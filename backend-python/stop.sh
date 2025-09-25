#!/bin/bash

# Function to kill python processes
kill_python_processes() {
    # Find and kill all node processes running react-scripts
    PYTHON_PIDS=$(ps aux | grep "python3" | awk '{print $2}')
    if [ ! -z "$PYTHON_PIDS" ]; then
        echo "Killing python processes..."
        for pid in $PYTHON_PIDS; do
            echo "Killing process $pid..."
            kill -9 $pid 2>/dev/null
        done
    fi
}

# Kill any remaining python processes
kill_python_processes

echo "All python development processes have been stopped."