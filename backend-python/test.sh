#!/bin/bash
# Set the base URL for the service
BASE_URL="http://localhost:5002"

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to print section headers
print_header() {
    echo -e "\n${GREEN}=== $1 ===${NC}\n"
}

# Function to make API calls and handle errors
call_api() {
    local method=$1
    local endpoint=$2
    local data=$3
    
    if [ -n "$data" ]; then
        response=$(curl -s -X $method "${BASE_URL}${endpoint}" \
            -H "Content-Type: application/json" \
            -d "$data")
    else
        response=$(curl -s -X $method "${BASE_URL}${endpoint}")
    fi
    
    # Check if response contains error
    if echo "$response" | grep -q '"error":'; then
        echo -e "${RED}Error:${NC}"
        echo "$response" | jq .
        return 1
    else
        echo "$response" | jq .
        return 0
    fi
}

# Test 1: Health Check
print_header "Testing Health Check endpoint..."
curl -X GET "${BASE_URL}/health"
echo -e "\n"

# Test 2: Search Documents with title
print_header "Test 1: Testing Search with title..."
curl -X POST "${BASE_URL}/v1/search" \
  -H "Content-Type: application/json" \
  -d '{
    "search_text": "Climate Change",
    "max_results": 2
  }'
echo -e "\n"

# Test 3: Search Documents with multiple criteria
print_header "Test 2:Testing Search with multiple criteria..."
curl -X POST "${BASE_URL}/v1/search" \
  -H "Content-Type: application/json" \
  -d '{
    "doc_type": "Report",
    "language": "English",
    "max_results": 3
  }'
echo -e "\n"
