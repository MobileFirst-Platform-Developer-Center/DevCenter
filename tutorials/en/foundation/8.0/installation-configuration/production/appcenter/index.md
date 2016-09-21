---
layout: tutorial
title: Installing and configuring the Application Center	
weight: 8
---
## Overview 
You install the Application Center as part of the MobileFirst Server installation.
You can install it with one of the following methods:

* Installation with IBM® Installation Manager
* Installation with Ant tasks
* Manual installation

Optionally, you can create the database of your choice before you install MobileFirst Server with the Application Center.  
After you installed the Application Center in the web application server of your choice, you have additional configuration to do. For more information, see Configuring Application Center after installation below. If you chose a manual setup in the installer, see the documentation of the server of your choice.

> **Note:** If you intend to install applications on iOS devices through the Application Center, you must first configure the Application Center server with SSL.

For a list of installed files and tools, see [Distribution structure of MobileFirst Server](../installation-manager/#distribution-structure-of-mobilefirst-server).

#### Jump to

* [Installing Application Center with IBM Installation Manager](#installing-application-center-with-ibm-installation-manager)
* [Installing the Application Center with Ant tasks](#installing-the-application-center-with-ant-tasks)
* [Manually installing Application Center](#manually-installing-application-center)
* [Configuring Application Center after installation](#configuring-application-center-after-installation)

## Installing Application Center with IBM Installation Manager
With IBM® Installation Manager, you can install Application Center, create its database, and deploy it on an Application Server.  
Before you begin, verify that the user who runs IBM Installation Manager has the privileges that are described in [File system prerequisites](../appserver/#file-system-prerequisites).

To install IBM Application Center with IBM Installation Manager, complete the followings steps.

1. Optional: You can manually create databases for Application Center, as described in [Optional creation of databases](#optional-creation-of-databases) below. IBM Installation Manager can create the Application Center databases for you with default settings.
2. Run IBM Installation Manager, as described in [Running IBM Installation Manager](../installation-manager).
3. Select **Yes** to the question **Install IBM Application Center**.

#### Jump to
* [Optional creation of databases](#optional-creation-of-databases)
* [Installing Application Center in WebSphere Application Server Network Deployment](#installing-application-center-in-websphere-application-server-network-deployment)
* [Completing the installation](#completing-the-installation)
* [Default logins and passwords created by IBM Installation Manager for the Application Center](#default-logins-and-passwords-created-by-ibm-installation-manager-for-the-application-center)

### Optional creation of databases
If you want to activate the option to install the Application Center when you run the MobileFirst Server installer, you need to have certain database access rights that entitle you to create the tables that are required by the Application Center.

If you have sufficient database administration credentials, and if you enter the administrator user name and password in the installer when prompted, the installer can create the databases for you. Otherwise, you need to ask your database administrator to create the required database for you. The database needs to be created before you start the MobileFirst Server installer.

The following topics describe the procedure for the supported database management systems.

#### Jump to

* [Creating the DB2 database for Application Center](#creating-the-db2-database-for-application-center)
* [Creating the MySQL database for Application Center](#creating-the-mysql-database-for-application-center)
* [Creating the Oracle database for Application Center](#creating-the-oracle-database-for-application-center)

#### Creating the DB2 database for Application Center
During IBM MobileFirst Foundation installation, the installer can create the Application Center database for you.

The installer can create the Application Center database for you if you enter the name and password of a user account on the database server that has the DB2® SYSADM or SYSCTRL privilege, and the account can be accessed through SSH. Otherwise, the database administrator can create the Application Center database for you. For more information, see the [DB2 Solution](http://ibm.biz/knowctr#SSEPGG_9.7.0/com.ibm.db2.luw.admin.sec.doc/doc/c0055206.html) user documentation.

When you manually create the database, you can replace the database name (here APPCNTR) and the password with a database name and password of your choosing.

> **Important:** You can name your database and user differently, or set a different password, but ensure that you enter the appropriate database name, user name, and password correctly across the DB2 database setup. DB2 has a database name limit of 8 characters on all platforms, and has a user name and password length limit of 8 characters for UNIX and Linux systems, and 30 characters for Windows.

1. Create a system user, for example, named **wluser** in a DB2 admin group such as **DB2USERS**, using the appropriate commands for your operating system. Give it a password, for example, **wluser**. If you want multiple instances of IBM MobileFirst Server to connect to the same database, use a different user name for each connection. Each database user has a separate default schema. For more information about database users, see the DB2 documentation and the documentation for your operating system.

2. Open a DB2 command line processor, with a user that has **SYSADM** or **SYSCTRL** permissions:

* On Windows systems, click **Start → IBM DB2 → Command Line Processor**
* On Linux or UNIX systems, navigate to **~/sqllib/bin** and enter `./db2`.
* Enter database manager and SQL statements similar to the following example to create the Application Center database, replacing the user name **wluser** with your chosen user names:

    ```bash
    CREATE DATABASE APPCNTR COLLATE USING SYSTEM PAGESIZE 32768
    CONNECT TO APPCNTR
    GRANT CONNECT ON DATABASE TO USER wluser
    DISCONNECT APPCNTR
    QUIT
    ```
3. The installer can create the database tables and objects for Application Center in a specific schema. This allows you to use the same database for Application Center and for a MobileFirst project. If the IMPLICIT\_SCHEMA authority is granted to the user created in step 1 (the default in the database creation script in step 2), no further action is required. If the user does not have the IMPLICIT\_SCHEMA authority, you need to create a SCHEMA for the Application Center database tables and objects.

#### Creating the MySQL database for Application Center
During the MobileFirst installation, the installer can create the Application Center database for you.

The installer can create the database for you if you enter the name and password of the superuser account. For more information, see [Securing the Initial MySQL Accounts](http://dev.mysql.com/doc/refman/5.1/en/default-privileges.html) on your MySQL database server. Your database administrator can also create the databases for you. When you manually create the database, you can replace the database name (here APPCNTR) and password with a database name and password of your choosing. Note that MySQL database names are case-sensitive on UNIX.

1. Start the MySQL command-line tool.
2. Enter the following commands:

    ```bash
    CREATE DATABASE APPCNTR CHARACTER SET utf8 COLLATE utf8_general_ci;
    GRANT ALL PRIVILEGES ON APPCNTR.* TO 'worklight'@'Worklight-host' IDENTIFIED BY 'password';
    GRANT ALL PRIVILEGES ON APPCNTR.* TO 'worklight'@'localhost' IDENTIFIED BY 'password';
    FLUSH PRIVILEGES;
    ```
    Here, you need to replace **Worklight-host** with the name of the host on which IBM MobileFirst Foundation runs.

#### Creating the Oracle database for Application Center
During the installation, the installer can create the Application Center database, except for the Oracle 12c database type, or the user and schema inside an existing database for you.

The installer can create the database, except for the Oracle 12c database type, or the user and schema inside an existing database if you enter the name and password of the Oracle administrator on the database server, and the account can be accessed through SSH. Otherwise, the database administrator can create the database or user and schema for you. When you manually create the database or user, you can use database names, user names, and a password of your choosing. Note that lowercase characters in Oracle user names can lead to trouble.

1. If you do not already have a database named **ORCL**, use the Oracle Database Configuration Assistant (DBCA) and follow the steps in the wizard to create a new general-purpose database named **ORCL**:
    * Use global database name **ORCL\_your\_domain**, and system identifier (SID) **ORCL**.
    * On the **Custom Scripts** tab of the step **Database Content**, do not run the SQL scripts, because you must first create a user account.
    * On the **Character Sets** tab of the step **Initialization Parameters**, select **Use Unicode (AL32UTF8) character set and UTF8 - Unicode 3.0 UTF-8 national character set**.
    * Complete the procedure, accepting the default values.
2. Create a database user either by using **Oracle Database Control**, or by using the **Oracle SQLPlu**s command-line interpreter.
    * Using **Oracle Database Control**:
        * Connect as **SYSDBA**.
        * Go to the **Users** page: click **Server**, then **Users** in the **Security** section.
        * Create a user, for example, named **APPCENTER**. If you want multiple instances of IBM MobileFirst Server to connect to the same general-purpose database you created in step 1, use a different user name for each connection. Each database user has a separate default schema.
        * Assign the following attributes:
            * Profile: **DEFAULT**
            * Authentication: **password**
            * Default tablespace: **USERS**
            * Temporary tablespace: **TEMP**
            * Status: **Unlocked**
            * Add system privilege: **CREATE SESSION**
            * Add system privilege: **CREATE SEQUENCE**
            * Add system privilege: **CREATE TABLE**
            * Add quota: **Unlimited for tablespace USERS**
    * Using the **Oracle SQLPlus** command-line interpreter:  
    The commands in the following example create a user named APPCENTER for the database:
    
        ```bash
        CONNECT SYSTEM/<SYSTEM_password>@ORCL
        CREATE USER APPCENTER IDENTIFIED BY password DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;
        GRANT CREATE SESSION, CREATE SEQUENCE, CREATE TABLE TO APPCENTER;
        DISCONNECT;
        ```

### Installing Application Center in WebSphere Application Server Network Deployment
To install Application Center in a set of WebSphere® Application Server Network Deployment servers, run IBM® Installation Manager on the machine where the deployment manager is running.

1. When IBM Installation Manager prompts you to specify the database type, select any option other than **Apache Derby**. IBM MobileFirst Foundation supports Apache Derby only in embedded mode, and this choice is incompatible with deployment through WebSphere Application Server Network Deployment.
2. In the installer panel in which you specify the WebSphere Application Server installation directory, select the deployment manager profile.

    > **Attention:** Do not select an application server profile and then a single managed server: doing so causes the deployment manager to overwrite the configuration of the server regardless of whether you install on the machine on which the deployment manager is running or on a different machine.
3. Select the required scope depending on where you want Application Center to be installed. The following table lists the available scopes:

    | Scope	 | Explanation | 
    |--------|-------------|
    | Cell	 | Installs Application Center in all application servers of the cell. | 
    | Cluster| Installs Application Center in all application servers of the specified cluster. | 
    | Node   | (excluding clusters)	Installs Application Center in all application servers of the specified node that are not in a cluster. | 
    | Server | Installs Application Center in the specified server, which is not in a cluster. | 

4. Restart the target servers by following the procedure in [Completing the installation](#completing-the-installation) below.

The installation has no effect outside the set of servers in the specified scope. The JDBC providers and JDBC data sources are defined with the specified scope. The entities that have a cell-wide scope (the applications and, for DB2®, the authentication alias) have a suffix in their name that makes them unique. So, you can install Application Center in different configurations or even different versions of Application Center, in different clusters of the same cell.

> **Note:** Because the JDBC driver is installed only in the specified set of application servers, the Test connection button for the JDBC data sources in the WebSphere Application Server administration console of the deployment manager might not work.

If you use a front-end HTTP server, you need to configure the public URL as well.

### Completing the installation
When installation is complete, you must restart the web application server in certain cases.  
You must restart the web application server in the following circumstances:

* When you are using WebSphere® Application Server with DB2® as database type.
* When you are using WebSphere Application Server and have opened it without the application security enabled before you installed IBM MobileFirst Application Center or MobileFirst Server.

The MobileFirst installer must activate the application security of WebSphere Application Server (if not active yet) to install Application Center. Then, for this activation to take place, restart the application server after the installation of MobileFirst Server completed.

* When you are using WebSphere Application Server Liberty or Apache Tomcat.
* After you upgraded from a previous version of MobileFirst Server.

If you are using WebSphere Application Server Network Deployment and chose an installation through the deployment manager:

* You must restart the servers that were running during the installation and on which the MobileFirst Server web applications are installed.

To restart these servers with the deployment manager console, select **Applications → Application Types → WebSphere enterprise applications → IBM_Application\_Center\_Services → Target specific application status**.

* You do not have to restart the deployment manager or the node agents.

> **Note:** Only the Application Center is installed in the application server. A MobileFirst Operations Console is not installed by default. To install a MobileFirst Operations Console, you need to follow the steps in [Deploying MobileFirst Server to the cloud]().

### Default logins and passwords created by IBM Installation Manager for the Application Center
IBM® Installation Manager creates the logins by default for the Application Center, according to your application server. You can use these logins to test the Application Center.

#### WebSphere Application Server full profile
The login **appcenteradmin** is created with a password that is generated and displayed during the installation.

All users authenticated in the application realm are also authorized to access the **appcenteradmin** role. This is not meant for a production environment, especially if WebSphere® Application Server is configured with a single security domain.

For more information about how to modify these logins, see [Configuring the Java EE security roles on WebSphere Application Server full profile]().

#### WebSphere Application Server Liberty profile
* The login demo is created in the basicRegistry with the password demo.
* The login appcenteradmin is created in the basicRegistry with the password admin.

For more information about how to modify these logins, see [Configuring the Java EE security roles on WebSphere Application Server Liberty profile]().

#### Apache Tomcat
* The login demo is created with the password demo.
* The login guest is created with the password guest.
* The login appcenteradmin is created with the password admin.

For more information about how to modify these logins, see [Configuring the Java EE security roles on Apache Tomcat]().




## Installing the Application Center with Ant tasks
Learn about the Ant tasks that you can use to install Application Center.

#### Jump to

* [Creating and configuring the database for Application Center with Ant tasks](#creating-and-configuring-the-database-for-application-center-with-ant-tasks)
* [Deploying the Application Center Console and Services with Ant tasks](#deploying-the-application-center-console-and-services-with-ant-tasks)

### Creating and configuring the database for Application Center with Ant tasks
If you did not manually create the database, you can use Ant tasks to create and configure your database for Application Center. If your database already exists, you can perform only the configuration steps with Ant tasks.

Before you begin, make sure that a database management system (DBMS) is installed and running on a database server, which can be on the same computer, or a different one.

The Ant tasks for Application Center are in the **ApplicationCenter/configuration-samples** directory of the MobileFirst Server distribution.

If you want to start the Ant task from a computer where MobileFirst Server is not installed, you must copy the following files to that computer:
    
* The library **mf\_server\_install\_dir/MobileFirstServer/mfp-ant-deployer.jar**
* The directory that contains binary files of the aapt program, from the Android SDK platform-tools package: **mf\_server\_install\_dir/ApplicationCenter/tools/android-sdk**
* The Ant sample files that are in **mf\_server\_install\_dir/ApplicationCenter/configuration-samples**

> **Note:** The **mf\_server\_install\_dir** placeholder represents the directory where you installed MobileFirst Server.

If you did not create your database manually, as described in [Optional creation of databases](#optional-creation-of-databases), follow steps 1 to 3 below.
If your database already exists, you must create only the database tables. Follow steps 4 to 7 below.

1. Copy the sample Ant file that corresponds to your DBMS. The files for creating a database are named after the following pattern:

    ```bash
    create-appcenter-database-<dbms>.xml
    ```
    
2. Edit the Ant file, and replace the placeholder values with the properties at the beginning of the file.
3. Run the following commands to create the Application Center database:

    ```bash
    ant -f create-appcenter-database-<dbms>.xml databases
    ```
    
    You can find the Ant command in **mf\_server\_install\_dir/shortcuts**.
    
    If the database already exists, then you must create only the database tables by completing the following steps:

4. Copy the sample Ant file that corresponds to both your application server, and your DBMS. The files for configuring an existing database are named after this pattern:
    
    ```bash
    configure-appcenter-<appServer>-<dbms>.xml
    ```
    
5. Edit the Ant file, and replace the placeholder values with the properties at the beginning of the file.
6. Run the following commands to configure the database:

    ```bash
    ant -f configure-appcenter-<appServer>-<dbms>.xml databases
    ```
    
    You can find the Ant command in **mf\_server\_install\_dir/shortcuts**.
    
7. Save the Ant file. You might need it later to apply a fix pack, or perform an upgrade.

If you do not want to save the passwords, you can replace them by "************" (12 stars) for interactive prompting.

### Deploying the Application Center Console and Services with Ant tasks
Use Ant tasks to deploy the Application Center Console and Services to an application server, and configure data sources, properties, and database drivers that are used by Application Center.

Before you begin,

* Complete the procedure at [Creating and configuring the database for Application Center with Ant tasks](#creating-and-configuring-the-database-for-application-center-with-ant-tasks).
* You must run the Ant task on the computer where the application server is installed, or the Network Deployment Manager for WebSphere® Application Server Network Deployment. If you want to start the Ant task from a computer where MobileFirst Server is not installed, you must copy the following files and directories to that computer:

    * The library **mf\_server\_install\_dir/MobileFirstServer/mfp-ant-deployer.jar**
    * The web applications (WAR and EAR files) in **mf_server\_install\_dir/ApplicationCenter/console**
    * The directory that contains the binary files of the aapt program, from the Android SDK platform-tools package: **mf\_server\_install\_dir/ApplicationCenter/tools/android-sdk**
    * The Ant sample files that are in **mf\_server\_install\_dir/ApplicationCenter/configuration-samples**

> **Note:** The mf_server_install_dir placeholder represents the directory where you installed MobileFirst Server.

1. Copy the Ant file that corresponds both to your application server, and your DBMS. The files for configuring Application Center are named after the following pattern:

    ```bash
    configure-appcenter-<appserver>-<dbms>.xml
    ```
    
2. Edit the Ant file, and replace the placeholder values with the properties at the beginning of the file.
3. Run the following command to deploy the Application Center Console and Services to an application server:

    ```bash
    ant -f configure-appcenter-<appserver>-<dbms>.xml install
    ```
    
    You can find the Ant command in **mf\_server\_install\_dir/shortcuts**.

    > **Note:** With these Ant files, you can also do the following actions:
    > 
    > * Uninstall Application Center, with the target **uninstall**.
    > * Update Application Center with the target **minimal-update**, to apply a fix pack.

4. Save the Ant file. You might need it later to apply a fix pack or perform an upgrade. If you do not want to save the passwords, you can replace them by "************" (12 stars) for interactive prompting.
5. If you installed on WebSphere Application Server Liberty profile, or Apache Tomcat, check that the aapt program is executable for all users. If needed, you must set the proper user rights. For example, on UNIX / Linux systems:

    ```bash
    chmod a+x mf_server_install_dir/ApplicationCenter/tools/android-sdk/*/aapt*
    ```

## Manually installing Application Center
A reconfiguration is necessary for the MobileFirst Server to use a database or schema that is different from the one that was specified during its installation. This reconfiguration depends on the type of database and on the kind of application server.

On application servers other than Apache Tomcat, you can deploy Application Center from two WAR files or one EAR file.

> **Restriction:** Whether you install Application Center with IBM® Installation Manager as part of the MobileFirst Server installation or manually, remember that "rolling updates" of Application Center are not supported. That is, you cannot install two versions of Application Center (for example, V5.0.6 and V6.0.0) that operate on the same database.

#### Jump to

* [Configuring the DB2 database manually for IBM MobileFirst Platform Application Center]()
* [Configuring the Apache Derby database manually for Application Center]()
* [Configuring the MySQL database manually for Application Center]()
* [Configuring the Oracle database manually for IBM MobileFirst Platform Application Center]()
* [Deploying the Application Center WAR files and configuring the application server manually]()
* [Deploying the Application Center EAR file and configuring the application server manually]()

### Configuring the DB2 database manually for IBM MobileFirst Platform Application Center
### Configuring the Apache Derby database manually for Application Center
### Configuring the MySQL database manually for Application Center
### Configuring the Oracle database manually for IBM MobileFirst Platform Application Center
### Deploying the Application Center WAR files and configuring the application server manually
### Deploying the Application Center EAR file and configuring the application server manually


## Configuring Application Center after installation
