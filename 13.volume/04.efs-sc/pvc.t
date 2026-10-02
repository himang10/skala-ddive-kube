apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: {{USER_NAME}}-efs-pvc
  namespace: {{NAMESPACE}}
spec:
  accessModes:
    - ReadWriteMany
  volumeMode: Filesystem
  resources:
    requests:
      storage: 100Mi
  storageClassName: efs-sc-shared

