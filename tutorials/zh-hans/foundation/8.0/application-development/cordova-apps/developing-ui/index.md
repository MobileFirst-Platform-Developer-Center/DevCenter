---
layout: tutorial
title: 为 Cordova 应用程序开发 UI
breadcrumb_title: Developing UI
relevantTo: [cordova]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
设计并实现应用程序的 UI 是开发流程中的重要部分。 通过结合使用 {{ site.data.keys.product_adj }} Eclipse 插件与 Thym 插件，可在开发 cordova 应用程序的过程中提供帮助。
从头开始为每个组件编写定制的 CSS 样式可以实现高级别的定制，但这样做需要大量资源。
有时，使用现有 JavaScript UI 框架是更好的方法。
本主题描述如何使用 {{ site.data.keys.product_adj }} Studio 的 Eclipse 中提供的两个 UI 框架（jQuery Mobile 和一个所见即所得编辑器）来开发 {{ site.data.keys.product_adj }} 应用程序。

要使用 MobileFirst Eclipse 插件为 Cordova 应用程序开发 UI，请执行以下操作：

1. 下载 Eclipse。
2. 从 Eclipse 市场安装 [Thym](http://marketplace.eclipse.org/content/eclipse-thym) 插件。
3. 从 Eclipse 市场安装 [MobileFirst 平台插件](http://marketplace.eclipse.org/content/ibm-mobilefirst-foundation-studio)。


## 所见即所得编辑器
{: #wysiwyg-editor }
MobileFirst 平台 Eclipse 插件随附一个所见即所得编辑器，为开发人员在开发 HTML UI 窗口小部件时提供便利。
该编辑器提供基本的选用板，供用户拖放 UI 窗口小部件，如按钮或文本框及其他 HTML 窗口小部件。这是一种“移动应用程序快速开发”工具，用于支持用户快速开发 Cordova 应用程序。

![所见即所得编辑器](wysiwyg-editor.png)

## jQuery Mobile
{: #jquery-mobile }
jQuery 是快速简洁的 JavaScript 框架，可简化快速 Web 开发工作的 HTML 文档流、事件处理、动画和 Ajax 交互。 jQuery Mobile 是针对智能手机和平板电脑的 Web 框架，对触摸操作进行了优化。 jQuery Mobile 需要运行 jQuery。

要将 jQuery Mobile 添加到应用程序，请执行以下操作：

1. 通过单击**文件 ->新建 -> 新建 Hybrid Mobile (Cordova) 应用程序项目**，在 eclipse 中创建 Thym 项目。
2. [下载 jQuery Mobile 包](http://jquerymobile.com/download/)。
3. 将下载的 jQuery Mobile 包复制到混合应用程序的 `www` 目录中，如下图所示：![www 目录](www-dir.png)
4. 打开主 `index.html`，如截屏所示，并将 jQuery 引用（如代码片段中所示）添加到项目：![添加 JQuery 引用](add-jquery-refs.png)

    ```html
      <!DOCTYPE HTML>
      <html>
          	<head>
          		<meta charset="UTF-8">
          		<title>appName</title>
          		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=0">
          		<!--
          			<link rel="shortcut icon" href="images/favicon.png">
          			<link rel="apple-touch-icon" href="images/apple-touch-icon.png">
          		-->
          		<link href="jqueryMobile/jquery.mobile.structure-1.4.5.min.css" rel="stylesheet">
          		<link href="jqueryMobile/demos/css/jquery.mobile.structure-1.4.5.min.css" rel="stylesheet">
          		<link href="jqueryMobile/jquery.mobile-1.4.5.min.css" rel="stylesheet">
          		<link href="jqueryMobile/jquery.mobile.theme-1.4.5.css" rel="stylesheet">
          		<link href="jqueryMobile/jquery.mobile.theme-1.4.5.min.css" rel="stylesheet">
          		<link href="jqueryMobile/jquery.mobile.external-png-1.4.5.min.css" rel="stylesheet">
          		<link href="jqueryMobile/jquery.mobile.inline-png-1.4.5.css" rel="stylesheet">
          		<link href="jqueryMobile/demos/css/jquery.mobile.inline-svg-1.4.5.min.css" rel="stylesheet">
          		<link href="jqueryMobile/jquery.mobile-1.4.5.css" rel="stylesheet">
          		<link href="jqueryMobile/jquery.mobile.inline-png-1.4.5.min.css" rel="stylesheet">
          		<link href="jqueryMobile/jquery.mobile.external-png-1.4.5.css" rel="stylesheet">
          		<link href="jqueryMobile/demos/css/jquery.mobile.inline-png-1.4.5.min.css" rel="stylesheet">
          		<link href="jqueryMobile/demos/theme-classic.css" rel="stylesheet">
          		<link href="jqueryMobile/jquery.mobile.inline-svg-1.4.5.css" rel="stylesheet">
          		<link href="jqueryMobile/jquery.mobile.structure-1.4.5.css" rel="stylesheet">
          		<link href="jqueryMobile/demos/css/jquery.mobile-1.4.5.min.css" rel="stylesheet">
          		<link href="jqueryMobile/jquery.mobile.inline-svg-1.4.5.min.css" rel="stylesheet">
          		<link href="jqueryMobile/demos/css/jquery.mobile.theme-1.4.5.min.css" rel="stylesheet">
          		<link href="jqueryMobile/demos/css/jquery.mobile.external-png-1.4.5.min.css" rel="stylesheet">
          		<link rel="stylesheet" href="css/main.css">
          		<script>window.$ = window.jQuery = WLJQ;</script>
          		<script src="jqueryMobile/demos/jquery.js"></script>
          		<script src="jqueryMobile/demos/jquery.mobile-1.4.5.js"></script>
          	</head>
          	<body style="display: none;">
          		<div data-role="page" id="page">
          			<div data-role="content" style="padding: 15px">
          				<!--application UI goes here-->
          				Hello MobileFirst
          			</div>
          		</div>
          		<script src="js/initOptions.js"></script>
          		<script src="js/main.js"></script>
          		<script src="js/messages.js"></script>
          	</body>
      </html>
    ```
在 HTML 文件中添加对 jQuery Mobile 的引用之后，在 Eclipse 中关闭并重新打开此文件。您现在将在可拖放到 HTML 画布的“选用板”视图中看到 jQuery Mobile 窗口小部件。
