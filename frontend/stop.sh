#!/bin/bash

# Store the process ID file location
PID_FILE="run/react.pid"

# Function to kill React-related processes
kill_react_processes() {
    # Find and kill all node processes running react-scripts
    REACT_PIDS=$(ps aux | grep "[r]eact-scripts" | awk '{print $2}')
    if [ ! -z "$REACT_PIDS" ]; then
        echo "Killing React development server processes..."
        for pid in $REACT_PIDS; do
            echo "Killing process $pid..."
            kill -9 $pid 2>/dev/null
        done
    fi

    # Find and kill any node processes running on port 3000
    PORT_PIDS=$(lsof -ti:3000)
    if [ ! -z "$PORT_PIDS" ]; then
        echo "Killing processes on port 3000..."
        for pid in $PORT_PIDS; do
            echo "Killing process $pid..."
            kill -9 $pid 2>/dev/null
        done
    fi
}

# Check if PID file exists and try to kill that process first
if [ -f "$PID_FILE" ]; then
    PID=$(cat "$PID_FILE")
    if ps -p $PID > /dev/null; then
        echo "Stopping React development server (PID: $PID)..."
        kill $PID
    fi
    rm "$PID_FILE"
fi

# Kill any remaining React processes
kill_react_processes

echo "All React development processes have been stopped."