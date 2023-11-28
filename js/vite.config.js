import path from 'path';
import react from '@vitejs/plugin-react';
import { defineConfig } from 'vite';

export default defineConfig({
  plugins: [react()],
  resolve: {
    alias: {
      '@': path.resolve(__dirname, './src'),
    },
  },
  server: {
    watch: {
      usePolling: true,
    },
  },
  define: {
    'import.meta.env.VITE_REACT_APP_FIREBASE_API_KEY': process.env.VITE_REACT_APP_FIREBASE_API_KEY,
    'import.meta.env.VITE_REACT_APP_FIREBASE_DOMAIN': process.env.VITE_REACT_APP_FIREBASE_DOMAIN,
    'import.meta.env.VITE_REACT_APP_FIREBASE_PROJECT_ID': process.env.VITE_REACT_APP_FIREBASE_PROJECT_ID,
    'import.meta.env.VITE_REACT_APP_FIREBASE_BUCKET': process.env.VITE_REACT_APP_FIREBASE_BUCKET,
    'import.meta.env.VITE_REACT_APP_FIREBASE_SENDER_ID': process.env.VITE_REACT_APP_FIREBASE_SENDER_ID,
    'import.meta.env.VITE_REACT_APP_FIREBASE_APP_ID': process.env.VITE_REACT_APP_FIREBASE_APP_ID,
    'import.meta.env.VITE_REACT_APP_FIREBASE_MEASUREMENT_ID': process.env.VITE_REACT_APP_FIREBASE_MEASUREMENT_ID,
  },
});
