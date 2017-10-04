---
layout: tutorial
title: Angepasste Begrüßungsanzeigen und Symbole zu Cordova-Apps hinzufügen
breadcrumb_title: Bilder und Symbole hinzufügen
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
