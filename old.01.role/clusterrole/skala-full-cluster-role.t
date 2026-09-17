---
# ClusterRole: skala-full-cluster-role
# ServiceAccount, ClusterRole, ClusterRoleBinding 등 RBAC 리소스의
# 생성(create), 조회(get/list/watch), 수정(update/patch), 삭제(delete) 권한 부여
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: skala-full-cluster-role
rules:

# RBAC 리소스 전체 관리
- apiGroups:
  - rbac.authorization.k8s.io
  resources:
  - clusterroles
  - clusterrolebindings
  - roles
  - rolebindings
  verbs:
  - get
  - list
  - watch
  - create
  # - update
  # - patch
  # - delete

# ServiceAccount 전체 관리
- apiGroups: [""]
  resources:
  - serviceaccounts
  - serviceaccounts/token
  verbs:
  - get
  - list
  - watch
  - create
  # - update
  # - patch
  # - delete

# Namespace 전체 관리
- apiGroups: [""]
  resources:
  - namespaces
  verbs:
  - get
  - list
  - watch
  - create
  # - update
  # - patch
  # - delete

# 핵심 워크로드 리소스 전체 관리
- apiGroups: [""]
  resources:
  - pods
  - pods/log
  - pods/exec
  - pods/portforward
  - nodes
  - configmaps
  - secrets
  - services
  - endpoints
  - persistentvolumes
  - persistentvolumeclaims
  - events
  verbs:
  - get
  - list
  - watch
  - create
  - update
  - patch
  - delete

# apps 그룹 리소스 전체 관리
- apiGroups: ["apps"]
  resources:
  - deployments
  - statefulsets
  - replicasets
  - daemonsets
  verbs:
  - get
  - list
  - watch
  - create
  - update
  - patch
  - delete

# storage 리소스 전체 관리
- apiGroups: ["storage.k8s.io"]
  resources:
  - storageclasses
  - volumeattachments
  verbs:
  - get
  - list
  - watch
  - create
  # - update
  # - patch
  # - delete
