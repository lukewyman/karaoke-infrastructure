resource "kubernetes_service_account_v1" "microservice_service_account" {
  depends_on = [ aws_iam_role_policy_attachment.role_policy_attachment ]

  metadata {
    name = local.service_account_name
    namespace = "${var.app_name}-${var.environment}"
    annotations = {
      "eks.amazonaws.com/role-arn" = module.iam_role_for_postgres_service_account.iam_role_arn
    }
  }
}

module "iam_role_for_postgres_service_account" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "5.32.0"

  role_name = "${local.app_name}-postgres-fullaccess-sa"

  oidc_providers = {
    main = {
      provider_arn = var.aws_iam_openid_connect_provider_arn
      namespace_service_accounts = [
        "${var.app_name}-${var.environment}:${local.service_account_name}"
      ]
    }
  }
}

resource "aws_iam_role_policy_attachment" "role_policy_attachment" {
  role = module.iam_role_for_postgres_service_account.iam_role_name
  policy_arn = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
}