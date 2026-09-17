apiVersion: v1
kind: Secret
metadata:
  name: {{SERVICEACCOUNT_NAME}}-token
  namespace: {{NAMESPACE}}
  annotations:
    kubernetes.io/service-account.name: {{SERVICEACCOUNT_NAME}}
type: kubernetes.io/service-account-token
