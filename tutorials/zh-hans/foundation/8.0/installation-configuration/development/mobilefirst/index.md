---
layout: tutorial
title: 设置 MobileFirst 开发环境
breadcrumb_title: MobileFirst
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
{{ site.data.keys.product_full }} 由以下组件组成：客户机 SDK、适配器原型、安全性检查和认证工具。

可以从在线存储库中获取这些组件，并可以使用软件包管理器来安装这些组件。这些在线存储库提供了各个组件的最新发行版。也可以从 {{ site.data.keys.mf_dev_kit }} 下载相同的组件以在本地使用。请注意，{{ site.data.keys.mf_dev_kit_short }} 提供的版本表示发布特定 {{ site.data.keys.mf_dev_kit_short }} 构件时提供的版本；要使用最新版本，需要下载新的 {{ site.data.keys.mf_dev_kit_short }} 构件。 

继续阅读以了解有关 {{ site.data.keys.product }} 组件的更多信息。

> 要评估 {{ site.data.keys.product }}，只需使用 Mobile Foundation Bluemix 服务在 Bluemix 上扩展 {{ site.data.keys.mf_server }} 实例即可。请参阅[使用 Mobile Foundation](../../../bluemix/using-mobile-foundation/) 教程，以获取相关指示信息。也可以选择安装 {{ site.data.keys.mf_dev_kit_short }} 作为本地安装。

#### 跳至：
{: #jump-to }

* [安装指南](#installation-guide)
* [{{ site.data.keys.mf_dev_kit }}](#mobilefirst-developer-kit)
* [{{ site.data.keys.product }} 组件](#mobilefirst-foundation-components)
* [应用程序和适配器开发](#applications-and-adapters-development)
* [后续教程](#tutorials-to-follow-next)

## 安装指南
{: #installation-guide }
请[阅读安装指南](installation-guide)，以便在工作站中快速设置 MobileFirst Foundation。

## {{ site.data.keys.mf_dev_kit }}
{: #mobilefirst-developer-kit }
{{ site.data.keys.mf_dev_kit_short }} 提供了具有最低配置的支持开发的环境。此工具包中包含 {{ site.data.keys.mf_server }}、{{ site.data.keys.mf_console }} 和 MobileFirst Developer 命令行界面 (CLI)，并选择性地提供了可供下载的客户机 SDK 和适配器工具。

> **注：**如果您需要在未连接因特网的计算机上设置开发环境，那么可脱机安装组件。请参阅[如何设置脱机 IBM MobileFirst 开发环境]({{site.baseurl}}/blog/2016/03/31/howto-set-up-an-offline-ibm-mobilefirst-8-0-development-environment)。

### {{ site.data.keys.mf_dev_kit_short }}安装程序
{: #developer-kit-installer }
对于无法连接因特网的本地安装，安装程序也打包了适用于这类安装的组件。  
可通过 {{ site.data.keys.mf_console }} 的“下载中心”来获取这些组件。

> 要下载安装程序，请访问[下载]({{site.baseurl}}/downloads/)页面。

## {{ site.data.keys.product }} 组件
{: #mobilefirst-foundation-components }

### {{ site.data.keys.mf_server }}
{: #mobilefirst-server }
WebSphere Liberty Profile 应用程序服务器上提供并预先部署了 {{ site.data.keys.mf_server }}（作为 {{ site.data.keys.mf_dev_kit_short }} 的一部分）。该服务器通过“mfp”运行时进行预配置，并使用基于文件系统的 Apache Derby 数据库。

在 {{ site.data.keys.mf_dev_kit_short }} 根目录中，提供了可从命令行中运行的以下脚本：

* `run.[sh|cmd]`：使用尾部 Liberty Server 消息运行 {{ site.data.keys.mf_server }}
    * 添加 `-bg` 标志以在后台运行该进程
* `stop.[sh|cmd]`：停止当前的 {{ site.data.keys.mf_server }} 实例
* `console.[sh|cmd]`：打开 {{ site.data.keys.mf_console }}

`.sh` 文件扩展名用于 Mac 和 Linux，而 `.cmd` 文件扩展名用于 Windows。

### {{ site.data.keys.mf_console }}
{: #mobilefirst-operations-console }
{{ site.data.keys.mf_console }} 公开了以下功能。  
开发人员可以：

- 注册和部署应用程序及适配器
- 选择性地下载本机/Cordova 应用程序和适配器起动器代码模板 
- 配置应用程序的认证和安全性属性
- 管理应用程序：
    - 应用程序真实性
    - 直接更新
    - 远程禁用/通知
- 将推送通知发送到 iOS 和 Android 设备
- 生成 DevOps 脚本以实现连续集成工作流和缩短开发周期

> 请参阅[使用 MobilFirst Operations Console](../../../product-overview/components/console/) 教程，以了解有关 {{ site.data.keys.mf_console }} 的更多信息。
### {{ site.data.keys.product }} 命令行界面
{: #mobilefirst-foundation-command-line-interface }
除了使用 {{ site.data.keys.mf_console }} 之外，还可以使用 {{ site.data.keys.mf_cli }} 开发和管理应用程序。
CLI 命令使用 `mfpdev` 作为前缀，并支持以下类型的任务：

* 向 {{ site.data.keys.mf_server }} 注册应用程序
* 配置您的应用程序
* 创建、构建和部署适配器
* 预览和更新 Cordova 应用程序

> 要下载并安装 {{ site.data.keys.mf_cli }}，请访问[下载]({{site.baseurl}}/downloads/)页面。  
>请参阅[使用 CLI 管理 MobileFirst 工件](../../../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts/)教程，以了解有关各种 CLI 命令的更多信息。

### {{ site.data.keys.product }} 客户机 SDK 和适配器工具
{: #mobilefirst-foundation-client-sdks-and-adapter-tooling }
{{ site.data.keys.product }} 提供了用于 Cordova 应用程序和本机平台（iOS、Android、Windows 8.1 Universal 和 Windows 10 UWP）的客户机 SDK。同时还提供了用于适配器和安全性检查开发的适配器工具。

* 要使用 {{ site.data.keys.product_adj }} 客户机 SDK，请访问[添加 {{ site.data.keys.product }}SDK](../../../application-development/sdk/) 教程类别。  
* 要开发适配器，请访问[适配器](../../../adapters/)教程类别。  
* 要开发安全性检查，请访问[认证和安全性](../../../authentication-and-security/)教程类别。  

## 应用程序和适配器开发
{: #applications-and-adapters-development }

### 应用程序
{: #applications }
* Cordova 应用程序需要 NodeJS 和 Cordova CLI。请阅读有关[设置 Cordova 开发环境](../cordova)的更多信息。

    您可以使用自己首选的代码编辑器（如 Atom.io、Visual Studio Code、Eclipse、IntelliJ 等）来实施应用程序和适配器。  
    
* 本机应用程序需要 Xcode、Android Studio 或 Visual Studio。请阅读有关[设置 iOS/Android/Windows 开发环境](../)的更多信息。

### 适配器
{: #adapters }
适配器要求安装 Apache Maven。请参阅[适配器](../../../adapters/)类别，以了解有关适配器以及如何创建、开发和部署适配器的更多信息。

## 后续教程
{: #tutorials-to-follow-next }
请访问[全部教程](../../../all-tutorials/)页面，并选择接下来要学习的教程类别。

