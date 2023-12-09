resource "kubernetes_deployment_v1" "web_app" {
  metadata {
    name = var.service_name
    labels = {
      app = var.service_name
    }
  }

  spec {
    replicas = 2 

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
        container {
          image = "${data.aws_ecr_repository.image_repository.repository_url}:${var.image_version}"
          name = var.service_name
          port {
            container_port = var.container_port
          }
          env {
            name = "MONGO_ARCHITECTURE"
            value = "replicaset"
          }
          env {
            name = "MONGO_HOSTNAME"
            value = "mongo"
          }
          env {
            name = "MONGO_PORT"
            value = var.mongo_port
          }
          env {
            name = "MONGO_USERNAME"
            value = data.aws_ssm_parameter.mongo_username.value
          }
          env {
            name = "MONGO_PASSWORD"
            value = data.aws_ssm_parameter.mongo_password.value
          }
        }
      }
    }
  }
}

resource "kubernetes_service_v1" "service" {
  metadata {
    name = "${var.service_name}-service"
  }

  spec {
    selector = {
      app = kubernetes_deployment_v1.web_app.spec.0.selector.0.match_labels.app
    }

    port {
      port = "80"
      target_port = var.container_port
      node_port = var.node_port
    }

    type = "NodePort"
  }
}