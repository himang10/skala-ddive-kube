#!/bin/bash
# =============================================================================
# taint.sh
# 노드에 taint를 설정/해제하는 스크립트
# taint key: skala.io/taint, effect: NoExecute
# =============================================================================

# 대상 노드 이름 (kubectl get nodes 로 확인 후 변경)
NODE_NAME=${1:-""}

if [ -z "$NODE_NAME" ]; then
  echo "Usage:"
  echo "  taint 설정:  $0 <node-name> [set]"
  echo "  taint 해제:  $0 <node-name> remove"
  echo ""
  echo "Available nodes:"
  kubectl get nodes -o wide
  exit 1
fi

ACTION=${2:-"set"}

case $ACTION in
  set)
    echo "[INFO] 노드 '$NODE_NAME' 에 taint 설정: skala.io/taint=NoExecute"
    kubectl taint node "$NODE_NAME" skala.io/taint=true:NoExecute
    echo ""
    echo "[INFO] 현재 노드 taint 상태:"
    kubectl describe node "$NODE_NAME" | grep -A 5 "Taints:"
    ;;
  remove)
    echo "[INFO] 노드 '$NODE_NAME' 에서 taint 해제: skala.io/taint=NoExecute"
    kubectl taint node "$NODE_NAME" skala.io/taint=true:NoExecute-
    echo ""
    echo "[INFO] 현재 노드 taint 상태:"
    kubectl describe node "$NODE_NAME" | grep -A 5 "Taints:"
    ;;
  *)
    echo "[ERROR] 알 수 없는 action: $ACTION (set | remove 중 선택)"
    exit 1
    ;;
esac
