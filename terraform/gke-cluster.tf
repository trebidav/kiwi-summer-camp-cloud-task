resource "random_string" "password" {
  length  = 64
  special = false
}

resource "google_container_cluster" "gke-cluster" {
  name    = "gke-cluster"
  network = "default"

  remove_default_node_pool = false
  initial_node_count       = 2

  master_auth {
    username = "kiwi-summer-camp"
    password = random_string.password.result

    client_certificate_config {
      issue_client_certificate = false
    }
  }
}

