---
layout: tutorial
title: Cordova 앱에 사용자 정의 스플래시 화면 및 아이콘 추가
breadcrumb_title: Adding images and icons
relevantTo: [cordova]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
**cordova-plugin-mfp** 플러그인을 사용했지만 {{ site.data.keys.product_adj }} 템플리트를 사용하지 않았거나 앱에 Cordova **cordova-plugin-splashscreen** 플러그인을 추가하지 않은 경우 {{ site.data.keys.product_full }}에서 제공하는 아이콘 및 스플래시 화면에 대한 이미지를 고유 이미지로 바꿀 수 있습니다. 템플리트를 사용한 경우 표시되는 파일인 Cordova 앱에서 사용하는 스플래시 이미지를 바꿀 수 있습니다.

스플래시 이미지 및 아이콘을 저장할 새 폴더를 작성하고 **config.xml** 구성 파일이 해당 항목을 가리키도록 수정해야 합니다.

1. Cordova 프로젝트의 루트 디렉토리 내에 폴더를 작성하십시오. 상위 폴더가 Cordova 프로젝트 루트 아래에 있는 경우 이 폴더는 임의의 중첩 서브폴더 레벨에 있을 수 있습니다.
2. 소스 스플래시 이미지와 아이콘 이미지를 이 폴더에 저장하십시오.
3. 사용자 정의 파일을 가리키도록 **config.xml** 구성 파일을 업데이트하십시오.

### Android
{: #android }
Android 앱이 있는 경우 스플래시 이미지를 식별하는 데 대한 요구사항은 앱을 작성할 때 {{ site.data.keys.product_adj }} 템플리트를 사용했는지 여부에 따라 다릅니다.

#### 스플래시 화면
{: #splash-screens }
앱을 작성할 때 {{ site.data.keys.product_adj }} 템플리트를 사용하지 *않은* 경우 표시되는 스플래시 이미지는 {{ site.data.keys.product_adj }} 이미지 위치에서 검색되는 스플래시 이미지입니다. 템플리트를 사용하지 않은 경우 대상 파일 경로 및 파일 이름은 예제와 동일하게 유지되어야 합니다. 소스 경로 및 파일 이름(`src`)을 표시하려는 파일의 경로로 변경하십시오. **config.xml** 파일에서 `<platform name="android">` 및 `</platform>` 태그 사이에 다음 예제와 유사한 행을 추가하십시오.

```xml
<update src="res/screen/android/splash-hdpi.9.png" target="res/drawable-hdpi/splash.9.png" />
<update src="res/screen/android/splash-ldpi.9.png" target="res/drawable-ldpi/splash.9.png" />
<update src="res/screen/android/splash-mdpi.9.png" target="res/drawable-mdpi/splash.9.png" />
<update src="res/screen/android/splash-xhdpi.9.png" target="res/drawable-xhdpi/splash.9.png" />
<update src="res/screen/android/splash-xxhdpi.9.png" target="res/drawable-xxhdpi/splash.9.png" />
```

앱 작성 시 {{ site.data.keys.product_adj }} 템플리트를 사용한 경우 Cordova에서 사용하는 스플래시 이미지를 업데이트해야 합니다. 소스 경로 맟 파일 이름(src)을 표시하려는 파일의 경로로 변경하십시오. config.xml 파일에서 <platform name="android"> 및 </platform> 태그 사이에 다음 예제와 유사한 행을 추가하십시오.

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

#### 아이콘
{: #icons }
아이콘 파일의 파일 이름이 다음 예제의 항목과 같아야 합니다. 경로는 임의의 경로일 수 있습니다. 각 이미지의 이름은 크기에 해당합니다.

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
iOS 앱이 있는 경우 `<platform name="ios">` 및 `</platform>` 태그 사이에 다음 예제와 유사한 행을 추가하십시오.

#### 스플래시 화면
{: #splash-screens-ios }
스플래시 화면 파일의 경로와 파일 이름이 다음 예제에 포함된 이름과 같아야 합니다. 각 이미지의 이름은 크기에 해당합니다.

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

#### 아이콘
{: #icons-ios}
아이콘 파일의 파일 이름이 다음 예제에 포함된 이름과 같아야 합니다. 경로는 임의의 경로일 수 있습니다. 각 이미지의 이름은 크기에 해당합니다.

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

MobileFirstPlatform Foundation cordova 플러그인 버전 8.0.2017102406에서 시작하여 `AppDelegate.m`이 변경되었으며 `cordova-plugin-mfp`가 설치된 cordova iOS 애플리케이션을 로드하는 동안 검은색 화면이 깜박입니다. 사용자가 이 스플래시 화면을 보지 않으려면 새 `ViewController`를 추가하고 `AppDelegate.m` 로드를 일부 변경하여 검은색 스플래시 화면을 피할 수 있습니다. 해당 프로세스의 단계는 다음과 같습니다.

1. XCode 프로젝트에서 **클래스** 폴더를 마우스 오른쪽 단추로 클릭하고 **새 파일** 옵션을 선택하십시오.
2. **Cocoa Touch 클래스** 템플리트를 선택하십시오. **다음**을 클릭하십시오.
3. 기본 값(클래스 이름은 *ViewController*임)을 그대로 두십시오. **다음**을 클릭하십시오.
4. **작성**을 클릭하십시오. 파일 `ViewController.m` 및 `ViewController.h`가 **클래스** 폴더에 추가됩니다.
5. **클래스** 폴더를 마우스 오른쪽 단추로 클릭하고 **새 파일** 옵션을 선택하십시오.
6. **스토리보드** 템플리트를 선택하십시오. **다음**을 클릭하고 `ViewController`라는 이름으로 저장한 다음 **작성**을 클릭하십시오.
7. `ViewController.storyboard`를 열고 새 `ViewController` 오브젝트를 추가하십시오. 그리고 **사용자 정의 클래스** 탭에서 속성 *클래스*를 *ViewController*로 추가하십시오. **ID** 탭에서 **스토리보드 ID** 및 **등록 ID**를 *ViewController*로 설정하십시오.
8. 아래와 같이 `AppDelegate.m`을 수정하여 애플리케이션을 빌드하고 실행하십시오. 이제 검은색 스플래시 화면 대신 흰색 화면이 표시되고 *ViewController.storyboard*에서 사용자 정의할 수 있습니다.

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


>**참고:** ios 플랫폼이 제거되거나 추가되면 이러한 변경 사항은 유실됩니다. 그러므로 필요할 때 이러한 변경 사항이 적용되는지 확인하십시오.

### Windows
{: #windows }
Windows 앱이 있는 경우 `<platform name="windows">` 및 `</platform>` 태그 사이에 다음 예제의 행과 유사한 행을 추가하십시오.

#### 스플래시 화면
{: #splash-screens-windows }
스플래시 화면 파일의 경로와 파일 이름이 다음 예제에 포함된 이름과 같아야 합니다. 각 이미지의 이름은 크기에 해당합니다.

```xml
<splash src="res/screen/windows/SplashScreen.scale-100.png" width="620" height="300"/>
<splash src="res/screen/windows/SplashScreenPhone.scale-240.png" width="1152" height="1920"/>
<splash src="res/screen/windows/Wide310x150Logo.scale-100.png" width="310" height="150"/>
<splash src="res/screen/windows/Wide310x150Logo.scale-240.png" width="744" height="360"/>
```

#### 아이콘
{: #icons-windows }
아이콘 파일의 파일 이름이 다음 예제에 포함된 이름과 같아야 합니다. 경로는 임의의 경로일 수 있습니다. 각 이미지의 이름은 크기에 해당합니다.

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
