apiVersion: batch/v1
kind: Job
metadata:
  name: {{USER_NAME}}-job
  namespace: {{NAMESPACE}}
  labels:                 
    app: {{USER_NAME}}-job
spec:
  backoffLimit: 3
  completions: 3
  parallelism: 2
  template:
    spec:
      containers:
      - name: print-time
        image: busybox
        command:
          - sh
          - -c
          - 'echo "Current Time: $(date +%Y-%m-%d_%H:%M:%S)"'
      restartPolicy: Never
