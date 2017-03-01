---
layout: tutorial
title: 设置 Cordova 开发环境
breadcrumb_title: Cordova
relevantTo: [cordova]
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
要开始 [Cordova (PhoneGap) 开发](https://cordova.apache.org/)，最基本的步骤是安装 Cordova CLI。Cordova CLI 是一款可用于创建 Cordova 应用程序的工具。可使用各种第三方框架和工具（如 Ionic、AngularJS 和 jQuery Mobile 等）来进一步提升这些应用程序的性能。
对于 Cordova 应用程序，可以使用您首选的代码编辑器（如 Atom.io、Visual Studio Code、Eclipse、IntelliJ 等）来实施应用程序和适配器。

**先决条件：**设置 Cordova 开发环境时，请确保您还阅读了[设置 {{ site.data.keys.product_adj }} 开发环境](../mobilefirst/)教程。

## 安装 Cordova CLI
{: #installing-the-cordova-cli }
{{ site.data.keys.product }} 支持 Apache [Cordova CLI 6.x](https://www.npmjs.com/package/cordova)。  
要进行安装：

1. 下载并安装 [NodeJS](https://nodejs.org/en/)。
2. 从**命令行**窗口中，运行以下命令：`npm install -g cordova`。

## 后续步骤
{: #next-steps }
要在 Cordova 应用程序中继续开发 {{ site.data.keys.product_adj }}，需要将 {{ site.data.keys.product_adj }} Cordova SDK/插件添加到 Cordova 应用程序中。

* 了解如何[将 {{ site.data.keys.product_adj }} SDK 添加到 Cordova 应用程序中](../../../application-development/sdk/cordova/)。
* 要了解应用程序开发，请参阅[使用 {{ site.data.keys.product }} SDK](../../../application-development/) 教程。
* 要了解适配器开发，请参阅[适配器](../../../adapters/)类别。
