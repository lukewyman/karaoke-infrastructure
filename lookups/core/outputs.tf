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