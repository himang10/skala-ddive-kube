# SKALA 쿠버네티스 심화 교육 1편 샘플 코드

이 저장소는 SK AX에서 시행하고 있는 SKALA 쿠버네티스 심화 교육 1편의 실습을 위한 샘플 코드입니다.

> **사용 안내**  
> 본 코드와 교육 자료는 무단으로 외부에서 사용하거나 복제·배포할 수 없으며, 임의로 가져가 사용할 수 없습니다. 사용이 필요한 경우 사전에 작성자의 허가를 받아 주세요.

## 디렉토리별 교육 내용

| 디렉토리 | 교육 내용 |
| --- | --- |
| `00.sample-container/` | 실습을 위한 컨테이너 이미지를 빌드하고 배포하기 위한 코드 |
| `01.kube-system/` | 쿠버네티스 시스템 구성 요소와 클러스터 프로세스 확인 |
| `02.kube-api/` | 쿠버네티스 API 서버에 요청하고 리소스 정보를 확인하는 방법 |
| `03.serviceaccount/` | 서비스 어카운트와 kubeconfig를 이용한 인증 및 접근 |
| `04.role/` | Role, RoleBinding, ClusterRole 기반의 RBAC 권한 관리 |
| `05.cmdargs/` | 컨테이너 실행 시 명령과 인자를 설정하는 방법 |
| `06.init-container/` | 초기화 컨테이너를 이용해 애플리케이션 시작 전 작업 수행 |
| `07.sidecar/` | 사이드카 컨테이너와 공유 설정을 이용한 보조 기능 구성 |
| `08.replicaset/` | ReplicaSet으로 파드 복제 수와 배포 버전 관리 |
| `09.statefulset/` | StatefulSet과 헤드리스 서비스를 이용한 상태형 애플리케이션 운영 |
| `10.service/` | Service 유형별 파드 연결 및 서비스 디스커버리 |
| `11.configmap/` | ConfigMap으로 설정값과 파일을 외부화하는 방법 |
| `12.secret/` | Secret으로 민감한 설정값과 파일을 전달하는 방법 |
| `13.volume/` | 볼륨과 스토리지 클래스를 이용한 컨테이너 데이터 관리 |
| `14.ingress/` | Ingress와 TLS 설정을 통한 외부 HTTP/HTTPS 트래픽 라우팅 |
| `15.bluegreen/` | 블루-그린 배포와 Ingress 카나리 배포 실습 |
| `16.grace-shutdown/` | 애플리케이션의 정상 종료와 종료 유예 시간 설정 |
| `17.probe/` | 시작·준비·활성 프로브를 이용한 컨테이너 상태 점검 |
| `18.cronjob/` | Job과 CronJob으로 일회성 및 주기성 작업 실행 |
| `19.security/` | 파드 보안 컨텍스트, 비특권 실행, capability 설정 |
| `20.qos/` | 리소스 요청·제한에 따른 QoS와 우선순위 설정 |

## 작성자 및 문의

- 작성자: 이용우
- 문의: [himang10@sk.com](mailto:himang10@sk.com), [himang10@gmail.com](mailto:himang10@gmail.com)
