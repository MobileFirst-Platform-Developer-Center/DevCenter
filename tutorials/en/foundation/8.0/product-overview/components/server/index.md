---
layout: tutorial
title: MobileFirst Server
relevantTo: [ios,android,windows,javascript]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{: #overview }
{{ site.data.keys.mf_server }} consists of several components. An overview of {{ site.data.keys.mf_server }} architecture is provided for you to understand the functions of each component.

Unlike {{ site.data.keys.mf_server }} V7.1 or earlier, the installation process for V8.0.0 is separated from the development and deployment of mobile app operations. In V8.0.0, after the server components and the database are installed and configured, {{ site.data.keys.mf_server }} can be operated for most operations without the need to access the application server or database configuration.

The administration and deployment operations of the {{ site.data.keys.product_adj }} artifacts are done through {{ site.data.keys.mf_console }}, or the REST API of the {{ site.data.keys.mf_server }} administration service. The operations can also be done by using some command line tools that wrap this API, such as mfpdev or mfpadm. The authorized users of {{ site.data.keys.mf_server }} can modify the server-side configuration of mobile applications, upload, or configure server-side code (the adapters), upload new web resources for Cordova mobile apps, run application management operations and more.

{{ site.data.keys.mf_server }} offers extra layers of security, in addition to the security layers of the network infrastructure or the application server. The security features include the control of application authenticity and the access control to the server-side resources and the adapters. These security configurations can also be done by the authorized users of {{ site.data.keys.mf_console }} and the administration service. You determine the authorization of the {{ site.data.keys.product_adj }} administrators by mapping them to security roles as described in [Configuring user authentication for {{ site.data.keys.mf_server }} administration](../../../installation-configuration/production/server-configuration).

A simplified version of {{ site.data.keys.mf_server }} that is preconfigured and does not need software prerequisite such as database or an application server is available for developers. See [Setting up the {{ site.data.keys.product_adj }} Development Server](../../../installation-configuration/development).

## {{ site.data.keys.mf_server }} Components
{ #mobilefirst-server-components }
The architecture of the {{ site.data.keys.mf_server }} components is illustrated as follows:

![Components that make up the {{ site.data.keys.mf_server }}](server_components.jpg)

### Core components of {{ site.data.keys.mf_server }}
{: #core-components-of-mobilefirst-server }
{{ site.data.keys.mf_console }}, the {{ site.data.keys.mf_server }} administration service, the {{ site.data.keys.mf_server }} live update service, the {{ site.data.keys.mf_server }} artifacts, and the {{ site.data.keys.product_adj }} runtime are the minimum set of the components to install. 

* The runtime provides the {{ site.data.keys.product_adj }} services to the mobile apps that run on the mobile devices.
* The administration service provides the configuration and administration capabilities. You use the administration service via {{ site.data.keys.mf_console }}, the live update service REST API, or command line tools such as mfpadm or mfpdev. 
* The live update service manages configuration data and is used by the administration service.

These components require a database. The database table name for each component does not have any intersection. As such, you can use the same database or even the same schema to store all the tables of these components. For more information, see [Setting up databases](../../../installation-configuration/production/server-configuration).

It is possible to install more than one instance of the runtime. In this case, each instance needs its own database. The artifacts component provides resources for {{ site.data.keys.mf_console }}. It does not requires a database.

### Optional components of {{ site.data.keys.mf_server }}
{: #optional-components-of-mobliefirst-server }
The {{ site.data.keys.mf_server }} push service provides push notification capabilities. It must be installed to provide these capabilities of the mobile apps use the {{ site.data.keys.product_adj }} Push features. From the perspective of mobile apps, the URL of the push service is the same as the URL as the runtime, except that its context root is `/imfpush`.

If you plan to install the push service on a different server or cluster than the runtime, you need to configure the routing rules of your HTTP server. The configuration is to ensure that the requests to the push service and the runtime are properly routed. 

The push service requires a database. The tables of the push service have no intersection with the tables of the runtime, the administration service, and the live update service. Thus, it can also be installed in the same database or schema.

The {{ site.data.keys.mf_analytics }} service and {{ site.data.keys.mf_analytics_console }} provide monitoring and analytics information about the mobile apps usage. Mobile apps can provide more insight by using the Logger SDK. The {{ site.data.keys.mf_analytics }} service does not need a database. It stores its data locally on disk by using Elasticsearch. The data is structured in shards that can be replicated between the members of a cluster of the Analytics service.

For more information about the network flows and the topology constraints for these components, see [Topologies and network flows](../../../installation-configuration/production/server-configuration).

### Installation process
{: #installation-process }
The installation of {{ site.data.keys.mf_server }} on-premises can be done by using the following ways:

* The Server Configuration Tool - a graphical wizard
* Ant tasks through the command line tools
* Manual installation

For more information about the installation of {{ site.data.keys.mf_server }} on-premises is provided, see:

* A [guide through a complete installation](../../../installation-configuration/production/) of {{ site.data.keys.mf_server }} farm on WebSphere  Application Server Liberty profile. The guide is based on a simple scenario for you to try out the installation either in graphical mode or in command line mode.
* A [detailed section](../../../installation-configuration/production/) that contains details about the installation prerequisites, database setup, server topologies, deployment of the components to the application server, and server configuration.

