variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["us-west-2a", "us-west-2b"]
}

variable "frontend_instance_type" {
  description = "Instance type for frontend EC2"
  type        = string
  default     = "t3.micro"
}

variable "frontend_ami_id" {
  description = "AMI ID for frontend EC2"
  type        = string
}

variable "backend_instance_type" {
  description = "Instance type for backend EC2"
  type        = string
  default     = "t3.small"
}

variable "backend_ami_id" {
  description = "AMI ID for backend EC2"
  type        = string
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
}

variable "otel_collector_endpoint" {
  description = "OpenTelemetry collector endpoint"
  type        = string
}

variable "db_host" {
  description = "Database host"
  type        = string
}

variable "db_name" {
  description = "Database name"
  type        = string
}

variable "db_user" {
  description = "Database user"
  type        = string
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

