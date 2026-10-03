#!/bin/bash

# ----------------------------------------------------------
# TLS 인증서를 사용하여 공개키를 추출하고 데이터를 디지털 서명하는 스크립트 코드
# ----------------------------------------------------------

# public key를 파일(tls-pub.pem)로 저장
openssl x509 -in tls.crt -pubkey -noout > tls-pub.pem


# [사용 예 2] 개인키로 서명 후 공개키로 서명 검증
openssl dgst -sha256 -sign tls.key -out plain.sig plain.txt
openssl dgst -sha256 -verify tls-pub.pem -signature plain.sig plain.txt