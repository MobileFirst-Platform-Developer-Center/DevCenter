---
layout: tutorial
title: 애플리케이션 인증
relevantTo: [android,ios,windows,javascript]
weight: 9
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }

애플리케이션을 적절하게 보안 처리하려면 사전 정의된 {{ site.data.keys.product_adj }} 애플리케이션 인증 [보안 검사](../#security-checks)(`appAuthenticity`)를 사용으로 설정하십시오. 사용으로 설정되면 이 검사는 애플리케이션에 서비스를 제공하기 전에 애플리케이션 인증의 유효성을 검증합니다. 프로덕션 환경의 애플리케이션에는 이 기능이 사용으로 설정되어 있어야 합니다. 

애플리케이션 인증을 사용으로 설정하려면 **{{ site.data.keys.mf_console }}** → **[사용자 애플리케이션]** → **인증**에서 화면 지시사항을 따르거나 아래 내용을 검토할 수 있습니다. 

#### 가용성
{: #availability }
* 애플리케이션 인증은 지원되는 모든 플랫폼(iOS, Android, Windows 8.1 Universal, Windows 10 UWP)의 Cordova 및 기본 애플리케이션에서 사용 가능합니다. 

#### 제한사항
{: #limitations }
* 애플리케이션 인증은 iOS에서 **Bitcode**를 지원하지 않습니다. 따라서 애플리케이션 인증을 사용하기 전에 Xcode 프로젝트 특성에서 Bitcode를 사용 안함으로 설정하십시오. 

#### 다음으로 이동:
{: #jump-to }
- [애플리케이션 인증 플로우](#application-authenticity-flow)
- [애플리케이션 인증 사용](#enabling-application-authenticity)
- [애플리케이션 인증 구성](#configuring-application-authenticity)
- [BTS(Build Time Secret)](#bts)
- [문제점 해결](#troubleshooting)
  - [재설정](#reset)
  - [유효성 검증 유형](#validation)
  - [SDK 버전 8.0.0.0-MFPF-IF201701250919 이하에 대한 지원](#legacy)

## 애플리케이션 인증 플로우
{: #application-authenticity-flow }
애플리케이션 인증 보안 검사는 애플리케이션이 {{ site.data.keys.mf_server }}에 등록하는 동안 실행되며, 애플리케이션의 인스턴스가 서버에 처음 연결을 시도할 때 발생합니다. 기본적으로 인증 확인은 한 번만 실행됩니다. 

이 동작을 사용자 정의하는 방법을 학습하려면 [애플리케이션 인증 구성](#configuring-application-authenticity)을 참조하십시오.

## 애플리케이션 인증 사용
{: #enabling-application-authenticity }
애플리케이션에서 애플리케이션 인증을 사용으로 설정하려면 다음 작업을 수행하십시오. 

1. 선호하는 브라우저에서 {{ site.data.keys.mf_console }}을 여십시오. 
2. 탐색 사이드바에서 애플리케이션을 선택하고 **인증** 메뉴 항목을 클릭하십시오.
3. **상태** 상자의 **설정/해제** 단추를 토글하십시오. 

![애플리케이션 인증 사용](enable_application_authenticity.png)

### 애플리케이션 인증 사용 안함
{: #disabling-application-authenticity }
개발 중 애플리케이션에 대한 특정 변경사항으로 인해 인증 유효성 검증이 실패할 수 있습니다. 따라서, 개발 프로세스 중에는 애플리케이션 인증을 사용 안함으로 설정하는 것이 좋습니다. 프로덕션 환경의 애플리케이션에는 이 기능이 사용으로 설정되어 있어야 합니다. 

애플리케이션 인증을 사용 안함으로 설정하려면 **상태** 상자의 **설정/해제** 단추를 다시 토글하십시오. 

## 애플리케이션 인증 구성
{: #configuring-application-authenticity }
기본적으로 애플리케이션 인증은 클라이언트 등록 동안에만 확인됩니다. 그러나 다른 보안 검사와 마찬가지로, 사용자는 [자원 보호](../#protecting-resources) 아래 지시사항에 따라 콘솔에서 `appAuthenticity` 보안 검사를 사용하여 애플리케이션 또는 자원을 보호하도록 결정할 수 있습니다. 

다음 특성을 사용하여 사전 정의된 애플리케이션-인증 보안 검사를 구성할 수 있습니다.

- `expirationSec`: 3600초/1시간으로 기본 설정됩니다. 인증 토큰이 만료될 때까지 기간을 정의합니다.

인증 검사가 완료된 후에는 설정 값을 기초로 토큰이 만료될 때까지 인증 검사가 다시 발생하지 않습니다. 

#### `expirationSec` 특성을 구성하려면 다음을 수행하십시오. 
{: #to-configure-the-expirationsec property }
1. {{ site.data.keys.mf_console }}을 로드하고 **[사용자 애플리케이션]** → **보안** → **보안 검사 구성**으로 이동한 다음 **새로 작성**을 클릭하십시오. 

2. `appAuthenticity` 범위 요소를 검색하십시오.

3. 새 값을 초 단위로 설정하십시오. 

![콘솔에서 expirationSec 특성 구성](configuring_expirationSec.png)

## BTS(Build Time Secret)
{: #bts }
BTS(Build Time Secret)는 iOS 애플리케이션 전용으로, **인증 유효성 검증을 보강하는 선택적 도구**입니다. 이 도구는 빌드 시간에 결정되는 본인확인정보를 애플리케이션에 삽입하며, 이는 나중에 인증 유효성 검증 프로세스에 사용됩니다. 

BTS 도구는 **{{ site.data.keys.mf_console }}** → **다운로드 센터**에서 다운로드할 수 있습니다. 

Xcode에서 BTS 도구를 사용하려면 다음 작업을 수행하십시오. 
1. **빌드 단계** 탭에서 **+** 단추를 클릭하여 새 **스크립트 실행 단계**를 작성하십시오. 
2. BTS 도구의 경로를 복사하여 작성한 새 "스크립트 실행 단계"에 붙여넣으십시오. 
3. 스크립트 실행 단계를 끌어 **소스 컴파일** 단계 위에 놓으십시오. 

이 도구는 애플리케이션의 프로덕션 버전을 빌드할 때 사용해야 합니다. 

## 문제점 해결
{: #troubleshooting }

### 재설정
{: #reset }
애플리케이션 인증 알고리즘은 유효성 검증에 애플리케이션 데이터 및 메타데이터를 사용합니다. 애플리케이션 인증을 사용으로 설정한 후 서버에 처음으로 연결하는 디바이스는 이러한 데이터 일부를 포함하고 있는 애플리케이션의 "지문"을 제공합니다. 

알고리즘에 새 데이터를 제공하여 이러한 지문을 재설정할 수 있습니다. 이는 개발 중에 유용합니다(예: Xcode에서 애플리케이션을 변경한 후). 지문을 재설정하려면 [**mfpadm** CLI](../../administering-apps/using-cli/)에서 **reset** 명령을 사용하십시오. 

지문을 재설정한 후 appAuthenticity 보안 검사는 이전과 마찬가지로 작동합니다(사용자는 이를 쉽게 확인할 수 있음). 

### 유효성 검증 유형
{: #validation }

기본적으로 애플리케이션 인증은 사용으로 설정된 경우 **동적** 유효성 검증 알고리즘을 사용합니다. 동적 애플리케이션 인증 유효성 검증은 애플리케이션의 인증을 판별하기 위해 모바일 플랫폼 고유 기능을 사용합니다. 따라서 유효성 검증은 모바일 운영 체제에 이전 버전과 호환되지 않는 변경사항이 도입된 경우 영향을 받을 수 있으며, 이로 인해 인증된 애플리케이션이 서버에 연결하지 못하게 될 수 있습니다. 

이러한 잠재적 문제를 해결하기 위해 **정적** 유효성 검증 알고리즘이 사용 가능합니다. 이 유효성 검증 유형은 OS 고유 변경사항의 영향을 덜 받습니다. 

유효성 검증 유형을 전환하려면 [**mfpadm** CLI](../../administering-apps/using-cli/)를 사용하여 다음 명령을 실행하십시오. 

```bash
app version [RUNTIME-NAME] APP-NAME ENVIRONMENT VERSION set authenticity-validation TYPE
```
`TYPE`은 `dynamic` 또는 `static`이 될 수 있습니다.

### SDK 버전 8.0.0.0-MFPF-IF201701250919 이하에 대한 지원
{: #legacy }
동적 및 정적 유효성 검증 유형은 **2017년 2월 이후**에 릴리스된 클라이언트 SDK에서만 지원합니다. **8.0.0.0-MFPF-IF201701250919 이하** SDK 버전의 경우에는 레거시 애플리케이션 인증 도구를 사용하십시오. 

애플리케이션 2진 파일은 mfp-app-authenticity 도구를 사용하여 서명되어야 합니다. 적합한 2진 파일은 iOS의 경우 `ipa`, Android의 경우 `apk`, Windows 8.1 Universal 및 Windows 10 UWP의 경우 `appx`입니다. 

1. **{{ site.data.keys.mf_console }} → 다운로드 센터**에서 mfp-app-authenticity 도구를 다운로드하십시오. 
2. **명령행** 창을 열고 `java -jar path-to-mfp-app-authenticity.jar path-to-binary-file` 명령을 실행하십시오. 

   예: 

   ```bash
   java -jar /Users/your-username/Desktop/mfp-app-authenticity.jar /Users/your-username/Desktop/MyBankApp.ipa
   ```

   이 명령은 `MyBankApp.ipa` 파일 옆에 `MyBankApp.authenticity_data`라는 `.authenticity_data` 파일을 생성합니다. 
3. [**mfpadm** CLI](../../administering-apps/using-cli/)를 사용하여 `.authenticity_data` 파일을 업로드하십시오. 
  ```bash
  app version [RUNTIME-NAME] APP-NAME ENVIRONMENT VERSION set authenticity-data FILE
  ```
