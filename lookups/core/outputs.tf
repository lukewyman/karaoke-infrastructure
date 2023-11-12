output "db_subnet_ids" {
  value = data.terraform_remote_state.vpc.outputs.database_subnets
}

output "private_subnets_cidr_blocks" {
  value = data.terraform_remote_state.vpc.outputs.private_subnets_cidr_blocks
}

output "public_subnets_cidr_blocks" {
  value = data.terraform_remote_state.vpc.outputs.public_subnets_cidr_blocks
}

output "vpc_id" {
  value = data.terraform_remote_state.vpc.outputs.vpc_id
}

output "aws_iam_openid_connect_provider_arn" {
  value = data.terraform_remote_state.eks_cluster.outputs.aws_iam_openid_connect_provider_arn
}

output "cluster_certificate_authority_data" {
  value = data.terraform_remote_state.eks_cluster.outputs.cluster_certificate_authority_data
}

output "eks_cluster_id" {
  value = data.terraform_remote_state.eks_cluster.outputs.eks_cluster_id
}

output "eks_cluster_endpoint" {
  value = data.terraform_remote_state.eks_cluster.outputs.eks_cluster_endpoint
}
