---
layout: tutorial
title: 将 MobileFirst Foundation SDK 添加到 Cordova 应用程序
breadcrumb_title: Cordova
relevantTo: [cordova]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
在此教程中，了解如何将 {{ site.data.keys.product_adj }} SDK 添加到新的或现有的使用 Apache Cordova、Ionic 或其他第三方工具创建的 Cordova 应用程序。 您还可以了解如何配置 {{ site.data.keys.mf_server }} 以识别应用程序，以及查找有关在项目中更改的 {{ site.data.keys.product_adj }} 配置文件的信息。

{{ site.data.keys.product_adj }} Cordova SDK 作为一组 Cordova 插件提供，并且[在 NPM 上注册](https://www.npmjs.com/package/cordova-plugin-mfp)。  
可用插件包括：

* **cordova-plugin-mfp** - 核心 SDK 插件
* **cordova-plugin-mfp-push** - 提供推送通知支持
* **cordova-plugin-mfp-jsonstore** - 提供 JSONStore 支持
* **cordova-plugin-mfp-fips** - *仅限 Android*。 提供 FIPS 支持
* **cordova-plugin-mfp-encrypt-utils** - *仅限 iOS*。 提供加密和解密支持

#### 支持级别
{: #support-levels }
MobileFirst 插件支持的 Cordova 平台版本包括：

* cordova-ios：**>= 4.1.1 以及 < 5.0**
* cordova-android：**>= 6.1.2 and <= 7.0**
* cordova-windows：**>= 4.3.2 以及 < 6.0**

#### 跳转至：
{: #jump-to }
- [Cordova SDK 组件](#cordova-sdk-components)
- [添加 {{ site.data.keys.product_adj }} Cordova SDK](#adding-the-mobilefirst-cordova-sdk)
- [更新 {{ site.data.keys.product_adj }} Cordova SDK](#updating-the-mobilefirst-cordova-sdk)
- [已生成 {{ site.data.keys.product_adj }} Cordova SDK 工件](#generated-mobilefirst-cordova-sdk-artifacts)
- [Cordova 浏览器平台支持](#cordova-browser-platform)
- [接下来要学习的教程](#tutorials-to-follow-next)

> **注：**如果使用 Xcode 8，在 iOS 模拟器中运行 iOS 应用程序时，**密钥链共享**功能是必需的。在构建 Xcode 项目之前，必须手动启用此功能。

## Cordova SDK 组件
{: #cordova-sdk-components }
#### cordova-plugin-mfp
{: #cordova-plugin-mfp }
cordova-plugin-mfp 插件是针对 Cordova 的核心 {{ site.data.keys.product_adj }} 插件，且此插件是必需的。 如果安装任何其他 {{ site.data.keys.product_adj }} 插件，并且 cordova-plugin-mfp 插件尚未安装，那么也将自动安装此插件。

> 以下 Cordova 插件将作为 cordova-plugin-mfp 的依赖项进行安装：
>   
>    - cordova-plugin-device
>    - cordova-plugin-dialogs
>    - cordova-plugin-globalization
>    - cordova-plugin-okhttp

#### cordova-plugin-mfp-jsonstore
{: #cordova-plugin-mfp-jsonstore }
cordova-plugin-mfp-jsonstore 插件使您的应用程序能够使用 JSONstore。 有关 JSONstore 的更多信息，请参阅 [JSONStore 教程](../../jsonstore/cordova/)。  

#### cordova-plugin-mfp-push
{: #cordova-plugin-mfp-push }
cordova-plugin-mfp-push 插件提供必需的许可权，以对 Android 应用程序使用来自 {{ site.data.keys.mf_server }} 的推送通知。 必需其他设置以使用推送通知。 有关推送通知的更多信息，请参阅[推送通知教程](../../../notifications/)。

#### cordova-plugin-mfp-fips
{: #cordova-plugin-mfp-fips }
cordova-plugin-mfp-fips 插件为 Android 平台提供 FIPS 140-2 支持。 有关更多信息，请参阅 [FIPS 140-2 支持](../../../administering-apps/federal/#fips-140-2-support)。

#### cordova-plugin-mfp-encrypt-utils
{: #cordova-plugin-mfp-encrypt-utils }
cordova-plugin-mfp-encrypt-utils 插件为使用 iOS 平台的 Cordova 应用程序提供用于加密的 iOS OpenSSL 框架。 有关更多信息，请参阅[为 Cordova iOS 启用 OpenSSL](additional-information)。

**先决条件：**

- 安装在开发人员工作站上的 [Apache Cordova CLI](https://www.npmjs.com/package/cordova) 和 {{ site.data.keys.mf_cli }}。
- {{ site.data.keys.mf_server }} 的本地或远程实例正在运行。
- 阅读[设置您的 {{ site.data.keys.product_adj }} 开发环境](../../../installation-configuration/development/mobilefirst)和[设置您的 Cordova 开发环境](../../../installation-configuration/development/cordova)教程。
- 对于 cordova-windows，必须安装与机器中已安装的 Visual Studio 和 .NET 版本兼容的 Visual C++ 版本。
- 如果使用 Windows Phone SDK 8.0 和 Visual Studio Tools for Universal Windows Apps，请确保创建的 cordova-windows 应用程序具有所有必需的支持库。

## 添加 {{ site.data.keys.product }} Cordova SDK
{: #adding-the-mobilefirst-cordova-sdk }
遵循下面的指示信息将 {{ site.data.keys.product }} Cordova SDK 添加到新的或现有的 Cordova 项目，然后在 {{ site.data.keys.mf_server }} 中进行注册。

在您开始之前，确保 {{ site.data.keys.mf_server }} 正在运行。  
如果使用本地安装的服务器：从**命令行**窗口，浏览至服务器的文件夹，然后运行命令：`./run.sh`。

> **注：**如果要将 SDK 添加到现有的 Cordova 应用程序，那么插件将覆盖 `MainActivity.java` 文件（针对 Android）和 `Main.m` 文件（针对 iOS）。

### 添加 SDK
{: #adding-the-sdk }
考虑使用 {{ site.data.keys.product_adj }} Cordova **应用程序模板**创建项目。 此模板会将必需的特定于 {{ site.data.keys.product_adj }} 的插件条目添加到 Cordova 项目的 **config.xml** 文件，并提供特定于 {{ site.data.keys.product_adj }} 并针对 {{ site.data.keys.product_adj }} 应用程序开发进行了调整的现成可用的 **index.js** 文件。

#### 新建应用程序
{: #new-application }
1. 创建 Cordova 项目：`cordova create projectName applicationId applicationName --template cordova-template-mfp`。  
   例如：

   ```bash
   cordova create Hello com.example.helloworld HelloWorld --template cordova-template-mfp
   ```
     - “Hello”是应用程序的文件夹名称。
     - “com.example.helloworld”是应用程序的标识。
     - “HelloWorld”是应用程序的名称。
     - --template 将使用特定于 {{ site.data.keys.product_adj }} 的新增项来修改应用程序。

    模板化的 **index.js** 使您能够使用其他 {{ site.data.keys.product_adj }} 功能，如[多语言应用程序翻译](../../translation)和初始化选项（请参阅用户文档以获取更多信息）。

2. 将目录更改为 Cordova 项目的根目录：`cd hello`

3. 使用 Cordova CLI 命令将一个或多个受支持的平台添加到 Cordova 项目：`cordova platform add ios|android|windows`。 例如：

   ```bash
   cordova platform add ios
   ```

   > **注：**由于已使用 {{ site.data.keys.product_adj }} 模板配置应用程序，因此将自动添加 {{ site.data.keys.product_adj }} 核心 Cordova 插件，因为已在步骤 3 中添加平台。

4. 通过运行 `cordova prepare` 命令来准备应用程序资源：

   ```bash
   cordova prepare
   ```

#### 现有应用程序
{: #existing-application }
1. 浏览至现有 Cordova 项目的根目录并添加 {{ site.data.keys.product_adj }} 核心 Cordova 插件：

   ```bash
   cordova plugin add cordova-plugin-mfp
   ```

2. 浏览至 **www\js** 文件夹并选择 **index.js** 文件。

3. 添加以下函数：

   ```javascript
   function wlCommonInit() {

   }
   ```

在装入 {{ site.data.keys.product_adj }} 客户机 SDK 之后，{{ site.data.keys.product_adj }} API 方法将可用。 然后将调用 `wlCommonInit` 函数。  
使用此函数调用各种 {{ site.data.keys.product_adj }} API 方法。

### 注册应用程序
{: #registering-the-application }
1. 打开**命令行**窗口并浏览至 Cordova 项目的根目录。  

2. 向 {{ site.data.keys.mf_server }} 注册此应用程序：

   ```bash
   mfpdev app register
   ```
    - 如果使用的是远程服务器，请[使用命令 `mfpdev server add`](../../using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance) 进行添加。

`mfpdev app register` CLI 命令将先连接到 {{ site.data.keys.mf_server }} 以注册应用程序，然后使用标识 {{ site.data.keys.mf_server }} 的元数据更新 Cordova 项目根目录的 **config.xml** 文件。

会在 {{ site.data.keys.mf_server }} 中将每个平台注册为应用程序。

> <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> **提示：**您还可以从 {{ site.data.keys.mf_console }} 注册应用程序：    
>
> 1. 装入 {{ site.data.keys.mf_console }}。  
> 2. 单击**应用程序**旁边的**新建**按钮以注册新应用程序，并遵循屏幕上的指示信息。  

### 使用 SDK
{: #using-the-sdk }
在装入 {{ site.data.keys.product_adj }} 客户机 SDK 之后，{{ site.data.keys.product_adj }} API 方法将可用。 然后将调用 `wlCommonInit` 函数。  
使用此函数调用各种 {{ site.data.keys.product_adj }} API 方法。

## 更新 {{ site.data.keys.product_adj }} Cordova SDK
{: #updating-the-mobilefirst-cordova-sdk }
要使用最新发行版更新 {{ site.data.keys.product_adj }} Cordova SDK，请除去 **cordova-plugin-mfp** 插件：运行 `cordova plugin remove cordova-plugin-mfp` 命令，然后运行 `cordova plugin add cordova-plugin-mfp` 命令以重新添加。

可以在 SDK 的 [NPM 存储库](https://www.npmjs.com/package/cordova-plugin-mfp)中找到 SDK 发行版。

## 已生成 {{ site.data.keys.product_adj }} Cordova SDK 工件
{: #generated-mobilefirst-cordova-sdk-artifacts }
### config.xml
{: #configxml }
Cordova 配置文件是包含应用程序元数据的必需 XML 文件，存储在应用程序的根目录中。  
将 {{ site.data.keys.product_adj }} Cordova SDK 添加到项目之后，Cordova 生成的 **config.xml** 文件会接收一组使用名称空间 `mfp:` 标识的新元素。 添加的元素包含与 {{ site.data.keys.product_adj }} 功能和 {{ site.data.keys.mf_server }} 相关的信息。

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
## Cordova 浏览器平台支持
{: #cordova-browser-platform}

MobileFirst 平台现在支持 Cordova 浏览器平台以及受支持的 Cordova Windows、Cordova Android 和 Cordova iOS 平台。

将 Cordova 浏览器平台用于 MobileFirst Platform (MFP) 类似于将 MFP 用于任何其他平台。下面解释了用于演示此功能的样本。

使用以下命令来创建 cordova 应用程序：
```bash
cordova create <your-appFolder-name> <package-name>
```
这将创建一个 vanilla cordova 应用程序。

使用以下命令来添加 MFP 插件：
```bash
cordova plugin add cordova-plugin-mfp
   ```
添加一个可用于 ping MFP 服务器（此服务器可能是本地托管的服务器或 IBM Cloud 上的服务器）的按钮。单击此按钮以 Ping 您的 MFP 服务器。
您可以使用以下样本代码：

#### index.html

```html
<!DOCTYPE html>
<html>

<head>
   <meta http-equiv="Content-Security-Policy" content="default-src 'self' data: gap: https://ssl.gstatic.com 'unsafe-eval'; style-src 'self' 'unsafe-inline'; media-src *">
  <meta name="format-detection" content="telephone=no">
  <meta name="msapplication-tap-highlight" content="no">
  <meta name="viewport" content="user-scalable=no, initial-scale=1, maximum-scale=1, minimum-scale=1, width=device-width">


  <link rel="stylesheet" type="text/css" href="css/index.css" />

  <!-- load script with wlCommonInit defined before loading cordova.js -->
  <script type="text/javascript" src="js/index.js"></script>
  <script type="text/javascript" src="cordova.js"></script>

  <title>MFP Starter - Cordova</title>
</head>

<body>

  <div id="main">
    <div id="main_title">Hello MobileFirst</div>
    <div id="main_status"></div>
    <div id="main_info"></div>
  </div>

  <div id="button_content">
    <button id="ping_button" style="display:none">Ping MobileFirst Server</button>
  </div>

</body>

</html>
```

#### index.js

```javascript

var Messages = {
        // Add here your messages for the default language.
  // Generate a similar file with a language suffix containing the translated messages.
  // key1 : message1,
};

var wlInitOptions = {
    // Options to initialize with the WL.Client object.
  // For initialization options please refer to IBM MobileFirst Platform Foundation Knowledge Center.
   mfpContextRoot : '/mfp', // "mfp" is the default context root in the MobileFirst Development server
    applicationId : 'io.cordova.hellocordova' // Replace with your own app id/package name.
};

function wlCommonInit() {
  app.init();
}

var app = {
  //initialize app
  "init": function init() {
    var buttonElement = document.getElementById("ping_button");
    buttonElement.style.display = "block";
    buttonElement.addEventListener('click', app.testServerConnection, false);
  },
  //test server connection
  "testServerConnection": function testServerConnection() {

    var titleText = document.getElementById("main_title");
    var statusText = document.getElementById("main_status");
    var infoText = document.getElementById("main_info");
    titleText.innerHTML = "Hello MobileFirst";
    statusText.innerHTML = "Connecting to Server...";
    infoText.innerHTML = "";

    WLAuthorizationManager.obtainAccessToken()
      .then(
        function (accessToken) {
          titleText.innerHTML = "Yay!";
          statusText.innerHTML = "Connected to MobileFirst Server";
        },
        function (error) {
          titleText.innerHTML = "Bummer...";
          statusText.innerHTML = "Failed to connect to MobileFirst Server";
        }
        );
    },
 }

```

>**注：**请务必在 index.js 文件的 **wlInitOptions** 中提及 `mfpContextRoot` 和 `applicationId`。

#### index.css

```css
body {
    position: static;
    font-family: "HelveticaNeue-Light", "Helvetica Neue Light", "Helvetica Neue", Helvetica, Arial, "Lucida Grande", sans-serif;
    font-weight: 300;
    margin: 0px;
	padding: 0px;
}

#button_content {
  position: absolute;
  bottom: 10%;
  width: 100%;
}

#ping_button {
  display: block;
  margin: 0 auto;
  height: 50px;
  width: 240px;
  font-size: 20px;
  color: white;
  background-color: #325c80;
}

#main {
  top: 10%;
  position: absolute;
  text-align: center;
  width: 100%
}

#main_title {
  font-size: 40px;
}

#main_status {
  font-size: 20px;
  margin-top: 10px;
}

#main_info {
  font-size: 14px;
  margin-top: 10px;
}

```


使用以下命令来添加浏览器平台：
```bash
cordova platform add browser
```
<!--
 (Register the app to the MFP server. The **mfpdev-cli** from version -.-.- and above recognizes cordova browser applications as web platform applications. If you are using a lower version then you can either upgrade to the latest version or manually register your application. -->

> 要手动注册您的应用程序：
>
* 登录到您的 MFP 服务器控制台。
* 单击_*应用程序*_选项旁边的**新建**按钮。
* 为应用程序提供名称，选择 **Web** 作为平台，然后提供应用程序的标识（在 `index.js` 的 **wlInitOptions** 函数中定义）。
>
>**谨记：**将服务器详细信息添加到应用程序的 `config.xml`。

<!--If you are using **mfpdev-cli** (more about the `cli` commands can be found [here](https://www.ibm.com/support/knowledgecenter/en/SSHSCD_8.0.0/com.ibm.worklight.dev.doc/dev/t_gs_cli.html)), add the MFP server using the following command:

```bash
mfpdev server add
```
Set it as the default server.

Register your application with the following command:

```bash
mfpdev app register
```
-->


 >**注**：不久后将发布用于注册浏览器平台应用程序的 *mfpdev-cli*。

然后，执行以下命令：

```bash
cordova prepare
cordova build
cordova run
```

<!--This will launch two browsers. One of the browser runs on cordova browser's proxy server (that runs on port `8000`, generally) which cannot connect to the MFP server due to the [same-origin-policy](https://developer.mozilla.org/en-US/docs/Web/Security/Same-origin_policy)). The other browser would be an MFP proxy server (this runs on port `9081`) that will serve MFP requests.

If you click the button to ping MFP on the browser running on port `8000`, the ping will fail whereas clicking the button that runs on localhost port `9081` will be successful. All the cordova browser compatible cordova plugins and MFP features can be used without issues.-->

这会启动运行在代理服务器上的浏览器（在端口 `9081` 上），然后连接到 MFP 服务器。cordova 浏览器的缺省代理服务器（运行在端口 `8000` 上）已被禁止，原因是该服务器由于 [same-origin-policy](https://developer.mozilla.org/en-US/docs/Web/Security/Same-origin_policy) 而无法连接到 MFP 服务器。

> 要运行的缺省浏览器设置为 **Chrome**。使用 `--target` 选项以在其他浏览器上运行，也可通过以下命令使用该选项：
```bash
 cordova run --target=Firefox
 ```

可通过以下命令来预览应用程序：

```bash
mfpdev app preview
```

唯一受支持的浏览器选项是*简单浏览器呈现*。该浏览器平台不支持*移动浏览器支持*选项。

### 使用 WebSphere Liberty 提供 cordova 浏览器资源
{: #using-liberty-cordova-browser}

按照指示信息使用<a href="http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/installation-configuration/development/web/">本</a>教程中的 WebSphere Liberty，然后进行以下更改。

将浏览器项目的 `www` 文件夹内容添加到 `[MyWebApp] → src → Main → webapp`，如本教程中**使用 Web 应用程序资源构建 Maven Web 应用程序**部分的步骤 1 中所述。最后，在 Liberty 服务器上注册您的应用程序，并在浏览器中使用路径 `localhost:9080/MyWebApp` 运行该应用程序以进行测试。另外将 `sjcl` 和 `jssha` 文件夹添加到其父文件夹，并更改其在 `ibmmfpf.js` 文件中的引用。

## 接下来要学习的教程
{: #tutorials-to-follow-next }
集成 {{ site.data.keys.product_adj }} Cordova SDK 之后，您现在可以：

- 查看[使用 {{ site.data.keys.product }} SDK 教程](../)
- 查看[适配器开发教程](../../../adapters/)
- 查看[认证和安全教程](../../../authentication-and-security/)
- 查看[通知教程](../../../notifications/)
- 查看[所有教程](../../../all-tutorials)
