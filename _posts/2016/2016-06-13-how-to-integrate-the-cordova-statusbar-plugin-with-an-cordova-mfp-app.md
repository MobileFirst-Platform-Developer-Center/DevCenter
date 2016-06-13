---
title: How to integrate the Cordova Statusbar Plugin with an Cordova MFP App
date: 2016-06-13
tags:
- MobileFirst_Platform
- iOS
- Cordova
version:
- 8.0
- 7.1
author:
  name: Vittal R Pai
---
When you integrate the [cordova-plugin-statusbar](https://cordova.apache.org/docs/en/latest/reference/cordova-plugin-statusbar) to an Cordova MFP v8.0 application on the iOS platform, you might notice that the status bar is not displayed properly in your application.

As MFP sample screenshot with `cordova-plugin-statusbar` and the status bar style set to `blacktranslucent` the output should look as seen here below: 

![cordova-plugin-statusbar-without-issue](https://dl.dropboxusercontent.com/s/ivq523cp82ux9sq/cordova-plugin-statusbar-without-issue.png)

But the way it is rendered is as below:

![cordova-plugin-statusbar-with-issue](https://dl.dropboxusercontent.com/s/5q3mxvpnl2bx7x4/cordova-plugin-statusbar-with-issue.png)

This is because of following reasons:

- MFPAppDelegate of 'cordova-plugin-mfp' is designed to meet the MobileFirst Foundation product requirement of an Cordova app that can contain both hybrid and native screens where it loads `UIViewController` as the root view controller and `CDVViewController` as child view controller.

- This implementation introduce potential friction points with `cordova-plugin-statusbar` that assumes `CDVViewController` is the root view controller.

In order to make `cordova-plugin-statusbar` work as expected, the developer will have to set `CDVViewController` as the root view controller. Replacing the code snippet in the `wlInitDidCompleteSuccessfully` method as suggested below in the MFPAppdelegate.m file of the cordova iOS project will resolve the issue.  


**Existing Snippet:**

```objective_c
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


**Suggested Fix:**

```objective_c
-(void)wlInitDidCompleteSuccessfully
{
   // Create a Cordova View Controller
   CDVViewController* cordovaViewController = [[CDVViewController alloc] init] ;

   cordovaViewController.startPage = [[WL sharedInstance] mainHtmlFilePath];
 
   [self.window setRootViewController:cordovaViewController];
   [self.window makeKeyAndVisible];
}
```  

Your application status bar will now be renedered as expected with cordova-plugin-statusbar without any issues.