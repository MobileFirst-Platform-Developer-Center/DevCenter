---
layout: tutorial
title: Cordova 앱에 사용자 정의 스플래시 화면 및 아이콘 추가
breadcrumb_title: 이미지 및 아이콘 추가
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
