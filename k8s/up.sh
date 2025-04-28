#!/bin/bash
cd database
 kubectl apply -f secrets.yaml
 kubectl apply -f .
cd ../user-service
 kubectl apply -f .
cd ../product-service
 kubectl apply -f .
# sleep 60kubect
cd ../nginx
 kubectl apply -f .
cd ../frontend  
 kubectl apply -f .
cd ../ingress
 kubectl apply -f .
cd ../hpa
 kubectl apply -f .
# helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
# helm repo update
#  helm install prometheus prometheus-community/kube-prometheus-stack
# sleep 30
# export POD_NAME=$(kubectl --namespace default get pod -l "app.kubernetes.io/name=grafana,app.kubernetes.io/instance=prometheus" -oname)
# kubectl --namespace default port-forward $POD_NAME 3000
