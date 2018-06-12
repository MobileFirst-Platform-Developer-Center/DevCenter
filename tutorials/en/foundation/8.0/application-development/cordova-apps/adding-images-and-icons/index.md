---
layout: tutorial
title: Adding custom splash screens and icons to Cordova apps
breadcrumb_title: Adding images and icons
relevantTo: [cordova]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{: #overview }
If you used the **cordova-plugin-mfp** plug-in, and you did not use the {{ site.data.keys.product_adj }} template or add the Cordova **cordova-plugin-splashscreen** plug-in to your app, you can replace the images for icons and splash screens that are provided by {{ site.data.keys.product_full }} with your own images. If you used the template, then you can replace the splash images that the Cordova app uses, as they are the files that are displayed.

You must create a new folder to hold the splash images and icons, and modify the **config.xml** configuration file to point to them.

1. Create a folder inside the root directory of your Cordova project. The folder can be in any level of nested subfolder when the parent folder is under the Cordova project root.
2. Place your source splash image and icon images in this folder.
3. Update the **config.xml** configuration file to point to your custom files.

### Android
{: #android }
If you have an Android app, the requirements to for identifying the splash images depends on whether you created the app with or without the {{ site.data.keys.product_adj }} template.

#### Splash screens
{: #splash-screens }
If you did *not* use the {{ site.data.keys.product_adj }} template when you created your app, the splash images that are displayed are those that are retrieved from the {{ site.data.keys.product_adj }} images location. The target file paths and file names must remain exactly as in the example when you do not use the template. Change the source paths and file names (`src`) to the path of the files that you want to display. Add lines similar to the following example between the `<platform name="android">` and `</platform>` tags in the **config.xml** file: 

```xml
<update src="res/screen/android/splash-hdpi.9.png" target="res/drawable-hdpi/splash.9.png" />
<update src="res/screen/android/splash-ldpi.9.png" target="res/drawable-ldpi/splash.9.png" />
<update src="res/screen/android/splash-mdpi.9.png" target="res/drawable-mdpi/splash.9.png" />
<update src="res/screen/android/splash-xhdpi.9.png" target="res/drawable-xhdpi/splash.9.png" />
<update src="res/screen/android/splash-xxhdpi.9.png" target="res/drawable-xxhdpi/splash.9.png" /> 
```

If you used the {{ site.data.keys.product_adj }} template when you created your app, you must update the splash images that Cordova uses. Change the source paths and file names (src) to the path of the files that you want to display. Add lines similar to the following example between the <platform name="android"> and </platform> tags in the config.xml file:

```xml
<splash density="land-hdpi" src="res/screen/android/screen-hdpi-landscape.png" />
<splash density="land-ldpi" src="res/screen/android/screen-ldpi-landscape.png" />
<splash density="land-mdpi" src="res/screen/android/screen-mdpi-landscape.png" />
<splash density="land-xhdpi" src="res/screen/android/screen-xhdpi-landscape.png" />
<splash density="hdpi" src="res/screen/android/screen-hdpi-portrait.png" />
<splash density="ldpi" src="res/screen/android/screen-ldpi-portrait.png" />
<splash density="mdpi" src="res/screen/android/screen-mdpi-portrait.png" />
<splash density="xhdpi" src="res/screen/android/screen-xhdpi-portrait.png" />
```

#### Icons
{: #icons }
The file names of the icon files must be the same as the entries in the following example. The paths can be any path. The name of each image corresponds to its size.

```xml
<icon src="res/icon/android/icon-96-xhdpi.png" />
<icon density="mdpi" src="res/icon/android/icon-48-mdpi.png" />
<icon density="hdpi" src="res/icon/android/icon-72-hdpi.png" />
<icon density="xhdpi" src="res/icon/android/icon-96-xhdpi.png" />
<icon density="xxhdpi" src="res/icon/android/icon-144-xxhdpi.png" />
<icon density="xxxhdpi" src="res/icon/android/icon-192-xxxhdpi.png" />
```

### iOS
{: #ios }
If you have an iOS app, add lines similar to the following example between the `<platform name="ios">` and `</platform>` tags:
    
#### Splash screens
{: #splash-screens-ios }
The paths and file names of the splash screen files must be the same as the names in the following example. The name of each image corresponds to its size.

```xml
<splash height="480" src="res/screen/ios/Default˜iphone.png" width="320" />
<splash height="1024" src="res/screen/ios/Default-Portrait˜ipad.png" width="768" />
<splash height="2048" src="res/screen/ios/Default-Portrait@2x˜ipad.png" width="1536" />
<splash height="768" src="res/screen/ios/Default-Landscape˜ipad.png" width="1024" />
<splash height="1536" src="res/screen/ios/Default-Landscape@2x˜ipad.png" width="2048" />
<splash height="1136" src="res/screen/ios/Default-568h@2x˜iphone.png" width="640" />
<splash height="1334" src="res/screen/ios/Default-667h˜iphone.png" width="750" />
<splash height="2208" src="res/screen/ios/Default-736h˜iphone.png" width="1242" />
<splash height="1242" src="res/screen/ios/Default-736h-Landscape˜iphone.png" width="2208" />
```

#### Icons
{: #icons-ios}
The file names of the icon files must be the same as the names in the following example. The paths can be any path. The name of each image corresponds to its size.

```xml
<icon height="167" src="res/icon/ios/icon-83.5@2x.png" width="167"/>
<icon height="57" src="res/icon/ios/icon.png" width="57" />
<icon height="114" src="res/icon/ios/icon@2x.png" width="114" />
<icon height="40" src="res/icon/ios/icon-40.png" width="40" />
<icon height="80" src="res/icon/ios/icon-40@2x.png" width="80" />
<icon height="50" src="res/icon/ios/icon-50.png" width="50" />
<icon height="100" src="res/icon/ios/icon-50@2x.png" width="100" />
<icon height="60" src="res/icon/ios/icon-60.png" width="60" />
<icon height="120" src="res/icon/ios/icon-60@2x.png" width="120" />
<icon height="180" src="res/icon/ios/icon-60@3x.png" width="180" />
<icon height="72" src="res/icon/ios/icon-72.png" width="72" />
<icon height="144" src="res/icon/ios/icon-72@2x.png" width="144" />
<icon height="76" src="res/icon/ios/icon-76.png" width="76" />
<icon height="152" src="res/icon/ios/icon-76@2x.png" width="152" />
<icon height="29" src="res/icon/ios/icon-small.png" width="29" />
<icon height="58" src="res/icon/ios/icon-small@2x.png" width="58" />
<icon height="87" src="res/icon/ios/icon-small@3x.png" width="87" />
```

Starting from MFP cordova plugin version 8.0.2017102406, a change has been made to the AppDelegate.m and this has been resulting in a flicker of a black screen while loading a cordova ios application with the cordova-plugin-mfp installed. If any user does not wish to see this splashscreen, then they may add a new ViewController and make some changes to the AppDelegate.m load to avoid the black splashscreen. The step by step process to this is as below :

1. In your XCode project, right click on 'Classes' folder and select 'New file' option.
2. Select 'Cocoa Touch Class' template. Click on 'Next'.
3. Leave the default values (Class name will be 'ViewController'). Click on 'Next'.
4. Click on 'Create'. Files 'ViewController.m' and 'ViewController.h' are added to the 'Classes' folder.
5. Again right click on the 'Classes' folder and select 'New file' option.
6. Select 'Storyboard' template. Clieck on 'Next', save it with the name 'ViewController' and click on 'Create'.
7. Open 'ViewController.storyboard' and add a new 'ViewController' object. And add the attributes 'Class' in 'Custom Class' tab as 'ViewController'. In the 'Identity' tab set 'Storyboard ID' and 'Restoration ID' as 'ViewController'.
8. Modify your 'AppDelegate.m' to the below file : 

```
/*
 Licensed Materials - Property of IBM
 
 (C) Copyright 2017 IBM Corp.
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */
/*
 Licensed to the Apache Software Foundation (ASF) under one
 or more contributor license agreements.  See the NOTICE file
 distributed with this work for additional information
 regarding copyright ownership.  The ASF licenses this file
 to you under the Apache License, Version 2.0 (the
 "License"); you may not use this file except in compliance
 with the License.  You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing,
 software distributed under the License is distributed on an
 "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 KIND, either express or implied.  See the License for the
 specific language governing permissions and limitations
 under the License.
 */
#import "AppDelegate.h"
#import <IBMMobileFirstPlatformFoundationHybrid/IBMMobileFirstPlatformFoundationHybrid.h>
#import <IBMMobileFirstPlatformFoundation/WLAnalytics.h>
#import "MainViewController.h"
#import "ViewController.h"
@implementation AppDelegate
NSString* const MFP_INITIALIAZATION = @"WLInitSuccess";
NSString* const OPEN_URL_COMPLETED = @"OpenURLCompleted";
- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
{
    if (NSClassFromString(@"CDVSplashScreen") == nil) {
        [[WL sharedInstance] showSplashScreen];
    }
    // By default splash screen will be automatically hidden once Worklight JavaScript framework is complete.
    // To override this behaviour set autoHideSplash property in initOptions.js to false and use WL.App.hideSplashScreen() API.
   
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
   // UIViewController* rootViewController = self.window.rootViewController;
    
    ViewController *loginController = [[UIStoryboard storyboardWithName:@"ViewController" bundle:nil] instantiateViewControllerWithIdentifier:@"ViewController"]; //or the homeController
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:loginController];
    self.window.rootViewController = navController;
    
    [self.window makeKeyAndVisible];
    
     [[WL sharedInstance] initializeWebFrameworkWithDelegate:self];
//    __block __weak id observer =  [[NSNotificationCenter defaultCenter]addObserverForName:MFP_INITIALIAZATION object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * note) {
//        self.viewController = [[MainViewController alloc] init];
//        self.viewController.startPage = [[WL sharedInstance] mainHtmlFilePath];
//        [super application:application didFinishLaunchingWithOptions:launchOptions];
//        [[NSNotificationCenter defaultCenter] removeObserver:observer name:MFP_INITIALIAZATION object:nil];
//    }];
    return YES;
}
-(void)wlInitWebFrameworkDidCompleteWithResult:(WLWebFrameworkInitResult *)result
{
    if ([result statusCode] == WLWebFrameworkInitResultSuccess) {
        [[WLAnalytics sharedInstance] addDeviceEventListener:NETWORK];
        [[WLAnalytics sharedInstance] addDeviceEventListener:LIFECYCLE];
        [self wlInitDidCompleteSuccessfully];
        //[[NSNotificationCenter defaultCenter] postNotificationName:MFP_INITIALIAZATION object:nil];
    } else {
        [self wlInitDidFailWithResult:result];
    }
}
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
}
-(void)wlInitDidFailWithResult:(WLWebFrameworkInitResult *)result
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"ERROR"
                                                        message:[result message]
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    //wi 116840 - Adding a post notification on mfp_intialization after openurl is executed and an observer notification is received.
    //This is to handle warm-start correctly
    __block __weak id observer = [[NSNotificationCenter defaultCenter]addObserverForName:OPEN_URL_COMPLETED object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * note) {
        [[NSNotificationCenter defaultCenter] postNotificationName:MFP_INITIALIAZATION object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:observer name:OPEN_URL_COMPLETED object:nil];
    }];
    
}
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}
- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
//wi 116840 - The below changes is to fix cold-start in handleopenurl. Only after the MFP_INITIALIZATION observer is returned, the handleopenurl plugin is called.
//This ensures that cold-start behaviour does not face any issues.
// After this, an observer for open_url_completed is initiated. This ensures that in "applicationWillEnterForeground", the action to post notification is completed after openurl is executed.
- (BOOL)application:(UIApplication*)application openURL:(NSURL*)url sourceApplication:(NSString*)sourceApplication annotation:(id)annotation
{
    if (!url) {
        return NO;
    }
    __block __weak id observer = [[NSNotificationCenter defaultCenter]addObserverForName:MFP_INITIALIAZATION object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * note) {
        [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:CDVPluginHandleOpenURLNotification object:url]];
        [[NSNotificationCenter defaultCenter] removeObserver:observer name:MFP_INITIALIAZATION object:nil];
    }];
    [[NSNotificationCenter defaultCenter] postNotificationName:OPEN_URL_COMPLETED object:nil];
    return YES;
}
@end


```
9 . Build and run the application. Now instead of the black splashscreen, a white screen will appear and this can be customized in 'ViewController.storyboard' .

>Note: These changes are bound to be lost if the ios platform is removed and added. Hence please ensure that these changes are made as and when needed.

### Windows
{: #windows }
If you have a Windows app, add lines similar to the lines in the following example between the `<platform name="windows">` and `</platform>` tags:

#### Splash screens
{: #splash-screens-windows }
The paths and file names of the splash screen files must be the same as the names in the following example. The name of each image corresponds to its size.

```xml
<splash src="res/screen/windows/SplashScreen.scale-100.png" width="620" height="300"/>
<splash src="res/screen/windows/SplashScreenPhone.scale-240.png" width="1152" height="1920"/>
<splash src="res/screen/windows/Wide310x150Logo.scale-100.png" width="310" height="150"/>
<splash src="res/screen/windows/Wide310x150Logo.scale-240.png" width="744" height="360"/>
```

#### Icons
{: #icons-windows }
The file names of the icon files must be the same as the names in the following example. The paths can be any path. The name of each image corresponds to its size.

```xml
<icon src="res/icon/windows/Square30x30Logo.scale-100.png" width="30" height="30" />
<icon src="res/icon/windows/Square44x44Logo.scale-100.png" width="44" height="44" />
<icon src="res/icon/windows/Square44x44Logo.scale-240.png" width="106" height="106" />
<icon src="res/icon/windows/Square70x70Logo.scale-100.png" width="70" height="70" />
<icon src="res/icon/windows/Square71x71Logo.scale-100.png" width="71" height="71" />
<icon src="res/icon/windows/Square71x71Logo.scale-240.png" width="170" height="170" />
<icon src="res/icon/windows/Square150x150Logo.scale-100.png" width="150" height="150" />
<icon src="res/icon/windows/Square150x150Logo.scale-240.png" width="360" height="360" />
<icon src="res/icon/windows/Square310x310Logo.scale-100.png" width="310" height="310" />
<icon src="res/icon/windows/StoreLogo.scale-100.png" width="50" height="50" />
<icon src="res/icon/windows/StoreLogo.scale-240.png" width="120" height="120" />
```
