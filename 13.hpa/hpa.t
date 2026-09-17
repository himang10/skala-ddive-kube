apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: {{USER_NAME}}-myfirst-api-server-hpa-utilization
  namespace: {{NAMESPACE}}
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: {{USER_NAME}}-myfirst-api-server
  minReplicas: 1
  maxReplicas: 5
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 50
  - type: Resource
    resource:
      name: memory
      target:
        type: AverageValue
        averageValue: 100Mi
  behavior:
    scaleUp:
      stabilizationWindowSeconds: 0
      policies:
        - type: Percent
          value: 100
          periodSeconds: 5
    scaleDown:
      policies:
        - type: Percent
          value: 100
          periodSeconds: 5
      stabilizationWindowSeconds: 0
      selectPolicy: Min

