---
layout: tutorial
title: 기밀 클라이언트
relevantTo: [android,ios,windows,javascript]
weight: 10
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
모바일 애플리케이션은 보호된 자원에 대한 액세스를 요청하기 위해 {{ site.data.keys.product_adj }} 클라이언트 SDK를 활용할 수 있습니다.   
모바일 애플리케이션이 아닌 기타 엔티티 역시 동일하게 수행할 수 있습니다. 이러한 엔티티는 **기밀 클라이언트**로 간주됩니다. 

기밀 클라이언트는 인증 신임 정보의 기밀성을 유지할 수 있는
클라이언트입니다. {{ site.data.keys.product_adj }} 권한 부여 서버를 사용하여
OAuth 스펙에 따라 보호 대상 자원에 대한 액세스 권한을 기밀 클라이언트에 부여할 수 있습니다. 이 기능은 **푸시 알림**을 위한 REST API와 같은 {{ site.data.keys.product }} **REST API** 중 하나를 사용하거나 보호된 자원을 요청해야 하는 모든 종류의 백엔드 및 성능 테스트 애플리케이션과 같은 비모바일 클라이언트에 자원에 대한 액세스를 부여할 수 있게 허용합니다. 

먼저 기밀 클라이언트를 {{ site.data.keys.mf_server }}에
등록합니다. 등록 과정에서 기밀 클라이언트의 신임 정보(ID와 본인확인정보)를
제공합니다. 또한 클라이언트에 부여될 수 있는 범위를 결정하는
클라이언트 허용 범위를 설정합니다.
등록된 기밀 클라이언트가 권한 서버에 액세스 토큰을 요청하면 서버에서
등록된 신임 정보를 사용하여 클라이언트를 인증하고, 요청된 범위가 클라이언트의
허용 범위와 일치하는지 확인합니다. 

등록된 기밀 클라이언트는 {{ site.data.keys.mf_server }}에 대한 모든 요청에서 사용할 토큰을 얻을 수 있습니다. 이 플로우는 OAuth 스펙의 [클라이언트 신임 정보 플로우](https://tools.ietf.org/html/rfc6749#section-1.3.4)를 기반으로 합니다. 기밀 클라이언트를 위한 액세스 토큰은 1시간 동안 유효함을 참고하십시오. 1시간 넘게 지속되는 태스크에 대해 기밀 클라이언트를 사용하는 경우 새 토큰 요청을 전송하여 매시간 토큰을 갱신하십시오. 

## 기밀 클라이언트 등록
{: #registering-the-confidential-client }
{{ site.data.keys.mf_console }}의 탐색 사이드바에서 **런타임 설정** → **기밀 클라이언트**를 클릭하십시오. **새로 작성**을 클릭하여 새 항목을 추가하십시오.   
다음 정보를 제공해야 합니다.

- **표시 이름**: 기밀 클라이언트를 지칭하는 데 사용되는 선택적 표시 이름입니다. 기본 표시 이름은 ID 매개변수의 값입니다.예를 들어 **백엔드 노드 서버**입니다. 
- **ID**: 기밀 클라이언트의 고유 ID입니다("사용자 이름"으로 간주될 수 있음). ID는 ASCII 문자만 포함할 수 있습니다. 
- **본인확인정보**: 기밀 클라이언트에서 액세스 권한을 부여하기 위한 개인용 비밀번호 문구입니다(API 키로 간주될 수 있음). 본인확인정보는 ASCII 문자만 포함할 수 있습니다. 
- **허용 범위**: 이러한 ID 및 본인확인정보 조합을 사용하는 기밀 클라이언트는 여기에서 정의된 범위가 자동으로 부여됩니다. 범위에 대한 자세한 정보는 [범위](../#scopes)를 참조하십시오. 
    - 허용 범위의 요소는 0개 이상의 문자 시퀀스를 나타내는 특수 별표 와일드카드 문자(`*`)도 포함할 수 있습니다. 예를 들어 범위 요소가 `send*`일 경우 기밀 클라이언트는 "sendMessage"와 같이 "send"로 시작하는 범위 요소를 포함하는 범위에 대한 액세스가 부여될 수 있습니다. 별표 와일드카드를 범위 요소 내의 임의의 위치에 배치할 수 있고, 두 번 이상 표시할 수도 있습니다.  
    - 한 개의 별표 문자(*)로 이루어진 허용 범위 매개변수는 기밀 클라이언트에 모든 범위에 대한 토큰이 부여될 수 있음을 나타냅니다. 

**범위의 예:**

- [외부 자원 보호](../protecting-external-resources)는 `authorization.introspect` 범위를 사용합니다. 
- REST API를 통한 [푸시 알림 전송](../../notifications/sending-notifications)은 범위 요소 `messages.write` 및 `push.application.<applicationId>`를 공백으로 구분하여 사용합니다. 
- 어댑터는 `accessRestricted`와 같이 사용자 정의 범위 요소로 보호될 수 있습니다. 
- `*` 범위는 catch-all 범위로서 모든 요청된 범위에 액세스 권한을 부여합니다. 

<img class="gifplayer" alt="기밀 클라이언트 구성" src="push-confidential-client.png"/>

## 사전 정의된 기밀 클라이언트
{: #predefined-confidential-clients }
{{ site.data.keys.mf_server }}는 사전 정의된 일부 기밀 클라이언트와 함께 제공됩니다. 

### 테스트
{: #test }
`test` 클라이언트는 개발 모드에서만 사용할 수 있습니다. 테스트 클라이언트를 통해 자원을 쉽게 테스트할 수 있습니다. 

- **ID**: `test`
- **본인확인정보**: `test`
- **허용 범위**: `*` (모든 범위)

### admin
{: #admin }
`admin` 클라이언트는 {{ site.data.keys.product }} 관리 서비스에 의해 내부적으로 사용됩니다. 

### 푸시
{: #push }
`push` 클라이언트는 {{ site.data.keys.product }} 푸시 서비스에 의해 내부적으로 사용됩니다. 

## 액세스 토큰 얻기
{: #obtaining-an-access-token }
토큰을 {{ site.data.keys.mf_server }} **토큰 엔드포인트**로부터 얻을 수 있습니다.   

**테스트 목적으로**, 아래에 설명되어 있는 바와 같이 Postman을 사용할 수 있습니다.   
실제 상황에서는 사용자가 선택한 기술로 백엔드 로직에 Postman을 구현할 수 있습니다. 

1.  다음에 대해 **POST** 요청을 작성하십시오. **http(s)://[ipaddress-or-hostname]:[port]/[runtime]/api/az/v1/token**.  
    For example: `http://localhost:9080/mfp/api/az/v1/token`
    - 개발 환경에서 {{ site.data.keys.mf_server }}는 사전 존재 `mfp` 런타임을 사용합니다.   
    - 프로덕션 환경에서는 런타임 값을 사용자의 런타임 이름으로 대체하십시오. 

2.  `application/x-www-form-urlencoded`의 컨텐츠 유형으로 요청을 설정하십시오.   
3.  다음 두 양식 매개변수를 설정하십시오. 
    - `grant_type` - 값을 `client_credentials`로 설정하십시오. 
    - `scope` - 값을 자원의 보호 범위로 설정하십시오. 자원에 보호 범위가 지정되지 않은 경우에는 이 매개변수를 생략하여 기본 범위(`RegisteredClient`)를 적용하십시오. 자세한 정보는 [범위](../../authentication-and-security/#scopes)를 참조하십시오. 

       ![Postman 구성의 이미지](confidential-client-steps-1-3.png)

4.  요청을 인증하려면 [기본 인증](https://en.wikipedia.org/wiki/Basic_access_authentication#Client_side)을 사용하십시오. 기밀 클라이언트의 **ID** 및 **본인확인정보**를 사용하십시오. 

    ![Postman 구성의 이미지](confidential-client-step-4.png)

    Postman 외부에서, **test** 기밀 클라이언트를 사용하는 경우 **HTTP 헤더**를 `Authorization: Basic dGVzdDp0ZXN0`로 설정하십시오(**base64**를 사용하여 `test:test` 인코딩).

이 요청의 응답은 **액세스 토큰** 및 만료 시간(1시간)을 포함하여 `JSON` 오브젝트를 포함합니다. 

```json
{
  "access_token": "eyJhbGciOiJSUzI1NiIsImp ...",
  "token_type": "Bearer",
  "expires_in": 3599,
  "scope": "sendMessage accessRestricted"
}
```

![기밀 클라이언트 작성](confidential-client-access-token.png)

## 액세스 토큰 사용
{: #using-the-access-token }
이제, **HTTP 헤더**: `Authorization: Bearer eyJhbGciOiJSUzI1NiIsImp ...`를 추가하고, 액세스 토큰을 이전 JSON 오브젝트에서 추출한 액세스 토큰으로 대체하여 원하는 자원에 대해 요청을 작성할 수 있습니다. 

## 가능한 응답
{: #possible-responses }
자원이 생성할 수 있는 일반 응답 이외에 {{ site.data.keys.mf_server }}에서 생성하는 몇 가지 응답을 살펴보십시오. 

### Bearer
{: #bearer }
HTTP 헤더 `WWW-Authenticate : Bearer`가 있는 HTTP **401** 응답 상태는 원래 요청의 `Authorization` 헤더에 토큰이 없음을 의미합니다. 

### invalid_token
{: #invalid-token }
HTTP 헤더 `WWW-Authenticate: Bearer error="invalid_token"`이 있는 HTTP **401** 응답 상태는 전송된 토큰이 **올바르지 않거나** **만료됨**을 의미합니다. 

### insufficient_scope
{: #insufficient-scope }
HTTP 헤더 `WWW-Authenticate : Bearer error="insufficient_scope", scope="RegisteredClient scopeA scopeB"`가 있는 HTTP **403** 응답은 원래 요청에서 발견된 토큰이 이 자원에서 요구하는 범위와 일치하지 않음을 의미합니다. 이 헤더는 예상 범위도 포함합니다. 

요청을 발행할 때 자원에서 요구하는 범위를 모르는 경우에는 `insufficient_scope`를 사용하여 필요한 범위를 판별하십시오. 예를 들면, 범위를 지정하지 않고 토큰을 요청한 후 자원에 대한 요청을 작성하십시오. 그런 다음 403 응답에서 요청된 범위를 추출하여 이 범위에 대해 새 토큰을 요청할 수 있습니다. 

