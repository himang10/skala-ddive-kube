apiVersion: v1
kind: Secret
metadata:
  name: {{USER_NAME}}-file-secret
type: Opaque
stringData:
  config.json: |
    {
      "database.url": "jdbc:mysql://localhost:3306/develop-db",
      "database.user": "developer",
      "database.password": "developer"
    }

