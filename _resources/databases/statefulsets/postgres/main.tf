resource "helm_release" "postgres" {
  name = "postgres"
  repository = "https://charts.bitnami.com/bitnami"
  chart = "postgresql"
  version = "13.2.5"

  namespace = local.app_name

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

resource "aws_ssm_parameter" "postgres_password" {
  name  = "/app/${var.app_name}/${var.environment}/postgres/PASSWORD"
  type  = "SecureString"
  value = random_password.password.result
}

resource "random_password" "password" {
  length  = 8
  special = false
}