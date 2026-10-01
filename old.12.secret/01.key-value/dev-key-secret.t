apiVersion: v1
kind: Secret
metadata:
  name: {{USER_NAME}}-dev-db-secret
stringData:
  database.url: jdbc:mysql://localhost:3306/develop-db
  database.user: developer
  database.password: developer

