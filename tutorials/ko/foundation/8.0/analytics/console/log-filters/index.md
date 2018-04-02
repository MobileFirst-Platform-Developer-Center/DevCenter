---
layout: tutorial
title: 로그 필터 구성
breadcrumb_title: Log Filters
relevantTo: [ios,android,javascript]
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }

관리자는 **{{ site.data.keys.mf_console }} → [사용자의 애플리케이션] → [버전] → 로그 필터**에서 {{ site.data.keys.product_adj }} 클라이언트 SDK 로그 캡처 및 레벨을 제어할 수 있습니다.  
`로그 필터`를 통해 로그할 수 있는 필터 레벨을 작성할 수 있습니다. 로그 레벨은 글로벌로(모든 로거 인스턴스) 설정하거나 특정 패키지에 대해 설정할 수 있습니다.

<img class="gifplayer"  alt="로그 필터 작성" src="add-log-filter.png"/>

애플리케이션이 서버에서 설정되는 구성 대체를 페치하려면 정기적으로 실행되는 코드의 한 위치(예: 앱 라이프사이클 콜백)에서 `updateConfigFromServer` 메소드를 호출해야 합니다.


#### Android
{: #android }

```java
Logger.updateConfigFromServer();
```

#### iOS
{: #ios }

```objective-c
[OCLogger updateConfigFromServer];
```

#### Cordova
{: #cordova }

```javascript
WL.Logger.updateConfigFromServer();
```

#### 웹
{: #web }

```javascript
ibmmfpfanalytics.logger.updateConfigFromServer();
```

서버가 리턴하는 `Logger` 구성 값은 클라이언트 측에서 설정되는 값보다 우선합니다. 클라이언트 로그 프로파일이 제거된 후 클라이언트가 클라이언트 로그 프로파일 검색을 시도하면 클라이언트가 비어 있는 페이로드를 수신합니다. 이 경우 `Logger` 구성의 기본값은 클라이언트에서 원래 구성된 값으로 지정됩니다.

## 서버 로그 전달
{: #forwarding-server-logs }

{{ site.data.keys.mf_console }}은 서버 관리자에게 로그를 지속하고 해당 로그를 {{ site.data.keys.mf_analytics_console }}에 전송하는 기능도 제공합니다.

서버 로그를 전달하려면 런타임 **설정** 화면으로 이동한 후 **추가 패키지** 아래에서 로거 패키지를 지정하십시오.  
수집된 로그는 {{ site.data.keys.mf_analytics_console_short }}에서 볼 수 있습니다. 이는 사용자가 모든 서버 로그를 수집하지 않고도 {{ site.data.keys.mf_analytics_console_short }}에서 선별 어댑터 로그를 선별하는 데 유용합니다.
