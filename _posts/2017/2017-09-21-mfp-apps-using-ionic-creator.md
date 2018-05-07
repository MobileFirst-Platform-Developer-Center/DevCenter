---
title: Rapidly develop MobileFirst apps using Ionic Creator
date: 2017-09-21
tags:
- MobileFirst_Platform
- Mobile_Foundation_Service
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

### Overview

Ionic 3.0 released with Angular 4.0.0 Support and TypeScript 2.1 & 2.2 compatibility in the month of April. More details about new features of Ionic 3.0 can be found in this [blog post](http://blog.ionic.io/ionic-3-0-has-arrived/). Creator is a simple drag & drop tool from Ionic where users can build high quality user interface for Ionic applications. More details about Ionic Creator can be found [here](http://ionic.io/products/creator).


### Prerequisites

* [Knowledge of using Mobile Foundation Service on IBM Cloud](https://console.bluemix.net/catalog/services/mobile-foundation)
* [Knowledge of using MobileFirst CLI](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts/)
* [Knowledge of Ionic framework](https://ionicframework.com/)


### Quick start

In this tutorial, building of an iOS Application using Ionic Creator and application life cycle management using MobileFirst Platform is demonstrated. The development process is divided into three steps.

- [Build Mobile user interface using Ionic Creator](#ionic-creator)
- [Create an Ionic v3 Application](#create-ionic-app)
- [Create a Mobile Foundation service instance, Register the app and Test](#create-mf-service)


### Build Mobile user interface using Ionic Creator
{: #ionic-creator}

- Log in to [Ionic Creator Console](https://dash.readme.io/to/ionic-creator)

- Create a new blank project with any name and the project type as Ionic 3.2.0.

![Create Blank Project]({{site.baseurl}}/assets/blog/2017-09-21-mfp-apps-using-ionic-creator/newproject.png)

- Prepare a user interface by adding buttons, image and header as shown below.

![Prepare UI]({{site.baseurl}}/assets/blog/2017-09-21-mfp-apps-using-ionic-creator/ionic-creator.png)

- Click **Export Your App** option which you can find on top right of the menu & **Download** the project zip file.

![Export Application]({{site.baseurl}}/assets/blog/2017-09-21-mfp-apps-using-ionic-creator/export.png)

### Create an Ionic v3 application
{: #create-ionic-app}

- Create a blank ionic v3 project. Open terminal and type the following command:

	`ionic start mfpsample blank`

	Where *mfpsample* is the project name, *blank* is the name of smallest ionic 3 project template.

- Install iOS Platform by running the following command:

	```bash
	cd mfpsample
	ionic cordova platform add ios
	```

- Add MobileFirst Cordova SDK by running the following command :

	`ionic cordova plugin add cordova-plugin-mfp`

- Go to the newly created `mfpsample` directory in finder, you will see directory called `src` inside.
  * Uncompress the contents of the zip file you exported and downloaded.
  * Copy and paste the contents from your zip export into the src directory.
  * Overwrite the `app` directory, `pages `directory, and `index.html`. This step adds the UI generated using Ionic Creator in the mobile application.

- Add the following snippet inside _**body**_ tag in `index.html` file which is located inside the path `src/index.html`. This is the requirement introduced only from ionic version 3.5.3 onwards.

  ```html
  <script src="build/vendor.js"></script>
  ```
- Add the click functionality to the Ping MFP Server button which is located inside `src/pages/m-fpsample/m-fpsample.html`. The button snippet should look like below.

	```html
	<button id="mFPSample-button1" ion-button (click)="ObtainToken()" color="positive" block>Ping MFP Server !</button>
	```

	> **Note :** Page name may vary in your application as it depends on the name that you have provided while creating the UI in ionic creator.

- Add logic to do OAuth token call with MobileFirst Server in the typescript file of the page which is located at `src/pages/m-fpsample/m-fpsample.ts`. The file contents look as below.

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
> **Note :** Please make sure that you have added the Mobilefirst APIs typescript reference tag in the first line.

 Building of the application is now complete, the next step is to create Mobile Foundation service instance on Bluemix and invoking it from the client application.

### Create MobileFirst Foundation service, Register App and Test
{: #create-mf-service}

- Create a Mobile Foundation service on IBM Cloud following the steps mentioned in [here](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/bluemix/using-mobile-foundation).

- Register the server profile of newly created Mobile Foundation service in MobileFirst CLI by running the following command in the terminal:

	```bash
  mfpdev server add
  ```

	and make the server profile as default.

	![Server Add]({{site.baseurl}}/assets/blog/2017-09-21-mfp-apps-using-ionic-creator/server-add.png)

- Now register the ionic app in MFP Server by running the following command in the terminal:

	```bash
  mfpdev app register
  ```

	This step registers the application in MobileFirst Server.

	![Register Application]({{site.baseurl}}/assets/blog/2017-09-21-mfp-apps-using-ionic-creator/app-register.png)

- Prepare and build the ionic application by running the following command in the terminal:

	```bash
	ionic cordova prepare
	ionic build ios
	```


That is it! We are done building an application, let us test the application.

Open the application in Xcode IDE (`mfpsample/platforms/ios/MyApp.xcodeproj`) & test it on a simulator or a phone device.
<div><center>
<table style="width:100%" cellpadding="0">
  <tr>
    <td><img src="{{site.baseurl}}/assets/blog/2017-09-21-mfp-apps-using-ionic-creator/iphone-screen.png" alt="iphone-screen" border="1" width="100%" /></td>
    <td><img src="{{site.baseurl}}/assets/blog/2017-09-21-mfp-apps-using-ionic-creator/iphone-success.png" alt="iphone-success" border="1" width="100%" /></td>
    <td><img src="{{site.baseurl}}/assets/blog/2017-09-21-mfp-apps-using-ionic-creator/iphone-disable.png" alt="iphone-disable" border="1" width="100%" /></td>
  </tr>
</table>
</center></div>
<br><br>
The entire process is described in the following video:

<div class="sizer">
 <div class="embed-responsive embed-responsive-16by9">
    <iframe src="https://www.youtube.com/embed/2mu8qPFmPjE"></iframe>
  </div>
</div>
<br/>

To include more IBM MobileFirst features to your Ionic application, refer to the tutorials [here](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/cordova-tutorials/).
