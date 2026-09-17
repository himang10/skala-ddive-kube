apiVersion: v1
kind: Pod
metadata:
  name: {{USER_NAME}}-pod-as-pid
  namespace: {{NAMESPACE}}
spec:
  hostPID: true
  hostNetwork: true
  containers:
    - name: main
      image: alpine
      command:
        - /bin/sh
        - -c
        - |
          apk add procps
          sleep infinity
