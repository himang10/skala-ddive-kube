# DaemonSet 실습

## 개념

**DaemonSet**은 클러스터의 **모든 노드(또는 선택된 노드)에 반드시 1개씩** 파드를 배포하는 워크로드 리소스입니다.

- 새 노드가 추가되면 → 자동으로 파드 배포
- 노드가 제거되면 → 해당 파드 자동 삭제
- Deployment와 달리 replica 수를 지정하지 않음

### 대표 사용 사례
| 용도 | 예시 |
|------|------|
| 노드 로그 수집 | Fluentd, Filebeat |
| 노드 모니터링 | node-exporter (Prometheus) |
| 네트워크 플러그인 | Calico, Flannel |
| 스토리지 플러그인 | GlusterFS, Ceph |

---

## 실습 파일

| 파일 | 설명 |
|------|------|
| `daemonset.t` | 템플릿 (변수 포함) |
| `daemonset.yaml` | 실제 배포용 |

**daemonset 동작**: 각 노드에서 10초마다 현재 시간과 노드 이름을 출력하는 로거 파드를 실행합니다.

---

## 실습 순서

### 1. 배포
```bash
kubectl apply -f daemonset.yaml
```

### 2. DaemonSet 상태 확인
```bash
kubectl get daemonset -n class-cloud
```
> `DESIRED` = 노드 수, `CURRENT` = 실제 실행 중인 파드 수

### 3. 파드가 어느 노드에 배포됐는지 확인
```bash
kubectl get pod -n class-cloud -o wide | grep node-logger
```
> `-o wide` 로 NODE 컬럼 확인 → 각 노드에 1개씩 배포됨

### 4. 로그 확인 (노드 이름 출력 확인)
```bash
# 파드 이름 확인 후
kubectl logs -n class-cloud <pod-name>
```
출력 예시:
```
[2026-04-11_10:00:00] Running on node: ip-10-0-1-25.ec2.internal
```

### 5. 리소스 삭제
```bash
kubectl delete -f daemonset.yaml
```

---

## Deployment vs DaemonSet 비교

| 항목 | Deployment | DaemonSet |
|------|-----------|-----------|
| 파드 수 | replicas로 지정 | 노드 수만큼 자동 |
| 배포 단위 | 클러스터 내 임의 노드 | 모든(또는 선택된) 노드 |
| 주 용도 | 애플리케이션 서버 | 인프라 에이전트 |
