---
layout: tutorial
title: Application Center
relevantTo: [ios,android,windows,javascript]
show_children: true
weight: 13
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
용도, 여러 컴포넌트 및 기능, 콘솔 및 클라이언트 사용 방법 등 {{ site.data.keys.mf_app_center_full }}에 대해 학습하십시오. 

모바일 디바이스 판매는 이제 개인용 컴퓨터의 판매를 앞지르고 있습니다. 따라서 모바일 애플리케이션이 비즈니스에 매우 중요해졌습니다.   
Application Center는 조직 내에서 모바일 애플리케이션을 쉽게 공유할 수 있도록 지원하는 도구입니다. 

Application Center를 엔터프라이즈 애플리케이션 저장소로 사용할 수 있습니다. Application Center를 사용하여 일부 모바일 애플리케이션의 대상을 회사 내 특정 사용자 그룹으로 지정할 수 있습니다. 

개발 팀은 애플리케이션 개발 단계 중에 Application Center를 사용하여 회사의 테스터, 디자이너 또는 경영진과 애플리케이션을 공유할 수도 있습니다. 이러한 시나리오에서는 개발 프로세스에 관련된 모든 사용자 간의 협업이 더욱 용이해집니다. 

> 또한 [Application Center 학습서](app-center-tutorial)를 검토할 수 있습니다. 

#### 다음으로 이동
{: #jump-to }
* [Application Center의 개념](#concept-of-application-center)
* [특정 플랫폼 요구사항](#specific-platform-requirements)
* [일반 아키텍처](#general-architecture)
* [예비 정보](#preliminary-information)
* [다음 내용](#whats-next)

## Application Center의 개념
{: #concept-of-application-center }
Application Center를 엔터프라이즈 애플리케이션 저장소로 사용할 수 있으며 Application Center를 통해 회사 내의 서로 다른 팀 구성원 간에 정보를 공유할 수 있습니다. 

Application Center의 개념은 회사 내의 개인 사용만 대상으로 한다는 점을 제외하고는 Apple 공용 앱 스토어 또는 Android Market의 개념과 유사합니다. 

Application Center를 사용하면 동일한 회사 또는 조직의 사용자가 모바일 애플리케이션의 저장소 역할을 수행하는 단일 위치에서 휴대전화 또는 태블릿으로 애플리케이션을 다운로드합니다. 

Application Center는 디바이스 자체에 설치되어 있는 모바일 애플리케이션을 대상으로 합니다. 이러한 애플리케이션은 원시 및 웹 컨텐츠를 혼합하는 하이브리드 애플리케이션 또는 디바이스 SDK를 사용하여 빌드되는 기본 애플리케이션입니다. Application Center는 모바일 웹 애플리케이션을 대상으로 하지 않습니다. 이러한 애플리케이션은 웹 사이트와 같은 URL을 통해 모바일 디바이스 웹 브라우저에 전달됩니다. 

현재 버전에서 Application Center는 Google Android 플랫폼, Apple iOS 플랫폼, Windows Phone 8 플랫폼, Windows 8 플랫폼 및 Windows 10 플랫폼용으로 빌드된 애플리케이션을 지원합니다. 

Windows Phone의 경우에는 현재 Windows Phone 애플리케이션 패키지(.xap) 파일 형식만 지원됩니다. Windows 10 UWP 앱 패키지(.appx) 파일 형식 또한 지원됩니다. Windows 스토어(데스크탑 애플리케이션)의 경우, 앱 패키지(.appx) 파일 형식이 지원됩니다. 

Windows Phone 7과 Windows RT 및 BlackBerry OS는 현재 Application Center 버전에서는 지원하지 않습니다. 

Application Center는 모바일 애플리케이션을 관리하며, {{ site.data.keys.product }} 위에 빌드된 애플리케이션을 포함하여 모든 종류의 Android, iOS, Windows Phone, Windows 8 또는 Windows 10 애플리케이션을 지원합니다. 

애플리케이션의 개발 프로세스 일부로 Application Center를 사용할 수 있습니다. Application Center의 일반 시나리오는 모바일 애플리케이션을 빌드하는 팀입니다. 개발 팀은 Android, iOS, Windows Phone 8, Windows 8 또는 Windows 10 UWP 애플리케이션의 새 버전을 작성합니다. 개발 팀은 이 새 버전을 확장 팀에서 검토하고 테스트하기를 원합니다. 개발자는 Application Center 콘솔로 이동하여 애플리케이션의 새 버전을 Application Center로 업로드합니다. 이 프로세스의 일부로 개발자는 애플리케이션 버전에 대한 설명을 입력할 수 있습니다. 예를 들어, 설명에는 개발 팀이 이전 버전에서 추가하거나 수정한 요소를 언급할 수 있습니다. 그리고 나면, 새 버전의 애플리케이션을 팀의 다른 구성원들이 사용할 수 있습니다. 

베타 테스터와 같은 다른 사용자의 경우 Application Center 설치 프로그램 애플리케이션, 모바일 클라이언트를 시작하여 사용 가능한 애플리케이션의 목록에서 모바일 애플리케이션의 이 새 버전을 찾고 테스터의 모바일 디바이스에 설치할 수 있습니다. 새 버전을 테스트한 후 베타 테스터는 애플리케이션의 등급을 지정하고 피드백을 제출할 수 있습니다. 피드백은 Application Center 콘솔의 개발자가 볼 수 있습니다. 

Application Center는 회사 또는 그룹 내 모바일 애플리케이션을 공유하는 편리한 방법입니다. 팀 구성원 간에 정보 공유의 수단입니다. 

## 특정 플랫폼 요구사항
{: #specific-platform-requirements }
각 운영 체제는 적절한 모바일 디바이스에서 애플리케이션을 배치, 설치 또는 사용하기 위한 특정 요구사항이 있습니다. 

### Android
{: #android }
알 수 없는 소스로부터 설치를 위해 모바일 디바이스를 구성해야 합니다. Android 설정에서 해당 토글을 찾을 수 있습니다. 세부사항은 [알 수 없는 소스의 앱을 위한 사용자 옵트인](http://developer.android.com/distribute/open.html#unknown-sources)을 참조하십시오.   

Application Center에서 애플리케이션은 내부 및 상업용 버전 번호를 갖습니다. 상업용 버전이 정보 표시 문자열로만 사용되는 반면 내부 버전 번호는 최신 버전을 구분하는 데 사용됩니다. Android 애플리케이션의 경우, 내부 버전은 애플리케이션 Manifest의 android:[versionCode](http://developer.android.com/guide/topics/manifest/manifest-element.html#vcode)이며 이는 정수여야 합니다.

### iOS
{: #ios }
Application Center를 통해 관리되는 모든 애플리케이션은 "임시 배포"용으로 패키지되어야 합니다. iOS 개발자 계정으로 최대 100개의 iOS 디바이스와 사용자의 애플리케이션을 공유할 수 있습니다. iOS 엔터프라이즈 계정이 있는 경우 사용자의 내부 애플리케이션을 iOS 디바이스와 무제한으로 공유할 수 있습니다. 세부사항은 [iOS 개발자 프로그램](https://developer.apple.com/programs/ios/distribute.html) 및 [iOS 엔터프라이즈 프로그램](https://developer.apple.com/programs/ios/enterprise/)을 참조하십시오. Application Center에서 애플리케이션은 내부 및 상업용 버전 번호를 갖습니다. 상업용 버전이 정보 표시 문자열로만 사용되는 반면 내부 버전 번호는 최신 버전을 구분하는 데 사용됩니다. iOS 애플리케이션의 경우, 내부 버전은 애플리케이션 Manifest **Info.plist**의 CFBundleVersion입니다. 버전 번호의 형식은 `a` 또는 `a.b`이거나 `a.b.c`이어야 합니다. 여기서 `a`, `b`, `c`는 음수가 아닌 정수이고 `a`는 `0`이 아닙니다. 

### Windows Phone 8
{: #windows-phone-8 }
애플리케이션은 Windows 스토어가 아닌 Application Center에서 설치됩니다. Application Center는 Microsoft 문서에서 **회사 허브**라고 부르는 것과 같은 역할을 합니다. 세부사항은 [Windows Phone용 회사 앱 배포](http://msdn.microsoft.com/en-us/library/windowsphone/develop/jj206943%28v=vs.105%29.aspx)를 참조하십시오.
회사 허브를 사용하려면, Windows Phone에서는 Microsoft에 회사 계정을 등록하고 Application Center 클라이언트를 포함한 모든 애플리케이션을 회사 인증서로 서명하도록 요구합니다. 서명된 애플리케이션만 Application Center를 통해 관리될 수 있습니다. 

회사 계정과 연관된 애플리케이션 등록 토큰을 통해 모든 모바일 디바이스를 등록해야 합니다. 

Application Center는 애플리케이션 등록 토큰을 분배하기 위한 기능을 통해 디바이스를 등록하도록 지원합니다. [세부사항은 Windows 8 Universal의 애플리케이션 등록 토큰](appcenter-console/#application-enrollment-tokens-in-windows-8-universal)을 참조하십시오. 

Application Center는 Microsoft Windows Phone 8.0 및 Microsoft Windows Phone 8.1에 대해 Windows Phone 애플리케이션 패키지(.xap) 파일로 애플리케이션을 배포하도록 지원합니다. Microsoft Windows Phone 8.1에서 Microsoft는 Windows Phone을 위한 앱 패키지(.appx) 파일로 새로운 유니버셜 형식을 도입했습니다. 현재 Application Center는 Microsoft Windows Phone 8.1에 대한 앱 패키지(.appx) 파일의 배포를 지원하지 않으며 Windows Phone 애플리케이션 패키지(.xap) 파일로만 제한됩니다. 

Application Center에서 애플리케이션은 하나의 버전 번호만 있습니다. 이 버전 번호는 최신 버전을 구별하는 데 사용됩니다. Windows Phone 8 애플리케이션의 경우 버전 번호는 **WMAppManifest.xml** 파일의 **버전** 필드에 있습니다. 이 버전 번호의 형식은 `a.b.c.d`여야 합니다. 여기서 `a`, `b`, `c`, `d`는 음수가 아닌 정수입니다. 

### Windows 8
{: #windows-8 }
Application Center 모바일 클라이언트는 일반 데스크탑 실행 파일(.exe)로 제공됩니다. 이를 사용하여 디바이스에 .appx 파일로 패키징되는 Windows 스토어 애플리케이션을 설치하십시오.
Windows 스토어를 사용하지 않고 디바이스에 appx 유형의 파일을 설치하는 것을 앱 사이드로딩이라고 합니다. 앱을 사이드로드하려면, [앱 사이드로드 준비](http://technet.microsoft.com/fr-fr/library/dn613842.aspx)의 전제조건을 준수해야 합니다. Windows 8.1 업데이트는 사이드로딩에 대한 전제조건을 간소화합니다. 자세한 정보는 [Windows 8.1 디바이스에 스토어 앱 사이드로딩](http://blogs.msdn.com/b/micham/archive/2014/05/30/sideloading-store-apps-to-windows-8-1-devices.aspx)을 참조하십시오. 

.exe 유형의 파일은 ARM 기반 태블릿에서 실행할 수 없으므로 Application Center는 Windows RT를 지원하지 않습니다. Windows 8 및 Windows 8.1만 지원됩니다. 

디바이스 사용자는 Application Center 클라이언트를 실행하려면 디바이스에 대한 관리자 역할이 필요합니다. 

Application Center는 모바일 클라이언트 배포를 위한 사전 정의된 방법을 제공하지 않습니다. 

Application Center에서 애플리케이션은 하나의 버전 번호만 있습니다. 이 버전 번호는 최신 버전을 구별하는 데 사용됩니다. Windows 8 애플리케이션의 경우 버전 번호는 AppxManifest.xml 파일의 버전 필드에 있습니다. 이 버전 번호의 형식은 a.b.c.d여야 하며, 여기서 a, b, c, d는 음수가 아닌 정수입니다. 

### Windows 10 UWP
{:  #windows-10-uwp}

Application Center는 UWP 앱 설치를 위한 Windows 10 UWP 클라이언트 프로젝트를 제공합니다. 이 프로젝트를 Visual Studio에서 열고 배포를 위한 바이너리(예: **.appx**)를 작성할 수 있습니다. Application Center는 모바일 클라이언트 배포를 위한 사전 정의된 방법을 제공하지 않습니다. 

Application Center에서 애플리케이션은 하나의 버전 번호만 있습니다. 이 버전 번호는 최신 버전을 구별하는 데 사용됩니다. Windows 10 UWP 애플리케이션의 경우 버전 번호는 **Package.appxmanifest** 파일의 _**버전**_ 필드에 있습니다. 이 버전 번호의 형식은 a.b.c.d여야 하며, 여기서 a, b, c, d는 음수가 아닌 정수입니다. 


## 일반 아키텍처
{: #general-architecture }
Application Center는 기본 요소 즉, 서버 측 컴포넌트, 저장소, 관리 콘솔 및 모바일 클라이언트 애플리케이션으로 구성되어 있습니다. 

### 서버 측 컴포넌트
{: #server-side-component }
서버 측 컴포넌트는 IBM WebSphere 또는 Apache Tomcat과 같은 웹 애플리케이션 서버에 배치되어야 하는 Java™ 엔터프라이즈 애플리케이션입니다. 

서버 측 컴포넌트는 관리 콘솔과 모바일 애플리케이션으로 구성되어 있습니다. 이 모바일 애플리케이션은 클라이언트 측 컴포넌트에 사용 가능한 모바일 애플리케이션을 설치합니다. 

웹 콘솔 및 설치 프로그램 애플리케이션은 REST 서비스를 통해 서버 컴포넌트와 통신합니다. 

여러 서비스가 Application Center 서버 측 컴포넌트를 구성합니다. 예를 들어, 사용 가능한 애플리케이션을 나열하는 서비스, 모바일 디바이스에 애플리케이션 2진 파일을 전달하는 서비스 또는 피드백 및 등급을 등록하는 서비스입니다. 

### 저장소
{: #repository }
어느 애플리케이션이 어느 디바이스에 설치되어 있는지, 애플리케이션에 대한 피드백 및 모바일 애플리케이션 2진 파일 등의 정보를 저장하는 데이터베이스. 특정 웹 애플리케이션 서버 및 지원되는 데이터베이스에 대해 Application Center를 구성하는 경우 Application Center 애플리케이션은 해당 데이터베이스와 연관됩니다. 

### 관리 콘솔
{: #administration-console }
관리자가 애플리케이션, 애플리케이션을 설치하기 위한 사용자 액세스 권한, 모바일 애플리케이션에 대한 사용자 피드백 및 디바이스에 설치된 애플리케이션에 대한 세부사항을 관리할 수 있는 웹 콘솔입니다. [Application Center 콘솔](appcenter-console)을 참조하십시오. 

### 모바일 클라이언트 애플리케이션
{: #mobile-client-application }
모바일 클라이언트를 사용하여 애플리케이션을 모바일 디바이스에 설치하고 애플리케이션에 대한 피드백을 서버에 보냅니다. [모바일 클라이언트](mobile-client)를 참조하십시오. 

다음 그림은 아키텍처에 대한 개요를 표시합니다. 

![Application Center 아키텍처](ac_arch.jpg)

Application Center 콘솔에서 다음 조치를 수행할 수 있습니다. 

* 모바일 애플리케이션의 다른 버전을 업로드합니다. 
* 원하지 않는 애플리케이션을 제거합니다. 
* 애플리케이션에 대한 액세스를 제어합니다. 각 애플리케이션은 애플리케이션을 설치할 수 있는 사용자 목록과 연관되어 있습니다. 
* 모바일 사용자가 애플리케이션에 대해 전송한 피드백을 살펴봅니다. 
* 디바이스에 설치된 애플리케이션에 대한 정보를 확보합니다. 
* 다운로드를 위해 사용 가능한 애플리케이션에 표시되지 않도록 애플리케이션을 비활성화합니다. 

모바일 클라이언트에서 다음 조치를 수행할 수 있습니다. 

* 사용 가능한 모바일 애플리케이션을 나열합니다. 
* 새 애플리케이션을 디바이스에 설치합니다. 
* 애플리케이션에 대한 피드백을 전송합니다. 

Application Center는 Android, iOS, Windows Phone 8 및 Windows 8 디바이스용 애플리케이션을 지원합니다. 따라서 모바일 클라이언트는 Android, iOS, Windows Phone 8 및 Windows 8에 대해 별도의 버전으로 제공됩니다. 

Android, iOS 및 Windows Phone 8 모바일 클라이언트는 {{ site.data.keys.product }}에서 구축되었습니다. 제품이 설치된 후 다양한 Java 애플리케이션 서버에서 Application Center 서버 측 컴포넌트를 구성하고 Application Center 클라이언트에 대해 {{ site.data.keys.product_adj }} 애플리케이션을 빌드하는 방법에 대해 학습하려면, [설치 후 Application Center 구성](../installation-configuration/production/appcenter)을 참조하십시오. 

## 예비 정보
{: #preliminary-information }
Application Center를 사용하려면, 보안 설정을 구성하고, {{ site.data.keys.product }}이 설치되어 있는 웹 애플리케이션 서버를 시작하고, Application Center 콘솔을 시작한 후 로그인해야 합니다. 

{{ site.data.keys.product }}을 설치하는 경우 Application Center가 지정된 애플리케이션 서버에 자동으로 설치됩니다. 

WebSphere Application Server Liberty 프로파일에 Application Center를 설치하는 경우 서버가 **installation-directory/server**에 작성됩니다. 

설치가 완료된 후 애플리케이션의 보안 설정을 구성해야 합니다. [Application Center에 대해 사용자 인증 구성](../installation-configuration/production/appcenter#configuring-user-authentication-for-application-center)을 참조하거나 LDAP 인증을 사용하는 경우 [LDAP을 사용하여 사용자 관리](../installation-configuration/production/appcenter/#managing-users-with-ldap)를 참조하십시오. 

### 예: Liberty 프로파일에서 서버 및 Application Center 콘솔 시작
{: #example-starting-the-server-and-the-application-center-console-on-liberty-profile}

1. **installation-directory/server/wlp/bin directory**에서 **server** 명령을 사용하여 Liberty 서버를 시작하십시오. 

   ```bash
   server start worklightServer
   ```

2. 서버가 실행 중인 경우 브라우저에 `http://localhost:9080/appcenterconsole/`을 입력하여 Application Center 콘솔을 시작하십시오. 
3. 로그인하십시오. 기본적으로, Apache Tomcat 또는 WebSphere Application Server Liberty 프로파일에서 Application Center 설치에 대해 두 개의 사용자가 정의됩니다. 
    * 비밀번호 **demo**를 사용하는 **demo**
    * 비밀번호 **admin**을 사용하는 **appcenteradmin**

### 추가 정보
{: #for-more-information }
Application Center 콘솔을 사용하려면, [Application Center 콘솔](appcenter-console)을 참조하십시오. 

다음 운영 체제에서 모바일 클라이언트를 설치 및 실행하려면 다음을 참조하십시오. 

* Android: [Android 모바일 디바이스에 클라이언트 설치](mobile-client/#installing-an-application-on-an-android-device)를 참조하십시오. 
* iOS 운영 체제: [iOS 모바일 디바이스에 클라이언트 설치](mobile-client/#installing-an-application-on-an-ios-device)를 참조하십시오. 
* Windows Phone 8: [Windows 8 Universal에 클라이언트 설치](mobile-client/#installing-the-client-on-a-windows-phone-8-universal-mobile-device)를 참조하십시오. 
* Windows 8: Windows 8용 모바일 클라이언트는 나중에 배포하기 위해 Application Center에 배치되지 않습니다. [Microsoft Windows 8: 프로젝트 빌드](preparations/#microsoft-windows-8-building-the-project)를 참조하십시오. 
* Windows 10 UWP: [Windows 10 디바이스에 Windows 10 UWP 클라이언트 설치](mobile-client/#installing-windows-10-uwp-client-on-windows-10-device)를 참조하십시오. 

## 다음 내용
{: #whats-next }
AppCenter 모바일 클라이언트를 사용하려면, 설치된 애플리케이션에 알림 전송, Appcenter 콘솔, 명령행 도구, 모바일 클라이언트에 대해 알아보기 및 로그 레벨 설정 주제에 설명된 프로시저를 따르십시오. 
