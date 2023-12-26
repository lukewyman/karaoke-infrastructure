locals {
  app_name = "${var.app_name}-${var.environment}"

  service_account_name = "dynamodb-full-access"
}