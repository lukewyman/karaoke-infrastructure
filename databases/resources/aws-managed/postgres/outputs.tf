output "postgres_endpoint" {
  value = aws_db_instance.postgres_instance.endpoint
}

output "postgres_identifier" {
  value = aws_db_instance.postgres_instance.identifier
}

output "postgres_service_account_name" {
  value = local.service_account_name
}