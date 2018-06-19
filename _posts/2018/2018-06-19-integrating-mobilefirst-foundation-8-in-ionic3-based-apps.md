---
title: Integrating MobileFirst Foundation 8.0 in Ionic v3 based apps
date: 2018-06-19
tags:
- MobileFirst_Foundation  
- iOS
- Android
- Cordova
- Ionic
version: 8.0
author:
  name: Vittal R Pai
---

## Overview
Ionic SDK is a framework built on AngularJS and Apache Cordova that helps you rapidly build hybrid mobile apps using web technologies such as HTML, CSS, and Javascript.

In this blog post, I will walk you through how to create, build, and deploy Ionic version 3.x application implemented with MobileFirst Foundation and run it on mobile & browser platforms.

## Install MobileFirst Components and SDKs

Ensure that you have [NodeJS](https://nodejs.org/en/) and [npm](https://www.npmjs.com/get-npm) downloaded and installed.

- **MobileFirst CLI**

 Install the MobileFirst CLI by running the following command:

	```bash
	npm install -g mfpdev-cli
	```
	
- **Cordova SDK**
	
	Install the Cordova SDK by running the following command:
	
	```bash
	npm install -g cordova
	```

- **Ionic SDK**
	
	Install latest Ionic 3 and Cordova version by running following command:
		
	```bash
	npm install -g cordova ionic
	```
	
- **MobileFirst 8.0 Server**

	Ensure that you have installed and running MobileFirst 8.0 server locally. More details on how to run MFP Server locally is [here](http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/installation-configuration/development/mobilefirst/#mobilefirst-server).



## Create a New Ionic Project
Create a new Ionic 3 project with a blank template by entering the command below.

```bash
ionic start MFPUserLogin blank
```

navigate to application folder add the platform by running following command.

```bash
cd MFPUserLogin
ionic cordova platform add ios
```

**Note** : You can add Android, iOS, Windows and Browser platforms.

## Add the MobileFirst Cordova SDK
The MobileFirst Cordova SDK is provided as a Cordova plugin and can be installed by running:

```bash
ionic cordova plugin add cordova-plugin-mfp
```

You can confirm the installed plugins by entering `ionic plugin list`.

![plugin-list]({{site.baseurl}}/assets/blog/2018-06-19-integrating-mobilefirst-foundation-8-in-ionic3-based-apps/plugin-list.png)


## Register App on MobileFirst Server
Register the application which you have created with MobileFirst 8.0 Server by running following command.

```bash
mfpdev app register
```

> **Note:** Make sure you have your MobileFirst Server running.

Open your MobileFirst console and confirm that your app has been registered.

## Implement the MobileFirst Adapter
MobileFirst adapters provide a way to retrieve and manage data for your mobile client app on the server side.

I’m using the [ResourceAdapter](https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80/ResourceAdapter) to call a resource API and [UserLogin](https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80/UserLogin) for security in this example. 

Download both the adapters and **build** it by running following command

```bash
mfpdev adapter build
```

and **deploy** them onto your MobileFirst server. 

```bash
mfpdev adapter deploy
```

### Security
The URL that gets the balance in the ResourceAdapter is protected by a OAuth Scope named **accessRestricted**.

```java
@OAuthSecurity(scope="accessRestricted")
```

In the **Security** tab of your registered **app** in the MobileFirst Operations Console's dashboard, select the **New** button under the **Scope-Elements Mapping** section.

Enter **accessRestricted** in the scope element and select **UserLogin** in the Custom Security Checks section.

![User Login Security]({{site.baseurl}}/assets/blog/2018-06-19-integrating-mobilefirst-foundation-8-in-ionic3-based-apps/userlogin-security.png)

The above steps needs to be followed for all the platforms which you have added in the application.

### Call your resource adapter

Create a new typescript file with a name **custom.typings.ts** inside `src` folder and add the following code.

```javascript
/// <reference path="../plugins/cordova-plugin-mfp/typings/worklight.d.ts" />
```

Add logic to do resource request call to the resource adapter endpoint in the typescript file of the page which is located at `src/pages/home/home.ts`. The file contents look as below.

``` javascript
import { Component } from '@angular/core';
import { NavController } from 'ionic-angular';

@Component({
  selector: 'page-home',
  templateUrl: 'home.html'
})
export class HomePage {

  balance: string;

  constructor(public navCtrl: NavController) { 
    console.log('--> HomePage constructor')
  }

  getBalance() {
    var resourceRequest = new WLResourceRequest("/adapters/ResourceAdapter/balance",WLResourceRequest.GET);
    resourceRequest.send().then((response) => {
      console.log('-->  getBalance(): Success ', response);
        this.balance = response.responseText;
    },
    function(error){
        console.log('-->  getBalance():  ERROR ', error.responseText);
        console.log(error);
    });
  }
  
}

```
### Update the view
Add the following code in your **home.html** in the `<ion-content padding>` elements:  

```html
<p><button ion-button icon-left outline (click)="getBalance()">
 	<ion-icon name="ios-cloud-upload-outline">
    </ion-icon>Get Balance</button>
</p>
<p>Your Balance : <font color="red"><pre>{{balance}}</pre></font></p>
```

* The **click** action calls the `getBalance` function.  
* To display the value of a variable in your view, you surround it with double curly brackets:

```xml
<pre>{{balance}}</pre>
```

### Add the UserLogin Challenge Handler
When we start the app, we want to go ahead and register the challengeHandler for the UserLogin securityCheck. We will make these changes in the **app.component.ts** file which is located in the path `src/app/app.component.ts`.

```javascript
import { Component, Renderer, ViewChild } from '@angular/core';
import { Platform, App, AlertController } from 'ionic-angular';
import { StatusBar } from '@ionic-native/status-bar';
import { SplashScreen } from '@ionic-native/splash-screen';

import { HomePage } from '../pages/home/home';
@Component({
  templateUrl: 'app.html'
})
export class MyApp {
  rootPage:any = HomePage;
  private UserLoginChallengeHandler: any

  constructor(platform: Platform, statusBar: StatusBar, splashScreen: SplashScreen, renderer: Renderer, public appCtrl: App, public alertCtrl: AlertController) {
    platform.ready().then(() => {
      // Okay, so the platform is ready and our plugins are available.
      // Here you can do any higher level native things you might need.
      statusBar.styleDefault();
      splashScreen.hide();
    });

    // register mfp init function after plugin loaded 
    renderer.listenGlobal('document', 'mfpjsloaded', () => {
      console.log('--> MobileFirst API plugin init complete');
      this.MFPInitComplete();
    });
  }

  // MFP Init complete function
  MFPInitComplete() {
    console.log('--> MFPInitComplete function called');
    this.registerChallengeHandler();  // register a ChallengeHandler callback for UserLogin security check
  }

  registerChallengeHandler() {
    this.UserLoginChallengeHandler = WL.Client.createSecurityCheckChallengeHandler("UserLogin");
    this.UserLoginChallengeHandler.handleChallenge = ((challenge: any) => {
      console.log('--> UserLoginChallengeHandler.handleChallenge called');
      this.displayLoginChallenge(challenge);
    });
  }

  displayLoginChallenge(response) {
    if (response.errorMsg) {
      var msg = response.errorMsg + ' <br> Remaining attempts: ' + response.remainingAttempts;
      console.log('--> displayLoginChallenge ERROR: ' + msg);
    }
    let prompt = this.alertCtrl.create({
      title: 'MFP Login Gateway',
      message: msg,
      inputs: [
        {
          name: 'username',
          placeholder: 'username'
        },
        {
          name: 'password',
          placeholder: 'password',
          type: 'password'
        },
      ],
      buttons: [
        {
          text: 'Login',
          handler: data => {
            console.log('UserLoginChallengeHandler', data.username);
            this.UserLoginChallengeHandler.submitChallengeAnswer(data);
          }
        }
      ]
    });
    prompt.present();
  }
}
```

If you are using the browser platform, add the following code inside `<head>` tag of the **index.html** file which is located in the path `src/index.html`.

```javascript
<script>
  var wlInitOptions = {
  // Options to initialize with the WL.Client object.
  // For initialization options please refer to IBM MobileFirst Platform Foundation Knowledge Center.
   mfpContextRoot : '/mfp', // "mfp" is the default context root in the MobileFirst Development server
   applicationId : 'io.cordova.hellocordova' // Replace with your own app id/package name.
  };
</script>
```

where `mfpContextRoot` is the runtime name of MobileFirst Platform and `applicationId` is the application ID for browser platform.

## Test the Application

Run the app in the mobile or browser by running following command.

- iOS 

	```bash
	ionic cordova prepare
	ionic cordova run ios
	```
- Android

	```bash
	ionic cordova prepare
	ionic cordova run android
	```
- Windows

	```bash
	ionic cordova prepare
	ionic cordova run windows
	```
- Browser

	```bash
	ionic cordova prepare
	ionic cordova run browser
	```
	**Note** : Launch the application on browser which runs on the port **9081** as it runs with proxy which redirects MFP requests to MFP Server. In this sample, the URL looks like `http://localhost:9081/MFPUserLogin/`

Click the **Get Balance** to view the balance amount.

This calls the ResourceAdapter and you will need to enter your authorization. After your username and password is validated, your balance is shown in the app.


![User Login App]({{site.baseurl}}/assets/blog/2018-06-19-integrating-mobilefirst-foundation-8-in-ionic3-based-apps/userlogin-iphone.png)


In this above tutorial, I have demonstrated the security capability of MobileFirst in an Ionic 3.x application.

Source code of the application is available in [Github](https://github.com/vittalpai/mfp-userlogin-ionic).
