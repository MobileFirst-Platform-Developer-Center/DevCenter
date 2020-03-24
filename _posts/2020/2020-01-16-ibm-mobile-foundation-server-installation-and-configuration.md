---
title: IBM Mobile Foundation Server Installation and Configuration
date: 2020-01-21
tags:
- MobileFirst_Platform
- MobileFirst_Foundation
- On_Premise
version:
- 8.0
author:
  name: Soumya Y Shanthimohan
---

>Installation and configuration of Mobile Foundation (MF) server comprise of steps that can be carried out easily, as explained in our [product documentation](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/installation-configuration/). This blog attempts to explain the MF installation and configuration in simple terms.

### To Start With

You can explore feature functions of the MF server by downloading the [Developer Kit](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/installation-configuration/development/).

The Developer Kit can be [downloaded](http://mobilefirstplatform.ibmcloud.com/downloads/#developer-kit) for free and it brings with it all the various components of MF v8.0 for you to experience.

This sets up a development environment for you to play around before installing the MF server in your production environment.

### Review the System requirements

As a pre-requisite, review our [System Requirements page](http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/product-overview/requirements/) prior to installation.

This will help you set up a system for the MF server to run smoothly and efficiently.

### MF Server Installation using Installation Manager

- MF server installation using IBM Installation Manager (IM) copies all the MF related artifacts on to the user’s machine.

- You will next have to configure your Database to store MF related data by creating the required tables.

- You will also have to configure the MF artifacts on your Application Server.

- Steps to install MF Server can be found [here](http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/installation-configuration/production/prod-env/).

- During MF server installation using IM, you can optionally install [Application Center](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/appcenter/)

- Note that applying an iFix means updating your MF artifacts in the MF install directory. After applying the ifix, you will have to configure your Application Server with the latest war files to see the changes in the MF server.


### Post installation tasks

- After the MF server installation is done, you have all the MF artifacts on your machine.

- You will next have to configure the Database and the Application Server.

- Configuring the Database and Application Server is made easy by providing OOTB tools in the MF Install directory

- You may use the [Server Configuration tool or ANT tasks to configure your Application Server and Database](https://mobilefirstplatform.ibmcloud.com/tutorials/ru/foundation/8.0/installation-configuration/production/prod-env/appserver/#installing-with-the-server-configuration-tool)

- The application server and database can also be manually configured too.

- Do not forget to update your application server using SCT or ANT after applying iFix, this will update your application server with the latest war files.

>**Note:** Do not manually delete any files or folders in the MF server install directory. Deleting would cause issues while upgrading or even uninstalling the MF server.
