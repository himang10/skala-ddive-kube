apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: {{USER_NAME}}-ebs-pvc
  namespace: {{NAMESPACE}}
spec:
  accessModes:
    - ReadWriteOnce
  volumeMode: Filesystem
  resources:
    requests:
      storage: 100Mi
  storageClassName: gp3

