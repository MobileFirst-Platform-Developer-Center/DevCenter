---
layout: tutorial
title: 从较早发行版迁移
weight: 12
---
## 概述
{: #overview }
{{ site.data.keys.product_full }} V8.0 引入了应用程序开发和部署的新概念以及一些 API 更改。 了解有关这些更改的信息以准备和计划迁移 MobileFirst 应用程序。

> [查看迁移手册](migration-cookbook)以快速开始迁移过程。

> 使用此[实验室]({{site.baseurl}}/labs/developers/8.0/advancedwallet/)指导您进行 V7.1 到 V8.0 迁移。

#### 跳至：
{: #jump-to }
* [为何要迁移至 {{ site.data.keys.product_full }} 8.0](#why-migrate-to-ibm-mobilefirst-foundation-80)
* [开发和部署过程中的更改](#changes-in-the-development-and-deployment-process)
* [迁移 Cordova 或混合应用程序](#migrating-a-cordova-or-hybrid-application)
* [迁移本机应用程序](#migrating-a-native-application)
* [迁移适配器和安全性](#migrating-adapters-and-security)
* [迁移推送通知支持](#migrating-push-notifications-support)
* [服务器数据库和服务器结构中的更改](#changes-in-the-server-databases-and-in-the-server-structure)
* [在 Cloudant 中存储移动数据](#storing-mobile-data-in-cloudant)
* [将修订包应用到 {{ site.data.keys.mf_server }}](#applying-a-fix-pack-to-mobilefirst-server)

## 为何要迁移至 IBM MobileFirst Foundation 8.0
{: #why-migrate-to-ibm-mobilefirst-foundation-80}

### 减少构建应用程序所需的工作、技能和时间
* 利用标准软件包管理器（npm、CocoaPods、Gradle、NuGet）和 Maven for Java Adapter 构建自动化功能，更快速、更方便、更智慧地构建应用程序
* 新增了更简单、更易于插入的模块化 MobileFirst SDK
* 新增并改善了整体用户体验，包括参与用户的下一个最佳行动，在注册、配置和部署应用程序的整个过程中提供指导帮助

### 增强了自动化功能，新增了开发服务和 IT 自助服务
* 新增了实时更新功能，可外部化和动态更改应用程序可配置信息（推送通知、认证、适配器、应用程序行为和工作流程）
* 完全重新设计，极大简化了注册、部署和管理应用程序等方面的控制台用户体验
* 建立了更简单的新应用程序体系结构，消除了开发和 IT 职能之间的相互依赖性
* 利用全新的崩溃分析、可配置警报和根本原因分析，改善了问题确定过程
* 改善了推送通知服务，支持通过 Web 控制台有针对性发送基于预订的通知

### 更多混合云部署选项
* IBM Cloud Public 上 MobileFirst Foundation 开发、测试和完全可扩展生产环境实现单击式配置
* 与 IBM DevOps Services 和 Urban Code 集成，构建部署管道

### 多渠道 API 创建和管理
* 利用特定于移动的安全扩展（例如，Step Up、Multifactor），加强 API Connect 多渠道安全性，提供最大程度的保护措施，然后使用 IBM DataPower 在 DMZ 中实施安全性
* 在 Foundation V8 中创建并定义与 API Connect 兼容的 Swagger REST API，然后在 API Connect 中管理这些 API，保护它们的安全

## 开发和部署过程中的更改
{: #changes-in-the-development-and-deployment-process }
> 有关使用 {{ site.data.keys.product }} V8.0.0 执行开发过程的速成实际经验，可查看[快速入门教程](../quick-start)。



在此版本的产品中，不再创建需要安装在运行 {{ site.data.keys.mf_server }} 的应用程序服务器中的项目 WAR 文件即可上载您的应用程序。 而是安装一次 {{ site.data.keys.mf_server }}，然后将应用程序、资源安全性或推送服务的服务器端**配置**上载到服务器。 您可以使用 {{ site.data.keys.mf_console }} 修改应用程序的配置。 也可以使用命令行工具或服务器 REST API 上载应用程序的新**配置文件**。

MobileFirst 项目不再存在。 相反，您使用所选的开发环境来开发移动应用程序。 分别采用 Java™ 或 JavaScript 开发应用程序的服务器端。 您可以使用 Apache Maven 或支持 Maven 的 IDE（如 Eclipse 和 IntelliJ 等）开发适配器。

在先前版本中，通过上载 .wlapp 文件将应用程序部署到服务器。 该文件包含用于描述应用程序的数据以及（如果是混合应用程序）Web 资源。 在 V8.0 中，.wlapp 文件替换为用于向服务器注册应用程序的应用程序描述符 JSON 文件。 对于使用“直接更新”的 Cordova 应用程序，现在将 Web 资源归档上载到服务器，而不是上载 .wlapp 的新版本。

开发应用程序时，{{ site.data.keys.mf_cli }} 用于许多任务，例如将应用程序注册到其目标服务器或上载其服务器端配置。

### 停用的功能部件和替换路径
{: #discontinued-features-and-replacement-path}
与先前版本相比，{{ site.data.keys.product }} V8.0.0 从根本上进行了简化。 由于这种简化，V8.0 中已停用了 V7.1 中提供的某些功能。

> 有关已停用的功能部件和替换路径的更多信息，请参阅 [V8.0 中停用的功能部件和 V8.0 中不包含的功能部件](../product-overview/release-notes/deprecated-discontinued)。

## 迁移 Cordova 或混合应用程序
{: #migrating-a-cordova-or-hybrid-application }
您可以使用 Apache Cordova 命令行工具或支持 Cordova 的 IDE（如 Visual Studio Code、Eclipse、IntelliJ 等）开始开发 Cordova 应用程序。

通过将 {{ site.data.keys.product_adj }} 插件添加到应用程序来添加对 {{ site.data.keys.product_adj }} 功能部件的支持。有关 V7.1 Cordova 或混合应用程序与 V8.0 Cordova 应用程序的差异的更多信息，请参阅[使用 V8.0 开发的 Cordova 应用程序与使用 V7.1 及更低版本开发的 Cordova 应用程序的比较](migrating-client-applications/cordova/#comparison-of-cordova-apps-developed-with-v-80-versus-v-71-and-before)。

要迁移 Cordova 或混合应用程序，您需要

* 要用于规划目的，请在现有项目上运行迁移辅助工具。 查看生成的报告并评估迁移操作所需的工作量。 有关更多信息，请参阅[使用迁移辅助工具启动 Cordova 应用程序迁移](migrating-client-applications/cordova/#starting-the-cordova-app-migration-with-the-migration-assistance-tool)。
* 替换 V8.0.0 中停用或不包含的客户端 API。 有关 API 更改的列表，请参阅[升级 WebView](migrating-client-applications/cordova/#upgrading-the-webview)。
* 修改对使用经典安全模型的客户机资源的调用。 例如，使用 `WLResourceRequest` API 来代替不推荐使用的 `WL.Client.invokeProcedure`。
* 如果使用“直接更新”，请查看[迁移“直接更新”](migrating-client-applications/cordova/#migrating-direct-update)。
* 有关迁移 Cordova 或混合应用程序的更多信息，请参阅[迁移现有 Cordova 和混合应用程序](migrating-client-applications/cordova)。

> **注：**迁移推送通知支持需要更改客户端和服务器端，稍后会在“迁移推送通知支持”中对此进行描述。

## 迁移本机应用程序
{: #migrating-a-native-application }
要迁移本机应用程序，需要遵循以下步骤：

* 要用于规划目的，请在现有项目上运行迁移辅助工具。 查看生成的报告并评估迁移操作所需的工作量。
* 更新您的项目以使用 {{ site.data.keys.product }} V8.0 中的 SDK
* 替换 V8.0 中停用或不包含的客户端 API。 迁移辅助工具可扫描您的代码并生成要替换的 API 的报告。
* 修改对使用经典安全模型的客户机资源的调用。 例如，使用 `WLResourceRequest` API 来代替不推荐使用的 `invokeProcedure`。
    * 有关迁移本机 iOS 应用程序的更多信息，请参阅[迁移现有的本机 iOS 应用程序](migrating-client-applications/ios)。
    * 有关迁移本机 Android 应用程序的更多信息，请参阅[迁移现有的本机 Android 应用程序](migrating-client-applications/android)。
    * 有关迁移本机 Windows 应用程序的更多信息，请参阅[迁移现有的本机 Windows 应用程序](migrating-client-applications/windows)。

> **注：**迁移推送通知支持需要更改客户端和服务器端，稍后会在[迁移推送通知支持](#migrating-push-notifications-support)中对此进行描述。

## 迁移适配器和安全性
{: #migrating-adapters-and-security }
从 V8.0 开始，适配器是 Maven 项目。 {{ site.data.keys.product_adj }} 安全框架基于 OAuth、安全作用域和安全性检查。 安全作用域定义访问资源的安全性需求。 安全性检查定义如何验证安全性需求。 安全性检查编写为 Java 适配器。 有关适配器和安全性的实际经验，请参阅[创建 Java 和 JavaScript 适配器](../adapters/creating-adapters)以及[授权概念](../authentication-and-security)教程。

{{ site.data.keys.mf_server }} 仅以独立于会话的方式运行，适配器不应该将状态存储到 Java 虚拟机 (JVM) 本地。

可以将适配器的属性外部化，从而针对适配器运行的上下文（例如，测试服务器或生产服务器）配置适配器。 但是，这些属性的值不再包含在项目 WAR 文件的属性文件中。 而是从 {{ site.data.keys.mf_console }} 或通过使用命令行工具或服务器 REST API 来进行定义。

* 有关迁移适配器的更多信息，请参阅[迁移现有适配器](migrating-adapters)以在 {{ site.data.keys.mf_server }} V8.0 下工作。
* 有关服务器端 API 更改的更多信息，请参阅 V8.0 中的[服务器端 API](../product-overview/release-notes/deprecated-discontinued/#server-side-api-changes) 更改。
* 有关用于开发适配器的 Apache Maven 的简介，请参阅[作为 Apache Maven 项目的适配器](../adapters)。
* 有关迁移认证和安全性的更多信息，请参阅[迁移认证和安全性](migrating-security)到 {{ site.data.keys.product_adj }} V8.0。

## 迁移推送通知支持
{: #migrating-push-notifications-support }
不再支持基于事件源的模型。 改为使用基于标记的通知。 要了解有关迁移客户机应用程序和服务器端组件的推送通知的更多信息，请参阅从基于事件源的通知[迁移推送通知](migrating-push-notifications)和[迁移方案](migrating-push-notifications/#migration-scenarios)。

从 V8.0 开始，在服务器端配置推送服务。 推送证书存储在服务器上。 您可以从 {{ site.data.keys.mf_console }} 进行设置，或通过使用命令行工具或推送服务 REST API 自动上载证书。 您也可以从
{{ site.data.keys.mf_console }} 发送推送通知。

推送服务受 OAuth 安全模型的保护。 必须将使用推送服务 REST API 的服务器端组件配置为 {{ site.data.keys.mf_server }} 的机密客户机。

### 推送通知数据迁移工具
{: #push-notifications-data-migration-tool }
此外还提供了推送通知数据迁移工具。 此迁移工具可帮助将 MobileFirst Platform Foundation 7.1 推送数据（设备、用户预订、凭证和标记）迁移到 {{ site.data.keys.product }} 8.0。

> [了解有关迁移工具的更多信息](migrating-push-notifications/#migration-tool)。

## 服务器数据库和服务器结构中的更改
{: #changes-in-the-server-databases-and-in-the-server-structure }
{{ site.data.keys.mf_server }} 支持在不更改代码、重建应用程序或重新部署的情况下更改应用程序安全性、连接和推送。 但这些更改暗含对以下项目的更改：数据库模式、数据库中存储的数据以及安装流程。

由于这些更改，{{ site.data.keys.product }} 不包含用于将数据库从较早版本迁移到 V8.0.0 或升级现有服务器安装的自动化脚本。 要将应用程序的新版本移到 V8.0.0，请安装可以与先前服务器并排运行的新服务器。 然后，将应用程序和适配器升级到 V8.0.0 并将其部署到新服务器。

## 在 Cloudant 中存储移动数据
{: #storing-mobile-data-in-cloudant }
不再支持使用 IMFData 框架或 CloudantToolkit 在 Cloudant 中存储移动数据。 有关备用 API 的信息，请参阅[使用 IMFData 或 Cloudant SDK 迁移在 Cloudant 中存储移动数据的应用程序](migrating-data)。

## 将修订包应用到 {{ site.data.keys.mf_server }}
{: #applying-a-fix-pack-to-mobilefirst-server }
了解如何使用 Server Configuration Tool 将 {{ site.data.keys.mf_server }} V8.0.0 升级到修订包或临时修订。 或者，如果使用 Ant 任务安装了 {{ site.data.keys.mf_server }}，那还可使用 Ant 任务应用修订包或临时修订。

要对 {{ site.data.keys.mf_server }} 应用临时修订或修订包，请根据初始安装方法选择以下其中一个主题：

* [使用 Server Configuration Tool 来应用修订包或临时修订](../installation-configuration/production/appserver/#applying-a-fix-pack-by-using-the-server-configuration-tool)
* [使用 Ant 文件应用修订包](../installation-configuration/production/appserver/#applying-a-fix-pack-by-using-the-ant-files)
