import type { Config } from "tailwindcss";

const config: Config = {
  content: ["./src/**/*.{js,ts,jsx,tsx,mdx}"],
  theme: {
    extend: {
      colors: {
        ink: "#10233f",
        navy: "#102f56",
        sky: "#eaf4ff",
        mist: "#f5f8fc",
      },
      boxShadow: {
        soft: "0 18px 55px rgba(16, 47, 86, 0.09)",
      },
    },
  },
  plugins: [],
};
export default config;
