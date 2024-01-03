resource "kubernetes_job_v1" "mongo_migrations" {
  metadata {
    name      = "mongo-migrations"
    namespace = local.app_name
  }

  spec {
    template {
      metadata {
        name = "mongo-migrations"
      }
      spec {
        service_account_name = var.service_account_name

        container {
          name    = "mongo-migrations"
          image   = "mongo:7.0.5-rc0"
          command = ["bin/bash", "-c", "mongosh --host mongo --port 27017 --username admin --password password1  --file create_db.js"]

        }

        volume {
          name = "mongo-script"
          config_map {
            name = kubernetes_config_map_v1.migration_files.metadata.0.name
          }
        }
      }
    }
  }
}

resource "kubernetes_config_map_v1" "migration_files" {
  metadata {
    name      = "mongo-migration-files"
    namespace = local.app_name
  }

  data = {

  }
}