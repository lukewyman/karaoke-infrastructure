output "load_balancer_host_name" {
  value = data.kubernetes_ingress_v1.ingress_alb.status.0.load_balancer.0.ingress.0.host_name
}