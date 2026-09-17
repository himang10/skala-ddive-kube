apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{USER_NAME}}-collabo-shared
  namespace: {{NAMESPACE}}
spec:
  replicas: 1
  selector:
    matchLabels:
      app: {{USER_NAME}}-collabo-shared
  template:
    metadata:
      labels:
        app: {{USER_NAME}}-collabo-shared
    spec:
      containers:
        - name: busybox
          image: busybox:1.36
          command:
            - /bin/sh
            - -c
            - |
              echo "collabo-shared started";
              while true; do
                echo "$(date) ready";
                sleep infinity;
              done
          resources:
            requests:
              cpu: "10m"
              memory: "16Mi"
            limits:
              cpu: "50m"
              memory: "64Mi"
