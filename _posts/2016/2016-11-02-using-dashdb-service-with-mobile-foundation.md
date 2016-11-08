---
title: Using Bluemix dashDB service with Mobile Foundation
date: 2016-11-02
tags:
- MobileFirst_Foundation
- Mobile_Foundation
- Bluemix
- dashDB
version: 8.0
author:
  name: Prashanth Bhat
---

## Overview:
**IBM MobileFirst Foundation**  can be setup on **Bluemix** in the following two ways:  
1. Using the [Mobile Foundation Bluemix service] (https://new-console.ng.bluemix.net/catalog/services/mobile-foundation/)  
2. Deploying Mobile Foundation on Bluemix using IBM-provided scripts that come with your on-prem License entitlement:  

* Setting up the [MobileFirst Server on Bluemix using Scripts on Liberty for Java runtime] (https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/bluemix/mobilefirst-server-using-scripts-lbp/)  
* Setting up the [MobileFirst Server on IBM Containers using Scripts on IBM Container Service] (https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/bluemix/mobilefirst-server-using-scripts/)  

In any of the above options, MobileFirst Server needs a database to store administration and runtime data such as deployed adapters, application configuration data, registered devices and so on.  

The database options for storing the administration and runtime data are as follows:  

1. **The Mobile Foundation Bluemix service:**  
  *  The **Developer plan** comes with a transient *Derby database*. This is a file system based database and meant only for short term demo purposes. Since derby data is stored in the Liberty application that is deployed, the data is not be persisted across restarts of the Cloud Foundry application.  
  * All the other plans: **Developer Pro, Professional Per Capacity** or **Professional1Application** plan requires you to provide a *dashDB database service on Bluemix*. Only the transactional plans of dashDB service are supported.  
2. **MobileFirst Foundation on Bluemix using IBM-provided scripts:**  
 In case of the scripts option, an external database is mandatory. We have the following two options:  
 * A *dashDB database service on Bluemix*. Only the transactional plans of dashDB service are supported.
 * An existing *IBM DB2 database*. (Bring your own DB2 database)

This blog post gives you the options available for using **dashDB Bluemix service as the database when you deploy MobileFirst Foundation on Bluemix.** In particular, we will see how a dashDB service can be shared across multiple instances of MobileFirst Foundation deployments.

## The dashDB Bluemix service:
IBM dashDB offers fully-managed, SQL database services for both transactional and data warehousing workloads. dashDB offers a host of plans under the following two categories:  

1. Plans targeted for analytics workloads through features such as in-memory data processing with columnar tables.  
2. Plans that deliver a transactional solution (OLTP) with enterprise-level performance and capabilities.  

**Mobile Foundation on Bluemix only supports the Enterprise transactional plans of dashDB service.**  

The picture depicts the dashDB plans showing the ones supported by Mobile Foundation. The plan **Enterprise for Transactions High Availability 2.8.500 (Pay per use)** is the recommended plan.  

> **Note:** You need to create the dashDB service instance before you can deploy MobileFirst Foundation on Bluemix.

![supported dashDB plans]({{site.baseurl}}/assets/blog/2016-11-02-using-dashdb-service-with-mobile-foundation/dashDBplans.png)

## Using the dashDB plan in the Mobile Foundation Bluemix service:
The *Developer Pro, Professional Per Capacity* and *Professional1Application plan* requires you to connect to a Bluemix dashDB service instance. When you deploy the Mobile Foundation service on Bluemix, you will be asked to provide the dashDB service instance details as the first step, as shown in the picture below.  

![connect-mobilefoundation-to-dashDB]({{site.baseurl}}/assets/blog/2016-11-02-using-dashdb-service-with-mobile-foundation/foundationservice-dashDB.png)

Upon connecting the Mobile Foundation to the dashDB service, a new schema is created for the exclusive use of this service instance, and all the data for that instance will be stored within the schema. This schema is not shared with the other instances of the Mobile Foundation service.  

A single dashDB instance can be shared across multiple Mobile Foundation service deployments. These deployments can very well be on different Organizations (Orgs) and Spaces. You only need to make sure that the user deploying the Mobile Foundation service has access to the Organization and Space where the dashDB instance is deployed.  
  
> **Note:** Connecting your Mobile Foundation service instance to as dashDB instance is a one-time activity that you will carry out when you create the instance for the first time. You cannot change the connection at a later point.  

## Using the dashDB service with Mobile Foundation on Bluemix using IBM-provided scripts:
### Connecting to a dashDB that is in an Org/space that is different than the MobileFirst Server:  

If you use dashDB service as the database when you deploy Mobile Foundation on Bluemix using scripts, then you need to run the scripts provided along with your MobileFirst Server download.  
[Follow the instructions] (https://www-01.ibm.com/support/docview.wss?uid=swg2C7000005) in this page to download the IBM MobileFirst Server 8.0 for IBM Containers archive (.zip file, search for: CNBL0EN).  
  
**Option 1:** If you are deploying MobileFirst Server in the same Org and Space where the dashDB service exists:  

1. `initenv.sh` – Provide the inputs to Log in to Bluemix Org and Space.
2. `prepareserverdbs.sh` – Creates the required schema and tables in the dashDB database and configures Mobile Foundation to connect to the database. The schemas are created in the dashDB service if they do not already exist. It is usually sufficient to use the same dashDB service instance as well as a single schema for Admin, Runtime as well as Push. 
3. `prepareserver.sh` - Create and upload the app onto Bluemix
4. `startserver.sh` – Start the Mobile Foundation app

**Option 2:** If you are deploying Mobile Foundation on a different Org and Space than where the dashDB service instance exists:  

1. `initenv.sh` – Provide the Org and Space where you have the dashDB service provisioned.
2. `prepareserverdbs.sh` – Creates the required schema and tables in the dashDB database and configures Mobile Foundation to connect to the database. The schemas are created in the dashDB service if they do not already exist. 
It is usually enough to use the same dashDB service instance as well as a single schema for Admin, Runtime and Push.  
Note: If the same dashDB is being shared across multiple Mobile Foundation instances, provide a unique Schema name which is not already in use. 
3. `initenv.sh` – Run this again and provide the Org and Space where you want to create your Mobile Foundation instance.
4. `prepareserver.sh` - Create and upload the app onto Bluemix 
5. `startserver.sh` – Start the Mobile Foundation app

### Sharing the same dashDB service instance across different Mobile Foundation deployments:
You can share a single dashDB service instance across many Mobile Foundation deployments.   
As you can see from the above steps, the prepareserverdbs.sh script creates the new schema as specified in the input parameters. Use Option 2 from above to reuse the same dashDB. Make sure that you isolate the database usage for each instance by providing a unique schema name for each MobileFirst Foundation deployment.   
  
A good practice is to prefix or add the user name or app name in the schema name that you create.  
  
For example: 
   
*User1* deploys his Mobile Foundation instance using the schema:  
` ADMIN_SCHEMA_NAME=MFPDATA_USER1_MYAPP1 `  
(The same schema names can be used for RUNTIME and PUSH schema names)  
  
*User2* deploys his Mobile Foundation instance using the schema:
` ADMIN_SCHEMA_NAME=MFPDATA_USER2_MYAPP2 `  
(The same schema names can be used for RUNTIME and PUSH schema names)  
  
### Deploying Mobile Foundation using scripts with specific dashDB user accounts:
If you want to share the dashDB instance across multiple users/developers, you may create new users in a dashDB instance and use them in the scripts.

New users with User role as **User** will be able to create new Schemas but will not be able to use schemas created by other users.

To create a new dashDB user:  

1. Navigate to your Bluemix Console and click on ‘All-Items’.
2. Search for your dashDB service instance, click and then ‘Open’ the dashDB instance
3. On the **dashDB Transactional** console, navigate to `Settings -> Users & Privileges` on the Left side menu
4. Click on the `+ `(Plus sign) to add a new user, create a new user, and set a password for the user. Click on `Add user` to save.
5. Note down the username and password that you have created.
The user that you have now created will be able to create new schemas in the dashDB service for their own user. But will not be able to use other users’ schemas.

![add-new-dashDB-user]({{site.baseurl}}/assets/blog/2016-11-02-using-dashdb-service-with-mobile-foundation/dashDBadmin.png)

Once you have created the new user, go to the Bluemix Console and click on `Service Credentials` of the dashDB service. View the Credentials and note down the following: 
 
1. `host`  
2. `db` (BLUDB by default)
3. `port` (50000 by default)  
The user name and password are not required since we will use the newly created user name and password for our deployment here.  
  
To setup Mobile Foundation using scripts with these settings, run the same steps but prepareserverdbs.sh will be run with the DB2 option  

1. `initenv.sh` – Logs in Bluemix Org and Space using the provided input parameters. This is the org and space where you will setup Mobile Foundation. The dashDB service instance can very well be in a different Org and Space.
2. `prepareserverdbs.sh` – Creates the required schema and tables in the dashDB database and configures Mobile Foundation to connect to the database. 
Provide the following properties, that you have noted in the previous steps:   

    ```xml
    DB_TYPE=DB2   
    DB2_HOST=aaaaaaa.services.dal.bluemix.net   
    DB2_DATABASE=BLUDB   
    DB2_PORT=50000   
    DB2_USERNAME=newuser   
    DB2_PASSWORD=xxxxxxxx   
    ADMIN_SCHEMA_NAME=MFPDATA_NEWUSER
    ```

3. `prepareserver.sh` - Create and upload the app onto Bluemix
4. `startserver.sh` – Start the Mobile Foundation app
