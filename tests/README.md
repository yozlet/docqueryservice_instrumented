# API Contract Tests

This directory contains a comprehensive test suite that validates any implementation of the World Bank Documents API against the defined contract. These tests ensure API parity between the .NET and Java implementations.

## Overview

The contract tests validate:
- **API Structure**: Correct endpoint behavior and response formats
- **Parameter Handling**: Proper processing of query parameters
- **Data Quality**: Schema compliance and data consistency
- **Error Handling**: Appropriate error responses
- **Pagination**: Consistent pagination behavior
- **Filtering**: Search and filter functionality

## Quick Start

### Test Local Implementation

```bash
# Test .NET implementation (default port 5000)
./run_contract_tests.sh --url http://localhost:5000/v3

# Test Java implementation (default port 8080)
./run_contract_tests.sh --url http://localhost:8080/v3
```

### Test Deployed Service

```bash
./run_contract_tests.sh --url https://api.yourservice.com/v3
```

## Test Categories

### Health Tests (`health`)
- API availability and health endpoint
- Basic service responsiveness

```bash
./run_contract_tests.sh --category health
```

### Basic Functionality Tests (`basic`)
- Core search endpoint behavior
- JSON response structure
- Document schema validation

```bash
./run_contract_tests.sh --category basic
```

### Parameter Handling Tests (`parameters`)
- Query parameter validation
- Format parameter (json/xml)
- Pagination parameters (rows, os)
- Field selection (fl parameter)

```bash
./run_contract_tests.sh --category parameters
```

### Filtering Tests (`filtering`)
- Country filtering (`count_exact`)
- Language filtering (`lang_exact`)
- Date range filtering (`strdate`/`enddate`)
- Search query (`qterm`)

```bash
./run_contract_tests.sh --category filtering
```

### Error Handling Tests (`errors`)
- Invalid parameter handling
- Error response format
- Graceful degradation

```bash
./run_contract_tests.sh --category errors
```

### Consistency Tests (`consistency`)
- Identical requests return identical results
- Pagination consistency
- Result ordering

```bash
./run_contract_tests.sh --category consistency
```

### Data Quality Tests (`quality`)
- Document ID uniqueness
- Required field validation
- Data completeness

```bash
./run_contract_tests.sh --category quality
```

## Setup

### Install Dependencies

```bash
pip3 install -r contract_test_requirements.txt
```

### Dependencies Include:
- `pytest` - Test framework
- `requests` - HTTP client for API calls
- `jsonschema` - JSON schema validation
- `pyyaml` - YAML parsing for OpenAPI spec
- `pytest-html` - HTML test reports
- `pytest-json-report` - JSON test reports

## Running Tests

### Using the Test Runner (Recommended)

```bash
# Run all tests against local Java service
./run_contract_tests.sh

# Run specific categories
./run_contract_tests.sh --category health,basic,parameters

# Custom API URL
./run_contract_tests.sh --url http://localhost:9000/v3

# Custom report directory
./run_contract_tests.sh --report-dir ./test_results
```

### Using pytest Directly

```bash
# Set API URL environment variable
export API_BASE_URL=http://localhost:8080/v3

# Run all tests
pytest test_api_contract.py -v

# Run specific test classes
pytest test_api_contract.py::TestAPIHealth -v
pytest test_api_contract.py::TestAPIBasicFunctionality -v

# Generate HTML report
pytest test_api_contract.py --html=report.html --self-contained-html
```

## Test Reports

The test runner generates detailed reports:

- **HTML Report**: Visual test results with pass/fail status
- **JSON Report**: Machine-readable results for CI/CD integration

Example HTML report shows:
- Test execution summary
- Individual test results
- Failed test details with error messages
- Execution time and environment info

## Contract Validation

### OpenAPI Specification

The tests validate against the OpenAPI specification in `../docs/openapi.yaml`, ensuring:

- Correct endpoint paths and methods
- Proper request parameter handling
- Response schema compliance
- Error response formats

### Schema Validation

Each API response is validated against JSON schemas to ensure:
- Required fields are present
- Field types are correct
- Data structures match specification
- Optional fields are handled properly

## CI/CD Integration

### GitHub Actions Example

```yaml
- name: Test API Contract Compliance
  run: |
    cd tests
    ./run_contract_tests.sh --url ${{ env.API_URL }}
    
- name: Upload Test Reports
  uses: actions/upload-artifact@v3
  if: always()
  with:
    name: contract-test-reports
    path: tests/reports/
```

### JSON Report Integration

The JSON report format allows easy integration with CI/CD systems:

```bash
# Check if tests passed
if jq -e '.summary.failed == 0' reports/contract_test_results.json > /dev/null; then
    echo "All contract tests passed ✅"
else
    echo "Contract tests failed ❌"
    exit 1
fi
```

## Development Workflow

### Testing During Development

1. Start your API service (local .NET or Java implementation)
2. Run contract tests: `./run_contract_tests.sh`
3. Fix any contract violations
4. Re-run tests until all pass

### Before Deployment

1. Run full test suite against both implementations:
   ```bash
   # Test .NET implementation
   ./run_contract_tests.sh --url http://localhost:5000/v3
   
   # Test Java implementation  
   ./run_contract_tests.sh --url http://localhost:8080/v3
   ```

2. Ensure both implementations pass all tests
3. Compare results to verify true API parity

### Continuous Testing

Set up automated testing:
- Run tests on every commit
- Test against staging environments
- Validate before production deployment

## Troubleshooting

### API Not Available
```
❌ API not available at http://localhost:8080/v3
Make sure your API service is running
```
**Solution**: Start your API service and ensure it's listening on the correct port.

### Test Failures
Check the HTML report for detailed error messages and fix implementation issues.

### Schema Validation Errors
Update your API responses to match the OpenAPI specification schema.

### Missing Dependencies
```bash
pip3 install -r contract_test_requirements.txt
```

## Custom Test Development

### Adding New Tests

1. Add test methods to appropriate test classes in `test_api_contract.py`
2. Use descriptive test names and docstrings
3. Include proper assertions and error messages
4. Add appropriate pytest markers

### Test Categories

Add markers to new tests:
```python
@pytest.mark.health
def test_new_health_feature(self, api_tester):
    """Test new health check feature"""
    pass
```

### Extending Validation

Add custom schema validation:
```python
def _validate_custom_response(self, response_data):
    """Custom validation logic"""
    # Your validation code here
    pass
```

This contract test suite ensures that both .NET and Java implementations maintain perfect API parity and comply with the World Bank Documents API specification.