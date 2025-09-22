# World Bank Documents & Reports API Reference

This document describes the World Bank Documents & Reports API that serves as the model for our document query service implementations.

## Overview

The World Bank Documents & Reports API is a REST-style API that allows searching and retrieving public documents with flexible querying and response options. Our project implements the same API structure in both .NET and Java backend services.

**Base URL**: `https://search.worldbank.org/api/v3/wds`

## Key Features

- Search across multiple document fields
- Retrieve specific fields
- Support for JSON and XML formats
- Facet and filtering capabilities
- Pagination support
- Date range querying

## Basic Query Structure

```
https://search.worldbank.org/api/v3/wds?format=[json/xml]&[parameters]
```

## Query Parameters

### Core Parameters

| Parameter | Type | Description | Example |
|-----------|------|-------------|---------|
| `format` | string | Response format (json/xml) | `json`, `xml` |
| `qterm` | string | Full-text search across multiple fields | `wind turbine` |
| `fl` | string | Comma-separated list of fields to return | `docdt,count,title` |
| `rows` | integer | Number of results per page (default: 10, max: 100) | `25` |
| `os` | integer | Offset/starting record number for pagination | `20` |

### Filtering Parameters

| Parameter | Type | Description | Example |
|-----------|------|-------------|---------|
| `count_exact` | string | Exact match for country | `Algeria` |
| `lang_exact` | string | Exact match for language | `English` |
| `strdate` | date | Start date (YYYY-MM-DD format) | `2020-01-01` |
| `enddate` | date | End date (YYYY-MM-DD format) | `2023-12-31` |

### Advanced Parameters

| Parameter | Type | Description | Example |
|-----------|------|-------------|---------|
| `facet` | string | Request facet data | `on` |
| `facet.field` | string | Specific facet fields | `count,lang` |
| `sort` | string | Sort order | `docdt desc` |

## Common Response Fields

| Field | Description |
|-------|-------------|
| `id` | Unique document identifier |
| `docdt` | Document date |
| `count` | Country |
| `title` | Document title |
| `lang` | Language |
| `docty` | Document type |
| `majdocty` | Major document type |
| `volnb` | Volume number |
| `totvolnb` | Total volume number |
| `url` | Document URL |

## Example Queries

### Basic Search
```bash
curl "https://search.worldbank.org/api/v3/wds?format=json&qterm=wind%20turbine&fl=docdt,count,title"
```

### Country-Specific Search
```bash
curl "https://search.worldbank.org/api/v3/wds?format=xml&count_exact=Algeria&fl=count,volnb,totvolnb"
```

### Date Range Query
```bash
curl "https://search.worldbank.org/api/v3/wds?format=json&strdate=2020-01-01&enddate=2023-12-31&fl=docdt,title,count"
```

### Paginated Results
```bash
curl "https://search.worldbank.org/api/v3/wds?format=json&qterm=climate&rows=25&os=50&fl=title,docdt"
```

## Response Format

### JSON Response Structure
```json
{
  "documents": {
    "numFound": 1234,
    "start": 0,
    "docs": [
      {
        "id": "document_id",
        "title": "Document Title",
        "docdt": "2023-01-15T00:00:00Z",
        "count": "Country Name",
        "lang": "English"
      }
    ]
  }
}
```

### XML Response Structure
```xml
<response>
  <result name="documents" numFound="1234" start="0">
    <doc>
      <str name="id">document_id</str>
      <str name="title">Document Title</str>
      <date name="docdt">2023-01-15T00:00:00Z</date>
      <str name="count">Country Name</str>
      <str name="lang">English</str>
    </doc>
  </result>
</response>
```

## Implementation Notes for Our Services

1. **API Parity**: Both .NET and Java services must implement identical endpoint behavior
2. **Response Format**: Support both JSON and XML responses
3. **Parameter Validation**: Implement proper validation for all query parameters
4. **Pagination**: Handle pagination consistently across implementations
5. **Error Handling**: Return appropriate HTTP status codes and error messages
6. **OpenTelemetry**: Instrument all API calls for distributed tracing

## Related Documentation

- [Project Goals](GOALS.md) - Complete project requirements and use cases
- [Architecture Overview](../CLAUDE.md) - Development guidance and architecture

## External References

- [Official World Bank API Documentation](https://documents.worldbank.org/en/publication/documents-reports/api)
- [World Bank Open Data](https://data.worldbank.org/)