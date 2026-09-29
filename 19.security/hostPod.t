apiVersion: v1
kind: Pod
metadata:
  name: {{USER_NAME}}-host-pod
  namespace: {{NAMESPACE}}
spec:
  hostNetwork: true
  hostPID: true
  hostIPC: true
  containers:
  - name: main
    image: alpine
    command: ["/bin/sh", "-c", "exec tail -f /dev/null"]
