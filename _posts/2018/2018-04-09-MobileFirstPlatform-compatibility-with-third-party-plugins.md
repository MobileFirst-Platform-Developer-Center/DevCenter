---
title: MobileFirstPlatform cordova plugin compatibility issues with third-party plugins and their resolutions
date: 2018-04-09
version:
- 8.0
tags:
- MobileFirst_Foundation
- Cordova
author:
  name: Srutha Keerthi
---


## Overview
Often the MobileFirstPlatform (MFP) Cordova plugin (*cordova-plugin-mfp*) is used in combination with other native Cordova plugins (like *cordova-plugin-camera*, *cordova-plugin-splashscreen* etc.) or with other third-party Cordova plugins. The MFP Cordova plugin works seamlessly with native Cordova plugins as the MFP plugin is built to ensure that there are no compatibility issues. 

But in case of third-party plugins, there is a possibility of incompatibility leading to some MFP functionalities not working, some third-party plugin functionalitites not working or both. Below are a few suggestions that can be followed to resolve such conflicts when MFP Cordova plugin is used in combination with various third-party plugins.

> **Note:** The suggestions below do not guarantee to solve incompatibility between all third-party plugins with MFP. These are only commonly observed patterns in third-party plugins that cause issues when used along with the MFP plugin and their possible resolutions.
>
Most of these issues have been observed in iOS platform. Hence the suggestions below are for iOS only. These can be extended to Android, if needed.

## Scenario 1: Third-party plugins replacing *AppDelegate.m*(in iOS) or having their own *AppDelegate.m*
The MFP cordova plugin replaces the application's AppDelegate.m(this file controls most operations that happen during app launch) to include MFP capabilities to the application. If another plugin also replaces the *AppDelegate.m* or has its own AppDelegate file, then the MFP code gets overwritten. 

The solution to this is to merge the code between both these files accordingly. For example :

MFP *AppDelegate.m* contains :

```
-(void)wlInitWebFrameworkDidCompleteWithResult:(WLWebFrameworkInitResult *)result
{
    //MFP related code
}
```

Third-party *AppDelegate.m* contains : 

```
-(void)wlInitWebFrameworkDidCompleteWithResult:(WLWebFrameworkInitResult *)result
{
 	//Third party plugin related code  
}

```

The final *AppDelegate.m* must have the below :

```
-(void)wlInitWebFrameworkDidCompleteWithResult:(WLWebFrameworkInitResult *)result
{
    //MFP related code
    //Third party plugin related code
}
```

> **Note:** Based on what the code does, the third-party code may need to execute before MFP code. It is up to the developer to ensure the right sequence of code execution.


## Scenario 2: Third-party plugins replacing AppDelegate.m(in ios) or having their own AppDelegate.m but both these AppDelegates cannot be merged


It might be possible that due to various dependencies, the *AppDelegate.m* files of plugins cannot be merged into a single file.
In such cases, the developer can use observers after carefully examining the correct flow of execution, which would not break either of the plugins' functionalities. 

For example:

MFP *AppDelegate.m* contains :

```
(void)wlInitWebFrameworkDidCompleteWithResult:(WLWebFrameworkInitResult *)result
{
    //MFP related code
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MFP" object:nil];
}
```
A notification "MFP" is created in the above code.

Third-party *AppDelegate.m* contains : 

```
(void)wlInitWebFrameworkDidCompleteWithResult:(WLWebFrameworkInitResult *)result
{
 	//Third party plugin related code  
 	    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_handleThirdPartyDependentCode) name:@"MFP" object:nil];
 	    //Third party code that needs to wait for the notification

}

```
In the above snippet, the latter part of the third party plugin's method has an observer added that waits for the notification "MFP" to be posted before executing certain code.


## Scenario 3: Third-party plugins use method swizzling 

Method swizzling is used to change a method's implementation during runtime. This is made possible as in Objective-C method invocations can be changed at runtime using the dispatch table of the class . 

Some of the lifecycle methods in *AppDelegate.m* if swizzled by third-party plugins can cause compatibility issues.

You will find the code similar to the below snippet if swizzling has been performed :

```
(void)load
{
    Method original, swizzled;
    
    original = class_getInstanceMethod(self, @selector(oldMethod));
    swizzled = class_getInstanceMethod(self, @selector(swizzled_oldeMethod));
    method_exchangeImplementations(original, swizzled);
}
```

The following are the possible solutions :
 
 1. Copy the entire contents of the swizzled methods into the appropriate methods into MFP's *AppDelegae.m* . Then delete the swizzled methods from the third-party plugin's *AppDelegate.m*. Ensure that the code copied is placed in the right order to avoid unwanted behaviour.
 
 2. Copy the contents of the MFP *AppDelegate.m* methods to the corresponding swizzled methods. 

 3. If the steps 1 and 2 does not solve the issue, use observers across both the *AppDelegate.m* files to maintain an order in the code's execution.
