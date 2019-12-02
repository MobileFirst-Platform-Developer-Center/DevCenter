---
layout: tutorial
title: MobileFirst Server 라이센싱
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
IBM {{ site.data.keys.mf_server }}는 구매한 항목을 기반으로 서로 다른 두 개의 라이센싱 방법을 지원합니다.

영구 라이센스를 획득한 경우, 구매한 제품을 이용할 수 있으며 {{ site.data.keys.mf_console }}의 **라이센스 추적 페이지** 및 [라이센스 추적 보고서](../../administering-apps/license-tracking/#license-tracking-report)를 통해 사용량 및 규제 준수를 확인할 수 있습니다. 토큰 라이센스를 구매한 경우, {{ site.data.keys.mf_server }}에서 원격 토큰 라이센스 서버와 통신하도록 구성하십시오.

### 애플리케이션 또는 주소 지정 가능 디바이스 라이센스
{: #application-or-addressable-device-licenses }
애플리케이션 또는 주소 지정 가능 디바이스 라이센스를 획득한 경우, 구매한 제품을 이용할 수 있으며 {{ site.data.keys.mf_console }}의 라이센스 추적 페이지 및 라이센스 추적 보고서를 통해 사용량 및 규제 준수를 확인할 수 있습니다.

### 가상 프로세서 코어(VPC 라이센싱)
{: #vpc-licensing}

Mobile Foundation은 VPC(Virtual Processor Core)라는 용량 기반 라이센싱으로도 사용 가능합니다. VPC는 Mobile Foundation의 라이센싱 비용을 결정하는 데 사용되는 측정 단위이며 사용 가능한 코어 수를 기반으로 합니다. 현재 이 메트릭은 Cloud Pak for Applications에서만 사용할 수 있습니다.

이 메트릭의 기능은 다음과 같습니다.

* 클라이언트에서는 여러 개의 애플리케이션과 디바이스를 실행할 수 있습니다. 따라서 이 형식의 라이센스는 고객이 배치하는 앱이 많은 시나리오의 경우 애플리케이션 라이센스와 비교하여 유용할 수 있습니다.

* 포트폴리오의 다른 제품과 연계하여 하이브리드 클라우드 배치를 위해 고객에게 유연성을 제공합니다.


### 토큰 라이센싱
{: #token-licensing }
토큰 환경에서는 사전 정의된 라이센스당 수량을 이용하는 일반적인 변동 환경과 비교하여 모든 제품이 사전 정의된 라이센스당 토큰 값을 이용합니다. 라이센스 키에는 라이센스 서버에서 체크인 및 체크아웃되는 토큰을 계산하기 위한 토큰 풀이 있습니다. 제품이 라이센스를 라이센스 서버에 체크인하거나 라이센스 서버에서 체크아웃하면 토큰이 이용되거나 해제됩니다.

라이센싱 계약은 토큰 라이센싱을 사용할 수 있는지 여부, 사용 가능한 토큰 수 및 토큰으로 유효성 검증되는 기능을 정의합니다. 토큰 라이센스 유효성 검증을 참조하십시오.

토큰 기반 라이센스를 구매한 경우 토큰 라이센스를 지원하는 {{ site.data.keys.mf_server }} 버전을 설치하고 서버에서 원격 토큰 서버와 통신할 수 있도록 애플리케이션 서버를 구성하십시오. 토큰 라이센싱을 위한 설치 및 구성을 참조하십시오.

토큰 라이센싱을 사용하는 경우 앱을 배치하기 전에 각 앱의 애플리케이션 디스크립터에 라이센스 앱 유형을 지정할 수 있습니다. 라이센스 앱 유형에는 APPLICATION 또는 ADDITIONAL_BRAND_DEPLOYMENT가 있습니다. 테스트를 위해 라이센스 앱 유형의 값을 NON_PRODUCTION으로 설정할 수 있습니다. 자세한 정보는 애플리케이션 라이센스 설정 정보를 참조하십시오.

Rational License Key Server 8.1.4.9와 함께 릴리스된 Rational License Key Server Administration and Reporting 도구는 {{ site.data.keys.product }}에서 이용되는 라이센스에 대한 보고서를 생성하고 관리할 수 있습니다. **MobileFirst Platform Foundation Application** 및 **MobileFirst Platform Additional Brand Deployment** 등의 표시 이름으로 보고서의 관련 부분을 식별할 수 있습니다. 이러한 이름은 토큰을 이용하는 라이센스 앱 유형을 참조합니다. 자세한 정보는 [Rational License Key Server Administration](https://www.ibm.com/support/knowledgecenter/SSSTWP_8.1.4/com.ibm.rational.license.doc/topics/c_rlks_admin_tool_overview.html) 및 [Reporting Tool overview and Rational License Key Server Fix Pack 9(8.1.4.9)](http://www.ibm.com/support/docview.wss?uid=swg24040300)의 내용을 참조하십시오.

{{ site.data.keys.mf_server }}에서 토큰 라이센싱을 사용하는 계획에 대한 정보는 토큰 라이센싱 사용에 대한 계획을 참조하십시오.

{{ site.data.keys.product }}용 라이센스 키를 얻으려면 IBM Rational License Key Center에 액세스해야 합니다. 라이센스 키 생성 및 관리에 대한 자세한 정보는 [IBM 지원 센터 - 라이센싱](http://www.ibm.com/software/rational/support/licensing/)을 참조하십시오.
