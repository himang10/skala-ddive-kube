#!/bin/bash
# TLS 흐름 요약: 비대칭키(tls.crt/tls.key)로 session.key를 안전하게 전달 -> session.key(대칭키)로 데이터 암호화
# 주의: tls.key(개인키)는 서버를 떠나지 않고, 네트워크로는 tls.crt(공개 인증서)만 전달된다.

set -e
rm -rf server client && mkdir -p server client

# 1. [Server] 키 쌍 준비: tls.key(개인키, 비공개) + tls.crt(인증서, 공개키 포함)
openssl genpkey -algorithm RSA -pkeyopt rsa_keygen_bits:2048 -out server/tls.key 2>/dev/null
openssl req -new -x509 -key server/tls.key -out server/tls.crt -days 365 \
  -subj "/CN=example.com" -addext "subjectAltName=DNS:example.com"

# 2. [Server -> Client] tls.crt 전달 (Client는 이 안의 공개키를 얻는다)
cp server/tls.crt client/tls.crt
openssl verify -CAfile client/tls.crt client/tls.crt   # 자체 서명이라 자기 자신을 신뢰 목록에 넣어 검증

# 3. [Client] session.key 생성 후, 서버 공개키(tls.crt)로 암호화해서 전송
openssl rand -base64 32 > client/session.key
openssl x509 -in client/tls.crt -pubkey -noout > client/public.pem
openssl pkeyutl -encrypt -pubin -inkey client/public.pem \
  -pkeyopt rsa_padding_mode:oaep \
  -in client/session.key \
  -out client/session.key.enc

cp client/session.key.enc server/session.key.enc       # Client -> Server

# 4. [Server] 개인키(tls.key)로 복호화 -> 양쪽이 같은 session.key를 갖게 됨
openssl pkeyutl -decrypt -inkey server/tls.key \
  -pkeyopt rsa_padding_mode:oaep \
  -in server/session.key.enc \
  -out server/session.key
cmp client/session.key server/session.key && echo "session.key 공유 완료"

# 5. [Client -> Server] 이후 데이터는 session.key(대칭키)로 암호화
cat > client/plain.txt <<EOF
Hello, TLS!
이 데이터는 session.key(AES-256)로 암호화되어 전송됩니다.
EOF
openssl enc -aes-256-cbc -salt -pbkdf2 -iter 100000 \
  -pass file:client/session.key \
  -in client/plain.txt -out client/plain.enc
cp client/plain.enc server/plain.enc                   # 네트워크로는 암호문만 이동

# 6. [Server] session.key로 복호화
openssl enc -aes-256-cbc -d -pbkdf2 -iter 100000 \
  -pass file:server/session.key \
  -in server/plain.enc -out server/plain.txt
echo "--- Server가 받은 평문 ---"
cat server/plain.txt
