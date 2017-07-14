---
layout: tutorial
title: Cordova 端到端演示
breadcrumb_title: Cordova
relevantTo: [cordova]
weight: 1
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
* Xcode for iOS、Android Studio for Android 或 Visual Studio 2013/2015 for Windows 8.1 Universal / Windows 10 UWP
* Cordova CLI 6.x。
* *可选*。{{ site.data.keys.mf_cli }}（[下载]({{site.baseurl}}/downloads)）
* *可选*。单机{{ site.data.keys.mf_server }}（[下载]({{site.baseurl}}/downloads)）

### 1. 启动 {{ site.data.keys.mf_server }}
{: #1-starting-the-mobilefirst-server }
确保您已[创建 Mobile Foundation 实例](../../bluemix/using-mobile-foundation)，或者  
如果使用 [{{ site.data.keys.mf_dev_kit }}](../../installation-configuration/development/mobilefirst)，请导航至服务器的文件夹并运行命令 `./run.sh`（在 Mac 和 Linux 中）或 `run.cmd`（在 Windows 中）。

### 2. 创建并注册应用程序
{: #2-creating-and-registering-an-application }
在浏览器窗口中，通过加载以下 URL 打开 {{ site.data.keys.mf_console }}：`http://your-server-host:server-port/mfpconsole`。如果是本地运行，请使用：[http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole)。用户名/密码为 *admin/admin*。
 
1. 单击**应用程序**旁的**新建**按钮
    * 选择平台：**Android、iOS、Windows**
    * 将 **com.ibm.mfpstartercordova** 输入为**应用程序标识**
    * 将 **1.0.0** 输入为**版本**
    * 单击**注册应用程序**

    <img class="gifplayer" alt="注册应用程序" src="register-an-application-cordova.png"/>
 
2. 单击**获取起动器代码**磁贴，并选择下载 Cordova 样本应用程序。

    <img class="gifplayer" alt="下载样本应用程序" src="download-starter-code-cordova.png"/>
 
### 3. 编辑应用程序逻辑
{: #3-editing-application-logic }
1. 在您所选的代码编辑器中打开 Cordova 项目。

2. 选择 **www/js/index.js** 文件并粘贴以下代码片段，以替换现有的 `WLAuthorizationManager.obtainAccessToken()` 函数：

```javascript
WLAuthorizationManager.obtainAccessToken()
    .then(
        function(accessToken) {
            titleText.innerHTML = "Yay!";
            statusText.innerHTML = "Connected to {{ site.data.keys.mf_server }}";
            
            var resourceRequest = new WLResourceRequest(
                "/adapters/javaAdapter/resource/greet/",
                WLResourceRequest.GET
            );
            
            resourceRequest.setQueryParameter("name", "world");
            resourceRequest.send().then(
                function(response) {
                    // Will display "Hello world" in an alert dialog.
                    alert("Success: " + response.responseText);
                },
                function(response) {
                    alert("Failure: " + JSON.stringify(response));
                }
            );
        },

        function(error) {
            titleText.innerHTML = "Bummer...";
            statusText.innerHTML = "Failed to connect to {{ site.data.keys.mf_server }}";
        }
    );
```
    
### 4. 部署适配器
{: #4-deploy-an-adapter }
下载[这一准备好的适配器工件](../javaAdapter.adapter)，并通过**操作 → 部署适配器**操作从 {{ site.data.keys.mf_console }} 进行部署。

或者，单击**适配器**旁边的**新建**按钮。  
        
1. 选择**操作 → 下载样本**选项。下载“Hello World”**Java** 适配器样本。

    > 如果未安装 Maven 和 {{ site.data.keys.mf_cli }}，请遵循屏幕上的**设置开发环境**指示信息。
2. 从**命令行**窗口中，导航至适配器的 Maven 项目根文件夹并运行以下命令：

    ```bash
    mfpdev adapter build
    ```

3. 构建完成时，通过**操作 → 部署适配器**操作从 {{ site.data.keys.mf_console }} 进行部署。适配器可在 **[adapter]/target** 文件夹中找到。
    
    <img class="gifplayer" alt="部署适配器" src="create-an-adapter.png"/>   


<img src="cordovaQuickStart.png" alt="样本应用程序" style="float:right"/>
### 5. 测试应用程序
{: #5-testing-the-application }
1. 从**命令行**窗口中，导航至 Cordova 项目的根文件夹。
2. 运行命令 `cordova platform add ios|android|windows` 来添加一个平台。
3. 在 Cordova 项目中，选择 **config.xml** 文件，然后编辑 `<mfp:server ... url=" "/>` 值，其中 **protocol**、**host** 和 **port** 属性设置为针对 {{ site.data.keys.mf_server }} 的正确的值。
    * 如果使用本地 {{ site.data.keys.mf_server }}，这些值通常是 **http**、 **localhost** 和 **9080**。
    * 如果使用远程 {{ site.data.keys.mf_server }}（在 Bluemix 中），这些值通常是 **https**、**your-server-address** 和 **443**。

    或者，如果已安装 {{ site.data.keys.mf_cli }}，那么导航至项目根文件夹并运行命令 `mfpdev app register`。如果使用远程 {{ site.data.keys.mf_server }}，[那么运行命令 `mfpdev server add`](../../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance) 来添加服务器，后跟（例如）`mfpdev app register myBluemixServer`。
	
如果已连接某设备，将在该设备上安装并启动此应用程序，  
否则将使用模拟器或仿真器。

<br clear="all"/>
### 结果
{: #results }
* 单击 **Ping {{ site.data.keys.mf_server }}** 按钮将显示**已连接到 {{ site.data.keys.mf_server }}**。
* 如果应用程序能够连接到 {{ site.data.keys.mf_server }}，那么将使用部署的 Java 适配器进行资源请求调用。

然后，适配器响应将显示在警报中。

## 后续步骤
{: #next-steps }
要了解有关在应用程序中使用适配器，如何集成附加服务（如推送通知），使用 {{ site.data.keys.product_adj }} 安全框架及其他内容的更多信息，请：

- 查看[应用程序开发](../../application-development/)教程
- 查看[适配器开发](../../adapters/)教程
- 查看[认证和安全教程](../../authentication-and-security/)
- 查看[通知教程](../../notifications/)
- 查看[所有教程](../../all-tutorials)
