---
layout: tutorial
title: Android 端到端演示
breadcrumb_title: Android
relevantTo: [android]
weight: 3
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
* Android Studio
* *可选*。{{ site.data.keys.mf_cli }}（[下载]({{site.baseurl}}/downloads)）
* *可选*。单机{{ site.data.keys.mf_server }}（[下载]({{site.baseurl}}/downloads)）

### 1. 启动 {{ site.data.keys.mf_server }}
{: #1-starting-the-mobilefirst-server }
确保您已[创建 Mobile Foundation 实例](../../bluemix/using-mobile-foundation)，或者  
如果使用 [{{ site.data.keys.mf_dev_kit }}](../../installation-configuration/development/mobilefirst)，请导航至服务器的文件夹并运行命令 `./run.sh`（在 Mac 和 Linux 中）或 `run.cmd`（在 Windows 中）。

### 2. 创建应用程序
{: #2-creating-an-application }
在浏览器窗口中，通过加载以下 URL 打开 {{ site.data.keys.mf_console }}：`http://your-server-host:server-port/mfpconsole`。如果是本地运行，请使用：[http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole)。用户名/密码为 *admin/admin*。
 
1. 单击**应用程序**旁的**新建**按钮
    * 选择 **Android** 平台
    * 将 **com.ibm.mfpstarterandroid** 输入为**应用程序标识**
    * 将 **1.0** 输入为**版本**值
    * 单击**注册应用程序**

    <img class="gifplayer" alt="注册应用程序" src="register-an-application-android.png"/>
 
2. 单击**获取起动器代码**磁贴，并选择下载 Android 样本应用程序。

    <img class="gifplayer" alt="下载样本应用程序" src="download-starter-code-android.png"/>

### 3. 编辑应用程序逻辑
{: #3-editing-application-logic }
1. 打开 Android Studio 项目并导入项目。

2. 从**项目**侧边栏菜单中，选择 **app → java → com.ibm.mfpstarterandroid → ServerConnectActivity.java** 文件，然后：

* 添加以下导入：

  ```java
  import java.net.URI;
  import java.net.URISyntaxException;
  import android.util.Log;
  ```
    
* 粘贴以下代码片段，以替换对 `WLAuthorizationManager.getInstance().obtainAccessToken` 的调用：

  ```java
  WLAuthorizationManager.getInstance().obtainAccessToken("", new WLAccessTokenListener() {
                @Override
                public void onSuccess(AccessToken token) {
                    System.out.println("Received the following access token value: " + token);
                    runOnUiThread(new Runnable() {
                        @Override
                        public void run() {
                            titleLabel.setText("Yay!");
                            connectionStatusLabel.setText("Connected to {{ site.data.keys.mf_server }}");
                        }
                    });

                    URI adapterPath = null;
                    try {
                        adapterPath = new URI("/adapters/javaAdapter/resource/greet");
                    } catch (URISyntaxException e) {
                        e.printStackTrace();
                    }

                    WLResourceRequest request = new WLResourceRequest(adapterPath, WLResourceRequest.GET);
                    
                    request.setQueryParameter("name","world");
                    request.send(new WLResponseListener() {
                        @Override
                        public void onSuccess(WLResponse wlResponse) {
                            // Will print "Hello world" in LogCat.
                            Log.i("MobileFirst Quick Start", "Success: " + wlResponse.getResponseText());
                        }

                        @Override
                        public void onFailure(WLFailResponse wlFailResponse) {
                            Log.i("MobileFirst Quick Start", "Failure: " + wlFailResponse.getErrorMsg());
                        }
                    });
                }

                @Override
                public void onFailure(WLFailResponse wlFailResponse) {
                    System.out.println("Did not receive an access token from server: " + wlFailResponse.getErrorMsg());
                    runOnUiThread(new Runnable() {
                        @Override
                        public void run() {
                            titleLabel.setText("Bummer...");
                            connectionStatusLabel.setText("Failed to connect to {{ site.data.keys.mf_server }}");
                        }
                    });
                }
            });
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

<img src="androidQuickStart.png" alt="样本应用程序" style="float:right"/>
### 5. 测试应用程序
{: #5-testing-the-application }

1. 在 Android Studio 中，从**项目**侧边栏菜单选择 **app → src → main →assets → mfpclient.properties** 文件，然后将 **protocol**、**host** 和 **port** 属性编辑为针对  {{ site.data.keys.mf_server }} 的正确的值。
    * 如果使用本地 {{ site.data.keys.mf_server }}，这些值通常是 **http**、 **localhost** 和 **9080**。
    * 如果使用远程 {{ site.data.keys.mf_server }}（在 Bluemix 中），这些值通常是 **https**、**your-server-address** 和 **443**。

    或者，如果已安装 {{ site.data.keys.mf_cli }}，那么导航至项目根文件夹并运行命令 `mfpdev app register`。如果使用远程 {{ site.data.keys.mf_server }}，[那么运行命令 `mfpdev server add`](../../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance) 来添加服务器，后跟（例如）`mfpdev app register myBluemixServer`。

2. 单击**运行应用程序**按钮。  

<br clear="all"/>
### 结果
{: #results }
* 单击 **Ping {{ site.data.keys.mf_server }}** 按钮将显示**已连接到 {{ site.data.keys.mf_server }}**。
* 如果应用程序能够连接到 {{ site.data.keys.mf_server }}，那么将使用部署的 Java 适配器进行资源请求调用。

然后，适配器响应将列显在 Android Studio 的 LogCat 视图中。

![成功从 {{ site.data.keys.mf_server }} 调用了资源的应用程序的图像](success_response.png)

## 后续步骤
{: #next-steps }
要了解有关在应用程序中使用适配器，如何集成附加服务（如推送通知），使用 {{ site.data.keys.product_adj }} 安全框架及其他内容的更多信息，请：

- 查看[开发应用程序](../../application-development/)教程
- 查看[适配器开发](../../adapters/)教程
- 查看[认证和安全教程](../../authentication-and-security/)
- 查看[通知教程](../../notifications/)
- 查看[所有教程](../../all-tutorials)
