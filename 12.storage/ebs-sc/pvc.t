apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: {{USER_NAME}}-ebs-sc-{{SERVICE_NAME}}
  namespace: {{NAMESPACE}}
spec:
  accessModes:
    - ReadWriteOnce
  volumeMode: Filesystem
  resources:
    requests:
      storage: 10Mi
  storageClassName: gp3

