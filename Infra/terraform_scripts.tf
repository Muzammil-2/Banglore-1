google_compute_network "network"{
    name = gcp_vpc
    region = us-central-1
}

google_compute_subnetwork "sunetwork" {
    network =
    name =
    cidr = 
    availability_zone =
}

google_compute_instance "instance" {
    name =
    network =
    subnetwork=
    machine_type=
}