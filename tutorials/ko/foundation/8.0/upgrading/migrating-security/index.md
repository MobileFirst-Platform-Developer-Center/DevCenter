---
layout: tutorial
title: 인증 및 보안 개념 마이그레이션
breadcrumb_title: 인증 개념 마이그레이션
downloads:
  - 이름: 마이그레이션 샘플 다운로드
    URL: https://github.com/MobileFirst-Platform-Developer-Center/MigrationSample
가중치: 3
---
## 개요
{: #overview }
{{site.data.keys.product_full }}의 보안 프레임워크는 보안 개발 및 관리 태스크를 개선하고 단순화하기 위해 버전 8.0에서 몇 가지가 크게 변경되었습니다. 특히 보안 구성 요소가 변경되었습니다. 8.0에서는 OAuth 보안 범위 및 보안 검사가 이전 버전의 보안 테스트, 영역 및 로그인 모듈을 대체합니다. 

이 학습서에서는 애플리케이션의 보안 코드를 마이그레이션하는 데 필요한 단계를 안내합니다. 샘플 7.1 애플리케이션을 시작점으로 사용하고, 동일한 보안 보호로 7.1 샘플 애플리케이션에서 8.0 애플리케이션으로 이동하는 전체 프로세스를 설명합니다. 7.1 샘플 앱과 마이그레이션된 애플리케이션이 둘 다 여기에 첨부됩니다. 

아래에서 설명하는 마이그레이션 단계는 다음과 같습니다. 
*	자원 어댑터를 8.0으로 마이그레이션 및 자원 보호 유지보수
*	클라이언트 앱 마이그레이션
*	7.1 앱의 인증 영역을 대체할 보안 검사 작성
*	새 인증 확인 핸들러 API를 사용하도록 클라이언트 측에서 인증 확인 핸들러 수정

이 학습서의 [두 번째 파트](#migrating-other-types-of-authentication-realms)에서는 샘플 앱의 마이그레이션에서 설명하지 않은 추가적인 마이그레이션 문제를 다룹니다. 
*	샘플에서 설명하는 양식 기반 인증 및 어댑터 기반 인증 외에 다른 유형의 권한 영역 마이그레이션
*	액세스 토큰 만기
*	애플리케이션 레벨 보호(애플리케이션 보안 테스트)
*	사용자 ID 영역 및 디바이스 ID 영역과 같은 8.0의 더 단순한 보안 모델에서 더 이상 필요하지 않은 7.1의 보안 구성 설정

> 마이그레이션을 시작하기 전에 [마이그레이션 쿡북](../migration-cookbook)을 참조하십시오. 또한 새 보안 프레임워크의 기본 개념에 대해 학습하려면 [인증 및 보안 학습서](../../authentication-and-security)도 참조하십시오.

## 샘플 애플리케이션
{: #the-sample-application }
시작점은 샘플 7.1 하이브리드 애플리케이션입니다. 이 애플리케이션은 OAuth로 보호되는 Java 어댑터에 액세스합니다. 어댑터에는 두 개의 메소드가 있습니다. `getBalance` 메소드는 양식 기반 인증 영역(사용자 이름 및 비밀번호로 로그인)으로 보호되며 `transferMoney` 메소드는 사용자가 핀 코드를 제공해야 하는 어댑터 기반 인증 영역으로 보호됩니다. 7.1 샘플 애플리케이션의 소스 코드와 8.0으로 마이그레이션된 후 동일한 애플리케이션의 소스 코드는 [다운로드](https://github.com/MobileFirst-Platform-Developer-Center/MigrationSample)할 수 있습니다. 

## 자원 어댑터 마이그레이션
{: #migrating-the-resource-adapter }
자원 어댑터로 마이그레이션 프로세스를 시작합니다. 어댑터가 프로젝트의 파트인 7.1에서와 달리, {{site.data.keys.product }} 8.0에서 어댑터는 별도의 Maven 프로젝트로 개발됩니다. 즉, 클라이언트 앱과 독립적으로 자원 어댑터를 마이그레이션하고 빌드하고 배치할 수 있습니다. 사용자가 선택한 순서로 이러한 파트를 자유롭게 마이그레이션할 수 있습니다. 이 학습서에서는 자원을 보호하는 OAuth 보안 범위 요소를 소개할 수 있도록 우선 자원 어댑터를 마이그레이션합니다. 

자원 어댑터 `AccountAdapter`를 마이그레이션할 예정이지만 어댑터 기반 인증은 8.0에서 더 이상 지원되지 않으므로 어댑터 기반 인증에 사용되는 다른 어댑터 `PinCodeAdapter`를 마이그레이션할 필요는 없습니다. 다음 단계 중 하나에서 이 어댑터를 {{site.data.keys.product }} 8.0 보안 검사로 대체합니다. 

> 어댑터를 8.0으로 마이그레이션하기 위한 지시사항은 [마이그레이션 쿡북](../migration-cookbook)을 참조하십시오. 

7.1 샘플에서 `AccountAdpter`의 메소드는 이미 `@OAuthSecurity` 어노테이션으로 보호됩니다. 동일한 어노테이션이 버전 8.0에서 사용됩니다. 유일한 차이는 7.1에서는 범위 요소 `UserLoginRealm` 및 `PinCodeRealm`이 authenticationConfig.xml 파일에서 정의된 보안 영역을 참조한다는 점입니다. 반면에 8.0에서는 범위 요소가 서버에 배치된 보안 검사에 맵핑됩니다. 동일한 범위 요소 이름을 사용하여 코드를 변경하지 않은 채로 유지할 수 있지만 MFP 8.0에서는 "영역(realm)"이라는 용어가 더 이상 사용되지 않으므로 범위 요소의 이름을 `UserLogin` 및 `PinCode`로 바꾸기로 합니다. 

```java
@OAuthSecurity(scope="UserLogin")

@OAuthSecurity(scope="PinCode")
```

### 사용자 ID를 가져오기 위해 새 API 사용
{: #use-the-new-api-for-getting-the-user-identity }
자원 어댑터는 서버 측 보안 API를 사용하여 인증된 사용자의 ID를 얻습니다. 이 API는 8.0에서 변경되었으므로 수정해야 합니다. 다음 7.1 코드를 찾으십시오. 

```java
WLServerAPI api = WLServerAPIProvider.getWLServerAPI();
api.getSecurityAPI().getSecurityContext().getUserIdentity();
```

그런 다음 8.0에서 다음과 같은 새 API로 대체하십시오.


```java
// Inject the security context
@Context
AdapterSecurityContext securityContext;

 // Get the authenticated user name
String userName = securityContext.getAuthenticatedUser().getDisplayName();
```

Maven 또는 {{site.data.keys.mf_cli }}를 사용하여 [어댑터를 빌드하고 서버에 배치](../../adapters/creating-adapters/#build-and-deploy-adapters)하십시오. 

## 클라이언트 애플리케이션 마이그레이션
{: #migrating-the-client-application }
다음, 클라이언트 애플리케이션을 마이그레이션합니다. 클라이언트 애플리케이션 마이그레이션 지시사항에 대해서는 마이그레이션 쿡북을 참조하십시오.
당분간 인증 확인 핸들러의 코드를 주석 처리하십시오. 나중에 인증 확인 핸들러를 수정합니다. 앱의 기본 HTML 파일인 index.html은 인증 확인 핸들러 코드를 가져오는 행 주위에 주석을 넣습니다. 

```html
      <!--  
    <script src="js/UserLoginChallengeHandler.js"></script>
    <script src="js/PinCodeChallengeHandler.js"></script>
 -->
```

### 로그아웃을 위한 새 클라이언트 API의 변경사항
{: #change-to-the-new-client-api-for-logout }
클라이언트 마이그레이션의 일부로 MobileFirst 8.0의 클라이언트측 API에서 변경사항을 처리해야 합니다. 클라이언트 API 변경사항 목록은 [WebView 업그레이드](../migrating-client-applications/cordova/#upgrading-the-webview)를 참조하십시오.
샘플 애플리케이션에는 보안과 관련된 하나의 클라이언트 API 변경사항(로그아웃을 위한 API)이 있습니다. 7.1의 `WL.Client.logout` 메소드는 8.0에서 지원되지 않습니다. 대신 `WLAuthorizationManager.logout`을 사용하고, 7.1의 인증 영역을 대체하는 보안 검사의 이름을 전달하십시오.
샘플 앱에서 로그아웃 단추는 `UserLogin` 보안 검사와 `PinCode` 보안 검사 둘 다에서 사용자를 로그아웃합니다. 

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

앱의 마이그레이션 단계를 완료한 후 애플리케이션을 빌드하고 `mfpdev app register` 명령을 사용하여 {{site.data.keys.mf_server }}에 등록하십시오. 이제 {{site.data.keys.mf_console }}에 애플리케이션이 나열되어야 합니다. 

## 양식 기반 인증 영역 마이그레이션
{: #migrating-the-form-based-authentication-realm }
이 단계에서는 이미 클라이언트 애플리케이션과 자원 어댑터를 마이그레이션하고 배치했습니다. 그러나 지금 애플리케이션을 실행하려고 시도하면 자원에 액세스할 수 없습니다. 애플리케이션은 자원 어댑터 메소드("UserLogin" 또는 "PinCode")에 필요한 범위 요소를 포함하는 액세스 토큰을 제공할 것으로 예상되지만 아직 보안 검사를 작성하지 않았으므로 애플리케이션은 액세스 토큰을 얻을 수 없고 애플리케이션은 보호되는 자원에 액세스할 권한이 부여되지 않습니다. 

이제 7.1 양식 기반 인증 영역 "UserLoginRealm"을 대신할 "UserLogin"이라는 8.0 보안 검사를 작성합니다. 보안 검사는 이전에 양식 기반 인증자와 사용자 정의 로그인 모듈에서 구현된 것과 동일한 인증 단계를 수행합니다. 즉, 인증 확인을 클라이언트로 보내고 인증 확인 응답에서 신임 정보를 수집하고 신임 정보를 유효성 검증하고 사용자 ID를 작성합니다. 아래에 나타낸 것처럼 보안 검사 작성은 매우 간단하며, 신임 정보 유효성 검증을 위해 7.1 사용자 정의 로그인 모듈에서 새 보안 검사로 코드를 복사하기만 하면 됩니다. 

보안 검사는 어댑터로 구현되므로 `UserLogin`이라는 [새 Java 어댑터를 작성](../../adapters/creating-adapters)하는 것부터 시작합니다. 

Java 어댑터를 작성하는 경우 기본 템플리트는 해당 어댑터가 자원을 제공한다고 가정합니다. 동일한 어댑터를 사용하여 자원을 제공하고 보안 테스트를 패키징할 수 있지만 여기에서 새 어댑터는 보안 검사에만 사용합니다. 그러므로 기본 자원 구현을 제거하겠습니다. UserLoginApplication.java 및 UserLoginResource.java 파일을 삭제하십시오. 또한 adapter.xml에서 <JAXRSApplicationClass> 요소를 제거하십시오.
Java 어댑터의 adapter.xml 파일에 `securityCheckDefinition`이라는 XML 요소를 추가하십시오. 예: 

```xml
<securityCheckDefinition name="UserLogin" class="com.sample.UserLogin">
     <property name="successStateExpirationSec" defaultValue="3600"/>
</securityCheckDefinition>
```

* name 속성은 보안 검사의 이름입니다. 
* class 속성은 보안 검사의 구현 Java 클래스를 지정합니다. 다음 단계에서 이 클래스를 작성합니다. 
* successStateExpirationSec 특성은 7.1 로그인 모듈의 expirationInSeconds 특성과 동등합니다. 이 특성은 이 보안 검사에 대한 성공 로그인이 유지되는 간격을 초 단위로 표시합니다. 이 특성의 기본값은 7.1과 8.0 둘 다에서 3600초입니다. 7.1 로그인 모듈이 다른 값으로 구성된 경우, 여기에 동일한 값을 넣어야 합니다. 

이 학습서의 목표를 위해 `successStateExpirationSec` 특성만 정의하겠습니다. 실제로는 [보안 검사 구성](../../authentication-and-security/creating-a-security-check/#security-check-configuration)으로 훨씬 많은 작업을 수행할 수 있습니다. 특히 차단된 상태 만기, 다중 시도 및 "기억하기"와 같은 일부 고급 기능을 사용하도록 보안 검사를 구성할 수 있습니다. 사용자 정의 구성 특성을 추가할 수 있으며, 런타임에 MFP 콘솔에서 구성 특성을 수정할 수 있습니다. 

### 보안 검사 Java 클래스 작성
{: #creating-the-security-check-java-class }
`UserAuthenticationSecurityCheck`를 확장하는 `UserLogin`이라는 Java 클래스를 작성하여 어댑터에 추가하십시오. 다음, 세 메소드 `createChallenge`, `validateCredentials` 및 `createUser`의 기본 구현을 대체합니다. 

* `validateCredentials`에는 인증 로직을 넣습니다. 7.1 로그인 모듈에서 인증 로직 코드(사용자 이름과 비밀번호를 유효성 검증하는 코드)를 복사하여 여기에 넣으십시오. 이 경우 로직은 매우 단순합니다. 단순히 비밀번호가 사용자 이름과 동일한지 테스트합니다. 
* `createChallenge` 메소드에서 클라이언트에게 전송할 인증 확인 메시지(해시 맵)를 작성합니다. 일반적으로 보안 검사는 여기에 인증 확인 구문이나 클라이언트의 응답을 유효성 검증하는 데 사용되는 일부 다른 유형의 인증 확인 오브젝트를 넣을 수 있습니다. 이 보안 검사에는 인증 확인 구문이 필요하지 않으므로 인증 확인 메시지에는 오류 메시지만 넣으면 됩니다(오류가 발견된 경우). 
* `createUser` 메소드는 7.1 로그인 모듈의 `createIdentity` 메소드와 동등합니다. 

전체 클래스는 다음과 같습니다. 

```java
public class UserLogin extends UserAuthenticationSecurityCheck {
    private String userId, displayName;
    private String errorMsg;

    @Override
    protected boolean validateCredentials(Map<String, Object> credentials) {
        if (credentials!=null && credentials.containsKey("username") &&
		credentials.containsKey("password")){
            String username = credentials.get("username").toString();
            String password = credentials.get("password").toString();

            // the authentication logic, copied from the 7.1 login module
            if (!username.isEmpty() && !password.isEmpty() && username.equals(password)) {
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

Maven 또는 {{site.data.keys.mf_cli }}를 사용하여 [어댑터를 빌드하고 서버에 배치](../../adapters/creating-adapters/#build-and-deploy-adapters)하십시오. {{site.data.keys.mf_console }}에서 어댑터 목록에 새 어댑터 UserLogin이 표시되어야 합니다. 

## 핀 코드 영역 마이그레이션
{: #migrating-the-pin-code-realm }
샘플에서 핀 코드 영역은 어댑터 기반 인증으로 구현되었으며, 이는 8.0에서 더 이상 지원되지 않습니다. 이 영역을 새 보안 검사로 대체합니다. 

`PinCode`라는 새 Java 어댑터를 작성하십시오. `CredentialsValidationSecurityCheck`를 확장하는 `PinCode`라는 Java 클래스를 작성하여 어댑터에 추가하십시오. 이번에는 UserLogin 보안 검사에 사용한 `UserAuthenticationSecurityCheck`가 아니라 `CredentialsValidationSecurityCheck`를 기본 클래스로 사용합니다. 핀 코드 보안 검사는 신임 정보(핀 코드)를 유효성 검증할 필요가 있을 뿐 사용자 ID를 지정하지는 않기 때문입니다. 

`CredentialsValidationSecurityCheck`를 확장하는 보안 검사를 작성하기 위해서는 `createChallenge`와 `validateCredentials`의 두 메소드를 구현해야 합니다. 

`UserLogin` 보안 검사와 유사하게 `PinCode` 보안 검사에는 인증 확인의 일부로 클라이언트로 전송할 특수 정보가 없습니다. `createChallenge` 메소드는 인증 확인 메시지 내에 오류 메시지(존재하는 경우)만 넣습니다. 

```java
    @Override
    protected Map<String, Object> createChallenge() {
        Map challenge = new HashMap();
        challenge.put("errorMsg",errorMsg);
        return challenge;
    }
```

`validateCredentials` 메소드는 핀 코드를 유효성 검증합니다. 이 경우 유효성 검증 코드는 한 행의 코드로 구성되지만 일반적으로 7.1 인증 어댑터의 유효성 검증 코드를 `validateCredentials` 메소드로 복사할 수 있습니다. 

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

[어댑터를 빌드하여 서버에 배치](../../adapters/creating-adapters/#build-and-deploy-adapters).

## 인증 확인 핸들러 마이그레이션
{: #migrating-the-challenge-handlers }
이제 마이그레이션된 클라이언트 앱, 자원 어댑터 및 자원을 보호하기 위한 보안 검사가 있습니다. 누락된 부분은 클라이언트에서 인증 확인으로 응답을 보내고 보안 검사로 신임 정보를 보낼 수 있게 해 주는 클라이언트 측의 인증 확인 핸들러뿐입니다. 클라이언트 앱을 마이그레이션할 때 인증 확인 핸들러를 포함하는 행을 주석 처리했음을 기억하십시오. 이제 이러한 행의 주석 처리를 취소하고 인증 확인 핸들러를 8.0으로 마이그레이션할 시간입니다. 

사용자 로그인 인증 확인 핸들러에서 시작합니다. 이 인증 확인 핸들러는 8.0에서도 7.1에서와 동일한 기능을 수행합니다. 이 핸들러는 인증 확인을 수신할 때 사용자에게 로그인 양식을 제공하고 사용자 이름과 비밀번호를 서버로 보낼 책임이 있습니다. 그러나 인증 확인 핸들러를 위한 클라이언트 API가 변경되고 단순화되었으므로 다음과 같이 변경해야 합니다. 

* 인증 확인 핸들러를 작성하는 호출을 다음으로 대체하십시오. 

```javascript
var userLoginChallengeHandler = WL.Client.createSecurityCheckChallengeHandler('UserLogin');
```

`createSecurityCheckChallengeHandler` 메소드는 {{site.data.keys.product_adj }} 보안 검사가 전송한 인증 확인을 처리하는 인증 확인 핸들러를 작성합니다. 대부분의 경우 7.1 클라이언트 API의 `createWLChallengeHandler` 메소드 또는 `createChallengeHandler` 메소드 대신 이 메소드를 사용해야 합니다. 유일한 예외는 써드파티 게이트웨이가 전송한 인증 확인을 처리하도록 디자인된 인증 확인 핸들러입니다. 이 유형의 인증 확인 핸들러를 8.0에서는 게이트웨이 인증 확인 핸들러라고 하며, WL.Client.createGatewayChallengeHandler() 메소드로 작성됩니다. 예를 들어, 사용자의 자원이 사용자 정의 로그인 양식을 클라이언트로 보내는 DataPower와 같은 되돌리기 프록시에 의해 보호되는 경우, 게이트웨이 인증 확인 핸들러를 사용하여 인증 확인을 처리해야 합니다. 게이트웨이 인증 확인 핸들러에 대한 자세한 정보는 [Quick Review of Challenge Handlers](https://mobilefirstplatform.ibmcloud.com/blog/2016/06/22/challenge-handlers/) 기사를 참조하십시오. 

* `isCustomResponse` 메소드를 제거하십시오. 이 메소드는 보안 검사 인증 확인 핸들러에 더 이상 필요하지 않습니다. 
* `handleChallenge` 메소드를 인증 확인 핸들러가 구현해야 하는 세 메소드 `handleChallenge()`, `handleSuccess()` 및 `handleFailure`로 대체하십시오. 8.0에서 인증 확인 핸들러는 응답이 인증 확인, 성공 또는 오류를 전달하는지 여부를 찾기 위해 더 이상 응답을 검사할 필요가 없습니다. 프레임워크가 이를 처리하고 적절한 메소드를 호출합니다. 
* `submitSuccess` 호출을 제거하십시오. 프레임워크가 자동으로 성공 응답을 처리합니다. 
* `submitFailure` 호출을 `userLoginChallengeHandler.cancel`로 대체하십시오. 
* `submitLoginForm` 호출을 다음으로 대체하십시오. 

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

핀 코드 인증 확인 핸들러의 마이그레이션은 사용자 로그인 인증 확인 핸들러의 마이그레이션과 매우 유사하므로 여기에서 자세히 나타내지는 않습니다. 첨부된 8.0 샘플에서 마이그레이션된 인증 확인 핸들러의 코드를 참조하십시오. 이는 앱의 마이그레이션을 완료합니다. 이제 애플리케이션을 다시 빌드하고, 서버에 배치하고, 작동하는지 테스트하고, 자원에 대한 액세스가 예상대로 보호되는지 테스트할 수 있습니다. 

## 다른 유형의 인증 영역 마이그레이션
{: #migrating-other-types-of-authentication-realms }
위의 절에서는 양식 기반 인증 영역 및 어댑터 기반 인증 영역의 마이그레이션 프로세스를 설명했습니다. 7.1 애플리케이션에는 애플리케이션 보안 테스트에 명시적으로 추가된 영역이나 `mobileSecurityTest` 또는 `webSecurityTest`에 기본적으로 포함된 영역 등 다른 유형의 영역이 포함될 수 있습니다. 다른 유형의 영역을 8.0으로 마이그레이션하려면 다음 가이드라인을 참조하십시오. 

### 애플리케이션 인증
{: #application-authenticity }
애플리케이션 인증은 8.0에서 사전 정의된 보안 검사로 제공됩니다. 기본적으로 이 보안 검사는 {{site.data.keys.mf_server }}에서 애플리케이션 런타임을 등록할 때 실행되며, 애플리케이션 인스턴스가 서버에 처음 연결하려고 시도할 때 발생합니다. 그러나 모든 {{site.data.keys.product_adj }} 보안 검사와 마찬가지로 사용자 정의 보안 범위에 이 사전 정의된 검사를 포함시킬 수 있습니다. 

### LTPA 영역
{: #ltpa-realm }
사전 정의된 8.0 보안 검사인 `LtpaBasedSSO`를 사용하십시오. 자세한 정보는 [IBM DataPower를 사용하여 {{site.data.keys.product_adj }} 8.0 애플리케이션 트래픽 보호]({{ site.baseurl }}/blog/2016/06/17/datapower-integration/) 학습서를 참조하십시오. 

### 디바이스 프로비저닝
{: #device-provisioning }
8.0의 클라이언트 등록 프로세스는 7.1의 디바이스 프로비저닝을 대체합니다. {{site.data.keys.product_adj }} 8.0에서 클라이언트(애플리케이션 인스턴스)는 서버에 처음 액세스하려고 시도할 때 자신을 {{site.data.keys.mf_server }}에 등록합니다. 등록의 일부로 클라이언트는 ID를 인증하는 데 사용할 공개 키를 제공합니다. 이 보호 메커니즘은 항상 사용되며, 디바이스 프로비저닝 영역을 8.0으로 마이그레이션할 필요가 없습니다. 

### 교차 사이트 요청 위조 방지(anti-XSRF) 영역
{: #anti-cross-site-request-forgery-anti-xsrf-realm }
Anti-XSRF는 8.0의 OAuth 기반 보안 프레임워크에서는 더 이상 관련이 없습니다. 

### 직접 업데이트 영역
{: #direct-update-realm }
직접 업데이트 영역을 8.0으로 마이그레이션할 필요는 없습니다. 직접 업데이트 기능은 {{site.data.keys.product_adj }} 8.0에서 지원되지만 이전 버전에서 필요한 직접 업데이트 영역과 같은 보안 검사는 필요하지 않습니다. 그러나 직접 업데이트 기능을 사용하여 업데이트를 전달하는 단계가 변경되었습니다. 자세한 정보는 [직접 업데이트 마이그레이션](../migrating-client-applications/cordova/#migrating-direct-update) 문서 주제를 참조하십시오.

### 원격 사용 안함 영역
{: #remote-disable-realm }
원격 사용 안함 영역을 8.0으로 마이그레이션할 필요는 없습니다. {{site.data.keys.product_adj }} 8.0의 원격 사용 안함 기능에는 보안 검사가 필요하지 않습니다. 

### 사용자 정의 인증자 및 로그인 모듈
{: #custom-authenticators-and-login-modules }
위에서 설명한 것처럼 새 보안을 작성하십시오. 기본 클래스 `UserAuthenticationSecurityCheck` 또는 `CredentialsValidationSecurityCheck`를 사용하십시오. 인증자 클래스 또는 로그인 모듈 클래스를 직접 마이그레이션할 수는 없지만 인증 확인 생성, 응답에서 신임 정보 추출 및 신임 정보 유효성 검증을 위한 코드와 같은 관련 코드 조각을 보안 검사에 복사할 수 있습니다. 

## 7.1의 추가 보안 구성 마이그레이션
{: #migrating-additional-security-configurations-of-71 }
### 애플리케이션 보안 테스트
{: #the-application-security-test }
자원 어댑터를 보호하는 데 사용되는 OAuth 범위 외에 7.1 샘플 애플리케이션도 애플리케이션 레벨 보안 테스트로 보호됩니다. 이 샘플은 application-descriptor.xml 파일에 애플리케이션 보안 테스트가 정의되어 있지 않으므로 기본 보안 테스트로 보호됩니다. 7.1에서 모바일 애플리케이션을 위한 기본 보안 테스트는 8.0에서 무관한 영역(anti-XSRF) 또는 명시적 마이그레이션이 필요하지 않은 영역(직접 업데이트, 원격 사용 안함)으로 구성됩니다. 그러므로 이 경우 애플리케이션 보안 테스트를 위한 마이그레이션이 필요하지 않습니다. 

8.0으로 마이그레이션한 후 애플리케이션 레벨에서 여전히 유지하기를 원하는 검사(영역)를 포함하는 애플리케이션 보안 테스트가 애플리케이션에 있는 경우, 해당 애플리케이션을 위한 필수 범위를 구성할 수 있습니다. 애플리케이션이 보호되는 자원에 액세스하려고 시도하는 경우, 자원을 보호하는 범위로 맵핑되는 검사 외에 필수 범위로 맵핑되는 보안 검사도 전달해야 합니다. 

애플리케이션을 위한 필수 범위를 정의하려면 {{site.data.keys.mf_console }}에서 애플리케이션 버전을 선택하고 보호 탭을 선택한 후 범위에 추가 단추를 클릭하십시오. 사전 정의되거나 사용자 정의된 보안 검사 또는 맵핑된 범위 요소를 범위에 포함시킬 수 있습니다. 

### 액세스 토큰 만기
{: #access-token-expiration }
application-descriptor.xml 파일에서 액세스 토큰 만기 특성의 값을 확인하십시오. 버전 7.1과 버전 8.0 둘 다에서 기본값은 3600초이므로, 애플리케이션 디스크립터 파일에 다른 값이 정의된 애플리케이션이 아니라면 아무것도 변경할 필요가 없습니다. 8.0에서 만기 값을 설정하려면 {{site.data.keys.mf_console }}에서 애플리케이션 버전 페이지로 이동한 후 보안 탭을 선택하고 최대 토큰 만기 기간 필드에 값을 입력하십시오. 

### 사용자 ID 영역
{: #user-identity-realm }
MobileFirst 7.1에서 인증 영역은 사용자 ID 영역으로 구성될 수 있습니다. OAuth 인증 플로우를 사용하는 애플리케이션은 애플리케이션 디스크립터 파일에서 `userIdentityRealms` 특성을 사용하여 사용자 ID 범위의 정렬된 목록을 정의합니다. 일반 Worklight 인증 플로우(비OAuth)를 사용하는 애플리케이션에서 `isInternalUserId` 속성은 해당 영역이 사용자 ID 영역인지 여부를 표시합니다. 이러한 구성은 {{site.data.keys.product_adj }} 8.0에서는 더 이상 필요하지 않습니다. {{site.data.keys.product_adj }} 8.0에서 활성 사용자 ID는 `setActiveUser` 메소드를 호출한 마지막 보안 검사에 의해 설정됩니다. 보안 검사가 샘플 애플리케이션의 UserLogin 보안 검사처럼 abstract 기본 클래스 `UserAuthenticationSecurityCheck`를 확장하는 경우, 기본 클래스가 활성 사용자 설정을 처리합니다. 

### 디바이스 ID 영역
{: #device-identity-realm }
7.1 애플리케이션에는 디바이스 ID 영역으로 정의된 영역이 있어야 합니다. 8.0에서는 이 구성을 위한 마이그레이션이 필요하지 않습니다. {{site.data.keys.product_adj }} 8.0에서 디바이스 ID는 보안 검사와 연관되지 않습니다. 디바이스 정보는 클라이언트 등록 플로우의 일부로 등록되며, 이 플로우는 클라이언트가 보호된 자원에 액세스하려고 처음 시도할 때 발생합니다. 

## 요약


{: #summary }
이 학습서에서는 이전 버전에서 기존 애플리케이션의 보안 아티팩트를 마이그레이션하는 데 필요한 기본 단계만 다루었습니다. [새 보안 프레임워크에 대해 자세히 학습](../../authentication-and-security/)하고 여기에서 다루지 않은 추가 기능을 이용할 것을 권장합니다. 
