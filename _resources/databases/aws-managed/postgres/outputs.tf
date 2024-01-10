output "postgres_endpoint" {
  value = aws_db_instance.postgres_instance.endpoint
}

output "postgres_identifier" {
  value = aws_db_instance.postgres_instance.identifier
}

output "postgres_service_name" {
  value = kubernetes_service_v1.postgres_service.metadata.0.name
}