---
layout: tutorial
title: 来自 JavaScript（Cordova 或 Web）应用程序的资源请求
breadcrumb_title: JavaScript
relevantTo: [javascript]
downloads:
  - name: 下载 Web 项目
    url: https://github.com/MobileFirst-Platform-Developer-Center/ResourceRequestWeb/tree/release80
  - name: 下载 Cordova 项目
    url: https://github.com/MobileFirst-Platform-Developer-Center/ResourceRequestCordova/tree/release80
  - name: 下载适配器 Maven 项目
    url: https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
{{ site.data.keys.product_adj }} 应用程序可以使用 `WLResourceRequest` REST API 访问资源。  
REST API 将使用所有适配器和外部资源。

**先决条件**：

- 如果要实现 Cordova 应用程序，请确保已[将 {{ site.data.keys.product }} SDK](../../../application-development/sdk/cordova) 添加到您的 Cordova 应用程序。
- 如果要实现 Web 应用程序，请确保已[将 {{ site.data.keys.product }} SDK](../../../application-development/sdk/web) 添加到您的 Web 应用程序。
- 了解如何[创建适配器](../../../adapters/creating-adapters/)。

## WLResourceRequest
{: #wlresourcerequest }
`WLResourceRequest` 类可处理对适配器或外部资源的资源请求。

创建 `WLResourceRequest` 对象并指定资源路径和 HTTP 方法。  
可用方法包括：`WLResourceRequest.GET`、`WLResourceRequest.POST`、`WLResourceRequest.PUT` 和 `WLResourceRequest.DELETE`。

```javascript
var resourceRequest = new WLResourceRequest(
    "/adapters/JavaAdapter/users",
    WLResourceRequest.GET
);
```

* 对于 **JavaScript 适配器**，请使用 `/adapters/{AdapterName}/{procedureName}`
* 对于 **Java 适配器**，请使用 `/adapters/{AdapterName}/{path}`。`path` 取决于您如何在 Java 代码中定义 `@Path` 注释。这也将包含您使用的任何 `@PathParam`。
* 要访问项目外面的资源，请根据外部服务器的需求使用完整 URL。
* **超时**：可选，请求超时（毫秒）

## 发送请求
{: #sending-the-request }
使用 `send()` 方法请求资源。  
`send()` 方法将采用可选参数来设置 HTTP 请求主体，可能是 JSON 对象或简单字符串。

通过使用 JavaScript **promises**，您可以定义 `onSuccess` 和 `onFailure` 回调函数。

```js
resourceRequest.send().then(
    onSuccess,
    onFailure
)
```

### setQueryParameter
{: #setqueryparameter }
通过使用 `setQueryParameter` 方法，您可以在 REST 请求中包含查询 (URL) 参数。

```js
resourceRequest.setQueryParameter("param1", "value1");
resourceRequest.setQueryParameter("param2", "value2");
```

#### JavaScript 适配器
{: #javascript-adapters-setquery}
JavaScript 适配器使用有序的无名参数。要将参数传递到 JavaScript 适配器，请设置名称为 `params` 的参数数组：

> **注：**`params` 值应该是数组的*字符串表示*。

```js
resourceRequest.setQueryParameter("params", "['value1', 'value2']");
```

这应该与 `WLResourceRequest.GET` 一起使用。

### setHeader
{: #setheader }
通过使用 `setHeader` 方法，您可以设置新的 HTTP 头，或者将现有头替换为 REST 请求中的相同名称。

```js
resourceRequest.setHeader("Header-Name","value");
```

### sendFormParameters(json)
{: #sendformparamtersjson }
要发送 URL 编码的表单参数，请改用 `sendFormParameters(json)` 方法。此方法会将 JSON 转换为 URL 编码的字符串，请将 `content-type` 设置为 `application/x-www-form-urlencoded`，然后将其设置为 HTTP 主体：

```js
var formParams = {"param1": "value1", "param2": "value2"};
resourceRequest.sendFormParameters(formParams);
```

#### JavaScript 适配器
{: #javascript-adapters-sendform }
JavaScript 适配器使用有序的无名参数。要将参数传递到 JavaScript 适配器，请设置名称为 `params` 的参数数组：

```js
var formParams = {"params":"['value1', 'value2']"};
```

这应该与 `WLResourceRequest.POST` 一起使用。


> 有关 `WLResourceRequest` 的更多信息，请参阅用户文档中的 API 参考。

## 响应
{: #the-response }
`onSuccess` 和 `onFailure` 回调将收到 `response` 对象。`response` 对象包含响应数据，并且您可以使用其属性来检索必需信息。常用属性包括：`responseText`、`responseJSON`（JSON 对象，如果以 JSON 格式响应）和 `status`（响应的 HTTP 状态）。

在请求失败情况下，`response` 对象还包含 `errorMsg` 属性。  
根据使用 Java 还是 JavaScript 适配器，响应可能包含其他属性，如 `responseHeaders`、`responseTime`、`statusCode`、`statusReason` 和 `totalTime`。

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

### 处理响应
{: #handling-the-response }
通过 `onSuccess` 和 `onFailure` 回调函数来检索响应对象。  
例如：

```js
onSuccess: function(response) {
    resultText = "Successfully called the resource: " + response.responseText;
},

onFailure: function(response) {
    resultText = "Failed to call the resource:" + response.errorMsg;
}
```

## 获取更多信息
{: #for-more-information }
> 有关 WLResourceRequest 的更多信息，请[参阅 API 参考](http://www.ibm.com/support/knowledgecenter/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WLResourceRequest.html)。

<img alt="样本应用程序的图像" src="resource-request-success-cordova.png" style="float:right"/>
## 样本应用程序
{: #sample-applications }
**ResourceRequestWeb** 和 **ResourceRequestCordova** 项目将使用 Java 适配器演示资源请求。  
适配器 Maven 项目包含在资源请求调用期间使用的 Java 适配器。

[单击以下载](https://github.com/MobileFirst-Platform-Developer-Center/ResourceRequestCordova/tree/release80) Cordova 项目。  
[单击以下载](https://github.com/MobileFirst-Platform-Developer-Center/ResourceRequestWeb/tree/release80) Web 项目。  
[单击以下载](https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80)适配器 Maven 项目。

### 样本用法
{: #sample-usage }
遵循样本的 README.md 文件获取指示信息。
