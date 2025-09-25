# Document Query Service - Scripts

Generate sample documents from World Bank API for development and testing.

## 🚀 Quick Start

### Generate Sample Data (Main Script)

```bash
# Generate 500 documents with PDFs
python worldbank_scraper.py --count 500

# Generate SQL only (no PDF downloads)
python worldbank_scraper.py --count 500 --sql-only
```

**Output:**

- `sample_data.sql` - Database INSERT statements
- `pdfs/` - Downloaded PDF files (unless `--sql-only`)

## 🛠️ Optional Utilities

### Database Management

```bash
# View database table counts
python utilities/database-info.py

# Initialize database schema
python utilities/database.py
```

### Cleanup

```bash
# Clean data only (recommended)
python utilities/clean.py --data --confirm

# Clean everything including Docker
python utilities/clean.py --all --confirm
```

## 📋 Requirements

```bash
pip install -r requirements.txt
```

## 📚 Detailed Documentation

For comprehensive guides, troubleshooting, and advanced usage:

- **[docs/README.md](docs/README.md)** - Complete documentation with workflows and examples
