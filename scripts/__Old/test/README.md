# Test Directory

This directory contains all test-related files, scripts, and data for the Document Query Service.

## 📁 Directory Contents

### 🧪 Test Scripts

- **`run_tests.sh`** - Main test runner script
- **`test_worldbank_scraper.py`** - World Bank API scraper tests

### 📊 Test Data

- **`test_data.sql`** - Basic test dataset
- **`real_test_data.sql`** - Real-world test data
- **`test_sample.sql`** - Sample test queries
- **`test_batch_sample.sql`** - Batch test sample data
- **`test_batch_sample2.sql`** - Additional batch test data

### 🔧 Test Configuration

- **`pytest.ini`** - Pytest configuration
- **`test_requirements.txt`** - Python test dependencies

### 📂 Test Analysis Directories

- **`test_error_analysis/`** - Error analysis and debugging data
- **`test_retry/`** - Retry mechanism test data

## 🚀 Running Tests

### Basic Test Execution

```bash
# Run all tests
./run_tests.sh

# Run specific test
python3 test_worldbank_scraper.py
```

### Test Environment Setup

```bash
# Install test dependencies
pip install -r test_requirements.txt

# Run with pytest
pytest -v
```

## 📋 Test Data Usage

### Loading Test Data

```bash
# Load basic test data
psql -U postgres -d docqueryservice -f test_data.sql

# Load real test data
psql -U postgres -d docqueryservice -f real_test_data.sql
```

### Test Samples

- **`test_sample.sql`** - Contains sample queries for testing search functionality
- **`test_batch_sample*.sql`** - Batch processing test data

## 🔍 Test Analysis

### Error Analysis

The `test_error_analysis/` directory contains:

- Error logs and debugging information
- Performance analysis data
- Failure pattern analysis

### Retry Testing

The `test_retry/` directory contains:

- Retry mechanism test cases
- Network failure simulation data
- Timeout and recovery tests

## 💡 Best Practices

1. **Isolation**: Each test should be independent and not rely on other tests
2. **Cleanup**: Tests should clean up after themselves
3. **Data**: Use the provided test data files for consistent results
4. **Coverage**: Aim for comprehensive test coverage of core functionality

## 🔗 Integration with Main Scripts

Test files can reference main scripts using relative paths:

```bash
# From test directory
../pdf_downloader.py test_data.sql
../worldbank_scraper.py --count 10 --output test_output.sql
```

## 📚 Related Documentation

- **`../docs/`** - Main project documentation
- **`../README.md`** - Scripts overview
- **`../../tests/`** - Project-wide contract tests
