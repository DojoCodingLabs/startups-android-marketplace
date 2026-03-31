import type { Config } from "tailwindcss";

export default {
  content: ["./index.html", "./src/**/*.{ts,tsx}"],
  theme: {
    extend: {
      colors: {
        primary: "var(--color-brand-primary)",
        secondary: "var(--color-brand-secondary)",
        accent: "var(--color-brand-accent)",
        warning: "var(--color-brand-warning)",
        error: "var(--color-brand-error)",
        success: "var(--color-brand-success)",
      },
      fontFamily: {
        primary: ["Space Grotesk", "sans-serif"],
        header: ["Outfit", "sans-serif"],
        tertiary: ["Inter", "sans-serif"],
      },
      transitionDuration: {
        short: "var(--motion-duration-short)",
        medium: "var(--motion-duration-medium)",
        long: "var(--motion-duration-long)",
      },
    },
  },
  plugins: [],
} satisfies Config;
