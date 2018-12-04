---
layout: tutorial
title: 迁移现有的 iOS 应用程序
breadcrumb_title: iOS
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
要迁移使用 IBM MobileFirst™ Platform Foundation V6.2.0 或更高版本创建的现有本机 Android 项目，必须修改此项目以使用当前版本中的 SDK。 然后，替换 V8.0 中停用或不包含的客户端 API。 迁移辅助工具可扫描您的代码并生成要替换的 API 的报告。

#### 跳至：
{: #jump-to }
* [扫描现有 {{ site.data.keys.product_adj }} 本机 iOS 应用程序以准备版本升级](#scanning-existing-mobilefirst-native-ios-apps-to-prepare-for-a-version-upgrade)
* [手动迁移现有 iOS 项目](#migrating-an-existing-ios-project-manually)
* [使用 CocoaPods 迁移现有本机 iOS 项目](#migrating-an-existing-native-ios-project-with-cocoapods)
* [在 iOS 中迁移加密](#migrating-encryption-in-ios)
* [更新 iOS 代码](#updating-the-ios-code)

## 扫描现有 {{ site.data.keys.product_adj }} 本机 iOS 应用程序以准备版本升级
{: #scanning-existing-mobilefirst-native-ios-apps-to-prepare-for-a-version-upgrade }
迁移辅助工具可帮助您准备通过 IBM MobileFirst™ Platform Foundation 先前版本创建的应用程序以执行迁移，方法是扫描本机 iOS 应用程序（使用 Swift 或 Objective-C 开发）的源文件并生成 V8.0 中不推荐使用或停用的 API 的报告。

使用迁移辅助工具之前，务必了解以下信息：

* 您必须具有现有 IBM MobileFirst Platform Foundation 本机 iOS 应用程序。
* 您必须具有因特网访问权。
* 您必须已安装 node.js V4.0.0 或更高版本。
* 查看并了解迁移过程的限制。 有关更多信息，请参阅[从先前发行版迁移应用程序](../)。

对于使用 IBM MobileFirst Platform Foundation 的先前版本创建的应用程序，在未进行一些更改的情况下在 {{ site.data.keys.product }} 8.0 中不受支持。 迁移辅助工具通过扫描现有版本应用程序中的源文件，识别 V8.0 中不推荐使用、不再支持或修改的 API，从而简化此过程。

迁移辅助工具不会修改或移动应用程序的任何开发人员代码或注释。

1. 通过使用以下其中一种方法下载迁移辅助工具：
    * 从 [Git 存储库](https://git.ng.bluemix.net/ibmmfpf/mfpmigrate-cli)下载 .tgz 文件。
    * 从 {{ site.data.keys.mf_console }} 下载{{ site.data.keys.mf_dev_kit }}，其中包含名为 **mfpmigrate-cli.tgz** 的迁移辅助工具文件。
2. 安装迁移辅助工具。
    * 切换到下载工具的目录。
    * 通过输入以下命令，使用 NPM 安装该工具：

   ```bash
   npm install -g
   ```

3. 通过输入以下命令来扫描 IBM MobileFirst Platform Foundation 应用程序：

   ```bash
   mfpmigrate scan --in source_directory --out destination_directory --type ios
   ```

    **source_directory**  
    版本项目的当前位置。

    **destination_directory**  
    创建报告的目录。  
    <br/>
    与 scan 命令一起使用时，迁移辅助工具会识别现有 IBM MobileFirst Platform Foundation 应用程序中在 V8.0 中已除去、不推荐使用或更改的 API，并将它们保存在确定的目标目录中。

## 手动迁移现有 iOS 项目
{: #migrating-an-existing-ios-project-manually }
在 Xcode 项目中手动迁移现有本机 iOS 项目，并继续使用 {{ site.data.keys.product }} V8.0 进行开发。

在开始之前，您必须：

* 在 Xcode 7.0 (iOS 9) 或更高版本中工作。
* 具有使用 IBM MobileFirst Platform Foundation 6.2.0 或更高版本创建的现有本机 iOS 项目。
* 对 V8.0.0 {{ site.data.keys.product_adj }} iOS SDK 文件副本具有访问权。

1. 在**构建阶段**部分的**将二进制与库进行链接**选项卡中删除对静态库 **libWorklightStaticLibProjectNative.a** 的所有现有引用。
2. 从 **WorklightAPI** 文件夹中删除 Headers 文件夹。
3. 在**构建阶段**部分中，链接**将二进制与库进行链接**选项卡中的主要必需框架 **IBMMobileFirstPlatformFoundation.framework** 文件。

    此框架提供核心 {{ site.data.keys.product_adj }} 功能。 同样，您可以添加[针对可选功能的其他框架](../../../application-development/sdk/ios/#manually-adding-the-mobilefirst-native-sdk)。

4. 与前面的步骤类似，在**构建阶段**选项卡的**将二进制与库进行链接**部分中将以下资源链接到您的项目。
    * SystemConfiguration.framework
    * MobileCoreServices.framework
    * Security.framework
    * 注：可能已链接部分框架。
        * libstdc++.6.tbd
        * libz.tbd
        * libc++.tbd
5. 将 **$(SRCROOT)/WorklightAPI/include** 从头文件搜索路径中除去。
6. 使用以下新保护伞头文件这一单个条目替换头文件的所有现有 {{ site.data.keys.product_adj }} 导入：
    * Objective-C：

      ```objc
      #import <IBMMobileFirstPlatformFoundation/IBMMobileFirstPlatformFoundation.h>
      ```
    * Swift：

      ```swift
      import IBMMobileFirstPlatformFoundation
      ```

现已升级您的应用程序，它可与 {{ site.data.keys.product }} V8.0 iOS SDK 配合使用。

#### 后续步骤
{: #what-to-do-next }
替换 V8.0 中停用或不包含的客户端 API。

## 使用 CocoaPods 迁移现有本机 iOS 项目
{: #migrating-an-existing-native-ios-project-with-cocoapods }
您可以通过使用 CocoaPods 获取 {{ site.data.keys.product }} iOS SDK 并在项目配置中进行更改，从而迁移现有的本机 iOS 项目以与 V8.0 配合工作。

> **注：**从 V7.1 起，在 Xcode 中支持使用 iOS 8.0 和更高版本进行 {{ site.data.keys.product_adj }} 开发。

您必须具有：

* 安装在开发环境中的 CocoaPods。
* 采用 iOS 8.0 或更高版本的 Xcode 7.1，用于开发环境。
* 与 MobileFirst 6.2 或更高版本集成的应用程序。

SDK 包含必需和可选 SDK。 每个必需或可选 SDK 具有其自己的 pod。  
必需的 IBMMobileFirstPlatformFoundation pod 是系统的核心。 它实施客户机/服务器连接，处理安全、分析和应用程序管理。

以下可选 pod 提供其他功能。

| pod | 功能 |
|-----|---------|
| IBMMobileFirstPlatformFoundationPush | 添加用于启用推送的 IBMMobileFirstPlatformFoundationPush 框架。 |
| IBMMobileFirstPlatformFoundationJSONStore | 实施 JSONStore 功能部件。 如果计划在应用程序中使用 JSONStore 功能，请在 Podfile 中包含此 pod。 |
| IBMMobileFirstPlatformFoundationOpenSSLUtils | 包含 {{ site.data.keys.product_adj }} 嵌入式 OpenSSL 功能并自动装入 openssl 框架。 如果计划使用由 {{ site.data.keys.product_adj }} 提供的 OpenSSL，请在 Podfile 中包含此 pod。 |

1. 在 Xcode 中打开您的项目。
2. 从 Xcode 项目中删除 **WorklightAPI** 文件夹（将其移至废纸篓）。
3. 以下列方式修改现有代码：
    * 将 **$(SRCROOT)/WorklightAPI/include** 从头文件搜索路径中除去。
    * 将 **$(PROJECTDIR)/WorklightAPI/frameworks** 从框架搜索路径中除去。
    * 除去对静态 **librarylibWorklightStaticLibProjectNative.a** 的所有引用。
4. 在**构建阶段**选项卡中，除去至下列框架和库的链接（它们是由 CocoaPods 自动重新添加的）：
    * libWorklightStaticLibProjectNative.a
    * SystemConfiguration.framework
    * MobileCoreServices.framework
    * CoreData.framework
    * CoreLocation.framework
    * Security.framework
    * sqlcipher.framework
    * libstdc++.6.dylib
    * libz.dylib
5. 关闭 Xcode。
6. 从 CocoaPods 获取 {{ site.data.keys.product_adj }} iOS SDK。 要获取此 SDK，请完成以下步骤：
    * 在新 Xcode 项目所在位置打开**终端**。
    * 运行 `pod init ` 命令以创建 **Podfile** 文件。
    * 使用文本编辑器打开项目根目录中的 Podfile 文件。
    * 注释掉或除去现有内容。
    * 添加以下行并保存更改，包括 iOS 版本：

      ```xml
      use_frameworks!
      platform :ios, 9.0
      pod 'IBMMobileFirstPlatformFoundation'
      ```

    * 在文件中指定以上列表中的附加 pod（如果应用程序需要使用这些 pod 提供的其他功能）。 例如，如果应用程序使用 OpenSSL，那么 **Podfile** 可能如下所示：

      ```xml
      use_frameworks!
      platform :ios, 9.0
      pod 'IBMMobileFirstPlatformFoundation'
      pod 'IBMMobileFirstPlatformFoundationOpenSSLUtils'
      ```

      > **注：**先前的语法将导入最新版本的 **IBMMobileFirstPlatformFoundation** pod。 如果使用的不是最新版本的 {{ site.data.keys.product_adj }}，那么需要添加完整版本号，包括主版本号、次版本号和补丁号。 补丁号的格式为 YYYYMMDDHH。 例如，为导入 **IBMMobileFirstPlatformFoundation** pod 的特定补丁版本 8.0.2016021411，该行将如下所示：

      ```xml
      pod 'IBMMobileFirstPlatformFoundation', '8.0.2016021411'
      ```

      或者，要获取次要版本号的最新补丁，语法如下：

      ```xml
      pod 'IBMMobileFirstPlatformFoundation', '~>8.0.0'
      ```

    * 验证 Xcode 项目是否已关闭。
    * 运行 ` pod install` 命令。

    该命令会安装 {{ site.data.keys.product_adj }} SDK **IBMMobileFirstPlatformFoundation.framework** ，以及安装 Podfile 和其依赖关系中指定的任何其他框架。 然后该命令将生成 pods 项目，并且将客户机项目与  {{ site.data.keys.product_adj }} SDK 集成。
7. 通过从命令行输入 open **ProjectName.xcworkspace**，在 Xcode 中打开 **ProjectName.xcworkspace** 文件。 该文件与 **ProjectName.xcodeproj** 文件位于同一目录中。
8. 使用以下新保护伞头文件这一单个条目替换头文件的所有现有 {{ site.data.keys.product_adj }} 导入：

   **Objective-C**

   ```objc
   #import <IBMMobileFirstPlatformFoundation/IBMMobileFirstPlatformFoundation.h>
   ```

   **Swift**

   ```swift
   import IBMMobileFirstPlatformFoundation
   ```

   如果使用的是推送或 JSONStore，那么需要包含独立导入。

   #### 推送
   {: #push }

   **Objective-C**

   ```objc
   #import <IBMMobileFirstPlatformFoundationPush/IBMMobileFirstPlatformFoundationPush.h>
   ```

   **Swift**

   ```swift
   import IBMMobileFirstPlatformFoundationPush
   ```

   ##### JSONStore
   {: #jsonstore }

   **Objective-C**

   ```objc
   #import <IBMMobileFirstPlatformFoundationJSONStore/IBMMobileFirstPlatformFoundationJSONStore.h>
   ```

   **Swift**

   ```swift
   import IBMMobileFirstPlatformFoundationJSONStore
   ```

9. 在**构建设置**选项卡中的**其他链接程序标记**下，在 `-ObjC` 标记的开头添加 `$(inherited)`。 例如：

    ![在 Xcode 构建设置中将 $(inherited) 添加到 ObjC 标记](add_inherited_to_ObjC.jpg)

10. 从 Xcode 7 开始，必须强制使用 TLS，请参阅“在 iOS 应用程序中强制使用 TLS 安全连接”。  

<br/>
现已升级您的应用程序，它可与 {{ site.data.keys.product }} V8.0 iOS SDK 配合使用。

#### 下一步是什么
{: #what-next }
替换 V8.0 中停用或不包含的客户端 API。

## 在 iOS 中迁移加密
{: #migrating-encryption-in-ios }
如果您的 iOS 应用程序已使用 OpenSSL 加密，那么可能需要将您的应用程序迁移到新的 V8.0 本机加密。 另外，如果要继续使用 OpenSSL，那么必须安装一些额外框架。

有关用于迁移的 iOS 加密选项的更多信息，请参阅[为 iOS 启用 OpenSSL](../../../application-development/sdk/ios/additional-information/#enabling-openssl-for-ios)。

## 更新 iOS 代码
{: #updating-the-ios-code }
在更新 iOS 框架并进行必需的配置更改之后，许多问题可能与特定应用程序代码有关。  
下表中列出了 iOS API 更改。

| API 元素 | 迁移路径 |
|-------------|----------------|
| {::nomarkdown}<ul><li><code>[WLClient getWLDevice][WLClient transmitEvent:]</code></li><li><code>[WLClient setEventTransmissionPolicy]</code></li><li><code>[WLClient
purgeEventTransmissionBuffer]</code></li></ul>{:/} | 已除去地理定位。 使用本机 iOS 或第三方软件包进行地理定位。 |
| {::nomarkdown}<ul><li><code>WL.Client.getUserInfo(realm, key)</code></li><li><code>WL.Client.updateUserInfo(options)</code></li></ul>{:/} | 无替换。 |
| `WL.Client.deleteUserPref(key, options)` | 无替换。 您可以使用适配器和 [`MFP.Server.getAuthenticatedUser`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-server/html/MFP.Server.html?view=kc#MFP.Server.getAuthenticatedUser:) API 来管理用户首选项。 |
| `[WLClient getRequiredAccessTokenScopeFromStatus]` | 使用 [`WLAuthorizationManager obtainAccessTokenForScope`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refobjc-worklight-ios/html/Classes/WLAuthorizationManager.html?view=kc#//api/name/obtainAccessTokenForScope:withCompletionHandler:)。 |
| `[WLClient login:withDelegate:]` | 使用 [`WLAuthorizationManager login`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refobjc-worklight-ios/html/Classes/WLAuthorizationManager.html?view=kc#//api/name/login:withCredentials:withCompletionHandler:)。 |
| `[WLClient logout:withDelegate:]` | 使用 [`WLAuthorizationManager logout`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refobjc-worklight-ios/html/Classes/WLAuthorizationManager.html?view=kc#//api/name/logout:withCompletionHandler:)。 |
| {::nomarkdown}<ul><li><code>[WLClient lastAccessToken]</code></li><li><code>[WLClient
lastAccessTokenForScope:]</code></li></ul>{:/} | 使用 [`WLAuthorizationManager obtainAccessTokenForScope`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refobjc-worklight-ios/html/Classes/WLAuthorizationManager.html?view=kc#//api/name/obtainAccessTokenForScope:withCompletionHandler:)。 |
| {::nomarkdown}<ul><li><code>[WLClient obtainAccessTokenForScope:withDelegate:]</code></li><li><code>[WLClient getRequiredAccessTokenScopeFromStatus:authenticationHeader:]</code></li></ul>{:/} | 使用 [`WLAuthorizationManager obtainAccessTokenForScope`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refobjc-worklight-ios/html/Classes/WLAuthorizationManager.html?view=kc#//api/name/obtainAccessTokenForScope:withCompletionHandler:)。 |
| `[WLClient isSubscribedToAdapter:(NSString *) adaptereventSource:(NSString *) eventSource` | 使用来自 IBMMobileFirstPlatformFoundationPush 框架的 [iOS 应用程序的 Objective-C 客户端推送 API](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/c_objc_push_api_native_ios_apps.html?view=kc#nativeobjective-capiforandroidapps)。 |
| `[WLClient - (int) getEventSourceIDFromUserInfo: (NSDictionary *) userInfo]` | 使用来自 IBMMobileFirstPlatformFoundationPush 框架的 [iOS 应用程序的 Objective-C 客户端推送 API](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/c_objc_push_api_native_ios_apps.html?view=kc#nativeobjective-capiforandroidapps)。 |
| `[WLClient invokeProcedure: (WLProcedureInvocationData *) ]` | 不推荐使用。 改用 [`WLResourceRequest`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refobjc-worklight-ios/html/Classes/WLResourceRequest.html?view=kc#/api/name/sendWithDelegate:)。 |
| `[WLClient sendUrlRequest:delegate:]` | 改用 [`[WLResourceRequest sendWithDelegate:delegate]`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refobjc-worklight-ios/html/Classes/WLResourceRequest.html?view=kc#/api/name/sendWithDelegate:)。 |
| `[WLClient (void) logActivity:(NSString *) activityType]`	| 已除去。 使用 Objective C 记录器。 |
| {::nomarkdown}<ul><li><code>[WLSimpleDataSharing setSharedToken: myName value:
myValue]</code></li><li><code>[WLSimpleDataSharing getSharedToken:
myName]]</code></li><li><code>[WLSimpleDataSharing clearSharedToken:
myName]</code></li></ul>{:/} | 使用 OS API 在应用程序之间共享令牌。 |
| `BaseChallengeHandler.submitFailure(WLResponse *)challenge` | 使用 [`BaseChallengeHandler.cancel()`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refobjc-worklight-ios/html/Classes/BaseChallengeHandler.html?view=kc)。 |
| `BaseProvisioningChallengeHandler` | 无替换。 设备供应现在由安全框架自动处理。 |
| `ChallengeHandler` | 对于定制网关验证问题，请使用 [`GatewayChallengeHandler`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refobjc-worklight-ios/html/Classes/SecurityCheckChallengeHandler.html?view=kc)。 对于 {{ site.data.keys.product_adj }} 安全性检查验证问题，请使用 [`SecurityCheckChallengeHandler`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refobjc-worklight-ios/html/Classes/SecurityCheckChallengeHandler.html?view=kc)。 |
| `WLChallengeHandler` | 使用 [`SecurityCheckChallengeHandler`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refobjc-worklight-ios/html/Classes/SecurityCheckChallengeHandler.html?view=kc)。 |
| `ChallengeHandler.isCustomResponse()` | 使用 [`GatewayChallengeHandler.canHandleResponse()`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refobjc-worklight-ios/html/Classes/GatewayChallengeHandler.html?view=kc)。 |
| `ChallengeHandler.submitAdapterAuthentication` | 在验证问题处理程序中实施类似逻辑。 对于定制网关验证问题处理程序，请使用 [`GatewayChallengeHandler`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refobjc-worklight-ios/html/Classes/GatewayChallengeHandler.html?view=kc)。 对于 {{ site.data.keys.product_adj }} 安全性检查验证问题处理程序，请使用 [`SecurityCheckChallengeHandler`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refobjc-worklight-ios/html/Classes/SecurityCheckChallengeHandler.html?view=kc)。 |
