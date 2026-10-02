apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{USER_NAME}}-volume-test
  namespace: {{NAMESPACE}}
spec:
  replicas: 2
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
      - name: storage-test
        image: busybox
        imagePullPolicy: IfNotPresent
        command: ["/bin/sh", "-c"]
        args:
          - echo "Hello from busybox" > /data/{{USER_NAME}}-hello.txt && sleep infinity
        volumeMounts:
        - name: pvc-volume
          mountPath: /data
      volumes:
      - name: pvc-volume
        persistentVolumeClaim:
          claimName: {{USER_NAME}}-efs-pvc

