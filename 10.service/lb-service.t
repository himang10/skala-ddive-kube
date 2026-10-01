apiVersion: v1
kind: Service
metadata:
  name: {{USER_NAME}}-{{SERVICE_NAME}}-lb
  namespace: no-namespace
  annotations:
    # NLB(Network Load Balancer) 타입으로 생성 지시 (AWS Load Balancer Controller 사용)
    service.beta.kubernetes.io/aws-load-balancer-type: nlb
    # target Type: instance | ip
    service.beta.kubernetes.io/aws-load-balancer-nlb-target-type: instance
spec:
  type: LoadBalancer
  selector:
    app: {{USER_NAME}}-{{SERVICE_NAME}}
  ports:
    - name: http
      protocol: TCP
      port: 80
      targetPort: 8080
    - name: mgmt
      protocol: TCP
      port: 8081
      targetPort: 8081
