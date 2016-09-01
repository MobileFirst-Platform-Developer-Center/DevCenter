---
layout: tutorial
title: Installing MobileFirst Server to an application server
weight: 4
---
## Overview
The installation of the components can be done by using Ant Tasks, the Server Configuration Tool, or manually. Find out the prerequisite and the details about the installation process so that you can install the components on the application server successfully.

Before you proceed with installing the components to the application server, ensure that the databases and the tables for the components are prepared and ready to use. For more information, see [Setting up databases](../databases).

The server topology to install the components must also be defined. See [Topologies and network flows](../topologies).

#### Jump to

* [Application server prerequisites](#application-server-prerequisites)
* [Installing with the Server Configuration Tool](#installing-with-the-server-configuration-tool) 
* [Installing with Ant tasks](#installing-with-ant-tasks)
* [Installing the MobileFirst Server components manually](#installing-the-mobilefirst-server-components-manually)
* [Installing a server farm](#installing-a-server-farm)

## Application server prerequisites
Depending on your choice of the application server, select one of the following topics to find out the prerequisites that you must fulfill before you install the MobileFirst Server components.

* [Apache Tomcat prerequisites](#apache-tomcat-prerequisites)
* [WebSphere Application Server Liberty prerequisites](#websphere-application-server-liberty-prerequisites)
* [WebSphere Application Server and WebSphere Application Server Network Deployment prerequisites](#websphere-application-server-and-websphere-application-server-network-deployment)

### Apache Tomcat prerequisites
MobileFirst Server has some requirements for the configuration of Apache Tomcat that are detailed in the following topics.  
Ensure that you fulfill the following criteria:

* Use a supported version of Apache Tomcat. See [System requirements](../../../product-overview/requirements).
* Apache Tomcat must be run with JRE 7.0 or later.
* The JMX configuration must be enabled to allow the communication between the administration service and the runtime component. The communication uses RMI as described in **Configuring JMX connection for Apache Tomcat** below.

<div class="panel-group accordion" id="tomcat-prereq" role="tablist" aria-multiselectable="true">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="jmx-connection">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#tomcat-prereq" href="#collapse-jmx-connection" aria-expanded="true" aria-controls="collapse-jmx-connection"> Configuring JMX connection for Apache Tomcat</a>
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
                            <li>registryPort must have the same value as the rmiRegistryPortPlatform attribute of the JMX Remote Lifecycle Listener.</li>
                            <li>serverPort must have the same value as the rmiServerPortPlatform attribute of the JMX Remote Lifecycle Listener.</li>
                        </ul>
                    <li>If you installed Apache Tomcat with the Apache Tomcat Windows Service Installer instead of adding the options to <b>CATALINA_OPTS</b>, run <b>tomcat_install_dir/bin/Tomcat7w.exe</b>, and add the options in the <b>Java</b> tab of the Properties window.
                    
                    <img alt="Apache Tomcat 7 properties" src="Tomcat_Win_Service_Installer_properties.jpg"/></li>
                </ol>
            </div>
        </div>
    </div>
</div>

### WebSphere Application Server Liberty prerequisites
IBM MobileFirst Server has some requirements for the configuration of the Liberty server that are detailed in the following topics.  
Ensure that you fulfill the following criteria:

* Use a supported version of Liberty. See [System requirements](../../../product-overview/requirements).
* Liberty must be run with JRE 7.0 or later. JRE 6.0 is not supported.
* Some versions of Liberty support both the features of Java™ EE 6 and Java EE 7. For example, jdbc-4.0 Liberty feature is part of Java EE 6, whereas jdbc-4.1 Liberty feature is part of Java EE 7. MobileFirst Server V8.0.0 can be installed with Java EE 6 or Java EE 7 features. However, if you want to run an older version of MobileFirst Server on the same Liberty server, you must use the Java EE 6 features. MobileFirst Server V7.1.0 and earlier, does not support the Java EE 7 features.
* JMX must be configured as documented in **Configuring JMX connection for WebSphere Application Server Liberty profile** below.
* For an installation in a production environment, you might want to start the Liberty server as a service on Windows, Linux, or UNIX systems so that:
The MobileFirst Server components are started automatically when the computer starts.
The process that runs Liberty server is not stopped when the user, who started the process, logs out.
* MobileFirst Server V8.0.0 cannot be deployed in a Liberty server that contains the deployed MobileFirst Server components from the previous versions.
* For an installation in a Liberty collective environment, the Liberty collective controller and the Liberty collective cluster members must be configured as documented in [Configuring a Liberty collective](http://www.ibm.com/support/knowledgecenter/SSAW57_8.5.5/com.ibm.websphere.wlp.nd.doc/ae/tagt_wlp_configure_collective.html?view=kc).

<div class="panel-group accordion" id="websphere-prereq" role="tablist" aria-multiselectable="true">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="websphere-jmx-connection">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#websphere-prereq" href="#collapse-websphere-jmx-connection" aria-expanded="true" aria-controls="collapse-websphere-jmx-connection"> Configuring JMX connection for WebSphere Application Server Liberty profile</a>
            </h4>
        </div>

        <div id="collapse-websphere-jmx-connection" class="panel-collapse collapse" role="tabpanel" aria-labelledby="websphere-jmx-connection">
            <div class="panel-body">
                <p>MobileFirst Server requires the secure JMX connection to be configured.</p>
                
                <ul>
                    <li>The Server Configuration Tool and the Ant tasks can configure a default secure JMX connection, which includes the generation of a self-signed SSL certificate with a validity period of 365 days. This configuration is not intended for production use.</li>
                    <li>To configure the secure JMX connection for production use, follow the instructions as described in <a href="http://www.ibm.com/support/knowledgecenter/SSD28V_8.5.5/com.ibm.websphere.wlp.core.doc/ae/twlp_admin_restconnector.html?cp=SSD28V_8.5.5&view=embed">Configuring secure JMX connection to the Liberty profile</a>.</li>
                    <li>The rest-connector is available for WebSphere® Application Server, Liberty Core, and other editions of Liberty, but it is possible to package a Liberty server with a subset of the available features. To verify that the rest-connector feature is available in your installation of Liberty, enter the following command:
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
IBM MobileFirst Server has some requirements for the configuration of WebSphere® Application Server and WebSphere Application Server Network Deployment that are detailed in the following topics.  
Ensure that you fulfill the following criteria:

* Use a supported version of WebSphere Application Server. See [System requirements](../../../product-overview/requirements).
* The application server must be run with JRE 7.0. By default, WebSphere Application Server uses Java™ 6.0 SDK. To switch to Java 7.0 SDK, see [Switching to Java 7.0 SDK in WebSphere Application Server](https://www.ibm.com/support/knowledgecenter/SSWLGF_8.5.5/com.ibm.sr.doc/twsr_java17.html).
* The administrative security must be turned on. MobileFirst Operations Console, the MobileFirst Server administration service, and the MobileFirst Server configuration service are protected by security roles. For more information, see [Enabling security](https://www.ibm.com/support/knowledgecenter/SSEQTP_8.5.5/com.ibm.websphere.base.doc/ae/tsec_csec2.html?cp=SSEQTP_8.5.5%2F1-8-2-31-0-2&lang=en).
* The JMX configuration must be enabled to allow the communication between the administration service and the runtime component. The communication uses SOAP. For WebSphere Application Server Network Deployment, RMI can be used. For more information, see **Configuring JMX connection for WebSphere Application Server and WebSphere Application Server Network Deployment** below.

<div class="panel-group accordion" id="websphere-nd-prereq" role="tablist" aria-multiselectable="true">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="websphere-nd-jmx-connection">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#websphere-nd-prereq" href="#collapse-websphere-nd-jmx-connection" aria-expanded="true" aria-controls="collapse-websphere-nd-jmx-connection">Configuring JMX connection for WebSphere Application Server and WebSphere Application Server Network Deployment</a>
            </h4>
        </div>

        <div id="collapse-websphere-nd-jmx-connection" class="panel-collapse collapse" role="tabpanel" aria-labelledby="websphere-nd-jmx-connection">
            <div class="panel-body">
                <p>MobileFirst Server requires the secure JMX connection to be configured.</p>
                
                <ul>
                    <li>MobileFirst Server requires access to the SOAP port, or the RMI port to perform JMX operations. By default, the SOAP port is active on a WebSphere Application Server. MobileFirst Server uses the SOAP port by default. If both the SOAP and RMI ports are deactivated, MobileFirst Server does not run.</li>
                    <li>RMI is only supported by WebSphere Application Server Network Deployment. RMI is not supported by a stand-alone profile, or a WebSphere Application Server server farm.</li>
                    <li>You must activate Administrative and Application Security.</li>
                </ul>
            </div>
        </div>
    </div>
</div>

### File system prerequisites
To install IBM MobileFirst Server to an application server, the MobileFirst installation tools must be run by a user that has specific file system privileges.  
The installation tools include:

* IBM® Installation Manager
* The Server Configuration Tool
* The Ant tasks to deploy MobileFirst Server

For WebSphere® Application Server Liberty profile, you must have the required permission to perform the following actions:

* Read the files in the Liberty installation directory.
* Create files in the configuration directory of the Liberty server, which is typically usr/servers/<servername>, to create backup copies and modify server.xml and jvm.options.
* Create files and directories in the Liberty shared resource directory, which is typically usr/shared.
* Create files in the Liberty server apps directory, which is typically usr/servers/<servername>/apps.

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

For all these application servers, the user who runs the application server must be able to read the files that were created by the user who ran the MobileFirst installation tools.

## Installing with the Server Configuration Tool
Use the Server Configuration Tool to install the MobileFirst Server components to your application server.

The Server Configuration Tool can set up the database and install the components to an application server. This tool is meant for a single user. The configuration files are store on the disk. The directory where they are stored can be modified with menu **File → Preferences**. The files must be used only by one instance of the Server Configuration Tool at the time. The tool does not manage concurrent access to the same file. If you have multiple instances of the tool accessing the same file, the data might be lost. For more information about how the tool creates and setup the databases, see [Create the database tables with the Server Configuration Tool](../databases/#create-the-database-tables-with-the-server-configuration-tool). If the databases exist, the tool can detect them by testing the presence and the content of some test tables and does not modify these database tables.

* [Supported operating systems](#supported-operating-systems)
* [Supported topologies](#supported-topologies)
* [Running the Server Configuration Tool](#running-the-server-configuration-tool)
* [Applying a fix pack by using the Server Configuration Tool](#applying-a-fix-pack-by-using-the-server-configuration-tool)

### Supported operating systems
You can use the Server Configuration Tool if you are on the following operating systems:

* Windows x86 or x86-64
* macOS x86-64
* Linux x86 or Linux x86-64

The tool is not available on other operating systems. You need to use Ant tasks to install the MobileFirst Server components as described in [Installing with Ant Tasks](#installing-with-ant-tasks).

### Supported topologies
The Server Configuration Tool installs the MobileFirst Server components with the following topologies:

* All components (MobileFirst Operations Console, the MobileFirst Server administration service, the MobileFirst Server live update service, and the MobileFirst runtime) are in the same application server. However, on WebSphere® Application Server Network Deployment when you install on a cluster, you can specify a different cluster for the administration and live update services, and for the runtime. On Liberty collective, MobileFirst Operations Console, the administration service, and the live update service are installed in a collective controller and the runtime in a collective member.
* If the MobileFirst Server push service is installed, it is also installed on the same server. However, on WebSphere Application Server Network Deployment when you install on a cluster, you can specify a different cluster for the push service. On Liberty collective, the push service is installed in a Liberty member that can be the same as the one where the runtime is installed.
* All the components use the same database system and the user. For DB2®, all the components also use the same schema.
* The Server Configuration Tool installs the components for a single server except for Liberty collective and WebSphere Application Server Network Deployment for asymmetric deployment. For an installation on multiple servers, a farm must be configured after the tool is run. The server farm configuration is not required on WebSphere Application Server Network Deployment.

For other topologies or other database settings, you can install the components with Ant Tasks or manually instead.

### Running the Server Configuration Tool
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
                            <li>The <b>mfp_server_install_dir</b> directory is where you installed MobileFirst Server.</li>
                        </ul>
                    </li>
                    <li>Select <b>File → New Configuration</b> to create a MobileFirst Server Configuration.
                        <ul>
                            <li>In the <b>Configuration Details</b> panel, enter the context root of the administration service and the runtime component. You might want to enter an environment ID. An environment ID is used in advanced use cases, for example when <a href="../topologies/#multiple-instances-of-mobilefirst-server-on-the-same-server-or-websphere-application-server-cell">multiple installations of MobileFirst Server are made on the same application server or same WebSphere® Application Server cell</a>.</li>
                            <li>In the <b>Console Settings</b> panel, select whether to install MobileFirst Operations Console or not. If the console is not installed, you need to use command line tools (<b>mfpdev</b> or <b>mfpadm</b>) or the REST API to interact with the MobileFirst Server administration service.</li>
                            <li>In the <b>Database Selection</b> panel, select the database management system that you plan to use. All the components use the same database type and the same database instance. For more information about the database panes, see <a href="../databases/#create-the-database-tables-with-the-server-configuration-tool">Create the database tables with the Server Configuration Tool</a>.</li>
                            <li>In the <b>Application Server Selection</b> panel, select the type of application server where you want to deploy MobileFirst Server.</li>
                        </ul>
                    </li>
                    <li>In the <b>Application Server Settings</b> panel, choose the application server and do the following steps:
                        <ul>
                            <li>For an installation on WebSphere Application Server Liberty:
                                <ul>
                                    <li>Enter the installation directory of Liberty and the name of the server where you want to install MobileFirst Server.</li>
                                    <li>You can create a default user to log in the console. This user is created in the Liberty Basic registry. For a production installation, you might want to clear the <b>Create a default user</b> option and to configure the user access after the installation. For more information, see <a href="">Configuring user authentication for MobileFirst Server administration</a>.</li>
                                    <li>Select the deployment type: <b>Standalone deployment</b> (default), <b>Server farm deployment</b>, or <b>Liberty collective deployment</b>.</li>
                                </ul>
                                
                                If the Liberty collective deployment option is selected, do the following steps:
                                <ul>
                                    <li>Specify the Liberty collective server:
                                        <ul>
                                            <li>Where the administration service, MobileFirst Operations Console and the live update service are installed. The server must be a Liberty collective controller.</li>
                                            <li>Where the runtime is installed. The server must be a Liberty collective member.</li>
                                            <li>Where the push service is installed. The server must be a Liberty collective member.</li>
                                        </ul>
                                    </li>
                                    <li>Enter the server ID of the member. This identifier must be different for each member in the collective.</li>
                                    <li>Enter the cluster name of the collective members.</li>
                                    <li>Enter the controller host name and HTTPS port number. The values must be the same as the one that is defined in the <code><variable></code> element inside the <b>server.xml</b> file of the Liberty collective controller.</li>
                                    <li>Enter the controller administrator user name and password.</li>
                                </ul>
                            </li>
                            <li>For an installation on WebSphere Application Server or WebSphere Application Server Network Deployment:
                                <ul>
                                    <li>Enter the installation directory of WebSphere Application Server.</li>
                                    <li>Select the WebSphere Application Server profile where you want to install MobileFirst Server. If you install on WebSphere Application Server Network Deployment, select the profile of the deployment manager. On the deployment manager profile, you can select a scope (<b>Server</b> or <b>Cluster</b>). If you select <b>Cluster</b>, you must specify the cluster:
                                        <ul>
                                            <li>Where the runtime is installed.</li>
                                            <li>Where the administration service, MobileFirst Operations Console and the live update service are installed.</li>
                                            <li>Where the push service is installed.</li>
                                        </ul>
                                    </li>
                                    <li>Enter an administrator login ID and password. The administrator user must have an administrator role.</li>
                                    <li>If you select the <b>Declare the WebSphere Administrator as an administrator user in IBM MobileFirst Platform Operations Console</b> option, then the user that is used to install MobileFirst Server is mapped to the administration security role of the console and can log in to the console with administrator privileges. This user is also mapped to the security role of the live update service. The user name and password are set as JNDI properties (<b>mfp.config.service.user</b> and <b>mfp.config.service.password</b>) of the administration service.</li>
                                    <li>If you do not select the <b>Declare the WebSphere Administrator as an administrator user in IBM MobileFirst Platform Operations Console</b> option, then before you can use MobileFirst Server, you must do the following tasks:
                                        <ul>
                                            <li>Enable the communication between the administration service and the live update service by:</li>
                                                <ul>
                                                    <li>Mapping a user to the security role <b>configadmin</b> of the live update service.</li>
                                                    <li>Adding the login ID and password of this user in the JNDI properties (<b>mfp.config.service.user</b> and <b>mfp.config.service.password</b>) of the administration service.</li>
                                                    <li>Map one or more users to the security roles of the administration service and MobileFirst Operations Console. See <a href="">Configuring user authentication for MobileFirst Server administration</a>.</li>
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
                                    <li>Create a default user to log in the console. This user is also created in the <b>tomcat-users.xml</b> configuration file. For a production installation, you might want to clear the Create a default user option and to configure the user access after the installation. For more information, see <a href="">Configuring user authentication for MobileFirst Server administration</a>.</li>
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
                    <li>In the <b>Analytics Settings</b> panel, select the <b>Enable the connection to the Analytics server</b> if MobileFirst Analytics is installed. Enter the following connection settings:
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

If Apache Tomcat is launched as a service, the setenv.bat or setenv.sh file that contains the statement to open the RMI might not be read. As a result, MobileFirst Server might not be able to work correctly. To set the required variables, see [Configuring JMX connection for Apache Tomcat](#apache-tomcat-prerequisites).

On WebSphere Application Server Network Deployment, the applications are installed but not started. You need to start them manually. You can do that from the WebSphere Application Server administration console.

Keep the configuration file in the Server Configuration Tool. You might reuse it to install the interim fixes. The menu to apply an interim fix is **Configurations > Replace the deployed WAR files**.

### Applying a fix pack by using the Server Configuration Tool
If MobileFirst Server is installed with the configuration tool and the configuration file is kept, you can apply a fix pack or an interim fix by reusing the configuration file.

1. Start the Server Configuration Tool.
    * On Linux, from application shortcuts **Applications → IBM MobileFirst Platform Server → Server Configuration Tool**.
    * On Windows, click **Start → Programs → IBM MobileFirst Platform Server → Server Configuration Tool**.
    * On macOS, open a shell console. Go to **mfp\_server\_install_dir/shortcuts** and type **./configuration-tool.sh**.
    * The **mfp\_server\_install\_dir** directory is where you installed MobileFirst Server.

2. Click **Configurations → Replace the deployed WAR files** and select an existing configuration to apply the fix pack or an interim fix.

## Installing with Ant tasks
Use Ant tasks to install the MobileFirst Server components to your application server.

You can find the sample configuration files for installing MobileFirst Server in the **mfp\_install\_dir/MobileFirstServer/configuration-samples directory**.

You can also create a configuration with the Server Configuration Tool and export the Ant files by using **File → Export Configuration as Ant Files...**. The sample Ant files have the same limitations as the Server Configuration Tool:

* All components (MobileFirst Operations Console, MobileFirst Server administration service, MobileFirst Server live update service, the MobileFirst Server artifacts, and MobileFirst runtime) are in the same application server. However, on WebSphere® Application Server Network Deployment when you install on a cluster, you can specify a different cluster for the administration and live update services, and for the runtime.
* If the MobileFirst Server push service is installed, it is also installed on the same server. However, on WebSphere Application Server Network Deployment when you install on a cluster, you can specify a different cluster for the push service.
* All the components use the same database system and the user. For DB2®, all the components also use the same schema.
* The Server Configuration Tool installs the components for a single server. For an installation on multiple servers, a farm must be configured after the tool is run. The server farm configuration is not supported on WebSphere Application Server Network Deployment.

You can configure the MobileFirst Server services to run in server farm with Ant tasks. To include your server in a farm, you need to specify some specific attributes that configure your application server accordingly. For more information about configuring a server farm with Ant tasks, see [Installing a server farm with Ant tasks](#installing-a-server-farm-with-ant-tasks).

For other topologies that are supported in [Topologies and network flows](../topologies), you can modify the sample Ant files.

The references to the Ant tasks are as follows:

* [Ant tasks for installation of MobileFirst Operations Console, MobileFirst Server artifacts, MobileFirst Server administration, and live update services]()
* [Ant tasks for installation of MobileFirst Server push service]()
* [Ant tasks for installation of MobileFirst runtime environments]()

For an overview of installing with the sample configuration file and tasks, see [Installing MobileFirst Server in command line mode](../command-line).

You can run an Ant file with the Ant distribution that is part of the product installation. For example, if you have WebSphere Application Server Network Deployment cluster and your database is IBM DB2, you can use the **mfp\_install\_dir/MobileFirstServer/configuration-samples/configure-wasnd-cluster-db2.xml** Ant file. After you edit the file and enter all the required properties, you can run the following commands from **mfp\_install\_dir/MobileFirstServer/configuration-samples** directory:

* **mfp\_install\_dir/shortcuts/ant -f configure-wasnd-cluster-db2.xml help** - This command displays the list of all the possible targets of the Ant file, to install, uninstall, or update some components.
* **mfp\_install\_dir/shortcuts/ant -f configure-wasnd-cluster-db2.xml install**  - This command installs MobileFirst Server on the WebSphere Application Server Network Deployment cluster, with DB2 as a data source by using the parameters that you entered in the properties of the Ant file.

<br/>
After the installation, make a copy of the Ant file so that you can reuse it to apply a fix pack.

### Applying a fix pack by using the Ant files
#### Updating with the sample Ant file
If you use the sample Ant files that are provided in the **mfp\_install\_dir/MobileFirstServer/configuration-samples** directory to install MobileFirst Server, you can reuse a copy of this Ant file to apply a fix pack. For password values, you can enter 12 stars (\*) instead of the actual value, to be prompted interactively when the Ant file is run.

1. Verify the value of the **mfp.server.install.dir** property in the Ant file. It must point to the directory that contains the product with the fix pack applied. This value is used to take the updated MobileFirst Server WAR files.
2. Run the command: `mfp_install_dir/shortcuts/ant -f your_ant_file update`

#### Updating with own Ant file
If you use your own Ant file, make sure that for each installation task (**installmobilefirstadmin**, **installmobilefirstruntime**, and **installmobilefirstpush**), you have a corresponding update task in your Ant file with the same parameters. The corresponding update tasks are **updatemobilefirstadmin**, **updatemobilefirstruntime**, and **updatemobilefirstpush**.

1. Verify the class path of the **<taskdef>** element for the **mfp-ant-deployer.jar** file. It must point to the **mfp-ant-deployer.jar** file in an MobileFirst Server installation that the fix pack is applied. By default, the updated MobileFirst Server WAR files are taken from the location of **mfp-ant-deployer.jar**.
2. Run the update tasks (**updatemobilefirstadmin**, **updatemobilefirstruntime**, and **updatemobilefirstpush**) of your Ant file.

### Sample Ant files modifications
You can modify the sample Ant files that are provided in the **mfp\_install\_dir/MobileFirstServer/configuration-samples** directory to adapt to your installation requirements.  
The following sections provide the details on how you can modify the sample Ant files to adapt the installation to your needs:

1. [Specify extra JNDI properties](#specify-extra-jndi-properties)
2. [Specify existing users](#specify-existing-users)
3. [Specify Liberty Java EE level](#specify-liberty-java-ee-level)
4. [Specify data source JDBC properties](#specify-data-source-jdbc-properties)
5. [Run the Ant files on a computer where MobileFirst Server is not installed](#run-the-ant-files-on-a-computer-where-mobilefirst-server-is-not-installed)
6. [Specify WebSphere Application Server Network Deployment targets](#specify-websphere-application-server-network-deployment-targets)
7. [Manual configuration of the RMI port on Apache Tomcat](#manual-configuration-of-the-rmi-port-on-apache-tomcat)

#### Specify extra JNDI properties
The **installmobilefirstadmin**, **installmobilefirstruntime**, and **installmobilefirstpush** Ant tasks declare the values for the JNDI properties that are required for the components to function. These JNDI properties are used to define the JMX communication, and also the links to other components (such the live update service, the push service, the analytics service, or the authorization server). However, you can also define values for other JNDI properties. Use the `<property>` element that exists for these three tasks. For a list of JNDI properties, see:

* [List of JNDI properties for MobileFirst Server administration service]()
* [List of JNDI properties for MobileFirst Server push service]()
* [List of JNDI properties for MobileFirst runtime]()

For example:

```xml
<installmobilefirstadmin ..>
    <property name="mfp.admin.actions.prepareTimeout" value="3000000"/>
</installmobilefirstadmin> 
```

#### Specify existing users
By default, the **installmobilefirstadmin** Ant task creates users:

* On WebSphere® Application Server Liberty to define a Liberty administrator for the JMX communication.
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
    
Also, the user that is created by the sample Ant files is mapped to the security roles of the administration service and the console. With this setting, you can use this user to log on to MobileFirst Server after the installation. To change that behavior, remove the `<user>` element from the sample Ant files. Alternatively, you can remove the **password** attribute from the `<user>` element, and the user is not created in the local registry of the application server.

#### Specify Liberty Java EE level
Some distributions of WebSphere Application Server Liberty support features from Java EE 6 or from Java EE 7. By default, the Ant tasks automatically detect the features to install. For example, **jdbc-4.0** Liberty feature is installed for Java EE 6 and **jdbc-4.1** feature is installed in case of Java EE 7. If the Liberty installation supports both features from Java EE 6 and Java EE 7, you might want to force a certain level of features. An example might be that you plan to run both MobileFirst Server V8.0.0 and V7.1.0 on the same Liberty server. MobileFirst ServerV7.1.0 or earlier supports only Java EE 6 features.

To force a certain level of Java EE 6 features, use the jeeversion attribute of the `<websphereapplicationserver>` element. For example:

```xml
<installmobilefirstadmin execute="${mfp.process.admin}" contextroot="${mfp.admin.contextroot}">
    [...]
    <applicationserver>
      <websphereapplicationserver installdir="${appserver.was.installdir}"
        profile="Liberty" jeeversion="6">
```

#### Specify data source JDBC properties
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

#### Run the Ant files on a computer where MobileFirst Server is not installed
To run the Ant tasks on a computer where MobileFirst Server is not installed, you need the following items:

* An Ant installation
* A copy of the **mfp-ant-deployer.jar** file to the remote computer. This library contains the definition of the Ant tasks.
* To specify the resources to be installed. By default, the WAR files are taken near the **mfp-ant-deployer.jar**, but you can specify the location of these WAR files. For example:

```xml
<installmobilefirstadmin execute="true" contextroot="/mfpadmin" serviceWAR="/usr/mfp/mfp-admin-service.war">
  <console install="true" warFile="/usr/mfp/mfp-admin-ui.war"/>
```

For more information, see the Ant tasks to install each MobileFirst Server component at [Installation reference]().

#### Specify WebSphere Application Server Network Deployment targets
To install on WebSphere Application Server Network Deployment, the specified WebSphere Application Server profile must be the deployment manager. You can deploy on the following configurations:

* A cluster
* A single server
* A cell (all the servers of a cell)
* A node (all the servers of a node)

The sample files such as **configure-wasnd-cluster-<dbms>.xml**, **configure-wasnd-server-<dbms>.xml**, and **configure-wasnd-node-<dbms>.xml** contain the declaration to deploy on each type of target. For more information, see the Ant tasks to install each MobileFirst Server component in the [Installation reference]().

> Note: As of V8.0.0, the sample configuration file for the WebSphere Application Server Network Deployment cell is not provided.


#### Manual configuration of the RMI port on Apache Tomcat
By default, the Ant tasks modify the **setenv.bat** file or the **setenv.sh** file to open the RMI port. If you prefer to open the RMI port manually, add the **tomcatSetEnvConfig** attribute with the value as false to the `<jmx>` element of the **installmobilefirstadmin**, **updatemobilefirstadmin**, and **uninstallmobilefirstadmin** tasks.

## Installing the MobileFirst Server components manually
You can also install the MobileFirst Server components to your application server manually.  
The following topics provide you the complete information to guide you through the installing process of the components on the supported applications in production.


