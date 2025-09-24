variable "environment" {
  description = "Environment name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "westus2"
}

variable "vnet_cidr" {
  description = "CIDR block for Virtual Network"
  type        = string
  default     = "10.1.0.0/16"
}

variable "backend_subnet_cidr" {
  description = "CIDR block for backend subnet"
  type        = string
  default     = "10.1.1.0/24"
}

variable "db_admin_username" {
  description = "PostgreSQL server admin username"
  type        = string
}

variable "db_admin_password" {
  description = "PostgreSQL server admin password"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "PostgreSQL database name"
  type        = string
  default     = "docquery"
}

variable "otel_collector_endpoint" {
  description = "OpenTelemetry collector endpoint"
  type        = string
}

