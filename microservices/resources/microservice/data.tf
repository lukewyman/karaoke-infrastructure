data "aws_eks_cluster_auth" "cluster_auth" {
  name = var.eks_cluster_id
}

data "aws_ecr_repository" "image_repository" {
  name = var.image_repository_name
}

data "aws_ssm_parameter" "mongo_username" {
  name = "/app/karaoke/DOCDB_USERNAME"
}

data "aws_ssm_parameter" "mongo_password" {
  name = "/app/karaoke/DOCDB_PASSWORD"
  with_decryption = true 
}

data "aws_iam_policy_document" "docdb_assume_role_policy" {
  statement {
    actions = [
      "sts:AssumeRoleWithWebIdentity"
    ]

    effect = "Allow"

    principals {
      type = "Federated"
      identifiers = [
        var.aws_iam_openid_connect_provider_arn
      ]
    }

    condition {
      test = "ForAnyValue:StringEquals"
      values = [
        "system:serviceaccount:${var.namespace_root}-${var.environment}:${var.service_name}-sa",
      ]
      variable = "${local.aws_iam_oidc_connect_provider_extract_from_arn}:sub"
    }

    condition {
      test = "ForAnyValue:StringEquals"
      values = [
        "sts.amazonaws.com"
      ]
      variable = "${local.aws_iam_oidc_connect_provider_extract_from_arn}:aud"
    }
  }
}