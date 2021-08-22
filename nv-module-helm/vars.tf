# dockerhub conf
variable "registry_server" {
    #default = "https://index.docker.io/v1/"
    default = "https://registry.neuvector.com"
}

variable "registry_username" {}
variable "registry_password" {}

variable "ns" {
    default = "neuvector"
}

variable "env_name" {
    default = "nvlabs"
}

variable "scanner_replicas" {
    default = "3"
}

variable "controller_replicas" {
    default = "3"
}

variable "containerd" {
    default = "false"
}

variable "containerd_path" {
    default = "/var/run/containerd/containerd.sock"
}

variable "webui_service" {}

variable "tag" {}

variable "secret_name" {
    default = "regsecret"
}
variable "helm_repo" {
    default = "https://neuvector.github.io/neuvector-helm/"
    #default = "https://raw.githubusercontent.com/achdevops/nv-helm/main"
}

variable "helm_chart" {
    default = "core"
    #default = "nv-chart"
}
variable "helm_name" {
    default = "my-release"
}

variable "admin_pass" {
  default = "admin"
  #sensitive = true
}

variable "reader_pass" {
  default = "demouser123"
  #sensitive = true
}

variable "with_configmap" {
  default = false
}

variable "license" {
  #sensitive = true
}
