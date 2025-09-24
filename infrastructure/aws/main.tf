terraform {
  required_version = ">= 1.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    # Configure your backend settings
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "DocQueryService"
      Environment = var.environment
      Terraform   = "true"
    }
  }
}

# VPC Configuration
module "vpc" {
  source = "../shared/vpc"

  vpc_name     = "doc-query-${var.environment}"
  vpc_cidr     = var.vpc_cidr
  azs          = var.availability_zones
  environment  = var.environment
}

# EC2 Instance for Frontend
module "frontend_ec2" {
  source = "../shared/ec2"

  name           = "frontend-${var.environment}"
  instance_type  = var.frontend_instance_type
  ami_id         = var.frontend_ami_id
  subnet_id      = module.vpc.public_subnets[0]
  vpc_security_group_ids = [module.frontend_sg.security_group_id]
  key_name       = var.key_name
  environment    = var.environment

  user_data = templatefile("${path.module}/templates/frontend-userdata.sh", {
    environment = var.environment
    otel_endpoint = var.otel_collector_endpoint
  })
}

# EC2 Instance for Python Backend
module "backend_ec2" {
  source = "../shared/ec2"

  name           = "backend-python-${var.environment}"
  instance_type  = var.backend_instance_type
  ami_id         = var.backend_ami_id
  subnet_id      = module.vpc.private_subnets[0]
  vpc_security_group_ids = [module.backend_sg.security_group_id]
  key_name       = var.key_name
  environment    = var.environment

  user_data = templatefile("${path.module}/templates/backend-userdata.sh", {
    environment = var.environment
    otel_endpoint = var.otel_collector_endpoint
    db_host = var.db_host
    db_name = var.db_name
    db_user = var.db_user
    db_password = var.db_password
  })
}

# Security Groups
module "frontend_sg" {
  source = "../shared/security_group"

  name        = "frontend-sg-${var.environment}"
  vpc_id      = module.vpc.vpc_id
  environment = var.environment

  ingress_rules = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

module "backend_sg" {
  source = "../shared/security_group"

  name        = "backend-sg-${var.environment}"
  vpc_id      = module.vpc.vpc_id
  environment = var.environment

  ingress_rules = [
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      cidr_blocks = [var.vpc_cidr]
    }
  ]
}

# OpenTelemetry Collector
module "otel_collector" {
  source = "../shared/otel_collector"

  name        = "otel-collector-${var.environment}"
  environment = var.environment
  subnet_id   = module.vpc.private_subnets[0]
  vpc_id      = module.vpc.vpc_id
}

