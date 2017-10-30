---
layout: tutorial
title: 已知问题和限制
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## 已知问题
{: #known-issues }
单击以下链接以接收针对该特定发行版及其所有修订包动态生成的文档列表，包括已知问题及其解决办法和相关下载：[http://www.ibm.com/support/search.wss?tc=SSVNUQ&tc=SSHT2F&atrn=SWVersion&atrv=8.0](http://www.ibm.com/support/search.wss?tc=SSVNUQ&tc=SSHT2F&atrn=SWVersion&atrv=8.0)。

## 已知限制
{: #known-limitations }
在本文档中，您可以在不同的位置中找到 {{ site.data.keys.product_full }} 已知限制的描述：

* 如果已知限制适用于某个特定功能，可在说明此特定功能的主题中找到其描述信息。 然后即可发现它对此功能有何影响。
* 如果已知限制是常规限制（即适用于可能不会直接相关的不同主题），可在此处找到其描述信息。

### 全球化
{: #globalization }
如果需要开发全球化应用程序，则以下限制适用：

* 部分翻译：{{ site.data.keys.product }} V8.0 产品的部分内容（包括其文档）已翻译为以下语言：简体中文、繁体中文、法语、德语、意大利语、日语、韩国语、葡萄牙语（巴西）、俄语和西班牙语。 已经翻译了面向用户的文本。
* 双向支持：{{ site.data.keys.product }}
生成的应用程序未全部支持双向。 缺省情况下，不提供图形用户界面 (GUI) 元素的镜像和文本方向的控制。 但是，生成的应用程序对此限制没有严重依赖关系。 开发人员在生成的代码中手动调整即可实现完整的 bidi 合规性。

虽然针对 {{ site.data.keys.product }} 核心功能提供希伯来语翻译，但是某些 GUI 元素可能未进行镜像。

* 对适配器名称的约束：适配器的名称必须是用于创建 Java 类名的有效名称。 另外，只能由以下字符组成：
    * 大小写字母（A-Z 和 a-z）
    * 数字 (0-9)
    * 下划线 (_)

* Unicode 字符：不支持基本多语言面之外的 Unicode 字符。
* 语言敏感度和 Unicode 规范化表单：在以下用例中，查询不会考虑语言敏感度（如正常匹配、不区分重音符、不区分大小写以及 1 对 2 映射），从而使搜索功能在不同语言中正常运行，并且对数据的搜索不会使用规范化表单 C (NFC)。
    * 从 {{ site.data.keys.mf_analytics_console }} 上为定制图表创建定制过滤器时。 但是，在此控制台中，消息属性使用规范化表单 C (NFC) 并考虑语言敏感度。
    * 从 {{ site.data.keys.mf_console }} 上在“浏览应用程序”页面中搜索应用程序、在“浏览适配器”页面中搜索适配器、在“推送”页面中搜索标记以及在“设备”页面上搜索设备时。
    * 在 JSONStore API 的查找功能中。

### {{ site.data.keys.mf_analytics }}
{: #mobilefirst-analytics }
{{ site.data.keys.mf_analytics }} 具有以下限制：

* 不支持安全性分析（未通过安全性检查的请求上的数据）。
* 在 {{ site.data.keys.mf_analytics_console }} 中，数字格式不遵循 International Components for Unicode (ICU) 规则。
* 在 {{ site.data.keys.mf_analytics_console }} 中，数字不使用用户的首选数字脚本。
* 在 {{ site.data.keys.mf_analytics_console }} 中，根据操作系统的语言设置而不是 Microsoft
Internet Explorer 的语言环境来显示日期、时间和数字的格式。
* 在针对定制图表创建定制过滤器时，数字数据必须是 10 进制的西方或欧洲数字，例如，0、1、2、3、4、5、6、7、8、9。
* 在 {{ site.data.keys.mf_analytics_console }} 的“警报管理”页面中创建警报时，数字数据必须是 10 进制的西方或欧洲数字，例如，0、1、2、3、4、5、6、7、8、9。
* {{ site.data.keys.mf_console }} 的“分析”页面支持以下浏览器：
    * Microsoft Internet Explorer V10 或更高版本
    * Mozilla Firefox ESR 或更高版本
    * iOS V7.0 或更高版本上的 Apple Safari
    * Google Chrome 最新版本
* Analytics 客户机 SDK 不可用于 Windows。


### {{ site.data.keys.mf_app_center_full }} 移动客户端
{: #ibm-mobilefirst-foundation-application-center-mobile-client }
Application
Center 移动式客户机遵循运行中设备的文化约定，如日期格式。 它不一定遵循更严格的 International Components for Unicode (ICU) 规则。

### {{ site.data.keys.mf_console_full }}
{: #ibm-mobilefirst-operations-console }
{{ site.data.keys.mf_console }} 具有以下限制：

* 仅支持部分双向语言。
* 向 Android 设备发送通知消息时无法更改文本方向。
    * 如果输入的前几个字母使用的是从右向左方向的语言（例如，阿拉伯语或希伯来语），那么整个文本方向自动调整为从右向左。
    * 如果输入的前几个字母使用的是从左向右方向的语言，那么整个文本方向
自动调整为从左向右。
* 在双向语言中，字符顺序和文本对齐与文化习惯不匹配。
* 数字字段不会根据语言环境的格式化规则来解析数字值。 控制台将显示格式化数字，但仅接受 *raw*（非格式化）数字作为输入。 例如，接受 1000，但不接受 1 000 或 1,000。
* {{ site.data.keys.mf_console }} 的“分析”页面中的响应时间取决于多个因素，如硬件（RAM 和 CPU）、累计分析数据的数量和 {{ site.data.keys.mf_analytics }} 集群。 请考虑在将 {{ site.data.keys.mf_analytics }} 集成到生产之前测试负载。

### Server Configuration Tool
{: #server-configuration-tool }
Server Configuration Tool 受到以下限制：

* 服务器配置的描述性名称仅能包含系统字符集中的字符。 在 Windows 上，为 ANSI 字符集。
* 包含单引号或双引号字符的密码可能无法正确运行。
* Server Configuration Tool 的控制台在显示不属于缺省代码页的字符串时，与 Windows 控制台具有相同的全球化限制。

由于其他产品（例如浏览器、数据库管理系统或软件开发包）的限制，可能会在全球化的各个方面受到限制或发生异常。 例如：

* 只能使用 ASCII 字符来定义 Application Center 的用户名和密码。 由于 WebSphere Application Server（Full Profile 或 Liberty Profile）不支持非 ASCII 密码和用户名，因此存在此限制。 请参阅“对用户标识和密码有效的字符”。
* 在 Windows 上：
    * 要查看测试服务器所创建的日志文件中的任何本地化消息，必须使用 UTF-8 编码打开此日志文件。
    * 由于以下原因导致存在这些限制：
        * 测试服务器安装在 WebSphere Application Server Liberty 概要文件上，后者使用 ANSI 编码创建日志文件，但对于其本地化消息则使用 UTF8 编码。

* 在 Java 7.0 Service Refresh 4-FP2 和先前版本中，无法将不属于基本多文种平面的 Unicode 字符粘贴到输入字段中。 要避免此问题，可以手动创建路径文件夹并在安装过程中选择该文件夹。
* 警报、确认和提示方法的定制标题和按钮名称必须尽量简短以避免在屏幕边缘截断字符。
* JSONStore 不能处理规范化。 JSONStore API 的查找功能不会考虑语言敏感度，如不区分重音符、不区分大小写以及 1 对 2 映射。

### 适配器与第三方依赖关系
{: #adapters-and-third-party-dependencies }
以下已知问题与应用程序服务器（包括 {{ site.data.keys.product_adj }} 共享库）中的依赖关系和类之间的交互相关。

#### Apache HttpClient
{: #apache-httpclient }
{{ site.data.keys.product }} 在内部使用 Apache HttpClient。 如果将 Apache HttpClient 实例作为依赖关系添加到 Java 适配器，以下 API 在适配器中无法正常工作：`AdaptersAPI.executeAdapterRequest、AdaptersAPI.getResponseAsJSON` 和 `AdaptersAPI.createJavascriptAdapterRequest`。 原因是这些 API 的签名中包含 Apache HttpClient 类型。 变通方法是使用内部 Apache HttpClient，但将 **pom.xml** 中的依赖关系作用域更改为 provided。

#### Bouncy Castle 密码库
{: #bouncy-castle-cryptographic-library }
{{ site.data.keys.product }} 本身使用 Bouncy Castle。 可以在适配器中使用其他版本的 Bouncy Castle，但需要对结果进行仔细测试：有时，{{ site.data.keys.product_adj }} Bouncy Castle 代码会填充 `javax.security` 程序包类的某些静态单项字段，并可能阻止适配器内的 Bouncy Castle 版本使用依赖于这些字段的功能。

#### JAR 文件的 Apache CXF 实施
{: #apache-cxf-implementaton-of-jar-files }
在 {{ site.data.keys.product_adj }} JAX-RS 实施中使用 CXF，从而阻止您将 Apache CXF JAR 文件添加到适配器。

### Application Center 移动式客户机：Android 4.0.x 上的刷新问题
{: #application-center-mobile-client-refresh-issues-on-android-40x}
Android 4.0.x WebView 组件存在多个已知的刷新问题。 将设备更新到 Android 4.1.x 会提供更佳的用户体验。

如果通过源构建 Application Center 客户机，那么在应用程序级别禁用 Android 清单中的硬件加速会改善 Android 4.0.x 的状况。 在这种情况下，应用程序必须使用 Android SDK 11 或更高版本来构建。

### Application Center 需要 MobileFirst Studio V7.1 来导入和构建 Application Center 移动式客户机
{: #application-center-requires-mobilefirst-studio-v71-for-importing-and-building-the-application-center-mobile-client }
要构建 Application Center 移动式客户机，需要 MobileFirst Studio V7.1。 您可以从[下载页面]({{site.baseurl}}/downloads)下载 MobileFirst Studio。 单击**上一 MobileFirst Platform Foundation 发行版**选项卡以获取下载链接。 有关安装指示信息，请参阅[针对 V7.1 的 IBM Knowledge Center 中的安装 MobileFirst Studio](https://www.ibm.com/support/knowledgecenter/SSHS8R_7.1.0/com.ibm.worklight.installconfig.doc/devenv/t_installing_ibm_worklight_studi.html)。 有关构建 Application Center 移动式客户机的更多信息，请参阅[有关使用移动式客户机的准备工作](../../../appcenter/preparations)。

### Application Center 和 Microsoft Windows Phone 8.1
{: #application-center-and-microsoft-windows-phone-81 }
Application Center 支持将 Microsoft
Windows Phone 8.0 和 Microsoft
Windows Phone 8.1 的应用程序作为 Windows Phone 应用程序包 (.xap) 文件进行分发。 通过 Microsoft
Windows Phone 8.1，Microsoft 引入了一种新的通用格式，即 Windows Phone 的应用程序包 (.appx) 文件。 目前，Application Center 不支持分发 Microsoft
Windows Phone 8.1 的应用程序包 (.appx) 文件，而仅支持分发 Windows Phone 应用程序包 (.xap) 文件。

Application Center 仅支持分发 Microsoft
Windows Store（桌面应用程序）的应用程序包 (.appx) 文件。

### 通过 Ant 或命令行来管理 {{ site.data.keys.product_adj }} 应用程序
{: #administering-mobilefirst-applications-through-ant-or-through-the-command-line }
如果仅下载并安装 {{ site.data.keys.mf_dev_kit_full }}，那么 **mfpadm** 工具不可用。 通过安装程序将 mfpadm 工具随 {{ site.data.keys.mf_server }} 一起安装。

### 保密客户机
{: #confidential-clients }
仅限针对保密客户机标识和密钥的值使用 ASCII 字符。

### 直接更新
{: #direct-update }
在 V8.0.0 中不支持在 Windows 上直接更新。

### FIPS 140-2 功能限制
{: #fips-104-2-feature-limitations }
在 {{ site.data.keys.product }} 中使用 FIPS 140-2 功能时，以下已知限制适用：
* 这一经 FIPS 140-2 验证的方式仅适用于保护（加密）由 JSONStore 功能存储的本地数据以及保护 {{ site.data.keys.product_adj }} 客户端和 {{ site.data.keys.mf_server }} 之间的 HTTPS 通信。
    * 对于 HTTPS 通信，仅 {{ site.data.keys.product_adj }} 客户端和 {{ site.data.keys.mf_server }} 之间的通信使用客户端上的 FIPS 140-2 库。 直接连接到其他服务器或服务时不使用 FIPS 140-2 库。
* 该功能仅在 iOS 和 Android 平台上受支持。
    * 在 Android 上，仅在使用 x86 或 armeabi 体系结构的设备或模拟器上支持此功能。 在使用 armv5 或 armv6 体系结构的 Android 上不受支持。 原因在于使用的 OpenSSL 库未获取针对 Android 上的 armv5 或 armv6 的 FIPS 140-2 验证。 即使 {{ site.data.keys.product_adj }} 库支持 64 位体系结构，FIPS 140-2 在 64 位体系结构上也不受支持。 如果项目仅包含 32 位本机 NDK 库，那么 FIPS 140-2 可以在 64 位设备上运行。
    * 在 iOS 上，在 i386、x86_64、armv7、armv7s 和 arm64 体系结构上支持此功能。
* 此功能只能与混合应用程序一起使用，而不能与本机应用程序一起使用。
* 对于本机 iOS，可通过 iOS FIPS 库启用 FIPS，并且缺省情况下已启用 FIPS。 无需执行任何操作来启用 FIPS 140-2。
* FIPS 140-2 功能不支持使用客户机上的用户注册功能。
* Application Center 客户端不支持 FIPS 140-2 功能。

### 安装 Application Center 或 {{ site.data.keys.mf_server }} 的修订包或临时修订
{: #installation-of-a-fix-pack-or-interim-fix-to-the-application-center-or-the-mobilefirst-server }
对 Application Center 或 {{ site.data.keys.mf_server }} 应用修订包或临时修订时，需要执行手动操作，并且您可能必须将应用程序关闭一段时间。

### JSONStore 支持的体系结构
{: #jsonstore-supported-architectures }
对于 Android，JSONStore 支持以下体系结构：ARM、ARM
v7 和 x86 32 位。 当前不支持其他体系结构。 尝试使用其他体系结构将导致异常，并且应用程序可能崩溃。

Windows 本机应用程序不支持 JSON Store。

### Liberty 服务器限制
{: #liberty-server-limitations }
如果在 32 位 JDK 7 上使用 Liberty 服务器，Eclipse 可能不会启动，并且可能收到以下错误：“初始化 VM 时出错。 无法为对象堆保留足够的空间。 错误：无法创建 Java 虚拟机。 错误：发生了致命异常。 程序将退出。”

要解决该问题，请将 64 位 JDK 与 64 位 Eclipse 和 64 位 Windows 一起使用。 如果在 64 位计算机上使用 32 位 JDK，可以将 JVM 首选项配置为 **mx512m** 和 **Xms216m**。

### LTPA 令牌限制
{: #ltpa-token-limitations }
在用户会话到期之前，当 LTPA 令牌到期时发生了 `SESN0008E` 异常。

LTPA 令牌已关联到当前的用户会话。 如果该会话在 LTPA 令牌到期之前到期，那么将自动创建新会话。 但是，如果 LTPA 令牌在用户会话到期之前到期，将发生以下异常：

`com.ibm.websphere.servlet.session.UnauthorizedSessionRequestException: SESN0008E: A user authenticated as anonymous has attempted to access a session owned by {user name}`

要解决该限制，必须强制用户会话在 LTPA 令牌到期时到期。
* 在 WebSphere Application Server Liberty 上，将 server.xml 文件中的 httpSession 属性 invalidateOnUnauthorizedSessionRequestException 设置为 true。
* 在 WebSphere Application Server 上，添加值为 true 的会话管理定制属性 InvalidateOnUnauthorizedSessionRequestException，以修复该问题。

**注：**在某些 WebSphere Application Server 或 WebSphere Application Server Liberty 版本上，仍然会记录该异常，但是会话将以正常的方式失效。 有关更多信息，[请参阅 APAR PM85141](http://www.ibm.com/support/docview.wss?uid=swg1PM85141)。

### Microsoft Windows Phone 8
{: #microsoft-windows-phone-8 }
对于 Windows Phone 8.1 环境，不支持 x64 体系结构。

### Microsoft Windows 10 UWP 应用程序
{: #microsoft-windows-10-uwp-apps }
当通过 NuGet 包安装 {{ site.data.keys.product_adj }} SDK 时，应用程序真实性功能将在 {{ site.data.keys.product_adj }} Windows 10 UWP 应用程序上无法工作。 作为变通方法，开发人员可以下载 NuGet 包并手动添加 {{ site.data.keys.product_adj }} SDK 引用。

### 嵌套项目可能导致 CLI 出现不可预测的结果
{: #nested-projects-can-result-in-unpredictable-results-with-the-cli }
在使用 {{ site.data.keys.mf_cli }} 时请勿将项目嵌套在另一个项目中。 否则，所操作的项目可能不是您预期的项目。

### 使用 {{ site.data.keys.mf_mbs }} 预览 Cordova Web 资源
{: #previewing-cordova-web-resources-with-the-mobile-browser-simulator }
您可以使用 {{ site.data.keys.mf_mbs }} 预览 Web 资源，但此模拟器并不支持所有的 {{ site.data.keys.product_adj }} JavaScript API。 尤其是不完全支持 OAuth 协议。 但是，可以使用 `WLResourceRequest` 测试适配器调用。

### 测试扩展应用程序真实性所需的物理 iOS 设备
{: #physical-ios-device-required-for-testing-extended-app-authenticity }
测试扩展应用程序真实性特征需要一台物理 iOS 设备，因为 IPA 不能安装在 iOS 模拟器上。

### {{ site.data.keys.mf_server }} 提供的 Oracle 12c 支持
{: #support-of-oracle-12c-by-mobilefirst-server }
{{ site.data.keys.mf_server }} 的安装工具（Installation Manager、Server Configuration Tool 和 Ant 任务）支持 Oracle 12c 作为数据库进行安装。

用户和表可以由安装工具创建，但是在您运行安装工具前，必须存在一个或多个数据库。

### 推送通知支持
{: #support-for-push-notification }
在 Cordova（iOS 和 Android 上）中支持不安全推送。

### 更新 cordova-ios 平台
{: #updating-cordova-ios-platform }
要更新 Cordova 应用程序的 cordova-ios 平台，必须通过完成以下步骤来卸载并重新安装此平台：

1. 使用命令行界面浏览至该应用程序的项目目录。
2. 运行 `cordova platform rm ios` 命令以除去该平台。
3. 运行 `cordova platform add ios@version` 命令以将新平台添加到该应用程序中，其中版本即 Cordova iOS 平台的版本。
4. 运行 `cordova prepare` 命令以集成更改。

如果使用 `cordova platform update ios` 命令，更新将失败。

### Web 应用程序
{: #web-applications }
Web 应用程序具有以下限制：
- {: #web_app_limit_ms_ie_n_edge }
在 Microsoft Internet Explorer (IE) 和 Microsoft Edge 中，将根据操作系统的地区格式首选项而不根据配置的浏览器或操作系统显示语言首选项来显示管理应用程序消息和客户端 Web SDK 消息。 另请参阅[定义多种语言的管理员消息](../../../administering-apps/using-console/#defining-administrator-messages-in-multiple-languages)。

### 针对 iOS Cordova 应用程序的 WKWebView 支持
{: #wkwebview-support-for-ios-cordova-applications }
应用程序通知和“直接更新”功能可能在具有 WKWebView 的 iOS Cordova 应用程序中无法正确工作。

此限制是由于 **cordova-plugin-wkwebview-engine** 中存在缺陷：file:// url XmlHttpRequests are not allowed in WKWebViewEgine。

要避开此问题，请在 Cordova 项目中运行以下命令：`cordova plugin add https://github.com/apache/cordova-plugins.git#master:wkwebview-engine-localhost`

执行此命令将在 Cordova 应用程序中运行本地 Web 服务器，然后您可以托管和访问本地文件，而无需使用文件 URI 方案 (file://) 来处理本地文件。

**注：**此 Cordova 插件不发布至 Node Package Manager (npm)。

### cordova-plugin-statusbar 不适用于已装入 cordova-plugin-mfp 的 Cordova 应用程序。
{: #cordova-plugin-statusbar-does-not-work-with-cordova-application-loaded-with-cordova-plugin-mfp }
cordova-plugin-statusbar 不适用于已装入 cordova-plugin-mfp 的 Cordova 应用程序。

要避开此问题，开发人员必须将 `CDVViewController` 设置为 root 视图控制器。 按以下 Cordova iOS 项目的 **MFPAppdelegate.m** 文件中的建议替换 `wlInitDidCompleteSuccessfully` 方法中的代码片段。

现有代码片段：

```objc
(void)wlInitDidCompleteSuccessfully
{
UIViewController* rootViewController = self.window.rootViewController; 
// Create a Cordova View Controller 
CDVViewController* cordovaViewController = [[CDVViewController alloc] init] ; 
cordovaViewController.startPage = [[WL sharedInstance] mainHtmlFilePath]; 
// Adjust the Cordova view controller view frame to match its parent view bounds 
cordovaViewController.view.frame = rootViewController.view.bounds; 
// Display the Cordova view [rootViewController addChildViewController:cordovaViewController]; 
[rootViewController.view addSubview:cordovaViewController.view]; 
[cordovaViewController didMoveToParentViewController:rootViewController]; 
}
```

含针对此限制的变通方法的建议的代码片段：

```objc
(void)wlInitDidCompleteSuccessfully
{
 // Create a Cordova View Controller 
CDVViewController* cordovaViewController = [[CDVViewController alloc] init] ; 
cordovaViewController.startPage = [[WL sharedInstance] mainHtmlFilePath]; 
[self.window setRootViewController:cordovaViewController]; 
[self.window makeKeyAndVisible];
}
```

### 在 Android 应用程序中不支持原始 IPv6 地址
{: #raw-ipv6-address-not-supported-in-android-applications }
在为本机 Android 应用程序配置 **mfpclient.properties** 期间，如果 {{ site.data.keys.mf_server }} 位于具有 IPv6 地址的主机上，那么请使用此 IPV6 地址的映射的主机名在 **mfpclient.properties** 中配置 **wlServerHost** 属性。 使用原始 IPv6 地址配置 **wlServerHost** 属性将导致应用程序连接到 {{ site.data.keys.mf_server }} 的尝试失败。

### 不建议修改 Cordova 应用程序的缺省行为
{:  #modifying_default_behaviour_of_a_cordova_app_is_not_recommended}
如果在将 {{ site.data.keys.product_adj }} Cordova SDK 添加到项目时修改 Cordova 应用程序的缺省行为（如覆盖后退按钮行为），可能会导致提交时应用程序被 Google Play Store 拒绝。
如果在提交到 Google Play Store 时遇到其他失败情况，可以联系 Google 支持人员。
