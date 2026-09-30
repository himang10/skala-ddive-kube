apiVersion: v1
kind: ServiceAccount
metadata:
  name: {{SERVICEACCOUNT_NAME}}
  namespace: {{NAMESPACE}}
---
apiVersion: v1
kind: Secret
metadata:
  name: {{SERVICEACCOUNT_NAME}}-token
  namespace: {{NAMESPACE}}
  annotations:
    kubernetes.io/service-account.name: {{SERVICEACCOUNT_NAME}}
type: kubernetes.io/service-account-token
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: admin-role-binding
  namespace: {{NAMESPACE}}
subjects:
- kind: ServiceAccount
  name: {{SERVICEACCOUNT_NAME}}
  namespace: {{NAMESPACE}}
roleRef:
  kind: ClusterRole
  name: cluster-admin
  apiGroup: rbac.authorization.k8s.io
