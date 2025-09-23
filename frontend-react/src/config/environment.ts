// Environment configuration for Document Query Service Frontend

export interface AppConfig {
  apiBaseUrl: string
  environment: string
  enableMetrics: boolean
  honeycombApiKey?: string
  honeycombDataset?: string
}


// Default configuration for different environments
const getDefaultConfig = (env: string): AppConfig => {
  switch (env) {
    case 'production':
      return {
        apiBaseUrl: '/api/v3', // Use nginx proxy in production
        environment: 'production',
        enableMetrics: true
      }
    case 'staging':
      return {
        apiBaseUrl: '/api/v3', // Use nginx proxy in staging
        environment: 'staging',
        enableMetrics: true
      }
    case 'development':
    default:
      return {
        apiBaseUrl: 'http://localhost:5001/api/v3', // Direct backend in development
        environment: 'development',
        enableMetrics: false
      }
  }
}

// Load configuration from environment variables
export const loadConfig = (): AppConfig => {
  const environment = import.meta.env.VITE_ENVIRONMENT || 'development'
  const defaultConfig = getDefaultConfig(environment)

  return {
    apiBaseUrl: import.meta.env.VITE_API_BASE_URL || defaultConfig.apiBaseUrl,
    environment,
    enableMetrics: import.meta.env.VITE_ENABLE_METRICS === 'true' || defaultConfig.enableMetrics,
    honeycombApiKey: import.meta.env.VITE_HONEYCOMB_API_KEY,
    honeycombDataset: import.meta.env.VITE_HONEYCOMB_DATASET || 'docquery-frontend'
  }
}

// Global configuration instance
export const config = loadConfig()

// Helper for logging configuration (without sensitive data)
export const getConfigSummary = () => ({
  environment: config.environment,
  apiBaseUrl: config.apiBaseUrl,
  enableMetrics: config.enableMetrics,
  hasHoneycombKey: !!config.honeycombApiKey
})

// Validate configuration
export const validateConfig = (): string[] => {
  const errors: string[] = []

  if (!config.apiBaseUrl) {
    errors.push('API_BASE_URL is required')
  }

  if (config.enableMetrics && !config.honeycombApiKey) {
    errors.push('HONEYCOMB_API_KEY is required when metrics are enabled')
  }

  return errors
}