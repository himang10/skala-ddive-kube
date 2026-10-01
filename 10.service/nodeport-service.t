apiVersion: v1
kind: Service
metadata:
  name: {{USER_NAME}}-{{SERVICE_NAME}}-nodeport
  namespace: {{NAMESPACE}}
spec:
  type: NodePort
  selector:
    app: {{USER_NAME}}-{{SERVICE_NAME}}
  ports:
    - name: http
      protocol: TCP
      port: 8080          # 클러스터 내부에서 접근하는 Service 포트
      targetPort: 8080    # Pod 컨테이너 포트
    - name: mgmt
      protocol: TCP
      port: 8081
      targetPort: 8081
