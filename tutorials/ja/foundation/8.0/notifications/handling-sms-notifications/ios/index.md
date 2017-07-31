---
layout: tutorial
title: iOS での SMS 通知の処理
breadcrumb_title: iOS での SMS の処理
relevantTo: [ios]
downloads:
  - name: Xcode プロジェクトのダウンロード
    url: https://github.com/MobileFirst-Platform-Developer-Center/SMSNotificationsSwift/tree/release80
weight: 9
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
SMS 通知は、プッシュ通知のサブセットです。したがって、最初に、[iOS でのプッシュ通知](../../)チュートリアルを必ずお読みください。

**前提条件**

* 必ず、以下のチュートリアルをお読みください。
  * [通知の概要](../../)
  * [{{ site.data.keys.product_adj }} 開発環境のセットアップ](../../../installation-configuration/#installing-a-development-environment)
  * [iOS アプリケーションへの {{ site.data.keys.product }} SDK の追加](../../../application-development/sdk/ios)
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

#### チャレンジ・ハンドラー
{: #challenge-handlers }
`push.mobileclient` スコープが**セキュリティー検査**にマップされる場合、プッシュ API を使用する前に、一致する**チャレンジ・ハンドラー**が存在し、登録済みであることを確認する必要があります。

#### 初期化
{: #initialization }
クライアント・アプリケーションが、正しいアプリケーション・コンテキストの MFPPush サービスに接続するために必要です。

* 最初に API メソッドを呼び出してから、その他の MFPPush API を使用する必要があります。
* 受け取ったプッシュ通知を処理するコールバック関数を登録します。

```swift
MFPPush.sharedInstance().initialize()
```

#### デバイスの登録
{: #register-device }
デバイスをプッシュ通知サービスに登録します。

```swift
MFPPush.sharedInstance().registerDevice(jsonOptions){ (response, error) -> Void in
     if error == nil {
         // Successfully registered
    } else {
        // Registration failed with error
    }
})
```

* **optionObject**: デバイスを登録するときに使用する電話番号を含んでいる `jsonOptions` です。例えば、次のとおりです。

```swift
let phoneNumber: String = self.phoneNumberTF.text!

let jsonOptions: [AnyHashable: Any] = [
    "phoneNumber": phoneNumber
]

if JSONSerialization.isValidJSONObject(jsonOptions) {
    // JSON is valid and can be sent with registerDevice request
}

```

> [プッシュ・デバイス登録 (POST) REST API](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_device_registration_post.html) を使用してデバイスを登録することもできます。

#### デバイスの登録抹消
{: #unregister-device }
プッシュ通知サービス・インスタンスからデバイスを登録抹消します。

```swift
MFPPush.sharedInstance().unregisterDevice { (response, error)  -> Void in
   if error == nil {
       // Unregistered successfully
    } else {
        // Failed to unregister
    }
})
```

## SMS サブスクライブ・サーブレットの使用
{: #using-an-sms-subscribe-servlet }
登録済みデバイスに通知を送信するときは REST API が使用されます。すべての形式の通知 (タグ通知、ブロードキャスト通知、および認証済み通知) を送信できます。

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
[ここをクリック](https://github.com/MobileFirst-Platform-Developer-Center/SMSNotificationsSwift/tree/release80) して Xcode プロジェクトをダウンロードします。

### サンプルの使用法
{: #sample-usage }
サンプルの README.md ファイルの指示に従ってください。
