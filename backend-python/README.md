# Document Summarization Service

This service provides API endpoints for searching and summarizing documents using various LLM models through LangChain. It integrates with the existing document query service infrastructure and provides RESTful endpoints for document operations.

## Features

- RESTful API endpoints for document search and summarization
- Multi-model support for document summarization:
  - OpenAI models (GPT-3.5 Turbo, GPT-4 Turbo)
  - Anthropic models (Claude 3 Sonnet, Claude 3 Opus)
- Flexible model selection per request
- PostgreSQL-based document search with configurable result limits
- Compatible with existing document model
- OpenTelemetry instrumentation for observability
- Docker support for easy deployment

## Prerequisites

- Python 3.9+
- API Keys (at least one required):
  - OpenAI API key (for GPT-3.5 and GPT-4 models)
  - Anthropic API key (for Claude models)
- PostgreSQL database
- Docker and docker-compose (for containerized deployment)

## Configuration

The service can be configured using environment variables:

```bash
# API Configuration
LISTEN_HOST=0.0.0.0
LISTEN_PORT=5002

# LLM Configuration (at least one API key required)
OPENAI_API_KEY=your_openai_api_key_here      # Required for GPT models
ANTHROPIC_API_KEY=your_anthropic_api_key_here # Required for Claude models

# Database Configuration
DATABASE_URL=postgresql://user:password@localhost:5432/dbname

# OpenTelemetry Configuration
OTEL_EXPORTER_OTLP_ENDPOINT=http://localhost:4317
OTEL_SERVICE_NAME=docquery-summarizer

# Honeycomb Configuration
HONEYCOMB_API_KEY=your_honeycomb_api_key_here
HONEYCOMB_DATASET=docquery-summarizer
```

## Local Development

1. Create a virtual environment:
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```

2. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

3. Set up environment variables:
   ```bash
   # Copy the template and edit with your values
   cp local-dev.env.template local-dev.env
   
   # Required: At least one of these API keys
   export OPENAI_API_KEY=your_openai_api_key_here
   export ANTHROPIC_API_KEY=your_anthropic_api_key_here
   
   # Required: Database connection
   export DATABASE_URL=postgresql://user:password@localhost:5432/dbname
   
   # Optional: Telemetry configuration
   export OTEL_EXPORTER_OTLP_ENDPOINT=http://localhost:4317
   export HONEYCOMB_API_KEY=your_honeycomb_api_key_here
   ```

4. Run the service:
   ```bash
   uvicorn app.main:app --host 0.0.0.0 --port 5002 --reload
   ```

## Docker Deployment

1. Build the Docker image:
   ```bash
   docker-compose build summarizer
   ```

2. Run the service:
   ```bash
   docker-compose up summarizer
   ```

## API Usage

### Search Documents

```http
POST /api/search
Content-Type: application/json

{
  "title": "Sample Document",
  "document_type": "Report",
  "language": "en",
  "max_results": 5
}
```

Response:
```json
{
  "total_results": 10,
  "documents": [
    {
      "id": "doc123",
      "title": "Sample Document",
      "abstract": "Document abstract...",
      "document_type": "Report",
      "language": "en"
      // ... other document fields
    }
    // ... more documents up to max_results
  ]
}
```

### Summarize Document

```http
POST /api/summarize
Content-Type: application/json

{
  "id": "doc123",
  "title": "Sample Document",
  "abstract": "Original abstract...",
  "content": "Full document content to summarize...",
  "model": "gpt-3.5-turbo-16k"  // Optional, defaults to GPT-3.5 Turbo
}
```

Response:
```json
{
  "id": "doc123",
  "summary": "Generated summary of the document..."
}
```

#### Available Models

The following models are supported for document summarization:

- `gpt-3.5-turbo-16k` (default) - OpenAI GPT-3.5 Turbo
- `gpt-4-turbo-preview` - OpenAI GPT-4 Turbo
- `claude-3-sonnet` - Anthropic Claude 3 Sonnet
- `claude-3-opus` - Anthropic Claude 3 Opus

Note: Make sure you have the appropriate API key configured for the model you want to use.

## Monitoring and Observability

The service is instrumented with OpenTelemetry and can send telemetry data to Honeycomb or any other OpenTelemetry collector. Configure the appropriate environment variables to enable telemetry collection.
