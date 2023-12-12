resource "kubernetes_ingress_v1" "ingress_alb" {
  metadata {
    name      = local.ingress_name
    namespace = local.app_name

    annotations = {
      "alb.ingress.kubernetes.io/load-balancer-name"           = "ingress-${var.app_name}-${var.environment}"
      "alb.ingress.kubernetes.io/scheme"                       = "internet-facing"
      "alb.ingress.kubernetes.io/healthcheck-path"             = "/ | /AWS.ALB/health"
      "alb.ingress.kubernetes.io/healthcheck-protocol"         = "HTTP"
      "alb.ingress.kubernetes.io/healthcheck-port"             = "traffic-port"
      "alb.ingress.kubernetes.io/healthcheck-interval-seconds" = 15
      "alb.ingress.kubernetes.io/healthcheck-timeout-seconds"  = 5
      "alb.ingress.kubernetes.io/success-codes"                = 200
      "alb.ingress.kubernetes.io/healthy-threshold-count"      = 2
      "alb.ingress.kubernetes.io/unhealthy-threshold-count"    = 2
    }
  }

  spec {
    ingress_class_name = "${var.app_name}-ingress-class"

    rule {
      http {

        dynamic "path" {
          for_each = var.routes
          content {
            backend {
              service {
                name = each.key
                port {
                  number = 80
                }
              }
            }
            path      = "/${each.value}"
            path_type = "Prefix"
          }
        }

      }
    }
  }
}