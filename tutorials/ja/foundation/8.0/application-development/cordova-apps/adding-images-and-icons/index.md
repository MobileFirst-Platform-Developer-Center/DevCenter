---
layout: tutorial
title: Cordova アプリケーションへのカスタム・スプラッシュ画面およびアイコンの追加
breadcrumb_title: Adding images and icons
relevantTo: [cordova]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
**cordova-plugin-mfp** プラグインを使用していた場合で、{{ site.data.keys.product_adj }} テンプレートを使用したり、アプリケーションに Cordova **cordova-plugin-splashscreen** プラグインを追加したりしていなかった場合、{{ site.data.keys.product_full }} によって提供されるアイコンおよびスプラッシュ画面のイメージを独自のイメージに置き換えることができます。 テンプレートを使用した場合は、Cordova アプリケーションで使用されるスプラッシュ・イメージが表示されるファイルであるため、それらのスプラッシュ・イメージを置換することができます。

新規フォルダーを作成してスプラッシュ・イメージおよびアイコンを入れ、それらを指すように **config.xml** 構成ファイルを変更してください。

1. Cordova プロジェクトのルート・ディレクトリー内にフォルダーを作成します。 フォルダーは、親フォルダーが Cordova プロジェクトのルートの下にある場合、ネストされたサブフォルダーの任意のレベルに配置可能です。
2. このフォルダーにソースのスプラッシュ・イメージおよびアイコン・イメージを配置します。
3. カスタム・ファイルを指すように **config.xml** 構成ファイルを更新します。

### Android
{: #android }
Android アプリケーションがある場合、スプラッシュ・イメージを識別するための要件は、アプリケーションの作成に {{ site.data.keys.product_adj }} テンプレートを使用したかどうかによって異なります。

#### スプラッシュ画面
{: #splash-screens }
アプリケーションの作成時に {{ site.data.keys.product_adj }} テンプレートを*使用しなかった* 場合、表示されるスプラッシュ・イメージは、{{ site.data.keys.product_adj }} のイメージ・ロケーションから取得されたものです。 テンプレートを使用しない場合、ターゲット・ファイルのパスとファイル名は、例とまったく同じにする必要があります。 ソースのパスとファイル名 (`src`) は、表示するファイルのパスに変更します。 **config.xml** ファイルで、`<platform name="android">` タグと `</platform>` タグの間に以下の例のような行を追加します。

```xml
<update src="res/screen/android/splash-hdpi.9.png" target="res/drawable-hdpi/splash.9.png" />
<update src="res/screen/android/splash-ldpi.9.png" target="res/drawable-ldpi/splash.9.png" />
<update src="res/screen/android/splash-mdpi.9.png" target="res/drawable-mdpi/splash.9.png" />
<update src="res/screen/android/splash-xhdpi.9.png" target="res/drawable-xhdpi/splash.9.png" />
<update src="res/screen/android/splash-xxhdpi.9.png" target="res/drawable-xxhdpi/splash.9.png" />
```

アプリケーションの作成時に {{ site.data.keys.product_adj }} テンプレートを使用した場合は、Cordova が使用するスプラッシュ・イメージを更新する必要があります。 ソースのパスとファイル名 (src) は、表示するファイルのパスに変更します。 config.xml ファイルで、<platform name="android"> タグと </platform> タグの間に以下の例のような行を追加します。

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

#### アイコン
{: #icons }
アイコン・ファイルのファイル名は、以下の例のエントリーと同じでなければなりません。 パスは任意のパスにすることができます。 各イメージの名前は、そのサイズに対応しています。

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
iOS アプリケーションがある場合、`<platform name="ios">` タグと `</platform>` タグの間に以下の例のような行を追加します。

#### スプラッシュ画面
{: #splash-screens-ios }
スプラッシュ画面ファイルのパスとファイル名は、以下の例の名前と同じでなければなりません。 各イメージの名前は、そのサイズに対応しています。

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

#### アイコン
{: #icons-ios}
アイコン・ファイルのファイル名は、以下の例の名前と同じでなければなりません。 パスは任意のパスにすることができます。 各イメージの名前は、そのサイズに対応しています。

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

MobileFirstPlatform Foundation Cordova プラグインのバージョン 8.0.2017102406 以降、`AppDelegate.m` に変更が加えられ、その結果として、`cordova-plugin-mfp` をインストールした状態で Cordova iOS アプリケーションをロードする間は黒い画面が明滅します。ユーザーがこのようなスプラッシュ画面を見たくない場合は、新しい `ViewController` を追加し、`AppDelegate.m` ロードにいくらかの変更を加えることによって、黒いスプラッシュ画面を回避することができます。この処理の手順は以下のとおりです。

1. XCode プロジェクト内で **Classes** フォルダーを右クリックし、**「新規ファイル」**オプションを選択します。
2. **Cocoa Touch Class** テンプレートを選択します。**「次へ」**をクリックします。
3. デフォルト値のままにします (クラス名は *ViewController* になります)。 **「次へ」**をクリックします。
4. **「作成」**をクリックします。ファイル `ViewController.m` および `ViewController.h` が **Classes** フォルダーに追加されます。
5. もう一度 **Classes** フォルダーを右クリックし、**「新規ファイル」**オプションを選択します。
6. **Storyboard** テンプレートを選択します。**「次へ」**をクリックし、`ViewController` という名前で保存し、**「作成」**をクリックします。
7. `ViewController.storyboard` を開き、新しい `ViewController` オブジェクトを追加します。さらに、**「カスタム・クラス」**タブで属性 *Class* を *ViewController* として追加します。**「ID」**タブで、**「Storyboard ID」**および**「Restoration ID」**を *ViewController* として設定します。
8. `AppDelegate.m` を以下のように変更し、アプリケーションをビルドして実行します。これで、黒いスプラッシュ画面の代わりに、白い画面が表示されるようになります。これは *ViewController.storyboard* でカスタマイズ可能です。

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


>**注:** これらの変更は、iOS プラットフォームが削除されてから追加されると失われます。したがって、これらの変更が、必要に応じて、必要になったときに行われるように注意してください。

### Windows
{: #windows }
Windows アプリケーションがある場合、`<platform name="windows">` タグと `</platform>` タグの間に以下の例のような行を追加します。

#### スプラッシュ画面
{: #splash-screens-windows }
スプラッシュ画面ファイルのパスとファイル名は、以下の例の名前と同じでなければなりません。 各イメージの名前は、そのサイズに対応しています。

```xml
<splash src="res/screen/windows/SplashScreen.scale-100.png" width="620" height="300"/>
<splash src="res/screen/windows/SplashScreenPhone.scale-240.png" width="1152" height="1920"/>
<splash src="res/screen/windows/Wide310x150Logo.scale-100.png" width="310" height="150"/>
<splash src="res/screen/windows/Wide310x150Logo.scale-240.png" width="744" height="360"/>
```

#### アイコン
{: #icons-windows }
アイコン・ファイルのファイル名は、以下の例の名前と同じでなければなりません。 パスは任意のパスにすることができます。 各イメージの名前は、そのサイズに対応しています。

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
