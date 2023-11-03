module "bastion" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.5.0"

  name                   = "${local.app_name}-bastion-host"
  ami                    = data.aws_ami.amzlinux2.id
  instance_type          = var.instance_type
  key_name               = var.instance_keypair
  subnet_id              = var.subnet_ids[0]
  vpc_security_group_ids = [module.bastion_sg.security_group_id]
}

module "bastion_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name                = "${local.app_name}-bastion-sg"
  description         = "Security Group with SSH port allowing all traffic"
  vpc_id              = var.vpc_id
  ingress_rules       = ["ssh-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules        = ["all-all"]
}