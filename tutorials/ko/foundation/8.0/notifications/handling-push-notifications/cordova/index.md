---
layout: tutorial
title: Cordova에서 푸시 알림 처리
breadcrumb_title: Cordova
relevantTo: [cordova]
downloads:
  - name: Download Cordova project
    url: https://github.com/MobileFirst-Platform-Developer-Center/PushNotificationsCordova/tree/release80
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
iOS, Android 및 Windows Cordova 애플리케이션이 푸시 알림을 수신하고 표시할 수 있으려면 먼저 **cordova-plugin-mfp-push** Cordova 플러그인을 Cordova 프로젝트에 추가해야 합니다. 애플리케이션이 구성되고 나면 디바이스를 등록 및 등록 취소하고 태그를 등록 및 등록 취소하고 알림을 처리하기 위해 {{ site.data.keys.product_adj }} 제공 알림 API를 사용할 수 있습니다. 이 학습서에서는 Cordova 애플리케이션에서 푸시 알림을 처리하는 방법에 대해 학습합니다.

> **참고:** 결함으로 인해 Cordova 애플리케이션에서는 인증된 알림이 현재 **지원되지 않습니다**. 하지만 `WLAuthorizationManager.obtainAccessToken("push.mobileclient").then( ... );`으로 각각의 `MFPPush` API 호출을 랩핑할 수 있는 임시 해결책이 제공됩니다. 제공된 샘플 애플리케이션에서는 이 임시 해결책을 사용합니다.

iOS의 자동 또는 대화식 알림에 대한 정보는 다음을 참조하십시오.

* [자동 알림](../silent)
* [대화식 알림](../interactive)

**전제조건:**

* 다음과 같은 학습서를 읽어야 합니다.
    * [{{ site.data.keys.product_adj }} 개발 환경 설정](../../../installation-configuration/#installing-a-development-environment)
    * [Cordova 애플리케이션에 {{ site.data.keys.product }} SDK 추가](../../../application-development/sdk/cordova)
    * [푸시 알림 개요](../../)
* {{ site.data.keys.mf_server }}가 로컬로 실행되거나 {{ site.data.keys.mf_server }}가 원격으로 실행 중입니다.
* {{ site.data.keys.mf_cli }}가 개발자 워크스테이션에 설치되어 있습니다.
* Cordova CLI가 개발자 워크스테이션에 설치되어 있습니다.

#### 다음으로 이동
{: #jump-to }
* [알림 구성](#notifications-configuration)
* [알림 API](#notifications-api)
* [푸시 알림 처리](#handling-a-push-notification)
* [샘플 애플리케이션](#sample-application)

## 알림 구성
{: #notifications-configuration }
새 Cordova 프로젝트를 작성하거나 기존 프로젝트를 사용하고 지원되는 플랫폼(iOS, Android, Windows) 중 하나 이상을 추가하십시오.

> {{ site.data.keys.product_adj }} Cordova SDK가 아직 프로젝트에 없는 경우 [Cordova 애플리케이션에 {{ site.data.keys.product }} SDK 추가](../../../application-development/sdk/cordova) 학습서의 지시사항을 따르십시오.

### 푸시 플러그인 추가
{: #adding-the-push-plug-in }
1. **명령행** 창에서 Cordova 프로젝트의 루트로 이동하십시오.  

2. 다음 명령을 실행하여 푸시 플러그인을 추가하십시오.

   ```bash
   cordova plugin add cordova-plugin-mfp-push
   ```

3. 다음 명령을 실행하여 Cordova 프로젝트를 빌드하십시오.

   ```bash
   cordova build
   ```

### iOS 플랫폼
{: #ios-platform }
iOS 플랫폼의 경우 추가적인 단계가 필요합니다.  
Xcode의 **기능** 화면에서 애플리케이션에 대해 푸시 알림을 사용으로 설정하십시오.

> <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> **중요:** 애플리케이션에 대해 선택된 번들 ID는 Apple Developer 사이트에서 이전에 작성한 앱 ID와 일치해야 합니다. [푸시 알림 개요] 학습서를 참조하십시오.

![Xcode에서 기능의 위치를 보여주는 이미지](push-capability.png)

### Android 플랫폼
{: #android-platform }
Android 플랫폼의 경우 추가적인 단계가 필요합니다.  
Android Studio에서 다음 `activity`를 `application` 태그에 추가하십시오.

```xml
<activity android:name="com.ibm.mobilefirstplatform.clientsdk.android.push.api.MFPPushNotificationHandler" android:theme="@android:style/Theme.NoDisplay"/>
```

## 알림 API
{: #notifications-api }
### 클라이언트 측
{: #client-side }

|Javascript 함수 |설명 |
| --- | --- |
|[`MFPPush.initialize(success, failure)`](#initialization) |MFPPush 인스턴스를 초기화합니다. | 
|[`MFPPush.isPushSupported(success, failure)`](#is-push-supported) |디바이스가 푸시 알림을 지원하는지 확인합니다. | 
|[`MFPPush.registerDevice(options, success, failure)`](#register-device) |디바이스를 푸시 알림 서비스에 등록합니다. | 
|[`MFPPush.getTags(success, failure)`](#get-tags) |푸시 알림 서비스 인스턴스에서 사용 가능한 모든 태그를 검색합니다. | 
|[`MFPPush.subscribe(tag, success, failure)`](#subscribe) |특정 태그에 등록합니다. | 
|[`MFPPush.getSubsciptions(success, failure)`](#get-subscriptions) |디바이스가 현재 등록된 태그를 검색합니다. | 
|[`MFPPush.unsubscribe(tag, success, failure)`](#unsubscribe) |특정 태그에서 등록 취소합니다. | 
|[`MFPPush.unregisterDevice(success, failure)`](#unregister) |푸시 알림 서비스에서 디바이스를 등록 취소합니다. | 

### API 구현
{: #api-implementation }
#### 초기화
{: #initialization }
**MFPPush** 인스턴스를 초기화합니다.

- 클라이언트 애플리케이션이 올바른 애플리케이션 컨텍스트를 사용하여 MFPPush 서비스에 연결하기 위해 필요합니다.  
- 다른 MFPPush API를 사용하기 전에 먼저 API 메소드를 호출해야 합니다.
- 수신된 푸시 알림을 처리하도록 콜백 함수를 등록합니다.

```javascript
MFPPush.initialize (
    function(successResponse) {
        alert("Successfully intialized");
        MFPPush.registerNotificationsCallback(notificationReceived);
    },
    function(failureResponse) {
        alert("Failed to initialize");
    }
);
```

#### 푸시가 지원되는지 여부
{: #is-push-supported }
디바이스가 푸시 알림을 지원하는지 확인합니다.

```javascript
MFPPush.isPushSupported (
    function(successResponse) {
        alert("Push Supported: " + successResponse);
    },
    function(failureResponse) {
        alert("Failed to get push support status");
    }
);
```

#### 디바이스 등록
{: #register-device }
디바이스를 푸시 알림 서비스에 등록합니다. 옵션이 필요하지 않은 경우 options를 `null`로 설정할 수 있습니다.


```javascript
var options = { };
MFPPush.registerDevice(
    options,
    function(successResponse) {
        alert("Successfully registered");
    },
    function(failureResponse) {
        alert("Failed to register");
    }
);
```

#### 태그 가져오기
{: #get-tags }
푸시 알림 서비스에서 사용 가능한 모든 태그를 검색합니다.

```javascript
MFPPush.getTags (
    function(tags) {
        alert(JSON.stringify(tags));
},
    function() {
        alert("Failed to get tags");
    }
);
```

#### 등록
{: #subscribe }
원하는 태그에 등록합니다.

```javascript
var tags = ['sample-tag1','sample-tag2'];

MFPPush.subscribe(
    tags,
    function(tags) {
        alert("Subscribed successfully");
    },
    function() {
        alert("Failed to subscribe");
    }
);
```

#### 등록 가져오기
{: #get-subscriptions }
디바이스가 현재 등록된 태그를 검색합니다.

```javascript
MFPPush.getSubscriptions (
    function(subscriptions) {
        alert(JSON.stringify(subscriptions));
    },
    function() {
        alert("Failed to get subscriptions");
    }
);
```

#### 등록 취소
{: #unsubscribe }
태그에서 등록 취소합니다.

```javascript
var tags = ['sample-tag1','sample-tag2'];

MFPPush.unsubscribe(
    tags,
    function(tags) {
        alert("Unsubscribed successfully");
    },
    function() {
        alert("Failed to unsubscribe");
    }
);
```

#### 등록 취소
{: #unregister }
푸시 알림 서비스 인스턴스에서 디바이스를 등록 취소합니다.

```javascript
MFPPush.unregisterDevice(
    function(successResponse) {
        alert("Unregistered successfully");
    },
    function() {
        alert("Failed to unregister");
    }
);
```

## 푸시 알림 처리
{: #handling-a-push-notification }
등록된 콜백 함수에서 해당 응답 오브젝트에 대해 조작을 수행하여 수신된 푸시 알림을 처리할 수 있습니다.

```javascript
var notificationReceived = function(message) {
    alert(JSON.stringify(message));
};
```

<img alt="샘플 애플리케이션의 이미지" src="notifications-app.png" style="float:right"/>
## 샘플 애플리케이션
{: #sample-application }
Cordova 프로젝트를 [다운로드하려면 클릭](https://github.com/MobileFirst-Platform-Developer-Center/PushNotificationsCordova/tree/release80)하십시오.

**참고:** 샘플을 실행할 Android 디바이스에 Google Play Services의 최신 버전이 설치되어 있어야 합니다.

### 샘플 사용법
{: #sample-usage }
샘플의 README.md 파일에 있는 지시사항을 따르십시오.
