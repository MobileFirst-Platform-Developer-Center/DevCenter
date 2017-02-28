---
layout: tutorial
title: 针对 Apple watchOS 开发
breadcrumb_title: watchOS 2 和 watchOS 3
relevantTo: [ios]
weight: 13
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
在此示例中，您将了解如何使用 {{ site.data.keys.product_adj }} 框架为 watchOS 2 和更高版本设置开发环境。将使用 watchOS 2 创建和描述示例。在 watchOS 3 上也可以正常工作。

## 设置
{: #setup }
要为 watchOS 设置开发环境，请创建 Xcode 项目，添加 watchOS 框架，然后设置必需的目标。

1. 在 Xcode 中创建 watchOS 2 应用程序。
    * 选择**文件 → 新建 → 项目**选项；将显示**为您的新项目选择模板**对话框。
    * 选择 **watchOS2/应用程序**选项，单击**下一步**。
    * 为此项目命名，然后单击**下一步**。
    * 从导航对话框中选择项目文件夹。

    项目导航树现在包含主要应用程序文件夹以及 **[project name] WatchKit Extension** 文件夹和目标。

    ![Xcode 中的 WatchOS 项目](WatchOSProject.jpg)

2. 添加 {{ site.data.keys.product_adj }} watchOS 框架。
    * 要使用 CocoaPods 安装必需的框架，请参阅[添加 {{ site.data.keys.product_adj }} 本机 SDK](../../application-development/sdk/ios/#adding-support-for-apple-watchos) 教程。
    * 要手动安装必需的框架：
        * 从 {{ site.data.keys.mf_console }} 的下载中心获取 watchOS 框架。
        * 在左侧导航窗格中选择 **[project name] WatchKit Extension** 文件夹。
        * 从**文件**菜单中选择**添加文件**。
        * 单击**选项**按钮并选择以下项：
            * **根据需要复制项目**和**创建组**选项。
            * **添加到目标**部分中的 **[project name] WatchKit Extension**。
        * 单击 **添加**。

        现在，当您在**目标**部分中选择 **[project name] WatchKit Extension** 时：
            * 框架路径将显示在**构建设置**选项卡的**搜索路径**部分内的**框架搜索路径**设置中。
            * **构建阶段**选项卡的**将二进制文件与库进行链接**部分将列出 **IBMMobileFirstPlatformFoundationWatchOS.framework** 文件：![watchOS 已链接的框架](watchOSlinkedframeworks.jpg)

        > **注：**WatchOS 2 需要位码。从 Xcode 7 开始，将**构建选项**设置为**启用位码**（**构建设置**选项卡，**构建选项**部分）。
3. 在服务器上注册主要应用程序和 WatchKit 扩展。对每个捆绑软件标识运行 `mfpdev app register`（或者从 {{ site.data.keys.mf_console }} 注册）：
    * com.worklight.[project_name]
    * com.worklight.[project_name].watchkitextension

4. 在 Xcode 中，从“文件->添加文件”菜单，浏览至通过 mfpdev 创建的 mfpclient.plist 文件，并将其添加到项目。
    * 选择此文件以显示**目标成员资格**框。除 **WatchOSDemoApp** 之外，选择 **WatchOSDemoApp WatchKit Extension** 目标。

Xcode 项目现在包含一个主要应用程序和一个 watchOS 2 应用程序，每个应用程序都可以单独开发。对于 Swift，watchOS 2 应用程序的入口点为 **[project name] watchKit Extension** 文件夹中的 **InterfaceController.swift** 文件。对于 Objective-C，入口点为 **ViewController.m** 文件。

## 为 iPhone 应用程序和 watchOS 应用程序设置 {{ site.data.keys.product_adj }} 安全性
{: #setting-up-mobilefirst-security-for-the-iphone-app-and-the-watchos-app }
Apple Watch 和 iPhone 设备在物理上不同。因此，针对各设备的安全检查必须适合可用的输入设备。例如，Apple Watch 限于数字板，不允许通常的用户名/密码安全性检查。因此，可以使用 pin 码启用对服务器上受保护资源的访问权。由于这些差异及类似差异，需要对每个目标应用不同的安全性检查。

以下是使用 iPhone 和 Apple Watch 目标创建应用程序的一个示例。此体系结构允许各目标具有自己的安全性检查。不同的安全性检查仅仅是可以如何为每个目标设计功能的示例。可能有其他安全性检查可用。

1. 确定由受保护资源定义的范围和安全性检查。
2. 在 {{ site.data.keys.mf_console }} 中：
    * 确保两个应用程序都已在服务器上注册：
        * com.worklight.[project_name]
        * com.worklight.[project_name].watchkitextension
    * 将 scopeName 映射到已定义的安全性检查：
        * 对于 com.worklight.[project_name]，将其映射到用户名/密码检查。
        * 对于 com.worklight.[project_name].watchkitapp.watchkitextension，将其映射到 pin 码安全性检查。

## WatchOS 限制
{: #watchos-limitation }
没有为 watchOS 开发提供用于向 {{ site.data.keys.product_adj }} 应用程序添加功能的可选框架。一些其他功能受 watchOS 或 Apple Watch 设备施加的约束限制。

| 功能 | 限制 |
|---------|------------|
| openSSL | 不受支持 |
| JSONStore| 不受支持 |
| 通知 | 不受支持 |
| {{ site.data.keys.product_adj }} 代码显示的消息警报 | 不受支持 |
| 应用程序真实性验证 | 与位码不兼容，因此不受支持 |
| 远程禁用/通知	| 需要定制（见下文） |
| 用户名/密码安全性检查 | 使用 CredentialsValidation 安全性检查 |

### 远程禁用/通知
{: #remote-disablenotify }
您可以使用 {{ site.data.keys.mf_console }} 配置 {{ site.data.keys.mf_server }}，以根据正在运行的版本禁用对客户机应用程序的访问权并返回消息（请参阅[远程禁用应用程序对受保护资源的访问权](../../administering-apps/using-console/#remotely-disabling-application-access-to-protected-resources)）。两个选项提供缺省 UI 警报：

* 当应用程序处于活动状态但发送消息时：**活动并且正在通知**
* 当应用程序过时并且访问被拒绝时：**拒绝访问**

对于 watchOS：

* 要查看将应用程序设置为**活动并且正在通知**的消息，必须实施和注册定制远程禁用验证问题处理程序。必须使用安全性检查 `wl_remoteDisableRealm` 初始化定制验证问题处理程序。
* 在禁用访问（**拒绝访问**）情况下，客户机应用程序将在故障回调或请求委派处理程序中收到错误消息。开发人员可以决定如何处理错误，通过 UI 通知用户或者写入日志。此外，还可以使用上述创建定制验证问题处理程序的方法。
