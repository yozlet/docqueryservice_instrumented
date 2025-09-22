# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Goals and Requirements

**IMPORTANT**: Always reference `docs/GOALS.md` for the complete project goals and architecture. Keep that file updated with any architectural decisions made during implementation.

This is an **observability solution demo** project that builds a hybrid full-stack application to demonstrate comprehensive monitoring capabilities using OpenTelemetry and Honeycomb.io.

## Architecture Overview

### Core Components
- **Frontend**: React app with RUM instrumentation (deployed on non-Azure cloud)
- **Dual Backend APIs**: 
  - .NET service (deployed to Azure App Services)
  - Java service (deployed on non-Azure cloud)
- **Shared Database**: Azure SQL/PostgreSQL in Azure
- **Observability Platform**: Honeycomb.io with OpenTelemetry collectors

### Document Query Service
Both backend APIs implement the same document query functionality modeled after the World Bank's Document & Reports API (see [docs/WORLDBANK_API.md](docs/WORLDBANK_API.md) for complete specification). The frontend provides query building and result navigation with the option to switch between backend services.

## Key Development Principles

1. **OpenTelemetry First**: All components must include comprehensive instrumentation (metrics, logs, traces)
2. **Hybrid Deployment**: Services span multiple cloud providers to demonstrate cross-platform observability
3. **API Parity**: Both .NET and Java services implement identical functionality
4. **Unified Build**: Single script builds and manages all services locally

## Database Schema

The project uses a SQL database with the schema defined in:
- **[docs/schema.sql](docs/schema.sql)** - Complete database schema
- **[docs/sample_data.sql](docs/sample_data.sql)** - Sample data for development

## Data Population

Use the World Bank API scraper to populate the database with real document data:
- **[scripts/worldbank_scraper.py](scripts/worldbank_scraper.py)** - Python scraper that fetches real World Bank documents and generates SQL INSERT statements
- **[scripts/README.md](scripts/README.md)** - Complete usage documentation for the scraper

Example usage:
```bash
cd scripts
pip3 install -r requirements.txt
python3 worldbank_scraper.py --count 100 --output data.sql
psql -d database_name -f data.sql
```

## Development Commands

*Commands will be added once the build system is implemented*

## Observability Requirements

All components must demonstrate:
- Distributed tracing across services
- Custom metrics collection
- Structured logging
- Real user monitoring (frontend)
- Infrastructure monitoring
- Alert configuration and incident response workflows

## Implementation Status

Currently in initial setup phase. The project structure and build system need to be established before implementing the document query services and observability features.

## Notes

- Keep `docs/GOALS.md` synchronized with architectural decisions
- Prioritize OpenTelemetry integration from the start
- Design for hybrid cloud deployment scenarios
- Plan for comprehensive observability demo use cases listed in GOALS.md