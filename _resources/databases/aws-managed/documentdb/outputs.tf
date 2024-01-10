output "docdb_endpoint" {
  value = aws_docdb_cluster.docdb.endpoint
}

output "mongo_service_name" {
  value = kubernetes_service_v1.docdb_service.metadata.0.name 
}