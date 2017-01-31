---
layout: tutorial
title: Android アプリケーションでのロギング
breadcrumb_title: Android でのロギング
relevantTo: [android]
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }

このチュートリアルでは、Android アプリケーションでロギング機能を追加するために必要なコード・スニペットを示します。

**前提条件:** 必ず[クライアント・サイドのログ収集の概説](../)をお読みください。

## ログ・キャプチャーの有効化
{: #enabling-log-capture }
デフォルトでは、ログ・キャプチャーは有効になっています。
ログ・キャプチャーは、クライアントにログを保存し、プログラムで有効または無効にすることができます。ログは、明示的な送信呼び出しまたは自動ログによってサーバーに送信されます。

> **注:** 詳細度を指定してログ・キャプチャーを有効にすることで、デバイス CPU やファイル・システム・スペースの消費、クライアントがネットワークでログを送信するときのペイロードのサイズに影響する可能性があります。

ログ・キャプチャーを無効にするには、以下のようにします。

```java
Logger.setCapture(false);
```

## キャプチャーしたログの送信
{: #sending-captured-logs }
アプリケーションのロジックに基づいて、ログを {{site.data.keys.product_adj }} に送信します。自動ログ送信を有効にして、自動的にログを送信することもできます。ログの最大サイズに達する前にログが送信されないと、ログ・ファイルがより新しいログで消去されます。

> **注:** ログ・データを収集する場合は、以下のパターンを採用してください。一定のインターバルでデータを送信すると、
{{site.data.keys.mf_analytics_console }}
でログ・データをほぼリアルタイムで見られるようにすることができます。

```java
Timer timer = new Timer();
timer.schedule(new TimerTask() {
  @Override
  public void run() {
    Logger.send();
  }
}, 0, 60000);
```

キャプチャーしたすべてのログが確実に送信されるようにするために、以下のいずれかの方法を検討してください。

* 一定の時間インターバルで `send` メソッドを呼び出す。
* アプリケーション・ライフサイクル・イベント・コールバック内から `send` メソッドを呼び出す。
* 以下のようにして、永続ログ・バッファーの最大ファイル・サイズを増やす (バイト単位)。

```java
Logger.setMaxFileSize(150000);
```

## 自動ログ送信
{: auto-log-sending }
デフォルトでは、自動ログ送信が有効になっています。正常なリソース要求がサーバーに送信されるたびに、キャプチャーされたログも最小で 60 秒の送信間隔で送信されます。自動ログ送信は、クライアントから有効または無効にすることができます。 

有効にするには、以下のようにします。


```java
Logger.setAutoSendLogs(true);
```

無効にするには、以下のようにします。


```java
Logger.setAutoSendLogs(false);
```

## Logger API による細かい調整
{: #fine-tuning-with-the-logger-api }
{{site.data.keys.product_adj }} クライアント SDK は、Logger API を内部で利用します。デフォルトでは、SDK によって作成されたログ・エントリーをキャプチャーしています。
ログ収集を細かく調整するには、パッケージ名を指定してロガー・インスタンスを使用します。
サーバー・サイドのフィルターを使用して、分析でどのロギング・レベルをキャプチャーするかを制御することもできます。


パッケージ名が `myApp` で、レベルが ERROR のログのみをキャプチャーする例のステップを以下に示します。

1. パッケージ名 `myApp` を指定して、`logger` インスタンスを使用します。

   ```java
   Logger logger = Logger.getInstance("MyApp");
   ```

2. **オプション: **指定されたレベルとパッケージのみにログ・キャプチャーとログ出力をプログラムで制限するフィルターを指定します。

   ```java
   HashMap<String, LEVEL> filters = new HashMap<>();
   filters.put("MyApp", LEVEL.ERROR);
   Logger.setFilters(filters);
   ```

3. **オプション:** サーバー構成プロファイルを取り出して、リモートでフィルターを制御します。

## サーバー構成プロファイルの取り出し
{: #fetching-server-configuration-profiles }
ロギング・レベルは、クライアントが設定することも、サーバーから構成プロファイルを取得することによって設定することもできます。{{site.data.keys.mf_analytics_console }} から、ログ・レベルは、グローバル (すべてのロガー・インスタンス) に設定することも、特定のパッケージ (複数可) に設定することも可能です。
 

> {{site.data.keys.mf_analytics_console }}からのフィルターの構成については、[『ログ・フィルターの構成』](../../../analytics/console/log-filters/)を参照してください。
サーバーで設定された構成オーバーライドをクライアントが取り出すには、アプリケーション・ライフサイクル・コールバック内など、
定期的に実行されるコード内の場所から `updateConfigFromServer` メソッドを呼び出す必要があります。


```java
Logger.updateConfigFromServer();
```

## ロギングの例
{: #logging-example }
ブラウザーの JavaScript コンソール、LogCat、または Xcode コンソールに出力します。

```java
import com.worklight.common.Logger;

public class MathUtils{
  private static final Logger logger = Logger.getInstance(MathUtils.class.getName());
  public int sum(final int a, final int b){
    logger.setLevel(LEVEL.DEBUG);
    int sum = a + b;
    logger.debug("sum called with args " + a + " and " + b + ". Returning " + sum);
    return sum;
  }
}
```
