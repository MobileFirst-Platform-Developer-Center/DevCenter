---
layout: tutorial
title: Analytics 워크플로우
breadcrumb_title: 워크플로우
relevantTo: [ios,android,javascript]
weight: 5
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }

{{ site.data.keys.mf_analytics_full }}를 사용하면 비즈니스 요구에 맞는 최적의 서비스를 제공할 수 있습니다. 목표가 정해지면 {{ site.data.keys.mf_analytics_short }} 클라이언트 SDK를 사용하여 적절한 데이터를 수집하고 {{ site.data.keys.mf_analytics_console }}을 사용하여 보고서를 빌드하십시오. 다음의 일반적인 시나리오에서는 Analytics 데이터를 수집하고 보고하는 방법을 보여줍니다. 

#### 다음으로 이동
{: #jump-to }

* [앱 사용 분석](#app-usage-analytics)
* [충돌 캡처](#crash-capture)

## 앱 사용 분석
{: #app-usage-analytics }

### 앱 사용을 캡처하기 위해 클라이언트 앱 초기화
{: #initializing-your-client-app-to-capture-app-usage }

앱 사용에서는 특정 앱을 포그라운드로 가져온 후 백그라운드로 보낸 횟수를 측정합니다. 모바일 앱에서 앱 사용을 캡처하려면 {{ site.data.keys.mf_analytics }} 클라이언트 SDK가 앱 라이프사이클 이벤트를 청취하도록 구성되어야 합니다. 

{{ site.data.keys.mf_analytics }} API를 사용하여 앱 사용을 캡처할 수 있습니다. 먼저 관련 디바이스 리스너를 작성했는지 확인하십시오. 그런 다음 데이터를 서버에 전송하십시오. 

#### iOS
{: #ios }

**AppDelegate.m/AppDeligate.swift** 파일의 애플리케이션 위임 `application:didFinishLaunchingWithOptions` 메소드에 다음 코드를 추가하십시오. 

**Objective-C**

```objc
WLAnalytics *analytics = [WLAnalytics sharedInstance];
[analytics addDeviceEventListener:LIFECYCLE];
```

 Analytics 데이터를 전송하려는 경우:

```objc
[[WLAnalytics sharedInstance] send];
```

**Swift**

```Swift
WLAnalytics.sharedInstance().addDeviceEventListener(LIFECYCLE);
```

Analytics 데이터를 전송하려는 경우:

```Swift
WLAnalytics.sharedInstance().send;
```

#### Android
{: #android }

애플리케이션 서브클래스 `onCreate` 메소드에 다음 코드를 추가하십시오. 

```Java
WLAnalytics.init(this);
WLAnalytics.addDeviceEventListener(DeviceEvent.LIFECYCLE);
```

Analytics 데이터를 전송하려는 경우:

```Java
WLAnalytics.send();
```

#### Cordova
{: #cordova }

Cordova 앱의 경우 iOS 및 Android 앱과 마찬가지로 고유 플랫폼 코드에서 리스너를 작성해야 합니다. 데이터를 서버에 전송하십시오. 

```javascript
WL.Analytics.send();
```

#### 웹 앱
{: #web-apps }

웹 앱의 경우 리스너가 필요하지 않습니다. `WLlogger` 클래스를 통해 Analytics를 사용 및 사용 안함으로 설정할 수 있습니다. 

```javascript                                    
ibmmfpfanalytics.logger.config({analyticsCapture: true});                
ibmmfpfanalytics.send();
```

### 기본 사용 및 디바이스 차트
{: #default-usage-and-devices-charts }

{{ site.data.keys.mf_analytics_console }}에 있는 앱 섹션의 **사용 및 디바이스** 페이지에는 앱 사용 관리를 지원하기 위해 다수의 기본 차트가 제공됩니다. 

#### 총 디바이스 수
{: #total-devices }

**총 디바이스 수** 차트에는 총 디바이스 수가 표시됩니다. 

#### 총 앱 세션 수
{: #total-app-sessions }

**총 앱 세션 수** 차트에는 총 앱 세션 수가 표시됩니다. 하나의 앱이 디바이스의 포그라운드로 이동할 때 하나의 앱 세션이 기록됩니다. 

#### 활성 사용자
{: #active-users }

**활성 사용자** 차트에는 다음 데이터에 대한 대화식 다중선 그래프가 표시됩니다. 

* 활성 사용자 - 표시된 시간 범위에 대한 고유 사용자 수입니다. 
* 신규 사용자 - 표시된 시간 범위에 대한 신규 사용자 수입니다. 

표시되는 기본 시간 범위는 각 시간에 대해 하나의 데이터 점이 포함된 1일입니다. 표시되는 시간 범위를 1일보다 큰 값으로 변경하는 경우에는 데이터 점이 각각의 날짜를 반영합니다. 범례에서 해당 키를 클릭하여 선의 표시 여부를 전환할 수 있습니다. 기본적으로 모든 키가 표시되며 모든 선을 표시하지 않도록 모든 키를 전환할 수는 없습니다. 

선 그래프에서 가장 정확한 데이터를 보려면 앱 코드를 통해 `setUserContext` API를 호출하여 `userID`를 제공해야 합니다. `userID` 값에 익명성을 제공하려면 먼저 값을 해시 처리해야 합니다. `userID`가 제공되지 않는 경우에는 기본적으로 디바이스의 ID가 사용됩니다. `userID`가 제공되지 않은 상태에서 여러 사용자가 하나의 디바이스를 사용하는 경우에는 디바이스의 ID가 한 명의 사용자로 계수되기 때문에 선 그래프가 정확한 데이터를 반영하지 않습니다. 

#### 앱 세션 수
{: #app-sessions }
**앱 세션 수** 차트에는 시간 경과에 따른 앱 세션 수에 대한 막대 그래프가 표시됩니다. 

#### 앱 사용
{: #app-usage }

**앱 사용** 차트에는 각 앱의 앱 세션 백분율에 대한 원형 차트가 표시됩니다. 

#### 신규 디바이스
{: #new-devices }

**신규 디바이스** 차트에는 기간 경과에 따른 신규 디바이스 수에 대한 막대 그래프가 표시됩니다. 

#### 모델 사용
{: #model-usage }

**모델 사용** 차트에는 각 디바이스 모델별 앱 세션 수 백분율에 대한 원형 차트가 표시됩니다. 

#### 운영 체제 사용
{: #operating-system-usage }
**운영 체제 사용** 차트에는 각 디바이스 운영 체제별 앱 세션 수 백분율에 대한 원형 차트가 표시됩니다. 

### 평균 세션 지속 기간에 대한 사용자 정의 차트 작성
{: #creating-acustom-chart-for-average-session-duration }

앱 세션의 지속 기간은 시각화할 가치 있는 메트릭입니다. 모든 앱에 대해 사용자는 특정 세션에서 소비하는 시간의 양을 알고 싶어 합니다. 

1. {{ site.data.keys.mf_analytics_console }} 대시보드 섹션의 **사용자 정의 차트** 페이지에서 **차트 작성**을 클릭하십시오. 
2. 차트에 제목을 지정하십시오. 
3. **이벤트 유형**에 대해 **앱 세션**을 선택하십시오. 
4. **차트 유형**에 대해 **막대 그래프**를 선택하십시오. 
5. **다음**을 클릭하십시오. 
6. **X축**에 대해 **타임라인**을 선택하십시오. 
7. **Y축**에 대해 **평균**을 선택하십시오. 
8. **특성**에 대해 **지속 기간**을 선택하십시오. 
9. **저장**을 클릭하십시오. 

## 충돌 캡처
{: #crash-capture }

{{ site.data.keys.mf_analytics }}에는 애플리케이션 충돌에 대한 데이터 및 보고서가 포함되어 있습니다. 이 데이터는 다른 라이프사이클 이벤트 데이터와 함께 자동으로 수집됩니다. 애플리케이션이 다시 작동되어 실행되면 충돌 데이터가 클라이언트에 의해 수집되어 서버에 전송됩니다. 

처리되지 않은 예외가 발생하고 이로 인해 프로그램이 복구 불가능 상태가 되면 앱 충돌이 기록됩니다. 앱이 닫히기 전에 {{ site.data.keys.mf_analytics }} SDK가 충돌 이벤트를 로그합니다. 이 데이터는 다음 로거 전송 호출과 함께 서버에 전송됩니다. 

### 충돌 데이터를 캡처하기 위해 앱 초기화
{: #initializing-your-app-to-capture-crash-data }

충돌 데이터를 수집하여 {{ site.data.keys.mf_analytics_console }} 보고서에 포함하려면 충돌 데이터를 서버에 전송해야 합니다. 

[앱 사용을 캡처하기 위해 클라이언트 앱 초기화](#initializing-your-client-app-to-capture-app-usage)에 설명된 대로 앱 라이프사이클 이벤트를 수집하는지 확인하십시오. 

충돌과 연관된 스택 추적을 가져오기 위해 앱이 다시 실행되면 클라이언트 로그를 전송해야 합니다. 타이머를 사용하면 로그를 주기적으로 전송할 수 있습니다. 

#### iOS
{: #ios-crash-data }

**Objective-C**

```objc
- (void)sendMFPAnalyticData {
  [OCLogger send];
  [[WLAnalytics sharedInstance] send];
}

// then elsewhere in the same implementation file:

[NSTimer scheduledTimerWithTimeInterval:60
  target:self
  selector:@selector(sendMFPAnalyticData)
  userInfo:nil
  repeats:YES]
```

**Swift**

```swift
overridefuncviewDidLoad() {
       super.viewDidLoad()
       WLAnalytics.sharedInstance();
       lettimer = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: #selector(sendMFPAnalyticData), userInfo: nil, repeats: true);
       timer.fire();
       // Do any additional setup after loading the view, typically from a nib.
   }

   funcsendMFPAnalyticData() {
       OCLogger.send()
       WLAnalytics.sharedInstance().send()
   }
```

#### Android
{: #android-crash-data }

```Java
Timer timer = new Timer();
timer.schedule(new TimerTask() {
  @Override
  public void run() {
    Logger.send();
    WLAnalytics.send();
  }
}, 0, 60000);
```

#### Cordova
{: #cordova-crash-data }

```Java
setInterval(function() {
  WL.Logger.send();
  WL.Analytics.send();
}, 60000)
```

#### 웹
{: #web-crash-data }

```Java
setInterval(function() {
  ibmmfpfanalytics.logger.send();
}, 60000);
```

### 앱 충돌 모니터링
{: #app-crash-monitoring }

충돌 후 앱이 다시 시작되면 충돌 로그가 {{ site.data.keys.mf_analytics_server }}에 전송됩니다. {{ site.data.keys.mf_analytics_console }}의 **대시보드** 섹션에서 앱 충돌에 대한 정보를 신속하게 확인할 수 있습니다.   
**대시보드** 섹션의 **개요** 페이지에서 **충돌** 막대 그래프에는 시간 경과에 따른 충돌의 히스토그램이 표시됩니다. 

데이터는 다음과 같은 두 가지 방식으로 표시될 수 있습니다. 

* **충돌 비율 표시**: 시간 경과에 따른 충돌 비율
* **총 충돌 수 표시**: 시간 경과에 따른 총 충돌 수

> **참고:** 충돌 차트에서는 `MfpAppSession` 문서에 대해 조회합니다. 차트에 데이터를 표시하려면 앱 사용 및 충돌을 수집하도록 앱을 인스트루먼테이션해야 합니다. `MfpAppSession` 데이터가 수집되지 않은 경우 `MfpAppLog` 문서를 조회합니다. 이 경우에는 차트에서 충돌 수는 계수할 수 있지만 앱 사용 수를 알 수 없기 때문에 충돌 비율을 계산할 수 없어서 다음과 같은 제한사항이 발생합니다. 
>
> * **충돌 비율 표시**를 선택하면 **충돌** 막대 그래프에 데이터가 표시되지 않습니다. 

### 충돌의 기본 차트
{: #default-charts-for-crashes }

{{ site.data.keys.mf_analytics_console }}에 있는 **앱** 섹션의 **충돌** 페이지에는 앱 충돌을 관리하는 데 도움이 되는 다수의 기본 차트가 제공됩니다. 

**충돌 개요** 차트에는 충돌 개요 테이블이 표시됩니다.   
**충돌** 막대 그래프에는 시간 경과에 따른 충돌의 히스토그램이 표시됩니다. 충돌 비율 또는 총 충돌 수를 기준으로 데이터를 표시할 수 있습니다. 충돌 막대 그래프도 애플리케이션 섹션의 충돌 페이지에 있습니다. 

**충돌 요약** 차트에는 정렬 가능한 충돌 요약 테이블이 표시됩니다. + 아이콘을 클릭하여 개별 충돌을 펼쳐서 충돌에 대한 자세한 내용이 포함된 **충돌 세부사항** 테이블을 볼 수 있습니다. 충돌 세부사항 테이블에서 **>** 아이콘을 클릭하여 특정 충돌 인스턴스에 대한 자세한 내용을 볼 수 있습니다. 

### 앱 충돌 문제점 해결
{: #app-crash-troubleshooting }

더 효율적인 앱 관리를 위해 {{ site.data.keys.mf_analytics_console }}의 **애플리케이션** 섹션에 있는 **충돌** 페이지를 확인할 수 있습니다. 

**충돌 개요** 테이블에는 다음과 같은 데이터 열이 표시됩니다. 

* **앱:** 앱 이름
* **충돌:** 해당 앱의 총 충돌 수
* **총 사용 수:** 사용자가 해당 앱을 열고 닫는 총 횟수
* **충돌 비율:** 사용당 충돌의 백분율

**충돌** 막대 그래프는 **대시보드** 섹션의 **개요** 페이지에 표시되는 것과 동일한 차트입니다. 

> **참고:** 두 차트 모두 `MfpAppSession` 문서에 대해 조회합니다. 차트에 데이터를 표시하려면 앱 사용 및 충돌을 수집하도록 앱을 인스트루먼테이션해야 합니다. `MfpAppSession` 데이터가 수집되지 않은 경우 `MfpAppLog` 문서를 조회합니다. 이 경우에는 차트에서 충돌 수는 계수할 수 있지만 앱 사용 수를 알 수 없기 때문에 충돌 비율을 계산할 수 없어서 다음과 같은 제한사항이 발생합니다. 
>
> * 충돌 개요 테이블에서 총 사용 수 및 충돌 비율에 대한 열이 비어 있습니다. 
> * 충돌 비율 표시를 선택하면 충돌 막대 그래프에 데이터가 표시되지 않습니다. 

**충돌 요약** 테이블은 정렬 가능하며 다음과 같은 데이터 열을 포함하고 있습니다. 

* 충돌
* 디바이스
* 마지막 충돌
* 앱
* OS
* 메시지

항목 옆의 **+** 아이콘을 클릭하여 다음과 같은 열이 포함된 **충돌 세부사항** 테이블을 표시할 수 있습니다. 

* 충돌 시간
* 앱 버전
* OS 버전
* 디바이스 모델
* 디바이스 ID
* 다운로드: 충돌을 유발한 로그를 다운로드할 링크

**충돌 세부사항** 테이블에서 항목을 펼쳐서 스택 추적을 포함한 자세한 내용을 가져올 수 있습니다. 

> **참고:** **충돌 요약** 테이블에 대한 데이터는 심각한 레벨 클라이언트 로그를 조회하여 채워집니다. 앱에서 심각한 클라이언트 로그를 수집하지 않는 경우에는 데이터를 사용할 수 없습니다. 
