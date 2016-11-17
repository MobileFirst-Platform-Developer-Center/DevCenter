---
layout: tutorial
title: Setting Up Databases
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
The following MobileFirst Server components need to store technical data into a database:

* MobileFirst Server administration service
* MobileFirst Server live update service
* MobileFirst Server push service
* MobileFirst runtime

> **Note:** If multiple runtime instances are installed with different context root, each instance needs its own set of tables.
> The database can be a relational database such as IBM  DB2 , Oracle, or MySQL.

#### Relational databases (DB2, Oracle, or MySQL)
Each component needs a set of tables. The tables can be created manually by running the SQL scripts specific to each component (see [Create the database tables manually](#create-the-database-tables-manually)), by using Ant Tasks, or the Server Configuration Tool. The table names of each component do not overlap. Thus, it is possible to put all the tables of these components under a single schema.

However, if you decide to install multiple instances of MobileFirst runtime, each with its own context root in the application server, every instance needs its own set of tables. In this case, they need to be in different schemas.

> **Note about DB2:** MobileFirst Foundation licensees are entitled to use DB2 as a supporting system for Foundation. To benefit from this you must, after installing the DB2 software:
> 
> * Download the restricted use activation image directly from the [IBM Passport Advantage (PPA) website](https://www-01.ibm.com/software/passportadvantage/pao_customer.html)
> * Apply the restricted use activation license file **db2xxxx.lic** using the **db2licm** command
>
> Learn more in the [DB2 IBM Knowledge Center](http://www.ibm.com/support/knowledgecenter/SSEPGG_10.5.0/com.ibm.db2.luw.kc.doc/welcome.html)

#### Jump to

* [Database users and privileges](#database-users-and-privileges)
* [Database requirements](#database-requirements)
* [Create the database tables manually](#create-the-database-tables-manually)
* [Create the database tables with the Server Configuration Tool](#create-the-database-tables-with-the-server-configuration-tool)
* [Create the database tables with Ant tasks](#create-the-database-tables-with-ant-tasks)

## Database users and privileges
At run time, the MobileFirst Server applications in the application server use data sources as resources to obtain connection to relational databases. The data source needs a user with certain privileges to access the database.

You need to configure a data source for each MobileFirst Server application that is deployed to the application server to have the access to the relational database. The data source requires a user with specific privileges to access the database. The number of users that you need to create depends on the installation procedure that is used to deploy MobileFirst Server applications to the application server.

### Installation with the Server Configuration Tool
The same user is used for all components (MobileFirst Server administration service, MobileFirst Server configuration service, MobileFirst Server push service, and MobileFirst runtime)

### Installation with Ant tasks
The sample Ant files that are provided in the product distribution use the same user for all components. However, it is possible to modify the Ant files to have different users:

* The same user for the administration service and the configuration service as they cannot be installed separately with Ant tasks.
* A different user for the runtime
* A different user for the push service.

### Manual installation
It is possible to assign a different data source, and thus a different user, to each of the MobileFirst Server components.
At run time, the users must have the following privileges on the tables and sequences of their data:

* SELECT TABLE
* INSERT TABLE
* UPDATE TABLE
* DELETE TABLE
* SELECT SEQUENCE

If the tables are not created manually before you run the installation with Ant Tasks or the Server Configuration Tool, ensure that you have a user that is able to create the tables. It also needs the following privileges:

* CREATE INDEX
* CREATE SEQUENCE
* CREATE TABLE

For an upgrade of the product, it needs these additional privileges:

* ALTER TABLE
* CREATE VIEW
* DROP INDEX
* DROP SEQUENCE
* DROP TABLE
* DROP VIEW

## Database requirements
The database stores all the data of the MobileFirst Server applications. Before you install the MobileFirst Server components, ensure that the database requirements are met.

* [DB2 database and user requirements](#db2-database-and-user-requirements)
* [Oracle database and user requirements](#oracle-database-and-user-requirements)
* [MySQL database and user requirements](#mysql-database-and-user-requirements)

### DB2 database and user requirements
Review the database requirement for DB2. Follow the steps to create user, database, and setup your database to meet the specific requirement.

Ensure that you set the database character set as UTF-8.

The page size of the database must be at least 32768. The following procedure creates a database with a page size 32768. It also creates a user (**mfpuser**) and then grants the database access to this user. This user can then be used by the Server Configuration Tool or the Ant tasks to create the tables.

1. Create a system user named, for example, **mfpuser** in a DB2 admin group such as **DB2USERS**, by using the appropriate commands for your operating system. Give it a password, for example, **mfpuser**.
2. Open a DB2 command line processor, with a user that has **SYSADM** or **SYSCTRL** permissions.
    * On Windows systems, click **Start → IBM DB2 → Command Line Processor**.
    * On Linux or UNIX systems, go to **~/sqllib/bin** and enter `./db2`.
3. To create the MobileFirst Server database, enter the SQL statements similar to the following example.

Replace the user name **mfpuser** with your own.

```sql
CREATE DATABASE MFPDATA COLLATE USING SYSTEM PAGESIZE 32768
CONNECT TO MFPDATA
GRANT CONNECT ON DATABASE TO USER mfpuser
DISCONNECT MFPDATA
QUIT
```

### Oracle database and user requirements
Review the database requirement for Oracle. Follow the steps to create user, database, and setup your database to meet the specific requirement.

Ensure that you set the database character set as Unicode character set (AL32UTF8) and the national character set as UTF8 - Unicode 3.0 UTF-8.  

The runtime user (as discussed is [Database users and privileges](#database-users-and-privileges)) must have an associated table space and enough quota to write the technical data required by the MobileFirst services. For more information about the tables that are used by the product, see [Internal runtime databases](../installation-reference/#internal-runtime-databases).

The tables are expected to be created in the default schema of the runtime user. The Ant tasks and the Server Configuration Tool create the tables in the default schema of the user passed as argument. For more information about the creation of tables, see [Creating the Oracle database tables manually](#creating-the-oracle-database-tables-manually).

The procedure creates a database if needed. A user that can create tables and index in this database is added and used as a runtime user.

1. If you do not already have a database, use the Oracle Database Configuration Assistant (DBCA) and follow the steps in the wizard to create a new general-purpose database, named ORCL in this example:
    * Use global database name **ORCL\_your\_domain**, and system identifier (SID) **ORCL**.
    * On the **Custom Scripts** tab of the step **Database Content**, do not run the SQL scripts because you must first create a user account.
    * On the **Character Sets** tab of the step **Initialization Parameters**, select **Use Unicode (AL32UTF8) character set and UTF8 - Unicode 3.0 UTF-8 national character set**.
    * Complete the procedure, accepting the default values.
2. Create a database user by using either Oracle Database Control or the Oracle SQLPlus command line interpreter.
3. Using Oracle Database Control:
    * Connect as **SYSDBA**.
    * Go to the **Users** page and click **Server**, then **Users** in the **Security** section.
    * Create a user, for example **MFPUSER**.
    * Assign the following attributes:
        * **Profile**: DEFAULT
        * **Authentication**: password
        * **Default tablespace**: USERS
        * **Temporary tablespace**: TEMP
        * **Status**: Unlocked
        * Add system privilege: CREATE SESSION
        * Add system privilege: CREATE SEQUENCE
        * Add system privilege: CREATE TABLE
        * Add quota: Unlimited for tablespace USERS
    * Using the Oracle SQLPlus command line interpreter:

The commands in the following example create a user named **MFPUSER** for the database:

```sql
CONNECT SYSTEM/<SYSTEM_password>@ORCL
CREATE USER MFPUSER IDENTIFIED BY MFPUSER_password DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;
GRANT CREATE SESSION, CREATE SEQUENCE, CREATE TABLE TO MFPUSER;
DISCONNECT;
```

### MySQL database and user requirements
Review the database requirement for MySQL. Follow the steps to create user, database, and configure your database to meet the specific requirement.

Make sure that you set the character set to UTF8.

The following properties must be assigned with appropriate values:

* max_allowed_packet with 256 M or more
* innodb_log_file_size with 250 M or more

For more information about how to set the properties, see the [MySQL documentation](http://dev.mysql.com/doc/).  
The procedure creates a database (MFPDATA) and a user (mfpuser) that can connect to the database with all privileges from a host (mfp-host).

1. Run a MySQL command line client with the option `-u root`.
2. Enter the following commands:

   ```sql
   CREATE DATABASE MFPDATA CHARACTER SET utf8 COLLATE utf8_general_ci;
   GRANT ALL PRIVILEGES ON MFPDATA.* TO 'mfpuser'@'mfp-host' IDENTIFIED BY 'mfpuser-password';
   GRANT ALL PRIVILEGES ON MFPDATA.* TO 'mfpuser'@'localhost' IDENTIFIED BY 'mfpuser-password';
   FLUSH PRIVILEGES;
   ```

    Where mfpuser before the "at" sign (@) is the user name, **mfpuser-password** after **IDENTIFIED BY** is its password, and **mfp-host** is the name of the host on which IBM MobileFirst Foundation runs.
    
    The user must be able to connect to the MySQL server from the hosts that run the Java application server with the MobileFirst Server applications installed.
    
## Create the database tables manually
The database tables for the MobileFirst Server applications can be created manually, with Ant Tasks, or with the Server Configuration Tool. The topics provide the explanation and details on how to create them manually.

* [Creating the DB2 database tables manually](#creating-the-db2-database-tables-manually)
* [Creating the Oracle database tables manually](#creating-the-oracle-database-tables-manually)
* [Creating the MySQL database tables manually](#creating-the-mysql-database-tables-manually)

### Creating the DB2 database tables manually
Use the SQL scripts that are provided in the MobileFirst Server installation to create the DB2  database tables.

As described in the Overview section, all the four MobileFirst Server components need tables. They can be created in the same schema or in different schemas. However, some constraints apply depending on how the MobileFirst Server applications are deployed to the Java application server. They are the similar to the topic about the possible users for DB2 as described in [Database users and privileges](#database-users-and-privileges).

#### Installation with the Server Configuration Tool
The same schema is used for all components (MobileFirst Server administration service, MobileFirst Server live update service, MobileFirst Server push service, and MobileFirst runtime)

#### Installation with Ant tasks
The sample Ant files that are provided in the product distribution use the same schema for all components. However, it is possible to modify the Ant files to have different schemas:

* The same schema for the administration service and the live update service as they cannot be installed separately with Ant tasks.
* A different schema for the runtime
* A different schema for the push service.

#### Manual installation
It is possible to assign a different data source, and thus a different schema, to each of the MobileFirst Server components.  
The scripts to create the tables are as follows:

* For the administration service, in **mfp\_install\_dir/MobileFirstServer/databases/create-mfp-admin-db2.sql**.
* For the live update service, in **mfp\_install\_dir/MobileFirstServer/databases/create-configservice-db2.sql**.
* For the runtime component, in **mfp\_install\_dir/MobileFirstServer/databases/create-runtime-db2.sql**.
* For the push service, in **mfp\_install\_dir/PushService/databases/create-push-db2.sql**.

The following procedure creates the tables for all the applications in the same schema (MFPSCM). It assumes that a database and a user are already created. For more information, see [DB2 database and user requirements](#db2-database-and-user-requirements).

Run DB2 with the following commands with the user (mfpuser):

```sql
db2 CONNECT TO MFPDATA
db2 SET CURRENT SCHEMA = 'MFPSCM'
db2 -vf mfp_install_dir/MobileFirstServer/databases/create-mfp-admin-db2.sql
db2 -vf mfp_install_dir/MobileFirstServer/databases/create-configservice-db2.sql -t
db2 -vf mfp_install_dir/MobileFirstServer/databases/create-runtime-db2.sql -t
db2 -vf mfp_install_dir/PushService/databases/create-push-db2.sql -t
```

If the tables are created by mfpuser, this user has the privileges on the tables automatically and can use them at run time. If you want to restrict the privileges of the runtime user as described in [Database users and privileges](#database-users-and-privileges) or a finer control of privileges, refer to the DB2 documentation.

### Creating the Oracle database tables manually
Use the SQL scripts that are provided in the MobileFirst Server installation to create the Oracle database tables.

As described in the Overview section, all the four MobileFirst Server components need tables. They can be created in the same schema or in different schemas. However, some constraints apply depending on how the MobileFirst Server applications are deployed to the Java application server. The details are described in [Database users and privileges](#database-users-and-privileges).

The tables must be created in the default schema of the runtime user. The scripts to create the tables are as follows:

* For the administration service, in **mfp\_install\_dir/MobileFirstServer/databases/create-mfp-admin-oracle.sql**.
* For the live update service, in **mfp\_install\_dir/MobileFirstServer/databases/create-configservice-oracle.sql**.
* For the runtime component, in **mfp\_install\_dir/MobileFirstServer/databases/create-runtime-oracle.sql**.
* For the push service, in **mfp\_install\_dir/PushService/databases/create-push-oracle.sql**.

The following procedure creates the tables for all the applications for the same user (**MFPUSER**). It assumes that a database and a user are already created. For more information, see [Oracle database and user requirements](#oracle-database-and-user-requirements).

Run the following commands in Oracle SQLPlus:

```sql
CONNECT MFPUSER/MFPUSER_password@ORCL
@mfp_install_dir/MobileFirstServer/databases/create-mfp-admin-oracle.sql
@mfp_install_dir/MobileFirstServer/databases/create-configservice-oracle.sql
@mfp_install_dir/MobileFirstServer/databases/create-runtime-oracle.sql
@mfp_install_dir/PushService/databases/create-push-oracle.sql
DISCONNECT;
```

If the tables are created by MFPUSER, this user has the privileges on the tables automatically and can use them at run time. The tables are created in the user's default schema. If you want to restrict the privileges of the runtime user as described in [Database users and privileges](#database-users-and-privileges) or have a finer control of privileges, refer to the Oracle documentation.

### Creating the MySQL database tables manually
Use the SQL scripts that are provided in the MobileFirst Server installation to create the MySQL database tables.

As described in the Overview section, all the four MobileFirst Server components need tables. They can be created in the same schema or in different schemas. However, some constraints apply depending on how the MobileFirst Server applications are deployed to the Java application server. They are the similar to the topic about the possible users for MySQL as described in [Database users and privileges](#database-users-and-privileges).

#### Installation with the Server Configuration Tool
The same database is used for all components (MobileFirst Server administration service, MobileFirst Server live update service, MobileFirst Server push service, and MobileFirst runtime)

#### Installation with Ant tasks
The sample Ant files that are provided in the product distribution use the same database for all components. However, it is possible to modify the Ant files to have different database:

* The same database for the administration service and the live update service as they cannot be installed separately with Ant tasks.
* A different database for the runtime
* A different database for the push service.

#### Manual installation
It is possible to assign a different data source, and thus a different database, to each of the MobileFirst Server components.  
The scripts to create the tables are as follows:

* For the administration service, in **mfp\_install\_dir/MobileFirstServer/databases/create-mfp-admin-mysql.sql**.
* For the live update service, in **mfp\_install\_dir/MobileFirstServer/databases/create-configservice-mysql.sql**.
* For the runtime component, in **mfp\_install\_dir/MobileFirstServer/databases/create-runtime-mysql.sql**.
* For the push service, in **mfp\_install\_dir/PushService/databases/create-push-mysql.sql**.

The following example creates the tables for all the applications for the same user and database. It assumes that a database and a user has been created as in [Requirements for the databases for MySQL](#database-requirements).

The following procedure creates the tables for all the applications for the same user (mfpuser) and database (MFPDATA). It assumes that a database and a user are already created.

1. Run a MySQL command line client with the option: `-u mfpuser`.
2. Enter the following commands:

```sql
USE MFPDATA;
SOURCE mfp_install_dir/MobileFirstServer/databases/create-mfp-admin-mysql.sql;
SOURCE mfp_install_dir/MobileFirstServer/databases/create-configservice-mysql.sql;
SOURCE mfp_install_dir/MobileFirstServer/databases/create-runtime-mysql.sql;
SOURCE mfp_install_dir/PushService/databases/create-push-mysql.sql;
```

## Create the database tables with the Server Configuration Tool
The database tables for the MobileFirst Server applications can be created manually, with Ant Tasks, or with the Server Configuration Tool. The topics provide the explanation and details about database setup when you install MobileFirst Server with the Server Configuration Tool.

The Server Configuration Tool can create the database tables as part of the installation process. In some cases, it can even create a database and a user for the MobileFirst Server components. For an overview of the installation process with the Server Configuration Tool, see [Installing MobileFirst Server in graphical mode](../tutorials/graphical-mode).

After you complete the configuration credentials and click **Deploy** in the Server Configuration Tool pane, the following operations are run:

* Create the database and user if needed.
* Verify whether the MobileFirst Server tables exist in the database. If they do not exist, create the tables.
* Deploys the MobileFirst Server applications to the application server.

If the database tables are created manually before you run the Server Configuration Tool, the tool can detect them and skip the phase of setting up the tables.

Depending on your choice of the supported database management system (DBMS), select one of the following topics for more details on how the tool creates the database tables.

* [Creating the DB2 database tables with the Server Configuration Tool](#creating-the-db2-database-tables-with-the-server-configuration-tool)
* [Creating the Oracle database tables with the Server Configuration Tool](#creating-the-oracle-database-tables-with-the-server-configuration-tool)
* [Creating the MySQL database tables with the Server Configuration Tool](#creating-the-mysql-database-tables-with-the-server-configuration-tool)

### Creating the DB2 database tables with the Server Configuration Tool
Use the Server Configuration Tool that is provided with MobileFirst Server installation to create the DB2  database tables.

The Server Configuration Tool can create a database in the default DB2 instance. In **Database Selection** panel of the Server Configuration Tool, select the IBM DB2 option. In the next three panes, enter the database credentials. If the database name that is entered in the **Database Additional Settings** panel does not exist in the DB2 instance, you can enter additional information to enable the tool to create a database for you.

The Server Configuration Tool creates the database tables with default settings with the following SQL statement:
```sql
CREATE DATABASE MFPDATA COLLATE USING SYSTEM PAGESIZE 32768
```

It is not meant to be used for production as in a default DB2 installation, many privileges are granted to PUBLIC.

### Creating the Oracle database tables with the Server Configuration Tool
Use the Server Configuration Tool that is provided with MobileFirst Server installation to create the Oracle database tables.

In Database Selection panel of the Server Configuration Tool, select the **Oracle Standard or Enterprise Editions, 11g or 12c** option. In the next three panes, enter the database credentials.

When you enter the Oracle user name in **Database Additional Settings** panel, it must be in uppercase. If you have an Oracle database user (FOO), but you enter a user name with lowercase (foo), the Server Configuration Tool considers it as another user. Unlike other tools for Oracle database, the Server Configuration Tool protects the user name against automatic conversion to uppercase.

The Server Configuration Tool uses a service name or Oracle System Identifier (SID) to identify a database. However, if you want to make the connection to Oracle RAC, you need to enter a complex JDBC URL. In this case, in the **Database Settings** panel, select the **Connect using generic Oracle JDBC URLs** option and enter a URL for the Oracle thin driver.

If you need to create database and user for Oracle, use the Oracle Database Creation Assistant (DBCA) tool. For more information, see [Oracle database and user requirements](#oracle-database-and-user-requirements).

The Server Configuration Tool can do the same but with a limitation. The tool can create a user for Oracle 11g or Oracle 12g. However, it can create a database only for Oracle 11g, and not for Oracle 12c.

If the database name or user name that is entered in the **Database Additional Settings** panel does not exist, refer to the following two sections for the extra steps to create the database or the user.

#### Creating the database

1. Run an SSH server on the computer that runs the Oracle database.

    The Server Configuration Tool opens an SSH session to the Oracle host to create the database. Except on Linux and some versions of UNIX systems, the SSH server is needed even if the Oracle database runs on the same computer as the Server Configuration Tool.

2. In **Database creation request** panel, enter the login ID and password of an Oracle database user that has the privileges to create a database.
3. In the same panel, also enter the password for the **SYS** user and the **SYSTEM** user for the database that is to be created.

A database is created with the SID name that is entered in the **Database Additional Settings** panel. It is not meant to be used for production.

#### Creating the user

1. Run an SSH server on the computer that runs the Oracle database.

    The Server Configuration Tool opens an SSH session to the Oracle host to create the database. Except on Linux and some versions of UNIX systems, the SSH server is needed even if the Oracle database runs on the same computer as the Server Configuration Tool.

2. In the **Database Additional Settings** panel, enter the login ID and password of the database user that is to be created.
3. In **Database creation request** panel, enter the login ID and password of an Oracle database user that has the privileges to create a database user.
4. In same panel, also enter the password for the **SYSTEM** user of the database.

### Creating the MySQL database tables with the Server Configuration Tool
Use the Server Configuration Tool that is provided with MobileFirst Server installation to create the MySQL database tables.

The Server Configuration Tool can create a MySQL database for you. In **Database Selection** panel of the Server Configuration Tool, select the **MySQL 5.5.x, 5.6.x or 5.7.x** option. In the next three panes, enter the database credentials. If the database or the user that you enter in the Database Additional Settings panel does not exist, the tool can create it.

If MySQL server does not have the settings that are recommended in [MySQL database and user requirements](#mysql-database-and-user-requirements), the Server Configuration Tool displays a warning. Make sure to fulfill the requirements before you run the Server Configuration Tool.

The following procedure provides some extra steps that you need to do when you create the database tables with the tool.

1. In the **Database Additional Settings** panel, besides the connection settings, you must enter all the hosts from which the user is allowed to connect to the database. That is, all the hosts where MobileFirst Server runs.
2. In the **Database creation request** panel, enter the login ID and the password of a MySQL administrator. By default, the administrator is root.

## Create the database tables with Ant tasks
The database tables for the MobileFirst Server applications can be created manually, with Ant Tasks, or with the Server Configuration Tool. The topics provide the explanation and details on how to create them with Ant tasks.

You can find relevant information in this section about the setting up of the database if MobileFirst Server is installed with Ant Tasks.

You can use Ant Tasks to set up the MobileFirst Server database tables. In some cases, you can also create a database and a user with these tasks. For an overview of the installation process with Ant Tasks, see [Installing MobileFirst Server in command line mode](../tutorials/command-line).

A set of sample Ant files is provided with the installation to help you get started with the Ant tasks. You can find the files in **mfp\_install\_dir/MobileFirstServer/configurations-samples**. The files are named after the following patterns:

#### configure-appserver-dbms.xml
The Ant files can do these tasks:

* Create the tables in a database if the database and database user exist. The requirements for the database are listed in [Database requirements](#database-requirements).
* Deploy the WAR files of the MobileFirst Server components to the application server. These Ant files use the same database user to create the tables, and to install the run time database user for the applications at run time. The files also use the same database user for all theMobileFirst Server applications.

#### create-database-dbms.xml
The Ant files can create a database if needed on the supported database management system (DBMS), and then create the tables in the database. However, as the database is created with default settings, it is not meant to be used for production.

In the Ant files, you can find the predefined targets that use the **configureDatabase** Ant task to set up the database. For more information, see [Ant configuredatabase](../installation-reference/#ant-configuredatabase-task-reference) task reference.

### Using the sample Ant files
The sample Ant files have predefined targets. Follow this procedure to use the files.

1. Copy the Ant file according to your application server and database configuration in a working directory.
2. Edit the file and enter the values for your configuration in the `<! -- Start of Property Parameters -->` section for the Ant file.
3. Run the Ant file with the databases target: `mfp_install_dir/shortcuts/ant -f your_ant_file databases`.

This command creates the tables in the specified database and schema for all MobileFirst Server applications (MobileFirst Server administration service, MobileFirst Server live update service, MobileFirst Server push service, and MobileFirst Server runtime). A log for the operations is produced and stored in your disk.

* On Windows, it is in C:\Users\user_name\Documents\IBM MobileFirst Platform Server Data\Configuration Logs\ directory.
* On UNIX, it is in $HOME/.mobilefirst\_platform\_server/configuration-logs/ directory.

### Different users for the database tables creation and for run time
The sample Ant files in **mfp\_install\_dir/MobileFirstServer/configurations-samples** use the same database user for:

* All the MobileFirst Server applications (the administration service, the live update service, the push service, and the runtime)
* The user that is used to create the database and the user at run time for the data source in the application server.

If you want to separate the users as described in [Database users and privileges](#database-users-and-privileges), you need to create your own Ant file, or modify the sample Ant files so that each database target has a different user. For more information, see the [Installation reference](../installation-reference).

For DB2  and MySQL, it is possible to have different users for the database creation and for the run time. The privileges for each type of the users are listed in [Database users and privileges](#database-users-and-privileges). For Oracle, you cannot have a different user for database creation and for the run time. The Ant tasks consider that the tables are in the default schema of a user. If you want to reduce privileges for the runtime user, you must create the tables manually in the default schema of the user that will be used at run time. For more information, see [Creating the Oracle database tables manually](#creating-the-oracle-database-tables-manually).

Depending on your choice of the supported database management system (DBMS), select one of the following topics to create the database with Ant tasks.

### Creating the DB2 database tables with Ant tasks
Use Ant tasks that are provided with MobileFirst Server installation to create the DB2  database.

To create the database tables in a database that already exists, see [Create the database tables with Ant tasks](#create-the-database-tables-with-ant-tasks).

To create a database and the database tables, you can do so by Ant tasks. The Ant tasks create a database in the default instance of DB2 if you use an Ant file that contains the **dba** element. This element can be found in the sample Ant files named as **create-database-<dbms>.xml**.

Before you run the Ant tasks, make sure that you have an SSH server on the computer that runs the DB2 database. The **configureDatabase** Ant task opens an SSH session to the DB2 host to create the database. The SSH server is needed even if the DB2 database runs on the same computer where you run the Ant tasks (except on Linux and some versions of UNIX systems).

Follow the general guidelines as described in [Create the database tables with Ant tasks](#create-the-database-tables-with-ant-tasks) to edit the copy of the **create-database-db2.xml** file.

You must also provide the login ID and password of a DB2 user with administration privileges (**SYSADM** or **SYSCTRL** permissions) in the **dba** element. In the sample Ant file for DB2 (**create-database-db2.xml**), the properties to set are: **database.db2.admin.username** and **database.db2.admin.password**.

When the **databases** Ant target is called, the **configureDatabase** Ant task creates a database with default settings with the following SQL statement:

```sql
CREATE DATABASE MFPDATA COLLATE USING SYSTEM PAGESIZE 32768
```

It is not meant to be used for production as in a default DB2 installation, many privileges are granted to PUBLIC.

### Creating the Oracle database tables with Ant tasks
Use Ant tasks that are provided with MobileFirst Server installation to create the Oracle database tables.

When you enter the Oracle user name in Ant file, it must be in uppercase. If you have an Oracle database user (FOO), but you enter a user name with lowercase (foo), the **configureDatabase** Ant task considers it as another user. Unlike other tools for Oracle database, the **configureDatabase** Ant task protects the user name against automatic conversion to uppercase.

The **configureDatabase** Ant task uses a service name or Oracle System Identifier (SID) to identify a database. However, if you want to make the connection to Oracle RAC, you need to enter a complex JDBC URL. In this case, the **oracle** element that is within the **configureDatabase** Ant task must use the attributes (**url**, **user**, and **password**) instead of these attributes (**database**, **server**, **port**, **user**, and **password**). For more information, see the table in [Ant **configuredatabase** task reference](../installation-reference/#ant-configuredatabase-task-reference). The sample Ant files in **mfp\_install\_dir/MobileFirstServer/configurations-samples** use the **database**, **server**, **port**, **user**, and **password** attributes in the **oracle** element. They must be modified if you need to connect to Oracle with a JDBC URL.

To create the database tables in a database that already exists, see [Create the database tables with Ant tasks](#create-the-database-tables-with-ant-tasks).

To create a database, user, or the database tables, use the Oracle Database Creation Assistant (DBCA) tool. For more information, see [Oracle database and user requirements](#oracle-database-and-user-requirements).

The **configureDatabase** Ant task can do the same but with a limitation. The task can create a database user for Oracle 11g or Oracle 12g. However, it can create a database only for Oracle 11g, and not for Oracle 12c. Refer to the following two sections for the extra steps that you need to create the database or the user.

#### Creating the database
Follow the general guidelines as described in [Create the database tables with Ant tasks](#create-the-database-tables-with-ant-tasks) to edit the copy of the **create-database-oracle.xml** file.

1. Run an SSH server on the computer that runs the Oracle database.

    The **configureDatabase** Ant task opens an SSH session to the Oracle host to create the database. Except on Linux and some versions of UNIX systems, the SSH server is needed even if the Oracle database runs on the same computer where you run the Ant tasks.

2. In **dba** element that is defined in the **create-database-oracle.xml** file, enter the login ID and password of an Oracle database user that can connect to the Oracle Server via SSH and has the privileges to create a database. You can assign the values in the following properties:
    * **database.oracle.admin.username**
    * **database.oracle.admin.password**
3. In **oracle** element, enter the database name that you want to create. The attribute is **database**. You can assign the value in the **database.oracle.mfp.dbname** property.
4. In the same **oracle** element, also enter the password for the **SYS** user and the **SYSTEM** user for the database that is to be created. The attributes are **sysPassword** and **systemPassword**. You can assign the values in the corresponding properties:
    * **database.oracle.sysPassword**
    * **database.oracle.systemPassword**
5. After all the database credentials are entered in the Ant file, save it and run the **databases** Ant target.

A database is created with the SID name that is entered in the database of the **oracle** element. It is not meant to be used for production.

#### Creating the user
Follow the general guidelines as described in [Create the database tables with Ant tasks](#create-the-database-tables-with-ant-tasks) to edit the copy of the **create-database-oracle.xml** file.

1. Run an SSH server on the computer that runs the Oracle database.

    The **configureDatabase** Ant task opens an SSH session to the Oracle host to create the database. Except on Linux and some versions of UNIX systems, the SSH server is needed even if the Oracle database runs on the same computer where you run the Ant tasks.

2. In oracle element that is defined in the **create-database-oracle.xml** file, enter the login ID and password of an Oracle database user that you want to create. The attributes are **user** and **password**. You can assign the values in the corresponding properties:
    * database.oracle.mfp.username
    * database.oracle.mfp.password
3. In the same **oracle** element, also enter the password for the **SYSTEM** user for the database. The attribute is **systemPassword**. You can assign the value in the **database.oracle.systemPassword property**.
4. In the **dba** element, enter the login ID and password of an Oracle database user that has the privileges to create a user. You can assign the values in the following properties:
    * **database.oracle.admin.username**
    * **database.oracle.admin.password**
5. After all the database credentials are entered in the Ant file, save it and run the **databases** Ant target.

A database user is created with the name and password that are entered in the **oracle** element. This user has the privileges to create the MobileFirst Server tables, upgrade them and use them at run time.





### Creating the MySQL database tables with Ant tasks
Use Ant Tasks that are provided with MobileFirst Server installation to create the MySQL database tables.

To create the database tables in a database that already exists, see [Create the database tables with Ant tasks](#create-the-database-tables-with-ant-tasks).

If MySQL server does not have the settings that are recommended in [MySQL database and user requirements](#mysql-database-and-user-requirements), the **configureDatabase** Ant task displays a warning. Make sure to fulfill the requirements before you run the Ant task.

To create a database and the database tables, follow the general guidelines as described in [Create the database tables with Ant tasks](#create-the-database-tables-with-ant-tasks) to edit the copy of the **create-database-mysql.xml** file.

The following procedure provides some extra steps that you need to do when you create the database tables with the **configureDatabase** Ant task.

1. In the **dba** element that is defined in the **create-database-mysql.xml** file, enter the login ID and password of a MySQL administrator. By default, the administrator is **root**. You can assign the values in the following properties:
    * **database.mysql.admin.username**
    * **database.mysql.admin.password**
2. In the **mysql** element, add a **client** element for each host from which the user is allowed to connect to the database. That is, all the hosts where MobileFirst Server runs.
After all the database credentials are entered in the Ant file, save it and run the **databases** Ant target.
