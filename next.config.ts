import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  output: "standalone", // <--- Ajoute cette ligne impérativement
};

export default nextConfig;