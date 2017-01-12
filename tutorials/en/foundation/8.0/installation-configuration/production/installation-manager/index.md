---
layout: tutorial
title: Running the IBM Installation Manager
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{: #overview }
IBM  Installation Manager installs the {{ site.data.keys.mf_server_full }} files and tools on your computer.

You run Installation Manager to install the binary files of {{ site.data.keys.mf_server }} and the tools to deploy the {{ site.data.keys.mf_server }} applications to an application server on your computer. The files and tools that are installed by the installer are described in [Distribution structure of {{ site.data.keys.mf_server }}](#distribution-structure-of-mobilefirst-server).

You need IBM Installation Manager V1.8.4 or later to run the {{ site.data.keys.mf_server }} installer. You can run it either in graphical mode or in command line mode.  
Two main options are proposed during the installation process:

* Activation of token licensing
* Installation and deployment of {{ site.data.keys.mf_app_center }}

### Token licensing
{: #token-licensing }
Token licensing is one of the two licensing methods supported by {{ site.data.keys.mf_server }}. You must determine whether you need to activate token licensing or not. If you do not have a contract that defines the use of token licensing with the Rational  License Key Server, do not activate token licensing. If you activate token licensing, you must configure {{ site.data.keys.mf_server }} for token licensing. For more information, see [Installing and configuring for token licensing](../token-licensing).

### {{ site.data.keys.mf_app_center_full }}
{: #ibm-mobilefirst-foundation-application-center }
Application Center is a component of {{ site.data.keys.product }}. With Application Center, you can share mobile applications that are under development within your organization in a single repository of mobile applications.

If you choose to install Application Center with Installation Manager, you must provide the database and the application server parameters so that Installation Manager configures the databases and deploys Application Center to the application server. If you choose not to install Application Center with Installation Manager, Installation Manager saves the WAR file and the resources of Application Center to your disk. It does not set up the databases nor deploys Application Center WAR file to your application server. You can do this later by using Ant tasks or manually. This option to install Application Center is a convenient way to discover Application Center because you are guided during the installation process by the graphical Install wizard.

However, for production installation, use Ant tasks to install Application Center. The installation with Ant tasks enables you to decouple the updates to {{ site.data.keys.mf_server }} from the updates to Application Center.

* Advantage of installing Application Center with Installation Manager.
    * A guided graphical wizard assists you through the installation and deployment process.
* Disadvantages of installing Application Center with Installation Manager.
    * If Installation Manager is run with the root user on UNIX or Linux, it might create files that are owned by root in the directory of the application server where Application Center is deployed. As a result, you must run the application server as root.
    * You have no access to the database scripts and cannot provide them to your database administrator to create the tables before you run the installation procedure. Installation Manager creates the database tables for you with default settings.
    * Each time when you upgrade the product, for example to install an interim fix, Application Center is upgraded first. The upgrade of Application Center includes operations on the database and the application server. If the upgrade of Application Center fails, it prevents Installation Manager from completing the upgrade, and prevents you from upgrading other {{ site.data.keys.mf_server }} components. For production installation, do not deploy Application Center with Installation Manager. Install Application Center separately with Ant tasks after Installation Manager installs{{ site.data.keys.mf_server }}. For more information about Application Center, see [Installing and configuring the Application Center](../../../appcenter).

> **Important:** The {{ site.data.keys.mf_server }} installer installs only the {{ site.data.keys.mf_server }} binary files and tools on your disk. It does not deploy the {{ site.data.keys.mf_server }} applications to your application server. After you run the installation with Installation Manager, you must set up the databases and deploy the {{ site.data.keys.mf_server }} applications to your application server.  
> Similarly, when you run Installation Manager to update an existing installation, it updates only the files on your disk. You need to perform more actions to update the applications that are deployed to your application servers.

#### Jump to
{: #jump-to }
* [Administrator versus user mode](#administrator-versus-user-mode)
* [Installing by using IBM Installation Manager Install wizard](#installing-by-using-ibm-installation-manager-install-wizard)
* [Installing by running IBM Installation Manager in command line](#installing-by-running-ibm-installation-manager-in-command-line)
* [Installing by using XML response files - silent installation](#installing-by-using-xml-response-files---silent-installation)
* [Distribution structure of {{ site.data.keys.mf_server }}](#distribution-structure-of-mobilefirst-server)

## Administrator versus user mode
{: #administrator-versus-user-mode }
You can install {{ site.data.keys.mf_server }} in two different IBM  Installation Manager modes. The mode depends on how IBM Installation Manager itself is installed. The mode determines the directories and commands that you use for both Installation Manager and packages.

{{ site.data.keys.product }} supports the following two Installation Manager modes:

* Administrator mode
* User (nonadministrator) mode

Group mode that is available on Linux or UNIX is not supported by the product.

### Administrator mode
{: #administrator-mode }
In administrator mode, Installation Manager must be run as root under Linux or UNIX, and with administrator privileges under Windows. The repository files of Installation Manager (that is the list of installed software and its version) are installed in a system directory. /var/ibm on Linux or UNIX, or ProgramData on Windows. Do not deploy Application Center with Installation Manager if you run Installation Manager in administrator mode.

### User (nonadministrator) mode
{: #user-nonadministrator-mode }
In user mode, Installation Manager can be run by any user without specific privileges. However, the repository files of Installation manager are stored in the user's home directory. Only that user is able to upgrade an installation of the product.
If you do not run Installation Manager as root, make sure that you have a user account that is available later when you upgrade the product installation or apply an interim fix.

For more information about the Installation Manager modes, see [Installing as an administrator, nonadministrator, or group](http://www.ibm.com/support/knowledgecenter/SSDV2W_1.8.4/com.ibm.silentinstall12.doc/topics/r_admin_nonadmin.html?lang=en&view=kc) in the IBM Installation Manager documentation.

## Installing by using IBM Installation Manager Install wizard
{: #installing-by-using-ibm-installation-manager-install-wizard }
Follow the steps in the procedure to install the resources of {{ site.data.keys.mf_server }}, and the tools (such as the Server Configuration Tool, Ant, and mfpadm program).  
The decisions in the following two panes in the installation wizard are mandatory:

* The **General settings** panel.
* The **Choose configuration** panel to install Application Center.

1. Launch Installation Manager.
2. Add the repository of {{ site.data.keys.mf_server }} in Installation Manager.
    * Go to **File → Preferences** and click **Add Repositories...**.
    * Browse for the repository file in the directory where the installer is extracted.

        If you decompress the {{ site.data.keys.product }} V8.0 .zip file for {{ site.data.keys.mf_server }} in **mfp\_installer\_directory** folder, the repository file can be found at **mfp\_installer\_directory/MobileFirst\_Platform\_Server/disk1/diskTag.inf**.

        You might also want to apply the latest fix pack that can be downloaded from the [IBM Support Portal](http://www.ibm.com/support/entry/portal/product/other_software/ibm_mobilefirst_platform_foundation). Make sure to enter the repository for the fix pack. If you decompress the fix pack in **fixpack_directory** folder, the repository file is found in **fixpack\_directory/MobileFirst\_Platform\_Server/disk1/diskTag.inf**.

        **Note:** You cannot install the fix pack without the repository of the base version in the repositories of Installation Manager. The fix packs are incremental installers and need the repository of the base version to be installed.
    * Select the file and click **OK**.
    * Click **OK** to close the **Preferences** panel.
3. After you accept the license terms of the product, click **Next**.
4. Choose the package group to install the product.

    {{ site.data.keys.product }} V8.0 is a replacement for the previous releases that have a different installation name:
    * Worklight for V5.0.6
    * IBM Worklight for V6.0 to V6.3
    
    If one of these older versions of the product is installed on your computer, Installation Manager offers you an option Use an Existing Package Group at the start of the installation process. This option uninstalls your older version of the product, and reuse your older installation options to upgrade {{ site.data.keys.mf_app_center_full }} if it was installed.
    
    For a separate installation, select the Create a New Package group option so that you can install the new version alongside with the older one.  
    If no other version of the product is installed on your computer, choose the Create a new package group option to install the product in a new package group.
    
5. Click **Next**.
6. Decide whether to activate token licensing in the **Activate token licensing** section of the **General settings** panel.

    If you have a contract to use token licensing with Rational  License Key Server, select the **Activate token licensing with the Rational License Key Server** option. After you activate token licensing, you must do extra steps to configure {{ site.data.keys.mf_server }}. Otherwise, select the **Do not activate token licensing with the Rational License Key Server** option to proceed.
7. Keep the default option (No) as-is in the **Install {{ site.data.keys.product }} for iOS** section of the **General settings** panel.
8. Decide whether to install Application Center in **Choose configuration** panel.

    For production installation, use Ant tasks to install Application Center. The installation with Ant tasks enables you to decouple the updates to {{ site.data.keys.mf_server }} from the updates to Application Center. In this case, select No option in the Choose configuration panel so that Application Center is not installed.

    If you select Yes, you need to go through the next panes to enter the details about the database you plan to use and the application server where you plan to deploy Application Center. You also need to have the JDBC driver of your database available.
9. Click **Next** until you reach the **Thank You** panel. Then, proceed with the installation.

An installation directory that contains the resources to install {{ site.data.keys.product_adj }} components is installed.

You can find the resources in the following folders:

* **MobileFirstServer** folder for {{ site.data.keys.mf_server }}
* **PushService** folder for {{ site.data.keys.mf_server }} push service
* **ApplicationCenter** folder for Application Center
* **Analytics** folder for {{ site.data.keys.mf_analytics }}

You can also find some shortcuts for the Server Configuration Tool, Ant, and mfpadm program in the **shortcuts** folder.

## Installing by running IBM Installation Manager in command line
{: #installing-by-running-ibm-installation-manager-in-command-line }

1. Review the license agreement for {{ site.data.keys.mf_server }}. The license files can be viewed when you download the installation repository from Passport Advantage .
2. Extract the compressed file of {{ site.data.keys.mf_server }} repository, that you downloaded, to a folder.

    You can download the repository from the {{ site.data.keys.product }} eAssembly on [IBM Passport Advantage](http://www.ibm.com/software/passportadvantage/pao_customers.htm). The name of the pack is **IBM MobileFirst Foundation V{{ site.data.keys.product_V_R }} .zip file of Installation Manager Repository for IBM MobileFirst Platform Server**.

    In the steps that follow, the directory where you extract the installer is referred as **mfp\_repository\_dir**. It contains a **MobileFirst\_Platform\_Server/disk1** folder.
3. Start a command line and go to **installation\_manager\_install\_dir/tools/eclipse/**.

    If you accept the license agreement after the review in step 1, install {{ site.data.keys.mf_server }}.
    * For an installation without token licensing enforcement (if you do not have a contract that defines the use of token licensing), enter the command:

      ```bash
      imcl install com.ibm.mobilefirst.foundation.server -repositories mfp_repository_dir/MobileFirst_Platform_Server/disk1 -properties user.appserver.selection2=none,user.database.selection2=none,user.database.preinstalled=false,user.licensed.by.tokens=false,user.use.ios.edition=false -acceptLicense
      ```
    * For an installation with token licensing enforcement, enter the command:
    
      ```bash
      imcl install com.ibm.mobilefirst.foundation.server -repositories mfp_repository_dir/MobileFirst_Platform_Server/disk1 -properties user.appserver.selection2=none,user.database.selection2=none,user.database.preinstalled=false,user.licensed.by.tokens=true,user.use.ios.edition=false -acceptLicense
      ```
    
        The value of **user.licensed.by.tokens** property is set to **true**. You must configure {{ site.data.keys.mf_server }} for [token licensing](../token-licensing).
        
        The following properties are set to install {{ site.data.keys.mf_server }} without Application Center:
        * **user.appserver.selection2**=none
        * **user.database.selection2**=none
        * **user.database.preinstalled**=false
        
        This property indicates whether token licensing is activated or not: **user.licensed.by.tokens=true/false**.
        
        Set the value of the user.use.ios.edition property to false to install {{ site.data.keys.product }}.
        
5. If you want to install with the latest interim fix, add the interim fix repository in the **-repositories** parameter. The **-repositories** parameter takes a comma-separated list of repositories.

    Add the version of the interim fix by replacing **com.ibm.mobilefirst.foundation.server** with **com.ibm.mobilefirst.foundation.server_version**. **version** has the form **8.0.0.0-buildNumber**. For example, if you install the interim fix **8.0.0.0-IF20160103101**5, enter the command: `imcl install com.ibm.mobilefirst.foundation.server_8.0.0.00-201601031015 -repositories...`.
    
    For more information about the imcl command, see [Installation Manager: Installing packages by using `imcl` commands](https://www.ibm.com/support/knowledgecenter/SSDV2W_1.8.4/com.ibm.cic.commandline.doc/topics/t_imcl_install.html?lang=en).
    
An installation directory that contains the resources to install {{ site.data.keys.product_adj }} components is installed.

You can find the resources in the following folders:

* **MobileFirstServer** folder for {{ site.data.keys.mf_server }}
* **PushService** folder for {{ site.data.keys.mf_server }} push service
* **ApplicationCenter** folder for Application Center
* **Analytics** folder for {{ site.data.keys.mf_analytics }}    

You can also find some shortcuts for the Server Configuration Tool, Ant, and mfpadm program in the **shortcuts** folder.

## Installing by using XML response files - silent installation
{: #installing-by-using-xml-response-files---silent-installation }
If you want to install {{ site.data.keys.mf_app_center_full }} with IBM Installation Manager in command line, you need to provide a large list of arguments. In this case, use the XML response files to provide these arguments.

Silent installations are defined by an XML file that is called a response file. This file contains the necessary data to complete installation operations silently. Silent installations are started from the command line or a batch file.

You can use Installation Manager to record preferences and installation actions for your response file in user interface mode. Alternatively, you can create a response file manually by using the documented list of response file commands and preferences.

Silent installation is described in the Installation Manager user documentation, see [Working in silent mode](http://ibm.biz/knowctr#SSDV2W_1.8.4/com.ibm.silentinstall12.doc/topics/t_silentinstall_overview.html).

There are two ways to create a suitable response file:

* Working with sample response files provided in the {{ site.data.keys.product_adj }} user documentation.
* Working with a response file recorded on a different computer.

Both of these methods are documented in the following sections.

### Working with sample response files for IBM Installation Manager
{: #working-with-sample-response-files-for-ibm-installation-manager }
Sample response files for IBM Installation Manager are provided in the **Silent\_Install\_Sample_Files.zip** compressed file. The following procedures describe how to use them.

1. Pick the appropriate sample response file from the compressed file. The Silent_Install_Sample_Files.zip file contains one subdirectory per release.

    > **Important:**  
    > 
    > * For an installation that does not install Application Center on an application server, use the file named **install-no-appcenter.xml**.
    > * For an installation that installs Application Center, pick the sample response file from the following table, depending on your application server and database.

   #### Sample installation response files in the **Silent\_Install\_Sample_Files.zip** file to install the Application Center
    
    <table>
        <tr>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
            <th>Application server where you install the Application Center</th>
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
            <td>WebSphere  Application Server Liberty profile</td>
            <td>install-liberty-derby.xml</td>
            <td>install-liberty-db2.xml</td>
            <td>install-liberty-mysql.xml (See Note)</td>
            <td>install-liberty-oracle.xml</td>
        </tr>
        <tr>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
            <td>WebSphere Application Server full profile, stand-alone server</td>
            <td>install-was-derby.xml</td>
            <td>install-was-db2.xml</td>
            <td>install-was-mysql.xml (See Note)</td>
            <td>install-was-oracle.xml</td>
        </tr>
        <tr>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
            <td>WebSphere Application Server Network Deployment</td>
            <td>n/a</td>
            <td>install-wasnd-cluster-db2.xml, install-wasnd-server-db2.xml, install-wasnd-node-db2.xml, install-wasnd-cell-db2.xml</td>
            <td>install-wasnd-cluster-mysql.xml (See Note), install-wasnd-server-mysql.xml (See Note), install-wasnd-node-mysql.xml, install-wasnd-cell-mysql.xml (See Note)</td>
            <td>install-wasnd-cluster-oracle.xml, install-wasnd-server-oracle.xml, install-wasnd-node-oracle.xml, install-wasnd-cell-oracle.xml</td>
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
    
    > **Note:** MySQL in combination with WebSphere Application Server Liberty profile or WebSphere Application Server full profile is not classified as a supported configuration. For more information, see [WebSphere Application Server Support Statement](http://www.ibm.com/support/docview.wss?uid=swg27004311). You can use IBM DB2 or another DBMS that is supported by WebSphere Application Server to benefit from a configuration that is fully supported by IBM Support.

    For uninstallation, use a sample file that depends on the version of {{ site.data.keys.mf_server }} or Worklight Server that you initially installed in the particular package group:
    
    * {{ site.data.keys.mf_server }} uses the package group {{ site.data.keys.mf_server }}.
    * Worklight Server V6.x, or later, uses the package group IBM Worklight.
    * Worklight Server V5.x uses the package group Worklight.

    <table>
        <tr>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
            <th>Initial version of {{ site.data.keys.mf_server }}</th>
            <th>Sample file</th>
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
            <td>IBM MobileFirst Server V6.x or later</td>
            <td>uninstall-initially-mfpserver.xml</td>
        </tr>
    </table>

2. Change the file access rights of the sample file to be as restrictive as possible. Step 4 requires that you supply some passwords. If you must prevent other users on the same computer from learning these passwords, you must remove the read permissions of the file for users other than yourself. You can use a command, such as the following examples:
    * On UNIX: `chmod 600 <target-file.xml>`
    * On Windows: `cacls <target-file.xml> /P Administrators:F %USERDOMAIN%\%USERNAME%:F`
3. Similarly, if the server is a WebSphere Application Server Liberty profile or Apache Tomcat server, and the server is meant to be started only from your user account, you must also remove the read permissions for users other than yourself from the following file:
    * For WebSphere Application Server Liberty profile: `wlp/usr/servers/<server>/server.xml`
    * For Apache Tomcat: `conf/server.xml`
4. Adjust the list of repositories, in the <server> element. For more information about this step, see IBM Installation Manager documentation at [Repositories](http://ibm.biz/knowctr#SSDV2W_1.8.4/com.ibm.silentinstall12.doc/topics/r_repository_types.html).

    In the `<profile>` element, adjust the values of each key/value pair.  
    In the `<offering>` element in the `<install>` element, set the version attribute to match the release you want to install, or remove the version attribute if you want to install the newest version available in the repositories.
5. Type the following command: `<InstallationManagerPath>/eclipse/tools/imcl input <responseFile>  -log /tmp/installwl.log -acceptLicense`

    Where:
    * `<InstallationManagerPath>` is the installation directory of IBM Installation Manager.
    * `<responseFile>` is the name of the file that is selected and updated in step 1.

> For more information, see the IBM Installation Manager documentation at [Installing a package silently by using a response file](http://ibm.biz/knowctr#SSDV2W_1.8.4/com.ibm.silentinstall12.doc/topics/t_silent_response_file_install.html).
    

### Working with a response file recorded on a different machine
{: #working-with-a-response-file-recorded-on-a-different-machine }

1. Record a response file, by running IBM Installation Manager in wizard mode and with option `-record responseFile` on a machine where a GUI is available. For more details, see [Record a response file with Installation Manager](http://ibm.biz/knowctr#SSDV2W_1.7.0/com.ibm.silentinstall12.doc/topics/t_silent_create_response_files_IM.html).
2. Change the file access rights of the response file to be as restrictive as possible. Step 4 requires that you supply some passwords. If you must prevent other users on the same computer from learning these passwords, you must remove the **read** permissions of the file for users other than yourself. You can use a command, such as the following examples:
    * On UNIX: `chmod 600 response-file.xml`
    * On Windows: `cacls response-file.xml /P Administrators:F %USERDOMAIN%\%USERNAME%:F`
3. Similarly, if the server is a WebSphere  Application Server Liberty or Apache Tomcat server, and the server is meant to be started only from your user account, you must also remove the read permissions for users other than yourself from the following file:
    * For WebSphere Application Server Liberty: `wlp/usr/servers/<server>/server.xml`
    * For Apache Tomcat: `conf/server.xml`
4. Modify the response file to take into account differences between the machine on which the response file was created and the target machine.
5. Install {{ site.data.keys.mf_server }} by using the response file on the target machine, as described in [Install a package silently by using a response file](http://ibm.biz/knowctr#SSDV2W_1.7.0/com.ibm.silentinstall12.doc/topics/t_silent_response_file_install.html).

### Command-line (silent installation) parameters
{: #command-line-silent-installation-parameters }
<table style="word-break:break-all">
    <tr>
        <th>Key</th>
        <th>When necessary</th>
        <th>Description</th>
        <th>Allowed values</th>
    </tr>
    <tr>
        <td>user.use.ios.edition</td>
        <td>Always</td>
        <td>Set the value to <code>false</code> if you plan to install {{ site.data.keys.product }}. If you plan to install the product for iOS edition, you must set the value to <code>true</code>.</td>
        <td><code>true</code> or <code>false</code></td>
    </tr>
    <tr>
        <td>user.licensed.by.tokens</td>
        <td>Always</td>
        <td>Activation of token licensing. If you plan to use the product with the Rational  License Key Server, you must activate token licensing.<br/><br/>In this case, set the value to <code>true</code>. If you do not plan to use the product with Rational License Key Server, set the value to <code>false</code>.<br/><br/>If you activate license tokens, specific configuration steps are required after you deploy the product to an application server. </td>
        <td><code>true</code> or <code>false</code></td>    
    </tr>
    <tr>
        <td>user.appserver.selection2</td>
        <td>Always</td>
        <td>Type of application server. was means preinstalled WebSphere  Application Server 8.5.5. tomcat means Tomcat 7.0.</td>
        <td></td>
    </tr>
    <tr>
        <td>user.appserver.was.installdir</td>
        <td>${user.appserver.selection2} == was</td>
        <td>WebSphere Application Server installation directory.</td>
        <td>An absolute directory name.</td>
    </tr>
    <tr>
        <td>user.appserver.was.profile</td>
        <td>${user.appserver.selection2} == was</td>
        <td>Profile into which to install the applications. For WebSphere Application Server Network Deployment, specify the Deployment Manager profile. Liberty means the Liberty profile (subdirectory wlp).</td>
        <td>The name of one of the WebSphere Application Server profiles.</td>
    </tr>
    <tr>
        <td>user.appserver.was.cell</td>
        <td>${user.appserver.selection2} == was && ${user.appserver.was.profile} != Liberty</td>
        <td>WebSphere Application Server cell into which to install the applications.</td>
        <td>The name of the WebSphere Application Server cell.</td>
    </tr>
    <tr>
        <td>user.appserver.was.node</td>
        <td>${user.appserver.selection2} == was && ${user.appserver.was.profile} != Liberty</td>
        <td>WebSphere Application Server node into which to install the applications. This corresponds to the current machine.</td>
        <td>The name of the WebSphere Application Server node of the current machine.</td>
    </tr>
    <tr>
        <td>user.appserver.was.scope</td>
        <td>${user.appserver.selection2} == was && ${user.appserver.was.profile} != Liberty</td>
        <td>Type of set of servers into which to install the applications.<br/><br/><code>server</code> means a standalone server.<br/><br/><code>nd-cell</code> means a WebSphere Application Server Network Deployment cell. <code>nd-cluster</code> means a WebSphere Application Server Network Deployment cluster.<br/><br/><code>nd-node</code> means a WebSphere Application Server Network Deployment node (excluding clusters).<br/><br/><code>nd-server</code> means a managed WebSphere Application Server Network Deployment server.</td>
        <td><code>server</code>, <code>nd-cell</code>, <code>nd-cluster</code>, <code>nd-node</code>, <code>nd-server</code></td>
    </tr>
    <tr>
      <td>user.appserver.was.serverInstance</td>
      <td>${user.appserver.selection2} == was && ${user.appserver.was.profile} != Liberty && ${user.appserver.was.scope} == server</td>
      <td>Name of WebSphere Application Server server into which to install the applications.</td>
      <td>The name of a WebSphere Application Server server on the current machine.</td>
    </tr>
    <tr>
      <td>user.appserver.was.nd.cluster</td>
      <td>${user.appserver.selection2} == was && ${user.appserver.was.profile} != Liberty && ${user.appserver.was.scope} == nd-cluster</td>
      <td>Name of WebSphere Application Server Network Deployment cluster into which to install the applications.</td>
      <td>The name of a WebSphere Application Server Network Deployment cluster in the WebSphere Application Server cell.</td>
    </tr>
    <tr>
      <td>user.appserver.was.nd.node</td>
      <td>${user.appserver.selection2} == was && ${user.appserver.was.profile} != Liberty && (${user.appserver.was.scope} == nd-node || ${user.appserver.was.scope} == nd-server)</td>
      <td>Name of WebSphere Application Server Network Deployment node into which to install the applications.</td>
      <td>The name of a WebSphere Application Server Network Deployment node in the WebSphere Application Server cell.</td>
    </tr>
    <tr>
      <td>user.appserver.was.nd.server</td>
      <td>${user.appserver.selection2} == was && ${user.appserver.was.profile} != Liberty && ${user.appserver.was.scope} == nd-server</td>
      <td>Name of WebSphere Application Server Network Deployment server into which to install the applications.</td>
      <td>The name of a WebSphere Application Server Network Deployment server in the given WebSphere Application Server Network Deployment node.</td>
    </tr>
    <tr>
      <td>user.appserver.was.admin.name</td>
      <td>${user.appserver.selection2} == was && ${user.appserver.was.profile} != Liberty</td>
      <td>Name of WebSphere Application Server administrator.</td>
      <td></td>
    </tr>
    <tr>
      <td>user.appserver.was.admin.password2</td>
      <td>${user.appserver.selection2} == was && ${user.appserver.was.profile} != Liberty</td>
      <td>Password of WebSphere Application Server administrator, optionally encrypted in a specific way.</td>
      <td></td>
    </tr>
    <tr>
      <td>user.appserver.was.appcenteradmin.password</td>
      <td>${user.appserver.selection2} == was && ${user.appserver.was.profile} != Liberty</td>
      <td>Password of <code>appcenteradmin</code> user to add to the WebSphere Application Server users list, optionally encrypted in a specific way.</td>
      <td></td>
    </tr>
    <tr>
      <td>user.appserver.was.serial</td>
      <td>${user.appserver.selection2} == was && ${user.appserver.was.profile} != Liberty</td>
      <td>Suffix that distinguishes the applications to be installed from other installations of {{ site.data.keys.mf_server }}.</td>
      <td>String of 10 decimal digits.</td>
    </tr>
    <tr>
      <td>user.appserver.was85liberty.serverInstance_</td>
      <td>${user.appserver.selection2} == was && ${user.appserver.was.profile} == Liberty</td>
      <td>Name of WebSphere Application Server Liberty server into which to install the applications.</td>
      <td></td>
    </tr>
    <tr>
      <td>user.appserver.tomcat.installdir</td>
      <td>${user.appserver.selection2} == tomcat</td>
      <td>Apache Tomcat installation directory. For a Tomcat installation that is split between a <b>CATALINA_HOME</b> directory and a <b>CATALINA_BASE</b> directory, here you need to specify the value of the <b>CATALINA_BASE</b> environment variable.</td>
      <td>An absolute directory name.</td>
    </tr>
    <tr>
      <td>user.database.selection2</td>
      <td>Always</td>
      <td>Type of database management system used to store the databases.</td>
      <td><code>derby</code>, <code>db2</code>, <code>mysql</code>, <code>oracle</code>, <code>none</code>. The value none means that the installer will not install the Application Center. If this value is used, both <b>user.appserver.selection2</b> and <b>user.database.selection2</b> must take the value none.</td>
    </tr>
    <tr>
      <td>user.database.preinstalled</td>
      <td>Always</td>
      <td><code>true</code> means a preinstalled database management system, <code>false</code> means Apache Derby to install.</td>
      <td><code>true</code>, <code>false</code></td>
    </tr>
    <tr>
      <td>user.database.derby.datadir</td>
      <td>${user.database.selection2} == derby</td>
      <td>The directory in which to create or assume the Derby databases.</td>
      <td>An absolute directory name.</td>
    </tr>
    <tr>
      <td>user.database.db2.host</td>
      <td>${user.database.selection2} == db2</td>
      <td>The host name or IP address of the DB2  database server.</td>
      <td></td>
    </tr>
    <tr>
      <td>user.database.db2.port</td>
      <td>${user.database.selection2} == db2</td>
      <td>The port where the DB2 database server listens for JDBC connections. Usually 50000.</td>
      <td>A number between 1 and 65535.</td>
    </tr>
    <tr>
      <td>user.database.db2.driver</td>
      <td>${user.database.selection2} == db2</td>
      <td>The absolute file name of db2jcc4.jar.</td>
      <td>An absolute file name.</td>
    </tr>
    <tr>
      <td>user.database.db2.appcenter.username</td>
      <td>${user.database.selection2} == db2</td>
      <td>The user name used to access the DB2 database for Application Center.</td>
      <td>Non-empty.</td>
    </tr>
    <tr>
      <td>user.database.db2.appcenter.password</td>
      <td>${user.database.selection2} == db2</td>
      <td>The password used to access the DB2 database for Application Center, optionally encrypted in a specific way.</td>
      <td>Non-empty password.</td>
    </tr>
    <tr>
      <td>user.database.db2.appcenter.dbname</td>
      <td>${user.database.selection2} == db2</td>
      <td>The name of the DB2 database for Application Center.</td>
      <td>Non-empty; a valid DB2 database name.</td>
    </tr>
    <tr>
      <td>user.database.oracle.appcenter.isservicename.jdbc.url</td>
      <td>Optional</td>
      <td>Indicates if <b>user.database.mysql.appcenter.dbname</b> is a Service name or a SID name. If the parameter is absent then <b>user.database.mysql.appcenter.dbname</b> is considered to be a SID name.</td>
      <td><code>true</code> (indicates a Service name) or <code>false</code> (indicates a SID name)</td>
    </tr>
    <tr>
      <td>user.database.db2.appcenter.schema</td>
      <td>${user.database.selection2} == db2</td>
      <td>The name of the schema for Application Center in the DB2 database.</td>
      <td></td>
    </tr>
    <tr>
      <td>user.database.mysql.host</td>
      <td>${user.database.selection2} == mysql</td>
      <td>The host name or IP address of the MySQL database server.</td>
      <td></td>
    </tr>
    <tr>
      <td>user.database.mysql.port</td>
      <td>${user.database.selection2} == mysql</td>
      <td>The port where the MySQL database server listens for JDBC connections. Usually 3306.</td>
      <td>A number between 1 and 65535.</td>
    </tr>
    <tr>
      <td>user.database.mysql.driver</td>
      <td>${user.database.selection2} == mysql</td>
      <td>The absolute file name of <b>mysql-connector-java-5.*-bin.jar</b>.</td>
      <td>An absolute file name.</td>
    </tr>
    <tr>
      <td>user.database.mysql.appcenter.username</td>
      <td>${user.database.selection2} == oracle</td>
      <td>The user name used to access the Oracle database for Application Center.</td>
      <td>A string consisting of 1 to 30 characters: ASCII digits, ASCII uppercase and lowercase letters, '_', '#', '$' are allowed.</td>
    </tr>
    <tr>
      <td>user.database.mysql.appcenter.password</td>
      <td>${user.database.selection2} == oracle</td>
      <td>The password used to access the Oracle database for Application Center, optionally encrypted in a specific way.</td>
      <td>The password must be a string consisting of 1 to 30 characters: ASCII digits, ASCII uppercase and lowercase letters, '_', '#', '$' are allowed.</td>
    </tr>
    <tr>
      <td>user.database.mysql.appcenter.dbname</td>
      <td>${user.database.selection2} == oracle, unless ${user.database.oracle.appcenter.jdbc.url} is specified</td>
      <td>The name of the Oracle database for Application Center.</td>
      <td>Non-empty, a valid Oracle database name.</td>
    </tr>
    <tr>
      <td>user.database.oracle.host</td>
      <td>${user.database.selection2} == oracle, unless ${user.database.oracle.appcenter.jdbc.url} is specified</td>
      <td>The host name or IP address of the Oracle database server.</td>
      <td></td>
    </tr>
    <tr>
      <td>user.database.oracle.port</td>
      <td>${user.database.selection2} == oracle, unless ${user.database.oracle.appcenter.jdbc.url} is specified</td>
      <td>The port where the Oracle database server listens for JDBC connections. Usually 1521.</td>
      <td>A number between 1 and 65535.</td>
    </tr>
    <tr>
      <td>user.database.oracle.driver</td>
      <td>${user.database.selection2} == oracle</td>
      <td>The absolute file name of the Oracle thin driver jar file. (<b>ojdbc6.jar or ojdbc7.jar</b>)</td>
      <td>An absolute file name.</td>
    </tr>
    <tr>
      <td>user.database.oracle.appcenter.username</td>
      <td>${user.database.selection2} == oracle</td>
      <td>The user name used to access the Oracle database for Application Center.</td>
      <td>A string consisting of 1 to 30 characters: ASCII digits, ASCII uppercase and lowercase letters, '_', '#', '$' are allowed.</td>
    </tr>
    <tr>
      <td>user.database.oracle.appcenter.username.jdbc</td>
      <td>	${user.database.selection2} == oracle</td>
      <td>The user name used to access the Oracle database for Application Center, in a syntax suitable for JDBC.</td>
      <td>Same as ${user.database.oracle.appcenter.username} if it starts with an alphabetic character and does not contain lowercase characters, otherwise it must be ${user.database.oracle.appcenter.username} surrounded by double quotes.</td>
    </tr>
    <tr>
      <td>user.database.oracle.appcenter.password</td>
      <td>${user.database.selection2} == oracle</td>
      <td>The password used to access the Oracle database for Application Center, optionally encrypted in a specific way.</td>
      <td>The password must be a string consisting of 1 to 30 characters: ASCII digits, ASCII uppercase and lowercase letters, '_', '#', '$' are allowed.</td>
    </tr>
    <tr>
      <td>user.database.oracle.appcenter.dbname</td>
      <td>${user.database.selection2} == oracle, unless ${user.database.oracle.appcenter.jdbc.url} is specified</td>
      <td>The name of the Oracle database for Application Center.</td>
      <td>Non-empty, a valid Oracle database name.
</td>
    </tr>
    <tr>
      <td>user.database.oracle.appcenter.isservicename.jdbc.url</td>
      <td>Optional</td>
      <td>Indicates if <code>user.database.oracle.appcenter.dbname</code> is a Service name or a SID name. If the parameter is absent then <code>user.database.oracle.appcenter.dbname</code> is considered to be a SID name.</td>
      <td><code>true</code> (indicates a Service name) or <code>false</code> (indicates a SID name)</td>
    </tr>
    <tr>
      <td>user.database.oracle.appcenter.jdbc.url</td>
      <td>${user.database.selection2} == oracle, unless ${user.database.oracle.host}, ${user.database.oracle.port}, ${user.database.oracle.appcenter.dbname} are all specified</td>
      <td>The JDBC URL of the Oracle database for Application Center.</td>
      <td>A valid Oracle JDBC URL. Starts with "jdbc:oracle:".</td>
    </tr>
    <tr>
      <td>user.writable.data.user</td>
      <td>Always</td>
      <td>The operating system user that is allowed to run the installed server.</td>
      <td>An operating system user name, or empty.</td>
    </tr>
    <tr>
      <td>user.writable.data.group2</td>
      <td>Always</td>
      <td>The operating system users group that is allowed to run the installed server.</td>
      <td>An operating system users group name, or empty.</td>
    </tr>
</table>

## Distribution structure of {{ site.data.keys.mf_server }}
{: #distribution-structure-of-mobilefirst-server }
The {{ site.data.keys.mf_server }} files and tools are installed in the {{ site.data.keys.mf_server }} installation directory.

#### Files and subdirectories in the Analytics subdirectory
{: #files-and-subdirectories-in-the-analytics-subdirectory }

| Item | Description |
|------|-------------|
| **analytics.ear** and **analytics-*.war** | The EAR and WAR files to install {{ site.data.keys.mf_analytics }}. |
| **configuration-samples** | Contains the sample Ant files to install {{ site.data.keys.mf_analytics }} with Ant tasks. |

#### Files and subdirectories in the ApplicationCenter subdirectory
{: #files-and-subdirectories-in-the-applicationcenter-subdirectory }

| Item | Description |
|------|-------------|
| **configuration-samples** | Contains the sample Ant files to install Application Center. The Ant tasks create the database table and deploy WAR files to an application server. | 
| **console** | Contains the EAR and WAR files to install Application Center. The EAR file is uniquely for IBM  PureApplication  System. | 
| **databases** | Contains the SQL scripts to be used for the manual creation of tables for Application Center. |
| **installer** | Contains the resources to create the Application Center client. | 
| **tools** | The tools of Application Center. | 

#### Files and subdirectories in the {{ site.data.keys.mf_server }} subdirectory
{: #files-and-subdirectories-in-the-mobilefirst-server-subdirectory }

| Item | Description |
|------|-------------|
| **mfp-ant-deployer.jar** | A set of {{ site.data.keys.mf_server }} Ant tasks. |
| **mfp-*.war** | The WAR files of the {{ site.data.keys.mf_server }} components. |
| **configuration-samples** | Contains the sample Ant files to install {{ site.data.keys.mf_server }} components with Ant tasks. | 
| **ConfigurationTool** | Contains the binary files of the Server Configuration Tool. The tool is launched from **mfp_server_install_dir/shortcuts**. |
| **databases** | Contains the SQL scripts to be used for the manual creation of tables for {{ site.data.keys.mf_server }} components ({{ site.data.keys.mf_server }} administration service, {{ site.data.keys.mf_server }} configuration service, and {{ site.data.keys.product_adj }} runtime). | 
| **external-server-libraries** |  Contains the JAR files that are used by different tools (such as the authenticity tool and the OAuth security tool). |

#### Files and subdirectories in the PushService subdirectory
{: #files-and-subdirectories-in-the-pushservice-subdirectory }

| Item | Description |
|------|-------------|
| **mfp-push-service.war** | The WAR file to install {{ site.data.keys.mf_server }} push service. |
| **databases** | Contains the SQL scripts to be used for the manual creation of tables for {{ site.data.keys.mf_server }} push service. | 

#### Files and subdirectories in the License subdirectory
{: #files-and-subdirectories-in-the-license-subdirectory }

| Item | Description |
|------|-------------|
| **Text** | Contains the license for {{ site.data.keys.product }}. | 

#### Files and subdirectories in the {{ site.data.keys.mf_server }} installation directory
{: #files-and-subdirectories-in-the-mobilefirst-server-installation-directory }

| Item | Description |
|------|-------------|
| **shortcuts** | Launcher scripts for Apache Ant, the Server Configuration Tool, and the mfpadmin command, which are supplied with {{ site.data.keys.mf_server }}. | 

#### Files and subdirectories in the tools subdirectory
{: #files-and-subdirectories-in-the-tools-subdirectory }

| Item | Description |
|------|-------------|
| **tools/apache-ant-version-number** | A binary installation of Apache Ant that is used by the Server Configuration Tool. It can also be used to run the Ant tasks. | 
