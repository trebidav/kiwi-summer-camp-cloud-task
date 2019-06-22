provider "google" {
  # project to deploy to
  project = "kiwi-summer-camp"

  # default region
  region = "europe-west3"

  # default zone
  zone = "europe-west3-a"

  # edit the path for your credentials file 
  # the service acoount should have correct rights to create kubernetes cluster
  credentials = file("kiwi-summer-camp.json")
}

data "google_client_config" "current" {
}

provider "kubernetes" {
  load_config_file       = false
  host                   = "https://${google_container_cluster.gke-cluster.endpoint}"
  cluster_ca_certificate = base64decode(google_container_cluster.gke-cluster.master_auth[0].cluster_ca_certificate)
  token                  = data.google_client_config.current.access_token
}

