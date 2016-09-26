---
layout: tutorial
title: Deploying MobileFirst Server on IBM PureApplication System
weight: 10
---
## Overview
IBM MobileFirst Foundation provides the capability to deploy and manage IBM MobileFirst Server and MobileFirst applications on IBM® PureApplication® System and IBM PureApplication Service on SoftLayer®.

IBM MobileFirst Platform Foundation in combination with IBM PureApplication System and IBM PureApplication Service on SoftLayer provides a simple and intuitive environment for developers and administrators, to develop mobile applications, test them, and deploy them to the cloud. This version of IBM MobileFirst Platform Foundation System Pattern provides MobileFirst runtime and artifacts support for the PureApplication Virtual System Pattern technologies that are included in the most recent versions of IBM PureApplication System and IBM PureApplication Service on SoftLayer. Classic Virtual System Pattern was supported in earlier versions of IBM PureApplication System.

#### Jump to
* [Installing IBM MobileFirst Foundation System Pattern](#installing-ibm-mobilefirst-foundation-system-pattern)
* [Token licensing requirements for IBM MobileFirst Foundation System Pattern](#token-licensing-requirements-for-ibm-mobilefirst-foundation-system-pattern)
* [Deploying MobileFirst Server on a single-node WebSphere Application Server Liberty profile server](#deploying-mobilefirst-server-on-a-single-node-websphere-application-server-liberty-profile-server)
* [Deploying MobileFirst Server on a multiple-node WebSphere Application Server Liberty profile server](#deploying-mobilefirst-server-on-a-multi-node-websphere-application-server-liberty-profile-server)
* [Deploying MobileFirst Server on a single-node WebSphere Application Server full profile server](#deploying-mobilefirst-server-on-a-single-node-websphere-application-server-full-profile-server)
* [Deploying MobileFirst Server on a multiple-node WebSphere Application Server full profile server](#deploying-mobilefirst-server-on-a-multi-node-websphere-application-server-full-profile-server)
* [Deploying MobileFirst Server on clusters of WebSphere Application Server Network Deployment servers](#deploying-mobilefirst-server-on-clusters-of-websphere-application-server-network-deployment-servers)
* [Deploying MobileFirst Application Center on a single-node WebSphere Application Server Liberty profile server](#deploying-mobilefirst-application-center-on-a-single-node-websphere-application-server-liberty-profile)
* [Deploying MobileFirst Application Center on a single-node WebSphere Application Server full profile server](#deploying-mobilefirst-application-center-on-a-single-node-websphere-application-server-full-profile)
* [Configuring MobileFirst administration security with an external LDAP repository](#configuring-mobilefirst-administration-security-with-an-external-ldap-repository)
* [Configuring an external database with a IBM MobileFirst Foundation System Pattern](#configuring-an-external-database-with-a-ibm-mobilefirst-foundation-system-pattern)
* [Deploying and configuring MobileFirst Analytics](#deploying-and-configuring-mobilefirst-analytics)
* [Predefined templates for MobileFirst Pattern](#predefined-templates-for-mobilefirst-pattern)
* [Script packages for MobileFirst Server](#script-packages-for-mobilefirst-server)
* [Upgrading IBM MobileFirst Foundation System Pattern](#upgrading-ibm-mobilefirst-foundation-system-pattern)

### Key benefits
IBM MobileFirst  Foundation System Pattern provides the following benefits:

* Predefined templates enable you to build patterns in a simple way for the most typical MobileFirst Server deployment topologies. Examples of the topologies are:  
    * IBM WebSphere® Application Server Liberty profile single node
    * IBM WebSphere Application Server Liberty profile multiple nodes
    * IBM WebSphere Application Server full profile single node
    * IBM WebSphere Application Server full profile multiple nodes
    * Clusters of WebSphere Application Server Network Deployment servers
        
    In V8.0.0 MobileFirst Application Center, deployment topologies such as:
        * IBM WebSphere Application Server Liberty profile single node
        * IBM WebSphere Application Server full profile single node
* Script packages act as building blocks to compose extended deployment topologies such as automating the inclusion of an analytics server in a pattern and flexible DB VM deployment options. WebSphere Application Server and DB2® script packages are available through the inclusion of WebSphere Application Server and DB2 pattern types.
* Optional JNDI properties in the runtime deployment script package allow fine-grained tuning for the deployment topology. In addition, deployment topologies that are built with IBM WebSphere Application Server full profile now support accessing the WebSphere Application Server Administration Console, which gives you full control over the configuration of the application server.

### Important restrictions
Depending on the pattern template you use, do not change some of the component attributes. If you change any of these component attributes, the deployment of patterns that are based on these templates fails.

#### MobileFirst Platform (Application Center Liberty single node)
Do not change the values for the following attributes in the Liberty profile server:

* WebSphere product Installation directory
* Configuration data location
* Liberty profile server name
* Under Install an IBM Java SDK, select only Java SDK V7.0 or Java SDK V7.1
* Select the Install additional features and clear the selection of IBM WebSphere eXtreme Scale.

#### MobileFirst Platform (Application Center WebSphere Application Server single node)
Do not change the values for the following attributes in the Liberty profile server:

* WebSphere product Installation directory
* Configuration data location
* Cell name
* Node name
* Profile name
* Under Install an IBM Java SDK, select only Java SDK V7.0 or Java SDK V7.1
* Select the Install additional features and clear the selection of IBM WebSphere eXtreme Scale.

#### MobileFirst Platform (Liberty single node)
Do not change the values for the following attributes in the Liberty profile server:

* WebSphere product Installation directory
* Configuration data location
* Liberty profile server name
* Under Install an IBM Java SDK, select only Java SDK V7.0 or Java SDK V7.1
* Select the Install additional features and clear the selection of IBM WebSphere eXtreme Scale.

#### MobileFirst Platform (Liberty server farm)
Do not change the values for the following attributes in the Liberty profile server:

* WebSphere product Installation directory
* Configuration data location
* Liberty profile server name
* Under Install an IBM Java SDK, select only Java SDK V7.0 or Java SDK V7.1
* Select the Install additional features and clear the selection of IBM WebSphere eXtreme Scale.

#### MobileFirst Platform (WebSphere Application Server single node) template
In the **Standalone server component** of the MobileFirst Server node, do not unlock or change the values for any of the following attributes:

* Cell name
* Node name
* Profile name
* If you change any of these attributes, your pattern deployment fails.

#### MobileFirst Platform (WebSphere Application Server server farm) template
In the **Standalone server component** of the MobileFirst Server node, do not unlock or change the values for any of the following attributes:

* Cell name
* Node name
* Profile name
* If you change any of these attributes, your pattern deployment fails.

#### MobileFirst Platform (WebSphere Application Server Network Deployment) template
In the **Deployment manager component** of the **DmgrNode node** or the **Custom nodes component** of the **CustomNode node**, do not unlock or change the values for any of the following attributes:

* Cell name
* Node name
* Profile name

If you change any of these attributes, your pattern deployment fails.

### Limitations
The following limitations apply:

* Dynamic scaling for WebSphere Application Server Liberty profile server farms and WebSphere Application Server full profile server farms is not supported. The number of server farm nodes can be specified in the pattern by setting the scaling policy but cannot be changed during run time.
* The IBM MobileFirst Foundation System Pattern Extension for MobileFirst Studio and Ant command-line interface that is supported in versions earlier than V7.0 are not available in this version of IBM MobileFirst Platform Foundation System Pattern.
* IBM MobileFirst Foundation System Pattern depends on WebSphere Application Server Patterns, which has its own restrictions. For more information, see [Restrictions for WebSphere Application Server Patterns](http://ibm.biz/knowctr#SSAJ7T_1.0.0/com.ibm.websphere.waspatt20base.doc/ae/rins_patternsB_restrictions.html).
* Due to restrictions in the uninstallation of Virtual System Patterns, you must delete the script packages manually after you delete the pattern type. In IBM PureApplication System, go to **Catalog → Script Packages** to delete the script packages that are listed in the **Components** section.
* The MobileFirst (WebSphere Application Server Network Deployment) pattern template does not support token licensing. If you want to use this pattern, you must use perpetual licensing. All other patterns support token licensing.

### Composition
IBM MobileFirst Platform Foundation System Pattern is composed of the following patterns:

* IBM WebSphere Application Server Network Deployment Patterns 2.2.0.0.
* [PureApplication Service] WebSphere 8558 for Mobile IM repository to allow the WebSphere Application Server Network Deployment Patterns to work. Contact the administrator for IBM PureApplication System to confirm that the WebSphere 8558 IM repository is installed.
* IBM DB2 with BLU Acceleration® Pattern 1.2.4.0.
* IBM MobileFirst Platform Foundation System Pattern.

### Components
In addition to all components provided by IBM WebSphere Application Server Pattern and IBM DB2 with BLU Acceleration Pattern, IBM MobileFirst Platform Foundation System Pattern provides the following Script Packages:

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
If you use MobileFirst Studio V6.3.0 or earlier to develop your applications, you can upload the associated runtime, application, and adapter artifacts into patterns associated with IBM MobileFirst Platform Foundation V7.0.0 and later.

Pattern types that are associated with IBM MobileFirst Platform Foundation V6.3.0 or earlier are not compatible with runtime, application, and adapter artifacts created by using MobileFirst Studio V7.0.0 and later.

For versions V6.0.0 and earlier, only the same versions of server, .war file, application (.wlapp file), and adapters are compatible.

## Installing IBM MobileFirst Foundation System Pattern
You can find the vsys.mobilefirst-8.0.0.0.tgz file in the mobilefirst_patterns_8.0.0.zip file. Make sure you extract it before you start this procedure.

1. Log in to IBM® PureApplication System with an account that has permission to create new pattern types.
2. Go to **Catalog → Pattern Types**.
3. Upload the IBM MobileFirst Platform Foundation System Pattern .tgz file:
    * On the toolbar, click **+**. The "Install a pattern type" window opens.
    * the Local tab, click **Browse**, select the IBM MobileFirst Platform Foundation System Pattern .tgz file, and then wait for the upload process to complete. The pattern type is displayed in the list and is marked as not enabled.
4. In the list of pattern types, click the uploaded pattern type. Details of the pattern type are displayed.
5. In the License Agreement row, click **License**. The License window is displayed stating the terms of the license agreement.
6. To accept the license, click **Accept**. Details of the pattern type now show that the license is accepted.
7. In the Status row, click **Enable**. The pattern type is now listed as being enabled.
8. Mandatory for PureApplication Service: After the pattern type is enabled successfully, go to **Catalog → Script** Packages and select script packages with names similar to "MFP \*\*\*". On the details page to the right, accept the license in the **License agreement** field. Repeat for all eleven script packages listed in the Components section.

## Token licensing requirements for IBM MobileFirst Platform Foundation System Pattern
If you use token licensing to license IBM MobileFirst™ Platform Foundation, you must install IBM® Rational® License Key Server and configure with your licenses before you deploy the MobileFirst Platform Pattern.

> **Important:** The **MobileFirst Platform (WAS ND)** pattern template does not support token licensing. You must be using perpetual licensing when you deploy patterns based on the MobileFirst Platform (WAS ND) pattern template. All other pattern templates support token licensing.

Your IBM Rational License Key Server must be external to your PureApplication® System. MobileFirst Pattern do not support the PureApplication System shared service for IBM Rational License Key Server.

In addition, you must know the following information about your Rational License Key Server to add the license key server information to your pattern attributes:

* Fully qualified host name or IP address of your Rational License Key Server
* License manager daemon (**lmgrd**) port
* Vendor daemon (**ibmratl**) port

If you have a firewall between your Rational License Key Server and your PureApplication System, ensure that both daemon ports are open in your firewall.
The deployment of MobileFirst Pattern fails if the license key server cannot be contacted or if insufficient license tokens are available.

For details about installing and configuring Rational License Key Server, see [IBM Support - Rational licensing start page](http://www.ibm.com/software/rational/support/licensing/).

## Deploying MobileFirst Server on a single-node WebSphere Application Server Liberty profile server
You use a predefined template to deploy MobileFirst Server on a single-node WebSphere® Application Server Liberty profile server.

This procedure involves uploading certain artifacts to IBM® PureApplication® System such as the required application and adapter. Before you begin, ensure that the artifacts are available for upload.

**Token licensing requirements:** If you use token licensing to license IBM MobileFirst Foundation, review the requirements outlined in [Token licensing requirements for IBM MobileFirst  Foundation System Pattern](#token-licensing-requirements-for-ibm-mobilefirst-foundation-system-pattern) before you continue. The deployment of this pattern fails if the license key server cannot be contacted or if insufficient license tokens are available.

Some parameters of script packages in the template have been configured with the recommended values and are not mentioned in this section. For fine-tuning purposes, see more information about all the parameters of script packages in [Script packages for MobileFirst Server](#script-packages-for-mobilefirst-server).

For more information about the composition and configuration options of the predefined template that is used in this procedure, see [MobileFirst Platform (Liberty single node) template](#mobilefirst-liberty-single-node-template).

1. Create a pattern from the predefined template:
    * In the IBM PureApplication System dashboard, click **Patterns → Virtual System Patterns**. The Virtual System Patterns page opens.
    * On the **Virtual System Patterns** page, click **Create New**, and then in the pop-up window, select **MobileFirst Platform (Liberty single node)** from the list of predefined templates. If the name is only partially visible due to its length, you can confirm that the correct template is selected by viewing its description on the **More information** tab.
    * In the **Name** field, provide a name for the pattern.
    * In the **Version** field, specify the version number of the pattern.
    * Click **Start Building**.
2. Mandatory for AIX®: In IBM PureApplication System running on Power®, the MobileFirst Platform DB node needs to use the AIX-specific add-on component "Default AIX add disk" to replace the "Default add disk" component in the template to support the jfs2 file system:
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
3. Optional: Configure MobileFirst Server administration. You can skip this step if you want to specify the user credential with MobileFirst Server administration privilege later during the pattern deployment configuration phase in step 9. To specify it now, complete these steps:

    > **Note:** If you want to configure administration security with an LDAP server, you need to supply additional LDAP information. For more information, see [Configuring MobileFirst administration security with an external LDAP repository](#configuring-mobilefirst-administration-security-with-an-external-ldap-repository).
    * In the MobileFirst Platform Server node, click the **MFP Server Administration** component. The properties of the selected component are displayed next to the canvas.
    * Next to the **admin_user** and **admin_password** fields, click the Delete button to clear their pattern level parameter settings.
    * In the **admin_user** and **admin\_password** fields, specify the administration user name and password.
    * If you use token licensing to license IBM MobileFirst Platform Foundation, complete the following fields. If you do not use token licensing, leave these fields blank.

    **ACTIVATE\_TOKEN\_LICENSE**: Select this field to license your pattern with token licensing.  
    **LICENSE\_SERVER\_HOSTNAME**: Enter the fully qualified host name or IP address of your Rational License Key Server.  
    **LMGRD\_PORT**: Enter the port number that the license manager daemon (**lmrgd**) listens for connections on. The default license manager daemon port is 27000.  
    **IBMRATL\_PORT**:Enter the port number that the vendor daemon (**ibmratl**) listens for connections on. The default vendor daemon port is typically 27001.  

    A default administration account for MobileFirst Server is created during pattern deployment.

4. Optional: Configure MobileFirst Server runtime deployment. You can skip this step if you want to specify the context root name for the runtime later during the pattern deployment configuration phase in step 9. To specify the context root name now, complete these steps:
    * In the MobileFirst Platform Server node, click the **MFP Server Runtime Deployment** component. The properties of the selected component are displayed next to the canvas.
    * Next to the **runtime\_contextRoot** field, click the **Delete** button to clear the pattern level parameter setting.
    * In the **runtime\_contextRoot** field, specify the runtime context root name. Note that the context root name must start with a forward slash, /; for example, `/HelloWorld`.

5. Upload application and adapter artifacts:

    > **Important:** When specifying the Target path for applications and adapters, make sure all the applications and adapters are placed in the same directory. For example, if one target path is **/opt/tmp/deploy/HelloWorld-common.json**, all the other target paths should be `/opt/tmp/deploy/*`.
    * In the MobileFirst Platform Server node, click the **MFP Server Application** or **MFP Server Adapter** component. The properties of the selected component are displayed next to the canvas.
    * In the **Additional file** field, click the **Browse** button to locate and upload the application or adapter artifact.
    * In the **Target path** field, specify the full path for storing the artifact including its file name; for example, **/opt/tmp/deploy/HelloWorld-common.json**.
    * If no application or adapter is to be deployed in the pattern, remove the relevant component by clicking the **X** button inside it. To get an empty MobileFirst Operations Console deployed without any app or adapter installed, remove the MFP Server Application Adapter Deployment component by clicking the X button inside it.

6. Optional: Add more application or adapter artifacts for deployment:
    * From the **Assets** toolbar, expand **Software Components**, and then drag and drop an **Additional file** component onto the MobileFirst Paltform Server node in the canvas. Rename it **MobileFirst App\_X** or **MobileFirst Adatper\_X** (where **X** stands for a unique number for differentiation).
    * Hover the cursor over the newly added App or Adapter component, and then click the **Move Up** and **Move Down** buttons to adjust its sequence in the node. Make sure it is placed after the MFP Runtime Deployment component but before the MFP Server Application Adapter Deployment component.
    * Click the newly added application or adapter component. The properties of the selected component are displayed next to the canvas. Upload the application or adapter artifact and specify its target path by referring to the steps in step 6.
    * Repeat step 7 to add more applications and adapters for deployment.

7. Optional: Configure application and adapter deployment to MobileFirst Server. You can skip this step if you want to specify the user credential with deployment privilege later during the pattern deployment configuration phase in step 9. If you have specified the default admin user credential in step 3, you can now specify the deployer user, which must align with the admin user credential:
    * In the MobileFirst Platform Server node, select the **MFP Server Application Adapter Deployment** component. The properties of the selected component are displayed next to the canvas.
    * Find the parameters named **deployer_user** and **deployer_password**, and then click the adjacent Delete buttons to clear the pattern level parameter settings.
    * In the **deployer\_user** and **deployer\_password** fields, specify the user name and password.

8. Configure and launch the pattern deployment:
    * In the IBM PureApplication System dashboard, click **Patterns → Virtual System Patterns**.
    * On the Virtual System Patterns page, use the **Search** field to find the pattern you created, and then select the pattern.
    * In the toolbar above the panel displaying detailed information about the pattern, click the Deploy button.
    * In the Deploy Pattern window, in the Configure panel, select the correct environment profile from the **Environment Profile** list, and provide other IBM PureApplication System environment parameters. To obtain the correct information, consult your IBM PureApplication System administrator.
    * In the middle column, click **Pattern attributes** to display attributes such as user names and passwords.

        Supply the following information in the fields provided:

        > **Note:** Make appropriate changes to the default values of the pattern-level parameters even if an external LDAP server is configured. If you configure administration security by using an LDAP server, you need to supply additional LDAP information. For more information, see [Configuring MobileFirst administration security with an external LDAP repository](#configuring-mobilefirst-administration-security-with-an-external-ldap-repository).
        
        **admin\_user**  
        Not visible if configured in step 3. Create a default MobileFirst Server administrator account. Default value: demo.
        
        **admin\_password**  
        Not visible if configured in step 3. Default admin account password. Default value: demo.
        
        **ACTIVATE\_TOKEN\_LICENSE**  
        Not visible if configured in step 3. Select this field to license your pattern with token licensing. Leave this field clear if you use perpetual licenses.
        
        **LICENSE\_SERVER\_HOSTNAME**  
        Not visible if configured in step 3. If you use token licensing to license IBM MobileFirst Platform Foundation, enter the fully-qualified hostname or IP address of your Rational License Key Server IP address. Otherwise, leave this field blank.
        
        **LMGRD\_PORT**   
        Not visible if configured in step 3. If you use token licensing to license IBM MobileFirst Platform Foundation, enter the port number that the license manager daemon (lmrgd) listens for connections on. Otherwise, leave this field blank.
        The default license manager daemon port is 27000.

        **IBMRATL\_PORT**  
        Not visible if configured in step 3. If you use token licensing to license IBM MobileFirst Platform Foundation, enter the port number that the vendor daemon (ibmratl) listens for connections on. Otherwise, leave this field blank.
        The default vendor daemon port is typically 27001.

        **runtime\_contextRoot**  
        Not visible if configured in step 5. Context root name for the MobileFirst Server runtime. The name must start with "/".
        
        **deployer\_user**  
        Not visible if configured in step 8. User name for the account with deployment privilege. If an external LDAP server is not configured, you must enter the same value as was specified when creating the default admin user for the administration service, because in this case, the only authorized user for app and adapter deployment is the default admin user.
        
        **deployer\_password**  
        Not visible if configured in step 8. User password for the user with deployment privilege.
        
        **MFP Vms Password(root)**  
        Root password for the MobileFirst Platform Server and MobileFirst Platform DB nodes. Default value: passw0rd.
        
        **MFP DB Password(Instance owner)**  
        Instance owner password for the MobileFirst Platform DB node. Default value: **passw0rd**.    
    * Click **Quick Deploy** to launch your pattern deployment. After a few seconds, a message is displayed to indicate that the pattern has started to launch. You can click the URL provided in the message to track your pattern deployment status or go to **Patterns → Virtual System Instances** to open the Virtual System Instances page and search for your pattern there.

    If you use token licensing to licenseIBM MobileFirst Platform Foundation, your pattern will fail to deploy if insufficient license tokens are available or if the license key server IP address and port were entered incorrectly.

9. Access the MobileFirst Operations Console:
    * Click **Patterns → Virtual System Instances** to open the Virtual System Instances page and search for your pattern there. Make sure it is in Running state.
    * Select the pattern name and expand the **Virtual machine perspective** option in the panel displaying details of the selected instance.
    * Find the MobileFirst Server VM that has a name similar to **MobileFirst\_Platform\_Server.** and make a note of its Public IP address: you need this information in the following step.
    * In the browser, open the MobileFirst Operations Console by composing its URL with one of the following formats:
        * `http://{MFP Server VM Public IP}:9080/mfpconsole`
        * `https://{MFP Server VM Public IP}:9443/mfpconsole`
    * Log in to the Console with admin user and password specified in step 3 or step 9.

## Deploying MobileFirst Server on a multiple-node WebSphere Application Server Liberty profile server
You use a predefined template to deploy MobileFirst Server on a multiple-node WebSphere® Application Server Liberty profile server.

This procedure involves uploading certain artifacts to IBM® PureApplication® System such as the required application and adapter. Before you begin, ensure that the artifacts are available for upload.

**Token licensing requirements:** If you use token licensing to license IBM MobileFirst Foundation, review the requirements outlined in [Token licensing requirements for IBM MobileFirst  Foundation System Pattern](#token-licensing-requirements-for-ibm-mobilefirst-foundation-system-pattern) before you continue. The deployment of this pattern fails if the license key server cannot be contacted or if insufficient license tokens are available.

Some parameters of script packages in the template have been configured with the recommended values and are not mentioned in this section. For fine-tuning purposes, see more information about all the parameters of script packages in [Script packages for MobileFirst Server](#script-packages-for-mobilefirst-server).

For more information about the composition and configuration options of the predefined template that is used in this procedure, see [MobileFirst Platform (Liberty server farm) template](#mobilefirst-liberty-server-farm-template).

1. Create a pattern from the predefined template:
    * In the IBM PureApplication System dashboard, click **Patterns → Virtual System Patterns**. The **Virtual System Patterns** page opens.
    * On the **Virtual System Patterns** page, click **Create New**, and then in the pop-up window, select **MobileFirst Platform (Liberty server farm)** from the list of predefined templates. If the name is only partially visible due to its length, you can confirm that the correct template is selected by viewing its description on the **More information** tab.
    * In the **Name** field, provide a name for the pattern.
    * In the **Version** field, specify the version number of the pattern.
    * Click **Start Building**.
2. Mandatory for AIX®: In IBM PureApplication System running on Power®, the MobileFirst Platform DB node needs to use the AIX-specific add-on component "Default AIX add disk" to replace the "Default add disk" component in the template to support the **jfs2** file system:
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
3. Optional: Configure MobileFirst Server administration. You can skip this step if you want to specify the user credential with MobileFirst Server administration privilege later during the pattern deployment configuration phase in step 9. To specify it now, complete these steps:

    > **Note:** If you want to configure administration security with an LDAP server, you need to supply additional LDAP information. For more information, see [Configuring MobileFirst administration security with an external LDAP repository](#configuring-mobilefirst-administration-security-with-an-external-ldap-repository).
    * In the MobileFirst Platform Server node, click the **MFP Server Administration** component. The properties of the selected component are displayed next to the canvas.
    * Next to the **admin_user** and **admin_password** fields, click the Delete button to clear their pattern level parameter settings.
    * In the **admin_user** and **admin\_password** fields, specify the administration user name and password.
    * If you use token licensing to license IBM MobileFirst Platform Foundation, complete the following fields. If you do not use token licensing, leave these fields blank.

    **ACTIVATE\_TOKEN\_LICENSE**: Select this field to license your pattern with token licensing.  
    **LICENSE\_SERVER\_HOSTNAME**: Enter the fully qualified host name or IP address of your Rational License Key Server.  
    **LMGRD\_PORT**: Enter the port number that the license manager daemon (**lmrgd**) listens for connections on. The default license manager daemon port is 27000.  
    **IBMRATL\_PORT**:Enter the port number that the vendor daemon (**ibmratl**) listens for connections on. The default vendor daemon port is typically 27001.  

    A default administration account for MobileFirst Server is created during pattern deployment.
    
4. Optional: Configure MobileFirst Server runtime deployment. You can skip this step if you want to specify the context root name for the runtime later during the pattern deployment configuration phase in step 10. To specify the context root name now, complete these steps:
    * In the MobileFirst Platform Server node, click the **MFP Server Runtime Deployment** component. The properties of the selected component are displayed next to the canvas.
    * Next to the **runtime\_contextRoot** field, click the **Delete** button to clear the pattern level parameter setting.
    * In the **runtime\_contextRoot** field, specify the runtime context root name. Note that the context root name must start with a forward slash, /; for example, `/HelloWorld`.

5. Upload application and adapter artifacts:

    > **Important:** When specifying the Target path for applications and adapters, make sure all the applications and adapters are placed in the same directory. For example, if one target path is **/opt/tmp/deploy/HelloWorld-common.json**, all the other target paths should be `/opt/tmp/deploy/*`.
    * In the MobileFirst Platform Server node, click the **MFP Server Application** or **MFP Server Adapter** component. The properties of the selected component are displayed next to the canvas.
    * In the **Additional file** field, click the **Browse** button to locate and upload the application or adapter artifact.
    * In the **Target path** field, specify the full path for storing the artifact including its file name; for example, **/opt/tmp/deploy/HelloWorld-common.json**.
    * If no application or adapter is to be deployed in the pattern, remove the relevant component by clicking the **X** button inside it. To get an empty MobileFirst Operations Console deployed without any app or adapter installed, remove the MFP Server Application Adapter Deployment component by clicking the X button inside it. 

6. Optional: Add more application or adapter artifacts for deployment:
    * From the **Assets** toolbar, expand **Software Components**, and then drag and drop an **Additional file** component onto the MobileFirst Paltform Server node in the canvas. Rename it **MobileFirst App\_X** or **MobileFirst Adatper\_X** (where **X** stands for a unique number for differentiation).
    * Hover the cursor over the newly added App or Adapter component, and then click the **Move Up** and **Move Down** buttons to adjust its sequence in the node. Make sure it is placed after the MFP Runtime Deployment component but before the MFP Server Application Adapter Deployment component.
    * Click the newly added application or adapter component. The properties of the selected component are displayed next to the canvas. Upload the application or adapter artifact and specify its target path by referring to the steps in step 6.
    * Repeat step 7 to add more applications and adapters for deployment.

7. Optional: Configure application and adapter deployment to MobileFirst Server. You can skip this step if you want to specify the user credential with deployment privilege later during the pattern deployment configuration phase in step 9. If you have specified the default admin user credential in step 3, you can now specify the deployer user, which must align with the admin user credential:
    * In the MobileFirst Platform Server node, select the **MFP Server Application Adapter Deployment** component. The properties of the selected component are displayed next to the canvas.
    * Find the parameters named **deployer_user** and **deployer_password**, and then click the adjacent Delete buttons to clear the pattern level parameter settings.
    * In the **deployer\_user** and **deployer\_password** fields, specify the user name and password.

8. Configure base scaling policy:
    * In the **MobileFirst Platform Server** node, select the **Base Scaling Policy** component. The properties of the selected component are displayed next to the canvas.
    * In the **Number of Instances** field, specify the number of server nodes to be instantiated during pattern deployment. The default value is 2 in the predefined template. Because dynamic scaling is not supported in this release, do not specify values in the remaining attribute fields.

9. Configure and launch the pattern deployment:
    * In the IBM PureApplication System dashboard, click **Patterns → Virtual System Patterns**.
    * On the Virtual System Patterns page, use the **Search** field to find the pattern you created, and then select the pattern.
    * In the toolbar above the panel displaying detailed information about the pattern, click the Deploy button.
    * In the Deploy Pattern window, in the Configure panel, select the correct environment profile from the **Environment Profile** list, and provide other IBM PureApplication System environment parameters. To obtain the correct information, consult your IBM PureApplication System administrator.
    * In the middle column, click **Pattern attributes** to display attributes such as user names and passwords.

        Supply the following information in the fields provided:

        > **Note:** Make appropriate changes to the default values of the pattern-level parameters even if an external LDAP server is configured. If you configure administration security by using an LDAP server, you need to supply additional LDAP information. For more information, see [Configuring MobileFirst administration security with an external LDAP repository](#configuring-mobilefirst-administration-security-with-an-external-ldap-repository).
        
        **admin\_user**  
        Not visible if configured in step 3. Create a default MobileFirst Server administrator account. Default value: demo.
        
        **admin\_password**  
        Not visible if configured in step 3. Default admin account password. Default value: demo.
        
        **ACTIVATE\_TOKEN\_LICENSE**  
        Not visible if configured in step 3. Select this field to license your pattern with token licensing. Leave this field clear if you use perpetual licenses.
        
        **LICENSE\_SERVER\_HOSTNAME**  
        Not visible if configured in step 3. If you use token licensing to license IBM MobileFirst Platform Foundation, enter the fully-qualified hostname or IP address of your Rational License Key Server IP address. Otherwise, leave this field blank.
        
        **LMGRD\_PORT**   
        Not visible if configured in step 3. If you use token licensing to license IBM MobileFirst Platform Foundation, enter the port number that the license manager daemon (lmrgd) listens for connections on. Otherwise, leave this field blank.
        The default license manager daemon port is 27000.

        **IBMRATL\_PORT**  
        Not visible if configured in step 3. If you use token licensing to license IBM MobileFirst Platform Foundation, enter the port number that the vendor daemon (ibmratl) listens for connections on. Otherwise, leave this field blank.
        The default vendor daemon port is typically 27001.

        **runtime\_contextRoot**  
        Not visible if configured in step 5. Context root name for the MobileFirst Server runtime. The name must start with "/".
        
        **deployer\_user**  
        Not visible if configured in step 8. User name for the account with deployment privilege. If an external LDAP server is not configured, you must enter the same value as was specified when creating the default admin user for the administration service, because in this case, the only authorized user for app and adapter deployment is the default admin user.
        
        **deployer\_password**  
        Not visible if configured in step 8. User password for the user with deployment privilege.
        
        **MFP Vms Password(root)**  
        Root password for the MobileFirst Platform Server and MobileFirst Platform DB nodes. Default value: passw0rd.
        
        **MFP DB Password(Instance owner)**  
        Instance owner password for the MobileFirst Platform DB node. Default value: **passw0rd**.    
    * Click **Quick Deploy** to launch your pattern deployment. After a few seconds, a message is displayed to indicate that the pattern has started to launch. You can click the URL provided in the message to track your pattern deployment status or go to **Patterns → Virtual System Instances** to open the Virtual System Instances page and search for your pattern there.

    If you use token licensing to licenseIBM MobileFirst Platform Foundation, your pattern will fail to deploy if insufficient license tokens are available or if the license key server IP address and port were entered incorrectly.
    
10. Access the MobileFirst Operations Console:
    * Click **Patterns → Virtual System Instances** to open the Virtual System Instances page and search for your pattern there. Make sure it is in Running state.
    * Select the pattern name and expand the **Virtual machine perspective** option in the panel displaying details of the selected instance.
    * Find the IHS Server VM that has a name similar to **IHS\_Server.*** and make a note of its Public IP address: you need this information in the following step.
    * In the browser, open the MobileFirst Operations Console by composing its URL with one of the following formats:
        * `http://{IHS Server VM Public IP}/mfpconsole`
        * `https://{IHS Server VM Public IP}/mfpconsole`
    * Log in to the Console with the admin user ID and password specified in step 3 or step 10.

## Deploying MobileFirst Server on a single-node WebSphere Application Server full profile server
You use a predefined template to deploy a single-node MobileFirst Server to a WebSphere® Application Server full profile server.

This procedure involves uploading certain artifacts to IBM® PureApplication® System such as the required application and adapter. Before you begin, ensure that the artifacts are available for upload.

**Token licensing requirements:** If you use token licensing to license IBM MobileFirst Foundation, review the requirements outlined in [Token licensing requirements for IBM MobileFirst Foundation System Pattern](#token-licensing-requirements-for-ibm-mobilefirst-foundation-system-pattern) before you continue. The deployment of this pattern fails if the license key server cannot be contacted or if insufficient license tokens are available.

Some parameters of script packages in the template have been configured with the recommended values and are not mentioned in this section. For fine-tuning purposes, see more information about all the parameters of script packages in [Script packages for MobileFirst Server](#script-packages-for-mobilefirst-server).

For more information about the composition and configuration options of the predefined template that is used in this procedure, see [MobileFirst Platform (WAS single node) template](#mobilefirst-platform-was-single-node-template).

1. Create a pattern from the predefined template:
    * In the IBM PureApplication System dashboard, click **Patterns → Virtual System Patterns**. The **Virtual System Patterns** page opens.
    * On the **Virtual System Patterns** page, click **Create New**, and then in the pop-up window, select **MobileFirst Platform (WAS single node)** from the list of predefined templates. If the name is only partially visible due to its length, you can confirm that the correct template is selected by viewing its description on the **More information** tab.
    * In the **Name** field, provide a name for the pattern.
    * In the **Version** field, specify the version number of the pattern.
    * Click **Start Building**.
2. Mandatory for AIX®: In IBM PureApplication System running on Power®, the MobileFirst Platform DB node needs to use the AIX-specific add-on component "Default AIX add disk" to replace the "Default add disk" component in the template to support the **jfs2** file system:
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
3. Optional: Configure MobileFirst Server administration. You can skip this step if you want to specify the user credential with MobileFirst Server administration privilege later during the pattern deployment configuration phase in step 9. To specify it now, complete these steps:

    > **Note:** If you want to configure administration security with an LDAP server, you need to supply additional LDAP information. For more information, see [Configuring MobileFirst administration security with an external LDAP repository](#configuring-mobilefirst-administration-security-with-an-external-ldap-repository).
    * In the MobileFirst Platform Server node, click the **MFP Server Administration** component. The properties of the selected component are displayed next to the canvas.
    * Next to the **admin_user** and **admin_password** fields, click the Delete button to clear their pattern level parameter settings.
    * In the **admin_user** and **admin\_password** fields, specify the administration user name and password.
    * If you use token licensing to license IBM MobileFirst Platform Foundation, complete the following fields. If you do not use token licensing, leave these fields blank.

    **ACTIVATE\_TOKEN\_LICENSE**: Select this field to license your pattern with token licensing.  
    **LICENSE\_SERVER\_HOSTNAME**: Enter the fully qualified host name or IP address of your Rational License Key Server.  
    **LMGRD\_PORT**: Enter the port number that the license manager daemon (**lmrgd**) listens for connections on. The default license manager daemon port is 27000.  
    **IBMRATL\_PORT**:Enter the port number that the vendor daemon (**ibmratl**) listens for connections on. The default vendor daemon port is typically 27001.  

    A default administration account for MobileFirst Server is created during pattern deployment.

4. Optional: Configure MobileFirst Server runtime deployment. You can skip this step if you want to specify the context root name for the runtime later during the pattern deployment configuration phase in step 9. To specify the context root name now, complete these steps:
    * In the MobileFirst Platform Server node, click the **MFP Server Runtime Deployment** component. The properties of the selected component are displayed next to the canvas.
    * Next to the **runtime\_contextRoot** field, click the **Delete** button to clear the pattern level parameter setting.
    * In the **runtime\_contextRoot** field, specify the runtime context root name. Note that the context root name must start with a forward slash, /; for example, `/HelloWorld`.

5. Upload application and adapter artifacts:

    > **Important:** When specifying the Target path for applications and adapters, make sure all the applications and adapters are placed in the same directory. For example, if one target path is **/opt/tmp/deploy/HelloWorld-common.json**, all the other target paths should be `/opt/tmp/deploy/*`.
    * In the MobileFirst Platform Server node, click the **MFP Server Application** or **MFP Server Adapter** component. The properties of the selected component are displayed next to the canvas.
    * In the **Additional file** field, click the **Browse** button to locate and upload the application or adapter artifact.
    * In the **Target path** field, specify the full path for storing the artifact including its file name; for example, **/opt/tmp/deploy/HelloWorld-common.json**.
    * If no application or adapter is to be deployed in the pattern, remove the relevant component by clicking the **X** button inside it. To get an empty MobileFirst Operations Console deployed without any app or adapter installed, remove the MFP Server Application Adapter Deployment component by clicking the X button inside it. 

6. Optional: Add more application or adapter artifacts for deployment:
    * From the **Assets** toolbar, expand **Software Components**, and then drag and drop an **Additional file** component onto the MobileFirst Paltform Server node in the canvas. Rename it **MobileFirst App\_X** or **MobileFirst Adatper\_X** (where **X** stands for a unique number for differentiation).
    * Hover the cursor over the newly added App or Adapter component, and then click the **Move Up** and **Move Down** buttons to adjust its sequence in the node. Make sure it is placed after the MFP Runtime Deployment component but before the MFP Server Application Adapter Deployment component.
    * Click the newly added application or adapter component. The properties of the selected component are displayed next to the canvas. Upload the application or adapter artifact and specify its target path by referring to the steps in step 6.
    * Repeat step 7 to add more applications and adapters for deployment.

7. Optional: Configure application and adapter deployment to MobileFirst Server. You can skip this step if you want to specify the user credential with deployment privilege later during the pattern deployment configuration phase in step 9. If you have specified the default admin user credential in step 3, you can now specify the deployer user, which must align with the admin user credential:
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
        
        > **Note:** Make appropriate changes to the default values of the pattern-level parameters even if an external LDAP server is configured. If you configure administration security by using an LDAP server, you need to supply additional LDAP information. For more information, see [Configuring MobileFirst administration security with an external LDAP repository](#configuring-mobilefirst-administration-security-with-an-external-ldap-repository).

        **WebSphere administrative user name**  
        Admin user ID for WebSphere administration console login. Default value: virtuser.

        **WebSphere administrative password**  
        Admin user password for WebSphere administration console login. Default value: passw0rd.
        
        **admin\_user**  
        Not visible if configured in step 3. Create a default MobileFirst Server administrator account. Default value: demo.
        
        **admin\_password**  
        Not visible if configured in step 3. Default admin account password. Default value: demo.
        
        **ACTIVATE\_TOKEN\_LICENSE**  
        Not visible if configured in step 3. Select this field to license your pattern with token licensing. Leave this field clear if you use perpetual licenses.
        
        **LICENSE\_SERVER\_HOSTNAME**  
        Not visible if configured in step 3. If you use token licensing to license IBM MobileFirst Platform Foundation, enter the fully-qualified hostname or IP address of your Rational License Key Server IP address. Otherwise, leave this field blank.
        
        **LMGRD\_PORT**   
        Not visible if configured in step 3. If you use token licensing to license IBM MobileFirst Platform Foundation, enter the port number that the license manager daemon (lmrgd) listens for connections on. Otherwise, leave this field blank.
        The default license manager daemon port is 27000.

        **IBMRATL\_PORT**  
        Not visible if configured in step 3. If you use token licensing to license IBM MobileFirst Platform Foundation, enter the port number that the vendor daemon (ibmratl) listens for connections on. Otherwise, leave this field blank.
        The default vendor daemon port is typically 27001.

        **runtime\_contextRoot**  
        Not visible if configured in step 5. Context root name for the MobileFirst Server runtime. The name must start with "/".
        
        **deployer\_user**  
        Not visible if configured in step 8. User name for the account with deployment privilege. If an external LDAP server is not configured, you must enter the same value as was specified when creating the default admin user for the administration service, because in this case, the only authorized user for app and adapter deployment is the default admin user.
        
        **deployer\_password**  
        Not visible if configured in step 8. User password for the user with deployment privilege.
        
        **MFP Vms Password(root)**  
        Root password for the MobileFirst Platform Server and MobileFirst Platform DB nodes. Default value: passw0rd.
        
        **MFP DB Password(Instance owner)**  
        Instance owner password for the MobileFirst Platform DB node. Default value: **passw0rd**.

        **Important restriction:**  
        When you set these attrbutes, do not change the following attributes in the MobileFirst Platform Server section:
        
        * Cell name
        * Node name
        * Profile name

        If you change any of these attributes, your pattern deployment will fail.

    * Click Quick Deploy to launch your pattern deployment. After a few seconds, a message is displayed to indicate that the pattern has started to launch. You can click the URL provided in the message to track your pattern deployment status or go to Patterns > Virtual System Instances to open the Virtual System Instances page and search for your pattern there.
9. 
## Upgrading IBM MobileFirst Platform Foundation System Pattern
To upgrade IBM MobileFirst Application Pattern, upload the .tgz file that contains the latest updates.

1. Log into IBM® PureApplication® System with an account that is allowed to upload new system plugins.
2. From the IBM PureApplication System console, navigate to **Catalog → System Plug-ins**.
3. Upload the IBM MobileFirst Application Pattern .tgz file that contains the updates.
4. Enable the plugins you have uploaded.
5. Redeploy the pattern.
