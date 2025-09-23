#!/bin/bash

# Frontend Deployment Script for Document Query Service
# This script builds and deploys the React frontend with nginx

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}🚀 Document Query Service Frontend Deployment${NC}"
echo "=============================================="

# Check if we're in the right directory
if [ ! -f "package.json" ]; then
    echo -e "${RED}❌ Error: package.json not found. Please run this script from the frontend-react directory${NC}"
    exit 1
fi

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo -e "${RED}❌ Error: Docker is not running. Please start Docker and try again${NC}"
    exit 1
fi

echo -e "${YELLOW}📋 Pre-deployment checks...${NC}"

# Security audit
echo "🔒 Running security audit..."
yarn audit || echo -e "${YELLOW}⚠️  Security audit found issues. Review before production deployment${NC}"

# Lint check
echo "🔍 Running linter..."
yarn lint

echo -e "${YELLOW}🏗️  Building application...${NC}"

# Clean previous build
if [ -d "dist" ]; then
    echo "🧹 Cleaning previous build..."
    rm -rf dist
fi

# Build the React application
echo "⚛️  Building React application..."
yarn build

# Verify build was successful
if [ ! -d "dist" ]; then
    echo -e "${RED}❌ Build failed - dist directory not found${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Build completed successfully${NC}"

echo -e "${YELLOW}🐳 Building Docker image...${NC}"

# Build Docker image
docker build -t docqueryservice-frontend:latest .

echo -e "${GREEN}✅ Docker image built successfully${NC}"

# Ask user about deployment method
echo -e "${YELLOW}📦 Choose deployment method:${NC}"
echo "1) Docker Compose (with backend)"
echo "2) Docker run (frontend only)"
echo "3) Build only (no deployment)"
read -p "Enter choice [1-3]: " choice

case $choice in
    1)
        echo -e "${YELLOW}🚀 Deploying with Docker Compose...${NC}"
        docker-compose down --remove-orphans 2>/dev/null || true
        docker-compose up -d --build
        echo -e "${GREEN}✅ Deployment complete!${NC}"
        echo "🌐 Frontend: http://localhost:3000"
        echo "🔧 Backend: http://localhost:5000"
        ;;
    2)
        echo -e "${YELLOW}🚀 Deploying frontend only...${NC}"
        docker stop docqueryservice-frontend 2>/dev/null || true
        docker rm docqueryservice-frontend 2>/dev/null || true
        docker run -d --name docqueryservice-frontend -p 3000:80 docqueryservice-frontend:latest
        echo -e "${GREEN}✅ Frontend deployment complete!${NC}"
        echo "🌐 Frontend: http://localhost:3000"
        echo -e "${YELLOW}⚠️  Note: You'll need to start the backend separately${NC}"
        ;;
    3)
        echo -e "${GREEN}✅ Build complete - ready for deployment${NC}"
        echo "Docker image: docqueryservice-frontend:latest"
        ;;
    *)
        echo -e "${RED}❌ Invalid choice${NC}"
        exit 1
        ;;
esac

echo ""
echo -e "${GREEN}🎉 Deployment script completed!${NC}"
echo "📚 For more information, see the README.md file"