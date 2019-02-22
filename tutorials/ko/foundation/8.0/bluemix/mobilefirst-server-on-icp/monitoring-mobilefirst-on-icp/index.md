---
layout: tutorial
title: IBM Cloud Private(ICP)에서 Mobile Foundation 모니터링
breadcrumb_title: Monitoring Mobile Foundation
relevantTo: [ios,android,windows,javascript]
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }

이 학습서에서는 IBM Cloud Private에서 실행 중인 Mobile Foundation을 모니터하기 위해 **Prometheus**를 통합하는 방법을 요약합니다.

IBM Mobile Foundation은 *MicroProfile 메트릭* API로 인스트루먼트화된 Mobile Foundation Server, Analytics 및 Application Center를 모니터할 수 있도록 `mpMetrics-1.0` 기능을 설정함으로써 모니터링 기능을 제공합니다. 이는 ICP에 배치된 Mobile Foundation 컨테이너의 JVM 및 시스템 레벨 메트릭을 모니터하는 데 도움이 됩니다.

`/metrics` API 요청에 대한 기본 응답 형식은 텍스트 형식이며 이 형식은 **Prometheus**와 호환 가능합니다.


## 프로시저
{: #procedure}

{{ site.data.keys.prod_icp }}에서 Mobile Foundation의 모니터링을 설정하려면 아래 단계를 완료하십시오.

### 1단계: IBM Monitoring 서비스 배치
a.  {{ site.data.keys.prod_icp }} 카탈로그에서 Monitoring 서비스를 배치하십시오.<br/>
b.  **카탈로그**로 이동하여 **ibm-icpmonitoring** helm 차트를 선택하고 설치하십시오. helm 차트는 {{ site.data.keys.prod_icp }}에 설치됩니다.<br/>
    ![icpmonitoring helm 선택](select-monitoring-helm.png)

### 2단계: **Prometheus** *configmap* 구성 업데이트

ICP 클러스터의 컨텍스트 구성 정보가 있는 ICP 인스턴스인 적절히 소싱된 터미널에서 다음 명령을 실행하십시오.<br/>
```bash
kubectl get svc | grep prometheus
```
<br/>
`ibm-icpmonitoring` 차트에 의해 배치되는 다수의 서비스가 표시됩니다. 이 학습서에서는 아래의 스크린샷에 표시된 바와 같이 `<name used for the helm release>-promethues`(mfp-prometheus-prometheus)라는 서비스에 초점을 맞추고 사용할 것입니다.<br/>

![배치된 서비스 가져오기](get-svcs-helm.png)
<br/>
이러한 서비스는 각각 연관된 *configmap* 오브젝트가 있습니다. Mobile Foundation 팟(Pod)의 메트릭 데이터를 가져오려면 Mobile Foundation Server에 대한 `mfpfserver` 어노테이션, Analytics에 대한 `mfpfanalytics` 어노테이션 및 Application Center에 대한 `mfpfappcenter` 어노테이션을 기타 몇몇 속성과 함께 서비스 배치에 추가하여 **mfp-prometheus-prometheus** 서비스와 연관된 *configmap*을 수정해야 합니다.<br/>
이를 달성하는 가장 간단한 방법은 아래 명령을 사용하여 소싱된 터미널에서 의도한 *configmap* 오브젝트를 편집하는 것입니다.<br/>
```bash
  kubectl edit configmap mfp-prometheus-prometheus
  ```
<br/>
이 명령은 vi 편집기에 요청된 YAML 파일을 가져옵니다.  파일 끝으로 화면 이동하여 `kind: ConfigMap` 바로 앞에 아래의 텍스트를 삽입하십시오.

Mobile Foundation Server 메트릭 구성(아래의 YAML 스니펫):<br/>

```yaml
# Configuration for MFP Server Monitoring
- job_name: 'mfpf-server'
scheme: 'https'
basic_auth:
  username: 'mfpRESTUser'
  password: 'mfpadmin'
tls_config:
  insecure_skip_verify: true
kubernetes_sd_configs:
  - role: endpoints
relabel_configs:
  - source_labels: [__meta_kubernetes_service_annotation_mfpfserver]
    action: keep
    regex: true
  - source_labels: [__address__, __meta_kubernetes_service_annotation_prometheus_io_port]
    action: replace
    target_label: __address__
    regex: (.+)(?::\d+);(\d+)
    replacement: $1:$2
  - action: labelmap
    regex: __meta_kubernetes_service_label_(.+)
```    
<br/>

Mobile Foundation Server 상태 검사 모니터링을 위한 구성(아래의 YAML 스니펫):<br/>

```yaml
# Configuration for MFP Health check  Monitoring<br/>
- job_name: 'mfp-healthcheck'
metrics_path: /mfpadmin/management-apis/2.0/diagnostic/healthCheck
scheme: 'https'
basic_auth:
  username: 'admin'
  password: 'admin'
tls_config:
  insecure_skip_verify: true
kubernetes_sd_configs:
  - role: endpoints
relabel_configs:
  - source_labels: [__meta_kubernetes_service_annotation_mfpfserver]
    action: keep
    regex: true
  - source_labels: [__address__, __meta_kubernetes_service_annotation_prometheus_io_port]
    action: replace
    target_label: __address__
    regex: (.+)(?::\d+);(\d+)
    replacement: $1:$2
  - action: labelmap
    regex: __meta_kubernetes_service_label_(.+)
```
<br/>
> **참고:** Mobile Foundation Analytics 및 Application Center 배치는 유사한 메트릭 구성을 따릅니다.

*job_name* 및 *source_labels*의 값은 앞에서 설명한 대로 변경됩니다.
  
### 3단계: 작업 업데이트 후 **Prometheus** 구성 다시 로드
아래의 curl 명령을 실행하십시오.<br/>
```cURL
curl -s -XPOST http://<ip address of the proxy node>:31271/-/reload
```
<br/>
![Prometheus config](prometheus-config.png)

### 4단계: Mobile Foundation 통계 모니터링

a. 브라우저에서 URL을 사용하여 **Prometheus** 콘솔로 이동하십시오. <br/>
```
http://<ip address of the Proxy Node>:31271
```
b. **Prometheus** 콘솔에서 아래 스크린샷에 표시된 대로 먼저 **상태**를 클릭한 후 드롭 다운에서 **대상**을 클릭하십시오.<br/>
  ![Prometheus 콘솔](prometheus-console.png)
c. Prometheus가 통계를 얻고 있는 모든 **대상**이 표시됩니다.<br/>
  ![appcenter를 대상으로 지정](target-appcenter.png)<br/>
  ![모두를 대상으로 지정](target-all.png)
<br/>
  위의 스크린샷은 Mobile Foundation Server, Analytics 및 Application Center **대상**을 명확히 보여줍니다. 2단계에 표시된 *configmap* YAML 파일의 *job_name* 속성의 값을 참조하십시오.<br/>
  배치 샘플을 두 개의 복제본으로 스케일업했으며 이로 인해 **Prometheus**는 서버에 대해 두 개의 엔드포인트가 스크랩되는 것을 보여줍니다.<br/>

  **Prometheus** 콘솔 및 후속 패널에서 **그래프**를 클릭하는 경우 아래의 스크린샷에 표시된 대로 **커서에서 메트릭 삽입**을 클릭하십시오.<br/>
  ![Prometheus 그래프](graph-config.png)

  현재 **Prometheus** 구성으로 모니터할 수 있는 다수의 메트릭이 표시됩니다. 긴 목록의 메트릭 중 **base:**로 시작하는 메트릭 이름은 `mpMetrics-1.0` 기능이 제공하는 Mobile Foundation 컨테이너에서 가져온 것입니다.<br/>
  ![Mobile Foundation 메트릭](metrics.png)

  Liberty 메트릭(예: **base:thread_count**)을 선택하면 아래 스크린샷에 표시된 대로 Prometheus 그래프에서 두 Mobile foundation Server 팟의 값을 볼 수 있습니다.<br/>
  ![스레드 수 그래프](thread-count-graph.png)

  **콘솔**을 클릭하여 **Prometheus**에서 기타 관련 메트릭을 그래픽 및 숫자 형식으로 탐색할 수 있습니다.<br/>
  배치를 스케일링할 수도 있습니다. 단기간 내에 Prometheus 콘솔의 엔드포인트 수가 복제본의 수와 일치하게 됩니다.  <br/>

  >**참고:** Prometheus의 *configmap* 파일에서 비밀번호에 일반 텍스트를 사용했지만 Prometheus는 Prometheus 패널에 해당 구성이 표시될 때 비밀번호를 표시하지 않습니다.

### 5단계: **Grafana** 대시보드에서 메트릭 보기
Mobile Foundation helm 차트에는 샘플 Grafana 대시보드 json 파일이 포함되며, 1단계에서 배치된 Monitoring 서비스에는 Grafana가 갖추어져 있습니다.<br/>

JSON 파일에서 Grafana 대시보드를 가져오는 방법은 다음과 같습니다.<br/>

* 배치된 모니터링 서비스에서 Grafana를 시작하십시오.<br/>
  <b>워크로드 -> Helm 릴리스 -> `<name used for the helm release>`(예: mfp-prometheus) ->시작)</b>

* [GitHub](https://github.ibm.com/IBMPrivateCloud/charts/tree/master/stable/ibm-mfpf-server-prod/additionalFiles/ibm-mfpf-server-prod-grafanadashboard.json)에서 로컬 워크스테이션으로 JSON 대시보드 파일을 다운로드하십시오.   <br/>

* Grafana 인터페이스에서 *홈* 단추를 클릭한 후 **대시보드 가져오기**를 클릭하십시오.<br/>

* **.json 파일 업로드** 단추를 클릭하고 로컬 파일 시스템에서 Grafana 대시보드 JSON 파일을 선택하십시오.<br/>

* **데이터 소스 선택** 메뉴에서 **prometheus**를 선택하십시오(아직 선택하지 않은 경우).<br/>

* **가져오기**를 클릭하십시오.<br/>

아래의 스크린샷에 Mobile Foundation Server용 샘플 모니터링 대시보드가 표시되어 있습니다.<br/>
![대시보드 1](dashboard-1.png)
![대시보드 2](dashboard-2.png)
![대시보드 3](dashboard-3.png)
