---
layout: tutorial
title: 모바일 클라이언트 사용 준비
breadcrumb_title: 준비
relevantTo: [ios,android,windows,javascript]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
Appcenter 설치 프로그램 애플리케이션은 모바일 디바이스에 앱을 설치하는 데 사용됩니다. 제공된 Cordova 또는 MobileFirst Studio 프로젝트를 사용하여 이 애플리케이션을 생성하거나, 미리 빌드된 Android, iOS 또는 Windows 8 Universal용 MobileFirst Studio 프로젝트 버전을 직접 사용할 수 있습니다. 

#### 다음으로 이동
{: #jump-to }
* [전제조건](#prerequisites)
* [Cordova 기반 IBM AppCenter 클라이언트](#cordova-based-ibm-appcenter-client)
* [MobileFirst Studio 기반 IBM AppCenter 클라이언트](#mobilefirst-studio-based-ibm-appcenter-client)
* [기능 사용자 정의(전문가용): Android, iOS, Windows Phone](#customizing-features-for-experts-android-ios-windows-phone)
* [Application Center에 모바일 클라이언트 배치](#deploying-the-mobile-client)

## 전제조건
{: #prerequisites }
### Android 운영 체제에 맞는 전제조건
{: #prerequisites-specific-to-the-android-operating-system }
모바일 클라이언트의 원시 Android 버전은 Android 애플리케이션 패키지(.apk) 파일 양식으로 소프트웨어 전달에 포함됩니다. **IBMApplicationCenter.apk** 파일은 **ApplicationCenter/installer** 디렉토리에 있습니다. 푸시 알림은 사용 안함으로 설정되어 있습니다. 푸시 알림을 사용으로 설정하려는 경우 .apk 파일을 다시 빌드해야 합니다. Application Center의 푸시 알림에 대한 자세한 정보는 [애플리케이션 업데이트의 푸시 알림](../push-notifications)을 참조하십시오. 

Android 버전을 빌드하려면 최신 버전의 Android 개발 도구가 있어야 합니다. 

### Apple iOS 운영 체제에 맞는 전제조건
{: #prerequisites-specific-to-apple-ios-operating-system }
iPad 및 iPhone용 원시 iOS 버전은 컴파일된 애플리케이션으로 전달되지 않습니다. 애플리케이션은 **IBMAppCenter**라는 {{ site.data.keys.product_full }} 프로젝트에서 작성해야 합니다. 이 프로젝트는 **ApplicationCenter/installer** 디렉토리에 배포의 일부로도 전달됩니다. 

iOS 버전을 빌드하려면 적절한 {{ site.data.keys.product_full }} 및 Apple 소프트웨어가 있어야 합니다. {{ site.data.keys.mf_studio }} 버전은 이 문서의 기반이 되는 {{ site.data.keys.mf_server }} 버전과 같아야 합니다. Apple Xcode 버전은 V6.1입니다. 

### Microsoft Windows Phone 운영 체제에 특정한 전제조건
{: #prerequisites-specific-to-microsoft-windows-phone-operating-system }
모바일 클라이언트의 Windows Phone 버전은 서명되지 않은 Windows Phone 애플리케이션 패키지(.xap) 파일로 소프트웨어 전달에 포함됩니다. **IBMApplicationCenterUnsigned.xap** 파일은 **ApplicationCenter/installer** 디렉토리에 있습니다. 

> **중요:** 서명되지 않은 .xap 파일은 직접 사용할 수 없습니다. 디바이스에 설치할 수 있으려면 Symantec/Microsoft에서 확보한 회사 인증서로 이 파일에 서명해야 합니다.

선택사항: 필요한 경우 소스에서 Windows Phone 버전을 빌드할 수도 있습니다. 이 작업을 수행하려면 최신 버전의 Microsoft Visual Studio가 있어야 합니다. 

### Microsoft Windows 8 운영 체제에 특정한 전제조건
{: #prerequisites-specific-to-microsoft-windows-8-operating-system }
모바일 클라이언트의 Windows 8 버전은 .zip 아카이브 파일로 포함됩니다. **IBMApplicationCenterWindowsStore.zip** 파일에는 실행 파일(.exe) 및 해당 종속 동적 링크 라이브러리(.dll) 파일이 포함되어 있습니다. 이 아카이브의 컨텐츠를 사용하려면 로컬 드라이브의 위치에 아카이브를 다운로드하고 실행 파일을 실행하십시오. 

선택사항: 필요한 경우 소스에서 Windows 8 버전을 빌드할 수도 있습니다. 이 작업을 수행하려면 최신 버전의 Microsoft Visual Studio가 있어야 합니다. 

## Cordova 기반 IBM AppCenter 클라이언트
{: #cordova-based-ibm-appcenter-client }
Cordova 기반 AppCenter 클라이언트 프로젝트는 **install_dir/ApplicationCenter/installer/CordovaAppCenterClient**의 `install` 디렉토리에 있습니다. 

이 프로젝트는 Cordova 프레임워크만을 기반으로 하므로 {{ site.data.keys.product }} 클라이언트/서버 API에 대한 종속성이 없습니다.   
이 앱은 표준 Cordova 앱이므로 {{ site.data.keys.mf_studio }}에 대한 종속성도 없습니다. 이 앱은 UI를 위해 Dojo를 사용합니다. 

시작하려면 아래 단계를 따르십시오. 

1. Cordova를 설치하십시오. 

```bash
npm install -g cordova@latest
```

2. Android SDK를 설치하고 `ANDROID_HOME`을 설정하십시오.   
3. 이 프로젝트를 빌드하고 실행하십시오. 

모든 플랫폼을 빌드합니다. 

```bash
cordova build
```

Android만 빌드합니다. 

```bash
cordova build android
```

iOS만 빌드합니다. 

```bash
cordova build ios
```

### AppCenter 설치 프로그램 애플리케이션 사용자 정의
{: #customizing-appcenter-installer-application }
특정 회사 또는 요구에 대한 사용자 인터페이스 업데이트와 같이 추가적으로 애플리케이션을 사용자 정의할 수 있습니다. 

> **참고:** 애플리케이션 UI 및 동작을 자유롭게 사용자 정의할 수 있지만, 이러한 변경사항은 IBM의 지원 계약에 포함되지 않습니다.

#### Android
{: #android }
* Android Studio를 여십시오. 
* **프로젝트(Eclipse ADT, Gradle 등) 가져오기**를 선택하십시오. 
* **install_dir/ApplicationCenter/installer/CordovaAppCenterClient/platforms/android**에서 Android 폴더를 선택하십시오. 

시간이 다소 걸릴 수 있습니다. 이 작업이 완료되면 사용자 정의할 준비가 된 것입니다. 

> **참고:** Gradle 버전 업그레이드의 경우 팝업 창에서 업데이트 옵션을 건너뛰도록 선택하십시오. 버전은 `grade-wrapper.properties`를 참조하십시오.

#### iOS
{: #ios }
* **install_dir/ApplicationCenter/installer/CordovaAppCenterClient/platforms**로 이동하십시오. 
* **IBMAppCenterClient.xcodeproj** 파일을 클릭하여 여십시오. 프로젝트가 Xcode에서 열리며 사용자 정의할 준비가 완료됩니다. 

## MobileFirst Studio 기반 IBM AppCenter 클라이언트
{: #mobilefirst-studio-based-ibm-appcenter-client }
iOS 및 Android용 Cordova 프로젝트를 사용하는 대신에, MobileFirst Studio 7.1을 기반으로 하고 iOS, Android 및 Windows Phone을 지원하는 App Center 클라이언트 애플리케이션의 이전 릴리스를 사용하도록 선택할 수 있습니다. 

### 프로젝트 가져오기 및 빌드(Android, iOS, Windows Phone)
{: #importing-and-building-the-project-android-ios-windows-phone }
**IBMAppCenter** 프로젝트를 {{ site.data.keys.mf_studio }}에 가져온 후 프로젝트를 빌드해야 합니다. 

> **참고:** V8.0.0의 경우 MobileFirst Studio 7.1을 사용하십시오. MobileFirst Studio는 [다운로드 페이지]({{site.baseurl}}/downloads)에서 다운로드할 수 있습니다. 설치 지시사항은 7.1용 IBM Knowledge Center의 [MobileFirst Studio 설치](https://www.ibm.com/support/knowledgecenter/SSHS8R_7.1.0/com.ibm.worklight.installconfig.doc/devenv/t_installing_ibm_worklight_studi.html)를 참조하십시오.

1. **파일 → 가져오기**를 선택하십시오. 
2. **일반 → 기존 프로젝트를 작업공간으로**를 선택하십시오. 
3. 다음 페이지에서 **루트 디렉토리 선택**을 선택하고 **IBMAppCenter** 프로젝트의 루트를 찾으십시오. 
4. **IBMAppCenter** 프로젝트를 선택하십시오. 
5. **작업공간에 프로젝트 복사**를 선택하십시오. 이 항목을 선택하면 사용자의 작업공간에 프로젝트의 사본을 작성합니다. UNIX 시스템에서 IBMAppCenter 프로젝트는 원래 위치에서 읽기 전용입니다. 따라서 작업공간에 프로젝트를 복사하면 파일 권한 관련 문제가 발생하지 않습니다. 
6. **완료**를 클릭하여 **IBMAppCenter** 프로젝트를 MobileFirst Studio로 가져오십시오. 

**IBMAppCenter** 프로젝트를 빌드하십시오. MobileFirst 프로젝트에는 **AppCenter**라는 단일 애플리케이션이 포함되어 있습니다. 애플리케이션을 마우스 오른쪽 단추로 클릭하고 **실행 도구 → 모든 환경 빌드**를 선택하십시오. 

#### Android
{: #android }
MobileFirst Studio는 **IBMAppCenter/apps/AppCenter/android/native**에 원시 Android 프로젝트를 생성합니다. 원시 Android 개발 도구(ADT) 프로젝트는 android/native 폴더에 있습니다. ADT 도구를 사용하여 이 프로젝트를 컴파일하고 서명할 수 있습니다. 생성되는 APK가 모든 Android 버전 2.3 이상과 호환 가능하도록 이 프로젝트에서는 Android SDK 레벨 16을 설치해야 합니다. 프로젝트를 빌드할 때 상위 레벨의 Android SDK를 선택하는 경우 생성되는 APK는 Android 버전 2.3과 호환 가능하지 않습니다. 

모바일 클라이언트 애플리케이션에 영향을 미치는 특정 Android 정보는 [개발자용 Android 사이트](https://developer.android.com/index.html)를 참조하십시오. 

애플리케이션 업데이트에 대한 푸시 알림을 사용하려면 먼저 Application Center 클라이언트 특성을 구성해야 합니다. 자세한 정보는 [애플리케이션 업데이트에 대한 푸시 알림 구성](../push-notifications)을 참조하십시오. 

#### iOS
{: #ios }
MobileFirst Studio는 **IBMAppCenter/apps/AppCenter/iphone/native**에 원시 iOS 프로젝트를 생성합니다. **IBMAppCenterAppCenterIphone.xcodeproj** 파일은 iphone/native 폴더에 있습니다. 이 파일은 Xcode를 사용하여 컴파일하고 서명해야 하는 Xcode 프로젝트입니다. 

iOS 모바일 클라이언트 애플리케이션을 서명하는 방법에 대해 자세히 알아보려면 [Apple 개발자 사이트](https://developer.apple.com/)를 참조하십시오. iOS 애플리케이션을 서명하려면 사용하는 프로비저닝 프로파일과 함께 사용할 수 있는 번들 ID로 애플리케이션의 번들 ID를 변경해야 합니다. 값은 Xcode 프로젝트 설정에서 **com.your\_internet\_domain\_name.appcenter**로 정의됩니다. 여기서 **your\_internet\_domain\_name**은 인터넷 도메인의 이름입니다. 

애플리케이션 업데이트에 대한 푸시 알림을 사용하려면 먼저 Application Center 클라이언트 특성을 구성해야 합니다. 자세한 정보는 [애플리케이션 업데이트에 대한 푸시 알림 구성](../push-notifications)을 참조하십시오. 

#### Windows Phone 8
{: #windows-phone-8 }
MobileFirst Studio는 **IBMAppCenter/apps/AppCenter/windowsphone8/native**에 원시 Windows Phone 8 프로젝트를 생성합니다. **AppCenter.csproj** 파일은 windowsphone8/native 폴더에 있습니다. 이 파일은 Visual Studio 및 Windows Phone 8.0 SDK를 사용하여 컴파일해야 하는 Visual Studio 프로젝트입니다. 

애플리케이션은 Windows Phone 8.0 및 8.1 디바이스에서 [Windows Phone 8.0 SDK](https://www.microsoft.com/en-in/download/details.aspx?id=35471)로 빌드됩니다. 결과가 이전의 Windows Phone 8.0 디바이스에서 실행되지 않기 때문에 Windows Phone 8.1 SDK로는 빌드되지 않습니다. 

Visual Studio 2013을 설치하면 Windows Phone 8.1 SDK 외에 8.0 SDK 설치도 선택할 수 있습니다. Windows Phone 8.0 SDK는 [Windows Phone SDK 아카이브](https://developer.microsoft.com/en-us/windows/downloads/sdk-archive)에서도 사용할 수 있습니다. 

Windows Phone 모바일 클라이언트 애플리케이션을 빌드하고 서명하는 방법에 대해 자세히 알아보려면 [Windows Phone Dev Center](https://developer.microsoft.com/en-us)를 참조하십시오. 

#### Microsoft Windows 8: 프로젝트 빌드
{: #microsoft-windows-8-building-the-project }
Windows 8 Universal 프로젝트는 **IBMApplicationCenterWindowsStore\AppCenterClientWindowsStore.csproj**에 있는 Visual Studio 프로젝트로 제공됩니다.   
클라이언트 프로젝트를 분배하기 전에 Microsoft Visual Studio 2013에서 프로젝트를 빌드해야 합니다. 

프로젝트 빌드는 사용자에게 분배하기 위한 전제조건이지만, Windows 8 애플리케이션은 나중에 분배하기 위해 Application Center에 배치하도록 설계되어 있지 않습니다. 

Windows 8 프로젝트를 빌드하려면 다음을 수행하십시오. 

1. Microsoft Visual Studio 2013에서 **IBMApplicationCenterWindowsStore\AppCenterClientWindowsStore.csproj**라는 Visual Studio 파일을 여십시오. 
2. 애플리케이션의 전체 빌드를 수행하십시오. 

Application Center 사용자에게 모바일 클라이언트를 배포하기 위해, 생성된 실행 파일(.exe) 및 해당 종속 동적 링크 라이브러리(.dll) 파일을 설치할 설치 프로그램을 나중에 생성할 수 있습니다. 또는 설치 프로그램에 포함시키지 않고 이러한 파일을 제공할 수 있습니다. 

## 기능 사용자 정의(전문가용): Android, iOS, Windows Phone
{: #customizing-features-for-experts-android-ios-windows-phone }
중앙 특성 파일을 편집하고 일부 다른 자원을 조작하여 기능을 사용자 정의할 수 있습니다. 

기능을 사용자 정의하는 경우 일부 기능은 **IBMAppCenter/apps/AppCenter/common/js/appcenter/** 또는 **ApplicationCenter/installer/CordovaAppCenterClient/www/js/appcenter** 디렉토리의 **config.json**이라는 중앙 특성 파일에 의해 제어됩니다. 기본 애플리케이션 동작을 변경하려는 경우 프로젝트를 빌드하기 전에 이 특성 파일을 조정할 수 있습니다. 

이 파일에는 다음 표에 표시된 특성이 포함되어 있습니다. 

| 특성     | 설명        |
|----------|-------------|
| url | Application Center 서버의 하드코딩된 주소. 이 특성이 설정되면 로그인 보기의 주소 필드가 표시되지 않습니다.  |
| defaultPort | url 특성이 널인 경우 이 특성은 전화기에서 로그인 보기의 포트 필드에 미리 채워집니다. 이것이 기본값이며 사용자가 필드를 편집할 수 있습니다.  |
| defaultContext | url 특성이 널인 경우 이 특성은 전화기에서 로그인 보기의 컨텍스트 필드에 미리 채워집니다. 이것이 기본값이며 사용자가 필드를 편집할 수 있습니다.  |
| ssl | 로그인 보기의 SSL 전환에 대한 기본값.  |
| allowDowngrade | 이 특성은 이전 버전의 설치 권한이 부여되었는지 여부를 표시합니다. 이전 버전은 운영 체제 및 버전이 다운그레이드를 허용하는 경우에만 설치할 수 있습니다.  |
| showPreviousVersions | 이 특성은 디바이스 사용자가 모든 버전의 애플리케이션에 대한 세부사항을 표시할 수 있는지 아니면 최신 버전의 세부사항만 표시할 수 있는지를 표시합니다.  |
| showInternalVersion | 이 특성은 내부 버전이 표시되는지 여부를 표시합니다. 값이 false인 경우 상업용 버전이 설정되지 않은 경우에만 내부 버전이 표시됩니다.  |
| listItemRenderer | 이 특성 값은 다음 중 하나입니다. <br/>- **full** (기본값): 애플리케이션 목록에 애플리케이션 이름, 등급, 최신 버전이 표시됩니다.<br/>- **simple**: 애플리케이션 목록에 애플리케이션 이름만 표시됩니다. |
| listAverageRating | 이 특성 값은 다음 중 하나입니다. <br/>-  **latestVersion**: 애플리케이션 목록에 최신 버전의 애플리케이션에 대한 평균 등급이 표시됩니다. <br/>-  **allVersions**: 애플리케이션 목록에 모든 버전의 애플리케이션에 대한 평균 등급이 표시됩니다. |
| requestTimeout | 이 특성은 Application Center 서버에 대한 요청의 제한시간(밀리초)을 표시합니다.  |
| gcmProjectId | Android 푸시 알림에 필요한 Google API 프로젝트 ID(프로젝트 이름 = com.ibm.appcenter). 예: 123456789012.  |
| allowAppLinkReview | 이 특성은 외부 애플리케이션 스토어에서 애플리케이션의 로컬 검토를 Application Center에서 등록하고 찾아볼 수 있는지 여부를 표시합니다. 이러한 로컬 검토는 외부 애플리케이션 스토어에서 볼 수 없습니다. 이러한 검토는 Application Center 서버에 저장됩니다.  |

### 기타 자원
{: #other-resources }
사용 가능한 기타 자원은 애플리케이션 아이콘, 애플리케이션 이름, 스플래시 화면 이미지, 아이콘, 애플리케이션의 변환 가능한 자원입니다. 

#### 애플리케이션 아이콘
{: #application-icons }
* **Android:** Android Studio 프로젝트의 **/res/drawabledensity** 디렉토리(각 밀도에 대해 하나의 디렉토리가 있음)에 있는 **icon.png** 파일. 
* **iOS:** Xcode 프로젝트의 **Resources** 디렉토리에 있는 **iconsize.png** 파일. 
* **Windows Phone:** Windows Phone용 MobileFirst Studio 환경 폴더의 **native** 디렉토리에 있는 **ApplicationIcon.png**, **IconicTileSmallIcon.png** 및 **IconicTileMediumIcon.png** 파일. 

#### 애플리케이션 이름
{: #application-name }
* **Android:** Android Studio 프로젝트의 **res/values/strings.xml**에서 **app_name** 특성을 편집하십시오. 
* **iOS:** Xcode 프로젝트의 **IBMAppCenterAppCenterIphone-Info.plist** 파일에서 **CFBundleDisplayName** 키를 편집하십시오. 
* **Windows Phone:** Visual Studio의 **Properties/WMAppManifest.xml** 파일에서 App 항목의 **Title** 속성을 편집하십시오. 

#### 스플래시 화면 이미지
{: #splash-screen-images }
* **Android:** Android Studio 프로젝트의 **res/drawable/density** 디렉토리(각 밀도에 대해 하나의 디렉토리가 있음)에서 **splashimage.9.png** 파일을 편집하십시오. 이 파일은 패치 9 이미지입니다. 
* **iOS:** Xcode 프로젝트의 **Resources** 디렉토리에서 **Default-size.png** 파일을 편집하십시오. 
* 자동 로그인 동안 표시되는 Cordova/MobileFirst Studio 기반 프로젝트의 스플래시 화면: **js/idx/mobile/themes/common/idx/Launch.css**
* **Windows Phone:** Windows Phone용 MobileFirst Studio 환경 폴더의 **native** 디렉토리에서 **SplashScreenImage.png** 파일을 편집하십시오. 

#### 애플리케이션의 아이콘(단추, 별, 유사 오브젝트)
{: #icons }
**IBMAppCenter/apps/AppCenter/common/css/images**.

#### 애플리케이션의 변환 가능한 자원
{: #translatable-resources }
**IBMAppCenter/apps/AppCenter/common/js/appcenter/nls/common.js**.

## Application Center에 모바일 클라이언트 배치
{: #deploying-the-mobile-client }
다양한 버전의 클라이언트 애플리케이션을 Application Center에 배치하십시오. 

Windows 8 모바일 클라이언트는 나중에 분배하기 위해 Application Center에 배치하도록 설계되어 있지 않습니다. 아카이브로 직접 패키지된 클라이언트 .exe 실행 파일 및 동적 링크 라이브러리 .dll 파일을 사용자에게 제공하거나 Windows 8 모바일 클라이언트에 대한 실행 가능 설치 프로그램을 작성하여 Windows 8 모바일 클라이언트를 분배하도록 선택할 수 있습니다. 

Android, iOS 및 Windows Phone 버전의 모바일 클라이언트를 Application Center에 배치해야 합니다. 이 작업을 수행하려면 Android 애플리케이션 패키지(.apk) 파일, iOS 애플리케이션(.ipa) 파일, Windows Phone 애플리케이션(.xap) 파일 및 웹 디렉토리 아카이브(.zip) 파일을 Application Center로 업로드해야 합니다. 

Android, iOS 및 Windows Phone용 모바일 클라이언트 애플리케이션을 추가하려면 [모바일 애플리케이션 추가](../appcenter-console/#adding-a-mobile-application)에 설명된 단계를 따르십시오. 애플리케이션이 설치 프로그램인 것을 표시하기 위해 설치 프로그램 애플리케이션 특성을 선택해야 합니다. 이 특성을 선택하면 모바일 디바이스 사용자가 무선으로 쉽게 모바일 클라이언트 애플리케이션을 설치할 수 있습니다. 모바일 클라이언트를 설치하려면 운영 체제에서 판별한 모바일 클라이언트 애플리케이션의 버전에 해당하는 관련 태스크를 참조하십시오. 
