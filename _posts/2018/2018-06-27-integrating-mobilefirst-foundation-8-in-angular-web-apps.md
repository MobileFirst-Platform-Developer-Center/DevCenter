---
title: Integrating MobileFirst Foundation 8.0 in Angular 6 web apps
date: 2018-06-27
tags:
- MobileFirst_Foundation  
- Web
- Angular
version: 8.0
author:
  name: Vittal R Pai
---

Angular is a TypeScript based open source front-end web application platform that helps you rapidly build a web application. The latest release of Angular is 6. More details about the new features of Angular 6 can be found in this [blog post](https://blog.angular.io/version-6-of-angular-now-available-cc56b0efa7a4).

This post will walk you through how to create, build Angular version 6 application implemented with MobileFirst Foundation Web SDK and run it on a browser.

## Install MobileFirst Components and SDKs

Ensure that you have [NodeJS](https://nodejs.org/en/) and [npm](https://www.npmjs.com/get-npm) downloaded and installed.

#### MobileFirst CLI

Install the MobileFirst CLI by running the following command:

```bash
npm install -g mfpdev-cli
```

#### Angular CLI

Install latest Angular version 6 CLI by running following command:

```bash
npm install -g @angular/cli
```

#### MobileFirst 8.0 Server

Ensure that you have installed and started latest iFix version of MobileFirst 8.0 server locally. More details on how to run MobileFirst Platform Foundation(MFP) Server locally is [here](http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/installation-configuration/development/mobilefirst/#mobilefirst-server).

## Create a New Angular Project
Create a new Angular 6 project by entering the command below.

```bash
ng new mfp-userlogin-angular
```

## Add the MobileFirst Web SDK

The MobileFirst Web SDK is provided as a npm plugin. Navigate to the application folder and install Mobilefirst Web SDK plugin by running following command:

```bash
cd mfp-userlogin-angular
npm i ibm-mfp-web-sdk --save
```

You can confirm the installed plugins by running following command:
 
``` bash
npm list --depth=0
```

![plugin-list]({{site.baseurl}}/assets/blog/2018-06-27-integrating-mobilefirst-foundation-8-in-angular-web-apps/plugin-list.png)


## Register App on MobileFirst Server

Register the application which you have created with MobileFirst 8.0 Server by running following command.

```bash
mfpdev app register
```
and enter applicationId as `com.mfp.userlogin`.

![mfp-app-register]({{site.baseurl}}/assets/blog/2018-06-27-integrating-mobilefirst-foundation-8-in-angular-web-apps/app-register.png)

> **Note:** Ensure you have your MobileFirst Server running while running the above command.

Open your MobileFirst console and confirm that your app has been registered.

## Implement the MobileFirst Adapter
MobileFirst adapters provide a way to retrieve and manage data for your mobile client app on the server side.

For this tutorial, I am using the [ResourceAdapter](https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80/ResourceAdapter) to call a resource API and [UserLogin](https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80/UserLogin) for security in the project.

Download both the adapters and **build** it by running the following command

```bash
mfpdev adapter build
```

and **deploy** them to your MobileFirst server.

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

![User Login Security]({{site.baseurl}}/assets/blog/2018-06-27-integrating-mobilefirst-foundation-8-in-angular-web-apps/userlogin-security.png)

### Import MobileFirst SDK in Application

Create a new typescript file with a name **custom-typings.d.ts** inside `src` folder and add the following code.

```javascript
/// <reference path="../node_modules/ibm-mfp-web-sdk/lib/typings/ibmmfpf.d.ts"/>
```
These steps enables the app to use MFP APIs in the project.

`Promise` identifier in the MobileFirst Web SDK does not work well with the Angular TypeScript Application as it will throw the duplicate identifier error. Presently, this is a know defect in the MobileFirst Web SDK npm plugin and this issue will be addressed in the upcoming release of the MobileFirst Web SDK.

As a temporary workaround, remove the following code from the `ibmmfpf.d.ts` typescript file which is located at the path `node_modules/ibm-mfp-web-sdk/lib/typings/ibmmfpf.d.ts`. 

```javascript
declare class Promise<T> implements Thenable<T> {
	
	constructor(callback: (resolve: (value?: T | Thenable<T>) => void, reject: (error?: any) => void) => void);

    then<U>(onFulfilled?: (value: T) => U | Thenable<U>, onRejected?: (error: any) => U | Thenable<U>): Promise<U>;
    then<U>(onFulfilled?: (value: T) => U | Thenable<U>, onRejected?: (error: any) => void): Promise<U>;
    
	catch<U>(onRejected?: (error: any) => U | Thenable<U>): Promise<U>;
}

declare namespace Promise {
	
	function resolve<T>(value?: T | Thenable<T>): Promise<T>;

	function reject(error: any): Promise<any>;
	function reject<T>(error: T): Promise<T>;

	function all<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(values: [T1 | Thenable<T1>, T2 | Thenable<T2>, T3 | Thenable<T3>, T4 | Thenable<T4>, T5 | Thenable<T5>, T6 | Thenable<T6>, T7 | Thenable<T7>, T8 | Thenable<T8>, T9 | Thenable<T9>, T10 | Thenable<T10>]): Promise<[T1, T2, T3, T4, T5, T6, T7, T8, T9, T10]>;
    function all<T1, T2, T3, T4, T5, T6, T7, T8, T9>(values: [T1 | Thenable<T1>, T2 | Thenable<T2>, T3 | Thenable<T3>, T4 | Thenable<T4>, T5 | Thenable<T5>, T6 | Thenable<T6>, T7 | Thenable<T7>, T8 | Thenable<T8>, T9 | Thenable<T9>]): Promise<[T1, T2, T3, T4, T5, T6, T7, T8, T9]>;
    function all<T1, T2, T3, T4, T5, T6, T7, T8>(values: [T1 | Thenable<T1>, T2 | Thenable<T2>, T3 | Thenable<T3>, T4 | Thenable<T4>, T5 | Thenable<T5>, T6 | Thenable<T6>, T7 | Thenable<T7>, T8 | Thenable<T8>]): Promise<[T1, T2, T3, T4, T5, T6, T7, T8]>;
    function all<T1, T2, T3, T4, T5, T6, T7>(values: [T1 | Thenable<T1>, T2 | Thenable<T2>, T3 | Thenable<T3>, T4 | Thenable<T4>, T5 | Thenable<T5>, T6 | Thenable<T6>, T7 | Thenable<T7>]): Promise<[T1, T2, T3, T4, T5, T6, T7]>;
    function all<T1, T2, T3, T4, T5, T6>(values: [T1 | Thenable<T1>, T2 | Thenable<T2>, T3 | Thenable<T3>, T4 | Thenable<T4>, T5 | Thenable<T5>, T6 | Thenable<T6>]): Promise<[T1, T2, T3, T4, T5, T6]>;
    function all<T1, T2, T3, T4, T5>(values: [T1 | Thenable<T1>, T2 | Thenable<T2>, T3 | Thenable<T3>, T4 | Thenable<T4>, T5 | Thenable<T5>]): Promise<[T1, T2, T3, T4, T5]>;
    function all<T1, T2, T3, T4>(values: [T1 | Thenable<T1>, T2 | Thenable<T2>, T3 | Thenable<T3>, T4 | Thenable<T4>]): Promise<[T1, T2, T3, T4]>;
    function all<T1, T2, T3>(values: [T1 | Thenable<T1>, T2 | Thenable<T2>, T3 | Thenable<T3>]): Promise<[T1, T2, T3]>;
    function all<T1, T2>(values: [T1 | Thenable<T1>, T2 | Thenable<T2>]): Promise<[T1, T2]>;
    function all<T>(values: (T | Thenable<T>)[]): Promise<T[]>;

	function race<T>(promises: (T | Thenable<T>)[]): Promise<T>;
}
```

Add following code snippet inside `Scripts` tag of **angular.json** file which is located at the root of the project.

```javascript
 "node_modules/ibm-mfp-web-sdk/ibmmfpf.js",
 "node_modules/sjcl/sjcl.js",
 "node_modules/jssha/src/sha.js"
```


### Add code to call resource adapter and handle MFP challenge

Add logic to do resource request call to the resource adapter endpoint and logic to handle challenges from MobileFirst Server in the typescript file of the home page which is located at `src/app/app.component.ts`. The file contents look as below.

``` javascript
import { Component } from '@angular/core';
import './app.component.css';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['app.component.css']
})
export class AppComponent {
  balance: string;
  message: string;

  UserLoginChallengeHandler: WL.Client.SecurityCheckChallengeHandler;
  title = 'MobileFirst UserLogin';
  constructor() {
    WL.Client.init({mfpContextRoot:"/mfp",applicationId:"com.mfp.userlogin"});
    this.MFPInitComplete();
   
  }

  getBalance() {
  var resourceRequest = new WL.ResourceRequest("/adapters/ResourceAdapter/balance",WL.ResourceRequest.GET);
  resourceRequest.send().then(
     (response) => {
      console.log('-->  getBalance(): Success ', response);
      this.balance = 'Your Balance is : ' + response.responseText;
     }, (error) => {
      console.log('-->  getBalance():  ERROR ', error.responseText);
      this.balance = error.responseText;
     }
   )
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
    this.message = response.errorMsg + ' <br> Remaining attempts: ' + response.remainingAttempts;
      console.log('--> displayLoginChallenge ERROR: ' + this.message);
    }
     // set modal open
     var modal = document.querySelector('#loginModal');
     modal.classList.add('open');
     // set overlay
     var overlay = document.querySelector('.overlay');
     overlay.classList.add('show');
  }

  submitChallenge(userId: String, pass: String) {
    var modal = document.querySelector('#loginModal');
    modal.classList.remove("open");
    var overlay = document.querySelector('.overlay');
    overlay.classList.remove('show');
    this.UserLoginChallengeHandler.submitChallengeAnswer({
      username: userId,
      password: pass
    });
  }

}
```

Here `WL.Client.init()` API intializes the SDK, `registerChallengeHandler()` function handles the UserLogin challenges from MobileFirst Server and `getBalance()` function does the resource request call to Resource Adapter.

### Update the view
Replace the content of **app.component.html** with following code. The file is located at the path `src/app/app.component.html`

```html
<div style="text-align:center">
  <h4>
    Welcome to {{ title }}!
  </h4>
</div>
<section class="page-body">
  <h6>Click on Get Balance button to view your account balance.</h6>
  <button mat-button data-target="loginModal" class="modal-trigger waves-effect waves-light btn" (click)="getBalance()" cdkFocusInitial>Get Balance</button>
  <br/>
  <br/>
  <h6>{% raw %}{{ balance }}{% endraw %}</h6>
    <div class="login-container modal" id="loginModal">
        <div class="login-modal modal-content">
          <h4>MobileFirst Login Gateway</h4 >
          <div class="mfp-modal">
              <h6>{% endraw %}{{ message }}{% endraw %}</h6>
              <br/>
              <form class="mfp-form">
                <div class="full-width form-field">
                  <input #userId type="text" placeholder="User Name" value="vittal">
                </div>
                <div class="full-width form-field">
                  <input #pass type="password"  placeholder="Password" value="vittal">
                </div>
              </form>
            </div>
            <br/>
            <div class="action-buttons modal-footer center">
              <button class="modal-close-btn waves-effect waves-light btn" (click)="submitChallenge(userId.value, pass.value)" >Login</button>
            </div>
        </div>
    </div>
</section>
<div class="overlay"></div>
```

* The **Get Balance** action calls the `getBalance` function.  
* To display the value of a variable in your view, you surround it with double curly brackets:

```xml
{% raw %}{{ balance }}{% endraw %}
```

Replace the content of **styles.css** with following code.

```html
/* You can add global styles to this file, and also import other style files */
 .cdk-overlay-container{
    justify-content: center;
    display: flex;
} 

.example-form {
  min-width: 150px;
  max-width: 500px;
  width: 100%;
}

.example-full-width {
  width: 100%;
}

.modal.open{
  z-index: 1003;
  display: block;
  opacity: 1;
  top: 10%;
  transform: scaleX(1) scaleY(1);
}

.center{
  text-align: center !important;
}
.page-body{
  text-align: center;
  padding: 2rem;
}
.overlay{
  position: fixed;
    display: none;
    width: 100%;
    height: 100%;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background-color: rgba(0,0,0,0.5);
    z-index: 2;
    cursor: pointer;
}
.overlay.show{
  display: block !important;
}
```

Add the following snippet inside `<head>` tag of **index.html** file.

```html
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0-rc.2/css/materialize.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0-rc.2/js/materialize.min.js">
</script>
```
## Setup Proxy

MobileFirst Web SDK requires proxy to be setup such that all MobileFirst API Calls needs to be forwarded to the MobileFirst Server.

Create a new json file with a name **proxy.conf.json** inside project folder and add the following code.

```json
{  
   "/mfp": {
      "target": "http://localhost:9080",
      "secure": false
   } 
}
```

The above configuration forwards all the requests which contains `/mfp` in the request path to the mobilefirst server which runs on the port `9080` by default. More details on setting up proxy in Angular Application can be found in the [readme file](https://github.com/angular/angular-cli/blob/master/docs/documentation/stories/proxy.md) of Angular CLI.

## Test the Application

Run the web application in the browser by running the following command. 

```bash
ng serve --proxy-config proxy.conf.json
```

This step launches the web application in the URL `http://localhost:4200/`.

Click the **Get Balance** to view the balance amount.

This  button internally calls the ResourceAdapter and you will need to enter your authorization. After your *username* and *password* is validated, your balance is shown in the app.


![UserLogin-App]({{site.baseurl}}/assets/blog/2018-06-27-integrating-mobilefirst-foundation-8-in-angular-web-apps/angular-app-screen.png)


This tutorial has demonstrated the security capability of MobileFirst in an Angular 6 web application using MobileFirst Web SDK.

Source code of the application is available in [Github](https://github.com/vittalpai/mfp-userlogin-angular).
