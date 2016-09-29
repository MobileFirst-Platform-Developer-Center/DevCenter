---
title: Migrating apps and adapters to MobileFirst Foundation 8.0
date: 2016-06-17
tags:
- MobileFirst_Platform
- Migration
version:
- 8.0
author:
  name: Idan Adar
---
With the release of MobileFirst Foundation 8.0 ([in beta form]({{site.baseurl}}/blog/2016/03/31/ibm-mobilefirst-platform-foundation-8-0-beta-is-available/), and now generally available), we also introduced some radical changes:

* Gone are MobileFirst projects you would create in MobileFirst Studio
* Gone are Hybrid apps you would create in those MobileFirst projects
* Gone is generating an SDK for native apps using MobileFirst Studio or MobileFirst CLI
* Gone is deployment of .war and .wlapp files to the MobileFirst Server

But not all is gone! there is plenty of new and improved:

* Registering apps (think "deploying", but don't use that word anymore for apps...) is now simplified and done directly from the MobileFirst Operations Console (or using the MobileFirst CLI)
* You now have full and unrestricted access to the Cordova ecosystem with the introduction of support for standard Cordova apps, made possible thanks to the introducion of the MobileFirst Cordova SDK (in other words, a set of Cordova plug-ins providing the MobileFirst feature set)
* You can use CocoaPods, Gradle and NuGet to add the MobileFirst Native SDKs into native apps (no more copy &amp; paste and manual configuration)
* Adapters are now based on Apache Maven, giving you a standard developmnt path, easing dependency inclusion and management
* Security configuration no longer requires deployment of a .war file, instead you do this straight in the MobileFirst Operation Console
* And lots and lots more

It's a lot of things and to help you migrate your existing applications and adapters to their new form, we've written a cookbook.  
The intention of the cookbook is to provide you with a clear and simple view of the migration steps you'll need to take.

There is also a fair amount of API changes, so in addition to the cookbook to there is also a Migration Assistance tool that will:

* Scan your projects and provide you with an API report detailing potentials actions you should take.
* For Hybrid apps the tool will also generate a Cordova project with all the metadata of the existing app, install the SDK for you and so on

You can read more about the Migration Assistance tool and find the migration steps you need to take, in the [Migration Cookbook]({{site.baseurl}}/tutorials/en/foundation/8.0/migration-cookbook).