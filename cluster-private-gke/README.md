# Terraform Deployment - Private Cluster [GKE]
private gke cluster + custom network + bastion host

## Steps:
- Step 1: Authenticate with your google account:
    ```
    gcloud auth application-default login
    gcloud config set project PROJECT_ID
    ```
 
- Step 2 : Clone this repo: 
```
#> git clone https://github.com/neuvector/terraform
#> cd cluster-private-gke/
```
- Step 3 : Update the terraform vars  file:
```
#rename terraform.tfvars.tpl to terraform.tfvars
mv  terraform.tfvars.tpl terraform.tfvars

# Set your values
prefix = "your-awesome-prefix"
project_id = "your-project-id"
num_nodes = 3

```

- Step 4: save changes and deploy the private cluster
```
terraform init
terraform plan -out cluster.out
terraform apply cluster.out
```

- Step 5: Get and copy the external bastion ip address:
```
gcloud compute instances list | grep bastion
```
- Step 6: Configure your ssh keys in [your metadata gcp project](https://cloud.google.com/compute/docs/instances/adding-removing-ssh-keys), then set your ssh config for the bastion connection:

```
vim ~/.ssh/config
```
- paste this config inside with the external ip address:
```
Host bastion-cluster
  HostName [BASTION-EXTERNAL-IP]
  User [SSH-USER]
  IdentityFile [PATH-SSH-PRIVATE-KEY]
```
- Step 5: Set your bastion with proxy to get access to the private cluster using ssh tunnel:
```
ssh bastion-cluster
```

- Step 6: Configure in your bastion host a basic proxy:
```
# run in the bastion
sudo apt-get install tinyproxy
sudo echo "Allow localhost" > /etc/tinyproxy/tinyproxy.conf
sudo service tinyproxy restart
```
- Step 7: Get your cluster context in your host machine:

```
CLUSTER_NAME="cluster-name"
CLUSTER_ZONE="cluster-zone"
CLUSTER_PROJECT_NAME="project-name"

gcloud container clusters get-credentials $CLUSTER_NAME \
  --zone $CLUSTER_ZONE \
  --project $CLUSTER_PROJECT_NAME
```

- Step 8: Configure the ssh tunnel and proxy in your host machine:

```
BASTION_INSTANCE_NAME="bastion-name"

gcloud compute ssh $BASTION_INSTANCE_NAME \
  --project $CLUSTER_PROJECT_NAME \
  --zone $CLUSTER_ZONE \
  --  -L 8888:localhost:8888 -N -q -f
```

- Step 9: configure the secure alias to manage your cluster:
```
vim ~/.bash_profile
#add the alias
alias kp='HTTPS_PROXY=localhost:8888 kubectl'
# save your changes
source ~/.bash_profile
```
- Step 10: test your cluster connection:
```
kp get nodes
```

### Clean Up
- destroy your deployment: 
```
terraform destroy
```

