---
layout: tutorial
title: クライアント・サイドのログ収集
breadcrumb_title: クライアント・サイドのログ収集
relevantTo: [ios,android,javascript]
weight: 7
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
ロギングは、診断およびデバッグを容易にするために、API 呼び出しを使用してメッセージを記録するソース・コードの装備です。{{site.data.keys.product_full }} は、このための一連のロギング API メソッドを提供します。

{{site.data.keys.product_adj }} `Logger` API は、`console.log` (JavaScript)、`java.util.logging` (Java)、および `NSLog` (Objective-C) など、一般的に使用されるロガー API に似ており、追加の機能として、分析収集および開発者検査で使用するために、ログに記録されたデータを永続的にキャプチャーして {{site.data.keys.mf_server }} に送信する機能を持っています。`Logger` API を使用して、適切なレベルでログ・データをレポートします。これにより、ログを検査する開発者は、ラボで問題を再現することなく、問題の優先順位を決定し、修正できます。

#### 使用可能性
{: #availability }
{{site.data.keys.product_adj }} 提供の `Logger` API メソッドは、iOS、Android、Web、および Cordova のアプリケーションで使用できます。

## ロギング・レベル
{: #logging-levels }
ロギング・ライブラリーには通常、詳細度制御 (多くの場合、**レベル**と呼ばれる) があります。  
ロギング・レベルは、最も高い詳細度から低い詳細度に向かって順番に、以下のとおりです。

* TRACE - メソッドの入り口点および出口点に使用
* DEBUG - メソッドの結果の出力に使用
* LOG - クラスのインスタンス化に使用
* INFO - 初期設定のレポートに使用
* WARN - 非推奨の使用の警告をログに記録するために使用
* ERROR - 予期しない例外に使用
* FATAL - リカバリー不能の異常終了またはハングに使用

> **注:** FATAL を使用すると、アプリケーションの異常終了が収集されます。アプリケーションの異常終了データのスキューを回避するには、このキーワードを使用しないことをお勧めします。

クライアント SDK はデフォルトでは FATAL の詳細度で構成され、生のデバッグ・ログの出力およびキャプチャーはほとんど行われないか、まったく行われません。{{site.data.keys.mf_analytics_console }} で構成プロファイルを設定することで、プログラムでログ詳細度を調整することも、手動で調整することもできます。これは、アプリケーションで明示的に取得されなければなりません。

### クライアント・アプリケーションからのロギング
{: #logging-from-client-applications }
* [JavaScript (Cordova、Web) アプリケーションでのロギング](javascript/)
* [iOS アプリケーションでのロギング](ios/)
* [Android アプリケーションでのロギング](android/)

### ログ詳細度の調整
{: #adjusting-log-verbosity }
クライアントを設定するか、サーバー・プロファイルを取得することによって、ロギング・レベルが設定されると、クライアントは送信するロギング・メッセージをフィルタリングします。
しきい値より下のメッセージが明示的に送信された場合、クライアントはそれを無視します。


例えば、詳細度レベルを DEBUG に設定するには、以下のようにします。

#### iOS
{: #ios}
**Objective-C**

```objc
[OCLogger setLevel:OCLogger_DEBUG];
```

**Swift**

```swift
 OCLogger.setLevel(OCLogger_DEBUG);
 ```

#### Android
{: #android }
```java
Logger.setLevel(Logger.LEVEL.DEBUG);
```

#### JavaScript (Cordova)
{: #javascript-cordova }
```javascript
WL.Logger.config({ level: 'DEBUG' });
```

#### JavaScript (Web)
{: #javascript-web }
Web SDK では、クライアントからデフォルトの trace レベルを変更することはできません。

## 異常終了キャプチャー
{: #crash-capture }
Android および iOS アプリケーションでは、{{site.data.keys.product_adj }} クライアント SDK は、アプリケーションの異常終了時にスタック・トレースをキャプチャーし、FATAL レベルでログに記録します。このタイプの異常終了は、UI がユーザーに表示されなくなる真の異常終了です。Cordova アプリケーションでは、JavaScript グローバル・エラーと、可能な場合は JavaScript 呼び出しスタックをキャプチャーし、FATAL レベルでログに記録します。このタイプの異常終了は異常終了イベントではなく、実行時のユーザー・エクスペリエンスに悪影響が出ることも出ないこともあります。

アプリケーションが再度実行されると、異常終了、キャッチされていない例外、およびグローバル・エラーが自動的にキャッチされてログに記録されます。

## ログの表示
{: #viewing-the-logs }
ログが収集されてサーバーに送信された後に、{{site.data.keys.mf_analytics_console }}でログを表示します。ナビゲーション・バーから**「アプリケーション」**パネルを選択し、**「クライアント・ログの検索」**タブをクリックします。

![ログの検索および表示](consoleViewClientLogs.png)
