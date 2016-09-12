---
layout: tutorial
title: Installation Reference
weight: 9
---
## Overview
Reference information about Ant tasks and configuration sample files for the installation of IBM MobileFirst  Server, IBM MobileFirst Application Center, and IBM MobileFirst Analytics.

#### Jump to
* [Ant configuredatabase task reference](#ant-configuredatabase-task-reference)
* [Ant tasks for installation of MobileFirst Operations Console, MobileFirst Server artifacts, MobileFirst Server administration, and live update services](#ant-tasks-for-installation-of-mobilefirst-operations-console-mobilefirst-server-artifacts-mobilefirst-server-administration-and-live-update)
* [Ant tasks for installation of MobileFirst Server push service](#ant-tasks-for-installation-of-mobilefirst-push-service)
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





















