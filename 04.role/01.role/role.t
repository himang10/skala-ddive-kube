apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: {{SERVICEACCOUNT_NAME}}-role
  namespace: {{NAMESPACE}}
rules:
- apiGroups: [""]
  resources:
  - pods
  - configmaps
  - services
  verbs:
  - get
  - list
  - watch
  - create
  - update
  - patch
  - delete
- apiGroups:
  - apps
  resources:
  - deployments
  verbs:
  - get
  - list
  - watch
  - create
  - update
  - patch
  - delete
