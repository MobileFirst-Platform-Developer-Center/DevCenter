---
layout: tutorial
title: MobileFirst Analytics Server 安装指南
breadcrumb_title: Installation Guide
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
采用一组两个 Java EE 标准 Web 应用程序归档 (WAR) 文件或一个企业应用程序归档 (EAR) 文件形式实施并装运 {{ site.data.keys.mf_analytics_server }}。 因此，可以在以下某个受支持的应用程序服务器中安装该产品：WebSphere Application Server、WebSphere Application Server Liberty 或 Apache Tomcat（仅限 WAR 文件）。

{{ site.data.keys.mf_analytics_server }} 将嵌入式 Elasticsearch 库用于数据存储和集群管理。 由于要实现高性能内存内搜索和查询引擎，需要快速磁盘 I/O，因此必须满足某些生产系统需求。 一般来说，在 CPU 出现问题之前可能已出现内存不足和磁盘不足（或者发现磁盘 I/O 成为性能瓶颈）。 在集群环境中，您需要快速、可靠、共置的节点集群。

#### 跳至：
{: #jump-to }

* [系统需求](#system-requirements)
* [容量注意事项](#capacity-considerations)
* [在 WebSphere Application Server Liberty 上安装 {{ site.data.keys.mf_analytics }}](#installing-mobilefirst-analytics-on-websphere-application-server-liberty)
* [在 Tomcat 上安装 {{ site.data.keys.mf_analytics }}](#installing-mobilefirst-analytics-on-tomcat)
* [在 WebSphere Application Server 上安装 {{ site.data.keys.mf_analytics }}](#installing-mobilefirst-analytics-on-websphere-application-server)
* [使用 Ant 任务安装 {{ site.data.keys.mf_analytics }}](#installing-mobilefirst-analytics-with-ant-tasks)
* [在运行先前版本的服务器上安装 {{ site.data.keys.mf_analytics_server }}](#installing-mobilefirst-analytics-server-on-servers-running-previous-versions)

## 系统需求
{: #system-requirements }

### 操作系统
{: #operating-systems }
* CentOS/RHEL 6.x/7.x
* 仅含 RHEL 内核的 Oracle Enterprise Linux 6/7
* Ubuntu 12.04/14.04
* SLES 11/12
* OpenSuSE 13.2
* Windows Server 2012/R2
* Debian 7

### JVM
{: #jvm }
* Oracle JVM 1.7u55+
* Oracle JVM 1.8u20+
* IcedTea OpenJDK 1.7.0.55+

### 硬件
{: #hardware }
* RAM：RAM 越多越好，但每个节点不超过 64 GB。 32 GB 和 16 GB 也可接受。 如果使用小于 8 GB 的 RAM，那么需要集群中存在许多小型节点；由于 Java 指针使用内存的方式，因此使用 64 GB 的 RAM 将会造成浪费而且容易出现问题。
* 磁盘：尽可能使用 SSD，或者如果 SSD 不可用，那么使用 RAID 0 配置中的高转速传统磁盘。
* CPU：CPU 往往不会成为性能瓶颈。 使用 2 核至 8 核的系统。
* 网络：出现需要水平扩展的需求之后，需要快速、可靠的数据中心，支持 1 GbE 至 10 GbE 的速度。

### 硬件配置
{: #hardware-configuration }
* 将可用 RAM 的一半提供给 JVM，但不超过 32 GB
    * 将 **ES\_HEAP\_SIZE** 环境变量设置为 32g。
    * 使用 -Xmx32g -Xms32g 设置 JVM 标志。
* 关闭磁盘交换。 允许操作系统在磁盘上开关堆交换会导致性能显著降级。
    * 暂时：`sudo swapoff -a`
    * 永久：根据操作系统文档编辑 **/etc/fstab**。
    * 如果上述选项均不可用，请设置 Elasticsearch 选项 **bootstrap.mlockall:
true**（在嵌入式 Elasticsearch 实例中该值为缺省值）。
* 增加允许的打开文件描述符。
    * Linux 通常将每个进程的打开文件描述符的数量限制为 1024。
    * 请查询您的操作系统文档，了解如何一直增大该值至较大的值，如 64,000。
* Elasticsearch 也针对各种文件混用 NioFS 和 MMapFS。 增加最大映射计数，从而使大量虚拟内存可用于映射的文件。
    * 暂时：`sysctl -w vm.max_map_count=262144`
    * 永久：在 **/etc/sysctl.conf** 中修改 **vm.max\_map\_count** 设置。
* 如果使用 BSD 和 Linux，请确保操作系统 I/O 调度程序设置为 **deadline** 或 **noop**，而不是设置为 **cfq**。

## 容量注意事项
{: #capacity-considerations }
容量是一个最常见的问题。 您需要多少 RAM？ 需要多少磁盘空间？ 需要多少节点？ 答案始终是：酌情而定。

您可以通过 IBM {{ site.data.keys.mf_analytics }} Analytics 收集许多异构事件类型，包括原始客户机 SDK 调试日志、服务器报告的网络事件、定制数据等。 它是一个大数据系统，拥有大数据系统需求。

您选择收集的数据类型和数据量以及您选择保留数据的时间长短都对您的存储需求和总体性能存在巨大的影响。 例如，请考虑以下问题。

* 原始调试客户机日志一个月后是否还有用？
* 您是否使用 {{ site.data.keys.mf_analytics }} 中的**警报**功能？ 如果使用此功能，那么您查询的事件是最近几分钟内发生的事件还是更大时间范围内发生的事件？
* 您使用定制图表吗？ 如果使用，那么您创建的这些图表是用于内置数据还是定制受检测的键/值对？ 您的数据保留多长时间？

{{ site.data.keys.mf_analytics_console }} 上的内置图表通过查询 {{ site.data.keys.mf_analytics_server }} 已汇总并优化（旨在实现尽可能最快的控制台用户体验）的数据来呈现。 由于这些数据已针对内置图表预先汇总和优化，因此不适用于控制台用户定义查询的警报或定制图表。

查询原始文档、应用过滤器、执行聚集和要求底层查询引擎计算平均值和百分比时，势必影响查询性能。 此用例需要仔细考量容量。 当查询性能受到影响之后，需要确定必须保留旧数据用于实现实时控制台可视性，还是将其从 {{ site.data.keys.mf_analytics_server }} 中清除。 实时控制台可视性是否确实对四个月前的数据有用？

### 索引、分片和节点
{: #indicies-shards-and-nodes }
底层数据存储是 Elasticsearch。 您必须对索引、分片和节点以及配置方式对性能的影响有所了解。 您可以将索引简单理解为数据的逻辑单元。 索引以一对多方式映射到分片（配置键即是分片）。 {{ site.data.keys.mf_analytics_server }} 按文档类型创建独立索引。 如果配置不丢弃任何文档类型，那么将创建数量等同于 {{ site.data.keys.mf_analytics_server }} 所提供的文档类型数量的索引。

如果将分片配置为 1，那么每个索引永远只有一个可供写入数据的主分片。 如果将分片设置为 10，那么每个索引可与 10 个分片相抵。 但是如果只有一个节点，那么分片过多会消耗性能。 这一个节点现在将每个索引与相同物理磁盘上的 10 个分片相抵。 只有在您计划立即（或几乎立即）将集群中的物理节点数扩展至 10 个时，才能将分片设置为 10。

同样的原则适用于 **replicas**。 仅当您计划立即（或几乎立即）扩展至匹配数学公式的节点数时才能将 **replicas** 设置为大于 0 的数字。  
例如，如果将 **shards** 设置为 4，并且将 **replicas** 设置为 2，那么可以扩展至 8 个节点，即 4 * 2。

## 在 WebSphere Application Server Liberty 上安装 {{ site.data.keys.mf_analytics }}
{: #installing-mobilefirst-analytics-on-websphere-application-server-liberty }
确保您已具有 {{ site.data.keys.mf_analytics }} EAR 文件。 有关安装工件的更多信息，请参阅[将 {{ site.data.keys.mf_server }} 安装到应用程序服务器中](../../prod-env/appserver)。 **analytics.ear** 文件位于 `<mf_server_install_dir>\analytics` 文件夹中。 有关如何下载和安装 WebSphere Application Server Liberty 的更多信息，请参阅 IBM developerWorks 上的以下文章：[关于 WebSphere Liberty](https://developer.ibm.com/wasdev/websphere-liberty/)。

1. 在 **./wlp/bin** 文件夹中运行以下命令以创建服务器。

   ```bash
   ./server create <serverName>
   ```

2. 通过在 **./bin** 文件夹中运行以下命令来安装以下功能部件。

   ```bash
   ./featureManager install jsp-2.2 ssl-1.0 appSecurity-1.0 localConnector-1.0
   ```

3. 将 **analytics.ear** 文件添加到 Liberty Server 的 `./usr/servers/<serverName>/apps` 文件夹中。
4. 将 `./usr/servers/<serverName>/server.xml` 文件的 `<featureManager>` 标记中的内容替换为以下内容：

   ```xml
   <featureManager>
        <feature>jsp-2.2</feature>
        <feature>ssl-1.0</feature>
        <feature>appSecurity-1.0</feature>
        <feature>localConnector-1.0</feature>
   </featureManager>
   ```

5. 在 **server.xml** 文件中，将 **analytics.ear** 配置为具有基于角色的安全性的应用程序。 以下示例将创建基本的硬编码用户注册表，并向用户分配每个不同的分析角色。

   ```xml
   <application location="analytics.ear" name="analytics-ear" type="ear">
        <application-bnd>
            <security-role name="analytics_administrator">
                <user name="admin"/>
            </security-role>
            <security-role name="analytics_infrastructure">
                <user name="infrastructure"/>
            </security-role>
            <security-role name="analytics_support">
                <user name="support"/>
            </security-role>
            <security-role name="analytics_developer">
                <user name="developer"/>
            </security-role>
            <security-role name="analytics_business">
                <user name="business"/>
            </security-role>
        </application-bnd>
   </application>

   <basicRegistry id="worklight" realm="worklightRealm">
        <user name="business" password="demo"/>
        <user name="developer" password="demo"/>
        <user name="support" password="demo"/>
        <user name="infrastructure" password="demo"/>
        <user name="admin" password="admin"/>
   </basicRegistry>
   ```

   > 有关如何配置其他用户注册表类型（如 LDAP）的更多信息，请参阅 WebSphere Application Server 产品文档中的[为 Liberty 配置用户注册表](http://ibm.biz/knowctr#SSAW57_8.5.5/com.ibm.websphere.wlp.nd.iseries.doc/ae/twlp_sec_registries.html)主题。

6. 通过在 **bin** 文件夹中运行以下命令来启动 Liberty Server。

   ```bash
   ./server start <serverName>
   ```

7. 转至 {{ site.data.keys.mf_analytics_console }}。

   ```bash
   http://localhost:9080/analytics/console
   ```

有关管理 WebSphere Application Server Liberty 的更多信息，请参阅 WebSphere Application Server 产品文档中的[从命令行管理 Liberty](http://ibm.biz/knowctr#SSAW57_8.5.5/com.ibm.websphere.wlp.nd.multiplatform.doc/ae/twlp_admin_script.html) 主题。

## 在 Tomcat 上安装 {{ site.data.keys.mf_analytics }}
{: #installing-mobilefirst-analytics-on-tomcat }
确保您已具有 {{ site.data.keys.mf_analytics }} WAR 文件。 有关安装工件的更多信息，请参阅[将 {{ site.data.keys.mf_server }} 安装到应用程序服务器中](../../prod-env/appserver)。 **analytics-ui.war** 和 **analytics-service.war** 文件位于 **<mf_server_install_dir>\analytics** 文件夹中。 有关如何下载和安装 Tomcat 的更多信息，请参阅 [Apache Tomcat](http://tomcat.apache.org/)。 确保下载的版本支持 Java 7 或更高版本。 有关哪一个版本的 Tomcat 支持 Java 7 的更多信息，请参阅 [Apache Tomcat 版本](http://tomcat.apache.org/whichversion.html)。

1. 将 **analytics-service.war** 和 **analytics-ui.war** 文件添加到 Tomcat **webapps** 文件夹中。
2. 取消注释 **conf/server.xml** 文件中的以下节（此节存在于新下载的 Tomcat 归档中，但已被注释掉）。

   ```xml
   <Valve className="org.apache.catalina.authenticator.SingleSignOn"/>
   ```

3. 在 **conf/server.xml** 文件中声明两个 WAR 文件，并定义一个用户注册表。

   ```xml
   <Context docBase ="analytics-service" path ="/analytics-service"></Context>
   <Context docBase ="analytics" path ="/analytics"></Context>
   <Realm className ="org.apache.catalina.realm.MemoryRealm"/>
   ```

   **MemoryRealm** 将识别 **conf/tomcat-users.xml** 文件中定义的用户。 有关其他选项的更多信息，请参阅 [Apache Tomcat 域配置方法](http://tomcat.apache.org/tomcat-7.0-doc/realm-howto.html)。

4. 将以下节添加到 **conf/tomcat-users.xml** 文件中以配置 **MemoryRealm**。
    * 添加安全角色。

      ```xml
      <role rolename="analytics_administrator"/>
      <role rolename="analytics_infrastructure"/>
      <role rolename="analytics_support"/>
      <role rolename="analytics_developer"/>
      <role rolename="analytics_business"/>
      ```
    * 添加一些具有所需角色的用户。

      ```xml
      <user name="admin" password="admin" roles="analytics_administrator"/>
      <user name="support" password="demo" roles="analytics_support"/>
      <user name="business" password="demo" roles="analytics_business"/>
      <user name="developer" password="demo" roles="analytics_developer"/>
      <user name="infrastructure" password="demo" roles="analytics_infrastructure"/>
      ```    
    * 启动 Tomcat Server 并转至 {{ site.data.keys.mf_analytics_console }}。

      ```xml
      http://localhost:8080/analytics/console
      ```

    有关如何启动 Tomcat Server 的更多信息，请访问 Tomcat 官网。 例如，如果是 Tomcat 7.0，请访问 [Apache Tomcat 7](http://tomcat.apache.org/tomcat-7.0-doc/introduction.html)。

## 在 WebSphere Application Server 上安装 {{ site.data.keys.mf_analytics }}
{: #installing-mobilefirst-analytics-on-websphere-application-server }
有关用于获取安装工件（JAR 和 EAR 文件）的初始安装步骤的更多信息，请参阅[将 {{ site.data.keys.mf_server }} 安装到应用程序服务器中](../../prod-env/appserver)。 **analytics.ear**、**analytics-ui.war** 和 **analytics-service.war** 文件位于 **<mf_server_install_dir>\analytics** 文件夹中。

以下步骤描述了如何在 WebSphere Application Server 上安装和运行分析 EAR 文件。 如果要在 WebSphere Application Server 上安装个别 WAR 文件，只需在部署两个 WAR 文件后对 **analytics-service** WAR 文件执行步骤 2 至 7 即可。 不能在 analytics-ui WAR 文件中更改类装入顺序。

1. 将 EAR 文件部署到应用程序服务器，但不启动。 . 有关如何在 WebSphere Application Server 上安装 EAR 文件的更多信息，请参阅 WebSphere Application Server 产品文档中的[使用控制台安装企业应用程序文件](http://ibm.biz/knowctr#SSAW57_8.5.5/com.ibm.websphere.nd.multiplatform.doc/ae/trun_app_instwiz.html)主题。

2. 从**企业应用程序**列表中选择 **MobileFirst Analytics** 应用程序。

    ![安装 WebSphere 企业应用程序](install_webphere_ent_app.jpg)

3. 单击**类装入和更新检测**。

    ![WebSphere 中的类装入](install_websphere_class_load.jpg)

4. 将类装入顺序设置为**父代最后**。

    ![更改类装入顺序](install_websphere_app_class_load_order.jpg)

5. 单击**安全角色到用户/组的映射**以映射管理用户。

    ![War 类装入顺序](install_websphere_sec_role.jpg)

6. 单击**管理模块**。

    ![在 WebSphere 中管理模块](install_websphere_manage_modules.jpg)

7. 选择**分析**模块并将类装入器顺序更改为**父代最后**。

    ![WebSphere 中的“分析”模块](install_websphere_module_class_load_order.jpg)

8. 在 WebSphere Application Server 管理控制台中启用**管理安全性**和**应用程序安全性**：
    * 登录到 WebSphere Application Server 管理控制台。
    * 在**安全性 > 全局安全性**菜单中，确保同时选中**启用管理安全性**和**启用应用程序安全性**。 注：仅在启用**管理安全性**后才可选择应用程序安全性。
    * 单击**确定**并保存更改。

9. 要支持通过 Swagger 文档访问分析服务，请完成以下步骤：
    * 单击**服务器 > 服务器类型 > WebSphere Application Server**，并从服务器列表中选择在其中部署分析服务的服务器。
    * 在**服务器基础结构**下，单击 **Java**，然后浏览至**流程管理 > 流程定义 > Java 虚拟机 > 定制属性**。
      - 设置以下定制属性<br/>
        **属性名称：***com.ibm.ws.classloader.strict*<br/>
        **值：***true*

10. 启动 {{ site.data.keys.mf_analytics }} 应用程序，并在浏览器中转至以下链接：`http://<hostname>:<port>/analytics/console`。

## 使用 Ant 任务安装 {{ site.data.keys.mf_analytics }}
{: #installing-mobilefirst-analytics-with-ant-tasks }
确保您有必需的 WAR 和配置文件：**analytics-ui.war** 和 **analytics-service.war**。 有关安装工件的更多信息，请参阅[将 {{ site.data.keys.mf_server }} 安装到应用程序服务器中](../../prod-env/appserver)。 **analytics-ui.war** 和 **analytics-service.war** 文件位于 **MobileFirst_Platform_Server\analytics** 中。

您必须在安装了应用程序服务器的计算机上运行 Ant 任务，或运行针对 WebSphere Application Server Network Deployment 的 Network Deployment Manager。 如果您希望从没有安装 {{ site.data.keys.mf_server }} 的计算机启动 Ant 任务，那么必须将以下文件复制到该计算机上：**\<mf_server_install_dir\>/MobileFirstServer/mfp-ant-deployer.jar**。

> 注：**mf_server_install_dir** 占位符是 {{ site.data.keys.mf_server }} 的安装目录。

1. 编辑您稍后用于部署 {{ site.data.keys.mf_analytics }} WAR 文件的 Ant 脚本。
    * 查看 [{{ site.data.keys.mf_analytics }} 样本配置文件](../../installation-reference/#sample-configuration-files-for-mobilefirst-analytics)中的样本配置文件。
    * 将占位符值替换为该文件开头的属性。

    > 注：当在 Ant XML 脚本的值中使用以下特殊字符时，必须对这些字符进行转义：
    >
    > * 美元符号 ($) 必须写作 $$，除非您明确希望通过语法 ${variable} 引用 Ant 变量，如 Apache Ant 手册的[属性](http://ant.apache.org/manual/properties.html)部分中所述。
    > * 和号字符 (&) 必须写作 &amp;，除非您明确希望引用 XML 实体。
    > * 双引号 (") 必须写作 &quot;，除非它在由单引号括起的字符串内。

2. 如果在多个服务器上安装节点集群：
    * 您必须取消注释 **wl.analytics.masters.list** 属性，并将其值设置为主节点的主机名和传输端口的列表。 例如：`node1.mycompany.com:96000,node2.mycompany.com:96000`
    * 在 **installanalytics**、**updateanalytics** 和 **uninstallanalytics** 任务中，将 **mastersList** 属性添加到 **elasticsearch** 元素中。

    **注：**如果在 WebSphere Application Server Network Deployment 的集群上进行安装，并且未设置该属性，那么 Ant 任务会在安装期间计算集群内所有成员的数据端点，并将 **masternodes** JNDI 属性设置为该值。

3. 要部署 WAR 文件，请运行以下命令：`ant -f configure-appServer-analytics.xml install`
    可以在 **mf_server_install_dir/shortcuts** 中找到该 Ant 命令。 此命令将在服务器上安装 {{ site.data.keys.mf_analytics }} 节点以及缺省类型的主节点和数据节点；如果在 WebSphere Application Server Network Deployment 上进行安装，那么会在集群的每个成员上安装这些节点。
4. 保存 Ant 文件。 您稍后可能需要使用此文件来应用修订包或执行升级。
    如果您不想保存密码，可以在出现交互式提示时使用“************”（12 个星号）来代替密码。

    **注：**如果您将节点添加到 {{ site.data.keys.mf_analytics }} 的集群中，那么必须更新 analytics/masternodes JNDI 属性，使其包含集群内所有主节点的端口。

## 在运行先前版本的服务器上安装 {{ site.data.keys.mf_analytics_server }}
{: #installing-mobilefirst-analytics-server-on-servers-running-previous-versions }
虽然没有用于升级先前版本
{{ site.data.keys.mf_analytics_server }} 的选项，但当您在托管先前版本的服务器上安装 {{ site.data.keys.mf_analytics_server }} V8.0.0 时，必须迁移一些属性和分析数据。

对于先前运行较早版本
{{ site.data.keys.mf_analytics_server }} 的服务器，请更新分析数据和 JNDI 属性。

### 迁移先前版本的
{{ site.data.keys.mf_analytics_server }} 所使用的服务器属性
{: #migration-of-server-properties-used-by-previous-versions-of-mobilefirst-analytics-server }
如果在以前运行过较早版本的
{{ site.data.keys.mf_analytics_server }} 的服务器上安装 {{ site.data.keys.mf_analytics_server }} V8.0.0，那么必须更新托管服务器上 JNDI 属性的值。

与较早版本相比，{{ site.data.keys.mf_analytics_server }} V8.0.0 中更改了一些事件类型。 由于此更改，必须将先前在服务器配置文件中配置的任何 JNDI 属性转换为新事件类型。

下表显示了旧事件类型与新事件类型之间的映射。 一些事件类型未更改。

| 旧事件类型            | 新事件类型         |
|---------------------------|------------------------|
| AlertDefinition	        | AlertDefinition        |
| AlertNotification	        | AlertNotification      |
| AlertRunnerNode	        | AlertRunnerNode        |
| AnalyticsConfiguration    | AnalyticsConfiguration |
| CustomCharts	            | CustomChart            |
| CustomData	            | CustomData             |
| Devices	                | Device                 |
| MfpAppLogs                | AppLog                 |
| MfpAppPushAction          | AppPushAction          |
| MfpAppSession	            | AppSession             |
| ServerLogs	            | ServerLog              |
| ServerNetworkTransactions | NetworkTransaction     |
| ServerPushNotifications   | PushNotification       |
| ServerPushSubscriptions   | PushSubscription       |
| Users	                    | User                   |
| inboundRequestURL	        | resourceURL            |
| mfpAppName	            | appName                |
| mfpAppVersion	            | appVersion             |

### 分析数据迁移
{: #analytics-data-migration }
{{ site.data.keys.mf_analytics_console }} 的内部进行了改进，改进的过程中需要更改存储数据的格式。 要继续与已收集的分析数据进行交互，必须将这些数据迁移到新的数据格式中。

在升级到 V8.0.0 之后首次查看 {{ site.data.keys.mf_analytics_console }} 时，在 {{ site.data.keys.mf_analytics_console }} 中不会显示任何统计信息。 您的数据并未丢失，但必须将其迁移至新的数据格式。

在 {{ site.data.keys.mf_analytics_console }} 的每个页面中显示警报，提醒您必须迁移文档。 此警报文本包含指向**迁移**页面的链接。

下图显示了来自**仪表板**部分的**概述**页面的样本警报：

![控制台中的迁移警报](migration_alert.jpg)

### “迁移”页面
{: #migration-page }
您可以通过 {{ site.data.keys.mf_analytics_console }} 中的扳手图标来访问“迁移”页面。 在**迁移**页面中，您可以看到必须迁移的文档数以及存储这些文档的索引。 只有一项操作可用：**执行迁移**。

下图显示了存在必须迁移的文档时的**迁移**页面：

![控制台中的“迁移”页面](migration_page.jpg)

> **注：**该过程可能需要较长时间（具体取决于您拥有的数据量），并且在迁移期间不能停止该过程。

在具有 32G 的 RAM、16G 的 JVM 以及 4 核处理器的单个节点上迁移 100 万个文档大约需要 3 分钟。 由于无法查询到未迁移的文档，因而未在 {{ site.data.keys.mf_analytics_console }} 中呈现这些文档。

如果迁移过程失败，请重新尝试迁移。 重新尝试迁移不会重新迁移已迁移过的文档，因此可保持数据的完整性。
