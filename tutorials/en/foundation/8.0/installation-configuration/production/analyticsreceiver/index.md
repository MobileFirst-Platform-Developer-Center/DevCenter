---
layout: tutorial
title: Installing and Configuring the MobileFirst Analytics Receiver Server
breadcrumb_title: Installing MobileFirst Analytics Receiver Server
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{: #overview }
The Mobile Analytics Receiver server is optional server that can be deployed to send Mobile Foundation Analytics Events from mobile client applications instead of to the Mobile Foundation Server runtime.  This deployment option enables offloading analytics events processing from the Mobile Foundation server runtime thereby allowing it's resources to be fully utilized for runtime functions.  

The {{ site.data.keys.mf_analytics_receiver_server }} is delivered as single WAR file. You should install this in seperate server. You can install it with one of the following methods:

* Installation with Ant tasks
* Manual installation

After you installed the {{ site.data.keys.mf_analytics_receiver_server }} in the web application server of your choice, you have additional configuration to do. For more information, see Configuring {{ site.data.keys.mf_analytics_receiver_server }} after installation below. If you choose a manual setup in the installer, see the documentation for the application server of your choice.

> **Note:** Do not install more than one instance of {{ site.data.keys.mf_analytics_receiver_server }} on a single host machine.

The analytics receiver WAR file is included with the MobileFirst Server installation. For more information, see Distribution structure of MobileFirst Server.

* For more information about how to install {{ site.data.keys.mf_analytics_receiver_server }}, see [{{ site.data.keys.mf_analytics_receiver_server }} installation guide](installation).
* For more information about how to configure IBM MobileFirst Analytics Receiver, see [Configuration guide](configuration).
