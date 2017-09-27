---
layout: tutorial
title: 来自 Android 应用程序的资源请求
breadcrumb_title: Android
relevantTo: [android]
downloads:
  - name: 下载 Android Studio 项目
    url: https://github.com/MobileFirst-Platform-Developer-Center/ResourceRequestAndroid/tree/release80
  - name: 下载适配器 Maven 项目
    url: https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80
weight: 5
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
{{ site.data.keys.product_adj }} 应用程序可以使用 `WLResourceRequest` REST API 访问资源。  
REST API 将使用所有适配器和外部资源。

**先决条件**：

- 确保您已[添加 {{ site.data.keys.product }} SDK](../../../application-development/sdk/android) 添加到本机 Android 项目。
- 了解如何[创建适配器](../../../adapters/creating-adapters)。

## WLResourceRequest
{: #wlresourcerequest }
`WLResourceRequest` 类可处理对适配器或外部资源的资源请求。

创建 `WLResourceRequest` 对象并指定资源路径和 HTTP 方法。  
可用方法包括：`WLResourceRequest.GET`、`WLResourceRequest.POST`、`WLResourceRequest.PUT`、`WLResourceRequest.HEAD` 和 `WLResourceRequest.DELETE`。

```java
URI adapterPath = URI.create("/adapters/JavaAdapter/users");
WLResourceRequest request = new WLResourceRequest(adapterPath,WLResourceRequest.GET);
```

* 对于 **JavaScript 适配器**，请使用 `/adapters/{AdapterName}/{procedureName}`
* 对于 **Java 适配器**，请使用 `/adapters/{AdapterName}/{path}`。 `path` 取决于您如何在 Java 代码中定义 `@Path` 注释。 这也将包含您使用的任何 `@PathParam`。
* 要访问项目外面的资源，请根据外部服务器的需求使用完整 URL。
* **超时**：可选，请求超时（毫秒）
* **作用域**：可选，如果您知道哪个作用域将保护资源 - 指定此作用域可以使请求更高效。

## 发送请求
{: #sending-the-request }
使用 `.send()` 方法请求资源。 指定 WLResponseListener 类实例：

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

## 参数
{: #parameters }
在发送请求之前，您可能希望根据需要添加参数。

### 路径参数
{: #path-parameters }
如上所述，在创建 `WLResourceRequest` 对象期间设置**路径**参数 (`/path/value1/value2`)：

```java
URI adapterPath = new URI("/adapters/JavaAdapter/users/value1/value2");
WLResourceRequest request = new WLResourceRequest(adapterPath,WLResourceRequest.GET);
```

### 查询参数
{: #query-parameters }
要发送**查询**参数 (`/path?param1=value1...`)，请对每个参数使用 `setQueryParameter` 方法：

```java
request.setQueryParameter("param1","value1");
request.setQueryParameter("param2","value2");
```

#### JavaScript 适配器
{: #javascript-adapters }
JavaScript 适配器使用有序的无名参数。 要将参数传递到 JavaScript 适配器，请设置名称为 `params` 的参数数组：

```java
request.setQueryParameter("params","['value1', 'value2']");
```

这应该与 `WLResourceRequest.GET` 一起使用。

### 表单参数
{: #form-parameters }
要发送主体中的表单参数，请使用 `.send(HashMap<String, String> formParameters, WLResponseListener)` 代替 `.send(WLResponseListener)`：  

```java
HashMap formParams = new HashMap();
formParams.put("height", height.getText().toString());
request.send(formParams, new MyInvokeListener());
```    

#### 参数 - JavaScript 适配器
{: #parameters-javascript-adapters}
JavaScript 适配器使用有序的无名参数。 要将参数传递到 JavaScript 适配器，请设置名称为 `params` 的参数数组：

```java
formParams.put("params", "['value1', 'value2']");
```

这应该与 `WLResourceRequest.POST` 一起使用。

### 头参数
{: #header-parameters }
要将参数作为 HTTP 头发送，请使用 `.addHeader()` API：

```java
request.addHeader("date", date.getText().toString());
```

### 其他定制主体参数
{: #other-custom-body-parameters }
- `.send(requestBody, WLResponseListener listener)` 允许您在主体中设置任意字符串。
- `.send(JSONStore json, WLResponseListener listener)` 允许您在主体中设置任意字典。
- `.send(byte[] data, WLResponseListener listener)` 允许您在主体中设置任意字节数组。

## 响应
{: #the-response }
`response` 对象包含响应数据，并且您可以使用其方法和属性来检索必需信息。 常用属性包括：`responseText`（字符串）、`responseJSON`（JSON 对象）（如果以 JSON 格式响应）和 `status`（整数）（响应的 HTTP 状态）。

使用 `WLResponse response` 和 `WLFailResponse response` 对象获取从适配器检索的数据。

## 获取更多信息
{: #for-more-information }
> 有关 WLResourceRequest 的更多信息，请[参阅 API 参考](../../../api/client-side-api/java/client/)。

<img alt="样本应用程序的图像" src="resource-request-success-android.png" style="float:right"/>
## 样本应用程序
{: #sample-application }
ResourceRequestAndroid 项目包含一个本机 Android 应用程序，该应用程序使用 Java 适配器发出资源请求。  
适配器 Maven 项目包含在资源请求调用期间使用的 Java 适配器。

[单击以下载](https://github.com/MobileFirst-Platform-Developer-Center/ResourceRequestAndroid/tree/release80) Android 项目。  
[单击以下载](https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80)适配器 Maven 项目。

### 样本用法
{: #sample-usage }
遵循样本的 README.md 文件获取指示信息。
