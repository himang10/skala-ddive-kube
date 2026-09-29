#!/bin/bash

CONFIG="${HOME}/.kube/config"

# 현재 Context
CONTEXT=$(yq -r '.["current-context"]' "$CONFIG")

# 현재 Context의 Namespace, Cluster, User
NAMESPACE=$(yq -r ".contexts[] | select(.name == \"$CONTEXT\") | .context.namespace // \"default\"" "$CONFIG")
CLUSTER=$(yq -r ".contexts[] | select(.name == \"$CONTEXT\") | .context.cluster" "$CONFIG")
USER=$(yq -r ".contexts[] | select(.name == \"$CONTEXT\") | .context.user" "$CONFIG")

# Cluster의 API Server URL
URL=$(yq -r ".clusters[] | select(.name == \"$CLUSTER\") | .cluster.server" "$CONFIG")

# User의 Token
TOKEN=$(yq -r ".users[] | select(.name == \"$USER\") | .user.token" "$CONFIG")

echo "=========================================="
echo " Kubernetes API Information"
echo "=========================================="
echo "NAMESPACE : ${NAMESPACE}"
echo "URL       : ${URL}"
echo "TOKEN     : ${TOKEN}"
echo "=========================================="
