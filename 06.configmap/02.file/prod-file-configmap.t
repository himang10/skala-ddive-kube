apiVersion: v1
kind: ConfigMap
metadata:
  name: {{USER_NAME}}-prod-file-config
data:
  config.json: |
    {
      "database.url": "jdbc:mysql://localhost:3306/production-db",
      "database.user": "productor",
      "database.password": "productor"
    }


