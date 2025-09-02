# --- Project and Region ---
variable "project_id" {
  description = "The GCP project ID where resources will be created"
  type        = string
}

variable "region" {
  description = "The region where VPC and subnets will be created"
  type        = string
  default     = "us-central1"
}

variable "cluster_name" {
  description = "Name prefix for resources (used for VPC, subnets, NAT)"
  type        = string
}

# --- Subnet CIDRs ---
variable "private_subnet_cidrs" {
  description = "List of CIDR ranges for private subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "public_subnet_cidrs" {
  description = "List of CIDR ranges for public subnets"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
