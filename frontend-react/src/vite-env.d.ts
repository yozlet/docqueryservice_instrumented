/// <reference types="vite/client" />

interface ImportMetaEnv {
  readonly VITE_ENVIRONMENT: string
  readonly VITE_API_BASE_URL: string
  readonly VITE_ENABLE_METRICS: string
  readonly VITE_HONEYCOMB_API_KEY: string
  readonly VITE_HONEYCOMB_DATASET: string
}

interface ImportMeta {
  readonly env: ImportMetaEnv
}