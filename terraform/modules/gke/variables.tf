variable "region" {
  description = "The region to deploy the cluster in"
  type        = string
  default     = "me-west1"
}

variable "k8s_version" {
  description = "The Kubernetes version to use"
  type        = string
  default     = "1.27" # Replace with a valid Kubernetes version
}

variable "cluster_name" {
  description = "The name of the GKE cluster"
  type        = string
  default     = "gke-test"
}

variable "network" {
  description = "The network the GKE cluster will use"
  type        = string
  default     = "default"
}

variable "subnetwork" {
  description = "The subnetwork the GKE cluster will use"
  type        = string
  default     = "default"
}

variable "nodepools" {
  description = "The configuration for the node pools"
  type = map(object({
    name           = string
    node_count     = number
    machine_type   = string
    node_labels    = map(string)
    min_node_count = number
    max_node_count = number
  }))
  default = {
    pool1 = {
      name           = "pool-1"
      node_count     = 1
      machine_type   = "e2-medium"
      node_labels    = {}
      min_node_count = 1
      max_node_count = 3
    }
  }
}
