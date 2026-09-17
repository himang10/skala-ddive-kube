apiVersion: v1
kind: Pod
metadata:
  name: {{USER_NAME}}-pod-as-nonroot
  namespace: {{NAMESPACE}}
spec:
  containers:
    - name: main
      image: alpine
      command: ["/bin/sleep", "infinity"]
      securityContext:
        runAsNonRoot: true
        runAsUser: 1000
        runAsGroup: 1000
