# Database Cleanup Scripts

This directory contains scripts to delete all data from the database while preserving the table structure. This is useful for development, testing, or when you need to reset the database to a clean state.

## ⚠️ WARNING

**These scripts will DELETE ALL DATA from your database!** Make sure you have backups if needed.

## Available Scripts

### 1. Python Script (Recommended)

**File:** `cleanup-database.py`

A comprehensive Python script that supports both PostgreSQL and SQL Server with safety features:

- ✅ Handles foreign key constraints properly
- ✅ Resets auto-increment sequences
- ✅ Shows table counts before/after cleanup
- ✅ Requires explicit confirmation
- ✅ Supports both database types
- ✅ Loads environment variables automatically

#### Usage:

```bash
# Show current table row counts
python3 cleanup-database.py --show-counts

# Clean PostgreSQL database (requires confirmation)
python3 cleanup-database.py --db-type postgresql --confirm

# Clean SQL Server database
python3 cleanup-database.py --db-type sqlserver --confirm
```

#### Requirements:

Install dependencies:

```bash
pip install -r cleanup_requirements.txt
```

### 2. Shell Script Wrapper

**File:** `cleanup-database.sh`

A convenient shell wrapper that:

- Automatically loads environment variables from `local-dev.env` files
- Installs Python dependencies if missing
- Provides easy-to-use interface

#### Usage:

```bash
# Show usage
./cleanup-database.sh

# Show current table counts
./cleanup-database.sh --show-counts

# Clean database (PostgreSQL)
./cleanup-database.sh --confirm

# Clean SQL Server database
./cleanup-database.sh --confirm --db-type sqlserver
```

### 3. Pure SQL Scripts

For those who prefer direct SQL execution:

#### PostgreSQL: `sql/cleanup-data.postgresql.sql`

- Uses `TRUNCATE` for fast cleanup
- Handles foreign key constraints
- Resets sequences automatically
- Re-inserts essential lookup data

#### SQL Server: `sql/cleanup-data.sqlserver.sql`

- Uses `DELETE` statements for compatibility
- Resets identity columns with `DBCC CHECKIDENT`
- Re-inserts essential lookup data

#### Usage:

```bash
# PostgreSQL
psql -d docqueryservice -f sql/cleanup-data.postgresql.sql

# SQL Server
sqlcmd -S localhost -d DocQueryService -i sql/cleanup-data.sqlserver.sql
```

## Environment Variables

The scripts automatically load environment variables from:

1. `../backend-python/local-dev.env` (preferred)
2. `../deployment/local-dev.env` (fallback)

### PostgreSQL Environment Variables:

```bash
# Option 1: Connection string
DATABASE_URL=postgresql://user:pass@host:port/dbname

# Option 2: Individual parameters
DB_HOST=localhost
DB_PORT=5432
DB_DATABASE=docqueryservice
DB_USERNAME=postgres
DB_PASSWORD=DevPassword123!
```

### SQL Server Environment Variables:

```bash
DB_SERVER=localhost
DB_PORT=1433
DB_DATABASE=DocQueryService
DB_USERNAME=sa
DB_PASSWORD=DevPassword123!
```

## Database Tables Cleaned

The scripts clean the following tables in dependency order:

### Relationship Tables (cleaned first):

- `document_authors`
- `document_topics`
- `document_access`

### Main Data Tables:

- `search_queries`
- `documents`

### Lookup Tables (cleaned last):

- `authors`
- `topics`
- `document_types`
- `languages`
- `countries`

## What Gets Preserved

After cleanup, the following essential lookup data is restored:

### Countries (10 entries):

- Major world regions and countries
- Includes Afghanistan, Brazil, China, Germany, India, Kenya, Mexico, Nigeria, USA, Global

### Languages (7 entries):

- English, Spanish, French, Portuguese, Chinese, Arabic, Russian

### Document Types (6 entries):

- Project Document, Country Study, Policy Research Report, Working Paper, Annual Report, Strategy Document

### Topics (8 entries):

- Energy, Education, Health, Infrastructure, Environment, Governance, Private Sector, Social Protection

## Safety Features

1. **Explicit Confirmation Required**: The Python script requires `--confirm` flag and user confirmation
2. **Foreign Key Handling**: Proper order of deletion to avoid constraint violations
3. **Transaction Safety**: SQL scripts use transactions for rollback capability
4. **Dependency Checks**: Python script checks for required packages
5. **Environment Loading**: Automatic loading of database credentials
6. **Verbose Logging**: Optional detailed logging with `--verbose` flag

## Examples

### Quick Reset for Development:

```bash
# Check current state
./cleanup-database.sh --show-counts

# Clean everything
./cleanup-database.sh --confirm

# Verify cleanup
./cleanup-database.sh --show-counts
```

### Production-Safe Cleanup:

```bash
# 1. Create backup first
pg_dump docqueryservice > backup_$(date +%Y%m%d_%H%M%S).sql

# 2. Show what will be deleted
python3 cleanup-database.py --show-counts

# 3. Perform cleanup with confirmation
python3 cleanup-database.py --confirm

# 4. Verify results
python3 cleanup-database.py --show-counts
```

## Troubleshooting

### Missing Python Dependencies:

```bash
pip install psycopg2-binary pyodbc
```

### Permission Issues:

```bash
chmod +x cleanup-database.py cleanup-database.sh
```

### Connection Issues:

- Check your `local-dev.env` file has correct database credentials
- Ensure database is running
- Verify network connectivity to database server

### Foreign Key Errors:

The scripts handle foreign key constraints automatically, but if you encounter issues:

- Use the Python script instead of raw SQL
- Check if there are additional tables not included in the cleanup list
