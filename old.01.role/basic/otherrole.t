apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: skala-pod-reader-role
  namespace: {{NAMESPACE}}
rules:
- apiGroups:
  - ""
  resources:
  - pods
  verbs:
  - get
  - list
