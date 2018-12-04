---
layout: tutorial
title: 将 MobileFirst Foundation SDK 添加到 iOS 应用程序
breadcrumb_title: iOS
relevantTo: [ios]
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
MobileFirst Foundation SDK 包含通过 [CocoaPods](http://guides.cocoapods.org) 可用并且可添加到 Xcode 项目的 pod 集合。  
pod 与核心函数和其他函数对应：

* **IBMMobileFirstPlatformFoundation** - 实现客户机到服务器连接，并处理认证和安全方面、资源请求和其他必需的核心函数。
* **IBMMobileFirstPlatformFoundationJSONStore** - 包含 JSONStore 框架。 有关更多信息，请查看[针对 iOS 的 JSONStore 教程](../../jsonstore/ios/)。
* **IBMMobileFirstPlatformFoundationPush** - 包含推送通知框架。 有关更多信息，请查看[通知教程](../../../notifications/)。
* **IBMMobileFirstPlatformFoundationWatchOS** - 包含对 Apple WatchOS 的支持。

在此教程中，了解如何使用 CocoaPods 将 MobileFirst 本机 SDK 添加到新的或现有的 iOS 应用程序。 您还可以了解如何配置 {{ site.data.keys.mf_server }} 以识别应用程序。

**先决条件：**

- Xcode 和 MobileFirst CLI 已安装在开发人员工作站上。  
- {{ site.data.keys.mf_server }} 的本地或远程实例正在运行。
- 阅读[设置您的 MobileFirst 开发环境](../../../installation-configuration/development/mobilefirst)和[设置您的 iOS 开发环境](../../../installation-configuration/development/ios)教程。

> **注：**使用 XCode 8 的情况下在模拟器上运行 iOS 应用程序时必需**密钥链共享**功能。

#### 跳转至：
{: #jump-to }
- [添加 MobileFirst 本机 SDK](#adding-the-mobilefirst-native-sdk)
- [手动添加 MobileFirst 本机 SDK](#manually-adding-the-mobilefirst-native-sdk)
- [添加对 Apple watchOS 的支持](#adding-support-for-apple-watchos)
- [更新 MobileFirst 本机 SDK](#updating-the-mobilefirst-native-sdk)
- [已生成 MobileFirst 本机 SDK 工件](#generated-mobilefirst-native-sdk-artifacts)
- [位码和 TLS 1.2](#bitcode-and-tls-12)
- [接下来要学习的教程](#tutorials-to-follow-next)

## 添加 {{ site.data.keys.product_adj }} 本机 SDK
{: #adding-the-mobilefirst-native-sdk }
遵循下面的指示信息将 {{ site.data.keys.product }} 本机 SDK 添加到新的或现有的 Xcode 项目，以将应用程序注册到 {{ site.data.keys.mf_server }}。

在您开始之前，确保 {{ site.data.keys.mf_server }} 正在运行。  
如果使用本地安装的服务器：从**命令行**窗口，浏览至服务器的文件夹，然后运行命令：`./run.sh`。

### 创建应用程序
{: #creating-an-application }
创建 Xcode 项目或使用现有项目（Swift 或 Objective-C）。  

### 添加 SDK
{: #adding-the-sdk }
1. 通过 CocoaPods 提供 {{ site.data.keys.product }} 本机 SDK。
    - 如果您的开发环境中已安装有 [CocoaPods](http://guides.cocoapods.org)，请跳至步骤 2。
    - 如果未安装 CocoaPods，将按照如下进行安装：  
        - 打开**命令行**窗口并浏览至 Xcode 项目的根目录。
        - 运行命令：`sudo gem install cocoapods`，然后运行命令 `pod setup`。 **注：**这些命令可能需要几分钟完成。
2. 运行命令：`pod init`。 这将创建 `Podfile`。
3. 使用您偏爱的代码编辑器打开 `Podfile`。
    - 注释掉或删除文件的内容。
    - 添加以下行并保存更改：

      ```xml
      use_frameworks!

      platform :ios, 8.0
      target "Xcode-project-target" do
          pod 'IBMMobileFirstPlatformFoundation'
      end
      ```
      - 将 **Xcode-project-target** 替换为 Xcode 项目目标的名称。

4. 返回到命令行窗口，运行命令 `pod install`，然后运行命令 `pod update`。 这些命令将添加 {{ site.data.keys.product }} 本机 SDK 文件、添加 **mfpclient.plist** 文件并生成 Pod 项目。  
    **注：**这些命令可能需要几分钟完成。

    > <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>**要点**：从此时开始，使用 `[ProjectName].xcworkspace` 文件在 Xcode 中打开项目。 请**勿**使用 `[ProjectName].xcodeproj` 文件。 基于 CocoaPods 的项目将作为包含应用程序（可执行程序）和库（CocoaPods 管理器提取的所有项目依赖关系）的工作空间进行管理。

### 手动添加 {{ site.data.keys.product_adj }} 本机 SDK
{: #manually-adding-the-mobilefirst-native-sdk }
您还可以手动添加 {{ site.data.keys.product }} SDK：

<div class="panel-group accordion" id="adding-the-sdk-manually" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="ios-sdk">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#ios-sdk" data-target="#collapse-ios-sdk" aria-expanded="false" aria-controls="collapse-ios-sdk"><b>单击以获取指示信息</b></a>
            </h4>
        </div>

        <div id="collapse-ios-sdk" class="panel-collapse collapse" role="tabpanel" aria-labelledby="ios-sdk">
            <div class="panel-body">
                <p>要手动添加 {{ site.data.keys.product }} SDK，请先通过 <b>{{ site.data.keys.mf_console }} → 下载中心 → SDK</b> 选项卡下载 SDK .zip 文件。</p>

                <ul>
                    <li>在您的 Xcode 项目中，将 {{ site.data.keys.product }} 框架文件添加到您的项目。
                        <ul>
                            <li>在 Project Explorer 中选择项目根图标。</li>
                            <li>选择<b>文件 → 添加文件</b>，然后浏览至包含先前已下载框架文件的文件夹。</li>
                            <li>单击<b>选项</b>按钮。</li>
                            <li>选择<b>根据需要复制项目</b>和<b>为任何添加的文件夹创建组</b>。<br/>
                            <b>注：</b>如果未选择<b>根据需要复制项目</b>选项，那么将不会复制框架文件，但会从其原始位置链接框架文件。</li>
                            <li>选择主要项目（第一个选项）并选择应用程序目标。</li>
                            <li>在<b>常规</b>选项卡中，移除自动添加到<b>已链接的框架和库</b>的任何框架。</li>
                            <li>必需：在<b>嵌入式二进制文件</b>中，添加以下框架：
                                <ul>
                                    <li>IBMMobileFirstPlatformFoundation.framework</li>
                                    <li>IBMMobileFirstPlatformFoundationOpenSSLUtils.framework</li>
                                    <li>IBMMobileFirstPlatformFoundationWatchOS.framework</li>
                                </ul>
                                执行此步骤会自动将这些框架添加到<b>已链接的框架和库</b>。
                            </li>
                            <li>在<b>已链接的框架和库</b>中，添加以下框架：
                                <ul>
                                    <li>IBMMobileFirstPlatformFoundationJSONStore.framework</li>
                                    <li>sqlcipher.framework</li>
                                    <li>openssl.framework</li>
                                    <li>Localizations.bundle</li>
                                </ul>
                            </li>
                            <blockquote><b>注：</b>这些步骤会将相关的 {{ site.data.keys.product }} 框架复制到项目，并将“链接二进制文件”中的这些框架与“构建阶段”选项卡中的库列表链接。 如果将文件链接到其原始位置（没有按照先前描述选择“根据需要复制项目”选项），那么需要按照下面所述设置“框架搜索路径”。</blockquote>
                        </ul>
                    </li>
                    <li>在步骤 1 中添加的框架将自动添加到<b>构建阶段</b>选项卡中的<b>将二进制文件与库进行链接</b>部分。</li>
                    <li><i>可选：</i>如果您没有按照先前所述将框架文件复制到项目中，请在<b>构建阶段</b>选项卡中使用<b>根据需要复制项目</b>选项执行以下步骤。
                        <ul>
                            <li>打开<b>构建设置</b>页面。</li>
                            <li>查找<b>搜索路径</b>部分。</li>
                            <li>将包含框架的文件夹的路径添加到<b>框架搜索路径</b>文件夹。</li>
                        </ul>
                    </li>
                    <li>在<b>构建设置</b>选项卡的<b>部署</b>部分中，为 <b>iOS 部署目标</b>字段选择一个大于或等于 8.0 的值。</li>
                    <li><i>可选：</i>从 Xcode 7 开始，将位码设置为缺省项。 有关限制和需求，请参阅<a href="additional-information/#working-with-bitcode-in-ios-apps">在 iOS 应用程序中使用位码</a>。 要禁用位码：
                        <ul>
                            <li>打开<b>构建选项</b>部分。</li>
                            <li>将<b>启用位码</b>设置为<b>否</b>。</li>
                        </ul>
                    </li>
                    <li>从 Xcode 7 开始，必须实施 TLS。 请参阅<a href="additional-information/#enforcing-tls-secure-connections-in-ios-apps">在 iOS 应用程序中实施 TLS 安全连接</a>。</li>
                </ul>

                <br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#ios-sdk" data-target="#collapse-ios-sdk" aria-expanded="false" aria-controls="collapse-ios-sdk"><b>结束部分</b></a>
            </div>
        </div>
    </div>
</div>

### 注册应用程序
{: #registering-the-application }
1. 打开**命令行**窗口并浏览至 Xcode 项目的根目录。  

2. 运行以下命令：

    ```bash
    mfpdev app register
    ```
    - 如果使用的是远程服务器，请[使用命令 `mfpdev server add`](../../using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance) 进行添加。

    系统会要求您提供应用程序的 BundleID。 **要点**：BundleID 是**区分大小写的**。  

`mfpdev app register` CLI 命令将先连接到 {{ site.data.keys.mf_server }} 以注册应用程序，然后在 Xcode 项目的根目录生成 **mfpclient.plist** 文件，并向该文件添加用来标识 {{ site.data.keys.mf_server }} 的元数据。  

> <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> **提示：**您还可以从 {{ site.data.keys.mf_console }} 注册应用程序：    
>
> 1. 装入 {{ site.data.keys.mf_console }}。
> 2. 单击**应用程序**旁边的**新建**按钮以注册新应用程序，并遵循屏幕上的指示信息。  
> 3. 注册应用程序之后，浏览至应用程序的**配置文件**选项卡，然后复制或下载 **mfpclient.plist** 文件。 遵循屏幕上指示信息将此文件添加到您的项目。

### 完成设置过程
{: #completing-the-setup-process }
在 Xcode 中，右键单击项目条目，单击**将文件添加到 [ProjectName]**，然后选择位于 Xcode 项目根目录的 **mfpclient.plist** 文件。

### 参考 SDK
{: #referencing-the-sdk }
无论何时您想要使用 {{ site.data.keys.product }} 本机 SDK，都请确保导入 {{ site.data.keys.product }} 框架：

Objective-C：

```objc
#import <IBMMobileFirstPlatformFoundation/IBMMobileFirstPlatformFoundation.h>
```

Swift：

```swift
import IBMMobileFirstPlatformFoundation
```

<br>
#### 关于 iOS 9 及以上版本的注意事项：
{: #note-about-ios-9-and-above }
> 从 Xcode 7 开始，缺省情况下会启用[应用程序传输安全性 (ATS)](https://developer.apple.com/library/ios/releasenotes/General/WhatsNewIniOS/Articles/iOS9.html#//apple_ref/doc/uid/TP40016198-SW14)。 要在开发期间运行应用程序，可以禁用 ATS（[阅读更多](http://iosdevtips.co/post/121756573323/ios-9-xcode-7-http-connect-server-error)）。
>   1. 在 Xcode 中，右键单击 **[project]/info.plist 文件 → 打开方式 → 源代码**
>   2. 粘贴以下内容：
>
```xml
>      <key>NSAppTransportSecurity</key>
>      <dict>
>            <key>NSAllowsArbitraryLoads</key>
>            <true/>
>      </dict>
```

## 添加对 Apple watchOS 的支持
{: #adding-support-for-apple-watchos}
如果是为 Apple watchOS 2 和更高版本进行开发，那么 Podfile 必须包含与主要应用程序和 watchOS 扩展对应的部分。 请参阅下面针对 watchOS 2 的示例：

```xml
# Replace with the name of your watchOS application
xcodeproj 'MyWatchApp'

use_frameworks!

#use the name of the iOS target
target :MyWatchApp do
    platform :ios, 9.0
    pod 'IBMMobileFirstPlatformFoundation'
    end

#use the name of the watch extension target
target :MyWatchApp WatchKit Extension do
    platform :watchos, 2.0
    pod 'IBMMobileFirstPlatformFoundation'
end
```

验证 Xcode 项目是否已关闭，然后运行 `pod install` 命令。

## 更新 {{ site.data.keys.product_adj }} 本机 SDK
{: #updating-the-mobilefirst-native-sdk }
要使用最新发行版更新 {{ site.data.keys.product }} 本机 SDK，请在**命令行**窗口中从 Xcode 项目的根文件夹运行以下命令：

```bash
pod update
```

可以在 SDK 的 [CocoaPods 存储库](https://cocoapods.org/?q=ibm%20mobilefirst)中找到 SDK 发行版。

## 已生成 {{ site.data.keys.product_adj }} 本机 SDK 工件
{: #generated-mobilefirst-native-sdk-artifacts }
### mfpclient.plist
{: #mfpclientplist }
此文件位于项目的根目录中，定义用于在 {{ site.data.keys.mf_server }} 上注册 iOS 应用程序的客户机端属性。

| 属性            | 描述                                                         | 示例值 |
|---------------------|---------------------------------------------------------------------|----------------|
| protocol    | 与
{{ site.data.keys.mf_server }}
的通信协议。             | http 或 https  |
| host        | {{ site.data.keys.mf_server }} 的主机名。                            | 192.168.1.63   |
| port        | {{ site.data.keys.mf_server }} 的端口。                                 | 9080           |
| wlServerContext     | {{ site.data.keys.mf_server }} 上应用程序的上下文根路径。 | /mfp/          |
| languagePreferences | 为客户机 sdk 系统消息设置缺省语言。           | zh             |

## 位码和 TLS 1.2
{: #bitcode-and-tls-12 }
有关对位码和 TLS 1.2 的支持的信息，请参阅[其他信息](additional-information)页面。

## 接下来要学习的教程
{: #tutorials-to-follow-next }
集成 {{ site.data.keys.product }} 本机 SDK 之后，您现在可以：

- 查看[使用 {{ site.data.keys.product }} SDK 教程](../)
- 查看[适配器开发教程](../../../adapters/)
- 查看[认证和安全教程](../../../authentication-and-security/)
- 查看[通知教程](../../../notifications/)
- 查看[所有教程](../../../all-tutorials)
