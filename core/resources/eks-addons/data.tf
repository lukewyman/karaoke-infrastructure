data "http" "ebs_csi_iam_policy" {
  url = "https://raw.githubusercontent.com/kubernetes-sigs/aws-ebs-csi-driver/master/docs/example-iam-policy.json"

  # Optional request headers
  request_headers = {
    Accept = "application/json"
  }
}

data "aws_eks_cluster_auth" "cluster_auth" {
  name = var.eks_cluster_id
}

data "aws_iam_policy_document" "assume_role_policy" {
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
        "system:serviceaccount:kube-system:ebs-csi-controller-sa"
      ]
      variable = "${local.aws_iam_oidc_connect_provider_extract_from_arn}:sub"
    }
  }
}