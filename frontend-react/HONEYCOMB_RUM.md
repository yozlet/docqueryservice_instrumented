# Honeycomb RUM Instrumentation

This document describes the Real User Monitoring (RUM) implementation using the Honeycomb Web SDK for OpenTelemetry.

## Overview

The Document Query Service frontend includes comprehensive telemetry instrumentation that captures:

- **Page load performance** - Document load times, resource timings
- **User interactions** - Search queries, pagination, document views, button clicks
- **API call tracing** - Backend requests with response times and error tracking
- **Custom business events** - Document search metrics, user action patterns

## Architecture

### Core Components

1. **`src/telemetry/honeycomb.ts`** - Main telemetry setup and SDK initialization
2. **`src/App.tsx`** - Application-level initialization and page view tracking
3. **`src/components/DocumentSearch.tsx`** - Component-level user interaction tracking

### Instrumentation Types

- **Automatic Instrumentation**:
  - Document load events (`DocumentLoadInstrumentation`)
  - User interactions like clicks (`UserInteractionInstrumentation`)
  - Fetch/XHR API calls (`FetchInstrumentation`, `XMLHttpRequestInstrumentation`)

- **Custom Instrumentation**:
  - Document search operations with performance metrics
  - User action tracking (search, pagination, document views)
  - API error tracking with detailed error context
  - Business event tracking for analytics

## Configuration

### Environment Variables

Set these environment variables to enable Honeycomb RUM:

```bash
# Required - Get from Honeycomb.io account
VITE_HONEYCOMB_API_KEY=your_honeycomb_api_key_here

# Optional - defaults to 'docquery-frontend'
VITE_HONEYCOMB_DATASET=docquery-frontend

# Enable metrics collection (set to 'true' to activate)
VITE_ENABLE_METRICS=true

# Environment name for span attributes
VITE_ENVIRONMENT=development|staging|production
```

### Development Setup

For local development, update `deployment/local-dev.env`:

```bash
# Enable RUM instrumentation
VITE_ENABLE_METRICS=true
VITE_HONEYCOMB_API_KEY=your_api_key
VITE_HONEYCOMB_DATASET=docquery-frontend
```

### Production Configuration

For production deployments, configure environment-specific variables:

```bash
# Production environment
VITE_ENVIRONMENT=production
VITE_ENABLE_METRICS=true
VITE_HONEYCOMB_API_KEY=prod_api_key
VITE_HONEYCOMB_DATASET=docquery-frontend-prod
```

## Tracked Events & Metrics

### 1. Page Load Performance

- **Event**: `page_view`
- **Attributes**:
  - `page`: Page name (e.g., 'app_home')
  - `user_agent`: Browser user agent
  - `screen_resolution`: Display resolution
  - `language`: Browser language
  - `url`: Current URL
  - `referrer`: Referring page

### 2. Document Search Operations

- **Event**: `document_search`
- **Attributes**:
  - `query`: Search terms (or '(empty)')
  - `result_count`: Total matching documents
  - `response_time_ms`: API response time
  - `has_query`: Boolean indicating if query was provided

- **Custom Span**: `document_search_operation`
- **Span Attributes**:
  - `search.query`: Search terms
  - `search.page`: Current page number
  - `search.page_size`: Results per page
  - `search.success`: Whether search succeeded
  - `search.error`: Error message if failed
  - `search.response_time_ms`: API response time

### 3. User Interactions

#### Search Actions
- **Event**: `user_action` with `action=search`
- **Attributes**:
  - `target`: 'search_input'
  - `query`: Search terms
  - `query_length`: Character count
  - `has_previous_results`: Boolean

#### Pagination
- **Event**: `user_action` with `action=paginate`
- **Attributes**:
  - `target`: 'pagination_control'
  - `from_page`: Previous page number
  - `to_page`: Target page number
  - `total_results`: Total result count

#### Document Views
- **Event**: `user_action` with `action=view_document`
- **Attributes**:
  - `target`: 'document_link'
  - `document_id`: Document identifier
  - `document_title`: Document title
  - `result_position`: Position in search results (1-based)
  - `page`: Current result page

### 4. API Error Tracking

- **Event**: `api_error`
- **Attributes**:
  - `endpoint`: API endpoint (e.g., '/wds')
  - `method`: HTTP method ('GET', 'POST', etc.)
  - `status_code`: HTTP status code
  - `error_message`: Error description
  - `timestamp`: Error occurrence time

## Usage Examples

### Custom Event Tracking

```typescript
import { trackEvent, trackUserAction } from '../telemetry/honeycomb'

// Track custom business event
trackEvent('feature_usage', {
  feature: 'advanced_search',
  user_type: 'authenticated',
  filters_used: ['date', 'country']
})

// Track specific user action
trackUserAction('export', 'download_button', {
  format: 'pdf',
  document_count: 5,
  search_query: 'renewable energy'
})
```

### Custom Span Creation

```typescript
import { createCustomSpan } from '../telemetry/honeycomb'

const processResults = async () => {
  const span = createCustomSpan('process_search_results', {
    'operation.type': 'data_processing',
    'results.count': results.length
  })

  try {
    // Processing logic here
    span?.setAttributes({
      'operation.success': true,
      'processed.items': processedCount
    })
  } catch (error) {
    span?.setAttributes({
      'operation.success': false,
      'error.message': error.message
    })
  } finally {
    span?.end()
  }
}
```

## Honeycomb Dashboard Queries

### Key Performance Queries

1. **Average Search Response Time**:
   ```
   BREAKDOWN BY search.query
   | AVG(search.response_time_ms)
   | WHERE event.name = "document_search"
   ```

2. **User Search Patterns**:
   ```
   COUNT
   | WHERE action = "search"
   | BREAKDOWN BY query
   | ORDER BY COUNT DESC
   ```

3. **Error Rate by Endpoint**:
   ```
   COUNT
   | WHERE event.name = "api_error"
   | BREAKDOWN BY endpoint, status_code
   ```

4. **Page Load Performance**:
   ```
   HEATMAP(duration)
   | WHERE name = "documentLoaded"
   ```

## Troubleshooting

### Telemetry Not Working

1. **Check Environment Variables**:
   ```bash
   # Verify configuration
   echo $VITE_HONEYCOMB_API_KEY
   echo $VITE_ENABLE_METRICS
   ```

2. **Check Browser Console**:
   - Look for "Honeycomb RUM instrumentation initialized successfully"
   - Check for any initialization errors

3. **Verify API Key**:
   - Confirm API key is valid in Honeycomb.io dashboard
   - Check dataset permissions

### Performance Considerations

- **Development**: Full sampling (all events tracked)
- **Production**: Consider sampling rates to manage volume
- **Custom Events**: Use sparingly to avoid overwhelming telemetry

### Common Issues

1. **CORS Errors**: Ensure `propagateTraceHeaderCorsUrls` includes your backend domains
2. **Missing Events**: Verify `VITE_ENABLE_METRICS=true` is set
3. **Build Errors**: Check all imports are correct and packages are installed

## Integration with Backend Tracing

The RUM instrumentation is configured to propagate trace headers to backend services:

- **Development**: Traces propagate to `localhost` backends
- **Production**: Configure regex patterns for production API domains
- **Distributed Tracing**: End-to-end traces from browser through backend services

## Security Notes

- **API Keys**: Never commit API keys to version control
- **Environment Variables**: Use secure secrets management in production
- **Data Privacy**: Be mindful of PII in custom event attributes
- **GDPR Compliance**: Consider user consent for telemetry collection

## Package Dependencies

```json
{
  "@honeycombio/opentelemetry-web": "1.0.2",
  "@opentelemetry/api": "1.9.0",
  "@opentelemetry/instrumentation-document-load": "0.50.0",
  "@opentelemetry/instrumentation-fetch": "0.205.0",
  "@opentelemetry/instrumentation-user-interaction": "0.50.0",
  "@opentelemetry/instrumentation-xml-http-request": "0.205.0",
  "@opentelemetry/sdk-trace-web": "2.1.0"
}
```

All packages follow the 3-day minimum age security policy defined in `.yarnrc.yml` for supply chain attack protection.