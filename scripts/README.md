# Database Setup for Document Query Service

This directory contains all the tools needed to set up and populate a SQL Server database for the Document Query Service.

> **📋 Documentation Note**: This README covers database setup and infrastructure. For detailed information about the World Bank API scraper, see [docs/SCRAPER_README.md](docs/SCRAPER_README.md). All comprehensive documentation is available in the [docs/](docs/) directory.

## 🚀 Quick Start

**One-command setup** (recommended):

```bash
cd scripts
./setup-database.sh
```

This will:

- Start SQL Server in Docker
- Initialize the database schema
- Load 500 sample documents from World Bank API
- Enable full-text search
- Test the setup

## 📁 Files Overview

### Database Schema

- **`sql/init-schema.sql`** - SQL Server database schema with tables, indexes, views, and stored procedures
- **`sql/enable-fulltext-search.sql`** - Full-text search setup (run after data is loaded)

### Python Tools

- **`database.py`** - Database connection utilities and operations
- **`worldbank_scraper.py`** - Enhanced scraper with direct database insertion (see [docs/SCRAPER_README.md](docs/SCRAPER_README.md))
- **`database_requirements.txt`** - Python dependencies for database operations

### Setup Scripts

- **`setup-database.sh`** - Automated database setup script
- **`docker-compose.yml`** (in project root) - SQL Server container configuration

## 🔧 Manual Setup

If you prefer manual setup or need to troubleshoot:

### 1. Start SQL Server

```bash
# From project root
docker-compose up -d sqlserver

# Wait for container to be ready
docker exec docquery-sqlserver /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P 'DevPassword123!' -Q 'SELECT 1'
```

### 2. Install Python Dependencies

```bash
pip3 install -r database_requirements.txt
```

**Note:** The database utilities now use `pymssql` instead of `pyodbc` for better ARM64 (Apple Silicon) compatibility and easier setup.

### 3. Initialize Database

```bash
# Test connection and create database
python3 database.py

# Or manually with Docker
docker exec docquery-sqlserver /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P 'DevPassword123!' -Q "CREATE DATABASE DocQueryService"

# Run schema
docker cp sql/init-schema.sql docquery-sqlserver:/tmp/init-schema.sql
docker exec docquery-sqlserver /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P 'DevPassword123!' -d DocQueryService -i /tmp/init-schema.sql
```

### 4. Load Sample Data

```bash
# Option A: Direct database insertion (recommended)
python3 worldbank_scraper.py --count 500 --database

# Option B: Generate SQL file first
python3 worldbank_scraper.py --count 500 --output sample_data.sql
docker cp sample_data.sql docquery-sqlserver:/tmp/sample_data.sql
docker exec docquery-sqlserver /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P 'DevPassword123!' -d DocQueryService -i /tmp/sample_data.sql
```

### 5. Enable Full-Text Search

```bash
docker cp sql/enable-fulltext-search.sql docquery-sqlserver:/tmp/enable-fulltext-search.sql
docker exec docquery-sqlserver /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P 'DevPassword123!' -d DocQueryService -i /tmp/enable-fulltext-search.sql
```

## 🔍 Database Operations

### Connect to Database

```bash
# Using sqlcmd in container
docker exec -it docquery-sqlserver /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P 'DevPassword123!' -d DocQueryService

# Using Python
python3 -c "
from database import DatabaseManager
db = DatabaseManager()
docs = db.search_documents('energy', limit=5)
for doc in docs: print(doc['title'])
"
```

### Load More Data

```bash
# Fetch specific topics
python3 worldbank_scraper.py --query "renewable energy" --count 200 --database

# Fetch by country
python3 worldbank_scraper.py --country "Brazil" --count 100 --database

# Large dataset
python3 worldbank_scraper.py --count 2000 --database
```

## 📊 Database Schema Overview

### Core Tables

- **`documents`** - Main document metadata (title, abstract, dates, etc.)
- **`countries`** - Country lookup table
- **`languages`** - Language codes and names
- **`document_types`** - Document type classifications
- **`authors`** - Author information
- **`topics`** - Topic/subject categorization

### Analytics Tables

- **`search_queries`** - Query logging for analytics
- **`document_access`** - View/download tracking

### Views & Procedures

- **`v_documents_summary`** - Document summary with access counts
- **`sp_SearchDocuments`** - Full-text search with filtering
- **`sp_GetSearchFacets`** - Faceted search results

## 🛠️ Connection Details

**Default Configuration:**

- **Server**: localhost:1433
- **Database**: DocQueryService
- **Username**: sa
- **Password**: DevPassword123!

## 🧪 Testing

Test your database setup:

```bash
# Basic connectivity test
python3 database.py

# Search functionality test
python3 -c "
from database import DatabaseManager
db = DatabaseManager()
results = db.search_documents('development', limit=3)
print(f'Found {len(results)} documents')
"
```

Your database is now ready to power the Document Query Service APIs! 🎉

## 📁 Directory Structure

```
scripts/
├── README.md                    # This file - main scripts overview
├── setup-database-azurite.sh   # 🚀 Automated Azurite setup (recommended)
├── setup-database.sh           # Database setup script
├── pdf_downloader_azurite.py   # Azurite PDF downloader
├── pdf_downloader.py           # Filesystem PDF downloader
├── worldbank_scraper.py        # World Bank API scraper
├── database.py                 # Database utilities (wrapper)
├── docs/                       # 📚 All documentation
├── utilities/                  # 🛠️ Helper scripts and tools
├── test/                       # 🧪 Test files and data
└── tmp/                        # 📂 Temporary files (PDFs, SQL data)
```

## 📚 Documentation

Comprehensive documentation is available in the [docs/](docs/) directory:

- **[docs/README_AZURITE.md](docs/README_AZURITE.md)** - Azurite blob storage integration
- **[docs/README_SETUP_AZURITE.md](docs/README_SETUP_AZURITE.md)** - Automated Azurite setup
- **[docs/UTILITIES.md](docs/UTILITIES.md)** - Helper scripts and utilities
- **[docs/CLEANUP_README.md](docs/CLEANUP_README.md)** - Database cleanup procedures
- **[docs/SCRAPER_README.md](docs/SCRAPER_README.md)** - World Bank scraper guide
- **[docs/STORAGE_README.md](docs/STORAGE_README.md)** - Storage system documentation

See [docs/README.md](docs/README.md) for the complete documentation index.

## 🧪 Testing

Test files and utilities are organized in the [test/](test/) directory:

- **[test/run_tests.sh](test/run_tests.sh)** - Main test runner
- **[test/README.md](test/README.md)** - Testing documentation
- Test data files and analysis tools

## 🛠️ Utilities

Helper scripts are available in the [utilities/](utilities/) directory:

- **[utilities/database.py](utilities/database.py)** - Database connection utilities
- **[utilities/cleanup-database.py](utilities/cleanup-database.py)** - Database cleanup utility
- **[utilities/cleanup-database.sh](utilities/cleanup-database.sh)** - Database cleanup script
- **[utilities/list_azurite_blobs.py](utilities/list_azurite_blobs.py)** - List Azurite blobs
- **[utilities/clean_azurite.sh](utilities/clean_azurite.sh)** - Clean Azurite storage
- **[utilities/start_azurite.sh](utilities/start_azurite.sh)** - Start Azurite emulator
