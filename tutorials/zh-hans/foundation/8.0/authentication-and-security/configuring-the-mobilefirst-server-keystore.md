---
layout: tutorial
title: 配置 MobileFirst Server 密钥存储库
breadcrumb_title: 配置服务器密钥存储库
weight: 14
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
密钥库是安全密钥和证书的存储库，用于验证和认证网络事务中所涉及各方的有效性。 {{ site.data.keys.mf_server }} 密钥库定义了 {{ site.data.keys.mf_server }} 实例的身份，并用于以数字方式签署 OAuth 令牌和直接更新包。 此外，在适配器使用相互 HTTPS (SSL) 认证与后端服务器进行通信时，密钥库用于验证 {{ site.data.keys.mf_server }} 实例的 SSL 客户机身份。

对于生产级安全性，在开发到生产过程中，管理员必须配置 {{ site.data.keys.mf_server }} 来使用用户定义的密钥库。 缺省 {{ site.data.keys.mf_server }} 密钥库规定为仅在开发过程中使用。

### 注释
{: #notes }
* 要使用密钥库验证直接更新包的真实性，请将应用程序与密钥库中定义的 {{ site.data.keys.mf_server }} 身份的公用密钥静态绑定。 请参阅[在客户端实施安全直接更新](../../application-development/direct-update)。
* 应慎重考虑在生产后重新配置 {{ site.data.keys.mf_server }} 密钥库。 更改配置会产生以下潜在影响：
    * 客户机可能需要获得一个新的 OAuth 令牌来取代使用先前密钥库签署的令牌。 在大多数情况下，这一过程对于应用程序是透明的。
    * 如果客户机应用程序绑定到与新密钥库配置中的 {{ site.data.keys.mf_server }} 身份不匹配的公用密钥，那么直接更新将失败。 要继续获取更新，请将应用程序与新的公用密钥绑定，并重新发布此应用程序。 或者，再次更改密钥库配置，以便与应用程序绑定的公用密钥相匹配。 请参阅[在客户端实施安全直接更新](../../application-development/direct-update)。
    *  对于相互 SSL 认证，如果在新的密钥库中找不到适配器中配置的 SSL 客户机身份别名和密码，或者其与 SSL 证书不匹配，那么 SSL 认证将失败。 请参阅以下过程步骤 2 中的适配器配置信息。

## 设置
{: #setup }
1. 使用包含密钥对（用于定义 {{ site.data.keys.mf_server }} 的身份）的别名创建 Java 密钥库 (JKS) 或 PKCS 12 密钥库文件。 如果您已有相应的密钥库文件，请跳至下一步。

   > **注：**别名密钥对算法类型必须为 RSA。 以下指示信息说明在使用 **keytool** 实用程序时，如何将算法类型设置为 RSA。

   您可以使用第三方工具来创建密钥库文件。 例如，您可以通过运行 Java **keytool** 实用程序并使用以下命令来生成 JKS 密钥库文件（其中，`<keystore name>` 是密钥库的名称，`<alias name>` 是您选择的别名）：

   ```bash
   keytool -keystore <keystore name> -genkey -alias <alias name> -keylag RSA
   ```

   以下样本命令将生成别名为 **my_alias** 的 `my_company.keystore` JKS 文件：

   ```bash
   keytool -keystore my_company.keystore -genkey -alias my_alias -keyalg RSA
   ```

   实用程序将提示您提供不同的输入参数，包括密钥库文件和别名的密码。

   > **注：**必须设置 `-keyalg RSA` 选项，以将生成的密钥算法类型设置为 RSA，而不是缺省的 DSA。

   要将密钥库用于适配器与后端服务器之间的相互 SSL 认证，也要将 {{ site.data.keys.product }} SSL 客户机身份别名添加到密钥库。 您可以使用通过 {{ site.data.keys.mf_server }} 身份别名创建密钥库文件所用的相同方法来执行此操作，但是改为提供 SSL 客户机身份的别名和密码。

2. 配置 {{ site.data.keys.mf_server }} 以使用密钥库：
   执行以下步骤，配置 {{ site.data.keys.mf_server }} 以使用密钥库：

      * **Javascript 适配器**
        在 {{ site.data.keys.mf_console }} 导航侧边栏中，选择**运行时设置**，然后选择**密钥库**选项卡。遵循此选项卡上的指示信息来配置用户定义的 {{ site.data.keys.mf_server }} 密钥库。 相关步骤包括上传密钥库文件，指明其类型，以及提供密钥库密码、{{ site.data.keys.mf_server }} 身份别名名称和别名密码。成功配置后，**状态**将更改为*用户定义*，否则将显示错误并且状态仍为*缺省*。
        在 `<connectionPolicy>` 元素的 `<sslCertificateAlias>` 和 `<sslCertificatePassword>` 子元素内，在相关适配器的描述符文件中配置 SSL 客户机身份别名（如使用）及其密码。 请参阅 [HTTP 适配器 connectionPolicy 元素](../../adapters/javascript-adapters/js-http-adapter/#the-xml-file)。

      * **Java 适配器**
        要为 Java 适配器配置相互 SSL 认证，那么必须更新服务器的密钥库。可以通过执行以下步骤来实现：

        * 将密钥库文件复制到 `<ServerInstallation>/mfp-server/usr/servers/mfp/resources/security`。

        * 编辑 `server.xml` 文件 `<ServerInstallation>/mfp-server/usr/servers/mfp/server.xml`。

        * 使用正确的文件名、密码和类型更新密钥库配置：`<keyStore id=“defaultKeyStore” location=<Keystore name> password=<Keystore password> type=<Keystore type> />`

如果要在 Bluemix 上使用 {{ site.data.keys.mf_bm_short}} 服务进行部署，可以在部署服务器之前在**高级设置**下上传密钥库文件。
