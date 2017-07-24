---
layout: tutorial
title: 使用 Analytics REST API
breadcrumb_title: Analytics REST API
relevantTo: [ios,android,cordova]
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }

{{ site.data.keys.mf_analytics_full }} 提供 REST API，可帮助开发人员导入 (POST) 和导出 (GET) 分析数据。

## 跳转至：
{: #jump-to }

* [Analytics REST API](#analytics-rest-api)
* [在 Swagger Docs 上试用](#try-it-out-on-swagger-docs)

## Analytics REST API
{: #analytics-rest-api }

要使用 Analytics REST API：

**基本 URL**

`/analytics-service/rest`

**示例**

`https://example.com:9080/analytics-service/v3/applogs`


REST API 方法 | 端点 | 描述
--- | --- | ---
应用程序日志 (POST) | /v3/applogs | 创建新的应用程序日志。
应用程序会话 (POST) | /v3/appsession | 当使用同一个 appSessionID 进行报告时，创建一个应用程序会话或更新现有的应用程序会话。
批量 (POST) | /v3/bulk | 批量报告事件。
定制图表 (GET)| /v3/customchart | 导出所有定制图表定义。
定制图表 (POST) | /v3/customchart/import | 导入定制图表的列表。
定制数据 (POST) | /v3/customdata | 创建新的定制数据。
设备 (POST) | /v3/device | 创建或更新设备。
导出数据 (GET) | /v3/export | 将数据导出为指定的数据格式。
网络事务 (POST) | /v3/networktransaction |  创建新的网络事务。
服务器日志 (POST) | /v3/serverlog | 创建新的服务器日志。
用户 (POST) | /v3/user | 创建新用户。

## 在 Swagger Docs 上试用
{: #try-it-out-on-swagger-docs }

在 Swagger Docs 上试用 Analytics REST API。  
在启用了分析的 {{ site.data.keys.mf_server }} 配置中，请访问：`<ipaddress>:<port>/analytics-service`。

![{{ site.data.keys.mf_analytics }} Swagger Docs UI](analytics-swagger.png)

通过单击**扩展操作**，您可以查看每个方法的实现说明、参数和响应消息。

> 警告：通过**试用！**发送的任何数据可能会干扰已位于数据存储器中的数据。如果您没有特意尝试将数据发送到生产环境，那么请对 `x-mfp-analytics-api-key` 使用测试名称。
![测试 Swagger Docs](test-swagger.png)
