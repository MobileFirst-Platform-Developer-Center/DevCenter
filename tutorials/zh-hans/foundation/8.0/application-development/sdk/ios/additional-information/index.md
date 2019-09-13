---
layout: tutorial
title: 其他信息
breadcrumb_title: additional information
relevantTo: [ios]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
### 在 iOS 应用程序中使用位码
{: #working-with-bitcode-in-ios-apps }
* 不支持使用位码进行应用程序真实性安全检查。
* watchOS 应用程序需要启用位码。

要启用位码，请在您的 Xcode 项目中浏览至**构建设置**选项卡，并将**启用位码**设置为**是**。

### 在 iOS 应用程序中实施 TLS 安全连接
{: #enforcing-tls-secure-connections-in-ios-apps }
从 iOS 9 开始，必须在所有应用程序中实施传输层安全性 (TLS) 协议 V1.2。 出于开发目的，您可以禁用此协议并忽略 iOS 9 需求。

Apple 应用程序传输安全性 (ATS) 是 iOS 9 的新功能部件，对应用程序和服务器之间的连接实施最佳实践。 缺省情况下，此功能部件实施可提高安全性的一些连接需求。 这些包括客户机端 HTTPS 请求以及服务器端证书和连接密码，它们通过使用转发密码遵守传输层安全性 (TLS) V1.2。

出于**开发目的**，您可以通过在应用程序的 info.plist 文件中指定异常来覆盖缺省行为，如“应用程序传输安全性技术说明”中所述。 但是，在**全生产**环境中，所有 iOS 应用程序都必须实施 TLS 安全连接以确保正常工作。

要启用非 TLS 连接，以下异常必须显示在 **project-name\Resources** 文件夹的 **project-name-info.plist** 文件中：

```xml
<key>NSExceptionDomains</key>
    <dict>
        <key>yourserver.com</key>
    
            <dict>
            <!--Include to allow subdomains-->
            <key>NSIncludesSubdomains</key>
            <true/>

            <!--Include to allow insecure HTTP requests-->
            <key>NSTemporaryExceptionAllowsInsecureHTTPLoads</key>
            <true/>
        </dict>
    </dict>
```

为生产做准备

1. 移除或注释掉先前显示在此页面中的代码。  
2. 设置客户机以使用以下条目将 HTTPS 请求发送到字典：  

   ```xml
   <key>protocol</key>
   <string>https</string>

   <key>port</key>
   <string>10443</string>
   ```
   
   在 `httpEndpoint` 定义内的 **server.xml** 中的服务器上定义 SSL 端口号。
    
3. 配置为 TLS 1.2 协议启用的服务器。 有关更多信息，请参阅[配置 {{ site.data.keys.mf_server }} 以启用 TLS V1.2](http://www-01.ibm.com/support/docview.wss?uid=swg21965659)
4. 对密码和证书进行设置，因为它们适用于您的设置。 有关更多信息，请参阅[应用程序传输安全性技术说明](https://developer.apple.com/library/prerelease/ios/technotes/App-Transport-Security-Technote/)、[对 WebSphere Application Server Network Deployment 使用安全套接字层 (SSL) 进行安全通信](http://www-01.ibm.com/support/knowledgecenter/SSAW57_8.5.5/com.ibm.websphere.nd.doc/ae/csec_sslsecurecom.html?cp=SSAW57_8.5.5%2F1-8-2-33-4-0&lang=en)以及[对 Liberty Profile 启用 SSL 通信](http://www-01.ibm.com/support/knowledgecenter/SSAW57_8.5.5/com.ibm.websphere.wlp.nd.doc/ae/twlp_sec_ssl.html?cp=SSAW57_8.5.5%2F1-3-11-0-4-1-0)。

### 为 iOS 启用 OpenSSL
{: #enabling-openssl-for-ios }
{{ site.data.keys.product_adj }} iOS SDK 将本机 iOS API 用于密码术。 您可以配置 {{ site.data.keys.product_full }}，以在 iOS 应用程序中使用 OpenSSL 密码术库。

以下 API 提供了加密/解密：`WLSecurityUtils.encryptText()` 和 `WLSecurityUtils.decryptWithKey()`。

#### 选项 1：本机加密和解密
{: #option-1-native-encryption-and-decryption }
缺省情况下，不使用 OpenSSL 提供本机加密和解密。 这相当于以显式方式设置加密或解密行为，如下所示：

```xml
WLSecurityUtils enableOSNativeEncryption:YES
```

#### 选项 2：启用 OpenSSL
{: #option-2-enabling-openssl }
缺省情况下，OpenSSL 已禁用。 要将其启用，请如下所示执行操作：

1. 安装 OpenSSL 框架：
    * 使用 CocoaPods：使用 CocoaPods 来安装 `IBMMobileFirstPlatformFoundationOpenSSLUtils` pod。
    * 在 Xcode 中手动：在“构建阶段”选项卡的“将二进制与库进行链接”部分中，手动链接 `IBMMobileFirstPlatformFoundationOpenSSLUtils` 和 openssl 框架。
2. 以下代码为加密/解密启用 OpenSSL 选项：

   ```xml
   WLSecurityUtils enableOSNativeEncryption:NO
   ```
    
   代码现在将使用 OpenSSL 实施（如果找到），否则在未正确安装框架的情况下会抛出错误。

通过此设置，加密/解密调用像该产品的先前版本一样使用 OpenSSL。

### 迁移选项
{: #migration-options }
如果您具有在先前版本中编写的 {{ site.data.keys.product_adj }} 项目，那么可能需要包含更改才能继续使用 OpenSSL。
    * 如果应用程序使用的不是加密/解密 API，并且未在设备上缓存任何加密数据，那么无需操作。
    * 如果应用程序使用的是加密/解密 API，那么可以选择将这些 API 与 OpenSSL 结合使用，也可以选择单独使用这些 API。

#### 迁移到本机加密
{: #migrating-to-native-encryption }
1. 确保选择缺省本机加密/解密选项（请参阅选项 1）。
2. 迁移高速缓存的数据：如果 {{ site.data.keys.product_full }} 的先前安装使用 OpenSSL 将加密数据保存到设备，那么必须安装 OpenSSL 框架，如选项 2 中所述。应用程序首次尝试解密数据时，它将回退到 OpenSSL，然后使用本机加密对其进行加密。 如果未安装 OpenSSL 框架，那么会抛出错误。 通过此方式，数据将自动迁移到本机加密，从而允许后续发行版在没有 OpenSSL 框架的情况下工作。

#### 继续使用 OpenSSL
{: #continuing-with-openssl }
如果需要 OpenSSL，请使用选项 2 中描述的设置。
