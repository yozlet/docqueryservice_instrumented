#!/bin/bash

# Load environment variables
if [ -f .env ]; then
    export $(cat .env | grep -v '^#' | xargs)
elif [ -f local-dev.env ]; then
    export $(cat local-dev.env | grep -v '^#' | xargs)
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

# Start uvicorn with reload in development mode
echo "Starting uvicorn server..."
uvicorn app.main:app \
    --host $LISTEN_HOST \
    --port $LISTEN_PORT \
    --reload \
    --reload-dir app \
    --log-level info

UVICORN_PID=$(ps aux | grep 'uvicorn app.main:app' | grep -v grep | awk '{print $2}')
# Store the PID in a file (optional)
echo "$UVICORN_PID" > run/uvicorn.pid
echo "Uvicorn PID: $UVICORN_PID"