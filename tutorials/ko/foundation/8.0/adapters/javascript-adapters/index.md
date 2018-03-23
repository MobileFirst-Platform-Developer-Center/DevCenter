---
layout: tutorial
title: JavaScript 어댑터
show_children: true
relevantTo: [ios,android,windows,javascript]
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }

JavaScript 어댑터는 HTTP 및 SQL 백엔드에 연결하기 위한 템플리트를 제공합니다. 일련의 서비스, 호출된 프로시저를 제공하고 모바일 앱이 AJAX 요청을 발행하여 이러한 프로시저를 호출할 수 있습니다.

**전제조건:** [Java 및 JavaScript 어댑터 작성](../creating-adapters) 학습서를 먼저 읽으십시오.

## 파일 구조
{: #file-structure }

![mvn-adapter](js-adapter-fs.png)

### adapter-resources 폴더
{: #the-adapter-resources-folder }

**adapter-resources** 폴더는 XML 구성 파일을 포함합니다. 이 구성 파일은 연결 옵션을 설명하고, 애플리케이션 또는 기타 어댑터에 제공되는 프로시저를 나열합니다.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<mfp:adapter name="JavaScriptAdapter">
    <displayName>JavaScriptAdapter</displayName>
    <description>JavaScriptAdapter</description>

    <connectivity>
        <connectionPolicy>
        ...
        </connectionPolicy>
    </connectivity>

    <procedure name="procedure1"></procedure>
    <procedure name="procedure2"></procedure>

    <property name="name" displayName="username" defaultValue="John"  />
</mfp:adapter>
```

<div class="panel-group accordion" id="terminology" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="adapter-xml">
            <h4 class="panel-title">
                <a name="click-for-adapter-xml-attributes-and-subelements" class="preventScroll" role="button" data-toggle="collapse" data-parent="#adapter-xml" data-target="#collapse-adapter-xml" aria-expanded="false" aria-controls="collapse-adapter-xml"><b>adapter.xml 속성 및 하위 요소에 대해 클릭</b></a>
            </h4>
        </div>

        <div id="collapse-adapter-xml" class="panel-collapse collapse" role="tabpanel" aria-labelledby="adapter-xml">
            <div class="panel-body">
                <ul>
                    <li><code>name</code>: <i>필수.</i> 어댑터 이름입니다. 이 이름은
{{ site.data.keys.mf_server }}
내에서 고유해야 합니다. 이름은 영숫자 문자 및 밑줄을 포함할 수 있으며 문자로 시작해야 합니다. 어댑터를 정의하고 배치한 후에는 이름을 수정할 수 없습니다.</li>
					<li><b>&lt;displayName&gt;</b>: <i>선택사항.</i> {{ site.data.keys.mf_console }}에
표시되는 어댑터의 이름입니다. 이 요소가 지정되지 않으면 이름 속성 값이 대신 사용됩니다.</li>
					<li><b>&lt;description&gt;</b>: <i>선택사항.</i> 어댑터에 대한 추가 정보입니다. {{ site.data.keys.mf_console }}에 표시됩니다.</li>
					<li><b>&lt;connectivity&gt;</b>: <i>필수.</i> 어댑터가 백엔드 애플리케이션에 연결하는 메커니즘을 정의합니다. 여기에는 &lt;connectionPolicy&gt; 하위 요소가 포함됩니다.
                        <ul>
                            <li><b>&lt;connectionPolicy&gt;</b>: <i>필수</i>. 연결 특성을 정의합니다. 이 하위 요소의 구조는
백엔드 애플리케이션의 통합 기술에 따라 다릅니다. &lt;connectionPolicy&gt;에 대한 자세한 정보는 <a href="js-http-adapter">HTTP 어댑터 &lt;connectionPolicy&gt; 요소</a> 및 <a href="js-sql-adapter">SQL 어댑터 &lt;connectionPolicy&gt; 요소</a>를 참조하십시오.</li>
                        </ul>
                    </li>
                    <li><b>&lt;procedure&gt;</b>: <i>필수.</i> 백엔드 애플리케이션에 의해 노출되는
서비스에 액세스하기 위한 프로세스를 정의합니다.
                        <ul>
                            <li><code>name</code>: <i>필수.</i> 프로시저 이름입니다. 이 이름은
어댑터 내에서 고유해야 합니다. 이름은 영숫자 문자 및 밑줄을 포함할 수 있으며 문자로 시작해야 합니다.</li>
                            <li><code>audit</code>: <i>선택사항.</i> 프로시저에 대한 호출이 감사 로그에
로그되는지 여부를 정의합니다. 유효값은 다음과 같습니다.
                                <ul>
                                    <li><code>true</code>: 프로시저에 대한 호출이 감사 로그에 기록됩니다.</li>
                                    <li><code>false</code>: 기본값입니다. 프로시저에 대한 호출이 감사 로그에 로그되지 않습니다.</li>
                                </ul>
                            </li>
                            <li><code>scope</code>: <i>선택사항.</i> 어댑터 자원 프로시저를 보호하는 보안 범위입니다. 이 범위는 간격으로 구분된 하나 이상의 범위 요소 문자열일 수 있으며, 기본 범위를 적용하는 경우에는 null일 수 있습니다. 범위 요소는 보안 검사 또는 보안 검사의 이름에 맵핑되는
키워드일 수 있습니다. 기본 범위는 <code>RegisteredClient</code>이며, 이는 예약된 {{ site.data.keys.product_adj }} 키워드입니다. 기본 범위는 자원에 액세스하는 데 액세스 토큰을 요구합니다.<br/>
								{{ site.data.keys.product_adj }} OAuth 자원 보호, 그리고 JavaScript 어댑터 자원에 대해 자원 보호를 구성하는 방법에 대한 자세한 정보는 <a href="../../authentication-and-security/#protecting-adapter-resources">어댑터 자원 보호</a>를 참조하십시오.<br/>
								<code>secured</code> 속성의 값이 <code>false</code>이면 <code>scope</code> 속성이 무시됩니다.</li>
                            <li><code>secured</code>: <i>선택사항.</i> 어댑터 프로시저가 {{ site.data.keys.product_adj }} 보안 프레임워크에 의해 보호되는지 정의합니다. 유효값은 다음과 같습니다.
                                <ul>
                                    <li><code>true</code>: 기본값입니다. 프로시저가 보호됩니다. 프로시저를 호출하려면
유효한 액세스 토큰이 필요합니다.</li>
                                    <li><code>false</code>. 프로시저가 보호되지 않습니다. 프로시저를 호출하는 데
액세스 토큰이 필요하지 않습니다. <a href="../../authentication-and-security/#unprotected-resources">보호되지 않은 자원</a>을 참조하십시오. 이 값을 설정하면 <code>scope</code> 속성이 무시됩니다.</li>
                                </ul>
                            </li>
                        </ul>
                    </li>
                    <li><b>&lt;securityCheckDefinition&gt;</b>: <i>선택사항.</i> 보안 검사 오브젝트를 정의합니다. <a href="../../authentication-and-security/creating-a-security-check">보안 검사 작성</a> 학습서에서 보안 검사에 대해 자세히 알아보십시오.</li>
        			<li><code>property</code>: <i>선택사항.</i> 사용자 정의 특성을 선언합니다. 이 학습서의 <a href="#custom-properties">사용자 정의 특성</a> 절에서 자세히 알아보십시오.</li>
                </ul>
                <br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#adapter-xml" data-target="#collapse-adapter-xml" aria-expanded="false" aria-controls="collapse-adapter-xml"><b>섹션 닫기</b></a>
            </div>
        </div>
    </div>
</div>

#### 사용자 정의 특성
{: #custom-properties }

**adapter.xml** 파일은 또한 사용자 정의 사용자 정의 특성을 포함할 수 있습니다. 어댑터 작성 동안 개발자가 지정하는 값은 어댑터를 재배치하지 않고 **{{ site.data.keys.mf_console }} → [사용자의 어댑터] → 구성 탭**에서 대체될 수 있습니다. 사용자 정의 특성은 [getPropertyValue API](#getpropertyvalue)를 사용하여 읽은 후 런타임 시 추가로 사용자 정의될 수 있습니다.

> <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> **참고:** 구성 특성 요소는 항상 &lt;procedure&gt; 요소 *아래*에 위치해야 합니다. 위의 예에서는 나중에 사용할 수 있도록 &lt;displayName&gt; 특성을 기본값으로 정의하였습니다.

&lt;property&gt; 요소는 다음 속성을 사용합니다.

- `name`: 구성 클래스에 정의된 특성의 이름입니다.
- `defaultValue`: 구성 클래스에 정의된 기본값을 대체합니다.
- `displayName`: *선택사항*, 콘솔에 표시될 친근한 이름.
- `description`: *선택사항*, 콘솔에 표시될 설명.
- `type`: *선택사항*, `integer`, `string`, `boolean` 또는 유효값의 목록과 같이 특정 유형의 특성을 확인합니다(예: `type="['1','2','3']"`).

![콘솔 특성](console-properties.png)

#### 구성 풀 및 푸시
{: #pull-and-push-configurations }

사용자 정의된 어댑터 특성은 **구성 파일 탭**에서 발견되는 어댑터 구성 파일을 사용하여 공유될 수 있습니다.  
이를 수행하기 위해서 Maven 또는 {{ site.data.keys.mf_cli }} 중 하나를 사용하여 아래 설명된 `pull` 및 `push` 명령을 사용하십시오. 공유할 특성에 대해서는 *특성에 제공된 기본값을 변경*해야 합니다.

어댑터 Maven 프로젝트의 루트 폴더에서 명령을 실행하십시오.

**Maven**  

* 구성 파일을 **풀**하려면 다음을 실행하십시오.  
  ```bash
  mvn adapter:configpull -DmfpfConfigFile=config.json
  ```

* 구성 파일을 **푸시**하려면 다음을 실행하십시오.
  ```bash
  mvn adapter:configpush -DmfpfConfigFile=config.json
  ```

**{{ site.data.keys.mf_cli }}**  

* 구성 파일을 **풀**하려면 다음을 실행하십시오.
  ```bash
  mfpdev adapter pull
  ```

* 구성 파일을 **푸시**하려면 다음을 실행하십시오.
  ```bash
  mfpdev adapter push
  ```

#### 다중 서버에 구성 푸시
{: #pushing-configurations-to-multiple-servers }

**pull** 및 **push** 명령은 다양한 DevOps 플로우를 작성하도록 도울 수 있으며 이러한 플로우에서는 사용자가 위치한 환경(DEV, QA, UAT, PRODUCTION)에 따라 어댑터에 여러 다양한 값이 필요합니다.

**Maven**  
위의 **config.json** 파일을 기본적으로 지정하는 방법을 기록하십시오. 여러 대상을 다루기 위해 여러 이름으로 파일을 작성하십시오.

**{{ site.data.keys.mf_cli }}**  
**--configFile** 또는 **-c** 플래그를 사용하여 기본값과 다른 구성 파일을 지정하십시오.

```bash
mfpdev adapter pull -c [adapterProject]/alternate_config.json
```

> `mfpdev help adapter pull/push`를 사용하여 자세히 알아보십시오.

### js 폴더
{: #the-js-folder }

이 폴더에는 **adapter.xml** 파일에 선언되는 모든 프로시저의 JavaScript 구현 파일이 포함되어 있고 JavaScript 어댑터에는 한 개의 JavaScript 파일만 포함될 수 있습니다. 또한 0개 또는 하나 이상의 XSL 파일을 포함하며, 검색된 원시 XML 데이터를 위한 변환 스키마를 포함합니다. 어댑터가 검색하는 데이터는 원시 상태로 또는 어댑터 자체에 의해 사전 처리되어 리턴될 수 있습니다. 어느 경우이든 **JSON 오브젝트**로 애플리케이션에 제공됩니다.

## JavaScript 어댑터 프로시저
{: #javascript-adapter-procedures }

프로시저는 XML로 선언되고 다음을 위해 서버 측 JavaScript로 구현됩니다.

* 어댑터 함수를 애플리케이션에 제공
* 데이터를 검색하고 조치를 수행하기 위해 백엔드 서비스 호출

**adapter.xml** 파일에 선언되는 각 프로시저는 JavaScript 파일에서 해당하는
함수가 있어야 합니다.

서버 측 JavaScript를 사용하여 프로시저는 서비스를 호출하기 전 또는 호출한 후에 데이터를 처리할 수 있습니다. 단순 XSLT 코드를 사용하여 추가 필터링을 검색된 데이터에 적용할 수 있습니다.  
JavaScript 어댑터 프로시저는 JavaScript에서 구현됩니다. 그러나 어댑터가 서버 측 엔티티이기 때문에, [어댑터 코드에서 Java를 사용](../javascript-adapters/using-java-in-javascript-adapters)하는 것이 가능합니다.

### 글로벌 변수 사용
{: #using-global-variables }

{{ site.data.keys.mf_server }}는 HTTP 세션에 의존하지 않으며 각 요청은 다른 노드에 도달할 수 있습니다. 한 요청에서 다른 요청까지 데이터를 유지하려면 글로벌 변수에 의존하면 안 됩니다.

### 어댑터 응답 임계값
{: #adapter-response-threshold }

어댑터 자원이 {{ site.data.keys.mf_server }} 메모리에
문자열로 저장되므로 어댑터 호출은 대량의 데이터를 리턴하도록 설계되지
않았습니다. 따라서 사용 가능한 메모리의 양을 초과하는 데이터는 메모리 부족 예외와 어댑터 호출 실패를
일으킬 수 있습니다. 이러한 실패를 방지하기 위해 {{ site.data.keys.mf_server }}에서 gzip으로 압축된 HTTP 응답을 리턴하는 임계값을 구성합니다. HTTP 프로토콜은 gzip 압축을 지원하기 위해 표준 헤더를 사용합니다. 또한 클라이언트 애플리케이션이
HTTP에서 gzip 컨텐츠를 지원할 수 있어야 합니다.

#### 서버 측
{: #server-side }

{{ site.data.keys.mf_console }}의 **런타임 > 설정 > 어댑터 응답에 대해 GZIP 압축 임계값** 아래에서 원하는 임계값을 설정하십시오. 기본값은 20KB입니다.  
**참고:** {{ site.data.keys.mf_console }}에 변경을 저장하면 변경이 런타임 시 즉각 적용됩니다.

#### 클라이언트 측
{: #client-side }

모든 클라이언트 요청에서 `gzip`에 `Accept-Encoding`
헤더의 값을 설정하여, 클라이언트가 gzip 응답을 구문 분석할 수 있게 하십시오.
사용자의 요청 변수와 함께 `addHeader` 메소드를 사용하십시오. 예: `request.addHeader("Accept-Encoding","gzip);`

## 서버 측 API
{: #server-side-apis }

JavaScript 어댑터는 다른 JavaScript 어댑터 호출, 서버 로그에 로깅, 구성 특성 값 획득, Analytics에 활동 보고, 요청 발행자 ID 획득과 같이 {{ site.data.keys.mf_server }}와 관련된 조작을 수행하기 위해 서버 측 Java API를 사용할 수 있습니다.  

### getPropertyValue
{: #getpropertyvalue }

**adapter.xml**에서 또는 {{ site.data.keys.mf_console }}에서 정의된 특성을 검색하려면 `MFP.Server.getPropertyValue(propertyName)`
API를 사용하십시오.

```js
MFP.Server.getPropertyValue("name");
```

### getTokenIntrospectionData
{: #gettokenintrospectiondata }

현재 사용자 ID의 사용을 얻으려면 `MFP.Server.getTokenIntrospectionData()` API를 사용하십시오.



```js
function getAuthUserId(){
   var securityContext = MFP.Server.getTokenIntrospectionData();
   var user = securityContext.getAuthenticatedUser();

   return "User ID: " + user.getId;
}
```

### getAdapterName
{: #getadaptername }

어댑터 이름을 검색하려면 `getAdapterName()` API를 사용하십시오.

### invokeHttp
{: #invokehttp }

HTTP 어댑터에서 `MFP.Server.invokeHttp(options)` API를 사용하십시오.  
[JavaScript HTTP 어댑터](js-http-adapter) 학습서에 사용법 예제를
볼 수 있습니다.

### invokeSQL
{: #invokesql }

SQL 어댑터에서 `MFP.Server.invokeSQLStatement(options)` 및 `MFP.Server.invokeSQLStoredProcedure(options)`
API를 사용하십시오.  
[JavaScript SQL 어댑터](js-sql-adapter) 학습서에 사용법 예제를
볼 수 있습니다.

### addResponseHeader
{: #addresponseheader }

응답에 새 헤더를 추가하려면 `MFP.Server.addResponseHeader(name,value)`
API를 사용하십시오.

```js
MFP.Server.addResponseHeader("Expires","Sun, 5 October 2014 18:00:00 GMT");
```
### getClientRequest
{: #getclientrequest }

어댑터 프로시저를 호출하는 데 사용된 Java HttpServletRequest 오브젝트에 대한 참조를 얻으려면 `MFP.Server.getClientRequest()`
API를 사용하십시오.

```js
var request = MFP.Server.getClientRequest();
var userAgent = request.getHeader("User-Agent");
```

### invokeProcedure
{: #invokeprocedure }

다른 JavaScript 어댑터를 호출하려면 `MFP.Server.invokeProcedure(invocationData)`를
사용하십시오.  
[고급 어댑터 사용법 및 매시업](../advanced-adapter-usage-mashup)
학습서에서 사용법 예제를 볼 수 있습니다.

### 로깅
{: #logging }

JavaScript API는 MFP.Logger 클래스를 통해 로깅 기능을 제공합니다. 여기에는 네 개의 표준 로깅 레벨에 해당하는 네 개의 함수가 포함되어 있습니다.  
자세한 정보는 [서버 측 로그 콜렉션](../server-side-log-collection) 학습서에 있습니다.

## JavaScript 어댑터 예제
{:# javascript-adapter-examples }
