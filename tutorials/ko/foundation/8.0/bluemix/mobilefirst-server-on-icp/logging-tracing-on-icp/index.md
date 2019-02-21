---
layout: tutorial
title: IBM Cloud Private의 로깅 및 추적
breadcrumb_title: Logging and Tracing
relevantTo: [ios,android,windows,javascript]
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
{{ site.data.keys.product_full }}에서는 오류, 경고 및 정보 메시지를 로그 파일에 기록합니다. 로깅의 기본 메커니즘은 애플리케이션 서버에 따라 다릅니다. {{ site.data.keys.prod_icp }}에서 유일하게 지원되는 애플리케이션 서버는 Liberty입니다.

다음 문서에서는 {{ site.data.keys.prod_icp }}의 Kubernetes 클러스터에서 실행되는 {{ site.data.keys.mf_server }}에 대한 로그 추적 및 수집을 사용으로 설정하는 방법에 대해 설명합니다.


#### 다음으로 이동:
{: #jump-to }
* [전제조건](#prereqs)
* [로깅 및 모니터링 메커니즘 구성](#configure-log-monitor)
* [*kubectl* 로그 수집](#collect-kubectl-logs)
* [IBM에서 제공하는 사용자 정의 스크립트를 사용하여 로그 수집](#collect-logs-custom-script)


## 전제조건
{: #prereqs}

로그 수집 및 문제점 해결에 필요한 다음 도구를 설치 및 구성하십시오.
* Docker(`docker`)
* Kubernetes CLI(`kubectl`)

{{ site.data.keys.prod_icp }}에서 실행되는 클러스터에 대한 `kubectl` 클라이언트를 구성하려면 [여기](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_2.1.0/manage_cluster/cfc_cli.html)에서 설명한 대로 해당 단계를 따르십시오.


## 로깅 및 모니터링 메커니즘 구성
{: #configure-log-monitor}

기본적으로 모든 {{ site.data.keys.product }} 로깅은 애플리케이션 서버 로그 파일로 이동합니다. Liberty에서 사용 가능한 표준 도구를 {{ site.data.keys.product }} 서버 로깅을 제어하는 데 사용할 수 있습니다. [로깅 및 모니터링 메커니즘 구성](https://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.installconfig.doc/admin/r_logging_and_monitoring_mechanisms.html)의 문서에서 자세히 알아보십시오.

[로깅 및 모니터링 메커니즘 구성](https://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.installconfig.doc/admin/r_logging_and_monitoring_mechanisms.html)에서는 로깅을 구성하기 위해 `server.xml`을 업데이트할 수 있는 방법에 대한 세부사항 및 추적 사용 설정에 대한 정보 또한 제공합니다. 선택적으로 추적을 사용으로 설정하려면 `com.ibm.ws.logging.trace.specification` 필터를 사용하십시오([자세히 알아보기](https://www.ibm.com/support/knowledgecenter/en/SSEQTP_8.5.5/com.ibm.websphere.wlp.doc/ae/rwlp_logging.html)). 이 특성은 서버 인스턴스의 `jvm.option` 또는 `bootstrap.properties`를 통해 지정할 수 있습니다.

예를 들어, `jvm.options`에 다음 항목을 추가하면 `com.ibm.mfp`로 시작하는 모든 메소드에 대한 추적이 사용으로 설정되며 추적 레벨은 *모두*로 설정됩니다.
```
-Dcom.ibm.ws.logging.trace.specification=com.ibm.mfp.*=all=enabled
```
 JNDI 구성을 사용하여 이 항목을 설정할 수도 있습니다. 자세한 정보는 [여기]({{ site.baseurl }}/tutorials/en/foundation/8.0/bluemix/mobilefirst-server-on-icp/#env-mf-server)를 참조하십시오.


## *kubectl* 로그 수집
{: #collect-kubectl-logs}

`kubectl logs` 명령은 Kubernetes Cluster에 배치된 컨테이너에 대한 정보를 가져오는 데 사용할 수 있습니다. 예를 들어, 다음 명령은 명령에 *pod_name*이 제공된 포드에 대한 로그를 검색합니다.

```bash
kubectl logs po/<pod_name>
```
`kubectl logs` 명령에 대한 자세한 정보는 [Kubernetes 문서](https://kubernetes-v1-4.github.io/docs/user-guide/kubectl/kubectl_logs/)를 참조하십시오.

## IBM에서 제공하는 사용자 정의 스크립트를 사용하여 로그 수집
{: #collect-logs-custom-script}

{{ site.data.keys.mf_server }} 로그 및 컨테이너 로그는 [get-icp-logs.sh](get-icp-logs.sh) 스크립트를 사용하여 수집할 수 있습니다. *Helm 릴리스 이름*을 입력으로 사용하고 배치된 모든 포드에서 로그를 수집합니다.

스크립트는 다음과 같이 실행할 수 있습니다.
```bash
get-icp-logs <helm_release_name> [<output_directory>] [<name_space>]
```
아래의 표에서는 사용자 정의 스크립트에서 사용되는 각 매개변수에 대해 설명합니다.

| 옵션 |설명 | 비고 |
|--------|-------------|---------|
| helm_release_name | 각 Helm Chart 설치의 릴리스 이름 | **필수** |
| output_directory | 수집된 로그를 배치할 출력 디렉토리 | **선택사항**<br/>기본값: 현재 작업 디렉토리 아래의 **mfp-icp-logs**. |
| name_space | 각 Helm Chart가 설치된 네임스페이스 | **선택사항**<br/>기본값: **default**. |
