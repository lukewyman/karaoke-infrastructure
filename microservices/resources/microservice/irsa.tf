resource "kubernetes_service_account_v1" "microservice_service_account" {
  depends_on = [ aws_iam_role_policy_attachment.role_policy_attachment ]

  metadata {
    name = "${var.service_name}-sa"
    namespace = "${var.app_name}-${var.environment}"
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.service_account_role.arn
    }
  }
}

resource "aws_iam_role" "service_account_role" {
  name = "${local.app_name}-${var.service_name}-service-account-role"
  assume_role_policy = data.aws_iam_policy_document.docdb_assume_role_policy.json 
}

resource "aws_iam_role_policy_attachment" "role_policy_attachment" {
  for_each = toset(var.iam_policy_arns)

  role = aws_iam_role.service_account_role.name
  policy_arn = each.key
}