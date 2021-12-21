variable "project_id" {
  description = "The project ID to host the cluster in"
  default     = "dcc-322208"
}
variable "cluster_name" {
  description = "The name for the GKE cluster"
  default     = "dcc"
}
variable "env_name" {
  description = "The environment for the GKE cluster"
  default     = "staging"
}
variable "region" {
  description = "The region to host the cluster in"
  default     = "us-west1"
}
variable "network" {
  description = "The VPC network created to host the cluster in"
  default     = "non-prod-vpc"
}
variable "subnetwork" {
  description = "The subnetwork created to host the cluster in"
  default     = "non-prod-subnet"
}
variable "ip_range_pods_name" {
  description = "The secondary ip range to use for pods"
  default     = "ip-range-pods"
}
variable "ip_range_services_name" {
  description = "The secondary ip range to use for services"
  default     = "ip-range-services"
}