---
layout: tutorial
title: 安装和配置
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
{{ site.data.keys.product_full }}
提供开发工具和服务器端组件，可在本地进行安装或将其部署到云以用于测试或生产。 查看适合于您的安装场景的安装主题。

### 设置开发环境
{: #installing-a-development-environment }
如果要开发移动应用程序的客户端或服务器端，请使用 [{{ site.data.keys.mf_dev_kit }}](development/mobilefirst/)或 [{{ site.data.keys.mf_bm }}服务](../bluemix/using-mobile-foundation)来开始。

**使用 {{ site.data.keys.mf_dev_kit }}**
{: #using-the-dev-kit }

{{ site.data.keys.mf_dev_kit }} 包含在个人工作站上运行和调试移动应用程序时所需要的一切内容。要使用 {{ site.data.keys.mf_dev_kit }} 开发应用程序，请遵循[设置 MobileFirst 开发环境](development/mobilefirst)教程。

**使用 {{ site.data.keys.mf_bm }}**
{: #using-mf-bluemix }

{{ site.data.keys.mf_bm }} 服务提供与 {{ site.data.keys.mf_dev_kit }} 类似的功能，但是服务在 IBM Cloud 上运行。

**为 {{ site.data.keys.product }} 应用程序设置开发环境**
{: #setting-dev-env-mf-apps }

{{ site.data.keys.product }} 提供有关可用于开发 {{ site.data.keys.product }} 应用程序的平台和工具的巨大灵活性。但是，需要一些基本设置以使所选工具能够与 {{ site.data.keys.product }} 交互。  

从以下链接中选择以设置与应用程序将使用的开发方法对应的开发环境：

* [设置 Cordova 开发环境](development/cordova)
* [设置 iOS 开发环境](development/ios)
* [设置 Android 开发环境](development/android)
* [设置 Windows 开发环境](development/windows)
* [设置 Xamarin 开发环境](development/xamarin)
* [设置 Web 开发环境](development/web)

### 本地设置测试或生产服务器
{: #installing-a-test-or-production-server-on-premises }

安装 {{ site.data.keys.product }} Server 的第一部分将使用名为 IBM Installation Manager 的 IBM 产品。必须在安装 {{ site.data.keys.product }} Server 组件之前安装 IBM Installation Manager V1.8.4 或更高版本。

> **要点：**确保您使用的是 IBM Installation Manager V1.8.4 或更高版本。 更低版本的 Installation Manager 将无法安装 {{ site.data.keys.product }} {{ site.data.keys.product_version }}，因为该产品的安装后操作需要使用 Java 7，而更低版本的 Installation Manager 只随附了 Java 6。

{{ site.data.keys.mf_server }} 安装向导使用 IBM Installation Manager 将所有服务器组件安装到服务器上。还会安装将 {{ site.data.keys.product }} Server 组件部署到应用程序服务器时所需要的工具和库。最好不要在同一个应用程序服务器实例上安装所有组件，开发服务器除外。部署工具允许选择要安装的组件。请参阅[拓扑和网络流](production/topologies)以获取安装服务器之前要考虑的要点。

请阅读下文以获取有关在特定环境上准备和安装 {{ site.data.keys.mf_server }} 及可选服务的信息。有关简单设置，请阅读[设置测试或生产环境](production)教程。

* [验证先决条件](production/#prerequisites)
* [{{ site.data.keys.mf_server }} 组件概述](production/topologies)
* 在装入工具和库以部署 MobileFirst Server 组件和 Application Centre（可选）之前要考虑的因素
  * 令牌许可证
  * MobileFirst Foundation Application Centre
  * 管理员与用户方式
* 在装入文件之后 MobileFirst Server 的分布结构
* 通过以下方式装入文件：
  * 使用 IBM Installation Manager 安装向导
  * 在命令行中运行 IBM Installation Manager
  * 使用 XML 响应文件 - 静默安装
* [为 MobileFirst Foundation Server 组件配置后端数据库](production/databases)
* [将 MobileFirst Server 安装到应用程序服务器中](production/appserver)
* [配置 MobileFirst Server](production/server-configuration)
* [安装 MobileFirst Analytics Server](production/analytics/installation)
* [安装 Application Center](production/appcenter)
* [在 IBM PureApplication System 上部署 MobileFirst Server](production/pure-application)

### 设置测试或生产环境
{: #setting-up-test-or-production-server}

通过通读有关如何在 WebSphere  Application Server Liberty Profile 上创建具有两个节点的功能性 {{ site.data.keys.mf_server }} 集群的指示信息，了解有关 {{ site.data.keys.mf_server }} 安装过程的信息。可以使用图形工具 (GUI) 或通过命令行来完成安装。

* [使用 IBM Installation Manager 和 Server Configuration Tool 进行 GUI 方式安装](production/tutorials/graphical-mode)。
* [使用命令行工具进行命令行安装](production/tutorials/command-line)。

在使用上述两种方法之一完成安装之后，根据需要，可能需要进一步的[配置](production/server-configuration)以完成设置。

### 在测试或生产环境上设置可选功能部件
{: #setting-up-optional-features-test-or-production-server}

{{ site.data.keys.product }} 包含可用于扩充测试或生产环境的可选组件。请参阅以下教程以获取更多信息：

* [安装和配置 {{ site.data.keys.mf_analytics_server }}](production/analytics/installation/)
* [安装和配置 {{ site.data.keys.mf_app_center }}](production/appcenter)

### 在云上部署 {{ site.data.keys.mf_server }} 测试或生产环境
{: #deploying-mobilefirst-server-test-or-production-on-the-cloud }

如果计划将 {{ site.data.keys.mf_server }} 部署到云，请参阅以下选项：

* [在 IBM Cloud 上使用 {{ site.data.keys.mf_server }}](../bluemix)。
* [在 IBM PureApplication 上使用 {{ site.data.keys.mf_server }}](production/pure-application)。

### 从较早版本进行升级
{: #upgrading-from-earlier-versions }
有关将现有安装和应用程序升级到更新版本的信息，请参阅[升级到 {{ site.data.keys.product_full }} {{ site.data.keys.product_version }}](../all-tutorials/#upgrading_to_current_version)。
