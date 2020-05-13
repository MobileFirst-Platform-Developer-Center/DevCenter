---
layout: tutorial
title: MobileFirst Analytics Receiver Server 구성 안내서
breadcrumb_title: 구성 안내서
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
{{ site.data.keys.mf_analytics_receiver_server }}의 구성입니다. 

#### 다음으로 이동
{: #jump-to }

* [구성 특성](#configuration-properties)

### 특성
{: #properties }
구성 특성의 전체 목록 및 애플리케이션 서버에서 이 특성을 설정하는 방법은 [구성 특성](#configuration-properties) 절을 참조하십시오.

## 구성 특성
{: #configuration-properties }
{{ site.data.keys.mf_analytics_receiver_server }}는 다음 추가 구성으로 시작할 수 있습니다. 

이 구성은 {{ site.data.keys.mf_server }}와 {{ site.data.keys.mf_analytics_receiver_server }} 모두에서 JNDI 특성을 통해 완료됩니다. 또한 {{ site.data.keys.mf_analytics_receiver_server }}는 구성 제어에 환경 변수 사용을 지원합니다. 환경 변수는 JNDI 특성보다 우선합니다.

이 특성의 변경사항을 적용하려면 Analytics Receiver 런타임 웹 애플리케이션을 다시 시작해야 합니다. 전체 애플리케이션 서버를 다시 시작할 필요는 없습니다.

WebSphere Application Server Liberty에서 JNDI 특성을 설정하려면 다음과 같이 `server.xml` 파일에 태그를 추가하십시오.

```xml
<jndiEntry jndiName="{PROPERTY NAME}" value="{PROPERTY VALUE}}" />
```

Tomcat에서 JNDI 특성을 설정하려면 다음과 같이 `context.xml` 파일에 태그를 추가하십시오. 

```xml
<Environment name="{PROPERTY NAME}" value="{PROPERTY VALUE}" type="java.lang.String" override="false" />
```

WebSphere Application Server의 JNDI 특성은 환경 변수로 사용할 수 있습니다.

* WebSphere Application Server 콘솔에서 **애플리케이션 → 애플리케이션 유형 → WebSphere 엔터프라이즈 애플리케이션**을 선택하십시오.
* **{{ site.data.keys.product_adj }} 관리 서비스** 애플리케이션을 선택하십시오.
* **웹 모듈 특성**에서 **웹 모듈용 환경 항목**을 클릭하여 JNDI 특성을 표시하십시오.

#### {{ site.data.keys.mf_analytics_receiver_server }}
{: #mobilefirst-receiver-server }
다음 테이블에서는 {{ site.data.keys.mf_analytics_receiver_server }}에서 설정할 수 있는 특성을 보여줍니다.

| 특성                           | 설명                                           | 기본값 |
|------------------------------------|-------------------------------------------------------|---------------|
| receiver.analytics.console.url          | 이 특성을 {{ site.data.keys.mf_analytics_console }}의 URL로 설정하십시오. 예: `http://hostname:port/analytics/console`. 이 특성을 설정하면 {{ site.data.keys.mf_console }}에서 분석 아이콘을 사용할 수 있습니다. | 없음 |
| receiver.analytics.url                  | 필수입니다. 수신 분석 데이터를 수신하는 {{ site.data.keys.mf_analytics_server }}에 의해 노출되는 URL입니다. 예: `http://hostname:port/analytics-service/rest`. | 없음 |
| receiver.analytics.username             | 데이터 시작점이 기본 인증으로 보호되는 경우 사용되는 사용자 이름입니다. | 없음 |
| receiver.analytics.password             | 데이터 시작점이 기본 인증으로 보호되는 경우 사용되는 비밀번호입니다. | 없음 |
| receiver.analytics.event.qsize          | 분석 이벤트 큐 크기입니다. 샘플 JVM 힙 크기를 입력하여 주의해서 추가해야 합니다. 기본 큐 크기는 10000입니다. | 없음 |

#### {{ site.data.keys.mf_server }}
{: #mobilefirst-server }
다음 테이블에서는 {{ site.data.keys.mf_server }}에서 설정할 수 있는 특성을 보여줍니다.

| 특성                           | 설명                                           | 기본값 |
|------------------------------------|-------------------------------------------------------|---------------|
| mfp.analytics.receiver.url                  | 필수입니다. 수신 분석 데이터를 수신하여 {{ site.data.keys.mf_analytics_server }}에 전달하는 {{ site.data.keys.mf_analytics_receiver_server }}에 의한 공개 URL입니다. 예: `http://hostname:port/analytics-receiver/rest`. | 없음 |
| mfp.analytics.receiver.username             | 데이터 시작점이 기본 인증으로 보호되는 경우 사용되는 사용자 이름입니다. | 없음 |
| mfp.analytics.receiver.password             | 데이터 시작점이 기본 인증으로 보호되는 경우 사용되는 비밀번호입니다. | 없음 |
