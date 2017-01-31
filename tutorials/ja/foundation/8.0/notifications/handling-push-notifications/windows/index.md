---
layout: tutorial
title: Windows 8.1 Universal および Windows 10 UWP でのプッシュ通知の処理
breadcrumb_title: Windows
relevantTo: [windows]
weight: 7
downloads:
  - name: Windows 8.1 Universal プロジェクトのダウンロード
    url: https://github.com/MobileFirst-Platform-Developer-Center/PushNotificationsWin8/tree/release80
  - name: Windows 10 UWP プロジェクトのダウンロード
    url: https://github.com/MobileFirst-Platform-Developer-Center/PushNotificationsWin10/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
{{site.data.keys.product_adj }} が提供する通知 API を使用して、デバイスの登録や登録抹消、タグへのサブスクライブやアンサブスクライブを実行できます。このチュートリアルでは、C# を使用して、ネイティブの Windows 8.1 Universal アプリケーションおよび Windows 10 UWP アプリケーションでプッシュ通知を処理する方法について学習します。

**前提条件**

* 必ず、以下のチュートリアルをお読みください。
	* [プッシュ通知の概要](../../)
    * [{{site.data.keys.product_adj }} 開発環境のセットアップ](../../../installation-configuration/#installing-a-development-environment)
    * [Windows アプリケーションへの {{site.data.keys.product_adj }} SDK の追加](../../../application-development/sdk/windows-8-10)
* ローカルで稼働している {{site.data.keys.mf_server }}、またはリモートで稼働している {{site.data.keys.mf_server }}
* 開発者ワークステーションに {{site.data.keys.mf_cli }} がインストールされていること

#### ジャンプ先:
{: #jump-to }
* [通知構成](#notifications-configuration)
* [通知 API](#notifications-api)
* [プッシュ通知の処理](#handling-a-push-notification)

## 通知構成
{: #notifications-configuration }
新しい Visual Studio プロジェクトを作成するか、または既存のプロジェクトを使用します。  
{{site.data.keys.product_adj }} Native Windows SDK がプロジェクトにまだ存在しない場合は、[Windows アプリケーションへの {{site.data.keys.product_adj }} SDK の追加](../../../application-development/sdk/windows-8-10)チュートリアルの説明に従ってください。

### プッシュ SDK の追加
{: #adding-the-push-sdk }
1. 「ツール」→「NuGet パッケージ マネージャー」→「パッケージ マネージャー コンソール」を選択します。
2. {{site.data.keys.product_adj }} プッシュ・コンポーネントをインストールするプロジェクトを選択します。
3. **Install-Package IBM.MobileFirstPlatformFoundationPush** コマンドを実行して、{{site.data.keys.product_adj }} プッシュ SDK を追加します。

## WNS 構成の前提条件
{: pre-requisite-wns-configuration }
1. アプリケーションにトースト通知機能が備わっていることを確認します。これは Package.appxmanifest 内で有効にできます。
2. `Package Identity Name` と `Publisher` が、WNS に登録されている値で更新されている必要があります。
3. (オプション) TemporaryKey.pfx ファイルを削除します。

## 通知 API
{: #notifications-api }
### MFPPush インスタンス
{: #mfppush-instance }
すべての API 呼び出しは、`MFPPush` のインスタンスから呼び出される必要があります。これを行うには、変数 (`private MFPPush PushClient = MFPPush.GetInstance();` など) を作成し、その後、クラス内で一貫して `PushClient.methodName()` を呼び出します。

代わりに、プッシュ API メソッドにアクセスする必要があるインスタンスごとに `MFPPush.GetInstance().methodName()` を呼び出すこともできます。

### チャレンジ・ハンドラー
{: #challenge-handlers }
`push.mobileclient` スコープが**セキュリティー検査**にマップされる場合、プッシュ API を使用する前に、一致する**チャレンジ・ハンドラー**が存在し、登録済みであることを確認する必要があります。

> チャレンジ・ハンドラーについて詳しくは、[資格情報の検証](../../../authentication-and-security/credentials-validation/ios)チュートリアルを参照してください。

### クライアント・サイド
{: #client-side }
| C Sharp メソッド                                                                                                | 説明                                                             |
|--------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------|
| [`Initialize()`](#initialization)                                                                            | 提供されたコンテキストの MFPPush を初期化します。                               |
| [`IsPushSupported()`](#is-push-supported)                                                                    | デバイスがプッシュ通知をサポートするかどうか。                             |
| [`RegisterDevice(JObject options)`](#register-device--send-device-token)                  | デバイスをプッシュ通知サービスに登録します。               |
| [`GetTags()`](#get-tags)                                | プッシュ通知サービス・インスタンス内で使用可能なタグを取得します。 |
| [`Subscribe(String[] Tags)`](#subscribe)     | 指定されたタグにデバイスをサブスクライブします。                          |
| [`GetSubscriptions()`](#get-subscriptions)              | デバイスが現在サブスクライブしているタグをすべて取得します。               |
| [`Unsubscribe(String[] Tags)`](#unsubscribe) | 特定のタグからアンサブスクライブします。                                  |
| [`UnregisterDevice()`](#unregister)                     | プッシュ通知サービスからデバイスを登録抹消します。              |

#### 初期化
{: #initialization }
初期化は、クライアント・アプリケーションが MFPPush サービスに接続するために必要です。

* 最初に `Initialize` メソッドを呼び出してから、その他の MFPPush API を使用する必要があります。
* このメソッドは、受け取ったプッシュ通知を処理するコールバック関数を登録します。

```csharp
MFPPush.GetInstance().Initialize();
```

#### プッシュがサポートされるか
{: #is-push-supported }
デバイスがプッシュ通知をサポートするかどうかをチェックします。

```csharp
Boolean isSupported = MFPPush.GetInstance().IsPushSupported();

if (isSupported ) {
    // Push is supported
} else {
    // Push is not supported
}
```

#### デバイスの登録 &amp; デバイス・トークンの送信
{: #register-device--send-device-token }
デバイスをプッシュ通知サービスに登録します。

```csharp
JObject Options = new JObject();
MFPPushMessageResponse Response = await MFPPush.GetInstance().RegisterDevice(Options);         
if (Response.Success == true)
{
    // Successfully registered
} else {
    // Registration failed with error
}
```

#### タグの取得
{: #get-tags }
プッシュ通知サービスからすべての使用可能なタグを取得します。

```csharp
MFPPushMessageResponse Response = await MFPPush.GetInstance().GetTags();
if (Response.Success == true)
{
    Message = new MessageDialog("Avalibale Tags: " + Response.ResponseJSON["tagNames"]);
} else{
    Message = new MessageDialog("Failed to get Tags list");
}
```

#### サブスクライブ
{: #subscribe }
目的のタグにサブスクライブします。

```csharp
string[] Tags = ["Tag1" , "Tag2"];

// Get subscription tag
MFPPushMessageResponse Response = await MFPPush.GetInstance().Subscribe(Tags);
if (Response.Success == true)
{
    //successfully subscribed to push tag
}
else
{
    //failed to subscribe to push tags
}
```

#### サブスクリプションの取得
{: #get-subscriptions }
デバイスが現在サブスクライブしているタグを取得します。

```csharp
MFPPushMessageResponse Response = await MFPPush.GetInstance().GetSubscriptions();
if (Response.Success == true)
{
    Message = new MessageDialog("Avalibale Tags: " + Response.ResponseJSON["tagNames"]);
}
else
{
    Message = new MessageDialog("Failed to get subcription list...");
}
```

#### アンサブスクライブ
{: #unsubscribe }
タグからアンサブスクライブします。

```csharp
string[] Tags = ["Tag1" , "Tag2"];

// unsubscribe tag
MFPPushMessageResponse Response = await MFPPush.GetInstance().Unsubscribe(Tags);
if (Response.Success == true)
{
    //succes
}
else
{
    //failed to subscribe to tags
}
```

#### 登録抹消
{: #unregister }
プッシュ通知サービス・インスタンスからデバイスを登録抹消します。

```csharp
MFPPushMessageResponse Response = await MFPPush.GetInstance().UnregisterDevice();         
if (Response.Success == true)
{
    // Successfully registered
} else {
    // Registration failed with error
}
```

## プッシュ通知の処理
{: #handling-a-push-notification }
プッシュ通知を処理するためには、`MFPPushNotificationListener` をセットアップする必要があります。これは、以下のメソッドを実装することで実現できます。

1. MFPPushNotificationListener タイプのインターフェースを使用してクラスを作成します。

   ```csharp
   internal class NotificationListner : MFPPushNotificationListener
   {
        public async void onReceive(String properties, String payload)
   {
        // Handle push notification here      
   }
   }
   ```

2. `MFPPush.GetInstance().listen(new NotificationListner())` を呼び出すことで、このクラスがリスナーになるように設定します。
3. onReceive メソッド内でプッシュ通知を受け取り、目的の動作にあわせて通知を処理できます。


<img alt="サンプル・アプリケーションのイメージ" src="sample-app.png" style="float:right"/>

## Windows Universal Push Notifications Service
{: #windows-universal-push-notifications-service }
サーバー構成内で特定のポートをオープンする必要はありません。

WNS では通常の http 要求または https 要求が使用されます。


## サンプル・アプリケーション
{: #sample-application }
[ここをクリック](https://github.com/MobileFirst-Platform-Developer-Center/PushNotificationsWin8/tree/release80) して、Windows 8.1 Universal プロジェクトをダウンロードします。  
[ここをクリック](https://github.com/MobileFirst-Platform-Developer-Center/PushNotificationsWin8/tree/release80) して、Windows 10 UWP プロジェクトをダウンロードします。

### サンプルの使用法
{: #sample-usage }
サンプルの README.md ファイルの指示に従ってください。
