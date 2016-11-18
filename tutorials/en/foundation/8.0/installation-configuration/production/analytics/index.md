---
layout: tutorial
title: Installing and Configuring the MobileFirst Analytics Server	
breadcrumb_title: Installing MobileFirst Analytics Server
weight: 7
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
The MobileFirst Analytics Server is delivered as two separate WAR files. For convenience in deploying on WebSphere  Application Server or WebSphere Application Server Liberty, MobileFirst Analytics Server is also delivered as an EAR file that contains the two WAR files.

> **Note:** Do not install more than one instance of MobileFirst Analytics Server on a single host machine. For more information about managing your cluster, see the Elasticsearch documentation.

The analytics WAR and EAR files are included with the MobileFirst Server installation. For more information, see Distribution structure of MobileFirst Server. When you deploy the WAR file, the MobileFirst Analytics Console is available at: `http://<hostname>:<port>/analytics/console`, for example: `http://localhost:9080/analytics/console`.

* For more information about how to install MobileFirst Analytics Server, see [MobileFirst Analytics Server installation guide](installation).
* For more information about how to configure IBM MobileFirst Analytics, see [Configuration guide](configuration).
