# Document Query Service

A comprehensive observability demonstration project featuring a multi-backend document search service modeled after the World Bank Documents & Reports API.

## 🎯 Project Overview

This project builds a complete observability solution demo with:
- **Multiple backend implementations** (.NET and Java) providing identical World Bank-style document APIs
- **Hybrid cloud architecture** spanning Azure and non-Azure deployments  
- **Full-stack observability** with OpenTelemetry instrumentation for metrics, logs, and traces
- **Real document data** from the World Bank API with SQL Server database storage
- **Production-ready database infrastructure** with Docker containerization

## 🏗️ Architecture

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   React Frontend │    │  .NET Backend   │    │  Java Backend   │
│   (Non-Azure)    │────│   (Azure)       │────│  (Non-Azure)    │
│   RUM Tracking   │    │   App Service   │    │   Cloud VM      │
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │                        │                        │
         └────────────────────────┼────────────────────────┘
                                  │
              ┌─────────────────────────────────────┐
              │        Azure SQL Database           │
              │     (Shared Document Store)         │
              └─────────────────────────────────────┘
                                  │
              ┌─────────────────────────────────────┐
              │         Honeycomb.io                │
              │    (Observability Platform)         │
              └─────────────────────────────────────┘
```

## 🚀 Quick Start

### Prerequisites
- **Docker** with Docker Compose
- **Python 3.9+**
- **Node.js 18+** (for future frontend development)
- **mise** tool manager (for .NET SDK management)
- **.NET 9.0 SDK** (managed via mise)

### 1. Database Setup

Start the SQL Server database and load sample documents:

```bash
# Clone the repository
git clone <repository-url>
cd docqueryservice_instrumented

# Start database and load sample data
cd scripts
./setup-database.sh
```

This will:
- 🐳 Start Azure SQL Edge in Docker (ARM64/Apple Silicon compatible)
- 📊 Initialize database schema with full-text search
- 📄 Load 500+ real World Bank documents
- ✅ Verify setup with connection tests

### 2. Test the Database

```bash
# Test database functionality
python3 database.py

# Search documents
python3 -c "
from database import DatabaseManager
db = DatabaseManager()
results = db.search_documents('renewable energy', limit=5)
for doc in results:
    print(f'• {doc[\"title\"][:60]}...')
"
```

### 3. Add More Documents

```bash
# Load documents by topic
python3 worldbank_scraper.py --query "climate change" --count 100 --database

# Load documents by country  
python3 worldbank_scraper.py --country "Brazil" --count 50 --database

# Load large dataset
python3 worldbank_scraper.py --count 2000 --database
```

### 4. Run the .NET Backend

```bash
# Setup .NET environment
mise activate

# Build and run the .NET API
cd backend-dotnet
dotnet build
dotnet run

# The API will be available at:
# - http://localhost:5000/api/v3/wds (World Bank API endpoints)
# - http://localhost:5000 (Interactive Swagger UI documentation)
```

### 5. Test the API

```bash
# Run comprehensive contract tests
cd tests
./run_contract_tests.sh --url http://localhost:5000/api/v3

# Test specific endpoints manually
curl "http://localhost:5000/api/v3/wds?rows=5"
curl "http://localhost:5000/api/v3/wds?qterm=energy&format=xml"
curl "http://localhost:5000/api/v3/wds/health"
```

## 📁 Project Structure

```
├── README.md                    # Main project documentation (this file)
├── docker-compose.yml           # SQL Server container configuration
├── scripts/                     # Database and data loading tools
│   ├── README.md               # Database setup documentation
│   ├── SCRAPER_README.md       # World Bank scraper documentation  
│   ├── database.py             # Database utilities (pymssql-based)
│   ├── worldbank_scraper.py    # World Bank API scraper
│   ├── setup-database.sh       # Automated database setup
│   └── sql/                    # SQL schema and scripts
├── backend-dotnet/             # .NET backend API implementation
│   ├── Controllers/            # ASP.NET Core API controllers
│   ├── Models/                 # Data models and DTOs
│   ├── Services/               # Business logic and data access
│   ├── Dockerfile              # Container configuration
│   └── README.md               # .NET backend documentation
├── tests/                      # Contract tests and API validation
├── docs/                       # Project documentation
│   ├── GOALS.md                # Observability demo objectives
│   ├── WORLDBANK_API.md        # API specification reference
│   └── openapi.yaml            # OpenAPI specification
└── [backend-java]              # Future: Java backend API implementation
```

## 🛠️ Current Status

### ✅ **Completed Components**

#### **Database Infrastructure**
- **Azure SQL Edge** container with ARM64 compatibility
- **Complete schema** with documents, countries, languages, types, authors, topics
- **Full-text search** capabilities with LIKE fallback
- **Database utilities** using pymssql for cross-platform reliability
- **Bulk data loading** with MERGE operations for efficient updates

#### **Data Pipeline** 
- **World Bank API scraper** with direct database insertion
- **Real document corpus** (500+ documents loaded from World Bank API)
- **Flexible filtering** by country, topic, date ranges, document types
- **Robust error handling** with retry logic and graceful failures

#### **Testing & Validation**
- **Contract tests** validating API specifications against real World Bank API
- **Database integration tests** verifying all operations
- **OpenAPI specification** defining the target API contract
- **Automated test suites** with pytest and comprehensive reporting

#### **Documentation**
- **Comprehensive setup guides** with troubleshooting
- **API documentation** based on World Bank specification  
- **Database schema documentation** with entity relationships
- **Cross-platform compatibility** notes (especially ARM64/Apple Silicon)

#### **Backend APIs**
- ✅ **.NET Backend API** (`backend-dotnet/`) - Complete ASP.NET Core Web API
  - World Bank API compatible endpoints (`GET /api/v3/wds`)
  - SQL Server integration with Dapper ORM and connection pooling
  - OpenTelemetry distributed tracing and runtime metrics instrumentation
  - XML and JSON format support with proper Content-Type headers
  - Docker containerization with multi-stage builds
  - Interactive Swagger/OpenAPI documentation at root path
  - **Contract Compliance**: 42/45 tests passing (93% overall compliance)
    - **Behavioral Tests**: 21/23 passing (91% compliance) ✅
    - **OpenAPI Tests**: 21/22 passing (95% compliance) ✅
  - Full error handling with structured logging and HTTP status codes
  - CORS configuration for cross-origin requests

### 🚧 **In Development**

- **Frontend React application** for document search and browsing
- **Java backend API** with identical functionality to .NET version
- **Deployment configurations** for Azure App Services and multi-cloud setup
- **Honeycomb.io integration** for unified observability platform

### 📋 **Planned Features**

- **Multi-backend deployment** (Azure App Service + cloud VMs)
- **Real User Monitoring (RUM)** instrumentation
- **Synthetic monitoring** and uptime checks
- **Business intelligence dashboards** correlating technical and business metrics
- **AI/ML anomaly detection** and automated remediation
- **ITSM integration** with ServiceNow

## 🔧 Development

### Database Operations

The database utilities support both direct connection and SQL file generation:

```bash
# Direct database insertion (recommended)
python3 worldbank_scraper.py --count 100 --database

# Generate SQL files for manual import
python3 worldbank_scraper.py --count 100 --output documents.sql
```

### Backend Development

```bash
# .NET Backend
mise activate                           # Activate .NET SDK environment
cd backend-dotnet
dotnet build                            # Build the project
dotnet run                              # Start the API server (http://localhost:5000)

# Available endpoints:
# - GET /api/v3/wds                     # Search documents with pagination
# - GET /api/v3/wds/{id}               # Get specific document by ID
# - GET /api/v3/wds/facets             # Get search facets for filtering
# - GET /api/v3/wds/health             # Health check endpoint
# - GET / (root)                       # Interactive Swagger UI documentation
```

### Testing

```bash
# Run comprehensive API contract tests against .NET backend
cd tests
./run_contract_tests.sh --url http://localhost:5000/api/v3

# Run specific test suites
./run_contract_tests.sh --url http://localhost:5000/api/v3 --suite behavioral  # 21/23 ✅
./run_contract_tests.sh --url http://localhost:5000/api/v3 --suite openapi     # 21/22 ✅

# Run with verbose output and custom categories
./run_contract_tests.sh --suite behavioral --category consistency,quality

# Generate detailed test reports (HTML + JSON)
./run_contract_tests.sh --url http://localhost:5000/api/v3 --report-dir ./reports
```

### Configuration

Database connection can be configured via environment variables:

```bash
export DB_SERVER=localhost
export DB_PORT=1433  
export DB_DATABASE=DocQueryService
export DB_USERNAME=sa
export DB_PASSWORD=DevPassword123!
```

## 📊 Database Schema

The database implements a comprehensive document management schema:

### Core Tables
- **`documents`** - Main document metadata (title, abstract, dates, URLs, etc.)
- **`countries`** - Country lookup table with codes and regions
- **`languages`** - Language codes and names
- **`document_types`** - Document type classifications
- **`authors`** - Author information with many-to-many relationships
- **`topics`** - Subject/topic categorization

### Analytics Tables
- **`search_queries`** - Query logging for performance analysis
- **`document_access`** - View/download tracking for usage metrics

### Views & Procedures  
- **`v_documents_summary`** - Document summaries with access counts
- **`sp_SearchDocuments`** - Full-text search with filtering
- **`sp_GetSearchFacets`** - Faceted search results

## 🎯 Observability Objectives

This project demonstrates comprehensive observability patterns:

1. **Infrastructure Monitoring** - CPU, memory, network across hybrid cloud
2. **APM (Application Performance Monitoring)** - End-to-end distributed tracing
3. **Synthetic Monitoring** - API uptime and performance testing
4. **Real User Monitoring** - Frontend performance and user experience
5. **Business Intelligence** - Technical metrics correlated with business KPIs
6. **Automated RCA** - Root cause analysis with correlated telemetry
7. **AI/ML Insights** - Predictive anomaly detection and automated remediation

## 🤝 Contributing

1. **Database changes**: Update `scripts/sql/init-schema.sql` and test with `database.py`
2. **API changes**: Update OpenAPI spec in `docs/openapi.yaml` and run contract tests
3. **Documentation**: Update relevant README files and maintain accuracy
4. **Testing**: Add tests for new functionality and ensure all tests pass

## 🔗 Additional Resources

- **[Database Setup Guide](scripts/README.md)** - Complete database installation and configuration
- **[Scraper Documentation](scripts/SCRAPER_README.md)** - World Bank API data collection
- **[API Specification](docs/WORLDBANK_API.md)** - Detailed API reference and examples
- **[Project Goals](docs/GOALS.md)** - Observability demonstration objectives
- **[Test Documentation](tests/README.md)** - Contract testing and validation

## 📄 License

This project is designed for educational and demonstration purposes, showcasing modern observability practices and multi-backend architecture patterns.

---

**Status**: 🟢 .NET backend API complete with 93% World Bank API contract compliance

**Next Milestone**: Java backend API implementation and React frontend development