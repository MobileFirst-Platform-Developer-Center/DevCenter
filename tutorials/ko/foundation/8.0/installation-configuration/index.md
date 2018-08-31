---
layout: tutorial
title: 설치 및 구성
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
{{ site.data.keys.product_full }}은 테스트 또는 프로덕션 용도로 클라우드에 배치하거나 사내 구축 환경에 설치할 수 있는 서버 측 컴포넌트 및 개발 도구를 제공합니다. 설치 시나리오에 적합한 설치 주제를 검토하십시오.

### 개발 환경 설정
{: #installing-a-development-environment }
모바일 애플리케이션의 서버 측 또는 클라이언트 측을 개발하는 경우 [{{ site.data.keys.mf_dev_kit }}](development/mobilefirst/) 또는 [{{ site.data.keys.mf_bm }} 서비스](../bluemix/using-mobile-foundation)를 사용하여 시작하십시오.

**{{ site.data.keys.mf_dev_kit }} 사용**
{: #using-the-dev-kit }

{{ site.data.keys.mf_dev_kit }}에는 개인 워크스테이션에서 모바일 애플리케이션을 실행하고 디버깅하는 데 필요한 모든 것이 포함되어 있습니다. {{ site.data.keys.mf_dev_kit }}을 사용하여 애플리케이션을 개발하려면 [MobileFirst 개발 환경 설정](development/mobilefirst) 학습서를 따르십시오.

**{{ site.data.keys.mf_bm }} 사용**
{: #using-mf-bluemix }

{{ site.data.keys.mf_bm }} 서비스는 {{ site.data.keys.mf_dev_kit }}과 유사한 기능을 제공하지만 서비스가 IBM Cloud에서 실행됩니다.

**{{ site.data.keys.product }} 애플리케이션 개발 환경 설정**
{: #setting-dev-env-mf-apps }

{{ site.data.keys.product }}에서는 {{ site.data.keys.product }} 애플리케이션을 개발하는 데 사용할 수 있는 플랫폼과 도구에 다양한 유연성을 제공합니다. 그러나 선택한 도구를 사용하여 {{ site.data.keys.product }}과 상호작용하려면 일부 기본 설정이 필요합니다.  

다음 링크에서 선택하여 애플리케이션에서 사용할 개발 접근법에 해당하는 개발 환경을 설정하십시오.

* [Cordova 개발 환경 설정](development/cordova)
* [iOS 개발 환경 설정](development/ios)
* [Android 개발 환경 설정](development/android)
* [Windows 개발 환경 설정](development/windows)
* [Xamarin 개발 환경 설정](development/xamarin)
* [웹 개발 환경 설정](development/web)

### 사내 구축 환경에 테스트 또는 프로덕션 서버 설정
{: #installing-a-test-or-production-server-on-premises }

{{ site.data.keys.product }} 서버 설치의 첫 번째 부분은 IBM Installation Manager라는 IBM 제품을 사용합니다. {{ site.data.keys.product }} 서버 컴포넌트를 설치하기 전에 IBM Installation Manager v1.8.4 이상을 설치해야 합니다.

> **중요:** IBM Installation Manager V1.8.4 이상을 사용하는지 확인하십시오. 제품의 설치 후 작업에 Java 7이 필요하므로 이전 버전의 Installation Manager는 {{ site.data.keys.product }} {{ site.data.keys.product_version }}을 설치할 수 없습니다. 이전 버전의 Installation Manager는 Java 6과 함께 제공됩니다.

{{ site.data.keys.mf_server }} 설치 마법사는 IBM Installation Manager를 사용하여 서버에 모든 서버 컴포넌트를 배치합니다.  {{ site.data.keys.product }} 서버 컴포넌트를 애플리케이션 서버에 배치하는 데 필요한 도구와 라이브러리도 설치됩니다.  우수 사례로, 개발 서버의 경우를 제외하고는 모든 컴포넌트를 동일한 애플리케이션 서버 인스턴스에 설치하지 않는 것이 좋습니다. 배치 도구에서는 설치할 컴포넌트를 선택할 수 있습니다.  서버 설치 전에 고려할 사항은 [토폴로지 및 네트워크 플로우](production/prod-env/topologies)를 참조하십시오.

특정 환경에서 {{ site.data.keys.mf_server }} 및 선택적 서비스를 준비하고 설치하는 데 대한 정보는 아래 내용을 읽어보십시오. 단순 설정의 경우 [테스트 또는 프로덕션 환경 설정](production) 학습서를 읽으십시오.

* [전제조건 확인](production/prod-env/prereqs)
* [{{ site.data.keys.mf_server }} 컴포넌트 개요](production/prod-env/topologies)
* MobileFirst Server 컴포넌트(선택적으로 Application Centre) 배치에 필요한 도구와 라이브러리를 로드하기 전에 고려할 요인
  * 토큰 라이센스
  * MobileFirst Foundation Application Centre
  * 관리자 모드 대 사용자 모드
* 파일 로드 후 MobileFirst Server의 배포 구조
* 파일 로드 방법
  * IBM Installation Manager 설치 마법사 사용
  * 명령행에서 IBM Installation Manager 실행
  * XML 응답 파일 사용 - 자동 설치
* [MobileFirst Foundation Server 컴포넌트의 백엔드 데이터베이스 구성](production/prod-env/databases)
* [애플리케이션 서버에 MobileFirst Server 설치](production/prod-env/appserver)
* [MobileFirst Server 구성](production/server-configuration)
* [MobileFirst Analytics Server 설치](production/analytics/installation)
* [Application Center 설치](production/appcenter)
* [IBM PureApplication System에 MobileFirst Server 배치](production/pure-application)

### 테스트 또는 프로덕션 환경 설정
{: #setting-up-test-or-production-server}

WebSphere Application Server Liberty 프로파일에 두 개의 노드가 있는 작동되는 {{ site.data.keys.mf_server }}클러스터를 작성하는 지시사항을 수행하여 {{ site.data.keys.mf_server }} 설치 프로세스에 대해 학습하십시오. 설치는 그래픽 도구(GUI)나 명령행을 사용해서 완료할 수 있습니다.

* [IBM Installation Manager와 서버 구성 도구를 사용한 GUI 모드 설치](production/simple-install/tutorials/graphical-mode).
* [명령행 도구를 사용하여 명령행 설치](production/simple-install/tutorials/command-line).

위의 두 방법 중 하나로 설치를 완료한 후에는 요구사항에 따라서 설정을 완료하기 위해 추가 [구성](production/server-configuration)이 필요할 수 있습니다.

### 테스트 또는 프로덕션 환경에 선택적 기능 설정
{: #setting-up-optional-features-test-or-production-server}

{{ site.data.keys.product }}에는 테스트나 프로덕션 환경을 보완하는 데 사용할 수 있는 선택적 컴포넌트가 포함되어 있습니다.  자세한 정보는 다음 학습서를 참조하십시오.

* [{{ site.data.keys.mf_analytics_server }} 설치 및 구성](production/analytics/installation/)
* [{{ site.data.keys.mf_app_center }} 설치 및 구성](production/appcenter)

### 클라우드에 {{ site.data.keys.mf_server }} 테스트 또는 프로덕션 환경 배치
{: #deploying-mobilefirst-server-test-or-production-on-the-cloud }

클라우드에 {{ site.data.keys.mf_server }}를 배치하려는 경우에는 다음과 같은 옵션을 참조하십시오.

* [IBM Cloud에서 {{ site.data.keys.mf_server }} 사용](../bluemix)
* [IBM PureApplication에서 {{ site.data.keys.mf_server }} 사용](production/pure-application)

### 이전 버전에서 업그레이드
{: #upgrading-from-earlier-versions }
기존 설치 및 애플리케이션을 새 버전으로 업그레이드하는 방법에 대한 정보는 [{{ site.data.keys.product_full }} {{ site.data.keys.product_version }}으로 업그레이드](../all-tutorials/#upgrading_to_current_version)를 참조하십시오.
