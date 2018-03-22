---
layout: tutorial
title: 设置开发环境
breadcrumb_title: Development Environment
show_children: true
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
在使用 {{ site.data.keys.product_full }} 开始开发客户机和服务器代码之前，首先需要设置开发环境。 这包括安装各种必需的软件和工具。 下面是您可能需要在开发人员工作站上安装的软件的列表（取决于您的需求）。

您也可以[在本工作站安装指南中](mobilefirst/installation-guide/)找到详细的分步指示信息。

#### 跳至：

* [服务器](#server)
* [应用程序开发](#application-development)
* [适配器开发](#adapter-development)
* [特定于平台的指示信息](#platform-specific-instructions)

### 服务器
{: #server }
您可以通过 [Mobile Foundation IBM Cloud 服务](../../bluemix/using-mobile-foundation)或在本地通过 {{ site.data.keys.mf_dev_kit_full }}（用于本地开发目的）来使用 {{ site.data.keys.mf_server }}。{{ site.data.keys.mf_server }} 要求运行 Java 7 或 8。

如果您计划使用 Mobile Foundation IBM Cloud 服务，那么需要使用 bluemix.net 帐户。

### 应用程序开发
{: #application-development }
最低需求如下：

* NodeJS（为 {{ site.data.keys.mf_cli }} 所需）
* {{ site.data.keys.mf_cli }}
* Cordova CLI
* IDE：
    - Xcode
    - Android Studio
    - Visual Studio
    - Atom.io / Visual Studio Code / WebStorm / IntelliJ / Eclipse / 其他 IDE

### 适配器开发
{: #adapter-development }
最低需求如下：

* NodeJS（为 {{ site.data.keys.mf_cli }} 所需）
* *可选* {{ site.data.keys.mf_cli }}
* Maven（需要 Java）
* IDE：
    - IntelliJ / Eclipse / 其他 IDE

### 特定于平台的指示信息
{: #platform-specific-instructions }
