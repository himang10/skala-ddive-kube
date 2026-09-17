#!/bin/bash

# kubectl get nodes -o json | jq '.items[].spec.taints'
kubectl get nodes -o custom-columns=NAME:.metadata.name,TAINTS:.spec.taints