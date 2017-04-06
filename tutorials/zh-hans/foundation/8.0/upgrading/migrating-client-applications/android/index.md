---
layout: tutorial
title: 迁移现有 Android 应用程序
breadcrumb_title: Android
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
要迁移使用 IBM MobileFirst Platform Foundation V6.2.0 或更高版本创建的现有本机 Android 项目，必须修改此项目以使用当前版本中的 SDK。然后，替换 V8.0 中停用或不包含的客户端 API。迁移辅助工具可扫描您的代码并生成要替换的 API 的报告。

#### 跳至：
{: #jump-to }
* [扫描现有的 {{ site.data.keys.product_adj }} 本机 Android 应用程序以准备升级版本](#scanning-existing-mobilefirst-native-android-apps-to-prepare-for-a-version-upgrade)
* [使用 Gradle 迁移 Android 项目](#migrating-an-android-project-with-gradle)
* [更新 Android 代码](#updating-the-android-code)

## 扫描现有的 {{ site.data.keys.product_adj }} 本机 Android 应用程序以准备升级版本
{: #scanning-existing-mobilefirst-native-android-apps-to-prepare-for-a-version-upgrade }
迁移辅助工具可帮助您准备使用 {{ site.data.keys.product_full }} 的先前版本创建的应用程序进行迁移，方法是扫描本机 Android 应用程序的源文件并生成 V8.0 中不推荐使用或停用的 API 的报告。

使用迁移辅助工具之前，务必了解以下信息：

* 必须具有现有 {{ site.data.keys.product }} 本机 Android 应用程序。
* 您必须具有因特网访问权。
* 您必须已安装 node.js V4.0.0 或更高版本。
* 查看并了解迁移过程的限制。有关更多信息，请参阅[从先前发行版迁移应用程序](../)。

对于使用 {{ site.data.keys.product }} 先前版本创建的应用程序，在未进行一些更改的情况下在 V8.0 中不受支持。迁移辅助工具通过扫描现有应用程序中的源文件，识别 V8.0 中不推荐使用、不再支持或修改的 API，从而简化此过程。

迁移辅助工具不会修改或移动应用程序的任何开发人员代码或注释。

1. 通过使用以下其中一种方法下载迁移辅助工具：
    * 从 [Jazzhub 存储库](https://hub.jazz.net/project/ibmmfpf/mfp-migrator-tool)下载 .tgz 文件。
    * 从 {{ site.data.keys.mf_console }} 下载 {{ site.data.keys.mf_dev_kit }}，其中包含名为 mfpmigrate-cli.tgz 的迁移辅助工具文件。
2. 安装迁移辅助工具。
    * 切换到下载工具的目录。
    * 通过输入以下命令，使用 NPM 安装该工具：

   ```bash
   npm install -g
   ```
    
3. 通过输入以下命令扫描 {{ site.data.keys.product }} 应用程序：

   ```bash
   mfpmigrate scan --in source_directory --out destination_directory --type android
   ```
    
   **source_directory**  
   项目的当前位置。

   **destination_directory**  
   创建报告的目录。
    
   与 scan 命令一起使用时，迁移辅助工具会识别现有 {{ site.data.keys.product }} 应用程序在 V8.0 中已移除、不推荐使用或更改的 API，并将它们保存在确定的目标目录中。

## 使用 Gradle 迁移 Android 项目
{: #migrating-an-android-project-with-gradle }
使用 Gradle 迁移带 {{ site.data.keys.product_adj }} SDK 的 Android 应用程序。

确保正确设置 Android Studio 和
Android SDK。有关如何设置系统的更多信息，请参阅 [Android Studio 概述](http://developer.android.com/tools/studio/index.html)。项目在升级到 {{ site.data.keys.product }} 之前必须符合 Android Studio/Gradle 设置且没有编译错误。

> **注：**此任务假定使用 Android Studio 创建了 Android 项目，并且按照 [Adding the {{ site.data.keys.product }} SDK to a new or existing application with Android Studio (7.1)](https://www.ibm.com/support/knowledgecenter/SSHS8R_7.1.0/com.ibm.worklight.dev.doc/dev/t_dev_new_w_gradle.html) 所述添加了 {{ site.data.keys.product_adj }} SDK。

如果 Android Studio 项目设置为添加先前版本的 {{ site.data.keys.product_adj }} SDK，请从 **build.gradle** dependencies 节中移除 **compile** 组。例如，如果是从 7.1 进行升级，请移除该组：

```xml
compile group: 'com.ibm.mobile.foundation', 
            name:'ibmmobilefirstplatformfoundation', 
            version:'7.1.0.0', 
            ext: 'aar', 
            transitive: true
```

现在，您可以使用本地或远程 SDK 文件来添加 V8.0.0 SDK 和配置。请参阅[将 {{ site.data.keys.product_adj }} SDK 添加到 Android 应用程序](../../../application-development/sdk/android)。

> 注：导入新的 SDK 后，需要手动导入 Javadoc 文件。请参阅[将 Javadocs 注册到 Android Studio Gradle 项目](../../../application-development/sdk/android/additional-information)。现在，您可以开始使用 {{ site.data.keys.product_adj }} SDK 来开发本机 Android 应用程序。
您可能需要根据 V8.0.0 API 中的更改来调整代码（请参阅[更新 Android 代码](#updating-the-android-code)）。

#### 后续步骤
{: #what-to-do-next }
替换 V8.0 中停用或不包含的客户端 API。

## 更新 Android 代码
{: #updating-the-android-code }
{{ site.data.keys.product_full }} V8.0 引入了一些对 Android SDK 的更改，这可能需要更改在先前版本中开发的应用程序。  
下表列出 {{ site.data.keys.product_adj }} Android SDK 中的更改。

#### 停用的 Android API 元素
{: #discontinued-android-api-elements }

| API 元素 | 迁移路径 | 
|-------------|----------------|
| `WLConfig WLClient.getConfig()` | 无替换。 | 
| {::nomarkdown}<ul><li><code>WLDevice WLClient.getWLDevice()</code></li><li><code>WLClient.transmitEvent(org.json.JSONObject event)</code></li><li><code>WLClient.setEventTransmissionPolicy(WLEventTransmissionPolicy policy)</code></li><li><code>WLClient.purgeEventTransmissionBuffer()</code></li></ul>{:/} | 使用 Android API 或第三方软件包进行地理定位。 | 
| {::nomarkdown}<ul><li><code>WL.Client.getUserInfo(realm, key)</code></li><li><code>WL.Client.updateUserInfo(options)</code></li></ul>{:/} | 无替换 | 
| {::nomarkdown}<ul><li><code>WL.Client.getUserInfo(realm, key</code></li><li><code>WL.Client.updateUserInfo(options)</code></li></ul>{:/} | 无替换 | 
| `WLClient.checkForNotifications()` | 使用 [`WLAuthorizationManager.obtainAccessToken("", listener)`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/wlclient/api/WLAuthorizationManager.html?view=kc#obtainAccessToken(java.lang.String,%20com.worklight.wlclient.api.WLAccessTokenListener)) 检查服务器连接并实施应用程序管理规则。 | 
| {::nomarkdown}<ul><li><code>WLClient.login(java.lang.String realmName, WLRequestListener listener,
WLRequestOptions options)</code></li><li><code>WLClient.login(java.lang.String realmName,
WLRequestListener listener)</code></li></ul>{:/} | 使用 [`AuthorizationManager.login()`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/wlclient/api/WLAuthorizationManager.html?view=kc#login(java.lang.String,%20org.json.JSONObject,%20com.worklight.wlclient.api.WLLoginResponseListener)) | 
| {::nomarkdown}<ul><li><code>WLClient.logout(java.lang.String realmName, WLRequestListener listener,
WLRequestOptions options)</code></li><li><code>WLClient.logout(java.lang.String realmName,
WLRequestListener listener)</code></li></ul>{:/} | 使用 [`AuthorizationManager.logout()`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/wlclient/api/WLAuthorizationManager.html?view=kc#logout(java.lang.String,%20com.worklight.wlclient.api.WLLogoutResponseListener))。 | 
| `WLClient.obtainAccessToken(java.lang.String scope,WLResponseListener
responseListener)` | 使用 [`WLAuthorizationManager.obtainAccessToken(String, WLAccessTokenListener)`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/wlclient/api/WLAuthorizationManager.html?view=kc#obtainAccessToken(java.lang.String,%20com.worklight.wlclient.api.WLAccessTokenListener)) 检查服务器连接并实施应用程序管理规则。 | 
| {::nomarkdown}<ul><li><code>WLClient.getLastAccessToken()</code></li><li><code>WLClient.getLastAccessToken(java.lang.String
scope)</code></li></ul>{:/} | 使用 [`AuthorizationManager`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/wlclient/api/WLAuthorizationManager.html?view=kc)。 | 
| `WLClient.getRequiredAccessTokenScope(int status, java.lang.String
header)` | 使用 [`AuthorizationManager`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/wlclient/api/WLAuthorizationManager.html?view=kc)。 | 
| `WLClient.logActivity(java.lang.String activityType)` | 使用 [`com.worklight.common.Logger`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/common/Logger.html?view=kc) | 
| `WLAuthorizationPersistencePolicy` | 无替换。要实现授权持久性，请在应用程序代码中存储授权令牌并创建定制 HTTP 请求。有关更多信息，请参阅 [Java™ 定制资源请求实现样本](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.dev.doc/dev/c_custom_request_to_resource_java.html?view=kc#c_custom_request_to_resource_hybrid)。 | 
| {::nomarkdown}<ul><li><code>WLSimpleSharedData.setSharedToken(myName, myValue)</code></li><li><code>WLSimpleSharedData.getSharedToken(myName)</code></li><li><code>WLSimpleSharedData.clearSharedToken(myName)</code></li></ul>{:/} | 使用 Android API 在应用程序之间共享令牌。 |
| `WLUserCertificateManager.deleteCertificate(android.content.Context
context)` | 无替换 | 
| `BaseChallengeHandler.submitFailure(WLResponse wlResponse)` | 使用 [`BaseChallengeHandler.cancel()`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/wlclient/api/challengehandler/BaseChallengeHandler.html?view=kc)。 | 
| `ChallengeHandler` | 对于定制网关验证问题，请使用 [GatewayChallengeHandler](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/wlclient/api/challengehandler/GatewayChallengeHandler.html?view=kc)。对于 {{ site.data.keys.product_adj }} 安全性检查验证问题，请使用 [SecurityCheckChallengeHandler](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/wlclient/api/challengehandler/SecurityCheckChallengeHandler.html?view=kc)。| 
| `WLChallengeHandler` | 使用 [SecurityCheckChallengeHandler](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/wlclient/api/challengehandler/SecurityCheckChallengeHandler.html?view=kc)。 |
| `ChallengeHandler.isCustomResponse()` | 使用 [`GatewayChallengeHandler.canHandleResponse()`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/wlclient/api/challengehandler/GatewayChallengeHandler.html?view=kc)。 | 
| `ChallengeHandler.submitAdapterAuthentication ` | 在验证问题处理程序中实施类似逻辑。对于定制网关验证问题处理程序，请使用 [GatewayChallengeHandler](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/wlclient/api/challengehandler/GatewayChallengeHandler.html?view=kc)。| 

#### 取决于旧 `org.apach.http` API 的 Android API 不再受支持
{: #android-apis-depending-on-the-legacy-orgapachhttp-apis-are-no-longer-supported }

| API 元素 | 迁移路径 | 
|-------------|----------------|
| 现在不推荐使用 `org.apache.http.Header[]`。因此，移除了以下方法： | |
| `org.apache.http.Header[] WLResourceRequest.getAllHeaders()` | 改用新的 `Map<String, List<String>> WLResourceRequest.getAllHeaders()` API。 | 
| `WLResourceRequest.addHeader(org.apache.http.Header header)` | 改用新的 `WLResourceRequest.addHeader(String name, String value)` API。 | 
| `org.apache.http.Header[] WLResourceRequest.getHeaders(java.lang.String
headerName)` | 改用新的 `List<String> WLResourceRequest.getHeaders(String headerName)` API。 |
| `org.apache.http.Header WLResourceRequest.getFirstHeader(java.lang.String
headerName)` | 改用新的 `WLResourceRequest.getHeaders(String headerName)` API。 | 
| `WLResourceRequest.setHeaders(org.apache.http.Header[] headers)` | 改用新的 `WLResourceRequest.setHeaders(Map<String, List<String>> headerMap)` API。 | 
| `WLResourceRequest.setHeader(org.apache.http.Header header)` | 改用新的 `WLResourceRequest.setHeaders(Map<String, List<String>> headerMap)` API。 | 
| `org.apache.http.client.CookieStore WLClient.getCookieStore()` | 替换为 `java.net.CookieStore getCookieStore WLClient.getCookieStore()`<br/><br/> `java.net.CookieStore getCookieStore WLClient.getCookieStore()` |
| `WLClient.setAllowHTTPClientCircularRedirect(boolean isSet)` | 无替换。MFP 客户机允许循环重定向。 | 
| {::nomarkdown}<ul><li><code>WLHttpResponseListener</code></li><li><code>WLResourceRequest</code>，所有采用 <code>WLHttpResponseListener</code> 的方法：<ul><li><code>WLResourceRequest.send(java.util.HashMap
formParameters,WLHttpResponseListener listener)</code></li><li><code>WLResourceRequest.send(org.json.JSONObject json,
WLHttpResponseListener listener)</code></li><li><code>WLResourceRequest.send(byte[] data,
WLHttpResponseListener listener)</code></li><li><code>WLResourceRequest.send(java.lang.String
requestBody,WLHttpResponseListener listener)</code></li><li><code>WLResourceRequest.send(WLHttpResponseListener
listener)</code></li><li><code>WLClient.sendRequest(org.apache.http.client.methods.HttpUriRequest request,WLHttpResponseListener listener)</code></li><li><code>WLClient.sendRequest(org.apache.http.client.methods.HttpUriRequest request, WLResponseListener listener)</code></li></ul></li></ul>{:/} | 由于不推荐使用 Apache HTTP 客户机依赖关系而已移除。创建自己的请求，以对请求和响应具有完全控制。 |




