---
layout: tutorial
title: 登录 Android 应用程序
breadcrumb_title: 登录 Android
relevantTo: [android]
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }

此教程提供必需的代码片段以在 Android 应用程序中添加日志记录功能。

**先决条件：**确保阅读[客户端日志收集的概述](../)。

## 启用日志捕获
{: #enabling-log-capture }
缺省情况下，已启用日志捕获。 日志捕获将日志保存到客户机并且可以编程方式启用或禁用。 使用显式发送调用或自动日志将日志发送到服务器

> **注：**按详细级别启用日志捕获可能在客户机通过网络发送日志时影响设备 CPU 使用、文件系统空间和有效内容大小。

要禁用日志捕获：

```java
Logger.setCapture(false);
```

## 发送捕获的日志
{: #sending-captured-logs }
根据应用程序逻辑，将日志发送到 {{ site.data.keys.product_adj }}。 也可启用自动日志发送以自动发送日志。 如果在达到最大大小后才发送日志，那么将清除日志文件以容纳更新的日志。

> **注：**收集日志数据时，采用以下模式。 按时间间隔发送数据可确保您在 {{ site.data.keys.mf_analytics_console }} 中近实时地查看日志数据。

```java
Timer timer = new Timer();
timer.schedule(new TimerTask() {
  @Override
  public void run() {
    Logger.send();
  }
}, 0, 60000);
```

要确保发送所有捕获的日志，请考虑以下策略之一：

* 按时间间隔调用 `send` 方法。
* 从应用程序生命周期事件回调中调用 `send` 方法。
* 增加持久性日志缓冲区的最大文件大小（字节）：

```java
Logger.setMaxFileSize(150000);
```

## 自动日志发送
{: auto-log-sending }
缺省情况下，启用自动日志发送。 每次将成功的资源请求发送到服务器后，也将发送捕获的日志，并且发送之间存在 60 秒最小时间间隔。 可以从客户机启用或禁用自动日志发送。

要启用：

```java
Logger.setAutoSendLogs(true);
```

要禁用：

```java
Logger.setAutoSendLogs(false);
```

## 使用记录器 API 微调
{: #fine-tuning-with-the-logger-api }
{{ site.data.keys.product_adj }} 客户机 SDK 内部使用记录器 API。 缺省情况下，您将捕获 SDK 生成的日志条目。 要微调日志收集，请结合使用记录器实例和程序包名。 您还可以使用服务器端过滤器来控制由分析捕获哪个日志记录级别。

要仅捕获 `myApp` 程序包名的级别为“错误”的日志，请遵循示例中的以下步骤。

1. 结合使用 `logger` 实例和 `myApp` 程序包名。

   ```java
   Logger logger = Logger.getInstance("MyApp");
   ```

2. **可选：**指定过滤器，以编程方式将日志捕获和日志输出仅限制于指定的级别和程序包。

   ```java
   HashMap<String, LEVEL> filters = new HashMap<>();
   filters.put("MyApp", LEVEL.ERROR);
   Logger.setFilters(filters);
   ```

3. **可选：**通过访存服务器配置概要文件，远程控制过滤器。

## 访存服务器配置概要文件
{: #fetching-server-configuration-profiles }
可以通过客户机或通过从服务器中检索配置概要文件来设置日志记录级别。 在
{{ site.data.keys.mf_analytics_console }}
中，可以全局（针对所有记录器实例）或针对一个或多个特定程序包设置日志级别。

> 有关从 {{ site.data.keys.mf_analytics_console }} 配置过滤器的信息，请参阅[配置日志过滤器](../../../analytics/console/log-filters/)。

为便于客户机访存服务器上设置的配置覆盖，必须从定期运行的代码中某一位置调用 `updateConfigFromServer` 方法，例如，在应用程序生命周期回调中。

```java
Logger.updateConfigFromServer();
```

## 日志记录示例
{: #logging-example }
输出到浏览器 JavaScript 控制台、LogCat 或 Xcode 控制台。

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
