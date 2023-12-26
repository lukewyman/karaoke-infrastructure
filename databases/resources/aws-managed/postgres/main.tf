resource "kubernetes_service_v1" "postgres_service" {
  depends_on = [ aws_db_instance.postgres_instance ]

  metadata {
    name = "postgres"
    namespace = "${var.app_name}-${var.environment}"
  }

  spec {
    type = "ExternalName"
    external_name = aws_db_instance.postgres_instance.address
  }
}

resource "aws_db_instance" "postgres_instance" {
  allocated_storage      = var.allocated_storage
  deletion_protection    = false
  engine                 = var.db_engine
  engine_version         = var.db_engine_version
  identifier             = "${local.app_name}-postgresql-instance"
  instance_class         = var.db_instance_type
  username               = "postgres"
  password               = random_password.postgres_password.result
  port                   = var.db_port
  skip_final_snapshot    = true
  storage_type           = var.db_storage_type
  db_subnet_group_name   = aws_db_subnet_group.postgres_subnet_group.name
  vpc_security_group_ids = [aws_security_group.postgres_security_group.id]
}

resource "aws_db_subnet_group" "postgres_subnet_group" {
  name       = "${local.app_name}-postgres-subnet-group"
  subnet_ids = var.db_subnet_ids
}

resource "aws_ssm_parameter" "app_username" {
  name = "/app/karaoke/${var.environment}/APP_USERNAME"
  type = "String"
  value = var.postgres_app_username
}

resource "aws_ssm_parameter" "app_password" {
  name = "/app/karaoke/${var.environment}/APP_PASSWORD"
  type = "SecureString"
  value = random_password.password.result
}

resource "aws_ssm_parameter" "postgres_password" {
  name  = "/app/karaoke/${var.environment}/POSTGRES_PASSWORD"
  type  = "SecureString"
  value = random_password.postgres_password.result
}

resource "random_password" "app_password" {
  length  = 8
  special = false
}

resource "random_password" "postgres_password" {
  length  = 8
  special = false
}

resource "aws_security_group" "postgres_security_group" {
  name   = "${local.app_name}-postgres-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port = var.db_port
    to_port   = var.db_port
    protocol  = "tcp"
    cidr_blocks = concat(
      var.public_subnets_cidr_blocks,
      var.private_subnets_cidr_blocks
    )
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
