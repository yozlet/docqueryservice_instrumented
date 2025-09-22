#!/bin/bash
# Contract Test Runner for World Bank API Implementations
# Tests any implementation (.NET or Java) against the API contract

set -e

# Default values
API_URL="http://localhost:8080/v3"
REPORT_DIR="./reports"
TEST_CATEGORIES="all"

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

usage() {
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Run API contract tests against any World Bank API implementation"
    echo ""
    echo "Options:"
    echo "  -u, --url URL       API base URL (default: http://localhost:8080/v3)"
    echo "  -c, --category CAT  Test category: health, basic, parameters, filtering, errors, consistency, quality, all (default: all)"
    echo "  -r, --report-dir    Report output directory (default: ./reports)"
    echo "  -h, --help          Show this help message"
    echo ""
    echo "Examples:"
    echo "  # Test .NET implementation"
    echo "  $0 --url http://localhost:5000/v3"
    echo ""
    echo "  # Test Java implementation"  
    echo "  $0 --url http://localhost:8080/v3"
    echo ""
    echo "  # Run only health and basic tests"
    echo "  $0 --category health,basic"
    echo ""
    echo "  # Test against deployed service"
    echo "  $0 --url https://api.myservice.com/v3"
    exit 1
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -u|--url)
            API_URL="$2"
            shift 2
            ;;
        -c|--category)
            TEST_CATEGORIES="$2"
            shift 2
            ;;
        -r|--report-dir)
            REPORT_DIR="$2"
            shift 2
            ;;
        -h|--help)
            usage
            ;;
        *)
            echo "Unknown option: $1"
            usage
            ;;
    esac
done

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE} World Bank API Contract Test Runner${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""
echo -e "${YELLOW}Configuration:${NC}"
echo -e "  API URL: ${GREEN}$API_URL${NC}"
echo -e "  Categories: ${GREEN}$TEST_CATEGORIES${NC}"
echo -e "  Report Dir: ${GREEN}$REPORT_DIR${NC}"
echo ""

# Create report directory
mkdir -p "$REPORT_DIR"

# Check if test dependencies are installed
echo -e "${YELLOW}Checking dependencies...${NC}"
if ! python3 -c "import pytest, requests, jsonschema, yaml" 2>/dev/null; then
    echo -e "${YELLOW}Installing test dependencies...${NC}"
    pip3 install -r contract_test_requirements.txt
fi

# Test API availability
echo -e "${YELLOW}Testing API availability...${NC}"
if curl -s -f "$API_URL/health" >/dev/null 2>&1; then
    echo -e "${GREEN}✅ API health endpoint responding${NC}"
elif curl -s -f "$API_URL/wds?format=json&rows=1" >/dev/null 2>&1; then
    echo -e "${GREEN}✅ API main endpoint responding${NC}"
else
    echo -e "${RED}❌ API not available at $API_URL${NC}"
    echo -e "${YELLOW}Make sure your API service is running${NC}"
    exit 1
fi
echo ""

# Set environment variable for tests
export API_BASE_URL="$API_URL"

# Build pytest command based on categories
PYTEST_CMD="python3 -m pytest test_api_contract.py -v"
PYTEST_CMD="$PYTEST_CMD --html=$REPORT_DIR/contract_test_report.html --self-contained-html"
PYTEST_CMD="$PYTEST_CMD --json-report --json-report-file=$REPORT_DIR/contract_test_results.json"

if [[ "$TEST_CATEGORIES" != "all" ]]; then
    # Convert comma-separated categories to pytest marker expressions
    IFS=',' read -ra CATEGORIES <<< "$TEST_CATEGORIES"
    MARKER_EXPR=""
    for category in "${CATEGORIES[@]}"; do
        if [[ -z "$MARKER_EXPR" ]]; then
            MARKER_EXPR="$category"
        else
            MARKER_EXPR="$MARKER_EXPR or $category"
        fi
    done
    PYTEST_CMD="$PYTEST_CMD -m \"$MARKER_EXPR\""
fi

echo -e "${YELLOW}Running contract tests...${NC}"
echo "Command: $PYTEST_CMD"
echo ""

# Run the tests
if eval $PYTEST_CMD; then
    echo ""
    echo -e "${GREEN}✅ Contract tests completed successfully!${NC}"
    RESULT=0
else
    echo ""
    echo -e "${RED}❌ Some contract tests failed${NC}"
    RESULT=1
fi

# Show report locations
echo ""
echo -e "${YELLOW}Test Reports:${NC}"
echo -e "  HTML: ${BLUE}$REPORT_DIR/contract_test_report.html${NC}"
echo -e "  JSON: ${BLUE}$REPORT_DIR/contract_test_results.json${NC}"

# Summary
if [[ $RESULT -eq 0 ]]; then
    echo ""
    echo -e "${GREEN}🎉 API implementation conforms to the contract!${NC}"
else
    echo ""
    echo -e "${RED}⚠️  API implementation has contract violations${NC}"
    echo -e "${YELLOW}Check the test report for details${NC}"
fi

exit $RESULT