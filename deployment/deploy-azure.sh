#!/bin/bash

# Azure Deployment Script (Non-Container)
# Deploys .NET backend to Azure App Service and sets up Azure SQL Database
# Supports both infrastructure creation and application deployment

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Functions
log() {
    echo -e "${GREEN}[$(date +'%Y-%m-%d %H:%M:%S')] $1${NC}"
}

warn() {
    echo -e "${YELLOW}[$(date +'%Y-%m-%d %H:%M:%S')] WARNING: $1${NC}"
}

error() {
    echo -e "${RED}[$(date +'%Y-%m-%d %H:%M:%S')] ERROR: $1${NC}" >&2
}

# Parse command line arguments
DRY_RUN=false
HELP=false
SKIP_BUILD=false
SKIP_INFRASTRUCTURE=false

while [[ $# -gt 0 ]]; do
    case $1 in
        --dry-run)
            DRY_RUN=true
            shift
            ;;
        --skip-build)
            SKIP_BUILD=true
            shift
            ;;
        --skip-infrastructure)
            SKIP_INFRASTRUCTURE=true
            shift
            ;;
        -h|--help)
            HELP=true
            shift
            ;;
        *)
            error "Unknown argument: $1"
            HELP=true
            shift
            ;;
    esac
done

# Show help
if [ "$HELP" = true ]; then
    cat << EOF
Usage: $0 [--dry-run] [--skip-build] [--skip-infrastructure] [-h|--help]

Deploy .NET backend to Azure with App Service, PostgreSQL Database, and Blob Storage (non-container deployment)

Options:
  --dry-run              Show what would be deployed without executing
  --skip-build           Skip the dotnet build and publish steps
  --skip-infrastructure  Skip Azure resource creation/configuration
  -h, --help            Show this help message

Prerequisites:
  - Azure CLI installed and logged in (az login)
  - .NET 9.0 SDK installed
  - Proper configuration in deployment/azure.env

Azure Resources Created:
  - App Service Plan (configurable SKU)
  - App Service (with .NET 9.0 runtime)
  - Azure Database for PostgreSQL (configurable tier)
  - Azure Blob Storage Account (for PDF storage)
  - Blob Container (for document files)

Configuration:
  Copy deployment/azure.env.template to deployment/azure.env and customize:
  - Azure subscription and resource group settings
  - PostgreSQL Database configuration
  - Blob Storage settings (account name, container, SKU)
  - OpenTelemetry/Honeycomb monitoring setup

Examples:
  $0                           # Full deployment with all resources
  $0 --dry-run                 # Preview deployment without changes
  $0 --skip-infrastructure     # Deploy app only (resources exist)
  $0 --skip-build             # Deploy without rebuilding app
EOF
    exit 0
fi

# Load environment configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
ENV_FILE="$SCRIPT_DIR/azure.env"

if [ -f "$ENV_FILE" ]; then
    log "Loading environment configuration from $ENV_FILE"
    if [ "$DRY_RUN" = false ]; then
        export $(grep -v '^#' "$ENV_FILE" | grep -v '^$' | xargs)
    else
        log "DRY RUN: Would load environment variables from $ENV_FILE"
    fi
else
    error "Environment file $ENV_FILE not found!"
    echo "Please create the environment file with your Azure configuration."
    exit 1
fi

# Validate required variables
validate_config() {
    log "Validating configuration..."
    
    local required_vars=(
        "AZURE_SUBSCRIPTION_ID"
        "AZURE_RESOURCE_GROUP" 
        "AZURE_APP_NAME"
        "AZURE_LOCATION"
    )
    
    # Add PostgreSQL-specific variables if creating Azure PostgreSQL
    if [ "${CREATE_AZURE_POSTGRES:-true}" = "true" ]; then
        required_vars+=(
            "AZURE_POSTGRES_SERVER_NAME"
            "AZURE_POSTGRES_DATABASE_NAME"
            "AZURE_POSTGRES_ADMIN_USER"
            "AZURE_POSTGRES_ADMIN_PASSWORD"
        )
    fi
    
    # Add Storage-specific variables if creating Azure Blob Storage
    if [ "${CREATE_STORAGE_ACCOUNT:-true}" = "true" ]; then
        required_vars+=(
            "AZURE_STORAGE_ACCOUNT_NAME"
            "AZURE_STORAGE_CONTAINER_NAME"
        )
    fi
    
    for var in "${required_vars[@]}"; do
        if [ -z "${!var}" ]; then
            error "Required environment variable $var is not set"
            exit 1
        fi
    done
    
    # Check Azure CLI
    if ! command -v az &> /dev/null; then
        error "Azure CLI is required but not installed"
        echo "Install from: https://docs.microsoft.com/en-us/cli/azure/install-azure-cli"
        exit 1
    fi
    
    # Check .NET CLI
    if ! command -v dotnet &> /dev/null; then
        error ".NET CLI is required but not installed"
        echo "Install from: https://dotnet.microsoft.com/download"
        exit 1
    fi
    
    # Check Azure login status
    if ! az account show &> /dev/null; then
        error "Not logged in to Azure CLI. Run 'az login' first."
        exit 1
    fi
    
    log "Configuration validation complete"
}

# Create Azure infrastructure
create_infrastructure() {
    if [ "$SKIP_INFRASTRUCTURE" = true ]; then
        log "Skipping infrastructure creation"
        return 0
    fi
    
    log "Creating/updating Azure infrastructure..."
    
    if [ "$DRY_RUN" = true ]; then
        log "DRY RUN: Would create Azure resources:"
        echo "  Resource Group: $AZURE_RESOURCE_GROUP"
        echo "  App Service Plan: $AZURE_APP_SERVICE_PLAN"
        echo "  App Service: $AZURE_APP_NAME"
        echo "  Location: $AZURE_LOCATION"
        return 0
    fi
    
    # Set subscription
    az account set --subscription "$AZURE_SUBSCRIPTION_ID"
    
    # Create resource group if requested
    if [ "${CREATE_RESOURCE_GROUP:-true}" = "true" ]; then
        log "Creating resource group: $AZURE_RESOURCE_GROUP"
        if az group show --name "$AZURE_RESOURCE_GROUP" &>/dev/null; then
            log "Resource group $AZURE_RESOURCE_GROUP already exists, skipping creation"
        else
            az group create \
                --name "$AZURE_RESOURCE_GROUP" \
                --location "$AZURE_LOCATION" \
                --output table
        fi
    else
        log "Skipping resource group creation (using existing resource group)"
        # Verify the resource group exists
        if ! az group show --name "$AZURE_RESOURCE_GROUP" &>/dev/null; then
            error "Resource group $AZURE_RESOURCE_GROUP does not exist. Set CREATE_RESOURCE_GROUP=true to create it."
            exit 1
        fi
        log "Using existing resource group: $AZURE_RESOURCE_GROUP"
    fi
    
    # Create App Service Plan (Linux, .NET 9.0 support)
    if [ "${CREATE_APP_SERVICE_PLAN:-true}" = "true" ]; then
        log "Creating App Service Plan: $AZURE_APP_SERVICE_PLAN"
        if az appservice plan show --name "$AZURE_APP_SERVICE_PLAN" --resource-group "$AZURE_RESOURCE_GROUP" &>/dev/null; then
            log "App Service Plan $AZURE_APP_SERVICE_PLAN already exists, skipping creation"
        else
            az appservice plan create \
                --name "$AZURE_APP_SERVICE_PLAN" \
                --resource-group "$AZURE_RESOURCE_GROUP" \
                --location "$AZURE_LOCATION" \
                --sku "${AZURE_SKU:-B1}" \
                --is-linux \
                --output table
        fi
    else
        log "Skipping App Service Plan creation (using existing plan)"
        # Only verify App Service Plan exists if we're creating an App Service
        if [ "${CREATE_APP_SERVICE:-true}" = "true" ]; then
            if ! az appservice plan show --name "$AZURE_APP_SERVICE_PLAN" --resource-group "$AZURE_RESOURCE_GROUP" &>/dev/null; then
                error "App Service Plan $AZURE_APP_SERVICE_PLAN does not exist. Set CREATE_APP_SERVICE_PLAN=true to create it."
                exit 1
            fi
            log "Using existing App Service Plan: $AZURE_APP_SERVICE_PLAN"
        fi
    fi
    
    # Create App Service if requested
    if [ "${CREATE_APP_SERVICE:-true}" = "true" ]; then
        log "Creating App Service: $AZURE_APP_NAME"
        if az webapp show --name "$AZURE_APP_NAME" --resource-group "$AZURE_RESOURCE_GROUP" &>/dev/null; then
            log "App Service $AZURE_APP_NAME already exists, skipping creation"
        else
            az webapp create \
                --name "$AZURE_APP_NAME" \
                --resource-group "$AZURE_RESOURCE_GROUP" \
                --plan "$AZURE_APP_SERVICE_PLAN" \
                --runtime "DOTNET|9.0" \
                --output table
        fi
    else
        log "Skipping App Service creation (CREATE_APP_SERVICE=false)"
    fi
    
    # Create Azure Database for PostgreSQL if requested
    if [ "${CREATE_AZURE_POSTGRES:-true}" = "true" ]; then
        create_azure_postgres
    else
        log "Skipping Azure PostgreSQL creation (using existing database)"
    fi
    
    # Create Azure Blob Storage if requested
    if [ "${CREATE_STORAGE_ACCOUNT:-true}" = "true" ]; then
        create_azure_storage
    else
        log "Skipping Azure Storage creation (using existing storage account)"
    fi
    
    log "Infrastructure creation complete"
}

# Create Azure Database for PostgreSQL
create_azure_postgres() {
    log "Creating Azure Database for PostgreSQL infrastructure..."
    
    if [ "$DRY_RUN" = true ]; then
        log "DRY RUN: Would create Azure PostgreSQL resources:"
        echo "  PostgreSQL Server: $AZURE_POSTGRES_SERVER_NAME"
        echo "  Database: $AZURE_POSTGRES_DATABASE_NAME"
        echo "  Admin User: $AZURE_POSTGRES_ADMIN_USER"
        echo "  SKU: $AZURE_POSTGRES_SKU"
        echo "  Version: $AZURE_POSTGRES_VERSION"
        return 0
    fi
    
    # Create PostgreSQL Server
    log "Creating Azure Database for PostgreSQL server: $AZURE_POSTGRES_SERVER_NAME"
    if az postgres flexible-server show --name "$AZURE_POSTGRES_SERVER_NAME" --resource-group "$AZURE_RESOURCE_GROUP" &>/dev/null; then
        log "PostgreSQL server $AZURE_POSTGRES_SERVER_NAME already exists, skipping creation"
    else
        az postgres flexible-server create \
            --name "$AZURE_POSTGRES_SERVER_NAME" \
            --resource-group "$AZURE_RESOURCE_GROUP" \
            --location "$AZURE_LOCATION" \
            --admin-user "$AZURE_POSTGRES_ADMIN_USER" \
            --admin-password "$AZURE_POSTGRES_ADMIN_PASSWORD" \
            --sku-name "${AZURE_POSTGRES_SKU:-Standard_B1ms}" \
            --tier "${AZURE_POSTGRES_TIER:-Burstable}" \
            --version "${AZURE_POSTGRES_VERSION:-14}" \
            --storage-size "${AZURE_POSTGRES_STORAGE_SIZE:-32}" \
            --public-access 0.0.0.0 \
            --output table
    fi
    
    # Create Database
    log "Creating PostgreSQL database: $AZURE_POSTGRES_DATABASE_NAME"
    if az postgres flexible-server db show --server-name "$AZURE_POSTGRES_SERVER_NAME" --resource-group "$AZURE_RESOURCE_GROUP" --database-name "$AZURE_POSTGRES_DATABASE_NAME" &>/dev/null; then
        log "PostgreSQL database $AZURE_POSTGRES_DATABASE_NAME already exists, skipping creation"
    else
        az postgres flexible-server db create \
            --server-name "$AZURE_POSTGRES_SERVER_NAME" \
            --resource-group "$AZURE_RESOURCE_GROUP" \
            --database-name "$AZURE_POSTGRES_DATABASE_NAME" \
            --output table
    fi
    
    # Configure firewall rules
    if [ "${ENABLE_FIREWALL_RULES:-true}" = "true" ]; then
        log "Configuring PostgreSQL server firewall rules..."
        
        # Allow Azure services
        if az postgres flexible-server firewall-rule show --name "AllowAzureServices" --server-name "$AZURE_POSTGRES_SERVER_NAME" --resource-group "$AZURE_RESOURCE_GROUP" &>/dev/null; then
            log "Firewall rule 'AllowAzureServices' already exists, skipping creation"
        else
            az postgres flexible-server firewall-rule create \
                --name "AllowAzureServices" \
                --server-name "$AZURE_POSTGRES_SERVER_NAME" \
                --resource-group "$AZURE_RESOURCE_GROUP" \
                --start-ip-address 0.0.0.0 \
                --end-ip-address 0.0.0.0 \
                --output table
        fi
        
        log "PostgreSQL server firewall configured to allow Azure services"
    fi
    
    log "Azure Database for PostgreSQL setup complete"
}

# Create Azure Blob Storage Account and Container
create_azure_storage() {
    log "Creating Azure Blob Storage infrastructure..."
    
    if [ "$DRY_RUN" = true ]; then
        log "DRY RUN: Would create Azure Storage resources:"
        echo "  Storage Account: $AZURE_STORAGE_ACCOUNT_NAME"
        echo "  Container: $AZURE_STORAGE_CONTAINER_NAME"
        echo "  SKU: ${AZURE_STORAGE_SKU:-Standard_LRS}"
        echo "  Access Tier: ${AZURE_STORAGE_ACCESS_TIER:-Hot}"
        return 0
    fi
    
    # Create Storage Account
    log "Creating Azure Storage Account: $AZURE_STORAGE_ACCOUNT_NAME"
    if az storage account show --name "$AZURE_STORAGE_ACCOUNT_NAME" --resource-group "$AZURE_RESOURCE_GROUP" &>/dev/null; then
        log "Storage Account $AZURE_STORAGE_ACCOUNT_NAME already exists, skipping creation"
    else
        az storage account create \
            --name "$AZURE_STORAGE_ACCOUNT_NAME" \
            --resource-group "$AZURE_RESOURCE_GROUP" \
            --location "$AZURE_LOCATION" \
            --sku "${AZURE_STORAGE_SKU:-Standard_LRS}" \
            --access-tier "${AZURE_STORAGE_ACCESS_TIER:-Hot}" \
            --kind StorageV2 \
            --https-only true \
            --allow-blob-public-access false \
            --output table
    fi
    
    # Get storage account connection string
    log "Retrieving storage account connection string..."
    STORAGE_CONNECTION_STRING=$(az storage account show-connection-string \
        --name "$AZURE_STORAGE_ACCOUNT_NAME" \
        --resource-group "$AZURE_RESOURCE_GROUP" \
        --query connectionString \
        --output tsv)
    
    if [ -z "$STORAGE_CONNECTION_STRING" ]; then
        error "Failed to retrieve storage account connection string"
        exit 1
    fi
    
    # Create blob container if requested
    if [ "${PDF_STORAGE_CREATE_CONTAINER:-true}" = "true" ]; then
        log "Creating blob container: $AZURE_STORAGE_CONTAINER_NAME"
        if az storage container show --name "$AZURE_STORAGE_CONTAINER_NAME" --connection-string "$STORAGE_CONNECTION_STRING" &>/dev/null; then
            log "Container $AZURE_STORAGE_CONTAINER_NAME already exists, skipping creation"
        else
            az storage container create \
                --name "$AZURE_STORAGE_CONTAINER_NAME" \
                --connection-string "$STORAGE_CONNECTION_STRING" \
                --public-access off \
                --output table
        fi
    fi
    
    # Update environment file with connection string
    if [ -f "$ENV_FILE" ]; then
        log "Updating environment file with storage connection string..."
        # Use sed to update the connection string in the env file
        if grep -q "AZURE_STORAGE_CONNECTION_STRING=" "$ENV_FILE"; then
            # Update existing line
            sed -i.bak "s|AZURE_STORAGE_CONNECTION_STRING=.*|AZURE_STORAGE_CONNECTION_STRING=\"$STORAGE_CONNECTION_STRING\"|" "$ENV_FILE"
        else
            # Add new line
            echo "AZURE_STORAGE_CONNECTION_STRING=\"$STORAGE_CONNECTION_STRING\"" >> "$ENV_FILE"
        fi
        log "Environment file updated with storage connection string"
    fi
    
    # Export for use in app configuration
    export AZURE_STORAGE_CONNECTION_STRING="$STORAGE_CONNECTION_STRING"
    
    log "Azure Blob Storage setup complete"
    log "Storage Account: $AZURE_STORAGE_ACCOUNT_NAME"
    log "Container: $AZURE_STORAGE_CONTAINER_NAME"
    log "Connection string updated in: $ENV_FILE"
}

# Build and publish .NET application
build_application() {
    if [ "$SKIP_BUILD" = true ]; then
        log "Skipping application build"
        return 0
    fi
    
    log "Building .NET application..."
    
    BACKEND_DIR="$PROJECT_ROOT/backend-dotnet"
    PUBLISH_DIR="$BACKEND_DIR/bin/Release/net9.0/publish"
    
    if [ "$DRY_RUN" = true ]; then
        log "DRY RUN: Would build application:"
        echo "  cd $BACKEND_DIR"
        echo "  dotnet restore"
        echo "  dotnet build -c Release"
        echo "  dotnet publish -c Release -o $PUBLISH_DIR"
        return 0
    fi
    
    cd "$BACKEND_DIR"
    
    # Restore dependencies
    log "Restoring NuGet packages..."
    dotnet restore
    
    # Build application
    log "Building application in Release mode..."
    dotnet build -c Release --no-restore
    
    # Publish application
    log "Publishing application..."
    dotnet publish -c Release -o "$PUBLISH_DIR" --no-build
    
    log "Application build complete"
    cd "$SCRIPT_DIR"
}

# Configure App Service settings
configure_app_service() {
    log "Configuring App Service settings..."
    
    if [ "$DRY_RUN" = true ]; then
        log "DRY RUN: Would configure App Service settings:"
        echo "  Environment variables from $ENV_FILE"
        echo "  HTTPS redirection"
        echo "  Health check endpoint: /health"
        return 0
    fi
    
    # Configure environment variables
    log "Setting application configuration..."
    
    # Set basic ASP.NET Core settings
    az webapp config appsettings set \
        --name "$AZURE_APP_NAME" \
        --resource-group "$AZURE_RESOURCE_GROUP" \
        --settings \
            ASPNETCORE_ENVIRONMENT="$ASPNETCORE_ENVIRONMENT" \
            WEBSITES_ENABLE_APP_SERVICE_STORAGE=false \
            WEBSITES_PORT=5001 \
        --output table
    
    # Set database configuration
    if [ -n "$DATABASE_CONNECTION_STRING" ]; then
        az webapp config appsettings set \
            --name "$AZURE_APP_NAME" \
            --resource-group "$AZURE_RESOURCE_GROUP" \
            --settings DATABASE_CONNECTION_STRING="$DATABASE_CONNECTION_STRING" \
            --output table
    fi
    
    # Set OpenTelemetry configuration
    if [ -n "$OTEL_EXPORTER_OTLP_ENDPOINT" ]; then
        az webapp config appsettings set \
            --name "$AZURE_APP_NAME" \
            --resource-group "$AZURE_RESOURCE_GROUP" \
            --settings \
                OTEL_EXPORTER_OTLP_ENDPOINT="$OTEL_EXPORTER_OTLP_ENDPOINT" \
                OTEL_EXPORTER_OTLP_HEADERS="$OTEL_EXPORTER_OTLP_HEADERS" \
                OTEL_SERVICE_NAME="$OTEL_SERVICE_NAME" \
                OTEL_RESOURCE_ATTRIBUTES="$OTEL_RESOURCE_ATTRIBUTES" \
            --output table
    fi
    
    # Set Azure Blob Storage configuration
    if [ -n "$AZURE_STORAGE_CONNECTION_STRING" ]; then
        log "Configuring Azure Blob Storage settings..."
        az webapp config appsettings set \
            --name "$AZURE_APP_NAME" \
            --resource-group "$AZURE_RESOURCE_GROUP" \
            --settings \
                AZURE_STORAGE_CONNECTION_STRING="$AZURE_STORAGE_CONNECTION_STRING" \
                AZURE_STORAGE_CONTAINER_NAME="$AZURE_STORAGE_CONTAINER_NAME" \
                PDF_STORAGE_TYPE="$PDF_STORAGE_TYPE" \
                PDF_STORAGE_CONTAINER="$PDF_STORAGE_CONTAINER" \
            --output table
    fi
    
    # Enable HTTPS redirection
    log "Enabling HTTPS redirection..."
    az webapp update \
        --name "$AZURE_APP_NAME" \
        --resource-group "$AZURE_RESOURCE_GROUP" \
        --https-only true \
        --output table
    
    log "App Service configuration complete"
}

# Deploy application
deploy_application() {
    log "Deploying application to Azure App Service..."
    
    BACKEND_DIR="$PROJECT_ROOT/backend-dotnet"
    PUBLISH_DIR="$BACKEND_DIR/bin/Release/net9.0/publish"
    
    if [ "$DRY_RUN" = true ]; then
        log "DRY RUN: Would deploy application:"
        echo "  Source: $PUBLISH_DIR"
        echo "  Target: $AZURE_APP_NAME.azurewebsites.net"
        echo "  Method: ZIP deployment"
        return 0
    fi
    
    if [ ! -d "$PUBLISH_DIR" ]; then
        error "Published application not found at $PUBLISH_DIR"
        echo "Run without --skip-build to build the application first"
        exit 1
    fi
    
    # Create deployment package
    TEMP_ZIP="/tmp/docquery-deployment-$(date +%s).zip"
    log "Creating deployment package: $TEMP_ZIP"
    
    cd "$PUBLISH_DIR"
    zip -r "$TEMP_ZIP" . > /dev/null
    cd "$SCRIPT_DIR"
    
    # Deploy via ZIP
    log "Deploying to App Service..."
    az webapp deployment source config-zip \
        --name "$AZURE_APP_NAME" \
        --resource-group "$AZURE_RESOURCE_GROUP" \
        --src "$TEMP_ZIP" \
        --output table
    
    # Clean up
    rm "$TEMP_ZIP"
    
    log "Application deployment complete"
}

# Verify deployment
verify_deployment() {
    log "Verifying deployment..."
    
    APP_URL="https://$AZURE_APP_NAME.azurewebsites.net"
    HEALTH_URL="$APP_URL/health"
    
    if [ "$DRY_RUN" = true ]; then
        log "DRY RUN: Would verify deployment:"
        echo "  Health check: $HEALTH_URL"
        echo "  Application URL: $APP_URL"
        return 0
    fi
    
    # Wait for deployment to complete
    log "Waiting for application to start..."
    sleep 30
    
    # Check health endpoint
    log "Checking health endpoint: $HEALTH_URL"
    if curl -f -s "$HEALTH_URL" > /dev/null; then
        log "✅ Health check passed!"
        echo "Application is running at: $APP_URL"
        echo "Health check: $HEALTH_URL"
    else
        warn "Health check failed. Application may still be starting."
        echo "Check application logs in Azure Portal"
        echo "Application URL: $APP_URL"
    fi
}

# Update template file with current configuration
update_template_file() {
    local template_file="$SCRIPT_DIR/azure.env.template"
    
    if [ ! -f "$template_file" ]; then
        warn "Template file not found: $template_file"
        return 0
    fi
    
    log "Updating template file with current configuration..."
    
    # Get current year
    local current_year=$(date +%Y)
    
    # Update storage account name with current year if different
    if [ -n "$AZURE_STORAGE_ACCOUNT_NAME" ]; then
        local template_storage_name=$(grep "AZURE_STORAGE_ACCOUNT_NAME=" "$template_file" | cut -d'=' -f2)
        if [ "$template_storage_name" != "$AZURE_STORAGE_ACCOUNT_NAME" ]; then
            log "Updating template storage account name to match current config"
            sed -i.bak "s/AZURE_STORAGE_ACCOUNT_NAME=.*/AZURE_STORAGE_ACCOUNT_NAME=${AZURE_STORAGE_ACCOUNT_NAME}/" "$template_file"
        fi
    fi
    
    # Update PostgreSQL server name with current year if different
    if [ -n "$AZURE_POSTGRES_SERVER_NAME" ]; then
        local template_postgres_name=$(grep "AZURE_POSTGRES_SERVER_NAME=" "$template_file" | cut -d'=' -f2)
        if [[ "$template_postgres_name" != *"$current_year"* ]] && [[ "$AZURE_POSTGRES_SERVER_NAME" == *"$current_year"* ]]; then
            log "Updating template PostgreSQL server name to include current year"
            sed -i.bak "s/AZURE_POSTGRES_SERVER_NAME=.*/AZURE_POSTGRES_SERVER_NAME=${AZURE_POSTGRES_SERVER_NAME}/" "$template_file"
        fi
    fi
    
    # Update App Service name with current year if different
    if [ -n "$AZURE_APP_NAME" ]; then
        local template_app_name=$(grep "AZURE_APP_NAME=" "$template_file" | cut -d'=' -f2)
        if [[ "$template_app_name" != *"$current_year"* ]] && [[ "$AZURE_APP_NAME" == *"$current_year"* ]]; then
            log "Updating template app service name to include current year"
            sed -i.bak "s/AZURE_APP_NAME=.*/AZURE_APP_NAME=${AZURE_APP_NAME}/" "$template_file"
        fi
    fi
    
    # Ensure connection string is reset to placeholder in template
    if grep -q "AZURE_STORAGE_CONNECTION_STRING=" "$template_file"; then
        if ! grep -q "your-storage-connection-string-here" "$template_file"; then
            log "Resetting template connection string to placeholder"
            sed -i.bak 's|AZURE_STORAGE_CONNECTION_STRING=".*"|AZURE_STORAGE_CONNECTION_STRING="your-storage-connection-string-here"|' "$template_file"
        fi
    fi
    
    # Clean up backup file
    [ -f "$template_file.bak" ] && rm "$template_file.bak"
    
    log "Template file updated successfully"
}

# Main deployment flow
main() {
    log "Starting Azure App Service deployment (non-container)"
    
    validate_config
    create_infrastructure
    build_application
    
    # Only configure and deploy app service if requested
    if [ "${CREATE_APP_SERVICE:-true}" = "true" ]; then
        configure_app_service
        deploy_application
        verify_deployment
    else
        log "Skipping App Service configuration and deployment (CREATE_APP_SERVICE=false)"
    fi
    
    log "🎉 Deployment completed successfully!"
    echo ""
    
    # Show App Service URLs only if App Service was created
    if [ "${CREATE_APP_SERVICE:-true}" = "true" ]; then
        echo "Application URL: https://$AZURE_APP_NAME.azurewebsites.net"
        echo "Health Check: https://$AZURE_APP_NAME.azurewebsites.net/health"
    fi
    
    # Show created resources summary
    echo "📋 Created Resources:"
    [ "${CREATE_RESOURCE_GROUP:-true}" = "true" ] && echo "  ✅ Resource Group: $AZURE_RESOURCE_GROUP"
    [ "${CREATE_STORAGE_ACCOUNT:-true}" = "true" ] && echo "  ✅ Storage Account: $AZURE_STORAGE_ACCOUNT_NAME"
    [ "${CREATE_AZURE_POSTGRES:-true}" = "true" ] && echo "  ✅ PostgreSQL Server: $AZURE_POSTGRES_SERVER_NAME"
    [ "${CREATE_APP_SERVICE_PLAN:-true}" = "true" ] && echo "  ✅ App Service Plan: $AZURE_APP_SERVICE_PLAN"
    [ "${CREATE_APP_SERVICE:-true}" = "true" ] && echo "  ✅ App Service: $AZURE_APP_NAME"
    echo ""
    echo "Next steps:"
    echo "1. Configure your database connection string in Azure Portal"
    echo "2. Set up custom domain if needed"
    echo "3. Configure monitoring and alerts"
    echo "4. Set up CI/CD pipeline for automated deployments"
    
    # Update template file to keep it current
    update_template_file
}

# Execute main function
main
