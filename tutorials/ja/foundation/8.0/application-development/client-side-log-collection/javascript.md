---
layout: tutorial
title: JavaScript (Cordova、Web) アプリケーションでのロギング
breadcrumb_title: JavaScript でのロギング
relevantTo: [javascript]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
このチュートリアルでは、JavaScript (Cordova、Web) アプリケーションでロギング機能を追加するために必要なコード・スニペットを示します。

**前提条件:** 必ず[クライアント・サイドのログ収集の概説](../)をお読みください。

## ログ・キャプチャーの有効化
{: #enabling-log-capture }
デフォルトでは、ログ・キャプチャーは有効になっています。ログ・キャプチャーは、クライアントにログを保存し、プログラムで有効または無効にすることができます。ログは、明示的な送信呼び出しまたは自動ログによってサーバーに送信されます。

> **注:** 詳細度を指定してログ・キャプチャーを有効にすることで、デバイス CPU やファイル・システム・スペースの消費、クライアントがネットワークでログを送信するときのペイロードのサイズに影響する可能性があります。



ログ・キャプチャーを無効にするには、以下のようにします。

### Cordova
{: #cordova }
```javascript
WL.Logger.config({ capture: false });```

### Web
{: #web }
```javascript
ibmmfpfanalytics.logger.enable(false);```

## キャプチャーしたログの送信
{: #sending-captured-logs }
アプリケーションのロジックに基づいて、ログを {{ site.data.keys.product_adj }} に送信します。自動ログ送信を有効にして、自動的にログを送信することもできます。ログの最大サイズに達する前にログが送信されないと、ログ・ファイルがより新しいログで消去されます。

> **注:** ログ・データを収集する場合は、以下のパターンを採用してください。一定のインターバルでデータを送信すると、{{ site.data.keys.mf_analytics_console }} でログ・データをほぼリアルタイムで見られるようにすることができます。



#### Cordova アプリケーション
{: #cordova-apps }

キャプチャーしたすべてのログが確実に送信されるようにするために、以下のいずれかの方法を検討してください。

* 一定の時間インターバルで `send` メソッドを呼び出す。
* アプリケーション・ライフサイクル・イベント・コールバック内から `send` メソッドを呼び出す。
* 以下のようにして、永続ログ・バッファーの最大ファイル・サイズを増やす (バイト単位)。
```javascript
setInterval(function() {
WL.Logger.send();
}, 60000);
```

```javascript
WL.Logger.config({ maxFileSize: 150000 });```

#### Web アプリケーション
{: #web-apps }

```javascript
setInterval(function() {
ibmmfpfanalytics.logger.send();
}, 60000);
```

Web API の最大ファイル・サイズは 5 mb で変更不可です。

## 自動ログ送信
{: auto-log-sending }
デフォルトでは、自動ログ送信が有効になっています。正常なリソース要求がサーバーに送信されるたびに、キャプチャーされたログも最小で 60 秒の送信間隔で送信されます。自動ログ送信は、クライアントから有効または無効にすることができます。 

#### Cordova アプリケーションの場合
{: #for-cordova-apps }
有効にするには、以下のようにします。

```javascript
WL.Logger.config({autoSendLogs: true});
```

無効にするには、以下のようにします。

```javascript
WL.Logger.config({autoSendLogs: false});```

#### Web アプリケーションの場合
{: #for-web-apps }
有効にするには、以下のようにします。

```javascript
ibmmfpfanalytics.autoSendLogs(true);
```

無効にするには、以下のようにします。

```javascript
ibmmfpfanalytics.autoSendLogs(false);
```

## Logger API による細かい調整
{: #fine-tuning-with-the-logger-api }
{{ site.data.keys.product_adj }} クライアント SDK は、Logger API を内部で利用します。デフォルトでは、SDK によって作成されたログ・エントリーをキャプチャーしています。ログ収集を細かく調整するには、パッケージ名を指定してロガー・インスタンスを使用します。サーバー・サイドのフィルターを使用して、分析でどのロギング・レベルをキャプチャーするかを制御することもできます。

パッケージ名が `myApp` で、レベルが ERROR のログのみをキャプチャーする例のステップを以下に示します。

#### Cordova アプリケーションの細かい調整
{: #fine-tuning-cordova-apps }
1. パッケージ名 `myApp` を指定して、`WL.Logger` インスタンスを使用します。

   ```javascript
var logger = WL.Logger.create({ pkg: 'MyApp' });```

2. **オプション: **指定されたレベルとパッケージのみにログ・キャプチャーとログ出力をプログラムで制限するフィルターを指定します。

   ```javascript
   WL.Logger.config({
        filters: {
            'MyApp': 'ERROR'
        }
   });
   ```

3. **オプション:** サーバー構成プロファイルを取り出して、リモートでフィルターを制御します。

#### Web アプリケーション
{: #fine-tuning-web-apps }
Web SDK では、クライアントがレベルを設定することはできません。サーバー構成プロファイルを取得して構成が変更されるまで、すべてのログがサーバーに送信されます。

## サーバー構成プロファイルの取り出し
{: #fetching-server-configuration-profiles }
ロギング・レベルは、クライアントが設定することも、サーバーから構成プロファイルを取得することによって設定することもできます。{{ site.data.keys.mf_analytics_console }} から、ログ・レベルは、グローバル (すべてのロガー・インスタンス) に設定することも、特定のパッケージ (複数可) に設定することも可能です。{{ site.data.keys.mf_analytics_console }}からのフィルターの構成については、[『ログ・フィルターの構成』](../../../analytics/console/log-filters/)を参照してください。サーバーで設定された構成オーバーライドをクライアントが取り出すには、アプリケーション・ライフサイクル・コールバック内など、定期的に実行されるコード内の場所から `updateConfigFromServer` メソッドを呼び出す必要があります。

#### Cordova アプリケーションのサーバー構成プロファイルの取り出し
{: #fetching-server-configuration-profiles-cordova-apps }

```javascript
WL.Logger.updateConfigFromServer();```

#### Web アプリケーションのサーバー構成プロファイルの取り出し
{: #fetching-server-configuration-profiles-web-apps }

```javascript
ibmmfpfanalytics.logger.updateConfigFromServer();```

## ロギングの例
{: #logging-example }
ブラウザーの JavaScript コンソール、LogCat、または Xcode コンソールに出力します。

### Cordova のロギングの例
{: #logging-example-cordova }

```javascript
var MathUtils = function(){
   var logger = WL.Logger.create({pkg: 'MathUtils'});
   var sum = function(a, b){
      var sum = a + b;
      logger.debug('sum called with args ' + a + ' and ' + b + '. Returning ' + sum);
      return sum;
   };
}();
```

### Web のロギングの例
{: #logging-example-web }
Web アプリケーションでのロギングについては、前述の例を使用し、それを置き換えてください。

```javascript
  var logger = WL.Logger.create({pkg: 'MathUtils'});
```

これを以下に置き換えます。

```javascript
var logger = ibmmfpfanalytics.logger.create({pkg: 'MathUtils'});
```
