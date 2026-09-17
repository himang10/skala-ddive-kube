apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: {{USER_NAME}}-node-logger
  namespace: {{NAMESPACE}}
  labels:
    app: {{USER_NAME}}-node-logger
spec:
  selector:
    matchLabels:
      app: {{USER_NAME}}-node-logger
  template:
    metadata:
      labels:
        app: {{USER_NAME}}-node-logger
    spec:
      containers:
      - name: node-logger
        image: busybox
        command:
          - sh
          - -c
          - |
            while true; do
              echo "[$(date +%Y-%m-%d_%H:%M:%S)] Running on node: $NODE_NAME"
              sleep 10
            done
        env:
        - name: NODE_NAME                  # 파드가 실행 중인 노드 이름
          valueFrom:
            fieldRef:
              fieldPath: spec.nodeName
        resources:
          requests:
            cpu: "50m"
            memory: "32Mi"
          limits:
            cpu: "100m"
            memory: "64Mi"
