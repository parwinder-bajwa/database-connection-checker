terraform {
  backend "gcs" {
    bucket      = "dcc-tf-state"
    prefix      = "terraform/resources/kubernetes-clusters/production/states.tfstate"
  }
}

provider "google" {
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
      name                      = "prod-node-pool"
      machine_type              = "e2-standard-2"
      node_locations            = "us-west2-a,us-west2-b,us-west2-c"
      min_count                 = 3
      max_count                 = 5
      disk_size_gb              = 60
    },
  ]
}
 