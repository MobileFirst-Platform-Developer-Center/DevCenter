---
layout: tutorial
title: Cordova 应用程序中的 MobileFirst Foundation 开发
breadcrumb_title: Cordova 应用程序开发
relevantTo: [cordova]
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
从 [http://cordova.apache.org/](http://cordova.apache.org/)：

> Apache Cordova 是开放式源代码移动开发框架。 它支持您使用标准 Web 技术（例如，HTML5、CSS3 和 JavaScript）进行跨平台开发，避免每个移动平台的本机开发语言。 应用程序在针对每个平台的包装程序中执行，并且依靠符合标准的 API 绑定来访问每个设备的传感器、数据和网络状态。

{{ site.data.keys.product_full }} 以多个 Cordova 插件的形式提供 SDK。 了解如何[向 Cordova 应用程序添加 {{ site.data.keys.product }} SDK](../../application-development/sdk/cordova)。

> **注：**使用 Test Flight 或 iTunes Connect 生成的用于存储 iOS 应用程序的提交/验证的归档/IPA 文件可能导致运行时崩溃/故障，请阅读博客 [Preparing iOS apps for App Store submission in {{ site.data.keys.product_full }}](https://mobilefirstplatform.ibmcloud.com/blog/2016/10/17/prepare-ios-apps-for-app-store-submission/) 以了解更多信息。

#### 跳转至：
{: #jump-to }

* [Cordova 应用程序开发](#cordova-application-development)
* [{{ site.data.keys.product_adj }} API](#mobilefirst-apis)
* [{{ site.data.keys.product_adj }} SDK 启动流程](#mobilefirst-sdk-startup-flow)
* [Cordova 应用程序安全性](#cordova-application-security)
* [Cordova 应用程序资源](#cordova-application-resources)
* [预览应用程序的 Web 资源](#previewing-an-applications-web-resources)
* [实施 JavaScript 代码](#implementing-javascript-code)
* [针对 Android 的 CrossWalk 支持](#crosswalk-support-for-android)
* [针对 iOS 的 WKWebView 支持](#wkwebview-support-for-ios)
* [补充阅读](#further-reading)
* [接下来要关注的教程](#tutorials-to-follow-next)

## Cordova 应用程序开发
{: #cordova-application-development }
可使用以下 Cordova 提供的开发路径和功能进一步增强使用 Cordova 开发的应用程序：

### Hooks
{: #hooks }
Cordova Hooks 是脚本，使开发人员能够定制 Cordova 命令，例如，支持创建定制构建流程示例。  
阅读有关 [Cordova Hooks](http://cordova.apache.org/docs/en/dev/guide/appdev/hooks/index.html#Hooks%20Guide) 的更多信息。

### Merges
{: #merges }
Merges 文件夹能够容纳特定于平台的 Web 资源（HTML、CSS 和 JavaScript 文件）。 然后，可在 `cordova prepare` 步骤期间针对相应的本机目录部署这些 Web 资源。 放置在 **merges/** 文件夹中的文件将覆盖相关平台的 **www/** 文件夹中的匹配文件。 阅读有关 [Merges 文件夹](https://github.com/apache/cordova-cli#merges)的更多信息。

### Cordova 插件
{: #cordova-plug-ins }
Cordova 插件可提供增强功能，例如，添加本机 UI 元素（对话框、选项卡栏、spinner 下拉列表和点赞）以及更高级的功能（例如，地图和地理定位、加载外部内容、定制键盘，以及摄像头、联系人和传感器之类的设备集成）。

您可以在 [GitHub.com](https://github.com) 上以及流行的 Cordova 插件 Web 站点（例如，[Plugreg](http://plugreg.com/) 和 [NPM](http://npmjs.org)）上查找 Cordova 插件。

示例插件：

- [cordova-plugin-dialogs](https://www.npmjs.com/package/cordova-plugin-dialogs)
- [cordova-plug-inprogress-indicator](https://www.npmjs.com/package/cordova-plugin-progress-indicator)
- [cordova-plugin-statusbar](https://www.npmjs.com/package/cordova-plugin-statusbar)

>**注：**在将 {{ site.data.keys.product_adj }} Cordova SDK 添加到项目时修改 Cordova 应用程序的缺省行为（如覆盖后退按钮行为）可能会导致提交时应用程序被 Google Play Store 拒绝。
如果在提交到 Google Play Store 时遇到其他失败情况，可以联系 Google 支持人员。


### 第三方框架
{: #3rd-party-frameworks }
可使用框架（例如，[Ionic](http://ionicframework.com/)、[AngularJS](https://angularjs.org/)、[jQuery Mobile](http://jquerymobile.com/)、[Backbone](http://backbonejs.org/) 和众多其他框架）进一步增强 Cordova 应用程序开发。

**集成博客帖子**

* [Best Practices for building AngularJS apps with MobileFirst Foundation 8.0](https://mobilefirstplatform.ibmcloud.com/blog/2016/08/11/best-practices-for-building-angularjs-apps-with-mobilefirst-foundation-8.0/)
* [Integrating {{ site.data.keys.product }} in Ionic-based apps]({{site.baseurl}}/blog/2016/07/19/integrating-mobilefirst-foundation-8-in-ionic-based-apps/)
* [Integrating {{ site.data.keys.product }} in Ionic 2 based apps]({{site.baseurl}}/blog/2016/10/17/integrating-mobilefirst-foundation-8-in-ionic2-based-apps/)

### 第三方程序包
{: #3rd-party-packages }
可使用第三方程序包来修改应用程序以满足各种需求，例如，缩小和并置应用程序的 Web 资源等。 可满足这些需求的流行的程序包有：

- [uglify-js](https://www.npmjs.com/package/uglify-js)
- [clean-css](https://www.npmjs.com/package/clean-css)

## {{ site.data.keys.product_adj }} API
{: #mobilefirst-apis }
在[向 Cordova 应用程序添加 {{ site.data.keys.product_adj }}Cordova SDK](../../application-development/sdk/cordova) 后，API 方法的 {{ site.data.keys.product_adj }} 集合即可供使用。

> 有关可用 API 方法的完整列表，请参阅 [API 参考大全](../../api)。

## {{ site.data.keys.product_adj }} SDK 启动流程
{: #mobilefirst-sdk-startup-flow }
<div class="panel-group accordion" id="startup-flows" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="android-flow">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#android-flow" data-target="#collapse-android-flow" aria-expanded="false" aria-controls="collapse-android-flow"><b>Android启动流程</b></a>
            </h4>
        </div>

        <div id="collapse-android-flow" class="panel-collapse collapse" role="tabpanel" aria-labelledby="android-flow">
            <div class="panel-body">
                <p>在 Android Studio 中，可使用 {{ site.data.keys.product_adj }} 复审 Android Cordova 应用程序的启动过程。 {{ site.data.keys.product_adj }} Cordova 插件 <b>cordova-plugin-mfp</b> 使用本机异步引导程序序列。 必须先完成引导程序序列，然后 Cordova 应用程序才能装入应用程序的主 HTML 文件。</p>

                <p>向 Cordova 应用程序添加 <b>cordova-plugin-mfp</b> 插件时，会检测应用程序的 <b>AndroidManifest.xml</b> 文件和 <code>MainActivity</code> 文件（继承 <code>CordovaActivity</code>）本机代码，以便执行 {{ site.data.keys.product_adj }} 初始化过程。</p>

                <p>应用程序本机代码检测包括：</p>
                <ul>
                    <li>添加 <code>com.worklight.androidgap.api.WL</code> API 调用以执行 {{ site.data.keys.product_adj }} 初始化。</li>
                    <li>在 <b>AndroidManifest.xml</b> 文件中，添加：
                        <ul>
                            <li>名为 <code>MFPLoadUrlActivity</code> 的活动，从而在安装 <b>cordova-plugin-crosswalk-webview</b> 的情况下进行适当的 {{ site.data.keys.product_adj }} 初始化。</li>
                            <li><code>application</code> 元素的定制属性 <b>android:name="com.ibm.MFPApplication</b>"（请参阅以下内容）。</li>
                        </ul>
                    </li>
                </ul>

                <h3>实施 WLInitWebFrameworkListener 和创建 WL 对象</h3>
                <p><b>MainActivity.java</b> 文件创建扩展 <code>CordovaActivity</code> 类的初始 <code>MainActivity</code> 类。 在初始化 {{ site.data.keys.product_adj }} 框架时，<code>WLInitWebFrameworkListener</code> 接收通知。</p>

{% highlight java %}
public class MainActivity extends CordovaActivity implements WLInitWebFrameworkListener {
{% endhighlight %}

                <p><code>MFPApplication</code> 类是从 <code>onCreate</code> 中调用的，并创建用于整个应用程序的 {{ site.data.keys.product_adj }} 客户机实例 (<code>com.worklight.androidgap.api.WL</code>)。<code>onCreate</code> 方法初始化 <b>WebView 框架</b>。</p>

{% highlight java %}
@Overridepublic void onCreate(Bundle savedInstanceState){
super.onCreate(savedInstanceState);

if (!((MFPApplication)this.getApplication()).hasCordovaSplashscreen()) {
           WL.getInstance().showSplashScreen(this);
       } 
   init();
   WL.getInstance().initializeWebFramework(getApplicationContext(), this);
}
{% endhighlight %}

                <p><code>MFPApplication</code> 类具有两个功能：</p>
                <ul>
                    <li>定义 <code>showSplashScreen</code> 方法以装入启动屏幕（如果存在）。</li>
                    <li>创建两个侦听器以启用分析。 如果不需要，那么可除去这些侦听器。</li>
                </ul>

                <h3>装入 WebView</h3>
                <p><b>cordova-plugin-mfp</b> 插件向 <b>AndroidManifest.xml</b> 文件添加初始化 Crosswalks WebView 所需的活动：</p>

{% highlight xml %}
<activity android:name="com.ibm.MFPLoadUrlActivity" />
{% endhighlight %}

                <p>此活动用于确保 Crosswalk WebView 的异步初始化如下所示：</p>

                <p>在初始化 {{ site.data.keys.product_adj }} 框架并准备好在 WebView 中装入后，如果 <code>WLInitWebFrameworkResult</code> 成功，那么 <code>onInitWebFrameworkComplete</code> 连接到 URL。</p>

{% highlight java %}
public void onInitWebFrameworkComplete(WLInitWebFrameworkResult result){
if (result.getStatusCode() == WLInitWebFrameworkResult.SUCCESS) {
super.loadUrl(WL.getInstance().getMainHtmlFilePath());
   } else {
      handleWebFrameworkInitFailure(result);
   }
}
{% endhighlight %}



                <br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#android-flow" data-target="#collapse-android-flow" aria-expanded="false" aria-controls="collapse-android-flow"><b>结束部分</b></a>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="ios-flow">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#ios-flow" data-target="#collapse-ios-flow" aria-expanded="false" aria-controls="collapse-ios-flow"><b>iOS启动流程</b></a>
            </h4>
        </div>

        <div id="collapse-ios-flow" class="panel-collapse collapse" role="tabpanel" aria-labelledby="ios-flow">
            <div class="panel-body">
                <p>在 iOS 平台中初始化 {{ site.data.keys.product_adj }} 框架以在使用 {{ site.data.keys.product_adj }} 的 Cordova 应用程序中显示 WebView。</p>

                <b>AppDelegate.m</b>
                <p><code>AppDelegate.m</code> 文件位于 Classes 文件夹中。 此文件可初始化 {{ site.data.keys.product_adj }} 框架，然后视图控制器将装入 WebView。</p>

                <p><code>didFinishLaunchingWithOptions</code> 方法可初始化框架：</p>

{% highlight objc %}
[[WL sharedInstance] initializeWebFrameworkWithDelegate:self];
{% endhighlight %}

                <p>在初始化成功后，<code>wlInitWebFrameworkDidCompleteWithResult</code> 将检查是否已装入 {{ site.data.keys.product_adj }} 框架，并创建连接到缺省 <b>index.html</b> 页面的 <code>MainViewController</code>。</p>

                <p>如果 Xcode 中构建 iOS Cordova 应用程序而未出错，那么可继续向本机平台和 WebView 添加功能。</p>

                <br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#ios-flow" data-target="#collapse-ios-flow" aria-expanded="false" aria-controls="collapse-ios-flow"><b>结束部分</b></a>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="windows-flow">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#windows-flow" data-target="#collapse-windows-flow" aria-expanded="false" aria-controls="collapse-windows-flow"><b>Windows启动流程</b></a>
            </h4>
        </div>

        <div id="collapse-windows-flow" class="panel-collapse collapse" role="tabpanel" aria-labelledby="windows-flow">
            <div class="panel-body">
                <p>{{ site.data.keys.product_adj }} Cordova 插件 <b>cordova-plugin-mfp</b> 使用本机异步引导程序序列。 必须先完成引导程序序列，然后 Cordova 应用程序才能装入应用程序的主 HTML 文件。</p>

                <p>向 Cordova 应用程序添加 <b>cordova-plugin-mfp</b> 插件会将 <b>index.html</b> 文件添加到应用程序的 <b>appxmanifest</b> 文件。 这将扩展 <code>CordovaActivity</code> 本机代码以执行 {{ site.data.keys.product_adj }} 初始化。</p>

                <br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#windows-flow" data-target="#collapse-windows-flow" aria-expanded="false" aria-controls="collapse-windows-flow"><b>结束部分</b></a>
            </div>
        </div>
    </div>
</div>

## Cordova 应用程序安全性
{: #cordova-application-security }
{{ site.data.keys.product_full }} 提供可帮助保护 Cordova 应用程序的安全功能。

与本机应用程序相比，未经授权的人员可更轻松地修改跨平台应用程序中的大量内容。因为跨平台应用程序中的大量共用内容采用可读取格式，因此 IBM MobileFirst Foundation 提供了可针对跨平台 Cordova 应用程序带来更高级别安全性的功能。

> 了解有关 [{{ site.data.keys.product_adj }} 安全框架](../../authentication-and-security)的更多信息

使用以下功能来提高 Cordova 应用程序的安全性：

* [加密 Cordova 软件包的 Web 资源](securing-apps/#encrypting-the-web-resources-of-your-cordova-packages)  
    加密 Cordova 应用程序的 www 文件夹中的内容，并在安装应用程序和第一次运行时进行解密。 此加密使得在打包应用程序时查看或修改此文件夹中内容变得更困难。
* [启用 Web 资源校验和功能](securing-apps/#enabling-the-web-resources-checksum-feature)  
    通过在启动应用程序时将内容与第一次启动应用程序时收集的基线校验和结果进行比较，确保应用程序的完整性。 此测试可帮助避免修改已安装的应用程序。
* [启用 FIPS 140-2](../../administering-apps/federal/#enabling-fips-140-2)  
    确保用于加密静止数据和动态数据的加密算法符合美国联邦信息处理标准 (FIPS) 140-2 标准。
* [证书置顶](../../authentication-and-security/certificate-pinning)  
    通过将主机与其期望的公用密钥相关联，帮助避免中间人攻击。

## Cordova 应用程序资源
{: #cordova-application-resources }
Cordova 应用程序需要特定资源。 在大多数情况下，在使用首选 Cordova 开发工具创建 Cordova 应用程序时，将为您生成这些资源。 如果使用 {{ site.data.keys.product }} 模板，那么还将提供启动屏幕和图标。

您可以使用 IBM 为处理 Cordova 项目而提供的项目模板，这支持使用 {{ site.data.keys.product_adj }} 功能。 如果使用此 {{ site.data.keys.product_adj }} 模板，那么将向您提供以下资源作为起点。 如果不使用 {{ site.data.keys.product_adj }} 模板，那么将提供除启动屏幕和图标之外的所有资源。 在初始创建 Cordova 项目时，通过指定 `--template` 选项和 {{ site.data.keys.product_adj }} 模板来添加模板。

如果更改任何资源的缺省文件名和路径，那么还必须在 Cordova 配置文件 (config.xml) 中指定此类更改。 此外，在某些情况下，您可以使用 mfpdev app config 命令更改缺省名称和路径。 如果可使用 mfpdev app config 命令更改名称和路径，那么将在有关特定资源的部分中注明。

### Cordova 配置文件 (config.xml)
{: #cordova-configuration-file-configxml }
Cordova 配置文件是包含应用程序元数据的必需的 XML 文件，其存储在应用程序的根目录中。在创建 Cordova 应用程序时自动生成此文件。 您可以使用 mfpdev app config 命令进行修改以添加定制属性。

### 主文件 (index.html)
{: #main-file-indexhtml}
此主文件是包含应用程序框架的 HTML5 文件。 此文件可装入定义应用程序的常规组件以及挂钩必需的文档事件所需的所有 Web 资源（脚本和样式表）。 您可以在 **your-project-name/www** 目录中找到此文件。 您可以使用 `mfpdev app config` 命令更改此文件的名称。

### 缩略图
{: #thumbnail-image }
缩略图在 {{ site.data.keys.mf_console }} 上提供应用程序的图形标识。 它必须是正方形图像，首选大小为 90 X 90 像素。  
在使用模板时提供缺省缩略图。 您可以对替换图像使用相同文件名以覆盖缺省图像。 可以在 **your-project-name/www/img** 文件夹中找到 thumbnail.png。 您可以使用 `mfpdev app config` 命令更改此文件的名称或路径。

### 启动图像
{: #splash-image }
在初始化应用程序时显示启动图像。 如果使用 {{ site.data.keys.product_adj }} 缺省模板，那么将提供启动图像。 这些缺省图像存储在以下目录中：

* iOS：<your project name>/res/screen/ios/
* Android：<your project name>/res/screen/android/
* Windows：<your project name>/res/screen/windows/

包含各种缺省启动图像以适合不同的显示器、iOS 和 Windows 以及不同版本的操作系统。 您可以将模板随附的缺省图像替换为自己的启动图像，或者添加图像（如果不使用模板）。 在使用 {{ site.data.keys.product_adj }} 模板针对 Android 平台构建应用程序时，将安装 **cordova-plugin-splashscreen** 插件。 在集成此插件时，将显示 Cordova 使用的启动图像来代替 {{ site.data.keys.product }} 使用的图像。 文件夹中采用 screen.png 格式的图像是 Cordova 标准启动图像。 您可以通过更改 Cordova **config.xml** 文件中的设置来指定显示的启动图像。

如果不使用 {{ site.data.keys.product_adj }} 模板，那么显示的缺省启动图像是 {{ site.data.keys.product }} 插件使用的图像。 缺省 {{ site.data.keys.product_adj }} 源启动图像的文件名采用 **splash-string.9.png** 格式。

> 有关使用自己的启动图像的更多信息，请参阅[向 Cordova 应用程序添加定制启动屏幕和图标](adding-images-and-icons)。

### 应用程序图标
{: #application-icons }
模板随附应用程序图标的缺省图像。 这些缺省图像存储在以下目录中：

* iOS：<your project name>/res/icon/ios/
* Android：<your project name>/res/icon/android/
* Windows：<your project name>/res/icon/windows/

您可以将缺省图像替换为自己的图像。 定制应用程序图像必须匹配要替换的缺省应用程序图像的大小，并且必须使用相同的文件名。 提供各种各样的缺省图像以适合不同的显示器和操作系统版本。

> 有关使用自己的启动图像的更多信息，请参阅[向 Cordova 应用程序添加定制启动屏幕和图标](adding-images-and-icons)。

### 样式表
{: #stylesheets }
应用程序代码可以包括用于定义应用程序视图的 CSS 文件。

样式表文件位于 <your project name>/www/css 目录中，并且将复制到以下特定于平台的文件夹：

* iOS：<your project name>/platforms/ios/www/css
* Android：<your project name>/platforms/android/assets/www/css
* Windows：<your project name>/platforms/windows/www/css

### 脚本
{: #scripts }
应用程序代码可包含 JavaScript 文件，这些文件可实现应用程序的各个功能，例如，交互式用户界面组件、业务逻辑和后端查询集成。

模板提供 JavaScript 文件 index.js，此文件位于 **your-project-name/www/js** 文件夹中。 此文件将复制到以下特定于平台的文件夹：

* iOS：<your project name>/platforms/ios/www/js
* Android：<your project name>/platforms/android/assets/www/js
* Windows：<your project name>/platforms/windows/assets/www/js

## 预览应用程序的 Web 资源
{: #previewing-an-applications-web-resources }
可在 iOS 模拟器、Android 仿真器、Windows 仿真器或物理设备中预览 Cordova 应用程序的 Web 资源。 在 {{ site.data.keys.product }} 中，提供两个额外的实时预览选项：{{ site.data.keys.mf_mbs_full }} 和简单浏览器呈现。

> <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> **安全限制：**您可以预览 Web 资源，但是模拟器并非支持所有 {{ site.data.keys.product_adj }} JavaScript API。 特别是，不完全支持 OAuth 协议。 但是，可以使用 `WLResourceRequest` 测试适配器调用。 在这种情况下，
>
> * 安全性检查不在服务器端运行，也不会将安全验证问题发送到在 {{ site.data.keys.mf_mbs }} 中运行的客户机。
> * 如果不在开发环境中使用 {{ site.data.keys.mf_server }}，请注册在允许的作用域列表中包含适配器作用域的保密客户机。 您可以通过 {{ site.data.keys.mf_console }} 使用“运行时/设置”菜单来定义保密客户机。 有关保密客户机的更多信息，请参阅[保密客户机](../../authentication-and-security/confidential-clients)。
>
> **注：**开发环境中的 {{ site.data.keys.mf_server }} 包含一个保密客户机“test”，其中具有无限制的允许范围（“*”）。 缺省情况下，mfpdev 应用程序预览使用此保密客户机。

#### 简单浏览器
{: #simple-browser }
在“简单浏览器”预览中，将在桌面浏览器中呈现应用程序的 Web 资源，而不将这些资源视为“应用程序”，这仅支持对 Web 资源进行简单调试。  

#### {{ site.data.keys.mf_mbs }}
{: #mobile-browser-simulator }
{{ site.data.keys.mf_mbs }} 是一个 Web 应用程序，其支持通过模拟设备功能来测试 Cordova 应用程序，而无需在仿真器或物理设备中安装应用程序。

**受支持的浏览器：**

* Firefox V38 和更高版本
* Chrome 49 和更高版本
* Safari 9 和更高版本

### 预览
{: #previewing }
1. 从**命令行**窗口，运行以下命令：

    ```bash
    mfpdev app preview
    ```

2. 选择预览选项：

    ```bash
    ? Select how to preview your app: (Use arrow keys)
    ❯ browser: Simple browser rendering
    mbs: Mobile Browser Simulator
    ```
3. 选择一个平台以进行预览（仅显示已添加的平台）：

    ```bash
    ❯◯ android
    ◯ ios
	```

> <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> **提示：** 在 [使用 CLI 来管理 {{ site.data.keys.product_adj }} 工件](../using-mobilefirst-cli-to-manage-mobilefirst-artifacts/) 教程中了解有关各个 CLI 命令的更多信息。

### 实时预览
{: #live-preview }
现在，可以使用实时预览实时编辑适用的代码（HTML、CSS 和 JS）。   
在对资源进行更改后，保存更改并且更改将立即反映在浏览器中。

### 实时重新装入
{: #live-reload }
要在物理设备或模拟器/仿真器中预览时实现类似效果，请添加 **cordova-plugin-livereload** 插件。 有关用法指示信息，[请参阅插件 GitHub 页面](https://github.com/omefire/cordova-plugin-livereload)。

### 在仿真器或物理设备上运行应用程序
{: #running-the-application-on-emulator-or-on-a-physical-device }
要模拟应用程序，请执行 Cordova CLI 命令 `cordova emulate ios|android|windows`。 例如：

```bash
cordova emulate ios
```

要在附加到开发工作站的物理设备上运行应用程序，请运行 Cordova CLI 命令 `cordova run ios|android|windows`。 例如：

```bash
cordova run ios
```

## 实现 JavaScript 代码
{: #implementing-javascript-code }
使用针对 JavaScript 提供自动补全的 IDE 可更方便地编辑 WebView 资源。

Xcode、Android Studio 和 Visual Studio 提供完整编辑功能，以供编辑 Objective C、Swift、C# 和 Java，但是可能限制帮助编辑 JavaScript 的方式。 为促进 JavaScript 编辑，{{ site.data.keys.product_adj }} Cordova 项目包含一个定义文件以供针对 {{ site.data.keys.product_adj }} API 元素提供自动补全。

每个 {{ site.data.keys.product_adj }} Cordova 插件都针对每个 {{ site.data.keys.product_adj }} JavaScript 文件提供一个 `d.ts` 配置文件。 `d.ts` 文件名与相应的 JavaScript 文件名匹配，其位于 plug-in 文件夹中。 例如，对于主 {{ site.data.keys.product_adj }} SDK，文件位于：**[myapp]\plugins\cordova-plugin-mfp\typings\worklight.d.ts**。

`d.ts` 配置文件针对支持 TypeScript 的所有 IDE 提供自动补全功能：[TypeScript Playground](http://www.typescriptlang.org/Playground/)、[Visual Studio Code](http://www.microsoft.com/visualstudio/eng)、[WebStorm](http://www.jetbrains.com/webstorm/)、[WebEssentials](http://visualstudiogallery.msdn.microsoft.com/6ed4c78f-a23e-49ad-b5fd-369af0c2107f)、[Eclipse](https://github.com/palantir/eclipse-typescript)。

WebView 的资源（HTML 和 JavaScript 文件）位于 **[myapp]\www** 文件夹中。 在使用 cordova build 命令构建项目或者在运行 cordova prepare 命令后，这些资源将被复制到 **[myapp]\platforms\ios\www**、**[myapp]\platforms\android\assets\www** 或 **[myapp]\platforms\windows\www** 文件夹下对应的 **www** 文件夹中。

在打开包含先前一个 IDE 的主应用程序文件夹时，将保留上下文。 IDE 编辑器现在将链接到相关的 `d.ts` 文件并在您输入时自动补全 {{ site.data.keys.product_adj }} API 元素。

## 针对 Android 的 CrossWalk 支持
{: #crosswalk-support-for-android }
针对 Android 平台的 Cordova 应用程序可将其缺省 WebView 替换为 [CrossWalk WebView](https://crosswalk-project.org/)。  
要进行添加：

1. 从 **命令行** 中，运行以下命令：

   ```bash
   cordova plugin add cordova-plugin-crosswalk-webview
   ```

   此命令会将 CrossWalk WebView 添加到应用程序。  
    在后台，{{ site.data.keys.product_adj }} Cordova SDK 将调整 Android 项目活动以供使用。

2. 通过运行以下命令构建项目：

   ```bash
   cordova build
   ```

## 针对 iOS 的 WKWebView 支持
{: #wkwebview-support-for-ios }
Cordova iOS 应用程序中使用的缺省 UIWebView 可替换为 [Apple 的 WKWebView](https://developer.apple.com/library/ios/documentation/WebKit/Reference/WKWebView_Ref/)。  
要添加，请从命令行窗口运行以下命令：`cordova plugin add cordova-plugin-wkwebview-engine`。

> 了解有关 [Cordova WKWebView 插件](https://github.com/apache/cordova-plugin-wkwebview-engine) 的更多信息。

## 进一步阅读
{: #further-reading }
了解有关 Cordova 的更多信息：

- [Cordova 概述](https://cordova.apache.org/docs/en/latest/guide/overview/index.html)
- [Cordova 最佳实践、测试、调试、注意事项以及获取最新信息](https://cordova.apache.org/docs/en/latest/guide/next/index.html#link-testing-on-a-simulator-vs-on-a-real-device)
- [Cordova 应用程序开发入门](https://cordova.apache.org/#getstarted)

## 接下来的教程
{: #tutorials-to-follow-next }
从 [向 Cordova 应用程序添加 MobileFirst SDK](../../application-development/sdk/cordova) 开始，然后在 [所有教程](../../all-tutorials/) 部分中查看 {{ site.data.keys.product_adj }} 提供的功能。
