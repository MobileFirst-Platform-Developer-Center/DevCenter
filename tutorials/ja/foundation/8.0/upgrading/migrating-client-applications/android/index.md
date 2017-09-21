---
layout: tutorial
title: 既存の Android アプリケーションのマイグレーション
breadcrumb_title: Android
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
IBM MobileFirst Platform Foundation バージョン 6.2.0 以降で作成された既存のネイティブ Android プロジェクトをマイグレーションするには、現行バージョンの SDK を使用するようにプロジェクトを変更する必要があります。次に、v8.0 で使用が中止された、または v8.0 に含まれていないクライアント・サイド API を置き換えます。マイグレーション・アシスト・ツールはコードをスキャンし、置き換える API のレポートを生成できます。

#### ジャンプ先
{: #jump-to }
* [バージョンアップの前準備として既存の{{ site.data.keys.product_adj }} ネイティブ Android アプリケーションをスキャン](#scanning-existing-mobilefirst-native-android-apps-to-prepare-for-a-version-upgrade)
* [Gradle を使用した Android プロジェクトのマイグレーション](#migrating-an-android-project-with-gradle)
* [Android コードの更新](#updating-the-android-code)

## バージョンアップの前準備として既存の {{ site.data.keys.product_adj }} ネイティブ Android アプリケーションをスキャン
{: #scanning-existing-mobilefirst-native-android-apps-to-prepare-for-a-version-upgrade }
マイグレーション・アシスト・ツールは、ネイティブ Android アプリケーションのソースをスキャンし、V8.0 で非推奨または使用中止となった API のレポートを生成することにより、{{ site.data.keys.product_full }} の以前のバージョンで作成されたアプリケーションのマイグレーションの準備を支援します。

マイグレーション・アシスト・ツールを使用する前に、以下の情報を知っておくことが重要です。

* 既存の {{ site.data.keys.product }} ネイティブ・アプリケーションがある必要があります。
* インターネット・アクセスが必要です。
* node.js バージョン 4.0.0 以降がインストールされている必要があります。
* マイグレーション・プロセスの制限についてよく読み、理解します。詳しくは、[以前のリリースからのアプリケーションのマイグレーション](../)を参照してください。

以前のバージョンの {{ site.data.keys.product }} で作成されたアプリケーションは、一部変更を行わないと V8.0 ではサポートされません。マイグレーション・アシスト・ツールは、既存のアプリケーションのソース・ファイルをスキャンすることによりこのプロセスを簡素化し、V8.0 で非推奨となった API、非サポート対象となった API、または変更された API を識別します。

マイグレーション・アシスト・ツールでは、アプリケーションの開発者コードおよびコメントの変更や移動は行いません。

1. 以下のいずれかの方法を使用してマイグレーション・アシスト・ツールをダウンロードします。
    * [Git リポジトリー](https://git.ng.bluemix.net/ibmmfpf/mfpmigrate-cli)から .tgz ファイルをダウンロードします。
    * {{ site.data.keys.mf_console }} から {{ site.data.keys.mf_dev_kit }} をダウンロードします。これには、mfpmigrate-cli.tgz という名前のファイルとしてマイグレーション・アシスト・ツールが含まれています。
2. マイグレーション・アシスト・ツールをインストールします。
    * ツールをダウンロードしたディレクトリーに移動します。
    * 以下のコマンドを入力することにより、NPM を使用してツールをインストールします。

   ```bash
npm install -g```

3. 以下のコマンドを入力して、{{ site.data.keys.product }} アプリケーションをスキャンします。

   ```bash
   mfpmigrate scan --in source_directory --out destination_directory --type android
   ```

   **source_directory**  
プロジェクトの現在のロケーション。

   **destination_directory**  
レポートが作成されるディレクトリー。

   マイグレーション・アシスト・ツールを scan コマンドと共に使用した場合、このツールは、既存の {{ site.data.keys.product }} アプリケーション内にある、V8.0 で削除された API、非推奨となった API、または変更された API を識別し、識別された宛先ディレクトリーにそれらを保存します。

## Gradle を使用した Android プロジェクトのマイグレーション
{: #migrating-an-android-project-with-gradle }
Gradle を使用して、{{ site.data.keys.product_adj }} SDK が追加された Android アプリケーションをマイグレーションします。

Android Studio および Android SDK が適切にセットアップされていることを確認します。システムのセットアップ方法について詳しくは、[Android Studio 概要](http://developer.android.com/tools/studio/index.html)を参照してください。プロジェクトは、Android Studio/Gradle セットアップに準拠していて、{{ site.data.keys.product }} にアップグレードする前にエラーなしでコンパイルされる必要があります。

> **注:** このタスクでは、Android プロジェクトが Android Studio を使用して作成されていること、および [Android Studio (7.1) の使用による新規アプリケーションまたは既存アプリケーションへの {{ site.data.keys.product }} SDK の追加](https://www.ibm.com/support/knowledgecenter/SSHS8R_7.1.0/com.ibm.worklight.dev.doc/dev/t_dev_new_w_gradle.html)で述べられているように、{{ site.data.keys.product_adj }} SDK が追加されていることを想定しています。

Android Studio プロジェクトが、{{ site.data.keys.product_adj }} SDK の以前のバージョンを追加するようにセットアップされている場合は、**build.gradle** 依存関係エンクロージャーから **compile** グループを削除します。例えば、7.1 からアップグレードする場合は、以下のグループを削除します。

```xml
compile group: 'com.ibm.mobile.foundation',
            name:'ibmmobilefirstplatformfoundation',
            version:'7.1.0.0',
            ext: 'aar',
            transitive: true
```

これで、ローカルまたはリモートの SDK ファイルを使用して V8.0.0 の SDK と構成を追加できるようになりました。[Android アプリケーションへの {{ site.data.keys.product_adj }} SDK の追加](../../../application-development/sdk/android)を参照してください。

> 注: 新しい SDK をインポートした後は、Javadoc ファイルを手動でインポートする必要があります。『[Android Studio Gradle プロジェクトへの Javadoc の登録](../../../application-development/sdk/android/additional-information)』を参照してください。

これで、{{ site.data.keys.product_adj }} SDK を使用してネイティブ Android アプリケーションの開発を始めることができます。V8.0.0 での API の変更にコードを適合させる必要がある場合があります ([Android コードの更新](#updating-the-android-code)を参照)。

#### 次の作業
{: #what-to-do-next }
使用が中止された、または V8.0 に含まれていないクライアント・サイド API を置き換えます。

## Android コードの更新
{: #updating-the-android-code }
{{ site.data.keys.product_full }} V8.0 では、Android SDK に対する多くの変更が導入されています。これにより、以前のバージョンで開発されたアプリケーションの変更が必要になる可能性があります。  
以下の表では、{{ site.data.keys.product_adj }} Android SDK の変更をリストします。

#### 使用が中止された Android API エレメント
{: #discontinued-android-api-elements }

| API エレメント| マイグレーション・パス|
|-------------|----------------|
| `WLConfig WLClient.getConfig()`| 代替はありません。|
| {::nomarkdown}<ul><li><code>WLDevice WLClient.getWLDevice()</code></li><li><code>WLClient.transmitEvent(org.json.JSONObject event) </code></li><li><code>WLClient.setEventTransmissionPolicy(WLEventTransmissionPolicy policy) </code></li><li><code>WLClient.purgeEventTransmissionBuffer() </code></li></ul>{:/} | GeoLocation 用の Android API またはサード・パーティー・パッケージを使用してください。|
| {::nomarkdown}<ul><li><code>WL.Client.getUserInfo(realm, key)</code></li><li><code>WL.Client.updateUserInfo(options)</code></li></ul>{:/} | 代替はありません。|
| {::nomarkdown}<ul><li><code>WL.Client.getUserInfo(realm, key</code></li><li><code>WL.Client.updateUserInfo(options)</code></li></ul>{:/} | 代替はありません。|
| `WLClient.checkForNotifications()` | [`WLAuthorizationManager.obtainAccessToken("", listener)`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/wlclient/api/WLAuthorizationManager.html?view=kc#obtainAccessToken(java.lang.String,%20com.worklight.wlclient.api.WLAccessTokenListener)) を使用して、サーバーへの接続を確認し、アプリケーション管理ルールを適用してください。|
| {::nomarkdown}<ul><li><code>WLClient.login(java.lang.String realmName, WLRequestListener listener, WLRequestOptions options)</code></li><li><code>WLClient.login(java.lang.String realmName, WLRequestListener listener)</code></li></ul>{:/} | [`AuthorizationManager.login()`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/wlclient/api/WLAuthorizationManager.html?view=kc#login(java.lang.String,%20org.json.JSONObject,%20com.worklight.wlclient.api.WLLoginResponseListener))を使用します。|
| {::nomarkdown}<ul><li><code>WLClient.logout(java.lang.String realmName, WLRequestListener listener, WLRequestOptions options)</code></li><li><code>WLClient.logout(java.lang.String realmName, WLRequestListener listener)</code></li></ul>{:/} | [`AuthorizationManager.logout()`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/wlclient/api/WLAuthorizationManager.html?view=kc#logout(java.lang.String,%20com.worklight.wlclient.api.WLLogoutResponseListener))を使用します。|
| `WLClient.obtainAccessToken(java.lang.String scope,WLResponseListener responseListener)` | [`WLAuthorizationManager.obtainAccessToken(String, WLAccessTokenListener)`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/wlclient/api/WLAuthorizationManager.html?view=kc#obtainAccessToken(java.lang.String,%20com.worklight.wlclient.api.WLAccessTokenListener)) を使用して、サーバーへの接続を確認し、アプリケーション管理ルールを適用してください。|
| {::nomarkdown}<ul><li><code>WLClient.getLastAccessToken()</code></li><li><code>WLClient.getLastAccessToken(java.lang.String scope) </code></li></ul>{:/} | [`AuthorizationManager`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/wlclient/api/WLAuthorizationManager.html?view=kc)を使用してください。|
| `WLClient.getRequiredAccessTokenScope(int status, java.lang.String header)` | [`AuthorizationManager`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/wlclient/api/WLAuthorizationManager.html?view=kc)を使用してください。|
| `WLClient.logActivity(java.lang.String activityType)` | [`com.worklight.common.Logger`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/common/Logger.html?view=kc) を使用してください。|
| `WLAuthorizationPersistencePolicy` | 代替はありません。許可パーシスタンスを実装するには、許可トークンをアプリケーション・コードに保管し、カスタム HTTP 要求を作成します。詳しくは、[Java™ カスタム・リソース要求実装サンプル](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.dev.doc/dev/c_custom_request_to_resource_java.html?view=kc#c_custom_request_to_resource_hybrid)を参照してください。|
| {::nomarkdown}<ul><li><code>WLSimpleSharedData.setSharedToken(myName, myValue)</code></li><li><code>WLSimpleSharedData.getSharedToken(myName)</code></li><li><code>WLSimpleSharedData.clearSharedToken(myName)</code></li></ul>{:/} | Android API を使用して、アプリケーション間でトークンを共有してください。|
| `WLUserCertificateManager.deleteCertificate(android.content.Context context)` | 代替はありません。|
| `BaseChallengeHandler.submitFailure(WLResponse wlResponse)` | [`BaseChallengeHandler.cancel()`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/wlclient/api/challengehandler/BaseChallengeHandler.html?view=kc) を使用します。|
| `ChallengeHandler` | カスタム・ゲートウェイ・チャレンジには、[GatewayChallengeHandler](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/wlclient/api/challengehandler/GatewayChallengeHandler.html?view=kc) を使用します。{{ site.data.keys.product_adj }} セキュリティー検査チャレンジには、[SecurityCheckChallengeHandler](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/wlclient/api/challengehandler/SecurityCheckChallengeHandler.html?view=kc) を使用します。|
| `WLChallengeHandler` | [SecurityCheckChallengeHandler](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/wlclient/api/challengehandler/SecurityCheckChallengeHandler.html?view=kc) を使用します。|
| `ChallengeHandler.isCustomResponse()` | [`GatewayChallengeHandler.canHandleResponse()`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/wlclient/api/challengehandler/GatewayChallengeHandler.html?view=kc) を使用します。|
| `ChallengeHandler.submitAdapterAuthentication` | チャレンジ・ハンドラーで同様のロジックを実装してください。カスタム・ゲートウェイ・チャレンジ・ハンドラーには、[GatewayChallengeHandler](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/wlclient/api/challengehandler/GatewayChallengeHandler.html?view=kc) を使用します。|

#### サポートされなくなった、レガシー `org.apach.http` API に依存している Android API
{: #android-apis-depending-on-the-legacy-orgapachhttp-apis-are-no-longer-supported }

| API エレメント| マイグレーション・パス|
|-------------|----------------|
| `org.apache.http.Header[]` は非推奨になっています。そのため、以下のメソッドは削除されました。| |
| `org.apache.http.Header[] WLResourceRequest.getAllHeaders()` | 代わりに、新しい `Map<String, List<String>> WLResourceRequest.getAllHeaders()` API を使用してください。|
| `WLResourceRequest.addHeader(org.apache.http.Header header)` | 代わりに、新しい `WLResourceRequest.addHeader(String name, String value)` API を使用してください。|
| `org.apache.http.Header[] WLResourceRequest.getHeaders(java.lang.String headerName)` | 代わりに、新しい `List<String> WLResourceRequest.getHeaders(String headerName)` API を使用してください。|
| `org.apache.http.Header WLResourceRequest.getFirstHeader(java.lang.String headerName)` | 代わりに、新しい `WLResourceRequest.getHeaders(String headerName)` API を使用してください。|
| `WLResourceRequest.setHeaders(org.apache.http.Header[] headers)` | 代わりに、新しい `WLResourceRequest.setHeaders(Map<String, List<String>> headerMap)` API を使用してください。|
| `WLResourceRequest.setHeader(org.apache.http.Header header)` | 代わりに、新しい `WLResourceRequest.setHeaders(Map<String, List<String>> headerMap)` API を使用してください。|
| `org.apache.http.client.CookieStore WLClient.getCookieStore()` | `java.net.CookieStore getCookieStore WLClient.getCookieStore()` と置き換えられました。<br/><br/> `java.net.CookieStore getCookieStore WLClient.getCookieStore()` |
| `WLClient.setAllowHTTPClientCircularRedirect(boolean isSet)` | 代替はありません。MFP クライアントでは、サーキュラー・リダイレクトが許可されます。|
| {::nomarkdown}<ul><li><code>WLHttpResponseListener</code></li><li><code>WLResourceRequest</code>、<code>WLHttpResponseListener</code> を取る以下のすべてのメソッド: <ul><li><code>WLResourceRequest.send(java.util.HashMap formParameters,WLHttpResponseListener listener)</code></li><li><code>WLResourceRequest.send(org.json.JSONObject json, WLHttpResponseListener listener)</code></li><li><code>WLResourceRequest.send(byte[] data, WLHttpResponseListener listener)</code></li><li><code>WLResourceRequest.send(java.lang.String requestBody,WLHttpResponseListener listener)</code></li><li><code>WLResourceRequest.send(WLHttpResponseListener listener)</code></li><li><code>WLClient.sendRequest(org.apache.http.client.methods.HttpUriRequest request,WLHttpResponseListener listener)</code></li><li><code>WLClient.sendRequest(org.apache.http.client.methods.HttpUriRequest request, WLResponseListener listener)</code></li></ul></li></ul>{:/} | 非推奨になった Apache HTTP クライアント依存関係のために削除されました。要求および応答を完全に制御できる独自の要求を作成してください。|
