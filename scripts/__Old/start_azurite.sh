#!/bin/bash
# Start Azurite for local blob storage development

echo "🔵 Starting Azurite blob storage emulator..."

# Check if Azurite is installed
if ! command -v azurite &> /dev/null; then
    echo "❌ Azurite not found. Installing..."
    npm install -g azurite
fi

# Create azurite data directory
mkdir -p ./azurite_data

# Start Azurite
echo "🚀 Starting Azurite on http://127.0.0.1:10000"
echo "   📁 Data directory: ./azurite_data"
echo "   🔑 Account: devstoreaccount1"
echo "   📦 Default container: pdfs"
echo ""
echo "Press Ctrl+C to stop Azurite"
echo ""

azurite --silent --location ./azurite_data --debug ./azurite_data/debug.log
