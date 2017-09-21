---
title: Rapidly develop MobileFirst apps using Ionic Creator
date: 2017-09-21
tags:
- MobileFirst_Platform 
- iOS
- Android
- Cordova
- Ionic
version:
- 8.0
author: 
  name: Vittal R Pai
---
In this blog post you will learn how to add IBM MobileFirst capability to an Ionic v3 application developed using Ionic Creator.

### Overview:

Ionic 3.0 released with Angular 4.0.0 Support and TypeScript 2.1 & 2.2 compatibility in the month of April. More details about new features of Ionic 3.0 can be found in this [blog](http://blog.ionic.io/ionic-3-0-has-arrived/). Creator is a simple drag & drop tool from Ionic where users can build high quality user interface for Ionic applications. More details about Ionic Creator can be found [here](http://ionic.io/products/creator). 


### Prerequisites:

* [Knowledge of Using Mobile Foundation on Bluemix Service](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/bluemix/using-mobile-foundation/)
* [Knowledge of Using MobileFirst CLI](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts/)
* [Knowledge of Ionic framework](https://ionicframework.com/)


### Quick start:

In this tutorial, we will build an iOS Application using Ionic creator and show application life cycle management using Mobilefirst Platform. I have divided the whole development process into three steps.

- [Build Mobile User interface using Ionic Creator](#ionic-creator)
- [Create an Ionic v3 Application](#create-ionic-app)
- [Create MobileFirst Foundation Service, Register App and Test](#create-mf-service)


### Build Mobile User interface using Ionic Creator
{: #ionic-creator}


- Login to [Ionic Creator Console](https://dash.readme.io/to/ionic-creator)

- Create a new blank project with any name and project type as Ionic 3.2.0.

	![Create Blank Project]({{site.baseurl}}/assets/blog/2017-09-21-mfp-apps-using-ionic-creator/newproject.png)

- Prepare an User interface by adding buttons, image and header as show in the below.

	![Prepare UI]({{site.baseurl}}/assets/blog/2017-09-21-mfp-apps-using-ionic-creator/ionic-creator.png)

- Click on export your app option which you can find on top right of the menu & Download the project zip file.

	![Export Application]({{site.baseurl}}/assets/blog/2017-09-21-mfp-apps-using-ionic-creator/export.png)

### Create an Ionic v3 Application
{: #create-ionic-app}

- Create a blank ionic v3 project. Open terminal and type the following command:

	`ionic start mfpsample blank`
	
	Where mfpsample is our project name, blank is the name of smallest ionic 3 project template.

- Install iOS Platform by running following command:

	```
	cd mfpsample
	ionic cordova platform add ios
	```

- Add Mobilefirst Cordova SDK by running following command :

	`ionic cordova plugin add cordova-plugin-mfp`

- Now go into the newly created mfpsample directory in finder, and you will see directory called "src" inside. Uncompress the contents of the zip file you exported and downloaded. Copy and paste the contents sfrom your zip export into the src directory. You will want to overwrite the app directory, pages directory, and index.html. This step adds the UI generated using Ionic Creator in the mobile application.

- Add the following snippet inside `<body>` tag in index.html file which is located inside the path `src/index.html`.

 `<script src="build/vendor.js"></script>`

- Add the click functionality to the Ping MFP Server button which is located inside `src/pages/m-fpsample/m-fpsample.html`. The button snippet should look like below.

	```
	<button id="mFPSample-button1" ion-button (click)="ObtainToken()" color="positive" block>Ping MFP Server !</button>
	```

	> **Note :** Page name may vary in your application as it depends on the name which you have given while creating UI in ionic creator.

- Add logic to do OAuth token call with MobileFirst Server in the typescript file of the page which is located at `src/pages/m-fpsample/m-fpsample.ts`. The whole file look like as below.

	```typescript
	/// <reference path="../../../plugins/cordova-plugin-mfp/typings/worklight.d.ts" />
	
	import { Component } from '@angular/core';
	import { NavController } from 'ionic-angular';
	
	
	
	@Component({
	  selector: 'page-m-fpsample',
	  templateUrl: 'm-fpsample.html'
	})
	export class MFPSamplePage {
	
	  constructor(public navCtrl: NavController) {
	  }
	
	  ObtainToken() {
	        WLAuthorizationManager.obtainAccessToken(null).then(
	            function(accessToken) {
	                WL.SimpleDialog.show("Success", "You've succesfully connected to MobileFirst Server", [{
	                    text: 'Ok',
	                    handler: null
	                }]);
	            },
	            function(error) {
	                WL.SimpleDialog.show("Failure", "Failed to connect MobileFirst Server", [{
	                    text: 'Ok',
	                    handler: null
	                }]);
	            }
	        );
	    }
	
	}
	```
This step adds the functionality of simple OAuth token fetch call with MobileFirst Server.

We have completed the building of application, the next step is to create Mobile Foundation Service instance on bluemix and invoking it from the client application.

### Create MobileFirst Foundation Service, Register App and Test
{: #create-mf-service}

- Create a Mobile Foundation Service on Blumeix following steps mentioned in [this blog](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/bluemix/using-mobile-foundation).

- Register the server profile of newly created Mobile Foundation Service in MobileFirst CLI by running following command in terminal:

	`mfpdev server register`
	
	and make the server profile as default.
	
	![Server Add]({{site.baseurl}}/assets/blog/2017-09-21-mfp-apps-using-ionic-creator/server-add.png)

- Now register the ionic app in MFP Server by running following command in terminal:

	`mfpdev app register`

	This step registers the application in Mobilefirst Server.
	
	![Register Application]({{site.baseurl}}/assets/blog/2017-09-21-mfp-apps-using-ionic-creator/app-register.png)

- Prepare and build the ionic application by running following command in terminal:

	```
	ionic cordova prepare
	ionic build ios
	```


Thats it !! We are done with building an application, let's test it.

Open the application in Xcode IDE(mfpsample/platforms/ios/MyApp.xcodeproj) & test it on simulator/phone.

<p align="center">
<img src="{{site.baseurl}}/assets/blog/2017-09-21-mfp-apps-using-ionic-creator/iphone-screen.png" width=“200”/>
<img src="{{site.baseurl}}/assets/blog/2017-09-21-mfp-apps-using-ionic-creator/iphone-success.png" width=“200”/>
<img src="{{site.baseurl}}/assets/blog/2017-09-21-mfp-apps-using-ionic-creator/iphone-disable.png" width=“200”/>
</p>


The whole process is described in the following video :
<div class=“sizer”>
    <div class=“embed-responsive embed-responsive-16by9">
        <iframe width="560" height="315" src="https://www.youtube.com/embed/0YaabJmZekE" frameborder="0" allowfullscreen></iframe>
    </div>
</div>

To include more IBM MobileFirst features to your Ionic application, refer to the tutorials [here](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/cordova-tutorials/).