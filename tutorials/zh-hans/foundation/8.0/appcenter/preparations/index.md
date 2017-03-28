---
layout: tutorial
title: 准备使用移动式客户机
breadcrumb_title: 准备
relevantTo: [ios,android,windows,javascript]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
Appcenter Installer 应用程序用于在移动设备上安装应用程序。您可以使用提供的 Cordova 或 MobileFirst Studio 项目生成此应用程序，或者直接使用针对 Android、iOS 或 Windows 8 Universal 的预先构建的 MobileFirst Studio 项目版本。

#### 跳至：
{: #jump-to }
* [先决条件](#prerequisites)
* [基于 Cordova 的 IBM AppCenter 客户机](#cordova-based-ibm-appcenter-client)
* [基于 MobileFirst Studio 的 IBM AppCenter 客户机](#mobilefirst-studio-based-ibm-appcenter-client)
* [定制功能（针对专家）：Android、iOS 和 Windows Phone](#customizing-features-for-experts-android-ios-windows-phone)
* [在 Application Center 中部署移动式客户机](#deploying-the-mobile-client)

## 先决条件
{: #prerequisites }
### Android 操作系统特定的先决条件
{: #prerequisites-specific-to-the-android-operating-system }
移动式客户机的本机 Android 版本以 Android 应用程序包 (.apk) 文件的形式包含在软件交付中。**IBMApplicationCenter.apk** 文件位于 **ApplicationCenter/installer** 目录中。
禁用了推送通知。如果您要启用推送通知，必须重新构建 .apk 文件。请参阅[应用程序更新的推送通知](../push-notifications)，以获取有关 Application Center 中的推送通知的更多信息。

要构建 Android 版本，必须有最新版本的 Android 开发工具。

### iOS 操作系统特定的先决条件
{: #prerequisites-specific-to-apple-ios-operating-system }
iPad 和 iPhone 的本机 iOS 版本不采用已编译应用程序的形式交付。必须从名为 **IBMAppCenter** 的 {{ site.data.keys.product_full }} 项目创建该应用程序。此项目还作为 **ApplicationCenter/installer** 目录中的分发版的一部分进行交付。

要构建 iOS 版本，您必须具有相应的 {{ site.data.keys.product_full }} 和 Apple 软件。{{ site.data.keys.mf_studio }} 的版本必须与此文档基于的 {{ site.data.keys.mf_server }} 版本相同。Apple Xcode 版本为 V6.1。

### Microsoft Windows Phone 操作系统特定的先决条件
{: #prerequisites-specific-to-microsoft-windows-phone-operating-system }
Windows Phone 版本的移动式客户机在软件交付中为未签署的 Windows Phone 应用程序包 (.xap) 文件。**IBMApplicationCenterUnsigned.xap** 文件位于 **ApplicationCenter/installer** 目录中。

> **要点：**无法直接使用未签署的 .xap 文件。您必须使用从 Symantec/Microsoft 获取的公司证书对其进行签署，然后才能在设备上安装。可选：如果需要，您还可以从源构建 Windows Phone 版本。为此，您必须具有最新版本的 Microsoft Visual Studio。

### Microsoft Windows 8 操作系统特定的先决条件
{: #prerequisites-specific-to-microsoft-windows-8-operating-system }
Windows 8 版本的移动式客户机作为 .zip 归档文件包含在其中。**IBMApplicationCenterWindowsStore.zip** 文件包含可执行文件 (.exe) 及其从属的动态链接库 (.dll) 文件。要使用此归档的内容，请将归档下载到本地驱动器上的某个位置，然后运行可执行文件。

可选：如果需要，您还可以从源构建 Windows 8 版本。为此，您必须具有最新版本的 Microsoft Visual Studio。

## 基于 Cordova 的 IBM AppCenter 客户机
{: #cordova-based-ibm-appcenter-client }
基于 Cordova 的 AppCenter 客户机项目位于`安装`目录中：**install_dir/ApplicationCenter/installer/CordovaAppCenterClient**。

此项目仅基于 Cordova 框架，因此不依赖于 {{ site.data.keys.product }} 客户机/服务器 API。  
由于这是标准 Cordova 应用程序，所以也不依赖于 {{ site.data.keys.mf_studio }}。此应用程序针对 UI 使用 Dojo。

请执行以下步骤以开始操作：

1. 安装 Cordova。

```bash
npm install -g cordova@latest
```

2. 安装 Android SDK 并设置 `ANDROID_HOME`。  
3. 构建并运行此项目。

构建所有平台：

```bash
cordova build
```

仅构建 Android：

```bash
cordova build android
```

仅构建 iOS：

```bash
cordova build ios
```

### 定制 AppCenter Installer 应用程序
{: #customizing-appcenter-installer-application }
您可以进一步定制应用程序，例如，针对特定公司或需求来更新其用户界面。

> **注：**虽然您可以自由地定制应用程序 UI 和行为，但此类更改不在 IBM 支持协议的服务范围内。
#### Android
{: #android }
* 打开 Android Studio。
* 选择**导入项目（Eclipse ADT、Gradle 等）**
* 从 **install_dir/ApplicationCenter/installer/CordovaAppCenterClient/platforms/android** 中选择 android 文件夹。

可能要花费一些时间。一旦完成，即可开始定制。

> **注：**选择此项将会跳过弹出窗口上用于升级 gradle 版本的更新选项。请参阅 `grade-wrapper.properties` 以了解版本。
#### iOS
{: #ios }
* 转至 **install_dir/ApplicationCenter/installer/CordovaAppCenterClient/platforms**。
* 单击以打开 **IBMAppCenterClient.xcodeproj** 文件，此时会在 Xcode 中打开项目并且您可以开始定制。

## 基于 MobileFirst Studio 的 IBM AppCenter 客户机
{: #mobilefirst-studio-based-ibm-appcenter-client }
您还可以选择使用先前发行版的 App Center 客户机应用程序（其基于 MobileFirst Studio 7.1 且支持 iOS、Android 和 Windows Phone），而不是将 Cordova 项目用于 iOS 和 Android。

### 导入并构建项目（Android、iOS 和 Windows Phone）
{: #importing-and-building-the-project-android-ios-windows-phone }
您必须将 **IBMAppCenter** 项目导入到 {{ site.data.keys.mf_studio }} ，然后构建项目。

> **注：**对于 V8.0.0，请使用 MobileFirst Studio 7.1。您可以从[下载页面]({{site.baseurl}}/downloads)下载 MobileFirst Studio。有关安装指示信息，请参阅 7.1 的 IBM Knowledge Center 中的[安装 MobileFirst Studio](https://www.ibm.com/support/knowledgecenter/SSHS8R_7.1.0/com.ibm.worklight.installconfig.doc/devenv/t_installing_ibm_worklight_studi.html)。
1. 选择**文件 → 导入**。
2. 选择**常规 → 将现有项目导入到工作空间中**。
3. 在下一个页面上，选择**选择根目录**，然后找到 **IBMAppCenter** 项目的根目录。
4. 选择 **IBMAppCenter** 项目。
5. 选择**将项目复制到工作空间中**。此选项会在您的工作空间中创建项目副本。在 UNIX 系统上，IBMAppCenter 项目在原始位置中为只读。因此将项目复制到工作空间中可避免文件许可权问题。
6. 单击**完成**以将 **IBMAppCenter** 项目导入到 MobileFirst Studio。

构建 **IBMAppCenter** 项目。MobileFirst 项目包含一个名为 **AppCenter** 的应用程序。右键单击该应用程序，然后选择**运行为 → 构建所有环境**。

#### Android
{: #android }
MobileFirst Studio 在 **IBMAppCenter/apps/AppCenter/android/native** 中生成本机 Android 项目。本机 Android 开发工具 (ADT) 项目位于 android/native 文件夹中。
您可以使用 ADT 工具来编译和签署此项目。该项目需要安装 Android SDK 级别 16，以便生成的 APK 与所有 Android V2.3 及更高版本兼容。
如果在构建项目时选择更高级别的 Android SDK，那么生成的 APK 将与 Android V2.3 不兼容。

请参阅[面向开发人员的 Android 站点](https://developer.android.com/index.html)，以获取影响移动式客户机应用程序的更具体的 Android 信息。

如果您要启用应用程序更新的推送通知，必须首先配置 Application Center 客户机属性。请参阅[为应用程序更新配置推送通知](../push-notifications)以获取更多信息。

#### iOS
{: #ios }
MobileFirst Studio 在 **IBMAppCenter/apps/AppCenter/iphone/native** 中生成本机 iOS 项目。**IBMAppCenterAppCenterIphone.xcodeproj** 文件位于 iphone/native 文件夹中。该文件是必须使用 Xcode 进行编译和签署的 Xcode 项目。

请参阅 [Apple 开发人员站点](https://developer.apple.com/)，以了解有关如何签署 iOS 移动式客户机应用程序的更多信息。要签署 iOS 应用程序，必须将应用程序的捆绑标识更改为可与所使用的供应概要文件共同使用的捆绑标识。在 Xcode 项目设置中将该值定义为 **com.your\_internet\_domain\_name.appcenter**，其中 **your\_internet\_domain\_name** 是因特网域的名称。

如果您要启用应用程序更新的推送通知，必须首先配置 Application Center 客户机属性。请参阅[为应用程序更新配置推送通知](../push-notifications)以获取更多信息。

#### Windows Phone 8
{: #windows-phone-8 }
MobileFirst Studio 在 **IBMAppCenter/apps/AppCenter/windowsphone8/native** 中生成本机 Windows Phone 8 项目。**AppCenter.csproj** 文件位于 windowsphone8/native 文件夹中。该文件是必须使用 Visual Studio 和 Windows Phone 8.0 SDK 进行编译的 Visual Studio 项目。


该应用程序是使用 [Windows Phone 8.0 SDK](https://www.microsoft.com/en-in/download/details.aspx?id=35471) 构建的，因此它可以在 Windows Phone 8.0 和 8.1 设备上运行。该应用程序不是使用 Windows Phone 8.1 SDK 构建的，因为使用它构建会导致无法在早期的 Windows Phone 8.0 设备上运行。

通过安装 Visual Studio 2013，您可以选择在安装 8.1 SDK 外还安装 Windows Phone 8.0 SDK。Windows Phone
8.0 SDK 也可以从 [Windows Phone SDK Archives](https://developer.microsoft.com/en-us/windows/downloads/sdk-archive) 中获取。

请参阅 [Windows Phone 开发中心](https://developer.microsoft.com/en-us)，以了解有关如何构建和签署 Windows Phone 移动式客户机应用程序的更多信息。

#### Microsoft Windows 8：构建项目
{: #microsoft-windows-8-building-the-project }
Windows 8 Universal 项目在 **IBMApplicationCenterWindowsStore\AppCenterClientWindowsStore.csproj** 中作为 Visual Studio 项目提供。  
您必须先在 Microsoft Visual Studio 2013 中构建客户机项目，然后才能进行分发。

构建项目是将项目分发给用户的先决条件，但 Windows 8 应用程序不能部署到 Application Center 中以供稍后分发。

要构建 Windows 8 项目：

1. 在 Microsoft Visual Studio 2013 中打开名为 **IBMApplicationCenterWindowsStore\AppCenterClientWindowsStore.csproj** 的 Visual Studio 项目文件。
2. 对应用程序执行完全构建。

要将移动式客户机分发给 Application Center 用户，您可以稍后生成一个安装程序，该安装程序将安装所生成的可执行 (.exe) 文件及其从属的动态链接库 (.dll) 文件。或者，可以提供这些文件，而不将它们包含在安装程序中。

## 定制功能（针对专家）：Android、iOS 和 Windows Phone
{: #customizing-features-for-experts-android-ios-windows-phone }
您可以通过编辑集中属性文件并处理其他某些资源来定制功能。

要定制功能：**IBMAppCenter/apps/AppCenter/common/js/appcenter/** 或 **ApplicationCenter/installer/CordovaAppCenterClient/www/js/appcenter** 目录中称为 **config.json** 的中央属性文件控制了多项功能。
如果您要更改缺省应用程序行为，可以在构建项目之前调整该属性文件。

此文件包含下表中显示的属性。

| 属性 | 描述 |
|----------|-------------|
| url | Application Center 服务器的硬编码地址。如果设置了该属性，那么不会显示“登录”视图的地址字段。 |
| defaultPort | 如果 url 属性为空，那么该属性会预填充手机上“登录”视图的 port 字段。这是缺省值；用户可编辑该字段。 |
| defaultContext | 如果 url 属性为空，那么该属性会预填充手机上“登录”视图的 context 字段。这是缺省值；用户可编辑该字段。 |
| ssl | “登录”视图的 SSL 开关的缺省值。 |
| allowDowngrade | 该属性指示是否授权安装较旧版本；仅当操作系统和版本允许降级时，才可安装较旧版本。 |
| showPreviousVersions | 此属性指示设备用户可显示应用程序的所有版本的详细信息还是只能显示最新版本的详细信息。 |
| showInternalVersion | 此属性指示是否显示内部版本。如果值为 false，那么仅当未设置商业版本时才会显示内部版本。 |
| listItemRenderer | 此属性可具有以下某个值：<br/>- **full**：缺省值；应用程序列表显示应用程序名称、评级和最新版本。<br/>- **simple**：应用程序列表仅显示应用程序名称。 |
| listAverageRating | 此属性可具有以下某个值：<br/>- **latestVersion**：应用程序列表显示应用程序的最新版本的平均评级。<br/>- **allVersions**：应用程序列表显示应用程序的所有版本的平均评级。 |
| requestTimeout | 该属性指示请求 Application Center 服务器的超时（单位为毫秒）。 |
| gcmProjectId | Google API 项目标识（项目名称 = com.ibm.appcenter），这是 Android 推送通知所必需的；例如，123456789012。 |
| allowAppLinkReview | 该属性指示能否在 Application Center 中注册和浏览来自外部应用商店的本地应用程序评论。在外部应用商店中看不到这些本地评论。这些评论存储在 Application Center 服务器中。 |

### 其他资源
{: #other-resources }
其他可用资源包括应用程序图标、应用程序名称、启动屏幕图像、图标和可转换的应用程序资源。

#### 应用程序图标
{: #application-icons }
* **Android：**Android Studio 项目的 **/res/drawabledensity** 目录中名为 **icon.png** 的文件；针对每种密度都存在一个目录。
* **iOS：**Xcode 项目的 **Resources** 目录中名为 **iconsize.png** 的文件。
* **Windows Phone：**针对 Windows Phone 的 MobileFirst Studio 环境文件夹内的 **native** 目录中名为 **ApplicationIcon.png**、**IconicTileSmallIcon.png** 和 **IconicTileMediumIcon.png** 的文件。

#### 应用程序名称
{: #application-name }
* **Android：**编辑 Android Studio 项目的 **res/values/strings.xml** 文件中的 **app_name** 属性。
* **iOS：**编辑 Xcode 项目的 **IBMAppCenterAppCenterIphone-Info.plist** 文件中的 **CFBundleDisplayName** 键。
* **Windows Phone：**编辑 Visual Studio 的 **Properties/WMAppManifest.xml** 文件中 App 条目的 **Title** 属性。

#### 启动屏幕图像
{: #splash-screen-images }
* **Android：**编辑 Android Studio 项目的 **res/drawable/density** 目录中名为 **splashimage.9.png** 的文件；对于每种密度都存在一个目录。此文件为补丁 9 映像。
* **iOS：**Xcode 项目的 **Resources** 目录中名为 **Default-size.png** 的文件。
* 自动登录期间基于 Cordova/MobileFirst Studio 的项目的启动屏幕：**js/idx/mobile/themes/common/idx/Launch.css**
* **Windows Phone：**编辑针对 Windows Phone 的 MobileFirst Studio 环境文件夹内的 **native** 目录中名为 **SplashScreenImage.png** 的文件。

#### 应用程序图标（按钮、星型和类似的对象）
{: #icons }
**IBMAppCenter/apps/AppCenter/common/css/images**。

#### 可转换的应用程序资源
{: #translatable-resources }
**IBMAppCenter/apps/AppCenter/common/js/appcenter/nls/common.js**。

## 在 Application Center 中部署移动式客户机
{: #deploying-the-mobile-client }
将不同版本的客户机应用程序部署到 Application Center。

Windows 8 移动式客户机不能部署到 Application Center 中以供稍后分发。您可以选择通过以下方式分发 Windows 8 移动式客户机：通过向用户提供直接打包归档的客户机 .exe 可执行文件和动态链接库 .dll 文件，或通过为 Windows 8 移动式客户机创建可执行安装程序。

必须将移动式客户机的 Android、iOS 和 Windows Phone 版本部署到 Application Center 中。
为此，必须将 Android 应用程序包 (.apk) 文件、iOS 应用程序 (.ipa) 文件、Windows Phone 应用程序 (.xap) 文件和 Web 目录归档 (.zip) 文件上载到 Application Center。

按照[添加移动应用程序](../appcenter-console/#adding-a-mobile-application)中描述的步骤，为 Android、iOS 和 Windows Phone 添加移动式客户机应用程序。请确保选中 Installer 应用程序属性以指示该应用程序是一个安装程序。选择该属性使移动设备用户可以轻松通过无线方式安装移动式客户机应用程序。要安装移动式客户机，请参阅与操作系统确定的移动式客户机应用程序版本对应的相关任务。
