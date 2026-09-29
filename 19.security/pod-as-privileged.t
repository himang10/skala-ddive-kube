apiVersion: v1
kind: Pod
metadata:
  name: {{USER_NAME}}-security-context
  namespace: {{NAMESPACE}}
spec:
  hostNetwork: true
  terminationGracePeriodSeconds: 0
  containers:
    - name: main
      image: alpine
      command:
        - /bin/sh
        - -c
        - |
          apk add iptables
          exec tail -f /dev/null
      securityContext:
        privileged: true
