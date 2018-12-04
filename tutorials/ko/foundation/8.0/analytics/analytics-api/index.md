---
layout: tutorial
title: 클라이언트 애플리케이션에서 Analytics API 사용
breadcrumb_title: Analytics API
relevantTo: [ios,android,javascript]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }

{{ site.data.keys.mf_analytics_full }}는 사용자가 애플리케이션에 대한 Analytics 데이터 수집을 시작하는 데 도움이 되는 클라이언트 측 API를 제공합니다. 이 학습서에서는 클라이언트 애플리케이션에서 Analytics 지원을 설정하는 방법에 대한 정보를 제공하고 사용 가능한 API를 나열합니다.

#### 다음으로 이동
{: #jump-to }

* [클라이언트 측에서 Analytics 구성](#configuring-analytics-on-the-client-side)
* [Analytics 데이터 전송](#sending-analytics-data)
* [클라이언트 이벤트 사용/사용 안함](#enablingdisabling-client-event-types)
* [사용자 정의 이벤트](#custom-events)
* [사용자 추적](#tracking-users)

## 클라이언트 측에서 Analytics 구성
{: #configuring-analytics-on-the-client-side }

{{ site.data.keys.mf_analytics }}가 제공하는 사전 정의된 데이터 수집을 시작하려면 먼저 해당 라이브러리를 가져와서 Analytics 지원을 초기화해야 합니다.

### JavaScript(Cordova)
{: #javascript-cordova }

Cordova 애플리케이션에서는 설정이 필요하지 않으며 초기화가 기본 제공됩니다.  

### JavaScript(웹)
{: #javascript-web }

웹 애플리케이션에서는 Analytics JavaScript 파일을 참조해야 합니다. 먼저 {{ site.data.keys.product_adj }} 웹 SDK를 추가해야 합니다. 자세한 정보는 [웹 애플리케이션에 {{ site.data.keys.product_adj }} SDK 추가](../../application-development/sdk/web) 학습서를 참조하십시오.  

{{ site.data.keys.product_adj }} 웹 SDK를 추가한 방식에 따라 다음 방법 중 하나를 진행하십시오.


`HEAD` 요소에 있는 {{ site.data.keys.mf_analytics }}를 참조하십시오.

```html
<head>
    ...
    <script type="text/javascript" src="node_modules/ibm-mfp-web-sdk/lib/analytics/ibmmfpfanalytics.js"></script>
    <script type="text/javascript" src="node_modules/ibm-mfp-web-sdk/ibmmfpf.js"></script>
</head>
```

또는 RequireJS를 사용 중인 경우 다음을 작성하십시오.

```javascript
require.config({
	'paths': {
		'ibmmfpfanalytics': 'node_modules/ibm-mfp-web-sdk/lib/analytics/ibmmfpfanalytics',
		'mfp': 'node_modules/ibm-mfp-web-sdk/ibmmfpf'
	}
});

require(['ibmmfpfanalytics','mfp'], function(ibmmfpfanalytics, WL) {
    // application logic.
});
```

"ibmmfpfanalytics"를 대체할 자체 네임스페이스를 선택할 수 있습니다.


```javascript
ibmmfpfanalytics.logger.config({analyticsCapture: true});
```

 **중요**: Cordova와 웹 SDK 사이에는 일부 JavaScript API 차이가 존재합니다. 사용자 문서에서 [API 참조서 주제](../../api/)를 참조하십시오.

### iOS
{: #ios }

#### WLAnalytics 라이브러리 가져오기
{: #importing-the-wlanalytics-library }

**Objective-C**

```objc
import "WLAnalytics.h"
```

**Swift**

```Swift
import IBMMobileFirstPlatformFoundation
```

#### Analytics 초기화
{: #initialize-analytics-ios }

**Objective-C**  
설정이 필요하지 않습니다. 기본적으로 미리 초기화됩니다.

**Swift**  
**WLAnalytics** 클래스의 다른 메소드를 호출하기 전에 `WLAnalytics.sharedInstance()`를 호출하십시오.

### Android
{: #android }

#### WLAnalytics 가져오기
{: #import-wlanalytics }

```java
import com.worklight.common.WLAnalytics;
```

#### Analytics 초기화
{: #initialize-analytics-android }

기본 활동의 `onCreate` 메소드 안에는 다음이 포함되어 있습니다.

```java
WLAnalytics.init(this.getApplication());
```


## 클라이언트 이벤트 유형 사용/사용 안함
{: #enablingdisabling-client-event-types }

Analytics API는 개발자에게 {{ site.data.keys.mf_analytics_console }}에서 시각화할 이벤트에 대한 Analytics 수집을 사용 및 사용 안함으로 설정할 수 있는 자유를 부여합니다.

{{ site.data.keys.mf_analytics }} API를 사용하면 다음과 같은 메트릭을 캡처할 수 있습니다.

* **라이프사이클 이벤트**: 앱 사용률, 사용 기간, 앱 충돌 비율
* **네트워크 사용**: API 호출 빈도 분석, 네트워크 성능 메트릭
* **사용자**: 제공된 사용자 ID로 식별되는 앱의 사용자
* **사용자 정의 분석**: 앱 개발자가 정의하는 사용자 정의 키/값 쌍

Analytics API의 초기화는 Cordova 앱에서도 네이티브 코드로 작성되어야 합니다.

 * 앱 사용을 캡처하려면 관련 이벤트가 발생하고 데이터를 서버에 전송하기 전에 앱 라이프사이클 이벤트 리스너를 등록해야 합니다.
 * 파일 시스템 또는 고유 언어 및 디바이스 기능을 사용하려면 API를 초기화해야 합니다. API가 고유 디바이스 기능(예: 파일 시스템)이 필요한 방식으로 사용되지만 초기화되지 않은 경우 API 호출이 실패합니다. 이 작동은 특히 Android에서 유효합니다.

**참고**: Cordova 애플리케이션을 빌드하기 위해 JavaScript Analytics API는 `LIFECYCLE` 또는 `NETWORK` 이벤트의 콜렉션을 사용 또는 사용 안함으로 설정하는 메소드를 가지고 있지 않습니다. 즉, Cordova 애플리케이션은 기본적으로 미리 사용으로 설정된 `LIFECYCLE` 및 `NETWORK` 이벤트와 함께 제공됩니다. 이러한 이벤트를 사용 안함으로 설정하려면 [클라이언트 라이프사이클 이벤트](#client-lifecycle-events) 및 [클라이언트 네트워크 이벤트](#client-lifecycle-events)를 참조하십시오.

### 클라이언트 라이프사이클 이벤트
{: #client-lifecycle-events }

Analytics SDK가 구성되고 나면 사용자의 디바이스에서 앱 세션 기록이 시작됩니다. {{ site.data.keys.mf_analytics }}에서 세션은 앱이 포그라운드에서 백그라운드로 이동할 때 기록되며, {{ site.data.keys.mf_analytics_console_short }}에서 세션을 작성합니다.

디바이스가 세션을 기록하도록 설정되고 사용자가 데이터를 전송하는 즉시 아래에 표시된 대로 데이터로 채워진 {{ site.data.keys.mf_analytics_console_short }}을 볼 수 있습니다.

![세션-차트](analytics-app-sessions.png)

{{ site.data.keys.mf_analytics_short }} API를 사용하여 앱 세션 콜렉션을 사용 또는 사용 안함으로 설정하십시오.

#### JavaScript
{: #javascript-lifecycle-events }

**웹**  
클라이언트 라이프사이클 이벤트를 사용하려면 Analytics를 초기화하십시오.

```javascript
ibmmfpfanalytics.logger.config({analyticsCapture: true});
```

**Cordova**  
라이프사이클 이벤트 캡처를 사용으로 설정하려면 Cordova 앱의 네이티브 플랫폼에서 이를 초기화해야 합니다.

* iOS 플랫폼의 경우:
	* **[Cordova 애플리케이션 루트 폴더] → platforms → ios → Classes** 폴더를 열고 **AppDelegate.m**(Objective-C) 또는 **AppDelegate.swift**(Swift) 파일을 찾으십시오.
	* 아래의 iOS 지침을 따라 `LIFECYCLE` 활동을 사용 또는 사용 안함으로 설정하십시오.
	* `cordova build` 명령을 실행하여 Cordova 프로젝트를 빌드하십시오.

* Android 플랫폼의 경우:
	* **[Cordova 애플리케이션 루트 폴더] → platforms → android → src → com → sample → [app-name] → MainActivity.java** 파일을 여십시오.
	* `onCreate` 메소드를 찾은 후 아래의 Android 지침을 따라 `LIFECYCLE` 활동을 사용 또는 사용 안함으로 설정하십시오.
	* `cordova build` 명령을 실행하여 Cordova 프로젝트를 빌드하십시오.

#### Android
{: #android-lifecycle-events }

클라이언트 라이프사이클 이벤트 로깅을 사용으로 설정하려는 경우:

```java
WLAnalytics.addDeviceEventListener(DeviceEvent.LIFECYCLE);
```

클라이언트 라이프사이클 이벤트 로깅을 사용 안함으로 설정하려는 경우:

```java
WLAnalytics.removeDeviceEventListener(DeviceEvent.LIFECYCLE);
```

#### iOS
{: #ios-lifecycle-events }

클라이언트 라이프사이클 이벤트 로깅을 사용으로 설정하려는 경우:

**Objective-C:**

```objc
[[WLAnalytics sharedInstance] addDeviceEventListener:LIFECYCLE];
```

**Swift:**

```swift
WLAnalytics.sharedInstance().addDeviceEventListener(LIFECYCLE);
```

클라이언트 라이프사이클 이벤트 로깅을 사용 안함으로 설정하려는 경우:

**Objective-C:**

```objc
[[WLAnalytics sharedInstance] removeDeviceEventListener:LIFECYCLE];
```

**Swift:**

```swift
WLAnalytics.sharedInstance().removeDeviceEventListener(LIFECYCLE);
```

### 클라이언트 네트워크 활동
{: #client-network-activities }

네트워크와 어댑터에 대한 콜렉션은 서버와 클라이언트라는 두 개의 다른 위치에서 발생합니다.

* 클라이언트는 `NETWORK` 디바이스 이벤트에서 수집을 시작할 때 라운드트립 시간 및 페이로드 크기 등의 정보를 수집합니다.

* 서버는 서버 처리 시간, 어댑터 사용, 사용된 프로시저 등의 백엔드 정보를 수집합니다.

클라이언트와 서버는 각각 고유 정보를 수집하므로 클라이언트가 차트에 데이터를 표시하도록 구성될 때까지 차트에 데이터가 표시되지 않습니다. 클라이언트를 구성하려면 `NETWORK` 디바이스 이벤트에 대한 수집을 시작한 후 이를 서버에 전송해야 합니다.

#### JavaScript
{: #javascript }

**웹**  
클라이언트 네트워크 이벤트를 사용하려면 Analytics를 초기화하십시오.

```javascript
ibmmfpfanalytics.logger.config({analyticsCapture: true});
```

**Cordova**  
네트워크 이벤트 캡처를 사용으로 설정하려면 Cordova 앱의 네이티브 플랫폼에서 이를 초기화해야 합니다.

* iOS 플랫폼의 경우:
	* **[Cordova 애플리케이션 루트 폴더] → platforms → ios → Classes** 폴더를 열고 **AppDelegate.m**(Objective-C) 또는 **AppDelegate.swift** 파일을 찾으십시오.
	* 아래의 iOS 지침을 따라 `NETWORK` 활동을 사용 또는 사용 안함으로 설정하십시오.
	* `cordova build` 명령을 실행하여 Cordova 프로젝트를 빌드하십시오.

* Android 플랫폼의 경우: 사용 안함으로 설정할 기본 활동의 하위 활동으로 이동하십시오.
	* **[Cordova 애플리케이션 루트 폴더] → platforms → ios → src → com → sample → [app-name] → MainActivity.java** 파일을 여십시오.
	* `onCreate` 메소드를 찾은 후 아래의 Android 지침을 따라 `NETWORK` 활동을 사용 또는 사용 안함으로 설정하십시오.
	* `cordova build` 명령을 실행하여 Cordova 프로젝트를 빌드하십시오.

#### iOS
{: #ios-network-activities }

클라이언트 네트워크 이벤트 로깅을 사용으로 설정하려는 경우:

**Objective-C:**

```objc
[[WLAnalytics sharedInstance] addDeviceEventListener:NETWORK];
```

**Swift:**

```swift
WLAnalytics.sharedInstance().addDeviceEventListener(NETWORK);
```

클라이언트 네트워크 이벤트 로깅을 사용 안함으로 설정하려는 경우:

**Objective-C:**

```objc
[[WLAnalytics sharedInstance] removeDeviceEventListener:NETWORK];
```

**Swift:**

```swift
WLAnalytics.sharedInstance().removeDeviceEventListener(NETWORK);
```

#### Android
{: #android-network-activities }

클라이언트 네트워크 이벤트 로깅을 사용으로 설정하려는 경우:

```java
WLAnalytics.addDeviceEventListener(DeviceEvent.NETWORK);
```

클라이언트 네트워크 이벤트 로깅을 사용 안함으로 설정하려는 경우:

```java
WLAnalytics.removeDeviceEventListener(DeviceEvent.NETWORK);
```

## 사용자 정의 이벤트
{: #custom-events }

다음 API 메소드를 사용하여 사용자 정의 이벤트를 작성하십시오.

#### JavaScript(Cordova)
{: #javascript-cordova-custom-events }

```javascript
WL.Analytics.log({"key" : 'value'});
```

#### JavaScript(웹)
{: #javascript-web-custom-events }

Web API의 경우 `addEvent` 메소드를 사용하여 사용자 정의 데이터를 전송합니다.

```javascript
ibmmfpfanalytics.addEvent({'Purchases':'radio'});
ibmmfpfanalytics.addEvent({'src':'App landing page','target':'About page'});
```

#### Android
{: #android-custom-events }

처음 두 구성을 설정한 후 다음 예와 같이 데이터 로그를 시작할 수 있습니다.

```java
JSONObject json = new JSONObject();
try {
    json.put("key", "value");
} catch (JSONException e) {
    // TODO Auto-generated catch block
    e.printStackTrace();
}

WLAnalytics.log("Message", json);
```

#### iOS
{: #ios-custom-events }

WLAnalytics를 가져오고 나면 이제 API를 사용하여 다음과 같이 사용자 정의 데이터를 수집할 수 있습니다.

**Objective-C:**

```objc
NSDictionary *inventory = @{
    @"property" : @"value",
};

[[WLAnalytics sharedInstance] log:@"Custom event" withMetadata:inventory];
[[WLAnalytics sharedInstance] send];
```

**Swift:**

```swift
let metadata: [NSObject: AnyObject] = ["foo": "bar"];  
WLAnalytics.sharedInstance().log("hello", withMetadata: metadata);
```

## 사용자 추적
{: #tracking-users }

개별 사용자를 추적하려면 `setUserContext` 메소드를 사용하십시오.

#### Cordova
{: #cordova-tracking-users }

지원되지 않습니다.

#### 웹 애플리케이션
{: #web-applications }

```javascript
ibmmfpfanalytics.setUserContext(user);
```

#### iOS
{: #ios-tracking-users }

**Objective-C**

```objc
[[WLAnalytics sharedInstance] setUserContext:@"John Doe"];
```

**Swift**

```swift
WLAnalytics.sharedInstance().setUserContext("John Doe")
```

#### Android
{: #android-tracking-users }

```java
WLAnalytics.setUserContext("John Doe");
```

개별 사용자를 추적 해제하려면 `unsetUserContext` 메소드를 사용하십시오.

#### Cordova
{: #cordova-untracking-users }

지원되지 않습니다.

#### 웹 애플리케이션
{: #web-applications-untracking-users }

{{ site.data.keys.product_adj }} 웹 SDK에는 `unsetUserContext`가 없습니다. `ibmmfpfanalytics.setUserContext(user)`에 대해 다른 호출이 작성되지 않으면 사용자 세션은 30분의 비활동 기간 후 종료됩니다.

#### iOS
{: #ios-untracking-users }

**Objective-C**

```objc
[[WLAnalytics sharedInstance] unsetUserContext];
```

**Swift**

```swift
WLAnalytics.sharedInstance().unsetUserContext
```

#### Android
{: #android-untracking-users }

```java
WLAnalytics.unsetUserContext();
```

## Analytics 데이터 전송
{: #sending-analytics-data }

Analytics 데이터 전송은 Analytics Server에서 클라이언트 측 분석을 보기 위해 중요한 단계입니다. Analytics를 위해 구성된 이벤트 유형에 대한 데이터가 수집되면 Analytics 로그가 클라이언트 디바이스의 로그 파일에 저장됩니다. 이 파일의 데이터는 Analytics API의 `send` 메소드를 사용하여 {{ site.data.keys.mf_analytics_server }}에 전송됩니다.

캡처된 로그를 주기적으로 서버에 전송하는 것을 고려해 보십시오. 정기적으로 데이터를 전송하면 {{ site.data.keys.mf_analytics_console }}에서 최신 분석 데이터를 볼 수 있습니다.

#### JavaScript(Cordova)
{: #javascript-cordova-sending-data }

Cordova 애플리케이션에서는 다음 JavaScript API 메소드를 사용하십시오.

```javascript
WL.Analytics.send();
```

#### JavaScript(웹)
{: #javascript-web-sending-data }

웹 애플리케이션에서는 선택한 네임스페이스에 따라 다음 JavaScript API 메소드를 사용하십시오.

```javascript
ibmmfpfanalytics.send();
```

#### iOS
{: #ios-sending-data }

**Objective-C**

```objc
[[WLAnalytics sharedInstance] send];
```

**Swift**

```swift
WLAnalytics.sharedInstance().send();
```

#### Android
{: #android-sending-data }

Android 애플리케이션에서는 다음 Java API 메소드를 사용하십시오.

```java
WLAnalytics.send();
```
