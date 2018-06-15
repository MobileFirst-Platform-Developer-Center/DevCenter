---
layout: tutorial
title: Installing and Configuring the MobileFirst Analytics Server
breadcrumb_title: Installing MobileFirst Analytics Server
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{: #overview }
The {{ site.data.keys.mf_analytics_server }} is delivered as two separate WAR files. For convenience in deploying on WebSphere  Application Server or WebSphere Application Server Liberty, {{ site.data.keys.mf_analytics_server }} is also delivered as an EAR file that contains the two WAR files.

> **Note:** Do not install more than one instance of {{ site.data.keys.mf_analytics_server }} on a single host machine. For more information about managing your cluster, see the Elasticsearch documentation.

The analytics WAR and EAR files are included with the MobileFirst Server installation. For more information, see Distribution structure of MobileFirst Server. When you deploy the WAR file, the MobileFirst Analytics Console is available at: `http://<hostname>:<port>/analytics/console`, for example: `http://localhost:9080/analytics/console`.

* For more information about how to install {{ site.data.keys.mf_analytics_server }}, see [{{ site.data.keys.mf_analytics_server }} installation guide](installation).
* For more information about how to configure IBM MobileFirst Analytics, see [Configuration guide](configuration).
