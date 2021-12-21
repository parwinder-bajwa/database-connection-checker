terraform {
  backend "gcs" {
    bucket      = "dcc-tf-state"
    prefix      = "terraform/kubernetes_cluster"
    credentials = "../../dcc-322208-ab2e0dc1b1f7.json"
  }
}

provider "google" {
  credentials = file("../../dcc-322208-ab2e0dc1b1f7.json")
  project     = var.project_id
  region      = var.region
}

module "kube_cluster" {
  source            = "../../../modules/GKE"
  project_id        = var.project_id
  name              = "${var.cluster_name}-${var.env_name}"
  regional          = true
  region            = var.region
  network           = var.network
  subnetwork        = var.subnetwork
  ip_range_pods     = var.ip_range_pods_name
  ip_range_services = var.ip_range_services_name
  node_pools = [
    {
      name                      = "non-prod-node-pool"
      machine_type              = "e2-small"
      node_locations            = "us-west2-a,us-west2-b,us-west2-c"
      min_count                 = 1
      max_count                 = 2
      disk_size_gb              = 30
    },
  ]
}
 