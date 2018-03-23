---
layout: tutorial
title: Windows 8.1 Universal 및 Windows 10 UWP에서 푸시 알림 처리
breadcrumb_title: Windows
relevantTo: [windows]
weight: 7
downloads:
  - name: Download Windows 8.1 Universal Project
    url: https://github.com/MobileFirst-Platform-Developer-Center/PushNotificationsWin8/tree/release80
  - name: Download Windows 10 UWP Project
    url: https://github.com/MobileFirst-Platform-Developer-Center/PushNotificationsWin10/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
디바이스를 등록 및 등록 취소하고 태그에 등록 및 등록 취소하기 위해 {{ site.data.keys.product_adj }} 제공 알림 API를 사용할 수 있습니다. 이 학습서에서는 C#을 사용하여 고유 Windows 8.1 Universal 및 Windows 10 UWP 애플리케이션에서 푸시 알림을 처리하는 방법에 대해 학습합니다.

**전제조건:**

* 다음과 같은 학습서를 읽어야 합니다.
	* [푸시 알림 개요](../../)
    * [{{ site.data.keys.product_adj }} 개발 환경 설정](../../../installation-configuration/#installing-a-development-environment)
    * [Windows 애플리케이션에 {{ site.data.keys.product_adj }} SDK 추가](../../../application-development/sdk/windows-8-10)
* {{ site.data.keys.mf_server }}가 로컬로 실행되거나 {{ site.data.keys.mf_server }}가 원격으로 실행 중입니다.
* {{ site.data.keys.mf_cli }}가 개발자 워크스테이션에 설치되어 있습니다.

#### 다음으로 이동:
{: #jump-to }
* [알림 구성](#notifications-configuration)
* [알림 API](#notifications-api)
* [푸시 알림 처리](#handling-a-push-notification)

## 알림 구성
{: #notifications-configuration }
새 Visual Studio 프로젝트를 작성하거나 기존 프로젝트를 사용하십시오.  
{{ site.data.keys.product_adj }} 고유 Windows SDK가 아직 프로젝트에 없는 경우 [Windows 애플리케이션에 {{ site.data.keys.product_adj }} SDK 추가](../../../application-development/sdk/windows-8-10) 학습서의 지시사항을 따르십시오.

### 푸시 SDK 추가
{: #adding-the-push-sdk }
1. 도구 → NuGet 패키지 관리자 → 패키지 관리자 콘솔을 선택하십시오.
2. {{ site.data.keys.product_adj }} 푸시 컴포넌트를 설치할 프로젝트를 선택하십시오.
3. **Install-Package IBM.MobileFirstPlatformFoundationPush** 명령을 실행하여 {{ site.data.keys.product_adj }} 푸시 SDK를 추가하십시오.

## 전제조건 WNS 구성
{: pre-requisite-wns-configuration }
1. 애플리케이션이 토스트 알림 기능을 가지고 있는지 확인하십시오. 이는 Package.appxmanifest에서 사용으로 설정할 수 있습니다.
2. `Package Identity Name` 및 `Publisher`가 WNS에 등록된 값으로 업데이트되어야 합니다.
3. (선택사항) TemporaryKey.pfx 파일을 삭제하십시오.

## 알림 API
{: #notifications-api }
### MFPPush 인스턴스
{: #mfppush-instance }
모든 API 호출은 `MFPPush`의 인스턴스에서 호출되어야 합니다.  이는 `private MFPPush PushClient = MFPPush.GetInstance();` 등의 변수를 작성한 후 클래스 전체에서 `PushClient.methodName()`를 호출하여 수행될 수 있습니다.

또는 푸시 API 메소드에 액세스해야 하는 각 인스턴스에 대해 `MFPPush.GetInstance().methodName()`을 호출할 수 있습니다.

### 인증 확인 핸들러
{: #challenge-handlers }
`push.mobileclient` 범위가 **보안 검사**에 맵핑되는 경우에는 푸시 API를 사용하기 전에 일치하는 **인증 확인 핸들러**가 존재하며 등록되어 있는지 확인해야 합니다.

> [신임 정보 유효성 검증](../../../authentication-and-security/credentials-validation/ios) 학습서에서 인증 확인 핸들러에 대해 자세히 학습하십시오.

### 클라이언트 측
{: #client-side }

| C# 메소드                                                                                                | 설명                                                             |
|--------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------|
| [`Initialize()`](#initialization)                                                                            | 제공된 컨텍스트에 대해 MFPPush를 초기화합니다.                               |
| [`IsPushSupported()`](#is-push-supported)                                                                    | 디바이스가 푸시 알림을 지원하는지 확인합니다.                             |
| [`RegisterDevice(JObject options)`](#register-device--send-device-token)                  | 디바이스를 푸시 알림 서비스에 등록합니다.               |
| [`GetTags()`](#get-tags)                                | 푸시 알림 서비스 인스턴스에서 사용 가능한 태그를 검색합니다. |
| [`Subscribe(String[] Tags)`](#subscribe)     | 디바이스를 지정된 태그에 등록합니다.                          |
| [`GetSubscriptions()`](#get-subscriptions)              | 디바이스가 현재 등록된 모든 태그를 검색합니다.               |
| [`Unsubscribe(String[] Tags)`](#unsubscribe) | 특정 태그에서 등록 취소합니다.                                  |
| [`UnregisterDevice()`](#unregister)                     | 푸시 알림 서비스에서 디바이스를 등록 취소합니다.              |

#### 초기화
{: #initialization }
클라이언트 애플리케이션이 MFPPush 서비스에 연결하려면 초기화가 필요합니다.

* 다른 MFPPush API를 사용하기 전에 먼저 `Initialize` 메소드를 호출해야 합니다.
* 이는 수신된 푸시 알림을 처리하도록 콜백 함수를 등록합니다.

```csharp
MFPPush.GetInstance().Initialize();
```

#### 푸시가 지원되는지 여부
{: #is-push-supported }
디바이스가 푸시 알림을 지원하는지 확인합니다.

```csharp
Boolean isSupported = MFPPush.GetInstance().IsPushSupported();

if (isSupported ) {
    // Push is supported
} else {
    // Push is not supported
}
```

#### 디바이스 등록 및 디바이스 토큰 전송
{: #register-device--send-device-token }
디바이스를 푸시 알림 서비스에 등록합니다.

```csharp
JObject Options = new JObject();
MFPPushMessageResponse Response = await MFPPush.GetInstance().RegisterDevice(Options);         
if (Response.Success == true)
{
    // Successfully registered
} else {
    // Registration failed with error
}
```

#### 태그 가져오기
{: #get-tags }
푸시 알림 서비스에서 사용 가능한 모든 태그를 검색합니다.

```csharp
MFPPushMessageResponse Response = await MFPPush.GetInstance().GetTags();
if (Response.Success == true)
{
    Message = new MessageDialog("Avalibale Tags: " + Response.ResponseJSON["tagNames"]);
} else{
    Message = new MessageDialog("Failed to get Tags list");
}
```

#### 등록
{: #subscribe }
원하는 태그에 등록합니다.

```csharp
string[] Tags = ["Tag1" , "Tag2"];

// Get subscription tag
MFPPushMessageResponse Response = await MFPPush.GetInstance().Subscribe(Tags);
if (Response.Success == true)
{
    //successfully subscribed to push tag
}
else
{
    //failed to subscribe to push tags
}
```

#### 등록 가져오기
{: #get-subscriptions }
디바이스가 현재 등록된 태그를 검색합니다.

```csharp
MFPPushMessageResponse Response = await MFPPush.GetInstance().GetSubscriptions();
if (Response.Success == true)
{
    Message = new MessageDialog("Avalibale Tags: " + Response.ResponseJSON["tagNames"]);
}
else
{
    Message = new MessageDialog("Failed to get subcription list...");
}
```

#### 등록 취소
{: #unsubscribe }
태그에서 등록 취소합니다.

```csharp
string[] Tags = ["Tag1" , "Tag2"];

// unsubscribe tag
MFPPushMessageResponse Response = await MFPPush.GetInstance().Unsubscribe(Tags);
if (Response.Success == true)
{
    //succes
}
else
{
    //failed to subscribe to tags
}
```

#### 등록 취소
{: #unregister }
푸시 알림 서비스 인스턴스에서 디바이스를 등록 취소합니다.

```csharp
MFPPushMessageResponse Response = await MFPPush.GetInstance().UnregisterDevice();         
if (Response.Success == true)
{
    // Successfully registered
} else {
    // Registration failed with error
}
```

## 푸시 알림 처리
{: #handling-a-push-notification }
푸시 알림을 처리하려면 `MFPPushNotificationListener`를 설정해야 합니다.  이는 다음 메소드를 구현하여 수행할 수 있습니다.

1. MFPPushNotificationListener 유형의 인터페이스를 사용하여 클래스를 작성하십시오.

   ```csharp
   internal class NotificationListner : MFPPushNotificationListener
   {
        public async void onReceive(String properties, String payload)
   {
        // Handle push notification here      
   }
   }
   ```

2. `MFPPush.GetInstance().listen(new NotificationListner())`를 호출하여 클래스를 리스너로 설정하십시오.
3. onReceive 메소드에서 사용자는 푸시 알림을 수신하고 원하는 작동에 대한 알림을 처리할 수 있습니다.


<img alt="샘플 애플리케이션의 이미지" src="sample-app.png" style="float:right"/>

## Windows Universal Push Notifications Service
{: #windows-universal-push-notifications-service }
서버 구성에서 특정 포트를 열지 않아도 됩니다.

WNS는 일반 http 또는 https 요청을 사용합니다.


## 샘플 애플리케이션
{: #sample-application }
Windows 8.1 Universal 프로젝트를 [다운로드하려면 클릭](https://github.com/MobileFirst-Platform-Developer-Center/PushNotificationsWin8/tree/release80)하십시오.  
Windows 10 UWP 프로젝트를 [다운로드하려면 클릭](https://github.com/MobileFirst-Platform-Developer-Center/PushNotificationsWin8/tree/release80)하십시오.

### 샘플 사용법
{: #sample-usage }
샘플의 README.md 파일에 있는 지시사항을 따르십시오.
