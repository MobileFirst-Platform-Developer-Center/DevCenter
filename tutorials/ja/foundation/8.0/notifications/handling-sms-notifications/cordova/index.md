---
layout: tutorial
title: Cordova での SMS 通知の処理
breadcrumb_title: Handling SMS in Cordova
relevantTo: [cordova]
weight: 8
downloads:
  - name: Download Cordova project
    url: https://github.com/MobileFirst-Platform-Developer-Center/SMSNotificationsCordova/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
SMS 通知は、プッシュ通知のサブセットです。したがって、最初に、[Cordova でのプッシュ通知](../../)チュートリアルを必ずお読みください。  
Cordova アプリケーションでの SMS 通知は、iOS および Android を対象にサポートされます。

**前提条件**

* 必ず、以下のチュートリアルをお読みください。
  * [通知の概要](../../)
  * [{{ site.data.keys.product_adj }} 開発環境のセットアップ](../../../installation-configuration/#installing-a-development-environment)
  * [iOS アプリケーションへの {{ site.data.keys.product }} SDK の追加](../../../application-development/sdk/cordova)
* ローカルで稼働している {{ site.data.keys.mf_server }}、またはリモートで稼働している {{ site.data.keys.mf_server }}
* 開発者ワークステーションに {{ site.data.keys.mf_cli }} がインストールされていること

#### ジャンプ先:
{: #jump-to }
* [通知 API](#notifications-api)   
* [SMS サブスクライブ・サーブレットの使用](#using-an-sms-subscribe-servlet)     
* [サンプル・アプリケーション](#sample-application)

## 通知 API
{: #notifications-api }
SMS 通知では、デバイスを登録するときに電話番号値が渡されます。

#### デバイスの登録
{: #register-device }
デバイスをプッシュ通知サービスに登録します。

```javascript
MFPPush.registerNotificationsCallback(notificationReceived);

function registerDevice() {
    var phoneNumber = prompt("Enter Your 10 digit phone number");
    if(phoneNumber != null &&  phoneNumber!="" &&  /^\d+$/.test(phoneNumber)) {
        var options = {};
        options.phoneNumber = phoneNumber;
        MFPPush.registerDevice(options, 
        function(successResponse) {
            alert("Successfully registered");
            enableButtons();
        }, function(failureResponse) {
            alert("Failed to register");
        });
        return true;
    }

    else {
        alert("Failed to register, You have entered invalid number");
    }
}
```

> [プッシュ・デバイス登録 (POST) REST API](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_device_registration_post.html) を使用してデバイスを登録することもできます。

## SMS サブスクライブ・サーブレットの使用
{: #using-an-sms-subscribe-servlet}
登録済みデバイスに通知を送信するときは REST API が使用されます。 すべての形式の通知 (タグ通知、ブロードキャスト通知、および認証済み通知) を送信できます。

通知を送信するために、POST を使用して REST エンドポイントへの要求が行われます (`imfpush/v1/apps/<application-identifier>/messages`)。  
URL の例を以下に示します。 

```bash
https://myserver.com:443/imfpush/v1/apps/com.sample.sms/messages
```

> すべてのプッシュ通知 REST API を確認するには、ユーザー資料の <a href="https://www.ibm.com/support/knowledgecenter/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/c_restapi_runtime.html">REST API ランタイム・サービス</a>のトピックを参照してください。

通知を送信するには、[通知の送信](../../sending-notifications)チュートリアルを参照してください。

<img alt="サンプル・アプリケーションのイメージ" src="sample-app.png" style="float:right"/>
## サンプル・アプリケーション
{: #sample-application }
[ここをクリック](https://github.com/MobileFirst-Platform-Developer-Center/SMSNotificationsSwift/tree/release80) して Cordova プロジェクトをダウンロードします。

**注:** サンプルを実行するには、Android デバイス上に最新バージョンの Google Play Services がインストールされている必要があります。

### サンプルの使用法
{: #sample-usage }
サンプルの README.md ファイルの指示に従ってください。
