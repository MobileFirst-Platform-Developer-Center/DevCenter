---
layout: tutorial
title: 以图形方式安装 MobileFirst Server 教程
weight: 0
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
使用 IBM Installation Manager 的图形方式和 Server Configuration Tool 来安装 {{ site.data.keys.mf_server }}。

#### 开始之前
{: #before-you-begin }
* 确保安装以下某个数据库和受支持的 Java 版本。计算机上还需要有对应的数据库 JDBC 驱动程序：
    * 来自受支持数据库列表的数据库管理系统 (DBMS)：
        * DB2 
        * MySQL
        * Oracle

        **要点：**您必须具有一个能够创建产品所需表的数据库以及可以在该数据库中创建表的数据库用户。

        在本教程中，用于创建表的步骤适用于 DB2。您可以在 [IBM Passport Advantage](http://www.ibm.com/software/passportadvantage/pao_customers.htm) 上查找作为 {{ site.data.keys.product }} eAssembly 软件包一部分的 DB2 安装程序。  
        
* 适用于您的数据库的 JDBC 驱动程序
    * 对于 DB2，使用 DB2 JDBC 驱动程序 4 类。
    * 对于 MySQL，使用 Connector/J JDBC 驱动程序。
    * 对于 Oracle，使用 Oracle 瘦 JDBC 驱动程序。

* Java 7 或更高版本。

* 从 [Installation Manager 和 Packaging Utility 下载链接](http://www.ibm.com/support/docview.wss?uid=swg27025142)下载 IBM Installation Manager V1.8.4 或更高版本的安装程序。
* 您还必须具有 {{ site.data.keys.mf_server }} 的安装库和 WebSphere Application Server Liberty Core V8.5.5.3 或更高版本的安装程序。请从 Passport Advantage 上的 {{ site.data.keys.product }} eAssembly 下载这些软件包：

**{{ site.data.keys.mf_server }} 安装库**  
Installation Manager Repository for {{ site.data.keys.mf_server }} 的 {{ site.data.keys.product }} V8.0 .zip 文件

**WebSphere Application Server Liberty Profile**  
IBM WebSphere Application Server - Liberty Core V8.5.5.3 或更高版本
    
如果您使用以下某种操作系统，可以图形方式运行安装：

* Windows x86 或 x86-64
* macOS x86-64
* Linux x86 或 Linux x86-64

在其他操作系统上，仍可以图形方式通过 Installation Manager 运行安装，但不能使用 Server Configuration Tool。您需要使用 Ant 任务（如[以命令行方式安装 {{ site.data.keys.mf_server }}](../command-line) 中所述）将 {{ site.data.keys.mf_server }} 部署到 Liberty 概要文件。

**注：**用于安装和设置数据库的指示信息不包含在本教程中。如果想要运行本教程而不安装独立数据库，可以使用嵌入式 Derby 数据库。但是，使用此数据库存在如下限制：


* 您可以图形方式运行 Installation Manager，但要部署服务器，需要跳过本教程中使用 Ant 任务进行安装的命令行部分。
* 不能配置服务器场。嵌入式 Derby 数据库不支持从多个服务器进行访问。要配置服务器场，需要 DB2、MySQL 或 Oracle。

#### 跳转至
{: #jump-to }

* [安装 IBM Installation Manager](#installing-ibm-installation-manager)
* [安装 WebSphere Application Server Liberty Core](#installing-websphere-application-server-liberty-core)
* [安装 {{ site.data.keys.mf_server }}](#installing-mobilefirst-server)
* [创建数据库](#creating-a-database)
* [运行 Server Configuration Tool](#running-the-server-configuration-tool)
* [测试安装](#testing-the-installation)
* [创建由两台运行 {{ site.data.keys.mf_server }} 的 Liberty 服务器组成的场](#creating-a-farm-of-two-liberty-servers-that-run-mobilefirst-server)
* [测试场，并在 {{ site.data.keys.mf_console }} 中查看更改](#testing-the-farm-and-see-the-changes-in-mobilefirst-operations-console)

### 安装 IBM Installation Manager
{: #installing-ibm-installation-manager }
必须安装 Installation Manager V1.8.4 或更高版本。更低版本的 Installation Manager 不能安装 {{ site.data.keys.product }} V8.0，因为产品后安装操作需要 Java 7。更低版本的 Installation Manager 随附 Java 6。

1. 解压缩下载的 IBM Installation Manager 归档。您可以在 [Installation Manager 和 Packaging Utility 下载链接](http://www.ibm.com/support/docview.wss?uid=swg27025142)找到安装程序。
2. 安装 Installation Manager：
    * 以管理员身份运行 **install.exe** 以安装 Installation Manager。在 Linux 或 UNIX 上，需要 root 用户身份。在 Windows 上，需要管理员权限。在此方式下，有关已安装的程序包的信息放置在磁盘上的共享位置，允许运行 Installation Manager 的任何用户都可更新应用程序。
    * 运行 **userinst.exe** 以在用户方式下安装 Installation Manager。无需特殊权限。但是在此方式下，有关已安装的程序包的信息放置在用户主目录下。仅限此用户才能更新使用 Installation Manager 安装的应用程序。

### 安装 WebSphere Application Server Liberty Core
{: #installing-websphere-application-server-liberty-core }
WebSphere Application Server Liberty Core 的安装程序是作为 {{ site.data.keys.product }} 软件包的一部分提供的。在此任务中，将安装 Liberty 概要文件并创建服务器实例，以便您可以在其中安装 {{ site.data.keys.mf_server }}。

1. 解压缩您下载的 WebSphere Application Server Liberty Core 压缩文件。
2. 启动 Installation Manager。
3. 在 Installation Manager 中添加存储库。
    * 转至**“文件 → 首选项”，然后单击“添加存储库...”**。
    * 在安装程序的解压缩目录中浏览 **diskTag.inf** 文件的 **repository.config** 文件。
    * 选择该文件，然后单击**确定**。
    * 单击**确定**以关闭“首选项”面板。
4. 单击**安装**以安装 Liberty。
    * 选择 **IBM WebSphere Application Server Liberty Core** 并单击**下一步**。
    * 接受许可协议中的所有条款，然后单击**下一步**。
5. 在本教程的范围中，在系统询问时无需安装额外资产。单击**安装**以启动安装过程。
    * 如果安装成功，程序将显示一条消息，指示安装成功。程序也可能显示重要的安装后指示信息。
    * 如果安装不成功，请单击**查看日志文件**以对问题进行故障诊断。
6. 将包含服务器的 **usr** 目录移至无需特定权限的位置。

    如果以管理员方式使用 Installation Manager 安装 Liberty，那么文件位于非管理员或非 root 用户无法修改文件的位置中。在本教程的范围内，将包含服务器的 **usr** 目录移至无需特定权限的位置。由此可在无需特定权限的情况下完成安装操作。
    * 请跳至 Liberty 的安装目录。
    * 创建名为 **etc** 的目录。这需要管理员权限或 root 用户权限。
    * 在 **etc** 目录中，使用以下内容创建 **server.env** 文件：`WLP_USER_DIR=<任何用户都可以写入的目录的路径>`
    
    例如，在 Windows 上：`WLP_USER_DIR=C:\LibertyServers\usr`
7. 创建 Liberty 服务器，在本教程后半部分，此服务器将用于安装 {{ site.data.keys.mf_server }} 的首个节点。
    * 启动命令行。
    * 转至 **liberty\_install\_dir/bin**，然后输入 `server create mfp1`。
    
    此命令会创建名为 mfp1 的 Liberty 服务器实例。您可以在 **liberty\_install\_dir/usr/servers/mfp1** 或 **WLP\_USER\_DIR/servers/mfp1**（如果按步骤 6 中所述修改了目录）中查看其定义。
    
创建服务器后，可以从 **liberty\_install\_dir/bin/** 使用 `server start mfp1` 启动此服务器。要停止服务器，请从 **liberty\_install\_dir/bin/** 输入命令：`server stop mfp1`。  
可在 http://localhost:9080 查看缺省主页。

> **注：**对于生产环境，需要确保启动主计算机时，Liberty 服务器作为服务启动。本教程中不涉及将 Liberty 服务器作为服务启动的内容。
### 安装 {{ site.data.keys.mf_server }}
{: #installing-mobilefirst-server }
运行 Installation Manager 以在磁盘上安装 {{ site.data.keys.mf_server }} 的二进制文件，然后再创建数据库并将 {{ site.data.keys.mf_server }} 部署至 Liberty 概要文件。在使用 Installation Manager 安装 {{ site.data.keys.mf_server }} 期间，会建议您安装 {{ site.data.keys.mf_app_center }}。
Application Center 是产品的另一个组件。在本教程中，不需要随着 {{ site.data.keys.mf_server }} 一起安装该组件。

1. 启动 Installation Manager。
2. 在 Installation Manager 中添加 {{ site.data.keys.mf_server }} 的存储库。
    * 转至**“文件 → 首选项”，然后单击“添加存储库...”**。
    * 在安装程序的解压缩目录中浏览存储库文件。

        如果将 {{ site.data.keys.mf_server }} 的 {{ site.data.keys.product }} V8.0 .zip 文件解压缩到 **mfp\_installer\_directory** 文件夹中，那么存储库文件位于 **mfp\_installer\_directory/MobileFirst\_Platform\_Server/disk1/diskTag.inf**。

        您还可能想应用可从 [IBM 支持门户网站](http://www.ibm.com/support/entry/portal/product/other_software/ibm_mobilefirst_platform_foundation)下载的最新修订包。确保输入修订包的存储库。如果将修订包解压缩到 **fixpack_directory** 文件夹，那么可以在 **fixpack_directory/MobileFirst_Platform_Server/disk1/diskTag.inf** 中找到存储库文件。
    
        > **注：**如果 Installation Manager 存储库中没有基本版本的存储库，那么无法安装修订包。修订包是累积安装程序，需要安装基本版本的存储库。
	    * 选择该文件，然后单击**确定**。
    * 单击**确定**以关闭“首选项”面板。

3. 在您接受产品的许可条款之后，单击**下一步**。
4. 选择**创建新软件包组**选项以将产品安装到该新软件包组中。
5. 单击**下一步**。
6. 在**常规设置**面板的**激活令牌许可**部分中，针对 **Rational License Key Server** 选项选择**不激活令牌许可**。

    在本教程中，假定不需要令牌许可，并且不包含为令牌许可配置 {{ site.data.keys.mf_server }} 的步骤。但对于生产安装，您必须确定是否需要激活令牌许可。如果您的某个合同要通过 Rational License Key Server 使用令牌许可，请选择使用 Rational License Key Server 激活令牌许可选项。在激活令牌许可之后，必须执行额外的步骤来配置 {{ site.data.keys.mf_server }}。
    7. 保持**常规设置**面板的“安装 **{{ site.data.keys.product }} for iOS**”部分中的缺省选项（否）不变。
8. 在**选择配置**面板中选择“否”选项，这样便不会安装 Application Center。对于生产安装，请使用 Ant 任务来安装 Application Center。使用 Ant 任务进行安装使您能够将 {{ site.data.keys.mf_server }} 的更新与 Application Center 的更新区分开来。
9. 单击**下一步**直到达到**谢谢您**面板。
然后，继续进行安装。

安装一个安装目录，其中包含用于安装 {{ site.data.keys.product_adj }} 组件的资源。  
您可以在以下文件夹中找到资源：

* MobileFirstServer 文件夹（针对 {{ site.data.keys.mf_server }}）
* PushService 文件夹（针对 {{ site.data.keys.mf_server }} 推送服务）
* ApplicationCenter 文件夹（针对 Application Center）
* Analytics 文件夹（针对 {{ site.data.keys.mf_analytics }}）

本教程的目的是通过使用 **MobileFirstServer** 文件夹中的资源来安装 {{ site.data.keys.mf_server }}。  
您还可以在 **shortcuts** 文件夹中找到 Server Configuration Tool、Ant 和 mfpadm 程序的一些快捷方式。

### 创建数据库
{: #creating-a-database }
此任务旨在确保您的 DBMS 中存在数据库并且允许用户使用此数据库、在其中创建表并使用这些表。  
此数据库用于存储供各种 {{ site.data.keys.product_adj }} 组件使用的技术数据：

* {{ site.data.keys.mf_server }} 管理服务
* {{ site.data.keys.mf_server }} 实时更新服务
* {{ site.data.keys.mf_server }} 推送服务
* {{ site.data.keys.product_adj }} 运行时

在本教程中，所有组件的表都置于相同模式下。Server Configuration Tool 在同一模式中创建表。要获得更大的灵活性，您可能想要使用 Ant 任务或手动安装。

> **注：**此任务中的步骤适合于 DB2。如果您计划使用 MySQL 或 Oracle，请参阅[数据库需求](../../databases/#database-requirements)。
1. 登录至正在运行 DB2 服务器的计算机。假定存在 DB2 用户，例如名为 **mfpuser** 的用户。
2. 验证此 DB2 用户是否具有对页面大小不小于 32768 的数据库的访问权，并且允许此用户在该数据库中创建隐式模式和表。

    缺省情况下，此用户是运行 DB2 的计算机的操作系统上声明的用户。即，具有此计算机的登录权限的用户。如果存在此类用户，那么无需执行步骤 3 中的下一个操作。在本教程的后面，Server Configuration Tool 将在该数据库的某个模式下创建产品所需的所有表。

3. 如果没有数据库，请使用针对此安装的正确页面大小创建一个数据库。
    * 使用具有 `SYSADM` 或 `SYSCTRL` 权限的用户身份打开一个会话。例如，使用属于由 DB2 安装程序创建的缺省管理用户的用户 **db2inst1**。
    * 打开 DB2 命令行处理器：
        * 在 Windows 系统中，单击**开始 → IBM DB2 → 命令行处理器**。
        * 在 Linux 或 UNIX 系统上，转至 **~/sqllib/bin**（或 **db2\_install\_dir/bin**，前提是 **sqllib** 不是在管理员主目录中创建的）并输入 `./db2`。
        * 输入以下 SQL 语句以创建一个称为 **MFPDATA** 的数据库：
        
        ```sql
        CREATE DATABASE MFPDATA COLLATE USING SYSTEM PAGESIZE 32768
        CONNECT TO MFPDATA
        GRANT CONNECT ON DATABASE TO USER mfpuser
        GRANT CREATETAB ON DATABASE TO USER mfpuser
        GRANT IMPLICIT_SCHEMA ON DATABASE TO USER mfpuser
        DISCONNECT MFPDATA
        QUIT
        ```
        
如果定义了其他用户名，请将 mfpuser 替换为您自己的用户名。  

> **注：**此语句不会除去授予缺省 DB2 数据库中的 PUBLIC 的缺省权限。对于生产环境，可能需要将此数据库中的权限降低至针对该产品的最低需求。有关 DB2 安全性和安全实践示例的更多信息，请参阅 [DB2 安全第 8 部分：12 项 DB2 安全最佳实践](http://www.ibm.com/developerworks/data/library/techarticle/dm-0607wasserman/)。
### 运行 Server Configuration Tool
{: #running-the-server-configuration-tool }
使用 Server Configuration Tool 来运行以下操作：

* 在数据库中创建 {{ site.data.keys.product_adj }} 应用程序所需的表
* 将 {{ site.data.keys.mf_server }} 的 Web 应用程序（运行时、管理服务、实时更新服务、推送服务组件和 {{ site.data.keys.mf_console }}）部署至 Liberty 服务器。

Server Configuration Tool 不会部署以下 {{ site.data.keys.product_adj }} 应用程序：

#### {{ site.data.keys.mf_analytics }}
{: #mobilefirst-analytics }
{{ site.data.keys.mf_analytics }}
由于内存需求较高，因此通常与 {{ site.data.keys.mf_server }} 部署在不同的服务器集上。{{ site.data.keys.mf_analytics }} 可手动安装或通过 Ant 任务来安装。如果已安装，可以在 Server Configuration Tool 中输入其 URL、用户名和密码来将数据发送到其中。然后，Server Configuration Tool 会将 {{ site.data.keys.product_adj }} 应用配置为向 {{ site.data.keys.mf_analytics }} 发送数据。 

#### Application Center
{: #application-center }
此应用程序可用于在内部向使用移动应用程序的员工分发这些应用程序，或者用于测试。它独立于 {{ site.data.keys.mf_server }}，并且无需与 {{ site.data.keys.mf_server }} 一起安装。
    
1. 启动 Server Configuration Tool。
    * 在 Linux 上，通过**应用程序快捷方式“应用程序 → {{ site.data.keys.mf_server }} → Server Configuration Tool**。
    * 在 Windows 上，单击**开始 → 程序 → IBM MobileFirst Platform Server → Server Configuration Tool**。
    * 在 macOS 上，打开 shell 控制台。转至 **mfp_server\_install\_dir/shortcuts，并输入 ./configuration-tool.sh**。
    
    mfp_server_install_dir 是 {{ site.data.keys.mf_server }} 的安装目录。
2. 选择**文件 → 新建配置...**以创建 {{ site.data.keys.mf_server }} 配置。
3. 将此配置命名为“Hello MobileFirst”，然后单击**确定**。
4. 保持配置详细信息缺省条目不变，然后单击**下一步**。
    
    在本教程中，不使用环境标识。这是用于高级部署方案的功能。  
    此类方案的一个示例是在同一个应用程序服务器或 WebSphere Application Server 单元中安装多个 {{ site.data.keys.mf_server }} 和管理服务实例。
5. 保持管理服务和运行时组件的缺省上下文根。
6. 不要更改**控制台设置**面板中的缺省条目，然后单击**下一步**以使用缺省上下文根安装 {{ site.data.keys.mf_console }}。
7. 选择 **IBM DB2** 作为数据库，然后单击**下一步**。
8. 在 **DB2 数据库设置**面板中，填写详细信息：
    * 输入运行 DB2 服务器的主机名。如果是在您的计算机上运行，可以输入 **localhost**。
    * 如果计划使用的 DB2 实例未在侦听缺省端口 (50000)，请更改端口号。
    * 输入 DB2 JDBC 驱动程序的路径。对于 DB2，预期文件名为 **db2jcc4.jar**。同一目录中还需要存在 **db2jcc\_license\_cu.jar** 文件。在标准 DB2 分发版中，可在 **db2\_install\_dir/java** 中找到这些文件。
    * 单击**下一步**。

    如果无法使用输入的凭证访问 DB2 服务器，那么 Server Configuration Tool 会禁用**下一步**按钮并显示错误。如果 JDBC 驱动程序不包含预期类，也会禁用**下一步**按钮。如果所有信息正确，**下一步**按钮会呈启用状态。
    
9. 在 **DB2 额外设置**面板中，填写详细信息：
    * 输入 **mfpuser** 作为 DB2 用户名并输入其密码。如果不是 **mfpuser**，请输入您自己的 DB2 用户名。
    * 输入 **MFPDATA** 作为数据库的名称。
    * 保留 **MFPDATA** 作为将在其中创建表的模式。单击**下一步**。缺省情况下，Server Configuration Tool 建议使用值 **MFPDATA**。
10. 不要在**数据库创建请求**面板中输入任何值，然后单击**下一步**。

    当先前窗格中输入的数据库不存在于 DB2 服务器时使用此窗格。在此情况下，您可以输入 DB2 管理员的用户名和密码。Server Configuration Tool 会打开与 DB2 服务器的 SSH 会话，并按照[创建数据库](#creating-a-database)所述运行命令以使用缺省设置和正确的页面大小来创建数据库。
11. 在**应用程序服务器选择**面板中，选择 **WebSphere Application Server** 选项并单击**下一步**。
12. 在**应用程序服务器设置**面板中，填写详细信息：
    * 输入 WebSphere Application Server Liberty 的安装目录。
    * 在“服务器名称”字段中，选择计划安装产品的服务器。选择在[安装 WebSphere Application Server Liberty Core](#installing-websphere-application-server-liberty-core) 的步骤 7 中创建的 **mfp1** 服务器。
    * 保持**创建用户**选项选中缺省值。
    
    此选项会在 Liberty 服务器的基本注册表中创建用户，以便您可以登录 {{ site.data.keys.mf_console }} 或管理服务。对于生产安装，请勿使用此选项，而是按“配置 {{ site.data.keys.mf_server }} 管理的用户认证”所述在安装后配置应用程序的安全角色。
    * 对于部署类型，选择服务器场部署选项。
    * 单击**下一步**。
13. 选择**安装推送服务**选项。

    当安装推送服务时，需要从管理服务到推送服务以及从管理服务和推送服务到运行时组件的 HTTP 或 HTTPS 流。
    14. 选择**自动计算推送和授权服务 URL** 选项。

    选择此选项时，Server Configuration Tool 会将应用程序配置为连接到同一服务器上安装的应用程序。当您使用聚类时，输入用于从 HTTP 负载均衡器连接到服务的 URL。
在 WebSphere Application Server Network Deployment 上进行安装时，需要手动输入 URL。
15. 保持**用于管理和推送服务之间的安全通信的凭证**缺省条目不变。

    需要客户机标识和密码将推送服务和管理服务注册为授权服务器（缺省情况下为运行时组件）的机密 OAuth 客户机。Server Configuration Tool 为每个服务生成一个标识和随机密码，在本入门教程中，可以保持原值不变。
16. 单击**下一步**。
17. 保持**分析设置**面板的缺省条目不变。

    要启用与分析服务器的连接，首先需要安装 {{ site.data.keys.mf_analytics }}。
但是，此安装不包含在本教程中。
18. 单击**部署**。

您可以在**控制台窗口**中看到已完成操作的详细信息。  
Ant 文件已保存。Server Configuration Tool 帮助您创建用于安装和更新配置的 Ant 文件。此 Ant 文件可以使用**文件 → 将配置导出为 Ant 文件...**进行导出。有关此 Ant 文件的更多信息，请参阅“[以命令行方式](../command-line)安装 {{ site.data.keys.mf_server }}”中的“使用 Ant 任务将 {{ site.data.keys.mf_server }} 部署到 Liberty”。

然后，此 Ant 文件将运行并执行以下操作：

1. 在数据中创建以下组件的表：
    * 管理服务和实时更新服务。由 **admdatabases** Ant 目标创建。
    * 运行时。由 **rtmdatabases** Ant 目标创建。
    * 推送服务。由 pushdatabases Ant 目标创建。
2. 各种组件的 WAR 文件均部署至 Liberty 服务器。您可以在 **adminstall**、**rtminstall** 和 **pushinstall** 目标下的日志中查看操作的详细信息。

如果您有权访问 DB2 服务器，可以使用以下指示信息列出创建的表：

1. 使用 mfpuser 打开 DB2 命令行处理器，如“创建数据库”的步骤 3 中所述。
2. 输入 SQL 语句：

```sql
CONNECT TO MFPDATA USER mfpuser USING mfpuser_password
LIST TABLES FOR SCHEMA MFPDATA
DISCONNECT MFPDATA
QUIT
```

记录以下数据库因素：

#### 数据库用户注意事项
{: #database-user-consideration }
在 Server Configuration Tool 中，只需一个数据库用户。此用户用于创建表，但是也用作为运行时的应用程序服务器中的数据源用户。在生产环境中，您可以将运行时使用的用户权限严格限制为最低限度的权限 (`SELECT / INSERT / DELETE / UPDATE)`，并提供其他用户用于在应用程序服务器中进行部署。作为示例提供的 Ant 文件针对这两种情况使用相同用户。但对于 DB2，您可能希望创建自己版本的文件。由此您可以通过 Ant 任务区分用于创建数据库的用户与用于应用程序服务器中数据源的用户。

#### 数据库表创建
{: #database-tables-creation }
对于生产环境，您可能希望手动创建表。例如，如果您的 DBA 要覆盖某些缺省设置或者分配特定表空间。在 **mfp\_server\_install\_dir/MobileFirstServer/databases** 和 **mfp_server\_install\_dir/PushService/databases** 中提供了用于创建表的数据库脚本。有关更多信息，请参阅[手动创建数据库表](../../databases/#create-the-database-tables-manually)。

在安装期间修改了 **server.xml** 文件和部分应用程序服务器设置。在每次修改之前，会生成 **server.xml** 文件的副本，例如，**server.xml.bak**、**server.xml.bak1** 和 **server.xml.bak2**。要查看已添加的所有内容，可以将 **server.xml** 文件与最旧的备份 (server.xml.bak) 进行比较。在 Linux 上，可以使用命令 diff `--strip-trailing-cr server.xml server.xml.bak` 来查看区别。在 AIX 上，使用命令 `diff server.xml server.xml.bak` 来查看区别。

#### 应用程序服务器设置的修改（特定于 Liberty）：
{: #modification-of-the-application-server-settings-specific-to-liberty }
1. Liberty 功能已添加。

    针对每个应用程序已添加了这些功能，并且这些功能可以复制。例如，JDBC 功能可用于管理服务和运行时组件。这种复制可以在卸载某个应用程序时移除这些功能而不破坏其他应用程序。例如，如果您决定在某个时候要从服务器卸载推送服务，并将其安装在另一台服务器上。但并非所有拓扑都可用。管理服务、实时更新服务和运行时组件必须与 Liberty 概要文件位于同一台应用程序服务器上。有关更多信息，请参阅[对 {{ site.data.keys.mf_server }} 管理服务、{{ site.data.keys.mf_server }} 实时更新服务和 {{ site.data.keys.product_adj }} 运行时的约束](../../topologies/#constraints-on-mobilefirst-server-administration-service-mobilefirst-server-live-update-service-and-mobilefirst-foundation-runtime)。除非添加的功能存在冲突，否则功能复制不会造成问题。添加 jdbc-40 和 jdbc-41 功能会导致问题，但是将同一个功能添加两次不会造成问题。
    
2. 在 `httpEndPoint` 声明中添加 `host='*'`。

    此设置旨在允许从所有网络接口连接至服务器。在生产环境中，您可能希望限制 HTTP 端点的主机值。
    3. 在服务器配置中添加 **tcpOptions** 元素 (**tcpOptions soReuseAddr="true"**) 以启用与无活动侦听器的端口的即时重新绑定，并改进服务器的吞吐量。
4. 如果不存在标识为 **defaultKeyStore** 的密钥库，那么会创建此密钥库。

    此密钥库旨在启用 HTTPS 端口，更具体而言，旨在启用管理服务 (mfp-admin-service.war) 与运行时组件 (mfp-server.war) 之间的 JMX 通信。这两个应用程序通过 JMX 进行通信。对于 Liberty 概要文件，restConnector 用于单一服务器中这两个应用程序之间的通信，也用于 Liberty 场中服务器之间的通信。它需要使用 HTTPS。对于缺省情况下创建的密钥库，Liberty 概要文件会创建一个证书，其有效期为 365 天。此配置不适用于生产用途。对于生产环境，您需要重新考虑使用自己的证书。    

    为启用 JMX，在基本注册表中会创建一个具有管理员角色的用户（名为 MfpRESTUser）。其名称和密码作为 JNDI 属性（mfp.admin.jmx.user 和 mfp.admin.jmx.pwd）提供，供运行时组件和管理服务用于运行 JMX 查询。在全局 JMX 属性中，某些属性用于定义集群方式（独立服务器或在场中工作）。Server Configuration Tool 在 Liberty 服务器中将 mfp.topology.clustermode 属性设置为 Standalone。在本教程后半部分有关创建场的内容中，该属性修改为 Cluster。
    5. 创建用户（对 Apache Tomcat 和 WebSphere Application Server 同样有效）
    * 可选用户：Server Configuration Tool 会创建一名测试用户 (admin/admin) 以便您在安装后使用此用户登录控制台。
    * 必需用户：Server Configuration Tool 还会创建一名用户（名为 configUser_mfpadmin，使用随机生成的密码）供管理服务用于联系本地实时更新服务。对于 Liberty 服务器，会创建 MfpRESTUser。如果您的应用程序服务器没有配置为使用基本注册表（例如，LDAP 注册表），那么 Server Configuration Tool 将无法请求现有用户的名称。在此情况下，您需要使用 Ant 任务。
6. **webContainer** 元素已修改。

    `deferServletLoad` Web 容器定制属性设置为 false。启动服务器时，必须启动运行时组件和管理服务。这些组件由此可注册 JMX Bean，并启动同步过程，以允许运行时组件下载需要维护的所有应用程序和适配器。
    7. 如果您使用的是 Liberty V8.5.5.5 或更早版本，缺省执行程序需要进行定制，以将 `coreThreads` 和 `maxThreads` 设置为较大的值。从 V8.5.5.6 开始，缺省执行程序由 Liberty 自动调整。

    此设置避免了破坏某些 Liberty 版本上的运行时组件和管理服务的启动顺序的超时问题。在服务器日志文件中，缺少此语句可能导致出现以下错误：
    
    > Failed to obtain JMX connection to access an MBean. There might be a JMX configuration error: Read timed out 
FWLSE3000E: A server error was detected. 
    > FWLSE3012E: JMX configuration error. Unable to obtain MBeans. Reason: "Read timed out".

#### 应用程序声明
{: #declaration-of-applications }
以下应用程序已安装：

* **mfpadmin**，管理服务
* **mfpadminconfig**，实时更新服务
* **mfpconsole**，{{ site.data.keys.mf_console }}
* **mobilefirst**，{{ site.data.keys.product_adj }} 运行时组件
* **imfpush**，推送服务

Server Configuration Tool 在同一服务器上安装所有应用程序。您可以在不同应用程序服务器中分隔这些应用程序，但必须遵循[拓扑和网络流](../../topologies)中所述的某些约束。  
要在不同服务器上进行安装，不能使用 Server Configuration Tool。请使用 Ant 任务或手动安装产品。

#### 管理服务
{: #administration-service }
管理服务是用于管理 {{ site.data.keys.product_adj }} 应用程序、适配器及其配置的服务。它受到安全角色的保护。缺省情况下，Server Configuration Tool 会添加具有管理员角色的用户 (admin)，您可使用此用户登录控制台进行测试。必须在使用 Server Configuration Tool（或使用 Ant 任务）安装后才能进行安全角色的配置。您可以将来自基本注册表或您在自己的应用程序服务器中配置的 LDAP 注册表的用户或组映射到每个安全角色。

类装入器是以 Liberty 概要文件和 WebSphere Application Server 授权父代最后来设置，适用于所有 {{ site.data.keys.product_adj }} 应用程序。此设置可避免 {{ site.data.keys.product_adj }} 应用程序中打包的类与应用程序服务器的类之间的冲突。忘记将类装入器授权设置为父代最后会导致手动安装频繁出错。对于 Apache Tomcat，无需此声明。

在 Liberty 概要文件中，在应用程序中添加公共库用于解密作为 JNDI 属性传递的密码。Server Configuration Tool 为管理服务定义了两个必需 JNDI 属性：**mfp.config.service.user** 和 **mfp.config.service.password**。管理服务使用这些属性来通过其 REST API 连接至实时更新服务。可定义更多 JNDI 属性以微调应用程序或者根据安装特殊需求对其进行调整。有关更多信息，请参阅 [{{ site.data.keys.mf_server }}管理服务的 JNDI 属性列表](../../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service)。

Server Configuration Tool 还定义 JNDI 属性（用于注册机密客户机的 URL 和 OAuth 参数）以用于与推送服务进行通信。  
包含管理服务表的数据库的数据源及其 JDBC 驱动程序库均已声明。

#### 实时更新服务
{: #live-update-service }
实时更新服务用于存储有关运行时和应用程序配置的信息。它受到管理服务的控制，并且必须始终与管理服务在同一台服务器上运行。上下文根为 **context\_root\_of\_admin\_serverconfig**。因此，其上下文根为 **mfpadminconfig**。管理服务假定遵循此约定来创建管理服务对实施更新服务的 REST 服务的请求的 URL。

类装入器是使用管理服务部分中讨论的授权父代最后设置的。

实时更新服务具有一个安全角色：**admin_config**。必须将一个用户映射到该角色。必须使用 JNDI 属性 **mfp.config.service.user** 和 **mfp.config.service.password** 将其密码和登录名提供给管理服务。有关 JNDI 属性的信息，请参阅 [{{ site.data.keys.mf_server }}管理服务的 JNDI 属性列表](../../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service)和 [{{ site.data.keys.mf_server }}实时更新服务的 JNDI 属性列表](../../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-live-update-service)。

它还需要具有 Liberty 概要文件上的 JNDI 名称的数据源。约定为 **context\_root\_of\_config\_server/jdbc/ConfigDS**。在此教程中，此数据源定义为 **mfpadminconfig/jdbc/ConfigDS**。在使用 Server Configuration Tool 或 Ant 任务进行的安装中，实时更新服务表与管理服务表位于相同的数据库和模式中。访问这些表的用户也相同。

#### {{ site.data.keys.mf_console }}
{: #mobilefirst-operations-console }
使用与管理服务相同的安全角色声明 {{ site.data.keys.mf_console }}。映射至 {{ site.data.keys.mf_console }} 的安全角色的用户还必须映射到管理服务的相同安全角色。实际上，{{ site.data.keys.mf_console }} 代表控制台用户运行到管理服务的查询。

Server Configuration Tool 提供了一个 JNDI 属性 **mfp.admin.endpoint**，用于指示控制台连接到管理服务的方式。Server Configuration Tool 设置的缺省值为 `*://*:*/mfpadmin`。此设置意味着必须使用与控制台的入局 HTTP 请求相同的协议、主机名和端口，并且管理服务的上下文根为 /mfpadmin。如果要强制通过 Web 代理发送请求，请更改缺省值。有关此 URL 的可能值的更多信息或者有关其他可能的 JNDI 属性的信息，请参阅 [{{ site.data.keys.mf_server }}管理服务的 JNDI 属性列表](../../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service)。

类装入器是使用管理服务部分中讨论的授权父代最后设置的。

#### {{ site.data.keys.product_adj }} 运行时
{: #mobilefirst-runtime }
此应用程序不受安全角色的保护。使用对 Liberty 服务器已知的用户登录以访问此应用程序时无需安全角色。移动设备请求将路由至运行时。这些请求由特定于产品的其他机制（例如，OAuth）和 {{ site.data.keys.product_adj }} 应用程序的配置来进行认证。

类装入器是使用管理服务部分中讨论的授权父代最后设置的。

它还需要具有 Liberty 概要文件上的 JNDI 名称的数据源。约定为 **context\_root\_of\_runtime/jdbc/mfpDS**。在此教程中，此数据源定义为 **mobilefirst/jdbc/mfpDS**。在使用 Server Configuration Tool 或 Ant 任务进行的安装中，运行时表与管理服务表位于相同的数据库和模式中。访问这些表的用户也相同。

#### 推送服务
{: #push-service }
此应用程序受 OAuth 保护。在发送到此服务的任何 HTTP 请求中必须包含有效的 OAuth 令牌。

通过 JNDI 属性（例如，授权服务器的 URL、客户机标识和推送服务的密码）来进行 OAuth 的配置。JNDI 属性还指示使用安全性插件 (**mfp.push.services.ext.security**) 和关系数据库 (**mfp.push.db.type**)。从移动设备到推送服务的请求将路由至此服务。推送服务的上下文根必须为 /imfpush。客户机 SDK 基于上下文根为 (**/imfpush**) 的运行时 URL 来计算推送服务的 URL。如果要将推送服务与运行时安装在不同服务器上，需要可将设备请求路由至相关应用程序服务器的 HTTP 路由器。

类装入器是使用管理服务部分中讨论的授权父代最后设置的。

它还需要具有 Liberty 概要文件上的 JNDI 名称的数据源。JNDI 名称为 **imfpush/jdbc/imfPushDS**。在使用 Server Configuration Tool 或 Ant 任务进行的安装中，推送服务表与管理服务表位于相同的数据库和模式中。访问这些表的用户也相同。

#### 其他文件修改
{: #other-files-modification }
Liberty Profile jvm.options 文件已修改。定义了一个属性 (com.ibm.ws.jmx.connector.client.rest.readTimeout) 以避免运行时与管理服务同步时 JMX 出现超时问题。

### 测试安装
{: #testing-the-installation }
安装完成后，可以使用此过程来测试安装的组件。

1. 使用命令 **server start mfp1** 启动服务器。服务器的二进制文件位于 **liberty\_install\_dir/bin** 中。
2. 使用 Web 浏览器测试 {{ site.data.keys.mf_console }}。转至 [http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole)。缺省情况下，服务器在端口 9080 上运行。但是，您可以在元素 `<httpEndpoint>` 中按 **server.xml** 文件中的定义验证此端口。这样会显示一个登录屏幕。

![控制台的登录屏幕](mfpconsole_signin.jpg)

3. 使用 **admin/admin** 登录。缺省情况下，该用户由 Server Configuration Tool 创建。

    > **注：**如果使用 HTTP 连接，将在网络中以明文发送登录标识和密码。要进行安全登录，请使用 HTTPS 来登录服务器。可以在 **server.xml** 文件的 `<httpEndpoint>` 元素的 httpsPort 属性中查看 Liberty 服务器的 HTTPS 端口。缺省情况下，该值为 9443。
    4. 使用**欢迎管理员 → 注销**来从控制台注销。
5. 在 Web 浏览器中输入以下 URL：[https://localhost:9443/mfpconsole](https://localhost:9443/mfpconsole)，并接受证书。缺省情况下，Liberty 服务器会生成对 Web 浏览器未知的缺省证书，您需要接受此证书。Mozilla Firefox 将此证书显示为安全性异常。
6. 使用 **admin/admin** 再次登录。在 Web 浏览器与 {{ site.data.keys.mf_server }} 之间会对登录和密码加密。对于生产环境，可以关闭 HTTP 端口。

### 创建由两台运行 {{ site.data.keys.mf_server }} 的 Liberty 服务器组成的场
{: #creating-a-farm-of-two-liberty-servers-that-run-mobilefirst-server }
在此任务中，您将创建第二台 Liberty 服务器，此服务器与第一台运行相同的 {{ site.data.keys.mf_server }} 并连接到相同的数据库。在生产环境中，您可以使用多台服务器来提升性能，在高峰时间使用足够的服务器来应对移动应用程序所需的每秒事务数。也可以因此实现高可用性，从而避免单一故障点。

有多台服务器运行 {{ site.data.keys.mf_server }} 时，必须将这些服务器配置为一个场。此配置使任何管理服务都能够联系场的所有运行时。如果集群未配置为场，那么将仅发送有关在运行管理操作的管理服务所在的应用程序服务器中运行的运行时的通知。其他运行时不知晓更改。例如，在未配置为场的集群中部署新版本的适配器时，只有一台服务器用于维护新适配器。其他服务器将继续维护旧适配器。仅限在 WebSphere Application Server Network Deployment 上安装服务器时才可拥有集群且无需配置场。管理服务可以通过 Deployment Manager 查询 JMX Bean 来查找所有服务器。Deployment Manager 必须处于运行状态才能允许执行管理操作，因为它用于提供单元的 {{ site.data.keys.product_adj }} JMX Bean 列表。

创建场时，还需要配置 HTTP Server，以将查询发送到场的所有成员。HTTP Server 的配置不包含在本教程范围内。本教程仅提供有关配置场以将管理操作复制到集群所有运行时组件的信息。

1. 在同一台计算机上创建第二台 Liberty 服务器。
    * 启动命令行。
    * 转至 **liberty\_install\_dir/bin**，并输入 **server create mfp2**。
2. 修改服务器 mfp2 的 HTTP 和 HTTPS 端口，以避免与服务器 mfp1 的端口出现冲突。
    * 转到第二台服务器的目录。目录为 **liberty\_install\_dir/usr/servers/mfp2** 或 **WLP\_USER\_DIR/servers/mfp2**（如果按照[安装 WebSphere Application Server Liberty Core](#installing-websphere-application-server-liberty-core) 的步骤 6 中所述修改目录）。
    * 编辑 **server.xml** 文件。
将



    ```xml
    <httpEndpoint id="defaultHttpEndpoint"
    httpPort="9080"
    httpsPort="9443" />
    ```
    
    替换为：
    
    ```xml
    <httpEndpoint id="defaultHttpEndpoint"
    httpPort="9081"
    httpsPort="9444" />
    ```
    
    通过此更改，服务器 mfp2 的 HTTP 和 HTTPS 端口将不会与服务器 mfp1 的端口出现冲突。在运行 {{ site.data.keys.mf_server }} 的安装之前，请确保修改这些端口。
否则，如果在安装之后修改端口，那么还需要在 JNDI 属性 **mfp.admin.jmx.port** 中反映端口更改。
    
3. 运行 Server Configuration Tool。
    *  创建配置 **Hello MobileFirst 2**。
    * 按照[运行 Server Configuration Tool](#running-the-server-configuration-tool) 所述执行相同的安装过程，但选择 **mfp2** 作为应用程序服务器。使用相同的数据库和相同的模式。

    > **注：**  
    > 
    > * 如果服务器 mfp1 有环境标识（在本教程中不建议使用），那么必须将同一环境标识用于服务器 mfp2。
    > * 如果修改了某些应用程序的上下文根，那么将相同的上下文根用于服务器 mfp2。一个场的服务器必须是对称的。
    > * 如果创建了缺省用户 (admin/admin)，请在服务器 mfp2 中创建相同的用户。

    Ant 任务会检测数据库是否存在，并且不会创建表（请参阅以下日志摘要）。然后会将应用程序部署到服务器。
    
    ```xml
    [configuredatabase] Checking connectivity to MobileFirstAdmin database MFPDATA with schema 'MFPDATA' and user 'mfpuser'...
    [configuredatabase] Database MFPDATA exists.
[configuredatabase] Connection to MobileFirstAdmin database MFPDATA with schema 'MFPDATA' and user 'mfpuser' succeeded.
[configuredatabase] Getting the version of MobileFirstAdmin database MFPDATA...
[configuredatabase] Table MFPADMIN_VERSION exists, checking its value...
[configuredatabase] GetSQLQueryResult => MFPADMIN_VERSION = 8.0.0
    [configuredatabase] Configuring MobileFirstAdmin database MFPDATA...
    [configuredatabase] The database is in latest version (8.0.0), no upgrade required.
[configuredatabase] Configuration of MobileFirstAdmin database MFPDATA succeeded.
```
    
4. 使用 HTTP 连接测试两台服务器。
    * 打开 Web 浏览器。

    * 输入以下 URL：[http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole)。此控制台由服务器 mfp1 维护。
    * 使用 **admin/admin** 登录。
    * 在相同 Web 浏览器中打开选项卡并输入 URL：[http://localhost:9081/mfpconsole](http://localhost:9081/mfpconsole)。此控制台由服务器 mfp2 维护。
    * 使用 admin/admin 登录。如果正确完成安装，登录后在两个选项卡中会显示相同的欢迎页面。
    * 返回至第一个浏览器选项卡，并单击**欢迎管理员 → 下载审计日志**。您将从控制台注销，并再次显示登录屏幕。此注销行为是一个问题。发生此问题的原因是当您登录服务器 mfp2 时，会在您的浏览器中创建轻量级第三方认证 (LTPA) 令牌并将其存储为 cookie。但服务器 mfp1 未识别此 LTPA 令牌。当 HTTP 负载均衡器位于集群之前时，可能会在生产环境中发生切换服务器的情况。要解决此问题，您必须确保两台服务器（mfp1 和 mfp2）都使用相同的密钥生成 LTPA 令牌。将 LTPA 密钥从服务器 mfp1 复制到服务器 mfp2。
    * 使用以下命令停止这两台服务器：
    
        ```bash
        server stop mfp1
        server stop mfp2
        ```
    * 将服务器 mfp1 的 LTPA 密钥复制到服务器 mfp2。在 **liberty\_install\_dir/usr/servers** 或 **WLP\_USER\_DIR/servers** 中，根据操作系统运行以下命令。 
        * 在 UNIX 上：`cp mfp1/resources/security/ltpa.keys mfp2/resources/security/ltpa.keys`
        * 在 Windows 上：`copy mfp1/resources/security/ltpa.keys mfp2/resources/security/ltpa.keys`
    * 重新启动服务器。这样从某一个浏览器选项卡切换至另一个浏览器选项卡时即可无需重新登录。在 Liberty 服务器场中，所有服务器必须具有相同的 LTPA 密钥。
5. 在 Liberty 服务器之间启用 JMX 通信。

    JMX 与 Liberty 的通信是通过使用 HTTPS 协议的 Liberty REST 接口完成的。要启用此通信，场的每个服务器都必须能识别其他成员的 SSL 证书。您需要在服务器信任库中交换 HTTPS 证书。使用 **java/bin** 中的 IBM 实用程序（例如，属于 IBM JRE 分发版的 Keytool）来配置信任库。在 **server.xml** 文件中定义了密钥库和信任库的位置。缺省情况下，Liberty Profile 的密钥库位于 **WLP\_USER\_DIR/servers/server\_name/resources/security/key.jks** 中。此缺省密钥库的密码（显示在 **server.xml** 文件中）为 **mobilefirst**。
    
    > **提示：**您可以使用 Keytool 实用程序来更改此密码，但必须同时更改 server.xml 文件中的密码，以便此 Liberty 服务器可以读取此密钥库。在本教程中，使用缺省密码。
        * 在 **WLP\_USER\_DIR/servers/mfp1/resources/security** 中，输入 `keytool -list -keystore key.jks`。此命令会显示密钥库中的证书。只有一个名为 **default** 的证书。系统会在提示您输入密钥库的密码 (mobilefirst)，然后您才能看到密钥。对于使用 Keytool 实用程序的所有后续命令都是如此。
    * 使用以下命令导出服务器 mfp1 的缺省证书：`keytool -exportcert
-keystore key.jks -alias default -file mfp1.cert`。
        * 在 **WLP\_USER\_DIR/servers/mfp2/resources/security** 中，使用以下命令导出服务器 mfp2 的缺省证书：`keytool -exportcert -keystore key.jks -alias default -file mfp2.cert`。
    * 在同一个目录中，使用以下命令导入服务器 mfp1 的证书：`keytool -import -file ../../../mfp1/resources/security/mfp1.cert -keystore key.jks`。服务器 mfp1 的证书会导入服务器 mfp2 的米密钥库，以使服务器 mfp2 能够信任到服务器 mfp1 的 HTTPS 连接。系统会要求您确认您信任此证书。
    * 在 **WLP_USER_DIR/servers/mfp1/resources/security** 中，使用以下命令导入服务器 mfp2 的证书：`keytool -import -file ../../../mfp2/resources/security/mfp2.cert -keystore key.jks`。执行此步骤后，即可在两台服务器之间建立 HTTPS 连接。

## 测试场，并在 {{ site.data.keys.mf_console }} 中查看更改
{: #testing-the-farm-and-see-the-changes-in-mobilefirst-operations-console }

1. 启动两台服务器：

    ```bash
    server start mfp1
    server start mfp2
    ```
    
2. 访问控制台。例如，[http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole) 或 [https://localhost:9443/mfpconsole](https://localhost:9443/mfpconsole)（在 HTTPS 中）。在左侧侧边栏中，会显示一个额外菜单，此菜单标记为**服务器场节点**。如果您单击**服务器场节点**，您可以看到每个节点的状态。您可能需要等待一段时间以便两个节点都完成启动。
    
    
