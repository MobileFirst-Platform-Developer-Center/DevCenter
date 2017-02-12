---
layout: tutorial
title: 설치 및 구성
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
{{ site.data.keys.product_full }}은 테스트 또는 프로덕션 용도로 클라우드에 배치하거나 사내 구축 환경에 설치할 수 있는 서버 측 컴포넌트 및 개발 도구를 제공합니다. 설치 시나리오에 적합한 설치 주제를 검토하십시오. 

### 개발 환경 설치
{: #installing-a-development-environment }
모바일 앱의 서버 측 또는 클라이언트 측을 개발하는 경우 [{{ site.data.keys.mf_dev_kit }}](development/mobilefirst/) 또는 [{{ site.data.keys.mf_bm }} 서비스](../bluemix/using-mobile-foundation)를 사용하여 시작하십시오. 

* [MobileFirst 개발 환경 설정](development/mobilefirst/)
* [Cordova 개발 환경 설정](development/cordova)
* [iOS 개발 환경 설정](development/ios)
* [Android 개발 환경 설정](development/android)
* [Windows 개발 환경 설정](development/windows)
* [Xamarin 개발 환경 설정](development/xamarin)
* [웹 개발 환경 설정](development/web)

### 사내 구축 환경에 테스트 또는 프로덕션 서버 설치
{: #installing-a-test-or-production-server-on-premises }
IBM 설치는 IBM Installation Manager라는 IBM 제품을 기반으로 합니다. {{ site.data.keys.product }}을 설치하기 전에 IBM Installation Manager V1.8.4 이상을 별도로 설치하십시오. 

> **중요:** IBM Installation Manager V1.8.4 이상을 사용하는지 확인하십시오. 제품의 설치 후 작업에 Java 7이 필요하므로 이전 버전의 Installation Manager는 {{ site.data.keys.product }} {{ site.data.keys.product_version }}을 설치할 수 없습니다. 이전 버전의 Installation Manager는 Java 6와 함께 제공됩니다.

{{ site.data.keys.mf_server }} 설치 프로그램은 {{ site.data.keys.mf_server }} 컴포넌트를 배치하기 위해 필요한 모든 도구 및 라이브러리를 컴퓨터에 복사하고 선택적으로 {{ site.data.keys.mf_app_center_full }}를 애플리케이션 서버에 복사합니다. 

테스트 또는 프로덕션 서버를 설치하는 경우 아래의 **{{ site.data.keys.mf_server }} 설치에 대한 학습서**에서 시작하여 단순하게 설치한 후 {{ site.data.keys.mf_server }}의 설치에 대해 학습하십시오. 특정 환경을 위한 설치 준비에 대한 자세한 정보는 [프로덕션 환경을 위한 {{ site.data.keys.mf_server }} 설치](production)를 참조하십시오. 

**{{ site.data.keys.mf_server }} 설치에 대한 학습서**  
지시사항을 수행하여 작동되는 {{ site.data.keys.mf_server }}(WebSphere Application Server Liberty 프로파일에 두 개의 노드가 있는 클러스터)를 작성하여 {{ site.data.keys.mf_server }} 설치 프로세스에 대해 학습하십시오. 설치는 두 가지 방법으로 수행될 수 있습니다. 

* 서버 구성 도구와 [IBM Installation Manager의 그래픽 모드 사용](production/tutorials/graphical-mode)
* [명령행 도구 사용](production/tutorials/command-line)

이후에는 작동되는 {{ site.data.keys.mf_server }}를 가지게 됩니다. 하지만 특히 보안을 위해 이 서버를 사용하기 전에 이 서버를 구성해야 합니다. 자세한 정보는 [{{ site.data.keys.mf_server }} 구성](production/server-configuration)을 참조하십시오. 

**추가**  

* {{ site.data.keys.mf_analytics_server }}를 설치에 추가하려면 [{{ site.data.keys.mf_analytics_server }} 설치 안내서](production/analytics/installation/)를 참조하십시오.   
* {{ site.data.keys.mf_app_center }}를 설치하려면 [Application Center 설치 및 구성](production/appcenter)을 참조하십시오. 

### 클라우드에 {{ site.data.keys.mf_server }} 배치
{: #deploying-mobilefirst-server-to-the-cloud }
클라우드에 {{ site.data.keys.mf_server }}를 배치하려는 경우에는 다음과 같은 옵션을 참조하십시오. 

* [IBM Bluemix에서 {{ site.data.keys.mf_server }} 사용](../bluemix)
* [IBM PureApplication에서 {{ site.data.keys.mf_server }} 사용](production/pure-application)

### 이전 버전에서 업그레이드
{: #upgrading-from-earlier-versions }
기존 설치 및 애플리케이션을 새 버전으로 업그레이드하는 방법에 대한 정보는 [{{ site.data.keys.product_full }} {{ site.data.keys.product_version }}으로 업그레이드](../all-tutorials/#upgrading_to_current_version)를 참조하십시오. 


