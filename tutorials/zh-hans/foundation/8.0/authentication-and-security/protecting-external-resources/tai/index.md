---
layout: tutorial
title: 信任关联拦截器
breadcrumb_title: 信任关联拦截器
relevantTo: [android,ios,windows,javascript]
weight: 2
downloads:
  - name: 下载样本
    url: https://github.com/MobileFirst-Platform-Developer-Center/TrustAssociationInterceptor/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
{{ site.data.keys.product_full }} 提供 Java 库以便于通过 [IBM WebSphere 信任关联拦截器](https://www.ibm.com/support/knowledgecenter/SSHRKX_8.5.0/mp/security/sec_ws_tai.dita)对外部资源进行认证。

Java 库是作为 JAR 文件 (**com.ibm.mfp.oauth.tai-8.0.0.jar**) 提供的。

本教程显示如何使用作用域 (`accessRestricted`) 来保护简单 Java Servlet `TAI/GetBalance`。

**先决条件：**

* 阅读[使用 {{ site.data.keys.mf_server }} 来认证外部资源](../)教程。
* 熟悉 [{{ site.data.keys.product }} 安全框架](../../)。

![流程](TAI_flow.jpg)

## 服务器设置
{: #server-setup }
1. 从 **{{ site.data.keys.mf_console }} → 下载中心 → 工具**选项卡下载安全工具 .zip。您将在其中找到 `mfp-oauth-tai.zip` 归档。解压缩此 zip。
2. 将 `com.ibm.mfp.oauth.tai.jar` 文件添加到 **usr/extension/lib** 中的 WebSphere Application Server 实例。
3. 将 `OAuthTai.mf` 文件添加到 **usr/extension/lib/features** 中的 WebSphere Application Server 实例。

### web.xml 设置
{: #webxml-setup }
将安全性约束和安全角色添加到 WebSphere Application Server 实例的 `web.xml` 文件：

```xml
<security-constraint>
   <web-resource-collection>
      <web-resource-name>TrustAssociationInterceptor</web-resource-name>
      <url-pattern>/TAI/GetBalance</url-pattern>
   </web-resource-collection>
   <auth-constraint>
      <role-name>TAIUserRole</role-name>
   </auth-constraint>
</security-constraint>

<security-role id="SecurityRole_TAIUserRole">
   <description>This is the role that {{ site.data.keys.product }} OAuthTAI uses to protect the resource, and it is mandatory to map it to 'All Authenticated in Application' in WebSphere Application Server full profile and to 'ALL_AUTHENTICATED_USERS' in WebSphere Application Server Liberty.</description>
   <role-name>TAIUserRole</role-name>
</security-role>
```

### server.xml
{: #serverxml }
将 WebSphere Application Server `server.xml` 文件修改为您的外部资源。

* 配置功能管理器以包含以下功能：

  ```xml
  <featureManager>
           <feature>jsp-2.2</feature>
           <feature>appSecurity-2.0</feature>
           <feature>usr:OAuthTai-8.0</feature>
           <feature>servlet-3.0</feature>
           <feature>jndi-1.0</feature>
  </featureManager>
  ```

* 添加安全角色作为 Java servlet 中的类注释：

```java
@ServletSecurity(@HttpConstraint(rolesAllowed = "TAIUserRole"))
```

如果使用 servlet-2.x，那么需要在 web.xml 文件中定义安全角色：

```xml
<application contextRoot="TAI" id="TrustAssociationInterceptor" location="TAI.war" name="TrustAssociationInterceptor"/>
   <application-bnd>
      <security-role name="TAIUserRole">
         <special-subject type="ALL_AUTHENTICATED_USERS"/>
      </security-role>
   </application-bnd>
</application>
```

* 配置 OAuthTAI。在此将 URL 设置为受保护的 URL：

  ```xml
  <usr_OAuthTAI id="myOAuthTAI" authorizationURL="http://localhost:9080/mfp/api" clientId="ExternalResourceId" clientSecret="ExternalResourcePass" cacheSize="500">
            <securityConstraint httpMethods="GET POST" scope="accessRestricted" securedURLs="/GetBalance"></securityConstraint>
  </usr_OAuthTAI>
  ```
    - **authorizationURL**：{{ site.data.keys.mf_server }} (`http(s):/your-hostname:port/runtime-name/api`) 或外部 AZ 服务器，例如，IBM DataPower。

    - **clientID**：资源服务器必须是已注册的保密客户机。要了解如何注册保密客户机，请阅读[保密客户机](../../confidential-clients/)教程。*保密客户机**必须** 具有允许的作用域 `authorization.introspect`，以使其可验证令牌。

    - **clientSecret**：资源服务器必须是已注册的保密客户机。要了解如何注册保密客户机，请阅读[保密客户机](../../confidential-clients/)教程。
    - **cacheSize（可选）**：TAI 使用 Java-Token-Validator 高速缓存来缓存令牌和自省数据作为值，从而在较短时间间隔内无需再次自省来自客户机请求中的令牌。

        缺省大小为 50000 个令牌。  

        如果想要保证在每个请求上自省令牌，请将高速缓存值设置为 0。  

    - **scope**：资源服务器针对一个或多个作用域进行认证。作用域可以是安全性检查或映射到安全性检查的作用域元素。

## 使用来自 TAI 的令牌自省数据
{: #using-the-token-introspection-data-from-the-tai }
通过资源，您可能想要访问 TAI 拦截和验证的令牌信息。您可以在此用户文档主题中查找在令牌上找到的数据列表：https://www.ibm.com/support/knowledgecenter/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-mfp-java-token-validator/html/com/ibm/mfp/java/token/validator/data/package-summary.html
要获取此数据，请使用 [WSSubject API](http://www.ibm.com/support/knowledgecenter/SSEQTP_8.5.5/com.ibm.websphere.wlp.doc/ae/rwlp_sec_apis.html)：

```java
Map<String, String> credentials = WSSubject.getCallerSubject().getPublicCredentials(Hashtable.class).iterator().next();
JSONObject securityContext = new JSONObject(credentials.get("securityContext"));
...
securityContext.get('mfp-device')
```

## 样本应用程序
{: #sample-application }
您可以在受支持的应用程序服务器（WebSphere Application Server Full Profile 和 WebSphere Application Server Liberty Profile）上部署项目。  
[下载简单 Java servlet](https://github.com/MobileFirst-Platform-Developer-Center/TrustAssociationInterceptor/tree/release80)。

### 样本用法
{: #sample-usage }
1. 确保[更新保密客户机](../#confidential-client)和 {{ site.data.keys.mf_console }} 中的密钥值。
2. 部署安全性检查：**[UserLogin](../../user-authentication/security-check/)** 或 **[PinCodeAttempts](../../credentials-validation/security-check/)**。
3. 注册匹配应用程序。
4. 将 `accessRestricted` 作用域映射到安全性检查。
5. 更新客户机应用程序以针对 servlet URL 生成 `WLResourceRequest`。
6. 将 securityConstraint 作用域设置为客户机需要进行认证的安全性检查。
