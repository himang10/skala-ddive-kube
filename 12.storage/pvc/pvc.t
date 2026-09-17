apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: efs-{{USER_NAME}}-{{SERVICE_NAME}}
  namespace: {{NAMESPACE}}
spec:
  storageClassName: ""
  accessModes:
    - ReadWriteMany
  volumeMode: Filesystem
  resources:
    requests:
      storage: 100Mi
  volumeName: efs-{{USER_NAME}}-{{SERVICE_NAME}}

