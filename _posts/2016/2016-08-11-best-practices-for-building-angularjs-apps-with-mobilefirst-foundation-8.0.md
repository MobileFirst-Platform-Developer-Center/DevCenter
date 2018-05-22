---
title: 'Best Practices for building AngularJS apps with MobileFirst Foundation 8.0'
date: 2016-08-11
tags:
  - MobileFirst_Foundation
  - Cordova
  - AngularJS
author:
  name: Yoel Nunez
---

## Overview
In this blog post we cover best practices for building AngularJS apps with MobileFirst. Starting with MobileFirst Platform Foundation 7.1 support for Cordova apps was introduced and in MobileFirst Foundation 8.0 the classic Hybrid application was replaced with the Cordova application model.
f you are an on-premise 7.1 or 8.0 customer or [Mobile Foundation service](https://console.bluemix.net/catalog/services/mobile-foundation) customer, then read further to learn the best practices for building angular js apps with Mobile Foundation.

Cordova applications have a very crucial event, `deviceready`, that indicates the Cordova's API's are fully loaded and ready to use. MobileFirst Foundation 8.0 APIs are loaded as [Cordova plugins]({{site.baseurl}}/tutorials/en/foundation/8.0/application-development/sdk/cordova) and therefore are only available after the `deviceready` event is fired. After the MobileFirst client SDK is loaded, the `wlCommonInit` function is invoked. `wlCommonInit` is defined by the developer as part of the application's code.

> **NOTE:** If you try to access MobileFirst APIs such as `WL.Client.createSecurityCheckChallengeHandler`, `WLResourceRequest`, `WL.Analytics.log`, etc. before `wlCommonInit` is called, a `$function is not defined exception` will be thrown.

* [Bootstrap](#bootstrap)
* [Splash Screen](#splash-screen)
* [App Showcase](#app-showcase)
* [Final Thoughts](#final-thoughts)

## Bootstrap
Angular offers automatic and manual bootstrap for your application. In automatic mode Angular is initialized as soon as the DOM loads and an `ng-app` directive is found. Automatic initialization is ideal when you have all the resources available to you when the DOM is loaded; however, as mentioned before Cordova's and MobileFirst Foundation's APIs are only available after the `deviceready` event is fired.

Manual bootstrap is the recommended approach since it gives us the flexibility to initialize the Angular module at any time, in our case we want to initialize Angular after the `wlCommonInit` function is called.

**init.js**

```
function wlCommonInit() {
	angular.bootstrap(document, ['your-app']);
}
```

**app.js**

```
var app = angular.module('your-app', []);
```

For more info on Angular bootstrap visit [AngularJS: Developer Guide: Bootstrap](https://docs.angularjs.org/guide/bootstrap)

## Splash Screen

By default the splash screen is hidden after the the `deviceready` event is fired and that is usually OK if your view is rendered at that time; however, since we are manually initializing Angular inside of the `wlCommonInit` function then your users will see Angular's double curly brace notation <code>&#123;&#123;&#125;&#125;</code> for a fraction of a second. That is an unpleasant experience for the user and we want to avoid it.

To fix it we can simply set the `AutoHideSplashScreen` property to false in the `config.xml` by adding the following line `<preference name="AutoHideSplashScreen" value="false" />`. This will show the splash screen until we manually invoke the `navigator.splashscreen.hide()` function.

The placement of the `navigator.splashscreen.hide()` function is up to you to decide where it is optimal for your application, you can call it inside `wlCommonInit` or anywhere else in your application; I prefer to call it inside my first controller. Most applications have some type of authentication controller and it is usually the first screen the user sees, so I tend to call `navigator.splashscreen.hide()` inside of the authentication controller i.e.,

```
app.controller('LoginCtrl', function ($scope) {
	navigator.splashscreen.hide();

  // other controller code
});
```

## App Showcase
The MobileFirst Banking App was recently updated to use AngularJS and it follows the recommendations noted in this post. You can find the application by visiting [https://github.com/MobileFirst-Platform-Developer-Center/MobileFirstBankCordova](https://github.com/MobileFirst-Platform-Developer-Center/MobileFirstBankCordova)

<img src="{{site.baseurl}}/assets/blog/2016-08-11-best-practices-for-building-angularjs-apps-with-mobilefirst-foundation-8.0/mobiefirst-bank-cordova.png" alt="mobilefirst banking app" width="300px" title="MobileFirst Bank App Screenshot" />


## Final Thoughts
AngularJS is a very powerful framework and it's single page app design is ideal for MobileFirst Foundation Cordova applications. In this post we covered the best practices of using Angular with a MobileFirst Cordova application, things like manual bootstrap and splash screen management. By following the steps mentioned above you can be sure that MobileFirst's APIs will be available when your Angular services, factories, and providers are initialized.
