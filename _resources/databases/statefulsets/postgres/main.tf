resource "aws_ssm_parameter" "postgres_password" {
  name  = "/app/karaoke/${var.environment}/POSTGRES_PASSWORD"
  type  = "SecureString"
  value = random_password.password.result
}

resource "random_password" "password" {
  length  = 8
  special = false
}

resource "helm_release" "postgres" {
  name = "${local.app_name}-postgres"
  repository = "https://charts.bitnami.com/bitnami"
  chart = "postgresql"
  version = "13.2.5"

  set {
    name = "architecture"
    value = "standalone"
  }

  set {
    name = "global.storageClass"
    value = "ebs-sc"
  }

  set {
    name = "auth.postgresPassword"
    value = aws_ssm_parameter.postgres_password.value
  }
}