---
layout: tutorial
title: 클라이언트 측 로그 콜렉션
breadcrumb_title: 클라이언트 측 로그 콜렉션
relevantTo: [ios,android,javascript]
weight: 7
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
로깅은 API 호출로 메시지를 기록하여 진단 및 디버깅을 용이하게 하는 소스 코드의 인스트루먼테이션입니다.
{{ site.data.keys.product_full }}에서는 이러한 용도로 사용되는 로깅 API 메소드 세트를 제공합니다. 

{{ site.data.keys.product_adj }} `Logger` API는 공통적으로 사용되는 로거 API(예: `console.log`(JavaScript), `java.util.logging`(Java) 및 `NSLog`(Objective-C))와 유사하며 분석 수집과 개발자 검사에 사용될 로그된 데이터를 지속적으로 캡처하여 {{ site.data.keys.mf_server }}에 전송하는 추가 기능을 제공합니다. `Logger` API를 사용하여 적절한 레벨에서 로그 데이터를 보고하여 로그를 검사하는 개발자가 실험실에서 문제점을 재생할 필요 없이 문제점을 선별하고 수정할 수 있게 하십시오. 

#### 가용성
{: #availability }
iOS, Android, 웹 및 Cordova 애플리케이션에 {{ site.data.keys.product_adj }} 제공 `Logger` API 메소드를 사용할 수 있습니다. 

## 로깅 레벨
{: #logging-levels }
일반적으로 로깅 라이브러리에는 보통 **레벨**로 불리는 상세도 제어가 있습니다.   
가장 높은 상세도에서 가장 낮은 상세도까지의 로깅 레벨은 다음과 같습니다. 

* TRACE - 메소드 시작점 및 종료점에 사용됨
* DEBUG - 메소드 결과 출력에 사용됨
* LOG - 클래스 인스턴스화에 사용됨
* INFO - 보고 초기화에 사용됨
* WARN - 더 이상 사용되지 않은 사용법 경고를 로그하는 데 사용됨
* ERROR - 예기치 않은 예외에 사용됨
* FATAL - 복구 불가능한 충돌 또는 정지에 사용됨

> **참고:** FATAL을 사용하면 앱 충돌을 수집합니다. 앱 충돌 데이터를 왜곡하지 않으려면 이 키워드를 사용하지 않는 것이 좋습니다.

클라이언트 SDK는 기본적으로 FATAL 상세도에서 구성되므로 출력되거나 캡처되는 원시 디버그 로그가 거의 또는 전혀 없습니다. 상세도는 프로그래밍 방식으로 조정하거나 {{ site.data.keys.mf_analytics_console }}(앱에서 명시적으로 검색해야 함)에서 구성 프로파일을 설정하여 조정할 수 있습니다. 

### 클라이언트 애플리케이션에서 로깅:
{: #logging-from-client-applications }
* [JavaScript(Cordova, 웹) 애플리케이션에서 로깅](javascript/)
* [iOS 애플리케이션에서 로깅](ios/)
* [Android 애플리케이션에서 로깅](android/)

### 로그 상세도 조정
{: #adjusting-log-verbosity }
클라이언트를 설정하거나 서버 프로파일을 검색하여 로깅 레벨을 설정하면 클라이언트는 로깅 메시지를 필터링하여 전송합니다. 임계값 미만의 메시지를 명시적으로 전송하면 클라이언트에서 무시합니다. 

예를 들어 상세도 레벨을 DEBUG로 설정하려면 다음을 수행하십시오. 

#### iOS
{: #ios}
**Objective-C**

```objc
[OCLogger setLevel:OCLogger_DEBUG];
```

**Swift**

```swift
 OCLogger.setLevel(OCLogger_DEBUG);
 ```

#### Android
{: #android }
```java
Logger.setLevel(Logger.LEVEL.DEBUG);
```

#### JavaScript(Cordova)
{: #javascript-cordova }
```javascript
WL.Logger.config({ level: 'DEBUG' });
```

#### JavaScript(웹)
{: #javascript-web }
웹 SDK의 경우 클라이언트에서 기본 추적 레벨을 변경할 수 없습니다. 

## 충돌 캡처
{: #crash-capture }
Android 및 iOS 애플리케이션의 {{ site.data.keys.product_adj }} 클라이언트 SDK는 애플리케이션 충돌 시 스택 추적을 캡처하여 FATAL 레벨로 로그합니다. 이 유형의 충돌은 사용자 보기에 UI가 표시되지 않는 true인 충돌입니다. Cordova 애플리케이션에서는 JavaScript 글로벌 오류를 캡처하고 가능한 경우 JavaScript 호출 스택도 캡처하여 FATAL 레벨로 기록합니다. 이러한 유형의 충돌은 충돌 이벤트가 아니며 런타임 시 사용자 경험에 불리한 영향을 미칠 수도 있고 그렇지 않을 수도 있습니다. 

앱이 다시 실행되면 충돌, 발견되지 않은 예외 및 글로벌 오류가 발견되고 자동으로 로그됩니다. 

## 로그 보기
{: #viewing-the-logs }
로그가 수집되고 서버로 전송되면 {{ site.data.keys.mf_analytics_console }}에 표시됩니다. 탐색줄에서 **앱** 패널을 선택하고 **클라이언트 로그 검색** 탭을 클릭하십시오. 

![로그 검색 및 보기](consoleViewClientLogs.png)
