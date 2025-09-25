# Scripts Documentation

Quick reference for Document Query Service scripts and utilities.

## 🚀 Quick Start

### Generate Sample Data

```bash
# Generate 500 sample documents with PDFs
python worldbank_scraper.py --count 500

# Generate SQL only (no PDF downloads)
python worldbank_scraper.py --count 500 --sql-only
```

### Database Operations

```bash
# Show database table counts
python utilities/database-info.py

# Clean database tables (keeps containers running)
python utilities/clean.py --database --confirm

# Clean all data (database + files)
python utilities/clean.py --data --confirm
```

### File Management

```bash
# Clean generated files only
python utilities/clean.py --files --confirm

# Clean everything including Docker
python utilities/clean.py --all --confirm
```

## 📁 Key Scripts

### Data Generation

- **`worldbank_scraper.py`** - Scrapes World Bank API for sample documents
  - Default: Downloads PDFs to `pdfs/` directory
  - `--sql-only` flag: Generates SQL without downloading PDFs
  - Creates `sample_data.sql` file

### Database Management

- **`utilities/database.py`** - Database connection utilities and schema setup
- **`utilities/database-info.py`** - View table counts and optionally clean database
- **`utilities/clean.py`** - Comprehensive cleanup script (self-contained)

### Setup (Legacy)

- **`__Old/setup-database.sh`** - Automated local PostgreSQL setup
- **`__Old/setup-database-azurite.sh`** - Automated Azurite blob storage setup

## 🔧 Cleanup Options

The `clean.py` script provides different cleanup modes:

- `--data` - Clean database tables and files (recommended)
- `--database` - Clean database tables only
- `--files` - Clean generated files only
- `--docker` - Clean Docker containers and volumes
- `--all` - Clean everything

All cleanup operations require `--confirm` flag for safety.

## 📊 File Structure

```
scripts/
├── worldbank_scraper.py     # Main data generation script
├── sample_data.sql          # Generated SQL (gitignored)
├── pdfs/                    # Downloaded PDFs (gitignored)
├── utilities/
│   ├── clean.py            # Main cleanup script
│   ├── database.py         # Database utilities
│   └── database-info.py    # Database inspection
└── __Old/                  # Legacy/archived scripts
```

## 💡 Common Workflows

### Fresh Start

```bash
python utilities/clean.py --data --confirm
python worldbank_scraper.py --count 100
```

### Development Testing

```bash
python utilities/clean.py --files --confirm
python worldbank_scraper.py --count 50 --sql-only
```

### Full Reset

```bash
python utilities/clean.py --all --confirm
docker-compose up -d
python worldbank_scraper.py --count 500
```

## 🔗 Environment

- **Database**: PostgreSQL via Docker Compose
- **Storage**: Local filesystem (Azurite deprecated)
- **Python**: 3.8+ with requirements.txt dependencies
