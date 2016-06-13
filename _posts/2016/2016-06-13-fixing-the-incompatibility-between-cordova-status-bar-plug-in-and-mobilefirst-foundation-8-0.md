---
title: Fixing the incompatibility between Cordova Statusbar Plug-in and MobileFirst Foundation 8.0
date: 2016-06-13
tags:
- MobileFirst_Platform
- iOS
- Cordova
version:
- 8.0
author:
  name: Vittal R Pai
---
When integrating the [cordova-plugin-statusbar](https://cordova.apache.org/docs/en/latest/reference/cordova-plugin-statusbar) to an iOS Cordova application that uses the MobileFirst Cordova SDK for MobileFirst Foundation 8.0, you may notice that the status bar is not displayed properly in your application.

As MFP sample screenshot with `cordova-plugin-statusbar` and the status bar style set to `blacktranslucent` the output should look as seen here below: 

By default, the status bar should display like this:
![cordova-plugin-statusbar-without-issue]({{site.baseurl}}/assets/blog/2016-06-13-fixing-the-incompatibility-between-cordova-status-bar-plug-in-and-mobilefirst-foundation-8-0/expected.png)

But the way it is rendered is like this:

![cordova-plugin-statusbar-with-issue]({{site.baseurl}}/assets/blog/2016-06-13-fixing-the-incompatibility-between-cordova-status-bar-plug-in-and-mobilefirst-foundation-8-0/actual.png)

This is because of following reasons:

* `MFPAppDelegate` of `cordova-plugin-mfp` is designed to meet the MobileFirst Foundation product requirement of a Cordova application that can contain both hybrid and native screens, where it loads the `UIViewController` as the root view controller and `CDVViewController` as child view controller.

* This implementation introduces potential friction points with `cordova-plugin-statusbar` that assumes `CDVViewController` is the root view controller.

In order to make `cordova-plugin-statusbar` work as expected, you will need to set `CDVViewController` as the root view controller. Replacing the code snippet in the `wlInitDidCompleteSuccessfully` method as suggested below in the **MFPAppdelegate.m** file of the cordova iOS project will resolve the issue.  

**Existing snippet:**

```objc
-(void)wlInitDidCompleteSuccessfully
{
   UIViewController* rootViewController = self.window.rootViewController;

   // Create a Cordova View Controller
   CDVViewController* cordovaViewController = [[CDVViewController alloc] init] ;

   cordovaViewController.startPage = [[WL sharedInstance] mainHtmlFilePath];
   
   // Adjust the Cordova view controller view frame to match its parent view bounds
   cordovaViewController.view.frame = rootViewController.view.bounds;

   // Display the Cordova view
   [rootViewController addChildViewController:cordovaViewController];  
   [rootViewController.view addSubview:cordovaViewController.view];
   [cordovaViewController didMoveToParentViewController:rootViewController];  
}
```


**Suggested fix:**

```objc
-(void)wlInitDidCompleteSuccessfully
{
   // Create a Cordova View Controller
   CDVViewController* cordovaViewController = [[CDVViewController alloc] init] ;

   cordovaViewController.startPage = [[WL sharedInstance] mainHtmlFilePath];
 
   [self.window setRootViewController:cordovaViewController];
   [self.window makeKeyAndVisible];
}
```  

Your application status bar will now be renedered as expected with cordova-plugin-statusbar without issues.