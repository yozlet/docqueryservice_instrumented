#!/bin/bash
"""
Database Cleanup Shell Script
Simple wrapper around the Python cleanup script
"""

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PYTHON_SCRIPT="$SCRIPT_DIR/cleanup-database.py"

# Source environment variables if local-dev.env exists
if [ -f "$SCRIPT_DIR/../backend-python/local-dev.env" ]; then
    echo "Loading environment from backend-python/local-dev.env..."
    set -a  # automatically export all variables
    source "$SCRIPT_DIR/../backend-python/local-dev.env"
    set +a
elif [ -f "$SCRIPT_DIR/../deployment/local-dev.env" ]; then
    echo "Loading environment from deployment/local-dev.env..."
    set -a
    source "$SCRIPT_DIR/../deployment/local-dev.env"
    set +a
else
    echo "Warning: No local-dev.env file found. Make sure database environment variables are set."
fi

# Check if Python script exists
if [ ! -f "$PYTHON_SCRIPT" ]; then
    echo "Error: Python cleanup script not found at $PYTHON_SCRIPT"
    exit 1
fi

# Check if required Python packages are available
python3 -c "import psycopg2, pyodbc" 2>/dev/null
if [ $? -ne 0 ]; then
    echo "Installing required Python packages..."
    pip3 install psycopg2-binary pyodbc
fi

# Show usage if no arguments provided
if [ $# -eq 0 ]; then
    echo "Database Cleanup Script"
    echo "======================"
    echo ""
    echo "Usage:"
    echo "  $0 --show-counts                    # Show current table row counts"
    echo "  $0 --confirm                        # Clean PostgreSQL database"
    echo "  $0 --confirm --db-type sqlserver    # Clean SQL Server database"
    echo ""
    echo "Environment variables will be loaded from:"
    echo "  - backend-python/local-dev.env (preferred)"
    echo "  - deployment/local-dev.env (fallback)"
    echo ""
    exit 0
fi

# Execute the Python script with all arguments
echo "Executing cleanup script..."
python3 "$PYTHON_SCRIPT" "$@"
