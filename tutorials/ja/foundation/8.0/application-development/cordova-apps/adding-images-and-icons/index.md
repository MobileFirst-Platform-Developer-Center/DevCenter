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
