!#/bin/bash
mkdir $HOME/certs
cd certs/
openssl genrsa -out dashboard.key 2048
openssl req -sha256 -new -key dashboard.key -out dashboard.csr
openssl x509 -req -sha256 -days 365 -in dashboard.csr -signkey dashboard.key -out dashboard.crt
kubectl create ns kubernetes-dashboard
kubectl -n kubernetes-dashboard create secret generic kubernetes-dashboard-certs --from-file=$HOME/certs
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-beta7/aio/deploy/recommended.yaml