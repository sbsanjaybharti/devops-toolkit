# Kubectl Quick Reference

Essential kubectl commands for daily Kubernetes operations.

## Cluster & Nodes

```
kubectl cluster-info
kubectl get nodes
kubectl top nodes
kubectl describe node <node-name>
```
## Pods

```
kubectl get pods -A
kubectl describe pod <pod-name>
kubectl exec -it <pod-name> -- /bin/bash
kubectl exec <pod-name> -- printenv
kubectl delete pod <pod-name>
```
## Deployments

```
kubectl get deployments
kubectl apply -f <file.yaml>
kubectl scale deployment <deployment-name> --replicas=3
kubectl rollout status deployment <deployment-name>
kubectl rollout restart deployment <deployment-name>
kubectl rollout undo deployment <deployment-name>
```
## Services, PV & PVC

```
kubectl get svc
kubectl get pv
kubectl get pvc
kubectl describe pvc <pvc-name>
kubectl patch pv <pv-name> -p '{"metadata":{"finalizers":null}}'
kubectl delete pv pvc <pvc-name>
```
## Debugging & Events

```
kubectl get events
kubectl get events --sort-by=".metadata.managedFields[0].time"
kubectl top pods
kubectl top nodes
kubectl logs <pod-name>
kubectl explain <resource>
```
## Context

```
kubectl config get-contexts
kubectl config use-context <context-name>
```