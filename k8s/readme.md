# IMP Commands

### To use blue green deployment, we should have two deployments and we can change the deployments as required in the services

```
---
apiVersion: v1
kind: Service
metadata:
    name: myapp
spec:
    selector:
        app: myapp
        replicas: blue ###or green
```

### we use -l to filter anything based on labels

Example

`kubectl get services -l app=myapp`

this will print the services having labels as app=myapp

### to install ingress

```
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm install my-nginx-ingress ingress-nginx/ingress-nginx
```
### to check metrics of a pod or node

```
kubectl top pod <pod_name>
kubectl top node <node_name>
kubectl top pod
kubectl top node
kubectl top pod -n <namespace>
kubectl top pod | grep -v NAME | sort -rnk 2 #sort numerically based on 2nd row
```
### Pod CPU Usage: Displays the CPU usage of each pod in the cluster.
Query: `sum(rate(container_cpu_usage_seconds_total{container!=""}[5m])) by (pod, namespace)`

### Pod Memory Usage: Displays the memory usage of each pod in the cluster.
Query: `container_memory_working_set_bytes{container!=""}`

### to apply load on the server use
`hey -n <number of requests> -c <concurrency> <url>`

## Taints and Tolerations

Both are use to provide restriction on whether a pod can be scheduled on a node or not based on certain conditions.
Taints are applied on nodes and tolerations are applied on pods.

`kubectl taint nodes node-name key=value:taint-effect`
to allow pod to be scheduled in the node, we need to provive toleration in the defination of pod
```
spec:
    tolerations:
    - key: "key"
      operator: "Equal" ## or "Exists" or "NotEqual" or based on the operator that we have used between key and value while defining taint
      value: "value"
      effect: "NoSchedule" ## or "PreferNoSchedule" or "NoExecute" based on the taint effect
```

`kubectl taint nodes node-name app=blue:NoSchedule`
```
spec:
    tolerations:
    - key: "app"
      operator: "Equal" 
      value: "blue"
      effect: "NoSchedule" 
```


`kubectl taint nodes node-name key=value:NoExecute`
`kubectl taint nodes node-name key=value:PreferNoSchedule`

for prometheus helm
`https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack`

sudo usermod -aG docker $USER && newgrp docker
