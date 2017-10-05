---
layout: tutorial
title: Windows 8.1 Universal 및 Windows 10 UWP 애플리케이션에서 인증 확인 핸들러 구현
breadcrumb_title: Windows
relevantTo: [windows]
weight: 5
downloads:
  - name: Win8 프로젝트 다운로드
    url: https://github.com/MobileFirst-Platform-Developer-Center/PinCodeWin8/tree/release80
  - name: Win10 프로젝트 다운로드
    url: https://github.com/MobileFirst-Platform-Developer-Center/PinCodeWin10/tree/release80
  - name: SecurityCheck Maven 프로젝트 다운로드
    url: https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
보호된 자원에 액세스를 시도할 때 서버(보안 검사)는 핸들할 클라이언트에 대한 하나 이상의 **인증 확인**을 포함하는 목록을 클라이언트에 다시 전송합니다.   
이 목록은 추가 데이터의 선택적 `JSON`과 함께 보안 검사 이름을 나열하는 `JSON` 오브젝트로 수신됩니다.

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
{: #creating-the-challenge-handler }
인증 확인 핸들러는 로그인 화면 표시, 신임 정보 수집, 신임 정보를 보안 검사에 다시 제출과 같이 {{ site.data.keys.mf_server }}에서 전송한 인증 확인을 핸들하는 클래스입니다. 

이 예제에서 보안 검사는 `PinCodeAttempts`이며 [CredentialsValidationSecurityCheck 구현](../security-check)에 정의되어 있습니다. 이 보안 검사가 전송한 인증 확인은 남은 로그인 시도 횟수(`remainingAttempts`) 및 선택적 `errorMsg`를 포함합니다. 

`Worklight.SecurityCheckChallengeHandler`를 확장하는 C# 클래스를 작성하십시오. 

```csharp
public class PinCodeChallengeHandler : Worklight.SecurityCheckChallengeHandler
{
}
```

## 인증 확인 핸들링
{: #handling-the-challenge }
`SecurityCheckChallengeHandler` 클래스의 최소 요구사항은 생성자와 `HandleChallenge` 메소드를 구현하는 것으로 사용자가 신임 정보를 제공하도록 요청하는 역할을 합니다. `HandleChallenge` 메소드는 `Object`로서 인증 확인을 수신합니다. 

생성자 메소드를 추가하십시오. 

```csharp
public PinCodeChallengeHandler(String securityCheck) {
    this.securityCheck = securityCheck;
}
```

이 `HandleChallenge` 예제에서 PIN 코드를 입력하도록 경보가 사용자에게 프롬프트로 표시됩니다.

```csharp
public override void HandleChallenge(Object challenge)
{
    try
    {
      JObject challengeJSON = (JObject)challenge;

      if (challengeJSON.GetValue("errorMsg") != null)
      {
          if (challengeJSON.GetValue("errorMsg").Type == JTokenType.Null)
              errorMsg = "This data requires a PIN Code.\n";
      }

      await CoreApplication.MainView.CoreWindow.Dispatcher.RunAsync(CoreDispatcherPriority.Normal,
           async () =>
           {
               _this.HintText.Text = "";
               _this.LoginGrid.Visibility = Visibility.Visible;
               if (errorMsg != "")
               {
                   _this.HintText.Text = errorMsg + "Remaining attempts: " + challengeJSON.GetValue("remainingAttempts");
               }
               else
               {
                   _this.HintText.Text = challengeJSON.GetValue("errorMsg") + "\n" + "Remaining attempts: " + challengeJSON.GetValue("remainingAttempts");
               }

               _this.GetBalance.IsEnabled = false;
           });
    } catch (Exception e)
    {
        Debug.WriteLine(e.StackTrace);
    }
}
```

> `showChallenge`의 구현이 샘플 애플리케이션에 포함됩니다. 

신임 정보가 올바르지 않은 경우, 프레임워크가 다시 `HandleChallenge`을 호출할 것으로 예상할 수 있습니다. 

## 인증 확인 응답 제출
{: #submitting-the-challenges-answer }
신임 정보를 UI에서 수집한 후에는 `SecurityCheckChallengeHandler`의 `ShouldSubmitChallengeAnswer()` 및 `GetChallengeAnswer()` 메소드를 사용하여 응답을 보안 검사로 다시 전송하십시오. `ShouldSubmitChallengeAnswer()`는 인증 확인 응답을 보안 검사로 다시 전송해야 하는지 여부를 표시하는 부울 값을 리턴합니다. 이 예제에서 `PinCodeAttempts`는 제출된 PIN 코드를 포함하는 `pin`이라는 특성을 예상합니다. 

```csharp
public override bool ShouldSubmitChallengeAnswer()
{
  JObject pinJSON = new JObject();
  pinJSON.Add("pin", pinCodeTxt.Text);
  this.challengeAnswer = pinJSON;
  return this.shouldsubmitchallenge;
}

public override JObject GetChallengeAnswer()
{
  return this.challengeAnswer;
}

```

## 인증 확인 취소
{: #cancelling-the-challenge }
UI에서 **취소** 단추를 클릭한 것처럼 일부 경우에 이 인증 확인을 완전히 버리도록 프레임워크에 알리고자 할 수 있습니다.

이를 수행하려면 `ShouldCancel` 메소드를 대체하십시오. 


```csharp
public override bool ShouldCancel()
{
  return shouldsubmitcancel;
}
```

## 인증 확인 핸들러 등록
{: #registering-the-challenge-handler }
인증 확인 핸들러가 올바른 인증 확인을 청취하도록 프레임워크에 특정 보안 검사 이름과 인증 확인 핸들러를 연관시키도록 알려야 합니다.

이를 위해서 다음과 같이 보안 검사를 사용하여 인증 확인 핸들러를 초기화하십시오.

```csharp
PinCodeChallengeHandler pinCodeChallengeHandler = new PinCodeChallengeHandler("PinCodeAttempts");
```

그런 다음 인증 확인 핸들러 인스턴스를 **등록**해야 합니다. 

```csharp
IWorklightClient client = WorklightClient.createInstance();
client.RegisterChallengeHandler(pinCodeChallengeHandler);
```

## 샘플 애플리케이션
{: #sample-application }
**PinCodeWin8** 및 **PinCodeWin10**
샘플은 C# 애플리케이션이며 예금 잔고를 가져오기 위해 `ResourceRequest`를 사용합니다.   
메소드는 최대 3번의 시도로 PIN 코드로 보호됩니다. 

SecurityCheckAdapters Maven 프로젝트를 [다운로드하려면 클릭](https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80)하십시오.   
Windows 8 프로젝트를 [다운로드하려면 클릭](https://github.com/MobileFirst-Platform-Developer-Center/PinCodeWin8/tree/release80)하십시오.   
Windows 10 UWP 프로젝트를 [다운로드하려면 클릭](https://github.com/MobileFirst-Platform-Developer-Center/PinCodeWin10/tree/release80)하십시오. 

### 샘플 사용법
{: #sample-usage }
샘플의 README.md 파일에 있는 지시사항을 따르십시오. 

![샘플 애플리케이션](sample-application.png)   
