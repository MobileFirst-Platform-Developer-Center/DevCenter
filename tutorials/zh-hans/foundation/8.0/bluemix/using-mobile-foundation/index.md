---
layout: tutorial
title: 在 Bluemix 服务上使用 Mobile Foundation
breadcrumb_title: Mobile Foundation 服务
relevantTo: [ios,android,windows,javascript]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
本教程提供了使用 {{ site.data.keys.mf_bm_full }} (**{{ site.data.keys.mf_bm_short }}**) 服务在 Bluemix 上设置 {{ site.data.keys.mf_server }} 实例的分步指示信息。  
{{ site.data.keys.mf_bm_short }} 是一项 Bluemix 服务，支持快速轻松在 **Liberty for Java 运行时**上启动 MobileFirst Foundation v8.0 的开发环境或生产环境。

{{ site.data.keys.mf_bm_short }} 服务提供了以下计划选项：

1. **Developer**：此计划在 Liberty for Java 运行时上提供 {{ site.data.keys.mf_server }} 作为 Cloud Foundry 应用程序。 此计划不支持使用外部数据库或定义多个节点*，并且仅限于开发和测试*。 服务器实例支持您注册任意数量的移动应用程序用于开发和测试。在此计划中，缺省情况下会添加 {{ site.data.keys.mf_analytics_service }} 服务。

    > **注：**“Developer”计划不提供持续性数据库，因此请务必备份配置，如[“故障诊断”部分中](#troubleshooting)所述。

2. **Developer Pro**：此计划在 Liberty for Java 运行时上提供 {{ site.data.keys.mf_server }} 作为 Cloud Foundry 应用程序，并且允许用户开发和测试任意数量的移动应用程序。 此计划要求您具有 **dashDB OLTP 服务**。 dashDB 服务单独创建和计费。 此计划大小受限，并且旨在用于基于团队的开发和测试活动，不可用于生产活动。 费用取决于环境的总规模。 （可选）您可以通过单击**添加分析**按钮来添加 {{ site.data.keys.mf_analytics_service }} 服务。

3. **Professional Per Capacity：**此计划允许用户在生产环境中构建、测试和运行任意数量的移动应用程序，不限制移动用户或设备数量。 它支持大型部署和高可用性。 此计划要求您具有 **dashDB OLTP 服务**。 dashDB 服务单独创建和计费。 费用取决于环境的总规模。 （可选）您可以通过单击**添加分析**按钮来添加 {{ site.data.keys.mf_analytics_service }} 服务。

4. **Professional 1 Application**：此计划在 Liberty for Java 运行时上的可扩展 Cloud Foundry 应用程序中提供 {{ site.data.keys.mf_server }}。 此计划也需要 dashDB 数据库服务，此服务单独创建并计费。 此计划允许用户构建和管理单个移动应用程序。 单个移动应用程序可包含多种类型，例如，iOS、Android、Windows 和 Mobile Web。 （可选）您可以通过单击**添加分析**按钮来添加 {{ site.data.keys.mf_analytics_service }} 服务。

> [请参阅 Bluemix.net 上的服务页面](https://console.ng.bluemix.net/catalog/services/mobile-foundation/)以获取有关可用计划及其计费方式的更多信息。

#### 跳转至：
{: #jump-to}
* [设置 {{ site.data.keys.mf_bm_short }} 服务](#setting-up-the-mobile-foundation-service)
* [使用 {{ site.data.keys.mf_bm_short }} 服务](#using-the-mobile-foundation-service)
* [服务器配置](#server-configuration)
* [高级服务器配置](#advanced-server-configuration)
* [添加分析支持](#adding-analytics-support)
* [除去分析支持](#removing-analytics-support)
* [从使用 IBM Containers 部署的分析切换到分析服务](#switching-from-analytics-container-to-analytics-service)
* [应用 {{ site.data.keys.mf_server }} 修订](#applying-mobilefirst-server-fixes)
* [访问服务器日志](#accessing-server-logs)
* [故障诊断](#troubleshooting)
* [补充阅读](#further-reading)

## 设置 {{ site.data.keys.mf_bm_short }} 服务
{: #setting-up-the-mobile-foundation-service }
要设置可用计划，请首先遵循以下步骤进行操作：

1. 访问 [bluemix.net](http://bluemix.net)、登录，并单击**目录**。
2. 搜索 **Mobile Foundation** 并单击生成的选项。
3. *可选*。 输入服务实例的定制名称，或者使用提供的缺省名称。
4. 选择期望的定价计划，然后单击**创建**。

    <img class="gifplayer" alt="创建 {{ site.data.keys.mf_bm_short }} 服务实例" src="service-creation.png"/>

### 设置 *developer* 计划
{: #setting-up-the-developer-plan }

创建 {{ site.data.keys.mf_bm_short }} 服务会创建 {{ site.data.keys.mf_server }}。
  * 您可以立即访问和使用 {{ site.data.keys.mf_server }}。
  * 要使用 CLI 访问 {{ site.data.keys.mf_server }}，您将需要凭证，单击 Bluemix 控制台左侧导航面板中提供的**服务凭证**时可获取这些凭证。

  ![{{ site.data.keys.mf_bm_short }} 的图像](overview-page-new.png)

### 设置 *Developer Pro*、*Professional Per Capacity* 和 *Professional 1 Application* 计划
{: #setting-up-the-developer-pro-professional-percapacity-and-professional-1-application-plans }
1. 这些计划需要外部 [dashDB 事务数据库实例](https://console.ng.bluemix.net/catalog/services/dashdb/)。

    > 了解有关[设置 dashDB 数据库实例]({{site.baseurl}}/blog/2016/11/02/using-dashdb-service-with-mobile-foundation/)的更多信息。

    如果您有现有的 dashDB 服务实例（DashDB Enterprise Transactional 2.8.500 或 Enterprise Transactional 12.128.1400），请选择**使用现有服务**选项，并提供您的凭证：

    ![{{ site.data.keys.mf_bm_short }} 设置图像](create-dashdb-instance-existing.png)

    1.b. 如果当前没有 dashDB 服务实例，请选择**创建新服务**选项并遵循屏幕上的指示信息进行操作：

    ![{{ site.data.keys.mf_bm_short }} 设置图像](create-dashdb-instance-new.png)

2. 启动 {{ site.data.keys.mf_server }}。
    - 您可以保留服务器配置的基本级别，并单击**启动基本服务器**，或者
    - 在[“设置”选项卡](#advanced-server-configuration)中更新服务器配置，并单击**启动高级服务器**。

    在此步骤中，会针对 {{ site.data.keys.mf_bm_short }} 服务生成 Cloud Foundry 应用程序，并初始化 MobileFirst Foundation 环境。 此步骤可能需要 5 到 10 分钟才能完成。

3. 实例就绪后，您可以[使用服务](#using-the-mobile-foundation-service)。

    ![{{ site.data.keys.mf_bm_short }} 设置图像](overview-page.png)

## 使用 {{ site.data.keys.mf_bm_short }} 服务
{: #using-the-mobile-foundation-service }

{{ site.data.keys.mf_server }} 运行后，会显示以下仪表板：

![{{ site.data.keys.mf_bm_short }} 设置图像](service-dashboard.png)

单击**添加分析**以将 {{ site.data.keys.mf_analytics_service }} 支持添加到服务器实例中。
在[添加分析支持](#adding-analytics-support)部分中了解更多信息。

单击**启动控制台**以打开 {{ site.data.keys.mf_console }}。 缺省用户名为“admin”，可通过单击“眼睛”图标来显示密码。

![{{ site.data.keys.mf_bm_short }} 设置图像](dashboard.png)

### 服务器配置
{: #server-configuration }
基本服务器实例包括：

* 单个节点（服务器大小：“小”）
* 1GB 内存
* 2GB 存储容量

### 高级服务器配置
{: #advanced-server-configuration }
通过**设置**选项卡，可以通过添加以下内容来进一步定制服务器实例

* 不同的节点、内存和存储组合
* {{ site.data.keys.mf_console }} 管理密码
* LTPA 密钥
* JNDI 配置
* 用户注册表
* 信任库
* {{ site.data.keys.mf_analytics_service }} 配置
* DashDB Enterprise Transactional 2.8.500 或 Enterprise Transactional 12.128.1400 数据库的选择（可在 *Professional 1 Application* 计划中获取）
* VPN

![{{ site.data.keys.mf_bm_short }} 设置图像](advanced-server-configuration.png)

## 添加 {{ site.data.keys.mf_analytics_service }} 支持
{: #adding-analytics-support }
您可以通过单击服务的“仪表板”页面中的**添加分析**将 {{ site.data.keys.mf_analytics_service }} 支持添加到自己的 {{ site.data.keys.mf_bm_short }} 服务实例中。 此操作会提供 {{ site.data.keys.mf_analytics_service }} 服务实例。

>创建或重新创建 {{ site.data.keys.mf_bm_short }} 服务的 **Developer** 计划实例时，缺省情况下会添加 {{ site.data.keys.mf_analytics_service }} 服务实例。
<!--* When using the **Developer** plan this action will also automatically hook the {{ site.data.keys.mf_analytics_service }} service instance to your {{ site.data.keys.mf_server }} instance.  
* When using the **Developer Pro**, **Professional Per Capacity** or **Professional 1 Application** plans, this action will require additional input from you to select: amount of available Nodes, available Memory and a storage volume. -->

操作完成后，请在浏览器中重新装入 {{ site.data.keys.mf_console }} 页面以访问 {{ site.data.keys.mf_analytics_service_console }}。  

> 在 [{{ site.data.keys.mf_analytics_service }}类别](../../analytics)中了解有关 {{ site.data.keys.mf_analytics_service }} 的更多信息。

##  除去 {{ site.data.keys.mf_analytics_service }} 支持
{: #removing-analytics-support}

您可以通过单击服务的“仪表板”页面上的**删除分析**来除去针对 {{ site.data.keys.mf_bm_short }} 服务实例的 {{ site.data.keys.mf_analytics_service }} 支持。此操作会删除 {{ site.data.keys.mf_analytics_service }} 服务实例。

此操作完成后，请在浏览器中重新装入 {{ site.data.keys.mf_console }} 页面。

##  从使用 IBM Containers 部署的分析切换到分析服务
{: #switching-from-analytics-container-to-analytics-service}

>**注**：删除 {{ site.data.keys.mf_analytics_service }} 将除去所有可用分析数据。此数据在新的 {{ site.data.keys.mf_analytics_service }} 实例中将不可用。
用户可以通过单击服务仪表板中的**删除分析**按钮来删除当前容器。这将除去分析实例，并启用**添加分析**按钮，用户可单击此按钮以添加新的 {{ site.data.keys.mf_analytics_service }} 服务实例。

## 应用 {{ site.data.keys.mf_server }} 修订
{: #applying-mobilefirst-server-fixes }
对 {{ site.data.keys.mf_bm }} 服务的更新会自动应用，无需人为干预，无需同意执行更新。 档更新可用时，会在服务的“仪表板”页面中显示一个条幅，其中包含指示信息和操作按钮。

## 访问服务器日志
{: #accessing-server-logs }
要访问服务器日志，请打开侧边栏并单击**应用程序 → Cloud Foundary 应用程序**。 选择服务，然后单击**运行时**。 然后单击**文件**选项卡。

您可以在 **logs** 文件夹中找到 **messages.log** 和 **trace.log** 文件。

#### 跟踪
{: #tracing }
要启动跟踪以在 **trace.log** 文件中查看调试级别消息：

1. 在**运行时 → 内存和实例**中，选择服务实例（以 **0** 开头的实例标识）。
2. 单击**跟踪**操作选项。
3. 输入以下跟踪语句：`com.worklight.*=debug=enabled`，然后单击**提交跟踪**。

现在，可从以上指定位置获取 **trace.log** 文件。

<img class="gifplayer" alt="{{ site.data.keys.mf_bm_short }} 服务的服务器日志" src="server-logs.png"/>

## 故障诊断
{: #troubleshooting }
Developer 计划不提供持续性数据库，这有时可能会导致数据丢失。 要在此类情况下快速开始使用，请确保遵循如下最佳实践：

* 每次执行以下任意服务器端操作时：
    * 部署适配器或者更新任何适配器配置或属性值
    * 执行任何安全配置，如作用域映射等

    请从命令行运行以下命令以将配置下载至 .zip 文件：

  ```bash
  $curl -X GET -u admin:admin -o export.zip http://<App Name>.mybluemix.net/mfpadmin/management-apis/2.0/runtimes/mfp/export/all
  ```

* 如果重新创建服务器或者配置丢失，请从命令行运行以下命令以将配置导入服务器：

  ```bash
  $curl -X POST -u admin:admin -F file=@./export.zip http://<App Name>.mybluemix.net/mfpadmin/management-apis/2.0/runtimes/mfp/deploy/multi
  ```

## 补充阅读
{: #further-reading }
现在 {{ site.data.keys.mf_server }} 实例已启动并正常运行。

* 熟悉 [{{ site.data.keys.mf_console }}](../../product-overview/components/console)。
* 通过[快速入门教程](../../quick-start)来体验 MobileFirst Foundation。
* 阅读所有[可用教程](../../all-tutorials/)。
