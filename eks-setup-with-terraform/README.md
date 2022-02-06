#  **<span style="color:green">Landmark Technologies, Ontario, Canada.</span>**
### **<span style="color:green">Contacts: +1437 215 2483<br> WebSite : <http://mylandmarktech.com/></span>**
### **Email: mylandmarktech@gmail.com**
# Landmark Technologies,  -    Landmark Technologies 
# Tel: +1 437 215 2483,   -     +1 437 215 2483 
#    www.mylandmarktech.com 
# Terraform Installation And Setup In AWS EC2 Linux Instances
#  Using Terraform to provision a fully managed Amazon EKS Cluster

##### Prerequisite
+ AWS Acccount.
+ Create an ubuntu EC2 Instnace.
+ Create IAM Role With Required Policies.
   + VPCFullAccess
   + EC2FullAcces
   + S3FullAccess  ..etc
   + Administrator Access
+ Attach IAM Role to EC2 Instance.

### Install Terraform
```sh
sudo adduser eksadmin
sudo echo "eksadmin  ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/eksadmin
sudo su - eksadmin
```
``` sh
$ git clone https://github.com/mylandmarktechs/eks-terraform-setup
$ cd eks-terraform-setup
# install terraform using a bash shell script
$ sh terraform-install.sh
# OR install terraform by running the commands below
$ wget https://releases.hashicorp.com/terraform/0.12.26/terraform_0.12.26_linux_amd64.zip
$ sudo unzip terraform_0.12.26_linux_amd64.zip -d /usr/local/bin/
# Export terraform binary path temporally
$ export PATH=$PATH:/usr/local/bin
# Add path permanently for current user.By Exporting path in .bashrc file at end of file.
$ vi .bashrc
   export PATH="$PATH:/usr/local/bin"
# Source .bashrc to reflect for current session
$ source ~/.bashrc  
# run the scripts https://github.com/mylandmarktechs/eks-terraform-setup/blob/main/terraform-install.sh

$ sudo yum install wget unzip -y
$ wget https://releases.hashicorp.com/terraform/0.12.26/terraform_0.12.26_linux_amd64.zip
$ sudo unzip terraform_0.12.26_linux_amd64.zip -d /usr/local/bin/
# Export terraform binary path temporally
$ export PATH=$PATH:/usr/local/bin
# Add path permanently for current user.By Exporting path in .bashrc file at end of file.
$ vi .bashrc
   export PATH="$PATH:/usr/local/bin"
# Source .bashrc to reflect for current session
 source ~/.bashrc  
# run the scripts https://github.com/mylandmarktechs/eks-terraform-setup/blob/main/terraform-install.sh
```
#### Clone terraform scripts
``` sh
$ git clone https://github.com/mylandmarktechs/eks-terraform-setup
$ cd eks-terraform-setup
```
#### <span style="color:orange">Update Your Key Name in variables.tf file before executing terraform script.</span>
## Infrastructure As A Code using Terraform
#### Create Infrastructure(Amazon EKS, IAM Roles, AutoScalingGroups, Launch Configuration, LoadBalancer, NodeGroups,VPC,Subnets,Route Tables,Security Groups, NACLs, ..etc) As A Code Using Terraform Scripts
``` sh
# Initialise to install plugins
$ terraform init 
# Validate terraform scripts
$ terraform validate 
# Plan terraform scripts which will list resources which is going  be created.
$ terraform plan 
# Apply to create resources
$ terraform apply --auto-approve
```

```sh
##  Destroy Infrastructure  
$ terraform destroy --auto-approve

## create the kubeconfig file  
$ mkdir .kube/ 
$ vi .kube/config
$ kubectl get pod
$ #!/bin/bash 
$ sh iam-authenticator.sh 
$ kubectl get pod
## deploy cluster auto scaler
$ kubectl apply -f clusterautoscaler.yml

 ```
```
##  Destroy Infrastructure  
```sh
$ terraform destroy --auto-approve 
```


# EKS Getting Started Guide Configuration

This is the full configuration from https://www.terraform.io/docs/providers/aws/guides/eks-getting-started.html

See that guide for additional information.

NOTE: This full configuration utilizes the [Terraform http provider](https://www.terraform.io/docs/providers/http/index.html) to call out to icanhazip.com to determine your local workstation external IP for easily configuring EC2 Security Group access to the Kubernetes servers. Feel free to replace this as necessary.


kubectl create deployment autoscaler-demo --image=nginx
kubectl get pods --all-namespaces | grep Running | wc -l
kubectl get nodes -o yaml | grep pods
kubectl scale deployment autoscaler-demo --replicas=20
https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html
aws-iam-authenticator help
