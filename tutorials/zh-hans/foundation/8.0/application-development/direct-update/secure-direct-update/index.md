---
layout: tutorial
title: 实施安全直接更新
breadcrumb_title: 安全直接更新
relevantTo: [cordova]
weight: 2
---

## 概述
{: #overview }
要使安全直接更新生效，必须在 {{ site.data.keys.mf_server }} 中部署用户定义的密钥库文件，并且部署的客户机应用程序中必须包含匹配公用密钥的副本。

本主题描述如何将公用密钥绑定到新客户机应用程序和升级的现有客户机应用程序。有关在 {{ site.data.keys.mf_server }} 中配置密钥库的更多信息，请参阅[配置 {{ site.data.keys.mf_server }} 密钥库](../../../authentication-and-security/configuring-the-mobilefirst-server-keystore/)。

服务器提供内置密钥库，可用于针对开发阶段测试安全直接更新。

**注：**在将公用密钥绑定到客户机应用程序并重新构建后，无需重新将其上载到 {{ site.data.keys.mf_server }}。但是，如果预先将应用程序发布到市场，而无公用密钥，那么必须重新发布。

针对开发目的，随 {{ site.data.keys.mf_server }} 一起提供以下缺省哑元公用密钥：

```xml
-----BEGIN PUBLIC KEY-----
MIIDPjCCAiagAwIBAgIEUD3/bjANBgkqhkiG9w0BAQsFADBgMQswCQYDVQQGEwJJTDELMAkGA1UECBMCSUwxETA
PBgNVBAcTCFNoZWZheWltMQwwCgYDVQQKEwNJQk0xEjAQBgNVBAsTCVdvcmtsaWdodDEPMA0GA1UEAxMGV0wgRG
V2MCAXDTEyMDgyOTExMzkyNloYDzQ3NTAwNzI3MTEzOTI2WjBgMQswCQYDVQQGEwJJTDELMAkGA1UECBMCSUwxE
TAPBgNVBAcTCFNoZWZheWltMQwwCgYDVQQKEwNJQk0xEjAQBgNVBAsTCVdvcmtsaWdodDEPMA0GA1UEAxMGV0wg
RGV2MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAzQN3vEB2/of7KAvuvyoIt0T7cjaSTjnOBm0N3+q
zx++dh92KpNJXj/a3o4YbwJXkJ7jU8ykjCYvjXRf0hme+HGhiIVwxJo54iqh76skDS5m7DaseFdndZUJ4p7NFVw
I5ixA36ZArSZ/Pn/ej56/RRjBeRI7AEGXUSGojBUPA6J6DYkwaXQRew9l+Q1kj4dTigyKL5Os0vNFaQyYu+bT2E
vnOixQ0DXm94IqmHZamZKbZLrWcOEfuAsSjKYOdMSM9jkCiHaKcj7fpEZhUxRRs7joKs1Ri4ihs6JeUvMEiG4gK
l9V3FP/Huy0pfkL0F8xMHgaQ4c/lxS/s3PV0OEg+7wIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQAgEhhqRl2Rgkt
MJeqOCRcT3uyr4XDK3hmuhEaE0nOvLHi61PoLKnDUNryWUicK/W+tUP9jkN5xRckdzG6TJ/HPySmZ7Adr6QRFu+
xcIMY+/S8j4PHLXBjoqgtUMhkt7S2/thN/VA6mwZpw4Ol0Pa2hyT2TkhQoYYkRwYCk9pxmuBCoH/eCWpSxquNny
RwrY25x0YzccXUaMI8L3/3hzq3mW40YIMiEdpiD5HqjUDpzN1funHNQdsxEIMYsWmGAwOdV5slFzyrH+ErUYUFA
pdGIdLtkrhzbqHFwXE0v3dt+lnLf21wRPIqYHaEu+EB/A4dLO6hm+IjBeu/No7H7TBFm
-----END PUBLIC KEY-----
```

> 重要信息：请勿将公用密钥用于生产目的。

## 生成和部署密钥库
{: #generating-and-deploying-the-keystore }
可使用多种工具从密钥库生成证书和抽取公用密钥。以下示例演示使用 JDK 密钥工具实用程序和 openSSL 的过程。

1. 从在 {{ site.data.keys.mf_server }} 中部署的密钥库文件抽取公用密钥。  
   注：公用密钥必须为 Base64 编码。
    
   例如，假定别名为 `mfp-server` 并且密钥库文件为 **keystore.jks**。  
   要生成证书，请发出以下命令：
    
   ```bash
   keytool -export -alias mfp-server -file certfile.cert
   -keystore keystore.jks -storepass keypassword
   ```
    
   此时将生成证书文件。  
   发出以下命令以抽取公用密钥：
    
   ```bash
   openssl x509 -inform der -in certfile.cert -pubkey -noout
   ```
    
   **注：**密钥工具单独无法抽取 Base64 格式的公用密钥。
    
2. 执行下列其中一个过程：
    * 将生成的文本（不含 `BEGIN PUBLIC KEY` 和 `END PUBLIC KEY` 标记）复制到应用程序的 mfpclient 属性文件，紧跟在 `wlSecureDirectUpdatePublicKey` 后面。
    * 从命令提示符发出以下命令：`mfpdev app config direct_update_authenticity_public_key <public_key>`
    
    对于 `<public_key>`，粘贴从步骤 1 生成的文本，而不含 `BEGIN PUBLIC KEY` 和 `END PUBLIC KEY` 标记。

3. 运行 cordova build 命令以将公用密钥保存在应用程序中。


