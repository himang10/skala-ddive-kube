apiVersion: v1
kind: Pod
metadata:
  name: {{USER_NAME}}-security-context
  namespace: {{NAMESPACE}}
spec:
  containers:
    - name: main
      image: alpine
      command: ["/bin/sh", "-c", "exec tail -f /dev/null"]
      securityContext:
        runAsNonRoot: true
        runAsUser: 1000
        runAsGroup: 1000
