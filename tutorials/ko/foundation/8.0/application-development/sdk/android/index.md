---
layout: tutorial
title: Android 애플리케이션에 MobileFirst Foundation SDK 추가
breadcrumb_title: Android
relevantTo: [android]
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
{{ site.data.keys.product_full }} SDK는 [Maven Central](http://search.maven.org/)을 통해 사용 가능한 종속 항목 콜렉션으로 구성되며, Android Studio 프로젝트에 추가될 수 있습니다. 종속 항목은 핵심 기능 및 다른 기능에 해당됩니다. 

* **IBMMobileFirstPlatformFoundation** - 클라이언트 대 서버 연결을 구현하고 인증 및 보안 측면, 자원 요청과 기타 필수 핵심 기능을 처리합니다. 
* **IBMMobileFirstPlatformFoundationJSONStore** - JSONStore 프레임워크를 포함합니다. 자세한 정보는 [Andoid용 JSONStore 학습서](../../jsonstore/android/)를 검토하십시오. 
* **IBMMobileFirstPlatformFoundationPush** - 푸시 알림 프레임워크를 포함합니다. 자세한 정보는 [알림 학습서](../../../notifications/)를 검토하십시오. 

이 학습서에서는 Gradle을 사용하여 신규 또는 기존 Android 애플리케이션에 {{ site.data.keys.product_adj }} 고유 SDK를 추가하는 방법에 대해 학습합니다. 또한 애플리케이션을 인식하도록 {{ site.data.keys.mf_server }}를 구성하는 방법 및 프로젝트에 추가되는 {{ site.data.keys.product_adj }} 구성 파일에 대한 정보를 찾는 방법에 대해서도 학습합니다. 

**전제조건:**

- 개발자 워크스테이션에 Android Studio 및 {{ site.data.keys.mf_cli }}가 설치되어 있습니다.   
- {{ site.data.keys.mf_server }}의 로컬 또는 원격 인스턴스가 실행 중입니다. 
- [{{ site.data.keys.product_adj }} 개발 환경 설정](../../../installation-configuration/development/mobilefirst) 및 [Android 개발 환경 설정](../../../installation-configuration/development/android) 학습서를 읽으십시오. 

#### 다음으로 이동:
{: #jump-to }
- [{{ site.data.keys.product_adj }} 고유 SDK 추가](#adding-the-mobilefirst-native-sdk)
- [{{ site.data.keys.product_adj }} 고유 SDK를 수동으로 추가](#manually-adding-the-mobilefirst-native-sdk)
- [{{ site.data.keys.product_adj }} 고유 SDK 업데이트](#updating-the-mobilefirst-native-sdk)
- [생성된 {{ site.data.keys.product_adj }} 고유 SDK 아티팩트](#generated-mobilefirst-native-sdk-artifacts)
- [Javadoc 및 Android 서비스의 지원](#support-for-javadoc-and-android-service)
- [다음 학습서](#tutorials-to-follow-next)

## {{ site.data.keys.product_adj }} 고유 SDK 추가
{: #adding-the-mobilefirst-native-sdk }
아래 지시사항에 따라 신규 또는 기존 Android Studio 프로젝트에 {{ site.data.keys.product_adj }} 고유 SDK를 추가하고 {{ site.data.keys.mf_server }} 인스턴스에 애플리케이션을 등록하십시오. 

시작하기 전에 {{ site.data.keys.mf_server }}가 실행 중인지 확인하십시오.   
로컬로 설치된 서버를 사용하는 경우: **명령행** 창에서 서버의 폴더로 이동하고 `./run.sh`(Mac 또는 Linux OS에서)나 `run.cmd`(Windows에서) 명령을 실행하십시오. 

### Android 애플리케이션 작성
{: #creating-an-android-application }
Android Studio 프로젝트를 작성하거나 기존 항목을 사용하십시오.   

### SDK 추가
{: #adding-the-sdk }
1. **Android → Gradle 스크립트**에서 **build.gradle(모듈: 앱)** 파일을 선택하십시오. 

2. `apply plugin: 'com.android.application'` 뒤에 다음 행을 추가하십시오. 

   ```xml
   repositories{
        jcenter()
   }
   ```

3. `android` 섹션 내에 다음 행을 추가하십시오. 

   ```xml
   packagingOptions {
        pickFirst 'META-INF/ASL2.0'
        pickFirst 'META-INF/LICENSE'
        pickFirst 'META-INF/NOTICE'
   }
   ```

4. `dependencies` 섹션 내에 다음 행을 추가하십시오. 

   ```xml
   compile group: 'com.ibm.mobile.foundation',
   name: 'ibmmobilefirstplatformfoundation',
   version: '8.0.+',
   ext: 'aar',
   transitive: true
   ```

   또는 단일 행의 경우:

   ```xml
   compile 'com.ibm.mobile.foundation:ibmmobilefirstplatformfoundation:8.0.+'
   ```

5. **Android → 앱 → Manifest**에서 `AndroidManifest.xml` 파일을 여십시오. **애플리케이션** 요소 위에 다음 권한을 추가하십시오. 

   ```xml
   <uses-permission android:name="android.permission.INTERNET"/>
   <uses-permission android:name="android.permission.ACCESS_WIFI_STATE"/>
   ```

6. 기존 **활동** 요소 옆에 {{ site.data.keys.product_adj }} UI 활동을 추가하십시오. 

   ```xml
   <activity android:name="com.worklight.wlclient.ui.UIActivity" />
   ```

> Gradle 동기화 요청이 표시되면 허용하십시오. 

### {{ site.data.keys.product_adj }} 고유 SDK를 수동으로 추가
{: #manually-adding-the-mobilefirst-native-sdk }
{{ site.data.keys.product_adj }} SDK를 다음과 같이 수동으로 추가할 수도 있습니다. 

<div class="panel-group accordion" id="adding-the-sdk-manually" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="android-sdk">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#android-sdk" data-target="#collapse-android-sdk" aria-expanded="false" aria-controls="collapse-android-sdk"><b>지시사항을 보려면 클릭</b></a>
            </h4>
        </div>

        <div id="collapse-android-sdk" class="panel-collapse collapse" role="tabpanel" aria-labelledby="android-sdk">
            <div class="panel-body">
                <p>{{ site.data.keys.product_adj }} SDK를 수동으로 추가하려면 먼저 <b>{{ site.data.keys.mf_console }} → 다운로드 센터 → SDK</b> 탭에서 SDK .zip 파일을 다운로드하십시오. 위 단계를 완료한 후에 아래 단계도 수행하십시오. </p>

                <ul>
                    <li>다운로드된 .zip 파일을 추출하고 관련 aar 파일을 <b>app\libs</b> 폴더에 저장하십시오. </li>
                    <li>다음을 <b>종속 항목</b> 클로저에 추가하십시오.
{% highlight xml %}
compile(name:'ibmmobilefirstplatformfoundation', ext:'aar')
compile 'com.squareup.okhttp3:okhttp-urlconnection:3.4.1'   
compile 'com.squareup.okhttp3:okhttp:3.4.1'
{% endhighlight %}
                    </li>
                    <li>다음을 <b>저장소</b> 클로저에 추가하십시오.
{% highlight xml %}
repositories {
    flatDir {
        dirs 'libs'
    }
}
{% endhighlight %}
                    </li>
                </ul>

                <br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#android-sdk" data-target="#collapse-android-sdk" aria-expanded="false" aria-controls="collapse-android-sdk"><b>닫기 섹션</b></a>
            </div>
        </div>
    </div>
</div>



### 애플리케이션 등록
{: #registering-the-application }
1. **명령행** 창을 열고 Android Studio 프로젝트의 루트로 이동하십시오.   

2. 다음 명령을 실행하십시오. 

    ```bash
    mfpdev app register
    ```
    - 원격 서버를 사용하는 경우 [`mfpdev server add` 명령을 사용](../../using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance)하여 추가하십시오. 

`mfpdev app register` CLI 명령은 먼저 {{ site.data.keys.mf_server }}에 연결하여 애플리케이션을 등록한 후에 Android Studio 프로젝트의 **[project root]/app/src/main/assets/** 폴더에 **mfpclient.properties** 파일을 생성하고 {{ site.data.keys.mf_server }}를 식별하는 메타데이터에 추가합니다. 

> <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> **팁:** {{ site.data.keys.mf_console }}에서 애플리케이션을 등록할 수도 있습니다.     
>
> 1. {{ site.data.keys.mf_console }}을 로드하십시오.   
> 2. **애플리케이션** 옆에 있는 **새로 작성** 단추를 클릭하여 새 애플리케이션을 등록하고 화면의 지시사항에 따르십시오.   
> 3. 애플리케이션이 등록된 후에 애플리케이션의 **구성 파일** 탭으로 이동하고 **mfpclient.properties** 파일을 복사하거나 다운로드하십시오. 화면의 지시사항에 따라 프로젝트에 파일을 추가하십시오. 

### WLClient 인스턴스 작성
{: #creating-a-wlclient-instance }
{{ site.data.keys.product_adj }} API를 사용하기 전에 `WLClient` 인스턴스를 다음과 같이 작성하십시오. 

```java
WLClient.createInstance(this);
```

**참고:** `WLClient` 인스턴스는 전체 애플리케이션 라이프사이클 중에 한 번만 작성해야 합니다. Android 애플리케이션 클래스를 사용하여 수행할 것을 권장합니다. 

## {{ site.data.keys.product_adj }} 고유 SDK 업데이트
{: #updating-the-mobilefirst-native-sdk }
최신 릴리스로 {{ site.data.keys.product_adj }} 고유 SDK를 업데이트하려면 릴리스 버전 번호를 찾고 **build.gradle** 파일에서 `version` 특성을 적절하게 업데이트하십시오.   
위의 4단계를 참조하십시오. 

SDK 릴리스는 SDK의 [JCenter 저장소](https://bintray.com/bintray/jcenter/com.ibm.mobile.foundation%3Aibmmobilefirstplatformfoundation/view#)에 있습니다. 

## 생성된 {{ site.data.keys.product_adj }} 고유 SDK 아티팩트
{: #generated-mobilefirst-native-sdk-artifacts }
### mfpclient.properties
{: #mfpclient.properties }
이 파일은 Android Studio 프로젝트의 **./app/src/main/assets/** 폴더에 있으며, {{ site.data.keys.mf_server }}에서 Android 앱을 등록하는 데 사용되는 클라이언트 측 특성을 정의합니다. 

| 특성| 설명| 예제 값|
|---------------------|---------------------------------------------------------------------|----------------|
| wlServerProtocol| {{ site.data.keys.mf_server }}에 사용되는 통신 프로토콜입니다.| HTTP 또는 HTTPS|
| wlServerHost| {{ site.data.keys.mf_server }}의 호스트 이름입니다.| 192.168.1.63|
| wlServerPort| {{ site.data.keys.mf_server }}의 포트입니다.| 9080|
| wlServerContext| {{ site.data.keys.mf_server }}에서 애플리케이션의 컨텍스트 루트 경로입니다. | /mfp/|
| languagePreferences| 클라이언트 SDK 시스템 메시지의 기본 언어를 설정합니다. | en|

## Javadoc 및 Android 서비스의 지원
{: #support-for-javadoc-and-android-service }
Javadoc 및 Android 서비스의 지원에 대한 정보는 [추가 정보](additional-information) 페이지를 참조하십시오. 

## 다음 학습서
{: #tutorials-to-follow-next }
이제 {{ site.data.keys.product_adj }} 고유 SDK가 통합되었으므로 다음을 수행할 수 있습니다. 

- [{{ site.data.keys.product }} SDK 사용 학습서](../) 검토
- [어댑터 개발 학습서](../../../adapters/) 검토
- [인증 및 보안 학습서](../../../authentication-and-security/) 검토
- [알림 학습서](../../../notifications/) 검토
- [모든 학습서](../../../all-tutorials) 검토
