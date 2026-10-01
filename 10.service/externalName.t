apiVersion: v1
kind: Service
metadata:
  name: {{USER_NAME}}-{{SERVICE_NAME}}-externalName
  namespace: {{NAMESPACE}}
spec:
  type: ExternalName
  externalName: skala-fileserver.skala-ai.com
  ports:
    - port: 443

