data "aws_eks_cluster_auth" "cluster_auth" {
  name = var.eks_cluster_id
}


data "kubernetes_ingress_v1" "ingress_alb" {
  depends_on = [ kubernetes_ingress_v1.ingress ]

  metadata {
    name      = local.ingress_name
    namespace = local.app_name
  }
}