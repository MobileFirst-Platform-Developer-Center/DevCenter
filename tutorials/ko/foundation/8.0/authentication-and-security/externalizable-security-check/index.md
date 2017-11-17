---
layout: tutorial
title: ExternalizableSecurityCheck 구현
breadcrumb_title: ExternalizableSecurityCheck
relevantTo: [android,ios,windows,javascript]
weight: 5
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
abstract `ExternalizableSecurityCheck` 클래스는 `SecurityCheck` 인터페이스를 구현하고 보안 검사 기능성의 두 가지 중요 측면인 외부화 및 상태 관리를 핸들합니다. 

* 외부화 - 이 클래스는 `Externalizable` 인터페이스를 구현하므로 파생된 클래스는 스스로 이를 구현할 필요가 없습니다. 
* 상태 관리 - 이 클래스는 `STATE_EXPIRED` 상태를 사전 정의하는데 이는 보안 검사가 만료되고 상태가 유지되지 않음을 의미합니다.파생된 클래스는 보안 검사에서 지원하는 다른 상태를 정의해야 합니다. 

서브클래스에 의해 구현되려면 세 개의 메소드 `initStateDurations`, `authorize` 및 `introspect`가 필요합니다. 

이 학습서는 클래스를 구현하는 방법을 설명하고 상태를 관리하는 방법을 보여줍니다.

**전제조건:** [권한 부여 개념](../) 및 [보안 검사 작성](../creating-a-security-check) 학습서를 읽으십시오. 

#### 다음으로 이동:
{: #jump-to }
* [initStateDurations 메소드](#the-initstatedurations-method)
* [authorize 메소드](#the-authorize-method)
* [introspect 메소드](#the-introspect-method)
* [AuthorizationContext 오브젝트](#the-authorizationcontext-object)
* [RegistrationContext 오브젝트](#the-registrationcontext-object)

## initStateDurations 메소드
{: #the-initstatedurations-method }
`ExternalizableSecurityCheck`는 `initStateDurations`라는 abstract 메소드를 정의합니다. 서브클래스는 보안 검사가 지원하는 모든 상태에 대해 이름과 기간을 제공하여 해당 메소드를 구현해야 합니다. 기간 값은 대게 보안 검사 구성에서 가져옵니다. 

```java
private static final String SUCCESS_STATE = "success";

protected void initStateDurations(Map<String, Integer> durations) {
    durations.put (SUCCESS_STATE, ((SecurityCheckConfig) config).successStateExpirationSec);
}
```

> 보안 검사 구성에 대한 자세한 정보는 CredentialsValidationSecurityCheck 구현 학습서의 [configurationclass 섹션](../credentials-validation/security-check/#configuration-class)을 참조하십시오.



## authorize 메소드
{: #the-authorize-method }
`SecurityCheck` 인터페이스는 `authorize`라는 메소드를 정의합니다. 이 메소드는 보안 검사의 기본 로직의 구현, 상태 관리 및 클라이언트에 응답 전송(성공, 인증 확인 또는 실패)을 책임집니다. 

다음 헬퍼 메소드를 사용하여 상태를 관리하십시오. 

```java
protected void setState(String name)
```
```java
public String getState()
```
다음 예제는 사용자가 로그인했는지 여부를 간단히 확인하고 이에 따라 성공 또는 실패를 리턴합니다.

```java
public void authorize(Set<String> scope, Map<String, Object> credentials, HttpServletRequest request, AuthorizationResponse response) {
    if (loggedIn){
        setState(SUCCESS_STATE);
        response.addSuccess(scope, getExpiresAt(), this.getName());
    } else  {
        setState(STATE_EXPIRED);
        Map <String, Object> failure = new HashMap<String, Object>();           
        failure.put("failure", "User is not logged-in");
        response.addFailure(getName(), failure);
    }
}
```

`AuthorizationResponse.addSuccess` 메소드는 성공 범위와 해당 만기를 응답 오브젝트에 추가합니다. 다음이 필요합니다. 

* 보안 검사에서 부여한 범위
* 부여된 범위의 만기.
  
`getExpiresAt` 헬퍼 메소드는 현재 상태가 만료되는 시간을 리턴하거나 현재 상태가 널이면 0을 리턴합니다. 

  ```java
  public long getExpiresAt()
  ```
   
* 보안 검사의 이름.

`AuthorizationResponse.addFailure` 메소드는 실패를 응답 오브젝트에 추가합니다. 다음이 필요합니다. 

* 보안 검사의 이름.
* 실패 `Map` 오브젝트. 

`AuthorizationResponse.addChallenge` 메소드는 인증 확인을 응답 오브젝트에 추가합니다. 다음이 필요합니다. 

* 보안 검사의 이름.
* 인증 확인 `Map` 오브젝트. 

## introspect 메소드
{: #the-introspect-method }
`SecurityCheck` 인터페이스는 `introspect`라는 메소드를 정의합니다. 이 메소드는 보안 검사가 요청된 범위를 부여하는 상태에 있음을 확인해야 합니다. 범위가 부여되면, 보안 검사는 결과 매개변수에 부여된 범위, 해당 만기 및 사용자 정의 자체 점검 데이터를 보고해야 합니다. 범위가 부여되지 않으면, 보안 검사는 아무것도 수행하지 않습니다.   
이 메소드는 보안 검사 및/또는 클라이언트 등록 레코드의 상태를 변경할 수도 있습니다. 

```java
public void introspect(Set<String> checkScope, IntrospectionResponse response) {
    if (getState().equals(SUCCESS_STATE)) {
        response.addIntrospectionData(getName(),checkScope,getExpiresAt(),null);
    }
}
```

## AuthorizationContext 오브젝트
{: #the-authorizationcontext-object }
`ExternalizableSecurityCheck` 클래스는 보안 검사에 대한 현재 클라이언트와 연관된 임시 데이터를 저장하는 데 사용되는 `AuthorizationContext authorizationContext` 오브젝트를 제공합니다.  
다음 메소드를 사용하여 데이터를 저장하고 얻으십시오. 

* 현재 클라이언트를 위해 이 보안 검사에서 설정한 인증된 사용자를 가져오십시오.

  ```java
  AuthenticatedUser getActiveUser();
  ```
  
* 이 보안 검사로 현재 클라이언트를 위한 활성 사용자를 설정하십시오. 

  ```java
  void setActiveUser(AuthenticatedUser user);
  ```

## RegistrationContext 오브젝트
{: #the-registrationcontext-object }
`ExternalizableSecurityCheck` 클래스는 현재 클라이언트와 연관된 지속적/배치 데이터를 저장하는 데 사용되는 `RegistrationContext registrationContext` 오브젝트를 제공합니다.  
다음 메소드를 사용하여 데이터를 저장하고 얻으십시오. 

* 현재 클라이언트를 위해 이 보안 검사에서 등록한 사용자를 가져오십시오.

  ```java
  AuthenticatedUser getRegisteredUser();
  ```
  
* 현재 클라이언트를 위해 지정된 사용자를 등록하십시오.

  ```java
  setRegisteredUser(AuthenticatedUser user);
  ```
  
* 현재 클라이언트의 public 지속적 속성을 가져오십시오.

  ```java
  PersistentAttributes getRegisteredPublicAttributes();
  ```
  
* 현재 클라이언트의 protected 지속적 속성을 가져오십시오.

  ```java
  PersistentAttributes getRegisteredProtectedAttributes();
  ```
  
* 지정된 검색 기준으로 모바일 클라이언트의 등록 데이터를 찾으십시오. 

  ```java
  List<ClientData> findClientRegistrationData(ClientSearchCriteria criteria);
  ```

## 샘플 애플리케이션
{: #sample-application }
`ExternalizableSecurityCheck`를 구현하는 샘플에 대해서는 [등록](../enrollment) 학습서를 참조하십시오. 
