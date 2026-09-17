#!/bin/bash
USER_NAME=sk199

# ============================================================
# Load Test Script using hey (분당 요청 수 기반)
# ============================================================
# 환경 변수 설정 (기본값 포함)
TARGET_URL="${TARGET_URL:-https://${USER_NAME}-ingress.skala25a.project.skala-ai.com/api/users}"
RPM="${RPM:-60}"                       # 분당 요청 수 (Requests Per Minute)
CONCURRENCY="${CONCURRENCY:-1}"       # 동시 접속 수 (-c)
DURATION="${DURATION:-2m}"             # 실행 시간 (-z), 예: 30s, 1m, 5m
METHOD="${METHOD:-GET}"                # HTTP Method

# ============================================================
# hey 설치 확인
if ! command -v hey &> /dev/null; then
  echo "[ERROR] 'hey' 가 설치되어 있지 않습니다. 설치를 시작합니다..."
  brew install hey
fi

# ============================================================
# RPM → QPS (초당 요청 수) 변환
# hey의 -q 옵션은 초당 요청 수(QPS) 기준이므로 RPM / 60 으로 변환
QPS=$(awk "BEGIN {printf \"%.4f\", ${RPM}/60}")

# ============================================================
# 실행 정보 출력
echo "============================================================"
echo "  Load Test Start (분당 요청 수 기반)"
echo "============================================================"
echo "  URL         : ${TARGET_URL}"
echo "  분당 요청   : ${RPM} req/min"
echo "  초당 요청   : ${QPS} req/s"
echo "  동시 접속   : ${CONCURRENCY}"
echo "  실행 시간   : ${DURATION}"
echo "  HTTP Method : ${METHOD}"
echo "============================================================"
echo ""

# ============================================================
# 실행
hey -c "${CONCURRENCY}" \
    -q "${QPS}" \
    -z "${DURATION}" \
    -m "${METHOD}" \
    "${TARGET_URL}"
