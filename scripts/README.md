# World Bank API Scraper

This script fetches real document data from the World Bank Documents & Reports API and generates SQL INSERT statements for populating your database.

## Setup

1. Install Python dependencies:
   ```bash
   pip3 install -r requirements.txt
   ```

2. For development and testing, also install test dependencies:
   ```bash
   pip3 install -r test_requirements.txt
   ```

## Usage

### Basic Usage
```bash
python3 worldbank_scraper.py --count 100 --output worldbank_data.sql
```

### Advanced Options
```bash
# Search for specific terms
python3 worldbank_scraper.py --count 50 --query "renewable energy" --output renewable_docs.sql

# Filter by country
python3 worldbank_scraper.py --count 25 --country "Brazil" --output brazil_docs.sql

# Start from a specific offset for pagination
python3 worldbank_scraper.py --count 100 --offset 200 --output page3_data.sql

# Combine filters
python3 worldbank_scraper.py --count 30 --query "climate change" --country "India" --output climate_india.sql
```

## Parameters

| Parameter | Description | Default | Example |
|-----------|-------------|---------|---------|
| `--count` | Number of documents to fetch | 100 | `--count 500` |
| `--output` | Output SQL file name | worldbank_data.sql | `--output my_data.sql` |
| `--query` | Search query term | None | `--query "digital transformation"` |
| `--country` | Filter by specific country | None | `--country "Nigeria"` |
| `--offset` | Starting offset for pagination | 0 | `--offset 100` |

## Output

The scraper generates a SQL file containing:
- INSERT statements for countries referenced in the documents
- INSERT statements for languages found in the documents  
- INSERT statements for document types found in the documents
- INSERT statements for all document records

All INSERT statements include `ON CONFLICT DO NOTHING` clauses to prevent duplicates when running multiple times.

## Database Setup

Before running the generated SQL file, make sure you have:
1. Created the database schema using `docs/schema.sql`
2. Set up your PostgreSQL or SQL Server database

Then run the generated SQL file:
```bash
psql -d your_database -f worldbank_data.sql
```

## Fields Extracted

The scraper extracts the following fields from the World Bank API:
- Document ID
- Title (from `display_title` field)
- Document date
- Abstract/description (when available)
- Document type and major document type
- Volume numbers
- URL (preferring PDF URLs)
- Language
- Country
- Author and publisher (when available)

## Rate Limiting

The scraper includes a 1-second delay between API requests to be respectful to the World Bank API. For large datasets, expect the scraping process to take some time.

## Troubleshooting

- **SSL Warnings**: You may see urllib3 SSL warnings - these can be safely ignored
- **No documents retrieved**: Try reducing the count or removing filters
- **Connection errors**: Check your internet connection and try again

## Examples

### Get recent climate-related documents
```bash
python3 worldbank_scraper.py --count 100 --query "climate" --output climate_docs.sql
```

### Get documents for multiple African countries (run separately)
```bash
python3 worldbank_scraper.py --count 50 --country "Kenya" --output kenya_docs.sql
python3 worldbank_scraper.py --count 50 --country "Nigeria" --output nigeria_docs.sql
```

### Build a large dataset incrementally
```bash
python3 worldbank_scraper.py --count 1000 --offset 0 --output batch1.sql
python3 worldbank_scraper.py --count 1000 --offset 1000 --output batch2.sql
python3 worldbank_scraper.py --count 1000 --offset 2000 --output batch3.sql
```

## Testing

The scraper includes a comprehensive test suite to ensure reliability and make it easier to validate changes.

### Running Tests

Run all tests:
```bash
pytest test_worldbank_scraper.py
```

Run with coverage:
```bash
pytest test_worldbank_scraper.py --cov=worldbank_scraper
```

Run specific test categories:
```bash
# Unit tests only
pytest test_worldbank_scraper.py::TestWorldBankScraper

# CLI tests only  
pytest test_worldbank_scraper.py::TestScraperCLI

# Specific test
pytest test_worldbank_scraper.py::TestWorldBankScraper::test_clean_text_basic
```

### Test Coverage

The test suite covers:
- **Text cleaning and sanitization** - Special characters, null bytes, length limits
- **Data extraction methods** - Countries, languages, document types from API responses
- **API interaction** - Request handling, parameter passing, error handling
- **SQL generation** - INSERT statement creation, field mapping, conflict handling
- **Date parsing** - Various date formats and edge cases
- **Command-line interface** - Argument parsing and method calls
- **Rate limiting** - Delay between API requests
- **Field mapping** - Correct handling of API response structure

### Test Data

Tests use realistic mock data that matches the actual World Bank API response structure, including:
- Multiple document formats
- Nested fields (like `docna` arrays)
- Optional fields and edge cases
- Various data types and formats