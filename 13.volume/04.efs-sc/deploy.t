apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{USER_NAME}}-volume-test
  namespace: {{NAMESPACE}}
spec:
  replicas: {{REPLICAS}}
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
      containers:
      - name: test
        image: busybox
        imagePullPolicy: IfNotPresent
        command: ["/bin/sh", "-c"]
        args:
          - echo "Hello from busybox" > /data/hello.txt && sleep infinity
        volumeMounts:
        - name: efs-volume
          mountPath: /data
      volumes:
      - name: efs-volume
        persistentVolumeClaim:
          claimName: {{USER_NAME}}-efs-pvc

