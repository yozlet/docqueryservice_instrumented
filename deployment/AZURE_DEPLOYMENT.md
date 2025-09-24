# Azure Deployment (Non-Container)

This guide explains how to deploy the .NET backend to Azure using App Service and Azure SQL Database without containers, providing a complete cloud infrastructure setup.

## 🎯 Overview

This deployment approach creates a complete Azure infrastructure including App Service and SQL Database. It offers:

- **Faster deployments** - No container build/push steps
- **Simplified configuration** - Direct .NET runtime management
- **Better performance** - No container overhead
- **Easier debugging** - Direct access to application files
- **Cost efficiency** - No container registry costs

## 📋 Prerequisites

### Required Tools

```bash
# Azure CLI
brew install azure-cli

# .NET 9.0 SDK
brew install dotnet

# Verify installations
az --version
dotnet --version
```

### Azure Account Setup

```bash
# Login to Azure
az login

# Set your subscription
az account set --subscription "your-subscription-id"

# Verify account
az account show
```

## 🚀 Quick Start

### 1. Configure Environment

```bash
# Copy and edit the Azure environment file
cp deployment/azure.env.template deployment/azure.env

# Edit with your Azure configuration
vim deployment/azure.env
```

### 2. Deploy Application

```bash
# Full deployment (creates App Service + SQL Database + deploys app)
./deployment/deploy-azure.sh

# Preview deployment without executing
./deployment/deploy-azure.sh --dry-run

# Deploy app only (skip infrastructure creation)
./deployment/deploy-azure.sh --skip-infrastructure

# Deploy without rebuilding
./deployment/deploy-azure.sh --skip-build
```

### 3. Using Main Deploy Script

```bash
# Use the main deployment script
cd deployment
./deploy.sh -e azure

# Choose option 2 (Azure deployment) when prompted
```

## ⚙️ Configuration

### Environment Variables

Edit `deployment/azure.env` with your specific values:

```bash
# Azure Resources
AZURE_SUBSCRIPTION_ID=12345678-1234-1234-1234-123456789012
AZURE_RESOURCE_GROUP=docquery-rg
AZURE_APP_SERVICE_PLAN=docquery-plan
AZURE_APP_NAME=docquery-api
AZURE_LOCATION=eastus

# Database (Azure SQL)
DATABASE_CONNECTION_STRING="Server=tcp:myserver.database.windows.net,1433;Initial Catalog=DocQueryService;User ID=myuser;Password=mypassword;Encrypt=True;"

# Monitoring (Honeycomb)
HONEYCOMB_API_KEY=your-honeycomb-api-key
OTEL_EXPORTER_OTLP_ENDPOINT=https://api.honeycomb.io
OTEL_EXPORTER_OTLP_HEADERS="x-honeycomb-team=your-api-key"
```

### Application Settings

The deployment automatically configures these Azure App Service settings:

| Setting                               | Value         | Purpose                     |
| ------------------------------------- | ------------- | --------------------------- |
| `ASPNETCORE_ENVIRONMENT`              | Production    | ASP.NET Core environment    |
| `WEBSITES_ENABLE_APP_SERVICE_STORAGE` | false         | Disable persistent storage  |
| `WEBSITES_PORT`                       | 5001          | Application port            |
| `DATABASE_CONNECTION_STRING`          | From env file | Database connection         |
| `OTEL_*`                              | From env file | OpenTelemetry configuration |

## 🏗️ Infrastructure

### Created Resources

The deployment script creates these Azure resources:

```bash
# Resource Group
az group create --name docquery-rg --location eastus

# App Service Plan (Linux, B1 tier)
az appservice plan create \
    --name docquery-plan \
    --resource-group docquery-rg \
    --sku B1 \
    --is-linux

# App Service (.NET 9.0 runtime)
az webapp create \
    --name docquery-api \
    --resource-group docquery-rg \
    --plan docquery-plan \
    --runtime "DOTNET|9.0"

# Azure SQL Server
az sql server create \
    --name docquery-sql-server \
    --resource-group docquery-rg \
    --admin-user sqladmin \
    --admin-password "SecurePassword123!"

# Azure SQL Database
az sql db create \
    --server docquery-sql-server \
    --resource-group docquery-rg \
    --name DocQueryService \
    --edition Basic

# SQL Server Firewall (Allow Azure Services)
az sql server firewall-rule create \
    --server docquery-sql-server \
    --resource-group docquery-rg \
    --name "AllowAzureServices" \
    --start-ip-address 0.0.0.0 \
    --end-ip-address 0.0.0.0
```

### Pricing Tiers

| Tier          | Monthly Cost\* | Features                     |
| ------------- | -------------- | ---------------------------- |
| F1 (Free)     | $0             | 1GB storage, 165 min/day     |
| B1 (Basic)    | ~$13           | 10GB storage, unlimited      |
| S1 (Standard) | ~$56           | Auto-scaling, custom domains |
| P1 (Premium)  | ~$146          | Advanced scaling, slots      |

\*Prices vary by region and are subject to change

## 🔧 Manual Deployment Steps

### 1. Build Application

```bash
cd backend-dotnet

# Restore packages
dotnet restore

# Build in release mode
dotnet build -c Release

# Publish application
dotnet publish -c Release -o ./publish
```

### 2. Deploy to Azure

```bash
# Create deployment package
cd publish
zip -r ../deployment.zip .

# Deploy via Azure CLI
az webapp deployment source config-zip \
    --name docquery-api \
    --resource-group docquery-rg \
    --src ../deployment.zip
```

### 3. Configure Application

```bash
# Set environment variables
az webapp config appsettings set \
    --name docquery-api \
    --resource-group docquery-rg \
    --settings \
        ASPNETCORE_ENVIRONMENT=Production \
        DATABASE_CONNECTION_STRING="your-connection-string"

# Enable HTTPS only
az webapp update \
    --name docquery-api \
    --resource-group docquery-rg \
    --https-only true
```

## 🔍 Monitoring & Debugging

### Application Logs

```bash
# View real-time logs
az webapp log tail \
    --name docquery-api \
    --resource-group docquery-rg

# Download log files
az webapp log download \
    --name docquery-api \
    --resource-group docquery-rg
```

### Health Checks

```bash
# Check application health
curl https://docquery-api.azurewebsites.net/health

# Expected response:
# {"status":"healthy","timestamp":"2024-01-15T10:30:00Z"}
```

### Performance Monitoring

The application includes OpenTelemetry integration for comprehensive monitoring:

- **Traces**: HTTP requests, database queries, external calls
- **Metrics**: Request rates, response times, error rates
- **Logs**: Application logs with correlation IDs

Configure Honeycomb monitoring:

```bash
az webapp config appsettings set \
    --name docquery-api \
    --resource-group docquery-rg \
    --settings \
        OTEL_EXPORTER_OTLP_ENDPOINT=https://api.honeycomb.io \
        OTEL_EXPORTER_OTLP_HEADERS="x-honeycomb-team=your-api-key" \
        OTEL_SERVICE_NAME=docquery-backend-appservice
```

## 🛠️ Troubleshooting

### Common Issues

#### 1. Application Won't Start

```bash
# Check application logs
az webapp log tail --name docquery-api --resource-group docquery-rg

# Common causes:
# - Missing environment variables
# - Database connection issues
# - Port configuration problems
```

#### 2. Database Connection Errors

```bash
# Verify connection string format
DATABASE_CONNECTION_STRING="Server=tcp:server.database.windows.net,1433;Database=DocQueryService;User ID=user;Password=pass;Encrypt=True;TrustServerCertificate=False;"

# Check firewall rules
az sql server firewall-rule create \
    --server myserver \
    --resource-group docquery-rg \
    --name AllowAzureServices \
    --start-ip-address 0.0.0.0 \
    --end-ip-address 0.0.0.0
```

#### 3. CORS Issues

```bash
# Configure CORS in application settings
az webapp config appsettings set \
    --name docquery-api \
    --resource-group docquery-rg \
    --settings CORS_ORIGIN="https://yourdomain.com"
```

#### 4. Performance Issues

- **Scale up**: Increase App Service Plan tier
- **Scale out**: Enable auto-scaling
- **Optimize**: Review database queries and caching

### Debug Commands

```bash
# Check deployment status
az webapp deployment list \
    --name docquery-api \
    --resource-group docquery-rg

# View application settings
az webapp config appsettings list \
    --name docquery-api \
    --resource-group docquery-rg

# Restart application
az webapp restart \
    --name docquery-api \
    --resource-group docquery-rg
```

## 🚀 CI/CD Integration

### GitHub Actions

```yaml
name: Deploy to Azure App Service

on:
  push:
    branches: [main]
    paths: ['backend-dotnet/**']

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Setup .NET
        uses: actions/setup-dotnet@v3
        with:
          dotnet-version: '9.0.x'

      - name: Build and publish
        run: |
          cd backend-dotnet
          dotnet restore
          dotnet build -c Release
          dotnet publish -c Release -o ./publish

      - name: Deploy to Azure
        uses: azure/webapps-deploy@v2
        with:
          app-name: 'docquery-api'
          publish-profile: ${{ secrets.AZURE_WEBAPP_PUBLISH_PROFILE }}
          package: './backend-dotnet/publish'
```

### Azure DevOps

```yaml
trigger:
  branches:
    include:
      - main
  paths:
    include:
      - backend-dotnet/*

pool:
  vmImage: 'ubuntu-latest'

variables:
  buildConfiguration: 'Release'

stages:
  - stage: Build
    jobs:
      - job: Build
        steps:
          - task: DotNetCoreCLI@2
            displayName: 'Restore packages'
            inputs:
              command: 'restore'
              projects: 'backend-dotnet/*.csproj'

          - task: DotNetCoreCLI@2
            displayName: 'Build application'
            inputs:
              command: 'build'
              projects: 'backend-dotnet/*.csproj'
              arguments: '--configuration $(buildConfiguration)'

          - task: DotNetCoreCLI@2
            displayName: 'Publish application'
            inputs:
              command: 'publish'
              projects: 'backend-dotnet/*.csproj'
              arguments: '--configuration $(buildConfiguration) --output $(Build.ArtifactStagingDirectory)'

          - task: PublishBuildArtifacts@1
            displayName: 'Publish artifacts'
            inputs:
              PathtoPublish: '$(Build.ArtifactStagingDirectory)'
              ArtifactName: 'drop'

  - stage: Deploy
    jobs:
      - deployment: Deploy
        environment: 'production'
        strategy:
          runOnce:
            deploy:
              steps:
                - task: AzureWebApp@1
                  displayName: 'Deploy to Azure App Service'
                  inputs:
                    azureSubscription: 'Azure-Connection'
                    appType: 'webAppLinux'
                    appName: 'docquery-api'
                    package: '$(Pipeline.Workspace)/drop'
```

## 📚 Additional Resources

- [Azure App Service Documentation](https://docs.microsoft.com/en-us/azure/app-service/)
- [ASP.NET Core on Azure](https://docs.microsoft.com/en-us/aspnet/core/host-and-deploy/azure-apps/)
- [Azure CLI Reference](https://docs.microsoft.com/en-us/cli/azure/)
- [OpenTelemetry .NET](https://opentelemetry.io/docs/instrumentation/net/)
- [Honeycomb.io Documentation](https://docs.honeycomb.io/)

## 🆚 Container vs Non-Container Comparison

| Aspect               | Non-Container (This Guide)    | Container                 |
| -------------------- | ----------------------------- | ------------------------- |
| **Deployment Speed** | ✅ Faster (direct deploy)     | ❌ Slower (build + push)  |
| **Resource Usage**   | ✅ Lower overhead             | ❌ Container overhead     |
| **Debugging**        | ✅ Direct file access         | ❌ Container isolation    |
| **Scaling**          | ✅ Native App Service scaling | ✅ Container scaling      |
| **Portability**      | ❌ Azure-specific             | ✅ Run anywhere           |
| **Configuration**    | ✅ Simpler setup              | ❌ More complex           |
| **Cost**             | ✅ No registry costs          | ❌ Registry storage costs |

Choose non-container deployment when:

- You're committed to Azure App Service
- You want faster deployments
- You need easier debugging
- Cost optimization is important

Choose container deployment when:

- You need multi-cloud portability
- You have complex dependencies
- You want consistent environments
- You're using microservices architecture
