resource "kubernetes_service_v1" "docdb_service" {
  depends_on = [ aws_docdb_cluster.docdb ]

  metadata {
    name = "mongo"
    namespace = "${var.app_name}-${var.environment}"
  }

  spec {
    type = "ExternalName"
    external_name = aws_docdb_cluster.docdb.endpoint
  }
}

resource "aws_docdb_cluster" "docdb" {
  cluster_identifier              = "${local.app_name}-cluster"
  engine                          = "docdb"
  engine_version                  = var.docdb_engine_version
  db_cluster_parameter_group_name = aws_docdb_cluster_parameter_group.docdb_parameter_group.name
  master_username                 = aws_ssm_parameter.admin_username.value
  master_password                 = aws_ssm_parameter.admin_password.value
  deletion_protection             = false
  port                            = var.docdb_port
  db_subnet_group_name            = aws_docdb_subnet_group.docdb_subnets.name
  vpc_security_group_ids          = [aws_security_group.documentdb_sg.id]
  skip_final_snapshot             = true
  storage_encrypted               = false
}

resource "aws_docdb_cluster_parameter_group" "docdb_parameter_group" {
  family = "docdb4.0"
  name   = "${local.app_name}-pg"

  parameter {
    name  = "tls"
    value = "disabled"
  }
}

resource "aws_docdb_cluster_instance" "cluster_instances" {
  count              = var.docdb_instance_count
  identifier         = "${local.app_name}-docdb-instance-${count.index}"
  cluster_identifier = aws_docdb_cluster.docdb.id
  instance_class     = var.docdb_instance_class
}

resource "aws_docdb_subnet_group" "docdb_subnets" {
  name       = "${local.app_name}-docdb-subnet-group"
  subnet_ids = var.docdb_subnet_ids
}

resource "aws_ssm_parameter" "admin_username" {
  name = "/app/${var.app_name}/${var.environment}/mongo/USERNAME"
  type = "String"
  value = "mongo_admin"
}

resource "aws_ssm_parameter" "admin_password" {
  name = "/app/${var.app_name}/${var.environment}/mongo/PASSWORD"
  type = "SecureString"
  value = random_password.admin_password.result
}

resource "random_password" "admin_password" {
  length = 8
  special = false
}

resource "aws_security_group" "documentdb_sg" {
  name   = "${local.app_name}${terraform.workspace}-docdb-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port = var.docdb_port
    to_port   = var.docdb_port
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