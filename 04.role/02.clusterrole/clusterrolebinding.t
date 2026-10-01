apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: {{SERVICEACCOUNT_NAME}}-clusterrole-binding
subjects:
- kind: ServiceAccount
  name: {{SERVICEACCOUNT_NAME}}
  namespace: {{NAMESPACE}}
roleRef:
  kind: ClusterRole
  name: cluster-admin
  apiGroup: rbac.authorization.k8s.io
