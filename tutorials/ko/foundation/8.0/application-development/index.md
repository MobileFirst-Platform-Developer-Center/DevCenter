---
layout: tutorial
title: 애플리케이션 개발
show_children: true
weight: 5
---
<!-- NLS_CHARSET=UTF-8 -->
## 개발 개념 및 개요
{: #development-concepts-and-overview }
{{ site.data.keys.product_full }} 도구 세트를 사용하여 앱을 개발하는 경우 여러 컴포넌트 및 요소를 개발하거나 구성해야 합니다. 앱 개발 시 관련되는 컴포넌트와 구성에 대해 학습하여 개발을 원활하게 진행할 수 있습니다. 

이러한 개념을 익히는 것 외에도 고유, Cordova 및 웹 애플리케이션에 대한 {{ site.data.keys.product_adj }} 제공 API(예: JSONStore 및 WLResourceReuest)를 학습하고 애플리케이션 디버깅 방법, 직접 업데이트를 사용하여 웹 자원을 새로 고치는 방법, 활성 업데이트를 사용하여 사용자 기반을 세그먼트화하는 방법 및 {{ site.data.keys.mf_cli }}를 사용하여 앱, 어댑터 및 기타 아티팩트를 처리하는 방법에 대해 학습합니다. 

사이드바 탐색에서 관련 주제로 이동하거나 계속 읽고 여러 {{ site.data.keys.product_adj }} 컴포넌트에 대해 자세히 알아보십시오. 

#### 다음으로 이동
{: #jump-to }
* [애플리케이션](#applications)
* [{{ site.data.keys.mf_server }}](#mobilefirst-server)
* [어댑터](#adapters)
* [다음 클라이언트 측 학습서](#client-side-tutorials-to-follow)

### 애플리케이션
{: #applications }
애플리케이션은 대상 {{ site.data.keys.mf_server }}에 대해 빌드되며 대상 서버에 대한 서버 측 구성을 포함합니다. 애플리케이션을 구성하려면 먼저 {{ site.data.keys.mf_server }}에서 애플리케이션을 등록해야 합니다. 

애플리케이션은 다음 요소에 의해 식별됩니다. 

* 앱 ID
* 버전 번호
* 대상 배치 플랫폼

> **참고:** 버전 번호는 웹 애플리케이션에 적용될 수 없습니다. 동일한 웹 애플리케이션을 여러 개 버전으로 보유할 수 없습니다.

클라이언트 측 및 서버 측에서 이러한 ID를 사용하여 앱이 올바르게 배치되고 지정된 자원만 사용하는지 확인합니다. {{ site.data.keys.product }}의 여러 파트에서는 다양한 방식으로 이러한 ID를 여러 가지로 조합하여 사용합니다. 

앱 ID는 대상 배치 플랫폼에 따라 다릅니다.

**Android**  
ID는 애플리케이션 패키지 이름입니다. 

**iOS**  
ID는 애플리케이션 번들 ID입니다. 

**Windows**  
ID는 애플리케이션 어셈블리 이름입니다. 

**웹**  
ID는 개발자가 지정한 고유 ID입니다. 

여러 대상 플랫폼의 앱이 동일한 앱 ID를 사용하는 경우 {{ site.data.keys.mf_server }}는 이러한 앱 모두를 플랫폼 인스턴스가 서로 다른 동일한 앱으로 간주합니다. 예를 들어 다음 앱은 *동일한 앱*의 서로 다른 플랫폼 인스턴스로 간주됩니다. 

* 번들 ID가 `com.mydomain.mfp`인 iOS 앱
* 패키지 이름이 `com.mydomain.mfp`인 Android 앱
* 어셈블리 이름이 `com.mydomain.mfp`인 Windows 10 Universal Windows Platform 앱
* 지정된 ID가 `com.mydomain.mfp`인 웹 앱

앱의 대상 배치 플랫폼은 앱이 고유 앱으로 개발되었는지, 또는 Cordova 앱으로 개발되었는지 여부와 관계가 없습니다. 예를 들어 다음 앱은 둘 다 {{ site.data.keys.product }}에서 iOS 앱으로 간주됩니다. 

* Xcode 및 네이티브 코드를 사용하여 개발되는 iOS 앱
* Cordova 크로스 플랫폼 개발 기술을 사용하여 개발되는 iOS 앱

> **참고:** Xcode 8을 사용하는 경우 iOS 시뮬레이터에서 iOS 앱을 실행 중이면 **키 체인 공유** 기능은 필수입니다. 이 기능을 수동으로 사용하도록 설정한 후에 Xcode 프로젝트를 빌드해야 합니다.

### 애플리케이션 구성
{: #application-configuration }
언급된 것과 같이 애플리케이션은 클라이언트 측 및 서버 측 모두에 구성됩니다.   

고유 및 Cordova iOS, Android와 Windows 애플리케이션의 경우 클라이언트 구성은 클라이언트 특성 파일(iOS는 **mfpclient.plist**, Android는 **mfpclient.properties** 또는 Windows는 **mfpclient.resw**)에 저장됩니다. 웹 애플리케이션의 경우 구성 특성은 SDK [초기화 메소드](../application-development/sdk/web)에 매개변수로 전달됩니다. 

클라이언트 구성 특성에는 서버에 액세스하는 데 필요한 애플리케이션 ID 및 정보(예: {{ site.data.keys.mf_server }} 런타임 URL과 보안 키)가 포함됩니다.   
앱의 서버 구성에는 앱 관리 상태, 직접 업데이트의 웹 자원, 구성된 보안 범위 및 로그 구성과 같은 정보가 포함됩니다. 

> [{{ site.data.keys.product }} SDK 학습서 추가](sdk)에서 {{ site.data.keys.product_adj }} client SDK를 추가하는 방법에 대해 알아보십시오.

애플리케이션을 빌드하기 전에 클라이언트 구성을 정의해야 합니다. 클라이언트-앱 구성 특성은 {{ site.data.keys.mf_server }} 런타임 시 이 앱에 대해 정의된 특성과 일치해야 합니다. 예를 들어 클라이언트 구성의 보안 키는 서버의 키와 일치해야 합니다. 웹 앱이 아닌 항목의 경우 {{ site.data.keys.mf_cli }}를 사용하여 클라이언트 구성을 변경할 수 있습니다. 

앱의 서버 구성은 앱 ID, 버전 번호 및 대상 플랫폼의 조합과 관련이 있습니다. 앱에 대한 서버 측 구성을 추가하려면 먼저 {{ site.data.keys.mf_server }} 런타임에 앱을 등록해야 합니다. 앱의 서버 측 구성은 일반적으로 {{ site.data.keys.mf_console }}을 사용하여 수행됩니다. 다음 메소드를 사용하여 앱의 서버 측을 구성할 수도 있습니다. 

* `mfpdev app pull` 명령을 사용하여 서버에서 기존 JSON 구성 파일을 가져오고 파일을 업데이트한 후 `mfpdev app push` 명령을 사용하여 변경된 구성을 업로드하십시오. 
* **mfpadm** 프로그램 또는 Ant 태스크를 사용하십시오. mfpadm 사용에 대한 정보는 [명령행을 통한 {{ site.data.keys.product_adj }} 애플리케이션 관리](../administering-apps/using-cli) 및 [Ant를 통한 {{ site.data.keys.product_adj }} 애플리케이션 관리](../administering-apps/using-ant)를 참조하십시오. 
* {{ site.data.keys.product_adj }} 관리 서비스의 REST API를 사용하십시오. REST API에 대한 정보는 [REST API for the {{ site.data.keys.mf_server }} administration service](../api/rest/administration-service/)를 참조하십시오. 

이러한 메소드를 사용하여 {{ site.data.keys.mf_server }}의 구성을 자동화할 수도 있습니다. 

> **중요:** {{ site.data.keys.mf_server }}가 실행 중이고 앱에서 트래픽을 수신하는 중에도 서버 구성을 수정할 수 있습니다. 앱의 서버 구성 변경 시에 서버를 중지할 필요가 없습니다.

프로덕션 서버에서 앱 버전은 일반적으로 앱 스토어에 공개되는 애플리케이션 버전과 일치합니다. 앱 신뢰성의 구성과 같은 일부 서버 구성 요소는 스토어에 공개된 앱에 특정됩니다. 

## {{ site.data.keys.mf_server }}
{: #mobilefirst-server }
모바일 앱의 서버 측은 {{ site.data.keys.mf_server }}입니다. {{ site.data.keys.mf_server }}는 애플리케이션 관리와 애플리케이션 보안 등의 기능에 대한 액세스 및 어댑터를 통한 기타 백엔드 시스템에 대한 모바일 앱 보안 액세스를 제공합니다. 

{{ site.data.keys.mf_server }}는 다음 기능을 포함하여 여러 {{ site.data.keys.product }} 기능을 제공하는 핵심 컴포넌트입니다. 

* 애플리케이션 관리
* 디바이스와 사용자 인증 및 애플리케이션 신뢰성 확인을 포함하여 애플리케이션 보안
* 어댑터를 통한 백엔드 서비스에 대한 보안 액세스
* 직접 업데이트를 사용하여 Cordova 앱 웹 자원 업데이트
* 푸시 알림 및 푸시 등록
* 앱 분석

개발 및 테스트에서 프로덕션 배치 및 유지보수에 이르는 앱 라이프사이클 전반에서 {{ site.data.keys.mf_server }}를 사용해야 합니다.   

> 앱 개발 시에 사전 구성된 서버를 사용할 수 있습니다. 앱 개발 시 사용할 {{ site.data.keys.mf_server }}에 대한 정보는 [{{ site.data.keys.product_adj }} 개발 환경 설정](../installation-configuration/development)을 참조하십시오.

{{ site.data.keys.mf_server }}는 다음 컴포넌트로 구성되어 있습니다. 이러한 컴포넌트는 {{ site.data.keys.mf_server }}에도 모두 포함됩니다. 단순 케이스의 경우 모두 동일한 애플리케이션 서버에서 실행되지만 프로덕션 또는 테스트 환경에서는 여러 애플리케이션 서버에서 이러한 컴포넌트를 실행할 수 있습니다. 이러한 {{ site.data.keys.mf_server }} 컴포넌트의 가능한 토폴로지에 대한 정보는 [토폴로지 및 네트워크 플로우](../installation-configuration/production/topologies)를 참조하십시오. 

### {{ site.data.keys.product_adj }} 및 {{ site.data.keys.mf_server }} 관리 서비스
{: #mobilefirst-and-the-mobilefirst-server-administration-service }
운영 콘솔은 {{ site.data.keys.mf_server }} 구성을 보고 편집할 수 있는 웹 인터페이스입니다. 여기에서 {{ site.data.keys.mf_analytics_console }}에 액세스할 수도 있습니다. 개발 서버의 운영 콘솔에 대한 컨텍스트 루트는 **/mfpconsole**입니다. 

관리 서비스는 앱 관리의 기본 시작점입니다. {{ site.data.keys.mf_console }}을 사용하여 웹 기반 인터페이스를 통해 관리 서비스에 액세스할 수 있습니다. **mfpadm** 명령행 도구 또는 관리 서비스 REST API로 관리 서비스에 액세스할 수도 있습니다. 

> [{{ site.data.keys.mf_console }} 기능](../product-overview/components/console)에 대해 자세히 알아보십시오. 

### {{ site.data.keys.product_adj }} 런타임
{: #mobilefirst-runtime }
런타임은 {{ site.data.keys.product_adj }} 클라이언트 앱의 기본 시작점입니다. 또한 런타임은 {{ site.data.keys.product }} OAuth 구현에 대한 기본 권한 부여 서버입니다. 

고급 케이스 및 드문 케이스의 경우 단일 {{ site.data.keys.mf_server }}에 여러 개의 디바이스 런타임 인스턴스가 있을 수 있습니다. 긱 인스턴스에는 고유 컨텍스트 루트가 있습니다. 컨텍스트 루트는 운영 콘솔에서 런타임 이름을 표시하는 데 사용됩니다. 키 저장소의 비밀 키와 같이 여러 서버 레벨 구성이 필요한 경우 여러 인스턴스를 사용하십시오. 

{{ site.data.keys.mf_server }}에 하나의 디바이스 런타임 인스턴스만 있는 경우 일반적으로 런타임 컨텍스트 루트를 알 필요가 없습니다. 예를 들어 {{ site.data.keys.mf_server }}에 하나의 런타임만 있고 `mfpdev app register` 명령을 사용하여 런타임에 애플리케이션을 등록하는 경우 애플리케이션이 해당 런타임에 자동으로 등록됩니다. 

### {{ site.data.keys.mf_server }} 푸시 서비스
{: #mobilefirst-server-push-service }
푸시 서비스는 푸시 알림 및 푸시 등록과 같은 푸시 관련 조작의 기본 액세스 지점입니다. 푸시 서비스에 접속하는 경우 클라이언트 앱은 런타임의 URL을 사용하지만 /mfppush로 컨텍스트 루트를 대체합니다. {{ site.data.keys.mf_console }} 또는 푸시 서비스 REST API를 사용하여 푸시 서비스를 구성하고 관리할 수 있습니다. 

{{ site.data.keys.product_adj }} 런타임과 별도의 애플리케이션 서버에서 푸시 서비스를 실행하는 경우 HTTP 서버를 사용하여 푸시 서비스 트래픽의 경로를 올바른 애플리케이션 서버로 지정해야 합니다. 

### {{ site.data.keys.mf_analytics }} 및 {{ site.data.keys.mf_analytics_console }}
{: #mobilefirst-analytics-and-the-mobilefirst-analytics-console }
{{ site.data.keys.mf_analytics_full }}는 확장 가능한 분석 기능을 제공하는 선택적 컴포넌트로, {{ site.data.keys.mf_console }}에서 액세스할 수 있습니다. 이 분석 기능을 사용하여 디바이스, 앱 및 서버에서 수집되는 로그와 이벤트에서 패턴, 문제점 및 플랫폼 사용량 통계를 검색할 수 있습니다. 

{{ site.data.keys.mf_console }}에서 분석 서비스에 대해 데이터 전달을 사용 또는 사용 안함으로 설정하는 필터를 정의할 수 있습니다. 전송되는 정보 유형도 필터링할 수 있습니다. 클라이언트 측에서 클라이언트 측 로그 캡처 API를 사용하여 분석 서버에 이벤트와 데이터를 전송할 수 있습니다. 

{{ site.data.keys.mf_server }}를 설치하고 원하는 토폴로지로 구성한 후 {{ site.data.keys.mf_server }} 및 해당 애플리케이션을 추가 구성할 경우 다음 방법을 통해 완료할 수 있습니다. 

* {{ site.data.keys.mf_console }}
* {{ site.data.keys.mf_server }} 관리 서비스 REST API
* **mfpadm** 명령행 도구

초기 설치 및 구성 후에 {{ site.data.keys.product }}를 구성할 때 애플리케이션 서버 콘솔 또는 인터페이스에 액세스할 필요가 없습니다.   
앱을 프로덕션에 배치할 때 다음 {{ site.data.keys.mf_server }} 프로덕션 환경에 앱을 배치할 수 있습니다. 

#### 사내 구축 환경
{: #on-premises }
> 사내 구축 환경에 사용되는 {{ site.data.keys.mf_server }} 설치 및 구성에 대한 정보는 [IBM {{ site.data.keys.mf_server }} 설치](../installation-configuration/production/appserver)를 참조하십시오.

#### 클라우드
{: #on-the-cloud }
* [IBM Bluemix에서 {{ site.data.keys.mf_server }}사용](../bluemix)
* [IBM PureApplication에서 {{ site.data.keys.mf_server }} 사용](../installation-configuration/production/pure-application)

## 어댑터
{: #adapters }
{{ site.data.keys.product }}의 어댑터는 백엔드 시스템을 클라이언트 애플리케이션 및 클라우드 서비스에 안전하게 연결합니다.   

JavaScript 또는 Java로 어댑터를 작성하고 Maven 프로젝트로 빌드 및 배치할 수 있습니다.   
어댑터는 {{ site.data.keys.mf_server }}의 {{ site.data.keys.product_adj }} 런타임에 배치됩니다. 

프로덕션 시스템에서 어댑터는 일반적으로 애플리케이션 서버 클러스터에서 실행됩니다. 클러스터 환경에서 어댑터가 올바르게 작동하도록 하려면 어댑터를 세션 정보가 없고 서버에 로컬로 저장된 REST 서비스로 구현하십시오. 

어댑터에는 사용자 정의 특성이 있을 수 있습니다. 이러한 특성은 어댑터를 재배치하지 않고도 서버 측에 구성할 수 있습니다. 예를 들어 테스트에서 프로덕션으로 이동할 때 어댑터가 자원에 액세스하는 데 사용하는 URL을 변경할 수 있습니다. 

mfpdev adapter deploy 명령을 사용하거나 Maven에서 직접 수행하여 {{ site.data.keys.mf_console }}에서 {{ site.data.keys.product_adj }} 런타임에 어댑터를 배치할 수 있습니다. 

> [어댑터 카테고리](../adapters)에서 어댑터 및 JavaScript와 Java 어댑터 개발 방법에 대해 자세히 알아보십시오. 

## 다음 클라이언트 측 학습서
{: #client-side-tutorials-to-follow }
