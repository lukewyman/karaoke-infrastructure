output "instance_id" {
  description = "Instance id of the bastion host"
  value       = module.bastion.id
}

output "instance_public_dns" {
  description = "Public DN of the bastion host"
  value       = module.bastion.public_dns
}

output "instance_public_ip" {
  description = "Public IP of the bastion host"
  value       = module.bastion.public_ip
}