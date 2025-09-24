#!/bin/bash

# Multi-environment deployment script for Document Query Service
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
ENVIRONMENT=""
DRY_RUN=false
HELP=false

while [[ $# -gt 0 ]]; do
    case $1 in
        -e|--environment)
            ENVIRONMENT="$2"
            shift 2
            ;;
        --dry-run)
            DRY_RUN=true
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
Usage: $0 -e|--environment ENV [--dry-run] [-h|--help]

Deploy Document Query Service to specified environment

Environments:
  local       - Local Docker Compose deployment
  azure       - Azure App Services deployment
  aws         - AWS ECS/EKS deployment
  gcp         - Google Cloud Run deployment

Options:
  -e, --environment ENV  Target deployment environment (required)
  --dry-run             Show what would be deployed without executing
  -h, --help            Show this help message

Examples:
  $0 -e local
  $0 -e azure --dry-run
  $0 -e aws
EOF
    exit 0
fi

# Validate environment
if [ -z "$ENVIRONMENT" ]; then
    error "Environment is required. Use -e or --environment to specify."
    echo "Available environments: local, azure, aws, gcp"
    exit 1
fi

case $ENVIRONMENT in
    local|azure|aws|gcp)
        log "Deploying to environment: $ENVIRONMENT"
        ;;
    *)
        error "Invalid environment: $ENVIRONMENT"
        echo "Available environments: local, azure, aws, gcp"
        exit 1
        ;;
esac

# Load environment configuration
ENV_FILE="$ENVIRONMENT.env"
if [ -f "$ENV_FILE" ]; then
    log "Loading environment configuration from $ENV_FILE"
    if [ "$DRY_RUN" = false ]; then
        export $(grep -v '^#' "$ENV_FILE" | xargs)
    else
        log "DRY RUN: Would load environment variables from $ENV_FILE"
    fi
else
    warn "Environment file $ENV_FILE not found. Using defaults."
fi

# Deployment functions
deploy_local() {
    log "Deploying to local Docker Compose..."

    if [ "$DRY_RUN" = true ]; then
        log "DRY RUN: Would execute:"
        echo "  cd ../frontend-react"
        echo "  docker-compose -f docker-compose.yml build"
        echo "  docker-compose -f docker-compose.yml up -d"
        echo "  docker-compose ps"
        return 0
    fi

    cd ../frontend-react
    docker-compose -f docker-compose.yml build
    docker-compose -f docker-compose.yml up -d

    log "Local deployment complete!"
    echo "Frontend: http://localhost:3000"
    echo "Backend: http://localhost:5001"

    docker-compose ps
}

deploy_azure() {
    log "Deploying to Azure..."

    if [ "$DRY_RUN" = true ]; then
        log "DRY RUN: Would execute Azure deployment commands"
        echo "  Container deployment: az webapp config container set --docker-custom-image-name"
        echo "  Non-container deployment: ./deploy-azure.sh"
        return 0
    fi

    # Check if user wants container or non-container deployment
    echo "Azure deployment options:"
    echo "1. Container deployment (Docker images to Azure Container Registry)"
    echo "2. Azure deployment (App Service + SQL Database, no containers)"
    echo ""
    read -p "Choose deployment method (1 or 2): " choice

    case $choice in
        1)
            deploy_azure_containers
            ;;
        2)
            deploy_azure_appservice
            ;;
        *)
            error "Invalid choice. Please select 1 or 2."
            exit 1
            ;;
    esac
}

deploy_azure_containers() {
    log "Deploying to Azure with containers..."
    
    # Azure container deployment would typically involve:
    # 1. Building container images
    # 2. Pushing to Azure Container Registry
    # 3. Updating App Service configuration
    # 4. Deploying containers

    error "Azure container deployment not yet implemented"
    echo "To implement Azure container deployment:"
    echo "1. Set up Azure Container Registry"
    echo "2. Configure Azure App Services for containers"
    echo "3. Set up Azure SQL Database"
    echo "4. Configure environment variables in Azure"
    exit 1
}

deploy_azure_appservice() {
    log "Deploying to Azure (App Service + SQL Database)..."
    
    # Use the dedicated Azure deployment script
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    AZURE_SCRIPT="$SCRIPT_DIR/deploy-azure.sh"
    
    if [ ! -f "$AZURE_SCRIPT" ]; then
        error "Azure deployment script not found: $AZURE_SCRIPT"
        exit 1
    fi
    
    log "Executing Azure deployment script..."
    "$AZURE_SCRIPT"
}

deploy_aws() {
    log "Deploying to AWS..."

    if [ "$DRY_RUN" = true ]; then
        log "DRY RUN: Would execute AWS deployment commands"
        echo "  aws ecs update-service --force-new-deployment"
        echo "  aws elbv2 modify-target-group --health-check-path /health"
        return 0
    fi

    error "AWS deployment not yet implemented"
    echo "To implement AWS deployment:"
    echo "1. Set up ECS cluster or EKS cluster"
    echo "2. Configure Application Load Balancer"
    echo "3. Set up RDS database"
    echo "4. Configure AWS Secrets Manager"
    exit 1
}

deploy_gcp() {
    log "Deploying to Google Cloud..."

    if [ "$DRY_RUN" = true ]; then
        log "DRY RUN: Would execute GCP deployment commands"
        echo "  gcloud run deploy docquery-frontend --image gcr.io/PROJECT/frontend"
        echo "  gcloud run deploy docquery-backend --image gcr.io/PROJECT/backend"
        return 0
    fi

    error "GCP deployment not yet implemented"
    echo "To implement GCP deployment:"
    echo "1. Set up Cloud Run services"
    echo "2. Configure Cloud SQL"
    echo "3. Set up Secret Manager"
    echo "4. Configure Cloud Load Balancer"
    exit 1
}

# Validate configuration
validate_config() {
    log "Validating configuration..."

    case $ENVIRONMENT in
        local)
            # Local validation
            if ! command -v docker &> /dev/null; then
                error "Docker is required for local deployment"
                exit 1
            fi

            if ! command -v docker-compose &> /dev/null; then
                error "Docker Compose is required for local deployment"
                exit 1
            fi
            ;;
        azure)
            if [ -z "$FRONTEND_DOMAIN" ]; then
                warn "FRONTEND_DOMAIN not set - using defaults"
            fi
            ;;
        aws)
            if [ -z "$AWS_REGION" ]; then
                warn "AWS_REGION not set - using defaults"
            fi
            ;;
    esac

    log "Configuration validation complete"
}

# Main deployment flow
main() {
    log "Starting deployment for environment: $ENVIRONMENT"

    validate_config

    case $ENVIRONMENT in
        local)
            deploy_local
            ;;
        azure)
            deploy_azure
            ;;
        aws)
            deploy_aws
            ;;
        gcp)
            deploy_gcp
            ;;
    esac

    log "Deployment completed successfully!"
}

# Execute main function
main