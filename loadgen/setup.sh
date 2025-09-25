#!/bin/bash
# Setup script for the load generator

set -e

echo "🚀 Setting up Document Query Service Load Generator..."

# Check if Python 3 is available
if ! command -v python3 &> /dev/null; then
    echo "❌ Python 3 is required but not installed"
    exit 1
fi

echo "✓ Python 3 found: $(python3 --version)"

# Create virtual environment if it doesn't exist
if [ ! -d "venv" ]; then
    echo "📦 Creating virtual environment..."
    python3 -m venv venv
fi

# Activate virtual environment
echo "🔧 Activating virtual environment..."
source venv/bin/activate

# Install dependencies
echo "📥 Installing Python dependencies..."
pip install --upgrade pip
pip install -r requirements.txt

# Install Playwright browsers
echo "🌐 Installing Playwright browsers..."
playwright install chromium

echo "✅ Setup complete!"
echo ""
echo "To use the load generator:"
echo "  source venv/bin/activate"
echo "  python load_generator.py -h localhost:5173 --rpm 60 --sessions 5"
echo ""
echo "To run with custom settings:"
echo "  python load_generator.py -h myapp.com --rpm 120 --sessions 10 --otlp-endpoint http://otel-collector:4317"