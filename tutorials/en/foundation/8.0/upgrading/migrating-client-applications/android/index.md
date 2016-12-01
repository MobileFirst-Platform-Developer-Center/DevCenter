---
layout: tutorial
title: Migrating existing Android applications
breadcrumb_title: Android
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
To migrate an existing native Android project that was created with IBM MobileFirst Platform Foundation version 6.2.0 or later, you must modify the project to use the SDK from the current version. Then you replace the client-side APIs that are discontinued or not in v8.0. The migration assistance tool can scan your code and generate reports of the APIs to replace.

#### Jump to

* [Scanning existing {{ site.data.keys.product }} native Android apps to prepare for {{ site.data.keys.product }} version 8.0](#scanning-existing-mobilefirst-native-android-apps-to-prepare-for-mobilefirst-version-80)
* [Migrating an Android project with Gradle](#migrating-an-android-project-with-gradle)
* [Updating the Android code](#updating-the-android-code)

## Scanning existing {{ site.data.keys.product }} native Android apps to prepare for {{ site.data.keys.product }} version 8.0
The migration assistance tool helps you prepare your apps that were created with a previous version of IBM MobileFirst™ Platform Foundation for migration by scanning the sources of the native Android app and generating a report of APIs that are deprecated or discontinued in version 8.0.

The following information is important to know before you use the migration assistance tool:

* You must have an existing {{ site.data.keys.product }} native Android application.
* You must have internet access.
* You must have node.js version 4.0.0 or later installed.
* Review and understand the limitations of the migration process. For more information, see [Migrating apps from earlier releases](../).

Apps that were created with previous versions of {{ site.data.keys.product }} are not supported in version 8.0 without some changes. The migration assistance tool simplifies the process by scanning the source files in the existing app and identifies APIs that are deprecated, no longer supported, or modified in version 8.0.

The migration assistance tool does not modify or move any developer code or comments of your app.

1. Download the migration assistance tool by using one of the following methods:
    * Download the .tgz file from the [Jazzhub repository](https://hub.jazz.net/project/ibmmfpf/mfp-migrator-tool).
    * Download the Developer Kit, which contains the migration assistance tool as a file named mfpmigrate-cli.tgz, from the {{ site.data.keys.mf_console }}.
2. Install the migration assistance tool.
    * Change to the directory where you downloaded the tool.
    * Use NPM to install the tool by entering the following command:

   ```bash
   npm install -g
   ```
    
3. Scan the {{ site.data.keys.product }} app by entering the following command:

   ```bash
   mfpmigrate scan --in source_directory --out destination_directory --type android
   ```
    
   **source_directory**  
   The current location of the project.

   **destination_directory**  
   The directory where the report is created.
    
   When it is used with the scan command, the migration assistance tool identifies APIs in the existing {{ site.data.keys.product }} app that are removed, deprecated, or changed in version 8.0 and saves them in the identified destination directory.

## Migrating an Android project with Gradle
Migrate your Android application with {{ site.data.keys.product_adj }} SDK using Gradle.

Ensure that your Android Studio and the Android SDK are set up properly. For more information about how to set up your system, see [Android Studio Overview](http://developer.android.com/tools/studio/index.html). Your project must conform to the Android Studio/Gradle setup and compile without errors before you upgrade to {{ site.data.keys.product }}.

> **Note:** This task assumes that the Android project is created with Android Studio and that the {{ site.data.keys.product_adj }} SDK is added with as described in [Adding the {{ site.data.keys.product }} SDK to a new or existing application with Android Studio (7.1)](https://www.ibm.com/support/knowledgecenter/SSHS8R_7.1.0/com.ibm.worklight.dev.doc/dev/t_dev_new_w_gradle.html).

If your Android Studio project was set up to add a previous version of {{ site.data.keys.product_adj }} SDK, remove the **compile** group from the **build.gradle** dependencies enclosure. For example, if you are upgrading from 7.1, remove this group:

```xml
compile group: 'com.ibm.mobile.foundation', 
            name:'ibmmobilefirstplatformfoundation', 
            version:'7.1.0.0', 
            ext: 'aar', 
            transitive: true
```

You can now add the V8.0.0 SDK and configuration, by using local or remote SDK files. See [Adding the {{ site.data.keys.product_adj }} SDK to Android applications](../../../application-development/sdk/android).

> Note: After you import the new SDK, you need to import the Javadoc files manually. See [Registering Javadocs to an Android Studio Gradle project](../../../application-development/sdk/android/additional-information).

You can now start developing your native Android application with the {{ site.data.keys.product_adj }} SDK. You might need to adapt your code to changes in the V8.0.0 API (see [Updating the Android code](#updating-the-android-code)).

#### What to do next
Replace the client-side APIs that are discontinued or not in v8.0.

## Updating the Android code
{{ site.data.keys.product_full }} v8.0 introduces a number of changes to the Android SDK that might require changes to apps developed in earlier versions.  
The tables below list changes in the {{ site.data.keys.product_adj }} Android SDK.

#### Discontinued Android API elements

| API element | Migration path | 
|-------------|----------------|
| `WLConfig WLClient.getConfig()` | No replacement. | 
| {::nomarkdown}<ul><li><code>WLDevice WLClient.getWLDevice()</code></li><li><code>WLClient.transmitEvent(org.json.JSONObject event)</code></li><li><code>WLClient.setEventTransmissionPolicy(WLEventTransmissionPolicy policy)</code></li><li><code>WLClient.purgeEventTransmissionBuffer()</code></li></ul>{:/} | Use Android API or third-party packages for GeoLocation. | 
| {::nomarkdown}<ul><li><code>WL.Client.getUserInfo(realm, key)</code></li><li><code>WL.Client.updateUserInfo(options)</code></li></ul>{:/} | No replacement | 
| {::nomarkdown}<ul><li><code>WL.Client.getUserInfo(realm, key</code></li><li><code>WL.Client.updateUserInfo(options)</code></li></ul>{:/} | No replacement | 
| `WLClient.checkForNotifications()` | Use [`WLAuthorizationManager.obtainAccessToken("", listener)`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/wlclient/api/WLAuthorizationManager.html?view=kc#obtainAccessToken(java.lang.String,%20com.worklight.wlclient.api.WLAccessTokenListener)) to check connectivity to the server and apply application management rules. | 
| {::nomarkdown}<ul><li><code>WLClient.login(java.lang.String realmName, WLRequestListener listener, WLRequestOptions options)</code></li><li><code>WLClient.login(java.lang.String realmName, WLRequestListener listener)</code></li></ul>{:/} | Use [`AuthorizationManager.login()`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/wlclient/api/WLAuthorizationManager.html?view=kc#login(java.lang.String,%20org.json.JSONObject,%20com.worklight.wlclient.api.WLLoginResponseListener)) | 
| {::nomarkdown}<ul><li><code>WLClient.logout(java.lang.String realmName, WLRequestListener listener, WLRequestOptions options)</code></li><li><code>WLClient.logout(java.lang.String realmName, WLRequestListener listener)</code></li></ul>{:/} | Use [`AuthorizationManager.logout()`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/wlclient/api/WLAuthorizationManager.html?view=kc#logout(java.lang.String,%20com.worklight.wlclient.api.WLLogoutResponseListener)). | 
| `WLClient.obtainAccessToken(java.lang.String scope,WLResponseListener responseListener)` | Use [`WLAuthorizationManager.obtainAccessToken(String, WLAccessTokenListener)`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/wlclient/api/WLAuthorizationManager.html?view=kc#obtainAccessToken(java.lang.String,%20com.worklight.wlclient.api.WLAccessTokenListener)) to check connectivity to the server and apply application management rules. | 
| {::nomarkdown}<ul><li><code>WLClient.getLastAccessToken()</code></li><li><code>WLClient.getLastAccessToken(java.lang.String scope)</code></li></ul>{:/} | Use [`AuthorizationManager`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/wlclient/api/WLAuthorizationManager.html?view=kc). | 
| `WLClient.getRequiredAccessTokenScope(int status, java.lang.String header)` | Use [`AuthorizationManager`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/wlclient/api/WLAuthorizationManager.html?view=kc). | 
| `WLClient.logActivity(java.lang.String activityType)` | Use [`com.worklight.common.Logger`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/common/Logger.html?view=kc) | 
| `WLAuthorizationPersistencePolicy` | No replacement. To implement authorization persistence, store the authorization token in the application code and create custom HTTP requests. For more information, see [Java™ custom resource-request implementation sample](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.dev.doc/dev/c_custom_request_to_resource_java.html?view=kc#c_custom_request_to_resource_hybrid). | 
| {::nomarkdown}<ul><li><code>WLSimpleSharedData.setSharedToken(myName, myValue)</code></li><li><code>WLSimpleSharedData.getSharedToken(myName)</code></li><li><code>WLSimpleSharedData.clearSharedToken(myName)</code></li></ul>{:/} | Use the Android APIs to share tokens across applications. |
| `WLUserCertificateManager.deleteCertificate(android.content.Context context)` | No replacement | 
| `BaseChallengeHandler.submitFailure(WLResponse wlResponse)` | Use [`BaseChallengeHandler.cancel()`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/wlclient/api/challengehandler/BaseChallengeHandler.html?view=kc). | 
| `ChallengeHandler` | For custom gateway challenges, use [GatewayChallengeHandler](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/wlclient/api/challengehandler/GatewayChallengeHandler.html?view=kc). For {{ site.data.keys.product_adj }} security-check challenges, use [SecurityCheckChallengeHandler](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/wlclient/api/challengehandler/SecurityCheckChallengeHandler.html?view=kc). | 
| `WLChallengeHandler` | Use [SecurityCheckChallengeHandler](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/wlclient/api/challengehandler/SecurityCheckChallengeHandler.html?view=kc). |
| `ChallengeHandler.isCustomResponse()` | Use [`GatewayChallengeHandler.canHandleResponse()`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/wlclient/api/challengehandler/GatewayChallengeHandler.html?view=kc). | 
| `ChallengeHandler.submitAdapterAuthentication` | Implement similar logic in your challenge handler. For custom gateway challenge handlers, use [GatewayChallengeHandler](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/wlclient/api/challengehandler/GatewayChallengeHandler.html?view=kc). | 

#### Android APIs depending on the legacy `org.apach.http` APIs are no longer supported

| API element | Migration path | 
|-------------|----------------|
| `org.apache.http.Header[]` is now deprecated. Therefore, the following methods are removed: | |
| `org.apache.http.Header[] WLResourceRequest.getAllHeaders()` | Use instead the new `Map<String, List<String>> WLResourceRequest.getAllHeaders()` API. | 
| `WLResourceRequest.addHeader(org.apache.http.Header header)` | Use instead the new `WLResourceRequest.addHeader(String name, String value)` API. | 
| `org.apache.http.Header[] WLResourceRequest.getHeaders(java.lang.String headerName)` | Use instead the new `List<String> WLResourceRequest.getHeaders(String headerName)` API. |
| `org.apache.http.Header WLResourceRequest.getFirstHeader(java.lang.String headerName)` | Use instead the new `WLResourceRequest.getHeaders(String headerName)` API. | 
| `WLResourceRequest.setHeaders(org.apache.http.Header[] headers)` | Instead, use the new `WLResourceRequest.setHeaders(Map<String, List<String>> headerMap)` API. | 
| `WLResourceRequest.setHeader(org.apache.http.Header header)` | Instead, use the new `WLResourceRequest.setHeaders(Map<String, List<String>> headerMap)` API. | 
| `org.apache.http.client.CookieStore WLClient.getCookieStore()` | Replaced with `java.net.CookieStore getCookieStore WLClient.getCookieStore()`<br/><br/> `java.net.CookieStore getCookieStore WLClient.getCookieStore()` |
| `WLClient.setAllowHTTPClientCircularRedirect(boolean isSet)` | No replacement. MFP Client allows circular redirects. | 
| {::nomarkdown}<ul><li><code>WLHttpResponseListener</code></li><li><code>WLResourceRequest</code>, all methods that take <code>WLHttpResponseListener</code>:<ul><li><code>WLResourceRequest.send(java.util.HashMap formParameters,WLHttpResponseListener listener)</code></li><li><code>WLResourceRequest.send(org.json.JSONObject json, WLHttpResponseListener listener)</code></li><li><code>WLResourceRequest.send(byte[] data, WLHttpResponseListener listener)</code></li><li><code>WLResourceRequest.send(java.lang.String requestBody,WLHttpResponseListener listener)</code></li><li><code>WLResourceRequest.send(WLHttpResponseListener listener)</code></li><li><code>WLClient.sendRequest(org.apache.http.client.methods.HttpUriRequest request,WLHttpResponseListener listener)</code></li><li><code>WLClient.sendRequest(org.apache.http.client.methods.HttpUriRequest request, WLResponseListener listener)</code></li></ul></li></ul>{:/} | Removed due to deprecated Apache HTTP Client dependencies. Create your own request to have full control over the request and response. |




