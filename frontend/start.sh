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

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "Error: Node.js is not installed"
    exit 1
fi

# Check if npm is installed
if ! command -v npm &> /dev/null; then
    echo "Error: npm is not installed"
    exit 1
fi

# Store the process ID file location
PID_FILE="run/react.pid"

# Create run directory if it doesn't exist
mkdir -p run

# Check if the app is already running
if [ -f "$PID_FILE" ]; then
    echo "Error: Application is already running. Use stop.sh to stop it first."
    exit 1
fi

# Install dependencies if node_modules doesn't exist
if [ ! -d "node_modules" ]; then
    echo "Installing dependencies..."
    npm install
fi

# Start the server based on environment
if [ "$ENV" = "production" ]; then
    echo "Starting React in production mode..."
    # Use serve for production
    npm install -g serve
    npm run build
    serve -s build -l 3000 & echo $! > "$PID_FILE"
    echo "Production server started. The application should be available at http://localhost:3000"
else
    echo "Starting React in development mode..."
    npm start & echo $! > "$PID_FILE"
    echo "Development server started. The application should be available at http://localhost:3000"
fi

echo "Use ./stop.sh to stop the server"
