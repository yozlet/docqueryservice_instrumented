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
├── tests/                       # Contract tests and API validation
├── docs/                       # Project documentation
│   ├── GOALS.md                # Observability demo objectives
│   ├── WORLDBANK_API.md        # API specification reference
│   └── openapi.yaml            # OpenAPI specification
└── [backends]                  # Future: .NET and Java API implementations
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

### 🚧 **In Development**

- **Frontend React application** for document search and browsing
- **.NET backend API** implementing World Bank-style endpoints  
- **Java backend API** with identical functionality to .NET version
- **OpenTelemetry instrumentation** across all components
- **Honeycomb.io integration** for unified observability

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

### Testing

```bash
# Run API contract tests
cd tests
./run_contract_tests.sh

# Run with verbose output
pytest test_api_contract.py -v

# Generate test reports
pytest test_openapi_contract.py --html=reports/test_report.html
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

**Status**: 🟢 Database infrastructure complete, ready for backend API development

**Next Milestone**: .NET and Java backend API implementations with OpenTelemetry instrumentation