---
layout: tutorial
title: 使用 MobileFirst CLI 管理 MobileFirst 工件
breadcrumb_title: Using the MobileFirst CLI
weight: 2
relevantTo: [ios,android,windows,javascript]
---
## 概述
{: #overview }
{{ site.data.keys.product_full }} 为开发人员提供命令行界面 (CLI) 工具 **mfpdev**，以轻松管理客户机和服务器工件。  
通过使用 CLI，您可以管理使用 {{ site.data.keys.product_adj }} Cordova 插件的基于 Cordova 的应用程序以及使用 {{ site.data.keys.product_adj }} 本机 SDK 的本机应用程序。

您还可以向本地或远程 {{ site.data.keys.mf_server }} 实例创建、注册和管理适配器，以及从命令行或通过 REST 服务或者从 {{ site.data.keys.mf_console }} 管理项目。

**mfpdev** 命令有两个方式：交互方式和直接方式。 在交互方式下，输入不带选项的命令，并且将提示您响应。 在直接方式下，输入包含选项的完整命令，并且不提供提示。 如果适用，提示对于应用程序的目标平台而言是上下文相关的，由从中运行命令的目录确定。 使用键盘的向上和向下方向键来进行选择，当您想要的选择项已突出显示并且前面有“>”字符时，按 Enter 键。

在此教程中，您将了解如何安装 `mfpdev` 命令行界面 (CLI)，以及如何使用它来管理 {{ site.data.keys.mf_server }} 实例、应用程序和适配器。

> 有关 Cordova 和本机应用程序中 SDK 集成的更多信息，请参阅[添加 {{ site.data.keys.product }} SDK](../../application-development/sdk/)类别中的教程。

#### 跳转至
{: #jump-to }
* [先决条件](#prerequisites)
* [安装 {{ site.data.keys.mf_cli }}](#installing-the-mobilefirst-cli)
* [CLI 命令列表](#list-of-cli-commands)
* [交互方式和直接方式](#interactive-and-direct-modes)
* [管理 {{ site.data.keys.mf_server }} 实例](#managing-mobilefirst-server-instances)
* [管理应用程序](#managing-applications)
* [管理和测试适配器](#managing-and-testing-adapters)
* [有帮助的命令](#helpful-commands)
* [更新和卸载命令行界面](#update-and-uninstall-the-command-line-interface)

## 先决条件
{: #prerequisites }
{{ site.data.keys.mf_cli }} 在 [NPM 注册表](https://www.npmjs.com/)中可用作 NPM 软件包。  

确保 **node.js** 和 **npm** 安装在开发环境中，以便安装 NPM 软件包。  
遵循 [nodejs.org](https://nodejs.org) 中的安装指示信息来安装 node.js。

要确认 node.js 安装正确，请运行命令 `node -v`。

```bash
node -v
v6.11.1
```

> **注：****node.js** 的最低受支持版本为 **4.2.3**。 另外，**node** 和 **npm** 包发展很快，MobileFirst CLI 可能无法在所有版本的 **node** 和 **npm**（包括最新版本）上都能完全发挥作用。 要使 CLI 能够正常运行，请确保 **node** 的版本为 **6.11.1**，**npm** 的版本为 **3.10.10**。

## 安装 {{ site.data.keys.mf_cli }}
{: #installing-the-mobilefirst-cli }
要安装命令行界面，请运行命令：

```bash
npm install -g mfpdev-cli
```

如果从 {{ site.data.keys.mf_console }} 的下载中心下载了 CLI .zip 文件，请使用命令：

```bash
npm install -g <path-to-mfpdev-cli.tgz>
```

- 要安装不带可选依赖关系的 CLI，请添加 `--no-optional` 标记：`npm install -g --no-optional path-to-mfpdev-cli.tgz`

要确认安装，请运行不带任何参数的命令 `mfpdev`，并将显示帮助文本：

```shell
NAME
     IBM MobileFirst Foundation Command Line Interface (CLI).

SYNOPSIS
     mfpdev <command> [options]

DESCRIPTION
     The IBM MobileFirst Foundation Command Line Interface (CLI) is a command-line
     for developing MobileFirst applications. The command-line can be used by itself, or in conjunction
     with the IBM MobileFirst Foundation Operations Console. Some functions are available from  
     the command-line only and not the console.

     For more information and a step-by-step example of using the CLI, see the IBM Knowledge Center for
     your version of IBM MobileFirst Foundation at

          https://www.ibm.com/support/knowledgecenter.
    ...
    ...
    ...
```

## CLI 命令列表
{: #list-of-cli-commands }

| 命令前缀                                                | 命令操作                               | 描述                                                             |
|---------------------------------------------------------------|----------------------------------------------|-------------------------------------------------------------------------|
| `mfpdev app`	                                                | register                                     | 向 {{ site.data.keys.mf_server }} 注册您的应用程序。                           |
|                                                               | config                                       | 使您能够指定要用于应用程序的后端服务器和运行时。此外，对于 Cordova 应用程序，使您能够进行多个其他方面的配置，如系统消息的缺省语言以及是否执行校验和安全性检查。 针对 Cordova 应用程序，包含其他配置参数。                                                                                                                                                |
|                                                               | pull                                         | 从服务器检索现有的应用程序配置。                |
|                                                               | push                                         | 将应用程序的配置发送到服务器。                             |
|                                                               | preview                                      | 使您能够预览 Cordova 应用程序，而无需目标平台类型的实际设备。 您可以在 {{ site.data.keys.mf_mbs }} 或 Web 浏览器中查看预览。                                                                               |
|                                                               | webupdate                                    | 将包含在 www 目录内的应用程序资源打包在可用于直接更新过程的 .zip 文件中。                                                                                                                                     |
| mfpdev server	                                                | info                                         | 显示有关 {{ site.data.keys.mf_server }} 的信息。                      |
|                                                               | add                                          | 将新的服务器定义添加到您的环境中                        |
|                                                               | edit                                         | 使您能够编辑服务器定义。                                |
|                                                               | remove                                       | 从您的环境中移除服务器定义。                      |
|                                                               | console                                      | 打开 {{ site.data.keys.mf_console }}。                               |
|                                                               | clean                                        | 注销应用程序并从 {{ site.data.keys.mf_server }} 中移除适配器。      |
| mfpdev adapter                                                | create                                       | 创建适配器。                                                     |
|                                                               | build                                        | 构建适配器。                                                      |
|                                                               | build all                                    | 在当前目录及其子目录中查找并构建所有适配器。 |
|                                                               | deploy                                       | 将适配器部署到 {{ site.data.keys.mf_server }}。                           |
|                                                               | deploy all                                   | 查找当前目录及其子目录中的所有适配器，并将它们部署到 {{ site.data.keys.mf_server }}。 |
|                                                               | call                                         | 在 {{ site.data.keys.mf_server }} 上调用适配器的过程。                 |
|                                                               | pull                                         | 从服务器检索现有的适配器配置。                |
|                                                               | push                                         | 将适配器的配置发送到服务器。                             |
| mfpdev                                                        | config                                       | 针对 mfpdev 命令行界面，设置预览浏览器类型、预览超时值以及服务器超时值的配置首选项。                                                                                                                   |
|                                                               | info                                         | 显示有关您环境的信息，包括操作系统、内存使用量、节点版本和命令行界面版本。 如果当前目录是 Cordova 应用程序，还将显示 Cordova cordova info 命令提供的信息。 |
|                                                               | -v                                           | 显示当前使用的 {{ site.data.keys.mf_cli }} 的版本号。 |
|                                                               | -d，--debug                                  | 调试方式：生成调试输出。                                      |
|                                                               | -dd，--ddebug                                | 详细的调试方式：生成详细的调试输出。                      |
|                                                               | -no-color                                    | 禁止在命令输出中使用颜色。                              |
| mfpdev help                                                   | 命令的名称                              | 显示 {{ site.data.keys.mf_cli }} (mfpdev) 命令的帮助。 通过参数，显示每个命令类型或命令的更具体的帮助文本。 例如“mfpdev help server add” |

## 交互方式和直接方式
{: #interactive-and-direct-modes }
可以在**交互**或**直接方式**下执行所有命令。 在交互方式下，将提示命令所需要的参数，并且将使用一些缺省值。 在直接方式下，必须随要执行的命令一起提供参数。

示例：

交互方式下的 `mfpdev server add`：

```bash
? Enter the name of the new server definition: mydevserver
? Enter the fully qualified URL of this server: http://mydevserver.example.com:9080
? Enter the {{ site.data.keys.mf_server }} administrator login ID: admin
? Enter the {{ site.data.keys.mf_server }} administrator password: *****
? Save the admin password for this server?: Yes
? Enter the context root of the MobileFirst administration services: mfpadmin
? Enter the {{ site.data.keys.mf_server }} connection timeout in seconds: 30
Verifying server configuration...
The following runtimes are currently installed on this server: mfp
Server profile 'mydevserver' added successfully.
```
直接方式下的 mfpdev server add 命令将为

```bash
mfpdev server add mydevserver --url http://mydevserver.example.com:9080 --login admin --password admin --setdefault
```

要查找直接方式下命令的正确语法，请使用 `mfpdev help <command>`。


## 管理 {{ site.data.keys.mf_server }} 实例
{: #managing-mobilefirst-server-instances }
您可以使用 `mfpdev server <option>` 命令管理使用中的 {{ site.data.keys.mf_server }} 的实例。 必须始终至少有一个服务器实例列示为缺省实例。   如果未指定另一个服务器，那么将始终使用缺省服务器。

### 列示服务器实例
{: #list-server-instances }
要列示可用的所有 {{ site.data.keys.mf_server }} 实例，请运行命令：

```bash
mfpdev server info
```

缺省情况下，将自动创建本地服务器概要文件，并供 CLI 用作当前缺省值。

### 添加新的服务器实例
{: #add-a-new-server-instance }
如果要使用其他本地或远程 {{ site.data.keys.mf_server }} 实例，可以将其添加到可用于命令的实例列表：

```bash
mfpdev server add
```

遵循交互式提示，提供服务器的名称、服务器 URL 以及用户/密码凭证。  
例如，要添加正在 Mobile Foundation IBM Cloud 服务上运行的 {{ site.data.keys.mf_server }}，可执行以下操作：

```bash
$ mfpdev server add
? Enter the name of the new server profile: MyBluemixServer
? Enter the fully qualified URL of this server: https://mobilefoundation-7abcd-server.mybluemix.net:443
? Enter the {{ site.data.keys.mf_server }} administrator login ID: admin
? Enter the {{ site.data.keys.mf_server }} administrator password: *****
? Save the administrator password for this server?: Yes
? Enter the context root of the MobileFirst administration services: mfpadmin
? Enter the {{ site.data.keys.mf_server }} connection timeout in seconds: 30
? Make this server the default?: Yes
Verifying server configuration...
The following runtimes are currently installed on this server: mfp
Server profile 'MyBluemixServer' added successfully.
```

- 将“fully qualified URL of this server”替换为您自己服务器的标准 URL。

### 编辑服务器实例
{: #edit-server-instances }
如果要编辑已注册服务器实例的详细信息，请运行以下命令，并遵循交互式提示选择要编辑的服务器，然后提供要更新的信息。

```bash
mfpdev server edit
```

要将服务器设置为缺省服务器，请使用：

```bash
mfpdev server edit <server_name> --setdefault
```

### 移除服务器实例
{: #remove-server-instances }
要从已注册服务器的列表中移除服务器实例，请运行命令：

```bash
mfpdev server remove
```

然后，从交互式列表中选择服务器

### 打开 {{ site.data.keys.mf_console }}
{: #open-mobilefirst-operations-console }
要打开已注册的缺省服务器的控制台，请运行命令：

```bash
mfpdev server console
```

要打开其他服务器的控制台，请将服务器名称作为命令参数进行通知：

```bash
mfpdev server console <server_name>
```

### 从服务器中移除应用程序和适配器
{: #remove-apps-and-adapters-from-a-server }
要移除服务器中注册的所有应用程序和适配器，请运行命令：

```bash
mfpdev server clean
```

然后从交互式提示中选择要清除的服务器。  
这会将服务器实例置于清除状态，而无需部署任何应用程序或适配器。

## 管理应用程序
{: #managing-applications }
命令 `mfpdev app <option>` 可用于管理使用 {{ site.data.keys.product }} SDK 创建的应用程序。

### 在服务器实例中注册应用程序
{: #register-an-application-in-a-server-instance }
当可执行时，必须在 {{ site.data.keys.mf_server }} 中注册应用程序。  
要注册应用程序，请从应用程序项目的根文件夹运行以下命令：

```bash
mfpdev app register
```

可以从 Cordova、Android、iOS 或 Windows 应用程序的根目录执行此命令。  
它将使用缺省服务器和运行时来运行以下任务：

* 向服务器注册应用程序。
* 为应用程序生成缺省客户机属性文件。
* 将服务器信息放置到客户机属性文件中。

对于 Cordova 应用程序，此命令将更新 config.xml 文件。  
对于 iOS 应用程序，此命令将更新 mfpclient.plist 文件。  
对于 Android 或 Windows 应用程序，此命令将更新 mfpclient.properties 文件。

要向非缺省服务器和运行时注册应用程序，请使用语法：

```
mfpdev app register <server> <runtime>
```

对于 Cordova Windows 平台，必须在命令中添加 `-w <platform>` 自变量。  `<platform>` 自变量是要注册的 Windows 平台的逗号分隔列表。 有效值为 `windows`、`windows8` 和 `windowsphone8`。

```
mfpdev app register -w windows8
```

### 配置应用程序
{: #configure-an-application }
在注册应用程序时，会将与服务器相关的属性添加到其配置文件。  
要更改这些属性的值，请运行以下命令：

```bash
mfpdev app config
```

此命令将以交互方式提供可更改的属性的列表，并提示属性的新值。  
可用属性将因每个平台而异（iOS、Android 或 Windows）。

可用配置包括：

* 将向其注册应用程序的服务器地址和运行时

    > **示例用例：**要向具有特定地址的 {{ site.data.keys.mf_server }} 注册应用程序，但还让应用程序连接到不同的服务器地址，例如 DataPower 设备：
    >
    > 1. 运行 `mfpdev app register` 以在期望的 {{ site.data.keys.mf_server }} 地址中注册应用程序。
    > 2. 运行 `mfpdev app config` 并更改 **server** 属性值以与 DataPower 设备的地址匹配。 您还可以在**直接方式**下运行此命令：`mfpdev app config server http(s)://server-ip-or-host:port`。

* 为“直接更新”真实性功能设置公用密钥
* 设置应用程序缺省语言（缺省值为英语 (en)）
* 是否启用 Web 资源校验和测试
* 要在 Web 资源校验和测试期间忽略哪些文件扩展名

<div class="panel-group accordion" id="app-config" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="app-config-options">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#app-config-options" data-target="#collapse-app-config-options" aria-expanded="false" aria-controls="collapse-app-config-options"><b>有关 Web 资源校验和设置的其他信息</b></a>
            </h4>
        </div>

        <div id="collapse-app-config-options" class="panel-collapse collapse" role="tabpanel" aria-labelledby="app-config-options">
            <div class="panel-body">
                <p>对于 Web 资源校验和设置，每个可能的目标平台（Android、iOS、Windows 8、Windows Phone 8 和 Windows 10 UWP）都具有特定于平台的密钥，以在 <b>mfpdev</b> 直接方式下使用。 这些密钥以表示平台名称的字符串开始。 例如，<code>windows10_security_test_web_resources_checksum</code> 是 true 或 false 设置，指定是否为 Windows 10 UWP 启用 Web 资源校验和测试。</p>

                <table class="table table-striped">
                    <tr>
                        <td><b>设置</b></td>
                        <td><b>描述</b></td>
                    </tr>
                    <tr>
                        <td><code>direct_update_authenticity_public_key</code></td>
                        <td>为直接更新认证指定公用密钥。 密钥必须采用 Base64 格式。</td>
                    </tr>
                    <tr>
                        <td><code>ios_security_test_web_resources_checksum</code></td>
                        <td>如果设置为 <code>true</code>，那么对 iOS Cordova 应用程序启用 Web 资源校验和测试。 缺省值为 <code>false</code>。</td>
                    </tr>
                    <tr>
                        <td><code>android_security_test_web_resources_checksum</code></td>
                        <td>如果设置为 <code>true</code>，那么对 Android Cordova 应用程序启用 Web 资源校验和测试。 缺省值为 <code>false</code>。</td>
                    </tr>
                    <tr>
                        <td><code>windows10_security_test_web_resources_checksum</code></td>
                        <td>如果设置为 <code>true</code>，那么对 Windows 10 UWP Cordova 应用程序启用 Web 资源校验和测试。 缺省值为 <code>false</code>。</td>
                    </tr>
                    <tr>
                        <td><code>windows8_security_test_web_resources_checksum</code></td>
                        <td>如果设置为 <code>true</code>，那么对 Windows 8.1 Cordova 应用程序启用 Web 资源校验和测试。 缺省值为 <code>false</code>。</td>
                    </tr>
                    <tr>
                        <td><code>windowsphone8_security_test_web_resources_checksum</code></td>
                        <td>如果设置为 <code>true</code>，那么对 Windows Phone 8.1 Cordova 应用程序启用 Web 资源校验和测试。 缺省值为 <code>false</code>。</td>
                    </tr>
                    <tr>
                        <td><code>ios_security_ignore_file_extensions</code></td>
                        <td>指定在对 iOS Cordova 应用程序进行 Web 资源校验和测试期间要忽略的文件扩展名。 用逗号分隔多个扩展名。 例如：jpg,gif,pdf</td>
                    </tr>
                    <tr>
                        <td><code>android_security_ignore_file_extensions</code></td>
                        <td>指定在对 Android Cordova 应用程序进行 Web 资源校验和测试期间要忽略的文件扩展名。 用逗号分隔多个扩展名。 例如：jpg, gif,pdf</td>
                    </tr>
                    <tr>
                        <td><code>windows10_security_ignore_file_extensions</code></td>
                        <td>指定在对 Windows 10 UWP Cordova 应用程序进行 Web 资源校验和测试期间要忽略的文件扩展名。 用逗号分隔多个扩展名。 例如：jpg,gif,pdf</td>
                    </tr>
                    <tr>
                        <td><code>windows8_security_ignore_file_extensions</code></td>
                        <td>指定在对 Windows 8.1 Cordova 应用程序进行 Web 资源校验和测试期间要忽略的文件扩展名。 用逗号分隔多个扩展名。 例如：jpg,gif,pdf</td>
                    </tr>
                    <tr>
                        <td><code>windowsphone8_security_ignore_file_extensions</code></td>
                        <td>指定在对 Windows Phone 8.1 Cordova 应用程序进行 Web 资源校验和测试期间要忽略的文件扩展名。 用逗号分隔多个扩展名。 例如：jpg,gif,pdf</td>
                    </tr>
                </table>

                <br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#app-config-options" data-target="#collapse-app-config-options" aria-expanded="false" aria-controls="collapse-app-config-options"><b>结束部分</b></a>
            </div>
        </div>
    </div>
</div>


### 预览 Cordova 应用程序
{: #preview-a-cordova-application }
可以使用浏览器预览 Cordova 应用程序的 Web 资源。 预览应用程序将支持快速开发，而无需使用特定于本机平台的仿真器和模拟器。

在运行预览命令之前，您必须通过添加 `wlInitOptions` 变量来准备项目。 完成以下步骤：

1. 将 *wlInitOptions* 变量添加到主要 JavaScript 文件（在标准 Cordova 应用程序中为 **index.js**）。

   ```javascript
   var wlInitOptions = {
      mfpContextRoot:'/mfp', // "mfp" is the default context root of {{ site.data.keys.mf_server }}
      applicationId:'com.sample.app' // Replace with your own value.
   };
   ```

2. 使用以下命令再次注册应用程序：

   ```bash
   mfpdev app register
   ```

 3. 运行以下命令：

    ```bash
    cordova prepare
    ```

 4. 通过从 Cordova 应用程序根文件夹运行以下命令来预览 Cordova 应用程序：

    ```bash
    mfpdev app preview
    ```

系统将提示您选择要预览的平台以及要使用的预览类型。
有两个预览选项：MBS 和浏览器。

* MBS - {{ site.data.keys.mf_mbs }}。 此方法将在浏览器中模拟移动设备，并提供基本的 Cordova API 模拟，如摄像头、文件上载、地理定位等。 注：您不能将 cordova 浏览器与 MBS 选项一起使用。
* 浏览器 - 简单浏览器呈现。 此方法会将 Cordova 应用程序的 www 资源作为正常的浏览器 Web 页面提供。

> 有关预览选项的更多详细信息，请参阅 [Cordova 开发教程](../cordova-apps)。

### 更新“直接更新”的 Web 资源
{: #update-web-resources-for-direct-update }
可以更新 Cordova 应用程序的 Web 资源（如 **www** 文件夹内的 .html、.css 和 .js 文件），而无需在移动设备上重新安装应用程序。 使用 {{ site.data.keys.product }} 提供的“直接更新”功能可以实现。

> 有关“直接更新”如何工作的更多详细信息，请参阅教程[在 Cordova 应用程序中使用“直接更新”](../direct-update)。

如果想发送一组要在 cordova 应用程序中更新的新 Web 资源，请运行命令

```bash
mfpdev app webupdate
```

此命令会将已更新的 Web 资源打包到 .zip 文件，并将其上载到已注册的缺省 {{ site.data.keys.mf_server }}。 可以在 **[cordova-project-root-folder]/mobilefirst/** 文件夹中找到打包的 Web 资源。

要将 Web 资源上载到不同的服务器实例，请将服务器名称和运行时作为命令的一部分进行通知

```bash
mfpdev app webupdate <server_name> <runtime>
```

您可以使用 --build 参数生成包含打包的 Web 资源的 .zip 文件，而无需将其上载到服务器。

```bash
mfpdev app webupdate --build
```

要上载先前构建的软件包，请使用 -- file 参数

```bash
mfpdev app webupdate --file mobilefirst/com.ibm.test-android-1.0.0.zip
```

还可以选择使用 --encrypt 参数对软件包的内容进行加密

```bash
mfpdev app webupdate --encrypt
```

### 提取和推送 {{ site.data.keys.product_adj }} 应用程序配置
{: #pull-and-push-the-mobilefirst-application-configuration }
在 {{ site.data.keys.mf_server }} 中注册 {{ site.data.keys.product_adj }} 应用程序之后，可以使用 {{ site.data.keys.mf_server }} 控制台更改一些应用程序配置，然后使用以下命令将这些配置从服务器提取到应用程序：

```bash
mfpdev app pull
```

还可以在本地更改应用程序配置，然后使用以下命令推送对 {{ site.data.keys.mf_server }} 的更改：

```bash
mfpdev app push
```

**示例：**可以在 {{ site.data.keys.mf_console }} 中执行安全性检查的范围映射，然后使用上述命令从服务器中提取相关信息。 下载的 .zip 文件存储在项目的 **[root directory]/mobilefirst** 文件夹中，稍后可与 `mfpdev app push` 一起使用，以将其上载到另一个 {{ site.data.keys.mf_server }}，通过复用预定义的配置允许快速配置和设置。

## 管理和测试适配器
{: #managing-and-testing-adapters }
可以使用命令 `mfpdev adapter <option>` 管理适配器。

> 要了解有关适配器的更多信息，请参阅[适配器](../../adapters/)类别下的教程。


### 创建适配器
{: #create-an-adapter }
要创建新适配器，请使用命令

```bash
mfpdev adapter create
```

遵循提示，通知适配器的名称、类型和组标识

### 构建适配器
{: #build-an-adpater }
要构建适配器，请从适配器的根文件夹运行以下命令：

```bash
mfpdev adapter build
```

这将在 **<AdapterName>/target** 文件夹中生成 .adapter 文件。

### 部署适配器
{: #deploy-an-adapter}
以下命令会将适配器部署到缺省服务器：

```bash
mfpdev adapter deploy
```

要部署到另一个服务器，请使用：

```bash
mfpdev adapter deploy <server_name>
```

### 从命令行调用适配器
{: #call-an-adapter-from-the-command-line }
在部署适配器之后，可以从命令行调用适配器以使用下列命令测试其行为：

```bash
mfpdev adapter call
```

系统会提示您通知要使用的适配器、过程和参数。 命令的输出将是适配器过程的响应。

> 可在[测试和调试适配器](../../adapters/testing-and-debugging-adapters/)教程中了解更多信息。

## 有帮助的命令
{: #helpful-commands }
要设置 mfpdev CLI 的首选项（如缺省浏览器和缺省预览方式），请使用命令：

```bash
mfpdev config
```

要查看描述所有 mfpdev 命令的帮助内容，请使用：

```bash
mfpdev help
```

以下命令将生成包含您的环境相关信息的列表：

```bash
mfpdev info
```

要显示 mfpdev CLI 的版本，请使用：

```bash
mfpdev -v
```

## 更新和卸载命令行界面
{: #update-and-uninstall-the-command-line-interface }
要更新命令行界面，请运行命令：

```bash
npm update -g mfpdev-cli
```

要卸载命令行界面，请运行命令：

```bash
npm uninstall -g mfpdev-cli
```
