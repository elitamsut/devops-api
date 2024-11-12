# Setup Google Terraform provider
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.74.0"
    }
  }
}

locals {
  # Zones: selects the first 3 available zones in the region
  zones = slice(data.google_compute_zones.available.names, 0, 3)

  # Project services to be enabled
  services = toset(["compute", "container", "cloudresourcemanager"])

  # Picking the latest available Kubernetes master version
  master_version = length(data.google_container_engine_versions.main.valid_master_versions) > 0 ? data.google_container_engine_versions.main.valid_master_versions[0] : "1.27.0"
}

# Allows management of a single API service for a Google Cloud Platform project.
resource "google_project_service" "main" {
  for_each           = local.services
  service            = "${each.value}.googleapis.com"
  disable_on_destroy = false
}

# To extract the available compute zones for the provided region
data "google_compute_zones" "available" {
  region     = var.region
  status     = "UP"
  depends_on = [google_project_service.main]
}

# To retrieve the latest Kubernetes version available in the region
data "google_container_engine_versions" "main" {
  location = var.region
}

# GKE cluster resource
resource "google_container_cluster" "gke" {
  name               = var.cluster_name
  location           = var.region
  node_locations     = local.zones # Set the node locations once

  min_master_version = local.master_version

  # Prevent automatic updates to the cluster
  release_channel {
    channel = "UNSPECIFIED"
  }

  remove_default_node_pool = true
  initial_node_count       = 1

  network    = var.network
  subnetwork = var.subnetwork

  enable_kubernetes_alpha = false
}

# Self-managed node pool
resource "google_container_node_pool" "nodepools" {
  for_each = var.nodepools

  name       = each.value.name
  location   = var.region
  cluster    = var.cluster_name
  node_count = each.value.node_count

  autoscaling {
    min_node_count = each.value.min_node_count  # Ensure min_node_count is defined in the input
    max_node_count = each.value.max_node_count  # Ensure max_node_count is defined in the input
  }

  management {
    auto_repair  = true
    auto_upgrade = false
  }

  node_config {
    machine_type = "e2-medium"  # Machine type used: n1-standard-1
    labels       = each.value.node_labels
  }

  lifecycle {
    ignore_changes = [
      initial_node_count,
      node_count,
      node_config,
      node_locations
    ]
  }

  version    = local.master_version
  depends_on = [google_container_cluster.gke]
}
