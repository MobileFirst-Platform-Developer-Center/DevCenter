---
layout: tutorial
title: 迁移现有的 Windows 应用程序
breadcrumb_title: Windows
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
要迁移使用 IBM MobileFirst™ Platform Foundation V6.2.0 或更高版本创建的现有本机 Windows 项目，必须修改此项目以使用当前版本中的 SDK。 然后，替换 V8.0 中停用或不包含的客户端 API。 迁移辅助工具可扫描您的代码并生成要替换的 API 的报告。

#### 跳至：
{: #jump-to }
* [扫描现有 {{ site.data.keys.product_adj }} 本机 Windows 应用程序以准备版本升级](#scanning-existing-mobilefirst-native-windows-apps-to-prepare-for-a-version-upgrade)
* [迁移 Windows 项目](#migrating-a-windows-project)
* [更新 Windows 代码](#updating-the-windows-code)

## 扫描现有 {{ site.data.keys.product_adj }} 本机 Windows 应用程序以准备版本升级
{: #scanning-existing-mobilefirst-native-windows-apps-to-prepare-for-a-version-upgrade }
迁移辅助工具可帮助您准备通过 IBM MobileFirst™ Platform Foundation 先前版本创建的应用程序以执行迁移，方法是扫描本机 Windows 应用程序的源文件并生成 V8.0 中不推荐使用或停用的 API 的报告。

使用迁移辅助工具之前，务必了解以下信息：

* 您必须具有现有 IBM MobileFirst Platform Foundation 本机 Windows 应用程序。
* 您必须具有因特网访问权。
* 您必须已安装 node.js V4.0.0 或更高版本。
* 查看并了解迁移过程的限制。 有关更多信息，请参阅[从较早发行版迁移应用程序](../)。

对于使用 IBM MobileFirst Platform Foundation 的先前版本创建的应用程序，在未进行一些更改的情况下在 V8.0 中不受支持。 迁移辅助工具通过扫描现有本机 Windows 应用程序中的源文件，识别 V8.0 中不推荐使用、不再支持或修改的 API，从而简化此过程。

迁移辅助工具不会修改或移动应用程序的任何开发人员代码或注释。

1. 通过使用以下其中一种方法下载迁移辅助工具：
    * 从 [Git 存储库](https://git.ng.bluemix.net/ibmmfpf/mfpmigrate-cli)下载 .tgz 文件。
    * 从 {{ site.data.keys.mf_console }} 下载 {{ site.data.keys.mf_dev_kit }}，其中包含名为 mfpmigrate-cli.tgz 的迁移辅助工具文件。
2. 安装迁移辅助工具。
    * 切换到下载工具的目录。
    * 通过输入以下命令，使用 NPM 安装该工具：

   ```bash
   npm install -g
   ```

3. 通过输入以下命令来扫描 IBM MobileFirst Platform Foundation 应用程序：

   ```bash
   mfpmigrate scan --in source_directory --out destination_directory --type windows
   ```

   **source_directory**  
   项目的当前位置。

   **destination_directory**  
   创建报告的目录。

   与 scan 命令一起使用时，迁移辅助工具会识别现有 IBM MobileFirst Platform Foundation 应用程序中在 V8.0 中已除去、不推荐使用或更改的 API，并将它们保存在确定的目标目录中。

## 迁移 Windows 项目
{: #migrating-a-windows-project }
要使用通过 IBM MobileFirst™ Platform Foundation V6.2.0 或更高版本创建的现有本机 Windows 项目，必须修改该项目。

MobileFirst V8.0 仅支持 Windows Universal 环境，即 Windows 10 Universal Windows Platform (UWP) 和 Windows 8 Universal（台式机和手机）。 不支持 Windows Phone 8 Silverlight。

您可以手动将 Visual Studio 项目升级到 V8.0。 {{ site.data.keys.product_adj }} V8.0 针对 Visual Studio SDK 引入的一些更改可能需要更改在先前版本中开发的应用程序。 有关已更改的 API 的信息，请参阅[更新 Windows 代码](#updating-the-windows-code)。

1. 将 {{ site.data.keys.product_adj }} SDK 更新至 V8.0。
    * 手动除去 MobileFirst SDK 包。 这包括除去 **wlclient.properties** 文件以及下列引用：
        * Newtonsoft.Json
        * SharpCompress
        * worklight-windows8

        > **注：**如果您的应用程序使用应用程序真实性或扩展真实性功能，那么必须添加 Microsoft Visual C++ 2013 Runtime Package
for Windows 或 Microsoft Visual C++ 2013 Runtime Package
for Windows Phone 作为对应用程序的引用。要执行此操作，请在 Visual Studio 中，右键单击本机项目的引用，然后根据已将哪个环境添加到本机 API 应用程序来完成以下选项之一：

        * 对于 Windows 台式机和平板电脑：右键单击**引用 → 添加引用 → Windows 8.1 → 扩展 → Microsoft Visual C++ 2013 Runtime Package for Windows → 确定**。
        * 对于 Windows Phone 8 Universal：右键单击**引用 → 添加引用 → Windows 8.1 → 扩展 → Microsoft Visual C++ 2013 Runtime Package for Windows Phone → 确定**。
        * 对于 Windows 10 Universal Windows Platform (UWP)：右键单击**引用 → 添加引用 → Windows 8.1 → 扩展 → Microsoft Visual C++ 2013 Runtime Package for Windows Universal → 确定**。
    * 通过 NuGet 添加 {{ site.data.keys.product_adj }} V8.0.0 SDK 包。 请参阅[使用 NuGet 添加 {{ site.data.keys.product_adj }} SDK](../../../application-development/sdk/windows-8-10)。
2. 将应用程序代码更新为使用 {{ site.data.keys.product_adj }} V8.0.0 API。
    * 对于先前发行版，Windows API 是 **IBM.Worklight.namespace** 的一部分。 这些 API 现已过时并替换为等效的 **WorklightNamespace** API。 您需要修改应用程序，以将对 **IBM.Worklight.namespace** 的所有引用替换为 **WorklightNamespace** 中的对应等效项。

   例如，以下片段是使用示例：

   ```csharp
   WLResourceRequest request = new WLResourceRequest
                            (new Uri(uriBuilder.ToString()), "GET", "accessRestricted");
                            request.send(listener);
   ```

   使用新 API 更新的片段将是：

   ```csharp
   WorklightResourceRequest request = newClient.ResourceRequest
                            (new Uri(uriBuilder.ToString(), UriKind.Relative), "GET", "accessRestricted");
                            WorklightResponse response = await request.Send();
   ```

    * 所有执行异步操作的方法先前都使用响应侦听器回调模型。 这些方法已替换为 **await/async** 模型。

现在，您可以开始使用 {{ site.data.keys.product_adj }} SDK 来开发本机 Windows 应用程序。 您可能需要更新代码来反映 {{ site.data.keys.product_adj }} V8.0.0 API 更改。

#### 后续步骤
{: #what-to-do-next }
替换 V8.0 中停用或不包含的客户端 API。

## 更新 Windows 代码
{: #updating-the-windows-code }
{{ site.data.keys.product }} V8.0 针对 Windows SDK 引入的一些更改可能需要更改在先前版本中开发的应用程序。

#### 不推荐使用的 Windows C# API 类
{: #deprecated-windows-c-api-classes }

| 类别 | 描述 | 推荐操作 |
|----------|-------------|--------------------|
| `ChallengeHandler`  | 对于定制网关验证问题，请使用 `GatewayChallengeHandler`。 对于 {{ site.data.keys.product_adj }} 安全性检查验证问题，请使用 `SecurityCheckChallengeHandler`。 |
| `ChallengeHandler`, `isCustomResponse()`  | 使用 `GatewayChallengeHandler.canHandleResponse()。` |
| `ChallengeHandler.submitAdapterAuthentication` | 在验证问题处理程序中实施类似逻辑。 对于定制网关验证问题处理程序，请使用 `GatewayChallengeHandler`。 对于 {{ site.data.keys.product_adj }} 安全性检查验证问题处理程序，请使用 `SecurityCheckChallengeHandler`。 |
| `ChallengeHandler.submitFailure(WLResponse wlResponse)` 对于定制网关验证问题处理程序，请使用 `GatewayChallengeHandler.Shouldcancel()`。 对于 {{ site.data.keys.product_adj }} 安全性检查验证问题处理程序，请使用 `SecurityCheckChallengeHandler.ShouldCancel()`。 |
| `WLAuthorizationManager` | 改用 `WorklightClient.WorklightAuthorizationManager`。 |
| `WLChallengeHandler` | 使用 `SecurityCheckChallengeHandler`。  |
| `WLChallengeHandler.submitFailure(WLResponse wlResponse)`  | 	使用 `SecurityCheckChallengeHandler.ShouldCancel()`。 |
| `WLClient` | 	改用 `WorklightClient`。 |
| `WLErrorCode` | 	不受支持。 |
| `WLFailResponse` | 	改用 `WorklightResponse`。 |
| `WLResponse` | 改用 `WorklightResponse`。 |
| `WLProcedureInvocationData` | 改用 `WorklightProcedureInvocationData`。 |
| `WLProcedureInvocationFailResponse` | 	不受支持。 |
| `WLProcedureInvocationResult` | 	不受支持。 |
| `WLRequestOptions` | 	不受支持。 |
| `WLResourceRequest` | 	改用 `WorklightResourceRequest`。 |

#### 不推荐使用的 Windows C# API 接口
{: #deprecated-windows-c-api-interfaces }

| 类别 | 描述 | 推荐操作 |
|----------|-------------|--------------------|
| `WLHttpResponseListener` | 不受支持。 |
| `WLResponseListener` | 响应将可用作 `WorklightResponse` 对象 |
| `WLAuthorizationPersistencePolicy` | 不受支持。 |
