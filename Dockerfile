# Étape 1 : Dépendances
FROM node:20-alpine AS deps
WORKDIR /app
# Copie uniquement les fichiers de dépendances pour optimiser le cache
COPY package.json package-lock.json ./
# Installation propre des dépendances
RUN npm ci

# Étape 2 : Construction (Build)
FROM node:20-alpine AS builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .
# Construit le projet Next.js
RUN npm run build

# Étape 3 : Production (Runner)
FROM node:20-alpine AS runner
WORKDIR /app

ENV NODE_ENV production

# Création d'un utilisateur non-root pour la sécurité
RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs

# Copie du dossier public (images, favicon, etc.)
COPY --from=builder /app/public ./public

# Copie des fichiers de build optimisés (grâce au mode standalone)
# Note : Le dossier .next/standalone contient tout le nécessaire pour tourner sans node_modules complet
COPY --from=builder --chown=nextjs:nodejs /app/.next/standalone ./
COPY --from=builder --chown=nextjs:nodejs /app/.next/static ./.next/static

USER nextjs

EXPOSE 3000

ENV PORT 3000
ENV HOSTNAME "0.0.0.0"

CMD ["node", "server.js"]