---
layout: tutorial
title: 보안 검사 작성
breadcrumb_title: Creating a security check
relevantTo: [android,ios,windows,javascript]
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }

보안 검사는 {{ site.data.keys.product_adj }} 보안 프레임워크의 기본 서버 측 빌딩 블록을 구성합니다. 보안 검사는 클라이언트 신임 정보 얻기 및 유효성 검증과 같이 특정 권한 부여 로직을 구현하는 서버 측 엔티티입니다. 0개 이상의 보안 검사에 맵핑되는 범위를 지정하여 자원을 보호합니다. 보호 범위에 대한 모든 보안 검사를 통과한 클라이언트에만 자원에 대한 액세스가 부여되도록 보장합니다. 보안 검사를 사용하면
{{ site.data.keys.mf_server }}에서 호스팅되는 자원과 외부 자원 서버의 자원 둘 모두에 대한 액세스 권한을 부여할 수 있습니다.

어댑터는 또한 *자원* 어댑터(클라이언트에 전송할 자원 및 컨텐츠를 제공함을 의미), *보안 검사* 어댑터 또는 **둘 다**가 될 수 있습니다.

> <b>참고:</b> 보안 검사가 어댑터 내에서 구현되면 {{ site.data.keys.product_adj }} 보안 프레임워크 및 어댑터 API가 분리되고 혼합될 수 없습니다. 따라서, 보안 검사 코드에 `AdpatersAPI` 인터페이스와 같은 어댑터 API를 사용할 수 없고 어댑터 자원 코드에 보안 검사 API를 사용할 수 없습니다.

보안 프레임워크의 아키텍처가 모듈식이고 유연하므로 보안 검사의 구현이 특정 자원이나 애플리케이션에 고유하게 종속되지 않습니다. 동일한 보안 검사를 재사용하여 각기 다른 자원을 보호하고, 다양한 권한 부여 플로우에 여러 가지 보안 검사를 조합해서 사용할 수 있습니다. 유연성 강화를 위해서 보안 검사 클래스는 보안 검사 정의 및 {{ site.data.keys.mf_console }}의 런타임 동안 어댑터 레벨로 사용자 정의될 수 있는 구성 특성을 표시합니다.

개발 프로세스를 용이하게 하고 가속화하기 위해 {{ site.data.keys.product }}에서는 `SecurityCheck` 인터페이스의 기본 추상 구현을 제공합니다. 또한 제공된 기본 보안 검사 클래스 각각에 대한 보충적 샘플 보안 검사 구성 클래스뿐만 아니라 `SecurityCheckConfiguration` 인터페이스의 기본 abstract 구현이 제공됩니다(`SecurityCheckConfigurationBase`). 
사용자의 개발 요구사항에 최적화된 기본 보안 검사 구현(및 관련된 샘플 구성)을 사용하여 시작하고, 필요에 따라 구현을 확장 및 수정하십시오.

> [보안 검사 규약](contract)에 대해 자세히 알아보십시오.

**전제조건:**

* [권한 부여 개념](../) 학습서를 읽으십시오.
* [어댑터 작성](../../adapters/creating-adapters) 방법을 학습하십시오.

**사용법:**  
아래 설명된 보안 검사 기본 클래스는 {{ site.data.keys.product_adj }} `com.ibm.mfp.security.checks.base` Java Maven 라이브러리의 일부로 사용 가능하며 [Maven Central 저장소](http://search.maven.org/#search|ga|1|a%3A%22mfp-security-checks-base%22)에서 어댑터를 빌드하는 동안 다운로드할 수 있습니다. 오프라인으로 개발하는 중인 경우 **{{ site.data.keys.mf_console }} → 다운로드 센터 → 도구 탭 → 보안 검사**에서 다운로드할 수 있습니다.

#### 다음으로 이동:
{: #jump-to }
* [보안 검사 정의](#defining-a-security-check)
* [보안 검사 구현](#security-check-implementation)
* [보안 검사 구성](#security-check-configuration)
* [사전 정의된 보안 검사](#predefined-security-checks)
* [다음에 수행할 작업](#what-s-next)

## 보안 검사 정의
{: #defining-a-security-check }

[Java 또는 JavaScript 어댑터를 작성](../../adapters/creating-adapters/)하거나 기존 어댑터를 사용하십시오.

> Java 어댑터를 작성할 때 기본 템플리트는 어댑터가 **자원**을 제공한다고 가정합니다. 동일한 어댑터에 보안 검사와 자원을 번들할 것인지 아니면 별도 어댑터로 분리할 것인지는 개발자의 선택입니다.

기본 **자원** 구현을 제거하려면 **[AdapterName]Application.java** 및 **[AdapterName]Resource.java** 파일을 삭제하십시오. **adapter.xml**에서도 `<JAXRSApplicationClass>` 요소를 제거하십시오.

Java 어댑터의 **adapter.xml** 파일에서 `securityCheckDefinition`라는 XML 요소를 추가하십시오. 예:

```xml
<securityCheckDefinition name="sample" class="com.sample.sampleSecurityCheck">
    <property name="successStateExpirationSec" defaultValue="60"/>
    <property name="blockedStateExpirationSec" defaultValue="60"/>
    <property name="maxAttempts" defaultValue="3"/>
</securityCheckDefinition>
```

* `name` 속성은 보안 검사의 이름입니다.
* `class` 속성은 보안 검사의 구현 Java 클래스를 지정합니다. 이 클래스를 작성해야 합니다.
* 보안 검사는 `property` 요소의 목록으로 [추가 구성](#security-check-configuration)될 수 있습니다.
* 사용자 정의 특성을 정의하려면 [보안 검사 구성](#security-check-configuration)을 참조하십시오.

보안 검사 정의가 있는 어댑터를 {{ site.data.keys.mf_server }}에 성공적으로 배치한 후에는 보안 검사 및 구성 정보를 볼 수 있고 **{{ site.data.keys.mf_console }} → 어댑터 → [사용자 어댑터]**에서 런타임 구성 변경을 수행할 수도 있습니다.

* **구성 파일** 탭에서 사용자 정의 보안 검사 및 구성 가능 특성을 정의하는 `<securityCheckDefinition>` 요소를 비롯하여 어댑터 디스크립터의 서버 사본을 볼 수 있습니다. [어댑터 구성을 가져오고](../../adapters/java-adapters/#custom-properties) 이를 다른 서버로 푸시할 수도 있습니다.
* **보안 검사** 탭에서 보안 검사 정의에 제공한 모든 구성 특성 목록을 볼 수 있습니다. 특성은 구성된 `displayName` 속성의 값 또는 표시 이름이 구성되지 않은 경우 이름 속성의 값에 의해 참조됩니다. 정의에서 해당 특성의 description 속성을 설정하면 이 설명도 표시됩니다.
각 특성에 대해 `defaultValue` 속성에
구성된 값이 현재 값으로 표시됩니다. 해당 값을 변경하여 보안 검사 정의에서 가져온
기본값을 재정의할 수 있습니다. 또한 언제든지 보안 검사 정의에서 원래 기본값을
복원할 수도 있습니다.
* {{ site.data.keys.mf_console }}의 **애플리케이션** 섹션에서 애플리케이션 버전을 선택할 수도 있습니다.

## 보안 검사 구현
{: #security-check-implementation }

보안 검사에 대한 **Java 클래스**를 작성하십시오. 아래 표시된 것처럼, 구현은 제공된 기본 클래스 중 하나를 확장해야 합니다. 선택하는 상위 클래스는 사용자 정의와 단순성 사이의 밸런스를 판별합니다.

### 보안 검사
{: #security-check }
`SecurityCheck`는 Java **인터페이스**이며, 보안 검사를 나타내기 위해 최소 필수 메소드를 정의합니다.  
이는 각 시나리오를 핸들하기 위해 보안 검사를 구현하는 개발자의 단독 책임입니다.

### ExternalizableSecurityCheck
{: #externalizablesecuritycheck }
이 abstract 클래스는 보안 검사 인터페이스의 기본 버전을 구현합니다.  
이는 기타 옵션 중에서 JSON으로 외부화, 비활성 제한시간, 만기 카운트다운 등을 제공합니다.

이 클래스의 서브클래싱은 보안 검사 구현에서 많은 유연성을 남겨둡니다.

> [ExternalizableSecurityCheck](../externalizable-security-check) 학습서에서 자세히 알아보십시오.

### CredentialsValidationSecurityCheck
{: #credentialsvalidationsecurityCheck }
이 클래스는 `ExternalizableSecurityCheck`를 확장하고 사용법을 단순화하기 위해 메소드 대부분을 구현합니다. 두 개의 메소드 `validateCredentials` 및 `createChallenge`가 구현되어야 합니다. 구현은 보안 검사가 구성된 기간 동안 차단된 후 특정 간격 중 제한된 로그인 시도 수를 허용합니다. 성공적인 로그인의 경우
사용자가 요청된 자원에 액세스할 수 있는 중에 구성된 기간 동안의 보안 검사 상태는 성공적입니다.

`CredentialsValidationSecurityCheck` 클래스는 자원에 액세스 권한을 부여하기 위해 임의의 신임 정보를 유효성 검증하기 위한 단순 플로우를 위한 것입니다. 지정된 시도 횟수 후에 액세스를 차단하는 기존 제공 기능도 제공됩니다.

> [CredentialsValidationSecurityCheck](../credentials-validation/) 학습서에서 자세히 알아보십시오.

### UserAuthenticationSecurityCheck
{: #userauthenticationsecuritycheck}
이 클래스는 `CredentialsValidationSecurityCheck`을 확장하고, 따라서 해당 기능의 모두를 상속합니다. 클래스는 현재 로그인 사용자를 식별할 때 사용할 수 있는 `AuthenticatedUser` 사용자 ID 오브젝트를 작성하는 구현을 이를 추가합니다. "Remember Me" 로그인 동작을 선택적으로 사용할 수 있는 기본 제공 기능도 제공됩니다. 세 개의 메소드 `createUser`, `validateCredentials` 및 `createChallenge`를 구현해야 합니다.

> [UserAuthentication 보안 검사](../user-authentication/) 학습서에서 자세히 알아보십시오.

## 보안 검사 구성
{: #security-check-configuration }

각 보안 검사 구현 클래스는 해당 보안 검사에 사용 가능한 특성을 정의하는 `SecurityCheckConfiguration` 클래스를 사용할 수 있습니다. 각 기본 `SecurityCheck` 클래스는 일치하는 `SecurityCheckConfiguration` 클래스와 함께 사용됩니다. 기본 `SecurityCheckConfiguration` 클래스 중 하나를 확장하는 자체 구현을 작성하고 사용자 정의 보안 검사를 위해 이를 사용할 수 있습니다.

예를 들어 `UserAuthenticationSecurityCheck`의 `createConfiguration` 메소드는 `UserAuthenticationSecurityCheckConfig`의 인스턴스를 리턴합니다.

```java
public abstract class UserAuthenticationSecurityCheck extends CredentialsValidationSecurityCheck {
  @Override
  public SecurityCheckConfiguration createConfiguration(Properties properties) {
      return new UserAuthenticationSecurityCheckConfig(properties);
  }
}
```

`UserAuthenticationSecurityCheckConfig`는 `rememberMeDurationSec`라는 특성(기본값 `0`)을 활성화합니다.

```java
public class UserAuthenticationSecurityCheckConfig extends CredentialsValidationSecurityCheckConfig {

    public int rememberMeDurationSec;

    public UserAuthenticationSecurityCheckConfig(Properties properties) {
        super(properties);
        rememberMeDurationSec = getIntProperty("rememberMeDurationSec", properties, 0);
    }

}
```

<br/>
이러한 특성은 여러 레벨에서 구성될 수 있습니다.

### adapter.xml
{: #adapterxml }
Java 어댑터 **adapter.xml** 파일의 `<securityCheckDefinition>` 내부에서 하나 이상의 `<property>` 요소를 추가할 수 있습니다.  
`<property>` 요소는 다음 속성을 사용합니다.

- **name**: 구성 클래스에서 정의된 특성의 이름입니다.
- **defaultValue**: 구성 클래스에서 정의된 기본값을 대체합니다.
- **displayName**: *선택사항*, 콘솔에 표시할 사용하기 쉬운 이름입니다.
- **description**: *선택사항*, 콘솔에 표시할 설명입니다.
- **type**: *선택사항*, 특성이 특정 유형(예: `integer`, `string`, `boolean`)이거나 올바른 값의 목록(예: `type="['1','2','3']"`)인지 확인합니다.

예제:

```xml
<property name="maxAttempts" defaultValue="3" displayName="How many attempts are allowed?" type="integer"/>
```

> 실제 예제의 경우 CredentialsValidation 보안 검사 학습서의 [보안 검사 구성 절](../credentials-validation/security-check/#configuring-the-security-check)을 참조하십시오.

### {{ site.data.keys.mf_console }} - 어댑터
{: #mobilefirst-operations-console-adapter }
{{ site.data.keys.mf_console }} → **[사용자 어댑터] → 보안 검사 탭**에서 **adapter.xml** 파일에 정의된 특성 값을 변경할 수 있습니다.  
**adapter.xml** 파일에 정의된 특성**만** 화면에 표시됨을 참고하십시오. 구성 클래스에 정의된 특성은 여기에 자동으로 표시되지 않습니다.

![콘솔의 어댑터](console-adapter-security.png)

필수 구성으로 어댑터의 구성 JSON 파일을 수동으로 편집하고 변경사항을 다시 {{ site.data.keys.mf_server }}로 푸시할 수도 있습니다.

1. **명령행 창**에서 프로젝트의 루트 폴더로 이동하여 `mfpdev adapter pull`을 실행하십시오.
2. **project-folder\mobilefirst** 폴더에 있는 구성 파일을 여십시오.
3. 파일을 편집하고 `securityCheckDefinitions` 오브젝트를 찾으십시오. 이 오브젝트에서 선택한 보안 검사로 이름 지정되는 오브젝트를 찾거나 작성하십시오. 보안 검사 오브젝트 내에서 특성 오브젝트를 찾거나 추가하십시오. 구성하려는 사용 가능한 각 오브젝트에 대해 특성 오브젝트 내에서 구성 특성 이름 및 값 쌍을 추가하십시오. 예:

   ```xml
   "securityCheckDefinitions": {
        "UserAuthentication": {
            "properties": {
                "maxAttempts": "4",
                "failureExpirationSec: "90"
            }
        }
   }
   ```

4. 다음 명령 `mfpdev adapter push`를 실행하여 업데이트된 구성 JSON 파일을 배치하십시오.

### {{ site.data.keys.mf_console }} - 애플리케이션
{: #mobilefirst-operations-console-application }
특성 값은 애플리케이션 레벨에서 대체될 수 있습니다.

{{ site.data.keys.mf_console }} → **[사용자 애플리케이션] → 보안 탭**의 **보안 검사 구성** 섹션 아래에서 사용 가능한 각 보안 검사에 정의된 값을 수정할 수 있습니다.

<img class="gifplayer" alt="보안 검사 특성 구성" src="console-application-security.png"/>

필수 구성으로 어댑터의 구성 JSON 파일을 수동으로 편집하고 변경사항을 다시 {{ site.data.keys.mf_server }}로 푸시할 수도 있습니다.

1. **명령행 창**에서 프로젝트의 루트 폴더로 이동하여 `mfpdev app pull`을 실행하십시오.
2. **project-folder\mobilefirst** 폴더에 있는 구성 파일을 여십시오.
3. 파일을 편집하고 `securityCheckConfigurations` 오브젝트를 찾으십시오. 이 오브젝트에서 선택한 보안 검사로 이름 지정되는 오브젝트를 찾거나 작성하십시오. 보안 검사 오브젝트 내에서 구성하려는 사용 가능한 각 구성 특성에 대해 구성 특성 이름 및 값 쌍을 추가하십시오. 예:

   ```xml
   "SecurityCheckConfigurations": {
        "UserAuthentication": {
            "properties": {
                "maxAttempts": "2",
                "failureExpirationSec: "60"
            }
        }
   }
   ```

4. 다음 명령 `mfpdev app push`를 실행하여 업데이트된 구성 JSON 파일을 배치하십시오.

## 사전 정의된 보안 검사
{: #predefined-security-checks }

이러한 사전 정의된 보안 검사도 사용 가능합니다.

- [애플리케이션 인증](../application-authenticity/)
- [직접 업데이트](../../application-development/direct-update)
- LTPA

## 다음에 수행할 작업
{: #what-s-next }

다음 학습서에서 보안 검사에 대해 계속 읽으십시오.  
개발 또는 변경 수행을 완료한 후 어댑터를 배치할 것을 기억하십시오.

* [CredentialsValidationSecurityCheck 구현](../credentials-validation/).
* [UserAuthenticationSecurityCheck 구현](../user-authentication/).
* 추가 {{ site.data.keys.product }} [인증 및 보안 기능](../)에 대해 알아보십시오.
