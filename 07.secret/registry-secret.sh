#!/bin/bash

kubectl create secret docker-registry skala-registry-secret \
  --docker-server=${DOCKER_REGISTRY} \
  --docker-username=${DOCKER_REGISTRY_USER} \
  --docker-password=${DOCKER_REGISTRY_PASSWORD} \
  --namespace=${CLASS_NAME}

