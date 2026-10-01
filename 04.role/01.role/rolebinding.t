apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: {{SERVICEACCOUNT_NAME}}-rolebinding
  namespace: {{NAMESPACE}}
subjects:
- kind: ServiceAccount
  name: {{SERVICEACCOUNT_NAME}}
  namespace: {{NAMESPACE}}
roleRef:
  kind: Role
  name: {{SERVICEACCOUNT_NAME}}-role
  apiGroup: rbac.authorization.k8s.io
