---
layout: tutorial
title: Xamarin 애플리케이션의 자원 요청
breadcrumb_title: Xamarin
relevantTo: [xamarin]
downloads:
  - 이름: Xamarin 프로젝트 다운로드
    URL: https://github.com/MobileFirst-Platform-Developer-Center/ResourceRequestXamarin/tree/release80
  - 이름: 어댑터 Maven 프로젝트 다운로드
    URL: https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80
weight: 5
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
{{ site.data.keys.product_full }} 애플리케이션은 `WorklightResourceRequest` REST API를 사용하여 자원에 액세스할 수 있습니다.   
REST API는 모든 어댑터 및 외부 자원에서 작동합니다. 

**전제조건**:

- {{ site.data.keys.product }} SDK를 고유 [Xamarin 애플리케이션](../../sdk/xamarin/)에 추가했는지 확인하십시오. 
- [어댑터 작성](../../../adapters/creating-adapters/) 방법에 대해 자세히 알아보십시오. 

## WLResourceRequest
{: #wlresourcerequest }
`WorklightResourceRequest` 클래스는 어댑터 또는 외부 자원에 대한 자원 요청을 처리합니다. 

`WorklightResourceRequest` 오브젝트를 작성하고 자원에 대한 경로 및 HTTP 메소드를 지정하십시오.   
사용 가능한 메소드는 `GET`, `POST`, `PUT` 및 `DELETE`입니다. 

```cs
URI adapterPath = new URI("/adapters/JavaAdapter/users",UriKind.Relative);
WorklightResourceRequest request = WorklightClient.CreateInstance.ResourceRequest(adapterPath,"GET");
```

* **JavaScript 어댑터**의 경우 `/adapters/{AdapterName}/{procedureName}`을 사용하십시오. 
* **Java 어댑터**의 경우 `/adapters/{AdapterName}/{path}`를 사용하십시오. `path`는 Java 코드로 `@Path` 어노테이션을 정의한 방식에 따라 다릅니다. 여기에는 사용한 `@PathParam`도 포함됩니다. 
* 프로젝트 외부의 자원에 액세스하려면 외부 서버의 요구사항에 따라 전체 URL을 사용하십시오. 
* **제한시간**: 요청 제한시간(밀리초)이며 선택사항입니다. 
* **범위**: 자원을 보호하는 범위를 아는 경우 선택사항입니다. 이 범위를 지정하여 요청의 효율성을 높일 수 있습니다. 

## 요청 보내기
{: #sending-the-request }
`.send()` 메소드를 사용하여 자원을 요청하십시오. 

```cs
WorklightResponse response = await request.send();
```

`WorklightResponse response` 오브젝트를 사용하여 어댑터에서 검색되는 데이터를 가져오십시오. 

`response` 오브젝트에는 응답 데이터가 포함되어 있으며 해당 메소드 및 특성을 사용하여 필수 정보를 검색할 수 있습니다. 일반적으로 사용되는 특성은 `ResponseText`, `ResponseJSON`(응답이 JSON 형식인 경우), `Success`(호출에 성공했거나 실패한 경우) 및 `HTTPStatus`(응답의 HTTP 상태)입니다. 

## 매개변수
{: #parameters }
필요한 경우 요청을 보내기 전에 매개변수를 추가할 수 있습니다. 

### 경로 매개변수
{: #path-parameters }
위에서 설명한 대로 **경로** 매개변수(`/path/value1/value2`)는 `WorklightResourceRequest` 오브젝트 작성 중에 설정됩니다. 

```cs
Uri adapterPath = new Uri("/adapters/JavaAdapter/users/value1/value2",UriKind.Relative);
WorklightResourceRequest request = WorklightClient.CreateInstance.ResourceRequest(adapterPath,"GET");
```

### 조회 매개변수
{: #query-parameters }
**조회** 매개변수(`/path?param1=value1...`)를 전송하려면 각 매개변수에 `SetQueryParameter` 메소드를 사용하십시오. 

```cs
request.SetQueryParameter("param1","value1");
request.SetQueryParameter("param2","value2");
```

#### JavaScript 어댑터
{: #javascript-adapters-query }
JavaScript 어댑터는 이름이 없는 정렬된 매개변수를 사용합니다. Javascript 어댑터에 매개변수를 전달하려면 `params`라는 이름을 사용하여 매개변수 배열을 설정하십시오. 

```cs
request.SetQueryParameter("params","['value1', 'value2']");
```

이는 `GET`과 함께 사용해야 합니다. 

### 양식 매개변수
{: #form-parameters }
본문에서 양식 매개변수를 보내려면 `.Send()` 대신 `.Send(Dictionary<string, string> formParameters)`를 사용하십시오.   

```cshrap
Dictionary<string,string> formParams = new Dictionary<string,string>();
formParams.Add("height", height.getText().toString());
request.Send(formParams);
```   

#### JavaScript 어댑터
{: #javascript-adapters-form }
JavaScript 어댑터는 이름이 없는 정렬된 매개변수를 사용합니다. Javascript 어댑터에 매개변수를 전달하려면 `params`라는 이름을 사용하여 매개변수 배열을 설정하십시오. 

```cs
formParams.Add("params","['value1', 'value2']");
```

이는 `POST`와 함께 사용해야 합니다. 

### 헤더 매개변수
{: #header-parameters }
매개변수를 HTTP 헤더로 보내려면 `.SetHeader()` API를 사용하십시오. 

```cs
System.Net.WebHeaderCollection headerCollection = new WebHeaderCollection();

headerCollection["key"] = value;

request.AddHeader(headerCollection);
```

### 기타 사용자 정의 본문 매개변수
{: #other-custom-body-parameters }
- `.Send(requestBody)`를 사용하여 본문에서 임의의 문자열을 설정할 수 있습니다. 
- `.Send(JObject json)`를 사용하여 본문에서 임의의 사전을 설정할 수 있습니다. 
- `.Send(byte[] data)`를 사용하여 본문에서 임의의 바이트 배열을 설정할 수 있습니다. 

## 응답
{: #the-response }
`WorklightResponse` 오브젝트에는 응답 데이터가 포함되어 있으며 해당 메소드 및 특성을 사용하여 필수 정보를 검색할 수 있습니다. 일반적으로 사용되는 특성은 `ResponseText`(문자열), 응답이 JSON 형식인 경우 `ResponseJSON`(JSON 오브젝트) 및 응답의 성공 상태인 `success`(부울)입니다. 

요청이 실패하는 경우 응답 오브젝트에는 `error` 특성도 포함됩니다. 

## 자세한 정보
{: #for-more-information }
> WLResourceRequest에 대한 자세한 정보는 사용자 문서를 참조하십시오.

<img alt="샘플 애플리케이션 이미지" src="resource-request-success-xamarin.png" style="float:right"/>

## 샘플 애플리케이션
{: #sample-application }
ResourceRequestXamarin 프로젝트에는 Java 어댑터를 사용하여 자원 요청을 작성하는 고유 Android 및 iOS 애플리케이션이 포함되어 있습니다.   
어댑터 Maven 프로젝트에는 자원 요청 호출 중에 사용되는 Java 어댑터가 포함되어 있습니다. 

Xamarin 프로젝트를 [클릭하여 다운로드](https://github.com/MobileFirst-Platform-Developer-Center/ResourceRequestXamarin/tree/release80)하십시오.   
어댑터 Maven 프로젝트를 [클릭하여 다운로드](https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80)하십시오. 

### 샘플 사용법
{: #sample-usage }
샘플의 README.md 파일에 있는 지시사항을 따르십시오. 
