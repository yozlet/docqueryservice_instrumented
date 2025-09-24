#!/bin/bash

# Check if PID file exists
if [ -f ./run/uvicorn.pid ]; then
    # Read PID from file
    PID=$(cat ./run/uvicorn.pid)
    
    # Check if process is running
    if ps -p $PID > /dev/null; then
        echo "Stopping uvicorn server (PID: $PID)..."
        kill $PID
        rm ./run/uvicorn.pid
    else
        echo "Process not running, removing stale PID file..."
        rm ./run/uvicorn.pid
    fi
else
    echo "No PID file found."
fi