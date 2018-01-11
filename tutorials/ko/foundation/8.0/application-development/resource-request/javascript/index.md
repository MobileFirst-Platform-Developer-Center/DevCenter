---
layout: tutorial
title: JavaScript(Cordova, 웹) 애플리케이션의 자원 요청
breadcrumb_title: JavaScript
relevantTo: [javascript]
downloads:
  - 이름: 웹 프로젝트 다운로드
    URL: https://github.com/MobileFirst-Platform-Developer-Center/ResourceRequestWeb/tree/release80
  - 이름: Cordova 프로젝트 다운로드
    URL: https://github.com/MobileFirst-Platform-Developer-Center/ResourceRequestCordova/tree/release80
  - 이름: Adapter Maven 프로젝트 다운로드
    URL: https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
{{ site.data.keys.product_adj }} 애플리케이션은 `WLResourceRequest` REST API를 사용하여 자원에 액세스할 수 있습니다.   
REST API는 모든 어댑터 및 외부 자원에서 작동합니다. 

**전제조건**:

- Cordova 애플리케이션을 구현 중인 경우 Cordova 애플리케이션에 [{{ site.data.keys.product }} SDK를 추가](../../../application-development/sdk/cordova)했는지 확인하십시오. 
- 웹 애플리케이션을 구현 중인 경우 웹 애플리케이션에 [{{ site.data.keys.product }} SDK를 추가](../../../application-development/sdk/web)했는지 확인하십시오. 
- [어댑터 작성](../../../adapters/creating-adapters/) 방법에 대해 자세히 알아보십시오. 

## WLResourceRequest
{: #wlresourcerequest }
`WLResourceRequest` 클래스는 어댑터 또는 외부 자원에 대한 자원 요청을 처리합니다. 

`WLResourceRequest` 오브젝트를 작성하고 자원에 대한 경로 및 HTTP 메소드를 지정하십시오.   
사용 가능한 메소드는 `WLResourceRequest.GET`, `WLResourceRequest.POST`, `WLResourceRequest.PUT` 및 `WLResourceRequest.DELETE`입니다. 

```javascript
var resourceRequest = new WLResourceRequest(
    "/adapters/JavaAdapter/users",
    WLResourceRequest.GET
);
```

* **JavaScript 어댑터**의 경우 `/adapters/{AdapterName}/{procedureName}`을 사용하십시오. 
* **Java 어댑터**의 경우 `/adapters/{AdapterName}/{path}`를 사용하십시오. `path`는 Java 코드로 `@Path` 어노테이션을 정의한 방식에 따라 다릅니다. 여기에는 사용한 `@PathParam`도 포함됩니다. 
* 프로젝트 외부의 자원에 액세스하려면 외부 서버의 요구사항에 따라 전체 URL을 사용하십시오. 
* **제한시간**: 요청 제한시간(밀리초)이며 선택사항입니다. 

## 요청 보내기
{: #sending-the-request }
`.send()` 메소드를 사용하여 자원을 요청하십시오.   
`send()` 메소드는 선택적 매개변수를 사용하여 HTTP 요청에 본문을 설정할 수 있으며, 이는 JSON 오브젝트 또는 단순 문자열일 수 있습니다. 

JavaScript **약속**을 사용하여 `onSuccess` 및 `onFailure` 콜백 함수를 정의할 수 있습니다. 

```js
resourceRequest.send().then(
    onSuccess,
    onFailure
)
```

### setQueryParameter
{: #setqueryparameter }
`setQueryParameter` 메소드를 사용하여 REST 요청에 조회(URL) 매개변수를 포함시킬 수 있습니다. 

```js
resourceRequest.setQueryParameter("param1", "value1");
resourceRequest.setQueryParameter("param2", "value2");
```

#### JavaScript 어댑터
{: #javascript-adapters-setquery}
JavaScript 어댑터는 이름이 없는 정렬된 매개변수를 사용합니다. Javascript 어댑터에 매개변수를 전달하려면 `params`라는 이름을 사용하여 매개변수 배열을 설정하십시오. 

> **참고:** `params` 값은 배열의 *문자열 표시*여야 합니다. 

```js
resourceRequest.setQueryParameter("params", "['value1', 'value2']");
```

이는 `WLResourceRequest.GET`와 함께 사용해야 합니다. 

### setHeader
{: #setheader }
`setHeader` 메소드를 사용하여 새 HTTP 헤더를 설정하거나 기존 헤더를 REST 요청에 포함된 동일한 이름으로 대체할 수 있습니다. 

```js
resourceRequest.setHeader("Header-Name","value");
```

### sendFormParameters(json)
{: #sendformparamtersjson }
URL 인코딩된 양식 매개변수를 전송하려면 `sendFormParameters(json)` 메소드를 대신 사용하십시오. 이 메소드는 JSON을 URL 인코딩된 문자열로 변환하고 `content-type`을 `application/x-www-form-urlencoded`로 설정하며 이를 HTTP 본문으로 설정합니다. 

```js
var formParams = {"param1": "value1", "param2": "value2"};
resourceRequest.sendFormParameters(formParams);
```

#### JavaScript 어댑터
{: #javascript-adapters-sendform }
JavaScript 어댑터는 이름이 없는 정렬된 매개변수를 사용합니다. Javascript 어댑터에 매개변수를 전달하려면 `params`라는 이름을 사용하여 매개변수 배열을 설정하십시오. 

```js
var formParams = {"params":"['value1', 'value2']"};
```

이는 `WLResourceRequest.POST`와 함께 사용해야 합니다. 


> `WLResourceRequest`에 대한 자세한 정보는 사용자 문서의 API 참조를 참조하십시오. 

## 응답
{: #the-response }
`onSuccess` 및 `onFailure` 콜백은 둘 다 `response` 오브젝트를 수신합니다. `response` 오브젝트에는 응답 데이터가 포함되어 있으며 해당 특성을 사용하여 필수 정보를 검색할 수 있습니다. 일반적으로 사용되는 특성은 `responseText`, 응답이 JSON 형식인 경우 `responseJSON`(JSON 오브젝트) 및 `status`(응답의 HTTP 상태)입니다. 

요청이 실패하는 경우 `response` 오브젝트에는 `errorMsg` 특성도 포함됩니다.   
Java를 사용하는지 또는 JavaScript 어댑터를 사용하는지 여부에 따라 응답에는 `responseHeaders`, `responseTime`, `statusCode`, `statusReason` 및 `totalTime`과 같은 다른 특성이 포함될 수 있습니다. 

```json
{
  "responseHeaders": {
    "Content-Type": "application/json",
    "X-Powered-By": "Servlet/3.1",
    "Content-Length": "86",
    "Date": "Mon, 15 Feb 2016 21:12:08 GMT"
  },
  "status": 200,
  "responseText": "{\"height\":\"184\",\"last\":\"Doe\",\"Date\":\"1984-12-12\",\"age\":31,\"middle\":\"C\",\"first\":\"John\"}",
  "responseJSON": {
    "height": "184",
    "last": "Doe",
    "Date": "1984-12-12",
    "age": 31,
    "middle": "C",
    "first": "John"
  },
  "invocationContext": null
}
```

### 응답 처리
{: #handling-the-response }
응답 오브젝트는 `onSuccess` 및 `onFailure` 콜백 함수에 의해 수신됩니다.   
예: 

```js
onSuccess: function(response) {
    resultText = "Successfully called the resource: " + response.responseText;
},

onFailure: function(response) {
    resultText = "Failed to call the resource:" + response.errorMsg;
}
```

## 자세한 정보
{: #for-more-information }
> WLResourceRequest에 대한 자세한 정보는 [API 참조를 참조하십시오](../../../api/client-side-api/javascript/client/).

<img alt="샘플 애플리케이션 이미지" src="resource-request-success-cordova.png" style="float:right"/>
## 샘플 애플리케이션
{: #sample-applications }
**ResourceRequestWeb** 및 **ResourceRequestCordova** 프로젝트는 Java 어댑터를 사용하는 자원 요청을 보여줍니다.   
어댑터 Maven 프로젝트에는 자원 요청 호출 중에 사용되는 Java 어댑터가 포함되어 있습니다. 

Cordova 프로젝트를 [클릭하여 다운로드](https://github.com/MobileFirst-Platform-Developer-Center/ResourceRequestCordova/tree/release80)하십시오.   
웹 프로젝트를 [클릭하여 다운로드](https://github.com/MobileFirst-Platform-Developer-Center/ResourceRequestWeb/tree/release80)하십시오.   
어댑터 Maven 프로젝트를 [클릭하여 다운로드](https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80)하십시오. 

### 샘플 사용법
{: #sample-usage }
샘플의 README.md 파일에 있는 지시사항을 따르십시오. 
