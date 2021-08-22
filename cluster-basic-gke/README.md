# Terraform Deployment - Simple Test Cluster [GKE]

## Versions:

| Name | Version |
|------|---------|
| terraform | >= 0.13.0|

## Inputs - (terraform.tfvars & module)

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cluster_name | cluster Name | `string` | `{}` | yes |
| project_id | project id to deploy the cluster | `string` | `{}` | yes |
| gke_num_nodes | default nodes number 1| `number` | `{}` | no |
| image | default image - ubuntu | `string` | `{}` | no |

## Outputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| GKE Cluster Name | Cluster Name | `string` | `{}` | yes |
| GKE Cluster Endpoint | Cluster Endpoint | `string` | `{}` | yes |

## Steps:
- Authenticate with your google account:
    ```
    gcloud auth application-default login
    gcloud config set project PROJECT_ID
    ```
 
### Case 1: [tfvars]

- Clone the repository: 

```
#> git clone https://github.com/neuvector/terraform
#> cd cluster-basic-gke/
```
- rename the file tfvars and update your values:
```
#> mv terraform.tfvars.tpl terraform.tfvars
#> vim terraform.tfvars
```

- save changes and deploy the cluster with terraform:  
```
terraform init
terraform plan -out cluster.out
terraform apply cluster.out
```
   
- Get the gke cluster credentials:
```
#get clusters
gcloud container clusters list
# get context
gcloud container clusters get-credentials [cluster-name] --zone [zone] --project [project-id]
```

### Case 2: [Module] 

- Edit the gke.tf file in the module-example folder with appropriate values:

```
#> git clone https://github.com/neuvector/terraform
#> cd cluster-basic-gke/module-example/
#> vim gke.tf

-------------------------
module "nv-gke-cluster" {
  source                = "git::https://github.com/neuvector/terraform//cluster-basic-gke?ref=feature/cases"
  
  cluster_name          = "nvlabs"
  project_id            = "nv-demo"
    
}"
```

- save changes and deploy the cluster with terraform:  
```
terraform init
terraform plan -out cluster.out
terraform apply cluster.out
```

- Get the gke cluster credentials:
```
#get clusters
gcloud container clusters list
# get context
gcloud container clusters get-credentials [cluster-name] --zone [zone] --project [project-id]
```

### Clean Up [warning]
- before destroy, remove all the deployments and servcies in the cluster to delete the load balancers.  
- destroy your deployment: 
```
terraform destroy
```
