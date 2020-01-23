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

>Installation and configuration of Mobile Foundation (MF) server comprise of steps that can be carried out easily, as explained in our [product documentation](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/installation-configuration/). This blog attempts to explain MF installation and configuration in simple terms.

### To Start With

You can explore feature functions of the MF server by downloading the [Developer Kit](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/installation-configuration/development/).

The Developer Kit can be [downloaded](http://mobilefirstplatform.ibmcloud.com/downloads/#developer-kit) for free and it brings with it all the various components of MF v8.0 for you to experience.

This sets up a development environment for you to play around before installing the MF server in your production environment.

### System requirements

As a pre-requisite, review our [System Requirements page](http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/product-overview/requirements/) prior to installation.

This will help you set up a system for the MF server to run smoothly and efficiently.

### MF Server Installation using Installation Manager

- Steps to install MF Server can be found [here](http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/installation-configuration/production/prod-env/).
- MF server installation using IBM Installation Manager (IM) deploys all the MF related artifacts on to the user’s machine.
- Post IM Installation, the MF war files have to be configured on your Application Server.
- Post IM Installation, the Database should be configured by creating the required MF tables.
- Also, applying an iFix means updating your MF artifacts in the MF install directory. You will have to configure your Application Server after applying iFix to see the changes in the MF server.
- During MF server installation using IM, you can optionally install [Application Center](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/appcenter/)

### Post Installation Tasks

- After the MF server installation is done, you have all the MF artifacts on your machine.
- Configure MF artifacts on to your application server.
- The database instance should also be configured, and the required MF tables should be created.
- Configuring the database and application server is made easy by providing OOTB tools in the MF Install directory
- You may use the [Server Configuration tool or ANT tasks to configure your Application Server and Database](https://mobilefirstplatform.ibmcloud.com/tutorials/ru/foundation/8.0/installation-configuration/production/prod-env/appserver/#installing-with-the-server-configuration-tool)
- The application server and database can also be manually configured.
- Do not forget to update your application server using SCT or ANT after applying iFix, this will update your application server with the latest war files.

>**Note:** Do not manually delete any files or folders in the MF server install directory. Deleting would cause issues while upgrading or even uninstalling the MF server.
