---
layout: tutorial
title: 라이센스 추적
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
라이센스 추적은 {{site.data.keys.product_full }}에서 기본적으로 사용으로 설정되어 있으며 활성 클라이언트 디바이스, 주소 지정 가능한 디바이스, 설치된 앱과 같은 라이센싱 정책과 관련된 메트릭을 추적합니다. 이 정보는 {{site.data.keys.product }}의 현재 사용이 라이센스 부여 레벨에 속하고 잠재적인 라이센스 위반을 방지할 수 있는지 판별하는 데 유용합니다. 

또한 클라이언트 디바이스 사용량을 추적하고 디바이스가 활성인지 판별하여 {{site.data.keys.product_adj }} 관리자가 {{site.data.keys.mf_server }}에 더 이상 액세스하지 않는 디바이스를 역할 해제할 수 있습니다. 직원이 퇴사하는 경우 등에 이러한 상황이 발생합니다. 

#### 다음으로 이동
{: #jump-to }

* [애플리케이션 라이센스 정보 설정](#setting-the-application-license-information)
* [라이센스 추적 보고서](#license-tracking-report)
* [토큰 라이센스 유효성 검증](#token-license-validation)
* [IBM License Metric Tool과 통합](#integration-with-ibm-license-metric-tool)

## 애플리케이션 라이센스 정보 설정
{: #setting-the-application-license-information }
{{site.data.keys.mf_server }}에 등록하는 앱에 대한 애플리케이션 라이센스 정보를 설정하는 방법에 대해 학습합니다. 

라이센스 조항은 {{site.data.keys.product_full }}, {{site.data.keys.product_full }} Consumer, {{site.data.keys.product_full }} Enterprise, IBM {{site.data.keys.product_adj }} Additional Brand Deployment를 구별합니다. 라이센스 추적 보고서에서 올바른 라이센스 정보를 생성할 수 있도록 애플리케이션을 서버에 등록할 때 애플리케이션의 라이센스 정보를 설정하십시오. 서버가 토큰 라이센싱을 사용하도록 구성되어 있는 경우 라이센스 정보를 사용하여 라이센스 서버에서 올바른 기능을 체크아웃합니다. 

애플리케이션 유형과 토큰 라이센스 유형을 설정하십시오.
애플리케이션 유형의 가능한 값은 다음과 같습니다.   

* **B2C**: 애플리케이션에 {{site.data.keys.product_full }} Consumer 라이센스가 있는 경우 이 애플리케이션 유형을 사용하십시오. 
* **B2E**: 애플리케이션에 {{site.data.keys.product_full }} Enterprise 라이센스가 있는 경우 이 애플리케이션 유형을 사용하십시오. 
* **UNDEFINED**: 주소 지정 가능한 디바이스 메트릭에 대해 규제 준수를 추적할 필요가 없는 경우 이 애플리케이션 유형을 사용하십시오. 

토큰 라이센스 유형의 가능한 값은 다음과 같습니다. 

* **APPLICATION**: 대부분의 애플리케이션에 APPLICATION을 사용하십시오. 이 값이 기본값입니다. 
* **ADDITIONAL\_BRAND\_DEPLOYMENT**: 애플리케이션에 IBM {{site.data.keys.product_adj }} Additional Brand Deployment 라이센스가 있는 경우 이 ADDITIONAL\_BRAND\_DEPLOYMENT를 사용하십시오. 
* **NON_PRODUCTION**: 프로덕션 서버에서 애플리케이션을 개발하고 테스트 중인 경우 NON\_PRODUCTION을 사용하십시오. 토큰 라이센스 유형이 NON_PRODUCTION인 애플리케이션에 대해서는 토큰이 체크아웃되지 않습니다. 

> **중요:** 프로덕션 앱에 NON_PRODUCTION을 사용하는 것은 라이센스 조항 위반입니다. 

**참고:** 서버가 토큰 라이센싱을 사용할 수 있도록 구성되어 있고 토큰 라이센스 유형이 ADDITIONAL\_BRAND\_DEPLOYMENT 또는 NON_PRODUCTION인 애플리케이션을 등록하려는 경우 애플리케이션의 첫 번째 버전을 등록하기 전에 애플리케이션 라이센스 정보를 설정하십시오. mfpadm 프로그램을 사용하여 버전을 등록하기 전에 애플리케이션의 라이센스 정보를 설정할 수 있습니다. 라이센스 정보가 설정된 후 첫 번째 앱 버전을 등록할 때 올바른 수의 토큰을 체크아웃합니다. 토큰 유효성 검증에 대한 자세한 정보는 토큰 라이센스 유효성 검증을 참조하십시오. 

{{site.data.keys.mf_console }}에서 라이센스 유형을 설정하려면 다음을 수행하십시오. 

1. 애플리케이션을 선택하십시오. 
2. **설정**을 선택하십시오. 
3. **애플리케이션 유형**과 **토큰 라이센스 유형**을 설정하십시오. 
4. **저장**을 클릭하십시오. 

mfpadm 프로그램에서 라이센스 유형을 설정하려면
`mfpadm app <appname> set license-config <application-type> <token license type>`을 사용하십시오. 

다음 예제에서는 **my.test.application** 애플리케이션에 라이센스 정보 B2E/APPLICATION을 설정합니다. 

```bash
echo password:admin > password.txt
mfpadm --url https://localhost:9443/mfpadmin --secure false --user admin \ --passwordfile password.txt \ app mfp my.test.application ios 0.0.1 set license-config B2E APPLICATION
rm password.txt
```

## 라이센스 추적 보고서
{: #license-tracking-report }
{{site.data.keys.product }}은 클라이언트 디바이스 메트릭, 주소 지정 가능한 디바이스 메트릭, 애플리케이션 메트릭에 대한 라이센스 추적 보고서를 제공합니다. 또한 보고서는 히스토리 데이터를 제공합니다. 

라이센스 추적 보고서에는 다음과 같은 데이터가 표시됩니다. 

* {{site.data.keys.mf_server }}에 배치된 애플리케이션 수
* 이번 달의 주소 지정 가능한 디바이스 수
* 활성 상태와 역할 해제 상태의 클라이언트 디바이스 수
* 최근 n일 동안 보고된 최대 클라이언트 디바이스 수. 여기서 n은 클라이언트 디바이스가 역할 해제된 후 활동하지 않은 기간(일)입니다. 

데이터를 자세히 분석할 수 있습니다. 이를 위해 라이센스 보고서와 라이센스 메트릭의 히스토리 목록이 포함된 CSV 파일을 다운로드할 수 있습니다. 

라이센스 추적 보고서에 액세스하려면 다음을 수행하십시오. 

1. {{site.data.keys.mf_console }}을 여십시오. 
2. **your-Name님, 안녕하세요** 메뉴를 여십시오. 
3. **라이센스**를 선택하십시오. 

라이센스 추적 보고서에서 CSV 파일을 얻으려면 **조치/보고서 다운로드**를 클릭하십시오. 

## 토큰 라이센스 유효성 검증
{: #token-license-validation }
토큰 라이센싱을 위해 IBM {{site.data.keys.mf_server }}를 설치하고 구성한 경우 서버가 여러 시나리오에서 라이센스의 유효성을 검증합니다. 구성이 올바르지 않으면 애플리케이션 등록 또는 삭제 시 라이센스의 유효성이 검증되지 않습니다. 

### 유효성 검증 시나리오
{: #validation-scenarios }
다양한 시나리오에서 라이센스의 유효성을 검증합니다. 

#### 애플리케이션 등록 시
{: #on-application-registration }
애플리케이션의 토큰 라이센스 유형에 사용할 수 있는 토큰이 부족한 경우 애플리케이션 등록에 실패합니다. 

> **팁:** 첫 번째 앱 버전을 등록하기 전에 토큰 라이센스 유형을 설정할 수 있습니다. 

애플리케이션당 한 번만 라이센스를 확인합니다. 동일한 애플리케이션에 대해 새 플랫폼을 등록하거나 기존 애플리케이션과 플랫폼의 새 버전을 등록하는 경우 새 토큰을 청구하지 않습니다. 

#### 토큰 라이센스 유형 변경 시
{: #on-token-license-type-change }
애플리케이션의 토큰 라이센스 유형을 변경하는 경우 애플리케이션의 토큰을 해제한 후 새 라이센스 유형에 사용하도록 회수합니다. 

#### 애플리케이션 삭제 시
{: #on-application-deletion }
애플리케이션의 마지막 버전이 삭제되면 라이센스를 체크인합니다. 

#### 서버 시작 시
{: #at-server-start }
등록된 모든 애플리케이션에 대해 라이센스를 체크아웃합니다. 모든 애플리케이션에 사용할 수 있는 토큰이 부족한 경우 서버에서 애플리케이션을 비활성화합니다. 

> **중요:** 서버는 애플리케이션을 자동으로 다시 활성화하지 않습니다. 사용 가능한 토큰 수를 늘린 후 애플리케이션을 수동으로 다시 활성화해야 합니다. 애플리케이션 사용 안함 설정과 사용 설정에 대한 자세한 정보는 [보호된 자원에 대한 애플리케이션 액세스를 사용 안함으로 원격 설정](../using-console/#remotely-disabling-application-access-to-protected-resources)을 참조하십시오.

#### 라이센스 만료 시
{: #on-license-expiration }
특정 기간이 지난 후에는 라이센스가 만료되며 다시 체크아웃해야 합니다. 모든 애플리케이션에 사용할 수 있는 토큰이 부족한 경우 서버에서 애플리케이션을 비활성화합니다. 

> **중요:** 서버는 애플리케이션을 자동으로 다시 활성화하지 않습니다. 사용 가능한 토큰 수를 보강한 후 애플리케이션을 수동으로 다시 활성화해야 합니다. 애플리케이션 사용 안함 설정과 사용 설정에 대한 자세한 정보는 [보호된 자원에 대한 애플리케이션 액세스를 사용 안함으로 원격 설정](../using-console/#remotely-disabling-application-access-to-protected-resources)을 참조하십시오.

#### 서버 종료 시
{: #at-server-shutdown }
서버 종료 중에 배치된 모든 애플리케이션에 대해 라이센스를 체크인합니다. 팜 클러스터의 마지막 서버가 종료된 경우에만 토큰이 해제됩니다. 

### 라이센스 유효성 검증 실패 원인
{: #causes-of-license-validation-failure }
다음과 같은 경우 애플리케이션이 등록되거나 삭제되면 라이센스 유효성 검증에 실패합니다. 

* Rational Common Licensing 기본 라이브러리가 설치되어 구성되지 않았습니다. 
* 관리 서비스에 토큰 라이센싱이 구성되어 있지 않습니다. 자세한 정보는 [토큰 라이센싱을 위한 설치 및 구성](../../installation-configuration/production/token-licensing)을 참조하십시오. 
* Rational License Key Server에 액세스할 수 없습니다. 
* 사용할 수 있는 토큰이 부족합니다. 
* 라이센스가 만료되었습니다. 

### {{site.data.keys.product_full }}에서 사용되는 IBM Rational License Key Server 기능 이름
{: #ibm-rational-license-key-server-feature-name-used-by-ibm-mobilefirst-foundation }
애플리케이션의 토큰 라이센스 유형에 따라 다음과 같은 기능이 사용됩니다. 

| 토큰 라이센스 유형 | 기능 이름 | 
|--------------------|--------------|
| APPLICATION        | 	ibmmfpfa    | 
| ADDITIONAL\_BRAND\_DEPLOYMENT |	ibmmfpabd | 
| NON_PRODUCTION	| (기능 없음) | 

## IBM License Metric Tool과 통합
{: #integration-with-ibm-license-metric-tool }
IBM License Metric Tool을 사용하여 IBM 라이센스 준수를 평가할 수 있습니다. 

IBM Software License Metric Tag 또는 SWID(소프트웨어 ID) 파일을 지원하는 BM License Metric Tool 버전을 설치하지 않은 경우에는 {{site.data.keys.mf_console }}에서 라이센스 추적 보고서를 사용해 라이센스 사용을 검토할 수 있습니다. 자세한 정보는 [라이센스 추적 보고서](#license-tracking-report)를 참조하십시오. 

### SWID 파일을 사용하는 PVU 기반 라이센싱 정보
{: #about-pvu-based-licensing-using-swid-files }
IBM MobileFirst Foundation Extension V8.0.0 오퍼링을 구매한 경우 PVU(Processor Value Unit) 메트릭에서 라이센스가 부여됩니다. 

PVU 계산은 ISO/IEC 19970-2 파일과 SWID 파일에 대한 IBM License Metric Tool의 지원을 기반으로 합니다. SWID 파일은 IBM Installation Manager가 {{site.data.keys.mf_server }} 또는 {{site.data.keys.mf_analytics_server }}를 설치할 때 서버에 기록됩니다. IBM License Metric Tool이 현재 카탈로그에 따라 제품에 올바르지 않은 SWID 파일을 발견하면 소프트웨어 카탈로그 위젯에 경고 사인이 표시됩니다. IBM License Metric Tool이 SWID 파일을 사용하여 작업하는 방법에 대한 자세한 정보는 [https://www.ibm.com/support/knowledgecenter/SS8JFY_9.2.0/com.ibm.lmt.doc/Inventory/overview/c\_iso\_tags.html](https://www.ibm.com/support/knowledgecenter/SS8JFY_9.2.0/com.ibm.lmt.doc/Inventory/overview/c_iso_tags.html)의 내용을 참조하십시오. 

Application Center 설치 수는 PVU-based 라이센싱으로 제한되지 않습니다. 

Foundation Extension의 PVU 라이센스는 IBM WebSphere Application Server Network Deployment, IBM API Connect™ Professional 또는 IBM API Connect Enterprise 제품 라이센스와 함께 구매하는 경우에만 구매할 수 있습니다. IBM Installation Manager가 License Metric Tool에서 사용할 SWID 파일을 추가하거나 업데이트합니다. 

> {{site.data.keys.product_full }} Extension에 대한 자세한 정보는 [https://www.ibm.com/common/ssi/cgi-bin/ssialias?infotype=AN&subtype=CA&htmlfid=897/ENUS216-367&appname=USN](https://www.ibm.com/common/ssi/cgi-bin/ssialias?infotype=AN&subtype=CA&htmlfid=897/ENUS216-367&appname=USN)의 내용을 참조하십시오.

> PVU 라이센싱에 대한 자세한 정보는 [https://www.ibm.com/support/knowledgecenter/SS8JFY_9.2.0/com.ibm.lmt.doc/Inventory/overview/c\_processor\_value\_unit\_licenses.html](https://www.ibm.com/support/knowledgecenter/SS8JFY_9.2.0/com.ibm.lmt.doc/Inventory/overview/c_processor_value_unit_licenses.html)의 내용을 참조하십시오.

### SLMT 태그
{: #slmt-tags }
IBM MobileFirst Foundation은 IBM Software License Metric Tag(SLMT) 파일을 생성합니다. IBM Software License Metric Tag를 지원하는 IBM License Metric Tool 버전은 라이센스 이용 보고서를 생성할 수 있습니다. {{site.data.keys.mf_server }}에 대한 해당 보고서를 해석하고 IBM Software License Metric Tag 파일의 생성을 구성하려면 이 절을 읽으십시오. 

실행 중인 MobileFirst 런타임 환경의 각 인스턴스는 IBM Software License Metric Tag 파일을 생성합니다. 모니터되는 메트릭은 `CLIENT_DEVICE`, `ADDRESSABLE_DEVICE`, `APPLICATION`입니다. 24시간마다 해당 값을 새로 고칩니다. 

#### CLIENT_DEVICE 메트릭 정보
{: #about-the-client_device-metric }
`CLIENT_DEVICE` 메트릭에는 다음과 같은 하위 유형이 있습니다. 

* 활성 디바이스

    MobileFirst 런타임 환경 또는 동일한 클러스터나 서버 팜에 속하는 다른 MobileFirst 런타임 인스턴스를 사용한 클라이언트 디바이스와 역할 해제되지 않은 클라이언트 디바이스의 수입니다. 역할 해제된 디바이스에 대한 자세한 정보는 [클라이언트 디바이스 및 주소 지정 가능한 디바이스에 대한 라이센스 추적 구성](../../installation-configuration/production/server-configuration/#configuring-license-tracking-for-client-device-and-addressable-device)을 참조하십시오. 

* 비활성 디바이스

    MobileFirst 런타임 환경 또는 동일한 클러스터나 서버 팜에 속하는 다른 MobileFirst 런타임 인스턴스를 사용한 클라이언트 디바이스와 역할 해제된 클라이언트 디바이스의 수입니다. 역할 해제된 디바이스에 대한 자세한 정보는 [클라이언트 디바이스 및 주소 지정 가능한 디바이스에 대한 라이센스 추적 구성](../../installation-configuration/production/server-configuration/#configuring-license-tracking-for-client-device-and-addressable-device)을 참조하십시오. 

다음은 특정한 경우입니다. 

* 디바이스의 역할 해제 기간이 짧은 기간으로 설정된 경우 "비활성 디바이스" 하위 유형은 "활성 또는 비활성 디바이스" 하위 유형으로 대체됩니다. 
* 디바이스 추적이 사용 안함으로 설정된 경우 `CLIENT_DEVICE`에는 하나의 항목만 생성되며 값은 0이고 메트릭 하위 유형은 "디바이스 추적 사용 안함"입니다. 

#### APPLICATION 메트릭 정보
{: #about-the-application-metric }
개발 서버에서 MobileFirst 런타임 환경이 실행 중인 경우가 아니면 APPLICATION 메트릭에 하위 유형이 없습니다. 

이 메트릭에 대해 보고되는 값은 MobileFirst 런타임 환경에 배치되는 애플리케이션의 수입니다. 각 애플리케이션은 새 애플리케이션인지, 추가 브랜드 배치인지 아니면 기존 애플리케이션의 추가 유형(예: 기본, 하이브리드 또는 웹)인지에 상관없이 한 단위로 계수됩니다. 

#### ADDRESSABLE_DEVICE 메트릭 정보
{: #about-the-addressable_device-metric }
ADDRESSABLE_DEVICE 메트릭에는 다음 하위 유형이 있습니다. 

* 애플리케이션: `<applicationName>`, 카테고리: `<application type>`

애플리케이션 유형은 **B2C**, **B2E** 또는 **UNDEFINED**입니다. 애플리케이션의 애플리케이션 유형을 정의하려면 [애플리케이션 라이센스 정보 설정](#setting-the-application-license-information)을 참조하십시오. 

다음은 특정한 경우입니다. 

* 디바이스의 역할 해제 기간이 30일 미만으로 설정된 경우 "짧은 역할 해제 기간" 경고가 하위 유형에 추가됩니다. 
* 라이센스 추적을 사용하지 않으면 주소 지정 가능 보고서가 생성되지 않습니다. 

메트릭을 사용하여 라이센스 추적을 구성하는 방법에 대한 자세한 정보는 다음을 참조하십시오. 

* [클라이언트 디바이스 및 주소 지정 가능한 디바이스에 대한 라이센스 추적 구성](../../installation-configuration/production/server-configuration/#configuring-license-tracking-for-client-device-and-addressable-device)
* [IBM License Metric Tool 로그 파일 구성](../../installation-configuration/production/server-configuration/#configuring-ibm-license-metric-tool-log-files)
