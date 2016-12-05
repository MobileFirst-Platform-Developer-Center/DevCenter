---
layout: tutorial
title: Installing and configuring for token licensing
breadcrumb_title: Token licensing
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
If you plan to use token licensing for {{ site.data.keys.mf_server }}, you must install the Rational  Common Licensing library and configure your application server to connect {{ site.data.keys.mf_server }} to the Rational License Key Server.

The following topics describe the installation overview, the manual installation of Rational Common Licensing library, the configuration of the application server, and the platform limitations for token licensing.

#### Jump to

* [Planning for the use of token licensing](#planning-for-the-use-of-token-licensing)
* [Installation overview for token licensing](#installation-overview-for-token-licensing)
* [Connecting {{ site.data.keys.mf_server }} installed on Apache Tomcat to the Rational License Key Server](#connecting-mobilefirst-server-installed-on-apache-tomcat-to-the-rational-license-key-server)
* [Connecting {{ site.data.keys.mf_server }} installed on WebSphere Application Server Liberty profile to the Rational License Key Server](#connecting-mobilefirst-server-installed-on-websphere-application-server-liberty-profile-to-the-rational-license-key-server)
* [Connecting {{ site.data.keys.mf_server }} installed on WebSphere Application Server to the Rational License Key Server](#connecting-mobilefirst-server-installed-on-websphere-application-server-to-the-rational-license-key-server)
* [Limitations of supported platforms for token licensing](#limitations-of-supported-platforms-for-token-licensing)
* [Troubleshooting token licensing problems](#troubleshooting-token-licensing-problems)

## Planning for the use of token licensing
If the token licensing is purchased for {{ site.data.keys.mf_server }}, you have extra steps to consider in the installation planning.

### Technical restrictions
Here are the technical restrictions for the use of token licensing:

#### Supported Platforms:
The list of platforms that support token licensing is listed at [Limitations of supported platforms for token licensing](#limitations-of-supported-platforms-for-token-licensing). The {{ site.data.keys.mf_server }} running on a platform that is not listed might not be possible to install and configure for token licensing. The native libraries for the Rational  Common Licensing client might not available for the platform or not supported.

#### Supported Topologies:
The topologies that are supported by token licensing is listed at [Constraints on {{ site.data.keys.mf_server }} administration service, {{ site.data.keys.mf_server }} live update service and {{ site.data.keys.product_adj }} runtime](../topologies/#constraints-on-mobilefirst-server-administration-service-mobilefirst-server-live-update-service-and-mobilefirst-runtime).

### Network requirement
{{ site.data.keys.mf_server }} must be able to communicate with the Rational License Key Server.

This communication requires the access to the following two ports of the license server:

* License manager daemon (**lmgrd**) port - the default port number is 27000.
* Vendor daemon (**ibmratl**) port
 
To configure the ports so that they use static values, see How to serve a license key to client machines through a firewall.

### Installation Process
You need to activate token licensing when you run the IBM  Installation Manager at installation time. For more information about the instructions for enabling token licensing, see [Installation overview for token licensing](#installation-overview-for-token-licensing).

After {{ site.data.keys.mf_server }} is installed, you must manually configure the server for token licensing. For more information, see the following topics in this section.

The {{ site.data.keys.mf_server }} is not functional before you complete this manual configuration. The Rational Common Licensing client library is to be installed in your application server, and you define the location of the Rational License Key Server.

### Operations
After you install and configure {{ site.data.keys.mf_server }} for token licensing, the server validates licenses during various scenarios. For more information about the retrieval of tokens during operations, see [Token license validation](../../../administering-apps/license-tracking/#token-license-validation).

If you need to test a non-production application on a production server with token licensing enabled, you can declare the application as non-production. For more information about declaring the application type, see [Setting the application license information](../../../administering-apps/license-tracking/#setting-the-application-license-information).

## Installation overview for token licensing
If you intend to use token licensing with {{ site.data.keys.product }}, make sure that you go through the following preliminary steps in this order.

> **Important:** Your choice about token licensing (activating it or not) as part of an installation that supports token licensing cannot be modified. If later you need to change the token licensing option, you must uninstall {{ site.data.keys.product }} and reinstall it.

1. Activate token licensing when you run IBM  Installation Manager to install {{ site.data.keys.product }}.

   #### Graphic mode installation
   If you install the product in graphic mode, select **Activate token licensing with the Rational License Key Server** option in the **General settings** panel during the installation.
    
   ![Activting token licensing in the IBM installation manager](licensing_with_tokens_activate.jpg)
    
   #### Command line mode installation
   If you install in silent mode, set the value as **true** to the **user.licensed.by.tokens** parameter in the response file.  
   For example, you can use:
    
   ```bash
   imcl install com.ibm.mobilefirst.foundation.server -repositories mfp_repository_dir/MobileFirst_Platform_Server/disk1 -properties user.appserver.selection2=none,user.database.selection2=none,user.database.preinstalled=false,user.use.ios.edition=false,user.licensed.by.tokens=true -acceptLicense
   ```
    
2. Deploy the {{ site.data.keys.mf_server }} to an application server after the product installation is complete. For more information, see [Installing {{ site.data.keys.mf_server }} to an application server](../appserver).

3. Configure {{ site.data.keys.mf_server }} for token licensing. The steps depend on your application server.

* For WebSphere Application Server Liberty profile, see [Connecting {{ site.data.keys.mf_server }} installed on WebSphere Application Server Liberty profile to the Rational License Key Server](#connecting-mobilefirst-server-installed-on-websphere-application-server-liberty-profile-to-the-rational-license-key-server)
* For Apache Tomcat, see [Connecting {{ site.data.keys.mf_server }} installed on Apache Tomcat to the Rational License Key Server](#connecting-mobilefirst-server-installed-on-apache-tomcat-to-the-rational-license-key-server)
* For WebSphere Application Server full profile, see [Connecting {{ site.data.keys.mf_server }} installed on WebSphere Application Server to the Rational License Key Server](#connecting-mobilefirst-server-installed-on-websphere-application-server-to-the-rational-license-key-server).

## Connecting {{ site.data.keys.mf_server }} installed on Apache Tomcat to the Rational License Key Server
You must install the Rational  Common Licensing native and Java libraries on the Apache Tomcat application server before you connect {{ site.data.keys.mf_server }} to the Rational License Key Server.

* Rational License Key Server 8.1.4.8 or later must be installed and configured. The network must allow communication to and from {{ site.data.keys.mf_server }} by opening the two-way communication ports (**lmrgd** and **ibmratl**). For more information, see [Rational License Key Server Portal](https://www.ibm.com/support/entry/portal/product/rational/rational_license_key_server?productContext=-283469295) and [How to serve a license key to client machines through a firewall](http://www.ibm.com/support/docview.wss?uid=swg21257370).
* Make sure that the license keys for {{ site.data.keys.product }} are generated . For more information about generating and managing your license keys with IBM  Rational License Key Center, see [IBM  Support - Licensing](http://www.ibm.com/software/rational/support/licensing/) and [Obtaining license keys with IBM Rational License Key Center](https://www.ibm.com/support/knowledgecenter/SSSTWP_8.1.4/com.ibm.rational.license.doc/topics/t_access_license_key_center.html).
* {{ site.data.keys.mf_server }} must be installed and configured with the option Activate token licensing with the Rational License Key Server on your Apache Tomcat as indicated in [Installation overview for token licensing](#installation-overview-for-token-licensing).

### Installing Rational Common Licensing libraries

1. Choose the Rational Common Licensing native library. Depending on your operating system and the bit version of the Java Runtime Environment (JRE) on which your Apache Tomcat is running, you must choose the correct native library in **product\_install\_dir/MobileFirstServer/tokenLibs/bin/your\_corresponding\_platform/the\_native\_library\_file**. For example, for Linux x86 with a 64-bit JRE, the library can be found in **product\_install\_dir/MobileFirstServer/tokensLibs/bin/Linux\_x86\_64/librcl\_ibmratl.so**.
2. Copy the native library to the computer that runs {{ site.data.keys.mf_server }} administration service. The directory might be **${CATALINA_HOME}/bin**. 
    > **Note:** **${CATALINA_HOME}** is the installation directory of your Apache Tomcat.
3. Copy **rcl_ibmratl.jar** file to **${CATALINA_HOME}/lib**. The **rcl_ibmratl.jar** file is a Rational Common Licensing Java library that can be found in **product\_install\_dir/MobileFirstServer/tokenLibs** directory. The library uses the native library that is copied in Step 2, and can be loaded only once by Apache Tomcat. This file must be placed in the **${CATALINA_HOME}/lib** directory or any directory in the path of Apache Tomcat common class loader.
    > **Important:** The Java virtual machine (JVM) of Apache Tomcat needs read and execute privileges on the copied native and Java libraries. Both copied files must also be readable and executable at least for the application server process in your operating system.
4. Configure the access to the Rational Common Licensing library by the JVM of your application server. For any operating systems, configure the **${CATALINA_HOME}/bin/setenv.bat** file (or **setenv.sh** file on UNIX) by adding the following line:

   **Windows:**  
    
   ```bash
   set CATALINA_OPTS=%CATALINA_OPTS% -Djava.library.path=absolute_path_to_the_previous_bin_directory
   ```
    
   **UNIX:**

   ```bash
   CATALINA_OPTS="$CATALINA_OPTS -Djava.library.path=absolute_path_to_the_previous_bin_directory"
   ```
    
   > **Note:** If you move the configuration folder of the server on which the administration service is running, you must update the **java.library.path** with the new absolute path.

5. Configure {{ site.data.keys.mf_server }} to access Rational License Key Server. In **${CATALINA_HOME}/conf/server.xml** file, look for the `Context` element of the administration service application, and add in these JNDI configuration lines.

   ```xml
   <Environment name="mfp.admin.license.key.server.host" value="rlks_hostname" type="java.lang.String" override="false"/>
   <Environment name="mfp.admin.license.key.server.port" value="rlks_port" type="java.lang.String" override="false"/>
   ```
   * **rlks_hostname** is the host name of the Rational License Key Server.
   * **rlks_port** is the port of the Rational License Key Server. By default, the value is **27000**.

For more information about the JNDI properties, see [JNDI properties for Administration Services: licensing](../server-configuration/#jndi-properties-for-administration-service-licensing).

### Installing on Apache Tomcat server farm
For configuring the connection of {{ site.data.keys.mf_server }} on Apache Tomcat server farm, you must follow all the steps that are described in [Installing Rational Common Licensing libraries](#installing-rational-common-licensing-libraries) for each node of your server farm where the {{ site.data.keys.mf_server }} administration service is running. For more information about server farm, see [Server farm topology](../topologies/#server-farm-topology) and [Installing a server farm](../appserver/#installing-a-server-farm).

## Connecting {{ site.data.keys.mf_server }} installed on WebSphere Application Server Liberty profile to the Rational License Key Server
You must install the Rational  Common Licensing native and Java libraries on the Liberty profile before you connect {{ site.data.keys.mf_server }} to the Rational License Key Server.

* Rational License Key Server 8.1.4.8 or later must be installed and configured. The network must allow communication to and from {{ site.data.keys.mf_server }} by opening the two-way communication ports (**lmrgd** and **ibmratl**). For more information, see [Rational License Key Server Portal](https://www.ibm.com/support/entry/portal/product/rational/rational_license_key_server?productContext=-283469295) and [How to serve a license key to client machines through a firewall](http://www.ibm.com/support/docview.wss?uid=swg21257370).
* Make sure that the license keys for {{ site.data.keys.product }} are generated . For more information about generating and managing your license keys with IBM  Rational License Key Center, see [IBM  Support - Licensing](http://www.ibm.com/software/rational/support/licensing/) and [Obtaining license keys with IBM Rational License Key Center](https://www.ibm.com/support/knowledgecenter/SSSTWP_8.1.4/com.ibm.rational.license.doc/topics/t_access_license_key_center.html).
* {{ site.data.keys.mf_server }} must be installed and configured with the option Activate token licensing with the Rational License Key Server on your Apache Tomcat as indicated in [Installation overview for token licensing](#installation-overview-for-token-licensing).

<h3 id="common-licensing-libraries-liberty">Installing Rational Common Licensing libraries</h3>

1. Define a shared library for the Rational Common Licensing client. This library uses native code and can be loaded only once by the application server. Thus, the applications that use it must reference it as a common library.
   * Choose the Rational Common Licensing native library. Depending on your operating system and the bit version of the Java Runtime Environment (JRE) on which your Liberty profile is running, you must choose the correct native library in **product_install_dir/MobileFirstServer/tokenLibs/bin/your_corresponding_platform/the_native_library_file**. For example, for Linux x86 with a 64-bits JRE, the library can be found in **product_install_dir/MobileFirstServer/tokensLibs/bin/Linux_x86_64/librcl_ibmratl.so**.
   * Copy the native library to the computer that runs {{ site.data.keys.mf_server }} administration service. The directory might be **${shared.resource.dir}/rcllib**. The **${shared.resource.dir}** directory is usually in **usr/shared/resources**, where usr is the directory that also contains the usr/servers directory. For more information about standard location of **${shared.resource.dir}**, see [WebSphere  Application Server Liberty Core - Directory locations and properties](http://www.ibm.com/support/knowledgecenter/SSD28V_8.5.5/com.ibm.websphere.wlp.core.doc/ae/rwlp_dirs.html?lang=en&view=kc). If the **rcllib** folder does not exist, create this folder and then copy the native library file over.
    
   > **Note:** Ensure that the Java virtual machine (JVM) of the application server has both read and execute privileges on the native library. On Windows, the following exception appears in the application server log if the JVM of the application server does not have the executable rights on the copied native library.
    
   ```bash
   com.ibm.rcl.ibmratl.LicenseConfigurationException: java.lang.UnsatisfiedLinkError: rcl_ibmratl (Access is denied).
   ```
   * Copy **rcl_ibmratl.jar** file to **${shared.resource.dir}/rcllib**. The **rcl_ibmratl.jar** file is a Rational Common Licensing Java library that can be found in **product_install_dir/MobileFirstServer/tokenLibs** directory.

   > **Note:** The Java virtual machine (JVM) of Liberty profile must have the possibility to read the copied Java library. This file must also have readable privilege (at least for the application server process) in your operating system.    
   * Declare a shared library that uses the **rcl_ibmratl.jar** file in the **${server.config.dir}/server.xml** file.

   ```xml
   <!-- Declare a shared Library for the RCL client. -->
   <!- This library can be loaded only once because it uses native code. -->
   <library id="RCLLibrary">
       <fileset dir="${shared.resource.dir}/rcllib" includes="rcl_ibmratl.jar"/>
   </library>
   ```    
   * Declare the shared library as a common library for the {{ site.data.keys.mf_server }} administration service application by adding an attribute (**commonLibraryRef**) to the class loader of the application. As the library can be loaded only once, it must be used as a common library, and not as a private library.

   ```xml
   <application id="mfpadmin" name="mfpadmin" location="mfp-admin-service.war" type="war">
      [...]
      <!- Declare the shared library as an attribute commonLibraryRef to 
          the class loader of the application. -->
      <classloader delegation="parentLast" commonLibraryRef="RCLLibrary">
      </classloader>
   </application>
   ```
   * If you are using Oracle as database, then the **server.xml** will already have the following class loader:

   ```xml
   <classloader delegation="parentLast" commonLibraryRef="MobileFirst/JDBC/oracle">
    </classloader>
   ```
    
   You also need to append Rational Common Licensing library as common library to the Oracle library as follows:
    
   ```xml
   <classloader delegation="parentLast"
         commonLibraryRef="MobileFirst/JDBC/oracle,RCLLibrary">
   </classloader>
   ```
   * Configure the access to the Rational Common Licensing library by the JVM of your application server. For any operating systems, configure the **${wlp.user.dir}/servers/server_name/jvm.options** file by adding the following line:

   ```xml
   -Djava.library.path=Absolute_path_to_the_previously_created_rcllib_folder
   ```
    
   > **Note:** If you move the configuration folder of the server on which the administration service is running, you must update the **java.library.path** with the new absolute path.

   The **${wlp.user.dir}** directory is usually in **liberty_install_dir/usr** and contains the servers directory. However, it's location can be customized. For more information, see [Customizing the Liberty environment](http://www.ibm.com/support/knowledgecenter/SSD28V_8.5.5/com.ibm.websphere.wlp.core.doc/ae/twlp_admin_customvars.html?lang=en&view=kc)
    
2. Configure {{ site.data.keys.mf_server }} to access Rational License Key Server.

   In the **${wlp.user.dir}/servers/server_name/server.xml** file, add these JNDI configuration lines.
    
   ```xml
   <jndiEntry jndiName="mfp.admin.license.key.server.host" value="rlks_hostname"/> 
   <jndiEntry jndiName="mfp.admin.license.key.server.port" value="rlks_port"/> 
   ```
   * **rlks_hostname** is the host name of the Rational License Key Server.
   * **rlks_port** is the port of the Rational License Key Server. By default, the value is 27000.

   For more information about the JNDI properties, see [JNDI properties for Administration Services: licensing](../server-configuration/#jndi-properties-for-administration-service-licensing).

### Installing on Liberty profile server farm
For configuring the connection of {{ site.data.keys.mf_server }} on Liberty profile server farm, you must follow all the steps that are described in [Installing Rational Common Licensing libraries](#installing-rational-common-licensing-libraries) for each node of your server farm where the {{ site.data.keys.mf_server }} administration service is running. For more information about server farm, see [Server farm topology](../topologies/#server-farm-topology) and [Installing a server farm](../appserver/#installing-a-server-farm).

## Connecting {{ site.data.keys.mf_server }} installed on WebSphere Application Server to the Rational License Key Server
You must configure a shared library for the Rational  Common Licensing libraries on WebSphere  Application Server before you connect {{ site.data.keys.mf_server }} to the Rational License Key Server.

* Rational License Key Server 8.1.4.8 or later must be installed and configured. The network must allow communication to and from {{ site.data.keys.mf_server }} by opening the two-way communication ports (**lmrgd** and **ibmratl**). For more information, see [Rational License Key Server Portal](https://www.ibm.com/support/entry/portal/product/rational/rational_license_key_server?productContext=-283469295) and [How to serve a license key to client machines through a firewall](http://www.ibm.com/support/docview.wss?uid=swg21257370).
* Make sure that the license keys for {{ site.data.keys.product }} are generated . For more information about generating and managing your license keys with IBM  Rational License Key Center, see [IBM  Support - Licensing](http://www.ibm.com/software/rational/support/licensing/) and [Obtaining license keys with IBM Rational License Key Center](https://www.ibm.com/support/knowledgecenter/SSSTWP_8.1.4/com.ibm.rational.license.doc/topics/t_access_license_key_center.html).
* {{ site.data.keys.mf_server }} must be installed and configured with the option Activate token licensing with the Rational License Key Server on your Apache Tomcat as indicated in [Installation overview for token licensing](#installation-overview-for-token-licensing).

### Installing Rational Common Licensing library on a stand-alone server

1. Define a shared library for the Rational Common Licensing library. This library uses native code and can be loaded only once by a class loader during the application server lifecycle. For this reason, the library is declared as a shared library and associated to all the application servers that run the {{ site.data.keys.mf_server }} administration service. For more information about the reasons to declare this library as a shared library, see [Configuring native libraries in shared libraries](http://www.ibm.com/support/knowledgecenter/SSEQTP_8.5.5/com.ibm.websphere.base.doc/ae/tcws_sharedlib_nativelib.html?view=kc).
    * Choose the Rational Common Licensing native library. Depending on your operating system and the bit version of the Java Runtime Environment (JRE) on which your WebSphere Application Server is running, you must choose the correct native library in **product_install_dir/MobileFirstServer/tokenLibs/bin/your_corresponding_platform/the_native_library_file**.
    
        For example, for Linux x86 with a 64-bits JRE, the library can be found in **product_install_dir/MobileFirstServer/tokensLibs/bin/Linux_x86_64/librcl_ibmratl.so**.
    
        To determine the bit version of the Java Runtime Environment for a stand-alone WebSphere Application Server or WebSphere Application Server Network Deployment installation, run **versionInfo.bat** on Windows or **versionInfo.sh** on UNIX from the **bin** directory. The **versionInfo.sh** file is in **/opt/IBM/WebSphere/AppServer/bin**. Look at the Architecture value in the **Installed Product** section. The Java Runtime Environment is 64-bit if the Architecture value mentions it explicitly or if it is suffixed with 64 or _64.
    * Place the native library that corresponds to your platform in a folder of your operating system. For example, **/opt/IBM/RCL_Native_Library/**.
    * Copy the **rcl_ibmratl.jar** file to **/opt/IBM/RCL_Native_Library/**. The **rcl_ibmratl.jar** file is a Rational Common Licensing Java library that can be found in **product_install_dir/MobileFirstServer/tokenLibs directory**.
    
        > **Important:** The Java virtual machine (JVM) of the application server needs read and execute privileges on the copied native and Java libraries. Both copied files must also be readable and executable at least for the application server process in your operating system.    
    * Declare a shared library in WebSphere Application Server administrative console.
        * Log in to WebSphere Application Server administrative console.
        * Expand **Environment → Shared Libraries**.
        * Select a scope that is visible by all servers that run the {{ site.data.keys.mf_server }} administration service. For example, a cluster.
        * Click **New**.
        * Enter a name for the library in the Name field. For example, "RCL Shared Library".
        * In the Classpath field, enter the path to the **rcl_ibmratl.jar** file. For example, **/opt/IBM/RCL_Native_Library/rcl_ibmratl.jar**.
        * Click **OK** and save the changes. This setting takes effect when the server is restarted.
    
        > **Note:** The native library path for this library is set in step 3 in the **ld.library.path** property of the server's Java virtual machine.
    * Associate the shared library with all servers that run the {{ site.data.keys.mf_server }} administration service.
    
        Associating the shared library to a server allows the shared library to be used by several applications. If you need the Rational Common Licensing client only for the {{ site.data.keys.mf_server }} administration service, you can create a shared library with an isolated class loader and associate it with the administration service application.

        The following instruction is to associate the library with a server. For WebSphere Application Server Network Deployment, you must complete this instruction for all the servers that run the {{ site.data.keys.mf_server }} administration service.    
        * Set the class loader policy and mode.    
            1. In WebSphere Application Server administrative console, click **Servers → Server Types → WebSphere application servers → server_name** to access the application server setting page.
            2. Set the values for the application class-loader policy and class loading mode of the server:
                * **Classloader policy**: Multiple
                * **Class loading mode**: Classes loaded with parent class loader first
            3. In the **Server Infrastructure** section, click **Java and Process Management → Class loader**.
            4. Click **New** and ensure that class loader order is set to **Classes loaded with parent class loader first**.
            5. Click **Apply** to create a new class loader ID.                
        * Create a library reference for each shared library file that your application needs.
            1. Click the name of the class loader that is created in the previous step.
            2. In the **Additional properties** section, click **Shared library references**.
            3. Click **Add**.
            4. At the Library reference settings page, select the appropriate library reference. The name identifies the shared library file that your application uses. For example, RCL Shared Library.
            5. Click **Apply** and then save the changes.
2. Configure the environment entries for the {{ site.data.keys.mf_server }} administration service web application.
    * In WebSphere Application Server administrative console, click **Applications → Application Types → WebSphere enterprise applications** and select the administration service application: **MobileFirst_Administration_Service**.
    * In the **Web Module Properties** section, click **Environment entries for web modules**.
    * Enter the values for **mfp.admin.license.key.server.host** and **mfp.admin.license.key.server.port**.
        * **mfp.admin.license.key.server.host** is the host name of the Rational License Key Server.
        * **mfp.admin.license.key.server.port** is the port of the Rational License Key Server. By default, the value is 27000.
    * Click **OK** and save the changes.
3. Configure the access to the Rational Common Licensing library by the application server JVM.
    * In WebSphere Application Server administrative console, click **Servers → Server Types → WebSphere Application Servers** and select your server.
    * In **Server Infrastructure** section, click **Java and Process Management → Process Definition → Java Virtual Machine → Custom Properties → New** to add a custom property.
    * In the **Name** field, type the name of the custom property as **java.library.path**.
    * In the **Value** field, enter the path of the folder where you place the native library file in Step 1b. For example, **/opt/IBM/RCL_Native_Library/**.
    * Click **OK** and save the changes.
4. Restart your application server.

### Installing Rational Common Licensing library on WebSphere Application Server Network Deployment
For installing the native library on a WebSphere Application Server Network Deployment, you must follow all the steps that are described in [Installing Rational Common Licensing library on a stand-alone server](#installing-rational-common-licensing-library-on-a-stand-alone-server) above. The servers or clusters that you configure must be restarted in order for the changes to take effect.

Each node of your WebSphere Application Server Network Deployment must have a copy of the Rational Common Licensing native library.

Each server where the {{ site.data.keys.mf_server }} administration service runs must be configured to have access to the native library copied on your local computer. These servers must also be configured to connect to Rational License Key Server.

> **Important:** If you use a cluster with WebSphere Application Server Network Deployment, your cluster can change. You must configure each newly added server in your cluster, where the administration services are running.

## Limitations of supported platforms for token licensing
The list of operating system, its version, and the hardware architecture that supports {{ site.data.keys.mf_server }} with token licensing enabled.

For token licensing, the {{ site.data.keys.mf_server }} needs to connect to the Rational  License Key Server by using the Rational Common Licensing library.

This library is composed of a Java library and also native libraries. These native libraries depend on the platform where {{ site.data.keys.mf_server }} is running. Thus, the token licensing by {{ site.data.keys.mf_server }} is supported only on platforms where the Rational Common Licensing library can be run.

The following table describes the platforms that support {{ site.data.keys.mf_server }} with the token licensing.

| Operating System             | Operating System version |	Hardware architecture |
|------------------------------|--------------------------|-----------------------|
| AIX                          | 7.1                      |	POWER8  (64-bit only) |
| SUSE Linux Enterprise Server | 11	                      | x86-64 only           |
| Windows Server               | 2012	                  | x86-64 only           |

Token licensing does not support 32-bit Java Runtime Environment (JRE). Make sure that the application server uses a 64-bit JRE.

## Troubleshooting token licensing problems
Find information to help resolve issues that you might encounter with token licensing if you activated this feature when you installed {{ site.data.keys.mf_server }}.

When you start the {{ site.data.keys.mf_server }} administration service after you complete Installing and configuring for token licensing, some errors or exceptions can be emitted in the application server log or on {{ site.data.keys.mf_console }}. These exceptions might be due to incorrect installation of the Rational Common Licensing library and configuration of the application server.

**Apache Tomcat**  
Check **catalina.log** or catalina.out file, depending on your platform.

**WebSphere® Application Server Liberty profile**  
Check **messages.log** file.

**WebSphere Application Server full profile**  
Check **SystemOut.log** file.

> **Important:** If token licensing is installed on WebSphere Application Server Network Deployment or a cluster, you must check the log of each server.

Here is a list of exceptions that might occur after the installation and configuration for token licensing:

* [Rational Common Licensing native library is not found](#rational-common-licensing-native-library-is-not-found)
* [Rational Common Licensing shared library is not found](#rational-common-licensing-shared-library-is-not-found)
* [The Rational License Key Server connection is not configured](#the-rational-license-key-server-connection-is-not-configured)
* [The Rational License Key Server is not accessible](#the-rational-license-key-server-is-not-accessible)
* [Failed to initialize Rational Common Licensing API](#failed-to-initialize-rational-common-licensing-api)
* [Insufficient token licenses](#insufficient-token-licenses)
* [Invalid rcl_ibmratl.jar file](#invalid-rcl_ibmratljar-file)

### Rational Common Licensing native library is not found

> FWLSE3125E: The Rational Common Licensing native library is not found. Make sure the JVM property (java.library.path) is defined with the right path and the native library can be executed. Restart {{ site.data.keys.mf_server }} after taking corrective action.

#### For WebSphere Application Server full profile
Possible causes to this error might be:

* No common property with name **java.library.path** is defined at server level.
* The path that is given as the value for the **java.library.path** property does not contain the Rational Common Licensing native library.
* The native library does not have appropriate permissions. The library must have the read and execute privileges on UNIX and Windows for the user who accesses it with the Java™ Runtime
* Environment of the application server.

#### For WebSphere Application Server Liberty profile and Apache Tomcat
Possible causes to this error might be:

* The path to the Rational Common Licensing native library given as the value of java.library.path property is either not set or incorrect.
    * For Liberty profile, check **${wlp.user.dir}/servers/server_name/jvm.options** file.
    * For Apache Tomcat, check **${CATALINA_HOME}/bin/setenv.bat** file or setenv.sh file, depending on your platform.
* The native library is not found in the path that is defined to the **java.library.path** property. Check that the native library exists in the defined path with the expected name.
* The native library does not have appropriate permissions. The error might be preceded by this exception: `com.ibm.rcl.ibmratl.LicenseConfigurationException: java.lang.UnsatisfiedLinkError: {0}\rcl_ibmratl.dll: Access is denied`.

The Java Runtime Environment of the application server needs read and execute privileges on this native library. The library file must also be readable and executable at least for the application server process in your operating system.

* The shared library that uses the **rcl_ibmratl.jar** file is not defined in the **${server.config.dir}/server.xml** file for Liberty profile. The **rcl_ibmratl.jar** might also not in the correct directory or the directory does not have the appropriate permissions.
* The shared library that used the **rcl_ibmratl.jar** file is not declared as a common library for the {{ site.data.keys.mf_server }} administration service application in the **${server.config.dir}/server.xml** file for the Liberty profile.
* There is a mix of 32-bit and 64-bit objects between the Java Runtime Environment of the application server and the native library. For example, a 32-bit Java Runtime Environment is used with a 64-bit native library. This mix is not supported.

### Rational Common Licensing shared library is not found

> FWLSE3126E: The Rational Common Licensing shared library is not found. Make sure the shared library is configured. Restart {{ site.data.keys.mf_server }} after taking corrective action.

Possible causes to this error might be:

* The **rcl_ibmratl.jar** file is not in the expected directory.
    * For Apache Tomcat, check that this file is in **${CATALINA_HOME}/lib** directory.
    * For WebSphere Application Server Liberty profile, check that this file is in the directory as defined in the server.xml file for the shared library of the Rational Common Licensing client. For example, **${shared.resource.dir}/rcllib**. In the **server.xml** file, ensure that this shared library is correctly referenced as a common library for {{ site.data.keys.mf_server }} administration service application.
    * For WebSphere Application Server, make sure that this file is in the directory that is specified in the class path of the WebSphere Application Server shared library. Check that the class path of that shared library contains this entry: **absolute\_path/rcl\_ibmratl.jar** whereas absolute_path is the absolute path of the **rcl_ibmratl.jar** file.

The **java.library.path** property is not set for the application server. Define a property with name **java.library.path** and set the path to the Rational Common Licensing native library as the value. For example, **/opt/IBM/RCL\_Native\_Library/**.
* The native library does not have the expected permissions. On Windows, the Java Runtime Environment of the application server must have the read and executable rights on the native library.
* There is a mix of 32-bit and 64-bit objects between the Java Runtime Environment of the application server and the native library. For example, a 32-bit Java Runtime Environment is used with a 64-bit native library. This mix is not supported.

### The Rational License Key Server connection is not configured

> FWLSE3127E: The Rational License Key Server connection is not configured. Make sure the admin JNDI properties "mfp.admin.license.key.server.host" and "mfp.admin.license.key.server.port" are set. Restart {{ site.data.keys.mf_server }} after taking corrective action.

Possible causes to this error might be:

* The Rational Common Licensing native library and the shared library that uses the **rcl_ibmratl.jar** file are correctly configured but the value of JNDI properties (**mfp.admin.license.key.server.host** and **mfp.admin.license.key.server.port**) is not set in the {{ site.data.keys.mf_server }} administration service application.
* The Rational License Key Server is down.
* The host computer on which Rational License Key Server is installed cannot be reached. Check the IP address or host name with the specified port.

### The Rational License Key Server is not accessible

> FWLSE3128E: The Rational License Key Server "{port}@{IP address or hostname}" is not accessible. Make sure that license server is running and accessible to {{ site.data.keys.mf_server }}. If this error occurs at runtime startup, restart {{ site.data.keys.mf_server }} after taking corrective action.

Possible causes to this error might be:

* The Rational Common Licensing shared library and the native library are correctly defined but there is no valid configuration to connect to the Rational License Key Server. Check the IP address, the host name, and the port of the license server. Make sure that the license server is started and accessible from the computer where the application server is installed.
* The native library is not found in the path that is defined to the **java.library.path** property.
* The native library does not have appropriate permissions.
* The native library is not in the defined directory.
* The Rational License Key Server is behind a firewall. The error might be preceded by this exception: [ERROR] Failed to get license for application 'WorklightStarter' because Rational Licence Key Server ({port}@{IP address or hostname}) is either down or not accessible com.ibm.rcl.ibmratl.LicenseServerUnreachableException. All license files searched for features: {port}@{IP address or hostname}

Ensure that the license manager daemon (lmgrd) port and the vendor daemon (ibmratl) port are open in your firewall. For more information, see How to serve a license key to client machines through a firewall.

### Failed to initialize Rational Common Licensing API

> Failed to initialize Rational Common Licensing (RCL) API because its native library could not be found or loaded com.ibm.rcl.ibmratl.LicenseConfigurationException: java.lang.UnsatisfiedLinkError: rcl_ibmratl (Not found in java.library.path)

Possible causes to this error might be:

* The Rational Common Licensing native library is not found in the path that is defined to the **java.library.path** property. Check that the native library exists in the defined path with the expected name.
* The **java.library.path** property is not set for the application server. Define a property with name **java.library.path** and set the path to the Rational Common Licensing native library as the value. For example, **/opt/IBM/RCL_Native_Library/**.
* There is a mix of 32-bit and 64-bit objects between the Java Runtime Environment of the application server and the native library. For example, a 32-bit Java Runtime Environment is used with a 64-bit native library. This mix is not supported.

### Insufficient token licenses

> FWLSE3129E: Insufficient token licenses for feature "{0}".

This error occurs when the remaining number of token licenses on the Rational License Key Server is not enough to deploy a new {{ site.data.keys.product_adj }} application.

### Invalid rcl_ibmratl.jar file

> UTLS0002E: The shared library RCL Shared Library contains a classpath entry which does not resolve to a valid jar file, the library jar file is expected to be found at {0}/rcl_ibmratl.jar.

**Note:** For WebSphere Application Server and WebSphere Application Server Network Deployment only

Possible causes to this error might be:

* The **rcl_ibmratl.jar** Java library does not have the appropriate permissions. The error might be followed by another exception: java.util.zip.ZipException: error in opening zip file. Check that the **rcl_ibmratl.jar** file has the read permission for the user who installs WebSphere Application Server.
* If there is no other exception, the **rcl_ibmratl.jar** file that is referenced in the class path of the shared library might be invalid or does not exist. Check that the **rcl_ibmratl.jar** file is valid or exists in the defined path.


