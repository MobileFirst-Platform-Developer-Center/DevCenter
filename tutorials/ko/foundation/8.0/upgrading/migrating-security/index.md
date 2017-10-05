---
layout: tutorial
title: 인증 및 보안 개념 마이그레이션
breadcrumb_title: 인증 개념 마이그레이션
downloads:
  - name: 마이그레이션 샘플 다운로드
    url: https://github.com/MobileFirst-Platform-Developer-Center/MigrationSample
weight: 3
---
## 개요
{: #overview }

{{ site.data.keys.product_full }} 보안 프레임워크는 보안 개발 및 관리 태스크를 개선하고 단순화하기 위해 버전 8.0에서 상당히 수정되었습니다. 이러한 변경사항에는 V7.1 보안 구성 요소 대체가 포함됩니다. V8.0에서 OAuth 보안 범위 및 보안 검사가 이전 버전의 보안 테스트, 영역 및 로그인 모듈을 대체합니다. 

이 학습서에서는 애플리케이션의 보안 코드를 V8.0으로 마이그레이션하는 데 필요한 단계를 안내합니다. 이 학습서에서는 샘플 {{ site.data.keys.product_adj }} V7.1 애플리케이션을 동일한 보안 보호를 제공하는 V8.0 애플리케이션으로 변환하는 전체 프로세스에 대해 다룹니다. 샘플 V7.1 애플리케이션과 마이그레이션된 V8.0 애플리케이션을 모두 다운로드할 수 있습니다. 이 학습서의 시작 부분에 있는 **마이그레이션 샘플 다운로드** 링크를 참조하십시오. 

이 학습서의 [첫 번째 파트](#migrating-the-sample-application)에서는 샘플 V7.1 애플리케이션을 V8.0으로 마이그레이션하는 방법에 대해 설명합니다. 여기에는 자원 어댑터 마이그레이션, 양식 기반 및 어댑터 기반 인증 영역을 보안 검사로 대체, 클라이언트 애플리케이션 및 인증 확인 핸들러 마이그레이션이 포함됩니다. <br />
[두 번째 파트](#migrating-other-types-of-authentication-realms)에서는 샘플 애플리케이션에서 다루지 않은 기타 유형의 V7.1 인증 영역을 V8.0으로 마이그레이션하는 방법에 대해 설명합니다. <br />
[세 번째 파트](#migrating-other-v71-security-configurations)에서는 V7.1 추가 보안 구성을 V8.0으로 마이그레이션하는 방법에 대해 설명합니다. 여기에는 애플리케이션 레벨 보호, 액세스 토큰 만기, 사용자 및 디바이스 ID 구성이 포함됩니다.
{% comment %} I edited and reordered, including splitting part two into two and three - which matches the header levels in the original doc. I moved the links (which I also edited) to each second-level header ("part").
{% endcomment %}

> **참고:** 마이그레이션을 시작하기 전에 [V8.0 마이그레이션 쿡북](../migration-cookbook)을 읽어 보는 것이 좋습니다.   
> 새로운 보안 프레임워크의 기본 개념에 대해 학습하려면 [인증 및 보안](../../authentication-and-security)을 참조하십시오. 

## 샘플 애플리케이션 마이그레이션
{: #migrating-the-sample-application }

이 마이그레이션 프로시저의 시작점은 샘플 V7.1 하이브리드 애플리케이션입니다. 이 애플리케이션은 V7.1 OAuth 보안 모델로 보호되는 Java 어댑터에 액세스합니다. 이 어댑터는 두 가지 메소드를 제공합니다. 
*  `getBalance` - 사용자 이름 및 비밀번호 로그인을 구현하는 양식 기반 인증 영역으로 보호됩니다. 
*  `transferMoney` - 핀 코드 기반 사용자 권한 부여를 구현하는 어댑터 기반 인증 영역으로 보호됩니다. 

이 학습서의 시작 부분에 있는 **마이그레이션 샘플 다운로드** 링크를 사용하여 V7.1 샘플 애플리케이션 및 마이그레이션된 V8.0 샘플 애플리케이션의 소스 코드를 다운로드하십시오. 

V7.1 샘플 애플리케이션을 V8.0으로 마이그레이션하려면 다음 단계를 수행하십시오. 
*  자원 보호 로직을 비롯한 [자원 어댑터 마이그레이션](#migrating-the-resource-adapter)
*  [클라이언트 애플리케이션 마이그레이션](#migrating-the-client-application)
*  인증 영역을 V8.0 보안 검사로 대체하여 샘플 V7.1 애플리케이션의 [인증 영역 마이그레이션](#migrating-rm-and-adapter-based-auth-realms)
*  클라이언트 측에서 [인증 확인 핸들러를 마이그레이션](#migrating-the-challenge-handlers)하여 새 인증 확인 핸들러 API 사용

### 자원 어댑터 마이그레이션
{: #migrating-the-resource-adapter }
먼저 자원 어댑터를 마이그레이션하십시오. V7.1에서는 어댑터가 애플리케이션 프로젝트의 일부지만, {{ site.data.keys.product }} V8.0에서는 어댑터가 별도의 Maven 프로젝트로 개발됩니다. 따라서 클라이언트 애플리케이션에 관계없이 자원 어댑터를 마이그레이션하고 마이그레이션된 어댑터를 배치할 수 있습니다. V8.0 클라이언트 애플리케이션 및 V8.0 보안 검사(어댑터 내에서 구현됨)의 경우에도 동일한 사항이 적용됩니다. 그러므로 이러한 아티팩트는 선택한 순서로 마이그레이션할 수 있습니다. 이 학습서는 V8.0 자원 보호에 사용되는 OAuth 보안 범위 요소에 대한 소개를 포함하여 자원 어댑터 마이그레이션에 대한 지시사항으로 시작됩니다. 

> **참고:** 
> *  다음은 샘플 `AccountAdapter` 자원 어댑터를 마이그레이션하기 위한 지시사항입니다. 구현되는 어댑터 기반 인증은 V8.0에서 더 이상 지원되지 않으므로 샘플 `PinCodeAdapter`를 마이그레이션할 필요가 없습니다. [핀 코드 어댑터 기반 인증 영역 대체](#replacing-the-pin-code-adapter-based-authentication-realm) 단계는 V7.1 핀 코드 어댑터를 유사한 보호를 제공하는 V8.0 보안 검사로 대체하는 방법에 대해 설명합니다.
> *  어댑터를 V8.0으로 마이그레이션하는 방법에 대한 지시사항은 [V8.0 마이그레이션 쿡북](../migration-cookbook)을 참조하십시오. 

V7.1 샘플의 `AccountAdpter` 메소드는 메소드의 보호 범위(`UserLoginRealm` 및 `PinCodeRealm`)를 정의하는 `@OAuthSecurity` 어노테이션으로 보호됩니다. V8.0에서도 동일한 어노테이션이 사용되지만, 범위 요소의 의미가 다릅니다. V7.1에서는 범위 요소가 **authenticationConfig.xml** 파일에 정의된 보안 영역을 참조합니다. V8.0에서는 범위 요소가 {{ site.data.keys.mf_server }}에 배치된 어댑터에 정의되어 있는 보안 검사에 맵핑됩니다. 범위 요소 이름을 포함한 자원 보호 코드가 변경되지 않도록 선택할 수 있습니다. 그러나 {{ site.data.keys.product }} V8.0에서는 "영역(realm)"이라는 용어가 더 이상 사용되지 않으므로, V8.0 애플리케이션의 범위 요소 이름이 `UserLogin` 및 `PinCode`로 변경되었습니다. 

```java
@OAuthSecurity(scope="UserLogin")
@OAuthSecurity(scope="PinCode")
```

#### 사용자 ID 검색 코드 업데이트
{: #updating-the-user-identity-retrieval-code }

샘플 자원 어댑터는 서버 측 보안 API를 사용하여 인증된 사용자의 ID를 얻습니다. 이 API는 V8.0에서 변경되었으므로, 업데이트된 API를 사용하도록 어댑터 코드를 수정해야 합니다. 마이그레이션된 V8.0 애플리케이션의 경우 다음 V7.1 코드를 제거하십시오. 

```java
WLServerAPI api = WLServerAPIProvider.getWLServerAPI();
api.getSecurityAPI().getSecurityContext().getUserIdentity();
```

그런 후 새 V8.0 API를 사용하는 다음 코드로 대체하십시오. 

```java
// Inject the security context
@Context
AdapterSecurityContext securityContext;

 // Get the authenticated user name
String userName = securityContext.getAuthenticatedUser().getDisplayName();
```
어댑터 코드를 편집한 후에는 Maven 또는 {{ site.data.keys.mf_cli }}를 사용하여 어댑터를 빌드하고 서버에 배치하십시오. 자세한 정보는 [어댑터 빌드 및 배치](../../adapters/creating-adapters/#build-and-deploy-adapters)를 참조하십시오.

### 클라이언트 애플리케이션 마이그레이션
{: #migrating-the-client-application }

다음으로, 클라이언트 애플리케이션을 마이그레이션하십시오. 자세한 클라이언트 애플리케이션 마이그레이션 지시사항은 [V8.0 마이그레이션 쿡북](../migration-cookbook)을 참조하십시오. 이 학습서에서는 보안 코드 마이그레이션에 대해 중점적으로 다룹니다. 이 단계에서는 인증 확인 핸들러 코드를 가져오는 행 주위에 주석을 추가하도록 애플리케이션의 기본 HTML 파일인 **index.html**을 편집하여 인증 확인 핸들러 코드를 제외시키십시오. 

```html 
<!--  
    <script src="js/UserLoginChallengeHandler.js"></script>
    <script src="js/PinCodeChallengeHandler.js"></script>
 -->
```

샘플 애플리케이션의 인증 확인 핸들러 코드는 뒤에 나오는 [인증 확인 핸들러 마이그레이션](#migrating-the-challenge-handlers) 단계에서 수정됩니다. 

#### 클라이언트 측 API 호출 업데이트
{: #updating-the-client-side-api-calls }

클라이언트 마이그레이션의 일부로 V8.0 클라이언트 측 API 변경사항을 처리해야 합니다. {{ site.data.keys.product }} V8.0 클라이언트 API 변경사항 목록은 [WebView 업그레이드](../migrating-client-applications/cordova/#upgrading-the-webview)를 참조하십시오. 
샘플 애플리케이션에는 보안과 관련된 클라이언트 API 변경사항이 한 개 있는데, 이것은 로그아웃 API입니다. V7.1 `WL.Client.logout` 메소드는 V8.0에서 지원되지 않습니다. 대신 V8.0 `WLAuthorizationManager.logout`을 사용하고, 7.1 권한 영역을 대체하는 보안 검사의 이름을 전달하십시오. 샘플 애플리케이션의 **로그아웃** 단추를 사용하면 `UserLogin` 및 `PinCode` 보안 검사에서 사용자가 로그아웃됩니다. 

```javascript
function logout() {
    WLAuthorizationManager.logout('UserLogin').then(
        function () {
            WLAuthorizationManager.logout('PinCode').then(function () {
                $("#ResponseDiv").html("Logged out");
            }, function (error) {
                WL.Logger.debug("failure on logout from PinCode check: " +
                    JSON.stringify(error));
            });
      },
      function (error) {
          WL.Logger.debug("failure on logout from UserLogin check: " +
              JSON.stringify(error));
      });
}
```

클라이언트 애플리케이션 마이그레이션 단계를 완료했으면 애플리케이션을 빌드한 다음 `mfpdev app register` 명령을 사용하여 {{ site.data.keys.mf_server }}에 애플리케이션을 등록하십시오. 애플리케이션이 성공적으로 등록되면 {{ site.data.keys.mf_console }} 탐색 사이드바의 **애플리케이션** 섹션에 표시됩니다. 

### 샘플 애플리케이션의 인증 영역 마이그레이션
{: #migrating-rm-and-adapter-based-auth-realms }

이 단계에는 마이그레이션된 V8.0 클라이언트 애플리케이션과 배치된 자원 어댑터가 이미 있습니다. 그러나 마이그레이션된 애플리케이션은 보호된 어댑터 자원에 액세스할 수 없습니다. 그 이유는 자원 어댑터 메소드가 아직 보안 검사에 맵핑되지 않은 `UserLogin` 및 `PinCode` 범위 요소에 의해 보호되기 때문입니다. 그러므로 애플리케이션이 보호된 메소드에 액세스하는 데 필요한 액세스 토큰을 얻을 수 없습니다. 이를 해결하려면 V7.1 인증 영역을 어댑터 메소드의 보호 범위 요소에 맵핑되는 V8.0 보안 검사로 대체해야 합니다. 

#### 사용자 로그인 양식 기반 인증 영역 대체
{: #replacing-the-user-login-form-based-authentication-realm }

V7.1 `UserLoginRealm` 양식 기반 인증 영역을 대체하려면 V7.1 양식 기반 인증자 및 사용자 정의 로그인 모듈과 동일한 인증 단계를 수행하는 V8.0 `UserLogin` 보안 검사를 작성하십시오. 보안 검사는 인증 확인을 클라이언트로 보내고 인증 확인 응답에서 로그인 신임 정보를 수집하며 신임 정보의 유효성을 검증하고 사용자 ID를 작성합니다. 다음 지시사항에 설명된 바와 같이, 보안 검사 작성은 복잡하지 않습니다. 보안 검사를 작성한 후에는 로그인 신임 정보의 유효성을 검증하는 코드를 V7.1 사용자 정의 모듈에서 새 보안 검사로 복사할 수 있습니다. 

V8.0에서 보안 검사는 어댑터로 구현됩니다. {{ site.data.keys.product }} V8.0에서 Java 어댑터는 자원 및 패키지 보안 테스트를 모두 제공할 수 있습니다. 그러나 이 마이그레이션 프로시저에서는 마이그레이션된 `AccountAdpter` 자원 어댑터를 유지보수하고 새로운 보안 검사를 패키징하기 위한 별도의 어댑터를 작성합니다. 그러므로 먼저 `UserLogin`이라는 새 Java 어댑터를 작성하십시오. 자세한 지시사항은 [새 Java 어댑터 작성](../../adapters/creating-adapters)을 참조하십시오. 

새 `UserLogin` 어댑터에서 `UserLogin` 보안 검사를 정의하려면 다음 코드에 표시된 것과 같이, &lt;securityCheckDefinition&gt; XML 요소를 어댑터의 **adapter.xml** 파일에 추가하십시오. 

```xml
<securityCheckDefinition name="UserLogin" class="com.sample.UserLogin">
     <property name="successStateExpirationSec" defaultValue="3600"/>
</securityCheckDefinition>
```

* `name` 속성은 보안 검사의 이름을 지정합니다("UserLogin"). 
* `class` 속성은 보안 검사 구현의 Java 클래스를 지정합니다("com.sample.UserLogin"). 이 클래스는 [다음 단계](#creating-the-user-login-security-check-java-class)에서 작성됩니다. 
* `successStateExpirationSec` 특성은 V7.1 로그인 모듈의 `expirationInSeconds` 특성과 동등합니다. 보안 검사 성공 상태의 만기 기간, 즉 성공한 보안 검사 로그인의 유효 기간(초)을 나타냅니다. 이 V7.1 및 V8.0 특성의 기본값은 3600초입니다. V7.1 로그인 모듈에서 다른 만기 기간을 구성한 경우 V8.0 `successStateExpirationSec` 특성의 값을 편집하여 동일한 값으로 설정하십시오. 

이 학습서에서는 `successStateExpirationSec` 특성을 정의하는 방법에 대해서만 설명하지만, 보안 검사로 더 많은 작업을 수행할 수 있습니다. 예를 들어 차단된 상태 만기, 다중 로그인 시도 또는 "기억하기" 로그인 등의 고급 기능을 구현할 수 있습니다. {{ site.data.keys.mf_console }} 또는 {{ site.data.keys.mf_cli }}(**mfpdev**)를 통해 런타임 시 구성 특성의 기본값을 변경하고, 사용자 정의 특성을 추가하며, 특성 값을 수정할 수 있습니다. 자세한 정보는 [V8.0 보안 검사 문서](../../authentication-and-security/creating-a-security-check/) 및 특히 [보안 검사 구성](../../authentication-and-security/creating-a-security-check/#security-check-configuration)을 참조하십시오. 

##### 사용자 로그인 보안 검사 Java 클래스 작성
{: #creating-the-user-login-security-check-java-class }

`UserLogin` 어댑터에서 `UserLogin` Java 클래스를 작성하십시오. 이 클래스는 {{ site.data.keys.product_adj }} `UserAuthenticationSecurityCheck` abstract 기본 클래스를 확장한 다음 {{ site.data.keys.product_adj }}  `CredentialsValidationSecurityCheck` abstract 기본 클래스를 확장합니다. 다음으로, `createChallenge`, `validateCredentials` 및 `createUser` 기본 클래스 메소드의 기본 구현을 대체하십시오. 

*  `createChallenge` 메소드는 클라이언트로 전송할 인증 확인 오브젝트(해시 맵)를 작성합니다. 인증 확인 구문이나 클라이언트 응답의 유효성을 검증하는 데 사용할 다른 유형의 인증 확인 오브젝트를 포함하도록 이 메소드의 구현을 수정할 수 있습니다. 그러나 샘플 애플리케이션의 경우 오류 발생 시 표시할 오류 메시지를 인증 확인 오브젝트에 추가하기만 하면 됩니다. 
*  `validateCredentials` 메소드에는 인증 로직이 포함되어 있습니다. 사용자 이름과 비밀번호의 유효성을 검증하는 인증 코드를 V7.1 로그인 모듈에서 이 V8.0 메소드로 복사하십시오. 샘플은 비밀번호가 사용자 이름과 동일한지 확인하는 기본 유효성 검증 로직을 구현합니다. 
*  `createUser` 메소드는 V7.1 로그인 모듈의 `createIdentity` 메소드와 동등합니다. 

전체 클래스 구현 코드는 다음과 같습니다. 

```java
public class UserLogin extends UserAuthenticationSecurityCheck {
    private String userId, displayName;
    private String errorMsg;

    @Override
    protected boolean validateCredentials(Map<String, Object> credentials) {
        if (credentials!=null &&  credentials.containsKey("username") &&

		credentials.containsKey("password")){
            String username = credentials.get("username").toString();
            String password = credentials.get("password").toString();

            // the authentication logic, copied from the V7.1 login module
            if (!username.isEmpty() &&  !password.isEmpty() &&  username.equals(password)) {
                userId = username;
                displayName = username;

                errorMsg = null;
                return true;
            } else {
                errorMsg = "Wrong Credentials";
            }
        } else {
            errorMsg = "Credentials not set properly";
        }
        return false;
    }

    @Override
    protected Map<String, Object> createChallenge() {
        Map challenge = new HashMap();
        challenge.put("errorMsg", errorMsg);
        return challenge;
    }

    @Override
    protected AuthenticatedUser createUser() {
        return new AuthenticatedUser(userId, displayName, this.getName());
    }
}
```

`UserAuthenticationSecurityCheck` 클래스 및 해당 클래스 구현에 대한 자세한 정보는 [UserAuthenticationSecurityCheck 클래스 구현](../../authentication-and-security/user-authentication/security-check/)을 참조하십시오. 


변경을 완료하려면 Maven 또는 {{ site.data.keys.mf_cli }}를 사용하여 `UserLogin` 어댑터를 빌드하고 서버에 배치하십시오. 자세한 정보는 [어댑터 빌드 및 배치](../../adapters/creating-adapters/#build-and-deploy-adapters)를 참조하십시오. 애플리케이션이 성공적으로 배치되면 {{ site.data.keys.mf_console }} 탐색 사이드바의 **어댑터** 섹션에 표시됩니다. 

#### 핀 코드 어댑터 기반 인증 영역 대체
{: #replacing-the-pin-code-adapter-based-authentication-realm }

V7.1 샘플 애플리케이션의 `PinCodeRealm` 영역은 V8.0에서 더 이상 지원되지 않는 어댑터 기반 인증을 사용하여 구현되었습니다. 이 영역을 대신하여, 새로운 `PinCode` Java 어댑터를 작성한 다음 {{ site.data.keys.product_adj }} `CredentialsValidationSecurityCheck` abstract 기본 클래스를 확장하는 `PinCode` Java 클래스에 추가하십시오. 

**참고:**
*  `PinCode` 어댑터를 작성하는 단계는 [사용자 로그인 양식 기반 인증 영역 대체](#replacing-the-user-login-form-based-authentication-realm) 단계에 설명된 `UserLogin` 어댑터 작성 단계와 유사합니다. 
*  `PinCode` 보안 검사는 로그인 신임 정보(핀 코드)의 유효성만 검증해야 하며, 사용자 ID는 지정하지 않아도 됩니다. 그러므로 이 보안 검사 클래스는 `UserLogin` 보안 검사에 사용되는 `UserAuthenticationSecurityCheck` 클래스가 아닌 `CredentialsValidationSecurityCheck` 기본 클래스를 확장합니다. 

`CredentialsValidationSecurityCheck` 기본 클래스를 확장하는 보안 검사를 작성하려면 `createChallenge` 및 `validateCredentials` 메소드를 구현해야 합니다. 

*  `createChallenge` 구현은 `UserLogin` 보안 검사와 유사합니다. `PinCode` 보안 검사에는 인증 확인의 일부로 클라이언트로 전송할 특수 정보가 없습니다. 그러므로 오류 발생 시 표시할 오류 메시지를 인증 확인 오브젝트에 추가하기만 하면 됩니다. 

   ```java
@Override
    protected Map<String, Object> createChallenge() {
        Map challenge = new HashMap();
        challenge.put("errorMsg",errorMsg);
        return challenge;
    }
```

*  `validateCredentials` 메소드는 핀 코드를 유효성 검증합니다. 다음 예에서는 유효성 검증 코드가 한 행으로 구성되어 있지만, V7.1 인증 어댑터의 유효성 검증 코드를 이 `validateCredentials` 메소드로 복사할 수도 있습니다. 

   ```java
   @Override
   protected boolean validateCredentials(Map<String, Object> credentials) {
       if (credentials!=null && credentials.containsKey("pin")){
           String pinCode = credentials.get("pin").toString();
           if (pinCode.equals("1234")) {
               return true;
           } else {
               errorMsg = "Pin code is not valid.";
           }
       } else {
           errorMsg = "Pin code was not provided";
       }
       return false;
   }
   ```

V7.1 인증 영역을 보안 검사로 마이그레이션했으면 어댑터를 빌드하고 {{ site.data.keys.mf_server }}로 배치하십시오. 자세한 정보는 [어댑터 빌드 및 배치](../../adapters/creating-adapters/#build-and-deploy-adapters)를 참조하십시오. 

### 인증 확인 핸들러 마이그레이션
{: #migrating-the-challenge-handlers }

이 단계에서는 이미 샘플 자원 어댑터와 클라이언트 애플리케이션을 마이그레이션하고 V7.1 인증 영역을 V8.0 보안 검사로 대체했습니다. 샘플 애플리케이션의 보안 마이그레이션을 완료하기 위해서는 클라이언트 애플리케이션의 인증 확인 핸들러를 마이그레이션하기만 하면 됩니다. 클라이언트 애플리케이션은 인증 확인 핸들러를 사용하여 보안 인증 확인에 응답하고 사용자로부터 수신한 신임 정보를 보안 검사로 전송합니다. 

[클라이언트 애플리케이션을 마이그레이션](#migrating-the-client-application)할 때 애플리케이션의 기본 HTML 파일인 **index.html**에서 관련 행을 주석 처리하여 인증 확인 핸들러 코드를 제외시켰습니다. 이제 이러한 행 주위에 추가한 주석을 제거하여 애플리케이션의 인증 확인 핸들러를 다시 추가하십시오. 

```html 
    <script src="js/UserLoginChallengeHandler.js"></script>
    <script src="js/PinCodeChallengeHandler.js"></script>
```

그런 후 다음 지시사항에 설명된 대로, 인증 확인 핸들러 코드를 V8.0으로 마이그레이션하십시오. V8.0 인증 확인 핸들러 API에 대한 자세한 정보는 [{{ site.data.keys.product }} 8.0의 Challenge Handlers 빠른 검토]({{ site.baseurl }}/blog/2016/06/22/challenge-handlers/) 및 V8.0 [JavaScript 클라이언트 측 API 참조](../../api/client-side-api/javascript/client/)의 `WL.Client` 및 `WL.Client.AbstractChallengeHandler` 문서를 참조하십시오. 

먼저, V8.0에서도 V7.1에서와 동일한 기능을 수행하는 사용자 로그인 인증 확인 핸들러(`userLoginChallengeHandler`)를 사용하십시오. 이 인증 확인 핸들러는 인증 확인을 수신할 때 사용자에게 로그인 양식을 제공하고 사용자 이름과 비밀번호를 {{ site.data.keys.mf_server }}로 전송합니다. 그러나 V8.0의 클라이언트 인증 확인 핸들러 API는 V7.1과 다르고 더 단순하므로 다음과 같이 변경해야 합니다. 

*  인증 확인 핸들러를 작성하는 코드를 V8.0 `WL.Client.createSecurityCheckChallengeHandler` 메소드를 호출하는 다음 코드로 대체하십시오. 

   ```javascript
var userLoginChallengeHandler = WL.Client.createSecurityCheckChallengeHandler('UserLogin');

    ```
   
   `WL.Client.createSecurityCheckChallengeHandler`는 {{ site.data.keys.product_adj }} 보안 검사에서 보낸 인증 확인을 처리하는 인증 확인 핸들러를 작성합니다. V8.0에서는 또한 써드파티 게이트웨이에서 보낸 인증 확인을 처리하는 `WL.Client.createGatewayChallengeHandler` 메소드도 도입했는데, V8.0에서는 이를 게이트웨이 인증 확인 핸들러라고 합니다. V7.1 애플리케이션을 V8.0으로 마이그레이션할 경우 `WL.Client` `createWLChallengeHandler` 또는 `createChallengeHandler` 메소드에 대한 호출을 예상 인증 확인 소스와 일치하는 V8.0 `WL.Client` 인증 확인 핸들러 작성 메소드로 대체하십시오. 예를 들어 사용자의 자원이 사용자 정의 로그인 양식을 클라이언트로 보내는 DataPower 리버스 프록시의 보호를 받는 경우, `createGatewayChallengeHandler`를 사용하여 게이트웨이 인증 확인을 처리하는 게이트웨이 인증 확인 핸들러를 작성하십시오. 

*  인증 확인 핸들러 `isCustomResponse` 메소드에 대한 호출을 제거하십시오. V8.0에서는 보안 인증 확인을 처리하는 데 이 메소드가 더 이상 필요하지 않습니다. 
*  `userLoginChallengeHandler.handleChallenge` 메소드의 구현을 V8.0 인증 확인 핸들러 `handleChallenge`, `handleSuccess` 및 `handleFailure` 메소드의 구현으로 대체하십시오. V7.1에서는 응답을 검사하여 응답에 인증 확인이 포함되어 있는지 또는 응답이 성공 또는 오류를 리턴하는지 여부를 판별하는 하나의 인증 확인 핸들러 메소드를 제공합니다. V8.0에서는 인증 확인 핸들러 응답의 유형마다 별도의 메소드를 제공하며, 보안 프레임워크가 응답 유형을 판별하고 적절한 메소드를 호출합니다. 
*  `submitSuccess` 메소드에 대한 호출을 제거하십시오. V8.0 보안 프레임워크가 성공 응답을 내재적으로 처리합니다. 
*  `submitFailure` 메소드에 대한 호출을 V8.0 `cancel` 인증 확인 핸들러 메소드에 대한 호출로 대체하십시오. 
*  `submitLoginForm` 메소드에 대한 호출을 V8.0 `submitChallengeAnswer` 인증 확인 핸들러 메소드에 대한 호출로 대체하십시오: 

   ```javascript
   userLoginChallengeHandler.submitChallengeAnswer({'username':username, 'password':password})
   ```
   
이러한 변경사항을 적용한 후 인증 확인 핸들러의 전체 코드는 다음과 같습니다. 
   
```javascript
function createUserLoginChallengeHandler() {
    var userLoginChallengeHandler = WL.Client.createSecurityCheckChallengeHandler('UserLogin');

    userLoginChallengeHandler.handleChallenge = function(challenge) {
        showLoginDiv();
        var statusMsg = (challenge.errorMsg !== null) ? challenge.errorMsg : "";
        $("#loginErrorMessage").html(statusMsg);
    };

    userLoginChallengeHandler.handleSuccess = function(data) {
        hideLoginDiv();
    };

    userLoginChallengeHandler.handleFailure = function(error) {
        if (error.failure !== null) {
            alert(error.failure);
        } else {
            alert("Failed to login.");
        }
    };

    $('#AuthSubmitButton').bind('click', function () {
        var username = $('#AuthUsername').val();
        var password = $('#AuthPassword').val();
        if (username === "" || password === "") {
            alert("Username and password are required");
            return;
        }

        userLoginChallengeHandler.submitChallengeAnswer(
            {'username':username, 'password':password});});

    $('#AuthCancelButton').bind('click', function () {
        userLoginChallengeHandler.cancel();
        hideLoginDiv();
    });

    return userLoginChallengeHandler;
}
```

핀 코드 인증 확인 핸들러(`pinCodeChallengeHandler`)의 마이그레이션은 사용자 로그인 인증 확인 핸들러의 마이그레이션과 유사합니다. 그러므로 `userLoginChallengeHandler` 마이그레이션 지시사항에 따라 핀 코드 인증 확인 핸들러에 필요한 사항을 조정하십시오. 마이그레이션된 핀 코드 인증 확인 핸들러의 전체 코드는 샘플 V8.0 애플리케이션에서 참조하십시오. 

샘플 V7.0 애플리케이션을 V8.0으로 마이그레이션하는 작업이 완료되었습니다. 애플리케이션을 다시 빌드하고 {{ site.data.keys.mf_server }}에 배치하여 테스트한 다음 어댑터 메소드 자원에 대한 액세스가 예상대로 보호되는지 확인하십시오. 

## 다른 유형의 인증 영역 마이그레이션
{: #migrating-other-types-of-authentication-realms }

지금까지 샘플 V7.1 애플리케이션의 일부인 양식 기반 및 어댑터 기반 영역을 마이그레이션하는 방법에 대해 학습했습니다. 그러나 애플리케이션 보안 테스트(`mobileSecurityTest`, `webSecurityTest` 또는 `customSecurityTest`)의 일부인 영역을 비롯한 다른 유형의 인증 영역이 V7.1 애플리케이션에 포함될 수 있습니다. 다음 절에서는 이러한 추가 유형의 인증 영역을 V8.0으로 마이그레이션하는 방법에 대해 설명합니다. 

*  [애플리케이션 인증](#application-authenticity)
*  [LTPA 영역](#ltpa-realm)
*  [디바이스 프로비저닝](#device-provisioning)
*  [교차 사이트 요청 위조 방지(anti-XSRF) 영역
](#anti-cross-site-request-forgery-anti-xsrf-realm)
*  [직접 업데이트 영역](#direct-update-realm)
*  [원격 사용 안함 영역](#remote-disable-realm)
*  [사용자 정의 인증자 및 로그인 모듈](#custom-authenticators-and-login-modules)

### 애플리케이션 인증
{: #application-authenticity }

{{ site.data.keys.product }} V8.0에서는 애플리케이션 인증 유효성 검증이 사전 정의된 보안 검사인 `appAuthenticity`로 제공됩니다. 기본적으로 이 보안 검사는 {{ site.data.keys.mf_server }}에서 애플리케이션 런타임을 등록할 때 실행되며, 애플리케이션 인스턴스가 서버에 처음 연결하려고 시도할 때 발생합니다. 그러나 모든 {{ site.data.keys.product_adj }} 보안 검사와 마찬가지로 사용자 정의 보안 범위에 이 사전 정의된 검사를 포함시킬 수 있습니다. 자세한 정보는 [애플리케이션 인증](../../authentication-and-security/application-authenticity/)을 참조하십시오. 

### LTPA 영역
{: #ltpa-realm }

V7.1 LTPA 영역을 대체하려면 {{ site.data.keys.product }} V8.0의 사전 정의된 LTPA 기반 SSO 보안 검사V8.0인 `LtpaBasedSSO`를 사용하십시오. 이 보안 검사에 대한 자세한 정보는 [LTPA 기반 SSO(싱글 사인온) 보안 검사](../../authentication-and-security/ltpa-security-check/)를 참조하십시오. 

### 디바이스 프로비저닝
{: #device-provisioning }

V7.1 디바이스 프로비저닝 영역(`wl_deviceAutoProvisioningRealm`)은 V8.0으로 마이그레이션할 필요가 없습니다. {{ site.data.keys.product }} V8.0 클라이언트 등록 프로세스가 V7.1 디바이스 프로비저닝을 대체합니다. V8.0에서 클라이언트(애플리케이션 인스턴스)는 서버에 처음 액세스하려고 시도할 때 자신을 {{ site.data.keys.mf_server }}에 등록합니다. 등록의 일부로 클라이언트는 자신의 ID를 인증하는 데 사용할 공개 키를 제공합니다. 이 보호 메커니즘은 항상 사용되므로, 보안 검사가 V7.1 디바이스 프로비저닝 영역을 대체할 필요가 없습니다. 

### 교차 사이트 요청 위조 방지(anti-XSRF) 영역
{: #anti-cross-site-request-forgery-anti-xsrf-realm }

V7.1 교차 사이트 요청 위조 방지(anti-XSRF) 영역(`wl_antiXSRFRealm`)은 V8.0으로 마이그레이션할 필요가 없습니다. V7.1.0에서는 인증 컨텍스트가 HTTP 세션에 저장되고 브라우저를 통해 교차 사이트 요청으로 전송되는 세션 쿠키로 식별됩니다. 이 버전의 anti-XSRF 영역은 클라이언트에서 서버로 전송되는 추가 헤더를 사용하여 XSRF 공격으로부터 쿠키 전송을 보호하는 데 사용됩니다. {{ site.data.keys.product }} V8.0에서는 보안 컨텍스트가 더 이상 HTTP 세션과 연관되지 않고 세션 쿠키로 식별되지도 않습니다. 대신, 권한 부여 헤더에 전달되는 OAuth 2.0 액세스 토큰을 사용하여 권한 부여가 수행됩니다. 권한 부여 헤더는 브라우저를 통해 교차 사이트 요청으로 전송되지 않으므로 XSRF 공격으로부터 보호할 필요가 없습니다. 

### 직접 업데이트 영역
{: #direct-update-realm }

V7.1 원격 사용 안함 영역(`wl_directUpdateRealm`)은 V8.0으로 마이그레이션할 필요가 없습니다. 직접 업데이트 기능의 {{ site.data.keys.product }} V8.0 구현의 경우 V7.1의 영역 요구사항과 달리, 관련 보안 검사가 필요하지 않습니다.  

**참고:** 직접 업데이트를 통해 업데이트를 제공하는 V8.0 단계는 V7.1 프로시저와 다릅니다. 자세한 정보는 [직접 업데이트 마이그레이션](../migrating-client-applications/cordova/#migrating-direct-update)을 참조하십시오. 

### 원격 사용 안함 영역
{: #remote-disable-realm }

V7.1 원격 사용 안함 영역(`wl_remoteDisableRealm`)은 V8.0으로 마이그레이션할 필요가 없습니다. 원격 사용 안함 기능의 {{ site.data.keys.product }} V8.0 구현의 경우 V7.1의 영역 요구사항과 달리, 관련 보안 검사가 필요하지 않습니다. V8.0의 원격 사용 안함 기능에 대한 정보는 [보호된 자원에 대한 애플리케이션 액세스를 사용 안함으로 원격 설정](../../administering-apps/using-console/#remotely-disabling-application-access-to-protected-resources)을 참조하십시오. 

### 사용자 정의 인증자 및 로그인 모듈
{: #custom-authenticators-and-login-modules }

사용자 정의 V7.1 인증자 및 로그인 모듈을 대체하려면 [사용자 로그인 보안 검사 Java 클래스 작성](#creating-the-user-login-security-check-java-class) 샘플 애플리케이션 마이그레이션 단계의 지시사항에 따라 새 보안 검사를 작성하십시오. 보안 검사를 통해 `UserAuthenticationSecurityCheck` 또는 `CredentialsValidationSecurityCheck` {{ site.data.keys.product }} V8.0 기본 클래스를 확장할 수 있습니다. V7.1 인증자 클래스 또는 로그인 모듈 클래스를 직접 마이그레이션할 수는 없지만, 관련 코드 조각을 보안 검사로 복사할 수 있습니다. 여기에는 보안 인증 확인을 생성하거나, 인증 확인 응답에서 로그인 신임 정보를 추출하거나, 신임 정보의 유효성을 검증하는 코드가 포함됩니다. 

## 기타 V7.1 보안 구성 마이그레이션
{: #migrating-other-v71-security-configurations }

*  [애플리케이션 보안 테스트](#the-application-security-test)
*  [액세스 토큰 만기](#access-token-expiration)
*  [사용자 ID 영역](#user-identity-realm)
*  [디바이스 ID 영역](#device-identity-realm)

### 애플리케이션 보안 테스트
{: #the-application-security-test }

V7.1에서 애플리케이션 디스크립터(**application-descriptor.xml**)는 특정 애플리케이션 자원에 적용되는 보호 이외에도 전체 애플리케이션 환경에 적용되는 애플리케이션 보안 테스트를 정의할 수 있습니다. 애플리케이션 디스크립터가 보안 테스트를 명시적으로 정의하지 않을 때 적용되는 기본 V7.1 모바일 애플리케이션 보안 테스트(샘플 V7.1 애플리케이션에 있음)는 `mobileSecurityTest`입니다. 이 보안 테스트는 V8.0에서 무관한 영역(anti-XSRF) 또는 명시적 마이그레이션이 필요하지 않은 영역(직접 업데이트, 원격 사용 안함)으로 구성됩니다. 그러므로 샘플 애플리케이션의 애플리케이션 환경 보호에는 특정 마이그레이션이 필요하지 않습니다. 

V8.0으로 마이그레이션한 후 애플리케이션 레벨에서 유지할 검사(영역)를 포함한 애플리케이션 보안 테스트가 V7.1 애플리케이션에 있는 경우, 필수 애플리케이션 범위를 구성할 수 있습니다. V8.0에서 보호된 자원에 액세스하려면 필수 애플리케이션 범위에 맵핑되는 보안 검사와 자원의 보호 범위에 맵핑되는 검사를 모두 전달해야 합니다. 필수 애플리케이션 범위를 정의하려면 V8.0 {{ site.data.keys.mf_console }}의 경우 탐색 사이드바의 **애플리케이션** 섹션에서 애플리케이션을 선택한 다음 **보안** 탭을 선택하십시오. **필수 애플리케이션 범위**에서 **범위에 추가**를 선택하십시오. 사전 정의되거나 사용자 정의된 보안 검사 또는 맵핑된 범위 요소를 애플리케이션 범위에 포함시킬 수 있습니다. V8.0에서 필수 애플리케이션 범위 구성에 대한 자세한 정보는 [필수 애플리케이션 범위](../..//authentication-and-security/#mandatory-application-scope)를 참조하십시오. 

### 액세스 토큰 만기
{: #access-token-expiration }

V7.1과 V8.0 모두에서 최대 액세스 토큰 만기 기간의 기본값은 3600초입니다. 그러므로 V7.1 애플리케이션이 이 기본값을 사용할 경우 해당 값을 V8.0에도 적용하기 위해 마이그레이션 작업을 수행할 필요가 없습니다. 그러나 V7.1 애플리케이션 디스크립터 파일(**application-descriptor.xml**)에 `accessTokenExpiration` 특성에 대해 다른 값이 설정된 경우에는 해당 V8.0 특성(`maxTokenExpiration`)에 대해서도 동일한 값을 구성할 수 있습니다. {{ site.data.keys.mf_console }}에서 이 작업을 수행하려면 애플리케이션의 **보안** 탭으로 이동한 다음 **토큰 구성** 섹션에서 **최대 토큰-만기(초)** 필드의 기본값을 편집하십시오. 애플리케이션의 **구성 파일** 콘솔 탭을 선택하면 `maxTokenExpiration` 특성의 값이 사용자의 구성 값으로 설정되어 있음을 확인할 수 있습니다. 

### 사용자 ID 영역
{: #user-identity-realm }

V7.1에서는 인증 영역을 사용자 ID 영역으로 구성할 수 있습니다. {{ site.data.keys.product_adj }} OAuth 보안 모델의 인증 플로우를 사용하는 애플리케이션은 애플리케이션 디스크립터 파일의 `userIdentityRealms` 특성을 사용하여 사용자 ID 영역의 정렬된 목록을 정의할 수 있습니다. {{ site.data.keys.product_adj }} 클래식(비OAuth) 보안 모델의 인증 플로우를 사용하는 애플리케이션에서 `isInternalUserId` 속성은 해당 영역이 사용자 ID 영역인지 여부를 의미합니다. V8.0에서는 이러한 사용자 ID 구성이 더 이상 필요하지 않습니다. V8.0에서 활성 사용자의 ID는 `setActiveUser` 메소드를 마지막으로 호출한 보안 검사에 의해 설정됩니다. 보안 검사가 abstract `UserAuthenticationSecurityCheck` 기본 클래스(예: 샘플 V8.0 `UserLogin` 검사)를 확장할 경우 기본 클래스에 의존하여 활성 사용자의 ID를 설정할 수 있습니다. 


### 디바이스 ID 영역
{: #device-identity-realm }

V7.1 애플리케이션은 디바이스 ID 영역을 정의해야 합니다. V8.0에서는 이 영역이 필요하지 않습니다. V8.0에서 디바이스 ID는 보안 검사와 연관되지 않습니다. 대신, 디바이스 정보는 클라이언트 등록 플로우의 일부로 등록되는데, 이 등록 플로우는 클라이언트가 보호된 자원에 액세스하려고 처음 시도할 때 발생합니다. 

## 다음에 수행할 작업
{: #whats-next }

이 학습서는 {{ site.data.keys.product }}의 이전 버전에서 개발된 기존 애플리케이션의 보안 아티팩트를 V8.0으로 마이그레이션하는 데 필요한 기본 단계만 다룹니다. V8.0 보안 기능을 완전하게 활용하려면 [V8.0 보안 프레임워크 문서](../../authentication-and-security/)를 참조하십시오. 

