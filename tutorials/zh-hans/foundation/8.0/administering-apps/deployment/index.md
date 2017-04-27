---
layout: tutorial
title: 将应用程序部署到测试和生产环境
breadcrumb_title: 将应用程序部署到环境
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
完成应用程序的开发周期后，请将其部署到测试环境中，然后再将其部署到生产环境中。

### 跳转至
{: #jump-to }

* [将适配器部署或更新至生产环境](#deploying-or-updating-an-adapter-to-a-production-environment)
* [使用自签名证书在适配器和后端服务器之间配置 SSL](#configuring-ssl-between-adapters-and-back-end-servers-by-using-self-signed-certificates)
* [为测试或生产环境构建应用程序](#building-an-application-for-a-test-or-production-environment)
* [向生产环境注册应用程序](#registering-an-application-to-a-production-environment)
* [将服务器端工件传输到测试或生产服务器](#transferring-server-side-artifacts-to-a-test-or-production-server)
* [在生产环境中更新 {{ site.data.keys.product_adj }} 应用程序](#updating-mobilefirst-apps-in-production)

## 将适配器部署或更新至生产环境
{: #deploying-or-updating-an-adapter-to-a-production-environment }
适配器包含
{{ site.data.keys.product }}
上部署并维护的应用程序的服务器端代码。在将适配器部署或更新至生产环境之前，请阅读此核对表。有关创建和构建适配器的更多信息，请参阅[开发 {{ site.data.keys.product_adj }} 应用程序的服务器端](../../adapters)。

在生产服务器运行的同时，可以上载、更新或配置适配器。在服务器机群的所有节点都收到新适配器或配置
之后，针对此适配器发出的所有入局请求都将使用新设置。

1. 如果在生产环境中更新现有适配器，请确保该适配器与向服务器注册的现有应用程序兼容，并确保不会影响这些应用程序的功能。


    已发布至应用商店并已使用的多个应用程序或相同应用程序的多个版本可使
用相同的适配器。在生产环境中更新适配器之前，请在测试服务器中针对新适配器以及
为测试服务器构建的应用程序的副本运行非回归测试。

2. 对于 Java 适配器，如果
适配器将 Java URLConnection 与 HTTPS 结合使用，请确保后端证书位于 {{ site.data.keys.mf_server }} 密钥库中。
        
    有关更多信息，请参阅[在 HTTP 适配器中使用 SSL](../../adapters/javascript-adapters/js-http-adapter/using-ssl/)。有关使用自签名证书的更多信息，请参阅[使用自签名证书在适配器和后端服务器之间配置 SSL](#configuring-ssl-between-adapters-and-back-end-servers-by-using-self-signed-certificates)。

    > **注：**如果应用程序服务器为 WebSphere Application Server Liberty，那么这些证书还必须包含在 Liberty 信任库中。
3. 验证适配器的服务器端配置。
4. 使用 `mfpadm deploy adapter` 和 `mfpadm adapter set user-config` 命令来上载适配器及其配置。

    有关适用于适配器的 **mfpadm** 的更多信息，请参阅[适配器命令](../using-cli/#commands-for-adapters)。
        
## 使用自签名证书在适配器和后端服务器之间配置 SSL
{: #configuring-ssl-between-adapters-and-back-end-servers-by-using-self-signed-certificates }
通过将服务器自签名 SSL 证书导入到 {{ site.data.keys.product_adj }} 密钥库，可以在适配器和后端服务器之间配置 SSL。

1. 从后端服务器密钥库中导出服务器公用证书。

    > **注：**使用 keytool 或 openssl lib 从后端服务器密钥库导出服务器的公用证书。请勿使用 Web 浏览器中的 export 功能。
    2. 将后端服务器证书导入到 {{ site.data.keys.product_adj }} 密钥库。
3. 部署新的 {{ site.data.keys.product_adj }} 密钥库。有关更多信息，请参阅[配置 {{ site.data.keys.mf_server }} 密钥库](../../authentication-and-security/configuring-the-mobilefirst-server-keystore/)。

### 示例
{: #example }
后端证书的 **CN** 名称必须与在适配器描述符 **adapter.xml** 文件中配置的内容匹配。例如，请考虑配置如下所示的 **adapter.xml** 文件：

```xml
<protocol>https</protocol>
<domain>mybackend.com</domain>
```

必须使用 **CN=mybackend.com** 生成后端证书。

如其他示例所示，请考虑以下适配器配置：

```xml
<protocol>https</protocol>
<domain>123.124.125.126</domain>
```

必须使用 **CN=123.124.125.126** 生成后端证书。

以下示例说明如何使用 Keytool 程序完成配置。

1. 使用专用证书创建为期 365 天的后端服务器密钥库。
        
    ```bash
    keytool -genkey -alias backend -keyalg RSA -validity 365 -keystore backend.keystore -storetype JKS
    ```

    > **注：****姓名**字段包含在 **adapter.xml** 配置文件中使用的服务器 URL（例如，**mydomain.com** 或 **localhost**）。
2. 将后端服务器配置为使用此密钥库。例如，在 Apache Tomcat 中，更改 **server.xml** 文件：

   ```xml
   <Connector port="443" SSLEnabled="true" maxHttpHeaderSize="8192" 
      maxThreads="150" minSpareThreads="25" maxSpareThreads="200"
      enableLookups="false" disableUploadTimeout="true"         
      acceptCount="100" scheme="https" secure="true"
      clientAuth="false" sslProtocol="TLS"
      keystoreFile="backend.keystore" keystorePass="password" keystoreType="JKS"
      keyAlias="backend"/>
   ```
        
3. 检查 **adapter.xml** 文件中的连接配置：

   ```xml
   <connectivity>
      <connectionPolicy xsi:type="http:HTTPConnectionPolicyType">
        <protocol>https</protocol>
        <domain>mydomain.com</domain>
        <port>443</port>
        <!-- The following properties are used by adapter's key manager for choosing a specific certificate from the key store
        <sslCertificateAlias></sslCertificateAlias> 
        <sslCertificatePassword></sslCertificatePassword>
        -->		
      </connectionPolicy>
      <loadConstraints maxConcurrentConnectionsPerNode="2"/>
   </connectivity>
   ```
        
4. 从所创建的后端服务器密钥库中导出公用证书：

   ```bash
   keytool -export -alias backend -keystore backend.keystore -rfc -file backend.crt
   ```
        
5. 将导出的证书导入到 {{ site.data.keys.mf_server }} 密钥库中：

   ```bash
   keytool -import -alias backend -file backend.crt -storetype JKS -keystore mfp.keystore
   ```
        
6. 确保已将证书正确导入密钥库中：

   ```bash
   keytool -list -keystore mfp.keystore
   ```
        
7. 部署新的 {{ site.data.keys.mf_server }} 密钥库。

## 为测试或生产环境构建应用程序
{: #building-an-application-for-a-test-or-production-environment }
要为测试或生产环境构建应用程序，必须针对目标服务器配置此应
用程序。要为生产环境构建应用程序，可能需要其他步骤。

1. 确保已配置目标服务器密钥库。有关更多信息，请参阅[配置 {{ site.data.keys.mf_server }} 密钥库](../../authentication-and-security/configuring-the-mobilefirst-server-keystore/)。

2. 如果计划分发该应用程序的可安装工件，请递增应用程序版本。
3. 构建应用程序之前，请针对目标服务器配置此应用程序。

    在客户机属性文件中定义目标服务器的 URL 和运行时名称。您也可以通过
{{ site.data.keys.mf_cli }}
更改目标服务器。要为目标服务器配置应用程序而不向正在运行的服务器注册此应用程
序，可以使用 `mfpdev app config server <server
URL>` 和 `mfpdev app config runtime
<runtime_name>` 命令。
也可以通过运行 `mfpdev app register` 命令，向正在运
行的服务器注册此应用程序。请使用服务器的公共 URL。此 URL 供移动应用程序用来连接到
{{ site.data.keys.mf_server }}。
    
    例如，要为目标服务器 mfp.mycompany.com 配置应用程序，并使运行时的缺省名称为 mfp，请运行 `mfpdev app config server https://mfp.mycompany.com` 和 `mfpdev app config runtime mfp`。
    
4. 为应用程序配置密钥和授权服务器。
    * 如果应用程序实施了证书绑定，请使用目标服务器的证书。有关证书绑定的更多信息，请参阅[证书绑定](../../authentication-and-security/certificate-pinning)。
    * 如果 iOS 应用程序使用应用程序传输安全性 (ATS)，请为目标服务器配置 ATS。
    * 要为 Apache Cordova 应用程序配置安全直接更新，请参阅[在客户机端实施安全直接更新](../../application-development/direct-update)。
    * 如果使用 Apache Cordova 来开发应用程序，请配置 Cordova 内容安全
策略 (CSP)。    

5. 如果计划对通过 Apache Cordova 开发的应用程序使用直接更新，请将用于构建此应用程序的 Cordova 插件版本一起打包在内。

    直接更新无法用于更新本机代码。如果更改了 Cordova 项目中的本机库或某个构建工具
，并将此类文件上载至
{{ site.data.keys.mf_server }}
，那么服务器将会检测到这一差异，但不会发送客户机应用程序的任何更新。本机库中的更改可能包括不同的 Cordova 版本、较新的 Cordova iOS 插件，甚至是比用于构建原始应用程序的插件修订包更新的 mfpdev 插件修订包。
    
6. 为生产用途配置应用程序。
    * 考虑禁用“打印到设备日志”。
    * 如果计划使用 {{ site.data.keys.mf_analytics }}，请验证应用程序是否将所收集的数据发送到 {{ site.data.keys.mf_server }}。
    * 除非计划为多个测试服务器创建同一个构建，否则请考虑禁用应用程序中
调用 `setServerURL` API 的功能。

7. 如果针对生产服务器进行构建，并且计划分发可安装工件，请归档应用程
序源代码，以便能够在测试服务器上针对此应用程序运行非回归测试。

    例如，如果稍后要更新适配器，那么可以在使用此适配器的已分发的应用程序上运行非回归测试。有关更多信息，请参阅[将适配器部署或更新至生产环境](#deploying-or-updating-an-adapter-to-a-production-environment)。
    
8. 可选：为应用程序创建应用程序真实性文件。

    向服务器注册应用程序以启用应用程序真实性安全检查后，可使用应用程序真实性文件。
    * 有关更多信息，请参阅[启用应用程序真实性安全性检查](../../authentication-and-security/application-authenticity)。
    * 有关向生产服务器注册应用程序的更多信息，请参阅[向生产环境注册应用程序](#registering-an-application-to-a-production-environment)。

## 向生产环境注册应用程序
{: #registering-an-application-to-a-production-environment }
向生产服务器注册应用程序时，会上载其应用程序描述符、定义其许可证类型并（可选）激活应用程序真实性。

#### 开始之前
{: #before-you-begin }
* 确认已配置 {{ site.data.keys.mf_server }} 密钥库且不是缺省密钥库。请勿在具有缺省密钥库的生产环境中使用服务器。{{ site.data.keys.mf_server }} 密钥库定义了 {{ site.data.keys.mf_server }} 实例的身份，并用于以数字方式签署 OAuth 令牌和直接更新包。您必须使用密钥配置服务器的密钥库，然后才能在生产环境中使用。有关更多信息，请参阅[配置 {{ site.data.keys.mf_server }} 密钥库](../../authentication-and-security/configuring-the-mobilefirst-server-keystore/)。
* 部署应用程序所使用的适配器。有关更多信息，请参阅[将适配器部署或更新至生产环境](#deploying-or-updating-an-adapter-to-a-production-environment)。
* 为目标服务器构建应用程序。有关更多信息，请参阅[为测试或生产环境构建应用程序](#building-an-application-for-a-test-or-production-environment)。

向生产服务器注册应用程序时，会上载其应用程序描述符、定义其许可证类型并（可选）激活应用程序真实性。如果已部署较低版本的应用程序，那么还可能需要定义更新策略。请查看以下过程，以了解一些重要步骤以及如何使用 **mfpadm** 程序来自动执行这些步骤。

1. 如果对 {{ site.data.keys.mf_server }}
配置了令牌许可，请确保许可证密钥服务器上具有足够的令牌。有关更多信息，请参阅[令牌许可证验证](../license-tracking/#token-license-validation)和[规划使用令牌许可](../../installation-configuration/production/token-licensing/#planning-for-the-use-of-token-licensing)。

   > **提示：**在注册应用程序的第一个版本之前，可设置应用程序的令牌许可证类型。有关更多信息，请参阅[设置应用程序许可证信息](../license-tracking/#setting-the-application-license-information)。

2. 将应用程序描述符从测试服务器传输到生产服务器。

   此操作可向生产服务器注册应用程序并上载其配置。
有关传输应用程序描述符的更多信息，请参阅[将服务器端工件传输到测试或生产服务器](#transferring-server-side-artifacts-to-a-test-or-production-server)。

3. 设置应用程序许可证信息。有关更多信息，请参阅[设置应用程序许可证信息](../license-tracking/#setting-the-application-license-information)。
4. 配置应用程序真实性安全检查。有关配置应用程序真实性安全检查的更多信息，请参阅[配置应用程序真实性安全检查](../../authentication-and-security/application-authenticity/#configuring-application-authenticity)。


   > **注：**您需要应用程序二进制文件来创建应用程序真实性文件。有关更多信息，请参阅[启用应用程序真实性安全性检查](../../authentication-and-security/application-authenticity/#enabling-application-authenticity)。
   5. 如果应用程序使用推送通知，请将推送通知证书上载到服务器。您可以使用 {{ site.data.keys.mf_console }} 来上载应用程序的推送证书。这些证书对于应用程序的所有版本是通用的。


   > **注：**在将应用程序发布至应用商店之前，可能无法使用生产证书来测试应用程序的推送通知。

6. 在将应用程序发布至应用商店之前，请验证以下项。
    * 测试您计划要使用的任何移动应用程序管理功能，如禁用远程应用程序或
显示管理员消息。有关更多信息，请参阅[移动应用程序管理](../using-console/#mobile-application-management)。
    * 在存在更新的情况下，定义更新策略。有关更多信息，请参阅[在生产环境中更新 {{ site.data.keys.product_adj }} 应用程序](#updating-mobilefirst-apps-in-production)。

## 将服务器端工件传输到测试或生产服务器
{: #transferring-server-side-artifacts-to-a-test-or-production-server }
您可以使用命令行工具或 REST API，将应用程序配置从一台服务器传输到另一台服务器。

应用程序描述符文件是包含应用程序的描述和配置的 JSON 文件。当您运行连接到
{{ site.data.keys.mf_server }}
实例的应用程序时，必须向该服务器注册此应用程序并进行配置。为应用程序定义配置后，可将应用程序描述符传输到另一台服务器（例如，传输到测试服务器或生产服务器）。在将应用程序描述符传输到新服务器后，系统会向此新服务器注册应用程序。根据您是否正在开发移动应用程序并有权访问代码，或者您是否正在管理服务器并
无权访问移动应用程序代码，提供了不同过程。

> **要点：**如果导入包含真实性数据的应用程序，并且该应用程序本身在生成真实性数据后经过重新编译，那么您必须刷新真实性数据。有关更多信息，请参阅[配置应用程序真实性安全检查](../../authentication-and-security/application-authenticity/#configuring-application-authenticity)。
* 如果您有权访问移动应用程序代码，请使用 `mfpdev app pull` 和 `mfpdev app push` 命令。
* 如果您无权访问移动应用程序代码，请使用管理服务。

#### 跳转至
{: #jump-to-1 }

* [使用 mfpdev 传输应用程序配置](#transferring-an-application-configuration-by-using-mfpdev)
* [使用管理服务传输应用程序配置](#transferring-an-application-configuration-with-the-administration-service)
* [使用 REST API 传输服务器端工件](#transferring-server-side-artifacts-by-using-the-rest-api)
* [从 MobileFirst Operations Console 导出和导入应用程序和适配器](#exporting-and-importing-applications-and-adapters-from-the-mobilefirst-operations-console)

### 使用 mfpdev 传输应用程序配置
{: #transferring-an-application-configuration-by-using-mfpdev }
开发应用程序后，可以将其从开发环境传输到测试或生产环境。

* 您的本地计算机上必须具有现有的 {{ site.data.keys.product_adj }} 应用程序。必须向 {{ site.data.keys.mf_server }} 注册该应用程序。
有关创建服务器概要文件的信息，请运行 **mfpdev app register**，或者参阅本文档的“开发应用程序”部分中有关注册应用程序类型的主题。
* 您的本地计算机必须已连接到当前向其注册该应用程序的服务器，还必须已连接到要向其传输该应用程序的服务器。
* 您的本地计算机上必须具有用于原始 {{ site.data.keys.mf_server }} 和要向其传输该应用程序的服务器的服务器概要文件。有关创建服务器概要文件的信息，请运行 **mfpdev server add**。
* 您必须已安装 {{ site.data.keys.mf_cli }}。

可使用 **mfpdev app pull** 命令来将该应用程序的服务器端配置文件的副本发送到本地计算机。然后，可使用 **mfpdev app push** 命令来将其发送到其他 {{ site.data.keys.mf_server }}。**mfpdev app push** 命令还可在指定服务器上注册该应用程序。

您还可以使用这些命令来将运行时配置从一台服务器传输到另一台服务器。

配置信息包括用于向服务器唯一标识应用程序的应用程序描述符的内容，以及特定于应用程序的其他信息。配置文件以压缩文件形式（.zip 格式）提供。这些 .zip 文件位于 **appName/mobilefirst** 目录中，并按如下方式命名：

```bash
appID-platform-version-artifacts.zip
```

其中，**appID** 是应用程序名称，**platform** 是 **android**、**ios** 或 **windows** 中的一个，而 version 是应用程序的版本级别。对于 Cordova 应用程序，将针对每个目标平台创建一个单独的 .zip 文件。

使用 **mfpdev
app push** 命令时，系统会修改应用程序的客户机属性文件以反映新 {{ site.data.keys.mf_server }} 的概要文件名称和 URL。

1. 在开发计算机上，浏览至应用程序根目录或者其中的某一个子目录。
2. 运行 **mfpdev app pull** 命令。如果指定的命令不含任何参数，那么会从缺省 {{ site.data.keys.mf_server }} 中拉出该应用程序。
您还可以指定特定服务器及其管理员密码。例如，针对名为 **myapp1** 的 Android 应用程序：


   ```bash
   cd myapp1
   mfpdev app pull Server10 -password secretPassword!
   ```
    
   此命令会在具有服务器概要文件 Server10 的 {{ site.data.keys.mf_server }} 上查找当前应用程序的配置文件。然后，它会将包含这些配置文件的压缩文件 **myapp1-android-1.0.0-artifacts.zip** 发送到本地计算机，并将其置于 **myapp1/mobilefirst** 目录中。
    
3. 运行 **mfpdev app push** 命令。如果指定的命令不含任何参数，那么会将该应用程序推送到缺省 {{ site.data.keys.mf_server }}。
您还可以指定特定服务器及其管理员密码。例如，对于在上一步骤中推送的同一应用程序：`mfpdev app push Server12 -password secretPass234!`。
    
   此命令会将 **myapp1-android-1.0.0-artifacts.zip** 文件发送到具有服务器概要文件 Server12 的 {{ site.data.keys.mf_server }}（其管理员密码为 **secretPass234!**）。客户机属性文件 **myapp1/app/src/main/assets/mfpclient.properties** 会进行修改，以反映向其注册该应用程序的服务器为 Server12 并显示此服务器的 URL。

该应用程序的服务器端配置文件位于 mfpdev app push 命令中指定的 {{ site.data.keys.mf_server }} 中。这样会向此新服务器注册该应用程序。

### 使用管理服务传输应用程序配置
{: #transferring-an-application-configuration-with-the-administration-service }
作为管理员，可使用 {{ site.data.keys.mf_server }} 的管理服务，将应用程序配置从一台服务器传输到另一台服务器。无需访问应用程序代码，但必须为目标服务器构建客户端应用程序。

#### 开始之前
{: #before-you-begin-1 }
为目标服务器构建客户端应用程序。有关更多信息，请参阅[为测试或生产环境构建应用程序](#building-an-application-for-a-test-or-production-environment)。

可从配置了应用程序的服务器中下载应用程序描述符，然后将其部署到新服务器上。您可以在 {{ site.data.keys.mf_console }} 中查看应用程序描述符。

1. 可选：在配置了应用程序服务器的服务器中查看应用程序描述符。打开该服务器的 {{ site.data.keys.mf_console }}，选择应用程序版本，然后转至**配置文件**选项卡。

2. 从配置了应用程序的服务器中下载应用程序描述符。可以使用 REST API 或 **mfpadm** 来下载。

   > **注：**还可以从 {{ site.data.keys.mf_console }} 导出应用程序或应用程序版本。请参阅[从 {{ site.data.keys.mf_console }} 导出和导入应用程序和适配器](#exporting-and-importing-applications-and-adapters-from-the-mobilefirst-operations-console)。
    * 要使用 REST API 下载应用程序描述符，请使用[应用程序描述符 (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_descriptor_get.html?view=kc#Application-Descriptor--GET-) REST API。

    以下 URL 可返回应用程序标识为 **my.test.application** 的应用程序、**ios** 平台以及 **0.0.1** 版本的应用程序描述符。对 {{ site.data.keys.mf_server }} 进行调用：`http://localhost:9080/mfpadmin/management-apis/2.0/runtimes/mfp/applications/my.test.application/ios/0.0.1/descriptor`
    
    例如，可将此 URL 与诸如 curl 等工具结合使用：`curl -user admin:admin http://[...]/ios/0.0.1/descriptor > desc.json`。
    
    <br/>
    根据您的服务器配置更改 URL 的以下元素：
     * **9080** 是开发期间 {{ site.data.keys.mf_server }} 的缺省 HTTP 端口。
     * **mfpadmin** 是管理服务的缺省上下文根。 

    有关 REST API 的信息，请参阅 {{ site.data.keys.mf_server }} 管理服务的 REST API。
     * 使用 **mfpadm** 下载应用程序描述符。

       运行 {{ site.data.keys.mf_server }} 安装程序时，将安装 **mfpadm** 程序。可以从 **product\_install\_dir/shortcuts/** 目录启动它，其中 **product\_install\_dir** 指示 {{ site.data.keys.mf_server }} 的安装目录。
    
       以下示例将创建密码文件（**mfpadm** 命令所需），然后下载应用程序标识为 **my.test.application** 的应用程序、**ios** 平台以及 **0.0.1** 版本的应用程序描述符。所提供的 URL 是开发期间 {{ site.data.keys.mf_server }} 的 HTTPS URL。
    
       ```bash
       echo password=admin > password.txt
       mfpadm --url https://localhost:9443/mfpadmin --secure false --user admin \ --passwordfile password.txt \ app version mfp my.test.application ios 0.0.1 get descriptor > desc.json
       rm password.txt
       ```
    
       根据您的服务器配置更改命令行的以下元素：
        * **9443** 是开发中 {{ site.data.keys.mf_server }} 的缺省 HTTPS 端口。
        * **mfpadmin** 是管理服务的缺省上下文根。 
        * --secure false 指示接受服务器的 SSL 证书，即使是自签名证书或是为不同于 URL 中使用的服务器主机名的其他主机名创建的证书也是如此。

       有关 **mfpadm** 程序的更多信息，请参阅[通过命令行管理 {{ site.data.keys.product_adj }} 应用程序](../using-cli)。
    
3. 将应用程序描述符上载到新服务器以注册应用程序或更新其配置。可以使用 REST API 或 **mfpadm** 来上载。
   * 要使用 REST API 上载应用程序描述符，请使用[应用程序 (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_post.html?view=kc#Application--POST-) REST API。
    
     以下 URL 将应用程序描述符上载到 mfp 运行时。您可发送 POST 请求，并且有效内容为 JSON 应用程序描述符。在此示例中，调用了在本地计算机上运行运行且 HTTP 端口设置为 9081 的服务器。
    
     ```bash
     http://localhost:9081/mfpadmin/management-apis/2.0/runtimes/mfp/applications/
     ```
    
     例如，可将此 URL 与诸如 curl 等工具结合使用。
    
     ```bash
     curl -H "Content-Type: application/json" -X POST -d @desc.json -u admin:admin \ http://localhost:9081/mfpadmin/management-apis/2.0/runtimes/mfp/applications/
     ```    
    
   * 使用 mfpadm 上载应用程序描述符。

     以下示例将创建密码文件（mfpadm 命令所需），然后上载应用程序标识为 my.test.application 的应用程序、ios 平台以及 0.0.1 版本的应用程序描述符。所提供的 URL 为本地计算机上运行但 HTTPS 端口设置为 9444 的服务器的 HTTPS URL，并用于名为 mfp 的运行时。

     ```bash
     echo password=admin > password.txt
     mfpadm --url https://localhost:9444/mfpadmin --secure false --user admin \ --passwordfile password.txt \ deploy app mfp desc.json 
     rm password.txt
     ```

### 使用 REST API 传输服务器端工件
{: #transferring-server-side-artifacts-by-using-the-rest-api }
不管您是什么角色，都可以出于备份或复用目的使用 {{ site.data.keys.mf_server }}管理服务来导出应用程序、适配器和资源。作为管理员或部署者，您还可以将导出归档部署到不同的服务器。无需访问应用程序代码，但必须为目标服务器构建客户端应用程序。

#### 开始之前
{: #before-you-begin-2 }
为目标服务器构建客户端应用程序。有关更多信息，请参阅[为测试或生产环境构建应用程序](#building-an-application-for-a-test-or-production-environment)。

导出 API 将检索运行时 .zip 归档形式的选定工件。使用部署 API 复用归档的内容。

> **要点：**请仔细考虑您的用例：  
>  
> * 导出文件包含应用程序真实性数据。该数据特定于移动应用程序的构建。移动应用程序包含服务器的 URL 及其运行时名称。因此，
如果希望使用另一个服务器或另一个运行时，则必须重新构建应用程序。仅传输导出的应用程序文件不可行。
> * 某些工件因服务器而异。推送凭证的操作也有所不同，具体取决于您是处于开发环境还是生产环境。
> * 在某些情况下（并非所有情况），可以传输应用程序运行时配置（包含活动/禁用状态和日志概要文件）。
> * 在某些情况下可能无法传输 Web 资源，例如，在重新构建应用程序以使用新服务器时。

* 要为一个适配器或所有适配器导出所有资源或选定的资源子集，请使用[导出适配器资源 (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_export_adapter_resources_get.html?view=kc) 或[导出适配器 (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_export_adapters_get.html?view=kc) API。
* 要在特定应用程序环境（如 Android 或 iOS）下导出所有资源，即所有版本以及针对该环境的版本的所有资源，请使用[导出应用程序环境 (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_export_application_environment_get.html?view=kc) API。
* 要导出特定应用程序版本（例如，V1.0 或 V2.0 的 Android 应用程序）的所有资源，请使用[导出应用程序环境资源 (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_export_application_environment_resources_get.html?view=kc) API。
* 要导出运行时的特定应用程序或所有应用程序，请使用[导出应用程序 (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_export_applications_get.html?view=kc) 或[导出应用程序资源 (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_export_application_resources_get.html?view=kc) API。**注：**不会在应用程序资源中导出用于推送通知的凭证。
* 要导出适配器内容、描述符、许可证配置、内容、用户配置、密钥库以及应用程序的 Web 资源，请使用[导出资源 (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_export_resources_get.html?view=kc#Export-resources--GET-) API。
* 要导出运行时的所有资源或选定资源，请使用[导出运行时资源 (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_export_runtime_resources_get.html?view=kc) API。例如，您可以使用此常规的 curl 命令来检索 .zip 文件形式的所有资源。

  ```bash
  curl -X GET -u admin:admin -o exported.zip
  "http://localhost:9080/worklightadmin/management-apis/2.0/runtimes/mfp/export/all"
  ```
    
* 要部署包含诸如适配器、应用程序、许可证配置、密钥库、Web 资源之类 Web 应用程序资源的归档，请使用[部署 (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_deploy_post.html?view=kc) API。例如，您可以使用此 curl 命令部署包含工件的现有 .zip 文件。

  ```bash
  curl -X POST -u admin:admin -F
  file=@/Users/john_doe/Downloads/export_applications_adf_ios_2.zip
  "http://localhost:9080/mfpadmin/management-apis/2.0/runtimes/mfp/deploy/multi"
  ```

* 要部署应用程序真实性数据，请使用[部署应用程序真实性数据 (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_deploy_application_authenticity_data_post.html?view=kc) API。
* 要部署应用程序的 Web 资源，请使用[部署 Web 资源 (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_deploy_a_web_resource_post.html?view=kc) API。

如果将导出归档部署到同一个运行时，那么应用程序或版本不一定会恢复，因为其已经导出。也就是说，重新部署不会除去后续所作的修改。然而，如果在导出与重新部署操作之间修改了某些应用程序资源，那么仅会重新部署导出归档中包含的资源（以其原始状态）。例如，如果要导出不含真实性数据的应用程序，可上载真实性数据，然后导入初始归档，此时真实性数据将不会被擦除。

### 从
{{ site.data.keys.mf_console }} 导出和导入应用程序和适配器
{: #exporting-and-importing-applications-and-adapters-from-the-mobilefirst-operations-console }
在某些情况下，您可以从控制台导出应用程序或其某一版本，并在以后将其导入同一服务器或不同服务器上的另一运行时。您还可以导出并重新导入适配器。此功能可用来复用或备份。

如果
您被授予 **mfpadmin** 管理员角色和
**mfpdeployer** 部署者角色，则可以导出应用程序的某
一版本或所有版本。应用程序或版本导出为 .zip 压缩文件，该文件保存了应用程序标识、描述符、真实性数据以及 Web 资源。您可以在以后导入归档，以将应用程序或版本重新部署到同一服务器或不同服务器上的另一运行时中。

> **要点：**请仔细考虑您的用例：  
> 
> * 导出文件包含应用程序真实性数据。该数据特定于移动应用程序的构建。移动应用程序包含服务器的 URL 及其运行时名称。因此，如果希望使用另一个服务器或另一个运行时，则必须重新构建应用程序。仅传输导出的应用程序文件不可行。
> * 某些工件因服务器而异。推送凭证的操作也有所不同，具体取决于您是处于开发环境还是生产环境。
> * 在某些情况下（并非所有情况），可以传输应用程序运行时配置（包含活动/禁用状态和日志概要文件）。
> * 在某些情况下可能无法传输 Web 资源，例如，在重新构建应用程序以使用新服务器时。

还可以使用 REST API 或 mfpadm 工具来传输应用程序描述符。有关更多信息，请参阅[使用管理服务传输应用程序配置](#transferring-an-application-configuration-with-the-administration-service)。

1. 从导航侧边栏中选择应用程序或应用程序版本，或者适配器。
2. 选择**操作 → 导出应用程序**或**导出版本**或**导出适配器**。

    系统将提示您保存封装了导出资源的 .zip 归档文件。对话框的外观取决于您的浏览器，目标文件夹取决于浏览器设置。

3. 保存归档文件。

    归档文件名包含应用程序或适配器的名称和版本（例如
**export_applications_com.sample.zip**）。

4. 要复用现有导出归档，请选择**操作 → 导入应用程序**或**导入版本**，浏览至归档，然后单击**部署**。

主控制台框架将显示已导入应用程序或适配器的详细信息。

如果要导入到相同的运行时，那么应用程序或版本不一定会恢复，因为其已经导出。也就是说，导入时重新部署不会除去后续所作的修改。相反，如果导入时，在导出与重新部署操作之间修改了某些应用程序资源，那么仅会重新部署导出归档中包含的资源（以其原始状态）。例如，如果要导出不含真实性数据的应用程序，可上载真实性数据，然后导入初始归档，此时真实性数据将不会被擦除。

## 在生产环境中更新 {{ site.data.keys.product_adj }} 应用程序
{: #updating-mobilefirst-apps-in-production }
如果 {{ site.data.keys.product_adj }} 应用程序已存在于生产环境、Application Center 或应用商店中，那么在升级这些应用程序时，需要遵循一般准则。

升级应用程序时，可以部署新应用程序版本并使旧版本继续工作，或者部署新应用程序版本并阻止旧版本。对于使用 Apache Cordova 开发的应用程序，还可以考虑仅更新 Web 资源。

### 部署新的应用程序版本并使旧版本保持工作
{: #deploying-a-new-app-version-and-leaving-the-old-version-working }
在您引入新功能或修改本机代码时，最常使用的升级路径就是发布新版本的应用程序。请考虑以下步骤：

1. 递增应用程序版本号。
2. 构建并测试应用程序。有关更多信息，请参阅[为测试或生产环境构建应用程序](#building-an-application-for-a-test-or-production-environment)。
3. 向 {{ site.data.keys.mf_server }} 注册此应用程序，并对其进行配置。
4. 将新的 .apk、.ipa、.appx 或 .xap 文件提交到各自的应用商店。
5. 等待评审和批准，并等待应用程序可用。
6. 可选 - 向旧版本的用户发送通知消息，宣布新版本。请参阅[显示管理员消息](../using-console/#displaying-an-administrator-message)和[定义多种语言的管理员消息](../using-console/#defining-administrator-messages-in-multiple-languages)。


### 部署新的应用程序版本并阻止旧版本
{: #deploying-a-new-app-version-and-blocking-the-old-version }
在您希望强制用户升级到新版本并阻止其访问旧版本时，使用此升级路径。请考虑以下步骤：

1. 可选 - 向旧版本的用户发送通知消息，宣布数天内将进行强制更新。请参阅[显示管理员消息](../using-console/#displaying-an-administrator-message)和[定义多种语言的管理员消息](../using-console/#defining-administrator-messages-in-multiple-languages)。
2. 递增应用程序版本号。
3. 构建并测试应用程序。有关更多信息，请参阅[为测试或生产环境构建应用程序](#building-an-application-for-a-test-or-production-environment)。
4. 向 {{ site.data.keys.mf_server }} 注册此应用程序，并对其进行配置。
5. 将新的 .apk、.ipa、.appx 或 .xap 文件提交到各自的应用商店。
6. 等待评审和批准，并等待应用程序可用。
7. 复制指向新应用程序版本的链接。
8. 在 {{ site.data.keys.mf_console }} 中阻止应用程序的旧版本，提供一条消息和指向新版本的链接。请参阅[远程禁用应用程序对受保护资源的访问权](../using-console/#remotely-disabling-application-access-to-protected-resources)。

> **注：**如果您禁用旧应用程序，那么它就不能再与 {{ site.data.keys.mf_server }} 通信。用户仍然可以启动应用程序并脱机使用，除非您在应用程序启动时强制进行服务器连接。
### 直接更新（无本机代码更改）
{: #direct-update-no-native-code-changes }
直接更新是一种强制升级机制，用于将快速修订部署到生产应用程序。如果您将应用程序重新部署到 {{ site.data.keys.mf_server }} 而不更改其版本，{{ site.data.keys.mf_server }} 会在用户连接到服务器时直接将更新的 Web 资源推送到设备。它不会推送更新的本机代码。在您考虑直接更新时，要记住的事项包括：

1. 直接更新不会更新应用程序版本。该应用程序保持在同一版本上，但是具有不同的 Web 资源集合。
如果用途不当，未更改的版本号会导致混淆。
2. 直接更新也不会经过应用商店评审过程，因为它在技术上不是新的发行版。这不应该被滥用，因为如果您部署绕过供应商评审的全新版本的应用程序，那么这些供应商会感到不满。
您有责任阅读每家商店的使用协议，并加以遵守。直接更新最好用于修订无法等待数天的紧急问题。
3. 直接更新被视为安全性机制，因此它是强制的，而不是可选的。在启动直接更新时，所有用户都必须更新其应用程序才可以使用该程序。
4. 如果使用不同于初始部署所用版本的另一版本 {{ site.data.keys.product }} 编译（构建）应用程序，那么将无法进行直接更新。

> **注：**使用 Test Flight 或 iTunes Connect 进行应用商店 iOS 应用程序的提交/验证时生成的归档/IPA 文件可能会导致运行时崩溃/失败，请阅读博客 [Preparing iOS apps for App Store submission in {{ site.data.keys.product }}](https://mobilefirstplatform.ibmcloud.com/blog/2016/10/17/prepare-ios-apps-for-app-store-submission/)，以了解更多信息。
