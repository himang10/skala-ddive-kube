apiVersion: keda.sh/v1alpha1
kind: ScaledObject
metadata:
  name: {{USER_NAME}}-scaledobject
  namespace: {{NAMESPACE}}
spec:
  scaleTargetRef:
    kind: Deployment
    name: {{USER_NAME}}-{{SERVICE_NAME}}
  pollingInterval: 5              
  cooldownPeriod: 10              
  minReplicaCount: 1
  maxReplicaCount: 10
  advanced:
    horizontalPodAutoscalerConfig:
      behavior:
        scaleUp:
          stabilizationWindowSeconds: 0
          policies:
          - type: Percent
            value: 100
            periodSeconds: 5
        scaleDown:
          stabilizationWindowSeconds: 0
          policies:
          - type: Percent
            value: 100
            periodSeconds: 5
  triggers:
  - type: kubernetes-workload
    metadata:
      workloadType: Deployment
      namespace: {{NAMESPACE}}
      podSelector: "app={{USER_NAME}}-collabo-shared"
      value: "1.0"
      metricType: Value
      podConditionType: Ready     

