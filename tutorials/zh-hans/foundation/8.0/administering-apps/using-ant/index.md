---
layout: tutorial
title: 通过 Ant 管理应用程序
breadcrumb_title: 使用 Ant 管理
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
可以通过 **mfpadm** Ant 任务管理 {{ site.data.keys.product_adj }} 应用程序。

#### 跳转至
{: #jump-to }

* [与其他设备比较](#comparison-with-other-facilities)
* [先决条件](#prerequisites)

## 与其他设备比较
{: #comparison-with-other-facilities }
可以通过以下方式对 {{ site.data.keys.product_full }} 执行管理操作：

* {{ site.data.keys.mf_console }}，属于交互式。
* **mfpadm** Ant 任务。
* **mfpadm** 程序。
* {{ site.data.keys.product_adj }} 管理 REST 服务。

**mfpadm** Ant 任务、**mfpadm** 程序和 REST 服务对于操作的自动执行或无人照管执行很有用，例如：

* 消除操作员在重复操作中引入的错误，或
* 在操作员正常工作时间以外操作，或
* 使用与测试或预生产服务器相同的设置来配置生产服务器。

相比 REST 服务，**mfpadm** Ant 任务和 **mfpadm** 程序更易于使用且具有更强的错误报告功能。
**mfpadm** Ant 任务相对于 mfpadm 程序的优势在于，它独立于平台，并且当与 Ant 的集成已经可用时，它更易于集成。

## 先决条件
{: #prerequisites }
**mfpadm** 工具可通过 {{ site.data.keys.mf_server }} 安装程序进行安装。在本页的其余部分中，**product\_install\_dir** 表示 {{ site.data.keys.mf_server }} 安装程序的安装目录。

运行 **mfpadm** 任务需要 Apache Ant。有关 ANT 的最低受支持版本的信息，请参阅“系统需求”。

为方便起见，{{ site.data.keys.mf_server }} 中包含了 Apache Ant 1.9.4。
在 **product\_install\_dir/shortcuts/** 目录中，提供了以下脚本。

* 针对 UNIX/Linux 的 ant
* 针对 Windows 的 ant.bat

这些脚本能够运行，这意味着不需要特定的环境变量。如果设置了环境变量 JAVA_HOME，那么脚本将接受该环境变量。

可以在安装 {{ site.data.keys.mf_server }} 的计算机以外的其他计算机上使用 **mfpadm** Ant 任务。

* 将文件 **product\_install\_dir/MobileFirstServer/mfp-ant-deployer.jar** 复制到该计算机上。
* 确保在此计算机上安装了受支持的 Apache Ant 版本和 Java 运行时环境。

要使用 **mfpadm** Ant 任务，请在 Ant 脚本中添加以下初始化命令：

```xml
<taskdef resource="com/ibm/mfp/ant/deployers/antlib.xml">
  <classpath>
    <pathelement location="product_install_dir/MobileFirstServer/mfp-ant-deployer.jar"/>
  </classpath>
</taskdef>
```

涉及同一 **mfp-ant-deployer.jar** 文件的其他初始化命令都是冗余的，因为由 **defaults.properties** 执行的初始化也由 antlib.xml 隐式执行。以下是冗余初始化命令的一个示例：


```xml
<taskdef resource="com/ibm/mfp/ant/defaults.properties">
  <classpath>
    <pathelement location="product_install_dir/MobileFirstServer/mfp-ant-deployer.jar"/>
  </classpath>
</taskdef>
```

有关运行 {{ site.data.keys.mf_server }} 安装程序的更多信息，请参阅[运行 IBM Installation Manager](../../installation-configuration/production/installation-manager/)。

#### 跳转至
{: #jump-to-1 }

* [调用 **mfpadm** Ant 任务](#calling-the-mfpadm-ant-task)
* [常规配置命令](#commands-for-general-configuration)
* [适配器命令](#commands-for-adapters)
* [应用程序命令](#commands-for-apps)
* [设备命令](#commands-for-devices)
* [故障诊断命令](#commands-for-troubleshooting)

### 调用 mfpadm Ant 任务
{: #calling-the-mfpadm-ant-task }
可以使用 **mfpadm** Ant 任务及其相关命令来管理 {{ site.data.keys.product_adj }} 应用程序。调用 **mfpadm** Ant 任务，如下所示：

```xml
<mfpadm url=... user=... password=...|passwordfile=... [secure=...]>
    some commands
</mfpadm>
```

#### 属性
{: #attributes }
**mfpadm** Ant 任务具有以下属性：

| 属性      | 描述 | 必需 | 缺省值 | 
|----------------|-------------|----------|---------|
| url	         | Administration Services 的 {{ site.data.keys.product_adj }} web 应用程序的基本 URL | 是	 | |
| secure	     | 是否避免存在安全风险的操作 | 否 | true |
| user	         | 用于访问 {{ site.data.keys.product_adj }} Administration Services 的用户名 | 是 | |
| password	     | 用户的密码 | 需要其中任一项 | |
| passwordfile   |	包含用户密码的文件 | 需要其中任一项 | |	 
| timeout	     | 整个 REST 服务访问超时，以秒为单位 | 否 | |
| connectTimeout |	建立网络连接超时，以秒为单位 | 否 | |	 
| socketTimeout  |	检测网络连接断开超时，以秒为单位 | 否 | |
| connectionRequestTimeout |	从连接请求池获取条目超时，以秒为单位 | 否 | |
| lockTimeout    |	获取锁定时超时 | 否 | |

**url**<br/>
基本 URL 最好使用 HTTPS 协议。例如，如果使用缺省端口和上下文根，请使用以下 URL。

* 对于 WebSphere Application Server：[https://server:9443/worklightadmin](https://server:9443/worklightadmin)
* 对于 Tomcat：[https://server:8443/worklightadmin](https://server:8443/worklightadmin)

**secure**<br/>
缺省值为 **true**。设置 **secure="false"** 可能会有以下影响：


* 用户和密码可能以一种不安全的方式（甚至可能通过未加密的 HTTP）传送。
* 接受服务器的 SSL 证书，即使是自签名证书或为不同于指定服务器主机名的其他主机名创建的证书也是如此。

**password**<br/>
在 Ant 脚本（通过 **password** 属性）或独立文件（通过 **passwordfile** 属性传递）中指定密码。密码是敏感信息，因此需要保护。
必须防止相同计算机上的其他用户知道此密码。为保护密码，在将密码输入文件之前，必须除去除您之外的其他用户对此文件的读许可权。例如，可以使用以下某个命令：

* 在 UNIX 上：`chmod 600 adminpassword.txt`
* 在 Windows 上：`cacls adminpassword.txt /P Administrators:F %USERDOMAIN%\%USERNAME%:F`

另外，您可能要想隐藏加密密码以防被他人偶尔瞥见。
要执行此操作，请使用 **mfpadm** config password 命令将模糊处理的密码存储在配置文件中。之后，可以将已模糊处理的密码复制并粘贴到 Ant 脚本或密码文件。

**mfpadm** 调用包含通过内部元素编码的命令。这些命令将按照列出的顺序执行。如果某个命令失败，那么将不会执行剩余命令，并且 **mfpadm** 调用将失败。

#### 元素
{: #elements }
可以在 **mfpadm** 调用中使用以下元素：

| 元素                       | 描述 | 计数 |
|-------------------------------|-------------|-------|
| show-info	                    | 显示用户和配置信息 | 0..∞ | 
| show-global-config	        | 显示全局配置信息 | 0..∞ | 
| show-diagnostics              | 显示诊断信息 | 0..∞ | 
| show-versions	                | 显示版本信息 | 0..∞ | 
| unlock	                    | 释放通用锁定 | 0..∞ | 
| list-runtimes	                | 列出运行时 | 0..∞ | 
| show-runtime      	        | 显示有关运行时的信息 | 0..∞ | 
| delete-runtime	            | 删除运行时 | 0..∞ | 
| show-user-config	            | 显示运行时的用户配置 | 0..∞ | 
| set-user-config	            | 指定运行时的用户配置 | 0..∞ | 
| show-confidential-clients	    | 显示运行时的保密客户机配置 | 0..∞ | 
| set-confidential-clients	    | 指定运行时的保密客户机配置 | 0..∞ | 
| set-confidential-clients-rule	| 指定运行时的保密客户机配置规则 | 0..∞ | 
| list-adapters	                | 列出适配器 | 0..∞ | 
| deploy-adapter	            | 部署适配器 | 0..∞ | 
| show-adapter	                | 显示有关适配器的信息 | 0..∞ | 
| delete-adapter	            | 删除适配器 | 0..∞ | 
| adapter	                    | 针对适配器的其他操作 | 0..∞ | 
| list-apps	                    | 列出应用程序 | 0..∞ | 
| deploy-app	                | 部署应用程序 | 0..∞ | 
| show-app	                    | 显示有关应用程序的信息 | 0..∞ | 
| delete-app	                | 删除应用程序 | 0..∞ | 
| show-app-version              | 显示有关应用程序版本的信息 | 0..∞ | 
| delete-app-version            | 删除应用程序的版本 | 0..∞ | 
| app	                        | 针对应用程序的其他操作 | 0..∞ | 
| app-version	                | 针对应用程序版本的其他操作 | 0..∞ | 
| list-devices	                | 列出设备 | 0..∞ | 
| remove-device	                | 除去设备 | 0..∞ | 
| device	                    | 针对设备的其他操作 | 0..∞ | 
| list-farm-members	            | 列出服务器场的成员 | 0..∞ | 
| remove-farm-member	        | 除去服务器场成员 | 0..∞ | 

#### XML 格式
{: #xml-format }
大部分命令的输出都是 XML 格式，特定命令（如 `<set-accessrule>`）的输入也是 XML 格式。您可以在 **product\_install\_dir/MobileFirstServer/mfpadm-schemas/** 目录中找到这些 XML 格式的 XML 模式。从服务器接收 XML 响应的命令将验证此响应是否符合特定的模式。
通过指定属性 **xmlvalidation="none"**，可以禁用此检查。 

#### 输出字符集
{: #output-character-set }
mfpadm Ant 任务的正常输出采用当前语言环境的编码格式进行编码。在 Windows 上，此编码格式即所谓的“ANSI 代码页”。影响如下所示：

* 此字符集外的字符将在输出时转换为问号。
* 输出发送至 Windows 命令提示符窗口 (cmd.exe) 时，非 ASCII 字符将无法正确显示，因为此类窗口假定字符采用所谓的“OEM 代码页”编码。

要解决此限制：

* 在除 Windows 之外的操作系统上，使用其编码为 UTF-8 的语言环境。此语言环境是 Red Hat Linux 和 macOS 上的缺省语言环境。其他多个操作系统采用 en_US.UTF-8 语言环境。
* 或者，使用属性 **output="some file name"** 来将 mfpadm 命令的输出重定向到某个文件。

### 常规配置命令
{: #commands-for-general-configuration }
在调用 **mfpadm** Ant 任务时，可以包含各种用于访问 IBM {{ site.data.keys.mf_server }} 或运行时全局配置的命令。

#### `show-global-config` 命令
{: #the-show-global-config-command }
`show-global-config` 显示可显示全局配置。它具有以下属性：

| 属性      | 描述 |	必需 | 缺省值 |
|----------------|-------------|-------------|---------|
| output	     | 输出文件的名称。  |	否	   | 不适用 |
| outputproperty | 输出的 Ant 属性名称。 | 否 | 不适用 |

**示例**  

```xml
<show-global-config/>
```

此命令基于[全局配置 (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_global_configuration_get.html?view=kc#Global-Configuration--GET-) REST 服务。

<br/>
#### `show-user-config` 命令
{: #the-show-user-config-command }
`<adapter>` 和 `<app-version>` 元素外的 `show-user-config` 命令可显示运行时的用户配置。它具有以下属性：

| 属性      | 描述 |	必需 | 缺省值 |
|----------------|-------------|-------------|---------|
| runtime	     | 运行时的名称。      | 是     |	不可用 |
| format	     | 指定输出格式。json 或 xml。 | 是 | 不可用       | 
| output	     | 用于存储输出的文件的名称。   | 否  | 不适用      | 
| outputproperty | 用于存储输出的 Ant 属性的名称。
  | 否 | 不适用 |

**示例**  

```xml
<show-user-config runtime="mfp" format="xml"/>
```

此命令基于[运行时配置 (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_runtime_configuration_get.html?view=kc#Runtime-Configuration--GET-) REST 服务。

<br/>
#### `set-user-config` 命令
{: #the-set-user-config-command }
位于 `<adapter>` 和 `<app-version>` 元素外部的 `set-user-config` 命令指定运行时的用户配置。它具有以下用于设置整个配置的属性。

| 属性      | 描述 |	必需 | 缺省值 |
|----------------|-------------|-------------|---------|
| runtime        | 运行时的名称。 | 是 | 不可用 | 
| file	         | 包含新配置的 JSON 或 XML 文件的名称。 | 是 | 不可用 | 

`set-user-config` 命令具有以下用于设置配置中单个属性 (property) 的属性 (attribute)。

| 属性      | 描述 |	必需 | 缺省值 |
|----------------|-------------|-------------|---------|
| runtime	     | 运行时的名称。 | 是 | 不可用 | 
| property	     | JSON 属性的名称。对于嵌套属性，请使用语法 prop1.prop2.....propN。对于 JSON 数组元素，请使用索引代替属性名称。 | 是 | 不可用 | 
| value	         | 属性的值。 | 是 | 不可用 |

**示例**  

```xml
<set-user-config runtime="mfp" file="myconfig.json"/>
```

```xml
<set-user-config runtime="mfp" property="timeout" value="240"/>
```

此命令基于[运行时配置 (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_runtime_configuration_put.html?view=kc#Runtime-configuration--PUT-) REST 服务。

<br/>
#### `show-confidential-clients` 命令
{: #the-show-confidential-clients-command }
`show-confidential-clients` 命令显示可以访问运行时的保密客户机的配置。有关保密客户机的更多信息，请参阅[保密客户机](../../authentication-and-security/confidential-clients)。此命令具有以下属性：

| 属性      | 描述 |	必需 | 缺省值 |
|----------------|-------------|-------------|---------|
| runtime        | 运行时的名称。 | 是 | 不可用 | 
| format         | 指定输出格式。json 或 xml。 | 是 | 不可用 | 
| output         | 用于存储输出的文件的名称。 | 否 | 不适用 | 
| outputproperty | 用于存储输出的 Ant 属性的名称。
 | 否 | 不适用 | 

**示例**  

```xml
<show-confidential-clients runtime="mfp" format="xml" output="clients.xml"/>
```

此命令基于[保密客户机 (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_confidential_clients_get.html?view=kc) REST 服务。

<br/>
#### `set-confidential-clients` 命令
{: #the-set-confidential-clients-command }
`set-confidential-clients` 命令指定可以访问运行时的保密客户机的配置。有关保密客户机的更多信息，请参阅[保密客户机](../../authentication-and-security/confidential-clients)。此命令具有以下属性：

| 属性      | 描述 |	必需 | 缺省值 |
|----------------|-------------|-------------|---------|
| runtime        | 运行时的名称。 | 是 | 不可用 | 
| file	         | 包含新配置的 JSON 或 XML 文件的名称。 | 是 | 不可用 | 

**示例**  

```xml
<set-confidential-clients runtime="mfp" file="clients.xml"/>
```

此命令基于[保密客户机 (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_confidential_clients_put.html?view=kc#Confidential-Clients--PUT-) REST 服务。

<br/>
#### `set-confidential-clients-rule` 命令
{: #the-set-confidential-clients-rule-command }
`set-confidential-clients-rule` 命令指定可以访问运行时的保密客户机的配置中的规则。有关保密客户机的更多信息，请参阅[保密客户机](../../authentication-and-security/confidential-clients)。此命令具有以下属性：

| 属性      | 描述 |	必需 | 缺省值 |
|----------------|-------------|-------------|---------|
| runtime        | 运行时的名称。 | 是 | 不可用 | 
| id             | 规则的标识。 | 是 | 不可用 | 
| displayName    | 规则的显示名称。 | 是 | 不可用 | 
| secret         | 规则的密钥。 | 是 | 不可用 | 
| allowedScope   | 规则的作用域。空格分隔的令牌列表。 | 是 | 不可用 | 

**示例**  

```xml
<set-confidential-clients-rule runtime="mfp" id="push" displayName="Push" secret="lOa74Wxs" allowedScope="**"/>
```

此命令基于[保密客户机 (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_confidential_clients_put.html?view=kc#Confidential-Clients--PUT-) REST 服务。

### 适配器命令
{: #commands-for-adapters }
在调用 **mfpadm** Ant 任务时，可以包含各种适配器命令。

#### `list-adapters` 命令
{: #the-list-adapters-command }
`list-adapters` 命令返回针对给定的运行时部署的适配器列表。
它具有以下属性。

| 属性      | 描述 |	必需 | 缺省值 |
|----------------|-------------|-------------|---------|
| runtime        | 运行时的名称。 | 	是 | 不可用 | 
| output	     | 输出文件的名称。 | 	否  | 不适用 | 
| outputproperty | 输出的 Ant 属性的名称。 | 否 | 不适用 | 

**示例**  

```xml
<list-adapters runtime="mfp"/>
```

此命令基于[适配器 (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapters_get.html?view=kc#Adapters--GET-) REST 服务。

<br/>
#### `deploy-adapter` 命令
{: #the-deploy-adapter-command }
`deploy-adapter` 命令在运行时中部署适配器。
它具有以下属性。

| 属性      | 描述 |	必需 | 缺省值 |
|----------------|-------------|-------------|---------|
| runtime	     | 运行时的名称。 | 是 | 不可用 | 
| file           | 二进制适配器文件 (.adapter)。 | 是 | 不可用 |

**示例**  

```xml
<deploy-adapter runtime="mfp" file="MyAdapter.adapter"/>
```

此命令基于[适配器 (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapter_post.html?view=kc#Adapter--POST-) REST 服务。


<br/>
#### `show-adapter` 命令
{: #the-show-adapter-command }
`show-adapter` 命令显示有关适配器的详细信息。
它具有以下属性。

| 属性      | 描述 |	必需 | 缺省值 |
|----------------|-------------|-------------|---------|
| runtime | 运行时的名称。 | 是 | 不可用 | 
| name | 适配器的名称。 | 是 | 不可用 | 
| output | 输出文件的名称。 | 否 | 不适用 | 
| outputproperty | 输出的 Ant 属性的名称。 | 否 | 不适用 | 

**示例**  

```xml
<show-adapter runtime="mfp" name="MyAdapter"/>
```

此命令基于[适配器 (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapter_get.html?view=kc#Adapter--GET-) REST 服务。


<br/>
#### `delete-adapter` 命令
{: #the-delete-adapter-command }
`delete-adapter` 命令从运行时中除去（取消部署）适配器。
它具有以下属性。

| 属性      | 描述 |	必需 | 缺省值 |
|----------------|-------------|-------------|---------|
| runtime | 运行时的名称。 | 是 | 不可用 | 
| name    | 适配器的名称。 | 是 | 不可用 | 

**示例**  

```xml
<delete-adapter runtime="mfp" name="MyAdapter"/>
```

此命令基于[适配器 (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapter_get.html?view=kc#Adapter--GET-) REST 服务。


<br/>
#### `adapter` 命令组
{: #the-adapter-command-group }
`adapter` 命令组具有以下属性。

| 属性      | 描述 |	必需 | 缺省值 |
|----------------|-------------|-------------|---------|
| runtime | 运行时的名称。 | 是 | 不可用 | 
| name | 适配器的名称。 | 是 | 不可用 | 

`adapter` 命令支持以下元素。

| 元素          | 描述 |	计数    | 
|------------------|-------------|-------------|
| get-binary	   | 获取二进制数据。 | 0..∞ | 
| show-user-config | 显示用户配置。 | 0..∞ | 
| set-user-config  | 指定用户配置。 | 0..∞ | 

<br/>
#### `get-binary` 命令
{: #the-get-binary-command }
`adapter` 元素内的 `<get-binary>` 命令返回二进制适配器文件。
它具有以下属性。

| 属性      | 描述 |	必需 | 缺省值 |
|----------------|-------------|-------------|---------|
| tofile	     | 输出文件的名称。 | 是 | 不可用 | 

**示例**  

```xml
<adapter runtime="mfp" name="MyAdapter">
  <get-binary tofile="/tmp/MyAdapter.adapter"/>
</adapter>
```

此命令基于[适配器 (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapter_get.html?view=kc#Adapter--GET-) REST 服务。


<br/>
#### `show-user-config` 命令
{: #the-show-user-config-command-1 }
`<adapter>` 元素中的 `show-user-config` 命令可显示适配器的用户配置。它具有以下属性。

| 属性      | 描述 |	必需 | 缺省值 |
|----------------|-------------|-------------|---------|
| format	     | 指定输出格式。json 或 xml。 | 是 | 不可用       | 
| output	     | 用于存储输出的文件的名称。   | 否  | 不适用      | 
| outputproperty | 用于存储输出的 Ant 属性的名称。
  | 否 | 不适用 |

**示例**  

```xml
<adapter runtime="mfp" name="MyAdapter">
  <show-user-config format="xml"/>
</adapter>
```

此命令基于[适配器配置 (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapter_configuration_get.html?view=kc#Adapter-Configuration--GET-) REST 服务。

<br/>
#### `set-user-config` 命令
{: #the-set-user-config-command-1 }
`<adapter>` 元素中的 `set-user-config` 命令可指定适配器的用户配置。它具有以下用于设置整个配置的属性。

| 属性      | 描述 |	必需 | 缺省值 |
|----------------|-------------|-------------|---------|
| file	| 包含新配置的 JSON 或 XML 文件的名称。 | 是 | 不可用 | 

此命令具有以下用于设置配置中单个属性 (property) 的属性 (attribute)。

| 属性      | 描述 |	必需 | 缺省值 |
|----------------|-------------|-------------|---------|
| property | JSON 属性的名称。对于嵌套属性，请使用语法 prop1.prop2.....propN。对于 JSON 数组元素，请使用索引代替属性名称。 | 是 | 不可用 | 
| value | 属性的值。 | 是 | 不可用 | 

**示例**  

```xml
<adapter runtime="mfp" name="MyAdapter">
  <set-user-config file="myconfig.json"/>
</adapter>
```

```xml
<adapter runtime="mfp" name="MyAdapter">
  <set-user-config property="timeout" value="240"/>
</adapter>
```

此命令基于[
应用程序配置 (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_configuration_put.html?view=kc) REST 服务。

### 应用程序命令
{: #commands-for-apps }
在调用 **mfpadm** Ant 任务时，可以包含各种应用程序命令。

#### `list-apps` 命令
{: #the-list-apps-command }
`list-apps` 命令返回在运行时中部署的应用程序列表。
它具有以下属性。

| 属性      | 描述 |	必需 | 缺省值 |
|----------------|-------------|-------------|---------|
| runtime | 运行时的名称。 | 是 | 不可用 | 
| output | 输出文件的名称。 | 否 | 不适用 | 
| outputproperty | 输出的 Ant 属性名称。 | 否 | 不适用 | 

**示例**  

```xml
<list-apps runtime="mfp"/>
```

此命令基于[应用程序 (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_applications_get.html?view=kc#Applications--GET-) REST 服务。

<br/>
#### `deploy-app` 命令
{: #the-deploy-app-command }
`deploy-app` 命令可在运行时中部署应用程序版本。它具有以下属性。

| 属性      | 描述 |	必需 | 缺省值 |
|----------------|-------------|-------------|---------|
| runtime | 运行时的名称。 | 是 | 不可用 | 
| file | 作为应用程序描述符的 JSON 文件。 | 是 | 不可用 | 

**示例**  

```xml
<deploy-app runtime="mfp" file="MyApp/application-descriptor.json"/>
```

此命令基于[应用程序 (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_post.html?view=kc#Application--POST-) REST 服务。

<br/>
#### `show-app` 命令
{: #the-show-app-command }
`show-app` 命令返回在运行时中部署的应用程序版本列表。它具有以下属性。

| 属性      | 描述 |	必需 | 缺省值 |
|----------------|-------------|-------------|---------|
| runtime | 运行时的名称。 | 是 | 不可用 | 
| name | 应用程序的名称。 | 是 | 不可用 | 
| output | 输出文件的名称。 | 否 | 不适用 | 
| outputproperty | 输出的 Ant 属性的名称。 | 否 | 不适用 | 

**示例**  

```xml
<show-app runtime="mfp" name="MyApp"/>
```

此命令基于[应用程序 (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_get.html?view=kc#Application--GET-) REST 服务。

<br/>
#### `delete-app` 命令
{: #the-delete-app-command }
`delete-app` 命令从运行时中针对部署了某个应用程序的所有环境除去（取消部署）该应用程序及其所有应用程序版本。
它具有以下属性。

| 属性      | 描述 |	必需 | 缺省值 |
|----------------|-------------|-------------|---------|
| runtime | 运行时的名称。 | 是 | 不可用 | 
| name | 应用程序的名称。 | 是 | 不可用 | 

**示例**  

```xml
<delete-app runtime="mfp" name="MyApp"/>
```

此命令基于[应用程序版本 (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_version_delete.html?view=kc#Application-Version--DELETE-) REST 服务。

<br/>
#### `show-app-version` 命令
{: #the-show-app-version-command }
`show-app-version` 命令可显示有关运行时中应用程序版本的详细信息。
它具有以下属性。

| 属性      | 描述 |	必需 | 缺省值 |
|----------------|-------------|-------------|---------|
| runtime | 运行时的名称。 | 是 | 不可用 | 
| name | 应用程序的名称。 | 是 | 不可用 | 
| environment	| 移动平台。 | 是 | 不可用 | 
| version	| 应用程序的版本号。 | 是 | 不可用 | 

**示例**  

```xml
<show-app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1"/>
```

此命令基于[应用程序版本 (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_version_get.html?view=kc#Application-Version--GET-) REST 服务。

<br/>
#### `delete-app-version` 命令
{: #the-delete-app-version-command }
`delete-app-version` 命令从运行时中除去（取消部署）应用程序版本。
它具有以下属性。

| 属性      | 描述 |	必需 | 缺省值 |
|----------------|-------------|-------------|---------|
| runtime | 运行时的名称。 | 是 | 不可用 | 
| name | 应用程序的名称。 | 是 | 不可用 | 
| environment	| 移动平台。 | 是 | 不可用 | 
| version	| 应用程序的版本号。 | 是 | 不可用 | 

**示例**  

```xml
<delete-app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1"/>
```

此命令基于[应用程序版本 (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_version_delete.html?view=kc#Application-Version--DELETE-) REST 服务。

<br/>
#### `app` 命令组
{: #the-app-command-group }
`app` 命令组具有以下属性。

| 属性      | 描述 |	必需 | 缺省值 |
|----------------|-------------|-------------|---------|
| runtime | 运行时的名称。 | 是 | 不可用 | 
| name | 应用程序的名称。 | 是 | 不可用 | 

app 命令组支持以下元素。

| 元素 | 描述 | 计数 | 
|---------|-------------|-------|
| show-license-config | 显示令牌许可证配置。 | 0.. | 
| set-license-config | 指定令牌许可证配置。 | 0.. | 
| delete-license-config | 除去令牌许可证配置。 | 0.. | 

<br/>
#### `show-license-config` 命令
{: #the-show-license-config-command }
`show-license-config` 命令可显示应用程序的令牌许可证配置。它具有以下属性。

| 属性      | 描述 |	必需 | 缺省值 |
|----------------|-------------|-------------|---------|
| output         |	用于存储输出的文件的名称。 | 是 | 不可用 |
| outputproperty | 	用于存储输出的 Ant 属性的名称。
 | 是	| 不可用 |

**示例**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <show-license-config output="/tmp/MyApp-license.xml"/>
</app-version>
```

此命令基于[
应用程序许可证配置 (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_license_configuration_get.html?view=kc) REST 服务。

<br/>
#### `set-license-config` 命令
{: #the-set-license-config-command }
`set-license-config` 命令可指定应用程序的令牌许可证配置。它具有以下属性。

| 属性      | 描述 |	必需 | 缺省值 |
|----------------|-------------|-------------|---------|
| appType | 应用程序类型：B2C 或 B2E | 是 | 不可用 | 
| licenseType | 应用程序类型：APPLICATION、ADDITIONAL_BRAND_DEPLOYMENT 或 NON_PRODUCTION。 | 是 | 不可用 | 

**示例**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <set-license-config appType="B2E" licenseType="APPLICATION"/>
</app-version>
```

此命令基于[
应用程序许可证配置 (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_license_configuration__post.html?view=kc) REST 服务。

<br/>
#### `delete-license-config` 命令
{: #the-delete-license-config-command }
`delete-license-config` 命令可重置应用程序的令牌许可证配置，即将其还原至初始状态。

**示例**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <delete-license-config/>
</app-version>
```

此命令基于[许可证配置 (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_license_configuration_delete.html?view=kc#License-configuration--DELETE-) REST 服务。

<br/>
#### `app-version` 命令组
{: #the-app-version-command-group }
`app-version` 命令组具有以下属性。

| 属性      | 描述 |	必需 | 缺省值 |
|----------------|-------------|-------------|---------|
| runtime | 运行时的名称。 | 是 | 不可用 | 
| name | 应用程序的名称。 | 是 | 不可用 | 
| environment | 移动平台。 | 是 | 不可用 | 
| version | 应用程序的版本。 | 是 | 不可用 | 

`app-version` 命令组支持以下元素：

| 元素 | 描述 | 计数 | 
|---------|-------------|-------|
| get-descriptor | 获取描述符。 | 0.. | 
| get-web-resources | 获取 Web 资源。 | 0.. | 
| set-web-resources | 指定 Web 资源。 | 0.. | 
| get-authenticity-data | 获取真实性数据。 | 0.. | 
| set-authenticity-data | 指定真实性数据。 | 0.. | 
| delete-authenticity-data | 删除真实性数据。 | 0.. | 
| show-user-config | 显示用户配置。 | 0.. | 
| set-user-config | 指定用户配置。 | 0.. | 

<br/>
#### `get-descriptor` 命令
{: #the-get-descriptor-command }
`<app-version>` 元素内的 `get-descriptor` 命令返回应用程序版本的应用程序描述符。它具有以下属性。

| 属性      | 描述 |	必需 | 缺省值 |
|----------------|-------------|-------------|---------|
| output | 用于存储输出的文件的名称。 | 否 | 不适用 | 
| outputproperty | 用于存储输出的 Ant 属性的名称。
 | 否 | 不适用 | 

**示例**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <get-descriptor output="/tmp/MyApp-application-descriptor.json"/>
</app-version>
```

此命令基于[应用程序描述符 (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_descriptor_get.html?view=kc#Application-Descriptor--GET-) 服务。

<br/>
#### `get-web-resources` 命令
{: #the-get-web-resources-command }
`<app-version>` 元素内的 `get-web-resources` 命令返回应用程序版本的 Web 资源（以 .zip 文件形式）。它具有以下属性。

| 属性      | 描述 |	必需 | 缺省值 |
|----------------|-------------|-------------|---------|
| tofile | 	输出文件的名称。 | 是 |不可用 | 

**示例**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <get-web-resources tofile="/tmp/MyApp-web.zip"/>
</app-version>
```

此命令基于[检索 Web 资源 (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_retrieve_web_resource_get.html?view=kc#Retrieve-Web-Resource--GET-) REST 服务。

<br/>
#### `set-web-resources` 命令
{: #the-set-web-resources-command }
`<app-version>` 元素内的 `set-web-resources` 命令可指定应用程序版本的 Web 资源。它具有以下属性。

| 属性      | 描述 |	必需 | 缺省值 |
|----------------|-------------|-------------|---------|
| file | 输入文件的名称（必须为 .zip 文件）。 | 是 |不可用 |

**示例**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <set-web-resources file="/tmp/MyApp-web.zip"/>
</app-version>
```

此命令基于[部署 Web 资源 (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_deploy_a_web_resource_post.html?view=kc#Deploy-a-web-resource--POST-) REST 服务。

<br/>
#### `get-authenticity-data` 命令
{: #the-get-authenticity-data-command }
`<app-version>` 元素内的 `get-authenticity-data` 命令可返回应用程序版本的真实性数据。它具有以下属性。

| 属性      | 描述 |	必需 | 缺省值 |
|----------------|-------------|-------------|---------|
| output | 	用于存储输出的文件的名称。 | 否 | 不适用 | 
| outputproperty | 用于存储输出的 Ant 属性的名称。
 | 否 | 不适用 | 

**示例**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <get-authenticity-data output="/tmp/MyApp.authenticity_data"/>
</app-version>
```

此命令基于[
导出运行时资源 (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_export_runtime_resources_get.html?view=kc) REST 服务。

<br/>
#### `set-authenticity-data` 命令
{: #the-set-authenticity-data-command }
`<app-version>` 元素内的 `set-authenticity-data` 命令可指定应用程序版本的真实性数据。它具有以下属性。

| 属性      | 描述 |	必需 | 缺省值 |
|----------------|-------------|-------------|---------|
| file | 输入文件的名称：{::nomarkdown}<ul><li>从中抽取真实性数据的 authenticity_data 文件</li><li>或设备文件（.ipa、.apk 或 .appx 文件）。</li></ul>{:/} |  是 | 不可用 | 

**示例**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <set-authenticity-data file="/tmp/MyApp.authenticity_data"/>
</app-version>
```

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <set-authenticity-data file="MyApp.ipa"/>
</app-version>
```

```xml
<app-version runtime="mfp" name="MyApp" environment="android" version="1.1">
  <set-authenticity-data file="MyApp.apk"/>
</app-version>
```

此命令基于[
部署应用程序真实性数据 (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_deploy_application_authenticity_data_post.html?view=kc) REST 服务。

<br/>
#### `delete-authenticity-data` 命令
{: #the-delete-authenticity-data-command }
`<app-version>` 元素内的 `delete-authenticity-data` 命令可删除应用程序版本的真实性数据。它没有任何属性。

**示例**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <delete-authenticity-data/>
</app-version>
```

此命令基于[
应用程序真实性 (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_authenticity_delete.html?view=kc) REST 服务。

<br/>
#### `show-user-config` 命令
{: #the-show-user-config-command-2 }
`<app-version>` 元素内的 `show-user-config` 命令可显示应用程序版本的用户配置。它具有以下属性。

| 属性      | 描述 |	必需 | 缺省值 |
|----------------|-------------|-------------|---------|
| format | 指定输出格式。json 或 xml。 | 是 | 不可用 | 
| output | 输出文件的名称。否 | 不适用 | 
| outputproperty | 输出的 Ant 属性名称。 | 否 | 不适用 | 

**示例**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <show-user-config format="json" output="/tmp/MyApp-config.json"/>
</app-version>
```

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <show-user-config format="xml" output="/tmp/MyApp-config.xml"/>
</app-version>
```

此命令基于[应用程序配置 (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_configuration_get.html?view=kc#Application-Configuration--GET-) REST 服务。

<br/>
#### `set-user-config` 命令
{: #the-set-user-config-command-2 }
`<app-version>` 元素内的 `set-user-config` 命令可指定应用程序版本的用户配置。它具有以下用于设置整个配置的属性。

| 属性      | 描述 |	必需 | 缺省值 |
|----------------|-------------|-------------|---------|
| file | 包含新配置的 JSON 或 XML 文件的名称。 | 是 | 不可用 | 

`set-user-config` 命令具有以下用于设置配置中单个属性 (property) 的属性 (attribute)。

| 属性      | 描述 |	必需 | 缺省值 |
|----------------|-------------|-------------|---------|
| property | JSON 属性的名称。对于嵌套属性，请使用语法 prop1.prop2.....propN。对于 JSON 数组元素，请使用索引代替属性名称。 | 是 | 不可用 | 
| value	| 属性的值。 | 是 | 不可用 | 

**示例**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <set-user-config file="/tmp/MyApp-config.json"/>
</app-version>
```

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <set-user-config property="timeout" value="240"/>
</app-version>
```

### 设备命令
{: #commands-for-devices }
在调用 **mfpadm** Ant 任务时，可以包含各种设备命令。

#### `list-devices` 命令
{: #the-list-devices-command }
`list-devices` 命令返回已联系运行时的应用程序的设备列表。
它具有以下属性：

| 属性      | 描述 |	必需 | 缺省值 |
|----------------|-------------|-------------|---------|
| runtime | 运行时的名称。 | 是 | 不可用 | 
| query	 | 要搜索的友好名称或用户标识。此参数可指定要搜索的字符串。将返回其友好名称或用户标识中包含此 | 字符串（以不区分大小写的方式匹配）的所有设备。 | 否 | 不适用 | 
| output | 	输出文件的名称。 | 否 | 不适用 | 
| outputproperty | 	输出的 Ant 属性的名称。 | 否 | 不适用 | 

**示例**  

```xml
<list-devices runtime="mfp"/>
```

```xml
<list-devices runtime="mfp" query="john"/>
```

此命令基于[设备 (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_devices_get.html?view=kc#Devices--GET-) REST 服务。


<br/>
#### `remove-device` 命令
{: #the-remove-device-command }
`remove-device` 命令清除有关已联系运行时的应用程序的设备的记录。
它具有以下属性：

| 属性      | 描述 |	必需 | 缺省值 |
|----------------|-------------|-------------|---------|
| runtime | 运行时的名称。 | 是 | 不可用 | 
| id | 唯一设备标识。 | 是 | 不可用 | 

**示例**  

```xml
<remove-device runtime="mfp" id="496E974CCEDE86791CF9A8EF2E5145B6"/>
```

此命令基于[设备 (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_device_delete.html?view=kc#Device--DELETE-) REST 服务。


<br/>
#### `device` 命令组
{: #the-device-command-group }
`device` 命令组具有以下属性。

| 属性      | 描述 |	必需 | 缺省值 |
|----------------|-------------|-------------|---------|
| runtime | 运行时的名称。 | 是 | 不可用 | 
| id | 唯一设备标识。 | 是 | 不可用 | 

`device` 命令支持以下元素。

| 元素        | 描述 |       计数 |
|----------------|-------------|-------------|
| set-status | 更改状态。 | 0..∞ | 
| set-appstatus | 更改应用程序的状态。 | 0..∞ | 

<br/>
#### `set-status` 命令
{: #the-set-status-command }
`set-status` 命令在运行时范围内更改设备的状态。它具有以下属性：

| 属性      | 描述 |	必需 | 缺省值 |
|----------------|-------------|-------------|---------|
| status | 新状态。 | 是 | 不可用 | 

状态可以为下列值之一：

* ACTIVE
* LOST
* STOLEN
* EXPIRED
* DISABLED

**示例**  

```xml
<device runtime="mfp" id="496E974CCEDE86791CF9A8EF2E5145B6">
  <set-status status="EXPIRED"/>
</device>
```

此命令基于[设备状态 (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_device_status_put.html?view=kc#Device-Status--PUT-) REST 服务。

<br/>
#### `set-appstatus` 命令
{: #the-set-appstatus-command }
`set-appstatus` 命令更改设备的状态，此更改关系到运行时中的应用程序。它具有以下属性：

| 属性      | 描述 |	必需 | 缺省值 |
|----------------|-------------|-------------|---------|
| app	| 应用程序的名称。 | 是 | 不可用 | 
| status | 	新状态。 | 是 | 不可用 | 

状态可以为下列值之一：

* ENABLED
* DISABLED

**示例**  

```xml
<device runtime="mfp" id="496E974CCEDE86791CF9A8EF2E5145B6">
  <set-appstatus app="MyApp" status="DISABLED"/>
</device>
```

此命令基于[设备应用程序状态 (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_device_application_status_put.html?view=kc#Device-Application-Status--PUT-) REST 服务。


### 故障诊断命令
{: #commands-for-troubleshooting }
可以使用 Ant 任务命令来调查 {{ site.data.keys.mf_server }} Web 应用程序的问题。

#### `show-info` 命令
{: #the-show-info-command }
`show-info` 命令显示有关 {{ site.data.keys.product_adj }} Administration Services 的基本信息，无需访问任何运行时或数据库即可返回。
 此命令用于测试 {{ site.data.keys.product_adj }} 管理服务究竟是否在运行。它具有以下属性：

| 属性      | 描述 |	必需 | 缺省值 |
|----------------|-------------|-------------|---------|
| output | 	输出文件的名称。 | 否 | 不适用 | 
| outputproperty | 	输出的 Ant 属性的名称。 | 否 | 不适用 | 

**示例**  

```xml
<show-info/>
```

<br/>
#### `show-versions` 命令
{: #the-show-versions-command }
`show-versions` 命令显示各种组件的 {{ site.data.keys.product_adj }} 版本：

* **mfpadmVersion**：从中获取 **mfp-ant-deployer.jar ** 文件的精确  {{ site.data.keys.mf_server }} 版本号。
* **productVersion**：从中获取 **mfp-admin-service.war** 文件的精确 {{ site.data.keys.mf_server }} 版本号。
* **mfpAdminVersion**：**mfp-admin-service.war** 的精确构建版本号。

此命令具有以下属性：

| 属性      | 描述 |	必需 | 缺省值 |
|----------------|-------------|-------------|---------|
| output | 	输出文件的名称。 | 否 | 不适用 | 
| outputproperty | 	输出的 Ant 属性的名称。 | 否 | 不适用 | 

**示例**  

```xml
<show-versions/>
```

<br/>
#### `show-diagnostics` 命令
{: #the-show-diagnostics-command }
`show-diagnostics` 命令可显示 {{ site.data.keys.product_adj }} 管理服务正常运行所需的各种组件的状态，例如数据库和辅助服务的可用性。此命令具有以下属性。

| 属性      | 描述 |	必需 | 缺省值 |
|----------------|-------------|-------------|---------|
| output | 	输出文件的名称。 | 否 | 不适用 | 
| outputproperty | 	输出的 Ant 属性的名称。 | 否 | 不适用 | 

**示例**  

```xml
<show-diagnostics/>
```

<br/>
#### `unlock` 命令
{: #the-unlock-command }
`unlock` 命令可释放通用锁定。一些破坏性操作会接受此锁定，以防止同时修改相同的配置数据。在极少数情况下，如果中断了此操作，那么锁可能仍处于锁定状态，从而使破坏性操作无法进一步执行。unlock 命令可用于在此类情况下发布锁定。此命令没有任何属性。

**示例**  

```xml
<unlock/>
```

<br/>
#### `list-runtimes` 命令
{: #the-list-runtimes-command }
`list-runtimes` 命令返回已部署的运行时的列表。它具有以下属性：

| 属性      | 描述 |	必需 | 缺省值 |
|----------------|-------------|-------------|---------|
| runtime | 运行时的名称。 | 是 | 不可用 | 
| output | 输出文件的名称。 | 否 | 不适用 | 
| outputproperty | 输出的 Ant 属性的名称。 | 否 | 不适用 | 

**示例**  

```xml
<list-runtimes/>
```

```xml
<list-runtimes inDatabase="true"/>
```

此命令基于[运行时 (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_runtimes_get.html?view=kc#Runtimes--GET-) REST 服务。


<br/>
#### `show-runtime` 命令
{: #the-show-runtime-command }
`show-runtime` 命令可显示有关给定的已部署运行时的信息。它具有以下属性：

| 属性      | 描述 |	必需 | 缺省值 |
|----------------|-------------|-------------|---------|
| runtime | 运行时的名称。 | 是 | 不可用 | 
| output | 输出文件的名称。 | 否 | 不适用 | 
| outputproperty | 输出的 Ant 属性的名称。 | 否 | 不适用 | 

**示例**

```xml
<show-runtime runtime="mfp"/>
```

此命令基于[运行时 (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_runtime_get.html?view=kc#Runtime--GET-) REST 服务。


<br/>
#### `delete-runtime` 命令
{: #the-delete-runtime-command }
`delete-runtime` 命令从数据库中删除运行时，包括其应用程序和适配器。
只有在运行时的 Web 应用程序停止时才能删除运行时。此命令具有以下属性。

| 属性      | 描述 |	必需 | 缺省值 |
|----------------|-------------|-------------|---------|
| runtime |  运行时的名称。 | 是 | 不可用 |
| condition | 删除条件：empty 或 always。**注意：**请慎用 always 选项。 | 否 | 不适用 |

**示例**

```xml
<delete-runtime runtime="mfp" condition="empty"/>
```

此命令基于[运行时 (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_runtime_delete.html?view=kc#Runtime--DELETE-) REST 服务。


<br/>
#### `list-farm-members` 命令
{: #the-list-farm-members-command }
`list-farm-members` 命令会返回在其上部署了指定运行时的场成员服务器的列表。它具有以下属性：

| 属性      | 描述 |	必需 | 缺省值 |
|----------------|-------------|-------------|---------|
| runtime | 运行时的名称。 | 是 | 不可用 | 
| output | 输出文件的名称。 | 否 | 不适用 | 
| outputproperty | 输出的 Ant 属性的名称。 | 否 | 不适用 | 

**示例**

```xml
<list-farm-members runtime="mfp"/>
```

此命令基于[场拓扑成员 (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_farm_topology_members_get.html?view=kc#Farm-topology-members--GET-) REST 服务。

<br/>
#### `remove-farm-member` 命令
{: #the-remove-farm-member-command }
`remove-farm-member` 命令可从在其上部署了指定运行时的场成员列表中除去某个服务器。在服务器不可用或断开连接时，可使用此命令。此命令具有以下属性。

| 属性      | 描述 |	必需 | 缺省值 |
|----------------|-------------|-------------|---------|
| runtime | 运行时的名称。 | 是 | 不可用 | 
| serverId | 服务器的标识。	 | 是 | 不适用 | 
| force | 强制除去场成员（即使在该成员可用且已连接的情况下）。 | 否 | false | 

**示例**

```xml
<remove-farm-member runtime="mfp" serverId="srvlx15"/>
```

此命令基于[场拓扑成员 (DELETE) ](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_farm_topology_members_delete.html?view=kc) REST 服务。
