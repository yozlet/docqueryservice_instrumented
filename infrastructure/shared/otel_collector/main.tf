resource "aws_ecs_cluster" "collector" {
  name = var.name

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Name        = var.name
    Environment = var.environment
  }
}

resource "aws_ecs_task_definition" "collector" {
  family                   = var.name
  requires_compatibilities = ["FARGATE"]
  network_mode            = "awsvpc"
  cpu                     = 512
  memory                  = 1024
  execution_role_arn      = aws_iam_role.ecs_execution.arn
  task_role_arn           = aws_iam_role.ecs_task.arn

  container_definitions = jsonencode([
    {
      name  = "otel-collector"
      image = "otel/opentelemetry-collector-contrib:latest"
      
      portMappings = [
        {
          containerPort = 4317
          hostPort      = 4317
          protocol      = "tcp"
        },
        {
          containerPort = 4318
          hostPort      = 4318
          protocol      = "tcp"
        }
      ]

      environment = [
        {
          name  = "HONEYCOMB_API_KEY"
          value = var.honeycomb_api_key
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.collector.name
          awslogs-region        = data.aws_region.current.name
          awslogs-stream-prefix = "otel"
        }
      }
    }
  ])

  tags = {
    Name        = var.name
    Environment = var.environment
  }
}

resource "aws_ecs_service" "collector" {
  name            = var.name
  cluster         = aws_ecs_cluster.collector.id
  task_definition = aws_ecs_task_definition.collector.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [var.subnet_id]
    security_groups  = [aws_security_group.collector.id]
    assign_public_ip = false
  }

  tags = {
    Name        = var.name
    Environment = var.environment
  }
}

resource "aws_security_group" "collector" {
  name        = "${var.name}-sg"
  description = "Security group for OpenTelemetry collector"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 4317
    to_port     = 4317
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.selected.cidr_block]
  }

  ingress {
    from_port   = 4318
    to_port     = 4318
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.selected.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.name}-sg"
    Environment = var.environment
  }
}

resource "aws_cloudwatch_log_group" "collector" {
  name              = "/ecs/${var.name}"
  retention_in_days = 30

  tags = {
    Name        = var.name
    Environment = var.environment
  }
}

resource "aws_iam_role" "ecs_execution" {
  name = "${var.name}-execution"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name        = "${var.name}-execution"
    Environment = var.environment
  }
}

resource "aws_iam_role" "ecs_task" {
  name = "${var.name}-task"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name        = "${var.name}-task"
    Environment = var.environment
  }
}

resource "aws_iam_role_policy_attachment" "ecs_execution" {
  role       = aws_iam_role.ecs_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

data "aws_region" "current" {}

data "aws_vpc" "selected" {
  id = var.vpc_id
}

