apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{USER_NAME}}-{{SERVICE_NAME}}
  namespace: {{NAMESPACE}}
  labels:
    app: {{USER_NAME}}-{{SERVICE_NAME}}
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
        prometheus.io/path: '/actuator/prometheus'
        update: {{HASHCODE}}
      labels:
        app: {{USER_NAME}}-{{SERVICE_NAME}}
    spec:
      containers:
      # -----------------------------------
      # Main Container
      # -----------------------------------
      - name: {{SERVICE_NAME}}
        image: {{DOCKER_REGISTRY}}/{{PROJECT_NAME}}/{{USER_NAME}}-webserver:1.0
        imagePullPolicy: Always
        env:
        - name: USER_NAME
          value: {{USER_NAME}}
        - name: NAMESPACE
          value: {{NAMESPACE}}
        - name: SPRING_PROFILES_ACTIVE  
          value: "local"  

      # -----------------------------------
      # Sidecar Container
      # -----------------------------------
      - name: nginx-sidecar
        image: nginx:1.27-alpine
        command: ["/bin/sh", "-c"]
        args:
          - apk add --no-cache jq && exec nginx -g 'daemon off;'
        ports:
        - containerPort: 80
        volumeMounts:
        - name: nginx-config
          mountPath: /etc/nginx/conf.d/default.conf
          subPath: default.conf

      volumes:
      - name: nginx-config
        configMap:
          name: {{USER_NAME}}-nginx-sidecar-config