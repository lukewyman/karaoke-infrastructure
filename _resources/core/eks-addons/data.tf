data "aws_eks_cluster_auth" "cluster_auth" {
  name = var.eks_cluster_id
}


# IAM for EBS CSI driver

data "http" "ebs_csi_iam_policy" {
  url = "https://raw.githubusercontent.com/kubernetes-sigs/aws-ebs-csi-driver/master/docs/example-iam-policy.json"

  request_headers = {
    Accept = "application/json"
  }
}

data "aws_iam_policy_document" "ebs_csi_assume_role_policy" {
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
        "system:serviceaccount:kube-system:ebs-csi-controller-sa",
      ]
      variable = "${local.aws_iam_oidc_connect_provider_extract_from_arn}:sub"
    }
  }
}


# IAM for Load Balancer Controller

data "http" "lbc_iam_policy" {
  url = "https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/main/docs/install/iam_policy.json"

  request_headers = {
    Accept = "application/json"
  }
}

data "aws_iam_policy_document" "lbc_assume_role_policy" {
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
        "system:serviceaccount:kube-system:aws-load-balancer-controller",
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


# IAM for External DNS Controller

data "aws_iam_policy_document" "external_dns_iam_policy" {
  statement {
    effect = "Allow"
    actions = [
      "route53:ChangeResourceRecordSets"
    ]
    resources = [
      "arn:aws:route53:::hostedzone/*"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "route53:ListHostedZones",
      "route53:ListResourceRecordSets"
    ]
    resources = [
      "*"
    ]
  }
}

data "aws_iam_policy_document" "external_dns_assume_role_policy" {
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
        "system:serviceaccount:default:external-dns",
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