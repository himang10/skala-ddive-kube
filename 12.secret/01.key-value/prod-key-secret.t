# secret.yaml
apiVersion: v1
kind: Secret
metadata:
  name: {{USER_NAME}}-db-secret
type: Opaque
stringData:
  database.url: jdbc:mysql://localhost:3306/production-db
  database.user: productor
  database.password: productor

