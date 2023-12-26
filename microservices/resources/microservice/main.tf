resource "kubernetes_service_v1" "service" {
  metadata {
    name      = "${var.service_name}"
    namespace = "${var.app_name}-${var.environment}"
  }

  spec {
    selector = {
      app = kubernetes_deployment_v1.web_app.spec.0.selector.0.match_labels.app
    }

    port {
      port        = "80"
      target_port = var.container_port
      node_port   = var.node_port
    }

    type = "NodePort"
  }
}

resource "kubernetes_deployment_v1" "web_app" {
  metadata {
    name = var.service_name
    labels = {
      app = var.service_name
    }
    namespace = local.app_name
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = var.service_name
      }
    }

    template {
      metadata {
        labels = {
          app = var.service_name
        }
      }

      spec {
        service_account_name = var.service_account_name

        container {
          image = "${data.aws_ecr_repository.image_repository.repository_url}:${var.image_version}"
          name  = var.service_name

          port {
            container_port = var.container_port
          }

          env_from {
            # FIGURE OUT HOW TO MAKE THIS BLOCK CONDITIONAL
            config_map_ref {
              name = kubernetes_config_map_v1.env_vars.0.metadata.0.name
            }

            secret_ref {
              name = kubernetes_secret_v1.env_secrets.0.metadata.0.name
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_config_map_v1" "env_vars" {
  count = local.create_config_map ? 1 : 0

  metadata {
    name      = "environment-variables"
    namespace = local.app_name
  }

  data = merge(
    { for n, v in var.env : n => v },
    { for n in var.env_parameter_store_text : n => data.aws_ssm_parameter.param_text[n].value }
  )
}

resource "kubernetes_secret_v1" "env_secrets" {
  count = local.create_secret ? 1 : 0

  metadata {
    name      = "secrets"
    namespace = "${var.app_name}-${var.environment}"
  }

  data = { for s in var.env_parameter_store_secret : s => data.aws_ssm_parameter.param_secret[s].value }
}