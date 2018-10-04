---
layout: tutorial
title: 将定制启动屏幕和图标添加到 Cordova 应用程序
breadcrumb_title: Adding images and icons
relevantTo: [cordova]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
如果使用 **cordova-plugin-mfp** 插件且未使用 {{ site.data.keys.product_adj }} 模板或向应用程序添加 Cordova **cordova-plugin-splashscreen** 插件，那么可以将 {{ site.data.keys.product_full }} 提供的图标和启动屏幕图像替换为自己的图像。 如果使用模板，那么可替换 Cordova 应用程序使用的启动图像，因为它们是显示的文件。

您必须创建新文件夹以保存启动图像和图标，并修改 **config.xml** 配置文件以指向它们。

1. 在 Cordova 项目的根目录中创建一个文件夹。 在父文件夹位于 Cordova 项目根目录中时，文件夹可处于嵌套子文件夹的任意级别。
2. 将源启动图像和图标图像放入此文件夹中。
3. 更新 **config.xml** 配置文件以指向您的定制文件。

### Android
{: #android }
如果您具有 Android 应用程序，那么标识启动图像的需求取决于创建应用程序时是否使用 {{ site.data.keys.product_adj }} 模板。

#### 启动屏幕
{: #splash-screens }
如果在创建应用程序时*未*使用 {{ site.data.keys.product_adj }} 模板，那么显示的启动图像将是从 {{ site.data.keys.product_adj }} 图像位置检索的图像。 在不使用模板时，目标文件路径和文件名必须仍与示例保持完全相同。 将源路径和文件名 (`src`) 更改为想要显示的文件的路径。 在 **config.xml** 文件的 `<platform name="android">` 和 `</platform>` 标记之间添加类似于以下示例的行：

```xml
<update src="res/screen/android/splash-hdpi.9.png" target="res/drawable-hdpi/splash.9.png" />
<update src="res/screen/android/splash-ldpi.9.png" target="res/drawable-ldpi/splash.9.png" />
<update src="res/screen/android/splash-mdpi.9.png" target="res/drawable-mdpi/splash.9.png" />
<update src="res/screen/android/splash-xhdpi.9.png" target="res/drawable-xhdpi/splash.9.png" />
<update src="res/screen/android/splash-xxhdpi.9.png" target="res/drawable-xxhdpi/splash.9.png" /> 
```

如果在创建应用程序时使用 {{ site.data.keys.product_adj }} 模板，那么必须更新 Cordova 使用的启动图像。 将源路径和文件名 (src) 更改为想要显示的文件的路径。 在 config.xml 文件的 <platform name="android"> 和 </platform> 标记之间添加类似于以下示例的行：

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

#### 图标
{: #icons }
图标文件的文件名必须与以下示例中的条目相同。 路径可以是任何路径。 每个图像的名称对应于其大小。

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
如果您有 iOS 应用程序，那么在 `<platform name="ios">` 和 `</platform>` 标记之间添加类似于以下示例的行：

#### 启动屏幕
{: #splash-screens-ios }
启动屏幕文件的路径和文件名必须与以下示例中的名称相同。 每个图像的名称对应于其大小。

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

#### 图标
{: #icons-ios}
图标文件的文件名必须与以下示例中的名称相同。 路径可以是任何路径。 每个图像的名称对应于其大小。

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

从 MobileFirstPlatform Foundation cordova 插件 V8.0.2017102406 开始，已对 `AppDelegate.m` 进行了更改，这会造成在通过已安装的 `cordova-plugin-mfp` 来装入 cordova iOS 应用程序时闪烁黑屏。如果用户不希望看到这种启动屏幕，那么他们可以添加一个新的 `ViewController`，并对 `AppDelegate.m` 装入进行一些更改以避免出现黑色启动屏幕。此过程的步骤如下：

1. 在 XCode 项目中，右键单击 **Classes** 文件夹，然后选择**新建文件**选项。
2. 选择 **Cocoa Touch Class** 模板。单击**下一步**。
3. 保留缺省值（类名将为 *ViewController*）。单击**下一步**。
4. 单击**创建**。此时会将文件 `ViewController.m` 和 `ViewController.h` 添加到 **Classes** 文件夹。
5. 再次右键单击 **Classes** 文件夹，然后选择**新建文件**选项。
6. 选择 **Storyboard** 模板。单击**下一步**，使用名称 `ViewController` 进行保存，然后单击**创建**。
7. 打开 `ViewController.storyboard`，然后添加一个新的 `ViewController` 对象。在**定制类**选项卡中，添加属性*类*作为 *ViewController*。在**标识**选项卡中，将**故事板标识**和**复原标识**设置为 *ViewController*。
8. 按如下所示修改 `AppDelegate.m`，然后构建并运行应用程序。现在不会再出现黑色启动屏幕，而是显示一个白色屏幕，且此屏幕可在 *ViewController.storyboard* 中进行定制。

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


>**注：**如果移除 ios 平台然后重新添加，这些更改一定会丢失。因此，请确保在需要时进行这些更改。

### Windows
{: #windows }
如果您有 Windows 应用程序，那么在 `<platform name="windows">` 和 `</platform>` 标记之间添加类似于以下示例的行：

#### 启动屏幕
{: #splash-screens-windows }
启动屏幕文件的路径和文件名必须与以下示例中的名称相同。 每个图像的名称对应于其大小。

```xml
<splash src="res/screen/windows/SplashScreen.scale-100.png" width="620" height="300"/>
<splash src="res/screen/windows/SplashScreenPhone.scale-240.png" width="1152" height="1920"/>
<splash src="res/screen/windows/Wide310x150Logo.scale-100.png" width="310" height="150"/>
<splash src="res/screen/windows/Wide310x150Logo.scale-240.png" width="744" height="360"/>
```

#### 图标
{: #icons-windows }
图标文件的文件名必须与以下示例中的名称相同。 路径可以是任何路径。 每个图像的名称对应于其大小。

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
