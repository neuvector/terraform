# Terraform Neuvector Deployment [Helm]
## NV Helm deployment with parameters

## Versions

| Name | Version |
|------|---------|
| terraform | >= 0.13.0|
| terraform helm provider| ~> 1.3.2 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| tag | neuvector version to deploy or update | `string` | `{}` | yes |
| helm_name | helm name deployment | `string` | `{}` | no |
| ns | neuvector deployment namespace | `string` | `{}` | no |
| webui_service | NodePort/LoadBalancer ... | `string` | `[]` | yes |
| containerd | Set to true, if the container runtime is containerd | `bool` | `[]` | no |
| containerd_path | If containerd is enabled, this local containerd socket path will be used /var/run/containerd/containerd.sock	 | `string` | `[]` | no |
| scanner_replicas | # replicas of scanners | `string` | `[]` | yes |
| controller_replicas | # replicas of controllers | `string` | `[]` | yes |
| registry_username | dockerhub username | `string` | `[]` | yes |
| registry_password  | dockerhub password | `string` | `[]` | yes |


### Case 1: [clasic]
- Clone the repository: 

```
#> git clone https://github.com/neuvector/terraform
#> cd nv-module-helm/
```
- rename the file tfvars and update your nv helm values:
```
#> mv terraform.tfvars.tpl terraform.tfvars
#> vim terraform.tfvars
```

- [Important] export your context
```
export KUBE_CTX="demo"
export KUBE_CONFIG_PATH="~/.kube/config"
```


- save changes and deploy the cluster with terraform:  
```
terraform init
terraform plan -out cluster.out
terraform apply cluster.out
```


### Case 2:[module]

- [Important] export your context
```
export KUBE_CTX="demo"
export KUBE_CONFIG_PATH="~/.kube/config"
```

- if your are going to use modules, create your module file
```
#> git clone https://github.com/neuvector/terraform
#> cd nv-module-helm/module-example/
#> vim nv.tf

-------------------------
module "nv-deployment" {
    source              = "git::https://github.com/neuvector/terraform//nv-module-helm?ref=feature/cases"
    # neuvector settings
    tag                 ="4.3.1"
    scanner_replicas    = "3"
    controller_replicas = "3"
    webui_service       = "LoadBalancer"

    # registry settings
    registry_username   = "user"
    #password path file
    registry_password   = "/path/registry.secret"
}
```

- save changes and deploy the cluster with terraform:  
```
terraform init
terraform plan -out cluster.out
terraform apply cluster.out
```

### Clean Up
- destroy your deployment: 
```
terraform destroy
```
