---
layout: tutorial
title: Configuring MobileFirst Server
weight: 6
---
## Overview
Consider your backup and recovery policy, optimize your MobileFirst Server configuration, and apply access restrictions and security options.

#### Jump to

* [Endpoints of the MobileFirst Server production server](#endpoints-of-the-mobilefirst-server-production-server)
* [Configuring MobileFirst Server to enable TLS V1.2](#configuring-mobilefirst-server-to-enable-tls-v1-2)
* [Configuring user authentication for MobileFirst Server administration](#configuring-user-authentication-for-mobilefirst-server-administration)
* [List of JNDI properties of the MobileFirst Server web applications](#list-of-jndi-properties-of-the-mobilefirst-server-web-applications)
* Configuring data sources
* Configuring logging and monitoring mechanisms
* Configuring license tracking
* [WebSphere Application Server SSL configuration and HTTP adapters](#websphere-application-server-ssl-configuration-and-http-adapters)

## Endpoints of the MobileFirst Server production server
You can create whitelists and blacklists for the endpoints of the IBM MobileFirst Server.

> **Note:** Information regarding URLs that are exposed by IBM MobileFirst Foundation is provided as a guideline. Organizations must ensure the URLs are tested in an enterprise infrastructure, based on what has been enabled for white and black lists.

| API URL under `<runtime context root>/api/` | Description                               | Suggested for whitelist? | 
|---------------------------------------------|-------------------------------------------|--------------------------|
| /adapterdoc/*	                              | Return the adapter's Swagger documentation for the named adapter | No. Used only internally by the administrator and the developers |
| /adapters/*  | Adapters serving | Yes |
| /az/v1/authorization/* | Authorize the client to access a specific scope | Yes | 
| /az/v1/introspection | Introspect the client's access token | No. This API is for confidential clients only. | 
| /az/v1/token | Generate an access token for the client | Yes | 
| /clientLogProfile/* | Get client log profile | Yes |
| /directupdate/* | Get Direct Update .zip file | Yes, if you plan to use Direct Update | 
| /loguploader | Upload client logs to server | Yes | 
| /preauth/v1/heartbeat | Accept heartbeat from the client and note the last activity time | Yes | 
| /preauth/v1/logout | Log out from a security check | Yes | 
| /preauth/v1/preauthorize | Map and execute security checks for a specific scope | Yes | 
| /reach | The server is reachable | No, for internal use only | 
| /registration/v1/clients/* | Registration-service clients API | No. This API is for confidential clients only. | 
| /registration/v1/self/* | Registration-service client self-registration API | Yes | 

## Configuring MobileFirst Server to enable TLS V1.2	
For MobileFirst Server to communicate with devices that support only Transport Layer Security v1.2 (TLS) V1.2, among the SSL protocols, you must complete the following instructions.

The steps to configure MobileFirst Server to enable Transport Layer Security (TLS) V1.2 depend on how MobileFirst Server connects to devices.

* If MobileFirst Server is behind a reverse proxy that decrypts SSL-encoded packets from devices before it passes the packets to the application server, you must enable TLS V1.2 support on your reverse proxy. If you use IBM® HTTP Server as your reverse proxy, see [Securing IBM HTTP Server](http://www.ibm.com/support/knowledgecenter/SSEQTP_8.5.5/com.ibm.websphere.ihs.doc/ihs/welc6top_securing_ihs_container.html?view=kc) for instructions.
* If MobileFirst Server communicates directly with devices, the steps to enable TLS V1.2 depend on whether your application serveris Apache Tomcat, WebSphere® Application Server Liberty profile, or WebSphere Application Server full profile.

### Apache Tomcat
1. Confirm that the Java™ Runtime Environment (JRE) supports TLS V1.2.
    Ensure that you have one of the following JRE versions:
    * Oracle JRE 1.7.0_75 or later
    * Oracle JRE 1.8.0_31 or later
2. Edit the conf/server.xml file and modify the <Connector> element that declares the HTTPS port so that the sslEnabledProtocols attribute has the following value: `sslEnabledProtocols="TLSv1.2,TLSv1.1,TLSv1,SSLv2Hello"`

### WebSphere Application Server Liberty profile
1. Confirm that the Java Runtime Environment (JRE) supports TLS V1.2.
    * If you use an IBM Java SDK, ensure that your IBM Java SDK is patched for the POODLE vulnerability. You can find the minimum IBM Java SDK versions that contain the patch for your version of WebSphere Application Server in [Security Bulletin: Vulnerability in SSLv3 affects IBM WebSphere Application Server (CVE-2014-3566)](http://www.ibm.com/support/docview.wss?uid=swg21687173).
    
        > **Note:** You can use the versions that are listed in the security bulletin or later versions.
    * If you use an Oracle Java SDK, ensure that you have one of the following versions:
        * Oracle JRE 1.7.0_75 or later
        * Oracle JRE 1.8.0_31 or later
2. If you use an IBM Java SDK, edit the **server.xml** file.
    * Add the following line: `<ssl id="defaultSSLConfig" keyStoreRef="defaultKeyStore" sslProtocol="SSL_TLSv2"/>`
    * Add the `sslProtocol="SSL_TLSv2"` attribute to all existing `<ssl>` elements.

### WebSphere Application Server full profile
1. Confirm that the Java Runtime Environment (JRE) supports TLS V1.2.

    Ensure that your IBM Java SDK is patched for the POODLE vulnerability. You can find the minimum IBM Java SDK versions that contain the patch for your version of WebSphere Application Server in [Security Bulletin: Vulnerability in SSLv3 affects IBM WebSphere Application Server (CVE-2014-3566)](http://www.ibm.com/support/docview.wss?uid=swg21687173).
    > **Note:** You can use the versions that are listed in the security bulletin or later versions.
2. Log in to WebSphere Application Server administrative console, and click **Security → SSL certificate and key management → SSL configurations**.
3. For each SSL configuration listed, modify the configuration to enable TLS V1.2.
    * Select an SSL configuration and then, under **Additional Properties**, click **Quality of protections (QoP)** settings.
    * From the **Protocol** list, select **SSL_TLSv2**.
    * Click **Apply** and then save the changes.

## Configuring user authentication for MobileFirst Server administration
MobileFirst Server administration requires user authentication. You can configure user authentication and choose an authentication method. Then, the configuration procedure depends on the web application server that you use.

> **Important:** If you use stand-alone WebSphere® Application Server full profile, use an authentication method other than the simple WebSphere authentication method (SWAM) in global security. You can use lightweight third-party authentication (LTPA). If you use SWAM, you might experience unexpected authentication failures.

You must configure authentication after the installer deploys the MobileFirst Server administration web applications in the web application server.

The MobileFirst Server administration has the following Java™ Platform, Enterprise Edition (Java EE) security roles defined:

* mfpadmin
* mfpdeployer
* mfpoperator
* mfpmonitor

You must map the roles to the corresponding sets of users. The **mfpmonitor** role can view data but cannot change any data. The following tables list MobileFirst roles and functions for production servers.

#### Deployment
|                        | Administrator | Deployer    | Operator    | Monitor    | 
|------------------------|---------------|-------------|-------------|------------|
| Java EE security role. | mfpadmin      | mfpdeployer | mfpoperator | mfpmonitor | 
| Deploy an application. | Yes           | Yes         | No          | No         | 
| Deploy an adapter.     | Yes           | Yes         | No          | No         | 

#### MobileFirst Server management
|                            | Administrator | Deployer    | Operator    | Monitor    | 
|----------------------------|---------------|-------------|-------------|------------|
| Java EE security role.     | mfpadmin      | mfpdeployer | mfpoperator | mfpmonitor | 
| Configure runtime settings.| Yes           | Yes         | No          | No         | 

#### Application management
|                                     | Administrator | Deployer    | Operator    | Monitor    | 
|-------------------------------------|---------------|-------------|-------------|------------|
| Java EE security role.              | mfpadmin      | mfpdeployer | mfpoperator | mfpmonitor | 
| Upload new MobileFirst application. | Yes           | Yes         | No          | No         | 
| Remove MobileFirst application.	  | Yes           | Yes         | No          | No         | 
| Upload new MobileFirst adapter.     | Yes           | Yes         | No          | No         | 
| Remove MobileFirst adapter.         | Yes           | Yes         | No          | No         | 
| Turn on or off application authenticity testing for an application. | Yes | Yes | No | No    | 
| Change properties on MobileFirst application status: Active, Active Notifying, and Disabled. | Yes | Yes | Yes | No | 

Basically, all roles can issue GET requests, the **mfpadmin**, **mfpdeployer**, and **mfpmonitor** roles can also issue POST and PUT requests, and the **mfpadmin** and **mfpdeployer** roles can also issue DELETE requests.

#### Requests related to push notifications

|                        | Administrator | Deployer    | Operator    | Monitor    | 
|------------------------|---------------|-------------|-------------|------------|
| Java EE security role. | mfpadmin      | mfpdeployer | mfpoperator | mfpmonitor | 
| GET requests <ul><li>Get a list of all the devices that use push notification for an application</li><li><li>Get the details of a specific device</li><li>Get the list of subscriptions</li><li>Get the subscription information that is associated with a subscription ID.</li><li>Get the details of a GCM configuration</li><li>Get the details of an APNS configuration</li><li>Get the list of tags that are defined for the application</li><li>Get details of a specific tag</li></ul>            | Yes           | Yes         | Yes         | Yes        | 
| POST and PUT requests <ul><li>Register an app with push notification</li><li>Update a push device registration</li><li>Create a subscription</li><li>Add or update a GCM configuration</li><li>Add or update an APNS configuration</li><li>Submit notifications to a device</li><li>Create or update a tag</li></ul> | Yes           | Yes         | Yes         | No         | 
| DELETE requests <ul><li>Delete the registration of a device to push notification</li><li>Delete a subscription</li><li>Unsubscribe a device from a tag</li><li>Delete a GCM configuration</li><li>Delete an APNS configuration</li><li>Delete a tag</li></ul> | Yes           | Yes         | No          | No         | 

#### Disabling
|                        | Administrator | Deployer    | Operator    | Monitor    | 
|------------------------|---------------|-------------|-------------|------------|
| Java EE security role. | mfpadmin      | mfpdeployer | mfpoperator | mfpmonitor | 
| Disable the specific device, marking the state as lost or stolen so that access from any of the applications on that device is blocked.       | Yes           | Yes         | Yes          | No        | 
| Disable a specific application, marking the state as disabled so that access from the specific application on that device is blocked.              | Yes           | Yes         | Yes         | No         | 

If you choose to use an authentication method through a user repository such as LDAP, you can configure the MobileFirst Server administration so that you can use users and groups with the user repository to define the Access Control List (ACL) of the MobileFirst Server administration. This procedure depends on the type and version of the web application server that you use.

### Configuring WebSphere Application Server full profile for MobileFirst Server administration
Configure security by mapping the MobileFirst Server administration Java™ EE roles to a set of users for both web applications.

You define the basics of user configuration in the WebSphere® Application Server console. Access to the console is usually by this address: `https://localhost:9043/ibm/console/`

1. Select **Security → Global Security**.
2. Select **Security Configuration Wizard** to configure users.
    You can manage individual user accounts by selecting **Users and Groups → Manage Users**.
3. Map the roles **mfpadmin**, **mfpdeployer**, **mfpmonitor**, and **mfpoperator** to a set of users.
    * Select **Servers → Server Types → WebSphere application servers**.
    * Select the server.
    * In the **Configuration** tab, select **Applications → Enterprise applications**.
    * Select **MobileFirst_Administration_Service**.
    * In the **Configuration** tab, select **Details → Security** role to user/group mapping.
    * Perform the necessary customization.
    * Click **OK**.
    * Repeat the steps to map the roles for the console web application. This time select **MobileFirst_Administration_Console**.
    * Click **Save** to save the changes.

### Configuring WebSphere Application Server Liberty profile for MobileFirst Server administration
In WebSphere® Application Server Liberty profile, you configure the roles of **mfpadmin**, **mfpdeployer**, **mfpmonitor**, and **mfpoperator** in the **server.xml** configuration file of the server.

To configure the security roles, you must edit the **server.xml** file. In the `<application-bnd>` element of each `<application>` element, create `<security-role>` elements. Each `<security-role>` element is for each roles: **mfpadmin**, mfpdeployer, mfpmonitor, and mfpoperator. Map the roles to the appropriate user group name, in this example: **mfpadmingroup**, **mfpdeployergroup**, **mfpmonitorgroup**, or **mfpoperatorgroup**. These groups are defined through the `<basicRegistry>` element. You can customize this element or replace it entirely with an `<ldapRegistry>` element or a `<safRegistry>` element.

Then, to maintain good response times with a large number of installed applications, for example with 80 applications, you should configure a connection pool for the administration database.

1. Edit the **server.xml** file. For example: 

    ```xml
    <security-role name="mfpadmin">
      <group name="mfpadmingroup"/>
    </security-role>
    <security-role name="mfpdeployer">
      <group name="mfpdeployergroup"/>
    </security-role>
    <security-role name="mfpmonitor">
      <group name="mfpmonitorgroup"/>
    </security-role>
    <security-role name="mfpoperator">
      <group name="mfpoperatorgroup"/>
    </security-role>

    <basicRegistry id="mfpadmin">
      <user name="admin" password="admin"/>
      <user name="guest" password="guest"/>
      <user name="demo" password="demo"/>
      <group name="mfpadmingroup">
        <member name="guest"/>
        <member name="demo"/>
      </group>
      <group name="mfpdeployergroup">
        <member name="admin" id="admin"/>
      </group>
      <group name="mfpmonitorgroup"/>
      <group name="mfpoperatorgroup"/>
    </basicRegistry>
    ```

2. Define  the **AppCenterPool** size:

    ```xml
    <connectionManager id="AppCenterPool" minPoolSize="10" maxPoolSize="40"/>
    ```
    
3. In the `<dataSource>` element, define a reference to the connection manager:

    ```xml
    <dataSource id="MFPADMIN" jndiName="mfpadmin/jdbc/mfpAdminDS" connectionManagerRef="AppCenterPool">
    ...
    </dataSource>
```

### Configuring Apache Tomcat for MobileFirst Server administration
You must configure the Java™ EE security roles for the MobileFirst Server administration on the Apache Tomcat web application server.

1. If you installed the MobileFirst Server administration manually, declare the following roles in the **conf/tomcat-users.xml** file:

    ```xml
    <role rolename="mfpadmin"/>
    <role rolename="mfpmonitor"/>
    <role rolename="mfpdeployer"/>
    <role rolename="mfpoperator"/>
    ```

2. Add roles to the selected users, for example:

    ```xml
    <user name="admin" password="admin" roles="mfpadmin"/>
    ```
    
3. You can define the set of users as described in the Apache Tomcat documentation, [Realm Configuration HOW-TO](http://tomcat.apache.org/tomcat-7.0-doc/realm-howto.html).

## List of JNDI properties of the MobileFirst Server web applications
Configure the JNDI properties for the MobileFirst Server web applications that are deployed to the application server.

* [Setting up JNDI properties for MobileFirst Server web applications]()
* [List of JNDI properties for MobileFirst Server administration service]()
* [List of JNDI properties for MobileFirst Server live update service]()
* [List of JNDI properties for MobileFirst runtime]()
* [List of JNDI properties for MobileFirst Server push service]()

### Setting up JNDI properties for MobileFirst Server web applications
Set up JNDI properties to configure the MobileFirst Server web applications that are deployed to the application server.  
Set the JNDI environment entries in one of the following ways:

* Configure the server environment entries. The steps to configure the server environment entries depends on which application server you use:

    * **WebSphere® Application Server:**
        1. In the WebSphere Application Server administration console, go to **Applications → Application Types → WebSphere enterprise applications → application_name → Environment entries for Web modules**.
        2. In the Value fields, enter values that are appropriate to your server environment.
    
        ![JNDI environment entries in WebSphere](jndi_was.jpg)
    * WebSphere Application Server Liberty:
        1. In **liberty_install_dir/usr/servers/serverName**, edit the **server.xml** file, and declare the JNDI properties as follows:
    
        ```xml
        <application id="app_context_root" name="app_context_root" location="app_war_name.war" type="war"> 
            ...
        </application>
        <jndiEntry jndiName="app_context_root/JNDI_property_name" value="JNDI_property_value" />
        ```
        
        The context root (in the previous example: **app_context_root**) connects between the JNDI entry and a specific MobileFirst application. If multiple MobileFirst applications exist on the same server, you can define specific JNDI entries for each application by using the context path prefix.
        
        **Note:** Some properties are defined globally on WebSphere Application Server Liberty, without prefixing the property name by the context root. For a list of these properties, see [Global JNDI entries](../appserver/#global-jndi-entries).
        
        For all other JNDI properties, the names must be prefixed with the context root of the application:
            * For the MobileFirst Administration Service application, the MobileFirst Operations Console and MobileFirst runtime, you can define the context root as you want. However, by default it is **/mfpadmin** for MobileFirst Administration Service, **/mfpconsole** for MobileFirst Operations Console, and **/mfp** for MobileFirst runtime.
            * For the live update service, the context root must be **/<adminContextRoot>config**. For example, if the context root of the administration service is **/mfpadmin**, then the context root of the live update service must be **/mfpadminconfig**.
            * For the push service, you must define the context root as **/imfpush**. Otherwise, the client devices cannot connect to it as the context root is hardcoded in the SDK.

        For example:
        
        ```xml
        <application id="mfpadmin" name="mfpadmin" location="mfp-admin-service.war" type="war">
            ...
        </application>
        <jndiEntry jndiName="mfpadmin/mfp.admin.actions.prepareTimeout" value = "2400000" />
        ```    
        
    * Apache Tomcat:
        1. In **tomcat_install_dir/conf**, edit the **server.xml** file, and declare the JNDI properties as follows:
        
        ```xml
        <Context docBase="app_context_root" path="/app_context_root">
            <Environment name="JNDI_property_name" override="false" type="java.lang.String" value="JNDI_property_value"/>
        </Context>
        ```
        
        * The context path prefix is not needed because the JNDI entries are defined inside the `<Context>` element of an application.
        * `override="false"` is mandatory.
        * The `type` attribute is always `java.lang.String`, unless specified differently for the property.
    
        For example:
        
        ```xml
        <Context docBase="app_context_root" path="/app_context_root">
            <Environment name="mfp.admin.actions.prepareTimeout" override="false" type="java.lang.String" value="2400000"/>
        </Context>
        ```
        
* If you install with Ant tasks, you can also set the values of the JNDI properties at installation time.

    In **mfp_install_dir/MobileFirstServer/configuration-samples**, edit the configuration XML file for the Ant tasks, and declare the values for the JNDI properties by using the property element inside the following tags:
    
    * `<installmobilefirstadmin>`, for MobileFirst Server administration, MobileFirst Operations Console, and live update services. For more information, see [Ant tasks for installation of MobileFirst Operations Console, MobileFirst Server artifacts, MobileFirst Server administration, and live update services]().
    * `<installmobilefirstruntime>`, for MobileFirst runtime configuration properties. For more information, see [Ant tasks for installation of MobileFirst runtime environments]().
    * `<installmobilefirstpush>`, for configuration of the push service. For more information, see [Ant tasks for installation of MobileFirst Server push service]().

    For example: 
    
    ```xml
    <installmobilefirstadmin ..>
        <property name = "mfp.admin.actions.prepareTimeout" value = "2400000" />
    </installmobilefirstadmin>
    ```
        
### List of JNDI properties for MobileFirst Server administration service
### List of JNDI properties for MobileFirst Server live update service
When you configure the MobileFirst Server live update service for your application server, you can set the following JNDI properties. The table lists the JNDI properties for the IBM® relational database live update service.

| Property | Optional or mandatory | Description | 
|----------|-----------------------|-------------|
| mfp.db.relational.queryTimeout | Optional | Timeout for executing a query in RDBMS, in seconds. A value of zero means an infinite timeout. A negative value means the default (no override).<br/><br/>In case no value is configured, a default value is used. For more information, see [setQueryTimeout](http://docs.oracle.com/javase/7/docs/api/java/sql/Statement.html#setQueryTimeout(int)). | 

### List of JNDI properties for MobileFirst runtime
### List of JNDI properties for MobileFirst Server push service

## Configuring data sources
## Configuring logging and monitoring mechanisms
## Configuring license tracking

## WebSphere Application Server SSL configuration and HTTP adapters
By setting a property, you can let HTTP adapters benefit from WebSphere® SSL configuration.

By default, HTTP adapters do not use WebSphere SSL by concatenating the Java™ Runtime Environment (JRE) truststore with the MobileFirst Server keystore, which is described in [Configuring the MobileFirst Server keystore](). Also see [Configuring SSL between MobileFirst adapters and back-end servers by using self-signed certificates]().

To have HTTP adapters use the WebSphere SSL configuration, set the **ssl.websphere.config** JNDI property to true. The setting has the following effects in order of precedence:

1. Adapters running on WebSphere use the WebSphere keystore and not the MobileFirst Server keystore.
2. If the **ssl.websphere.alias** property is set, the adapter uses the SSL configuration that is associated with the alias as set in this property.