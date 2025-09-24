#!/bin/bash

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

# Start the development server
echo "Starting React development server..."
npm start & echo $! > "$PID_FILE"

echo "Development server started. The application should be available at http://localhost:3000"
echo "Use ./stop.sh to stop the server"
