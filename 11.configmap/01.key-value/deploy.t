apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{USER_NAME}}-{{SERVICE_NAME}}
  namespace: {{NAMESPACE}}
  annotations:
    prometheus.io/scrape: 'true'
    prometheus.io/port: '8080'
    prometheus.io/path: '/actuator/prometheus'
    update: 7a4d145eaf266c9c6f556cce11c1c6f0
  labels:
    app: {{USER_NAME}}-{{SERVICE_NAME}}
spec:
  replicas: {{REPLICAS}}
  selector:
    matchLabels:
      app: {{USER_NAME}}-{{SERVICE_NAME}}
  template:
    metadata:
      labels:
        app: {{USER_NAME}}-{{SERVICE_NAME}}
    spec:
      containers:
      - name: webserver
        image: {{DOCKER_REGISTRY}}/{{PROJECT_NAME}}/{{USER_NAME}}-{{IMAGE_NAME}}:1.0
        imagePullPolicy: Always
        env:
        - name: USER_NAME
          value: {{USER_NAME}}

        - name: DATABASE_URL
          valueFrom:
            configMapKeyRef:
              name: {{USER_NAME}}-db-config
              key: database.url
        - name: DATABASE_USER
          valueFrom:
            configMapKeyRef:
              name: {{USER_NAME}}-db-config
              key: database.user
        - name: DATABASE_PASSWORD
          valueFrom:
            configMapKeyRef:
              name: {{USER_NAME}}-db-config
              key: database.password

