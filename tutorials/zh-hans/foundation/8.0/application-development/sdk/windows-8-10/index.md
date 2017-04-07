---
layout: tutorial
title: 将 MobileFirst Foundation SDK 添加到 Windows 8.1 Universal 或 Windows 10 UWP 应用程序
breadcrumb_title: Windows
relevantTo: [windows]
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
{{ site.data.keys.product }} SDK 包含通过 [Nuget](https://www.nuget.org/) 可用并且可添加到 Visual Studio 项目的依赖关系集合。依赖关系与核心函数和其他函数对应：

* **IBMMobileFirstPlatformFoundation** - 实现客户机到服务器连接，并处理认证和安全方面、资源请求及其他必需的核心函数。

在此教程中，了解如何使用 Nuget 将 {{ site.data.keys.product_adj }} 本机 SDK 添加到新的或现有的 Windows 8.1 Universal 应用程序或 Windows 10 UWP (Universal Windows Platform) 应用程序。您还可以了解如何配置 {{ site.data.keys.mf_server }} 以识别应用程序，查找有关添加到项目的 {{ site.data.keys.product_adj }} 配置文件的信息。

**先决条件：**

- Microsoft Visual Studio 2013 或 2015 和 {{ site.data.keys.mf_cli }} 已安装在开发人员工作站上。开发 Windows 10 UWP 解决方案至少需要 Visual Studio 2015。
- {{ site.data.keys.mf_server }} 的本地或远程实例正在运行。
- 阅读[设置您的 {{ site.data.keys.product_adj }} 开发环境](../../../installation-configuration/development/mobilefirst)和[设置您的 Windows 8 Universal 和 Windows 10 UWP 开发环境](../../../installation-configuration/development/windows)教程。

#### 跳转至：
{: #jump-to }
- [添加 {{ site.data.keys.product_adj }} 本机 SDK](#adding-the-mobilefirst-native-sdk)
- [手动添加 {{ site.data.keys.product_adj }} 本机 SDK](#manually-adding-the-mobilefirst-win-native-sdk)
- [更新 {{ site.data.keys.product_adj }} 本机 SDK](#updating-the-mobilefirst-native-sdk)
- [已生成 {{ site.data.keys.product_adj }} 本机 SDK 工件](#generated-mobilefirst-native-sdk-artifacts)
- [接下来要学习的教程](#tutorials-to-follow-next)

## 添加 {{ site.data.keys.product_adj }} 本机 SDK
{: #adding-the-mobilefirst-native-sdk }
遵循下面的指示信息将 {{ site.data.keys.product_adj }} 本机 SDK 添加到新的或现有的 Visual Studio 项目，以将应用程序注册到 {{ site.data.keys.mf_server }}。

在您开始之前，确保 {{ site.data.keys.mf_server }} 实例正在运行。  
如果使用本地安装的服务器：从**命令行**窗口，浏览至服务器的文件夹，并运行命令：`./run.cmd`。

### 创建应用程序
{: #creating-an-application }
使用 Visual Studio 2013/2015 创建 Windows 8.1 Universal 或 Windows 10 UWP 项目，或者使用现有项目。  

### 添加 SDK
{: #adding-the-sdk }
1. 要导入 {{ site.data.keys.product_adj }} 软件包，请使用 NuGet 软件包管理器。NuGet 是 Microsoft 开发平台（包括 .NET）的软件包管理器。NuGet 客户机工具能够生成和使用软件包。NuGet Gallery 是所有软件包作者和用户所使用的中央软件包存储库。

2. 在 Visual Studio 2013/2015 中打开 Windows 8.1 Universal 或 Windows 10 UWP 项目。右键单击项目解决方案，然后选择**管理 Nuget 软件包**。

    ![Add-Nuget-tosolution-VS-settings](Add-Nuget-tosolution0.png)

3. 在搜索选项中，搜索“IBM MobileFirst 平台”。选择 **IBM.MobileFirstPlatform.{{ site.data.keys.product_V_R_M_I }}**。

    ![Add-Nuget-tosolution-search](Add-Nuget-tosolution1.png)

    ![Add-Nuget-tosolution-choose](Add-Nuget-tosolution2.png)

4. 单击**安装**。此操作将安装 {{ site.data.keys.product }} 本机 SDK 及其依赖关系。此步骤还将在 Visual Studio 项目的 `strings` 文件夹中生成空 `mfpclient.resw` 文件。

5. 确保至少在 `Package.appxmanifest` 中启用以下功能：

    - 因特网（客户机）

### 手动添加 {{ site.data.keys.product_adj }} 本机 SDK
{: #manually-adding-the-mobilefirst-win-native-sdk }

您还可以手动添加 {{ site.data.keys.product }} SDK：

<div class="panel-group accordion" id="adding-the-win-sdk" role="tablist" aria-multiselectable="false">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="win-sdk">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#win-sdk" data-target="#collapse-win-sdk" aria-expanded="false" aria-controls="collapse-win-sdk"><b>单击以获取指示信息</b></a>
            </h4>
        </div>

        <div id="collapse-win-sdk" class="panel-collapse collapse" role="tabpanel" aria-labelledby="win-sdk">
            <div class="panel-body">
                <p>可以通过手动获取框架和库文件，准备用于开发 MobileFirst 应用程序的环境。NuGet 还提供 {{ site.data.keys.product }} SDK for Windows 8 和 Windows 10 Universal Windows Platform (UWP)。</p>

                <ol>
                    <li>从 {{ site.data.keys.mf_console }} → 下载中心 → SDK</b> 选项卡获得 {{ site.data.keys.product }}SDK<b>。</li>
                    <li>解压缩通过步骤 1 下载的 SDK 的内容。</li>
                    <li>在 Visual Studio 中打开 Windows Universal 本机项目。执行以下步骤。<ol>
                            <li>选择<b>工具 → NuGet Package Manager → 软件包管理器设置</b>。</li>
                            <li>选择<b>软件包源</b>选项。单击 <b>+</b> 图标以添加新的软件包源。</li>
                            <li>提供软件包源的名称（例如<em>windows8nuget</em>）</li>
                            <li>导航至已下载并解压缩的 MobileFirst SDK 文件夹。单击<b>确定</b>。</li>
                            <li>单击<b>更新</b>，然后单击<b>确定</b>。</li>
                            <li>右键单击<b>解决方案资源管理器</b>选项卡中的<b>解决方案项目名称</b>（位于屏幕右侧）。</li>
                            <li>选择<b>管理解决方案的 NuGet 软件包 → 联机 → windows8nuget</b>。</li>
                            <li>单击<b>安装</b>选项。这样会显示<b>选择项目</b>选项。</li>
                            <li>确保选中所有复选框。单击<b>确定</b>。</li>
                        </ol>

                    </li>
                </ol>

                <br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#win-sdk" data-target="#collapse-win-sdk" aria-expanded="false" aria-controls="collapse-win-sdk"><b>结束部分</b></a>
            </div>
        </div>
    </div>
</div>

### 注册应用程序
{: #reigstering-the-application }
1. 打开**命令行**并浏览至 Visual Studio 项目的根目录。  

2. 运行以下命令：

   ```bash
   mfpdev app register
   ```
    - 如果使用远程服务器，请[使用命令 `mfpdev server add`](../../using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance) 进行添加。

`mfpdev app register` CLI 命令将先连接到 {{ site.data.keys.mf_server }} 以注册应用程序，然后更新 Visual Studio 项目内 **strings** 文件夹中的 **mfpclient.resw** 文件，并向该文件添加用来标识 {{ site.data.keys.mf_server }} 的元数据。

> <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> **提示：**您还可以从 {{ site.data.keys.mf_console }} 注册应用程序：    
>
> 1. 装入 {{ site.data.keys.mf_console }}。  
> 2. 单击**应用程序**旁边的**新建**按钮以注册新应用程序，并遵循屏幕上的指示信息。  
> 3. 注册应用程序之后，浏览至应用程序的**配置文件**选项卡，然后复制或下载 **mfpclient.resw** 文件。遵循屏幕上的指示信息将此文件添加到您的项目。

## 更新 {{ site.data.keys.product_adj }} 本机 SDK
{: #updating-the-mobilefirst-native-sdk}

要使用最新发行版更新 {{ site.data.keys.product_adj }} 本机 SDK，请在**命令行**窗口中从 Visual Studio 项目的根文件夹运行以下命令：

```bash
Nuget update
```

## 已生成 {{ site.data.keys.product_adj }} 本机 SDK 工件
{: #generated-mobilefirst-native-sdk-artifacts}

### mfpclient.resw
{: #mfpclientresw }
此文件位于项目的 `strings` 文件夹中，包含服务器连接属性，并且用户可编辑：

- `protocol` – {{ site.data.keys.mf_server }} 的通信协议。`HTTP` 或 `HTTPS`。
- `WlAppId` - 应用程序的标识。这应该与服务器中的应用程序标识相同。
- `host` – {{ site.data.keys.mf_server }} 实例的主机名。
- `port` – {{ site.data.keys.mf_server }} 实例的端口。
- `wlServerContext` – {{ site.data.keys.mf_server }} 实例上应用程序的上下文根路径。
- `languagePreference` - 为客户机 sdk 系统消息设置缺省语言。

## 接下来要学习的教程
{: #tutorials-to-follow-next}

集成 MobileFirst 本机 SDK 之后，您现在可以：

- 查看[使用 {{ site.data.keys.product }} SDK 教程](../)
- 查看[适配器开发教程](../../../adapters/)
- 查看[认证和安全教程](../../../authentication-and-security/)
- 查看[通知教程](../../../notifications/)
- 查看[所有教程](../../../all-tutorials)
