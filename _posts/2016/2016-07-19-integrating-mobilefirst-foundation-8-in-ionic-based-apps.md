---
title: Integrating MobileFirst Foundation 8.0 in Ionic-based apps
date: 2016-07-19
tags:
- MobileFirst_Foundation  
- iOS
- Android
- Cordova
- Ionic
version: 8.0
author:
  name: Robert Puryear
---

## Overview
Ionic SDK is a framework built on AngularJS and Apache Cordova that helps you rapidly build hybrid mobile apps using web technologies such as HTML, CSS, and Javascript.

This blog is going to walk you through how to create, build, and deploy Ionic 1 apps implemented with MobileFirst Foundation.


## Install MobileFirst CLI and SDKs
You will need to install the **MobileFirst CLI, the Ionic, and Cordova SDKs as well as have an MobileFirst server running**.

Ensure that you have [NodeJS](https://nodejs.org/en/) downloaded and installed.


#### MobileFirst CLI
Install the MobileFirst CLI by entering the following command:

`npm install -g mfpdev-cli`

#### Ionic SDK
Install the Ionic SDK by entering the following command:

`npm install -g cordova ionic`

#### Cordova SDK
Install the Cordova SDK by entering the following command:

`npm install -g cordova`



## Create a New Ionic Project
Create a new Ionic project with a blank template by entering the command below.

`ionic start myApp blank`

**Ionic automatically adds iOS v3.8 however MobileFirst v8.0 support ios v4.0+. To fix this issue, you will need to remove the ios platform and re-add it.**

###To remove the existing iOS platform:
Change directory into your Ionic project and run:

`ionic platform remove ios`

###To add the latest iOS platform:

`ionic platform add ios@latest`

**If you want to add the android platform, you can add it with:**

`ionic platform add android@latest`


## Add the MobileFirst Cordova SDK
The MobileFirst Cordova SDK is provided as a Cordova plugin and can be installed by running:

`cordova plugin add cordova-plugin-mfp`

You can confirm the installed plugins by entering `ionic plugin list`

![ionic-plugin]({{site.baseurl}}/assets/blog/2016-07-19-integrating-mobilefirst-foundation-8-in-ionic-based-apps/plugins.png)

## Preview the App
You can preview the app in a number of ways.

### Ionic Preview
To view both iOS and Android platforms using the Ionic CLI:

`ionic serve --lab`

![ionic-serve]({{site.baseurl}}/assets/blog/2016-07-19-integrating-mobilefirst-foundation-8-in-ionic-based-apps/serve.png)

This will launch your default browser and will auto-reload if you change any files in the www directory.

### Update Ionic Code

Open the **js/app.js** file.

The module is named **starter**.

`angular.module('starter', ['ionic'])`

The **ng-app** directive on index.html tells angular which code to run on the page.

`<body ng-app="starter">`

To link the view and the model of the app together, **create a controller** in the **app.js** file.

```javascript
	.controller("mainCtrl", function($scope){
	})
```

The `$scope` service allows you to share variables and functions from the controller to the view.

Go back to **index.html**.

Add **ng-controller** to the body tag and include the mainCtrl name. This allows you to use the controller anywhere inside the body tag.

`ng-controller="mainCtrl"`


### Native App Simulator
To preview the app in a native iOS or Android Simulator, you can use the Cordova emulate command:

`cordova emulate`

**The iOS simulator will only be available if you are working on a machine running OS X.**

## Register App on MobileFirst Server

To enable the MobileFirst capabilities such as using the Mobile Browser Simulator to preview the application we need to add some javascript code to connect to the MobileFirst server.

**Note: Make sure you have your MobileFirst server running.**

Open **app.js** and enter the following at the bottom:

```javascript

function wlCommonInit() {
           console.log(">> wlCommonInit() ..." );  
           var serverUrl = WL.App.getServerUrl(function(success){
               console.log(success);
           }, function(fail){
               console.log(fail);
           });
			WLAuthorizationManager.obtainAccessToken().then(
                    function (accessToken) {
                      console.log(">> Success - Connected to MobileFirst Server");          
                    },
                    function (error) {
                      console.log(">> Failed to connect to MobileFirst Server");  
                      console.log(error);        
                    }
            );
    };
```

**Register your app with your MobileFirst server.**

`mfpdev app register`

Open your MobileFirst console and confirm that your app has been registered.



### MobileFirst Preview
To preview the app in a browser or the mobile browser simulator using MobileFirst:

`mfpdev app preview`

Select the mobile browser simulator option.


![ionic-mbs]({{site.baseurl}}/assets/blog/2016-07-19-integrating-mobilefirst-foundation-8-in-ionic-based-apps/mbs.png)

**Note: Currently OAuth isn't fully implemented with the Mobile Browser Simulator MobileFirst v8**

## Implement the MobileFirst Adapter
MobileFirst adapters provide a way to retrieve and manage data for your mobile client app on the server side.

I’m using the [ResourceAdapter](https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80/ResourceAdapter) to call a resource API and [PinCodeAdapter](https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80/PinCodeAttempts) for security in this example.

You should first **build** and **deploy** them onto your MobileFirst server:

`mfpdev adapter build`

`mfpdev adapter deploy`

### Security
The url that gets the balance in the ResourceAdapter is protected by a security check named “accessRestricted”.

`@OAuthSecurity(scope="accessRestricted")`

In the **Security** tab of your registered **app** in the MobileFirst dashboard, select the **New** button under the **Scope-Elements Mapping** section.

Enter **accessRestricted** in the scope element and select **PinCodeAttempts** in the Custom Security Checks section.

### Call your resource adapter
Add the following code to your **mainCtrl controller** to call make the adapter call:

```javascript
  $scope.balance = "";
  $scope.getAdapter = function(){
	var resourceRequest = new WLResourceRequest("/adapters/ResourceAdapter/balance",
                WLResourceRequest.GET
            );
    resourceRequest.send().then(
                  function(response){
                     $scope.balance = response.responseText;
                     $scope.$apply();
                  },
                  function(error){
                      console.log(error);
                  }
              );
  };

```

We have defined the **balance** variable that will hold the value we get back from the adapter call. We have also defined the **getAdapter** variable which is the function where we actually call the adapter and get the balance.

### Update the view
Add the following code in your **index.html** in the `<ion-content>` elements:

`<h3>Check your account balance</h3> `

`<button ng-click="getAdapter()" class="button button-block button-balanced">Submit</button>`

`<h3>Balance: {{ balance }}</h3>`

The **ng-click** directive calls the getAdapter function.

To display the value of a **$scope** variable in your view, you surround it with double curly brackets

`{{ balance }}`

### Add the Challenge Handler

Add [ChallengeHandler.js](https://github.com/MobileFirst-Platform-Developer-Center/PinCodeCordova/tree/release80/www/js) in your project in the js directory.

Reference the script in **index.html**.

`<script src="js/ChallengeHandler.js"></script>`

Call the challenge handler in wlCommonInit to handle the security check.

`PinCodeChallengeHandler()`


## Test the App

Run the app in the simulator using Cordova since we are using OAuth security.

`cordova emulate`

![ionic-launch]({{site.baseurl}}/assets/blog/2016-07-19-integrating-mobilefirst-foundation-8-in-ionic-based-apps/launch.png)

Click the **Submit button** to get your balance.

This will call the PinCode adapter and you will need to enter your authorization.

![ionic-pincode]({{site.baseurl}}/assets/blog/2016-07-19-integrating-mobilefirst-foundation-8-in-ionic-based-apps/pincode.png)

**The default pin code is 1234. You can update this in the console under the PinCodeAttempts adapter > Security Check.**  

After your code is validated, your balance is shown in the app.

![ionic-balance]({{site.baseurl}}/assets/blog/2016-07-19-integrating-mobilefirst-foundation-8-in-ionic-based-apps/balance.png)
