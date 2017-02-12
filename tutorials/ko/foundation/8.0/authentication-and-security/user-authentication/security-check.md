---
layout: tutorial
title: UserAuthenticationSecurityCheck 클래스 구현
breadcrumb_title: 보안 검사
relevantTo: [android,ios,windows,javascript]
weight: 1
다운로드:
  - 이름: 보안 검사 다운로드
    url: https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
이 abstract 클래스는 `CredentialsValidationSecurityCheck`를 확장하고 단순 사용자 인증의 가장 일반적인 유스 케이스에 적합하도록 빌드합니다.신임 정보 유효성 검증 이외에 현재 사용자를 식별할 수 있게 허용하여 프레임워크의 다양한 파트로부터 액세스할 수 있는 **사용자 ID**를 작성합니다. 선택적으로 `UserAuthenticationSecurityCheck`는 또한 **Remember Me** 기능을 제공합니다. 

이 학습서는 사용자 이름 및 비밀번호를 요청하는 보안 검사의 예제를 사용하고 인증된 사용자를 표시하기 위해 사용자 이름을 사용합니다.

**전제조건:** [CredentialsValidationSecurityCheck](../../credentials-validation/) 학습서를 읽으십시오. 

#### 다음으로 이동:
{: #jump-to }
* [보안 검사 작성](#creating-the-security-check)
* [인증 확인 작성](#creating-the-challenge)
* [사용자 신임 정보 유효성 검증](#validating-the-user-credentials)
* [AuthenticatedUser 오브젝트 작성](#creating-the-authenticateduser-object)
* [RememberMe 기능 추가](#adding-rememberme-functionality)
* [보안 검사 구성](#configuring-the-security-check)
* [샘플 보안 검사](#sample-security-check)

## 보안 검사 작성
{: #creating-the-security-check }
[Java 어댑터를 작성](../../../adapters/creating-adapters)하고 `UserAuthenticationSecurityCheck`를 확장하는 `UserLogin`이라는 Java 클래스를 추가하십시오.

```java
public class UserLogin extends UserAuthenticationSecurityCheck {

    @Override
    protected AuthenticatedUser createUser() {
        return null;
    }

    @Override
    protected boolean validateCredentials(Map<String, Object> credentials) {
        return false;
    }

    @Override
    protected Map<String, Object> createChallenge() {
        return null;
    }
}
```

## 인증 확인 작성
{: #creating-the-challenge }
인증 확인은 [CredentialsValidationSecurityCheck 구현](../../credentials-validation/security-check/)에 설명된 내용과 정확하게 동일합니다.

```java
@Override
protected Map<String, Object> createChallenge() {
    Map challenge = new HashMap();
    challenge.put("errorMsg",errorMsg);
    challenge.put("remainingAttempts",getRemainingAttempts());
    return challenge;
}
```

## 사용자 신임 정보 유효성 검증
{: #validating-the-user-credentials }
클라이언트가 인증 확인 응답을 보낼 때, 응답은 `Map`으로 `validateCredentials`에 전달됩니다. 이 메소드를 사용하여 사용자의 로직을 구현하십시오. 메소드는 신임 정보가
올바르면 `true`를 리턴합니다. 

이 예제에서 신임 정보는 `username`과 `password`가 동일할 때 "올바른" 것으로 간주됩니다. 

```java
@Override
protected boolean validateCredentials(Map<String, Object> credentials) {
    if(credentials!=null && credentials.containsKey("username") && credentials.containsKey("password")){
        String username = credentials.get("username").toString();
        String password = credentials.get("password").toString();
        if(!username.isEmpty() && !password.isEmpty() && username.equals(password)) {
            return true;
        }
        else {
            errorMsg = "Wrong Credentials";
        }
    }
    else{
        errorMsg = "Credentials not set properly";
    }
    return false;
}
```

## AuthenticatedUser 오브젝트 작성
{: #creating-the-authenticateduser-object }
`UserAuthenticationSecurityCheck` 클래스는 어댑터의 인증 확인 핸들러 같이 사용자 코드의 여러 부분에서 현재 사용자를 검색할 수 있게 허용하여 지속적 데이터에서 현재 클라이언트(사용자, 디바이스, 애플리케이션)의 표시를 저장합니다. 사용자는 클래스 `AuthenticatedUser`의 인스턴스로 표시됩니다. 구성자는 `id`, `displayName` 및 `securityCheckName` 매개변수를 가집니다. 

이 예제에서는 `id` 및 `displayName` 매개변수 둘 다에 대해 `username`을 사용합니다. 

1. 먼저 `validateCredentials` 메소드를 수정하여 `username` 인수를 저장하십시오. 

   ```java
   private String userId, displayName;

   @Override
   protected boolean validateCredentials(Map<String, Object> credentials) {
        if(credentials!=null && credentials.containsKey("username") && credentials.containsKey("password")){
            String username = credentials.get("username").toString();
            String password = credentials.get("password").toString();
            if(!username.isEmpty() && !password.isEmpty() && username.equals(password)) {
                userId = username;
                displayName = username;
                return true;
            }
            else {
                errorMsg = "Wrong Credentials";
            }
        }
        else{
            errorMsg = "The credentials are not set properly.";
        }
        return false;
   }
   ```

2. 그런 다음 `createUser` 메소드를 대체하여 `AuthenticatedUser`의 새 인스턴스를 리턴하십시오. 

   ```java
   @Override
   protected AuthenticatedUser createUser() {
        return new AuthenticatedUser(userId, displayName, this.getName());
   }
   ```

현재 보안 검사 이름을 얻기 위해 `this.getName()`을 사용할 수 있습니다. 

`UserAuthenticationSecurityCheck`는 성공적인 `validateCredentials` 후에 사용자의 `createUser()` 구현을 호출합니다. 

### AuthenticatedUser의 속성 저장
{: #storing-attributes-in-the-authenticateduser }
`AuthenticatedUser`는 대체 생성자를 가집니다. 

```java
AuthenticatedUser(String id, String displayName, String securityCheckName, Map<String, Object> attributes);
```

이 생성자는 사용자 표시와 함께 저장할 사용자 정의 속성의 `Map`을 추가합니다. 맵은 프로파일 사진, 웹 사이트 등 추가 정보를 저장하는 데 사용될 수 있습니다. 이 정보는 클라이언트 측(인증 확인 핸들러)과 자원(자체 점검 데이터를 사용)에서 액세스 가능합니다. 

> **참고:**
>`Map` 속성은 Java 라이브러리(`String`, `int`, `Map` 등)에 번들된 유형/클래스의 오브젝트 및 사용자 정의 클래스가 **아닌** 클래스의 오브젝트만 포함할 수 있습니다. 

## RememberMe 기능 추가
{: #adding-rememberme-functionality }
기본적으로 `UserAuthenticationSecurityCheck`는 성공 상태가 지속되는 기간을 판별하기 위해 `successStateExpirationSec` 특성을 사용합니다. 이 특성은 `CredentialsValidationSecurityCheck`에서 상속됩니다.

사용자가 `successStateExpirationSec` 값을 경과하여 로그인 상태를 유지할 수 있게 하려는 경우 `UserAuthenticationSecurityCheck`가 이 기능을 추가합니다. 

`UserAuthenticationSecurityCheck`는 `rememberMeDurationSec`라는 특성을 추가합니다. 이 특성의 기본값은 `0`입니다. 즉 기본적으로 사용자는 **0초** 동안 기억되며 이는 기본적으로 기능이 사용 안함으로 설정되어 있음을 나타냅니다. 이 값을 애플리케이션에 적절한 수(일, 주, 개월...)로 변경하십시오. .

`rememberCreatedUser()` 메소드를 대체하여 기능을 관리할 수도 있는데 이 메소드는 기본적으로 `true`를 리턴합니다. 이는 기능이 기본적으로 활성화되어 있음(기간 특성을 변경한 경우)을 의미합니다. 

이 예제에서 클라이언트는 제출된 신임 정보의 일부로 `boolean` 값을 전송하여 **RememberMe** 기능을 사용/사용 안함으로 설정하도록 결정합니다. 

1. 먼저 `validateCredentials` 메소드를 수정하여 `rememberMe` 선택사항을 저장하십시오. 

   ```java
   private String userId, displayName;
   private boolean rememberMe = false;

   @Override
   protected boolean validateCredentials(Map<String, Object> credentials) {
        if(credentials!=null && credentials.containsKey("username") && credentials.containsKey("password")){
            String username = credentials.get("username").toString();
            String password = credentials.get("password").toString();
            if(!username.isEmpty() && !password.isEmpty() && username.equals(password)) {
                userId = username;
                displayName = username;

                //Optional RememberMe
                if(credentials.containsKey("rememberMe") ){
                    rememberMe = Boolean.valueOf(credentials.get("rememberMe").toString());
                }

                return true;
            }
            else {
                errorMsg = "Wrong Credentials";
            }
        }
        else{
            errorMsg = "Credentials not set properly";
        }
        return false;
   }
   ```

2. 그런 다음 `rememberCreatedUser()` 메소드를 대체하십시오. 

   ```java
   @Override
   protected boolean rememberCreatedUser() {
        return rememberMe;
   }
   ```

## 보안 검사 구성
{: #configuring-the-security-check }
**adapter.xml** 파일에서 `<securityCheckDefinition>` 요소를 추가하십시오. 

```xml
<securityCheckDefinition name="UserLogin" class="com.sample.UserLogin">
  <property name="maxAttempts" defaultValue="3" description="How many attempts are allowed."/>
  <property name="blockedStateExpirationSec" defaultValue="10" description="How long before the client can try again (seconds)."/>
  <property name="successStateExpirationSec" defaultValue="60" description="How long is a successful state valid for (seconds)."/>
  <property name="rememberMeDurationSec" defaultValue="120" description="How long is the user remembered by the RememberMe feature (seconds)."/>
</securityCheckDefinition>
```
이전에 언급한 대로 `UserAuthenticationSecurityCheck`는 `blockedStateExpirationSec`, `successStateExpirationSec` 등과 같은 모든 `CredentialsValidationSecurityCheck` 특성을 상속합니다. 또한 `rememberMeDurationSec` 특성을 구성할 수 있습니다. 

## 샘플 보안 검사
{: #sample-security-check }
보안 검사 Maven 프로젝트를 [다운로드](https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80)하십시오.  

Maven 프로젝트는 `UserAuthenticationSecurityCheck`의 구현을 포함합니다.
