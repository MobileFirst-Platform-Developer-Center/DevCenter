---
layout: tutorial
title: Installing and configuring the IBM MobileFirst Foundation Application Center	
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

* [Configuring the DB2 database manually for Application Center](#configuring-the-db2-database-manually-for-application-center)
* [Configuring the Apache Derby database manually for Application Center](#configuring-the-apache-derby-database-manually-for-application-center)
* [Configuring the MySQL database manually for Application Center](#configuring-the-mysql-database-manually-for-application-center)
* [Configuring the Oracle database manually for Application Center](#configuring-the-oracle-database-manually-for-application-center)
* [Deploying the Application Center WAR files and configuring the application server manually](#deploying-the-application-center-war-files-and-configuring-the-application-server-manually)
* [Deploying the Application Center EAR file and configuring the application server manually](#deploying-the-application-center-ear-file-and-configuring-the-application-server-manually)

### Configuring the DB2 database manually for Application Center
You configure the DB2® database manually by creating the database, creating the database tables, and then configuring the relevant application server to use this database setup.

1. Create the database. This step is described in [Creating the DB2 database for Application Center](#creating-the-db2-database-for-application-center).
2. Create the tables in the database. This step is described in [Setting up your DB2 database manually for Application Center](#setting-up-your-db2-database-manually-for-application-center).
3. Perform the application server-specific setup as the following list shows.

#### Jump to

* [Setting up your DB2 database manually for Application Center](#setting-up-your-db2-database-manually-for-application-center)
* [Configuring Liberty profile for DB2 manually for Application Center](#configuring-liberty-profile-for-db2-manually-for-application-center)
* [Configuring WebSphere Application Server for DB2 manually for Application Center](#configuring-websphere-application-server-for-db2-manually-for-application-center)
* [Configuring Apache Tomcat for DB2 manually for Application Center](#configuring-apache-tomcat-for-db2-manually-for-application-center)

#### Setting up your DB2 database manually for Application Center
Set up your DB2 database for Application Center by creating the database schema.

1. Create a system user, **worklight**, in a DB2 admin group such as **DB2USERS**, by using the appropriate commands for your operating system. Give it the password **worklight**. For more information, see the DB2 documentation and the documentation for your operating system.

> **Important:** You can name your user differently, or set a different password, but ensure that you enter the appropriate user name and password correctly across the DB2 database setup. DB2 has a user name and password length limit of 8 characters for UNIX and Linux systems, and 30 characters for Windows.

2. Open a DB2 command line processor, with a user that has **SYSADM** or **SYSCTRL** permissions:
    * On Windows systems, click **Start → IBM DB2 → Command Line Processor**.
    * On Linux or UNIX systems, go to **~/sqllib/bin** and enter `./db2`.

3. Enter the following database manager and SQL statements to create a database that is called **APPCNTR**:

    ```bash
    CREATE DATABASE APPCNTR COLLATE USING SYSTEM PAGESIZE 32768 
    CONNECT TO APPCNTR 
    GRANT CONNECT ON DATABASE TO USER worklight 
    QUIT
    ```
    
4. Run DB2 with the following commands to create the **APPCNTR** tables, in a schema named **APPSCHM** (the name of the schema can be changed). This command can be run on an existing database that has a page size compatible with the one defined in step 3.
    
    ```bash
    db2 CONNECT TO APPCNTR
    db2 SET CURRENT SCHEMA = 'APPSCHM'
    db2 -vf product_install_dir/ApplicationCenter/databases/create-appcenter-db2.sql -t
    ```
    
#### Configuring Liberty profile for DB2 manually for Application Center
You can set up and configure your DB2® database manually for Application Center with WebSphere® Application Server Liberty profile.  
Complete the DB2 Database Setup procedure before continuing.

1. Add the DB2 JDBC driver JAR file to **$LIBERTY\_HOME/wlp/usr/shared/resources/db2**.

    If that directory does not exist, create it. You can retrieve the file in one of two ways:
    * Download it from [DB2 JDBC Driver Versions](http://www.ibm.com/support/docview.wss?uid=swg21363866).
    * Fetch it from the **db2\_install\_dir/java** on the DB2 server directory.

2. Configure the data source in the **$LIBERTY_HOME/wlp/usr/servers/worklightServer/server.xml** file as follows:

    In this path, you can replace **worklightServer** by the name of your server.

    ```xml
    <library id="DB2Lib">
        <fileset dir="${shared.resource.dir}/db2" includes="*.jar"/>
    </library>
    
    <!-- Declare the IBM Application Center database. -->
    <dataSource jndiName="jdbc/AppCenterDS" transactional="false">
      <jdbcDriver libraryRef="DB2Lib"/>
      <properties.db2.jcc databaseName="APPCNTR"  currentSchema="APPSCHM"
            serverName="db2server" portNumber="50000"
            user="worklight" password="worklight"/>
    </dataSource> 
    ```
    
    The **worklight** placeholder after **user=** is the name of the system user with **CONNECT** access to the **APPCNTR** database that you have previously created.  
    The **worklight** placeholder after **password=** is this user's password. If you have defined either a different user name, or a different password, or both, replace **worklight** accordingly. Also, replace **db2server** with the host name of your DB2 server (for example, **localhost**, if it is on the same computer).

    DB2 has a user name and password length limit of 8 characters for UNIX and Linux systems, and 30 characters for Windows.

3. You can encrypt the database password with the securityUtility program in **liberty\_install\_dir/bin**.

#### Configuring WebSphere Application Server for DB2 manually for Application Center
You can set up and configure your DB2® database manually for Application Center with WebSphere® Application Server.

1. Determine a suitable directory for the JDBC driver JAR file in the WebSphere Application Server installation directory.
    * For a stand-alone server, you can use a directory such as **was\_install\_dir/optionalLibraries/IBM/Worklight/db2**.
    * For deployment to a WebSphere Application Server ND cell, use **was\_install\_dir/profiles/profile-name/config/cells/cell-name/Worklight/db2**.
    * For deployment to a WebSphere Application Server ND cluster, use **was\_install\_dir/profiles/profile-name/config/cells/cell-name/clusters/cluster-name/Worklight/db2**.
    * For deployment to a WebSphere Application Server ND node, use **was\_install\_dir/profiles/profile-name/config/cells/cell-name/nodes/node-name/Worklight/db2**.
    * For deployment to a WebSphere Application Server ND server, use **was\_install\_dir/profiles/profile-name/config/cells/cell-name/nodes/node-name/servers/server-name/Worklight/db2**.

    If this directory does not exist, create it.
    
2. Add the DB2 JDBC driver JAR file and its associated license files, if any, to the directory that you determined in step 1.  
    You can retrieve the driver file in one of two ways:
    * Download it from [DB2 JDBC Driver Versions](http://www.ibm.com/support/docview.wss?uid=swg21363866).
    * Fetch it from the **db2\_install\_dir/java** directory on the DB2 server.

3. In the WebSphere Application Server console, click **Resources → JDBC → JDBC Providers**.  
    * Select the appropriate scope from the **Scope** combination box.
    * Click **New**.
    * Set **Database type** to **DB2**.
    * Set **Provider type** to **DB2 Using IBM JCC Driver**.
    * Set **Implementation Type** to **Connection pool data source**.
    * Set **Name** to **DB2 Using IBM JCC Driver**.
    * Click **Next**.
    * Set the class path to the set of JAR files in the directory that you determined in step 1, replacing **was\_install\_dir/profiles/profile-name** with the WebSphere Application Server variable reference `${USER_INSTALL_ROOT}`.
    * Do not set **Native library path**.
    * Click **Next**.
    * Click **Finish**.
    * The JDBC provider is created.
    * Click **Save**.

4. Create a data source for the Application Center database:
    * Click **Resources → JDBC → Data sources**.
    * Select the appropriate scope from the **Scope** combination box.
    * Click **New** to create a data source.
    * Set the **Data source name** to **Application Center Database**.
    * Set **JNDI Name** to **jdbc/AppCenterDS**.
    * Click **Next**.
    * Enter properties for the data source, for example:
        * **Driver type**: 4
        * **Database Name**: APPCNTR
        * **Server name**: localhost
        * **Port number**: 50000 (default)
    * Click **Next**.
    * Create JAAS-J2C authentication data, specifying the DB2 user name and password as its properties. If necessary, go back to the data source creation wizard, by repeating steps 4.a to 4.h.
    * Select the authentication alias that you created in the **Component-managed authentication alias** combination box (not in the **Container-managed authentication alias** combination box).
    * Click **Next** and **Finish**.
    * Click **Save**.
    * In **Resources → JDBC → Data sources**, select the new data source.
    * Click **WebSphere Application Server data source properties**.
    * Select the **Non-transactional data source** check box.
    * Click **OK**.
    * Click **Save**.
    * Click **Custom properties for the data source**, select the property **currentSchema**, and set the value to the schema used to create the Application Center tables (APPSCHM in this example).
5. Test the data source connection by selecting **Data Source** and clicking **Test Connection**.

Leave **Use this data source in (CMP)** selected.

#### Configuring Apache Tomcat for DB2 manually for Application Center
If you want to manually set up and configure your DB2® database for Application Center with Apache Tomcat server, use the following procedure.  
Before you continue, complete the DB2 database setup procedure.

1. Add the DB2 JDBC driver JAR file.

    You can retrieve this JAR file in one of the following ways:
    * Download it from [DB2 JDBC Driver Versions](http://www.ibm.com/support/docview.wss?uid=swg21363866).
    * Or fetch it from the directory **db2\_install\_dir/java** on the DB2 server) to **$TOMCAT_HOME/lib**.

2. Prepare an XML statement that defines the data source, as shown in the following code example.

    ```xml
    <Resource auth="Container"
            driverClassName="com.ibm.db2.jcc.DB2Driver"
            name="jdbc/AppCenterDS"
            username="worklight"
            password="password"
            type="javax.sql.DataSource"
            url="jdbc:db2://server:50000/APPCNTR:currentSchema=APPSCHM;"/>
    ```
    
    The **worklight** parameter after **username=** is the name of the system user with "CONNECT" access to the **APPCNTR** database that you have previously created. The **password** parameter after **password=** is this user's password. If you have defined either a different user name, or a different password, or both, replace these entries accordingly.

    DB2 enforces limits on the length of user names and passwords.
    * For UNIX and Linux systems: 8 characters
    * For Windows: 30 characters

3. Insert this statement in the server.xml file, as indicated in [Configuring Apache Tomcat for Application Center manually](#configuring-apache-tomcat-for-application-center-manually).

### Configuring the Apache Derby database manually for Application Center
You configure the Apache Derby database manually by creating the database and database tables, and then configuring the relevant application server to use this database setup.

1. Create the database and the tables within them. This step is described in [Setting up your Apache Derby database manually for Application Center](#setting-up-your-apache-database-manually-for-application-center).
2. Configure the application server to use this database setup. Go to one of the following topics.

#### Jump to

* [Setting up your Apache Derby database manually for Application Center](#setting-up-your-apache-derby-database-manually-for-application-center)
* [Configuring Liberty profile for Derby manually for Application Center](#configuring-liberty-profile-for-derby-manually-for-application-center)
* [Configuring WebSphere Application Server for Derby manually for Application Center](#configuring-websphere-application-server-for-derby-manually-for-application-center)
* [Configuring Apache Tomcat for Derby manually for Application Center](#configuring-apache-tomcat-for-derby-manually-for-application-center)

#### Setting up your Apache Derby database manually for Application Center
Set up your Apache Derby database for Application Center by creating the database schema.

1. In the location where you want the database to be created, run **ij.bat** on Windows systems or **ij.sh** on UNIX and Linux systems.

    > **Note:** The ij program is part of Apache Derby. If you do not already have it installed, you can download it from [Apache Derby: Downloads](http://db.apache.org/derby/derby_downloads).

    For supported versions of Apache Derby, see [System requirements](../../../product-overview/requirements).  
    The script displays ij version number.
    
2. At the command prompt, enter the following commands:

    ```bash
    connect 'jdbc:derby:APPCNTR;user=APPCENTER;create=true';
    run '<product_install_dir>/ApplicationCenter/databases/create-appcenter-derby.sql';
    quit;
    ```

#### Configuring Liberty profile for Derby manually for Application Center
If you want to manually set up and configure your Apache Derby database for Application Center with WebSphere® Application Server Liberty profile, use the following procedure. Complete the Apache Derby database setup procedure before continuing.

Configure the data source in the $LIBERTY_HOME/usr/servers/worklightServer/server.xml file (worklightServer may be replaced in this path by the name of your server) as follows:

```xml
<!-- Declare the jar files for Derby access through JDBC. -->
<library id="derbyLib">
  <fileset dir="C:/Drivers/derby" includes="derby.jar" />
</library>

<!-- Declare the IBM Application Center database. -->
<dataSource jndiName="jdbc/AppCenterDS" transactional="false" statementCacheSize="10">
  <jdbcDriver libraryRef="derbyLib" 
              javax.sql.ConnectionPoolDataSource="org.apache.derby.jdbc.EmbeddedConnectionPoolDataSource40"/>
  <properties.derby.embedded databaseName="DERBY_DATABASES_DIR/APPCNTR" user="APPCENTER"
                             shutdownDatabase="false" connectionAttributes="upgrade=true"/>
  <connectionManager connectionTimeout="180" 
                     maxPoolSize="10" minPoolSize="1" 
                     reapTime="180" maxIdleTime="1800" 
                     agedTimeout="7200" purgePolicy="EntirePool"/>
</dataSource>
```

#### Configuring WebSphere Application Server for Derby manually for Application Center
You can set up and configure your Apache Derby database manually for Application Center with WebSphere® Application Server. Complete the Apache Derby database setup procedure before continuing.

1. Determine a suitable directory for the JDBC driver JAR file in the WebSphere Application Server installation directory. If this directory does not exist, create it.
    * For a standalone server, you can use a directory such as **was\_install\_dir/optionalLibraries/IBM/Worklight/derby**.
    * For deployment to a WebSphere Application Server ND cell, use **was\_install\_dir/profiles/profile-name/config/cells/cell-name/Worklight/derby**.
    * For deployment to a WebSphere Application Server ND cluster, use **was\_install\_dir/profiles/profile-name/config/cells/cell-name/clusters/cluster-name/Worklight/derby**.
    * For deployment to a WebSphere Application Server ND node, use **was\_install\_dir/profiles/profile-name/config/cells/cell-name/nodes/node-name/Worklight/derby**.
    * For deployment to a WebSphere Application Server ND server, use **was\_install\_dir/profiles/profile-name/config/cells/cell-name/nodes/node-name/servers/server-name/Worklight/derby**.
2. Add the **Derby** JAR file from **product\_install\_dir/ApplicationCenter/tools/lib/derby.jar** to the directory determined in step 1.
3. Set up the JDBC provider.
    * In the WebSphere Application Server console, click **Resources → JDBC → JDBC Providers**.
    * Select the appropriate scope from the **Scope** combination box.
    * Click **New**.
    * Set **Database Type** to **User-defined**.
    * Set **class Implementation name** to **org.apache.derby.jdbc.EmbeddedConnectionPoolDataSource40**.
    * Set **Name** to **Worklight - Derby JDBC Provider**.
    * Set **Description** to **Derby JDBC provider for Worklight**.
    * Click **Next**.
    * Set the **Class path** to the JAR file in the directory determined in step 1, replacing **was\_install\_dir/profiles/profile-name** with the WebSphere Application Server variable reference **${USER\_INSTALL\_ROOT}**.
    * Click **Finish**.
4. Create the data source for the **Worklight** database.
    * In the WebSphere Application Server console, click **Resources → JDBC → Data sources**.
    * Select the appropriate scope from the **Scope** combination box.
    * Click **New**.
    * Set **Data source Name** to **Application Center Database**.
    * Set **JNDI** name to **jdbc/AppCenterDS**.
    * Click **Next**.
    * Select the existing JDBC Provider that is named **Worklight - Derby JDBC Provider**.
    * Click **Next**.
    * Click **Next**.
    * Click **Finish**.
    * Click **Save**.
    * In the table, click the **Application Center Database** data source that you created.
    * Under **Additional Properties**, click **Custom properties**.
    * Click **databaseName**.
    * Set **Value** to the path to the **APPCNTR** database that is created in [Setting up your Apache Derby database manually for Application Center](#setting-up-your-apache-derby-manually-for-application-center).
    * Click **OK**.
    * Click **Save**.
    * At the top of the page, click **Application Center Database**.
    * Under **Additional Properties**, click **WebSphere Application Server data source properties**.
    * Select **Non-transactional datasource**.
    * Click **OK**.
    * Click **Save**.
    * In the table, select the **Application Center Database** data source that you created.
    * Optional: Only if you are not on the console of a WebSphere Application Server Deployment Manager, click **test connection**.

#### Configuring Apache Tomcat for Derby manually for Application Center
You can set up and configure your Apache Derby database manually for Application Center with the Apache Tomcat application server. Complete the Apache Derby database setup procedure before continuing.

1. Add the **Derby** JAR file from **product\_install\_dir/ApplicationCenter/tools/lib/derby.jar** to the directory **$TOMCAT\_HOME/lib**.
2. Prepare an XML statement that defines the data source, as shown in the following code example.

    ```xml
    <Resource auth="Container"
            driverClassName="org.apache.derby.jdbc.EmbeddedDriver"
            name="jdbc/AppCenterDS"
            username="APPCENTER"
            password=""
            type="javax.sql.DataSource"
            url="jdbc:derby:DERBY_DATABASES_DIR/APPCNTR"/>
    ```

3. Insert this statement in the **server.xml** file, as indicated in [Configuring Apache Tomcat for Application Center manually](#configuring-apache-tomcat-for-application-center-manually).

### Configuring the MySQL database manually for Application Center
You configure the MySQL database manually by creating the database, creating the database tables, and then configuring the relevant application server to use this database setup.

1. Create the database. This step is described in [Creating the MySQL database for Application Center](#creating-the-mysql-database-for-application-center).
2. Create the tables in the database. This step is described in [Setting up your MySQL database manually for Application Center](#setting-up-your-mysql).
3. Perform the application server-specific setup as the following list shows.

#### Jump to

* [Setting up your MySQL database manually for Application Center](#setting-up-your-mysql-database-manually-for-application-center)
* [Configuring Liberty profile for MySQL manually for Application Center](#configuring-liberty-profile-for-mysql-manually-for-application-center)
* [Configuring WebSphere Application Server for MySQL manually for Application Center](#configuring-websphere-application-server-for-mysql-manually-for-application-center)
* [Configuring Apache Tomcat for MySQL manually for Application Center](#configuring-apache-tomcat-for-mysql-manually-for-application-center)

#### Setting up your MySQL database manually for Application Center
Complete the following procedure to set up your MySQL database.

1. Create the database schema.
    * Run a MySQL command line client with the option `-u root`.
    * Enter the following commands:

    ```bash
    CREATE DATABASE APPCNTR CHARACTER SET utf8 COLLATE utf8_general_ci;
    GRANT ALL PRIVILEGES ON APPCNTR.* TO 'worklight'@'Worklight-host'IDENTIFIED BY 'worklight';
    GRANT ALL PRIVILEGES ON APPCNTR.* TO 'worklight'@'localhost' IDENTIFIED BY 'worklight';
    FLUSH PRIVILEGES;

    USE APPCNTR;
    SOURCE product_install_dir/ApplicationCenter/databases/create-appcenter-mysql.sql;
    ```
    
    Where **worklight** before the "at" sign (@) is the user name, **worklight** after `IDENTIFIED BY` is its password, and **Worklight-host** is the name of the host on which IBM MobileFirst Foundation runs.

2. Add the following property to your MySQL option file: max_allowed_packet=256M.  
    For more information about option files, see the MySQL documentation at MySQL.

3. Add the following property to your MySQL option file: innodb_log_file_size = 250M  
    For more information about the innodb_log_file_size property, see the MySQL documentation, section innodb_log_file_size.

#### Configuring Liberty profile for MySQL manually for Application Center
If you want to manually set up and configure your MySQL database for Application Center with WebSphere® Application Server Liberty profile, use the following procedure. Complete the MySQL database setup procedure before continuing.

> **Note:** MySQL in combination with WebSphere Application Server Liberty profile or WebSphere Application Server full profile is not classified as a supported configuration. For more information, see [WebSphere Application Server Support Statement](http://www.ibm.com/support/docview.wss?uid=swg27004311). You can use IBM® DB2® or another database supported by WebSphere Application Server to benefit from a configuration that is fully supported by IBM Support.

1. Add the MySQL JDBC driver JAR file to **$LIBERTY_HOME/wlp/usr/shared/resources/mysql**. If that directory does not exist, create it.
2. Configure the data source in the **$LIBERTY_HOME/usr/servers/worklightServer/server.xml** file (**worklightServer** may be replaced in this path by the name of your server) as follows:

```xml
<!-- Declare the jar files for MySQL access through JDBC. -->
<library id="MySQLLib">
  <fileset dir="${shared.resource.dir}/mysql" includes="*.jar"/>
</library>


<!-- Declare the IBM Application Center database. -->
<dataSource jndiName="jdbc/AppCenterDS" transactional="false">
  <jdbcDriver libraryRef="MySQLLib"/>
  <properties databaseName="APPCNTR" 
              serverName="mysqlserver" portNumber="3306" 
              user="worklight" password="worklight"/>
</dataSource>
```

where **worklight** after **user=** is the user name, **worklight** after **password=** is this user's password, and **mysqlserver** is the host name of your MySQL server (for example, localhost, if it is on the same machine).

3. You can encrypt the database password with the securityUtility program in `<liberty_install_dir>/bin`.

#### Configuring WebSphere Application Server for MySQL manually for Application Center
If you want to manually set up and configure your MySQL database for Application Center with WebSphere® Application Server, use the following procedure. Complete the MySQL database setup procedure before continuing.

> **Note:** MySQL in combination with WebSphere Application Server Liberty profile or WebSphere Application Server full profile is not classified as a supported configuration. For more information, see [WebSphere Application Server Support Statement](http://www.ibm.com/support/docview.wss?uid=swg27004311). We suggest that you use IBM® DB2® or another database supported by WebSphere Application Server to benefit from a configuration that is fully supported by IBM Support.

1. Determine a suitable directory for the JDBC driver JAR file in the WebSphere Application Server installation directory.
    * For a standalone server, you can use a directory such as **WAS\_INSTALL\_DIR/optionalLibraries/IBM/Worklight/mysql**.
    * For deployment to a WebSphere Application Server ND cell, use **WAS\_INSTALL\_DIR/profiles/profile-name/config/cells/cell-name/Worklight/mysql**.
    * For deployment to a WebSphere Application Serverr ND cluster, use **WAS\_INSTALL\_DIR/profiles/profile-name/config/cells/cell-name/clusters/cluster-name/Worklight/mysql**.
    * For deployment to a WebSphere Application Server ND node, use **WAS\_INSTALL\_DIR/profiles/profile-name/config/cells/cell-name/nodes/node-name/Worklight/mysql**.
    * For deployment to a WebSphere Application Server ND server, use **WAS\_INSTALL\_DIR/profiles/profile-name/config/cells/cell-name/nodes/node-name/servers/server-name/Worklight/mysql**.

    If this directory does not exist, create it.
    
2. Add the MySQL JDBC driver JAR file downloaded from [Download Connector/J](http://dev.mysql.com/downloads/connector/j/) to the directory determined in step 1.
3. Set up the JDBC provider:
    * In the WebSphere Application Server console, click **Resources → JDBC → JDBC Providers**.
    * Select the appropriate scope from the **Scope** combination box.
    * Click **New**.
    * Create a **JDBC provider** named **MySQL**.
    * Set **Database type** to **User defined**.
    * Set **Scope** to **Cell**.
    * Set **Implementation class** to **com.mysql.jdbc.jdbc2.optional.MysqlConnectionPoolDataSource**.
    * Set **Database classpath** to the **JAR file** in the directory determined in step 1, replacing **WAS\_INSTALL\_DIR/profiles/profile-name** with the WebSphere Application Server variable reference **${USER_INSTALL_ROOT}**.
    * Save your changes.
4. Create a data source for the IBM Application Center database:
    * Click **Resources → JDBC → Data sources**.
    * Select the appropriate scope from the **Scope** combination box.
    * Click **New** to create a data source.
    * Type any name (for example, Application Center Database).
    * Set **JNDI Name** to **jdbc/AppCenterDS**.
    * Use the existing JDBC Provider MySQL, defined in the previous step.
    * Set **Scope** to **New**.
    * On the **Configuration** tab, select **Non-transactional data source**.
    * Click **Next** a number of times, leaving all other settings as defaults.
    * Save your changes.
5. Set the custom properties of the new data source.
    * Select the new data source.
    * Click **Custom properties**.
    Set the following properties:
    
    ```xml
    portNumber = 3306
    relaxAutoCommit=true
    databaseName = APPCNTR
    serverName = the host name of the MySQL server
    user = the user name of the MySQL server
    password = the password associated with the user name
    ```

6. Set the WebSphere Application Server custom properties of the new data source.
    * In **Resources → JDBC → Data sources**, select the **new data source**.
    * Click **WebSphere Application Server data source properties**.
    * Select **Non-transactional data source**.
    * Click **OK**.
    * Click **Save**.

#### Configuring Apache Tomcat for MySQL manually for Application Center
If you want to manually set up and configure your MySQL database for Application Center with the Apache Tomcat server, use the following procedure. Complete the MySQL database setup procedure before continuing.

1. Add the MySQL Connector/J JAR file to the **$TOMCAT_HOME/lib** directory.
2. Prepare an XML statement that defines the data source, as shown in the following code example. Insert this statement in the server.xml file, as indicated in [Configuring Apache Tomcat for Application Center manually](#configuring-apache-tomcat-for-application-center-manually).

```xml
<Resource name="jdbc/AppCenterDS"
            auth="Container"
            type="javax.sql.DataSource"
            maxActive="100"
            maxIdle="30"
            maxWait="10000"
            username="worklight"
            password="worklight"
            driverClassName="com.mysql.jdbc.Driver"
            url="jdbc:mysql://server:3306/APPCNTR"/>
```

### Configuring the Oracle database manually for Application Center
You configure the Oracle database manually by creating the database, creating the database tables, and then configuring the relevant application server to use this database setup.

1. Create the database. This step is described in [Creating the Oracle database for Application Center](#creating-the-oracle-database-for-application-center).
2. Create the tables in the database. This step is described in [Setting up your Oracle database manually for Application Center](#setting-up-your-oracle-database-manually-for-application-center).
3. Perform the application server-specific setup as the following list shows.

#### Jump to

* [Setting up your Oracle database manually for Application Center](#setting-up-your-oracle-database-manually-for-application-center)
* [Configuring Liberty profile for Oracle manually for Application Center](#configuring-liberty-profile-for-oracle-manually-for-application-center)
* [Configuring WebSphere Application Server for Oracle manually for Application Center](#configuring-websphere-application-server-for-oracle-manually-for-application-center)
* [Configuring Apache Tomcat for Oracle manually for Application Center](#configuring-apache-tomcat-for-oracle-manually-for-application-center)

#### Setting up your Oracle database manually for Application Center
Complete the following procedure to set up your Oracle database.

1. Ensure that you have at least one Oracle database.

    In many Oracle installations, the default database has the SID (name) ORCL. For best results, specify **Unicode (AL32UTF8)** as the character set of the database.

    If the Oracle installation is on a UNIX or Linux computer, make sure that the database is started next time the Oracle installation is restarted. To this effect, make sure that the line in /etc/oratab that corresponds to the database ends with a Y, not with an N.
    
2. Create the user APPCENTER, either by using Oracle Database Control, or by using the Oracle SQLPlus command-line interpreter.
    * To create the user for the Application Center database/schema, by using Oracle Database Control, proceed as follows:
        * Connect as **SYSDBA**.
        * Go to the Users page.
        * Click **Server**, then **Users** in the Security section.
        * Create a user, named **APPCENTER** with the following attributes:

        ```bash
        Profile: DEFAULT
        Authentication: password
        Default tablespace: USERS
        Temporary tablespace: TEMP
        Status: Unlocked
        Add system privilege: CREATE SESSION
        Add system privilege: CREATE SEQUENCE
        Add system privilege: CREATE TABLE
        Add quota: Unlimited for tablespace USERS
        ```
    *  To create the user by using Oracle SQLPlus, enter the following commands:

        ```bash
        CONNECT SYSTEM/<SYSTEM_password>@ORCL
        CREATE USER APPCENTER IDENTIFIED BY password DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;
        GRANT CREATE SESSION, CREATE SEQUENCE, CREATE TABLE TO APPCENTER;
        DISCONNECT;
        ```

3. Create the tables for the Application Center database:
    * Using the Oracle SQLPlus command-line interpreter, create the tables for the Application Center database by running the **create-appcenter-oracle.sql** file:

    ```bash
    CONNECT APPCENTER/APPCENTER_password@ORCL
    @product_install_dir/ApplicationCenter/databases/create-appcenter-oracle.sql
    DISCONNECT;
    ```

4. Download and configure the Oracle JDBC driver:
    * Download the JDBC driver from the Oracle website at [Oracle: JDBC, SQLJ, Oracle JPublisher and Universal Connection Pool (UCP)](http://www.oracle.com/technetwork/database/features/jdbc/index-091264.html).
    * Ensure that the Oracle JDBC driver is in the system path. The driver file is **ojdbc6.jar**.

#### Configuring Liberty profile for Oracle manually for Application Center
You can set up and configure your Oracle database manually for Application Center with WebSphere® Application Server Liberty profile by adding the JAR file of the Oracle JDBC driver. Before continuing, set up the Oracle database.

1. Add the JAR file of the Oracle JDBC driver to **$LIBERTY_HOME/wlp/usr/shared/resources/oracle**. If that directory does not exist, create it.
2. If you are using JNDI, configure the data sources in the **$LIBERTY_HOME/wlp/usr/servers/mobileFirstServer/server.xml** file as shown in the following JNDI code example:

    **Note:** In this path, you can replace mobileFirstServer with the name of your server.
    
    ```xml
    <!-- Declare the jar files for Oracle access through JDBC. -->
    <library id="OracleLib">
      <fileset dir="${shared.resource.dir}/oracle" includes="*.jar"/>
    </library>

    <!-- Declare the IBM Application Center database. -->
    <dataSource jndiName="jdbc/AppCenterDS" transactional="false">
      <jdbcDriver libraryRef="OracleLib"/>
      <properties.oracle driverType="thin"
                         serverName="oserver" portNumber="1521"
                         databaseName="ORCL"
                         user="APPCENTER" password="APPCENTER_password"/>
    </dataSource>
    ```
    
    where:
    * **APPCENTER** after **user=** is the user name,
    * **APPCENTER_password** after **password=** is this user's password, and
    * **oserver** is the host name of your Oracle server (for example, localhost if it is on the same machine).

    > **Note:** For more information on how to connect the Liberty server to the Oracle database with a service name, or with a URL, see the [WebSphere Application Server Liberty Core 8.5.5 documentation](http://www-01.ibm.com/support/knowledgecenter/SSD28V_8.5.5/com.ibm.websphere.wlp.core.doc/autodita/rwlp_metatype_core.html?cp=SSD28V_8.5.5%2F1-5-0), section **properties.oracle**.

3. You can encrypt the database password with the securityUtility program in **liberty\_install\_dir/bin**.


#### Configuring WebSphere Application Server for Oracle manually for Application Center
If you want to manually set up and configure your Oracle database for Application Center with WebSphere® Application Server, use the following procedure. Complete the Oracle database setup procedure before continuing.

1. Determine a suitable directory for the JDBC driver JAR file in the WebSphere Application Server installation directory.
    * For a standalone server, you can use a directory such as WAS_INSTALL_DIR/optionalLibraries/IBM/Worklight/oracle.
    * For deployment to a WebSphere Application Server ND cell, use **WAS\_INSTALL\_DIR/profiles/profile-name/config/cells/cell-name/Worklight/oracle**.
    * For deployment to a WebSphere Application Server ND cluster, use **WAS\_INSTALL\_DIR/profiles/profile-name/config/cells/cell-name/clusters/cluster-name/Worklight/oracle**.
    * For deployment to a WebSphere Application Server ND node, use **WAS\_INSTALL\_DIR/profiles/profile-name/config/cells/cell-name/nodes/node-name/Worklight/oracle**.
    * For deployment to a WebSphere Application Server ND server, use **WAS\_INSTALL\_DIR/profiles/profile-name/config/cells/cell-name/nodes/node-name/servers/server-name/Worklight/oracle**.

    If this is directory does not exist, create it.

2. Add the Oracle ﻿**ojdbc6.jar** file downloaded from [JDBC and Universal Connection Pool (UCP)](http://www.oracle.com/technetwork/database/features/jdbc/index-091264.html) to the directory determined in step 1.
3. Set up the JDBC provider:
    * In the WebSphere Application Server console, click **Resources → JDBC → JDBC Providers**.
    * Select the appropriate scope from the **Scope** combination box.
    * Click **New**.
    * Complete the **JDBC Provider** fields as indicated in the following table:

        | Field | Value |
        |-------|-------|
        | Databasetype | Oracle |
        | Provider type | Oracle JDBC Driver |
        | Implementation type | Connection pool data source |
        | Name | Oracle JDBC Driver |
    * Click **Next**.
    * Set the **class path** to the JAR file in the directory determined in step 1, replacing **WAS\_INSTALL\_DIR/profiles/profile-name** with the WebSphere Application Server variable reference **${USER_INSTALL_ROOT}**
    * Click **Next**.

    The JDBC provider is created.

4. Create a data source for the Worklight database:
    * Click **Resources → JDBC → Data sources**.
    * Select the appropriate scope from the **Scope** combination box.
    * Click **New**.
    * Set **Data source name** to **Oracle JDBC Driver DataSource**.
    * Set **JNDI name** to **jdbc/AppCenterDS**.
    * Click **Next**.
    * Click **Select an existing JDBC provider** and select **Oracle JDBC driver** from the list.
    * Click **Next**.
    * Set the **URL** value to **jdbc:oracle:thin:@oserver:1521:ORCL**, where **oserver** is the host name of your Oracle server (for example, **localhost**, if it is on the same machine).
    * Click **Next** twice.
    * Click **Resources → JDBC → Data sources → Oracle JDBC Driver DataSource → Custom properties**.
    * Set **oracleLogPackageName** to **oracle.jdbc.driver**.
    * Set **user = APPCENTER**.
    * Set **password = APPCENTER_password**.
    * Click **OK** and save the changes.
    * In **Resources → JDBC → Data sources**, select the new data source.
    * Click **WebSphere Application Server data source properties**.
    * Select the **Non-transactional data source** check box.
    * Click **OK**.
    * Click **Save**.

#### Configuring Apache Tomcat for Oracle manually for Application Center
If you want to manually set up and configure your Oracle database for Application Center with the Apache Tomcat server, use the following procedure. Complete the Oracle database setup procedure before continuing.

1. Add the Oracle JDBC driver JAR file to the directory **$TOMCAT_HOME/lib**.
2. Prepare an XML statement that defines the data source, as shown in the following code example. Insert this statement in the server.xml file, as indicated in [Configuring Apache Tomcat for Application Center manually](#configuring-apache-tomcat-for-application-center-manually)
  
```xml
<Resource name="jdbc/AppCenterDS"
        auth="Container"
        type="javax.sql.DataSource"
        driverClassName="oracle.jdbc.driver.OracleDriver"
        url="jdbc:oracle:thin:@oserver:1521:ORCL"
        username="APPCENTER"
        password="APPCENTER_password"/>
```

Where **APPCENTER** after **username=** is the name of the system user with "CONNECT" access to the **APPCNTR** database that you have previously created, and **APPCENTER_password** after password= is this user's password. If you have defined either a different user name, or a different password, or both, replace these values accordingly.

### Deploying the Application Center WAR files and configuring the application server manually
The procedure to manually deploy the Application Center WAR files manually to an application server depends on the type of application server being configured.  
These manual instructions assume that you are familiar with your application server.

> **Note:** Using the MobileFirst Server installer to install Application Center is more reliable than installing manually, and should be used whenever possible.

If you prefer to use the manual process, follow these steps to configure your application server for Application Center. You must deploy the appcenterconsole.war and applicationcenter.war files to your Application Center. The files are located in **product\_install\_dir/ApplicationCenter/console**.

#### Jump to

* [Configuring the Liberty profile for Application Center manually](#configuring-the-liberty-profile-for-application-center-manually)
* [Configuring WebSphere Application Server for Application Center manually](#configuring-websphere-application-server-for-application-center-manually)
* [Configuring Apache Tomcat for Application Center manually](#configuring-apache-tomcat-for-application-center-manually)

#### Configuring the Liberty profile for Application Center manually
To configure WebSphere® Application Server Liberty profile manually for Application Center, you must modify the **server.xml** file.  
In addition to modifications for the databases that are described in [Manually installing Application Center](#manually-installing-application-center), you must make the following modifications to the **server.xml** file.

1. Ensure that the `<featureManager>` element contains at least the following `<feature>` elements:

    ```xml
    <feature>jdbc-4.0</feature>
    <feature>appSecurity-2.0</feature>
    <feature>servlet-3.0</feature>
    <feature>usr:MFPDecoderFeature-1.0</feature>
    ```

2. Add the following declarations for Application Center:

    ```xml
    <!-- The directory with binaries of the 'aapt' program, from the Android SDK's
         platform-tools package. -->
    <jndiEntry jndiName="android.aapt.dir" value="product_install_dir/ApplicationCenter/tools/android-sdk"/>
    <!-- Declare the Application Center Console application. -->
    <application id="appcenterconsole"
                 name="appcenterconsole"
                 location="appcenterconsole.war"
                 type="war">
      <application-bnd>
        <security-role name="appcenteradmin">
          <group name="appcentergroup"/>
        </security-role>
      </application-bnd>
      <classloader delegation="parentLast">
      </classloader>
    </application>

    <!-- Declare the IBM Application Center Services application. -->
    <application id="applicationcenter" 
                 name="applicationcenter"
                 location="applicationcenter.war" 
                 type="war"> 
      <application-bnd>
        <security-role name="appcenteradmin">
          <group name="appcentergroup"/>
        </security-role>
      </application-bnd>
      <classloader delegation="parentLast">           
      </classloader>
    </application>

    <!-- Declare the user registry for the IBM Application Center. -->
    <basicRegistry id="applicationcenter-registry"
                   realm="ApplicationCenter">
      <!-- The users defined here are members of group "appcentergroup",
           thus have role "appcenteradmin", and can therefore perform
           administrative tasks through the Application Center Console. -->
      <user name="appcenteradmin" password="admin"/>
      <user name="demo" password="demo"/>
      <group name="appcentergroup">
        <member name="appcenteradmin"/>
        <member name="demo"/>
      </group>
    </basicRegistry>
    ```
    
    The groups and users that are defined in the `basicRegistry` are example logins that you can use to test Application Center. Similarly, the groups that are defined in the `<security-role name="appcenteradmin">` for the Application Center console and the Application Center service are examples. For more information about how to modify these groups, see [Configuring the Java EE security roles on WebSphere Application Server Liberty profile]().
    
3. If the database is Oracle, add the **commonLibraryRef** attribute to the class loader of the Application Center service application.

    ```xml
    ...
    <classloader delegation="parentLast"  commonLibraryRef="OracleLib">
    ...
    ```
    
    The name of the library reference (`OracleLib` in this example) must be the ID of the library that contains the JDBC JAR file. This ID is declared in the procedure that is documented in [Configuring Liberty profile for Oracle manually for Application Center](#configuring-liberty-profile-for-oracle-manually-for-application-center).

4. Copy the Application Center WAR files to your Liberty server.
    * On UNIX and Linux systems:
    
        ```bash
        mkdir -p LIBERTY_HOME/wlp/usr/servers/server_name/apps
        cp product_install_dir/ApplicationCenter/console/*.war LIBERTY_HOME/wlp/usr/servers/server_name/apps/
        ```
    * On Windows systems:

        ```bash
        mmkdir LIBERTY_HOME\wlp\usr\servers\server_name\apps
        copy /B product_install_dir\ApplicationCenter\console\appcenterconsole.war 
        LIBERTY_HOME\wlp\usr\servers\server_name\apps\appcenterconsole.war
        copy /B product_install_dir\ApplicationCenter\console\applicationcenter.war 
        LIBERTY_HOME\wlp\usr\servers\server_name\apps\applicationcenter.war
        ```
        
5. Copy the password decoder user feature.
    * On UNIX and Linux systems:

        ```bash
        mkdir -p LIBERTY_HOME/wlp/usr/extension/lib/features
        cp product_install_dir/features/com.ibm.websphere.crypto_1.0.0.jar LIBERTY_HOME/wlp/usr/extension/lib/
        cp product_install_dir/features/MFPDecoderFeature-1.0.mf LIBERTY_HOME/wlp/usr/extension/lib/features/
        ```
    * On Windows systems:

        ```bash
        mkdir LIBERTY_HOME\wlp\usr\extension\lib
        copy /B product_install_dir\features\com.ibm.websphere.crypto_1.0.0.jar  
        LIBERTY_HOME\wlp\usr\extension\lib\com.ibm.websphere.crypto_1.0.0.jar
        mkdir LIBERTY_HOME\wlp\usr\extension\lib\features
        copy /B product_install_dir\features\MFPDecoderFeature-1.0.mf  
        LIBERTY_HOME\wlp\usr\extension\lib\features\MFPDecoderFeature-1.0.mf
        ```

6. Start the Liberty server.

#### Configuring WebSphere Application Server for Application Center manually
To configure WebSphere® Application Server for Application Center manually, you must configure variables, custom properties, and class loading policies. Make sure that a WebSphere Application Server profile exists.

1. Log on to the WebSphere Application Server administration console for your IBM MobileFirst  Server.
2. Enable application security.
    * Click **Security → Global Security**.
    * Ensure that **Enable administrative security** is selected. Application security can be enabled only if administrative security is enabled.
    * Ensure that **Enable application security** is selected.
    * Click **OK**.
    * Save the changes.

    For more information, see [Enabling security](http://ibm.biz/knowctr#SSEQTP_7.0.0/com.ibm.websphere.base.doc/info/aes/ae/tsec_csec2.html).

3. Create the Application Center JDBC data source and provider. See the appropriate section in [Manually installing Application Center](#manually-installing-application-center).
4. Install the Application Center console WAR file.
    * Depending on your version of WebSphere Application Server, click one of the following options:
        * **Applications → New → New Enterprise Application**
        * **Applications → New Application → New Enterprise Application**
    * Navigate to the MobileFirst Server installation directory **mfserver\_install\_dir/ApplicationCenter/console**.
    * Select **appcenterconsole.war** and click **Next**.
    * On the **How do you want to install the application?** page, click **Detailed**, and then click **Next**.
    * On the **Application Security Warnings** page, click **Continue**.
    * Click **Next** until you reach the "Map context roots for web modules" page.
    * In the **Context Root** field, type **/appcenterconsole**.
    * Click **Next** until you reach the "Map security roles to users or groups" page.
    * Select all roles, click **Map Special Subjects** and select **All Authenticated in Application's Realm**.
    * Click **Next** until you reach the Summary page.
    * Click **Finish** and save the configuration.

5. Configure the class loader policies and then start the application:
    * Click **Applications → Application types → WebSphere Enterprise Applications**.
    * From the list of applications, click **appcenterconsole\_war**.
    * In the **Detail Properties** section, click the **Class loading and update detection** link.
    * In the **Class loader order** pane, click **Classes loaded with local class loader first (parent last)**.
    * Click **OK**.
    * In the **Modules section**, click **Manage Modules**.
    * From the list of modules, click **ApplicationCenterConsole**.
    * In the **Class loader order** pane, click **Classes loaded with local class loader first (parent last)**.
    * Click **OK** twice.
    * Click **Save**.
    * Select **appcenterconsole_war** and click (Start).

6. Install the WAR file for Application Center services.
    * Depending on your version of WebSphere Application Server, click one of the following options:
        * **Applications → New → New Enterprise Application**
        * **Applications → New Application → New Enterprise Application**
    * Navigate to the MobileFirst Server installation directory **mfserver\_install\_dir/ApplicationCenter/console**.
    * Select **applicationcenter.war** and click **Next**.
    * On the **How do you want to install the application?** page, click **Detailed**, and then click **Next**.
    * On the **Application Security Warnings** page, click **Continue**.
    * Click **Next** until you reach the "Map resource references to resources" page.
    * Click **Browser** and select the data source with the **jdbc/AppCenterDS** JNDI name.
    * Click **Apply**.
    * In the **Context Root** field, type **/applicationcenter**.
    * Click **Next** until you reach the "Map security roles to users or groups" page.
    * Select **all roles**, click **Map Special Subjects**, and select **All Authenticated in Application's Realm**.
    * Click **Next** until you reach the **Summary** page.
    * Click **Finish** and save the configuration.

7. Repeat step 5.
    * Select **applicationcenter.war** from the list of applications in substeps b and k.
    * Select **ApplicationCenterServices** in substep g.

8. Review the server class loader policy: Depending on your version of WebSphere Application Server, click **Servers → Server Types → Application Servers or Servers → Server Types → WebSphere application servers** and then select the server.
    * If the class loader policy is set to **Multiple**, do nothing.
    * If the class loader policy is set to **Single** and **Class loading mode** is set to **Classes loaded with local class loader first (parent last)**, do nothing.
    * If **Classloader policy** is set to **Single** and **Class loading mode** is set to **Classes loaded with parent class loader first**, set **Classloader policy** to **Multiple** and set the **classloader policy** of all applications other than MobileFirst applications to **Classes loaded with parent class loader first**.

9. Save the configuration.

10. Configure a JNDI environment entry to indicate the directory with binary files of the aapt program, from the Android SDK platform-tools package.
    * Determine a suitable directory for the aapt binary files in the WebSphere Application Server installation directory.
        * For a stand-alone server, you can use a directory such as **WAS\_INSTALL\_DIR/optionalLibraries/IBM/mobilefirst/android-sdk**.
        * For deployment to a WebSphere Application Server Network Deployment cell, use **WAS\_INSTALL\_DIR/profiles/profile-name/config/cells/cell-name/mobilefirst/android-sdk**.
        * For deployment to a WebSphere Application Server Network Deployment cluster, use **WAS\_INSTALL\_DIR/profiles/profile-name/config/cells/cell-name/clusters/cluster-name/mobilefirst/android-sdk**.
        * For deployment to a WebSphere Application Server Network Deployment node, use **WAS\_INSTALL\_DIR/profiles/profile-name/config/cells/cell-name/nodes/node-name/mobilefirst/android-sdk**.
        * For deployment to a WebSphere Application Server Network Deployment server, use **WAS\_INSTALL\_DIR/profiles/profile-name/config/cells/cell-name/nodes/node-name/servers/server-name/mobilefirst/android-sdk**.
    * Copy the **product\_install\_dir/ApplicationCenter/tools/android-sdk** directory to the directory that you determined in Substep a.
    * For WebSphere Application Server Network Deployment, click **System administration → Nodes**, select the nodes, and click **Full Synchronize**.
    * Configure the environment entry (JNDI property) android.aapt.dir, and set as its value the directory that you determined in Substep a. The **WAS\_INSTALL\_DIR/profiles/profile-name** profile is replaced with the WebSphere Application Server variable reference **${USER\_INSTALL\_ROOT}**.

You can now access the Application Center at `http://<server>:<port>/appcenterconsole`, where server is the host name of your server and port is the port number (by default 9080).

#### Configuring Apache Tomcat for Application Center manually
To configure Apache Tomcat for Application Center manually, you must copy JAR and WAR files to Tomcat, add database drivers, edit the **server.xml** file, and then start Tomcat.

1. Add the database drivers to the Tomcat lib directory. See the instructions for the appropriate DBMS in [Manually installing Application Center](#manually-installing-application-center).
2. Edit **tomcat\_install\_dir/conf/server.xml**.
    * Uncomment the following element, which is initially commented out: `<Valve className="org.apache.catalina.authenticator.SingleSignOn" />`.
    * Declare the Application Center console and services applications and a user registry: 

        ```xml
        <!-- Declare the IBM Application Center Console application. -->
        <Context path="/appcenterconsole" docBase="appcenterconsole">

          <!-- Define the AppCenter services endpoint in order for the AppCenter
               console to be able to invoke the REST service.
               You need to enable this property if the server is behind a reverse
               proxy or if the context root of the Application Center Services
               application is different from '/applicationcenter'. -->
          <!-- <Environment name="ibm.appcenter.services.endpoint"
                            value="http://proxy-host:proxy-port/applicationcenter"
                            type="java.lang.String" override="false"/>
          -->

        </Context>

        <!-- Declare the IBM Application Center Services application. -->
        <Context path="/applicationcenter" docBase="applicationcenter">
          <!-- The directory with binaries of the 'aapt' program, from
               the Android SDK's platform-tools package. -->
          <Environment name="android.aapt.dir"
                       value="product_install_dir/ApplicationCenter/tools/android-sdk"
                       type="java.lang.String" override="false"/>
          <!-- The protocol of the application resources URI.
               This property is optional. It is only needed if the protocol
               of the external and internal URI are different. -->
          <!-- <Environment name="ibm.appcenter.proxy.protocol"
                            value="http" type="java.lang.String" override="false"/>
          -->

          <!-- The host name of the application resources URI. -->
          <!-- <Environment name="ibm.appcenter.proxy.host"
                            value="proxy-host"
                            type="java.lang.String" override="false"/>
          -->

          <!-- The port of the application resources URI.
               This property is optional. -->
          <!-- <Environment name="ibm.appcenter.proxy.port"
                            value="proxy-port"
                            type="java.lang.Integer" override="false"/> -->

          <!-- Declare the IBM Application Center Services database. -->
          <!-- <Resource name="jdbc/AppCenterDS" type="javax.sql.DataSource" ... -->

        </Context>

        <!-- Declare the user registry for the IBM Application Center.
             The MemoryRealm recognizes the users defined in conf/tomcat-users.xml.
             For other choices, see Apache Tomcat's "Realm Configuration HOW-TO"
             http://tomcat.apache.org/tomcat-7.0-doc/realm-howto.html . -->
        <Realm className="org.apache.catalina.realm.MemoryRealm"/>
        ```
    where you fill in the `<Resource>` element as described in one of the sections:
        * [Configuring Apache Tomcat for DB2 manually for Application Center](#configuring-apache-tomcat-for-db2-manually-for-application-center)
        * [Configuring Apache Tomcat for Derby manually for Application Center](#configuring-apache-tomcat-for-derby-manually-for-application-center)
        * [Configuring Apache Tomcat for MySQL manually for Application Center](#configuring-apache-tomcat-for-mysql-manually-for-application-center)
        * [Configuring Apache Tomcat for Oracle manually for Application Center](#configuring-apache-tomcat-for-oracle-manually-for-application-center)
3. Copy the Application Center WAR files to Tomcat.
    * On UNIX and Linux systems:

        ```bash
        cp product_install_dir/ApplicationCenter/console/*.war TOMCAT_HOME/webapps/
        ```
    * On Windows systems:

        ```bash
        copy /B product_install_dir\ApplicationCenter\console\appcenterconsole.war tomcat_install_dir\webapps\appcenterconsole.war
        copy /B product_install_dir\ApplicationCenter\console\applicationcenter.war tomcat_install_dir\webapps\applicationcenter.war
        ```
4. Start Tomcat.

### Deploying the Application Center EAR file and configuring the application server manually
As an alternative to the MobileFirst Server installer procedure, you can use a manual procedure to deploy the Application Center EAR file and configure your WebSphere® application server manually. These manual instructions assume that you are familiar with your application server.

The procedure to deploy the Application Center EAR file manually to an application server depends on the type of application server. Manual deployment is supported only for WebSphere Application Server Liberty profile and WebSphere Application Server.

> **Tip:** It is more reliable to install Application Center through the MobileFirst Server installer than manually. Therefore, whenever possible, use the MobileFirst Server installer. If, however, you prefer the manual procedure, deploy the **appcentercenter.ear** file, which you can find in the **product\_install\_dir/ApplicationCenter/console** directory.

#### Configuring the Liberty profile for Application Center manually
After you deploy the Application Center EAR file, to configure WebSphere® Application Server Liberty profile manually for Application Center, you must modify the server.xml file.

In addition to modifications for the databases that are described in [Manually installing Application Center](#manually-installing-application-center), you must make the following modifications to the **server.xml** file.

1. Ensure that the `<featureManager>` element contains at least the following `<feature>` elements:
    
    ```xml
    <feature>jdbc-4.0</feature>
    <feature>appSecurity-2.0</feature>
    <feature>servlet-3.0</feature>
    <feature>usr:MFPDecoderFeature-1.0</feature>
    ```

2. Add the following declarations for Application Center:

    ```xml
    <!-- The directory with binaries of the 'aapt' program, from the Android SDK's platform-tools package. -->
    <jndiEntry jndiName="android.aapt.dir" value="product_install_dir/ApplicationCenter/tools/android-sdk"/>

    <!-- Declare the IBM Application Center application. -->
    <application id="applicationcenter" 
                 name="applicationcenter"
                 location="applicationcenter.ear" 
                 type="ear"> 
      <application-bnd>
        <security-role name="appcenteradmin">
          <group name="appcentergroup"/>
        </security-role>
      </application-bnd>
      <classloader delegation="parentLast">           
      </classloader>
    </application>

    <!-- Declare the user registry for the IBM Application Center. -->
    <basicRegistry id="applicationcenter-registry"
                   realm="ApplicationCenter">
      <!-- The users defined here are members of group "appcentergroup",
           thus have role "appcenteradmin", and can therefore perform
           administrative tasks through the Application Center Console. -->
      <user name="appcenteradmin" password="admin"/>
      <user name="demo" password="demo"/>
      <group name="appcentergroup">
        <member name="appcenteradmin"/>
        <member name="demo"/>
      </group>
    </basicRegistry>
    ```

    The groups and users that are defined in the **basicRegistry** element are example logins, which you can use to test Application Center. Similarly, the groups that are defined in the `<security-role name="appcenteradmin">` element are examples. For more information about how to modify these groups, see [Configuring the Java EE security roles on WebSphere Application Server Liberty profile]().

3. If the database is Oracle, add the **commonLibraryRef** attribute to the class loader of the Application Center application.

    ```xml
    ...
    <classloader delegation="parentLast"  commonLibraryRef="OracleLib">
    ...
    ```
    
    The name of the library reference (**OracleLib** in this example) must be the ID of the library that contains the JDBC JAR file. This ID is declared in the procedure that is documented in [Configuring Liberty profile for Oracle manually for Application Center](#configuring-liberty-profile-for-oracle-manually-for-application-center).

4. Copy the Application Center EAR files to your Liberty server.
    * On UNIX and Linux systems:

        ```bash
        mkdir -p LIBERTY_HOME/wlp/usr/servers/server_name/apps
        cp product_install_dir/ApplicationCenter/console/*.ear LIBERTY_HOME/wlp/usr/servers/server_name/apps/
        ```
    * On Windows systems:

        ```bash
        mkdir LIBERTY_HOME\wlp\usr\servers\server_name\apps
        copy /B product_install_dir\ApplicationCenter\console\applicationcenter.ear 
        LIBERTY_HOME\wlp\usr\servers\server_name\apps\applicationcenter.ear
        ```
        
5. Copy the password decoder user feature.
    * On UNIX and Linux systems:

        ```bash
        mkdir -p LIBERTY_HOME/wlp/usr/extension/lib/features
        cp product_install_dir/features/com.ibm.websphere.crypto_1.0.0.jar LIBERTY_HOME/wlp/usr/extension/lib/
        cp product_install_dir/features/MFPDecoderFeature-1.0.mf LIBERTY_HOME/wlp/usr/extension/lib/features/
        ```
    * On Windows systems:

        ```bash
        mkdir LIBERTY_HOME\wlp\usr\extension\lib
        copy /B product_install_dir\features\com.ibm.websphere.crypto_1.0.0.jar  
        LIBERTY_HOME\wlp\usr\extension\lib\com.ibm.websphere.crypto_1.0.0.jar
        mkdir LIBERTY_HOME\wlp\usr\extension\lib\features
        copy /B product_install_dir\features\MFPDecoderFeature-1.0.mf  
        LIBERTY_HOME\wlp\usr\extension\lib\features\MFPDecoderFeature-1.0.mf
        ```
        
6. Start the Liberty server.

#### Configuring WebSphere Application Server for Application Center manually
After you deploy the Application Center EAR file, to configure WebSphere® Application Server profile manually for Application Center, you must configure variables, custom properties, and class loader policies. Make sure that a WebSphere Application Server profile exists.

1. Log on to the WebSphere Application Server administration console for your IBM MobileFirst  Server.
2. Enable application security.
    * Click **Security → Global Security**.
    * Ensure that **Enable administrative security** is selected. Application security can be enabled only if administrative security is enabled.
    * Ensure that **Enable application security** is selected.
    * Click **OK**.
    * Save the changes.

    For more information, see [Enabling security](http://ibm.biz/knowctr#SSEQTP_7.0.0/com.ibm.websphere.base.doc/info/aes/ae/tsec_csec2.html).

3. Create the Application Center JDBC data source and provider. See the appropriate section in [Manually installing Application Center](#manually-installing-application-center).
4. Install the Application Center console WAR file.
    * Depending on your version of WebSphere Application Server, click one of the following options:
        * **Applications → New → New Enterprise Application**
        * **Applications → New Application → New Enterprise Application**
    * Navigate to the MobileFirst Server installation directory **mfserver\_install\_dir/ApplicationCenter/console**.
    * Select **appcenterconsole.war** and click **Next**.
    * On the **How do you want to install the application?** page, click **Detailed**, and then click **Next**.
    * On the **Application Security Warnings** page, click **Continue**.
    * Click **Next** until you reach the "Map context roots for web modules" page.
    * In the **Context Root** field, type **/appcenterconsole**.
    * Click **Next** until you reach the "Map security roles to users or groups" page.
    * Select all roles, click **Map Special Subjects** and select **All Authenticated in Application's Realm**.
    * Click **Next** until you reach the Summary page.
    * Click **Finish** and save the configuration.

5. Configure the class loader policies and then start the application:
    * Click **Applications → Application types → WebSphere Enterprise Applications**.
    * From the list of applications, click **AppCenterEAR**.
    * In the **Detail Properties** section, click the **Class loading and update detection** link.
    * In the **Class loader order** pane, click **Classes loaded with local class loader first (parent last)**.
    * Click **OK**.
    * In the **Modules section**, click **Manage Modules**.
    * From the list of modules, click **ApplicationCenterConsole**.
    * In the **Class loader order** pane, click **Classes loaded with local class loader first (parent last)**.
    * Click **OK**.
    * From the list of modules, click **ApplicationCenterServices**.
    * In the **Class loader order** pane, click **Classes loaded with local class loader first (parent last)**.
    * Click **OK** twice.
    * Click **Save**.
    * Select **appcenterconsoleEAR** and click **Start**.
6. Review the server class loader policy:

    Depending on your version of WebSphere Application Server, click **Servers → Server Types → Application Servers or Servers → Server Types → WebSphere application servers** and then select the server.
        * If the class loader policy is set to **Multiple**, do nothing.
        * If the class loader policy is set to **Single** and **Class loading mode** is set to **Classes loaded with local class loader first (parent last)**, do nothing.
        * If **Classloader policy** is set to **Single** and **Class loading mode** is set to **Classes loaded with parent class loader first**, set **Classloader policy** to **Multiple** and set the **classloader policy** of all applications other than MobileFirst applications to **Classes loaded with parent class loader first**.

7. Save the configuration.
8. Configure a JNDI environment entry to indicate the directory with binary files of the **aapt** program, from the Android SDK **platform-tools** package.
    * Determine a suitable directory for the aapt binary files in the WebSphere Application Server installation directory.
        * For a stand-alone server, you can use a directory such as **WAS\_INSTALL\_DIR/optionalLibraries/IBM/mobilefirst/android-sdk**.
        * For deployment to a WebSphere Application Server Network Deployment cell, use **WAS\_INSTALL\_DIR/profiles/profile-name/config/cells/cell-name/mobilefirst/android-sdk**.
        * For deployment to a WebSphere Application Server Network Deployment cluster, use **WAS\_INSTALL\_DIR/profiles/profile-name/config/cells/cell-name/clusters/cluster-name/mobilefirst/android-sdk**.
        * For deployment to a WebSphere Application Server Network Deployment node, use **WAS\_INSTALL\_DIR/profiles/profile-name/config/cells/cell-name/nodes/node-name/mobilefirst/android-sdk**.
        * For deployment to a WebSphere Application Server Network Deployment server, use **WAS\_INSTALL\_DIR/profiles/profile-name/config/cells/cell-name/nodes/node-name/servers/server-name/mobilefirst/android-sdk**.
    * Copy the **product\_install\_dir/ApplicationCenter/tools/android-sdk** directory to the directory that you determined in Substep a.
    * For WebSphere Application Server Network Deployment, click **System administration → Nodes**, select the nodes, and click **Full Synchronize**.
    * Configure the environment entry (JNDI property) **android.aapt.dir** and set as its value the directory that you determined in Substep a. The **WAS\_INSTALL\_DIR/profiles/profile-name** profile is replaced with the WebSphere Application Server variable reference **${USER_INSTALL_ROOT}**.

    You can now access the Application Center at http://<server>:<port>/appcenterconsole, where server is the host name of your server and port is the port number (by default 9080).

## Configuring Application Center after installation
