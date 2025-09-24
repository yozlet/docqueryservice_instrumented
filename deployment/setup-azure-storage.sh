#!/bin/bash

# Azure Blob Storage Setup Helper
# Helps configure Azure Blob Storage for the PDF downloader

set -e

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log() {
    echo -e "${GREEN}[$(date +'%Y-%m-%d %H:%M:%S')] $1${NC}"
}

info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

warn() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

echo "🌟 Azure Blob Storage Setup Helper 🌟"
echo "======================================"
echo ""

# Check if Azure CLI is installed
if ! command -v az &> /dev/null; then
    echo "❌ Azure CLI is required but not installed"
    echo "Install from: https://docs.microsoft.com/en-us/cli/azure/install-azure-cli"
    exit 1
fi

# Check if logged in
if ! az account show &> /dev/null; then
    echo "❌ Please log in to Azure CLI first:"
    echo "   az login"
    exit 1
fi

# Get current subscription info
SUBSCRIPTION_INFO=$(az account show --query '{name:name, id:id}' -o tsv)
SUBSCRIPTION_NAME=$(echo "$SUBSCRIPTION_INFO" | cut -f1)
SUBSCRIPTION_ID=$(echo "$SUBSCRIPTION_INFO" | cut -f2)

log "Current Azure Subscription: $SUBSCRIPTION_NAME ($SUBSCRIPTION_ID)"
echo ""

# Prompt for configuration
echo "📝 Please provide the following information:"
echo ""

read -p "🏷️  Resource Group Name (default: docquery-rg): " RESOURCE_GROUP
RESOURCE_GROUP=${RESOURCE_GROUP:-docquery-rg}

read -p "🌍 Azure Region (default: eastus): " LOCATION
LOCATION=${LOCATION:-eastus}

read -p "💾 Storage Account Name (must be globally unique, 3-24 chars, lowercase/numbers only): " STORAGE_ACCOUNT
while [[ -z "$STORAGE_ACCOUNT" || ${#STORAGE_ACCOUNT} -lt 3 || ${#STORAGE_ACCOUNT} -gt 24 || ! "$STORAGE_ACCOUNT" =~ ^[a-z0-9]+$ ]]; do
    warn "Storage account name must be 3-24 characters, lowercase letters and numbers only"
    read -p "💾 Storage Account Name: " STORAGE_ACCOUNT
done

read -p "📁 Container Name (default: pdfs): " CONTAINER_NAME
CONTAINER_NAME=${CONTAINER_NAME:-pdfs}

read -p "⚡ Storage SKU (Standard_LRS/Standard_GRS/Premium_LRS, default: Standard_LRS): " STORAGE_SKU
STORAGE_SKU=${STORAGE_SKU:-Standard_LRS}

read -p "🌡️  Access Tier (Hot/Cool, default: Hot): " ACCESS_TIER
ACCESS_TIER=${ACCESS_TIER:-Hot}

echo ""
log "Configuration Summary:"
echo "  📍 Resource Group: $RESOURCE_GROUP"
echo "  🌍 Location: $LOCATION"
echo "  💾 Storage Account: $STORAGE_ACCOUNT"
echo "  📁 Container: $CONTAINER_NAME"
echo "  ⚡ SKU: $STORAGE_SKU"
echo "  🌡️  Access Tier: $ACCESS_TIER"
echo ""

read -p "🚀 Proceed with creation? (y/N): " CONFIRM
if [[ ! "$CONFIRM" =~ ^[Yy]$ ]]; then
    echo "❌ Setup cancelled"
    exit 0
fi

echo ""
log "Creating Azure Blob Storage resources..."

# Create resource group if it doesn't exist
log "Checking/creating resource group: $RESOURCE_GROUP"
if az group show --name "$RESOURCE_GROUP" &>/dev/null; then
    info "Resource group $RESOURCE_GROUP already exists"
else
    az group create --name "$RESOURCE_GROUP" --location "$LOCATION" --output table
    log "Resource group created: $RESOURCE_GROUP"
fi

# Create storage account
log "Creating storage account: $STORAGE_ACCOUNT"
if az storage account show --name "$STORAGE_ACCOUNT" --resource-group "$RESOURCE_GROUP" &>/dev/null; then
    warn "Storage account $STORAGE_ACCOUNT already exists"
else
    az storage account create \
        --name "$STORAGE_ACCOUNT" \
        --resource-group "$RESOURCE_GROUP" \
        --location "$LOCATION" \
        --sku "$STORAGE_SKU" \
        --access-tier "$ACCESS_TIER" \
        --kind StorageV2 \
        --https-only true \
        --allow-blob-public-access false \
        --output table
    log "Storage account created: $STORAGE_ACCOUNT"
fi

# Get connection string
log "Retrieving connection string..."
CONNECTION_STRING=$(az storage account show-connection-string \
    --name "$STORAGE_ACCOUNT" \
    --resource-group "$RESOURCE_GROUP" \
    --query connectionString \
    --output tsv)

# Create container
log "Creating container: $CONTAINER_NAME"
if az storage container show --name "$CONTAINER_NAME" --connection-string "$CONNECTION_STRING" &>/dev/null; then
    warn "Container $CONTAINER_NAME already exists"
else
    az storage container create \
        --name "$CONTAINER_NAME" \
        --connection-string "$CONNECTION_STRING" \
        --public-access off \
        --output table
    log "Container created: $CONTAINER_NAME"
fi

echo ""
log "✅ Azure Blob Storage setup complete!"
echo ""
echo "📋 Configuration for your azure.env file:"
echo "=========================================="
echo "AZURE_STORAGE_ACCOUNT_NAME=$STORAGE_ACCOUNT"
echo "AZURE_STORAGE_CONTAINER_NAME=$CONTAINER_NAME"
echo "AZURE_STORAGE_SKU=$STORAGE_SKU"
echo "AZURE_STORAGE_ACCESS_TIER=$ACCESS_TIER"
echo "AZURE_STORAGE_CONNECTION_STRING=\"$CONNECTION_STRING\""
echo "PDF_STORAGE_TYPE=azure_blob"
echo "PDF_STORAGE_CONTAINER=$CONTAINER_NAME"
echo "PDF_STORAGE_CREATE_CONTAINER=true"
echo ""
echo "🔧 Usage with PDF Downloader:"
echo "=============================="
echo "python scripts/pdf_downloader.py sample_data.sql \\"
echo "  --storage azure_blob \\"
echo "  --azure-connection-string \"$CONNECTION_STRING\" \\"
echo "  --azure-container \"$CONTAINER_NAME\""
echo ""
log "Copy the configuration above to your deployment/azure.env file"

