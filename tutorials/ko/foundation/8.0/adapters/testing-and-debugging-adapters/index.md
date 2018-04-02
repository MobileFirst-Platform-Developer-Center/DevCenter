---
layout: tutorial
title: 어댑터 테스트 및 디버깅
relevantTo: [ios,android,windows,javascript]
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }

Java 및 JavaScript 어댑터를 테스트하고 Java 또는 JavaScript 어댑터에서 사용하기 위해 구현된 Java 코드를 디버그하기 위해 Eclipse 및 IntelliJ 등과 같은 IDE를 사용할 수 있습니다.  

이 학습서에서는 {{ site.data.keys.mf_cli }} 및 Postman을 사용하여 어댑터를 테스트하는 방법 및 Eclipse IDE를 사용하여 Java 어댑터를 디버깅하는 방법을 보여줍니다.

#### 다음으로 이동
{: #jump-to }

* [어댑터 테스트](#testing-adapters)
 * [Postman 사용](#using-postman)
 * [Swagger 사용](#using-swagger)
* [어댑터 디버깅](#debugging-adapters)
 * [JavaScript 어댑터](#debugging-javascript-adapters)
 * [Java 어댑터](#debugging-java-adapters)

## 어댑터 테스트
{: #testing-adapters }

어댑터는 REST 인터페이스를 통해 사용 가능합니다. 이는 사용자가 자원의 URL을 알면 요청을 테스트하고 적절하다고 판단하는 `URL` 매개변수, `path` 매개변수, `body` 매개변수 또는 `headers`를 전달하기 위해 Postman과 같은 HTTP 도구를 사용할 수 있음을 의미합니다.

어댑터 자원에 액세스하는 데 사용되는 URL의 구조는 다음과 같습니다.

* JavaScript 어댑터의 경우 - `http://hostname-or-ip-address:port-number/mfp/api/adapters/{adapter-name}/{procedure-name}`
* Java 어댑터의 경우 - `http://hostname-or-ip-address:port-number/mfp/api/adapters/{adapter-name}/{path}`

### 매개변수 전달
{: #passing-parameters }

* Java 어댑터를 사용할 때 어댑터를 구성했던 방법에 따라서 URL, 본문, 양식 등에서 매개변수를 전달할 수 있습니다.
* JavaScript 어댑터를 사용할 때 `params=["param1", "param2"]`로 매개변수를 전달합니다. 즉, JavaScript 프로시저는 **정렬되고 이름이 지정되지 않은 값의 배열**인 `params`라는 하나의 매개변수만 수신합니다. 이 매개변수는 URL(`GET`)에서 또는 본문(`POST`)에서 `Content-Type: application/x-www-form-urlencoded`를 사용하여 표시될 수 있습니다.

### 보안 처리
{: #handling-security }

자원에 명시적으로 지정된 범위가 없더라도 {{ site.data.keys.product }} 보안 프레임워크는 어댑터 자원을 위한 액세스 토큰을 필요로 합니다. 따라서 특별히 보안을 사용 안함으로 설정하지 않는다면 엔드포인트는 항상 보안이 적용됩니다.

Java 어댑터에서 보안을 사용 안함으로 설정하려면 `OAuthSecurity` 어노테이션을 method/class에 추가하십시오.

```java
@OAuthSecurity(enabled=false)
```

JavaScript 어댑터에서 보안을 사용 안함으로 설정하려면 `secured` 속성을 프로시저에 추가하십시오.

```js
<procedure name="adapter-procedure-name" secured="false"/>
```

{{ site.data.keys.mf_server }}의 개발 버전은 보안 문제를 임시 해결하기 위해 테스트 토큰 엔드포인트를 포함합니다.

### Postman 사용
{: #using-postman }

#### 테스트 토큰
{: #test-token }

테스트 토큰을 수신하려면 아래의 "Postman으로 실행" 단추를 클릭하여 준비된 요청을 포함하는 Postman 앱으로 콜렉션을 가져오거나, 다음 단계에 따라 요청을 직접 작성하십시오.

<a href="https://app.getpostman.com/run-collection/d614827491450d43c10e"><img src="https://run.pstmn.io/button.svg" alt="Postman으로 실행" style="margin: 0"></a>

{% comment %}
1. {{ site.data.keys.mf_console }} → **설정** → **기밀 클라이언트** 탭에서 기밀 클라이언트를 작성하거나 기본값을 사용하십시오.  
테스트 용도의 경우 **허용된 범위**를 `**`로 설정하십시오.

  ![기밀 클라이언트 설정 이미지](confidential_client.png)
{% endcomment %}

1.  HTTP 클라이언트(Postman)를 사용하여, `Content-Type: application/x-www-form-urlencoded`를 지정하고 다음 매개변수와 함께 `http://<IP>:<PORT>/mfp/api/az/v1/token`에 대해 HTTP `POST` 요청을 작성하십시오.

    - `grant_type` - 값을 `client_credentials`로 설정하십시오.
    - `scope` - 값을 자원의 보호 범위로 설정하십시오. 자원에 보호 범위가 지정되지 않은 경우에는 이 매개변수를 생략하여 기본 범위(`RegisteredClient`)를 적용하십시오. 자세한 정보는 [범위](../../authentication-and-security/#scopes)를 참조하십시오.

    ![Postman 본문 구성 이미지](Body_configuration.png)

2.  기밀 클라이언트 ID("테스트") 및 시크릿("테스트")과 함께 `Basic authentication`을 사용하여 `authorization header`를 추가하십시오.
    > 기밀 클라이언트에 대한 자세한 정보는 [기밀 클라이언트](../../authentication-and-security/confidential-clients)를 참조하십시오.

    ![Postman 권한 부여 구성 이미지](Authorization_configuration.png)


결과는 임시 유효 액세스 토큰이 있는 JSON 오브젝트입니다.

```json
{
  "access_token": "eyJhbGciOiJSUzI1NiIsImp3ayI6eyJlIjoiQVFBQiIsIm4iOiJBTTBEZDd4QWR2NkgteWdMN3I4cUNMZEUtM0kya2s0NXpnWnREZF9xczhmdm5ZZmRpcVRTVjRfMnQ2T0dHOENWNUNlNDFQTXBJd21MNDEwWDlJWm52aHhvWWlGY01TYU9lSXFvZS1ySkEwdVp1dzJySGhYWjNXVkNlS2V6UlZjQ09Zc1FOLW1RSzBtZno1XzNvLWV2MFVZd1hrU093QkJsMUVocUl3VkR3T2llZzJKTUdsMEVYc1BaZmtOWkktSFU0b01paS1Uck5MelJXa01tTHZtMDloTDV6b3NVTkExNXZlQ0twaDJXcG1TbTJTNjFuRGhIN2dMRW95bURuVEVqUFk1QW9oMmluSS0zNlJHWVZNVVViTzQ2Q3JOVVl1SW9iT2lYbEx6QklodUlDcGZWZHhUX3g3c3RLWDVDOUJmTVRCNEdrT0hQNWNVdjdOejFkRGhJUHU4Iiwia3R5IjoiUlNBIiwia2lkIjoidGVzdCJ9fQ.eyJpc3MiOiJjb20uaWJtLm1mcCIsInN1YiI6InRlc3QiLCJhdWQiOiJjb20uaWJtLm1mcCIsImV4cCI6MTQ1MjUxNjczODAwNSwic2NvcGUiOiJ4eCJ9.vhjSkv5GShCpcDSu1XCp1FlgSpMHZa-fcJd3iB4JR-xr_3HOK54c36ed_U5s3rvXViao5E4HQUZ7PlEOl23bR0RGT2bMGJHiU7c0lyrMV5YE9FdMxqZ5MKHvRnSOeWlt2Vc2izh0pMMTZd-oL-0w1T8e-F968vycyXeMs4UAbp5Dr2C3DcXCzG_h9jujsNNxgXL5mKJem8EpZPolQ9Rgy2bqt45D06QTW7J9Q9GXKt1XrkZ9bGpL-HgE2ihYeHBygFll80M8O56By5KHwfSvGDJ8BMdasHFfGDRZUtC_yz64mH1lVxz5o0vWqPwEuyfslTNCN-M8c3W9-6fQRjO4bw",
  "token_type": "Bearer",
  "expires_in": 3599,
  "scope": "**"
}
```
<br/><br/>
#### 요청 전송
{: #sending-request }

어댑터 엔드포인트에 대한 추가 요청이 있으므로 `Authorization` 이름의 HTTP 헤더와 이전에 수신한 값(Bearer로 시작하는)을 추가하십시오. 보안 프레임워크는 사용자의 자원을 보호하는 보안 문제를 건너뜁니다.

  ![테스트 토큰과 함께 Postman을 사용하는 어댑터 요청](Adapter-response.png)

### Swagger 사용
{: #using-swagger }

Swagger 문서 UI는 어댑터의 REST 엔드포인트에 대한 시각적 표시입니다.  
Swagger을 사용하여 개발자는 클라이언트 애플리케이션이 이용하기 전에 어댑터 엔드포인트를 테스트할 수 있습니다.

Swagger에 액세스하려면 다음을 수행하십시오.

1. {{ site.data.keys.mf_console }}을 열고 어댑터 목록에서 어댑터를 선택하십시오.
2. **자원** 탭을 클릭하십시오.
3. **Swagger 문서 보기** 단추를 클릭하십시오.  
4. **표시/숨기기** 단추를 클릭하십시오.

  ![Swagger UI 이미지](SwaggerUI.png)

<img alt="Swagger UI의 켜기/끄기 스위치 이미지" src="on-off-switch.png" style="float:right;margin:27px -10px 0 0"/>

#### 테스트 토큰 추가
{: #adding-a-test-token }

요청에 테스트 토큰을 추가하여 보안 프레임워크가 자원을 보호하는 보안 문제를 건너뛰게 하려면 엔드포인트의 조작의 오른쪽 구석에 있는 **켜기/끄기 스위치** 단추를 클릭하십시오.

Swagger UI에 부여하려는 범위를 선택하도록 요청됩니다. (테스트 용도의 경우 모두를 선택할 수 있습니다.) 처음으로 Swagger UI를 사용 중인 경우 기밀 클라이언트 ID와 시크릿으로 로그인해야 할 수 있습니다. 이를 위해서 **허용된 범위**를 `*`로 지정하여 새 기밀 클라이언트를 작성해야 합니다.

> [기밀 클라이언트](../../authentication-and-security/confidential-clients) 학습서에서 기밀 클라이언트에 대해 자세히 알아보십시오.

<br/><br/>

#### 요청 전송
{: #sending-request-swagger }

엔드포인트의 조작을 확장하고 필수 매개변수(필요한 경우)를 입력한 다음 **시험해 보기!** 단추를 클릭하십시오.

  ![테스트 토큰과 함께 Swagger를 사용하는 어댑터 요청](SwaggerReq.png)

#### Swagger 어노테이션
{: #swagger-annotations }
Java 어댑터에서만 이용할 수 있습니다.

Java 어댑터를 위한 Swagger 문서를 생성하려면 Java 구현에서 Swagger 제공 어노테이션을 사용하십시오.
> Swagger 어노테이션에 대해 자세히 알아보려면 [Swagger 문서](https://github.com/swagger-api/swagger-core/wiki/Annotations-1.5.X)를 참조하십시오.

```java
@ApiOperation(value = "Multiple Parameter Types Example", notes = "Example of passing parameters by using 3 different methods: path parameters, headers, and form parameters. A JSON object containing all the received parameters is returned.")
@ApiResponses(value = { @ApiResponse(code = 200, message = "A JSON object containing all the received parameters returned.") })
@POST
@Produces(MediaType.APPLICATION_JSON)
@Path("/{path}")
public Map<String, String> enterInfo(
    @ApiParam(value = "The value to be passed as a path parameter", required = true) @PathParam("path") String path,
    @ApiParam(value = "The value to be passed as a header", required = true) @HeaderParam("Header") String header,
    @ApiParam(value = "The value to be passed as a form parameter", required = true) @FormParam("form") String form) {
  Map<String, String> result = new HashMap<String, String>();

  result.put("path", path);
  result.put("header", header);
  result.put("form", form);

  return result;
}
```

![Swagger UI의 다중 매개변수 엔드포인트](Multiple_Parameter.png)


{% comment %}
### {{ site.data.keys.mf_cli }} 사용
{: #using-mobilefirst-cli }

어댑터 기능을 테스트하려면 명령행에서 Java 또는 JavaScript 어댑터를 호출하기 위해 `mfpdev adapter call` 명령을 사용하십시오.
명령을 직접 또는 대화식으로 실행하도록 선택할 수 있습니다. 다음은 직접 모드를 사용하는 예입니다.

#### Java 어댑터
{: #java-adapters-adapters-cli }

**명령행** 창을 열고 다음을 실행하십시오.

```bash
mfpdev adapter call adapterName/path
```
예:

```bash
mfpdev adapter call SampleAdapter/users/World

Calling GET '/mfp/api/adapters/SampleAdapter/users/World'
Response:
Hello World
```

#### JavaScript 어댑터
{: #javascript-adapters-cli }

**명령행** 창을 열고 다음을 실행하십시오.

```bash
mfpdev adapter call adapterName/procedureName
```
예:

```bash
mfpdev adapter call SampleAdapter/getFeed

Calling GET '/mfp/api/adapters/SampleAdapter/users/World'
Response:
Hello World
```

{% endcomment %}

## 어댑터 디버깅
{: #debugging-adapters }

### JavaScript 어댑터
{: #debugging-javascript-adapters }
`MFP.Logger` API를 사용하여 JavaScrit 어댑터에서 JavaScript 코드를 디버깅할 수 있습니다.  
최소에서 최대 상세까지 사용 가능한 로깅 레벨은 `MFP.Logger.error`, `MFP.Logger.warn`, `MFP.Logger.info` 및 `MFP.Logger.debug`입니다.

그런 다음 로그는 애플리케이션 서버의 로그 파일에 인쇄됩니다.  
서버 상세 레벨이 적절히 설정되도록 하십시오. 그렇지 않으면 로그 파일에서 로깅을 볼 수 없습니다.

### Java 어댑터
{: #debugging-java-adapters }

어댑터의 Java 코드를 디버깅할 수 있으려면 먼저 Eclipse가 다음과 같이 구성되어야 합니다.

1. **Maven 통합** - Eclipse Kepler (v4.3) 시작, Maven 지원은 Eclipse에서 기본 제공됩니다.  
Eclipse 인스턴스가 Maven을 지원하지 않으면, [m2e 지침에 따라](http://www.eclipse.org/m2e/) Maven 지원을 추가하십시오.

2. Maven을 Eclipse에서 사용할 수 있으면 어댑터 Maven 프로젝트를 가져오십시오.

    ![어댑터 Maven 프로젝트를 Eclipse로 가져오는 방법을 보여주는 이미지](import-adapter-maven-project.png)

3. 디버깅 매개변수를 제공하십시오.
    - **실행** → **구성 디버그**를 클릭하십시오.
    - **원격 Java 애플리케이션**을 두 번 클릭하십시오.
    - 이 구성에 **이름**을 제공하십시오.
    - **호스트** 값을 설정하십시오. 로컬 서버를 실행 중이면 "localhost"를 사용하거나, 원격 서버 호스트 이름을 제공하십시오.
    - **포트** 값을 "10777"로 설정하십시오.
    - **찾아보기**를 클릭하고 Maven 프로젝트를 선택하십시오.
    - **디버그**를 클릭하십시오.

    ![{{ site.data.keys.mf_server }} 디버그 매개변수를 설정하는 방법을 보여주는 이미지](setting-debug-parameters.png)

4. **창 → 보기 표시 → 디버그**를 클릭하여 *디버그 모드*를 시작하십시오. 이제 표준 Java 애플리케이션에서와 마찬가지로 Java 코드를 정상적으로 디버그할 수 있습니다. 코드를 실행하고 설정된 중단점에 적중하기 위해 어댑터에 요청을 발행해야 할 수도 있습니다. [어댑터 테스트 섹션](#testing-adapters)에서 어댑터 자원 호출 방법에 대한 지시사항에 따라 이를 수행할 수 있습니다.

    ![디버그 중인 어댑터를 보여주는 이미지](debugging.png)

> Java 어댑터를 디버그하기 위해 IntelliJ를 사용하는 방법에 대한 지시사항은 [MobileFirst Java 어댑터 개발을 위해 IntelliJ 사용]({{site.baseurl}}/blog/2016/03/31/using-intellij-to-develop-adapters) 블로그 게시물을 참조하십시오.
