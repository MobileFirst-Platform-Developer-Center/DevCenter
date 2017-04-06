---
layout: tutorial
title: Web 应用程序端到端演示
breadcrumb_title: Web
relevantTo: [javascript]
weight: 5
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
* 新型 Web 浏览器
* *可选*。{{ site.data.keys.mf_cli }}（[下载]({{site.baseurl}}/downloads)）
* *可选*。单机{{ site.data.keys.mf_server }}（[下载]({{site.baseurl}}/downloads)）

### 1. 启动 {{ site.data.keys.mf_server }}
{: #starting-the-mobilefirst-server }
确保您已[创建 Mobile Foundation 实例](../../bluemix/using-mobile-foundation)，或者  
如果使用 [{{site.data.keys.mf_dev_kit }}](../../installation-configuration/development/mobilefirst)，请导航至服务器的文件夹并运行命令 `./run.sh`（在 Mac 和 Linux 中）或 `run.cmd`（在 Windows 中）。

### 2. 创建并注册应用程序
{: #creating-and-registering-an-application }
在浏览器窗口中，通过加载以下 URL 打开 {{ site.data.keys.mf_console }}：`http://your-server-host:server-port/mfpconsole`。如果是本地运行，请使用：[http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole)。用户名/密码为 *admin/admin*。
 
1. 单击**应用程序**旁的**新建**按钮
    * 选择 **Web** 平台
    * 将 **com.ibm.mfpstarterweb** 输入为**应用程序标识**
    * 单击**注册应用程序**

    <img class="gifplayer" alt="注册应用程序" src="register-an-application-web.png"/>
 
2. 单击**获取起动器代码**磁贴，并选择下载 Web 样本应用程序。

    <img class="gifplayer" alt="下载样本应用程序" src="download-starter-code-web.png"/>
 
### 3. 编辑应用程序逻辑
{: #editing-application-logic }
1. 在您所选的代码编辑器中打开项目。

2. 选择 **client/js/index.js** 文件并粘贴以下代码片段，以替换现有的 `WLAuthorizationManager.obtainAccessToken()` 函数：

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
{: #deploy-an-adapter }
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


<img src="web-success.png" alt="样本应用程序" style="float:right"/>
### 5. 测试应用程序
{: #testing-the-application }
1. 从**命令行**窗口中，导航至 **[project root] → node-server** 文件夹。
2. 运行命令 `npm start` 来安装所需的 Node.js 配置并启动 Node.js 服务器。
3. 打开 **[project root] → node-server → server.js** 文件，并将 **host** 和 **port** 变量编辑为针对 {{ site.data.keys.mf_server }} 的正确的值。
    * 如果使用本地 {{ site.data.keys.mf_server }}，这些值通常是 **http**、 **localhost** 和 **9080**。
    * 如果使用远程 {{ site.data.keys.mf_server }}（在 Bluemix 中），这些值通常是 **https**、**your-server-address** 和 **443**。 

   例如：  
    
   ```javascript
   var host = 'https://mobilefoundation-xxxx.mybluemix.net'; // The Mobile Foundation server address
   var port = 9081; // The local port number to use
   var mfpURL = host + ':443'; // The Mobile Foundation server port number
   ```
   
4. 在您的浏览器中，访问 URL [http://localhost:9081/home](http://localhost:9081/home)。

<br>
#### 安全源策略
{: #secure-origins-policy }
开发过程中使用 Chrome 时，在同时使用 HTTP 和“localhost”**以外**的主机的情况下，浏览器可能不允许加载应用程序。这是因为缺省情况下，本浏览器中实施并使用了安全源策略。

要解决此问题，您可以通过以下标记启动 Chrome 浏览器：

```bash
--unsafely-treat-insecure-origin-as-secure="http://replace-with-ip-address-or-host:port-number" --user-data-dir=/test-to-new-user-profile/myprofile
```

- 将“test-to-new-user-profile/myprofile”替换为将充当新 Chrome 用户概要文件的文件夹的位置，以便标记起作用。

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
- 查看[所有教程](../../all-tutorials)
