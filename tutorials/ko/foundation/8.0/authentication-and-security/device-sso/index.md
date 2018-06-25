---
layout: tutorial
title: 디바이스 싱글 사인온(SSO) 구성
breadcrumb_title: Device SSO
relevantTo: [android,ios,windows,cordova]
weight: 11
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
{{ site.data.keys.product_full }}은 동일한 디바이스에서 다중 애플리케이션 사이에 사용자 정의 보안 검사의 상태를 공유할 수 있게 하는 싱글 사인온(SSO) 기능을 제공합니다. 예를 들어 디바이스 SSO를 사용하여 사용자는 디바이스에서 한 애플리케이션에 사인온하고 동일한 구현을 사용하는 동일한 디바이스에 있는 다른 애플리케이션에서 성공적으로 인증받을 수도 있습니다.

**전제조건**: [인증 및 보안](../) 학습서를 읽으십시오.

## SSO 구성
{: #configuring-sso }
{{ site.data.keys.mf_console }}에서 다음을 수행하십시오.

1. **[사용자 애플리케이션] → 보안 탭 → 보안 검사 구성** 섹션으로 이동하십시오.
2. **새로 작성** 단추를 클릭하여 새로운 보안 검사 구성을 작성하거나 보안 검사 구성이 이미 존재하는 경우 **편집** 아이콘을 클릭하십시오.
3. **보안 검사 특성 구성** 대화 상자에서 **디바이스 SSO 사용** 설정을 **true**로 설정하고 `OK`를 누르십시오.

디바이스 SSO을 사용으로 설정하려는 각 애플리케이션에 대해 이러한 단계를 반복하십시오.

<img class="gifplayer" alt="{{ site.data.keys.mf_console }}에서 디바이스 SSO 구성" src="enable-device-sso.png"/>

필수 구성으로 애플리케이션의 구성 JSON 파일을 수동으로 편집하고 변경사항을 다시 {{ site.data.keys.mf_server }}로 푸시할 수도 있습니다.

1. **명령행 창**에서 프로젝트의 루트 폴더로 이동하여 `mfpdev app pull`을 실행하십시오.
2. **[project-folder]\mobilefirst** 폴더에 있는 구성 파일을 여십시오.
3. 선택한 사용자 정의 보안 검사에 대해 디바이스 SSO를 사용으로 설정하도록 파일을 편집하십시오. 디바이스 SSO는 사용자 정의 보안 검사의 `enableSSO` 특성을 `true`로 설정하여 활성화됩니다. 특성 구성은 `securityCheckConfigurations` 오브젝트에 중첩된 보안 검사 오브젝트 안에 들어 있습니다. 애플리케이션 디스크립터 파일에서 이 오브젝트를 찾거나, 없으면 새로 작성하십시오. 예:

   ```xml
   "securityCheckConfigurations": {
        "UserAuthentication": {
            ...
            ...
            "enableSSO": true
        }
   }
   ```
   
4. 다음 명령 `mfpdev app push`를 실행하여 업데이트된 구성 JSON 파일을 배치하십시오.

## 기존의 샘플과 함께 디바이스 SSO 사용
{: #using-device-sso-with-a-pre-existing-sample }
디바이스 SSO를 구성하는 데 샘플이 사용되므로 [신임 정보 유효성 검증](../credentials-validation/) 학습서를 읽으십시오.  
이 데모의 경우 Cordova 샘플 애플리케이션이 사용되지만 iOS, Android, 및 Windows 샘플 애플리케이션을 사용해서 동일하게 작업할 수도 있습니다.

1. [샘플 사용법 지시사항](../credentials-validation/javascript/#sample-usage)을 따르십시오.
2. 다른 샘플 이름과 애플리케이션 ID로 단계를 반복하십시오.
3. 동일한 디바이스에서 두 애플리케이션을 실행하십시오. 각 애플리케이션에서 사용자에게 핀코드("1234")가 어떻게 프롬프트되는지 확인하십시오.
4. {{ site.data.keys.mf_console }}에서 위의 지침대로 각 애플리케이션에 대해 `Enable Device SSO`를 `true`로 설정하십시오.
5. 두 애플리케이션을 종료하고 다시 시도하십시오. 열어 놓은 첫 번째 애플리케이션에서 **잔고 가져오기** 단추를 누르면 핀코드를 한 번 입력하라는 프롬프트가 표시됩니다. 두 번째 애플리케이션을 열고 **잔고 가져오기** 단추를 누른 후에는 잔고를 가져오기 위해 핀코드를 다시 입력할 필요가 없습니다.
`PinCodeAttempts` 보안 검사는 60초 만기 토큰을 가집니다. 따라서 60초 후 추가로 한 번 시도한 후에는 두 번째 애플리케이션에서 핀코드를 요구합니다.

![핀코드 cordova 샘플 애플리케이션](pincode-attempts-cordova.png)
