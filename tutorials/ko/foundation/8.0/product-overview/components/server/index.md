---
layout: tutorial
title: MobileFirst Server
relevantTo: [ios,android,windows,javascript]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
{{ site.data.keys.mf_server }}는 여러 컴포넌트로 구성됩니다. 사용자가 각 컴포넌트의 기능을 이해할 수 있도록 {{ site.data.keys.mf_server }} 아키텍처의 개요가 제공됩니다.

{{ site.data.keys.mf_server }} V7.1 이하와 달리 V8.0.0용 설치 프로세스는 모바일 앱 조작의 개발과 배치와 별개입니다. V8.0.0에서는 서버 컴포넌트 및 데이터베이스가 설치되고 구성된 후에 애플리케이션 서버 또는 데이터베이스 구성에 액세스할 필요 없이 대부분의 조작에 대해 {{ site.data.keys.mf_server }}가 작동할 수 있습니다.

{{ site.data.keys.product_adj }} 아티팩트의 관리 및 배치 조작은 {{ site.data.keys.mf_console }} 또는 {{ site.data.keys.mf_server }} 관리 서비스의 REST API를 통해 수행됩니다. 조작은 이 API를 랩핑하는 일부 명령행 도구(예: mfpdev 또는 mfpadm 등)에 의해 수행될 수도 있습니다. {{ site.data.keys.mf_server }}의 권한 부여된 사용자는 모바일 애플리케이션의 서버 측 구성을 수정하거나 서버 측 코드(어댑터)를 업로드 및 구성하거나 Cordova 모바일 앱에 대한 새 웹 자원을 업로드하거나 애플리케이션 관리 조작을 실행할 수 있습니다.

{{ site.data.keys.mf_server }}는 네트워크 인프라 또는 애플리케이션 서버의 보안 계층 외에 추가 보안 계층을 제공합니다. 보안 기능에는 애플리케이션 인증 제어 및 서버 측 자원 및 어댑터에 대한 액세스 제어가 포함됩니다. 이러한 보안 구성은 {{ site.data.keys.mf_console }} 및 관리 서비스의 권한 부여된 사용자에 의해서도 수행될 수 있습니다. 사용자는 [{{ site.data.keys.mf_server }} 관리용 사용자 인증 구성](../../../installation-configuration/production/server-configuration)에 설명된 대로 이를 보안 역할에 맵핑함으로써 {{ site.data.keys.product_adj }} 관리자의 권한을 판별합니다. 

개발자는 사전 구성되었으며 데이터베이스 또는 애플리케이션 서버 등의 필수 소프트웨어가 필요하지 않은 {{ site.data.keys.mf_server }}의 단순화 버전을 사용할 수 있습니다. [{{ site.data.keys.product_adj }} Development Server 설정](../../../installation-configuration/development)을 참조하십시오.

## {{ site.data.keys.mf_server }} 컴포넌트
{: #mobilefirst-server-components }
{{ site.data.keys.mf_server }} 컴포넌트의 아키텍처는 다음과 같이 설명됩니다. 

![{{ site.data.keys.mf_server }}](server_components.jpg)

### {{ site.data.keys.mf_server }}의 코어 컴포넌트
{: #core-components-of-mobilefirst-server }
{{ site.data.keys.mf_console }}, {{ site.data.keys.mf_server }} 관리 서비스, {{ site.data.keys.mf_server }} 라이브 업데이트 서비스, {{ site.data.keys.mf_server }} 아티팩트, {{ site.data.keys.product_adj }} 런타임은 설치할 최소 컴포넌트 세트입니다.  

* 런타임은 모바일 디바이스에서 실행되는 모바일 앱에 {{ site.data.keys.product_adj }} 서비스를 제공합니다. 
* 관리 서비스는 구성 및 관리 기능을 제공합니다. mfpadm 또는 mfpdev와 같이 {{ site.data.keys.mf_console }}, 라이브 업데이트 서비스 REST API 또는 명령행 도구를 통해 관리 서비스를 사용합니다.  
* 라이브 업데이트 서비스는 구성 데이터를 관리하며 관리 서비스에서 사용됩니다. 

이러한 컴포넌트에는 데이터베이스가 필요합니다. 각 컴포넌트에 대한 데이터베이스 테이블 이름에는 교차 지점이 없습니다. 따라서 동일한 데이터베이스 또는 동일한 스키마를 사용하여 이러한 컴포넌트의 모든 테이블을 저장할 수 있습니다. 자세한 정보는 [데이터베이스 설정](../../../installation-configuration/production/server-configuration)을 참조하십시오.

런타임의 인스턴스를 둘 이상 설치할 수 있습니다. 이 경우 각 인스턴스에 자체 데이터베이스가 필요합니다. 아티팩트 컴포넌트는 {{ site.data.keys.mf_console }}의 자원을 제공합니다. 데이터베이스는 필요하지 않습니다.

### {{ site.data.keys.mf_server }}의 선택적 컴포넌트
{: #optional-components-of-mobliefirst-server }
{{ site.data.keys.mf_server }} 푸시 서비스는 푸시 알림 기능을 제공합니다. 이는 {{ site.data.keys.product_adj }} 푸시 기능을 사용하는 모바일 앱의 이러한 기능을 제공하기 위해 설치되어야 합니다. 모바일 앱의 관점에서 보면 컨텍스트 루트가 `/imfpush`인 점만 제외하면 푸시 서비스의 URL이 런타임의 URL과 동일합니다. 

런타임 외의 다른 서버 또는 클러스터에 푸시 서비스를 설치할 계획인 경우, HTTP 서버의 경로 지정 규칙을 구성해야 합니다. 구성으로 인해 푸시 서비스 및 런타임에 대한 요청이 적절히 경로 지정됩니다.  

푸시 서비스에는 데이터베이스가 필요합니다. 푸시 서비스의 테이블은 런타임, 관리 서비스 및 라이브 업데이트 서비스의 테이블과 교차 지점이 없습니다. 따라서 동일한 데이터베이스 또는 스키마에 설치될 수 있습니다. 

{{ site.data.keys.mf_analytics }} 서비스 및 {{ site.data.keys.mf_analytics_console }}은 모바일 앱 사용에 대한 모니터링 및 분석 정보를 제공합니다. 모바일 앱은 로거 SDK를 사용하여 더 많은 통찰을 제공할 수 있습니다. {{ site.data.keys.mf_analytics }} 서비스에는 데이터베이스가 필요하지 않습니다. Elasticsearch를 사용하여 디스크에 로컬 형식으로 데이터를 저장합니다. 데이터는 Analytics 서비스의 클러스터 멤버 사이에서 복제될 수 있는 샤드 형식으로 구조화됩니다.

네트워크 플로우에 대한 자세한 정보 및 이러한 컴포넌트에 대한 토폴로지 제한조건에 대해서는 [토폴로지 및 네트워크 플로우](../../../installation-configuration/production/server-configuration)를 참조하십시오.

### 설치 프로세스
{: #installation-process }
다음 방법으로 {{ site.data.keys.mf_server }} 사내 구축형 설치를 완료할 수 있습니다.

* Server Configuration Tool - 그래픽 마법사 
* 명령행 도구를 통한 Ant 태스크
* 수동 설치

{{ site.data.keys.mf_server }} 사내 구축 환경 설치에 대한 자세한 정보는 다음을 참조하십시오. 

* WebSphere Application Server Liberty 프로파일에 대한 {{ site.data.keys.mf_server }} 팜의 [전체 설치 관련 안내서](../../../installation-configuration/production/). 안내서는 그래픽 모드 또는 명령행 모드 중 하나에서 설치를 시도하도록 할 수 있는 단순 시나리오를 기반으로 합니다. 
* 애플리케이션 전제조건, 데이터베이스 설정, 서버 토폴로지, 애플리케이션에 대한 컴포넌트의 배치, 서버 구성에 대한 세부사항이 포함된 [상세한 섹션](../../../installation-configuration/production/).

