---
layout: tutorial
title: iOS 端到端演示
breadcrumb_title: iOS
relevantTo: [ios]
weight: 2
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
* Xcode
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
    * 选择 **iOS** 平台
    * 将 **com.ibm.mfpstarteriosobjectivec** 或 **com.ibm.mfpstarteriosswift** 输入为**应用程序标识**（取决于您在下一步中下载的应用程序框架）
    * 将 **1.0** 输入为**版本**值
    * 单击**注册应用程序**
    
    <img class="gifplayer" alt="注册应用程序" src="register-an-application-ios.png"/>
 
2. 单击**获取起动器代码**磁贴，并选择下载 iOS Objective-C 或 iOS Swift 样本应用程序。

    <img class="gifplayer" alt="下载样本应用程序" src="download-starter-code-ios.png"/>
    
### 3. 编辑应用程序逻辑
{: #3-editing-application-logic }
1. 通过双击 **.xcworkspace** 文件打开 Xcode 项目。

2. 选择 **[project-root]/ViewController.m/swift** 文件并粘贴以下代码片段，以替换现有的 `getAccessToken()` 函数：
 
   在 Objective-C 中：

   ```objc
   - (IBAction)getAccessToken:(id)sender {
   _testServerButton.enabled = NO;
   NSURL *serverURL = [[WLClient sharedInstance] serverUrl];
   _connectionStatusLabel.text = [NSString stringWithFormat:@"Connecting to server...\n%@", serverURL];
    
   NSLog(@"Testing Server Connection");
   [[WLAuthorizationManager sharedInstance] obtainAccessTokenForScope:@"" withCompletionHandler:^(AccessToken *token, NSError *error) {
        if (error != nil) {
            _titleLabel.text = @"Bummer...";
            _connectionStatusLabel.text = [NSString stringWithFormat:@"Failed to connect to {{ site.data.keys.mf_server }}\n%@", serverURL];
            NSLog(@"Did not receive an access token from server: %@", error.description);
        } else {
            _titleLabel.text = @"Yay!";
            _connectionStatusLabel.text = [NSString stringWithFormat:@"Connected to {{ site.data.keys.mf_server }}\n%@", serverURL];
            NSLog(@"Received the following access token value: %@", token.value);
            
            NSURL* url = [NSURL URLWithString:@"/adapters/javaAdapter/resource/greet/"];
            WLResourceRequest* request = [WLResourceRequest requestWithURL:url method:WLHttpMethodGet];
            
            [request setQueryParameterValue:@"world" forName:@"name"];
            [request sendWithCompletionHandler:^(WLResponse *response, NSError *error) {
                if (error != nil){
                    NSLog(@"Failure: %@",error.description);
                }
                else if (response != nil){
                    // Will print "Hello world" in the Xcode Console.
                    NSLog(@"Success: %@",response.responseText);
                }
            }];
        }

        _testServerButton.enabled = YES;
    }];
}
   ```
    
   在 Swift 中：
    
   ```swift
   @IBAction func getAccessToken(sender: AnyObject) {
        self.testServerButton.enabled = false
        
        let serverURL = WLClient.sharedInstance().serverUrl()
        
        connectionStatusLabel.text = "Connecting to server...\n\(serverURL)"
        print("Testing Server Connection")
        WLAuthorizationManager.sharedInstance().obtainAccessTokenForScope(nil) { (token, error) -> Void in
            
            if (error != nil) {
                self.titleLabel.text = "Bummer..."
                self.connectionStatusLabel.text = "Failed to connect to {{ site.data.keys.mf_server }}\n\(serverURL)"
                print("Did not recieve an access token from server: " + error.description)
            } else {
                self.titleLabel.text = "Yay!"
                self.connectionStatusLabel.text = "Connected to {{ site.data.keys.mf_server }}\n\(serverURL)"
                print("Recieved the following access token value: " + token.value)
                
                let url = NSURL(string: "/adapters/javaAdapter/resource/greet/")
                let request = WLResourceRequest(URL: url, method: WLHttpMethodGet)
                
                request.setQueryParameterValue("world", forName: "name")
                request.sendWithCompletionHandler { (response, error) -> Void in
                    if (error != nil){
                        NSLog("Failure: " + error.description)
                    }
                    else if (response != nil){
                        NSLog("Success: " + response.responseText)
                    }
                }
            }
            
            self.testServerButton.enabled = true
        }
   }
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

<img src="iosQuickStart.png" alt="样本应用程序" style="float:right"/>
### 5. 测试应用程序
{: #5-testing-the-application }
1. 在 Xcode 中，选择 **mfpclient.plist** 文件并将 **protocol**、**host** 和 **port** 属性编辑为针对 {{ site.data.keys.mf_server }} 的正确的值。
    * 如果使用本地 {{ site.data.keys.mf_server }}，这些值通常是 **http**、 **localhost** 和 **9080**。
    * 如果使用远程 {{ site.data.keys.mf_server }}（在 Bluemix 中），这些值通常是 **https**、**your-server-address** 和 **443**。
     
    或者，如果已安装 {{ site.data.keys.mf_cli }}，那么导航至项目根文件夹并运行命令 `mfpdev app register`。如果使用远程 {{ site.data.keys.mf_server }}，[那么运行命令 `mfpdev server add`](../../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance) 来添加服务器，后跟（例如）`mfpdev app register myBluemixServer`。

2. 按**播放**按钮。

<br clear="all"/>
### 结果
{: #results }
* 单击 **Ping {{ site.data.keys.mf_server }}** 按钮将显示**已连接到 {{ site.data.keys.mf_server }}**。
* 如果应用程序能够连接到 {{ site.data.keys.mf_server }}，那么将使用部署的 Java 适配器进行资源请求调用。

然后，适配器响应将列显在 Xcode 控制台中。

![成功从 {{ site.data.keys.mf_server }} 调用了资源的应用程序的图像](success_response.png)

## 后续步骤
{: #next-steps }
要了解有关在应用程序中使用适配器，如何集成附加服务（如推送通知），使用 {{ site.data.keys.product_adj }} 安全框架及其他内容的更多信息，请：

- 查看[应用程序开发](../../application-development/)教程
- 查看[适配器开发](../../adapters/)教程
- 查看[认证和安全教程](../../authentication-and-security/)
- 查看[通知教程](../../notifications/)
- 查看[所有教程](../../all-tutorials)
