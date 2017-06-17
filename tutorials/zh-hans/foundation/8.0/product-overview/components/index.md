---
layout: tutorial
title: 产品组件
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
{{ site.data.keys.product_full }} 包含以下组件：{{ site.data.keys.mf_cli }}、{{ site.data.keys.mf_server }}、客户端运行时组件、{{ site.data.keys.mf_console }}、{{ site.data.keys.mf_app_center }} 和 {{ site.data.keys.mf_system_pattern }}。

下图显示 {{ site.data.keys.product }} 的组件：

![{{ site.data.keys.product }} 解决方案的体系结构](architecture.jpg)

### {{ site.data.keys.mf_cli }}
{: #mobilefirst-cli }
除了使用 IBM {{ site.data.keys.mf_console }} 之外，还可以使用 {{ site.data.keys.mf_cli_full }} 开发和管理应用程序。必须使用 CLI 完成 {{ site.data.keys.product_adj }} 开发流程的某些步骤。

所有以 **mfpdev** 开头的命令均支持以下类型的任务：

* 向 {{ site.data.keys.mf_server }} 注册应用程序
* 配置您的应用程序
* 创建、构建和部署适配器
* 预览和更新 Cordova 应用程序
* 有关更多信息，请参阅[使用 CLI 来管理 {{ site.data.keys.product_adj }} 工件](../../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts/)教程。

### {{ site.data.keys.mf_server }}
{: #mobilefirst-server }
{{ site.data.keys.mf_server }} 向 {{ site.data.keys.product_adj }} 应用程序提供安全的后端连接、应用程序管理、推送通知支持以及分析功能和监控。它不是 Java Platform Enterprise Edition (Java EE) 意义上的应用程序服务器。它充当 {{ site.data.keys.product }} 应用程序包的容器，实际上是 Web 应用程序的集合，可以选择打包为在传统应用程序服务器基础之上运行的 EAR（企业归档）文件。

{{ site.data.keys.mf_server }} 与企业环境相集成，并使用现有资源和基础结构。此集成基于作为服务器端软件组件的适配器，它们负责将后端企业系统信息及基于云的服务传送至用户设备。
您可以使用这些适配器通过信息源来检索并更新数据，允许用户执行事务并启动其他服务和应用程序。

[了解有关 {{ site.data.keys.mf_server }}](server) 的更多信息。

### 客户端运行时组件
{: #client-side-runtime-components }
{{ site.data.keys.product }} 提供将服务器功能嵌入在已部署应用程序的目标环境中的客户端运行时代码。这些运行时客户机 API 是集成到本地存储的应用程序代码中的库。您可以使用它们将 {{ site.data.keys.product_adj }} 功能添加到自己的客户机应用程序。可以使用 {{ site.data.keys.mf_dev_kit_full }} 安装 API 和库，也可以从您的开发平台的存储库中下载 API 和库。

### {{ site.data.keys.mf_console }}
{: #mobilefirst-operations-console }
{{ site.data.keys.mf_console }} 用于控制和管理移动应用程序。{{ site.data.keys.mf_console }} 还是了解 {{ site.data.keys.product }} 开发的入口点。
您可以从控制台下载代码示例、工具和 SDK。

可以使用
{{ site.data.keys.mf_console }} 来执行以下任务：

* 通过基于 Web 的集中式控制台监控和配置所有部署的应用程序、适配器和推送通知规则。
* 通过使用应用程序版本和设备类型的预配置规则，远程禁用连接到 {{ site.data.keys.mf_server }} 的能力。
* 定制在应用程序启动时发送给用户的消息。
* 收集来自所有运行中应用程序的用户统计信息。
* 生成与用户采用情况和用法有关的内置的、预先配置的报告（通过应用程序连接到服务器的用户的数量和频率）。
* 为特定于应用程序的事件配置数据收集规则。
* [了解有关 {{ site.data.keys.mf_console }}](console) 的更多信息。

### {{ site.data.keys.mf_analytics }}
{: #mobilefirst-analytics }
{{ site.data.keys.product }} 包含可通过 {{ site.data.keys.mf_console }} 访问的可扩展操作{{ site.data.keys.mf_analytics_short }}功能。{{ site.data.keys.mf_analytics_short }}功能支持企业在从设备、应用程序和服务器收集的日志和事件中搜索模式、问题和平台使用情况统计信息。

{{ site.data.keys.mf_analytics }}的数据包含以下源：

* iOS 和 Android 设备上应用程序的崩溃事件（本机代码和 JavaScript 错误的崩溃事件）。
* 任何应用程序到服务器活动的交互（{{ site.data.keys.mf_cli }} 客户机/服务器协议支持的任何内容，包括推送通知）。
* 传统 {{ site.data.keys.product_adj }} 日志文件中捕获的服务器端日志。

[了解有关{{ site.data.keys.mf_analytics }}](../../analytics)的更多信息。

### Application Center
{: #application-center }
利用 Application Center，您可以在单个移动应用程序存储库中共享组织内正在开发的移动应用程序。开发团队成员可以使用 Application Center 与团队成员共享应用程序。此过程促进应用程序开发中涉及的所有人员之间的协作。

贵公司通常可以如下所示使用 Application Center：

1. 开发团队创建一个应用程序版本。
2. 开发团队将该应用程序上载到 Application Center，输入其描述并请求扩展团队复审该应用程序并对其进行测试。
3. 当新版本的应用程序可用时，测试人员会运行 Application Center 安装程序（即移动式客户机）。然后，测试人员会找到此新版本的应用程序，将其安装到移动设备上并进行测试。
4. 测试后，测试人员会评定应用程序并提交反馈，开发人员可通过 Application Center 控制台来查看。

Application Center 的目的在于实现公司内部的专用，您可以将某些移动应用程序的目标指定为特定用户组。可将 Application Center 用作一个企业应用程序商店。

### {{ site.data.keys.mf_system_pattern }}
{: #mobilefirst-system-pattern }
通过 {{ site.data.keys.mf_system_pattern_full }}，您可以在 IBM PureApplication System 或 IBM PureApplication Service on SoftLayer 上部署 {{ site.data.keys.mf_server }}。通过这些模式，管理员和公司可以通过利用内部云技术快速响应业务环境中的更改。此方法简化了部署过程，提高了运作效率，可从容应对增长的移动需求。此需求加快了解决方案的迭代过程，超出了传统需求周期。使用 {{ site.data.keys.mf_server }} Pattern 还会授权访问最佳实践和内置专业知识，例如，内置扩展策略。

#### PureApplication System
{: #pureapplication-system }
IBM PureApplication System 是一个基于 IBM X-Architecture 的可高度扩展的集成系统，其在云环境中提供以应用程序为中心的计算模型。

以应用程序为中心的系统是管理复杂应用程序以及应用程序调用的任务和过程的有效方式。整个系统实施一个不同的虚拟计算环境，其中将针对不同的应用程序工作负载自动定制不同的资源配置。IBM PureApplication System 平台的应用程序管理功能可快速、简单且重复部署中间件和其他应用程序组件。

IBM PureApplication System 提供在集成系统中交付的虚拟工作负载和可扩展基础结构。

#### 虚拟系统模式
{: #virtual-system-patterns }
虚拟系统模式是针对一组部署需求的重现拓扑的逻辑表示。

虚拟系统模式支持有效且可重复的系统部署，包括一个或多个虚拟机实例，以及其上运行的应用程序。您可以完全自动化部署，而不需要执行多个耗时的手动任务。此类部署消除由于容易出错的手动配置过程导致的问题，尤其是在复杂的生产拓扑中（例如，服务器场），并且可加速解决方案部署。
