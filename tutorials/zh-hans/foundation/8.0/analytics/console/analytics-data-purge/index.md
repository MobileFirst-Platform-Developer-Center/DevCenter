---
layout: tutorial
title: 数据保留和清除
breadcrumb_title: Data Retention and Purging
relevantTo: [ios,android,javascript]
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }

{{ site.data.keys.mf_analytics }} 数据存储在服务器上，可用于报告直至数据被清除。您可以控制保留或清除哪些事件类型数据。可以定期或手动清除数据。

## 从 Analytics Console 配置数据保留
{: #configuring-data-retention-from-the-analytics-console }

1. 从 {{ site.data.keys.mf_analytics_console }}，单击**管理**图标 (<img  alt="扳手图标" style="margin:0;display:inline" src="wrench.png"/>)。
2. 选择**设置**选项卡。

   ![数据保留配置](analytics_console_data_retention.png)

   * 选择**丢弃**单选按钮以立即删除数据。
   * 在**数据保留时间**列中，选择要保留的天数，或者保留缺省的**无限期保留数据**值。

3. 单击**保存更改**。

新的保留策略就位。
