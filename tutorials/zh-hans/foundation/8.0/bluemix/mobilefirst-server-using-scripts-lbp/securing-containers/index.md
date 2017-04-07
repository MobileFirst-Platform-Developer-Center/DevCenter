---
layout: tutorial
title: 保护 MobilFirst Server
relevantTo: [ios,android,windows,javascript]
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
以下是保护 {{ site.data.keys.mf_server }} 实例时可遵循的几种方法。

#### 跳转至
{: #jump-to }
* [配置应用程序传输安全性 (ATS)](#configuring-app-transport-security-ats)
* [容器的 LDAP 配置](#ldap-configuration-for-containers)

## 配置应用程序传输安全性 (ATS)
{: #configuring-app-transport-security-ats }
ATS 配置不会影响从其他非 iOS 移动操作系统连接的应用程序。其他移动操作系统不要求服务器在 ATS 安全级别上进行通信，但是仍可以与 ATS 配置的服务器进行通信。在配置服务器之前，准备好已生成的证书。以下步骤假定密钥库文件 **ssl_cert.p12** 具有个人证书并且 **ca.crt** 是签名证书。

1. 将 **ssl_cert.p12** 文件复制到 **mfpf-server-libertyapp/usr/security/** 文件夹中。
2. 修改 **mfpf-server-libertyapp/usr/config/keystore.xml** 文件，使其类似于以下示例配置：

   ```xml
   <server>
        <featureManager>
            <feature>ssl-1.0</feature>
        </featureManager>
        <ssl id="defaultSSLConfig" sslProtocol="TLSv1.2" keyStoreRef="defaultKeyStore" enabledCiphers="TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384" />
        <keyStore id="defaultKeyStore" location="ssl_cert.p12" password="*****" type="PKCS12"/>
   </server>
   ```
    - **ssl-1.0** 添加为功能管理器中的功能，支持服务器使用 SSL 通信。
    - 在 ssl 标记中添加 **sslProtocol="TLSv1.2"**，以要求服务器仅在传输层安全性 (TLS) V1.2 协议上进行通信。可添加多个协议。
例如，添加 **sslProtocol="TLSv1+TLSv1.1+TLSv1.2"** 将确保服务器可在 TLS V1、V1.1 和 V1.2 上通信。（iOS 9 应用程序需要 TLS V1.2。）
    - 在 ssl 标记中添加 **enabledCiphers="TLS\_ECDHE\_ECDSA\_WITH\_AES\_256\_GCM\_SHA384"**，从而使服务器强制仅使用此密码进行通信。
    - **keyStore** 标记通知服务器使用依据上述需求创建的新证书。

以下特定密码需要 Java 密码术扩展 (JCE) 策略设置和其他 JVM 选项：

* TLS\_ECDHE\_ECDSA\_WITH\_AES\_256_GCM\_SHA384
* TLS\_ECDHE\_ECDSA\_WITH\_AES\_256\_CBC\_SHA384
* TLS\_ECDHE\_ECDSA\_WITH\_AES\_256\_CBC\_SHA
* TLS\_ECDHE\_RSA\_WITH\_AES\_256\_GCM\_SHA384
* TLS\_ECDHE\_RSA\_WITH\_AES\_256\_CBC\_SHA384

策略文件已安装在 Liberty for Java 运行时中，您无需再次将其添加到软件包，只需将以下 JVM 选项添加到 **mfpf-server-libertyapp/usr/env/jvm.options** 文件中即可：`Dcom.ibm.security.jurisdictionPolicyDir=/opt/ibm/wlp/usr/servers/worklight/resources/security/`。

仅对于开发阶段之目的，您可以通过向 info.plist 文件添加以下属性来禁用 ATS：

```xml
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
        <true/>
</dict>
```

## {{ site.data.keys.product_full }} 上的安全配置
{: #security-configuration-for-ibm-mobilefirst-foundation }
IBM MobileFirst Foundation 实例安全配置应包含加密密码，启用应用程序真实性检查以及保护对控制台的访问。

### 对密码进行加密
{: #encrypting-passwords }
以加密格式存储 {{ site.data.keys.mf_server }} 用户的密码。您可以使用 Liberty Profile 中提供的 securityUtility 命令以使用 XOR 或 AES 加密来编码密码。然后，可以将加密密码复制到 /usr/env/server.env 文件。请参阅“对 {{ site.data.keys.mf_server }} 中配置的用户角色的密码进行加密”以获取指示信息。

### 应用程序真实性验证
{: #application-authenticity-validation }
要避免未经授权的移动应用程序访问 {{ site.data.keys.mf_server }}， [ 请启用应用程序真实性安全性检查](../../../authentication-and-security/application-authenticity)。


### 保护后端连接的安全
{: #securing-a-connection-to-the-back-end }
如果在容器和本地后端系统之间需要安全连接，可以使用 Bluemix Secure
Gateway 服务。本文中提供配置详细信息：安全地从 IBM Bluemix 容器上的 MobileFirst 连接到本地后端。

#### 对 {{ site.data.keys.mf_server }} 中配置的用户角色的密码进行加密
{: #encrypting-passwords-for-user-roles-configured-in-mobilefirst-server }
可以对为 {{ site.data.keys.mf_server }} 配置的用户角色的密码进行加密。  
在 **package_root/mfpf-server-liberty-app/usr/env** 的 **server.env** 文件中配置密码。应以加密格式存储密码。

1. 您可以在 Liberty Profile 中使用 `securityUtility` 命令来编码密码。选择 XOR 或 AES 加密来编码密码。
2. 将已加密的密码复制到 **server.env** 文件。示例：`MFPF_ADMIN_PASSWORD={xor}PjsyNjE=`
3. 如果使用 AES 加密并且使用了自己的加密密钥代替缺省密钥，那么必须创建包含加密密钥的配置文件并将其添加到 **usr/config** 目录。在运行时期间，Liberty 服务器访问文件以解密密码。配置文件必须具有 .xml 文件扩展名且类似于以下格式：

```bash
<?xml version="1.0" encoding="UTF-8"?>
<server>
    <variable name="wlp.password.encryption.key" value="yourKey" />
</server>
```

#### 限制访问容器上运行的控制台
{: #restricting-access-to-the-consoles-running-on-containers }
您可以通过创建并部署信任关联拦截器 (TAI) 来拦截针对控制台的请求，来限制生产环境中对 MobileFirst Operations Console 和 MobileFirst Analytics Console 的访问。

TAI 可实施特定于用户的过滤逻辑，决定是将请求转发到控制台还是需要核准。此过滤方法可使您灵活地添加自己的认证机制（如果需要）。

另请参阅：[针对 Liberty Profile 开发定制 TAI](https://www.ibm.com/support/knowledgecenter/SSD28V_8.5.5/com.ibm.websphere.wlp.core.doc/ae/twlp_dev_custom_tai.html?view=embed)

1. 创建实施安全性机制以控制对 MobileFirst Operations Console 的访问的定制 TAI。以下定制 TAI 示例使用入局请求的 IP 地址来验证是否提供 MobileFirst Operations Console 的访问。

   ```java
   package com.ibm.mfpconsole.interceptor;
   import java.util.Properties;

   import javax.servlet.http.HttpServletRequest;
   import javax.servlet.http.HttpServletResponse;

   import com.ibm.websphere.security.WebTrustAssociationException;
   import com.ibm.websphere.security.WebTrustAssociationFailedException;
   import com.ibm.wsspi.security.tai.TAIResult;
   import com.ibm.wsspi.security.tai.TrustAssociationInterceptor;

   public class MFPConsoleTAI implements TrustAssociationInterceptor {
String allowedIP =null;
public MFPConsoleTAI() {
super();
       }

    /*
     * @see com.ibm.wsspi.security.tai.TrustAssociationInterceptor#isTargetInterceptor
     * (javax.servlet.http.HttpServletRequest)
     */
       public boolean isTargetInterceptor(HttpServletRequest req)
                      throws WebTrustAssociationException {
          //Add logic to determine whether to intercept this request
boolean interceptMFPConsoleRequest = false;
    	   String requestURI = req.getRequestURI();

    	   if(requestURI.contains("mfpconsole")) {
		   interceptMFPConsoleRequest = true;
    	   }

    	   return interceptMFPConsoleRequest;
       }

    /*
     * @see com.ibm.wsspi.security.tai.TrustAssociationInterceptor#negotiateValidateandEstablishTrust
     * (javax.servlet.http.HttpServletRequest,javax.servlet.http.HttpServletResponse)
     */

    public TAIResult negotiateValidateandEstablishTrust(HttpServletRequest request,
                    HttpServletResponse resp) throws WebTrustAssociationFailedException {
        // Add logic to authenticate a request and return a TAI result.
String tai_user = "MFPConsoleCheck";
if(allowedIP != null) {
String ipAddress = request.getHeader("X-FORWARDED-FOR");
            	if (ipAddress == null) {
            	  ipAddress = request.getRemoteAddr();
            	}

            	if(checkIPMatch(ipAddress, allowedIP)) {
TAIResult.create(HttpServletResponse.SC_OK, tai_user);
            	}
            	else {
            		TAIResult.create(HttpServletResponse.SC_FORBIDDEN, tai_user);
            	}

            }
            return TAIResult.create(HttpServletResponse.SC_OK, tai_user);
        }

       private static boolean checkIPMatch(String ipAddress, String pattern) {
if (pattern.equals("*.*.*.*") || pattern.equals("*"))
return true;
String[] mask = pattern.split("\\.");
    	   String[] ip_address = ipAddress.split("\\.");

	   for (int i = 0; i < mask.length; i++)
    	   {
    		   if (mask[i].equals("*") || mask[i].equals(ip_address[i]))
    		      continue;
    		   else
    		      return false;
    		}
    		return true;
       }

    /*
     * @see com.ibm.wsspi.security.tai.TrustAssociationInterceptor#initialize(java.util.Properties)
     */

    public int initialize(Properties properties)
                    throws WebTrustAssociationFailedException {

    	if(properties != null) {
if(properties.containsKey("allowedIPs")) {
allowedIP = properties.getProperty("allowedIPs");
        		}
        	}
            return 0;
        }

    /*
     * @see com.ibm.wsspi.security.tai.TrustAssociationInterceptor#getVersion()
     */

    public String getVersion() {
return "1.0";
        }

    /*
     * @see com.ibm.wsspi.security.tai.TrustAssociationInterceptor#getType()
     */
        public String getType() {
            return this.getClass().getName();
        }

    /*
     * @see com.ibm.wsspi.security.tai.TrustAssociationInterceptor#cleanup()
     */

    public void cleanup()
{}
   }
```
2. 将定制 TAI 实施导出到 .jar 文件并将其放置在适合的 **env** 文件夹 (**mfpf-server-libertyapp/usr/env**) 中。
3. 创建包含 TAI 拦截器的详细信息的 XML 配置文件（请参阅步骤 1 中提供的 TAI 配置示例代码），然后将您的 .xml 文件添加到适合的文件夹 (**mfpf-server-libertyapp/usr/config**) 中。您的 .xml 文件应当类似于以下示例。**提示：请确保更新类名和属性以反映您的实施**。

    ```xml
    <?xml version="1.0" encoding="UTF-8"?>
     <server description="new server">
       <featureManager>
         <feature>appSecurity-2.0</feature>
       </featureManager>

      <trustAssociation id="MFPConsoleTAI" invokeForUnprotectedURI="true"
                       failOverToAppAuthType="false">
         <interceptors id="MFPConsoleTAI" enabled="true"
                       className="com.ibm.mfpconsole.interceptor.MFPConsoleTAI"
                       invokeBeforeSSO="true" invokeAfterSSO="false" libraryRef="MFPConsoleTAI">
                       <properties allowedIPs="9.182.149.*"/>
         </interceptors>
       </trustAssociation>

        <library id="MFPConsoleTAI">
          <fileset dir="${server.config.dir}" includes="MFPConsoleTAI.jar"/>
        </library>
    </server>
    ```
4. 重新部署服务器。现在，仅在满足配置的 TAI 安全性机制时才可访问 MobileFirst Operations Console。


## 容器的 LDAP 配置
{: #ldap-configuration-for-containers}

可以配置 IBM MobileFirst Foundation 以安全地连接到外部 LDAP 存储库。

可针对以下目的使用外部 LDAP 注册表：

* 通过外部 LDAP 注册表配置 MobileFirst 管理安全性。
* 配置 MobileFirst 移动应用程序以使用外部 LDAP 注册表。

### 通过 LDAP 配置管理安全性
{: #configuring-administration-security-with-ldap }
通过外部 LDAP 注册表配置 MobileFirst 管理安全性。  
配置过程包含以下步骤：

* 设置和配置 LDAP 存储库
* 更改注册表文件 (registry.xml)
* 配置安全网关以连接到本地 LDAP 存储库和容器。（对于本步骤，现有应用程序应位于 Bluemix 上。）

#### LDAP 存储库
{: #ldap-repository }
在 LDAP 存储库中创建用户和组。对于组，将根据用户成员资格来实施授权。

#### 注册表文件
{: #registry-file }
1. 打开 **registry.xml** 并找到 `basicRegistry` 元素。将 `basicRegistry` 元素替换为类似于以下片段的代码：


   ```xml
   <ldapRegistry
        id="ldap"
        host="1.234.567.8910" port="1234" ignoreCase="true"
        baseDN="dc=worklight,dc=com"
        ldapType="Custom"
        sslEnabled="false"
        bindDN="uid=admin,ou=system"
        bindPassword="secret">
        <customFilters userFilter="(&amp;(uid=%v)(objectclass=inetOrgPerson))"
        groupFilter="(&amp;(member=uid=%v)(objectclass=groupOfNames))"
        userIdMap="*:uid"
        groupIdMap="*:cn"
        groupMemberIdMap="groupOfNames:member"/>
   </ldapRegistry>
   ```

    条目 | 描述    
    --- | ---
    `host` 和 `port` | 您的本地 LDAP 服务器的主机名（IP 地址）和端口号。`baseDN` | LDAP 中捕获有关特定组织的所有详细信息的域名 (DN)。`bindDN="uid=admin,ou=system"
` | LDAP 服务器的绑定详细信息。例如，Apache 目录服务的缺省值将为 `uid=admin,ou=system`。`bindPassword="secret"	` | LDAP 服务器的绑定密码。例如，Apache 目录服务的缺省值为 `secret`。`<customFilters userFilter="(&amp;(uid=%v)(objectclass=inetOrgPerson))" groupFilter="(&amp;(member=uid=%v)(objectclass=groupOfNames))" userIdMap="*:uid" groupIdMap="*:cn" groupMemberIdMap="groupOfNames:member"/>	` | 用于在认证和授权期间查询目录服务（如 Apache）的定制过滤器。        
2. 确保为 `appSecurity-2.0` 和 `ldapRegistry-3.0` 启用以下功能：

   ```xml
   <featureManager>
        <feature>appSecurity-2.0</feature>
        <feature>ldapRegistry-3.0</feature>
   </featureManager>
   ```

   有关配置各种 LDAP 服务器存储库的详细信息，请参阅 [WebSphere Application Server Liberty Knowledge Center](http://www-01.ibm.com/support/knowledgecenter/was_beta_liberty/com.ibm.websphere.wlp.nd.multiplatform.doc/ae/twlp_sec_ldap.html)。

#### 安全网关
{: #secure-gateway }
要配置到 LDAP 服务器的安全网关连接，必须在 Bluemix 上创建安全网关服务实例，然后获取 LDAP 注册表的 IP 信息。您需要本地 LDAP 主机名和端口号才能完成此任务。

1. 登录到 Bluemix 并浏览至**目录，类别 > 集成**，然后单击**安全网关**。
2. 在“添加服务”下，选择应用程序，然后单击**创建**。这样就将服务绑定到了应用程序。
3. 转至应用程序的 Bluemix 仪表板，单击**安全网关**服务实例，然后单击**添加网关**。
4. 命名网关并单击**添加目标**，然后输入本地 LDAP 服务器的名称、IP 地址和端口。
5. 按照提示完成连接。要查看已初始化的目标，请导航至 LDAP 网关服务的“目标”屏幕。

6. 要获取您所需的主机和端口信息，请单击 LDAP 网关服务实例（位于“安全网关”仪表板上）上的“信息”图标。
显示的详细信息是本地 LDAP 服务器的别名。

7. 捕获**目标标识**和**云主机：端口**值。转至 registry.xml 文件并添加这些值，取代任何现有值。在 registry.xml 文件中查看以下更新代码片段示例：

```xml
<ldapRegistry
    id="ldap"
    host="cap-sg-prd-5.integration.ibmcloud.com" port="15163" ignoreCase="true"
    baseDN="dc=worklight,dc=com"
    ldapType="Custom"
    sslEnabled="false"
    bindDN="uid=admin,ou=system"
    bindPassword="secret">
    <customFilters userFilter="(&amp;(uid=%v)(objectclass=inetOrgPerson))"
    groupFilter="(&amp;(member=uid=%v)(objectclass=groupOfNames))"
    userIdMap="*:uid"
    groupIdMap="*:cn"
    groupMemberIdMap="groupOfNames:member"/>
</ldapRegistry>
```

### 配置应用程序以使用 LDAP
{: #configuring-apps-to-work-with-ldap }
配置 MobileFirst 移动应用程序以使用外部 LDAP 注册表。  
配置流程包含以下步骤：配置安全网关以连接到本地 LDAP 存储库和容器。（对于本步骤，现有应用程序应位于 Bluemix 上。）

要配置到 LDAP 服务器的安全网关连接，必须在 Bluemix 上创建安全网关服务实例，然后获取 LDAP 注册表的 IP 信息。您需要本地 LDAP 主机名和端口号才能完成此步骤。

1. 登录到 Bluemix 并浏览至**目录，类别 > 集成**，然后单击**安全网关**。
2. 在“添加服务”下，选择应用程序，然后单击**创建**。这样就将服务绑定到了应用程序。
3. 转至应用程序的 Bluemix 仪表板，单击**安全网关**服务实例，然后单击**添加网关**。
4. 命名网关并单击**添加目标**，然后输入本地 LDAP 服务器的名称、IP 地址和端口。
5. 按照提示完成连接。要查看已初始化的目标，请导航至 LDAP 网关服务的“目标”屏幕。

6. 要获取您所需的主机和端口信息，请单击 LDAP 网关服务实例（位于“安全网关”仪表板上）上的“信息”图标。
显示的详细信息是本地 LDAP 服务器的别名。

7. 捕获**目标标识**和**云主机：端口**值。针对 LDAP 登录模块提供这些值。

**结果**  
这样将在 Bluemix 上的 MobileFirst 应用程序与本地 LDAP 服务器之间建立通信。通过本地 LDAP 服务器验证 Bluemix 应用程序的认证和授权。
