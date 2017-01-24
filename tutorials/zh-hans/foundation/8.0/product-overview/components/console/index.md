---
layout: tutorial
title: 使用 MobileFirst Operations Console
breadcrumb_title: MobileFirst Operations Console
relevantTo: [ios,android,windows,javascript]
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
{{ site.data.keys.mf_console_full }}    是基于 Web 的 UI，支持为开发人员和管理员简化创建、监控、保护和管理应用程序与适配器的工作流程。

#### 作为开发人员
{: #as-a-developer }
* 开发用于任何环境的应用程序，并且将其注册到 {{ site.data.keys.mf_server }}   。
* 查看所有已部署的应用程序和适配器概览。查看仪表板。
* 管理和配置已注册的应用程序，包括直接更新、远程禁用和用于应用程序真实性与用户认证的安全性参数。
* 通过部署证书、创建通知标记和发送通知来设置推送通知。
* 创建并部署适配器。
* 下载样本。

#### 作为 IT 管理员
{: #as-an-it-administrator }
* 监控各种服务。
* 搜索访问 {{ site.data.keys.mf_server }}    的设备，并管理其访问权。
* 动态更新适配器配置。
* 通过日志概要文件来调整客户机记录器配置。
* 跟踪产品许可证的使用方式。

#### 跳转至：
{: #jump-to }
* [访问控制台](#accessing-the-console)
* [浏览控制台](#navigating-the-console)

## 访问控制台
{: #accessing-the-console }
可以如下方式访问 {{ site.data.keys.mf_console }}   ：

### 从本地安装的 {{ site.data.keys.mf_server }}   
{: #from-a-locally-installed-mobilefirst-server }
#### 桌面浏览器
{: #desktop-browser }
从您选择的浏览器，装入 URL [http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole)。用户名/密码为 *admin/admin*。

#### 命令行
{: #command-line }
从**命令行**窗口中使用已安装的 {{ site.data.keys.mf_cli }}    运行命令：`mfpdev server console`。

### 从远程安装的 {{ site.data.keys.mf_server }}   
{: #from-a-remotely-installed-mobilefirst-server }
#### 桌面浏览器
{: #desktop-browser-remote }
从您选择的浏览器，装入 URL `http://the-server-host:server-port-number/mfpconsole`。  
主机服务器可以是客户拥有的服务器、IBM Bluemix 服务或 IBM [Mobile Foundation](../../../bluemix/)。

#### 命令行
{: #command-line-remote }
从**命令行**窗口中使用已安装的 {{ site.data.keys.mf_cli }}   ， 

1. 添加远程服务器定义：

    *交互方式*  
    运行命令：`mfpdev server add` 并遵循屏幕上的指示信息进行操作。

    *直接方式*  
    通过以下结构运行命令：`mfpdev server add [server-name] --URL [remote-server-URL] --login [admin-username] --password [admin-password] --contextroot [admin-service-name]`。例如：

   ```bash
   mfpdev server add MyRemoteServer http://my-remote-host:9080/ --login TheAdmin --password ThePassword --contextroot mfpadmin
   ```

2. 运行命令：`mfpdev server console MyRemoteServer`。

> 通过[使用 CLI 来管理 {{ site.data.keys.product_adj }}    工件](../../../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts/)教程来了解有关各种 CLI 命令的更多信息。
## 浏览控制台
{: #navigating-the-console }
### 仪表板
{: #dashboard }
“仪表板”提供了已部署的项目概览。

![控制台仪表板图像](dashboard.png)

#### 操作下拉菜单
{: #actions-dropdown }
此下拉菜单提供了对各种控制台操作的快速访问功能。

![操作下拉菜单图像](actions-dropdown.png)

### 运行时设置
{: #runtime-settings }
编辑运行时属性、全局安全性变量、服务器密钥库和保密客户机。

![“运行时设置”屏幕图像](runtime-settings.png)

### 错误日志
{: #error-log }
“错误日志”可显示当前运行时环境中从 {{ site.data.keys.mf_console }}    或从命令行启动的失败管理操作列表。使用此日志可查看失败对服务器产生的影响。

> 有关更多信息，请参阅用户文档中有关针对运行时环境的操作的错误日志的主题。

![错误日志屏幕图像](error-log.png)

### 设备
{: #devices }
管理员可以搜索访问 {{ site.data.keys.mf_server }}    的设备，并管理访问权。  
可使用用户标识或使用友好名称来搜索设备。用户标识是用于登录的标识。  
友好名称是与设备关联的名称，用于将此设备与共享用户标识的其他设备加以区分。 

> 有关更多信息，请参阅用户文档中有关设备访问管理的主题。

![设备管理屏幕图像](devices.png)

### 应用程序
{: #applications }
#### 注册应用程序
{: #registering-applications }
提供基本应用程序值和下载起动器代码。 

![应用程序注册屏幕图像](register-applications.png)

#### 管理应用程序
{: #managing-applications }
通过使用[直接更新](../../../application-development/direct-update/)、远程禁用、[应用程序真实性](../../../authentication-and-security/application-authenticity/)和[设置安全性参数](../../../authentication-and-security/)来管理和配置已注册的应用程序。

![应用程序管理屏幕图像](application-management.png)

#### 认证和安全性
{: #authentication-and-security }
配置应用程序安全性参数（例如，缺省令牌到期日期值、将作用域元素映射到安全性检查、定义强制性应用程序作用域和配置安全性检查选项）。

> [了解](../../../authentication-and-security/)有关 {{ site.data.keys.product_adj }}    安全性框架的更多信息。

![应用程序安全配置屏幕图像](authentication-and-security.png)

#### 应用程序设置
{: #application-settings }
在控制台中配置应用程序的显示名称以及应用程序类型和许可。

![应用程序设置屏幕图像](application-settings.png)

#### 通知
{: #notifications }
设置[推送通知](../../../notifications/)和相关参数（例如，证书和 GCM 详细信息）、定义标记以及向设备发送通知。

![推送通知设置屏幕图像](push-notifications.png)

### 适配器
{: #adapters }
#### 创建适配器
{: #creating-adapters }
[注册适配器](../../../adapters/)并下载起动器代码，通过更新适配器属性来动态更新适配器，无需重新构建和重新部署适配器工件。

![适配器注册屏幕图像](create-adapter.png)

#### 适配器属性
{: #adapter-properties }
部署适配器后，可以在控制台中对其进行配置。

![适配器配置屏幕图像](adapter-configuration.png)

### 客户机日志
{: #client-logs }
管理员可以使用日志概要文件来针对操作系统、操作系统版本、应用程序、应用程序版本和设备模型的任意组合调整客户机记录器配置（例如，日志级别和日志包过滤器）。

当管理员创建配置概要文件时，日志配置将与 API 调用的响应（例如，`WLResourceRequest`）合并，并自动应用。

> 有关更多信息，请参阅用户文档中有关客户端日志捕获配置的主题。

![客户机日志屏幕图像](client-logs.png)

### 许可证跟踪
{: #license-tracking }
可从顶部“设置”按钮访问。

许可条款因使用的 {{ site.data.keys.product }}    版本（Enterprise 或 Consumer）而异。缺省情况下，已启用了许可证跟踪，该功能会跟踪与许可策略相关的度量值，如活动客户机设备数以及已安装的应用程序数。此信息帮助确定 {{ site.data.keys.product }}    的当前使用是否在许可证权利级别内，并可防止潜在的许可证违例。

通过跟踪客户机设备的使用并确定设备是否处于活动状态，管理员可以停用不应再访问服务的设备。例如，如果某个员工已离开公司，那么可能会出现此情况。

> 有关更多信息，请参阅用户文档中有关许可证跟踪的主题。

![客户机日志屏幕图像](license-tracking.png)

### 下载
{: #downloads }
对于因特网连接不可用的情况，可以从 {{ site.data.keys.mf_console }}    中的下载中心下载 {{ site.data.keys.product }}    的各种开发工件快照。

![可用工件图像](downloads.png)

