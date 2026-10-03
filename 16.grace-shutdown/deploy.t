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
        update: {{HASHCODE}}
      labels:
        app: {{USER_NAME}}-{{SERVICE_NAME}}
    spec:
      terminationGracePeriodSeconds: 0  # default 30s
      containers:
      - name: {{IMAGE_NAME}}
        image: {{DOCKER_REGISTRY}}/{{PROJECT_NAME}}/{{USER_NAME}}-{{IMAGE_NAME}}:1.0
        imagePullPolicy: Always
        env:
        - name: USER_NAME
          value: {{USER_NAME}}
        ports:
        - containerPort: 8080
        lifecycle:
          postStart:
            exec:
              command: ["/bin/sh", "-c", "echo '[postStart] container started: {{USER_NAME}}-{{SERVICE_NAME}}' > /proc/1/fd/1"]
          preStop:
            exec:
              command: ["/bin/sh", "-c", "echo '[preStop] container stopping: {{USER_NAME}}-{{SERVICE_NAME}}' > /proc/1/fd/1 && sleep 10"]

