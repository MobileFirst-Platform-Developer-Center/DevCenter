---
layout: tutorial
title: 来自 iOS 应用程序的资源请求
breadcrumb_title: iOS
relevantTo: [ios]
downloads:
  - name: 下载 Xcode 项目
    url: https://github.com/MobileFirst-Platform-Developer-Center/ResourceRequestSwift/tree/release80
  - name: 下载 Adapter Maven 项目
    url: https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
{{ site.data.keys.product_adj }} 应用程序可以使用 `WLResourceRequest` REST API 访问资源。  
REST API 将使用所有适配器和外部资源。

**先决条件**：

- 确保您已[将 {{ site.data.keys.product }} SDK](../../../application-development/sdk/ios) 添加到本机 iOS 项目。
- 了解如何[创建适配器](../../../adapters/creating-adapters/)。

## WLResourceRequest
{: #wlresourcerequest }
`WLResourceRequest` 类可处理对适配器或外部资源的资源请求。

创建 `WLResourceRequest` 对象并指定资源路径和 HTTP 方法。  
可用方法包括：`WLHttpMethodGet`、`WLHttpMethodPost`、`WLHttpMethodPut` 和 `WLHttpMethodDelete`。

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

* 对于 **JavaScript 适配器**，请使用 `/adapters/{AdapterName}/{procedureName}`
* 对于 **Java 适配器**，请使用 `/adapters/{AdapterName}/{path}`。`path` 取决于您如何在 Java 代码中定义 `@Path` 注释。这也将包含您使用的任何 `@PathParam`。
* 要访问项目外面的资源，请根据外部服务器的需求使用完整 URL。
* **超时**：可选，请求超时（毫秒）

## 发送请求
{: #sending-the-request }
使用 `sendWithCompletionHandler` 方法请求资源。  
提供完成处理程序来处理检索到的数据：

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

或者，您可以使用 `sendWithDelegate` 并提供遵守 `NSURLConnectionDataDelegate` 和 `NSURLConnectionDelegate` 协议的委派。这将允许您处理具有更高粒度的响应，如处理二进制响应。   

## 参数
{: #parameters }
在发送请求之前，您可能希望根据需要添加参数。

### 路径参数
{: #path-parameters }
如上所述，在创建 `WLResourceRequest` 对象期间设置**路径**参数 (`/path/value1/value2`)。

### 查询参数
{: #query-parameters }
要发送**查询**参数 (`/path?param1=value1...`)，请对每个参数使用 `setQueryParameter` 方法：

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

#### JavaScript 适配器
{: #javascript-adapters-query }
JavaScript 适配器使用有序的无名参数。要将参数传递到 JavaScript 适配器，请设置名称为 `params` 的参数数组：

Objective-C

```objc
[request setQueryParameterValue:@"['value1', 'value2']" forName:@"params"];
```

Swift

```swift
request.setQueryParameterValue("['value1', 'value2']", forName: "params")
```

这应该与 `WLHttpMethodGet` 一起使用。

### 表单参数
{: #form-parameters }
要发送主体中的**表单**参数，请使用 `sendWithFormParameters` 代替 `sendWithCompletionHandler`：

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

#### JavaScript 适配器
{: #javascript-adapters-form }
JavaScript 适配器使用有序的无名参数。要将参数传递到 JavaScript 适配器，请设置名称为 `params` 的参数数组：

Objective-C

```objc
NSDictionary *formParams = @{@"params":@"['value1', 'value2']"};
```
Swift

```swift
let formParams = ["params":"['value1', 'value2']"]
```

这应该与 `WLHttpMethodPost` 一起使用。

### 头参数
{: #header-parameters }
要将参数作为 HTTP 头发送，请使用 `setHeaderValue` API：

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

### 其他定制主体参数
{: #other-custom-body-parameters }

- `sendWithBody` 允许您在主体中设置任意字符串。
- `sendWithJSON` 允许您在主体中设置任意字典。
- `sendWithData` 允许您在主体中设置任意 `NSData`。

###  completionHandler 和 delegate 回调队列
为了避免在接收响应时阻止 UI，可以指定专用回调队列，执行 API 的 `sendWithCompletionHandler` 和 `sendWithDelegate` 集的 completionHandler 块和 delegate。

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

## 响应
{: #the response }
`response` 对象包含响应数据，并且您可以使用其方法和属性来检索必需信息。常用属性包括：`responseText`（字符串）、`responseJSON`（字典）（如果以 JSON 格式响应）和 `status`（整数）（响应的 HTTP 状态）。

使用 `response` 和 `error` 对象获取从适配器检索的数据。

## 获取更多信息
{: #for-more-information }
> 有关 WLResourceRequest 的更多信息，请[参阅 API 参考](http://www.ibm.com/support/knowledgecenter/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refobjc-worklight-ios/html/Classes/WLResourceRequest.html)。

<img alt="样本应用程序的图像" src="resource-request-success-ios.png" style="margin-left: 15px; float:right"/>
## 样本应用程序
{: #sample-application }
ResourceRequestSwift 项目包含使用 Swift 实现的 iOS 应用程序，该应用程序使用 Java 适配器发出资源请求。  
适配器 Maven 项目包含在资源请求调用期间使用的 Java 适配器。

[单击以下载](https://github.com/MobileFirst-Platform-Developer-Center/ResourceRequestSwift/tree/release80) iOS 项目。  
[单击以下载](https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80)适配器 Maven 项目。

### 样本用法
{: #sample-usage }
遵循样本的 README.md 文件以获取指示信息。

#### 关于 iOS 9 的注意事项：
{: #note-about-ios-9 }

> Xcode 7 缺省情况下会启用[应用程序传输安全性 (ATS)](https://developer.apple.com/library/ios/releasenotes/General/WhatsNewIniOS/Articles/iOS9.html#//apple_ref/doc/uid/TP40016198-SW14)。要完成教程，请禁用 ATS（[阅读更多](http://iosdevtips.co/post/121756573323/ios-9-xcode-7-http-connect-server-error)）。
>   1. 在 Xcode 中，右键单击 **[project]/info.plist 文件 → 打开方式 → 源代码**
>   2. 粘贴以下内容：
>
```xml
>      <key>NSAppTransportSecurity</key>
>      <dict>
>            <key>NSAllowsArbitraryLoads</key>
>            <true/>
>      </dict>
```
