module "nv-gke-cluster" {
  source                = "git::https://github.com/devseclabs/gke-cluster.git"
  
  cluster_name          = "nvlabs"
  project_id            = "nv-demo"
    
}