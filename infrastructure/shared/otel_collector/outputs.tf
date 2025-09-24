output "collector_endpoint" {
  description = "OpenTelemetry collector endpoint"
  value       = "http://${aws_ecs_service.collector.name}.${data.aws_region.current.name}.ecs.internal:4317"
}

output "security_group_id" {
  description = "ID of the collector security group"
  value       = aws_security_group.collector.id
}

