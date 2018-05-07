---
layout: tutorial
title: JavaScript（Cordova 或 Web）应用程序中的日志记录
breadcrumb_title: Logging in JavaScript
relevantTo: [javascript]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
此教程提供必需的代码片段以在 JavaScript（Cordova 或 Web）应用程序中添加日志记录功能。

**先决条件：**确保阅读[客户端日志收集的概述](../)。

## 启用日志捕获
{: #enabling-log-capture }
缺省情况下，已启用日志捕获。 日志捕获将日志保存到客户机并且可以编程方式启用或禁用。 使用显式发送调用或自动日志将日志发送到服务器

> **注：**按详细级别启用日志捕获可能在客户机通过网络发送日志时影响设备 CPU 使用、文件系统空间和有效内容大小。

要禁用日志捕获：

### Cordova
{: #cordova }
```javascript
WL.Logger.config({capture: false});
```

### Web
{: #web }
```javascript
ibmmfpfanalytics.logger.enable(false);
```

## 发送捕获的日志
{: #sending-captured-logs }
根据应用程序逻辑，将日志发送到 {{ site.data.keys.product_adj }}。 也可启用自动日志发送以自动发送日志。 如果在达到最大大小后才发送日志，那么将清除日志文件以容纳更新的日志。

> **注：**收集日志数据时，采用以下模式。 按时间间隔发送数据可确保您在 {{ site.data.keys.mf_analytics_console }} 中近实时地查看日志数据。

#### Cordova 应用程序
{: #cordova-apps }

要确保发送所有捕获的日志，请考虑以下策略之一：

* 按时间间隔调用 `send` 方法。
* 从应用程序生命周期事件回调中调用 `send` 方法。
* 增加持久性日志缓冲区的最大文件大小（字节）：
```javascript
setInterval(function() {
    WL.Logger.send();
}, 60000);
```

```javascript
WL.Logger.config({ maxFileSize: 150000 });
```

#### Web 应用程序
{: #web-apps }

```javascript
setInterval(function() {
   ibmmfpfanalytics.logger.send();
}, 60000);
```

Web API 的最大文件大小为 5 MB，无法更改。

## 自动日志发送
{: auto-log-sending }
缺省情况下，启用自动日志发送。 每次将成功的资源请求发送到服务器后，也将发送捕获的日志，并且发送之间存在 60 秒最小时间间隔。 可以从客户机启用或禁用自动日志发送。 缺省情况下，启用自动日志发送。

#### 对于 Cordova 应用程序
{: #for-cordova-apps }
要启用：

```javascript
WL.Logger.config({autoSendLogs: true});
```

要禁用：

```javascript
WL.Logger.config({autoSendLogs: false});
```

#### 对于 Web 应用程序
{: #for-web-apps }
要启用：

```javascript
ibmmfpfanalytics.autoSendLogs(true);
```

要禁用：

```javascript
ibmmfpfanalytics.autoSendLogs(false);
```

## 使用记录器 API 微调
{: #fine-tuning-with-the-logger-api }
{{ site.data.keys.product_adj }} 客户机 SDK 内部使用记录器 API。 缺省情况下，您将捕获 SDK 生成的日志条目。 要微调日志集合，请结合使用记录器实例和程序包名。 您还可以使用服务器端过滤器来控制由分析捕获哪个日志记录级别。

要仅捕获 `myApp` 程序包名的级别为“错误”的日志，请遵循示例中的以下步骤。

#### 微调 Cordova 应用程序
{: #fine-tuning-cordova-apps }
1. 结合使用 `WL.Logger` 实例和 `myApp` 程序包名。

   ```javascript
   var logger = WL.Logger.create({ pkg: 'MyApp' });
   ```

2. **可选：**指定过滤器，以编程方式将日志捕获和日志输出仅限制于指定的级别和程序包。

   ```javascript
   WL.Logger.config({
        filters: {
            'MyApp': 'ERROR'
        }
   });
   ```

3. **可选：**通过访存服务器配置概要文件，远程控制过滤器。

#### Web 应用程序
{: #fine-tuning-web-apps }
对于 Web SDK，客户机无法设置级别。 所有日志记录都将发送至服务器，直至通过检索服务器配置概要文件更改配置。

## 访存服务器配置概要文件
{: #fetching-server-configuration-profiles }
可以通过客户机或通过从服务器中检索配置概要文件来设置日志记录级别。 在
{{ site.data.keys.mf_analytics_console }}
中，可以全局（针对所有记录器实例）或针对一个或多个特定程序包设置日志级别。 有关从 {{ site.data.keys.mf_analytics_console }} 配置过滤器的信息，请参阅[配置日志过滤器](../../../analytics/console/log-filters/)。  为便于客户机访存服务器上设置的配置覆盖，必须从定期运行的代码中某一位置调用 `updateConfigFromServer` 方法，例如，在应用程序生命周期回调中。

#### 访存 Cordova 应用程序的服务器配置概要文件
{: #fetching-server-configuration-profiles-cordova-apps }

```javascript
WL.Logger.updateConfigFromServer();
```

#### 访存 Web 应用程序的服务器配置概要文件
{: #fetching-server-configuration-profiles-web-apps }

```javascript
ibmmfpfanalytics.logger.updateConfigFromServer();
```

## 日志记录示例
{: #logging-example }
输出到浏览器 JavaScript 控制台、LogCat 或 Xcode 控制台。

### 日志记录示例 Cordova
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

### 日志记录示例 Web
{: #logging-example-web }
对于使用 Web 应用程序的日志记录，使用前述示例并将

```javascript
var logger = WL.Logger.create({pkg: 'MathUtils'});
```

替换为

```javascript
var logger = ibmmfpfanalytics.logger.create({pkg: 'MathUtils'});
```
