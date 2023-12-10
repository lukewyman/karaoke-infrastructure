locals {
  app_name = "${var.app_name}-${var.environment}"

  aws_iam_oidc_connect_provider_extract_from_arn = element(split("oidc-provider/", "${var.aws_iam_openid_connect_provider_arn}"), 1)
}