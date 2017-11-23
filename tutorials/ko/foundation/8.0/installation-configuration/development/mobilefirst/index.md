---
layout: tutorial
title: MobileFirst 개발 환경 설정
breadcrumb_title: MobileFirst
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
{{ site.data.keys.product_full }}은 클라이언트 SDK, 어댑터 원형, 보안 검사 및 인증 도구라는 여러 컴포넌트로 구성됩니다. 

이 컴포넌트는 온라인 저장소에서 사용할 수 있으며 패키지 관리자를 사용하여 설치할 수 있습니다. 이 온라인 저장소는 각 컴포넌트의 최신 릴리스를 제공합니다. 로컬로 사용하기 위해 동일한 컴포넌트를 {{ site.data.keys.mf_dev_kit }}에서 다운로드할 수도 있습니다. {{ site.data.keys.mf_dev_kit_short }}에서 사용 가능한 버전은 특정 {{ site.data.keys.mf_dev_kit_short }} 빌드가 릴리스된 시기에 사용 가능한 버전을 나타내며 최신 버전을 사용하기 위해 새 {{ site.data.keys.mf_dev_kit_short }} 빌드를 다운로드해야 합니다.  

{{ site.data.keys.product }}의 컴포넌트에 대해 자세히 학습하기 위해 계속 읽으십시오. 

> {{ site.data.keys.product }}을 평가하려면 Mobile Foundation Bluemix 서비스를 사용하여 Bluemix에서 {{ site.data.keys.mf_server }}의 인스턴스를 회전시키기만 하면 됩니다. [Mobile Foundation 사용](../../../bluemix/using-mobile-foundation/) 학습서에서 지시사항을 참조하십시오. 로컬 설치를 위해 {{ site.data.keys.mf_dev_kit_short }}을 설치하도록 선택할 수도 있습니다.



#### 다음으로 이동:
{: #jump-to }

* [설치 안내서](#installation-guide)
* [{{ site.data.keys.mf_dev_kit }}](#mobilefirst-developer-kit)
* [{{ site.data.keys.product }} 컴포넌트](#mobilefirst-foundation-components)
* [애플리케이션 및 어댑터 개발](#applications-and-adapters-development)
* [다음 학습서](#tutorials-to-follow-next)

## 설치 안내서
{: #installation-guide }
[설치 안내서를 읽고](installation-guide) 워크스테이션에서 MobileFirst Foundation을 신속하게 설정하십시오. 

## {{ site.data.keys.mf_dev_kit }}
{: #mobilefirst-developer-kit }
{{ site.data.keys.mf_dev_kit_short }}은 필요한 구성이 최소인 개발 준비가 된 환경을 제공합니다. 이 킷은 {{ site.data.keys.mf_server }} &amp; {{ site.data.keys.mf_console }}, MobileFirst Developer CLI(Command-line Interface) 등의 컴포넌트로 구성되며 선택적으로 다운로드할 클라이언트 SDK 및 어댑터 도구를 제공합니다. 

> **참고:** 인터넷 액세스가 없는 컴퓨터에서 개발 환경을 설정해야 하는 경우에는 컴포넌트를 오프라인으로 설치할 수 있습니다. [오프라인 IBM MobileFirst 개발 환경 설정 방법]({{site.baseurl}}/blog/2016/03/31/howto-set-up-an-offline-ibm-mobilefirst-8-0-development-environment)을 참조하십시오.



### {{ site.data.keys.mf_dev_kit_short }} 설치 프로그램
{: #developer-kit-installer }
설치 프로그램은 인터넷 연결을 사용할 수 없는 로컬 설치를 위한 컴포넌트를 패키지합니다.   
이 컴포넌트는 {{ site.data.keys.mf_console }}의 Download Center를 통해 얻을 수 있습니다. 

> 설치 프로그램을 다운로드하려면 [다운로드]({{site.baseurl}}/downloads/) 페이지를 방문하십시오. 

## {{ site.data.keys.product }} 컴포넌트
{: #mobilefirst-foundation-components }

### {{ site.data.keys.mf_server }}
{: #mobilefirst-server }
{{ site.data.keys.mf_dev_kit_short }}의 일부로 {{ site.data.keys.mf_server }}는 WebSphere Liberty 프로파일 애플리케이션 서버에 사전 배치된 상태로 제공됩니다. 이 서버는 "mfp" 런타임을 사용하여 사전 구성되어 있으며 파일 시스템 기반 Apache Derby 데이터베이스를 사용합니다. 

{{ site.data.keys.mf_dev_kit_short }} 루트 디렉토리에서 다음과 같은 스크립트를 명령행에서 실행할 수 있습니다. 

* `run.[sh|cmd]`: 후미 Liberty 서버 메시지와 함께 {{ site.data.keys.mf_server }} 실행
    * 백그라운드에서 프로세스를 실행하려면 `-bg` 플래그 추가
* `stop.[sh|cmd]`: 현재 {{ site.data.keys.mf_server }} 인스턴스 중지
* `console.[sh|cmd]`: {{ site.data.keys.mf_console }} 열기

`.sh` 파일 확장자는 Mac 및 Linux용이고 `.cmd` 파일 확장자는 Windows용입니다. 

### {{ site.data.keys.mf_console }}
{: #mobilefirst-operations-console }
{{ site.data.keys.mf_console }}은 다음과 같은 기능을 노출합니다.   
개발자는 다음을 수행할 수 있습니다. 

- 애플리케이션 및 어댑터 등록 및 배치
- 선택적으로 기본/Cordova 애플리케이션 및 어댑터 시작 코드 템플리트 다운로드 
- 애플리케이션의 인증 및 보안 특성 구성
- 애플리케이션 관리:
    - 애플리케이션 인증
    - 직접 업데이트
    - 원격 사용 안함/알림
- iOS 및 Android 디바이스에 푸시 알림 보내기
- 지속적인 통합 워크플로우 및 빠른 개발 주기를 위한 DevOps 스크립트 생성

> [MobilFirst Operations Console 사용](../../../product-overview/components/console/) 학습서에서 {{ site.data.keys.mf_console }}에 대해 자세히 학습하십시오.



### {{ site.data.keys.product }} 명령행 인터페이스
{: #mobilefirst-foundation-command-line-interface }
{{ site.data.keys.mf_console }} 외에도 {{ site.data.keys.mf_cli }}를 사용하여 애플리케이션을 개발하고 관리할 수 있습니다. CLI 명령은 접두부에 `mfpdev`가 지정되고 다음과 같은 유형의 태스크를 지원합니다. 

* {{ site.data.keys.mf_server }}에 앱 등록
* 앱 구성
* 어댑터 작성, 빌드 및 배치
* Cordova 앱 미리보기 및 업데이트

> {{ site.data.keys.mf_cli }}를 다운로드하여 설치하려면 [다운로드]({{site.baseurl}}/downloads/) 페이지를 방문하십시오.   
>[CLI를 사용하여 MobileFirst 아티팩트 관리](../../../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts/) 학습서에서 다양한 CLI 명령에 대해 자세히 학습하십시오. 

### {{ site.data.keys.product }} 클라이언트 SDK 및 어댑터 도구
{: #mobilefirst-foundation-client-sdks-and-adapter-tooling }
{{ site.data.keys.product }}은 Cordova 애플리케이션 및 기본 플랫폼(iOS, Android 및 Windows 8.1 Universal &amp; Windows 10 UWP)용 클라이언트 SDK를 제공합니다. 어댑터 및 보안 검사 개발용 어댑터 도구도 사용할 수 있습니다. 

* {{ site.data.keys.product_adj }} 클라이언트 SDK를 사용하려면 [{{ site.data.keys.product }} SDK 추가](../../../application-development/sdk/) 학습서 카테고리를 방문하십시오.   
* 어댑터를 개발하려면 [어댑터](../../../adapters/) 학습서 카테고리를 방문하십시오.   
* 보안 검사를 개발하려면 [인증 및 보안](../../../authentication-and-security/) 학습서 카테고리를 방문하십시오.   

## 애플리케이션 및 어댑터 개발
{: #applications-and-adapters-development }

### 애플리케이션
{: #applications }
* Cordova 애플리케이션을 사용하려면 NodeJS 및 Cordova CLI가 필요합니다. [Cordova 개발 환경 설정](../cordova)에 대해 자세히 읽으십시오. 

    선호하는 코드 편집기(예: Atom.io, Visual Studio Code, Eclipse, IntelliJ 등)를 사용하여 애플리케이션 및 어댑터를 구현할 수 있습니다.   
    
* 기본 애플리케이션을 사용하려면 Xcode, Android Studio 또는 Visual Studio가 필요합니다. [iOS/Android/Windows 개발 환경 설정](../)에 대해 자세히 읽으십시오. 

### 어댑터
{: #adapters }
어댑터를 사용하려면 Apache Maven을 설치해야 합니다. [어댑터](../../../adapters/) 카테고리를 참조하여 어댑터와 어댑터 작성, 개발 및 배치 방법에 대해 자세히 학습하십시오. 

## 다음 학습서
{: #tutorials-to-follow-next }
[모든 학습서](../../../all-tutorials/) 페이지를 방문하여 다음으로 수행할 학습서 카테고리를 선택하십시오. 

