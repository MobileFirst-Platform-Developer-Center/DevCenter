---
layout: tutorial
title: Installing MobileFirst Server to an application server
breadcrumb_title: Installing MobileFirst Server
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{: #overview }
The installation of the components can be done by using Ant Tasks, the Server Configuration Tool, or manually. Find out the prerequisite and the details about the installation process so that you can install the components on the application server successfully.

Before you proceed with installing the components to the application server, ensure that the databases and the tables for the components are prepared and ready to use. For more information, see [Setting up databases](../databases).

The server topology to install the components must also be defined. See [Topologies and network flows](../topologies).

#### Jump to
{: #jump-to }

* [Application server prerequisites](#application-server-prerequisites)
* [Installing with the Server Configuration Tool](#installing-with-the-server-configuration-tool)
* [Installing with Ant tasks](#installing-with-ant-tasks)
* [Installing the {{ site.data.keys.mf_server }} components manually](#installing-the-mobilefirst-server-components-manually)
* [Installing a server farm](#installing-a-server-farm)

## Application server prerequisites
{: #application-server-prerequisites }
Depending on your choice of the application server, select one of the following topics to find out the prerequisites that you must fulfill before you install the {{ site.data.keys.mf_server }} components.

* [Apache Tomcat prerequisites](#apache-tomcat-prerequisites)
* [WebSphere Application Server Liberty prerequisites](#websphere-application-server-liberty-prerequisites)
* [WebSphere Application Server and WebSphere Application Server Network Deployment prerequisites](#websphere-application-server-and-websphere-application-server-network-deployment-prerequisites)

### Apache Tomcat prerequisites
{: #apache-tomcat-prerequisites }
{{ site.data.keys.mf_server }} has some requirements for the configuration of Apache Tomcat that are detailed in the following topics.  
Ensure that you fulfill the following criteria:

* Use a supported version of Apache Tomcat. See [System requirements](../../../product-overview/requirements).
* Apache Tomcat must be run with JRE 7.0 or later.
* The JMX configuration must be enabled to allow the communication between the administration service and the runtime component. The communication uses RMI as described in **Configuring JMX connection for Apache Tomcat** below.

<div class="panel-group accordion" id="tomcat-prereq" role="tablist" aria-multiselectable="true">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="jmx-connection">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#tomcat-prereq" href="#collapse-jmx-connection" aria-expanded="true" aria-controls="collapse-jmx-connection"><b>Click for instructions on configuring JMX connection for Apache Tomcat</b></a>
            </h4>
        </div>

        <div id="collapse-jmx-connection" class="panel-collapse collapse" role="tabpanel" aria-labelledby="jmx-connection">
            <div class="panel-body">
                <p>You must configure a secure JMX connection for Apache Tomcat application server.</p>
                <p>The Server Configuration Tool and the Ant tasks can configure a default secure JMX connection, which includes the definition of a JMX remote port, and the definition of authentication properties. They modify <b>tomcat_install_dir/bin/setenv.bat</b> and <b>tomcat_install_dir/bin/setenv.sh</b> to add these options to <b>CATALINA_OPTS</b>:</p>
{% highlight xml %}
-Djava.rmi.server.hostname=localhost
-Dcom.sun.management.jmxremote.port=8686
-Dcom.sun.management.jmxremote.authenticate=false
-Dcom.sun.management.jmxremote.ssl=false
{% endhighlight %}

                <p><b>Note:</b> 8686 is a default value. The value for this port can be changed if the port is not available on the computer.</p>

                <ul>
                    <li>The <b>setenv.bat</b> file is used if you start Apache Tomcat with <b>tomcat_install_dir/bin/startup.bat</b>, or <b>tomcat_install_dir/bin/catalina.bat.</b></li>
                    <li>The <b>setenv.sh</b> file is used if you start Apache Tomcat with <b>tomcatInstallDir/bin/startup.sh</b>, or <b>tomcat_install_dir/bin/catalina.sh.</b></li>
                </ul>

                <p>This file might not be used if you start Apache Tomcat with another command. If you installed the Apache Tomcat Windows Service Installer, the service launcher does not use <b>setenv.bat</b>.</p>

                <blockquote><b>Important:</b> This configuration is not secure by default. To secure the configuration, you must manually complete steps 2 and 3 of the following procedure.</blockquote>

                <p>Manually configuring Apache Tomcat:</p>

                <ol>
                    <li>For a simple configuration, add the following options to <b>CATALINA_OPTS</b>:

{% highlight xml %}
-Djava.rmi.server.hostname=localhost
-Dcom.sun.management.jmxremote.port=8686
-Dcom.sun.management.jmxremote.authenticate=false
-Dcom.sun.management.jmxremote.ssl=false
{% endhighlight %}
                    </li>
                    <li>To activate authentication, see the Apache Tomcat user documentation <a href="https://tomcat.apache.org/tomcat-7.0-doc/config/http.html#SSL_Support">SSL Support - BIO and NIO</a> and <a href="http://tomcat.apache.org/tomcat-7.0-doc/ssl-howto.html">SSL Configuration HOW-TO</a>.</li>
                    <li>For a JMX configuration with SSL enabled, add the following options:
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

                    <b>Note:</b> The port 8686 can be changed.</li>
                    <li>
                        <p>If the Tomcat instance is running behind a firewall, the JMX Remote Lifecycle Listener must be configured. See the Apache Tomcat documentation for <a href="http://tomcat.apache.org/tomcat-7.0-doc/config/listeners.html#JMX_Remote_Lifecycle_Listener_-_org.apache.catalina.mbeans.JmxRemoteLifecycleListener">JMX Remote Lifecycle Listener</a>.</p><p>The following environment properties must also be added to the Context section of the administration service application in the <b>server.xml</b> file, such as in the following example:</p>

{% highlight xml %}
<Context docBase="mfpadmin" path="/mfpadmin ">
    <Environment name="mfp.admin.rmi.registryPort" value="registryPort" type="java.lang.String" override="false"/>
    <Environment name="mfp.admin.rmi.serverPort" value="serverPort" type="java.lang.String" override="false"/>
</Context>
{% endhighlight %}

                        In the previous example:
                        <ul>
                            <li>registryPort must have the same value as the <b>rmiRegistryPortPlatform</b> attribute of the JMX Remote Lifecycle Listener.</li>
                            <li>serverPort must have the same value as the <b>rmiServerPortPlatform</b> attribute of the JMX Remote Lifecycle Listener.</li>
                        </ul>
                    </li>
                    <li>If you installed Apache Tomcat with the Apache Tomcat Windows Service Installer instead of adding the options to <b>CATALINA_OPTS</b>, run <b>tomcat_install_dir/bin/Tomcat7w.exe</b>, and add the options in the <b>Java</b> tab of the Properties window.

                    <img alt="Apache Tomcat 7 properties" src="Tomcat_Win_Service_Installer_properties.jpg"/></li>
                </ol>
            </div>
        </div>
    </div>
</div>

### WebSphere Application Server Liberty prerequisites
{: #websphere-application-server-liberty-prerequisites }
{{ site.data.keys.product_full }}has some requirements for the configuration of the Liberty server that are detailed in the following topics.  

Ensure that you fulfill the following criteria:

* Use a supported version of Liberty. See [System requirements](../../../product-overview/requirements).
* Liberty must be run with JRE 7.0 or later. JRE 6.0 is not supported.
* Some versions of Liberty support both the features of Java EE 6 and Java EE 7. For example, jdbc-4.0 Liberty feature is part of Java EE 6, whereas jdbc-4.1 Liberty feature is part of Java EE 7. {{ site.data.keys.mf_server }} V8.0.0 can be installed with Java EE 6 or Java EE 7 features. However, if you want to run an older version of {{ site.data.keys.mf_server }} on the same Liberty server, you must use the Java EE 6 features. {{ site.data.keys.mf_server }} V7.1.0 and earlier, does not support the Java EE 7 features.
* JMX must be configured as documented in **Configuring JMX connection for WebSphere Application Server Liberty profile** below.
* For an installation in a production environment, you might want to start the Liberty server as a service on Windows, Linux, or UNIX systems so that:
The {{ site.data.keys.mf_server }} components are started automatically when the computer starts.
The process that runs Liberty server is not stopped when the user, who started the process, logs out.
* {{ site.data.keys.mf_server }} V8.0.0 cannot be deployed in a Liberty server that contains the deployed {{ site.data.keys.mf_server }} components from the previous versions.
* For an installation in a Liberty collective environment, the Liberty collective controller and the Liberty collective cluster members must be configured as documented in [Configuring a Liberty collective](http://www.ibm.com/support/knowledgecenter/SSAW57_8.5.5/com.ibm.websphere.wlp.nd.doc/ae/tagt_wlp_configure_collective.html?view=kc).

<div class="panel-group accordion" id="websphere-prereq" role="tablist" aria-multiselectable="true">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="websphere-jmx-connection">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#websphere-prereq" href="#collapse-websphere-jmx-connection" aria-expanded="true" aria-controls="collapse-websphere-jmx-connection"><b>Click for instructions on configuring JMX connection for WebSphere Application Server Liberty profile</b></a>
            </h4>
        </div>

        <div id="collapse-websphere-jmx-connection" class="panel-collapse collapse" role="tabpanel" aria-labelledby="websphere-jmx-connection">
            <div class="panel-body">
                <p>{{ site.data.keys.mf_server }} requires the secure JMX connection to be configured.</p>

                <ul>
                    <li>The Server Configuration Tool and the Ant tasks can configure a default secure JMX connection, which includes the generation of a self-signed SSL certificate with a validity period of 365 days. This configuration is not intended for production use.</li>
                    <li>To configure the secure JMX connection for production use, follow the instructions as described in <a href="http://www.ibm.com/support/knowledgecenter/SSD28V_8.5.5/com.ibm.websphere.wlp.core.doc/ae/twlp_admin_restconnector.html?cp=SSD28V_8.5.5&view=embed">Configuring secure JMX connection to the Liberty profile</a>.</li>
                    <li>The rest-connector is available for WebSphere  Application Server, Liberty Core, and other editions of Liberty, but it is possible to package a Liberty server with a subset of the available features. To verify that the rest-connector feature is available in your installation of Liberty, enter the following command:
{% highlight bash %}                    
liberty_install_dir/bin/productInfo featureInfo
{% endhighlight %}
                    <b>Note:</b> Verify that the output of this command contains restConnector-1.0.</li>
                </ul>
            </div>
        </div>
    </div>
</div>

### WebSphere Application Server and WebSphere Application Server Network Deployment prerequisites
{: #websphere-application-server-and-websphere-application-server-network-deployment-prerequisites }
{{ site.data.keys.mf_server }} has some requirements for the configuration of WebSphere  Application Server and WebSphere Application Server Network Deployment that are detailed in the following topics.  
Ensure that you fulfill the following criteria:

* Use a supported version of WebSphere Application Server. See [System requirements](../../../product-overview/requirements).
* The application server must be run with JRE 7.0. By default, WebSphere Application Server uses Java 6.0 SDK. To switch to Java 7.0 SDK, see [Switching to Java 7.0 SDK in WebSphere Application Server](https://www.ibm.com/support/knowledgecenter/SSWLGF_8.5.5/com.ibm.sr.doc/twsr_java17.html).
* The administrative security must be turned on. {{ site.data.keys.mf_console }}, the {{ site.data.keys.mf_server }} administration service, and the {{ site.data.keys.mf_server }} configuration service are protected by security roles. For more information, see [Enabling security](https://www.ibm.com/support/knowledgecenter/SSEQTP_8.5.5/com.ibm.websphere.base.doc/ae/tsec_csec2.html?cp=SSEQTP_8.5.5%2F1-8-2-31-0-2&lang=en).
* The JMX configuration must be enabled to allow the communication between the administration service and the runtime component. The communication uses SOAP. For WebSphere Application Server Network Deployment, RMI can be used. For more information, see **Configuring JMX connection for WebSphere Application Server and WebSphere Application Server Network Deployment** below.

<div class="panel-group accordion" id="websphere-nd-prereq" role="tablist" aria-multiselectable="true">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="websphere-nd-jmx-connection">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#websphere-nd-prereq" href="#collapse-websphere-nd-jmx-connection" aria-expanded="true" aria-controls="collapse-websphere-nd-jmx-connection"><b>Click for instructions on configuring JMX connection for WebSphere Application Server and WebSphere Application Server Network Deployment</b></a>
            </h4>
        </div>

        <div id="collapse-websphere-nd-jmx-connection" class="panel-collapse collapse" role="tabpanel" aria-labelledby="websphere-nd-jmx-connection">
            <div class="panel-body">
                <p>{{ site.data.keys.mf_server }} requires the secure JMX connection to be configured.</p>

                <ul>
                    <li>{{ site.data.keys.mf_server }} requires access to the SOAP port, or the RMI port to perform JMX operations. By default, the SOAP port is active on a WebSphere Application Server. {{ site.data.keys.mf_server }} uses the SOAP port by default. If both the SOAP and RMI ports are deactivated, {{ site.data.keys.mf_server }} does not run.</li>
                    <li>RMI is only supported by WebSphere Application Server Network Deployment. RMI is not supported by a stand-alone profile, or a WebSphere Application Server server farm.</li>
                    <li>You must activate Administrative and Application Security.</li>
                </ul>
            </div>
        </div>
    </div>
</div>

### File system prerequisites
{: #file-system-prerequisites }
To install {{ site.data.keys.mf_server }} to an application server, the {{ site.data.keys.product_adj }} installation tools must be run by a user that has specific file system privileges.  
The installation tools include:

* IBM  Installation Manager
* The Server Configuration Tool
* The Ant tasks to deploy {{ site.data.keys.mf_server }}

For WebSphere  Application Server Liberty profile, you must have the required permission to perform the following actions:

* Read the files in the Liberty installation directory.
* Create files in the configuration directory of the Liberty server, which is typically usr/servers/server-name, to create backup copies and modify server.xml and jvm.options.
* Create files and directories in the Liberty shared resource directory, which is typically usr/shared.
* Create files in the Liberty server apps directory, which is typically usr/servers/server-name/apps.

For WebSphere Application Server full profile and WebSphere Application Server Network Deployment, you must have the required permission to perform the following actions:

* Read the files in the WebSphere Application Server installation directory.
* Read the configuration file of the selected WebSphere Application Server full profile or of the Deployment Manager profile.
* Run the wsadmin command.
* Create files in the profiles configuration directory. The installation tools put resources such as shared libraries or JDBC drivers in that directory.

For Apache Tomcat, you must have the required permission to perform the following actions:

* Read the configuration directory.
* Create backup files and modify files in the configuration directory, such as server.xml, and tomcat-users.xml.
* Create backup files and modify files in the bin directory, such as setenv.bat.
* Create files in the lib directory.
* Create files in the webapps directory.

For all these application servers, the user who runs the application server must be able to read the files that were created by the user who ran the {{ site.data.keys.product_adj }} installation tools.

## Installing with the Server Configuration Tool
{: #installing-with-the-server-configuration-tool }
Use the Server Configuration Tool to install the {{ site.data.keys.mf_server }} components to your application server.

The Server Configuration Tool can set up the database and install the components to an application server. This tool is meant for a single user. The configuration files are store on the disk. The directory where they are stored can be modified with menu **File → Preferences**. The files must be used only by one instance of the Server Configuration Tool at the time. The tool does not manage concurrent access to the same file. If you have multiple instances of the tool accessing the same file, the data might be lost. For more information about how the tool creates and setup the databases, see [Create the database tables with the Server Configuration Tool](../databases/#create-the-database-tables-with-the-server-configuration-tool). If the databases exist, the tool can detect them by testing the presence and the content of some test tables and does not modify these database tables.

* [Supported operating systems](#supported-operating-systems)
* [Supported topologies](#supported-topologies)
* [Running the Server Configuration Tool](#running-the-server-configuration-tool)
* [Applying a fix pack by using the Server Configuration Tool](#applying-a-fix-pack-by-using-the-server-configuration-tool)

### Supported operating systems
{: #supported-operating-systems }
You can use the Server Configuration Tool if you are on the following operating systems:

* Windows x86 or x86-64
* macOS x86-64
* Linux x86 or Linux x86-64

The tool is not available on other operating systems. You need to use Ant tasks to install the {{ site.data.keys.mf_server }} components as described in [Installing with Ant Tasks](#installing-with-ant-tasks).

### Supported topologies
{: #supported-topologies }
The Server Configuration Tool installs the {{ site.data.keys.mf_server }} components with the following topologies:

* All components ({{ site.data.keys.mf_console }}, the {{ site.data.keys.mf_server }} administration service, the {{ site.data.keys.mf_server }} live update service, and the {{ site.data.keys.product_adj }} runtime) are in the same application server. However, on WebSphere  Application Server Network Deployment when you install on a cluster, you can specify a different cluster for the administration and live update services, and for the runtime. On Liberty collective, {{ site.data.keys.mf_console }}, the administration service, and the live update service are installed in a collective controller and the runtime in a collective member.
* If the {{ site.data.keys.mf_server }} push service is installed, it is also installed on the same server. However, on WebSphere Application Server Network Deployment when you install on a cluster, you can specify a different cluster for the push service. On Liberty collective, the push service is installed in a Liberty member that can be the same as the one where the runtime is installed.
* All the components use the same database system and the user. For DB2 , all the components also use the same schema.
* The Server Configuration Tool installs the components for a single server except for Liberty collective and WebSphere Application Server Network Deployment for asymmetric deployment. For an installation on multiple servers, a farm must be configured after the tool is run. The server farm configuration is not required on WebSphere Application Server Network Deployment.

For other topologies or other database settings, you can install the components with Ant Tasks or manually instead.

### Running the Server Configuration Tool
{: #running-the-server-configuration-tool }
Before you run the Server Configuration Tool, make sure that the following requirements are fulfilled:

* The databases and the tables for the components are prepared and ready to use. See [Setting up databases](../databases).
* The server topology to install the components is decided. See [Topologies and network flows](../topologies).
* The application server is configured. See [Application server prerequisites](#application-server-prerequisites).
* The user that runs the tool has the specific file system privileges. See [File system prerequisites](#file-system-prerequisites).

<div class="panel-group accordion" id="running-the-configuration-tool" role="tablist" aria-multiselectable="true">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="configuration-tool">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#running-the-configuration-tool" href="#collapse-configuration-tool" aria-expanded="true" aria-controls="collapse-configuration-tool"><b>Click for instructions on running the Configuration Tool</b></a>
            </h4>
        </div>

        <div id="collapse-configuration-tool" class="panel-collapse collapse" role="tabpanel" aria-labelledby="configuration-tool">
            <div class="panel-body">
                <ol>
                    <li>Start the Server Configuration Tool.
                        <ul>
                            <li>On Linux, from application shortcuts <b>Applications → IBM MobileFirst Platform Server → Server Configuration Tool</b>.</li>
                            <li>On Windows, click <b>Start → Programs → IBM MobileFirst Platform Server → Server Configuration Tool</b>.</li>
                            <li>On macOS, open a shell console. Go to <b>mfp_server_install_dir/shortcuts</b> and type <b>./configuration-tool.sh</b>.</li>
                            <li>The <b>mfp_server_install_dir</b> directory is where you installed {{ site.data.keys.mf_server }}.</li>
                        </ul>
                    </li>
                    <li>Select <b>File → New Configuration</b> to create a {{ site.data.keys.mf_server }} Configuration.
                        <ul>
                            <li>In the <b>Configuration Details</b> panel, enter the context root of the administration service and the runtime component. You might want to enter an environment ID. An environment ID is used in advanced use cases, for example when <a href="../topologies/#multiple-instances-of-mobilefirst-server-on-the-same-server-or-websphere-application-server-cell">multiple installations of {{ site.data.keys.mf_server }} are made on the same application server or same WebSphere  Application Server cell</a>.</li>
                            <li>In the <b>Console Settings</b> panel, select whether to install {{ site.data.keys.mf_console }} or not. If the console is not installed, you need to use command line tools (<b>mfpdev</b> or <b>mfpadm</b>) or the REST API to interact with the {{ site.data.keys.mf_server }} administration service.</li>
                            <li>In the <b>Database Selection</b> panel, select the database management system that you plan to use. All the components use the same database type and the same database instance. For more information about the database panes, see <a href="../databases/#create-the-database-tables-with-the-server-configuration-tool">Create the database tables with the Server Configuration Tool</a>.</li>
                            <li>In the <b>Application Server Selection</b> panel, select the type of application server where you want to deploy {{ site.data.keys.mf_server }}.</li>
                        </ul>
                    </li>
                    <li>In the <b>Application Server Settings</b> panel, choose the application server and do the following steps:
                        <ul>
                            <li>For an installation on WebSphere Application Server Liberty:
                                <ul>
                                    <li>Enter the installation directory of Liberty and the name of the server where you want to install {{ site.data.keys.mf_server }}.</li>
                                    <li>You can create a default user to log in the console. This user is created in the Liberty Basic registry. For a production installation, you might want to clear the <b>Create a default user</b> option and to configure the user access after the installation. For more information, see <a href="../server-configuration/#configuring-user-authentication-for-mobilefirst-server-administration">Configuring user authentication for {{ site.data.keys.mf_server }} administration</a>.</li>
                                    <li>Select the deployment type: <b>Standalone deployment</b> (default), <b>Server farm deployment</b>, or <b>Liberty collective deployment</b>.</li>
                                </ul>

                                If the Liberty collective deployment option is selected, do the following steps:
                                <ul>
                                    <li>Specify the Liberty collective server:
                                        <ul>
                                            <li>Where the administration service, {{ site.data.keys.mf_console }} and the live update service are installed. The server must be a Liberty collective controller.</li>
                                            <li>Where the runtime is installed. The server must be a Liberty collective member.</li>
                                            <li>Where the push service is installed. The server must be a Liberty collective member.</li>
                                        </ul>
                                    </li>
                                    <li>Enter the server ID of the member. This identifier must be different for each member in the collective.</li>
                                    <li>Enter the cluster name of the collective members.</li>
                                    <li>Enter the controller host name and HTTPS port number. The values must be the same as the one that is defined in the <code>variable</code> element inside the <b>server.xml</b> file of the Liberty collective controller.</li>
                                    <li>Enter the controller administrator user name and password.</li>
                                </ul>
                            </li>
                            <li>For an installation on WebSphere Application Server or WebSphere Application Server Network Deployment:
                                <ul>
                                    <li>Enter the installation directory of WebSphere Application Server.</li>
                                    <li>Select the WebSphere Application Server profile where you want to install {{ site.data.keys.mf_server }}. If you install on WebSphere Application Server Network Deployment, select the profile of the deployment manager. On the deployment manager profile, you can select a scope (<b>Server</b> or <b>Cluster</b>). If you select <b>Cluster</b>, you must specify the cluster:
                                        <ul>
                                            <li>Where the runtime is installed.</li>
                                            <li>Where the administration service, {{ site.data.keys.mf_console }} and the live update service are installed.</li>
                                            <li>Where the push service is installed.</li>
                                        </ul>
                                    </li>
                                    <li>Enter an administrator login ID and password. The administrator user must have an administrator role.</li>
                                    <li>If you select the <b>Declare the WebSphere Administrator as an administrator user in {{ site.data.keys.mf_console }}</b> option, then the user that is used to install {{ site.data.keys.mf_server }} is mapped to the administration security role of the console and can log in to the console with administrator privileges. This user is also mapped to the security role of the live update service. The user name and password are set as JNDI properties (<b>mfp.config.service.user</b> and <b>mfp.config.service.password</b>) of the administration service.</li>
                                    <li>If you do not select the <b>Declare the WebSphere Administrator as an administrator user in {{ site.data.keys.mf_console }}</b> option, then before you can use {{ site.data.keys.mf_server }}, you must do the following tasks:
                                        <ul>
                                            <li>Enable the communication between the administration service and the live update service by:
                                                <ul>
                                                    <li>Mapping a user to the security role <b>configadmin</b> of the live update service.</li>
                                                    <li>Adding the login ID and password of this user in the JNDI properties (<b>mfp.config.service.user</b> and <b>mfp.config.service.password</b>) of the administration service.</li>
                                                    <li>Map one or more users to the security roles of the administration service and {{ site.data.keys.mf_console }}. See <a href="../server-configuration/#configuring-user-authentication-for-mobilefirst-server-administration">Configuring user authentication for {{ site.data.keys.mf_server }} administration</a>.</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                </ul>
                            </li>
                            <li>For an installation on Apache Tomcat:
                                <ul>
                                    <li>Enter the installation directory of Apache Tomcat.</li>
                                    <li>Enter the port that is used for the JMX communication with RMI. By default, the value is 8686. The Server Configuration Tool modifies the <b>tomcat_install_dir/bin/setenv.bat</b> or <b>tomcat_install_dir/bin/setenv.sh</b> file to open this port. If you want to open the port manually, or have already some code that opens the port in <b>setenv.bat</b> or <b>setenv.sh</b>, do not use the tool. Install with Ant tasks instead. An option to open the RMI port manually is provided for an installation with Ant tasks.</li>
                                    <li>Create a default user to log in the console. This user is also created in the <b>tomcat-users.xml</b> configuration file. For a production installation, you might want to clear the Create a default user option and to configure the user access after the installation. For more information, see <a href="../server-configuration/#configuring-user-authentication-for-mobilefirst-server-administration">Configuring user authentication for {{ site.data.keys.mf_server }} administration</a>.</li>
                                </ul>
                            </li>
                        </ul>
                    </li>
                    <li>In the <b>Push Service Settings</b> panel, select the <b>Install the Push service</b> option if you want the push service to be installed in the application server. The context root is <b>imfpush</b>. To enable the communication between the push service and the administration service, you need to define the following parameters:
                        <ul>
                            <li>Enter the URL of the push service and the URL of the runtime. This URL can be computed automatically if you install on Liberty, Apache Tomcat, or stand-alone WebSphere Application Server. It uses the URL of the component (the runtime or the push service) on the local server. If you install on WebSphere Application Server Network Deployment or the communications go through a web proxy or load balancer, you must enter the URL manually.</li>
                            <li>Enter the confidential client IDs and secret for the OAuth communication between the services. Otherwise, the tool generates default values and random passwords.</li>
                        </ul>
                    </li>
                    <li>In the <b>Analytics Settings</b> panel, select the <b>Enable the connection to the Analytics server</b> if {{ site.data.keys.mf_analytics }} is installed. Enter the following connection settings:
                        <ul>
                            <li>The URL of the Analytics console.</li>
                            <li>The URL of the Analytics server (the Analytics data service).</li>
                            <li>The user login ID and password that is allowed to publish data to the Analytics server.</li>
                        </ul>

                        The tool configures the runtime and the push service to send data to the Analytics server.
                    </li>
                    <li>Click <b>Deploy</b> to proceed with the installation.</li>
                </ol>
            </div>
        </div>
    </div>
</div>

After the installation is completed successfully, restart the application server in the case of Apache Tomcat or Liberty profile.

If Apache Tomcat is launched as a service, the setenv.bat or setenv.sh file that contains the statement to open the RMI might not be read. As a result, {{ site.data.keys.mf_server }} might not be able to work correctly. To set the required variables, see [Configuring JMX connection for Apache Tomcat](#apache-tomcat-prerequisites).

On WebSphere Application Server Network Deployment, the applications are installed but not started. You need to start them manually. You can do that from the WebSphere Application Server administration console.

Keep the configuration file in the Server Configuration Tool. You might reuse it to install the interim fixes. The menu to apply an interim fix is **Configurations > Replace the deployed WAR files**.

### Applying a fix pack by using the Server Configuration Tool
{: #applying-a-fix-pack-by-using-the-server-configuration-tool }
If {{ site.data.keys.mf_server }} is installed with the configuration tool and the configuration file is kept, you can apply a fix pack or an interim fix by reusing the configuration file.

1. Start the Server Configuration Tool.
    * On Linux, from application shortcuts **Applications → IBM MobileFirst Platform Server → Server Configuration Tool**.
    * On Windows, click **Start → Programs → IBM MobileFirst Platform Server → Server Configuration Tool**.
    * On macOS, open a shell console. Go to **mfp\_server\_install_dir/shortcuts** and type **./configuration-tool.sh**.
    * The **mfp\_server\_install\_dir** directory is where you installed {{ site.data.keys.mf_server }}.

2. Click **Configurations → Replace the deployed WAR files** and select an existing configuration to apply the fix pack or an interim fix.

## Installing with Ant tasks
{: #installing-with-ant-tasks }
Use Ant tasks to install the {{ site.data.keys.mf_server }} components to your application server.

You can find the sample configuration files for installing {{ site.data.keys.mf_server }} in the **mfp\_install\_dir/MobileFirstServer/configuration-samples directory**.

You can also create a configuration with the Server Configuration Tool and export the Ant files by using **File → Export Configuration as Ant Files...**. The sample Ant files have the same limitations as the Server Configuration Tool:

* All components ({{ site.data.keys.mf_console }}, {{ site.data.keys.mf_server }} administration service, {{ site.data.keys.mf_server }} live update service, the {{ site.data.keys.mf_server }} artifacts, and {{ site.data.keys.product_adj }} runtime) are in the same application server. However, on WebSphere  Application Server Network Deployment when you install on a cluster, you can specify a different cluster for the administration and live update services, and for the runtime.
* If the {{ site.data.keys.mf_server }} push service is installed, it is also installed on the same server. However, on WebSphere Application Server Network Deployment when you install on a cluster, you can specify a different cluster for the push service.
* All the components use the same database system and the user. For DB2 , all the components also use the same schema.
* The Server Configuration Tool installs the components for a single server. For an installation on multiple servers, a farm must be configured after the tool is run. The server farm configuration is not supported on WebSphere Application Server Network Deployment.

You can configure the {{ site.data.keys.mf_server }} services to run in server farm with Ant tasks. To include your server in a farm, you need to specify some specific attributes that configure your application server accordingly. For more information about configuring a server farm with Ant tasks, see [Installing a server farm with Ant tasks](#installing-a-server-farm-with-ant-tasks).

For other topologies that are supported in [Topologies and network flows](../topologies), you can modify the sample Ant files.

The references to the Ant tasks are as follows:

* [Ant tasks for installation of {{ site.data.keys.mf_console }}, {{ site.data.keys.mf_server }} artifacts, {{ site.data.keys.mf_server }} administration, and live update services](../installation-reference/#ant-tasks-for-installation-of-mobilefirst-operations-console-mobilefirst-server-artifacts-mobilefirst-server-administration-and-live-update-services)
* [Ant tasks for installation of {{ site.data.keys.mf_server }} push service](../installation-reference/#ant-tasks-for-installation-of-mobilefirst-server-push-service)
* [Ant tasks for installation of {{ site.data.keys.product_adj }} runtime environments](../installation-reference/#ant-tasks-for-installation-of-mobilefirst-runtime-environments)

For an overview of installing with the sample configuration file and tasks, see [Installing {{ site.data.keys.mf_server }} in command line mode](../tutorials/command-line).

You can run an Ant file with the Ant distribution that is part of the product installation. For example, if you have WebSphere Application Server Network Deployment cluster and your database is IBM DB2, you can use the **mfp\_install\_dir/MobileFirstServer/configuration-samples/configure-wasnd-cluster-db2.xml** Ant file. After you edit the file and enter all the required properties, you can run the following commands from **mfp\_install\_dir/MobileFirstServer/configuration-samples** directory:

* **mfp\_install\_dir/shortcuts/ant -f configure-wasnd-cluster-db2.xml help** - This command displays the list of all the possible targets of the Ant file, to install, uninstall, or update some components.
* **mfp\_install\_dir/shortcuts/ant -f configure-wasnd-cluster-db2.xml install**  - This command installs {{ site.data.keys.mf_server }} on the WebSphere Application Server Network Deployment cluster, with DB2 as a data source by using the parameters that you entered in the properties of the Ant file.

<br/>
After the installation, make a copy of the Ant file so that you can reuse it to apply a fix pack.

### Applying a fix pack by using the Ant files
{: #applying-a-fix-pack-by-using-the-ant-files }

#### Updating with the sample Ant file
{: #updating-with-the-sample-ant-file }
If you use the sample Ant files that are provided in the **mfp\_install\_dir/MobileFirstServer/configuration-samples** directory to install {{ site.data.keys.mf_server }}, you can reuse a copy of this Ant file to apply a fix pack. For password values, you can enter 12 stars (\*) instead of the actual value, to be prompted interactively when the Ant file is run.

1. Verify the value of the **mfp.server.install.dir** property in the Ant file. It must point to the directory that contains the product with the fix pack applied. This value is used to take the updated {{ site.data.keys.mf_server }} WAR files.
2. Run the command: `mfp_install_dir/shortcuts/ant -f your_ant_file update`

#### Updating with own Ant file
{: #updating-with-own-ant-file }
If you use your own Ant file, make sure that for each installation task (**installmobilefirstadmin**, **installmobilefirstruntime**, and **installmobilefirstpush**), you have a corresponding update task in your Ant file with the same parameters. The corresponding update tasks are **updatemobilefirstadmin**, **updatemobilefirstruntime**, and **updatemobilefirstpush**.

1. Verify the class path of the **taskdef** element for the **mfp-ant-deployer.jar** file. It must point to the **mfp-ant-deployer.jar** file in an {{ site.data.keys.mf_server }} installation that the fix pack is applied. By default, the updated {{ site.data.keys.mf_server }} WAR files are taken from the location of **mfp-ant-deployer.jar**.
2. Run the update tasks (**updatemobilefirstadmin**, **updatemobilefirstruntime**, and **updatemobilefirstpush**) of your Ant file.

### Sample Ant files modifications
{: #sample-ant-files-modifications }
You can modify the sample Ant files that are provided in the **mfp\_install\_dir/MobileFirstServer/configuration-samples** directory to adapt to your installation requirements.  
The following sections provide the details on how you can modify the sample Ant files to adapt the installation to your needs:

1. [Specify extra JNDI properties](#specify-extra-jndi-properties)
2. [Specify existing users](#specify-existing-users)
3. [Specify Liberty Java EE level](#specify-liberty-java-ee-level)
4. [Specify data source JDBC properties](#specify-data-source-jdbc-properties)
5. [Run the Ant files on a computer where {{ site.data.keys.mf_server }} is not installed](#run-the-ant-files-on-a-computer-where-mobilefirst-server-is-not-installed)
6. [Specify WebSphere Application Server Network Deployment targets](#specify-websphere-application-server-network-deployment-targets)
7. [Manual configuration of the RMI port on Apache Tomcat](#manual-configuration-of-the-rmi-port-on-apache-tomcat)

#### Specify extra JNDI properties
{: #specify-extra-jndi-properties }
The **installmobilefirstadmin**, **installmobilefirstruntime**, and **installmobilefirstpush** Ant tasks declare the values for the JNDI properties that are required for the components to function. These JNDI properties are used to define the JMX communication, and also the links to other components (such the live update service, the push service, the analytics service, or the authorization server). However, you can also define values for other JNDI properties. Use the `<property>` element that exists for these three tasks. For a list of JNDI properties, see:

* [List of JNDI properties for {{ site.data.keys.mf_server }} administration service](../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service)
* [List of JNDI properties for {{ site.data.keys.mf_server }} push service](../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service)
* [List of JNDI properties for {{ site.data.keys.product_adj }} runtime](../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime)

For example:

```xml
<installmobilefirstadmin ..>
    <property name="mfp.admin.actions.prepareTimeout" value="3000000"/>
</installmobilefirstadmin>
```

#### Specify existing users
{: #specify-existing-users }
By default, the **installmobilefirstadmin** Ant task creates users:

* On WebSphere  Application Server Liberty to define a Liberty administrator for the JMX communication.
* On any application server, to define a user that is used for the communication with the live update service.

To use an existing user instead of creating new user, you can do the following operations:

1. In the `<jmx>` element, specify a user and password, and set the value of the **createLibertyAdmin** attribute to false. For example:

   ```xml
   <installmobilefirstadmin ...>
       <jmx libertyAdminUser="myUser" libertyAdminPassword="password" createLibertyAdmin="false" />
       ...
   ```

2. In the `<configuration>` element, specify a user and password and set the value of the **createConfigAdminUser** attribute to false. For example:

   ```xml
    <installmobilefirstadmin ...>
        <configuration configAdminUser="myUser" configAdminPassword="password" createConfigAdminUser="false" />
        ...
   ```

Also, the user that is created by the sample Ant files is mapped to the security roles of the administration service and the console. With this setting, you can use this user to log on to {{ site.data.keys.mf_server }} after the installation. To change that behavior, remove the `<user>` element from the sample Ant files. Alternatively, you can remove the **password** attribute from the `<user>` element, and the user is not created in the local registry of the application server.

#### Specify Liberty Java EE level
{: #specify-liberty-java-ee-level }
Some distributions of WebSphere Application Server Liberty support features from Java EE 6 or from Java EE 7. By default, the Ant tasks automatically detect the features to install. For example, **jdbc-4.0** Liberty feature is installed for Java EE 6 and **jdbc-4.1** feature is installed in case of Java EE 7. If the Liberty installation supports both features from Java EE 6 and Java EE 7, you might want to force a certain level of features. An example might be that you plan to run both {{ site.data.keys.mf_server }} V8.0.0 and V7.1.0 on the same Liberty server. {{ site.data.keys.mf_server }} V7.1.0 or earlier supports only Java EE 6 features.

To force a certain level of Java EE 6 features, use the jeeversion attribute of the `<websphereapplicationserver>` element. For example:

```xml
<installmobilefirstadmin execute="${mfp.process.admin}" contextroot="${mfp.admin.contextroot}">
    [...]
    <applicationserver>
      <websphereapplicationserver installdir="${appserver.was.installdir}"
        profile="Liberty" jeeversion="6">
```

#### Specify data source JDBC properties
{: #specify-data-source-jdbc-properties }
You can specify the properties for the JDBC connection. Use the `<property>` element of a `<database>` element. The element is available in **configureDatabase**, **installmobilefirstadmin**, **installmobilefirstruntime**, and **installmobilefirstpush** Ant tasks. For example:

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

#### Run the Ant files on a computer where {{ site.data.keys.mf_server }} is not installed
{: #run-the-ant-files-on-a-computer-where-mobilefirst-server-is-not-installed }
To run the Ant tasks on a computer where {{ site.data.keys.mf_server }} is not installed, you need the following items:

* An Ant installation
* A copy of the **mfp-ant-deployer.jar** file to the remote computer. This library contains the definition of the Ant tasks.
* To specify the resources to be installed. By default, the WAR files are taken near the **mfp-ant-deployer.jar**, but you can specify the location of these WAR files. For example:

```xml
<installmobilefirstadmin execute="true" contextroot="/mfpadmin" serviceWAR="/usr/mfp/mfp-admin-service.war">
  <console install="true" warFile="/usr/mfp/mfp-admin-ui.war"/>
```

For more information, see the Ant tasks to install each {{ site.data.keys.mf_server }} component at [Installation reference](../installation-reference).

#### Specify WebSphere Application Server Network Deployment targets
{: #specify-websphere-application-server-network-deployment-targets }
To install on WebSphere Application Server Network Deployment, the specified WebSphere Application Server profile must be the deployment manager. You can deploy on the following configurations:

* A cluster
* A single server
* A cell (all the servers of a cell)
* A node (all the servers of a node)

The sample files such as **configure-wasnd-cluster-dbms-name.xml**, **configure-wasnd-server-dbms-name.xml**, and **configure-wasnd-node-dbms-name.xml** contain the declaration to deploy on each type of target. For more information, see the Ant tasks to install each {{ site.data.keys.mf_server }} component in the [Installation reference](../installation-reference).

> Note: As of V8.0.0, the sample configuration file for the WebSphere Application Server Network Deployment cell is not provided.


#### Manual configuration of the RMI port on Apache Tomcat
{: #manual-configuration-of-the-rmi-port-on-apache-tomcat }
By default, the Ant tasks modify the **setenv.bat** file or the **setenv.sh** file to open the RMI port. If you prefer to open the RMI port manually, add the **tomcatSetEnvConfig** attribute with the value as false to the `<jmx>` element of the **installmobilefirstadmin**, **updatemobilefirstadmin**, and **uninstallmobilefirstadmin** tasks.

## Installing the {{ site.data.keys.mf_server }} components manually
{: #installing-the-mobilefirst-server-components-manually }
You can also install the {{ site.data.keys.mf_server }} components to your application server manually.  
The following topics provide you the complete information to guide you through the installing process of the components on the supported applications in production.

* [Manual installation on WebSphere Application Server Liberty](#manual-installation-on-websphere-application-server-liberty)
* [Manual installation on WebSphere Application Server Liberty collective](#manual-installation-on-websphere-application-server-liberty-collective)
* [Manual installation on Apache Tomcat](#manual-installation-on-apache-tomcat)
* [Manual installation on WebSphere Application Server and WebSphere Application Server Network Deployment](#manual-installation-on-websphere-application-server-and-websphere-application-server-network-deployment)

### Manual installation on WebSphere Application Server Liberty
{: #manual-installation-on-websphere-application-server-liberty }
Make sure that you have also fulfilled the requirements as documented in [WebSphere Application Server Liberty prerequisites](#websphere-application-server-liberty-prerequisites).

* [Topology constraints](#topology-constraints)
* [Application server settings](#application-server-settings)
* [Liberty features required by the {{ site.data.keys.mf_server }} applications](#liberty-features-required-by-the-mobilefirst-server-applications)
* [Global JNDI entries](#global-jndi-entries)
* [Class loader](#class-loader)
* [Password decoder user feature](#password-decoder-user-feature)
* [Configuration details](#configuration-details-liberty)

#### Topology constraints
{: #topology-constraints }
The {{ site.data.keys.mf_server }} administration service, the {{ site.data.keys.mf_server }} live update service, and the MobileFirst runtime must be installed on the same application server. The context root of the live update service must be defined as **the-adminContextRootconfig**. The context root of the push service must be **imfpush**. For more information about the constraints, see [Constraints on the {{ site.data.keys.mf_server }} components and {{ site.data.keys.mf_analytics }}](../topologies/#constraints-on-the-mobilefirst-server-components-and-mobilefirst-analytics).

#### Application server settings
{: #application-server-settings }
You must configure the **webContainer** element to load the servlets immediately. This setting is required for the initialization through JMX. For example: `<webContainer deferServletLoad="false"/>`.

Optionally, to avoid timeout issues that break the startup sequence of the runtime and the administration service on some Liberty versions, change the default **executor** element. Set large values to the **coreThreads** and **maxThreads** attributes. For example:

```xml
<executor id="default" name="LargeThreadPool"
  coreThreads="200" maxThreads="400" keepAlive="60s"
  stealPolicy="STRICT" rejectedWorkPolicy="CALLER_RUNS"/>
```

You might also configure the **tcpOptions** element and set the **soReuseAddr** attribute to `true`: `<tcpOptions soReuseAddr="true"/>`.

#### Liberty features required by the {{ site.data.keys.mf_server }} applications
{: #liberty-features-required-by-the-mobilefirst-server-applications }
You can use the following features for Java EE 6 or Java EE 7.

**{{ site.data.keys.mf_server }} administration service**

* **jdbc-4.0** (jdbc-4.1 for Java EE 7)
* **appSecurity-2.0**
* **restConnector-1.0**
* **usr:MFPDecoderFeature-1.0**

**{{ site.data.keys.mf_server }} push service**  

* **jdbc-4.0** (jdbc-4.1 for Java EE 7)
* **servlet-3.0** (servlet-3.1 for Java EE 7)
* **ssl-1.0**
* **usr:MFPDecoderFeature-1.0**

**{{ site.data.keys.product_adj }} runtime**  

* **jdbc-4.0** (jdbc-4.1 for Java EE 7)
* **servlet-3.0** (servlet-3.1 for Java EE 7)
* **ssl-1.0**
* **usr:MFPDecoderFeature-1.0**

#### Global JNDI entries
{: #global-jndi-entries }
The following global JNDI entries are required to configure the JMX communication between the runtime and the administration service:

* **mfp.admin.jmx.host**
* **mfp.admin.jmx.port**
* **mfp.admin.jmx.user**
* **mfp.admin.jmx.pwd**
* **mfp.topology.platform**
* **mfp.topology.clustermode**

These global JNDI entries are set with this syntax and are not prefixed by a context root. For example: `<jndiEntry jndiName="mfp.admin.jmx.port" value="9443"/>`.

> **Note:** To protect against an automatic conversion of the JNDI values, so that 075 is not converted to 61 or 31.500 is not converted to 31.5, use this syntax '"075"' when you define the value.

For more information about the JNDI properties for the administration service, see [List of JNDI properties for {{ site.data.keys.mf_server }} administration service](../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service).  

For a farm configuration, see also the following topics:

* [Server farm topology](../topologies/#server-farm-topology)
* [Topologies and network flows](../topologies)
* [Installing a server farm](#installing-a-server-farm)

#### Class loader
{: #class-loader }
For all applications, the class loader must have the parent last delegation. For example:

```xml
<application id="mfpadmin" name="mfpadmin" location="mfp-admin-service.war" type="war">
  [...]
  <classloader delegation="parentLast">
  </classloader>
</application>
```

#### Password decoder user feature
{: #password-decoder-user-feature }
Copy the password decoder user feature to your Liberty profile. For example:

* On UNIX and Linux systems:

  ```bash
  mkdir -p LIBERTY_HOME/wlp/usr/extension/lib/features
  cp product_install_dir/features/com.ibm.websphere.crypto_1.0.0.jar LIBERTY_HOME/wlp/usr/extension/lib/
  cp product_install_dir/features/MFPDecoderFeature-1.0.mf LIBERTY_HOME/wlp/usr/extension/lib/features/
  ```

* On Windows systems:

  ```bash
  mkdir LIBERTY_HOME\wlp\usr\extension\lib
  copy /B product_install_dir\features\com.ibm.websphere.crypto_1.0.0.jar
  LIBERTY_HOME\wlp\usr\extension\lib\com.ibm.websphere.crypto_1.0.0.jar
  mkdir LIBERTY_HOME\wlp\usr\extension\lib\features
  copy /B product_install_dir\features\MFPDecoderFeature-1.0.mf
  LIBERTY_HOME\wlp\usr\extension\lib\features\MFPDecoderFeature-1.0.mf
  ```

#### Configuration details
{: #configuration-details-liberty }
<div class="panel-group accordion" id="manual-installation-liberty" role="tablist" aria-multiselectable="true">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="admin-service">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty" href="#collapse-admin-service" aria-expanded="true" aria-controls="collapse-admin-service"><b>{{ site.data.keys.mf_server }} administration service configuration details</b></a>
            </h4>
        </div>

        <div id="collapse-admin-service" class="panel-collapse collapse" role="tabpanel" aria-labelledby="admin-service">
            <div class="panel-body">
                <p>The administration service is packaged as a WAR application for you to deploy to the application server. You need to make some specific configurations for this application in the <b>server.xml</b> file. The administration service WAR file is in <b>mfp_install_dir/MobileFirstServer/mfp-admin-service.war</b>. You can define the context root as you want. However, usually it is <b>/mfpadmin</b>.</p>

                <h3>Mandatory JNDI properties</h3>
                <p>When you define the JNDI properties, the JNDI names must be prefixed with the context root of the administration service. The following example illustrates the case to declare <b>mfp.admin.push.url</b> whereby the administration service is installed with <b>/mfpadmin</b> as the context root:</p>
{% highlight xml %}
<jndiEntry jndiName="mfpadmin/mfp.admin.push.url" value="http://localhost:9080/imfpush"/>
{% endhighlight %}

                <p>If the push service is installed, you must configure the following JNDI properties:</p>
                <ul>
                    <li><b>mfp.admin.push.url</b></li>
                    <li><b>mfp.admin.authorization.server.url</b></li>
                    <li><b>mfp.push.authorization.client.id</b></li>
                    <li><b>mfp.push.authorization.client.secret</b></li>
                    <li><b>mfp.admin.authorization.client.id</b></li>
                    <li><b>mfp.admin.authorization.client.secret</b></li>
                </ul>
                <p>The JNDI properties for the communication with the configuration service are as follows:</p>
                <ul>
                    <li><b>mfp.config.service.user</b></li>
                    <li><b>mfp.config.service.password</b></li>
                </ul>
                <p>For more information about the JNDI properties, see <a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service">List of JNDI properties for {{ site.data.keys.mf_server }} administration service</a>.</p>

                <h3>Data source</h3>
                <p>The JNDI name of the data source for the administration service must be defined as <b>jndiName=the-contextRoot/jdbc/mfpAdminDS</b>. The following example illustrates the case whereby the administration service is installed with the context root <b>/mfpadmin</b>, and that the service is using a relational database:</p>

{% highlight xml %}
<dataSource jndiName="mfpadmin/jdbc/mfpAdminDS" transactional="false">
  [...]
</dataSource>
{% endhighlight %}

                <h3></h3>
                <p>Declare the following roles in the <b>application-bnd</b> element of the application:</p>
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
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty" href="#collapse-live-update-service" aria-expanded="true" aria-controls="collapse-liberty-admin-service"><b>{{ site.data.keys.mf_server }} live update service configuration details</b></a>
            </h4>
        </div>

        <div id="collapse-live-update-service" class="panel-collapse collapse" role="tabpanel" aria-labelledby="live-update-service">
            <div class="panel-body">
                <p>The live update service is packaged as a WAR application for you to deploy to the application server. You need to make some specific configurations for this application in the <b>server.xml</b> file. Before you proceed, review <a href="#manual-installation-on-websphere-application-server-liberty">Manual installation on WebSphere Application Server Liberty</a> for the configuration details that are common to all services.</p>

                <p>The live update service WAR file is in <b>mfp_install_dir/MobileFirstServer/mfp-live-update.war</b>. The context root of the live update service must define in this way: <b>/the-adminContextRootconfig</b>. For example, if the context root of the administration service is <b>/mfpadmin</b>, then the context root of the live update service must be <b>/mfpadminconfig</b>.</p>

                <h3>Data source</h3>
                <p>The JNDI name of the data source for the live update service must be defined as the-contextRoot/jdbc/ConfigDS. The following example illustrates the case whereby the live update service is installed with the context root /mfpadminconfig, and that the service is using a relational database:</p>

{% highlight xml %}
<dataSource jndiName="mfpadminconfig/jdbc/ConfigDS" transactional="false">
  [...]
</dataSource>
{% endhighlight %}

                <h3></h3>
                <p>Declare the configadmin role in the <b>application-bnd</b> element of the application. At least one user must be mapped to this role. The user and its password must be provided to the following JNDI properties of the administration service:</p>

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
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty" href="#collapse-console-configuration" aria-expanded="true" aria-controls="collapse-console-configuration"><b>{{ site.data.keys.mf_console }} configuration details</b></a>
            </h4>
        </div>

        <div id="collapse-console-configuration" class="panel-collapse collapse" role="tabpanel" aria-labelledby="console-configuration">
            <div class="panel-body">
                <p>The console is packaged as a WAR application for you to deploy to the application server. You need to make some specific configurations for this application in the <b>server.xml</b> file. Before you proceed, review <a href="#manual-installation-on-websphere-application-server-liberty">Manual installation on WebSphere Application Server Liberty</a> for the configuration details that are common to all services.</p>

                <p>The console WAR file is in <b>mfp_install_dir/MobileFirstServer/mfp-admin-ui.war</b>. You can define the context root as you want. However, usually it is <b>/mfpconsole</b>.</p>

                <h3>Mandatory JNDI properties</h3>
                <p>When you define the JNDI properties, the JNDI names must be prefixed with the context root of the console. The following example illustrates the case to declare <b>mfp.admin.endpoint</b> whereby the console is installed with <b>/mfpconsole</b> as the context root:</p>

{% highlight xml %}
<jndiEntry jndiName="mfpconsole/mfp.admin.endpoint" value="*://*:*/mfpadmin"/>
{% endhighlight %}

                <p>The typical value for the mfp.admin.endpoint property is <b>*://*:*/the-adminContextRoot</b>.<br/>
                For more information about the JNDI properties, see <a href="../server-configuration/#jndi-properties-for-mobilefirst-operations-console">JNDI properties for {{ site.data.keys.mf_console }}</a>.</p>

                <h3>Security roles</h3>
                <p>Declare the following roles in the <b>application-bnd</b> element of the application:</p>
                <ul>
                    <li><b>mfpadmin</b></li>
                    <li><b>mfpdeployer</b></li>
                    <li><b>mfpmonitor</b></li>
                    <li><b>mfpoperator</b></li>
                </ul>
                Any user that is mapped to a security role of the console must also be mapped to the same security role of the administration service.
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="runtime-configuration">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty" href="#collapse-runtime-configuration" aria-expanded="true" aria-controls="collapse-runtime-configuration"><b>MobileFirst runtime configuration details</b></a>
            </h4>
        </div>

        <div id="collapse-runtime-configuration" class="panel-collapse collapse" role="tabpanel" aria-labelledby="runtime-configuration">
            <div class="panel-body">
                <p>The runtime is packaged as a WAR application for you to deploy to the application server. You need to make some specific configurations for this application in the <b>server.xml</b> file. Before you proceed, review <a href="#manual-installation-on-websphere-application-server-liberty">Manual installation on WebSphere Application Server Liberty</a> for the configuration details that are common to all services.</p>

                <p>The runtime WAR file is in <b>mfp_install_dir/MobileFirstServer/mfp-server.war</b>. You can define the context root as you want. However, it is <b>/mfp</b> by default.</p>

                <h3>Mandatory JNDI properties</h3>
                <p>When you define the JNDI properties, the JNDI names must be prefixed with the context root of the runtime. The following example illustrates the case to declare <b>mfp.analytics.url</b> whereby the runtime is installed with <b>/mobilefirst</b> as the context root:</p>

{% highlight xml %}
<jndiEntry jndiName="mobilefirst/mfp.analytics.url" value="http://localhost:9080/analytics-service/rest"/>
{% endhighlight %}

                <p>You must define the <b>mobilefirst/mfp.authorization.server</b> property. For example:</p>
{% highlight xml %}
<jndiEntry jndiName="mobilefirst/mfp.authorization.server" value="embedded"/>
{% endhighlight %}

                <p>If {{ site.data.keys.mf_analytics }} is installed, you need to define the following JNDI properties:</p>
                <ul>   
                    <li><b>mfp.analytics.url</b></li>
                    <li><b>mfp.analytics.console.url</b></li>
                    <li><b>mfp.analytics.username</b></li>
                    <li><b>mfp.analytics.password</b></li>
                </ul>

                <p>For more information about the JNDI properties, see <a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime">List of JNDI properties for {{ site.data.keys.product_adj }} runtime</a>.</p>

                <h3>Data source</h3>
                <p>The JNDI name of the data source for the runtime must be defined as <b>jndiName=the-contextRoot/jdbc/mfpDS</b>. The following example illustrates the case whereby the runtime is installed with the context root <b>/mobilefirst</b>, and that the runtime is using a relational database:</p>

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
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty" href="#collapse-push-configuration-liberty" aria-expanded="true" aria-controls="collapse-push-configuration-liberty"><b>{{ site.data.keys.mf_server }} push service configuration details</b></a>
            </h4>
        </div>

        <div id="collapse-push-configuration-liberty" class="panel-collapse collapse" role="tabpanel" aria-labelledby="push-configuration-liberty">
            <div class="panel-body">
                <p>The push service is packaged as a WAR application for you to deploy to the application server. You need to make some specific configurations for this application in the <b>server.xml</b> file. Before you proceed, review <a href="#manual-installation-on-websphere-application-server-liberty">Manual installation on WebSphere Application Server Liberty</a> for the configuration details that are common to all services.</p>

                <p>The push service WAR file is in <b>mfp_install_dir/PushService/mfp-push-service.war</b>. You must define the context root as <b>/imfpush</b>. Otherwise, the client devices cannot connect to it as the context root is hardcoded in the SDK.</p>

                <h3>Mandatory JNDI properties</h3>
                <p>When you define the JNDI properties, the JNDI names must be prefixed with the context root of the push service. The following example illustrates the case to declare <b>mfp.push.analytics.user</b> whereby the push service is installed with <b>/imfpush</b> as the context root:</p>

{% highlight xml %}
<jndiEntry jndiName="imfpush/mfp.push.analytics.user" value="admin"/>
{% endhighlight %}

                You need to define the following properties:
                <ul>
                    <li><b>mfp.push.authorization.server.url</b></li>
                    <li><b>mfp.push.authorization.client.id</b></li>
                    <li><b>mfp.push.authorization.client.secret</b></li>
                    <li><b>mfp.push.services.ext.security</b> - the value must be <b>com.ibm.mfp.push.server.security.plugin.OAuthSecurityPlugin</b>.</li>
                    <li><b>mfp.push.db.type</b> - for a relational database, the value must be DB.</li>
                </ul>

                If {{ site.data.keys.mf_analytics }} is configured, define the following JNDI properties:
                <ul>
                    <li><b>mfp.push.analytics.endpoint</b></li>
                    <li><b>mfp.analytics.username</b></li>
                    <li><b>mfp.analytics.password</b></li>
                    <li><b>mfp.push.services.ext.analytics</b> - the value must be <b>com.ibm.mfp.push.server.analytics.plugin.AnalyticsPlugin</b>.</li>
                </ul>
                For more information about the JNDI properties, see <a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service">List of JNDI properties for {{ site.data.keys.mf_server }} push service</a>.
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="artifacts-configuration">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty" href="#collapse-artifacts-configuration" aria-expanded="true" aria-controls="collapse-artifacts-configuration"><b>{{ site.data.keys.mf_server }} artifacts configuration details</b></a>
            </h4>
        </div>

        <div id="collapse-artifacts-configuration" class="panel-collapse collapse" role="tabpanel" aria-labelledby="artifacts-configuration">
            <div class="panel-body">
                <p>The artifacts component is packaged as a WAR application for you to deploy to the application server. You need to make some specific configurations for this application in the <b>server.xml</b> file. Before you proceed, review <a href="#manual-installation-on-websphere-application-server-liberty">Manual installation on WebSphere Application Server Liberty</a> for the configuration details that are common to all services.</p>

                <p>The WAR file for this component is in <b>mfp_install_dir/MobileFirstServer/mfp-dev-artifacts.war</b>. You must define the context root as <b>/mfp-dev-artifacts</b>.</p>
            </div>
        </div>
    </div>
</div>

### Manual installation on WebSphere Application Server Liberty collective
{: #manual-installation-on-websphere-application-server-liberty-collective }
Make sure that you have also fulfilled the requirements as documented in [WebSphere Application Server Liberty prerequisites](#websphere-application-server-liberty-prerequisites).

* [Topology constraints](#topology-constraints-collective)
* [Application server settings](#application-server-settings-collective)
* [Liberty features required by the {{ site.data.keys.mf_server }} applications](#liberty-features-required-by-the-mobilefirst-server-applications-collective)
* [Global JNDI entries](#global-jndi-entries-collective)
* [Class loader](#class-loader-collective)
* [Password decoder user feature](#password-decoder-user-feature-collective)
* [Configuration details](#configuration-details-collective)

#### Topology constraints
{: #topology-constraints-collective }
The {{ site.data.keys.mf_server }} administration service, the {{ site.data.keys.mf_server }} live update service, and {{ site.data.keys.mf_console }} must be installed in a Liberty collective controller. The {{ site.data.keys.product_adj }} runtime and the {{ site.data.keys.mf_server }} push service must be installed in every member of the Liberty collective cluster.

The context root of the live update service must be defined as **the-adminContextRootconfig**. The context root of the push service must be **imfpush**. For more information about the constraints, see [Constraints on the {{ site.data.keys.mf_server }} components and {{ site.data.keys.mf_analytics }}](../topologies/#constraints-on-the-mobilefirst-server-components-and-mobilefirst-analytics).

#### Application server settings
{: #application-server-settings-collective }
You must configure the **webContainer** element to load the servlets immediately. This setting is required for the initialization through JMX. For example: `<webContainer deferServletLoad="false"/>`.

Optionally, to avoid timeout issues that break the startup sequence of the runtime and the administration service on some Liberty versions, change the default **executor** element. Set large values to the **coreThreads** and **maxThreads** attributes. For example:

```xml
<executor id="default" name="LargeThreadPool"
  coreThreads="200" maxThreads="400" keepAlive="60s"
  stealPolicy="STRICT" rejectedWorkPolicy="CALLER_RUNS"/>
```

You might also configure the **tcpOptions** element and set the **soReuseAddr** attribute to `true`: `<tcpOptions soReuseAddr="true"/>`.

#### Liberty features required by the {{ site.data.keys.mf_server }} applications
{: #liberty-features-required-by-the-mobilefirst-server-applications-collective }

You need to add the following features for Java EE 6 or Java EE 7.

**{{ site.data.keys.mf_server }} administration service**

* **jdbc-4.0** (jdbc-4.1 for Java EE 7)
* **appSecurity-2.0**
* **restConnector-1.0**
* **usr:MFPDecoderFeature-1.0**

**{{ site.data.keys.mf_server }} push service**  

* **jdbc-4.0** (jdbc-4.1 for Java EE 7)
* **servlet-3.0** (servlet-3.1 for Java EE 7)
* **ssl-1.0**
* **usr:MFPDecoderFeature-1.0**

**{{ site.data.keys.product_adj }} runtime**  

* **jdbc-4.0** (jdbc-4.1 for Java EE 7)
* **servlet-3.0** (servlet-3.1 for Java EE 7)
* **ssl-1.0**
* **usr:MFPDecoderFeature-1.0**

#### Global JNDI entries
{: #global-jndi-entries-collective }
The following global JNDI entries are required to configure the JMX communication between the runtime and the administration service:

* **mfp.admin.jmx.host**
* **mfp.admin.jmx.port**
* **mfp.admin.jmx.user**
* **mfp.admin.jmx.pwd**
* **mfp.topology.platform**
* **mfp.topology.clustermode**
* **mfp.admin.serverid**

These global JNDI entries are set with this syntax and are not prefixed by a context root. For example: `<jndiEntry jndiName="mfp.admin.jmx.port" value="9443"/>`.

> **Note:** To protect against an automatic conversion of the JNDI values, so that 075 is not converted to 61 or 31.500 is not converted to 31.5, use this syntax '"075"' when you define the value.

* For more information about the JNDI properties for the administration service, see [List of JNDI properties for {{ site.data.keys.mf_server }} administration service](../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service).  
* For more information about the JNDI properties for the runtime, see [List of JNDI properties for {{ site.data.keys.product_adj }} runtime](../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime).

#### Class loader
{: #class-loader-collective }
For all applications, the class loader must have the parent last delegation. For example:

```xml
<application id="mfpadmin" name="mfpadmin" location="mfp-admin-service.war" type="war">
  [...]
  <classloader delegation="parentLast">
  </classloader>
</application>
```

#### Password decoder user feature
{: #password-decoder-user-feature-collective }
Copy the password decoder user feature to your Liberty profile. For example:

* On UNIX and Linux systems:

  ```bash
  mkdir -p LIBERTY_HOME/wlp/usr/extension/lib/features
  cp product_install_dir/features/com.ibm.websphere.crypto_1.0.0.jar LIBERTY_HOME/wlp/usr/extension/lib/
  cp product_install_dir/features/MFPDecoderFeature-1.0.mf LIBERTY_HOME/wlp/usr/extension/lib/features/
  ```

* On Windows systems:

  ```bash
  mkdir LIBERTY_HOME\wlp\usr\extension\lib
  copy /B product_install_dir\features\com.ibm.websphere.crypto_1.0.0.jar
  LIBERTY_HOME\wlp\usr\extension\lib\com.ibm.websphere.crypto_1.0.0.jar
  mkdir LIBERTY_HOME\wlp\usr\extension\lib\features
  copy /B product_install_dir\features\MFPDecoderFeature-1.0.mf
  LIBERTY_HOME\wlp\usr\extension\lib\features\MFPDecoderFeature-1.0.mf
  ```
#### Configuration details
{: #configuration-details-collective }
<div class="panel-group accordion" id="manual-installation-liberty-collective" role="tablist" aria-multiselectable="true">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="admin-service-collective">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty-collective" href="#collapse-admin-service-collective" aria-expanded="true" aria-controls="collapse-admin-service-collective"><b>{{ site.data.keys.mf_server }} administration service configuration details</b></a>
            </h4>
        </div>

        <div id="collapse-admin-service-collective" class="panel-collapse collapse" role="tabpanel" aria-labelledby="admin-service-collective">
            <div class="panel-body">
                <p>The administration service is packaged as a WAR application for you to deploy to the Liberty collective controller. You need to make some specific configurations for this application in the <b>server.xml</b> file of the Liberty collective controller.
                <br/><br/>
                Before you proceed, review <a href="#manual-installation-on-websphere-application-server-liberty-collective">Manual installation on WebSphere Application Server Liberty collective</a> for the configuration details that are common to all services.
                <br/><br/>
                The administration service WAR file is in <b>mfp_install_dir/MobileFirstServer/mfp-admin-service-collective.war</b>. You can define the context root as you want. However, usually it is <b>/mfpadmin</b>.</p>

                <h3>Mandatory JNDI properties</h3>
                <p>When you define the JNDI properties, the JNDI names must be prefixed with the context root of the administration service. The following example illustrates the case to declare <b>mfp.admin.push.url</b> whereby the administration service is installed with <b>/mfpadmin</b> as the context root:</p>
{% highlight xml %}
<jndiEntry jndiName="mfpadmin/mfp.admin.push.url" value="http://localhost:9080/imfpush"/>
{% endhighlight %}

                <p>If the push service is installed, you must configure the following JNDI properties:</p>
                <ul>
                    <li><b>mfp.admin.push.url</b></li>
                    <li><b>mfp.admin.authorization.server.url</b></li>
                    <li><b>mfp.push.authorization.client.id</b></li>
                    <li><b>mfp.push.authorization.client.secret</b></li>
                    <li><b>mfp.admin.authorization.client.id</b></li>
                    <li><b>mfp.admin.authorization.client.secret</b></li>
                </ul>
                <p>The JNDI properties for the communication with the configuration service are as follows:</p>
                <ul>
                    <li><b>mfp.config.service.user</b></li>
                    <li><b>mfp.config.service.password</b></li>
                </ul>
                <p>For more information about the JNDI properties, see <a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service">List of JNDI properties for {{ site.data.keys.mf_server }} administration service</a>.</p>

                <h3>Data source</h3>
                <p>The JNDI name of the data source for the administration service must be defined as <b>jndiName=the-contextRoot/jdbc/mfpAdminDS</b>. The following example illustrates the case whereby the administration service is installed with the context root <b>/mfpadmin</b>, and that the service is using a relational database:</p>

{% highlight xml %}
<dataSource jndiName="mfpadmin/jdbc/mfpAdminDS" transactional="false">
  [...]
</dataSource>
{% endhighlight %}

                <h3>Security roles</h3>
                <p>Declare the following roles in the <b>application-bnd</b> element of the application:</p>
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
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty-collective" href="#collapse-live-update-service-collective" aria-expanded="true" aria-controls="collapse-live-update-service-collective"><b>{{ site.data.keys.mf_server }} live update service configuration details</b></a>
            </h4>
        </div>

        <div id="collapse-live-update-service-collective" class="panel-collapse collapse" role="tabpanel" aria-labelledby="live-update-service-collective">
            <div class="panel-body">
                <p>The live update service is packaged as a WAR application for you to deploy to the liberty collective controller. You need to make some specific configurations for this application in the <b>server.xml</b> file of the Liberety collective controller.
                <br/><br/>
                Before you proceed, review <a href="#manual-installation-on-websphere-application-server-liberty-collective">Manual installation on WebSphere Application Server Liberty collective</a> for the configuration details that are common to all services.
                <br/><br/>
                The live update service WAR file is in <b>mfp_install_dir/MobileFirstServer/mfp-live-update.war</b>. The context root of the live update service must define in this way: <b>/the-adminContextRootconfig</b>. For example, if the context root of the administration service is <b>/mfpadmin</b>, then the context root of the live update service must be <b>/mfpadminconfig</b>.</p>

                <h3>Data source</h3>
                <p>The JNDI name of the data source for the live update service must be defined as <b>the-contextRoot/jdbc/ConfigDS</b>. The following example illustrates the case whereby the live update service is installed with the context root <b>/mfpadminconfig</b>, and that the service is using a relational database:</p>

{% highlight xml %}
<dataSource jndiName="mfpadminconfig/jdbc/ConfigDS" transactional="false">
  [...]
</dataSource>
{% endhighlight %}

                <h3>Security roles</h3>
                <p>Declare the configadmin role in the <b>application-bnd</b> element of the application. At least one user must be mapped to this role. The user and its password must be provided to the following JNDI properties of the administration service:</p>

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
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty-collective" href="#collapse-console-configuration-collective" aria-expanded="true" aria-controls="collapse-console-configuration-collective"><b>{{ site.data.keys.mf_console }} configuration details</b></a>
            </h4>
        </div>

        <div id="collapse-console-configuration-collective" class="panel-collapse collapse" role="tabpanel" aria-labelledby="console-configuration-collective">
            <div class="panel-body">
                <p>The console is packaged as a WAR application for you to deploy to the Liberty collective controller. You need to make some specific configurations for this application in the <b>server.xml</b> file of the Liberty collective controller.
                <br/><br/>Before you proceed, review <a href="#manual-installation-on-websphere-application-server-liberty-collective">Manual installation on WebSphere Application Server Liberty</a> for the configuration details that are common to all services.
                <br/><br/>
                The console WAR file is in <b>mfp_install_dir/MobileFirstServer/mfp-admin-ui.war</b>. You can define the context root as you want. However, usually it is <b>/mfpconsole</b>.</p>

                <h3>Mandatory JNDI properties</h3>
                <p>When you define the JNDI properties, the JNDI names must be prefixed with the context root of the console. The following example illustrates the case to declare <b>mfp.admin.endpoint</b> whereby the console is installed with <b>/mfpconsole</b> as the context root:</p>

{% highlight xml %}
<jndiEntry jndiName="mfpconsole/mfp.admin.endpoint" value="*://*:*/mfpadmin"/>
{% endhighlight %}

                <p>The typical value for the mfp.admin.endpoint property is <b>*://*:*/the-adminContextRoot</b>.<br/>
                For more information about the JNDI properties, see <a href="../server-configuration/#jndi-properties-for-mobilefirst-operations-console">JNDI properties for {{ site.data.keys.mf_console }}</a>.</p>

                <h3>Security roles</h3>
                <p>Declare the following roles in the <b>application-bnd</b> element of the application:</p>
                <ul>
                    <li><b>mfpadmin</b></li>
                    <li><b>mfpdeployer</b></li>
                    <li><b>mfpmonitor</b></li>
                    <li><b>mfpoperator</b></li>
                </ul>
                Any user that is mapped to a security role of the console must also be mapped to the same security role of the administration service.
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="runtime-configuration-collective">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty-collective" href="#collapse-runtime-configuration-collective" aria-expanded="true" aria-controls="collapse-runtime-configuration-collective"><b>{{ site.data.keys.product_adj }} runtime configuration details</b></a>
            </h4>
        </div>

        <div id="collapse-runtime-configuration-collective" class="panel-collapse collapse" role="tabpanel" aria-labelledby="runtime-configuration-collective">
            <div class="panel-body">
                <p>The runtime is packaged as a WAR application for you to deploy to the Liberty collective cluster members. You need to make some specific configurations for this application in the <b>server.xml</b> file of every Liberty collective cluster member.
                <br/><br/>
                Before you proceed, review <a href="#manual-installation-on-websphere-application-server-liberty-collective">Manual installation on WebSphere Application Server Liberty collective</a> for the configuration details that are common to all services.
                <br/><br/>
                The runtime WAR file is in <b>mfp_install_dir/MobileFirstServer/mfp-server.war</b>. You can define the context root as you want. However, it is <b>/mfp</b> by default.</p>

                <h3>Mandatory JNDI properties</h3>
                <p>When you define the JNDI properties, the JNDI names must be prefixed with the context root of the runtime. The following example illustrates the case to declare <b>mfp.analytics.url</b> whereby the runtime is installed with <b>/mobilefirst</b> as the context root:</p>

{% highlight xml %}
<jndiEntry jndiName="mobilefirst/mfp.analytics.url" value="http://localhost:9080/analytics-service/rest"/>
{% endhighlight %}

                <p>You must define the <b>mobilefirst/mfp.authorization.server</b> property. For example:</p>
{% highlight xml %}
<jndiEntry jndiName="mobilefirst/mfp.authorization.server" value="embedded"/>
{% endhighlight %}

                <p>If {{ site.data.keys.mf_analytics }} is installed, you need to define the following JNDI properties:</p>
                <ul>   
                    <li><b>mfp.analytics.url</b></li>
                    <li><b>mfp.analytics.console.url</b></li>
                    <li><b>mfp.analytics.username</b></li>
                    <li><b>mfp.analytics.password</b></li>
                </ul>

                <p>For more information about the JNDI properties, see <a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime">List of JNDI properties for {{ site.data.keys.product_adj }} runtime</a>.</p>

                <h3>Data source</h3>
                <p>The JNDI name of the data source for the runtime must be defined as <b>jndiName=the-contextRoot/jdbc/mfpDS</b>. The following example illustrates the case whereby the runtime is installed with the context root <b>/mobilefirst</b>, and that the runtime is using a relational database:</p>

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
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty-collective" href="#collapse-push-configuration" aria-expanded="true" aria-controls="collapse-push-configuration"><b>{{ site.data.keys.mf_server }} push service configuration details</b></a>
            </h4>
        </div>

        <div id="collapse-push-configuration" class="panel-collapse collapse" role="tabpanel" aria-labelledby="push-configuration">
            <div class="panel-body">
                <p>The push service is packaged as a WAR application for you to deploy to a Liberty collective cluster member or to a Liberty server. If you install the push service in a Liberty server, see <a href="#configuration-details-liberty">{{ site.data.keys.mf_server }} push service configuration details</a> under <a href="#manual-installation-on-websphere-application-server-liberty">Manual installation on WebSphere Application Server Liberty</a>.
                <br/><br/>
                When the {{ site.data.keys.mf_server }} push service is installed in a Liberty collective, it can be installed in the same cluster than the runtime or in another cluster.
                <br/><br/>
                You need to make some specific configurations for this application in the <b>server.xml</b> file of every Liberty collective cluster member. Before you proceed, review <a href="#manual-installation-on-websphere-application-server-liberty-collective">Manual installation on WebSphere Application Server Liberty collective </a> for the configuration details that are common to all services.    
                <br/><br/>
                The push service WAR file is in <b>mfp_install_dir/PushService/mfp-push-service.war</b>. You must define the context root as <b>/imfpush</b>. Otherwise, the client devices cannot connect to it as the context root is hardcoded in the SDK.</p>

                <h3>Mandatory JNDI properties</h3>
                <p>When you define the JNDI properties, the JNDI names must be prefixed with the context root of the push service. The following example illustrates the case to declare <b>mfp.push.analytics.user</b> whereby the push service is installed with <b>/imfpush</b> as the context root:</p>

{% highlight xml %}
<jndiEntry jndiName="imfpush/mfp.push.analytics.user" value="admin"/>
{% endhighlight %}

                You need to define the following properties:
                <ul>
                    <li><b>mfp.push.authorization.server.url</b></li>
                    <li><b>mfp.push.authorization.client.id</b></li>
                    <li><b>mfp.push.authorization.client.secret</b></li>
                    <li><b>mfp.push.services.ext.security</b> - the value must be <b>com.ibm.mfp.push.server.security.plugin.OAuthSecurityPlugin</b>.</li>
                    <li><b>mfp.push.db.type</b> - for a relational database, the value must be DB.</li>
                </ul>

                If {{ site.data.keys.mf_analytics }} is configured, define the following JNDI properties:
                <ul>
                    <li><b>mfp.push.analytics.endpoint</b></li>
                    <li><b>mfp.analytics.username</b></li>
                    <li><b>mfp.analytics.password</b></li>
                    <li><b>mfp.push.services.ext.analytics</b> - the value must be <b>com.ibm.mfp.push.server.analytics.plugin.AnalyticsPlugin</b>.</li>
                </ul>
                For more information about the JNDI properties, see <a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service">List of JNDI properties for {{ site.data.keys.mf_server }} push service</a>.
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="artifacts-configuration-collective">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty-collective" href="#collapse-artifacts-configuration-collective" aria-expanded="true" aria-controls="collapse-artifacts-configuration-collective"><b>{{ site.data.keys.mf_server }} artifacts configuration details</b></a>
            </h4>
        </div>

        <div id="collapse-artifacts-configuration-collective" class="panel-collapse collapse" role="tabpanel" aria-labelledby="artifacts-configuration-collective">
            <div class="panel-body">
                <p>The artifacts component is packaged as a WAR application for you to deploy to the Liberty collective controller. You need to make some specific configurations for this application in the <b>server.xml</b> file of the Liberty collective controller. Before you proceed, review <a href="#manual-installation-on-websphere-application-server-liberty">Manual installation on WebSphere Application Server Liberty</a> for the configuration details that are common to all services.</p>

                <p>The WAR file for this component is in <b>mfp_install_dir/MobileFirstServer/mfp-dev-artifacts.war</b>. You must define the context root as <b>/mfp-dev-artifacts</b>.</p>
            </div>
        </div>
    </div>
</div>

### Manual installation on Apache Tomcat
{: #manual-installation-on-apache-tomcat }
Make sure that you have fulfilled the requirements as documented in [Apache Tomcat prerequisites](#apache-tomcat-prerequisites).

* [Topology constraints](#topology-constraints-tomcat)
* [Application server settings](#application-server-settings-tomcat)
* [Configuration details](#configuration-details-tomcat)

#### Topology constraints
{: #topology-constraints-tomcat }
The {{ site.data.keys.mf_server }} administration service, the {{ site.data.keys.mf_server }} live update service, and the {{ site.data.keys.product_adj }} runtime must be installed on the same application server. The context root of the live update service must be defined as **the-adminContextRootconfig**. The context root of the push service must be **imfpush**. For more information about the constraints, see [Constraints on the {{ site.data.keys.mf_server }} components and {{ site.data.keys.mf_analytics }}](../topologies/#constraints-on-the-mobilefirst-server-components-and-mobilefirst-analytics).

#### Application server settings
{: #application-server-settings-tomcat }
ou must activate the **Single Sign On Valve**. For example:

```xml
<Valve className="org.apache.catalina.authenticator.SingleSignOn"/>
```

Optionally, you might want to activate the memory realm if the users are defined in **tomcat-users.xml**. For example:

```xml
<Realm className="org.apache.catalina.realm.MemoryRealm"/>
```
#### Configuration details
{: #configuration-details-tomcat }
<div class="panel-group accordion" id="manual-installation-apache-tomcat" role="tablist" aria-multiselectable="true">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="admin-service-tomcat">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-apache-tomcat" href="#collapse-admin-service-tomcat" aria-expanded="true" aria-controls="collapse-admin-service-tomcat"><b>{{ site.data.keys.mf_server }} administration service configuration details</b></a>
            </h4>
        </div>

        <div id="collapse-admin-service-tomcat" class="panel-collapse collapse" role="tabpanel" aria-labelledby="admin-service-tomcat">
            <div class="panel-body">
                <p>The administration service is packaged as a WAR application for you to deploy to the application server. You need to make some specific configurations for this application in the <b>server.xml</b> file of the application server.
                <br/><br/>
                Before you proceed, review <a href="#manual-installation-on-apache-tomcat">Manual installation on Apache Tomcat</a> for the configuration details that are common to all services.
                <br/><br/>
                The administration service WAR file is in <b>mfp_install_dir/MobileFirstServer/mfp-admin-service.war</b>. You can define the context root as you want. However, usually it is <b>/mfpadmin</b>.</p>

                <h3>Mandatory JNDI properties</h3>
                <p>The JNDI properties are defined within the <code>Environment</code> element in the application context. For example:</p>

{% highlight xml %}
<Environment name="mfp.admin.push.url" value="http://localhost:8080/imfpush" type="java.lang.String" override="false"/>
{% endhighlight %}
                <p>To enable the JMX communication with the runtime, define the following JNDI properties:</p>
                <ul>
                    <li><b>mfp.topology.platform</b></li>
                    <li><b>mfp.topology.clustermode</b></li>
                </ul>

                <p>If the push service is installed, you must configure the following JNDI properties:</p>
                <ul>
                    <li><b>mfp.admin.push.url</b></li>
                    <li><b>mfp.admin.authorization.server.url</b></li>
                    <li><b>mfp.push.authorization.client.id</b></li>
                    <li><b>mfp.push.authorization.client.secret</b></li>
                    <li><b>mfp.admin.authorization.client.id</b></li>
                    <li><b>mfp.admin.authorization.client.secret</b></li>
                </ul>
                <p>The JNDI properties for the communication with the configuration service are as follows:</p>
                <ul>
                    <li><b>mfp.config.service.user</b></li>
                    <li><b>mfp.config.service.password</b></li>
                </ul>
                <p>For more information about the JNDI properties, see <a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service">List of JNDI properties for {{ site.data.keys.mf_server }} administration service</a>.</p>

                <h3>Data source</h3>
                <p>The data source (jdbc/mfpAdminDS) is declared as a resource in the **Context** element. For example:</p>

{% highlight xml %}
<Resource name="jdbc/mfpAdminDS" type="javax.sql.DataSource" .../>
{% endhighlight %}

                <h3>Security roles</h3>
                <p>The security roles available for the administration service application are:</p>
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
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-apache-tomcat" href="#collapse-live-update-service-tomcat" aria-expanded="true" aria-controls="collapse-live-update-service-tomcat"><b>{{ site.data.keys.mf_server }} live update service configuration details</b></a>
            </h4>
        </div>

        <div id="collapse-live-update-service-tomcat" class="panel-collapse collapse" role="tabpanel" aria-labelledby="live-update-service-tomcat">
            <div class="panel-body">
                <p>The live update service is packaged as a WAR application for you to deploy to the application server. You need to make some specific configurations for this application in the <b>server.xml</b> file.
                <br/><br/>
                Before you proceed, review <a href="#manual-installation-on-apache-tomcat">Manual installation on Apache Tomcat</a> for the configuration details that are common to all services.
                <br/><br/>
                The live update service WAR file is in <b>mfp_install_dir/MobileFirstServer/mfp-live-update.war</b>. The context root of the live update service must define in this way: <b>/the-adminContextRoot/config</b>. For example, if the context root of the administration service is <b>/mfpadmin</b>, then the context root of the live update service must be <b>/mfpadminconfig</b>.</p>

                <h3>Data source</h3>
                <p>The JNDI name of the data source for the live update service must be defined as <code>jdbc/ConfigDS</code>. Declare it as a resource in the <code>Context</code> element.</p>

                <h3>Security roles</h3>
                <p>The security role available for the live update service application is <b>configadmin</b>.
                <br/><br/>
                At least one user must be mapped to this role. The user and its password must be provided to the following JNDI properties of the administration service:</p>

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
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-apache-tomcat" href="#collapse-console-configuration-tomcat" aria-expanded="true" aria-controls="collapse-console-configuration-tomcat"><b>{{ site.data.keys.mf_console }} configuration details</b></a>
            </h4>
        </div>

        <div id="collapse-console-configuration-tomcat" class="panel-collapse collapse" role="tabpanel" aria-labelledby="console-configuration-tomcat">
            <div class="panel-body">
                <p>The console is packaged as a WAR application for you to deploy to the application server. You need to make some specific configurations for this application in the <b>server.xml</b> file of the application server.
                <br/><br/>Before you proceed, review <a href="#manual-installation-on-apache-tomcat">Manual installation on Apache Tomcat</a> for the configuration details that are common to all services.
                <br/><br/>
                The console WAR file is in <b>mfp_install_dir/MobileFirstServer/mfp-admin-ui.war</b>. You can define the context root as you want. However, usually it is <b>/mfpconsole</b>.</p>

                <h3>Mandatory JNDI properties</h3>
                <p>You need to define the <b>mfp.admin.endpoint</b> property. The typical value for this property is <b>*://*:*/the-adminContextRoot</b>.
                <br/><br/>
                For more information about the JNDI properties, see <a href="../server-configuration/#jndi-properties-for-mobilefirst-operations-console">JNDI properties for {{ site.data.keys.mf_console }}</a>.</p>

                <h3>Security roles</h3>
                <p>The security roles available for the application are:</p>
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
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-apache-tomcat" href="#collapse-runtime-configuration-tomcat" aria-expanded="true" aria-controls="collapse-runtime-configuration-tomcat"><b>{{ site.data.keys.product_adj }} runtime configuration details</b></a>
            </h4>
        </div>

        <div id="collapse-runtime-configuration-tomcat" class="panel-collapse collapse" role="tabpanel" aria-labelledby="runtime-configuration-tomcat">
            <div class="panel-body">
                <p>The runtime is packaged as a WAR application for you to deploy to the application server. You need to make some specific configurations for this application in the <b>server.xml</b> file.
                <br/><br/>
                Before you proceed, review <a href="#manual-installation-on-apache-tomcat">Manual installation on Apache Tomcat</a> for the configuration details that are common to all services.
                <br/><br/>
                The runtime WAR file is in <b>mfp_install_dir/MobileFirstServer/mfp-server.war</b>. You can define the context root as you want. However, it is <b>/mfp</b> by default.</p>

                <h3>Mandatory JNDI properties</h3>
                <p>You must define the <b>mfp.authorization.server</b> property. For example:</p>

{% highlight xml %}
<Environment name="mfp.authorization.server" value="embedded" type="java.lang.String" override="false"/>
{% endhighlight %}

                <p>To enable the JMX communication with the administration service, define the following JNDI properties:</p>
                <ul>
                    <li><b>mfp.topology.platform</b></li>
                    <li><b>mfp.topology.clustermode</b></li>
                </ul>

                <p>If {{ site.data.keys.mf_analytics }} is installed, you need to define the following JNDI properties:</p>
                <ul>   
                    <li><b>mfp.analytics.url</b></li>
                    <li><b>mfp.analytics.console.url</b></li>
                    <li><b>mfp.analytics.username</b></li>
                    <li><b>mfp.analytics.password</b></li>
                </ul>

                <p>For more information about the JNDI properties, see <a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime">List of JNDI properties for {{ site.data.keys.product_adj }} runtime</a>.</p>

                <h3>Data source</h3>
                <p>The JNDI name of the data source for the runtime must be defined as <b>jdbc/mfpDS</b>. Declare it as a resource in the <b>Context</b> element.</p>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="push-configuration-tomcat">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-apache-tomcat" href="#collapse-push-configuration-tomcat" aria-expanded="true" aria-controls="collapse-push-configuration-tomcat"><b>{{ site.data.keys.mf_server }} push service configuration details</b></a>
            </h4>
        </div>

        <div id="collapse-push-configuration-tomcat" class="panel-collapse collapse" role="tabpanel" aria-labelledby="push-configuration-tomcat">
            <div class="panel-body">
                <p>The push service is packaged as a WAR application for you to deploy to the application server. You need to make some specific configurations for this application. Before you proceed, review <a href="#manual-installation-on-apache-tomcat">Manual installation on Apache Tomcat </a> for the configuration details that are common to all services.    
                <br/><br/>
                The push service WAR file is in <b>mfp_install_dir/PushService/mfp-push-service.war</b>. You must define the context root as <b>/imfpush</b>. Otherwise, the client devices cannot connect to it as the context root is hardcoded in the SDK.</p>

                <h3>Mandatory JNDI properties</h3>
                <p>You need to define the following properties:</p>
                <ul>
                    <li><b>mfp.push.authorization.server.url</b></li>
                    <li><b>mfp.push.authorization.client.id</b></li>
                    <li><b>mfp.push.authorization.client.secret</b></li>
                    <li><b>mfp.push.services.ext.security</b> - the value must be <b>com.ibm.mfp.push.server.security.plugin.OAuthSecurityPlugin</b>.</li>
                    <li><b>mfp.push.db.type</b> - for a relational database, the value must be DB.</li>
                </ul>

                <p>If {{ site.data.keys.mf_analytics }} is configured, define the following JNDI properties:</p>
                <ul>
                    <li><b>mfp.push.analytics.endpoint</b></li>
                    <li><b>mfp.analytics.username</b></li>
                    <li><b>mfp.analytics.password</b></li>
                    <li><b>mfp.push.services.ext.analytics</b> - the value must be <b>com.ibm.mfp.push.server.analytics.plugin.AnalyticsPlugin</b>.</li>
                </ul>
                For more information about the JNDI properties, see <a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service">List of JNDI properties for {{ site.data.keys.mf_server }} push service</a>.
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="artifacts-configuration-tomcat">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-on-apache-tomcat" href="#collapse-artifacts-configuration-tomcat" aria-expanded="true" aria-controls="collapse-artifacts-configuration-tomcat"><b>{{ site.data.keys.mf_server }} artifacts configuration details</b></a>
            </h4>
        </div>

        <div id="collapse-artifacts-configuration-tomcat" class="panel-collapse collapse" role="tabpanel" aria-labelledby="artifacts-configuration-tomcat">
            <div class="panel-body">
                <p>The artifacts component is packaged as a WAR application for you to deploy to the application server. You need to make some specific configurations for this application in the <b>server.xml</b> file of the application server. Before you proceed, review <a href="#manual-installation-on-apache-tomcat">Manual installation on Apache Tomcat</a> for the configuration details that are common to all services.</p>

                <p>The WAR file for this component is in <b>mfp_install_dir/MobileFirstServer/mfp-dev-artifacts.war</b>. You must define the context root as <b>/mfp-dev-artifacts</b>.</p>
            </div>
        </div>
    </div>
</div>

### Manual installation on WebSphere Application Server and WebSphere Application Server Network Deployment
{: #manual-installation-on-websphere-application-server-and-websphere-application-server-network-deployment }
Make sure that you have fulfilled the requirements as documented in <a href="#websphere-application-server-and-websphere-application-server-network-deployment-prerequisites">WebSphere Application Server and WebSphere Application Server Network Deployment prerequisites</a>.

* [Topology constraints](#topology-constraints-nd)
* [Application server settings](#application-server-settings-nd)
* [Class loader](#class-loader-nd)
* [Configuration details](#configuration-details-nd)

#### Topology constraints
{: #topology-constraints-nd }
<b>On a stand-alone WebSphere Application Server</b>  
The {{ site.data.keys.mf_server }} administration service, the {{ site.data.keys.mf_server }} live update service, and the {{ site.data.keys.product_adj }} runtime must be installed on the same application server. The context root of the live update service must be defined as <b>the-adminContextRootConfig</b>. The context root of the push service must be <b>imfpush</b>. For more information about the constraints, see [Constraints on the {{ site.data.keys.mf_server }} components and {{ site.data.keys.mf_analytics }}](../topologies/#constraints-on-the-mobilefirst-server-components-and-mobilefirst-analytics).

<b>On WebSphere Application Server Network Deployment</b>  
The deployment manager must be running while {{ site.data.keys.mf_server }} is running. The deployment manager is used for the JMX communication between the runtime and the administration service. The administration service and the live update service must be installed on the same application server. The runtime can be installed on different servers than the administration service, but it must be on the same cell.

#### Application server settings
{: #application-server-settings-nd }
The administrative security and the application security must be enabled. You can enable the application security in the WebSphere Application Server administration console:

1. Log in to the WebSphere Application Server administration console.
2. Click **Security → Global Security**. Ensure that Enable administrative security is selected.
3. Also, ensure that **Enable application security** is selected. The application security can be enabled only if administrative security is enabled.
4. Click **OK**.
5. Save the changes.

For more information, see [Enabling security](http://www.ibm.com/support/knowledgecenter/SSAW57_8.5.5/com.ibm.websphere.nd.doc/ae/tsec_csec2.html?view=kc) in WebSphere Application Server documentation.

The server class loader policy must support parent last delegation. The {{ site.data.keys.mf_server }} WAR files must be installed with parent last class loader mode. Review the class-loader policy:

1. Log in to the WebSphere Application Server administration console.
2. Click S**ervers → Server Types → WebSphere application servers**, and click on the server that is used for {{ site.data.keys.product }}.
3. If the class-loader policy is set to **Multiple**, do nothing.
4. If the class-loader policy is set to **Single** and the class loading mode is set to **Classes loaded with local class loader first (parent last)**, do nothing.
5. If the class-loader policy is set to **Single** and the class loading mode is set to **Classes loaded with parent class loader first (parent first)**, change the class-loader policy to **Multiple**. Also, set the class loader order of all applications other than {{ site.data.keys.mf_server }} applications to **Classes loaded with parent class loader first (parent first)**.

#### Class loader
{: #class-loader-nd }
For all {{ site.data.keys.mf_server }} applications, the class loader must have the parent last delegation.

To set the class loader delegation to parent last after an application is installed, follow these steps:

1. Click the **Manage Applications** link, or click **Applications → Application Types → WebSphere entreprise applications**.
2. Click the **{{ site.data.keys.mf_server }}** application. By default the name of the application is the name of the WAR file.
3. In the **Detail Properties** section, click the **Class loading and update detection** link.
4. In the **Class loader order** pane, select the **Classes loaded with local class loader first (parent last)** option.
5. Click **OK**.
6. In the **Modules** section, click the **Manage Modules** link.
7. Click the module.
8. For the **Class loader order** field, select the **Classes loaded with local class loader first (parent last)** option.
9. Click **OK** twice to confirm the selection and back to the **Configuration** panel of the application.
10. Click **Save** to persist the changes.

#### Configuration details
{: #configuration-details-nd }
<div class="panel-group accordion" id="manual-installation-nd" role="tablist" aria-multiselectable="true">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="admin-service-nd">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-nd" href="#collapse-admin-service-nd" aria-expanded="true" aria-controls="collapse-admin-service-nd"><b>{{ site.data.keys.mf_server }} administration service configuration details</b></a>
            </h4>
        </div>

        <div id="collapse-admin-service-nd" class="panel-collapse collapse" role="tabpanel" aria-labelledby="admin-service-nd">
            <div class="panel-body">
                <p>The administration service is packaged as a WAR application for you to deploy to the application server. You need to make some specific configurations for this application in the <b>server.xml</b> file of the application server.
                <br/><br/>
                Before you proceed, review <a href="#manual-installation-on-websphere-application-server-and-websphere-application-server-network-deployment">Manual installation on WebSphere Application Server and WebSphere Application Server Network Deployment</a> for the configuration details that are common to all services.
                <br/><br/>
                The administration service WAR file is in <b>mfp_install_dir/MobileFirstServer/mfp-admin-service.war</b>. You can define the context root as you want. However, usually it is <b>/mfpadmin</b>.</p>

                <h3>Mandatory JNDI properties</h3>
                <p>You can set JNDI properties with the WebSphere Application Server administration console. Go to <b>Applications → Application Types → WebSphere enterprise applications → application_name → Environment entries for Web modules</b> and set the entries.</p>

                <p>To enable the JMX communication with the runtime, define the following JNDI properties:</p>

                <b>On WebSphere Application Server Network Deployment</b>
                <ul>
                    <li><b>mfp.admin.jmx.dmgr.host</b></li>
                    <li><b>mfp.admin.jmx.dmgr.port</b> - the SOAP port on the deployment manager.</li>
                    <li><b>mfp.topology.platform</b> - set the value as <b>WAS</b>.</li>
                    <li><b>mfp.topology.clustermode</b> - set the value as <b>Cluster</b>.</li>
                    <li><b>mfp.admin.jmx.connector</b> - set the value as <b>SOAP</b>.</li>
                </ul>

                <b>On a stand-alone WebSphere Application Server</b>
                <ul>
                    <li><b>mfp.topology.platform</b> - set the value as <b>WAS</b>.</li>
                    <li><b>mfp.topology.clustermode</b> - set the value as <b>Standalone</b>.</li>
                    <li><b>mfp.admin.jmx.connector</b> - set the value as <b>SOAP</b>.</li>
                </ul>

                <p>If the push service is installed, you must configure the following JNDI properties:</p>
                <ul>
                    <li><b>mfp.admin.push.url</b></li>
                    <li><b>mfp.admin.authorization.server.url</b></li>
                    <li><b>mfp.push.authorization.client.id</b></li>
                    <li><b>mfp.push.authorization.client.secret</b></li>
                    <li><b>mfp.admin.authorization.client.id</b></li>
                    <li><b>mfp.admin.authorization.client.secret</b></li>
                </ul>
                <p>The JNDI properties for the communication with the configuration service are as follows:</p>
                <ul>
                    <li><b>mfp.config.service.user</b></li>
                    <li><b>mfp.config.service.password</b></li>
                </ul>
                <p>For more information about the JNDI properties, see <a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service">List of JNDI properties for {{ site.data.keys.mf_server }} administration service</a>.</p>

                <h3>Data source</h3>
                <p>Create a data source for the administration service and map it to <b>jdbc/mfpAdminDS</b>.</p>

                <h3>Start order</h3>
                <p>The administration service application must start before the runtime application. You can set the order at <b>Startup behavior</b> section. For example, set the Startup Order to <b>1</b> for the administration service and <b>2</b> to the runtime.</p>

                <h3>Security roles</h3>
                <p>The security roles available for the administration service application are:</p>
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
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-nd" href="#collapse-live-update-service-nd" aria-expanded="true" aria-controls="collapse-live-update-service-nd"><b>{{ site.data.keys.mf_server }} live update service configuration details</b></a>
            </h4>
        </div>

        <div id="collapse-live-update-service-nd" class="panel-collapse collapse" role="tabpanel" aria-labelledby="live-update-service-nd">
            <div class="panel-body">
                <p>The live update service is packaged as a WAR application for you to deploy to the application server. You need to make some specific configurations for this application in the <b>server.xml</b> file.
                <br/><br/>
                Before you proceed, review <a href="#manual-installation-on-websphere-application-server-and-websphere-application-server-network-deployment">Manual installation on WebSphere Application Server and WebSphere Application Server Network Deployment</a> for the configuration details that are common to all services.
                <br/><br/>
                The live update service WAR file is in <b>mfp_install_dir/MobileFirstServer/mfp-live-update.war</b>. The context root of the live update service must define in this way: <b>/the-adminContextRoot/config</b>. For example, if the context root of the administration service is <b>/mfpadmin</b>, then the context root of the live update service must be <b>/mfpadminconfig</b>.</p>

                <h3>Data source</h3>
                <p>Create a data source for the live update service and map it to <b>jdbc/ConfigDS</b>.</p>

                <h3>Security roles</h3>
                <p>The <b>configadmin</b> role is defined for this application.
                <br/><br/>
                At least one user must be mapped to this role. The user and its password must be provided to the following JNDI properties of the administration service:</p>

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
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-nd" href="#collapse-console-configuration-nd" aria-expanded="true" aria-controls="collapse-console-configuration-nd"><b>{{ site.data.keys.mf_console }} configuration details</b></a>
            </h4>
        </div>

        <div id="collapse-console-configuration-nd" class="panel-collapse collapse" role="tabpanel" aria-labelledby="console-configuration-nd">
            <div class="panel-body">
                <p>The console is packaged as a WAR application for you to deploy to the application server. You need to make some specific configurations for this application in the <b>server.xml</b> file of the application server.
                <br/><br/>Before you proceed, review <a href="#manual-installation-on-websphere-application-server-and-websphere-application-server-network-deployment">Manual installation on WebSphere Application Server and WebSphere Application Server Network Deployment</a> for the configuration details that are common to all services.
                <br/><br/>
                The console WAR file is in <b>mfp_install_dir/MobileFirstServer/mfp-admin-ui.war</b>. You can define the context root as you want. However, usually it is <b>/mfpconsole</b>.</p>

                <h3>Mandatory JNDI properties</h3>
                <p>You can set JNDI properties with the WebSphere Application Server administration console. Go to <b>Applications → Application Types → WebSphere enterprise applications → application_name → Environment</b> entries for Web modules and set the entries.
                <br/><br/>
                You need to define the <b>mfp.admin.endpoint</b> property. The typical value for this property is <b>*://*:*/the-adminContextRoot</b>.
                <br/><br/>
                For more information about the JNDI properties, see <a href="../server-configuration/#jndi-properties-for-mobilefirst-operations-console">JNDI properties for {{ site.data.keys.mf_console }}</a>.</p>

                <h3>Security roles</h3>
                <p>The security roles available for the application are:</p>
                <ul>
                    <li><b>mfpadmin</b></li>
                    <li><b>mfpdeployer</b></li>
                    <li><b>mfpmonitor</b></li>
                    <li><b>mfpoperator</b></li>
                </ul>
                Any user that is mapped to a security role of the console must also be mapped to the same security role of the administration service.
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="runtime-configuration-nd">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-nd" href="#collapse-runtime-configuration-nd" aria-expanded="true" aria-controls="collapse-runtime-configuration-nd"><b>MobileFirst runtime configuration details</b></a>
            </h4>
        </div>

        <div id="collapse-runtime-configuration-nd" class="panel-collapse collapse" role="tabpanel" aria-labelledby="runtime-configuration-nd">
            <div class="panel-body">
                <p>The runtime is packaged as a WAR application for you to deploy to the application server. You need to make some specific configurations for this application in the <b>server.xml</b> file.
                <br/><br/>
                Before you proceed, review <a href="#manual-installation-on-websphere-application-server-and-websphere-application-server-network-deployment">Manual installation on WebSphere Application Server and WebSphere Application Server Network Deployment</a> for the configuration details that are common to all services.
                <br/><br/>
                The runtime WAR file is in <b>mfp_install_dir/MobileFirstServer/mfp-server.war</b>. You can define the context root as you want. However, it is <b>/mfp</b> by default.</p>

                <h3>Mandatory JNDI properties</h3>
                <p>You can set JNDI properties with the WebSphere Application Server administration console. Go to <b>Applications → Application Types → WebSphere enterprise applications → application_name → Environment</b> entries for Web modules and set the entries.</p>

                <p>You must define the <b>mfp.authorization.server</b> property with the value as embedded.<br/>
                Also, define the following JNDI properties to enable the JMX communication with the administration service:</p>

                <b>On WebSphere Application Server Network Deployment</b>
                <ul>
                    <li><b>mfp.admin.jmx.dmgr.host</b> - the host name of the deployment manager.</li>
                    <li><b>mfp.admin.jmx.dmgr.port</b> - the SOAP port of the deployment manager.</li>
                    <li><b>mfp.topology.platform</b> - set the value as <b>WAS</b>.</li>
                    <li><b>mfp.topology.clustermode</b> - set the value as <b>Cluster</b>.</li>
                    <li><b>mfp.admin.jmx.connector</b> - set the value as <b>SOAP</b>.</li>
                </ul>

                <b>On a stand-alone WebSphere Application Server</b>
                <ul>
                    <li><b>mfp.topology.platform</b> - set the value as <b>WAS</b>.</li>
                    <li><b>mfp.topology.clustermode</b> - set the value as <b>Standalone</b>.</li>
                    <li><b>mfp.admin.jmx.connector</b> - set the value as <b>SOAP</b>.</li>
                </ul>

                <p>If {{ site.data.keys.mf_analytics }} is installed, you need to define the following JNDI properties:</p>
                <ul>   
                    <li><b>mfp.analytics.url</b></li>
                    <li><b>mfp.analytics.console.url</b></li>
                    <li><b>mfp.analytics.username</b></li>
                    <li><b>mfp.analytics.password</b></li>
                </ul>

                <p>For more information about the JNDI properties, see <a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime">List of JNDI properties for {{ site.data.keys.product_adj }} runtime</a>.</p>

                <h3>Start order</h3>
                <p>The runtime application must start after the administration service application. You can set the order at <b>Startup behavior</b> section. For example, set the Startup Order to <b>1</b> for the administration service and <b>2</b> to the runtime.</p>

                <h3>Data source</h3>
                <p>Create a data source for the runtime and map it to <b>jdbc/mfpDS</b>.</p>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="push-configuration-nd">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-nd" href="#collapse-push-configuration-nd" aria-expanded="true" aria-controls="collapse-push-configuration-nd"><b>{{ site.data.keys.mf_server }} push service configuration details</b></a>
            </h4>
        </div>

        <div id="collapse-push-configuration-nd" class="panel-collapse collapse" role="tabpanel" aria-labelledby="push-configuration-nd">
            <div class="panel-body">
                <p>The push service is packaged as a WAR application for you to deploy to the application server. You need to make some specific configurations for this application. Before you proceed, review <a href="#manual-installation-on-websphere-application-server-and-websphere-application-server-network-deployment">Manual installation on WebSphere Application Server and WebSphere Application Server Network Deployment </a> for the configuration details that are common to all services.    
                <br/><br/>
                The push service WAR file is in <b>mfp_install_dir/PushService/mfp-push-service.war</b>. You must define the context root as <b>/imfpush</b>. Otherwise, the client devices cannot connect to it as the context root is hardcoded in the SDK.</p>

                <h3>Mandatory JNDI properties</h3>
                <p>You can set JNDI properties with the WebSphere Application Server administration console. Go to <b>Applications > Application Types → WebSphere enterprise applications → application_name → Environment entries for Web modules</b> and set the entries.</p>

                <p>You need to define the following properties:</p>
                <ul>
                    <li><b>mfp.push.authorization.server.url</b></li>
                    <li><b>mfp.push.authorization.client.id</b></li>
                    <li><b>mfp.push.authorization.client.secret</b></li>
                    <li><b>mfp.push.services.ext.security</b> - the value must be <b>com.ibm.mfp.push.server.security.plugin.OAuthSecurityPlugin</b>.</li>
                    <li><b>mfp.push.db.type</b> - for a relational database, the value must be DB.</li>
                </ul>

                <p>If {{ site.data.keys.mf_analytics }} is configured, define the following JNDI properties:</p>
                <ul>
                    <li><b>mfp.push.analytics.endpoint</b></li>
                    <li><b>mfp.analytics.username</b></li>
                    <li><b>mfp.analytics.password</b></li>
                    <li><b>mfp.push.services.ext.analytics</b> - the value must be <b>com.ibm.mfp.push.server.analytics.plugin.AnalyticsPlugin</b>.</li>
                </ul>
                <p>For more information about the JNDI properties, see <a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service">List of JNDI properties for {{ site.data.keys.mf_server }} push service</a>.</p>

                <h3>Data source</h3>
                <p>Create the data source for the push service and map it to <b>jdbc/imfPushDS</b>.</p>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="artifacts-configuration-nd">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-nd" href="#collapse-artifacts-configuration-nd" aria-expanded="true" aria-controls="collapse-artifacts-configuration-nd"><b>{{ site.data.keys.mf_server }} artifacts configuration details</b></a>
            </h4>
        </div>

        <div id="collapse-artifacts-configuration-nd" class="panel-collapse collapse" role="tabpanel" aria-labelledby="artifacts-configuration-nd">
            <div class="panel-body">
                <p>The artifacts component is packaged as a WAR application for you to deploy to the application server. You need to make some specific configurations for this application in the <b>server.xml</b> file of the application server. Before you proceed, review <a href="#manual-installation-on-websphere-application-server-and-websphere-application-server-network-deployment">Manual installation on WebSphere Application Server and WebSphere Application Server Network Deployment</a> for the configuration details that are common to all services.</p>

                <p>The WAR file for this component is in <b>mfp_install_dir/MobileFirstServer/mfp-dev-artifacts.war</b>. You must define the context root as <b>/mfp-dev-artifacts</b>.</p>
            </div>
        </div>
    </div>
</div>

## Installing a server farm
{: #installing-a-server-farm }
You can install your server farm by running Ant tasks, with the Server Configuration Tool, or manually.

* [Planning the configuration of a server farm](#planning-the-configuration-of-a-server-farm)
* [Installing a server farm with the Server Configuration Tool](#installing-a-server-farm-with-the-server-configuration-tool)
* [Installing a server farm with Ant tasks](#installing-a-server-farm-with-ant-tasks)
* [Configuring a server farm manually](#configuring-a-server-farm-manually)
* [Verifying a farm configuration](#verifying-a-farm-configuration)
* [Lifecycle of a server farm node](#lifecycle-of-a-server-farm-node)

### Planning the configuration of a server farm
{: #planning-the-configuration-of-a-server-farm }
To plan the configuration of a server farm, choose the application server, configure the {{ site.data.keys.product_adj }} databases, and deploy the WAR files of the {{ site.data.keys.mf_server }} components on each server of the farm. You have the options to use the Server Configuration Tool, Ant tasks, or manual operations to configure a server farm.

When you intend to plan a server farm installation, see [Constraints on {{ site.data.keys.mf_server }} administration service, {{ site.data.keys.mf_server }} live update service and MobileFirst runtime](../topologies/#constraints-on-mobilefirst-server-administration-service-mobilefirst-server-live-update-service-and-mobilefirst-foundation-runtime) first, and in particular see [Server farm topology](../topologies/#server-farm-topology).

In {{ site.data.keys.product }}, a server farm is composed of multiple stand-alone application servers that are not federated or administered by a managing component of an application server. {{ site.data.keys.mf_server }} internally provides a farm plug-in as the means to enhance an application server so that it can be part of a server farm.

#### When to declare a server farm
{: #when-to-declare-a-server-farm }
**Declare a server farm in the following cases:**

* {{ site.data.keys.mf_server }} is installed on multiple Tomcat application servers.
* {{ site.data.keys.mf_server }} is installed on multiple WebSphere Application Server servers but not on WebSphere Application Server Network Deployment.
* {{ site.data.keys.mf_server }} is installed on multiple WebSphere Application Server Liberty servers.

**Do not declare a server farm in the following cases:**

* Your application server is stand-alone.
* Multiple application servers are federated by WebSphere Application Server Network Deployment.

#### Why it is mandatory to declare a farm
{: #why-it-is-mandatory-to-declare-a-farm }
Each time a management operation is performed through {{ site.data.keys.mf_console }} or through the {{ site.data.keys.mf_server }} administration service application, the operation needs to be replicated to all instances of a runtime environment. Examples of such management operations are the uploading of a new version of an app or of an adapter. The replication is done via JMX calls performed by the administration service application instance that handles the operation. The administration service needs to contact all runtime instances in the cluster. In environments listed under **When to declare a server farm** above, the runtime can be contacted through JMX only if a farm is configured. If a server is added to a cluster without proper configuration of the farm, the runtime in that server will be in an inconsistent state after each management operation, and until it is restarted again.

### Installing a server farm with the Server Configuration Tool
{: #installing-a-server-farm-with-the-server-configuration-tool }
Use the Server Configuration Tool to configure each server in the farm according to the requirements of the single type of application server that is used for each member of the server farm.

When you plan a server farm with the Server Configuration Tool, first create the stand-alone servers and configure their respective truststores so that they can communicate with one another in a secure way. Then, run the tool that does the following operations:

* Configure the database instance that is shared by the {{ site.data.keys.mf_server }} components.
* Deploy the {{ site.data.keys.mf_server }} components to each server
* Modify its configuration to make it a member of a server farm

<div class="panel-group accordion" id="installing-mobilefirst-server-ct" role="tablist" aria-multiselectable="true">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="server-farm-ct">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#server-farm-ct" href="#collapse-server-farm-ct" aria-expanded="true" aria-controls="collapse-server-farm-ct"><b>Click for instructions on installing a server farm with the Server Configuration Tool</b></a>
            </h4>
        </div>

        <div id="collapse-server-farm-ct" class="panel-collapse collapse" role="tabpanel" aria-labelledby="server-farm-ct">
            <div class="panel-body">
                <p>{{ site.data.keys.mf_server }} requires the secure JMX connection to be configured.</p>

                <ol>
                    <li>Prepare the application servers that must be configured as the server farm members.
                        <ul>
                            <li>Choose the type of application server to use to configure the members of the server farm. {{ site.data.keys.product }} supports the following application servers in server farms:
                                <ul>
                                    <li>WebSphere  Application Server full profile<br/>
                                    <b>Note:</b> In a farm topology, you cannot use the RMI JMX connector. In this topology, only the SOAP connector is supported by {{ site.data.keys.product }}.</li>
                                    <li>WebSphere Application Server Liberty profile</li>
                                    <li>Apache Tomcat</li>
                                </ul>
                                To know which versions of the application servers are supported, see <a href="../../../product-overview/requirements">System requirements</a>.

                                <blockquote><b>Important:</b> {{ site.data.keys.product }} supports only homogeneous server farms. A server farm is homogeneous when it connects same type of application servers. Attempting to associate different types of application servers might lead to unpredictable behavior at run time. For example, a farm with a mix of Apache Tomcat servers and WebSphere Application Server full profile servers is an invalid configuration.</blockquote>
                            </li>
                            <li>Set up as many stand-alone servers as the number of members that you want in the farm.
                                <ul>
                                    <li>Each of these stand-alone servers must communicate with the same database. You must make sure that any port used by any of these servers is not also used by another server that is configured on the same host. This constraint applies to the ports used by HTTP, HTTPS, REST, SOAP, and RMI protocols.</li>
                                    <li>Each of these servers must have the {{ site.data.keys.mf_server }} administration service, the {{ site.data.keys.mf_server }} live update service, and one or more {{ site.data.keys.product_adj }} runtimes deployed on it.</li>
                                    <li>For more information about setting up a server, see <a href="../topologies/#constraints-on-mobilefirst-server-administration-service-mobilefirst-server-live-update-service-and-mobilefirst-foundation-runtime">Constraints on {{ site.data.keys.mf_server }} administration service, {{ site.data.keys.mf_server }} live update service and {{ site.data.keys.product_adj }} runtime</a>.</li>
                                </ul>
                            </li>
                            <li>Exchange the signer certificates between all the servers in their respective truststores.
                            <br/><br/>
                            This step is mandatory for the farms that use WebSphere Application Server full profile or Liberty as security must be enabled. In addition, for Liberty farms, the same LTPA configuration must be replicated on each server to ensure single-sign on capability. To do this configuration, follow the guidelines in step 6 of <a href="#configuring-a-server-farm-manually">Configuring a server farm manually</a>.
                            </li>
                        </ul>
                    </li>
                    <li>Run the Server Configuration Tool for each server of the farm. All servers must share the same databases. Make sure to select the deployment type: <b>Server farm deployment</b> in the <b>Application Server Settings</b> panel. For more information about the tool, see <a href="#running-the-server-configuration-tool">Running the Server Configuration Tool</a>.
                    </li>
                </ol>
            </div>
        </div>
    </div>
</div>

### Installing a server farm with Ant tasks
{: #installing-a-server-farm-with-ant-tasks }
Use Ant tasks to configure each server in the farm according to the requirements of the single type of application server that is used for each member of the server farm.

When you plan a server farm with Ant tasks, first create the stand-alone servers and configure their respective truststores so that they can communicate with one another in a secure way. Then, run Ant tasks to configure the database instance that is shared by the {{ site.data.keys.mf_server }} components. Finally, run Ant tasks to deploy the {{ site.data.keys.mf_server }} components to each server and modify its configuration to make it a member of a server farm.

<div class="panel-group accordion" id="installing-mobilefirst-server-ant" role="tablist" aria-multiselectable="true">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="server-farm-ant">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#server-farm-ct" href="#collapse-server-farm-ant" aria-expanded="true" aria-controls="collapse-server-farm-ant"><b>Click for instructions on installing a server farm with Ant tasks</b></a>
            </h4>
        </div>

        <div id="collapse-server-farm-ant" class="panel-collapse collapse" role="tabpanel" aria-labelledby="server-farm-ant">
            <div class="panel-body">
                <p>{{ site.data.keys.mf_server }} requires the secure JMX connection to be configured.</p>

                <ol>
                    <li>Prepare the application servers that must be configured as the server farm members.
                        <ul>
                            <li>Choose the type of application server to use to configure the members of the server farm. {{ site.data.keys.product }} supports the following application servers in server farms:
                                <ul>
                                    <li>WebSphere  Application Server full profile. <b>Note:</b> In a farm topology, you cannot use the RMI JMX connector. In this topology, only the SOAP connector is supported by {{ site.data.keys.product }}.</li>
                                    <li>WebSphere Application Server Liberty profile</li>
                                    <li>Apache Tomcat</li>
                                </ul>
                                To know which versions of the application servers are supported, see <a href="../../../product-overview/requirements">System requirements</a>.

                                <blockquote><b>Important:</b> {{ site.data.keys.product }} supports only homogeneous server farms. A server farm is homogeneous when it connects same type of application servers. Attempting to associate different types of application servers might lead to unpredictable behavior at run time. For example, a farm with a mix of Apache Tomcat servers and WebSphere Application Server full profile servers is an invalid configuration.</blockquote>
                            </li>
                            <li>Set up as many stand-alone servers as the number of members that you want in the farm.
                            <br/><br/>
                            Each of these stand-alone servers must communicate with the same database. You must make sure that any port used by any of these servers is not also used by another server that is configured on the same host. This constraint applies to the ports used by HTTP, HTTPS, REST, SOAP, and RMI protocols.
                            <br/><br/>
                            Each of these servers must have the {{ site.data.keys.mf_server }} administration service, the {{ site.data.keys.mf_server }} live update service, and one or more {{ site.data.keys.product_adj }} runtimes deployed on it.
                            <br/><br/>
                            For more information about setting up a server, see <a href="../topologies/#constraints-on-mobilefirst-server-administration-service-mobilefirst-server-live-update-service-and-mobilefirst-foundation-runtime">Constraints on {{ site.data.keys.mf_server }} administration service, {{ site.data.keys.mf_server }} live update service and {{ site.data.keys.product_adj }} runtime</a>.</li>
                            <li>Exchange the signer certificates between all the servers in their respective truststores.
                            <br/><br/>
                            This step is mandatory for the farms that use WebSphere Application Server full profile or Liberty as security must be enabled. In addition, for Liberty farms, the same LTPA configuration must be replicated on each server to ensure single-sign on capability. To do this configuration, follow the guidelines in step 6 of <a href="#configuring-a-server-farm-manually">Configuring a server farm manually</a>.
                            </li>
                        </ul>
                    </li>
                    <li>Configure the database for the administration service, the live update service, and the runtime.
                        <ul>
                            <li>Decide which database that you want to use and choose the Ant file to create and configure the database in the <b>mfp_install_dir/MobileFirstServer/configuration-samples</b> directory:
                                <ul>
                                    <li>For DB2 , use <b>create-database-db2.xml</b>.</li>
                                    <li>For MySQL, use <b>create-database-mysql.xml</b>.</li>
                                    <li>For Oracle, use <b>create-database-oracle.xml</b>.</li>
                                </ul>
                                <blockquote>Note: Do not use the Derby database in a farm topology because the Derby database allows only a single connection at a time.</blockquote>

                            </li>
                            <li>Edit the Ant file and enter all the required properties for the database.
                            <br/><br/>
                            To enable the configuration of the database that is used by the {{ site.data.keys.mf_server }} components, set the values of the following properties:
                                <ul>
                                    <li>Set <b>mfp.process.admin</b> to <b>true</b>. To configure the database for the administration service and the live update service.</li>
                                    <li>Set <b>mfp.process.runtime</b> to <b>true</b>. To configure the database for the runtime.</li>
                                </ul>
                            </li>
                            <li>Run the following commands from the <b>mfp_install_dir/MobileFirstServer/configuration-samples</b> directory where <b>create-database-ant-file.xml</b> must be replaced with the actual Ant file name that you chose: <code>mfp_install_dir/shortcuts/ant -f create-database-ant-file.xml admdatabases</code> and <code>mfp_install_dir/shortcuts/ant -f create-database-ant-file.xml rtmdatabases</code>.
                            <br/><br/>
                            As the {{ site.data.keys.mf_server }} databases are shared between the application servers in a farm, these two commands must be run only once, whatever the number of servers in the farm.
                            </li>
                            <li>Optionally, if you want to install another runtime, you must configure another database with another database name or schema. To do so, edit the Ant file, modify the properties, and run the following command once, whatever the number of servers in the farm: <code>mfp_install_dir/shortcuts/ant -f create-database-ant-file.xml rtmdatabases</code>.</li>
                        </ul>
                    </li>
                    <li>Deploy the administration service, the live update service, and the runtime on the servers and configure these servers as the members of a server farm.
                        <ul>
                            <li>Choose the Ant file that corresponds to your application server and your database in the <b>mfp\_install\_dir/MobileFirstServer/configuration-samples</b> directory to deploy the administration service, the live update service, and the runtime on the servers.
                            <br/><br/>
                            For example, choose the <b>configure-liberty-db2.xml</b> file for a deployment on Liberty server with the DB2 database. Make as many copies of this file as the number of members that you want in the farm.
                            <br/><br/>
                            <b>Note:</b> Keep these files after the configuration as they can be reused for upgrading the {{ site.data.keys.mf_server }} components that are already deployed, or for uninstalling them from each member of the farm.</li>
                            <li>Edit each copy of the Ant file, enter the same properties for the database that are used at step 2, and also enter the other required properties for the application server.
                            <br/><br/>
                            To configure the server as a server farm member, set the values of the following properties:
                                <ul>
                                    <li>Set <b>mfp.farm.configure</b> to true.</li>
                                    <li><b>mfp.farm.server.id</b>: An identifier that you define for this farm member. Make sure that each server in the farm has its own unique identifier. If two servers in the farm have the same identifier, the farm might behave in an unpredictable way.</li>
                                    <li><b>mfp.config.service.user</b>: The user name that is used to access the live update service. The user name must be the same for all the members of the farm.</li>
                                    <li><b>mfp.config.service.password</b>: The password that is used to access the live update service. The password must be the same for all the members of the farm.</li>
                                </ul>
                                To enable the deployment of the WAR files of the {{ site.data.keys.mf_server }} components on the server, set the values of the following properties:
                                    <ul>
                                        <li>Set <b>mfp.process.admin</b> to <b>true</b>. To deploy the WAR files of the administration service and the live update service.</li>
                                        <li>Set <b>mfp.process.runtime</b> to <b>true</b>. To deploy the WAR file of the runtime.</li>
                                    </ul>
                                <br/>
                                <b>Note:</b> If you plan to install more than one runtime on the servers of the farm, specify the attribute id and set a value that must be unique for each runtime on the <b>installmobilefirstruntime</b>, <b>updatemobilefirstruntime</b>, and <b>uninstallmobilefirstruntime</b> Ant tasks.
                                <br/>
                                For example,
{% highlight xml %}
<target name="rtminstall">
    <installmobilefirstruntime execute="true" contextroot="/runtime1" id="rtm1">
{% endhighlight %}
                            </li>
                            <li>For each server, run the following commands where <b>configure-appserver-database-ant-file.xml</b> must be replaced with the actual Ant file name that you chose: <code>mfp_install_dir/shortcuts/ant -f configure-appserver-database-ant-file.xml adminstall</code> and <code>mfp_install_dir/shortcuts/ant -f configure-appserver-database-ant-file.xml rtminstall</code>.
                            <br/><br/>
                            These commands run the <b>installmobilefirstadmin</b> and <b>installmobilefirstruntime</b> Ant tasks. For more information about these tasks, see <a href="../installation-reference/#ant-tasks-for-installation-of-mobilefirst-operations-console-mobilefirst-server-artifacts-mobilefirst-server-administration-and-live-update-services">Ant tasks for installation of {{ site.data.keys.mf_console }}, {{ site.data.keys.mf_server }} artifacts, {{ site.data.keys.mf_server }} administration, and live update services</a> and <a href="../installation-reference/#ant-tasks-for-installation-of-mobilefirst-runtime-environments">Ant tasks for installation of {{ site.data.keys.product_adj }} runtime environments</a>.
                            </li>
                            <li>Optionally, if you want to install another runtime, do the following steps:
                                <ul>
                                    <li>Make a copy of the Ant file that you configured at step 3.b.</li>
                                    <li>Edit the copy, set a distinct context root, and a value for the attribute <b>id</b> of <b>installmobilefirstruntime</b>, <b>updatemobilefirstruntime</b>, and <b>uninstallmobilefirstruntime</b> that is different from the other runtime configuration.</li>
                                    <li>Run the following command on each server on the farm where <b>configure-appserver-database-ant-file2.xml</b> must be replaced with the actual name of the Ant file that is edited: <code>mfp_install_dir/shortcuts/ant -f configure-appserver-database-ant-file2.xml rtminstall</code>.</li>
                                    <li>Repeat this step for each server of the farm.</li>
                                </ul>
                            </li>                            
                        </ul>
                    </li>
                    <li>Restart all the servers.</li>
                </ol>
            </div>
        </div>
    </div>
</div>

### Configuring a server farm manually
{: #configuring-a-server-farm-manually }
You must configure each server in the farm according to the requirements of the single type of application server that is used for each member of the server farm.

When you plan a server farm, first create stand-alone servers that communicate with the same database instance. Then, modify the configuration of these servers to make them members of a server farm.

<div class="panel-group accordion" id="configuring-manually" role="tablist" aria-multiselectable="true">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="manual">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#websphere-prereq" href="#collapse-manual" aria-expanded="true" aria-controls="collapse-manual"><b>Click for instructions on configuring a server farm manually</b></a>
            </h4>
        </div>

        <div id="collapse-manual" class="panel-collapse collapse" role="tabpanel" aria-labelledby="manual">
            <div class="panel-body">
                <ol>
                    <li>Choose the type of application server to use to configure the members of the server farm. {{ site.data.keys.product }} supports the following application servers in server farms:
                        <ul>
                            <li>WebSphere  Application Server full profile<br/>
                            <b>Note:</b> In a farm topology, you cannot use the RMI JMX connector. In this topology, only the SOAP connector is supported by {{ site.data.keys.product }}.</li>
                            <li>WebSphere Application Server Liberty profile</li>
                            <li>Apache Tomcat</li>
                        </ul>
                        To know which versions of the application servers are supported, see <a href="../../../product-overview/requirements">System requirements</a>.

                        <blockquote><b>Important:</b> {{ site.data.keys.product }} supports only homogeneous server farms. A server farm is homogeneous when it connects same type of application servers. Attempting to associate different types of application servers might lead to unpredictable behavior at run time. For example, a farm with a mix of Apache Tomcat servers and WebSphere Application Server full profile servers is an invalid configuration.</blockquote>
                    </li>
                    <li>Decide which database that you want to use. You can choose from:
                        <ul>
                            <li>DB2 </li>
                            <li>MySQL</li>
                            <li>Oracle</li>
                        </ul>
                        {{ site.data.keys.mf_server }} databases are shared between the application servers in a farm, which means:
                        <ul>
                            <li>You create the database only once, whatever the number of servers in the farm.</li>
                            <li>You cannot use the Derby database in a farm topology because the Derby database allows only a single connection at a time.</li>
                        </ul>
                        For more information about databases, see <a href="../databases">Setting up databases</a>.
                    </li>
                    <li>Set up as many stand-alone servers as the number of members that you want in the farm.
                        <ul>
                            <li>Each of these stand-alone servers must communicate with the same database. You must make sure that any port used by any of these servers is not also used by another server that is configured on the same host. This constraint applies to the ports used by HTTP, HTTPS, REST, SOAP, and RMI protocols.</li>
                            <li>Each of these servers must have the {{ site.data.keys.mf_server }} administration service, the {{ site.data.keys.mf_server }} live update service, and one or more {{ site.data.keys.product_adj }} runtimes deployed on it.</li>
                            <li>When each of these servers is working properly in a stand-alone topology, you can transform them into members of a server farm.</li>
                        </ul>
                    </li>
                    <li>Stop all the servers that are intended to become members of the farm.</li>
                    <li>Configure each server appropriately for the type of application server.<br/>You must set some JNDI properties correctly. In a server farm topology, the mfp.config.service.user and mfp.config.service.password JNDI properties must have the same value for all the members of the farm. For Apache Tomcat, you must also check that the JVM arguments are properly defined.
                        <ul>
                            <li><b>WebSphere Application Server Liberty profile</b>
                                <br/>
                                In the server.xml file, set the JNDI properties shown in the following sample code.
{% highlight xml %}
<jndiEntry jndiName="mfp.topology.clustermode" value="Farm"/>
<jndiEntry jndiName="mfp.admin.serverid" value="farm_member_1"/>
<jndiEntry jndiName="mfp.admin.jmx.user" value="myRESTConnectorUser"/>
<jndiEntry jndiName="mfp.admin.jmx.pwd" value="password-of-rest-connector-user"/>
<jndiEntry jndiName="mfp.admin.jmx.host" value="93.12.0.12"/>
<jndiEntry jndiName="mfp.admin.jmx.port" value="9443"/>
{% endhighlight %}
                                These properties must be set with appropriate values:
                                <ul>
                                    <li><b>mfp.admin.serverid</b>: The identifier that you defined for this farm member. This identifier must be unique across all farm members.</li>
                                    <li><b>mfp.admin.jmx.user</b> and <b>mfp.admin.jmx.pwd</b>: These values must match the credentials of a user as declared in the <code>administrator-role</code> element.</li>
                                    <li><b>mfp.admin.jmx.host</b>: Set this parameter to the IP or the host name that is used by remote members to access this server. Therefore, do not set it to <b>localhost</b>. This host name is used by the other members of the farm and must be accessible to all farm members.</li>
                                    <li><b>mfp.admin.jmx.port</b>: Set this parameter to the server HTTPS port that is used for the JMX REST connection. You can find the value in the <code>httpEndpoint</code> element of the <b>server.xml</b> file.</li>
                                </ul>
                            </li>
                            <li><b>Apache Tomcat</b>
                                <br/>
                                Modify the <b>conf/server.xml</b> file to set the following JNDI properties in the administration service context and in every runtime context.
{% highlight xml %}
<Environment name="mfp.topology.clustermode" value="Farm" type="java.lang.String" override="false"/>
<Environment name="mfp.admin.serverid" value="farm_member_1" type="java.lang.String" override="false"/>
{% endhighlight %}
                                The <b>mfp.admin.serverid</b> property must be set to the identifier that you defined for this farm member. This identifier must be unique across all farm members.
                                <br/>
                                You must make sure that the <code>-Djava.rmi.server.hostname</code> JVM argument is set to the IP or the host name that is used by remote members to access this server. Therefore, do not set it to <b>localhost</b>. In addition, you must make sure that the <code>-Dcom.sun.management.jmxremote.port</code> JVM argument is set with a port that is not already in use to enable JMX RMI connections. Both arguments are set in the <b>CATALINA_OPTS</b> environment variable.
                            </li>
                            <li><b>WebSphere Application Server full profile</b>
                                <br/>
                                You must declare the following JNDI properties in the administration service and in every runtime application deployed on the server.
                                <ul>
                                    <li><b>mfp.topology.clustermode</b></li>
                                    <li><b>mfp.admin.serverid</b></li>
                                </ul>
                                In the WebSphere Application Server console,
                                <ul>
                                    <li>select <b>Applications → Application Types → WebSphere Enterprise applications</b>.</li>
                                    <li>Select the administration service application.</li>
                                    <li>In <b>Web Module Properties</b>, click <b>Environment entries for Web Modules</b> to display the JNDI properties.</li>
                                    <li>Set the values of the following properties.
                                        <ul>
                                            <li>Set <b>mfp.topology.clustermode</b> to <b>Farm</b>.</li>
                                            <li>Set <b>mfp.admin.serverid</b> to the identifier that you chose for this farm member. This identifier must be unique across all farm members.</li>
                                            <li>Set <b>mfp.admin.jmx.user</b> to a user name that has access to the SOAP connector.</li>
                                            <li>Set <b>mfp.admin.jmx.pwd</b> to the password of the user as declared in <b>mfp.admin.jmx.user</b>.</li>
                                            <li>Set <b>mfp.admin.jmx.port</b> to the value of the SOAP port.</li>
                                        </ul>
                                    </li>
                                    <li>Verify that <b>mfp.admin.jmx.connector</b> is set to <b>SOAP</b>.</li>
                                    <li>Click <b>OK</b> and save the configuration.</li>
                                    <li>Make similar changes for every {{ site.data.keys.product_adj }} runtime application deployed on the server.</li>
                                </ul>
                            </li>
                        </ul>
                    </li>
                    <li>Exchange the server certificates in their truststores between all members of the farm. Exchanging the server certificates in their truststores is mandatory for farms that use WebSphere Application Server full profile and WebSphere Application Server Liberty profile because in these farms, communications between the servers is secured by SSL.
                        <ul>
                            <li><b>WebSphere Application Server Liberty profile</b>
                                <br/>
                                You can configure the truststore by using IBM  utilities such as Keytool or iKeyman.
                                <ul>
                                    <li>For more information about Keytool, see <a href="http://www-01.ibm.com/support/knowledgecenter/?lang=en#!/SSYKE2_6.0.0/com.ibm.java.security.component.60.doc/security-component/keytoolDocs/keytool_overview.html">Keytool</a> in the IBM SDK, Java Technology Edition.</li>
                                    <li>For more information about iKeyman, see <a href="http://www-01.ibm.com/support/knowledgecenter/?lang=en#!/SSYKE2_6.0.0/com.ibm.java.security.component.60.doc/security-component/ikeyman_tool.html">iKeyman</a> in the IBM SDK, Java Technology Edition.</li>
                                </ul>
                                The locations of keystore and truststore are defined in the <b>server.xml</b> file. See the <b>keyStoreRef</b> and <b>trustStoreRef</b> attributes in <a href="http://www.ibm.com/support/knowledgecenter/SSD28V_8.5.5/com.ibm.websphere.wlp.core.doc/ae/rwlp_ssl.html?lang=en&view=kc">SSL configuration attributes</a>. By default, the keystore of Liberty profile is at <b>${server.config.dir}/resources/security/key.jks</b>. If the truststore reference is missing or not defined in the <b>server.xml</b> file, the keystore that is specified by <b>keyStoreRef</b> is used. The server uses the default keystore and the file is created the first time that the server runs. In that case, a default certificate is created with a validity period of 365 days. For production, you might consider using your own certificate (including the intermediate ones, if needed) or changing the expiration date of the generated certificate.

                                <blockquote>Note: If you want to confirm the location of the truststore, you can do so by adding the following declaration to the server.xml file:
{% highlight xml %}
<logging traceSpecification="SSL=all:SSLChannel=all"/>
{% endhighlight %}
                                </blockquote>
                                Lastly, start the server and look for lines that contain com.ibm.ssl.trustStore in the <b>${wlp.install.dir}/usr/servers/server_name/logs/trace.log</b> file.
                                <ul>
                                    <li>Import the public certificates of the other servers in the farm into the truststore that is referenced by the <b>server.xml</b> configuration file of the server. The tutorial <a href="../tutorials/graphical-mode">Installing {{ site.data.keys.mf_server }} in graphical mode</a> provides you the instructions to exchange the certificates between two Liberty servers in a farm. For more information, see step 5 of <a href="../tutorials/graphical-mode/#creating-a-farm-of-two-liberty-servers-that-run-mobilefirst-server">Creating a farm of two Liberty servers that run {{ site.data.keys.mf_server }}</a> section.</li>
                                    <li>Restart each instance of WebSphere Application Server Liberty profile to make the security configuration take effect. The following steps are needed for single sign-on (SSO) to work.</li>
                                    <li>Start one member of the farm. In the default LTPA configuration, after the Liberty server starts successfully, it generates an LTPA keystore as <b>${wlp.user.dir}/servers/server_name/resources/security/ltpa.keys.</b></li>
                                    <li>Copy the <b>ltpa.keys</b> file to the <b>${wlp.user.dir}/servers/server_name/resources/security</b> directory of each farm member to replicate the LTPA keystores across the farm members. For more information about LTPA configuration, see <a href="http://www.ibm.com/support/knowledgecenter/?view=kc#!/SSAW57_8.5.5/com.ibm.websphere.wlp.nd.multiplatform.doc/ae/twlp_sec_ltpa.html">Configuring LTPA on the Liberty profile</a>.</li>
                                </ul>
                            </li>
                            <li><b>WebSphere Application Server full profile</b>
                                <br/>
                                Configure the truststore in the WebSphere Application Server administration console.
                                <ul>
                                    <li>Log in to WebSphere Application Server administration console.</li>
                                    <li>Select <b>Security → SSL certificate and key management</b>.</li>
                                    <li>In <b>Related Items</b>, select <b>Keystores and certificates</b>.</li>
                                    <li>In the <b>Keystore usages</b> field, make sure that <b>SSL keystores</b> is selected. You can now import the certificates from all the other servers in the farm.</li>
                                    <li>Click <b>NodeDefaultTrustStore</b>.</li>
                                    <li>In <b>Additional Properties</b>, select <b>Signer certificates</b>.</li>
                                    <li>Click <b>Retrieve from port</b>. You can now enter communication and security details of each of the other servers in the farm. Follow the next steps for each of the other farm members.</li>
                                    <li>In the <b>Host</b> field, enter the server host name or IP address.</li>
                                    <li>In the <b>Port</b> field, enter the HTTPS transport (SSL) port.</li>
                                    <li>In <b>SSL configuration for outbound connection</b>, select <b>NodeDefaultSSLSettings</b>.</li>
                                    <li>In the <b>Alias</b> field, enter an alias for this signer certificate.</li>
                                    <li>Click <b>Retrieve signer information</b>.</li>
                                    <li>Review the information that is retrieved from the remote server and then click <b>OK</b>.</li>
                                    <li>Click <b>Save</b>.</li>
                                    <li>Restart the server.</li>
                                </ul>    
                            </li>
                        </ul>
                    </li>
                </ol>
            </div>
        </div>
    </div>
</div>

### Verifying a farm configuration
{: #verifying-a-farm-configuration }
The purpose of this task is to check the status of the farm members and verify whether a farm is configured properly.

1. Start all the servers of the farm.
2. Access {{ site.data.keys.mf_console }}. For example, **http://server_name:port/mfpconsole**, or **https://hostname:secure_port/mfpconsole** in HTTPS.
    In the console sidebar, an extra menu that is labeled as Server Farm Nodes appears.
3. Click **Server Farm Nodes** to access the list of registered farm members and their status. In the following example, the node that is identified as **FarmMember2** is considered to be down, which indicates that this server has probably failed and requires some maintenance.

![Status of Farm nodes in the {{ site.data.keys.mf_console }}](farm_nodes_status_list.jpg)

### Lifecycle of a server farm node
{: #lifecycle-of-a-server-farm-node }
You can configure heartbeat rate and timeout values to indicate possible server problems among farm members by triggering a change in status of an affected node.

#### Registration and monitoring servers as farm nodes
{: #registration-and-monitoring-servers-as-farm-nodes }
When a server configured as a farm node is started, the administration service on that server automatically registers it as a new farm member.
When a farm member is shut down, it automatically unregisters from the farm.

A heartbeat mechanism exists to keep track of farm members that might become unresponsive, for example, because of a power outage or a server failure. In this heartbeat mechanism, {{ site.data.keys.product_adj }} runtimes periodically send a heartbeat to {{ site.data.keys.product_adj }} administration services at a specified rate. If the {{ site.data.keys.product_adj }} administration service registers that too long a time has elapsed since a farm member sent a heartbeat, the farm member is considered to be down.

Farm members that are considered to be down do not serve any more requests to mobile applications.

Having one or more nodes down does not prevent the other farm members from correctly serving requests to mobile applications nor from accepting new management operations that are triggered through the {{ site.data.keys.mf_console }}.

#### Configuring the heartbeat rate and timeout values
{: #configuring-the-heartbeat-rate-and-timeout-values }
You can configure the heartbeat rate and timeout values by defining the following JNDI properties:

* **mfp.admin.farm.heartbeat**
* **mfp.admin.farm.missed.heartbeats.timeout**

<br/>
For more information about JNDI properties, see [List of JNDI properties for {{ site.data.keys.mf_server }} administration service](../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service).
