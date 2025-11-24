# Stage 1: Dependencies
FROM node:20-alpine AS deps
WORKDIR /app
# Installation de libc6-compat nécessaire pour certaines libs sur Alpine
RUN apk add --no-cache libc6-compat
COPY package.json package-lock.json ./
RUN npm ci

# Stage 2: Builder
FROM node:20-alpine AS builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .


# Désactive la télémétrie Next.js pendant le build
ENV NEXT_TELEMETRY_DISABLED=1

RUN npm run build

# Stage 3: Runner
FROM node:20-alpine AS runner
WORKDIR /app

ENV NODE_ENV=production
ENV NEXT_TELEMETRY_DISABLED=1

RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs

# Copie des fichiers nécessaires seulement
COPY --from=builder /app/public ./public

USER nextjs

EXPOSE 3000

ENV PORT=3000
# Le hostname doit être 0.0.0.0 pour Docker
ENV HOSTNAME="0.0.0.0"

CMD ["node", "server.js"]