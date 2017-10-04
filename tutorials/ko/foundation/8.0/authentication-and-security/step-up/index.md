---
layout: tutorial
title: 인증 설정
breadcrumb_title: 인증 설정n
relevantTo: [android,ios,windows,javascript]
weight: 5
downloads:
  - name: Cordova 프로젝트 다운로드
    url: https://github.com/MobileFirst-Platform-Developer-Center/StepUpCordova/tree/release80
  - name: iOS Swift 프로젝트 다운로드
    url: https://github.com/MobileFirst-Platform-Developer-Center/StepUpSwift/tree/release80
  - name: Android 프로젝트 다운로드
    url: https://github.com/MobileFirst-Platform-Developer-Center/StepUpAndroid/tree/release80
  - name: Win8 프로젝트 다운로드
    url: https://github.com/MobileFirst-Platform-Developer-Center/StepUpWin8/tree/release80
  - name: Win10 프로젝트 다운로드
    url: https://github.com/MobileFirst-Platform-Developer-Center/StepUpWin10/tree/release80
  - name: 웹 프로젝트 다운로드
    url: https://github.com/MobileFirst-Platform-Developer-Center/StepUpWeb/tree/release80
  - name: SecurityCheck Maven 프로젝트 다운로드
    url: https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
자원은 여러 보안 검사에 의해 보호될 수 있습니다. 이러한 시나리오에서 {{ site.data.keys.mf_server }}는 애플리케이션에 모든 관련된 인증 확인을 동시에 전송합니다.  

보안 검사는 또한 다른 보안 검사에 종속될 수 있습니다. 따라서 언제 인증 확인이 보내지는지를 제어할 수 있는 것이 중요합니다.   
예를 들어 이 학습서는 사용자 이름과 비밀번호로 보호되는 두 개의 자원(두 번째 자원은 추가 PIN 코드도 요구함)을 갖는 애플리케이션을 설명합니다. 

**전제조건:** 계속하기 전에 [CredentialsValidationSecurityCheck](../credentials-validation) 및 [UserAuthenticationSecurityCheck](../user-authentication) 학습서를 읽으십시오. 

#### 다음으로 이동:
{: #jump-to }
* [보안 검사 참조](#referencing-a-security-check)
* [상태 머신](#state-machine)
* [Authorize 메소드](#the-authorize-method)
* [인증 확인 핸들러](#challenge-handlers)
* [샘플 애플리케이션](#sample-applications)

## 보안 검사 참조
{: #referencing-a-security-check }
두 개의 보안 검사 `StepUpPinCode` 및 `StepUpUserLogin`을 작성하십시오. 초기 구현은 [신임 정보 유효성 검증](../credentials-validation/security-check/) 및 [사용자 인증](../user-authentication/security-check/) 학습서에 설명된 구현과 동일합니다. 

이 예제에서 `StepUpPinCode`는 `StepUpUserLogin`에 **종속됩니다**. 사용자는 `StepUpUserLogin`에 성공적으로 로그인한 후에만 PIN 코드를 입력하도록 요청받아야 합니다. 이를 위해 `StepUpPinCode`가 `StepUpUserLogin` 클래스를 **참조**할 수 있어야 합니다.  

{{ site.data.keys.product_adj }} 프레임워크는 참조를 삽입하기 위해 어노테이션을 제공합니다.   
사용자의 `StepUpPinCode` 클래스에서 클래스 레벨에 다음을 추가하십시오. 

```java
@SecurityCheckReference
private transient StepUpUserLogin userLogin;
```

> <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> **중요:** 두 보안 검사 구현 모두 동일한 어댑터 내부에 번들되어야 합니다. 이 참조를 해결하기 위해 프레임워크는 적절한 클래스를 갖는 보안 검사를 검색하고 종속적 보안 검사로 참조를 삽입합니다.   
동일한 클래스의 보안 검사가 둘 이상 있을 경우 어노테이션은 선호하는 검사의 고유 이름을 지정하는 데 사용할 수 있는 선택적인 `name` 매개변수를 가집니다. 

## 상태 머신
{: #state-machine }
`CredentialsValidationSecurityCheck`(`StepUpPinCode` 및 `StepUpUserLogin` 둘 다 포함)를 확장하는 모든 클래스는 단순 상태 머신을 상속합니다. 지정된 시점에 보안 검사는 다음 상태 중 하나일 수 있습니다. 

- `STATE_ATTEMPTING`: 인증 확인이 전송되었고 보안 검사가 클라이언트 응답을 대기 중입니다. 시도 계수는 이 상태 동안 유지보수됩니다.
- `STATE_SUCCESS`: 신임 정보가 유효성 검증되었습니다. 
- `STATE_BLOCKED`: 최대 시도 횟수에 도달했고 검사가 잠금 상태에 있습니다. 

현재 상태는 상속된 `getState()` 메소드를 사용하여 얻을 수 있습니다. 

`StepUpUserLogin`에서 convenience 메소드를 추가하여 사용자가 현재 로그인 상태인지 확인하십시오. 이 메소드는 나중에 학습서에서 사용됩니다.

```java
public boolean isLoggedIn(){
    return this.getState().equals(STATE_SUCCESS);
}
```

## Authorize 메소드
{: #the-authorize-method }
`SecurityCheck` 인터페이스는 `authorize`라는 메소드를 정의합니다. 이 메소드는 인증 확인 전송 또는 요청 유효성 검사같은 보안 검사의 기본 로직 구현을 책임집니다.   
`StepUpPinCode`가 확장하는 `CredentialsValidationSecurityCheck` 클래스는 이미 이 메소드에 대한 구현을 포함합니다. 하지만 이 경우 목표는 `authorize` 메소드의 기본 동작을 시작하기 전에 `StepUpUserLogin`의 상태를 확인하는 것입니다. 

이를 위해 `authorize` 메소드를 **대체**하십시오. 

```java
@Override
public void authorize(Set<String> scope, Map<String, Object> credentials, HttpServletRequest request, AuthorizationResponse response) {
    if(userLogin.isLoggedIn()){
        super.authorize(scope, credentials, request, response);
    }
}
```

이 구현은 `StepUpUserLogin` 참조의 현재 상태를 확인합니다. 

* 상태가 `STATE_SUCCESS`(사용자가 로그인됨)인 경우 보안 검사의 정상 플로우가 계속됩니다. 
* `StepUpUserLogin`이 다른 상태에 있으면 아무것도 수행되지 않습니다. 인증 확인이 전송되지 않으며 성공도 실패도 아닙니다. 

자원이 `StepUpPinCode` 및 `StepUpUserLogin` **둘 다**로 보호된다고 가정하여, 이 플로우는 2차 신임 정보(PIN 코드)를 프롬프트하기 전에 사용자가 로그인했는지 확인합니다. 클라이언트는 두 보안 검사가 활성화된 경우에도 동시에 두 인증 확인을 수신하지 않습니다. 

또는 자원이 `StepUpPinCode`**로만** 보호되는 경우(프레임워크가 이 보안 검사만 활성화) `StepUpUserLogin`을 수동으로 트리거하기 위해 `authorize` 구현을 변경할 수 있습니다. 

```java
@Override
public void authorize(Set<String> scope, Map<String, Object> credentials, HttpServletRequest request, AuthorizationResponse response) {
    if(userLogin.isLoggedIn()){
        //If StepUpUserLogin is successful, continue the normal processing of StepUpPinCode
        super.authorize(scope, credentials, request, response);
    } else {
        //In any other case, process StepUpUserLogin instead.
        userLogin.authorize(scope, credentials, request, response);
    }
}
```

## 현재 사용자 검색
{: #retrieve-current-user }
`StepUpPinCode` 보안 검사에서 현재 사용자의 PIN 코드를 일부 데이터베이스에서 검색할 수 있도록 해당 사용자 ID를 알고자 합니다. 

`StepUpUserLogin` 보안 검사에서 **권한 부여 컨텍스트**에서 현재 사용자를 얻기 위해 다음 메소드를 추가하십시오. 

```java
public AuthenticatedUser getUser(){
    return authorizationContext.getActiveUser();
}
```

`StepUpPinCode`에서 `userLogin.getUser()` 메소드를 사용하여 `StepUpUserLogin` 보안 검사에서 현재 사용자를 가져오고 이 특정 사용자에 대한 올바른 PIN 코드를 확인할 수 있습니다. 

```java
@Override
protected boolean validateCredentials(Map<String, Object> credentials) {
    //Get the correct PIN code from the database
    User user = userManager.getUser(userLogin.getUser().getId());

    if(credentials!=null && credentials.containsKey(PINCODE_FIELD)){
        String pinCode = credentials.get(PINCODE_FIELD).toString();

        if(pinCode.equals(user.getPinCode())){
            errorMsg = null;
            return true;
        }
        else{
            errorMsg = "Wrong credentials. Hint: " + user.getPinCode();
        }
    }
    return false;
}
```

## 인증 확인 핸들러
{: #challenge-handlers }
클라이언트 측에서, 여러 단계를 핸들하기 위한 특수 API는 없습니다. 오히려 각 인증 핸들러는 자체 인증 확인을 핸들합니다. 
이 예제에서 두 개의 별도 인증 확인 핸들러를 등록해야 합니다. `StepUpUserLogin`에서 인증 확인을 핸들하기 위한 하나와 `StepUpPincode`에서 인증 확인을 핸들하기 위한 하나입니다. 

<img alt="단계별 샘플 애플리케이션" src="sample_application.png" style="float:right"/>
## 샘플 애플리케이션
{: #sample-applications }
### 보안 검사
{: #security-check }
`StepUpUserLogin` 및 `StepUpPinCode` 보안 검사를 StepUp Maven 프로젝트 아래 SecurityChecks 프로젝트에서 사용할 수 있습니다.
보안 검사 Maven 프로젝트를 [다운로드하려면 클릭](https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80)하십시오. 

### 애플리케이션
{: #applications }
샘플 애플리케이션은 OS(Swift), Android, Windows 8.1/10, Cordova 및 웹에서 사용 가능합니다. 

* Cordova 프로젝트를 [다운로드하려면 클릭](https://github.com/MobileFirst-Platform-Developer-Center/StepUpCordova/tree/release80)하십시오. 
* iOS Swift 프로젝트를 [다운로드하려면 클릭](https://github.com/MobileFirst-Platform-Developer-Center/StepUpSwift/tree/release80)하십시오. 
* Android 프로젝트를 [다운로드하려면 클릭](https://github.com/MobileFirst-Platform-Developer-Center/StepUpAndroid/tree/release80)하십시오. 
* Windows 8.1 프로젝트를 [다운로드하려면 클릭](https://github.com/MobileFirst-Platform-Developer-Center/StepUpWin8/tree/release80)하십시오. 
* Windows 10 프로젝트를 [다운로드하려면 클릭](https://github.com/MobileFirst-Platform-Developer-Center/StepUpWin10/tree/release80)하십시오. 
* 웹 앱 프로젝트를 [다운로드하려면 클릭](https://github.com/MobileFirst-Platform-Developer-Center/StepUpWeb/tree/release80)하십시오. 

### 샘플 사용법
{: #sample-usage }
샘플의 README.md 파일에 있는 지시사항을 따르십시오. 
