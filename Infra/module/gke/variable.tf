# --- Project and region ---
variable "project_id" {
  description = "GCP project ID where resources will be created"
  type        = string
}

variable "region" {
  description = "Region for the GKE cluster"
  type        = string
  default     = "us-central1"
}

# --- Network ---
variable "vpc_network" {
  description = "The VPC network name where the cluster will be deployed"
  type        = string
}

variable "subnetwork" {
  description = "The subnetwork name where the cluster nodes will run"
  type        = string
}

# --- Cluster ---
variable "cluster_name" {
  description = "The name of the GKE cluster"
  type        = string
}

variable "cluster_version" {
  description = "The Kubernetes version for the GKE cluster"
  type        = string
  default     = "1.29"
}

# --- Node Pools ---
variable "node_groups" {
  description = <<EOT
Map of node pools for the GKE cluster.
Example:
node_groups = {
  "default-pool" = {
    instance_types = ["e2-medium"]
    capacity_type  = "ON_DEMAND"   # or "SPOT"
    scaling_config = {
      min_size     = 1
      desired_size = 2
      max_size     = 3
    }
  }
}
EOT
  type = map(object({
    instance_types = list(string)
    capacity_type  = string
    scaling_config = object({
      min_size     = number
      desired_size = number
      max_size     = number
    })
  }))
}
