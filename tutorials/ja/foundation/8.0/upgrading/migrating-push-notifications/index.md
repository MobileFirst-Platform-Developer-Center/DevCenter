---
layout: tutorial
title: イベント・ソース・ベース通知からのプッシュ通知のマイグレーション
breadcrumb_title: プッシュ通知のマイグレーション
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
{{ site.data.keys.product_full }} v8.0 から、イベント・ソース・ベースのモデルはサポートされず、プッシュ通知機能は全面的にプッシュ・サービス・モデルによって使用可能になっています。以前のバージョンの {{ site.data.keys.product_adj }} における既存のイベント・ソース・ベースのアプリケーションを v8.0 に移行する場合は、それらのアプリケーションを新しいプッシュ・サービス・モデルにマイグレーションする必要があります。

マイグレーション時には、これは、使用する API を別のものに変更するということではなく、むしろ、使用するモデル/アプローチを別のものに変更するということである点に留意してください。

例えば、イベント・ソース・ベースのモデルでは、通知を特定のセグメントに送信するためにモバイル・アプリケーション・ユーザーをセグメント化する場合、各セグメントを固有のイベント・ソースとしてモデル化します。プッシュ・サービス・モデルでは、同じことを実現するために、セグメントを表すタグを定義し、ユーザーが各タグをサブスクライブするようにします。タグ・ベースの通知は、イベント・ソース・ベースの通知を置き換えるものです。

#### ジャンプ先
{: #jump-to }
* [マイグレーション・シナリオ](#migration-scenarios)
* [マイグレーション・ツール](#migration-tool)

<br/>

次の表に、2 つのモデル間の比較を示します。

| ユーザー要件| イベント・ソース・モデル| プッシュ・サービス・モデル|
|------------------|--------------------|--------------------|
| アプリケーションでプッシュ通知を使用可能にするには| {::nomarkdown}<ul><li>イベント・ソース・アダプターを作成し、その中で EventSource を作成します。</li><li>プッシュ資格情報を使用してアプリケーションを構成またはセットアップします。</li></ul>{:/} | プッシュ資格情報を使用してアプリケーションを構成またはセットアップします。|
| モバイル・クライアント・アプリケーションでプッシュ通知を使用可能にするには| {::nomarkdown}<ul><li>WLClient を作成します。</li><li>{{ site.data.keys.mf_server }} に接続します。</li><li>プッシュ・クライアントのインスタンスを取得します。</li><li>イベント・ソースにサブスクライブします。</li></ul>{:/} | {::nomarkdown}<ul><li>プッシュ・クライアントのインスタンスを生成します。</li><li>プッシュ・クライアントを初期化します。</li><li>モバイル・デバイスを登録します。</li></ul>{:/} |
| モバイル・クライアント・アプリケーションで特定のタグに基づいた通知を使用可能にするには| サポートされません。| 対象のタグ (タグ名を使用) をサブスクライブします。|
| モバイル・クライアント・アプリケーションで通知を受け取って処理するには| リスナー実装を登録します。| リスナー実装を登録します。|
| プッシュ通知をモバイル・クライアント・アプリケーションに送信するには| {::nomarkdown}<ul><li>WL.Server API を内部的に呼び出してプッシュ通知を送信する、アダプター・プロシージャーを実装します。</li><li>WL サーバー API は、以下のように通知を送信する手段を提供します。<ul><li>ユーザー別</li><li>デバイス別</li><li><li>ブロードキャスト (すべてのデバイス)</li></ul></li><li>その後、バックエンド・サーバー・アプリケーションは、アダプター・プロシージャーを呼び出して、アプリケーション・ロジックの一部としてプッシュ通知をトリガーできます。</li></ul>{:/} | {::nomarkdown}<ul><li>バックエンド・サーバー・アプリケーションは、メッセージ REST API を直接呼び出すことができます。ただし、そのようなアプリケーションは、{{ site.data.keys.mf_server }} に機密クライアントとして登録し、有効な OAuth アクセス・トークンを取得し、それを REST API の許可ヘッダーで渡す必要があります。</li><li>REST API は、以下のように通知を送信するオプションを備えています。<ul><li>ユーザー別</li><li>デバイス別</li><li>プラットフォーム別</li><li>タグ別</li><li>ブロードキャスト (すべてのデバイス)</li></ul></li></ul>{:/} |
| 定期的な期間 (ポーリング間隔) でプッシュ通知をトリガーするには|  イベント・ソース・アダプター内にプッシュ通知を送信する関数を実装し、これを createEventSource 関数呼び出しの一部として実装します。| サポートされません。|
| フックを名前、URL、およびイベント・タイプで登録するには| プッシュ通知をサブスクライブまたはアンサブスクライブするデバイスのパスに、フックを実装します。| サポートされません。|

## マイグレーション・シナリオ
{: #migration-scenarios }
{{ site.data.keys.product }} v8.0 以降、イベント・ソース・ベースのモデルはサポートされなくなり、プッシュ通知機能は全面的にプッシュ・サービス・モデルによって {{ site.data.keys.product }} で使用可能になります。このモデルは、イベント・ソース・モデルよりもシンプルでアジャイルな代替モデルです。

以前のバージョンの IBM MobileFirst Platform Foundation における既存のイベント・ソース・ベースのアプリケーションは、v8.0 の新しいプッシュ・サービス・モデルにマイグレーションする必要があります。

#### ジャンプ先のセクション
{: #jump-to-section }
* [ハイブリッド・アプリケーション](#hybrid-applications)
* [ネイティブ Android アプリケーション](#native-android-applications)
* [ネイティブ iOS アプリケーション](#native-ios-applications)
* [ネイティブ Windows ユニバーサル・アプリケーション](#native-windows-universal-applications)

### ハイブリッド・アプリケーション
{: #hybrid-applications }
マイグレーション・シナリオ例では、単一のイベント・ソースまたは複数のイベント・ソース、ブロードキャスト通知またはユニキャスト通知、あるいはタグ通知を使用するアプリケーションを扱っています。

#### シナリオ 1: アプリケーションで単一のイベント・ソースを使用する既存のアプリケーション
{: #hybrid-scenario-1-existing-applications-using-single-event-source-in-their-application }
以前のバージョンの {{ site.data.keys.product_adj }} では、イベント・ソース・ベースのモデルを使用したプッシュのみがサポートされていたため、アプリケーションは単一のイベント・ソースを使用していました。

##### クライアント
{: #client-hybrid-1 }
V8.0.0 にこれをマイグレーションするには、このモデルをユニキャスト通知に変換します。

1. 以下のように、アプリケーションで {{ site.data.keys.product_adj }} プッシュ・クライアント・インスタンスを初期化し、成功コールバックで、通知を受け取る必要があるコールバック・メソッドを登録します。

   ```javascript
   MFPPush.initialize(function(successResponse){
   MFPPush.registerNotificationsCallback(notificationReceived); },
   function(failureResponse){alert("Failed to initialize");    
                              }  
   );
   ```

2. 通知コールバック・メソッドを実装します。

   ```javascript
var notificationReceived = function(message) {
alert(JSON.stringify(message));
   };
   ```

3. モバイル・デバイスをプッシュ通知サービスに登録します。

   ```javascript
MFPPush.registerDevice(function(successResponse) {
alert("Successfully registered");
	    },
	  function(failureResponse) {
		alert("Failed to register");
	    }
   );
   ```

4. (オプション) モバイル・デバイスをプッシュ通知サービスから登録抹消します。

   ```javascript
MFPPush.unregisterDevice(function(successResponse) {
alert("Successfully unregistered");
	    },
	  function(failureResponse) {
		alert("Failed to unregister");
	    }
   );
   ```

5. WL.Client.Push.isPushSupported() を削除し (使用されている場合)、以下を使用します。

   ```javascript
MFPPush.isPushSupported (function(successResponse) {
alert(successResponse);
	   },
	   function(failureResponse) {
	       alert("Failed to get the push suport status");
	   }
   );
   ```

6. サブスクライブ対象のイベント・ソースがないため、以下の `WL.Client.Push` API を削除し、通知コールバックを登録します。
    * `registerEventSourceCallback()`
    * `subscribe()`
    * `unsubscribe()`
    * `isSubscribed()`
    * `onReadyToSubscribe()`

##### サーバー
{: #server-hybrid-1 }
1. アダプターで以下の WL.Server API を削除します (使用されている場合)。
    * `notifyAllDevices()`
    * `notifyDevice()`
    * `notifyDeviceSubscription()`
    * `createEventSource()`
2. 同じイベント・ソースを使用していた各アプリケーションに対して、以下のステップを実行します。
    1. {{ site.data.keys.mf_console }} を使用して資格情報をセットアップします。『[プッシュ通知設定の構成 (Configuring push notification settings)](../../notifications/sending-notifications)』を参照してください。

        [Update GCM settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_gcm_settings_put.html?view=kc#Update-GCM-settings--PUT-) REST API (Android アプリケーションの場合) または [Update APNs settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_apns_settings_put.html?view=kc#Update-APNs-settings--PUT-) REST API (iOS アプリケーションの場合) を使用して、資格情報をセットアップすることもできます。
    2. **「スコープ・エレメントのマッピング (Scope Elements Mapping)」**でスコープ `push.mobileclient` を追加します。
    3. プッシュ通知をサブスクライバーに送信できるようにするタグを作成します。プッシュ通知のための[タグの定義](../../notifications/sending-notifications/#defining-tags)を参照してください。
    4. 以下の方法のいずれかを使用して通知を送信できます。
        * {{ site.data.keys.mf_console }}。『[サブスクライバーへのプッシュ通知の送信 (Sending push notifications to subscribers)](../../notifications/sending-notifications/#sending-notifications)』を参照してください。
        * `userId`/`deviceId` を使用した [Push Message (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) REST API。

#### シナリオ 2: アプリケーションで複数のイベント・ソースを使用する既存のアプリケーション
{: #hybrid-scenario-2-existing-applications-using-multiple-event-sources-in-their-application }
複数のイベント・ソースを使用するアプリケーションでは、サブスクリプションに基づいてユーザーをセグメント化する必要があります。

##### クライアント
{: #client-hybrid-2 }
これは、対象トピックに基づいてユーザー/デバイスをセグメント化するタグにマップされます。これをマイグレーションするために、このモデルをタグ・ベースの通知に変換できます。

1. 以下のように、アプリケーションで MFPPush クライアント・インスタンスを初期化し、成功コールバックで、通知を受け取る必要があるコールバック・メソッドを登録します。

   ```javascript
   MFPPush.initialize(function(successResponse){
		MFPPush.registerNotificationsCallback(notificationReceived);              					},
		function(failureResponse){
			alert("Failed to initialize");
		}
   );
   ```

2. 通知コールバック・メソッドを実装します。

   ```javascript
var notificationReceived = function(message) {
alert(JSON.stringify(message));
   };
   ```

3. モバイル・デバイスをプッシュ通知サービスに登録します。

   ```javascript
MFPPush.registerDevice(function(successResponse) {
alert("Successfully registered");
	    },
	  function(failureResponse) {
		alert("Failed to register");
	    }
   );
   ```

4. (オプション) モバイル・デバイスをプッシュ通知サービスから登録抹消します。

   ```javascript
MFPPush.unregisterDevice(function(successResponse) {
alert("Successfully unregistered");
	    },
	  function(failureResponse) {
		alert("Failed to unregister");
	    }
   );
   ```

5. `WL.Client.Push.isPushSupported()` を削除し (使用されている場合)、以下を使用します。

   ```javascript
MFPPush.isPushSupported (function(successResponse) {
alert(successResponse);
	   },
	   function(failureResponse) {
	       alert("Failed to get the push suport status");
	   }
   );
   ```

6. サブスクライブ対象のイベント・ソースがないため、以下の `WL.Client.Push` API を削除し、通知コールバックを登録します。
    * `registerEventSourceCallback()`
    * `subscribe()`
    * `unsubscribe()`
    * `isSubscribed()`
    * `onReadyToSubscribe()`

7. タグにサブスクライブします。

   ```javascript
   var tags = ['sample-tag1','sample-tag2'];
   MFPPush.subscribe(tags, function(successResponse) {
    	alert("Successfully subscribed");
        },
      function(failureResponse) {
    	alert("Failed to subscribe");
        }
   );
   ```

8. (オプション) タグからアンサブスクライブします。

   ```javascript
MFPPush.unsubscribe(tags, function(successResponse) {
alert("Successfully unsubscribed");
	    },
	  function(failureResponse) {
		alert("Failed to unsubscribe");
	    }
   );
   ```

##### サーバー
{: #server-hybrid-2 }
アダプターで以下の `WL.Server` API (使用されている場合) を削除します。

* `notifyAllDevices()`
* `notifyDevice()`
* `notifyDeviceSubscription()`
* `createEventSource()`

同じイベント・ソースを使用していた各アプリケーションに対して、以下のステップを実行します。

1. {{ site.data.keys.mf_console }} を使用して資格情報をセットアップします。『[プッシュ通知設定の構成 (Configuring push notification settings)](../../notifications/sending-notifications)』を参照してください。

    [Update GCM settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_gcm_settings_put.html?view=kc#Update-GCM-settings--PUT-) REST API (Android アプリケーションの場合) または [Update APNs settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_apns_settings_put.html?view=kc#Update-APNs-settings--PUT-) REST API (iOS アプリケーションの場合) を使用して、資格情報をセットアップすることもできます。
2. **「スコープ・エレメントのマッピング (Scope Elements Mapping)」**でスコープ `push.mobileclient` を追加します。
3. プッシュ通知をサブスクライバーに送信できるようにするタグを作成します。プッシュ通知のための[タグの定義](../../notifications/sending-notifications/#defining-tags)を参照してください。
4. 以下の方法のいずれかを使用して通知を送信できます。
    * {{ site.data.keys.mf_console }}。『[サブスクライバーへのプッシュ通知の送信 (Sending push notifications to subscribers)](../../notifications/sending-notifications/#sending-notifications)』を参照してください。
    * `userId`/`deviceId` を使用した [Push Message (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) REST API。

#### シナリオ 3: アプリケーションでブロードキャスト/ユニキャスト通知を使用する既存のアプリケーション
{: #hybrid-scenario-3-existing-applications-using-broadcast-unicast-notification-in-their-application }
##### クライアント
{: #client-hybrid-3 }
1. 以下のように、アプリケーションで MFPPush クライアント・インスタンスを初期化し、成功コールバックで、通知を受け取る必要があるコールバック・メソッドを登録します。

   ```javascript
   MFPPush.initialize(function(successResponse){
		MFPPush.registerNotificationsCallback(notificationReceived);              					},
		function(failureResponse){
			alert("Failed to initialize");
		}
   );
   ```

2. 通知コールバック・メソッドを実装します。

   ```javascript
var notificationReceived = function(message) {
alert(JSON.stringify(message));
   };
   ```

3. モバイル・デバイスをプッシュ通知サービスに登録します。

   ```javascript
MFPPush.registerDevice(function(successResponse) {
alert("Successfully registered");
	    },
	  function(failureResponse) {
		alert("Failed to register");
	    }
   );
   ```

4. (オプション) モバイル・デバイスをプッシュ通知サービスから登録抹消します。

   ```javascript
MFPPush.unregisterDevice(function(successResponse) {
alert("Successfully unregistered");
	    },
	  function(failureResponse) {
		alert("Failed to unregister");
	    }
   );
   ```

5. WL.Client.Push.isPushSupported() を削除し (使用されている場合)、以下を使用します。

   ```javascript
MFPPush.isPushSupported (function(successResponse) {
alert(successResponse);
	   },
	   function(failureResponse) {
	       alert("Failed to get the push suport status");
	   }
   );
   ```

6. 以下の `WL.Client.Push` API を削除します。
    * `onReadyToSubscribe()`
    * `onMessage()`

##### サーバー
{: #server-hybrid-3 }
アダプターで `WL.Server.sendMessage()` (使用されている場合) を削除します。  
同じイベント・ソースを使用していた各アプリケーションに対して、以下のステップを実行します。

1. {{ site.data.keys.mf_console }} を使用して資格情報をセットアップします。『[プッシュ通知設定の構成 (Configuring push notification settings)](../../notifications/sending-notifications)』を参照してください。

    [Update GCM settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_gcm_settings_put.html?view=kc#Update-GCM-settings--PUT-) REST API (Android アプリケーションの場合) または [Update APNs settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_apns_settings_put.html?view=kc#Update-APNs-settings--PUT-) REST API (iOS アプリケーションの場合) を使用して、資格情報をセットアップすることもできます。
2. **「スコープ・エレメントのマッピング (Scope Elements Mapping)」**でスコープ `push.mobileclient` を追加します。
3. プッシュ通知をサブスクライバーに送信できるようにするタグを作成します。プッシュ通知のための[タグの定義](../../notifications/sending-notifications/#defining-tags)を参照してください。
4. 以下の方法のいずれかを使用して通知を送信できます。
    * {{ site.data.keys.mf_console }}。『[サブスクライバーへのプッシュ通知の送信 (Sending push notifications to subscribers)](../../notifications/sending-notifications/#sending-notifications)』を参照してください。
    * `userId`/`deviceId` を使用した [Push Message (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) REST API。

#### シナリオ 4: アプリケーションでタグ通知を使用する既存のアプリケーション
{: #hybrid-scenario-4-existing-applications-using-tag-notifications-in-their-application }
##### クライアント
{: #client-hybrid-4 }
1. 以下のように、アプリケーションで MFPPush クライアント・インスタンスを初期化し、成功コールバックで、通知を受け取る必要があるコールバック・メソッドを登録します。

   ```javascript
   MFPPush.initialize(function(successResponse){
		MFPPush.registerNotificationsCallback(notificationReceived);              					},
		function(failureResponse){
			alert("Failed to initialize");
		}
   );
   ```

2. 通知コールバック・メソッドを実装します。

   ```javascript
var notificationReceived = function(message) {
alert(JSON.stringify(message));
   };
   ```

3. モバイル・デバイスをプッシュ通知サービスに登録します。

   ```javascript
MFPPush.registerDevice(function(successResponse) {
alert("Successfully registered");
	    },
	  function(failureResponse) {
		alert("Failed to register");
	    }
   );
   ```

4. (オプション) モバイル・デバイスをプッシュ通知サービスから登録抹消します。

   ```javascript
MFPPush.unregisterDevice(function(successResponse) {
alert("Successfully unregistered");
	    },
	  function(failureResponse) {
		alert("Failed to unregister");
	    }
   );
   ```

5. `WL.Client.Push.isPushSupported()` を削除し (使用されている場合)、以下を使用します。

   ```javascript
MFPPush.isPushSupported (function(successResponse) {
alert(successResponse);
	   },
	   function(failureResponse) {
	       alert("Failed to get the push suport status");
	   }
   );
   ```

6. 以下の `WL.Client.Push` API を削除します。
    * `subscribeTag()`
    * `unsubscribeTag()`
    * `isTagSubscribed()`
    * `onReadyToSubscribe()`
    * `onMessage()`

7. 以下のように、タグにサブスクライブします。

   ```javascript
   var tags = ['sample-tag1','sample-tag2'];
   MFPPush.subscribe(tags, function(successResponse) {
    	alert("Successfully subscribed");
        },
      function(failureResponse) {
    	alert("Failed to subscribe");
        }
   );
   ```

8. (オプション) 以下のように、タグからアンサブスクライブします。

   ```javascript
MFPPush.unsubscribe(tags, function(successResponse) {
alert("Successfully unsubscribed");
	    },
	  function(failureResponse) {
		alert("Failed to unsubscribe");
	    }
   );
   ```

##### サーバー
{: #server-hybrid-4 }
アダプターで `WL.Server.sendMessage()` (使用されている場合) を削除します。  
同じイベント・ソースを使用していた各アプリケーションに対して、以下のステップを実行します。

1. {{ site.data.keys.mf_console }} を使用して資格情報をセットアップします。『[プッシュ通知設定の構成 (Configuring push notification settings)](../../notifications/sending-notifications)』を参照してください。

    [Update GCM settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_gcm_settings_put.html?view=kc#Update-GCM-settings--PUT-) REST API (Android アプリケーションの場合) または [Update APNs settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_apns_settings_put.html?view=kc#Update-APNs-settings--PUT-) REST API (iOS アプリケーションの場合) を使用して、資格情報をセットアップすることもできます。
2. **「スコープ・エレメントのマッピング (Scope Elements Mapping)」**でスコープ `push.mobileclient` を追加します。
3. プッシュ通知をサブスクライバーに送信できるようにするタグを作成します。プッシュ通知のための[タグの定義](../../notifications/sending-notifications/#defining-tags)を参照してください。
4. 以下の方法のいずれかを使用して通知を送信できます。
    * {{ site.data.keys.mf_console }}。『[サブスクライバーへのプッシュ通知の送信 (Sending push notifications to subscribers)](../../notifications/sending-notifications/#sending-notifications)』を参照してください。
    * `userId`/`deviceId` を使用した [Push Message (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) REST API。

### ネイティブ Android アプリケーション
{: #native-android-applications }
マイグレーション・シナリオ例では、単一のイベント・ソースまたは複数のイベント・ソース、ブロードキャスト通知またはユニキャスト通知、あるいはタグ通知を使用するアプリケーションを扱っています。

#### シナリオ 1: アプリケーションで単一のイベント・ソースを使用する既存のアプリケーション
{: #android-scenario-1-existing-applications-using-single-event-source-in-their-application }
以前のバージョンの MobileFirst では、イベント・ソース・ベースのモデルを使用したプッシュのみがサポートされていたため、アプリケーションは単一のイベント・ソースを使用していました。

##### クライアント
{: #client-android-1 }
v8.0 にこれをマイグレーションするには、このモデルをユニキャスト通知に変換します。

1. アプリケーションで MFPPush クライアント・インスタンスを初期化します。

   ```java
   MFPPush push = MFPPush.getInstance();
        push.initialize(_this);
   ```

2. インターフェース MFPPushNotificationListener を実装し、onReceive() を定義します。

   ```java
   @Override
   public void onReceive(MFPSimplePushNotification message) {
        Log.i("Push Notifications", message.getAlert());
   }
   ```

3. モバイル・デバイスをプッシュ通知サービスに登録します。

   ```java
   push.registerDevice(new MFPPushResponseListener<String>(){
        @Override
        public void onFailure(MFPPushException arg0) {
            Log.i("Push Notifications", "Failed to register");
	    }
        @Override
        public void onSuccess(String arg0) {
           Log.i("Push Notifications", "Registered successfully");

        }
   });
   ```

4. (オプション) モバイル・デバイスをプッシュ通知サービスから登録抹消します。

   ```java
   push.unregisterDevice(new MFPPushResponseListener<String>(){
        @Override
        public void onFailure(MFPPushException arg0) {
            Log.i("Push Notifications", "Failed to unregister");

        }
        @Override
        public void onSuccess(String arg0) {
             Log.i("Push Notifications", "Unregistered successfully");
        }
   });
   ```

5. `WLClient.Push.isPushSupported()` (使用されている場合) を削除し、`push.isPushSupported();` を使用します。
6. サブスクライブ対象のイベント・ソースがないため、以下の `WLClient.Push` API を削除し、通知コールバックを登録します。
    * `registerEventSourceCallback()`
    * `subscribe()`
    * `unsubscribe()`
    * `isSubscribed()`
    * `WLOnReadyToSubscribeListener` および `WLNotificationListener` 実装

##### サーバー
{: #server-android-1 }
アダプターで以下の `WL.Server` API (使用されている場合) を削除します。

* `notifyAllDevices()`
* `notifyDevice()`
* `notifyDeviceSubscription()`
* `createEventSource()`

同じイベント・ソースを使用していた各アプリケーションに対して、以下のステップを実行します。

1. {{ site.data.keys.mf_console }} を使用して資格情報をセットアップします。『[プッシュ通知設定の構成 (Configuring push notification settings)](../../notifications/sending-notifications)』を参照してください。

    [Update GCM settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_gcm_settings_put.html?view=kc#Update-GCM-settings--PUT-) REST API (Android アプリケーションの場合) または [Update APNs settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_apns_settings_put.html?view=kc#Update-APNs-settings--PUT-) REST API (iOS アプリケーションの場合) を使用して、資格情報をセットアップすることもできます。
2. **「スコープ・エレメントのマッピング (Scope Elements Mapping)」**でスコープ `push.mobileclient` を追加します。
3. プッシュ通知をサブスクライバーに送信できるようにするタグを作成します。プッシュ通知のための[タグの定義](../../notifications/sending-notifications/#defining-tags)を参照してください。
4. 以下の方法のいずれかを使用して通知を送信できます。
    * {{ site.data.keys.mf_console }}。『[サブスクライバーへのプッシュ通知の送信 (Sending push notifications to subscribers)](../../notifications/sending-notifications/#sending-notifications)』を参照してください。
    * `userId`/`deviceId` を使用した [Push Message (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) REST API。

#### シナリオ 2: アプリケーションで複数のイベント・ソースを使用する既存のアプリケーション
{: #android-scenario-2-existing-applications-using-multiple-event-sources-in-their-application }
複数のイベント・ソースを使用するアプリケーションでは、サブスクリプションに基づいてユーザーをセグメント化する必要があります。

##### クライアント
{: #client-android-2 }
これは、対象トピックに基づいてユーザー/デバイスをセグメント化するタグにマップされます。{{ site.data.keys.product }} V8.0.0 にこれをマイグレーションするには、このモデルをタグ・ベースの通知に変換します。

1. 以下のように、アプリケーションで `MFPPush` クライアント・インスタンスを初期化します。

   ```java
   MFPPush push = MFPPush.getInstance();
        push.initialize(_this);
   ```

2. インターフェース MFPPushNotificationListener を実装し、onReceive() を定義します。

   ```java
   @Override
   public void onReceive(MFPSimplePushNotification message) {
        Log.i("Push Notifications", message.getAlert());
   }
   ```

3. モバイル・デバイスをプッシュ通知サービスに登録します。

   ```java
   push.registerDevice(new MFPPushResponseListener<String>(){
        @Override
        public void onFailure(MFPPushException arg0) {
            Log.i("Push Notifications", "Failed to register");
	    }
        @Override
        public void onSuccess(String arg0) {
            Log.i("Push Notifications", "Registered successfully");
        }
   });
   ```

4. (オプション) 次のように、モバイル・デバイスをプッシュ通知サービスから登録抹消します。

   ```java
   push.unregisterDevice(new MFPPushResponseListener<String>(){
        @Override
        public void onFailure(MFPPushException arg0) {
            Log.i("Push Notifications", "Failed to unregister");

        }
        @Override
        public void onSuccess(String arg0) {
             Log.i("Push Notifications", "Unregistered successfully");
        }
   });
   ```

5. `WLClient.Push.isPushSupported()` (使用されている場合) を削除し、`push.isPushSupported();` を使用します。
6. サブスクライブ対象のイベント・ソースがないため、以下の `WLClient.Push` API を削除し、通知コールバックを登録します。
    * `registerEventSourceCallback()`
    * `subscribe()`
    * `unsubscribe()`
    * `isSubscribed()`

7. `WLOnReadyToSubscribeListener` および `WLNotificationListener` の実装
8. 以下のように、タグにサブスクライブします。

   ```java
   String[] tags = new String[2];
   tags[0] ="sample-tag1";
   tags[1] ="sample-tag2";
   push.subscribe(tags, new MFPPushResponseListener<String[]>(){

        @Override
        public void onFailure(MFPPushException arg0) {
            Log.i("Failed to subscribe");
        }

        @Override
        public void onSuccess(String[] arg0) {
            Log.i( "Subscribed successfully");
        }
   });
   ```

9. (オプション) 以下のように、タグからアンサブスクライブします。

   ```java
   String[] tags = new String[2];
   tags[0] ="sample-tag1";
   tags[1] ="sample-tag2";
   push.unsubscribe(tags, new MFPPushResponseListener<String[]>(){

        @Override
        public void onFailure(MFPPushException arg0) {
            Log.i("Push Notifications", "Failed to unsubscribe");
        }

        @Override
        public void onSuccess(String[] arg0) {
            Log.i("Push Notifications", "Unsubscribed successfully");
        }
   });
   ```

##### サーバー
{: #server-android-2 }
アダプターで以下の `WL.Server` API (使用されている場合) を削除します。

* `notifyAllDevices()`
* `notifyDevice()`
* `notifyDeviceSubscription()`
* `createEventSource()`

同じイベント・ソースを使用していた各アプリケーションに対して、以下のステップを実行します。

1. {{ site.data.keys.mf_console }} を使用して資格情報をセットアップします。『[プッシュ通知設定の構成 (Configuring push notification settings)](../../notifications/sending-notifications)』を参照してください。

    [Update GCM settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_gcm_settings_put.html?view=kc#Update-GCM-settings--PUT-) REST API (Android アプリケーションの場合) または [Update APNs settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_apns_settings_put.html?view=kc#Update-APNs-settings--PUT-) REST API (iOS アプリケーションの場合) を使用して、資格情報をセットアップすることもできます。
2. **「スコープ・エレメントのマッピング (Scope Elements Mapping)」**でスコープ `push.mobileclient` を追加します。
3. プッシュ通知をサブスクライバーに送信できるようにするタグを作成します。プッシュ通知のための[タグの定義](../../notifications/sending-notifications/#defining-tags)を参照してください。
4. 以下の方法のいずれかを使用して通知を送信できます。
    * {{ site.data.keys.mf_console }}。『[サブスクライバーへのプッシュ通知の送信 (Sending push notifications to subscribers)](../../notifications/sending-notifications/#sending-notifications)』を参照してください。
    * `userId`/`deviceId` を使用した [Push Message (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) REST API。     

#### シナリオ 3: アプリケーションでブロードキャスト/ユニキャスト通知を使用する既存のアプリケーション
{: #android-scenario-3-existing-applications-using-broadcast-unicast-notification-in-their-application }
##### クライアント
{: #client-android-3 }

1. 以下のように、アプリケーションで `MFPPush` クライアント・インスタンスを初期化します。

   ```java
   MFPPush push = MFPPush.getInstance();
        push.initialize(_this);
   ```

2. インターフェース `MFPPushNotificationListener` を実装し、`onReceive()` を定義します。

   ```java
   @Override
   public void onReceive(MFPSimplePushNotification message) {
        Log.i("Push Notifications", message.getAlert());
   }
   ```

3. モバイル・デバイスをプッシュ通知サービスに登録します。

   ```java
   push.registerDevice(new MFPPushResponseListener<String>(){
        @Override
        public void onFailure(MFPPushException arg0) {
            Log.i("Push Notifications", "Failed to register");
	    }
        @Override
        public void onSuccess(String arg0) {
           Log.i("Push Notifications", "Registered successfully");

        }
   });
   ```

4. (オプション) モバイル・デバイスをプッシュ通知サービスから登録抹消します。

   ```java
   push.unregisterDevice(new MFPPushResponseListener<String>(){
        @Override
        public void onFailure(MFPPushException arg0) {
            Log.i("Push Notifications", "Failed to unregister");

        }
        @Override
        public void onSuccess(String arg0) {
             Log.i("Push Notifications", "Unregistered successfully");
        }
   });
   ```

5. `WLClient.Push.isPushSupported()` (使用されている場合) を削除し、`push.isPushSupported();` を使用します。
6. 以下の WLClient.Push API を削除します。
    * `registerEventSourceCallback()`
    * `WLOnReadyToSubscribeListener` および `WLNotificationListener` の実装

##### サーバー
{: #server-android-3 }
アダプターで WL.Server.sendMessage() API を削除します (使用されている場合)。

同じイベント・ソースを使用していた各アプリケーションに対して、以下のステップを実行します。

1. {{ site.data.keys.mf_console }} を使用して資格情報をセットアップします。『[プッシュ通知設定の構成 (Configuring push notification settings)](../../notifications/sending-notifications)』を参照してください。

    [Update GCM settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_gcm_settings_put.html?view=kc#Update-GCM-settings--PUT-) REST API (Android アプリケーションの場合) または [Update APNs settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_apns_settings_put.html?view=kc#Update-APNs-settings--PUT-) REST API (iOS アプリケーションの場合) を使用して、資格情報をセットアップすることもできます。
2. **「スコープ・エレメントのマッピング (Scope Elements Mapping)」**でスコープ `push.mobileclient` を追加します。
3. プッシュ通知をサブスクライバーに送信できるようにするタグを作成します。プッシュ通知のための[タグの定義](../../notifications/sending-notifications/#defining-tags)を参照してください。
4. 以下の方法のいずれかを使用して通知を送信できます。
    * {{ site.data.keys.mf_console }}。『[サブスクライバーへのプッシュ通知の送信 (Sending push notifications to subscribers)](../../notifications/sending-notifications/#sending-notifications)』を参照してください。
    * `userId`/`deviceId` を使用した [Push Message (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) REST API。    

#### シナリオ 4: アプリケーションでタグ通知を使用する既存のアプリケーション
{: #android-scenario-4-existing-applications-using-tag-notifications-in-their-application }
##### クライアント
{: #client-android-4 }

1. 以下のように、アプリケーションで `MFPPush` クライアント・インスタンスを初期化します。

   ```java
   MFPPush push = MFPPush.getInstance();
        push.initialize(_this);
   ```

2. インターフェース MFPPushNotificationListener を実装し、onReceive() を定義します。

   ```java
   @Override
   public void onReceive(MFPSimplePushNotification message) {
        Log.i("Push Notifications", message.getAlert());
   }
   ```

3. モバイル・デバイスをプッシュ通知サービスに登録します。

   ```java
   push.registerDevice(new MFPPushResponseListener<String>(){
        @Override
        public void onFailure(MFPPushException arg0) {
            Log.i("Push Notifications", "Failed to register");
	    }
        @Override
        public void onSuccess(String arg0) {
            Log.i("Push Notifications", "Registered successfully");
        }
   });
   ```

4. (オプション) モバイル・デバイスをプッシュ通知サービスから登録抹消します。

   ```java
   push.unregisterDevice(new MFPPushResponseListener<String>(){
        @Override
        public void onFailure(MFPPushException arg0) {
            Log.i("Push Notifications", "Failed to unregister");

        }
        @Override
        public void onSuccess(String arg0) {
             Log.i("Push Notifications", "Unregistered successfully");
        }
   });
   ```

5. `WLClient.Push.isPushSupported()` (使用されている場合) を削除し、`push.isPushSupported()`; を使用します。
6. 以下の `WLClient.Push` API を削除します。
    * `subscribeTag()`
    * `unsubscribeTag()`
    * `isTagSubscribed()`
    * `WLOnReadyToSubscribeListener` および `WLNotificationListener` の実装

7. 以下のように、タグにサブスクライブします。

   ```java
   String[] tags = new String[2];
   tags[0] ="sample-tag1";
   tags[1] ="sample-tag2";
   push.subscribe(tags, new MFPPushResponseListener<String[]>(){

        @Override
        public void onFailure(MFPPushException arg0) {
            Log.i("Failed to subscribe");
        }

        @Override
        public void onSuccess(String[] arg0) {
            Log.i( "Subscribed successfully");
        }
   });
   ```

8. (オプション) 以下のように、タグからアンサブスクライブします。

   ```java
   String[] tags = new String[2];
   tags[0] ="sample-tag1";
   tags[1] ="sample-tag2";
   push.unsubscribe(tags, new MFPPushResponseListener<String[]>(){

        @Override
        public void onFailure(MFPPushException arg0) {
            Log.i("Push Notifications", "Failed to unsubscribe");
        }

        @Override
        public void onSuccess(String[] arg0) {
            Log.i("Push Notifications", "Unsubscribed successfully");
        }
   });
   ```

##### サーバー
{: #server-android-4 }
アダプターで `WL.Server.sendMessage()` (使用されている場合) を削除します。

同じイベント・ソースを使用していた各アプリケーションに対して、以下のステップを実行します。

1. {{ site.data.keys.mf_console }} を使用して資格情報をセットアップします。『[プッシュ通知設定の構成 (Configuring push notification settings)](../../notifications/sending-notifications)』を参照してください。

    [Update GCM settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_gcm_settings_put.html?view=kc#Update-GCM-settings--PUT-) REST API (Android アプリケーションの場合) または [Update APNs settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_apns_settings_put.html?view=kc#Update-APNs-settings--PUT-) REST API (iOS アプリケーションの場合) を使用して、資格情報をセットアップすることもできます。
2. **「スコープ・エレメントのマッピング (Scope Elements Mapping)」**でスコープ `push.mobileclient` を追加します。
3. プッシュ通知をサブスクライバーに送信できるようにするタグを作成します。プッシュ通知のための[タグの定義](../../notifications/sending-notifications/#defining-tags)を参照してください。
4. 以下の方法のいずれかを使用して通知を送信できます。
    * {{ site.data.keys.mf_console }}。『[サブスクライバーへのプッシュ通知の送信 (Sending push notifications to subscribers)](../../notifications/sending-notifications/#sending-notifications)』を参照してください。
    * `userId`/`deviceId` を使用した [Push Message (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) REST API。

### ネイティブ iOS アプリケーション
{: #native-ios-applications }
マイグレーション・シナリオ例では、単一のイベント・ソースまたは複数のイベント・ソース、ブロードキャスト通知またはユニキャスト通知、あるいはタグ通知を使用するアプリケーションを扱っています。

#### シナリオ 1: アプリケーションで単一のイベント・ソースを使用する既存のアプリケーション
{: #ios-scenario-1-existing-applications-using-single-event-source-in-their-application }
以前のバージョンの {{ site.data.keys.product_adj }} では、イベント・ソース・ベースのモデルを使用したプッシュのみがサポートされていたため、アプリケーションは単一のイベント・ソースを使用していました。

##### クライアント
{: #client-ios-1 }
v8.0 にこれをマイグレーションするには、このモデルをユニキャスト通知に変換します。

1. 以下のように、アプリケーションで `MFPPush` クライアント・インスタンスを初期化します。

   ```objc
[[MFPPush sharedInstance] initialize];```

2. `didReceiveRemoteNotification()` で通知処理を実装します。
3. モバイル・デバイスをプッシュ通知サービスに登録します。

   ```objc
[[MFPPush sharedInstance] registerDevice:^(WLResponse *response, NSError *error) {
if(error){
    	   NSLog(@"Failed to register");
        } else {
            NSLog(@"Successfullyregistered");
        }
   }];
   ```

4. (オプション) モバイル・デバイスをプッシュ通知サービスから登録抹消します。

   ```objc
[MFPPush sharedInstance] unregisterDevice:^(WLResponse *response, NSError *error) {
if(error){
	       NSLog(@"Failed to unregister");
        } else {
	       NSLog(@"Successfully unregistered");
        }
   }];
   ```

5. `WLClient.Push.isPushSupported()` を削除し (使用されている場合)、以下を使用します。

   ```objc
[[MFPPush sharedInstance] isPushSupported]```

6. サブスクライブ対象のイベント・ソースがないため、以下の `WLClient.Push` API を削除し、通知コールバックを登録します。
    * `registerEventSourceCallback()`
    * `subscribe()`
    * `unsubscribe()`
    * `isSubscribed()`
    * `WLOnReadyToSubscribeListener` 実装

7. `didRegisterForRemoteNotificationsWithDeviceToken` で `sendDeviceToken()` を呼び出します。

   ```objc
[[MFPPush sharedInstance] sendDeviceToken:deviceToken];```

##### サーバー
{: #server-ios-1 }
アダプターで以下の WL.Server API を削除します (使用されている場合)。

* `notifyAllDevices()`
* `notifyDevice()`
* `notifyDeviceSubscription()`
* `createEventSource()`

同じイベント・ソースを使用していた各アプリケーションに対して、以下のステップを実行します。

1. {{ site.data.keys.mf_console }} を使用して資格情報をセットアップします。『[プッシュ通知設定の構成 (Configuring push notification settings)](../../notifications/sending-notifications)』を参照してください。

    [Update GCM settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_gcm_settings_put.html?view=kc#Update-GCM-settings--PUT-) REST API (Android アプリケーションの場合) または [Update APNs settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_apns_settings_put.html?view=kc#Update-APNs-settings--PUT-) REST API (iOS アプリケーションの場合) を使用して、資格情報をセットアップすることもできます。
2. **「スコープ・エレメントのマッピング (Scope Elements Mapping)」**でスコープ `push.mobileclient` を追加します。
3. プッシュ通知をサブスクライバーに送信できるようにするタグを作成します。プッシュ通知のための[タグの定義](../../notifications/sending-notifications/#defining-tags)を参照してください。
4. 以下の方法のいずれかを使用して通知を送信できます。
    * {{ site.data.keys.mf_console }}。『[サブスクライバーへのプッシュ通知の送信 (Sending push notifications to subscribers)](../../notifications/sending-notifications/#sending-notifications)』を参照してください。
    * `userId`/`deviceId` を使用した [Push Message (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) REST API。

#### シナリオ 2: アプリケーションで複数のイベント・ソースを使用する既存のアプリケーション
{: #ios-scenario-2-existing-applications-using-multiple-event-sources-in-their-application }
複数のイベント・ソースを使用するアプリケーションでは、サブスクリプションに基づいてユーザーをセグメント化する必要があります。

##### クライアント
{: #client-ios-2}
これは、対象トピックに基づいてユーザー/デバイスをセグメント化するタグにマップされます。{{ site.data.keys.product_adj }} V8.0.0 にこれをマイグレーションするには、このモデルをタグ・ベースの通知に変換します。

1. 以下のように、アプリケーションで `MFPPush` クライアント・インスタンスを初期化します。

   ```objc
[[MFPPush sharedInstance] initialize];```

2. `didReceiveRemoteNotification()` で通知処理を実装します。
3. 次のように、モバイル・デバイスをプッシュ通知サービスに登録します。

   ```objc
[[MFPPush sharedInstance] registerDevice:^(WLResponse *response, NSError *error) {
if(error){
        	NSLog(@"Failed to register");
        }else{
        	NSLog(@"Successfullyregistered");
        }
   }];
   ```

4. (オプション) 次のように、モバイル・デバイスをプッシュ通知サービスから登録抹消します。

   ```objc
[MFPPush sharedInstance] unregisterDevice:^(WLResponse *response, NSError *error) {
if(error){
        	NSLog(@"Failed to unregister");
        }else{
        	NSLog(@"Successfully unregistered");
        }
   }];
   ```

5. `WLClient.Push.isPushSupported()` を削除し (使用されている場合)、以下を使用します。

   ```objc
[[MFPPush sharedInstance] isPushSupported]```

6. サブスクライブ対象のイベント・ソースがないため、以下の `WLClient.Push` API を削除し、通知コールバックを登録します。
    * `registerEventSourceCallback()`
    * `subscribe()`
    * `unsubscribe()`
    * `isSubscribed()`
    * `WLOnReadyToSubscribeListener` 実装

7. `didRegisterForRemoteNotificationsWithDeviceToken` で `sendDeviceToken()` を呼び出します。
8. 以下のように、タグにサブスクライブします。

   ```objc
   NSMutableArray *tags = [[NSMutableArray alloc]init];
   [tags addObject:@"sample-tag1"];
   [tags addObject:@"sample-tag2"];
   [MFPPush sharedInstance] subscribe:tags completionHandler:^(WLResponse *response, NSError *error) {
        if(error){
        	NSLog(@"Failed to unregister");
        }else{
        	NSLog(@"Successfully unregistered");
        }
   }];
   ```

9. (オプション) 以下のように、タグからアンサブスクライブします。

   ```objc
   NSMutableArray *tags = [[NSMutableArray alloc]init];
   [tags addObject:@"sample-tag1"];
   [tags addObject:@"sample-tag2"];
   [MFPPush sharedInstance] unsubscribe:tags completionHandler:^(WLResponse *response, NSError *error) {
        if(error){
        	NSLog(@"Failed to unregister");
        }else{
        	NSLog(@"Successfully unregistered");
        }
   }];
   ```

##### サーバー
:{: #server-ios-2 }
アダプターで `WL.Server` (使用されている場合) を削除します。

* `notifyAllDevices()`
* `notifyDevice()`
* `notifyDeviceSubscription()`
* `createEventSource()`

同じイベント・ソースを使用していた各アプリケーションに対して、以下のステップを実行します。

1. {{ site.data.keys.mf_console }} を使用して資格情報をセットアップします。『[プッシュ通知設定の構成 (Configuring push notification settings)](../../notifications/sending-notifications)』を参照してください。

    [Update GCM settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_gcm_settings_put.html?view=kc#Update-GCM-settings--PUT-) REST API (Android アプリケーションの場合) または [Update APNs settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_apns_settings_put.html?view=kc#Update-APNs-settings--PUT-) REST API (iOS アプリケーションの場合) を使用して、資格情報をセットアップすることもできます。
2. **「スコープ・エレメントのマッピング (Scope Elements Mapping)」**でスコープ `push.mobileclient` を追加します。
3. プッシュ通知をサブスクライバーに送信できるようにするタグを作成します。プッシュ通知のための[タグの定義](../../notifications/sending-notifications/#defining-tags)を参照してください。
4. 以下の方法のいずれかを使用して通知を送信できます。
    * {{ site.data.keys.mf_console }}。『[サブスクライバーへのプッシュ通知の送信 (Sending push notifications to subscribers)](../../notifications/sending-notifications/#sending-notifications)』を参照してください。
    * `userId`/`deviceId` を使用した [Push Message (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) REST API。    

#### シナリオ 3: アプリケーションでブロードキャスト/ユニキャスト通知を使用する既存のアプリケーション
{: #ios-scenario-3-existing-applications-using-broadcast-unicast-notification-in-their-application }
##### クライアント
{: #client-ios-3 }
1. 以下のように、アプリケーションで MFPPush クライアント・インスタンスを初期化します。

   ```objc
[[MFPPush sharedInstance] initialize];```

2. `didReceiveRemoteNotification()` で通知処理を実装します。
3. 次のように、モバイル・デバイスをプッシュ通知サービスに登録します。

   ```objc
[[MFPPush sharedInstance] registerDevice:^(WLResponse *response, NSError *error) {
if(error){
        	NSLog(@"Failed to register");
        }else{
        	NSLog(@"Successfullyregistered");
        }
   }];
   ```

4. (オプション) モバイル・デバイスをプッシュ通知サービスから登録抹消します。

   ```objc
[MFPPush sharedInstance] unregisterDevice:^(WLResponse *response, NSError *error) {
if(error){
        	NSLog(@"Failed to unregister");
        }else{
        	NSLog(@"Successfully unregistered");
        }
   }];
   ```

5. `WLClient.Push.isPushSupported()` を削除し (使用されている場合)、以下を使用します。

   ```objc
[[MFPPush sharedInstance] isPushSupported]```

6. 以下の `WLClient.Push` API を削除します。
    * `registerEventSourceCallback()`
    * `WLOnReadyToSubscribeListener` 実装

##### サーバー
{: #server-ios-3 }
アダプターで `WL.Server.sendMessage` (使用されている場合) を削除します。

同じイベント・ソースを使用していた各アプリケーションに対して、以下のステップを実行します。

1. {{ site.data.keys.mf_console }} を使用して資格情報をセットアップします。『[プッシュ通知設定の構成 (Configuring push notification settings)](../../notifications/sending-notifications)』を参照してください。

    [Update GCM settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_gcm_settings_put.html?view=kc#Update-GCM-settings--PUT-) REST API (Android アプリケーションの場合) または [Update APNs settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_apns_settings_put.html?view=kc#Update-APNs-settings--PUT-) REST API (iOS アプリケーションの場合) を使用して、資格情報をセットアップすることもできます。
2. **「スコープ・エレメントのマッピング (Scope Elements Mapping)」**でスコープ `push.mobileclient` を追加します。
3. プッシュ通知をサブスクライバーに送信できるようにするタグを作成します。プッシュ通知のための[タグの定義](../../notifications/sending-notifications/#defining-tags)を参照してください。
4. 以下の方法のいずれかを使用して通知を送信できます。
    * {{ site.data.keys.mf_console }}。『[サブスクライバーへのプッシュ通知の送信 (Sending push notifications to subscribers)](../../notifications/sending-notifications/#sending-notifications)』を参照してください。
    * `userId`/`deviceId` を使用した [Push Message (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) REST API。  

#### シナリオ 4: アプリケーションでタグ通知を使用する既存のアプリケーション
{: #ios-scenario-4-existing-applications-using-tag-notifications-in-their-application }
##### クライアント
{: #client-ios-4 }

1. 以下のように、アプリケーションで MFPPush クライアント・インスタンスを初期化します。

   ```objc
[[MFPPush sharedInstance] initialize];```

2. `didReceiveRemoteNotification()` で通知処理を実装します。
3. 次のように、モバイル・デバイスをプッシュ通知サービスに登録します。

   ```objc
[[MFPPush sharedInstance] registerDevice:^(WLResponse *response, NSError *error) {
if(error){
        	NSLog(@"Failed to register");
        }else{
        	NSLog(@"Successfullyregistered");
        }
   }];
   ```

4. (オプション) 次のように、モバイル・デバイスをプッシュ通知サービスから登録抹消します。

   ```objc
[MFPPush sharedInstance] unregisterDevice:^(WLResponse *response, NSError *error) {
if(error){
        	NSLog(@"Failed to unregister");
        }else{
        	NSLog(@"Successfully unregistered");
        }
   }];
   ```

5. `WLClient.Push.isPushSupported()` を削除し (使用されている場合)、`[[MFPPush sharedInstance] isPushSupported]` を使用します。
6. サブスクライブ対象のイベント・ソースがないため、以下の `WLClient.Push` API を削除し、通知コールバックを登録します。
    * `registerEventSourceCallback()`
    * `subscribeTag()`
    * `unsubscribeTag()`
    * `isTagSubscribed()`
    * `WLOnReadyToSubscribeListener` 実装

7. `didRegisterForRemoteNotificationsWithDeviceToken` で `sendDeviceToken()` を呼び出します。
8. 以下のように、タグにサブスクライブします。

   ```objc
   NSMutableArray *tags = [[NSMutableArray alloc]init];
   [tags addObject:@"sample-tag1"];
   [tags addObject:@"sample-tag2"];
   [MFPPush sharedInstance] subscribe:tags completionHandler:^(WLResponse *response, NSError *error) {
        if(error){
        	NSLog(@"Failed to unregister");
        }else{
        	NSLog(@"Successfully unregistered");
        }
   }];
   ```

9. (オプション) 以下のように、タグからアンサブスクライブします。

   ```objc
   NSMutableArray *tags = [[NSMutableArray alloc]init];
   [tags addObject:@"sample-tag1"];
   [tags addObject:@"sample-tag2"];
   [MFPPush sharedInstance] unsubscribe:tags completionHandler:^(WLResponse *response, NSError *error) {
        if(error){
        	NSLog(@"Failed to unregister");
        }else{
        	NSLog(@"Successfully unregistered");
        }
   }];
   ```

##### サーバー
{: server-ios-4 }
アダプターで `WL.Server.sendMessage` を削除します (使用されている場合)。

同じイベント・ソースを使用していた各アプリケーションに対して、以下のステップを実行します。

1. {{ site.data.keys.mf_console }} を使用して資格情報をセットアップします。『[プッシュ通知設定の構成 (Configuring push notification settings)](../../notifications/sending-notifications)』を参照してください。

    [Update GCM settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_gcm_settings_put.html?view=kc#Update-GCM-settings--PUT-) REST API (Android アプリケーションの場合) または [Update APNs settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_apns_settings_put.html?view=kc#Update-APNs-settings--PUT-) REST API (iOS アプリケーションの場合) を使用して、資格情報をセットアップすることもできます。
2. **「スコープ・エレメントのマッピング (Scope Elements Mapping)」**でスコープ `push.mobileclient` を追加します。
3. プッシュ通知をサブスクライバーに送信できるようにするタグを作成します。プッシュ通知のための[タグの定義](../../notifications/sending-notifications/#defining-tags)を参照してください。
4. 以下の方法のいずれかを使用して通知を送信できます。
    * {{ site.data.keys.mf_console }}。『[サブスクライバーへのプッシュ通知の送信 (Sending push notifications to subscribers)](../../notifications/sending-notifications/#sending-notifications)』を参照してください。
    * `userId`/`deviceId` を使用した [Push Message (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) REST API。  

### ネイティブ Windows ユニバーサル・アプリケーション
{: #native-windows-universal-applications }
マイグレーション・シナリオ例では、単一のイベント・ソースまたは複数のイベント・ソース、ブロードキャスト通知またはユニキャスト通知、あるいはタグ通知を使用するアプリケーションを扱っています。

#### シナリオ 1: アプリケーションで単一のイベント・ソースを使用する既存のアプリケーション
{: #windows-scenario-1-existing-applications-using-single-event-source-in-their-application }
v8.0 にこれをマイグレーションするには、このモデルをユニキャスト通知に変換します。

##### クライアント
{: #windows-client-1}

1. 以下のように、アプリケーションで `MFPPush` クライアント・インスタンスを初期化します。

   ```csharp
   MFPPush push = MFPPush.GetInstance();
   push.Initialize();
   Implement the interface MFPPushNotificationListener and define onReceive().
   class Pushlistener : MFPPushNotificationListener
   {
        public void onReceive(String properties, String payload)
        {
                Debug.WriteLine("Push Notifications\n properties:" + properties + "\n payload:" + payload);
        }
   }
   ```

2. モバイル・デバイスをプッシュ通知サービスに登録します。

   ```csharp
   MFPPushMessageResponse Response = await push.RegisterDevice(null);
   if (Response.Success == true)
   {
        Debug.WriteLine("Push Notifications Registered successfully");
   } 
   else
   {
        Debug.WriteLine("Push Notifications Failed to register");
   }
   ```

3. (オプション) モバイル・デバイスをプッシュ通知サービスから登録抹消します。

   ```csharp
   MFPPushMessageResponse Response = await push.UnregisterDevice();
   if (Response.Success == true)
   {
        Debug.WriteLine("Push Notifications Failed to unregister");
   }
   else
   {
        Debug.WriteLine("Push Notifications Unregistered successfully");
   }
   ```

4. `WLClient.Push.IsPushSupported()` (使用されている場合) を削除し、`push.IsPushSupported();` を使用します。
5. サブスクライブ対象のイベント・ソースがないため、以下の `WLClient.Push` API を削除し、通知コールバックを登録します。
    * `registerEventSourceCallback()`
    * `subscribe()`
    * `unsubscribe()`
    * `isSubscribed()`
    * `WLOnReadyToSubscribeListener` および `WLNotificationListener` 実装

##### サーバー
{: #windows-server-1 }
アダプターで以下の `WL.Server` API (使用されている場合) を削除します。

* `notifyAllDevices()`
* `notifyDevice()`
* `notifyDeviceSubscription()`
* `createEventSource()`

同じイベント・ソースを使用していた各アプリケーションに対して、以下のステップを実行します。

1. {{ site.data.keys.mf_console }} の**「プッシュ設定」**ページで WNS 資格情報をセットアップするか、WNS Settings REST API を使用します。
2. スコープ `push.mobileclient` を、{{ site.data.keys.mf_console }} の「セキュリティー」タブにある**「スコープ・エレメントのマッピング」**セクションに追加します。
3. また、[Push Message (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) REST API を使用し、`userId`/`deviceId` を指定することで、メッセージを送信することもできます。

#### シナリオ 2: アプリケーションで複数のイベント・ソースを使用する既存のアプリケーション
{: #windows-scenario-2-existing-applications-using-multiple-event-sources-in-their-appliction }
複数のイベント・ソースを使用するアプリケーションでは、サブスクリプションに基づいてユーザーをセグメント化する必要があります。

##### クライアント
{: #windows-client-2 }
これは、対象トピックに基づいてユーザー/デバイスをセグメント化するタグにマップされます。{{ site.data.keys.product_adj }} V8.0.0 にこれをマイグレーションするには、このモデルをタグ・ベースの通知に変換します。

1. 以下のように、アプリケーションで `MFPPush` クライアント・インスタンスを初期化します。

   ```csharp
   MFPPush push = MFPPush.GetInstance();
   push.Initialize();
   Implement the interface MFPPushNotificationListener and define onReceive().
   class Pushlistener : MFPPushNotificationListener
   {
        public void onReceive(String properties, String payload)
        {
                Debug.WriteLine("Push Notifications\n properties:" + properties + "\n payload:" + payload);
        }
   }
   ```

2. モバイル・デバイスを IMFPUSH サービスに登録します。

   ```csharp
   MFPPushMessageResponse Response = await push.RegisterDevice(null);
   if (Response.Success == true)
   {
        Debug.WriteLine("Push Notifications Registered successfully");
   } 
   else
   {
        Debug.WriteLine("Push Notifications Failed to register");
   }
   ```

3. (オプション) 以下のように、モバイル・デバイスを IMFPUSH サービスから登録抹消します。

   ```csharp
   MFPPushMessageResponse Response = await push.UnregisterDevice();
   if (Response.Success == true)
   {
        Debug.WriteLine("Push Notifications Failed to unregister");
   }
   else
   {
        Debug.WriteLine("Push Notifications Unregistered successfully");
   }
   ```

4. `WLClient.Push.IsPushSupported()` (使用されている場合) を削除し、`push.IsPushSupported();` を使用します。
5. サブスクライブ対象のイベント・ソースがないため、以下の `WLClient.Push` API を削除し、通知コールバックを登録します。
    * `registerEventSourceCallback()`
    * `subscribe()`
    * `unsubscribe()`
    * `isSubscribed()`
    * `WLOnReadyToSubscribeListener` および `WLNotificationListener` 実装

6. 以下のように、タグにサブスクライブします。

   ```csharp
   String[] Tag = { "sample-tag1", "sample-tag2" };
   MFPPushMessageResponse Response = await push.Subscribe(Tag);
   if (Response.Success == true)
   {
        Debug.WriteLine("Subscribed successfully");
   }
   else
   {
        Debug.WriteLine("Failed to subscribe");
   }
   ```

7. (オプション) 以下のように、タグからアンサブスクライブします。

   ```csharp
   String[] Tag = { "sample-tag1", "sample-tag2" };
   MFPPushMessageResponse Response = await push.Unsubscribe(Tag);
   if (Response.Success == true)
   {
        Debug.WriteLine("Unsubscribed successfully");
   }
   else
   {
        Debug.WriteLine("Failed to unsubscribe");
   }
   ```

##### サーバー
{: #windows-server-2 }
アダプターで以下の `WL.Server` API (使用されている場合) を削除します。

* `notifyAllDevices()`
* `notifyDevice()`
* `notifyDeviceSubscription()`
* `createEventSource()`

同じイベント・ソースを使用していた各アプリケーションに対して、以下のステップを実行します。

1. {{ site.data.keys.mf_console }} の**「プッシュ設定」**ページで WNS 資格情報をセットアップするか、WNS Settings REST API を使用します。
2. スコープ `push.mobileclient` を、{{ site.data.keys.mf_console }} の**「セキュリティー」**タブにある**「スコープ・エレメントのマッピング」**セクションに追加します。
3. {{ site.data.keys.mf_console }} の**「タグ」**ページでプッシュ・タグを作成します。
4. また、[Push Message (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) REST API を使用し、ターゲットとして `userId`/`deviceId`/`tagNames` を指定することで、通知を送信することもできます。

#### シナリオ 3: アプリケーションでブロードキャスト/ユニキャスト通知を使用する既存のアプリケーション
{: #windows-scenario-3-existing-applications-using-broadcast-unicast-notification-in-their-application }

##### クライアント
{:# windows-client-3 }
1. 以下のように、アプリケーションで `MFPPush` クライアント・インスタンスを初期化します。

   ```csharp
   MFPPush push = MFPPush.GetInstance();
   push.Initialize();
   Implement the interface MFPPushNotificationListener and define onReceive().
   class Pushlistener : MFPPushNotificationListener
   {
        public void onReceive(String properties, String payload)
        {
                Debug.WriteLine("Push Notifications\n properties:" + properties + "\n payload:" + payload);
        }
   }
   ```

2. モバイル・デバイスをプッシュ通知サービスに登録します。

   ```csharp
   MFPPushMessageResponse Response = await push.RegisterDevice(null);
   if (Response.Success == true)
   {
        Debug.WriteLine("Push Notifications Registered successfully");
   } 
   else
   {
        Debug.WriteLine("Push Notifications Failed to register");
   }
   ```

3. (オプション) モバイル・デバイスをプッシュ通知サービスから登録抹消します。

   ```csharp
   MFPPushMessageResponse Response = await push.UnregisterDevice();
   if (Response.Success == true)
   {
        Debug.WriteLine("Push Notifications Failed to unregister");
   }
   else
   {
        Debug.WriteLine("Push Notifications Unregistered successfully");
   }
   ```

4. `WLClient.Push.isPushSupported()` (使用されている場合) を削除し、`push.IsPushSupported();` を使用します。
5. 以下の `WLClient.Push` API を削除します。
    * `registerEventSourceCallback()`
    * `WLOnReadyToSubscribeListener` および `WLNotificationListener` 実装

##### サーバー
{: #windows-server-3 }
アダプターで `WL.Server.sendMessage()` (使用されている場合) を削除します。

同じイベント・ソースを使用していた各アプリケーションに対して、以下のステップを実行します。

1. {{ site.data.keys.mf_console }} の**「プッシュ設定」**ページで WNS 資格情報をセットアップするか、WNS Settings REST API を使用します。
2. スコープ `push.mobileclient` を、{{ site.data.keys.mf_console }} の**「セキュリティー」**タブにある**「スコープ・エレメントのマッピング」**セクションに追加します。
3. {{ site.data.keys.mf_console }} の**「タグ」**ページでプッシュ・タグを作成します。
4. また、[Push Message (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) REST API を使用し、ターゲットとして `userId`/`deviceId`/`tagNames` を指定することで、通知を送信することもできます。

#### シナリオ 4: アプリケーションでタグ通知を使用する既存のアプリケーション
{: #windows-scenario-4-existing-applications-using-tag-notifications-in-their-application }
##### クライアント
{: #windows-client-4 }

1. 以下のように、アプリケーションで `MFPPush` クライアント・インスタンスを初期化します。

   ```csharp
   MFPPush push = MFPPush.GetInstance();
   push.Initialize();
   ```

2. インターフェース MFPPushNotificationListener を実装し、onReceive() を定義します。

   ```csharp
class Pushlistener : MFPPushNotificationListener
   {
        public void onReceive(String properties, String payload)
        {
                Debug.WriteLine("Push Notifications\n properties:" + properties + "\n payload:" + payload);
        }
   }
   ```

3. モバイル・デバイスをプッシュ通知サービスに登録します。

   ```csharp
   MFPPushMessageResponse Response = await push.RegisterDevice(null);
   if (Response.Success == true)
   {
        Debug.WriteLine("Push Notifications Registered successfully");
   } 
   else
   {
        Debug.WriteLine("Push Notifications Failed to register");
   }
   ```

4. (オプション) モバイル・デバイスをプッシュ通知サービスから登録抹消します。

   ```csharp
   MFPPushMessageResponse Response = await push.UnregisterDevice();
   if (Response.Success == true)
   {
        Debug.WriteLine("Push Notifications Failed to unregister");
   }
   else
   {
        Debug.WriteLine("Push Notifications Unregistered successfully");
   }
   ```

5. `WLClient.Push.IsPushSupported()` (使用されている場合) を削除し、`push.IsPushSupported()`; を使用します。
6. 以下の `WLClient.Push` API を削除します。
    * `subscribeTag()`
    * `unsubscribeTag()`
    * `isTagSubscribed()`
    * `WLOnReadyToSubscribeListener` および `WLNotificationListener` 実装

7. 以下のように、タグにサブスクライブします。

   ```csharp
   String[] Tag = { "sample-tag1", "sample-tag2" };
   MFPPushMessageResponse Response = await push.Subscribe(Tag);
   if (Response.Success == true)
   {
        Debug.WriteLine("Subscribed successfully");
   }
   else
   {
        Debug.WriteLine("Failed to subscribe");
   }
   ```

8. (オプション) 以下のように、タグからアンサブスクライブします。

   ```csharp
   String[] Tag = { "sample-tag1", "sample-tag2" };
   MFPPushMessageResponse Response = await push.Unsubscribe(Tag);
   if (Response.Success == true)
   {
        Debug.WriteLine("Unsubscribed successfully");
   }
   else
   {
        Debug.WriteLine("Failed to unsubscribe");
   }
   ```

##### サーバー
{: #windows-server-4 }
アダプターで `WL.Server.sendMessage()` (使用されている場合) を削除します。

同じイベント・ソースを使用していた各アプリケーションに対して、以下のステップを実行します。

1. {{ site.data.keys.mf_console }} の**「プッシュ設定」**ページで WNS 資格情報をセットアップするか、WNS Settings REST API を使用します。
2. スコープ `push.mobileclient` を、{{ site.data.keys.mf_console }} の**「セキュリティー」**タブにある**「スコープ・エレメントのマッピング」**セクションに追加します。
3. {{ site.data.keys.mf_console }} の**「タグ」**ページでプッシュ・タグを作成します。
4. また、[Push Message (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) REST API を使用し、ターゲットとして `userId`/`deviceId`/`tagNames` を指定することで、通知を送信することもできます。

## マイグレーション・ツール
{: #migration-tool }
マイグレーション・ツールは、MobileFirst Platform Foundation 7.1 のプッシュ・データ (デバイス、ユーザーのサブスクリプション、資格情報、およびタグ) を {{ site.data.keys.product }} 8.0 にマイグレーションする際に役立ちます。  
マイグレーション・ツールは、以下の機能を使用してこのプロセスを簡素化します。

1. デバイス、資格情報、タグ、およびユーザー・サブスクリプションを、アプリケーションごとに、MobileFirst Platform Foundation 7.1 データベースから読み取ります。
2. このデータを、それぞれのアプリケーション用の {{ site.data.keys.product }} 8.0 データベース内にある、それぞれの表にコピーします。
3. v8.0 アプリケーションでの環境にかかわらず、v7.1 の全環境の全プッシュ・データをマイグレーションします。

マイグレーション・ツールによってユーザー・サブスクリプション関連、アプリケーション環境関連、およびデバイス関連のデータが変更されることは一切ありません。  

マイグレーション・ツールを使用する前に、以下の情報を知っておくことが重要です。

1. Java バージョン 1.6 以上が必要です。
2. MobileFirst Server 7.1 と {{ site.data.keys.mf_server }} 8.0 の両方がセットアップされ、使用できる状態になっていることを確認します。
3. MobileFirst Server 7.1 と {{ site.data.keys.mf_server }} 8.0 の両方のバックアップをとります。
4. 最新バージョンのアプリケーションを {{ site.data.keys.mf_server }} 8.0 に登録します。
	* アプリケーションの表示名は、MobileFirst Platform Foundation 7.1 内でのそのアプリケーションと一致している必要があります。
	* PacakgeName/BundleID を覚えておき、同じ値をアプリケーションに対して指定します。
	* アプリケーションが {{ site.data.keys.mf_server }} 8.0 に登録されていない場合、マイグレーションは成功しません。
5. アプリケーションの各環境に応じて、スコープ・エレメントのマッピングを指定します。[スコープのマッピングについてもっとよく知る](../../notifications/sending-notifications/#scope-mapping)。

#### 手順
{: #procedure }
1. [下記の GitHub リポジトリー](http://github.com)からマイグレーション・ツールをダウンロードします。
2. ツールをダウンロードしたら、**migration.properties** ファイルに以下の詳細を指定します。

    | 値| 説明| サンプル値|
    |----------------------|--------------|---------------|
    | w.db.type		       | 対象とするデータベースのタイプ| pw.db.type = db2 可能な値は DB2、Oracle、MySql、Derby|
    | pw.db.url			   | MobileFirst Platform Foundation 7.1 Worklight データベースの URL| jdbc:mysql://localhost:3306/WRKLGHT|
    | pw.db.adminurl	   | MobileFirst Platform Foundation 7.1 Admin データベースの URL| jdbc:mysql://localhost:3306/ADMIN|
    | pw.db.username	   | MobileFirst Platform Foundation 7.1 Worklight データベースのユーザー名| pw.db.username=root|
    | pw.db.password	   | MobileFirst Platform Foundation 7.1 Worklight データベースのパスワード| pw.db.password=root|
    | pw.db.adminusername| MobileFirst Platform Foundation 7.1 Admin データベースのユーザー名| pw.db.adminusername=root|
    | pw.db.adminpassword| MobileFirst Platform Foundation 7.1 Admin データベースのパスワード| pw.db.adminpassword=root|
    | pw.db.urlTarget	   | MFP 8.0 データベースの URL| jdbc:mysql://localhost:3306/MFPDATA|
    | pw.db.usernameTarget| MFP 8.0 データベースのユーザー名| pw.db.usernameTarget=root|
    | pw.db.passwordTarget| MFP 8.0 データベースのパスワード| pw.db.passwordTarget=root|
    | pw.db.schema| MobileFirst Platform Foundation 7.1 Worklight データベースのスキーマ| WRKLGT|
    | pw.db.adminschema| MobileFirst Platform Foundation 7.1 Admin データベースのスキーマ| WLADMIN|
    | pw.db.targetschema| {{ site.data.keys.product }} 8.0 Worklight データベースのスキーマ| MFPDATA|
    | runtime			   | MobileFirst Platform Foundation 7.1 のランタイム名| runtime=worklight|
    | applicationId	       | MobileFirst Platform Foundation 7.1 に登録されているアプリケーションの、コンマ (,) 区切りのリストを指定します。| HybridTestApp,NativeiOSTestApp|
    | targetApplicationId| {{ site.data.keys.product }} 8.0に登録されているアプリケーションの、コンマ (,) 区切りのリストを指定します。| com.HybridTestApp,com.NativeiOSTestApp|

    * **applicationID** と **targetApplicationId** の両方の値が、正しい順序で指定されていることを確認します。マッピングは、1 対 1 (つまり n 対 n) の方式で行われます。すなわち、**applicationId** リスト内の最初のアプリケーションのデータが、**targetApplicationId** リスト内の最初のアプリケーションにマイグレーションされます。
	* **targetApplicationId** リストには、アプリケーションの packageName/BundleId を指定します。つまり、MobileFirst Platform Foundation 7.1 の TestApp1 ならば、**targetApplicationId** は com.TestApp1 となります (TestApp1 の packageName/BundleId)。これは、MobileFirst Platform Foundation 7.1 では **applicationId** はアプリケーション名であるのに対し、{{ site.data.keys.mf_server }} 8.0 ではこれは、アプリケーションの環境に基づいた packageName/BundleId/packageIdentityName であるためです。

2. 以下のコマンドを使用してツールを実行します。

   ```bash
   java -jar pushDataMigration.jar path-to-migration.properties
   ```

   * ツールの .jar ファイルとこのプロパティー・ファイルが別々の場所に配置されている場合は、**path-to-migration.properties** を **migration.properties** のパスで置き換えます。そうでない場合は、コマンドからパスを削除します。
