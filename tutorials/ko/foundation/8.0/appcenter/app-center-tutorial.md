---
layout: tutorial
title: IBM Application Center를 사용하여 모바일 애플리케이션 분배
relevantTo: [ios,android,windows8,cordova]
show_in_nav: false
weight: 7
---
## 개요
{: #overview }
{{site.data.keys.mf_app_center_full }}는 공용 앱 스토어와 유사한 **모바일 애플리케이션의 저장소**이지만 조직 또는 팀의 요구에 초점이 맞춰져 있습니다. 개인용 앱 스토어입니다. 

Application Center는 다음 모바일 애플리케이션을 쉽게 공유할 수 있습니다. 

* **피드백 및 등급 정보를 공유**할 수 있습니다.   
* 액세스 제어 목록을 사용하여 애플리케이션을 설치할 수 있는 사용자를 제한할 수 있습니다. 

Application Center는 {{site.data.keys.product_adj }} 앱 및 비{{site.data.keys.product_adj }} 앱과 함께 작동하며 **iOS, Android**, **BlackBerry 6/7** 및 **Windows/Phone 8.x** 애플리케이션을 지원합니다. 

> **참고:** 스토어 제출/iOS 앱의 유효성 검증을 위해 Test Flight 또는 iTunes Connect를 사용하여 생성된 아카이브/IPA 파일은 런타임 충돌/실패를 야기할 수 있으며, 자세한 사항은 [IBM MobileFirst Foundation 8.0에서 앱 스토어 제출을 위해 iOS 앱 준비](https://mobilefirstplatform.ibmcloud.com/blog/2016/10/17/prepare-ios-apps-for-app-store-submission/) 블로그를 읽어보십시오.

다양한 컨텍스트에서 Application Center를 사용할 수 있습니다. 예: 

* 조직 전체에서 엔터프라이즈 앱 스토어로서. 
* 팀 내에서 애플리케이션을 분배하기 위한 개발 단계 중에. 

> **참고:** iOS AppCenter 설치 프로그램 애플리케이션을 빌드하려면, MobileFirst 7.1이 필요합니다. 

#### 다음으로 이동: 
{: #jump-to}
* [설치 및 구성](#installing-and-configuring)
* [Cordova 기반 IBM AppCenter 클라이언트](#cordova-based-ibm-appcenter-client)
* [모바일 클라이언트 준비](#preparing-mobile-clients)
* [Application Center 콘솔에서 애플리케이션 관리](#managing-applications-in-the-application-center-console)
* [Application Center 모바일 클라이언트](#the-application-center-mobile-client)
* [Application Center 명령행 도구](#application-center-command-line-tools)

## 설치 및 구성
{: #installing-and-configuring }
Application Center는 IBM Installation Manager를 사용하는 {{site.data.keys.mf_server }} 설치의 일부로 설치됩니다. 

**전제조건:** Application Center를 설치하기 전에 애플리케이션 서버와 데이터베이스가 설치되어 있어야 합니다. 

* 애플리케이션 서버: Tomcat 또는 WebSphere Application Server 전체 프로파일 또는 Liberty 프로파일
* 데이터베이스: DB2, Oracle 또는 MySQL

데이터베이스가 설치되어 있지 않은 경우 설치 프로세스에서 Apache Derby 데이터베이스도 설치할 수 있습니다. 그러나 Derby 데이터베이스를 사용하는 것은 프로덕션 시나리오의 경우 권장되지 않습니다. 

1. IBM Installation Manager는 데이터베이스와 애플리케이션 서버의 선택사항과 함께 Application Center의 설치를 안내합니다. 

    > 자세한 정보는 [{{site.data.keys.mf_server }} 설치](../../installation-configuration)에 대한 주제를 참조하십시오. 

    iOS 7.1은 https 프로토콜만 지원하기 때문에 iOS 7.1 이상을 실행하는 디바이스용 앱을 분배할 계획이라면 SSL(최소한 TLS v.1 이상)을 사용하여 Application Center 서버의 보안을 설정해야 합니다. 자체 서명된 인증서는 권장하지 않지만, 디바이스에 자체 서명된 인증서가 분배되는 경우 테스트 목적으로 사용할 수 있습니다. 

2. IBM Installation Manager를 사용하여 Application Center가 설치된 후 콘솔을 여십시오. `http://localhost:9080/appcenterconsole`

3. 이 사용자/비밀번호 조합인 demo/demo를 사용하여 로그인하십시오. 

4. 이 때 사용자 인증을 구성할 수 있습니다. 예를 들어, LDAP 저장소에 연결할 수 있습니다. 

    > 자세한 정보는 [설치 후 Application Center 구성](../../installation-configuration/production/appcenter/#configuring-application-center-after-installation)에 대한 주제를 참조하십시오.

5. Android, iOS, BlackBerry 6/7 및 Windows Phone 8에 대한 모바일 클라이언트를 준비하십시오. 

모바일 클라이언트는 카탈로그를 찾아보고 애플리케이션을 설치하는 데 사용하는 모바일 애플리케이션입니다. 

> **참고:** 프로덕션 설치의 경우 제공된 Ant 태스크를 실행하여 Application Center를 설치하는 것에 대해 고려하십시오. Application Center에 대한 업데이트에서 서버에 대한 업데이트를 분리할 수 있습니다.

## Cordova 기반 IBM AppCenter 클라이언트
{: #cordova-based-ibm-appcenter-client }
Cordova 기반 AppCenter 클라이언트 프로젝트는 **install_dir/ApplicationCenter/installer/CordovaAppCenterClient**의 `install` 디렉토리에 있습니다. 

이 프로젝트는 Cordova 프레임워크만을 기반으로 하므로 {{site.data.keys.product }} 클라이언트/서버 API에 대한 종속성이 없습니다.   
이 앱은 표준 Cordova 앱이므로 {{site.data.keys.mf_studio }}에 대한 종속성도 없습니다. 이 앱은 UI를 위해 Dojo를 사용합니다. 

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

## 모바일 클라이언트 준비
{: #preparing-mobile-clients }
### Android 전화 및 태블릿의 경우
{: #for-android-phones-and-tablets }
모바일 클라이언트는 컴파일된 애플리케이션(APK)로 제공되며 **install_dir/ApplicationCenter/installer/IBMApplicationCenter.apk**에 있습니다. 

> **참고:** Android 및 iOS AppCenter 클라이언트 빌드에 대해 Cordova 프레임워크를 사용 중인 경우 [Cordova 기반 IBM AppCenter 클라이언트](#cordova-based-ibm-appcenter-client)를 참조하십시오.

### iPad 및 iPhone의 경우
{: #for-ipad-and-iphone }
1. 소스 코드에 제공된 클라이언트 애플리케이션을 컴파일하고 서명하십시오. 필수사항입니다. 

2. MobileFirst Studio에서 **install\_dir/ApplicationCenter/installer**에 있는 IBMAppCenter 프로젝트를 여십시오. 

3. 프로젝트를 빌드하려면 **실행 도구 → MobileFirst Development Server에서 실행**을 사용하십시오. 

4. Xcode를 사용하여 Apple iOS 엔터프라이즈 프로파일이 포함된 애플리케이션을 빌드하고 서명하십시오.
  
생성되는 원시 프로젝트(**iphone\native**에서)를 Xcode에서 수동으로 열거나 iPhone 폴더를 마우스 오른쪽 단추로 클릭한 후 **실행 도구 → Xcode 프로젝트**를 선택할 수 있습니다. 이 조치는 프로젝트를 생성하고 Xcode에서 프로젝트를 엽니다. 

> **참고:** Android 및 iOS AppCenter 클라이언트 빌드에 대해 Cordova 프레임워크를 사용 중인 경우 [Cordova 기반 IBM AppCenter 클라이언트](#cordova-based-ibm-appcenter-client)를 참조하십시오.

### Blackberry의 경우
{: #for-blackberry }
* BlackBerry 버전을 빌드하려면, BlackBerry SDK 6.0이 포함된 BlackBerry Eclipse IDE(또는 BlackBerry Java 플러그인이 포함된 Eclipse)가 있어야 합니다. 애플리케이션을 BlackBerry SDK 6.0으로 컴파일한 경우 BlackBerry OS 7에서도 실행됩니다. 

BlackBerry 프로젝트가 **install\_dir/ApplicationCenter/installer/IBMAppCenterBlackBerry6**에 제공됩니다. 

### Windows Phone 8의 경우
{: #for-windows-phone-8}
1.  회사 계정을 Microsoft에 등록하십시오.
  
Application Center는 회사 계정과 함께 제공되는 회사 인증서를 사용하여 서명되는 회사 애플리케이션만 관리합니다. 

2. 모바일 클라이언트의 Windows Phone 버전은 **install\_dir/ApplicationCenter/installer/IBMApplicationCenterUnsigned.xap**에 포함됩니다.

* 또한 Application Center 모바일 클라이언트가 이 회사 인증서로 서명되었는지 확인하십시오. 

* 회사 애플리케이션을 디바이스에 설치하려면, 먼저 회사 등록 토큰을 설치하여 디바이스를 회사에 등록하십시오. 

> 회사 계정 및 등록 토큰에 대한 자세한 정보는 [Microsoft 개발자 웹 사이트 → Windows Phone용 회사 앱 배포](http://msdn.microsoft.com/library/windows/apps/jj206943(v=vs.105).aspx) 페이지를 참조하십시오.

> Windows Phone 모바일 클라이언트 애플리케이션에 서명하는 방법에 대한 자세한 정보는 [Microsoft 개발자 웹 사이트](http://dev.windows.com/en-us/develop)를 참조하십시오.

<br/>

> <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> **중요:** 부호 없는 `.xap` 파일을 직접 사용할 수 **없습니다**. 디바이스에 설치할 수 있으려면, 먼저 Symantec 또는 Microsoft에서 확보한 회사 인증서를 사용하여 서명해야 합니다.


### Windows 8.1 Pro용 Windows 스토어 앱
{: #for-windows-store-apps-for-windows-81-pro }
* **install\_dir/ApplicationCenter/installer/IBMApplicationCenterWindowsStore. zip** 파일은 Application Center 클라이언트의 실행 파일을 포함합니다. 이 파일을 클라이언트 컴퓨터에 분배하고 압축을 해제하십시오. 실행 가능 프로그램이 포함되어 있습니다. 

* Microsoft Windows 스토어를 사용하지 않고 Windows 스토어 앱(`appx` 파일 유형)을 설치하는 것을 앱 <em>사이드로딩</em>이라고 합니다. 앱을 사이드로드하려면, [앱 사이드로드 준비](https://technet.microsoft.com/fr-fr/library/dn613842.aspx. The Windows 8.1.1 update simplifies the prerequisites for sideloading. For more information, see [Sideloading Store Apps to Windows 8.1.1 Devices]( http://blogs.msdn.com/b/micham/archive/2014/05/30/sideloading-store-apps-to-windows-8-1-devices.aspx)의 전제조건을 준수해야 합니다. 

## Application Center 콘솔에서 애플리케이션 관리
{: #managing-applications-in-the-application-center-console }
![앱 센터의 애플리케이션 관리 이미지]({{ site.baseurl }}/assets/backup/overview1.png)

Application Center 콘솔을 사용하여 다음과 같은 방법으로 카탈로그에서 애플리케이션을 관리하십시오. 

* 애플리케이션 추가 및 제거
* 애플리케이션의 버전 관리    
* 애플리케이션의 세부사항 보기
* 특정 사용자 또는 사용자 그룹으로 애플리케이션의 액세스 제한
* 각 애플리케이션에 대한 검토 읽기
* 등록된 사용자 및 디바이스 검토

### 새 애플리케이션을 저장소에 추가
{: #adding-new-applications-to-the-store }
![앱 센터에 앱 추가 이미지]({{ site.baseurl }}/assets/backup/addAppFile_smaller.png)

새 애플리케이션을 스토어에 추가하려면, 다음을 수행하십시오. 

1. Application Center 콘솔을 여십시오. 
2. **애플리케이션 추가**를 클릭하십시오. 
3. 애플리케이션 파일을 선택하십시오. 
    * `.ipa`: iOS
    * `.apk`: Android
    * `.zip`: BlackBerry 6/7
    * `.xap`: Windows Phone 8.x
    * `.appx`: Windows Store 8.x

* **다음**을 클릭하십시오. 

    애플리케이션 세부사항 보기에서, 새 애플리케이션에 대한 정보를 검토하고 설명과 같은 추가 정보를 입력할 수 있습니다. 카탈로그에 있는 모든 애플리케이션을 위해 나중에 이 보기로 돌아올 수 있습니다. 

    ![애플리케이션 세부사항 화면 이미지]({{ site.baseurl }}/assets/backup/appDetails1.png)

* 태스크를 완료하려면 **완료**를 클릭하십시오. 

새 애플리케이션이 저장소에 추가됩니다. 

![앱 센터의 액세스 제어 이미지]({{ site.baseurl }}/assets/backup/accessControlEnabled.png)

기본적으로, 저장소의 권한 부여된 사용자가 애플리케이션을 설치할 수 있습니다. 

### 사용자 그룹으로 액세스 제한
{: #restricting-access-to-a-group-of-users }
액세스를 사용자 그룹으로 제한하려면, 다음을 수행하십시오. 

1. 카탈로그 보기에서 애플리케이션 이름 옆에 있는 **제한되지 않은 링크**를 클릭하십시오. 설치 액세스 제어 페이지가 열립니다. 
2. **액세스 제어 사용**을 선택하십시오. 이제 애플리케이션을 설치할 권한이 부여된 사용자 또는 그룹의 목록을 입력할 수 있습니다. 
3. LDAP을 구성한 경우 LDAP 저장소에 정의되어 있는 사용자 및 그룹을 추가하십시오. 

또한 해당 URL을 입력하여 Google Play 또는 Apple App Store와 같은 공용 앱 저장소로부터 애플리케이션을 추가할 수도 있습니다. 

## Application Center 모바일 클라이언트
{: #the-application-center-mobile-client }
App Center 모바일 클라이언트는 디바이스에서 애플리케이션을 관리하기 위한 모바일 애플리케이션입니다. 모바일 클라이언트를 사용하여 다음을 수행할 수 있습니다. 

* (액세스 권한이 있는)카탈로그의 모든 애플리케이션을 나열합니다. 
* 선호하는 애플리케이션을 나열합니다. 
* 애플리케이션을 설치하거나 새 버전으로 업그레이드합니다. 
* 애플리케이션에 대한 피드백 및 별 5개 등급을 제공합니다. 

### 카탈로그에 모바일 클라이언트 애플리케이션 추가
{: #adding-mobile-client-applications-to-the-catalog }
Application Center 모바일 클라이언트 애플리케이션을 카탈로그에 추가해야 합니다. 

1. Application Center 콘솔을 여십시오. 
2. **애플리케이션 추가** 단추를 클릭하여 모바일 클라이언트 `.apk`, `.ipa`, `.zip` 또는 `.xap` 파일을 추가하십시오. 
3. **다음**을 클릭하여 애플리케이션 세부사항 페이지를 여십시오. 
4. 애플리케이션 세부사항 페이지에서 이 애플리케이션이 모바일 클라이언트라는 것을 표시하려면 **설치 프로그램**을 선택하십시오. 
5. **완료**를 클릭하여 Application Center 앱을 카탈로그에 추가하십시오. 

Windows 8.1용 Application Center 클라이언트는 카탈로그에 추가할 필요가 없습니다. 이 클라이언트는 **install\_dir/ApplicationCenter/installer/IBMApplicationCenterWindowsStore.zip** 파일에 포함된 일반 Windows `.exe` 프로그램입니다. 간단하게 클라이언트 컴퓨터로 복사할 수 있습니다. 

### Windows Phone 8
{: #windows-phone-8 }
Windows Phone 8에서 사용자가 디바이스를 등록할 수 있도록 회사 계정과 함께 수신한 등록 토큰을 Application Center 콘솔에도 설치해야 합니다. 기어 아이콘을 통해 Application Center 설정 페이지를 열고 사용할 수 있습니다. 

![Windows Phone 8 앱 등록 이미지]({{ site.baseurl }}/assets/backup/wp8Enrollment.png)

모바일 클라이언트를 설치할 수 있으려면 등록 토큰을 설치하여 디바이스를 회사에 등록해야 합니다. 

1. 디바이스에서 웹 브라우저를 여십시오. 
2. 다음 URL `http://hostname:9080/appcenterconsole/installers.html`을 입력하십시오. 
3. 사용자 이름 및 비밀번호를 입력하십시오. 
4. **토큰**을 클릭하여 등록 토큰의 목록을 여십시오. 
5. 목록에서 회사를 선택하십시오. 회사 계정의 세부사항이 표시됩니다. 
6. **회사 계정 추가**를 클릭하십시오. 디바이스가 등록됩니다. 

### 모바일 디바이스에 모바일 클라이언트 설치
{: #installing-the-mobile-client-on-the-mobile-device }
모바일 디바이스에 모바일 클라이언트를 설치하려면 다음을 수행하십시오.
![애플리케이션 설치 프로그램 앱 이미지]({{ site.baseurl }}/assets/backup/installers_smaller.png)

1. 디바이스에서 웹 브라우저를 여십시오. 
2. 다음 URL `http://hostname:9080/appcenterconsole/installers.html`을 입력하십시오. 
3. 사용자 이름 및 비밀번호를 입력하십시오. 
4. Application Center 애플리케이션을 선택하여 설치를 시작하십시오. 

**Android** 디바이스에서 Android 다운로드 애플리케이션을 열고 설치를 위한 **IBM App Center**를 선택해야 합니다. 

### 모바일 클라이언트에 로그인
{: #logging-in-to-the-mobile-client }
모바일 클라이언트에 로그인하려면 다음을 수행하십시오. 

1. 서버에 액세스하기 위한 신임 정보를 입력하십시오. 
2. 서버의 호스트 이름이나 IP 주소를 입력하십시오.
3. 기본 포트(`9080`)가 아닌 경우 **서버 포트** 필드에 포트 번호를 입력하십시오. 
4. **애플리케이션 컨텍스트** 필드에 컨텍스트 `applicationcenter`를 입력하십시오. 

![로그인 화면]({{ site.baseurl }}/assets/backup/login.png)

### Application Center 모바일 클라이언트 보기
{: #application-center-mobile-client-views }
* **카탈로그** 보기는 사용 가능한 애플리케이션의 목록을 표시합니다. 
* 애플리케이션을 선택하면 애플리케이션에서 **세부사항** 보기가 열립니다. 세부사항 보기에서 애플리케이션을 설치할 수 있습니다. 세부사항 보기에 있는 별표 아이콘을 사용하여 애플리케이션을 즐겨찾기로 표시할 수도 있습니다. 

    ![카탈로그 세부사항]({{ site.baseurl }}/assets/backup/catalog_details.001.jpg)

* **즐겨찾기** 보기는 즐겨찾기 애플리케이션을 나열합니다. 이 목록은 특정 사용자의 모든 디바이스에서 사용할 수 있습니다. 
* **업데이트** 보기는 사용 가능한 모든 업데이트를 나열합니다. 업데이트 보기에서 세부사항 보기로 이동할 수 있습니다. 애플리케이션의 새 버전을 선택하거나 사용 가능한 최신 버전을 선택할 수 있습니다. 푸시 알림을 전송하도록 Application Center가 구성되어 있는 경우 푸시 알림 메시지로 업데이트에 대한 알림을 받을 수 있습니다. 

모바일 클라이언트에서 애플리케이션의 등급을 지정하고 검토를 전송할 수 있습니다. 콘솔 또는 모바일 디바이스에서 검토를 볼 수 있습니다. 

![검토]({{ site.baseurl }}/assets/backup/reviewss.png)

## Application Center 명령행 도구
{: #application-center-command-line-tools }
**install_dir/ApplicationCenter/tools** 디렉토리에는 저장소에서 애플리케이션을 관리하기 위해 명령행 도구 또는 Ant 태스크를 사용하는 데 필요한 모든 파일이 포함되어 있습니다. 

* `applicationcenterdeploytool.jar`: 업로드 명령행 도구. 
* `json4jar`: 업로드 도구에 필요한 JSON 형식의 라이브러리. 
* `build.xml`: 단일 파일 또는 일련의 파일을 Application Center에 업로드하는 데 사용할 수 있는 샘플 Ant 스크립트. 
* `acdeploytool.sh` 및 `acdeploytool.bat`: `applicationcenterdeploytool.jar` 파일을 사용하여 Java를 호출하는 단순 스크립트. 

예를 들어, 애플리케이션 `app.apk` 파일을 사용자 ID `demo` 및 비밀번호 `demo`를 사용하여 `localhost:9080/applicationcenter`의 저장소에 배치하려면, 다음을 작성하십시오. 

```bash
Java com.ibm.appcenter.Upload -s http://localhost:9080 -c applicationcenter -u demo -p demo app.apk
```
