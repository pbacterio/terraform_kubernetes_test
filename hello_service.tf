resource "kubernetes_replication_controller" "hello-app" {
  metadata {
    name = "hello-app"
  }
  spec {
    selector {
      app = "hello-app"
    }
    template {
      container {
        image = "pbacterio/demoapp"
        name  = "helloapp"
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
      port = 8080
      target_port = 8080
    }
  }
}
