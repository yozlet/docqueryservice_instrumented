resource "aws_instance" "main" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id

  vpc_security_group_ids = var.vpc_security_group_ids
  key_name              = var.key_name

  user_data = var.user_data

  root_block_device {
    volume_size = var.root_volume_size
    volume_type = "gp3"
  }

  tags = {
    Name        = var.name
    Environment = var.environment
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }
}

resource "aws_eip" "main" {
  count  = var.create_eip ? 1 : 0
  domain = "vpc"

  instance = aws_instance.main.id

  tags = {
    Name        = "${var.name}-eip"
    Environment = var.environment
  }
}

