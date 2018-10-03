---
layout: tutorial
title: Setting up the Ionic development environment
breadcrumb_title: Ionic
relevantTo: [ionic]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{: #overview }
Ionic is a framework built on [AngularJS](https://angularjs.org/) and [Apache Cordova](https://cordova.apache.org/) that helps you to rapidly build hybrid mobile & web apps using web technologies such as HTML, CSS, and Javascript.

If you are a developer who has chosen Ionic as the framework to develop your mobile or web app, the following sections help you get started with [IBM Mobile Foundation](http://mobilefirstplatform.ibmcloud.com) SDK in your Ionic app.

You can use your preferred code editor such as Atom.io, Visual Studio Code, Eclipse, IntelliJ and others for writing your applications.

**Prerequisite:** As you setup your Ionic development environment, make sure to also read the [Setting up the MobileFirst development environment](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/installation-configuration/development/mobilefirst) tutorial.

## Installing the Ionic CLI
{: #installing_cli }
To get started with Ionic development the first step required is to install the [Ionic CLI](https://ionicframework.com/docs/cli/).

**To install cordova and ionic CLI:**

* Download and install [NodeJS](https://nodejs.org/en/).
* From a Command-line window, run the command:
```bash  
  npm install -g ionic
```  

## Adding the Mobile Foundation SDK to your Ionic app
{: #adding_mfp_ionic_sdk }
To continue with MobileFirst development in Ionic applications, the MobileFirst Cordova SDK or plug-ins need to be added to the Ionic application.

Learn how to add the MobileFirst SDK to Cordova applications.
For application development, refer to the tutorial [Adding the Mobile Foundation SDK to Ionic applications]({{site.baseurl}}/tutorials/en/foundation/8.0/application-development/sdk/ionic).
