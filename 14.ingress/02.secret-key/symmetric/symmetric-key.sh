#!/bin/bash

# 암호화 대상 평문 파일 생성
cat > plain.txt <<EOF
Hello, OpenSSL!
이 파일은 대칭키(AES-256-CBC)로 암호화됩니다.
EOF

openssl rand -base64 32 > secret.key

openssl enc -aes-256-cbc -salt -pbkdf2 -iter 100000 \
  -pass file:secret.key \
  -in plain.txt \
  -out secret.enc 



openssl enc -aes-256-cbc -d -pbkdf2 -iter 100000 \
  -pass file:secret.key \
  -in secret.enc \
  -out decrypted.txt 
