#!/bin/bash
# Contract Test Runner for World Bank API Implementations
# Tests any implementation (.NET or Java) against the API contract

set -e

# Default values
API_URL="http://localhost:8080/v3"
REPORT_DIR="./reports"
TEST_CATEGORIES="all"
TEST_SUITE="both"

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
    echo "  -s, --suite SUITE   Test suite: behavioral, openapi, both (default: both)"
    echo "  -r, --report-dir    Report output directory (default: ./reports)"
    echo "  -h, --help          Show this help message"
    echo ""
    echo "Test Suites:"
    echo "  behavioral  - Run behavioral/business logic tests (test_api_contract.py)"
    echo "                Tests consistency, data quality, filtering, error handling"
    echo "  openapi     - Run OpenAPI spec compliance tests (test_openapi_contract.py)"
    echo "                Tests schema validation and spec-driven parameter testing"
    echo "  both        - Run both test suites for comprehensive validation"
    echo ""
    echo "Examples:"
    echo "  # Test .NET implementation with both suites"
    echo "  $0 --url http://localhost:5000/v3"
    echo ""
    echo "  # Test Java implementation with only OpenAPI compliance"
    echo "  $0 --url http://localhost:8080/v3 --suite openapi"
    echo ""
    echo "  # Run only behavioral tests with specific categories"
    echo "  $0 --suite behavioral --category consistency,quality"
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
        -s|--suite)
            TEST_SUITE="$2"
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
echo -e "  Test Suite: ${GREEN}$TEST_SUITE${NC}"
echo -e "  Categories: ${GREEN}$TEST_CATEGORIES${NC}"
echo -e "  Report Dir: ${GREEN}$REPORT_DIR${NC}"
echo ""

# Create report directory
mkdir -p "$REPORT_DIR"

# Check if test dependencies are installed
echo -e "${YELLOW}Checking dependencies...${NC}"
if [[ "$TEST_SUITE" == "openapi" || "$TEST_SUITE" == "both" ]]; then
    # OpenAPI tests need additional dependencies
    if ! python3 -c "import pytest, requests, jsonschema, yaml, openapi_parser" 2>/dev/null; then
        echo -e "${YELLOW}Installing test dependencies...${NC}"
        pip3 install -r contract_test_requirements.txt
    fi
else
    # Behavioral tests need basic dependencies
    if ! python3 -c "import pytest, requests, jsonschema, yaml" 2>/dev/null; then
        echo -e "${YELLOW}Installing test dependencies...${NC}"
        pip3 install -r contract_test_requirements.txt
    fi
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

# Function to run a test suite
run_test_suite() {
    local test_file=$1
    local suite_name=$2
    local report_suffix=$3
    
    echo -e "${YELLOW}Running $suite_name tests...${NC}"
    
    # Build pytest command
    local PYTEST_CMD="python3 -m pytest $test_file -v"
    PYTEST_CMD="$PYTEST_CMD --html=$REPORT_DIR/${report_suffix}_test_report.html --self-contained-html"
    PYTEST_CMD="$PYTEST_CMD --json-report --json-report-file=$REPORT_DIR/${report_suffix}_test_results.json"
    
    # Add category filters for behavioral tests (OpenAPI tests don't use markers)
    if [[ "$test_file" == "test_api_contract.py" && "$TEST_CATEGORIES" != "all" ]]; then
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
    
    echo "Command: $PYTEST_CMD"
    echo ""
    
    # Run the tests
    if eval $PYTEST_CMD; then
        echo -e "${GREEN}✅ $suite_name tests completed successfully!${NC}"
        return 0
    else
        echo -e "${RED}❌ Some $suite_name tests failed${NC}"
        return 1
    fi
}

# Run tests based on selected suite
OVERALL_RESULT=0

case "$TEST_SUITE" in
    "behavioral")
        echo -e "${YELLOW}Running behavioral contract tests...${NC}"
        echo ""
        if ! run_test_suite "test_api_contract.py" "behavioral" "behavioral"; then
            OVERALL_RESULT=1
        fi
        ;;
    "openapi")
        echo -e "${YELLOW}Running OpenAPI specification tests...${NC}"
        echo ""
        if ! run_test_suite "test_openapi_contract.py" "OpenAPI specification" "openapi"; then
            OVERALL_RESULT=1
        fi
        ;;
    "both")
        echo -e "${YELLOW}Running comprehensive contract tests (both suites)...${NC}"
        echo ""
        
        # Run behavioral tests
        echo -e "${BLUE}=== Behavioral Contract Tests ===${NC}"
        if ! run_test_suite "test_api_contract.py" "behavioral" "behavioral"; then
            OVERALL_RESULT=1
        fi
        
        echo ""
        echo -e "${BLUE}=== OpenAPI Specification Tests ===${NC}"
        if ! run_test_suite "test_openapi_contract.py" "OpenAPI specification" "openapi"; then
            OVERALL_RESULT=1
        fi
        ;;
    *)
        echo -e "${RED}❌ Invalid test suite: $TEST_SUITE${NC}"
        echo -e "${YELLOW}Valid options: behavioral, openapi, both${NC}"
        exit 1
        ;;
esac

# Show report locations
echo ""
echo -e "${YELLOW}Test Reports:${NC}"
case "$TEST_SUITE" in
    "behavioral")
        echo -e "  Behavioral HTML: ${BLUE}$REPORT_DIR/behavioral_test_report.html${NC}"
        echo -e "  Behavioral JSON: ${BLUE}$REPORT_DIR/behavioral_test_results.json${NC}"
        ;;
    "openapi")
        echo -e "  OpenAPI HTML: ${BLUE}$REPORT_DIR/openapi_test_report.html${NC}"
        echo -e "  OpenAPI JSON: ${BLUE}$REPORT_DIR/openapi_test_results.json${NC}"
        ;;
    "both")
        echo -e "  Behavioral HTML: ${BLUE}$REPORT_DIR/behavioral_test_report.html${NC}"
        echo -e "  Behavioral JSON:  ${BLUE}$REPORT_DIR/behavioral_test_results.json${NC}"
        echo -e "  OpenAPI HTML:     ${BLUE}$REPORT_DIR/openapi_test_report.html${NC}"
        echo -e "  OpenAPI JSON:     ${BLUE}$REPORT_DIR/openapi_test_results.json${NC}"
        ;;
esac

# Summary
if [[ $OVERALL_RESULT -eq 0 ]]; then
    echo ""
    case "$TEST_SUITE" in
        "behavioral")
            echo -e "${GREEN}🎉 API implementation passes behavioral contract tests!${NC}"
            ;;
        "openapi")
            echo -e "${GREEN}🎉 API implementation conforms to OpenAPI specification!${NC}"
            ;;
        "both")
            echo -e "${GREEN}🎉 API implementation passes comprehensive contract validation!${NC}"
            echo -e "${GREEN}   ✅ Behavioral compliance: PASSED${NC}"
            echo -e "${GREEN}   ✅ OpenAPI specification: PASSED${NC}"
            ;;
    esac
else
    echo ""
    case "$TEST_SUITE" in
        "behavioral")
            echo -e "${RED}⚠️  API implementation has behavioral contract violations${NC}"
            ;;
        "openapi")
            echo -e "${RED}⚠️  API implementation fails OpenAPI specification compliance${NC}"
            ;;
        "both")
            echo -e "${RED}⚠️  API implementation has contract violations${NC}"
            ;;
    esac
    echo -e "${YELLOW}Check the test reports for details${NC}"
fi

exit $OVERALL_RESULT