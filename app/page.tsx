import Image from "next/image";

export default function Home() {
  return (
    <div className="flex min-h-screen items-center justify-center bg-zinc-50 font-sans dark:bg-black transition-colors duration-300">
      <main className="flex w-full max-w-3xl flex-col items-center justify-center gap-8 px-4 text-center">
        
        {/* Logo avec animation de flottement (animate-float) */}
        <div className="animate-float relative overflow-hidden rounded-full shadow-2xl shadow-zinc-300 dark:shadow-zinc-900 dark:border-zinc-800">
          <Image
            src="/logo.png" // Assure-toi que l'image est bien dans public/logo.png pour l'affichage page
            alt="Logo Gwongzho Empire"
            width={150}
            height={150}
            className="object-cover"
            priority
          />
        </div>

        {/* Contenu Texte avec animation d'apparition (animate-fade-in) */}
        <div className="animate-fade-in delay-200 flex flex-col items-center gap-4">
          <h1 className="text-4xl font-bold tracking-tight text-black dark:text-white sm:text-6xl drop-shadow-sm">
            Gwongzho Empire
          </h1>
          
          <p className="max-w-md text-lg leading-relaxed text-zinc-600 dark:text-zinc-400">
            Bienvenue sur notre plateforme officielle. <br />
            Nous construisons quelque chose d'exceptionnel.
          </p>
        </div>

        {/* Bouton */}
        <div className="animate-fade-in mt-4" style={{ animationDelay: '0.4s' }}>
          <a
            href="mailto:contact@gwongzho.com"
            className="inline-block rounded-full bg-zinc-900 px-8 py-3 text-sm font-medium text-white transition hover:scale-105 hover:bg-zinc-700 dark:bg-white dark:text-black dark:hover:bg-zinc-200"
          >
            En savoir plus
          </a>
        </div>
        
      </main>
    </div>
  );
}