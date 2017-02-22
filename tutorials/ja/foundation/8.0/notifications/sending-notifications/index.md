---
layout: tutorial
title: 通知の送信
relevantTo: [ios,android,windows,cordova]
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
プッシュ通知または SMS 通知を iOS、Android、または Windows デバイスに送信するためには、まず、GCM 詳細 (Android)、APNS 証明書 (iOS)、または WNS 資格情報 (Windows 8.1 Universal/Windows 10 UWP) を使用して {{site.data.keys.mf_server }} を構成する必要があります。
その後、すべてのデバイスに通知を送信したり (ブロードキャスト)、特定のタグに登録しているデバイス、単一デバイス ID、ユーザー ID、iOS デバイスのみ、Android デバイスのみ、または Windows デバイスのみに通知を送信したり、あるいは認証ユーザーに基づいて通知を送信したりできます。

**前提条件**: 必ず、[通知の概要](../)チュートリアルをお読みください。

#### ジャンプ先:
{: #jump-to }
* [通知の設定](#setting-up-notifications)
    * [Google Cloud Messaging / Firebase Cloud Messaging](#google-cloud-messaging--firebase-cloud-messaging)
    * [Apple Push Notifications Service](#apple-push-notifications-service)
    * [Windows Push Notifications Service](#windows-push-notifications-service)
    * [SMS 通知サービス](#sms-notification-service)
    * [スコープ・マッピング](#scope-mapping)
    * [認証済み通知](#authenticated-notifications)
* [タグの定義](#defining-tags)
* [通知の送信](#sending-notifications)    
    * [{{site.data.keys.mf_console }}](#mobilefirst-operations-console)
    * [REST API](#rest-apis)
    * [通知のカスタマイズ](#customizing-notifications)
* [プロキシー・サポート](#proxy-support)
* [次に使用するチュートリアル](#tutorials-to-follow-next)

## 通知のセットアップ
{: #setting-up-notifications }
通知サポートの有効化では、{{site.data.keys.mf_server }} とクライアント・アプリケーションの両方でいくつかの構成ステップが必要になります。  
この後のサーバー・サイドのセットアップを続けてお読みになるか、[クライアント・サイドのセットアップ](#tutorials-to-follow-next)にお進みください。

サーバー・サイドで必要なセットアップには、必要なベンダー (APNS、GCM、または WNS) の構成と push.mobileclient スコープのマッピングがあります。

### Google Cloud Messaging / Firebase Cloud Messaging
{: #google-cloud-messaging--firebase-cloud-messaging }
> **注:** [最近の発表](https://firebase.google.com/support/faq/#gcm-fcm)で、Google は GCM から FCM への移行を表明しています。それに伴い、下記の手順も更新されました。また、既存で使用中の GCM 構成は引き続き機能しますが、新規 GCM 構成は機能しないため、代わりに FCM を使用する必要がある点にも注意してください。

Android デバイスは、プッシュ通知に Firebase Cloud Messaging (FCM) サービスを使用します。  
FCM をセットアップするには、次のようにします。

1. [Firebase コンソール](https://console.firebase.google.com/?pli=1)にアクセスします。
2. 新規プロジェクトを作成し、プロジェクトに名前を付けます。
3. 設定 (歯車) アイコンをクリックし、**「プロジェクトの設定」**を選択します。
4. **「クラウド メッセージング」**タブをクリックして、**「サーバー API キー」**と**「送信者 ID」**を生成し、**「保存」**をクリックします。

> [{{site.data.keys.product_adj }} プッシュ・サービス用 REST API](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_gcm_settings_put.html#Push-GCM-Settings--PUT-) または [{{site.data.keys.product_adj }} 管理サービス用 REST API](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_gcm_settings_put.html#restservicesapi) のいずれかを使用して FCM をセットアップすることもできます。

#### 注
{: #notes }
お客様の組織にインターネットとの間のトラフィックを制限するファイアウォールが存在する場合は、以下のステップを実行する必要があります。  

* FCM クライアント・アプリケーションがメッセージを受信するために FCM との接続を許可するようにファイアウォールを構成します。
* 開くポートは 5228、5229、および 5230 です。
FCM は通常は 5228 のみを使用しますが、場合によっては 5229 および 5230 を使用することもあります。 
* FCM は特定の IP を提供しないため、Google の ASN 15169 にリストされた IP ブロックに含まれるすべての IP アドレスへの発信接続をファイアウォールが受け入れられるようにする必要があります。 
* ファイアウォールが {{site.data.keys.mf_server }} から android.googleapis.com への発信接続をポート 443 で受け入れるようにします。

<img class="gifplayer" alt="GCM 資格情報の追加のイメージ" src="gcm-setup.png"/>

### Apple Push Notifications Service
{: #apple-push-notifications-service }
iOS デバイスは、プッシュ通知に Apple Push Notification Service (APNS) を使用します。  
APNS をセットアップするには、次のようにします。

1. [プッシュ通知証明書を生成します](https://www.ibm.com/developerworks/community/blogs/worklight/entry/understanding-and-setting-up-push-notifications-in-development-evnironment?lang=en)。
2. {{site.data.keys.mf_console }} →**「 [ご使用のアプリケーション] 」→「プッシュ」→「プッシュ設定」**で、証明書タイプを選択し、証明書のファイルとパスワードを指定します。次に、**「保存」**をクリックします。

#### 注
{: #notes-apns }
* プッシュ通知を送信するには、{{site.data.keys.mf_server }} インスタンスから以下のサーバーにアクセス可能でなければなりません。  
    * Sandbox サーバー:  
        * gateway.sandbox.push.apple.com:2195
        * feedback.sandbox.push.apple.com:2196
    * 実動サーバー:  
        * gateway.push.apple.com:2195
        * Feedback.push.apple.com:2196

        * 1-courier.push.apple.com 5223
* 開発フェーズでは、apns-certificate-sandbox.p12 サンドボックス証明書ファイルを使用します。
* 実動フェーズでは、apns-certificate-production.p12 実動証明書ファイルを使用します。
    * APNS 実動証明書は、その証明書を使用するアプリケーションが Apple App Store に正常に送信された後、はじめてテストできるようになります。

> [{{site.data.keys.product_adj }} プッシュ・サービス用 REST API](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_apns_settings_put.html#Push-APNS-settings--PUT-) または [{{site.data.keys.product_adj }} 管理サービス用 REST API](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_apns_settings_put.html?view=kc) のいずれかを使用して APNS をセットアップすることもできます。

<img class="gifplayer" alt="APNS 資格情報の追加のイメージ" src="apns-setup.png"/>

### Windows Push Notifications Service
{: #windows-push-notifications-service }
Windows デバイスは、プッシュ通知に Windows Push Notifications Service (WNS) を使用します。  
WNS をセットアップするには、次のようにします。

1. [Microsoft が提供する指示](https://msdn.microsoft.com/en-in/library/windows/apps/hh465407.aspx)に従って、**「パッケージ セキュリティ ID (SID)」**と**「クライアント シークレット」**の値を生成します。
2. {{site.data.keys.mf_console }} →**「 [ご使用のアプリケーション] 」→「プッシュ」→「プッシュ設定」**で、これらの値を追加し、**「保存」**をクリックします。

> [{{site.data.keys.product_adj }} プッシュ・サービス用 REST API](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_wns_settings_put.html?view=kc) または [{{site.data.keys.product_adj }} 管理サービス用 REST API](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_wns_settings_put.html?view=kc) のいずれかを使用して WNS をセットアップすることもできます。

<img class="gifplayer" alt="WNS 資格情報の追加のイメージ" src="wns-setup.png"/>

### SMS 通知サービス
{: #sms-notification-service }
以下の JSON を使用して、SMS 通知を送信するための SMS ゲートウェイがセットアップされます。[`smsConf` REST API を使用](https://www.ibm.com/support/knowledgecenter/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_sms_settings_put.html)して、SMS ゲートウェイ構成で {{site.data.keys.mf_server }} を更新します。

```json
{
	"host": "2by0.com",
	"name": "dummy",
	"port": "80",
	"programName": "gateway/add.php",
	"parameters": [{
		"name": "xmlHttp",
		"value": "false",
		"encode": "true"
	}, {
		"name": "httpsEnabled",
		"value": "false",
		"encode": "true"
	}]

}
```

> SMS 関連の REST API について詳しくは、[プッシュ・サービス API リファレンス](https://www.ibm.com/support/knowledgecenter/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/c_restapi_runtime.html)を参照してください。

### スコープ・マッピング
{: #scope-mapping }
**push.mobileclient** スコープ・エレメントをアプリケーションにマップします。

1. {{site.data.keys.mf_console }} をロードし、**「 [ご使用のアプリケーション] 」→「セキュリティー」→「スコープ・エレメントのマッピング」**にナビゲートし、**「新規」**をクリックします。
2. **「スコープ・エレメント」**フィールドに「push.mobileclient」と入力します。次に、**「追加」**をクリックします。

    <div class="panel-group accordion" id="scopes" role="tablist" aria-multiselectable="false">
        <div class="panel panel-default">
            <div class="panel-heading" role="tab" id="additional-scopes">
                <h4 class="panel-title">
                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#additional-scopes" data-target="#collapse-additional-scopes" aria-expanded="false" aria-controls="collapse-additional-scopes"><b>使用可能な追加のスコープのリストについてはここをクリック</b></a>
                </h4>
            </div>

            <div id="collapse-additional-scopes" class="panel-collapse collapse" role="tabpanel" aria-labelledby="zip-file">
                <div class="panel-body">
                    <table class="table table-striped">
                        <tr>
                            <td><b>有効範囲</b></td>
                            <td><b>説明</b></td>
                        </tr>
                        <tr>
                            <td>apps.read</td>
                            <td>アプリケーション・リソースの読み取りの許可</td>
                        </tr>
                        <tr>
                            <td>apps.write</td>
                            <td>アプリケーション・リソースの作成、更新、削除の許可</td>
                        </tr>
                        <tr>
                            <td>gcmConf.read</td>
                            <td>GCM 構成設定の読み取りの許可 (API キーおよび SenderId)</td>
                        </tr>
                        <tr>
                            <td>gcmConf.write</td>
                            <td>GCM 構成設定の更新、削除の許可</td>
                        </tr>
                        <tr>
                            <td>apnsConf.read</td>
                            <td>APNs 構成設定の読み取りの許可</td>
                        </tr>
                        <tr>
                            <td>apnsConf.write</td>
                            <td>APNs 構成設定の更新、削除の許可</td>
                        </tr>
                        <tr>
                            <td>devices.read</td>
                            <td>デバイスの読み取りの許可</td>
                        </tr>
                        <tr>
                            <td>devices.write</td>
                            <td>デバイスの作成、更新、削除の許可</td>
                        </tr>
                        <tr>
                            <td>subscriptions.read</td>
                            <td>サブスクリプションの読み取りの許可</td>
                        </tr>
                        <tr>
                            <td>subscriptions.write</td>
                            <td>サブスクリプションの作成、更新、削除の許可</td>
                        </tr>
                        <tr>
                            <td>messages.write</td>
                            <td>プッシュ通知の送信の許可</td>
                        </tr>
                        <tr>
                            <td>webhooks.read</td>
                            <td>イベント通知の読み取りの許可</td>
                        </tr>
                        <tr>
                            <td>webhooks.write</td>
                            <td>イベント通知の送信の許可</td>
                        </tr>
                        <tr>
                            <td>smsConf.read</td>
                            <td>SMS 構成設定の読み取りの許可</td>
                        </tr>
                        <tr>
                            <td>smsConf.write</td>
                            <td>SMS 構成設定の更新、削除の許可</td>
                        </tr>
                        <tr>
                            <td>wnsConf.read</td>
                            <td>WNS 構成設定の読み取りの許可</td>
                        </tr>
                        <tr>
                            <td>wnsConf.write</td>
                            <td>WNS 構成設定の更新、削除の許可</td>
                        </tr>
                    </table>
                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#additional-scopes" data-target="#collapse-additional-scopes" aria-expanded="false" aria-controls="collapse-additional-scopes"><b>セクションを閉じる</b></a>
                </div>
            </div>
        </div>
    </div>

    <img class="gifplayer" alt="スコープ・マッピング" src="scope-mapping.png"/>

### 認証済み通知
{: #authenticated-notifications }
認証済み通知とは、1 つ以上の `userId` に送信される通知です。  

**push.mobileclient** スコープ・エレメントをアプリケーションで使用されるセキュリティー検査にマップします。  

1. {{site.data.keys.mf_console }} をロードし、**「 [ご使用のアプリケーション] 」→「セキュリティー」→「スコープ・エレメントのマッピング」**にナビゲートし、**「新規」**をクリックするか、既存のスコープ・マッピング・エントリーを編集します。
2. セキュリティー検査を選択します。次に、**「追加」**をクリックします。

    <img class="gifplayer" alt="認証済み通知" src="authenticated-notifications.png"/>
    
## タグの定義
{: #defining-tags }
{{site.data.keys.mf_console }} →**「 [ご使用のアプリケーション] 」→「プッシュ」→「タグ」**で、**「新規」**をクリックします。  
適切な`「タグ名」`と`「説明」`を入力し、**「保存」**をクリックします。

<img class="gifplayer" alt="タグの追加" src="adding-tags.png"/>

サブスクリプションにより、デバイス登録とタグが結び付けられます。
デバイスがタグから登録解除されると、関連付けられたすべてのサブスクリプションが、デバイス自体から自動的にアンサブスクライブされます。
デバイスのユーザーが複数存在するシナリオでは、サブスクリプションは、ユーザー・ログイン基準に基づいて、モバイル・アプリケーションに実装する必要があります。
例えば、ユーザーがアプリケーションに正常にログインした後にサブスクライブ呼び出しを行い、ログアウト・アクション処理の一部としてアンサブスクライブ呼び出しを明示的に行います。


## 通知の送信
{: #sending-notifications }
プッシュ通知は、{{site.data.keys.mf_console }} から送信することも、REST API を使用して送信することもできます。

* {{site.data.keys.mf_console }} では、タグ通知およびブロードキャスト通知の 2 つのタイプの通知を送信できます。
* REST API では、タグ通知、ブロードキャスト通知、および認証済み通知のすべての形式の通知を送信できます。

### {{site.data.keys.mf_console }}
{: #mobilefirst-operations-console }
単一デバイス ID、単一または複数のユーザー ID、iOS デバイスのみか Android デバイスのみ、またはタグにサブスクライブしているデバイスに対して通知を送信できます。

#### タグ通知
{: #tag-notifications }
タグ通知は、特定のタグにサブスクライブしているすべてのデバイスをターゲットとする通知メッセージです。タグはユーザーが関心のあるトピックを表し、選択した関心に従って通知を受けられる機能を提供します。 

{{site.data.keys.mf_console }} →**「 [ご使用のアプリケーション] 」→「プッシュ」→「通知の送信」**タブで、**「送信先」**から**「タグ別のデバイス」**を選択し、**「通知テキスト」**を入力します。次に、**「送信」**をクリックします。

<img class="gifplayer" alt="タグによる送信" src="sending-by-tag.png"/>

#### ブロードキャスト通知
{: #breadcast-notifications }
ブロードキャスト通知は、サブスクライブされているすべてのデバイスを宛先とするタグ・プッシュ通知の一形態です。ブロードキャスト通知は、デフォルトでは、予約済みの `Push.all` タグ (あらゆるデバイスで自動作成される) へのサブスクリプションによって、プッシュ対応のすべての {{site.data.keys.product_adj }} アプリケーションに対して使用可能になります。`Push.all` タグは、プログラマチックにアンサブスクライブできます。

{{site.data.keys.mf_console }} →**「 [ご使用のアプリケーション] 」→「プッシュ」→「通知の送信」**タブで、**「送信先」**から**「すべて」**を選択し、**「通知テキスト」**を入力します。次に、**「送信」**をクリックします。

![すべてに送信](sending-to-all.png)

### REST API
{: #rest-apis }
REST API を使用する場合は、タグ通知、ブロードキャスト通知、および認証済み通知のすべての形式の通知を送信できます。

通知を送信するために、POST を使用して REST エンドポイントへの要求が行われます (`imfpush/v1/apps/<application-identifier>/messages`)。  
URL の例を以下に示します。 

```bash
https://myserver.com:443/imfpush/v1/apps/com.sample.PinCodeSwift/messages
```

> すべてのプッシュ通知 REST API を確認するには、ユーザー資料の [REST API ランタイム・サービス](https://www.ibm.com/support/knowledgecenter/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/c_restapi_runtime.html)のトピックを参照してください。

#### 通知ペイロード
{: #notification-payload }
要求には、以下のペイロード・プロパティーを含めることができます。 

ペイロード・プロパティー| 定義
--- | ---
message | 送信されるアラート・メッセージ
settings | 通知のさまざまな属性の設定。
target | ターゲットのセットで使用できるのは、コンシューマー ID、デバイス、プラットフォーム、またはタグです。ターゲットのうちの 1 つのみを設定できます。
deviceIds | デバイス ID によってあらわされるデバイスの配列。これらの ID を持つデバイスが通知を受け取ります。これはユニキャスト通知です。
notificationType | メッセージの送信に使用されるチャネル (プッシュ/SMS) を示す整数値。許可される値は、1 (プッシュのみ)、2 (SMS のみ)、および 3 (プッシュと SMS) です。
platforms | デバイス・プラットフォームの配列。これらのプラットフォームを実行しているデバイスが通知を受け取ります。サポートされる値は、A (Apple/iOS)、G (Google/Android)、および M (Microsoft/Windows) です。
tagNames | tagNames として指定されたタグの配列。これらのタグにサブスクライブされているデバイスが通知を受け取ります。タグ・ベース通知にはこのタイプのターゲットを使用します。
userIds | 通知の送信先とする、ユーザー ID によって表されるユーザーの配列。これはユニキャスト通知です。
phoneNumber | デバイスを登録し、通知を受け取るために使用される電話番号。これはユニキャスト通知です。

**プッシュ通知ペイロード JSON サンプル**

```json
{
    "message" : {
    "alert" : "Test message",
  },
  "settings" : {
    "apns" : {
      "badge" : 1,
      "iosActionKey" : "Ok",
      "payload" : "",
      "sound" : "song.mp3",
      "type" : "SILENT",
    },
    "gcm" : {
      "delayWhileIdle" : ,
      "payload" : "",
      "sound" : "song.mp3",
      "timeToLive" : ,
    },
  },
  "target" : {
    // The list below is for demonstration purposes only - per the documentation only 1 target is allowed to be used at a time.
    "deviceIds" : [ "MyDeviceId1", ... ],
    "platforms" : [ "A,G", ... ],
    "tagNames" : [ "Gold", ... ],
    "userIds" : [ "MyUserId", ... ],
  },
}
```

**SMS 通知ペイロード JSON サンプル**

```json
{
    "message" : {
    "alert": "Hello World from an SMS message"
  },
  "notificationType":3,
   "target" : {
     "deviceIds" : ["38cc1c62-03bb-36d8-be8e-af165e671cf4"]
   }
}
```

#### 通知の送信
{: #sending-the-notification }
通知は、いろいろなツールを使用して送信できます。  
テスト目的では、以下で説明するように Postman が使用されます。

1. [機密クライアントを構成します](../../authentication-and-security/confidential-clients/)。
       
REST API 経由でプッシュ通知を送信する場合、スペースで区切られた `messages.write` と `push.application.<applicationId>` のスコープ・エレメントを使用します。
    
    <img class="gifplayer" alt="機密クライアントの構成" src="push-confidential-client.png"/>

2. [アクセス・トークンを作成します](../../authentication-and-security/confidential-clients#obtaining-an-access-token)。  
    
    
3. **http://localhost:9080/imfpush/v1/apps/com.sample.PushNotificationsAndroid/messages** への **POST** 要求を行います。
    - リモート {{site.data.keys.product_adj }} を使用している場合、`hostname` と `port` の値を実際の値で置き換えてください。
    - アプリケーション ID 値を実際の値で更新します。

4. ヘッダーを設定します。
    - **Authorization**: `Bearer eyJhbGciOiJSUzI1NiIsImp ...`
    - 「Bearer」の後に続く値を上記ステップ (1) で入手したアクセス・トークンの値で置き換えます。
    
    ![許可ヘッダー](postman_authorization_header.png)

5. 本体を設定します。
    - 上記の[通知ペイロード](#notification-payload)の説明に従ってプロパティーを更新します。
    - 例えば、**userIds** 属性が指定された **target** プロパティーを追加すると、特定の登録済みユーザーに通知を送信できます。

   ```json
   {
        "message" : {
            "alert" : "Hello World!"
        }
   }
   ```
    
   ![許可ヘッダー](postman_json.png)
    
これで**「送信」**ボタンをクリックすると、デバイスに通知が到着します。

![サンプル・アプリケーションのイメージ](notifications-app.png)

### 通知のカスタマイズ
{: #customizing-notifications }
通知メッセージを送信する前に、以下の通知属性をカスタマイズすることもできます。  

{{site.data.keys.mf_console }} →**「 [ご使用のアプリケーション] 」→「プッシュ」→「タグ」→「プッシュ送信 (Send Push)」**タブで、**「iOS カスタム設定」/「Android カスタム設定」**セクションを展開し、通知属性を変更します。

### Android
{: #android }
* 通知音、GCM ストレージ内に通知を保管する期間、カスタム・ペイロードなど。
* 通知のタイトルを変更する場合は、Android プロジェクトの **strings.xml** ファイル内に `push_notification_tile` を追加します。

### iOS
{: #ios }
* 通知音、カスタム・ペイロード、アクション・キーのタイトル、通知タイプ、バッジの数値。

![プッシュ通知のカスタマイズ](customizing-push-notifications.png)

## プロキシー・サポート
{: #proxy-support }
プロキシー設定を使用して、通知が Android デバイスおよび iOS デバイスに送信される際に経由するオプションのプロキシーを設定できます。プロキシーの設定には、**push.apns.proxy.** 構成プロパティーと **push.gcm.proxy.** 構成プロパティーを使用できます。詳しくは、[{{site.data.keys.mf_server }} プッシュ・サービスの JNDI プロパティーのリスト](../../installation-configuration/production/server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service)を参照してください。

## 次に使用するチュートリアル
{: #tutorials-to-follow-next }
これでサーバー・サイドがセットアップされたので、次はクライアント・サイドをセットアップし、受け取った通知を処理します。

* プッシュ通知の処理
    * [Cordova アプリケーションでのプッシュ通知の処理](../handling-push-notifications/cordova)
    * [iOS アプリケーションでのプッシュ通知の処理](../handling-push-notifications/ios)
    * [Android アプリケーションでのプッシュ通知の処理](../handling-push-notifications/android)
    * [Windows アプリケーションでのプッシュ通知の処理](../handling-push-notifications/windows)

* SMS 通知の処理
    * [Cordova アプリケーションでの SMS 通知の処理](../handling-sms-notifications/cordova)
    * [iOS アプリケーションでの SMS 通知の処理](../handling-sms-notifications/ios)
    * [Android アプリケーションでの SMS 通知の処理](../handling-sms-notifications/android)
