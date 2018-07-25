---
layout: tutorial
title: MobileFirst Analytics
breadcrumb_title: Analytics
show_children: true
relevantTo: [ios,android,javascript]
weight: 9
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }

{{ site.data.keys.mf_analytics_full }} 将从 {{ site.data.keys.mf_server }} 和客户机设备中的应用程序到服务器活动、客户机日志、客户机崩溃和服务器端日志中收集数据。 然后，收集的数据将提供针对移动状况和服务器基础结构的丰富视图。 其中包含：用户保留时间、崩溃报告、设备类型和操作系统细分、定制数据和定制图表、网络使用情况、推送通知结果、应用程序内行为、调试日志收集等的缺省报告。

{{ site.data.keys.mf_server }} 随附经过预检测的网络基础结构报告。 当客户机和服务器同时报告网络使用情况时，将汇总数据以便您可以将性能欠佳归因于网络、服务器或后端系统。 此外，您还可以通过在客户机端和 {{ site.data.keys.mf_analytics_server }} 上定义过滤器来控制分析所访问和使用的记录器数据。 选择所报告事件的详细程度和数据保留策略、设置条件警报、构建定制图表和使用新数据。

#### 平台支持
{: #platform-support }

{{ site.data.keys.mf_analytics }} 支持：

* 本机 iOS 和 Android 客户机
* Cordova 应用程序（iOS 和 Android）
* Web 应用程序
* 支持**不可用**于 Windows 8.1 Universal 或 Windows 10 UWP

IBM {{ site.data.keys.mf_server }} 随附经过预检测的网络基础结构报告。 当客户机和服务器同时报告其网络使用情况时，将汇总数据以便您可以将性能欠佳归因于网络、服务器或后端系统。

## 客户机开发
{: #client-development }

下面两个客户机类协力将原始数据发送至服务器：Logger 类和 Analytics 类。

### Analytics API
{: #the-analytics-api }

分析客户机 API 收集有关各种事件的数据并将其发送至 {{ site.data.keys.mf_analytics_server }}。
> 在[分析客户机开发](analytics-api)教程中了解更多信息。

### Logger API
{: #the-logger-api }

Logger 将作为标准记录器运行。 您也可以在任何日志记录级别将记录器数据从客户机发送至 {{ site.data.keys.mf_analytics_server }}。 但是，服务器配置将控制允许的日志记录请求级别。 将忽略在此阈值下发送的请求。

需要控制日志记录级别以均衡两个需求：收集信息的需求和限制数据量以适应有限存储能力的需求。

> 在[客户机日志记录](../application-development/client-side-log-collection/)教程中了解更多信息。

此外，您还可以通过在客户端和 {{ site.data.keys.mf_analytics_server }}上定义过滤器来控制分析所访问和使用的记录器数据。

## Analytics Console 和 Operations Console
{: #the-analytics-and-operations-consoles }

{{ site.data.keys.product_full }} 提供 Analytics Console 和 Operations Console。 {{ site.data.keys.mf_console_full }} 可配置分析服务器与客户机应用程序的协作方式。 {{ site.data.keys.mf_analytics_console_full }} 配置并显示各种分析报告。

> 在 [Operations Console](console) 教程中了解更多信息。

> 在[定制图表](console/custom-charts)教程中了解有关使用 Analytics Console 创建定制图表的更多信息。

## 分析服务器
{: #the-analytics-server }

分析服务器在开发和生产环境中可用。

对于开发，分析服务器将与 {{ site.data.keys.mf_dev_kit }} 一起安装。  有关更多信息，请参阅[设置 {{ site.data.keys.product_adj }} 开发环境](../installation-configuration/development/mobilefirst/)。 安装工具包之后，{{ site.data.keys.mf_analytics_console_short }} 可满足您的开发需求。

对于生产，根据您的可用的基础结构、业务需求、系统设计等提供不同的安装和配置选项。有关更多信息，请参阅[设置 {{ site.data.keys.product_adj }} 开发环境](../installation-configuration/production/analytics/)。

{{ site.data.keys.mf_analytics }} 使用 Elasticsearch。 [了解如何使用 Elasticsearch](elasticsearch)（在 {{ site.data.keys.product }} 中）。

## 故障诊断
{: #troubleshotting }

有关对 {{ site.data.keys.mf_analytics }} 进行故障诊断的信息，请参阅[分析故障诊断](../troubleshooting/analytics/)。

## 接下来要阅读的内容
{: #what-to-read-next }
