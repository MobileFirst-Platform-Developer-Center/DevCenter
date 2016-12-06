---
layout: tutorial
title: Deploying MobileFirst Server on IBM PureApplication System
breadcrumb_title: Installing Pure Application System
weight: 10
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{{ site.data.keys.product_full }} provides the capability to deploy and manage {{ site.data.keys.mf_server }} and {{ site.data.keys.product_adj }} applications on IBM  PureApplication System and IBM PureApplication Service on SoftLayer .

{{ site.data.keys.product }} in combination with IBM PureApplication System and IBM PureApplication Service on SoftLayer provides a simple and intuitive environment for developers and administrators, to develop mobile applications, test them, and deploy them to the cloud. This version of {{ site.data.keys.mf_system_pattern_full }} provides {{ site.data.keys.product }} runtime and artifacts support for the PureApplication Virtual System Pattern technologies that are included in the most recent versions of IBM PureApplication System and IBM PureApplication Service on SoftLayer. Classic Virtual System Pattern was supported in earlier versions of IBM PureApplication System.

#### Jump to
* [Installing {{ site.data.keys.mf_system_pattern }}](#installing-mobilefirst-system-pattern)
* [Token licensing requirements for {{ site.data.keys.mf_system_pattern }}](#token-licensing-requirements-for-mobilefirst-system-pattern)
* [Deploying {{ site.data.keys.mf_server }} on a single-node WebSphere Application Server Liberty profile server](#deploying-mobilefirst-server-on-a-single-node-websphere-application-server-liberty-profile-server)
* [Deploying {{ site.data.keys.mf_server }} on a multiple-node WebSphere Application Server Liberty profile server](#deploying-mobilefirst-server-on-a-multiple-node-websphere-application-server-liberty-profile-server)
* [Deploying {{ site.data.keys.mf_server }} on a single-node WebSphere Application Server full profile server](#deploying-mobilefirst-server-on-a-single-node-websphere-application-server-full-profile-server)
* [Deploying {{ site.data.keys.mf_server }} on a multiple-node WebSphere Application Server full profile server](#deploying-mobilefirst-server-on-a-multiple-node-websphere-application-server-full-profile-server)
* [Deploying {{ site.data.keys.mf_server }} on clusters of WebSphere Application Server Network Deployment servers](#deploying-mobilefirst-server-on-clusters-of-websphere-application-server-network-deployment-servers)
* [Deploying {{ site.data.keys.mf_app_center }} on a single-node WebSphere Application Server Liberty profile server](#deploying-mobilefirst-application-center-on-a-single-node-websphere-application-server-liberty-profile-server)
* [Deploying {{ site.data.keys.mf_app_center }} on a single-node WebSphere Application Server full profile server](#deploying-mobilefirst-application-center-on-a-single-node-websphere-application-server-full-profile-server)
* [Configuring {{ site.data.keys.product_adj }} administration security with an external LDAP repository](#configuring-mobilefirst-administration-security-with-an-external-ldap-repository)
* [Configuring an external database with a {{ site.data.keys.mf_system_pattern }}](#configuring-an-external-database-with-a-mobilefirst-system-pattern)
* [Deploying and configuring {{ site.data.keys.mf_analytics }}](#deploying-and-configuring-mobilefirst-analytics)
* [Predefined templates for {{ site.data.keys.mf_system_pattern }}](#predefined-templates-for-mobilefirst-system-pattern)
* [Script packages for {{ site.data.keys.mf_server }}](#script-packages-for-mobilefirst-server)
* [Upgrading {{ site.data.keys.mf_system_pattern }}](#upgrading-mobilefirst-system-pattern)

### Key benefits
{{ site.data.keys.mf_system_pattern }} provides the following benefits:

* Predefined templates enable you to build patterns in a simple way for the most typical {{ site.data.keys.mf_server }} deployment topologies. Examples of the topologies are  
    * IBM WebSphere  Application Server Liberty profile single node
    * IBM WebSphere Application Server Liberty profile multiple nodes
    * IBM WebSphere Application Server full profile single node
    * IBM WebSphere Application Server full profile multiple nodes
    * Clusters of WebSphere Application Server Network Deployment servers
    * {{ site.data.keys.mf_app_center }} deployment topologies such as
        * IBM WebSphere Application Server Liberty profile single node
        * IBM WebSphere Application Server full profile single node
* Script packages act as building blocks to compose extended deployment topologies such as automating the inclusion of an analytics server in a pattern and flexible DB VM deployment options. WebSphere Application Server and DB2 script packages are available through the inclusion of WebSphere Application Server and DB2 pattern types.
* Optional JNDI properties in the runtime deployment script package allow fine-grained tuning for the deployment topology. In addition, deployment topologies that are built with IBM WebSphere Application Server full profile now support accessing the WebSphere Application Server Administration Console, which gives you full control over the configuration of the application server.

### Important restrictions
Depending on the pattern template you use, do not change some of the component attributes. If you change any of these component attributes, the deployment of patterns that are based on these templates fails.

#### {{ site.data.keys.product }} (Application Center Liberty single node)
Do not change the values for the following attributes in the Liberty profile server:

* WebSphere product Installation directory
* Configuration data location
* Liberty profile server name
* Under Install an IBM Java SDK, select only Java SDK V7.0 or Java SDK V7.1
* Select the Install additional features and clear the selection of IBM WebSphere eXtreme Scale.

#### {{ site.data.keys.product }} (Application Center WebSphere Application Server single node)
Do not change the values for the following attributes in the Liberty profile server:

* WebSphere product Installation directory
* Configuration data location
* Cell name
* Node name
* Profile name
* Under Install an IBM Java SDK, select only Java SDK V7.0 or Java SDK V7.1
* Select the Install additional features and clear the selection of IBM WebSphere eXtreme Scale.

#### {{ site.data.keys.product }} (Liberty single node)
Do not change the values for the following attributes in the Liberty profile server:

* WebSphere product Installation directory
* Configuration data location
* Liberty profile server name
* Under Install an IBM Java SDK, select only Java SDK V7.0 or Java SDK V7.1
* Select the Install additional features and clear the selection of IBM WebSphere eXtreme Scale.

#### {{ site.data.keys.product }} (Liberty server farm)
Do not change the values for the following attributes in the Liberty profile server:

* WebSphere product Installation directory
* Configuration data location
* Liberty profile server name
* Under Install an IBM Java SDK, select only Java SDK V7.0 or Java SDK V7.1
* Select the Install additional features and clear the selection of IBM WebSphere eXtreme Scale.

#### {{ site.data.keys.product }} (WebSphere Application Server single node) template
In the **Standalone server component** of the MobileFirst Platform Server node, do not unlock or change the values for any of the following attributes:

* Cell name
* Node name
* Profile name
* If you change any of these attributes, your pattern deployment fails.

#### {{ site.data.keys.product }} (WebSphere Application Server server farm) template
In the **Standalone server component** of the MobileFirst Platform Server node, do not unlock or change the values for any of the following attributes:

* Cell name
* Node name
* Profile name
* If you change any of these attributes, your pattern deployment fails.

#### {{ site.data.keys.product }} (WebSphere Application Server Network Deployment) template
In the **Deployment manager component** of the **DmgrNode node** or the **Custom nodes component** of the **CustomNode node**, do not unlock or change the values for any of the following attributes:

* Cell name
* Node name
* Profile name

If you change any of these attributes, your pattern deployment fails.

### Limitations
The following limitations apply:

* Dynamic scaling for WebSphere Application Server Liberty profile server farms and WebSphere Application Server full profile server farms is not supported. The number of server farm nodes can be specified in the pattern by setting the scaling policy but cannot be changed during run time.
* The {{ site.data.keys.v63_to_80prerebrand_product_full }} System Pattern Extension for {{ site.data.keys.mf_studio }} and Ant command-line interface that are supported in versions earlier than V7.0, are not available for the current version of {{ site.data.keys.mf_system_pattern }}.
* {{ site.data.keys.mf_system_pattern }} depends on WebSphere Application Server Patterns, which has its own restrictions. For more information, see [Restrictions for WebSphere Application Server Patterns](http://ibm.biz/knowctr#SSAJ7T_1.0.0/com.ibm.websphere.waspatt20base.doc/ae/rins_patternsB_restrictions.html).
* Due to restrictions in the uninstallation of Virtual System Patterns, you must delete the script packages manually after you delete the pattern type. In IBM PureApplication System, go to **Catalog → Script Packages** to delete the script packages that are listed in the **Components** section.
* The MobileFirst (WebSphere Application Server Network Deployment) pattern template does not support token licensing. If you want to use this pattern, you must use perpetual licensing. All other patterns support token licensing.

### Composition
{{ site.data.keys.mf_system_pattern }} is composed of the following patterns:

* IBM WebSphere Application Server Network Deployment Patterns 2.2.0.0.
* [PureApplication Service] WebSphere 8558 for Mobile IM repository to allow the WebSphere Application Server Network Deployment Patterns to work. Contact the administrator for IBM PureApplication System to confirm that the WebSphere 8558 IM repository is installed.
* IBM DB2 with BLU Acceleration  Pattern 1.2.4.0.
* {{ site.data.keys.mf_system_pattern }}.

### Components
In addition to all components provided by IBM WebSphere Application Server Pattern and IBM DB2 with BLU Acceleration Pattern, {{ site.data.keys.mf_system_pattern }} provides the following Script Packages:

* MFP Administration DB
* MFP Runtime DB
* MFP Server Prerequisite
* MFP Server Administration
* MFP Server Runtime Deployment
* MFP Server Application Adapter Deployment
* MFP IHS Configuration
* MFP Analytics
* MFP Open Firewall Ports for WAS
* MFP WAS SDK Level
* MFP Server Application Center

### Compatibility between pattern types and artifacts created with different product versions
If you use MobileFirst Studio V6.3.0 or earlier to develop your applications, you can upload the associated runtime, application, and adapter artifacts into patterns associated with {{ site.data.keys.v63_to_80prerebrand_product_full }} V7.0.0 and later.

Pattern types that are associated with {{ site.data.keys.v63_to_80prerebrand_product_full }} V6.3.0 or earlier are not compatible with runtime, application, and adapter artifacts created by using MobileFirst Studio V7.0.0 and later.

For versions V6.0.0 and earlier, only the same versions of server, **.war** file, application (**.wlapp** file), and adapters are compatible.

## Installing {{ site.data.keys.mf_system_pattern }}
You can find the **{{ site.data.keys.mf_system_pattern_file }}** file. Make sure you extract the file before you start this procedure.

1. Log in to IBM  PureApplication System with an account that has permission to create new pattern types.
2. Go to **Catalog → Pattern Types**.
3. Upload the {{ site.data.keys.mf_system_pattern }} **.tgz** file:
    * On the toolbar, click **+**. The "Install a pattern type" window opens.
    * In the Local tab, click **Browse**, select the {{ site.data.keys.mf_system_pattern }} **.tgz** file, and then wait for the upload process to complete. The pattern type is displayed in the list and is marked as not enabled.
4. In the list of pattern types, click the uploaded pattern type. Details of the pattern type are displayed.
5. In the License Agreement row, click **License**. The License window is displayed stating the terms of the license agreement.
6. To accept the license, click **Accept**. Details of the pattern type now show that the license is accepted.
7. In the Status row, click **Enable**. The pattern type is now listed as being enabled.
8. Mandatory for PureApplication Service: After the pattern type is enabled successfully, go to **Catalog → Script** Packages and select script packages with names similar to "MFP \*\*\*". On the details page to the right, accept the license in the **License agreement** field. Repeat for all eleven script packages listed in the Components section.

## Token licensing requirements for {{ site.data.keys.mf_system_pattern }}
If you use token licensing to license {{ site.data.keys.product }}, you must install IBM  Rational  License Key Server and configure with your licenses before you deploy the {{ site.data.keys.mf_system_pattern_full }}.

> **Important:** The {{ site.data.keys.product }} (WAS ND) pattern template does not support token licensing. You must be using perpetual licensing when you deploy patterns based on the {{ site.data.keys.product }} (WAS ND) pattern template. All other pattern templates support token licensing.

Your IBM Rational License Key Server must be external to your PureApplication  System. {{ site.data.keys.system_pattern }} does not support the PureApplication System shared service for IBM Rational License Key Server.

In addition, you must know the following information about your Rational License Key Server to add the license key server information to your pattern attributes:

* Fully qualified host name or IP address of your Rational License Key Server
* License manager daemon (**lmgrd**) port
* Vendor daemon (**ibmratl**) port

If you have a firewall between your Rational License Key Server and your PureApplication System, ensure that both daemon ports are open in your firewall.
The deployment of {{ site.data.keys.system_pattern }} fails if the license key server cannot be contacted or if insufficient license tokens are available.

For details about installing and configuring Rational License Key Server, see [IBM Support - Rational licensing start page](http://www.ibm.com/software/rational/support/licensing/).

## Deploying {{ site.data.keys.mf_server }} on a single-node WebSphere Application Server Liberty profile server
You use a predefined template to deploy {{ site.data.keys.mf_server }} on a single-node WebSphere  Application Server Liberty profile server.

This procedure involves uploading certain artifacts to IBM  PureApplication  System such as the required application and adapter. Before you begin, ensure that the artifacts are available for upload.

**Token licensing requirements:** If you use token licensing to license {{ site.data.keys.product }}, review the requirements outlined in [Token licensing requirements for {{ site.data.keys.mf_system_pattern }}](#token-licensing-requirements-for-mobilefirst-system-pattern) before you continue. The deployment of this pattern fails if the license key server cannot be contacted or if insufficient license tokens are available.

Some parameters of script packages in the template have been configured with the recommended values and are not mentioned in this section. For fine-tuning purposes, see more information about all the parameters of script packages in [Script packages for {{ site.data.keys.mf_server }}](#script-packages-for-mobilefirst-server).

For more information about the composition and configuration options of the predefined template that is used in this procedure, see [{{ site.data.keys.product }} (Liberty single node) template](#mobilefirst-foundation-liberty-single-node-template).

1. Create a pattern from the predefined template:
    * In the IBM PureApplication System dashboard, click **Patterns → Virtual System Patterns**. The Virtual System Patterns page opens.
    * On the **Virtual System Patterns** page, click **Create New**, and then in the pop-up window, select **MobileFirst Platform (Liberty single node)** from the list of predefined templates. If the name is only partially visible due to its length, you can confirm that the correct template is selected by viewing its description on the **More information** tab.
    * In the **Name** field, provide a name for the pattern.
    * In the **Version** field, specify the version number of the pattern.
    * Click **Start Building**.
2. Mandatory for AIX : In IBM PureApplication System running on Power , the MobileFirst Platform DB node needs to use the AIX-specific add-on component "Default AIX add disk" to replace the "Default add disk" component in the template to support the jfs2 file system:
    * In the Pattern Builder, select the **MobileFirst Platform DB** node.
    * Click the **Add a Component Add-on** button (the button is visible above the component box when you hover the cursor over the **MobileFirst Platform DB** node).
    * From the **Add Add-ons** list, select **Default AIX add disk**. The component is added as the lowest component of the MobileFirst Platform DB node.
    * Select the **Default AIX add disk** component and specify the following attributes:
        * **DISK_SIZE_GB:** Storage size (measured in GB) to be extended to the DB server. Example value: **10**.
        * **FILESYSTEM_TYPE:** Supported file system in AIX. Default value: **jfs2**.
        * **MOUNT_POINT:** Align with the attribute **Mount point for instance owner** in the Database Server component in the MobileFirst Platform DB node. Example value: **/dbinst**.
        * **VOLUME_GROUP:** Example value: **group1**. Contact your IBM PureApplication System administrator for the correct value.
    * In the MobileFirst Platform DB node, select the **Default add disk** component, and then click the bin icon to delete it.
    * Save the pattern.
3. Optional: Configure {{ site.data.keys.mf_server }} administration. You can skip this step if you want to specify the user credential with {{ site.data.keys.mf_server }} administration privilege later during the pattern deployment configuration phase in step 9. To specify it now, complete these steps:

    > **Note:** If you want to configure administration security with an LDAP server, you need to supply additional LDAP information. For more information, see [Configuring {{ site.data.keys.product_adj }} administration security with an external LDAP repository](#configuring-mobilefirst-administration-security-with-an-external-ldap-repository).
    * In the MobileFirst Platform Server node, click the **MFP Server Administration** component. The properties of the selected component are displayed next to the canvas.
    * Next to the **admin_user** and **admin_password** fields, click the Delete button to clear their pattern level parameter settings.
    * In the **admin_user** and **admin\_password** fields, specify the administration user name and password.
    * If you use token licensing to license {{ site.data.keys.product }}, complete the following fields. If you do not use token licensing, leave these fields blank.

    **ACTIVATE\_TOKEN\_LICENSE**: Select this field to license your pattern with token licensing.  
    **LICENSE\_SERVER\_HOSTNAME**: Enter the fully qualified host name or IP address of your Rational License Key Server.  
    **LMGRD\_PORT**: Enter the port number that the license manager daemon (**lmrgd**) listens for connections on. The default license manager daemon port is 27000.  
    **IBMRATL\_PORT**:Enter the port number that the vendor daemon (**ibmratl**) listens for connections on. The default vendor daemon port is typically 27001.  

    A default administration account for {{ site.data.keys.mf_server }} is created during pattern deployment.

4. Optional: Configure {{ site.data.keys.mf_server }} runtime deployment. You can skip this step if you want to specify the context root name for the runtime later during the pattern deployment configuration phase in step 9. To specify the context root name now, complete these steps:
    * In the MobileFirst Platform Server node, click the **MFP Server Runtime Deployment** component. The properties of the selected component are displayed next to the canvas.
    * Next to the **runtime\_contextRoot** field, click the **Delete** button to clear the pattern level parameter setting.
    * In the **runtime\_contextRoot** field, specify the runtime context root name. Note that the context root name must start with a forward slash, /; for example, `/HelloWorld`.

5. Upload application and adapter artifacts:

    > **Important:** When specifying the Target path for applications and adapters, make sure all the applications and adapters are placed in the same directory. For example, if one target path is **/opt/tmp/deploy/HelloWorld-common.json**, all the other target paths should be `/opt/tmp/deploy/*`.
    * In the MobileFirst Platform Server node, click the **MFP Server Application** or **MFP Server Adapter** component. The properties of the selected component are displayed next to the canvas.
    * In the **Additional file** field, click the **Browse** button to locate and upload the application or adapter artifact.
    * In the **Target path** field, specify the full path for storing the artifact including its file name; for example, **/opt/tmp/deploy/HelloWorld-common.json**.
    * If no application or adapter is to be deployed in the pattern, remove the relevant component by clicking the **X** button inside it. To get an empty {{ site.data.keys.mf_console }} deployed without any app or adapter installed, remove the MFP Server Application Adapter Deployment component by clicking the X button inside it.

6. Optional: Add more application or adapter artifacts for deployment:
    * From the **Assets** toolbar, expand **Software Components**, and then drag and drop an **Additional file** component onto the MobileFirst Platform Server node in the canvas. Rename it to **{{ site.data.keys.product_adj }} App\_X** or **{{ site.data.keys.product_adj }} Adatper\_X** (where **X** stands for a unique number for differentiation).
    * Hover the cursor over the newly added App or Adapter component, and then click the **Move Up** and **Move Down** buttons to adjust its sequence in the node. Make sure it is placed after the MFP Runtime Deployment component but before the MFP Server Application Adapter Deployment component.
    * Click the newly added application or adapter component. The properties of the selected component are displayed next to the canvas. Upload the application or adapter artifact and specify its target path by referring to the steps in step 6.
    * Repeat step 7 to add more applications and adapters for deployment.

7. Optional: Configure application and adapter deployment to {{ site.data.keys.mf_server }}. You can skip this step if you want to specify the user credential with deployment privilege later during the pattern deployment configuration phase in step 9. If you have specified the default admin user credential in step 3, you can now specify the deployer user, which must align with the admin user credential:
    * In the MobileFirst Platform Server node, select the **MFP Server Application Adapter Deployment** component. The properties of the selected component are displayed next to the canvas.
    * Find the parameters named **deployer_user** and **deployer_password**, and then click the adjacent Delete buttons to clear the pattern level parameter settings.
    * In the **deployer\_user** and **deployer\_password** fields, specify the user name and password.

8. Configure and launch the pattern deployment:
    * In the IBM PureApplication System dashboard, click **Patterns → Virtual System Patterns**.
    * On the **Virtual System Patterns** page, use the **Search** field to find the pattern you created, and then select the pattern.
    * In the toolbar above the panel displaying detailed information about the pattern, click the Deploy button.
    * In the Deploy Pattern window, in the Configure panel, select the correct environment profile from the **Environment Profile** list, and provide other IBM PureApplication System environment parameters. To obtain the correct information, consult your IBM PureApplication System administrator.
    * In the middle column, click **Pattern attributes** to display attributes such as user names and passwords.

        Supply the following information in the fields provided:

        > **Note:** Make appropriate changes to the default values of the pattern-level parameters even if an external LDAP server is configured. If you configure administration security by using an LDAP server, you need to supply additional LDAP information. For more information, see [Configuring {{ site.data.keys.product_adj }} administration security with an external LDAP repository](#configuring-mobilefirst-administration-security-with-an-external-ldap-repository).
        
        **admin\_user**  
        Not visible if configured in step 3. Create a default {{ site.data.keys.mf_server }} administrator account. Default value: demo.
        
        **admin\_password**  
        Not visible if configured in step 3. Default admin account password. Default value: demo.
        
        **ACTIVATE\_TOKEN\_LICENSE**  
        Not visible if configured in step 3. Select this field to license your pattern with token licensing. Leave this field clear if you use perpetual licenses.
        
        **LICENSE\_SERVER\_HOSTNAME**  
        Not visible if configured in step 3. If you use token licensing to license {{ site.data.keys.product }}, enter the fully-qualified hostname or IP address of your Rational License Key Server IP address. Otherwise, leave this field blank.
        
        **LMGRD\_PORT**   
        Not visible if configured in step 3. If you use token licensing to license {{ site.data.keys.product }}, enter the port number that the license manager daemon (lmrgd) listens for connections on. Otherwise, leave this field blank.
        The default license manager daemon port is 27000.

        **IBMRATL\_PORT**  
        Not visible if configured in step 3. If you use token licensing to license {{ site.data.keys.product }}, enter the port number that the vendor daemon (ibmratl) listens for connections on. Otherwise, leave this field blank.
        The default vendor daemon port is typically 27001.

        **runtime\_contextRoot**  
        Not visible if configured in step 5. Context root name for the {{ site.data.keys.mf_server }} runtime. The name must start with "/".
        
        **deployer\_user**  
        Not visible if configured in step 8. User name for the account with deployment privilege. If an external LDAP server is not configured, you must enter the same value as was specified when creating the default admin user for the administration service, because in this case, the only authorized user for app and adapter deployment is the default admin user.
        
        **deployer\_password**  
        Not visible if configured in step 8. User password for the user with deployment privilege.
        
        **MFP Vms Password(root)**  
        Root password for {{ site.data.keys.mf_server }} and {{ site.data.keys.product }} DB nodes. Default value: passw0rd.
        
        **MFP DB Password(Instance owner)**  
        Instance owner password for the MobileFirst Platform DB node. Default value: **passw0rd**.    
    * Click **Quick Deploy** to launch your pattern deployment. After a few seconds, a message is displayed to indicate that the pattern has started to launch. You can click the URL provided in the message to track your pattern deployment status or go to **Patterns → Virtual System Instances** to open the Virtual System Instances page and search for your pattern there.

    If you use token licensing to license {{ site.data.keys.product }}, your pattern will fail to deploy if insufficient license tokens are available or if the license key server IP address and port were entered incorrectly.

9. Access the {{ site.data.keys.mf_console }}:
    * Click **Patterns → Virtual System Instances** to open the Virtual System Instances page and search for your pattern there. Make sure it is in Running state.
    * Select the pattern name and expand the **Virtual machine perspective** option in the panel displaying details of the selected instance.
    * Find the {{ site.data.keys.mf_server }} VM that has a name similar to **MobileFirst\_Platform\_Server.** and make a note of its Public IP address: you need this information in the following step.
    * In the browser, open the {{ site.data.keys.mf_console }} by composing its URL with one of the following formats:
        * `http://{MFP Server VM Public IP}:9080/mfpconsole`
        * `https://{MFP Server VM Public IP}:9443/mfpconsole`
    * Log in to the Console with admin user and password specified in step 3 or step 9.

## Deploying {{ site.data.keys.mf_server }} on a multiple-node WebSphere Application Server Liberty profile server
You use a predefined template to deploy {{ site.data.keys.mf_server }} on a multiple-node WebSphere  Application Server Liberty profile server.

This procedure involves uploading certain artifacts to IBM  PureApplication  System such as the required application and adapter. Before you begin, ensure that the artifacts are available for upload.

**Token licensing requirements:** If you use token licensing to license {{ site.data.keys.product }}, review the requirements outlined in [Token licensing requirements for {{ site.data.keys.mf_system_pattern }}](#token-licensing-requirements-for-mobilefirst-system-pattern) before you continue. The deployment of this pattern fails if the license key server cannot be contacted or if insufficient license tokens are available.

Some parameters of script packages in the template have been configured with the recommended values and are not mentioned in this section. For fine-tuning purposes, see more information about all the parameters of script packages in [Script packages for {{ site.data.keys.mf_server }}](#script-packages-for-mobilefirst-server).

For more information about the composition and configuration options of the predefined template that is used in this procedure, see [{{ site.data.keys.product }} (Liberty server farm) template](#mobilefirst-foundation-liberty-server-farm-template).

1. Create a pattern from the predefined template:
    * In the IBM PureApplication System dashboard, click **Patterns → Virtual System Patterns**. The **Virtual System Patterns** page opens.
    * On the **Virtual System Patterns** page, click **Create New**, and then in the pop-up window, select **MobileFirst Platform (Liberty server farm)** from the list of predefined templates. If the name is only partially visible due to its length, you can confirm that the correct template is selected by viewing its description on the **More information** tab.
    * In the **Name** field, provide a name for the pattern.
    * In the **Version** field, specify the version number of the pattern.
    * Click **Start Building**.
2. Mandatory for AIX : In IBM PureApplication System running on Power , the MobileFirst Platform DB node needs to use the AIX-specific add-on component "Default AIX add disk" to replace the "Default add disk" component in the template to support the **jfs2** file system:
    * In the Pattern Builder, select the **MobileFirst Platform DB** node.
    * Click the **Add a Component Add-on** button (the button is visible above the component box when you hover the cursor over the **MobileFirst Platform DB** node).
    * From the **Add Add-ons** list, select **Default AIX add disk**. The component is added as the lowest component of the MobileFirst Platform DB node.
    * Select the **Default AIX add disk** component and specify the following attributes:
        * **DISK_SIZE_GB:** Storage size (measured in GB) to be extended to the DB server. Example value: **10**.
        * **FILESYSTEM_TYPE:** Supported file system in AIX. Default value: **jfs2**.
        * **MOUNT_POINT:** Align with the attribute **Mount point for instance owner** in the Database Server component in the MobileFirst Platform DB node. Example value: **/dbinst**.
        * **VOLUME_GROUP:** Example value: **group1**. Contact your IBM PureApplication System administrator for the correct value.
    * In the MobileFirst Platform DB node, select the **Default add disk** component, and then click the bin icon to delete it.
    * Save the pattern.
3. Optional: Configure {{ site.data.keys.mf_server }} administration. You can skip this step if you want to specify the user credential with {{ site.data.keys.mf_server }} administration privilege later during the pattern deployment configuration phase in step 9. To specify it now, complete these steps:

    > **Note:** If you want to configure administration security with an LDAP server, you need to supply additional LDAP information. For more information, see [Configuring {{ site.data.keys.product_adj }} administration security with an external LDAP repository](#configuring-mobilefirst-administration-security-with-an-external-ldap-repository).
    * In the MobileFirst Platform Server node, click the **MFP Server Administration** component. The properties of the selected component are displayed next to the canvas.
    * Next to the **admin_user** and **admin_password** fields, click the Delete button to clear their pattern level parameter settings.
    * In the **admin_user** and **admin\_password** fields, specify the administration user name and password.
    * If you use token licensing to license {{ site.data.keys.product }}, complete the following fields. If you do not use token licensing, leave these fields blank.

    **ACTIVATE\_TOKEN\_LICENSE**: Select this field to license your pattern with token licensing.  
    **LICENSE\_SERVER\_HOSTNAME**: Enter the fully qualified host name or IP address of your Rational License Key Server.  
    **LMGRD\_PORT**: Enter the port number that the license manager daemon (**lmrgd**) listens for connections on. The default license manager daemon port is 27000.  
    **IBMRATL\_PORT**:Enter the port number that the vendor daemon (**ibmratl**) listens for connections on. The default vendor daemon port is typically 27001.  

    A default administration account for {{ site.data.keys.mf_server }} is created during pattern deployment.
    
4. Optional: Configure {{ site.data.keys.mf_server }} runtime deployment. You can skip this step if you want to specify the context root name for the runtime later during the pattern deployment configuration phase in step 10. To specify the context root name now, complete these steps:
    * In the MobileFirst Platform Server node, click the **MFP Server Runtime Deployment** component. The properties of the selected component are displayed next to the canvas.
    * Next to the **runtime\_contextRoot** field, click the **Delete** button to clear the pattern level parameter setting.
    * In the **runtime\_contextRoot** field, specify the runtime context root name. Note that the context root name must start with a forward slash, /; for example, `/HelloWorld`.

5. Upload application and adapter artifacts:

    > **Important:** When specifying the Target path for applications and adapters, make sure all the applications and adapters are placed in the same directory. For example, if one target path is **/opt/tmp/deploy/HelloWorld-common.json**, all the other target paths should be `/opt/tmp/deploy/*`.
    * In the MobileFirst Platform Server node, click the **MFP Server Application** or **MFP Server Adapter** component. The properties of the selected component are displayed next to the canvas.
    * In the **Additional file** field, click the **Browse** button to locate and upload the application or adapter artifact.
    * In the **Target path** field, specify the full path for storing the artifact including its file name; for example, **/opt/tmp/deploy/HelloWorld-common.json**.
    * If no application or adapter is to be deployed in the pattern, remove the relevant component by clicking the **X** button inside it. To get an empty {{ site.data.keys.mf_console }} deployed without any app or adapter installed, remove the MFP Server Application Adapter Deployment component by clicking the X button inside it. 

6. Optional: Add more application or adapter artifacts for deployment:
    * From the **Assets** toolbar, expand **Software Components**, and then drag and drop an **Additional file** component onto the MobileFirst Platform Server node in the canvas. Rename it **{{ site.data.keys.product_adj }} App\_X** or **{{ site.data.keys.product_adj }} Adatper\_X** (where **X** stands for a unique number for differentiation).
    * Hover the cursor over the newly added App or Adapter component, and then click the **Move Up** and **Move Down** buttons to adjust its sequence in the node. Make sure it is placed after the MFP Runtime Deployment component but before the MFP Server Application Adapter Deployment component.
    * Click the newly added application or adapter component. The properties of the selected component are displayed next to the canvas. Upload the application or adapter artifact and specify its target path by referring to the steps in step 6.
    * Repeat step 7 to add more applications and adapters for deployment.

7. Optional: Configure application and adapter deployment to {{ site.data.keys.mf_server }}. You can skip this step if you want to specify the user credential with deployment privilege later during the pattern deployment configuration phase in step 9. If you have specified the default admin user credential in step 3, you can now specify the deployer user, which must align with the admin user credential:
    * In the MobileFirst Platform Server node, select the **MFP Server Application Adapter Deployment** component. The properties of the selected component are displayed next to the canvas.
    * Find the parameters named **deployer_user** and **deployer_password**, and then click the adjacent Delete buttons to clear the pattern level parameter settings.
    * In the **deployer\_user** and **deployer\_password** fields, specify the user name and password.

8. Configure base scaling policy:
    * In the MobileFirst Platform Server node, select the **Base Scaling Policy** component. The properties of the selected component are displayed next to the canvas.
    * In the **Number of Instances** field, specify the number of server nodes to be instantiated during pattern deployment. The default value is 2 in the predefined template. Because dynamic scaling is not supported in this release, do not specify values in the remaining attribute fields.

9. Configure and launch the pattern deployment:
    * In the IBM PureApplication System dashboard, click **Patterns → Virtual System Patterns**.
    * On the **Virtual System Patterns** page, use the **Search** field to find the pattern you created, and then select the pattern.
    * In the toolbar above the panel displaying detailed information about the pattern, click the Deploy button.
    * In the Deploy Pattern window, in the Configure panel, select the correct environment profile from the **Environment Profile** list, and provide other IBM PureApplication System environment parameters. To obtain the correct information, consult your IBM PureApplication System administrator.
    * In the middle column, click **Pattern attributes** to display attributes such as user names and passwords.

        Supply the following information in the fields provided:

        > **Note:** Make appropriate changes to the default values of the pattern-level parameters even if an external LDAP server is configured. If you configure administration security by using an LDAP server, you need to supply additional LDAP information. For more information, see [Configuring {{ site.data.keys.product_adj }} administration security with an external LDAP repository](#configuring-mobilefirst-administration-security-with-an-external-ldap-repository).
        
        **admin\_user**  
        Not visible if configured in step 3. Create a default {{ site.data.keys.mf_server }} administrator account. Default value: demo.
        
        **admin\_password**  
        Not visible if configured in step 3. Default admin account password. Default value: demo.
        
        **ACTIVATE\_TOKEN\_LICENSE**  
        Not visible if configured in step 3. Select this field to license your pattern with token licensing. Leave this field clear if you use perpetual licenses.
        
        **LICENSE\_SERVER\_HOSTNAME**  
        Not visible if configured in step 3. If you use token licensing to license {{ site.data.keys.product }}, enter the fully-qualified hostname or IP address of your Rational License Key Server IP address. Otherwise, leave this field blank.
        
        **LMGRD\_PORT**   
        Not visible if configured in step 3. If you use token licensing to license {{ site.data.keys.product }}, enter the port number that the license manager daemon (lmrgd) listens for connections on. Otherwise, leave this field blank.
        The default license manager daemon port is 27000.

        **IBMRATL\_PORT**  
        Not visible if configured in step 3. If you use token licensing to license {{ site.data.keys.product }}, enter the port number that the vendor daemon (ibmratl) listens for connections on. Otherwise, leave this field blank.
        The default vendor daemon port is typically 27001.

        **runtime\_contextRoot**  
        Not visible if configured in step 5. Context root name for the {{ site.data.keys.mf_server }} runtime. The name must start with "/".
        
        **deployer\_user**  
        Not visible if configured in step 8. User name for the account with deployment privilege. If an external LDAP server is not configured, you must enter the same value as was specified when creating the default admin user for the administration service, because in this case, the only authorized user for app and adapter deployment is the default admin user.
        
        **deployer\_password**  
        Not visible if configured in step 8. User password for the user with deployment privilege.
        
        **MFP Vms Password(root)**  
        Root password for the {{ site.data.keys.mf_server }} and {{ site.data.keys.product }} DB nodes. Default value: passw0rd.
        
        **MFP DB Password(Instance owner)**  
        Instance owner password for the MobileFirst Platform DB node. Default value: **passw0rd**.    
    * Click **Quick Deploy** to launch your pattern deployment. After a few seconds, a message is displayed to indicate that the pattern has started to launch. You can click the URL provided in the message to track your pattern deployment status or go to **Patterns → Virtual System Instances** to open the Virtual System Instances page and search for your pattern there.

    If you use token licensing to license {{ site.data.keys.product }}, your pattern will fail to deploy if insufficient license tokens are available or if the license key server IP address and port were entered incorrectly.
    
10. Access the {{ site.data.keys.mf_console }}:
    * Click **Patterns → Virtual System Instances** to open the Virtual System Instances page and search for your pattern there. Make sure it is in Running state.
    * Select the pattern name and expand the **Virtual machine perspective** option in the panel displaying details of the selected instance.
    * Find the IHS Server VM that has a name similar to **IHS\_Server.*** and make a note of its Public IP address: you need this information in the following step.
    * In the browser, open the {{ site.data.keys.mf_console }} by composing its URL with one of the following formats:
        * `http://{IHS Server VM Public IP}/mfpconsole`
        * `https://{IHS Server VM Public IP}/mfpconsole`
    * Log in to the Console with the admin user ID and password specified in step 3 or step 10.

## Deploying {{ site.data.keys.mf_server }} on a single-node WebSphere Application Server full profile server
You use a predefined template to deploy a single-node {{ site.data.keys.mf_server }} to a WebSphere  Application Server full profile server.

This procedure involves uploading certain artifacts to IBM  PureApplication  System such as the required application and adapter. Before you begin, ensure that the artifacts are available for upload.

**Token licensing requirements:** If you use token licensing to license {{ site.data.keys.product }}, review the requirements outlined in [Token licensing requirements for {{ site.data.keys.mf_system_pattern }}](#token-licensing-requirements-for-mobilefirst-system-pattern) before you continue. The deployment of this pattern fails if the license key server cannot be contacted or if insufficient license tokens are available.

Some parameters of script packages in the template have been configured with the recommended values and are not mentioned in this section. For fine-tuning purposes, see more information about all the parameters of script packages in [Script packages for {{ site.data.keys.mf_server }}](#script-packages-for-mobilefirst-server).

For more information about the composition and configuration options of the predefined template that is used in this procedure, see [{{ site.data.keys.product }} (WAS single node) template](#mobilefirst-foundation-was-single-node-template).

1. Create a pattern from the predefined template:
    * In the IBM PureApplication System dashboard, click **Patterns → Virtual System Patterns**. The **Virtual System Patterns** page opens.
    * On the **Virtual System Patterns** page, click **Create New**, and then in the pop-up window, select **MobileFirst Platform (WAS single node)** from the list of predefined templates. If the name is only partially visible due to its length, you can confirm that the correct template is selected by viewing its description on the **More information** tab.
    * In the **Name** field, provide a name for the pattern.
    * In the **Version** field, specify the version number of the pattern.
    * Click **Start Building**.
2. Mandatory for AIX : In IBM PureApplication System running on Power , the MobileFirst Platform DB node needs to use the AIX-specific add-on component "Default AIX add disk" to replace the "Default add disk" component in the template to support the **jfs2** file system:
    * In the Pattern Builder, select the **MobileFirst Platform DB** node.
    * Click the **Add a Component Add-on** button (the button is visible above the component box when you hover the cursor over the **MobileFirst Platform DB** node).
    * From the **Add Add-ons** list, select **Default AIX add disk**. The component is added as the lowest component of the MobileFirst Platform DB node.
    * Select the **Default AIX add disk** component and specify the following attributes:
        * **DISK_SIZE_GB:** Storage size (measured in GB) to be extended to the DB server. Example value: **10**.
        * **FILESYSTEM_TYPE:** Supported file system in AIX. Default value: **jfs2**.
        * **MOUNT_POINT:** Align with the attribute **Mount point for instance owner** in the Database Server component in the MobileFirst Platform DB node. Example value: **/dbinst**.
        * **VOLUME_GROUP:** Example value: **group1**. Contact your IBM PureApplication System administrator for the correct value.
    * In the MobileFirst Platform DB node, select the **Default add disk** component, and then click the bin icon to delete it.
    * Save the pattern.
3. Optional: Configure {{ site.data.keys.mf_server }} administration. You can skip this step if you want to specify the user credential with {{ site.data.keys.mf_server }} administration privilege later during the pattern deployment configuration phase in step 9. To specify it now, complete these steps:

    > **Note:** If you want to configure administration security with an LDAP server, you need to supply additional LDAP information. For more information, see [Configuring {{ site.data.keys.product_adj }} administration security with an external LDAP repository](#configuring-mobilefirst-administration-security-with-an-external-ldap-repository).
    * In the MobileFirst Platform Server node, click the **MFP Server Administration** component. The properties of the selected component are displayed next to the canvas.
    * Next to the **admin_user** and **admin_password** fields, click the Delete button to clear their pattern level parameter settings.
    * In the **admin_user** and **admin\_password** fields, specify the administration user name and password.
    * If you use token licensing to license {{ site.data.keys.product }}, complete the following fields. If you do not use token licensing, leave these fields blank.

    **ACTIVATE\_TOKEN\_LICENSE**: Select this field to license your pattern with token licensing.  
    **LICENSE\_SERVER\_HOSTNAME**: Enter the fully qualified host name or IP address of your Rational License Key Server.  
    **LMGRD\_PORT**: Enter the port number that the license manager daemon (**lmrgd**) listens for connections on. The default license manager daemon port is 27000.  
    **IBMRATL\_PORT**:Enter the port number that the vendor daemon (**ibmratl**) listens for connections on. The default vendor daemon port is typically 27001.  

    A default administration account for {{ site.data.keys.mf_server }} is created during pattern deployment.

4. Optional: Configure {{ site.data.keys.mf_server }} runtime deployment. You can skip this step if you want to specify the context root name for the runtime later during the pattern deployment configuration phase in step 9. To specify the context root name now, complete these steps:
    * In the MobileFirst Platform Server node, click the **MFP Server Runtime Deployment** component. The properties of the selected component are displayed next to the canvas.
    * Next to the **runtime\_contextRoot** field, click the **Delete** button to clear the pattern level parameter setting.
    * In the **runtime\_contextRoot** field, specify the runtime context root name. Note that the context root name must start with a forward slash, /; for example, `/HelloWorld`.

5. Upload application and adapter artifacts:

    > **Important:** When specifying the Target path for applications and adapters, make sure all the applications and adapters are placed in the same directory. For example, if one target path is **/opt/tmp/deploy/HelloWorld-common.json**, all the other target paths should be `/opt/tmp/deploy/*`.
    * In the MobileFirst Platform Server node, click the **MFP Server Application** or **MFP Server Adapter** component. The properties of the selected component are displayed next to the canvas.
    * In the **Additional file** field, click the **Browse** button to locate and upload the application or adapter artifact.
    * In the **Target path** field, specify the full path for storing the artifact including its file name; for example, **/opt/tmp/deploy/HelloWorld-common.json**.
    * If no application or adapter is to be deployed in the pattern, remove the relevant component by clicking the **X** button inside it. To get an empty {{ site.data.keys.mf_console }} deployed without any app or adapter installed, remove the MFP Server Application Adapter Deployment component by clicking the X button inside it. 

6. Optional: Add more application or adapter artifacts for deployment:
    * From the **Assets** toolbar, expand **Software Components**, and then drag and drop an **Additional file** component onto the MobileFirst Platform Server node in the canvas. Rename it **{{ site.data.keys.product_adj }} App\_X** or **{{ site.data.keys.product_adj }} Adatper\_X** (where **X** stands for a unique number for differentiation).
    * Hover the cursor over the newly added App or Adapter component, and then click the **Move Up** and **Move Down** buttons to adjust its sequence in the node. Make sure it is placed after the MFP Runtime Deployment component but before the MFP Server Application Adapter Deployment component.
    * Click the newly added application or adapter component. The properties of the selected component are displayed next to the canvas. Upload the application or adapter artifact and specify its target path by referring to the steps in step 6.
    * Repeat step 7 to add more applications and adapters for deployment.

7. Optional: Configure application and adapter deployment to {{ site.data.keys.mf_server }}. You can skip this step if you want to specify the user credential with deployment privilege later during the pattern deployment configuration phase in step 9. If you have specified the default admin user credential in step 3, you can now specify the deployer user, which must align with the admin user credential:
    * In the MobileFirst Platform Server node, select the **MFP Server Application Adapter Deployment** component. The properties of the selected component are displayed next to the canvas.
    * Find the parameters named **deployer_user** and **deployer_password**, and then click the adjacent Delete buttons to clear the pattern level parameter settings.
    * In the **deployer\_user** and **deployer\_password** fields, specify the user name and password.

8. Configure base scaling policy:
    * In the IBM PureApplication System dashboard, click **Patterns → Virtual System Patterns**.
    * On the **Virtual System Patterns** page, use the Search field to find the pattern you created, and then select the pattern.
    * In the toolbar above the panel displaying detailed information about the pattern, click the **Deploy** button.
    * In the **Deploy Pattern** window, in the **Configure** panel, select the correct **Environment Profile** and other IBM PureApplication System environment parameters by consulting your IBM PureApplication System administrator.
    * In the middle column, click **Pattern attributes** to set attributes such as user name and passwords.

        Supply the following information in the fields provided:
        
        > **Note:** Make appropriate changes to the default values of the pattern-level parameters even if an external LDAP server is configured. If you configure administration security by using an LDAP server, you need to supply additional LDAP information. For more information, see [Configuring {{ site.data.keys.product_adj }} administration security with an external LDAP repository](#configuring-mobilefirst-administration-security-with-an-external-ldap-repository).

        **WebSphere administrative user name**  
        Admin user ID for WebSphere administration console login. Default value: virtuser.

        **WebSphere administrative password**  
        Admin user password for WebSphere administration console login. Default value: passw0rd.
        
        **admin\_user**  
        Not visible if configured in step 3. Create a default {{ site.data.keys.mf_server }} administrator account. Default value: demo.
        
        **admin\_password**  
        Not visible if configured in step 3. Default admin account password. Default value: demo.
        
        **ACTIVATE\_TOKEN\_LICENSE**  
        Not visible if configured in step 3. Select this field to license your pattern with token licensing. Leave this field clear if you use perpetual licenses.
        
        **LICENSE\_SERVER\_HOSTNAME**  
        Not visible if configured in step 3. If you use token licensing to license {{ site.data.keys.product }}, enter the fully-qualified hostname or IP address of your Rational License Key Server IP address. Otherwise, leave this field blank.
        
        **LMGRD\_PORT**   
        Not visible if configured in step 3. If you use token licensing to license {{ site.data.keys.product }}, enter the port number that the license manager daemon (lmrgd) listens for connections on. Otherwise, leave this field blank.
        The default license manager daemon port is 27000.

        **IBMRATL\_PORT**  
        Not visible if configured in step 3. If you use token licensing to license {{ site.data.keys.product }}, enter the port number that the vendor daemon (ibmratl) listens for connections on. Otherwise, leave this field blank.
        The default vendor daemon port is typically 27001.

        **runtime\_contextRoot**  
        Not visible if configured in step 5. Context root name for the {{ site.data.keys.mf_server }} runtime. The name must start with "/".
        
        **deployer\_user**  
        Not visible if configured in step 8. User name for the account with deployment privilege. If an external LDAP server is not configured, you must enter the same value as was specified when creating the default admin user for the administration service, because in this case, the only authorized user for app and adapter deployment is the default admin user.
        
        **deployer\_password**  
        Not visible if configured in step 8. User password for the user with deployment privilege.
        
        **MFP Vms Password(root)**  
        Root password for the {{ site.data.keys.mf_server }} and {{ site.data.keys.product }} DB nodes. Default value: passw0rd.
        
        **MFP DB Password(Instance owner)**  
        Instance owner password for the MobileFirst Platform DB node. Default value: **passw0rd**.

        **Important restriction:**  
        When you set these attrbutes, do not change the following attributes in the {{ site.data.keys.mf_server }} section:
        
        * Cell name
        * Node name
        * Profile name

        If you change any of these attributes, your pattern deployment will fail.
    * Click **Quick Deploy** to launch your pattern deployment. After a few seconds, a message is displayed to indicate that the pattern has started to launch. You can click the URL provided in the message to track your pattern deployment status or go to **Patterns → Virtual System Instances** to open the **Virtual System Instances** page and search for your pattern there.

9. Access the {{ site.data.keys.mf_console }}:
    * Click **Patterns → Virtual System Instances** to open the Virtual System Instances page and search for your pattern there. Make sure it is in Running state.
    * Select the pattern name and expand the **Virtual machine perspective** option in the panel displaying details of the selected instance.
    * Find the {{ site.data.keys.mf_server }} VM that has a name similar to **MobileFirst\_Platform\_Server.** and make a note of its Public IP address: you need this information in the following step.
    * In the browser, open the {{ site.data.keys.mf_console }} by composing its URL with one of the following formats:
        * `http://{MFP Server VM Public IP}:9080/mfpconsole`
        * `https://{MFP Server VM Public IP}:9443/mfpconsole`
    * Log in to the Console with admin user and password specified in step 3 or step 9.

## Deploying {{ site.data.keys.mf_server }} on a multiple-node WebSphere Application Server full profile server
You use a predefined template to deploy {{ site.data.keys.mf_server }} on a multiple-node WebSphere  Application Server full profile server.

This procedure involves uploading certain artifacts to IBM  PureApplication  System such as the required application and adapter. Before you begin, ensure that the artifacts are available for upload.

**Token licensing requirements:** If you use token licensing to license {{ site.data.keys.product }}, review the requirements outlined in [Token licensing requirements for {{ site.data.keys.mf_system_pattern }}](#token-licensing-requirements-for-mobilefirst-system-pattern) before you continue. The deployment of this pattern fails if the license key server cannot be contacted or if insufficient license tokens are available.

Some parameters of script packages in the template have been configured with the recommended values and are not mentioned in this section. For fine-tuning purposes, see more information about all the parameters of script packages in [Script packages for {{ site.data.keys.mf_server }}](#script-packages-for-mobilefirst-server).

For more information about the composition and configuration options of the predefined template that is used in this procedure, see [{{ site.data.keys.product }} (WAS server farm) template](#mobilefirst-foundation-was-server-farm-template).

1. Create a pattern from the predefined template:
    * In the IBM PureApplication System dashboard, click **Patterns → Virtual System Patterns**. The Virtual System Patterns page opens.
    * On the **Virtual System Patterns** page, click **Create New**, and then in the pop-up window, select **MobileFirst Platform (WAS server farm)** from the list of predefined templates. If the name is only partially visible due to its length, you can confirm that the correct template is selected by viewing its description on the **More information** tab.
    * In the **Name** field, provide a name for the pattern.
    * In the **Version** field, specify the version number of the pattern.
    * Click **Start Building**.
2. Mandatory for AIX : In IBM PureApplication System running on Power , the MobileFirst Platform DB node needs to use the AIX-specific add-on component "Default AIX add disk" to replace the "Default add disk" component in the template to support the jfs2 file system:
    * In the Pattern Builder, select the **MobileFirst Platform DB** node.
    * Click the **Add a Component Add-on** button (the button is visible above the component box when you hover the cursor over the **MobileFirst Platform DB** node).
    * From the **Add Add-ons** list, select **Default AIX add disk**. The component is added as the lowest component of the MobileFirst Platform DB node.
    * Select the **Default AIX add disk** component and specify the following attributes:
        * **DISK_SIZE_GB:** Storage size (measured in GB) to be extended to the DB server. Example value: **10**.
        * **FILESYSTEM_TYPE:** Supported file system in AIX. Default value: **jfs2**.
        * **MOUNT_POINT:** Align with the attribute **Mount point for instance owner** in the Database Server component in the MobileFirst Platform DB node. Example value: **/dbinst**.
        * **VOLUME_GROUP:** Example value: **group1**. Contact your IBM PureApplication System administrator for the correct value.
    * In the MobileFirst Platform DB node, select the **Default add disk** component, and then click the bin icon to delete it.
    * Save the pattern.
3. Optional: Configure {{ site.data.keys.mf_server }} administration. You can skip this step if you want to specify the user credential with {{ site.data.keys.mf_server }} administration privilege later during the pattern deployment configuration phase in step 9. To specify it now, complete these steps:

    > **Note:** If you want to configure administration security with an LDAP server, you need to supply additional LDAP information. For more information, see [Configuring {{ site.data.keys.product_adj }} administration security with an external LDAP repository](#configuring-mobilefirst-administration-security-with-an-external-ldap-repository).
    * In the MobileFirst Platform Server node, click the **MFP Server Administration** component. The properties of the selected component are displayed next to the canvas.
    * Next to the **admin_user** and **admin_password** fields, click the Delete button to clear their pattern level parameter settings.
    * In the **admin_user** and **admin\_password** fields, specify the administration user name and password.
    * If you use token licensing to license {{ site.data.keys.product }}, complete the following fields. If you do not use token licensing, leave these fields blank.

    **ACTIVATE\_TOKEN\_LICENSE**: Select this field to license your pattern with token licensing.  
    **LICENSE\_SERVER\_HOSTNAME**: Enter the fully qualified host name or IP address of your Rational License Key Server.  
    **LMGRD\_PORT**: Enter the port number that the license manager daemon (**lmrgd**) listens for connections on. The default license manager daemon port is 27000.  
    **IBMRATL\_PORT**:Enter the port number that the vendor daemon (**ibmratl**) listens for connections on. The default vendor daemon port is typically 27001.  

    A default administration account for {{ site.data.keys.mf_server }} is created during pattern deployment.

4. Optional: Configure {{ site.data.keys.mf_server }} runtime deployment. You can skip this step if you want to specify the context root name for the runtime later during the pattern deployment configuration phase in step 10. To specify the context root name now, complete these steps:
    * In the MobileFirst Platform Server node, click the **MFP Server Runtime Deployment** component. The properties of the selected component are displayed next to the canvas.
    * Next to the **runtime\_contextRoot** field, click the **Delete** button to clear the pattern level parameter setting.
    * In the **runtime\_contextRoot** field, specify the runtime context root name. Note that the context root name must start with a forward slash, /; for example, `/HelloWorld`.

5. Upload application and adapter artifacts:

    > **Important:** When specifying the Target path for applications and adapters, make sure all the applications and adapters are placed in the same directory. For example, if one target path is **/opt/tmp/deploy/HelloWorld-common.json**, all the other target paths should be `/opt/tmp/deploy/*`.
    * In the MobileFirst Platform Server node, click the **MFP Server Application** or **MFP Server Adapter** component. The properties of the selected component are displayed next to the canvas.
    * In the **Additional file** field, click the **Browse** button to locate and upload the application or adapter artifact.
    * In the **Target path** field, specify the full path for storing the artifact including its file name; for example, **/opt/tmp/deploy/HelloWorld-common.json**.
    * If no application or adapter is to be deployed in the pattern, remove the relevant component by clicking the **X** button inside it. To get an empty {{ site.data.keys.mf_console }} deployed without any app or adapter installed, remove the MFP Server Application Adapter Deployment component by clicking the X button inside it.

6. Optional: Add more application or adapter artifacts for deployment:
    * From the **Assets** toolbar, expand **Software Components**, and then drag and drop an **Additional file** component onto the MobileFirst Platform Server node in the canvas. Rename it **{{ site.data.keys.product_adj }} App\_X** or **{{ site.data.keys.product_adj }} Adatper\_X** (where **X** stands for a unique number for differentiation).
    * Hover the cursor over the newly added App or Adapter component, and then click the **Move Up** and **Move Down** buttons to adjust its sequence in the node. Make sure it is placed after the MFP Runtime Deployment component but before the MFP Server Application Adapter Deployment component.
    * Click the newly added application or adapter component. The properties of the selected component are displayed next to the canvas. Upload the application or adapter artifact and specify its target path by referring to the steps in step 6.
    * Repeat step 7 to add more applications and adapters for deployment.

7. Optional: Configure application and adapter deployment to {{ site.data.keys.mf_server }}. You can skip this step if you want to specify the user credential with deployment privilege later during the pattern deployment configuration phase in step 10. If you have specified the default admin user credential in step 3, you can now specify the deployer user, which must align with the admin user credential:
    * In the MobileFirst Platform Server node, select the **MFP Server Application Adapter Deployment** component. The properties of the selected component are displayed next to the canvas.
    * Find the parameters named **deployer_user** and **deployer_password**, and then click the adjacent Delete buttons to clear the pattern level parameter settings.
    * In the **deployer\_user** and **deployer\_password** fields, specify the user name and password.

8. Configure base scaling policy:
    * In the **{{ site.data.keys.mf_server }}** node, select the **Base Scaling Policy** component. The properties of the selected component are displayed next to the canvas.
    * In the **Number of Instances** field, specify the number of server nodes to be instantiated during pattern deployment. The default value is 2 in the predefined template. Because dynamic scaling is not supported in this release, do not specify values in the remaining attribute fields.

9. Configure and launch the pattern deployment:
    * In the IBM PureApplication System dashboard, click **Patterns → Virtual System Patterns**.
    * On the **Virtual System Patterns** page, use the **Search** field to find the pattern you created, and then select the pattern.
    * In the toolbar above the panel displaying detailed information about the pattern, click the Deploy button.
    * In the Deploy Pattern window, in the Configure panel, select the correct environment profile from the **Environment Profile** list, and provide other IBM PureApplication System environment parameters. To obtain the correct information, consult your IBM PureApplication System administrator.
    * In the middle column, click **Pattern attributes** to display attributes such as user names and passwords.

        Supply the following information in the fields provided:

        > **Note:** Make appropriate changes to the default values of the pattern-level parameters even if an external LDAP server is configured. If you configure administration security by using an LDAP server, you need to supply additional LDAP information. For more information, see [Configuring {{ site.data.keys.product_adj }} administration security with an external LDAP repository](#configuring-mobilefirst-administration-security-with-an-external-ldap-repository).
        
        **runtime_contextRoot_list**  
        Context root names of the {{ site.data.keys.mf_server }} runtimes in case multiple runtimes exist. Use a semicolon, ";" to separate each runtime context root; for example, **HelloMobileFirst;HelloWorld**.

        **Important:** **runtime_contextRoot_list** must align with the context root specified in the MFP Server Runtime Deployment node; otherwise, IHS will not be able to correctly route requests that contain the runtime context root.
        
        **WebSphere administrative user name**  
        Admin user ID for WebSphere administration console login. Default value: virtuser.
        
        **WebSphere administrative password**  
        Admin user password for WebSphere administration console login. Default value: passw0rd.

        **admin\_user**  
        Not visible if configured in step 3. Create a default {{ site.data.keys.mf_server }} administrator account. Default value: demo.
        
        **admin\_password**  
        Not visible if configured in step 3. Default admin account password. Default value: demo.
        
        **ACTIVATE\_TOKEN\_LICENSE**  
        Not visible if configured in step 3. Select this field to license your pattern with token licensing. Leave this field clear if you use perpetual licenses.
        
        **LICENSE\_SERVER\_HOSTNAME**  
        Not visible if configured in step 3. If you use token licensing to license {{ site.data.keys.product }}, enter the fully-qualified hostname or IP address of your Rational License Key Server IP address. Otherwise, leave this field blank.
        
        **LMGRD\_PORT**   
        Not visible if configured in step 3. If you use token licensing to license {{ site.data.keys.product }}, enter the port number that the license manager daemon (lmrgd) listens for connections on. Otherwise, leave this field blank.
        The default license manager daemon port is 27000.

        **IBMRATL\_PORT**  
        Not visible if configured in step 3. If you use token licensing to license {{ site.data.keys.product }}, enter the port number that the vendor daemon (ibmratl) listens for connections on. Otherwise, leave this field blank.
        The default vendor daemon port is typically 27001.

        **runtime\_contextRoot**  
        Not visible if configured in step 5. Context root name for the {{ site.data.keys.mf_server }} runtime. The name must start with "/".
        
        **deployer\_user**  
        Not visible if configured in step 8. User name for the account with deployment privilege. If an external LDAP server is not configured, you must enter the same value as was specified when creating the default admin user for the administration service, because in this case, the only authorized user for app and adapter deployment is the default admin user.
        
        **deployer\_password**  
        Not visible if configured in step 8. User password for the user with deployment privilege.
        
        **MFP Vms Password(root)**  
        Root password for the {{ site.data.keys.mf_server }} and {{ site.data.keys.product }} DB nodes. Default value: passw0rd.
        
        **MFP DB Password(Instance owner)**  
        Instance owner password for the MobileFirst Platform DB node. Default value: **passw0rd**.    
    * Click **Quick Deploy** to launch your pattern deployment. After a few seconds, a message is displayed to indicate that the pattern has started to launch. You can click the URL provided in the message to track your pattern deployment status or go to **Patterns → Virtual System Instances** to open the Virtual System Instances page and search for your pattern there.

    If you use token licensing to license {{ site.data.keys.product }}, your pattern will fail to deploy if insufficient license tokens are available or if the license key server IP address and port were entered incorrectly.
    
10. Access the {{ site.data.keys.mf_console }}:
    * Click **Patterns → Virtual System Instances** to open the Virtual System Instances page and search for your pattern there. Make sure it is in Running state.
    * Select the pattern name and expand the **Virtual machine perspective** option in the panel displaying details of the selected instance.
    * Find the IHS Server VM that has a name similar to **IHS\_Server.*** and make a note of its Public IP address: you need this information in the following step.
    * In the browser, open the {{ site.data.keys.mf_console }} by composing its URL with one of the following formats:
        * `http://{IHS Server VM Public IP}/mfpconsole`
        * `https://{IHS Server VM Public IP}/mfpconsole`
    * Log in to the Console with the admin user ID and password specified in step 3 or step 10.

## Deploying {{ site.data.keys.mf_server }} on clusters of WebSphere Application Server Network Deployment servers
You can use a predefined template to deploy {{ site.data.keys.mf_server }} on clusters of WebSphere  Application Server Network Deployment servers. This {{ site.data.keys.mf_system_pattern_short }} template does not support token licensing.

This procedure involves uploading certain artifacts to IBM  PureApplication  System such as the required application and adapter. Before you begin, ensure that the artifacts are available for upload.

If you are running the System Monitoring for WebSphere Application Server shared service, the {{ site.data.keys.product }} runtime environment might fail to start correctly when you deploy the pattern. If possible, stop the shared service before you continue with this procedure. If you cannot stop the shared service, you might need to restart the {{ site.data.keys.product }} runtime from the WebSphere Application Server administrative console to fix the problem. For more information, see [{{ site.data.keys.product }} runtime synchronization limitation with WebSphere Application Server Network Deployment](#mobilefirst-foundation-runtime-synchronization-limitation-with-websphere-application-server-network-deployment). 

**Important token licensing restriction:** This pattern template does not support token licensing. You must be using perpetual licensing when you deploy patterns based on the {{ site.data.keys.product }} (WAS ND) pattern template.

Some parameters of script packages in the template are configured with recommended values and are not covered in this topic. For fine-tuning purposes, see more information about all the parameters of script packages in [Script packages for {{ site.data.keys.mf_server }}](#script-packages-for-mobilefirst-server).

For more information about the composition and configuration options of the predefined template that is used in this procedure, see [{{ site.data.keys.product }} (WAS ND) template](#mobilefirst-foundation-was-nd-template).

1. Create a pattern from the predefined template:
    * In the IBM PureApplication System dashboard, click **Patterns → Virtual System Patterns**. The Virtual System Patterns page opens.
    * On the **Virtual System Patterns** page, click **Create New**, and then in the pop-up window, select **MobileFirst Platform (WAS ND)** from the list of predefined templates. If the name is only partially visible due to its length, you can confirm that the correct template is selected by viewing its description on the **More information** tab.
    * In the **Name** field, provide a name for the pattern.
    * In the **Version** field, specify the version number of the pattern.
    * Click **Start Building**.
2. Mandatory for AIX : In IBM PureApplication System running on Power , the MobileFirst Platform DB node needs to use the AIX-specific add-on component "Default AIX add disk" to replace the "Default add disk" component in the template to support the jfs2 file system:
    * In the Pattern Builder, select the **MobileFirst Platform DB** node.
    * Click the **Add a Component Add-on** button (the button is visible above the component box when you hover the cursor over the **MobileFirst Platform DB** node).
    * From the **Add Add-ons** list, select **Default AIX add disk**. The component is added as the lowest component of the MobileFirst Platform DB node.
    * Select the **Default AIX add disk** component and specify the following attributes:
        * **DISK_SIZE_GB:** Storage size (measured in GB) to be extended to the DB server. Example value: **10**.
        * **FILESYSTEM_TYPE:** Supported file system in AIX. Default value: **jfs2**.
        * **MOUNT_POINT:** Align with the attribute **Mount point for instance owner** in the Database Server component in the MobileFirst Platform DB node. Example value: **/dbinst**.
        * **VOLUME_GROUP:** Example value: **group1**. Contact your IBM PureApplication System administrator for the correct value.
    * In the MobileFirst Platform DB node, select the **Default add disk** component, and then click the bin icon to delete it.
    * Save the pattern.
3. Optional: Configure {{ site.data.keys.mf_server }} administration. You can skip this step if you want to specify the user credential with {{ site.data.keys.mf_server }} administration privilege later during the pattern deployment configuration phase in step 9. To specify it now, complete these steps:

    > **Note:** If you want to configure administration security with an LDAP server, you need to supply additional LDAP information. For more information, see [Configuring {{ site.data.keys.product_adj }} administration security with an external LDAP repository](#configuring-mobilefirst-administration-security-with-an-external-ldap-repository).
    * In the MobileFirst Platform Server node, click the **MFP Server Administration** component. The properties of the selected component are displayed next to the canvas.
    * Next to the **admin_user** and **admin_password** fields, click the Delete button to clear their pattern level parameter settings.
    * In the **admin_user** and **admin\_password** fields, specify the administration user name and password.
    * If you use token licensing to license {{ site.data.keys.product }}, complete the following fields. If you do not use token licensing, leave these fields blank.

    **ACTIVATE\_TOKEN\_LICENSE**: Select this field to license your pattern with token licensing.  
    **LICENSE\_SERVER\_HOSTNAME**: Enter the fully qualified host name or IP address of your Rational License Key Server.  
    **LMGRD\_PORT**: Enter the port number that the license manager daemon (**lmrgd**) listens for connections on. The default license manager daemon port is 27000.  
    **IBMRATL\_PORT**:Enter the port number that the vendor daemon (**ibmratl**) listens for connections on. The default vendor daemon port is typically 27001.  

    A default administration account for {{ site.data.keys.mf_server }} is created during pattern deployment.

4. Optional: Configure {{ site.data.keys.mf_server }} runtime deployment. You can skip this step if you want to specify the context root name for the runtime later during the pattern deployment configuration phase in step 10. To specify the context root name now, complete these steps:
    * In the MobileFirst Platform Server node, click the **MFP Server Runtime Deployment** component. The properties of the selected component are displayed next to the canvas.
    * Next to the **runtime\_contextRoot** field, click the **Delete** button to clear the pattern level parameter setting.
    * In the **runtime\_contextRoot** field, specify the runtime context root name. Note that the context root name must start with a forward slash, /; for example, `/HelloWorld`.

5. Optional: Adjust the number of application server nodes in your WebSphere Application Server Network Deployment clusters for the {{ site.data.keys.product_adj }} Administration component and the {{ site.data.keys.product }} runtime environment.

    By default, the Administration component and runtime environment each have two application server nodes in their respective clusters.
    * In the DmgrNode node, click the **MFP Server Administration** component. The properties of the component are displayed next to the canvas.
    * In the **NUMBER\_OF\_CLUSTERMEMBERS** field, specify the number of application server nodes that you want in your WebSphere Application Server Network Deployment cluster for the {{ site.data.keys.product_adj }} Administration component.
    * In the DmgrNode node, click the **MFP Server Runtime Deployment** component. The properties of the component are displayed next to the canvas.
    * In the **NUMBER\_OF\_CLUSTERMEMBERS** field, specify the number of application server nodes that you want in your WebSphere Application Server Network Deployment cluster for the {{ site.data.keys.product }} runtime environment.
    * In the CustomNode node, click the **Base Scaling Policy** component.
    * Adjust the **Number of Instances** value to account for the total number of application server nodes that you entered in the **NUMBER\_OF\_CLUSTERMEMBERS** field for each component.
    The minimum value for **Number of Instances** is the total number of server nodes for the {{ site.data.keys.product_adj }} Administration component and the {{ site.data.keys.product }} runtime environments.

    For example, the default value for **Number of Instances** is 4 for the default topology with two nodes for the administration component and two nodes for the runtime environment. If you change **NUMBER\_OF\_CLUSTERMEMBERS** values for the administration component to 3 and for the runtime environment to 5, the minimum value for Number of Instances is 8.

6. Upload application and adapter artifacts:

    > **Important:** When specifying the Target path for applications and adapters, make sure all the applications and adapters are placed in the same directory. For example, if one target path is **/opt/tmp/deploy/HelloWorld-common.json**, all the other target paths should be `/opt/tmp/deploy/*`.
    * In the MobileFirst Platform Server node, click the **MFP Server Application** or **MFP Server Adapter** component. The properties of the selected component are displayed next to the canvas.
    * In the **Additional file** field, click the **Browse** button to locate and upload the application or adapter artifact.
    * In the **Target path** field, specify the full path for storing the artifact including its file name; for example, **/opt/tmp/deploy/HelloWorld-common.json**.
    * If no application or adapter is to be deployed in the pattern, remove the relevant component by clicking the **X** button inside it. To get an empty {{ site.data.keys.mf_console }} deployed without any app or adapter installed, remove the MFP Server Application Adapter Deployment component by clicking the X button inside it.

7. Optional: Add more application or adapter artifacts for deployment:
    * From the **Components** toolbar, expand **Software Components**, and then drag and drop an **Additional file** component onto the MobileFirst Platform Server node in the canvas. Rename it **{{ site.data.keys.product_adj }} App\_X** or **{{ site.data.keys.product_adj }} Adatper\_X** (where **X** stands for a unique number for differentiation).
    * Hover the cursor over the newly added App or Adapter component, and then click the **Move Up** and **Move Down** buttons to adjust its sequence in the node. Make sure it is placed after the MFP Runtime Deployment component but before the MFP Server Application Adapter Deployment component.
    * Click the newly added application or adapter component. The properties of the selected component are displayed next to the canvas. Upload the application or adapter artifact and specify its target path by referring to the steps in step 6.
    * In the **Additional file** field, click the **Browse** button to locate and upload the application or adapter artifact.
    * In the **Target path** field, specify the full path for storing the artifact, including its file name. For example, **/opt/tmp/deploy/HelloWorld-common.wlapp**.

    Repeat this step if you want to add more applications and adapters for deployment.

8. Optional: Configure application and adapter deployment to {{ site.data.keys.mf_server }}. You can skip this step if you want to specify the user credential with deployment privilege later during the pattern deployment configuration phase in step 10. If you have specified the default admin user credential in step 3, you can now specify the deployer user, which must align with the admin user credential:
    * In the MobileFirst Platform Server node, select the **MFP Server Application Adapter Deployment** component. The properties of the selected component are displayed next to the canvas.
    * Find the parameters named **deployer_user** and **deployer_password**, and then click the adjacent Delete buttons to clear the pattern level parameter settings.
    * In the **deployer\_user** and **deployer\_password** fields, specify the user name and password.

9. Configure base scaling policy:
    * In the IBM PureApplication System dashboard, click **Patterns → Virtual System Patterns**.
    * On the **Virtual System Patterns** page, use the Search field to find the pattern you created, and then select the pattern.
    * In the toolbar above the panel displaying detailed information about the pattern, click the **Deploy** button.
    * In the **Deploy Pattern** window, in the **Configure** panel, select the correct **Environment Profile** and other IBM PureApplication System environment parameters by consulting your IBM PureApplication System administrator.
    * In the middle column, click **Pattern attributes** to set attributes such as user name and passwords.

        Supply the following information in the fields provided:
        
        > **Note:** Make appropriate changes to the default values of the pattern-level parameters even if an external LDAP server is configured. If you configure administration security by using an LDAP server, you need to supply additional LDAP information. For more information, see [Configuring {{ site.data.keys.product_adj }} administration security with an external LDAP repository](#configuring-mobilefirst-administration-security-with-an-external-ldap-repository).

        **WebSphere administrative user name**  
        Admin user ID for WebSphere administration console login. Default value: virtuser.

        **WebSphere administrative password**  
        Admin user password for WebSphere administration console login. Default value: passw0rd.
        
        **admin\_user**  
        Not visible if configured in step 3. Create a default {{ site.data.keys.mf_server }} administrator account. Default value: demo.
        
        **admin\_password**  
        Not visible if configured in step 3. Default admin account password. Default value: demo.
        
        **ACTIVATE\_TOKEN\_LICENSE**  
        Not visible if configured in step 3. Select this field to license your pattern with token licensing. Leave this field clear if you use perpetual licenses.
        
        **LICENSE\_SERVER\_HOSTNAME**  
        Not visible if configured in step 3. If you use token licensing to license {{ site.data.keys.product }}, enter the fully-qualified hostname or IP address of your Rational License Key Server IP address. Otherwise, leave this field blank.
        
        **LMGRD\_PORT**   
        Not visible if configured in step 3. If you use token licensing to license {{ site.data.keys.product }}, enter the port number that the license manager daemon (lmrgd) listens for connections on. Otherwise, leave this field blank.
        The default license manager daemon port is 27000.

        **IBMRATL\_PORT**  
        Not visible if configured in step 3. If you use token licensing to license {{ site.data.keys.product }}, enter the port number that the vendor daemon (ibmratl) listens for connections on. Otherwise, leave this field blank.
        The default vendor daemon port is typically 27001.

        **runtime\_contextRoot**  
        Not visible if configured in step 5. Context root name for the {{ site.data.keys.mf_server }} runtime. The name must start with "/".
        
        **deployer\_user**  
        Not visible if configured in step 8. User name for the account with deployment privilege. If an external LDAP server is not configured, you must enter the same value as was specified when creating the default admin user for the administration service, because in this case, the only authorized user for app and adapter deployment is the default admin user.
        
        **deployer\_password**  
        Not visible if configured in step 8. User password for the user with deployment privilege.
        
        **MFP Vms Password(root)**  
        Root password for the {{ site.data.keys.mf_server }} and {{ site.data.keys.product }} DB nodes. Default value: passw0rd.
        
        **MFP VMs Password(virtuser)**  
        Password for the virtuser user of the DmgrNode, CustomNode, IHSNode and {{ site.data.keys.product }} DB nodes. Default value: passw0rd.
        
        **Open firewall ports for WAS**  
        The WebSphere Application Server nodes that are deployed in the CustomNode VM nodes require open firewall ports to connect to the database server and the LDAP server (if configured for LDAP). If you need to specify multiple port numbers, separate the port numbers with a semicolon (;). For example, 50000;636The default value is 50000 (the default port for DB2  server).

        **Important restriction:**  
        When you set these attrbutes, do not change the following attributes in the {{ site.data.keys.mf_server }} section:
        
        * Cell name
        * Node name
        * Profile name

        If you change any of these attributes, your pattern deployment will fail.
    * Click **Quick Deploy** to launch your pattern deployment. After a few seconds, a message is displayed to indicate that the pattern has started to launch. You can click the URL provided in the message to track your pattern deployment status or go to **Patterns → Virtual System Instances** to open the **Virtual System Instances** page and search for your pattern there.

10. Access the {{ site.data.keys.mf_console }}:
    * Click **Patterns → Virtual System Instances** to open the Virtual System Instances page and search for your pattern there. Make sure it is in Running state.
    * Select the pattern name and expand the **Virtual machine perspective** option in the panel displaying details of the selected instance.
    * Find the {{ site.data.keys.mf_server }} VM that has a name similar to **MobileFirst\_Platform\_Server.** and make a note of its Public IP address: you need this information in the following step.
    * In the browser, open the {{ site.data.keys.mf_console }} by composing its URL with one of the following formats:
        * `http://{MFP Server VM Public IP}:9080/mfpconsole`
        * `https://{MFP Server VM Public IP}:9443/mfpconsole`
    * Log in to the Console with admin user and password specified in step 3 or step 9.

    If the console does not display the {{ site.data.keys.product }} runtimes, restart the {{ site.data.keys.product }} runtime node from the WebSphere Application Server administrative console. For instructions about restarting the runtime node from the administrative console, see [Restarting the {{ site.data.keys.product }} runtime from the WebSphere Application Server administrative console](#restarting-the-mobilefirst-foundation-runtime-from-the-websphere-application-server-administrative-console).

### {{ site.data.keys.product }} runtime synchronization limitation with WebSphere Application Server Network Deployment
If you deploy a PureApplication  pattern based on the {{ site.data.keys.product }} (WAS ND) template and run the System Monitoring for WebSphere  Application Server shared service, the {{ site.data.keys.product }} runtime environment might fail to start correctly, when you deploy the pattern.

A PureApplication virtual system pattern based on the {{ site.data.keys.product }} (WAS ND) template deploys the {{ site.data.keys.product_adj }} administration service and the {{ site.data.keys.product }} runtime into different WebSphere Application Server Network Deployment clusters. For the {{ site.data.keys.product }} runtime to work correctly, it must be started after the {{ site.data.keys.product_adj }} administration service. If the {{ site.data.keys.product }} runtime starts first, the runtime service fails to detect the {{ site.data.keys.product_adj }} administration service, which causes errors in the runtime service.

When the deployment of a PureApplication pattern is almost complete, the System Monitoring for WebSphere Application Server shared service restarts all of the WebSphere Application Server nodes that are deployed from the pattern. The nodes restart in a random order, so the nodes that contain the {{ site.data.keys.product }} runtime might be restarted before the nodes that contain the {{ site.data.keys.product_adj }} administration service.

You must stop the System Monitoring for WebSphere Application Server shared service before you deploy the pattern. If you cannot stop the shared service, you might need to restart the {{ site.data.keys.product }} runtime from the WebSphere Application Server administrative console to fix the problem.

	### Restarting the {{ site.data.keys.product }} runtime from the WebSphere Application Server administrative console
If your {{ site.data.keys.mf_console }} is empty after you deploy a PureApplication  System pattern based on the {{ site.data.keys.product }} (WAS ND) template, you might need to restart the IBM {{ site.data.keys.product }} runtime from the WebSphere  Application Server administrative console.

This procedure applies only when you are deploying PureApplication virtual system patterns based on the {{ site.data.keys.product }} (WAS ND) template when you are running the System Monitoring for WebSphere Application Server shared service. If you do not use this shared service or are deploying a pattern based on a different template, this procedure does not apply to you.

You must deploy your pattern before you do this procedure.

To work correctly, the {{ site.data.keys.product_adj }} administration service nodes must be started before the {{ site.data.keys.product }} runtime nodes. If the System Monitoring for WebSphere Application Server shared service is running when you deploy a pattern, the shared service restarts all of the WebSphere Application Server nodes that are deployed from the pattern. The nodes restart in a random order, which means that the {{ site.data.keys.product }} runtime nodes might be started before the {{ site.data.keys.product_adj }} administration service nodes.

1. Confirm that the System Monitoring for WebSphere Application Server shared service is deployed and running:
    * In the PureApplication System dashboard, click Patterns and then under Pattern Instances, click Shared Services.

        > **Important:** Shared Services appears twice in the **Patterns** menu, ensure that you click **Shared Services** under **Pattern Instances** and not under Patterns.
    * On the **Shared Service Instances** page, look for a name that starts with **System Monitoring for WebSphere Application Server**. Click that name to expand its entry
    
        If you do not see an entry for **System Monitoring for WebSphere Application Server**, the System Monitoring for WebSphere Application Server shared service is not deployed and you do not need to continue with this procedure.
    * Check the **Status** column for the service.
    
        If **Status** says `Stopped`, the System Monitoring for WebSphere Application Server shared service is stopped and you do not need to continue with this procedure.  
        If **Status** says `Started`, the System Monitoring for WebSphere Application Server shared service is running. Continue with the rest of this procedure.

2. Confirm that your pattern is running, and access the {{ site.data.keys.mf_console }} from the PureApplication System dashboard.

    For instructions about how access the {{ site.data.keys.mf_console }} from the PureApplication System dashboard, see step 10 in [Deploying {{ site.data.keys.mf_server }} on clusters of WebSphere Application Server Network Deployment servers](#deploying-mobilefirst-server-on-clusters-of-websphere-application-server-network-deployment-servers).
    
3. If the console appears empty or is otherwise not displaying {{ site.data.keys.product }} runtimes, restart the {{ site.data.keys.product }} runtime node from the WebSphere Application Server administrative console:
    * In the **PureApplication System** dashboard, click **Patterns → Virtual System Instances**.
    * On the **Virtual System Instances** page, find your pattern instance and confirm that it is running. If it is not running, start the pattern instance.
    * Click the name of your pattern instance and in the details panel, find the **Virtual machine perspective** section.
    * In the **Virtual machine perspective** section, find the virtual machine whose name starts with **DmgrNode** and note its public IP address.
    * Open the WebSphere Application Server administrative console at the following URL:
    
        ```bash
        https://{DmgrNode VM public IP address}:9043/ibm/console
        ```
    
        Use the user ID and password that you specified for the WebSphere Application Server administrative console when you deployed the pattern.
    * In the WebSphere Application Server administrative console, expand **Applications** and click **All applications**.
    * Restart the {{ site.data.keys.product }} runtime:
        * In the list of applications, select the application with name that begins with IBM\_Worklight\_project\_runtime\_MFP.
        * In the **Action** column, select **Stop**.
        * Click **Submit Action**.
        * Wait until the application status in the **Status** column shows the stopped icon.
        * In the **Action** column, select **Start**.
        * Click S**ubmit Action**.

        Repeat this step for each {{ site.data.keys.product }} runtime application in the list.

4. Access the {{ site.data.keys.mf_console }} again and confirm that your {{ site.data.keys.product }} runtimes are now visible.

## Deploying {{ site.data.keys.mf_app_center }} on a single-node WebSphere Application Server Liberty profile server
You use a predefined template to deploy {{ site.data.keys.mf_app_center }} on a single-node WebSphere  Application Server Liberty profile server.

This procedure involves uploading certain artifacts to IBM  PureApplication  System such as the required application and adapter. Before you begin, ensure that the artifacts are available for upload.

**Token licensing requirements:** If you use token licensing to license {{ site.data.keys.product }}, review the requirements that are outlined in [Token licensing requirements for {{ site.data.keys.mf_system_pattern }}](#token-licensing-requirements-for-mobilefirst-system-pattern) before you continue. If the license key server cannot be contacted or if insufficient license tokens are available then the deployment of this pattern fails.

Some parameters of script packages in the template is configured with the recommended values and are not mentioned here. For fine-tuning purposes, see more information about all the parameters of script packages in [Script packages for {{ site.data.keys.mf_server }}](#script-packages-for-mobilefirst-server).

For more information about the composition and configuration options of the predefined template that is used in this procedure, see [{{ site.data.keys.mf_app_center }} (Liberty single node) template](#mobilefirst-application-center-liberty-single-node-template).

1. Create a pattern from the predefined template:
    * In the IBM PureApplication System dashboard, click **Patterns → Virtual System Patterns**. The Virtual System Patterns page opens.
    * On the **Virtual System Patterns** page, click **Create New**, and then in the pop-up window, select **MobileFirst Platform (AppCenter Liberty single node)** from the list of predefined templates. If the name is only partially visible due to its length, you can confirm that the correct template is selected by viewing its description on the **More information** tab.
    * In the **Name** field, provide a name for the pattern.
    * In the **Version** field, specify the version number of the pattern.
    * Click **Start Building**.
2. Mandatory for AIX : In IBM PureApplication System running on Power, the MobileFirst Platform DB node needs to use the AIX-specific add-on component "Default AIX add disk" to replace the "Default add disk" component in the template to support the jfs2 file system:
    * In the Pattern Builder, select the **MobileFirst Platform DB** node.
    * Click the **Add a Component Add-on** button (the button is visible above the component box when you hover the cursor over the **MobileFirst Platform DB** node).
    * From the **Add Add-ons** list, select **Default AIX add disk**. The component is added as the lowest component of the MobileFirst Platform DB node.
    * Select the **Default AIX add disk** component and specify the following attributes:
        * **DISK_SIZE_GB:** Storage size (measured in GB) to be extended to the DB server. Example value: **10**.
        * **FILESYSTEM_TYPE:** Supported file system in AIX. Default value: **jfs2**.
        * **MOUNT_POINT:** Align with the attribute **Mount point for instance owner** in the Database Server component in the MobileFirst Platform DB node. Example value: **/dbinst**.
        * **VOLUME_GROUP:** Example value: **group1**. Contact your IBM PureApplication System administrator for the correct value.
    * In the MFP AppCenter DB node, select the **Default add disk** component, and then click the bin icon to delete it.
    * Save the pattern.
3. Optional: Configure **MFP Server Application Center** in the **MFP AppCenter Server** node.
    
    > **Note:** If you want to configure administration security with an LDAP server, you need to supply more LDAP information. For more information, see [Configuring {{ site.data.keys.product_adj }} administration security with an external LDAP repository](#configuring-mobilefirst-administration-security-with-an-external-ldap-repository).
    * In the M**FP AppCenter Server** node, click the **MFP Server Application Center** component. The properties of the selected component are displayed next to the canvas.
    * Next to the **admin_user** and **admin_password** fields, click the Delete button to clear their pattern level parameter settings.
    * In the **admin_user** and **admin_password** fields, specify the administration user name and password.
    * Next to the **db_user** and **db_password** fields, click the **Delete** button to clear their pattern level parameter settings.
    * In the **db_user** and **db_password** fields, specify the database user name and password.
    * In the **db_name**, **db_instance**, **db_ip**, and **db_port** fields, specify the database user name, password, instance name, IP, and port number.

    A default administration account for {{ site.data.keys.mf_server }} is created during pattern deployment.

4. Configure and launch the pattern deployment:
    * In the IBM PureApplication System dashboard, click **Patterns → Virtual System Patterns**.
    * On the **Virtual System Patterns** page, use the **Search** field to find the pattern you created, and then select the pattern.
    * In the toolbar above the panel that displays the detailed information about the pattern, click the **Deploy** button.
    * In the **Deploy Pattern** window, in the **Configure** panel, select the correct environment profile from the **Environment Profile** list, and provide other IBM PureApplication System environment parameters. To obtain the correct information, consult your IBM PureApplication System administrator.
    * In the middle column, click Pattern attributes to display attributes such as user names and passwords.

    Supply the following information in the fields provided:

    > **Note:** Make appropriate changes to the default values of the pattern-level parameters even if an external LDAP server is configured. If you configure administration security by using an LDAP server, you need to supply additional LDAP information. For more information, see [Configuring {{ site.data.keys.product_adj }} administration security with an external LDAP repository](#configuring-mobilefirst-administration-security-with-an-external-ldap-repository).
    
    **admin\_user**  
    Not visible if configured in step 3. Create a default {{ site.data.keys.mf_server }} administrator account. Default value: demo.
    
    **admin\_password**  
    Not visible if configured in step 3. Default admin account password. Default value: demo.
    
    **ACTIVATE\_TOKEN\_LICENSE**  
    Not visible if configured in step 3. Select this field to license your pattern with token licensing. Leave this field clear if you use perpetual licenses.
    
    **LICENSE\_SERVER\_HOSTNAME**  
    Not visible if configured in step 3. If you use token licensing to license {{ site.data.keys.product }}, enter the fully-qualified hostname or IP address of your Rational License Key Server IP address. Otherwise, leave this field blank.
    
    **LMGRD\_PORT**   
    Not visible if configured in step 3. If you use token licensing to license {{ site.data.keys.product }}, enter the port number that the license manager daemon (lmrgd) listens for connections on. Otherwise, leave this field blank.
    The default license manager daemon port is 27000.

    **IBMRATL\_PORT**  
    Not visible if configured in step 3. If you use token licensing to license {{ site.data.keys.product }}, enter the port number that the vendor daemon (ibmratl) listens for connections on. Otherwise, leave this field blank.
    The default vendor daemon port is typically 27001.

    **runtime\_contextRoot**  
    Not visible if configured in step 5. Context root name for the {{ site.data.keys.mf_server }} runtime. The name must start with "/".
    
    **deployer\_user**  
    Not visible if configured in step 8. User name for the account with deployment privilege. If an external LDAP server is not configured, you must enter the same value as was specified when creating the default admin user for the administration service, because in this case, the only authorized user for app and adapter deployment is the default admin user.
    
    **deployer\_password**  
    Not visible if configured in step 8. User password for the user with deployment privilege.
    
    **MFP Vms Password(root)**  
    Root password for the {{ site.data.keys.mf_server }} and {{ site.data.keys.product }} DB nodes. Default value: passw0rd.
    
    **MFP DB Password(Instance owner)**  
    Instance owner password for the MobileFirst Platform DB node. Default value: **passw0rd**.    
* Click **Quick Deploy** to launch your pattern deployment. After a few seconds, a message is displayed to indicate that the pattern has started to launch. You can click the URL provided in the message to track your pattern deployment status or go to **Patterns → Virtual System Instances** to open the Virtual System Instances page and search for your pattern there.

5. To access the {{ site.data.keys.mf_console }} perform the following steps:
    * Click **Patterns → Virtual System Instances** to open the **Virtual System Instances** page and search for your pattern there.
    * Select your pattern name and expand the Virtual machine perspective in the panel that displays the details of the selected instance.
    * Find the {{ site.data.keys.mf_server }} VM that has a name similar to **MFP\_AppCenter\_Server.**, make a note of its public IP address.
    * In the browser, open the {{ site.data.keys.mf_console }} by composing its URL with one of the following formats:
        * `http://{MFP Server VM Public IP}:9080/appcenterconsole`
        * `https://{MFP Server VM Public IP}:9443/appcenterconsole`
    * Log in to the Console with admin user and password specified in step 3.

## Deploying {{ site.data.keys.mf_app_center }} on a single-node WebSphere Application Server full profile server
You use a predefined template to deploy a single-node {{ site.data.keys.mf_app_center }} to a WebSphere  Application Server full profile server.

This procedure involves uploading certain artifacts to IBM  PureApplication  System such as the required application and adapter. Before you begin, ensure that the artifacts are available for upload.

**Token licensing requirements:** If you use token licensing to license {{ site.data.keys.product }}, review the requirements outlined in [Token licensing requirements for {{ site.data.keys.mf_system_pattern }}](#token-licensing-requirements-for-mobilefirst-system-pattern) before you continue. The deployment of this pattern fails if the license key server cannot be contacted or if insufficient license tokens are available.

Some parameters of script packages in the template have been configured with the recommended values and are not mentioned in this section. For fine-tuning purposes, see more information about all the parameters of script packages in [Script packages for {{ site.data.keys.mf_server }}](#script-packages-for-mobilefirst-server).

For more information about the composition and configuration options of the predefined template that is used in this procedure, see [{{ site.data.keys.mf_app_center }} (WAS single node) template](#mobilefirst-application-center-was-single-node-template).

1. Create a pattern from the predefined template:
    * In **the IBM PureApplication System** dashboard, click P**atterns → Virtual System Patterns**. The Virtual System Patterns page opens.
    * On the **Virtual System Patterns** page, click **Create New**, and then in the pop-up window, select **MobileFirst Platform (AppCenter Liberty single node)** from the list of predefined templates. If the name is only partially visible due to its length, you can confirm that the correct template is selected by viewing its description on the More information tab.
    * In the **Name** field, provide a name for the pattern.
    * In the **Version** field, specify the version number of the pattern.
    * Click **Start Building**.
2. Mandatory for AIX : In IBM PureApplication System running on Power , the MobileFirst Platform DB node needs to use the AIX-specific add-on component "Default AIX add disk" to replace the "Default add disk" component in the template to support the **jfs2** file system:
    * In the Pattern Builder, select the **MFP AppCenter DB** node.
    * Click the **Add a Component** Add-on button (the button is visible above the component box when you hover the cursor over the **MFP AppCenter** DB node).
    * From the Add Add-ons list, select **Default AIX** add disk. The component is added as the lowest component of the MobileFirst Platform DB node.
    * Select the **Default AIX** add disk component and specify the following attributes:
        
        **DISK\_SIZE\_GB**  
        Storage size (measured in GB) to be extended to the DB server. Following is the example value: 10.

        **FILESYSTEM\_TYPE**  
        Supported file system in AIX. Following is the default value: **jfs2**.

        **MOUNT\_POINT**  
        Align with the attribute **Mount point for instance owner** in the Database Server component in the MobileFirst Platform DB node. Following is the example value: /dbinst.

        **VOLUME\_GROUP**  
        Following is the example value: **group1**. Contact your IBM PureApplication System administrator for the correct value.
    * In the **MFP AppCenter DB** node, select the **Default add disk** component, and then click the bin icon to delete it.
    * Save the pattern.

3. Optional: Configure **MFP Server Application Center** in the **MFP AppCenter Server** node.

    > **Note:** If you want to configure administration security with an LDAP server, you need to supply more LDAP information. For more information, see [Configuring {{ site.data.keys.product_adj }} administration security with an external LDAP repository](#configuring-mobilefirst-administration-security-with-an-external-ldap-repository).
    * In the **MFP AppCenter Server** node, click the **MFP Server Administration** component. The properties of the selected component are displayed next to the canvas.
    * Next to the **admin_user** and **admin_password** fields, click the Delete button to clear their pattern level parameter settings.
    * In the **admin_user** and **admin\_password** fields, specify the administration user name and password.
    * If you use token licensing to license {{ site.data.keys.product }}, complete the following fields. If you do not use token licensing, leave these fields blank.

    **ACTIVATE\_TOKEN\_LICENSE**: Select this field to license your pattern with token licensing.  
    **LICENSE\_SERVER\_HOSTNAME**: Enter the fully qualified host name or IP address of your Rational License Key Server.  
    **LMGRD\_PORT**: Enter the port number that the license manager daemon (**lmrgd**) listens for connections on. The default license manager daemon port is 27000.  
    **IBMRATL\_PORT**:Enter the port number that the vendor daemon (**ibmratl**) listens for connections on. The default vendor daemon port is typically 27001.  

    A default administration account for {{ site.data.keys.mf_server }} is created during pattern deployment.

4. Configure and launch the pattern deployment:
    * In the IBM PureApplication System dashboard, click **Patterns → Virtual System Patterns**.
    * On the **Virtual System Patterns** page, use the **Search** field to find the pattern you created, and then select the pattern.
    * In the toolbar above the panel displaying detailed information about the pattern, click the Deploy button.
    * In the Deploy Pattern window, in the Configure panel, select the correct environment profile from the **Environment Profile** list, and provide other IBM PureApplication System environment parameters. To obtain the correct information, consult your IBM PureApplication System administrator.
    * In the middle column, click **Pattern attributes** to display attributes such as user names and passwords.

        Supply the following information in the fields provided:

        > **Note:** Make appropriate changes to the default values of the pattern-level parameters even if an external LDAP server is configured. If you configure administration security by using an LDAP server, you need to supply additional LDAP information. For more information, see [Configuring {{ site.data.keys.product_adj }} administration security with an external LDAP repository](#configuring-mobilefirst-administration-security-with-an-external-ldap-repository).
        
        **admin\_user**  
        Not visible if configured in step 3. Create a default {{ site.data.keys.mf_server }} administrator account. Default value: demo.
        
        **admin\_password**  
        Not visible if configured in step 3. Default admin account password. Default value: demo.
        
        **ACTIVATE\_TOKEN\_LICENSE**  
        Not visible if configured in step 3. Select this field to license your pattern with token licensing. Leave this field clear if you use perpetual licenses.
        
        **LICENSE\_SERVER\_HOSTNAME**  
        Not visible if configured in step 3. If you use token licensing to license {{ site.data.keys.product }}, enter the fully-qualified hostname or IP address of your Rational License Key Server IP address. Otherwise, leave this field blank.
        
        **LMGRD\_PORT**   
        Not visible if configured in step 3. If you use token licensing to license {{ site.data.keys.product }}, enter the port number that the license manager daemon (lmrgd) listens for connections on. Otherwise, leave this field blank.
        The default license manager daemon port is 27000.

        **IBMRATL\_PORT**  
        Not visible if configured in step 3. If you use token licensing to license {{ site.data.keys.product }}, enter the port number that the vendor daemon (ibmratl) listens for connections on. Otherwise, leave this field blank.
        The default vendor daemon port is typically 27001.

        **runtime\_contextRoot**  
        Not visible if configured in step 5. Context root name for the {{ site.data.keys.mf_server }} runtime. The name must start with "/".
        
        **deployer\_user**  
        Not visible if configured in step 8. User name for the account with deployment privilege. If an external LDAP server is not configured, you must enter the same value as was specified when creating the default admin user for the administration service, because in this case, the only authorized user for app and adapter deployment is the default admin user.
        
        **deployer\_password**  
        Not visible if configured in step 8. User password for the user with deployment privilege.
        
        **MFP Vms Password(root)**  
        Root password for the {{ site.data.keys.mf_server }} and {{ site.data.keys.product }} DB nodes. Default value: passw0rd.
        
        **MFP DB Password(Instance owner)**  
        Instance owner password for the MobileFirst Platform DB node. Default value: **passw0rd**.    
    * Click **Quick Deploy** to launch your pattern deployment. After a few seconds, a message is displayed to indicate that the pattern has started to launch. You can click the URL provided in the message to track your pattern deployment status or go to **Patterns → Virtual System Instances** to open the Virtual System Instances page and search for your pattern there.

5. To access the {{ site.data.keys.mf_console }} perform the following steps:
    * Click **Patterns → Virtual System Instances** to open the Virtual System Instances page and search for your pattern there.
    * Select your pattern name and expand the Virtual machine perspective in the panel that displays the details of the selected instance.
    * Find the {{ site.data.keys.mf_server }} VM that has a name similar to **MFP\_AppCenter\_Server.**, make a note of its public IP address.
    * In the browser, open the {{ site.data.keys.mf_console }} by composing its URL with one of the following formats:
        * `http://{MFP Server VM Public IP}:9080/appcenterconsole`
        * `https://{MFP Server VM Public IP}:9443/appcenterconsole`
    * Log in to the Console with admin user and password specified in step 3.

## Configuring {{ site.data.keys.product_adj }} administration security with an external LDAP repository
You can configure {{ site.data.keys.product_adj }} administration security to enable connecting out to an external LDAP repository. The configuration is common for both WebSphere  Application Server Liberty profile and full profile.

This procedure involves configuring the LDAP parameters for connecting to the external user registry server. Before you begin, ensure the LDAP server is working and consult your LDAP administrator to obtain the required configuration information.

**Important:**  
When the LDAP repository configuration is enabled, a default user for {{ site.data.keys.product_adj }} administration is not automatically created. Instead, you must specify the administration user name and password that are stored in the LDAP repository. This information is required by WebSphere Application Server Liberty profile and a server farm of WebSphere Application Server full profile.

If the runtime to be deployed in the pattern is configured to use LDAP for application authentication, make sure that the LDAP server configured in the runtime is the same as the LDAP server that is configured for the {{ site.data.keys.product_adj }} Administration; different LDAP servers are not supported. Also, the protocol and port for LDAP connection must be identical. For example, if connections from the runtime to the LDAP server are configured to use the SSL protocol and port is 636, connections from the {{ site.data.keys.product_adj }} Administration to the LDAP server must use the SSL protocol and port 636 as well.

1. Build a pattern with any topology you need. For more information, see the following topics:
    * [Deploying {{ site.data.keys.mf_server }} on a single-node WebSphere Application Server Liberty profile server](#deploying-mobilefirst-server-on-a-single-node-websphere-application-server-liberty-profile-server)
    * [Deploying {{ site.data.keys.mf_server }} on a multiple-node WebSphere Application Server Liberty profile server](#deploying-mobilefirst-server-on-a-multiple-node-websphere-application-server-liberty-profile-server)
    * [Deploying {{ site.data.keys.mf_server }} on a single-node WebSphere Application Server full profile server](#deploying-mobilefirst-server-on-a-single-node-websphere-application-server-full-profile-server)
    * [Deploying {{ site.data.keys.mf_server }} on a multiple-node WebSphere Application Server full profile server](#deploying-mobilefirst-server-on-a-multiple-node-websphere-application-server-full-profile-server)
    * [Deploying {{ site.data.keys.mf_server }} on clusters of WebSphere Application Server Network Deployment servers](#deploying-mobilefirst-server-on-clusters-of-websphere-application-server-network-deployment-servers)
2. Mandatory for AIX : In IBM  PureApplication  System running on Power, the MobileFirst Platform DB node needs to use the AIX-specific add-on component "Default AIX add disk" to replace the "Default add disk" component in the template to support the jfs2 file system:
    * In the **Pattern Builder**, select the **MobileFirst Platform DB** node.
    * Click the **Add a Component Add-on** button (the button is visible above the component box when you hover the cursor over the **MobileFirst Platform DB** node).
    * From the **Add Add-ons** list, select **Default AIX add disk**. The component is added as the lowest component of the MobileFirst Platform DB node.
    * Select the Default AIX add disk component and specify the following attributes:

        **DISK\_SIZE\_GB**  
        Storage size (measured in GB) to be extended to the DB server. Example value: 10.
        
        **FILESYSTEM\_TYPE**  
        Supported file system in AIX. Default value: jfs2.
        
        **MOUNT\_POINT**  
        Align with the attribute **Mount point for instance owner** in the **Database Server component** in the **MobileFirst Platform DB** node. Example value: `/dbinst`.
        
        **VOLUME\_GROUP**  
        Example value: `group1`. Contact your IBM PureApplication System administrator for the correct value.
    * In the MobileFirst Platform DB node, select the Default add disk component, and then click the bin icon to delete it.
    * Save the pattern.

3. Configure {{ site.data.keys.mf_server }} administration:
    * In IBM PureApplication System, in the dashboard, click P**atterns → Virtual System Patterns**. The Virtual System Patterns page opens.
    * On the **Virtual System Patterns** page, use the **Search** field to find and select the pattern you created, and then click **Open** to open the **Pattern Builder** page.
    * In the MobileFirst Platform Server node (or the DmgrNode node when using the {{ site.data.keys.product }} (WAS ND) template), select the MFP Server Administration component. The properties of the selected component are displayed next to the canvas.
    * Supply the following LDAP information in the fields provided:

    **admin_user**  
    User ID of the account that has {{ site.data.keys.mf_server }} administration privilege. This value is stored in the LDAP repository. Not required if the {{ site.data.keys.mf_server }} is to be deployed on a single node of WebSphere Application Server full profile.
    
    **admin_password**  
    Admin user password. This value is stored in the LDAP repository. Not required if the {{ site.data.keys.mf_server }} is to be deployed on a single node of WebSphere Application Server full profile.
    
    **LDAP_TYPE**  
    LDAP server type of your user registry. One of the following values:  
    --- **None**  
    LDAP connection is disabled. When this is set, all the other LDAP parameters are treated as placeholders only.  
    --- **TivoliDirectoryServer**  
    Select this if the LDAP repository is an IBM Tivoli  Directory Server.  
    --- **ActiveDirectory**  
    Select this if the LDAP repository is a Microsoft Active Directory.  
    Default value: None.
    
    **LDAP_IP**  
    LDAP server IP address.
    
    **LDAP_SSL_PORT**  
    LDAP port for secure connection.
    
    **LDAP_PORT**  
    LDAP port for non-secure connection.
    
    **BASE_DN**  
    Base DN.
    
    **BIND_DN**  
    Bind DN.
    
    **BIND_PASSWORD**  
    Bind DN password.
    
    **REQUIRE_SSL**  
    Select true for secure connection to the LDAP server. Default value: false.
    
    **USER_FILTER**  
    LDAP user filter that applies when searching the existing user registry for users.
    
    **GROUP_FILTER**  
    LDAP group filter that applies when searching the existing user registry for groups.
    
    **LDAP\_REPOSITORY\_NAME**  
    LDAP server name.
    
    **CERT\_FILE\_PATH**  
    Target path of the uploaded LDAP server certification.
    
    **mfpadmin**  
    Admin role for {{ site.data.keys.mf_server }}. One of the following values:
    --- **None**  
        No user.  
    --- **AllAuthenticatedUsers**  
        Authenticated users  
    --- **Everyone**  
        All users.  
        
    Default value: None. For more information about security roles, see [Configuring user authentication for {{ site.data.keys.mf_server }} administration](../../../installation-configuration/production/server-configuration/#configuring-user-authentication-for-mobilefirst-server-administration).
    
    **mfpdeployer**  
    Deployer role for {{ site.data.keys.mf_server }}. One of the following values:
    --- **None**  
        No user.  
    --- **AllAuthenticatedUsers**  
        Authenticated users  
    --- **Everyone**  
        All users.
    
    Default value: None. For more information about security roles, see [Configuring user authentication for {{ site.data.keys.mf_server }} administration](../../../installation-configuration/production/server-configuration/#configuring-user-authentication-for-mobilefirst-server-administration).
    
    **mfpmonitor**  
    Monitor role for {{ site.data.keys.mf_server }}. One of the following values:    
    --- **None**  
        No user.  
    --- **AllAuthenticatedUsers**  
        Authenticated users     
    --- **Everyone**  
        All users.
    
    Default value: None. For more information about security roles, see [Configuring user authentication for {{ site.data.keys.mf_server }} administration](../../../installation-configuration/production/server-configuration/#configuring-user-authentication-for-mobilefirst-server-administration).
    
    **mfpoperator**  
    Operator role for {{ site.data.keys.mf_server }}. One of the following values:
    --- **None**  
        No user.  
    --- **AllAuthenticatedUsers**  
        Authenticated users  
    --- **Everyone**  
        All users.

    Default value: None. For more information about security roles, see [Configuring user authentication for {{ site.data.keys.mf_server }} administration](../../../installation-configuration/production/server-configuration/#configuring-user-authentication-for-mobilefirst-server-administration).

4. Optional: Configure the LDAP SSL connection. This step is required only if you set **REQUIRE_SSL** to true in the previous step to use secure connections to the LDAP server:
    * From the **Assets** toolbar, expand **Software Components**, and then drag and drop an **Additional file** component onto the MobileFirst Platform Server node in the canvas. Rename the component "MobileFirst LDAP Cert", for example.
    * Hover the cursor over the newly added component, and then click the **Move up** and **Move down** buttons to adjust the position of the component in the node. Make sure that it is placed between the **MFP Server Prerequisite** component and the **MFP Server Administration** component.
    * Click the **MobileFirst LDAP Cert** component. The properties of the selected component are displayed next to the canvas. Upload the LDAP certification artifact in the **Additional file** field by clicking the **Browse** button to locate it
    * In the **Target** path field, specify the full path for storing the artifact including its file name; for example, **/opt/tmp/tdscert.der**.
    * In the MobileFirst Platform Server node (or the DmgrNode node when using the {{ site.data.keys.product }} (WebSphere Application Server Network Deployment) template), select the MFP Server Administration component, and then click the **Add reference** button next to the **CERT\_FILE\_PATH** field. In the pop-up window, click the **component-level parameter** tab. From the Component list, select **MobileFirst LDAP Cert**. In the **Output** attribute list, select **target\_path**. Click the **Add** button to refresh the **Output value** field, and then click **OK**.

5. Configure and launch the pattern deployment. On the Deploy Pattern page, in the Nodes list, you can adjust your LDAP configurations by clicking **MobileFirst Server** (or **DmgrNode** when using the {{ site.data.keys.product }} (WAS ND) template) and then expanding **MFP Server Administration**. For more information about pattern deployment, see the "Configure and launch the pattern deployment" step in one of the following topics depending on the topology you selected when creating the pattern:
    * [Deploying {{ site.data.keys.mf_server }} on a single-node WebSphere Application Server Liberty profile server](#deploying-mobilefirst-server-on-a-single-node-websphere-application-server-liberty-profile-server), step 8.
    * [Deploying {{ site.data.keys.mf_server }} on a multiple-node WebSphere Application Server Liberty profile server](#deploying-mobilefirst-server-on-a-multiple-node-websphere-application-server-liberty-profile-server), step 9.
    * [Deploying {{ site.data.keys.mf_server }} on a single-node WebSphere Application Server full profile server](#deploying-mobilefirst-server-on-a-single-node-websphere-application-server-full-profile-server), step 8.
    * [Deploying {{ site.data.keys.mf_server }} on a multiple-node WebSphere Application Server full profile server](#deploying-mobilefirst-server-on-a-multiple-node-websphere-application-server-full-profile-server), step 9.
    * [Deploying {{ site.data.keys.mf_server }} on clusters of WebSphere Application Server Network Deployment servers](#deploying-mobilefirst-server-on-clusters-of-websphere-application-server-network-deployment-servers), step 9 onwards.

6. Access the {{ site.data.keys.mf_console }}. Use the administrator user name and password to log in to the {{ site.data.keys.mf_console }} through your LDAP configuration. For more information, see the "Access the {{ site.data.keys.mf_console }}:" step in one of the following topics depending on the topology you selected when creating the pattern;
    * [Deploying {{ site.data.keys.mf_server }} on a single-node WebSphere Application Server Liberty profile server](#deploying-mobilefirst-server-on-a-single-node-websphere-application-server-liberty-profile-server), step 9.
    * [Deploying {{ site.data.keys.mf_server }} on a multiple-node WebSphere Application Server Liberty profile server](#deploying-mobilefirst-server-on-a-multiple-node-websphere-application-server-liberty-profile-server), step 10.
    * [Deploying {{ site.data.keys.mf_server }} on a single-node WebSphere Application Server full profile server](#deploying-mobilefirst-server-on-a-single-node-websphere-application-server-full-profile-server), step 9.
    * [Deploying {{ site.data.keys.mf_server }} on a multiple-node WebSphere Application Server full profile server](#deploying-mobilefirst-server-on-a-multiple-node-websphere-application-server-full-profile-server), step 10.
    * [Deploying {{ site.data.keys.mf_server }} on clusters of WebSphere Application Server Network Deployment servers](#deploying-mobilefirst-server-on-clusters-of-websphere-application-server-network-deployment-servers), step 10 onwards.

## Configuring an external database with a {{ site.data.keys.mf_system_pattern }}
You can configure {{ site.data.keys.mf_system_pattern }} to enable connecting out to an external database. IBM DB2 is the only supported external database. The configuration is common for all the supported patterns.

**Before you begin**
This procedure involves configuring the external database parameters for connecting to the external database. Before you begin, ensure the following:

* Configure the external database instance on your installed IBM DB2.
* Make a note of the database instance name, database user name, database password, database host name or IP and database instance port.

1. Build a pattern with any topology you need. For more information, see the following topics:
    [Deploying {{ site.data.keys.mf_server }} on a single-node WebSphere Application Server Liberty profile server](#deploying-mobilefirst-server-on-a-single-node-websphere-application-server-liberty-profile-server)
    * [Deploying {{ site.data.keys.mf_server }} on a multiple-node WebSphere Application Server Liberty profile server](#deploying-mobilefirst-server-on-a-multiple-node-websphere-application-server-liberty-profile-server)
    * [Deploying {{ site.data.keys.mf_server }} on a single-node WebSphere Application Server full profile server](#deploying-mobilefirst-server-on-a-single-node-websphere-application-server-full-profile-server)
    * [Deploying {{ site.data.keys.mf_server }} on a multiple-node WebSphere Application Server full profile server](#deploying-mobilefirst-server-on-a-multiple-node-websphere-application-server-full-profile-server)
    * [Deploying {{ site.data.keys.mf_server }} on clusters of WebSphere Application Server Network Deployment servers](#deploying-mobilefirst-server-on-clusters-of-websphere-application-server-network-deployment-servers)

2. Select **MobileFirst Platform DB** and click **Remove component**.
3. Configure {{ site.data.keys.mf_server }} administration:
    * In IBM PureApplication  System, in the dashboard, click **Patterns → Virtual System Patterns**. The **Virtual System Patterns** page opens.
    * On the **Virtual System Patterns** page, use the **Search** field to find and select the pattern you created, and then click **Open** to open the **Pattern Builder** page.
    * In the MobileFirst Platform Server node (or the DmgrNode node when using the {{ site.data.keys.product }} (WAS ND) template), select the **MFP Server Administration** component. The properties of the selected component are displayed next to the canvas.
    * Check the option **USE\_EXTERNAL\_DATABASE** and configure the following parameters:

        **db_instance**  
        External database instance name.
        
        **db_user**  
        External database user name.
        
        **db_name**  
        External database name.
        
        **db_password**  
        External database password.
        
        **db_ip**  
        External database IP.
        
        **db_port**  
        External database port number.
        
        > **Note:** If you are using the {{ site.data.keys.product }} (WAS ND) pattern template, you will need to additionally configure the attribute **Open firewall ports for WAS** to the external database port number.
    * In the MobileFirst Platform Server node (or the DmgrNode node when using the {{ site.data.keys.product }} (WAS ND) template), select the **MFP Server Runtime Deployment** component. The properties of the selected component are displayed next to the canvas.
    * Under the **USE\_EXTERNAL\_DATABASE** configure the following parameters:

        **rtdb_instance**  
        External database instance name.
        
        **rtdb_user**  
        External runtime database user name.
        
        **rtdb_name**  
        External runtime database name, which will be created.
        
        **rtdb_password**
        External runtime database password.

## Deploying and configuring {{ site.data.keys.mf_analytics }}
You can deploy and configure the {{ site.data.keys.mf_analytics }} on both WebSphere  Application Server Liberty profile and full profile to enable the Analytics features in the pattern.

Before you begin,  
If you intend to use an LDAP repository to protect the Analytics Console, ensure that the LDAP server is working and consult your LDAP administrator to obtain the required configuration information.

> **Important:** When the LDAP repository configuration is enabled in the Analytics component, a default administration user is not created for {{ site.data.keys.mf_analytics }}. Instead, you must specify the administration user name and password values that are stored in the LDAP repository. These values are required to protect the Analytics Console.

1. Build a pattern with the topology you need. For more information, see the following topics:
    * [Deploying {{ site.data.keys.mf_server }} on a single-node WebSphere Application Server Liberty profile server](#deploying-mobilefirst-server-on-a-single-node-websphere-application-server-liberty-profile-server)
    * [Deploying {{ site.data.keys.mf_server }} on a multiple-node WebSphere Application Server Liberty profile server](#deploying-mobilefirst-server-on-a-multiple-node-websphere-application-server-liberty-profile-server)
    * [Deploying {{ site.data.keys.mf_server }} on a single-node WebSphere Application Server full profile server](#deploying-mobilefirst-server-on-a-single-node-websphere-application-server-full-profile-server)
    * [Deploying {{ site.data.keys.mf_server }} on a multiple-node WebSphere Application Server full profile server](#deploying-mobilefirst-server-on-a-multiple-node-websphere-application-server-full-profile-server)
    * [Deploying {{ site.data.keys.mf_server }} on clusters of WebSphere Application Server Network Deployment servers](#deploying-mobilefirst-server-on-clusters-of-websphere-application-server-network-deployment-servers)

2. Add and configure {{ site.data.keys.mf_analytics }}:
    * In the IBM  PureApplication  System dashboard, click **Patterns → Virtual System Patterns**. The **Virtual System Patterns** page opens.
    * On the **Virtual System Patterns** page, use the **Search** field to find and select the pattern you created, and then click **Open** to open the **Pattern Builder** page.
    * From the **Assets** list, expand **Software Components**, and then drag and drop one of the following components onto the canvas:

        **Liberty profile server**  
        Select this component if you want to deploy {{ site.data.keys.mf_analytics }} on WebSphere Application Server Liberty profile.
        
        **Standalone server**  
        Select this component if you want to deploy {{ site.data.keys.mf_analytics }} on WebSphere Application Server full profile.

        A new node is created with the name "OS Node". Rename it "{{ site.data.keys.mf_analytics }}".
    * Make the following configuration changes depending on the type of application server you want to deploy Analytics to:
        * If you are deploying {{ site.data.keys.mf_analytics }} to WebSphere Application Server Liberty profile, click **Liberty profile server** in the {{ site.data.keys.mf_analytics }} node. The properties of the selected component are displayed next to the canvas. In the **Configuration data location** field, enter the path **/opt/IBM/WebSphere/Liberty** and specify the administrative user name and password. Use the default values for the other parameters.
        * If you are deploying {{ site.data.keys.mf_analytics }} to WebSphere Application Server full profile, click **Standalone server** in the {{ site.data.keys.mf_analytics }} node. The properties of the selected component are displayed next to the canvas. In the **Configuration data location** field, enter the path **/opt/IBM/WebSphere/AppServer/Profiles**, change Profile name to **AppSrv01**, and specify the administrative user name and password. Use the default values for the other parameters.
    
        > **Important:** The WebSphere Application Server administrative user will be created in the WebSphere Application Server user repository. If LDAP will be configured for the Analytics server, avoid user name conflicts with the WebSphere Application Server administrative user. For example, if "user1" will be introduced by the LDAP server through its configuration, do not set "user1" as the WebSphere Application Server administrative user name.
    * From the Components list, expand **Scripts**, and then drag and drop an **MFP Server Prerequisite** component and a MFP WAS SDK Level component onto the {{ site.data.keys.mf_analytics }} node on the canvas.
    * From the Components list, expand **Scripts**, and then drag and drop an **MFP Analytics** component onto the {{ site.data.keys.mf_analytics }} node on the canvas. Make sure the MFP Analytics component is positioned after the Liberty profile server component (or the Standalone server component).
    * Supply the following {{ site.data.keys.mf_analytics }} information in the fields provided:
        
        The LDAP parameters are exactly the same as the MFP Server Administration parameters. For more information, see the "Configure MFP Server Administration" step in 3:
        
        > **Important:** For LDAP SSL connection configuration in {{ site.data.keys.mf_analytics }}, make sure that in step 4b in [Configuring {{ site.data.keys.product_adj }} administration security with an external LDAP repository](#configuring-mobilefirst-administration-security-with-an-external-ldap-repository), the dragged-in {{ site.data.keys.product_adj }} LDAP Cert component in the {{ site.data.keys.mf_analytics }} node must be moved to between the Liberty profile server (or Stanalone server) and the MFP Analytics script package.
        
   #### WAS_ROOT
    * If {{ site.data.keys.mf_analytics }} is being installed on WebSphere Application Server Liberty profile, specify the installation directory of the Liberty profile for Analytics:
        * Click the **Add reference** button next to the **WAS_ROOT** field and in the pop-up window, click the **component-level parameter** tab.
        * In the **Component** field, select **Liberty profile server** (it might be called **Liberty profile server\_1** if the {{ site.data.keys.mf_server }} is also deployed on WebSphere Application Server Liberty profile).
        * In the **Output attribute** field, select **install_directory**. Click the **Add** button to refresh the Output value field, and then click **OK**.
    * If {{ site.data.keys.mf_analytics }} is being installed on WebSphere Application Server full profile, specify the installation directory of the WebSphere Application Server full profile for Analytics:
        * Click the **Add reference** button next to the WAS_ROOT field and in the pop-up window, click the **component-level parameter** tab.
        * In the **Component** field, select **Standalone server** (it might be called **Standalone server\_1** if the {{ site.data.keys.mf_server }} is also deployed on WebSphere Application Server full profile)
        * In the **Output attribute** field, select **install_directory**. Click the **Add** button to refresh the Output value field, and then click **OK**.
        
   #### HEAP\_MIN\_SIZE
   
    Applicable to WebSphere Application Server full profile only.

    The amount of Analytics data that is generated is directly proportional to the amount of memory required to handle it. Set this value to allow a larger minimum heap size for WebSphere Application Server full profile. Make sure that the **Memory size** value specified in the Core OS component of the {{ site.data.keys.mf_analytics }} node is larger than **HEAP\_MIN\_SIZE**. Consider setting a value equal to **HEAP\_MAX\_SIZE**.
    
    Default value: 4096 MB.

   #### HEAP\_MAX\_SIZE
    Applicable to WebSphere Application Server full profile only.

    The amount of Analytics data that is generated is directly proportional to the amount of memory required to handle it. Set this value to allow a larger maximum heap size for WebSphere Application Server full profile. Make sure that the **Memory size** value specified in the Core OS component of the {{ site.data.keys.mf_analytics }} node is larger than **HEAP\_MAX\_SIZE**. Consider setting a value equal to **HEAP\_MIN\_SIZE**.

    Default value: 4096 MB.
    
   #### WAS\_admin\_user
    * Applicable to WebSphere Application Server full profile only.  
    WebSphere Application Server full profile admin user ID for the Analytics server.
        * Click the **Add reference** button next to the **WAS\_admin\_user** field and in the pop-up window, click the **component-level** parameter tab.
        * In the **Component** field, select **Standalone server** (it may be called **Standalone server_1** if the {{ site.data.keys.mf_server }} is also deployed on WebSphere Application Server full profile)
        * In the **Output attribute** field, select **was\_admin**. Click the **Add** button to refresh the **Output** value field, and then click **OK**.
    
    For Liberty profile, the default value can be used.
    
   #### WAS\_admin\_password
    Applicable to WebSphere Application Server full profile only.

    WebSphere Application Server full profile admin user ID for the Analytics server.
    * Click the **Add reference** button next to the **WAS\_admin\_password** field and in the pop-up window, click the **component-level parameter** tab.
    * In the **Component** field, select **Standalone server** (it may be called **Standalone server_1** if the {{ site.data.keys.mf_server }} is also deployed on WebSphere Application Server full profile)
    * In the **Output** attribute field, select **was\_admin\_password**. Click the **Add** button to refresh the **Output** value field, and then click **OK**.
    
    For Liberty profile, the default value can be used.

   #### admin_user
    * If an LDAP repository is not enabled, create a default administration user for {{ site.data.keys.mf_analytics_console }} protection.
    * If an LDAP repository is enabled, specify the user name that has {{ site.data.keys.mf_analytics }} administration privilege. The value is stored in the LDAP repository.

   #### admin_password
    * If an LDAP repository is not enabled, specify the password for the default administration user for {{ site.data.keys.mf_analytics_console }} protection.
    * If an LDAP repository is enabled, specify the administration user password. The value is stored in the LDAP repository.
    
    Optional: Enable the LDAP repository for {{ site.data.keys.mf_analytics_console }} protection. The LDAP parameters in {{ site.data.keys.mf_analytics }} are exactly the same as those for {{ site.data.keys.mf_server }} Administration. For more information, see “Configure MFP Server Administration” (step 3) in [Configuring {{ site.data.keys.product_adj }} administration security with an external LDAP repository](#configuring-mobilefirst-administration-security-with-an-external-ldap-repository).

3. Configure {{ site.data.keys.mf_server }} runtime deployment for {{ site.data.keys.mf_analytics }} connection:
    * In the MobileFirst Platform Server node (or the DmgrNode node when using the {{ site.data.keys.product }} (WAS ND) template), select the **MFP Server Runtime Deployment** component.
    * Drag a link from the MFP Server Runtime Deployment component to the Liberty profile server component or to the Standalone server component in the {{ site.data.keys.mf_analytics }} node, depending on the type of application server being used. The Configure Data Dependencies pop-up window opens.
    * Configure the data dependencies:
        * In the Configure Data Dependencies window, clear any existing recommended data dependency entries by clicking the **X** button next to each entry.
        * Below **MFP Server Runtime Deployment** component, select **analytics_ip** and below **Liberty profile server** or **Standalone server**, select **IP**.
        * Click the **Add** button to add the new data dependency.
        * Click **OK** to save your changes.

            ![Adding link from MFP Server Runtime component to the Liberty server](pureapp_analytics_link_1.jpg)
            
            The link from the MFP Server Runtime Deployment component to the Liberty profile server component (or the Standalone server component) is built.
    * Drag another link from the MFP Server Runtime Deployment component to the MFP Analytics component in the {{ site.data.keys.mf_analytics }} node. The Configure Data Dependencies pop-up window opens.
    * Configure the data dependencies:
        * In the Configure Data Dependencies window, clear all the recommended data dependencies entries by clicking the **X** button next to each entry.
        * Below **MFP Server Runtime Deployment** component, select **analytics\_admin\_user** and below **MFP Analytics**, select **admin_user**.
        * Click the **Add** button to add the new data dependency.
        * Repeat the process to configure a data dependency from **analytics\_admin\_password** to **admin_password**.
        * Click **OK** to save your changes.
            
            ![Adding link from MFP Server Runtime Deployment component to the MFP Analytics component](pureapp_analytics_link_2.jpg)
            
    The following figure shows an example of a {{ site.data.keys.mf_analytics }} node added to a {{ site.data.keys.product }} WAS ND pattern:

    ![{{ site.data.keys.mf_analytics }} node added to a {{ site.data.keys.product }} WAS ND pattern](pureapp_analytics_node.jpg)

4. Configure and launch the pattern deployment.

    On the Deploy Pattern page, you can adjust your {{ site.data.keys.mf_analytics }} configuration settings by clicking the {{ site.data.keys.mf_analytics }} component under the Nodes list in the middle column and then expanding MFP Analytics.

    For more information about pattern deployment, see the "Configure and launch the pattern deployment" step in the following topics depending on the topology you selected when creating the pattern:
    * [Deploying {{ site.data.keys.mf_server }} on a single-node WebSphere Application Server Liberty profile server](#deploying-mobilefirst-server-on-a-single-node-websphere-application-server-liberty-profile-server), step 8.
    * [Deploying {{ site.data.keys.mf_server }} on a multiple-node WebSphere Application Server Liberty profile server](#deploying-mobilefirst-server-on-a-multiple-node-websphere-application-server-liberty-profile-server), step 9.
    * [Deploying {{ site.data.keys.mf_server }} on a single-node WebSphere Application Server full profile server](#deploying-mobilefirst-server-on-a-single-node-websphere-application-server-full-profile-server), step 8.
    * [Deploying {{ site.data.keys.mf_server }} on a multiple-node WebSphere Application Server full profile server](#deploying-mobilefirst-server-on-a-multiple-node-websphere-application-server-full-profile-server), step 9.
    * [Deploying {{ site.data.keys.mf_server }} on clusters of WebSphere Application Server Network Deployment servers](#deploying-mobilefirst-server-on-clusters-of-websphere-application-server-network-deployment-servers), step 9 onwards.

5. Access {{ site.data.keys.mf_analytics }} through the {{ site.data.keys.mf_console }}.

    For more information, see the "Access the {{ site.data.keys.mf_console }}" step in one of the following topics depending on the topology you selected when creating the pattern:
    * [Deploying {{ site.data.keys.mf_server }} on a single-node WebSphere Application Server Liberty profile server](#deploying-mobilefirst-server-on-a-single-node-websphere-application-server-liberty-profile-server), step 9.
    * [Deploying {{ site.data.keys.mf_server }} on a multiple-node WebSphere Application Server Liberty profile server](#deploying-mobilefirst-server-on-a-multiple-node-websphere-application-server-liberty-profile-server), step 10.
    * [Deploying {{ site.data.keys.mf_server }} on a single-node WebSphere Application Server full profile server](#deploying-mobilefirst-server-on-a-single-node-websphere-application-server-full-profile-server), step 9.
    * [Deploying {{ site.data.keys.mf_server }} on a multiple-node WebSphere Application Server full profile server](#deploying-mobilefirst-server-on-a-multiple-node-websphere-application-server-full-profile-server), step 10.
    * [Deploying {{ site.data.keys.mf_server }} on clusters of WebSphere Application Server Network Deployment servers](#deploying-mobilefirst-server-on-clusters-of-websphere-application-server-network-deployment-servers), step 10 onwards.    
    
## Predefined templates for {{ site.data.keys.mf_system_pattern }}
{{ site.data.keys.mf_system_pattern }} includes predefined templates that you can use to build patterns for the most typical deployment topologies.  
The following templates are available:

#### Jump to
* [{{ site.data.keys.product }} (Liberty single node) template](#mobilefirst-foundation-liberty-single-node-template)
* [{{ site.data.keys.product }} (Liberty server farm) template](#mobilefirst-foundation-liberty-server-farm-template)
* [{{ site.data.keys.product }} (WAS single node) template](#mobilefirst-foundation-was-single-node-template)
* [{{ site.data.keys.product }} (WAS server farm) template](#mobilefirst-foundation-was-server-farm-template)
* [{{ site.data.keys.product }} (WAS ND) template](#mobilefirst-foundation-was-nd-template)
* [{{ site.data.keys.mf_app_center }} (Liberty single node) template](#mobilefirst-application-center-liberty-single-node-template)
* [{{ site.data.keys.mf_app_center }} (WAS single node) template](#mobilefirst-application-center-was-single-node-template)

### {{ site.data.keys.product }} (Liberty single node) template
The following diagram shows the composition of the "MobileFirst Platform (Liberty single node)" template.

![{{ site.data.keys.product }} (Liberty single node) template](pureapp_templ_Lib_single_node.jpg)

The {{ site.data.keys.product }} (Liberty single node) template is composed of the following nodes and components:

| Node | Components | 
|------|------------|
| MobileFirst Platform Server | **Liberty profile server**<br/>WebSphere  Application Server Liberty profile server installation.<br/><br/>**MFP Server Prerequisite**<br/>Prerequisites for {{ site.data.keys.mf_server }} installation including SSL and Ant.<br/><br/>**MFP Server Administration**<br/>{{ site.data.keys.mf_server }} Administration web application including {{ site.data.keys.mf_console }}.<br/>**MFP Server Runtime Deployment**<br/>Runtime context root configuration.<br/><br/>**MFP Server Application**<br/>{{ site.data.keys.product_adj }} application to be added to the deployment.<br/><br/>**MFP Server Adapter**<br/>. An adapter to be added to the deployment.<br/><br/>**MFP Server Application Adapter Deployment**<br/>Application and adapter deployment to {{ site.data.keys.mf_server }}. | 
| MobileFirst Platform DB | **Database Server**<br/>DB2  database server installation.<br/><br/>**MFP Administration DB**<br/>MobileFirst administration database schema installation.<br/><br/>**MFP Runtime DB**<br/>{{ site.data.keys.product }} runtime database schema installation.<br/><br/>**Default add disk**<br/>Disk size configuration. | 

### {{ site.data.keys.product }} (Liberty server farm) template
The following diagram shows the composition of the "MobileFirst Platform (Liberty server farm)" template.

![{{ site.data.keys.product }} (Liberty server farm) template](pureapp_templ_Lib_server_farm.jpg)

The {{ site.data.keys.product }} (Liberty server farm) template is composed of the following nodes and components:

| Node | Components | 
|------|------------|
| IHS Server | **IBM  HTTP servers**<br/>IBM HTTP Server installation.<br/><br/>**MFP IHS Configuration**<br/>Automatic configuration of IBM HTTP Server. | 
| MobileFirst Platform Server | **Liberty profile server**<br/>WebSphere Application Server Liberty profile server installation.<br/><br/>**MFP Server Prerequisite**<br/>Prerequisites for {{ site.data.keys.mf_server }} installation including SSL and Ant.<br/><br/>**MFP Server Administration**<br/>{{ site.data.keys.mf_server }} Administration web application including {{ site.data.keys.mf_console }}.<br/><br/>**MFP Server Runtime Deployment**<br/>Runtime context root configuration.<br/><br/>**MFP Server Application**<br/>{{ site.data.keys.product_adj }} application to be added to the deployment.<br/><br/>**MFP Server Adapter**<br/>An adapter to be added to the deployment.<br/><br/>**MFP Server Application Adapter Deployment**<br/>Application and adapter deployment to {{ site.data.keys.mf_server }}.<br/><br/>**Base Scaling Policy**<br/>VM scaling policy: number of VMs. | 
| MobileFirst Platform DB | **Database Server**<br/>DB2 database server installation.<br/><br/>**MFP Administration DB**<br/>{{ site.data.keys.product_adj }} administration database schema installation.<br/><br/>**MFP Runtime DB**<br/>{{ site.data.keys.product }} runtime database schema installation.<br/><br/>**Default add disk**<br/>Disk size configuration. | 

### {{ site.data.keys.product }} (WAS single node) template
The following diagram shows the composition of the "MobileFirst Platform (WAS single node)" template.

![{{ site.data.keys.product }} (WAS single node) template](pureapp_templ_WAS_single_node.jpg)

The {{ site.data.keys.product }} (WAS single node) template is composed of the following nodes and components:

| Node | Components | 
|------|------------|
| MobileFirst Platform Server | **Standalone server**<br/>WebSphere Application Server full profile server installation.<br/><br/>Restriction:<br/>Do not change the values for the following component attributes:{::nomarkdown}<ul><li>Cell name</li><li>Node name</li><li>Profile name</li></ul>{:/}If you change any of these attributes, the deployment of patterns that are based on this template fails.<br/><br/>**MFP Server Prerequisite**<br/>Prerequisites for {{ site.data.keys.mf_server }} installation including SSL and Ant.<br/><br/>**MFP Server Administration**<br/>{{ site.data.keys.mf_server }} Administration web application including<br/><br/>**MFP Server Runtime Deployment**<br/>Runtime context root configuration. {{ site.data.keys.mf_console }}.<br/><br/>**{{ site.data.keys.product_adj }} App**<br/>{{ site.data.keys.product_adj }} application to be added to the deployment.<br/><br/>**{{ site.data.keys.product_adj }} Adapter**<br/>{{ site.data.keys.product_adj }} adapter to be added to the deployment.<br/><br/>**MFP Server Application Adapter Deployment**<br/>Application and adapter deployment to {{ site.data.keys.mf_server }}. | 
| MobileFirst Platform DB | **Database Server**<br/>DB2 database server installation.<br/><br/>**MFP Administration DB**<br/>{{ site.data.keys.product_adj }} administration database schema installation.<br/><br/>**MFP Runtime DB**<br/>{{ site.data.keys.product }} runtime database schema installation.<br/><br/>**Default add disk**<br/>Disk size configuration. | 

### {{ site.data.keys.product }} (WAS server farm) template
The following diagram shows the composition of the "MobileFirst Platform (WAS server farm)" template.

![{{ site.data.keys.product }} (WAS server farm) template](pureapp_templ_WAS_server_farm.jpg)

The {{ site.data.keys.product }} (WAS server farm) template is composed of the following nodes and components:

| Node | Components | 
|------|------------|
| IHS Server | **IBM HTTP servers**<br/>IBM HTTP Server installation.<br/><br/>**MFP IHS Configuration**<br/>Automatic configuration of IBM HTTP Server. | 
| MobileFirst Platform Server | **Standalone server**<br/>WebSphere Application Server full profile server installation.<br/><br/>Restriction: Do not change the values for the following component attributes:{::nomarkdown}<ul><li>Cell name</li><li>Node name</li><li>Profile name</li></ul>{:/}If you change any of these attributes, the deployment of patterns that are based on this template fails.<br/><br/>**MFP Server Prerequisite**<br/>Prerequisites for {{ site.data.keys.mf_server }} installation including SSL and Ant.<br/><br/>**MFP Server Administration**<br/>{{ site.data.keys.mf_server }} Administration web application including {{ site.data.keys.mf_console }}.<br/><br/>**MFP Server Runtime Deployment**<br/>Runtime context root configuration.<br/><br/>**{{ site.data.keys.product_adj }} App**<br/>{{ site.data.keys.product_adj }} application to be added to the deployment.<br/><br/>**{{ site.data.keys.product_adj }} Adapter**An adapter to be added to the deployment.<br/><br/>**MFP Server Application Adapter Deployment**<br/>Application and adapter deployment to {{ site.data.keys.mf_server }}.<br/><br/>**Base Scaling Policy**<br/>VM scaling policy: number of VMs. | 
| MobileFirst Platform DB | **Database Server**<br/>DB2 database server installation.<br/><br/>**MFP Administration DB**<br/>{{ site.data.keys.product_adj }} administration database schema installation.<br/><br/>**MFP Runtime DB**<br/>{{ site.data.keys.product }} runtime database schema installation.<br/><br/>**Default add disk**<br/>Disk size configuration. | 

### {{ site.data.keys.product }} (WAS ND) template
The following diagram shows the composition of the "MobileFirst Platform (WAS ND)" template.

![{{ site.data.keys.product }} (WAS ND) template](pureapp_templ_WAS_ND.jpg)

The {{ site.data.keys.product }} (WAS ND) template is composed of the following nodes and components:

| Node | Components | 
|------|------------|
| IHS Server | **IBM HTTP servers**<br/>IBM HTTP Server installation.<br/><br/>**MFP IHS Configuration**<br/>Automatic configuration of IBM HTTP Server. | 
| DmgrNode | **Deployment manager**<br/>WebSphere Application Server deployment manager installation.<br/><br/>Restriction: Do not change the values for the following component attributes:{::nomarkdown}<ul><li>Cell name</li><li>Node name</li><li>Profile name</li></ul>{:/}If you change any of these attributes, the deployment of patterns that are based on this template fails.<br/><br/>**MFP Server Prerequisite**<br/>Prerequisites for {{ site.data.keys.mf_server }} installation including SSL and Ant.<br/><br/>**MFP Server Administration**<br/>{{ site.data.keys.mf_server }} Administration web application including {{ site.data.keys.mf_console }}.<br/><br/>**MFP Runtime**<br/>Runtime WAR file.<br/><br/>**MFP Server Runtime Deployment**<br/>Runtime context root configuration.<br/><br/>**MFP Application**<br/>{{ site.data.keys.product_adj }} application to be added to the deployment.<br/><br/>**MFP Adapter**<br/>An adapter to be added to the deployment.<br/><br/>**MFP Server Application Adapter Deployment**<br/>Application and adapter deployment to {{ site.data.keys.mf_server }}. | 
| MobileFirst Platform DB | **Database Server**<br/>DB2 database server installation.<br/><br/>**MFP Administration DB**<br/>{{ site.data.keys.product_adj }} administration database schema installation.<br/><br/>**MFP Runtime DB**<br/>{{ site.data.keys.product }} runtime database schema installation.<br/><br/>**Default add disk**<br/>Disk size configuration. | 
| CustomNode | **Custom nodes**<br/>Details of the cells and nodes in the clusters of WebSphere Application Server Network Deployment servers.<br/><br/>Restriction: Do not change the values for the following component attributes:{::nomarkdown}<ul><li>Cell name</li><li>Node name</li><li>Profile name</li></ul>{:/}If you change any of these attributes, the deployment of patterns that are based on this template fails.<br/><br/>**MFP Open Firewall Ports for WAS**<br/>Ports that must be open to enable connection to the database server and the LDAP server.<br/><br/>**Base scaling policy**<br/>Number of virtual machine instances required for the chosen topology. | 

### {{ site.data.keys.mf_app_center }} (Liberty single node) template
The following diagram shows the composition of the "MobileFirst Platform Application Center (Liberty single node)" template.

![{{ site.data.keys.mf_app_center }} (Liberty single node) template](pureapp_templ_appC_Lib_single_node.jpg)

The {{ site.data.keys.mf_app_center }} (Liberty single node) template is composed of the following nodes and components:

| Node | Components |
|------|------------|
| MFP AppCenter DB | **Database Server**<br/>DB2 database server installation.<br/><br/>**Default add disk**<br/>Disk size configuration. | 
| MFP AppCenter Server | **Liberty profile server**<br/>WebSphere Application Server Liberty profile server installation.<br/><br/>**MFP Server Prerequisite**<br/>Prerequisites for {{ site.data.keys.mf_server }} installation including SSL and Ant.<br/><br/>**MFP Server Application Center**<br/>This script package sets up the {{ site.data.keys.mf_app_center }} server in a WebSphere Application Server full profile or WebSphere Application Server Liberty profile server. | 

### {{ site.data.keys.mf_app_center }} (WAS single node) template
The diagram shows the composition of the "MobileFirst Platform Application Center (WAS single node)" template.

![{{ site.data.keys.mf_app_center }} (WAS single node) template](pureapp_templ_appC_WAS_single_node.jpg)

The {{ site.data.keys.mf_app_center }} (WAS single node) template is composed of the following nodes and components:

| Node | Components | 
|------|------------|
| MFP AppCenter DB | **Database Server**<br/>DB2 database server installation.<br/><br/>**Default add disk**<br/>Disk size configuration. | 
| MFP AppCenter Server | **Standalone server**<br/>WebSphere Application Server full profile server installation.<br/><br/>Restriction: Do not change the values for the following component attributes:{::nomarkdown}<ul><li>Cell name</li><li>Node name</li><li>Profile name</li></ul>{:/}If you change any of these attributes, the deployment of patterns that are based on this template fails.<br/><br/>**MFP WAS SDK Level**<br/>Purpose of this script is to set the required SDK level as the default SDK for the WAS Profile<br/><br/>**MFP Server Prerequisite**<br/>Prerequisites for {{ site.data.keys.mf_server }} installation including SSL and Ant.<br/><br/>**MFP Server Application Center**<br/>This script package sets up the {{ site.data.keys.mf_app_center }} server in a WebSphere Application Server full profile or WebSphere Application Server Liberty profile server. | 


## Script packages for {{ site.data.keys.mf_server }}
{{ site.data.keys.mf_system_pattern }} provides script packages that are the building blocks to compose various pattern topologies.  
The following sections list and describe the parameters for each script package.

#### Jump to
* [MFP Administration DB](#mfp-administration-db)
* [MFP Analytics](#mfp-analytics)
* [MFP IHS Configuration](#mfp-ihs-configuration)
* [MFP Open Firewall Ports for WAS](#mfp-open-firewall-ports-for-was)
* [MFP WAS SDK Level](#mfp-was-sdk-level)
* [MFP Runtime DB](#mfp-runtime-db)
* [MFP Server Administration](#mfp-server-administration)
* [MFP Server Application Adapter Deployment](#mfp-server-application-adapter-deployment)
* [MFP Server Application Center](#mfp-server-application-center)
* [MFP Server Prerequisite](#mfp-server-prerequisite)
* [MFP Server Runtime Deployment](#mfp-server-runtime-deployment)

### MFP Administration DB
This script package sets up the administration database schema in a DB2  database. It must be used with the Database Server (DB2) software component.

| Parameter | Description | 
|-----------|-------------|
| db_user   | Mandatory. User name to create the Administration database. It can be mapped to the Instance name of the Database Server component. Default value: db2inst1. |
| db_name	| Mandatory. Database name to create the Administration database. Default value: WLADM. |
| db_password |	Mandatory. User password to create the Administration database. It can be mapped to the Instance owner password of the Database Server component. Default value: passw0rd (as pattern level parameter). |
| other\_db\_args | Mandatory. Four parameters to create the Administration database:SQL type, Codeset,Territory and Collate. Default value: DB2 UTF-8 US SYSTEM. |

### MFP Analytics
This script package sets up {{ site.data.keys.mf_analytics_server }} in a WebSphere Application Server full profile or WebSphere Application Server Liberty profile server, and sets up the connection and mapping of Analytics administration security roles to an external TDS or AD server. It must be used with the WebSphere Application Server Liberty profile server or WebSphere Application Server full profile (display name: Standalone server) software component . It must be installed after the Liberty profile or Standalone server software component.

| Parameter | Description | 
|-----------|-------------|
| WAS_ROOT  | Mandatory.{::nomarkdown}<ul><li>If Analytics is installed on WebSphere Application Server Liberty profile, specify the installation directory of the WebSphere Application Server Liberty profile for Analytics.</li><li>If Analytics is installed on WebSphere Application Server full profile, specify the installation directory of the WebSphere Application Server full profile for Analytics.</li></ul>{:/} | 
| HEAP\_MIN\_SIZE | WebSphere Application Server full profile only.<br/><br/>Depending on the amount of Analytics data that is generated, more memory is required for more data handling. Set this to allow larger minimum heap size for WebSphere Application Server full profile. Make sure the memory size specified in the Core OS component of {{ site.data.keys.mf_analytics }} is larger than this. It is recommended to set the same value as HEAP_MAX_SIZE.<br/><br/>Default value: 4096 (MB). | 
| HEAP\_MAX\_SIZE	| WebSphere Application Server full profile only.<br/><br/>Depending on the amount of Analytics data that is generated, more memory is required for more data handling. Set this to allow larger maximum heap size for WebSphere Application Server full profile. Make sure the memory size specified in the Core OS component of {{ site.data.keys.mf_analytics }} is larger than this. It is recommended to set the same value asHEAP_MIN_SIZE.<br/><br/>Default value: 4096 (MB). | 
| WAS\_admin\_user | WebSphere Application Server full profile only.<br/><br/>WebSphere Application Server full profile admin user for the Analytics server. For WebSphere Application Server Liberty profile, leave the default value unchanged. | 
| WAS\_admin\_password | WebSphere Application Server full profile only.<br/><br/>WebSphere Application Server full profile admin user password for the Analytics server. For WebSphere Application Server Liberty profile, leave the default value unchanged. | 
| admin_user | Mandatory.{::nomarkdown}<ul><li>If LDAP repository not enabled, create a default administration user for {{ site.data.keys.mf_analytics_console }} protection.</li><li>If LDAP repository is enabled, specify the user name that has {{ site.data.keys.mf_analytics }} administration privilege. The value is stored in the LDAP repository.</li></ul> |
| admin_password | Mandatory.<ul><li>If an LDAP repository is not enabled, specify the password for the default administration user for {{ site.data.keys.mf_analytics_console }} protection.</li><li>If an LDAP repository is enabled, specify the admin user password. The value is stored in the LDAP repository.</li></ul>{:/} | 
| LDAP_TYPE | (LDAP parameter) Mandatory. LDAP server type of your user registry:<br/><br/>None<br/>LDAP connection is disabled. When this is set, all the other LDAP parameters are treated as placeholders only.<br/><br/>TivoliDirectoryServer<br/>Select this if the LDAP repository is an IBM  Tivoli  Directory Server.<br/><br/>ActiveDirectory<br/>Select this if the LDAP repository is a Microsoft Active Directory.<br/><br/>Default value: None. | 
| LDAP_IP | (LDAP parameter). LDAP server IP address. | 
| LDAP\_SSL\_PORT | (LDAP parameter) LDAP port for secure connection. | 
| LDAP_PORT | (LDAP parameter) LDAP port for non-secure connection. | 
| BASE_DN | (LDAP parameter) Base DN. | 
| BIND_DN | (LDAP parameter) Bind DN. | 
| BIND_PASSWORD | (LDAP parameter) Bind DN password. | 
| REQUIRE_SSL | (LDAP parameter) Set it to true for secure connection to LDAP server.{::nomarkdown}<ul><li>When it is true, LDAP_SSL_PORT is used and CERT_FILE_PATH is required to locate the certification file of the LDAP server.</li><li>When it is false, LDAP_PORT is used.</li></ul>{:/}Default value: false. | 
| USER_FILTER | (LDAP parameter) LDAP user filter that searches the existing user registry for users. | 
| GROUP_FILTER | (LDAP parameter) LDAP group filter that searches the existing user registry for groups. | 
| LDAP\_REPOSITORY\_NAME | (LDAP parameter) LDAP server name. | 
| CERT\_FILE\_PATH | (LDAP parameter) Target path of the uploaded LDAP server certification. It is mandatory when REQUIRE_SSL is set to true. | 
| mfpadmin | (LDAP parameter) Admin role for {{ site.data.keys.mf_server }}:<br/><br/>None<br/>No user.<br/><br/>AllAuthenticatedUsers<br/>Authenticated users<br/><br/>Everyone<br/>All users.<br/><br/>Default value: None. | 
| mfpdeployer | (LDAP parameter) Deployer role for {{ site.data.keys.mf_server }}:<br/><br/>None<br/>No user.<br/><br/>AllAuthenticatedUsers<br/>Authenticated users<br/><br/>Everyone<br/>All users.<br/><br/>Default value: None. | 
| mfpmonitor | (LDAP parameter) Monitor role for {{ site.data.keys.mf_server }}:<br/><br/>None<br/>No user.<br/><br/>AllAuthenticatedUsers<br/>Authenticated users<br/><br/>Everyone<br/>All users.<br/><br/>Default value: None. | 
| mfpoperator | (LDAP parameter) Operator role for {{ site.data.keys.mf_server }}:<br/><br/>None<br/>No user.<br/><br/>AllAuthenticatedUsers<br/>Authenticated users<br/><br/>Everyone<br/>All users.<br/><br/>Default value: None. | 

### MFP IHS Configuration
This script package configures the IBM HTTP Server to work as a load balancer for multiple instances of {{ site.data.keys.mf_server }}. It must be used with the IBM HTTP servers software component . It must be installed after the IBM HTTP servers software component.

| Parameter | Description | 
|-----------|-------------|
| WAS_ROOT | Mandatory. Installation directory of WebSphere Application Server Liberty profile or WebSphere Application Server full profile in the MobileFirst Platform Server node, or installation directory of Deployment manager in the DmgrNode node. In the pattern templates, it is mapped to output attribute `install_directory` of Liberty profile server, Standalone server, or Deployment manager. | 
| profile_name | Optional. The profile name that contains the files for the WebSphere Application Server runtime environment.<br/><br/>In the pattern templates, it is mapped to output attribute **dmgr\_profile\_name** of Deployment manager or sa_profile_name of Standalone server. | 
| runtime\_contextRoot\_list | Mandatory. Runtime context root list that allows IHS to route requests that have matching context roots. Use semicolons (;) to separate the runtime context roots. For example, HelloMobileFirst;HelloWorld<br/><br/>Important: It must align with the context root specified in the MFP Server Runtime Deployment. Otherwise, IHS cannot correctly route requests that contain the Runtime context root. | 
| http_port | Mandatory. Open the firewall port in the IHS Server node to allow the HTTP transport from IHS Server to {{ site.data.keys.mf_server }}. Must be 9080. | 
| https_port | Mandatory. Open the firewall port in the IHS Server node to allow the HTTPS transport from IHS Server to {{ site.data.keys.mf_server }}. Must be 9443. | 
| server_hostname | Mandatory. Host name of IBM HTTP servers. It is mapped to the host output attribute of IBM HTTP servers in the pattern template. | 

### MFP Open Firewall Ports for WAS
This script package is only applicable for Custom nodes in the {{ site.data.keys.product_adj }} (WAS ND) pattern template (WebSphere Application Server Network Deployment). Its purpose is to open the necessary firewall ports of the Custom nodes that host the {{ site.data.keys.product_adj }} Administration Services and runtime. As well as defining some WebSphere Application Server predefined ports, you need to specify the other ports for connecting to the DB2 server and the LDAP server.

| Parameter | Description | 
|-----------|-------------|
| WAS_ROOT | Mandatory. Installation directory of WebSphere Application Server Network Deployment Custom nodes in the CustomNode node. In the pattern templates, it is mapped to output attribute install_directory of Custom nodes server. |
| profile_name | Mandatory. The profile name that contains the files for the WebSphere Application Server runtime environment. In the pattern templates, it is mapped to output attribute cn_profile_name of Custom nodes. | 
| WAS\_admin\_user | Mandatory. It is mapped to the was_admin output attribute of Custom nodes in the pattern template. | 
| Ports	| Mandatory. Other ports that need to be opened for connecting to DB2 server and LDAP server (optional). Port values can be separated by semicolons; for example, '50000;636'<br/><br/>Default value: 50000. | 

### MFP WAS SDK Level
This script package is only applicable where ever the WAS Profiles are available in the pattern template (WebSphere Application Server Network Deployment).

| Parameter | Description | 
|-----------|-------------|
| WAS_ROOT | Installation directory of WebSphere Application Server Liberty profile or WebSphere Application Server full profile in the MobileFirst Platform Server node or the installation directory of the Deployment manager in the DmgrNode node. In the pattern templates, it is mapped to output attribute **install_directory** of Liberty profile server, Standalone server, or Deployment manager. |
| profile_name | The profile name that contains the files for the WebSphere Application Server runtime environment. In the pattern templates, it is mapped to output attribute **dmgr\_profile\_name** of Deployment manager or **sa\_profile\_name** of Standalone server. | 
| SDK_name | Name of the SDK that needs to be enabled for this WebSphere installation | 

### MFP Runtime DB
This script package sets up the runtime database schema in a DB2 database.

| Parameter | Description | 
|-----------|-------------|
| db_user | Mandatory. User name to create the Runtime database. It can be mapped to the Instance name of the Database Server component. Default value: db2inst1. | 
| db_name | Mandatory. Database name to create the Runtime database. Default value: WLRTIME. | 
| db_password | Mandatory. User password to create the Runtime database. It can be mapped to the Instance owner password of the Database Server component. Default value: passw0rd (as pattern level parameter). | 
| other\_db\_args |	Mandatory. Four parameters to create the Runtime database:SQL type, Codeset,Territory and Collate. Default value: DB2 UTF-8 US SYSTEM. | 

### MFP Server Administration
This script package sets up the {{ site.data.keys.product_adj }} Administration component (including the {{ site.data.keys.mf_console }}) in a WebSphere Application Server full profile or WebSphere Application Server Liberty profile server, and setting up the connection and mapping administration security roles to an external TDS or AD server.

The script package must be used with the WebSphere Application Server Liberty profile server software component or the WebSphere Application Server full profile software component (display name: Standalone server), and must be installed after the MFP Server Prerequisite but prior to any other MFP * Script Packages in the {{ site.data.keys.mf_server }} VM node.

| Parameter | Description |
|-----------|-------------|
| WAS_ROOT | Mandatory. Installation directory of WebSphere Application Server Liberty profile or WebSphere Application Server full profile in the MobileFirst Platform Server node or the installation directory of the Deployment manager in the DmgrNode node. In the pattern templates, it is mapped to output attribute `install_directory` of Liberty profile server, Standalone server, or Deployment manager. | 
| profile_name | Optional. The profile name that contains the files for the WebSphere Application Server runtime environment. In the pattern templates, it is mapped to output attribute dmgr_profile_name of Deployment manager or sa_profile_name of Standalone server. | 
| NUMBER\_OF\_CLUSTERMEMBERS | Optional. Only applicable for the {{ site.data.keys.product }} (WAS ND) pattern template. It specifies the number of cluster members for the cluster to deploy the MFP administration service. Default value: 2. | 
| db_user | Mandatory. User name that created the Administration database. It is mapped to the db_user output attribute of the MFP Administration DB script package in the pattern template. | 
| db_name | Mandatory. Name of the Administration database. It is mapped to the `db_name` output attribute of the MFP Administration DB script package in the pattern template. | 
| db_password |	Mandatory. Password for user who created the Administration database. It is mapped to the db_password output attribute of the MFP Administration DB script package in the pattern template.| 
| db_ip | IP address of the DB server where the Administration database is installed. It is mapped to the IP output attribute of the Database Server software component in the pattern template. | 
| db_port |  Port number of the DB server where the Administration database is installed. It is mapped to the instancePort output attribute of the Database Server software component in the pattern template. | 
| admin_user | User name that has {{ site.data.keys.mf_server }} administration privilege.{::nomarkdown}<ul><li>When LDAP_TYPE is None, create the default admin user.</li><li>When LDAP_TYPE is set to TivoliDirectoryServer or ActiveDirectory and other LDAP parameters are specified according to your LDAP server configuration, the admin_user value should be taken from the configured LDAP user repository. Not required when the {{ site.data.keys.mf_server }} is to be deployed on a single node of WebSphere Application Server full profile.</li></ul> | 
| admin_password | Password of the admin user.<ul><li>When LDAP_TYPE is None, create the default admin user password.</li><li>When an external LDAP server is configured, the user password is taken from the LDAP repository. Not required when the {{ site.data.keys.mf_server }} is to be deployed on a single node of WebSphere Application Server full profile.</li></ul> | 
| install_console | Whether the {{ site.data.keys.mf_console }} is to be deployed in the MobileFirst Platform Server node. Default value: Selected. (Check box) |
| WAS\_admin\_user | Optional. When the {{ site.data.keys.mf_server }} is deployed on WebSphere Application Server full profile, it is mapped to the was_adminoutput attribute of Standalone server in the pattern template. When the {{ site.data.keys.mf_server }} is deployed on WebSphere Application Server Network Deployment, it is mapped to the was_admin output attribute of Deployment manager in the pattern template. | 
| WAS\_admin\_password | Optional. When the {{ site.data.keys.mf_server }} is deployed on WebSphere Application Server full profile, it is mapped to the was\_admin\_password output attribute of Standalone server in the pattern template. When the {{ site.data.keys.mf_server }} is deployed on WebSphere Application Server Network Deployment, it is mapped to the was\_admin\_password output attribute of Deployment manager in the pattern template. | 
| server_hostname | Mandatory. Host name of the {{ site.data.keys.mf_server }} or Deployment manager. Mapped to the host output attribute of Liberty profile server, Standalone Server, or Deployment manager. | 
| server\_farm\_mode | Mandatory. Whether the {{ site.data.keys.mf_server }} is to be deployed in server farm mode. Must be selected for a server farm topology and must be cleared for a standalone topology. Default value: set according to the topology defined in the pattern template. | 
| webserver_ip | Optional. When IBM HTTP servers is deployed in the pattern template, this parameter is mapped to the IP output attribute of IBM HTTP servers. | 
| LDAP_TYPE | (LDAP parameter) Mandatory. LDAP server type of your user registry. One of the following values:<ul>None – LDAP connection is disabled. When this value is selected, all the other LDAP parameters are treated as placeholders only.</li><li>TivoliDirectoryServer: Select this value if the LDAP repository is IBM Tivoli Directory Server</li><li>ActiveDirectory: Select this value if the LDAP repository is Microsoft Active Directory</li></ul>{:/}Default value: None. | 
| LDAP_IP | (LDAP parameter) LDAP server IP address. | 
| LDAP_SSL_PORT | (LDAP parameter) LDAP port for secure connection. | 
| LDAP_PORT | (LDAP parameter) LDAP port for non-secure connection. | 
| BASE_DN | (LDAP parameter) Base DN. | 
| BIND_DN | (LDAP parameter) Bind DN. | 
| BIND_PASSWORD | (LDAP parameter) Bind DN password. | 
| REQUIRE_SSL | (LDAP parameter) Set to true for secure connection to LDAP server.{::nomarkdown}<ul><li>When true, the LDAP\_SSL\_PORT is used and CERT\_FILE\_PATH is required to locate the certification file of the LDAP server.</li><li>When false, LDAP_PORT is used.</li></ul>{:/}Default value: false. | 
| USER_FILTER | (LDAP parameter) User filter that searches the existing user registry for users. | 
| GROUP_FILTER | (LDAP parameter) LDAP group filter that searches the existing user registry for groups. | 
| LDAP\_REPOSITORY\_NAME | (LDAP parameter) LDAP server name. | 
| CERT\_FILE\_PATH | (LDAP parameter) Target path of the uploaded LDAP server certification. It is mandatory when REQUIRE_SSL is set to true. | 
| mfpadmin | Admin role for {{ site.data.keys.mf_server }}. One of the following values:<br/><br/>None<br/>No user.<br/><br/>AllAuthenticatedUsers<br/>Authenticated users<br/><br/>Everyone<br/>All users.<br/><br/>Default value: None. | 
| mfpdeployer | (LDAP parameter) Deployer role for {{ site.data.keys.mf_server }}:<br/><br/>None<br/>No user.<br/><br/>AllAuthenticatedUsers<br/>Authenticated users<br/><br/>Everyone<br/>All users.<br/><br/>Default value: None. | 
| mfpmonitor | (LDAP parameter) Monitor role for {{ site.data.keys.mf_server }}:<br/><br/>None<br/>No user.<br/><br/>AllAuthenticatedUsers<br/>Authenticated users<br/><br/>Everyone<br/>All users.<br/><br/>Default value: None. | 
| mfpoperator | (LDAP parameter) Operator role for {{ site.data.keys.mf_server }}:<br/><br/>None<br/>No user.<br/><br/>AllAuthenticatedUsers<br/>Authenticated users<br/><br/>Everyone<br/>All users.<br/><br/>Default value: None. | 

### MFP Server Application Adapter Deployment
This script package deploys applications and adapters to the {{ site.data.keys.mf_server }}. It must be installed after the corresponding MFP Server Runtime Deployment script package that installed the runtime where the application and adapter are to be deployed.

| Parameter | Description | 
|-----------|-------------|
| artifact_dir | Mandatory. Installation path of application and adapter for deployment. It is mapped to the target_pathoutput attribute of the {{ site.data.keys.product_adj }} App component in the pattern template. | 
| admin_context | Mandatory. Must be mfpadmin. | 
| runtime_context | Mandatory. Align with the runtime context root specified in the MFP Server Runtime Deployment component. It is mapped to runtime_contextRoot output attribute of the MFP Server Runtime Deployment component. | 
| deployer_user | Mandatory. User account with application and adapter deployment privilege. Set as pattern level parameter in the pattern template. | 
| deployer_password | Mandatory. User password with application and adapter deployment privilege. Set as pattern level parameter in the pattern template. | 
| webserver_ip | Optional. When IBM HTTP servers is deployed in the pattern template, it is mapped to the same output attribute of MFP Server Administration. | 

### MFP Server Application Center
This script package sets up the {{ site.data.keys.mf_app_center }} server in a WebSphere Application Server full profile or WebSphere Application Server Liberty profile server. It must be used with the WebSphere Application Server Liberty profile server and MFP Server Prerequisite or WebSphere Application Server full profile (Standalone server), MFP WAS SDK Level and MFP Server Prerequisite. It must be installed after the Liberty profile or Standalone server software component.

| Parameter | Description | 
|-----------|-------------|
| WAS_ROOT | Mandatory. Installation directory of WebSphere Application Server Liberty profile or WebSphere Application Server full profile in the MobileFirst Platform Server node. In the pattern templates, it is mapped to output attribute `install_directory` of Liberty profile server or Standalone server. | 
| profile_name | The profile name that contains the files for the WebSphere Application Server runtime environment. In the pattern templates, it is mapped to output attribute sa_profile_name of Standalone server. | 
| db_instance | Name of the database instance. It is mapped to the instancePort output attribute of the Database Server software component in the pattern template. | 
| db_user | User name that created the Administration database. It is mapped to the db_user output attribute of the MFP Administration DB script package in the pattern template. | 
| db_name | Name of the Administration database. It is mapped to the `db_name` output attribute of the MFP Administration DB script package in the pattern template. |
| db_password | Password for user who created the Administration database. It is mapped to the db_password output attribute of the MFP Administration DB script package in the pattern template. | 
| db_ip | IP address of the DB server where the Administration database is installed. It is mapped to the IP output attribute of the Database Server software component in the pattern template. | 
| db_port | Port number of the DB server where the Administration database is installed. It is mapped to the instancePort output attribute of the Database Server software component in the pattern template.|
| admin_user | User name that has {{ site.data.keys.mf_server }} administration privilege.<br/><br/>In the pattern template, it is associated with the parameter of the same name in the MFP Server Administration script package as a pattern level parameter to ensure they are set to the same value | 
| admin_password | admin user password.<br/><br/>In the pattern template, it is associated with the parameter of the same name in the MFP Server Administration script package as a pattern level parameter to ensure they are set to the same value | 
| WAS\_admin\_user | Mandatory for WebSphere Application Server. Optional for WebSphere Application Server Liberty. When the {{ site.data.keys.mf_server }} is deployed on WebSphere Application Server full profile, it is mapped to the was_adminoutput attribute of Standalone server in the pattern template.<br/><br/>When the {{ site.data.keys.mf_server }} is deployed on WebSphere Application Server Network Deployment, it is mapped to the was_admin output attribute of Deployment manager in the pattern template. | 
| WAS\_admin\_password | Mandatory for WebSphere Application Server. Optional for WebSphere Application Server Liberty. When the {{ site.data.keys.mf_server }} is deployed on WebSphere Application Server full profile, it is mapped to the was\_admin\_password output attribute of Standalone server in the pattern template. |
| server_hostname | Host name of the {{ site.data.keys.mf_server }}. It is mapped to the host output attribute of Liberty profile server or Standalone Server. |
| LDAP_TYPE | (LDAP parameter) Mandatory. LDAP server type of your user registry:<br/><br/>None<br/>LDAP connection is disabled. When this is set, all the other LDAP parameters are treated as placeholders only.<br/><br/>TivoliDirectoryServer<br/>Select this if the LDAP repository is an IBM  Tivoli  Directory Server.<br/><br/>ActiveDirectory<br/>Select this if the LDAP repository is a Microsoft Active Directory.<br/><br/>Default value: None. | 
| LDAP_IP | (LDAP parameter). LDAP server IP address. | 
| LDAP\_SSL\_PORT | (LDAP parameter) LDAP port for secure connection. | 
| LDAP_PORT | (LDAP parameter) LDAP port for non-secure connection. | 
| BASE_DN | (LDAP parameter) Base DN. | 
| BIND_DN | (LDAP parameter) Bind DN. | 
| BIND_PASSWORD | (LDAP parameter) Bind DN password. | 
| REQUIRE_SSL | (LDAP parameter) Set it to true for secure connection to LDAP server.{::nomarkdown}<ul><li>When it is true, LDAP_SSL_PORT is used and CERT_FILE_PATH is required to locate the certification file of the LDAP server.</li><li>When it is false, LDAP_PORT is used.</li></ul>Default value: false. | 
| USER_FILTER | (LDAP parameter) LDAP user filter that searches the existing user registry for users. | 
| GROUP_FILTER | (LDAP parameter) LDAP group filter that searches the existing user registry for groups. | 
| LDAP\_REPOSITORY\_NAME | (LDAP parameter) LDAP server name. | 
| CERT\_FILE\_PATH | (LDAP parameter) Target path of the uploaded LDAP server certification. It is mandatory when REQUIRE_SSL is set to true. | 
| appcenteradmin | Admin role for {{ site.data.keys.mf_app_center }}. Use one of the following values:<ul><li>None</li><li>No user</li><li>AllAuthenticatedUsers</li>Authenticated users</li><li>Everyone</li><li>All users</li></ul>{:/}Default value: None | 

### MFP Server Prerequisite
This script package includes all prerequisites that are required to install the {{ site.data.keys.mf_server }}, including the DB2 JDBC driver and Apache Ant. The script package must be used with the WebSphere Application Server Liberty profile server software component or the WebSphere Application Server full profile software component (display name: Standalone server), and must be installed after the server software component but prior to any other MFP* script packages in the MobileFirst Platform Server node.

| Parameter | Description |
|-----------|-------------|
| None | No parameters for this script package. | 

### MFP Server Runtime Deployment
This script package installs the {{ site.data.keys.product }} runtime in a WebSphere Application Server full profile or WebSphere Application Server Liberty profile server with the {{ site.data.keys.mf_console }} installed. The script package also sets up the connection to the {{ site.data.keys.mf_analytics_server }}. It must be installed after the MFP Server Administration script package.

| Parameter | Description |
|-----------|-------------|
| WAS_ROOT | Mandatory. Installation directory of WebSphere Application Server Liberty profile or WebSphere Application Server full profile in the MobileFirst Platform Server node, or installation directory of Deployment manager in the DmgrNode node. In the pattern templates, it is mapped to output attribute install_directory of Liberty profile server or Standalone server. | 
| profile_name | Optional. The profile name that contains the files for the WebSphere Application Server runtime environment. In the pattern templates, it is mapped to output attribute dmgr\_profile\_name of Deployment manager or sa\_profile\_name of Standalone server. |
| NUMBER\_OF\_CLUSTERMEMBERS | Optional. Only applicable for the {{ site.data.keys.product }} (WAS ND) pattern template. It specifies the number of cluster members for the cluster to deploy MFP runtime. Default value: 2. | 
| db_ip | IP address of the DB server where the Runtime (and optional Reports) database is installed. It is mapped to the IP output attribute of the Database Server software component in the pattern template. |
| db_port | Port number of the DB server where the Runtime (and optional Reports) database is installed. It is mapped to theinstancePort output attribute of the Database Server software component in the pattern template. |
| admin_user | Mandatory. User name that has {{ site.data.keys.mf_server }} administration privilege. In the pattern template, it is associated with the parameter of the same name in the MFP Server Administration script package as a pattern level parameter to ensure they are set to the same value | 
| admin_password | Mandatory. admin user password. In the pattern template, it is associated with the parameter of the same name in the MFP Server Administration script package as a pattern level parameter to ensure they are set to the same value | 
| runtime_path | Mandatory. Runtime WAR file installed path. For example: it can be mapped to the target_path output attribute of MFP Server Runtime in the pattern template. | 
| runtime_contextRoot | Mandatory. Runtime context root. Must start with a forward slash, /; for example, "/HelloWorld". It is set as a pattern level parameter in the pattern template. | 
| rtdb_name | Mandatory. Name of the Runtime database. It is mapped to the `db_name` output attribute of the MFP Runtime DB script package in the pattern template. | 
| rtdb_user | Mandatory. User that created the Runtime database. It is mapped to the `db_user` output attribute of the MFP Runtime DB script package in the pattern template. |
| rtdb_password | Mandatory. Password of the user that created the Runtime database. It is mapped to the `db_password` output attribute of the MFP Runtime DB script package in the pattern template. |
| rptdb_name | Optional. Name of the Reports database. It is mapped to the `db_name` output attribute of the MFP Reports DB script package in the pattern template. Leave blank if you do not want to connect to a Reports database. |
| rptdb_user | Optional. User that created the Reports database. It is mapped to the `db_user` output attribute of the MFP Reports DB script package in the pattern template. | 
| rptdb_password | Optional. Password of the user that created the Reports database. It is mapped to the `db_password` output attribute of MFP Reports DB script package in the pattern template. \ 
| was\_admin\_user	| Optional. When the {{ site.data.keys.mf_server }} is deployed on WebSphere Application Server full profile, it is mapped to the was_adminoutput attribute of Standalone server in the pattern template. When the {{ site.data.keys.mf_server }} is deployed on WebSphere Application Server Network Deployment, it is mapped to the was_admin output attribute of Deployment manager in the pattern template. |
| was_admin_password | Optional. When the {{ site.data.keys.mf_server }} is deployed on WebSphere Application Server full profile, it is mapped to thewas_admin_password output attribute of Standalone server in the pattern template. When the {{ site.data.keys.mf_server }} is deployed on WebSphere Application Server Network Deployment, it is mapped to the was_admin_password output attribute of Deployment manager in the pattern template. | 
| server_farm_mode | Mandatory. Map it to the same attribute of MFP Server Administration. | 
| server_hostname | Mandatory. Host name of the {{ site.data.keys.mf_server }}. It is mapped to the host output attribute of Liberty profile server, Standalone Server, or Deployment manager. |
| analytics_ip | Optional. {{ site.data.keys.mf_analytics }} Node IP address to enable the Analytics capability in the MFP Server Runtime. |
| analytics_admin_user | Optional. Administrator name of the {{ site.data.keys.mf_analytics_server }}. | 
| analytics_admin_password | Optional. Password of administrator of the {{ site.data.keys.mf_analytics_server }}. | 

## Upgrading {{ site.data.keys.mf_system_pattern }}
To upgrade {{ site.data.keys.mf_system_pattern }}, upload the **.tgz** file that contains the latest updates.

1. Log into IBM  PureApplication  System with an account that is allowed to upload new system plugins.
2. From the IBM PureApplication System console, navigate to **Catalog → System Plug-ins**.
3. Upload the {{ site.data.keys.mf_system_pattern }} **.tgz** file that contains the updates.
4. Enable the plugins you have uploaded.
5. Redeploy the pattern.

