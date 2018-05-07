---
layout: tutorial
title: Operations Console 및 Analytics Console
breadcrumb_title: Analytics Console
relevantTo: [ios,android,javascript]
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->

## 개요
클라이언트가 {{ site.data.keys.mf_analytics_server }}에 대해 작업하는 방식을 구성하고 Operations Console 및 Analytics Console을 사용하여 광범위한 보고서를 구성하고 보십시오.

## {{ site.data.keys.mf_analytics_console_full }}
{{ site.data.keys.mf_analytics_console }}에서 Analytics 보고서를 보고 구성하십시오. 경보를 관리하고 클라이언트 로그를 보십시오.

오른쪽 상단 탐색줄에 있는 **Analytics Console** 링크를 클릭하여 {{ site.data.keys.mf_console }}에서 {{ site.data.keys.mf_analytics_console_short }}을 열 수 있습니다.

![Analytics Console 단추](analytics-console-button.png)

{{ site.data.keys.mf_analytics_console_short }}로 이동하면 기본 **대시보드** 패널이 표시됩니다. 클라이언트 애플리케이션이 이미 로그 및 Analytics 데이터를 서버에 전송한 경우에는 관련 보고서가 채워져 있습니다. 탐색줄에서 **앱** 및 **인프라**를 선택할 수 있습니다.

![Analytics Console](analytics-console.png)

### 대시보드
**대시보드** 패널에서는 애플리케이션 충돌, 애플리케이션 세션 및 서버 처리 시간과 관련된 수집된 Analytics 데이터를 검토할 수 있습니다. 또한 사용자 정의 차트를 작성하고 경보를 관리할 수 있습니다.

### 앱
**앱** 패널에서는 사용 및 디바이스와 관련된 심층 Analytics 데이터(예: 총 디바이스 및 앱 세션 수, 활성 사용자, 앱 사용, 신규 디바이스, 모델 사용 및 운영 체제)와 충돌 관련 데이터를 검토할 수 있습니다. 클라이언트 로그에서 특정 앱 및 디바이스를 검색하십시오(**앱 → 클라이언트 로그 검색**).


### 인프라
**인프라** 패널에서는 세션 처리 시간, 평균 요청 크기, 서버 요청, 네트워크 요청, 어댑터 응답 시간, 프로시저 응답 시간, 크기 및 어댑터 사용과 관련된 Analytics 데이터와 알림 요청 및 중개자 등의 푸시 알림 데이터를 검토할 수 있습니다. 서버 로그도 검색할 수 있습니다.

> [Analytics 워크플로우](../workflows/) 학습서에서 자세히 학습하십시오.

> **참고:** 클라이언트/서버 로그 **검색** 및 **내보내기** 데이터 기능은 최신 Chrome 브라우저 버전에서 날짜 필터 수정 시 마우스 클릭 이벤트를 통해 조치를 호출하지 않습니다. 이 문제는 Chrome 브라우저 문제로 인해 발생하며 알려진 제한사항입니다. 이 문제는 다른 브라우저나 Chrome 브라우저 버전 *v54.0.2840.71* 이전에서는 발생하지 않습니다. 최신 Chrome 브라우저에서는 검색/내보내기 단추를 클릭하기 전에 필요한 날짜를 설정하고 페이지를 새로 고치거나 Enter/Return 키를 눌러서 선택한 조치를 실행하여 문제를 해결할 수 있습니다. 

## Analytics 기능

### 앱 Analytics
**앱 → 사용 및 디바이스** 탭에서 앱 세션 차트 및 앱 사용 차트를 보고 사용자가 가장 자주 사용하는 앱을 파악할 수 있습니다.

### 기본 제공 Analytics
{{ site.data.keys.product_adj }} 클라이언트 SDK를 {{ site.data.keys.mf_server }}와 함께 사용하는 경우 앱이 {{ site.data.keys.mf_server }}에 대해 작성하는 모든 요청에 대해 Analytics 데이터가 자동으로 수집됩니다. **대시보드 → 개요**에서 수집되어 {{ site.data.keys.mf_analytics_server }}에 보고되는 기본 디바이스 메타데이터를 보십시오.

### 사용자 정의 Analytics
앱이 사용자 정의 데이터를 전송하고 사용자 정의 데이터에 대한 사용자 정의 차트를 작성하게 할 수 있습니다.

> [Analytics API](../analytics-api/) 학습서에서 사용자 정의 Analytics 전송 방법에 대해 학습하십시오.

### 사용자 정의 차트
사용자 정의 차트를 사용하면 Analytics 데이터 저장소에서 수집된 Analytics 데이터를 {{ site.data.keys.mf_analytics_console_short }}에서 기본적으로 사용할 수 없는 차트로 시각화할 수 있습니다(**대시보드 → 사용자 정의 차트**). 이 시각화 기능은 비즈니스에 필수적인 데이터를 분석하는 강력한 방법입니다.

> [사용자 정의 차트 작성](custom-charts/) 학습서에서 사용자 정의 차트 작성 방법을 학습하십시오.

### 경보 관리
경보는 {{ site.data.keys.mf_analytics_console }}을 정기적으로 확인하지 않고도 모바일 앱의 상태를 모니터할 수 있는 사전 예방적 수단을 제공합니다.

**대시보드 → 경보 관리** 탭에서 초과한 경우 경보를 트리거하여 관리자에게 알리는 임계값을 구성할 수 있습니다. 콘솔에서 트리거된 경보를 시각화하거나 사용자 정의 웹 후크를 사용하여 해당 경보를 처리할 수 있습니다. 사용자 정의 웹 후크를 사용하면 경보가 트리거될 때 알리는 사용자 및 방법을 제어할 수 있습니다.

> [경보 관리](alerts/) 학습서에서 경보를 관리하는 방법을 학습하십시오.

### 앱 충돌 모니터
앱 충돌은 {{ site.data.keys.mf_analytics_console_short }}(**앱 → 충돌**)에서 시각화되며 여기서 충돌을 신속하게 보고 충돌에 대해 적절하게 조치를 취할 수 있습니다. *애플리케이션이 다시 실행되면* 충돌 로그가 기본적으로 디바이스에서 수집된 후 서버에 전송됩니다. 충돌 로그는 Analytics Server에 전송되면 자동으로 충돌 차트를 채웁니다.

### 서버 및 네트워크 데이터 모니터
{{ site.data.keys.mf_analytics_console_short }}은 네트워크 데이터가 Analytics Server에 전송될 때 네트워크 데이터를 모니터하며 사용자가 다양한 방식으로 이 정보를 조회할 수 있게 합니다(**인프라 → 서버 및 네트워크**).


### 클라이언트 로그 수집, 검색 및 보고
클라이언트 로그는 서버에 전송되고 Analytics 보고서에 포함될 수 있습니다.

보고서에 로깅 정보를 포함하려면 다음을 수행하십시오.

1. {{ site.data.keys.mf_analytics_console_short }}에서 **대시보드 → 사용자 정의 차트** 탭을 선택하십시오.

2. **이벤트 유형** 풀다운 메뉴에서 **클라이언트 로그**를 선택하십시오.

**사용자 정의 차트**에 대한 자세한 정보는 [사용자 정의 차트 작성](custom-charts/)을 참조하십시오.

로깅 데이터를 필터링할 수 있습니다. 로그 필터는 Analytics Server에서 구성하고 저장한 후 클라이언트 애플리케이션에 의해 검색될 수 있습니다.

로그 필터 구성에 대한 정보는 [클라이언트 로그 검색](log-filters/) 학습서를 참조하십시오.

클라이언트에서 로그를 전송하는 것에 대한 자세한 정보는 [클라이언트 로그 콜렉션](../../application-development/client-side-log-collection/)을 참조하십시오.



## {{ site.data.keys.mf_console_full }}
{{ site.data.keys.mf_console }}을 사용하여 Analytics Server를 구성하고 관리하십시오.

{{ site.data.keys.mf_analytics_console_short }}에 있는 경우 맨 위 탐색줄에 있는 **Operations Console** 단추를 클릭하여 {{ site.data.keys.mf_console }}에 액세스하십시오.

### 추가적인 로거 패키지에서 Analytics 데이터 수집
기본적으로 패키지 `com.worklight`로부터의 로깅만 Analytics에 전송됩니다. 추가적인 패키지로부터의 로깅을 추가하려면 [Analytics Server에 로그 전달](../../adapters/server-side-log-collection/java-adapter/#forwarding-logs-to-the-analytics-server)을 참조하십시오.


### Analytics 지원 사용/사용 안함
{: #enabledisable-analytics-support}

기본적으로 Analytics Server에 의한 분석 데이터 수집은 사용으로 설정됩니다. 예를 들어, 처리 시간을 줄이기 위해 이를 사용 안함으로 설정할 수 있습니다.

1. 탐색 사이드바에서 **런타임 설정**을 클릭하십시오. 실수로 변경되는 것을 방지하기 위해 런타임 특성은 읽기 전용 모드로 표시됩니다.
2. 설정을 편집 가능으로 설정하려면 **편집** 단추를 클릭하십시오. *관리자* 또는 *배치자* 이외의 역할로 로그인한 경우에는 런타임 특성 수정이 허용되지 않으므로 **편집** 단추가 표시되지 않습니다.
3. **데이터 콜렉션 사용** 드롭 다운 메뉴에서 **false**를 선택하여 데이터 콜렉션을 사용 안함으로 설정하십시오.
4. **저장**을 클릭하십시오.
5. **읽기 전용** 단추를 클릭하여 특성을 다시 잠그십시오.


![콘솔에서 Analytics 지원 사용 또는 사용 안함](enable-disable-analytics.png)


### 역할 기반 액세스 제어
{{ site.data.keys.mf_analytics_console_short }}의 컨텐츠는 사전 정의된 보안 역할에 의해 제한됩니다.  
{{ site.data.keys.mf_analytics_console_short }}은 로그인한 사용자의 보안 역할에 따라 다른 컨텐츠를 표시합니다. 다음 표에서는 보안 역할 및 {{ site.data.keys.mf_analytics_console_short }}에 대한 이들 역할의 액세스를 보여줍니다.

| 역할           | 역할 이름                | 보기 액세스                                                     | 편집 액세스  |
|----------------|--------------------------|--------------------------------------------------------------------|-----------------|
| 관리자  | analytics_administrator  | 모든 항목	                                                     | 모든 항목     |
| 인프라 | analytics_infrastructure	| 모든 항목	                                                     | 모든 항목     |
| 개발자      | analytics_developer	    | 관리 페이지를 제외한 모든 항목		             | 모든 항목     |
| 지원        | analytics_support        | 관리 페이지를 제외한 모든 항목		             | 모든 항목     |
| 비즈니스       | analytics_business       | 관리 및 인프라 페이지를 제외한 모든 항목 | 모든 항목     |

> 역할 설정에 대한 정보는 [{{ site.data.keys.mf_server }} 관리를 위해 사용자 인증 구성](../../installation-configuration/production/server-configuration#configuring-user-authentication-for-mobilefirst-server-administration)을 참조하십시오.


## 관련 블로그 포스트
* [사용자 정의 Analytics 인스트루먼테이션에 대해 알아보기]({{site.baseurl}}/blog/2016/01/22/howto-custom-in-app-behavior-analytics/)
* [웹 후크 인스트루먼테이션에 대해 알아보기]({{site.baseurl}}/blog/2015/10/19/using-mfp-adapters-endpoint-analytics-alerts-webhooks/)
