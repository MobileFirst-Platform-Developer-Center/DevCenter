---
layout: tutorial
title: 安装和配置
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
{{ site.data.keys.product_full }}
提供开发工具和服务器端组件，可在本地进行安装或将其部署到云以用于测试或生产。查看适合于您的安装场景的安装主题。

### 安装开发环境
{: #installing-a-development-environment }
如果要开发移动应用程序的客户端或服务器端，请使用 [{{ site.data.keys.mf_dev_kit }}](development/mobilefirst/) 或 [{{ site.data.keys.mf_bm }} 服务](../bluemix/using-mobile-foundation)来开始。

* [设置 MobileFirst 开发环境](development/mobilefirst/)
* [设置 Cordova 开发环境](development/cordova)
* [设置 iOS 开发环境](development/ios)
* [设置 Android 开发环境](development/android)
* [设置 Windows 开发环境](development/windows)
* [设置 Xamarin 开发环境](development/xamarin)
* [设置 Web 开发环境](development/web)

### 本地安装测试或生产服务器
{: #installing-a-test-or-production-server-on-premises }
IBM 安装都基于 IBM Installation Manager。请首先单独安装 IBM Installation Manager V1.8.4 或更高版本，然后再安装 {{ site.data.keys.product }}。

> **要点：**确保您使用的是 IBM Installation Manager V1.8.4 或更高版本。更低版本的 Installation Manager 将无法安装 {{ site.data.keys.product }} {{ site.data.keys.product_version }}，因为该产品的安装后操作需要使用 Java 7，而更低版本的 Installation Manager 只随附了 Java 6。
{{ site.data.keys.mf_server }} 安装程序会将部署 {{ site.data.keys.mf_server }} 组件和 {{ site.data.keys.mf_app_center_full }}（可选）到应用程序服务器所需的所有工具和库复制到您的计算机中。

如果要安装测试或生产服务器，请开始阅读下面的**关于 {{ site.data.keys.mf_server }} 安装的教程**以执行简单安装，并了解有关 {{ site.data.keys.mf_server }} 安装的信息。有关为特定环境准备安装的更多信息，请参阅[为生产环境安装 {{ site.data.keys.mf_server }}](production)。

**关于 {{ site.data.keys.mf_server }} 安装的教程**  
通过通读有关如何在 WebSphere  Application Server Liberty Profile 上创建具有两个节点的功能性 {{ site.data.keys.mf_server }} 集群的指示信息，了解有关 {{ site.data.keys.mf_server }} 安装过程的信息。可以如下方式完成安装：

* [使用 IBM Installation Manager 图形方式](production/tutorials/graphical-mode)和 Server Configuration Tool。
* [使用命令行工具](production/tutorials/command-line)。

之后，您将拥有一个正常运行的 {{ site.data.keys.mf_server }}。但在使用此服务器之前，需对其进行配置，尤其要确保安全性。有关更多信息，请参阅[配置 {{ site.data.keys.mf_server }}](production/server-configuration)。

**新增项**  

* 要将 {{ site.data.keys.mf_analytics_server }} 添加到安装中，请参阅《[{{ site.data.keys.mf_analytics_server }} 安装指南](production/analytics/installation/)》。  
* 要安装 {{ site.data.keys.mf_app_center }}，请参阅[安装和配置 Application Center](production/appcenter)。

### 将 {{ site.data.keys.mf_server }} 部署到云
{: #deploying-mobilefirst-server-to-the-cloud }
如果计划将 {{ site.data.keys.mf_server }} 部署到云，请参阅以下选项：

* [在 IBM Bluemix 上使用 {{ site.data.keys.mf_server }}](../bluemix)。
* [在 IBM PureApplication 上使用 {{ site.data.keys.mf_server }}](production/pure-application)。

### 从较早版本进行升级
{: #upgrading-from-earlier-versions }
有关将现有安装和应用程序升级到更新版本的信息，请参阅[升级到 {{ site.data.keys.product_full }} {{ site.data.keys.product_version }}](../all-tutorials/#upgrading_to_current_version)。


