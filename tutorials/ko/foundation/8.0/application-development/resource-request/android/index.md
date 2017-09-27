---
layout: tutorial
title: Android 애플리케이션의 자원 요청
breadcrumb_title: Android
relevantTo: [android]
downloads:
  - 이름: Android Studio 프로젝트 다운로드
    URL: https://github.com/MobileFirst-Platform-Developer-Center/ResourceRequestAndroid/tree/release80
  - 이름: Adapter Maven 프로젝트 다운로드
    URL: https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80
weight: 5
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
{{ site.data.keys.product_adj }} 애플리케이션은 `WLResourceRequest` REST API를 사용하여 자원에 액세스할 수 있습니다.   
REST API는 모든 어댑터 및 외부 자원에서 작동합니다. 

**전제조건**:

- 고유 Android 프로젝트에 [{{ site.data.keys.product }} SDK를 추가](../../../application-development/sdk/android)했는지 확인하십시오. 
- [어댑터 작성](../../../adapters/creating-adapters) 방법에 대해 자세히 알아보십시오. 

## WLResourceRequest
{: #wlresourcerequest }
`WLResourceRequest` 클래스는 어댑터 또는 외부 자원에 대한 자원 요청을 처리합니다. 

`WLResourceRequest` 오브젝트를 작성하고 자원에 대한 경로 및 HTTP 메소드를 지정하십시오.   
사용 가능한 메소드는 `WLResourceRequest.GET`, `WLResourceRequest.POST`, `WLResourceRequest.PUT`, `WLResourceRequest.HEAD` 및 `WLResourceRequest.DELETE`입니다. 

```java
URI adapterPath = URI.create("/adapters/JavaAdapter/users");
WLResourceRequest request = new WLResourceRequest(adapterPath,WLResourceRequest.GET);
```

* **JavaScript 어댑터**의 경우 `/adapters/{AdapterName}/{procedureName}`을 사용하십시오. 
* **Java 어댑터**의 경우 `/adapters/{AdapterName}/{path}`를 사용하십시오. `path`는 Java 코드로 `@Path` 어노테이션을 정의한 방식에 따라 다릅니다. 여기에는 사용한 `@PathParam`도 포함됩니다. 
* 프로젝트 외부의 자원에 액세스하려면 외부 서버의 요구사항에 따라 전체 URL을 사용하십시오. 
* **제한시간**: 요청 제한시간(밀리초)이며 선택사항입니다. 
* **범위**: 자원을 보호하는 범위를 아는 경우 선택사항입니다. 이 범위를 지정하여 요청의 효율성을 높일 수 있습니다. 

## 요청 보내기
{: #sending-the-request }
`.send()` 메소드를 사용하여 자원을 요청하십시오. WLResponseListener 클래스 인스턴스를 다음과 같이 지정하십시오. 

```java
request.send(new WLResponseListener(){
  public void onSuccess(WLResponse response) {
    Log.d("Success", response.getResponseText());
  }
  public void onFailure(WLFailResponse response) {
    Log.d("Failure", response.getResponseText());
  }
});
```

## 매개변수
{: #parameters }
필요한 경우 요청을 보내기 전에 매개변수를 추가할 수 있습니다. 

### 경로 매개변수
{: #path-parameters }
위에서 설명한 대로 **경로** 매개변수(`/path/value1/value2`)는 `WLResourceRequest` 오브젝트 작성 중에 설정됩니다. 

```java
URI adapterPath = new URI("/adapters/JavaAdapter/users/value1/value2");
WLResourceRequest request = new WLResourceRequest(adapterPath,WLResourceRequest.GET);
```

### 조회 매개변수
{: #query-parameters }
**조회** 매개변수(`/path?param1=value1...`)를 전송하려면 각 매개변수에 `setQueryParameter` 메소드를 사용하십시오. 

```java
request.setQueryParameter("param1","value1");
request.setQueryParameter("param2","value2");
```

#### JavaScript 어댑터
{: #javascript-adapters }
JavaScript 어댑터는 이름이 없는 정렬된 매개변수를 사용합니다. Javascript 어댑터에 매개변수를 전달하려면 `params`라는 이름을 사용하여 매개변수 배열을 설정하십시오. 

```java
request.setQueryParameter("params","['value1', 'value2']");
```

이는 `WLResourceRequest.GET`와 함께 사용해야 합니다. 

### 양식 매개변수
{: #form-parameters }
본문에서 양식 매개변수를 보내려면 `.send(WLResponseListener)` 대신 `.send(HashMap<String, String> formParameters, WLResponseListener)`를 사용하십시오.   

```java
HashMap formParams = new HashMap();
formParams.put("height", height.getText().toString());
request.send(formParams, new MyInvokeListener());
```    

#### 매개변수 - JavaScript 어댑터
{: #parameters-javascript-adapters}
JavaScript 어댑터는 이름이 없는 정렬된 매개변수를 사용합니다. Javascript 어댑터에 매개변수를 전달하려면 `params`라는 이름을 사용하여 매개변수 배열을 설정하십시오. 

```java
formParams.put("params", "['value1', 'value2']");
```

이는 `WLResourceRequest.POST`와 함께 사용해야 합니다. 

### 헤더 매개변수
{: #header-parameters }
매개변수를 HTTP 헤더로 보내려면 `.addHeader()` API를 사용하십시오. 

```java
request.addHeader("date", date.getText().toString());
```

### 기타 사용자 정의 본문 매개변수
{: #other-custom-body-parameters }
- `.send(requestBody, WLResponseListener listener)`를 사용하여 본문에서 임의의 문자열을 설정할 수 있습니다. 
- `.send(JSONStore json, WLResponseListener listener)`를 사용하여 본문에서 임의의 사전을 설정할 수 있습니다. 
- `.send(byte[] data, WLResponseListener listener)`를 사용하여 본문에서 임의의 바이트 배열을 설정할 수 있습니다. 

## 응답
{: #the-response }
`response` 오브젝트에는 응답 데이터가 포함되어 있으며 해당 메소드 및 특성을 사용하여 필수 정보를 검색할 수 있습니다. 일반적으로 사용되는 특성은 `responseText`(문자열), 응답이 JSON 형식인 경우 `responseJSON`(JSON 오브젝트) 및 응답의 HTTP 상태인 `status`(정수)입니다. 

`WLResponse response` 및 `WLFailResponse response` 오브젝트를 사용하여 어댑터에서 검색되는 데이터를 가져오십시오. 

## 자세한 정보
{: #for-more-information }
> WLResourceRequest에 대한 자세한 정보는 [API 참조를 참조하십시오](../../../api/client-side-api/java/client/).

<img alt="샘플 애플리케이션 이미지" src="resource-request-success-android.png" style="float:right"/>
## 샘플 애플리케이션
{: #sample-application }
ResourceRequestAndroid 프로젝트에는 Java 어댑터를 사용하여 자원 요청을 작성하는 고유 Android 애플리케이션이 포함되어 있습니다.   
어댑터 Maven 프로젝트에는 자원 요청 호출 중에 사용되는 Java 어댑터가 포함되어 있습니다. 

Android 프로젝트를 [클릭하여 다운로드](https://github.com/MobileFirst-Platform-Developer-Center/ResourceRequestAndroid/tree/release80)하십시오.   
어댑터 Maven 프로젝트를 [클릭하여 다운로드](https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80)하십시오. 

### 샘플 사용법
{: #sample-usage }
샘플의 README.md 파일에 있는 지시사항을 따르십시오. 
