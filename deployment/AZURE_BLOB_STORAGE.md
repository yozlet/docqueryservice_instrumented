# Azure Blob Storage Setup Guide

This guide explains how to set up Azure Blob Storage for the Document Query Service PDF downloader.

## Overview

The PDF downloader supports two storage backends:

- **Local Storage** (default): Files stored on local filesystem
- **Azure Blob Storage**: Files stored in Azure cloud storage

## Quick Setup

### Option 1: Automated Setup (Recommended)

Use the provided setup script:

```bash
./deployment/setup-azure-storage.sh
```

This interactive script will:

1. ✅ Check Azure CLI installation and login status
2. 🏗️ Create resource group (if needed)
3. 💾 Create storage account with secure defaults
4. 📁 Create blob container for PDFs
5. 📋 Generate configuration for your `azure.env` file

### Option 2: Manual Setup

1. **Create Storage Account**:

```bash
az storage account create \
  --name "your-storage-account" \
  --resource-group "your-resource-group" \
  --location "eastus" \
  --sku Standard_LRS \
  --access-tier Hot \
  --kind StorageV2 \
  --https-only true \
  --allow-blob-public-access false
```

2. **Create Container**:

```bash
az storage container create \
  --name "pdfs" \
  --account-name "your-storage-account" \
  --public-access off
```

3. **Get Connection String**:

```bash
az storage account show-connection-string \
  --name "your-storage-account" \
  --resource-group "your-resource-group"
```

## Configuration

### Environment Variables

Add these to your `deployment/azure.env` file:

```bash
# Azure Blob Storage Configuration
AZURE_STORAGE_ACCOUNT_NAME=your-storage-account
AZURE_STORAGE_CONTAINER_NAME=pdfs
AZURE_STORAGE_SKU=Standard_LRS
AZURE_STORAGE_ACCESS_TIER=Hot
AZURE_STORAGE_CONNECTION_STRING="DefaultEndpointsProtocol=https;AccountName=..."

# PDF Downloader Configuration
PDF_STORAGE_TYPE=azure_blob
PDF_STORAGE_CONTAINER=pdfs
PDF_STORAGE_CREATE_CONTAINER=true
```

### Deployment Integration

The Azure deployment script (`deploy-azure.sh`) automatically:

- ✅ Creates storage account and container
- 🔗 Retrieves and configures connection string
- ⚙️ Sets up App Service environment variables
- 📝 Updates your `azure.env` file

Enable storage creation in `azure.env`:

```bash
CREATE_STORAGE_ACCOUNT=true
```

## Usage

### With PDF Downloader

**Local Development**:

```bash
python scripts/pdf_downloader.py sample_data.sql \
  --storage azure_blob \
  --azure-connection-string "DefaultEndpointsProtocol=https;..." \
  --azure-container "pdfs"
```

**Production Deployment**:
The deployed App Service automatically uses Azure Blob Storage when configured.

### Storage Account Naming

Azure Storage Account names must be:

- ✅ **3-24 characters long**
- ✅ **Lowercase letters and numbers only**
- ✅ **Globally unique across all Azure**

Examples:

- ✅ `docquerystorage2024`
- ✅ `mycompanydocs`
- ❌ `DocQuery-Storage` (uppercase, hyphens)
- ❌ `my_docs` (underscores)

## Security Features

The setup includes security best practices:

- 🔒 **HTTPS Only**: All connections encrypted
- 🚫 **No Public Access**: Blobs not publicly accessible
- 🔐 **Private Containers**: Container access requires authentication
- 🛡️ **Connection String Auth**: Secure access via connection strings

## Cost Optimization

### Storage Tiers

- **Hot**: Frequently accessed files (default for PDFs)
- **Cool**: Infrequently accessed files (30+ days)
- **Archive**: Rarely accessed files (180+ days)

### SKU Options

- **Standard_LRS**: Locally redundant (lowest cost)
- **Standard_GRS**: Geo-redundant (higher availability)
- **Premium_LRS**: SSD storage (better performance)

### Cost Estimates

For 1000 PDFs (~500MB total):

- **Storage**: ~$0.02/month (Standard_LRS, Hot)
- **Transactions**: ~$0.01/month (read/write operations)
- **Bandwidth**: Varies by usage

## Troubleshooting

### Common Issues

**Storage account name taken**:

```
Storage account name must be globally unique. Try adding numbers or your company name.
```

**Connection string not working**:

```bash
# Verify connection string
az storage account show-connection-string --name "your-account" --resource-group "your-rg"
```

**Container access denied**:

```bash
# Check container exists and permissions
az storage container show --name "pdfs" --connection-string "your-connection-string"
```

### Verification Commands

**Test storage account**:

```bash
az storage account show --name "your-storage-account" --resource-group "your-rg"
```

**List containers**:

```bash
az storage container list --connection-string "your-connection-string"
```

**Upload test file**:

```bash
echo "test" > test.txt
az storage blob upload --file test.txt --name test.txt --container-name pdfs --connection-string "your-connection-string"
```

## Integration with Deployment

The Azure deployment process automatically:

1. **Creates Infrastructure**: Storage account, container, firewall rules
2. **Configures App Service**: Sets environment variables for blob storage
3. **Updates Configuration**: Saves connection string to `azure.env`
4. **Validates Setup**: Ensures all resources are properly configured

Run full deployment:

```bash
./deployment/deploy-azure.sh
```

Or storage only:

```bash
./deployment/deploy-azure.sh --skip-build --skip-infrastructure
```

## Next Steps

After setup:

1. ✅ Test PDF downloader with Azure Blob Storage
2. 📊 Monitor storage usage in Azure Portal
3. 🔧 Adjust access tiers based on usage patterns
4. 📈 Scale storage account as needed

For more information, see:

- [Azure Blob Storage Documentation](https://docs.microsoft.com/en-us/azure/storage/blobs/)
- [PDF Downloader Documentation](../scripts/STORAGE_README.md)
- [Deployment Guide](AZURE_DEPLOYMENT.md)

