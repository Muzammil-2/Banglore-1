variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "Region to deploy resources"
  type        = string
  default     = "us-central1"
}

variable "vpc_cidr" {
  description = "CIDR range for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnets" {
  description = "Subnets in the VPC"
  type        = map(any)
}

variable "secondary_ranges" {
  description = "Secondary IP ranges for subnets (needed for GKE)"
  type        = map(any)
}

variable "network_name" {
  description = "Name of the VPC network"
  type        = string
}

variable "cluster_name" {
  description = "Name of GKE cluster"
  type        = string
}

variable "cluster_version" {
  description = "GKE version"
  type        = string
  default     = "1.29"
}

variable "node_pools" {
  description = "Node pool configs"
  type        = map(any)
}
