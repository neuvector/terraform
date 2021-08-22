terraform {
  required_version = ">= 0.13"
}

provider "helm" {
  #version = "~> 1.3.2"
  kubernetes {
    #define locally $HOME/.kube/config
    #https://registry.terraform.io/providers/hashicorp/helm/latest/docs
   }
}
