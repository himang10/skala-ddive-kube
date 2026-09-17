apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: skala-read-rolebinding
subjects:
- kind: ServiceAccount
  name: {{SERVICEACCOUNT_NAME}}
  namespace: {{NAMESPACE}}
roleRef:
  kind: ClusterRole
  name: skala-cluster-read-role
  apiGroup: rbac.authorization.k8s.io
