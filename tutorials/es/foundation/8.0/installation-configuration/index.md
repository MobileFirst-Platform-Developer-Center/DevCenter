---
layout: tutorial
title: Installation and Configuration
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{: #overview }
{{ site.data.keys.product_full }} provides development tools and server-side components that you can install on-premises or deploy to the cloud for test or production use. Review the installation topics appropriate for your installation scenario.

### Installing a development environment
{: #installing-a-development-environment }
If you develop the client-side or the server-side of mobile apps, use either the [{{ site.data.keys.mf_dev_kit }}](development/mobilefirst/) or the [{{ site.data.keys.mf_bm }} service](../bluemix/using-mobile-foundation) to get started.

* [Set-up the MobileFirst development environment](development/mobilefirst/)
* [Set-up the Cordova development environment](development/cordova)
* [Set-up the iOS development environment](development/ios)
* [Set-up the Android development environment](development/android)
* [Set-up the Windows development environment](development/windows)
* [Set-up the Xamarin development environment](development/xamarin)
* [Set-up the Web development environment](development/web)

### Installing a test or production server on-premises
{: #installing-a-test-or-production-server-on-premises }
IBM installations are based on an IBM product called IBM Installation Manager. Install IBM Installation Manager V1.8.4 or later separately before you install {{ site.data.keys.product }}.

> **Important:** Ensure that you use IBM Installation Manager V1.8.4 or later. The older versions of Installation Manager are not able to install {{ site.data.keys.product }} {{ site.data.keys.product_version }} because the post-installation operations of the product require Java 7. The older versions of Installation Manager come with Java 6.

The {{ site.data.keys.mf_server }} installer copies onto your computer all the tools and libraries that are required for deploying {{ site.data.keys.mf_server }} components and optionally the {{ site.data.keys.mf_app_center_full }} to your application server.

If you install a test or production server, start with **Tutorials about {{ site.data.keys.mf_server }} installation** below for a simple installation and to learn about the installation of {{ site.data.keys.mf_server }}. For more information about preparing an installation for your specific environment, see [Installing {{ site.data.keys.mf_server }} for a production environment](production).

**Tutorials about {{ site.data.keys.mf_server }} installation**  
Learn about the {{ site.data.keys.mf_server }} installation process by walking through the instructions to create a functional {{ site.data.keys.mf_server }}, cluster with two nodes on WebSphere  Application Server Liberty profile. The installation can be done in two ways:

* [By using the graphical mode of IBM  Installation Manager](production/tutorials/graphical-mode) and the Server Configuration Tool.
* [By using the command line tool](production/tutorials/command-line).

Afterwards you'll have a working {{ site.data.keys.mf_server }}. However, you need to configure it, in particular for security, before you use the server. For more information, see [Configuring {{ site.data.keys.mf_server }}](production/server-configuration).

**Additions**  

* To add {{ site.data.keys.mf_analytics_server }} to your installation, see the [{{ site.data.keys.mf_analytics_server }} installation guide](production/analytics/installation/).  
* To install {{ site.data.keys.mf_app_center }}, see [Installing and configuring the Application Center](production/appcenter).

### Deploying {{ site.data.keys.mf_server }} to the cloud
{: #deploying-mobilefirst-server-to-the-cloud }
If you plan to deploy {{ site.data.keys.mf_server }} to the cloud, see the following options:

* [Using {{ site.data.keys.mf_server }} on IBM Bluemix](../bluemix).
* [Using {{ site.data.keys.mf_server }} on IBM PureApplication](production/pure-application).

### Upgrading from earlier versions
{: #upgrading-from-earlier-versions }
For information about upgrading existing installations and applications to a newer version, see [Upgrading to {{ site.data.keys.product_full }} {{ site.data.keys.product_version }}](../all-tutorials/#upgrading_to_current_version).


