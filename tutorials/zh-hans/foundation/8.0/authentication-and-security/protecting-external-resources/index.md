---
layout: tutorial
title: 使用 MobileFirst Server 来认证外部资源
breadcrumb_title: 保护外部资源
relevantTo: [android,ios,windows,javascript]
weight: 12
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
受保护资源可在 {{ site.data.keys.mf_server }}（例如，**适配器**）或**外部服务器**上运行。您可以使用 {{ site.data.keys.product }} 随附的验证模块来保护外部服务器上的资源。

在此教程中，您将了解如何通过实施验证 {{ site.data.keys.product_adj }} **访问令牌**的**过滤器**来保护外部**资源服务器**。  
您可以完全使用定制代码或者使用封装部分流程的一个 {{ site.data.keys.product }} helper 库来实施此类保护。

**先决条件：**  

* 了解 [{{ site.data.keys.product_adj }} 安全框架](../)。

## 流程
{: #flow }
![保护外部资源图](external_resources_flow.jpg)

{{ site.data.keys.mf_server }} 具有一个名为**自省端点**的组件，能够验证 {{ site.data.keys.product_adj }} **访问令牌**中的数据以及从中抽取数据。可通过 REST API 使用此自省端点。

1. 使用 {{ site.data.keys.product }} 客户机 SDK 的应用程序使用或不使用 `Authorization` 头（**客户机访问令牌**）对受保护资源进行资源请求调用（或任何 HTTP 请求）。
2. 要与自省端点进行通信，资源服务器上的**过滤器**需要为自身获取单独的令牌（请参阅**保密客户机**部分）。
3. 资源服务器上的**过滤器**通过步骤 1 抽取**客户机访问令牌**，并将其发送到自省端点以进行验证。
4. 如果 {{ site.data.keys.product_adj }} 授权服务器确定令牌无效（或者不存在），那么资源服务器会重定向客户机以获取必需作用域的新令牌。在使用 {{ site.data.keys.product_adj }} 客户机 SDK 时，本部分会在内部发生。

## 保密客户机
{: #confidential-client }
因为自省端点是作用域 `authorization.introspect` 保护的内部资源，所以资源服务器需要获取单独的令牌以向其发送任何数据。如果尝试针对自省端点发出请求而不使用授权头，那么将返回 401 响应。

要使外部资源服务器能够请求 `authorization.introspect` 作用域的令牌，需要通过 {{ site.data.keys.mf_console }} 将服务器注册为**保密客户机**。  

> 在[保密客户机](../confidential-clients/)教程中了解更多信息。

在 {{ site.data.keys.mf_console }} 中的**设置 → 保密客户机**下，添加新条目。选择**客户机密钥**和 **API 密钥**值。确保将 `authorization.introspect` 设置为**允许的作用域**。

<img class="gifplayer" alt="配置保密客户机" src="confidential-client.png"/>

## 实施
{: #implementations }
可通过直接对各种 REST API 发出 HTTP 请求来手动实施此流程（请参阅文档）。  
{{ site.data.keys.product }} 还提供库，以帮助您使用提供的**信任关联拦截器**在 **WebSphere** 服务器上实现此操作，或者使用提供的 **Java 令牌验证程序**在其他任何基于 Java 的过滤器上实现此操作：
