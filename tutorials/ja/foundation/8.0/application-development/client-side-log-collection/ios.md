---
layout: tutorial
title: iOS アプリケーションでのロギング
breadcrumb_title: iOS でのロギング
relevantTo: [ios]
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
このチュートリアルでは、iOS アプリケーションでロギング機能を追加するために必要なコード・スニペットを示します。

**前提条件:** 必ず[クライアント・サイドのログ収集の概説](../)をお読みください。

> **注:** Swift で `OCLogger` を使用するには、`OCLogger` 拡張クラスを作成する必要があります (このクラスは別個の Swift ファイルであるか、現行 Swift ファイルの拡張にします)。

```swift
extension OCLogger {
    //Log methods with no metadata

    func logTraceWithMessages(message:String, _ args: CVarArgType...) {
        logWithLevel(OCLogger_TRACE, message: message, args:getVaList(args), userInfo:Dictionary<String, String>())
    }

    func logDebugWithMessages(message:String, _ args: CVarArgType...) {
        logWithLevel(OCLogger_DEBUG, message: message, args:getVaList(args), userInfo:Dictionary<String, String>())
    }

    func logInfoWithMessages(message:String, _ args: CVarArgType...) {
        logWithLevel(OCLogger_INFO, message: message, args:getVaList(args), userInfo:Dictionary<String, String>())
    }

    func logWarnWithMessages(message:String, _ args: CVarArgType...) {
        logWithLevel(OCLogger_WARN, message: message, args:getVaList(args), userInfo:Dictionary<String, String>())
    }

    func logErrorWithMessages(message:String, _ args: CVarArgType...) {
        logWithLevel(OCLogger_ERROR, message: message, args:getVaList(args), userInfo:Dictionary<String, String>())
    }

    func logFatalWithMessages(message:String, _ args: CVarArgType...) {
        logWithLevel(OCLogger_FATAL, message: message, args:getVaList(args), userInfo:Dictionary<String, String>())
    }

    func logAnalyticsWithMessages(message:String, _ args: CVarArgType...) {
        logWithLevel(OCLogger_ANALYTICS, message: message, args:getVaList(args), userInfo:Dictionary<String, String>())
    }

    //Log methods with metadata

    func logTraceWithUserInfo(userInfo:Dictionary<String, String>, message:String, _ args: CVarArgType...) {
        logWithLevel(OCLogger_TRACE, message: message, args:getVaList(args), userInfo:userInfo)
    }

    func logDebugWithUserInfo(userInfo:Dictionary<String, String>, message:String, _ args: CVarArgType...) {
        logWithLevel(OCLogger_DEBUG, message: message, args:getVaList(args), userInfo:userInfo)
    }

    func logInfoWithUserInfo(userInfo:Dictionary<String, String>, message:String, _ args: CVarArgType...) {
        logWithLevel(OCLogger_INFO, message: message, args:getVaList(args), userInfo:userInfo)
    }

    func logWarnWithUserInfo(userInfo:Dictionary<String, String>, message:String, _ args: CVarArgType...) {
        logWithLevel(OCLogger_WARN, message: message, args:getVaList(args), userInfo:userInfo)
    }

    func logErrorWithUserInfo(userInfo:Dictionary<String, String>, message:String, _ args: CVarArgType...) {
        logWithLevel(OCLogger_ERROR, message: message, args:getVaList(args), userInfo:userInfo)
    }

    func logFatalWithUserInfo(userInfo:Dictionary<String, String>, message:String, _ args: CVarArgType...) {
        logWithLevel(OCLogger_FATAL, message: message, args:getVaList(args), userInfo:userInfo)
    }

    func logAnalyticsWithUserInfo(userInfo:Dictionary<String, String>, message:String, _ args: CVarArgType...) {
        logWithLevel(OCLogger_ANALYTICS, message: message, args:getVaList(args), userInfo:userInfo)
    }
}
```

拡張クラスを含めると、Swift で `OCLogger` を使用できるようになります。

## ログ・キャプチャーの有効化
{: #enabling-log-capture }
デフォルトでは、ログ・キャプチャーは有効になっています。
ログ・キャプチャーは、クライアントにログを保存し、プログラムで有効または無効にすることができます。ログは、明示的な送信呼び出しまたは自動ログによってサーバーに送信されます。

> **注:** 詳細度を指定してログ・キャプチャーを有効にすることで、デバイス CPU やファイル・システム・スペースの消費、クライアントがネットワークでログを送信するときのペイロードのサイズに影響する可能性があります。

ログ・キャプチャーを無効にするには、以下のようにします。

**Objective-C**

```objc
[OCLogger setCapture:NO];
```

**Swift**

```swift
OCLogger.setCapture(false);
```

## キャプチャーしたログの送信
{: #sending-captured-logs }
アプリケーションのロジックに基づいて、ログを {{site.data.keys.product_adj }} に送信します。自動ログ送信を有効にして、自動的にログを送信することもできます。ログの最大サイズに達する前にログが送信されないと、ログ・ファイルがより新しいログで消去されます。

> **注:** ログ・データを収集する場合は、以下のパターンを採用してください。データを定期的に送信すると、
{{site.data.keys.mf_analytics_console }}でログ・データをほぼリアルタイムで見られるようにすることができます。

**Objective-C**

```objc
[NSTimer scheduledTimerWithTimeInterval:60
  target:[OCLogger class]
  selector:@selector(send)
  userInfo:nil
  repeats:YES];
```

**Swift**

```swift
var timer = NSTimer.scheduledTimerWithTimeInterval(60,
  target:OCLogger.self,
  selector: #selector(OCLogger.send),
  userInfo: nil,
  repeats: true)
```

キャプチャーしたすべてのログが確実に送信されるようにするために、以下のいずれかの方法を検討してください。

* 一定の時間インターバルで `send` メソッドを呼び出す。
* アプリケーション・ライフサイクル・イベント・コールバック内から `send` メソッドを呼び出す。
* 以下のようにして、永続ログ・バッファーの最大ファイル・サイズを増やす (バイト単位)。

**Objective-C**

```objc
[OCLogger setMaxFileSize:150000];

```

**Swift**

```swift
OCLogger.setMaxFileSize(150000);
```

## 自動ログ送信
{: #auto-log-sending }
デフォルトでは、自動ログ送信が有効になっています。正常なリソース要求がサーバーに送信されるたびに、キャプチャーされたログも最小で 60 秒の送信間隔で送信されます。自動ログ送信は、クライアントから有効または無効にすることができます。 

**Objective-C**

有効にするには、以下のようにします。

```objc
[OCLogger setAutoSendLogs:YES];
```

無効にするには、以下のようにします。

```objc
[OCLogger setAutoSendLogs:NO];
```

**Swift**

有効にするには、以下のようにします。

```swift
OCLogger.setAutoSendLogs(true);
```

無効にするには、以下のようにします。

```swift
OCLogger.setAutoSendLogs(false);
```

## Logger API による細かい調整
{: #fine-tuning-with-the-logger-api }
{{site.data.keys.product_adj }} クライアント SDK は、Logger API を内部で利用します。デフォルトでは、SDK によって作成されたログ・エントリーをキャプチャーしています。
ログ収集を細かく調整するには、パッケージ名を指定してロガー・インスタンスを使用します。
サーバー・サイドのフィルターを使用して、分析でどのロギング・レベルをキャプチャーするかを制御することもできます。

### Objective-C
{: #objective-c}
パッケージ名が `myApp` で、レベルが `ERROR` のログのみをキャプチャーする例のステップを以下に示します。

1. パッケージ名 `myApp` を指定して、`logger` インスタンスを使用します。

   ```objc
   OCLogger *logger = [OCLogger getInstanceWithPackage:@"MyApp"];
   ```

2. **オプション: **指定されたレベルとパッケージのみにログ・キャプチャーとログ出力をプログラムで制限するフィルターを指定します。

   ```objc
   [OCLogger setFilters:@{@"MyApp": @(OCLogger_ERROR)}];
   ```

3. **オプション:** サーバー構成プロファイルを取り出して、リモートでフィルターを制御します。

### Swift
{: #swift }
1. 『概説』で説明されているとおりに拡張を使用して、パッケージのロガー・インスタンスを作成します。

   ```swift
   let logger : OCLogger = OCLogger.getInstanceWithPackage("MyTestLoggerPackage");
   ```

2. **オプション:** ロギング・レベルを指定します。

   ```swift
   OCLogger.setLevel(OCLogger_DEBUG);
   ```

3. **オプション:** サーバー構成プロファイルを取り出して、リモートでフィルターを制御します。

## サーバー構成プロファイルの取り出し
{: #fetching-server-configuration-profiles }
ロギング・レベルは、クライアントが設定することも、サーバーから構成プロファイルを取得することによって設定することもできます。{{site.data.keys.mf_analytics_console }} から、ログ・レベルは、グローバル (すべてのロガー・インスタンス) に設定することも、特定のパッケージ (複数可) に設定することも可能です。
{{site.data.keys.mf_analytics_console }}からのフィルターの構成については、[『ログ・フィルターの構成』](../../../analytics/console/log-filters/)を参照してください。
クライアントがサーバーから構成を取り出すには、アプリケーション・ライフサイクル・コールバック内など、定期的に実行されるコード内の場所から `updateConfigFromServer` メソッドを呼び出す必要があります。

**Objective-C**

```objc
[OCLogger updateConfigFromServer];
```

**Swift**

```swift
 OCLogger.updateConfigFromServer();
 ```

## ロギングの例
{: #logging-example }
ブラウザーの JavaScript コンソール、LogCat、または Xcode コンソールに出力します。

#### Objective-C
{: #objective-c-example }

```objc
#import "OCLogger.h"
+ (int) sum:(int) a with:(int) b{
    int sum = a + b;
    [OCLogger setLevel:DEBUG];
    OCLogger* mathLogger = [OCLogger getInstanceWithPackage:@"MathUtils"];
    NSString* logMessage = [NSString stringWithFormat:@"sum called with args %d and %d. Returning %d", a, b, sum];
    [mathLogger debug:logMessage];
    return sum;
}
```

### Swift
{: #swift-logging }

```swift
func sum(a: Int, b: Int) -> Int{
    var sum = a + b;
    let logger = OCLogger.getInstanceWithPackage("MathUtils");

    logger.logInfoWithMessages("sum called with args /(a) and /(b). Returning /(sum)");
    return sum;
}
```
