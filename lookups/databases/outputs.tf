output "docdb_endpoint" {
  value = data.terraform_remote_state.mongo.outputs.docdb_endpoint
}
