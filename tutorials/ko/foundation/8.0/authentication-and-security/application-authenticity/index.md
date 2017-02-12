---
layout: tutorial
title: 애플리케이션 인증
relevantTo: [android,ios,windows,javascript]
weight: 9
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
HTTP 요청을 발행하여 애플리케이션은 {{ site.data.keys.mf_server }}가 액세스 권한을 제공하는 기업 HTTP 서버(API)에 액세스할 수 있습니다. 사전 정의된 애플리케이션-인증 [보안 검사](../)는 {{ site.data.keys.mf_server }} 인스턴스에 연결을 시도하는 애플리케이션이 인증된 것인지를 확인합니다. 

애플리케이션 인증을 사용으로 설정하려면 **{{site.data.keys.mf_console }}**
→ **[사용자 애플리케이션]** → **인증**에서
화면 지시사항을 따르거나 아래 내용을 검토할 수 있습니다. 

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

## 애플리케이션 인증 플로우
{: #application-authenticity-flow }
기본적으로 애플리케이션-인증 보안 검사는 {{ site.data.keys.mf_server }}에 애플리케이션 런타임의 등록 동안 실행되며, 애플리케이션의 인스턴스가 서버에 처음 연결을 시도할 때 발생합니다. 인증 확인은 다시 발생하지 않습니다. 

이 동작을 사용자 정의하는 방법을 학습하려면 [애플리케이션 인증 구성](#configuring-application-authenticity)을 참조하십시오.

## 애플리케이션 인증 사용
{: #enabling-application-authenticity }
애플리케이션 인증이 Cordova 또는 기본 애플리케이션에서 사용되게 하려면 애플리케이션 2진 파일이 mfp-app-authenticity 도구를 사용하여 서명되어야 합니다. 적합한 2진 파일은 iOS의 경우 `ipa`, Android의 경우 `apk`, Windows 8.1 Universal 및 Windows 10 UWP의 경우 `appx`입니다. 

1. **{{ site.data.keys.mf_console }} → 다운로드 센터**에서 mfp-app-authenticity 도구를 다운로드하십시오. 
2. **명령행** 창을 열고 `java -jar path-to-mfp-app-authenticity.jar path-to-binary-file` 명령을 실행하십시오. 

   예: 

   ```bash
   java -jar /Users/your-username/Desktop/mfp-app-authenticity.jar /Users/your-username/Desktop/MyBankApp.ipa
   ```

   이 명령은 `MyBankApp.ipa` 파일 옆에 `MyBankApp.authenticity_data`라는 `.authenticity_data` 파일을 생성합니다. 

3. 선호하는 브라우저에서 {{ site.data.keys.mf_console }}을 여십시오. 
4. 탐색 사이드바에서 애플리케이션을 선택하고 **인증** 메뉴 항목을 클릭하십시오.
5. `.authenticity_data` 파일을 업로드하려면 **인증 파일 업로드**를 클릭하십시오. 

`.authenticity_data` 파일이 업로드되면 애플리케이션 인증이 사용으로 설정됩니다. 

![애플리케이션 인증 사용](enable_application_authenticity.png)

### 애플리케이션 인증 사용 안함
{: #disabling-application-authenticity }
애플리케이션 인증을 사용 안함으로 설정하려면 **인증 파일 삭제** 단추를 클릭하십시오.

## 애플리케이션 인증 구성
{: #configuring-application-authenticity }
기본적으로 애플리케이션 인증은 클라이언트 등록 동안에만 확인됩니다. 다른 보안 검사와 동일하게 [자원 보호](../#protecting-resources) 아래 지시사항에 따라 콘솔에서 `appAuthenticity` 보안 검사를 사용하여 애플리케이션 또는 자원을 보호하도록 결정할 수 있습니다. 

다음 특성을 사용하여 사전 정의된 애플리케이션-인증 보안 검사를 구성할 수 있습니다.

- `expirationSec`: 3600초/1시간으로 기본 설정됩니다. 인증 토큰이 만료될 때까지 기간을 정의합니다.

인증 검사가 완료된 후에는 설정 값을 기초로 토큰이 만료될 때까지 인증 검사가 다시 발생하지 않습니다. 

#### `expirationSec` 특성을 구성하려면 다음을 수행하십시오. 
{: #to-configure-the-expirationsec property }
1. {{ site.data.keys.mf_console }}을 로드하고 **[사용자 애플리케이션]** → **보안** → **보안 검사 구성**으로 이동한 다음 **새로 작성**을 클릭하십시오. 

2. `appAuthenticity` 범위 요소를 검색하십시오.

3. 새 값을 초 단위로 설정하십시오. 

![콘솔에서 expirationSec 특성 구성](configuring_expirationSec.png)
