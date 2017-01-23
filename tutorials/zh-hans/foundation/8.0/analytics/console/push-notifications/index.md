---
layout: tutorial
title: 推送通知
breadcrumb_title: 推送通知
relevantTo: [ios,android,javascript]
weight: 5
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }

为推送通知设置 {{ site.data.keys.mf_analytics }} 支持（请参阅[设置分析支持](../../../notifications/analytics/)）之后，您可以创建有关推送使用情况的报告。

## 推送报告
{: #push-reports }

在配置 {{ site.data.keys.mf_analytics_short }} 支持并且将推送事件发送至 {{ site.data.keys.mf_analytics_short }} 服务之后，“推送通知”报告将变得可用。

1. 在 {{ site.data.keys.mf_analytics_console }} 中，从导航栏选择**基础结构**部分。
2. 选择**推送通知**选项卡。

将显示两种报告类型：

**通知请求**  
将根据请求的时间段、应用程序和版本显示请求数，按日期细分。

**通过介体发送的通知**  
根据应用程序平台、请求的时间段、应用程序和版本来细分请求数。

![“推送通知”报告](pushNotifications.png)
