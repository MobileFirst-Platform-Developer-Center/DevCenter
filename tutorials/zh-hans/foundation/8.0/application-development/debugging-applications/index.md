---
layout: tutorial
title: 调试 JavaScript（Cordova、Web）应用程序
breadcrumb_title: 调试应用程序        
relevantTo: [javascript]
weight: 10
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
调试的过程包含查找应用程序代码和应用程序用户界面中缺陷原因。

* JavaScript（Cordova、Web）应用程序由基于 Web 的资源组成，例如，HTML、JavaScript 和 CSS。Cordova 应用程序也可能包含可选本机代码（以 Java、Objective-C、Swift 和 C#...编写）。
* 可使用平台 SDK 提供的标准工具来调试本机代码，例如，XCode、Android 或 Microsoft Visual Studio。

本教程探讨了调试基于 JavaScript 的应用程序的各种方法，无论是通过仿真器、模拟器、物理设备还是在 Web 浏览器中本地运行。

> 了解有关 Cordova 调试的更多信息并在 Cordova Web 站点中进行测试：[调试应用程序](https://cordova.apache.org/docs/en/latest/guide/next/index.html#link-testing-on-a-simulator-vs-on-a-real-device)。
#### 跳转至：
{: #jump-to }

* [使用 {{ site.data.keys.mf_mbs }}](#debugging-with-the-mobile-browser-simulator) 进行调试
* [使用 Ripple 进行调试](#debugging-with-ripple)
* [使用 iOS Remote Web Inspector 进行调试](#debugging-with-ios-remote-web-inspector)
* [使用 Chrome Remote Web Inspector 进行调试](#debugging-with-chrome-remote-web-inspector)
* [使用 {{ site.data.keys.product_adj }} 记录器进行调试](#debugging-with-mobilefirst-logger)
* [使用 WireShark 进行调试](#debugging-with-wireshark)

## 使用 {{ site.data.keys.mf_mbs }} 进行调试
{: #debugging-with-the-mobile-browser-simulator }
您可以使用 {{ site.data.keys.product_full }} {{ site.data.keys.mf_mbs }} (MBS) 来预览和调试 {{ site.data.keys.product_adj }} 应用程序。  
要使用 MBS，请打开**命令行**窗口并运行命令：

```bash
mfpdev app preview
```

如果应用程序包括多个平台 - 请指定要预览的平台：

```bash
mfpdev app preview -p <platform>
```

> <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> **重要信息：**预览功能具有多个已知限制。在预览期间，应用程序表现可能与期望不同。例如，其使用保密客户机绕过安全功能，因此不会触发验证问题处理程序。
### {{ site.data.keys.mf_mbs }}
{: #mobile-browser-simulator}

![MBS](mbs.png)

### 简单预览
{: #simple-preview }

![MBS](simple.png)

> 在[使用 {{ site.data.keys.mf_cli }} 来管理 {{ site.data.keys.product_adj }} 工件](../using-mobilefirst-cli-to-manage-mobilefirst-artifacts)教程中了解有关 {{ site.data.keys.mf_cli }} 的更多信息。
## 使用 Ripple 进行调试
{: #debugging-with-ripple }
Apache Ripple™ 是一个基于 Web 的移动环境模拟器，用于调试移动 Web 应用程序。  
它使您能够在浏览器中运行 Cordova 应用程序并模拟各种 Cordova f功能。例如，可通过让您从计算机本地选择照片来模拟照相机 API。  

### 安装 Ripple
{: #installing-ripple }

1. 下载并安装最新版本的 [Node.js](https://nodejs.org/en/)。
您可以通过在终端输入 `npm -v` 来验证 Node.js 安装。
2. 打开终端并输入：

   ```bash
   npm install -g ripple-emulator
   ```

### 使用 Ripple 运行应用程序
{: #running-application-using-ripple }
在安装 Ripple 后，从 Cordova 项目位置打开终端并输入：

```bash
ripple emulate
```

![Ripple 仿真器](Ripple2.png)

> 可在 [Apache Ripple 页面](http://ripple.incubator.apache.org/)或 [npm ripple-emulator 页面](https://www.npmjs.com/package/ripple-emulator)上找到有关 Apache Ripple™ 的更多信息。
## 使用 iOS Remote Web Inspector 进行调试
{: #debugging-with-ios-remote-web-inspector }
从 iOS 6 开始，Apple 引入一个远程 [Web Inspector](https://developer.apple.com/safari/tools/) 以供调试 iOS 设备上的 Web 应用程序。要进行调试，请确保设备（或 iOS 模拟器）已关闭**秘密浏览**选项。  

1. 要在设备上启用 Web Inspector，请点击**设置 > Safari > 高级 > Web Inspector**。
2. 要启动调试，请将 iOS 设备连接到 Mac，或者启动模拟器。
3. 在 Safari 中，转至**首选项 > 高级**，选中**在菜单栏上显示“开发”菜单**复选框。
4. 在 Safari 中，选择**开发 > [您的设备标识] > [您的应用程序 HTML 文件]**。

![Safari 调试](safari-debugging.png)

## 使用 Chrome Remote Web Inspector 进行调试
{: #debugging-with-chrome-remote-web-inspector }
使用 Google Chrome，可在 Android 设备或 Android 仿真器上远程检查 Web 应用程序。  
此操作需要 Android 4.4 或更高版本或者 Chrome 32 或更高版本。此外，在 `AndroidManifest.xml` 文件中，需要 `targetSdkVersion = 19` 或更高版本。在 `project.properties` 文件中，需要 `target = 19` 或更高版本。

1. 在 Android 仿真器或已连接的设备中启动应用程序。
2. 在 Chrome 的地址栏中输入以下 URL：`chrome://inspect`。
3. 按下相关应用程序的**检查**。

![Chrome Remote Web Inspector](Chrome-Remote-Web-Inspector.png)

### 使用 {{ site.data.keys.product_adj }} 记录器进行调试
{: #debugging-with-mobilefirst-logger }
{{ site.data.keys.product }} 提供可用于打印日志消息的 `WL.Logger` 对象。  
`WL.Logger` 包含多个级别的日志记录：`WL.Logger.info`、`WL.Logger.debug` 和 `WL.Logger.error`。

> 有关更多信息，请参阅用户文档 API 参考部分中的 `WL.Logger` 文档。

**检查日志：**

* **Developer console**，在使用模拟器或仿真器预览平台时。
* **LogCat**，在 Android 设备上运行时
* **XCode Console**，在 iOS 设备上运行时
* **Visual Studio Output**，在 Windows 设备上运行时。

### 使用 WireShark 进行调试
{: #debugging-with-wireshark }
**Wireshark 是一个网络协议分析器**，可用于查看网络中发生的事件。  
您可以使用过滤器来仅了解所需事项。  

> 有关更多信息，请参阅 [WireShark](http://www.wireshark.org) Web 站点。

![Wireshark](wireshark.png)
