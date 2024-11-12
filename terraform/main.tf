# Configure the Google Cloud provider
provider "google" {
  credentials = file("/Users/elitamsut/new-task-gke/my-gke-tf/eli-tamsut-devops-assessment-e1dc29958dcc.json")
  project     = "eli-tamsut-devops-assessment"
  region      = "me-west1"
  zone        = "me-west-a"
}



# Invoke the cluster module which creates VPC, subnet, and GKE cluster with a default worker node pool
module "cluster" {
  source = "./cluster"

  region       = var.region
  cluster_name = var.cluster_name
  k8s_version  = var.k8s_version
}
