---
layout: tutorial
title: Setting Up Databases
weight: 2
show_disqus: true
---
## Overview
The following MobileFirst Server components need to store technical data into a database:

* MobileFirst Server administration service
* MobileFirst Server live update service
* MobileFirst Server push service
* MobileFirst runtime

> **Note:** If multiple runtime instances are installed with different context root, each instance needs its own set of tables.
> The database can be a relational database such as IBM® DB2®, Oracle, or MySQL.

#### Relational databases (DB2, Oracle, or MySQL)
Each component needs a set of tables. The tables can be created manually by running the SQL scripts specific to each component (see [Create the database tables manually](#create-the-database-tables-manually)), by using Ant Tasks, or the Server Configuration Tool. The table names of each component do not overlap. Thus, it is possible to put all the tables of these components under a single schema.

However, if you decide to install multiple instances of MobileFirst runtime, each with its own context root in the application server, every instance needs its own set of tables. In this case, they need to be in different schemas.

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
Review the database requirement for DB2®. Follow the steps to create user, database, and setup your database to meet the specific requirement.

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

The runtime user (as discussed is [Database users and privileges](#database-users-and-privileges)) must have an associated table space and enough quota to write the technical data required by the MobileFirst services. For more information about the tables that are used by the product, see [Internal runtime databases]().

The tables are expected to be created in the default schema of the runtime user. The Ant tasks and the Server Configuration Tool create the tables in the default schema of the user passed as argument. For more information about the creation of tables, see [Creating the Oracle database tables manually](#creating-the-oracle-database-tables-manually).

The procedure creates a database if needed. A user that can create tables and index in this database is added and used as a runtime user.

1. If you do not already have a database, use the Oracle Database Configuration Assistant (DBCA) and follow the steps in the wizard to create a new general-purpose database, named ORCL in this example:
    * Use global database name **ORCL_your_domain**, and system identifier (SID) **ORCL**.
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
Use the SQL scripts that are provided in the MobileFirst Server installation to create the DB2® database tables.

As described in the Overview section, all the four MobileFirst Server components need tables. They can be created in the same schema or in different schemas. However, some constraints apply depending on how the MobileFirst Server applications are deployed to the Java™ application server. They are the similar to the topic about the possible users for DB2 as described in [Database users and privileges](#database-users-and-privileges).

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

* For the administration service, in mfp_install_dir/MobileFirstServer/databases/create-mfp-admin-db2.sql.
* For the live update service, in mfp_install_dir/MobileFirstServer/databases/create-configservice-db2.sql.
* For the runtime component, in mfp_install_dir/MobileFirstServer/databases/create-runtime-db2.sql.
* For the push service, in mfp_install_dir/PushService/databases/create-push-db2.sql.

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



### Creating the MySQL database tables manually




