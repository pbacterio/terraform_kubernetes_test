resource "kubernetes_replication_controller" "hello-app" {
  metadata {
    name = "hello-app"
  }

  spec {
    selector {
      app = "hello-app"
    }

    replicas = 2

    template {
      container {
        image = "pbacterio/demoapp"
        name  = "hello-app"

        env {
          name = "NAME"

          value_from {
            config_map_key_ref = {
              name = "hello-app"
              key  = "name"
            }
          }
        }

        volume_mount {
          name       = "hello-app"
          mount_path = "/conf"
        }
      }

      volume {
        name = "hello-app"

        config_map {
          name = "hello-app"
        }
      }
    }
  }
}

resource "kubernetes_service" "hello-app" {
  metadata {
    name = "hello-app"
  }

  spec {
    selector {
      app = "hello-app"
    }

    port {
      port        = 8080
      target_port = 8080
    }
  }
}

resource "kubernetes_config_map" "hello-app" {
  metadata {
    name = "hello-app"
  }

  data {
    name = "KLAATU BARADA NIKTO"
  }
}
