---
layout: tutorial
title: 제품 컴포넌트
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
{{ site.data.keys.product_full }}은 {{ site.data.keys.mf_cli }}, {{ site.data.keys.mf_server }}, 클라이언트 측 컴포넌트, {{ site.data.keys.mf_console }}, {{ site.data.keys.mf_app_center }} 및 {{ site.data.keys.mf_system_pattern }} 등의 컴포넌트로 구성됩니다.

다음 그림은 {{ site.data.keys.product }}의 컴포넌트를 표시합니다.

![ {{ site.data.keys.product }} 솔루션의 아키텍처](architecture.jpg)

### {{ site.data.keys.mf_cli }}
{: #mobilefirst-cli }
IBM {{ site.data.keys.mf_console }} 사용하는 외에도 {{ site.data.keys.mf_cli_full }}를 사용하여 애플리케이션을 개발 및 관리할 수 있습니다. {{ site.data.keys.product_adj }} 개발 프로세스의 일부 측면은 CLI에서 수행되어야 합니다.

**mfpdev**로 시작하는 명령은 모두 다음 유형의 태스크를 지원합니다.

* {{ site.data.keys.mf_server }}에 앱 등록
* 앱 구성
* 어댑터 작성, 빌드 및 배치
* Cordova 앱 미리보기 및 업데이트
* 자세한 정보는 [CLI를 사용하여 {{ site.data.keys.product_adj }} 아티팩트 관리](../../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts/) 학습서를 참조하십시오.

### {{ site.data.keys.mf_server }}
{: #mobilefirst-server }
{{ site.data.keys.mf_server }}는 안전한 백엔드 연결성, 애플리케이션 관리, 푸시 알림 지원 및 분석 기능과 {{ site.data.keys.product_adj }} 애플리케이션에 대한 모니터링을 제공합니다. 이는 Java Platform, Enterprise Edition(Java EE) 센스의 애플리케이션 서버가 아닙니다. {{ site.data.keys.product }} 애플리케이션 패키지에 대한 컨테이너의 역할을 하며, 사실 웹 애플리케이션의 콜렉션이고, 일반 애플리케이션 서버의 맨 위에서 실행되는 EAR(Enterprise Archive) 파일로 선택적으로 패키지됩니다.

{{ site.data.keys.mf_server }}는 엔터프라이즈 환경으로 통합되며 기존 자원과 인프라를 사용합니다. 이 통합은 백엔드 엔터프라이즈 시스템과 클라우드 기반 서비스를 사용자 디바이스에 채널링할 책임이 있는 서버 측 소프트웨어 컴포넌트인 어댑터에 기반합니다. 어댑터를 사용하여 정보 소스에서 데이터를 검색하고 업데이트할 수 있으며 사용자가 트랜잭션을 수행하고 다른 서비스와 애플리케이션을 시작하도록 허용할 수 있습니다.

[{{ site.data.keys.mf_server }}에 대해 자세히 알아보십시오](server).

### 클라이언트 측 런타임 컴포넌트
{: #client-side-runtime-components }
{{ site.data.keys.product }}은 배치된 앱의 대상 환경에 서버 기능을 임베드하는 클라이언트 측 런타임 코드를 제공합니다. 이러한 런타임 클라이언트 API는 로컬로 저장된 앱 코드에 통합되는 라이브러리입니다. 이를 사용하여 {{ site.data.keys.product_adj }} 기능을 클라이언트 앱에 추가합니다. API 및 라이브러리는 {{ site.data.keys.mf_dev_kit_full }}와 함께 설치되거나 개발 플랫폼에 대해 저장소에서 다운로드할 수 있습니다.

### {{ site.data.keys.mf_console }}
{: #mobilefirst-operations-console }
{{ site.data.keys.mf_console }}은 모바일 애플리케이션을 관리 및 제어하는 데 사용됩니다. {{ site.data.keys.mf_console }} 역시 {{ site.data.keys.product }} 개발에 대해 학습하기 위한 시작점이 될 수 있습니다. 콘솔에서는 코드 예제, 도구 및 SDK를 다운로드할 수 있습니다.

다음 태스크에 {{ site.data.keys.mf_console }}을 사용할 수 있습니다.

* 중앙화된 웹 기반 콘솔에서 배치된 모든 애플리케이션, 어댑터 및 푸시 알림 규칙을 모니터링하고 구성하십시오.
* 앱 버전 및 디바이스 유형의 사전 구성된 규칙을 사용하여 {{ site.data.keys.mf_server }} 연결 기능을 원격으로 사용 안함으로 설정합니다.
* 애플리케이션이 실행될 때 사용자에게 전송되는 메시지를 사용자 정의합니다.
* 실행 중인 모든 애플리케이션에서 사용자 통계를 수집합니다.
* 사용자 채택 및 사용에 관한 사전 구성된 기본 제공 보고서를 생성합니다(애플리케이션을 통해 서버와 관련 중인 사용자의 수 및 빈도).
* 애플리케이션 특정 이벤트에 맞게 데이터 콜렉션 규칙을 구성합니다.
* [{{ site.data.keys.mf_console }}에 대해 자세히 알아보십시오](console).

### {{ site.data.keys.mf_analytics }}
{: #mobilefirst-analytics }
{{ site.data.keys.product }}에는 {{ site.data.keys.mf_console }}에서 액세스할 수 있는 확장성 있는 운영 {{ site.data.keys.mf_analytics_short }} 기능이 포함됩니다. {{ site.data.keys.mf_analytics_short }} 기능을 통해 엔터프라이즈는 패턴, 문제점 및 플랫폼 사용법 통계에 대해 디바이스, 앱 및 서버에서 수집된 로그 및 이벤트를 검색할 수 있습니다.

{{ site.data.keys.mf_analytics }}에 대한 데이터는 다음 소스를 포함합니다.

* iOS 및 Android 디바이스의 애플리케이션에 대한 충돌 이벤트(네이티브 코드 및 JavaScript 오류에 대한 충돌 이벤트).
* 애플리케이션-서버 활동의 상호작용(푸시 알림을 포함하여 {{ site.data.keys.mf_cli }}ent/server 프로토콜에서 지원되는 항목).
* 일반적인 {{ site.data.keys.product_adj }} 로그 파일에서 캡처된 서버 측 로그.

[{{ site.data.keys.mf_analytics }}에 대해 자세히 알아보십시오](../../analytics).

### Application Center
{: #application-center }
Application Center를 사용하면 조직에서 개발 중인 모바일 애플리케이션을 모바일 애플리케이션의 단일 저장소에서 공유할 수 있습니다. 개발 팀 구성원은 Application Center를 사용하여 팀의 구성원과 애플리케이션을 공유할 수 있습니다. 이 프로세스로 애플리케이션의 개발에 참여하는 모든 담당자들 간의 협업이 간단해집니다.

회사에서는 일반적으로 다음과 같이 Application Center를 사용할 수 있습니다.

1. 개발 팀에서 하나의 애플리케이션 버전을 작성합니다.
2. 개발 팀이 Application Center에 애플리케이션을 업로드하고 해당 설명을 입력하고 확장 팀에 이를 검토하고 테스트하도록 요청합니다.
3. 새 버전의 애플리케이션이 사용 가능하면 테스트 담당자가 모바일 클라이언트인 Application Center 설치 프로그램 애플리케이션을 실행합니다. 그런 다음, 테스트 담당자는 이 새 버전의 애플리케이션을 찾고 모바일 디바이스에 설치한 후 테스트합니다.
4. 테스트한 후에 테스트 담당자는 애플리케이션의 등급을 지정하고 피드백을 제출합니다. 이 피드백은 개발자가 Application Center 콘솔에서 볼 수 있습니다.

Application Center는 회사에서 개인 용도로 작성되며 일부 모바일 애플리케이션의 대상을 특정 사용자 그룹으로 지정할 수 있습니다. Application Center를 엔터프라이즈 애플리케이션 저장소로 사용할 수 있습니다.

### {{ site.data.keys.mf_system_pattern }}
{: #mobilefirst-system-pattern }
{{ site.data.keys.mf_system_pattern_full }}과 함께 IBM PureApplication System에 {{ site.data.keys.mf_server }} 및 SoftLayer에 IBM PureApplication Service를 배치할 수 있습니다. 이러한 패턴으로 관리자 및 회사는 사내 구축형 Cloud 기술을 활용함으로써 비즈니스 환경에서의 변경사항에 신속하게 대응할 수 있습니다. 이 접근방식을 통해 배치 프로세스가 간단해지고 모바일 수요 증가에 대응하기 위해 운영 효율성이 개선됩니다. 이러한 수요는 기존 수요 주기를 초과하는 솔루션 반복을 가속화합니다. {{ site.data.keys.mf_server }} 패턴을 사용하면 내장 스케일링 정책 같이 우수 사례 및 내장 전문 지식에 대한 액세스도 제공합니다.

#### PureApplication System
{: #pureapplication-system }
IBM PureApplication System은 클라우드 환경에서 애플리케이션 중심 컴퓨팅 모델을 제공하는 IBM X-Architecture를 기반으로 하는 확장성이 강한 통합형 시스템입니다.

애플리케이션 중심 시스템은 복잡한 애플리케이션과 애플리케이션에서 호출하는 태스크 및 프로세스를 관리하기에 효과적인 방법입니다. 전체 시스템은 다양한 자원 구성이 다양한 애플리케이션 워크로드에 맞게 자동으로 조정되는 다양한 가상 컴퓨팅 환경을 구현합니다. IBM PureApplication System 플랫폼의 애플리케이션 관리 기능은 미들웨어 및 기타 애플리케이션 컴포넌트를 쉽고 빠르고 반복적으로 배치할 수 있게 해줍니다.

IBM PureApplication System은 하나의 통합된 시스템에서 전달되는 가상화된 워크로드 및 확장 가능한 인프라를 제공합니다.

#### 가상 시스템 패턴
{: #virtual-system-patterns }
가상 시스템 패턴은 일련의 배치 요구사항을 위한 반복 토폴로지에 대한 논리 표현입니다.

가상 시스템 패턴을 사용하면 하나 이상의 가상 머신 인스턴스를 포함하는 시스템과 이 시스템에서 실행되는 애플리케이션을 효율적으로 반복하여 배치할 수 있습니다. 배치를 완전히 자동화하여 시간이 많이 걸리는 수동 태스크를 여러 번 수행할 필요가 없어집니다. 이러한 배치는 서버 팜 같은 복합 프로덕션 토폴로지에서 특히 오류에 취약한 수동 구성 프로세스에 의해 소개되는 문제점을 제거하고 솔루션 배치를 가속화합니다.
