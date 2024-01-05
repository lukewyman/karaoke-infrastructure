resource "helm_release" "mongodb" {
  name = "mongo"
  repository = "https://charts.bitnami.com/bitnami"
  chart = "mongodb"
  version = "14.4.9"

  namespace = local.app_name

  set {
    name = "architecture"
    value = "standalone"
  }

  set {
    name = "useStatefulSet"
    value = true
  }

  set {
    name = "global.storageClass"
    value = "ebs-sc"
  }

  set {
    name = "auth.rootUser"
    value = aws_ssm_parameter.admin_username.value
  }

  set {
    name = "auth.rootPassword"
    value = aws_ssm_parameter.admin_password.value
  }
  
}

resource "aws_ssm_parameter" "admin_username" {
  name = "/app/${var.app_name}/${var.environment}/mongo/USERNAME"
  type = "String"
  value = "admin"
}

resource "aws_ssm_parameter" "admin_password" {
  name = "/app/${var.app_name}/${var.environment}/mongo/PASSWORD"
  type = "SecureString"
  value = random_password.admin_password.result
}

resource "random_password" "admin_password" {
  length = 8
  special = false
}