---
layout: tutorial
title: JavaScript(Cordova, 웹) 애플리케이션에서 인증 확인 핸들러 구현
breadcrumb_title: JavaScript
relevantTo: [javascript]
weight: 2
다운로드:
  - 이름: PreemptiveLogin Cordova 프로젝트 다운로드
    url: https://github.com/MobileFirst-Platform-Developer-Center/PreemptiveLoginCordova/tree/release80
  - 이름: PreemptiveLogin 웹 프로젝트 다운로드
    url: https://github.com/MobileFirst-Platform-Developer-Center/PreemptiveLoginWeb/tree/release80
  - 이름: RememberMe Cordova 프로젝트 다운로드
    url: https://github.com/MobileFirst-Platform-Developer-Center/RememberMeCordova/tree/release80
  - 이름: RememberMe 웹 프로젝트 다운로드
    url: https://github.com/MobileFirst-Platform-Developer-Center/RememberMeWeb/tree/release80
  - 이름: SecurityCheck Maven 프로젝트 다운로드
    url: https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
**전제조건:** **CredentialsValidationSecurityCheck**의 [인증 확인 핸들러 구현](../../credentials-validation/javascript) 학습서를 읽으십시오. 

인증 확인 핸들러는 선점형 `login`, `logout` 및 `obtainAccessToken`과 같이 몇 개의 추가 기능(API)을 보여줍니다. 

## 로그인
{: #login }
이 예제에서 `UserLogin`은 `username` 및 `password`라는 *키:값*을 예상합니다. 선택적으로 더 긴 기간 동안 이 사용자를 기억하도록 보안 검사에 알리는 부울 `rememberMe` 키를 허용하기도 합니다. 이는 샘플 애플리케이션에서 로그인 양식의 선택란에서 부울 값을 사용하여 수집됩니다. 

```js
userLoginChallengeHandler.submitChallengeAnswer({'username':username, 'password':password, rememberMe: rememberMeState});
```

인증 확인을 수신하지 않고 사용자를 로그인하고자 할 수 있습니다. 예를 들어 애플리케이션의 첫 번째 화면으로 로그인 화면을 표시하거나 로그아웃 또는 로그인 실패 후에 로그인 화면을 표시할 수 있습니다. 이러한 시나리오를 **선점형 로그인**이라고 부릅니다.

응답할 인증 확인이 없으면 `submitChallengeAnswer` API를 호출할 수 없습니다. 이러한 시나리오의 경우 {{ site.data.keys.product }} SDK는 `login` API를 다음과 같이 포함합니다. 

```js
WLAuthorizationManager.login(securityCheckName,{'username':username, 'password':password, rememberMe: rememberMeState}).then(
    function () {
        WL.Logger.debug("login onSuccess");
    },
    function (response) {
        WL.Logger.debug("login onFailure: " + JSON.stringify(response));
    });
```

신임 정보가 잘못된 경우 보안 검사는 **인증 확인**을 다시 전송합니다. 

애플리케이션의 요구사항을 기반으로 하는 `submitChallengeAnswer`와는 반대로 `login`을 언제 사용할지를 아는 것은 개발자의 책임입니다. 이를 달성하기 위한 하나의 방법은 부울 플래그 예를 들어 `isChallenged`를 정의하고 `handleChallenge`에 도달할 때 `true`를 설정하거나 그 외의 경우(실패, 성공, 초기화 등) 이를 `false`로 설정하는 것입니다. 

사용자가 **로그인** 단추를 클릭하면 사용할 API를 동적으로 선택할 수 있습니다. 

```js
if (isChallenged){
    userLoginChallengeHandler.submitChallengeAnswer({'username':username, 'password':password, rememberMe: rememberMeState});
} else {
    WLAuthorizationManager.login(securityCheckName,{'username':username, 'password':password, rememberMe: rememberMeState}).then(
//...
    );
}
```

> **참고:**
>`WLAuthorizationManager` `login()` API는 자체 `onSuccess` 및 `onFailure` 메소드를 보유하며 관련 인증 확인 핸들러의 `handleSuccess` 또는 `handleFailure` 메소드 **역시** 호출됩니다.
## 액세스 토큰 얻기
{: #obtaining-an-access-token }
이 보안 검사는 **RememberMe** 기능(`rememberMe` 부울 키로서)을 지원하므로 애플리케이션이 시작될 때 클라이언트가 현재 로그인한 상태인지 확인하는 것이 유용합니다. 

{{ site.data.keys.product }} SDK는 서버에 올바른 토큰을 요청하기 위해 `obtainAccessToken` API를 제공합니다. 

```js
WLAuthorizationManager.obtainAccessToken(userLoginChallengeHandler.securityCheckName).then(
    function (accessToken) {
        WL.Logger.debug("obtainAccessToken onSuccess");
        showProtectedDiv();
    },
    function (response) {
        WL.Logger.debug("obtainAccessToken onFailure: " + JSON.stringify(response));
        showLoginDiv();
});
```
> **참고:**
> `WLAuthorizationManager` `obtainAccessToken()` API는 자체 `onSuccess` 및 `onFailure` 메소드를 보유하며 관련 인증 확인 핸들러의 `handleSuccess` 또는 `handleFailure` 메소드 **역시** 호출됩니다.
클라이언트가 이미 로그인되어 있거나 *remembered* 상태인 경우 API가 성공을 트리거합니다. 클라이언트가 로그인되지 않은 경우 보안 검사가 인증 확인을 다시 전송합니다.

`obtainAccessToken` API는 **범위**를 가져옵니다. 범위는 **보안 검사**의 이름일 수 있습니다.

> [권한 부여 개념](../../) 학습서에서 **범위**에 대해 자세히 알아보십시오. 

## 인증된 사용자 검색
{: #retrieving-the-authenticated-user }
인증 확인 핸들러 `handleSuccess` 메소드는 매개변수로 `data`를 가집니다. 보안 검사가 `AuthenticatedUser`를 사용하는 경우 이 오브젝트는 사용자의 특성을 포함합니다. 현재 사용자를 저장하기 위해 `handleSuccess`를 사용할 수 있습니다. 

```js
userLoginChallengeHandler.handleSuccess = function(data) {
    WL.Logger.debug("handleSuccess");
    isChallenged = false;
    document.getElementById ("rememberMe").checked = false;
    document.getElementById('username').value = "";
    document.getElementById('password').value = "";
    document.getElementById("helloUser").innerHTML = "Hello, " + data.user.displayName;
    showProtectedDiv();
}
```

여기서, `data`는 `AuthenticatedUser`를 나타내는 `JSONObject`를 포함하는 `user`라는 키를 가집니다. 

```json
{
  "user": {
    "id": "john",
    "displayName": "john",
    "authenticatedAt": 1455803338008,
    "authenticatedBy": "UserLogin"
  }
}
```

## 로그아웃
{: #logout }
{{ site.data.keys.product }} SDK는 또한 특정 보안 검사에서 로그아웃하도록 `logout` API를 제공합니다.

```js
WLAuthorizationManager.logout(securityCheckName).then(
    function () {
        WL.Logger.debug("logout onSuccess");
        location.reload();
    },
    function (response) {
        WL.Logger.debug("logout onFailure: " + JSON.stringify(response));
    });
```

## 샘플 애플리케이션
{: #sample-applications }
이 학습서와 연관된 두 개의 샘플이 있습니다. 

- **PreemptiveLogin**: 선점형 `login` API를 사용하여 항상 로그인 화면으로 시작하는 애플리케이션입니다. 
- **RememberMe**: *Remember Me* 선택란이 있는 애플리케이션입니다. 사용자는 다음 번 애플리케이션을 열 때 로그인 화면을 건너뛸 수 있습니다. 

두 샘플 모두 **SecurityCheckAdapters** 어댑터 Maven 프로젝트에서 동일한 `UserLogin` 보안 검사를 사용합니다.

- SecurityCheckAdapters Maven 프로젝트를 [다운로드하려면 클릭](https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80)하십시오.   
- RememberMeCordova 프로젝트를 [다운로드하려면 클릭](https://github.com/MobileFirst-Platform-Developer-Center/RememberMeCordova/tree/release80)하십시오.   
- PreemptiveLogin Cordova 프로젝트를 [다운로드하려면 클릭](https://github.com/MobileFirst-Platform-Developer-Center/PreemptiveLoginCordova/tree/release80)하십시오. 
- RememberMe 웹 프로젝트를 [다운로드하려면 클릭](https://github.com/MobileFirst-Platform-Developer-Center/RememberMeWeb/tree/release80)하십시오. 
- PreemptiveLogin 웹 프로젝트를 [다운로드하려면 클릭](https://github.com/MobileFirst-Platform-Developer-Center/PreemptiveLoginWeb/tree/release80)하십시오. 

### 샘플 사용법
{: #sample-usage }
샘플의 README.md 파일에 있는 지시사항을 따르십시오. 앱을 위한 사용자 이름/비밀번호는 일치해야 합니다(즉, "john"/"john"). 

![샘플 애플리케이션](sample-application.png)
