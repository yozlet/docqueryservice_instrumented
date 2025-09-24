variable "name" {
  description = "Name of the OpenTelemetry collector resources"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet to launch the collector in"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "honeycomb_api_key" {
  description = "Honeycomb API key"
  type        = string
  sensitive   = true
}

