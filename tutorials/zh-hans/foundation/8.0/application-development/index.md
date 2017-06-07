---
layout: tutorial
title: 开发应用程序
show_children: true
weight: 5
---
<!-- NLS_CHARSET=UTF-8 -->
## 开发概念和概述
{: #development-concepts-and-overview }
在使用 {{ site.data.keys.product_full }} 工具集开发应用程序时，必须开发或配置各种组件和元素。了解开发应用程序时所涉及的组件和元素可帮助顺利进行开发。

除了熟悉这些概念，您还需要了解 {{ site.data.keys.product_adj }} 针对 Native、Cordova 和 Web 应用程序提供的 API，例如，JSONStore 和 WLResourceReuest，以及了解如何调试应用程序、使用直接更新来刷新 Web 资源、实时更新以细分用户群以及如何使用 {{ site.data.keys.mf_cli }} 来处理应用程序、适配器和其他工件。

您可以从侧边栏浏览至相关主题，或者继续阅读以了解有关各个 {{ site.data.keys.product_adj }} 组件的更多信息。

#### 跳转至
{: #jump-to }
* [应用程序](#applications)
* [{{ site.data.keys.mf_server }}](#mobilefirst-server)
* [适配器](#adapters)
* [要关注的客户机端教程](#client-side-tutorials-to-follow)

### 应用程序
{: #applications }
应用程序是针对目标 {{ site.data.keys.mf_server }} 构建的，并且在目标服务器上具有服务器端配置。您必须在 {{ site.data.keys.mf_server }} 上注册应用程序，然后才能进行配置。

以下元素标识应用程序：

* 应用程序标识
* 版本号
* 目标部署平台

> **注：**版本号不适用于 Web 应用程序。您无法拥有相同 Web 应用程序的多个版本。
这些标识用于客户机端和服务器端，以确保正确部署应用程序并且仅使用分配给它们的资源。{{ site.data.keys.product }} 的不同部件以不同方式使用这些标识的各种组合。

应用程序标识取决于目标部署平台：

**Android**  
标识是应用程序包名称。

**iOS**  
标识是应用程序捆绑软件标识。

**Windows**  
标识是应用程序组装名称。

**Web**  
标识是开发人员指定的唯一标识。

如果针对不同目标平台的应用程序全都具有相同应用程序标识，那么 {{ site.data.keys.mf_server }} 会将所有这些应用程序视为具有不同平台实例的相同应用程序。例如，以下应用程序被视为*相同应用程序*的不同平台实例：

* 捆绑软件标识为 `com.mydomain.mfp` 的 iOS 应用程序。
* 软件包名为 `com.mydomain.mfp` 的 Android 应用程序。
* 组合件名称为 `com.mydomain.mfp` 的 Windows 10 Universal Windows Platform 应用程序。
* 具有指定标识 `com.mydomain.mfp` 的 Web 应用程序。

应用程序的目标部署平台与应用程序是作为本机应用程序还是 Cordova 应用程序进行开发无关。例如，以下应用程序在 {{ site.data.keys.product }} 中都视为 iOS 应用程序：

* 使用 Xcode 和本机代码开发的 iOS 应用程序
* 使用 Cordova 跨平台开发技术开发的 iOS 应用程序

> **注：**使用 Xcode 8 的情况下，在 iOS 模拟器中运行 iOS 应用程序时**密钥链共享**功能是必需的。您需要手动启用此功能，然后才能构建 Xcode 项目。
### 应用程序配置
{: #application-configuration }
正如所述，在客户机端和服务器端配置应用程序。  

对于本机和 Cordova iOS、Android 及 Windows 应用程序，客户机配置存储在客户机属性文件（对于 iOS 为 **mfpclient.plist**，对于 Android 为 **mfpclient.properties**，或者对于 Windows 为 **mfpclient.resw**）中。对于 Web 应用程序，会将配置属性作为参数传递到 SDK [初始化方法](../application-development/sdk/web)中。

客户机配置属性包括应用程序标识和信息，例如，{{ site.data.keys.mf_server }} 运行时的 URL 和访问服务器所需的安全密钥。  
应用程序的服务器配置包括诸如应用程序管理状态、直接更新的 Web 资源、配置的安全范围和日志配置等信息。

> 在[添加 {{ site.data.keys.product }} SDK 教程](sdk)中了解如何添加 {{ site.data.keys.product_adj }} 客户机 SDK。
在构建应用程序之前，必须定义客户机配置。客户机应用程序配置属性必须匹配在 {{ site.data.keys.mf_server }} 运行时中针对此应用程序定义的属性。例如，客户机配置中的安全密钥必须匹配服务器上的密钥。对于非 Web 应用程序，您可以使用 {{ site.data.keys.mf_cli }} 更改客户机配置。

应用程序的服务器配置绑定到应用程序标识、版本号和目标平台组合。您必须将应用程序注册到 {{ site.data.keys.mf_server }} 运行时，然后才能添加应用程序的服务器端配置。配置应用程序的服务器端通常是通过 {{ site.data.keys.mf_console }} 完成的。您还可以通过以下方法配置应用程序的服务器端：

* 使用 `mfpdev app pull` 命令从服务器抓取现有 JSON 配置文件，更新文件，并使用 `mfpdev app push` 命令上载更改的配置。
* 使用 **mfpadm** 程序或 Ant 任务。有关使用 mfpadm 的信息，请参阅[通过命令行管理 {{ site.data.keys.product_adj }} 应用程序](../administering-apps/using-cli)和[通过 Ant 管理 {{ site.data.keys.product_adj }} 应用程序](../administering-apps/using-ant)。
* 使用 {{ site.data.keys.product_adj }} 管理服务的 REST API。有关 REST API 的信息，请参阅 [REST API for the {{ site.data.keys.mf_server }} administration service](../api/rest/administration-service/)。

您还可以使用这些方法来自动配置 {{ site.data.keys.mf_server }}。

> **请记住：**您可以修改服务器配置，甚至是在 {{ site.data.keys.mf_server }} 正在运行和接收来自应用程序的流量时。您无需停止服务器以更改应用程序的服务器配置。
在生产服务器上，应用程序版本通常对应于发布到应用商店的应用程序的版本。某些服务器配置元素（例如，应用程序真实性配置）对于发布到商店的应用程序是唯一的。

## {{ site.data.keys.mf_server }}
{: #mobilefirst-server }
移动应用程序的服务器端是 {{ site.data.keys.mf_server }}。{{ site.data.keys.mf_server }} 为您提供应用程序管理和应用程序安全性等功能的访问权，并通过适配器为您提供其他后端系统的移动应用程序安全访问权。

{{ site.data.keys.mf_server }} 是交付多个 {{ site.data.keys.product }} 功能的核心组件，包括以下功能：

* 应用程序管理
* 应用程序安全性，包括认证设备和用户以及验证应用程序真实性
* 通过适配器对后端服务的安全访问
* 使用直接更新来更新 Cordova 应用程序 Web 资源
* 推送通知和推送订阅
* 应用程序分析

您需要在从开发和测试一直到生产部署和维护的整个应用程序生命周期中使用 {{ site.data.keys.mf_server }}。  

> 提供预先配置的服务器以供在开发应用程序时使用。有关要在开发应用程序时使用的 {{ site.data.keys.mf_server }} 的信息，请参阅[设置 {{ site.data.keys.product_adj }} 开发环境](../installation-configuration/development)。
{{ site.data.keys.mf_server }} 由以下组件组成。所有这些组件也包含在 {{ site.data.keys.mf_server }} 中。在简单情况下，它们全都在相同的应用程序服务器上运行，但是在生产或测试环境中，组件可能在不同的应用程序服务器上运行。有关这些 {{ site.data.keys.mf_server }} 组件的可能拓扑的信息，请参阅[拓扑和网络流](../installation-configuration/production/topologies)。

### {{ site.data.keys.product_adj }} 和 {{ site.data.keys.mf_server }} 管理服务
{: #mobilefirst-and-the-mobilefirst-server-administration-service }
操作控制台是一个 Web 界面，可用来查看和编辑 {{ site.data.keys.mf_server }} 配置。也可以从此处访问 {{ site.data.keys.mf_analytics_console }}。开发服务器中操作控制台的上下文根为 **/mfpconsole**。

管理服务是管理应用程序的主入口点。您可以使用 {{ site.data.keys.mf_console }} 通过基于 Web 的界面来访问管理服务。您还可以使用 **mfpadm** 命令行工具或管理服务 REST API 来访问管理服务。

> 了解有关 [{{ site.data.keys.mf_console }} 功能](../product-overview/components/console)的更多信息。

### {{ site.data.keys.product_adj }} 运行时
{: #mobilefirst-runtime }
运行时是 {{ site.data.keys.product_adj }} 客户机应用程序的主入口点。运行时也是 {{ site.data.keys.product }} OAuth 实施的缺省授权服务器。

在高级以及罕见情况下，可能在单个 {{ site.data.keys.mf_server }} 中有一个设备运行时的多个实例。每个实例都有其自己的上下文根。上下文根用于显示操作控制台中运行时的名称。在需要不同服务器级别配置的情况下使用多个实例，例如，密钥库的密钥。

如果 {{ site.data.keys.mf_server }} 中只有一个设备运行时实例，那么通常不需要了解运行时上下文根。例如，如果在 {{ site.data.keys.mf_server }} 只有一个运行时的情况下使用 `mfpdev app register` 命令将应用程序注册到运行时，也会自动将应用程序注册到此运行时。

### {{ site.data.keys.mf_server }} 推送服务
{: #mobilefirst-server-push-service }
推送服务是与推送相关的操作的主访问点，例如，推送通知和推送订阅。为联系推送服务，客户机应用程序使用运行时的 URL，但是将上下文根替换为 /mfppush。您可以使用 {{ site.data.keys.mf_console }} 或推送服务 REST API 来配置和管理推送服务。

如果通过 {{ site.data.keys.product_adj }} 运行时在单独的应用程序服务器中运行推送服务，那么必须将推送服务流量路由到包含 HTTP Server 的正确应用程序服务器。

### {{ site.data.keys.mf_analytics }} 和 {{ site.data.keys.mf_analytics_console }}
{: #mobilefirst-analytics-and-the-mobilefirst-analytics-console }
{{ site.data.keys.mf_analytics_full }} 是一个可选组件，其提供可从 {{ site.data.keys.mf_console }} 访问的可扩展分析功能。此分析功能使您能够通过从设备、应用程序和服务器收集的日志和事件搜索模式、问题和平台使用情况统计信息。

通过 {{ site.data.keys.mf_console }}，您可以定义过滤器以启用或禁用到分析服务的数据转发。您还可以过滤所发送信息的类型。在客户机端，您可以使用客户端日志捕获 API 以将事件和数据发送到分析服务器。

在将 {{ site.data.keys.mf_server }} 安装到想要的拓扑并进行配置后，可通过以下任一方法全部完成 {{ site.data.keys.mf_server }} 及其应用程序的任何进一步配置：

* {{ site.data.keys.mf_console }}
* {{ site.data.keys.mf_server }} 管理服务 REST API
* **mfpadm** 命令行工具

在初始安装和配置后，您无需访问任何应用程序服务器控制台或界面即可配置 {{ site.data.keys.product }}。  
在将应用程序部署至生产时，可以将应用程序部署到以下 {{ site.data.keys.mf_server }} 生产环境：

#### 本地
{: #on-premises }
> 有关针对本地环境安装和配置 {{ site.data.keys.mf_server }} 的信息，请参阅[安装 IBM {{ site.data.keys.mf_server }}](../installation-configuration/production/appserver)。
#### 在云上
{: #on-the-cloud }
* [在 IBM Bluemix 上使用 {{ site.data.keys.mf_server }}](../bluemix)。
* [在 IBM PureApplication 上使用 {{ site.data.keys.mf_server }}](../installation-configuration/production/pure-application)。

## 适配器
{: #adapters }
{{ site.data.keys.product }} 中的适配器安全地将后端系统连接到客户机应用程序和云服务。  

您可以通过 JavaScript 或 Java 编写适配器，并且可将适配器构建和部署为 Maven 项目。  
适配器将部署到 {{ site.data.keys.mf_server }} 中的 {{ site.data.keys.product_adj }} 运行时。

在生产系统中，适配器通常在应用程序服务器集群中运行。作为 REST 服务实施适配器而不使用会话信息，并且本地存储在服务器上以确保适配器在集群环境中正常工作。

适配器可具有用户定义的属性。可在服务器端配置这些属性而无需重新部署适配器。例如，在从测试移至生产时，您可以更改适配器用于访问资源的 URL。

您可以使用 mfpdev adapter deploy 命令通过 {{ site.data.keys.mf_console }} 或者直接从 Maven 将适配器部署到 {{ site.data.keys.product_adj }} 运行时。

> 了解有关适配器以及如何在[适配器类别](../adapters)中开发 JavaScript 和 Java 适配器的更多信息。

## 要关注的客户机端教程
{: #client-side-tutorials-to-follow }
