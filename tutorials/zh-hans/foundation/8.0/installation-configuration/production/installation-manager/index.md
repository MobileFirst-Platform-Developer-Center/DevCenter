---
layout: tutorial
title: 运行 IBM Installation Manager
weight: 7
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
IBM Installation Manager 在计算机上安装 {{ site.data.keys.mf_server_full }} 文件和工具。

可运行 Installation Manager 来安装 {{ site.data.keys.mf_server }} 和工具的二进制文件，以将 {{ site.data.keys.mf_server }} 应用程序部署到您的计算机上的应用程序服务器中。 [{{ site.data.keys.mf_server }} 的分布结构](#distribution-structure-of-mobilefirst-server)中描述了安装程序安装的文件和工具。

您需要 IBM Installation Manager V1.8.4 或更高版本来运行 {{ site.data.keys.mf_server }} 安装程序。 可以图形方式或命令行方式运行该程序。  
安装过程中将对两种主要选项提出建议：

* 激活令牌许可
* 安装和部署 {{ site.data.keys.mf_app_center }}

### 令牌许可
{: #token-licensing }
令牌许可是 {{ site.data.keys.mf_server }} 支持的两种许可方法之一。 您必须确定是否需要激活令牌许可。 如果您没有定义将令牌许可用于 Rational License
Key Server 的合同，那么请不要激活令牌许可。 如果激活令牌许可，那么必须针对令牌许可配置 {{ site.data.keys.mf_server }}。 有关更多信息，请参阅[针对令牌许可进行安装和配置](../token-licensing)。

### {{ site.data.keys.mf_app_center_full }}
{: #ibm-mobilefirst-foundation-application-center }
Application Center 是 {{ site.data.keys.product }} 的组件。 利用 Application Center，您可以在单个移动应用程序存储库中共享组织内正在开发的移动应用程序。

如果选择使用 Installation Manager 安装 Application Center，那么必须提供数据库和应用程序服务器参数，以便 Installation Manager 能够配置数据库并将 Application Center 部署到应用程序服务器上。 如果选择不使用 Installation Manager 安装 Application Center，那么 Installation Manager 会将 WAR 文件以及 Application Center 的资源保存到磁盘上。 它既不会设置数据库，也不会将 Application Center WAR 文件部署到应用程序服务器上。 可以稍后使用 Ant 任务或手动完成此操作。 用于安装 Application Center 的这一选项是发现 Application Center 的一种简便方式，因为安装过程中图形安装向导会为您提供指导。

但是，对于生产安装，请使用 Ant 任务来安装 Application Center。 使用 Ant 任务进行安装使您能够将 {{ site.data.keys.mf_server }} 的更新与 Application Center 的更新区分开来。

* 使用 Installation Manager 安装 Application Center 的优势。
    * 指导性图形向导会帮助您完成安装和部署过程。
* 使用 Installation Manager 安装 Application Center 的劣势。
    * 如果在 UNIX 或 Linux 上使用 root 用户运行 Installation Manager，那么可能会创建由部署 Application Center 的应用程序服务器的目录中的根目录所拥有的文件。 因此，您必须作为 root 用户运行应用程序服务器。
    * 您无权访问数据库脚本，也无法向数据库管理员提供此脚本以在运行安装过程前创建表。 Installation Manager 可使用缺省设置为您创建数据库表。
    * 每次升级产品时（例如，要安装临时修订），都首先会升级 Application Center。 升级 Application Center 包括在数据库和应用程序服务器上进行操作。 如果 Application Center 升级失败，那么将阻止 Installation Manager 完成升级，并阻止您升级其他 {{ site.data.keys.mf_server }} 组件。 对于生产安装，请不要使用 Installation Manager 部署 Application Center。 在 Installation Manager 安装 {{ site.data.keys.mf_server }} 后，请单独使用 Ant 任务来安装 Application Center。 有关 Application Center 的更多信息，请参阅[安装和配置 Application Center](../../../appcenter)。

> **要点：**{{ site.data.keys.mf_server }} 安装程序仅将 {{ site.data.keys.mf_server }} 二进制文件和工具安装在磁盘上。 它不会将 {{ site.data.keys.mf_server }} 应用程序部署到应用程序服务器上。 使用 Installation Manager 运行安装后，必须设置数据库并将 {{ site.data.keys.mf_server }} 应用程序部署到应用程序服务器上。  
>类似地，运行 Installation Manager 以更新现有安装时，将仅更新磁盘上的文件。 需执行更多操作以更新部署到应用程序服务器的应用程序。

#### 跳转至
{: #jump-to }
* [管理员与用户方式](#administrator-versus-user-mode)
* [使用 IBM Installation Manager 安装向导进行安装](#installing-by-using-ibm-installation-manager-install-wizard)
* [在命令行中运行 IBM Installation Manager 来安装](#installing-by-running-ibm-installation-manager-in-command-line)
* [使用 XML 响应文件进行安装 - 静默安装](#installing-by-using-xml-response-files---silent-installation)
* [{{ site.data.keys.mf_server }} 的分布结构](#distribution-structure-of-mobilefirst-server)

## 管理员与用户方式
{: #administrator-versus-user-mode }
可以通过两种不同的 IBM Installation Manager 方式来安装 {{ site.data.keys.mf_server }}。 方式取决于 IBM Installation Manager 自身的安装方式。 方式可决定您用于 Installation Manager 和软件包的目录和命令。

{{ site.data.keys.product }} 支持以下两种 Installation Manager 方式：

* 管理员方式
* 用户（非管理员）方式

产品不支持 Linux 或 UNIX 上可用的组方式。

### 管理员方式
{: #administrator-mode }
在管理员方式下，必须作为 root 用户在 Linux 或 UNIX 下运行 Installation Manager，在 Windows 下必须使用管理员权限来运行。 系统目录中安装有 Installation Manager 的存储库文件（即安装的软件及其版本的列表）。 /var/ibm（Linux 或 UNIX）或 ProgramData（Windows 上）。 如果以管理员方式运行 Installation Manager，请不要使用 Installation Manager 部署 Application Center。

### 用户（非管理员）方式
{: #user-nonadministrator-mode }
在用户方式下，不具有特定权限的任何用户均可运行 Installation Manager。 但是，Installation Manager 的存储库文件存储在用户主目录中。 只有该用户能够升级产品安装。
如果未作为 root 用户运行 Installation Manager，请确保您在升级产品安装过程或应用临时修订后提供用户帐户。

有关 Installation Manager 方式的更多信息，请参阅 IBM Installation
Manager 文档中的 [Installing as an administrator, nonadministrator, or group](http://www.ibm.com/support/knowledgecenter/SSDV2W_1.8.4/com.ibm.silentinstall12.doc/topics/r_admin_nonadmin.html?lang=en&view=kc)。

## 使用 IBM Installation Manager 安装向导进行安装
{: #installing-by-using-ibm-installation-manager-install-wizard }
遵循安装 {{ site.data.keys.mf_server }} 的资源和工具（例如，Server Configuration Tool、Ant 和 mfpadm 程序）的过程中的步骤。  
安装向导的以下两个窗格中的决策为必填：

* **常规设置**面板。
* **选择配置**面板，用于安装 Application Center。

1. 启动 Installation Manager。
2. 在 Installation Manager 中添加 {{ site.data.keys.mf_server }} 的存储库。
    * 转至**文件 → 首选项**，然后单击**添加存储库...**。
    * 在安装程序的解压缩目录中浏览存储库文件。

        如果将 {{ site.data.keys.mf_server }} 的 {{ site.data.keys.product }} V8.0 .zip 文件解压缩到 **mfp\_installer\_directory** 文件夹中，那么存储库文件位于 **mfp\_installer\_directory/MobileFirst\_Platform\_Server/disk1/diskTag.inf**。

        您可能还想应用可从 [IBM 支持门户网站](http://www.ibm.com/support/entry/portal/product/other_software/ibm_mobilefirst_platform_foundation)下载的最新修订包。 确保输入修订包的存储库。 如果将修订包解压缩到 **fixpack_directory** 文件夹，那么可以在 **fixpack\_directory/MobileFirst\_Platform\_Server/disk1/diskTag.inf** 中找到存储库文件。

        **注：**如果 Installation Manager 存储库中没有基本版本的存储库，那么无法安装修订包。 修订包是累积安装程序，需要安装基本版本的存储库。
    * 选择该文件，然后单击**确定**。
    * 单击**确定**以关闭**首选项**面板。
3. 在您接受产品的许可条款之后，单击**下一步**。
4. 选择软件包组以安装产品。

    {{ site.data.keys.product }} V8.0 取代具有不同安装名称的先前发行版：
    * Worklight (V5.0.6)
    * IBM Worklight（V6.0 至 V6.3）

    如果计算机上安装了上述某个较旧版本的产品，Installation Manager 在开始安装流程时将允许您选择使用现有软件包组。 此选项会卸载产品的较旧版本，然后复用较旧安装选项来升级 {{ site.data.keys.mf_app_center_full }}（如果先前已安装）。

    要进行独立安装，请选择创建新软件包组选项，以便您可以并行于较旧版本来安装新版本。  
    如果未在计算机上安装任何其他版本的产品，那么选择创建新软件包组选项以在新软件包组中安装产品。

5. 单击**下一步**。
6. 在**常规设置**面板的**激活令牌许可**部分中决定是否激活令牌许可。

    如果您的某个合同要通过 Rational License Key Server 使用令牌许可，请选择**使用 Rational License Key Server 激活令牌许可**选项。 在激活令牌许可之后，必须执行额外的步骤来配置 {{ site.data.keys.mf_server }}。 否则，请选择**不使用 Rational License Key Server 激活令牌许可**选项以继续。
7. 保持**常规设置**面板的**安装 {{ site.data.keys.product }} for iOS** 部分中的缺省选项（否）不变。
8. 在**选择配置**面板中决定是否安装 Application Center。

    对于生产安装，请使用 Ant 任务来安装 Application Center。 使用 Ant 任务进行安装使您能够将 {{ site.data.keys.mf_server }} 的更新与 Application Center 的更新区分开来。 在此情况下，在“选择配置”面板中选择“否”选项，这样便不会安装 Application Center。

    如果选择“是”，需要完成后续窗格以输入计划使用的数据库以及计划部署 Application Center 的应用程序服务器的详细信息。 还需要有可用的数据库 JDBC 驱动程序。
9. 单击**下一步**直到达到**谢谢您**面板。 然后，继续进行安装。

安装一个安装目录，其中包含用于安装 {{ site.data.keys.product_adj }} 组件的资源。

您可以在以下文件夹中找到资源：

* **MobileFirstServer**文件夹（针对 {{ site.data.keys.mf_server }}）
* **PushService** 文件夹（针对 {{ site.data.keys.mf_server }} 推送服务）
* **ApplicationCenter** 文件夹（针对 Application Center）
* **Analytics** 文件夹（针对 {{ site.data.keys.mf_analytics }}）

您还可以在 **shortcuts** 文件夹中找到 Server Configuration Tool、Ant 和 mfpadm 程序的一些快捷方式。

## 在命令行中运行 IBM Installation Manager 来安装
{: #installing-by-running-ibm-installation-manager-in-command-line }

1. 查看 {{ site.data.keys.mf_server }} 的许可协议。 可以在从 Passport Advantage 下载安装库时查看许可文件。
2. 将下载的 {{ site.data.keys.mf_server }} 存储库的压缩文件解压缩至某个文件夹中。

    您可以从 [IBM Passport Advantage](http://www.ibm.com/software/passportadvantage/pao_customers.htm) 上的 {{ site.data.keys.product }} eAssembly 下载存储库。 包名称为 **IBM MobileFirst Platform Server 的 Installation Manager 存储库的 IBM MobileFirst Foundation V{{ site.data.keys.product_V_R }} .zip 文件**。

    在后续步骤中，解压缩安装程序的目录称为 **mfp\_repository\_dir**。 其中包含 **MobileFirst\_Platform\_Server/disk1** 文件夹。
3. 启动命令行，并转至 **installation\_manager\_install\_dir/tools/eclipse/**。

    如果在步骤 1 中查看许可协议后表示接受，即可安装 {{ site.data.keys.mf_server }}。
    * 对于未强制令牌许可的安装（如果您不具备定义令牌使用许可的合同），请输入以下命令：

      ```bash
      imcl install com.ibm.mobilefirst.foundation.server -repositories mfp_repository_dir/MobileFirst_Platform_Server/disk1 -properties user.appserver.selection2=none,user.database.selection2=none,user.database.preinstalled=false,user.licensed.by.tokens=false,user.use.ios.edition=false -acceptLicense
      ```
    * 对于强制令牌许可的安装，请输入以下命令：

      ```bash
      imcl install com.ibm.mobilefirst.foundation.server -repositories mfp_repository_dir/MobileFirst_Platform_Server/disk1 -properties user.appserver.selection2=none,user.database.selection2=none,user.database.preinstalled=false,user.licensed.by.tokens=true,user.use.ios.edition=false -acceptLicense
      ```

        **user.licensed.by.tokens** 属性值设置为 **true**。 您必须为[令牌许可](../token-licensing)配置 {{ site.data.keys.mf_server }}。

        将设置以下属性，以在无 Application Center 的情况下安装 {{ site.data.keys.mf_server }}：
        * **user.appserver.selection2**=none
        * **user.database.selection2**=none
        * **user.database.preinstalled**=false

        此属性指示是否激活令牌许可：**user.licensed.by.tokens=true/false**。

        将 user.use.ios.edition 属性的值设置为 false 以安装 {{ site.data.keys.product }}。

5. 如果要使用最新的临时修订进行安装，请在 **-repositories** 参数中添加临时修订存储库。 **-repositories** 参数用于提取存储库的逗号分隔列表。

    通过将 **com.ibm.mobilefirst.foundation.server** 替换为 **com.ibm.mobilefirst.foundation.server_version**，来添加临时修订版本。 **version** 的格式为 **8.0.0.0-buildNumber**。 例如，如果要安装临时修订 **8.0.0.0-IF201601031015**，请输入以下命令：`imcl install com.ibm.mobilefirst.foundation.server_8.0.0.00-201601031015 -repositories...`。

    有关 imcl 命令的更多信息，请参阅 [Installation Manager：使用 `imcl` 命令安装软件包](https://www.ibm.com/support/knowledgecenter/SSDV2W_1.8.4/com.ibm.cic.commandline.doc/topics/t_imcl_install.html?lang=en)。

安装一个安装目录，其中包含用于安装 {{ site.data.keys.product_adj }} 组件的资源。

您可以在以下文件夹中找到资源：

* **MobileFirstServer**文件夹（针对 {{ site.data.keys.mf_server }}）
* **PushService** 文件夹（针对 {{ site.data.keys.mf_server }} 推送服务）
* **ApplicationCenter** 文件夹（针对 Application Center）
* **Analytics** 文件夹（针对 {{ site.data.keys.mf_analytics }}）    

您还可以在 **shortcuts** 文件夹中找到 Server Configuration Tool、Ant 和 mfpadm 程序的一些快捷方式。

## 使用 XML 响应文件进行安装 - 静默安装
{: #installing-by-using-xml-response-files---silent-installation }
如果要在命令行中使用 IBM Installation Manager 安装 {{ site.data.keys.mf_app_center_full }}，需要提供较大的自变量列表。 在此情况下，可以使用 XML 响应文件提供这些自变量。

静默安装由称为响应文件的 XML 文件定义。 该文件包含静默完成安装操作的必要数据。 静默安装从命令行或批处理文件启动。

您可在用户界面方式下使用 Installation Manager 为响应文件记录首选项和安装操作。 或者，您可使用记录的响应文件命令和首选项的列表，手动创建响应文件。

Installation Manager 用户文档中描述了静默安装，请参阅[使用静默方式](http://ibm.biz/knowctr#SSDV2W_1.8.4/com.ibm.silentinstall12.doc/topics/t_silentinstall_overview.html)。

可以通过两种方式创建合适的响应文件：

* 使用 {{ site.data.keys.product_adj }} 用户文档中提供的样本响应文件。
* 使用不同计算机上记录的响应文件。

后续部分中对这两种方法都进行了介绍。

### 使用用于 IBM Installation Manager 的样本响应文件
{: #working-with-sample-response-files-for-ibm-installation-manager }
**Silent\_Install\_Sample_Files.zip** 压缩文件中包含 IBM Installation Manager 的样本响应文件。 以下过程介绍了如何使用这些文件。

1. 从压缩文件中选取适用的样本响应文件。 Silent_Install_Sample_Files.zip 文件对于每个发行版都包含一个子目录。

    > **要点：**  
    >
    > * 对于不在应用程序服务器上安装 Application Center 的安装，请使用名为 **install-no-appcenter.xml** 的文件。
    > * 对于要安装 Application Center 的安装，请根据应用程序服务器和数据库从下表中选取样本响应文件。

   #### **Silent\_Install\_Sample_Files.zip** 文件中用于安装 Application Center 的样本安装响应文件

    <table>
        <tr>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
            <th>安装 Application Center 的应用程序服务器</th>
            <th>Derby</th>
            <th>IBM DB2 </th>
            <th>MySQL</th>
            <th>Oracle</th>
        </tr>
        <tr>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
            <td>WebSphere  Application Server Liberty Profile</td>
            <td>install-liberty-derby.xml</td>
            <td>install-liberty-db2.xml</td>
            <td>install-liberty-mysql.xml（请参阅注释）</td>
            <td>install-liberty-oracle.xml</td>
        </tr>
        <tr>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
            <td>WebSphere Application Server Full Profile（独立服务器）</td>
            <td>install-was-derby.xml</td>
            <td>install-was-db2.xml</td>
            <td>install-was-mysql.xml（请参阅注释）</td>
            <td>install-was-oracle.xml</td>
        </tr>
        <tr>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
            <td>WebSphere Application Server Network Deployment</td>
            <td>不适用</td>
            <td>install-wasnd-cluster-db2.xml、install-wasnd-server-db2.xml、install-wasnd-node-db2.xml 和 install-wasnd-cell-db2.xml</td>
            <td>install-wasnd-cluster-mysql.xml（请参阅注释）、install-wasnd-server-mysql.xml（请参阅注释）、install-wasnd-node-mysql.xml 和 install-wasnd-cell-mysql.xml（请参阅注释）</td>
            <td>install-wasnd-cluster-oracle.xml、install-wasnd-server-oracle.xml、install-wasnd-node-oracle.xml 和 install-wasnd-cell-oracle.xml</td>
        </tr>
        <tr>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
            <td>Apache Tomcat</td>
            <td>install-tomcat-derby.xml</td>
            <td>install-tomcat-db2.xml</td>
            <td>install-tomcat-mysql.xml</td>
            <td>install-tomcat-oracle.xml</td>
        </tr>
    </table>

    > **注释：**MySQL 与 WebSphere Application Server Liberty profile 或 WebSphere Application Server Full Profile 的组合不属于受支持的配置。 有关更多信息，请参阅 [WebSphere Application Server 支持声明](http://www.ibm.com/support/docview.wss?uid=swg27004311)。 您可以使用 IBM DB2 或其他受 WebSphere Application Server 支持的 DBMS，以受益于配置可获得 IBM 支持中心的全面支持。

    对于卸载，使用的样本文件取决于在特定软件包组中最初安装的 {{ site.data.keys.mf_server }} 或 Worklight Server 的版本：

    * {{ site.data.keys.mf_server }} 使用软件包组 {{ site.data.keys.mf_server }}。
    * Worklight Server V6.x 或更高版本使用软件包组 IBM Worklight。
    * Worklight Server V5.x 使用软件包组 Worklight。

    <table>
        <tr>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
            <th>{{ site.data.keys.mf_server }} 的初始版本</th>
            <th>样本文件</th>
        </tr>
        <tr>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
            <td>Worklight Server V5.x</td>
            <td>uninstall-initially-worklightv5.xml</td>
        </tr>
        <tr>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
            <td>Worklight Server V6.x</td>
            <td>uninstall-initially-worklightv6.xml</td>
        </tr>
        <tr>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
            <td>IBM MobileFirst Server V6.x 或更高版本</td>
            <td>uninstall-initially-mfpserver.xml</td>
        </tr>
    </table>

2. 更改样本文件的文件访问权限，尽可能提高其限制性。 步骤 4 将会要求您提供一些密码。 如果要防止同一台电脑上的其他用户获取这些密码，必须除去其他用户对文件的读许可权。 您可以使用命令，如以下示例：
    * 在 UNIX 上：`chmod 600 <target-file.xml>`
    * 在 Windows 上：`cacls <target-file.xml> /P Administrators:F %USERDOMAIN%\%USERNAME%:F`
3. 同样，如果服务器是 WebSphere Application Server Liberty Profile 或 Apache Tomcat 服务器，并且打算只通过您的用户帐户启动该服务器，那么还必须除去除您之外的其他用户对以下文件“读”许可权：
    * 对于 WebSphere Application Server Liberty Profile：`wlp/usr/servers/<server>/server.xml`
    * 对于 Apache Tomcat：`conf/server.xml`
4. 使用 <server> 元素来调整存储库列表。 有关此步骤的更多信息，请参阅[存储库](http://ibm.biz/knowctr#SSDV2W_1.8.4/com.ibm.silentinstall12.doc/topics/r_repository_types.html)中的 IBM Installation Manager 文档。

    使用 `<profile>` 元素来调整每个键/值对的值。  
    在 `<install>` 元素的 `<offering>` 元素中，设置版本属性，使其与要安装的发行版匹配；但是如果要在存储库中安装可用的最新版本，请除去版本属性。
5. 输入以下命令：`<InstallationManagerPath>/eclipse/tools/imcl input <responseFile>  -log /tmp/installwl.log -acceptLicense`

    其中：
    * `<InstallationManagerPath>` 是 IBM Installation Manager 的安装目录。
    * `<responseFile>` 是在步骤 1 中选择并更新的文件的名称。

> 有关更多信息，请参阅[使用响应文件静默安装软件包](http://ibm.biz/knowctr#SSDV2W_1.8.4/com.ibm.silentinstall12.doc/topics/t_silent_response_file_install.html)中的 IBM Installation Manager 文档。


### 处理在不同机器上记录的响应文件
{: #working-with-a-response-file-recorded-on-a-different-machine }

1. 在可以使用 GUI 的机器上，以向导方式运行 IBM Installation
Manager 并使用 `-record responseFile` 选项，以记录响应文件。 有关更多详细信息，请参阅[使用 Installation Manager 记录响应文件](http://ibm.biz/knowctr#SSDV2W_1.7.0/com.ibm.silentinstall12.doc/topics/t_silent_create_response_files_IM.html)。
2. 更改响应文件的文件访问权，使其限制性尽可能高。 步骤 4 将会要求您提供一些密码。 如果要防止同一台电脑上的其他用户获取这些密码，必须取消其他用户对文件的 **read** 权限。 您可以使用命令，如以下示例：
    * 在 UNIX 上：`chmod 600 response-file.xml`
    * 在 Windows 上：`cacls response-file.xml /P Administrators:F %USERDOMAIN%\%USERNAME%:F`
3. 同样，如果服务器是 WebSphere Application Server Liberty 或 Apache Tomcat 服务器，并且打算只通过您的用户帐户启动该服务器，那么还必须除去除您之外的其他用户对以下文件“读”许可权：
    * 对于 WebSphere Application Server Liberty：`wlp/usr/servers/<server>/server.xml`
    * 对于 Apache Tomcat：`conf/server.xml`
4. 修改响应文件以考虑到包含创建响应文件的机器与目标机器之间的差别。
5. 使用目标机器上的响应文件安装 {{ site.data.keys.mf_server }}，如 [使用响应文件静默安装软件包](http://ibm.biz/knowctr#SSDV2W_1.7.0/com.ibm.silentinstall12.doc/topics/t_silent_response_file_install.html)中所述。

### 命令行（静默安装）参数
{: #command-line-silent-installation-parameters }
<table style="word-break:break-all">
    <tr>
        <th>键</th>
        <th>何时必要</th>
        <th>描述</th>
        <th>允许的值</th>
    </tr>
    <tr>
        <td>user.use.ios.edition</td>
        <td>总是</td>
        <td>如果计划安装 {{ site.data.keys.product }}，那么将值设置为 <code>false</code>。 如果计划为 iOS 版本安装产品，那么必须将值设置为 <code>true</code>。</td>
        <td><code>true</code> 或 <code>false</code></td>
    </tr>
    <tr>
        <td>user.licensed.by.tokens</td>
        <td>总是</td>
        <td>激活令牌许可。 如果您计划将此产品与 Rational License
Key Server 一起使用，那么必须激活令牌许可。<br/><br/>在此情况下，将值设置为 <code>true</code>。 如果不计划将此产品与 Rational License Key Server 一起使用，那么将值设置为 <code>false</code>。<br/><br/>如果您激活许可令牌，那么在将产品部署到应用程序服务器后将需要执行特定的配置步骤。 </td>
        <td><code>true</code> 或 <code>false</code></td>    
    </tr>
    <tr>
        <td>user.appserver.selection2</td>
        <td>总是</td>
        <td>应用程序服务器的类型。 was 表示预安装的 WebSphere  Application Server 8.5.5。 tomcat 表示 Tomcat 7.0。</td>
        <td></td>
    </tr>
    <tr>
        <td>user.appserver.was.installdir</td>
        <td>${user.appserver.selection2} == was</td>
        <td>WebSphere Application Server 安装目录。</td>
        <td>一个绝对目录名称。</td>
    </tr>
    <tr>
        <td>user.appserver.was.profile</td>
        <td>${user.appserver.selection2} == was</td>
        <td>要在其中安装应用程序的概要文件。 对于 WebSphere Application Server Network Deployment，请指定 Deployment Manager 概要文件。 Liberty 表示 Liberty 概要文件（子目录 wlp）。</td>
        <td>某个 WebSphere Application Server 概要文件的名称。</td>
    </tr>
    <tr>
        <td>user.appserver.was.cell</td>
        <td>${user.appserver.selection2} == was &&
${user.appserver.was.profile} != Liberty</td>
        <td>要在其中安装应用程序的 WebSphere Application Server 单元。</td>
        <td>WebSphere Application Server 单元的名称。</td>
    </tr>
    <tr>
        <td>user.appserver.was.node</td>
        <td>${user.appserver.selection2} == was &&
${user.appserver.was.profile} != Liberty</td>
        <td>要在其中安装应用程序的 WebSphere Application Server 节点。 这对应于当前机器。</td>
        <td>当前机器的 WebSphere Application Server 节点的名称。</td>
    </tr>
    <tr>
        <td>user.appserver.was.scope</td>
        <td>${user.appserver.selection2} == was &&
${user.appserver.was.profile} != Liberty</td>
        <td>要在其中安装应用程序的服务器集合的类型。<br/><br/><code>server</code> 表示独立服务器。<br/><br/><code>nd-cell</code> 表示 WebSphere Application Server Network Deployment 单元。 <code>nd-cluster</code> 表示 WebSphere Application Server Network Deployment 集群。<br/><br/><code>nd-node</code> 表示 WebSphere Application Server Network Deployment 节点（排除集群）。<br/><br/><code>nd-server</code> 表示受管 WebSphere Application Server Network Deployment 服务器。</td>
        <td><code>server</code>、<code>nd-cell</code>、<code>nd-cluster</code>、<code>nd-node</code> 和 <code>nd-server</code></td>
    </tr>
    <tr>
      <td>user.appserver.was.serverInstance</td>
      <td>${user.appserver.selection2} == was &&
${user.appserver.was.profile} != Liberty && ${user.appserver.was.scope}
== server</td>
      <td>要在其中安装应用程序的 WebSphere Application Server 服务器的名称。</td>
      <td>当前机器上的 WebSphere Application Server 服务器的名称。</td>
    </tr>
    <tr>
      <td>user.appserver.was.nd.cluster</td>
      <td>${user.appserver.selection2} == was &&
${user.appserver.was.profile} != Liberty && ${user.appserver.was.scope}
== nd-cluster</td>
      <td>要在其中安装应用程序的 WebSphere Application Server Network Deployment 集群的名称。</td>
      <td>WebSphere Application Server 单元中 WebSphere Application Server Network Deployment 集群的名称。</td>
    </tr>
    <tr>
      <td>user.appserver.was.nd.node</td>
      <td>${user.appserver.selection2} == was &&
${user.appserver.was.profile} != Liberty && (${user.appserver.was.scope}
== nd-node || ${user.appserver.was.scope} == nd-server)</td>
      <td>要在其中安装应用程序的 WebSphere Application Server Network Deployment 节点的名称。</td>
      <td>WebSphere Application Server 单元中 WebSphere Application Server Network Deployment 节点的名称。</td>
    </tr>
    <tr>
      <td>user.appserver.was.nd.server</td>
      <td>${user.appserver.selection2} == was &&
${user.appserver.was.profile} != Liberty && ${user.appserver.was.scope}
== nd-server</td>
      <td>要在其中安装应用程序的 WebSphere Application Server Network Deployment 服务器的名称。</td>
      <td>指定的 WebSphere Application Server Network Deployment 节点中 WebSphere Application Server Network Deployment 服务器的名称。</td>
    </tr>
    <tr>
      <td>user.appserver.was.admin.name</td>
      <td>${user.appserver.selection2} == was &&
${user.appserver.was.profile} != Liberty</td>
      <td>WebSphere Application Server 管理员的名称。</td>
      <td></td>
    </tr>
    <tr>
      <td>user.appserver.was.admin.password2</td>
      <td>${user.appserver.selection2} == was &&
${user.appserver.was.profile} != Liberty</td>
      <td>WebSphere Application Server 管理员的密码（可以选择以特定方式加密）。</td>
      <td></td>
    </tr>
    <tr>
      <td>user.appserver.was.appcenteradmin.password</td>
      <td>${user.appserver.selection2} == was &&
${user.appserver.was.profile} != Liberty</td>
      <td>要添加到 WebSphere Application Server 用户列表的 <code>appcenteradmin</code> 用户的密码（可以选择以特定方式加密）。</td>
      <td></td>
    </tr>
    <tr>
      <td>user.appserver.was.serial</td>
      <td>${user.appserver.selection2} == was &&
${user.appserver.was.profile} != Liberty</td>
      <td>用于区分要安装的应用程序与其他 {{ site.data.keys.mf_server }} 安装的后缀。</td>
      <td>含 10 个十进制数字的字符串。</td>
    </tr>
    <tr>
      <td>user.appserver.was85liberty.serverInstance_</td>
      <td>${user.appserver.selection2} == was &&
${user.appserver.was.profile} == Liberty</td>
      <td>要在其中安装应用程序的 WebSphere Application Server Liberty 服务器的名称。</td>
      <td></td>
    </tr>
    <tr>
      <td>user.appserver.tomcat.installdir</td>
      <td>${user.appserver.selection2} == tomcat</td>
      <td>Apache Tomcat 安装目录。 对于在 <b>CATALINA_HOME</b> 目录与 <b>CATALINA_BASE</b> 目录之间分拆开的 Tomcat 安装，您需要在此指定 <b>CATALINA_BASE</b> 环境变量的值。</td>
      <td>一个绝对目录名称。</td>
    </tr>
    <tr>
      <td>user.database.selection2</td>
      <td>总是</td>
      <td>用于存储数据库的数据库管理系统的类型。</td>
      <td><code>derby</code>、<code>db2</code>、<code>mysql</code>、<code>oracle</code> 和 <code>none</code>。 值 none 表示安装程序不会安装 Application Center。 如果使用此值，那么 <b>user.appserver.selection2</b> 和 <b>user.database.selection2</b> 都必须采用值 none。</td>
    </tr>
    <tr>
      <td>user.database.preinstalled</td>
      <td>总是</td>
      <td><code>true</code> 表示预安装的数据库管理系统，而 <code>false</code> 表示要安装的 Apache Derby。</td>
      <td><code>true</code> 和 <code>false</code></td>
    </tr>
    <tr>
      <td>user.database.derby.datadir</td>
      <td>${user.database.selection2} == derby</td>
      <td>要在其中创建或采用 Derby 数据库的目录。</td>
      <td>一个绝对目录名称。</td>
    </tr>
    <tr>
      <td>user.database.db2.host</td>
      <td>${user.database.selection2} == db2</td>
      <td>DB2 数据库服务器的主机名或 IP 地址。</td>
      <td></td>
    </tr>
    <tr>
      <td>user.database.db2.port</td>
      <td>${user.database.selection2} == db2</td>
      <td>一个端口，DB2 数据库服务器在此端口侦听 JDBC 连接。 通常为 50000。</td>
      <td>一个 1 到 65535 之间的数字。</td>
    </tr>
    <tr>
      <td>user.database.db2.driver</td>
      <td>${user.database.selection2} == db2</td>
      <td>db2jcc4.jar 的绝对文件名。</td>
      <td>一个绝对文件名。</td>
    </tr>
    <tr>
      <td>user.database.db2.appcenter.username</td>
      <td>${user.database.selection2} == db2</td>
      <td>用于访问 Application Center 的 DB2 数据库的用户名。</td>
      <td>非空。</td>
    </tr>
    <tr>
      <td>user.database.db2.appcenter.password</td>
      <td>${user.database.selection2} == db2</td>
      <td>用于访问 Application Center 的 DB2 数据库的密码，可以选择以特定方式加密。</td>
      <td>非空密码。</td>
    </tr>
    <tr>
      <td>user.database.db2.appcenter.dbname</td>
      <td>${user.database.selection2} == db2</td>
      <td>Application Center 的 DB2 数据库的名称。</td>
      <td>非空；一个有效的 DB2 数据库名称。</td>
    </tr>
    <tr>
      <td>user.database.oracle.appcenter.isservicename.jdbc.url</td>
      <td>可选</td>
      <td>指示 <b>user.database.mysql.appcenter.dbname</b> 是服务名称还是 SID 名称。 如果该参数不存在，那么会将 <b>user.database.mysql.appcenter.dbname</b> 视为 SID 名称。</td>
      <td><code>true</code>（指示服务名称）或 <code>false</code>（指示 SID 名称）</td>
    </tr>
    <tr>
      <td>user.database.db2.appcenter.schema</td>
      <td>${user.database.selection2} == db2</td>
      <td>DB2 数据库中的 Application Center 模式的名称。</td>
      <td></td>
    </tr>
    <tr>
      <td>user.database.mysql.host</td>
      <td>${user.database.selection2} == mysql</td>
      <td>MySQL 数据库服务器的主机名或 IP 地址。</td>
      <td></td>
    </tr>
    <tr>
      <td>user.database.mysql.port</td>
      <td>${user.database.selection2} == mysql</td>
      <td>一个端口，MySQL 数据库服务器在此端口侦听 JDBC 连接。 通常为 3306。</td>
      <td>一个 1 到 65535 之间的数字。</td>
    </tr>
    <tr>
      <td>user.database.mysql.driver</td>
      <td>${user.database.selection2} == mysql</td>
      <td><b>mysql-connector-java-5.*-bin.jar</b> 的绝对文件名。</td>
      <td>一个绝对文件名。</td>
    </tr>
    <tr>
      <td>user.database.mysql.appcenter.username</td>
      <td>${user.database.selection2} == oracle</td>
      <td>用于访问 Application Center 的 Oracle 数据库的用户名。</td>
      <td>由 1 到 30 个字符组成的字符串：允许使用 ASCII 数字、ASCII 大写和小写字母、“_”、“#”以及“$”。</td>
    </tr>
    <tr>
      <td>user.database.mysql.appcenter.password</td>
      <td>${user.database.selection2} == oracle</td>
      <td>用于访问 Application Center 的 Oracle 数据库的密码，可以选择以特定方式加密。</td>
      <td>该密码必须是由 1 到 30 个字符组成的字符串：允许使用 ASCII 数字、ASCII 大写和小写字母、“_”、“#”以及“$”。</td>
    </tr>
    <tr>
      <td>user.database.mysql.appcenter.dbname</td>
      <td>${user.database.selection2} == oracle，除非指定了 ${user.database.oracle.appcenter.jdbc.url}</td>
      <td>Application Center 的 Oracle 数据库的名称。</td>
      <td>非空；一个有效的 Oracle 数据库名称。</td>
    </tr>
    <tr>
      <td>user.database.oracle.host</td>
      <td>${user.database.selection2} == oracle，除非指定了 ${user.database.oracle.appcenter.jdbc.url}</td>
      <td>Oracle 数据库服务器的主机名或 IP 地址。</td>
      <td></td>
    </tr>
    <tr>
      <td>user.database.oracle.port</td>
      <td>${user.database.selection2} == oracle，除非指定了 ${user.database.oracle.appcenter.jdbc.url}</td>
      <td>一个端口，Oracle 数据库服务器在此端口侦听 JDBC 连接。 通常为 1521。</td>
      <td>一个 1 到 65535 之间的数字。</td>
    </tr>
    <tr>
      <td>user.database.oracle.driver</td>
      <td>${user.database.selection2} == oracle</td>
      <td>Oracle 瘦驱动程序 jar 文件的绝对文件名。 （<b>ojdbc6.jar 或 ojdbc7.jar</b>）</td>
      <td>一个绝对文件名。</td>
    </tr>
    <tr>
      <td>user.database.oracle.appcenter.username</td>
      <td>${user.database.selection2} == oracle</td>
      <td>用于访问 Application Center 的 Oracle 数据库的用户名。</td>
      <td>由 1 到 30 个字符组成的字符串：允许使用 ASCII 数字、ASCII 大写和小写字母、“_”、“#”以及“$”。</td>
    </tr>
    <tr>
      <td>user.database.oracle.appcenter.username.jdbc</td>
      <td>	${user.database.selection2} == oracle</td>
      <td>用于访问 Application Center 的 Oracle 数据库的用户名，采用适合于 JDBC 的语法。</td>
      <td>如果该用户名以一个字母字符开头并且不包含小写字符，那么与 ${user.database.oracle.appcenter.username} 相同，否则必须是引在双引号内的 ${user.database.oracle.appcenter.username}。</td>
    </tr>
    <tr>
      <td>user.database.oracle.appcenter.password</td>
      <td>${user.database.selection2} == oracle</td>
      <td>用于访问 Application Center 的 Oracle 数据库的密码，可以选择以特定方式加密。</td>
      <td>该密码必须是由 1 到 30 个字符组成的字符串：允许使用 ASCII 数字、ASCII 大写和小写字母、“_”、“#”以及“$”。</td>
    </tr>
    <tr>
      <td>user.database.oracle.appcenter.dbname</td>
      <td>${user.database.selection2} == oracle，除非指定了 ${user.database.oracle.appcenter.jdbc.url}</td>
      <td>Application Center 的 Oracle 数据库的名称。</td>
      <td>非空；一个有效的 Oracle 数据库名称。
</td>
    </tr>
    <tr>
      <td>user.database.oracle.appcenter.isservicename.jdbc.url</td>
      <td>可选</td>
      <td>指示 <code>user.database.oracle.appcenter.dbname</code> 是服务名称还是 SID 名称。 如果该参数不存在，那么会将 <code>user.database.oracle.appcenter.dbname</code> 视为 SID 名称。</td>
      <td><code>true</code>（指示服务名称）或 <code>false</code>（指示 SID 名称）</td>
    </tr>
    <tr>
      <td>user.database.oracle.appcenter.jdbc.url</td>
      <td>${user.database.selection2} == oracle，除非 ${user.database.oracle.host}、${user.database.oracle.port} 和 ${user.database.oracle.appcenter.dbname} 全都已指定</td>
      <td>Application Center 的 Oracle 数据库的 JDBC URL。</td>
      <td>一个有效的 Oracle JDBC URL。 以“jdbc:oracle:”开头。</td>
    </tr>
    <tr>
      <td>user.writable.data.user</td>
      <td>总是</td>
      <td>被允许运行所安装服务器的操作系统用户。</td>
      <td>一个操作系统用户名，或为空。</td>
    </tr>
    <tr>
      <td>user.writable.data.group2</td>
      <td>总是</td>
      <td>被允许运行所安装服务器的操作系统用户组。</td>
      <td>一个操作系统用户组名，或为空。</td>
    </tr>
</table>

## {{ site.data.keys.mf_server }} 的分布结构
{: #distribution-structure-of-mobilefirst-server }
{{ site.data.keys.mf_server }} 文件和工具都安装在 {{ site.data.keys.mf_server }} 安装目录中。

#### Analytics 子目录中的文件和子目录
{: #files-and-subdirectories-in-the-analytics-subdirectory }

| 项目 | 描述 |
|------|-------------|
| **analytics.ear** 和 **analytics-*.war** | 用于安装 {{ site.data.keys.mf_analytics }} 的 EAR 和 WAR 文件。 |
| **configuration-samples** | 包含样本 Ant 文件以使用 Ant 任务安装 {{ site.data.keys.mf_analytics }}。 |

#### ApplicationCenter 子目录中的文件和子目录
{: #files-and-subdirectories-in-the-applicationcenter-subdirectory }

| 项目 | 描述 |
|------|-------------|
| **configuration-samples** | 包含用于安装 Application Center 的样本 Ant 文件。 Ant 任务将创建数据库表并将 WAR 文件部署到应用程序服务器。 |
| **console** | 包含用于安装 Application Center 的 EAR 和 WAR 文件。 EAR 文件对于 IBM
PureApplication System 而言唯一。 |
| **databases** | 包含用于为 Application Center 手动创建表的 SQL 脚本。 |
| **installer** | 包含用于创建 Application Center 客户机的资源。 |
| **tools** | Application Center 的工具。 |

#### {{ site.data.keys.mf_server }} 子目录中的文件和子目录
{: #files-and-subdirectories-in-the-mobilefirst-server-subdirectory }

| 项目 | 描述 |
|------|-------------|
| **mfp-ant-deployer.jar** | 一组 {{ site.data.keys.mf_server }} Ant 任务。 |
| **mfp-*.war** | {{ site.data.keys.mf_server }} 组件的 WAR 文件。 |
| **configuration-samples** | 包含样本 Ant 文件以使用 Ant 任务安装 {{ site.data.keys.mf_server }} 组件。 |
| **ConfigurationTool** | 包含 Server Configuration Tool 的二进制文件。 可通过 **mfp_server_install_dir/shortcuts** 启动此工具。 |
| **databases** | 包含用于为 {{ site.data.keys.mf_server }} 组件（{{ site.data.keys.mf_server }} 管理服务、{{ site.data.keys.mf_server }} 配置服务和 {{ site.data.keys.product_adj }} 运行时）手动创建表的 SQL 脚本。 |
| **external-server-libraries** |  包含不同工具（如真实性工具和 OAuth 安全工具）使用的 JAR 文件。 |

#### PushService 子目录中的文件和子目录
{: #files-and-subdirectories-in-the-pushservice-subdirectory }

| 项目 | 描述 |
|------|-------------|
| **mfp-push-service.war** | 用于安装 {{ site.data.keys.mf_server }} 推送服务的 WAR 文件。 |
| **databases** | 包含用于为 {{ site.data.keys.mf_server }} 推送服务手动创建表的 SQL 脚本。 |

#### License 子目录中的文件和子目录
{: #files-and-subdirectories-in-the-license-subdirectory }

| 项目 | 描述 |
|------|-------------|
| **Text** | 包含 {{ site.data.keys.product }} 的许可证。 |

#### {{ site.data.keys.mf_server }} 安装目录中的文件和子目录
{: #files-and-subdirectories-in-the-mobilefirst-server-installation-directory }

| 项目 | 描述 |
|------|-------------|
| **shortcuts** | {{ site.data.keys.mf_server }} 随附了 Apache Ant 的启动程序脚本、Server Configuration Tool 和 mfpadmin 命令。 |

#### tools 子目录中的文件和子目录
{: #files-and-subdirectories-in-the-tools-subdirectory }

| 项目 | 描述 |
|------|-------------|
| **tools/apache-ant-version-number** | Server Configuration Tool 所使用的 Apache Ant 的二进制安装。 它还可用于运行 Ant 任务。 |
