# --- VPC ---
resource "google_compute_network" "main" {
  name                    = "${var.cluster_name}-vpc"
  auto_create_subnetworks = false   # custom mode VPC (like AWS)
}

# --- Subnets (private + public combined) ---
resource "google_compute_subnetwork" "private" {
  count         = length(var.private_subnet_cidrs)
  name          = "${var.cluster_name}-private-${count.index + 1}"
  ip_cidr_range = var.private_subnet_cidrs[count.index]
  region        = var.region
  network       = google_compute_network.main.id

  private_ip_google_access = true   # allow private subnets to reach Google APIs

  secondary_ip_range {
    range_name    = "pods"
    ip_cidr_range = var.private_pods_cidrs[count.index]
  }

  secondary_ip_range {
    range_name    = "services"
    ip_cidr_range = var.private_services_cidrs[count.index]
  }
}

resource "google_compute_subnetwork" "public" {
  count         = length(var.public_subnet_cidrs)
  name          = "${var.cluster_name}-public-${count.index + 1}"
  ip_cidr_range = var.public_subnet_cidrs[count.index]
  region        = var.region
  network       = google_compute_network.main.id
}

# --- Cloud Router (needed for NAT) ---
resource "google_compute_router" "main" {
  name    = "${var.cluster_name}-router"
  region  = var.region
  network = google_compute_network.main.id
}

# --- Cloud NAT (instead of AWS NAT Gateway + EIP) ---
resource "google_compute_router_nat" "main" {
  name   = "${var.cluster_name}-nat"
  router = google_compute_router.main.name
  region = var.region

  nat_ip_allocate_option             = "AUTO_ONLY" # auto-assign ephemeral IPs
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  subnetwork {
    name                    = google_compute_subnetwork.private[0].name
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

  # if multiple private subnets:
  dynamic "subnetwork" {
    for_each = google_compute_subnetwork.private
    content {
      name                    = subnetwork.value.name
      source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
    }
  }
}
