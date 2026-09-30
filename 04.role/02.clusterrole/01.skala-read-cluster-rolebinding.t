apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: skala-cluster-read-rolebinding
subjects:
- kind: ServiceAccount
  name: {{SERVICEACCOUNT_NAME}}
  namespace: {{NAMESPACE}}
roleRef:
  kind: ClusterRole
  name: skala-cluster-read-role
  apiGroup: rbac.authorization.k8s.io
