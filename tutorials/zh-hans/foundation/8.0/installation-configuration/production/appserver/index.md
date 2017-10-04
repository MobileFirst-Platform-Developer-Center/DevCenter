---
layout: tutorial
title: 将 MobileFirst Server 安装到应用程序服务器
breadcrumb_title: 安装 MobileFirst Server
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
可以使用 Ant 任务或 Server Configuration Tool 安装组件，或手动进行安装。了解关于安装流程的先决条件和详细信息，以便您能够在应用程序服务器上成功安装组件。

在继续将组件安装到应用程序服务器之前，请确保组件的数据库和表已就绪并且可以使用。有关更多信息，请参阅[设置数据库](../databases)。

还必须定义用于安装组件的服务器拓扑。请参阅[拓扑和网络流](../topologies)。

#### 跳转至
{: #jump-to }

* [应用程序服务器必备软件](#application-server-prerequisites)
* [使用 Server Configuration Tool 安装](#installing-with-the-server-configuration-tool)
* [使用 Ant 任务安装](#installing-with-ant-tasks)
* [手动安装 {{ site.data.keys.mf_server }} 组件](#installing-the-mobilefirst-server-components-manually)
* [安装服务器场](#installing-a-server-farm)

## 应用程序服务器必备软件
{: #application-server-prerequisites }
根据您所选的应用程序服务器，选择以下某个主题，以了解在安装 {{ site.data.keys.mf_server }} 组件前必须满足的先决条件。

* [Apache Tomcat 先决条件](#apache-tomcat-prerequisites)
* [WebSphere Application Server Liberty 先决条件](#websphere-application-server-liberty-prerequisites)
* [WebSphere Application Server 和 WebSphere Application Server Network Deployment 先决条件](#websphere-application-server-and-websphere-application-server-network-deployment-prerequisites)

### Apache Tomcat 先决条件
{: #apache-tomcat-prerequisites }
{{ site.data.keys.mf_server }} 对以下主题中详细介绍的 Apache Tomcat 配置有一些要求。  
确保您满足以下条件：

* 使用受支持版本的 Apache Tomcat。请参阅[系统需求](../../../product-overview/requirements)。
* 必须使用 JRE 7.0 或更高版本运行 Apache Tomcat。
* 必须启用 JMX 配置，以允许管理服务与运行时组件间进行通信。通信使用下面的**为 Apache Tomcat 配置 JMX 连接**中所述的 RMI。

<div class="panel-group accordion" id="tomcat-prereq" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="jmx-connection">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#tomcat-prereq" href="#collapse-jmx-connection" aria-expanded="true" aria-controls="collapse-jmx-connection"><b>单击以获取有关为 Apache Tomcat 配置 JMX 连接的指示信息</b></a>
            </h4>
        </div>

        <div id="collapse-jmx-connection" class="panel-collapse collapse" role="tabpanel" aria-labelledby="jmx-connection">
            <div class="panel-body">
                <p>您必须为 Apache Tomcat 应用程序服务器配置安全的 JMX 连接。</p>
                <p>Server Configuration Tool 和 Ant 任务可以配置缺省安全 JMX 连接，其包括 JMX 远程端口的定义以及认证属性的定义。它们将修改 <b>tomcat_install_dir/bin/setenv.bat</b> 和 <b>tomcat_install_dir/bin/setenv.sh</b>，从而将这些选项添加到 <b>CATALINA_OPTS</b>：</p>
{% highlight xml %}
-Djava.rmi.server.hostname=localhost
-Dcom.sun.management.jmxremote.port=8686
-Dcom.sun.management.jmxremote.authenticate=false
-Dcom.sun.management.jmxremote.ssl=false
{% endhighlight %}

                <p><b>注：</b> 8686 是缺省值。如果计算机上该端口不可用，可以更改此端口的值。</p>

                <ul>
                    <li>如果使用 <b>tomcat_install_dir/bin/startup.bat</b> 或 <b>tomcat_install_dir/bin/catalina.bat</b> 启动 Apache Tomcat，那么将使用 <b>setenv.bat</b> 文件。</li>
                    <li>如果使用 <b>tomcatInstallDir/bin/startup.sh</b> 或 <b>tomcat_install_dir/bin/catalina.sh</b> 启动 Apache Tomcat，那么将使用 <b>setenv.sh</b> 文件。</li>
                </ul>

                <p>如果您通过其他命令启动 Apache Tomcat，那么可能不会使用此文件。如果安装了 Apache Tomcat Windows Service Installer，那么服务启动程序不会使用 <b>setenv.bat</b>。</p>

                <blockquote><b>要点：</b>缺省情况下，此配置不安全。要保护配置，您必须手动完成以下过程的步骤 2 和 3。</blockquote>

                <p>手动配置 Apache Tomcat：</p>

                <ol>
                    <li>对于简单配置，请将以下选项添加到 <b>CATALINA_OPTS</b>：

{% highlight xml %}
-Djava.rmi.server.hostname=localhost
-Dcom.sun.management.jmxremote.port=8686
-Dcom.sun.management.jmxremote.authenticate=false
-Dcom.sun.management.jmxremote.ssl=false
{% endhighlight %}
                    </li>
                    <li>要激活认证，请参阅 Apache Tomcat 用户文档 <a href="https://tomcat.apache.org/tomcat-7.0-doc/config/http.html#SSL_Support">SSL支持 - BIO 和 NIO</a> 以及 <a href="http://tomcat.apache.org/tomcat-7.0-doc/ssl-howto.html">SSL 配置方法</a>。</li>
                    <li>对于启用 SSL 的 JMX 配置，添加以下选项：
{% highlight xml %}
-Dcom.sun.management.jmxremote=true
-Dcom.sun.management.jmxremote.port=8686
-Dcom.sun.management.jmxremote.ssl=true
-Dcom.sun.management.jmxremote.authenticate=false
-Djava.rmi.server.hostname=localhost  
-Djavax.net.ssl.trustStore=<key store location>
-Djavax.net.ssl.trustStorePassword=<key store password>
-Djavax.net.ssl.trustStoreType=<key store type>
-Djavax.net.ssl.keyStore=<key store location>
-Djavax.net.ssl.keyStorePassword=<key store password>
-Djavax.net.ssl.keyStoreType=<key store type>
{% endhighlight %}

                    <b>注：</b>可以更改端口 8686。</li>
                    <li>
                        <p>如果 Tomcat 实例在防火墙背后运行，那么必须配置 JMX 远程生命周期侦听器。请参阅<a href="http://tomcat.apache.org/tomcat-7.0-doc/config/listeners.html#JMX_Remote_Lifecycle_Listener_-_org.apache.catalina.mbeans.JmxRemoteLifecycleListener">JMX远程生命周期侦听器</a>的 Apache Tomcat 文档。</p><p>还必须将以下环境属性添加到 <b>server.xml</b> 文件中的管理服务应用程序的 Context 节，如以下示例所示：</p>

{% highlight xml %}
<Context docBase="mfpadmin" path="/mfpadmin ">
    <Environment name="mfp.admin.rmi.registryPort" value="registryPort" type="java.lang.String" override="false"/>
    <Environment name="mfp.admin.rmi.serverPort" value="serverPort" type="java.lang.String" override="false"/>
</Context>
{% endhighlight %}

                        在上一个示例中：
			<ul>
                            <li>registryPort 必须具有与 JMX 远程生命周期侦听器的 <b>rmiRegistryPortPlatform</b> 属性相同的值。</li>
                            <li>serverPort 必须具有与 JMX 远程生命周期侦听器的 <b>rmiServerPortPlatform</b> 属性相同的值。</li>
                        </ul>
                    </li>
                    <li>如果您通过 Apache Tomcat Windows Service Installer（而不是向 <b>CATALINA_OPTS</b> 添加选项）安装了 Apache Tomcat，那么请运行 <b>tomcat_install_dir/bin/Tomcat7w.exe</b>，并在“属性”窗口的 <b>Java</b> 选项卡中添加选项。

                    <img alt="Apache Tomcat 7 属性" src="Tomcat_Win_Service_Installer_properties.jpg"/></li>
                </ol>
            </div>
        </div>
    </div>
</div>

### WebSphere Application Server Liberty 先决条件
{: #websphere-application-server-liberty-prerequisites }
{{ site.data.keys.product_full }} 对以下主题中详细介绍的 Liberty 服务器配置有一些要求。  

确保您满足以下条件：

* 使用受支持版本的 Liberty。请参阅[系统需求](../../../product-overview/requirements)。
* 必须使用 JRE 7.0 或更高版本运行 Liberty。不支持 JRE 6.0。
* Liberty 的某些版本支持 Java EE 6 和 Java EE 7 的功能。例如，jdbc-4.0 Liberty 功能是 Java EE 6 的一部分，而 jdbc-4.1 Liberty 功能是 Java EE 7 的一部分。可使用 Java EE 6 或 Java EE 7 功能来安装 {{ site.data.keys.mf_server }} V8.0.0。但是，如果要在同一 Liberty 服务器上运行旧版本 {{ site.data.keys.mf_server }}，那么必须使用 Java EE 6 功能。{{ site.data.keys.mf_server }} V7.1.0 和更低版本不支持 Java EE 7 功能。
* 必须如下面的 **为 WebSphere Application Server Liberty Profile 配置 JMX 连接**中所述配置 JMX。
* 要在生产环境中安装，您可能希望在 Windows、Linux 或 UNIX 系统上作为服务启动 Liberty 服务器，以便：
在启动计算机时，{{ site.data.keys.mf_server }} 组件可以自动启动。
当启动运行 Liberty 服务器的进程的用户注销时，此进程不会停止。
* 以下 Liberty 服务器中无法部署 {{ site.data.keys.mf_server }} V8.0.0：包含来自于先前版本的已部署的 {{ site.data.keys.mf_server }} 组件。
* 要在 Liberty 集合体环境中进行安装，Liberty 集合体控制器和 Liberty 集合体集群成员必须按照[配置 Liberty 集合体](http://www.ibm.com/support/knowledgecenter/SSAW57_8.5.5/com.ibm.websphere.wlp.nd.doc/ae/tagt_wlp_configure_collective.html?view=kc)中所述来进行配置。

<div class="panel-group accordion" id="websphere-prereq" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="websphere-jmx-connection">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#websphere-prereq" href="#collapse-websphere-jmx-connection" aria-expanded="true" aria-controls="collapse-websphere-jmx-connection"><b>单击以获取有关为 WebSphere Application Server Liberty Profile 配置 JMX 连接的指示信息</b></a>
            </h4>
        </div>

        <div id="collapse-websphere-jmx-connection" class="panel-collapse collapse" role="tabpanel" aria-labelledby="websphere-jmx-connection">
            <div class="panel-body">
                <p>{{ site.data.keys.mf_server }} 需要配置安全的 JMX 连接。</p>

                <ul>
                    <li>Server Configuration Tool 和 Ant 任务可以配置安全的缺省 JMX 连接，该连接包括生成有效期 365 天的自签名 SSL 证书。此配置不适用于生产用途。</li>
                    <li>要为生产用途配置安全的 JMX 连接，请遵循<a href="http://www.ibm.com/support/knowledgecenter/SSD28V_8.5.5/com.ibm.websphere.wlp.core.doc/ae/twlp_admin_restconnector.html?cp=SSD28V_8.5.5&view=embed">配置到 Liberty Profile 的安全 JMX 连接</a>中所述的指示信息。</li>
                    <li>其余的接口可用于 WebSphere Application Server、Liberty Core 以及 Liberty 的其他版本，但是可以将 Liberty 服务器与一部分可用功能部件打包在一起。要验证其余接口功能部件在您的 Liberty 安装中是否可用，请输入以下命令：
{% highlight bash %}                    
liberty_install_dir/bin/productInfo featureInfo
{% endhighlight %}
                    <b>注：</b>验证此命令的输出是否包含 restConnector-1.0。</li>
                </ul>
            </div>
        </div>
    </div>
</div>

### WebSphere Application Server 和 WebSphere Application Server Network Deployment 先决条件
{: #websphere-application-server-and-websphere-application-server-network-deployment-prerequisites }
{{ site.data.keys.mf_server }} 对以下主题中详细介绍的 WebSphere  Application Server 和 WebSphere Application Server Network Deployment 配置有一些要求。  
确保您满足以下条件：

* 使用受支持版本的 WebSphere Application Server。请参阅[系统需求](../../../product-overview/requirements)。
* 必须使用 JRE 7.0 运行应用程序服务器。缺省情况下，WebSphere Application Server 使用 Java 6.0 SDK。要切换到 Java 7.0 SDK，请参阅[在 WebSphere Application Server 中切换到 Java 7.0 SDK](https://www.ibm.com/support/knowledgecenter/SSWLGF_8.5.5/com.ibm.sr.doc/twsr_java17.html)。
* 必须启动管理安全性。{{ site.data.keys.mf_console }}、{{ site.data.keys.mf_server }} 管理服务和 {{ site.data.keys.mf_server }} 配置服务受安全角色保护。有关更多信息，请参阅[启用安全性](https://www.ibm.com/support/knowledgecenter/SSEQTP_8.5.5/com.ibm.websphere.base.doc/ae/tsec_csec2.html?cp=SSEQTP_8.5.5%2F1-8-2-31-0-2&lang=en)。
* 必须启用 JMX 配置，以允许管理服务与运行时组件间进行通信。此通信使用 SOAP。对于 WebSphere Application Server Network Deployment，可使用 RMI。有关更多信息，请参阅下面的**为 WebSphere Application Server 和 WebSphere Application Server Network Deployment 配置 JMX 连接**。

<div class="panel-group accordion" id="websphere-nd-prereq" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="websphere-nd-jmx-connection">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#websphere-nd-prereq" href="#collapse-websphere-nd-jmx-connection" aria-expanded="true" aria-controls="collapse-websphere-nd-jmx-connection"><b>单击以获取有关为 WebSphere Application Server 和 WebSphere Application Server Network Deployment 配置 JMX 连接的指示信息</b></a>
            </h4>
        </div>

        <div id="collapse-websphere-nd-jmx-connection" class="panel-collapse collapse" role="tabpanel" aria-labelledby="websphere-nd-jmx-connection">
            <div class="panel-body">
                <p>{{ site.data.keys.mf_server }} 需要配置安全的 JMX 连接。</p>

                <ul>
                    <li>{{ site.data.keys.mf_server }} 需要访问 SOAP 端口或 RMI 端口以执行 JMX 操作。缺省情况下，SOAP 端口在 WebSphere Application Server 上处于活动状态。缺省情况下，{{ site.data.keys.mf_server }} 使用 SOAP 端口。如果同时取消激活 SOAP 和 RMI 端口，那么 {{ site.data.keys.mf_server }} 将无法运行。</li>
                    <li>RMI 仅受 WebSphere Application Server Network Deployment 支持。独立概要文件或 WebSphere Application Server 服务器场不支持 RMI。</li>
                    <li>必须激活 Administrative 和 Application Security。</li>
                </ul>
            </div>
        </div>
    </div>
</div>

### 文件系统先决条件
{: #file-system-prerequisites }
要将 {{ site.data.keys.mf_server }} 安装到应用程序服务器中，必须由具有特定文件系统特权的用户来运行 {{ site.data.keys.product_adj }} 安装工具。  
安装工具包括：

* IBM Installation Manager
* Server Configuration Tool
* 用于部署 {{ site.data.keys.mf_server }} 的 Ant 任务

对于 WebSphere Application Server Liberty Profile，您必须具有所需的许可权以执行以下操作：

* 读取 Liberty 安装目录中的文件。
* 在 Liberty 服务器的配置目录（通常是 usr/servers/server-name）中创建文件，或创建备份副本并修改 server.xml 和 jvm.options。
* 在 Liberty 共享资源目录（通常是 usr/shared）中创建文件和目录。
* 在 Liberty 服务器 apps 目录（通常是 usr/servers/server-name/apps）中创建文件。

对于 WebSphere Application Server Full Profile 和 WebSphere Application Server Network Deployment，您必须具有所需的许可权来执行以下操作：

* 读取 WebSphere Application Server 安装目录中的文件。
* 读取所选 WebSphere Application Server Full Profile 或 Deployment Manager Profile 的配置文件。
* 运行 wsadmin 命令。
* 在 profiles 配置目录中创建文件。安装工具会将诸如共享库或 JDBC 驱动程序等资源放在该目录中。

对于 Apache Tomcat，您必须具有所需许可权以执行以下操作：

* 读取配置目录。
* 在配置目录中创建备份文件并修改文件（如 server.xml 和 tomcat-users.xml）。
* 在 bin 目录中创建备份文件并修改文件（如 setenv.bat）。
* 在 lib 目录中创建文件。
* 在 webapps 目录中创建文件。

对于所有这些应用程序服务器，运行应用程序服务器的用户必须能够读取由运行 {{ site.data.keys.product_adj }} 安装工具的用户创建的文件。

## 使用 Server Configuration Tool 安装
{: #installing-with-the-server-configuration-tool }
使用 Server Configuration Tool 将 {{ site.data.keys.mf_server }} 组件安装到您的应用程序服务器。

Server Configuration Tool 可以设置数据库并将组件安装到应用程序服务器。该工具旨在用于单个用户。配置文件存储在磁盘中。这些文件的存储目录可以使用菜单**文件 → 首选项**来修改。这些文件一次必须只能由一个 Server Configuration Tool 实例使用。此工具不管理对同一文件的并行访问。如果此工具有多个实例同时访问同一文件，可能会丢失数据。有关该工具如何创建和设置数据库的更多信息，请参阅[使用 Server Configuration Tool 创建数据库表](../databases/#create-the-database-tables-with-the-server-configuration-tool)。如果数据库存在，此工具可以通过测试某些测试表是否存在及其内容可以检测数据库，而不用修改这些数据表。

* [受支持的操作系统](#supported-operating-systems)
* [受支持的拓扑](#supported-topologies)
* [运行 Server Configuration Tool](#running-the-server-configuration-tool)
* [通过使用 Server Configuration Tool 应用修订包](#applying-a-fix-pack-by-using-the-server-configuration-tool)

### 受支持的操作系统
{: #supported-operating-systems }
如果您使用以下操作系统，那么可以使用 Server Configuration Tool：

* Windows x86 或 x86-64
* macOS x86-64
* Linux x86 或 Linux x86-64

该工具不可在其他操作系统上使用。您需要按[使用 Ant 任务进行安装](#installing-with-ant-tasks)中所述，使用 Ant 任务来安装 {{ site.data.keys.mf_server }} 组件。

### 受支持的拓扑
{: #supported-topologies }
Server Configuration Tool 使用以下拓扑安装 {{ site.data.keys.mf_server }} 组件：

* 所有组件（{{ site.data.keys.mf_console }}、{{ site.data.keys.mf_server }} 管理服务、{{ site.data.keys.mf_server }} 实时更新服务和 {{ site.data.keys.product_adj }} 运行时）位于同一个应用程序服务器中。但是，在 WebSphere Application Server Network Deployment 上，当您在集群上进行安装时，可以为管理和实时更新服务以及运行时指定不同的集群。在 Liberty 集合体上，{{ site.data.keys.mf_console }}、管理服务和实时更新服务安装在集合体控制器中，而运行时安装在集合体成员中。
* 如果已安装 {{ site.data.keys.mf_server }} 推送服务，还可以将其安装在同一服务器上。但是，在 WebSphere Application Server Network Deployment 上，当您在集群上进行安装时，可以为推送服务指定其他集群。在 Liberty 集合体上，推送服务安装在 Liberty 成员中，该成员可以与运行时安装所在的成员相同。
* 所有组件均使用相同的数据库系统和用户。对于 DB2，所有组件还使用相同的模式。
* Server Configuration Tool 安装单个服务器的组件，但非对称部署的 Liberty 集合体和 WebSphere Application Server Network Deployment 除外。要在多台服务器上进行安装，必须在运行该工具后配置场。WebSphere Application Server Network Deployment 上不需要服务器场配置。

对于其他拓扑或其他数据库设置，可以改为使用 Ant 任务或手动安装这些组件。

### 运行 Server Configuration Tool
{: #running-the-server-configuration-tool }
在运行 Server Configuration Tool 之前，确保满足以下需求：

* 数据库和组件表已就绪并可供使用。请参阅[设置数据库](../databases)。
* 确定用于安装组件的服务器拓扑。请参阅[拓扑和网络流](../topologies)。
* 已配置应用程序服务器。请参阅[应用程序服务器先决条件](#application-server-prerequisites)。
* 运行此工具的用户具有特定的文件系统权限。请参阅[文件系统先决条件](#file-system-prerequisites)。

<div class="panel-group accordion" id="running-the-configuration-tool" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="configuration-tool">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#running-the-configuration-tool" href="#collapse-configuration-tool" aria-expanded="true" aria-controls="collapse-configuration-tool"><b>单击以获取有关运行配置工具的指示信息</b></a>
            </h4>
        </div>

        <div id="collapse-configuration-tool" class="panel-collapse collapse" role="tabpanel" aria-labelledby="configuration-tool">
            <div class="panel-body">
                <ol>
                    <li>启动 Server Configuration Tool。
                        <ul>
                            <li>在 Linux，通过应用程序快捷方式<b>应用程序 → IBM MobileFirst Platform Server → Server Configuration Tool</b>。</li>
                            <li>在 Windows 上，单击<b>开始 → 程序 → IBM MobileFirst Platform Server → Server Configuration Tool</b>。</li>
                            <li>在 macOS 上，打开 shell 控制台。转至 <b>mfp_server_install_dir/shortcuts</b>，然后输入 <b>./configuration-tool.sh</b>。</li>
                            <li><b>mfp_server_install_dir</b> 是 {{ site.data.keys.mf_server }} 的安装目录。</li>
                        </ul>
                    </li>
                    <li>选择<b>文件 → 新建配置</b>以创建 {{ site.data.keys.mf_server }} 配置。
                        <ul>
                            <li>在<b>配置详细信息</b>面板中，输入管理服务和运行时组件的上下文根。您可能要输入环境标识。高级用例中将使用环境标识，例如，<a href="../topologies/#multiple-instances-of-mobilefirst-server-on-the-same-server-or-websphere-application-server-cell">当在同一应用程序服务器上或同一 WebSphere Application Server 单元上安装 {{ site.data.keys.mf_server }} 时</a>。</li>
                            <li>在<b>控制台设置</b>面板中，选择是否安装 {{ site.data.keys.mf_console }}。如果未安装控制台，需使用命令行工具（<b>mfpdev</b> 或 <b>mfpadm</b>）或 REST API 与 {{ site.data.keys.mf_server }} 管理服务交互。</li>
                            <li>在<b>数据库选择</b>面板中，选择您计划使用的数据库管理系统。所有组件均使用相同的数据库类型和相同的数据库实例。有关数据库窗格的更多信息，请参阅<a href="../databases/#create-the-database-tables-with-the-server-configuration-tool">使用 Server Configuration Tool 创建数据库表</a>。</li>
                            <li>在<b>应用程序服务器选择</b>面板中，选择要部署 {{ site.data.keys.mf_server }} 的应用程序服务器的类型。</li>
                        </ul>
                    </li>
                    <li>在<b>应用程序服务器设置</b>面板中，选择应用程序服务器并完成以下步骤：
                        <ul>
                            <li>要在 WebSphere Application Server Liberty 上进行安装：
                                <ul>
                                    <li>输入 Liberty 的安装目录以及要安装 {{ site.data.keys.mf_server }} 的服务器的名称。</li>
                                    <li>您可以创建登录到控制台的缺省用户。将在 Liberty Basic 注册表中创建该用户。对于生产安装，您可能要清除<b>创建缺省用户</b>选项，并在安装后配置用户访问权。有关更多信息，请参阅<a href="../server-configuration/#configuring-user-authentication-for-mobilefirst-server-administration">配置 {{ site.data.keys.mf_server }} 管理的用户认证</a>。</li>
                                    <li>设置部署类型：<b>独立部署</b>（缺省值）、<b>服务器场部署</b>或 <b>Liberty 集合体部署</b>。</li>
                                </ul>

                                如果选择 Liberty 集合体部署选项，请执行以下步骤：
                                <ul>
                                    <li>指定 Liberty 集合体服务器：
                                        <ul>
                                            <li>安装管理服务、{{ site.data.keys.mf_console }} 和实时更新服务的集群。服务器必须是 Liberty 集合体控制器。</li>
                                            <li>安装运行时的集群。服务器必须是 Liberty 集合体成员。</li>
                                            <li>安装推送服务的集群。服务器必须是 Liberty 集合体成员。</li>
                                        </ul>
                                    </li>
                                    <li>输入成员的服务器标识。对于集合体中的每个成员，该标识必须不同。</li>
                                    <li>输入集合体成员的集群名称。</li>
                                    <li>输入控制器主机名和 HTTPS 端口号。这些值必须与 Liberty 集合体控制器的 <b>server.xml</b> 文件的 <code>variable</code> 元素中定义的值相同。</li>
                                    <li>输入控制器管理员用户名和密码。</li>
                                </ul>
                            </li>
                            <li>要在 WebSphere Application Server 或 WebSphere Application Server Network Deployment 上进行安装：
			    <ul>
                                    <li>输入 WebSphere Application Server 的安装目录。</li>
                                    <li>选择要安装 {{ site.data.keys.mf_server }} 的 WebSphere Application Server 概要文件。如果要在 WebSphere Application Server Network Deployment 上进行安装，请选择 Deployment Manager 的概要文件。在 Deployment Manager 概要文件上，可选择某一范围（<b>服务器</b>或<b>集群</b>）。如选择<b>集群</b>，那么必须指定：
				    <ul>
                                            <li>安装运行时的集群。</li>
                                            <li>安装管理服务、{{ site.data.keys.mf_console }} 和实时更新服务的集群。</li>
                                            <li>安装推送服务的集群。</li>
                                        </ul>
                                    </li>
                                    <li>输入管理员登录标识和密码。管理员用户必须具有管理员角色。</li>
                                    <li>如果选择<b>将 WebSphere 管理员声明为 {{ site.data.keys.mf_console }} 中的管理员用户</b>选项，那么用于安装 {{ site.data.keys.mf_server }} 的用户将映射到控制台的管理安全角色，并可以使用管理员权限登录到控制台。该用户还将映射到实时更新服务的安全角色。用户名和密码设置为管理服务的 JNDI 属性（<b>mfp.config.service.user</b> 和 <b>mfp.config.service.password</b>）。</li>
                                    <li>如果未选择<b>将 WebSphere 管理员声明为 {{ site.data.keys.mf_console }} 中的管理员用户</b>选项，那么必须完成以下任务才能使用 {{ site.data.keys.mf_server }}：
				    <ul>
                                            <li>通过以下方式启用管理服务与实时更新服务间的通信：
					    <ul>
                                                    <li>将用户映射到实时更新服务的安全角色 <b>configadmin</b>。</li>
                                                    <li>在管理服务的 JNDI 属性（<b>mfp.config.service.user</b> 和 <b>mfp.config.service.password</b>）中添加该用户的登录标识和密码。</li>
                                                    <li>将一个或多个用户映射到管理服务和 {{ site.data.keys.mf_console }} 的安全角色。请参阅<a href="../server-configuration/#configuring-user-authentication-for-mobilefirst-server-administration">为 {{ site.data.keys.mf_server }} 管理配置用户认证</a>。</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                </ul>
                            </li>
                            <li>要在 Apache Tomcat 上进行安装：
			    <ul>
                                    <li>输入 Apache Tomcat 的安装目录。</li>
                                    <li>输入用于 JMX 与 RMI 通信的端口。缺省情况下，该值为 8686。Server Configuration Tool 修改 <b>tomcat_install_dir/bin/setenv.bat</b> 或 <b>tomcat_install_dir/bin/setenv.sh</b> 文件来打开此端口。如果要手动打开此端口，或使用在 <b>setenv.bat</b> 或 <b>setenv.sh</b> 中打开此端口的一些代码，请不要使用此工具。请改为使用 Ant 任务进行安装。提供了一个手动打开 RMI 端口的选项，以使用 Ant 任务进行安装。</li>
                                    <li>创建登录到控制台的缺省用户。还将在 <b>tomcat-users.xml</b> 配置文件中创建该用户。对于生产安装，您可能要清除创建缺省用户选项，并在安装后配置用户访问权。有关更多信息，请参阅<a href="../server-configuration/#configuring-user-authentication-for-mobilefirst-server-administration">配置 {{ site.data.keys.mf_server }} 管理的用户认证</a>。</li>
                                </ul>
                            </li>
                        </ul>
                    </li>
                    <li>在<b>推送服务设置</b>面板中，如果要在应用程序服务器中安装推送服务，请选中<b>安装推送服务</b>选项。上下文根为 <b>imfpush</b>。要启用推送服务与管理服务间的通信，需定义以下参数：
		    <ul>
                            <li>输入推送服务的 URL 和运行时的 URL。如果在 Liberty、Apache Tomcat 或独立 WebSphere Application Server 上进行安装，可自动计算此 URL。它使用本地服务器上的组件（运行时或推送服务）的 URL。如果在 WebSphere Application Server Network Deployment 上进行安装，或通过 Web 代理或负载均衡器进行通信，那么必须手动输入 URL。</li>
                            <li>输入用于服务之间 OAuth 通信的保密客户机标识和密码。否则，该工具会生成缺省值和随机密码。</li>
                        </ul>
                    </li>
                    <li>在<b>分析设置</b>面板中，如果已安装 {{ site.data.keys.mf_analytics }}，请选中<b>连接到分析服务器</b>。输入以下连接设置：
		    <ul>
                            <li>分析控制台的 URL。</li>
                            <li>分析服务器（分析数据服务）的 URL。</li>
                            <li>允许向分析服务器发布数据的用户登录标识和密码。</li>
                        </ul>

                        该工具可配置运行时和推送服务以向分析服务器发送数据。</li>
                    <li>单击<b>部署</b>以继续进行安装。</li>
                </ol>
            </div>
        </div>
    </div>
</div>

成功完成安装后，如果是 Apache Tomcat 或 Liberty 概要文件，那么重新启动应用程序服务器。

如果作为服务启动 Apache Tomcat，那么可能不会读取包含用于打开 RMI 的语句的 setenv.bat 或 setenv.sh 文件。
因此，{{ site.data.keys.mf_server }} 可能无法正常工作。要设置所需的变量，请参阅[为 Apache Tomcat 配置 JMX 连接](#apache-tomcat-prerequisites)。

在 WebSphere Application Server Network Deployment 上，已安装应用程序，但未启动。您需要手动启动。您可以从 WebSphere Application Server 管理控制台完成此操作。

将配置文件保存在 Server Configuration Tool 中。您可能会重新使用它来安装临时修订。应用临时修订的菜单为**配置>替换部署的 WAR 文件**。

### 通过使用 Server Configuration Tool 应用修订包
{: #applying-a-fix-pack-by-using-the-server-configuration-tool }
如果已使用该配置工具安装 {{ site.data.keys.mf_server }} 并且保留了配置文件，那么可以复用该配置文件来应用修订包或临时修订。

1. 启动 Server Configuration Tool。
    * 在 Linux，通过应用程序快捷方式**应用程序 → IBM MobileFirst Platform Server → Server Configuration Tool**。
    * 在 Windows 上，单击**开始 → 程序 → IBM MobileFirst Platform Server → Server Configuration Tool**。
    * 在 macOS 上，打开 shell 控制台。转至 **mfp\_server\_install_dir/shortcuts**，然后输入 **./configuration-tool.sh**。
    * **mfp\_server\_install\_dir** 是 {{ site.data.keys.mf_server }} 的安装目录。

2. 单击**配置 → 替换已部署的 WAR 文件**，然后选择现有配置来应用修订包或临时修订。

## 使用 Ant 任务安装
{: #installing-with-ant-tasks }
使用 Ant 任务将 {{ site.data.keys.mf_server }} 组件安装到应用程序服务器上。

您可以在 **mfp\_install\_dir/MobileFirstServer/configuration-samples 目录**中查找用于安装 {{ site.data.keys.mf_server }} 的样本配置文件。

您也可以使用 Server Configuration Tool 创建配置，然后通过使用**文件 → 将配置导出为 Ant 文件...**来导出 Ant 文件。样本 Ant 文件具有与 Server Configuration Tool 相同的限制：

* 所有组件（{{ site.data.keys.mf_console }}、{{ site.data.keys.mf_server }} 管理服务、{{ site.data.keys.mf_server }} 实时更新服务、{{ site.data.keys.mf_server }} 工件和 {{ site.data.keys.product_adj }} 运行时）均在同一个应用程序服务器中。但是，在 WebSphere Application Server Network Deployment 上，当您在集群上进行安装时，可以为管理和实时更新服务以及运行时指定不同的集群。
* 如果已安装 {{ site.data.keys.mf_server }} 推送服务，还可以将其安装在同一服务器上。但是，在 WebSphere Application Server Network Deployment 上，当您在集群上进行安装时，可以为推送服务指定其他集群。
* 所有组件均使用相同的数据库系统和用户。对于 DB2，所有组件还使用相同的模式。
* Server Configuration Tool 为单个服务器安装组件。要在多台服务器上进行安装，必须在运行该工具后配置场。WebSphere Application Server Network Deployment 上不支持服务器场配置。

您可以使用 Ant 任务将 {{ site.data.keys.mf_server }} 服务配置为在服务器场中运行。要在场中包含您的服务器，需要指定某些特定属性，这些属性相应配置应用程序服务器。有关使用 Ant 任务配置服务器场的更多信息，请参阅[使用 Ant 任务安装服务器场](#installing-a-server-farm-with-ant-tasks)。

对于[拓扑和网络流](../topologies)中支持的其他拓扑，可以修改样本 Ant 文件。

对 Ant 任务的引用如下所示：

* [用于安装 {{ site.data.keys.mf_console }}、{{ site.data.keys.mf_server }} 工件、{{ site.data.keys.mf_server }} 管理和实时更新服务的 Ant 任务](../installation-reference/#ant-tasks-for-installation-of-mobilefirst-operations-console-mobilefirst-server-artifacts-mobilefirst-server-administration-and-live-update-services)
* [用于安装 {{ site.data.keys.mf_server }} 推送服务的 Ant 任务](../installation-reference/#ant-tasks-for-installation-of-mobilefirst-server-push-service)
* [用于安装 {{ site.data.keys.product_adj }} 运行时环境的 Ant 任务](../installation-reference/#ant-tasks-for-installation-of-mobilefirst-runtime-environments)

要了解使用样本配置文件和任务进行安装的概述，请参阅[以命令行方式安装 {{ site.data.keys.mf_server }}](../tutorials/command-line)。

您可以使用作为产品安装的一部分的 Ant 分发版来运行 Ant 文件。例如，如果您有 WebSphere Application Server Network Deployment 集群，且数据库是 IBM DB2，那么您可以使用 **mfp\_install\_dir/MobileFirstServer/configuration-samples/configure-wasnd-cluster-db2.xml** Ant 文件。在编辑文件并输入所有必需属性之后，可以从 **mfp\_install\_dir/MobileFirstServer/configuration-samples** 目录运行以下命令：

* **mfp\_install\_dir/shortcuts/ant -f configure-wasnd-cluster-db2.xml help** - 此命令显示安装、卸载或更新某些组件的 Ant 文件的所有可能的目标列表。
* **mfp\_install\_dir/shortcuts/ant -f configure-wasnd-cluster-db2.xml install**  - 此命令使用在 Ant 文件属性中输入的参数，在 WebSphere Application Server Network Deployment 集群上安装 {{ site.data.keys.mf_server }}（使用 DB2 作为数据源）。

<br/>
安装后，请复制 Ant 文件，使您能够复用它来应用修订包。

### 使用 Ant 文件应用修订包
{: #applying-a-fix-pack-by-using-the-ant-files }

#### 使用样本 Ant 文件更新
{: #updating-with-the-sample-ant-file }
如果使用 **mfp\_install\_dir/MobileFirstServer/configuration-samples** 目录中提供的样本 Ant 文件安装 {{ site.data.keys.mf_server }}，那么可以复用此 Ant 文件副本来应用修订包。对于密码值，可以输入运行 Ant 文件时交互提示的 12 个星号 (\*)，而非实际值。

1. 验证 Ant 文件中 **mfp.server.install.dir** 属性的值。它必须指向包含应用修订包的产品的目录。将使用此值提取更新的 {{ site.data.keys.mf_server }} WAR 文件。
2. 运行命令： `mfp_install_dir/shortcuts/ant -f your_ant_file update`

#### 使用自己的 Ant 文件更新
{: #updating-with-own-ant-file }
如果使用您自己的 Ant 文件，请确保对于每项安装任务（**installmobilefirstadmin**、**installmobilefirstruntime** 和 **installmobilefirstpush**），您都在具有相同参数的 Ant 文件中拥有相应的更新任务。相应的更新任务有 **updatemobilefirstadmin**、**updatemobilefirstruntime** 和 **updatemobilefirstpush**。

1. 验证 **mfp-ant-deployer.jar** 文件的 **taskdef** 元素的类路径。它必须指向应用修订包的 {{ site.data.keys.mf_server }} 安装中的 **mfp-ant-deployer.jar** 文件。缺省情况下，将从 **mfp-ant-deployer.jar** 位置提取更新的 {{ site.data.keys.mf_server }} WAR 文件。
2. 运行 Ant 文件的更新任务（**updatemobilefirstadmin**、**updatemobilefirstruntime** 和 **updatemobilefirstpush**）。

### 修改样本 Ant 文件
{: #sample-ant-files-modifications }
您可以修改 **mfp\_install\_dir/MobileFirstServer/configuration-samples** 目录中提供的样本 Ant 文件，以适应您的安装需求。  
以下部分提供了有关可如何修改样本 Ant 文件使安装过程适应您的需求的详细信息：

1. [指定额外的 JNDI 属性](#specify-extra-jndi-properties)
2. [指定现有用户](#specify-existing-users)
3. [指定 Liberty Java EE 级别](#specify-liberty-java-ee-level)
4. [指定数据源 JDBC 属性](#specify-data-source-jdbc-properties)
5. [在未安装 {{ site.data.keys.mf_server }} 的计算机上运行 Ant 文件](#run-the-ant-files-on-a-computer-where-mobilefirst-server-is-not-installed)
6. [指定 WebSphere Application Server Network Deployment 目标](#specify-websphere-application-server-network-deployment-targets)
7. [在 Apache Tomcat 上手动配置 RMI 端口](#manual-configuration-of-the-rmi-port-on-apache-tomcat)

#### 指定额外的 JNDI 属性
{: #specify-extra-jndi-properties }
**installmobilefirstadmin**、**installmobilefirstruntime** 和**installmobilefirstpush** Ant 任务声明组件运作所需的 JNDI 属性的值。这些 JNDI 属性用于定义 JMX 通信，以及指向其他组件（例如，实时更新服务、推送服务、分析服务或授权服务器）的链接。但是，还可以定义其他 JNDI 属性的值。使用针对这三项任务存在的 `<property>` 元素。有关 JNDI 属性的列表，请参阅：

* [{{ site.data.keys.mf_server }} 管理服务的 JNDI 属性列表](../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service)
* [{{ site.data.keys.mf_server }} 推送服务的 JNDI 属性列表](../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service)
* [{{ site.data.keys.product_adj }} 运行时的 JNDI 属性列表](../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime)

例如：

```xml
<installmobilefirstadmin ..>
    <property name="mfp.admin.actions.prepareTimeout" value="3000000"/>
</installmobilefirstadmin> 
```

#### 指定现有用户
{: #specify-existing-users }
缺省情况下，**installmobilefirstadmin** Ant 任务将：

* 在 WebSphere Application Server Liberty 上为 JMX 通信定义 Liberty 管理员。
* 在任何应用程序服务器上创建用户，以定义用于与实时更新服务通信的用户。

要使用现有用户（而不创建新用户），可完成以下操作：

1. 在 `<jmx>` 元素中，指定用户和密码，然后将 **createLibertyAdmin** 属性的值设置为 false。例如：

   ```xml
   <installmobilefirstadmin ...>
       <jmx libertyAdminUser="myUser" libertyAdminPassword="password" createLibertyAdmin="false" />
       ...
   ```

2. 在 `<configuration>` 元素中，指定用户和密码，然后将 **createConfigAdminUser** 属性的值设置为 false。例如：

   ```xml
    <installmobilefirstadmin ...>
        <configuration configAdminUser="myUser" configAdminPassword="password" createConfigAdminUser="false" />
        ...
   ```

此外，样本 Ant 文件创建的用户还将映射到管理服务和控制台的安全角色。使用此设置，可在安装后使用该用户登录到 {{ site.data.keys.mf_server }}。要更改此行为，请从样本 Ant 文件中除去 `<user>` 元素。或者，可从 `<user>` 元素中除去 **password** 属性，并且应用程序服务器的本地注册表中将不会创建用户。

#### 指定 Liberty Java EE 级别
{: #specify-liberty-java-ee-level }
某些 WebSphere Application Server Liberty 的分发版支持 Java EE 6 或 Java EE 7 的功能部件。缺省情况下，Ant 任务会自动检测要安装的功能部件。例如，将为 Java EE 6 安装 **jdbc-4.0** Liberty 功能部件，并针对 Java EE 7 安装 **jdbc-4.1** 功能部件。如果 Liberty 安装支持 Java EE 6 和 Java EE 7 的功能部件，那么您可能要强制使用特定级别的功能部件。例如，您计划在同一 Liberty 服务器上同时运行 {{ site.data.keys.mf_server }} V8.0.0 和 V7.1.0。 {{ site.data.keys.mf_server }} V7.1.0 或更低版本仅支持 Java EE 6 功能部件。

要强制使用特定级别的 Java EE 6 功能部件，请使用 `<websphereapplicationserver>` 元素的 jeeversion 属性。例如：

```xml
<installmobilefirstadmin execute="${mfp.process.admin}" contextroot="${mfp.admin.contextroot}">
    [...]
    <applicationserver>
      <websphereapplicationserver installdir="${appserver.was.installdir}"
        profile="Liberty" jeeversion="6">
```

#### 指定数据源 JDBC 属性
{: #specify-data-source-jdbc-properties }
您可以指定 JDBC 连接的属性。使用 `<database>` 元素的 `<property>` 元素。**configureDatabase**、**installmobilefirstadmin**、**installmobilefirstruntime** 和 **installmobilefirstpush** Ant 任务中可使用该元素。例如：

```xml
<configuredatabase kind="MobileFirstAdmin">
    <db2 database="${database.db2.mfpadmin.dbname}"
        server="${database.db2.host}"
        instance="${database.db2.instance}"
        user="${database.db2.mfpadmin.username}"
        port= "${database.db2.port}"
        schema = "${database.db2.mfpadmin.schema}"
        password="${database.db2.mfpadmin.password}">

       <property name="commandTimeout" value="10"/>
    </db2>
```

#### 在未安装 {{ site.data.keys.mf_server }} 的计算机上运行 Ant 文件
{: #run-the-ant-files-on-a-computer-where-mobilefirst-server-is-not-installed }
要在未安装 {{ site.data.keys.mf_server }} 的计算机上运行 Ant 任务，需执行以下操作：

* 安装 Ant
* 将 **mfp-ant-deployer.jar** 文件复制到远程计算机上。此库包含 Ant 任务的定义。
* 指定要安装的资源。缺省情况下，会在 **mfp-ant-deployer.jar** 附近提取 WAR 文件，但可以指定这些 WAR 文件的位置。例如：

```xml
<installmobilefirstadmin execute="true" contextroot="/mfpadmin" serviceWAR="/usr/mfp/mfp-admin-service.war">
  <console install="true" warFile="/usr/mfp/mfp-admin-ui.war"/>
```

有关更多信息，请参阅[安装参考](../installation-reference)中用于安装每个 {{ site.data.keys.mf_server }} 组件的 Ant 任务。

#### 指定 WebSphere Application Server Network Deployment 目标
{: #specify-websphere-application-server-network-deployment-targets }
要在 WebSphere Application Server Network Deployment 上进行安装，指定的 WebSphere Application Server 概要文件必须是 Deployment Manager. 您可以基于以下配置进行部署：

* 集群
* 单台服务器
* 单元（单元的所有服务器）
* 节点（节点的所有服务器）

诸如 **configure-wasnd-cluster-dbms-name.xml**、**configure-wasnd-server-dbms-name.xml** 和 **configure-wasnd-node-dbms-name.xml** 等样本文件均包含要在每一类目标上部署的声明。有关更多信息，请参阅[安装参考](../installation-reference)中用于安装每个 {{ site.data.keys.mf_server }} 组件的 Ant 任务。

> 注：自 V8.0.0 起，将不再提供 WebSphere Application Server Network Deployment 单元的样本配置文件。


#### 在 Apache Tomcat 上手动配置 RMI 端口
{: #manual-configuration-of-the-rmi-port-on-apache-tomcat }
缺省情况下，Ant 任务会修改 **setenv.bat** 文件或 **setenv.sh** 文件以打开 RMI 端口。如果您喜欢手动打开 RMI 端口，请将值为 false 的 **tomcatSetEnvConfig** 属性添加到 **installmobilefirstadmin**、**updatemobilefirstadmin** 和 **uninstallmobilefirstadmin** 任务的 `<jmx>` 元素。

## 手动安装 {{ site.data.keys.mf_server }} 组件
{: #installing-the-mobilefirst-server-components-manually }
您还可以手动将 {{ site.data.keys.mf_server }} 组件安装到应用程序服务器。  
以下主题为您提供了完整的信息，指导您完成在生产中的受支持应用程序上安装组件的过程。

* [在 WebSphere Application Server Liberty 上手动安装](#manual-installation-on-websphere-application-server-liberty)
* [在 WebSphere Application Server Liberty 集合体上手动安装](#manual-installation-on-websphere-application-server-liberty-collective)
* [在 Apache Tomcat 上手动安装](#manual-installation-on-apache-tomcat)
* [在 WebSphere Application Server 和 WebSphere Application Server Network Deployment 上手动安装](#manual-installation-on-websphere-application-server-and-websphere-application-server-network-deployment)

### 在 WebSphere Application Server Liberty 上手动安装
{: #manual-installation-on-websphere-application-server-liberty }
确保您同样满足 [WebSphere Application Server Liberty 先决条件](#websphere-application-server-liberty-prerequisites)中记录的需求。

* [拓扑约束](#topology-constraints)
* [应用程序服务器设置](#application-server-settings)
* [{{ site.data.keys.mf_server }} 应用程序所需的 Liberty 功能](#liberty-features-required-by-the-mobilefirst-server-applications)
* [全局 JNDI 条目](#global-jndi-entries)
* [类装入器](#class-loader)
* [密码解码器用户功能](#password-decoder-user-feature)
* [配置详细信息](#configuration-details-liberty)

#### 拓扑约束
{: #topology-constraints }
必须在同一应用程序服务器上安装 {{ site.data.keys.mf_server }} 管理服务、{{ site.data.keys.mf_server }} 实时更新服务和 MobileFirst 运行时。必须将实时更新服务的上下文根定义为 **the-adminContextRootconfig**。推送服务的上下文根必须为 **imfpush**。有关约束的更多信息，请参阅[有关 {{ site.data.keys.mf_server }} 组件和 {{ site.data.keys.mf_analytics }} 的约束](../topologies/#constraints-on-the-mobilefirst-server-components-and-mobilefirst-analytics)。

#### 应用程序服务器设置
{: #application-server-settings }
必须配置 **webContainer** 元素以立即装入 servlet。需要此设置来通过 JMX 进行初始化。例如：`<webContainer deferServletLoad="false"/>`。

（可选）为避免发生某些 Liberty 版本上运行时和管理服务的启动顺序被破坏的超时问题，请更改缺省 **executor** 元素。将 **coreThreads** 和 **maxThreads** 属性设置为较大的值。例如：

```xml
<executor id="default" name="LargeThreadPool"
  coreThreads="200" maxThreads="400" keepAlive="60s"
  stealPolicy="STRICT" rejectedWorkPolicy="CALLER_RUNS"/>
```

您还可以配置 **tcpOptions** 元素，并将 **soReuseAddr** 属性设置为 `true`：`<tcpOptions soReuseAddr="true"/>`。

#### {{ site.data.keys.mf_server }} 应用程序所需的 Liberty 功能
{: #liberty-features-required-by-the-mobilefirst-server-applications }
您可以针对 Java EE6 或 Java EE 7 使用以下功能。

**{{ site.data.keys.mf_server }} 管理服务**

* **jdbc-4.0**（对于 Java EE 7，为 jdbc-4.1）
* **appSecurity-2.0**
* **restConnector-1.0**
* **usr:MFPDecoderFeature-1.0**

**{{ site.data.keys.mf_server }} 推送服务**  

* **jdbc-4.0**（对于 Java EE 7，为 jdbc-4.1）
* **servlet-3.0**（对于 Java EE 7，为 servlet-3.1）
* **ssl-1.0**
* **usr:MFPDecoderFeature-1.0**

**{{ site.data.keys.product_adj }} 运行时**  

* **jdbc-4.0**（对于 Java EE 7，为 jdbc-4.1）
* **servlet-3.0**（对于 Java EE 7，为 servlet-3.1）
* **ssl-1.0**
* **usr:MFPDecoderFeature-1.0**

#### 全局 JNDI 条目
{: #global-jndi-entries }
需要以下全局 JNDI 条目，以在运行时与管理服务间配置 JMX 通信：

* **mfp.admin.jmx.host**
* **mfp.admin.jmx.port**
* **mfp.admin.jmx.user**
* **mfp.admin.jmx.pwd**
* **mfp.topology.platform**
* **mfp.topology.clustermode**

将使用此语法设置这些全局 JNDI 条目且前缀非上下文根。例如：`<jndiEntry jndiName="mfp.admin.jmx.port" value="9443"/>`。

> **注：**为防止自动转换 JNDI 值，以便不会将 075 转换为 61，或不会将 31.500 转换为 31.5，请在定义值时使用此语法 '"075"'。

有关管理服务的 JNDI 属性的更多信息，请参阅[{{ site.data.keys.mf_server }} 管理服务的 JNDI 属性列表](../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service)。  

有关场配置信息，另请参阅以下主题：

* [服务器场拓扑](../topologies/#server-farm-topology)
* [拓扑和网络流](../topologies)
* [安装服务器场](#installing-a-server-farm)

#### 类装入器
{: #class-loader }
对于所有应用程序，类装入器必须使用父代最后的授权。例如：

```xml
<application id="mfpadmin" name="mfpadmin" location="mfp-admin-service.war" type="war">
  [...]
  <classloader delegation="parentLast">
  </classloader>
</application>
```

#### 密码解码器用户功能
{: #password-decoder-user-feature }
将密码解码器用户功能复制到您的 Liberty 概要文件。例如：

* 在 UNIX 和 Linux 系统上：

  ```bash
  mkdir -p LIBERTY_HOME/wlp/usr/extension/lib/features
  cp product_install_dir/features/com.ibm.websphere.crypto_1.0.0.jar LIBERTY_HOME/wlp/usr/extension/lib/
  cp product_install_dir/features/MFPDecoderFeature-1.0.mf LIBERTY_HOME/wlp/usr/extension/lib/features/
  ```

* 在 Windows 系统上：

  ```bash
  mkdir LIBERTY_HOME\wlp\usr\extension\lib
  copy /B product_install_dir\features\com.ibm.websphere.crypto_1.0.0.jar
  LIBERTY_HOME\wlp\usr\extension\lib\com.ibm.websphere.crypto_1.0.0.jar
  mkdir LIBERTY_HOME\wlp\usr\extension\lib\features
  copy /B product_install_dir\features\MFPDecoderFeature-1.0.mf
  LIBERTY_HOME\wlp\usr\extension\lib\features\MFPDecoderFeature-1.0.mf
  ```

#### 配置详细信息
{: #configuration-details-liberty }
<div class="panel-group accordion" id="manual-installation-liberty" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="admin-service">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty" href="#collapse-admin-service" aria-expanded="true" aria-controls="collapse-admin-service"><b>{{ site.data.keys.mf_server }} 管理服务配置详细信息</b></a>
            </h4>
        </div>

        <div id="collapse-admin-service" class="panel-collapse collapse" role="tabpanel" aria-labelledby="admin-service">
            <div class="panel-body">
                <p>管理服务打包为 WAR 应用程序，供您部署到应用程序服务器。您需要在 <b>server.xml</b> 文件中对此应用程序进行一些具体配置。管理服务 WAR 文件位于 <b>mfp_install_dir/MobileFirstServer/mfp-admin-service.war</b>。您可以根据需要定义上下文根。但是，它通常为 <b>/mfpadmin</b>。</p>

                <h3>必需的 JNDI 属性</h3>
                <p>定义 JNDI 属性时，JNDI 名称必须使用管理服务的上下文根作为前缀。以下示例说明声明 <b>mfp.admin.push.url</b> 的情况，此时使用 <b>/mfpadmin</b> 作为上下文根来安装管理服务：</p>
{% highlight xml %}
<jndiEntry jndiName="mfpadmin/mfp.admin.push.url" value="http://localhost:9080/imfpush"/>
{% endhighlight %}

                <p>如果已安装推送服务，那么必须配置以下 JNDI 属性：</p>
                <ul>
                    <li><b>mfp.admin.push.url</b></li>
                    <li><b>mfp.admin.authorization.server.url</b></li>
                    <li><b>mfp.push.authorization.client.id</b></li>
                    <li><b>mfp.push.authorization.client.secret</b></li>
                    <li><b>mfp.admin.authorization.client.id</b></li>
                    <li><b>mfp.admin.authorization.client.secret</b></li>
                </ul>
                <p>用于与配置服务通信的 JNDI 属性如下：</p>
                <ul>
                    <li><b>mfp.config.service.user</b></li>
                    <li><b>mfp.config.service.password</b></li>
                </ul>
                <p>有关 JNDI 属性的更多信息，请参阅<a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service">{{ site.data.keys.mf_server }} 管理服务的 JNDI 属性列表</a>。</p>

                <h3>数据源</h3>
                <p>管理服务的数据源的 JNDI 名称必须定义为 <b>jndiName=the-contextRoot/jdbc/mfpAdminDS</b>。以下示例说明使用上下文根 <b>/mfpadmin</b> 安装管理服务，且该服务使用关系数据库的情况：</p>

{% highlight xml %}
<dataSource jndiName="mfpadmin/jdbc/mfpAdminDS" transactional="false">
  [...]
</dataSource>
{% endhighlight %}

                <h3></h3>
                <p>在应用程序的 <b>application-bnd</b> 元素中声明以下角色：</p>
                <ul>
                    <li>mfpadmin</li>
                    <li>mfpdeployer</li>
                    <li>mfpmonitor</li>
                    <li>mfpoperator</li>
                </ul>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="live-update-service">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty" href="#collapse-live-update-service" aria-expanded="true" aria-controls="collapse-live-update-service"><b>{{ site.data.keys.mf_server }} 实时更新服务配置详细信息</b></a>
            </h4>
        </div>

        <div id="collapse-live-update-service" class="panel-collapse collapse" role="tabpanel" aria-labelledby="live-update-service">
            <div class="panel-body">
                <p>实时更新服务打包为一个 WAR 应用程序，供您部署到应用程序服务器。您需要在 <b>server.xml</b> 文件中对此应用程序进行一些具体配置。在继续操作之前，请查看<a href="#manual-installation-on-websphere-application-server-liberty">在 WebSphere Application Server Liberty 上进行手动安装</a>，以了解对所有服务通用的配置详细信息。</p>

                <p>实时更新服务 WAR 文件位于 <b>mfp_install_dir/MobileFirstServer/mfp-live-update.war</b> 中。必须按以下方式定义实时更新服务的上下文根：<b>/the-adminContextRootconfig</b>。例如，如果管理服务的上下文根为 <b>/mfpadmin</b>，那么实时更新服务的上下文根必须为 <b>/mfpadminconfig</b>。</p>

                <h3>数据源</h3>
                <p>实时更新服务的数据源的 JNDI 名称必须定义为 the-contextRoot/jdbc/ConfigDS。以下示例说明使用上下文根 /mfpadminconfig 安装实时更新服务，且该服务使用关系数据库的情况：</p>

{% highlight xml %}
<dataSource jndiName="mfpadminconfig/jdbc/ConfigDS" transactional="false">
  [...]
</dataSource>
{% endhighlight %}

                <h3></h3>
                <p>在应用程序的 <b>application-bnd</b> 元素中声明 configadmin 角色。必须将至少一个用户映射至此角色。必须为管理服务的以下 JNDI 属性提供用户及其密码：</p>

                <ul>
                    <li><b>mfp.config.service.user</b></li>
                    <li><b>mfp.config.service.password</b></li>
                </ul>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="console-configuration">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty" href="#collapse-console-configuration" aria-expanded="true" aria-controls="collapse-console-configuration"><b>{{ site.data.keys.mf_console }} 配置详细信息</b></a>
            </h4>
        </div>

        <div id="collapse-console-configuration" class="panel-collapse collapse" role="tabpanel" aria-labelledby="console-configuration">
            <div class="panel-body">
                <p>控制台打包为一个 WAR 应用程序，供您部署到应用程序服务器。您需要在 <b>server.xml</b> 文件中对此应用程序进行一些具体配置。在继续操作之前，请查看<a href="#manual-installation-on-websphere-application-server-liberty">在 WebSphere Application Server Liberty 上进行手动安装</a>，以了解对所有服务通用的配置详细信息。</p>

                <p>控制台 WAR 文件位于 <b>mfp_install_dir/MobileFirstServer/mfp-admin-ui.war</b>。您可以根据需要定义上下文根。但通常上下文根为 <b>/mfpconsole</b>。</p>

                <h3>必需的 JNDI 属性</h3>
                <p>定义 JNDI 属性时，必须使用控制台的上下文根作为 JNDI 名称的前缀。以下示例显示了声明 <b>mfp.admin.endpoint</b> 而安装的控制台使用 <b>/mfpconsole</b> 作为上下文根的情况。</p>

{% highlight xml %}
<jndiEntry jndiName="mfpconsole/mfp.admin.endpoint" value="*://*:*/mfpadmin"/>
{% endhighlight %}

                <p>mfp.admin.endpoint 属性的典型值是 <b>*://*:*/the-adminContextRoot</b>。<br/>
                有关 JNDI 属性的完整列表，请参阅 <a href="../server-configuration/#jndi-properties-for-mobilefirst-operations-console">{{ site.data.keys.mf_console }} 的 JNDI 属性</a>。</p>

                <h3>安全角色</h3>
                <p>在应用程序的 <b>application-bnd</b> 元素中声明以下角色：</p>
                <ul>
                    <li><b>mfpadmin</b></li>
                    <li><b>mfpdeployer</b></li>
                    <li><b>mfpmonitor</b></li>
                    <li><b>mfpoperator</b></li>
                </ul>
                映射到控制台的安全角色的任何用户还必须同时映射到管理服务的相同安全角色。
		</div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="runtime-configuration">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty" href="#collapse-runtime-configuration" aria-expanded="true" aria-controls="collapse-runtime-configuration"><b>MobileFirst 运行时配置详细信息</b></a>
            </h4>
        </div>

        <div id="collapse-runtime-configuration" class="panel-collapse collapse" role="tabpanel" aria-labelledby="runtime-configuration">
            <div class="panel-body">
                <p>运行时打包为一个 WAR 应用程序，供您部署到应用程序服务器。您需要在 <b>server.xml</b> 文件中对此应用程序进行一些具体配置。在继续操作之前，请查看<a href="#manual-installation-on-websphere-application-server-liberty">在 WebSphere Application Server Liberty 上进行手动安装</a>，以了解对所有服务通用的配置详细信息。</p>

                <p>运行时 WAR 文件位于 <b>mfp_install_dir/MobileFirstServer/mfp-server.war</b> 中。您可以根据需要定义上下文根。但是，缺省情况下为 <b>/mfp</b>。</p>

                <h3>必需的 JNDI 属性</h3>
                <p>定义 JNDI 属性时，JNDI 名称必须使用运行时的上下文根作为前缀。以下示例说明声明 <b>mfp.analytics.url</b> 的情况，此时使用 <b>/mobilefirst</b> 作为上下文根来安装运行时：</p>

{% highlight xml %}
<jndiEntry jndiName="mobilefirst/mfp.analytics.url" value="http://localhost:9080/analytics-service/rest"/>
{% endhighlight %}

                                <p>必须定义 <b>mobilefirst/mfp.authorization.server</b> 属性。例如：</p>
{% highlight xml %}
<jndiEntry jndiName="mobilefirst/mfp.authorization.server" value="embedded"/>
{% endhighlight %}

                <p>如果已安装 {{ site.data.keys.mf_analytics }}，那么需要定义以下 JNDI 属性：</p>
                <ul>   
                    <li><b>mfp.analytics.url</b></li>
                    <li><b>mfp.analytics.console.url</b></li>
                    <li><b>mfp.analytics.username</b></li>
                    <li><b>mfp.analytics.password</b></li>
                </ul>

                <p>有关 JNDI 属性的更多信息，请参阅 <a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime">{{ site.data.keys.product_adj }} 运行时的 JNDI 属性列表</a>。</p>

                <h3>数据源</h3>
                <p>必须将运行时的数据源的 JNDI 名称定义为 <b>jndiName=the-contextRoot/jdbc/mfpDS</b>。以下示例说明使用上下文根 <b>/mobilefirst</b> 安装运行时，且运行时使用关系数据库的情况：</p>

{% highlight xml %}
<dataSource jndiName="mobilefirst/jdbc/mfpDS" transactional="false">
  [...]
</dataSource>
{% endhighlight %}
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="push-configuration-liberty">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty" href="#collapse-push-configuration-liberty" aria-expanded="true" aria-controls="collapse-push-configuration-liberty"><b>{{ site.data.keys.mf_server }} 推送服务配置详细信息</b></a>
            </h4>
        </div>

        <div id="collapse-push-configuration-liberty" class="panel-collapse collapse" role="tabpanel" aria-labelledby="push-configuration-liberty">
            <div class="panel-body">
                <p>推送服务打包为一个 WAR 应用程序，供您部署到应用程序服务器。您需要在 <b>server.xml</b> 文件中对此应用程序进行一些具体配置。在继续操作之前，请查看<a href="#manual-installation-on-websphere-application-server-liberty">在 WebSphere Application Server Liberty 上进行手动安装</a>，以了解对所有服务通用的配置详细信息。</p>

                <p>推送服务 WAR 文件位于 <b>mfp_install_dir/PushService/mfp-push-service.war</b>。您必须将上下文根定义为 <b>/imfpush</b>。否则，由于在 SDK 中对上下文根进行硬编码，因此客户机设备无法连接到此上下文根。</p>

                <h3>必需的 JNDI 属性</h3>
                <p>定义 JNDI 属性时，必须使用推送服务的上下文根作为 JNDI 名称的前缀。以下示例显示了声明 <b>mfp.push.analytics.user</b> 而安装的推送服务使用 <b>/imfpush</b> 作为上下文根的情况。</p>

{% highlight xml %}
<jndiEntry jndiName="imfpush/mfp.push.analytics.user" value="admin"/>
{% endhighlight %}

                您需要定义以下属性：
		<ul>
                    <li><b>mfp.push.authorization.server.url</b></li>
                    <li><b>mfp.push.authorization.client.id</b></li>
                    <li><b>mfp.push.authorization.client.secret</b></li>
                    <li><b>mfp.push.services.ext.security</b> - 该值必须为 <b>com.ibm.mfp.push.server.security.plugin.OAuthSecurityPlugin</b>。</li>
                    <li><b>mfp.push.db.type</b> - 对于关系数据库，该值必须是 DB。</li>
                </ul>

                如果已配置 {{ site.data.keys.mf_analytics }}，请定义以下 JNDI 属性：
		<ul>
                    <li><b>mfp.push.analytics.endpoint</b></li>
                    <li><b>mfp.analytics.username</b></li>
                    <li><b>mfp.analytics.password</b></li>
                    <li><b>mfp.push.services.ext.analytics</b> - 该值必须为 <b>com.ibm.mfp.push.server.analytics.plugin.AnalyticsPlugin</b>。</li>
                </ul>
                有关 JNDI 属性的更多信息，请参阅 <a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service">{{ site.data.keys.mf_server }} 推送服务的 JNDI 属性列表</a>。
		</div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="artifacts-configuration">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty" href="#collapse-artifacts-configuration" aria-expanded="true" aria-controls="collapse-artifacts-configuration"><b>{{ site.data.keys.mf_server }} 工件配置详细信息</b></a>
            </h4>
        </div>

        <div id="collapse-artifacts-configuration" class="panel-collapse collapse" role="tabpanel" aria-labelledby="artifacts-configuration">
            <div class="panel-body">
                <p>工件组件打包为一个 WAR 应用程序，供您部署到应用程序服务器。您需要在 <b>server.xml</b> 文件中对此应用程序进行一些具体配置。在继续操作之前，请查看<a href="#manual-installation-on-websphere-application-server-liberty">在 WebSphere Application Server Liberty 上进行手动安装</a>，以了解对所有服务通用的配置详细信息。</p>

                <p>该组件的 WAR 文件位于 <b>mfp_install_dir/MobileFirstServer/mfp-dev-artifacts.war</b>。您必须将上下文根定义为 <b>/mfp-dev-artifacts</b>。</p>
            </div>
        </div>
    </div>
</div>

### 在 WebSphere Application Server Liberty 集合体上手动安装
{: #manual-installation-on-websphere-application-server-liberty-collective }
确保您同样满足 [WebSphere Application Server Liberty 先决条件](#websphere-application-server-liberty-prerequisites)中记录的需求。

* [拓扑约束](#topology-constraints-collective)
* [应用程序服务器设置](#application-server-settings-collective)
* [{{ site.data.keys.mf_server }} 应用程序所需的 Liberty 功能](#liberty-features-required-by-the-mobilefirst-server-applications-collective)
* [全局 JNDI 条目](#global-jndi-entries-collective)
* [类装入器](#class-loader-collective)
* [密码解码器用户功能](#password-decoder-user-feature-collective)
* [配置详细信息](#configuration-details-collective)

#### 拓扑约束
{: #topology-constraints-collective }
{{ site.data.keys.mf_server }} 管理服务、{{ site.data.keys.mf_server }} 实时更新服务和 {{ site.data.keys.mf_console }} 必须安装在 Liberty 集合体控制器中。{{ site.data.keys.product_adj }} 运行时和 {{ site.data.keys.mf_server }} 推送服务必须安装在 Liberty 集合体集群的所有成员中。

必须将实时更新服务的上下文根定义为 **the-adminContextRootconfig**。推送服务的上下文根必须为 **imfpush**。有关约束的更多信息，请参阅[有关 {{ site.data.keys.mf_server }} 组件和 {{ site.data.keys.mf_analytics }} 的约束](../topologies/#constraints-on-the-mobilefirst-server-components-and-mobilefirst-analytics)。

#### 应用程序服务器设置
{: #application-server-settings-collective }
必须配置 **webContainer** 元素以立即装入 servlet。需要此设置来通过 JMX 进行初始化。例如：`<webContainer deferServletLoad="false"/>`。

（可选）为避免发生某些 Liberty 版本上运行时和管理服务的启动顺序被破坏的超时问题，请更改缺省 **executor** 元素。将 **coreThreads** 和 **maxThreads** 属性设置为较大的值。例如：

```xml
<executor id="default" name="LargeThreadPool"
  coreThreads="200" maxThreads="400" keepAlive="60s"
  stealPolicy="STRICT" rejectedWorkPolicy="CALLER_RUNS"/>
```

您还可以配置 **tcpOptions** 元素，并将 **soReuseAddr** 属性设置为 `true`：`<tcpOptions soReuseAddr="true"/>`。

#### {{ site.data.keys.mf_server }} 应用程序所需的 Liberty 功能
{: #liberty-features-required-by-the-mobilefirst-server-applications-collective }

您需要为 Java EE6 或 Java EE 7 添加以下功能。

**{{ site.data.keys.mf_server }} 管理服务**

* **jdbc-4.0**（对于 Java EE 7，为 jdbc-4.1）
* **appSecurity-2.0**
* **restConnector-1.0**
* **usr:MFPDecoderFeature-1.0**

**{{ site.data.keys.mf_server }} 推送服务**  

* **jdbc-4.0**（对于 Java EE 7，为 jdbc-4.1）
* **servlet-3.0**（对于 Java EE 7，为 servlet-3.1）
* **ssl-1.0**
* **usr:MFPDecoderFeature-1.0**

**{{ site.data.keys.product_adj }} 运行时**  

* **jdbc-4.0**（对于 Java EE 7，为 jdbc-4.1）
* **servlet-3.0**（对于 Java EE 7，为 servlet-3.1）
* **ssl-1.0**
* **usr:MFPDecoderFeature-1.0**

#### 全局 JNDI 条目
{: #global-jndi-entries-collective }
需要以下全局 JNDI 条目，以在运行时与管理服务间配置 JMX 通信：

* **mfp.admin.jmx.host**
* **mfp.admin.jmx.port**
* **mfp.admin.jmx.user**
* **mfp.admin.jmx.pwd**
* **mfp.topology.platform**
* **mfp.topology.clustermode**
* **mfp.admin.serverid**

将使用此语法设置这些全局 JNDI 条目且前缀非上下文根。例如：`<jndiEntry jndiName="mfp.admin.jmx.port" value="9443"/>`。

> **注：**为防止自动转换 JNDI 值，以便不会将 075 转换为 61，或不会将 31.500 转换为 31.5，请在定义值时使用此语法 '"075"'。

* 有关管理服务的 JNDI 属性的更多信息，请参阅[{{ site.data.keys.mf_server }} 管理服务的 JNDI 属性列表](../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service)。  
* 有关运行时的 JNDI 属性的更多信息，请参阅[{{ site.data.keys.product_adj }} 运行时的 JNDI 属性列表](../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime)。

#### 类装入器
{: #class-loader-collective }
对于所有应用程序，类装入器必须使用父代最后的授权。例如：

```xml
<application id="mfpadmin" name="mfpadmin" location="mfp-admin-service.war" type="war">
  [...]
  <classloader delegation="parentLast">
  </classloader>
</application>
```

#### 密码解码器用户功能
{: #password-decoder-user-feature-collective }
将密码解码器用户功能复制到您的 Liberty 概要文件。例如：

* 在 UNIX 和 Linux 系统上：

  ```bash
  mkdir -p LIBERTY_HOME/wlp/usr/extension/lib/features
  cp product_install_dir/features/com.ibm.websphere.crypto_1.0.0.jar LIBERTY_HOME/wlp/usr/extension/lib/
  cp product_install_dir/features/MFPDecoderFeature-1.0.mf LIBERTY_HOME/wlp/usr/extension/lib/features/
  ```

* 在 Windows 系统上：

  ```bash
  mkdir LIBERTY_HOME\wlp\usr\extension\lib
  copy /B product_install_dir\features\com.ibm.websphere.crypto_1.0.0.jar
  LIBERTY_HOME\wlp\usr\extension\lib\com.ibm.websphere.crypto_1.0.0.jar
  mkdir LIBERTY_HOME\wlp\usr\extension\lib\features
  copy /B product_install_dir\features\MFPDecoderFeature-1.0.mf
  LIBERTY_HOME\wlp\usr\extension\lib\features\MFPDecoderFeature-1.0.mf
  ```
#### 配置详细信息
{: #configuration-details-collective }
<div class="panel-group accordion" id="manual-installation-liberty-collective" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="admin-service-collective">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty-collective" href="#collapse-admin-service-collective" aria-expanded="true" aria-controls="collapse-admin-service-collective"><b>{{ site.data.keys.mf_server }} 管理服务配置详细信息</b></a>
            </h4>
        </div>

        <div id="collapse-admin-service-collective" class="panel-collapse collapse" role="tabpanel" aria-labelledby="admin-service-collective">
            <div class="panel-body">
                <p>管理服务打包为一个 WAR 应用程序，供您部署到 Liberty 集合体控制器。您需要在 Liberty 集合体控制器的 <b>server.xml</b> 文件中对此应用程序进行一些具体配置。
		<br/><br/>
                在继续操作之前，请查看<a href="#manual-installation-on-websphere-application-server-liberty-collective">在 WebSphere Application Server Liberty 集合体上进行手动安装</a>，以了解对所有服务通用的配置详细信息。
		<br/><br/>
                管理服务 WAR 文件位于 <b>mfp_install_dir/MobileFirstServer/mfp-admin-service-collective.war</b> 中。您可以根据需要定义上下文根。但是，它通常为 <b>/mfpadmin</b>。</p>

                <h3>必需的 JNDI 属性</h3>
                <p>定义 JNDI 属性时，JNDI 名称必须使用管理服务的上下文根作为前缀。以下示例说明声明 <b>mfp.admin.push.url</b> 的情况，此时使用 <b>/mfpadmin</b> 作为上下文根来安装管理服务：</p>
{% highlight xml %}
<jndiEntry jndiName="mfpadmin/mfp.admin.push.url" value="http://localhost:9080/imfpush"/>
{% endhighlight %}

                <p>如果已安装推送服务，那么必须配置以下 JNDI 属性：</p>
                <ul>
                    <li><b>mfp.admin.push.url</b></li>
                    <li><b>mfp.admin.authorization.server.url</b></li>
                    <li><b>mfp.push.authorization.client.id</b></li>
                    <li><b>mfp.push.authorization.client.secret</b></li>
                    <li><b>mfp.admin.authorization.client.id</b></li>
                    <li><b>mfp.admin.authorization.client.secret</b></li>
                </ul>
                <p>用于与配置服务通信的 JNDI 属性如下：</p>
                <ul>
                    <li><b>mfp.config.service.user</b></li>
                    <li><b>mfp.config.service.password</b></li>
                </ul>
                <p>有关 JNDI 属性的更多信息，请参阅<a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service">{{ site.data.keys.mf_server }} 管理服务的 JNDI 属性列表</a>。</p>

                <h3>数据源</h3>
                <p>管理服务的数据源的 JNDI 名称必须定义为 <b>jndiName=the-contextRoot/jdbc/mfpAdminDS</b>。以下示例说明使用上下文根 <b>/mfpadmin</b> 安装管理服务，且该服务使用关系数据库的情况：</p>

{% highlight xml %}
<dataSource jndiName="mfpadmin/jdbc/mfpAdminDS" transactional="false">
  [...]
</dataSource>
{% endhighlight %}

                <h3>安全角色</h3>
                <p>在应用程序的 <b>application-bnd</b> 元素中声明以下角色：</p>
                <ul>
                    <li>mfpadmin</li>
                    <li>mfpdeployer</li>
                    <li>mfpmonitor</li>
                    <li>mfpoperator</li>
                </ul>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="live-update-service-collective">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty-collective" href="#collapse-live-update-service-collective" aria-expanded="true" aria-controls="collapse-live-update-service-collective"><b>{{ site.data.keys.mf_server }} 实时更新服务配置详细信息</b></a>
            </h4>
        </div>

        <div id="collapse-live-update-service-collective" class="panel-collapse collapse" role="tabpanel" aria-labelledby="live-update-service-collective">
            <div class="panel-body">
                <p>实时更新服务打包为一个 WAR 应用程序，供您部署到 Liberty 集合体控制器。您需要在 Liberty 集合体控制器的 <b>server.xml</b> 文件中对此应用程序进行一些具体配置。
		<br/><br/>
                在继续操作之前，请查看<a href="#manual-installation-on-websphere-application-server-liberty-collective">在 WebSphere Application Server Liberty 集合体上进行手动安装</a>，以了解对所有服务通用的配置详细信息。
		<br/><br/>
                实时更新服务 WAR 文件位于 <b>mfp_install_dir/MobileFirstServer/mfp-live-update.war</b> 中。必须按以下方式定义实时更新服务的上下文根：<b>/the-adminContextRootconfig</b>。例如，如果管理服务的上下文根为 <b>/mfpadmin</b>，那么实时更新服务的上下文根必须为 <b>/mfpadminconfig</b>。</p>

                <h3>数据源</h3>
                <p>实时更新服务的数据源的 JNDI 名称必须定义为 <b>the-contextRoot/jdbc/ConfigDS</b>。以下示例说明使用上下文根 <b>/mfpadminconfig</b> 安装实时更新服务，且该服务使用关系数据库的情况：</p>

{% highlight xml %}
<dataSource jndiName="mfpadminconfig/jdbc/ConfigDS" transactional="false">
  [...]
</dataSource>
{% endhighlight %}

                <h3>安全角色</h3>
                <p>在应用程序的 <b>application-bnd</b> 元素中声明 configadmin 角色。必须将至少一个用户映射至此角色。必须为管理服务的以下 JNDI 属性提供用户及其密码：</p>

                <ul>
                    <li><b>mfp.config.service.user</b></li>
                    <li><b>mfp.config.service.password</b></li>
                </ul>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="console-configuration-collective">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty-collective" href="#collapse-console-configuration-collective" aria-expanded="true" aria-controls="collapse-console-configuration-collective"><b>{{ site.data.keys.mf_console }} 配置详细信息</b></a>
            </h4>
        </div>

        <div id="collapse-console-configuration-collective" class="panel-collapse collapse" role="tabpanel" aria-labelledby="console-configuration-collective">
            <div class="panel-body">
                <p>控制台打包为一个 WAR 应用程序，供您部署到 Liberty 集合体控制器。您需要在 Liberty 集合体控制器的 <b>server.xml</b> 文件中对此应用程序进行一些具体配置。
		<br/><br/>在继续操作之前，请查看<a href="#manual-installation-on-websphere-application-server-liberty-collective">在 WebSphere Application Server Liberty 上进行手动安装</a>，以了解对所有服务通用的配置详细信息。
		<br/><br/>
                控制台 WAR 文件位于 <b>mfp_install_dir/MobileFirstServer/mfp-admin-ui.war</b>。您可以根据需要定义上下文根。但通常上下文根为 <b>/mfpconsole</b>。</p>

                <h3>必需的 JNDI 属性</h3>
                <p>定义 JNDI 属性时，必须使用控制台的上下文根作为 JNDI 名称的前缀。以下示例显示了声明 <b>mfp.admin.endpoint</b> 而安装的控制台使用 <b>/mfpconsole</b> 作为上下文根的情况。</p>

{% highlight xml %}
<jndiEntry jndiName="mfpconsole/mfp.admin.endpoint" value="*://*:*/mfpadmin"/>
{% endhighlight %}

                <p>mfp.admin.endpoint 属性的典型值是 <b>*://*:*/the-adminContextRoot</b>。<br/>
                有关 JNDI 属性的完整列表，请参阅 <a href="../server-configuration/#jndi-properties-for-mobilefirst-operations-console">{{ site.data.keys.mf_console }} 的 JNDI 属性</a>。</p>

                <h3>安全角色</h3>
                <p>在应用程序的 <b>application-bnd</b> 元素中声明以下角色：</p>
                <ul>
                    <li><b>mfpadmin</b></li>
                    <li><b>mfpdeployer</b></li>
                    <li><b>mfpmonitor</b></li>
                    <li><b>mfpoperator</b></li>
                </ul>
                映射到控制台的安全角色的任何用户还必须同时映射到管理服务的相同安全角色。
		</div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="runtime-configuration-collective">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty-collective" href="#collapse-runtime-configuration-collective" aria-expanded="true" aria-controls="collapse-runtime-configuration-collective"><b>{{ site.data.keys.product_adj }} 运行时配置详细信息</b></a>
            </h4>
        </div>

        <div id="collapse-runtime-configuration-collective" class="panel-collapse collapse" role="tabpanel" aria-labelledby="runtime-configuration-collective">
            <div class="panel-body">
                <p>运行时打包为一个 WAR 应用程序，供您部署到 Liberty 集合体集群成员。您需要在每个 Liberty 集合体集群成员的 <b>server.xml</b> 文件中对此应用程序进行一些具体配置。
		<br/><br/>
                在继续操作之前，请查看<a href="#manual-installation-on-websphere-application-server-liberty-collective">在 WebSphere Application Server Liberty 集合体上进行手动安装</a>，以了解对所有服务通用的配置详细信息。
		<br/><br/>
                运行时 WAR 文件位于 <b>mfp_install_dir/MobileFirstServer/mfp-server.war</b> 中。您可以根据需要定义上下文根。但是，缺省情况下为 <b>/mfp</b>。</p>

                <h3>必需的 JNDI 属性</h3>
                <p>定义 JNDI 属性时，JNDI 名称必须使用运行时的上下文根作为前缀。以下示例说明声明 <b>mfp.analytics.url</b> 的情况，此时使用 <b>/mobilefirst</b> 作为上下文根来安装运行时：</p>

{% highlight xml %}
<jndiEntry jndiName="mobilefirst/mfp.analytics.url" value="http://localhost:9080/analytics-service/rest"/>
{% endhighlight %}

                                <p>必须定义 <b>mobilefirst/mfp.authorization.server</b> 属性。例如：</p>
{% highlight xml %}
<jndiEntry jndiName="mobilefirst/mfp.authorization.server" value="embedded"/>
{% endhighlight %}

                <p>如果已安装 {{ site.data.keys.mf_analytics }}，那么需要定义以下 JNDI 属性：</p>
                <ul>   
                    <li><b>mfp.analytics.url</b></li>
                    <li><b>mfp.analytics.console.url</b></li>
                    <li><b>mfp.analytics.username</b></li>
                    <li><b>mfp.analytics.password</b></li>
                </ul>

                <p>有关 JNDI 属性的更多信息，请参阅 <a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime">{{ site.data.keys.product_adj }} 运行时的 JNDI 属性列表</a>。</p>

                <h3>数据源</h3>
                <p>必须将运行时的数据源的 JNDI 名称定义为 <b>jndiName=the-contextRoot/jdbc/mfpDS</b>。以下示例说明使用上下文根 <b>/mobilefirst</b> 安装运行时，且运行时使用关系数据库的情况：</p>

{% highlight xml %}
<dataSource jndiName="mobilefirst/jdbc/mfpDS" transactional="false">
  [...]
</dataSource>
{% endhighlight %}
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="push-configuration">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty-collective" href="#collapse-push-configuration" aria-expanded="true" aria-controls="collapse-push-configuration"><b>{{ site.data.keys.mf_server }} 推送服务配置详细信息</b></a>
            </h4>
        </div>

        <div id="collapse-push-configuration" class="panel-collapse collapse" role="tabpanel" aria-labelledby="push-configuration">
            <div class="panel-body">
                <p>推送服务打包为一个 WAR 应用程序，供您部署到 Liberty 集合体集群成员或 Liberty 服务器。如果在 Liberty 服务器中安装推送服务，请参阅 <a href="#manual-installation-on-websphere-application-server-liberty">WebSphere Application Server Liberty 上的手动安装</a>下面的<a href="#configuration-details-liberty">{{ site.data.keys.mf_server }}推送服务配置详细信息</a>。
		<br/><br/>
                当 {{ site.data.keys.mf_server }} 推送服务安装在 Liberty 集合体中时，可以将其安装在与运行时相同的集群中，也可以将其安装在其他集群中。
		<br/><br/>
                您需要在每个 Liberty 集合体集群成员的 <b>server.xml</b> 文件中对此应用程序进行一些具体配置。在继续操作之前，请查看<a href="#manual-installation-on-websphere-application-server-liberty-collective">在 WebSphere Application Server Liberty 集合体上进行手动安装</a>，以了解对所有服务通用的配置详细信息。    
                <br/><br/>
                推送服务 WAR 文件位于 <b>mfp_install_dir/PushService/mfp-push-service.war</b>。您必须将上下文根定义为 <b>/imfpush</b>。否则，由于在 SDK 中对上下文根进行硬编码，因此客户机设备无法连接到此上下文根。</p>

                <h3>必需的 JNDI 属性</h3>
                <p>定义 JNDI 属性时，必须使用推送服务的上下文根作为 JNDI 名称的前缀。以下示例显示了声明 <b>mfp.push.analytics.user</b> 而安装的推送服务使用 <b>/imfpush</b> 作为上下文根的情况。</p>

{% highlight xml %}
<jndiEntry jndiName="imfpush/mfp.push.analytics.user" value="admin"/>
{% endhighlight %}

                您需要定义以下属性：
		<ul>
                    <li><b>mfp.push.authorization.server.url</b></li>
                    <li><b>mfp.push.authorization.client.id</b></li>
                    <li><b>mfp.push.authorization.client.secret</b></li>
                    <li><b>mfp.push.services.ext.security</b> - 该值必须为 <b>com.ibm.mfp.push.server.security.plugin.OAuthSecurityPlugin</b>。</li>
                    <li><b>mfp.push.db.type</b> - 对于关系数据库，该值必须是 DB。</li>
                </ul>

                如果已配置 {{ site.data.keys.mf_analytics }}，请定义以下 JNDI 属性：
		<ul>
                    <li><b>mfp.push.analytics.endpoint</b></li>
                    <li><b>mfp.analytics.username</b></li>
                    <li><b>mfp.analytics.password</b></li>
                    <li><b>mfp.push.services.ext.analytics</b> - 该值必须为 <b>com.ibm.mfp.push.server.analytics.plugin.AnalyticsPlugin</b>。</li>
                </ul>
                有关 JNDI 属性的更多信息，请参阅 <a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service">{{ site.data.keys.mf_server }} 推送服务的 JNDI 属性列表</a>。
		</div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="artifacts-configuration-collective">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty-collective" href="#collapse-artifacts-configuration-collective" aria-expanded="true" aria-controls="collapse-artifacts-configuration-collective"><b>{{ site.data.keys.mf_server }} 工件配置详细信息</b></a>
            </h4>
        </div>

        <div id="collapse-artifacts-configuration-collective" class="panel-collapse collapse" role="tabpanel" aria-labelledby="artifacts-configuration-collective">
            <div class="panel-body">
                <p>工件组件打包为一个 WAR 应用程序，供您部署到 Liberty 集合体控制器。您需要在 Liberty 集合体控制器的 <b>server.xml</b> 文件中对此应用程序进行一些具体配置。在继续操作之前，请查看<a href="#manual-installation-on-websphere-application-server-liberty">在 WebSphere Application Server Liberty 上进行手动安装</a>，以了解对所有服务通用的配置详细信息。</p>

                <p>该组件的 WAR 文件位于 <b>mfp_install_dir/MobileFirstServer/mfp-dev-artifacts.war</b>。您必须将上下文根定义为 <b>/mfp-dev-artifacts</b>。</p>
            </div>
        </div>
    </div>
</div>

### 在 Apache Tomcat 上手动安装
{: #manual-installation-on-apache-tomcat }
确保您已满足 [Apache Tomcat 先决条件](#apache-tomcat-prerequisites)中记录的需求。

* [拓扑约束](#topology-constraints-tomcat)
* [应用程序服务器设置](#application-server-settings-tomcat)
* [配置详细信息](#configuration-details-tomcat)

#### 拓扑约束
{: #topology-constraints-tomcat }
必须在同一应用程序服务器上安装 {{ site.data.keys.mf_server }} 管理服务、{{ site.data.keys.mf_server }} 实时更新服务和 {{ site.data.keys.product_adj }} 运行时。必须将实时更新服务的上下文根定义为 **the-adminContextRootconfig**。推送服务的上下文根必须为 **imfpush**。有关约束的更多信息，请参阅[有关 {{ site.data.keys.mf_server }} 组件和 {{ site.data.keys.mf_analytics }} 的约束](../topologies/#constraints-on-the-mobilefirst-server-components-and-mobilefirst-analytics)。

#### 应用程序服务器设置
{: #application-server-settings-tomcat }
您必须激活 **Single Sign On Valve**。例如：

```xml
<Valve className="org.apache.catalina.authenticator.SingleSignOn"/>
```

（可选）如果已在 **tomcat-users.xml** 中定义用户，那么您可能希望激活内存域。例如：

```xml
<Realm className="org.apache.catalina.realm.MemoryRealm"/>
```
#### 配置详细信息
{: #configuration-details-tomcat }
<div class="panel-group accordion" id="manual-installation-apache-tomcat" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="admin-service-tomcat">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-apache-tomcat" href="#collapse-admin-service-tomcat" aria-expanded="true" aria-controls="collapse-admin-service-tomcat"><b>{{ site.data.keys.mf_server }} 管理服务配置详细信息</b></a>
            </h4>
        </div>

        <div id="collapse-admin-service-tomcat" class="panel-collapse collapse" role="tabpanel" aria-labelledby="admin-service-tomcat">
            <div class="panel-body">
                <p>管理服务打包为 WAR 应用程序，供您部署到应用程序服务器。您需要在应用程序服务器的 <b>server.xml</b> 文件中对此应用程序进行一些具体配置。
		<br/><br/>
                在继续操作之前，请查看<a href="#manual-installation-on-apache-tomcat">在 Apache Tomcat 上进行手动安装</a>，以了解对所有服务通用的配置详细信息。
		<br/><br/>
                管理服务 WAR 文件位于 <b>mfp_install_dir/MobileFirstServer/mfp-admin-service.war</b>。您可以根据需要定义上下文根。但是，它通常为 <b>/mfpadmin</b>。</p>

                <h3>必需的 JNDI 属性</h3>
                <p>应用程序上下文中的 <code>Environment</code> 元素中定义了 JNDI 属性。例如：</p>

{% highlight xml %}
<Environment name="mfp.admin.push.url" value="http://localhost:8080/imfpush" type="java.lang.String" override="false"/>
{% endhighlight %}
                <p>要启用 JMX 与运行时通信，请定义以下 JNDI 属性：</p>
                <ul>
                    <li><b>mfp.topology.platform</b></li>
                    <li><b>mfp.topology.clustermode</b></li>
                </ul>

                <p>如果已安装推送服务，那么必须配置以下 JNDI 属性：</p>
                <ul>
                    <li><b>mfp.admin.push.url</b></li>
                    <li><b>mfp.admin.authorization.server.url</b></li>
                    <li><b>mfp.push.authorization.client.id</b></li>
                    <li><b>mfp.push.authorization.client.secret</b></li>
                    <li><b>mfp.admin.authorization.client.id</b></li>
                    <li><b>mfp.admin.authorization.client.secret</b></li>
                </ul>
                <p>用于与配置服务通信的 JNDI 属性如下：</p>
                <ul>
                    <li><b>mfp.config.service.user</b></li>
                    <li><b>mfp.config.service.password</b></li>
                </ul>
                <p>有关 JNDI 属性的更多信息，请参阅<a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service">{{ site.data.keys.mf_server }} 管理服务的 JNDI 属性列表</a>。</p>

                <h3>数据源</h3>
                <p>将数据源 (jdbc/mfpAdminDS) 声明为 **Context** 元素中的一项资源。例如：</p>

{% highlight xml %}
<Resource name="jdbc/mfpAdminDS" type="javax.sql.DataSource" .../>
{% endhighlight %}

                <h3>安全角色</h3>
                <p>可供管理服务应用程序使用的安全角色有：</p>
                <ul>
                    <li>mfpadmin</li>
                    <li>mfpdeployer</li>
                    <li>mfpmonitor</li>
                    <li>mfpoperator</li>
                </ul>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="live-update-service-tomcat">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-apache-tomcat" href="#collapse-live-update-service-tomcat" aria-expanded="true" aria-controls="collapse-live-update-service-tomcat"><b>{{ site.data.keys.mf_server }} 实时更新服务配置详细信息</b></a>
            </h4>
        </div>

        <div id="collapse-live-update-service-tomcat" class="panel-collapse collapse" role="tabpanel" aria-labelledby="live-update-service-tomcat">
            <div class="panel-body">
                <p>实时更新服务打包为一个 WAR 应用程序，供您部署到应用程序服务器。您需要在 <b>server.xml</b> 文件中对此应用程序进行一些具体配置。
		<br/><br/>
                在继续操作之前，请查看<a href="#manual-installation-on-apache-tomcat">在 Apache Tomcat 上进行手动安装</a>，以了解对所有服务通用的配置详细信息。
		<br/><br/>
                实时更新服务 WAR 文件位于 <b>mfp_install_dir/MobileFirstServer/mfp-live-update.war</b> 中。必须按以下方式定义实时更新服务的上下文根：<b>/the-adminContextRoot/config</b>。例如，如果管理服务的上下文根为 <b>/mfpadmin</b>，那么实时更新服务的上下文根必须为 <b>/mfpadminconfig</b>。</p>

                <h3>数据源</h3>
                <p>实时更新服务的数据源的 JNDI 名称必须定义为 <code>jdbc/ConfigDS</code>。在 <code>Context</code> 元素中将其声明为资源。</p>

                <h3>安全角色</h3>
                <p>实时更新服务应用程序可用的安全角色为 <b>configadmin</b>。
		<br/><br/>
                必须将至少一个用户映射至此角色。必须为管理服务的以下 JNDI 属性提供用户及其密码：</p>

                <ul>
                    <li><b>mfp.config.service.user</b></li>
                    <li><b>mfp.config.service.password</b></li>
                </ul>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="console-configuration-tomcat">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-apache-tomcat" href="#collapse-console-configuration-tomcat" aria-expanded="true" aria-controls="collapse-console-configuration-tomcat"><b>{{ site.data.keys.mf_console }} 配置详细信息</b></a>
            </h4>
        </div>

        <div id="collapse-console-configuration-tomcat" class="panel-collapse collapse" role="tabpanel" aria-labelledby="console-configuration-tomcat">
            <div class="panel-body">
                <p>控制台打包为一个 WAR 应用程序，供您部署到应用程序服务器。您需要在应用程序服务器的 <b>server.xml</b> 文件中对此应用程序进行一些具体配置。
		<br/><br/>在继续操作之前，请查看<a href="#manual-installation-on-apache-tomcat">在 Apache Tomcat 上进行手动安装</a>，以了解对所有服务通用的配置详细信息。
                <br/><br/>
                控制台 WAR 文件位于 <b>mfp_install_dir/MobileFirstServer/mfp-admin-ui.war</b>。您可以根据需要定义上下文根。但通常上下文根为 <b>/mfpconsole</b>。</p>

                <h3>必需的 JNDI 属性</h3>
                <p>您需要定义 <b>mfp.admin.endpoint </b> 属性。该属性的典型值是 <b>*://*:*/the-adminContextRoot</b>。
		<br/><br/>
                有关 JNDI 属性的完整列表，请参阅 <a href="../server-configuration/#jndi-properties-for-mobilefirst-operations-console">{{ site.data.keys.mf_console }} 的 JNDI 属性</a>。</p>

                <h3>安全角色</h3>
                <p>可用于此应用程序的安全角色为：</p>
                <ul>
                    <li><b>mfpadmin</b></li>
                    <li><b>mfpdeployer</b></li>
                    <li><b>mfpmonitor</b></li>
                    <li><b>mfpoperator</b></li>
                </ul>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="runtime-configuration-tomcat">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-apache-tomcat" href="#collapse-runtime-configuration-tomcat" aria-expanded="true" aria-controls="collapse-runtime-configuration-tomcat"><b>{{ site.data.keys.product_adj }} 运行时配置详细信息</b></a>
            </h4>
        </div>

        <div id="collapse-runtime-configuration-tomcat" class="panel-collapse collapse" role="tabpanel" aria-labelledby="runtime-configuration-tomcat">
            <div class="panel-body">
                <p>运行时打包为一个 WAR 应用程序，供您部署到应用程序服务器。您需要在 <b>server.xml</b> 文件中对此应用程序进行一些具体配置。
                <br/><br/>
                在继续操作之前，请查看<a href="#manual-installation-on-apache-tomcat">在 Apache Tomcat 上进行手动安装</a>，以了解对所有服务通用的配置详细信息。
		<br/><br/>
                运行时 WAR 文件位于 <b>mfp_install_dir/MobileFirstServer/mfp-server.war</b> 中。您可以根据需要定义上下文根。但是，缺省情况下为 <b>/mfp</b>。</p>

                <h3>必需的 JNDI 属性</h3>
                <p>您必须定义 <b>mfp.authorization.server</b> 属性。例如：</p>

{% highlight xml %}
<Environment name="mfp.authorization.server" value="embedded" type="java.lang.String" override="false"/>
{% endhighlight %}

                <p>要启用 JMX 与管理服务通信，请定义以下 JNDI 属性：</p>
                <ul>
                    <li><b>mfp.topology.platform</b></li>
                    <li><b>mfp.topology.clustermode</b></li>
                </ul>

                <p>如果已安装 {{ site.data.keys.mf_analytics }}，那么需要定义以下 JNDI 属性：</p>
                <ul>   
                    <li><b>mfp.analytics.url</b></li>
                    <li><b>mfp.analytics.console.url</b></li>
                    <li><b>mfp.analytics.username</b></li>
                    <li><b>mfp.analytics.password</b></li>
                </ul>

                <p>有关 JNDI 属性的更多信息，请参阅 <a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime">{{ site.data.keys.product_adj }} 运行时的 JNDI 属性列表</a>。</p>

                <h3>数据源</h3>
                <p>运行时的数据源的 JNDI 名称必须定义为 <b>jdbc/mfpDS</b>。在 <b>Context</b> 元素中将其声明为资源。</p>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="push-configuration-tomcat">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-apache-tomcat" href="#collapse-push-configuration-tomcat" aria-expanded="true" aria-controls="collapse-push-configuration-tomcat"><b>{{ site.data.keys.mf_server }} 推送服务配置详细信息</b></a>
            </h4>
        </div>

        <div id="collapse-push-configuration-tomcat" class="panel-collapse collapse" role="tabpanel" aria-labelledby="push-configuration-tomcat">
            <div class="panel-body">
                <p>推送服务打包为一个 WAR 应用程序，供您部署到应用程序服务器。您需要对此应用程序进行一些具体配置。在继续操作之前，请查看<a href="#manual-installation-on-apache-tomcat">在 Apache Tomcat 上进行手动安装</a>，以了解对所有服务通用的配置详细信息。    
                <br/><br/>
                推送服务 WAR 文件位于 <b>mfp_install_dir/PushService/mfp-push-service.war</b>。您必须将上下文根定义为 <b>/imfpush</b>。否则，由于在 SDK 中对上下文根进行硬编码，因此客户机设备无法连接到此上下文根。</p>

                <h3>必需的 JNDI 属性</h3>
                <p>您需要定义以下属性：</p>
                <ul>
                    <li><b>mfp.push.authorization.server.url</b></li>
                    <li><b>mfp.push.authorization.client.id</b></li>
                    <li><b>mfp.push.authorization.client.secret</b></li>
                    <li><b>mfp.push.services.ext.security</b> - 该值必须为 <b>com.ibm.mfp.push.server.security.plugin.OAuthSecurityPlugin</b>。</li>
                    <li><b>mfp.push.db.type</b> - 对于关系数据库，该值必须是 DB。</li>
                </ul>

                <p>如果已配置 {{ site.data.keys.mf_analytics }}，请定义以下 JNDI 属性：</p>
                <ul>
                    <li><b>mfp.push.analytics.endpoint</b></li>
                    <li><b>mfp.analytics.username</b></li>
                    <li><b>mfp.analytics.password</b></li>
                    <li><b>mfp.push.services.ext.analytics</b> - 该值必须为 <b>com.ibm.mfp.push.server.analytics.plugin.AnalyticsPlugin</b>。</li>
                </ul>
                有关 JNDI 属性的更多信息，请参阅 <a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service">{{ site.data.keys.mf_server }} 推送服务的 JNDI 属性列表</a>。
		</div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="artifacts-configuration-tomcat">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-on-apache-tomcat" href="#collapse-artifacts-configuration-tomcat" aria-expanded="true" aria-controls="collapse-artifacts-configuration-tomcat"><b>{{ site.data.keys.mf_server }} 工件配置详细信息</b></a>
            </h4>
        </div>

        <div id="collapse-artifacts-configuration-tomcat" class="panel-collapse collapse" role="tabpanel" aria-labelledby="artifacts-configuration-tomcat">
            <div class="panel-body">
                <p>工件组件打包为一个 WAR 应用程序，供您部署到应用程序服务器。您需要在应用程序服务器的 <b>server.xml</b> 文件中对此应用程序进行一些具体配置。在继续操作之前，请查看<a href="#manual-installation-on-apache-tomcat">在 Apache Tomcat 上进行手动安装</a>，以了解对所有服务通用的配置详细信息。</p>

                <p>该组件的 WAR 文件位于 <b>mfp_install_dir/MobileFirstServer/mfp-dev-artifacts.war</b>。您必须将上下文根定义为 <b>/mfp-dev-artifacts</b>。</p>
            </div>
        </div>
    </div>
</div>

### 在 WebSphere Application Server 和 WebSphere Application Server Network Deployment 上手动安装
{: #manual-installation-on-websphere-application-server-and-websphere-application-server-network-deployment }
确保您已满足 <a href="#websphere-application-server-and-websphere-application-server-network-deployment-prerequisites">WebSphere Application Server 和 WebSphere Application Server Network Deployment 先决条件</a>中记录的需求。

* [拓扑约束](#topology-constraints-nd)
* [应用程序服务器设置](#application-server-settings-nd)
* [类装入器](#class-loader-nd)
* [配置详细信息](#configuration-details-nd)

#### 拓扑约束
{: #topology-constraints-nd }
<b>在独立的 WebSphere Application Server 上</b>  
必须在同一应用程序服务器上安装 {{ site.data.keys.mf_server }} 管理服务、{{ site.data.keys.mf_server }} 实时更新服务和 {{ site.data.keys.product_adj }} 运行时。必须将实时更新服务的上下文根定义为 <b>the-adminContextRootConfig</b>。推送服务的上下文根必须为 <b>imfpush</b>。有关约束的更多信息，请参阅[有关 {{ site.data.keys.mf_server }} 组件和 {{ site.data.keys.mf_analytics }} 的约束](../topologies/#constraints-on-the-mobilefirst-server-components-and-mobilefirst-analytics)。

<b>在 WebSphere Application Server Network Deployment 上</b>  
在运行 {{ site.data.keys.mf_server }} 时，必须正在运行 Deployment Manager。Deployment Manager 用于运行时与管理服务间的 JMX 通信。管理服务和实时更新服务必须安装在相同的应用程序服务器上。运行时与管理服务可安装在不同的服务器上，但必须位于同一单元上。

#### 应用程序服务器设置
{: #application-server-settings-nd }
必须启用管理安全性和应用程序安全性。可以在 WebSphere Application Server 管理控制台中启用应用程序安全性：

1. 登录到 WebSphere Application Server 管理控制台。
2. 单击**安全性 → 全局安全性**。确保选中了启用管理安全性。
3. 此外，还要确保选中**启用应用程序安全性**。仅在启用了管理安全性的情况下才可启用应用程序安全性。
4. 单击**确定**。
5. 保存更改。

有关更多信息，请参阅 WebSphere Application Server 文档中的[启用安全性](http://www.ibm.com/support/knowledgecenter/SSAW57_8.5.5/com.ibm.websphere.nd.doc/ae/tsec_csec2.html?view=kc)。

服务器类装入器策略必须支持父代最后的授权。必须使用父代最后的类装入器方式来安装 {{ site.data.keys.mf_server }} WAR 文件。查看类装入器策略：

1. 登录到 WebSphere Application Server 管理控制台。
2. 单击**服务器 → 服务器类型 → WebSphere Application Server**，然后单击用于 {{ site.data.keys.product }} 的服务器。
3. 如果将类装入器策略设置为**多个**，那么无需执行任何操作。
4. 如果将类装入器策略设置为**单个**，并且类装入方式设置为**最先通过本地类装入器（父代最后）装入类**，那么无需执行任何操作。
5. 如果将类装入器策略设置为**单个**，并且类装入方式设置为**最先通过父代类装入器（父代最先）装入类**，请将类装入器策略更改为**多个**。此外，还应将除 {{ site.data.keys.mf_server }} 应用程序以外的所有应用程序的类装入器顺序设置为**最先通过父代类装入器（父代最先）装入类**。

#### 类装入器
{: #class-loader-nd }
对于所有 {{ site.data.keys.mf_server }} 应用程序，类装入器都必须使用父代最后的授权。

要在安装应用程序后将类装入器授权设置为父代最后的授权，请遵循以下步骤：

1. 单击**管理应用程序**链接，或单击**应用程序 → 应用程序类型 → WebSphere 企业应用程序**.
2. 单击 **{{ site.data.keys.mf_server }}** 应用程序。缺省情况下，应用程序名称为 WAR 文件的名称。
3. 在**详细信息属性**部分中，单击**类装入和更新检测**链接。
4. 在**类装入器顺序**窗格中，选中**最先通过本地类装入器（父代最后）装入类**选项。
5. 单击**确定**。
6. 在**模块**部分中，单击**管理模块**链接。
7. 单击模块。
8. 对于**类装入器顺序**字段，选中**最先通过本地类装入器（父代最后）装入类**选项。
9. 单击两次**确定**以确认选择，然后回到应用程序的**配置**面板。
10. 单击**保存**以持久保存更改。

#### 配置详细信息
{: #configuration-details-nd }
<div class="panel-group accordion" id="manual-installation-nd" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="admin-service-nd">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-nd" href="#collapse-admin-service-nd" aria-expanded="true" aria-controls="collapse-admin-service-nd"><b>{{ site.data.keys.mf_server }} 管理服务配置详细信息</b></a>
            </h4>
        </div>

        <div id="collapse-admin-service-nd" class="panel-collapse collapse" role="tabpanel" aria-labelledby="admin-service-nd">
            <div class="panel-body">
                <p>管理服务打包为 WAR 应用程序，供您部署到应用程序服务器。您需要在应用程序服务器的 <b>server.xml</b> 文件中对此应用程序进行一些具体配置。
		<br/><br/>
                在继续操作之前，请查看<a href="#manual-installation-on-websphere-application-server-and-websphere-application-server-network-deployment">在 WebSphere Application Server 和 WebSphere Application Server Network Deployment 上手动安装</a>，以了解对所有服务通用的配置详细信息。
		<br/><br/>
                管理服务 WAR 文件位于 <b>mfp_install_dir/MobileFirstServer/mfp-admin-service.war</b>。您可以根据需要定义上下文根。但是，它通常为 <b>/mfpadmin</b>。</p>

                <h3>必需的 JNDI 属性</h3>
                <p>您可以使用 WebSphere Application Server 管理控制台设置 JNDI 属性。转至<b>应用程序 → 应用程序类型 → WebSphere 企业应用程序 → application_name → Web 模块的环境条目</b>，并设置这些条目。</p>

                <p>要启用 JMX 与运行时通信，请定义以下 JNDI 属性：</p>

                <b>在 WebSphere Application Server Network Deployment 上</b>
                <ul>
                    <li><b>mfp.admin.jmx.dmgr.host</b></li>
                    <li><b>mfp.admin.jmx.dmgr.port</b> - Deployment Manager 上的 SOAP 端口。</li>
                    <li><b>mfp.topology.platform</b> - 将该值设置为 <b>WAS</b>。</li>
                    <li><b>mfp.topology.clustermode</b> - 将该值设置为 <b>Cluster</b>。</li>
                    <li><b>mfp.admin.jmx.connector </b> - 将该值设置为 <b>SOAP</b>。</li>
                </ul>

                <b>在独立的 WebSphere Application Server 上</b>
                <ul>
                    <li><b>mfp.topology.platform</b> - 将该值设置为 <b>WAS</b>。</li>
                    <li><b>mfp.topology.clustermode</b> - 将该值设置为 <b>Standalone</b>。</li>
                    <li><b>mfp.admin.jmx.connector </b> - 将该值设置为 <b>SOAP</b>。</li>
                </ul>

                <p>如果已安装推送服务，那么必须配置以下 JNDI 属性：</p>
                <ul>
                    <li><b>mfp.admin.push.url</b></li>
                    <li><b>mfp.admin.authorization.server.url</b></li>
                    <li><b>mfp.push.authorization.client.id</b></li>
                    <li><b>mfp.push.authorization.client.secret</b></li>
                    <li><b>mfp.admin.authorization.client.id</b></li>
                    <li><b>mfp.admin.authorization.client.secret</b></li>
                </ul>
                <p>用于与配置服务通信的 JNDI 属性如下：</p>
                <ul>
                    <li><b>mfp.config.service.user</b></li>
                    <li><b>mfp.config.service.password</b></li>
                </ul>
                <p>有关 JNDI 属性的更多信息，请参阅<a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service">{{ site.data.keys.mf_server }} 管理服务的 JNDI 属性列表</a>。</p>

                <h3>数据源</h3>
                <p>为管理服务创建数据源，并将其映射到 <b>jdbc/mfpAdminDS</b>。</p>

                <h3>启动顺序</h3>
                <p>管理服务应用程序必须在启动运行时应用程序之前启动。您可以在<b>启动行为</b>部分设置此顺序。例如，针对管理服务将 StartupOrder 设置为 <b>1</b>，针对运行时设置为 <b>2</b>。</p>

                <h3>安全角色</h3>
                <p>可供管理服务应用程序使用的安全角色有：</p>
                <ul>
                    <li>mfpadmin</li>
                    <li>mfpdeployer</li>
                    <li>mfpmonitor</li>
                    <li>mfpoperator</li>
                </ul>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="live-update-service-nd">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-nd" href="#collapse-live-update-service-nd" aria-expanded="true" aria-controls="collapse-live-update-service-nd"><b>{{ site.data.keys.mf_server }} 实时更新服务配置详细信息</b></a>
            </h4>
        </div>

        <div id="collapse-live-update-service-nd" class="panel-collapse collapse" role="tabpanel" aria-labelledby="live-update-service-nd">
            <div class="panel-body">
                <p>实时更新服务打包为一个 WAR 应用程序，供您部署到应用程序服务器。您需要在 <b>server.xml</b> 文件中对此应用程序进行一些具体配置。
		<br/><br/>
                在继续操作之前，请查看<a href="#manual-installation-on-websphere-application-server-and-websphere-application-server-network-deployment">在 WebSphere Application Server 和 WebSphere Application Server Network Deployment 上手动安装</a>，以了解对所有服务通用的配置详细信息。
		<br/><br/>
                实时更新服务 WAR 文件位于 <b>mfp_install_dir/MobileFirstServer/mfp-live-update.war</b> 中。必须按以下方式定义实时更新服务的上下文根：<b>/the-adminContextRoot/config</b>。例如，如果管理服务的上下文根为 <b>/mfpadmin</b>，那么实时更新服务的上下文根必须为 <b>/mfpadminconfig</b>。</p>

                <h3>数据源</h3>
                <p>为实时更新服务创建数据源，并将其映射到 <b>jdbc/ConfigDS</b>。</p>

                <h3>安全角色</h3>
                <p>为此应用程序定义了 <b>configadmin</b> 角色。
		<br/><br/>
                必须将至少一个用户映射至此角色。必须为管理服务的以下 JNDI 属性提供用户及其密码：</p>

                <ul>
                    <li><b>mfp.config.service.user</b></li>
                    <li><b>mfp.config.service.password</b></li>
                </ul>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="console-configuration-nd">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-nd" href="#collapse-console-configuration-nd" aria-expanded="true" aria-controls="collapse-console-configuration-nd"><b>{{ site.data.keys.mf_console }} 配置详细信息</b></a>
            </h4>
        </div>

        <div id="collapse-console-configuration-nd" class="panel-collapse collapse" role="tabpanel" aria-labelledby="console-configuration-nd">
            <div class="panel-body">
                <p>控制台打包为一个 WAR 应用程序，供您部署到应用程序服务器。您需要在应用程序服务器的 <b>server.xml</b> 文件中对此应用程序进行一些具体配置。
                <br/><br/>在继续操作之前，请查看<a href="#manual-installation-on-websphere-application-server-and-websphere-application-server-network-deployment">在 WebSphere Application Server 和 WebSphere Application Server Network Deployment 上手动安装</a>，以了解对所有服务通用的配置详细信息。
                <br/><br/>
                控制台 WAR 文件位于 <b>mfp_install_dir/MobileFirstServer/mfp-admin-ui.war</b>。您可以根据需要定义上下文根。但通常上下文根为 <b>/mfpconsole</b>。</p>

                <h3>必需的 JNDI 属性</h3>
                <p>您可以使用 WebSphere Application Server 管理控制台设置 JNDI 属性。转至<b>应用程序 → 应用程序类型 → WebSphere 企业应用程序 → application_name → Web 模块的环境条目</b>，并设置这些条目。
		<br/><br/>
                您需要定义 <b>mfp.admin.endpoint </b> 属性。该属性的典型值是 <b>*://*:*/the-adminContextRoot</b>。
		<br/><br/>
                有关 JNDI 属性的完整列表，请参阅 <a href="../server-configuration/#jndi-properties-for-mobilefirst-operations-console">{{ site.data.keys.mf_console }} 的 JNDI 属性</a>。</p>

                <h3>安全角色</h3>
                <p>可用于此应用程序的安全角色为：</p>
                <ul>
                    <li><b>mfpadmin</b></li>
                    <li><b>mfpdeployer</b></li>
                    <li><b>mfpmonitor</b></li>
                    <li><b>mfpoperator</b></li>
                </ul>
                映射到控制台的安全角色的任何用户还必须同时映射到管理服务的相同安全角色。
		</div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="runtime-configuration-nd">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-nd" href="#collapse-runtime-configuration-nd" aria-expanded="true" aria-controls="collapse-runtime-configuration-nd"><b>MobileFirst 运行时配置详细信息</b></a>
            </h4>
        </div>

        <div id="collapse-runtime-configuration-nd" class="panel-collapse collapse" role="tabpanel" aria-labelledby="runtime-configuration-nd">
            <div class="panel-body">
                <p>运行时打包为一个 WAR 应用程序，供您部署到应用程序服务器。您需要在 <b>server.xml</b> 文件中对此应用程序进行一些具体配置。
                <br/><br/>
                在继续操作之前，请查看<a href="#manual-installation-on-websphere-application-server-and-websphere-application-server-network-deployment">在 WebSphere Application Server 和 WebSphere Application Server Network Deployment 上手动安装</a>，以了解对所有服务通用的配置详细信息。
		<br/><br/>
                运行时 WAR 文件位于 <b>mfp_install_dir/MobileFirstServer/mfp-server.war</b> 中。您可以根据需要定义上下文根。但是，缺省情况下为 <b>/mfp</b>。</p>

                <h3>必需的 JNDI 属性</h3>
                <p>您可以使用 WebSphere Application Server 管理控制台设置 JNDI 属性。转至<b>应用程序 → 应用程序类型 → WebSphere 企业应用程序 → application_name → Web 模块的环境条目</b>，并设置这些条目。</p>

                <p>您必须定义 <b>mfp.authorization.server</b> 属性，其值为嵌入式。<br/>
                同时，请定义以下 JNDI 属性以启用 JMX 与管理服务通信：</p>

                <b>在 WebSphere Application Server Network Deployment 上</b>
                <ul>
                    <li><b>mfp.admin.jmx.dmgr.host</b> - Deployment Manager 的主机名。</li>
                    <li><b>mfp.admin.jmx.dmgr.port</b> - Deployment Manager 的 SOAP 端口。</li>
                    <li><b>mfp.topology.platform</b> - 将该值设置为 <b>WAS</b>。</li>
                    <li><b>mfp.topology.clustermode</b> - 将该值设置为 <b>Cluster</b>。</li>
                    <li><b>mfp.admin.jmx.connector </b> - 将该值设置为 <b>SOAP</b>。</li>
                </ul>

                <b>在独立的 WebSphere Application Server 上</b>
                <ul>
                    <li><b>mfp.topology.platform</b> - 将该值设置为 <b>WAS</b>。</li>
                    <li><b>mfp.topology.clustermode</b> - 将该值设置为 <b>Standalone</b>。</li>
                    <li><b>mfp.admin.jmx.connector </b> - 将该值设置为 <b>SOAP</b>。</li>
                </ul>

                <p>如果已安装 {{ site.data.keys.mf_analytics }}，那么需要定义以下 JNDI 属性：</p>
                <ul>   
                    <li><b>mfp.analytics.url</b></li>
                    <li><b>mfp.analytics.console.url</b></li>
                    <li><b>mfp.analytics.username</b></li>
                    <li><b>mfp.analytics.password</b></li>
                </ul>

                <p>有关 JNDI 属性的更多信息，请参阅 <a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime">{{ site.data.keys.product_adj }} 运行时的 JNDI 属性列表</a>。</p>

                <h3>启动顺序</h3>
                <p>运行时应用程序必须在管理服务应用程序启动之后才能启动。您可以在<b>启动行为</b>部分设置此顺序。例如，针对管理服务将 StartupOrder 设置为 <b>1</b>，针对运行时设置为 <b>2</b>。</p>

                <h3>数据源</h3>
                <p>为运行时创建数据源，并将其映射到 <b>jdbc/mfpDS</b>。</p>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="push-configuration-nd">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-nd" href="#collapse-push-configuration-nd" aria-expanded="true" aria-controls="collapse-push-configuration-nd"><b>{{ site.data.keys.mf_server }} 推送服务配置详细信息</b></a>
            </h4>
        </div>

        <div id="collapse-push-configuration-nd" class="panel-collapse collapse" role="tabpanel" aria-labelledby="push-configuration-nd">
            <div class="panel-body">
                <p>推送服务打包为一个 WAR 应用程序，供您部署到应用程序服务器。您需要对此应用程序进行一些具体配置。在继续操作之前，请查看<a href="#manual-installation-on-websphere-application-server-and-websphere-application-server-network-deployment">在 WebSphere Application Server 和 WebSphere Application Server Network Deployment 上手动安装</a>，以了解对所有服务通用的配置详细信息。    
                <br/><br/>
                推送服务 WAR 文件位于 <b>mfp_install_dir/PushService/mfp-push-service.war</b>。您必须将上下文根定义为 <b>/imfpush</b>。否则，由于在 SDK 中对上下文根进行硬编码，因此客户机设备无法连接到此上下文根。</p>

                <h3>必需的 JNDI 属性</h3>
                <p>您可以使用 WebSphere Application Server 管理控制台设置 JNDI 属性。转至<b>应用程序 > 应用程序类型 → WebSphere 企业应用程序 → application_name → Web 模块的环境条目</b>，并设置这些条目。</p>

                <p>您需要定义以下属性：</p>
                <ul>
                    <li><b>mfp.push.authorization.server.url</b></li>
                    <li><b>mfp.push.authorization.client.id</b></li>
                    <li><b>mfp.push.authorization.client.secret</b></li>
                    <li><b>mfp.push.services.ext.security</b> - 该值必须为 <b>com.ibm.mfp.push.server.security.plugin.OAuthSecurityPlugin</b>。</li>
                    <li><b>mfp.push.db.type</b> - 对于关系数据库，该值必须是 DB。</li>
                </ul>

                <p>如果已配置 {{ site.data.keys.mf_analytics }}，请定义以下 JNDI 属性：</p>
                <ul>
                    <li><b>mfp.push.analytics.endpoint</b></li>
                    <li><b>mfp.analytics.username</b></li>
                    <li><b>mfp.analytics.password</b></li>
                    <li><b>mfp.push.services.ext.analytics</b> - 该值必须为 <b>com.ibm.mfp.push.server.analytics.plugin.AnalyticsPlugin</b>。</li>
                </ul>
                <p>有关 JNDI 属性的更多信息，请参阅 <a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service">{{ site.data.keys.mf_server }} 推送服务的 JNDI 属性列表</a>。</p>

                <h3>数据源</h3>
                <p>为推送服务创建数据源，并将其映射到 <b>jdbc/imfPushDS</b>。</p>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="artifacts-configuration-nd">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-nd" href="#collapse-artifacts-configuration-nd" aria-expanded="true" aria-controls="collapse-artifacts-configuration-nd"><b>{{ site.data.keys.mf_server }} 工件配置详细信息</b></a>
            </h4>
        </div>

        <div id="collapse-artifacts-configuration-nd" class="panel-collapse collapse" role="tabpanel" aria-labelledby="artifacts-configuration-nd">
            <div class="panel-body">
                <p>工件组件打包为一个 WAR 应用程序，供您部署到应用程序服务器。您需要在应用程序服务器的 <b>server.xml</b> 文件中对此应用程序进行一些具体配置。在继续操作之前，请查看<a href="#manual-installation-on-websphere-application-server-and-websphere-application-server-network-deployment">在 WebSphere Application Server 和 WebSphere Application Server Network Deployment 上手动安装</a>，以了解对所有服务通用的配置详细信息。</p>

                <p>该组件的 WAR 文件位于 <b>mfp_install_dir/MobileFirstServer/mfp-dev-artifacts.war</b>。您必须将上下文根定义为 <b>/mfp-dev-artifacts</b>。</p>
            </div>
        </div>
    </div>
</div>

## 安装服务器场
{: #installing-a-server-farm }
您可以通过运行 Ant 任务或通过 Server Configuration Tool 来安装服务器场，也可以手动安装。

* [规划服务器场的配置](#planning-the-configuration-of-a-server-farm)
* [使用 Server Configuration Tool 安装服务器场](#installing-a-server-farm-with-the-server-configuration-tool)
* [使用 Ant 任务安装服务器场](#installing-a-server-farm-with-ant-tasks)
* [手动配置服务器场](#configuring-a-server-farm-manually)
* [验证场配置](#verifying-a-farm-configuration)
* [服务器场节点的生命周期](#lifecycle-of-a-server-farm-node)

### 规划服务器场的配置
{: #planning-the-configuration-of-a-server-farm }
要规划服务器场的配置，请选择应用程序服务器，配置 {{ site.data.keys.product_adj }} 数据库，并在场的每个服务器上部署 {{ site.data.keys.mf_server }} 组件的 WAR 文件。您可以选择使用 Server Configuration Tool、Ant 任务或手动操作来配置服务器场。

当您想要规划服务器场安装时，请先参阅[{{ site.data.keys.mf_server }} 管理服务、{{ site.data.keys.mf_server }} 实时更新服务和 MobileFirst 运行时的约束](../topologies/#constraints-on-mobilefirst-server-administration-service-mobilefirst-server-live-update-service-and-mobilefirst-foundation-runtime)，尤其是参阅[服务器场拓扑](../topologies/#server-farm-topology)。

在 {{ site.data.keys.product }} 中，一个服务器场由多个独立应用程序服务器组成，这些服务器既未联合，也不由应用程序服务器的管理组件管理。{{ site.data.keys.mf_server }} 在内部提供群插件作为一种增强应用程序服务器方式，以便其能够成为服务器场一部分。

#### 声明服务器场的时机
{: #when-to-declare-a-server-farm }
**在以下情况下，可声明服务器场：**

* {{ site.data.keys.mf_server }} 安装在多个 Tomcat 应用程序服务器上。
* {{ site.data.keys.mf_server }} 安装在多个 WebSphere Application Server 服务器上，但未安装在 WebSphere Application Server Network Deployment 上。
* {{ site.data.keys.mf_server }} 安装在多个 WebSphere Application Server Liberty 服务器上。

**在以下情况下，请不要声明服务器场：**

* 您的应用程序服务器是独立的。
* 多个应用程序服务器通过 WebSphere Application Server Network Deployment 联合在一起。

#### 为什么必须声明一个场
{: #why-it-is-mandatory-to-declare-a-farm }
每次通过 {{ site.data.keys.mf_console }} 或 {{ site.data.keys.mf_server }} 管理服务应用程序执行管理操作时，都需要将该操作复制到运行时环境的所有实例。此类管理操作的示例包括上载新版本的应用程序或适配器。复制通过能够处理该操作的管理服务应用程序实例执行的 JMX 调用完成。管理服务需要联系集群中的所有运行时实例。在上面的**何时声明服务器场**下列出的环境中，只有配置了场，才能通过 JMX 联系运行时。如果在未正确配置场的情况下将服务器添加到集群中，那么在每次执行管理操作后，该服务器中的运行时将处于不一致状态，直至再次重新启动为止。

### 使用 Server Configuration Tool 安装服务器场
{: #installing-a-server-farm-with-the-server-configuration-tool }
使用 Server Configuration Tool，根据用于服务器场每个成员的单个应用程序服务器类型的需求，在场中配置每台服务器。

在使用 Server Configuration Tool 规划服务器场时，首先创建独立服务器，然后配置其各自的信任库，从而可以通过安全方式相互通信。然后，运行执行以下操作的工具：

* 配置 {{ site.data.keys.mf_server }} 组件共享的数据库实例。
* 将 {{ site.data.keys.mf_server }} 组件部署到每台服务器
* 修改其配置以使其成为服务器场的成员

<div class="panel-group accordion" id="installing-mobilefirst-server-ct" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="server-farm-ct">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#server-farm-ct" href="#collapse-server-farm-ct" aria-expanded="true" aria-controls="collapse-server-farm-ct"><b>单击以获取有关使用 Server Configuration Tool 安装服务器场的指示信息</b></a>
            </h4>
        </div>

        <div id="collapse-server-farm-ct" class="panel-collapse collapse" role="tabpanel" aria-labelledby="server-farm-ct">
            <div class="panel-body">
                <p>{{ site.data.keys.mf_server }} 需要配置安全的 JMX 连接。</p>

                <ol>
                    <li>准备必须配置为服务器场成员的应用程序服务器。
                        <ul>
                            <li>选择要用于配置服务器场成员的应用程序服务器的类型。{{ site.data.keys.product }} 支持服务器场中的以下应用程序服务器：
                                <ul>
                                    <li>WebSphere Application Server Full Profile<br/>
                                    <b>注：</b>在场拓扑中，不能使用 RMI JMX 接口。在此拓扑中，{{ site.data.keys.product }} 仅支持 SOAP 接口。</li>
                                    <li>WebSphere Application Server Liberty Profile</li>
                                    <li>Apache Tomcat</li>
                                </ul>
                                要了解哪些版本的应用程序服务器受支持，请参阅<a href="../../../product-overview/requirements">系统需求</a>。

                                <blockquote><b>要点：</b> {{ site.data.keys.product }} 只支持同类服务器场。在连接相同类型的应用程序服务器时，服务器场为同类。尝试关联不同类型的应用程序服务器可能会导致运行时出现不可预测的行为。例如，混用 Apache Tomcat 服务器和 WebSphere Application Server Full Profile 服务器的场是无效的配置。</blockquote>
                            </li>
                            <li>设置与希望包含在场中的成员数一样多的独立服务器。
			    <ul>
                                    <li>其中的每个独立服务器都必须与同一个数据库通信。您必须确保其中的任意服务器使用的任何端口均没有被同一主机上配置的另一个服务器使用。此约束适用于 HTTP、HTTPS、REST、SOAP 和 RMI 协议所使用的端口。</li>
                                    <li>其中每台服务器必须部署 {{ site.data.keys.mf_server }} 管理服务、{{ site.data.keys.mf_server }} 实时更新服务以及一个或多个 {{ site.data.keys.product_adj }} 运行时。</li>
                                    <li>有关设置服务器的更多信息，请参阅<a href="../topologies/#constraints-on-mobilefirst-server-administration-service-mobilefirst-server-live-update-service-and-mobilefirst-foundation-runtime">{{ site.data.keys.mf_server }} 管理服务、{{ site.data.keys.mf_server }} 实时更新服务和 {{ site.data.keys.product_adj }} 运行时的约束</a>。</li>
                                </ul>
                            </li>
                            <li>在各自信任库的所有服务器之间交换签署者证书。
			    <br/><br/>
                            因为必须启用安全性，所以此步骤是使用 WebSphere Application Server Full Profile 或 Liberty 的场所必需的。此外，对于 Liberty 场，必须在每台服务器上复制相同的 LTPA 配置以确保单点登录功能。要执行此配置，请遵循<a href="#configuring-a-server-farm-manually">手动配置服务器场</a> 的步骤 6 中的准则。
			    </li>
                        </ul>
                    </li>
                    <li>针对场的每台服务器运行 Server Configuration Tool。所有服务器必须共享相同数据库。确保在<b>应用程序服务器设置</b>面板中选择部署类型：<b>服务器场部署</b>。有关该工具的更多信息，请参阅<a href="#running-the-server-configuration-tool">运行 Server Configuration Tool</a>。
		    </li>
                </ol>
            </div>
        </div>
    </div>
</div>

### 使用 Ant 任务安装服务器场
{: #installing-a-server-farm-with-ant-tasks }
使用 Ant 任务，根据用于服务器场每个成员的单个应用程序服务器类型的需求，在场中配置每台服务器。

在使用 Ant 任务规划服务器场时，首先创建独立服务器，然后配置其各自的信任库，从而可以通过安全方式相互通信。然后，运行 Ant 任务以配置 {{ site.data.keys.mf_server }} 组件共享的数据库实例。最后，运行 Ant 任务以将 {{ site.data.keys.mf_server }} 组件部署到每台服务器并修改其配置以使其成为服务器场的成员。

<div class="panel-group accordion" id="installing-mobilefirst-server-ant" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="server-farm-ant">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#server-farm-ct" href="#collapse-server-farm-ant" aria-expanded="true" aria-controls="collapse-server-farm-ant"><b>单击以获取有关使用 Ant 任务安装服务器场的指示信息</b></a>
            </h4>
        </div>

        <div id="collapse-server-farm-ant" class="panel-collapse collapse" role="tabpanel" aria-labelledby="server-farm-ant">
            <div class="panel-body">
                <p>{{ site.data.keys.mf_server }} 需要配置安全的 JMX 连接。</p>

                <ol>
                    <li>准备必须配置为服务器场成员的应用程序服务器。
		    <ul>
                            <li>选择要用于配置服务器场成员的应用程序服务器的类型。{{ site.data.keys.product }} 支持服务器场中的以下应用程序服务器：
                                <ul>
                                    <li>WebSphere Application Server Full Profile。<b>注：</b>在场拓扑中，不能使用 RMI JMX 接口。在此拓扑中，{{ site.data.keys.product }} 仅支持 SOAP 接口。</li>
                                    <li>WebSphere Application Server Liberty Profile</li>
                                    <li>Apache Tomcat</li>
                                </ul>
                                要了解哪些版本的应用程序服务器受支持，请参阅<a href="../../../product-overview/requirements">系统需求</a>。

                                <blockquote><b>要点：</b> {{ site.data.keys.product }} 只支持同类服务器场。在连接相同类型的应用程序服务器时，服务器场为同类。尝试关联不同类型的应用程序服务器可能会导致运行时出现不可预测的行为。例如，混用 Apache Tomcat 服务器和 WebSphere Application Server FullProfile 服务器的场是无效的配置。</blockquote>
                            </li>
                            <li>设置与希望包含在场中的成员数一样多的独立服务器。
			    <br/><br/>
                            其中的每个独立服务器都必须与同一个数据库通信。您必须确保其中的任意服务器使用的任何端口均没有被同一主机上配置的另一个服务器使用。此约束适用于 HTTP、HTTPS、REST、SOAP 和 RMI 协议所使用的端口。
                            <br/><br/>
                            其中每台服务器必须部署 {{ site.data.keys.mf_server }} 管理服务、{{ site.data.keys.mf_server }} 实时更新服务以及一个或多个 {{ site.data.keys.product_adj }} 运行时。
			    <br/><br/>
                            有关设置服务器的更多信息，请参阅<a href="../topologies/#constraints-on-mobilefirst-server-administration-service-mobilefirst-server-live-update-service-and-mobilefirst-foundation-runtime">{{ site.data.keys.mf_server }} 管理服务、{{ site.data.keys.mf_server }} 实时更新服务和 {{ site.data.keys.product_adj }} 运行时的约束</a>。</li>
                            <li>在各自信任库的所有服务器之间交换签署者证书。
			    <br/><br/>
                            因为必须启用安全性，所以此步骤是使用 WebSphere Application Server Full Profile 或 Liberty 的场所必需的。此外，对于 Liberty 场，必须在每台服务器上复制相同的 LTPA 配置以确保单点登录功能。要执行此配置，请遵循<a href="#configuring-a-server-farm-manually">手动配置服务器场</a> 的步骤 6 中的准则。
			    </li>
                        </ul>
                    </li>
                    <li>针对管理服务、实时更新服务和运行时配置数据库。
		    <ul>
                            <li>决定想要使用的数据库，并选择 Ant 文件以在 <b>mfp_install_dir/MobileFirstServer/configuration-samples</b> 目录中创建和配置数据库：
			    <ul>
                                    <li>对于 DB2，使用 <b>create-database-db2.xml</b>。</li>
                                    <li>对于 MySQL，使用 <b>create-database-mysql.xml</b>。</li>
                                    <li>对于 Oracle，使用 <b>create-database-oracle.xml</b>。</li>
                                </ul>
                                <blockquote>注：请勿在场拓扑中使用 Derby 数据库，因为 Derby 数据库一次只允许一个连接。</blockquote>

                            </li>
                            <li>编辑 Ant 文件并输入数据库的所有必需属性。
                            <br/><br/>
                            要启用 {{ site.data.keys.mf_server }} 组件使用的数据库的配置，请设置以下属性的值：
                                <ul>
                                    <li>将 <b>mfp.process.admin</b> 设置为 <b>true</b>。针对管理服务和实时更新服务配置数据库。</li>
                                    <li>将 <b>mfp.process.runtime</b> 设置为 <b>true</b>。针对运行时配置数据库。</li>
                                </ul>
                            </li>
                            <li>从 <b>mfp_install_dir/MobileFirstServer/configuration-samples</b> 目录运行以下命令，其中必须将 <b>create-database-ant-file.xml</b> 替换为您选择的实际 Ant 文件名：<code>mfp_install_dir/shortcuts/ant -f create-database-ant-file.xml admdatabases</code> 和 <code>mfp_install_dir/shortcuts/ant -f create-database-ant-file.xml rtmdatabases</code>。
                            <br/><br/>
                            因为在场中的应用程序服务器之间共享 {{ site.data.keys.mf_server }} 数据库，因此必须仅运行这两个命令一次，而无论场中服务器的数量。
                            </li>
                            <li>（可选）如果想要安装其他运行时，那么必须使用其他数据库名称或模式配置其他数据库。要执行此操作，请编辑 Ant 文件，修改属性，然后运行以下命令一次，而无论场中服务器的数量：<code>mfp_install_dir/shortcuts/ant -f create-database-ant-file.xml rtmdatabases</code>。</li>
                        </ul>
                    </li>
                    <li>在服务器上部署管理服务、实时更新服务和运行时，并将这些服务器配置为服务器场的成员。
                        <ul>
                            <li>在 <b>mfp\_install\_dir/MobileFirstServer/configuration-samples</b> 目录中选择与您的应用程序服务器和数据库相对应的 Ant 文件，以在服务器上部署管理服务、实时更新服务和运行时。
                            <br/><br/>
                            例如，选择 <b>configure-liberty-db2.xml</b> 文件以在包含 DB2 数据库的 Liberty 服务器上部署。生成此文件的副本，数量与场中想要的成员数量相同。
                            <br/><br/>
                            <b>注：</b>在配置后保留这些文件，因为可复用于升级已部署的 {{ site.data.keys.mf_server }} 组件，或者复用于从场的每个成员中卸载这些组件。</li>
                            <li>编辑每个 Ant 文件副本，输入在步骤 2 中使用的数据库的相同属性，并输入应用程序服务器的其他必需属性。
                            <br/><br/>
                            要将服务器配置为服务器场成员，请设置以下属性的值：
                                <ul>
                                    <li>将 <b>mfp.farm.configure</b> 设置为 true。</li>
                                    <li><b>mfp.farm.server.id</b>：为此服务器场成员定义的标识。确保场中的每个服务器都具有自己的唯一标识。如果场中的两个服务器具有相同标识，那么该场可能会以不可预测的方式运行。</li>
                                    <li><b>mfp.config.service.user</b>：用于访问实时更新服务的用户名。对于场的所有成员，该用户名必须相同。</li>
                                    <li><b>mfp.config.service.password</b>：用于访问实时更新服务的密码。对于场的所有成员，该密码必须相同。</li>
                                </ul>
                                要支持在服务器上部署 {{ site.data.keys.mf_server }} 组件的 WAR 文件，请设置以下属性的值：
                                    <ul>
                                        <li>将 <b>mfp.process.admin</b> 设置为 <b>true</b>。部署管理服务和实时更新服务的 WAR 文件。</li>
                                        <li>将 <b>mfp.process.runtime</b> 设置为 <b>true</b>。部署运行时的 WAR 文件。</li>
                                    </ul>
                                <br/>
                                <b>注：</b>如果计划在场的服务器上安装多个运行时，那么指定属性 id 并设置对于 <b>installmobilefirstruntime</b>、<b>updatemobilefirstruntime</b> 和 <b>uninstallmobilefirstruntime</b> Ant 任务上的每个运行时必须唯一的值。
                                <br/>
                                例如，
{% highlight xml %}
<target name="rtminstall">
    <installmobilefirstruntime execute="true" contextroot="/runtime1" id="rtm1">
{% endhighlight %}
                            </li>
                            <li>对于每个服务器，运行以下命令，其中必须将 <b>configure-appserver-database-ant-file.xml</b> 替换为您选择的实际 Ant 文件名：<code>mfp_install_dir/shortcuts/ant -f configure-appserver-database-ant-file.xml adminstall</code> 和 <code>mfp_install_dir/shortcuts/ant -f configure-appserver-database-ant-file.xml rtminstall</code>。
                            <br/><br/>
                            这些命令运行 <b>installmobilefirstadmin</b> 和 <b>installmobilefirstruntime</b> Ant 任务。有关这些任务的更多信息，请参阅<a href="../installation-reference/#ant-tasks-for-installation-of-mobilefirst-operations-console-mobilefirst-server-artifacts-mobilefirst-server-administration-and-live-update-services">用于安装 {{ site.data.keys.mf_console }}、{{ site.data.keys.mf_server }} 工件、{{ site.data.keys.mf_server }} 管理和实时更新服务的 Ant 任务</a>以及<a href="../installation-reference/#ant-tasks-for-installation-of-mobilefirst-runtime-environments">用于安装 {{ site.data.keys.product_adj }} 运行时环境的 Ant 任务</a>。
                            </li>
                            <li>（可选）如果想要安装其他运行时，请执行以下步骤：
                                <ul>
                                    <li>生成在步骤 3.b 中配置的 Ant 文件的副本。</li>
                                    <li>编辑副本，设置不同的上下文根，并针对 <b>installmobilefirstruntime</b>、<b>updatemobilefirstruntime</b> 和 <b>uninstallmobilefirstruntime</b> 的 <b>id</b> 属性设置与其他运行时配置不同的值。</li>
                                    <li>在场的每台服务器上运行以下命令，其中 <b>configure-appserver-database-ant-file2.xml</b> 必须替换为编辑的 Ant 文件的实际名称：<code>mfp_install_dir/shortcuts/ant -f configure-appserver-database-ant-file2.xml rtminstall</code>。</li>
                                    <li>针对场的每台服务器重复此步骤。</li>
                                </ul>
                            </li>                            
                        </ul>
                    </li>
                    <li>重新启动所有服务器。</li>
                </ol>
            </div>
        </div>
    </div>
</div>

### 手动配置服务器场
{: #configuring-a-server-farm-manually }
您必须根据用于服务器场每个成员的单个应用程序服务器类型的需求，在场中配置每个服务器。

在您计划服务器场时，请先创建与同一个数据库实例通信的独立服务器。然后，修改这些服务器的配置以使其成为服务器场的成员。

<div class="panel-group accordion" id="configuring-manually" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="manual">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#websphere-prereq" href="#collapse-manual" aria-expanded="true" aria-controls="collapse-manual"><b>单击以获取有关手动配置服务器场的指示信息</b></a>
            </h4>
        </div>

        <div id="collapse-manual" class="panel-collapse collapse" role="tabpanel" aria-labelledby="manual">
            <div class="panel-body">
                <ol>
                    <li>选择要用于配置服务器场成员的应用程序服务器的类型。{{ site.data.keys.product }} 支持服务器场中的以下应用程序服务器：
                        <ul>
                            <li>WebSphere Application Server Full Profile<br/>
                            <b>注：</b>在场拓扑中，不能使用 RMI JMX 接口。在此拓扑中，{{ site.data.keys.product }} 仅支持 SOAP 接口。</li>
                            <li>WebSphere Application Server Liberty Profile</li>
                            <li>Apache Tomcat</li>
                        </ul>
                        要了解哪些版本的应用程序服务器受支持，请参阅<a href="../../../product-overview/requirements">系统需求</a>。

                        <blockquote><b>要点：</b> {{ site.data.keys.product }} 只支持同类服务器场。在连接相同类型的应用程序服务器时，服务器场为同类。尝试关联不同类型的应用程序服务器可能会导致运行时出现不可预测的行为。例如，混用 Apache Tomcat 服务器和 WebSphere Application Server Full Profile 服务器的场是无效的配置。</blockquote>
                    </li>
                    <li>决定要使用的数据库。您可以从下列各项中进行选择：
		    <ul>
                            <li>DB2</li>
                            <li>MySQL</li>
                            <li>Oracle</li>
                        </ul>
                        在场中的应用程序服务器之间共享 {{ site.data.keys.mf_server }} 数据库，这表示：
			<ul>
                            <li>仅创建一次数据库，而不管场中的服务器数量如何。</li>
                            <li>不能在场拓扑中使用 Derby 数据库，因为 Derby 数据库一次只允许一个连接。</li>
                        </ul>
                        有关数据库的更多信息，请参阅<a href="../databases">设置数据库</a>。
			</li>
                    <li>设置与希望包含在场中的成员数一样多的独立服务器。
		    <ul>
                            <li>其中的每个独立服务器都必须与同一个数据库通信。您必须确保其中的任意服务器使用的任何端口均没有被同一主机上配置的另一个服务器使用。此约束适用于 HTTP、HTTPS、REST、SOAP 和 RMI 协议所使用的端口。</li>
                            <li>其中每台服务器必须部署 {{ site.data.keys.mf_server }} 管理服务、{{ site.data.keys.mf_server }} 实时更新服务以及一个或多个 {{ site.data.keys.product_adj }} 运行时。</li>
                            <li>当其中每个服务器都在独立拓扑中正常工作时，可以将其转变到服务器场的成员中。</li>
                        </ul>
                    </li>
                    <li>停止所有旨在成为场成员的服务器。</li>
                    <li>为应用程序服务器类型适当地配置每个服务器。<br/>您必须正确设置某些 JNDI 属性。在服务器场拓扑中，对于场的所有成员，mfp.config.service.user 和mfp.config.service.password JNDI 属性必须具有相同的值。对于 Apache Tomcat，您还必须检查 JVM 参数是否已正确定义。
<ul>
                            <li><b>WebSphere Application Server Liberty Profile</b>
                                <br/>
                                在 server.xml 文件中，设置显示在以下样本代码中的 JNDI 属性。
{% highlight xml %}
<jndiEntry jndiName="mfp.topology.clustermode" value="Farm"/>
<jndiEntry jndiName="mfp.admin.serverid" value="farm_member_1"/>
<jndiEntry jndiName="mfp.admin.jmx.user" value="myRESTConnectorUser"/>
<jndiEntry jndiName="mfp.admin.jmx.pwd" value="password-of-rest-connector-user"/>
<jndiEntry jndiName="mfp.admin.jmx.host" value="93.12.0.12"/>
<jndiEntry jndiName="mfp.admin.jmx.port" value="9443"/>
{% endhighlight %}
                                必须使用相应的值设置这些属性：
				<ul>
                                    <li><b>mfp.admin.serverid</b>：您为该场成员定义的标识。该标识在所有场成员中必须唯一。</li>
                                    <li><b>mfp.admin.jmx.user</b> 和 <b>mfp.admin.jmx.pwd</b>：这些值必须与 <code>administrator-role</code> 元素中声明的用户的凭证匹配。</li>
                                    <li><b>mfp.admin.jmx.host</b>：将此参数设置为远程成员用于访问此服务器的 IP 或主机名。因此，请勿将其设置为 <b>localhost</b>。该主机名将由场的其他成员使用，并且必须可供所有场成员访问。</li>
                                    <li><b>mfp.admin.jmx.port</b>：将此参数设置为用于 JMX REST 连接的服务器 HTTPS 端口。您可以在 <b>server.xml</b> 文件的 <code>httpEndpoint</code> 元素中查找值。</li>
                                </ul>
                            </li>
                            <li><b>Apache Tomcat</b>
                                <br/>
                                修改 <b>conf/server.xml</b> 文件以在管理服务上下文和每个运行时上下文中设置以下 JNDI 属性。
{% highlight xml %}
<Environment name="mfp.topology.clustermode" value="Farm" type="java.lang.String" override="false"/>
<Environment name="mfp.admin.serverid" value="farm_member_1" type="java.lang.String" override="false"/>
{% endhighlight %}
                                必须将 <b>mfp.admin.serverid</b> 属性设置为对该场成员定义的标识。该标识在所有场成员中必须唯一。
				<br/>
				您必须确保将 <code>-Djava.rmi.server.hostname</code> JVM 参数设置为远程成员用于访问此服务器的 IP 或主机名。因此，请勿将其设置为 <b>localhost</b>。此外，必须确保用于设置 <code>-Dcom.sun.management.jmxremote.port</code> JVM 参数的端口尚未被使用，才能启用 JMX RMI 连接。在 <b>CATALINA_OPTS</b> 环境变量中设置这两个参数。
				</li>
                            <li><b>WebSphere Application Server Full Profile</b>
                                <br/>
                                您必须在服务器上部署的管理服务和每个运行时应用程序中声明以下 JNDI 属性。
				<ul>
                                    <li><b>mfp.topology.clustermode</b></li>
                                    <li><b>mfp.admin.serverid</b></li>
                                </ul>
                                在 WebSphere Application Server 控制台中，
				<ul>
                                    <li>选择 <b>应用程序 → 应用程序类型 → WebSphere 企业应用程序</b>。</li>
                                    <li>选择管理服务应用程序。</li>
                                    <li>在 <b>Web 模块属性</b>中，单击 <b>Web 模块的环境条目</b>以显示 JNDI 属性。</li>
                                    <li>设定以下属性的值。
				    <ul>
                                            <li>将 <b>mfp.topology.clustermode</b> 设置为 <b>Farm</b>。</li>
                                            <li>将 <b>mfp.admin.serverid</b> 设置为对该场成员选择的标识。该标识在所有场成员中必须唯一。</li>
                                            <li>将 <b>mfp.admin.jmx.user</b> 设置为有权访问 SOAP 连接器的用户名。</li>
                                            <li>将 <b>mfp.admin.jmx.pwd</b> 设置为在 <b>mfp.admin.jmx.user</b> 中声明的用户的密码。</li>
                                            <li>将 <b>mfp.admin.jmx.port</b> 设置为 SOAP 端口值。</li>
                                        </ul>
                                    </li>
                                    <li>验证 <b>mfp.admin.jmx.connector</b> 是否设置为 <b>SOAP</b>。</li>
                                    <li>单击<b>确定</b>并保存配置。</li>
                                    <li>对部署在服务器上的每个 {{ site.data.keys.product_adj }} 运行时应用程序进行类似更改。</li>
                                </ul>
                            </li>
                        </ul>
                    </li>
                    <li>在场的所有成员之间交换信任库中的服务器证书。使用 WebSphere Application Server Full Profile 和 WebSphere Application Server Liberty Profile 的场必须交换信任库中的服务器证书，因为这些场中服务器之间的通信由 SSL 提供保护。
<ul>
                            <li><b>WebSphere Application Server Liberty Profile</b>
                                <br/>
                                您可以使用 IBM 实用程序（如 Keytool 或 iKeyman）配置信任库。
				<ul>
                                    <li>有关 Keytool 的更多信息，请参阅 IBM SDK Java Technology Edition 中的 <a href="http://www-01.ibm.com/support/knowledgecenter/?lang=en#!/SSYKE2_6.0.0/com.ibm.java.security.component.60.doc/security-component/keytoolDocs/keytool_overview.html">Keytool</a>。</li>
                                    <li>有关 iKeyman 的更多信息，请参阅 IBM SDK Java Technology Edition 中的 <a href="http://www-01.ibm.com/support/knowledgecenter/?lang=en#!/SSYKE2_6.0.0/com.ibm.java.security.component.60.doc/security-component/ikeyman_tool.html">iKeyman</a>。</li>
                                </ul>
                                在 <b>server.xml</b> 文件中定义了密钥库和信任库的位置。请参阅 <a href="http://www.ibm.com/support/knowledgecenter/SSD28V_8.5.5/com.ibm.websphere.wlp.core.doc/ae/rwlp_ssl.html?lang=en&view=kc">SSL 配置属性</a>中的 <b>keyStoreRef</b> 和 <b>trustStoreRef</b> 属性。缺省情况下，Liberty Profile 的密钥库位于 <b>${server.config.dir}/resources/security/key.jks</b> 中。如果信任库引用缺失或者未在 <b>server.xml</b> 文件中进行定义，那么将使用 <b>keyStoreRef</b> 所指定的密钥库。服务器将使用缺省密钥库，并且会在服务器首次运行时创建该文件。在这种情况下，将创建缺省证书，其有效期为 365 天。对于生产环境，您可能要考虑使用自己的证书（如果需要，包括中间证书）或者更改已生成证书的到期日期。
			
				<blockquote>注：如果您要确认信任库的位置，那么可以将以下声明添加到 server.xml 文件来实现这一点：
{% highlight xml %}
<logging traceSpecification="SSL=all:SSLChannel=all"/>
{% endhighlight %}
                                </blockquote>
                                最后，启动服务器，并在 <b>${wlp.install.dir}/usr/servers/server_name/logs/trace.log</b> 文件中查找包含 com.ibm.ssl.trustStore 的行。
				<ul>
                                    <li>将场中其他服务器的公用证书导入到服务器的 <b>server.xml</b> 配置文件所引用的信任库中。教程<a href="../tutorials/graphical-mode">以图形方式安装 {{ site.data.keys.mf_server }}</a> 为您提供指示信息以在场中的两个 Liberty 服务器之间交换证书。有关更多信息，请参阅<a href="../tutorials/graphical-mode/#creating-a-farm-of-two-liberty-servers-that-run-mobilefirst-server">创建由两台运行 {{ site.data.keys.mf_server }} 的 Liberty 服务器组成的场</a>部分。</li>
                                    <li>重新启动 WebSphere Application Server Liberty Profile 的每个实例，以使安全配置生效。需要执行以下步骤来使单点登录 (SSO) 生效。</li>
                                    <li>启动场的一个成员。在缺省 LTPA 配置中，在 Liberty 服务器成功启动之后，将生成 LTPA 密钥库 <b>${wlp.user.dir}/servers/server_name/resources/security/ltpa.keys。</b></li>
                                    <li>将 <b>ltpa.keys</b> 文件复制到每个场成员 <b>${wlp.user.dir}/servers/server_name/resources/security</b> 目录，以在场成员中复制 LTPA 密钥库。有关 LTPA 配置的更多信息，请参阅 <a href="http://www.ibm.com/support/knowledgecenter/?view=kc#!/SSAW57_8.5.5/com.ibm.websphere.wlp.nd.multiplatform.doc/ae/twlp_sec_ltpa.html">在 Liberty Profile 上配置 LTPA</a>。</li>
                                </ul>
                            </li>
                            <li><b>WebSphere Application Server Full Profile</b>
                                <br/>
                                在 WebSphere Application Server 管理控制台中配置信任库。
				<ul>
                                    <li>登录到 WebSphere Application Server 管理控制台。</li>
                                    <li>选择<b>安全性 → SSL 证书和密钥管理</b>。</li>
                                    <li>在“<b>相关项</b>”中，选择<b>密钥库和证书</b>。</li>
                                    <li>在<b>密钥库使用情况</b>字段中，确保选择 <b>SSL 密钥库</b>。您现在可以从场中的所有其他服务器导入证书。</li>
                                    <li>单击 <b>NodeDefaultTrustStore</b>。</li>
                                    <li>在“<b>其他属性</b>”中，选择<b>签署者证书</b>。</li>
                                    <li>单击<b>从端口检索</b>。您现在可以输入场中其他每个服务器的通信和安全详细信息。对每个其他场成员执行接下来的步骤。</li>
                                    <li>在<b>主机</b>字段中，输入服务器主机名或 IP 地址。</li>
                                    <li>在<b>端口</b>字段中，输入 HTTPS 传输 (SSL) 端口。</li>
                                    <li>在<b>针对出站连接的 SSL 配置</b>中选择 <b>NodeDefaultSSLSettings</b>。</li>
                                    <li>在<b>别名</b>字段中，输入该签署者证书的别名。</li>
                                    <li>单击<b>检索签署者信息</b>。</li>
                                    <li>查看从远程服务器检索的信息，然后单击<b>确定</b>。</li>
                                    <li>单击<b>保存</b>。</li>
                                    <li>重新启动服务器。</li>
                                </ul>    
                            </li>
                        </ul>
                    </li>
                </ol>
            </div>
        </div>
    </div>
</div>

### 验证场配置
{: #verifying-a-farm-configuration }
本任务的目的是检查场成员的状态并验证场配置是否正确。

1. 启动场的所有服务器。
2. 访问 {{ site.data.keys.mf_console }}。例如，**http://server_name:port/mfpconsole** 或 **https://hostname:secure_port/mfpconsole**（在 HTTPS 中）。
    在控制台侧边栏中，会显示一个额外菜单，此菜单标记为服务器场节点。
3. 单击**服务器场节点**，以访问已注册场成员及其状态的列表。在以下示例中，将标识为 **FarmMember2** 的节点视为宕机，这指示该服务器可能已发生故障，需要一些维护。

![{{ site.data.keys.mf_console }} 中场节点的状态](farm_nodes_status_list.jpg)

### 服务器场节点的生命周期
{: #lifecycle-of-a-server-farm-node }
您可以配置脉动信号速率和超时值，以通过触发受影响节点状态中的更改来指示场成员中可能的服务器问题。

#### 注册并监控作为场节点的服务器
{: #registration-and-monitoring-servers-as-farm-nodes }
启动配置为场节点的服务器后，该服务器上的管理服务会自动将其注册为新的场成员。
关闭场成员后，会自动将其从场注销。

存在脉动信号机制，用于保持跟踪可能变得无响应（例如，由于断电或服务器故障）的场成员。在该脉动信号机制中，{{ site.data.keys.product_adj }} 运行时会以指定速率向 {{ site.data.keys.product_adj }} 管理服务定期发送脉动信号。如果 {{ site.data.keys.product_adj }} 管理服务注意到自场成员发送脉动信号后过去了太长时间，那么会将场成员视为宕机。

视为宕机的场成员不会向移动应用程序提供更多请求。

一个或多个节点宕机不会阻止场的其他成员向移动应用程序正确提供请求服务，也不会阻止接受通过 {{ site.data.keys.mf_console }} 触发的新管理操作。

#### 配置脉动信号速率和超时值
{: #configuring-the-heartbeat-rate-and-timeout-values }
您可以通过定义以下 JNDI 属性，配置脉动信号速率和超时值：

* **mfp.admin.farm.heartbeat**
* **mfp.admin.farm.missed.heartbeats.timeout**

<br/>
有关 JNDI 属性的更多信息，请参阅 [{{ site.data.keys.mf_server }} 管理服务的 JNDI 属性列表](../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service)。
