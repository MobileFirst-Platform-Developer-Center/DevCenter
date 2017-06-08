---
layout: tutorial
title: 方案装入程序
breadcrumb_title: 方案装入程序
relevantTo: [ios,android,javascript]
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }

> **注：**方案装入程序本质上是*实验性的*，因此不完全受支持。请酌情使用。
>
> * 一些图表未填充。

方案装入程序将使用虚拟数据填充各种 {{ site.data.keys.mf_analytics_console_full }} 图表和报告。数据将存储在 Elasticsearch 数据存储库中，与现有的测试或生产数据安全地隔离。

装入的数据本质上是合成的，直接注入到数据存储库中。它不是由客户机或服务器创建的任何实际分析数据的结果。数据的目的是使用户能够更好地查看 UI 中显示的各种报告和图表的性质。因此，数据**不**应用于测试目的。

#### 跳转至
{: #jump-to }

* [开始之前](#before-you-start)
* [连接到方案装入程序](#connecting-to-the-scenario-loader)
* [配置数据装入](#configuring-the-data-loading)
* [装入和删除数据](#loading-and-deleting-the-data)
* [查看填充的图表和表格](#viewing-the-populated-charts-and-tables)
* [禁用调试方式](#disabling-the-debug-mode)

## 开始之前
{: #before-you-start }

方案装入程序与 {{ site.data.keys.mf_analytics_console }} 打包在一起。在连接到方案装入程序之前，确保您的 {{ site.data.keys.mf_analytics_console_short }} 正在运行并且可以访问。

## 连接到方案装入程序
{: #connecting-to-the-scenario-loader }

1. 要启用方案装入程序，请设置 JVM 参数 `-DwlDevEnv=true` 或环境变量 `ANALYTICS_DEBUG=true`。

2. 使用控制台 URL 在浏览器中访问方案装入程序：`http://<console-path>/scenarioLoader`，其中，`<console-path>` 是在 `mfp-server/usr/servers/mfp/server.xml` 文件中定义的 JNDI 属性值，例如：

    `<jndiEntry jndiName="mfp/mfp.analytics.console.url" value='"http://localhost:9080/analytics/console"'/>`

3. 将显示“方案装入程序”页面以及 {{ site.data.keys.mf_analytics_console_short }} 导航栏。仍不可以从导航栏访问方案装入程序。

## 配置数据装入
{: #configuring-the-data-loading}

1. 在**测试配置**部分中，各种设置可用于控制已生成数据的性质（**基本**选项卡）和容量（**容量规划**选项卡）。确保将**历史记录天数**设置配置为至少 30 天，以便装入足够的数据。

    将在**测试配置**部分中提供有关这些设置的所有可用信息。

2. 单击**管理**图标 <img  alt="扳手图标" style="margin:0;display:inline" src="wrench.png"/>，然后选择**设置**选项卡。在**高级**部分中，确保将**缺省租户**值设置为 `dummy_data_for_demo_purposes_only`。

## 装入和删除数据
{: #loading-and-deleting-the-data }

要装入数据，请单击**方案操作**部分中的**启动方案装入**按钮。

要删除数据，请单击**测试配置**部分中的**立即删除**按钮。

**NB：**阅读**方案操作**部分中有关数据创建和删除的免责声明。

## 查看填充的图表和表格
{: #viewing-the-populated-charts-and-tables }

在装入数据之后，将填充 Analytics Console 中可用的许多（但并非所有）图表和表格。

从 {{ site.data.keys.mf_analytics_console_short }} 导航栏，检查各种页面和选项卡以查看填充的图表和表格。

## 禁用调试模式
{: #disabling-the-debug-mode }

要在使用调试方式和合成数据工作之后使用真实数据：

1. 通过单击**测试配置**部分中的**立即删除**按钮来删除数据。
2. 在**设置** → **高级**部分中确保将**缺省租户**值设置为 `worklight`。
3. 对于设置为 true 的变量，请设置为 false（JVM 参数 `-DwlDevEnv=false` 或环境变量`ANALYTICS_DEBUG=false`）。
4. 重新启动 {{ site.data.keys.mf_analytics_server }}。
