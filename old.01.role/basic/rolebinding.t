apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: skala-admin-rolebinding
  namespace: {{NAMESPACE}}
subjects:
- kind: ServiceAccount
  name: {{SERVICEACCOUNT_NAME}}
  namespace: {{NAMESPACE}}
roleRef:
  kind: Role
  name: skala-admin-role
  apiGroup: rbac.authorization.k8s.io
