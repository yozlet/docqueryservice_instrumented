#!/bin/bash

# Set the base URL for the service
BASE_URL="http://localhost:5002/v1"

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

# Test 1: Search Documents
print_header "Test 1: Search for documents about climate change"
search_response=$(call_api "POST" "/search" '{
    "search_text": "climate change",
    "max_results": 1
}')

echo "$search_response"

# Extract first document ID for summary test
doc_id=$(echo "$search_response" | jq -r '.documents[0].id')

if [ -n "$doc_id" ] && [ "$doc_id" != "null" ]; then
    print_header "Test 2: Generate summary for document $doc_id"
    call_api "POST" "/summary" "{
        \"ids\": [\"$doc_id\"],
        \"model\": \"gpt-3.5-turbo-16k\"
    }"
else
    echo -e "${RED}No document ID found in search results${NC}"
fi

# Test 3: Error handling - Invalid document ID
print_header "Test 3: Test error handling with invalid document ID"
call_api "POST" "/summary" '{
    "ids": ["invalid_id_123"],
    "model": "gpt-3.5-turbo-16k"
}'

# Test 4: Error handling - Empty request
print_header "Test 4: Test error handling with empty request"
call_api "POST" "/summary" '{
    "ids": []
}'
