---
layout: tutorial
title: 设置数据库
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
以下 {{ site.data.keys.mf_server_full }} 组件需要将技术数据存储到数据库中：

* {{ site.data.keys.mf_server }} 管理服务
* {{ site.data.keys.mf_server }} 实时更新服务
* {{ site.data.keys.mf_server }} 推送服务
* {{ site.data.keys.product }} 运行时

> **注：**如果使用不同的上下文根来安装多个运行时实例，那么每一个实例均需要其自身的一组表。
>数据库可以是关系数据库（例如，IBM DB2、Oracle 或 MySQL）。

#### 关系数据库（DB2、Oracle 或 MySQL）
{: #relational-databases-db2-oracle-or-mysql }
每个组件均需要一组表。可以通过运行特定于每个组件的 SQL 脚本（请参阅[手动创建数据库表](#create-the-database-tables-manually)）、通过使用 Ant 任务或 Server Configuration Tool 来手动创建表。每个组件的表名称均不重叠。因此，可以将这些组件的所有表置于一个模式下。

但是，如果您决定安装 {{ site.data.keys.product }} 运行时的多个实例（每一个在应用程序服务器中均具有其自身的上下文根），那么每个实例均需要其自身的一组表。在这种情况下，它们需要处于不同模式中。

> **有关 DB2 的注释：** {{ site.data.keys.product_adj }} 被许可方有权将 DB2 用作 Foundation 的支持系统。要得益于此，必须在安装 DB2 软件之后：
> 
> * 直接从 [IBM Passport Advantage (PPA) Web 站点](https://www-01.ibm.com/software/passportadvantage/pao_customer.html)下载受限使用的激活映像
> * 使用 **db2licm** 命令应用受限使用的激活许可证文件 **db2xxxx.lic**
>
> 从 [DB2 IBM Knowledge Center](http://www.ibm.com/support/knowledgecenter/SSEPGG_10.5.0/com.ibm.db2.luw.kc.doc/welcome.html) 中获取更多信息
#### 跳转至
{: #jump-to }

* [数据库用户和权限](#database-users-and-privileges)
* [数据库需求](#database-requirements)
* [手动创建数据库表](#create-the-database-tables-manually)
* [使用 Server Configuration Tool 创建数据库表](#create-the-database-tables-with-the-server-configuration-tool)
* [使用 Ant 任务创建数据库表](#create-the-database-tables-with-ant-tasks)

## 数据库用户和权限
{: #database-users-and-privileges }
在运行时，应用程序服务器中的 {{ site.data.keys.mf_server }} 应用程序使用数据源作为资源来获取到关系数据库的连接。数据源需要具有特定数据库访问权限的用户。

您需要为部署到应用程序服务器的每个 {{ site.data.keys.mf_server }} 应用程序配置数据源，然后才能访问关系数据库。数据源需要具有特定数据库访问权限的用户。您需要创建的用户数量取决于用于将 {{ site.data.keys.mf_server }} 应用程序部署到应用程序服务器的安装过程。

### 使用 Server Configuration Tool 安装
{: #installation-with-the-server-configuration-tool }
同一用户将用于所有组件（{{ site.data.keys.mf_server }} 管理服务、{{ site.data.keys.mf_server }} 配置服务、{{ site.data.keys.mf_server }} 推送服务和 {{ site.data.keys.product }} 运行时）

### 使用 Ant 任务进行安装
{: #installation-with-ant-tasks }
在产品分发版中提供的样本 Ant 文件将对所有组件使用同一用户。但是，可以修改 Ant 文件以具有不同的用户：

* 由于不能使用 Ant 任务单独安装管理服务和配置服务，因此对管理服务和配置服务使用同一用户。
* 对运行时使用不同用户
* 对推送服务使用不同用户。

### 手动安装
{: #manual-installation }
可以向每个 {{ site.data.keys.mf_server }} 组件分配不同的数据源，以此分配不同的用户。在运行时，用户必须对数据表和序列具有以下权限：

* SELECT TABLE
* INSERT TABLE
* UPDATE TABLE
* DELETE TABLE
* SELECT SEQUENCE

如果在使用 Ant 任务或 Server Configuration Tool 运行安装之前没有手动创建表，请确保您具有能够创建表的用户。还需要以下权限：

* CREATE INDEX
* CREATE SEQUENCE
* CREATE TABLE

对于产品升级，需要以下额外权限：

* ALTER TABLE
* CREATE VIEW
* DROP INDEX
* DROP SEQUENCE
* DROP TABLE
* DROP VIEW

## 数据库需求
{: #database-requirements }
数据库用于存储 {{ site.data.keys.mf_server }} 应用程序的所有数据。在安装 {{ site.data.keys.mf_server }} 组件之前，请确保满足数据库需求。

* [DB2 数据库和用户需求](#db2-database-and-user-requirements)
* [Oracle 数据库和用户需求](#oracle-database-and-user-requirements)
* [MySQL 数据库和用户需求](#mysql-database-and-user-requirements)

> 有关受支持的数据库软件版本的最新列表，请参阅[系统需求](../../../product-overview/requirements/)页面。


### DB2 数据库和用户需求
{: #db2-database-and-user-requirements }
查看 DB2 的数据库需求。遵循步骤来创建用户和数据库，并设置您的数据库以满足特定需求。

请确保将数据库字符集设置为 UTF-8。

数据库的页面大小必须至少为 32768。以下过程创建了页面大小为 32768 的数据库。此过程还创建了用户 (**mfpuser**)，然后向该用户授予数据库访问权。之后，Server Configuration Tool 或 Ant 任务可使用该用户来创建表。

1. 使用您操作系统的相应命令在 DB2 管理员组（如 **DB2USERS**）中创建一个系统用户（例如，名为 **mfpuser** 的用户）。为其设置密码，例如，**mfpuser**。
2. 以具有 **SYSADM** 或 **SYSCTRL** 权限的用户的身份打开 DB2 命令行处理器。
    * 在 Windows 系统中，单击**开始 → IBM DB2 → 命令行处理器**。
    * 在 Linux 或 UNIX 系统上，浏览至 **~/sqllib/bin** 并输入 `/db2`。
3. 要创建 {{ site.data.keys.mf_server }} 数据库，请输入与以下示例类似的 SQL 语句。

将用户名 **mfpuser** 替换为您自己的用户名。

```sql
CREATE DATABASE MFPDATA COLLATE USING SYSTEM PAGESIZE 32768
CONNECT TO MFPDATA
GRANT CONNECT ON DATABASE TO USER mfpuser
DISCONNECT MFPDATA
QUIT
```

### Oracle 数据库和用户需求
{: #oracle-database-and-user-requirements }
查看 Oracle 的数据库需求。遵循步骤来创建用户和数据库，并设置您的数据库以满足特定需求。

请确保将数据库字符集设置为 Unicode character set (AL32UTF8)，将国家字符集设置为 UTF8 - Unicode 3.0 UTF-8。  

运行时用户（如[数据库用户和权限](#database-users-and-privileges)中所论述）必须具有关联的表空间和足够的配额来编写 {{ site.data.keys.product }} 服务所需要的技术数据。有关产品所使用的表的更多信息，请参阅[内部运行时数据库](../installation-reference/#internal-runtime-databases)。

期望在运行时用户的缺省模式中创建表。Ant 任务和 Server Configuration Tool 将在作为自变量传递的用户的缺省模式中创建各表。有关创建表的更多信息，请参阅[手动创建 Oracle 数据库表](#creating-the-oracle-database-tables-manually)。

此过程将创建数据库（如果需要）。将添加可在此数据库中创建表和索引的用户，并且会将该用户用作运行时用户。

1. 如果您还没有数据库，请使用 Oracle Database Configuration Assistant (DBCA) 并执行向导中的步骤来新建名为 ORCL 的常规用途数据库，如本示例所示：
    * 使用全局数据库名称 **ORCL\_your\_domain** 和系统标识 (SID) **ORCL**。
    * 在步骤**数据库内容**的**定制脚本**选项卡上，请不要运行 SQL 脚本，因为您必须先创建一个用户帐户。
    * 在步骤**初始化参数**的**字符集**选项卡上，选择**使用 Unicode (AL32UTF8) 字符集和 UTF8 - Unicode 3.0 UTF-8 国家字符集**。
    * 完成此过程（接受缺省值）。
2. 通过使用 Oracle Database Control 或 Oracle SQLPlus 命令行解释器来创建数据库用户。
3. 使用 Oracle Database Control：
    * 以 **SYSDBA** 身份连接。
    * 转至**用户**页面，单击**服务器**，然后单击**安全**部分中的**用户**。
    * 创建用户，例如 **MFPUSER**。
    * 指定以下属性：
        * **Profile**: DEFAULT
        * **Authentication**: password
        * **Default tablespace**: USERS
        * **Temporary tablespace**: TEMP
        * **Status**: Unlocked
        * Add system privilege: CREATE SESSION
        * Add system privilege: CREATE SEQUENCE

        * Add system privilege: CREATE TABLE
        * Add quota: Unlimited for tablespace USERS
    * 使用 Oracle SQLPlus 命令行解释器：

以下示例中的命令将为数据库创建名为 **MFPUSER** 的用户：

```sql
CONNECT SYSTEM/<SYSTEM_password>@ORCL
CREATE USER MFPUSER IDENTIFIED BY MFPUSER_password DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;
GRANT CREATE SESSION, CREATE SEQUENCE, CREATE TABLE TO MFPUSER;
DISCONNECT;
```

### MySQL 数据库和用户需求
{: #mysql-database-and-user-requirements }
查看 MySQL 的数据库需求。遵循以下步骤来创建用户和数据库，并配置数据库以满足特定需求。

确保将字符集设置为 UTF8。

必须使用相应的值指定以下属性：

* max_allowed_packet（使用 256 M 或更高）
* innodb_log_file_size（使用 250 M 或更高）

有关如何设置这些属性的更多信息，请参阅 [MySQL 文档](http://dev.mysql.com/doc/)。  
此过程会创建数据库 (MFPDATA) 和用户 (mfpuser)，此用户可从主机 (mfp-host) 连接到具有所有特权的数据库。

1. 使用选项 `-u root` 运行 MySQL 命令行客户机。
2. 输入以下命令：

   ```sql
   CREATE DATABASE MFPDATA CHARACTER SET utf8 COLLATE utf8_general_ci;
   GRANT ALL PRIVILEGES ON MFPDATA.* TO 'mfpuser'@'mfp-host' IDENTIFIED BY 'mfpuser-password';
   GRANT ALL PRIVILEGES ON MFPDATA.* TO 'mfpuser'@'localhost' IDENTIFIED BY 'mfpuser-password';
   FLUSH PRIVILEGES;
   ```

    其中，@ 符号前面的 mfpuser 是用户名，**IDENTIFIED BY** 后面的 **mfpuser-password** 是密码，**mfp-host** 是运行 {{ site.data.keys.product_adj }} 的主机的名称。
    
    用户必须能够从运行安装了 {{ site.data.keys.mf_server }} 应用程序的 Java 应用程序服务器的主机连接到 MySQL 服务器。
    
## 手动创建数据库表
{: #create-the-database-tables-manually }
可以使用 Ant 任务或使用 Server Configuration Tool 来为 {{ site.data.keys.mf_server }} 应用程序手动创建数据库表。这些主题提供了有关如何手动创建这些数据库表的说明和详细信息。

* [手动创建 DB2 数据库表](#creating-the-db2-database-tables-manually)
* [手动创建 Oracle 数据库表](#creating-the-oracle-database-tables-manually)
* [手动创建 MySQL 数据库表](#creating-the-mysql-database-tables-manually)

### 手动创建 DB2 数据库表
{: #creating-the-db2-database-tables-manually }
使用 {{ site.data.keys.mf_server }} 安装中提供的 SQL 脚本创建 DB2 数据库表。

如“概述”部分中所述，全部四个 {{ site.data.keys.mf_server }} 组件均需要表。可以在同一模式或不同模式下创建这些组件。但是，某些约束将适用，具体取决于如何将 {{ site.data.keys.mf_server }} 应用程序部署到 Java 应用程序服务器。它们与[数据库用户和权限](#database-users-and-privileges)中所述的有关 DB2 可能用户的主题相类似。

#### 使用 Server Configuration Tool 安装
{: #installation-with-the-server-configuration-tool-1 }
同一模式用于所有组件（{{ site.data.keys.mf_server }} 管理服务、{{ site.data.keys.mf_server }} 实时更新服务、{{ site.data.keys.mf_server }} 推送服务和 {{ site.data.keys.product }} 运行时）

#### 使用 Ant 任务进行安装
{: #installation-with-ant-tasks-1 }
产品分发中提供的样本 Ant 文件将同一模式用于所有组件。但是，可以修改 Ant 文件，使其具有不同的模式：

* 管理服务和实时更新服务的模式相同，因为无法单独使用 Ant 任务来安装这两种服务。
* 运行时的模式不同
* 推送服务的模式不同。

#### 手动安装
{: #manual-installation-1 }
可以向 {{ site.data.keys.mf_server }} 组件中的每一个组件分配不同的数据源（进而分配不同的模式）。  
用于创建表的脚本如下所示：

* 对于管理服务，位于 **mfp\_install\_dir/MobileFirstServer/databases/create-mfp-admin-db2.sql**。
* 对于实时更新服务，位于 **mfp\_install\_dir/MobileFirstServer/databases/create-configservice-db2.sql**。
* 对于运行时组件，位于 **mfp\_install\_dir/MobileFirstServer/databases/create-runtime-db2.sql**。
* 对于推送服务，位于 **mfp\_install\_dir/PushService/databases/create-push-db2.sql**。

以下过程为处于同一模式 (MFPSCM) 的所有应用程序创建了表。假定已创建数据库和用户。有关更多信息，请参阅 [DB2 数据库和用户需求](#db2-database-and-user-requirements)。

通过用户 (mfpuser) 使用以下命令来运行 DB2：

```sql
db2 CONNECT TO MFPDATA
db2 SET CURRENT SCHEMA = 'MFPSCM'
db2 -vf mfp_install_dir/MobileFirstServer/databases/create-mfp-admin-db2.sql
db2 -vf mfp_install_dir/MobileFirstServer/databases/create-configservice-db2.sql -t
db2 -vf mfp_install_dir/MobileFirstServer/databases/create-runtime-db2.sql -t
db2 -vf mfp_install_dir/PushService/databases/create-push-db2.sql -t
```

如果 mfpuser 创建了表，那么该用户将自动具有访问此表的特权，并且可以在运行时使用此表。如果您要限制[数据库用户和权限](#database-users-and-privileges)中所述的运行时用户的特权或更好地控制特权，请参阅 DB2 文档。


### 手动创建 Oracle 数据库表
{: #creating-the-oracle-database-tables-manually }
使用 {{ site.data.keys.mf_server }} 安装中提供的 SQL 脚本创建 Oracle 数据库表。

如“概述”部分中所述，全部四个 {{ site.data.keys.mf_server }} 组件均需要表。可以在同一模式或不同模式下创建这些组件。但是，某些约束将适用，具体取决于如何将 {{ site.data.keys.mf_server }} 应用程序部署到 Java 应用程序服务器。[数据库用户和权限](#database-users-and-privileges)中描述了详细信息。


必须在运行时用户的缺省模式下创建表。用于创建表的脚本如下所示：

* 对于管理服务，位于 **mfp\_install\_dir/MobileFirstServer/databases/create-mfp-admin-oracle.sql**。

* 对于实时更新服务，位于 **mfp\_install\_dir/MobileFirstServer/databases/create-configservice-oracle.sql**。

* 对于运行时组件，位于 **mfp\_install\_dir/MobileFirstServer/databases/create-runtime-oracle.sql**。

* 对于推送服务，位于 **mfp\_install\_dir/PushService/databases/create-push-oracle.sql**。


以下过程为同一用户 (**MFPUSER**) 的所有应用程序创建了表。假定已创建数据库和用户。有关更多信息，请参阅 [Oracle 数据库和用户需求](#oracle-database-and-user-requirements)。


在 Oracle SQLPlus 中运行以下命令：

```sql
CONNECT MFPUSER/MFPUSER_password@ORCL
@mfp_install_dir/MobileFirstServer/databases/create-mfp-admin-oracle.sql
@mfp_install_dir/MobileFirstServer/databases/create-configservice-oracle.sql
@mfp_install_dir/MobileFirstServer/databases/create-runtime-oracle.sql
@mfp_install_dir/PushService/databases/create-push-oracle.sql
DISCONNECT;
```

如果 MFPUSER 创建了表，那么该用户将自动具有访问此表的特权，并且可以在运行时使用此表。将在用户的缺省模式下创建表。如果您要限制[数据库用户和权限](#database-users-and-privileges)中所述的运行时用户的特权或更好地控制特权，请参阅 Oracle 文档。


### 手动创建 MySQL 数据库表
{: #creating-the-mysql-database-tables-manually }
使用 {{ site.data.keys.mf_server }} 安装中提供的 SQL 脚本创建 MySQL 数据库表。

如“概述”部分中所述，全部四个 {{ site.data.keys.mf_server }} 组件均需要表。可以在同一模式或不同模式下创建这些组件。但是，某些约束将适用，具体取决于如何将 {{ site.data.keys.mf_server }} 应用程序部署到 Java 应用程序服务器。它们与[数据库用户和权限](#database-users-and-privileges)中所述的有关 MySQL 可能用户的主题相类似。


#### 使用 Server Configuration Tool 安装
{: #installation-with-the-server-configuration-tool-2 }
同一数据库用于所有组件（{{ site.data.keys.mf_server }} 管理服务、{{ site.data.keys.mf_server }} 实时更新服务、{{ site.data.keys.mf_server }} 推送服务和 {{ site.data.keys.product }} 运行时）

#### 使用 Ant 任务进行安装
{: #installation-with-ant-tasks-2 }
产品分发版中提供的样本 Ant 文件将同一数据库用于所有组件。但是，可以修改 Ant 文件，使其具有不同的数据库：

* 管理服务和实时更新服务的数据库相同，因为无法单独使用 Ant 任务来安装这两种服务。
* 对运行时使用不同的数据库
* 推送服务的数据库不同。

#### 手动安装
{: #manual-installation-2 }
可以向 {{ site.data.keys.mf_server }} 组件中的每一个组件分配不同的数据源（进而分配不同的数据库）。  
用于创建表的脚本如下所示：

* 对于管理服务，位于 **mfp\_install\_dir/MobileFirstServer/databases/create-mfp-admin-mysql.sql**。

* 对于实时更新服务，位于 **mfp\_install\_dir/MobileFirstServer/databases/create-configservice-mysql.sql**。

* 对于运行时组件，位于 **mfp\_install\_dir/MobileFirstServer/databases/create-runtime-mysql.sql**。

* 对于推送服务，位于 **mfp\_install\_dir/PushService/databases/create-push-mysql.sql**。


以下示例为同一用户和数据库的所有应用程序创建了表。
假定已如[MySQL 的数据库需求](#database-requirements)中所述创建了数据库和用户。


以下过程为同一用户 (mfpuser) 和数据库 (MFPDATA) 的所有应用程序创建了表。它假定已创建数据库和用户。

1. 使用以下选项运行 MySQL 命令行客户机：`-u mfpuser`。
2. 输入以下命令：

```sql
USE MFPDATA;
SOURCE mfp_install_dir/MobileFirstServer/databases/create-mfp-admin-mysql.sql;
SOURCE mfp_install_dir/MobileFirstServer/databases/create-configservice-mysql.sql;
SOURCE mfp_install_dir/MobileFirstServer/databases/create-runtime-mysql.sql;
SOURCE mfp_install_dir/PushService/databases/create-push-mysql.sql;
```

## 使用 Server Configuration Tool 创建数据库表

{: #create-the-database-tables-with-the-server-configuration-tool }
可以使用 Ant 任务或使用 Server Configuration Tool 来为 {{ site.data.keys.mf_server }} 应用程序手动创建数据库表。以下主题提供了有关使用 Server Configuration Tool 安装 {{ site.data.keys.mf_server }} 时设置数据库的说明和详细信息。


Server Configuration Tool 可以在安装过程中创建数据库表。在某些情况下，甚至可以为 {{ site.data.keys.mf_server }} 组件创建数据库和用户。有关使用 Server Configuration Tool 的安装流程的概述，请参阅[以图形方式安装 {{ site.data.keys.mf_server }}](../tutorials/graphical-mode)。


在完成配置凭证并单击 Server Configuration Tool 窗格中的**部署**之后，将运行以下操作：


* 需要时创建数据库和用户。
* 验证数据库中是否存在 {{ site.data.keys.mf_server }} 表。如果不存在，请创建这些表。
* 将 {{ site.data.keys.mf_server }} 应用程序部署到应用程序服务器。

如果在运行 Server Configuration Tool 之前已手动创建了数据库表，那么此工具会检测到这些表，并跳过设置表的阶段。


根据您选择的受支持数据库管理系统 (DBMS)，请选择以下某个主题以了解有关此工具如何创建数据库表的更多详细信息：

* [使用 Server Configuration Tool 创建 DB2 数据库表](#creating-the-db2-database-tables-with-the-server-configuration-tool)

* [使用 Server Configuration Tool 创建 Oracle 数据库表](#creating-the-oracle-database-tables-with-the-server-configuration-tool)

* [使用 Server Configuration Tool 创建 MySQL 数据库表](#creating-the-mysql-database-tables-with-the-server-configuration-tool)

### 使用 Server Configuration Tool 创建 DB2 数据库表
{: #creating-the-db2-database-tables-with-the-server-configuration-tool }
使用 {{ site.data.keys.mf_server }} 安装提供的 Server Configuration Tool 来创建 DB2 数据库表。

Server Configuration Tool 可以在缺省 DB2 实例中创建数据库。在 Server Configuration Tool 的**数据库选择**面板中，选择 IBM DB2 选项。在后续三个窗格中，输入数据库凭证。如果在**数据库额外设置**面板中输入的数据库名称不存在于 DB2 实例中，可以输入额外信息以使该工具能够为您创建数据库。

Server Configuration Tool 使用以下 SQL 语句按照缺省设置创建数据库表：
```sql
CREATE DATABASE MFPDATA COLLATE USING SYSTEM PAGESIZE 32768
```

此设置并不适用于生产，因为在缺省 DB2 安装中，许多权限都是公开的。

### 使用 Server Configuration Tool 创建 Oracle 数据库表
{: #creating-the-oracle-database-tables-with-the-server-configuration-tool }
使用 {{ site.data.keys.mf_server }} 安装随附的 Server Configuration Tool 创建 Oracle 数据库表。

在 Server Configuration Tool 的数据库选择面板中，选择 **Oracle Standard 或 Enterprise Editions 11g 或 12c** 选项。在下面的三个窗格中，输入数据库凭证。

在**数据库附加设置**面板中输入 Oracle 用户名时，必须采用大写形式。如果您使用 Oracle 数据库用户 (FOO)，但以小写形式 (foo) 输入用户名，那么 Server Configuration Tool 会将其视为另一位用户。与 Oracle 数据库的其他工具不同，Server Configuration Tool 会对用户名进行保护，以防止自动转换为大写。

Server Configuration Tool 使用服务名称或 Oracle 系统标识 (SID) 来标识数据库。但是，如果要连接到 Oracle RAC，需输入复杂的 JDBC URL。在这种情况下，在**数据库设置**面板中，选择**使用通用 Oracle JDBC URL 连接**选项，并输入 Oracle 瘦驱动程序的 URL。

如果需要为 Oracle 创建数据库和用户，请使用 Oracle Database Creation Assistant (DBCA) 工具。有关更多信息，请参阅 [Oracle 数据库和用户需求](#oracle-database-and-user-requirements)。


Server Configuration Tool 可以执行相同的任务但存在限制。该工具可为 Oracle 11g 或 Oracle 12g 创建用户。
但是，它只能为 Oracle 11g 创建数据库，而不能为 Oracle 12c 创建数据库。

如果在**数据库附加设置**面板中输入的数据库名称或用户名不存在，请参阅以下两部分内容，以了解有关创建数据库或用户的额外步骤。

#### 创建数据库
{: #creating-the-database }

1. 在运行 Oracle 数据库的计算机上运行 SSH 服务器。

    Server Configuration Tool 可打开与 Oracle 主机的 SSH 会话以创建数据库。除了 Linux 和部分版本的 UNIX 系统，即使 Oracle 数据库与 Server Configuration Tool 在相同计算机上运行，也需要 SSH 服务器。

2. 在**数据库创建请求**面板中，输入有权创建数据库的 Oracle 数据库用户的登录标识和密码。
3. 在同一面板中，还应为要创建的数据库输入 **SYS** 用户和 **SYSTEM** 用户的密码。

将使用在**数据库附加设置**面板中输入的 SID 名称创建数据库。这并不意味着可用于生产。

#### 创建用户
{: #creating-the-user }

1. 在运行 Oracle 数据库的计算机上运行 SSH 服务器。

    Server Configuration Tool 可打开与 Oracle 主机的 SSH 会话以创建数据库。除了 Linux 和部分版本的 UNIX 系统，即使 Oracle 数据库与 Server Configuration Tool 在相同计算机上运行，也需要 SSH 服务器。

2. 在**数据库附加设置**面板中，输入要创建的数据库用户的登录标识和密码。
3. 在**数据库创建请求**面板中，输入有权创建数据库用户的 Oracle 数据库用户的登录标识和密码。
4. 在同一面板中，还应输入数据库的 **SYSTEM** 用户的密码。

### 使用 Server Configuration Tool 创建 MySQL 数据库表
{: #creating-the-mysql-database-tables-with-the-server-configuration-tool }
使用 {{ site.data.keys.mf_server }} 安装随附的 Server Configuration Tool 创建 MySQL 数据库表。

Server Configuration Tool 可以为您创建 MySQL 数据库。在 Server Configuration Tool 的**数据库选择**面板中，选择 **MySQL 5.5.x、5.6.x 或 5.7.x** 选项。在后续三个窗格中，输入数据库凭证。如果您在数据库额外设置面板中输入的数据库或用户不存在，此工具会创建该数据库或用户。

如果 MySQL 服务器无 [MySQL 数据库和用户需求](#mysql-database-and-user-requirements)中建议的设置，那么 Server Configuration Tool 会显示一条警告。运行 Server Configuration Tool 之前，请确保满足这些需求。

以下过程提供了一些额外步骤，您在使用此工具创建数据库表时需要执行这些步骤。

1. 在**数据库额外设置**面板中，除了连接设置，必须输入允许用户从中连接到数据库的所有主机。
也即，所有运行 {{ site.data.keys.mf_server }} 的主机。
2. 在**数据库创建请求**面板中，输入 MySQL 管理员的登录标识和密码。缺省情况下，管理员为 root 用户。

## 使用 Ant 任务创建数据库表
{: #create-the-database-tables-with-ant-tasks }
可以使用 Ant 任务或使用 Server Configuration Tool 来为 {{ site.data.keys.mf_server }} 应用程序手动创建数据库表。以下主题提供了有关如何使用 Ant 任务创建数据库表的说明及详细信息。

如果使用 Ant 任务安装 {{ site.data.keys.mf_server }}，那么可在本部分中找到有关如何设置数据库的相关信息。

您可以使用 Ant 任务来设置 {{ site.data.keys.mf_server }} 数据库表。在某些情况下，还可以使用这些任务创建数据库和用户。有关使用 Ant 任务的安装流程的概述，请参阅[以命令行方式安装 {{ site.data.keys.mf_server }}](../tutorials/command-line)。

安装提供了一组样本 Ant 文件，来帮助您着手完成 Ant 任务。您可以在 **mfp\_install\_dir/MobileFirstServer/configurations-samples** 中找到这些文件。文件依据以下模式命名：

#### configure-appserver-dbms.xml
{: #configure-appserver-dbmsxml }
Ant 文件能够完成以下任务：

* 在数据库中创建表（如数据库和数据库用户存在）。[数据库需求](#database-requirements)中列出了数据库的需求。
* 将 {{ site.data.keys.mf_server }} 组件的 WAR 文件部署到应用程序服务器中。这些 Ant 文件使用相同的数据库用户来创建表，并在运行时为应用程序安装运行时数据库用户。这些文件还针对所有的 {{ site.data.keys.mf_server }} 应用程序使用相同的数据库用户。

#### create-database-dbms.xml
{: #create-database-dbmsxml }
Ant 文件可创建数据库（如受支持的数据库管理系统 (DBMS) 上需要），然后在数据库中创建表。然而，尽管数据库是使用缺省设置创建的，但并不意味着可用于生产。

在 Ant 文件中，可找到使用 **configureDatabase** Ant 任务设置数据库的预定义目标。有关更多信息，请参阅 [Ant configuredatabase](../installation-reference/#ant-configuredatabase-task-reference) 任务参考。

### 使用样本 Ant 文件
{: #using-the-sample-ant-files }
样本 Ant 文件具有预定义目标。请遵循以下过程以使用这些文件。

1. 根据应用程序服务器和数据库配置复制工作目录中的 Ant 文件。
2. 编辑该文件并在 Ant 文件的 `<! -- Start of Property Parameters -->` 部分为配置输入值。
3. 运行具有 databases 目标的 Ant 文件：`mfp_install_dir/shortcuts/ant -f your_ant_file databases`。

此命令用于为所有 {{ site.data.keys.mf_server }} 应用程序（{{ site.data.keys.mf_server }} 管理服务、{{ site.data.keys.mf_server }} 实时更新服务、{{ site.data.keys.mf_server }} 推送服务和 {{ site.data.keys.mf_server }} 运行时），在指定数据库和模式中创建表。将生成操作日志并存储在磁盘中。

* 在 Windows 上，位于 **{{ site.data.keys.prod_server_data_dir_win }}\\Configuration Logs\\** 目录。
* 在 UNIX 上，位于 **{{ site.data.keys.prod_server_data_dir_unix }}/configuration-logs/** 目录。

### 用于数据库表创建和运行时的不同用户
{: #different-users-for-the-database-tables-creation-and-for-run-time }
**mfp\_install\_dir/MobileFirstServer/configurations-samples** 中的样本 Ant 文件将相同的数据库用户用于：

* 所有 {{ site.data.keys.mf_server }} 应用程序（管理服务、实时更新服务、推送服务以及运行时）
* 用于在运行时为应用程序服务器中的数据源创建数据库和用户的用户。

如果要如[数据库用户和权限](#database-users-and-privileges)中所述分离用户，需创建您自己的 Ant 文件或修改样本 Ant 文件，以便每个数据库目标均有一位不同的用户。有关更多信息，请参阅[安装参考](../installation-reference)。

对于 DB2 和 MySQL，可以让不同用户负责数据库创建和运行时。[数据库用户和权限](#database-users-and-privileges)中列出了每一类用户的特权。对于 Oracle，创建数据库和运行时无法具有不同的用户。Ant 任务认为表属于“一个用户”的缺省模式。如果要减少运行时用户的特权，必须在运行时将使用的那位用户的缺省模式中手动创建表。有关更多信息，请参阅[手动创建 Oracle 数据库表](#creating-the-oracle-database-tables-manually)。

根据您所选的受支持的数据库管理系统 (DBMS)，选择以下某个主题以使用 Ant 任务创建数据库。

### 使用 Ant 任务创建 DB2 数据库表
{: #creating-the-db2-database-tables-with-ant-tasks }
使用 {{ site.data.keys.mf_server }} 安装提供的 Ant 任务创建 DB2 数据库。

要在已存在的数据库中创建数据库表，请参阅[使用 Ant 任务创建数据库表](#create-the-database-tables-with-ant-tasks)。

要创建数据库和数据库表，可以使用 Ant 任务来执行此操作。如果您使用包含 **dba** 元素的 Ant 文件，那么 Ant 任务会在 DB2 缺省实例中创建数据库。此元素可以在名为 **create-database-<dbms>.xml** 的样本 Ant 文件中找到。

在运行 Ant 任务之前，请确保您在运行 DB2 数据库的计算机上具有 SSH 服务器。**configureDatabase** Ant 任务打开与 DB2 主机的 SSH 会话以创建数据库。即使 DB2 数据库在运行 Ant 任务的同一台计算机上运行（Linux 以及部分版本的 UNIX 系统除外），也需要 SSH 服务器。

根据[使用 Ant 任务创建数据库表](#create-the-database-tables-with-ant-tasks)中描述的一般准则来编辑 **create-database-db2.xml** 文件的副本。

您还必须在 **dba** 元素中为 DB2 用户的登录标识和密码提供管理权限（**SYSADM** 或 **SYSCTRL** 许可权）。在 DB2 样本 Ant 文件 (**create-database-db2.xml**) 中，要设置如下这些属性：**database.db2.admin.username** 和 **database.db2.admin.password**。

在调用 **databases** Ant 目标时，**configureDatabase** Ant 任务会使用以下 SQL 语句按照缺省设置来创建数据库：


```sql
CREATE DATABASE MFPDATA COLLATE USING SYSTEM PAGESIZE 32768
```

此设置并不适用于生产，因为在缺省 DB2 安装中，许多权限都是公开的。

### 使用 Ant 任务创建 Oracle 数据库表
{: #creating-the-oracle-database-tables-with-ant-tasks }
使用 {{ site.data.keys.mf_server }} 安装提供的 Ant 任务创建 Oracle 数据库表。

在 Ant 文件中输入 Oracle 用户名时，必须使用大写。如果您具有 Oracle 数据库用户 (FOO)，但输入小写的用户名 (foo)，那么 **configureDatabase** Ant 任务会将其视为另一个用户。与 Oracle 数据库的其他工具不同，**configureDatabase** Ant 任务会对用户名进行保护，以防止自动转换为大写。

**configureDatabase** Ant 任务使用服务名称或 Oracle 系统标识 (SID) 来标识数据库。但是，如果要连接到 Oracle RAC，需输入复杂的 JDBC URL。在此情况下，**configureDatabase** Ant 任务中的 **oracle** 元素必须使用特性 **url**、**user** 和 **password**，来代替特性 **database**、**server**、**port**、**user** 和 **password**。有关更多信息，请参阅 [Ant **configuredatabase** 任务参考](../installation-reference/#ant-configuredatabase-task-reference)中的表。**mfp\_install\_dir/MobileFirstServer/configurations-samples** 中的样本 Ant 文件在 **oracle** 元素中使用 **database**、**server**、**port**、**user** 和 **password** 特性。如果需要使用 JDBC URL 连接到 Oracle，必须修改这些特性。

要在已存在的数据库中创建数据库表，请参阅[使用 Ant 任务创建数据库表](#create-the-database-tables-with-ant-tasks)。

要创建数据库、用户或数据库表，请使用 Oracle Database Creation Assistant (DBCA) 工具。有关更多信息，请参阅 [Oracle 数据库和用户需求](#oracle-database-and-user-requirements)。


**configureDatabase** Ant 任务可以执行相同的任务但存在限制。该任务可以为 Oracle 11g 或 Oracle 12g 创建数据库用户。但是，它只能为 Oracle 11g 创建数据库，而不能为 Oracle 12c 创建数据库。请参阅以下两节以了解创建数据库或用户所需的额外步骤。

#### 创建数据库
{: #creating-the-database-1 }
根据[使用 Ant 任务创建数据库表](#create-the-database-tables-with-ant-tasks)中描述的一般准则来编辑 **create-database-oracle.xml** 文件的副本。

1. 在运行 Oracle 数据库的计算机上运行 SSH 服务器。

    **configureDatabase** Ant 任务打开与 Oracle 主机的 SSH 会话以创建数据库。除了 Linux 和部分版本的 UNIX 系统，即使 Oracle 数据库与 Ant 任务在相同计算机上运行，也需要 SSH 服务器。

2. 在 **create-database-oracle.xml** 文件中定义的 **dba** 元素中，输入可以通过 SSH 连接到 Oracle 服务器切有权创建数据库的 Oracle 数据库的登录标识和密码。您可以在以下属性中指定这些值：

    * **database.oracle.admin.username**
    * **database.oracle.admin.password**
3. 在 **oracle** 元素中，输入想要创建的数据库名称。对应特性是 **database**。您可以在 **database.oracle.mfp.dbname** 属性中指定值。
4. 在同一 **oracle** 元素中，还应为要创建的数据库输入 **SYS** 用户和 **SYSTEM** 用户的密码。对应特性是 **sysPassword** 和 **systemPassword**。
您可以在对应属性中指定这些值：

    * **database.oracle.sysPassword**
    * **database.oracle.systemPassword**
5. 在 Ant 文件中输入所有数据库凭证后，请保存并运行 **databases** Ant 目标。

这样将使用 **oracle** 元素的 database 中输入的 SID 名称创建数据库。这并不意味着可用于生产。

#### 创建用户
{: #creating-the-user-1 }
根据[使用 Ant 任务创建数据库表](#create-the-database-tables-with-ant-tasks)中描述的一般准则来编辑 **create-database-oracle.xml** 文件的副本。

1. 在运行 Oracle 数据库的计算机上运行 SSH 服务器。

    **configureDatabase** Ant 任务打开与 Oracle 主机的 SSH 会话以创建数据库。除了 Linux 和部分版本的 UNIX 系统，即使 Oracle 数据库与 Ant 任务在相同计算机上运行，也需要 SSH 服务器。

2. 在 **create-database-oracle.xml** 文件中定义的 oracle 元素中，输入想要创建的 Oracle 数据库用户的登录标识和密码。对应特性是 **user** 和 **password**。
您可以在对应属性中指定这些值：

    * database.oracle.mfp.username
    * database.oracle.mfp.password
3. 在同一个 **oracle** 元素中，同时输入数据库的 **SYSTEM** 用户的密码。对应特性是 **systemPassword**。您可以在 **database.oracle.systemPassword 属性**中指定值。
4. 在 **dba** 元素中，输入有权创建用户的 Oracle 数据库用户的登录标识和密码。您可以在以下属性中指定这些值：

    * **database.oracle.admin.username**
    * **database.oracle.admin.password**
5. 在 Ant 文件中输入所有数据库凭证后，请保存并运行 **databases** Ant 目标。

这样将使用 **oracle** 元素中输入的名称和密码创建数据库用户。此用户有权创建 {{ site.data.keys.mf_server }} 表、升级表以及在运行时使用表。

### 使用 Ant 任务创建 MySQL 数据库表
{: #creating-the-mysql-database-tables-with-ant-tasks }
使用 {{ site.data.keys.mf_server }} 安装随附的 Ant 任务创建 MySQL 数据库表。

要在已存在的数据库中创建数据库表，请参阅[使用 Ant 任务创建数据库表](#create-the-database-tables-with-ant-tasks)。

如果 MySQL 服务器无 [MySQL 数据库和用户需求](#mysql-database-and-user-requirements)中建议的设置，那么 **configureDatabase** Ant 任务会显示一条警告。运行 Ant 任务前，请确保满足需求。

要创建数据库和数据库表，请遵循[使用 Ant 任务创建数据库表](#create-the-database-tables-with-ant-tasks)中所述的一般准则来编辑 **create-database-mysql.xml** 文件副本。

以下过程提供了在使用 **configureDatabase** Ant 任务创建数据库表时需要完成的一些额外的步骤。

1. 在 **create-database-mysql.xml** 文件中定义的 **dba** 元素中，输入 MySQL 管理员的登录标识和密码。缺省情况下，管理员为 **root**。您可以在以下属性中指定这些值：

    * **database.mysql.admin.username**
    * **database.mysql.admin.password**
2. 在 **mysql** 元素中，为允许用户连接到数据库的每个主机添加 **client** 元素。也即，所有运行 {{ site.data.keys.mf_server }} 的主机。在 Ant 文件中输入所有数据库凭证后，请保存并运行 **databases** Ant 目标。
