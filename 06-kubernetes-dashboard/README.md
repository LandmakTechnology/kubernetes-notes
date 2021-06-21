
# Landmark Technologies == Kubernetes Dasboard (UI)
# Managing Kubernetes resources from the UI
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
kubectl edit svc kubernetes-dashboard -n kubernetes-dashboard
```
### Get token to access Dasboard 
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


