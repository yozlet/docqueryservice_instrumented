

import { HoneycombWebSDK } from '@honeycombio/opentelemetry-web';
import { getWebAutoInstrumentations } from '@opentelemetry/auto-instrumentations-web';

const configDefaults = {
  ignoreNetworkEvents: true,
  propagateTraceHeaderCorsUrls: [
    /.+/g, // Regex to match your backend URLs. Update to the domains you wish to include.
  ]
}

var sdk: HoneycombWebSDK | null = null;

const endpoint = process.env.REACT_APP_BROWSER_OTEL_EXPORTER_OTLP_ENDPOINT;

export function initTelemetry() {
  if (sdk == null) {
    sdk = new HoneycombWebSDK({
      endpoint: endpoint,
      debug: true, // Set to false for production environment.
      serviceName: 'docassistant-frontend', // Replace with your application name. Honeycomb uses this string to find your dataset when we receive your data. When no matching dataset exists, we create a new one with this name if your API Key has the appropriate permissions.
      instrumentations: [getWebAutoInstrumentations({
        // Loads custom configuration for xml-http-request instrumentation.
        '@opentelemetry/instrumentation-xml-http-request': configDefaults,
        '@opentelemetry/instrumentation-fetch': configDefaults,
        '@opentelemetry/instrumentation-document-load': configDefaults,
      })],
    });
    sdk.start();
  }
}