locals {
  app_name = "${var.app_name}-${var.environment}"

  eks_cluster_name = "${local.app_name}-${var.eks_cluster_name}"

  eks_node_group_name = "${local.app_name}-${var.eks_node_group_name}"
}