apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{USER_NAME}}-curl
  namespace: {{NAMESPACE}}
  labels:
    app: {{USER_NAME}}-curl
spec:
  replicas: 1
  selector:
    matchLabels:
      app: {{USER_NAME}}-curl
  template:
    metadata:
      labels:
        app: {{USER_NAME}}-curl
    spec:
      #serviceAccountName: skala-admin-sa
      terminationGracePeriodSeconds: 0
      containers:
      - name: curl
        image: curlimages/curl:latest
        securityContext:
          runAsUser: 0
        command: ["sh", "-c"]
        args: ["apk add --no-cache jq && exec sleep infinity"]