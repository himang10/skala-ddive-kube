#!/bin/bash
set -e

NAMESPACE=${CLASS_NAME}
SERVICEACCOUNT_NAME=${CLASS_NAME}-${STUDENT_NUM}-sa
SECRET_NAME=${SERVICEACCOUNT_NAME}-token

OUTPUT_FILE="${CLASS_NAME}.${NAMESPACE}.kubeconfig"

TOKEN=$(kubectl get secret "$SECRET_NAME" -n "$NAMESPACE" -o jsonpath='{.data.token}' | base64 -d)
CA=$(kubectl get secret "$SECRET_NAME" -n "$NAMESPACE" -o jsonpath='{.data.ca\.crt}')
SERVER=$(kubectl config view --minify -o jsonpath='{.clusters[0].cluster.server}')
CLUSTER=$(kubectl config view --minify -o jsonpath='{.clusters[0].name}')

if [ -z "$TOKEN" ] || [ -z "$CA" ]; then
  echo "토큰 또는 CA 인증서를 가져오지 못했습니다. Secret(${SECRET_NAME})이 ${NAMESPACE} 네임스페이스에 정상 생성되었는지 확인하세요." >&2
  exit 1
fi

# $HOME/.kube/config를 건드리지 않고 별도 kubeconfig 파일로 생성
cat <<EOF > "$OUTPUT_FILE"
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
    user: ${SERVICEACCOUNT_NAME}
  name: ${SERVICEACCOUNT_NAME}-context
current-context: ${SERVICEACCOUNT_NAME}-context
users:
- name: ${SERVICEACCOUNT_NAME}
  user:
    token: ${TOKEN}
EOF

echo "생성 완료: ${OUTPUT_FILE}"
echo "사용법: kubectl --kubeconfig=${OUTPUT_FILE} get pods"
