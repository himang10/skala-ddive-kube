apiVersion: v1
kind: Service
metadata:
  name: {{USER_NAME}}-{{SERVICE_NAME}}
  namespace: {{NAMESPACE}}
spec:
  selector:
    app: {{USER_NAME}}-{{SERVICE_NAME}}
    version: 2.0.0-NEW
  ports:
    - name: http
      protocol: TCP
      port: 8080
      targetPort: 8080
    - name: mgmt
      protocol: TCP
      port: 8081
      targetPort: 8081
  type: ClusterIP


