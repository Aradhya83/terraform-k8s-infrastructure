resource "kubernetes_namespace" "app" {
  metadata {
    name = var.namespace
  }
}


resource "kubernetes_config_map" "app_config" {
  metadata {
    name      = "app-config"
    namespace = kubernetes_namespace.app.metadata[0].name
  }

  data = {
    APP_ENV = var.environment
  }
}


resource "kubernetes_secret" "app_secret" {
  metadata {
    name      = "app-secret"
    namespace = kubernetes_namespace.app.metadata[0].name
  }

  type = "Opaque"

  data = {
    APP_USERNAME = "admin"
    APP_PASSWORD = "password123"
  }
}


resource "kubernetes_deployment" "app" {
  metadata {
    name      = "my-app"
    namespace = kubernetes_namespace.app.metadata[0].name

    labels = {
      app = "my-app"
    }
  }

  spec {
    replicas = var.replicas

    selector {
      match_labels = {
        app = "my-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "my-app"
        }
      }

      spec {
        container {
          name  = "my-app"
          image = var.image

          port {
            container_port = 80
          }

          env {
            name = "APP_ENV"

            value_from {
              config_map_key_ref {
                name = kubernetes_config_map.app_config.metadata[0].name
                key  = "APP_ENV"
              }
            }
          }

          env {
            name = "APP_USERNAME"

            value_from {
              secret_key_ref {
                name = kubernetes_secret.app_secret.metadata[0].name
                key  = "APP_USERNAME"
              }
            }
          }

          env {
            name = "APP_PASSWORD"

            value_from {
              secret_key_ref {
                name = kubernetes_secret.app_secret.metadata[0].name
                key  = "APP_PASSWORD"
              }
            }
          }
        }
      }
    }
  }
}


resource "kubernetes_service" "app" {
  metadata {
    name      = "my-app-service"
    namespace = kubernetes_namespace.app.metadata[0].name
  }

  spec {
    selector = {
      app = "my-app"
    }

    port {
      port        = 80
      target_port = 80
    }

    type = "ClusterIP"
  }
}