#!/bin/bash
cd database
sudo kubectl delete -f .
cd ../ingress
sudo kubectl delete -f .
sudo kubectl delete -f secrets.yaml
cd ../user-service
sudo kubectl delete -f .
cd ../product-service
sudo kubectl delete -f .
cd ../nginx
sudo kubectl delete -f .
cd ../frontend  
sudo kubectl delete -f .
cd ../hpa
sudo kubectl delete -f .
helm uninstall prometheus
