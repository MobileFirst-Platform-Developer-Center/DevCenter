---
layout: tutorial
title: Application Center 콘솔
relevantTo: [ios,android,windows,javascript]
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
Application Center 콘솔을 사용하여 Application Center의 저장소 및 애플리케이션을 관리할 수 있습니다.

Application Center 콘솔은 Application Center의 저장소를 관리하기 위한 웹 애플리케이션입니다. Application Center 저장소는 모바일 디바이스에 설치될 수 있는 모바일 애플리케이션을 저장하는 중앙 위치입니다.

Application Center 콘솔을 사용하여 다음을 수행할 수 있습니다.

* Android, iOS, Windows 8(Windows 스토어 패키지 한정), Windows Phone 8 또는 Windows 10 운영 체제용으로 작성된 애플리케이션을 업로드합니다.
* 모바일 애플리케이션의 여러 버전을 관리합니다.
* 모바일 애플리케이션의 테스터에 대한 피드백을 검토합니다.
* 모바일 디바이스에서 애플리케이션을 나열하고 설치할 권한이 있는 사용자를 정의합니다.
* 어느 디바이스에 어느 애플리케이션이 설치되어 있는지 추적합니다.

> **참고:**
>
> * 관리자 역할이 있는 사용자만 Application Center 콘솔에 로그인할 수 있습니다.
> * 다문화 지원: Application Center 콘솔의 사용자 인터페이스가 변환되지 않았습니다.

#### 다음으로 이동
{: #jump-to }
* [Application Center 콘솔 시작](#starting-the-application-center-console)
* [손상된 로그인 페이지 문제점 해결(Apache Tomcat)](#troubleshooting-a-corrupted-login-page-apache-tomcat)
* [Safari 브라우저의 손상된 로그인 페이지 문제점 해결](#troubleshooting-a-corrupted-login-page-in-safari-browsers)
* [애플리케이션 관리](#application-management)
* [모바일 애플리케이션 추가](#adding-a-mobile-application)
* [공용 앱 스토어로부터 애플리케이션 추가](#adding-an-application-from-a-public-app-store)
* [애플리케이션 특성](#application-properties)
* [애플리케이션 특성 편집](#editing-application-properties)
* [{{ site.data.keys.mf_server }} 및 Application Center의 모바일 애플리케이션 업그레이드](#upgrading-a-mobile-application-in-mobilefirst-server-and-the-application-center)
* [애플리케이션 파일 다운로드](#downloading-an-application-file)

Application Center 콘솔에서 사용자가 전송한 모바일 애플리케이션 버전에 대한 검토를 확인할 수 있습니다.

* [사용자 및 그룹 관리](#user-and-group-management)
* [액세스 제어](#access-control)
* [액세스 제어 관리](#managing-access-control)
* [디바이스 관리](#device-management)
* [Windows 8 Universal의 애플리케이션 등록 토큰](#application-enrollment-tokens-in-windows-8-universal)
* [Application Center 콘솔에서 로그아웃](#signing-out-of-the-application-center-console)

## Application Center 콘솔 시작
{: #starting-the-application-center-console }
웹 브라우저에서 Application Center를 시작할 수 있으며 관리자 역할이 있는 경우 로그인할 수 있습니다.

1. 데스크탑에서 웹 브라우저 세션을 시작하십시오.
2. 시스템 관리자에게 문의하여 Application Center가 설치되어 있는 서버의 주소와 포트를 확보하십시오.
3. 다음 URL `http://server/appcenterconsole`을 입력하십시오.
4. 여기서 **server**는 Application Center가 설치되어 있는 서버의 주소 및 포트입니다. `http://localhost:9080/appcenterconsole`

Application Center에 로그인하십시오. 시스템 관리자에게 문의하여 Application Center 콘솔에 로그인할 수 있도록 인증 정보를 얻으십시오.

![Application Center 콘솔 로그인](ac_startconsole.jpg)

> **참고:** 관리자 역할이 있는 사용자만 Application Center 콘솔에 로그인할 수 있습니다.

## 손상된 로그인 페이지 문제점 해결(Apache Tomcat)
{: #troubleshooting-a-corrupted-login-page-apache-tomcat }
Application Center가 Apache Tomcat에서 실행 중인 경우 Application Center 콘솔의 손상된 로그인 페이지를 복구할 수 있습니다.

Application Center가 Apache Tomcat에서 실행 중인 경우 잘못된 사용자 이름 또는 비밀번호의 사용으로 Application Center 콘솔의 로그인 페이지가 손상될 수 있습니다.

잘못된 사용자 이름 또는 잘못된 비밀번호를 사용하여 콘솔에 로그인하려고 시도하면 오류 메시지가 표시됩니다. 사용자 이름 또는 비밀번호를 정정하면 로그인에 성공하는 대신 다음 오류 중 하나가 발생합니다. 메시지는 브라우저에 따라 달라집니다.

* 이전과 동일한 오류 메시지
* **연결이 재설정됨**이라는 메시지
* **로그인에 허용된 시간이 초과됨**이라는 메시지

동작은 j_security_check 서블릿의 Apache Tomcat에 의한 관리로 링크됩니다. 이 동작은 Apache Tomcat에 특정하며 WebSphere Application Server 프로파일에서는 발생하지 않습니다.

임시 해결책으로는 로그인에 실패한 후 브라우저의 새로 고치기 단추를 클릭하여 웹 페이지를 새로 고치는 것입니다. 그런 다음, 올바른 인증 정보를 입력하십시오.

## Safari 브라우저의 손상된 로그인 페이지 문제점 해결
{: #troubleshooting-a-corrupted-login-page-in-safari-browsers }
Safari 브라우저를 사용하는 경우 Application Center 콘솔의 손상된 로그인 페이지를 복구할 수 있습니다.

Application Center 콘솔을 Safari 브라우저에서 여는 경우 콘솔에서 벗어날 수 있습니다. 다시 콘솔로 돌아오면 로그인 페이지를 볼 수 있습니다. 올바른 로그인 세부사항을 입력하더라도 로그인에 성공하는 대신 다음 메시지가 표시됩니다. **HTTP 상태 404 - appcenterconsole/j_security_check.**

동작은 Safari 브라우저에서 캐싱 문제점으로 링크됩니다.

임시 해결책은 인증 정보가 자동 완성되거나 입력하지 않고 로그인 페이지가 표시되는 경우 강제 다시 로드를 트리거하는 것입니다. 다음은 강제 다시 로드를 트리거하는 방법입니다.

* Mac 컴퓨터에서, Shift + **새로 고치기** 단추를 누르십시오.
* iPad 또는 iPhone 디바이스의 경우: 새로 고치기 단추를 두 번 클릭하거나 Safari 브라우저를 닫아 캐시를 지우십시오. 홈 단추를 두 번 클릭한 후 Safari를 쓸어넘기십시오.

## 애플리케이션 관리
{: #application-management }
애플리케이션 관리를 사용하여 새 애플리케이션 및 버전을 추가하고 이러한 애플리케이션을 관리할 수 있습니다.  
Application Center를 통해 새 애플리케이션 및 버전을 추가하고 이러한 애플리케이션을 관리할 수 있습니다.

**애플리케이션**을 클릭하여 애플리케이션 관리에 액세스하십시오.

### WebSphere Application Server Liberty 프로파일 또는 Apache Tomcat에 설치되어 있는 Application Center
{: #application-center-installed-on-websphere-application-server-liberty-profile-or-on-apache-tomcat }
IBM Installation Manager 패키지를 사용하여 {{ site.data.keys.product_full }}을 설치하는 동안 이러한 애플리케이션 서버에서 Application Center의 설치에는 시작하는 데 사용할 수 있는 두 개의 다른 사용자가 정의되어 있습니다.

* 로그인 ID **demo**와 비밀번호 **demo**를 사용하는 사용자
* 로그인 ID **appcenteradmin**와 비밀번호 **admin**을 사용하는 사용자

### WebSphere Application Server 전체 프로파일
{: #websphere-application-server-full-profile }
WebSphere Application Server 전체 프로파일에 Application Center를 설치한 경우 기본적으로 appcenteradmin이라는 하나의 사용자가 설치 프로그램에서 표시한 비밀번호와 함께 작성됩니다.

![사용 가능한 애플리케이션](ac_app_mgt.jpg)

## 모바일 애플리케이션 추가
{: #adding-a-mobile-application }
Application Center 콘솔을 사용하여 서버의 저장소에 애플리케이션을 추가할 수 있습니다. 그런 다음, 모바일 클라이언트를 사용하여 이러한 애플리케이션을 모바일 디바이스에 설치할 수 있습니다.

애플리케이션 보기에서 Application Center에 애플리케이션을 추가할 수 있습니다. 처음에는 애플리케이션 목록이 비어 있으며 애플리케이션 파일을 업로드해야 합니다. 애플리케이션 파일은 이 프로시저에서 설명됩니다.

모바일 디바이스에 설치할 수 있도록 애플리케이션을 추가하려면 다음을 수행하십시오.

1. **애플리케이션 추가**를 클릭하십시오.
2. **업로드**를 클릭하십시오.
3. Application Center 저장소에 업로드할 애플리케이션 파일을 선택하십시오.

   ### Android
   {: #android }
   애플리케이션 파일 이름 확장자는 **.apk**입니다.

   ### iOS
   {: #ios }
   일반 iOS 애플리케이션의 애플리케이션 파일 이름 확장자는 **.ipa**입니다.

   ### Windows Phone 8
   {: #windows-phone-8 }
   애플리케이션 파일 이름 확장자는 **.xap**입니다. 애플리케이션은 회사 계정을 사용하여 서명해야 합니다. 이 회사 계정에 대한 애플리케이션 등록 토큰을 Windows Phone 8 디바이스에서 사용할 수 있어야 애플리케이션을 디바이스에 설치할 수 있습니다. 자세한 내용은 [Windows 8 Universal의 애플리케이션 등록 토큰](#application-enrollment-tokens-in-windows-8-universal)을 참조하십시오.

   ### Windows 8
   {: #windows-8 }
   애플리케이션은 Windows 스토어 패키지로 제공되며, 파일 확장자는 **.appx**입니다.

   Windows 스토어 .appx 패키지는 "프레임워크" 패키지로도 알려진 하나 이상의 Windows 컴포넌트 라이브러리 앱 패키지에 따라 달리질 수 있습니다. Windows 8용 MobileFirst 하이브리드 애플리케이션은 Microsoft.WinJS 프레임워크 패키지에 따라 다릅니다. 애플리케이션 패키지를 생성하는 데 Microsoft Visual Studio를 사용하는 경우 종속성 패키지도 생성되며 별도의 .appx 파일로 패키지됩니다. 모바일 클라이언트를 사용하여 이러한 애플리케이션을 설치하려면, 애플리케이션 .appx 패키지 및 다른 종속성 패키지를 Application Center 서버에 업로드해야 합니다. 종속성 패키지를 업로드하는 경우 Application Center 콘솔에서 비활성으로 표시됩니다. 프레임워크 패키지가 클라이언트에서 설치 가능한 애플리케이션으로 표시되지 않으므로 이는 예상된 동작입니다. 나중에 사용자가 애플리케이션을 설치하는 경우 모바일 클라이언트는 종속성이 디바이스에 이미 설치되어 있는지 확인합니다. 종속성 패키지가 설치되어 있지 않은 경우, 클라이언트는 자동으로 Application Center 서버에서 종속성 패키지를 검색하며 이를 디바이스에 설치합니다. 종속성에 대한 자세한 정보는 애플리케이션의 패키지 및 배치에 대한 Windows 개발자 문서에 있는 [종속성](http://msdn.microsoft.com/library/windows/apps/hh464929.aspx#dependencies)을 참조하십시오.

   ### Windows 10 Universal
   {: windows-10-universal}
   애플리케이션 파일 이름 확장자는 **.appx**입니다.



4. 애플리케이션의 정의를 완료하기 위해 특성에 액세스하려면 **다음**을 클릭하십시오.
5. 특성을 완료하여 애플리케이션을 정의하십시오. 특성 값을 완료하는 방법에 대한 정보는 [애플리케이션 특성](#application-properties)을 참조하십시오.
6. **완료**를 클릭하십시오.

![애플리케이션 특성, 애플리케이션 추가](ac_add_app_props.jpg)

## 공용 앱 스토어에서 애플리케이션 추가
{: #adding-an-application-from-a-public-app-store }
Application Center는 Google Play 또는 Apple iTunes와 같은 서드파티 애플리케이션 스토어에 저장되는 카탈로그 애플리케이션에 대한 추가 기능을 지원합니다.

서드파티 앱 스토어의 애플리케이션은 다른 애플리케이션처럼 Application Center 카탈로그에 표시되지만, 사용자는 애플리케이션을 설치하기 위해 해당하는 공용 앱 스토어로 경로가 지정됩니다. 사용자 기업 내에서 작성한 애플리케이션을 추가하는 장소와 동일하게 콘솔의 공용 앱 스토어로부터 애플리케이션을 추가합니다. [모바일 애플리케이션 추가](#adding-a-mobile-application)를 참조하십시오.

> **참고:** 현재 Application Center는 Google Play 및 Apple iTunes만 지원합니다. Windows Phone 스토어 및 Windows 스토어는 아직 지원되지 않습니다.

애플리케이션 실행 파일 대신에 애플리케이션이 저장되는 서드파티 애플리케이션 스토어에 URL을 제공해야 합니다. 콘솔은 올바른 애플리케이션 링크를 쉽게 찾을 수 있도록 지원된 서드파티 애플리케이션 스토어 웹 사이트에 대한 직접 링크를 **애플리케이션 추가** 페이지에 제공합니다.

Google Play 스토어 주소는 [https://play.google.com/store/apps](https://play.google.com/store/apps)입니다.

Apple iTunes 스토어 주소는 [https://linkmaker.itunes.apple.com/](https://linkmaker.itunes.apple.com/)입니다. 노래, 팟캐스트 및 Apple에서 지원하는 다른 항목을 포함하여 모든 종류의 iTunes 항목에 대해 이 사이트를 검색할 수 있기 때문에 iTunes 사이트 대신 링크 메이커 사이트를 사용하십시오. iOS 애플리케이션 선택만으로 애플리케이션 링크를 작성하기 위한 호환 가능한 링크가 제공됩니다.

1. 찾아보려는 공용 앱 스토어의 URL을 클릭하십시오.
2. 서드파티 앱 스토어에서 애플리케이션의 URL을 Application Center 콘솔의 **애플리케이션 추가** 페이지에 있는 **애플리케이션 URL** 텍스트 필드에 복사하십시오.
    * **Google Play:**
        * 스토어에서 애플리케이션을 선택하십시오.
        * 애플리케이션의 세부사항 페이지를 클릭하십시오.
        * 주소 표시줄의 URL을 복사하십시오.
    * **Apple iTunes:**
        * 검색 결과에 항목의 목록이 리턴되면 원하는 항목을 선택하십시오.

        * 애플리케이션 세부사항 페이지를 열려면 선택한 애플리케이션의 맨 아래에서 **직접 링크**를 클릭하십시오.

        * 주소 표시줄의 URL을 복사하십시오.

          **참고:** **직접 링크**를 Application Center에 복사하지 마십시오. **직접 링크**는 경로가 재지정되는 URL이며, 사용자는 경로 재지정 대상 URL을 알고 있어야 합니다.

3. 애플리케이션 링크가 콘솔의 **애플리케이션 URL** 텍스트 필드에 있는 경우 **다음**을 클릭하여 애플리케이션 링크 작성의 유효성을 검증하십시오.
    * 유효성 검증에 실패하면 오류 메시지가 **애플리케이션 추가** 페이지에 표시됩니다. 다른 링크를 시도하거나 현재 링크를 작성하기 위한 시도를 취소할 수 있습니다.
    * 유효성 검증에 성공하면 이 조치는 애플리케이션 특성을 표시합니다. 다음 단계로 이동하기 전에 애플리케이션 특성에서 애플리케이션 설명을 수정할 수 있습니다.

    ![애플리케이션 특성에서 수정된 애플리케이션 설명](ac_add_public_app_details.jpg)

4. **완료**를 클릭하여 애플리케이션 링크를 작성하십시오.

    이 조치를 통해 Application Center 모바일 클라이언트의 해당 버전에서 애플리케이션을 사용할 수 있습니다. 이 애플리케이션이 공용 앱 스토어에 저장되고 2진 앱과 다르다는 것을 표시하기 위해 애플리케이션 아이콘에 작은 링크 아이콘이 표시됩니다.

    ![Google Play에 저장된 애플리케이션에 대한 링크](ac_public_app_available.jpg)

## 애플리케이션 특성
{: #application-properties }
애플리케이션에는 특성 세트가 있고 모바일 디바이스의 운영 체제에 따라 다르며 이를 편집할 수 없습니다. 또한 애플리케이션에는 공통 특성과 편집 가능한 특성이 있습니다.

다음 필드의 값은 애플리케이션에서 가져온 값이며 편집할 수 없습니다.

* **패키지**.
* **내부 버전**.
* **상업용 버전**.
* **레이블**.
* **외부 URL**. 이 특성은 Android, iOS 및 Windows Phone 8에서 실행되는 애플리케이션에 대해 지원됩니다.

### Android 애플리케이션의 특성
{: #properties-of-android-applications }
다음 특성에 자세한 정보는 Android SDK 문서를 참조하십시오.

* **패키지**는 애플리케이션의 패키지 이름이며 애플리케이션의 Manifest 파일에 있는 Manifest 요소의 **패키지** 속성입니다.
* **내부 버전**은 애플리케이션의 내부 버전 ID이며 애플리케이션의 Manifest 파일에 있는 **manifest** 요소의 **android:versionCode** 속성입니다.
* **상업용 버전**은 애플리케이션의 공개 버전입니다.
* **레이블**은 애플리케이션의 레이블이며 애플리케이션의 **manifest** 파일에 있는 애플리케이션 요소의 **android:label 속성**입니다.
* **외부 URL**은 현재 애플리케이션의 최신 버전에 대한 세부사항 보기에서 Application Center의 모바일 클라이언트가 자동으로 시작되도록 하는 데 사용할 수 있는 URL입니다.

### iOS 애플리케이션의 특성
{: #properties-of-ios-applications }
다음 특성에 대한 자세한 정보는 iOS SDK 문서를 참조하십시오.

* **패키지**는 회사 ID 및 제품 이름이며 **CFBundleIdentifier** 키입니다.
* **내부 버전**은 애플리케이션의 빌드 번호이며 애플리케이션의 **CFBundleVersion** 키입니다.
* **상업용 버전**은 애플리케이션의 공개 버전입니다.
* **레이블**은 애플리케이션의 레이블이며 애플리케이션의 **CFBundleDisplayName** 키입니다.
* **외부 URL**은 현재 애플리케이션의 최신 버전에 대한 세부사항 보기에서 Application Center의 모바일 클라이언트가 자동으로 시작되도록 하는 데 사용할 수 있는 URL입니다.

### Windows Phone 8 애플리케이션의 특성
{: #properties-of-windows-phone-8-applications }
다음 특성에 대한 자세한 정보는 Windows Phone 문서를 참조하십시오.

* **패키지**는 애플리케이션의 제품 ID이며 애플리케이션의 Manifest 파일에 있는 앱 요소의 **ProductID** 속성입니다.
* **내부 버전**은 애플리케이션의 버전 ID이며 애플리케이션의 Manifest 파일에 있는 앱 요소의 **Version** 속성입니다.
* **상업용 버전**은 내부 버전과 같이 애플리케이션의 버전입니다.
* **레이블**()은 애플리케이션의 제목입니다. 애플리케이션의 Manifest 파일에 있는 **App** 요소의 **Title** 속성입니다.
* **벤더**는 애플리케이션을 작성한 벤더이며 애플리케이션의 Manifest 파일에 있는 **App** 요소의 **Publisher** 속성입니다.
* **외부 URL**은 현재 애플리케이션의 최신 버전에 대한 세부사항 보기에서 Application Center의 모바일 클라이언트가 자동으로 시작되도록 하는 데 사용할 수 있는 URL입니다.
* **상업용 버전**은 **내부 버전**과 같이 애플리케이션의 버전입니다.

### Windows 스토어 애플리케이션의 특성
{: #properties-of-windows-store-applications }
다음 특성에 대한 자세한 정보는 애플리케이션 개발에 대한 Windows 스토어 문서를 참조하십시오.

* **패키지**는 애플리케이션의 제품 ID이며 애플리케이션의 Manifest 파일에 있는 **패키지** 이름입니다.
* **내부 버전**은 애플리케이션의 버전 ID이며 애플리케이션의 Manifest 파일에 있는 **Version** 속성입니다.
* **상업용 버전**은 **내부 버전**과 같이 애플리케이션의 버전입니다.
* **레이블**은 애플리케이션의 제목이며 애플리케이션의 Manifest 파일에 있는 **패키지** 표시 이름 속성입니다.
* **벤더**는 애플리케이션을 작성한 벤더이며 애플리케이션의 Manifest 파일에 있는 **Publisher** 속성입니다.

### Windows 10 Universal 애플리케이션의 특성
{: #properties-of-windows-10-universal-applications}

* **패키지**는 애플리케이션의 제품 ID이며 애플리케이션의 Manifest 파일에 있는 **패키지** 이름입니다.
* **내부 버전**은 애플리케이션의 버전 ID이며 애플리케이션의 Manifest 파일에 있는 **Version** 속성입니다.
* **상업용 버전**은 **내부 버전**과 같이 애플리케이션의 버전입니다.
* **레이블**은 애플리케이션의 제목이며 애플리케이션의 Manifest 파일에 있는 **패키지** 표시 이름 속성입니다.
* **벤더**는 애플리케이션을 작성한 벤더이며 애플리케이션의 Manifest 파일에 있는 **Publisher** 속성입니다.

### 공통 특성: 작성자
{: #common-property-author }
**작성자** 필드는 읽기 전용입니다. 이 필드는 애플리케이션을 업로드하는 사용자의 **username** 속성을 표시합니다.

### 편집 가능한 특성
{: #editable-properties }
다음 필드를 편집할 수 있습니다.

**설명**  
이 필드를 사용하여 모바일 사용자에게 애플리케이션을 설명합니다.

**권장됨**  
사용자에게 이 애플리케이션을 설치하도록 권장함을 표시하려면 **권장됨**을 선택하십시오. 권장된 애플리케이션은 모바일 클라이언트에서 특수 목록으로 표시됩니다.

**설치 프로그램**  
관리자 전용의 경우: 이 특성은 애플리케이션이 모바일 디바이스에 다른 애플리케이션을 설치하고 애플리케이션에 대한 피드백을 모바일 디바이스에서 Application Center로 전송하는 데 사용된다는 것을 표시합니다. 일반적으로 하나의 애플리케이션만 **설치 프로그램**으로 규정되며 모바일 클라이언트라고 합니다. 이 애플리케이션은 [모바일 클라이언트](../mobile-client)에 문서화되어 있습니다.

**활성**  
애플리케이션을 모바일 디바이스에 설치할 수 있다는 것을 표시하려면 활성을 선택하십시오.

* **활성**을 선택하지 않은 경우 모바일 사용자는 디바이스에 표시되는 사용 가능한 애플리케이션 목록에서 해당 애플리케이션을 볼 수 없으며 애플리케이션은 비활성입니다.
* 애플리케이션 관리의 사용 가능한 애플리케이션 목록에서 **비활성 표시**가 선택되어 있는 경우 애플리케이션을 사용할 수 없습니다. **비활성 표시**가 선택되지 않은 경우에는 애플리케이션이 사용 가능한 애플리케이션 목록에 표시되지 않습니다.

**프로덕션 준비 완료**  
애플리케이션이 프로덕션 환경에서 배치될 준비가 되었으며 따라서 해당 애플리케이션 스토어를 통해 Tivoli Endpoint Manager에서 관리하기에 적합하다는 것을 표시하려면 **프로덕션 준비 완료**를 선택하십시오. 이 특성이 선택되는 애플리케이션만 Tivoli Endpoint Manager에 플래그가 지정됩니다.

## 애플리케이션 특성 편집
{: #editing-application-properties }
업로드된 애플리케이션 목록에서 애플리케이션의 특성을 편집할 수 있습니다.  
업로드된 애플리케이션의 특성을 편집하려면 다음을 수행하십시오.

1. **애플리케이션**을 선택하여 업로드된 애플리케이션의 목록인 사용 가능한 애플리케이션을 표시하십시오.
2. 애플리케이션의 버전을 클릭하여 애플리케이션 세부사항 특성을 편집하십시오.
3. 원하는 편집 가능한 특성을 편집하십시오. 이러한 특성에 대한 세부사항은 [애플리케이션 특성](#application-properties)을 참조하십시오. 현재 애플리케이션 파일의 이름이 특성 뒤에 표시됩니다.

    > **중요:** 파일을 업데이트하려는 경우 동일한 패키지에 속해야 하며 버전 번호가 동일해야 합니다. 이러한 특성 중 하나가 동일하지 않은 경우 애플리케이션 목록으로 돌아가서 새 버전을 먼저 추가해야 합니다.

4. **확인**을 클릭하여 변경사항을 저장하고 사용 가능한 애플리케이션으로 돌아가거나 **적용**을 클릭하여 저장한 후 애플리케이션 세부사항을 열린 상태로 유지하십시오.

![편집을 위한 애플리케이션 특성](ac_edit_app_props.jpg)

## {{ site.data.keys.mf_server }} 및 Application Center에서 모바일 애플리케이션 업그레이드
{: #upgrading-a-mobile-application-in-mobilefirst-server-and-the-application-center }

> 이는 Android, iOS 및 Windows Phone에만 지원되며 Windows 10 Universal, Blackberry 또는 Windows 8 Universal에는 현재 지원되지 않습니다.


{{ site.data.keys.mf_console }} 및 Application Center의 조합을 사용하여 배치된 모바일 애플리케이션을 쉽게 업그레이드할 수 있습니다.

Application Center의 모바일 클라이언트는 모바일 디바이스에 설치되어야 합니다. HelloWorld 애플리케이션을 모바일 디바이스에 설치해야 하며 애플리케이션이 실행 중인 경우 {{ site.data.keys.mf_server }}에 연결해야 합니다.

이 프로시저를 사용하여 {{ site.data.keys.mf_server }} 및 Application Center에 배치된 Android, iOS 및 Windows Phone을 업데이트할 수 있습니다. 이 태스크에서 애플리케이션 HelloWorld 버전 1.0은 이미 {{ site.data.keys.mf_server }} 및 Application Center에 배치되어 있습니다.

HelloWorld 버전 2.0이 릴리스되었으며 버전 1.0 사용자를 최신 버전으로 업그레이드하려고 합니다. 새 애플리케이션 버전을 배치하려면 다음을 수행하십시오.

1. Application Center에 HelloWorld 2.0을 배치하십시오. [모바일 애플리케이션 추가](#adding-a-mobile-application)를 참조하십시오.
2. 애플리케이션 세부사항 페이지에서 외부 URL의 설정을 복사하십시오.

    ![애플리케이션 세부사항에서 외부 URL 복사](ac_copy_ext_url.jpg)

3. 외부 URL을 클립보드에 복사하는 경우 {{ site.data.keys.mf_console }}을 여십시오.
4. HelloWorld 버전 1.0의 액세스 규칙을 "액세스 사용 안함"으로 변경하십시오.
5. 외부 URL을 URL 필드에 붙여넣으십시오.

    클라이언트 실행: 모바일 디바이스가 HelloWorld 버전 1.0을 실행하기 위해 {{ site.data.keys.mf_server }}에 연결하는 경우 디바이스 사용자에게 애플리케이션의 버전을 업그레이드하도록 요청합니다.

    ![원격으로 애플리케이션의 이전 버전을 사용 안함으로 설정](ac_remote_disable_app_cli.jpg)

6. **업그레이드**를 클릭하여 Application Center 클라이언트를 여십시오. 로그인 세부사항이 올바른 경우 HelloWorld 버전 2.0의 세부사항 페이지에 바로 액세스합니다.

    ![Application Center 클라이언트의 HelloWorld 2.0 세부사항](ac_cli_app_details_upgrade.jpg)

## 애플리케이션 파일 다운로드
{: #downloading-an-application-file }
Application Center에 등록된 애플리케이션의 파일을 다운로드할 수 있습니다.

1. **애플리케이션**을 선택하여 업로드된 애플리케이션의 목록인 **사용 가능한 애플리케이션**을 확인하십시오.
2. **애플리케이션 세부사항** 아래에서 애플리케이션의 버전을 누르십시오.
3. "애플리케이션 파일" 섹션에서 파일 이름을 누르십시오.

## 애플리케이션 검토 보기
{: #viewing-application-reviews }
Application Center 콘솔에서 사용자가 전송한 모바일 애플리케이션 버전에 대한 검토를 확인할 수 있습니다.

모바일 애플리케이션의 사용자는 등급 및 설명이 포함된 검토를 작성하고, Application Center 클라이언트를 통해 검토를 제출할 수 있습니다. 검토는 Application Center 콘솔과 클라이언트에서 사용할 수 있습니다. 개별 검토는 항상 특정 애플리케이션 버전과 연관되어 있습니다.

애플리케이션 버전에 대한 모바일 사용자 또는 테스터의 검토를 보려면 다음을 수행하십시오.

1. **애플리케이션**을 선택하여 업로드된 애플리케이션의 목록인 **사용 가능한 애플리케이션**을 확인하십시오.
2. 애플리케이션의 버전을 선택하십시오.
3. 메뉴에서 **검토**를 선택하십시오.

    ![애플리케이션 버전의 검토](ac_appfeedbk.jpg)

    등급은 기록된 모든 검토의 등급 평균입니다. 1 - 5개의 별로 구성되어 있으며 별 1개는 최하위의 평가 레벨을 표시하고 별 5개는 최상위의 평가 레벨을 표시합니다. 클라이언트는 별 0개 등급을 전송할 수 없습니다.

    평균 등급은 애플리케이션이 애플리케이션의 용도를 충족시키는 방법을 표시합니다.

4. 검토의 일부인 주석을 펼치고 검토가 생성되는 모바일 디바이스의 세부사항을 보려면 이중 화살촉 <img src="down-arrow.jpg" style="margin:0;display:inline" alt="이중 화살촉 단추"/>을 클릭하십시오.

    예를 들어, 주석은 설치 실패와 같은 검토 제출의 이유를 제공할 수 있습니다.
    검토를 삭제하려는 경우 삭제하려는 검토의 오른쪽에 있는 휴지통 아이콘을 클릭하십시오.

## 사용자 및 그룹 관리
{: #user-and-group-management }
사용자 및 그룹을 사용하여 모바일 디바이스에 애플리케이션 설치와 같은 Application Center의 일부 기능에 대한 액세스 권한이 있는 사용자를 정의할 수 있습니다.  
액세스 제어 목록(ACL)의 정의에 있는 사용자 및 그룹을 사용하십시오.

### 등록된 사용자 관리
{: #managing-registered-users }
등록된 사용자를 관리하려면 **사용자/그룹** 탭을 클릭하고 **등록된 사용자**를 선택하십시오. 다음을 포함하는 Application Center의 등록된 사용자 목록을 확보하게 됩니다.

* 모바일 클라이언트 사용자
* 콘솔 사용자
* 로컬 그룹 구성원
* 액세스 제어 목록의 구성원

![Application Center의 등록된 사용자 목록](ac_reg_users.jpg)

Application Center가 LDAP 저장소에 연결되어 있는 경우 사용자 표시 이름을 편집할 수 없습니다. 저장소가 LDAP이 아닌 경우 사용자 표시 이름을 선택한 후 편집하여 이름을 변경할 수 있습니다.

새 사용자를 등록하려면, **사용자 등록**을 클릭하고 로그인 이름 및 표시 이름을 입력한 후 **확인**을 클릭하십시오.  
사용자를 등록 취소하려면, 사용자 이름 옆의 휴지통 아이콘을 클릭하십시오.

* 사용자가 제공한 피드백 제거
* 액세스 제어 목록에서 사용자 제거
* 로컬 그룹에서 사용자 제거

> **참고:** 사용자의 등록을 취소하는 경우 애플리케이션 서버 또는 LDAP 저장소에서 사용자는 제거되지 않습니다.

### 로컬 그룹 관리
{: #managing-local-groups }
로컬 그룹을 관리하려면 **사용자/그룹** 탭을 클릭하고 **사용자 그룹**을 선택하십시오.  
로컬 그룹을 작성하려면 **그룹 작성**을 클릭하십시오. 새 그룹의 이름을 입력하고 **확인**을 클릭하십시오.

Application Center가 LDAP 저장소에 연결되어 있는 경우 검색은 LDAP 저장소에 정의된 그룹 뿐만 아니라 로컬 그룹도 포함합니다. 저장소가 LDAP이 아닌 경우에는 로컬 그룹만 검색에 사용할 수 있습니다.

![로컬 사용자 그룹](ac_loc_group.jpg)

그룹을 삭제하려면 그룹 이름 옆의 휴지통 아이콘을 클릭하십시오. 그룹은 액세스 제어 목록에서도 제거됩니다.  
그룹의 멤버를 추가하거나 제거하려면 그룹의 **멤버 편집** 링크를 클릭하십시오.

![그룹 멤버십 관리](ac_grp_members.jpg)

새 멤버를 추가하려면 사용자 표시 이름을 입력하여 사용자를 검색하고, 사용자를 선택한 후 **추가**를 클릭하십시오.

Application Center가 LDAP 저장소에 연결되어 있는 경우 사용자 검색이 LDAP 저장소에서 수행됩니다. 저장소가 LDAP이 아닌 경우에는 등록된 사용자 목록에서 검색이 수행됩니다.

그룹에서 구성원을 제거하려면 사용자 이름 오른쪽에 있는 X 아이콘을 클릭하십시오.

## 액세스 제어
{: #access-control }
모바일 디바이스에서 애플리케이션의 설치가 모든 사용자에게 개방되어 있는지 또는 애플리케이션을 설치하는 기능을 제한할지 결정할 수 있습니다.

모바일 디바이스에서 애플리케이션의 설치를 특정 사용자로 제한하거나 모든 사용자가 사용 가능하게 할 수 있습니다.

액세스 제어는 버전 레벨이 아닌 애플리케이션 레벨에서 정의됩니다.

기본적으로, 애플리케이션이 업로드되고 나면 모든 사용자가 모바일 디바이스에 애플리케이션을 설치할 수 있습니다.

애플리케이션에 대한 현재 액세스 제어는 각 애플리케이션의 사용 가능한 애플리케이션에 표시됩니다. 설치에 대한 무제한 또는 제한된 액세스 상태는 액세스 제어를 편집하는 페이지에 대한 링크로 표시됩니다.

설치 권한은 모바일 디바이스에서 애플리케이션의 설치에만 해당되는 권한입니다. 액세스 제어를 사용하지 않는 경우 모든 사람이 애플리케이션에 액세스할 수 있습니다.

## 액세스 제어 관리
{: #managing-access-control }
모바일 디바이스에 애플리케이션을 설치하기 위해 사용자 또는 그룹에 대한 액세스 권한을 추가하거나 제거할 수 있습니다.  
액세스 제어를 편집할 수 있습니다.

1. 사용 가능한 애플리케이션 아래의 애플리케이션 관리에서, 애플리케이션 설치의 무제한 또는 제한된 상태를 클릭하십시오.

    ![무제한 또는 제한 모드를 클릭할 위치](ac_app_access_state.jpg)

2. 액세스 제어를 사용으로 설정하려면 **액세스 제어 사용**을 선택하십시오.
3. 액세스 목록에 사용자 또는 그룹을 추가하십시오.

단일 사용자 또는 그룹을 추가하려면, 이름을 입력하고 발견된 일치 항목에서 항목을 선택한 후 **추가**를 클릭하십시오.

Application Center가 LDAP 저장소에 연결되어 있는 경우 로컬로 정의된 그룹뿐만 아니라 저장소에서 사용자 및 그룹을 검색할 수 있습니다. 저장소가 LDAP이 아닌 경우 로컬 그룹 및 등록된 사용자만 검색할 수 있습니다. 로컬 그룹은 **사용자/그룹** 탭에만 정의되어 있습니다. Liberty 프로파일 연합 레지스트리를 사용하는 경우, 로그인 이름을 사용해야만 사용자를 검색할 수 있습니다. 결과는 최대 15명의 사용자와 15개의 그룹(50명의 사용자와 50개의 그룹 대신)으로 제한됩니다.

액세스 목록에 사용자를 추가하면서 동시에 사용자를 등록하려면, 이름을 입력하고 **추가**를 클릭하십시오. 그런 다음, 사용자의 로그인 이름 및 표시 이름을 지정해야 합니다.

애플리케이션의 모든 사용자를 추가하려면 **애플리케이션에서 사용자 추가**를 클릭하고 적절한 애플리케이션을 선택하십시오.  
사용자 또는 그룹에서 액세스 권한을 제거하려면 이름 오른쪽에 있는 십자 아이콘을 클릭하십시오.

![액세스 목록에 사용자 추가 또는 제거](ac_instal_access.jpg)

## 디바이스 관리
{: #device-management }
Application Center 모바일 클라이언트 및 해당 특성에서 Application Center로 연결된 디바이스를 볼 수 있습니다.

**디바이스 관리**는 Application Center 모바일 클라이언트에서 한 번 이상 Application Center에 연결된 디바이스 목록을 **등록된 디바이스** 아래에 표시합니다.

![디바이스 목록](ac_reg_devices.jpg)

### 디바이스 특성
{: #device-properties }
디바이스의 특성 또는 해당 디바이스에 설치된 애플리케이션을 보려면 디바이스 목록에서 디바이스를 클릭하십시오.

![디바이스 특성](ac_edit_deviceprops.jpg)

디바이스 특성을 보려면 **특성**을 선택하십시오.

**이름**  
디바이스의 이름입니다. 이 특성을 편집할 수 있습니다.

> **참고:** iOS에서 사용자는 설정 > 일반 > 정보 > 이름의 디바이스 설정에서 이 이름을 정의할 수 있습니다. 동일한 이름이 iTunes에 표시됩니다.

**사용자 이름**  
디바이스에 로그인한 첫 번째 사용자의 이름.

**제조업체**  
디바이스의 제조업체.

**모델 **  
모델 ID.

**운영 체제**  
모바일 디바이스의 운영 체제.

**고유 ID**  
모바일 디바이스의 고유 ID.

디바이스 이름을 편집하는 경우 이름을 저장하고 등록된 디바이스로 돌아가려면 **확인**을 클릭하고, 저장한 후 디바이스 특성 편집 창을 열린 상태로 유지하려면 **적용**을 클릭하십시오.

### 디바이스에 설치된 애플리케이션
{: #applications-installed-on-device }
디바이스에 설치된 모든 애플리케이션을 나열하려면 **디바이스에 설치된 애플리케이션**을 선택하십시오.

![디바이스에 설치된 애플리케이션](ac_apps_on_device.jpg)

## Windows 8 Universal의 애플리케이션 등록 토큰
{: #application-enrollment-tokens-in-windows-8-universal }
Windows 8 Universal 운영 체제에서 회사 애플리케이션을 디바이스에 설치하려면 사용자가 각 디바이스를 회사에 등록해야 합니다. 디바이스를 등록하는 한 가지 방법은 애플리케이션 등록 토큰을 사용하는 것입니다.

애플리케이션 등록 토큰을 통해 Windows 8 Universal 디바이스에 회사 애플리케이션을 설치할 수 있습니다. 디바이스를 회사에 등록하려면 먼저 지정된 회사에 대한 등록 토큰을 디바이스에 설치해야 합니다. 그런 다음, 해당 회사에서 작성하고 서명하는 애플리케이션을 설치할 수 있습니다.
Application Center는 등록 토큰의 전달을 간소화합니다. Application Center 카탈로그의 관리자로서, Application Center 콘솔에서 등록 토큰을 관리할 수 있습니다. 등록 토큰이 Application Center 콘솔에서 선언되면 Application Center 사용자가 자신의 디바이스를 등록하는 데 사용할 수 있습니다.

Application Center의 설정 보기에서 사용 가능한 등록 토큰 인터페이스를 통해 Windows 8 Universal용 애플리케이션 등록 토큰을 등록, 업데이트 또는 삭제하여 이를 관리할 수 있습니다.

### 애플리케이션 등록 토큰 관리
{: #managing-application-enrollment-tokens }
Application Center의 관리자로서, Application Center 설정을 표시하기 위해 화면 헤더에 있는 기어 아이콘을 클릭하여 등록된 토큰 목록에 액세스할 수 있습니다. 그런 다음, 등록된 토큰의 목록을 표시하려면 **등록 토큰**을 선택하십시오.

디바이스를 등록하려면, 디바이스 사용자가 Application Center 모바일 클라이언트를 설치하기 전에 토큰 파일을 업로드하고 설치해야 합니다. 모바일 클라이언트도 회사 애플리케이션입니다. 따라서 모바일 클라이언트를 설치할 수 있으려면 디바이스가 등록되어야 합니다.

등록된 토큰은 `http://hostname:portnumber/applicationcenter/installers.html`의 부트스트랩 페이지를 통해 사용 가능하며 여기서 **hostname**은 Application Center를 호스팅하는 서버의 호스트 이름이고 **portnumber**는 해당하는 포트 번호입니다.

Application Center 콘솔에서 토큰을 등록하려면, **토큰 업로드**를 클릭하고 토큰 파일을 선택하십시오. 토큰 파일 확장자는 aetx입니다.  
토큰의 인증서 제목을 업데이트하려면, 목록에서 토큰 이름을 선택하고 값을 변경한 후 확인을 클릭하십시오.  
토큰을 삭제하려면, 목록에서 토큰의 오른쪽에 있는 휴지통 아이콘을 클릭하십시오.

## Application Center 콘솔에서 로그아웃
{: #signing-out-of-the-application-center-console }
보안을 위해 관리 태스크를 완료하고 나면 콘솔에서 로그아웃해야 합니다.

Application Center 콘솔에 대한 보안 사인온에서 로그아웃하려면 다음을 수행하십시오.  
Application Center 콘솔에서 로그아웃하려면, 모든 페이지의 배너에 표시되는 시작 메시지 옆에 있는 **로그아웃**을 클릭하십시오.
