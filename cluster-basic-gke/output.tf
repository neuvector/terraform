#Outputs
output "region" {
  value       = var.region
  description = "region"
}

output "kubernetes_cluster_name" {
  value       = google_container_cluster.nvcluster.name
  description = "GKE Cluster Name"
}


output "kubernetes_cluster_endpoint" {
  value       = google_container_cluster.nvcluster.endpoint
  description = "GKE Cluster Endpoint"
}

# output "kubernetes_cluster_cert" {
#   value       = base64decode(google_container_cluster.nvcluster.master_auth.0.cluster_ca_certificate)
#   #value       = base64encode(google_container_cluster.nvcluster.master_auth.0.client_certificate)
#   description = "GKE Cluster Cert"
# }
