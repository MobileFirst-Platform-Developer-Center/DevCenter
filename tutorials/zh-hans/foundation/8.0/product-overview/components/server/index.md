---
layout: tutorial
title: MobileFirst Server
relevantTo: [ios,android,windows,javascript]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
{{ site.data.keys.mf_server }} 由多个组件组成。为您提供了 {{ site.data.keys.mf_server }} 体系结构概述，便于您了解每个组件的功能。

与 {{ site.data.keys.mf_server }} V7.1 或更早版本不同的是，V8.0.0 的安装过程独立于移动应用操作的开发和部署。在 V8.0.0 中，安装并配置服务器组件和数据库之后，可以运行 {{ site.data.keys.mf_server }} 来执行大部分操作，而无需访问应用程序服务器或数据库配置。

{{ site.data.keys.product_adj }} 工件的管理和部署操作通过 {{ site.data.keys.mf_console }} 或 {{ site.data.keys.mf_server }} 管理服务的 REST API 来执行。这些操作也可以使用包含此 API 的一些命令行工具来执行，例如 mfpdev 或 mfpadm。{{ site.data.keys.mf_server }} 的授权用户可以修改移动应用程序的服务器端配置，上载或配置服务器端代码（适配器），上载 Cordova 移动应用的新 Web 资源，运行应用程序管理操作等操作。

除了网络基础结构或应用程序服务器的安全层之外，{{ site.data.keys.mf_server }} 提供了额外层次的安全保护。这些安全功能包括控制应用程序真实性和对服务器端资源与适配器的访问控制。这些安全配置也可以由 {{ site.data.keys.mf_console }} 的授权用户和管理服务来完成。您可以按照[为 {{ site.data.keys.mf_server }} 管理配置用户认证](../../../installation-configuration/production/server-configuration)所述，将 {{ site.data.keys.product_adj }} 管理员映射到安全角色来确定这些管理员的权限。

预先配置且不需要必备软件（例如，数据库或应用程序服务器）的 {{ site.data.keys.mf_server }} 简化版本可供开发者使用。请参阅[设置 {{ site.data.keys.product_adj }} 开发服务器](../../../installation-configuration/development)。

## {{ site.data.keys.mf_server }} 组件
{: #mobilefirst-server-components }
{{ site.data.keys.mf_server }} 组件的体系结构如下图所示：

![组成 {{ site.data.keys.mf_server }} 的组件](server_components.jpg)

### {{ site.data.keys.mf_server }} 的核心组件
{: #core-components-of-mobilefirst-server }
{{ site.data.keys.mf_console }}、{{ site.data.keys.mf_server }} 管理服务、{{ site.data.keys.mf_server }} 实时更新服务、{{ site.data.keys.mf_server }} 工件和 {{ site.data.keys.product_adj }} 运行时是要安装的最少组件集。 

* 该运行时为在移动设备上运行的移动应用提供 {{ site.data.keys.product_adj }} 服务。
* 该管理服务提供配置和管理功能。您可以通过 {{ site.data.keys.mf_console }}、实时更新服务 REST API 或命令行工具（例如 mfpadm 或 mfpdev）来使用管理服务。 
* 该实时更新服务管理由该管理服务使用的配置数据。

这些组件需要数据库。每个组件的数据库表名没有任何交集。因此，您可以使用同一个数据库，甚至同一个模式来存储这些组件的所有表。有关更多信息，请参阅[设置数据库](../../../installation-configuration/production/server-configuration)。

可以安装多个运行时实例。在此情况下，每个实例都需要自己的数据库。工件组件为 {{ site.data.keys.mf_console }} 提供资源。它不需要数据库。

### {{ site.data.keys.mf_server }} 的可选组件
{: #optional-components-of-mobliefirst-server }
{{ site.data.keys.mf_server }} 推送服务提供推送通知功能。必须安装此服务才能为移动应用提供使用 {{ site.data.keys.product_adj }} 推送功能的能力。从移动应用的角度而言，推送服务的 URL 与运行时的 URL 相同，除了上下文根为 `/imfpush` 之外。

如果计划将推送服务安装到不同于运行时的服务器或集群，需要配置 HTTP Server 的路由规则。此配置是为了确保能够正确路由发送到推送服务和运行时的请求。 

推送服务需要数据库。推送服务的表与运行时、管理服务和实时更新服务的表没有交集。因此，也可以安装在同一数据库或模式中。

{{ site.data.keys.mf_analytics }}服务和{{ site.data.keys.mf_analytics_console }} 提供有关移动应用使用情况的监控和分析信息。移动应用可以使用 Logger SDK 来提供更多洞察力。{{ site.data.keys.mf_analytics }}服务不需要数据库。它通过使用 Elasticsearch 将数据存储在本地或磁盘。这些数据采用片状结构，可以在分析服务集群的成员之间进行复制。

有关这些组件的网络流和拓扑约束的更多信息，请参阅[拓扑和网络流](../../../installation-configuration/production/server-configuration)。

### 安装过程
{: #installation-process }
{{ site.data.keys.mf_server }} 本地部署的安装可以通过使用以下方法来完成：

* 服务器配置工具 - 图形向导
* 通过命令行工具的 Ant 任务
* 手动安装

有关 {{ site.data.keys.mf_server }} 本地部署安装的更多信息，请参阅：

* WebSphere Application Server Liberty 概要文件上 {{ site.data.keys.mf_server }} 场的[完整安装指南](../../../installation-configuration/production/)。本指南基于简单场景，供您以图形方式或命令行方式尝试安装。
* [详细章节](../../../installation-configuration/production/)，其中包含与安装先决条件、数据库设置、服务器拓扑、将组件部署到应用程序服务器和服务器配置有关的详细信息。

