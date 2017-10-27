---
layout: tutorial
title: 许可证跟踪
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
缺省情况下，{{ site.data.keys.product_full }} 中已启用了许可证跟踪，该功能会跟踪与许可策略相关的度量值，如活动客户机设备数、可寻址设备数以及已安装的应用程序数。此信息帮助确定 {{ site.data.keys.product }} 的当前使用是否在许可证权利级别内，并可防止潜在的许可证违例。

此外，通过跟踪客户机设备的使用并确定设备是否处于活动状态，{{ site.data.keys.product_adj }} 管理员可以停用不再访问 {{ site.data.keys.mf_server }} 的设备。例如，如果某个员工离开公司，那么可能会出现此情况。

#### 跳转至
{: #jump-to }

* [设置应用程序许可证信息](#setting-the-application-license-information)
* [许可证跟踪报告](#license-tracking-report)
* [令牌许可证验证](#token-license-validation)
* [与 IBM License Metric Tool 集成](#integration-with-ibm-license-metric-tool)

## 设置应用程序许可证信息
{: #setting-the-application-license-information }
了解如何针对注册 {{ site.data.keys.mf_server }} 的应用程序设置应用程序许可证信息。

许可条款区分 {{ site.data.keys.product_full }}、{{ site.data.keys.product_full }} Consumer、{{ site.data.keys.product_full }} Enterprise 和 IBM {{ site.data.keys.product_adj }} Additional Brand Deployment。请在向服务器注册应用程序时设置应用程序的许可证信息，以便许可证跟踪报告能生成正确的许可证信息。如果为令牌许可配置了服务器，那么许可证信息将用于从许可证服务器检出正确的功能部件。

可设置应用程序类型和令牌许可证类型。应用程序类型的可能的值有：  

* **B2C**：如果应用程序作为 {{ site.data.keys.product_full }} Consumer 获得许可，请使用此应用程序类型。
* **B2E**：如果应用程序作为 {{ site.data.keys.product_full }} Enterprise 获得许可，请使用此应用程序类型。
* **UNDEFINED**：如果您无需跟踪“可寻址设备”度量的合规性，请使用此应用程序类型。

令牌许可证类型的可能的值有：

* **APPLICATION**：将 APPLICATION 用于大多数应用程序。这是缺省值。
* **ADDITIONAL\_BRAND\_DEPLOYMENT**：如果应用程序作为 IBM {{ site.data.keys.product_adj }} Additional Brand Deployment 获得许可，请使用此 ADDITIONAL\_BRAND\_DEPLOYMENT。
* **NON_PRODUCTION**：在生产服务器上开发和测试应用程序时，请使用 NON\_PRODUCTION。未对令牌许可证类型为 NON_PRODUCTION 的应用程序检出令牌。

> **要点：**将 NON_PRODUCTION 用于生产应用程序违反许可条款。

**注：**如果为令牌许可配置了服务器，并且如果您计划使用“令牌许可证类型”ADDITIONAL\_BRAND\_DEPLOYMENT 或 NON_PRODUCTION 注册应用程序，请在注册第一个版本的应用程序前设置应用程序许可证信息。利用 mfpadm 程序，可以在注册任何版本前设置应用程序的许可证信息。设置许可证信息后，在注册第一个版本的应用程序时将检出正确数目的令牌。有关令牌验证的更多信息，请参阅“令牌许可证验证”。

要使用 {{ site.data.keys.mf_console }} 设置许可证类型

1. 选择应用程序
2. 选择**设置**
3. 设置**应用程序类型**和**令牌许可证类型**
4. 单击**保存**。

要使用 mfpadm 程序设置许可证类型，请使用 `mfpadm app <appname> set license-config <application-type> <token license type>`

以下示例将许可证信息 B2E / APPLICATION 设置为名为 **my.test.application** 的应用程序

```bash
echo password:admin > password.txt
mfpadm --url https://localhost:9443/mfpadmin --secure false --user admin \ --passwordfile password.txt \ app mfp my.test.application ios 0.0.1 set license-config B2E APPLICATION
rm password.txt
```

## 许可证跟踪报告
{: #license-tracking-report }
{{ site.data.keys.product }} 为“客户机设备”度量、“可寻址设备”度量和“应用程序”度量提供许可证跟踪报告。该报告还提供历史数据。

许可跟踪报告显示以下数据：

* 在 {{ site.data.keys.mf_server }}
中部署的应用程序数。
* 当前日历月中的可寻址设备数。
* 客户机设备（活动设备和已退役的设备）数。
* 过去 n 天报告的客户机设备的最大数量，其中 n 是停用客户机设备之前所需经过的不活动天数。

您可能希望进一步分析数据。为此，可下载 CSV 文件，该文件包含许可证报告以及许可证度量的历史列表。

要访问许可证跟踪报告：

1. 打开
{{ site.data.keys.mf_console }}。
2. 单击**您好，您的姓名**菜单。
3. 选择**许可证**。

要从许可证跟踪报告获取 CSV 文件，请单击**操作/下载报告**。

## 令牌许可证验证
{: #token-license-validation }
如果要为令牌许可安装和配置 IBM {{ site.data.keys.mf_server }}，那么服务器会在各种场景中验证许可证。如果配置不正确，那么无法在应用程序注册或删除时验证
许可证。

### 验证场景
{: #validation-scenarios }
许可证会在各种场景下验证：

#### 注册应用程序时
{: #on-application-registration }
如果没有足够多的令牌可用于应用程序的令牌许可证类型，那么注册应用
程序将失败。

> **提示：**在注册第一个版本的应用程序之前，可设置令牌许可证类型。

每个应用程序仅检查一次许可证。如果要为同一应用程序注册新平台，或如果要为现有应用程序和平台注册新版本，那么将不会索要新令牌。

#### 更改令牌许可证类型时
{: #on-token-license-type-change }
更改应用程序的令牌许可证类型时，将发布应用程序的令牌，然后针对新的许可证类型取回此令牌。

#### 删除应用程序时
{: #on-application-deletion }
删除应用程序的最后一个版本时将检入许可证。

#### 服务器启动时
{: #at-server-start }
将针对每个已注册的应用程序检出许可证。如果没有足够多的令牌可用于所有应用程序，那么服务器将取消激活应用程序。

> **要点：**服务器未自动重新激活应用程序。增加可用令牌数后，必须手动重新激活应用程序。有关禁用和启用应用程序的更多信息，请参阅[远程禁用应用程序对受保护资源的访问权](../using-console/#remotely-disabling-application-access-to-protected-resources)。

#### 许可证到期时
{: #on-license-expiration }
特定的一段时间过后，许可证将到期且必须再次检出。如果没有足够多的令牌可用于所有应用程序，那么服务器将取消激活应用程序。

> **要点：**服务器未自动重新激活应用程序。扩大可用令牌数后，必须手动重新激活应用程序。有关禁用和启用应用程序的更多信息，请参阅[远程禁用应用程序对受保护资源的访问权](../using-console/#remotely-disabling-application-access-to-protected-resources)。

#### 服务器关闭时
{: #at-server-shutdown }
在关闭服务器的过程中，会为每个已部署的应用程序检入许可证。只有关闭场的集群的最后一台服务器时才会发布令牌。

### 许可证验证失败的原因
{: #causes-of-license-validation-failure }
在以下情况下，当注册或删除应用程序时，许可证验证可能会失败：

* 未安装和配置 Rational Common Licensing 本机库。
* 未针对令牌许可配置管理服务。
有关更多信息，请参阅[针对令牌许可进行安装和配置](../../installation-configuration/production/token-licensing)。
* Rational License Key Server 不可访问。
* 未提供足够的令牌。
* 许可证已到期。

### {{ site.data.keys.product_full }} 所使用的 IBM Rational License Key Server 功能部件名称
{: #ibm-rational-license-key-server-feature-name-used-by-ibm-mobilefirst-foundation }
根据应用程序的令牌许可证类型，将使用以下功能部件。

| 令牌许可证类型| 功能部件名称| 
|--------------------|--------------|
| APPLICATION| 	ibmmfpfa| 
| ADDITIONAL\_BRAND\_DEPLOYMENT|	ibmmfpabd| 
| NON_PRODUCTION	| （无功能部件）| 

## 与 IBM License Metric Tool 进行集成
{: #integration-with-ibm-license-metric-tool }
IBM License Metric Tool 允许您评估是否遵守 IBM 许可证。

如果尚未安装支持 IBM Software License Metric Tag 或 SWID（软件标识）文件的 IBM License Metric Tool 版本，可以在 {{ site.data.keys.mf_console }} 中使用许可证跟踪报告来复审许可证使用情况。有关更多信息，请参阅[许可证跟踪报告](#license-tracking-report)。

### 关于使用 SWID 文件的基于 PVU 的许可
{: #about-pvu-based-licensing-using-swid-files }
如果您已购买 IBM MobileFirst Foundation Extension V8.0.0 产品，将根据处理器价值单元 (PVU) 度量进行许可。

PVU 计算基于 IBM License Metric Tool 对 ISO/IEC 19970-2 和 SWID 文件的支持。在 IBM Installation Manager 安装 {{ site.data.keys.mf_server }} 或 {{ site.data.keys.mf_analytics_server }} 时，将 SWID 文件写入服务器。当 IBM License Metric Tool 根据当前目录发现产品的无效 SWID 文件时，将在“软件目录”窗口小部件上显示一个警告符号。有关 IBM License Metric Tool 如何使用 SWID 文件的更多信息，请参阅 [https://www.ibm.com/support/knowledgecenter/SS8JFY_9.2.0/com.ibm.lmt.doc/Inventory/overview/c\_iso\_tags.html](https://www.ibm.com/support/knowledgecenter/SS8JFY_9.2.0/com.ibm.lmt.doc/Inventory/overview/c_iso_tags.html)。

Application Center 安装数量不受基于 PVU 的许可限制。

针对 Foundation Extension 的 PVU 许可证只可以与以下产品许可证一起购买：IBM WebSphere Application Server Network Deployment、IBM API Connect™ Professional 或 IBM API Connect Enterprise。IBM Installation Manager 将添加或更新 SWID 文件以供 License Metric Tool 使用。

> 有关 {{ site.data.keys.product_full }} Extension 的更多信息，请参阅 [https://www.ibm.com/common/ssi/cgi-bin/ssialias?infotype=AN&subtype=CA&htmlfid=897/ENUS216-367&appname=USN](https://www.ibm.com/common/ssi/cgi-bin/ssialias?infotype=AN&subtype=CA&htmlfid=897/ENUS216-367&appname=USN)。

> 有关 PVU 许可的更多信息，请参阅 [https://www.ibm.com/support/knowledgecenter/SS8JFY_9.2.0/com.ibm.lmt.doc/Inventory/overview/c\_processor\_value\_unit\_licenses.html](https://www.ibm.com/support/knowledgecenter/SS8JFY_9.2.0/com.ibm.lmt.doc/Inventory/overview/c_processor_value_unit_licenses.html)。

### SLMT 标记
{: #slmt-tags }
IBM MobileFirst Foundation 将生成 IBM Software License Metric Tag (SLMT) 文件。支持 IBM Software License Metric Tag 的 IBM License Metric Tool 版本会生成许可证使用量报告。阅读此部分以解释这些 {{ site.data.keys.mf_server }} 报告，并配置 IBM Software License Metric Tag 文件的生成。

正在运行的 MobileFirst 运行时环境的每个实例均生成 IBM Software License Metric Tag 文件。受监控的度量值是
`CLIENT_DEVICE`、`ADDRESSABLE_DEVICE`
和 `APPLICATION`。这些值每 24 小时刷新一次。

#### 关于 CLIENT_DEVICE 度量值
{: #about-the-client_device-metric }
`CLIENT_DEVICE` 度量值可以具有以下子类型：

* 活动设备数

    使用 MobileFirst 运行时环境，或使用属于同一集群或服务器场的其他 MobileFirst 运行时实例，且尚未停用的客户机设备数。有关已停用设备的更多信息，请参阅
[
为客户机设备和可寻址设备配置许可证跟踪](../../installation-configuration/production/server-configuration/#configuring-license-tracking-for-client-device-and-addressable-device)。

* 不活动设备

    使用 MobileFirst 运行时环境，或使用属于同一集群或服务器场的其他 MobileFirst 运行时实例，且已停用的客户机设备数。有关已停用设备的更多信息，请参阅
[
为客户机设备和可寻址设备配置许可证跟踪](../../installation-configuration/production/server-configuration/#configuring-license-tracking-for-client-device-and-addressable-device)。

具体情况如下：

* 如果设备的停用时间段设置为一小段时间，那么“不活动设备”子类型替换为子类型“活动或不活动设备”。
* 如果已禁用设备跟踪，那么只为 `CLIENT_DEVICE` 生成一个条目，其值为 0，且度量值子类型为“设备跟踪已禁用”。

#### 关于 APPLICATION 度量值
{: #about-the-application-metric }
APPLICATION 度量值没有任何子类型，除非 MobileFirst 运行时环境正在开发服务器上运行。

为该度量值报告的值是在 MobileFirst 运行时环境中部署的应用程序数。不论是新应用程序、其他品牌部署还是现有应用程序的其他类
型（例如，本机、混合或 Web），每个应用程序都计算为一个单元。

#### 关于 ADDRESSABLE_DEVICE 度量值
{: #about-the-addressable_device-metric }
ADDRESSABLE_DEVICE 度量值具有以下子类型：

* 应用程序：`<applicationName>`，类别：`<application type>`

应用程序类型为
**B2C**、**B2E** 或
**UNDEFINED**。要定义应用程序的应用程序类型，请参阅[设置应用程序许可证信息](#setting-the-application-license-information)。

具体情况如下：

* 如果设备的停用时间段设置为小于 30 天，那么会向子类型附加警告“停用时间段短”。
* 如果禁用了许可证跟踪，则不会生成可寻址报告。

有关使用度量值配置许可证跟踪的更多信息，请参阅

* [
为客户机设备和可寻址设备配置许可证跟踪](../../installation-configuration/production/server-configuration/#configuring-license-tracking-for-client-device-and-addressable-device)
* [配置 IBM License Metric Tool 日志文件](../../installation-configuration/production/server-configuration/#configuring-ibm-license-metric-tool-log-files)
