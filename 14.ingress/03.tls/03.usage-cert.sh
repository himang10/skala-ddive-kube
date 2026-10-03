#!/bin/bash

# ----------------------------------------------------------
# TLS 인증서를 사용하여 공개키를 추출하고 데이터를 암호화/복호화하는 스크립트 코드
# ----------------------------------------------------------


# public key를 파일(tls-pub.pem)로 저장
openssl x509 -in tls.crt -pubkey -noout > tls-pub.pem


# [사용 예 1] 공개키로 데이터 암호화 (개인키로만 복호화 가능)
echo "hello skala" > plain.txt
openssl pkeyutl -encrypt -pubin -inkey tls-pub.pem -in plain.txt -out secret.enc
# 복호화는 개인키로 수행
openssl pkeyutl -decrypt -inkey tls.key -in secret.enc