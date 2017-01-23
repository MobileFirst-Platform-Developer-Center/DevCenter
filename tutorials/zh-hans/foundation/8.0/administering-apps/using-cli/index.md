---
layout: tutorial
title: 通过终端管理应用程序
breadcrumb_title: 使用终端管理
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
可以通过 **mfpadm** 程序来管理 {{ site.data.keys.product_adj }}    应用程序。

#### 跳转至
{: #jump-to }

* [与其他设备比较](#comparison-with-other-facilities)
* [先决条件](#prerequisites)

## 与其他设备比较
{: #comparison-with-other-facilities }
可以通过以下方式对 {{ site.data.keys.product_full }}    运行管理操作：

* {{ site.data.keys.mf_console }}   ，属于交互式。
* mfpadm Ant 任务。
* **mfpadm** 程序。
* {{ site.data.keys.product_adj }}    管理 REST 服务。

**mfpadm** Ant 任务、mfpadm 程序和 REST 服务对于操作的自动执行或无人照管执行很有用，如以下用例：

* 消除操作员在重复操作中引入的错误，或
* 在操作员正常工作时间以外操作，或
* 使用与测试或预生产服务器相同的设置来配置生产服务器。

相比 REST 服务，**mfpadm** 程序和 mfpadm Ant 任务更易于使用且具有更强的错误报告功能。mfpadm 程序相对于 mfpadm Ant 任务的优势在于，当与操作系统命令的集成已经可用时，它更易于集成。此外，它更适合以交互方式使用。

## 先决条件
{: #prerequisites }
**mfpadm** 工具可通过 {{ site.data.keys.mf_server }}    安装程序进行安装。在本页的其余部分中，**product\_install\_dir** 表示 {{ site.data.keys.mf_server }}    安装程序的安装目录。

在 **product\_install\_dir/shortcuts/** 目录中以一组脚本的形式提供 **mfpadm** 命令：

* mfpadm（对于 UNIX/Linux）
* mfpadm.bat（对于 Windows）

这些脚本能够运行，这意味着不需要特定的环境变量。如果设置了环境变量 **JAVA_HOME**，那么脚本将接受该环境变量。  
要使用 **mfpadm** 程序，请将 **product\_install\_dir/shortcuts/** 目录放入 PATH 环境变量中，或在每次调用中引用其绝对文件名。

有关运行 {{ site.data.keys.mf_server }}    安装程序的更多信息，请参阅[运行 IBM Installation Manager](../../installation-configuration/production/installation-manager/)。

#### 跳转至
{: #jump-to-1 }

* [调用 **mfpadm** 程序](#calling-the-mfpadm-program)
* [常规配置命令](#commands-for-general-configuration)
* [适配器命令](#commands-for-adapters)
* [应用程序命令](#commands-for-apps)
* [设备命令](#commands-for-devices)
* [故障诊断命令](#commands-for-troubleshooting)


### 调用 **mfpadm** 程序
{: #calling-the-mfpadm-program }
可以使用 **mfpadm** 程序来管理 {{ site.data.keys.product_adj }}    应用程序。

#### 语法
{: #syntax }
调用 mfpadm 程序，如下所示：

```bash
mfpadm --url= --user= ... [--passwordfile=...] [--secure=false] some command
```

**mfpadm** 程序具有以下选项：


| 选项	| 类型 | 描述 | 必需 | 缺省值 | 
|-----------|------|-------------|----------|---------|
| --url | 	 | URL | Administration Services 的 {{ site.data.keys.product_adj }}    web 应用程序的基本 URL | 是 | | 
| --secure	 | 布尔值 | 是否避免存在安全风险的操作 | 否 | true | 
| --user	 | 名称 | 用于访问 {{ site.data.keys.product_adj }}    Administration Services 的用户名 | 是 |  | 	 
| --passwordfile | 文件 | 包含用户密码的文件 | 否 | 
| --timeout	     | 数字  | 整个 REST 服务访问超时，以秒为单位 | 否 | 	 
| --connect-timeout | 数字 | 建立网络连接超时，以秒为单位 | 否 |
| --socket-timeout  | 数字 | 检测网络连接断开超时，以秒为单位 | 否 | 
| --connection-request-timeout | 数字 | 从连接请求池获取条目超时，以秒为单位 | 否 |
| --lock-timeout | 数字 | 获取锁定时的超时，以秒为单位 | 否 | 2 | 
| --verbose	     | 详细的输出 | 否	| |  

**url**  
URL 最好使用 HTTPS 协议。例如，如果使用缺省端口和上下文根，请使用此 URL：

* 对于 WebSphere Application Server：https://server:9443/mfpadmin
* 对于 Tomcat：https://server:8443/mfpadmin

**secure**  
缺省情况下，`--secure` 选项设置为 true。将其设置为 `--secure=false` 可能会有以下影响：

* 用户和密码可能以一种不安全的方式（甚至可能通过未加密的 HTTP）传送。
* 接受服务器的 SSL 证书，即使是自签名证书或为不同于服务器主机名的其他主机名创建的证书也是如此。

**password**  
在独立文件（通过 `--passwordfile` 选项传递）中指定密码。
在交互方式（请参阅“交互方式”）下，您还可以通过交互方式指定密码。密码是敏感信息，因此需要保护。
必须防止相同计算机上的其他用户知道这些密码。为保护密码，在将密码输入文件之前，必须除去除您之外的其他用户对此文件的读许可权。
例如，可以使用以下某个命令：

* 在 UNIX 上：`chmod 600 adminpassword.txt`
* 在 Windows 上：`cacls adminpassword.txt /P Administrators:F %USERDOMAIN%\%USERNAME%:F`

出于此原因，不要通过命令行参数向进程传递密码。在许多操作系统上，其他用户可以查看您的进程的命令行参数。


mfpadm 调用包含一个命令。支持以下命令。

| 命令                           | 描述 | 
|-----------------------------------|-------------|
| show info	| 显示用户和配置信息。 | 
| show global-config | 显示全局配置信息。 | 
| show diagnostics | 显示诊断信息。 | 
| show versions	| 显示版本信息。 | 
| unlock | 释放通用锁定。 | 
| list runtimes [--in-database] | 列出运行时。 | 
| show runtime [runtime-name] | 显示有关运行时的信息。 | 
| delete runtime [runtime-name] condition | 删除运行时。 | 
| show user-config [runtime-name] | 显示运行时的用户配置。 | 
| set user-config [runtime-name] file | 指定运行时的用户配置。 | 
| set user-config [runtime-name] property = value | 指定运行时的用户配置中的属性。 | 
| show confidential-clients [runtime-name] | 显示运行时的保密客户机配置。 | 
| set confidential-clients [runtime-name] file | 指定运行时的保密客户机配置。 | 
| set confidential-clients-rule [runtime-name] id display-name secret allowed-scope | 指定运行时的保密客户机配置规则。 | 
| list adapters [runtime-name] | 列出适配器。 | 
| deploy adapter [runtime-name] property = value | 部署适配器。| 
| show adapter [runtime-name] adapter-name | 显示有关适配器的信息。| 
| delete adapter [runtime-name] adapter-name | 删除适配器。| 
| adapter [runtime-name] adapter-name get binary [> tofile]	| 获取适配器的二进制数据。| 
| list apps [runtime-name] | 列出应用程序。| 
| deploy app [runtime-name] file | 部署应用程序。| 
| show app [runtime-name] app-name | 显示有关应用程序的信息。| 
| delete app [runtime-name] app-name | 删除应用程序。 | 
| show app version [runtime-name] app-name environment version | 显示有关应用程序版本的信息。 |
| delete app version [runtime-name] app-name environment version | 删除应用程序的版本。 |
| app [runtime-name] app-name show license-config | 显示应用程序的令牌许可证配置。 |
| app [runtime-name] app-name set license-config app-type license-type | 指定应用程序的令牌许可证配置。 |
| app [runtime-name] app-name delete license-config | 除去应用程序的令牌许可证配置。 | 
| app version [runtime-name] app-name environment version get descriptor [> tofile]	| 获取应用程序版本的描述符。 | 
| app version [runtime-name] app-name environment version get web-resources [> tofile] | 获取应用程序版本的 Web 资源。 | 
| app version [runtime-name] app-name environment version set web-resources file | 指定应用程序版本的 Web 资源。 | 
| app version [runtime-name] app-name environment version get authenticity-data [> tofile] | 获取应用程序版本的真实性数据。 | 
| app version [runtime-name] app-name environment version set authenticity-data [file] | 指定应用程序版本的真实性数据。 | 
| app version [runtime-name] app-name environment version delete authenticity-data | 删除应用程序版本的真实性数据。 | 
| app version [runtime-name] app-name environment version show user-config | 显示应用程序版本的用户配置。 | 
| app version [runtime-name] app-name environment version set user-config file | 指定应用程序版本的用户配置。 | 
| app version [runtime-name] app-name environment version set user-config property = value | 指定应用程序版本的用户配置中的属性。 |
| list devices [runtime-name][--query query] | 列出设备。 |
| remove device [runtime-name] id | 除去设备。 |
| device [runtime-name] id set status new-status | 更改设备状态。 |
| device [runtime-name] id set appstatus app-name new-status | 更改应用程序的设备状态。 |
| list farm-members [runtime-name] | 列出作为服务器场成员的服务器。 |
| remove farm-member [runtime-name] server-id | 从场成员列表中除去服务器。 |

#### 交互方式
{: #interactive-mode }
另外，也可以调用 **mfpadm**，而不在命令行中指定任何命令。
然后可以交互式输入命令，每行一个命令。
`exit` 命令或标准输入上的文件结束符（在 UNIX 终端上为 **Ctrl-D**）可以终止 mfpadm。

`Help` 命令在此方式中也可用。例如：

* help
* help show versions
* help device
* help device set status

#### 交互方式下的命令历史记录
{: #command-history-in-interactive-mode }
在某些操作系统上，交互式 mfpadm 命令会记住命令历史记录。通过命令历史记录，您可以使用向上箭头或向下箭头键选择之前的命令、编辑并加以执行。

**在 Linux 上**  
如果在 PATH 中已安装并找到 rlwrap 程序包，那么表示在终端仿真器窗口中已启用命令历史记录。要安装 rlwrap 程序包：

* 在 Red Hat Linux 上：`sudo yum install rlwrap`
* 在 SUSE Linux 上：`sudo zypper install rlwrap`
* 在 Ubuntu 上：`sudo apt-get install rlwrap` **在 OS X 上**  
如果在 PATH 中已安装并找到 rlwrap 程序包，那么表示在终端程序中已启用命令历史记录。要安装 rlwrap 程序包：

1. 使用 [www.macports.org](http://www.macports.org) 中的安装程序安装 MacPorts。
2. 运行命令：`sudo /opt/local/bin/port install rlwrap`
3. 然后，要在 PATH 中使用 rlwrap 程序，请在兼容 Bourne 的 shell 中使用该命令：`PATH=/opt/local/bin:$PATH`

**在 Windows 上**  
在 cmd.exe 控制台窗口中已启用命令历史记录。

在未运行或不需要 rlwrap 的环境中，您可以通过选项 `--no-readline` 将其禁用。

#### 配置文件
{: #the-configuration-file }
也可以在配置文件中存储选项，而不是每次调用时都在命令行上传递这些选项。当存在配置文件并且指定了选项 –configfile=file 时，可以省略以下选项：

* --url=URL
* --secure=boolean
* --user=name
* --passwordfile=file
* --timeout=seconds
* --connect-timeout=seconds
* --socket-timeout=seconds
* --connection-request-timeout=seconds
* --lock-timeout=seconds
* runtime-name

使用这些命令，将这些值存储在配置文件中。

| 命令 | 注释 |
|---------|---------| 
| mfpadm [--configfile=file] config url URL | | 
| mfpadm [--configfile=file] config secure boolean | | 
| mfpadm [--configfile=file] config user name | | 
| mfpadm [--configfile=file] config password | 提示输入密码。 | 
| mfpadm [--configfile=file] config timeout seconds | | 
| mfpadm [--configfile=file] config connect-timeout seconds | | 
| mfpadm [--configfile=file] config socket-timeout seconds | | 
| mfpadm [--configfile=file] config connection-request-timeout seconds | | 
| mfpadm [--configfile=file] config lock-timeout seconds | | 
| mfpadm [--configfile=file] config runtime runtime-name | | 

使用以下命令可列出配置文件中存储的值：`mfpadm [--configfile=file] config`

配置文件是文本文件，采用当前语言环境编码和 Java **.properties** 语法。以下是缺省配置文件：

* UNIX：**${HOME}/.mfpadm.config**
* Windows：**{{ site.data.keys.prod_server_data_dir_win }}  \mfpadm.config**

**注：**如果未指定 `--configfile` 选项，那么缺省配置文件只用于交互方式和 config 命令。对于其他命令的非交互方式使用，必须显式指定要使用的配置文件。

> **要点：**密码以模糊格式存储，可防止密码被窥视。然而，该加密并不安全。
#### 一般选项
{: #generic-options }
有一些常用的一般选项：


| 选项	| 描述 | 
|-----------|-------------|
| --help	| 显示一些用法帮助 | 
| --version	| 显示版本 | 

#### XML 格式
{: #xml-format }
从服务器接收 XML 响应的命令将验证此响应是否符合特定的模式。通过指定 `--xmlvalidation=none`，可以禁用此检查。

#### 输出字符集
{: #output-character-set }
mfpadm 程序生成的正常输出采用当前语言环境的编码格式进行编码。在 Windows 上，此编码格式为“ANSI 代码页”。影响如下所示：

* 此字符集外的字符将在输出时转换为问号。
* 输出发送至 Windows 命令提示符窗口 (cmd.exe) 时，非 ASCII 字符将无法正确显示，因为此类窗口假定字符采用“OEM 代码页”编码。

要解决此限制：

* 在除 Windows 之外的操作系统上，使用其编码为 UTF-8 的语言环境。此格式为 Red Hat Linux 和 OS X 上的缺省语言环境。其他多个操作系统采用 `en_US.UTF-8` 语言环境。
* 或者将 mfpadm Ant 任务与属性 `output="some file name"` 配合使用，以将命令输出重定向到某个文件。

### 常规配置命令
{: #commands-for-general-configuration }
在调用 **mfpadm** 程序时，可以包含各种用于访问 IBM {{ site.data.keys.mf_server }}    或运行时全局配置的命令。

#### `show global-config` 命令
{: #the-show-global-config-command }
`show
global-config` 命令可显示全局配置。

语法：`show global-config`

它采用以下选项：

| 参数 | 描述 |
|----------|-------------|
| --xml    | 生成 XML 输出（而非表格输出）。 | 

**示例**  

```bash
show global-config
```

此命令基于[全局配置 (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_global_configuration_get.html?view=kc#Global-Configuration--GET-) REST 服务。

<br /> 
#### `show user-config` 命令
{: #the-show-user-config-command }
`show
user-config` 命令可显示运行时的用户配置。

语法：`show user-config [--xml][runtime-name]`

它采用以下参数：


| 参数 | 描述 |
|----------|-------------|
| runtime-name | 运行时的名称。 |

`show user-config` 命令在动词后采用以下选项。

| 参数 | 描述 | 必需 | 缺省值 | 
|----------|-------------|----------|---------|
| --xml | 生成 XML 格式（而非 JSON 格式）的输出。 | 否 | 标准输出 | 

**示例**  

```bash
show user-config mfp
```

此命令基于[运行时配置 (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_runtime_configuration_get.html?view=kc#Runtime-Configuration--GET-) REST 服务。

<br /> 
#### `set user-config` 命令
{: #the-set-user-config-command }
`set
user-config` 命令可指定运行时的用户配置或此配置中的单个属性。

针对整个配置的语法：`set user-config [runtime-name] file`

它采用以下参数：


| 属性 | 描述 | 
|-----------|-------------|
| runtime-name | 运行时的名称。 | 
| file | 包含新配置的 JSON 或 XML 文件的名称。 | 

针对单个属性的语法：`set user-config [runtime-name] property = value`

`set user-config` 命令采用以下参数：

| 参数 | 描述 | 
|----------|-------------|
| runtime-name | 运行时的名称。 | 
| property | JSON 属性的名称。对于嵌套属性，请使用语法 prop1.prop2.....propN。对于 JSON 数组元素，请使用索引代替属性名称。 |
| value | 属性的值。 | 

**示例**  

```bash
set user-config mfp myconfig.json
```

```bash
set user-config mfp timeout = 240
```

此命令基于[运行时配置 (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_runtime_configuration_put.html?view=kc#Runtime-configuration--PUT-) REST 服务。

<br /> 
#### `show confidential-clients` 命令
{: #the-show-confidential-clients-command }
`show confidential-clients` 命令显示可以访问运行时的保密客户机的配置。有关保密客户机的更多信息，请参阅[保密客户机](../../authentication-and-security/confidential-clients)。

语法：`show confidential-clients [--xml][runtime-name]`

它采用以下参数：


| 属性 | 描述 |
|-----------|-------------|
| runtime-name | 运行时的名称。 |

`show confidential-clients` 命令在动词后采用以下选项。

| 参数 | 描述 | 必需 | 缺省值 |
|----------|-------------|----------|---------|
| --xml | 生成 XML 格式（而非 JSON 格式）的输出。 | 否 | 标准输出 |

**示例**

```bash
show confidential-clients --xml mfp
```

此命令基于[保密客户机 (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_confidential_clients_get.html?view=kc#Confidential-Clients--GET-) REST 服务。

<br /> 
#### `set confidential-clients` 命令
{: #the-set-confidential-clients-command }
`set confidential-clients` 命令指定可以访问运行时的保密客户机的配置。有关保密客户机的更多信息，请参阅[保密客户机](../../authentication-and-security/confidential-clients)。

语法：`set confidential-clients [runtime-name] file`

它采用以下参数：

| 属性 | 描述 | 
|-----------|-------------|
| runtime-name | 运行时的名称。 | 
| file	| 包含新配置的 JSON 或 XML 文件的名称。 | 

**示例**

```bash
set confidential-clients mfp clients.xml
```

此命令基于[保密客户机 (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_confidential_clients_put.html?view=kc#Confidential-Clients--PUT-) REST 服务。

<br /> 
#### `set confidential-clients-rule` 命令
{: #the-set-confidential-clients-rule-command }
`set confidential-clients-rule` 命令指定可以访问运行时的保密客户机的配置中的规则。有关保密客户机的更多信息，请参阅[保密客户机](../../authentication-and-security/confidential-clients)。

语法：`set confidential-clients-rule [runtime-name] id displayName secret allowedScope`

它采用以下参数：


| 属性	| 描述 |
|-----------|-------------|
| runtime | 运行时的名称。 | 
| id | 规则的标识。 | 
| displayName | 规则的显示名称。 | 
| secret | 规则的密钥。 | 
| allowedScope | 规则的作用域。空格分隔的令牌列表。使用双引号来传递由两个或更多个令牌组成的列表。 | 

**示例**

```bash
set confidential-clients-rule mfp push Push lOa74Wxs "**"
```

此命令基于[保密客户机 (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_confidential_clients_put.html?view=kc#Confidential-Clients--PUT-) REST 服务。

### 适配器命令
{: #commands-for-adapters }
在调用 **mfpadm** 程序时，可以包含各种适配器命令。

### `list adapters` 命令
{: #the-list-adapters-command }
`list adapters` 命令返回为运行时部署的适配器列表。

语法：`list adapters [runtime-name]`

它采用以下参数：


| 参数 | 描述 | 
|----------|-------------|
| runtime-name | 运行时的名称。 |

`list adapters` 命令在对象后采用以下选项。

| 选项 | 描述 | 
|--------|-------------|
| --xml | 生成 XML 输出（而非表格输出）。 | 

**示例**  

```xml
list adapters mfp
```

此命令基于[适配器 (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapters_get.html?view=kc#Adapters--GET-) REST 服务。

<br /> 
#### `deploy adapter` 命令
{: #the-deploy-adapter-command }
`deploy adapter` 命令在运行时中部署适配器。

语法：`deploy adapter [runtime-name] file`

它采用以下参数：


| 参数 | 描述 | 
|----------|-------------|
| runtime-name | 运行时的名称。 |
| file | 二进制适配器文件 (.adapter) |

**示例**

```bash
deploy adapter mfp MyAdapter.adapter
```

此命令基于[适配器 (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapter_post.html?view=kc#Adapter--POST-) REST 服务。


<br /> 
#### `show adapter` 命令
{: #the-show-adapter-command }
`show adapter` 命令显示有关适配器的详细信息。

语法：`show adapter [runtime-name] adapter-name`

它采用以下参数。

| 参数 | 描述 | 
|----------|-------------|
| runtime-name | 运行时的名称。 |
| adapter-name | 适配器的名称 |

`show adapter` 命令在对象后采用以下选项。

| 选项 | 描述 |
|--------|-------------|
| --xml | 生成 XML 输出（而非表格输出）。 |

**示例**

```bash
show adapter mfp MyAdapter
```

此命令基于[适配器 (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapter_get.html?view=kc#Adapter--GET-) REST 服务。


<br /> 
#### `delete adapter` 命令
{: #the-delete-adapter-command }
`delete adapter` 命令从运行时中除去（取消部署）适配器。

语法：`delete adapter [runtime-name] adapter-name`

它采用以下参数：


| 参数 | 描述 |
|----------|-------------|
| runtime-name | 运行时的名称。 | 
| adapter-name | 适配器的名称。 | 

**示例**

```bash
delete adapter mfp MyAdapter
```

此命令基于[适配器 (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapter_delete.html?view=kc#Adapter--DELETE-) REST 服务。


<br /> 
#### `adapter` 命令前缀
{: #the-adapter-command-prefix }
`adapter` 命令前缀在动词前采用以下参数。

| 参数 | 描述 | 
|----------|-------------|
| runtime-name | 运行时的名称。 | 
| adapter-name | 适配器的名称。 | 

<br /> 
#### `adapter get binary` 命令
{: #the-adapter-get-binary-command }
`adapter get binary` 命令返回二进制适配器文件。

语法：`adapter [runtime-name] adapter-name get binary [> tofile]`

它在动词后采用以下选项。

| 选项 | 描述 | 必需 | 缺省值 | 
|--------|-------------|----------|---------|
| > tofile | 输出文件的名称。 | 否 | 标准输出 |

**示例**

```bash
adapter mfp MyAdapter get binary > /tmp/MyAdapter.adapter
```

此命令基于[
导出运行时资源 (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_export_runtime_resources_get.html?view=kc) REST 服务。

<br /> 
#### `adapter show user-config` 命令
{: #the-adapter-show-user-config-command }
`adapter show user-config` 命令可显示适配器的用户配置。

语法：`adapter [runtime-name] adapter-name show user-config [--xml]`

它在动词后采用以下选项。

| 选项 | 描述 |
|--------|-------------|
| --xml | 生成 XML 格式（而非 JSON 格式）的输出。 | 

**示例**

```bash
adapter mfp MyAdapter show user-config
```

此命令基于[适配器配置 (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapter_configuration_get.html?view=kc#Adapter-Configuration--GET-) REST 服务。

<br /> 
#### `adapter set user-config` 命令
{: #the-adapter-set-user-config-command }
`adapter set user-config` 命令可指定适配器的用户配置或此配置中的单个属性。

针对整个配置的语法：`adapter [runtime-name] adapter-name set user-config file`

它在动词后采用以下参数。

| 选项 | 描述 | 
|--------|-------------|
| file | 包含新配置的 JSON 或 XML 文件的名称。 |

针对单个属性的语法：`adapter [runtime-name] adapter-name set user-config property = value`

它在动词后采用以下参数。

| 选项 | 描述 |
|--------|-------------|
| property | JSON 属性的名称。对于嵌套属性，请使用语法 prop1.prop2.....propN。对于 JSON 数组元素，请使用索引代替属性名称。 | 
| value | 属性的值。 | 

**示例**

```bash
adapter mfp MyAdapter set user-config myconfig.json
```

```bash
adapter mfp MyAdapter set user-config timeout = 240
```

此命令基于[适配器配置 (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapter_configuration_put.html?view=kc) REST 服务。

### 应用程序命令
{: #commands-for-apps }
在调用 **mfpadm** 程序时，可以包含各种应用程序命令。


#### `list apps` 命令
{: #the-list-apps-command }
`list apps` 命令返回在运行时中部署的应用程序列表。

语法：`list apps [runtime-name]`

它采用以下参数：


| 参数 | 描述 | 
|----------|-------------|
| runtime-name | 运行时的名称。 |

`list apps` 命令在对象后采用以下选项。

| 选项 | 描述 |
|--------|-------------|
| --xml | 生成 XML 输出（而非表格输出）。 |

**示例**

```bash
list apps mfp
```

此命令基于[应用程序 (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_applications_get.html?view=kc#Applications--GET-) REST 服务。

#### `deploy app` 命令
{: #the-deploy-app-command }
`deploy
app` 命令可在运行时中部署应用程序版本。

语法：`deploy app [runtime-name] file`

它采用以下参数：


| 参数 | 描述 | 
|----------|-------------|
| runtime-name | 运行时的名称。 |
| file | 作为应用程序描述符的 JSON 文件。 |

**示例**

```bash
deploy app mfp MyApp/application-descriptor.json
```

此命令基于[应用程序 (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_post.html?view=kc#Application--POST-) REST 服务。

#### `show app` 命令
{: #the-show-app-command }
`show app` 命令显示有关运行时中应用程序的详细信息，特别是其环境和版本信息。


语法：`show app [runtime-name] app-name`

它采用以下参数：


| 参数 | 描述 | 
|----------|-------------|
| runtime-name | 运行时的名称。 | 
| app-name | 应用程序的名称。 | 

`show app` 命令在对象后采用以下选项。

| 选项 | 描述 |
|--------|-------------|
| --xml	 | 生成 XML 输出（而非表格输出）。 |

**示例**

```bash
show app mfp MyApp
```

此命令基于[应用程序 (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_get.html?view=kc#Application--GET-) REST 服务。

#### `delete app` 命令
{: #the-delete-app-command }
`delete
app` 命令可从运行时中除去（取消部署）应用程序（包含所有环境和所有版本）。

语法：`delete app [runtime-name] app-name`

它采用以下参数：


| 参数 | 描述 | 
|----------|-------------|
| runtime-name | 运行时的名称。 | 
| app-name | 应用程序的名称 | 

**示例**

```bash
delete app mfp MyApp
```

此命令基于[应用程序版本 (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_version_delete.html?view=kc#Application-Version--DELETE-) REST 服务。

#### `show app version` 命令
{: #the-show-app-version-command }
`show app
version` 命令可显示有关运行时中应用程序版本的详细信息。

语法：`show app version [runtime-name] app-name environment version`

它采用以下参数：


| 参数 | 描述 | 
|----------|-------------|
| runtime-name | 运行时的名称。 | 
| app-name | 应用程序的名称。 | 
| environment | 移动平台。 | 
| version | 应用程序的版本。 | 

`show app version` 命令在对象后采用以下选项。

| 参数 | 描述 | 
| ---------|-------------|
| -- xml | 生成 XML 输出（而非表格输出）。 | 

**示例**

```bash
show app version mfp MyApp iPhone 1.1
```

此命令基于[应用程序版本 (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_version_get.html?view=kc#Application-Version--GET-) REST 服务。

#### `delete app version` 命令
{: #the-delete-app-version-command }
`delete app version` 命令从运行时中除去（取消部署）应用程序版本。


语法：`delete app version [runtime-name] app-name environment version`

它采用以下参数：


| 参数 | 描述 | 
|----------|-------------|
| runtime-name | 运行时的名称。 | 
| app-name | 应用程序的名称。 | 
| environment | 移动平台。 | 
| version | 应用程序的版本。 | 

**示例**

```bash
delete app version mfp MyApp iPhone 1.1
```

此命令基于[应用程序版本 (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_version_delete.html?view=kc#Application-Version--DELETE-) REST 服务。

#### `app` 命令前缀
{: #the-app-command-prefix }
`app` 命令前缀在动词前采用以下参数。

| 参数 | 描述 | 
|----------|-------------|
| runtime-name | 运行时的名称。 | 
| app-name | 应用程序的名称。 | 

#### `app show license-config` 命令
{: #the-app-show-license-config-command }
`app
show license-config` 命令可显示应用程序的令牌许可证配置。

语法：`app [runtime-name] app-name show license-config`

它在对象后采用以下选项：


| 参数 | 描述 | 
|----------|-------------|
| --xml | 生成 XML 输出（而非表格输出）。 | 

**示例**

```bash
app mfp MyApp show license-config
```

此命令基于[
应用程序许可证配置 (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_license_configuration_get.html?view=kc) REST 服务。

#### `app set license-config` 命令
{: #the-app-set-license-config-command }
`app set
license-config` 命令可指定应用程序的令牌许可证配置。

语法：`app [runtime-name] app-name set license-config app-type license-type`

它在动词后采用以下参数。

| 参数 | 描述 | 
|----------|-------------|
| appType | 应用程序类型：B2C 或 B2E。 | 
| licenseType | 应用程序类型：APPLICATION、ADDITIONAL_BRAND_DEPLOYMENT 或 NON_PRODUCTION。 | 

**示例**

```bash
app mfp MyApp iPhone 1.1 set license-config B2E APPLICATION
```

此命令基于[
应用程序许可证配置 (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_license_configuration__post.html?view=kc) REST 服务。

#### `app delete license-config` 命令
{: #the-app-delete-license-config-command }
`app
delete license-config` 命令可重置应用程序的令牌许可证配置，即将其还原至初始状态。

语法：`app [runtime-name] app-name delete license-config`

**示例**

```bash
app mfp MyApp iPhone 1.1 delete license-config
```

此命令基于[许可证配置 (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_license_configuration_delete.html?view=kc#License-configuration--DELETE-) REST 服务。

#### `app version` 命令前缀
{: #the-app-version-command-prefix }
`app version` 命令前缀在动词前采用以下参数。

| 参数 | 描述 | 
|----------|-------------|
| runtime-name | 运行时的名称。 | 
| app-name | 应用程序的名称。 | 
| environment | 移动平台 | 
| version | 应用程序的版本 | 

#### `app version get descriptor` 命令
{: #the-app-version-get-descriptor-command }
`app
version get descriptor` 命令返回应用程序版本的应用程序描述符。

语法：`app version [runtime-name] app-name environment version get descriptor [> tofile]`

它在动词后采用以下参数。

| 参数 | 描述 | 必需 | 缺省值 | 
|----------|-------------|----------|---------|
| > tofile | 输出文件的名称。 | 否 | 标准输出 | 

**示例**

```bash
app version mfp MyApp iPhone 1.1 get descriptor > /tmp/MyApp-application-descriptor.json
```

此命令基于[应用程序描述符 (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_descriptor_get.html?view=kc#Application-Descriptor--GET-) REST 服务。

#### `app version get web-resources` 命令
{: #the-app-version-get-web-resources-command }
`app version get web-resources` 命令返回应用程序版本的 Web 资源（以 .zip 文件形式）。

语法：`app version [runtime-name] app-name environment version get web-resources [> tofile]`

它在动词后采用以下参数。

| 参数 | 描述 | 必需 | 缺省值 | 
|----------|-------------|----------|---------|
| > tofile | 输出文件的名称。 | 否 | 标准输出 | 

**示例**

```bash
app version mfp MyApp iPhone 1.1 get web-resources > /tmp/MyApp-web.zip
```

此命令基于[检索 Web 资源 (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_retrieve_web_resource_get.html?view=kc#Retrieve-Web-Resource--GET-) REST 服务。

#### `app version set web-resources` 命令
{: #the-app-version-set-web-resources-command }
`app version set web-resources` 命令可指定应用程序版本的 Web 资源。

语法：`app version [runtime-name] app-name environment version set web-resources file`

它在动词后采用以下参数。

| 参数 | 描述 |
| file | 输入文件的名称（必须为 .zip 文件）。| 

**示例**

```bash
app version mfp MyApp iPhone 1.1 set web-resources /tmp/MyApp-web.zip
```

此命令基于[部署 Web 资源 (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_deploy_a_web_resource_post.html?view=kc#Deploy-a-web-resource--POST-) REST 服务。

#### `app version get authenticity-data` 命令
{: #the-app-version-get-authenticity-data-command }
`app version get authenticity-data` 命令返回应用程序版本的真实性数据。

语法：`app version [runtime-name] app-name environment version get authenticity-data [> tofile]`

它在动词后采用以下参数。

| 参数 | 描述 | 必需 | 缺省值 |
| > tofile | 输出文件的名称。| 否 | 标准输出 | 

**示例**

```bash
app version mfp MyApp iPhone 1.1 get authenticity-data > /tmp/MyApp.authenticity_data
```

此命令基于[
导出运行时资源 (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_export_runtime_resources_get.html?view=kc) REST 服务。

#### `app version set authenticity-data` 命令
{: #the-app-version-set-authenticity-data-command }
`app version set authenticity-data` 命令可指定应用程序版本的真实性数据。

语法：`app version [runtime-name] app-name environment version set authenticity-data file`

它在动词后采用以下参数。

| 参数 | 描述 | 
|----------|-------------|
| file | 输入文件的名称：<ul><li>从中抽取真实性数据的 .authenticity_data 文件</li><li>或设备文件（.ipa、.apk 或 .appx）。</li></ul>| 

**示例**

```bash
app version mfp MyApp iPhone 1.1 set authenticity-data /tmp/MyApp.authenticity_data
```

```bash
app version mfp MyApp iPhone 1.1 set authenticity-data MyApp.ipa
```

```bash
app version mfp MyApp android 1.1 set authenticity-data MyApp.apk
```

此命令基于[
部署应用程序真实性数据 (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_deploy_application_authenticity_data_post.html?view=kc) REST 服务。

#### `app version delete authenticity-data` 命令
{: #the-app-version-delete-authenticity-data-command }
`app version delete authenticity-data` 命令可删除应用程序版本的真实性数据。

语法：`app version [runtime-name] app-name environment version delete authenticity-data`

**示例**

```bash
app version mfp MyApp iPhone 1.1 delete authenticity-data
```

此命令基于[
应用程序真实性 (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_authenticity_delete.html?view=kc) REST 服务。

#### `app version show user-config` 命令
{: #the-app-version-show-user-config-command }
`app version show user-config` 命令可显示应用程序版本的用户配置。

语法：`app version [runtime-name] app-name environment version show user-config [--xml]`

它在动词后采用以下选项。

| 参数 | 描述 | 必需 | 缺省值 | 
|----------|-------------|----------|---------|
| [--xml] | 生成 XML 格式（而非 JSON 格式）的输出。 | 否 | 标准输出 | 

**示例**

```bash
app version mfp MyApp iPhone 1.1 show user-config
```

此命令基于[应用程序配置 (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_configuration_get.html?view=kc#Application-Configuration--GET-) REST 服务。

### `app version set user-config` 命令
{: #the-app-version-set-user-config-command }
`app version set user-config` 命令可指定应用程序版本的用户配置或此配置中的单个属性。

针对整个配置的语法：`app version [runtime-name] app-name environment version set user-config file`

它在动词后采用以下参数。

| 参数 | 描述 | 
|----------|-------------|
| file | 包含新配置的 JSON 或 XML 文件的名称。 | 

针对单个属性的语法：`app version [runtime-name] app-name environment version set user-config property = value`

`app version set user-config` 命令在动词后采用以下参数。

| 参数 | 描述 | 
|----------|-------------|
| property | JSON 属性的名称。对于嵌套属性，请使用语法 prop1.prop2.....propN。对于 JSON 数组元素，请使用索引代替属性名称。 | 
| value | 属性的值。 | 

**示例**

```bash
app version mfp MyApp iPhone 1.1 set user-config /tmp/MyApp-config.json
```

```bash
app version mfp MyApp iPhone 1.1 set user-config timeout = 240
```

此命令基于[
应用程序配置 (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_configuration_put.html?view=kc) REST 服务。

### 设备命令
{: #commands-for-devices }
在调用 **mfpadm** 程序时，可以包含各种设备命令。


#### `list devices` 命令
{: #the-list-devices-command }
`list devices` 命令返回已联系运行时的应用程序的设备列表。


语法：`list devices [runtime-name][--query query]`

它采用以下参数：


| 参数 | 描述 | 
|----------|-------------|
| runtime-name | 运行时的名称。 | 
| query | 要搜索的友好名称或用户标识。此参数可指定要搜索的字符串。将返回其友好名称或用户标识中包含此字符串（以不区分大小写的方式匹配）的所有设备。
 | 

`list devices` 命令在对象后采用以下选项。

| 选项 | 描述 | 
|--------|-------------|
| --xml | 生成 XML 输出（而非表格输出）。 | 

**示例**

```bash
list-devices mfp
```

```bash
list-devices mfp --query=john
```

此命令基于[设备 (GET) REST](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_devices_get.html?view=kc#Devices--GET-) 服务。

#### `remove device` 命令
{: #the-remove-device-command }
`remove
device` 命令清除有关某一设备的记录，该设备已联系某一运行时的应用程序。


语法：`remove device [runtime-name] id`

它采用以下参数：


| 参数 | 描述 | 
|----------|-------------|
| runtime-name | 运行时的名称。 | 
| id | 唯一设备标识。 | 

**示例**

```bash
remove device mfp 496E974CCEDE86791CF9A8EF2E5145B6
```

此命令基于[设备 (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_device_delete.html?view=kc#Device--DELETE-) REST 服务。


#### `device` 命令前缀
{: #the-device-command-prefix }
`device` 命令前缀在动词前采用以下参数。

| 参数 | 描述 | 
|----------|-------------|
| runtime-name | 运行时的名称。 | 
| id | 唯一设备标识。 | 

#### `device set status` 命令
{: #the-device-set-status-command }
`device
set status` 命令在运行时范围内更改设备的状态。


语法：`device [runtime-name] id set status new-status`

它采用以下参数：


| 参数 | 描述 | 
|----------|-------------|
| new-status | 新状态。 | 

状态可以为下列值之一：

* ACTIVE
* LOST
* STOLEN
* EXPIRED
* DISABLED

**示例**

```bash
device mfp 496E974CCEDE86791CF9A8EF2E5145B6 set status EXPIRED
```

此命令基于[设备状态 (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_device_status_put.html?view=kc#Device-Status--PUT-) REST 服务。

#### `device set appstatus` 命令
{: #the-device-set-appstatus-command }
`device set appstatus` 命令更改设备的状态，此更改关系到运行时中的应用程序。


语法：`device [runtime-name] id set appstatus app-name new-status`

它采用以下参数：


| 参数 | 描述 | 
|----------|-------------|
| app-name | 应用程序的名称。 | 
| new-status | 新状态。 | 

状态可以为下列值之一：

* ENABLED
* DISABLED


**示例**

```xml
device mfp 496E974CCEDE86791CF9A8EF2E5145B6 set appstatus MyApp DISABLED
```

此命令基于[设备应用程序状态 (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_device_application_status_put.html?view=kc#Device-Application-Status--PUT-) REST 服务。


### 故障诊断命令
{: #commands-for-troubleshooting }
在调用 **mfpadm** 程序时，可以包含各种故障诊断命令。


#### `show info` 命令
{: #the-show-info-command }
`show info` 命令显示有关 {{ site.data.keys.product_adj }}    Administration Services 的基本信息，无需访问任何运行时或数据库即可返回这些信息。
此命令可用于测试 {{ site.data.keys.product_adj }}    Administration Services 究竟是否在运行。

语法：`show info`

它在对象后采用以下选项。

| 选项 | 描述 | 
|--------|-------------|
| --xml | 生成 XML 输出（而非表格输出）。 |

**示例**

```bash
show info
```

#### `show versions` 命令
{: #the-show-versions-command }
`show versions` 命令显示各种组件的 {{ site.data.keys.product_adj }}    版本：

* **mfpadmVersion**：从中获取 **which mfp-ant-deployer.jar** 的精确 {{ site.data.keys.mf_server }}    版本号。
* **productVersion**：从中可以获取 **mfp-admin-service.war** 的 {{ site.data.keys.mf_server }}    精确版本号。
* **mfpAdminVersion**：**mfp-admin-service.war** 的精确构建版本号。

语法：`show versions`

它在对象后采用以下选项。

| 选项 | 描述 | 
|--------|-------------|
| --xml | 生成 XML 输出（而非表格输出）。 | 

**示例**

```bash
show versions
```

#### `show diagnostics` 命令
{: #the-show-diagnostics-command }
`show
diagnostics` 命令可显示 {{ site.data.keys.product_adj }}   
管理服务正常运行所需的各种组件的状态，例如数据库和辅助服务的可用性。

语法：`show diagnostics`

它在对象后采用以下选项。

| 选项 | 描述 | 
|--------|-------------|
| --xml | 生成 XML 输出（而非表格输出）。 | 

**示例**

```bash
show diagnostics
```

#### `unlock` 命令
{: #the-unlock-command }
`unlock` 命令可释放通用锁定。一些破坏性操作会接受此锁定，以防止同时修改相同的配置数据。在极少数情况下，如果中断了此操作，那么锁可能仍处于锁定状态，从而使破坏性操作无法进一步执行。unlock 命令可用于在此类情况下发布锁定。

**示例**

```bash
unlock
```

#### `list runtimes` 命令
{: #the-list-runtimes-command }
`list
runtimes` 命令返回已部署的运行时的列表。

语法：`list runtimes [--in-database]`

它采用以下选项：

| 选项 | 描述 | 
|--------|-------------|
| --in-database	| 是否在数据库中查看，而不是通过 MBeans
 | 
| --xml | 生成 XML 输出（而非表格输出）。 | 

**示例**

```bash
list runtimes
```

```bash
list runtimes --in-database
```

此命令基于[运行时 (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_runtimes_get.html?view=kc#Runtimes--GET-) REST 服务。


#### `show runtime` 命令
{: #the-show-runtime-command }
`show
runtime` 命令可显示有关给定的已部署运行时的信息。

语法：`show runtime [runtime-name]`

它采用以下参数：


| 参数 | 描述 | 
|----------|-------------|
| runtime-name | 运行时的名称。 | 

`show runtime` 命令在对象后采用以下选项。

| 选项 | 描述 | 
|--------|-------------|
| --xml | 生成 XML 输出（而非表格输出）。 | 

此命令基于[运行时 (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_runtime_get.html?view=kc#Runtime--GET-) REST 服务。


**示例**

```bash
show runtime mfp
```

#### `delete runtime` 命令
{: #the-delete-runtime-command }
`delete runtime` 命令从数据库中删除运行时，包括其应用程序和适配器。只有在运行时的 Web 应用程序停止时才能删除运行时。

语法：`delete runtime [runtime-name] condition`

它采用以下参数：


| 参数 | 描述 | 
|----------|-------------|
| runtime-name | 运行时的名称。 | 
| condition | 删除条件：empty 或 always。**注意：**请慎用 always 选项。 |

**示例**

```bash
delete runtime mfp empty
```

此命令基于[运行时 (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_runtime_delete.html?view=kc#Runtime--DELETE-) REST 服务。


#### `list farm-members` 命令
{: #the-list-farm-members-command }
`list
farm-members` 命令会返回在其上部署了指定运行时的场成员服务器的列表。

语法：`list farm-members [runtime-name]`

它采用以下参数：


| 参数 | 描述 | 
|----------|-------------|
| runtime-name | 运行时的名称。 | 

`list farm-members` 命令在对象后采用以下选项。

| 选项 | 描述 | 
|--------|-------------|
| --xml | 生成 XML 输出（而非表格输出）。 | 

**示例**

```bash
list farm-members mfp
```

此命令基于[场拓扑成员 (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_farm_topology_members_get.html?view=kc#Farm-topology-members--GET-) REST 服务。

#### `remove farm-member` 命令
{: #the-remove-farm-member-command }
`remove
farm-member` 命令可从在其上部署了指定运行时的场成员的列表中除去某个服务器。在服务器不可用或断开连接时，可使用此命令。

语法：`remove farm-member [runtime-name] server-id`

它采用以下参数。

| 参数 | 描述 | 
|----------|-------------|
| runtime-name | 运行时的名称。 | 
| server-id | 服务器的标识。 | 

`remove farm-member` 命令在对象后采用以下选项。

| 选项 | 描述 | 
|--------|-------------|
| --force | 强制除去场成员（即使在该成员可用且已连接的情况下）。 | 

**示例**

```bash
remove farm-member mfp srvlx15
```

此命令基于[场拓扑成员 (DELETE) ](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_farm_topology_members_delete.html?view=kc) REST 服务。
