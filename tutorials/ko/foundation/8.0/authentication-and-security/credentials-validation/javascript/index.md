---
layout: tutorial
title: JavaScript(Cordova, 웹) 애플리케이션에서 인증 확인 핸들러 구현
breadcrumb_title: JavaScript
relevantTo: [javascript]
weight: 2
downloads:
  - name: Download Web project
    url: https://github.com/MobileFirst-Platform-Developer-Center/PinCodeWeb/tree/release80
  - name: Download Cordova project
    url: https://github.com/MobileFirst-Platform-Developer-Center/PinCodeCordova/tree/release80
  - name: Download SecurityCheck Maven project
    url: https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
보호된 자원에 액세스를 시도할 때 서버(보안 검사)는 핸들할 클라이언트에 대한 하나 이상의 **인증 확인**을 포함하는 목록을 클라이언트에 다시 전송합니다.  
이 목록은 추가 데이터의 선택적 `JSON`과 함께 보안 검사 이름을 나열하는 `JSON object`로 수신됩니다.

```json
{
  "challenges": {
    "SomeSecurityCheck1":null,
    "SomeSecurityCheck2":{
      "some property": "some value"
    }
  }
}
```

그런 다음 클라이언트는 각 보안 검사에 대해 **인증 확인 핸들러**를 등록해야 합니다.  
인증 확인 핸들러는 보안 검사에 특정한 클라이언트 측 동작을 정의합니다.

## 인증 확인 핸들러 작성
{: creating-the-challenge-handler }
인증 확인 핸들러는 로그인 화면 표시, 신임 정보 수집, 신임 정보를 보안 검사에 다시 제출과 같이 {{ site.data.keys.mf_server }}에서 전송한 인증 확인을 핸들합니다.

이 예제에서 보안 검사는 `PinCodeAttempts`이며 [CredentialsValidationSecurityCheck 구현](../security-check)에 정의되어 있습니다. 이 보안 검사가 전송한 인증 확인은 남은 로그인 시도 횟수(`remainingAttempts`) 및 선택적 `errorMsg`를 포함합니다.


인증 확인 핸들러를 작성하고 등록하려면 `WL.Client.createSecurityCheckChallengeHandler()`
API 메소드를 사용하십시오.

```javascript
PinCodeChallengeHandler = WL.Client.createSecurityCheckChallengeHandler("PinCodeAttempts");
```

## 인증 확인 핸들링
{: #handling-the-challenge }
`createSecurityCheckChallengeHandler` 프로토콜의 최소 요구사항은 `handleChallenge()` 메소드를 구현하는 것으로 사용자가 신임 정보를 제공하도록 요청하는 역할을 합니다. `handleChallenge` 메소드는 `JSON` 오브젝트로서 인증 확인을 수신합니다.

이 예제에서는 PIN 코드를 입력하도록 경보가 사용자에게 프롬프트로 표시됩니다.

```javascript
PinCodeChallengeHandler.handleChallenge = function(challenge) {
    var msg = "";

    // Create the title string for the prompt
    if(challenge.errorMsg != null) {
        msg =  challenge.errorMsg + "\n";
    } else {
        msg = "This data requires a PIN code.\n";
    }

    msg += "Remaining attempts: " + challenge.remainingAttempts;

    // Display a prompt for user to enter the pin code     
    var pinCode = prompt(msg, "");

    if(pinCode){ // calling submitChallengeAnswer with the entered value
        PinCodeChallengeHandler.submitChallengeAnswer({"pin":pinCode});
    } else { // calling cancel in case user pressed the cancel button
        PinCodeChallengeHandler.cancel();   
    }                            
};
```

신임 정보가 올바르지 않은 경우, 프레임워크가 다시 `handleChallenge`을 호출할 것으로 예상할 수 있습니다.

## 인증 확인 응답 제출
{: #submitting-the-challenges-answer }
신임 정보를 UI에서 수집한 후에는 `createSecurityCheckChallengeHandler`의 `submitChallengeAnswer()`를 사용하여 응답을 보안 검사로 다시 전송하십시오. 이 예제에서 `PinCodeAttempts`는 제출된 PIN 코드를 포함하는 `pin`이라는 특성을 예상합니다.

```javascript
PinCodeChallengeHandler.submitChallengeAnswer({"pin":pinCode});
```

## 인증 확인 취소
{: #cancelling-the-challenge }
UI에서 **취소** 단추를 클릭한 것처럼 일부 경우에 이 인증 확인을 완전히 버리도록 프레임워크에 알리고자 할 수 있습니다.  
이를 수행하려면 다음을 호출하십시오.

```javascript
PinCodeChallengeHandler.cancel();
```

## 실패 핸들링
{: #handling-failures }
일부 시나리오에서는 실패를 트리거합니다(예: 최대 시도 횟수에 도달). 이를 핸들하려면 `createSecurityCheckChallengeHandler`의 `handleFailure()`를 구현하십시오.  
매개변수로 전달된 JSON 오브젝트의 구조는 실패의 특성에 크게 좌우됩니다.

```javascript
PinCodeChallengeHandler.handleFailure = function(error) {
    WL.Logger.debug("Challenge Handler Failure!");

    if(error.failure && error.failure == "account blocked") {
        alert("No Remaining Attempts!");  
    } else {
        alert("Error! " + JSON.stringify(error));
    }
};
```

## 성공 핸들링
{: #handling-successes }
일반적으로 애플리케이션의 남은 부분이 계속 실행될 수 있도록 프레임워크에서 성공을 자동으로 처리합니다.

선택적으로 `createSecurityCheckChallengeHandler`의 `handleSuccess()` 메소드를 구현하여 프레임워크가 인증 확인 핸들러 플로우를 닫기 전에 작업하도록 선택할 수 있습니다. 여기에서 다시, 매개변수로 전달된 `success` JSON 오브젝트의 컨텐츠와 구조는 보안 검사가 전송한 항목에 따라 달라집니다.

`PinCodeAttemptsCordova` 샘플 애플리케이션에서 success는 추가 데이터를 포함하지 않습니다.

## 인증 확인 핸들러 등록
{: #registering-the-challenge-handler }
인증 확인 핸들러가 올바른 인증 확인을 청취하도록 프레임워크에 특정 보안 검사 이름과 인증 확인 핸들러를 연관시키도록 알려야 합니다.  
이를 위해서 다음과 같이 보안 검사를 사용하여 인증 확인 핸들러를 작성하십시오.

```javascript
someChallengeHandler = WL.Client.createSecurityCheckChallengeHandler("the-securityCheck-name");
```

## 샘플 애플리케이션
{: #sample-applications }
**PinCodeWeb** 및 **PinCodeCordova** 프로젝트는 은행 잔고를 가져오기 위해 `WLResourceRequest`를 사용합니다.  
메소드는 최대 3번의 시도로 PIN 코드로 보호됩니다.

웹 프로젝트를 [다운로드하려면 클릭](https://github.com/MobileFirst-Platform-Developer-Center/PinCodeWeb/tree/release80)하십시오.  
Cordova 프로젝트를 [다운로드하려면 클릭](https://github.com/MobileFirst-Platform-Developer-Center/PinCodeCordova/tree/release80)하십시오.  
SecurityAdapters Maven 프로젝트를 [다운로드하려면 클릭](https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80)하십시오.  

### 샘플 사용법
{: #sample-usage }
샘플의 README.md 파일에 있는 지시사항을 따르십시오.

![샘플 애플리케이션](pincode-attempts-cordova.png)
