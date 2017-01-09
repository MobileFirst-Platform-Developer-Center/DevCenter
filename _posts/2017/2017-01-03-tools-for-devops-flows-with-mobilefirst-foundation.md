---
title: Tools for DevOps flows with IBM MobileFirst Foundation 8.0
date: 2017-01-03
tags:
- MobileFirst_Foundation
- DevOps
version: 8.0
author:
  name: Idan Adar
---
## Overview
When we were designing IBM MobileFirst Foundation 8.0, one of our guiding principles was to make sure you can use familiar development tools & follow familiar DevOps processes.  
The following are some enhancements we made that we hope you'll appreciate:

1. Our SDK is delivered as a Cordova plug-in (so you can always use the latest version of Cordova, and integrate in any other Cordova plug-ins you choose).
2. You can use standard package managers for native platforms to create & manage your app builds (such as CocoaPods, Gradle and NuGet).
3. You can use Maven for adapters (to easily and independently integrate libraries in server-side code).
4. We provide both CLI and UI based tools to make it easier for you to transition between DEV, QA, UAT, and Production environments.

The above enhancements make it easier for you &amp; your team to create DevOps flows for a more automated and safe approach to managing your applications, adapters and environments.

In this blog post I will outline the tools and options provided with MobileFirst Foundation 8.0 that you can use to build a DevOps flow that meets your particular needs.

## Cloning an application 
When you want to publish a new version of an application that is integrated with MobileFirst Foundation 8.0, you might want to copy over all the settings from the previous version of your app, such as the scopes, security checks, and other customized options and attributes. For a DevOps flow, there is no IBM-provided CLI path yet, but, thanks to *Jorge Iglesias Fernandez*, you can [use a program he's authored to accomplish this]({{site.baseurl}}/blog/2017/01/09/cloning-application-configuration).

You also have the option to use the **Clone** button from the MobileFirst Operations Console. In the console, select your application version from the sidebar navigation and then select **Clone Version** from the Action dropdown. The end result will be a new instance of the application with a new version and preserved settings.
https://mobilefirstplatform.ibmcloud.com/blog/2017/01/09/cloning-application-configuration/
<img src="{{site.baseurl}}/assets/blog/2017-01-03-tools-for-devops-flows-with-mobilefirst-foundation/cloning.png" alt="Cloning procedure" class="gifplayer"/>

## Targeting adapters and applications to different servers
This section covers what you need to know to "move" your apps and adapters between development servers, QA servers and production servers.

### Applications
Much like cloning, which preserves your application settings, when it comes to applications there are three steps you'll need to follow. Run all of the following commands from the application root folder.

**1. Saving application settings**  
Save the application configuration by running the command:

```bash
mfpdev app pull
```

**2. Registering the application in another server**  
By default the MobileFirst CLI comes with a "default" server profile, which points to a local server (= the server that is part of the [Developer Kit]({{site.baseurl}}/downloads)).  
Before you can register your app to another server, you need to add another server profile for it.

Accomplish this by running the following command and providing the required details:

```bash
mfpdev server add
```

Then, run the following command to register the application version.  
Remember to replace **server-profile** with the server profile name you'll choose:

```bash
mfpdev app register server-profile
```

> Learn more in the [Using MobileFirst CLI to Manage MobileFirst Artifacts]({{site.baseurl}}/tutorials/en/foundation/8.0/application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts/) documentation topic.

**3. Importing application settings**  
With the application now registered in the other server, you can restore its configuration by running the command:

```bash
mfpdev app push
```

### Adapters
<!--As for adapters, the same commands are available for adapters as well: `mfpdev adapter pull` and `mfpdev adapter push`.-->
As for adapters, the same commands are available for adapters as well via Maven.  
These commands pull/push to the MobileFirst Server the adapter configuration, which includes its connectivity details and any custom properties you may have added.

> Learn more in the [Java adapters]({{site.baseurl}}/tutorials/en/foundation/8.0/adapters/javascript-adapters/#pull-and-push-configurations) and [JavaScript adapters]({{site.baseurl}}/tutorials/en/foundation/8.0/adapters/javascript-adapters/#pull-and-push-configurations) documentation topics.

For adapters, the **pull** command creates by default a **config.json** file at the root of the adapter folder. You can then make copies of this file with different names, i.e. **dev.json**, **qa.json**, **uat.json** and **prod.json** and later on use the **push** command (after deploying the adapter) to configure the adapter with a different configuration depending on the required environment.

For example, to push the settings of the UAT environment to a deployed adapter, run the following MobileFirst CLI command: `mfpdev adapter push --configFile | -c path-to-json-file`.

```bash
mfpdev adapter push -c uat.json
```

> **Note:** Make sure you're using MobileFirst CLI with a build number that equals or higher than **8.0.0-2016121916**.

Alternatively, You can accomplish the same using the following **Maven** commands: 

* `mvn adapter:configpull -DmfpfConfigFile=config.json`
* `mvn adapter:configpush -DmfpfConfigFile=config.json`

You can find additional explanation in this [StackOverflow answer](http://stackoverflow.com/questions/40946310/unable-to-build-adapters-using-profiles-and-properties-in-maven/40956730#40956730).

## Bonus
Learn about [continuous devliery of adapters]({{site.baseurl}}/blog/2016/08/25/mobilefirst-devops-in-bluemix/) using the Bluemix DevOps service.
