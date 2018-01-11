---
layout: tutorial
title: 通过 IBM Application Center 分发移动应用程序
relevantTo: [ios,android,windows8,cordova]
show_in_nav: false
weight: 7
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
{{ site.data.keys.mf_app_center_full }} 是类似于通用应用商店的**移动应用程序存储库**，但其关注的是组织或团队的需求。 它是一个专用应用商店。

Application Center 有助于共享移动应用程序：

* 您可以**共享反馈和评级**信息。  
* 您可以使用访问控制表来限制可安装应用程序的人员。

Application Center 可处理 {{ site.data.keys.product_adj }} 应用程序和非 {{ site.data.keys.product_adj }} 应用程序，并且支持任何 **iOS、Android**、**BlackBerry 6/7** 和 **Windows/Phone 8.x** 应用程序。

> **注：**使用 Test Flight 或 iTunes Connect 生成且用于在商店提交/验证 iOS 应用程序的归档/IPA 文件可能导致运行时崩溃/失败，请阅读博客 [Preparing iOS apps for App Store submission in IBM MobileFirst Foundation 8.0](https://mobilefirstplatform.ibmcloud.com/blog/2016/10/17/prepare-ios-apps-for-app-store-submission/) 以了解更多信息。

您可以在不同的上下文中使用 Application Center。 例如：

* 作为整个组织的企业应用商店。
* 开发期间在团队内分发应用程序。

> **注：**要构建 iOS AppCenter Installer 应用程序，需要 MobileFirst 7.1。

#### 跳至：
{: #jump-to}
* [安装和配置](#installing-and-configuring)
* [基于 Cordova 的 IBM AppCenter 客户机](#cordova-based-ibm-appcenter-client)
* [准备移动式客户机](#preparing-mobile-clients)
* [在 Application Center 控制台中管理应用程序](#managing-applications-in-the-application-center-console)
* [Application Center 移动式客户机](#the-application-center-mobile-client)
* [Application Center 命令行工具](#application-center-command-line-tools)

## 安装和配置
{: #installing-and-configuring }
在使用 IBM Installation Manager 安装 {{ site.data.keys.mf_server }} 期间，安装 Application Center。

**先决条件：**在安装 Application Center 之前，必须已安装应用程序服务器和数据库：

* 应用程序服务器：Tomcat 或 WebSphere Application Server Full Profile/Liberty Profile
* 数据库：DB、Oracle 或 MySQL

如果未安装数据库，那么安装过程还可能安装 Apache Derby 数据库。 但是，建议不要将 Derby 数据库用于生产环境。

1. IBM Installation Manager 将引导您使用所选的数据库和应用程序服务器来安装 Application Center。

    > 有关更多信息，请参阅有关[安装 {{ site.data.keys.mf_server }}](../../installation-configuration) 的主题。

    因为 iOS 7.1 仅支持 https 协议，所以如果您打算针对运行 iOS 7.1 或更高版本的设备分发应用程序，那么必须使用 SSL（至少使用 TLS v.1）来保护 Application Center 服务器。 不推荐使用自签名证书，但这类证书可用于测试目的，前提是已将自签名 CA 证书分发到设备上。

2. 在使用 IBM Installation Manager 安装 Application Center 之后，打开控制台：`http://localhost:9080/appcenterconsole`

3. 使用以下用户/密码组合登录：demo/demo

4. 此时，您可以配置用户认证。 例如，可连接到 LDAP 存储库。

    > 有关更多信息，请参阅有关[在安装后配置 Application Center](../../installation-configuration/production/appcenter/#configuring-application-center-after-installation) 的主题。

5. 为 Android、iOS、BlackBerry 6/7 和 Windows Phone 8 准备移动式客户机

移动式客户机是用于浏览目录和安装应用程序的移动应用程序。

> **注：**对于生产安装，请考虑通过运行所提供的 Ant 任务来安装 Application Center：这可减少因更新 Application Center 而导致更新服务器的次数。

## 基于 Cordova 的 IBM AppCenter 客户机
{: #cordova-based-ibm-appcenter-client }
基于 Cordova 的 AppCenter 客户机项目位于`安装`目录中：**install_dir/ApplicationCenter/installer/CordovaAppCenterClient**。

此项目仅基于 Cordova 框架，因此不依赖于 {{ site.data.keys.product }} 客户机/服务器 API。  
由于这是标准 Cordova 应用程序，所以也不依赖于 {{ site.data.keys.mf_studio }}。 此应用程序针对 UI 使用 Dojo。

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

可能要花费一些时间。 一旦完成，即可开始定制。

> **注：**选择此项将会跳过弹出窗口上用于升级 gradle 版本的更新选项。 请参阅 `grade-wrapper.properties` 以了解版本。

#### iOS
{: #ios }
* 转至 **install_dir/ApplicationCenter/installer/CordovaAppCenterClient/platforms**。
* 单击以打开 **IBMAppCenterClient.xcodeproj** 文件，此时会在 Xcode 中打开项目并且您可以开始定制。

## 准备移动式客户机
{: #preparing-mobile-clients }
### 对于 Android 手机和平板电脑
{: #for-android-phones-and-tablets }
移动式客户机作为已编译的应用程序 (APK) 交付，并且位于 **install_dir/ApplicationCenter/installer/IBMApplicationCenter.apk**

> **注：**如果使用 Cordova 框架来构建 Android 和 iOS AppCenter 客户机，请参阅[基于 Cordova 的 IBM AppCenter 客户机](#cordova-based-ibm-appcenter-client)。

### 对于 iPad 和 iPhone
{: #for-ipad-and-iphone }
1. 编译并签署源代码中提供的客户机应用程序。 这是必需的操作。

2. 在 MobileFirst Studio 中，打开以下位置中的 IBMAppCenter 项目：**install\_dir/ApplicationCenter/installer**。

3. 使用**运行为 → 在 MobileFirst Development Server 上运行**以构建该项目。

4. 在 Xcode 中使用 Apple iOS Enterprise 概要信息构建和签署应用程序。  
您可以在 Xcode 中手动打开生成的本机项目（在 **iphone\native** 中），或者右键单击 iPhone 文件夹并选择**运行为 → Xcode 项目**。 此操作将生成项目并在 Xcode 中打开该项目。

> **注：**如果使用 Cordova 框架来构建 Android 和 iOS AppCenter 客户机，请参阅[基于 Cordova 的 IBM AppCenter 客户机](#cordova-based-ibm-appcenter-client)。

### 对于 Blackberry
{: #for-blackberry }
* 要构建 BlackBerry 版本，您必须具有带有 BlackBerry SDK 6.0 的 BlackBerry Eclipse IDE（或带有 BlackBerry Java 插件的 Eclipse）。 以 BlackBerry SDK 6.0 编译该应用程序时，该应用程序还会在 BlackBerry OS 7 上运行。

以下位置中提供了一个 BlackBerry 项目：**install\_dir/ApplicationCenter/installer/IBMAppCenterBlackBerry6**

### 对于 Windows Phone 8
{: #for-windows-phone-8}
1.  向 Microsoft 注册一个公司帐户。  
Application Center 仅管理那些使用公司帐户随附的公司证书签署的公司应用程序。

2. 以下位置中提供了 Windows Phone 版本的移动式客户机：**install\_dir/ApplicationCenter/installer/IBMApplicationCenterUnsigned.xap**

* 确保也使用此公司证书签署 Application Center 移动式客户机。

* 要在设备上安装公司应用程序，请先通过安装公司注册标记来向公司注册设备。

> 有关公司帐户和注册标记的更多信息，请参阅 [Microsoft 开发人员 Web 站点 → Windows Phone 的企业应用分发](http://msdn.microsoft.com/library/windows/apps/jj206943(v=vs.105).aspx) 页面。

> 有关如何签署 Windows Phone 移动式客户机应用程序的更多信息，请访问 [Microsoft 开发人员 Web 站点](http://dev.windows.com/en-us/develop)。

<br/>

> <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> **要点：****不能**直接使用未签名的 `.xap` 文件。 必须先使用从 Symantec 或 Microsoft 获取的公司证书来签署该文件，然后才能在设备上安装。

### 对于 Windows Store Apps for Windows 8.1 Pro
{: #for-windows-store-apps-for-windows-81-pro }
* **install\_dir/ApplicationCenter/installer/IBMApplicationCenterWindowsStore.zip** 文件包含 Application Center 客户机的可执行文件。 将此文件分发到客户端计算机上并进行解压缩。 其中包含可执行程序。

* 在不使用 Microsoft Windows Store 的情况下安装 Windows Store 应用程序（类型为 `appx` 的文件）称为<em>侧加载</em>应用程序。要侧加载应用程序，您必须遵循 [Prepare to sideload apps](https://technet.microsoft.com/fr-fr/library/dn613842.aspx. The Windows 8.1.1 update simplifies the prerequisites for sideloading. For more information, see [Sideloading Store Apps to Windows 8.1.1 Devices]( http://blogs.msdn.com/b/micham/archive/2014/05/30/sideloading-store-apps-to-windows-8-1-devices.aspx) 中的先决条件。

## 在 Application Center 控制台中管理应用程序
{: #managing-applications-in-the-application-center-console }
![App Center 中应用程序管理的图像]({{ site.baseurl }}/assets/backup/overview1.png)

可在 Application Center 控制台上使用以下方式管理目录中的应用程序：

* 添加和除去应用程序
* 管理应用程序的版本    
* 查看应用程序的详细信息
* 将应用程序访问限制为特定用户或用户组
* 读取每个应用程序的评论
* 评论已注册的用户和设备

### 向商店添加新应用程序
{: #adding-new-applications-to-the-store }
![将应用程序添加到 App Center 的图像]({{ site.baseurl }}/assets/backup/addAppFile_smaller.png)

要向商店添加新应用程序：

1. 打开 Application Center 控制台。
2. 单击**添加应用程序**。
3. 选择应用程序文件：
    * `.ipa`：iOS
    * `.apk`：Android
    * `.zip`：BlackBerry 6/7
    * `.xap`：Windows Phone 8.x
    * `.appx`：Windows Store 8.x

* 单击**下一步**。

    在“应用程序详细信息”视图中，您可以查看有关新应用程序的信息并输入更多信息（例如，描述）。 对于目录中的所有应用程序，您稍后都可以返回到此视图。

    ![“应用程序详细信息”屏幕的图像]({{ site.baseurl }}/assets/backup/appDetails1.png)

* 单击**完成**以完成该任务。

此时会将新应用程序添加到商店。

![App Center 中访问控制的图像]({{ site.baseurl }}/assets/backup/accessControlEnabled.png)

缺省情况下，商店的任何授权用户都可以安装应用程序。

### 将访问限制为一组用户
{: #restricting-access-to-a-group-of-users }
要将访问限制为一组用户：

1. 在目录视图中，单击应用程序名称旁边的**无限制链接**。 此时会打开“安装访问控制”页面。
2. 选择**启用访问控制**。 现在，您可以输入有权安装应用程序的用户或组的列表。
3. 如果已配置 LDAP，请添加在 LDAP 存储库中定义的用户和组。

您还可以在通用应用商店（例如，Google Play 或 Apple App Store）中通过输入 URL 来添加应用程序。

## Application Center 移动式客户机
{: #the-application-center-mobile-client }
App Center 移动式客户机是用于管理设备上的应用程序的移动应用程序。 通过移动式客户机，您可以：

* 列出目录中（您具有访问权）的所有应用程序。
* 列出收藏的应用程序。
* 安装应用程序或升级到新版本。
* 针对应用程序提供反馈和五星评级。

### 向目录中添加移动式客户机应用程序
{: #adding-mobile-client-applications-to-the-catalog }
您必须将 Application Center 移动式客户机应用程序添加到目录中。

1. 打开 Application Center 控制台。
2. 单击**添加应用程序**按钮以添加移动式客户机 `.apk`、`.ipa`、`.zip` 或 `.xap` 文件。
3. 单击**下一步**以打开“应用程序详细信息”页面。
4. 在“应用程序详细信息”页面中，选择**安装程序**以指示此应用程序是移动式客户机。
5. 单击**完成**以将 Application Center 应用程序添加到目录中。

不需要将针对 Windows 8.1 Pro 的 Application Center 客户机添加到目录中。 此客户机是 **install\_dir/ApplicationCenter/installer/IBMApplicationCenterWindowsStore.zip** 文件中的常规 Windows `.exe` 程序。 只需将其复制到客户端计算机上。

### Windows Phone 8
{: #windows-phone-8 }
在 Windows Phone 8 上，您还必须将随公司帐户一起收到的注册标记安装到 Application Center 控制台，以便用户可注册其设备。 使用可通过齿轮图标打开的“Application Center 设置”页面。

![Windows Phone 8 应用程序注册的图像]({{ site.baseurl }}/assets/backup/wp8Enrollment.png)

在安装移动式客户机之前，必须通过安装注册标记来向公司注册设备：

1. 打开设备上的 Web 浏览器。
2. 输入 URL：`http://hostname:9080/appcenterconsole/installers.html`
3. 输入用户名和密码。
4. 单击**标记**以打开注册标记列表。
5. 选择该列表中的公司。 此时会显示公司帐户的详细信息。
6. 单击**添加公司帐户**。 此时会注册该设备。

### 在移动设备上安装移动式客户机
{: #installing-the-mobile-client-on-the-mobile-device }
要在移动设备上安装移动式客户机：![应用程序安装程序的图像]({{ site.baseurl }}/assets/backup/installers_smaller.png)

1. 打开设备上的 Web 浏览器。
2. 输入 URL：`http://hostname:9080/appcenterconsole/installers.html`
3. 输入用户名和密码。
4. 选择 Application Center 应用程序以启动安装。

在 **Android** 设备上，必须打开“Android 下载”应用程序，然后选择 **IBM App Center** 进行安装。

### 登录到移动式客户机
{: #logging-in-to-the-mobile-client }
要登录到移动式客户机：

1. 输入您的凭证以访问服务器。
2. 输入服务器的主机名或 IP 地址。
3. 在**服务器端口**字段中，如果不是使用缺省端口号 (`9080`)，请输入端口号。
4. 在**应用程序上下文**字段中，输入上下文：`applicationcenter`。

![“登录”屏幕]({{ site.baseurl }}/assets/backup/login.png)

### Application Center 移动式客户机视图
{: #application-center-mobile-client-views }
* **目录**视图显示可用应用程序的列表。
* 如果选中一个应用程序，那么将打开此应用程序的**详细信息**视图。 您可以从“详细信息”视图中安装应用程序。 您还可以使用“详细信息”视图中的星形图标来将应用程序标记为收藏项。

    ![目录详细信息]({{ site.baseurl }}/assets/backup/catalog_details.001.jpg)

* **收藏夹**视图列出收藏的应用程序。 在特定用户的所有设备上都会提供此列表。
* **更新**视图列出所有可用更新。 在“更新”视图中，您可以浏览至“详细信息”视图。 您可以选择较新版本的应用程序或采用最新可用版本。 如果将 Application Center 配置为发送推送通知，那么推送通知消息可能通知您有更新。

通过移动式客户机，您可以对应用程序进行评级和发送评论。 可在控制台或移动设备上查看评论。

![评论]({{ site.baseurl }}/assets/backup/reviewss.png)

## Application Center 命令行工具
{: #application-center-command-line-tools }
**install_dir/ApplicationCenter/tools** 目录包含使用命令行工具或 Ant 任务来管理商店中的应用程序所需的所有文件：

* `applicationcenterdeploytool.jar`：上载命令行工具。
* `json4jar`：上载工具所需的 JSON 格式的库。
* `build.xml`：可用于将单个文件或一系列文件上载到 Application Center 的样本 Ant 脚本。
* `acdeploytool.sh` 和 `acdeploytool.bat`：用于通过 `applicationcenterdeploytool.jar` 文件调用 Java 的简单脚本。

例如，要使用用户标识 `demo` 和密码 `demo` 将应用程序 `app.apk` 文件部署到 `localhost:9080/applicationcenter` 中的商店，请编写：

```bash
Java com.ibm.appcenter.Upload -s http://localhost:9080 -c applicationcenter -u demo -p demo app.apk
```
