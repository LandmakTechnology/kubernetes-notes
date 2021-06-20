
# Landmark Technologies == Kubernetes Dasboard (UI)
- 

## Step-00: Introduction
- We can access and manage Kubernetes using Kubernetes Dasboard
  - Deployment of Kubernetes Dasboard

## Step-01: Certificates 
- We shall create dashboard.key and dashboard.csr files for HTTPS'
- We shall create self signed dashboard.key & dashboard.csr
### create dashboard.key and dashboard.csr open openssl
```
# create dashboard.key and dashboard.csr open openssl 
#Create the require namespace and deploy the dashboard
mkdir $HOME/certs
cd certs/
openssl genrsa -out dashboard.key 2048
openssl req -sha256 -new -key dashboard.key -out dashboard.csr
openssl x509 -req -sha256 -days 365 -in dashboard.csr -signkey dashboard.key -out dashboard.crt
kubectl create ns kubernetes-dashboard
kubectl -n kubernetes-dashboard create secret generic kubernetes-dashboard-certs --from-file=$HOME/certs
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-beta7/aio/deploy/recommended.yaml

# verify if the pods is running
kubectl get all -n kubernetes-dashboard
```
### verify if the kubernetes-dashboard pods are  running
```
# Verify  
kubectl get pod -n kubernetes-dashboard
```
## Step-02: Create an k8s-admin serviceAccount to access the dashboard
### ServiceAccount for k8s-admin
```yml
# ServiceAccount.yml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: k8s-admin
  namespace: kubernetes-dashboard
---
# Create ClusterRoleBinding for the k8s-admin
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRoleBinding
metadata:
  name: k8s-admin
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: k8s-admin
  namespace: kubernetes-dashboard
```
### create service Account
```
# create service Account
kubectl apply -f ServiceAccount.yml 
```
### Edit kubernetes-dashboard service to NodePort
- **Observation:** kubernetes-dashboard default service is ClusterIP 
```
# Edit kubernetes-dashboard service 
kubectl get all -n kubernetes-dashboard
```
### Access the Dasboard using token
```
# Get token
kubectl  -n kubernetes-dashboard describe secret $(kubectl  -n kubernetes-dashboard get secret | grep k8s-admin | awk '{print $1}')
```

### Access the kubernetes-dashboard using Public IP
```
# Get NodePort
kubectl get svc kubernetes-dashboard
Observation: Make a note of port which starts with 3 (Example: 80:3xxxx/TCP). Capture the port 3xxxx and use it in application URL below. 

# kubernetes-dashboard URL
https://<worker-node-public-ip>:<Node-Port>
```


### Verify Rollout History of a Deployment
- **Observation:** We have the rollout history, so we can switch back to older revisions using 
revision history available to us.  

```
# Check the Rollout History of a Deployment
kubectl rollout history deployment/<Deployment-Name>
kubectl rollout history deployment/my-first-deployment  
```

### Access the Application using Public IP
- We should see `Application Version:V2` whenever we access the application in browser
```
# Get NodePort
kubectl get svc
Observation: Make a note of port which starts with 3 (Example: 80:3xxxx/TCP). Capture the port 3xxxx and use it in application URL below. 

# Get Public IP of Worker Nodes
kubectl get nodes -o wide
Observation: Make a note of "EXTERNAL-IP" if your Kubernetes cluster is setup on AWS EKS.

# Application URL
http://<worker-node-public-ip>:<Node-Port>
```


## Step-02: Update the Application from V3 to V4 using "Edit Deployment" Option
### Edit Deployment
```
# Edit Deployment
kubectl edit deployment/<Deployment-Name> --record=true
kubectl edit deployment/my-first-deployment --record=true
```

```yml
# Change From 2.0.0
    spec:
      containers:
      - image: mylandmarktech/hello:2

# Change To 3.0.0
    spec:
      containers:
      - image: mylandmarktech/hello:3
```

### Verify Rollout Status
- **Observation:** Rollout happens in a rolling update model, so no downtime.
```
# Verify Rollout Status 
kubectl rollout status deployment/my-first-deployment
```
### Verify Replicasets
- **Observation:**  We should see 3 ReplicaSets now, as we have updated our application to 3rd version 3.0.0
```
# Verify ReplicaSet and Pods
kubectl get rs
kubectl get po
```
### Verify Rollout History
```
# Check the Rollout History of a Deployment
kubectl rollout history deployment/<Deployment-Name>
kubectl rollout history deployment/my-first-deployment   
```

### Access the Application using Public IP
- We should see `Application Version:V3` whenever we access the application in browser
```
# Get NodePort
kubectl get svc
Observation: Make a note of port which starts with 3 (Example: 80:3xxxx/TCP). Capture the port 3xxxx and use it in application URL below. 

# Get Public IP of Worker Nodes
kubectl get nodes -o wide
Observation: Make a note of "EXTERNAL-IP" if your Kubernetes cluster is setup on AWS EKS.

# Application URL
http://<worker-node-public-ip>:<Node-Port>
```
