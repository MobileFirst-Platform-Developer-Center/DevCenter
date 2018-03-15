---
layout: tutorial
title: 配置日志过滤器
breadcrumb_title: Log Filters
relevantTo: [ios,android,javascript]
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }

管理员可以从 **{{ site.data.keys.mf_console }} → [您的应用程序] → [版本] → 日志过滤器**控制 {{ site.data.keys.product_adj }} 客户机 SDK 日志捕获和级别。  
通过`日志过滤器`，您可以创建可以记录的过滤器级别。可以全局（所有记录器实例）或针对特定的一个或多个包设置日志级别。

<img class="gifplayer"  alt="创建日志过滤器" src="add-log-filter.png"/>

为便于应用程序访存服务器上设置的配置覆盖，必须从定期运行的代码中某一位置调用 `updateConfigFromServer` 方法，例如，在应用程序生命周期回调中。


#### Android
{: #android }

```java
Logger.updateConfigFromServer();
```

#### iOS
{: #ios }

```objective-c
[OCLogger updateConfigFromServer];
```

#### Cordova
{: #cordova }

```javascript
WL.Logger.updateConfigFromServer();
```

#### Web
{: #web }

```javascript
ibmmfpfanalytics.logger.updateConfigFromServer();
```

服务器返回的 `Logger` 配置值优先于在客户机端设置的任何值。当已除去客户机日志概要文件并且客户机尝试检索客户机日志概要文件时，客户机将收到空有效内容。在这种情况下，`Logger` 配置缺省为最初在客户机上配置的内容。

## 转发服务器日志
{: #forwarding-server-logs }

{{ site.data.keys.mf_console }} 还使服务器管理员能够持久存储日志并将这些日志发送至 {{ site.data.keys.mf_analytics_console }}。

要转发服务器日志，请浏览至运行时**设置**屏幕，并在**其他包**下指定记录器包。  
然后，可以在 {{ site.data.keys.mf_analytics_console_short }} 中查看收集的日志。如果用户要在无须收集所有服务器日志的情况下在 {{ site.data.keys.mf_analytics_console_short }} 中利用分类适配器日志，这将很有用。
