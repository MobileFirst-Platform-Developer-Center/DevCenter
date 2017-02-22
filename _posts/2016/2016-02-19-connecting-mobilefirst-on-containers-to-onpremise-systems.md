---
title: Connecting securely from IBM MobileFirst on Containers to on-premise systems
date: 2016-02-19
tags:
- MobileFirst_Platform
- Bluemix
- IBM_Containers
- On_premise
version:
- 7.1
author:
  name: SRIKANTH K MURALI 
---

> **Note:** This blog post refers to connecting a on-prem database as the admin and run time DB for the MobileFirst server running on IBM Containers. For instructions on connecting to on-prem backends from your adapters for MobileFirst server running on Liberty buildpacks and Mobile Foundation Bluemix service (which also runs on Liberty buildpack), pl refer to this [blog post](https://mobilefirstplatform.ibmcloud.com/blog/2016/08/22/connecting-to-on-premise-backends-with-bluemix-secure-gateway-service/)

You are already aware of the [IBM MobileFirst Platform Foundation (MFPF)](https://developer.ibm.com/mobilefirstplatform/documentation/getting-started-7-1/bluemix/run-foundation-on-bluemix) on IBM Containers offering that allows you to take a locally developed IBM MobileFirst project and run it on IBM Bluemix. This article demonstrates on how to securely connect from the IBM MobileFirst Platform Foundation on IBM Containers to a on-premise computer / data-center using the newly launched [Virtual Private Network (VPN)](https://www.ng.bluemix.net/docs/services/vpn/index.html) Service on IBM Bluemix.

IBM VPN service provides a secure communication channel between your data center and the resources running in the IBM Containers. You can configure the MobileFirst Platform to access the Systems of Record (SoR) data securely from the on-premise data center via the Adapters. Also, you can configure to store the MobileFirst related metadata in a database situated in the on-premise data center.

In this article, we will explore on both these configurations - how to configure IBM MFPF on IBM Containers to work with the database that resides within your enterprise environment. Also, how to configure the IBM MFPF on IBM Containers to access the customer data stored in the enterprise systems via Adapters.

## Create a VPN service instance

* Log in to the IBM Bluemix environment and create an instance of the IBM VPN Service. You can create one instance of the VPN service per Bluemix space.
* On the <a href="https://www.ng.bluemix.net/docs/services/vpn/index.html" target="_blank">VPN Service console</a>, select the types of containers that you would like to associate the VPN Service with - Single Container or Container groups.
* Create a VPN Site Connection configuration by specifying the Gateway IP of your data center within the enterprise. You would also need to configure the Customer Subnet and a pre-shared secret to establish the connection.
    
Your VPN service instance on Bluemix has now been configured.

## Configuration for the on-premise data center
The on-premise data center should now be configured to work with the VPN service on Bluemix. You can install any of the standard IPSec clients on the on-premise gateway. Detailed steps of configuration for various clients is provided [here](https://www.ng.bluemix.net/docs/services/vpn/onpremises_gateway.html).

Once the on-premise data center and the IBM Bluemix VPN service is configured, a secure connection will be established between the two endpoints. You can check the status of the connection either in the Bluemix VPN console or by executing *ipsec statusall* command on the data center.

## Configuring the database for IBM MobileFirst Platform Foundation on IBM Bluemix
Next, you will configure the database required to store the metadata for the IBM MobileFirst Platform, on the data center machine. You can install the database of your choice on the data center. MySQL has been chosen as the database for this article.

Once the database has been configured, create the database tables required for the IBM MobileFirst administration and runtime configuration. You can either use the Ant tasks that is shipped with the product or manually using the sql files. You should have access to a IBM MobileFirst Server installation on any machine to obtain the sql files. The sql files (create-worklightadmin-mysql.sql and create-worklight-mysql.sql) can be found in the <em>product_install_dir/WorklightServer/databases/</em> folder. Details for the configuration can be found in these links:

* [Configuring IBM MobileFirst Administration](https://www-01.ibm.com/support/knowledgecenter/SSHS8R_7.1.0/com.ibm.worklight.installconfig.doc/install_config/t_wlconsole_install.html)
* [Configuring IBM MobileFirst Runtime projects](https://www-01.ibm.com/support/knowledgecenter/SSHS8R_7.1.0/com.ibm.worklight.deploy.doc/deploy/c_deploy_wl_project.html)

Next, we would need to build the [IBM MobileFirst Platform Foundation image](https://www-01.ibm.com/support/knowledgecenter/SSHS8R_7.1.0/com.ibm.worklight.deploy.doc/deploy/c_server_image_ov.html) and run it on the IBM Containers environment.
Download the IBM MFP on Containers offering from the Passport advantage site. Firstly, the database related libraries needs to be added into the image. Create a folder named *mysql* inside the /mfpf-server/usr/ directory and place the mysql-java-connector jar in that folder. Add the following into the end of the /mfpf-server/Dockerfile.
<pre>    COPY usr/mysql/*.jar /opt/ibm/wlp/usr/shared/resources/mysql/
</pre>
The MobileFirst platform should now be configured to use the database on the data-center. To perform this, create the following configuration snippets in the *mfpf-server/usr/config* directory. Ensure that the Private IP of the datacenter is provided in the snippet. The data transfer between the Container and the database happens via the secure channel established by the VPN service.

**The MFP Administration database configuration - wladmin.xml**

```xml
<?xml version="1.0" encoding="UTF-8"?><server description="new server">
<!-- Declare the jar files for MySQL access through JDBC. -->
<library id="MySQLLib">
 <fileset dir="${shared.resource.dir}/mysql" includes="*.jar"/>
</library>

<!-- Declare the IBM Worklight administration database. -->
<dataSource jndiName="${env.MFPF_ADMIN_ROOT}/jdbc/WorklightAdminDS" transactional="false">
 <jdbcDriver libraryRef="MySQLLib"/>
 <properties databaseName="WLADMIN" serverName="<private ip of the datacenter>" portNumber="3306" user="mysqluser" password="mysqlpass"/>
</dataSource>
</server>
</pre>
Create a runtime related configuration for each of the MobileFirst Projects. The project name used here is *StarterApplication*

<b>The MFP project runtime database configuration - starterapplication.xml</b>
<pre><?xml version="1.0" encoding="UTF-8"?>
<server description="new server">
<application id="StarterApplication" location="StarterApplication.war" name="StarterApplication" type="war">
 <classloader delegation="parentLast">
     <privateLibrary id="worklightlib_StarterApplication">
         <fileset dir="${shared.resource.dir}/lib" includes="worklight-jee-library.jar"/>
         <fileset dir="${wlp.install.dir}/lib" includes="com.ibm.ws.crypto.passwordutil*.jar"/>
     </privateLibrary>
 </classloader>
</application>
<!-- Declare the jar files for MySQL access through JDBC. -->
<library id="StarterApplicationMySQLLib">
 <fileset dir="${shared.resource.dir}/mysql" includes="*.jar"/>
</library>

<!-- Declare the Worklight Server project database -->
<dataSource jndiName="StarterApplication/jdbc/WorklightDS" transactional="false">
 <jdbcDriver libraryRef="StarterApplicationMySQLLib"/>
     <properties databaseName="STARTERAPPLICATION" serverName="<private ip of the datacenter>" portNumber="3306" user="mysqluser" password="mysqlpass"/>
</dataSource>
</server>
```

You can now build the docker image by following the [steps here](https://www-01.ibm.com/support/knowledgecenter/SSHS8R_7.1.0/com.ibm.worklight.deploy.doc/deploy/t_build_run_server_container.html). Note: Since the databases are already configured, the prepareserverdbs.sh script need not be run.

Once the MFP Container is up and running, you can access the MFP Console and verify that the projects are initialized.

You can use the MobileFirst Studio or the Command line interface (MFP CLI) to create MobileFirst Adapters that can be deployed on the server. The Adapters will help to connect to the enterprise backend system and deliver data to and from the Mobile applications. The adapters can be built to either to connect to a web-service or a database available in the enterprise system. You can find more details on [building adapters here](https://www-01.ibm.com/support/knowledgecenter/SSHS8R_7.1.0/com.ibm.worklight.dev.doc/devref/c_DevelopingTheServer-sideOfAnIBMWorklightApplication.html).

To connect from the Adapter to the enterprise system securely via the VPN service, provide the private IP address of the system in the connection information of the Adapter. You can now build &amp; deploy the adapter on the container and perform request invocation from the Mobile application. The MFP Container now has been enabled to work with an on-premise system within the enterprise via the VPN service.