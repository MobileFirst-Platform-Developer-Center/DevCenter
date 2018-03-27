---
layout: tutorial
title: iOS 애플리케이션에서 자원 요청
breadcrumb_title: iOS
relevantTo: [ios]
downloads:
  - name: Download Xcode project
    url: https://github.com/MobileFirst-Platform-Developer-Center/ResourceRequestSwift/tree/release80
  - name: Download Adapter Maven project
    url: https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
{{ site.data.keys.product_adj }} 애플리케이션은 `WLResourceRequest` REST API를 사용하여 자원에 액세스할 수 있습니다.  
REST API는 모든 어댑터 및 외부 자원에서 작동합니다.

**전제조건**:

- 고유 iOS 프로젝트에 [{{ site.data.keys.product }} SDK를 추가](../../../application-development/sdk/ios)했는지 확인하십시오.
- [어댑터 작성](../../../adapters/creating-adapters/) 방법에 대해 자세히 알아보십시오.

## WLResourceRequest
{: #wlresourcerequest }
`WLResourceRequest` 클래스는 어댑터 또는 외부 자원에 대한 자원 요청을 처리합니다.

`WLResourceRequest` 오브젝트를 작성하고 자원에 대한 경로 및 HTTP 메소드를 지정하십시오.  
사용 가능한 메소드는 `WLHttpMethodGet`, `WLHttpMethodPost`, `WLHttpMethodPut` 및 `WLHttpMethodDelete`입니다.

Objective-C

```objc
WLResourceRequest *request = [WLResourceRequest requestWithURL:[NSURL URLWithString:@"/adapters/JavaAdapter/users/"] method:WLHttpMethodGet];
```
Swift

```swift
let request = WLResourceRequest(
    URL: NSURL(string: "/adapters/JavaAdapter/users"),
    method: WLHttpMethodGet
)
```

* **JavaScript 어댑터**의 경우 `/adapters/{AdapterName}/{procedureName}`을 사용하십시오.
* **Java 어댑터**의 경우 `/adapters/{AdapterName}/{path}`를 사용하십시오. `path`는 Java 코드로 `@Path` 어노테이션을 정의한 방식에 따라 다릅니다. 여기에는 사용한 `@PathParam`도 포함됩니다.
* 프로젝트 외부의 자원에 액세스하려면 외부 서버의 요구사항에 따라 전체 URL을 사용하십시오.
* **제한시간**: 요청 제한시간(밀리초)이며 선택사항입니다.

## 요청 보내기
{: #sending-the-request }
`sendWithCompletionHandler` 메소드를 사용하여 자원을 요청하십시오.  
다음과 같이 완료 핸들러를 제공하여 검색된 데이터를 처리하십시오.

Objective-C

```objc
[request sendWithCompletionHandler:^(WLResponse *response, NSError *error) {
    if (error == nil){
        NSLog(@"%@", response.responseText);
    } else {
        NSLog(@"%@", error.description);
    }
}];
```
Swift

```swift
request.sendWithCompletionHandler { (response, error) -> Void in
    if(error == nil){
        NSLog(response.responseText)
    }
    else{
        NSLog(error.description)
    }
}
```

또는 `sendWithDelegate`를 사용하고 `NSURLConnectionDataDelegate` 및 `NSURLConnectionDelegate` 프로토콜을 둘 다 준수하는 위임을 제공할 수 있습니다. 이렇게 하면 보다 세부적인 응답을 처리할 수 있습니다(예: 2진 응답 처리).   

## 매개변수
{: #parameters }
필요한 경우 요청을 보내기 전에 매개변수를 추가할 수 있습니다.

### 경로 매개변수
{: #path-parameters }
위에서 설명한 대로 **경로** 매개변수(`/path/value1/value2`)는 `WLResourceRequest` 오브젝트 작성 중에 설정됩니다.

### 조회 매개변수
{: #query-parameters }
**조회** 매개변수(`/path?param1=value1...`)를 전송하려면 각 매개변수에 `setQueryParameter` 메소드를 사용하십시오.

Objective-C

```objc
[request setQueryParameterValue:@"value1" forName:@"param1"];
[request setQueryParameterValue:@"value2" forName:@"param2"];
```
Swift

```swift
request.setQueryParameterValue("value1", forName: "param1")
request.setQueryParameterValue("value2", forName: "param2")
```

#### JavaScript 어댑터
{: #javascript-adapters-query }
JavaScript 어댑터는 이름이 없는 정렬된 매개변수를 사용합니다. Javascript 어댑터에 매개변수를 전달하려면 `params`라는 이름을 사용하여 매개변수 배열을 설정하십시오.

Objective-C

```objc
[request setQueryParameterValue:@"['value1', 'value2']" forName:@"params"];
```

Swift

```swift
request.setQueryParameterValue("['value1', 'value2']", forName: "params")
```

이는 `WLHttpMethodGet`와 함께 사용해야 합니다.

### 양식 매개변수
{: #form-parameters }
본문에서 **양식** 매개변수를 보내려면 `sendWithCompletionHandler` 대신 `sendWithFormParameters`를 사용하십시오.

Objective-C

```objc
//@FormParam("height")
NSDictionary *formParams = @{@"height":@"175"};

//Sending the request with Form parameters
[request sendWithFormParameters:formParams completionHandler:^(WLResponse *response, NSError *error) {
    if (error == nil){
        NSLog(@"%@", response.responseText);
    } else {
        NSLog(@"%@", error.description);
    }
}];
```
Swift

```swift
//@FormParam("height")
let formParams = ["height":"175"]

//Sending the request with Form parameters
request.sendWithFormParameters(formParams) { (response, error) -> Void in
    if(error == nil){
        NSLog(response.responseText)
    }
    else{
        NSLog(error.description)
    }
}
```

#### JavaScript 어댑터
{: #javascript-adapters-form }
JavaScript 어댑터는 이름이 없는 정렬된 매개변수를 사용합니다. Javascript 어댑터에 매개변수를 전달하려면 `params`라는 이름을 사용하여 매개변수 배열을 설정하십시오.

Objective-C

```objc
NSDictionary *formParams = @{@"params":@"['value1', 'value2']"};
```
Swift

```swift
let formParams = ["params":"['value1', 'value2']"]
```

이는 `WLHttpMethodPost`와 함께 사용해야 합니다.

### 헤더 매개변수
{: #header-parameters }
매개변수를 HTTP 헤더로 보내려면 `setHeaderValue` API를 사용하십시오.

Objective-C

```objc
//@HeaderParam("Date")
[request setHeaderValue:@"2015-06-06" forName:@"birthdate"];
```
Swift

```swift
//@HeaderParam("Date")
request.setHeaderValue("2015-06-06", forName: "birthdate")
```

### 기타 사용자 정의 본문 매개변수
{: #other-custom-body-parameters }

- `sendWithBody`를 사용하여 본문에서 임의의 문자열을 설정할 수 있습니다.
- `sendWithJSON`을 사용하여 본문에서 임의의 사전을 설정할 수 있습니다.
- `sendWithData`를 사용하여 본문에서 임의의 `NSData`를 설정할 수 있습니다.

### completionHandler 및 delegate에 대한 콜백 큐
응답 수신 중 UI 차단을 방지하기 위해 API의 `sendWithCompletionHandler` 및 `sendWithDelegate` 세트에 대해 completionHandler 블록 또는 delegate를 실행하도록 개인용 콜백 큐를 지정할 수 있습니다.

#### Objective-C

```objc
//creating callback queue
dispatch_queue_t completionQueue = dispatch_queue_create("com.ibm.mfp.app.callbackQueue", DISPATCH_QUEUE_SERIAL);

//Sending the request with callback queue
[request sendWithCompletionHandler:completionQueue completionHandler:^(WLResponse *response, NSError *error) {
    if (error == nil){
        NSLog(@"%@", response.responseText);
    } else {
        NSLog(@"%@", error.description);
    }
}];
```
#### Swift

```swift
//creating callback queue
var completionQueue = dispatch_queue_create("com.ibm.mfp.app.callbackQueue", DISPATCH_QUEUE_SERIAL)

//Sending the request with callback queue
request.sendWithCompletionHandler(completionQueue) { (response, error) -> Void in
  if (error == nil){
      NSLog(@"%@", response.responseText);
  } else {
      NSLog(@"%@", error.description);
    }
}
```

## 응답
{: #the response }
`response` 오브젝트에는 응답 데이터가 포함되어 있으며 해당 메소드 및 특성을 사용하여 필수 정보를 검색할 수 있습니다. 일반적으로 사용되는 특성은 `responseText`(문자열), 응답이 JSON 형식인 경우 `responseJSON`(사전) 및 응답의 HTTP 상태인 `status`(정수)입니다.

`response` 및 `error` 오브젝트를 사용하여 어댑터에서 검색되는 데이터를 가져오십시오.

## 자세한 정보
{: #for-more-information }
> WLResourceRequest에 대한 자세한 정보는 [API 참조를 참조하십시오](../../../api/client-side-api/objc/client/).

<img alt="샘플 애플리케이션 이미지" src="resource-request-success-ios.png" style="margin-left: 15px; float:right"/>
## 샘플 애플리케이션
{: #sample-application }
ResourceRequestSwift 프로젝트에는 Swift에서 구현되며 Java 어댑터를 사용하여 자원 요청을 작성하는 iOS 애플리케이션이 포함되어 있습니다.  
어댑터 Maven 프로젝트에는 자원 요청 호출 중에 사용되는 Java 어댑터가 포함되어 있습니다.

iOS 프로젝트를 [클릭하여 다운로드](https://github.com/MobileFirst-Platform-Developer-Center/ResourceRequestSwift/tree/release80)하십시오.  
어댑터 Maven 프로젝트를 [클릭하여 다운로드](https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80)하십시오.

### 샘플 사용법
{: #sample-usage }
샘플의 README.md 파일에 있는 지시사항을 따르십시오.

#### iOS 9에 대한 참고사항:
{: #note-about-ios-9 }

> Xcode 7은 [ATS(Application Transport Security)](https://developer.apple.com/library/ios/releasenotes/General/WhatsNewIniOS/Articles/iOS9.html#//apple_ref/doc/uid/TP40016198-SW14)를 기본적으로 사용합니다. 학습서를 완료하려면 ATS를 사용 안함으로 설정하십시오([자세히 보기](http://iosdevtips.co/post/121756573323/ios-9-xcode-7-http-connect-server-error)).
>   1. Xcode에서 **[프로젝트]/info.plist 파일 → 다른 이름으로 열기 → 소스 코드**를 마우스 오른쪽 단추로 클릭하십시오.
>   2. 다음을 붙여넣으십시오.
>
```xml
>      <key>NSAppTransportSecurity</key>
>      <dict>
>            <key>NSAllowsArbitraryLoads</key>
>            <true/>
>      </dict>
```
