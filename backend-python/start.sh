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
export LISTEN_PORT_HTTPS=${LISTEN_PORT_HTTPS:-"443"}

# SSL configuration
export SSL_KEYFILE=${SSL_KEYFILE:-""}
export SSL_CERTFILE=${SSL_CERTFILE:-""}
export SSL_VERSION=${SSL_VERSION:-"TLSv1_2"}
export SSL_CIPHERS=${SSL_CIPHERS:-"TLSv1.2+ECDSA+AESGCM:TLSv1.2+ECDSA+CHACHA20:TLSv1.2+ECDSA+AES"}

# Create PID file directory if it doesn't exist
mkdir -p ./run
ENV_FILE="./.worker.env"

# Start uvicorn based on environment
echo "Starting uvicorn server in $ENV mode..."
if [ "$ENV" = "production" ]; then
    # Create a temporary env file for workers    
    env | grep -v '^_' > "$ENV_FILE"
    # Production mode: no reload
    # Start HTTP server
    uvicorn app.main:app \
        --host $LISTEN_HOST \
        --port $LISTEN_PORT \
        --log-level info \
        --env-file "$ENV_FILE" &
    
    # Start HTTPS server if SSL certificates are provided
    if [ -n "$SSL_KEYFILE" ] && [ -n "$SSL_CERTFILE" ]; then
        echo "Starting HTTPS server..."
        uvicorn app.main:app \
            --host $LISTEN_HOST \
            --port $LISTEN_PORT_HTTPS \
            --ssl-keyfile "$SSL_KEYFILE" \
            --ssl-certfile "$SSL_CERTFILE" \
            --ssl-version "$SSL_VERSION" \
            --ssl-ciphers "$SSL_CIPHERS" \
            --log-level info \
            --env-file "$ENV_FILE"
    else
        # Wait for the HTTP server
        wait
    fi
else
    # Development mode: with reload
    # Start HTTP server
    uvicorn app.main:app \
        --host $LISTEN_HOST \
        --port $LISTEN_PORT \
        --reload \
        --reload-dir app \
        --log-level info &
        
    # Start HTTPS server if SSL certificates are provided
    if [ -n "$SSL_KEYFILE" ] && [ -n "$SSL_CERTFILE" ]; then
        echo "Starting HTTPS server..."
        uvicorn app.main:app \
            --host $LISTEN_HOST \
            --port $LISTEN_PORT_HTTPS \
            --ssl-keyfile "$SSL_KEYFILE" \
            --ssl-certfile "$SSL_CERTFILE" \
            --ssl-version "$SSL_VERSION" \
            --ssl-ciphers "$SSL_CIPHERS" \
            --reload \
            --reload-dir app \
            --log-level info
    else
        # Wait for the HTTP server
        wait
    fi
fi

# Clean up temporary env file
rm -f "$ENV_FILE"
