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

### .NET Backend
```bash
# Setup
mise activate  # Activate mise environment with .NET SDK

# Build and run
cd backend-dotnet
dotnet build
dotnet run

# The API will be available at:
# - http://localhost:5000/api/v3/wds (API endpoints)
# - http://localhost:5000 (Swagger UI documentation)
```

### React Frontend
```bash
# Setup
mise activate  # Activate mise environment with Node.js 20 and Yarn 4

# Build and run
cd frontend-react
yarn install    # Uses security-hardened Yarn configuration
yarn dev        # Development server on http://localhost:5173

# Production build
yarn build
yarn preview    # Preview production build
```

### Testing
```bash
# Run contract tests against .NET backend
cd tests
./run_contract_tests.sh --url http://localhost:5000/api/v3

# Run specific test suites
./run_contract_tests.sh --url http://localhost:5000/api/v3 --suite behavioral  # 21/23 passing ✅
./run_contract_tests.sh --url http://localhost:5000/api/v3 --suite openapi    # 21/22 passing ✅
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

**Infrastructure:**
- ✅ **SQL Server Database** with real World Bank document data
- ✅ **Contract Testing Suite** with comprehensive API validation
- ✅ **Development Environment** with mise tooling

### 🚧 In Progress/Planned
- ⏳ **Java Backend** - Spring Boot implementation (planned)
- ⏳ **React Frontend** - Document query interface (planned)
- ⏳ **Deployment Configurations** - Azure + multi-cloud setup (planned)

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