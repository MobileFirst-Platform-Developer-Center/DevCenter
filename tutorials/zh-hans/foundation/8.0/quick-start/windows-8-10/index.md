---
layout: tutorial
title: Windows 8.1 Universal 和 Windows 10 UWP 端到端演示
breadcrumb_title: Windows
relevantTo: [windows]
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
本演示的目的是展示端到端流程：

1. 在 {{ site.data.keys.mf_console }} 中注册并下载与 {{ site.data.keys.product_adj }} 客户机 SDK 预捆绑的样本应用程序。
2. 将新的或提供的适配器部署到 {{ site.data.keys.mf_console }}。  
3. 应用程序逻辑更改为发出资源请求。

**最终结果**：

* 成功 ping {{ site.data.keys.mf_server }}。
* 成功地使用适配器检索数据。

#### 先决条件：
{: #prerequisites }
* 已配置 Visual Studio 2013/5
* *可选*。{{ site.data.keys.mf_cli }}（[下载]({{site.baseurl}}/downloads)）
* *可选*。单机{{ site.data.keys.mf_server }}（[下载]({{site.baseurl}}/downloads)）

### 1. 启动 {{ site.data.keys.mf_server }}
{: #1-starting-the-mobilefirst-server }
确保您已[创建 Mobile Foundation 实例](../../bluemix/using-mobile-foundation)，或者  
如果使用 [{{ site.data.keys.mf_dev_kit }}](../../installation-configuration/development/mobilefirst)，请导航至服务器的文件夹并运行命令 `./run.cmd`。

### 2. 创建应用程序
{: #2-creating-an-application }
在浏览器窗口中，通过加载以下 URL 打开 {{ site.data.keys.mf_console }}：`http://your-server-host:server-port/mfpconsole`。如果是本地运行，请使用：[http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole)。用户名/密码为 *admin/admin*。

1. 单击**应用程序**旁的**新建**按钮
    * 选择 **Windows** 平台
    * 将 **MFPStarterCSharp.Windows** 输入为**应用程序标识**（对于 Windows），或输入 **MFPStarterCSharp.WindowsPhone**（对于 Windows Phone）
    * 将 **1.0.0** 输入为**版本**值
    * 单击**注册应用程序**

    <img class="gifplayer" alt="注册应用程序" src="register-an-application-windows.png"/>

2. 单击**获取起动器代码**磁贴，并选择下载 Windows 8.1 或 Windows 10 样本应用程序。

    <img class="gifplayer" alt="下载样本应用程序" src="download-starter-code-windows.png"/>

### 3. 编辑应用程序逻辑
{: #3-editing-application-logic }
1. 打开 Visual Studio 项目。

2. 选择解决方案的 **MainPage.xaml.cs** 文件，并将以下代码片段粘贴到 GetAccessToken() 方法：

   ```csharp
   try
                   {
       
                       IWorklightClient _newClient = WorklightClient.CreateInstance();
          accessToken = await _newClient.AuthorizationManager.ObtainAccessToken("");
          if (accessToken.IsValidToken &&  accessToken.Value != null &&  accessToken.Value != "")
          {
              System.Diagnostics.Debug.WriteLine("Received the following access token value: " + accessToken.Value);
              titleTextBlock.Text = "Yay!";
              statusTextBlock.Text = "Connected to {{ site.data.keys.mf_server }}";

              Uri adapterPath = new Uri("/adapters/javaAdapter/resource/greet",UriKind.Relative);
              WorklightResourceRequest request = _newClient.ResourceRequest(adapterPath, "GET","");
              request.SetQueryParameter("name", "world");
              WorklightResponse response = await request.Send();

              System.Diagnostics.Debug.WriteLine("Success: " + response.ResponseText);

            }
        }
        catch (Exception e)
        {
            titleTextBlock.Text = "Uh-oh";
            statusTextBlock.Text = "Client failed to connect to {{ site.data.keys.mf_server }}";
            System.Diagnostics.Debug.WriteLine("An error occurred: '{0}'", e);
        }
   ```


### 4. 部署适配器
{: 4-deploy-an-adapter }
下载[这一准备好的适配器工件](../javaAdapter.adapter)，并通过**操作 → 部署适配器**操作从 {{ site.data.keys.mf_console }} 进行部署。

<!-- Alternatively, click the **New** button next to **Adapters**.  

1. Select the **Actions → Download sample** option. Download the "Hello World" **Java** adapter sample.

    > If Maven and {{ site.data.keys.mf_cli }} are not installed, follow the on-screen **Set up your development environment** instructions.

2. From a **Command-line** window, navigate to the adapter's Maven project root folder and run the command:

    ```bash
    mfpdev adapter build
    ```

3. When the build finishes, deploy it from the {{ site.data.keys.mf_console }} using the **Actions → Deploy adapter** action. The adapter can be found in the **[adapter]/target** folder.

    <img class="gifplayer" alt="Deploy an adapter" src="create-an-adapter.png"/>    -->

<img src="windowsQuickStart.png" alt="样本应用程序" style="float:right"/>
### 5. 测试应用程序
{: 5-testing-the-application }
1. 在 Visual Studio 中，选择 **mfpclient.resw** 文件并将 **protocol**、**host** 和 **port** 属性编辑为针对 {{ site.data.keys.mf_server }} 的正确的值。
    * 如果使用本地 {{ site.data.keys.mf_server }}，这些值通常是 **http**、 **localhost** 和 **9080**。
    * 如果使用远程 {{ site.data.keys.mf_server }}（在 Bluemix 中），这些值通常是 **https**、**your-server-address** 和 **443**。

    或者，如果已安装 {{ site.data.keys.mf_cli }}，那么导航至项目根文件夹并运行命令 `mfpdev app register`。如果使用远程 {{ site.data.keys.mf_server }}，[那么运行命令 `mfpdev server add`](../../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance) 来添加服务器，后跟（例如）`mfpdev app register myBluemixServer`。

2. 按**运行应用程序**按钮。

### 结果
{: #results }
* 单击 **Ping {{ site.data.keys.mf_server }}** 按钮将显示**已连接到 {{ site.data.keys.mf_server }}**。
* 如果应用程序能够连接到 {{ site.data.keys.mf_server }}，那么将使用部署的 Java 适配器进行资源请求调用。

然后，适配器响应将列显在 Visual Studio 的 Outpout 控制台中。

![成功从 {{ site.data.keys.mf_server }} 调用了资源的应用程序的图像](success_response.png)

## 后续步骤
{: #next-steps }
要了解有关在应用程序中使用适配器，如何集成附加服务（如推送通知），使用 {{ site.data.keys.product_adj }} 安全框架及其他内容的更多信息，请：

- 查看[应用程序开发](../../application-development/)教程
- 查看[适配器开发](../../adapters/)教程
- 查看[认证和安全教程](../../authentication-and-security/)
- 查看[通知教程](../../notifications/)
- 查看[所有教程](../../all-tutorials)
