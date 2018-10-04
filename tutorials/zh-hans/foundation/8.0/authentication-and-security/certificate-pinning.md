---
layout: tutorial
title: 证书锁定
relevantTo: [ios,android,cordova]
weight: 13
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
通过公用网络进行通信时，必须安全地发送和接收信息。 广泛用于保护这些通信的协议是 SSL/TLS。 （SSL/TLS 指的是安全套接字层或其后续项 TLS，即传输层安全性）。 SSL/TLS 使用数字证书来提供认证和加密。 要信任某证书真实有效，该证书必须通过可信认证中心 (CA) 的根证书进行数字签名。 操作系统和浏览器保留有可信 CA 根证书的列表，以便它们可以轻松验证由这些 CA 发布和签署的证书。

依赖于证书链验证的协议（如 SSL/TLS）容易遭受多种危险的攻击（包括中间人攻击），这种情况会在未经授权方能够查看和修改在移动设备与后端系统间传递的所有流量时发生。

{{ site.data.keys.product_full }} 提供一个用于启用**证书锁定**的 API。 它在本机 iOS、本机 Android 和跨平台 Cordova {{ site.data.keys.product_adj }} 应用程序中受支持。

## 证书锁定过程
{: #certificate-pinning-process }
证书锁定是将主机与其期望的公用密钥关联的过程。 由于您同时拥有服务器端代码和客户机端代码，因此可以将客户机代码配置为仅接受用于自己域名的特定证书，而不接受与操作系统或浏览器认可的可信 CA 根证书对应的任何证书。
证书副本将放入客户机应用程序中。 在 SSL 握手（第一次向服务器发出请求）期间，{{ site.data.keys.product_adj }} 客户机 SDK 会验证服务器证书的公用密钥是否与应用程序中存储的证书的公用密钥匹配。

您还可以将多个证书与客户机应用程序锁定。 所有证书的副本都应放入客户机应用程序中。 在 SSL 握手（第一次向服务器发出请求）期间，{{ site.data.keys.product_adj }} 客户机 SDK 会验证服务器证书的公用密钥是否与应用程序中存储的证书之一的公用密钥匹配。

#### 重要信息
{: #important }
* 某些移动操作系统可能会高速缓存证书验证检查结果。 因此，在发出安全请求**之前**，您的代码应调用证书锁定 API 方法。 否则，任何后续请求可能会跳过证书验证和锁定检查。
* 确保只使用 {{ site.data.keys.product }} API 与相关主机进行所有通信，即使在证书锁定后也如此。 使用第三方 API 与相同的主机交互可能会导致发生意外的行为，如移动操作系统对未验证证书进行高速缓存。
* 再次调用证书锁定 API 方法会覆盖先前的锁定操作。

如果锁定过程成功，那么在安全请求 SSL/TLS 握手期间，将使用所提供证书内的公用密钥来验证 {{ site.data.keys.mf_server }} 证书的完整性。 如果锁定过程失败，那么客户机应用程序将拒绝针对服务器的所有 SSL/TLS 请求。

## 证书设置
{: #certificate-setup }
您必须使用从认证中心购买的证书。 自签名证书**不受支持**。 为了与受支持的环境保持兼容，请确保使用以 **DER**（特异编码规则，根据国际电信联盟 X.690 标准定义）格式编码的证书。

证书必须放入 {{ site.data.keys.mf_server }} 和应用程序中。 按如下方式放置证书：

* 在 {{ site.data.keys.mf_server }}（WebSphere Application Server、WebSphere Application Server Liberty 或 Apache Tomcat）中：参考您的特定应用程序服务器的文档，以获取有关如何配置 SSL/TLS 和证书的信息。
* 在您的应用程序中：
    - 本机 iOS：向应用程序**捆绑软件**添加证书
    - 本机 Android：将证书放入 **assets** 文件夹中
    - Cordova：将证书放入 **app-name\www\certificates** 文件夹中（如果此文件夹尚不存在，请予以创建）

## 证书锁定 API
{: #certificate-pinning-api }
证书锁定包含以下过载 API 方法，其中一个方法具有参数 `certificateFilename`，其中 `certificateFilename` 是证书文件的名称，第二个方法具有参数 `certificateFilenames`，其中 `certificateFilenames` 是证书文件的名称数组。

### Android
{: #android }
单证书：
语法：
pinTrustedCertificatePublicKeyFromFile(String certificateFilename);
示例：
```java
WLClient.getInstance().pinTrustedCertificatePublicKey("myCertificate.cer");
```
多个证书：

语法：
pinTrustedCertificatePublicKeyFromFile(String[] certificateFilename);
示例：
```java
String[] certificates={"myCertificate.cer","myCertificate1.cer"};
WLClient.getInstance().pinTrustedCertificatePublicKey(certificates);
```
在以下两种情况下，证书锁定方法将引发异常：
* 文件不存在
* 文件格式错误


### iOS
{: #ios }
单证书锁定语法：
pinTrustedCertificatePublicKeyFromFile:(NSString*) certificateFilename;

在以下两种情况下，证书锁定方法将引发异常：
* 文件不存在
* 文件格式错误

多证书锁定语法：
pinTrustedCertificatePublicKeyFromFiles:(NSArray*) certificateFilenames;

在以下两种情况下，证书锁定方法将引发异常：
* 不存在证书文件
* 不存在格式正确的证书文件

**在 Objective-C 中：**
示例：
单证书：
```objc
[[WLClient sharedInstance]pinTrustedCertificatePublicKeyFromFile:@"myCertificate.cer"];

```
多证书：
示例：
```objc
NSArray *arrayOfCerts = [NSArray arrayWithObjects:@“Cert1”,@“Cert2”,@“Cert3",nil];
[[WLClient sharedInstance]pinTrustedCertificatePublicKeyFromFiles:arrayOfCerts];
```

**在 Swift 中：**

单证书：
示例：
```swift
WLClient.sharedInstance().pinTrustedCertificatePublicKeyFromFile("myCertificate.cer")
```
多证书：
示例：
```swift
let arrayOfCerts : [Any] = ["Cert1", "Cert2”, "Cert3”];
WLClient.sharedInstance().pinTrustedCertificatePublicKey( fromFiles: arrayOfCerts)
```

在以下两种情况下，证书锁定方法将引发异常：

* 文件不存在
* 文件格式错误

### Cordova
{: #cordova }

单证书锁定：

```javascript
WL.Client.pinTrustedCertificatePublicKey('myCertificate.cer').then(onSuccess, onFailure);
```

多证书锁定：

```javascript
WL.Client.pinTrustedCertificatePublicKey(['Cert1.cer','Cert2.cer','Cert3.cer']).then(onSuccess, onFailure);
```

证书锁定方法会返回预期结果：

* 成功锁定时，证书锁定方法将调用 onSuccess 方法。
* 在以下两种情况下，证书锁定方法将触发 onFailure 回调：
* 文件不存在
* 文件格式错误

之后，如果对未锁定其证书的服务器发出安全请求，那么将调用特定请求（例如，`obtainAccessToken` 或 `WLResourceRequest`）的 `onFailure` 回调。

> 在 [API 参考](../../api/client-side-api/)中了解有关证书锁定 API 方法的更多信息
