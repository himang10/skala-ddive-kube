apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: skala-cluster-read-role
rules:
# nonResourceURLs 접근 허용
- nonResourceURLs:
  - "/version"
  - "/metrics"
  - "/healthz"
  - "/api"
  - "/api/*"
  - "/apis"
  - "/apis/*"
  verbs: ["get"]

# ClusterRole 리소스 중 이름이 admin, view인 것만 get 허용
- apiGroups: 
  - rbac.authorization.k8s.io
  resources: 
  - clusterroles
  resourceNames: 
  - admin
  - view
  verbs: 
  - get

- apiGroups: [""]
  resources: 
  - namespaces
  - pods
  - pods/log
  - nodes
  - configmaps
  - services
  - endpoints
  - persistentvolumes
  - persistentvolumeclaims
  - secrets
  verbs:
  - get
  - list

- apiGroups: ["apps"]
  resources: 
  - deployments
  - statefulsets
  - replicaSets
  - daemonSets
  verbs:
  - get
  - list

- apiGroups: ["storage.k8s.io"]
  resources: ["storageclasses"]
  verbs: ["get", "list"]

# metrics.k8s.io (resource metrics)
- apiGroups: ["metrics.k8s.io"]
  resources: ["pods", "nodes"]
  verbs: ["get", "list"]

# custom.metrics.k8s.io (custom metrics)
- apiGroups: ["custom.metrics.k8s.io"]
  resources: ["*"]
  verbs: ["get", "list"]

# external.metrics.k8s.io (external metrics, e.g., KEDA)
- apiGroups: ["external.metrics.k8s.io"]
  resources: ["*"]
  verbs: ["get", "list"]

- apiGroups: ["discovery.k8s.io"]
  resources: ["endpointslices"]
  verbs: ["get", "list"]
