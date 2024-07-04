import { defineConfig, loadEnv } from "vite";
import tailwindcss from "tailwindcss";
import autoprefixer from "autoprefixer";

export default defineConfig(({ command, mode }) => {
  const env = loadEnv(mode, process.cwd(), "");

  return {
    publicDir: false,
    build: {
      outDir: "../priv/static",
      emptyOutDir: false,
      target: ["es2020"],
      manifest: false,
      rollupOptions: {
        input: "js/app.js",
        output: {
          assetFileNames: "assets/[name][extname]",
          chunkFileNames: "[name].js",
          entryFileNames: "assets/[name].js",
        },
      },
      commonjsOptions: {
        exclude: [],
        include: ["vendor/topbar.js"],
      },
    },
    css: {
      postcss: {
        plugins: [tailwindcss, autoprefixer],
      },
    },
    define: {
      __APP_ENV__: env.APP_ENV,
    },
  };
});
