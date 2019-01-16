---
layout: tutorial
title: 临时修订中的新增内容
breadcrumb_title: Interim iFixes
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
<br/>
临时修订中提供一些修补程序和更新，用于纠正问题并且使 {{ site.data.keys.product_full }} 针对新的移动操作系统发行版来说始终为最新状态。

临时修订是累积式的。 下载最新的 V8.0 临时修订，即表示您已获得较早临时修订中的所有修订。

下载并安装最新临时修订，以获得以下部分中描述的所有修订。 如果安装较早的修订，那么可能无法获得此处描述的所有修订。

> 要获取 {{ site.data.keys.product }} 8.0 的临时修订发行版的列表，[请参阅此处]({{site.baseurl}}/blog/tag/iFix_8.0/)。

如果列示了 APAR 编号，那么可以通过在临时修订 README 文件中搜索该 APAR 编号来确认该临时修订中是否具有此功能。

### 随 CD 更新 3 (8.0.0.0-MFPF-IF201811050432-CDUpdate-03) 引入的功能

##### <span style="color:NAVY">**在 iOS 上支持刷新令牌**</span>

Mobile Foundation 从此 CD 更新开始在 iOS 上引入了刷新令牌功能。[了解更多信息]({{site.baseurl}}/tutorials/en/foundation/8.0/authentication-and-security/#refresh-tokens)。

##### <span style="color:NAVY">**从 Mobile Foundation 控制台下载管理 CLI (*mfpadm*)**</span>

现在，可以从 Mobile Foundation 控制台的*下载中心*来下载 Mobile Foundation 管理 CLI (*mfpadm*)。

##### <span style="color:NAVY">**对 Node v8.x for MobileFirst CLI 的支持**</span>

从此临时修订 (*8.0.0.0-MFPF-IF201810040631*) 开始，Mobile Foundation 添加了对 Node v8.x for MobileFirst CLI 的支持。

##### <span style="color:NAVY">**针对 Cordova 项目移除了有关 *libstdc++* 的依赖关系**</span>

从此临时修订 (*8.0.0.0-MFPF-IF201809041150*) 开始，引入了一个更改，将移除作为 Cordova 项目的依赖关系 *libstdc++* 。运行在 iOS 12 上的新应用程序需要此功能。有关进一步的详细信息，如变通方法，请参阅[此博客帖子](https://mobilefirstplatform.ibmcloud.com/blog/2018/07/23/mfp-support-for-ios12/)。

### 随 CD 更新 2 (8.0.0.0-MFPF-IF201807180449-CDUpdate-02) 引入的功能

##### <span style="color:NAVY">**对 React Native 开发的支持**</span>

从 CD 更新 (*8.0.0.0-MFPF-IF201807180449-CDUpdate-02*) 开始，Mobile Foundation [宣布]({{site.baseurl}}/blog/2018/07/24/React-Native-SDK-Mobile-Foundation/)了对 React Native 开发的支持，同时提供了 IBM Mobile Foundation SDK for React Native 应用程序。[了解更多信息]({{site.baseurl}}/tutorials/en/foundation/8.0/reactnative-tutorials/)。

##### <span style="color:NAVY">**已实现 JSONStore 集合与 iOS 和 Cordova SDK 的 CouchDB 数据库的自动同步**</span>

从 CD 更新 (*8.0.0.0-MFPF-IF201807180449-CDUpdate-02*) 开始，通过使用 MobileFirst iOS SDK 和 Cordova SDK，您可以实现设备上 JSONStore 集合与任何风格的 CouchDB 数据库（包括 [Cloudant](https://www.ibm.com/in-en/marketplace/database-management)）之间的自动数据同步。有关此功能的更多信息，请阅读此[博客帖子]({{site.baseurl}}/blog/2018/07/24/jsonstoresync-couchdb-databases-ios-and-cordova/)。

##### <span style="color:NAVY">**引入了刷新令牌**</span>

从 CD 更新 (*8.0.0.0-MFPF-IF201807180449-CDUpdate-02*) 开始，Mobile Foundation 现在引入了名为刷新令牌的特殊类型的令牌，可用于请求新的访问令牌。[了解更多信息]({{site.baseurl}}/tutorials/en/foundation/8.0/authentication-and-security/#refresh-tokens)。

##### <span style="color:NAVY">**支持 Cordova v8 和 Cordova Android v7**</span>

从此临时修订 (*8.0.0.0-MFPF-IF201804051553*) 开始，支持 Cordova v8 和 Cordova Android v7 的 MobileFirst Cordova 插件。要使用所提及版本的 Cordova，您必须获取最新的 MobileFirst 插件并升级至最新的 CLI (mfpdev-cli) 版本。有关个别平台的受支持版本的详细信息，请参阅[向 Cordova 应用程序添加 MobileFirst Foundation SDK]({{site.baseurl}}/tutorials/en/foundation/8.0/application-development/sdk/cordova/#support-levels)。

##### <span style="color:NAVY">**已实现 JSONStore 集合与 CouchDB 数据库的自动同步**</span>

从此临时修订 (*8.0.0.0-MFPF-IF201802201451*) 开始，通过使用 MobileFirst Android SDK，您可以实现设备上 JSONStore 集合与任何风格的 CouchDB 数据库（包括 [Cloudant](https://www.ibm.com/in-en/marketplace/database-management)）之间的自动数据同步。有关此功能的更多信息，请阅读此[博客帖子]({{site.baseurl}}/blog/2018/02/23/jsonstoresync-couchdb-databases/)。

### 随 CD 更新 1 (8.0.0.0-MFPF-IF201711230641-CDUpdate-01) 引入的功能

##### <span style="color:NAVY">**对 Eclipse UI 编辑器的支持**</span>

从 CD 更新 *8.0.0.0-MFPF-IF201711230641-CDUpdate-01* 开始，现在在 MobileFirst Studio 的 Eclipse 中提供了 WYSIWYG 编辑器。开发人员可以使用此 UI 编辑器为其 Cordova 应用程序设计和实施 UI。[了解更多信息](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/application-development/cordova-apps/developing-ui/)。

##### <span style="color:NAVY">**用于构建认知应用程序的新适配器**</span>

从 CD 更新 *8.0.0.0-MFPF-IF201711230641-CDUpdate-01* 开始，Mobile Foundation 针对 [*Watson Tone Analyzer*](https://github.com/mfpdev/mfp-extension-adapters/tree/master/WatsonToneAnalyzer) 和 [*Language Translator*](https://github.com/mfpdev/mfp-extension-adapters/tree/master/WatsonLanguageTranslator) 服务引入了两个新的预构建认知服务适配器。可以从 Mobile Foundation 控制台中的*下载中心*下载和部署这些适配器。

##### <span style="color:NAVY">**动态应用程序真实性**</span>

从临时修订 *8.0.0.0-MFPF-IF20170220-1900* 开始，提供*应用程序真实性*的全新实施。该实施不需要脱机 *mfp-app-authenticity* 工具来生成 *.authenticity_data* 文件。而可以通过 MobileFirst 控制台来启用或禁用*应用程序真实性*。有关更多信息，请参阅[配置应用程序真实性](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/authentication-and-security/application-authenticity)。

##### <span style="color:NAVY">**针对 Windows 10 的 Appcenter（客户机和服务器）支持**</span>

从临时修订 *8.0.0.0-MFPF-IF20170327-1055* 开始，在 IBM Application Center 中支持 Windows 10 UWP 应用程序。用户现在可以上载 Windows 10 UWP 应用程序，并在其设备上安装相同的应用程序。现在，Application Center 随附用于安装 UWP 应用程序的 Windows 10 UWP 客户机项目。您可以在 Visual Studio 中打开项目，然后针对分发创建二进制（例如，*.appx*）。Application Center 未提供预定义方法来分发移动式客户机。有关更多信息，请参阅 [Microsoft Windows 10 Universal (Native) IBM AppCenter 客户机](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/appcenter/preparations/#microsoft-windows-10-universal-native-ibm-appcenter-client)。

##### <span style="color:NAVY">**针对 Eclipse Neon 的 MobileFirst Eclipse 插件支持**</span>

从临时修订 *8.0.0.0-MFPF-IF20170426-1210* 开始，更新 MobileFirst Eclipse 插件以支持 Eclipse Neon。

##### <span style="color:NAVY">**已修改 Android SDK 以使用更新版本的 OkHttp (V3.4.1)**</span>

从临时修订 *8.0.0.0-MFPF-IF20170605-2216* 开始，已修改 Android SDK 以使用更新版本的 *OkHttp (V3.4.1)*，代替先前与 MobileFirst SDK for Android 捆绑在一起的旧版本。OkHttp 作为依赖关系添加，而非与 SDK 捆绑在一起。这将允许开发人员自由选择使用 OkHttp 库，另外可防止多个版本的 OkHttp 产生冲突。

##### <span style="color:NAVY">**对 Cordova v7 的支持**</span>

从临时修订 *8.0.0.0-MFPF-IF20170608-0406* 开始，支持 Cordova v7。有关个别平台受支持版本的详细信息，请参阅[向 Cordova 应用程序添加 MobileFirst Foundation SDK](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/application-development/sdk/cordova/)。

##### <span style="color:NAVY">**多证书锁定支持**</span>

从临时修订 (*8.0.0.0-MFPF-IF20170624-0159*) 开始，Mobile Foundation 支持锁定多个证书。在此临时修订之前，Mobile Foundation 支持锁定单个证书。Mobile Foundation 引入了一个新 API，通过允许用户将多个 X509 证书的公用密钥锁定到客户机应用程序，来允许连接到多个主机。仅对本机 Android 和 iOS 应用程序支持此功能。在[新增功能](http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/product-overview/release-notes/whats-new/)的 *MobileFirst API 中的新增功能*部分中了解有关*多证书锁定支持*的更多信息。

##### <span style="color:NAVY">**用于构建认知应用程序的适配器**</span>

从临时修订 (*8.0.0.0-MFPF-IF20170710-1834*) 开始，Mobile Foundation 为 Watson 认知服务（如 [*WatsonConversation*](https://github.com/mfpdev/mfp-extension-adapters/tree/master/WatsonConversationAdapter)、[*WatsonDiscovery*](https://github.com/mfpdev/mfp-extension-adapters/tree/master/WatsonDiscoveryAdapter) 和 [*WatsonNLU（自然语言理解）*](https://github.com/mfpdev/mfp-extension-adapters/tree/master/WatsonNLUAdapter)引入了预构建的适配器。可以从 Mobile Foundation 控制台中的*下载中心*下载和部署这些适配器。

##### <span style="color:NAVY">**用于构建无服务器应用程序的 Cloud Functions 适配器**</span>

从临时修订 (*8.0.0.0-MFPF-IF20170710-1834*) 开始，Mobile Foundation 引入了一个针对 [Cloud Functions Platform](https://console.bluemix.net/openwhisk/) 的名为 [*Cloud Functions 适配器*](https://github.com/mfpdev/mfp-extension-adapters/tree/master/OpenWhiskAdapter)的预构建适配器。可以从 Mobile Foundation 控制台中的*下载中心*下载和部署该适配器。

##### <span style="color:NAVY">**在 Cordova SDK 中支持锁定多个证书**</span>

从此临时修订 (*8.0.0.0-MFPF-IF20170803-1112*) 开始，在 Cordova SDK 中支持锁定多个证书。在[新增功能 ](http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/product-overview/release-notes/whats-new/)的*MobileFirst API 中的新增功能*部分中阅读有关*多证书锁定支持*的更多信息。

##### <span style="color:NAVY">**支持 Cordova 浏览器平台**</span>

从临时修订 (*8.0.0.0-MFPF-IF20170823-1236*) 开始，{{ site.data.keys.product }} 支持 Cordova 浏览器平台以及 Cordova Windows、Cordova Android 和 Cordova iOS 的较早受支持平台。[了解更多信息](https://mobilefirstplatform.ibmcloud.com/blog/2017/08/29/cordova-browser-compatibility-with-MFP/)。

##### <span style="color:NAVY">**通过适配器的 OpenAPI 规范生成适配器**</span>

从临时修订 (*8.0.0.0-MFPF-IF20170901-1903*) 开始，{{ site.data.keys.product }} 引入了该功能，可通过适配器的 OpenAPI 规范自动生成适配器。{{ site.data.keys.product }} 用户现在可以关注应用程序逻辑，而无需创建用于将应用程序连接到所期望后端服务的 {{ site.data.keys.product }} 适配器。[了解更多信息]({{site.baseurl}}/tutorials/en/foundation/8.0/adapters/microservice-adapter/)。

##### <span style="color:NAVY">**对 iOS 11 和 iPhone X 的支持**</span>

从 CD 更新 *8.0.0.0-MFPF-IF201711230641-CDUpdate-01* 开始，Mobile Foundation 宣布了 Mobile Foundation v8.0 上对 iOS 11 和 iPhone X 的支持。有关进一步的详细信息，请阅读博客帖子[针对 iOS 11 和 iPhone X 的 IBM MobileFirst Platform Foundation 支持](https://mobilefirstplatform.ibmcloud.com/blog/2017/09/18/mfp-support-for-ios11/)。

##### **<span style="color:NAVY">支持 Android Oreo</span>**

从 CD 更新 *8.0.0.0-MFPF-IF201711230641-CDUpdate-01* 开始，Mobile Foundation 通过此[博客帖子](https://mobilefirstplatform.ibmcloud.com/blog/2017/08/22/mobilefirst-android-Oreo/)宣布支持 Android Oreo。当通过 OTA 升级设备后，在较早版本的 Android 上构建的本机 Android 应用程序和混合/Cordova 应用程序都会在 Android Oreo 上按预期运行。

##### <span style="color:NAVY">**现在可以在 Kubernetes 集群上部署 Mobile Foundation**</span>

从 CD 更新 *8.0.0.0-MFPF-IF201711230641-CDUpdate-01* 开始，Mobile Foundation 用户现在可以部署 Mobile Foundation，在 Kubernetes 集群上包含 Mobile Foundation Server、Mobile Analytics Server 和 Application Center。已更新部署软件包以支持 Kubernetes 部署。阅读[声明](https://mobilefirstplatform.ibmcloud.com/blog/2017/09/09/mobilefoundation-on-kube/)。

<!--
### Licensing
{: #licensing }
#### PVU licensing
{: #pvu-licensing }
A new offering, {{ site.data.keys.product }} Extension V8.0.0, is available through PVU (processor value unit) licensing. For more information on PVU licensing for {{ site.data.keys.product }} Extension, see [Licensing {{ site.data.keys.product_adj }}](../../licensing).


### Web applications
{: #web-applications }
#### Registering web applications from the {{ site.data.keys.mf_cli }} (APAR PI65327)
{: #registering-web-applications-from-the-mobilefirst-cli-apar-pi65327 }
You can now register client web applications to {{ site.data.keys.mf_server }} by using the {{ site.data.keys.mf_cli }} (mfpdev) as an alternative to registration from the {{ site.data.keys.mf_console }}. For more information, see Registering web applications from the {{ site.data.keys.mf_cli }}.

### Cordova applications
{: #cordova-applications }
#### Opening the native IDE for a Cordova project from Eclipse with the Studio plug-in
{: #opening-the-native-ide-for-a-cordova-project-from-eclipse-with-the-studio-plug-in }
With the Studio plug-in installed in your Eclipse IDE, you can open an existing Cordova project in Android Studio or Xcode from the Eclipse interface to build and run the project.

#### Added *projectName* directory as an option when you use the Migration Assistance tool
{: #added-projectname-directory-as-an-option-when-you-use-the-migration-assistance-tool }
You can specify a name for your Cordova project directory when you migrate projects with the migration assistance tool. If you do not provide a name, the default name is *app_name-app_id-version*.

#### Usability improvements to the Migration Assistance tool
{: #usability-improvements-to-the-migration-assistance-tool }
Made the following changes to improve the usability of the Migration Assistance tool:

* The Migration Assistance tool scans HTML files and JavaScript files.
* The scan report opens in your default browser automatically after the scan is finished.
* The *--out* flag is optional. The working directory is used if it is not specified.
* When the *--out* flag is specified and the directory does not exist, the directory is created.

### Adapters
{: #adapters }
#### Added `mfpdev push` and `pull` commands for Java and JavaScript adapter configurations
{: #added-mfpdev-push-and-pull-commands-for-java-and-javascript-adapter-configurations }
You can use {{ site.data.keys.mf_cli }} to push Java and JavaScript adapter configurations to the {{ site.data.keys.mf_server }} and pull adapter configurations from the {{ site.data.keys.mf_server }}.

### Application Center
{: #application-center}

Cordova based application center client is now available for iOS and Android.
-->
