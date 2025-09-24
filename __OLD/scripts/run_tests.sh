#!/bin/bash
# Test runner script for World Bank scraper

set -e

echo "World Bank Scraper Test Suite"
echo "============================="

# Check if test dependencies are installed
echo "Checking test dependencies..."
python3 -c "import pytest, responses" 2>/dev/null || {
    echo "Test dependencies not found. Installing..."
    pip3 install -r test_requirements.txt
}

# Run the tests
echo -e "\nRunning tests...\n"
python3 -m pytest test_worldbank_scraper.py -v

# Optional: Run with coverage if pytest-cov is available
if python3 -c "import pytest_cov" 2>/dev/null; then
    echo -e "\nRunning tests with coverage...\n"
    python3 -m pytest test_worldbank_scraper.py --cov=worldbank_scraper --cov-report=term-missing
fi

echo -e "\nTest suite completed successfully! ✅"