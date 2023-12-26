output "docdb_endpoint" {
  value = aws_docdb_cluster.docdb.endpoint
}

output "docdb_service_account_name" {
  value = local.service_account_name
}