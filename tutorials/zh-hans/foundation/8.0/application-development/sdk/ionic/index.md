---
layout: tutorial
title: 将 MobileFirst Foundation SDK 添加到 Ionic 应用程序
breadcrumb_title: Ionic
relevantTo: [ionic]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
在此教程中，了解如何将 {{ site.data.keys.product_adj }} SDK 添加到使用 Ionic CLI 创建的新的或现有的 Ionic 应用程序。您还可以了解如何配置 {{ site.data.keys.mf_server }} 以识别应用程序，以及查找有关在项目中更改的 {{ site.data.keys.product_adj }} 配置文件的信息。

{{ site.data.keys.product_adj }} Ionic SDK 作为一组 Typescript 包装程序以及 Cordova 插件提供，并在 [NPM](https://www.npmjs.com/package/cordova-plugin-mfp) 上注册。  

可用插件包括：

* **cordova-plugin-mfp** - 核心 SDK 插件
* **cordova-plugin-mfp-push** - 提供推送通知支持
* **cordova-plugin-mfp-jsonstore** - 提供 JSONStore 支持


### 支持级别
{: #support-levels }
MobileFirst 插件支持的 Ionic Cordova 平台版本包括：

* cordova-ios：**>= 4.1.1 以及 < 5.0**
* cordova-android：**>= 6.1.2 以及 < 7.0**
* cordova-windows：**>= 4.3.2 以及 < 6.0**

### 跳转至：
{: #jump-to }
- [Ionic SDK 组件](#ionic-sdk-components)
- [添加 {{ site.data.keys.product_adj }} Ionic SDK](#adding-the-mobilefirst-ionic-sdk)
- [更新 {{ site.data.keys.product_adj }} Ionic SDK](#updating-the-mobilefirst-ionic-sdk)
- [已生成 {{ site.data.keys.product_adj }} Ionic SDK 工件](#generated-mobilefirst-ionic-sdk-artifacts)
- [接下来要学习的教程](#tutorials-to-follow-next)

## Ionic SDK 组件
{: #ionic-sdk-components }
#### cordova-plugin-mfp
{: #cordova-plugin-mfp }
*cordova-plugin-mfp* 插件是针对 Cordova 的核心 {{ site.data.keys.product_adj }} 插件，并且此插件是必需的。如果安装任何其他 {{ site.data.keys.product_adj }} 插件，并且 *cordova-plugin-mfp* 插件尚未安装，那么也将自动安装此插件。

> 以下 Cordova 插件将作为 cordova-plugin-mfp 的依赖项进行安装：
>   
>    - cordova-plugin-device
>    - cordova-plugin-dialogs
>    - cordova-plugin-globalization
>    - cordova-plugin-okhttp

#### cordova-plugin-mfp-jsonstore
{: #cordova-plugin-mfp-jsonstore }
*cordova-plugin-mfp-jsonstore* 插件使您的应用程序能够使用 JSONstore。有关 JSONstore 的更多信息，请参阅 [JSONStore 教程](../../jsonstore/cordova/)。  

#### cordova-plugin-mfp-push
{: #cordova-plugin-mfp-push }
*cordova-plugin-mfp-push* 插件提供必需的许可权，以对 Android 应用程序使用来自 {{ site.data.keys.mf_server }} 的推送通知。必需其他设置以使用推送通知。 有关推送通知的更多信息，请参阅[推送通知教程](../../../notifications/)。

#### cordova-plugin-mfp-fips
{: #cordova-plugin-mfp-fips }
*cordova-plugin-mfp-fips* 插件为 Android 平台提供 FIPS 140-2 支持。有关更多信息，请参阅 [FIPS 140-2 支持](../../../administering-apps/federal/#fips-140-2-support)。

#### cordova-plugin-mfp-encrypt-utils
{: #cordova-plugin-mfp-encrypt-utils }
*cordova-plugin-mfp-encrypt-utils* 插件为使用 iOS 平台的 Cordova 应用程序提供用于加密的 iOS OpenSSL 框架。有关更多信息，请参阅[为 Cordova iOS 启用 OpenSSL](additional-information)。

**先决条件：**

- 安装在开发人员工作站上的 [Ionic CLI](https://www.npmjs.com/package/ionic) 和 {{ site.data.keys.mf_cli }}。
- {{ site.data.keys.mf_server }} 的本地或远程实例正在运行。
- 阅读[设置您的 {{ site.data.keys.product_adj }} 开发环境](../../../installation-configuration/development/mobilefirst)和[设置您的 Cordova 开发环境](../../../installation-configuration/development/cordova)教程。
- 对于 cordova-windows，必须安装与机器中已安装的 Visual Studio 和 .NET 版本兼容的 Visual C++ 版本。
- 如果使用 Visual Studio Tools for Universal Windows Apps，请确保创建的 cordova-windows 应用程序具有所有必需的支持库。

## 添加 {{ site.data.keys.product }} Ionic SDK
{: #adding-the-mobilefirst-ionic-sdk }
遵循下面的指示信息将 {{ site.data.keys.product }} Ionic SDK 添加到新的或现有的 Ionic 项目，然后在 {{ site.data.keys.mf_server }} 中进行注册。

在您开始之前，确保 {{ site.data.keys.mf_server }} 正在运行。  
如果使用本地安装的服务器，那么请从**命令行**窗口，浏览至服务器的文件夹，然后运行命令：`./run.sh`。

### 添加 SDK
{: #adding-the-sdk }
考虑使用 {{ site.data.keys.product_adj }} Ionic **应用程序模板**创建项目。此模板会将必需的特定于 {{ site.data.keys.product_adj }} 的插件条目添加到 Ionic 项目的 **config.xml** 文件，并提供特定于 {{ site.data.keys.product_adj }} 并针对 {{ site.data.keys.product_adj }} 应用程序开发进行了调整的现成可用的 **index.js** 文件。

#### 新建应用程序
{: #new-application }
1. 创建 Ionic 项目：`ionic start projectName starter-template`。  
   例如：

   ```bash
   ionic start Hello blank
   ```
     - “Hello”是文件夹名称和应用程序名称。
     - “blank”是启动器模板的名称。

    > 模板化的 **index.js** 使您能够使用其他 {{ site.data.keys.product_adj }} 功能，如[多语言应用程序翻译](../../translation)和初始化选项（请参阅用户文档以获取更多信息）。

2. 将目录切换至 Ionic 项目的根目录：`cd hello`

3. 使用 Ionic CLI 命令添加 MobileFirst 插件：`ionic cordova plugin add cordova-plugin-name`
例如：

   ```bash
   ionic cordova plugin add cordova-plugin-mfp
   ```

   > 上述命令会将 MobileFirst 核心 SDK 插件添加到 Ionic 项目。

4. 使用 Ionic CLI 命令将一个或多个受支持的平台添加到 Cordova 项目：`ionic cordova platform add ios|android|windows|browser`。例如：

   ```bash
   cordova platform add ios
   ```

4. 运行 `ionic cordova prepare` 命令来准备应用程序资源：

   ```bash
   ionic cordova prepare
   ```

#### 现有应用程序
{: #existing-application }

浏览至现有 Ionic 项目的根目录，然后添加 {{ site.data.keys.product_adj }} 核心 Ionic Cordova 插件：

   ```bash
   ionic cordova plugin add cordova-plugin-mfp
   ```

在装入 {{ site.data.keys.product_adj }} 客户机 SDK 之后，{{ site.data.keys.product_adj }} API 方法将可用。 然后将调用 `mfjsloaded` 事件。  

### 注册应用程序
{: #registering-the-application }
1. 打开**命令行**窗口并浏览至 Ionic 项目的根目录。  

2. 向 {{ site.data.keys.mf_server }} 注册此应用程序：

   ```bash
   mfpdev app register
   ```
    - 如果使用的是远程服务器，请[使用命令](../../using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance) `mfpdev server add` 进行添加。

`mfpdev app register` CLI 命令将先连接到 {{ site.data.keys.mf_server }} 以注册应用程序，然后使用标识 {{ site.data.keys.mf_server }} 的元数据更新 Ionic 项目根目录的 **config.xml** 文件。

会在 {{ site.data.keys.mf_server }} 中将每个平台注册为应用程序。

> <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> **提示：**您还可以从 {{ site.data.keys.mf_console }} 注册应用程序：    
>
> 1. 装入 {{ site.data.keys.mf_console }}。  
> 2. 单击**应用程序**旁边的**新建**按钮以注册新应用程序，并遵循屏幕上的指示信息。  

### 使用 SDK
{: #using-the-sdk }
在装入 {{ site.data.keys.product_adj }} 客户机 SDK 之后，{{ site.data.keys.product_adj }} API 方法将可用。 然后将调用 `mfjsloaded` 事件。  
只有在调用事件之后才会调用各种 {{ site.data.keys.product_adj }} API 方法。

## 更新 {{ site.data.keys.product_adj }} Ionic SDK
{: #updating-the-mobilefirst-cordova-sdk }
要使用最新发行版更新 {{ site.data.keys.product_adj }} Ionic Cordova SDK，请除去 **cordova-plugin-mfp** 插件：运行 `ionic cordova plugin remove cordova-plugin-mfp` 命令，然后运行 `ionic cordova plugin add cordova-plugin-mfp` 命令以重新添加。

可以在 SDK 的 [NPM 存储库](https://www.npmjs.com/package/cordova-plugin-mfp)中找到 SDK 发行版。

## 已生成 {{ site.data.keys.product_adj }} Ionic SDK 工件
{: #generated-mobilefirst-ionic-sdk-artifacts }
### config.xml
{: #configxml }
Ionic 配置文件是包含应用程序元数据的必需 XML 文件，存储在应用程序的根目录中。  
将 {{ site.data.keys.product_adj }} Ionic SDK 添加到项目之后，Ionic 生成的 **config.xml** 文件会接收一组使用名称空间 `mfp:` 标识的新元素。添加的元素包含与 {{ site.data.keys.product_adj }} 功能和 {{ site.data.keys.mf_server }} 相关的信息。

### 添加到 **config.xml** 文件的 {{ site.data.keys.product_adj }} 设置示例
{: #example-of-mobilefirst-settings-added-to-the-configxml-file}
```xml
<?xml version='1.0'encoding='utf-8'?>
<widget id="..." xmlns:mfp="http://www.ibm.com/mobilefirst/cordova-plugin-mfp">
    <mfp:android>
        <mfp:sdkChecksum>3563350808</mfp:sdkChecksum>
        <mfp:appChecksum>0</mfp:appChecksum>
        <mfp:security>
            <mfp:testWebResourcesChecksum enabled="false" ignoreFileExtensions="png, jpg, jpeg, gif, mp4, mp3" />
        </mfp:security>
    </mfp:android>
    <mfp:windows>
        <mfp:sdkChecksum>3563350808</mfp:sdkChecksum>
       <mfp:windows10>
          <mfp:sdkChecksum>...</mfp:sdkChecksum>          
          <mfp:security>
             <mfp:testWebResourcesChecksum/>
          </mfp:security>
    </mfp:windows>
    <mfp:platformVersion>8.0.0.00-20151214-1255</mfp:platformVersion>
    <mfp:clientCustomInit enabled="false" />
    <mfp:server runtime="mfp" url="http://10.0.0.1:9080" />
    <mfp:directUpdateAuthenticityPublicKey>the-key</mfp:directUpdateAuthenticityPublicKey>
    <mfp:languagePreferences>en</mfp:languagePreferences>
</widget>
```

<div class="panel-group accordion" id="config-xml" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="config-xml-properties">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#config-xml-properties" data-target="#collapse-config-xml-properties" aria-expanded="false" aria-controls="collapse-config-xml-properties"><b>单击以获取 config.xml 属性的完整列表</b></a>
            </h4>
        </div>

        <div id="collapse-config-xml-properties" class="panel-collapse collapse" role="tabpanel" aria-labelledby="config-xml-properties">
            <div class="panel-body">
                <table class="table table-striped">
                    <tr>
                        <td><b>元素</b></td>
                        <td><b>描述</b></td>
                        <td><b>配置</b></td>
                    </tr>
                    <tr>
                        <td><b>widget</b></td>
                        <td><a href="http://cordova.apache.org/docs/en/dev/config_ref/index.html">config.xml 文档</a>的根元素。 此元素包含两个必需属性： <ul><li><b>id</b>：这是在创建 Cordova 项目时指定的应用程序包名称。 如果在向 {{ site.data.keys.mf_server }} 注册应用程序之后手动更改了此值，那么必须重新注册应用程序。</li><li><b>xmlns:mfp</b>：{{ site.data.keys.product_adj }} 插件 XML 名称空间。</li></ul></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td><b>mfp:platformVersion</b></td>
                        <td>必需。 开发应用程序所用的产品版本。</td>
                        <td>缺省情况下已设置。 不得更改此值。</td>
                    </tr>
                    <tr>
                        <td><b>mfp:directUpdateAuthenticityPublicKey</b></td>
                        <td>可选。 在启用“直接更新真实性”功能时，将在部署期间对直接更新包进行数字签名。 在客户机下载包之后，将运行安全性检查以验证包真实性。 此字符串值是公用密钥，将用于认证直接更新 .zip 文件。</td>
                        <td>使用 <code>mfpdev app config direct_update_authenticity_public_key key-value</code> 命令设置。</td>
                    </tr>
                    <tr>
                        <td><b>mfp:languagePreferences</b></td>
                        <td>可选。 包含用于显示系统消息的语言环境的逗号分隔列表。</td>
                        <td>使用 <code>mfpdev app config language_preferences key-value</code> 命令设置。</td>
                    </tr>
                    <tr>
                        <td><b>mfp:clientCustomInit</b></td>
                        <td>控制如何调用 <code>WL.Client.init</code> 方法。 缺省情况下，将此值设置为 false，将在初始化 {{ site.data.keys.product_adj }} 插件之后自动调用 <code>WL.Client.init</code> 方法。 针对客户机代码将此值设置为 <b>true</b>，以显式控制调用 <code>WL.Client.init</code> 的时间。</td>
                        <td>手动编辑。 您可以将 <b>enabled</b> 属性值设置为 <b>true</b> 或 <b>false</b>。</td>
                    </tr>
                    <tr>
                        <td><b>mfp:server</b></td>
                        <td>缺省远程服务器连接信息，客户机应用程序将使用此信息与 {{ site.data.keys.mf_server }} 进行通信。 <ul><li><b>url：</b>url 值指定缺省情况下客户机将用于连接到服务器的 {{ site.data.keys.mf_server }} 协议、主机和端口值。</li><li><b>runtime：</b>运行时值指定应用程序注册到的 {{ site.data.keys.mf_server }} 运行时。 有关 {{ site.data.keys.product_adj }} 运行时的更多信息，请参阅 {{ site.data.keys.mf_server }} 概述。</li></ul></td>
                        <td><ul><li>使用 <code>the mfpdev app config server</code> 命令设置服务器 url 值。</li><li>使用 <code>mfpdev app config runtime</code> 命令设置服务器运行时值。</li></ul></td>
                    </tr>
                    <tr>
                        <td><b>mfp:ios</b></td>
                        <td>此元素包含针对 iOS 平台的所有与 {{ site.data.keys.product_adj }} 相关的客户机应用程序配置。<ul><li><b>mfp:appChecksum</b></li><li><b>mfp:sdkChecksum</b></li><li><b>mfp:security</b></li></ul></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td><b>mfp:android</b></td>
                        <td>此元素包含针对 Android 平台的所有与 {{ site.data.keys.product_adj }} 相关的客户机应用程序配置。<ul><li><b>mfp:appChecksum</b></li><li><b>mfp:sdkChecksum</b></li><li><b>mfp:security</b></li></ul></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td><b>mfp:windows</b></td>
                        <td>此元素包含针对 Windows 平台的所有与 {{ site.data.keys.product_adj }} 相关的客户机应用程序配置。<ul><li><b>mfp:appChecksum</b></li><li><b>mfp:windowsphone8</b></li><li><b>mfp:windows8</b></li><li><b>mfp:windows10</b></li></ul></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td><b>mfp:windows8</b></td>
                        <td>此元素包含针对 Windows 8.1 平台的所有与 {{ site.data.keys.product_adj }} 相关的客户机应用程序配置。
                        <ul><li><b>mfp:sdkChecksum</b></li><li><b>mfp:security</b></li></ul></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td><b>mfp:windows10</b></td>
                        <td>此元素包含针对 Windows 10 平台的所有与 {{ site.data.keys.product_adj }} 相关的客户机应用程序配置。
                        <ul><li><b>mfp:sdkChecksum</b></li><li><b>mfp:security</b></li></ul></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td><b>mfp:windowsphone8</b></td>
                        <td>此元素包含针对 Windows Phone 8.1 平台的所有与 {{ site.data.keys.product_adj }} 相关的客户机应用程序配置。
                        <ul><li><b>mfp:sdkChecksum</b></li><li><b>mfp:security</b></li></ul></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td><b>mfp:appChecksum</b></td>
                        <td>此值是应用程序 Web 资源的校验和。 在运行 <code>mfpdev app webupdate</code> 时计算。</td>
                        <td>不是用户可配置的。 该校验和值在运行 <code>mfpdev app webupdate</code> 命令时更新。 有关 <code>mfpdev app webupdate</code> 命令的更多详细信息，请在命令窗口中输入 <code>mfpdev help app webupdate</code>。</td>
                    </tr>
                    <tr>
                        <td><b>mfp:sdkChecksum</b></td>
                        <td>此值是用于标识唯一 {{ site.data.keys.product_adj }} SDK 级别的 {{ site.data.keys.mf_console }} SDK 校验和。</td>
                        <td>不是用户可配置的。 缺省情况下，此值已设置。</td>
                    </tr>
                    <tr>
                        <td><b>mfp:security</b></td>
                        <td>此元素包含特定于客户机应用程序平台的配置以确保 {{ site.data.keys.product_adj }} 安全性。 包含<ul><li><b>mfp:testWebResourcesChecksum</b></li></ul></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td><b>mfp:testWebResourcesChecksum</b></td>
                        <td>控制每次在移动设备上开始运行应用程序时，应用程序是否验证其 Web 资源的完整性。 属性： <ul><li><b>enabled：</b>有效值为 <b>true</b> 和 <b>false</b>。 如果将此属性设置为 <b>true</b>，那么应用程序将计算其 Web 资源的校验和，并且会将此校验和与初次运行应用程序时存储的值进行比较。</li><li><b>ignoreFileExtensions：</b>校验和计算可能需要几秒钟，这取决于 Web 资源的大小。 要使其更加快速，可以提供要在计算中忽略的文件扩展名列表。 当 <b>enabled</b> 属性值为 <b>false</b> 时，将忽略此值。</li></ul></td>
                        <td><ul><li>使用 <code>mfpdev app config android_security_test_web_resources_checksum key-value</code> 命令设置 <b>enabled</b> 属性。</li><li>使用 <code>mfpdev app config android_security_ignore_file_extensions value</code> 命令设置 <b>ignoreFileExtensions</b> 属性。</li></ul></td>
                    </tr>
                </table>

                <br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#config-xml-properties" data-target="#collapse-config-xml-properties" aria-expanded="false" aria-controls="collapse-config-xml-properties"><b>结束部分</b></a>
            </div>
        </div>
    </div>
</div>

### 编辑 config.xml 文件中的 {{ site.data.keys.product_adj }} 设置
{: #editing-mobilefirst-settings-in-the-configxml-file }
您可以使用 {{ site.data.keys.mf_cli }} 通过运行命令来编辑上面的设置：

```bash
mfpdev app config
```

## 接下来要学习的教程
{: #tutorials-to-follow-next }
集成 {{ site.data.keys.product_adj }} Ionic SDK 之后，您现在可以：

- 查看[使用 {{ site.data.keys.product }} SDK 教程](../)
- 查看[适配器开发教程](../../../adapters/)
- 查看[认证和安全教程](../../../authentication-and-security/)
- 查看[通知教程](../../../notifications/)
- 查看[所有教程](../../../all-tutorials)
