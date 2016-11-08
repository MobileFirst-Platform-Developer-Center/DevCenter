---
layout: tutorial
title: Adding custom splash screens and icons to Cordova apps
breadcrumb_title: Adding images and icons
relevantTo: [cordova]
weight: 1
---

## Overview
If you used the **cordova-plugin-mfp** plug-in, and you did not use the MobileFirst template or add the Cordova **cordova-plugin-splashscreen** plug-in to your app, you can replace the images for icons and splash screens that are provided by IBM MobileFirst Foundation with your own images. If you used the template, then you can replace the splash images that the Cordova app uses, as they are the files that are displayed.

You must create a new folder to hold the splash images and icons, and modify the **config.xml** configuration file to point to them.

1. Create a folder inside the root directory of your Cordova project. The folder can be in any level of nested subfolder when the parent folder is under the Cordova project root.
2. Place your source splash image and icon images in this folder.
3. Update the **config.xml** configuration file to point to your custom files.

### Android
If you have an Android app, the requirements to for identifying the splash images depends on whether you created the app with or without the MobileFirst template.

#### Splash screens
If you did *not* use the MobileFirst template when you created your app, the splash images that are displayed are those that are retrieved from the MobileFirst images location. The target file paths and file names must remain exactly as in the example when you do not use the template. Change the source paths and file names (`src`) to the path of the files that you want to display. Add lines similar to the following example between the `<platform name="android">` and `</platform>` tags in the **config.xml** file: 

```xml
<update src="res/screen/android/splash-hdpi.9.png" target="res/drawable-hdpi/splash.9.png" />
<update src="res/screen/android/splash-ldpi.9.png" target="res/drawable-ldpi/splash.9.png" />
<update src="res/screen/android/splash-mdpi.9.png" target="res/drawable-mdpi/splash.9.png" />
<update src="res/screen/android/splash-xhdpi.9.png" target="res/drawable-xhdpi/splash.9.png" />
<update src="res/screen/android/splash-xxhdpi.9.png" target="res/drawable-xxhdpi/splash.9.png" /> 
```

If you used the MobileFirst template when you created your app, you must update the splash images that Cordova uses. Change the source paths and file names (src) to the path of the files that you want to display. Add lines similar to the following example between the <platform name="android"> and </platform> tags in the config.xml file:

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
If you have an iOS app, add lines similar to the following example between the `<platform name="ios">` and `</platform>` tags:
    
#### Splash screens
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

### Windows
If you have a Windows app, add lines similar to the lines in the following example between the `<platform name="windows">` and `</platform>` tags:

#### Splash screens
The paths and file names of the splash screen files must be the same as the names in the following example. The name of each image corresponds to its size.

```xml
<splash src="res/screen/windows/SplashScreen.scale-100.png" width="620" height="300"/>
<splash src="res/screen/windows/SplashScreenPhone.scale-240.png" width="1152" height="1920"/>
<splash src="res/screen/windows/Wide310x150Logo.scale-100.png" width="310" height="150"/>
<splash src="res/screen/windows/Wide310x150Logo.scale-240.png" width="744" height="360"/>
```

#### Icons
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
