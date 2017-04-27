---
layout: tutorial
title: 与 Cloudant 集成
relevantTo: [javascript]
downloads:
  - name: 下载 Cordova 项目
    url：https://github.com/MobileFirst-Platform-Developer-Center/CloudantAdapter/tree/release80
weight: 9
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
Cloudant 是基于 CouchDB 的非关系型数据库，其作为独立产品和数据库即服务 (DBaaS) 提供在 IBM Bluemix 和 `cloudant.com` 上。

如 Cloudant 文档中所述：
> 文档是 JSON 对象。文档是数据容器，是 Cloudant 数据库的基础。  
所有文档都必须有两个字段：唯一的 `_id` 字段和 `_rev` 字段。由您创建 `_id` 字段，或由 Cloudant 自动生成为 UUID。`_rev` 字段是修订版号，并且是 Cloudant 复制协议必不可少的。除这两个必填字段外，文档还可以包含 JSON 格式的任何其他内容。
Cloudant API 记录于 [IBM Cloudant Documentation](https://docs.cloudant.com/index.html) 站点中。

您可以使用适配器与远程 Cloudant 数据库通信。本教程会向您展示一些示例。

本教程假设您满意这些适配器。请参阅 [JavaScript HTTP 适配器](../javascript-adapters/js-http-adapter)或 [Java 适配器](../java-adapters)。

### 跳转至
{: #jump-to}
* [JavaScript HTTP 适配器](#javascript-http-adapter)
* [Java 适配器](#java-adapters)
* [样本应用程序](#sample-application)


## JavaScript HTTP 适配器
{: #javascript-http-adapter }
Cloudant API 可作为简单的 HTTP Web 服务访问。

您可以使用 HTTP 适配器，通过 `invokeHttp` 方法连接到 Cloudant HTTP 服务。

### 认证
{: #authentication }
Cloudant 支持多种认证形式。请参阅位于以下网址的有关认证的 Cloudant 文档：[https://docs.cloudant.com/authentication.html](https://docs.cloudant.com/authentication.html)。通过 JavaScript HTTP 适配器，您可以使用**基本认证**。

在适配器 XML 文件中，指定 Cloudant 实例的 `domain` 和 `port`，并添加 `basic` 类型的 `authentication` 元素。框架将使用这些凭证生成 `Authorization: Basic` HTTP 头。

**注：**通过 Cloudant，可以生成唯一的 API 密钥，而不是使用真实的用户名和密码。

```xml
<connectivity>
  <connectionPolicy xsi:type="http:HTTPConnectionPolicyType">
    <protocol>https</protocol>
    <domain>CLOUDANT_ACCOUNT.cloudant.com</domain>
    <port>443</port>
    <connectionTimeoutInMilliseconds>30000</connectionTimeoutInMilliseconds>
    <socketTimeoutInMilliseconds>30000</socketTimeoutInMilliseconds>
    <authentication>
      <basic/>
        <serverIdentity>
          <username>CLOUDANT_KEY</username>
          <password>CLOUDANT_PASSWORD</password>
        </serverIdentity>
    </authentication>
    <maxConcurrentConnectionsPerNode>50</maxConcurrentConnectionsPerNode>
    <!-- Following properties used by adapter's key manager for choosing specific certificate from key store
    <sslCertificateAlias></sslCertificateAlias>
    <sslCertificatePassword></sslCertificatePassword>
    -->
  </connectionPolicy>
</connectivity>
```

### 过程
{: #procedures }
您的适配器过程使用 `invokeHttp` 方法，向由 Cloudant 定义的 URL 之一发送 HTTP 请求。  
例如，可以通过将 `POST` 请求发送到 `/{*your-database*}/`（其主体是您想要存储的文档，以 JSON 格式表示）来创建一个新文档。

```js
function addEntry(entry){

    var input = { 
method : 'post',
            returnedContentType : 'json',
            path : DATABASE_NAME + '/',
            body: {
                contentType : 'application/json',        
                content : entry
            }
        };

    var response = MFP.Server.invokeHttp(input);
    if(!response.id){
        response.isSuccessful = false;
    }
    return response;

}
```

相同的想法可应用于所有 Cloudant 功能。请参阅位于以下网址的有关文档的 Cloudant 文档：[https://docs.cloudant.com/document.html](https://docs.cloudant.com/document.html)

## Java 适配器
{: #java-adapters }
Cloudant 为您提供 [Java 客户机库](https://github.com/cloudant/java-cloudant)，便于使用 Cloudant 的所有功能。

在 Java 适配器的初始化期间，设置 `CloudantClient` 实例以便使用。  
**注：**通过 Cloudant，可以生成唯一的 API 密钥，而不是使用真实的用户名和密码。

```java
CloudantClient cloudantClient = new CloudantClient(cloudantAccount,cloudantKey,cloudantPassword);
db = cloudantClient.database(cloudantDBName, false);
```
<br/>
使用[普通的旧 Java 对象](https://en.wikipedia.org/wiki/Plain_Old_Java_Object)和面向 RESTful Web 服务的标准 Java API (JAX-RS 2.0)，通过在 HTTP 请求中发送以 JSON 格式表示的文档，在 Cloudant 上创建一个新文档。
```java
@POST
@Consumes(MediaType.APPLICATION_JSON)
public Response addEntry(User user){
    if(user!=null && user.isValid()){
        db.save(user);
        return Response.ok().build();
    }
    else{
        return Response.status(418).build();
    }
}
```

<img alt="样本应用程序图像" src="cloudant-app.png" style="float:right"/>
## 样本应用程序
{: #sample-application }
[单击以下载](https://github.com/MobileFirst-Platform-Developer-Center/CloudantAdapter/tree/release80) Cordova 项目。

此样本包含两个适配器，一个为 JavaScript，一个为 Java。  
它还包含 Cordova 应用程序，该应用程序使用 Java 和 JavaScript 适配器。

> **注：**由于已知限制，该样本使用 Cloudant Java Client v1.2.3。

### 样本用法
{: #sample-usage }
遵循样本的 README.md 文件获取指示信息。
