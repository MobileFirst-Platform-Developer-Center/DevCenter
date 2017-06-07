---
layout: tutorial
title: クライアント・アプリケーションでの Analytics API の使用
breadcrumb_title: Analytics API
relevantTo: [ios,android,javascript]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }

{{ site.data.keys.mf_analytics_full }} は、アプリケーションについての Analytics データの収集を開始するのを支援するクライアント・サイド API を提供します。このチュートリアルでは、クライアント・アプリケーション上での Analytics サポートのセットアップ方法について説明し、使用可能な API をリストします。

#### ジャンプ先
{: #jump-to }

* [クライアント・サイドでの Analytics の構成](#configuring-analytics-on-the-client-side)
* [Analytics データの送信](#sending-analytics-data)
* [クライアント・イベントの有効化/無効化](#enablingdisabling-client-event-types)
* [カスタム・イベント](#custom-events)
* [ユーザーのトラッキング](#tracking-users)

## クライアント・サイドでの Analytics の構成
{: #configuring-analytics-on-the-client-side }

{{ site.data.keys.mf_analytics }} が提供する事前定義データの収集を開始するには、事前に Analytics サポートを初期設定するために対応するライブラリーをインポートする必要があります。

### JavaScript (Cordova)
{: #javascript-cordova }

Cordova アプリケーションではセットアップは必要なく、初期設定は組み込まれています。  

### JavaScript (Web)
{: #javascript-web }

Web アプリケーションでは、分析 JavaScript ファイルを参照する必要があります。最初に必ず {{ site.data.keys.product_adj }} Web SDK を追加しておいてください。詳細については、[『Web アプリケーションへの {{ site.data.keys.product_adj }} SDK の追加』](../../application-development/sdk/web) チュートリアルを参照してください。  

{{ site.data.keys.product_adj }} Web SDK を追加した方法に応じて、以下のいずれかの方法で進めます。


以下のように、`HEAD` エレメント内の {{ site.data.keys.mf_analytics }} を参照します。

```html
<head>
    ...
    <script type="text/javascript" src="node_modules/ibm-mfp-web-sdk/lib/analytics/ibmmfpfanalytics.js"></script>
    <script type="text/javascript" src="node_modules/ibm-mfp-web-sdk/ibmmfpf.js"></script>
</head>
```

または、RequireJS を使用している場合は、以下を作成します。

```javascript
require.config({
	'paths': {
		'ibmmfpfanalytics': 'node_modules/ibm-mfp-web-sdk/lib/analytics/ibmmfpfanalytics',
		'mfp': 'node_modules/ibm-mfp-web-sdk/ibmmfpf'
	}
});

require(['ibmmfpfanalytics','mfp'], function(ibmmfpfanalytics, WL) {
    // application logic.
});
```

ユーザー独自の名前空間を選択して、「ibmmfpfanalytics」と置き換えることができることに留意してください。


```javascript
ibmmfpfanalytics.logger.config({analyticsCapture: true});
```

 **重要**:  Cordova と Web SDK 間には JavaScript API においていくつかの相違点があります。ユーザー資料の[『API リファレンス』トピック](../../api/)を参照してください。

### iOS
{: #ios }

#### WLAnalytics ライブラリーのインポート
{: #importing-the-wlanalytics-library }

**Objective-C**

```objc
import "WLAnalytics.h"
```

**Swift**

```Swift
import IBMMobileFirstPlatformFoundation
```

#### Analytics の初期設定
{: #initialize-analytics }

**Objective-C**  
セットアップは不要です。デフォルトで事前に初期設定されています。

**Swift**  
**WLAnalytics** クラスの他のメソッドを呼び出す前に、`WLAnalytics.sharedInstance()` を呼び出します。

### Android
{: #android }

#### WLAnalytics のインポート
{: #import-wlanalytics }

```java
import com.worklight.common.WLAnalytics;
```

#### Analytics の初期設定
{: #initialize-analytics }

メイン・アクティビティーの `onCreate` メソッド内に以下を含めます。

```java
WLAnalytics.init(this.getApplication());
```


## クライアント・イベント・タイプの有効化/無効化
{: #enablingdisabling-client-event-types }

Analytics API では、開発者は {{ site.data.keys.mf_analytics_console }} 上で視覚化したいイベントについての Analytics の収集を自由に有効または無効にすることができます。

{{ site.data.keys.mf_analytics }} API により、以下のメトリックのキャプチャーが可能になります。

* **ライフサイクル・イベント**: アプリケーション使用比率、使用所要時間、アプリケーション異常終了比率
* **ネットワーク使用**: API 呼び出し頻度の明細、ネットワーク・パフォーマンス・メトリック
* **ユーザー**: 指定されたユーザー ID で識別されるアプリケーション・ユーザー
* **カスタム分析**: アプリケーション開発者によって定義されるカスタム・キー/値ペア

Analytics API の初期設定は、Cordova アプリケーションであっても、ネイティブ・コードで作成されなければなりません。

 * アプリケーションの使用をキャプチャーするには、関連イベントが発生してそのデータがサーバーに送信される前に
アプリケーション・ライフサイクル・イベント・リスナーを登録する必要があります。
 * ファイル・システムまたはネイティブ言語およびデバイス機能を使用するには、API を初期設定する必要があります。
ネイティブ・デバイス機能 (ファイル・システムなど) を必要とする方法で API が使用されるが、初期設定されていないと、API 呼び出しは失敗します。
Android では特に、この動作になります。

**注**: Cordova アプリケーションを構築するにあたり、JavaScript Analytics API には `LIFECYCLE` イベントおよび `NETWORK` イベントの収集を有効にしたり無効にしたりするメソッドがありません。言い換えると、Cordova アプリケーションは、`LIFECYCLE` イベントおよび `NETWORK` イベントがデフォルトで事前に有効になった状態で出荷されます。これらのイベントを無効にしたい場合は、[『クライアント・ライフサイクル・イベント』](#client-lifecycle-events)および[『クライアント・ネットワーク・イベント』](#client-lifecycle-events)を参照してください。

### クライアント・ライフサイクル・イベント
{: #client-lifecycle-events }

Analytics SDK が構成された後、ユーザーのデバイス上でアプリケーション・セッションの記録が開始します。{{ site.data.keys.mf_analytics }} でのセッションは、アプリケーションがフォアグラウンドからバックグラウンドに移動され、これにより、{{ site.data.keys.mf_analytics_console_short }} でセッションが作成されたときに記録されます。

セッションを記録するようにデバイスがセットアップされ、ユーザーがデータを送信するとすぐに、以下に示すようにデータが {{ site.data.keys.mf_analytics_console_short }} に設定されているのを確認できます。

![セッション-グラフ](analytics-app-sessions.png)

{{ site.data.keys.mf_analytics_short }} API を使用して、アプリケーション・セッションの収集を有効または無効にします。

#### JavaScript
{: #javascript }

**Web**  
クライアント・ライフサイクル・イベントを使用するには、以下のようにして Analytics を初期設定します。

```javascript
ibmmfpfanalytics.logger.config({analyticsCapture: true});
```

**Cordova**  
ライフサイクル・イベントのキャプチャーを有効にするには、Cordova アプリケーションのネイティブ・プラットフォームで初期設定する必要があります。

* iOS プラットフォームの場合:
	* **「[Cordova application root folder]」→「platforms」→「ios」→「Classes」**フォルダーを開き、**AppDelegate.m** (Objective-C) ファイルまたは **AppDelegate.swift** (Swift) ファイルを見つけます。
	* 下記の iOS ガイドに従って、`LIFECYCLE` アクティビティーを有効または無効にします。
	* コマンド `cordova build` を実行して、Cordova プロジェクトを作成します。

* Android プラットフォームの場合:
	* **「[Cordova application root folder]」→「platforms」→「android」→「src」→「com」→「sample」→「[app-name]」→「MainActivity.java」**ファイルを開きます。
	* `onCreate` メソッドを探し、下記の Android ガイドに従って、`LIFECYCLE` アクティビティーを有効または無効にします。
	* コマンド `cordova build` を実行して、Cordova プロジェクトを作成します。

#### Android
{: #android }

クライアント・ライフサイクル・イベントのロギングを有効にするには、以下のようにします。

```java
WLAnalytics.addDeviceEventListener(DeviceEvent.LIFECYCLE);
```

クライアント・ライフサイクル・イベントのロギングを無効にするには、以下のようにします。

```java
WLAnalytics.removeDeviceEventListener(DeviceEvent.LIFECYCLE);
```

#### iOS
{: #ios }

クライアント・ライフサイクル・イベントのロギングを有効にするには、以下のようにします。

**Objective-C:**

```objc
[[WLAnalytics sharedInstance] addDeviceEventListener:LIFECYCLE];
```

**Swift:**

```swift
WLAnalytics.sharedInstance().addDeviceEventListener(LIFECYCLE);
```

クライアント・ライフサイクル・イベントのロギングを無効にするには、以下のようにします。

**Objective-C:**

```objc
[[WLAnalytics sharedInstance] removeDeviceEventListener:LIFECYCLE];
```

**Swift:**

```swift
WLAnalytics.sharedInstance().removeDeviceEventListener(LIFECYCLE);
```

### クライアント・ネットワーク・アクティビティー
{: #client-network-activities }

アダプターおよびネットワークについての収集は、クライアントとサーバーの 2 つの異なるロケーションで発生します。

* ユーザーが `NETWORK` デバイス・イベントについて収集を開始すると、クライアントは往復時間およびペイロード・サイズなどの情報を収集します。

* サーバーは、サーバー処理時間、アダプターの使用状況、使用されたプロシージャーなどのバックエンド情報を収集します。

クライアントとサーバーはそれぞれ独自の情報を収集するため、クライアントが収集を行うように構成されるまでグラフにはデータが表示されません。クライアントを構成するには、`NETWORK` デバイス・イベントの収集を開始し、それをサーバーに送信する必要があります。

#### JavaScript
{: #javascript }

**Web**  
クライアント・ネットワーク・イベントを使用するには、以下のようにして Analytics を初期設定します。

```javascript
ibmmfpfanalytics.logger.config({analyticsCapture: true});
```

**Cordova**  
ネットワーク・イベントのキャプチャーを有効にするには、Cordova アプリケーションのネイティブ・プラットフォームで初期設定する必要があります。

* iOS プラットフォームの場合:
	* **「[Cordova application root folder]」→「platforms」→「ios」→「Classes」**フォルダーを開き、**AppDelegate.m** (Objective-C) ファイルまたは **AppDelegate.swift** ファイルを見つけます。
	* 下記の iOS ガイドに従って、`NETWORK` アクティビティーを有効または無効にします。
	* コマンド `cordova build` を実行して、Cordova プロジェクトを作成します。

* Android プラットフォームの場合: 無効にするメイン・アクティビティーのサブアクティビティーにナビゲートします。
	* **「[Cordova application root folder]」→「platforms」→「ios」→「src」→「com」→「sample」→「[app-name]」→「MainActivity.java」**ファイルを開きます。
	* `onCreate` メソッドを探し、下記の Android ガイドに従って、`NETWORK` アクティビティーを有効または無効にします。
	* コマンド `cordova build` を実行して、Cordova プロジェクトを作成します。

#### iOS
{: #ios }

クライアント・ネットワーク・イベントのロギングを有効にするには、以下のようにします。

**Objective-C:**

```objc
[[WLAnalytics sharedInstance] addDeviceEventListener:NETWORK];
```

**Swift:**

```swift
WLAnalytics.sharedInstance().addDeviceEventListener(NETWORK);
```

クライアント・ネットワーク・イベントのロギングを無効にするには、以下のようにします。

**Objective-C:**

```objc
[[WLAnalytics sharedInstance] removeDeviceEventListener:NETWORK];
```

**Swift:**

```swift
WLAnalytics.sharedInstance().removeDeviceEventListener(NETWORK);
```

#### Android
{: #android }

クライアント・ネットワーク・イベントのロギングを有効にするには、以下のようにします。

```java
WLAnalytics.addDeviceEventListener(DeviceEvent.NETWORK);
```

クライアント・ネットワーク・イベントのロギングを無効にするには、以下のようにします。

```java
WLAnalytics.removeDeviceEventListener(DeviceEvent.NETWORK);
```

## カスタム・イベント
{: #custom-events }

カスタム・イベントを作成するには、以下の API メソッドを使用します。

#### JavaScript (Cordova)
{: #javascript-cordova }

```javascript
WL.Analytics.log({"key" : 'value'});
```

#### JavaScript (Web)
{: #javascript-web }

Web API では、`addEvent` メソッドでカスタム・データが送信されます。

```javascript
ibmmfpfanalytics.addEvent({'Purchases':'radio'});
ibmmfpfanalytics.addEvent({'src':'App landing page','target':'About page'});
```

#### Android
{: #android }

最初の 2 つの構成を設定した後、以下の例のようにしてデータをログに記録し始めることができます。

```java
JSONObject json = new JSONObject();
try {
    json.put("key", "value");
} catch (JSONException e) {
    // TODO Auto-generated catch block
    e.printStackTrace();
}

WLAnalytics.log("Message", json);
```

#### iOS
{: #ios }

WLAnalytics をインポートした後、以下のようにして API を使用してカスタム・データを収集できるようになります。

**Objective-C:**

```objc
NSDictionary *inventory = @{
    @"property" : @"value",
};

[[WLAnalytics sharedInstance] log:@"Custom event" withMetadata:inventory];
[[WLAnalytics sharedInstance] send];
```

**Swift:**

```swift
let metadata: [NSObject: AnyObject] = ["foo": "bar"];  
WLAnalytics.sharedInstance().log("hello", withMetadata: metadata);
```

## ユーザーのトラッキング
{: #tracking-users }

個々のユーザーをトラッキングするには、以下のように `setUserContext` メソッドを使用します。

#### Cordova
{: #cordova }

サポートされません。

#### Web アプリケーション
{: #web-applications }

```javascript
ibmmfpfanalytics.setUserContext(user);
```

#### iOS
{: #ios }

**Objective-C**

```objc
[[WLAnalytics sharedInstance] setUserContext:@"John Doe"];
```

**Swift**

```swift
WLAnalytics.sharedInstance().setUserContext("John Doe")
```

#### Android
{: #android }

```java
WLAnalytics.setUserContext("John Doe");
```

個々のユーザーのトラッキングを解除するには、以下のように `unsetUserContext` メソッドを使用します。

#### Cordova
{: #cordova }

サポートされません。

#### Web アプリケーション
{: #web-applications }

{{ site.data.keys.product_adj }} Web SDK に `unsetUserContext` はありません。ユーザー・セッションは、別のユーザー・セッションが `ibmmfpfanalytics.setUserContext(user)` に作成されない限り、30 分活動が無ければ終了します。

#### iOS
{: #ios }

**Objective-C**

```objc
[[WLAnalytics sharedInstance] unsetUserContext];
```

**Swift**

```swift
WLAnalytics.sharedInstance().unsetUserContext
```

#### Android
{: #android }

```java
WLAnalytics.unsetUserContext();
```

## Analytics データの送信
{: #sending-analytics-data }

Analytics の送信は、Analytics サーバー上でクライアント・サイドの分析を表示するための重要なステップです。構成済みのイベント・タイプのデータが Analytics のために収集されると、分析ログはクライアント・デバイス上のログ・ファイルに保管されます。ファイルのデータは、Analytics API の  `send` メソッドを使用して {{ site.data.keys.mf_analytics_server }} に送信されます。

キャプチャーされたログを定期的にサーバーに送信することを検討してください。定期的にデータを送信することにより、{{ site.data.keys.mf_analytics_console }} で常に最新の分析データを参照できるようになります。

#### JavaScript (Cordova)
{: #javascript-cordova }

Cordova アプリケーションで、以下の JavaScript API メソッドを使用します。

```javascript
WL.Analytics.send();
```

#### JavaScript (Web)
{: #javascript-web }

Web アプリケーションで、以下の JavaScript API メソッドを使用します  (内容は選択した名前空間に応じて異なります) 。

```javascript
ibmmfpfanalytics.send();
```

#### iOS
{: #ios }

**Objective-C**

```objc
[[WLAnalytics sharedInstance] send];
```

**Swift**

```swift
WLAnalytics.sharedInstance().send();
```

#### Android
{: #android }

Android アプリケーションで、以下の Java API メソッドを使用します。

```java
WLAnalytics.send();
```
