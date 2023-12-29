locals {
  app_name = "${var.app_name}-${var.environment}-dbs-managed"

  service_account_name = "docdb-full-access"
}