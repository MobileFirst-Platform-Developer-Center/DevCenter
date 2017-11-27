---
layout: tutorial
title: JavaScript HTTP 어댑터
breadcrumb_title: HTTP 어댑터
relevantTo: [ios,android,windows,javascript]
downloads:
  - 이름: 어댑터 Maven 프로젝트 다운로드
    URL: https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }

HTTP 어댑터를 사용하여 GET 또는 POST HTTP 요청을 보내고 데이터를 응답 헤더와 본문에서 검색할 수 있습니다. HTTP 어댑터는 RESTful 및 SOAP 기반 서비스에서 작동하며 구조화된 HTTP 소스(예: RSS 피드)를 읽을 수 있습니다. 

단순한 서버 측 JavaScript 코드를 사용하여 HTTP 어댑터를 쉽게 사용자 정의할 수 있습니다. 예를 들어, 필요한 경우 서버 측 필터링을 설정할 수 있습니다. 검색된 데이터는 XML, HTML, JSON 또는 일반 텍스트 형식으로 되어 있습니다. 

어댑터는 어댑터 특성과 프로시저를 정의하기 위해 XML으로 구성됩니다.   
선택적으로 수신한 레코드와 필드를 필터링하기 위해 XSL을 사용할 수도 있습니다. 

**전제조건:** [JavaScript 어댑터](../) 학습서를 먼저 읽으십시오. 

## XML 파일
{: #the-xml-file }

XML 파일은 설정과 메타데이터를 포함합니다.   
어댑터 XML 파일을 편집하려면 다음을 수행해야 합니다.

* 프로토콜을 HTTP 또는 HTTPS로 설정하십시오.   
* HTTP 도메인을 HTTP URL의 도메인 파트로 설정하십시오.   
* TCP 포트를 설정하십시오.   

`connectivity` 요소 아래에 필수 프로시저를 선언하십시오.

```xml
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<mfp:adapter name="JavaScriptHTTP"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:mfp="http://www.ibm.com/mfp/integration"
	xmlns:http="http://www.ibm.com/mfp/integration/http">

	<displayName>JavaScriptHTTP</displayName>
	<description>JavaScriptHTTP</description>
	<connectivity>
		<connectionPolicy xsi:type="http:HTTPConnectionPolicyType">
			<protocol>https</protocol>
			<domain>mobilefirstplatform.ibmcloud.com</domain>
			<port>443</port>
			<connectionTimeoutInMilliseconds>30000</connectionTimeoutInMilliseconds>
			<socketTimeoutInMilliseconds>30000</socketTimeoutInMilliseconds>
			<maxConcurrentConnectionsPerNode>50</maxConcurrentConnectionsPerNode>
		</connectionPolicy>
	</connectivity>

	<procedure name="getFeed"/>
	<procedure name="getFeedFiltered"/>
</mfp:adapter>
```

<div class="panel-group accordion" id="terminology" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="adapter-xml">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#adapter-xml" data-target="#collapse-adapter-xml" aria-expanded="false" aria-controls="collapse-adapter-xml"><b><code>connectionPolicy</code> 속성 및 하위 요소에 대해 클릭</b></a>
</h4>
        </div>

        <div id="collapse-adapter-xml" class="panel-collapse collapse" role="tabpanel" aria-labelledby="adapter-xml">
            <div class="panel-body">
                <ul>
                    <li><b>xsi:type</b>: <i>필수.</i> 이 속성 값은 http:HTTPConnectionPolicyType이어야 합니다.</li>
                    <li><b>cookiePolicy</b>: <i>선택사항.</i> 이 속성은 백엔드 애플리케이션에서 도착하는 쿠키를 HTTP 어댑터에서 처리하는 방법을 설정합니다. 올바른 값은 다음과 같습니다.
                            <ul>
                            <li>BEST_MATCH: 기본값</li>
                            <li>BROWSER_COMPATIBILITY</li>
                            <li>RFC_2109</li>
                            <li>RFC_2965</li>
                            <li>NETSCAPE</li>
                            <li>IGNORE_COOKIES</li>
                        </ul>
                        이러한 값에 대한 자세한 정보는 Apache <a href="http://hc.apache.org/httpclient-3.x/cookies.html">HTTP 구성요소</a> 페이지를 참조하십시오. </li>
                    <li><b>maxRedirects</b>: <i>선택사항.</i> HTTP 어댑터가 따를 수 있는 최대 경로 재지정 수입니다. 이 속성은 인증 실패와 같은 몇 가지 오류로 인해 백엔드 애플리케이션이 순환 경로 재지정을 전송할 때 유용합니다. 이 속성이 0으로 설정되면, 어댑터는 경로 재지정을 따르려고 전혀 시도하지 않고 HTTP 302 응답이 사용자에게 리턴됩니다. 기본값은 10입니다. </li>
                    <li><b>protocol</b>: <i>선택사항.</i> 사용할 URL 프로토콜입니다. 유효값은 다음과 같습니다. <b>http</b>(기본값), <b>https</b>. </li>
                    <li><b>domain</b>: <i>필수.</i> 호스트 주소입니다.</li>
                    <li><b>port</b>: <i>선택사항.</i> 포트 주소입니다. 포트가 지정되지 않으면 기본 HTTP/S 포트가 사용됩니다(80/443). </li>
                    <li><b>sslCertificateAlias</b>: 정규 HTTP 인증 및 단순 SSL 인증의 경우 선택적입니다. 상호 SSL 인증의 경우 필수입니다. 어댑터 개인용 SSL 키의 별명으로, 키 저장소의 올바른 SSL 인증서에 액세스하기 위해 HTTP 어댑터 키 관리자가 사용합니다. 키 저장소 설정 프로세스에 대한 자세한 정보는 <a href="using-ssl">HTTP 어댑터에서 SSL 사용</a> 학습서를 참조하십시오. </li>
                    <li><b>sslCertificatePassword</b>: 정규 HTTP 인증 및 단순 SSL 인증의 경우선택적입니다. 상호 SSL 인증의 경우 필수입니다. 어댑터 개인용 SSL 키의 비밀번호로, 키 저장소의 올바른 SSL 인증서에 액세스하기 위해 HTTP 어댑터 키 관리자가 사용합니다. 키 저장소 설정 프로세스에 대한 자세한 정보는 <a href="using-ssl">HTTP 어댑터에서 SSL 사용</a> 학습서를 참조하십시오. </li>
                    <li><b>authentication</b>: <i>선택사항.</i> HTTP 어댑터의 인증 구성입니다. HTTP 어댑터는 두 가지 인증 프로토콜 중 하나를 사용할 수 있습니다. 다음과 같이, <b>authentication</b>< 요소를 정의하십시오. <ul>
                            <li>Basic authentication
{% highlight xml %}
<authentication>
    <basic/>
</authentication>
{% endhighlight %}</li>
                            <li>Digest authentication
{% highlight xml %}
<authentication>
    <digest/>
</authentication>
{% endhighlight %}</li>


                            연결 정책은 <code>serverIdentity</code> 요소를 포함할 수 있습니다. 이 기능은 모든 인증 스키마에 적용됩니다. 예:
{% highlight xml %}
<authentication>
    <basic/>
    <serverIdentity>
        <username></username>
        <password></password>
    </serverIdentity>
</authentication>
{% endhighlight %}
                        </ul>
                    </li>
                    <li><b>proxy</b>: <i>선택사항.</i> proxy 요소는 백엔드 애플리케이션에 액세스할 때 사용하는 프록시 서버의 세부사항을 지정합니다. 프록시 세부사항에는 프로토콜 도메인 및 포트가 포함되어야 합니다. 프록시에서 인증이 필요한 경우 <code>proxy</code> 안에 중첩된 <code>authentication</code> 요소를 추가하십시오. 이 요소는 어댑터의 인증 프로토콜을 기술할 때 사용한 것과 구조가 동일합니다. 다음 예제는 기본 인증을 요구하고, 서버 ID를 사용하는 프록시를 보여줍니다.

{% highlight xml %}
<connectionPolicy xsi:type="http:HTTPConnectionPolicyType">
  <protocol>http</protocol>
  <domain>www.bbc.co.uk</domain>
  <proxy>
    <protocol>http</protocol>
    <domain>wl-proxy</domain>
    <port>8167</port>
    <authentication>
      <basic/>
      <serverIdentity>
        <username>${proxy.user}</username>
        <password>${proxy.password}</password>
      </serverIdentity>
    </authentication>
  </proxy>
</connectionPolicy>
{% endhighlight %}</li>
                    <li><b>maxConcurrentConnectionsPerNode</b>: <i>선택사항.</i> {{ site.data.keys.mf_server }}가 백엔드에 대해 열 수 있는 최대 동시 연결 수를 정의합니다. {{ site.data.keys.product }}는 애플리케이션으로부터의 수신 서비스 요청 수는 제한하지 않습니다. 이는 백엔드 서비스에 대한 동시 HTTP 연결 수만 제한합니다.

<br/><br/>
                    동시 HTTP 연결 수의 기본값은 50입니다. 백엔드 서비스에서 허용된 최대 요청 수 및 어댑터에 대한 예상 동시 요청 수를 기반으로 이 기본값을 변경할 수 있습니다. 또한 수신되는 동시 요청 수를 제한하기 위해 백엔드 서비스를 구성할 수도 있습니다. <br/><br/>
                    2-노드 시스템이 있으며 이 시스템에 100개의 동시 요청이 로드될 것으로 예상되고 백엔드 서비스가 지원할 수 있는 동시 요청 수는 최대 80개라고 가정합니다. maxConcurrentConnectionsPerNode를 40으로 설정할 수 있습니다. 이 설정은 백엔드 서비스에 대한 동시 요청이 최대 80개가 넘지 않게 해줍니다. <br/><br/>
                    값을 늘리면 백엔드 애플리케이션에 더 많은 메모리가 필요합니다. 메모리 문제를 피하려면 너무 높은 값을 설정하지 마십시오. 그 대신, 초당 평균 및 최대 트랜잭션 수를
예측하고 해당 평균 지속기간을 평가하십시오. 그리고 나서, 이 예에 표시된 대로
필요한 동시 연결 수를 계산하고 5-10% 여분을 추가하십시오. 그런 다음, 백엔드를
모니터하고 이 값을 필요에 따라 조정하여 백엔드 애플리케이션이 모든 수신 요청을
처리할 수 있도록 하십시오.<br/><br/>
                    어댑터를 클러스터에 배치하는 경우, 이 속성 값을 클러스터 구성원 수로 나눈 최대 필수 로드 값으로 설정하십시오.
                    <br/><br/>
백엔드 애플리케이션 크기 조정 방법에 대한 자세한 정보는 <a href="{{site.baseurl}}/learn-more">확장성 및 하드웨어 크기 조정 문서</a> 및 첨부된 하드웨어 계산기 스프레드시트를 참조하십시오. </li>
                    <li><b>connectionTimeoutInMilliseconds</b>: <i>선택사항.</i> 백엔드 연결까지의 제한시간을 설정할 수 있습니다. 이 제한시간을 설정하는 것은 HTTP 요청 호출 뒤에 특정시간이 경과한 후 제한시간 예외가 발생하는 것을 보장하지 않습니다. <code>invokeHTTP()</code> 함수에서 이 매개변수에 다른 값을 전달하면 여기에서 정의된 값을 대체할 수 있습니다.</li>
                    <li><b>socketTimeoutInMilliseconds</b>: <i>선택사항.</i> 연결 패킷에서 시작하여 2개의 연속 패킷 사이의 제한시간(밀리초). 이 제한시간을 설정하는 것은 HTTP 요청 호출 뒤에 특정시간이 경과한 후 제한시간 예외가 발생하는 것을 보장하지 않습니다. <code>invokeHttp()</code> 함수에서 <code>socketTimeoutInMilliseconds</code> 매개변수에 다른 값을 전달하면 여기에서 정의된 값을 대체할 수 있습니다.</li>
                </ul>
                <br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#adapter-xml" data-target="#collapse-adapter-xml" aria-expanded="false" aria-controls="collapse-adapter-xml"><b>섹션 닫기</b></a>
            </div>
        </div>
    </div>
</div>


## JavaScript 구현
{: #javascript-implementation }

서비스 URL이 프로시저 호출에 사용됩니다. URL의 일부 파트는 상수입니다(예: http://example.com/).   
URL의 다른 파트는 매개변수화될 수 있습니다. 즉, 프로시저에 제공되는 매개변수값에 의해 런타임 시 대체될 수 있습니다. 

다음 URL 파트는 매개변수화될 수 있습니다. 

* 경로 요소
* 조회 문자열 매개변수
* 단편

HTTP 요청을 호출하려면 `MFP.Server.invokeHttp` 메소드를
사용하십시오.   
지정할 입력 매개변수 오브젝트를 제공하십시오.

* HTTP 메소드: `GET`, `POST`, `PUT`, `DELETE`
* 리턴되는 컨텐츠 유형: `XML`, `JSON`, `HTML`
또는 `plain`
* 서비스 `path`
* 조회 매개변수(선택사항)
* 요청 본문(선택사항)
* 변환 유형(선택사항)

```js
function getFeed() {
  var input = {
      method : 'get',
      returnedContentType : 'xml',
      path : "feed.xml"
  };


  return MFP.Server.invokeHttp(input);
}
```

> 옵션의 전체 목록은 사용자 문서에서 "MFP.Server.invokeHttp"에 대해 API 참조서를 참조하십시오. 

## XSL
변환 필터링
{: #xsl-transformation-filtering }

또한 예를 들어 데이터를 필터링하기 위해 XSL 변환을 수신 데이터에 적용할 수 있습니다.   
XSL 변환을 적용하려면 JavaScript 구현 파일의 옆에 **filtered.xsl**
파일을 작성하십시오. 

그런 다음 프로시저 호출의 입력 매개변수에서 변환 옵션을 지정할 수 있습니다. 예: 

```js
function getFeedFiltered() {

  var input = {
      method : 'get',
      returnedContentType : 'xml',
      path : "feed.xml",
      transformation : {
        type : 'xslFile',
        xslFile : 'filtered.xsl'
      }
  };

  return MFP.Server.invokeHttp(input);
}
```

## SOAP 기반 서비스 요청 작성
{: #creating-a-soap-based-service-request }

`MFP.Server.invokeHttp` API 메소드를 사용하여 **SOAP**
엔벨로프를 작성할 수 있습니다.   
참고: JavaScript HTTP 어댑터에서 SOAP 기반 서비스를 호출하기 위해 **E4X**를 사용하여 요청 본문 내 SOAP XML 엔벨로프를 암호화할 수 있습니다. 

```js
var request =
		<soap:Envelope
      xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
      xmlns:xsd="http://www.w3.org/2001/XMLSchema"
      xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
			<soap:Body>
				<GetCitiesByCountry xmlns="http://www.webserviceX.NET">
					<CountryName>{countryName}</CountryName>
				</GetCitiesByCountry>
			</soap:Body>
		</soap:Envelope>;
```

그런 다음 `MFP.Server.invokeHttp(options)` 메소드는 SOAP 서비스에 대한
요청을 호출하는 데 사용됩니다.   
Options 오브젝트는 다음 특성을 포함해야 합니다.

* `method` 특성: 일반적으로 `POST`
* `returnedContentType` 특성: 일반적으로 `XML`
* `path` 특성: 서비스 경로
* `body` 특성: `content`(문자열로서의 SOAP XML) 및
`contentType`

```js
var input = {
      method: 'post',
	returnedContentType: 'xml',
	path: '/globalweather.asmx',
	body: {
		content: request.toString(),
		contentType: 'text/xml; charset=utf-8'
	}
};

var result = MFP.Server.invokeHttp(input);
```

## SOAP 기반 서비스의 호출 결과
{: #invoking-results-of-soap-based-service }

결과는 `JSON` 오브젝트로 랩핑됩니다. 

```json
{
	"statusCode" : 200,
	"errors" : [],
	"isSuccessful" : true,
	"statusReason" : "OK",
	"Envelope" : {
		"Body" : {
			"GetWeatherResponse" : {
				"xmlns" : "http://www.webserviceX.NET",
				"GetWeatherResult" : "<?xml version=\"1.0\" encoding=\"utf-16\"?>\n<CurrentWeather>\n  <Location>Shanghai / Hongqiao, China (ZSSS) 31-10N 121-26E 3M</Location>\n  <Time>Mar 07, 2016 - 01:30 AM EST / 2016.03.07 0630 UTC</Time>\n  <Wind> from the W (270 degrees) at 4 MPH (4 KT) (direction variable):0</Wind>\n  <Visibility> 4 mile(s):0</Visibility>\n  <Temperature> 69 F (21 C)</Temperature>\n  <DewPoint> 53 F (12 C)</DewPoint>\n  <RelativeHumidity> 56%</RelativeHumidity>\n  <Pressure> 29.94 in. Hg (1014 hPa)</Pressure>\n  <Status>Success</Status>\n</CurrentWeather>"
			}
		},
		"xsd" : "http://www.w3.org/2001/XMLSchema",
		"soap" : "http://schemas.xmlsoap.org/soap/envelope/",
		"xsi" : "http://www.w3.org/2001/XMLSchema-instance"
	},
	"responseHeaders" : {
		"X-AspNet-Version" : "4.0.30319",
		"Date" : "Mon, 07 Mar 2016 06:46:08 GMT",
		"Content-Length" : "1027",
		"Content-Type" : "text/xml; charset=utf-8",
		"Server" : "Microsoft-IIS/7.0",
		"X-Powered-By" : "ASP.NET",
		"Cache-Control" : "private, max-age=0",
		"X-RBT-Optimized-By" : "e8i-wx-sh4 (RiOS 8.6.2d-ibm1) SC"
	},
	"warnings" : [],
	"totalTime" : 654,
	"responseTime" : 651,
	"info" : []
}
```

`Envelope` 특성을 참고하십시오. 이 특성은 SOAP 기반 요청에 특정합니다.   
`Envelope` 특성은 SOAP 기반 요청의 결과 컨텐츠를 포함합니다. 

XML 컨텐츠에 액세스하려면 다음을 수행하십시오. 

* 클라이언트 측에서 jQuery는 결과 문자열을 랩핑하는 데 사용될 수 있으며 DOM 노드를 따를 수 있습니다. 

```javascript
var resourceRequest = new WLResourceRequest(
    "/adapters/JavaScriptSOAP/getWeatherInfo",
    WLResourceRequest.GET
);

resourceRequest.setQueryParameter("params", "['Washington', 'United States']");

resourceRequest.send().then(
    function(response) {
        var $result = $(response.invocationResult.Envelope.Body.GetWeatherResponse.GetWeatherResult);
		var weatherInfo = {
			location: $result.find('Location').text(),
			time: $result.find('Time').text(),
			wind: $result.find('Wind').text(),
			temperature: $result.find('Temperature').text(),
		};
    },
    function() {
        // ...
    }
)
```
* 서버 측에서 결과 문자열로 XML 오브젝트를 작성하십시오. 그런 다음 노드는 특성으로 액세스될 수 있습니다.

```javascript
var xmlDoc = new XML(result.Envelope.Body.GetWeatherResponse.GetWeatherResult);
var weatherInfo = {
	Location: xmlDoc.Location.toString(),
	Time: xmlDoc.Time.toString(),
	Wind: xmlDoc.Wind.toString(),
	Temperature: xmlDoc.Temperature.toString()
};
```

## 샘플 어댑터
{: #sample-adapter }

어댑터 Maven 프로젝트를 [다운로드하려면 클릭](https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80/)하십시오. 

### 샘플 사용법
{: #sample-usage }

* [JavaScriptHTTP 어댑터를 빌드 및 배치](../../creating-adapters/)하기 위해 Maven, {{ site.data.keys.mf_cli }} 또는 선택한 IDE를 사용하십시오. 
* 어댑터를 테스트하거나 디버깅하려면 [어댑터 테스트 및 디버깅](../../testing-and-debugging-adapters) 학습서를 참조하십시오. 
