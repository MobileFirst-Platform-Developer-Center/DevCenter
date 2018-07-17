---
layout: tutorial
title: 기존 Android 애플리케이션 마이그레이션
breadcrumb_title: Android
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
IBM MobileFirst Platform Foundation 버전 6.2.0 이상으로 작성된 기존의 고유 Android 프로젝트를 마이그레이션하려면 현재 버전에서 SDK를 사용하도록 프로젝트를 수정해야 합니다. 그런 다음 V8.0에서 중단되거나 중단되지 않은 클라이언트 측 API를 대체하십시오. 마이그레이션 지원 도구는 코드를 스캔하고 대체할 API의 보고서를 생성할 수 있습니다.

#### 다음으로 이동
{: #jump-to }
* [버전 업그레이드 준비를 위해 기존 {{ site.data.keys.product_adj }} 고유 Android 앱 스캔](#scanning-existing-mobilefirst-native-android-apps-to-prepare-for-a-version-upgrade)
* [Gradle로 Android 프로젝트 마이그레이션](#migrating-an-android-project-with-gradle)
* [Android 코드 업데이트](#updating-the-android-code)

## 버전 업그레이드 준비를 위해 기존 {{ site.data.keys.product_adj }} 고유 Android 앱 스캔
{: #scanning-existing-mobilefirst-native-android-apps-to-prepare-for-a-version-upgrade }
마이그레이션 지원 도구는 고유 Android 앱의 소스를 스캔하고 V8.0에서 더 이상 사용되지 않거나 중단된 API의 보고서를 생성하여 마이그레이션을 위해 {{ site.data.keys.product_full }}의 이전 버전으로 작성된 앱을 준비하도록 도와줍니다.

마이그레이션 지원 도구를 사용하기 전에 다음 정보를 파악하는 것이 중요합니다.

* 기존 {{ site.data.keys.product }} 고유 Android 애플리케이션이 있어야 합니다.
* 인터넷에 액세스할 수 있어야 합니다.
* node.js 버전 4.0.0 이상이 설치되어 있어야 합니다.
* 마이그레이션 프로세스의 제한사항을 검토하고 숙지하십시오. 자세한 정보는 [이전 릴리스에서 앱 마이그레이션](../)을 참조하십시오.

{{ site.data.keys.product }}의 이전 버전으로 작성된 앱은 몇 가지를 변경하지 않으면 V8.0에서 지원되지 않습니다. 마이그레이션 지원 도구는 기존 앱에서 소스 파일을 스캔하여 프로세스를 단순화하고, V8.0에서 더 이상 사용되지 않거나 더 이상 지원되지 않거나 수정된 API를 식별합니다.

마이그레이션 지원 도구는 앱의 주석 또는 개발자 코드를 수정하거나 이동하지 않습니다.

1. 다음 방법 중 하나를 사용하여 마이그레이션 지원 도구를 다운로드하십시오.
    * [Git 저장소](https://git.ng.bluemix.net/ibmmfpf/mfpmigrate-cli)에서 .tgz 파일을 다운로드하십시오.
    * {{ site.data.keys.mf_console }}에서 마이그레이션 지원 도구를 포함하는 {{ site.data.keys.mf_dev_kit }}을 mfpmigrate-cli.tgz라는 파일로 다운로드하십시오.
2. 마이그레이션 지원 도구를 설치하십시오.
    * 도구를 다운로드한 디렉토리로 변경하십시오.
    * 다음 명령을 입력하여 NPM을 사용하여 도구를 설치하십시오.

   ```bash
   npm install -g
   ```

3. 다음 명령을 입력하여 {{ site.data.keys.product }} 앱을 스캔하십시오.

   ```bash
   mfpmigrate scan --in source_directory --out destination_directory --type android
   ```

   **source_directory**  
   프로젝트의 현재 위치입니다.

   **destination_directory**  
   보고서가 작성된 디렉토리입니다.

   스캔 명령과 함께 사용될 때 마이그레이션 지원 도구는 V8.0에서 제거되었거나 더 이상 사용되지 않거나 변경된 API를 기존 {{ site.data.keys.product }} 앱에서 식별하여 식별된 대상 디렉토리에 저장합니다.

## Gradle로 Android 프로젝트 마이그레이션
{: #migrating-an-android-project-with-gradle }
Gradle을 사용하여 {{ site.data.keys.product_adj }} SDK로 Android 애플리케이션 마이그레이션

Android Studio 및 Android SDK가 올바르게 설정되었는지 확인하십시오. 시스템을 설정하는 방법에 대한 자세한 정보는 [Android Studio 개요](http://developer.android.com/tools/studio/index.html)를 참조하십시오. {{ site.data.keys.product }}으로 업그레이드하려면 먼저 프로젝트가 Android Studio/Gradle 설정을 준수하고 오류 없이 컴파일되어야 합니다.

> **참고:** 이 태스크는 Android 프로젝트가 Android Studio로 작성되었고 [Android Studio를 사용하여 신규 또는 기존 애플리케이션에 {{ site.data.keys.product }} SDK 추가(7.1)](https://www.ibm.com/support/knowledgecenter/SSHS8R_7.1.0/com.ibm.worklight.dev.doc/dev/t_dev_new_w_gradle.html)에서 설명하는 것처럼 {{ site.data.keys.product_adj }} SDK가 함께 추가되었다고 가정합니다.

Android Studio 프로젝트가 이전 버전의 {{ site.data.keys.product_adj }} SDK를 추가하도록 설정된 경우, **build.gradle** 종속 항목 격납장치에서 **compile** 그룹을 제거하십시오. 예를 들어, 7.1에서 업그레이드하는 경우 다음 그룹을 제거하십시오.

```xml
compile group: 'com.ibm.mobile.foundation',
            name:'ibmmobilefirstplatformfoundation',
            version:'7.1.0.0',
            ext: 'aar',
            transitive: true
```

이제 로컬 또는 원격 SDK 파일을 사용하여 V8.0.0 SDK 및 구성을 추가할 수 있습니다. [Android 애플리케이션에 {{ site.data.keys.product_adj }} SDK 추가](../../../application-development/sdk/android)를 참조하십시오.

> 참고: 새 SDK를 가져온 후에는 수동으로 Javadoc 파일을 가져와야 합니다. [Android Studio Gradle 프로젝트에 Javadoc 등록](../../../application-development/sdk/android/additional-information)을 참조하십시오.

이제 {{ site.data.keys.product_adj }} SDK를 사용하여 고유 Android 애플리케이션 개발을 시작할 수 있습니다. V8.0.0 API의 변경사항에 맞게 코드를 조정해야 할 수도 있습니다([Android 코드 업데이트](#updating-the-android-code) 참조).

#### 다음에 수행할 작업
{: #what-to-do-next }
V8.0에서 중단되거나 중단되지 않은 클라이언트 측 API를 대체하십시오.

## Android 코드 업데이트
{: #updating-the-android-code }
{{ site.data.keys.product_full }} V8.0은 이전 버전에서 개발된 앱을 변경해야 하는 많은 Android SDK 변경사항을 소개합니다.  
다음 표는 {{ site.data.keys.product_adj }} Android SDK의 변경사항을 나열합니다.

#### 중단된 Android API 요소
{: #discontinued-android-api-elements }

|API 요소 |마이그레이션 경로 |
|-------------|----------------|
|`WLConfig WLClient.getConfig()` |대체 없음. |
| {::nomarkdown}<ul><li><code>WLDevice WLClient.getWLDevice()</code></li><li><code>WLClient.transmitEvent(org.json.JSONObject event)</code></li><li><code>WLClient.setEventTransmissionPolicy(WLEventTransmissionPolicy policy)</code></li><li><code>WLClient.purgeEventTransmissionBuffer()</code></li></ul>{:/} |위치정보에 대한 Android API 또는 써드파티 패키지를 사용하십시오. |
| {::nomarkdown}<ul><li><code>WL.Client.getUserInfo(realm, key)</code></li><li><code>WL.Client.updateUserInfo(options)</code></li></ul>{:/} |대체 없음 |
| {::nomarkdown}<ul><li><code>WL.Client.getUserInfo(realm, key</code></li><li><code>WL.Client.updateUserInfo(options)</code></li></ul>{:/} |대체 없음 |
|`WLClient.checkForNotifications()` |[`WLAuthorizationManager.obtainAccessToken("", listener)`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/wlclient/api/WLAuthorizationManager.html?view=kc#obtainAccessToken(java.lang.String,%20com.worklight.wlclient.api.WLAccessTokenListener))을 사용하여 서버에 대한 연결을 확인하고 애플리케이션 관리 규칙을 적용하십시오. |
| {::nomarkdown}<ul><li><code>WLClient.login(java.lang.String realmName, WLRequestListener listener, WLRequestOptions options)</code></li><li><code>WLClient.login(java.lang.String realmName, WLRequestListener listener)</code></li></ul>{:/} |[`AuthorizationManager.login()`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/wlclient/api/WLAuthorizationManager.html?view=kc#login(java.lang.String,%20org.json.JSONObject,%20com.worklight.wlclient.api.WLLoginResponseListener))을 사용하십시오. |
| {::nomarkdown}<ul><li><code>WLClient.logout(java.lang.String realmName, WLRequestListener listener, WLRequestOptions options)</code></li><li><code>WLClient.logout(java.lang.String realmName, WLRequestListener listener)</code></li></ul>{:/} |[`AuthorizationManager.logout()`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/wlclient/api/WLAuthorizationManager.html?view=kc#logout(java.lang.String,%20com.worklight.wlclient.api.WLLogoutResponseListener))을 사용하십시오. |
|`WLClient.obtainAccessToken(java.lang.String scope,WLResponseListener responseListener)` |[`WLAuthorizationManager.obtainAccessToken(String, WLAccessTokenListener)`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/wlclient/api/WLAuthorizationManager.html?view=kc#obtainAccessToken(java.lang.String,%20com.worklight.wlclient.api.WLAccessTokenListener))을 사용하여 서버에 대한 연결을 확인하고 애플리케이션 관리 규칙을 적용하십시오. |
| {::nomarkdown}<ul><li><code>WLClient.getLastAccessToken()</code></li><li><code>WLClient.getLastAccessToken(java.lang.String scope)</code></li></ul>{:/} |[`AuthorizationManager`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/wlclient/api/WLAuthorizationManager.html?view=kc)를 사용하십시오. |
|`WLClient.getRequiredAccessTokenScope(int status, java.lang.String header)` |[`AuthorizationManager`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/wlclient/api/WLAuthorizationManager.html?view=kc)를 사용하십시오. |
|`WLClient.logActivity(java.lang.String activityType)` |[`com.worklight.common.Logger`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/common/Logger.html?view=kc)를 사용하십시오. |
|`WLAuthorizationPersistencePolicy` |대체 없음. 권한 지속성을 구현하려면 애플리케이션 코드에 인증 토큰을 저장하고 사용자 정의 HTTP 요청을 작성하십시오. 자세한 정보는 [Java™ 사용자 정의 자원 요청 구현 샘플](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.dev.doc/dev/c_custom_request_to_resource_java.html?view=kc#c_custom_request_to_resource_hybrid)을 참조하십시오. |
| {::nomarkdown}<ul><li><code>WLSimpleSharedData.setSharedToken(myName, myValue)</code></li><li><code>WLSimpleSharedData.getSharedToken(myName)</code></li><li><code>WLSimpleSharedData.clearSharedToken(myName)</code></li></ul>{:/} |애플리케이션에서 토큰을 공유하는 Android API를 사용하십시오. |
|`WLUserCertificateManager.deleteCertificate(android.content.Context context)` |대체 없음 |
|`BaseChallengeHandler.submitFailure(WLResponse wlResponse)` |[`BaseChallengeHandler.cancel()`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/wlclient/api/challengehandler/BaseChallengeHandler.html?view=kc)을 사용하십시오. |
|`ChallengeHandler` |사용자 정의 게이트웨이 인증 확인의 경우 [GatewayChallengeHandler](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/wlclient/api/challengehandler/GatewayChallengeHandler.html?view=kc)를 사용하십시오. {{ site.data.keys.product_adj }} 보안 검사 인증 확인의 경우 [SecurityCheckChallengeHandler](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/wlclient/api/challengehandler/SecurityCheckChallengeHandler.html?view=kc)를 사용하십시오. |
|`WLChallengeHandler` |[SecurityCheckChallengeHandler](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/wlclient/api/challengehandler/SecurityCheckChallengeHandler.html?view=kc)를 사용하십시오. |
|`ChallengeHandler.isCustomResponse()` |[`GatewayChallengeHandler.canHandleResponse()`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/wlclient/api/challengehandler/GatewayChallengeHandler.html?view=kc)를 사용하십시오. |
|`ChallengeHandler.submitAdapterAuthentication` |인증 확인 핸들러에서 유사한 로직을 구현하십시오. 사용자 정의 게이트웨이 인증 확인 핸들러의 경우 [GatewayChallengeHandler](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/wlclient/api/challengehandler/GatewayChallengeHandler.html?view=kc)를 사용하십시오. |

#### 레거시 `org.apach.http` API에 종속되는 Android API는 더 이상 지원되지 않음
{: #android-apis-depending-on-the-legacy-orgapachhttp-apis-are-no-longer-supported }

|API 요소 |마이그레이션 경로 |
|-------------|----------------|
|`org.apache.http.Header[]`는 이제 더 이상 사용되지 않습니다. 따라서 다음 메소드가 제거됩니다. | |
|`org.apache.http.Header[] WLResourceRequest.getAllHeaders()` |대신 새 `Map<String, List<String>> WLResourceRequest.getAllHeaders()` API를 사용하십시오. |
|`WLResourceRequest.addHeader(org.apache.http.Header header)` |대신 새 `WLResourceRequest.addHeader(String name, String value)` API를 사용하십시오. |
|`org.apache.http.Header[] WLResourceRequest.getHeaders(java.lang.String headerName)` |대신 새 `List<String> WLResourceRequest.getHeaders(String headerName)` API를 사용하십시오. |
|`org.apache.http.Header WLResourceRequest.getFirstHeader(java.lang.String headerName)` |대신 새 `WLResourceRequest.getHeaders(String headerName)` API를 사용하십시오. |
|`WLResourceRequest.setHeaders(org.apache.http.Header[] headers)` |대신 새 `WLResourceRequest.setHeaders(Map<String, List<String>> headerMap)` API를 사용하십시오. |
|`WLResourceRequest.setHeader(org.apache.http.Header header)` |대신 새 `WLResourceRequest.setHeaders(Map<String, List<String>> headerMap)` API를 사용하십시오. |
|`org.apache.http.client.CookieStore WLClient.getCookieStore()` |`java.net.CookieStore getCookieStore WLClient.getCookieStore()`<br/><br/> `java.net.CookieStore getCookieStore WLClient.getCookieStore()` |
|`WLClient.setAllowHTTPClientCircularRedirect(boolean isSet)` |대체 없음. MFP 클라이언트를 사용하면 순환하여 경로를 재지정할 수 있습니다. |
| {::nomarkdown}<ul><li><code>WLHttpResponseListener</code></li><li><code>WLResourceRequest</code>, <code>WLHttpResponseListener</code>를 가져오는 모든 메소드:<ul><li><code>WLResourceRequest.send(java.util.HashMap formParameters,WLHttpResponseListener listener)</code></li><li><code>WLResourceRequest.send(org.json.JSONObject json, WLHttpResponseListener listener)</code></li><li><code>WLResourceRequest.send(byte[] data, WLHttpResponseListener listener)</code></li><li><code>WLResourceRequest.send(java.lang.String requestBody,WLHttpResponseListener listener)</code></li><li><code>WLResourceRequest.send(WLHttpResponseListener listener)</code></li><li><code>WLClient.sendRequest(org.apache.http.client.methods.HttpUriRequest request,WLHttpResponseListener listener)</code></li><li><code>WLClient.sendRequest(org.apache.http.client.methods.HttpUriRequest request, WLResponseListener listener)</code></li></ul></li></ul>{:/} |더 이상 사용되지 않는 Apache HTTP 클라이언트 종속 항목으로 인해 제거되었습니다. 요청 및 응답을 완전히 제어하려면 자체 요청을 작성하십시오. |
