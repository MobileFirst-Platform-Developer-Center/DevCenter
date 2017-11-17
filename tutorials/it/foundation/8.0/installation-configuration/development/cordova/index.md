---
layout: tutorial
title: Setting up the Cordova development environment
breadcrumb_title: Cordova
relevantTo: [cordova]
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{: #overview }
To get started with [Cordova (PhoneGap) development](https://cordova.apache.org/) the very basic required step is to install the Cordova CLI. The Cordova CLI is the tool enabling you to create Cordova applications. These applications can be further enhanced by using various 3rd party frameworks and tools such as Ionic, AngularJS, jQuery Mobile and many more. 
With Cordova applications you can use your preferred code editor, such as Atom.io, Visual Studio Code, Eclipse, IntelliJ and others for implementing your applications and adapters.

**Prerequisite:** As you setup your Cordova development environment, make sure to also read the [Setting up the {{ site.data.keys.product_adj }} development environment](../mobilefirst/) tutorial.

## Installing the Cordova CLI
{: #installing-the-cordova-cli }
{{ site.data.keys.product }} supports Apache [Cordova CLI 6.x](https://www.npmjs.com/package/cordova) or greater.  
To install:

1. Download and install [NodeJS](https://nodejs.org/en/).
2. From a **Command-line** window, run the command: `npm install -g cordova`.

## Next steps
{: #next-steps }
To continue with {{ site.data.keys.product_adj }} development in Cordova applications, the {{ site.data.keys.product_adj }} Cordova SDK/plug-ins need to be added to the Cordova application.

* Learn how to add the [{{ site.data.keys.product_adj }} SDK to Cordova applications](../../../application-development/sdk/cordova/).
* For applications development, refer to the [Using the {{ site.data.keys.product }} SDK](../../../application-development/) tutorials.
* For adapters develpment, refer to the [Adapters](../../../adapters/) category.
