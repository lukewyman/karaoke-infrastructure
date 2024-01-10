locals {
  app_name = "${var.app_name}-${var.environment}"
  docdb_service_account_name = "docdb-full-access"
  dynamodb_service_account_name = "dynamodb-full-access"
  rds_service_account_name = "rds-full-access"
}