# --- Service account for GKE nodes (instead of IAM role for node group) ---
resource "google_service_account" "gke_nodes" {
  account_id   = "${var.cluster_name}-nodes"
  display_name = "GKE Node Service Account"
}

# IAM roles for the node service account
# Equivalent to AmazonEKSWorkerNodePolicy, CNI Policy, ECR ReadOnly
# GKE needs cloud-platform scope + specific IAM roles
resource "google_project_iam_member" "gke_node_roles" {
  for_each = toset([
    "roles/container.nodeServiceAgent",
    "roles/logging.logWriter",
    "roles/monitoring.metricWriter",
    "roles/monitoring.viewer"
  ])
  project = var.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.gke_nodes.email}"
}

# --- GKE Cluster (like aws_eks_cluster) ---
resource "google_container_cluster" "main" {
  name     = var.cluster_name
  location = var.region

  network    = var.vpc_network
  subnetwork = var.subnetwork

  initial_node_count = 1  # required but usually overridden by node pools

  remove_default_node_pool = true
  deletion_protection      = false

  release_channel {
    channel = "REGULAR"
  }

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }
}

# --- Node Pools (like aws_eks_node_group) ---
resource "google_container_node_pool" "main" {
  for_each = var.node_groups

  name       = each.key
  cluster    = google_container_cluster.main.name
  location   = var.region
  node_count = each.value.scaling_config.desired_size

  node_config {
    machine_type    = each.value.instance_types[0]
    preemptible     = each.value.capacity_type == "SPOT" ? true : false
    service_account = google_service_account.gke_nodes.email
    oauth_scopes    = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  autoscaling {
    min_node_count = each.value.scaling_config.min_size
    max_node_count = each.value.scaling_config.max_size
  }

  management {
    auto_upgrade = true
    auto_repair  = true
  }
}
