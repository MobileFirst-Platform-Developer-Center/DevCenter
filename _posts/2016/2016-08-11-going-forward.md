---
title: IBM MobileFirst Platform Foundation 7.1 And Ionic2 - Going forward at your own pace
date: 2016-08-11
version:
- 7.1
tags:
- MobileFirst_Foundation
- Hybrid
- Ionic
author:
  name: Ishai Borovoy
---
## Introduction

We as a human being always look forward to what the future will bring us - we depend on time, and still no one has invented a time machine. Usually, we want to have the newest technology with us, we always want to have the latest software version or the latest mobile phone in our hand. There are many reasons for that and it varies from one person to another.  Some try to go forward like as long distance-runner do, and some as a short-distance runner - fast as they can to achieve the target and keep moving forward, and there are some who choose to walk. So in the end of the day, all of us going forward but in a different pace.

<img alt="long distance-runner" src="{{site.baseurl}}/assets/blog/2016-08-11-going-forward/long-run.jpg" style="float:right;margin: 10px"/>

As you heard (at least if you read the title of this blog) IBM MobileFirst Foundation 8.0 is out and available on the [cloud](https://www.ibm.com/marketplace/cloud/mobile-cloud-applications/us/en-us) and [on-premise](https://mobilefirstplatform.ibmcloud.com/downloads/).

In this blog I want to talk why version 8.0 is your way to moving forward from the hybrid development aspects, but still to let you how that you can get good support with MobileFirst Platform 7.1 for your hybrid development needs. MobileFirst Platform 7.1 the platform introduced a [new ability](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/7.1/hello-world/integrating-mfpf-sdk-in-cordova-applications/) to develop an app as Cordova app and not embedded the Cordova inside the platform as previous versions, it's done by making MobileFirst hybrid a Cordova plugin.  This way gives the developer much more flexibility.  As an example the folder structure of the project is the same as Cordova app which is very important for integration with other frameworks like [Ionic](http://ionicframework.com/). The only thing is that with MFP version 7.1 you are able to works just with Cordova version 3.7.0, and you need to works with [MFP CLI](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/7.1/advanced-client-side-development/using-cli-to-create-build-and-manage-mobilefirst-project-artifacts/) commands (e.g: `mfp cordova emulate`).  As hybrid development support is one of of the platform focus, and with version 8.0 it becomes even better, since IBM MobileFoundation SDK is not longer depends on Cordova version, [click to learn about Cordova development in version 8.0](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/using-the-mfpf-sdk/cordova-apps/).

[Ionic](http://ionicframework.com/) is a leading platform in hybrid mobile app development market, and it gives an easy way to build beautiful and interactive mobile apps using HTML5 and AngularJS. Now [Ionic2](http://ionic.io/2) is out as beta and it gets lot's of attractions.  Ionic2 is based on the newest version of AngularJS, version 2, which is very different from development perspective, it's much more [component](http://learnangular2.com/components/) oriented development hen [controllers](https://docs.angularjs.org/guide/controller) oriented.  There is already good lab about working with [IBM MobileFirst 8.0 and Ionic2](https://mobilefirstplatform.ibmcloud.com/labs/developers/8.0/advancedmessenger/).

In this blog I want to support backward and show how you can works with Ionic2 on top of MFP 7.1 Cordova app.  

There is ready sample which you can work with in the [following link](https://github.com/mfpdev/mfp71-with-ionic2).  

## The technical challenges

What are the challenges to work with MobileFirst Platform 7.1 and Ionic 2:

1. Cordova version needs to be 3.7.0, since that the version MobileFirst Platform 7.1 is compatible with.

2. Ionic2 is Based on AngularJS 2 and working with [TypeScript](https://www.typescriptlang.org/) is the recommended way until ESS6.0(http://www.ecma-international.org/ecma-262/6.0/) will be adopted on the major web browsers.  This is a challenge since TypeScript works with .d.ts(http://definitelytyped.org/guides/best-practices.html) files which used by advanced editors (e.g: [Visual Code](https://www.visualstudio.com/en-us/products/code-vs.aspx)) and [transpilrers](https://www.wikiwand.com/en/Source-to-source_compiler) (e.g: [gulp-typescript](https://www.npmjs.com/package/gulp-typescript)).  

> Handle the above challenges is explained in the sample [README](https://github.com/mfpdev/mfp71-with-ionic2#how-to-create-a-blank-template-of-an-mfp-71-cordova-app-that-uses-ionic2)

## Development process
- The development of the application is mostly done in the `app` folder. The result of it [transpiled](https://www.wikiwand.com/en/Source-to-source_compiler) into inside `www/build` folder.

![App Structure]({{site.baseurl}}/assets/blog/2016-08-11-going-forward/app-structure.png)

- To allow the TypeScript being transpiled automatically on every save open terminal window  in the project root folder and execute the command `gulp watch`.

![gulp watch]({{site.baseurl}}/assets/blog/2016-08-11-going-forward/gulp-watch.png)

- Important: Remember to work with MFP 7.1 CLI commands (e.g: `mfp cordova emulate`) and no directly with Cordova CLI or Ionic CLI.  Working with the Cordova or Ionic CLIs will cause your project damage since MFP 7.1 is compatible with Cordova 3.7.0 version.

>And remember to always going forward ;-), MobileFirst Foundation version 8.0 is already there.
