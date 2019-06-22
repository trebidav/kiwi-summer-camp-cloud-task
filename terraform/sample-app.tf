resource "kubernetes_namespace" "kiwi-summer-camp" {
  metadata {
    name = "kiwi-summer-camp"
  }
}


resource "kubernetes_replication_controller" "kiwi-summer-camp-app" {
  metadata {
    name = "kiwi-summer-camp-app"

    labels = {
      App = "KiwiSummerCampApp"
    }

    namespace = kubernetes_namespace.kiwi-summer-camp.metadata[0].name
  }

  spec {
    replicas = 2

    selector = {
      App = "KiwiSummerCampApp"
    }

    template {
      metadata {
        name = "kiwi-summer-camp-app"

        labels = {
          App = "KiwiSummerCampApp"
        }

        namespace = kubernetes_namespace.kiwi-summer-camp.metadata[0].name
      }
      spec {

        container {
          image = "davidtrebicky/kiwi-summer-camp-cloud-task:latest"
          name  = "kiwi-summer-camp-app"

          port {
            container_port = 5000
          }

          resources {
            limits {
              cpu    = "0.5"
              memory = "512Mi"
            }

            requests {
              cpu    = "250m"
              memory = "50Mi"
            }
          }

          liveness_probe {
            http_get {
              path = "/health"
              port = 5000
            }

            initial_delay_seconds = 3
            period_seconds        = 10
            timeout_seconds       = 3
          }

          readiness_probe {
            http_get {
              path = "/health"
              port = 5000
            }
            initial_delay_seconds = 3
            period_seconds        = 10
            timeout_seconds       = 3
          }
        }
      }
    }

  }
}

resource "kubernetes_service" "kiwi-summer-camp-app" {
  metadata {
    name      = "kiwi-summer-camp-app-svc"
    namespace = kubernetes_namespace.kiwi-summer-camp.metadata[0].name
  }

  spec {
    selector = {
      App = kubernetes_replication_controller.kiwi-summer-camp-app.metadata[0].labels.App
    }

    port {
      port = 80
    }

    type = "LoadBalancer"
  }
}

output "sample-app-url" {
  value = format("http://%s:%s", kubernetes_service.kiwi-summer-camp-app.load_balancer_ingress[0].ip, kubernetes_service.kiwi-summer-camp-app.spec[0].port[0].port)
}


