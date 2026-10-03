apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: {{USER_NAME}}-manual-tls-ingress
  namespace: {{NAMESPACE}}
spec:
  ingressClassName: {{INGRESS_CLASS_NAME}}
  rules:
  - host: {{USER_NAME}}-manual-tls-ingress.{{NAMESPACE}}.skala-{{LOCATION}}.com
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
              number: 8081
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
    - {{USER_NAME}}-manual-tls-ingress.{{NAMESPACE}}.skala-{{LOCATION}}.com
    secretName: {{USER_NAME}}-manual-tls-secret
