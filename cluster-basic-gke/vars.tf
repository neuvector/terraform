
# VARS

variable "project_id" {}


variable "cluster_name" {
    default = "lab-gke"
}

# variable "gke_username" {}

# variable "gke_password" {}

variable "gke_num_nodes" {
    default = "3"
}

variable "machine" {
    default = "e2-medium"
}

variable "image" {
    default = "ubuntu"
}

variable "region" {
    default = "us-central1"
}

variable "zone" {
    default = "us-central1-c"
}

variable "net_cidr" {
    default = "10.16.0.0/24"
}
