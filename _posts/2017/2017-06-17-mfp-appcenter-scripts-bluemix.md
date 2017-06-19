---
title: Scripts for deploying IBM Mobile First Platform Application Center on Bluemix is released
date: 2017-06-17
tags:
- MobileFirst_Foundation
- Application_Center
- Bluemix
- IBM_Containers
- Docker
- Announcement
version: 8.0
author:
  name: Vinod Appajanna
---
Starting from MobileFirst Foundation [iFix8.0.0.0-MFPF-IF20170608-0406](https://mobilefirstplatform.ibmcloud.com/blog/2017/06/08/8-0-ifix-release/) the scripts for deploying IBM MobileFirst Platform Application Center for IBM Containers and Liberty for Java runtime on Bluemix is supported.


**For Application Center on “IBM Containers” following are the high level steps**


1. Setup your host computer with the required tools ([Cloud Foundry CLI](https://github.com/cloudfoundry/cli/releases)).
2. Setup your [Bluemix](https://console.bluemix.net) account.
3. Build the MobileFirst Application Center and push it to Bluemix as a Cloud Foundry application.

Finally, you will upload the apps to the Application Center and can install the same from devices.


**For Application Center on “Liberty for java Runtime” following are the high level steps**


1. Setup your host computer with the required tools (Cloud Foundry CLI, Docker, and IBM Containers Extension (cf ic) Plug-in).
2. Setup your Bluemix account.
3. Build a MobileFirst Application Server image and push it to the Bluemix repository.

Finally, you will run the image on IBM Containers as a single Container or a Container group, and upload the apps to the Application Center.

**For more details on installation procedure refer the links below**

* [IBM Containers](http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/bluemix/mobilefirst-server-using-scripts/)
* [Liberty for java Runtime ](http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/bluemix/mobilefirst-server-using-scripts-lbp/)
