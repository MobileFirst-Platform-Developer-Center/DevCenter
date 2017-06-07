---
layout: tutorial
title: 其他信息
breadcrumb_title: 其他信息
relevantTo: [cordova]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
### 在 iOS 应用程序中实施 TLS 安全连接
{: #enforcing-tls-secure-connections-in-ios-apps }
从 iOS 9 开始，必须在所有应用程序中实施传输层安全性 (TLS) 协议 V1.2。出于开发目的，您可以禁用此协议并忽略 iOS 9 需求。

Apple 应用程序传输安全性 (ATS) 是 iOS 9 的新功能部件，对应用程序和服务器之间的连接实施最佳实践。缺省情况下，此功能部件实施可提高安全性的一些连接需求。这些包括客户机端 HTTPS 请求以及服务器端证书和连接密码，它们通过使用转发密码遵守传输层安全性 (TLS) V1.2。

出于**开发目的**，您可以通过在应用程序的 info.plist 文件中指定异常来覆盖缺省行为，如“应用程序传输安全性技术说明”中所述。但是，在**全生产**环境中，所有 iOS 应用程序都必须实施 TLS 安全连接以确保其正常工作。

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
    
3. 配置针对 TLS 1.2 协议启用的服务器。有关更多信息，请参阅[配置 {{ site.data.keys.mf_server }} 以启用 TLS V1.2](http://www-01.ibm.com/support/docview.wss?uid=swg21965659)
4. 对密码和证书进行设置，因为它们适用于您的设置。有关更多信息，请参阅[应用程序传输安全性技术说明](https://developer.apple.com/library/prerelease/ios/technotes/App-Transport-Security-Technote/)、[对 WebSphere Application Server Network Deployment 使用安全套接字层 (SSL) 进行安全通信](http://www-01.ibm.com/support/knowledgecenter/SSAW57_8.5.5/com.ibm.websphere.nd.doc/ae/csec_sslsecurecom.html?cp=SSAW57_8.5.5%2F1-8-2-33-4-0&lang=en)以及[对 Liberty Profile 启用 SSL 通信](http://www-01.ibm.com/support/knowledgecenter/SSAW57_8.5.5/com.ibm.websphere.wlp.nd.doc/ae/twlp_sec_ssl.html?cp=SSAW57_8.5.5%2F1-3-11-0-4-1-0)。

## 在 Cordova 应用程序中启用 OpenSSL
{: #enabling-openssl-in-cordova-applications }
针对 iOS 的 {{ site.data.keys.product_adj }} Cordova SDK 将本机 iOS API 用于密码术。您可以配置应用程序，以在 Cordova iOS 应用程序中改用 OpenSSL 密码术库。

使用以下 JavaScript API 提供加密/解密功能：

* WL.SecurityUtils.encryptText
* WL.SecurityUtils.decryptWithKey

### 选项 1：本机加密/解密
{: #option-1-native-encryptiondecryption }
缺省情况下，{{ site.data.keys.product_adj }} 在不使用 OpenSSL 的情况下提供本机加密/解密。这相当于以显式方式设置加密/解密行为：

* WL.SecurityUtils.enableNativeEncryption(true)

## 选项 2：启用 OpenSSL
{: #option-2-enabling-openssl }
缺省情况下，禁用 {{ site.data.keys.product_adj }} 提供的 OpenSSL。

要安装支持 OpenSSL 的必需框架，请先安装 Cordova 插件：

```bash
cordova plugin add cordova-plugin-mfp-encrypt-utils
```

以下代码为加密/解密启用 OpenSSL 选项：

* WL.SecurityUtils.enableNativeEncryption(false)

通过此设置，加密/解密调用像 {{ site.data.keys.product }} 先前版本一样使用 OpenSSL。

### 迁移选项
{: #migration-options }
如果您具有在产品先前版本中编写的 {{ site.data.keys.product_adj }} 项目，那么可能需要包含更改才能继续使用 OpenSSL。

* 如果应用程序使用的不是加密/解密 API，并且未在设备上缓存任何加密数据，那么无需操作。
* 如果应用程序使用的是加密/解密 API，那么可以选择将这些 API 与 OpenSSL 结合使用，也可以选择单独使用这些 API。
    - **迁移到本机加密：**
        1. 确保选择缺省本机加密/解密选项（请参阅**选项 1**）。
        2. **迁移高速缓存的数据**：如果先前产品安装使用 OpenSSL 将已加密数据保存到设备，但现在选择本机加密/解密选项，那么必须对存储的数据进行解密。应用程序首次尝试解密数据时，它将回退到 OpenSSL，然后使用本机加密对其进行加密。通过此方式，数据将自动迁移到本机加密。**注：**要允许通过 OpenSSL 解密，必须通过安装 Cordova 插件来添加 OpenSSL 框架：`cordova plugin add cordova-plugin-mfp-encrypt-utils`
    - **继续使用 OpenSSL：**如果需要 OpenSSL，请使用**选项 2** 中描述的设置。
