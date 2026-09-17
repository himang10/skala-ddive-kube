apiVersion: v1
kind: Pod
metadata:
  name: {{USER_NAME}}-pod-as-privileged
  namespace: {{NAMESPACE}}
spec:
  hostNetwork: true
  containers:
    - name: main
      image: alpine
      command:
        - /bin/sh
        - -c
        - |
          apk add iptables
          sleep infinity
      securityContext:
        privileged: true
