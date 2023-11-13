# resource "kubernetes_config_map_v1" "config_map" {
#   metadata {
#     name = "db-creation-script"
#   }

#   data = {
#     "init" = "${file("${path.module}/db_scripts/file_name???")}"
#   }
# }

resource "helm_release" "mongodb" {
  name = "${local.app_name}-mongodb"
  repository = "https://charts.bitnami.com/bitnami"
  chart = "mongodb"
  version = "14.2.5"

  set {
    name = "architecture"
    value = "standalone"
  }

  set {
    name = "useStatefulSet"
    value = true
  }

  set {
    name = "global.storageClass"
    value = "ebs-sc"
  }
  
}