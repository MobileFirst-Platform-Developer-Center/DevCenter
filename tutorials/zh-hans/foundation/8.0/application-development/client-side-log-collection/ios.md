---
layout: tutorial
title: 登录 iOS 应用程序
breadcrumb_title: 登录 iOS
relevantTo: [ios]
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
此教程提供必需的代码片段，以在 iOS 应用程序中添加日志记录功能。

**先决条件：**确保阅读[客户端日志收集的概述](../)。

> **注：**在 Swift 中使用 `OCLogger` 需要创建 `OCLogger` 扩展类（此类可以是单独的 Swift 文件，或者当前 Swift 文件的扩展）：
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

在包含扩展类后，您现在可以在 Swift 中使用 `OCLogger`。

## 启用日志捕获
{: #enabling-log-capture }
缺省情况下，已启用日志捕获。日志捕获将日志保存到客户机，并且可以编程方式启用或禁用。使用显式发送调用或自动日志将日志发送到服务器。

> **注：**按详细级别启用日志捕获可能在客户机通过网络发送日志时影响设备 CPU 使用、文件系统空间和有效内容大小。要禁用日志捕获：

**Objective-C**

```objc
[OCLogger setCapture:NO];
```

**Swift**

```swift
OCLogger.setCapture(false);
```

## 发送捕获的日志
{: #sending-captured-logs }
根据应用程序逻辑，将日志发送到 {{ site.data.keys.product_adj }}。也可启用自动日志发送以自动发送日志。如果在达到最大大小后才发送日志，那么将清除日志文件以容纳更新的日志。

> **注：**收集日志数据时，采用以下模式。定期发送数据可确保您在 {{ site.data.keys.mf_analytics_console }} 中近实时地查看日志数据。**Objective-C**

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

要确保发送所有捕获的日志，请考虑以下策略之一：

* 按时间间隔调用 `send` 方法。
* 从应用程序生命周期事件回调中调用 `send` 方法。
* 增加持久性日志缓冲区的最大文件大小（字节）：

**Objective-C**

```objc
[OCLogger setMaxFileSize:150000];

```

**Swift**

```swift
OCLogger.setMaxFileSize(150000);
```

## 自动日志发送
{: #auto-log-sending }
缺省情况下，启用自动日志发送。每次将成功的资源请求发送到服务器后，也将发送捕获的日志，并且发送之间存在 60 秒最小时间间隔。可以从客户机启用或禁用自动日志发送。缺省情况下，启用自动日志发送。

**Objective-C**

要启用：

```objc
[OCLogger setAutoSendLogs:YES];
```

要禁用：

```objc
[OCLogger setAutoSendLogs:NO];
```

**Swift**

要启用：

```swift
OCLogger.setAutoSendLogs(true);
```

要禁用：

```swift
OCLogger.setAutoSendLogs(false);
```

## 使用记录器 API 微调
{: #fine-tuning-with-the-logger-api }
{{ site.data.keys.product_adj }} 客户机 SDK 内部使用记录器 API。缺省情况下，您将捕获 SDK 生成的日志条目。要微调日志集合，请结合使用记录器实例和程序包名。您还可以使用服务器端过滤器来控制由分析捕获哪个日志记录级别。

### Objective-C
{: #objective-c}
要仅捕获 `myApp` 程序包名的级别为 `ERROR` 的日志，请遵循示例中的以下步骤。

1. 结合使用 `logger` 实例和 `myApp` 程序包名。

   ```objc
   OCLogger *logger = [OCLogger getInstanceWithPackage:@"MyApp"];
   ```

2. **可选：**指定过滤器，以编程方式将日志捕获和日志输出仅限制于指定的级别和程序包。

   ```objc
   [OCLogger setFilters:@{@"MyApp": @(OCLogger_ERROR)}];
   ```

3. **可选：**通过访存服务器配置概要文件，远程控制过滤器。

### Swift
{: #swift }
1. 如“概述”中所述使用扩展，为程序包创建记录器实例。

   ```swift
   let logger : OCLogger = OCLogger.getInstanceWithPackage("MyTestLoggerPackage");
   ```

2. **可选：**指定日志记录级别。

   ```swift
   OCLogger.setLevel(OCLogger_DEBUG);
   ```

3. **可选：**通过访存服务器配置概要文件，远程控制过滤器。

## 访存服务器配置概要文件
{: #fetching-server-configuration-profiles }
可以通过客户机或通过从服务器中检索配置概要文件来设置日志记录级别。在
{{ site.data.keys.mf_analytics_console }}
中，可以全局（针对所有记录器实例）或针对一个或多个特定程序包设置日志级别。有关从 {{ site.data.keys.mf_analytics_console }} 配置过滤器的信息，请参阅[配置日志过滤器](../../../analytics/console/log-filters/)。
为便于客户机从服务器访存配置，必须从定期运行的代码中某一位置调用 `updateConfigFromServer` 方法，例如，在应用程序生命周期回调中。

**Objective-C**

```objc
[OCLogger updateConfigFromServer];
```

**Swift**

```swift
 OCLogger.updateConfigFromServer();
 ```

## 日志记录示例
{: #logging-example }
输出到浏览器 JavaScript 控制台、LogCat 或 Xcode 控制台。

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
