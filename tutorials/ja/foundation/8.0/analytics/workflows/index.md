---
layout: tutorial
title: Analytics ワークフロー
breadcrumb_title: ワークフロー
relevantTo: [ios,android,javascript]
weight: 5
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }

{{ site.data.keys.mf_analytics_full }} を活用して、ビジネス・ニーズに最適に対応することができます。目標が特定されたら、{{ site.data.keys.mf_analytics_short }}クライアント SDK を使用して該当データを収集し、{{ site.data.keys.mf_analytics_console }} を使用してレポートを作成します。以下の一般的なシナリオで、分析データの収集およびレポート作成の方法の例を示します。

#### ジャンプ先
{: #jump-to }

* [アプリケーションの使用の分析](#app-usage-analytics)
* [異常終了キャプチャー](#crash-capture)

## アプリケーションの使用の分析
{: #app-usage-analytics }

### アプリケーション使用をキャプチャーするためのクライアント・アプリケーションの初期化
{: #initializing-your-client-app-to-capture-app-usage }

アプリケーションの使用では、特定のアプリケーションがフォアグラウンドに移動された後、バックグラウンドに送られた回数を測定します。モバイル・アプリケーションでアプリケーション使用をキャプチャーするには、{{ site.data.keys.mf_analytics }} クライアント SDK が、アプリケーション・ライフサイクル・イベントを聴取するように構成されている必要があります。

{{ site.data.keys.mf_analytics }} API を使用して、アプリケーションの使用状況をキャプチャーできます。関連するデバイス・リスナーがまず作成済みであることを確認してください。その後、データをサーバーに送信します。

#### iOS
{: #ios }

**AppDelegate.m/AppDeligate.swift** ファイル内の Application Delegate の `application:didFinishLaunchingWithOptions` メソッドに次のコードを追加します。

**Objective-C**

```objc
WLAnalytics *analytics = [WLAnalytics sharedInstance];
[analytics addDeviceEventListener:LIFECYCLE];
```

 分析データを送信するには、以下のようにします。

```objc
[[WLAnalytics sharedInstance] send];
```

**Swift**

```Swift
WLAnalytics.sharedInstance().addDeviceEventListener(LIFECYCLE);
```

分析データを送信するには、以下のようにします。

```Swift
WLAnalytics.sharedInstance().send;
```

#### Android
{: #android }

Application サブクラスの `onCreate` メソッドに次のコードを追加します。

```Java
WLAnalytics.init(this);
WLAnalytics.addDeviceEventListener(DeviceEvent.LIFECYCLE);
```

分析データを送信するには、以下のようにします。

```Java
WLAnalytics.send();
```

#### Cordova
{: #cordova }

iOS および Android アプリケーションと同様に、Cordova アプリケーションの場合も、ネイティブ・プラットフォーム・コードにリスナーを作成する必要があります。以下のようにしてデータをサーバーに送信します。

```javascript
WL.Analytics.send();
```

#### Web アプリケーション
{: #web-apps }

Web アプリケーションの場合、リスナーは不要です。`WLlogger` クラスを通じて分析を有効化および無効化することができます。

```javascript                                    
ibmmfpfanalytics.logger.config({analyticsCapture: true});                
ibmmfpfanalytics.send();
```

### 使用状況とデバイスのデフォルト・グラフ
{: #default-usage-and-devices-charts }

{{ site.data.keys.mf_analytics_console }} の「アプリケーション」セクションの**「使用状況とデバイス (Usage and Devices)」**ページには、アプリケーションの使用状況の管理に役立ついくつかのデフォルト・グラフが用意されています。

#### 合計デバイス数
{: #total-devices }

**「合計デバイス数」**グラフは、合計デバイスの数を示します。

#### 合計アプリケーション・セッション数
{: #total-app-sessions }

**「合計アプリケーション・セッション数 (Total App Sessions)」**グラフは、合計アプリケーション・セッションの数を示します。アプリケーションをデバイスのフォアグラウンドに移動すると、アプリケーション・セッションが記録されます。

#### アクティブ・ユーザー
{: #active-users }

**「アクティブ・ユーザー」**グラフでは、以下のデータについて複数の線からなる対話式折れ線グラフを表示します。

* アクティブ・ユーザー - 表示時間フレームの固有のユーザー。
* 新規ユーザー - 表示時間フレームの新規のユーザー。

デフォルトの表示時間フレームは 1 日であり、1 時間ごとに 1 つのデータ・ポイントがあります。表示時間フレームを変更して 1 日より大きくすると、データ・ポイントは 1 日ごとになります。凡例の中で対応するキーをクリックして、その線を表示するかどうかを切り替えられます。デフォルトではすべてのキーが表示されます。すべてのキーを切り替えてどの線も表示されないようにすることはできません。

折れ線グラフに最も正確なデータを表示するには、アプリケーション・コードで `setUserContext` API を呼び出して `userID` を指定する必要があります。`userID` 値に匿名性を持たせる場合は、最初にその値をハッシュしなければなりません。`userID` が指定されない場合、デバイスの ID がデフォルトで使用されます。1 つのデバイスが複数のユーザーによって使用され、`userID` が指定されない場合、デバイスの ID が 1 人のユーザーとしてカウントされるため、正確なデータが折れ線グラフに反映されません。

#### アプリケーション・セッション数
{: #app-sessions }
**「アプリケーション・セッション数」**グラフは、アプリケーション・セッション数の経時的な棒グラフを表示します。

#### アプリケーションの使用
{: #app-usage }

**「アプリケーションの使用」**グラフは、各アプリケーションのアプリケーション・セッション数のパーセンテージを円グラフで示します。

#### 新規デバイス
{: #new-devices }

**「新規デバイス」**グラフは、新規デバイス数の経時的な棒グラフを示します。

#### モデルの使用
{: #model-usage }

**「モデルの使用」**グラフは、各デバイス・モデルのアプリケーション・セッション数のパーセンテージを円グラフで示します。

#### オペレーティング・システムの使用
{: #operating-system-usage }
**「オペレーティング・システムの使用」**グラフは、各デバイス・オペレーティング・システムのアプリケーション・セッション数のパーセンテージを円グラフで示します。

### 平均セッション所要時間に関するカスタム・グラフの作成
{: #creating-acustom-chart-for-average-session-duration }

アプリケーション・セッションの所要時間は、視覚化すべき有効なメトリックです。どんなアプリケーションでも、ユーザーが特定のセッションで費やした時間に関する情報は必要になります。

1. {{ site.data.keys.mf_analytics_console }} で、「ダッシュボード」セクションの**「カスタム・グラフ (Custom Charts)」**ページで**「グラフの作成」**をクリックします。
2. グラフにタイトルを付けます。
3. **「イベント・タイプ」**に**「アプリケーション・セッション (App Session)」**を選択します。
4. **「グラフ・タイプ」**に**「棒グラフ」**を選択します。
5. **「次へ」**をクリックします。
6. **「X 軸」**に**「タイムライン (Timeline)」**を選択します。
7. **「Y 軸」**に**「平均」**を選択します。
8. **「プロパティー」**に**「所要時間 (Duration)」**を選択します。
9. **「保存 (Save)」**をクリックします。

## 異常終了キャプチャー
{: #crash-capture }

{{ site.data.keys.mf_analytics }} には、アプリケーションの異常終了についてのデータとレポートが含まれます。このデータは、他のライフサイクル・イベント・データと共に自動的に収集されます。異常終了データはクライアントによって収集され、アプリケーションが再度実行されると、サーバーに送信されます。

処理されない例外が発生し、プログラムがリカバリー不能な状態になると、アプリケーション異常終了が記録されます。アプリケーションがクローズする前に、{{ site.data.keys.mf_analytics }} SDK は異常終了イベントをログに記録します。このデータは、次回のロガー送信呼び出しを使用してサーバーに送信されます。

### 異常終了データをキャプチャーするためのアプリケーションの初期化
{: #initializing-your-app-to-capture-crash-data }

異常終了データが収集され、{{ site.data.keys.mf_analytics_console }}・レポートに含まれるようにするには、 異常終了データがサーバーに送信されていることを確認してください。

[『アプリケーション使用をキャプチャーするためのクライアント・アプリケーションの初期化』](#initializing-your-client-app-to-capture-app-usage)に説明されているように、アプリケーション・ライフサイクル・イベントを収集していることを確認してください。

異常終了に関連付けられたスタック・トレースを取得するには、アプリケーションが再度実行された後にクライアント・ログを送信する必要があります。タイマーを使用すると、確実にログが定期的に送信されます。

#### iOS
{: #ios-crash-data }

**Objective-C**

```objc
- (void)sendMFPAnalyticData {
  [OCLogger send];
  [[WLAnalytics sharedInstance] send];
}

// then elsewhere in the same implementation file:

[NSTimer scheduledTimerWithTimeInterval:60
  target:self
  selector:@selector(sendMFPAnalyticData)
  userInfo:nil
  repeats:YES]
```

**Swift**

```swift
overridefuncviewDidLoad() {
       super.viewDidLoad()
       WLAnalytics.sharedInstance();
       lettimer = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: #selector(sendMFPAnalyticData), userInfo: nil, repeats: true);
       timer.fire();
       // Do any additional setup after loading the view, typically from a nib.
   }

   funcsendMFPAnalyticData() {
       OCLogger.send()
       WLAnalytics.sharedInstance().send()
   }
```

#### Android
{: #android-crash-data }

```Java
Timer timer = new Timer();
timer.schedule(new TimerTask() {
  @Override
  public void run() {
    Logger.send();
    WLAnalytics.send();
  }
}, 0, 60000);
```

#### Cordova
{: #cordova-crash-data }

```Java
setInterval(function() {
  WL.Logger.send();
  WL.Analytics.send();
}, 60000)
```

#### Web
{: #web-crash-data }

```Java
setInterval(function() {
  ibmmfpfanalytics.logger.send();
}, 60000);
```

### アプリケーション異常終了のモニター
{: #app-crash-monitoring }

異常終了の後に、アプリケーションが再始動したときに、異常終了ログが {{ site.data.keys.mf_analytics_server }}に送信されます。{{ site.data.keys.mf_analytics_console }} の**「ダッシュボード」**セクションでアプリケーション異常終了に関する情報を迅速に表示できます。  
**「ダッシュボード」**セクションの**「概要」**ページで、**「異常終了 (Crashes)」**の棒グラフに、異常終了数の経時的なヒストグラムが示されます。

以下の 2 つの方法でデータを表示できます。

* **異常終了率の表示 (Display crash rate)**: 経時的な異常終了率
* **合計異常終了数の表示 (Display total crashes)**: 経時的な合計異常終了数

> **注:** 「異常終了 (Crashes)」グラフは、`MfpAppSession` 文書に対して照会を実行します。グラフにデータが表示されるようにするには、アプリケーションの使用数と異常終了数を収集するようにアプリケーションを調整する必要があります。`MfpAppSession` データが収集されない場合、`MfpAppLog` 文書に対して照会が実行されます。この場合、グラフでは異常終了の数をカウントできますが、アプリケーション使用数が不明であるため、異常終了率は計算できません。そのため、以下の制限が生じます。
>
> * **「異常終了率の表示 (Display Crash Rate)」** が選択されている場合でも、*「異常終了 (Crashes)」**棒グラフにデータは表示されません*。

### 異常終了のデフォルト・グラフ
{: #default-charts-for-crashes }

{{ site.data.keys.mf_analytics_console }} の**「アプリケーション」**セクションの**「異常終了 (Crashes)」**ページには、アプリケーション異常終了の管理に役立ついくつかのデフォルト・グラフが用意されています。

**「異常終了の概要 (Crash Overview)」**グラフは、異常終了の概要の表を表示します。  
**「異常終了 (Crashes)」**棒グラフは、異常終了の経時的なヒストグラムを表示します。異常終了率または合計異常終了数でデータを表示できます。「異常終了 (Crashes)」棒グラフは、「アプリケーション」セクションの「異常終了 (Crashes)」ページ内にもあります。

**「異常終了サマリー (Crash Summary)」**グラフは、異常終了のサマリーのソート可能な表を表示します。「+」アイコンをクリックすることで個々の異常終了を展開し、異常終了の詳細を含む**「異常終了の詳細 (Crash Details)」**表を表示することができます。「異常終了の詳細 (Crash Details)」表で、「**>**」 アイコンをクリックして、個々の異常終了インスタンスに関する詳細を表示できます。

### アプリケーション異常終了のトラブルシューティング
{: #app-crash-troubleshooting }

{{ site.data.keys.mf_analytics_console }} の**「アプリケーション」**セクションで**「異常終了 (Crashes)」**ページを表示して、アプリケーションの管理を向上させることができます。

**異常終了の概要 (Crash Overview)** 表には、以下のデータ列が表示されます。

* **アプリケーション:** アプリケーション名
* **異常終了 (Crashes):** 当該アプリケーションの異常終了の総数
* **合計使用回数 (Total Uses):** ユーザーが当該アプリケーションを開いて閉じた合計回数
* **異常終了率 (Crash Rate):** 1 回の使用当たりの異常終了のパーセンテージ

**「異常終了 (Crashes)」**の棒グラフは、**「ダッシュボード」**セクションの**「概要」**ページに表示されるグラフと同じです。

> **注:**両方のグラフともに、`MfpAppSession` 文書に対して照会を実行します。グラフにデータが表示されるようにするには、アプリケーションの使用数と異常終了数を収集するようにアプリケーションを調整する必要があります。`MfpAppSession` データが収集されない場合、`MfpAppLog` 文書に対して照会が実行されます。この場合、グラフでは異常終了の数をカウントできますが、アプリケーション使用数が不明であるため、異常終了率は計算できません。そのため、以下の制限が生じます。
>
> * 「異常終了の概要 (Crash Overview)」表の「合計使用回数 (Total Uses)」および「異常終了率 (Crash Rate)」の列が空になります。
> * 「異常終了率の表示 (Display Crash Rate)」が選択されている場合でも、「異常終了 (Crashes)」棒グラフにデータは表示されません。

**「異常終了サマリー (Crash Summary)」**表はソート可能です。この表には、以下のデータ列が含まれます。

* 異常終了
* デバイス
* 最後の異常終了
* アプリケーション
* OS
* メッセージ

任意の項目の横にある**「+」**アイコンをクリックして、**「異常終了の詳細 (Crash Details)」**表を表示できます。この表には、以下の列が含まれています。

* 異常終了した時刻
* アプリケーション・バージョン
* OS バージョン
* デバイス・モデル
* デバイス ID
* ダウンロード: 異常終了につながったログをダウンロードするためのリンク

**「異常終了の詳細 (Crash Details)」**表内の任意の項目を展開して、スタック・トレースなどの詳細を表示できます。

> **注:** **「異常終了サマリー (Crash Summary)」**表のデータは、 FATAL レベルのクライアント・ログに照会することで取り込まれます。アプリケーションで FATAL クライアント・ログを収集していない場合は、使用可能なデータはありません。
