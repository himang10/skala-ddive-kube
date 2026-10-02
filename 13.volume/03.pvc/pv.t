apiVersion: v1
kind: PersistentVolume
metadata:
  name: {{USER_NAME}}-efs-pvc
spec:
  capacity:
    storage: 100Mi  # 논리적 크기, 실제 EFS는 무제한
  volumeMode: Filesystem
  accessModes:
    - ReadWriteMany
  persistentVolumeReclaimPolicy: Retain
  csi:
    driver: efs.csi.aws.com
#    volumeHandle: fs-0e24afe9e2bc46ee5::fsap-0618f4fd3c6abd1ee # 판교
#    volumeHandle: fs-0faafdd925470e87d::fsap-0beb6c5f1fc9b01cf # 울산
  claimRef:
    namespace: {{NAMESPACE}}
    name: {{USER_NAME}}-efs-pvc

