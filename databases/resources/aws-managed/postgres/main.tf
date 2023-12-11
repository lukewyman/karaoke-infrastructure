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
  username               = local.postgres_user
  password               = random_password.password.result
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

resource "aws_ssm_parameter" "postgres_password" {
  name  = "/app/karaoke/${var.environment}/POSTGRES_PASSWORD"
  type  = "SecureString"
  value = random_password.password.result
}

resource "random_password" "password" {
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



resource "kubernetes_job_v1" "postgres_migrations" {
  metadata {
    name = "postgres-migrations"
    namespace = "${var.app_name}-${var.environment}"
  }

  spec {
    template {
      metadata {
        
      }
      spec {
        container {
          name = "postgres-migrations"
          image = "flyway/flyway"
          args = ["migrate"]

          env {
            name = "FLYWAY_URL"
            value = local.flyway_db_url
          }
          env {
            name = "FLYWAY_USER"
            value = local.postgres_user
          }
          env {
            name = "FLYWAY_PASSWORD"
            value_from {
              secret_key_ref {
                name = kubernetes_secret_v1.postres_password.metadata.0.name 
                key = "POSTGRES_PASSWORD"
              }
            }
          }

          volume_mount {
            name = "sql"
            mount_path = "/flyway/sql"            
          }
        }
        volume {
          name = "sql"
          config_map {
            name = kubernetes_config_map_v1.migration_files.metadata.0.name
          }
        }
        restart_policy = "Never"
      }
    }
  }
}

resource "kubernetes_config_map_v1" "migration_files" {
  metadata {
    name = "postgres-migrations-files"
    namespace = "${var.app_name}-${var.environment}"
  }

  data = {for f in local.migrations: f => file("${var.migrations_dir}/${f}")}
}

resource "kubernetes_secret_v1" "postres_password" {
  metadata {
    name = "postgres-password"
    namespace = "${var.app_name}-${var.environment}"
  }

  data = {
    "POSTGRES_PASSWORD" = aws_ssm_parameter.postgres_password.value
  }
}