---
layout: tutorial
title: MobileFirst Analytics Server 구성 안내서
breadcrumb_title: Configuration Guide
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
{{ site.data.keys.mf_analytics_server }}에 대한 일부 구성이 필요합니다. 표시된 대로 구성 매개변수 중 일부는 단일 노드에 적용되고 일부는 전체 클러스터에 적용됩니다.

#### 다음으로 이동
{: #jump-to }

* [구성 특성](#configuration-properties)
* [Analytics 데이터 백업](#backing-up-analytics-data)
* [클러스터 관리 및 Elasticsearch](#cluster-management-and-elasticsearch)

### 특성
{: #properties }
구성 특성의 전체 목록 및 애플리케이션 서버에서 이 특성을 설정하는 방법은 [구성 특성](#configuration-properties)을 참조하십시오.

* **discovery.zen.minimum\_master\_nodes** 특성은 분할뇌 신드롬을 방지하기 위해 **ceil((number of master-eligible nodes in the cluster / 2) + 1)**로 설정되어야 합니다.
    * 클러스터에서 마스터 적격인 Elasticsearch 노드는 마스터인 마스터 적격 노드를 결정하기 위해 쿼럼을 설정해야 합니다.
    * 마스터 적격 노드를 클러스터에 추가하면 마스터 적격 노드의 수가 변경되므로 설정이 변경되어야 합니다. 새 마스터 적격 노드를 클러스터에 도입하는 경우 설정을 수정해야 합니다. 클러스터 관리 방법에 대한 자세한 정보는 [클러스터 관리 및 Elasticsearch](#cluster-management-and-elasticsearch)를 참조하십시오.
* 모든 노드에서 **clustername** 특성을 설정하여 클러스터에 이름을 지정하십시오.
    * Elasticsearch의 개발자 인스턴스가 기본 이름을 사용 중인 클러스터에 실수로 참여하지 않도록 클러스터에 이름을 지정하십시오.
* 각 노드에서 **nodename** 특성을 설정하여 각 노드에 이름을 지정하십시오.
    * 기본적으로 Elasticsearch는 각 노드의 이름을 임의의 Marvel 문자를 따라 지정하며 각 노드가 다시 시작될 때마다 노드 이름이 다릅니다.
* 각 노드에서 **datapath** 특성을 설정하여 데이터 디렉토리에 대한 파일 시스템 경로를 명시적으로 선언하십시오.
* 각 노드에서 **masternodes** 특성을 설정하여 전용 마스터 노드를 명시적으로 선언하십시오.

### 클러스터 복구 설정
{: #cluster-recovery-settings }
다중 노드 클러스터로 용량 확장한 후에는 전체 클러스터를 다시 시작해야 하는 경우가 있을 수 있습니다. 전체 클러스터를 다시 시작해야 하는 경우에는 복구 설정을 고려해야 합니다. 클러스터에 10개의 노드가 있는 경우 한 번에 한 노드씩 클러스터를 가져올 때 마스터 노드는 각 노드가 클러스터에 도착하는 즉시 데이터 밸런싱을 시작해야 한다고 가정합니다. 마스터가 이 방식으로 작동할 수 있는 경우에는 불필요한 재밸런싱이 많이 필요합니다. 마스터가 노드에 재밸런싱을 지시하려면 먼저 최소 개수의 노드가 클러스터에 참여할 때까지 대기하도록 클러스터 설정을 구성해야 합니다. 이를 통해 클러스터를 다시 시작하는 데 소요되는 시간을 몇 시간에서 몇 분으로 줄일 수 있습니다.

* 클러스터에서 지정된 수의 노드가 작동하고 참여할 때까지 Elasticsearch에서 재밸런싱을 시작하지 않게 하려면 **gateway.recover\_after\_nodes** 특성을 환경 설정으로 설정해야 합니다. 클러스터에 10개 노드가 있는 경우에는 **gateway.recover\_after\_nodes** 특성에 대한 값 8이 합리적인 설정입니다.
* **gateway.expected\_nodes** 특성은 클러스터에 있을 것으로 예상되는 노드 수로 설정해야 합니다. 이 예에서 **gateway.expected_nodes** 특성의 값은 10입니다.
* 마스터 노드의 시작 이후 설정된 시간이 경과할 때까지 마스터가 재밸런싱된 지시사항 전송을 대기하도록 지시하려면 **gateway.recover\_after\_time** 특성을 설정해야 합니다.

이전 설정의 조합은 Elasticsearch가 **gateway.recover\_after\_nodes** 노드의 값이 존재할 때까지 대기함을 의미합니다. 그런 다음 **gateway.recover\_after\_time**분 경과 후 또는 **gateway.expected\_nodes**개 노드가 클러스터에 참여한 후(둘 중 빠른 것 적용) 복구를 시작합니다.

### 수행하지 않을 작업
{: #what-not-to-do }
* 프로덕션 클러스터를 무시하지 마십시오.
    * 클러스터를 모니터링하고 육성해야 합니다. 태스크 전용인 많은 우수한 Elasticsearch 모니터링 도구를 사용할 수 있습니다.
* **datapath** 설정에 NAS(Network-Attached Storage)를 사용하지 마십시오. NAS는 대기 시간을 늘리고 단일 실패 지점을 도입합니다. 항상 로컬 호스트 디스크를 사용하십시오.
* 여러 데이터 센터에 분포한 클러스터와 지리적으로 넓은 지역에 분포한 클러스터는 피하십시오. 노드 간 대기 시간으로 인해 심각한 성능 병목 현상이 발생합니다.
* 자체 클러스터 구성 관리 솔루션은 개발하지 마십시오. Puppet, Chef 및 Ansible 등의 많은 우수한 구성 관리 솔루션을 사용할 수 있습니다.

## 구성 특성
{: #configuration-properties }
{{ site.data.keys.mf_analytics_server }}는 추가 구성 없이 시작될 수 있습니다.

{{ site.data.keys.mf_server }}와 {{ site.data.keys.mf_analytics_server }} 모두에서 JNDI 특성을 통해 구성이 완료됩니다. 또한 {{ site.data.keys.mf_analytics_server }}는 구성 제어에 환경 변수 사용을 지원합니다. 환경 변수는 JNDI 특성보다 우선합니다.

이 특성의 변경사항을 적용하려면 Analytics 런타임 웹 애플리케이션을 다시 시작해야 합니다. 전체 애플리케이션 서버를 다시 시작할 필요는 없습니다.

WebSphere Application Server Liberty에서 JNDI 특성을 설정하려면 다음과 같이 **server.xml** 파일에 태그를 추가하십시오.

```xml
<jndiEntry jndiName="{PROPERTY NAME}" value="{PROPERTY VALUE}}" />
```

Tomcat에서 JNDI 특성을 설정하려면 다음과 같이 context.xml 파일에 태그를 추가하십시오.

```xml
<Environment name="{PROPERTY NAME}" value="{PROPERTY VALUE}" type="java.lang.String" override="false" />
```

WebSphere Application Server의 JNDI 특성은 환경 변수로 사용할 수 있습니다.

* WebSphere Application Server 콘솔에서 **애플리케이션 → 애플리케이션 유형 → WebSphere 엔터프라이즈 애플리케이션**을 선택하십시오.
* **{{ site.data.keys.product_adj }} 관리 서비스** 애플리케이션을 선택하십시오.
* **웹 모듈 특성**에서 **웹 모듈용 환경 항목**을 클릭하여 JNDI 특성을 표시하십시오.

#### {{ site.data.keys.mf_server }}
{: #mobilefirst-server }
다음 테이블에서는 {{ site.data.keys.mf_server }}에서 설정할 수 있는 특성을 보여줍니다.

| 특성                           | 설명                                           | 기본값 |
|------------------------------------|-------------------------------------------------------|---------------|
| mfp.analytics.console.url          | 이 특성을 {{ site.data.keys.mf_analytics_console }}의 URL로 설정하십시오. 예를 들어, http://hostname:port/analytics/console입니다. 이 특성을 설정하면 {{ site.data.keys.mf_console }}에서 분석 아이콘을 사용할 수 있습니다. | 없음 |
| mfp.analytics.logs.forward         | 이 특성이 true로 설정되면 {{ site.data.keys.mf_server }}에서 기록되는 서버 로그가 {{ site.data.keys.mf_analytics }}에서 캡처됩니다. | true |
| mfp.analytics.url                  |필수입니다. 수신 분석 데이터를 수신하는 {{ site.data.keys.mf_analytics_server }}에 의해 노출되는 URL입니다. 예를 들어, http://hostname:port/analytics-service/rest/v2입니다. | 없음 |
| analyticsconsole/mfp.analytics.url |	선택사항. Analytics REST 서비스의 전체 URI입니다. 방화벽 또는 안전한 리버스 프록시가 있는 시나리오에서는 이 URI가 로컬 LAN 내의 내부 URI가 아닌 외부 URI여야 합니다. 이 값은 URI 프로토콜, 호스트 이름 또는 포트 대신 *를 포함하여 수신 URL의 해당 파트를 나타낼 수 있습니다.	*://*:*/analytics-service(프로토콜, 호스트 이름 및 포트가 동적으로 판별됨) |
| mfp.analytics.username             | 데이터 시작점이 기본 인증으로 보호되는 경우 사용되는 사용자 이름입니다. | 없음 |
| mfp.analytics.password             | 데이터 시작점이 기본 인증으로 보호되는 경우 사용되는 비밀번호입니다. | 없음 |

#### {{ site.data.keys.mf_analytics_server }}
{: #mobilefirst-analytics-server }
다음 테이블에서는 {{ site.data.keys.mf_analytics_server }}에서 설정할 수 있는 특성을 보여줍니다.

| 특성                           | 설명                                           | 기본값 |
|------------------------------------|-------------------------------------------------------|---------------|
| analytics/nodetype | Elasticsearch 노드 유형을 정의합니다. 올바른 값은 master 및 data입니다. 이 특성이 설정되지 않은 경우에는 노드가 마스터 적격 노드와 데이터 노드의 역할을 모두 수행합니다. | 	없음 |
| analytics/shards | 색인당 샤드 수입니다. 이 값은 클러스터에서 시작되는 첫 번째 노드에서만 설정할 수 있으며 변경할 수 없습니다. | 1 |
| analytics/replicas_per_shard | 클러스터 내 각 샤드의 복제본 수입니다. 이 값은 실행 중인 클러스터에서 동적으로 변경될 수 있습니다. | 0 |
| analytics/masternodes | 마스터 적격 노드의 호스트 이름 및 포트가 포함된 쉼표로 구분된 문자열입니다. | 없음 |
| analytics/clustername | 클러스터의 이름입니다. 동일한 서브세트에서 작동하는 여러 클러스터를 보유할 계획이고 이들 클러스터를 고유하게 식별해야 하는 경우 이 값을 설정하십시오. | worklight |
| analytics/nodename | 클러스터 내 노드의 이름입니다. | 무작위로 생성되는 문자열
| analytics/datapath | 파일 시스템에서 분석 데이터가 저장되는 경로입니다. | ./analyticsData |
| analytics/settingspath | Elasticsearch 설정 파일의 경로입니다. 자세한 정보는 Elasticsearch를 참조하십시오. | 없음 |
| analytics/transportport | 노드 간 통신에 사용되는 포트입니다. | 9600 |
| analytics/httpport | Elasticsearch에 대한 HTTP 통신에 사용되는 포트입니다. | 9500 |
| analytics/http.enabled | Elasticsearch에 대한 HTTP 통신을 사용 또는 사용 안함으로 설정합니다. | false |
| analytics/serviceProxyURL | 분석 UI WAR 파일 및 분석 서비스 WAR 파일은 별도의 애플리케이션 서버에 설치될 수 있습니다. 이를 수행하도록 선택하는 경우에는 UI WAR 파일의 JavaScript 런타임이 브라우저의 XSS(Cross-site scripting) 차단에 의해 차단될 수 있음을 숙지해야 합니다. 이 차단을 무시하기 위해 JavaScript 런타임이 원래 서버에서 REST API 응답을 검색하도록 UI WAR 파일에 Java 프록시 코드가 포함됩니다. 하지만 프록시는 REST API 요청을 분석 서비스 WAR 파일에 전달하도록 구성됩니다. WAR 파일을 별도의 애플리케이션 서버에 설치한 경우 이 특성을 구성하십시오. | 없음 |
| analytics/bootstrap.mlockall | 이 특성은 Elasticsearch 메모리가 디스크로 스왑되지 않도록 방지합니다. | true |
| analytics/multicast | 멀티캐스트 노드 발견을 사용 또는 사용 안함으로 설정합니다. | false |
| analytics/warmupFrequencyInSeconds | 준비 조회가 실행되는 빈도입니다. 준비 조회는 백그라운드에서 실행되어 조회 결과를 메모리에 강제 상주시켜 웹 콘솔 성능을 향상시킵니다. 음수 값은 준비 조회를 사용 안함으로 설정합니다. | 600 |
| analytics/tenant | 기본 Elasticsearch 색인의 이름입니다.	worklight |

키에 점이 포함되어 있지 않은 모든 경우(**http.enabled**가 아니라 **httpport**) 변수 이름에 **ANALYTICS_** 접두부가 있는 시스템 환경 변수를 통해 설정을 제어할 수 있습니다. JNDI 특성과 시스템 환경 변수가 모두 설정된 경우에는 시스템 환경 변수가 우선합니다. 예를 들어, **analytics/httpport** JNDI 특성과 **ANALTYICS_httpport** 시스템 환경 변수가 모두 설정된 경우에는 **ANALYTICS_httpport**의 값이 사용됩니다.

> **중요**: 현재, MobileFirst Analytics v8.0은 다중 테넌시를 지원하지 않습니다. MobileFirst Server의 이벤트는 기본적으로 단일 테넌트 아키텍처에 전송됩니다. 

#### 문서 TTL(Time to Live)
{: #document-time-to-live-ttl }
TTL은 효과적으로 데이터 보존 정책을 설정하고 유지보수할 수 있는 방법입니다. 사용자의 의사결정은 시스템 자원 요구에 극적인 결과를 가져옵니다. 데이터를 오래 보존할수록 더 많은 RAM, 디스크 및 스케일링이 필요할 수 있습니다.

각 문서 유형에는 자체 TTL이 있습니다. 문서의 TTL을 설정하면 문서가 지정된 시간 동안 저장된 후 자동으로 삭제될 수 있습니다.

각 TTL JNDI 특성의 이름은 **analytics/TTL_[document-type]**으로 지정됩니다. 예를 들어, **NetworkTransaction**의 TTL 설정은 **analytics/TTL_NetworkTransaction**으로 이름 지정됩니다.

다음과 같은 기본 시간 단위를 사용하여 이 값을 설정할 수 있습니다.

* 1Y = 1년
* 1M = 1개월
* 1w = 1주
* 1d = 1일
* 1h = 1시간
* 1m = 1분
* 1s = 1초
* 1ms = 1밀리초

지원되는 문서 유형의 목록은 다음과 같습니다.

* TTL_PushNotification
* TTL_PushSubscriptionSummarizedHourly
* TTL_ServerLog
* TTL_AppLog
* TTL_NetworkTransaction
* TTL_AppSession
* TTL_AppSessionSummarizedHourly
* TTL_NetworkTransactionSummarizedHourly
* TTL_CustomData
* TTL_AppPushAction
* TTL_AppPushActionSummarizedHourly
* TTL_PushSubscription


> **참고:** 이전 {{ site.data.keys.mf_analytics_server }} 버전에서 마이그레이션하는 경우 TTL JNDI 특성을 이전에 구성했으면 [이전 {{ site.data.keys.mf_analytics_server }} 버전에서 사용하는 서버 특성 마이그레이션](../installation/#migration-of-server-properties-used-by-previous-versions-of-mobilefirst-analytics-server)을 참조하십시오.

#### Elasticsearch
{: #elasticsearch }
{{ site.data.keys.mf_analytics_console }}을 제공하는 기본 스토리지 및 클러스터링 기술이 Elasticsearch입니다.  
Elasticsearch는 일반적으로 성능 튜닝을 위한 여러 튜닝 가능 특성을 제공합니다. 많은 JNDI 특성은 Elasticsearch에서 제공하는 특성을 발췌한 것입니다.

또한 특성 이름 앞에 **analytics/**가 추가된 JNDI 특성을 사용하여 Elasticsearch에서 제공하는 모든 특성을 설정할 수 있습니다. 예를 들어, **threadpool.search.queue_size**는 Elasticsearch에서 제공하는 특성입니다. 이는 다음 JNDI 특성을 사용하여 설정될 수 있습니다.

```xml
<jndiEntry jndiName="analytics/threadpool.search.queue_size" value="100" />
```

이 특성은 일반적으로 사용자 정의 설정 파일에서 설정됩니다. Elasticsearch 및 해당 특성 파일의 형식에 익숙한 경우 다음과 같이 **settingspath** JNDI 특성을 사용하여 설정 파일의 경로를 지정할 수 있습니다.

```xml
<jndiEntry jndiName="analytics/settingspath" value="/home/system/elasticsearch.yml" />
```

숙련된 Elasticsearch IT 관리자가 아니거나 특정 필요성을 식별하지 않았거나 서비스 또는 지원 팀의 지시를 받은 경우가 아니면 이 설정을 조정하지 마십시오.

## Analytics 데이터 백업
{: #backing-up-analytics-data }
{{ site.data.keys.mf_analytics }} 데이터를 백업하는 방법에 대해 학습하십시오.

{{ site.data.keys.mf_analytics }}에 대한 데이터는 {{ site.data.keys.mf_analytics_server }} 파일 시스템에 파일 세트로 저장됩니다. 이 폴더의 위치는 {{ site.data.keys.mf_analytics_server }} 구성의 datapath JNDI 특성에 의해 지정됩니다. JNDI 특성에 대한 자세한 정보는 [구성 특성](#configuration-properties)을 참조하십시오.

{{ site.data.keys.mf_analytics_server }} 구성도 파일 시스템에 저장되며 이름은 server.xml입니다.

이미 수행한 적이 있는 기존 서버 백업 프로시저를 사용하여 이 파일을 백업할 수 있습니다. 이 파일을 백업할 때는 {{ site.data.keys.mf_analytics_server }}가 중지되었는지 확인하는 것 외에는 특별한 프로시저가 필요하지 않습니다. 해당 서버가 중지되지 않은 경우에는 백업을 수행하는 중에 데이터가 변경되어 메모리에 저장된 데이터가 아직 파일 시스템에 기록되지 않았을 수 있습니다. 데이터 불일치를 방지하려면 백업을 시작하기 전에 {{ site.data.keys.mf_analytics_server }}를 중지하십시오.

## 클러스터 관리 및 Elasticsearch
{: #cluster-management-and-elasticsearch }
클러스터를 관리하고 노드를 추가하여 메모리 및 용량 부담을 완화하십시오.

### 클러스터에 노드 추가
{: #add-a-node-to-the-cluster }
{{ site.data.keys.mf_analytics_server }}를 설치하거나 독립형 Elasticsearch 인스턴스를 실행하여 새 노드를 클러스터에 추가할 수 있습니다.

독립형 Elasticsearch 인스턴스를 선택하는 경우 메모리 및 용량 요구사항에 대한 클러스터 부담은 일부 완화되지만 데이터 수집 부담은 완화되지 않습니다. 데이터 보고서는 지속적 저장소로 이동하기 전에 데이터 무결성 및 데이터 최적화를 유지하기 위해 항상 {{ site.data.keys.mf_analytics_server }}를 통해 이동해야 합니다.

이러한 방법을 혼합해서 함께 사용할 수 있습니다.

기본 Elasticsearch 데이터 저장소에서는 노드가 동종 노드일 것으로 예상하므로 클러스터의 쓰고 남은 노트북과 강력한 8-코어 64GB RAM 랙 시스템은 함께 사용하지 마십시오. 노드 사이에서는 비슷한 하드웨어를 사용하십시오.

#### 클러스터에 {{ site.data.keys.mf_analytics_server }} 추가
{: #adding-a-mobilefirst-analytics-server-to-the-cluster }
클러스터에 {{ site.data.keys.mf_analytics_server }}를 추가하는 방법에 대해 학습하십시오.

Elasticsearch는 {{ site.data.keys.mf_analytics_server }}에 임베드되어 있으므로 Elasticsearch 설정을 사용하여 클러스터 동작을 정의하십시오. 예를 들어 WebSphere Application Server Liberty 팜을 작성하거나 다른 애플리케이션 서버 설정을 사용하지 마십시오.

다음 샘플 지시사항에서는 노드를 마스터 노드 또는 데이터 노드로 구성하지 마십시오. 대신 Elasticsearch REST API가 모니터링 및 동적 구성을 위해 노출되도록 임시로 작동할 "검색 로드 밸런서"로 노드를 구성하십시오.

**참고:**

* [시스템 요구사항](../installation/#system-requirements)에 따라 이 노드의 하드웨어 및 운영 체제를 구성하는 것을 기억하십시오.
* 포트 9600은 Elasticsearch에서 사용하는 전송 포트입니다. 따라서 클러스터 노드 간 모든 방화벽에서 포트 9600이 열려 있어야 합니다.

1. 새로 할당된 시스템의 애플리케이션 서버에 분석 서비스 WAR 파일 및 분석 UI WAR 파일(UI를 원하는 경우)을 설치하십시오. 이 {{ site.data.keys.mf_analytics_server }}의 인스턴스를 지원되는 앱 서버에 설치하십시오.
    * [WebSphere Application Server Liberty에 {{ site.data.keys.mf_analytics }} 설치](../installation/#installing-mobilefirst-analytics-on-websphere-application-server-liberty)
    * [Tomcat에 {{ site.data.keys.mf_analytics }} 설치](../installation/#installing-mobilefirst-analytics-on-tomcat)
    * [WebSphere Application Server에 {{ site.data.keys.mf_analytics }} 설치](../installation/#installing-mobilefirst-analytics-on-websphere-application-server)

2. JNDI 특성에 대한 애플리케이션 서버의 구성 파일을 편집(또는 시스템 환경 변수를 사용)하여 최소한 다음과 같은 플래그를 구성하십시오.

    | 플래그 | 값(예) | 기본값 | 참고 |
    |------|-----------------|---------|------|
    | cluster.name | 	worklight	 | worklight | 	이 노드가 참여할 클러스터입니다. |
    | discovery.zen.ping.multicast.enabled | 	false | 	true | 	실수로 클러스터에 참여하는 것을 방지하려면 false로 설정하십시오. |
    | discovery.zen.ping.unicast.hosts | 	["9.8.7.6:9600"] | 	없음 | 	기존 클러스터의 마스터 노드 목록입니다. 마스터 노드에서 전송 포트 설정을 지정한 경우 기본 포트인 9600을 변경하십시오. |
    | node.master | 	false | 	true | 	이 노드를 마스터로 허용하지 마십시오. |
    | node.data|	false | 	true | 	이 노드가 데이터를 저장하도록 허용하지 마십시오. |
    | http.enabled | 	true	 | true | 	Elasticsearch REST API에 대해 비보안 HTTP 포트 9200을 여십시오. |

3. 프로덕션 시나리오의 모든 구성 플래그를 고려하십시오. Elasticsearch에서 해당 데이터가 아닌 다른 파일 시스템 디렉토리에서 플러그인을 보관하길 원하므로 **path.plugins** 플래그를 설정해야 합니다.
4. 필요한 경우 애플리케이션 서버를 실행하고 WAR 애플리케이션을 시작하십시오.
5. 새 노드의 콘솔 출력을 확인하거나 {{ site.data.keys.mf_analytics_console }}에 있는 **관리** 페이지의 **클러스터 및 노드** 섹션에서 노드 개수를 관찰하여 이 새 노드가 클러스터에 참여했음을 확인하십시오.

#### 클러스터에 독립형 Elasticsearch 노드 추가
{: #adding-a-stand-alone-elasticsearch-node-to-the-cluster }
클러스터에 독립형 Elasticsearch 노드를 추가하는 방법에 대해 학습하십시오.

몇 가지 간단한 단계를 통해 독립형 Elasticsearch 노드를 기존 {{ site.data.keys.mf_analytics }} 클러스터에 추가할 수 있습니다. 하지만 이 노드의 역할을 결정해야 합니다. 마스터 적격 노드로 설정하시겠습니까? 그렇다면 분할뇌 문제를 방지해야 합니다. 데이터 노드로 설정하시겠습니까? 클라이언트 전용 노드로 설정하시겠습니까? 실행 중인 클러스터에 동적 구성 변경사항이 영향을 미치도록 Elasticsearch의 REST API를 직접 노출하기 위해 임시로 노드를 시작할 수 있도록 클라이언트 전용 노드를 원할 수 있습니다.

다음 샘플 지시사항에서는 노드를 마스터 노드 또는 데이터 노드로 구성하지 마십시오. 대신 Elasticsearch REST API가 모니터링 및 동적 구성을 위해 노출되도록 임시로 작동할 "검색 로드 밸런서"로 노드를 구성하십시오.

**참고:**

* [시스템 요구사항](../installation/#system-requirements)에 따라 이 노드의 하드웨어 및 운영 체제를 구성하는 것을 기억하십시오.
* 포트 9600은 Elasticsearch에서 사용하는 전송 포트입니다. 따라서 클러스터 노드 간 모든 방화벽에서 포트 9600이 열려 있어야 합니다.

1. [https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.7.5.tar.gz](https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.7.5.tar.gz)에서 Elasticsearch를 다운로드하십시오.
2. 파일의 압축을 푸십시오.
3. **config/elasticsearch.yml** 파일을 편집하고 최소한 다음과 같은 플래그를 구성하십시오.

    | 플래그 | 값(예) | 기본값 | 참고 |
    |------|-----------------|---------|------|
    | cluster.name | 	worklight	 | worklight | 	이 노드가 참여할 클러스터입니다. |
    | discovery.zen.ping.multicast.enabled | 	false | 	true | 	실수로 클러스터에 참여하는 것을 방지하려면 false로 설정하십시오. |
    | discovery.zen.ping.unicast.hosts | 	["9.8.7.6:9600"] | 	없음 | 	기존 클러스터의 마스터 노드 목록입니다. 마스터 노드에서 전송 포트 설정을 지정한 경우 기본 포트인 9600을 변경하십시오. |
    | node.master | 	false | 	true | 	이 노드를 마스터로 허용하지 마십시오. |
    | node.data|	false | 	true | 	이 노드가 데이터를 저장하도록 허용하지 마십시오. |
    | http.enabled | 	true	 | true | 	Elasticsearch REST API에 대해 비보안 HTTP 포트 9200을 여십시오. |


4. 프로덕션 시나리오의 모든 구성 플래그를 고려하십시오. Elasticsearch에서 해당 데이터가 아닌 다른 파일 시스템 디렉토리에서 플러그인을 보관하길 원하므로 path.plugins 플래그를 설정해야 합니다.
5. `./bin/plugin -i elasticsearch/elasticsearch-analytics-icu/2.7.0`을 실행하여 ICU 플러그인을 설치하십시오.
6. `./bin/elasticsearch`를 실행하십시오.
7. 새 노드의 콘솔 출력을 확인하거나 {{ site.data.keys.mf_analytics_console }}에 있는 **관리** 페이지의 **클러스터 및 노드** 섹션에서 노드 개수를 관찰하여 이 새 노드가 클러스터에 참여했음을 확인하십시오.

#### 회로 차단기
{: #circuit-breakers }
Elasticsearch 회로 차단기에 대해 학습하십시오.

Elasticsearch에는 조작으로 인해 **OutOfMemoryError**가 발생하는 것을 방지하는 데 사용되는 여러 회로 차단기가 포함되어 있습니다. 예를 들어, {{ site.data.keys.mf_console }}에 데이터를 제공하는 조회를 수행하면 JVM 힙의 40%가 사용되고 회로 차단기가 트리거되고 예외가 발생하고 콘솔이 비어 있는 데이터를 수신합니다.

또한 Elasticsearch에는 디스크가 가득 차는 것을 방지하는 기능이 있습니다. Elasticsearch 데이터 저장소가 데이터를 기록하도록 구성되어 있는 디스크 용량의 90%가 차면 Elasticsearch 노드는 클러스터에 있는 마스터 노드에 이를 알립니다. 그러면 마스터 노드는 새 문서 쓰기의 경로가 거의 가득 차 있는 노드에서 벗어나도록 재지정합니다. 클러스터에 하나의 노드만 있는 경우에는 데이터를 기록할 수 있는 보조 노드가 없습니다. 따라서 데이터가 기록되지 않고 유실됩니다.
