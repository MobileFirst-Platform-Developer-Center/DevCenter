---
layout: tutorial
title: 设置 Ionic 开发环境
breadcrumb_title: Ionic
relevantTo: [ionic]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
Ionic 是一个构建在 [AngularJS](https://angularjs.org/) 和 [Apache Cordova](https://cordova.apache.org/) 之上的框架，可帮助您使用 Web 技术（例如，HTML、CSS 和 Javascript）快速构建混合移动和 Web 应用程序。

如果您是选择 Ionic 作为框架开发移动或 Web 应用程序的开发人员，那么以下部分可帮助您开始在 Ionic 应用程序中使用 [IBM Mobile Foundation](http://mobilefirstplatform.ibmcloud.com) SDK。

您可以使用自己首选的代码编辑器（如 Atom.io、Visual Studio Code、Eclipse、IntelliJ 等）来编写您的应用程序。

**先决条件：**设置 Ionic 开发环境时，请确保您还阅读了[设置 MobileFirst 开发环境](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/installation-configuration/development/mobilefirst)教程。

## 安装 Ionic CLI
{: #installing_cli }
要开始使用 Ionic 开发，需要执行的第一步是安装 [Ionic CLI](https://ionicframework.com/docs/cli/)。

**要安装 cordova 和 ionic CLI：**

* 下载并安装 [NodeJS](https://nodejs.org/en/)。
* 从命令行窗口中，运行以下命令：
```bash  
  npm install -g ionic
```  

## 将 Mobile Foundation SDK 添加到 Ionic 应用程序
{: #adding_mfp_ionic_sdk }
要在 Ionic 应用程序中继续使用 MobileFirst 开发，需要将 MobileFirst Cordova SDK 或插件添加到 Ionic 应用程序。

了解如何将 MobileFirst SDK 添加到 Cordova 应用程序。
有关应用程序开发，请参阅教程：[将 Mobile Foundation SDK 添加到 Ionic 应用程序]({{site.baseurl}}/tutorials/en/foundation/8.0/application-development/sdk/ionic)。
