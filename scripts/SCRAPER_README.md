# World Bank API Scraper

This script fetches real document data from the World Bank Documents & Reports API and can either generate SQL INSERT statements or insert directly into a SQL Server database.

## Setup

1. Install Python dependencies:
   ```bash
   pip3 install -r requirements.txt
   ```

2. For database functionality, also install database dependencies:
   ```bash
   pip3 install -r database_requirements.txt
   ```

3. For development and testing, also install test dependencies:
   ```bash
   pip3 install -r test_requirements.txt
   ```

## Usage

### Basic Usage (SQL File Generation)
```bash
python3 worldbank_scraper.py --count 100 --output worldbank_data.sql
```

### Direct Database Insertion
```bash
python3 worldbank_scraper.py --count 100 --database
```

### Advanced Options
```bash
# Search for specific terms
python3 worldbank_scraper.py --count 50 --query "renewable energy" --output renewable_docs.sql

# Filter by country
python3 worldbank_scraper.py --count 25 --country "Brazil" --database

# Start from a specific offset for pagination
python3 worldbank_scraper.py --count 100 --offset 200 --output page3_data.sql

# Combine filters with database insertion
python3 worldbank_scraper.py --count 30 --query "climate change" --country "India" --database
```

## Parameters

| Parameter | Description | Default | Example |
|-----------|-------------|---------|---------|
| `--count` | Number of documents to fetch | 100 | `--count 500` |
| `--output` | Output SQL file name | worldbank_data.sql | `--output my_data.sql` |
| `--query` | Search query term | None | `--query "digital transformation"` |
| `--country` | Filter by specific country | None | `--country "Nigeria"` |
| `--offset` | Starting offset for pagination | 0 | `--offset 100` |
| `--database` | Insert directly into SQL Server database | False | `--database` |
| `--db-server` | Database server | localhost | `--db-server myserver` |
| `--db-port` | Database port | 1433 | `--db-port 1433` |
| `--db-name` | Database name | DocQueryService | `--db-name MyDB` |

## Output Options

### SQL File Generation
The scraper generates a SQL file containing:
- INSERT statements for countries referenced in the documents
- INSERT statements for languages found in the documents  
- INSERT statements for document types found in the documents
- INSERT statements for all document records

All INSERT statements include `ON CONFLICT DO NOTHING` clauses to prevent duplicates when running multiple times.

### Direct Database Insertion
When using `--database`, the scraper will:
- Connect directly to SQL Server
- Insert documents using MERGE operations to handle duplicates
- Provide real-time feedback on insertion progress
- Fall back to SQL file generation if database connection fails

## Database Setup

### For SQL File Method:
Before running the generated SQL file, make sure you have:
1. Created the database schema using `sql/init-schema.sql`
2. Set up your SQL Server database

Then run the generated SQL file:
```bash
# Copy to container and run
docker cp worldbank_data.sql docquery-sqlserver:/tmp/worldbank_data.sql
docker exec docquery-sqlserver /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P 'DevPassword123!' -d DocQueryService -i /tmp/worldbank_data.sql
```

### For Direct Database Method:
Make sure you have:
1. SQL Server running (see `README.md` for setup instructions)
2. Database schema initialized
3. Python database dependencies installed (`pip3 install -r database_requirements.txt`)

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
- **Database connection failed**: Ensure SQL Server is running and credentials are correct
- **ODBC driver not found**: Install SQL Server ODBC drivers for your system

## Examples

### Get recent climate-related documents (SQL file)
```bash
python3 worldbank_scraper.py --count 100 --query "climate" --output climate_docs.sql
```

### Get documents for multiple African countries (direct to database)
```bash
python3 worldbank_scraper.py --count 50 --country "Kenya" --database
python3 worldbank_scraper.py --count 50 --country "Nigeria" --database
```

### Build a large dataset incrementally
```bash
python3 worldbank_scraper.py --count 1000 --offset 0 --database
python3 worldbank_scraper.py --count 1000 --offset 1000 --database
python3 worldbank_scraper.py --count 1000 --offset 2000 --database
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
- **Database integration** - Direct insertion functionality and error handling

### Test Data

Tests use realistic mock data that matches the actual World Bank API response structure, including:
- Multiple document formats
- Nested fields (like `docna` arrays)
- Optional fields and edge cases
- Various data types and formats