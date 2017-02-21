---
layout: tutorial
title: Cordova でのプッシュ通知の処理
breadcrumb_title: Cordova
relevantTo: [cordova]
downloads:
  - name: Cordova プロジェクトのダウンロード
    url: https://github.com/MobileFirst-Platform-Developer-Center/PushNotificationsCordova/tree/release80
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
iOS、Android、および Windows の Cordova アプリケーションでプッシュ通知を受け取り、プッシュ通知を表示できるようにするには、**cordova-plugin-mfp-push** Cordova プラグインを Cordova プロジェクトに追加する必要があります。アプリケーションが構成されると、{{site.data.keys.product_adj }} が提供する通知 API を使用して、デバイスの登録や登録抹消、タグへのサブスクライブやアンサブスクライブ、および通知の処理を実行できます。このチュートリアルでは、Cordova アプリケーションでプッシュ通知を処理する方法について学習します。

> **注:** ある問題のために、認証済み通知は、現在 Cordova アプリケーションでは**サポートされていません**。しかし、予備手段が用意されており、各 `MFPPush` API 呼び出しを `WLAuthorizationManager.obtainAccessToken("push.mobileclient").then( ... );` でラップできます。提供されるサンプル・アプリケーションはこの予備手段を使用しています。

iOS でのサイレント通知または対話式通知については、以下を参照してください。

* [サイレント通知](../silent)
* [対話式通知](../interactive)

**前提条件:**

* 必ず、以下のチュートリアルをお読みください。
    * [{{site.data.keys.product_adj }} 開発環境のセットアップ](../../../installation-configuration/#installing-a-development-environment)
    * [Cordova アプリケーションへの {{site.data.keys.product }} SDK の追加](../../../application-development/sdk/cordova)
    * [プッシュ通知の概要](../../)
* ローカルで稼働している {{site.data.keys.mf_server }}、またはリモートで稼働している {{site.data.keys.mf_server }}
* 開発者ワークステーションに {{site.data.keys.mf_cli }} がインストールされていること
* 開発者ワークステーションに Cordova CLI がインストールされていること

#### ジャンプ先:
{: #jump-to }
* [通知構成](#notifications-configuration)
* [通知 API](#notifications-api)
* [プッシュ通知の処理](#handling-a-push-notification)
* [サンプル・アプリケーション](#sample-application)

## 通知構成
{: #notifications-configuration }
新しい Cordova プロジェクトを作成するか既存のプロジェクトを使用し、サポートされるプラットフォーム (iOS、Android、Windows) を 1 つ以上追加します。

> {{site.data.keys.product_adj }} Cordova SDK がプロジェクトにまだ存在しない場合は、[Cordova アプリケーションへの {{site.data.keys.product }} SDK の追加](../../../application-development/sdk/cordova)チュートリアルの説明に従ってください。

### プッシュ・プラグインの追加
{: #adding-the-push-plug-in }
1. **コマンド・ライン**・ウィンドウから Cordova プロジェクトのルートにナビゲートします。  

2. 以下のコマンドを実行して、プッシュ・プラグインを追加します。

   ```bash
   cordova plugin add cordova-plugin-mfp-push
   ```

3. 以下のコマンドを実行して、Cordova プロジェクトをビルドします。

   ```bash
   cordova build
   ```

### iOS プラットフォーム
{: #ios-platform }
iOS プラットフォームでは追加のステップが必要です。  
Xcode で、**「Capabilities」**画面を使用してアプリケーションのプッシュ通知を有効にします。

> <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> **重要:** アプリケーションに対して選択する bundleId は、先に Apple Developer サイトで作成した AppId に一致しなければなりません。[プッシュ通知の概要] チュートリアルを参照してください。

![Xcode 内の「Capabilities」の場所を示すイメージ](push-capability.png)

## 通知 API
{: #notifications-api }
### クライアント・サイド
{: #client-side }

| Javascript 関数 | 説明 |
| --- | --- |
| [`MFPPush.initialize(success, failure)`](#initialization) | MFPPush インスタンスを初期化します。 | 
| [`MFPPush.isPushSupported(success, failure)`](#is-push-supported) | デバイスがプッシュ通知をサポートするかどうか。 | 
| [`MFPPush.registerDevice(options, success, failure)`](#register-device) | デバイスをプッシュ通知サービスに登録します。 | 
| [`MFPPush.getTags(success, failure)`](#get-tags) | プッシュ通知サービス・インスタンス内で使用可能なすべてのタグを取得します。 | 
| [`MFPPush.subscribe(tag, success, failure)`](#subscribe) | 特定のタグにサブスクライブします。 | 
| [`MFPPush.getSubsciptions(success, failure)`](#get-subscriptions) | デバイスが現在サブスクライブしているタグを取得します。 | 
| [`MFPPush.unsubscribe(tag, success, failure)`](#unsubscribe) | 特定のタグからアンサブスクライブします。 | 
| [`MFPPush.unregisterDevice(success, failure)`](#unregister) | プッシュ通知サービスからデバイスを登録抹消します。 | 

### API 実装
{: #api-implementation }
#### 初期化
{: #initialization }
**MFPPush** インスタンスを初期化します。

- クライアント・アプリケーションが、正しいアプリケーション・コンテキストの MFPPush サービスに接続するために必要です。  
- 最初に API メソッドを呼び出してから、その他の MFPPush API を使用する必要があります。
- 受け取ったプッシュ通知を処理するコールバック関数を登録します。

```javascript
MFPPush.initialize (
    function(successResponse) {
        alert("Successfully intialized");
        MFPPush.registerNotificationsCallback(notificationReceived);
    },
    function(failureResponse) {
        alert("Failed to initialize");
    }
);
```

#### プッシュがサポートされるか
{: #is-push-supported }
デバイスがプッシュ通知をサポートするかどうかをチェックします。

```javascript
MFPPush.isPushSupported (
    function(successResponse) {
        alert("Push Supported: " + successResponse);
    },
    function(failureResponse) {
        alert("Failed to get push support status");
    }
);
```

#### デバイスの登録
{: #register-device }
デバイスをプッシュ通知サービスに登録します。必要なオプションがない場合、オプションは `null` に設定できます。


```javascript
var options = { };
MFPPush.registerDevice(
    options,
    function(successResponse) {
        alert("Successfully registered");
    },
    function(failureResponse) {
        alert("Failed to register");
    }
);
```

#### タグの取得
{: #get-tags }
プッシュ通知サービスからすべての使用可能なタグを取得します。

```javascript
MFPPush.getTags (
    function(tags) {
        alert(JSON.stringify(tags));
},
    function() {
        alert("Failed to get tags");
    }
);
```

#### サブスクライブ
{: #subscribe }
目的のタグにサブスクライブします。

```javascript
var tags = ['sample-tag1','sample-tag2'];

MFPPush.subscribe(
    tags,
    function(tags) {
        alert("Subscribed successfully");
    },
    function() {
        alert("Failed to subscribe");
    }
);
```

#### サブスクリプションの取得
{: #get-subscriptions }
デバイスが現在サブスクライブしているタグを取得します。

```javascript
MFPPush.getSubscriptions (
    function(subscriptions) {
        alert(JSON.stringify(subscriptions));
    },
    function() {
        alert("Failed to get subscriptions");
    }
);
```

#### アンサブスクライブ
{: #unsubscribe }
タグからアンサブスクライブします。

```javascript
var tags = ['sample-tag1','sample-tag2'];

MFPPush.unsubscribe(
    tags,
    function(tags) {
        alert("Unsubscribed successfully");
    },
    function() {
        alert("Failed to unsubscribe");
    }
);
```

#### 登録抹消
{: #unregister }
プッシュ通知サービス・インスタンスからデバイスを登録抹消します。

```javascript
MFPPush.unregisterDevice(
    function(successResponse) {
        alert("Unregistered successfully");
    },
    function() {
        alert("Failed to unregister");
    }
);
```

## プッシュ通知の処理
{: #handling-a-push-notification }
登録済みのコールバック関数内で応答オブジェクトを操作することで、受け取ったプッシュ通知を処理できます。

```javascript
var notificationReceived = function(message) {
    alert(JSON.stringify(message));
};
```

<img alt="サンプル・アプリケーションのイメージ" src="notifications-app.png" style="float:right"/>
## サンプル・アプリケーション
{: #sample-application }
[ここをクリック](https://github.com/MobileFirst-Platform-Developer-Center/PushNotificationsCordova/tree/release80) して Cordova プロジェクトをダウンロードします。

**注:** サンプルを実行するには、Android デバイス上に最新バージョンの Google Play Services がインストールされている必要があります。

### サンプルの使用法
{: #sample-usage }
サンプルの README.md ファイルの指示に従ってください。
