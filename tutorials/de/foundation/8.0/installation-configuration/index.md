---
layout: tutorial
title: Installation and Configuration
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Die {{ site.data.keys.product_full }} stellt Entwicklungstools und serverseitige Komponenten bereit, die Sie
lokal vor Ort installieren oder für Test- und Produktionszwecke in der Cloud implementieren können. Lesen Sie die Abschnitte zu dem für Sie zutreffenden
Installationsszenario.

### Setting up a development environment
{: #installing-a-development-environment }
If you develop the client-side or the server-side of mobile applications, use either the [{{ site.data.keys.mf_dev_kit }}](development/mobilefirst/) or the [{{ site.data.keys.mf_bm }} service](../bluemix/using-mobile-foundation) to get started.

**Using the {{ site.data.keys.mf_dev_kit }}**
{: #using-the-dev-kit }

The {{ site.data.keys.mf_dev_kit }} includes everything required to run and debug mobile applications on a personal workstation. To develop an application using the {{ site.data.keys.mf_dev_kit }}, follow the [Setting up the MobileFirst development environment](development/mobilefirst) tutorial.

**Using the {{ site.data.keys.mf_bm }}**
{: #using-mf-bluemix }

The {{ site.data.keys.mf_bm }} service provides functionality similar to the {{ site.data.keys.mf_dev_kit }}, however the service runs on IBM Cloud.

**Setting up the development environment for {{ site.data.keys.product }} applications**
{: #setting-dev-env-mf-apps }

{{ site.data.keys.product }} provides vast flexibility regarding the platforms and tools that can be used to develop {{ site.data.keys.product }} applications. However, some basic setup is required to enable the chosen tools to interact with {{ site.data.keys.product }}.  

Select from the following links to set up the development environment corresponding to the development approach that the application will use:

* [Cordova-Entwicklungsumgebung einrichten](development/cordova)
* [iOS-Entwicklungsumgebung einrichten](development/ios)
* [Android-Entwicklungsumgebung einrichten](development/android)
* [Windows-Entwicklungsumgebung einrichten](development/windows)
* [Xamarin-Entwicklungsumgebung einrichten](development/xamarin)
* [Webentwicklungsumgebung einrichten](development/web)

### Setting up a test or production server on-premises
{: #installing-a-test-or-production-server-on-premises }

The first part of installing the {{ site.data.keys.product }} Server uses an IBM product called IBM Installation Manager. IBM Installation Manager v1.8.4 or later must be installed before installing the {{ site.data.keys.product }} Server components.

> **Wichtiger Hinweis:** Sie müssen
IBM Installation Manager ab Version 1.8.4 verwenden. Die älteren Versionen des
Installation Manager sind nicht in der Lage, {{ site.data.keys.product }} {{ site.data.keys.product_version }}
zu installieren, da für den Installationsabschluss für das Produkt
Java 7 erforderlich ist. Die älteren Versionen des Installation
Manager arbeiten mit Java 6.

The {{ site.data.keys.mf_server }} installation wizard uses IBM Installation Manager to place all of the server components onto the server.  Tools and libraries are also installed that are required to deploy the {{ site.data.keys.product }} Server components to the application server.  As a best practice do not install all of the components on the same application server instance, except in the case of a development server. The deployment tools allow for selection of the components to install.  Please see the [Topologies and Network flows](production/topologies) for points to consider before installing the server.

Please read below for information on preparing and installing {{ site.data.keys.mf_server }} and optional services on your specific environment. For a simple set up, please read [Setting up a test or production environment](production) tutorial.

* [Verifying prerequisites](production/#prerequisites)
* [{{ site.data.keys.mf_server }} components overview](production/topologies)
* Factors to consider, before loading tools and libraries to deploy MobileFirst Server components, and Application Centre optionally
  * Token license
  * MobileFirst Foundation Application Centre
  * Administratormodus und Benutzermodus im Vergleich
* Distribution structure of MobileFirst Server after file loading
* Loading files by
  * using IBM Installation Manager Install wizard
  * running IBM Installation Manager in command line
  * using XML response files - silent installation
* [Configuring backend databases for MobileFirst Foundation Server components](production/databases)
* [Installing MobileFirst Server to an application server](production/appserver)
* [Configuring MobileFirst Server](production/server-configuration)
* [Installing MobileFirst Analytics Server](production/analytics/installation)
* [Installing Application Center](production/appcenter)
* [Deploying MobileFirst Server on IBM PureApplication System](production/pure-application)

### Setting up a test or production environment
{: #setting-up-test-or-production-server}

Learn about the {{ site.data.keys.mf_server }} installation process by going through the instructions to create a functional {{ site.data.keys.mf_server }} cluster with two nodes on WebSphere Application Server Liberty profile. The installation can be completed by using the graphical tools (GUI) or via the command line.

* [GUI mode installation with IBM Installation Manager and the Server Configuration Tool ](production/tutorials/graphical-mode).
* [Command line Installation with command line tool](production/tutorials/command-line).

After completing the installation using either of the two methods above, further [configuration](production/server-configuration) may be required to complete the setup depending on the requirements.

### Setting up optional features on your test or production environment
{: #setting-up-optional-features-test-or-production-server}

{{ site.data.keys.product }} includes optional components that may be used to augment your test or production environment.  Please see the following tutorials for more information:

* [Installing and Configuring the {{ site.data.keys.mf_analytics_server }}](production/analytics/installation/)
* [Installing and Configuring the {{ site.data.keys.mf_app_center }}](production/appcenter)

### Deploying a {{ site.data.keys.mf_server }} test or production environment on the cloud
{: #deploying-mobilefirst-server-test-or-production-on-the-cloud }

If you plan to deploy {{ site.data.keys.mf_server }} to the cloud, see the following options:

* [Using {{ site.data.keys.mf_server }} on IBM Cloud](../bluemix).
* j[{{ site.data.keys.mf_server }} in IBM PureApplication](production/pure-application)

### Upgrade für ältere Versionen
{: #upgrading-from-earlier-versions }
For information about upgrading existing installations and applications to a newer version, see [Upgrading to {{ site.data.keys.product_full }} {{ site.data.keys.product_version }}](../all-tutorials/#upgrading_to_current_version).
