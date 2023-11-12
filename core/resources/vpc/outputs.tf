output "azs" {
  description = "A list of availability zones spefified as argument to this module"
  value       = module.karaoke_vpc.azs
}

output "database_subnets" {
  value = module.karaoke_vpc.database_subnets
}

output "nat_public_ips" {
  description = "List of public Elastic IPs created for AWS NAT Gateway"
  value       = module.karaoke_vpc.nat_public_ips
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.karaoke_vpc.private_subnets
}

output "private_subnets_cidr_blocks" {
  description = "List of CIDR blocks for the private subnets"
  value       = module.karaoke_vpc.private_subnets_cidr_blocks
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.karaoke_vpc.public_subnets
}

output "public_subnets_cidr_blocks" {
  description = "List of CIDR blocks for the public subnets"
  value       = module.karaoke_vpc.public_subnets_cidr_blocks
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = module.karaoke_vpc.vpc_cidr_block
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.karaoke_vpc.vpc_id
}