---
layout: tutorial
title: iOS アプリケーションからのリソース要求
breadcrumb_title: iOS
relevantTo: [ios]
downloads:
  - name: Download Xcode project
    url: https://github.com/MobileFirst-Platform-Developer-Center/ResourceRequestSwift/tree/release80
  - name: Download Adapter Maven project
    url: https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
{{ site.data.keys.product_adj }} アプリケーションは `WLResourceRequest` REST API を使用してリソースにアクセスできます。  
REST API は、すべてのアダプターおよび外部リソースで機能します。

**前提条件**:

- 必ずご使用のネイティブ iOS プロジェクトに [{{ site.data.keys.product }} SDK を追加](../../../application-development/sdk/ios)しておいてください。
- [アダプターの作成](../../../adapters/creating-adapters/)方法を参照してください。

## WLResourceRequest
{: #wlresourcerequest }
`WLResourceRequest` クラスは、アダプターまたは外部リソースに対するリソース要求を処理します。

`WLResourceRequest` オブジェクトを作成し、リソースへのパスと HTTP メソッドを指定します。  
使用可能なメソッドは、`WLHttpMethodGet`、`WLHttpMethodPost`、`WLHttpMethodPut`、および `WLHttpMethodDelete` です。

Objective-C

```objc
WLResourceRequest *request = [WLResourceRequest requestWithURL:[NSURL URLWithString:@"/adapters/JavaAdapter/users/"] method:WLHttpMethodGet];
```
Swift

```swift
let request = WLResourceRequest(
    URL: NSURL(string: "/adapters/JavaAdapter/users"),
    method: WLHttpMethodGet
)
```

* **JavaScript アダプター** の場合は、`/adapters/{AdapterName}/{procedureName}` を使用します。
* **Java アダプター**の場合は、`/adapters/{AdapterName}/{path}` を使用します。 `path` は、Java コードで `@Path` アノテーションをどのように定義したかによって決まります。 これには、使用した `@PathParam` も含まれます。
* プロジェクトの外部にあるリソースにアクセスするには、外部サーバーの要件のとおりに完全な URL を使用してください。
* **タイムアウト**: オプション。ミリ秒単位の要求タイムアウトです。

## 要求の送信
{: #sending-the-request }
`sendWithCompletionHandler` メソッドを使用して、リソースを要求します。  
取得したデータを処理するには、完了ハンドラーを指定します。

Objective-C

```objc
[request sendWithCompletionHandler:^(WLResponse *response, NSError *error) {
    if (error == nil){
        NSLog(@"%@", response.responseText);
    } else {
        NSLog(@"%@", error.description);
    }
}];
```
Swift

```swift
request.sendWithCompletionHandler { (response, error) -> Void in
    if(error == nil){
        NSLog(response.responseText)
    }
    else{
        NSLog(error.description)
    }
}
```

代替方法として、`sendWithDelegate` を使用して、`NSURLConnectionDataDelegate` と `NSURLConnectionDelegate` の両方のプロトコルに準拠するデリゲートを指定することができます。 これにより、バイナリー応答の処理など、よりきめ細かに応答を処理できます。   

## パラメーター
{: #parameters }
要求を送信する前に、必要に応じてパラメーターを追加したい場合があります。

### パス・パラメーター
{: #path-parameters }
上記の説明のとおり、**path** パラメーター (`/path/value1/value2`) は、`WLResourceRequest` オブジェクトの作成中に設定されます。

### 照会パラメーター
{: #query-parameters }
**query** パラメーター (`/path?param1=value1...`) を送信するには、パラメーターごとに `setQueryParameter` メソッドを使用します。

Objective-C

```objc
[request setQueryParameterValue:@"value1" forName:@"param1"];
[request setQueryParameterValue:@"value2" forName:@"param2"];
```
Swift

```swift
request.setQueryParameterValue("value1", forName: "param1")
request.setQueryParameterValue("value2", forName: "param2")
```

#### JavaScript アダプター
{: #javascript-adapters-query }
JavaScript アダプターは、名前のない順序付きのパラメーターを使用します。 パラメーターを JavaScript アダプターに渡すには、以下のように名前 `params` を使用してパラメーターの配列を設定します。

Objective-C

```objc
[request setQueryParameterValue:@"['value1', 'value2']" forName:@"params"];
```

Swift

```swift
request.setQueryParameterValue("['value1', 'value2']", forName: "params")
```

これは、`WLHttpMethodGet` と一緒に使用してください。

### フォーム・パラメーター
{: #form-parameters }
本体内の **form** パラメーターを送信するには、`sendWithCompletionHandler` ではなく、`sendWithFormParameters` を使用します。

Objective-C

```objc
//@FormParam("height")
NSDictionary *formParams = @{@"height":@"175"};

//Sending the request with Form parameters
[request sendWithFormParameters:formParams completionHandler:^(WLResponse *response, NSError *error) {
    if (error == nil){
        NSLog(@"%@", response.responseText);
    } else {
        NSLog(@"%@", error.description);
    }
}];
```
Swift

```swift
//@FormParam("height")
let formParams = ["height":"175"]

//Sending the request with Form parameters
request.sendWithFormParameters(formParams) { (response, error) -> Void in
    if(error == nil){
        NSLog(response.responseText)
    }
    else{
        NSLog(error.description)
    }
}
```

#### JavaScript アダプター
{: #javascript-adapters-form }
JavaScript アダプターは、名前のない順序付きのパラメーターを使用します。 パラメーターを JavaScript アダプターに渡すには、以下のように名前 `params` を使用してパラメーターの配列を設定します。

Objective-C

```objc
NSDictionary *formParams = @{@"params":@"['value1', 'value2']"};
```
Swift

```swift
let formParams = ["params":"['value1', 'value2']"]
```

これは、`WLHttpMethodPost` と一緒に使用してください。

### ヘッダー・パラメーター
{: #header-parameters }
HTTP ヘッダーとしてパラメーターを送信するには、`setHeaderValue` API を使用します。

Objective-C

```objc
//@HeaderParam("Date")
[request setHeaderValue:@"2015-06-06" forName:@"birthdate"];
```
Swift

```swift
//@HeaderParam("Date")
request.setHeaderValue("2015-06-06", forName: "birthdate")
```

### その他のカスタム本体パラメーター
{: #other-custom-body-parameters }

- `sendWithBody` を使用して、本体に任意のストリングを設定できます。
- `sendWithJSON` を使用して、本体に任意のディクショナリーを設定できます。
- `sendWithData` を使用して、本体に任意の `NSData` を設定できます。

### completionHandler およびデリゲートのためのコールバック・キュー
応答の受信中に UI がブロックされるのを回避するには、API の `sendWithCompletionHandler` セットおよび `sendWithDelegate` セットに対して completionHandler ブロックまたはデリゲートを実行するプライベート・コールバック・キューを指定します。

#### Objective-C

```objc
//creating callback queue
dispatch_queue_t completionQueue = dispatch_queue_create("com.ibm.mfp.app.callbackQueue", DISPATCH_QUEUE_SERIAL);

//Sending the request with callback queue
[request sendWithCompletionHandler:completionQueue completionHandler:^(WLResponse *response, NSError *error) {
    if (error == nil){
        NSLog(@"%@", response.responseText);
    } else {
        NSLog(@"%@", error.description);
    }
}];
```
#### Swift

```swift
//creating callback queue
var completionQueue = dispatch_queue_create("com.ibm.mfp.app.callbackQueue", DISPATCH_QUEUE_SERIAL)

//Sending the request with callback queue
request.sendWithCompletionHandler(completionQueue) { (response, error) -> Void in
  if (error == nil){
      NSLog(@"%@", response.responseText);
  } else {
      NSLog(@"%@", error.description);
    }
}
```

## 応答
{: #the response }
`response` オブジェクトには応答データが含まれており、そのメソッドとプロパティーを使用して必要な情報を取得することができます。 よく使用されるプロパティーは、`responseText` (ストリング)、`responseJSON` (ディクショナリー) (応答が JSON の場合)、および `status` (整数) (応答の HTTP 状況) です。

`response` オブジェクトおよび `error` オブジェクトを使用して、アダプターから取り出されたデータを取得します。

## 詳細情報
{: #for-more-information }
> WLResourceRequest について詳しくは、[API リファレンスを参照してください](../../../api/client-side-api/objc/client/)。

<img alt="サンプル・アプリケーションのイメージ" src="resource-request-success-ios.png" style="margin-left: 15px; float:right"/>
## サンプル・アプリケーション
{: #sample-application }
ResourceRequestSwift プロジェクトには、Swift で実装され、Java アダプターを使用してリソース要求を行う iOS アプリケーションが含まれています。  
アダプター Maven プロジェクトには、リソース要求呼び出し中に使用される Java アダプターが含まれています。

[ここをクリック](https://github.com/MobileFirst-Platform-Developer-Center/ResourceRequestSwift/tree/release80) して iOS プロジェクトをダウンロードします。  
[ここをクリック](https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80) してアダプター Maven プロジェクトをダウンロードします。

### サンプルの使用法
{: #sample-usage }
サンプルの README.md ファイルの指示に従ってください。

#### iOS 9 についての注意:
{: #note-about-ios-9 }

> Xcode 7 を使用すると、デフォルトで [Application Transport Security (ATS)](https://developer.apple.com/library/ios/releasenotes/General/WhatsNewIniOS/Articles/iOS9.html#//apple_ref/doc/uid/TP40016198-SW14) が使用可能になります。 チュートリアルを実行するには、ATS を使用不可にしてください ([続きを読む](http://iosdevtips.co/post/121756573323/ios-9-xcode-7-http-connect-server-error))。
>   1. Xcode で、右クリックにより**「[プロジェクト]/info.plist ファイル」→「指定して開く」→「ソース・コード」**を選択します。
>   2. 以下を貼り付けます。
>
```xml
>      <key>NSAppTransportSecurity</key>
>      <dict>
>            <key>NSAllowsArbitraryLoads</key>
>            <true/>
>      </dict>
```
