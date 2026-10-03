apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{USER_NAME}}-{{SERVICE_NAME}}
  namespace: {{NAMESPACE}}
spec:
  replicas: 1
  selector:
    matchLabels:
      app: {{USER_NAME}}-{{SERVICE_NAME}}
  template:
    metadata:
      annotations:
        prometheus.io/scrape: 'true'
        prometheus.io/port: '8080'
        prometheus.io/path: '/prometheus'
        update: {{HASHCODE}}
      labels:
        app: {{USER_NAME}}-{{SERVICE_NAME}}
    spec:
      containers:
        - name: {{IMAGE_NAME}}
          image: {{DOCKER_REGISTRY}}/{{PROJECT_NAME}}/{{USER_NAME}}-{{IMAGE_NAME}}:1.0
          imagePullPolicy: Always
          resources:
            requests:
              cpu: "100m"
              memory: "128Mi"
            limits:
              cpu: "200m"
              memory: "256Mi"
          env:
            - name: USER_NAME
              value: {{USER_NAME}}

