# Deployment Configuration and Management

This directory contains deployment configurations and scripts for the Document Query Service across multiple environments and cloud providers.

## 🏗️ Architecture Overview

The Document Query Service is designed for **hybrid cloud deployment** where different components can run on different cloud providers:

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   React Frontend │    │  .NET Backend   │    │    Database     │
│   (Any Cloud)    │────│   (Azure)       │────│   (Azure SQL)   │
│   nginx + Docker │    │  App Service    │    │   or Any SQL    │
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │                        │                        │
         └────────────────────────┼────────────────────────┘
                                  │
              ┌─────────────────────────────────────┐
              │         Honeycomb.io                │
              │    (Observability Platform)         │
              └─────────────────────────────────────┘
```

## 🌍 Environment Configuration

### Environment Files

Each deployment environment has its own configuration:

- **`local.env`** - Local development with Docker Compose
- **`azure.env`** - Azure App Services deployment
- **`aws.env`** - AWS ECS/EKS deployment
- **`gcp.env`** - Google Cloud Run deployment

### Configuration Variables

#### Frontend Configuration
```bash
# React App Settings
VITE_ENVIRONMENT=production
VITE_API_BASE_URL=/api/v3
VITE_ENABLE_METRICS=true
VITE_HONEYCOMB_API_KEY=your-key
VITE_HONEYCOMB_DATASET=docquery-frontend-prod

# nginx Settings
NGINX_PORT=8080
SERVER_NAME=docquery.yourdomain.com
BACKEND_HOST=docquery-api.yourdomain.com
BACKEND_PORT=443
CORS_ORIGIN=https://docquery.yourdomain.com
```

#### Backend Configuration
```bash
# ASP.NET Core Settings
ASPNETCORE_ENVIRONMENT=Production
LISTEN_HOST=0.0.0.0
LISTEN_PORT=5001

# Database Settings
DATABASE_CONNECTION_STRING="Server=..."
# Or individual settings:
DB_SERVER=your-db-server.com
DB_PORT=1433
DB_DATABASE=DocQueryService
DB_USERNAME=admin
DB_PASSWORD=your-secure-password

# OpenTelemetry Settings
OTEL_EXPORTER_OTLP_ENDPOINT=https://api.honeycomb.io
OTEL_EXPORTER_OTLP_HEADERS="x-honeycomb-team=your-api-key"
OTEL_SERVICE_NAME=docquery-backend-prod
```

## 🚀 Deployment Methods

### 1. Automated Deployment Script

```bash
# Local deployment
./deploy.sh -e local

# Azure deployment (dry run)
./deploy.sh -e azure --dry-run

# AWS deployment
./deploy.sh -e aws

# Show help
./deploy.sh --help
```

### 2. Docker Compose Deployment

```bash
# Development
cd ../frontend-react
docker-compose -f docker-compose.yml up -d

# Production
cd ../deployment
docker-compose -f docker-compose.production.yml up -d
```

### 3. Manual Cloud Deployment

#### Azure App Services
```bash
# Build and push images
docker build -t your-registry.azurecr.io/docquery-frontend:latest ../frontend-react
docker build -t your-registry.azurecr.io/docquery-backend:latest ../backend-dotnet

# Push to Azure Container Registry
docker push your-registry.azurecr.io/docquery-frontend:latest
docker push your-registry.azurecr.io/docquery-backend:latest

# Deploy via Azure CLI
az webapp config container set --docker-custom-image-name your-registry.azurecr.io/docquery-frontend:latest
```

#### AWS ECS
```bash
# Build and push to ECR
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin your-account.dkr.ecr.us-east-1.amazonaws.com

docker build -t your-account.dkr.ecr.us-east-1.amazonaws.com/docquery-frontend:latest ../frontend-react
docker push your-account.dkr.ecr.us-east-1.amazonaws.com/docquery-frontend:latest

# Update ECS service
aws ecs update-service --cluster docquery-prod --service docquery-frontend --force-new-deployment
```

## 🔧 Configuration Management

### Environment Variable Hierarchy

1. **Cloud Provider Secrets** (highest priority)
   - Azure Key Vault
   - AWS Secrets Manager
   - Google Secret Manager

2. **Environment Files** (medium priority)
   - `.env.production`
   - `.env.staging`
   - `.env.local`

3. **Default Values** (lowest priority)
   - Built into application code

### Security Best Practices

1. **Never commit sensitive values** to version control
2. **Use cloud provider secret management** for production
3. **Rotate API keys and passwords** regularly
4. **Use least-privilege access** for all services
5. **Enable audit logging** for configuration changes

## 🌐 Multi-Cloud Deployment Scenarios

### Scenario 1: Azure + AWS Hybrid
```bash
# Frontend on AWS (CDN + S3)
FRONTEND_URL=https://d1234567890.cloudfront.net
BACKEND_URL=https://docquery-api.azurewebsites.net

# Backend on Azure App Services
BACKEND_HOST=docquery-api.azurewebsites.net
DATABASE_CONNECTION_STRING="Server=tcp:server.database.windows.net,1433;..."
```

### Scenario 2: GCP + Azure Hybrid
```bash
# Frontend on GCP Cloud Run
FRONTEND_URL=https://docquery-frontend-xyz-uc.a.run.app
BACKEND_URL=https://docquery-api.azurewebsites.net

# Backend on Azure, Database on GCP Cloud SQL
BACKEND_HOST=docquery-api.azurewebsites.net
DATABASE_CONNECTION_STRING="Server=1.2.3.4,1433;Database=DocQueryService;..."
```

## 📊 Monitoring and Observability

### OpenTelemetry Configuration
```bash
# Common settings for all environments
OTEL_EXPORTER_OTLP_ENDPOINT=https://api.honeycomb.io
OTEL_EXPORTER_OTLP_HEADERS="x-honeycomb-team=${HONEYCOMB_API_KEY}"

# Service-specific settings
OTEL_SERVICE_NAME=docquery-frontend-${ENVIRONMENT}
OTEL_RESOURCE_ATTRIBUTES="service.version=1.0.0,deployment.environment=${ENVIRONMENT}"
```

### Health Check Endpoints
- **Frontend**: `GET /health` → nginx health
- **Backend**: `GET /health` → API health + database connectivity
- **Database**: Connection test via backend health check

## 🛠️ Development Workflow

### Local Development
1. Use `.env.local` for configuration
2. Start services with `docker-compose up -d`
3. Frontend: http://localhost:3000
4. Backend: http://localhost:5001

### Staging Deployment
1. Update `.env.staging` with staging URLs
2. Run `./deploy.sh -e staging --dry-run` to validate
3. Deploy with `./deploy.sh -e staging`
4. Validate health checks and observability

### Production Deployment
1. Update production environment secrets
2. Run `./deploy.sh -e production --dry-run`
3. Deploy with `./deploy.sh -e production`
4. Monitor deployment via Honeycomb dashboards

## 🚨 Troubleshooting

### Common Issues

1. **Cross-Origin Errors**
   - Verify `CORS_ORIGIN` matches frontend domain
   - Check `ALLOWED_CONNECT_ORIGINS` includes backend URL

2. **Database Connection Failures**
   - Validate `DATABASE_CONNECTION_STRING` format
   - Check network connectivity and firewall rules
   - Verify credentials and database permissions

3. **Missing Environment Variables**
   - Check environment file loading
   - Validate secret manager configuration
   - Review application startup logs

### Debug Commands
```bash
# Check environment configuration
./deploy.sh -e production --dry-run

# Verify container health
docker ps
docker logs docquery-frontend
docker logs docquery-backend

# Test API connectivity
curl -f http://localhost:3000/health
curl -f http://localhost:5001/health
```

## 📚 Additional Resources

- [Azure App Service Configuration](https://docs.microsoft.com/en-us/azure/app-service/)
- [AWS ECS Task Definitions](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definitions.html)
- [Google Cloud Run Configuration](https://cloud.google.com/run/docs/configuring)
- [OpenTelemetry Configuration](https://opentelemetry.io/docs/reference/specification/)
- [Honeycomb.io Setup Guide](https://docs.honeycomb.io/getting-data-in/)