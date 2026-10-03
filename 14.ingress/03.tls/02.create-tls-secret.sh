#!/bin/bash

# ----------------------------------------------------------
# Kubernetes에 TLS 시크릿을 생성하고 확인하는 스크립트 코드
# ----------------------------------------------------------

# 1. TLS 시크릿을 k8s에 생성합니다.
kubectl create secret tls ${STUDENT_NUM}-manual-tls-secret \
        --key tls.key \
        --cert tls.crt \
        -n ${CLASS_NAME}

# 2. 생성된 TLS 시크릿을 확인합니다.
kubectl get secret ${STUDENT_NUM}-manual-tls-secret -o yaml -n ${CLASS_NAME}