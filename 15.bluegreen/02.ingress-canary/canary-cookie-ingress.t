apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  annotations:
    nginx.ingress.kubernetes.io/canary: "true"
    nginx.ingress.kubernetes.io/canary-by-cookie: "canary-session"
  name: {{USER_NAME}}-cert-canary-ingress
  namespace: {{NAMESPACE}}
  labels:
    app: {{USER_NAME}}-cert-canary-ingress
spec:
  ingressClassName: {{INGRESS_CLASS_NAME}}
  rules:
  - host: {{USER_NAME}}-cert-ingress.{{NAMESPACE}}.skala-{{LOCATION}}.com
    http:
      paths:
      - backend:
          service:
            name: {{USER_NAME}}-green
            port:
              number: 8080
        path: /
        pathType: Prefix
  tls:
  - hosts:
    - '{{USER_NAME}}-cert-ingress.{{NAMESPACE}}.skala-{{LOCATION}}.com'
    secretName: wildcard-{{NAMESPACE}}-skala-{{LOCATION}}-com-tls

