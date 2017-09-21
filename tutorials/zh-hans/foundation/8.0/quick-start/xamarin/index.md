---
layout: tutorial
title: Xamarin 端到端演示
breadcrumb_title: Xamarin
relevantTo: [xamarin]
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
本演示的目的是展示端到端流程：

1. 在 {{ site.data.keys.mf_console }} 中注册与 {{ site.data.keys.product_adj }} Xamarin 客户机 SDK 捆绑的样本应用程序。
2. 将新的或提供的适配器部署到 {{ site.data.keys.mf_console }}。  
3. 应用程序逻辑更改为发出资源请求。

**最终结果**：

* 成功 ping {{ site.data.keys.mf_server }}。

#### 先决条件：
{: #prerequisites }
* Xamarin Studio
* *可选*。单机{{ site.data.keys.mf_server }}（[下载]({{site.baseurl}}/downloads)）

### 1. 启动 {{ site.data.keys.mf_server }}
{: #1-starting-the-mobilefirst-server }
确保您已[创建 Mobile Foundation 实例](../../bluemix/using-mobile-foundation)，或者  
如果使用 [{{ site.data.keys.mf_dev_kit }}](../../installation-configuration/development/)，请导航至服务器的文件夹并运行命令 `./run.sh`（在 Mac 和 Linux 中）或 `run.cmd`（在 Windows 中）。

### 2. 创建应用程序
{: #2-creating-an-application }
在浏览器窗口中，通过加载以下 URL 打开 {{ site.data.keys.mf_console }}：`http://your-server-host:server-port/mfpconsole`。如果是本地运行，请使用：[http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole)。用户名/密码为 *admin/admin*。

1. 单击**应用程序**旁的**新建**按钮
    * 选择 **Android** 平台
    * 将 **com.ibm.mfpstarterxamarin** 输入为**应用程序标识**（取决于您在下一步中下载的应用程序框架）
    * 将 **1.0** 输入为**版本**值
    * 单击**注册应用程序**

    <img class="gifplayer" alt="注册应用程序" src="register-an-application-xamarin.gif"/>

### 3. 编辑应用程序逻辑
{: #3-editing-application-logic }
* 创建一个 Xamarin 项目。
* 按[添加 SDK](../../application-development/sdk/xamarin/) 教程中所述添加 Xamarin SDK。
* 按如下所示，在任何类文件中添加一个类型为 `IWorklightClient` 的属性。

   ```csharp
   /// <summary>
   /// Gets or sets the worklight sample client.
   /// </summary>
   /// <value>The worklight client.</value>
   public static IWorklightClient WorklightClient {get; set;}
   ```
* 如果您正在 iOS 环境下进行开发，请将以下代码粘贴到 **AppDelegate.cs** 文件的 **FinishedLaunching** 方法中：

  ```csharp
   <ClassName>.WorklightClient = WorklightClient.CreateInstance();
  ```
  >将 `<ClassName>` 替换为您的类名。
* 如果您正在 Android 环境下进行开发，请在 **MainActivity.cs** 文件的 **OnCreate** 方法中包含以下代码行：

  ```csharp
   <ClassName>.WorklightClient = WorklightClient.CreateInstance(this);
  ```
  >将 `<ClassName>` 替换为您的类名。
* 定义一个方法来获取访问标记并向 MFP Server 发出资源请求，如下所示。

    ```csharp
    public async void ObtainToken()
           {
            try
                   {
       
                       IWorklightClient _newClient = App.WorklightClient;
                       WorklightAccessToken accessToken = await _newClient.AuthorizationManager.ObtainAccessToken("");
       
                       if (accessToken.Value != null &&  accessToken.Value != "")
                       {
                           System.Diagnostics.Debug.WriteLine("Received the following access token value: " + accessToken.Value);
                           StringBuilder uriBuilder = new StringBuilder().Append("/adapters/javaAdapter/resource/greet");
       
                           WorklightResourceRequest request = _newClient.ResourceRequest(new Uri(uriBuilder.ToString(), UriKind.Relative), "GET");
                           request.SetQueryParameter("name", "world");
                           WorklightResponse response = await request.Send();
       
                           System.Diagnostics.Debug.WriteLine("Success: " + response.ResponseText);
                       }
                   }
                   catch (Exception e)
                   {
                       System.Diagnostics.Debug.WriteLine("An error occurred: '{0}'", e);
                   }
               }
           }
    }
   ```

* 在类构造函数中调用 **ObtainToken** 方法，或者通过单击某个按钮来调用。

### 4. 部署适配器
{: #4-deploy-an-adapter }
下载 [此准备好的 .adapter 工件](../javaAdapter.adapter)，然后在 {{ site.data.keys.mf_console }} 中使用 **操作 → 部署适配器** 操作进行部署。
或者，单击 **适配器** 旁边的 **新建** 按钮。

1. 选择 **操作 → 下载样本** 选项。下载“Hello World”**Java** 适配器样本。

   > 如果未安装 Maven 和 {{ site.data.keys.mf_cli }}，请遵循屏幕上的 **设置开发环境** 指示信息。
2. 从 **命令行** 窗口中，导航至适配器的 Maven 项目根文件夹并运行以下命令：
```bash
   mfpdev adapter build
   ```

3. 构建完成后，在 {{ site.data.keys.mf_console }} 中通过 **操作 → 部署适配器** 操作进行部署。适配器可在 **[adapter]/target** 文件夹中找到。

   <img class="gifplayer" alt="部署适配器" src="create-an-adapter.png"/>

<!-- <img src="device-screen.png" alt="样本应用程序" style="float:right"/>-->
### 5. 测试应用程序
{: #5-testing-the-application }
1. 在 Xamarin Studio 中，选择 `mfpclient.properties` 文件并使用 {{ site.data.keys.mf_server }} 的正确值来编辑 **protocol**、**host** 和 **port** 属性。
    * 如果使用本地 {{ site.data.keys.mf_server }}，这些值通常是 **http**、**localhost** 和 **9080**。
    * 如果使用远程 {{ site.data.keys.mf_server }}（在 Bluemix 中），这些值通常是 **https**、**您的服务器地址** 和 **443**。
2. 按 **播放** 按钮。

<br clear="all"/>
### 结果
{: #results }
* 单击 **Ping MobileFirst 服务器** 按钮将显示 **已连接到 MobileFirst 服务器**。
* 如果应用程序能够连接到 {{ site.data.keys.mf_server }}，那么将使用部署的 Java 适配器进行资源请求调用。

然后，适配器响应将列显在 Xamarin Studio 控制台中。
![成功从 {{ site.data.keys.mf_server }} 调用了资源的应用程序的图像](console-output.png)
## 下一步
{: #next-steps }
要详细了解有关在应用程序中使用适配器，如何集成附加服务（如推送通知），使用 {{ site.data.keys.product_adj }} 安全框架及其他内容，请：

- 查看 [适配器开发](../../adapters/) 教程
- 查看 [认证和安全教程](../../authentication-and-security/)
- 查看 [所有教程](../../all-tutorials)
