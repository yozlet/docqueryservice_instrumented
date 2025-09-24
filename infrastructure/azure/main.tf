terraform {
  required_version = ">= 1.0"
  
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  backend "azurerm" {
    # Configure your backend settings
  }
}

provider "azurerm" {
  features {}
}

# Resource Group
resource "azurerm_resource_group" "main" {
  name     = "rg-docquery-${var.environment}"
  location = var.location

  tags = {
    Environment = var.environment
    Project     = "DocQueryService"
    Terraform   = "true"
  }
}

# Virtual Network
resource "azurerm_virtual_network" "main" {
  name                = "vnet-docquery-${var.environment}"
  address_space       = [var.vnet_cidr]
  location           = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

# Subnets
resource "azurerm_subnet" "backend" {
  name                 = "snet-backend-${var.environment}"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [var.backend_subnet_cidr]
}

# PostgreSQL Server
resource "azurerm_postgresql_flexible_server" "main" {
  name                = "psql-docquery-${var.environment}"
  resource_group_name = azurerm_resource_group.main.name
  location           = azurerm_resource_group.main.location
  version            = "14"
  
  administrator_login    = var.db_admin_username
  administrator_password = var.db_admin_password

  storage_mb = 32768
  sku_name   = "B_Standard_B1ms"

  backup_retention_days = 7
  
  zone = "1"

  tags = {
    Environment = var.environment
  }
}

# Database
resource "azurerm_postgresql_flexible_server_database" "main" {
  name      = var.db_name
  server_id = azurerm_postgresql_flexible_server.main.id
  collation = "en_US.utf8"
  charset   = "utf8"
}

# App Service Plan
resource "azurerm_service_plan" "main" {
  name                = "asp-docquery-${var.environment}"
  resource_group_name = azurerm_resource_group.main.name
  location           = azurerm_resource_group.main.location
  os_type            = "Linux"
  sku_name           = "B1"
}

# .NET Backend App Service
resource "azurerm_linux_web_app" "backend" {
  name                = "app-docquery-backend-${var.environment}"
  resource_group_name = azurerm_resource_group.main.name
  location           = azurerm_resource_group.main.location
  service_plan_id    = azurerm_service_plan.main.id

  site_config {
    application_stack {
      dotnet_version = "7.0"
    }
  }

  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
    "WEBSITE_RUN_FROM_PACKAGE"           = "1"
    "ASPNETCORE_ENVIRONMENT"             = var.environment
    "ConnectionStrings__DefaultConnection" = "Host=${azurerm_postgresql_flexible_server.main.fqdn};Database=${var.db_name};Username=${var.db_admin_username};Password=${var.db_admin_password}"
    "OTEL_EXPORTER_OTLP_ENDPOINT"        = var.otel_collector_endpoint
    "OTEL_SERVICE_NAME"                  = "docquery-backend-dotnet"
  }

  identity {
    type = "SystemAssigned"
  }
}

# Application Insights
resource "azurerm_application_insights" "main" {
  name                = "appi-docquery-${var.environment}"
  location           = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  application_type    = "web"
}

# Log Analytics Workspace
resource "azurerm_log_analytics_workspace" "main" {
  name                = "log-docquery-${var.environment}"
  location           = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  sku                = "PerGB2018"
  retention_in_days   = 30
}

