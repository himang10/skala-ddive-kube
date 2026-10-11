apiVersion: v1
kind: ConfigMap
metadata:
  name: {{USER_NAME}}-nginx-sidecar-config
  namespace: {{NAMESPACE}}
data:
  default.conf: |
    server {
        listen 80;

        location / {
            proxy_pass http://127.0.0.1:8080;

            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;

            # Sidecar를 통과했다는 것을 확인하기 위한 Header
            add_header X-Sidecar-Proxy "nginx-sidecar" always;
        }

        location /nginx-health {
            return 200 "nginx sidecar is running\n";
        }
    }
