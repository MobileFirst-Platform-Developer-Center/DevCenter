---
layout: tutorial
title: Android에서 푸시 알림 처리
breadcrumb_title: Android
relevantTo: [android]
downloads:
  - name: Android Studio 프로젝트 다운로드
    url: https://github.com/MobileFirst-Platform-Developer-Center/PushNotificationsAndroid/tree/release80
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
Android 애플리케이션이 수신된 푸시 알림을 처리할 수 있으려면 먼저 Google Play Services에 대한 지원을 구성해야 합니다. 애플리케이션이 구성되고 나면 디바이스를 등록 및 등록 취소하고 태그에 등록 및 등록 취소하기 위해 {{ site.data.keys.product_adj }} 제공 알림 API를 사용할 수 있습니다. 이 학습서에서는 Android 애플리케이션에서 푸시 알림을 처리하는 방법에 대해 학습합니다. 

**전제조건:**

* 다음과 같은 학습서를 읽어야 합니다. 
    * [{{ site.data.keys.product_adj }} 개발 환경 설정](../../../installation-configuration/#installing-a-development-environment)
    * [Android 애플리케이션에 {{ site.data.keys.product }} SDK 추가](../../../application-development/sdk/android)
    * [푸시 알림 개요](../../)
* {{ site.data.keys.mf_server }}가 로컬로 실행되거나 {{ site.data.keys.mf_server }}가 원격으로 실행 중입니다. 
* {{ site.data.keys.mf_cli }}가 개발자 워크스테이션에 설치되어 있습니다. 

#### 다음으로 이동:
{: #jump-to }
* [알림 구성](#notifications-configuration)
* [알림 API](#notifications-api)
* [푸시 알림 처리](#handling-a-push-notification)
* [샘플 애플리케이션](#sample-application)

## 알림 구성
{: #notifications-configuration }
새 Android Studio 프로젝트를 작성하거나 기존 프로젝트를 사용하십시오.   
{{ site.data.keys.product_adj }} 고유 Android SDK가 아직 프로젝트에 없는 경우 [Android 애플리케이션에 {{ site.data.keys.product }} SDK 추가](../../../application-development/sdk/android) 학습서의 지시사항을 따르십시오. 

### 프로젝트 설정
{: #project-setup }
1. **Android → Gradle 스크립트**에서 **build.gradle (Module: app)** 파일을 선택한 후 다음 행을 `dependencies`에 추가하십시오. 

   ```bash
   com.google.android.gms:play-services-gcm:9.0.2
   ```
   - **참고:** 최신 Play Services 버전(현재는 9.2.0) 사용을 방해하는 [알려진 Google 결함](https://code.google.com/p/android/issues/detail?id=212879)이 있습니다. 낮은 버전을 사용하십시오. 

   그리고 다음 행을 추가하십시오. 

   ```xml
   compile group: 'com.ibm.mobile.foundation',
            name: 'ibmmobilefirstplatformfoundationpush',
            version: '8.0.+',
            ext: 'aar',
            transitive: true
   ```
    
   또는 단일 행으로 다음 행을 추가하십시오. 

   ```xml
   compile 'com.ibm.mobile.foundation:ibmmobilefirstplatformfoundationpush:8.0.+'
   ```

2. **Android → 앱 → Manifest**에서 `AndroidManifest.xml` 파일을 여십시오. 
	* `manifest` 태그 맨 위에 다음과 같은 권한을 추가하십시오. 

	  ```xml
	  <!-- Permissions -->
      <uses-permission android:name="android.permission.WAKE_LOCK" />

      <!-- GCM Permissions -->
      <uses-permission android:name="com.google.android.c2dm.permission.RECEIVE" />
      <permission
    	    android:name="your.application.package.name.permission.C2D_MESSAGE"
    	    android:protectionLevel="signature" />
      ```
      
	* `application` 태그에 다음을 추가하십시오. 

	  ```xml
      <!-- GCM Receiver -->
      <receiver
            android:name="com.google.android.gms.gcm.GcmReceiver"
            android:exported="true"
            android:permission="com.google.android.c2dm.permission.SEND">
            <intent-filter>
                <action android:name="com.google.android.c2dm.intent.RECEIVE" />
                <category android:name="your.application.package.name" />
            </intent-filter>
      </receiver>

      <!-- MFPPush Intent Service -->
      <service
            android:name="com.ibm.mobilefirstplatform.clientsdk.android.push.api.MFPPushIntentService"
            android:exported="false">
            <intent-filter>
                <action android:name="com.google.android.c2dm.intent.RECEIVE" />
            </intent-filter>
      </service>

      <!-- MFPPush Instance ID Listener Service -->
      <service
            android:name="com.ibm.mobilefirstplatform.clientsdk.android.push.api.MFPPushInstanceIDListenerService"
            android:exported="false">
            <intent-filter>
                <action android:name="com.google.android.gms.iid.InstanceID" />
            </intent-filter>
      </service>
      
      <activity android:name="com.ibm.mobilefirstplatform.clientsdk.android.push.api.MFPPushNotificationHandler"
           android:theme="@android:style/Theme.NoDisplay"/>
	  ```

	  > **참고:** `your.application.package.name`을 애플리케이션의 실제 패키지 이름으로 대체해야 합니다. 

    * 애플리케이션의 활동에 다음 `intent-filter`를 추가하십시오. 
      
      ```xml
      <intent-filter>
          <action android:name="your.application.package.name.IBMPushNotification" />
          <category android:name="android.intent.category.DEFAULT" />
      </intent-filter>
      ```
      
## 알림 API
{: #notifications-api }
### MFPPush 인스턴스
{: #mfppush-instance }
모든 API 호출은 `MFPPush`의 인스턴스에서 호출되어야 합니다. 이는 `private MFPPush push = MFPPush.getInstance();` 등의 클래스 레벨 필드를 작성한 후 클래스 전체에서 `push.<api-call>`를 호출하여 수행될 수 있습니다. 

또는 푸시 API 메소드에 액세스해야 하는 각 인스턴스에 대해 `MFPPush.getInstance().<api_call>`을 호출할 수 있습니다. 

### 인증 확인 핸들러
{: #challenge-handlers }
`push.mobileclient` 범위가 **보안 검사**에 맵핑되는 경우에는 푸시 API를 사용하기 전에 일치하는 **인증 확인 핸들러**가 존재하며 등록되어 있는지 확인해야 합니다. 

> [신임 정보 유효성 검증](../../../authentication-and-security/credentials-validation/android) 학습서에서 인증 확인 핸들러에 대해 자세히 학습하십시오. 

### 클라이언트 측
{: #client-side }

| Java 메소드 | 설명 |
|-----------------------------------------------------------------------------------|-------------------------------------------------------------------------|
| [`initialize(Context context);`](#initialization) | 제공된 컨텍스트에 대해 MFPPush를 초기화합니다. |
| [`isPushSupported();`](#is-push-supported) | 디바이스가 푸시 알림을 지원하는지 확인합니다. |
| [`registerDevice(JSONObject, MFPPushResponseListener);`](#register-device) | 디바이스를 푸시 알림 서비스에 등록합니다. |
| [`getTags(MFPPushResponseListener)`](#get-tags) | 푸시 알림 서비스 인스턴스에서 사용 가능한 태그를 검색합니다. |
| [`subscribe(String[] tagNames, MFPPushResponseListener)`](#subscribe) | 디바이스를 지정된 태그에 등록합니다. |
| [`getSubscriptions(MFPPushResponseListener)`](#get-subscriptions) | 디바이스가 현재 등록된 모든 태그를 검색합니다. |
| [`unsubscribe(String[] tagNames, MFPPushResponseListener)`](#unsubscribe) | 특정 태그에서 등록 취소합니다. |
| [`unregisterDevice(MFPPushResponseListener)`](#unregister) | 푸시 알림 서비스에서 디바이스를 등록 취소합니다. |

#### 초기화
{: #initialization }
클라이언트 애플리케이션이 올바른 애플리케이션 컨텍스트를 사용하여 MFPPush 서비스에 연결하기 위해 필요합니다. 

* 다른 MFPPush API를 사용하기 전에 먼저 API 메소드를 호출해야 합니다. 
* 수신된 푸시 알림을 처리하도록 콜백 함수를 등록합니다. 

```java
MFPPush.getInstance().initialize(this);
```

#### 푸시가 지원되는지 여부
{: #is-push-supported }
디바이스가 푸시 알림을 지원하는지 확인합니다. 

```java
Boolean isSupported = MFPPush.getInstance().isPushSupported();

if (isSupported ) {
    // Push is supported
} else {
    // Push is not supported
}
```

#### 디바이스 등록
{: #register-device }
디바이스를 푸시 알림 서비스에 등록합니다. 

```java
MFPPush.getInstance().registerDevice(null, new MFPPushResponseListener<String>() {
    @Override
    public void onSuccess(String s) {
        // Successfully registered
    }

    @Override
    public void onFailure(MFPPushException e) {
        // Registration failed with error
    }
});
```

#### 태그 가져오기
{: #get-tags }
푸시 알림 서비스에서 사용 가능한 모든 태그를 검색합니다. 

```java
MFPPush.getInstance().getTags(new MFPPushResponseListener<List<String>>() {
    @Override
    public void onSuccess(List<String> strings) {
        // Successfully retrieved tags as list of strings
    }

    @Override
    public void onFailure(MFPPushException e) {
        // Failed to receive tags with error
    }
});
```

#### 등록
{: #subscribe }
원하는 태그에 등록합니다. 

```java
String[] tags = {"Tag 1", "Tag 2"};

MFPPush.getInstance().subscribe(tags, new MFPPushResponseListener<String[]>() {
    @Override
    public void onSuccess(String[] strings) {
        // Subscribed successfully
    }

    @Override
    public void onFailure(MFPPushException e) {
        // Failed to subscribe
    }
});
```

#### 등록 가져오기
{: #get-subscriptions }
디바이스가 현재 등록된 태그를 검색합니다. 

```java
MFPPush.getInstance().getSubscriptions(new MFPPushResponseListener<List<String>>() {
    @Override
    public void onSuccess(List<String> strings) {
        // Successfully received subscriptions as list of strings
    }

    @Override
    public void onFailure(MFPPushException e) {
        // Failed to retrieve subscriptions with error
    }
});
```

#### 등록 취소
{: #unsubscribe }
태그에서 등록 취소합니다. 

```java
String[] tags = {"Tag 1", "Tag 2"};

MFPPush.getInstance().unsubscribe(tags, new MFPPushResponseListener<String[]>() {
    @Override
    public void onSuccess(String[] strings) {
        // Unsubscribed successfully
    }

    @Override
    public void onFailure(MFPPushException e) {
        // Failed to unsubscribe
    }
});
```

#### 등록 취소
{: #unregister }
푸시 알림 서비스 인스턴스에서 디바이스를 등록 취소합니다. 

```java
MFPPush.getInstance().unregisterDevice(new MFPPushResponseListener<String>() {
    @Override
    public void onSuccess(String s) {
        disableButtons();
        // Unregistered successfully
    }

    @Override
    public void onFailure(MFPPushException e) {
        // Failed to unregister
    }
});
```

## 푸시 알림 처리
{: #handling-a-push-notification }
푸시 알림을 처리하려면 `MFPPushNotificationListener`를 설정해야 합니다. 이는 다음 메소드 중 하나를 구현하여 수행할 수 있습니다. 

### 옵션 1
{: #option-one }
푸시 알림을 처리할 활동에서 

1. 클래스 선언에 `implements MFPPushNofiticationListener`를 추가하십시오. 
2. `onCreate` 메소드에서 `MFPPush.getInstance().listen(this)`를 호출하여 클래스를 리스너로 설정하십시오. 
2. 그런 다음 아래의 *필수* 메소드를 추가해야 합니다. 

   ```java
   @Override
   public void onReceive(MFPSimplePushNotification mfpSimplePushNotification) {
        // Handle push notification here
   }
   ```

3. 이 메소드에서 사용자는 `MFPSimplePushNotification`을 수신하고 원하는 작동에 대한 알림을 처리할 수 있습니다. 

### 옵션 2
{: #option-two }
아래에 개략적으로 설명된 대로 `MFPPush`의 인스턴스에서 `listen(new MFPPushNofiticationListener())`를 호출하여 리스너를 작성하십시오. 

```java
MFPPush.getInstance().listen(new MFPPushNotificationListener() {
    @Override
    public void onReceive(MFPSimplePushNotification mfpSimplePushNotification) {
        // Handle push notification here
    }
});
```

<img alt="샘플 애플리케이션의 이미지" src="notifications-app.png" style="float:right"/>
## 샘플 애플리케이션
{: #sample-application }

Android Studio 프로젝트를 [다운로드하려면 클릭](https://github.com/MobileFirst-Platform-Developer-Center/PushNotificationsAndroid/tree/release80)하십시오. 

### 샘플 사용법
{: #sample-usage }
샘플의 README.md 파일에 있는 지시사항을 따르십시오. 
