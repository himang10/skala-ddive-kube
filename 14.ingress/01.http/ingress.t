apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: {{USER_NAME}}-ingress
  namespace: {{NAMESPACE}}
spec:
  ingressClassName: {{INGRESS_CLASS_NAME}}
  rules:
  - host: {{USER_NAME}}-ingress.{{NAMESPACE}}.skala-{{LOCATION}}.com
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
