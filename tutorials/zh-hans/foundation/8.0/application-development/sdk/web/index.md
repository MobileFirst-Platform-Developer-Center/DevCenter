---
layout: tutorial
title: 将 MobileFirst Foundation SDK 添加到 Web 应用程序
breadcrumb_title: Web
relevantTo: [javascript]
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
您可以使用首选开发环境和工具开发移动或桌面 {{ site.data.keys.product_adj }} Web 应用程序。  
在此教程中，了解如何将 {{ site.data.keys.product_adj }} Web SDK 添加到 Web 应用程序，以及如何向 {{ site.data.keys.mf_server }} 注册 Web 应用程序

{{ site.data.keys.product_adj }} Web SDK 作为一组 JavaScript 文件提供，并[在 NPM 中可用](https://www.npmjs.com/package/ibm-mfp-web-sdk)。  
SDK 包含以下文件：

- **ibmmfpf.js** - SDK 的核心。
- **ibmmfpfanalytics.js** - 为 {{ site.data.keys.mf_analytics }} 提供支持。

#### 跳转至
{: #jump-to }
- [先决条件](#prerequisites)
- [添加 {{ site.data.keys.product_adj }} Web SDK](#adding-the-mobilefirst-web-sdk)
- [初始化 {{ site.data.keys.product_adj }} Web SDK](#initializing-the-mobilefirst-web-sdk)
- [注册 Web 应用程序](#registering-the-web-application)
- [更新 {{ site.data.keys.product_adj }} Web SDK](#updating-the-mobilefirst-web-sdk)
- [相同的源策略](#same-origin-policy)
- [安全源策略](#secure-origins-policy)
- [接下来要学习的教程](#tutorials-to-follow-next)

## 先决条件
{: #prerequisites }
-   请参阅设置 Web 开发环境的 [受支持的 Web 浏览器](../../../installation-configuration/development/web/#web-app-supported-browsers)先决条件。

-   要运行 NPM 命令，必须安装 [Node.js](https://nodejs.org)。

## 添加 {{ site.data.keys.product_adj }} Web SDK
{: #adding-the-mobilefirst-web-sdk }
要将 SDK 添加到新的或现有的 Web 应用程序，请先将其下载到您的工作站，然后将其添加到您的 Web 应用程序。

### 下载 SDK
{: #downloading-the-sdk }
1. 从**命令行**窗口，浏览至您的 Web 应用程序的根文件夹。
2. 运行命令：`npm install ibm-mfp-web-sdk`。

此命令将创建以下目录结构：

![SDK 文件夹内容(sdk-folder.png)

### 添加 SDK
{: #adding-the-sdk }
要添加 {{ site.data.keys.product }} Web SDK，请在 Web 应用程序中以标准方式进行引用。  
SDK 还[支持 AMD](https://en.wikipedia.org/wiki/Asynchronous_module_definition)，以便您可以使用模块装入器（如 [RequireJS](http://requirejs.org/)）装入 SDK。

#### 标准
在 `HEAD` 元素中引用 **ibmmfpf.js** 文件。  

```html
<head>
    ...
    ...
    <script type="text/javascript" src="node_modules/ibm-mfp-web-sdk/ibmmfpf.js"></script>
</head>
```

#### 使用 RequireJS

**HTML**  

```html
<script type="text/javascript" src="node_modules/requirejs/require.js" data-main="index"></script>
```

**JavaScript**

```javascript
require.config({
	'paths': {
		'mfp': 'node_modules/ibm-mfp-web-sdk/ibmmfpf'
	}
});

require(['mfp'], function(WL) {
    // application logic.
});
```

> <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> **要点：**如果要添加分析支持，请将 **ibmmfpfanalytics.js** 文件引用放置在 **ibmmfpf.js** 文件引用**之前**。

## 初始化 {{ site.data.keys.product_adj }} Web SDK
{: #initializing-the-mobilefirst-web-sdk }
通过在您的 Web 应用程序的主要 JavaScript 文件中指定**上下文根**和**应用程序标识**值来初始化 {{ site.data.keys.product }} Web SDK：

```javascript
var wlInitOptions = {
    mfpContextRoot : '/mfp', // "mfp" is the default context root in the {{ site.data.keys.product }}
    applicationId : 'com.sample.mywebapp' // Replace with your own value.
};

WL.Client.init(wlInitOptions).then (
    function() {
        // Application logic.
});
```

- **mfpContextRoot：**{{ site.data.keys.mf_server }} 所使用的上下文根。
- **applicationId：**应用程序包名称，在[注册应用程序](#registering-the-web-application)时定义。

### 注册 Web 应用程序 
{: #registering-the-web-application }
您可以从 {{ site.data.keys.mf_console }} 或者从 {{ site.data.keys.mf_cli }} 注册应用程序。

#### 从 {{ site.data.keys.mf_console }}
{: #from-mobilefirst-operations-console }
1. 打开您偏爱的浏览器，通过输入 `http://localhost:9080/mfpconsole/` URL 来装入 {{ site.data.keys.mf_console }}。
2. 单击**应用程序**旁边的**新建**按钮以创建新应用程序。
3. 选择 **Web** 作为平台，并提供名称和标识。
4. 单击**注册应用程序**。

![添加 Web 平台(add-web-platform.png)

#### 从 {{ site.data.keys.mf_cli }}
{: #from-mobilefirst-cli }
从**命令行**窗口，浏览至 Web 应用程序的根文件夹，并运行命令：`mfpdev app register`。

## 更新 {{ site.data.keys.product_adj }} Web SDK
{: #updating-the-mobilefirst-web-sdk }
可以在 SDK [NPM 存储库](https://www.npmjs.com/package/ibm-mfp-web-sdk)中找到 SDK 发行版。  
要使用最新发行版更新 {{ site.data.keys.product_adj }} Web SDK：

1. 浏览至 Web 应用程序的根文件夹。
2. 运行命令：`npm update ibm-mfp-web-sdk`。

## 同源策略
{: #same-origin-policy }
如果将 Web 资源托管在未安装 {{ site.data.keys.mf_server }} 的服务器上，将触发[同源策略](https://developer.mozilla.org/en-US/docs/Web/Security/Same-origin_policy)违例。同源策略安全模型旨在防范来自未经验证的源的潜在安全威胁。根据此策略，浏览器允许 Web 资源（如脚本）仅与来自相同源（定义为 URI 方案、主机名和端口号的组合）的资源交互。有关同源策略的更多信息，请参阅 [Web 源概念](https://tools.ietf.org/html/rfc6454)规范，特别是 [3. 同源策略的原则](https://tools.ietf.org/html/rfc6454#section-3)。

必须在支持拓扑中处理使用 {{ site.data.keys.product_adj }} Web SDK 的 Web 应用程序。例如，使用逆向代理在内部将请求重定向到相应的服务器，同时维护相同的单个源。

### 替换方法
{: #alternatives }
您可以使用以下任何一种方法来满足策略需求：

- 从 {{ site.data.keys.mf_dev_kit_full }} 中所使用的同一个 WebSphere Application Server Liberty Profile 应用程序服务器提供 Web 应用程序资源。
- 使用 Node.js 作为逆向代理将应用程序请求重定向到 {{ site.data.keys.mf_server }}。

> 在[设置 Web 开发环境](../../../installation-configuration/development/web)教程中了解更多信息

## 安全源策略
{: #secure-origins-policy }
当您在开发期间使用 Chrome 时，如果使用 HTTP 和**非** `localhost` 主机，那么浏览器可能不允许应用程序装入。这是因为，缺省情况下，在此浏览器中实施和使用安全源策略。

要解决此问题，可以使用以下标记启动 Chrome 浏览器：

```bash
--unsafely-treat-insecure-origin-as-secure="http://replace-with-ip-address-or-host:port-number" --user-data-dir=/test-to-new-user-profile/myprofile
```

- 将“test-to-new-user-profile/myprofile”替换为充当新 Chrome 用户概要文件的文件夹的位置，以使标记起作用。

在[此 Chormium 开发人员文档](https://www.chromium.org/Home/chromium-security/prefer-secure-origins-for-powerful-new-features)中阅读有关安全源的更多信息。

## 接下来要学习的教程
{: #tutorials-to-follow-next }
集成 {{ site.data.keys.product_adj }} Web SDK 之后，您现在可以：

- 查看[使用 {{ site.data.keys.product }} SDK 教程](../)
- 查看[适配器开发教程](../../../adapters/)
- 查看[认证和安全教程](../../../authentication-and-security/)
- 查看[所有教程](../../../all-tutorials)
