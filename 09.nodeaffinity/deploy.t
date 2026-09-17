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
      affinity:
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
            - matchExpressions:
              - key: {{NODE_LABEL_KEY}}
                operator: In
                values:
                - "{{NODE_LABEL_VALUE}}"
      containers:
      - name: {{IMAGE_NAME}}
        image: {{DOCKER_REGISTRY}}/{{USER_NAME}}-{{IMAGE_NAME}}:{{VERSION}}
        imagePullPolicy: Always
        env:
        - name: USER_NAME
          value: {{USER_NAME}}
