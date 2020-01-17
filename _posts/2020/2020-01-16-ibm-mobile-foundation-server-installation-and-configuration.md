---
title: IBM Mobile Foundation Server Installation and Configuration 
date: 2020-01-16
tags:
- MobileFirst_Platform
- MobileFirst_Foundation
- On_Premise
version:
- 8.0
author:
  name: Soumya Y Shanthimohan
---

>Any task gets easier when we understand it better.

>Installation and configuration of Mobile Foundation (MF) Server is as easy as it is explained in our [product documentation] (https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/installation-configuration/). In this blog, let us understand MF installation and configuration in simple terms.

### To Start With -

You can try the MF server in action by downloading the [Developer Kit](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/installation-configuration/development/) .

The Developer Kit can be [downloaded](http://mobilefirstplatform.ibmcloud.com/downloads/#developer-kit) for free and it brings in all the various components of MF v8.0 for you to experience.

This sets up a development environment for you to play around before installing the MF Server on your Production Environment.

### System requirements -

As a pre-requisite, review our [System Requirements page]  (http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/product-overview/requirements/) prior to installation.

This will help you setup a system for MF server to run smoothly and efficiently.

### MF Server Installation through Installation Manager -

- Steps to install MF Server can be found [here](http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/installation-configuration/production/prod-env/)
- MF Server installation using IBM Installation manager (IM) basically deploys all the MF related artifacts on to the user’s machine
- Post IM Installation, the MF war files have to be configured on your Application Server 
- Post IM Installation, the Database should be configured by creating the required MF tables
- Also, applying an ifix means just updating your MF artifacts in the MF install directory. You will have to configure your Application Server after applying ifix to see the changes in the MF server
- During MF server installation using IM, you can optionally install [Application Center](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/appcenter/)

### Post Installation Tasks -

- Once the MF server installation is done, you have all the MF artifatcs on your machine
- It’s time to configure MF artifacts on to your Application Server
- Database instance should also be configured, and the required MF tables should be created
- Configuring the Database and Application Server is made easy by providing inhouse tools in the MF Install directory
- You may use the [Server Configuration tool or ANT tasks to configure your Application Server and Database](https://mobilefirstplatform.ibmcloud.com/tutorials/ru/foundation/8.0/installation-configuration/production/prod-env/appserver/#installing-with-the-server-configuration-tool)
- The Application Server and Database can also be manually configured 
- Do not forget to update your Application Server using SCT or ANT after applying ifix, this will update your Application Server with the latest war files

>Note: Do not manually delete any files or folders in the MF server install directory. Deleting would cause issues while upgrading or even uninstalling the MF server.
