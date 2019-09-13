---
layout: tutorial
title: 设置 Web 开发环境
breadcrumb_title: Web
relevantTo: [javascript]
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
开发和测试 Web 应用程序与在所选的 Web 浏览器中预览本地 HTML 文件一样简单。  
开发人员可使用他们选择的 IDE 以及符合他们需求的任何框架。

但是，在 Web 应用程序的开发过程中存在一个障碍。 由于违反[同源策略](https://developer.mozilla.org/en-US/docs/Web/Security/Same-origin_policy)，Web 应用程序可能会发生一些错误。 同源策略是对 Web 浏览器施加的一项限制。 例如，如果在 **example.com** 域上托管某个应用程序，那么不允许同一应用程序访问其他服务器上的内容或 {{ site.data.keys.mf_server }} 上的内容。

[应在支持的拓扑中处理使用 {{ site.data.keys.product }} Web SDK](../../../application-development/sdk/web) 的 Web 应用程序，例如，在保持同一个源的情况下使用逆向代理在内部将请求重定向到相应服务器。

可使用以下任一方法来满足策略要求：

- 通过也托管 {{ site.data.keys.mf_server }} 的同一 WebSphere Full/Liberty Profile 应用程序服务器提供 Web 应用程序资源。
- 使用 Node.js 作为代理以将应用程序请求重定向到 {{ site.data.keys.mf_server }}。

#### 跳至：
{: #jump-to }
- [先决条件](#prerequisites)
- [使用 WebSphere Liberty Profile 提供 Web 应用程序资源](#using-websphere-liberty-profile-to-serve-the-web-application-resources)
- [使用 Node.js](#using-nodejs)
- [下一步](#next-steps)

## 先决条件
{: #prerequisites }
-   {: #web-app-supported-browsers }
    Web 应用程序在以下浏览器版本中受支持。 版本号表示各自浏览器的最早完全受支持的版本。

    | 浏览器               | Chrome   | Safari<sup>*</sup>   | Internet Explorer   | Firefox   | Android 浏览器   |
    |-----------------------|:--------:|:--------------------:|:-------------------:|:---------:|:-----------------:|
    | **受支持的版本** |  {{ site.data.keys.mf_web_browser_support_chrome_ver }} | {{ site.data.keys.mf_web_browser_support_safari_ver }} | {{ site.data.keys.mf_web_browser_support_ie_ver }} | {{ site.data.keys.mf_web_browser_support_firefox_ver }} | {{ site.data.keys.mf_web_browser_support_android_ver }}  |

    <sup>*</sup> 在 Safari 中，专用浏览模式仅支持单页应用程序 (SPA)。 其他应用程序可能会表现出异常行为。

    {% comment %} [sharonl][c-web-browsers-ms-edge] 请参阅任务 111165 中有关 Microsoft Edge 支持的信息。 {% endcomment %}

-   以下安装指示信息要求在开发人员工作站上安装 Apache Maven 或 Node.js。 有关更多指示信息，请参阅 [安装指南](../mobilefirst/installation-guide/)。

## 使用 WebSphere Liberty Profile 提供 Web 应用程序资源
{: #using-websphere-liberty-profile-to-serve-the-web-application-resources }
为了能够提供 Web 应用程序资源，需要将这些资源存储在 Maven Web 应用程序（**.war** 文件）中。

### 创建 Maven Web 应用程序原型
{: #creating-a-maven-webapp-archetype }
1. 从**命令行**窗口中，浏览至您选择的位置。
2. 运行以下命令：

   ```bash
   mvn archetype:generate -DgroupId=MyCompany -DartifactId=MyWebApp -DarchetypeArtifactId=maven-archetype-webapp -DinteractiveMode=false
   ```
    - 将 **MyCompany** 和 **MyWebApp** 替换为您自己的值。
    - 要逐个输入值，请除去 `-DinteractiveMode=false` 标志。

### 使用 Web 应用程序资源构建 Maven Web 应用程序 
{: #building-the-maven-webapp-with-the-web-applications-resources }
1. 将 Web 应用程序资源（如 HTML、CSS、JavaScript 和图像文件）放在所生成的 **[MyWebApp] → src → Main → webapp** 文件夹中。

    > 从此处开始，请考虑将 **webapp** 文件夹作为 Web 应用程序的开发位置。

2. 运行 `mvn clean install` 命令以生成包含应用程序 Web 资源的 .war 文件。  
   生成的 .war 文件位于 **[MyWebApp] → target** 文件夹中。
   
    > <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> **要点：**每次更新 Web 资源时，都必须运行 `mvn clean install`。

### 将 Maven Web 应用程序添加到应用程序服务器中
{: #adding-the-maven-webapp-to-the-application-server }
1. 编辑 WebSphere Application Server 的 **server.xml** 文件。  
    如果使用 {{ site.data.keys.mf_dev_kit }}，那么该文件位于 [**{{ site.data.keys.mf_dev_kit }}] → mfp-server → user → servers → mfp** 文件夹中。 添加以下条目：

   ```xml
   <application name="MyWebApp" location="path-to/MyWebApp.war" type="war"></application>
   ```
    - 将 **name** 和 **path-to/MyWebApp.war** 替换为您自己的值。
    - 将更改保存至 **server.xml** 文件后，系统将自动重新启动应用程序服务器。  

### 测试 Web 应用程序
{: #testing-the-web-application }
一旦您准备好测试 Web 应用程序，请访问以下 URL：**localhost:9080/MyWebApp**。
    - 将 **MyWebApp** 替换为您自己的值。

## 使用 Node.js
{: #using-nodejs }
Node.js 可用作逆向代理，以用于将请求从 Web 应用程序传送到 {{ site.data.keys.mf_server }}。

1. 从**命令行**窗口中，浏览至 Web 应用程序文件夹，然后运行以下一组命令： 

   ```bash
   npm init
   npm install --save express
   npm install --save request
   ```

2. 在 **node_modules** 文件夹中创建新文件，例如 **proxy.js**。
3. 将以下代码添加到该文件中：

   ```javascript
   var express = require('express');
   var http = require('http');
   var request = require('request');

   var app = express();
   var server = http.createServer(app);
   var mfpServer = "http://localhost:9080";
   var port = 9081;

   server.listen(port);
   app.use('/myapp', express.static(__dirname + '/'));
   console.log('::: server.js ::: Listening on port ' + port);

   // Web server - serves the web application
   app.get('/home', function(req, res) {
        // Website you wish to allow to connect
        res.sendFile(__dirname + '/index.html');
   });

   // Reverse proxy, pipes the requests to/from {{ site.data.keys.mf_server }}
   app.use('/mfp/*', function(req, res) {
        var url = mfpServer + req.originalUrl;
        console.log('::: server.js ::: Passing request to URL: ' + url);
        req.pipe(request[req.method.toLowerCase()](url)).pipe(res);
   });
   ```
    - 将 **port** 值替换为您首选的值。
    - 将 `/myapp` 替换为 Web 应用程序首选的路径名。
    - 将 `/index.html` 替换为主 HTML 文件的名称。
    - 如果需要，请使用 {{ site.data.keys.product }} 运行时的上下文根更新 `/mfp/*`。

4. 要启动代理，请运行以下命令：`node proxy.js`。
5. 一旦您准备好测试 Web 应用程序，请访问以下 URL：**server-hostname:port/app-name**（例如，**http://localhost:9081/myapp**）
    - 将 **server-hostname** 替换为您自己的值。
    - 将 **port** 替换为您自己的值。
    - 将 **app-name** 替换为您自己的值。

## 后续步骤
{: #next-steps }
要在 Web 应用程序中继续开发 {{ site.data.keys.product }}，需要将 {{ site.data.keys.product }} Web SDK 添加到 Web 应用程序中。

* 了解如何[将 {{ site.data.keys.product }} SDK 添加到 Web 应用程序中](../../../application-development/sdk/web/)。
* 要了解应用程序开发，请参阅[使用 {{ site.data.keys.product }} SDK](../../../application-development/) 教程。
* 要了解适配器开发，请参阅[适配器](../../../adapters/)类别。
