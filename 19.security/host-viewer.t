apiVersion: v1
kind: Pod
metadata:
  name: {{USER_NAME}}-security-context
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
          exec tail -f /dev/null
      volumeMounts:
        - name: host-root
          mountPath: /host
          readOnly: true
  volumes:
    - name: host-root
      hostPath:
        path: /
        type: Directory
