# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Goals and Requirements

**IMPORTANT**: Always reference `docs/GOALS.md` for the complete project goals and architecture. Keep that file updated with any architectural decisions made during implementation.

**DOCUMENTATION MAINTENANCE**: When creating new documentation files (guides, README files, configuration docs, etc.), **always update this CLAUDE.md file** to reference the new documentation. This ensures future Claude Code sessions can discover and utilize all available documentation.

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

### Automated Database Initialization

The `deployment/dev.sh` script automatically handles database setup for new developers:

1. **Creates DocQueryService database** if it doesn't exist
2. **Creates documents table** with proper schema
3. **Loads sample data** from World Bank API scraper
4. **Handles dependencies** (installs pymssql if needed)
5. **Provides fallback instructions** if automatic setup fails

The initialization runs automatically when you start the development environment:
```bash
cd deployment
./dev.sh start --auto  # Includes automatic database setup
```

### Manual Database Setup

If automatic initialization fails, use these manual steps:
```bash
# 1. Setup database and schema
cd scripts
python3 database.py

# 2. Load sample data
python3 worldbank_scraper.py --count 25 --database

# 3. Verify setup
curl "http://localhost:5001/api/v3/wds?format=json&rows=5"
```

## Data Population

Use the World Bank API scraper to populate the database with real document data:
- **[scripts/worldbank_scraper.py](scripts/worldbank_scraper.py)** - Python scraper that fetches real World Bank documents and generates SQL INSERT statements
- **[scripts/database.py](scripts/database.py)** - Database setup and connection utilities
- **[scripts/README.md](scripts/README.md)** - Complete usage documentation for the scraper

The scraper supports both direct database insertion and SQL file generation:
```bash
cd scripts
pip3 install -r requirements.txt

# Direct database insertion (preferred)
python3 worldbank_scraper.py --count 100 --database

# Generate SQL file (fallback)
python3 worldbank_scraper.py --count 100 --output data.sql
```

## Development Environment

### **🚀 Quick Start (Recommended)**

Use the unified development environment for the easiest local development:

```bash
cd deployment

# Quick start - automatically start database, backend, and frontend
./dev.sh start --auto --verbose

# Check status of all services
./dev.sh status

# Stop all services cleanly
./dev.sh stop
```

**Service URLs:**
- **Frontend**: http://localhost:5173 (React app with document search)
- **Backend API**: http://localhost:5001 (REST API + Swagger UI)
- **Database**: localhost:1433 (Azure SQL Edge container)

**📖 Complete Documentation:** [`deployment/UNIFIED-DEV-GUIDE.md`](deployment/UNIFIED-DEV-GUIDE.md)

### **Manual Development Commands**

#### Prerequisites
```bash
# Install required tool versions (.NET SDK, Node.js, Yarn)
mise install
```

#### .NET Backend
```bash
# Setup and run
mise activate
cd backend-dotnet
dotnet build
dotnet run

# API available at:
# - http://localhost:5001/api/v3/wds (API endpoints)
# - http://localhost:5001 (Swagger UI documentation)
```

#### React Frontend
```bash
# Setup and run
mise activate
cd frontend-react
yarn install    # Uses security-hardened Yarn configuration
yarn dev        # Development server on http://localhost:5173

# Production build
yarn build
yarn preview    # Preview production build
```

#### Testing
```bash
# Run contract tests against .NET backend
cd tests
./run_contract_tests.sh --url http://localhost:5001/api/v3

# Run specific test suites
./run_contract_tests.sh --url http://localhost:5001/api/v3 --suite behavioral  # 21/23 passing ✅
./run_contract_tests.sh --url http://localhost:5001/api/v3 --suite openapi    # 21/22 passing ✅
```

## Observability Requirements

All components must demonstrate:
- Distributed tracing across services
- Custom metrics collection
- Structured logging
- Real user monitoring (frontend)
- Infrastructure monitoring
- Alert configuration and incident response workflows

## API Contract Testing

Ensure both .NET and Java implementations maintain perfect API parity using our dual testing approach:

### **Test Suites**
- **[tests/test_api_contract.py](tests/test_api_contract.py)** - Behavioral contract tests (consistency, data quality, business logic)
- **[tests/test_openapi_contract.py](tests/test_openapi_contract.py)** - OpenAPI spec-driven tests (schema validation, parameter compliance)
- **[tests/run_contract_tests.sh](tests/run_contract_tests.sh)** - Unified test runner for both suites
- **[docs/openapi.yaml](docs/openapi.yaml)** - Complete OpenAPI specification (single source of truth)

### **Usage Examples**
```bash
cd tests

# Run comprehensive testing (both behavioral + OpenAPI compliance)
./run_contract_tests.sh --url http://localhost:5000/v3

# Test only OpenAPI specification compliance
./run_contract_tests.sh --url http://localhost:8080/v3 --suite openapi

# Test only behavioral/business logic compliance
./run_contract_tests.sh --url http://localhost:8080/v3 --suite behavioral

# Test specific behavioral categories
./run_contract_tests.sh --suite behavioral --category consistency,quality
```

### **Why Two Test Suites?**
- **OpenAPI Tests**: Ensure structural/schema compliance with the specification
- **Behavioral Tests**: Ensure runtime behavior, data quality, and business logic correctness
- **Combined**: Comprehensive validation that catches both spec violations and implementation bugs

## Implementation Status

### ✅ Completed Components

**Frontend Application:**
- ✅ **React Frontend** (`frontend-react/`) - Modern React application with comprehensive features
  - **Search Interface**: Real-time document search with pagination and filtering
  - **Security-Hardened Dependencies**: 3-day minimum package age gate protection
  - **Production Deployment**: nginx configuration with security headers and performance optimization
  - **Docker Support**: Multi-stage containerization with non-root user security
  - **Multiple Deployment Options**: Development mode, Docker, Docker Compose, static build
  - **API Integration**: Full backend integration with error handling and loading states
  - **📖 Deployment Guide**: [`frontend-react/README.md`](frontend-react/README.md)

**Backend APIs:**
- ✅ **.NET Backend** (`backend-dotnet/`) - Complete ASP.NET Core Web API
  - World Bank API compatible endpoints (`/api/v3/wds`)
  - SQL Server integration with Dapper ORM
  - OpenTelemetry distributed tracing and metrics
  - Docker containerization support
  - Swagger/OpenAPI documentation
  - **Contract Compliance**: 42/45 tests passing (93% compliance)
    - Behavioral tests: 21/23 passing (91%)
    - OpenAPI tests: 21/22 passing (95%)
  - **📖 Backend Guide**: [`backend-dotnet/README.md`](backend-dotnet/README.md)

**Observability & Telemetry:**
- ✅ **Complete End-to-End OpenTelemetry Instrumentation** - Full distributed tracing from frontend to backend
  - **Frontend RUM**: Honeycomb Web SDK captures page loads, user interactions, API calls with trace propagation
  - **Backend Telemetry**: .NET OpenTelemetry with ASP.NET Core, SQL Client, and custom business logic instrumentation
  - **Unified Datasets**: `docquery-frontend` and `docquery-backend` in Honeycomb for correlated analysis
  - **Custom Business Events**: Document searches, user actions, API errors, database operations
  - **Error Tracking**: Full exception traces with distributed context propagation
  - **Performance Monitoring**: End-to-end request tracking, database query performance, search response times
  - **📖 RUM Documentation**: [`frontend-react/HONEYCOMB_RUM.md`](frontend-react/HONEYCOMB_RUM.md)
  - **📖 Environment Template**: [`deployment/local-dev.env.template`](deployment/local-dev.env.template)

**Infrastructure & Development:**
- ✅ **SQL Server Database** with real World Bank document data
- ✅ **Contract Testing Suite** with comprehensive API validation
- ✅ **Unified Development Environment** with hybrid local setup
- ✅ **Security-Hardened Package Management** with supply chain attack protection
- ✅ **Comprehensive Documentation** with deployment guides and troubleshooting
- ✅ **📖 Development Guide**: [`deployment/UNIFIED-DEV-GUIDE.md`](deployment/UNIFIED-DEV-GUIDE.md)

### 🚧 In Progress/Planned
- ⏳ **Java Backend** - Spring Boot implementation with identical .NET functionality
- ⏳ **Multi-Cloud Deployment** - Azure + AWS/GCP hybrid architecture
- ⏳ **Infrastructure Monitoring** - Server metrics, database performance
- ⏳ **Synthetic Monitoring** - Uptime checks, API health monitoring

## 🔒 Security Requirements

**CRITICAL**: This project implements strict npm/yarn security measures to prevent supply chain attacks. All development must follow these security directives based on [npm-security-best-practices](https://github.com/bodadotsh/npm-security-best-practices):

### Mandatory Frontend Security Settings

**Yarn Configuration** (`frontend-react/.yarnrc.yml`):
```yaml
enableScripts: false                # NEVER enable scripts during install
npmMinimalAgeGate: 4320            # Minimum 3 days (production: 7 days / 10080 minutes)
defaultSemverRangePrefix: ""       # Always use exact versions
enableStrictSsl: true              # Enforce SSL certificate validation
nodeLinker: node-modules           # Use node-modules for security visibility
```

**Security Validation Commands**:
```bash
# Required before any dependency changes
cd frontend-react
yarn npm audit                     # Check for vulnerabilities
yarn outdated                      # Review package ages
yarn install --check-resolutions   # Verify lockfile integrity
```

**Security Violations to NEVER Allow**:
- ❌ Enabling `enableScripts: true`
- ❌ Reducing `npmMinimalAgeGate` below 4320 (3 days)
- ❌ Using semver ranges instead of exact versions
- ❌ Installing packages without age gate validation
- ❌ Ignoring audit warnings without investigation

**Production Security Hardening**:
- Increase `npmMinimalAgeGate: 10080` (7 days) for production
- Use private npm registry for internal packages
- Enable package-lock auditing in CI/CD
- Regular security dependency updates with proper testing

### Why These Measures Matter
- **Supply Chain Attacks**: Recent attacks like `node-ipc`, `ua-parser-js` compromised fresh packages
- **Script Execution**: Malicious packages often use install scripts to compromise systems  
- **Dependency Confusion**: Exact versions prevent typo-squatting attacks
- **Age Gate Protection**: Minimum release age allows community discovery of malicious packages

## Notes

- Keep `docs/GOALS.md` synchronized with architectural decisions
- Prioritize OpenTelemetry integration from the start
- Design for hybrid cloud deployment scenarios
- Plan for comprehensive observability demo use cases listed in GOALS.md
- **NEVER compromise on frontend security settings** - they protect against supply chain attacks