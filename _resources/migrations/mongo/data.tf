data "aws_eks_cluster_auth" "cluster_auth" {
  name = var.eks_cluster_id
}