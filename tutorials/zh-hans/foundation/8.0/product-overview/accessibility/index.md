---
layout: tutorial
title: IBM MobileFirst Foundation 的辅助功能
breadcrumb_title: 辅助功能
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
<br/>
辅助功能旨在帮助身体有残疾的用户（如行动不便或视力受限）成功使用信息技术内容。

### 辅助功能
{: #accessibility-features }
{{ site.data.keys.product_full }}
包含以下主要辅助功能：

* 可以仅通过键盘完成的操作
* 支持使用屏幕朗读器的操作

{{ site.data.keys.product }} 使用最新的 W3C 标准，即，[WAI-ARIA
1.0](http://www.w3.org/TR/wai-aria/)，确保符合 [US Section 508](http://www.access-board.gov/guidelines-and-standards/communications-and-it/about-the-section-508-standards/section-508-standards) 以及 [Web Content Accessibility Guidelines (WCAG) 2.0](http://www.w3.org/TR/WCAG20/) 中的要求。 要利用这些辅助功能，需使用最新版的屏幕朗读器和该产品所支持的最新 Web 浏览器。

### 键盘导航
{: #keyboard-navigation }
本产品使用标准导航键。

### 界面信息
{: #interface-informaton }
{{ site.data.keys.product }} 用户界面没有每秒闪烁 2 - 55 次的内容。

您可以将屏幕朗读器与数字语音合成器结合使用，以收听屏幕上显示的内容。 请参阅辅助技术的文档，以获取有关如何将辅助技术用于本产品及其文档的详细信息。

### {{ site.data.keys.mf_cli }}
{: #mobilefirst-cli }
缺省情况下，通过 {{ site.data.keys.mf_cli }} 显示的状态消息会使用各种不同颜色来表示成功、错误和警告。 您可以在任何 {{ site.data.keys.mf_cli }} 命令上使用 `--no-color` 选项，以禁止该命令使用这些颜色。 指定 `--no-color` 时，会用为操作系统控制台设置的文本显示颜色来显示输出。

### Web 界面 
{: #web-interface }
{{ site.data.keys.product }} Web 用户界面依靠级联样式表适当地呈现内容并提供可用的经验。 应用程序为弱视用户提供一种同等方式来使用用户的系统显示设置，包括高对比度模式。 您可以使用设备或 Web 浏览器设置来控制字体大小。

可以使用键盘快捷键浏览不同的 {{ site.data.keys.product_adj }} 环境及其文档。 Eclipse 为其开发环境提供辅助功能。 因特网浏览器还为 Web 应用程序（如 {{ site.data.keys.mf_console }}、{{ site.data.keys.mf_analytics_console }}、{{ site.data.keys.product }} Application Center 控制台和 {{ site.data.keys.product }} Application Center 移动式客户机）提供辅助功能。

{{ site.data.keys.product }} Web 用户界面包含可用于快速导航至应用程序中功能区域的 WAI-ARIA 导航界标。

### 安装和配置
{: #installation-and-configuration }
可通过以下两种方式安装和配置 {{ site.data.keys.product }}：图形用户界面 (GUI) 或命令行。

虽然图形用户界面（向导方式下的 IBM Installation
Manager 或 Server
Configuration Tool）不提供有关用户界面对象的信息，但可提供与命令行界面同等的功能。 GUI 中的所有功能均受命令行支持，但部分特定的安装和配置功能只能由命令行提供。 您可以在 IBM Knowledge
Center 中阅读有关 [IBM Installation Manager](http://www.ibm.com/support/knowledgecenter/SSDV2W/im_family_welcome.html?lang=en&view=kc) 的辅助功能的信息。

以下主题提供有关如何在不使用 GUI 的情况下完成安装和配置的信息：

* 使用 IBM Installation Manager 的样本响应文件
该方法支持以静默方式安装和配置 {{ site.data.keys.mf_server }} 和 Application Center。 可以通过使用名为 install-no-appcenter.xml 的响应文件暂不安装 Application Center。 之后，使用 Ant 任务在后期阶段进行安装。 请参阅“使用 Ant 任务安装 Application Center”。 在此情况下，可以独立完成 Application Center 的安装和升级。
* 使用 Ant 任务安装
* 使用 Ant 任务安装 Application Center。

### 供应商软件
{: #vendor-software }
{{ site.data.keys.product }} 包含 IBM 许可协议未涵盖的特定供应商软件。 IBM 未对这些产品的辅助功能选项作任何说明。 请联系供应商以获取其产品的辅助功能信息。

### 相关辅助功能信息
{: #related-accessibility-information }
除了标准 IBM 帮助热线和支持 Web 站点，IBM 已建立 TTY 电话服务以供失聪或者有听力障碍的客户用来访问销售和支持服务：

TTY 服务  
800-IBM-3383 (800-426-3383)  
（北美地区）

### IBM 和辅助功能
{: #ibm-and-accessibility }
有关 IBM 对于辅助功能的承诺的更多信息，请参阅 [IBM 辅助功能](http://www.ibm.com/able)。


