#!/bin/bash

# Stop and remove existing container if it exists
echo "Stopping existing web-nginx container if running..."
docker stop web-nginx >/dev/null 2>&1
docker rm web-nginx >/dev/null 2>&1

# Build the Docker image
echo "Building web-nginx image..."
docker build -t web-nginx .

if [ $? -ne 0 ]; then
    echo "Error: Failed to build Docker image"
    exit 1
fi

# Load environment variables from .env.local if it exists
if [ -f .env.local ]; then
    echo "Loading environment variables from .env.local..."
    set -a  # automatically export all variables
    source .env.local
    set +a
else
    echo "No .env.local file found, using default environment variables..."
fi

# Run the container
echo "Starting web-nginx container..."
docker run -d \
    --name web-nginx \
    -p 8080:8080 \
    --add-host host.docker.internal:host-gateway \
    -e OTEL_COLLECTOR_URL="${OTEL_COLLECTOR_URL:-}" \
    -e HONEYCOMB_API_KEY="${HONEYCOMB_API_KEY:-}" \
    web-nginx

if [ $? -ne 0 ]; then
    echo "Error: Failed to start container"
    exit 1
fi

echo "Container web-nginx is running!"
echo "Access the proxy at http://localhost:8080"
echo "To view logs: docker logs web-nginx"
echo "To stop: docker stop web-nginx"