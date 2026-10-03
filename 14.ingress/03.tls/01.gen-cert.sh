#!/bin/bash

USER_NAME=${STUDENT_NUM}
CLASS_NAME=${CLASS_NAME}
LOCATION=${LOCATION}


# ----------------------------------------------------------
# TLS 인증서와 키 파일을 생성하고 확인하는 스크립트 코드
# ----------------------------------------------------------


#1. tls.key 와 tls.crt 파일을 생성합니다.
# 1년짜리 self-signed 인증서 생성
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -subj "/CN=${USER_NAME}-ingress.${CLASS_NAME}.skala-${LOCATION}.com/O=com.sk.skala" \
  -keyout tls.key \
  -out tls.crt

# 2. 생성된 인증서와 키 파일을 확인합니다.
ls -l tls.key tls.crt

# 3. X.509 인증서 파일 tls.crt의 내용을 확인합니다.
openssl x509 -in tls.crt -text -noout

# 4. public key를 출력해봅니다.
openssl x509 -in tls.crt -pubkey -noout