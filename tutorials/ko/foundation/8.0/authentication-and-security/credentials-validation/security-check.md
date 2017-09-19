---
layout: tutorial
title: CredentialsValidationSecurityCheck 클래스 구현
breadcrumb_title: 보안 검사
relevantTo: [android,ios,windows,javascript]
weight: 1
downloads:
  - name: 보안 검사 다운로드
    url: https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
이 abstract 클래스는 `ExternalizableSecurityCheck`를 확장하고 사용법을 단순화하기 위해 메소드 대부분을 구현합니다. 두 개의 메소드 `validateCredentials` 및 `createChallenge`는 필수입니다.   
`CredentialsValidationSecurityCheck` 클래스는 자원에 대한 액세스를 허용하기 위해 임의의 신임 정보를 유효성 검증하기 위한 단순 플로우를 위한 것입니다. 지정된 시도 횟수 후에 액세스를 차단하는 기존 제공 기능도 제공됩니다. 

이 학습서는 자원을 보호하기 위해 하드 코딩된 PIN 코드의 예를 사용하고, 사용자에게 3번의 시도 횟수를 제공합니다(이 시도 횟수 뒤에는 클라이언트 애플리케이션 인스턴스가 60초 동안 차단됩니다). 

**전제조건:** [권한 부여 개념](../../) 및 [보안 검사 작성](../../creating-a-security-check) 학습서를 읽으십시오.  

#### 다음으로 이동:
{: #jump-to }
* [보안 검사 작성](#creating-the-security-check)
* [인증 확인 작성](#creating-the-challenge)
* [사용자 신임 정보 유효성 검증](#validating-the-user-credentials)
* [보안 검사 구성](#configuring-the-security-check)
* [샘플 보안 검사](#sample-security-check)

## 보안 검사 작성
{: #creating-the-security-check }
[Java 어댑터를 작성](../../../adapters/creating-adapters)하고 `CredentialsValidationSecurityCheck`를 확장하는 `PinCodeAttempts`라는 Java 클래스를 추가하십시오. 

```java
public class PinCodeAttempts extends CredentialsValidationSecurityCheck {

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
보안 검사가 트리거되면 인증 확인을 클라이언트에 전송합니다. `null`을 리턴하면 빈 인증 확인이 작성되며 이는 일부 경우에 충분할 수도 있습니다.   
선택적으로 표시할 오류 메시지 또는 클라이언트에서 사용할 수 있는 기타 다른 데이터와 같은 데이터와 함께 인증 확인을 리턴할 수 있습니다.

예를 들어 `PinCodeAttempts`는 사전 정의된 오류 메시지와 남아 있는 시도 횟수를 전송합니다.

```java
@Override
protected Map<String, Object> createChallenge() {
    Map challenge = new HashMap();
    challenge.put("errorMsg",errorMsg);
    challenge.put("remainingAttempts",getRemainingAttempts());
    return challenge;
}
```

> `errorMsg`의 구현이 샘플 애플리케이션에 포함됩니다. 

`getRemainingAttempts()`는 `CredentialsValidationSecurityCheck`에서 상속됩니다. 

## 사용자 신임 정보 유효성 검증
{: #validating-the-user-credentials }
클라이언트가 인증 확인에서 응답을 보낼 때, 응답은 `Map`으로 `validateCredentials`에 전달됩니다. 이 메소드는 사용자의 로직을 구현하고 신임 정보가 유효하면 `true`를 리턴해야 합니다. 

```java
@Override
protected boolean validateCredentials(Map<String, Object> credentials) {
    if(credentials!=null && credentials.containsKey("pin")){
        String pinCode = credentials.get("pin").toString();

        if(pinCode.equals("1234")){
            return true;
        }
        else {
            errorMsg = "The pin code is not valid.";
        }

    }
    else{
        errorMsg = "The pin code was not provided.";
    }

    //In any other case, credentials are not valid
    return false;

}
```

### Configuration 클래스
{: #configuration-class }
또한 adapter.xml 파일 및 {{ site.data.keys.mf_console }}을 사용하여 유효한 PIN 코드를 구성할 수 있습니다. 

`CredentialsValidationSecurityCheckConfig`를 확장하는 새로운 Java 클래스를 작성하십시오. 기본 구성을 상속하려면 상위 보안 검사 클래스와 일치하는 클래스를 확장하는 것이 중요합니다.

```java
public class PinCodeConfig extends CredentialsValidationSecurityCheckConfig {

    public String pinCode;

    public PinCodeConfig(Properties properties) {
        super(properties);
        pinCode = getStringProperty("pinCode", properties, "1234");
    }

}
```

이 클래스의 유일한 필수 메소드는 `Properties` 인스턴스를 핸들할 수 있는 생성자입니다. adapter.xml 파일에서 특정 특성을 검색하려면 `get[Type]Property` 메소드를 사용하십시오. 값이 발견되지 않으면, 세 번째 매개변수가 기본값(`1234`)을 정의합니다. 

또한 `addMessage` 메소드를 사용하여 오류 핸들링을 이 생성자에 추가할 수 있습니다.

```java
public PinCodeConfig(Properties properties) {
        //Make sure to load the parent properties
    super(properties);

    //Load the pinCode property
    pinCode = getStringProperty("pinCode", properties, "1234");

    //Check that the PIN code is at least 4 characters long. Triggers an error.
    if(pinCode.length() < 4) {
        addMessage(errors,"pinCode","pinCode needs to be at least 4 characters");
    }

    //Check that the PIN code is numeric. Triggers warning.
    try {
        int i = Integer.parseInt(pinCode);
    }
    catch(NumberFormatException nfe) {
        addMessage(warnings,"pinCode","PIN code contains non-numeric characters");
    }
}
```

사용자의 main 클래스( `PinCodeAttempts`)에서 구성을 로드할 수 있도록 다음 두 개의 메소드를 추가하십시오.

```java
@Override
public SecurityCheckConfiguration createConfiguration(Properties properties) {
    return new PinCodeConfig(properties);
}
@Override
protected PinCodeConfig getConfiguration() {
    return (PinCodeConfig) super.getConfiguration();
}
```

이제 기본 PIN 코드를 검색하기 위해 `getConfiguration().pinCode` 메소드를 사용할 수 있습니다.  

하드코딩된 값 대신 구성에서 PIN 코드를 사용하기 위해 `validateCredentials` 메소드를 수정할 수 있습니다. 

```java
@Override
protected boolean validateCredentials(Map<String, Object> credentials) {
    if(credentials!=null && credentials.containsKey(PINCODE_FIELD)){
        String pinCode = credentials.get(PINCODE_FIELD).toString();

        if(pinCode.equals(getConfiguration().pinCode)){
            return true;
        }
        else {
            errorMsg = "Pin code is not valid. Hint: " + getConfiguration().pinCode;
        }

    }
    else{
        errorMsg = "The pin code was not provided.";
    }

    //In any other case, credentials are not valid
    return false;

}
```

## 보안 검사 구성
{: #configuring-the-security-check }
adapter.xml에서 `<securityCheckDefinition>` 요소를 추가하십시오.

```xml
<securityCheckDefinition name="PinCodeAttempts" class="com.sample.PinCodeAttempts">
  <property name="pinCode" defaultValue="1234" description="The valid PIN code"/>
  <property name="maxAttempts" defaultValue="3" description="How many attempts are allowed"/>
  <property name="blockedStateExpirationSec" defaultValue="60" description="How long before the client can try again (seconds)"/>
  <property name="successStateExpirationSec" defaultValue="60" description="How long is a successful state valid for (seconds)"/>
</securityCheckDefinition>
```

`name` 속성은 보안 검사의 이름이어야 합니다.  `class` 매개변수를 이전에 작성한 클래스로 설정하십시오. 

`securityCheckDefinition`는 0개 이상의 `property` 요소를 포함할 수 있습니다. `pinCode` 특성은 `PinCodeConfig` 구성 클래스에 정의된 것입니다. 다른 특성은 `CredentialsValidationSecurityCheckConfig` 구성 클래스에서
상속됩니다. 

기본적으로 adapter.xml 파일에서 이러한 특성을 지정하지 않은 경우 `CredentialsValidationSecurityCheckConfig`에서 설정된 기본값을 수신합니다. 

```java
public CredentialsValidationSecurityCheckConfig(Properties properties) {
    super(properties);
    maxAttempts = getIntProperty("maxAttempts", properties, 1);
    attemptingStateExpirationSec = getIntProperty("attemptingStateExpirationSec", properties, 120);
    successStateExpirationSec = getIntProperty("successStateExpirationSec", properties, 3600);
    blockedStateExpirationSec = getIntProperty("blockedStateExpirationSec", properties, 0);
}
```
`CredentialsValidationSecurityCheckConfig` 클래스는 다음 특성을 정의합니다.

- `maxAttempts`: *실패*에 도달하기 전에 허용되는 시도 횟수입니다.
- `attemptingStateExpirationSec`: 클라이언트가 올바른 신임 정보를 제공해야 하고 시도를 계수하는 간격(초)입니다. 
- `successStateExpirationSec`: 성공적인 로그인이 보유하는 간격(초)입니다. 
- `blockedStateExpirationSec`: `maxAttempts`에 도달한 후 클라이언트가 차단되는 간격(초)입니다. 

`blockedStateExpirationSec`의 기본값이 `0`으로 설정되어 있음을 참고하십시오. 클라이언트가 올바르지 않은 신임 정보를 전송하면 "0초 후"에 다시 시도할 수 있습니다. 이는 기본적으로 "시도 횟수" 기능이 사용 안함으로 설정되어 있음을 의미합니다. 


## 샘플 보안 검사
{: #sample-security-check }
보안 검사 Maven 프로젝트를 [다운로드](https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80)하십시오.  

Maven 프로젝트는 CredentialsValidationSecurityCheck의 구현을 포함합니다.
