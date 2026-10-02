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
      labels:
        app: {{USER_NAME}}-volume-test
    spec:
      affinity:
        podAntiAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
          - labelSelector:
              matchLabels:
                app: {{USER_NAME}}-volume-test
            topologyKey: kubernetes.io/hostname
      terminationGracePeriodSeconds: 0
      containers:
      - name: test
        image: busybox
        imagePullPolicy: IfNotPresent
        command: ["/bin/sh", "-c"]
        args:
          - echo "Hello from busybox" > /data/hello.txt && sleep infinity
        volumeMounts:
        - name: ebs-volume
          mountPath: /data
      volumes:
      - name: ebs-volume
        persistentVolumeClaim:
          claimName: {{USER_NAME}}-ebs-pvc