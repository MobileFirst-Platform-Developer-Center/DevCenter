---
title: IBM MobileFirst Platform Foundation 7.1 And Ionic 2 - Going forward at your own pace
date: 2016-08-14
version:
- 7.1
tags:
- MobileFirst_Platform
- Hybrid
- Ionic
author:
  name: Ishai Borovoy
additional_authors:
  - Carmel Schindelhaim
---
## Introduction
As human beings, many of us spend a great deal of time thinking about the future. We can’t wait to get our hands on the newest technology, latest software versions, or latest mobile phones. Some of us embrace change more slowly, adopting new technologies when we feel it’s right to do it. Each of us moves towards the future at our own pace - some of us as sprinters, some of us as long distance runners, and others as joggers or walkers. And yet, we all move forward eventually.

<img alt="long distance-runner" src="{{site.baseurl}}/assets/blog/2016-08-14-going-forward/long-run.jpg" style="float:right;margin: 10px"/>

So what does this have to do with building mobile apps? We recently released MobileFirst Foundation 8.0  (available on the [cloud](https://www.ibm.com/marketplace/cloud/mobile-cloud-applications/us/en-us) and [on-premise](https://mobilefirstplatform.ibmcloud.com/downloads/)). If you are doing hybrid development, you’ll appreciate that MobileFirst Foundation 8.0 doesn’t require you to use a specific Cordova version, making it easy to combine it with the latest front-end frameworks &amp; tools. But if you choose to stick with MobileFirst Foundation 7.1 for the time being, you can still enjoy doing hybrid development with the latest technologies, like [Ionic2](http://ionic.io/2). You just have to follow a few more steps, as described in this blog below.

MobileFirst Platform Foundation 7.1 allows you to develop your app as a Cordova app. We did this by providing the MobileFirst hybrid SDK as a set of Cordova plugins, compared to previous versions of MobileFirst Foundation, where Cordova was embedded within the platform. This change was great because as a developer, you got more flexibility. For example, the folder structure of the project of an MobileFirst Foundation hybrid app is the same as that of a Cordova app, making it easy for you to integrate other frameworks like [Ionic](http://ionicframework.com/). However, to work with the newest frameworks, like Ionic2, you still have to do a few tricks, since MobileFirst 7.1 is only compatible with Cordova version 3.7.0 (not later versions), and you have to work with the [MobileFirst Foundation CLI](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/7.1/advanced-client-side-development/using-cli-to-create-build-and-manage-mobilefirst-project-artifacts/), and not with the Cordova or Ionic CLI commands.

[Ionic](http://ionicframework.com/) is a leading platform for hybrid mobile app development. It provides an easy way to build beautiful and interactive mobile apps using HTML5 and AngularJS. Now [Ionic2](http://ionic.io/2) is out in beta, and it’s getting a lot of attention. Ionic2 is based on the newest version of AngularJS, version 2, which is very different from a development perspective, because it is much more [component](http://learnangular2.com/components/) oriented than [controller](https://docs.angularjs.org/guide/controller) oriented. There is already good lab about working with [IBM MobileFirst 8.0 and Ionic2](https://mobilefirstplatform.ibmcloud.com/labs/developers/8.0/advancedmessenger/).

> **Note:** In case you are looking for a sample which shows MFP 7.1 + Angular 2 [here you go](https://github.com/mfpdev/mfp71-with-angular2).

In this blog I want to show how you can work with Ionic2 in an of MFP 7.1 Cordova app.

There is ready sample which you can work with in the [following link](https://github.com/mfpdev/mfp71-with-ionic2).

## The technical challenges
The challenges of combining MobileFirst Platform 7.1 with Ionic 2 are the following:

1. The Cordova version needs to be 3.7.0, since that is the version MobileFirst Platform 7.1 is compatible with.
 
2. Ionic2 is based on AngularJS 2, and working with [TypeScript](https://www.typescriptlang.org/) is recommended until [ESS6.0](http://www.ecma-international.org/ecma-262/6.0/) will be adopted on the major web browsers. This is a challenge because TypeScript works with [.d.ts](http://definitelytyped.org/guides/best-practices.html) files which are used by advanced editors (e.g: [Visual Code](https://www.visualstudio.com/en-us/products/code-vs.aspx)) and [transpilrers](https://www.wikiwand.com/en/Source-to-source_compiler) (e.g: [gulp-typescript](https://www.npmjs.com/package/gulp-typescript)).

> How to deal with the above challenges is explained in the sample [README](https://github.com/mfpdev/mfp71-with-ionic2#how-to-create-a-blank-template-of-an-mfp-71-cordova-app-that-uses-ionic2)

## Development process

- Application development is mostly done in the `app` folder. The result of it [transpiled](https://www.wikiwand.com/en/Source-to-source_compiler) into inside `www/build` folder.
 
![App Structure]({{site.baseurl}}/assets/blog/2016-08-14-going-forward/app-structure.png)
 
- To allow the TypeScript to be transpiled automatically on every save, open terminal window in the project root folder and execute the command `gulp watch`.
 
![gulp watch]({{site.baseurl}}/assets/blog/2016-08-14-going-forward/gulp-watch.png)
 
**Important:** Remember to work with MFP 7.1 CLI commands (e.g: `mfp cordova emulate`) and not directly with the Cordova CLI or Ionic CLI. Working with the Cordova or Ionic CLIs will cause your project damage since MFP 7.1 is compatible only with Cordova 3.7.0.

> And remember, if you want to jump forward ;-) MobileFirst Foundation version 8.0 is already here.
