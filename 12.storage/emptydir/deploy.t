apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{USER_NAME}}-{{SERVICE_NAME}}
  namespace: {{NAMESPACE}}
spec:
  replicas: 1
  selector:
    matchLabels:
      app: {{USER_NAME}}-{{SERVICE_NAME}}
  template:
    metadata:
      annotations:
        update: {{HASHCODE}}
      labels:
        app: {{USER_NAME}}-{{SERVICE_NAME}}
    spec:
      serviceAccountName: default
      containers:
      - name: volume-test1
        image: busybox
        imagePullPolicy: IfNotPresent
        command: ["/bin/sh", "-c"]
        args:
          - echo "Hello from busybox" > /data1/hello1.txt && sleep infinity
        volumeMounts:
        - name: emptydir-volume
          mountPath: /data1
      - name: volume-test2
        image: busybox
        imagePullPolicy: IfNotPresent
        command: ["/bin/sh", "-c"]
        args:
          - echo "Hello from busybox" > /data2/hello2.txt && sleep infinity
        volumeMounts:
        - name: emptydir-volume
          mountPath: /data2
      volumes:
      - name: emptydir-volume
        emptyDir: {}

