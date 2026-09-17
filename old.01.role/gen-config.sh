#!/bin/bash

NAMESPACE=class-cloud
SERVICEACCOUNT=class-cloud-sa

SECRET=${SERVICEACCOUNT}-token
TOKEN=$(kubectl get secret $SECRET -n $NAMESPACE -o jsonpath='{.data.token}' | base64 -d)
CA=$(kubectl get secret $SECRET -n $NAMESPACE -o jsonpath='{.data.ca\.crt}')
SERVER=$(kubectl config view --minify -o jsonpath='{.clusters[0].cluster.server}')
CLUSTER=$(kubectl config view --minify -o jsonpath='{.clusters[0].name}')

cat <<EOF > "${SERVICEACCOUNT}-kubeconfig-${NAMESPACE}"
apiVersion: v1
kind: Config
clusters:
- cluster:
    certificate-authority-data: ${CA}
    server: ${SERVER}
  name: ${CLUSTER}
contexts:
- context:
    cluster: ${CLUSTER}
    namespace: ${NAMESPACE}
    user: ${SERVICEACCOUNT}
  name: skala-edu-cluster
current-context: skala-edu-cluster
users:
- name: ${SERVICEACCOUNT}
  user:
    token: ${TOKEN}
EOF

echo "Generated: ${SERVICEACCOUNT}-kubeconfig-${NAMESPACE}"
