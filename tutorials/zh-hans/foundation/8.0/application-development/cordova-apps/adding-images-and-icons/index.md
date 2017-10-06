---
layout: tutorial
title: 针对 Cordova 应用程序添加定制启动屏幕和图标
breadcrumb_title: 添加图像和图标
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
