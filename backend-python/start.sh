#!/bin/bash

# Function to show usage
show_usage() {
    echo "Usage: $0 [production|development]"
    echo "If no argument is provided, development mode is used"
    exit 1
}

# Check if more than one argument is provided
if [ $# -gt 1 ]; then
    show_usage
fi

# Set environment based on argument
ENV="development"
if [ $# -eq 1 ]; then
    case "$1" in
        production|development)
            ENV="$1"
            ;;
        *)
            show_usage
            ;;
    esac
fi

# Function to load environment variables from a file
load_env_file() {
    local env_file=$1
    if [ -f "$env_file" ]; then
        echo "Loading environment from $env_file..."
        set -a  # automatically export all variables
        source "$env_file"
        set +a
    fi
}

# Load environment variables based on mode
if [ "$ENV" = "production" ]; then
    if [ -f production.env ]; then
        load_env_file "production.env"
    else
        echo "Error: production.env file not found"
        exit 1
    fi
else
    if [ -f .env ]; then
        load_env_file ".env"
    elif [ -f local-dev.env ]; then
        load_env_file "local-dev.env"
    fi
fi

# Create and activate virtual environment if it doesn't exist
if [ ! -d ".venv" ]; then
    echo "Creating virtual environment..."
    python3 -m venv .venv
fi

# Activate virtual environment
source .venv/bin/activate

# Install dependencies if needed
if [ ! -f ".venv/.dependencies_installed" ]; then
    echo "Installing dependencies..."
    pip install --upgrade pip
    pip install -r requirements.txt
    touch .venv/.dependencies_installed
fi

# Set default environment variables if not set
export DATABASE_URL=${DATABASE_URL:-"postgresql://postgres:DevPassword123!@localhost:5432/docqueryservice"}
export LISTEN_HOST=${LISTEN_HOST:-"0.0.0.0"}
export LISTEN_PORT=${LISTEN_PORT:-"5002"}

# Create PID file directory if it doesn't exist
mkdir -p ./run
ENV_FILE="./.worker.env"

# Start uvicorn based on environment
echo "Starting uvicorn server in $ENV mode..."
if [ "$ENV" = "production" ]; then
    # Create a temporary env file for workers    
    env | grep -v '^_' > "$ENV_FILE"
    # Production mode: no reload
    uvicorn app.main:app \
        --host $LISTEN_HOST \
        --port $LISTEN_PORT \
        --log-level info \
        --env-file "$ENV_FILE"
else
    # Development mode: with reload
    uvicorn app.main:app \
        --host $LISTEN_HOST \
        --port $LISTEN_PORT \
        --reload \
        --reload-dir app \
        --log-level info
fi

# Clean up temporary env file
rm -f "$ENV_FILE"

UVICORN_PID=$(ps aux | grep 'uvicorn app.main:app' | grep -v grep | awk '{print $2}')
# Store the PID in a file
echo "$UVICORN_PID" > run/uvicorn.pid
echo "Uvicorn PID: $UVICORN_PID"