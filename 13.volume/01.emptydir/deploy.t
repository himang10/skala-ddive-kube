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
      containers:
      - name: test1
        image: busybox
        imagePullPolicy: IfNotPresent
        command: ["/bin/sh", "-c"]
        args:
          - echo "Hello from busybox" > /data1/hello1.txt && sleep infinity
        volumeMounts:
        - name: emptydir-volume
          mountPath: /data1
      - name: test2
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

