---
layout: tutorial
title: Installation Reference
weight: 9
---
## Overview
Reference information about Ant tasks and configuration sample files for the installation of IBM MobileFirst  Server, IBM MobileFirst Application Center, and IBM MobileFirst Analytics.

#### Jump to
* [Ant configuredatabase task reference](#ant-configuredatabase-task-reference)
* [Ant tasks for installation of MobileFirst Operations Console, MobileFirst Server artifacts, MobileFirst Server administration, and live update services](#ant-tasks-for-installation-of-mobilefirst-operations-console-mobilefirst-server-artifacts-mobilefirst-server-administration-and-live-update-services)
* [Ant tasks for installation of MobileFirst Server push service](#ant-tasks-for-installation-of-mobilefirst-server-push-service)
* [Ant tasks for installation of MobileFirst runtime environments](#ant-tasks-for-installation-of-mobilefirst-runtime-environments)
* [Ant tasks for installation of Application Center](#ant-tasks-for-installation-of-application-center)
* [Ant tasks for installation of MobileFirst Analytics](#ant-tasks-for-installation-of-mobilefirst-analytics)
* [Internal runtime databases](#interanl-runtime-databases)
* [Sample configuration files](#sample-configuration-files)
* [Sample configuration files for MobileFirst Analytics](#sample-configuration-files-for-mobilefirst-analytics)

## Ant configuredatabase task reference
Reference information for the configuredatabase Ant task. This reference information is for relational databases only. It does not apply to Cloudant®.

The **configuredatabase** Ant task creates the relational databases that are used by MobileFirst Server administration service, MobileFirst Server live update service, MobileFirst Server push service, MobileFirst runtime, and the Application Center services. This Ant task configures a relational database through the following actions:

* Checks whether the MobileFirst tables exist and creates them if necessary.
* If the tables exist for an older version of IBM MobileFirst™ Platform Foundation, migrates them to the current version.
* If the tables exist for the current version of IBM MobileFirst Platform Foundation, does nothing.

In addition, if one of the following conditions is met:

* The DBMS type is Derby.
* An inner element `<dba>` is present.
* The DBMS type is DB2®, and the specified user has the permissions to create databases.

Then, the task can have the following effects:

* Create the database if necessary (except for Oracle 12c, and Cloudant).
* Create a user, if necessary, and grants that user access rights to the database.

> **Note:** The configuredatabase Ant task has not effect if you use it with Cloudant.

### Attributes and elements for configuredatabase task

The **configuredatabase** task has the following attributes:

| Attribute | Description | Required | Default | 
|-----------|-------------|----------|---------|
| kind      | The type of database: In MobileFirst Server: MobileFirstRuntime, MobileFirstConfig, MobileFirstAdmin, or push. In Application Center: ApplicationCenter. | Yes | None |
| includeConfigurationTables | To specify whether to perform database operations on both the live update service and the administration service or on the administration service only. The value is either true or false. |  No | true |
| execute | To specify whether to execute the configuredatabase Ant task. The value is either true or false. | No | true | 

#### kind
IBM MobileFirst Platform Foundation V8.0.0 supports four kinds of database: MobileFirst runtime uses **MobileFirstRuntime** database. MobileFirst Server administration service uses the **MobileFirstAdmin** database. MobileFirst Server's Live Update service uses the **MobileFirstConfig** database. By default, it is created with **MobileFirstAdmin** kind. MobileFirst Server push service uses the **push** database. Application Center uses the **ApplicationCenter** database.

#### includeConfigurationTables
The **includeConfigurationTables** attribute can be used only when the **kind** attribute is **MobileFirstAdmin**. The valid value can be true or false. When this attribute is set to true, the **configuredatabase** task performs database operations on both the administration service database and the Live Update service database in a single run. When this attribute is set to false, the **configuredatabase** task performs database operations only on the administration service database.

#### execute
The **execute** attribute enables or disables the execution of the **configuredatabase** Ant task. The valid value can be true or false. When this attribute is set to false, the **configuredatabase** task performs no configuration or database operations.

The **configuredatabase** task supports the following elements:

| Element             | Description	                | Count | 
|---------------------|-----------------------------|-------|
| `<derby>`           | The parameters for Derby.   | 0..1  | 
| `<db2>`             |	The parameters for DB2.     | 0..1  | 
| `<mysql>`           |	The parameters for MySQL.   | 0..1  | 
| `<oracle>`          |	The parameters for Oracle.  | 0..1  | 
| `<driverclasspath>` | The JDBC driver class path. | 0..1  | 

For each database type, you can use a `<property>` element to specify a JDBC connection property for access to the database. The `<property>` element has the following attributes:

| Attribute | Description                | Required | Default | 
|-----------|----------------------------|----------|---------|
| name      | The name of the property.	 | Yes      | None    |
| value	    | The value for the property.| Yes	    | None    |   

#### Apache Derby
The `<derby>` element has the following attributes:

| Attribute | Description                                | Required | Default                                                                      | 
|-----------|--------------------------------------------|----------|------------------------------------------------------------------------------|
| database  | The database name.                         | No	    | MFPDATA, MFPADM, MFPCFG, MFPPUSH, or APPCNTR, depending on kind.             |
| datadir   | The directory that contains the databases. | Yes      | None                                                                         | 
| schema	| The schema name.                           | No       | MFPDATA, MFPCFG, MFPADMINISTRATOR, MFPPUSH, or APPCENTER, depending on kind. |

The `<derby>` element supports the following element:

| Element      | Description                     | Count   |
|--------------|---------------------------------|---------|
| `<property>` | The JDBC connection property.   | 0..∞    |

For the available properties, see [Setting attributes for the database connection URL](http://db.apache.org/derby/docs/10.11/ref/rrefattrib24612.html).

#### DB2
The `<db2>` element has the following attributes:

| Attribute | Description                            | Required | Default | 
|-----------|----------------------------------------|----------|---------|
| database  | The database name.                     | No       | MFPDATA, MFPADM, MFPCFG, MFPPUSH, or APPCNTR, depending on kind. |
| server    | The host name of the database server.	 | Yes      | None  |
| port      | The port on the database server.       | No	    | 50000 |
| user      | The user name for accessing databases. | Yes	    | None  |
| password  | The password for accessing databases.	 | No	    | Queried interactively |
| instance  | The name of the DB2 instance.          | No	    | Depends on the server |
| schema    | The schema name.                       | No	    | Depends on the user   |

For more information about DB2 user accounts, see [DB2 security model overview](http://ibm.biz/knowctr#SSEPGG_10.1.0/com.ibm.db2.luw.admin.sec.doc/doc/c0021804.html).  
The `<db2>` element supports the following elements:

| Element      | Description                             | Count   |
|--------------|-----------------------------------------|---------|
| `<property>` | The JDBC connection property.           | 0..∞    |
| `<dba>`      | The database administrator credentials. | 0..1    |

For the available properties, see [Properties for the IBM® Data Server Driver for JDBC and SQLJ](http://ibm.biz/knowctr#SSEPGG_10.1.0/com.ibm.db2.luw.apdv.java.doc/src/tpc/imjcc_rjvdsprp.html).  
The inner element `<dba>` specifies the credentials for the database administrators. This element has the following attributes:

| Attribute | Description                            | Required | Default | 
|-----------|----------------------------------------|----------|---------|
| user      | The user name for accessing database.  | Yes      | None    |
| password  | The password or accessing database.    | No	    | Queried interactively |

The user that is specified in a `<dba>` element must have the SYSADM or SYSCTRL DB2 privilege. For more information, see [Authorities overview](http://ibm.biz/knowctr#SSEPGG_10.1.0/com.ibm.db2.luw.admin.sec.doc/doc/c0055206.html).

The `<driverclasspath>` element must contain the JAR files for the DB2 JDBC driver and for the associated license. You can retrieve those files in one of the following ways:

* Download DB2 JDBC drivers from the [DB2 JDBC Driver Versions](http://www.ibm.com/support/docview.wss?uid=swg21363866) page
* Or fetch the **db2jcc4.jar** file and its associated **db2jcc_license_*.jar** files from the **DB2_INSTALL_DIR/java** directory on the DB2 server.

You cannot specify details of table allocations, such as the table space, by using the Ant task. To control the table space, you must use the manual instructions in section [DB2 database and user requirements](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.installconfig.doc/install_config/t_db2_requirements.html?view=kc).

#### MySQL
The element `<mysql>` has the following attributes:

| Attribute | Description                            | Required | Default | 
|-----------|----------------------------------------|----------|---------|
| database	| The database name.	                 | No       | MFPDATA, MFPADM, MFPCFG, MFPPUSH, or APPCNTR, depending on kind. |
| server	| The host name of the database server.	 | Yes	    | None |
| port	    | The port on the database server.	     | No	    | 3306 |
| user	    | The user name for accessing databases. | Yes	    | None |
| password	| The password for accessing databases.	 | No	    | Queried interactively |

For more information about MySQL user accounts, see [MySQL User Account Management](http://dev.mysql.com/doc/refman/5.5/en/user-account-management.html).  
The `<mysql>` element supports the following elements:

| Element      | Description                                      | Count |
|--------------|--------------------------------------------------|-------|
| `<property>` | The JDBC connection property.                    | 0..∞  |
| `<dba>`      | The database administrator credentials.          | 0..1  |
| `<client>`   | The host that is allowed to access the database. | 0..∞  | 

For the available properties, see [Driver/Datasource Class Names, URL Syntax and Configuration Properties for Connector/J](http://dev.mysql.com/doc/connector-j/en/connector-j-reference-configuration-properties.html).  
The inner element `<dba>` specifies the database administrator credentials. This element has the following attributes:

| Attribute | Description                            | Required | Default | 
|-----------|----------------------------------------|----------|---------|
| user	    | The user name for accessing databases. | Yes	    | None |
| password	| The password for accessing databases.	 | No	    | Queried interactively |

The user that is specified in a `<dba>` element must be a MySQL superuser account. For more information, see [Securing the Initial MySQL Accounts](http://dev.mysql.com/doc/refman/5.5/en/default-privileges.html).

Each `<client>` inner element specifies a client computer or a wildcard for client computers. These computers are allowed to connect to the database. This element has the following attributes:

| Attribute | Description                                                              | Required | Default | 
|-----------|--------------------------------------------------------------------------|----------|---------|
| hostname	| The symbolic host name, IP address, or template with % as a placeholder. | Yes	  | None    |

For more information about the hostname syntax, see [Specifying Account Names](http://dev.mysql.com/doc/refman/5.5/en/account-names.html).

The `<driverclasspath>` element must contain a MySQL Connector/J JAR file. You can download that file from the [Download Connector/J](http://www.mysql.com/downloads/connector/j/) page.

Alternatively, you can use the `<mysql>` element with the following attributes:

| Attribute | Description                            | Required | Default               | 
|-----------|----------------------------------------|----------|-----------------------|
| url       | The database connection URL.	         | Yes      | None                  |
| user	    | The user name for accessing databases. | Yes      | None                  |
| password	| The password for accessing databases.	 | No       | Queried interactively |

> `Note:` If you specify the database with the alternative attributes, this database must exist, the user account must exist, and the database must already be accessible to the user. In this case, the **configuredatabase** task does not attempt to create the database or the user, nor does it attempt to grant access to the user. The **configuredatabase** task ensures only that the database has the required tables for the current MobileFirst Server version. You do not have to specify the inner elements `<dba>` or `<client>`.

#### Oracle
The element `<oracle>` has the following attributes:

| Attribute      | Description                                                              | Required | Default | 
|----------------|--------------------------------------------------------------------------|----------|---------|
| database       | The database name, or Oracle service name. **Note:** You must always use a service name to connect to a PDB database. | No | ORCL |
| server	     | The host name of the database server.                                    | Yes      | None | 
| port	         | The port on the database server.                                         | No       | 1521 | 
| user	         | The user name for accessing databases. See the note under this table.	| Yes      | None | 
| password	     | The password for accessing databases.                                    | No       | Queried interactively | 
| sysPassword	 | The password for the user SYS.                                           | No       | Queried interactively if the database does not yet exist | 
| systemPassword | The password for the user SYSTEM.                                        | No       | Queried interactively if the database or the user does not exist yet | 

> `Note:` For the user attribute, use preferably a user name in uppercase letters. Oracle user names are generally in uppercase letters. Unlike other database tools, the **configuredatabase** Ant task does not convert lowercase letters to uppercase letters in the user name. If the **configuredatabase** Ant task fails to connect to your database, try to enter the value for the **user** attribute in uppercase letters.

For more information about Oracle user accounts, see [Overview of Authentication Methods](http://docs.oracle.com/cd/B28359_01/server.111/b28318/security.htm#i12374).  
The `<oracle>` element supports the following elements:

| Element      | Description                                      | Count |
|--------------|--------------------------------------------------|-------|
| `<property>` | The JDBC connection property.                    | 0..∞  |
| `<dba>`      | The database administrator credentials.          | 0..1  |

For information about the available connection properties, see [Class OracleDriver](http://docs.oracle.com/cd/E11882_01/appdev.112/e13995/oracle/jdbc/OracleDriver.html).  
The inner element `<dba>` specifies the database administrator credentials. This element has the following attributes:

| Attribute      | Description                                                              | Required | Default | 
|----------------|--------------------------------------------------------------------------|----------|---------|
| user	         | The user name for accessing databases. See the note under this table.	| Yes      | None    | 
| password	     | The password for accessing databases.                                    | No       | Queried interactively | 

The `<driverclasspath>` element must contain an Oracle JDBC driver JAR file. You can download Oracle JDBC drivers from [JDBC, SQLJ, Oracle JPublisher and Universal Connection Pool (UCP)](http://www.oracle.com/technetwork/database/features/jdbc/index-091264.html).

You cannot specify details of table allocation, such as the table space, by using the Ant task. To control the table space, you can create the user account manually and assign it a default table space before you run the Ant task. To control other details, you must use the manual instructions in section [Oracle database and user requirements](../databases/#oracle-database-and-user-requirements).

| Attribute | Description                            | Required | Default               | 
|-----------|----------------------------------------|----------|-----------------------|
| url       | The database connection URL.	         | Yes      | None                  |
| user	    | The user name for accessing databases. | Yes      | None                  |
| password	| The password for accessing databases.	 | No       | Queried interactively |

> **Note:** If you specify the database with the alternative attributes, this database must exist, the user account must exist, and the database must already be accessible to the user. In this case, the task does not attempt to create the database or the user, nor does it attempt to grant access to the user. The **configuredatabase** task ensures only that the database has the required tables for the current MobileFirst Server version. You do not have to specify the inner element `<dba>`.

## Ant tasks for installation of MobileFirst Operations Console, MobileFirst Server artifacts, MobileFirst Server administration, and live update services
The **installmobilefirstadmin**, **updatemobilefirstadmin**, and **uninstallmobilefirstadmin** Ant tasks are provided for the installation of MobileFirst Operations Console, the artifacts component, the administration service, and the live update service.

### Task effects

#### installmobilefirstadmin
The **installmobilefirstadmin** Ant task configures an application server to run the WAR files of the administration and live update services as web applications, and optionally, to install the MobileFirst Operations Console. This task has the following effects:

* It declares the administration service web application in the specified context root, by default /mfpadmin.
* It declares the live update service web application in a context root derived from the specified context root of the administration service. By default, /mfpadminconfig.
* For the relational databases, it declares data sources and on WebSphere® Application Server full profile, JDBC providers for the administration services.
* It deploys the administration service and the live update service on the application server.
* Optionally, it declaresMobileFirst Operations Console as a web application in the specified context root, by default /mfpconsole. If the MobileFirst Operations Console instance is specified, the Ant task declares the appropriate JNDI environment entry to communicate with the corresponding management service. For example,

```xml
<target name="adminstall">
  <installmobilefirstadmin servicewar="${mfp.service.war.file}">
    <console install="${mfp.admin.console.install}" warFile="${mfp.console.war.file}"/>
```

* Optionally, it declares the MobileFirst Server artifacts web application in the specified context root /mfp-dev-artifacts when MobileFirst Operations Console is installed.
* It configures the configuration properties for the administration service by using JNDI environment entries. These JNDI environment entries also give some additional information about the application server topology, for example whether the topology is a stand-alone configuration, a cluster, or a server farm.
* Optionally, it configures users that it maps to roles used by MobileFirst Operations Console, and the administration and live update services web applications.
* It configures the application server for use of JMX.
* Optionally, it configures the communication with the MobileFirst Server push service.
* Optionally, it sets the MobileFirst JNDI environment entries to configure the application server as a server farm member for the MobileFirst Server administration part.

#### updatemobilefirstadmin
The **updatemobilefirstadmin** Ant task updates an already-configured MobileFirst Server web application on an application server. This task has the following effects:

* It updates the administration service WAR file. This file must have the same base name as the corresponding WAR file that was previously deployed.
* It updates the live update service WAR file. This file must have the same base name as the corresponding WAR file that was previously deployed.
* It updates the MobileFirst Operations Console WAR file. This file must have the same base name as the corresponding WAR file that was previously deployed.
The task does not change the application server configuration, that is, the web application configuration, data sources, JNDI environment entries, user-to-role mappings, and JMX configuration.

#### uninstallmobilefirstadmin
The **uninstallmobilefirstadmin** Ant task undoes the effects of an earlier run of installmobilefirstadmin. This task has the following effects:

* It removes the configuration of the administration service web application with the specified context root. As a consequence, the task also removes the settings that were added manually to that application.
* It removes the WAR files of the administration and live update services, and MobileFirst Operations Console from the application server as an option.
* For the relational DBMS, it removes the data sources and on WebSphere Application Server Full Profile the JDBC providers for the administration and live update services.
* For the relational DBMS, it removes the database drivers that were used by the administration and live update services from the application server.
* It removes the associated JNDI environment entries.
* On WebSphere Application Server Liberty and Apache Tomcat, it removes the users configured by the installmobilefirstadmin invocation.
* It removes the JMX configuration.

### Attributes and elements
The **installmobilefirstadmin**, **updatemobilefirstadmin**, and **uninstallmobilefirstadmin** Ant tasks have the following attributes:

| Attribute         | Description                                                              | Required | Default | 
|-------------------|--------------------------------------------------------------------------|----------|---------|
| contextroot       | The common prefix for URLs to the administration service to get information about MobileFirst runtime environments, applications, and adapters. | No | /mfpadmin | 
| id                | To distinguish different deployments.              | No | Empty | 
| environmentId     | To distinguish different MobileFirst environments. | No | Empty | 
| servicewar        | The WAR file for the administration service.       | No | The mfp-admin-service.war file is in the same directory as the mfp-ant-deployer.jar file. | 
| shortcutsDir      | The directory where to place shortcuts.            | No | None | 
| wasStartingWeight | The start order for WebSphere Application Server. Lower values start first. | No | 1 | 

#### contextroot and id
The **contextroot** and **id** attributes distinguish different deployments of MobileFirst Operations Console and the administration service.

In WebSphere Application Server Liberty profiles and in Tomcat environments, the contextroot parameter is sufficient for this purpose. In WebSphere Application Server Full profile environments, the id attribute is used instead. Without this id attribute, two WAR files with the same context roots might conflict and these files would not be deployed.

#### environmentId
Use the **environmentId** attribute to distinguish several environments, consisting each of MobileFirst Server administration service and MobileFirst runtime web applications, that must operate independently. For example, with this option you can host a test environment, a pre-production environment, and a production environment on the same server or in the same WebSphere Application Server Network Deployment cell. This environmentId attribute creates a suffix that is added to MBean names that the administration service and the MobileFirst runtime projects use when they communicate through Java™ Management Extensions (JMX).

#### servicewar
Use the **servicewar** attribute to specify a different directory for the administration service WAR file. You can specify the name of this WAR file with an absolute path or a relative path.

#### shortcutsDir
The **shortcutsDir** attribute specifies where to place shortcuts to the MobileFirst Operations Console. If you set this attribute, you can add the following files to that directory:

* **mobilefirst-console.url** - this file is a Windows shortcut. It opens the MobileFirst Operations Console in a browser.
* **mobilefirst-console.sh**- this file is a UNIX shell script and opens the MobileFirst Operations Console in a browser.
* **mobilefirst-admin-service.url** - this file is a Windows shortcut. It opens in a browser and calls a REST service that returns a list of the MobileFirst projects that can be managed in JSON format. For each listed MobileFirst project, some details are also available about their artifacts, such as the number of applications, the number of adapters, the number of active devices, the number of decommissioned devices. The list also indicates whether the MobileFirst project runtime is running or idle.
* **mobilefirst-admin-service.sh** - this file is a UNIX shell script that provides the same output as the **mobilefirst-admin-service.url** file.

#### wasStartingWeight
Use the **wasStartingWeight** attribute to specify a value that is used in WebSphere Application Server as a weight to ensure that a start order is respected. As a result of the start order value, the administration service web application is deployed and started before any other MobileFirst runtime projects. If MobileFirst projects are deployed or started before the web application, the JMX communication is not established and the runtime cannot synchronize with the administration service database and cannot handle server requests.

The **installmobilefirstadmin**, **updatemobilefirstadmin**, and **uninstallmobilefirstadmin** Ant tasks support the following elements:

| Element               | Description                                      | Count |
|-----------------------|--------------------------------------------------|-------|
| `<applicationserver>` | The application server.                          | 1     |
| `<configuration>`     | The live update service.	                       | 1     |
| `<console>`           | The administration console.                      | 0..1  |
| `<database>`          | The databases.                                   | 1     |
| `<jmx>`               | To enable Java Management Extensions.	           | 1     |
| `<property>`          | The properties.	                               | 0..   |
| `<push>`              | The push service.	                               | 0..1  |
| `<user>`              | The user to be mapped to a security role.	       | 0..   |

### To specify a MobileFirst Operations Console
The `<console>` element collects information to customize the installation of the MobileFirst Operations Console. This element has the following attributes:

| Attribute         | Description                                                               | Required | Default     | 
|-------------------|---------------------------------------------------------------------------|----------|-------------|
| contextroot       | The URI of the MobileFirst Operations Console.                            | No       | /mfpconsole |
| install           | To indicate whether the MobileFirst Operations Console must be installed. | No       | Yes         |
| warfile           | The console WAR file.	                                                    |No        | The mfp-admin-ui.war file is in the same directory as  themfp-ant-deployer.jar file. |

The `<console>` element supports the following element:

| Element               | Description                                      | Count |
|-----------------------|--------------------------------------------------|-------|
| `<artifacts>`         | The MobileFirst Server artifacts.                | 0..1  |
| `<property>`	        | The properties.	                               | 0..   |

The `<artifacts>` element has the following attributes:

| Attribute         | Description                                                               | Required | Default     | 
|-------------------|---------------------------------------------------------------------------|----------|-------------|
| install           | To indicate whether the artifacts component must be installed.            | No       | true        |
| warFile           | The artifacts WAR file.                                                   | No       | The mfp-dev-artifacts.war file is in the same directory as the mfp-ant-deployer.jar file |

By using this element, you can define your own JNDI properties or override the default value of the JNDI properties that are provided by the administration service and the MobileFirst Operations Console WAR files.

The `<property>` element specifies a deployment property to be defined in the application server. It has the following attributes:

| Attribute  | Description                | Required | Default | 
|------------|----------------------------|----------|---------|
| name       | The name of the property.  | Yes      | None    | 
| value	     | The value of the property. |	Yes      | None    |

By using this element, you can define your own JNDI properties or override the default value of the JNDI properties that are provided by the administration service and the MobileFirst Operations Console WAR files.

For more information about the JNDI properties, see [List of JNDI properties for MobileFirst Server administration service](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.installconfig.doc/install_config/r_wladmin_jndi_property_list.html?view=kc).

### To specify an application server
Use the `<applicationserver>` element to define the parameters that depend on the underlying application server. The `<applicationserver>` element supports the following elements.

| Element                                   | Description                                      | Count |
|-------------------------------------------|--------------------------------------------------|-------|
| `<websphereapplicationserver>` or `<was>` | The parameters for WebSphere Application Server. <br/><br/>The `<websphereapplicationserver>` element (or `was>` in its short form) denotes a WebSphere Application Server instance. WebSphere Application Server full profile (Base, and Network Deployment) are supported, so is WebSphere Application Server Liberty Core and WebSphere Application Server Liberty Network Deployment.               | 0..1  |
| `<tomcat>`                                | The parameters for Apache Tomcat.	               | 0..1  |

The attributes and inner elements of these elements are described in the tables of [Ant tasks for installation of MobileFirst runtime environments](#ant-tasks-for-installation-of-mobilefirst-runtime-environments).  
However, for the inner element of the `<was>` element for Liberty collective, see the following table:

| Element                  | Description                      | Count |
|--------------------------|----------------------------------|-------|
| `<collectiveController>` | A Liberty collective controller. |	0..1  |

The `<collectiveController>` element has the following attributes:

| Attribute                | Description                            | Required | Default | 
|--------------------------|----------------------------------------|----------|---------|
| serverName               | The name of the collective controller.	| Yes      | None    |
| controllerAdminName      | The administrative user name that is defined in the collective controller. This is the same user that is used to join new members to the   collective.                                                         | Yes      | None    |
| controllerAdminPassword  | The administrative user password.	    | Yes      | None    |
| createControllerAdmin    | To indicate whether the administrative user must be created in the basic registry of the collective controller. Possible values are true or false.                                                              | No	   | true    |

### To specify the live update service configuration
Use the `<configuration>` element to define the parameters that depend on the live update service. The `<configuration>` element has the following attributes.

| Attribute                | Description                                                    | Required | Default | 
|--------------------------|----------------------------------------------------------------|----------|---------|
| install                  | To indicate whether the live update service must be installed.	| Yes | true |
| configAdminUser	       | The administrator for the live update service.	                | No. However, it is required for a server farm topology. |If not defined, a user is generated. In a server farm topology, the user name must be the same for all the members of the farm. |
| configAdminPassword      | The administrator password for live update service user.       | If a user is specified for **configAdminUser**. | None. In a server farm topology, the password must be the same for all the members of the farm. |
| createConfigAdminUser	   | To indicate whether to create an admin user in the basic registry of the application server, if it is missing. | No | true |
| warFile                  | The live update service WAR file.	                            | No         | The mfp-live-update.war file is in the same directory as the mfp-ant-deployer.jar file. |

The `<configuration>` element supports the following elements:

| Element      | Description                           | Count |
|--------------|---------------------------------------|-------|
| `<user>`     | The user for the live update service. | 0..1  |
| `<property>` | The properties.	                   | 0..   |

The `<user>` element collects the parameters about a user to include in a certain security role for an application.

| Attribute   | Description                                                             | Required | Default | 
|-------------|-------------------------------------------------------------------------|----------|---------|
| role	      | A valid security role for the application. Possible value: configadmin.	| Yes      | None    |
| name	      | The user name.	                                                        | Yes      | None    |
| password	  | The password if the user needs to be created.	                        | No       | None    |

After you defined the users by using the `<user>` element, you can map them to any of the following roles for authentication in MobileFirst Operations Console: `configadmin`.

For more information about which authorizations are implied by the specific roles, see [Configuring user authentication for MobileFirst Server administration](../server-configuration/#configuring-user-authentication-for-mobilefirst-server-administration).

> **Tip:** If the users exist in an external LDAP directory, set only the **role** and **name** attributes but do not define any passwords.

The `<property>` element specifies a deployment property to be defined in the application server. It has the following attributes:

| Attribute  | Description                | Required | Default | 
|------------|----------------------------|----------|---------|
| name       | The name of the property.  | Yes      | None    | 
| value	     | The value of the property. |	Yes      | None    |

By using this element, you can define your own JNDI properties or override the default value of the JNDI properties that are provided by the administration service and the MobileFirst Operations Console WAR files. For more information about the JNDI properties, see [List of JNDI properties for MobileFirst Server administration service](../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service).

### To specify an application server
Use the `<applicationserver>` element to define the parameters that depend on the underlying application server. The `<applicationserver>` element supports the following elements:

| Element      | Description                                              | Count |
|--------------|--------------------------------------------------------- |-------|
| `<websphereapplicationserver>` or `<was>`	| The parameters for WebSphere Application Server.<br/><br/>The <websphereapplicationserver> element (or <was> in its short form) denotes a WebSphere Application Server instance. WebSphere Application Server full profile (Base, and Network Deployment) are supported, so is WebSphere Application Server Liberty Core and WebSphere Application Server Liberty Network Deployment. | 0..1  | 
| `<tomcat>`   | The parameters for Apache Tomcat.                        | 0..1  |

The attributes and inner elements of these elements are described in the tables of [Ant tasks for installation of MobileFirst runtime environments](#ant-tasks-for-installation-of-mobilefirst-runtime-environments).  
However, for the inner element of the <was> element for Liberty collective, see the following table:

| Element               | Description                  | Count |
|-----------------------|----------------------------- |-------|
| `<collectiveMember>`	| A Liberty collective member. | 0..1  |

The `<collectiveMember>` element has the following attributes:

| Attribute   | Description                                             | Required | Default | 
|-------------|---------------------------------------------------------|----------|---------|
| serverName  |	The name of the collective member.                      | Yes      | None    |
| clusterName |	The cluster name that the collective member belongs to. | Yes	   | None    |

> **Note:** If the push service and the runtime components are installed in the same collective member, then they must have the same cluster name. If these components are installed on distinct members of the same collective, the cluster names can be different.

### To specify Analytics
The `<analytics>` element indicates that you want to connect the MobileFirst push service to an already installed MobileFirst Analytics service. It has the following attributes:

| Attribute     | Description                                                               | Required | Default | 
|---------------|---------------------------------------------------------------------------|----------|---------|
| install	    | To indicate whether to connect the push service to MobileFirst Analytics. | No       | false   |
| analyticsURL 	| The URL of MobileFirst Analytics services.	                            | Yes	   | None    |
| username	    | The user name.	                                                        | Yes	   | None    |
| password	    | The password.	                                                            | Yes	   | None    |
| validate	    | To validate whether MobileFirst Analytics Console is accessible or not.	| No	   | true    |

**install**  
Use the install attribute to indicate that this push service must be connected and send events to MobileFirst Analytics. Valid values are true or false.

**analyticsURL**  
Use the analyticsURL attribute to specify the URL that is exposed by MobileFirst Analytics, which receives incoming analytics data.

For example: `http://<hostname>:<port>/analytics-service/rest`

**username**  
Use the username attribute to specify the user name that is used if the data entry point for the MobileFirst Analytics is protected with basic authentication.

**password**  
Use the password attribute to specify the password that is used if the data entry point for the MobileFirst Analytics is protected with basic authentication.

**validate**  
Use the validate attribute to validate whether the MobileFirst Analytics Console is accessible or not, and to check the user name authentication with a password. The possible values are true, or false.

### To specify a connection to the push service database
The `<database>` element collects the parameters that specify a data source declaration in an application server to access the push service database.

You must declare a single database: `<database kind="Push">`. You specify the `<database>` element similarly to the configuredatabase Ant task, except that the `<database>` element does not have the `<dba>` and `<client>` elements. It might have `<property>` elements.

The `<database>` element has the following attributes:

| Attribute     | Description                                     | Required | Default | 
|---------------|-------------------------------------------------|----------|---------|
| kind          | The kind of database (Push).	                  | Yes	     | None    |
| validate	    | To validate whether the database is accessible. | No       | true    |

The `<database>` element supports the following elements. For more information about the configuration of these database elements for relational DBMS, see the tables of [Ant tasks for installation of MobileFirst runtime environments](#ant-tasks-for-installation-of-mobilefirst-runtime-environments).

| Element            | Description                                                      | Count |
|--------------------|----------------------------------------------------------------- |-------|
| <db2>	             | The parameter for DB2® databases.	                            | 0..1  |
| <derby>	         | The parameter for Apache Derby databases.	                    | 0..1  | 
| <mysql>	         | The parameter for MySQL databases.                               | 0..1  |
| <oracle>	         | The parameter for Oracle databases.	                            | 0..1  |
| <cloudant>	     | The parameter for Cloudant databases.	                        | 0..1  |
| <driverclasspath>	 | The parameter for JDBC driver class path (relational DBMS only). | 0..1  |

> **Note:** The attributes of the `<cloudant>` element are slightly different from the runtime. For more information, see the following table:

| Attribute     | Description                                     | Required | Default                   | 
|---------------|-------------------------------------------------|----------|---------------------------|
| url           | The URL of the Cloudant account.                | No       | https://user.cloudant.com |
| user          | The user name of the Cloudant account.	      | Yes	     | None                      |
| password      | The password of the Cloudant account.	          | No	     | Queried interactively     |
| dbName        | The Cloudant database name. **Important:** This database name must start with a lowercase letter and contain only lowercase characters (a-z), Digits (0-9), any of the characters _, $, and -.                                | No       | mfp_push_db               |

## Ant tasks for installation of MobileFirst Server push service
Reference information for the **installmobilefirstruntime**, **updatemobilefirstruntime**, and **uninstallmobilefirstruntime** Ant tasks.

### Task effects

#### installmobilefirstruntime
The **installmobilefirstruntime** Ant task configures an application server to run a MobileFirst runtime WAR file as a web application. This task has the following effects.

* It declares the MobileFirst web application in the specified context root, by default /mfp.
* It deploys the runtime WAR file on the application server.
* It declares data sources and on WebSphere® Application Server full profile JDBC providers for the runtime.
* It deploys the database drivers in the application server.
* It sets MobileFirst configuration properties through JNDI environment entries.
* Optionally, it sets the MobileFirst JNDI environment entries to configure the application server as a server farm member for the runtime.

#### updatemobilefirstruntime
The **updatemobilefirstruntime** Ant task updates a MobileFirst runtime that is already configured on an application server. This task updates the runtime WAR file. The file must have the same base name as the runtime WAR file that was previously deployed. Other than that, the task does not change the application server configuration, that is, the web application configuration, data sources, and JNDI environment entries.

#### uninstallmobilefirstruntime
The **uninstallmobilefirstruntime** Ant task undoes the effects of an earlier **installmobilefirstruntime** run. This task has the following effects.

* It removes the configuration of the MobileFirst web application with the specified context root. The task also removes the settings that are added manually to that application.
* It removes the runtime WAR file from the application server.
* It removes the data sources and on WebSphere Application Server full profile the JDBC providers for the runtime.
* It removes the associated JNDI environment entries.

### Attributes and elements
The **installmobilefirstruntime**, **updatemobilefirstruntime**, and **uninstallmobilefirstruntime** Ant tasks have the following attributes:

| Attribute         | Description                                                                 | Required   | Default                   | 
|-------------------|-----------------------------------------------------------------------------|------------|---------------------------|
| contextroot       | The common prefix in URLs to the application (context root).                | No | /mfp  |
| id	            | To distinguish different deployments.                                       | No | Empty |
| environmentId	    | To distinguish different MobileFirst environments.                          | No | Empty |
| warFile	        | The WAR file for MobileFirst runtime.                                       | No | The mfp-server.war file is in the same directory as the mfp-ant-deployer.jar file. |
| wasStartingWeight | The start order for WebSphere Application Server. Lower values start first. | No | 2     |                           | 

#### contextroot and id
The **contextroot** and **id** attributes distinguish different MobileFirst projects.

In WebSphere Application Server Liberty profiles and in Tomcat environments, the contextroot parameter is sufficient for this purpose. In WebSphere Application Server full profile environments, the id attribute is used instead.

#### environmentId
Use the **environmentId** attribute to distinguish several environments, consisting each of MobileFirst Server administration service and MobileFirst runtime web applications, that must operate independently. You must set this attribute to the same value for the runtime application as the one that was set in the <installmobilefirstadmin> invocation, for the administration service application.

#### warFile
Use the **warFile** attribute to specify a different directory for the MobileFirst runtime WAR file. You can specify the name of this WAR file with an absolute path or a relative path.

#### wasStartingWeight
Use the **wasStartingWeight** attribute to specify a value that is used in WebSphere Application Server as a weight to ensure that a start order is respected. As a result of the start order value, the MobileFirst Server administration service web application is deployed and started before any other MobileFirst runtime projects. If MobileFirst projects are deployed or started before the web application, the JMX communication is not established and you cannot manage your MobileFirst projects.

The **installmobilefirstruntime**, **updatemobilefirstruntime**, and **uninstallmobilefirstruntime** tasks support the following elements:

| Element               | Description                                      | Count |
|-----------------------|--------------------------------------------------|-------|
| `<property>`          | The properties.	                               | 0..   |
| `<applicationserver>` | The application server.                          | 1     |
| `<database>`          | The databases.                                   | 1     |
| `<analytics>`         | The analytics.                                   | 0..1  |

The `<property>` element specifies a deployment property to be defined in the application server. It has the following attributes:

| Attribute | Description                | Required | Default | 
|-----------|----------------------------|----------|---------|
| name      | The name of the property.	 | Yes      | None    |
| value	    | The value for the property.| Yes	    | None    |  

The `<applicationserver>` element describes the application server to which the MobileFirst application is deployed. It is a container for one of the following elements:

| Element                                    | Description                                      | Count |
|--------------------------------------------|--------------------------------------------------|-------|
| `<websphereapplicationserver>` or `<was>`  | The parameters for WebSphere Application Server.	| 0..1  |
| `<tomcat>`                                 | The parameters for Apache Tomcat.                | 0..1  |

The `<websphereapplicationserver>` element (or `<was>` in its short form) denotes a WebSphere Application Server instance. WebSphere Application Server full profile (Base, and Network Deployment) are supported, so is WebSphere Application Server Liberty Core and WebSphere Application Server Liberty Network Deployment. The `<websphereapplicationserver>` element has the following attributes:

| Attribute       | Description                                            | Required                 | Default | 
|-----------------|--------------------------------------------------------|--------------------------|---------|
| installdir      |	WebSphere Application Server installation directory.   | Yes                      | None    |
| profile         |	WebSphere Application Server profile, or Liberty.      | Yes	                  | None    |
| user	WebSphere Application Server administrator name.	               | Yes, except for Liberty  | None    |
| password        | WebSphere Application Server administrator password.   | No	Queried interactively |         | 
| libertyEncoding |	The algorithm to encode data source passwords for WebSphere Application Server Liberty. The possible values are none, xor, and aes. Whether the xor or aes encoding is used, the clear password is passed as argument to the securityUtility program, which is called through an external process. You can see the password with a ps command, or in the /proc file system on UNIX operating systems.                                                         | No                       |	xor     |
| jeeVersion      |	For Liberty profile. To specify whether to install the features of the JEE6 web profile or the JEE7 web profile. Possible values are 6, 7, or auto.| No | auto |
| configureFarm   |	For WebSphere Application Server Liberty, and WebSphere Application Server full profile (not for WebSphere Application Server Network Deployment edition and Liberty collective). To specify whether the server is a server farm member. Possible values are true or false. | No	      | false   |
| farmServerId    |	A string that uniquely identify a server in a server farm. The MobileFirst Server administration services and all the MobileFirst runtimes that communicate with it must share the same value.                                                                | Yes                      |	None    |

It supports the following element for single-server deployment:

| Element     | Description      | Count |
|-------------|------------------|-------|
| `<server>`  | A single server. | 0..1  |

The <server> element, which is used in this context, has the following attribute:

| Attribute | Description      | Required | Default | 
|-----------|------------------|----------|---------|
| name	    | The server name. | Yes      | None    |

It supports the following elements for Liberty collective:

| Element               | Description                  | Count |
|-----------------------|------------------------------|-------|
| `<collectiveMember>`  | A Liberty collective member. | 0..1  |

The `<collectiveMember>` element has the following attributes:




