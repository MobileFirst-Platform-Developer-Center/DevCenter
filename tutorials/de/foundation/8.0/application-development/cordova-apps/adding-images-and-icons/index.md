---
layout: tutorial
title: Angepasste Begrüßungsanzeigen und Symbole zu Cordova-Apps hinzufügen
breadcrumb_title: Adding images and icons
relevantTo: [cordova]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Wenn Sie das Plug-in **cordova-plugin-mfp** und nicht die
{{ site.data.keys.product_adj }}-Schablone verwendet haben oder das Cordova-Plug-in
**cordova-plugin-splashscreen** zu Ihrer App hinzufügen, können Sie die Bilder der
{{ site.data.keys.product_full }} für Symbole und Begrüßungsanzeigen durch Ihre eigenen
Bilder ersetzen. Wenn Sie die Schablone verwendet haben, können Sie die von der Cordova-App verwendeten und angezeigten Begrüßungsbilder
ersetzen. 

Sie müssen einen neuen Ordner für die Begrüßungsbilder und Symbole erstellen und die Konfigurationsdatei
**config.xml** so modifizieren, dass sie auf die Anzeigen und Symbole zeigt. 

1. Erstellen Sie einen Ordner im Stammverzeichnis Ihres Cordova-Projekts.Der Ordner kann sich auf einer Verschachtelungsebene eines Unterordners befinden, solange sich der übergeordnete Ordner im Cordova-Projektstammverzeichnis
befindet. 
2. Stellen Sie Ihre Quellenbegrüßungsbilder und -symbole in diesen Ordner. 
3. Aktualisieren Sie die Konfigurationsdatei **config.xml** so, dass sie auf Ihre angepassten Dateien
zeigt. 

### Android
{: #android }
Wenn Sie eine Android-App haben, richten sich die Anforderungen für die Identifikation der Begrüßungsbilder danach, ob Sie die App
mit der
{{ site.data.keys.product_adj }}-Schablone oder ohne sie erstellt haben. 

#### Begrüßungsanzeigen
{: #splash-screens }
Wenn Sie Ihre App *nicht* mit der {{ site.data.keys.product_adj }}-Schablone
erstellt haben, werden die von der
{{ site.data.keys.product_adj }}-Bildposition abgerufenen Begrüßungsbilder
angezeigt. Die Zieldateipfade und -dateinamen müssen exakt aus dem Beispiel übernommen
werden, wenn Sie die Schablone nicht verwenden. Ändern Sie die Quellenpfade und Dateinamen
(`src`) in die Pfade der Dateien, die angezeigt werden sollen. Fügen Sie in der Datei **config.xml** zwischen den Tags `<platform name="android">` und `</platform>` Zeilen wie die im folgenden Beispiel hinzu: 

```xml
<update src="res/screen/android/splash-hdpi.9.png" target="res/drawable-hdpi/splash.9.png" />
<update src="res/screen/android/splash-ldpi.9.png" target="res/drawable-ldpi/splash.9.png" />
<update src="res/screen/android/splash-mdpi.9.png" target="res/drawable-mdpi/splash.9.png" />
<update src="res/screen/android/splash-xhdpi.9.png" target="res/drawable-xhdpi/splash.9.png" />
<update src="res/screen/android/splash-xxhdpi.9.png" target="res/drawable-xxhdpi/splash.9.png" /> 
```

Wenn Sie Ihre App mit der {{ site.data.keys.product_adj }}-Schablone erstellt haben, müssen Sie
die von Cordova verwendeten Begrüßungsbilder aktualisieren. Ändern Sie die Quellenpfade und Dateinamen
(src) in die Pfade der Dateien, die angezeigt werden sollen. Fügen Sie in der Datei config.xml zwischen den Tags <platform name="android"> und </platform> Zeilen wie die im folgenden Beispiel hinzu: 

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

#### Symbole
{: #icons }
Die Namen der Symboldateien müssen die gleichen wie im folgenden Beispiel sein. Die Pfade können beliebige sein. Der Name der einzelnen Bilder richtet sich nach ihrer
Größe. 

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
Wenn Sie eine iOS-App haben, fügen Sie Zeilen ähnlich den folgenden zwischen den Tags `<platform name="ios">` und `</platform>` ein: 

#### Begrüßungsanzeigen
{: #splash-screens-ios }
Die Dateipfade und -namen der Begrüßungsanzeigen müssen die gleichen wie im folgenden Beispiel sein. Der Name der einzelnen Bilder richtet sich nach ihrer
Größe. 

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

#### Symbole
{: #icons-ios}
Die Namen der Symboldateien müssen die gleichen wie im folgenden Beispiel sein. Die Pfade können beliebige sein. Der Name der einzelnen Bilder richtet sich nach ihrer
Größe. 

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

Seit der Cordova-Plug-in Version 8.0.2017102406 für die MobileFirst Platform Foundation gibt es eine Änderung in `AppDelegate.m`, die notwendig war, weil bei installiertem Plug-in `cordova-plugin-mfp` eine schwarze flimmernde Anzeige erschien, sobald die Cordova-iOS-Anwendung geladen wurde. Wenn ein Benutzer dieser Begrüßungsanzeige nicht sehen möchte, kann er einen neuen `ViewController` hinzufügen und einige Änderungen am Ladevorgang in `AppDelegate.m` vornehmen, um eine schwarze Begrüßungsanzeige zu vermeiden. Die erforderlichen Schritte sind nachfolgend beschrieben:

1. Klicken Sie in Ihrem Xcode-Projekt mit der rechten Maustaste auf den Ordner **Classes** und wählen Sie die Option **New file** aus.
2. Wählen Sie die Schablone **Cocoa Touch Class** aus. Klicken Sie auf **Next**.
3. Übernehmen Sie die Standardwerte (d. h. den Klassennamen *ViewController*). Klicken Sie auf **Next**.
4. Klicken Sie auf **Create**. Die Dateien `ViewController.m` und `ViewController.h` werden zum Ordner **Classes** hinzugefügt.
5. Klicken Sie erneut mit der rechten Maustaste auf den Ordner **Classes** und wählen Sie die Option **New file** aus.
6. Wählen Sie die Schablone **Storyboard** aus. Klicken Sie auf **Next** und speichern Sie die Schablone unter dem Namen `ViewController`. Klicken Sie dann auf **Create**.
7. Öffnen Sie `ViewController.storyboard` und fügen Sie ein neues Objekt `ViewController` hinzu. Fügen Sie die Attributklasse auf der Registerklasse **Custom Class** als *ViewController* hinzu. Geben Sie auf der Registerkarte **Identity** *ViewController* für die **Storyboard ID** und die **Restoration ID** an.
8. Modifizieren Sie Ihre Datei `AppDelegate.m` wie unten angegeben. Erstellen Sie dann die Anwendung und führen Sie sie aus. Anstelle der schwarzen Begrüßungsanzeige müssten Sie jetzt eine weiße Anzeige sehen, die Sie in *ViewController.storyboard* anpassen können.

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
      // Standardmäßig wird die Begrüßungsanzeige automatisch ausgeblendet, sobald das Worklight-JavaScript-Framework abgeschlossen ist.
      // Sie können dieses Verhalten überschreiben, indem Sie die Eigenschaft autoHideSplash in initOptions.js auf "false" setzen und die API WL.App.hideSplashScreen() verwenden.

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

      // Cordova ViewController erstellen
      CDVViewController* cordovaViewController = [[CDVViewController alloc] init] ;

      cordovaViewController.startPage = [[WL sharedInstance] mainHtmlFilePath];

      // Anzeigerahmen des Cordova ViewController an die übergeordnete Anzeigebegrenzung anpassen
      cordovaViewController.view.frame = rootViewController.view.bounds;

      // Cordova-Ansicht anzeigen
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
      // Senden, wenn die Anwendung vom aktiven in den inaktiven Zustand wechselt. Dies kann bei bestimmten Arten von temporären Unterbrechungen geschehen (z. B. bei einem eingehenden Anruf oder einer eingehenden SMS) oder wenn der Benutzer die Anwendung beendet und diese in den Hintergrund gestellt wird.
      // Stoppen Sie mit dieser Methode laufende Aufgaben, inaktivieren Sie Zeitgeber und drosseln Sie die OpenGL-ES-Volldbildrate. Bei Spielen kann mit dieser Methode das Spiel angehalten werden.
  }
  - (void)applicationDidEnterBackground:(UIApplication *)application
  {
      // Verwenden Sie diese Methode, um gemeinsam genutzte Ressourcen freizugeben, Benutzerdaten zu speichern, Zeitgeber zu inaktivieren und so viele Informationen zum Zustand der Anwendung zu speichern, dass eine Wiederherstellung des aktuellen Zustands möglich ist, wenn die Anwendung später beendet wird.
      // Wenn Ihre Anwendung die Ausführung im Hintergrund unterstützt, wird diese Methode anstelle von applicationWillTerminate: aufgerufen, wenn der Benutzer die Anwendung beendet.
  }
  - (void)applicationWillEnterForeground:(UIApplication *)application
  {
      // Als Teil des Übergangs vom Hintergrundstatus in den aktiven Zustand aufgerufen. Hier können Sie vieles rückgängig machen, was beim Wechsel in den Hintergrundstatus geschieht.
      //wi 116840 - Abschlussbenachrichtigung zur mfp_intialization hinzufügen, nachdem openurl ausgeführt und eine Benachrichtigung von der Überwachungsfunktion empfangen wurde.
      // So wird ein Warmstart ordnungsgemäß gehandhabt.
      __block __weak id observer = [[NSNotificationCenter defaultCenter]addObserverForName:OPEN_URL_COMPLETED object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * note) {
          [[NSNotificationCenter defaultCenter] postNotificationName:MFP_INITIALIAZATION object:nil];
          [[NSNotificationCenter defaultCenter] removeObserver:observer name:OPEN_URL_COMPLETED object:nil];
      }];

  }
  - (void)applicationDidBecomeActive:(UIApplication *)application
  {
      // Alle Aufgaben neu Starten, die während der Inaktivität der Anwendung gestoppt (oder noch nicht gestartet) wurden. Falls die Anwendung sich im Hintergrund befand, können Sie die Anzeige der Benutzerschnittstelle aktualisieren.
  }
  - (void)applicationWillTerminate:(UIApplication *)application
  {
      // Aufgerufen, wenn die Anwendung kurz vor der Beendigung steht. Speichern Sie ggf. Daten (siehe auch applicationDidEnterBackground:).
  }
  //wi 116840 - Mit den folgenden Änderungen wird ein Kaltstart in handleopenurl korrigiert. Erst wenn die Überwachungsfunktion für MFP_INITIALIZATION zurückkehrt, wird das Plug-in handleopenurl aufgerufen.
  // So wird sichergestellt, dass es beim Kaltstart keine Probleme gibt.
  // Anschließend wird eine Überwachungsfunktion für open_url_completed initialisiert. Damit ist sichergestellt, dass in "applicationWillEnterForeground" die Aktion für die Abschlussbenachrichtigung nach Ausführung von openurl beendet ist.
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


>**Hinweis:** Diese Änderungen gehen zwangsläufig verloren, wenn die iOS-Plattform entfernt und hinzugefügt wird. Sie müssen also sicherstellen, dass diese Änderungen immer bei Bedarf vorgenommen werden. 

### Windows
{: #windows }
Wenn Sie eine Windows-App haben, fügen Sie Zeilen ähnlich denen im folgenden Beispiel zwischen den Tags `<platform name="windows">` und `</platform>` ein: 

#### Begrüßungsanzeigen
{: #splash-screens-windows }
Die Dateipfade und -namen der Begrüßungsanzeigen müssen die gleichen wie im folgenden Beispiel sein. Der Name der einzelnen Bilder richtet sich nach ihrer
Größe. 

```xml
<splash src="res/screen/windows/SplashScreen.scale-100.png" width="620" height="300"/>
<splash src="res/screen/windows/SplashScreenPhone.scale-240.png" width="1152" height="1920"/>
<splash src="res/screen/windows/Wide310x150Logo.scale-100.png" width="310" height="150"/>
<splash src="res/screen/windows/Wide310x150Logo.scale-240.png" width="744" height="360"/>
```

#### Symbole
{: #icons-windows }
Die Namen der Symboldateien müssen die gleichen wie im folgenden Beispiel sein. Die Pfade können beliebige sein. Der Name der einzelnen Bilder richtet sich nach ihrer
Größe. 

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
