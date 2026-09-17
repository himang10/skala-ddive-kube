apiVersion: v1
kind: Pod
metadata:
  name: {{USER_NAME}}-host-viewer
  namespace: {{NAMESPACE}}
spec:
  hostPID: true
  hostIPC: true
  hostNetwork: true
  restartPolicy: Always
  containers:
    - name: log-viewer
      image: ubuntu:24.04
      securityContext:
        privileged: true
      command:
        - /bin/sh
        - -c
        - |
          apt-get update && \
          apt-get install -y procps && \
          sleep infinity
      volumeMounts:
        - name: host-root
          mountPath: /host
  volumes:
    - name: host-root
      hostPath:
        path: /
        type: Directory
