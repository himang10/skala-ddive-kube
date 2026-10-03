apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  annotations:
    cert-manager.io/cluster-issuer: letsencrypt-prod
    nginx.ingress.kubernetes.io/priority: "1000"
  name: {{USER_NAME}}-cm-tls-ingress
  namespace: {{NAMESPACE}}
spec:
  ingressClassName: {{INGRESS_CLASS_NAME}}
  rules:
  - host: {{USER_NAME}}-cm-ingress.{{NAMESPACE}}.skala-{{LOCATION}}.com
    http:
      paths:
      - backend:
          service:
            name: {{USER_NAME}}-{{SERVICE_NAME}}
            port:
              number: 8080
        path: /api
        pathType: Prefix
      - backend:
          service:
            name: {{USER_NAME}}-{{SERVICE_NAME}}
            port:
              number: 8080
        path: /actuator
        pathType: Prefix
      - backend:
          service:
            name: {{USER_NAME}}-{{SERVICE_NAME}}
            port:
              number: 8080
        path: /swagger
        pathType: Prefix
      - backend:
          service:
            name: {{USER_NAME}}-{{SERVICE_NAME}}
            port:
              number: 8080
        path: /
        pathType: Prefix
  tls:
  - hosts:
    - {{USER_NAME}}-cm-ingress.{{NAMESPACE}}.skala-{{LOCATION}}.com
    secretName: {{USER_NAME}}-cm-auto-tls-secret
