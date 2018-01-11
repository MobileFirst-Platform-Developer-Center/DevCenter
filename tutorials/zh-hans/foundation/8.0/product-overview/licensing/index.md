---
layout: tutorial
title: MobileFirst Server 中的许可
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
IBM {{ site.data.keys.mf_server }} 基于您的购买情况支持两种不同的许可方法。

如果购买了永久许可证，那么可通过 {{ site.data.keys.mf_console }} 中的**许可证跟踪页面**和[许可证跟踪报告](../../administering-apps/license-tracking/#license-tracking-report)来使用购买的产品并验证您的使用情况及合规性。 如果购买了令牌许可证，请将 {{ site.data.keys.mf_server }} 配置为与远程令牌许可证服务器通信。

### 应用程序或可寻址设备许可证
{: #application-or-addressable-device-licenses }
如果购买了应用程序或可寻址设备许可证，那么可通过 {{ site.data.keys.mf_console }} 中的许可证跟踪页面和许可证跟踪报告来使用购买的产品并验证您的使用情况及合规性。

### 处理器价值单元 (PVU) 许可
{: #processor-value-unit-pvu-licensing }
如果购买了 IBM {{ site.data.keys.product }} Extension（请参阅[许可证信息文档](http://www.ibm.com/software/sla/sladb.nsf/lilookup/C154C7B1C8C840F38525800A0037B46E?OpenDocument)），那么处理器价值单元 (PVU) 许可将可用，但此许可仅在购买 IBM WebSphere Application Server Network Deployment、IBM API Connect™ Professional 或 IBM API Connect Enterprise 之后才可用。

PVU 许可定价结构反映可用于已安装产品的处理器类型和数量。 权利可以是全容量或子容量。 在处理器价值单元许可结构下，您根据为每个处理器核心分配的价值单元数来进行软件许可。

例如，针对处理器类型 A，每个核心分配 80 个价值单元，针对处理器类型 B，每个核心分配 100 个价值单元。 如果许可某个产品在两个类型 A 处理器上运行，那么必须获得每个核心 160 个价值单元的权利。 如果该产品要在两个类型 B 处理器上运行，那么所需权利为每个核心 200 个价值单元。

> [阅读了解](https://www.ibm.com/support/knowledgecenter/SS8JFY_9.2.0/com.ibm.lmt.doc/Inventory/overview/c_processor_value_unit_licenses.html)有关 PVU 许可的更多信息。



### 令牌许可
{: #token-licensing }
与预先定义好的每个许可证支持的数量这种传统浮动环境相比，在令牌环境中，每个产品都采用预先定义好的每个许可证支持的令牌值。 许可证密钥有一个令牌池，许可证服务器可通过该池计算出检入和检出的令牌数。 当产品在许可证服务器中检入或检出许可证时，便会使用或者释放令牌。

您的许可合同中定义了是否能够使用令牌许可、可用的令牌数以及通过令牌验证的功能。 请参阅“令牌许可证验证”。

如果购买了基于令牌的许可证，那么安装支持令牌许可证的 {{ site.data.keys.mf_server }} 版本并配置应用程序服务器，以便该服务器可以与远程令牌服务器通信。 请参阅“安装和配置令牌许可”。

使用令牌许可，可以在部署每个应用程序之前在应用程序描述符中指定许可应用程序类型。 许可应用程序类型可以为 APPLICATION 或 ADDITIONAL_BRAND_DEPLOYMENT。 为了进行测试，可以将许可应用程序类型的值设置为 NON_PRODUCTION。 有关更多信息，请参阅“设置应用程序许可证信息”。

与 Rational License Key Server 8.1.4.9 一起发布的 Rational License Key Server
Administration and Reporting 工具可以管理 {{ site.data.keys.product }} 使用的许可证并为其生成报告。 可以使用以下显示名称识别该报告的相关部分：**MobileFirst Platform Foundation Application** 或 **MobileFirst Platform Additional Brand Deployment**。 这些名称指出为其使用令牌的许可应用程序类型。 有关更多信息，请参阅 [Rational License Key Server Administration](https://www.ibm.com/support/knowledgecenter/SSSTWP_8.1.4/com.ibm.rational.license.doc/topics/c_rlks_admin_tool_overview.html) 和 [Reporting Tool overview and Rational License Key Server Fix Pack 9 (8.1.4.9)](http://www.ibm.com/support/docview.wss?uid=swg24040300)。

有关 {{ site.data.keys.mf_server }} 的令牌许可使用规划的信息，请参阅“令牌许可使用规划”。

要获取 {{ site.data.keys.product }} 的许可证密钥，需要访问 IBM Rational License Key Center。 有关生成和管理许可证密钥的更多信息，请访问 [IBM Support - Licensing](http://www.ibm.com/software/rational/support/licensing/)。
