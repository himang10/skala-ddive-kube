#!/bin/bash

DOMAIN=${DOMAIN:-example.com}

# 암호화 대상 평문 파일 생성
cat > plain.txt <<EOF
Hello, OpenSSL!
이 파일은 비대칭키(RSA)로 암호화됩니다.
EOF

# 개인키(tls.key) 생성 (RSA 2048)
openssl genpkey -algorithm RSA -pkeyopt rsa_keygen_bits:2048 -out tls.key

# 자체 서명 인증서(tls.crt) 생성 (유효기간 365일)
openssl req -new -x509 -key tls.key -out tls.crt -days 365 \
  -subj "/CN=${DOMAIN}/O=${DOMAIN}" \
  -addext "subjectAltName=DNS:${DOMAIN}"

# 인증서에서 공개키 추출
openssl x509 -in tls.crt -pubkey -noout > public.pem

# 공개키로 암호화 (RSA-OAEP, 입력 크기 제한 있음)
openssl pkeyutl -encrypt -pubin -inkey public.pem \
  -pkeyopt rsa_padding_mode:oaep \
  -in plain.txt \
  -out secret.enc

# 개인키로 복호화
openssl pkeyutl -decrypt -inkey tls.key \
  -pkeyopt rsa_padding_mode:oaep \
  -in secret.enc \
  -out decrypted.txt

# 서명 및 검증
openssl dgst -sha256 -sign tls.key -out plain.sig plain.txt
openssl dgst -sha256 -verify public.pem -signature plain.sig plain.txt

# Kubernetes TLS Secret 생성 예시
# kubectl create secret tls tls-secret --cert=tls.crt --key=tls.key
