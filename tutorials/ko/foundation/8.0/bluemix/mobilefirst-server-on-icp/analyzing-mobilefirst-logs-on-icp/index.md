---
layout: tutorial
title: IBM Cloud Private에서 MobileFirst 로그 메시지 분석
breadcrumb_title: Analyzing MobileFirst log messages
relevantTo: [ios,android,windows,javascript]
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }

{{ site.data.keys.prod_icp }}의 {{ site.data.keys.prod_adj }} 배치에서는 콘솔에서 JSON 형식 로깅을 사용하는 기본 Liberty를 실행하는 경우 로그 이벤트가 필드로 구분되어 Elasticsearch에 저장될 수 있습니다. Kibana를 사용하여 대시보드를 통해 여러 Liberty 팟(Pod)을 모니터링하고 검색하거나 조회를 통해 많은 로그 레코드를 필터링할 수 있습니다.

Kubernetes 배치는 팟(Pod)으로 구성되며, 팟(Pod)은 컨테이너로 구성됩니다. {{ site.data.keys.prod_icp }}에서 각 팟(Pod)의 콘솔 출력은 기본 탄력적 로깅 스택으로 자동 전달됩니다. 탄력적 로깅에 대한 자세한 정보는 [{{ site.data.keys.prod_icp }}로깅](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_2.1.0/manage_metrics/logging_elk.html)을 참조하십시오.


## 프로시저
{: #procedure}

단계를 완료하여 {{ site.data.keys.prod_icp }} 카탈로그를 찾아보고 적절한 Helm 차트를 선택하십시오. 이를 사용하여 애플리케이션을 배치합니다.

1.  Helm 차트에서 JSON 로깅을 사용으로 설정하십시오.

      a.  {{ site.data.keys.prod_icp }} 콘솔에서 **메뉴 > 카탈로그**를 클릭하십시오.<br/>
      b.  **로그** 섹션에서 **ibm-mfpfp-server-prod / ibm-mfpfp-analytics-prod / ibm-mfpf-appcenter-prod** Helm 차트를 선택하십시오.<br/>

      **참고:**  콘솔에 액세스할 때 Helm 카탈로그가 이 Helm 차트를 포함하지 않으면 **관리 > Helm 저장소**를 선택하고 저장소를 동기화하는 단추를 클릭하여 카탈로그를 새로 고치십시오.

      c.  로깅 필드를 다음 기본값으로 설정하십시오. 또는 명령행에서 `--set` 플래그를 사용하여 {{ site.data.keys.prod_adj }} Helm 차트를 배치할 때 이전 값을 설정할 수 있습니다.<br/>
      <p><b>JSON 로깅에 대한 Helm 차트 필드 및 값</b></p>            
      <table class="table table-bordered" >
        <thead>
          <tr>
            <th>GUI 필드 이름</th>
            <th>명령행 필드 이름</th>
            <th>필드 값</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>콘솔 로깅 형식 </td>
            <td>logs.consoleFormat</td>
            <td>json</td>
          </tr>
          <tr>
            <td>콘솔 로깅 레벨</td>
            <td>logs.consoleLogLevel</td>
            <td>info</td>
          </tr>
          <tr>
            <td>콘솔 로깅 소스</td>
            <td>logs.consoleLogLevel</td>
            <td>message, trace, accessLog, ffdc<br/><br/>지원되는 소스 유형은 messages, traces, accessLog 또는 ffdc입니다.  <br/>콘솔 로깅 소스에서 쉼표로 구분된 목록으로 각 소스 유형을 지정하십시오. <br/>accessLog를 사용하려면 <code>server.xml</code> 파일에 추가 설정이 필요합니다. <br/>자세한 정보는 <a href="https://www.ibm.com/support/knowledgecenter/SSAW57_liberty/com.ibm.websphere.wlp.nd.multiplatform.doc/ae/rwlp_http_accesslogs.html?view=kc">HTTP 액세스 로깅</a>을 참조하십시오.</td>
          </tr>
        </tbody>
      </table>
2.  Kibana를 배치하십시오.<br/>
    JSON 로깅이 사용으로 설정된 상태로 Liberty를 배치한 후에는 로그 레코드가 Elasticsearch에 저장되고, Kibana에서 로그 레코드를 볼 수 있습니다.<br/>

      a.  Kibana를 배치하려면 콘솔에서 **카탈로그 > Helm Charts**를 클릭하십시오.<br/>
      b.  **ibm-icplogging-kibana** Helm 차트를 선택하고 대상 네임스페이스에서 **kube-system**을 클릭하십시오.<br/>
      c.  **설치**를 클릭하십시오.<br/>

3.  Kibana를 여십시오.<br/>

      a.  콘솔에서 **네트워크 액세스 > 서비스**를 클릭하십시오.<br/>
      b.  서비스 목록에서 **Kibana**를 선택하십시오.<br/>
      c.  **노드 포트** 필드에서 링크를 클릭하여 Kibana를 여십시오.<br/>

4.  Kibana에서 색인 패턴을 작성하십시오.<br/>

      a.  Kibana에서 **관리 > 색인 패턴**을 클릭하십시오. 패턴의 색인 이름으로 `logstash-*`를 입력하십시오.<br/>
      b.  *시간 필터* 필드 이름으로 **ibm_datetime**을 선택하십시오.<br/>
      c.  **작성**을 클릭하십시오.<br/>

5. 고유한 조회, 시각화 또는 대시보드를 작성하여 로그 데이터를 분석할 수 있습니다.

6. [여기](https://github.com/WASdev/sample.dashboards)에서 샘플 대시보드 세트를 다운로드하십시오. Kibana로 대시보드를 가져오려면 **관리 > 저장된 오브젝트**를 선택하고 **가져오기**를 클릭하십시오.

## 추가 정보
{: #further_reading}

* [{{ site.data.keys.prod_icp }}에서 Liberty 로깅](https://www.ibm.com/support/knowledgecenter/SSAW57_liberty/com.ibm.websphere.wlp.nd.multiplatform.doc/ae/twlp_icp_logging.html?view=kc)
