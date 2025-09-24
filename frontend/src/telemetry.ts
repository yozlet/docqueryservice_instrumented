

import { WebTracerProvider } from '@opentelemetry/sdk-trace-web';
import { BatchSpanProcessor } from '@opentelemetry/sdk-trace-base';
import { registerInstrumentations } from '@opentelemetry/instrumentation';
import { getWebAutoInstrumentations } from '@opentelemetry/auto-instrumentations-web';
import { resourceFromAttributes, detectResources } from '@opentelemetry/resources';
import { browserDetector } from '@opentelemetry/opentelemetry-browser-detector';
import { ATTR_SERVICE_NAME, ATTR_SERVICE_VERSION } from '@opentelemetry/semantic-conventions';
import { OTLPTraceExporter } from '@opentelemetry/exporter-trace-otlp-http';
import { ZoneContextManager } from '@opentelemetry/context-zone';

export function initTelemetry() {

  const collectorUrl = process.env.REACT_APP_OTEL_COLLECTOR_URL || 'http://localhost:4318/v1/traces';
  const ATTR_DEPLOYMENT_ENVIRONMENT = "deployment.environment";

  let resource = resourceFromAttributes({
    [ATTR_SERVICE_NAME]: 'docquery-frontend',
    [ATTR_SERVICE_VERSION]: '1.0.0',
    [ATTR_DEPLOYMENT_ENVIRONMENT]: process.env.NODE_ENV,
  });

  const detectedResources = detectResources({detectors: [browserDetector]});
  resource = resource.merge(detectedResources);

  const provider = new WebTracerProvider({
    resource,
    spanProcessors: [
      new BatchSpanProcessor(
        new OTLPTraceExporter({
          url: collectorUrl,
        }),
        {
          maxQueueSize: 100,
          maxExportBatchSize: 10,
          scheduledDelayMillis: 500,
          exportTimeoutMillis: 30000,
        }
      )
    ],
  });

  provider.register({
    contextManager: new ZoneContextManager(),
  })

  registerInstrumentations({
    tracerProvider: provider,
    instrumentations: [
      getWebAutoInstrumentations({
        '@opentelemetry/instrumentation-fetch': {
          propagateTraceHeaderCorsUrls: /.*/,
          clearTimingResources: true,
        },
      }),
    ],
  });

}