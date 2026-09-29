#!/bin/bash

# ==========================================
# Kubernetes API Server 직접 호출 (Pod 삭제)
# ==========================================
#
CONFIG="${HOME}/.kube/config"

# 현재 Context
CONTEXT=$(yq -r '.["current-context"]' "$CONFIG")

# 현재 Context의 Namespace, Cluster, User
NAMESPACE=${CLASS_NAME}
CLUSTER=$(yq -r ".contexts[] | select(.name == \"$CONTEXT\") | .context.cluster" "$CONFIG")
USER=$(yq -r ".contexts[] | select(.name == \"$CONTEXT\") | .context.user" "$CONFIG")

# Cluster의 API Server URL
URL=$(yq -r ".clusters[] | select(.name == \"$CLUSTER\") | .cluster.server" "$CONFIG")

# User의 Token
TOKEN=$(yq -r ".users[] | select(.name == \"$USER\") | .user.token" "$CONFIG")

# 삭제할 Pod 이름
POD_NAME="${STUDENT_NUM}-webserver"

# 환경 변수
API_PATH="/api/v1/namespaces/${NAMESPACE}/pods/${POD_NAME}"

# 실제 요청 URL
REQUEST="${URL}${API_PATH}"
echo "REQUEST = $REQUEST"

# 요청 내용 출력
echo "=========================================="
echo "REQUEST"
echo "=========================================="
echo "DELETE ${REQUEST}"
echo
echo "Authorization: Bearer ${TOKEN}"
echo "=========================================="

# Kubernetes API Server 호출
# -k : 인증서 검증 생략 (실습용)
# -X DELETE : Pod 삭제 요청
# -H : Bearer Token 인증
# -o : 기존 result.json이 있어도 덮어씀
curl -k \
  -X DELETE \
  -H "Authorization: Bearer ${TOKEN}" \
  "${REQUEST}" \
  -o result.json

echo
echo "Response saved to result.json"
