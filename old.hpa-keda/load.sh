#!/bin/bash

# ============================================================
# Load Test Script using hey
# ============================================================
# 환경 변수 설정 (기본값 포함)
#TARGET_URL="${TARGET_URL:-https://sk199-tls.skala25a.project.skala-ai.com/api/users}"
TARGET_URL="${TARGET_URL:-https://sk199-tls.skala25a.project.skala-ai.com/api/load-cpu?duration-sec=10}"
CONCURRENCY="${CONCURRENCY:-400}"       # 동시 접속 수 (-c)
REQUESTS="${REQUESTS:-0}"              # 총 요청 수 (-n), 0이면 duration 기반
QPS="${QPS:-0}"                        # 초당 요청 수 (-q), 0이면 무제한
DURATION="${DURATION:-2m}"             # 실행 시간 (-z), REQUESTS=0 일 때 사용
METHOD="${METHOD:-GET}"                # HTTP Method

# ============================================================
# hey 설치 확인
if ! command -v hey &> /dev/null; then
  echo "[ERROR] 'hey' 가 설치되어 있지 않습니다."
  brew install hey
fi

# ============================================================
# 파라미터 구성
HEY_ARGS="-c ${CONCURRENCY} -m ${METHOD}"

if [ "${QPS}" != "0" ]; then
  HEY_ARGS="${HEY_ARGS} -q ${QPS}"
fi

if [ "${REQUESTS}" != "0" ]; then
  HEY_ARGS="${HEY_ARGS} -n ${REQUESTS}"
else
  HEY_ARGS="${HEY_ARGS} -z ${DURATION}"
fi

# ============================================================
# 실행 정보 출력
echo "============================================================"
echo "  Load Test Start"
echo "============================================================"
echo "  URL         : ${TARGET_URL}"
echo "  동시 접속   : ${CONCURRENCY}"
echo "  총 요청 수  : $([ "${REQUESTS}" != "0" ] && echo "${REQUESTS}건" || echo "시간 기반")"
echo "  실행 시간   : $([ "${REQUESTS}" != "0" ] && echo "요청 수 완료 시까지" || echo "${DURATION}")"
echo "  초당 요청   : $([ "${QPS}" != "0" ] && echo "${QPS} req/s" || echo "무제한")"
echo "  HTTP Method : ${METHOD}"
echo "============================================================"
echo ""

# ============================================================
# 실행
hey ${HEY_ARGS} "${TARGET_URL}"
