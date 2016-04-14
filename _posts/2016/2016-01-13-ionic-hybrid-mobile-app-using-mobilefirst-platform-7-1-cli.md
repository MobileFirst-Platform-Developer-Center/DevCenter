---
title: Ionic Hybrid Mobile app using MobileFirst Platform 7.1 CLI
date: 2016-01-13
tags:
- MobileFirst_Platform
- Ionic
- Cordova
version:
- 7.1
author:
  name: Vidyasagar MSC
---

![Ionic preview image](http://vidyasagarmsc.com/wp-content/uploads/2015/12/preview.jpg)

Mobile apps are everywhere and on everyone's learning list. As a web developer, You can leverage your HTML5, Javascript, CSS and other web development technologies like AngarJS to develop mobile apps through [Apache Cordova](http://vidyasagarmsc.com/category/javascript/cordova-javascript). The Ionic framework makes your hybrid mobile app front-end development easy with its open source SDK.

In a simple language, Ionic is a powerf HTML5 SDK that helps you build native-feeling mobile apps using web technologies like HTML, CSS, and Javascript.

[Ionic](http://vidyasagarmsc.com/tag/ionic) also uses AngarJS for a lot of the core functionality of the framework. While you can still use Ionic with just the CSS portion, It's recommended investing in Angar as it’s one of the best ways to build browser-based applications today.

![Sample Ionic app image](http://vidyasagarmsc.com/wp-content/uploads/2015/12/cordova-ng-ionic.png)

MobileFirst Platform (MFP) is an IBM mobile middleware offering also quoted under MADP (Mobile Application Development Platform) and MEAP (Mobile Enterprise Application Platform).

### Setting up MobileFirst Platform CLI
IBM MobileFirst Platform Command Line Interface (CLI) is provided as an alternative to the Studio IDE. You can create and manage MobileFirst native and hybrid apps by using your own preferred text editors or alternative IDEs.

The [procedure to setup]({{site.baseurl}}/downloads/) CLI is very easy and MFP developer edition is completely free for trial purpose.

### Ionic CLI Setup
Personally, I am a CLI guy. So Similar to MFP CLI, I use Ionic CLI and its pretty easy to create an Ionic App.

First of all, you need Node.js 4 to use npm commands. Then, install the latest Cordova and Ionic [Command-line tools](https://npmjs.org/package/ionic). Follow the [Android](http://cordova.apache.org/docs/en/5.1.1/guide/platforms/android/index.html) and [iOS](http://cordova.apache.org/docs/en/5.1.1/guide/platforms/ios/index.html) platform guides to install required platform dependencies.

Once successfly install, Open Terminal on a Linux Machine or Command Prompt on Windows (As an Administrator) and run the following command to confirm Ionic Installation: `ionic info`. If Ionic is properly setup, You shod see the below output with all the required information.

```bash
Your system information:
Cordova CLI: 5.4.1
Ionic CLI Version: 1.7.12
Ionic App Lib Version: 0.6.5
ios-deploy version: Not installed
ios-sim version: 5.0.4
OS: Mac OS X El Capitan
Node Version: v4.2.3
Xcode version: Xcode 7.2 Build version 7C68
```

Now let's bring the awesomeness of MFP into an Ionic app by starting ground up.

Open your Terminal or Command Prompt and let's create a new Ionic App with MFP. Effective MFP CLI V7.1, The hybrid mobile app which you are creating is a Cordova app by defat.

```bash
Vidyasagars-MacBook-Pro:~ VMac$ mfp cordova create
[?] Enter name of app: MFPIonicApp2
[?] Enter the package ID: com.ibm.MFPIonicApp2
[?] Enter the app version: 1.0.0
[?] Select platforms to be supported by your app: android, ios
[?] The following plugins will be automatically added to your app:
cordova-plugin-mfp
org.apache.cordova.device
org.apache.cordova.dialogs
org.apache.cordova.geolocation
org.apache.cordova.globalization
org.apache.cordova.inappbrowser
org.apache.cordova.network-information
Please press enter to continue...
[?] Select additional plugins you wod like to add: cordova-plugin-mfp-jsonstore 7.1.0 "IBM MobileFirst Platform Foundation - JSONStore", cordova-plugin-mfp-push 7.1.0 "IBM MobileFirst Platform Foundation - Push Notifications", org.apache.cordova.battery-status 0.2.12 "Battery", org.apache.cordova.file 1.3.2 "File"
[?] Enter a path to an app template to be added: /Users/VMac/Documents/mfp-ionic-templates-master/blanknic-templates-master/blank
```

If you observe the last command, It looks like pre-built MFP + Ionic templates may be downloaded from GIT. If you think so, your guess is right.

You can find the [templates here](https://github.com/csantanapr/mfp-ionic-templates). Credits: Carlos Santana.

Download the templates as a ZIP and in your command point to the location where you have unzipped the templates on your system.

Once done navigate to the app folder on your Terminal or Command Prompt and run this command: `npm install`. All the packages mentioned in packages.json will be updated.

**Note:** You can learn more about MFP CLI commands and setting up MobileFirst server [here](https://developer.ibm.com/mobilefirstplatform/documentation/getting-started-7-1/foundation/hello-world/integrating-mfpf-sdk-in-cordova-applications/)

![Image of MFP Ionic App Folder structure](http://vidyasagarmsc.com/wp-content/uploads/2015/12/2015-12-30_13-02-40-e1451462516291.jpg)

Navigate to app.js under **www/js** folder and the below code to `wlCommonInit` function

```javascript
WL.Client.connect({
    onSuccess: onConnectSuccess,
    onFailure: onConnectFailure
});
```

Why am I doing this?

* To make your application begin communicating with MobileFirst Server as soon as it starts, use the **WL.Client.connect** method in common/js/app.js inside the wlCommonInit method.
* To make your application communicate with the server at a later stage, call the WL.Client.connect method, as defined in the WL.Client class.

**Note:** Call this method only once, before any other WL.Client methods that communicate with the server. Remember to implement the onSuccess and onFailure callback functions.

Here's the code snippet from app.js:

```javascript
function onConnectSuccess() {
    console.log("Yay!!! Connected to MobileFirst Server");
}

function onConnectFailure() {
    console.log("Failed to Connect");
}

window.MFPClientDefer = angar.injector(['ng']).get('$q').defer();;
window.wlCommonInit = window.MFPClientDefer.resolve;
window.MFPClientDefer.promise.then(function wlCommonInit(){
    // Common initialization code goes here or use the angar service MFPClientPromise
    console.log('MobileFirst Client SDK Initilized');
    mfpMagicPreviewSetup();

    WL.Client.connect({
        onSuccess: onConnectSuccess,
        onFailure: onConnectFailure
    });
});
```
