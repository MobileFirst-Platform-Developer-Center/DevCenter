---
title: Social login support for Cordova and Mobile Foundation 8.0
date: 2017-01-12
tags:
- MobileFirst_Foundation
- cordova
- iOS
version:
- 8.0
author:
  name: Mike Billau
additional_authors:
  name: 
 - Vittal R Pai
---
## Fixing the incompatibility between Cordova Google Plus Authentication Plug-in and MobileFirst Foundation on iOS 
When developing a Cordova applications with MobileFirst Foundation, there is often a need to [use third party plug-ins]({{site.baseurl}}/blog/2015/08/03/integrating-3rd-party-cordova-plug-ins/) to achieve advanced functionalty. While it is possible to use [adapters and the Social Login sample]({{site.baseurl}}/blog/2016/04/06/social-login-with-ibm-mobilefirst-platform-foundation/) to log into social platforms, you may also seek to achieve this functionality by only using Cordova plug-ins.

It has recently been discovered that some of these third party Cordova plug-ins do not work well with the Cordova SDK plug-in, especially on iOS. This blog post will explain the incompatibility between "social login" Cordova plug-ins and `cordova-plugin-mfp` as well as provide some workarounds for logging into Google+ and Facebook in your application.

## Problem description
A common use case for mobile applications is authenticating a user with different social media platforms, such as Facebook and Google+. In order to add "social sign-in" capabilities to your Cordova application ([without using an adapter]({{site.baseurl}}/blog/2016/04/06/social-login-with-ibm-mobilefirst-platform-foundation/)), you could search the various Cordova plug-in repositories such as ([Apache Cordova](https://cordova.apache.org/plug-ins/) and [plugreg](http://www.plugreg.com/)) and implement third-party plug-ins like:

- [cordova-plugin-facebook4](https://github.com/gigya/cordova-plugin-facebook4) - Facebook, using Facebook SDK
- [openFB](https://github.com/ccoenraets/OpenFB/) - Facebook, using OAuth
- [cordova-plugin-googleplus](https://github.com/EddyVerbruggen/cordova-plugin-googleplus) - Google+
- [ng-cordova-oauth](https://github.com/nraboy/ng-cordova-oauth) - Oauth, for general/other login

You can read various [descriptions of this problem](https://github.com/jeduan/cordova-plugin-facebook4/issues/166) by [searching the Issues tab](https://github.com/EddyVerbruggen/cordova-plugin-googleplus/issues?utf8=%E2%9C%93&q=is%3Aissue%20is%3Aopen%20openURL) in the various Github repositories, but in general, when the `cordova-plugin-mfp` plug-in is installed (or sometimes even without, for example, certain versions of the Facebook and Google+ plug-ins) you will be unable to programmatically close the login window that appears. Usually, a user is able to actually open a login window and tap in their username/password, but after the authentication request comes back from the third party service, the login window is unable to be closed. As a developer, control does not return back from the InAppBrowser window to your application. Users will generally see a blank screen.

To explain this behavior, we will look at the `cordova-plugin-googleplus` plug-in. This plug-in makes use of the [openURL method](https://github.com/EddyVerbruggen/cordova-plugin-googleplus/blob/master/src/ios/GooglePlus.m) provided by the default `AppDelegate` used in a Cordova application. This method is used by most of the third party Cordova plug-ins to open up the provider's familiar login screen. By setting breakpoints in Xcode, we can see that this method is never called when the `cordova-plugin-mfp` plug-in is installed.

When using  `cordova-plugin-mfp`, MobileFirst Foundation uses the `MFPAppDelegate` instead of `AppDelegate` to allow your MobileFirst Foundation-enabled Cordova application many advanced and unique features, such as containing both hybrid and native screen elements.  Unfortunately, it seems that the `MFPAppDelegate` code was forked and does not contain [an updated openURL method](https://github.com/apache/cordova-ios/blob/master/guides/API%20changes%20in%204.0.md#cdvappdelegateh-new), so the Google Plus authentication plug-in can not return the control back to the application.

# Workaround for Google+ plugin
To fix the integration between `cordova-plugin-googleplus` and `cordova-plugin-mfp` plug-ins, we need to change the Google Plus plugin to implement `MFPAppDelegate` instead of `AppDelegate`, see: [https://github.com/vittalpai/cordova-plugin-googleplus/blob/master/src/ios/GooglePlus.m#L19](https://github.com/vittalpai/cordova-plugin-googleplus/blob/master/src/ios/GooglePlus.m#L19)

## Use Forked Google Plus Plugin
The simplest way to start using the Google+ plug-in is to install our forked version, directly from GitHub and not from the default cordova plug-in repository:

```
cordova plugin add https://github.com/vittalpai/cordova-plugin-googleplus/ --save --variable REVERSED_CLIENT_ID=myreversedclientid
```

That's it! This updated code should work with the `cordova-plugin-mfp` plugin!

## Workaround for other social login plug-ins
To enable social login for other platforms, it is best to use a provided OAuth login flow instead of a Cordova application that might use the `handleOpenURL` method. We recommend using the [`ng-cordova-oauth`](https://github.com/nraboy/ng-cordova-oauth) library to log into other social networking sites, like Facebook, Twitter, etc. This library is built to be used with the Ionic framework - see our other [blog]({{site.baseurl}}/blog/2016/12/26/web-development-using-ionic-2-and-mobile-foundation/) [posts]({{site.baseurl}}/blog/2016/10/17/integrating-mobilefirst-foundation-8-in-ionic2-based-apps/) about using Ionic! If you are not using Ionic, then there are other plug-ins available, such as the [openFB library](https://github.com/ccoenraets/OpenFB/) for Facebook.

> **Note:** The `ng-cordova-oauth` library above has removed support for [Google+ as of 2016](https://github.com/nraboy/ng-cordova-oauth#important-note-about-google), which means that to enable Google+ login functionality in your Cordova application, you need to follow the above workaround.

## White screen and Troubleshooting
When troubleshooting this workaround, it is important to use both the iOS Device log, accessible by **⌘ + /**.  
Also enable the JavaScript console log, accessible by opening up Safari, then clicking **Develop > Simulator > {App Name}**.

> To enable Developer mode, enable the “Show Develop menu in menu bar” setting found in [Safari’s preferences under the Advanced pane](https://developer.apple.com/library/content/documentation/AppleApplications/Conceptual/Safari_Developer_Guide/GettingStarted/GettingStarted.html)

## Check your CSP
When dealing with outgoing network connections of any time, it is always a good idea to review your security settings and policies. Be sure to check out the [Cordova Security Guide](https://cordova.apache.org/docs/en/latest/guide/appdev/security/) for Cordova security.

When testing, the Safari JavaScript console may show the following error message when trying to log in to Google:

```
Refused to execute a script for an inline event handler because 'unsafe-inline' appears in neither the script-src directive nor the default-src directive of the Content Security Policy.
```

The solution is to edit the [Content Security Policy](https://developer.mozilla.org/en-US/docs/Web/HTTP/CSP) in the **index.html** page.

> MobileFirst Foundation provides a variety of different security features, please review the documentation

## iOS Simulator not updating
Sometimes you will be able to build the application just fine, but it doesn't seem to update on the simulator. Check your terminal logs careful - a common mistake is missing the **Info.plist** file from Google:

```
Failed to load Info.plist from bundle at path /Users/mike/Library/Developer/CoreSimulator/Devices/91BE3286-5BB6-4795-BE2F-DE9FB7BAE32C/data/Library/Caches/com.apple.mobile.installd.staging/temp.auvJTI/extracted/Payload/HelloCordova.app/Frameworks/GoogleAppUtilities.framework
```

When this happens, you need to make sure that the **.plist** file you download from the Google Developers console has been installed. The best way to do this is to open the project in Xcode (click on the **/platforms/ios/{ProjectName}.xcodeproj**) and drag the **.plist** file, or just drag it into your **/platforms/ios** folder. **Note:** You will need to add this **plist** file after every time you remove the ios platform or plug-in.

## Conclusion
One of the benefits of aligning the MobileFirst Foundation client SDK more closely with the open source Cordova project is that it opens up a world of opportunities through third party plug-ins. Sometimes not all of these plug-ins will always work well together. In this blog post we showed how to modify the `cordova-plugin-googleplus` plug-in code to work with the MobileFirst Foundation framework and provided a working fork. If you need to use social login features, we still recommend [using an adapter](https://mobilefirstplatform.ibmcloud.com/blog/2016/04/06/social-login-with-ibm-mobilefirst-platform-foundation/) but this method will work if you need a pure Cordova approach.
