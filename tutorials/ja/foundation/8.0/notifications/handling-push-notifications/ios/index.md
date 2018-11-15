---
layout: tutorial
title: iOS でのプッシュ通知の処理
breadcrumb_title: iOS
relevantTo: [ios]
weight: 5
downloads:
  - name: Download Xcode project
    url: https://github.com/MobileFirst-Platform-Developer-Center/PushNotificationsSwift/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
{{ site.data.keys.product_adj }} が提供する通知 API を使用して、デバイスの登録や登録抹消、タグへのサブスクライブやアンサブスクライブを実行できます。 このチュートリアルでは、Swift を使用して iOS アプリケーションでプッシュ通知を処理する方法について学習します。

サイレント通知または対話式通知については、以下を参照してください。

* [サイレント通知](../silent)
* [対話式通知](../interactive)

**前提条件**

* 必ず、以下のチュートリアルをお読みください。
	* [プッシュ通知の概要](../../)
    * [{{ site.data.keys.product_adj }} 開発環境のセットアップ](../../../installation-configuration/#installing-a-development-environment)
    * [iOS アプリケーションへの {{ site.data.keys.product }} SDK の追加](../../../application-development/sdk/ios)
* ローカルで稼働している {{ site.data.keys.mf_server }}、またはリモートで稼働している {{ site.data.keys.mf_server }}
* 開発者ワークステーションに {{ site.data.keys.mf_cli }} がインストールされていること


### ジャンプ先:
{: #jump-to }
* [通知構成](#notifications-configuration)
* [通知 API](#notifications-api)
* [プッシュ通知の処理](#handling-a-push-notification)


### 通知構成
{: #notifications-configuration }
新しい Xcode プロジェクトを作成するか、または既存のプロジェクトを使用します。
{{ site.data.keys.product_adj }} Native iOS SDK がプロジェクトにまだ存在しない場合は、[iOS  アプリケーションへの {{ site.data.keys.product }} SDK の追加](../../../application-development/sdk/ios)チュートリアルの説明に従ってください。


### プッシュ SDK の追加
{: #adding-the-push-sdk }
1. プロジェクトの既存の **podfile** を開き、以下の行を追加します。

   ```xml
   use_frameworks!

   platform :ios, 8.0
   target "Xcode-project-target" do
        pod 'IBMMobileFirstPlatformFoundation'
        pod 'IBMMobileFirstPlatformFoundationPush'
   end

   post_install do |installer|
        workDir = Dir.pwd

        installer.pods_project.targets.each do |target|
            debugXcconfigFilename = "#{workDir}/Pods/Target Support Files/#{target}/#{target}.debug.xcconfig"
            xcconfig = File.read(debugXcconfigFilename)
            newXcconfig = xcconfig.gsub(/HEADER_SEARCH_PATHS = .*/, "HEADER_SEARCH_PATHS = ")
            File.open(debugXcconfigFilename, "w") { |file| file << newXcconfig }

            releaseXcconfigFilename = "#{workDir}/Pods/Target Support Files/#{target}/#{target}.release.xcconfig"
            xcconfig = File.read(releaseXcconfigFilename)
            newXcconfig = xcconfig.gsub(/HEADER_SEARCH_PATHS = .*/, "HEADER_SEARCH_PATHS = ")
            File.open(releaseXcconfigFilename, "w") { |file| file << newXcconfig }
        end
   end
   ```
    - 使用する Xcode プロジェクトのターゲットの名前で **Xcode-project-target** を置き換えてください。

2. **podfile** を保存して閉じます。
3. **コマンド・ライン**・ウィンドウからプロジェクトのルート・フォルダーにナビゲートします。
4. コマンド `pod install` を実行します。
5. **.xcworkspace** ファイルを使用して、プロジェクトを開きます。

## 通知 API
{: #notifications-api }
### MFPPush インスタンス
{: #mfppush-instance }
すべての API 呼び出しは、`MFPPush` のインスタンスから呼び出される必要があります。  これを行うには、ビュー・コントローラー内で `var` を使用し (`var push = MFPPush.sharedInstance();` など)、その後、ビュー・コントローラー内で一貫して `push.methodName()` を呼び出します。

代わりに、プッシュ API メソッドにアクセスする必要があるインスタンスごとに `MFPPush.sharedInstance().methodName()` を呼び出すこともできます。

### チャレンジ・ハンドラー
{: #challenge-handlers }
`push.mobileclient` スコープが**セキュリティー検査**にマップされる場合、プッシュ API を使用する前に、一致する**チャレンジ・ハンドラー**が存在し、登録済みであることを確認する必要があります。

> チャレンジ・ハンドラーについて詳しくは、[資格情報の検証](../../../authentication-and-security/credentials-validation/ios)チュートリアルを参照してください。

### クライアント・サイド
{: #client-side }

| Swift メソッド | 説明  |
|---------------|--------------|
| [`initialize()`](#initialization) | 提供されたコンテキストの MFPPush を初期化します。 |
| [`isPushSupported()`](#is-push-supported) | デバイスがプッシュ通知をサポートするかどうか。 |
| [`registerDevice(completionHandler: ((WLResponse!, NSError!) -> Void)!)`](#register-device--send-device-token) | デバイスをプッシュ通知サービスに登録します。|
| [`sendDeviceToken(deviceToken: NSData!)`](#register-device--send-device-token) | デバイス・トークンをサーバーに送信します。 |
| [`getTags(completionHandler: ((WLResponse!, NSError!) -> Void)!)`](#get-tags) | プッシュ通知サービス・インスタンス内で使用可能なタグを取得します。 |
| [`subscribe(tagsArray: [AnyObject], completionHandler: ((WLResponse!, NSError!) -> Void)!)`](#subscribe) | 指定されたタグにデバイスをサブスクライブします。 |
| [`getSubscriptions(completionHandler: ((WLResponse!, NSError!) -> Void)!)`](#get-subscriptions)  | デバイスが現在サブスクライブしているタグをすべて取得します。 |
| [`unsubscribe(tagsArray: [AnyObject], completionHandler: ((WLResponse!, NSError!) -> Void)!)`](#unsubscribe) | 特定のタグからアンサブスクライブします。 |
| [`unregisterDevice(completionHandler: ((WLResponse!, NSError!) -> Void)!)`](#unregister) | プッシュ通知サービスからデバイスを登録抹消します。              |

#### 初期化
{: #initialization }
初期化は、クライアント・アプリケーションが MFPPush サービスに接続するために必要です。

* 最初に `initialize` メソッドを呼び出してから、その他の MFPPush API を使用する必要があります。
* このメソッドは、受け取ったプッシュ通知を処理するコールバック関数を登録します。

```swift
MFPPush.sharedInstance().initialize();
```

#### プッシュがサポートされるか
{: #is-push-supported }
デバイスがプッシュ通知をサポートするかどうかをチェックします。

```swift
let isPushSupported: Bool = MFPPush.sharedInstance().isPushSupported()

if isPushSupported {
    // Push is supported
} else {
    // Push is not supported
}
```

#### デバイスの登録 &amp; デバイス・トークンの送信
{: #register-device--send-device-token }
デバイスをプッシュ通知サービスに登録します。

```swift
MFPPush.sharedInstance().registerDevice(nil) { (response, error) -> Void in
    if error == nil {
        self.enableButtons()
        self.showAlert("Registered successfully")
        print(response?.description ?? "")
    } else {
        self.showAlert("Registrations failed.  Error \(error?.localizedDescription)")
        print(error?.localizedDescription ?? "")
    }
}
```

<!--`options` = `[NSObject : AnyObject]` which is an optional parameter that is a dictionary of options to be passed with your register request, sends the device token to the server to register the device with its unique identifier.-->

```swift
MFPPush.sharedInstance().sendDeviceToken(deviceToken)
```

> **注:** これは一般的に `didRegisterForRemoteNotificationsWithDeviceToken` メソッドの **AppDelegate** 内で呼び出されます。

#### タグの取得
{: #get-tags }
プッシュ通知サービスからすべての使用可能なタグを取得します。

```swift
MFPPush.sharedInstance().getTags { (response, error) -> Void in
    if error == nil {
        print("The response is: \(response)")
        print("The response text is \(response?.responseText)")
        if response?.availableTags().isEmpty == true {
            self.tagsArray = []
            self.showAlert("There are no available tags")
        } else {
            self.tagsArray = response!.availableTags() as! [String]
            self.showAlert(String(describing: self.tagsArray))
            print("Tags response: \(response)")
        }
    } else {
        self.showAlert("Error \(error?.localizedDescription)")
        print("Error \(error?.localizedDescription)")
    }
}
```


#### サブスクライブ
{: #subscribe }
目的のタグにサブスクライブします。

```swift
var tagsArray: [String] = ["Tag 1", "Tag 2"]

MFPPush.sharedInstance().subscribe(self.tagsArray) { (response, error)  -> Void in
    if error == nil {
        self.showAlert("Subscribed successfully")
        print("Subscribed successfully response: \(response)")
    } else {
        self.showAlert("Failed to subscribe")
        print("Error \(error?.localizedDescription)")
    }
}
```


#### サブスクリプションの取得
{: #get-subscriptions }
デバイスが現在サブスクライブしているタグを取得します。

```swift
MFPPush.sharedInstance().getSubscriptions { (response, error) -> Void in
   if error == nil {
       var tags = [String]()
       let json = (response?.responseJSON)! as [AnyHashable: Any]
       let subscriptions = json["subscriptions"] as? [[String: AnyObject]]
       for tag in subscriptions! {
           if let tagName = tag["tagName"] as? String {
               print("tagName: \(tagName)")
               tags.append(tagName)
           }
       }
       self.showAlert(String(describing: tags))
   } else {
       self.showAlert("Error \(error?.localizedDescription)")
       print("Error \(error?.localizedDescription)")
   }
}
```


#### アンサブスクライブ
{: #unsubscribe }
タグからアンサブスクライブします。

```swift
var tags: [String] = {"Tag 1", "Tag 2"};

// Unsubscribe from tags
MFPPush.sharedInstance().unsubscribe(self.tagsArray) { (response, error)  -> Void in
    if error == nil {
        self.showAlert("Unsubscribed successfully")
        print(String(describing: response?.description))
    } else {
        self.showAlert("Error \(error?.localizedDescription)")
        print("Error \(error?.localizedDescription)")
    }
}
```

#### 登録抹消
{: #unregister }
プッシュ通知サービス・インスタンスからデバイスを登録抹消します。

```swift
MFPPush.sharedInstance().unregisterDevice { (response, error)  -> Void in
   if error == nil {
       // Disable buttons
       self.disableButtons()
       self.showAlert("Unregistered successfully")
       print("Subscribed successfully response: \(response)")
   } else {
       self.showAlert("Error \(error?.localizedDescription)")
       print("Error \(error?.localizedDescription)")
   }
}
```

## プッシュ通知の処理
{: #handling-a-push-notification }

プッシュ通知は、ネイティブ iOS フレームワークによって直接的に処理されます。 アプリケーション・ライフサイクルに応じて、いろいろなメソッドが iOS フレームワークによって呼び出されます。

例えば、アプリケーションの実行中に単純な通知を受け取った場合は、**AppDelegate** の `didReceiveRemoteNotification` がトリガーされます。

```swift
func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
    print("Received Notification in didReceiveRemoteNotification \(userInfo)")
    // display the alert body
      if let notification = userInfo["aps"] as? NSDictionary,
        let alert = notification["alert"] as? NSDictionary,
        let body = alert["body"] as? String {
          showAlert(body)
        }
}
```

> iOS での通知の処理について詳しくは、Apple の資料 (http://bit.ly/1ESSGdQ) を参照してください。

<img alt="サンプル・アプリケーションのイメージ" src="notifications-app.png" style="float:right"/>

## サンプル・アプリケーション
{: #sample-application }
[ここをクリック](https://github.com/MobileFirst-Platform-Developer-Center/PushNotificationsSwift/tree/release80) して Xcode プロジェクトをダウンロードします。

### サンプルの使用法
{: #sample-usage }
サンプルの README.md ファイルの指示に従ってください。
