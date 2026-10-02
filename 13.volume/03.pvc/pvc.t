apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: {{USER_NAME}}-efs-pvc
  namespace: {{NAMESPACE}}
spec:
  storageClassName: ""
  accessModes:
    - ReadWriteMany
  volumeMode: Filesystem
  resources:
    requests:
      storage: 100Mi
  volumeName: {{USER_NAME}}-efs-pvc

