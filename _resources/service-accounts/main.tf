# DOCUMENTDB FULL ACCESS 
resource "kubernetes_service_account_v1" "docdb_full_access" {
  depends_on = [ aws_iam_role_policy_attachment.docdb_policy_attachment ]

  metadata {
    name = local.docdb_service_account_name
    namespace = local.app_name
    annotations = {
      "eks.amazonaws.com/role-arn" = module.iam_role_for_docdb_service_account.iam_role_arn
    }
  }
}

module "iam_role_for_docdb_service_account" {
	
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "5.32.0"

  role_name = "${local.app_name}-${local.docdb_service_account_name}"

  oidc_providers = {
    main = {
      provider_arn = var.aws_iam_openid_connect_provider_arn
      namespace_service_accounts = [
        "${local.app_name}:${local.docdb_service_account_name}"
      ]
    }
  }
}

resource "aws_iam_role_policy_attachment" "docdb_policy_attachment" {
  role = module.iam_role_for_docdb_service_account.iam_role_name
  policy_arn = "arn:aws:iam::aws:policy/AmazonDocDBFullAccess"
}


# DYNAMODB FULL ACESS 
resource "kubernetes_service_account_v1" "dynamodb_full_access" {  
  depends_on = [ aws_iam_role_policy_attachment.dynamodb_policy_attachment ]

  metadata {
    name = local.dynamodb_service_account_name
    namespace = "${local.app_name}"
		annotations = {
      "eks.amazonaws.com/role-arn" = module.iam_role_for_dynamodb_service_account.iam_role_arn
    }
  }
}

module "iam_role_for_dynamodb_service_account" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "5.32.0"

  role_name = "${local.app_name}-${local.dynamodb_service_account_name}"

  oidc_providers = {
    main = {
      provider_arn = var.aws_iam_openid_connect_provider_arn
      namespace_service_accounts = [
        "${local.app_name}:${local.dynamodb_service_account_name}"
      ]
    }
  }
}

resource "aws_iam_role_policy_attachment" "dynamodb_policy_attachment" {
  role = module.iam_role_for_dynamodb_service_account.iam_role_name
  policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
}


# RDS FULL ACCESS
resource "kubernetes_service_account_v1" "rds_full_access" {
  depends_on = [ aws_iam_role_policy_attachment.rds_policy_attachment ]

  metadata {
    name = local.rds_service_account_name
    namespace = local.app_name
    annotations = {
      "eks.amazonaws.com/role-arn" = module.iam_role_for_rds_service_account.iam_role_arn
    }
  }
}

module "iam_role_for_rds_service_account" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "5.32.0"

  role_name = "${local.app_name}-${local.rds_service_account_name}"

  oidc_providers = {
    main = {
      provider_arn = var.aws_iam_openid_connect_provider_arn
      namespace_service_accounts = [
        "${local.app_name}:${local.rds_service_account_name}"
      ]
    }
  }
}

resource "aws_iam_role_policy_attachment" "rds_policy_attachment" {
  role = module.iam_role_for_rds_service_account.iam_role_name
  policy_arn = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
}


