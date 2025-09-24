// Honeycomb OpenTelemetry Web SDK instrumentation
// Real User Monitoring (RUM) setup for Document Query Service

import { HoneycombWebSDK } from '@honeycombio/opentelemetry-web'
import { DocumentLoadInstrumentation } from '@opentelemetry/instrumentation-document-load'
import { UserInteractionInstrumentation } from '@opentelemetry/instrumentation-user-interaction'
import { FetchInstrumentation } from '@opentelemetry/instrumentation-fetch'
import { XMLHttpRequestInstrumentation } from '@opentelemetry/instrumentation-xml-http-request'
import { trace } from '@opentelemetry/api'
import { config } from '../config/environment'

let sdk: HoneycombWebSDK | null = null

export interface TelemetryConfig {
  serviceName: string
  serviceVersion: string
  honeycombApiKey?: string
  honeycombDataset?: string
  environment: string
  debug?: boolean
}

// Initialize Honeycomb Web SDK for RUM instrumentation
export const initializeHoneycomb = (telemetryConfig: TelemetryConfig): boolean => {
  // Skip initialization if metrics are disabled or API key is missing
  if (!config.enableMetrics || !telemetryConfig.honeycombApiKey) {
    console.info('Honeycomb RUM instrumentation disabled:', {
      enableMetrics: config.enableMetrics,
      hasApiKey: !!telemetryConfig.honeycombApiKey
    })
    return false
  }

  try {
    // Configure Honeycomb Web SDK
    sdk = new HoneycombWebSDK({
      apiKey: telemetryConfig.honeycombApiKey,
      dataset: telemetryConfig.honeycombDataset || 'docquery-frontend',
      serviceName: telemetryConfig.serviceName,
      debug: telemetryConfig.debug || false,

      // Service attributes
      serviceVersion: telemetryConfig.serviceVersion,

      // Instrumentations for web applications
      instrumentations: [
        // Document load instrumentation
        new DocumentLoadInstrumentation(),
        // User interaction instrumentation (clicks, form submissions, etc.)
        new UserInteractionInstrumentation(),
        // Fetch instrumentation for API calls
        new FetchInstrumentation({
          propagateTraceHeaderCorsUrls: [
            /localhost/, // Allow trace propagation to localhost backends
            new RegExp(telemetryConfig.environment === 'production' ? 'api\\.' : 'localhost')
          ],
          clearTimingResources: true
        }),
        // XMLHttpRequest instrumentation
        new XMLHttpRequestInstrumentation({
          propagateTraceHeaderCorsUrls: [
            /localhost/,
            new RegExp(telemetryConfig.environment === 'production' ? 'api\\.' : 'localhost')
          ],
          clearTimingResources: true
        })
      ],

      // Custom span processors or exporters can be added here
      skipOptionsValidation: false
    })

    // Start the SDK
    sdk.start()

    console.info('Honeycomb RUM instrumentation initialized successfully', {
      serviceName: telemetryConfig.serviceName,
      environment: telemetryConfig.environment,
      dataset: telemetryConfig.honeycombDataset,
      debug: telemetryConfig.debug || false
    })

    return true
  } catch (error) {
    console.error('Failed to initialize Honeycomb RUM instrumentation:', error)
    return false
  }
}

// Shutdown telemetry (useful for cleanup)
export const shutdownTelemetry = async (): Promise<void> => {
  if (sdk) {
    try {
      await sdk.shutdown()
      console.info('Honeycomb RUM instrumentation shut down successfully')
    } catch (error) {
      console.error('Error shutting down Honeycomb RUM instrumentation:', error)
    } finally {
      sdk = null
    }
  }
}

// Helper to add custom attributes to the current span
export const addCustomAttribute = (key: string, value: string | number | boolean): void => {
  try {
    // Get active span and add attribute
    const activeSpan = trace.getActiveSpan()
    if (activeSpan) {
      activeSpan.setAttribute(key, value)
    }
  } catch (error) {
    console.warn('Failed to add custom attribute:', error)
  }
}

// Create custom spans for business logic tracking
export const createCustomSpan = (name: string, attributes: Record<string, string | number | boolean> = {}) => {
  try {
    const tracer = trace.getTracer('docquery-frontend')

    return tracer.startSpan(name, {
      attributes: {
        'span.kind': 'client',
        ...attributes
      }
    })
  } catch (error) {
    console.warn('Failed to create custom span:', error)
    return null
  }
}

// Track custom events (user actions, business events, etc.)
export const trackEvent = (eventName: string, properties: Record<string, any> = {}): void => {
  try {
    const span = createCustomSpan(`event.${eventName}`, {
      'event.name': eventName,
      ...Object.fromEntries(
        Object.entries(properties).map(([k, v]) => [`event.${k}`, v])
      )
    })

    if (span) {
      // End span immediately for event tracking
      span.end()
    }
  } catch (error) {
    console.warn('Failed to track event:', error)
  }
}

// Track page views
export const trackPageView = (pageName: string, additionalProperties: Record<string, any> = {}): void => {
  trackEvent('page_view', {
    page: pageName,
    url: window.location.href,
    referrer: document.referrer,
    ...additionalProperties
  })
}

// Track user interactions
export const trackUserAction = (action: string, target: string, additionalProperties: Record<string, any> = {}): void => {
  trackEvent('user_action', {
    action,
    target,
    timestamp: Date.now(),
    ...additionalProperties
  })
}

// Track search operations specifically for our document query service
export const trackDocumentSearch = (query: string, resultCount: number, responseTime: number): void => {
  trackEvent('document_search', {
    query: query || '(empty)',
    result_count: resultCount,
    response_time_ms: responseTime,
    has_query: !!query
  })
}

// Track API errors
export const trackApiError = (endpoint: string, method: string, status: number, error: string): void => {
  trackEvent('api_error', {
    endpoint,
    method,
    status_code: status,
    error_message: error,
    timestamp: Date.now()
  })
}

// Export the SDK instance for advanced usage if needed
export const getSDK = (): HoneycombWebSDK | null => sdk