---
layout: tutorial
title: 알려진 문제 및 제한사항
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## 알려진 문제
{: #known-issues }
알려진 문제 및 해결책과 관련 다운로드를 포함하여 이 특정 릴리스 및 모든 해당 수정팩에 대한 문서의 동적으로 생성된 목록을 수신하려면 다음 링크를 클릭하십시오. [http://www.ibm.com/support/search.wss?tc=SSVNUQ&tc=SSHT2F&atrn=SWVersion&atrv=8.0](http://www.ibm.com/support/search.wss?tc=SSVNUQ&tc=SSHT2F&atrn=SWVersion&atrv=8.0).

## 알려진 제한사항
{: #known-limitations }
이 문서에서는 {{ site.data.keys.product_full }} 알려진 제한사항에 대한 설명을 여러 위치에서 찾을 수 있습니다. 

* 알려진 제한사항이 특정 기능에 적용되는 경우 이 특정 기능에 대해 설명하는 주제에서 해당 설명을 찾을 수 있습니다. 따라서 해당 제한사항이 기능에 미치는 영향을 즉시 식별할 수 있습니다. 
* 알려진 제한사항이 일반적인 경우(즉 직접적인 관련이 없는 여러 주제에 적용되는 경우) 여기에서 해당 설명을 찾을 수 있습니다. 

### 다국어 지원
{: #globalization }
전세계에 적용할 앱을 개발 중인 경우 다음 제한사항이 적용됩니다. 

* 부분 번역: 해당 문서를 포함하여 제품 {{ site.data.keys.product }} v8.0의 일부는 중국어, 대만어, 프랑스어, 독일어, 이탈리아어, 일본어, 한국어, 포르투갈어(브라질), 러시아어, 스페인어 등의 언어로 번역됩니다. 사용자 대면 텍스트가 번역됩니다.
* 양방향 지원: {{ site.data.keys.product }}에서 생성하는 애플리케이션은 완전히 양방향을 사용하지는 않습니다. 기본적으로 그래픽 사용자 인터페이스(GUI) 요소의 미러링 및 텍스트 방향 제어는 제공되지 않습니다. 그러나 이러한 제한사항으로 인해 생성된 애플리케이션에 대해 강한 종속성은 없습니다. 개발자는 생성된 코드의 수동 조정을 통해 완전한 양방향 호환성을 달성할 수 있습니다. 

{{ site.data.keys.product }} 코어 기능에 대해 히브리어 번역이 제공되지만 일부 GUI 요소가 미러링되지 않습니다. 

* 어댑터 이름에 대한 제한조건: 어댑터 이름은 Java 클래스 이름을 작성하는 데 유효한 이름이어야 합니다. 또한 어댑터 이름은 다음 문자로만 구성되어야 합니다. 
    * 대문자 및 소문자(A-Z 및 a-z)
    * 숫자(0-9)
    * 밑줄(_)

* 유니코드 문자: BMP(Basic Multilingual Plane) 외의 유니코드 문자는 지원되지 않습니다. 
* 언어 민감성 및 UNF(Unicode Normalization Form): 다음 유스 케이스에서는 조회 시에 다른 언어로 제대로 실행하기 위한 검색 기능을 위해 언어 민감성(일반 일치, 액센트 구분 안함, 1 대 2 맵핑)을 고려하지 않으며 데이터 검색 시 NFC(Normalization Form C)를 사용하지 않습니다.
    * {{ site.data.keys.mf_analytics_console }}에서 사용자 정의 차트에 대한 사용자 정의 필터를 작성하는 경우. 그러나 이 콘솔의 메시지 특성에서는 NFC(Normalization Form C)를 사용하고 언어 민감성을 고려합니다. 
    * {{ site.data.keys.mf_console }}로부터 애플리케이션 찾아보기 페이지에서 애플리케이션, 브라우저 어댑터 페이지에서 어댑터, 푸시 페이지에서 태그 또는 디바이스 페이지에서 디바이스를 검색할 경우.
    * JSONStore API의 찾기 기능의 경우.

### {{ site.data.keys.mf_analytics }}
{: #mobilefirst-analytics }
{{ site.data.keys.mf_analytics }}의 제한사항은 다음과 같습니다. 

* 보안 분석(보안 검사에 실패한 요청의 데이터)은 지원되지 않습니다. 
* {{ site.data.keys.mf_analytics_console }}에서 숫자 형식은 ICU(International Components for Unicode) 규칙을 따르지 않습니다.
* {{ site.data.keys.mf_analytics_console }}에서 숫자는 사용자가 선호하는 숫자 스크립트를 사용하지 않습니다.
* {{ site.data.keys.mf_analytics_console }}에서 날짜, 시간 및 숫자 형식은 Microsoft Internet Explorer의 로케일이 아니라 운영 체제의 언어 설정에 따라 표시됩니다.
* 사용자 정의 차트에 대한 사용자 정의 필터를 작성하는 경우, 숫자 데이터는 기본 10, Western 또는 European 숫자(예: 0, 1, 2, 3, 4, 5, 6, 7, 8, 9)이어야 합니다. 
* {{ site.data.keys.mf_analytics_console }}의 경보 관리 페이지에서 경보를 작성할 때 숫자 데이터는 기본 10, Western 또는 European 숫자(예: 0, 1, 2, 3, 4, 5, 6, 7, 8, 9)여야 합니다.
* {{ site.data.keys.mf_console }}의 분석 페이지는 다음 브라우저를 지원합니다. 
    * Microsoft Internet Explorer 버전 10 이상 
    * Mozilla Firefox ESR 이상
    * Apple Safari on iOS 버전 7.0 이상 
    * Google Chrome 최신 버전 
* Analytics 클라이언트 SDK는 Windows에서 사용할 수 없습니다.


### {{ site.data.keys.mf_app_center_full }} 모바일 클라이언트
{: #ibm-mobilefirst-foundation-application-center-mobile-client }
Application Center 모바일 클라이언트는 날짜 형식화와 같이 실행 중인 디바이스의 문화적 규칙을 따릅니다. 보다 엄격한 ICU(International Components for Unicode) 규칙을 항상 따르지는 않습니다. 

### {{ site.data.keys.mf_console_full }}
{: #ibm-mobilefirst-operations-console }
{{ site.data.keys.mf_console }}의 제한사항은 다음과 같습니다. 

* 양방향 언어는 부분적으로만 지원됩니다. 
* Android 디바이스에 알림 메시지가 전송되는 경우 텍스트 방향이 변경될 수 없습니다. 
    * 입력되는 첫 번째 문자가 오른쪽에서 왼쪽으로 표시되는 언어인 경우(예: 아랍어 및 히브리어) 전체 텍스트 방향은 오른쪽에서 왼쪽으로 자동 설정됩니다. 
    * 입력된 첫 번째 문자가 왼쪽에서 오른쪽으로 쓰는 언어인 경우 전체 텍스트 방향은 자동으로 왼쪽에서 오른쪽으로 진행합니다.
* 문자 순서 및 텍스트 맞춤은 양방향 언어의 문화적 방식과 일치하지 않습니다. 
* 숫자 필드는 로케일의 형식화 규칙에 따라 숫자 값을 구문 분석하지 않습니다. 콘솔에는 형식화된 숫자가 표시되지만 입력으로는 형식화되지 않은 *원시* 숫자만 허용됩니다. 예: 1 000 또는 1,000이 아닌 1000입니다.
* {{ site.data.keys.mf_console }}의 분석 페이지에서 응답 시간은 하드웨어(RAM, CPU), 누적된 분석 데이터의 수량 및 {{ site.data.keys.mf_analytics }} 클러스터링 같은 여러 요인에 따라 다릅니다. {{ site.data.keys.mf_analytics }}를 프로덕션에 통합하기 전에 로드를 테스트할 것을 고려하십시오. 

### Server Configuration Tool
{: #server-configuration-tool }
다음과 같은 제한사항이 Server Configuration Tool에 적용됩니다.

* 서버 구성의 설명 이름에는 시스템 문자 세트에 있는 문자만 포함될 수 있습니다. Windows의 경우, ANSI 문자 세트가 해당됩니다.
* 작은따옴표 또는 큰따옴표가 포함된 비밀번호는 올바르게 작동하지 않을 수 있습니다. 
* Server Configuration Tool의 콘솔은 기본 코드 페이지 외부에 있는 문자열을 표시하기 위해 Windows 콘솔과 동일한 다국어 지원 제한사항을 가집니다.

사용 중인 브라우저, 데이터베이스 관리 시스템 또는 SDK(Software Development Kit)와 같은 다른 제품의 제한사항으로 인해 다국어 지원의 다양한 측면에서 제한사항 또는 이상이 발생할 수도 있습니다. 예: 

* ASCII 문자만 사용하여 Application Center의 사용자 이름과 비밀번호를 정의해야 합니다. 이 제한사항은 WebSphere Application Server(전체 또는 Liberty 프로파일)는 비 ASCII 비밀번호 및 사용자 이름을 지원하지 않습니다. 사용자 ID 및 비밀번호에 유효한 문자를 참조하십시오.
* Windows의 경우:
    * 테스트 서버에서 작성하는 로그 파일에서 자국어 메시지를 보려면 UTF8 인코딩을 사용하여 이 로그 파일을 열어야 합니다. 
    * 다음과 같은 원인으로 인해 이러한 제한이 있습니다. 
        * 테스트 서버는 WebSphere Application Server Liberty 프로파일에 설치되며, 이는 UTF8 인코딩을 사용하는 자국어로 지원된 메시지를 제외하고 ANSI 인코딩으로 로그 파일을 작성합니다.

* Java 7.0 Service Refresh 4-FP2 및 이전 버전에서는 BMP(Basic Multilingual Plane)의 일부가 아닌 유니코드 문자를 입력 필드에 붙여넣을 수 없습니다. 이 문제를 해결하려면 경로 폴더를 수동으로 작성하고 설치 중에 해당 폴더를 선택하십시오. 
* 경보, 확인 및 프롬프트 메소드에 대한 사용자 정의 제목 및 단추 이름은 화면 가장자리에서 잘리지 않도록 짧게 유지해야 합니다. 
* JSONStore는 정규화를 처리하지 않습니다. JSONStore API에 대한 찾기 기능은 액센트 구분, 대소문자 구분, 1 대 2 맵핑과 같은 언어 민감성을 고려하지 않습니다. 

### 어댑터 및 써드파티 종속성
{: #adapters-and-third-party-dependencies }
다음 알려진 문제는 {{ site.data.keys.product_adj }} 공유 라이브러리를 포함하여 애플리케이션 서버의 종속성 및 클래스 간 상호작용과 관련이 있습니다. 

#### Apache HttpClient
{: #apache-httpclient }
{{ site.data.keys.product }}는 내부적으로 Apache HttpClient를 사용합니다. Apache HttpClient 인스턴스를 Java 어댑터에 대한 종속 항목으로 추가하는 경우, 어댑터에서 `AdaptersAPI.executeAdapterRequest, AdaptersAPI.getResponseAsJSON` 및 `AdaptersAPI.createJavascriptAdapterRequest`라는 API가 올바르게 작동하지 않습니다. 이는 API의 서명에 Apache HttpClient 유형이 포함되어 있기 때문입니다. 임시 해결책은 내부 Apache HttpClient를 사용하되 제공된 **pom.xml**에서 종속성 범위를 변경하는 것입니다.

#### Bouncy Castle 암호화 라이브러리
{: #bouncy-castle-cryptographic-library }
{{ site.data.keys.product }}는 Bouncy Castle 자체를 사용합니다. 어댑터에서 다른 버전의 Bouncy Castle을 사용할 수는 있지만 결과를 주의깊게 테스트해야 합니다. 일부 경우 {{ site.data.keys.product_adj }} Bouncy Castle 코드로 `javax.security` 패키지 클래스의 특정 정적 싱글톤 필드를 채워 어댑터 내의 Bouncy Castle 버전에서 해당 필드를 기반으로 하는 기능이 사용되는 것을 방지할 수 있습니다. 

#### JAR 파일의 Apache CXF 구현
{: #apache-cxf-implementaton-of-jar-files }
CXF는 {{ site.data.keys.product_adj }} JAX-RS 구현에서 사용되어 어댑터에 Apache CXF JAR 파일을 추가하는 것을 방지합니다. 

### Application Center 모바일 클라이언트: Android 4.0.x의 새로 고치기 문제
{: #application-center-mobile-client-refresh-issues-on-android-40x}
Android 4.0.x WebView 컴포넌트에는 여러 가지 새로 고치기 문제가 있는 것으로 알려져 있습니다. 디바이스를 Android 4.1.x로 업데이트하면 사용자 경험이 향상됩니다. 

소스로부터 Application Center 클라이언트를 빌드할 경우, Android Manifest에서 애플리케이션 레벨에서 하드웨어 가속을 사용 안함으로 설정하면 Android 4.0.x에 대한 상황을 개선해야 합니다. 이 경우 Android SDK 11 이상을 사용하여 애플리케이션을 빌드해야 합니다. 

### Application Center 모바일 클라이언트를 가져오고 빌드하기 위해 Application Center에는 MobileFirst Studio V7.1이 필요합니다. 
{: #application-center-requires-mobilefirst-studio-v71-for-importing-and-building-the-application-center-mobile-client }
Application Center 모바일 클라이언트를 빌드하려면 MobileFirst Studio V7.1이 필요합니다. MobileFirst Studio는 [다운로드 페이지]({{site.baseurl}}/downloads)에서 다운로드할 수 있습니다. **이전 MobileFirst Platform Foundation 릴리스** 탭에서 다운로드 링크를 클릭하십시오. 설치 지시사항에 대해서는 [7.1용 IBM Knowledge Center에 MobileFirst Studio 설치](https://www.ibm.com/support/knowledgecenter/SSHS8R_7.1.0/com.ibm.worklight.installconfig.doc/devenv/t_installing_ibm_worklight_studi.html)를 참조하십시오. Application Center 모바일 클라이언트 빌드에 대한 자세한 정보는 [모바일 클라이언트 사용 준비](../../../appcenter/preparations)를 참조하십시오.

### Application Center 및 Microsoft Windows Phone 8.1
{: #application-center-and-microsoft-windows-phone-81 }
Application Center는 Microsoft Windows Phone 8.0 및 Microsoft Windows Phone 8.1에 대해 Windows Phone 애플리케이션 패키지(.xap) 파일로 애플리케이션을 배포하도록 지원합니다. Microsoft Windows Phone 8.1에서 Microsoft는 Windows Phone을 위한 앱 패키지(.appx) 파일로 새로운 유니버셜 형식을 도입했습니다. 현재 Application Center는 Microsoft Windows Phone 8.1에 대한 앱 패키지(.appx) 파일의 배포를 지원하지 않으며 Windows Phone 애플리케이션 패키지(.xap) 파일로만 제한됩니다. 

Application Center는 Microsoft Windows Store(데스크탑 애플리케이션)용 앱 패키지(.appx) 파일의 분배만 지원합니다. 

### Ant 또는 명령행을 통한 {{ site.data.keys.product_adj }} 애플리케이션 관리
{: #administering-mobilefirst-applications-through-ant-or-through-the-command-line }
{{ site.data.keys.mf_dev_kit_full }}만 다운로드하고 설치하면 **mfpadm** 도구를 사용할 수 없습니다. mfpadm 도구는 설치 프로그램을 사용하여 {{ site.data.keys.mf_server }}와 함께 설치됩니다. 

### 기밀 클라이언트
{: #confidential-clients }
기밀 클라이언트 ID 및 본인확인정보의 값에만 ASCII 문자를 사용하십시오. 

### 직접 업데이트
{: #direct-update }
V8.0.0에서는 Windows 기반 직접 업데이트가 지원되지 않습니다.

### FIPS 140-2 기능 제한사항
{: #fips-104-2-feature-limitations }
{{ site.data.keys.product }}에서 FIPS 140-2 기능을 사용하는 경우 다음과 같은 알려진 제한사항이 적용됩니다. 
* 이 FIPS 140-2 유효성 검증 모드는 JSONStore 기능에 의해 저장되는 로컬 데이터의 보호(암호화) 및 {{ site.data.keys.product_adj }} 클라이언트와 {{ site.data.keys.mf_server }} 간 HTTPS 통신의 보호에만 적용됩니다. 
    * HTTPS 통신의 경우, {{ site.data.keys.product_adj }} 클라이언트와 {{ site.data.keys.mf_server }} 사이의 통신에서만 클라이언트의 FIPS 140-2 라이브러리를 사용합니다. 기타 서버 또는 서비스로 직접 연결하는 경우 FIPS 140-2 라이브러리를 사용하지 않습니다. 
* 이 기능은 iOS 및 Android 플랫폼에서만 지원됩니다.
    * Android의 경우, 이 기능은 x86 또는 armeabi 아키텍처를 사용하는 디바이스 또는 시뮬레이터에서만 지원됩니다. armv5 또는 armv6 아키텍처를 사용하는 Android에서는 지원되지 않습니다. 사용된 OpenSSL 라이브러리가 Android에서 armv5 또는 armv6의 FIPS 140-2 유효성 검증을 받지 못했기 때문입니다. {{ site.data.keys.product_adj }} 라이브러리가 64비트 아키텍처를 지원하더라도 FIPS 140-2는 64비트 아키텍처에서 지원되지 않습니다. 프로젝트에 32비트 고유 NDK 라이브러리가 포함되어 있는 경우에만 FIPS 140-2가 64비트 디바이스에서 실행될 수 있습니다.
    * iOS의 경우, 이 기능은 i386, x86_64, armv7, armv7s 및 arm64 아키텍처에서 지원됩니다. 
* 이 기능은 고유 애플리케이션이 아닌 하이브리드 애플리케이션에서 작동됩니다. 
* 고유 iOS의 경우 FIPS는 iOS FIPS 라이브러리를 통해 사용할 수 있으며 기본적으로 사용으로 설정되어 있습니다. FIPS 140-2를 사용으로 설정하기 위해 조치를 수행할 필요가 없습니다.
* 클라이언트에서 사용자 등록 기능 사용은 FIPS 140-2 기능에서 지원되지 않습니다.
* Application Center 클라이언트는 FIPS 140-2 기능을 지원하지 않습니다. 

### 수정사항 또는 임시 수정사항을 Application Center 또는 {{ site.data.keys.mf_server }}에 설치
{: #installation-of-a-fix-pack-or-interim-fix-to-the-application-center-or-the-mobilefirst-server }
Application Center 또는 {{ site.data.keys.mf_server }}에 수정사항 또는 임시 수정사항을 적용할 경우, 수동 조작이 필요하며 때때로 애플리케이션을 시스템 종료해야 할 수 있습니다. 

### JSONStore 지원 아키텍처
{: #jsonstore-supported-architectures }
Android의 경우, JSONStore에서는 ARM, ARM v7 및 x86 32비트 아키텍처를 지원합니다. 기타 아키텍처는 현재 지원되지 않습니다. 다른 아키텍처를 사용하려고 시도하면 예외가 발생하며 애플리케이션이 잠재적으로 손상됩니다. 

Windows 고유 애플리케이션에서는 JSON 저장소가 지원되지 않습니다. 

### Liberty 서버 제한사항
{: #liberty-server-limitations }
Liberty 서버를 32비트 JDK 7에서 사용할 경우, Eclipse가 시작되지 않으며 사용자가 다음 오류를 수신할 수 있습니다. "VM 초기화 동안 오류가 발생했습니다. 오브젝트 힙을 위한 충분한 공간을 예약할 수 없습니다. 오류: JVM(Java Virtual Machine)을 작성할 수 없습니다. 오류: 치명적 예외가 발생했습니다. 프로그램이 종료됩니다."

이 문제를 수정하려면 64비트 Eclipse 및 64비트 Windows에서 64비트 JDK를 사용하십시오. 64비트 컴퓨터에서 32비트 JDK를 사용하는 경우 JVM 환경 설정을 **mx512m** 및 **Xms216m**으로 구성할 수 있습니다.

### LTPA 토큰 제한사항
{: #ltpa-token-limitations }
사용자 세션이 만료되기 전에 LTPA 토큰이 만료되는 경우 `SESN0008E` 예외가 발생합니다. 

LTPA 토큰은 현재 사용자 세션과 연관됩니다. LTPA 토큰이 만료되기 전에 세션이 만료되는 경우 새 세션이 자동으로 작성됩니다. 하지만 사용자 세션이 만료되기 전에 LTPA 토큰이 만료되는 경우 다음 예외가 발생합니다. 

`com.ibm.websphere.servlet.session.UnauthorizedSessionRequestException: SESN0008E: A user authenticated as anonymous has attempted to access a session owned by {user name}`

이 제한사항을 해결하려면 LTPA 토큰이 만료될 때 사용자 세션을 강제로 만료해야 합니다. 
* WebSphere Application Server Liberty에서 httpSession 속성 invalidateOnUnauthorizedSessionRequestException을 server.xml 파일에서 true로 설정하십시오. 
* WebSphere Application Server에서 값이 true인 세션 관리 사용자 정의 특성 InvalidateOnUnauthorizedSessionRequestException을 추가하여 문제를 수정하십시오.

**참고:** WebSphere Application Server 또는 WebSphere Application Server Liberty의 특정 버전에서는 예외가 계속 로그되지만 세션은 제대로 무효화됩니다. 자세한 정보는 [APAR PM85141](http://www.ibm.com/support/docview.wss?uid=swg1PM85141)을 참조하십시오.

### Microsoft Windows Phone 8
{: #microsoft-windows-phone-8 }
Windows Phone 8.1 환경의 경우, x64 아키텍처가 지원되지 않습니다. 

### Microsoft Windows 10 UWP 앱
{: #microsoft-windows-10-uwp-apps }
NuGet 패키지를 통해 {{ site.data.keys.product_adj }} SDK를 설치한 경우, {{ site.data.keys.product_adj }} Windows 10 UWP 앱에서 애플리케이션 인증 기능이 작동하지 않습니다. 임시 해결책으로 개발자가 NuGet 패키지를 다운로드하여 수동으로 {{ site.data.keys.product_adj }} SDK 참조를 추가할 수 있습니다.

### 중첩 프로젝트의 경우 CLI와 관련된 예기치 않은 결과가 발생할 수 있음
{: #nested-projects-can-result-in-unpredictable-results-with-the-cli }
{{ site.data.keys.mf_cli }}를 사용하는 경우 하나의 프로젝트 내에 다른 프로젝트를 중첩시키지 마십시오. 중첩시키는 경우 예상했던 것과 다른 프로젝트에서 조치가 수행될 수 있습니다.

### {{ site.data.keys.mf_mbs }}에서 Cordova 웹 자원 미리보기 
{: #previewing-cordova-web-resources-with-the-mobile-browser-simulator }
{{ site.data.keys.mf_mbs }}로 웹 자원을 미리볼 수 있지만 일부 {{ site.data.keys.product_adj }} JavaScript API는 시뮬레이터에 의해 지원되지 않습니다. 특히, OAuth 프로토콜은 완전히 지원되지는 않습니다. 하지만 `WLResourceRequest`를 사용하여 어댑터에 대한 호출을 테스트할 수 있습니다. 

### 확장된 앱 인증의 테스트에 필요한 실제 iOS 디바이스
{: #physical-ios-device-required-for-testing-extended-app-authenticity }
iOS 시뮬레이터에 IPA를 설치할 수 없으므로 확장된 앱 인증 기능을 테스트하려면 실제 iOS 디바이스가 필요합니다. 

### {{ site.data.keys.mf_server }}의 Oracle 12c 지원
{: #support-of-oracle-12c-by-mobilefirst-server }
{{ site.data.keys.mf_server }}의 설치 도구(Installation Manager, Server Configuration Tool, Ant 태스크)는 데이터베이스로 Oracle 12c를 통한 설치를 지원합니다. 

설치 도구로 사용자 및 테이블을 작성할 수 있지만 데이터베이스는 설치 도구를 실행하기 전에 존재해야 합니다. 

### 푸시 알림에 대한 지원
{: #support-for-push-notification }
iOS 및 Android의 Cordova에서 비보안 푸시가 지원됩니다. 

### cordova-ios 플랫폼 업데이트
{: #updating-cordova-ios-platform }
Cordova 앱의 cordova-ios 플랫폼을 업데이트하려면 다음 단계를 완료하여 플랫폼을 설치 제거하고 다시 설치해야 합니다. 

1. 명령행 인터페이스를 사용하여 앱에 대한 프로젝트 디렉토리로 이동하십시오.
2. `cordova platform rm ios` 명령을 실행하여 플랫폼을 제거하십시오.
3. `cordova platform add ios@version` 명령을 실행하여 새 플랫폼을 앱에 추가하십시오. 여기서 버전은 Cordova iOS 플랫폼의 버전입니다.
4. 변경사항을 통합하려면 `cordova prepare` 명령을 실행하십시오. 

`cordova platform update ios` 명령을 사용할 경우 업데이트에 실패합니다.

### 웹 애플리케이션
{: #web-applications }
웹 애플리케이션은 다음 제한사항을 가집니다.
- {: #web_app_limit_ms_ie_n_edge }
Microsoft Internet Explorer(IE) 및 Microsoft Edge, 관리 앱 메시지와 클라이언트 웹 SDK 메시지는 구성된 브라우저 또는 운영 체제 표시 언어 환경 설정에 따라서가 아닌 운영 체제의 영역 형식 환경 설정에 따라 표시됩니다. [다중 언어로 관리자 메시지 정의](../../../administering-apps/using-console/#defining-administrator-messages-in-multiple-languages)도 참조하십시오.

### iOS Cordova 애플리케이션에 대한 WKWebView 지원
{: #wkwebview-support-for-ios-cordova-applications }
WKWebView를 사용하는 iOS Cordova 앱에서는 앱 알림 및 직접 업데이트 기능이 제대로 작동하지 않습니다. 

이 제한사항은 defect file:// url XmlHttpRequests로 인해서이며 **cordova-plugin-wkwebview-engine**의 WKWebViewEgine에서는 허용되지 않습니다.

이 문제를 회피하기 위해 Cordova 프로젝트에서 다음 명령을 실행하십시오. `cordova plugin add https://github.com/apache/cordova-plugins.git#master:wkwebview-engine-localhost`

이 명령을 실행하면 Cordova 애플리케이션에서 로컬 웹 서버가 실행되며, 로컬 파일을 사용하기 위해 파일 URI 스키마(file://)를 사용하는 대신 로컬 파일을 호스트하고 이에 액세스할 수 있습니다.

**참고:** 이 Cordova 플러그인은 NPM(Node Package Manager)에 공개되지 않습니다.

### cordova-plugin-statusbar는 cordova-plugin-mfp와 함께 로드된 Cordova 애플리케이션에 대해 작업하지 않습니다.
{: #cordova-plugin-statusbar-does-not-work-with-cordova-application-loaded-with-cordova-plugin-mfp }
cordova-plugin-statusbar는 cordova-plugin-mfp와 함께 로드된 Cordova 애플리케이션에 대해 작업하지 않습니다.

이 문제를 회피하기 위해 개발자는 루트 뷰 제어기로 `CDVViewController`를 설정해야 합니다. Cordova iOS 프로젝트의 **MFPAppdelegate.m** 파일 아래에 제안된 대로 `wlInitDidCompleteSuccessfully` 메소드에서 코드 스니펫을 대체합니다.

기존 코드 스니펫:

```objc
(void)wlInitDidCompleteSuccessfully
{
UIViewController* rootViewController = self.window.rootViewController; 
// Create a Cordova View Controller 
CDVViewController* cordovaViewController = [[CDVViewController alloc] init] ; 
cordovaViewController.startPage = [[WL sharedInstance] mainHtmlFilePath]; 
// Adjust the Cordova view controller view frame to match its parent view bounds 
cordovaViewController.view.frame = rootViewController.view.bounds; 
// Display the Cordova view [rootViewController addChildViewController:cordovaViewController]; 
[rootViewController.view addSubview:cordovaViewController.view]; 
[cordovaViewController didMoveToParentViewController:rootViewController]; 
}
```

제한사항에 대한 임시 해결책으로 권장되는 코드 스니펫:

```objc
(void)wlInitDidCompleteSuccessfully
{
 // Create a Cordova View Controller 
CDVViewController* cordovaViewController = [[CDVViewController alloc] init] ; 
cordovaViewController.startPage = [[WL sharedInstance] mainHtmlFilePath]; 
[self.window setRootViewController:cordovaViewController]; 
[self.window makeKeyAndVisible];
}
```

### Android 애플리케이션에서 지원되지 않는 원시 IPv6 주소
{: #raw-ipv6-address-not-supported-in-android-applications }
고유 Android 애플리케이션에 대한 **mfpclient.properties**의 구성 동안 {{ site.data.keys.mf_server }}가 IPv6 주소를 가진 호스트에 있는 경우, IPV6 주소에 대한 맵핑된 호스트 이름을 사용하여 **mfpclient.properties**의 **wlServerHost** 특성을 구성하십시오. 원시 IPv6 주소를 가진 **wlServerHost** 특성은 {{ site.data.keys.mf_server }}에 연결하기 위한 애플리케이션의 시도에 실패합니다.

### Cordova 앱의 기본 동작 수정은 권장되지 않음
{:  #modifying_default_behaviour_of_a_cordova_app_is_not_recommended}
{{ site.data.keys.product_adj }} Cordova SDK가 프로젝트에 추가되면 Cordova 앱의 기본 동작을 수정(예: 뒤로 버튼 동작 무시)하여 Google Play 스토어에서 제출 시 앱을 거부 할 수 있습니다.
Google Play 스토어에 제출된 다른 오류는 Google 지원팀에 문의할 수 있습니다. 
