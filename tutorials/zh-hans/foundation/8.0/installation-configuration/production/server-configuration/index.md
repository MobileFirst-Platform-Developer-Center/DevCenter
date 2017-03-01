---
layout: tutorial
title: 配置 MobileFirst Server
weight: 5
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
考虑您的备份和恢复策略，优化您的 {{ site.data.keys.mf_server }} Server 配置并应用访问限制和安全选项。

#### 跳转至
{: #jump-to }

* [{{ site.data.keys.mf_server }} 生产服务器的端点](#endpoints-of-the-mobilefirst-server-production-server)
* [配置 {{ site.data.keys.mf_server }} 以启用 TLS V1.2](#configuring-mobilefirst-server-to-enable-tls-v12)
* [为 {{ site.data.keys.mf_server }} 管理配置用户认证](#configuring-user-authentication-for-mobilefirst-server-administration)
* [{{ site.data.keys.mf_server }} Web 应用程序的 JNDI 属性列表](#list-of-jndi-properties-of-the-mobilefirst-server-web-applications)
* [配置数据源](#configuring-data-sources)
* [配置日志记录和监控机制](#configuring-logging-and-monitoring-mechanisms)
* [配置多个运行时](#configuring-multiple-runtimes)
* [配置许可证跟踪](#configuring-license-tracking)
* [WebSphere Application Server SSL 配置和 HTTP 适配器](#websphere-application-server-ssl-configuration-and-http-adapters)

## {{ site.data.keys.mf_server }} 生产服务器的端点
{: #endpoints-of-the-mobilefirst-server-production-server }
您可以为 IBM {{ site.data.keys.mf_server }} 的端点创建白名单和黑名单。

> **注：**{{ site.data.keys.product }} 所公开的 URL 相关信息将作为准则提供。组织必须根据白名单和黑名单启用的内容，确保在企业基础结构中对这些 URL 进行测试。| API URL（位于 `<runtime context root>/api/` 下） | 描述                               | 针对白名单建议？ |
|---------------------------------------------|-------------------------------------------|--------------------------|
| /adapterdoc/*	                              | 为指定适配器返回适配器的 Swagger 文档 | 否。仅供管理员和开发人员内部使用 |
| /adapters/*  | 适配器服务 | 是 |
| /az/v1/authorization/* | 授权客户机访问特定范围 | 是 |
| /az/v1/introspection | 反思客户机的访问令牌 | 否。此 API 仅用于保密客户机。 |
| /az/v1/token | 为客户机生成访问令牌 | 是 |
| /clientLogProfile/* | 获取客户机日志概要文件 | 是 |
| /directupdate/* | 获取直接更新 .zip 文件 | 是，如果您计划使用“直接更新” |
| /loguploader | 将客户机日志上载到服务器 | 是 |
| /preauth/v1/heartbeat | 接受客户机的脉动信号，并注意上一次活动时间 | 是 |
| /preauth/v1/logout | 注销安全性检查 | 是 |
| /preauth/v1/preauthorize | 为特定范围映射和执行安全性检查 | 是 |
| /reach | 服务器可访问 | 否，仅供内部使用 |
| /registration/v1/clients/* | 注册服务客户机 API | 否。此 API 仅用于保密客户机。 |
| /registration/v1/self/* | 注册服务客户机自注册 API | 是 |

## 配置 {{ site.data.keys.mf_server }} 以启用 TLS V1.2
{: #configuring-mobilefirst-server-to-enable-tls-v12 }
为使 {{ site.data.keys.mf_server }} 与仅支持传输层安全性 v1.2 (TLS V1.2)（SSL 协议的一种）的设备通信，必须完成以下指示信息。

用于配置 {{ site.data.keys.mf_server }} 以启用传输层安全性 (TLS) V1.2 的步骤取决于 {{ site.data.keys.mf_server }} 如何连接到设备。

* 如果 {{ site.data.keys.mf_server }} 在逆向代理（在将 SSL 编码包传递到应用程序服务器之前对这些包解密）的后面，那么您必须对逆向代理启用 TLS V1.2 支持。如果使用 IBM HTTP Server 作为逆向代理，请参阅 [Securing IBM HTTP Server](http://www.ibm.com/support/knowledgecenter/SSEQTP_8.5.5/com.ibm.websphere.ihs.doc/ihs/welc6top_securing_ihs_container.html?view=kc) 以获取指示信息。
* 如果 {{ site.data.keys.mf_server }} 直接与设备通信，那么用于启用 TLS V1.2 的步骤取决于应用程序服务器是 Apache Tomcat、WebSphere Application Server Liberty Profile 还是 WebSphere Application Server Full Profile。

### Apache Tomcat
{: #apache-tomcat }
1. 确认 Java 运行时环境 (JRE) 支持 TLS V1.2。确保您具有以下某个 JRE 版本：
    * Oracle JRE 1.7.0_75 或更高版本
    * Oracle JRE 1.8.0_31 或更高版本
2. 编辑 **conf/server.xml** 文件，并修改用于声明 HTTPS 端口的 `Connector` 元素，以使 **sslEnabledProtocols** 属性具有以下值：`sslEnabledProtocols="TLSv1.2,TLSv1.1,TLSv1,SSLv2Hello"`。

### WebSphere  Application Server Liberty Profile
{: #websphere-application-server-liberty-profile }
1. 确认 Java 运行时环境 (JRE) 支持 TLS V1.2。
    * 如果使用 IBM Java SDK，请确保针对 POODLE 漏洞对 IBM Java SDK 打好补丁。您可以在 [Security Bulletin: Vulnerability in SSLv3 affects IBM WebSphere Application Server (CVE-2014-3566)](http://www.ibm.com/support/docview.wss?uid=swg21687173) 中找到包含 WebSphere Application Server 版本补丁的最低的 IBM Java SDK 版本。

        > **注：**您可以使用安全公告中所列的版本或更高版本。
    * 如果使用 Oracle Java SDK，请确保您具有以下某个版本：
        * Oracle JRE 1.7.0_75 或更高版本
        * Oracle JRE 1.8.0_31 或更高版本
2. 如果使用 IBM Java SDK，请编辑 **server.xml** 文件。
    * 添加以下行：`<ssl id="defaultSSLConfig" keyStoreRef="defaultKeyStore" sslProtocol="SSL_TLSv2"/>`
    * 将 `sslProtocol="SSL_TLSv2"` 属性添加到所有现有的 `<ssl>` 元素。

### WebSphere Application Server Full Profile
{: #websphere-application-server-full-profile }
1. 确认 Java 运行时环境 (JRE) 支持 TLS V1.2。

    确保针对 POODLE 漏洞对 IBM Java SDK 打好补丁。您可以在 [Security Bulletin: Vulnerability in SSLv3 affects IBM WebSphere Application Server (CVE-2014-3566)](http://www.ibm.com/support/docview.wss?uid=swg21687173) 中找到包含 WebSphere Application Server 版本补丁的最低的 IBM Java SDK 版本。   
     > **注：**您可以使用安全公告中所列的版本或更高版本。
    2. 登录到 WebSphere Application Server 管理控制台，然后单击**安全性 → SSL 证书和密钥管理 → SSL 配置**。
3. 针对所列的每个 SSL 配置，修改该配置以启用 TLS V1.2。
    * 选择 SSL 配置，然后在**其他属性**下单击**保护质量 (QoP) **设置。
    * 从**协议**列表中，选择 **SSL_TLSv2**。
    * 单击**应用**，然后保存更改。

## 为 {{ site.data.keys.mf_server }} 管理配置用户认证
{: #configuring-user-authentication-for-mobilefirst-server-administration }
{{ site.data.keys.mf_server }} 管理需要用户认证。您可以配置用户认证并选择认证方法。然后，配置过程将取决于您所使用的 Web 应用程序服务器。

> **要点：**如果使用独立的 WebSphere  Application Server Full Profile，请在全局安全性中使用“简单 WebSphere 认证方法”(SWAM) 以外的认证方法。您可以使用轻量级第三方认证 (LTPA)。如果使用 SWAM，那么可能会发生意外的认证失败。安装程序在 Web 应用程序服务器中部署 {{ site.data.keys.mf_server }} 管理 Web 应用程序之后，您必须配置认证。

{{ site.data.keys.mf_server }} 管理定义了以下 Java Platform，Enterprise Edition ((Java EE) 安全角色：

* mfpadmin
* mfpdeployer
* mfpoperator
* mfpmonitor

必须将角色映射到对应的用户集。**mfpmonitor** 角色可以查看数据，但不能更改任何数据。下表列出了用于生产服务器的 MobileFirst 角色和功能。

#### 部署
{: #deployment }

|                        | 管理员 | 部署者    | 操作员    | 监控者    |
|------------------------|---------------|-------------|-------------|------------|
| Java EE 安全角色。 | mfpadmin      | mfpdeployer | mfpoperator | mfpmonitor |
| 部署应用程序。 | 是           | 是         | 否          | 否         |
| 部署适配器。     | 是           | 是         | 否          | 否         |

#### {{ site.data.keys.mf_server }} 管理
{: #mobilefirst-server-management }

|                            | 管理员 | 部署者    | 操作员    | 监控者    |
|----------------------------|---------------|-------------|-------------|------------|
| Java EE 安全角色。     | mfpadmin      | mfpdeployer | mfpoperator | mfpmonitor |
| 配置运行时设置。| 是           | 是         | 否          | 否         |

#### 应用程序管理
{: #mobilefirst-server-management }

|                                     | 管理员 | 部署者    | 操作员    | 监控者    |
|-------------------------------------|---------------|-------------|-------------|------------|
| Java EE 安全角色。              | mfpadmin      | mfpdeployer | mfpoperator | mfpmonitor |
| 上载新的 {{ site.data.keys.product_adj }} 应用程序。 | 是           | 是         | 否          | 否         |
| 除去 {{ site.data.keys.product_adj }} 应用程序。	  | 是           | 是         | 否          | 否         |
| 上载新的适配器。     | 是           | 是         | 否          | 否         |
| 除去适配器。         | 是           | 是         | 否          | 否         |
| 打开或关闭对应用程序的应用程序真实性测试。 | 是 | 是 | 否 | 否    |
| 更改 {{ site.data.keys.product_adj }} 应用程序状态的属性：活动、活动通知以及已禁用。 | 是 | 是 | 是 | 否 |

基本上，所有角色都可以发出 GET 请求，**mfpadmin**、**mfpdeployer** 和 **mfpmonitor** 角色也可以发出 POST 和 PUT 请求，且 **mfpadmin** 和 **mfpdeployer** 角色还可以发出 DELETE 请求。

#### 与推送通知相关的请求
{: #requests-related-to-push-notifications }

|                        | 管理员 | 部署者    | 操作员    | 监控者    |
|------------------------|---------------|-------------|-------------|------------|
| Java EE 安全角色。 | mfpadmin      | mfpdeployer | mfpoperator | mfpmonitor |
| GET 请求{::nomarkdown}<ul><li>获取对应用程序使用推送通知的所有设备的列表</li><li>获取特定设备的详细信息</li><li>获取预订列表</li><li>获取与预订标识关联的预订信息</li><li>获取 GCM 配置的详细信息</li><li>获取 APNS 配置的详细信息</li><li>获取为应用程序定义的标记的列表</li><li>获取特定标记的详细信息</li></ul>{:/}| 是           | 是         | 是         | 是        |
| POST 和 PUT 请求{::nomarkdown}<ul><li>向应用程序注册推送通知</li><li>更新推送设备注册</li><li>创建预订</li><li>添加或更新 GCM 配置</li><li>添加或更新 APNS 配置</li><li>将通知提交到设备</li><li>创建或更新标记</li></ul>{:/} | 是           | 是         | 是         | 否         |
| DELETE 请求{::nomarkdown}<ul><li>删除推送通知的设备注册</li><li>删除预订</li><li>通过标记取消预订设备</li><li>删除 GCM 配置</li><li>删除 APNS 配置</li><li>删除标记</li></ul>{:/} | 是           | 是         | 否          | 否         |

#### 禁用
{: #disabling }

|                        | 管理员 | 部署者    | 操作员    | 监控者    |
|------------------------|---------------|-------------|-------------|------------|
| Java EE 安全角色。 | mfpadmin      | mfpdeployer | mfpoperator | mfpmonitor |
| 禁用特定设备，将其状态标记为丢失或被盗，从而阻止该设备上任何应用程序发出的访问请求。       | 是           | 是         | 是          | 否        |
| 禁用特定应用程序，将其状态标记为已禁用，从而阻止该设备上这个特定应用程序发出的访问请求。              | 是           | 是         | 是         | 否         |

如果选择使用通过用户资源库的认证方法（如 LDAP），那么您可配置 {{ site.data.keys.mf_server }} 管理，以便能够通过用户资源库使用用户和组来定义 {{ site.data.keys.mf_server }} 管理的访问控制表 (ACL)。
该过程取决于您所使用的 Web 应用程序服务器的类型和版本。

### 为 {{ site.data.keys.mf_server }} 管理配置 WebSphere Application Server Full Profile
{: #configuring-websphere-application-server-full-profile-for-mobilefirst-server-administration }
通过将 {{ site.data.keys.mf_server }} 管理 Java EE 角色映射到 Web 应用程序的一组用户，配置安全性。

可在 WebSphere Application Server 控制台中定义用户配置的基础。通常，通过以下地址访问控制台：`https://localhost:9043/ibm/console/`

1. 选择**安全性 → 全局安全性**。
2. 选择**安全性配置向导**来配置用户。
可以通过选择**用户和组 → 管理用户**来管理个别用户帐户。
3. 将角色 **mfpadmin**、**mfpdeployer**、**mfpmonitor** 和 **mfpoperator** 映射到一组用户。
    * 选择**服务器 → 服务器类型 → WebSphere Application Server**。
    * 选择服务器。
    * 在**配置**选项卡中，选择**应用程序 → 企业应用程序**。
    * 选择 **MobileFirst_Administration_Service**。
    * 在**配置**选项卡中，选择**详细信息 → 安全**角色到用户/组的映射。
    * 进行必要的定制。
    * 单击**确定**。
    * 重复这些步骤，以映射控制台 Web 应用程序的角色。这次选择 **MobileFirst_Administration_Console**。
    * 单击**保存**以保存更改。

### 为 {{ site.data.keys.mf_server }} 管理配置 WebSphere Application Server Liberty Profile
{: #configuring-websphere-application-server-liberty-profile-for-mobilefirst-server-administration }
在 WebSphere  Application Server Liberty Profile 中，可以在服务器的 **server.xml** 配置文件中配置 **mfpadmin**、**mfpdeployer**、**mfpmonitor** 和 **mfpoperator** 角色。

要配置安全角色，您必须编辑 **server.xml** 文件。
在每个 `<application>` 元素的 `<application-bnd>` 元素中，创建 `<security-role>` 元素。每个 `<security-role>` 元素对应每个角色：**mfpadmin**、mfpdeployer、mfpmonitor 和 mfpoperator。将角色映射到相应的用户组名，在此示例中为：**mfpadmingroup**、**mfpdeployergroup**、**mfpmonitorgroup** 或 **mfpoperatorgroup**。通过 `<basicRegistry>` 元素定义这些组。
您可以定制该元素或将其完全替换为 `<ldapRegistry>` 元素或 `<safRegistry>` 元素。

稍后，通过大量已安装的应用程序，维护良好的响应时间，例如，在有 80 个应用程序的情况下，您应该配置管理数据库的连接池。

1. 编辑 **server.xml** 文件。
例如：

   ```xml
   <security-role name="mfpadmin">
      <group name="mfpadmingroup"/>
   </security-role>
   <security-role name="mfpdeployer">
      <group name="mfpdeployergroup"/>
   </security-role>
   <security-role name="mfpmonitor">
      <group name="mfpmonitorgroup"/>
   </security-role>
   <security-role name="mfpoperator">
      <group name="mfpoperatorgroup"/>
   </security-role>

   <basicRegistry id="mfpadmin">
      <user name="admin" password="admin"/>
      <user name="guest" password="guest"/>
      <user name="demo" password="demo"/>
      <group name="mfpadmingroup">
        <member name="guest"/>
        <member name="demo"/>
      </group>
      <group name="mfpdeployergroup">
        <member name="admin" id="admin"/>
      </group>
      <group name="mfpmonitorgroup"/>
      <group name="mfpoperatorgroup"/>
   </basicRegistry>
   ```

2. 定义 **AppCenterPool** 大小：

   ```xml
   <connectionManager id="AppCenterPool" minPoolSize="10" maxPoolSize="40"/>
   ```

3. 在元素 `<dataSource>` 中，为连接管理器定义一个引用：


   ```xml
   <dataSource id="MFPADMIN" jndiName="mfpadmin/jdbc/mfpAdminDS" connectionManagerRef="AppCenterPool">
   ...
   </dataSource>
   ```

### 为 {{ site.data.keys.mf_server }} 管理配置 Apache Tomcat
{: #configuring-apache-tomcat-for-mobilefirst-server-administration }
您必须在 Apache Tomcat Web 应用程序服务器上为 {{ site.data.keys.mf_server }} 管理配置 Java EE 安全角色。

1. 如果您手动安装了 {{ site.data.keys.mf_server }} 管理，请在 **conf/tomcat-users.xml** 文件中声明以下角色：

   ```xml
   <role rolename="mfpadmin"/>
   <role rolename="mfpmonitor"/>
   <role rolename="mfpdeployer"/>
   <role rolename="mfpoperator"/>
   ```

2. 将角色添加到所选用户，例如：

   ```xml
   <user name="admin" password="admin" roles="mfpadmin"/>
   ```

3. 您可以按 Apache Tomcat 文档中的描述定义用户集，[Realm Configuration HOW-TO](http://tomcat.apache.org/tomcat-7.0-doc/realm-howto.html)。

## {{ site.data.keys.mf_server }} Web 应用程序的 JNDI 属性列表
{: #list-of-jndi-properties-of-the-mobilefirst-server-web-applications }
配置部署到应用程序服务器的 {{ site.data.keys.mf_server }} Web 应用程序的 JNDI 属性。

* [为 {{ site.data.keys.mf_server }} Web 应用程序设置 JNDI 属性](#setting-up-jndi-properties-for-mobilefirst-server-web-applications)
* [{{ site.data.keys.mf_server }} 管理服务的 JNDI 属性列表](#list-of-jndi-properties-for-mobilefirst-server-administration-service)
* [{{ site.data.keys.mf_server }} 实时更新服务的 JNDI 属性列表](#list-of-jndi-properties-for-mobilefirst-server-live-update-service)
* [{{ site.data.keys.product_adj }} 运行时的 JNDI 属性列表](#list-of-jndi-properties-for-mobilefirst-runtime)
* [{{ site.data.keys.mf_server }}推送服务的 JNDI 属性列表](#list-of-jndi-properties-for-mobilefirst-server-push-service)

### 为
{{ site.data.keys.mf_server }} Web 应用程序设置 JNDI 属性
{: #setting-up-jndi-properties-for-mobilefirst-server-web-applications }
设置 JNDI 属性以配置部署到应用程序服务器的
{{ site.data.keys.mf_server }} Web 应用程序。  
通过以下某种方式设置 JNDI 环境条目：

* 配置服务器环境条目。用于配置服务器环境条目的步骤取决于所使用的应用程序服务器：

    * **WebSphere Application Server：**
        1. 在 WebSphere Application Server 管理控制台中，转至**应用程序 → 应用程序类型 → WebSphere Enterprise Applications → application_name → Web 模块的环境条目**。
        2. 在“值”字段中，输入适用于您的服务器环境的值。

        ![WebSphere 中的 JNDI 环境条目](jndi_was.jpg)
    * WebSphere Application Server Liberty：

      在 **liberty\_install\_dir/usr/servers/serverName** 中，编辑 **server.xml** 文件，并如下声明 JNDI 属性：

      ```xml
      <application id="app_context_root" name="app_context_root" location="app_war_name.war" type="war">
            ...
      </application>
      <jndiEntry jndiName="app_context_root/JNDI_property_name" value="JNDI_property_value" />
      ```

      上下文根（在上个示例中为 **app\_context\_root**）将连接 JNDI 条目与特定的 {{ site.data.keys.product_adj }} 应用程序。如果同一服务器上存在多个 {{ site.data.keys.product_adj }} 应用程序，那么可以通过使用上下文路径前缀为每个应用程序定义特定 JNDI 条目。

      > **注：**WebSphere Application Server Liberty 上全局定义了一些属性，属性名称无上下文根前缀。要获取这些属性的列表，请参阅[全局 JNDI 条目](../appserver/#global-jndi-entries)。
      对于所有其他 JNDI 属性，必须使用应用程序的上下文根作为名称的前缀：

       * 对于实时更新服务，上下文根必须是 **/[adminContextRoot]config**。例如，如果管理服务的上下文根为 **/mfpadmin**，那么实时更新服务的上下文根必须为 **/mfpadminconfig**。
       * 对于推送服务，您必须将上下文根定义为 **/imfpush**。
否则，由于在 SDK 中对上下文根进行硬编码，因此客户机设备无法连接到此上下文根。
       * 对于 {{ site.data.keys.product_adj }} Administration
Service 应用程序、
{{ site.data.keys.mf_console }}
和 {{ site.data.keys.product_adj }} 运行时，可以根据需要定义上下文根。但缺省情况下，{{ site.data.keys.product_adj }} Administration
Service 的上下文根为 **/mfpadmin**，
{{ site.data.keys.mf_console }}
的上下文根为 **/mfpconsole**，{{ site.data.keys.product_adj }} 运行时的上下文根为 **/mfp**。

      例如：

      ```xml
      <application id="mfpadmin" name="mfpadmin" location="mfp-admin-service.war" type="war">
            ...
      </application>
      <jndiEntry jndiName="mfpadmin/mfp.admin.actions.prepareTimeout" value = "2400000" />
      ```    

    * Apache Tomcat：

      在 **tomcat\_install\_dir/conf** 中，编辑 **server.xml** 文件，并如下声明 JNDI 属性：

      ```xml
      <Context docBase="app_context_root" path="/app_context_root">
            <Environment name="JNDI_property_name" override="false" type="java.lang.String" value="JNDI_property_value"/>
      </Context>
      ```

        * 由于在应用程序的 `<Context>` 元素内定义 JNDI 条目，因此无需上下文路径前缀。
        * 必需 `override="false"`。
        * `type` 属性始终为 `java.lang.String`，除非对该属性另有指定。

      例如：

      ```xml
      <Context docBase="app_context_root" path="/app_context_root">
            <Environment name="mfp.admin.actions.prepareTimeout" override="false" type="java.lang.String" value="2400000"/>
      </Context>
      ```

* 如果通过 Ant 任务进行安装，那么还可以在安装时设置 JNDI 属性的值。

  在 **mfp_install_dir/MobileFirstServer/configuration-samples** 中，编辑 Ant 任务的配置 XML 文件，并使用以下标记内的 property 元素来声明 JNDI 属性的值：

  * `<installmobilefirstadmin>`，针对
{{ site.data.keys.mf_server }}
管理、{{ site.data.keys.mf_console }} 和实时更新服务。有关更多信息，请参阅[用于安装 {{ site.data.keys.mf_console }}、{{ site.data.keys.mf_server }} 工件、{{ site.data.keys.mf_server }} 管理和实时更新服务的 Ant 任务](../installation-reference/#ant-tasks-for-installation-of-mobilefirst-operations-console-mobilefirst-server-artifacts-mobilefirst-server-administration-and-live-update-services)。
  * `<installmobilefirstruntime>`，针对
{{ site.data.keys.product_adj }} 运行时配置属性。有关更多信息，请参阅[用于安装 {{ site.data.keys.product_adj }} 运行时环境的 Ant 任务](../installation-reference/#ant-tasks-for-installation-of-mobilefirst-runtime-environments)。
  * `<installmobilefirstpush>`，针对推送服务的配置。有关更多信息，请参阅[用于安装 {{ site.data.keys.mf_server }} 推送服务的 Ant 任务](../installation-reference/#ant-tasks-for-installation-of-mobilefirst-server-push-service)。

  例如：

  ```xml
  <installmobilefirstadmin ..>
        <property name = "mfp.admin.actions.prepareTimeout" value = "2400000" />
  </installmobilefirstadmin>
  ```

### {{ site.data.keys.mf_server }}
管理服务的 JNDI 属性列表
{: #list-of-jndi-properties-for-mobilefirst-server-administration-service }
当为应用程序服务器配置 {{ site.data.keys.mf_server }} 管理服务和 {{ site.data.keys.mf_console }} 时，需要设置可选或必需的 JNDI 属性（尤其是针对 Java 管理扩展 (JMX)）。

可以在管理服务 Web 应用程序 mfp-admin-service.war 上设置以下属性。

#### 管理服务的 JNDI 属性：JMX
{: #jndi-properties-for-administration-service-jmx }

| 属性                 | 可选或必需 | 描述 | 局限性 |
|--------------------------|-----------------------|-------------|--------------|
| mfp.admin.jmx.connector  | 可选	           | Java 管理扩展 (JMX) 接口类型。<br/>可能值为 `SOAP` 和 `RMI`。缺省值为 SOAP。 | 仅限 WebSphere Application Server。 |
| mfp.admin.jmx.host       | 可选	           | 用于 JMX REST 连接的主机名。 | 仅限于 Liberty Profile。 |
| mfp.admin.jmx.port	   | 可选	           | 用于 JMX REST 连接的端口。 | 仅限于 Liberty Profile。 |
| mfp.admin.jmx.user       | 对于 Liberty Profile 和 WebSphere Application Server 场为必需，对于其他项为可选 | 用于 JMX REST 连接的用户名。 | WebSphere Application Server Liberty Profile：JMX REST 连接的用户名。<br/><br/>WebSphere Application Server 场：SOAP 连接的用户名。<br/><br/>WebSphere Application Server Network Deployment：如果映射到 {{ site.data.keys.mf_server }} 管理应用程序的虚拟主机不是缺省主机，那么为 WebSphere 管理员的用户名。<br/><br/>Liberty 集合体：在 Liberty 控制器的 server.xml 文件的 `<administrator-role>` 元素中定义的控制器管理员的用户名。 |
| mfp.admin.jmx.pwd	| 对于 Liberty Profile 和 WebSphere Application Server 场为必需，对于其他项为可选 | 用于 JMX REST 连接的用户密码。 | WebSphere Application Server Liberty Profile：JMX REST 连接的用户密码。<br/><br/>>WebSphere Application Server 场：SOAP 连接的用户密码。<br/><br/>WebSphere Application Server Network Deployment：如果映射到 {{ site.data.keys.mf_server }} 服务器管理应用程序的虚拟主机不是缺省主机，那么为 WebSphere 管理员的用户密码。<br/><br/>Liberty 集合体：Liberty 控制器的 server.xml 文件的 `<administrator-role>` 元素中定义的控制器管理员的密码。 |
| mfp.admin.rmi.registryPort | 可选 | 通过防火墙的 JMX 连接的 RMI 注册表端口。 | 仅限 Tomcat。 |
| mfp.admin.rmi.serverPort | 可选 | 通过防火墙的 JMX 连接的 RMI 服务器端口。 | 仅限 Tomcat。 |
| mfp.admin.jmx.dmgr.host | 必需 | Deployment Manager 主机名。 | 仅限 WebSphere Application Server Network Deployment。 |
| mfp.admin.jmx.dmgr.port | 必需 | Deployment Manager RMI 或 SOAP 端口。 | 仅限 WebSphere Application Server Network Deployment。 |

#### 管理服务的 JNDI 属性：超时
{: #jndi-properties-for-administration-service-timeout }

| 属性                 | 可选或必需 | 描述  |
|--------------------------|-----------------------|--------------|
| mfp.admin.actions.prepareTimeout | 可选 | 在部署事务期间将数据从管理服务传输到运行时的超时时间，以毫秒为单位。如果无法在该时间内到达运行时，将出现错误且部署事务结束。<br/><br/>缺省值：1800000 毫秒（30 分钟） |
| mfp.admin.actions.commitRejectTimeout | 可选 | 与运行时通信以提交或拒绝部署事务时的超时时间，以毫秒为单位。如果无法在该时间内到达运行时，将出现错误且部署事务结束。<br/><br/>缺省值：120000 毫秒（2 分钟） |
| mfp.admin.lockTimeoutInMillis | 可选 |获取事务锁定的超时时间，以毫秒为单位。由于部署事务是顺序运行的，因此使用锁定。事务必须等待上一个事务完成。此超时是事务等待的最大时间。<br/><br/>缺省值：1200000 毫秒（20 分钟） |
| mfp.admin.maxLockTimeInMillis | 可选 | 某流程可在事务锁定上花费的最大时间。由于部署事务是顺序运行的，因此使用锁定。发生应用程序服务器在执行锁定时失败的这种情况的前提十分罕见：即重新启动下一个应用程序服务器时未释放锁定。在此情况下，将在最大锁定时间后自动释放锁定，以确保服务器不会永久阻塞。设置长于正常事务的时间。<br/><br/>缺省值：1800000 毫秒（30 分钟） |

#### 管理服务的 JNDI 属性：日志记录
{: #jndi-properties-for-administration-service-logging }

| 属性                 | 可选或必需 | 描述  |
|--------------------------|-----------------------|--------------|
| mfp.admin.logging.formatjson | 可选 | 将此属性设置为 true，以支持对响应和日志消息中的 JSON 对象进行正确格式化（多余的空格）。调试服务器时设置该属性十分有用。缺省值：false。 |
| mfp.admin.logging.tosystemerror | 可选 | 指定是否所有的日志记录消息都指向 System.Error。调试服务器时设置该属性十分有用。 |

#### 管理服务的 JNDI 属性：代理
{: #jndi-properties-for-administration-service-proxies }

| 属性                 | 可选或必需 | 描述  |
|--------------------------|-----------------------|--------------|
| mfp.admin.proxy.port | 可选 | 如果 {{ site.data.keys.product_adj }} 管理服务器在防火墙或逆向代理的后面，那么该属性将指定主机的地址。设置该属性以使防火墙外部的用户能够访问 {{ site.data.keys.product_adj }} 管理服务器。通常此属性是代理的端口，例如 443。仅当外部和内部 URI 的协议不同时才需要此属性。 |
| mfp.admin.proxy.protocol | 可选 | 如果将 {{ site.data.keys.product_adj }}
管理服务器置于防火墙或逆向代理后面，那么该属性指定协议（HTTP 或 HTTPS）。设置该属性以使防火墙外部的用户能够访问 {{ site.data.keys.product_adj }} 管理服务器。通常该属性设置为代理的协议。例如，wl.net。仅当外部和内部 URI 的协议不同时才需要此属性。 |
| mfp.admin.proxy.scheme | 可选 | 此属性只是 mfp.admin.proxy.protocol 的替代名称。 |
| mfp.admin.proxy.host | 可选 | 如果 {{ site.data.keys.product_adj }} 管理服务器在防火墙或逆向代理的后面，那么该属性将指定主机的地址。设置该属性以使防火墙外部的用户能够访问 {{ site.data.keys.product_adj }} 管理服务器。通常该属性是代理的地址。 |

#### 管理服务的 JNDI 属性：拓扑
{: #jndi-properties-for-administration-service-topologies }

| 属性                 | 可选或必需 | 描述  |
|--------------------------|-----------------------|--------------|
| mfp.admin.audit | 可选。 | 将此属性设置为 false 可禁用 {{ site.data.keys.mf_console }} 的审计功能。缺省值为 true。 |
| mfp.admin.environmentid | 可选。 | MBean 注册的环境标识。在同一应用程序服务器上安装 {{ site.data.keys.mf_server }} 的不同实例时使用该标识。该标识确定哪个管理服务、哪个控制台以及哪个运行时属于同一安装。管理服务仅管理具有同一环境标识的运行时。 |
| mfp.admin.serverid | 对于服务器场和 Liberty 集合体为必需，对于其他项为可选。 | 服务器场：服务器标识。场中的每个服务器的标识必须不同。
<br/><br/> Liberty 集合体：该值必须为 controller。
 |
| mfp.admin.hsts | 可选。 | 设置为 true 以根据 RFC 6797 启用 HTTP Strict Transport Security。 |
| mfp.topology.platform | 可选 | 服务器类型。有效值：{::nomarkdown}<ul><li>Liberty</li><li>WAS</li><li>Tomcat</li></ul>{:/}如果未设置该值，应用程序会尝试猜测服务器类型。 |
| mfp.topology.clustermode | 可选 | 除服务器类型外，还在此处指定服务器拓扑。有效值：{::nomarkdown}<ul><li>独立</li><li>集群</li><li>场</li></ul>{:/}缺省值为“独立” |
| mfp.admin.farm.heartbeat | 可选 | 此属性可用于设置服务器场拓扑中所用脉动信号速率持续的时间（以分钟为单位）。缺省值为 2 分钟。<br/><br/>在服务器场中，所有成员都必须使用相同的脉动信号速率。如果在服务器场中的某个服务器上设置或更改了此 JNDI 值，那么还必须在该服务器场中的所有其他服务器上设置相同的值。有关更多信息，请参阅[服务器场节点的生命周期](../appserver/#lifecycle-of-a-server-farm-node)。 |
| mfp.admin.farm.missed.heartbeats.timeout | 可选 | 此属性可用于设置在服务器场成员的状态被视为发生故障或关闭之前，该成员缺少的脉动信号数。缺省值为 2。<br/><br/>在服务器场中，所有成员都必须使用相同的缺失脉动信号数。
如果在服务器场中的某个服务器上设置或更改了此 JNDI 值，那么还必须在该服务器场中的所有其他服务器上设置相同的值。有关更多信息，请参阅[服务器场节点的生命周期](../appserver/#lifecycle-of-a-server-farm-node)。 |
| mfp.admin.farm.reinitialize | 可选 | 布尔值（true 或 false），用于重新注册或重新初始化场成员。 |
| mfp.swagger.ui.url | 可选 | 此属性定义要显示在管理控制台中的 Swagger 用户界面的 URL。 |

#### 管理服务的 JNDI 属性：关系数据库
{: #jndi-properties-for-administration-service-relational-database }

| 属性                 | 可选或必需 | 描述  |
|--------------------------|-----------------------|--------------|
| mfp.admin.db.jndi.name | 可选 | 数据库的 JNDI 名称。该参数是指定数据库的正常机制。缺省值为 **java:comp/env/jdbc/mfpAdminDS**。 |
| mfp.admin.db.openjpa.ConnectionDriverName | 可选/有条件的必需项 | 数据库连接驱动程序类的标准名称。仅当 **mfp.admin.db.jndi.name ** 属性指定的数据源未在应用程序服务器配置中定义时，才是必需的。 |
| mfp.admin.db.openjpa.ConnectionURL | 可选/有条件的必需项 | 数据库连接的 URL。仅当 **mfp.admin.db.jndi.name ** 属性指定的数据源未在应用程序服务器配置中定义时，才是必需的。 |
| mfp.admin.db.openjpa.ConnectionUserName | 可选/有条件的必需项 | 数据库连接的用户名。
仅当 **mfp.admin.db.jndi.name ** 属性指定的数据源未在应用程序服务器配置中定义时，才是必需的。 |
| mfp.admin.db.openjpa.ConnectionPassword | 可选/有条件的必需项 | 用于数据库连接的密码。仅当 **mfp.admin.db.jndi.name ** 属性指定的数据源未在应用程序服务器配置中定义时，才是必需的。 |
| mfp.admin.db.openjpa.Log | 可选 | 此属性传递到 OpenJPA，并启用 JPA 日志记录。有关更多信息，请参阅 [Apache OpenJPA User's Guide](http://openjpa.apache.org/docs/openjpa-0.9.0-incubating/manual/manual.html)。 |
| mfp.admin.db.type | 可选 | 此属性定义数据库类型。
缺省值是从连接 URL 推断得出。 |

#### 管理服务的 JNDI 属性：许可
{: #jndi-properties-for-administration-service-licensing }

| 属性                 | 可选或必需 | 描述  |
|--------------------------|-----------------------|--------------|
| mfp.admin.license.key.server.host	| {::nomarkdown}<ul><li>对于永久许可证为可选</li><li>对于令牌许可证为必需</li></ul>{:/} | Rational License Key Server 的主机名。 |
| mfp.admin.license.key.server.port	| {::nomarkdown}<ul><li>对于永久许可证为可选</li><li>对于令牌许可证为必需</li></ul>{:/} | Rational License Key Server 的端口号。 |

#### 管理服务的 JNDI 属性：JNDI 配置
{: #jndi-properties-for-administration-service-jndi-configurations }

| 属性                 | 可选或必需 | 描述  |
|--------------------------|-----------------------|--------------|
| mfp.jndi.configuration | 可选 | 如果必须从插入 WAR 文件内的属性文件中读取 JNDI 属性（此属性除外），那么这是指 JNDI 配置的名称。如果未设置此属性，那么将不会从属性文件中读取 JNDI 属性。 |
| mfp.jndi.file | 可选 | 如果必须从安装在 Web 服务器内的文件中读取 JNDI 属性（此属性除外），那么这是指包含 JNDI 配置的文件的名称。如果未设置此属性，那么将不会从属性文件中读取 JNDI 属性。 |

管理服务使用实时更新服务作为辅助工具来存储各种配置。使用下列属性来配置访问实时更新服务的方式。

#### 管理服务的 JNDI 属性：实时更新服务
{: #jndi-properties-for-administration-service-live-update-service }

| 属性                 | 可选或必需 | 描述  |
|--------------------------|-----------------------|--------------|
| mfp.config.service.url | （可选）实时更新服务的 URL。通过将 config 添加到管理服务的上下文根，从管理服务的 URL 派生缺省 URL。 |
| mfp.config.service.user | 必需 | 用于访问实时更新服务的用户名。
在服务器场拓扑中，对于场的所有成员，该用户名必须相同。 |
| mfp.config.service.password | 必需 | 用于访问实时更新服务的密码。
在服务器场拓扑中，对于场的所有成员，该密码必须相同。 |
| mfp.config.service.schema | 可选 | 实时更新服务所使用的模式的名称。 |

管理服务使用推送服务作为辅助工具来存储各种推送设置。使用下列属性来配置访问推送服务的方式。由于推送服务受 OAuth 安全模型保护，因此必须设置各种属性以在 OAuth 中启用保密客户机。

#### 管理服务的 JNDI 属性：推送服务
{: #jndi-properties-for-administration-service-push-service }

| 属性                 | 可选或必需 | 描述  |
|--------------------------|-----------------------|--------------|
| mfp.admin.push.url | 可选 | 推送服务的 URL。如果未指定该属性，那么会视为已禁用推送服务。如果未正确设置该属性，那么管理服务将无法联系推送服务，并且无法在 {{ site.data.keys.mf_console }} 中管理推送服务。 |
| mfp.admin.authorization.server.url | 可选 | 推送服务所使用的 OAuth 授权服务器的 URL。通过将上下文根更改为第一个已安装运行时的上下文根，从管理服务的 URL 派生缺省 URL。如果安装多个运行时，那么最好设置该属性。如果未正确设置该属性，那么管理服务将无法联系推送服务，并且无法在 {{ site.data.keys.mf_console }} 中管理推送服务。 |
| mfp.push.authorization.client.id | 可选/有条件的必需项 | 处理推送服务的 OAuth 授权的保密客户机的标识。仅当指定 **mfp.admin.push.url** 属性时才必需。 |
| mfp.push.authorization.client.secret | 可选/有条件的必需项 | 处理推送服务的 OAuth 授权的保密客户机的密钥。
仅当指定 **mfp.admin.push.url** 属性时才必需。 |
| mfp.admin.authorization.client.id | 可选/有条件的必需项 | 处理管理服务的 OAuth 授权的保密客户机的标识。仅当指定 **mfp.admin.push.url** 属性时才必需。 |
| mfp.push.authorization.client.secret | 可选/有条件的必需项 | 处理管理服务的 OAuth 授权的保密客户机的密钥。仅当指定 **mfp.admin.push.url** 属性时才必需。 |

### {{ site.data.keys.mf_console }} 的 JNDI 属性
{: #jndi-properties-for-mobilefirst-operations-console }
在 {{ site.data.keys.mf_console }} 的 Web 应用程序 (mfp-admin-ui.war) 上可以设置以下属性。

| 属性                 | 可选或必需 | 描述  |
|--------------------------|-----------------------|--------------|
| mfp.admin.endpoint | 可选 | 使 {{ site.data.keys.mf_console }} 能够查找 {{ site.data.keys.mf_server }}
管理 REST 服务。指定 **mfp-admin-service.war** Web 应用程序的外部地址和上下文根。在有防火墙或安全逆向代理的情况下，该 URI 必须为外部 URI 且不能为本地 LAN 中的内部 URI。例如，https://wl.net:443/mfpadmin。 |
| mfp.admin.global.logout | 可选 | 在控制台注销期间清除 WebSphere 用户认证高速缓存。此属性仅适用于 WebSphere Application Server V7。缺省值为 false。 |
| mfp.admin.hsts | 可选 | 将此属性设置为 true 以根据 RFC 6797 启用 HTTP [Strict Transport Security](http://www.w3.org/Security/wiki/Strict_Transport_Security)。有关更多信息，请参阅 W3C
Strict Transport Security 页面。缺省值为 false。 |
| mfp.admin.ui.cors | 可选 | 缺省值为 true。有关更多信息，请参阅 [W3C Cross-Origin Resource Sharing 页面](http://www.w3.org/TR/cors/)。 |
| mfp.admin.ui.cors.strictssl | 可选 | 设置为 false，以在使用 SSL（HTTPS 协议）保护 {{ site.data.keys.mf_console }} 但未保护 {{ site.data.keys.mf_server }} 管理服务的情况（或相反情况）下允许 CORS 情况。该属性仅在 **mfp.admin.ui.cors** 属性已启用时生效。 |

### {{ site.data.keys.mf_server }} 实时更新服务的 JNDI 属性列表
{: #list-of-jndi-properties-for-mobilefirst-server-live-update-service }
在为应用程序服务器配置 {{ site.data.keys.mf_server }} 实时更新服务时，您可以设置以下 JNDI 属性。该表列出 IBM 关系数据库实时更新服务的 JNDI 属性。

| 属性 | 可选或必需 | 描述 |
|----------|-----------------------|-------------|
| mfp.db.relational.queryTimeout | 可选 | 在 RDBMS 中执行查询时允许的超时（秒）。零值表示无限超时。负值表示缺省值（不覆盖）。<br/><br/>如果未配置任何值，那么将使用缺省值。有关更多信息，请参阅 [setQueryTimeout](http://docs.oracle.com/javase/7/docs/api/java/sql/Statement.html#setQueryTimeout(int))。
 |

要了解如何设置这些属性，请参阅[设置 {{ site.data.keys.mf_server }} Web 应用程序的 JNDI 属性](#setting-up-jndi-properties-for-mobilefirst-server-web-applications)。

### {{ site.data.keys.product_adj }} 运行时的 JNDI 属性列表
{: #list-of-jndi-properties-for-mobilefirst-runtime }
如果为应用程序服务器配置 {{ site.data.keys.mf_server }} 运行时，那么需设置可选或必需的 JNDI 属性。  
下表列出了始终作为 JNDI 条目可用的 {{ site.data.keys.product_adj }} 属性：

| 属性 | 描述 |
|----------|-------------|
| mfp.admin.jmx.dmgr.host | 必需。Deployment Manager 的主机名。仅限 WebSphere Application Server Network Deployment。 |
| mfp.admin.jmx.dmgr.port | 必需。Deployment Manager 的 RMI 或 SOAP 端口。仅限 WebSphere Application Server Network Deployment。 |
| mfp.admin.jmx.host | 仅限 Liberty。用于 JMX REST 连接的主机名。对于 Liberty 集合体，请使用控制器的主机名。 |
| mfp.admin.jmx.port | 仅限 Liberty。用于 JMX REST 连接的端口号。对于 Liberty 集合体，REST 接口的端口必须与 `<httpEndpoint>` 元素中声明的 httpsPort 属性值相同。在 Liberty 控制器的 server.xml 文件中声明该元素。 |
| mfp.admin.jmx.user | 可选。WebSphere Application Server 场：SOAP 连接的用户名。<br/><br/>Liberty 集合体：在 Liberty 控制器的 server.xml 文件的 `<administrator-role>` 元素中定义的控制器管理员的用户名。 |
| mfp.admin.jmx.pwd | 可选。WebSphere Application Server 场：SOAP 连接的用户密码。<br/><br/>Liberty 集合体：Liberty 控制器的 server.xml 文件的 `<administrator-role>` 元素中定义的控制器管理员的密码。 |
| mfp.admin.serverid | 对于服务器场和 Liberty 集合体为必需，对于其他项为可选。<br/><br/>服务器场：服务器标识。场中的每个服务器的标识必须不同。
<br/><br/>Liberty 集合体：成员标识。
对于集合体中的各个成员，该标识必须不同。不能使用值 controller，因为该值专为集合体控制器保留。 |
| mfp.topology.platform | 可选。服务器类型。有效值为：<ul><li>Liberty</li><li>WAS</li><li>Tomcat</li></ul>如果未设置该值，应用程序会尝试猜测服务器类型。 |
| mfp.topology.clustermode | 可选。除服务器类型外，还在此处指定服务器拓扑。有效值：<ul><li>独立<li>集群</li><li>场</li></ul>缺省值为“独立” |
| mfp.admin.jmx.replica | 可选。仅用于 Liberty 集合体。<br/><br/>仅当用于管理此运行时的管理组件已部署在不同的 Liberty 控制器（副本）中时，才设置该属性。<br/><br/>使用以下语法指定不同控制器副本的端点列表：`replica-1 hostname:replica-1 port, replica-2 hostname:replica-2 port,..., replica-n
hostname:replica-n port` |
| mfp.analytics.console.url | 可选。由 IBM {{ site.data.keys.mf_analytics }} 公开的可链接到分析控制台的 URL。如果要通过 {{ site.data.keys.mf_console }} 访问分析控制台，请设置该属性。
例如，`http://<hostname>:<port>/analytics/console` |
| mfp.analytics.password | 通过基本认证保护 IBM {{ site.data.keys.mf_analytics }} 的数据入口点时所使用的密码。 |
| mfp.analytics.url | 由收到入局分析数据的 IBM {{ site.data.keys.mf_analytics }} 公开的 URL。例如，`http://<hostname>:<port>/analytics-service/rest` |
| mfp.analytics.username | 通过基本认证保护 IBM {{ site.data.keys.mf_analytics }} 的数据入口点时所使用的用户名。|
| mfp.device.decommissionProcessingInterval | 定义执行停用任务的频率（秒）。缺省值：86400，即一天。 |
| mfp.device.decommission.when | 设备停用任务将客户机设备停用之前所需经过的不活动天数。
缺省值：90 天。 |
| mfp.device.archiveDecommissioned.when | 归档停用的客户机设备前需经过的不活动天数。<br/><br/>此任务将停用的客户机设备写入归档文件。
归档客户机设备会写入 {{ site.data.keys.mf_server }} **home\devices_archive** 目录中的文件。
该文件名包含创建归档文件的时间戳记。缺省值：90 天。 |
| mfp.licenseTracking.enabled | 用于在 {{ site.data.keys.product }} 中启用或禁用设备跟踪的值。<br/><br/>出于性能原因，当 {{ site.data.keys.product }} 仅运行商家到消费者 (B2C) 应用程序时，您可以禁用设备跟踪。
 禁用设备跟踪后，还会禁用许可证报告，并且不会生成任何许可证度量值。<br/><br/>可能值为 true（缺省值）和 false。
 |
| mfp.runtime.temp.folder | 定义运行时临时文件的文件夹。如果未设置，将使用 Web 容器的缺省临时文件夹位置。 |
| mfp.adapter.invocation.url | 要用于从内部 Java 适配器或 JavaScript 适配器（使用其余端点调用这些适配器）调用适配器过程的 URL。如果未设置此属性，将使用当前正在执行请求的 URL（这是缺省行为）。此值应包含完整 URL，包括上下文根。 |
| mfp.authorization.server | 授权服务器方式。可以是以下某种方式：{::nomarkdown}<ul><li>embedded：使用 {{ site.data.keys.product_adj }} 授权服务器。</li><li>external：使用外部授权服务器</li></ul>{:/}. 在设置此值时，还必须为外部服务器设置 **mfp.external.authorization.server.secret** 和 **mfp.external.authorization.server.introspection.url** 属性。 |
| mfp.external.authorization.server.secret | 外部授权服务器的密钥。在使用外部授权服务器（即，将 **mfp.authorization.server** 设置为 external）时需要此属性，否则将忽略此属性。 |
| mfp.external.authorization.server.introspection.url | 外部授权服务器的自省端点的 URL。在使用外部授权服务器（即，将 **mfp.authorization.server** 设置为 **external**）时必需此属性，否则将忽略此属性。 |
| ssl.websphere.config | 用于为 HTTP 适配器配置密钥库。在设置为 false（缺省值）时，指示 {{ site.data.keys.product_adj }} 运行时使用 {{ site.data.keys.product_adj }} 密钥库。在设置为 true 时，指示 {{ site.data.keys.product_adj }} 运行时使用 WebSphere SSL 配置。有关更多信息，请参阅 [WebSphere Application Server SSL 配置和 HTTP 适配器](#websphere-application-server-ssl-configuration-and-http-adapters)。 |

### {{ site.data.keys.mf_server }} 推送服务的 JNDI 属性列表
{: #list-of-jndi-properties-for-mobilefirst-server-push-service }

| 属性 | 可选或必需 | 描述 |
|----------|-----------------------|-------------|
| mfp.push.db.type | 可选 | 数据库类型。可能的值：DB、CLOUDANT。缺省值：DB |
| mfp.push.db.queue.connections | 可选 | 线程池中执行数据库操作的线程数。缺省值：3 |
| mfp.push.db.cloudant.url | 可选 | Cloudant 帐户 URL。定义该属性时，Cloudant 数据库将定向到此 URL。 |
| mfp.push.db.cloudant.dbName | 可选 | Cloudant 帐户中数据库的名称。它必须以小写字母开头，并且只能包含小写字母、数字以及 _、$ 和 - 等字符。缺省值：mfp\_push\_db |
| mfp.push.db.cloudant.username | 可选 | Cloudant 帐户的用户名，用于存储数据库。未定义该属性时，将使用关系数据库。 |
| mfp.push.db.cloudant.password | 可选 | Cloudant 帐户的密码，用于存储数据库。设置 mfp.db.cloudant.username 时，必须设置该属性。 |
| mfp.push.db.cloudant.doc.version | 可选 | Cloudant 文档版本。 |
| mfp.push.db.cloudant.socketTimeout | 可选	| 检测 Cloudant 网络连接断开超时，以毫秒为单位。零值表示无限超时。负值表示缺省值（不覆盖）。此为缺省值。请访问 [https://github.com/cloudant/java-cloudant#advanced-configuration](https://github.com/cloudant/java-cloudant#advanced-configuration)。 |
| mfp.push.db.cloudant.connectionTimeout | 可选	| 建立 Cloudant 网络连接超时，以毫秒为单位。零值表示无限超时。负值表示缺省值（不覆盖）。此为缺省值。请访问 [https://github.com/cloudant/java-cloudant#advanced-configuration](https://github.com/cloudant/java-cloudant#advanced-configuration)。 |
| mfp.push.db.cloudant.maxConnections | 可选 | Cloudant 接口的最大连接数。此为缺省值。请访问 [https://github.com/cloudant/java-cloudant#advanced-configuration](https://github.com/cloudant/java-cloudant#advanced-configuration)。 |
| mfp.push.db.cloudant.ssl.authentication | 可选 | 布尔值（true 或 false），指定是否为到 Cloudant 数据库的 HTTPS 连接启用 SSL 证书链验证和主机名验证。缺省值：True |
| mfp.push.db.cloudant.ssl.configuration | 可选	| （仅限 WAS Full Profile）对于到 Cloudant 数据库的 HTTPS 连接：WebSphere Application Server 配置中 SSL 配置的名称，以便在没有为主机和端口指定任何配置时使用。 |
| mfp.push.db.cloudant.proxyHost | 可选	| Cloudant 接口的代理主机。此为缺省值：请访问 [https://github.com/cloudant/java-cloudant#advanced-configuration](https://github.com/cloudant/java-cloudant#advanced-configuration)。 |
| mfp.push.db.cloudant.proxyPort | 可选	| Cloudant 接口的代理端口。此为缺省值：请访问 [https://github.com/cloudant/java-cloudant#advanced-configuration](https://github.com/cloudant/java-cloudant#advanced-configuration)。 |
| mfp.push.services.ext.security | 可选	| 安全扩展插件。 |
| mfp.push.security.endpoint | 可选	| 授权服务器的端点 URL。 |
| mfp.push.security.user | 可选	| 用于访问授权服务器的用户名。 |
| mfp.push.security.password | 可选	| 用于访问授权服务器的密码。 |
| mfp.push.services.ext.analytics | 可选 | 分析扩展插件。 |
| mfp.push.analytics.endpoint | 可选 | 分析服务器的端点 URL。 |
| mfp.push.analytics.user | 可选 | 用于访问分析服务器的用户名。 |
| mfp.push.analytics.password | 可选 | 用于访问分析服务器的密码。 |
| mfp.push.analytics.events.notificationDispatch | 可选	| 将要分派通知时的分析事件。缺省值：true |
| mfp.push.internalQueue.maxLength | 可选 | 分派前保留通知任务的队列的长度。缺省值：200000 |
| mfp.push.gcm.proxy.enabled | 可选	| 显示是否必须通过代理访问 Google GCM。缺省值：false |
| mfp.push.gcm.proxy.protocol | 可选 | 可以是 http 或 https。 |
| mfp.push.gcm.proxy.host | 可选 | GCM 代理主机。负值意味着缺省端口。 |
| mfp.push.gcm.proxy.port | 可选 | GCM 代理端口。缺省值：-1 |
| mfp.push.gcm.proxy.user | 可选 | 代理用户名（如果代理要求认证）。
空的用户名表示没有认证。 |
| mfp.push.gcm.proxy.password | 可选 | 代理密码（如果代理要求认证）。 |
| mfp.push.gcm.connections | 可选 | 推送 GCM 最大连接数。缺省值：10 |
| mfp.push.apns.proxy.enabled | 可选 | 显示是否必须通过代理访问 APN。缺省值：false |
| mfp.push.apns.proxy.type | 可选 | APN 代理类型。 |
| mfp.push.apns.proxy.host | 可选 | APN 代理主机。 |
| mfp.push.apns.proxy.port | 可选 | APN 代理端口。缺省值：-1 |
| mfp.push.apns.proxy.user | 可选 | 代理用户名（如果代理要求认证）。
空的用户名表示没有认证。 |
| mfp.push.apns.proxy.password | 可选 | 代理密码（如果代理要求认证）。 |
| mfp.push.apns.connections | 可选 | 推送 APN 最大连接数。缺省值：3 |
| mfp.push.apns.connectionIdleTimeout | 可选 | APN 空闲连接超时。缺省值：0 |


{% comment %}
<!-- START NON-TRANSLATABLE -->
The following table contains an additional 11 analytics push events that were removed. See RTC defect 112448 
| Property | Optional or mandatory | Description |
|----------|-----------------------|-------------|
| mfp.push.db.type | Optional | Database type. Possible values: DB, CLOUDANT. Default: DB |
| mfp.push.db.queue.connections | Optional | Number of threads in the thread pool that does the database operation. Default: 3 |
| mfp.push.db.cloudant.url | Optional | The Cloudant  account URL. When this property is defined, the Cloudant DB will be directed to this URL. |
| mfp.push.db.cloudant.dbName | Optional | The name of the database in the Cloudant account. It must start with a lowercase letter and consist only of lowercase letters, digits, and the characters _, $, and -. Default: mfp\_push\_db |
| mfp.push.db.cloudant.username | Optional | The user name of the Cloudant account, used to store the database. when this property is not defined, a relational database is used. |
| mfp.push.db.cloudant.password | Optional | The password of the Cloudant account, used to store the database. This property must be set when mfp.db.cloudant.username is set. |
| mfp.push.db.cloudant.doc.version | Optional | The Cloudant document version. |
| mfp.push.db.cloudant.socketTimeout | Optional	| A timeout for detecting the loss of a network connection for Cloudant, in milliseconds. A value of zero means an infinite timeout. A negative value means the default (no override). Default. See [https://github.com/cloudant/java-cloudant#advanced-configuration](https://github.com/cloudant/java-cloudant#advanced-configuration). |
| mfp.push.db.cloudant.connectionTimeout | Optional	| A timeout for establishing a network connection for Cloudant, in milliseconds. A value of zero means an infinite timeout. A negative value means the default (no override). Default. See [https://github.com/cloudant/java-cloudant#advanced-configuration](https://github.com/cloudant/java-cloudant#advanced-configuration). |
| mfp.push.db.cloudant.maxConnections | Optional | The Cloudant connector's max connections. Default. See [https://github.com/cloudant/java-cloudant#advanced-configuration](https://github.com/cloudant/java-cloudant#advanced-configuration). |
| mfp.push.db.cloudant.ssl.authentication | Optional | A Boolean value (true or false) that specifies whether the SSL certificate chain validation and host name verification are enabled for HTTPS connections to the Cloudant database. Default: True |
| mfp.push.db.cloudant.ssl.configuration | Optional	| (WAS Full Profile only) For HTTPS connections to the Cloudant database: The name of an SSL configuration in the WebSphere  Application Server configuration, to use when no configuration is specified for the host and port. |
| mfp.push.db.cloudant.proxyHost | Optional	| Cloudant connector's proxy host. Default: See [https://github.com/cloudant/java-cloudant#advanced-configuration](https://github.com/cloudant/java-cloudant#advanced-configuration). |
| mfp.push.db.cloudant.proxyPort | Optional	| Cloudant connector's proxy port. Default: See [https://github.com/cloudant/java-cloudant#advanced-configuration](https://github.com/cloudant/java-cloudant#advanced-configuration). |
| mfp.push.services.ext.security | Optional	| The security extension plugin. |
| mfp.push.security.endpoint | Optional	| The endpoint URL for the authorization server. |
| mfp.push.security.user | Optional	| The username to access the authorization server. |
| mfp.push.security.password | Optional	| The password to access the authorization server. |
| mfp.push.services.ext.analytics | Optional | The analytics extension plugin. |
| mfp.push.analytics.endpoint | Optional | The endpoint URL for the analytics server. |
| mfp.push.analytics.user | Optional | The username to access the analytics server. |
| mfp.push.analytics.password | Optional | The password to access the analytics server. |
| mfp.push.analytics.events.appCreate | Optional | The analytic event when the application is created. Default: true |
| mfp.push.analytics.events.appDelete | Optional | The analytic event when the application is deleted. Default: true |
| mfp.push.analytics.events.deviceRegister | Optional | The analytic event when the device is registered. Default: true |
| mfp.push.analytics.events.deviceUnregister | Optional	| The analytic event when the device is unregistered. Default: true |
| mfp.push.analytics.events.tagSubscribe | Optional | The analytic event when the device is subscribed to tag. Default: true |
| mfp.push.analytics.events.tagUnsubscribe | Optional | The analytic event when the device is unsubscribed from tag. Default: true |
| mfp.push.analytics.events.notificationSendSuccess | Optional | The analytic event when the notification is sent successfully. Default: true |
| mfp.push.analytics.events.notificationSendFailure | Optional | The analytic event when the notification is failed to send. Default: false |
| mfp.push.analytics.events.inactiveDevicePurge | Optional | The analytic event when the inactive devices are deleted. Default: true |
| mfp.push.analytics.events.msgReqAccepted | Optional | The analytic event when the notification is accepted for delivery. Default: true |
| mfp.push.analytics.events.msgDispatchFailed | Optional | The analytic event when the notification dispatch failed. Default: true |
| mfp.push.analytics.events.notificationDispatch | Optional	| The analytic event when the notification is about to be dispatched. Default: true |
| mfp.push.internalQueue.maxLength | Optional | The length of the queue which holds the notification tasks before dispatch. Default: 200000 |
| mfp.push.gcm.proxy.enabled | Optional	| Shows whether Google GCM must be accessed through a proxy. Default: false |
| mfp.push.gcm.proxy.protocol | Optional | Can be either http or https. |
| mfp.push.gcm.proxy.host | Optional | GCM proxy host. Negative value means default port. |
| mfp.push.gcm.proxy.port | Optional | GCM proxy port. Default: -1 |
| mfp.push.gcm.proxy.user | Optional | Proxy user name, if the proxy requires authentication. Empty user name means no authentication. |
| mfp.push.gcm.proxy.password | Optional | Proxy password, if the proxy requires authentication. |
| mfp.push.gcm.connections | Optional | Push GCM max connections. Default : 10 |
| mfp.push.apns.proxy.enabled | Optional | Shows whether APNs must be accessed through a proxy. Default: false |
| mfp.push.apns.proxy.type | Optional | APNs proxy type. |
| mfp.push.apns.proxy.host | Optional | APNs proxy host. |
| mfp.push.apns.proxy.port | Optional | APNs proxy port. Default: -1 |
| mfp.push.apns.proxy.user | Optional | Proxy user name, if the proxy requires authentication. Empty user name means no authentication. |
| mfp.push.apns.proxy.password | Optional | Proxy password, if the proxy requires authentication. |
| mfp.push.apns.connections | Optional | Push APNs max connections. Default : 3 |
| mfp.push.apns.connectionIdleTimeout | Optional | APNs Idle Connection Timeout. Default : 0 |
<!-- END NON-TRANSLATABLE -->
{% endcomment %}

## 配置数据源
{: #configuring-data-sources }
查明与受支持的数据库相关的一些数据源配置详细信息。

* [管理 DB2 事务日志大小](#managing-the-db2-transaction-log-size)
* [为 {{ site.data.keys.mf_server }} 和 Application Center 数据源配置 DB2 HADR 无缝故障转移](#configuring-db2-hadr-seamless-failover-for-mobilefirst-server-and-application-center-data-sources)
* [处理过时连接](#handling-stale-connections)
* [通过 {{ site.data.keys.mf_console }} 创建或删除应用程序后的旧数据](#stale-data-after-creating-or-deleting-apps-from-mobilefirst-operations-console)

### 管理 DB2 事务日志大小
{: #managing-the-db2-transaction-log-size }
在使用 IBM {{ site.data.keys.mf_console }} 部署至少为 40 MB 的应用程序时，您可能会收到 transaction log full 错误。

以下系统输出是 transaction log full 错误代码的示例。

```bash
DB2 SQL Error: SQLCODE=-964, SQLSTATE=57011
```

每个应用程序的内容都存储在 {{ site.data.keys.product_adj }} 管理数据库中。

活动日志文件由 **LOGPRIMARY** 和 **LOGSECOND** 数据库配置参数定义数量，并且由 **LOGFILSIZ** 数据库配置参数定义大小。单个事务不能使用超过 **LOGFILSZ** * (**LOGPRIMARY** + **LOGSECOND**) * 4096 KB 的日志空间。

`DB2 GET DATABASE CONFIGURATION` 命令包含有关日志文件大小的信息，以及主要和辅助日志文件的数量。

根据部署的 {{ site.data.keys.product_adj }} 应用程序的最大大小，您可能需要增加 DB2 日志空间。

使用 `DB2 update db cfg` 命令增大 **LOGSECOND** 参数。在激活数据库时不会分配空间。而是仅在需要时分配空间。

### 为 {{ site.data.keys.mf_server }} 和 Application Center 数据源配置 DB2 HADR 无缝故障转移
{: #configuring-db2-hadr-seamless-failover-for-mobilefirst-server-and-application-center-data-sources }
必须使用 WebSphere Application Server Liberty Profile 和 WebSphere Application Server 启用无缝故障转移功能。利用此功能，您可以在数据库发生故障转移并由 DB2 JDBC 驱动程序重新分配路由时管理异常。

> **注：**Apache Tomcat 不支持 DB2 HADR 故障转移。

DB2 HADR 的缺省行为是，DB2 JDBC 驱动程序会在首次尝试重复使用现有连接期间执行数据库检测，一旦检测到数据库故障就会重新分配客户机路由，同时该驱动程序会触发 **com.ibm.db2.jcc.am.ClientRerouteException**，并返回 **ERRORCODE=-4498** 和 **SQLSTATE=08506**。在应用程序接收此异常前，WebSphere Application Server 会将其映射到 **com.ibm.websphere.ce.cm.StaleConnectionException**。

在这种情况下，应用程序将不得不捕获异常并重新执行该事务。{{ site.data.keys.product_adj }} 和
Application Center 运行时环境不管理异常，但依赖于一项被称为“无缝故障转移”的功能。要启用该功能，必须将 **enableSeamlessFailover** JDBC 属性设置为“1”。

#### WebSphere Application Server Liberty Profile 配置
{: #websphere-application-server-liberty-profile-configuration }
必须编辑 **server.xml** 文件，并将 **enableSeamlessFailover** 属性添加到 {{ site.data.keys.product_adj }} 和
Application Center 数据源的 **properties.db2.jcc** 元素中。例如：

```xml
<dataSource jndiName="jdbc/WorklightAdminDS" transactional="false">
  <jdbcDriver libraryRef="DB2Lib"/>
  <properties.db2.jcc databaseName="WLADMIN"  currentSchema="WLADMSC"
                      serverName="db2server" portNumber="50000"
                      enableSeamlessFailover= "1"
                      user="worklight" password="worklight"/>
</dataSource>
```

#### WebSphere Application Server 配置
{: #websphere-application-server-configuration }
从 WebSphere Application Server 管理控制台，针对每个 {{ site.data.keys.product_adj }} 和 Application Center 数据源执行以下操作：

1. 转至**资源 → JDBC → 数据源 → 数据源名称**。
2. 选择**新建**，并添加以下定制属性或更新值（如果属性已存在）：`enableSeamlessFailover : 1`
3. 单击**应用**。
4. 保存配置。

有关如何配置到支持 HADR 的 DB2 数据库的连接的更多信息，请参阅 [Setting up a connection to an HADR-enabled DB2 database](https://www.ibm.com/support/knowledgecenter/SSAW57_8.5.5/com.ibm.websphere.nd.multiplatform.doc/ae/tdat_db2_hadr.html?cp=SSAW57_8.5.5%2F3-3-6-3-3-0-7-3&lang=en)。

### 处理过时连接
{: #handling-stale-connections }
配置应用程序服务器以避免出现数据库超时问题。

**StaleConnectionException** 是在 JDBC 驱动程序从连接请求或操作返回了不可恢复错误时，由 Java 应用程序服务器概要文件数据库连接代码生成的异常。在数据库供应商发出异常，指示连接池中的当前连接不再有效时，会生成 **StaleConnectionException**。
可能由于多种原因导致此异常。**StaleConnectionException** 的最常见原因是由于从数据库连接池检索连接并且发现长时间未用后连接已超时或者断开。

您可以配置应用程序服务器以避免出现此异常。

#### Apache Tomcat 的配置
{: #apache-tomcat-configuration }
**MySQL**  
经过一段时间的不活动状态之后，MySQL 数据库将关闭该连接。该超时时间是由名为 **wait_timeout** 的系统变量定义的。
缺省值为 28000 秒（8 小时）。

MySQL 关闭连接之后，当有连接尝试连接到数据库时，将产生以下异常：

```xml
com.mysql.jdbc.exceptions.jdbc4.MySQLNonTransientConnectionException: No operations allowed after statement closed.
```

编辑 **server.xml** 和 **context.xml** 文件，并为每个 `<Resource>` 元素添加以下属性：

* **testOnBorrow="true"**
* **validationQuery="select 1"**

例如：

```xml
<Resource name="jdbc/AppCenterDS"
  type="javax.sql.DataSource"
  driverClassName="com.mysql.jdbc.Driver"
  ...
  testOnBorrow="true"
  validationQuery="select 1"
/>
```

#### WebSphere Application Server Liberty Profile 配置
{: #websphere-application-server-liberty-profile-configuration-1 }
编辑 **server.xml** 文件，并为每个 `<dataSource>` 元素（运行时和 Application Center 数据库）添加带有 agedTimeout 属性的 `<connectionManager>` 元素：

```xml
<connectionManager agedTimeout="timeout_value"/>
```

超时值主要取决于并行打开的连接数，但是也与池中的最小和最大连接数有关。因此，必须调整不同的 **connectionManager** 属性以确定最适合的值。有关 **connectionManager** 元素的更多信息，请参阅 [Liberty：**server.xml** 文件中的配置元素](https://www.ibm.com/support/knowledgecenter/SSD28V_8.5.5/com.ibm.websphere.wlp.core.doc/autodita/rwlp_metatype_core.html)。

> **注释：**MySQL 与 WebSphere Application Server Liberty profile 或 WebSphere Application Server Full Profile 的组合不属于受支持的配置。有关更多信息，请参阅 [WebSphere Application Server 支持声明](http://www.ibm.com/support/docview.wss?uid=swg27004311)。使用 IBM DB2 或其他受 WebSphere Application Server 支持的数据库，以从 IBM 支持中心全面支持的配置中受益。
### 通过 {{ site.data.keys.mf_console }} 创建或删除应用程序后的旧数据
{: #stale-data-after-creating-or-deleting-apps-from-mobilefirst-operations-console }
在 Tomcat 8 应用程序服务器上，如果使用 MySQL 数据库，那么通过 {{ site.data.keys.mf_console }} 对服务的一些调用将返回 404 错误。

在 Tomcat 8 应用程序服务器上，如果使用 MySQL 数据库，那么当您使用
{{ site.data.keys.mf_console }} 删除应用程序或添加新应用程序并多次尝试刷新控制台时，您可能会看到旧数据。例如，用户可能会在列表中看到已删除的应用程序。

为避免此问题，请在数据源或数据库管理系统中将隔离级别更改为 **READ_COMMITTED**。

有关 **READ_COMMITTED** 的含义，请参阅 [MySQL 文档](http://www.ibm.com/doc/refman/5.7/en/innodb-transaction-isolation-levels.html?view=kc) ([http://dev.mysql.com/doc/refman/5.7/en/innodb-transaction-isolation-levels.html](http://dev.mysql.com/doc/refman/5.7/en/innodb-transaction-isolation-levels.html))。

* 要在数据源中将隔离级别更改为 **READ_COMMITTED**，请修改 **server.xml** Tomcat 配置文件：在 **<Resource name="jdbc/mfpAdminDS" .../>** 部分，添加 **defaultTransactionIsolation="READ_COMMITTED"** 属性。
* 要在数据库管理系统中将隔离级别全局更改为 **READ_COMMITTED**，请参阅 MySQL 文档的 [SET TRANSACTION Syntax 页面](http://dev.mysql.com/doc/refman/5.7/en/set-transaction.html) ([http://dev.mysql.com/doc/refman/5.7/en/set-transaction.html](http://dev.mysql.com/doc/refman/5.7/en/set-transaction.html))。

#### WebSphere Application Server Full Profile 配置
{: #websphere-application-server-full-profile-configuration }
**DB2 或 Oracle**  
要尽可能减少过时连接问题，请在 WebSphere Application Server 管理控制台中检查每个数据源上的连接池配置。

1. 登录到 WebSphere Application Server 管理控制台。
2. 选择**资源 → JDBC 提供程序 → database_jdbc_provider → 数据源 → your_data_source → 连接池属性**。
3. 将**最小连接数**值设置为 0。
4. 将**收集时间**值设置为小于**未使用超时**值的值。
5. 确保将**清除策略**属性设置为**整个池（缺省值）**。

有关更多信息，请参阅[连接池设置](https://www.ibm.com/support/knowledgecenter/SSAW57_8.5.5/com.ibm.websphere.nd.doc/ae/udat_conpoolset.html)。

**MySQL**  

1. 登录到 WebSphere Application Server 管理控制台。
2. 选择**资源 → JDBC → 数据源**。
3. 对于每个 MySQL 数据源：
    * 单击数据源。
    * 选择**其他属性**下的**连接池**属性。
    * 修改**过期超时**属性的值。该值必须小于 MySQL **wait_timeout** 系统变量，以便在 MySQL 关闭连接之前清除这些连接。
    * 单击**确定**。

> **注释：**MySQL 与 WebSphere Application Server Liberty profile 或 WebSphere Application Server Full Profile 的组合不属于受支持的配置。有关更多信息，请参阅 [WebSphere Application Server 支持声明](http://www.ibm.com/support/docview.wss?uid=swg27004311)。使用 IBM DB2 或其他受 WebSphere Application Server 支持的数据库，以从 IBM 支持中心全面支持的配置中受益。
## 配置日志记录和监控机制
{: #configuring-logging-and-monitoring-mechanisms }
{{ site.data.keys.product }} 会在日志文件中报告错误、警告和参考消息。底层的日志记录机制因应用程序服务器而异。

### {{ site.data.keys.mf_server }}
{: #mobilefirst-server }
{{ site.data.keys.product }}（简称 {{ site.data.keys.mf_server }}）使用标准 java.util.logging 包。缺省情况下，所有的 {{ site.data.keys.product_adj }} 日志记录都将记入应用程序服务器日志文件。您可以使用每个应用程序服务器中可用的标准工具来控制 {{ site.data.keys.mf_server }} 日志记录。例如，如果要在 WebSphere Application Server Liberty 中激活跟踪日志记录，请向 server.xml 文件添加跟踪元素。要在 WebSphere Application Server 中激活跟踪日志记录，请使用控制台中的日志记录屏幕并对 {{ site.data.keys.product_adj }} 日志启用跟踪。

{{ site.data.keys.product_adj }} 日志均以 **com.ibm.mfp** 开头。  
Application Center 日志以 **com.ibm.puremeap** 开头。

有关每个应用程序服务器的日志记录模型的更多信息（包括日志文件的位置），请参阅相关应用程序服务器的文档，如下表所示。

| 应用程序服务器 | 文档位置 |
| -------------------|---------------------------|
| Apache Tomcat	     | [http://tomcat.apache.org/tomcat-7.0-doc/logging.html#Using_java.util.logging_(default)](http://tomcat.apache.org/tomcat-7.0-doc/logging.html#Using_java.util.logging_(default)) |
| WebSphere Application Server Full Profile V8.5 | 	[http://ibm.biz/knowctr#SSEQTP_8.5.5/com.ibm.websphere.base.doc/ae/ttrb_trcover.html](http://ibm.biz/knowctr#SSEQTP_8.5.5/com.ibm.websphere.base.doc/ae/ttrb_trcover.html) |
| WebSphere Application Server Liberty Profile V8.5 | 	[http://ibm.biz/knowctr#SSEQTP_8.5.5/com.ibm.websphere.wlp.doc/ae/rwlp_logging.html?cp=SSEQTP_8.5.5%2F1-16-0-0](http://ibm.biz/knowctr#SSEQTP_8.5.5/com.ibm.websphere.wlp.doc/ae/rwlp_logging.html?cp=SSEQTP_8.5.5%2F1-16-0-0) |

### 日志级别映射
{: #log-level-mappings }
{{ site.data.keys.mf_server }} 使用 **java.util.logging** API。日志记录级别将映射到以下级别：

* WL.Logger.debug: FINE
* WL.Logger.info: INFO
* WL.Logger.warn: WARNING
* WL.Logger.error: SEVERE

### 日志监控工具
{: #log-monitoring-tools }
对于 Apache Tomcat，您可以使用 [IBM  Operations Analytics - Log Analysis](http://www.ibm.com/software/products/en/ibm-operations-analytics---log-analysis) 或其他行业标准日志文件监控工具来监控日志并突出显示错误和警告。

对于 WebSphere Application Server，使用 IBM Knowledge Center 中描述的日志查看工具。URL 列出在该页面 {{ site.data.keys.mf_server }} 部分的表中。

### 后端连接
{: #back-end-connectivity }
要启用跟踪以监控后端连接，请参阅此页面的 {{ site.data.keys.mf_server }} 部分中表内针对特定应用程序服务器平台的文档。使用 **com.ibm.mfp.server.js.adapter** 包并将日志级别设置为 **FINEST**。

### 针对管理操作的审计日志
{: #audit-log-for-administration-operations }
{{ site.data.keys.mf_console }} 存储了针对登录、注销和所有管理操作（例如部署应用程序或适配器或者锁定应用程序）的审计日志。您可以通过在 {{ site.data.keys.product_adj }} 管理服务 (**mfp-admin-service.war**) 的 Web 应用程序上将 JNDI 属性 **mfp.admin.audit** 设置为 false，来禁用审计日志。

启用审计日志后，可以通过单击页面页脚中的**审计日志**链接来从 {{ site.data.keys.mf_console }} 中下载。

### 登录和认证问题
{: #login-and-authentication-issues }
要诊断登录和认证问题，请为跟踪启用包 **com.ibm.mfp.server.security**，并将日志级别设置为 **FINEST**。

## 配置多个运行时
{: #configuring-multiple-runtimes }
您可以为 {{ site.data.keys.mf_server }} 配置多个运行时，从而在 {{ site.data.keys.mf_console }} 中针对不同应用程序“类型”创造视觉差异。

> **注释：**Mobile Foundation Bluemix 服务创建的 Mobile Foundation 服务器实例不支持多个运行时。然而，在 Bluemix 服务中，您必须创建多个服务实例。
#### 跳转至
{: #jump-to-1 }
* [在 WebSphere Liberty Profile 中配置多个运行时](#configuring-multiple-runtimes-in-websphere-liberty-profile)
* [注册应用程序并将适配器部署到不同的运行时](#registering-applications-and-deploying-adapters-to-different-runtimes)
* [导出和导入运行时配置](#exporting-and-importing-runtime-configurations)

### 在 WebSphere Liberty Profile 中配置多个运行时
{: #configuring-multiple-runtimes-in-websphere-liberty-profile }

1. 打开应用程序服务器的 **server.xml** 文件。该文件通常位于 **[application-server]/usr/servers/server-name/** 文件夹中。例如，对于 {{ site.data.keys.mf_dev_kit }}，该文件位于 **[installation-folder]/mfp-server/usrs/servers/mfp/server.xml**。

2. 添加第二个 `application` 元素：

   ```xml
   <application id="second-runtime" name="second-runtime" location="mfp-server.war" type="war">
        <classloader delegation="parentLast">
            </classloader>
   </application>
   ```

3. 添加第二组 JNDI 条目：

   ```xml
   <jndiEntry jndiName="second-runtime/mfp.analytics.url" value='"http://localhost:9080/analytics-service/rest"'/>
   <jndiEntry jndiName="second-runtime/mfp.analytics.console.url" value='"http://localhost:9080/analytics/console"'/>
   <jndiEntry jndiName="second-runtime/mfp.analytics.username" value='"admin"'/>
   <jndiEntry jndiName="second-runtime/mfp.analytics.password" value='"admin"'/>
   <jndiEntry jndiName="second-runtime/mfp.authorization.server" value='"embedded"'/>
   ```

4. 添加第二个 `dataSource` 元素：

   ```xml
   <dataSource jndiName="second-runtime/jdbc/mfpDS" transactional="false">
        <jdbcDriver libraryRef="DerbyLib"/>
        <properties.derby.embedded databaseName="${wlp.install.dir}/databases/second-runtime" user='"MFPDATA"'/>
   </dataSource>
   ```

    > **注：**
    >
    > * 确保 `dataSource` 指向其他数据库模式。
    > * 确保已为新的运行时创建了[其他数据库实例](../databases)。
    > * 在开发环境中，在 `properties.derby.embedded` 子元素中添加 `createDatabase="create"`。

5. 重新启动应用程序服务器。

### 注册应用程序并将适配器部署到不同的运行时
{: #registering-applications-and-deploying-adapters-to-different-runtimes }
如果 {{ site.data.keys.mf_server }} 配置有多个运行时，那么在注册应用程序和部署适配器方面会稍有不同。

* [通过 {{ site.data.keys.mf_console }} 注册和部署](#registering-and-deploying-from-the-mobilefirst-operations-console)
* [通过命令行注册和部署](#registering-and-deploying-from-the-command-line)

#### 通过 {{ site.data.keys.mf_console }} 注册和部署
{: #registering-and-deploying-from-the-mobilefirst-operations-console }
在 {{ site.data.keys.mf_console }} 中执行这些操作时，您现在需要选择运行时以执行注册或部署操作。

<img class="gifplayer" alt="{{ site.data.keys.mf_console }} 中的多个运行时" src="register-and-deploy-to-multiple-runtimes.png"/>

#### 通过命令行注册和部署
{: #registering-and-deploying-from-the-command-line }
使用 **mfpdev** 命令行工具执行这些操作时，您现在需要添加运行时名称以执行注册或部署操作。

要注册应用程序：`mfpdev app register <server-name> <runtime-name>`。  

```bash
mfpdev app register local second-runtime
```

要部署适配器：`mfpdev adapter deploy <server-name> <runtime-name>`。  

```bash
mfpdev adapter deploy local second-runtime
```

* **local** 是 {{ site.data.keys.mf_cli }} 中缺省服务器定义的名称。使用您需要注册或部署到的服务器定义名称替换 *local*。
* **runtime-name** 是要注册或部署到的运行时名称。

> 通过以下 CLI help 命令了解更多信息：
>
> * `mfpdev help server add`
> * `mfpdev help app register`
> * `mfpdev help adapter deploy`

## 导出和导入运行时配置
{: #exporting-and-importing-runtime-configurations }
您可以导出运行时配置，然后使用 {{ site.data.keys.mf_server }} **管理服务** 的 REST API 将其导入到另一个 {{ site.data.keys.mf_server }} 中。

例如，您可以在开发环境中设置一个运行时配置并将其导出，接着将其导入到测试环境中以用于快速设置，然后针对测试环境的特定需求进行进一步配置。

> [在 API 参考中](http://www.ibm.com/support/knowledgecenter/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/c_restapi_oview.html)查找所有可用的 REST API。
## 配置许可证跟踪
{: #configuring-license-tracking }
缺省情况下启用许可证跟踪。阅读以下主题以了解如何配置许可证跟踪。有关许可证跟踪的更多信息，请参阅[许可证跟踪](../../../administering-apps/license-tracking)。

* [
为客户机设备和可寻址设备配置许可证跟踪](#configuring-license-tracking-for-client-device-and-addressable-device)
* [配置 IBM License Metric Tool 日志文件](#configuring-ibm-license-metric-tool-log-files)

### 为客户机设备和可寻址设备配置许可证跟踪
{: #configuring-license-tracking-for-client-device-and-addressable-device }
缺省情况下，针对客户机设备和可寻址设备启用许可证跟踪。{{ site.data.keys.mf_console }} 中提供许可证报告。
您可以指定以下 JNDI 属性以更改许可证跟踪的缺省设置。

> **注意：**如果您有定义令牌许可使用的合同，另请参阅[安装和配置令牌许可](../token-licensing)。
您可以指定以下 JNDI 属性以更改许可证跟踪的缺省设置。

**mfp.device.decommission.when**  
在设备处于不活动状态达到此天数后，将通过设备取消授权任务来取消授权此设备。许可证报告不会将停用的设备计为活动设备。此属性的缺省值为 90 天。如果按客户机设备或可寻址设备许可软件，或者许可证报告可能不足以证明合规性，那么请勿设置小于 30 天的值。

**mfp.device.archiveDecommissioned.when**  
该值以天为单位，用于定义在运行停用任务后何时将已停用的设备放入归档文件中。归档的设备将写入到 IBM {{ site.data.keys.mf_server }} **home\devices_archive** 目录中的文件。该文件名包含创建归档文件的时间戳记。缺省值为 90 天。

**mfp.device.decommissionProcessingInterval**  
定义运行停用任务的频率（秒）。缺省值：86400，即一天。停用任务执行以下操作：

* 根据 **mfp.device.decommission.when** 设置，停用不活动的设备。
* （可选）根据 **mfp.device.archiveDecommissioned.when** 设置，归档较旧的停用设备。
* 生成许可证跟踪报告。

**mfp.licenseTracking.enabled**  
用于在 {{ site.data.keys.product }} 中启用或禁用许可证跟踪的值。
缺省情况下，启用许可证跟踪。出于性能原因，当不是按客户机设备或可寻址设备许可 {{ site.data.keys.product }} 时，您可以禁用该标志。禁用设备跟踪后，还会禁用许可证报告，并且不会生成任何许可证度量值。在此情况下，仅针对“应用程序”计数生成 IBM License Metric Tool 记录。

有关指定 JNDI 属性的更多信息，请参阅 [{{ site.data.keys.product_adj }} 运行时的 JNDI 属性列表](#list-of-jndi-properties-for-mobilefirst-runtime)。

### 配置 IBM License Metric Tool 日志文件
{: #configuring-ibm-license-metric-tool-log-files }
{{ site.data.keys.product }} 生成 IBM Software License Metric Tag (SLMT) 文件。支持 IBM Software License Metric Tag 的 IBM License Metric Tool 版本能够生成许可证使用情况报告。请阅读本信息以了解如何配置所生成文件的位置和最大大小。

缺省情况下，IBM Software License Metric Tag 文件位于以下目录中：

* 在 Windows 上：**%ProgramFiles%\ibm\common\slm**
* 在 UNIX 和类 UNIX 操作系统上：**/var/ibm/common/slm**

如果目录不可写，将在运行 {{ site.data.keys.product_adj }} 运行时环境的应用程序服务器的日志目录中创建这些文件。

您可以使用以下属性配置这些文件的位置与管理：

* **license.metric.logger.output.dir**：IBM Software License Metric Tag 文件的位置
* **license.metric.logger.file.size**：执行循环前 SLMT 文件的最大大小。缺省大小为 1 MB。
* **license.metric.logger.file.number**：保留在循环中的最大 SLMT 归档文件数。缺省数量为 10。

要更改缺省值，您必须创建一个 Java 属性文件，其格式为 **key=value**，并通过 **license_metric_logger_configuration** JVM 属性提供属性文件的路径。

有关 IBM License Metric Tool 报告的更多信息，请参阅[与 IBM License Metric Tool 集成](../../../administering-apps/license-tracking/#integration-with-ibm-license-metric-tool)。

## WebSphere Application Server SSL 配置和 HTTP 适配器
{: #websphere-application-server-ssl-configuration-and-http-adapters }
通过设置属性，可以使 HTTP 适配器利用 WebSphere SSL 配置的优势。

缺省情况下，HTTP 适配器不会通过将 Java 运行时环境 (JRE) 信任库与 [配置 {{ site.data.keys.mf_server }} 密钥库](../../../authentication-and-security/configuring-the-mobilefirst-server-keystore)中描述的 {{ site.data.keys.mf_server }} 密钥库相连接来使用 WebSphere SSL。另请参阅[使用自签名证书在适配器和后端服务器之间配置 SSL](../../../administering-apps/deployment/#configuring-ssl-between-adapters-and-back-end-servers-by-using-self-signed-certificates)。

要使 HTTP 适配器使用 WebSphere SSL 配置，请将 **ssl.websphere.config** JNDI 属性设置为 true。该设置具有以下效果（按优先顺序）：

1. 运行在 WebSphere 上的适配器使用 WebSphere 密钥库而非 {{ site.data.keys.mf_server }} 密钥库。
2. 如果设置了 **ssl.websphere.alias** 属性，那么适配器将使用与该属性中设置的别名关联的 SSL 配置。

