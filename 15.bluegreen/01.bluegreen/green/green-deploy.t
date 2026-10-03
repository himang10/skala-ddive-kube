apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{USER_NAME}}-green
  namespace: {{NAMESPACE}}
spec:
  replicas: 1
  selector:
    matchLabels:
      app: {{USER_NAME}}-{{SERVICE_NAME}}
      version: "2.0"
  template:
    metadata:
      annotations:
        prometheus.io/scrape: 'true'
        prometheus.io/port: '8080'
        prometheus.io/path: '/actuator/prometheus'
        update: {{HASHCODE}}
      labels:
        app: {{USER_NAME}}-{{SERVICE_NAME}}
        version: "2.0"
    spec:
      containers:
      - name: {{IMAGE_NAME}}
        image: {{DOCKER_REGISTRY}}/{{PROJECT_NAME}}/{{USER_NAME}}-{{IMAGE_NAME}}:2.0
        imagePullPolicy: Always
        env:
        - name: USER_NAME
          value: {{USER_NAME}}
        - name: NAMESPACE
          value: {{NAMESPACE}}
