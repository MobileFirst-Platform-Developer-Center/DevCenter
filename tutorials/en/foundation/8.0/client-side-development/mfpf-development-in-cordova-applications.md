---
layout: tutorial
title: MobileFirst Platform Foundation development in Cordova applications
relevantTo: [cordova]
weight: 1
---

## Overview
From [http://cordova.apache.org/](http://cordova.apache.org/):
> Apache Cordova is an open-source mobile development framework. It allows you to use standard web technologies such as HTML5, CSS3, and JavaScript for cross-platform development, avoiding each mobile platforms' native development language. Applications execute within wrappers targeted to each platform, and rely on standards-compliant API bindings to access each device's sensors, data, and network status.

IBM MobileFirst Platform Foundation provides an SDK in the form of a standard Cordova plug-in which can be installed in Cordova application. 

> To integrate integrate a Cordova application with the MobileFirst Cordova SDK, review the following tutorial: [Adding the MobileFirst Platform Foundation SDK to Cordova applications](../../adding-the-mfpf-sdk/adding-the-mfpf-sdk-to-cordova-applications)

The MobileFirst SDK feature set provides the following:

* Use MobileFirst <code>ResourceRequest</code> API to retrieve data from backend systems
* Protect applications using the MobileFirst SecurityChecks and other security features such as Application Authentcity Protection
* Ability to navigate and share data between web and native views and/or call Native code using the MobileFirst <code>SendAction</code> API
* Update an application's web resources using Direct Update
* And more...

> For a complete list of MobileFirst SDK abilities [visit the user documentation](http://www-01.ibm.com/support/knowledgecenter/SSHS8R_8.0.0/wl_welcome.html).

### Application development
Cordova applications can be further enhanced using Cordova plug-ins for adding UI elements such as dialogs, tabbars, spinners and the like as well as more advanced functionalities such as Geolocation and more. You can find Cordova plug-ins in the official [Cordova plug-ins repository](https://cordova.apache.org/plugins/), as well as on [GitHub.com](https://github.com) and in popular Cordova blog, such as [Plugreg](http://plugreg.com/).

Example plug-ins:

- [cordova-plugin-dialogs](https://www.npmjs.com/package/cordova-plugin-dialogs)
- [cordova-plug-inprogress-indicator](https://www.npmjs.com/package/cordova-plugin-progress-indicator)
- [cordova-plugin-statusbar](https://www.npmjs.com/package/cordova-plugin-statusbar)

Cordova application development can be further enhanced by using frameworks such as [Ionic](http://ionicframework.com/), [AngularJS](https://angularjs.org/), [jQuery Mobile](http://jquerymobile.com/), [Backbone](http://backbonejs.org/) and others.

> To get started with Cordova applications visit [Cordova's Get Started website](https://cordova.apache.org/#getstarted).

##Tutorials to follow next
Get started by [adding the MobileFirst SDK to your Cordova application](../../adding-the-mfpf-sdk/adding-the-mfpf-sdk-to-cordova-applications), and review MobileFirst-provided features in the [All Tutorials](../../all-tutorials/) section.
