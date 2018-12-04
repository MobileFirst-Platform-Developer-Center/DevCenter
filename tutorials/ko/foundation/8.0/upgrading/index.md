---
layout: tutorial
title: 이전 릴리스에서 마이그레이션
weight: 12
---
## 개요
{: #overview }
{{ site.data.keys.product_full }} v8.0은 애플리케이션 개발 및 배치를 위한 새 개념과 몇몇 API 변경사항을 소개합니다. MobileFirst 애플리케이션의 마이그레이션을 준비하고 계획하기 위해 이러한 변경사항에 대해 학습하십시오.

> 마이그레이션 프로세스를 빠르게 시작하려면 [마이그레이션 쿡북을 검토](migration-cookbook)하십시오.

> 이 [랩]({{site.baseurl}}/labs/developers/8.0/advancedwallet/)을 사용하여 v7.1에서 v8.0으로 마이그레이션할 수 있습니다.

#### 다음으로 이동
{: #jump-to }
* [{{ site.data.keys.product_full }} 8.0으로 마이그레이션해야 하는 이유](#why-migrate-to-ibm-mobilefirst-foundation-80)
* [개발 및 배치 프로세스의 변경사항](#changes-in-the-development-and-deployment-process)
* [Cordova 또는 하이브리드 애플리케이션 마이그레이션](#migrating-a-cordova-or-hybrid-application)
* [네이티브 애플리케이션 마이그레이션](#migrating-a-native-application)
* [어댑터 및 보안 마이그레이션](#migrating-adapters-and-security)
* [푸시 알림 지원 마이그레이션](#migrating-push-notifications-support)
* [서버 데이터베이스 및 서버 구조의 변경사항](#changes-in-the-server-databases-and-in-the-server-structure)
* [Cloudant에 모바일 데이터 저장](#storing-mobile-data-in-cloudant)
* [{{ site.data.keys.mf_server }}](#applying-a-fix-pack-to-mobilefirst-server)에 수정팩 적용

## IBM MobileFirst Foundation 8.0으로 마이그레이션해야 하는 이유
{: #why-migrate-to-ibm-mobilefirst-foundation-80}

### 앱 빌드에 필요한 노력, 기술 및 시간 감소
* Java 어댑터 빌드 자동화를 위해 표준 패키지 관리자(npm, CocoaPods, Gradle, NuGet) 및 Maven을 사용하여 보다 빠르고 단순하고 스마트하게 앱을 빌드할 수 있음
* 보다 단순하고 쉽게 플러그인할 수 있는 모듈식 MobileFirst SDK
* 예상 사용자의 다음 번 최적 조치를 포함하여 앱 등록, 구성 및 배치에 대한 안내식 도움말을 제공하는 새롭고 개선된 전체 사용자 환경

### 자동화 향상 및 새로운 개발 및 IT 셀프 서비스
* 앱 구성 가능 정보(푸시 알림, 인증, 어댑터, 앱 동작, 워크플로우)를 구체화하고 동적으로 변경할 수 있는 새로운 라이브 업데이트 기능
* 앱 등록, 배치 및 관리를 위해 완전히 재편되고 간소화된 콘솔 사용자 환경
* 개발 및 IT의 상호의존성을 제거한 더욱 단순해진 새로운 앱 아키텍처
* 새로운 충돌 분석, 구성 가능한 경보 및 근본 원인 분석을 통해 향상된 문제점 판별
* 향상된 푸시 알림 서비스를 통해 대상에 맞는 등록 기반의 통지를 웹 콘솔에서 전송할 수 있음

### 더 많은 하이브리드 클라우드 배치 옵션
* IBM Cloud Public에서 MobileFirst Foundation 개발, 테스트 및 완전히 확장 가능한 프로덕션 환경의 원클릭 프로비저닝
* 배치 파이프라인을 빌드할 수 있도록 IBM DevOps Services 및 Urban Code와 통합됨

### 다채널 API 작성 및 관리
* 보호 극대화를 위해 모바일 관련 보안 확장기능(예: Step Up, Multifactor)으로 API Connect 다채널 보안 강화 후 IBM DataPower로 DMZ에 적용
* Foundation v8에서 API Connect와 호환되는 Swagger REST API를 작성하고 정의한 후 API Connect에서 관리 및 보안 처리

## 개발 및 배치 프로세스의 변경사항
{: #changes-in-the-development-and-deployment-process }
> {{ site.data.keys.product }} V8.0.0에 대한 개발 프로세스의 빠른 실제 경험을 위해 [빠른 시작 학습서](../quick-start)를 검토할 수 있습니다.

이 버전의 제품에서는 앱을 업로드하려면 {{ site.data.keys.mf_server }}를 실행 중인 애플리케이션 서버에 설치해야 하는 프로젝트 WAR 파일을 더 이상 작성하지 않습니다. 대신 {{ site.data.keys.mf_server }}가 한 번 설치되면 앱, 자원 보안 또는 푸시 서비스의 서버 측 **구성**이 서버에 업로드됩니다. {{ site.data.keys.mf_console }}을 사용하여 앱 구성을 수정할 수 있습니다. 또한 명령행 도구나 서버 REST API를 사용하여 앱의 새 **구성 파일**을 업로드할 수도 있습니다.

MobileFirst 프로젝트는 더 이상 존재하지 않습니다. 대신 선택한 개발 환경으로 모바일 앱을 개발합니다. Java™ 또는 JavaScript에서 개별적으로 애플리케이션의 서버 측을 개발합니다. Apache Maven 또는 Maven 사용 IDE(예: Eclipse, IntelliJ 및 기타)를 사용하여 어댑터를 개발할 수 있습니다.

이전 버전에서는 .wlapp 파일을 업로드하여 애플리케이션이 서버에 배치되었습니다. 이 파일에는 애플리케이션을 설명하는 데이터가 포함되어 있습니다(하이브리드 애플리케이션의 경우 웹 자원). v8.0에서는 서버에 앱을 등록하기 위해 .wlapp 파일이 애플리케이션 디스크립터 JSON 파일로 대체되었습니다. 직접 업데이트를 사용하는 Cordova 애플리케이션의 경우 새 버전의 .wlapp을 업로드하지 않고 이제 웹 자원 아카이브를 서버에 업로드합니다.

앱을 개발할 때 여러 태스크(예: 대상 서버에 앱 등록 또는 해당 서버 측 구성 업로드)에 {{ site.data.keys.mf_cli }}를 사용합니다.

### 중단된 기능 및 대체 경로
{: #discontinued-features-and-replacement-path}
{{ site.data.keys.product }} V8.0.0은 이전 버전에 비해 훨씬 간단합니다. 이 단순화의 결과로, V7.1에서 사용할 수 있는 일부 기능은 v8.0에서 중단됩니다.

> 중단된 기능 및 대체 경로에 대한 자세한 정보는 [v8.0에서 중단된 기능 및 v8.0에 포함되지 않은 기능](../product-overview/release-notes/deprecated-discontinued)을 참조하십시오.

## Cordova 또는 하이브리드 애플리케이션 마이그레이션
{: #migrating-a-cordova-or-hybrid-application }
Apache Cordova 명령행 도구 또는 Cordova 사용 IDE(예: Visual Studio Code, Eclipse, IntelliJ 등)로 Cordova 앱 개발을 시작합니다.

{{ site.data.keys.product_adj }} 플러그인을 앱에 추가하여 {{ site.data.keys.product_adj }} 기능에 대한 지원을 추가하십시오. V7.1 Cordova 또는 하이브리드 앱과 V8.0 Cordova 앱의 차이에 대한 자세한 정보는 [v8.0과 v7.1 이전 버전으로 개발된 Cordova 앱의 비교](migrating-client-applications/cordova/#comparison-of-cordova-apps-developed-with-v-80-versus-v-71-and-before)를 참조하십시오.

Cordova 또는 하이브리드 앱을 마이그레이션하려면 다음을 수행하십시오.

* 계획 용도로는 기존 프로제트에서 마이그레이션 지원 도구를 실행하십시오. 생성된 보고서를 검토하고 마이그레이션에 필요한 사항을 평가하십시오. 자세한 정보는 [마이그레이션 지원 도구로 Cordova 앱 마이그레이션 시작](migrating-client-applications/cordova/#starting-the-cordova-app-migration-with-the-migration-assistance-tool)을 참조하십시오.
* V8.0.0에서 중단되거나 중단되지 않은 클라이언트 측 API를 대체하십시오. API 변경사항 목록은 [WebView 업그레이드](migrating-client-applications/cordova/#upgrading-the-webview)를 참조하십시오.
* 클래식 보안 모델을 사용하는 클라이언트 자원에 대한 호출을 수정하십시오. 예를 들어, 더 이상 사용되지 않는 `WL.Client.invokeProcedure` 대신 `WLResourceRequest` API를 사용하십시오.
* 직접 업데이트를 사용하는 경우 [직접 업데이트 마이그레이션](migrating-client-applications/cordova/#migrating-direct-update)을 검토하십시오.
* Cordova 또는 하이브리드 앱의 마이그레이션에 대한 자세한 정보는 [기존 Cordova 및 하이브리드 애플리케이션 마이그레이션](migrating-client-applications/cordova)을 참조하십시오.

> **참고:** 푸시 알림 지원을 마이그레이션하려면 클라이언트 측 및 서버 측 변경사항이 필요하며, 이에 대해서는 나중에 푸시 알림 지원 마이그레이션에서 설명합니다.

## 네이티브 애플리케이션 마이그레이션
{: #migrating-a-native-application }
네이티브 애플리케이션을 마이그레이션하려면 다음 단계를 수행해야 합니다.

* 계획 용도로는 기존 프로제트에서 마이그레이션 지원 도구를 실행하십시오. 생성된 보고서를 검토하고 마이그레이션에 필요한 사항을 평가하십시오.
* {{ site.data.keys.product }} v8.0에서 SDK를 사용하여 프로젝트를 업데이트하십시오.
* v8.0에서 중단되거나 중단되지 않은 클라이언트 측 API를 대체하십시오. 마이그레이션 지원 도구는 코드를 스캔하고 대체할 API의 보고서를 생성할 수 있습니다.
* 클래식 보안 모델을 사용하는 클라이언트 자원에 대한 호출을 수정하십시오. 예를 들어, 더 이상 사용되지 않는 `invokeProcedure` 대신 `WLResourceRequest` API를 사용하십시오.
    * 네이티브 iOS 앱의 마이그레이션에 대한 자세한 정보는 [기존 네이티브 iOS 애플리케이션 마이그레이션](migrating-client-applications/ios)을 참조하십시오.
    * 네이티브 Android 앱의 마이그레이션에 대한 자세한 정보는 [기존 네이티브 Android 애플리케이션 마이그레이션](migrating-client-applications/android)을 참조하십시오.
    * 네이티브 Windows 앱의 마이그레이션에 대한 자세한 정보는 [기존 네이티브 Windows 애플리케이션 마이그레이션](migrating-client-applications/windows)을 참조하십시오.

> **참고:** 푸시 알림 지원을 마이그레이션하려면 클라이언트 측 및 서버 측 변경사항이 필요하며, 이에 대해서는 나중에 [푸시 알림 지원 마이그레이션](#migrating-push-notifications-support)에서 설명합니다.

## 어댑터 및 보안 마이그레이션
{: #migrating-adapters-and-security }
v8.0부터 어댑터는 Maven 프로젝트입니다. {{ site.data.keys.product_adj }} 보안 프레임워크는 OAuth, 보안 범위 및 보안 검사를 기반으로 합니다. 보안 범위는 자원에 액세스하기 위한 보안 요구사항을 정의합니다. 보안 검사는 보안 요구사항을 확인하는 방법을 정의합니다. 보안 검사는 Java 어댑터로 작성됩니다. 어댑터 및 보안에 대한 실제 경험을 위해 [Java 및 JavaScript 어댑터 작성](../adapters/creating-adapters)과 [권한 개념](../authentication-and-security)에 대한 학습서를 참조하십시오.

{{ site.data.keys.mf_server }}는 세션 독립 모드에서만 작동하며 어댑터는 상태를 JVM(Java Virtual Machine)에 로컬로 저장하지 않아야 합니다.

어댑터 특성을 구체화하여 실행 컨텍스트에 맞게 어댑터를 구성할 수 있습니다(예: 테스트 서버 또는 프로덕션 서버). 하지만 이러한 특성의 값은 프로젝트 WAR 파일의 특성 파일에 더 이상 포함되지 않습니다. 대신 {{ site.data.keys.mf_console }}에서 또는 명령행 도구나 서버 REST API를 사용하여 정의합니다.

* 어댑터 마이그레이션에 대한 자세한 정보는 {{ site.data.keys.mf_server }} v8.0에서 작동하도록 [기존 어댑터 마이그레이션](migrating-adapters)을 참조하십시오.
* 서버 측 API 변경사항에 대한 자세한 정보는 v8.0에서 [서버 측 API](../product-overview/release-notes/deprecated-discontinued/#server-side-api-changes) 변경사항을 참조하십시오.
* 어댑터 개발에 사용된 Apache Maven에 대한 소개는 [Apache Maven 프로젝트로서의 어댑터](../adapters)를 참조하십시오.
* 인증 및 보안 마이그레이션에 대한 자세한 정보는 {{ site.data.keys.product_adj }} v8.0으로의 [인증 및 보안 마이그레이션](migrating-security)을 참조하십시오.

## 푸시 알림 지원 마이그레이션
{: #migrating-push-notifications-support }
이벤트 소스 기반 모델은 더 이상 지원되지 않습니다. 대신 태그 기반 알림을 사용하십시오. 클라이언트 앱 및 서버 측 컴포넌트를 위한 푸시 알림 마이그레이션에 대해 자세히 학습하려면 이벤트 소스 기반 알림에서 [푸시 알림 마이그레이션](migrating-push-notifications) 및 [마이그레이션 시나리오](migrating-push-notifications/#migration-scenarios)를 참조하십시오.

v8.0부터는 서버 측에 푸시 서비스를 구성합니다. 푸시 인증서는 서버에 저장됩니다. {{ site.data.keys.mf_console }}에서 설정하거나 명령행 도구 또는 푸시 서비스 REST API를 사용하여 자동으로 인증서를 업로드할 수 있습니다. 또한 {{ site.data.keys.mf_console }}에서 푸시 알림을 보낼 수도 있습니다.

푸시 서비스는 OAuth 보안 모델을 통해 보호됩니다. 푸시 서비스 REST API를 사용하는 서버 측 컴포넌트는 {{ site.data.keys.mf_server }}의 기밀 클라이언트로 구성되어야 합니다.

### 푸시 알림 데이터 마이그레이션 도구
{: #push-notifications-data-migration-tool }
푸시 알림 데이터에도 마이그레이션 도구를 사용할 수 있습니다. 마이그레이션 도구는 MobileFirst Platform Foundation 7.1 푸시 데이터(디바이스, 사용자 등록, 신임 정보 및 태그)를 {{ site.data.keys.product }} 8.0으로 마이그레이션하는 데 도움이 됩니다.

> [마이그레이션 도구에 대해 자세히 학습](migrating-push-notifications/#migration-tool)하십시오.

## 서버 데이터베이스 및 서버 구조의 변경사항
{: #changes-in-the-server-databases-and-in-the-server-structure }
{{ site.data.keys.mf_server }}를 사용하면 코드 변경, 앱 재빌드 또는 재배치 없이 앱 보안, 연결 및 푸시를 변경할 수 있습니다. 그러나 이러한 변경은 데이터베이스 스키마, 데이터베이스에 저장된 데이터 및 설치 프로세스에서의 변경을 의미합니다.

이러한 변경사항 때문에 {{ site.data.keys.product }}에는 이전 버전에서 V8.0.0으로 데이터베이스를 마이그레이션하거나 기존 서버 설치를 업그레이드하는 자동화된 스크립트가 포함되지 않습니다. 새 버전의 앱을 V8.0.0로 이동하려면 이전 서버와 병행하여 실행할 수 있는 새 서버를 설치하십시오. 그런 다음 앱과 어댑터를 V8.0.0으로 업그레이드하고 새 서버에 배치하십시오.

## Cloudant에 모바일 데이터 저장
{: #storing-mobile-data-in-cloudant }
IMFData 프레임워크 또는 CloudantToolkit으로 Cloudant에 모바일 데이터를 저장하는 것은 더 이상 지원되지 않습니다. 대체 API에 대해서는 [IMFData 또는 Cloudant SDK로 Cloudant에 모바일 데이터를 저장하는 앱 마이그레이션](migrating-data)을 참조하십시오.

## {{ site.data.keys.mf_server }}에 수정팩 적용
{: #applying-a-fix-pack-to-mobilefirst-server }
{{ site.data.keys.mf_server }} V8.0.0을 수정팩 또는 임시 수정사항으로 업그레이드하려면 서버 구성 도구 사용 방법을 찾으십시오. 또는 Ant 태스크로 {{ site.data.keys.mf_server }}를 설치한 경우 Ant 태스크를 사용하여 수정팩이나 임시 수정사항을 적용할 수도 있습니다.

{{ site.data.keys.mf_server }}에 임시 수정사항이나 수정팩을 적용하려면 초기 설치 방법에 따라 다음 주제 중 하나를 선택하십시오.

* [서버 구성 도구를 사용하여 수정팩 또는 임시 수정사항 적용](../installation-configuration/production/prod-env/appserver/#applying-a-fix-pack-by-using-the-server-configuration-tool)
* [Ant 파일을 사용하여 수정팩 적용](../installation-configuration/production/prod-env/appserver/#applying-a-fix-pack-by-using-the-ant-files)
