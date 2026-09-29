#!/bin/bash

# ==========================================
# Kubernetes API Server 직접 호출 (Pod 생성)
# webserver-pod.yaml 내용을 JSON으로 변환하여 API로 생성
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

# Pod 정보
POD_NAME="${STUDENT_NUM}-webserver"
IMAGE="skala-registry.skala-${LOCATION}.com/${CLASS_NAME}/${STUDENT_NUM}-webserver:1.0"

# webserver-pod.yaml을 JSON으로 변환한 요청 본문
JSON_BODY=$(cat <<EOF
{
  "apiVersion": "v1",
  "kind": "Pod",
  "metadata": {
    "name": "${POD_NAME}",
    "namespace": "${NAMESPACE}",
    "labels": {
      "app": "${POD_NAME}"
    }
  },
  "spec": {
    "containers": [
      {
        "name": "webserver",
        "image": "${IMAGE}",
        "imagePullPolicy": "Always",
        "env": [
          { "name": "USER_NAME", "value": "skala" },
          { "name": "CLASS_NAME", "value": "${NAMESPACE}" }
        ]
      }
    ]
  }
}
EOF
)

# 환경 변수
API_PATH="/api/v1/namespaces/${NAMESPACE}/pods"

# 실제 요청 URL
REQUEST="${URL}${API_PATH}"
echo "REQUEST = $REQUEST"

# 요청 내용 출력
echo "=========================================="
echo "REQUEST"
echo "=========================================="
echo "POST ${REQUEST}"
echo
echo "Authorization: Bearer ${TOKEN}"
echo
echo "Body:"
echo "${JSON_BODY}"
echo "=========================================="

# Kubernetes API Server 호출
# -k : 인증서 검증 생략 (실습용)
# -H : Bearer Token 인증 및 Content-Type
# -d : 요청 본문(JSON)
# -o : 기존 result.json이 있어도 덮어씀
curl -k \
  -X POST \
  -H "Authorization: Bearer ${TOKEN}" \
  -H "Content-Type: application/json" \
  -d "${JSON_BODY}" \
  "${REQUEST}" \
  -o result.json

echo
echo "Response saved to result.json"
