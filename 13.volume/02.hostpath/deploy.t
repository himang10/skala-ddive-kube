apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{USER_NAME}}-volume-test
  namespace: {{NAMESPACE}}
spec:
  replicas: 1
  selector:
    matchLabels:
      app: {{USER_NAME}}-volume-test
  template:
    metadata:
      annotations:
        update: "{{HASHCODE}}"
      labels:
        app: {{USER_NAME}}-volume-test
    spec:
      terminationGracePeriodSeconds: 0
      serviceAccountName: default
      containers:
      - name: test
        image: busybox
        imagePullPolicy: IfNotPresent
        command: ["/bin/sh", "-c"]
        args:
          - echo "Hello from busybox" > /data/hello.txt && sleep infinity
        volumeMounts:
        - name: hostpath-volume
          mountPath: /data
      volumes:
      - name: hostpath-volume
        hostPath:
          path: /tmp/hostpath-{{USER_NAME}}
          type: DirectoryOrCreate
