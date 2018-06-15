---
layout: tutorial
title: 安装参考
weight: 9
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
有关用于安装 {{ site.data.keys.mf_server_full }}、{{ site.data.keys.mf_app_center_full }} 和 {{ site.data.keys.mf_analytics_full }} 的 Ant 任务和配置样本文件的参考信息。

#### 跳至：
{: #jump-to }
* [Ant configuredatabase 任务参考](#ant-configuredatabase-task-reference)
* [用于安装 {{ site.data.keys.mf_console }}、{{ site.data.keys.mf_server }} 工件、{{ site.data.keys.mf_server }} 管理和实时更新服务的 Ant 任务](#ant-tasks-for-installation-of-mobilefirst-operations-console-mobilefirst-server-artifacts-mobilefirst-server-administration-and-live-update-services)
* [用于安装 {{ site.data.keys.mf_server }} 推送服务的 Ant 任务](#ant-tasks-for-installation-of-mobilefirst-server-push-service)
* [用于安装 {{ site.data.keys.product_adj }} 运行时环境的 Ant 任务](#ant-tasks-for-installation-of-mobilefirst-runtime-environments)
* [用于安装 Application Center 的 Ant 任务](#ant-tasks-for-installation-of-application-center)
* [用于安装 {{ site.data.keys.mf_analytics }} 的 Ant 任务](#ant-tasks-for-installation-of-mobilefirst-analytics)
* [内部运行时数据库](#internal-runtime-databases)
* [样本配置文件](#list-of-sample-configuration-files)
* [{{ site.data.keys.mf_analytics }} 的样本配置文件](#sample-configuration-files-for-mobilefirst-analytics)

## Ant configuredatabase 任务参考
{: #ant-configuredatabase-task-reference }
configuredatabase Ant 任务的参考信息。 本参考信息仅针对关系数据库。 它不适用于 Cloudant。

**configuredatabase** Ant 任务创建由 {{ site.data.keys.mf_server }} 管理服务、{{ site.data.keys.mf_server }} 实时更新服务、{{ site.data.keys.mf_server }} 推送服务、{{ site.data.keys.product_adj }} 运行时和 Application Center 服务使用的关系数据库。 此 Ant 任务通过以下操作配置关系数据库：

* 检查 {{ site.data.keys.product_adj }} 表是否存在，并根据需要创建这些表。
* 如果存在较低版本的 {{ site.data.keys.product }} 的表，请将它们迁移至当前版本。
* 如果存在当前版本的 {{ site.data.keys.product }} 的表，那么无需执行任何操作。

此外，如果满足以下条件之一：

* DBMS 类型为 Derby。
* 存在内部元素 `<dba>`。
* DBMS 类型为 DB2，并且指定的用户具有创建数据库的许可权。

那么该任务可以产生以下影响：

* 根据需要创建数据库（Oracle 12c 和 Cloudant 除外）。
* 根据需要创建用户，并授予该用户访问该数据库的权利。

> **注：**如果您将 configuredatabase Ant 任务与 Cloudant 一同使用，此任务将不会产生任何影响。

### configuredatabase 任务的属性和元素
{: #attributes-and-elements-for-configuredatabase-task }

**configuredatabase** 任务具有以下属性：

| 属性 | 描述 | 必需 | 缺省值 |
|-----------|-------------|----------|---------|
| kind      | 数据库类型：在 {{ site.data.keys.mf_server }} 中为：MobileFirstRuntime、MobileFirstConfig、 MobileFirstAdmin 或 push。 在 Application Center 中为：ApplicationCenter。 | 是 | 无 |
| includeConfigurationTables | 指定是同时在实时更新服务和管理服务上还是仅在管理服务上执行数据库操作。 值为 true 或 false。 |  否 | true |
| execute | 指定是否执行 configuredatabase Ant 任务。 值为 true 或 false。 | 否 | true |

#### kind
{: #kind }
{{ site.data.keys.product }} 支持四种类型的数据库：{{ site.data.keys.product_adj }} 运行时使用 **MobileFirstRuntime** 数据库。 {{ site.data.keys.mf_server }} 管理服务使用 **MobileFirstAdmin** 数据库。 {{ site.data.keys.mf_server }} 实时更新服务使用 **MobileFirstConfig** 数据库。 缺省情况下，使用 **MobileFirstAdmin** 类型创建。 {{ site.data.keys.mf_server }} 推送服务使用 **push** 数据库。 Application Center 使用 **ApplicationCenter** 数据库。

#### includeConfigurationTables
{: #includeconfigurationtables }
只有当 **kind** 属性为 **MobileFirstAdmin** 时，才可以使用 **includeConfigurationTables** 属性。 有效值可能为 true 或 false。 当将此属性设置为 true 时，**configuredatabase** 任务将在单个运行中对管理服务数据库和实时更新服务数据库执行数据库操作。 当将此属性设置为 false 时，**configuredatabase** 任务将只对管理服务数据库执行数据库操作。

#### execute
{: #execute }
**execute** 属性将启用或禁用 **configuredatabase** Ant 任务的执行。 有效值可能为 true 或 false。 当将此属性设置为 false 时，**configuredatabase** 任务将不执行配置或数据库操作。

**configuredatabase** 任务支持以下元素：

| 元素             | 描述	                | 计数 |
|---------------------|-----------------------------|-------|
| `<derby>`           | Derby 的参数。   | 0..1  |
| `<db2>`             |	DB2 的参数。     | 0..1  |
| `<mysql>`           |	MySQL 的参数。   | 0..1  |
| `<oracle>`          |	Oracle 的参数。  | 0..1  |
| `<driverclasspath>` | JDBC 驱动程序类路径。 | 0..1  |

对于每种数据库类型，您可以使用 `<property>` 元素指定 JDBC 连接属性来访问该数据库。 `<property>` 元素具有以下属性：

| 属性 | 描述                | 必需 | 缺省值 |
|-----------|----------------------------|----------|---------|
| name      | 属性的名称。	 | 是      | 无    |
| value	    | 属性的值。| 是	    | 无    |   

#### Apache Derby
{: #apache-derby }
`<derby>` 元素具有以下属性：

| 属性 | 描述                                | 必需 | 缺省值                                                                      |
|-----------|--------------------------------------------|----------|------------------------------------------------------------------------------|
| database  | 数据库名称。                         | 否	    | MFPDATA、MFPADM、MFPCFG、MFPPUSH 或 APPCNTR，取决于类型。             |
| datadir   | 包含数据库的目录。 | 是      | 无                                                                         |
| schema	| 模式名称。                           | 否       | MFPDATA、MFPCFG、MFPADMINISTRATOR、MFPPUSH 或 APPCENTER，取决于类型。 |

`<derby>` 元素支持以下元素：

| 元素      | 描述                     | 计数   |
|--------------|---------------------------------|---------|
| `<property>` | JDBC 连接属性。   | 0..∞    |

有关可用属性，请参阅 [Setting attributes for the database connection URL](http://db.apache.org/derby/docs/10.11/ref/rrefattrib24612.html)。

#### DB2
{: #db2 }
`<db2>` 元素具有以下属性：

| 属性 | 描述                            | 必需 | 缺省值 |
|-----------|----------------------------------------|----------|---------|
| database  | 数据库名称。                     | 否       | MFPDATA、MFPADM、MFPCFG、MFPPUSH 或 APPCNTR，取决于类型。 |
| server    | 数据库服务器的主机名。	 | 是      | 无  |
| port      | 数据库服务器上的端口。       | 否	    | 50000 |
| user      | 用于访问数据库的用户名。 | 是	    | 无  |
| password  | 用于访问数据库的密码。	 | 否	    | 交互式查询 |
| instance  | DB2 实例的名称。          | 否	    | 取决于服务器 |
| schema    | 模式名称。                       | 否	    | 取决于用户   |

有关 DB2 用户帐户的更多信息，请参阅 [DB2 安全模型概述](http://ibm.biz/knowctr#SSEPGG_10.1.0/com.ibm.db2.luw.admin.sec.doc/doc/c0021804.html)。  
`<db2>` 元素支持以下元素：

| 元素      | 描述                             | 计数   |
|--------------|-----------------------------------------|---------|
| `<property>` | JDBC 连接属性。           | 0..∞    |
| `<dba>`      | 数据库管理员凭证。 | 0..1    |

有关可用属性，请参阅 [IBM  Data Server Driver for JDBC and SQLJ 的属性](http://ibm.biz/knowctr#SSEPGG_10.1.0/com.ibm.db2.luw.apdv.java.doc/src/tpc/imjcc_rjvdsprp.html)。  
内部元素 `<dba>` 指定数据库管理员的凭证。 此元素具有以下属性：

| 属性 | 描述                            | 必需 | 缺省值 |
|-----------|----------------------------------------|----------|---------|
| user      | 用于访问数据库的用户名。  | 是      | 无    |
| password  | 用于访问数据库的密码。    | 否	    | 交互式查询 |

在 `<dba>` 元素中指定的用户必须具有 SYSADM 或 SYSCTRL DB2 特权。 有关更多信息，请参阅[权限概述](http://ibm.biz/knowctr#SSEPGG_10.1.0/com.ibm.db2.luw.admin.sec.doc/doc/c0055206.html)。

`<driverclasspath>` 元素必须包含 DB2 JDBC 驱动程序和关联许可证的 JAR 文件。 您可以通过以下某种方式检索这些文件：

* 从 [DB2 JDBC Driver Versions](http://www.ibm.com/support/docview.wss?uid=swg21363866) 页面下载 DB2 JDBC 驱动程序
* 或从 DB2 服务器上的 **DB2_INSTALL_DIR/java** 目录访存 **db2jcc4.jar** 文件及其关联的 **db2jcc_license_*.jar** 文件。

不能通过使用 Ant 任务来指定表分配的详细信息，例如，表空间。 要控制表空间，必须使用 [DB2 数据库和用户需求](../databases/#db2-database-and-user-requirements)部分中的手动操作指示信息。

#### MySQL
{: #mysql }
元素 `<mysql>` 具有以下属性：

| 属性 | 描述                            | 必需 | 缺省值 |
|-----------|----------------------------------------|----------|---------|
| database	| 数据库名称。	                 | 否       | MFPDATA、MFPADM、MFPCFG、MFPPUSH 或 APPCNTR，取决于类型。 |
| server	| 数据库服务器的主机名。	 | 是	    | 无 |
| port	    | 数据库服务器上的端口。	     | 否	    | 3306 |
| user	    | 用于访问数据库的用户名。 | 是	    | 无 |
| password	| 用于访问数据库的密码。	 | 否	    | 交互式查询 |

有关 MySQL 用户帐户的更多信息，请参阅 [MySQL 用户帐户管理](http://dev.mysql.com/doc/refman/5.5/en/user-account-management.html)。  
`<mysql>` 元素支持以下元素：

| 元素      | 描述                                      | 计数 |
|--------------|--------------------------------------------------|-------|
| `<property>` | JDBC 连接属性。                    | 0..∞  |
| `<dba>`      | 数据库管理员凭证。          | 0..1  |
| `<client>`   | 允许访问数据库的主机。 | 0..∞  |

有关可用属性，请参阅 [Driver/Datasource Class Names, URL Syntax and Configuration Properties for Connector/J](http://dev.mysql.com/doc/connector-j/en/connector-j-reference-configuration-properties.html)。  
内部元素 `<dba>` 指定数据库管理员凭证。 此元素具有以下属性：

| 属性 | 描述                            | 必需 | 缺省值 |
|-----------|----------------------------------------|----------|---------|
| user	    | 用于访问数据库的用户名。 | 是	    | 无 |
| password	| 用于访问数据库的密码。	 | 否	    | 交互式查询 |

在 `<dba>` 元素中指定的用户必须是 MySQL 超级用户帐户。 有关更多信息，请参阅 [Securing the Initial MySQL Accounts](http://dev.mysql.com/doc/refman/5.5/en/default-privileges.html)。

每个 `<client>` 内部元素指定一台客户端计算机或表示多台客户端计算机的通配符。 这些计算机可以连接到数据库。 此元素具有以下属性：

| 属性 | 描述                                                              | 必需 | 缺省值 |
|-----------|--------------------------------------------------------------------------|----------|---------|
| hostname	| 将 % 作为占位符的符号主机名、IP 地址或模板。 | 是	  | 无    |

有关 hostname 语法的更多信息，请参阅 [Specifying Account Names](http://dev.mysql.com/doc/refman/5.5/en/account-names.html)。

`<driverclasspath>` 元素必须包含一个 MySQL Connector/J JAR 文件。 可以从 [Download
Connector/J](http://www.mysql.com/downloads/connector/j/) 页面下载该文件。

或者，您可以将 `<mysql>` 元素与以下属性结合使用：

| 属性 | 描述                            | 必需 | 缺省值               |
|-----------|----------------------------------------|----------|-----------------------|
| url       | 数据库连接 URL。	         | 是      | 无                  |
| user	    | 用于访问数据库的用户名。 | 是      | 无                  |
| password	| 用于访问数据库的密码。	 | 否       | 交互式查询 |

> `注：`如果使用替代属性指定数据库，该数据库和用户帐户都必须存在，数据库也必须能供用户访问。 在这种情况下，**configuredatabase** 任务不会尝试创建数据库或用户，也不会尝试向用户授予访问权。 **configuredatabase** 任务仅
确保数据库具有当前
{{ site.data.keys.mf_server }}
版本的必需表。 您无需指定内部元素 `<dba>` 或 `<client>`。

#### Oracle
{: #oracle }
元素 `<oracle>` 具有以下属性：

| 属性      | 描述                                                              | 必需 | 缺省值 |
|----------------|--------------------------------------------------------------------------|----------|---------|
| database       | 数据库名称或 Oracle 服务名称。 **注：**必须始终使用服务名称来连接到 PDB 数据库。 | 否 | ORCL |
| server	     | 数据库服务器的主机名。                                    | 是      | 无 |
| port	         | 数据库服务器上的端口。                                         | 否       | 1521 |
| user	         | 用于访问数据库的用户名。 请参阅此表下方的注释。	| 是      | 无 |
| password	     | 用于访问数据库的密码。                                    | 否       | 交互式查询 |
| sysPassword	 | 用户 SYS 的密码。                                           | 否       | 交互式查询（如果数据库尚不存在） |
| systemPassword | 用户 SYSTEM 的密码。                                        | 否       | 交互式查询（如果数据库或用户尚不存在） |

> `注：` 对于 user 属性，最好使用大写字母的用户名。 Oracle 用户名通常为大写字母。 不像其他数据库工具，**configuredatabase** Ant 任务不会将用户名中的小写字母转换为大写字母。 如果 **configuredatabase** Ant 任务无法连接到您的数据库，请尝试用大写字母为 **user** 属性输入值。

有关 Oracle 用户帐户的更多信息，请参阅[认证方法概述](http://docs.oracle.com/cd/B28359_01/server.111/b28318/security.htm#i12374)。  
`<oracle>` 元素支持以下元素：

| 元素      | 描述                                      | 计数 |
|--------------|--------------------------------------------------|-------|
| `<property>` | JDBC 连接属性。                    | 0..∞  |
| `<dba>`      | 数据库管理员凭证。          | 0..1  |

有关可用连接属性的信息，请参阅 [Class OracleDriver](http://docs.oracle.com/cd/E11882_01/appdev.112/e13995/oracle/jdbc/OracleDriver.html)。  
内部元素 `<dba>` 指定数据库管理员凭证。 此元素具有以下属性：

| 属性      | 描述                                                              | 必需 | 缺省值 |
|----------------|--------------------------------------------------------------------------|----------|---------|
| user	         | 用于访问数据库的用户名。 请参阅此表下方的注释。	| 是      | 无    |
| password	     | 用于访问数据库的密码。                                    | 否       | 交互式查询 |

`<driverclasspath>` 元素必须包含一个 Oracle JDBC 驱动程序 JAR 文件。 可以从 [JDBC, SQLJ, Oracle JPublisher and Universal Connection
Pool (UCP)](http://www.oracle.com/technetwork/database/features/jdbc/index-091264.html) 下载 Oracle JDBC 驱动程序。

不能通过使用 Ant 任务来指定表分配的详细信息，例如，表空间。 要控制表空间，可以手动创建用户帐户并在运行 Ant 任务之前向其分配缺省表空间。 要控制其他详细信息，必须使用 [Oracle 数据库和用户需求](../databases/#oracle-database-and-user-requirements)部分中的手动操作指示信息。

| 属性 | 描述                            | 必需 | 缺省值               |
|-----------|----------------------------------------|----------|-----------------------|
| url       | 数据库连接 URL。	         | 是      | 无                  |
| user	    | 用于访问数据库的用户名。 | 是      | 无                  |
| password	| 用于访问数据库的密码。	 | 否       | 交互式查询 |

> **注：**如果使用替代属性指定数据库，该数据库和用户帐户都必须存在，数据库也必须能供用户访问。 在这种情况下，任务不会尝试创建数据库或用户，也不会尝试向用户授予访问权。 **configuredatabase** 任务仅
确保数据库具有当前
{{ site.data.keys.mf_server }}
版本的必需表。 您无需指定内部元素 `<dba>`。

## 用于安装 {{ site.data.keys.mf_console }}、{{ site.data.keys.mf_server }} 工件、{{ site.data.keys.mf_server }} 管理和实时更新服务的 Ant 任务
{: #ant-tasks-for-installation-of-mobilefirst-operations-console-mobilefirst-server-artifacts-mobilefirst-server-administration-and-live-update-services }
现在提供了 **installmobilefirstadmin**、**updatemobilefirstadmin** 和 **uninstallmobilefirstadmin** Ant 任务以用于安装 {{ site.data.keys.mf_console }}、工件组件、管理服务和实时更新服务。

### 任务影响
{: #task-effects }

#### installmobilefirstadmin
{: #installmobilefirstadmin }
**installmobilefirstadmin** Ant 任务将配置应用程序服务器，以将管理和实时更新服务的 WAR 文件作为 Web 应用程序运行并（可选）安装 {{ site.data.keys.mf_console }}。 该任务具有以下影响：

* 此任务将在指定上下文根（缺省情况下为 /mfpadmin）中声明管理服务 Web 应用程序。
* 此任务将在从管理服务的指定上下文根中获取的上下文根中声明实时更新服务 Web 应用程序。 缺省情况下为 /mfpadminconfig。
* 对于关系数据库，此任务将为管理服务声明数据源以及（在 WebSphere Application Server Full Profile 上）JDBC 提供程序。
* 此任务将在应用程序服务器上部署管理服务和实时更新服务。
* （可选）此任务将在指定的上下文根（缺省情况下为 /mfpconsole）中将 {{ site.data.keys.mf_console }} 声明为 Web 应用程序。 如果已指定 {{ site.data.keys.mf_console }}实例，那么 Ant 任务将声明与对应管理服务进行通信的相应 JNDI 环境。 例如，

```xml
<target name="adminstall">
  <installmobilefirstadmin servicewar="${mfp.service.war.file}">
    <console install="${mfp.admin.console.install}" warFile="${mfp.console.war.file}"/>
```

* （可选）在安装了 {{ site.data.keys.mf_console }} 时，此任务将在指定的上下文根 /mfp-dev-artifacts 中将 {{ site.data.keys.mf_server }} 工件声明为 Web 应用程序。
* 此任务将使用 JNDI 环境条目配置管理服务的配置属性。 这些 JNDI 环境条目还给出一些关于应用程序服务器拓扑的其他信息，例如拓扑是独立配置、集群还是服务器场。
* （可选）此任务将对用户进行配置，将其映射到 {{ site.data.keys.mf_console }} 以及管理和实时更新服务 Web 应用程序所使用的角色。
* 此任务配置应用程序服务器以供 JMX 使用。
* （可选）此任务将配置与 {{ site.data.keys.mf_server }} 推送服务之间的通信。
* （可选）设置 MobileFirst JNDI 环境条目以将应用程序服务器配置为 {{ site.data.keys.mf_server }} 管理部分的服务器场成员。

#### updatemobilefirstadmin
{: #updatemobilefirstadmin }
**updatemobilefirstadmin** Ant 任务将更新已在应用程序服务器上配置的 {{ site.data.keys.mf_server }} Web 应用程序。 该任务具有以下影响：

* 此任务将更新管理服务 WAR 文件。 该文件的基本名称与先前部署的对应 WAR 文件的基本名称必须完全相同。
* 此任务将更新实时更新服务 WAR 文件。 该文件的基本名称与先前部署的对应 WAR 文件的基本名称必须完全相同。
* 此任务将更新 {{ site.data.keys.mf_console }} WAR 文件。 该文件的基本名称与先前部署的对应 WAR 文件的基本名称必须完全相同。
该任务不会更改应用程序服务器配置，即 Web 应用程序配置、数据源、JNDI 环境条目、用户到角色映射以及 JMX 配置。

#### uninstallmobilefirstadmin
{: #uninstallmobilefirstadmin }
**uninstallmobilefirstadmin** Ant 任务撤销早期运行 installmobilefirstadmin 的影响。 该任务具有以下影响：

* 此任务将除去具有指定上下文根的管理服务 Web 应用程序配置。 因此，此任务还将除去手动添加到该应用程序的设置。
* 此任务将从作为选项的应用程序服务器中除去管理服务和实时更新服务以及 {{ site.data.keys.mf_console }} 的 WAR 文件。
* 对于关系 DBMS，此任务将除去管理服务和实时更新服务的数据源以及（在 WebSphere Application Server Full Profile 上）JDBC 提供程序。
* 对于关系 DBMS，此任务将从应用程序服务器中除去已由管理服务和实时更新服务使用的数据库驱动程序。
* 此任务将除去关联的 JNDI 环境条目。
* 在 WebSphere Application Server Liberty 和 Apache Tomcat 上，此任务将除去 installmobilefirstadmin 调用配置的用户。
* 此任务将除去 JMX 配置。

### 属性和元素
{: #attributes-and-elements }
**installmobilefirstadmin**、**updatemobilefirstadmin** 和 **uninstallmobilefirstadmin** Ant 任务具有以下属性：

| 属性         | 描述                                                              | 必需 | 缺省值 |
|-------------------|--------------------------------------------------------------------------|----------|---------|
| contextroot       | 用于获取 {{ site.data.keys.product_adj }} 运行时环境、应用程序和适配器相关信息的管理服务 URL 的通用前缀。 | 否 | /mfpadmin |
| id                | 区分不同的部署。              | 否 | 空 |
| environmentId     | 区分不同的 {{ site.data.keys.product_adj }} 环境。 | 否 | 空 |
| servicewar        | 管理服务的 WAR 文件。       | 否 | mfp-admin-service.war 文件与 mfp-ant-deployer.jar 文件位于同一目录中。 |
| shortcutsDir      | 放置快捷方式的目录。            | 否 | 无 |
| wasStartingWeight | WebSphere Application Server 的启动顺序。 从较小的值开始启动。 | 否 | 1 |

#### contextroot 和 id
{: #contextroot-and-id }
**contextroot** 和 **id** 属性区分                                  {{ site.data.keys.mf_console }} 和管理服务的不同部署。

在 WebSphere Application Server Liberty Profile 和 Tomcat 环境中，contextroot 参数足以实现该目的。 在 WebSphere Application Server Full Profile 环境中，改为使用 id 属性。 没有该 id 属性时，使用同一上下文根的两个 WAR 文件可能会冲突，并无法部署这些文件。

#### environmentId
{: #environmentid }
使用 **environmentId** 属性可区分多个环境，包括必须独立运行的每个 {{ site.data.keys.mf_server }} 管理服务和 {{ site.data.keys.product_adj }} 运行时 Web 应用程序。 例如，使用该选项，您可以在同一个服务器或同一个 WebSphere Application Server Network Deployment 单元中托管测试环境、预生产环境和生产环境。 该 environmentId 属性会创建一个后缀，此后缀会添加到管理服务和 {{ site.data.keys.product_adj }} 运行时项目通过 Java 管理扩展 (JMX) 进行通信时使用的 MBean 名称上。

#### servicewar
{: #servicewar }
使用 **servicewar** 属性来指定管理服务 WAR 文件的不同目录。 您可以使用绝对路径或相对路径来指定该 WAR 文件的名称。

#### shortcutsDir
{: #shortcutsdir }
**shortcutsDir** 属性指定将快捷方式放置在 {{ site.data.keys.mf_console }}的何处。 如果设置该属性，可以将以下文件添加到该目录：

* **mobilefirst-console.url** - 该文件是 Windows 快捷方式。 该文件会在浏览器中打开 {{ site.data.keys.mf_console }}。
* **mobilefirst-console.sh**- 该文件是 UNIX shell 脚本，并在浏览器中打开 {{ site.data.keys.mf_console }}。
* **mobilefirst-admin-service.url** - 该文件是 Windows 快捷方式。 将在浏览器中打开该文件，它将调用一个 REST 服务来返回可管理的 {{ site.data.keys.product_adj }} 项目列表（JSON 格式）。 对于每个列出的 {{ site.data.keys.product_adj }} 项目，还提供了关于其工件的某些详细信息，如应用程序数、适配器数、活动设备数以及停用设备数。 该列表还指示 {{ site.data.keys.product_adj }} 项目运行时是正在运行还是空闲。
* **mobilefirst-admin-service.sh** - 该文件是 UNIX shell 脚本，它提供的输出与 **mobilefirst-admin-service.url** 文件提供的输出完全相同。

#### wasStartingWeight
{: #wasstartingweight }
使用 **wasStartingWeight** 属性将 WebSphere Application Server 中使用的值指定为权重，以确保启动顺序的稳定可靠。 根据启动顺序值，在任何其他 {{ site.data.keys.product_adj }} 运行时项目之前部署和启动管理服务 Web 应用程序。 如果在 Web 应用程序之前部署或启动 {{ site.data.keys.product_adj }} 项目，将不会建立 JMX 通信，运行时无法与管理服务数据库同步，并且无法处理服务器请求。

**installmobilefirstadmin**、**updatemobilefirstadmin** 和 **uninstallmobilefirstadmin** Ant 任务支持以下元素：

| 元素               | 描述                                      | 计数 |
|-----------------------|--------------------------------------------------|-------|
| `<applicationserver>` | 应用程序服务器。                          | 1     |
| `<configuration>`     | 实时更新服务。	                       | 1     |
| `<console>`           | 管理控制台。                      | 0..1  |
| `<database>`          | 数据库。                                   | 1     |
| `<jmx>`               | 启用 Java 管理扩展。	           | 1     |
| `<property>`          | 属性。	                               | 0..   |
| `<push>`              | 推送服务。	                               | 0..1  |
| `<user>`              | 要映射到安全角色的用户。	       | 0..   |

### 指定 {{ site.data.keys.mf_console }}
{: #to-specify-a-mobilefirst-operations-console }
`<console>` 元素收集信息以定制 {{ site.data.keys.mf_console }} 的安装。 此元素具有以下属性：

| 属性         | 描述                                                               | 必需 | 缺省值     |
|-------------------|---------------------------------------------------------------------------|----------|-------------|
| contextroot       | {{ site.data.keys.mf_console }} 的 URI。                            | 否       | /mfpconsole |
| install           | 指示是否必须安装 {{ site.data.keys.mf_console }}。 | 否       | 是         |
| warfile           | 控制台 WAR 文件。	                                                    |否        | mfp-admin-ui.war 文件与 mfp-ant-deployer.jar 文件位于同一目录中。 |

`<console>` 元素支持以下元素：

| 元素               | 描述                                      | 计数 |
|-----------------------|--------------------------------------------------|-------|
| `<artifacts>`         | {{ site.data.keys.mf_server }} 工件。                | 0..1  |
| `<property>`	        | 属性。	                               | 0..   |

`<artifacts>` 元素具有以下属性：

| 属性         | 描述                                                               | 必需 | 缺省值     |
|-------------------|---------------------------------------------------------------------------|----------|-------------|
| install           | 用于指示是否必须安装工件组件。            | 否       | true        |
| warFile           | 工件 WAR 文件。                                                   | 否       | mfp-dev-artifacts.war 文件与 mfp-ant-deployer.jar 文件位于同一目录中 |

使用该元素时，可以定义自己的 JNDI 属性，或覆盖管理服务和 {{ site.data.keys.mf_console }} WAR 文件提供的 JNDI 属性的缺省值。

`<property>` 元素指定了要在应用程序服务器中定义的部署属性。 它具有以下属性：

| 属性  | 描述                | 必需 | 缺省值 |
|------------|----------------------------|----------|---------|
| name       | 属性的名称。  | 是      | 无    |
| value	     | 属性的值。 |	是      | 无    |

使用该元素时，可以定义自己的 JNDI 属性，或覆盖管理服务和 {{ site.data.keys.mf_console }} WAR 文件提供的 JNDI 属性的缺省值。

有关 JNDI 属性的更多信息，请参阅 [{{ site.data.keys.mf_server }} 管理服务的 JNDI 属性列表](../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service)。

### 指定应用程序服务器
{: #to-specify-an-application-server }
使用 `<applicationserver>` 元素来定义依赖底层应用程序服务器的参数。 `<applicationserver>` 元素支持以下元素。

| 元素                                   | 描述                                      | 计数 |
|-------------------------------------------|--------------------------------------------------|-------|
| `<websphereapplicationserver>` 或 `<was>` | WebSphere Application Server 的参数。 <br/><br/>`<websphereapplicationserver>` 元素（或其缩写形式 `was>`）表示 WebSphere Application Server 实例。 WebSphere Application Server Full Profile（Base 和 Network Deployment）与 WebSphere Application Server Liberty Core 和 WebSphere Application Server Liberty Network Deployment 一样受支持。               | 0..1  |
| `<tomcat>`                                | Apache Tomcat 的参数。	               | 0..1  |

在[用于安装 {{ site.data.keys.product_adj }} 运行时环境的 Ant 任务](#ant-tasks-for-installation-of-mobilefirst-runtime-environments)表中描述了这些元素的属性和内部元素。  
但是，有关用于 Liberty 集合体的 `<was>` 元素的内部元素，请参阅下表：

| 元素                  | 描述                      | 计数 |
|--------------------------|----------------------------------|-------|
| `<collectiveController>` | Liberty 集合体控制器。 |	0..1  |

`<collectiveController>` 元素具有以下属性：

| 属性                | 描述                            | 必需 | 缺省值 |
|--------------------------|----------------------------------------|----------|---------|
| serverName               | 集合体控制器的名称。	| 是      | 无    |
| controllerAdminName      | 集合体控制器中定义的管理用户名。 此用户还负责将新成员加入到集合体中。                                                         | 是      | 无    |
| controllerAdminPassword  | 管理用户密码。	    | 是      | 无    |
| createControllerAdmin    | 用于指示是否必须在集合体控制器的基本注册表中创建管理用户。 可能值为 true 或 false。                                                              | 否	   | true    |

### 指定实时更新服务配置
{: #to-specify-the-live-update-service-configuration }
使用 `<configuration>` 元素来定义依赖于实时更新服务的参数。 `<configuration>` 元素具有以下属性。

| 属性                | 描述                                                    | 必需 | 缺省值 |
|--------------------------|----------------------------------------------------------------|----------|---------|
| install                  | 指示是否必须安装实时更新服务。	| 是 | true |
| configAdminUser	       | 实时更新服务的管理员。	                | 否。但对于服务器场拓扑而言必需。 |如果未定义，将生成用户。 在服务器场拓扑中，对于场的所有成员，该用户名必须相同。 |
| configAdminPassword      | 实时更新服务用户的管理员密码。       | 如果对 **configAdminUser** 指定了用户。 | 无。 在服务器场拓扑中，对于场的所有成员，该密码必须相同。 |
| createConfigAdminUser	   | 用于指示是否在应用程序服务器的基本注册表中创建管理用户（如果缺失）。 | 否 | true |
| warFile                  | 实时更新服务的 WAR 文件。	                            | 否         | mfp-live-update.war 文件与 mfp-ant-deployer.jar 文件位于同一目录中。 |

`<configuration>` 元素支持以下元素：

| 元素      | 描述                           | 计数 |
|--------------|---------------------------------------|-------|
| `<user>`     | 实时更新服务的用户。 | 0..1  |
| `<property>` | 属性。	                   | 0..   |

`<user>` 元素收集关于用户的参数以包含在应用程序的某些安全角色中。

| 属性   | 描述                                                             | 必需 | 缺省值 |
|-------------|-------------------------------------------------------------------------|----------|---------|
| role	      | 应用程序的有效安全角色。 可能的值：configadmin。	| 是      | 无    |
| name	      | 用户名。	                                                        | 是      | 无    |
| password	  | 需要创建用户时的密码。	                        | 否       | 无    |

使用 `<user>` 元素定义用户之后，可以将其映射到以下任一角色以供在 {{ site.data.keys.mf_console }} 中进行认证：`configadmin`。

有关特定角色暗示哪些授权的更多信息，请参阅[配置 {{ site.data.keys.mf_server }} 管理的用户认证](../server-configuration/#configuring-user-authentication-for-mobilefirst-server-administration)。

> **提示：**如果用户存在于外部 LDAP 目录中，仅设置 **role** 和 **name** 属性，但是不定义任何密码。

`<property>` 元素指定了要在应用程序服务器中定义的部署属性。 它具有以下属性：

| 属性  | 描述                | 必需 | 缺省值 |
|------------|----------------------------|----------|---------|
| name       | 属性的名称。  | 是      | 无    |
| value	     | 属性的值。 |	是      | 无    |

使用该元素时，可以定义自己的 JNDI 属性，或覆盖管理服务和 {{ site.data.keys.mf_console }} WAR 文件提供的 JNDI 属性的缺省值。 有关 JNDI 属性的更多信息，请参阅 [{{ site.data.keys.mf_server }} 管理服务的 JNDI 属性列表](../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service)。

### 指定应用程序服务器
{: #to-specify-an-application-server-1 }
使用 `<applicationserver>` 元素来定义依赖底层应用程序服务器的参数。 `<applicationserver>` 元素支持以下元素：

| 元素      | 描述                                              | 计数 |
|--------------|--------------------------------------------------------- |-------|
| `<websphereapplicationserver>` 或 `<was>`	| WebSphere Application Server 的参数。<br/><br/><websphereapplicationserver> 元素（或其缩写形式 <was>）表示 WebSphere Application Server 实例。 WebSphere Application Server Full Profile（Base 和 Network Deployment）与 WebSphere Application Server Liberty Core 和 WebSphere Application Server Liberty Network Deployment 一样受支持。 | 0..1  |
| `<tomcat>`   | Apache Tomcat 的参数。                        | 0..1  |

在[用于安装 {{ site.data.keys.product_adj }} 运行时环境的 Ant 任务](#ant-tasks-for-installation-of-mobilefirst-runtime-environments)表中描述了这些元素的属性和内部元素。  
但是，有关用于 Liberty 集合体的 <was> 元素的内部元素，请参阅下表：

| 元素               | 描述                  | 计数 |
|-----------------------|----------------------------- |-------|
| `<collectiveMember>`	| Liberty 集合体成员。 | 0..1  |

`<collectiveMember>` 元素具有以下属性：

| 属性   | 描述                                             | 必需 | 缺省值 |
|-------------|---------------------------------------------------------|----------|---------|
| serverName  |	集合体成员的名称。                      | 是      | 无    |
| clusterName |	集合体成员所属的集群名称。 | 是	   | 无    |

> **注：**如果推送服务和运行时组件安装在同一个集合体成员中，那么它们必须具有相同的集群名称。 如果这些组件安装在同一个集合体的不同成员中，那么集群名称可以不同。

### 指定分析
{: #to-specify-analytics }
`<analytics>` 元素表示您想要将 {{ site.data.keys.product_adj }} 推送服务连接至已安装的 {{ site.data.keys.mf_analytics }} 服务。 它具有以下属性：

| 属性     | 描述                                                               | 必需 | 缺省值 |
|---------------|---------------------------------------------------------------------------|----------|---------|
| install	    | 指示是否将推送服务连接到 {{ site.data.keys.mf_analytics }}。 | 否       | false   |
| analyticsURL 	| {{ site.data.keys.mf_analytics }} 服务的 URL。	                            | 是	   | 无    |
| username	    | 用户名。	                                                        | 是	   | 无    |
| password	    | 密码。	                                                            | 是	   | 无    |
| validate	    | 验证 {{ site.data.keys.mf_analytics_console }} 是否可以访问。	| 否	   | true    |

**install**  
使用 install 属性来指示必须将该推送服务连接至 {{ site.data.keys.mf_analytics }}，并向其发送事件。 有效值为 true 或 false。

**analyticsURL**  
使用 analyticsURL 属性来指定由收到入局分析数据的 {{ site.data.keys.mf_analytics }} 公开的 URL。

例如：`http://<hostname>:<port>/analytics-service/rest`

**username**  
使用 username 属性来指定通过基本认证保护 {{ site.data.keys.mf_analytics }} 的数据入口点时所使用的用户名。

**password**  
使用 password 属性来指定通过基本认证保护 {{ site.data.keys.mf_analytics }} 的数据入口点时所使用的密码。

**validate**  
使用 validate 属性来验证 {{ site.data.keys.mf_analytics_console }} 是否可以访问，并使用密码检查用户名认证。 可能的值为 true 或 false。

### 指定到推送服务数据库的连接
{: #to-specify-a-connection-to-the-push-service-database }

`<database>` 元素收集应用程序服务器中指定数据源声明的参数以访问推送服务数据库。

您必须声明单个数据库：`<database kind="Push">`。 指定 `<database>` 元素类似于 configuredatabase Ant 任务，但是 `<database>` 元素不包含 `<dba>` 和 `<client>` 元素。 它可能具有 `<property>` 元素。

`<database>` 元素具有以下属性：

| 属性     | 描述                                     | 必需 | 缺省值 |
|---------------|-------------------------------------------------|----------|---------|
| kind          | 数据库类型 (Push)。	                  | 是	     | 无    |
| validate	    | 验证数据库是否可以访问。 | 否       | true    |

`<database>` 元素支持以下元素。 有关关系 DBMS 的这些数据库元素配置的更多信息，请参阅 [用于安装 {{ site.data.keys.product_adj }} 运行时环境的 Ant 任务](#ant-tasks-for-installation-of-mobilefirst-runtime-environments)表。

| 元素            | 描述                                                      | 计数 |
|--------------------|----------------------------------------------------------------- |-------|
| <db2>	             | DB2 数据库的参数。	                            | 0..1  |
| <derby>	         | Apache Derby 数据库的参数。	                    | 0..1  |
| <mysql>	         | MySQL 数据库的参数。                               | 0..1  |
| <oracle>	         | Oracle 数据库的参数。	                            | 0..1  |
| <cloudant>	     | Cloudant 数据库的参数。	                        | 0..1  |
| <driverclasspath>	 | JDBC 驱动程序类路径的参数（仅限关系 DBMS）。 | 0..1  |

> **注：**`<cloudant>` 元素的属性与运行时稍有不同。 有关更多信息，请参阅下表：

| 属性     | 描述                                     | 必需 | 缺省值                   |
|---------------|-------------------------------------------------|----------|---------------------------|
| url           | Cloudant 帐户的 URL。                | 否       | https://user.cloudant.com |
| user          | Cloudant 帐户的用户名。	      | 是	     | 无                      |
| password      | Cloudant 帐户的密码。	          | 否	     | 交互式查询     |
| dbName        | Cloudant 数据库名称。 **要点：**该数据库名称必须以小写字母开头，并且只能包含小写字符 (a-z)、数字 (0-9) 及以下任意字符：_、$ 和 -。                                | 否       | mfp_push_db               |

## 用于安装 {{ site.data.keys.mf_server }} 推送服务的 Ant 任务
{: #ant-tasks-for-installation-of-mobilefirst-server-push-service }
**installmobilefirstpush**、**updatemobilefirstpush** 和 **uninstallmobilefirstpush** Ant 任务是为了推送服务的安装而提供的。

### 任务影响
{: #task-effects-1 }
#### installmobilefirstpush
{: #installmobilefirstpush }
**installmobilefirstpush** Ant 任务配置应用程序服务器，以将推送服务 WAR 文件作为 Web 应用程序运行。 此任务具有以下影响：此任务将在 **/imfpush** 上下文根中声明推送服务 Web 应用程序。 无法更改上下文根。
对于关系数据库，此任务将为推送服务声明数据源以及（在 WebSphere Application Server Full Profile 上）JDBC 提供程序。
此任务将使用 JNDI 环境条目配置推送服务的配置属性。 这些 JNDI 环境条目将配置与 {{ site.data.keys.product_adj }} 授权服务器、{{ site.data.keys.mf_analytics }} 以及 Cloudant（如果使用 Cloudant）的 OAuth 通信。

#### updatemobilefirstpush
{: #updatemobilefirstpush }
**updatemobilefirstpush** Ant 任务将更新已在应用程序服务器上配置的 {{ site.data.keys.mf_server }} Web 应用程序。 此任务将更新推送服务 WAR 文件。 该文件的基本名称与先前部署的对应 WAR 文件的基本名称必须完全相同。

#### uninstallmobilefirstpush
{: #uninstallmobilefirstpush }
**uninstallmobilefirstpush** Ant 任务将撤销早期运行 **installmobilefirstpush** 的影响。 此任务具有以下影响：将除去具有指定上下文根的推送服务 Web 应用程序配置。 因此，此任务还将除去手动添加到该应用程序的设置。
此任务提供从应用程序服务器中除去推送服务 WAR 文件的选项。
对于关系 DBMS，此任务将除去推送服务的数据源以及（在 WebSphere Application Server Full Profile 上）JDBC 提供程序。
此任务将除去关联的 JNDI 环境条目。

### 属性和元素
{: #attributes-and-elements-1 }
**installmobilefirstpush**、**updatemobilefirstpush** 和 **uninstallmobilefirstpush** Ant 任务具有以下属性：

| 属性 | 描述                           | 必需 | 缺省值     |
|-----------|---------------------------------------|----------|-------------|
| id        | 区分不同的部署。	| 否	   | 空
| warFile	| 推送服务的 WAR 文件。	| 否	   | ../PushService/mfp-push-service.war 文件相对于包含 mfp-ant-deployer.jar 文件的 MobileFirstServer 目录。 |

### Id
{: #id }
**id** 属性可区分同一个 WebSphere Application Server 单元中推送服务的不同部署。 没有该 id 属性时，使用同一上下文根的两个 WAR 文件可能会冲突，并无法部署这些文件。

### warFile
{: #warfile }
使用 **warFile** 属性来指定推送服务 WAR 文件的不同目录。 您可以使用绝对路径或相对路径来指定该 WAR 文件的名称。

**installmobilefirstpush**、**updatemobilefirstpush** 和 **uninstallmobilefirstpush** Ant 任务支持以下元素：

| 元素               | 描述             | 计数 |
|-----------------------|-------------------------|-------|
| `<applicationserver>` | 应用程序服务器。 | 1     |
| `<analytics>`	        | 分析。	      | 0..1  |
| `<authorization>`	    | 授权服务器，用于认证与其他 {{ site.data.keys.mf_server }} 组件的通信。 | 1 |
| `<database>`	        | 数据库。	      | 1     |
| `<property>`	        | 属性。	      | 0..∞  |

### 指定授权服务器
{: #to-specify-the-authorization-server }
`<authorization>` 元素将收集信息以配置授权服务器，与其他 {{ site.data.keys.mf_server }} 组件进行认证通信。 此元素具有以下属性：

| 属性          | 描述                           | 必需 | 缺省值     |
|--------------------|---------------------------------------|----------|-------------|
| auto               | 指示是否计算授权服务器 URL。 可能的值为 true 或 false。	| 在 WebSphere Application Server Network Deployment 集群或节点上需要。   	 | true |
| authorizationURL   | 授权服务器的 URL。	 | 如果方式不是 auto。 | 本地服务器上运行时的上下文根。 |
| runtimeContextRoot | 运行时的上下文根。	     | 否	     | /mfp       |
| pushClientID	     | 授权服务器中的推送服务保密标识。  | 是 | 无 |
| pushClientSecret	 | 授权服务器中的推送服务保密客户机密码。 | 是 | 无 |

#### auto
{: #auto }
如果将此值设置为 true，那么将使用本地应用程序服务器上运行时的上下文根来自动计算授权服务器的 URL。 如果在集群中的 WebSphere Application Server Network Deployment 上部署，将不支持 auto 方式。

#### authorizationURL
{: #authorizationurl }
授权服务器的 URL。 如果授权服务器是 {{ site.data.keys.product_adj }} 运行时，那么该 URL 是运行时的 URL。 例如：`http://myHost:9080/mfp`。

#### runtimeContextRoot
{: #runtimecontextroot }
用于以自动方式计算授权服务器的 URL 的运行时上下文根。
#### pushClientID
{: #pushclientid }
此充当授权服务器的保密客户机的推送服务实例的标识。 必须为授权服务器注册标识和密钥。 可以通过 **installmobilefirstadmin** Ant 任务或 {{ site.data.keys.mf_console }} 注册。

#### pushClientSecret
{: #pushclientsecret }
此充当授权服务器的保密客户机的推送服务实例的密钥。 必须为授权服务器注册标识和密钥。 可以通过 **installmobilefirstadmin** Ant 任务或 {{ site.data.keys.mf_console }} 注册。

`<property>` 元素指定了要在应用程序服务器中定义的部署属性。 它具有以下属性：

| 属性  | 描述                | 必需 | 缺省值 |
|------------|----------------------------|----------|---------|
| name       | 属性的名称。  |	是	     | 无    |
| value	     | 属性的值。 |	是	     | 无    |

使用该元素时，可以定义自己的 JNDI 属性，或覆盖推送服务 WAR 文件提供的 JNDI 属性的缺省值。

有关 JNDI 属性的更多信息，请参阅[{{ site.data.keys.mf_server }} 推送服务的 JNDI 属性列表](../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service)。

### 指定应用程序服务器
{: #to-specify-an-application-server-2 }
使用 `<applicationserver>` 元素来定义依赖底层应用程序服务器的参数。 `<applicationserver>` 元素支持以下元素：

| 元素                               | 描述                                      | 计数 |
|---------------------------------------|--------------------------------------------------|-------|
| <websphereapplicationserver> 或 <was>	| WebSphere Application Server 的参数。 | `<websphereapplicationserver>` 元素（或其缩写形式 `<was>`）表示 WebSphere Application Server 实例。 WebSphere Application Server Full Profile（Base 和 Network Deployment）与 WebSphere Application Server Liberty Core 和 WebSphere Application Server Liberty Network Deployment 一样受支持。 | 0..1 |
| `<tomcat>` | Apache Tomcat 的参数。 | 0..1 |

在[用于安装 {{ site.data.keys.product_adj }} 运行时环境的 Ant 任务](#ant-tasks-for-installation-of-mobilefirst-runtime-environments)表中描述了这些元素的属性和内部元素。

但是，有关用于 Liberty 集合体的 `<was>` 元素的内部元素，请参阅下表：

| 元素              | 描述                  | 计数 |
|----------------------|------------------------------|-------|
| `<collectiveMember>` | Liberty 集合体成员。 |	0..1  |

`<collectiveMember>` 元素具有以下属性：

| 属性   | 描述                        | 必需 | 缺省值 |
|-------------|------------------------------------|----------|---------|
| serverName  | 集合体成员的名称。 | 是      | 无    |
| clusterName |	集合体成员所属的集群名称。 | 是 | 无 |

> **注：**如果推送服务和运行时组件安装在同一个集合体成员中，那么它们必须具有相同的集群名称。 如果这些组件安装在同一个集合体的不同成员中，那么集群名称可以不同。

### 指定分析
{: #to-specify-analytics-1 }
`<analytics>` 元素表示您想要将 {{ site.data.keys.product_adj }} 推送服务连接至已安装的 {{ site.data.keys.mf_analytics }} 服务。 它具有以下属性：

| 属性    | 描述                        | 必需 | 缺省值 |
|--------------|------------------------------------|----------|---------|
| install	   | 指示是否将推送服务连接到 {{ site.data.keys.mf_analytics }}。 | 否 | false |
| analyticsURL | {{ site.data.keys.mf_analytics }} 服务的 URL。 | 是 | 无 |
| username	   | 用户名。 | 是 | 无 |
| password	   | 密码。 | 是 | 无 |
| validate	   | 验证 {{ site.data.keys.mf_analytics_console }} 是否可以访问。 | 否 | true |

#### install
{: #install }
使用 **install** 属性来指示必须将该推送服务连接至 {{ site.data.keys.mf_analytics }}，并向其发送事件。 有效值为 true 或 false。

#### analyticsURL
{: #analyticsurl }
使用 **analyticsURL** 属性来指定由收到入局分析数据的 {{ site.data.keys.mf_analytics }} 公开的 URL。  
例如：`http://<hostname>:<port>/analytics-service/rest`

#### username
{: #username }
使用 **username** 属性来指定通过基本认证保护 {{ site.data.keys.mf_analytics }}
的数据入口点时所使用的用户名。

#### password
{: #password }
使用 **password** 属性来指定通过基本认证保护 {{ site.data.keys.mf_analytics }}
的数据入口点时所使用的密码。

#### validate
{: #validate }
使用 **validate** 属性来验证 {{ site.data.keys.mf_analytics_console }} 是否可以访问，并使用密码检查用户名认证。 可能的值为 true 或 false。

### 指定到推送服务数据库的连接
{: #to-specify-a-connection-to-the-push-service-database-1 }
`<database>` 元素收集应用程序服务器中指定数据源声明的参数以访问推送服务数据库。

您必须声明单个数据库：`<database kind="Push">`。 指定 `<database>` 元素类似于 configuredatabase Ant 任务，但是 `<database>` 元素不包含 `<dba>` 和 `<client>` 元素。 它可能具有 `<property>` 元素。

`<database>` 元素具有以下属性：

| 属性    | 描述                  | 必需 | 缺省值 |
|--------------|------------------------------|----------|---------|
| kind         | 数据库类型 (Push)。 | 是      | 无    |
| validate	   | 验证数据库是否可以访问。 | 否 | true |

`<database>` 元素支持以下元素。 有关关系 DBMS 的这些数据库元素配置的更多信息，请参阅 [用于安装 {{ site.data.keys.product_adj }} 运行时环境的 Ant 任务](#ant-tasks-for-installation-of-mobilefirst-runtime-environments)中的表。

| 元素              | 描述                               | 计数 |
|----------------------|-------------------------------------------|-------|
| `<db2>`	           | DB2 数据库的参数。         | 0..1  |
| `<derby>`	           | Apache Derby 数据库的参数。 | 0..1  |
| `<mysql>`	           | MySQL 数据库的参数。        | 0..1  |
| `<oracle>`           | Oracle 数据库的参数。       | 0..1  |
| `<cloudant>`	       | Cloudant 数据库的参数。     | 0..1  |
| `<driverclasspath>`  | JDBC 驱动程序类路径的参数（仅限关系 DBMS）。 | 0..1 |

> **注：**`<cloudant>` 元素的属性与运行时稍有不同。 有关更多信息，请参阅下表：

| 属性    | 描述                            | 必需   | 缺省值 |
|--------------|----------------------------------------|------------|---------|
| url	       | Cloudant 帐户的 URL。       | 否         | https://user.cloudant.com |
| user	       | Cloudant 帐户的用户名。 | 是 | 无 |
| password	   | Cloudant 帐户的密码。	| 否  | 交互式查询 |
| dbName	   | Cloudant 数据库名称。 **要点：**该数据库名称必须以小写字母开头，并且只能包含小写字符 (a-z)、数字 (0-9) 及以下任意字符：_、$ 和 -。 |否	| mfp_push_db |

## 用于安装 {{ site.data.keys.product_adj }} 运行时环境的 Ant 任务
{: #ant-tasks-for-installation-of-mobilefirst-runtime-environments }
**installmobilefirstruntime**、**updatemobilefirstruntime** 和 **uninstallmobilefirstruntime** Ant 任务的参考信息。

### 任务影响
{: #task-effects-2 }

#### installmobilefirstruntime
{: #installmobilefirstruntime }
**installmobilefirstruntime** Ant 任务配置应用程序服务器以将 {{ site.data.keys.product_adj }} 运行时 WAR 文件作为 Web 应用程序运行。 此任务的影响如下。

* 此任务将在指定上下文根（缺省情况下为 /mfp）中声明 {{ site.data.keys.product_adj }} Web 应用程序。
* 此任务将在应用程序服务器上部署运行时 WAR 文件。
* 此任务将为运行时声明数据源以及（在 WebSphere Application Server Full Profile 上）JDBC 提供程序。
* 此任务将在应用程序服务器中部署数据库驱动程序。
* 此任务通过 JNDI 环境条目设置 {{ site.data.keys.product_adj }} 配置属性。
* （可选）此任务设置 {{ site.data.keys.product_adj }} JNDI 环境条目以将应用程序服务器配置为运行时的服务器场成员。

#### updatemobilefirstruntime
{: #updatemobilefirstruntime }
**updatemobilefirstruntime** Ant 任务将更新应用程序服务器上已配置的 {{ site.data.keys.product_adj }} 运行时。 此任务将更新运行时 WAR 文件。 该文件的基本名称与先前部署的运行时 WAR 文件的基本名称必须完全相同。 除此之外，此任务不会更改应用程序服务器配置，即，Web 应用程序配置、数据源和 JNDI 环境条目。

#### uninstallmobilefirstruntime
{: #uninstallmobilefirstruntime }
**uninstallmobilefirstruntime** Ant 任务用于撤销早先运行 **installmobilefirstruntime** 的影响。 此任务的影响如下。

* 此任务将除去具有指定上下文根的 {{ site.data.keys.product_adj }} Web 应用程序配置。 此任务还将除去手动添加到该应用程序的设置。
* 此任务将从应用程序服务器中除去运行时 WAR 文件。
* 此任务将除去运行时的数据源以及（在 WebSphere Application Server Full Profile 上）JDBC 提供程序。
* 此任务将除去关联的 JNDI 环境条目。

### 属性和元素
{: #attributes-and-elements-2 }
**installmobilefirstruntime**、**updatemobilefirstruntime** 和 **uninstallmobilefirstruntime** Ant 任务具有以下属性：

| 属性         | 描述                                                                 | 必需   | 缺省值                   |
|-------------------|-----------------------------------------------------------------------------|------------|---------------------------|
| contextroot       | 应用程序的 URL 中的公共前缀（上下文根）。                | 否 | /mfp  |
| id	            | 区分不同的部署。                                       | 否 | 空 |
| environmentId	    | 区分不同的 {{ site.data.keys.product_adj }} 环境。                          | 否 | 空 |
| warFile	        | {{ site.data.keys.product_adj }} 运行时的 WAR 文件。                                       | 否 | mfp-server.war 文件与 mfp-ant-deployer.jar 文件位于同一目录中。 |
| wasStartingWeight | WebSphere Application Server 的启动顺序。 从较小的值开始启动。 | 否 | 2     |                           |

#### contextroot 和 id
{: #contextroot-and-id-1 }
**contextroot** 和 **id** 属性区分不同的 {{ site.data.keys.product_adj }} 项目。

在 WebSphere Application Server Liberty Profile 和 Tomcat 环境中，contextroot 参数足以实现该目的。 在 WebSphere Application Server Full Profile 环境中，改为使用 id 属性。

#### environmentId
{: #environmentid-1 }
使用 **environmentId** 属性可区分多个环境，包括必须独立运行的每个 {{ site.data.keys.mf_server }} 管理服务和 {{ site.data.keys.product_adj }} 运行时 Web 应用程序。 您必须将运行时应用程序的该属性设置为 <installmobilefirstadmin> 调用中针对管理服务应用程序设置的相同值。

#### warFile
{: #warfile-1 }
使用 **warFile** 属性来指定 {{ site.data.keys.product_adj }} 运行时 WAR 文件的不同目录。 您可以使用绝对路径或相对路径来指定该 WAR 文件的名称。

#### wasStartingWeight
{: #wasstartingweight-1 }
使用 **wasStartingWeight** 属性将 WebSphere Application Server 中使用的值指定为权重，以确保启动顺序的稳定可靠。 根据启动顺序值，在任何其他 {{ site.data.keys.product_adj }} 运行时项目之前部署和启动 {{ site.data.keys.mf_server }} 管理服务 Web 应用程序。 如果 {{ site.data.keys.product_adj }} 项目在 Web 应用程序之前部署或启动，那么不会建立 JMX 通信并且您无法管理 {{ site.data.keys.product_adj }} 项目。

**installmobilefirstruntime**、**updatemobilefirstruntime** 和 **uninstallmobilefirstruntime** 任务支持以下元素：

| 元素               | 描述                                      | 计数 |
|-----------------------|--------------------------------------------------|-------|
| `<property>`          | 属性。	                               | 0..   |
| `<applicationserver>` | 应用程序服务器。                          | 1     |
| `<database>`          | 数据库。                                   | 1     |
| `<analytics>`         | 分析。                                   | 0..1  |

`<property>` 元素指定了要在应用程序服务器中定义的部署属性。 它具有以下属性：

| 属性 | 描述                | 必需 | 缺省值 |
|-----------|----------------------------|----------|---------|
| name      | 属性的名称。	 | 是      | 无    |
| value	    | 属性的值。| 是	    | 无    |  

`<applicationserver>` 元素描述了要将 {{ site.data.keys.product_adj }} 应用程序部署到的应用程序服务器。 它是以下某个元素的容器：

| 元素                                    | 描述                                      | 计数 |
|--------------------------------------------|--------------------------------------------------|-------|
| `<websphereapplicationserver>` 或 `<was>`  | WebSphere Application Server 的参数。	| 0..1  |
| `<tomcat>`                                 | Apache Tomcat 的参数。                | 0..1  |

`<websphereapplicationserver>` 元素（或其缩写形式 `<was>`）表示 WebSphere Application Server 实例。 WebSphere Application Server Full Profile（Base 和 Network Deployment）与 WebSphere Application Server Liberty Core 和 WebSphere Application Server Liberty Network Deployment 一样受支持。 `<websphereapplicationserver>` 元素具有以下属性：

| 属性       | 描述                                            | 必需                 | 缺省值 |
|-----------------|--------------------------------------------------------|--------------------------|---------|
| installdir      |	WebSphere Application Server 安装目录。   | 是                      | 无    |
| profile         |	WebSphere Application Server Profile 或 Liberty。      | 是	                  | 无    |
| user	             WebSphere Application Server 管理员名称。	               | 是，除 Liberty 之外  | 无    |
| password        | WebSphere Application Server 管理员密码。   | 否 交互式查询 |         |
| libertyEncoding |	针对 WebSphere Application Server Liberty 的数据源密码编码的算法。 可能值为 none、xor 和 aes。 不管使用 xor 还是 aes 编码，明文密码作为自变量传递给 securityUtility 程序，该程序通过外部进程调用。 您可以使用 ps 命令或在 UNIX 操作系统上的 /proc 文件系统中查看密码。                                                         | 否                       |	xor     |
| jeeVersion      |	针对 Liberty Profile。 指定是否安装 JEE6 Web 概要文件或 JEE7 Web 概要文件的功能。 可能的值包括：6、7 或 auto。| 否 | auto |
| configureFarm   |	针对 WebSphere Application Server Liberty 和 WebSphere Application Server Full Profile（不针对 WebSphere Application Server Network Deployment 版本 和 Liberty 集合体）。 用于指定服务器是否为服务器场成员。 可能值为 true 或 false。 | 否	      | false   |
| farmServerId    |	在服务器场中唯一标识服务器的字符串。 {{ site.data.keys.mf_server }} 管理服务和与其通信的所有 {{ site.data.keys.product_adj }} 运行时必须共享相同的值。                                                                | 是                      |	无    |

针对单服务器部署支持以下元素：

| 元素     | 描述      | 计数 |
|-------------|------------------|-------|
| `<server>`  | 单台服务器。 | 0..1  |

在此上下文中使用的 <server> 元素具有以下属性：

| 属性 | 描述      | 必需 | 缺省值 |
|-----------|------------------|----------|---------|
| name	    | 服务器名称。 | 是      | 无    |

针对 Liberty 集合体，支持以下元素：

| 元素               | 描述                  | 计数 |
|-----------------------|------------------------------|-------|
| `<collectiveMember>`  | Liberty 集合体成员。 | 0..1  |

`<collectiveMember>` 元素具有以下属性：

| 属性               | 描述      | 必需 | 缺省值 |
|-------------------------|------------------|----------|---------|
| serverName              |	集合体成员的名称。                       | 是 | 无 |
| clusterName             |	集合体成员所属的集群名称。  | 是 | 无 |
| serverId                |	用于唯一标识集合体成员的字符串。 | 是 | 无 |
| controllerHost          |	集合体控制器的名称。                   | 是 | 无 |
| controllerHttpsPort     |	集合体控制器的 HTTPS 端口。             | 是 | 无 |
| controllerAdminName     |	集合体控制器中定义的管理用户名。 此用户还负责将新成员加入到集合体中。 | 是 | 无 |
| controllerAdminPassword |	管理用户密码。	                     | 是 | 无 |
| createControllerAdmin   |	用于指示是否必须在集合体成员的基本注册表中创建管理用户。 可能值为 true 或 false。 | 否 | true |

针对网络部署，支持以下元素：

| 元素     | 描述                                   | 计数 |
|-------------|-----------------------------------------------|-------|
| `<cell>`    |	整个单元。	                          | 0..1  |
| `<cluster>` |	集群的所有服务器。                 |	0..1  |
| `<node>`    |	节点中的所有服务器，不包含集群。 | 0..1  |
| `<server>`  |	单台服务器。	                          | 0..1  |

`<cell>` 元素没有属性。

`<cluster>` 元素具有以下属性：

| 属性 | 描述       | 必需 | 缺省值 |
|-----------|-------------------|----------|---------|
| name      | 集群名称。 | 是	   | 无    |

`<node>` 元素具有以下属性：

| 属性 | 描述    | 必需 | 缺省值 |
|-----------|----------------|----------|---------|
| name      | 节点名。 | 是	    | 无    |

在 Network Deployment 上下文中使用的 `<server>` 元素具有以下属性：

| 属性  | 描述      | 必需 | 缺省值 |
|------------|------------------|----------|---------|
| nodeName   | 节点名。   | 是	   | 无    |
| serverName | 服务器名称。 | 是      | 无    |

`<tomcat>` 元素表示 Apache Tomcat 服务器。 它具有以下属性：

| 属性     | 描述      | 必需 | 缺省值 |
|---------------|------------------|----------|---------|
| installdir    | Apache Tomcat 的安装目录。 对于在 CATALINA_HOME 目录和 CATALINA_BASE 目录之间拆分的 Tomcat 安装，请指定 CATALINA_BASE 环境变量的值。     | 是 | 无    |
| configureFarm | 用于指定服务器是否为服务器场成员。 可能值为 true 或 false。	| 否 | false |
| farmServerId	| 在服务器场中唯一标识服务器的字符串。 {{ site.data.keys.mf_server }} 管理服务和与其通信的所有 {{ site.data.keys.product_adj }} 运行时必须共享相同的值。 | 是 | 无 |

`<database>` 元素指定访问特定数据库所需要的信息。 指定 `<database>` 元素类似于 configuredatabase Ant 任务，但是该元素不包含 `<dba>` 和 `<client>` 元素。 但是，它可能具有 `<property>` 元素。 `<database>` 元素具有以下属性：

| 属性 | 描述                                | 必需 | 缺省值 |
|-----------|--------------------------------------------|----------|---------|
| kind      | 数据库类型（{{ site.data.keys.product_adj }} 运行时）。 | 是 | 无 |
| validate  | 验证数据库是否可以访问。 可能的值为 true 或 false。 | 否 | true |

`<database>` 元素支持以下元素：

| 元素             | 描述	                | 计数 |
|---------------------|-----------------------------|-------|
| `<derby>`           | Derby 的参数。   | 0..1  |
| `<db2>`             |	DB2 的参数。     | 0..1  |
| `<mysql>`           |	MySQL 的参数。   | 0..1  |
| `<oracle>`          |	Oracle 的参数。  | 0..1  |
| `<driverclasspath>` | JDBC 驱动程序类路径。 | 0..1  |

`<analytics>` 元素表示您想要将 {{ site.data.keys.product_adj }} 运行时连接至已安装的 {{ site.data.keys.mf_analytics_console }} 和服务。 它具有以下属性：

| 属性    | 描述                                                                      | 必需 | 缺省值 |
|--------------|----------------------------------------------------------------------------------|----------|---------|
| install      | 指示是否将 {{ site.data.keys.product_adj }} 运行时连接到 {{ site.data.keys.mf_analytics }}。 | 否       | false   |
| analyticsURL | {{ site.data.keys.mf_analytics }} 服务的 URL。	                                      | 是      | 无    |
| consoleURL   | {{ site.data.keys.mf_analytics_console }} 的 URL。	                                      | 是      | 无    |
| username     | 用户名。	                                                                  | 是      | 无    |
| password     | 密码。	                                                                  | 是      | 无    |
| validate     | 验证 {{ site.data.keys.mf_analytics_console }} 是否可以访问。	      | 否	     | true    |
| tenant       | 从 {{ site.data.keys.product_adj }}
运行时收集的索引数据的租户。	      | 否       | 内部标识 |

#### install
{: #install-1 }
使用 **install** 属性来指示必须将该 {{ site.data.keys.product_adj }} 运行时连接至 {{ site.data.keys.mf_analytics }} 并向其发送事件。 有效值为 **true** 或 **false**。

#### analyticsURL
{: #analyticsurl-1 }
使用 **analyticsURL** 属性来指定由收到入局分析数据的 {{ site.data.keys.mf_analytics }} 公开的 URL。  
例如：`http://<hostname>:<port>/analytics-service/rest`

#### consoleURL
{: #consoleurl }
将 **consoleURL** 属性用于由链接到 {{ site.data.keys.mf_analytics }} 的 {{ site.data.keys.mf_analytics_console }} 公开的 URL。  
例如：`http://<hostname>:<port>/analytics/console`

#### username
{: #username-1 }
使用 **username** 属性来指定通过基本认证保护 {{ site.data.keys.mf_analytics }}
的数据入口点时所使用的用户名。

#### password
{: #password-1 }
使用 **password** 属性来指定通过基本认证保护 {{ site.data.keys.mf_analytics }}
的数据入口点时所使用的密码。

#### validate
{: #validate-1 }
使用 **validate** 属性来验证 {{ site.data.keys.mf_analytics_console }} 是否可以访问，并使用密码检查用户名认证。 可能的值为 **true** 或 **false**。

#### tenant
{: #tenant }
有关此属性的更多信息，请参阅[配置属性](../analytics/configuration/#configuration-properties)。

### 指定 Apache Derby 数据库
{: #to-specify-an-apache-derby-database }
`<derby>` 元素具有以下属性：

| 属性  | 描述                                | 必需 | 缺省值 |
|------------|--------------------------------------------|----------|---------|
| database	 | 数据库名称。	                      | 否       |	MFPDATA、MFPADM、MFPCFG、MFPPUSH 或 APPCNTR，取决于类型。 |
| datadir	 | 包含数据库的目录。 |	是	     | 无    |
| schema     |	模式名称。                          |	否	     | MFPDATA、MFPCFG、MFPADMINISTRATOR、MFPPUSH 或 APPCENTER，取决于类型。 |

`<derby>` 元素支持以下元素：

| 元素       | 描述	                | 计数 |
|---------------|-------------------------------|-------|
| `<property>`  | 数据源属性或 JDBC 连接属性。	| 0.. |

有关可用属性的更多信息，请参阅 Class [EmbeddedDataSource40](http://db.apache.org/derby/docs/10.8/publishedapi/jdbc4/org/apache/derby/jdbc/EmbeddedDataSource40.html) 的文档。 另请参阅 [Class EmbeddedConnectionPoolDataSource40](http://db.apache.org/derby/docs/10.8/publishedapi/jdbc4/org/apache/derby/jdbc/EmbeddedConnectionPoolDataSource40.html) 的文档。

有关 Liberty 服务器的可用属性的更多信息，请参阅 [Liberty profile: Configuration elements in the server.xml
file](http://ibm.biz/knowctr#SSAW57_8.5.5/com.ibm.websphere.wlp.nd.doc/autodita/rwlp_metatype_4ic.html) 中 properties.derby.embedded 的文档。

当在 {{ site.data.keys.product }} 的安装目录中使用 **mfp-ant-deployer.jar** 文件时，不需要 `<driverclasspath>` 元素。

### 指定 DB2 数据库
{: #to-specify-a-db2-database }
`<db2>` 元素具有以下属性：

| 属性  | 描述                                | 必需 | 缺省值 |
|------------|--------------------------------------------|----------|---------|
| database   | 数据库名称。 | 否 MFPDATA、MFPADM、MFPCFG、MFPPUSH 或 APPCNTR，取决于类型。 |
| server     | 数据库服务器的主机名。      | 是	     | 无    |
| port       | 数据库服务器上的端口。           | 否	     | 50000   |
| user       | 用于访问数据库的用户名。     | 该用户无需拥有对数据库的扩展特权。 如果您对数据库施加限制，那么可以设置拥有数据库用户和特权中列出的|受限特权的用户。 | 是	无 |
| password   | 用于访问数据库的密码。      | 否       | 交互式查询 |
| schema     | 模式名称。                           | 否       | 取决于用户 |

有关 DB2 用户帐户的更多信息，请参阅 [DB2 安全模型概述](http://ibm.biz/knowctr#SSEPGG_10.1.0/com.ibm.db2.luw.admin.sec.doc/doc/c0021804.html)。  
`<db2>` 元素支持以下元素：

| 元素       | 描述	                | 计数 |
|---------------|-------------------------------|-------|
| `<property>`  | 数据源属性或 JDBC 连接属性。	| 0.. |

有关可用属性的更多信息，请参阅 [IBM  Data Server Driver for JDBC and SQLJ 的属性](http://ibm.biz/knowctr#SSEPGG_9.7.0/com.ibm.db2.luw.apdv.java.doc/src/tpc/imjcc_rjvdsprp.html)。

有关 Liberty 服务器的可用属性的更多信息，请参阅 [Liberty profile: Configuration elements in the server.xml
file](http://ibm.biz/knowctr#SSAW57_8.5.5/com.ibm.websphere.wlp.nd.doc/autodita/rwlp_metatype_4ic.html) 中的 properties.db2.jcc 部分。

`<driverclasspath>` 元素必须包含 DB2 JDBC 驱动程序和关联许可证的 JAR 文件。 您可以从 [DB2 JDBC 驱动程序版本](http://www.ibm.com/support/docview.wss?uid=swg21363866)下载 DB2 JDBC 驱动程序。

### 指定 MySQL 数据库
{: #to-specify-a-mysql-database }
`<mysql>` 元素具有以下属性：

| 属性  | 描述                                | 必需 | 缺省值 |
|------------|--------------------------------------------|----------|---------|
| database	 | 数据库名称。	                      | 否       | MFPDATA、MFPADM、MFPCFG、MFPPUSH 或 APPCNTR，取决于类型。 |
| server	 | 数据库服务器的主机名。	  | 是      | 无    |
| port	     | 数据库服务器上的端口。           | 否	     | 3306    |
| user	     | 用于访问数据库的用户名。 该用户无需拥有对数据库的扩展特权。 如果您对数据库施加限制，那么可以设置拥有数据库用户和特权中列出的|受限特权的用户。 | 是 | 无 |
| password	 | 用于访问数据库的密码。	  | 否	     | 交互式查询 |

还可以指定 URL 来替代 **database**、**server** 和 **port**。 在此情况下，使用以下属性：

| 属性  | 描述                                | 必需 | 缺省值 |
|------------|--------------------------------------------|----------|---------|
| url	     | 用于连接到数据库的 URL。	  | 是	     | 无    |
| user	     | 用于访问数据库的用户名。 该用户无需拥有对数据库的扩展特权。 如果您对数据库施加限制，那么可以设置拥有数据库用户和特权中列出的受限特权的用户。 | 是  | 无 |
| password	 | 用于访问数据库的密码。	  | 否       | 交互式查询 |

有关 MySQL 用户帐户的更多信息，请参阅 [MySQL 用户帐户管理](http://dev.mysql.com/doc/refman/5.5/en/user-account-management.html)。

`<mysql>` 元素支持以下元素：

| 元素       | 描述	                | 计数 |
|---------------|-------------------------------|-------|
| `<property>`  | 数据源属性或 JDBC 连接属性。	| 0.. |

有关可用属性的更多信息，请参阅 [Driver/Datasource Class Names, URL Syntax and Configuration
Properties for Connector/J](http://dev.mysql.com/doc/connector-j/en/connector-j-reference-configuration-properties.html) 中的文档。

有关 Liberty 服务器的可用属性的更多信息，请参阅 [Liberty profile: Configuration elements in the server.xml
file](http://ibm.biz/knowctr#SSAW57_8.5.5/com.ibm.websphere.wlp.nd.doc/autodita/rwlp_metatype_4ic.html) 中的 properties 部分。

`<driverclasspath>` 元素必须包含一个 MySQL Connector/J JAR 文件。 可以从 [Download Connector/J](http://www.mysql.com/downloads/connector/j/) 下载该文件。

### 指定 Oracle 数据库
{: #to-specify-an-oracle-database }
`<oracle>` 元素具有以下属性：

| 属性  | 描述                                | 必需 | 缺省值 |
|------------|--------------------------------------------|----------|---------|
| database   | 数据库名称或 Oracle 服务名称。 注：必须始终使用服务名称来连接到 PDB 数据库。 | 否 | ORCL |
| server	 | 数据库服务器的主机名。	是	无
| port	     | 数据库服务器上的端口。	否	1521
| user	     | 用于访问数据库的用户名。 该用户无需拥有对数据库的扩展特权。 如果您对数据库施加限制，那么可以设置拥有数据库用户和特权中列出的受限特权的用户。 请参阅此表下方的注释。 | 是 | 无 |
| password	 | 用于访问数据库的密码。	  | 否       | 交互式查询 |

> **注：**对于 **user** 属性，最好使用大写字母的用户名。 Oracle 用户名通常为大写字母。 不像其他数据库工具，**installmobilefirstruntime** Ant 任务不会将用户名中的小写字母转换为大写字母。 如果 **installmobilefirstruntime** Ant 任务无法连接到您的数据库，请尝试用大写字母为 **user** 属性输入值。

还可以指定 URL 来替代 **database**、**server** 和 **port**。 在此情况下，使用以下属性：

| 属性  | 描述                                | 必需 | 缺省值 |
|------------|--------------------------------------------|----------|---------|
| url	     | 用于连接到数据库的 URL。	  | 是      | 无    |
| user	     | 用于访问数据库的用户名。 该用户无需拥有对数据库的扩展特权。 如果您对数据库施加限制，那么可以设置拥有数据库用户和特权中列出的受限特权的用户。 请参阅此表下方的注释。 | 是 | 无 |
| password	 | 用于访问数据库的密码。	  | 否	     | 交互式查询 |

> **注：**对于 **user** 属性，最好使用大写字母的用户名。 Oracle 用户名通常为大写字母。 不像其他数据库工具，**installmobilefirstruntime** Ant 任务不会将用户名中的小写字母转换为大写字母。 如果 **installmobilefirstruntime** Ant 任务无法连接到您的数据库，请尝试用大写字母为 **user** 属性输入值。

有关 Oracle 用户帐户的更多信息，请参阅[认证方法概述](http://docs.oracle.com/cd/B28359_01/server.111/b28318/security.htm#i12374)。

有关 Oracle 数据库连接 URL 的更多信息，请参阅 [Data Sources and URLs](http://docs.oracle.com/cd/B28359_01/java.111/b31224/urls.htm) 中的 **Database
URLs and Database Specifiers** 部分。

它支持以下元素：

| 元素       | 描述	                | 计数 |
|---------------|-------------------------------|-------|
| `<property>`  | 数据源属性或 JDBC 连接属性。	| 0.. |

有关可用属性的更多信息，请参阅 [Data Sources and URLs](http://docs.oracle.com/cd/B28359_01/java.111/b31224/urls.htm) 中的 **Data Sources and URLs** 部分。

有关 Liberty 服务器可用属性的更多信息，请参阅 [Liberty profile: Configuration elements in the server.xml file](http://ibm.biz/knowctr#SSAW57_8.5.5/com.ibm.websphere.wlp.nd.doc/autodita/rwlp_metatype_4ic.html) 中的 **properties.oracle** 部分。

`<driverclasspath>` 元素必须包含一个 Oracle JDBC 驱动程序 JAR 文件。 可以从 [JDBC, SQLJ, Oracle JPublisher and Universal Connection
Pool (UCP)](http://www.oracle.com/technetwork/database/features/jdbc/index-091264.html) 下载 Oracle JDBC 驱动程序。

元素 `<property>`（可用于 `<derby>`、`<db2>`、` <mysql>` 或 `<oracle>` 元素内部）具有以下属性：

| 属性  | 描述                                | 必需 | 缺省值 |
|------------|--------------------------------------------|----------|---------|
| name       | 属性的名称。	              | 是      | 无    |
| type	     | 属性值的 Java 类型（通常为 java.lang.String/Integer/Boolean）。 | 否 | java.lang.String |
| value	     | 属性的值。	              | 是      |  无   |

## 用于安装 Application Center 的 Ant 任务
{: #ant-tasks-for-installation-of-application-center }
`<installApplicationCenter>`、`<updateApplicationCenter>` 和 `<uninstallApplicationCenter>` Ant 任务是为安装 Application Center Console 和 Services 而提供。

### 任务影响
{: #task-effects-3 }
### installApplicationCenter
{: #installapplicationcenter }
`<installApplicationCenter>` 任务配置应用程序服务器以将 Application Center Services WAR 文件作为 Web 应用程序运行，并安装 Application Center Console。 该任务具有以下影响：

* 该任务声明了 /applicationcenter 上下文根中的
Application Center Services Web 应用程序。
* 该任务声明数据源，并且在 WebSphere Application Server Full Profile 上还声明了 Application Center Services 的 JDBC 提供程序。
* 该任务在应用程序服务器上部署
Application Center Services Web 应用程序。
* 该任务在 /appcenterconsole 上下文根中将
Application Center Console 声明为一个 Web 应用程序。
* 该任务在应用程序服务器上部署 Application Center Console WAR 文件。
* 该任务使用 JNDI 环境条目配置
Application Center Services 的配置属性。 已注释与端点和代理相关的 JNDI 环境条目。 在某些情况下，您必须对它们取消注释。
* 此任务对用户进行配置，将其映射到
Application Center Console 和 Services Web 应用程序使用的角色。
* 此任务在 WebSphere Application Server 上，配置 Web 容器所需的定制属性。

#### updateApplicationCenter
{: #updateApplicationCenter }
`<updateApplicationCenter>` 任务对已在应用程序服务器上配置的 Application Center 应用程序进行更新。 该任务具有以下影响：

* 该任务更新 Application Center Services WAR 文件。 该文件的基本名称与先前部署的对应 WAR 文件的基本名称必须完全相同。
* 该任务更新 Application Center Console WAR 文件。 该文件的基本名称与先前部署的对应 WAR 文件的基本名称必须完全相同。

该任务不会更改应用程序服务器配置，即 Web 应用程序配置、数据源、JNDI 环境条目以及用户到角色的映射。 该任务仅适用于使用此主题中描述的 <installApplicationCenter> 任务所执行的安装。

> **注：**在 WebSphere Application Server Liberty Profile 上，该任务不会更改功能，这将在已安装应用程序的 server.xml 文件中遗留下潜在的非最小功能列表。

#### uninstallApplicationCenter
{: #uninstallApplicationCenter }
`<uninstallApplicationCenter>` Ant 任务撤销早期运行 `<installApplicationCenter>` 的影响。 该任务具有以下影响：

* 此任务将除去具有 **/applicationcenter** 上下文根的
Application Center Services Web 应用程序配置。 因此，此任务还将除去手动添加到该应用程序的设置。
* 此任务从应用程序服务器除去
Application Center Services and Console WAR 文件。
* 此任务将除去数据源，并且在 WebSphere Application Server Full Profile 上还除去
Application Center Services 的 JDBC 提供程序。
* 此任务从应用程序服务器除去已由
Application Center Services 使用的数据库驱动程序。
* 此任务将除去关联的 JNDI 环境条目。
* 此任务除去由 `<installApplicationCenter>` 调用配置的用户。

### 属性和元素
{: #attributes-and-elements-3 }
`<installApplicationCenter>`、`<updateApplicationCenter>` 和 `<uninstallApplicationCenter>` 任务具有以下属性：

| 属性    | 描述                                | 必需 | 缺省值 |
|--------------|--------------------------------------------|----------|---------|
| id	       | 用于区分 WebSphere Application Server Full Profile 中的不同部署。	| 否 | 空 |
| servicewar   | Application Center Services 的 WAR 文件。 | 否 | applicationcenter.war 文件位于 Application Center Console 目录中：**product_install_dir/ApplicationCenter/console。** |
| shortcutsDir | 放置快捷方式的目录。 | 否 | 无 |
| aaptDir | 包含来自 Android SDK platform-tools 软件包的 aapt 程序的目录。 | 否 | 无 |

#### id
{: #id-1 }
在 WebSphere Application Server Full Profile 环境中，**id** 属性用于区分不同的 Application Center Console 和 Services 部署。 没有该 **id** 属性时，使用同一上下文根的两个 WAR 文件可能会冲突，并无法部署这些文件。

#### servicewar
{: #servicewar-1 }
使用 **servicewar** 属性来指定
Application Center Services WAR 文件的不同目录。 您可以使用绝对路径或相对路径来指定该 WAR 文件的名称。

#### shortcutsDir
{: #shortcutsdir-1 }
**shortcutsDir** 属性指定将 Application Center Console 的快捷方式放置在何处。 如果设置了该属性，会将以下文件添加到该目录：

* **appcenter-console.url**：该文件是 Windows 快捷方式。 该文件会在浏览器中打开
Application Center Console。
* **appcenter-console.sh**：该文件是 UNIX Shell 脚本。 该文件会在浏览器中打开
Application Center Console。

#### aaptDir
{: #aaptdir }
**aapt** 程序是 {{ site.data.keys.product }} 分发版的一部分：**product_install_dir/ApplicationCenter/tools/android-sdk**。  
如果未设置该属性，那么在 apk 应用程序上载期间，Application Center 使用其自身代码对其进行解析时，可能会有限制。

`<installApplicationCenter>`、`<updateApplicationCenter>` 和 `<uninstallApplicationCenter>` 任务支持以下元素：

| 元素           | 描述	                            | 计数 |
|-------------------|-------------------------------------------|-------|
| applicationserver	| 应用程序服务器。                   | 1     |
| console           | Application Center Console。	        | 1     |
| database          | 数据库。	                        | 1     |
| user	            | 要映射到安全角色的用户。 | 0..∞  |

### 指定 Application Center Console
{: #to-specify-an-application-center-console }
`<console>` 元素收集信息以定制 Application Center Console 的安装。 此元素具有以下属性：

| 属性    | 描述                                      | 必需 | 缺省值 |
|--------------|--------------------------------------------------|----------|---------|
| warfile      | Application Center Console 的 WAR 文件。 |	否       | appcenterconsole.war 文件位于 Application Center Console 目录：**product_install_dir/ApplicationCenter/console**。 |

### 指定应用程序服务器
{: #to-specify-an-application-server-3 }
使用 `<applicationserver>` 元素来定义依赖底层应用程序服务器的参数。 `<applicationserver>` 元素支持以下元素。

| 元素           | 描述	                            | 计数 |
|-------------------|-------------------------------------------|-------|
| **websphereapplicationserver** 或 **was**	| WebSphere Application Server 的参数。 `<websphereapplicationserver>` 元素（或其缩写形式 `<was>`）表示 WebSphere Application Server 实例。 WebSphere Application Server Full Profile（Base 和 Network DeploymentI）与 WebSphere Application Server Liberty Core 一样受支持。 Application Center 不支持 Liberty 集合体。 | 0..1 |
| tomcat            | Apache Tomcat 的参数。 | 0..1 |

在[用于安装 {{ site.data.keys.product_adj }} 运行时环境的 Ant 任务](#ant-tasks-for-installation-of-mobilefirst-runtime-environments)页面的表中描述了这些元素的属性和内部元素。

### 指定到服务数据库的连接
{: #to-specify-a-connection-to-the-services-database }
`<database>` 元素收集应用程序服务器中指定数据源声明的参数以访问服务数据库。

您必须声明单个数据库：`<database kind="ApplicationCenter">`。 指定 `<database>` 元素类似于 `<configuredatabase>` Ant 任务，但是 `<database>` 元素不包含 `<dba>` 和 `<client>` 元素。 它可能具有 `<property>` 元素。

`<database>` 元素具有以下属性：

| 属性    | 描述                                            | 必需 | 缺省值 |
|--------------|--------------------------------------------------------|----------|---------|
| kind         | 数据库类型 (ApplicationCenter)。              | 是      | 无    |
| validate	   | 验证数据库是否可以访问。 | 否       | True    |

`<database>` 元素支持以下元素。 有关这些数据库元素配置的更多信息，请参阅[用于安装 {{ site.data.keys.product_adj }} 运行时环境的 Ant 任务](#ant-tasks-for-installation-of-mobilefirst-runtime-environments)中的表。

| 元素           | 描述	                            | 计数 |
|-------------------|-------------------------------------------|-------|
| db2	            | DB2 数据库的参数。	        | 0..1  |
| derby             | Apache Derby 数据库的参数。	| 0..1  |
| mysql             | MySQL 数据库的参数。	    | 0..1  |
| oracle	        | Oracle 数据库的参数。	    | 0..1  |
| driverclasspath   | 表示 JDBC 驱动程序类路径的参数。	| 0..1  |

### 用于指定用户和安全角色
{: #to-specify-a-user-and-a-security-role }
`<user>` 元素收集关于用户的参数以包含在应用程序的某些安全角色中。

| 属性    | 描述                                            | 必需 | 缺省值 |
|--------------|--------------------------------------------------------|----------|---------|
| role         | 用户角色 appcenteradmin。 | 是 | 无 |
| name	       | 用户名。 | 是 | 无 |
| password	   | 必须创建用户时的密码。	| 否 | 无 |

## 用于安装 {{ site.data.keys.mf_analytics }} 的 Ant 任务
{: #ant-tasks-for-installation-of-mobilefirst-analytics }
**installanalytics**、**updateanalytics** 和 **uninstallanalytics** Ant 任务是为了 {{ site.data.keys.mf_analytics }} 的安装而提供的。

这些 Ant 任务的目的是使用应用程序服务器上数据的相应存储器来配置 {{ site.data.keys.mf_analytics_console }} 和 {{ site.data.keys.mf_analytics }}
Service。
该任务将安装作为主节点的 {{ site.data.keys.mf_analytics }}
节点和数据。 有关更多信息，请参阅[集群管理和 Elasticsearch](../analytics/configuration/#cluster-management-and-elasticsearch)。

### 任务影响
{: #task-effects-4 }
#### installanalytics
{: #installanalytics }
**installanalytics** Ant 任务配置应用程序服务器以运行 {{ site.data.keys.mf_analytics }}。 该任务具有以下影响：

* 该任务在应用程序服务器上部署 {{ site.data.keys.mf_analytics }}
Service 和 {{ site.data.keys.mf_analytics_console }} WAR 文件。
* 该任务在指定的上下文根 (/analytics-service) 中声明 {{ site.data.keys.mf_analytics }} Service Web 应用程序。
* 该任务在指定的上下文根 (/analytics) 中声明 {{ site.data.keys.mf_analytics_console }} Web 应用程序。
* 该任务通过 JNDI 环境条目设置 {{ site.data.keys.mf_analytics_console }} 和 {{ site.data.keys.mf_analytics }}
Services 配置属性。
* 在 WebSphere Application Server Liberty Profile 上，该任务配置 Web 容器。
* （可选）该任务创建使用 {{ site.data.keys.mf_analytics_console }} 的用户。

#### updateanalytics
{: #updateanalytics }
**updateanalytics** Ant 任务在应用程序服务器上更新已配置的 {{ site.data.keys.mf_analytics }}
Service 和 {{ site.data.keys.mf_analytics_console }} Web 应用程序 WAR 文件。 这些文件必须具有与先前部署的项目 WAR 文件相同的基本名称。

该任务不会更改应用程序服务器配置，即 Web 应用程序配置和 JNDI 环境条目。

#### uninstallanalytics
{: #uninstallanalytics }
**uninstallanalytics** Ant 任务用于撤销早先运行 **installanalytics** 的影响。 该任务具有以下影响：

* 该任务使用 {{ site.data.keys.mf_analytics }}
Service 和 {{ site.data.keys.mf_analytics_console }} Web 应用程序各自的上下文根除去其配置。
* 该任务从应用程序服务器除去 {{ site.data.keys.mf_analytics }}
Service 和 {{ site.data.keys.mf_analytics_console }} WAR 文件。
* 此任务将除去关联的 JNDI 环境条目。

### 属性和元素
{: #attributes-and-elements-4 }
**installanalytics**、**updateanalytics** 和 **uninstallanalytics** 任务具有以下属性：

| 属性    | 描述                                            | 必需 | 缺省值 |
|--------------|--------------------------------------------------------|----------|---------|
| serviceWar   | 用于 {{ site.data.keys.mf_analytics }}
Service 的 WAR 文件     | 否       | analytics-service.war 文件位于 Analytics 目录中。 |

#### serviceWar
{: #servicewar-2 }
使用 **serviceWar** 属性来指定 {{ site.data.keys.mf_analytics }}
Services WAR 文件的不同目录。 您可以使用绝对路径或相对路径来指定该 WAR 文件的名称。

`<installanalytics>`、`<updateanalytics>` 和 `<uninstallanalytics>` 任务支持以下元素：

| 属性         | 描述                               | 必需 | 缺省值 |
|-------------------|-------------------------------------------|----------|---------|
| console	        | {{ site.data.keys.mf_analytics }}   	                | 是	   | 1       |
| user	            | 要映射到安全角色的用户。	| 否	   | 0..     |
| storage	        | 存储器的类型。	                    | 是 	   | 1       |
| applicationserver	| 应用程序服务器。	                | 是	   | 1       |
| property          | 属性。	                            | 否 	   | 0..     |

### 指定 {{ site.data.keys.mf_analytics_console }}
{: #to-specify-a-mobilefirst-analytics-console }
`<console>` 元素收集信息以定制 {{ site.data.keys.mf_analytics_console }}的安装。 此元素具有以下属性：

| 属性    | 描述                                  | 必需 | 缺省值 |
|--------------|----------------------------------------------|----------|---------|
| warfile	   | 控制台 WAR 文件	                      | 否	     | analytics-ui.war 文件位于 Analytics 目录中。 |
| shortcutsdir | 放置快捷方式的目录。 | 否	     | 无    |

#### warFile
{: #warfile-2 }
使用 **warFile** 属性来指定 {{ site.data.keys.mf_analytics_console }} WAR 文件的不同目录。 您可以使用绝对路径或相对路径来指定该 WAR 文件的名称。

#### shortcutsDir
{: #shortcutsdir-2 }
**shortcutsDir** 属性指定将快捷方式放置在 {{ site.data.keys.mf_analytics_console }}的何处。 如果设置该属性，可以将以下文件添加到该目录：

* **analytics-console.url**：该文件是 Windows 快捷方式。 该文件会在浏览器中打开 {{ site.data.keys.mf_analytics_console }}。
* **analytics-console.sh**：该文件是 UNIX Shell 脚本。 该文件会在浏览器中打开 {{ site.data.keys.mf_analytics_console }}。

> 注：这些快捷方式不包含 ElasticSearch 租户参数。

`<console>` 元素支持以下嵌套元素：

| 元素  | 描述	| 计数 |
|----------|----------------|-------|
| property | 属性。	    | 0..   |

使用该元素，您可以定义自己的 JNDI 属性。

`<property>` 元素具有以下属性：

| 属性  | 描述                | 必需 | 缺省值 |
|------------|----------------------------|----------|---------|
| name       | 属性的名称。  | 是      | 无    |
| value	     | 属性的值。 |	是      | 无    |

### 用于指定用户和安全角色
{: #to-specify-a-user-and-a-security-role-1 }
`<user>` 元素收集关于用户的参数以包含在应用程序的某些安全角色中。

| 属性   | 描述                                   | 必需 | 缺省值 |
|-------------|-----------------------------------------------|----------|---------|
| role	      | 应用程序的有效安全角色。    | 是      | 无    |
| name	      | 用户名。	                              | 是      | 无    |
| password	  | 需要创建用户时的密码。 | 否       | 无    |

使用 ` <user>` 元素定义用户之后，可以将其映射到以下任一角色以供在 {{ site.data.keys.mf_console }} 中进行认证：

* **mfpmonitor**
* **mfpoperator**
* **mfpdeployer**
* **mfpadmin**

### 指定 {{ site.data.keys.mf_analytics }} 的存储器类型
{: #to-specify-a-type-of-storage-for-mobilefirst-analytics }
`<storage>` 元素表示 {{ site.data.keys.mf_analytics }}
用于存储其收集的信息和数据的存储器的底层类型。

它支持以下元素：

| 元素       | 描述	| 计数   |
|---------------|---------------|---------|
| elasticsearch	| ElasticSearch | 集群 |

`<elasticsearch>` 参数收集有关 ElasticSearch 集群的参数。

| 属性        | 描述                                   | 必需 | 缺省值   |
|------------------|-----------------------------------------------|----------|-----------|
| clusterName	   | ElasticSearch 集群名称。	           | 否       | worklight |
| nodeName	       | ElasticSearch 节点名。 在 ElasticSearch 集群中该名称必须唯一。	| 否 | `worklightNode_<random number>` |
| mastersList	   | 逗号分隔的字符串，其中包含 ElasticSearch 集群中的 ElasticSearch 主节点的主机名和端口（例如： hostname1:transport-port1,hostname2:transport-port2）	           | 否       |	取决于拓扑 |
| dataPath	       | ElasticSearch 集群位置。	       | 否	      | 取决于应用程序服务器 |
| shards	       | ElasticSearch 集群创建的分片数量。 该值只能通过在 ElasticSearch 集群中创建的主节点进行设置。	| 否 | 5 |
| replicasPerShard | ElasticSearch 集群中每个分片的副本数量。 该值只能通过在 ElasticSearch 集群中创建的主节点进行设置。 | 否 | 1 |
| transportPort	   | 在 ElasticSearch 集群中用于节点到节点通信的端口。	| 否 | 9600 |

#### clusterName
{: #clustername }
使用 **clusterName** 属性来指定 ElasticSearch 集群的名称。

由于一个 ElasticSearch 集群由共享相同集群名称的一个或多个节点组成，因此如果您配置多个节点，则可能会为 **clusterName** 属性指定相同的值。

#### nodeName
{: #nodename }
使用 **nodeName** 属性来指定 ElasticSearch 集群中要配置的节点的名称。 在 ElasticSearch 集群中，每个节点名都必须是唯一的（即使节点跨多台机器）。

#### mastersList
{: #masterslist }
使用 **mastersList** 属性提供 ElasticSearch 集群中主节点的逗号分隔列表。 该列表中的每个主节点必须由其主机名和 ElasticSearch 节点到节点通信端口来标识。 缺省情况下，该端口为 9600 或是您在配置主节点时使用 **transportPort** 属性指定的端口号。

例如：`hostname1:transport-port1, hostname2:transport-port2`。

**注：**

* 如果您指定的 **transportPort** 与缺省值 9600 不同，那么还必须使用 **transportPort** 属性设置该值。 缺省情况下，省略 **mastersList** 属性时，将尝试检测所有受支持应用程序服务器上的主机名和 ElasticSearch 传输端口。
* 如果目标应用程序服务器为 WebSphere Application Server Network Deployment 集群，并且您在稍晚时间点对该集群添加或除去了服务器，那么您必须手动编辑该列表以与 ElasticSearch 集群保持同步。

#### dataPath
{: #datapath }
使用 **dataPath** 属性来指定存储 ElasticSearch 数据的不同目录。 您可以指定绝对路径或相对路径。

如果未指定 **dataPath** 属性，那么将 ElasticSearch 集群数据存储于缺省目录（名为**analyticsData**），该目录位置取决于应用程序服务器：

* 对于 WebSphere Application Server Liberty Profile，位置为 `${wlp.user.dir}/servers/serverName/analyticsData`。
* 对于 Apache Tomcat，位置为：`${CATALINA_HOME}/bin/analyticsData`。
* 对于 WebSphere Application Server 和 WebSphere Application Server Network Deployment，位置为 `${was.install.root}/profiles/<profileName>/analyticsData`。

在 {{ site.data.keys.mf_analytics }}
Service 组件接收事件时，在运行时将自动创建 **analyticsData** 目录及其包含的子目录和文件的层次结构（如果这些对象先前不存在）。

#### shards
{: #shards }
使用 **shards** 属性来指定要在 ElasticSearch 集群中创建的分片数量。

#### replicasPerShard
{: #replicaspershard }
使用 **replicasPerShard** 属性来指定要在 ElasticSearch 集群中为每个分片创建的副本数量。

每个分片可以没有副本，或者具有一个或多个副本。 缺省情况下，每个分片具有一个副本，但可以在 {{ site.data.keys.mf_analytics }} 中的现有索引上动态更改副本数量。 副本分片决不能在其分片所在的节点上启动。

#### transportPort
{: #transportport }
使用 **transportPort** 属性指定与该节点进行通信时，ElasticSearch 集群中的其他节点必须使用的端口。 您必须确保该端口可用，并且当该节点位于代理或防火墙后时该端口可访问。

### 指定应用程序服务器
{: #to-specify-an-application-server-4 }
使用 `<applicationserver>` 元素来定义依赖底层应用程序服务器的参数。 `<applicationserver>` 元素支持以下元素。

**注：**在[用于安装 {{ site.data.keys.product_adj }} 运行时环境的 Ant 任务](#ant-tasks-for-installation-of-mobilefirst-runtime-environments)表中描述了此元素的属性和内部元素。

| 元素                                   | 描述	| 计数   |
|-------------------------------------------|---------------|---------|
| **websphereapplicationserver** 或 **was** | WebSphere Application Server 的参数。	| 0..1 |
| tomcat	                                | Apache Tomcat 的参数。	| 0..1 |

### 指定定制 JNDI 属性
{: #to-specify-custom-jndi-properties }
`<installanalytics>`、`<updateanalytics>` 和 `<uninstallanalytics>` 元素支持以下元素：

| 元素  | 描述 | 计数 |
|----------|-------------|-------|
| property | 属性。	 | 0..   |

使用该元素，您可以定义自己的 JNDI 属性。

此元素具有以下属性：

| 属性  | 描述                | 必需 | 缺省值 |
|------------|----------------------------|----------|---------|
| name       | 属性的名称。  | 是      | 无    |
| value	     | 属性的值。 |	是      | 无    |

## 内部运行时数据库
{: #internal-runtime-databases }
了解运行时数据库表、其目的以及每个表中存储的数据的数量级顺序。 在关系数据库中，实体都组织在数据库表中。

### {{ site.data.keys.mf_server }} 运行时使用的数据库
{: #database-used-by-mobilefirst-server-runtime }
下表提供运行时数据库表、其描述及其在关系数据库中的使用方式的列表。

| 关系数据库表名称 | 描述 | 数量级 |
|--------------------------------|-------------|--------------------|
| LICENSE_TERMS	                 | 存储每次运行设备停用任务时捕获的各种许可证度量值。 | 数十行。 该值不超过 JNDI 属性 mfp.device.decommission.when 设置的值。 有关 JNDI 属性的更多信息，请参阅 [{{ site.data.keys.product_adj }} 运行时的 JNDI 属性列表](../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime) |
| ADDRESSABLE_DEVICE	         | 每日存储可寻址设备度量。 每次启动集群时，还会添加 1 个条目。	| 400 行左右。 每天删除久于 13 个月的条目。 |
| MFP_PERSISTENT_DATA	         | 存储已向 OAuth 服务器注册的客户机应用程序的实例，包括有关设备、应用程序、与客户机关联的用户以及设备状态的信息。 | 每个设备和应用程序对 1 行。 |
| MFP_PERSISTENT_CUSTOM_ATTR	 | 与客户机应用程序实例关联的定制属性。 定制属性是根据每个客户机实例通过应用程序注册的特定于应用程序的属性。 | 每个设备和应用程序对 0 行或更多行 |
| MFP_TRANSIENT_DATA	         | 客户机和设备的认证上下文 | 每个设备和应用程序对 2 行；如果使用设备单点登录，那么每个设备另外增加 2 行。 有关 SSO 的更多信息，请参阅[配置设备单点登录 (SSO)](../../../authentication-and-security/device-sso)。 |
| SERVER_VERSION	             | 产品版本。	| 一行 |

### {{ site.data.keys.mf_server }} 管理服务使用的数据库
{: #database-used-by-mobilefirst-server-administration-service }
下表提供管理数据库表、其描述及其在关系数据库中的使用方式的列表。

| 关系数据库表名称 | 描述 | 数量级 |
|--------------------------------|-------------|--------------------|
| ADMIN_NODE	                 | 存储有关运行管理服务的服务器的信息。 在仅使用 1 台服务器的独立拓扑中，不使用该实体。 | 每个服务器 1 行；使用独立服务器时为空。 |
| AUDIT_TRAIL	                 | 存储在使用管理服务器执行的所有管理操作的审计跟踪。 | 数千行。 |
| CONFIG_LINKS	                 | 存储指向实时更新服务的链接。 适配器和应用程序可能具有存储在实时更新服务中的配置，链接用于查找这些配置。	| 数百行。 每个适配器将使用 2 到 3 行。 每个应用程序将使用 4 到 6 行。 |
| FARM_CONFIG	                 | 存储使用服务器场时场节点的配置。 | 数十行；如果未使用服务器场，那么为空。 |
| GLOBAL_CONFIG	                 | 存储一些全局配置数据。 | 1 行。 |
| PROJECT	                     | 存储已部署项目的名称。 | 数十行。 |
| PROJECT_LOCK	                 | 内部集群同步任务。 | 数十行。 |
| TRANSACTIONS	                 | 内部集群同步表；存储所有当前管理操作的状态。 | 数十行。 |
| MFPADMIN_VERSION	             | 产品版本。	| 1 行。 |

### {{ site.data.keys.mf_server }} 实时更新服务使用的数据库
{: #database-used-by-mobilefirst-server-live-update-service }
下表提供实时更新服务数据库表、其描述及其在关系数据库中的使用方式的列表。

| 关系数据库表名称 | 描述 | 数量级 |
|--------------------------------|-------------|--------------------|
| CS_SCHEMAS	                 | 存储存在于平台中的版本化模式。	| 每个模式 1 行。 |
| CS_CONFIGURATIONS	             | 存储每个版本化模式的配置的实例。 | 每个配置 1 行。 |
| CS_TAGS	                     | 存储每个配置实例的可搜索字段和值。	| 对配置中每个字段名称使用行，每个可搜索字段使用值。 |
| CS_ATTACHMENTS	             | 存储每个配置实例的附件。 | 每个附件 1 行。 |
| CS_VERSION	                 | 存储已创建表或实例的 MFP 的版本。 | 具有 MFP 版本的表中的一行。 |

### {{ site.data.keys.mf_server }} 推送服务使用的数据库
{: #database-used-by-mobilefirst-server-push-service }
下表提供推送服务数据库表、其描述及其在关系数据库中的使用方式的列表。

| 关系数据库表名称 | 描述 | 数量级 |
|--------------------------------|-------------|--------------------|
| PUSH_APPS	                     | 推送通知表；存储推送应用程序的详细信息。 | 每个应用程序 1 行。 |
| PUSH_ENV	                     | 推送通知表；存储推送环境的详细信息。 | 数十行。 |
| PUSH_TAGS	                     | 推送通知表；存储已定义标记的详细信息。	     | 数十行。 |
| PUSH_DEVICES	                 | 推送通知表。 为每个设备存储一条记录。	         | 每个设备 1 行。 |
| PUSH_SUBSCRIPTIONS	         | 推送通知表。 为每个标记预订存储一条记录。 | 每个设备预订 1 行。 |
| PUSH_MESSAGES	                 | 推送通知表；存储推送消息的详细信息。	 | 数十行。 |
| PUSH_MESSAGE_SEQUENCE_TABLE	 | 推送通知表；存储生成的序列标识。	 | 1 行。 |
| PUSH_VERSION	                 | 产品版本。	                                         | 1 行。 |

有关设置数据库的更多信息，请参阅[设置数据库](../databases)。

## 样本配置文件
{{ site.data.keys.product }} 包含许多样本配置文件，可帮助您启动 Ant 任务来安装 {{ site.data.keys.mf_server }}。

启动这些 Ant 任务的最容易方式是使用 {{ site.data.keys.mf_server }} 分发版的 **MobileFirstServer/configuration-samples/** 目录中提供的样本配置文件。 有关使用 Ant 任务安装 {{ site.data.keys.mf_server }} 的更多信息，请参阅[使用 Ant 任务进行安装](../appserver/#installing-with-ant-tasks)。

### 样本配置文件的列表
{: #list-of-sample-configuration-files }
选取相应的样本配置文件。 提供以下文件。

| 任务                                                     | Derby                     | DB2                     | MySQL                     | Oracle                      |
|----------------------------------------------------------|---------------------------|-------------------------|---------------------------|-----------------------------|
| 通过数据库管理员凭证创建数据库 | create-database-derby.xml | create-database-db2.xml | create-database-mysql.xml | create-database-oracle.xml
| 在 Liberty 上安装 {{ site.data.keys.mf_server }}	                   | configure-liberty-derby.xml | configure-liberty-db2.xml | configure-liberty-mysql.xml | （请参阅有关 MySQL 的注释） | configure-liberty-oracle.xml |
| 在 WebSphere Application Server Full Profile 单台服务器上安装 {{ site.data.keys.mf_server }} |	configure-was-derby.xml | configure-was-db2.xml | configure-was-mysql.xml（请参阅有关 MySQL 的注释） | configure-was-oracle.xml |
| 在 WebSphere Application Server Network Deployment 上安装 {{ site.data.keys.mf_server }}（请参阅有关配置文件的注释） | configure-wasnd-cluster-derby.xml、configure-wasnd-server-derby.xml 和 configure-wasnd-node-derby.xml。 configure-wasnd-cell-derby.xml | configure-wasnd-cluster-db2.xml、configure-wasnd-server-db2.xml、configure-wasnd-node-db2.xml 和 configure-wasnd-cell-db2.xml | configure-wasnd-cluster-mysql.xml（请参阅有关 MySQL 的注释）、configure-wasnd-server-mysql.xml（请参阅有关 MySQL 的注释）、configure-wasnd-node-mysql.xml（请参阅有关 MySQL 的注释）以及 configure-wasnd-cell-mysql.xml | configure-wasnd-cluster-oracle.xml、 configure-wasnd-server-oracle.xml、configure-wasnd-node-oracle.xml 和 configure-wasnd-cell-oracle.xml |
| 在 Apache Tomcat 上安装 {{ site.data.keys.mf_server }}	           | configure-tomcat-derby.xml | configure-tomcat-db2.xml | configure-tomcat-mysql.xml | configure-tomcat-oracle.xml |
| 在 Liberty 集合体上安装 {{ site.data.keys.mf_server }}	       | 不相关              | configure-libertycollective-db2.xml | configure-libertycollective-mysql.xml | configure-libertycollective-oracle.xml |

**有关 MySQL 的注释：**与 WebSphere Application Server Liberty Profile 或 WebSphere Application Server Full Profile 结合使用的 MySQL 不属于受支持的配置。 有关更多信息，请参阅 WebSphere Application Server Support Statement。 考虑使用 IBM DB2 或其他受 WebSphere Application Server 支持的数据库，以从 IBM 支持中心全面支持的配置中受益。

**有关 WebSphere Application Server Network Deployment 配置文件的注释：****wasnd** 的配置文件包含作用域，可将其设置为 **cluster**、**node**、**server** 或 **cell**。 例如，对于 **configure-wasnd-cluster-derby.xml**，该作用域为 **cluster**。 这些作用域类型按如下方式定义部署目标：

* **cluster**：部署到集群。
* **server**：部署到由 Deployment Manager 管理的单个服务器。
* **node**：部署到在节点上运行但不属于集群的所有服务器。
* **cell**：部署到单元上的所有服务器。

## {{ site.data.keys.mf_analytics }} 的样本配置文件
{: #sample-configuration-files-for-mobilefirst-analytics }
{{ site.data.keys.product }}
包含多个样本配置文件，这些样本配置文件可帮助您启动 Ant 任务来安装 {{ site.data.keys.mf_analytics }}
Services 和 {{ site.data.keys.mf_analytics_console }}。

开始学习 `<installanalytics>`、`<updateanalytics>` 和 `<uninstallanalytics>` Ant 任务的最简单方式就是通过使用 {{ site.data.keys.mf_server }} 分发版的 **Analytics/configuration-samples/** 目录中提供的样本配置文件。

### 步骤 1
{: #step-1 }
选取相应的样本配置文件。 提供以下 XML 文件。 这些文件在后续步骤中称为 **configure-file.xml**。

| 任务 | 应用程序服务器 |
|------|--------------------|
| 在 WebSphere Application Server Liberty Profile 上安装 {{ site.data.keys.mf_analytics }} Services and Console | configure-liberty-analytics.xml |
| 在 Apache Tomcat 上安装 {{ site.data.keys.mf_analytics }}
Services and Console | configure-tomcat-analytics.xml |
| 在 WebSphere Application Server Full Profile 上安装 {{ site.data.keys.mf_analytics }} Services and Console | configure-was-analytics.xml |
| 在 WebSphere Application Server Network Deployment 单台服务器上安装 {{ site.data.keys.mf_analytics }} Services and Console。 | configure-wasnd-server-analytics.xml |
| 在 WebSphere Application Server Network Deployment 单元上安装 {{ site.data.keys.mf_analytics }} Services and Console | configure-wasnd-cell-analytics.xml |
| 在  WebSphere Application Server Network Deployment 节点上安装 {{ site.data.keys.mf_analytics }} Services and Console | configure-wasnd-node.xml |
| 在 WebSphere Application Server Network Deployment 集群上安装 {{ site.data.keys.mf_analytics }} Services and Console | configure-wasnd-cluster-analytics.xml |

**有关 WebSphere Application Server Network Deployment 配置文件的注释：**  
wasnd 的配置文件包含作用域，可将其设置为 **cluster**、**node**、**server** 或 **cell**。 例如，对于 **configure-wasnd-cluster-analytics.xml**，作用域为 **cluster**。 这些作用域类型按如下方式定义部署目标：

* **cluster**：部署到集群。
* **server**：部署到由 Deployment Manager 管理的单个服务器。
* **node**：部署到在节点上运行但不属于集群的所有服务器。
* **cell**：部署到单元上的所有服务器。

### 步骤 2
{: #step-2 }
更改样本文件的文件访问权限，尽可能提高其限制性。 步骤 3 需要您提供某些密码。 如果要防止同一台电脑上的其他用户获取这些密码，必须除去其他用户对文件的读许可权。 您可以使用命令，如以下示例：

在 UNIX 上：`chmod 600 configure-file.xml`
在 Windows 上：`cacls configure-file.xml /P Administrators:F %USERDOMAIN%\%USERNAME%:F`

### 步骤 3
{: #step-3 }
同样，如果应用程序服务器是 WebSphere Application Server Liberty Profile 或 Apache Tomcat，且该服务器仅从您的用户帐户启动，那么还必须从以下文件除去其他用户的读许可权：

* 对于 WebSphere Application Server Liberty profile：**wlp/usr/servers/<server>/server.xml**
* 对于 Apache Tomcat：**conf/server.xml**

### 步骤 4
{: #step-4 }
替换文件开始处的属性的占位符值。

**注：**  
当在 Ant XML 脚本值中使用以下特殊字符时，必须对这些字符进行转义：

* 美元符号 (`$`) 必须写作 $$，除非您明确希望通过语法 `${variable}` 引用 Ant 变量，如 Apache Ant Manual 的 Properties 部分中所述。
* 和号字符 (`&`) 必须写作 `&amp;`，除非您明确希望引用 XML 实体。
* 双引号 (`"`) 必须写作 `&quot;`，除非它在由单引号括起的字符串内。

### 步骤 5
{: #step-5 }
运行命令：`ant -f configure-file.xml install`

此命令将 {{ site.data.keys.mf_analytics }} Services 和 {{ site.data.keys.mf_analytics_console }} 组件安装到应用程序服务器中。
要安装更新的 {{ site.data.keys.mf_analytics }} Services 和 {{ site.data.keys.mf_analytics_console }} 组件，例如，在应用 {{ site.data.keys.mf_server }} 修订包时，运行以下命令：`ant -f configure-file.xml minimal-update`。

要撤销安装步骤，请运行命令：`ant -f configure-file.xml uninstall`

该命令会卸载 {{ site.data.keys.mf_analytics }} Services 和 {{ site.data.keys.mf_analytics_console }} 组件。
