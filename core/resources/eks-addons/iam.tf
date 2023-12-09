# IAM resources for EBS CSI 

resource "aws_iam_policy" "ebs_csi_iam_policy" {
  name        = "${local.app_name}-AmazonEKS_EBS_CSI_Driver_Policy"
  path        = "/"
  description = "EBS CSI IAM Policy"
  policy      = data.http.ebs_csi_iam_policy.response_body
}

resource "aws_iam_role" "ebs_csi_iam_role" {
  name = "${local.app_name}-ebs-csi-iam-role"

  assume_role_policy = data.aws_iam_policy_document.ebs_csi_assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "ebs_csi_iam_role_policy" {
  policy_arn = aws_iam_policy.ebs_csi_iam_policy.arn
  role       = aws_iam_role.ebs_csi_iam_role.name
}


# IAM resources for Load Balancer Controller

resource "aws_iam_policy" "lbc_iam_policy" {
  name        = "${local.app_name}-AWSLoadBalancerControllerIAMPolicy"
  path        = "/"
  description = "AWS Load Balancer Controller IAM Policy"
  policy      = data.http.lbc_iam_policy.response_body
}

resource "aws_iam_role" "lbc_iam_role" {
  name = "${local.app_name}-lbc-iam-role"

  assume_role_policy = data.aws_iam_policy_document.lbc_assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "lbc_iam_role_policy_attach" {
  policy_arn = aws_iam_policy.lbc_iam_policy.arn
  role       = aws_iam_role.lbc_iam_role.name
}


# IAM resources for External DNS Controller

resource "aws_iam_policy" "external_dns_iam_policy" {
  name = "${local.app_name}-ExternalDNSControllerIAMPolicy"
  path = "/"
  description = "AWS Load Balancer Controller IAM Policy"
  policy = data.aws_iam_policy_document.external_dns_iam_policy.json
}

resource "aws_iam_role" "external_dns_iam_role" {
  name = "${local.app_name}-external-dns-iam-role"

  assume_role_policy = data.aws_iam_policy_document.external_dns_assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "external_dns_iam_role_policy_attach" {
  policy_arn = aws_iam_policy.external_dns_iam_policy.arn 
  role = aws_iam_role.external_dns_iam_role.name 
}