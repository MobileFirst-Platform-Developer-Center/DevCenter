---
layout: tutorial
title: Operations Console 和 Analytics Console
breadcrumb_title: Analytics Console
relevantTo: [ios,android,javascript]
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->

## 概述
使用 Operations Console 和 Analytics Console 配置客户机使用 {{ site.data.keys.mf_analytics_server }} 的方式、配置和查看各种报告。

## {{ site.data.keys.mf_analytics_console_full }}
从 {{ site.data.keys.mf_analytics_console }} 查看和配置分析报告。管理警报和查看客户机日志。

您可以通过单击右上导航栏中的 **Analytics Console** 链接，从 {{ site.data.keys.mf_console }} 打开 {{ site.data.keys.mf_analytics_console_short }}。

![Analytics Console 按钮](analytics-console-button.png)

在导航到 {{ site.data.keys.mf_analytics_console_short }} 之后，将显示缺省的**仪表板**面板。如果客户机应用程序已将日志和分析数据发送到服务器，那么将填充相关报告。可以从导航栏中选择**应用程序**和**基础结构**。

![Analytics Console](analytics-console.png)

### 仪表板
在**仪表板**面板中，您可以查看收集的与应用程序崩溃、应用程序会话和服务器处理时间相关的分析数据。另外，您还可以创建定制图表和管理警报。

### 应用程序
在**应用程序**面板中，您可以查看与使用情况和设备（如设备和应用程序会话总数、活动用户、应用程序使用情况、新设备、型号使用情况和操作系统）相关的深入分析数据以及与崩溃相关的数据。在客户机日志中搜索特定的应用程序和设备（**应用程序 → 客户机日志搜索**）。


### 基础结构
在**基础结构**面板中，您可以查看与以下项相关的分析数据：会话处理时间、平均请求大小、服务器请求、网络请求、适配器响应时间、过程响应时间、大小和适配器使用情况以及推送通知数据（如通知请求和依据介体）。您也可以在服务器日志中搜索。

> 在[分析工作流程](../workflows/)教程中了解更多信息。

## 分析功能

### 应用程序分析
从**应用程序 → 使用情况和设备**选项卡，您可以查看“应用程序会话”图表和“应用程序使用情况”图表，了解用户使用频率最高的应用程序。

### 内置分析
将 {{ site.data.keys.product_adj }} 客户机 SDK 与 {{ site.data.keys.mf_server }} 一起使用时，会针对您的应用程序向 {{ site.data.keys.mf_server }} 发出的任何请求自动收集分析数据。从**仪表板 → 概述**，查看收集并报告至 {{ site.data.keys.mf_analytics_server }} 的基本设备元数据。

### 定制分析
您可以让自己的应用程序发送定制数据，并针对定制数据创建定制图表。

> 在 [Analytics API](../analytics-api/) 教程中了解如何发送定制分析。

### 定制图表
定制图表允许您将分析数据存储库中收集的分析数据直观呈现为缺省情况下在 {{ site.data.keys.mf_analytics_console_short }} 中不可用的图表（**仪表板 → 定制图表**）。该直观呈现功能是分析业务关键型数据的有效方式。

> 在[创建定制图表](custom-charts/)教程中了解如何创建定制图表。

### 管理警报
警报提供一种主动方式来监控移动应用程序的运行状况，无需定期检查 {{ site.data.keys.mf_analytics_console }}。

从**仪表板 → 警报管理**选项卡，您可以配置阈值，如果超出阈值，将触发警报以通知管理员。您可以在控制台上直观呈现触发的警报，或者使用定制 web hook 处理警报。定制 web hook 允许您控制触发警报后通知谁以及如何通知。

> 在[管理警报](alerts/)教程中了解如何管理警报。

### 监视应用程序崩溃
应用程序崩溃直观呈现在 {{ site.data.keys.mf_analytics_console_short }} 上（**应用程序 → 崩溃**），您可以在其中快速查看崩溃并相应地采取行动。崩溃日志缺省情况下在设备上收集，并且*在重新运行应用程序后*发送至服务器。在将崩溃日志发送到分析服务器后，它们将自动填充崩溃图表。

### 监视服务器和网络数据
{{ site.data.keys.mf_analytics_console_short }} 会在将网络数据发送到分析服务器时监视网络数据，并且允许用户以不同的方式查询此信息（**基础结构 → 服务器和网络**）。


### 收集、搜索和报告客户机日志
可以将客户机日志发送至服务器并且包含在分析报告中。

要将日志记录信息包含在报告中：

1. 从 {{ site.data.keys.mf_analytics_console_short }}，选择**仪表板 → 定制图表**选项卡。

2. 从**事件类型**下拉菜单中选择**客户机日志**。

有关**定制图表**的更多信息，请参阅[创建定制图表](custom-charts/)。

可以过滤日志记录数据。可以在分析服务器上配置和保存日志过滤器，然后由客户机应用程序检索。

有关配置日志过滤器的信息，请参阅[客户机日志搜索](log-filters/)教程。

有关从客户机发送日志的更多信息，请参阅[客户机日志收集](../../application-development/client-side-log-collection/)。



## {{ site.data.keys.mf_console_full }}
使用 {{ site.data.keys.mf_console }} 配置并管理分析服务器。

如果您位于 {{ site.data.keys.mf_analytics_console_short }} 中，请通过单击顶部导航栏中的 **Operations Console** 按钮来访问 {{ site.data.keys.mf_console }}。

### 从其他记录器软件包收集分析数据
缺省情况下，只会将来自包 `com.worklight` 的日志记录发送至分析。要添加来自其他软件包的日志记录，请参阅[将日志转发至分析服务器](../../adapters/server-side-log-collection/java-adapter/#forwarding-logs-to-the-analytics-server)。


### 启用/禁用分析支持
{: #enabledisable-analytics-support}

缺省情况下，启用由分析服务器收集数据以进行分析的功能。您可以将其禁用，譬如为节省处理时间。

1. 在导航侧边栏中，单击**运行时设置**。为避免无意中更改，将以只读方式显示运行时属性。
2. 要使设置可编辑，请单击**编辑**按钮。如果以*管理员*或*部署者*之外的角色登录，**编辑**按钮将不可见，因为不允许您修改运行时属性。
3. 从**已启用数据收集**下拉菜单中选择 **false** 以禁用数据收集。
4. 单击**保存**。
5. 单击**只读**按钮以再次锁定属性。


![在控制台中启用或禁用分析支持](enable-disable-analytics.png)


### 基于角色的访问控制
{{ site.data.keys.mf_analytics_console_short }} 中的内容受到预定义的安全角色的限制。  
{{ site.data.keys.mf_analytics_console_short }} 基于登录用户的安全角色显示不同的内容。下表显示了安全角色及其对 {{ site.data.keys.mf_analytics_console_short }} 的访问权。

| 角色           | 角色名称                | 查看访问权                                                     | 编辑访问权  |
|----------------|--------------------------|--------------------------------------------------------------------|-----------------|
| 管理员  | analytics_administrator  | 全部。	                                                     | 全部。     |
| 基础结构 | analytics_infrastructure	| 全部。	                                                     | 全部。     |
| 开发人员      | analytics_developer	    | 除“管理”页面外的全部。		             | 全部。     |
| 支持        | analytics_support        | 除“管理”页面外的全部。		             | 全部。     |
| 业务       | analytics_business       | 除“管理”和“基础结构”页面外的全部。 | 全部。     |

> 有关设置角色的信息，请参阅[为 {{ site.data.keys.mf_server }} 管理配置用户认证](../../installation-configuration/production/server-configuration#configuring-user-authentication-for-mobilefirst-server-administration)。


## 相关博客帖子
* [有关检测定制分析的更多信息]({{site.baseurl}}/blog/2016/01/22/howto-custom-in-app-behavior-analytics/)
* [有关检测 Webhook 的更多信息]({{site.baseurl}}/blog/2015/10/19/using-mfp-adapters-endpoint-analytics-alerts-webhooks/)
