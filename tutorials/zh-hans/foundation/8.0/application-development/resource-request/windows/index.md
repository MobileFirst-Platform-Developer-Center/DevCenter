---
layout: tutorial
title: 来自 Windows 应用程序的资源请求
breadcrumb_title: Windows
relevantTo: [windows]
downloads:
  - name: Download Native Windows 8 project
    url: https://github.com/MobileFirst-Platform-Developer-Center/ResourceRequestWin8/tree/release80
  - name: Download Native Windows 10 project
    url: https://github.com/MobileFirst-Platform-Developer-Center/ResourceRequestWin10/tree/release80
  - name: Download Adapter Maven project
    url: https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
{{ site.data.keys.mf_console }} 应用程序可以使用 `WorklightResourceRequest` RESTAPI 访问资源。  
REST API 将使用所有适配器和外部资源。

**先决条件**：

- 确保您已将 {{ site.data.keys.product }} SDK 添加到本机 [Windows 8.1 Universal 或 Windows 10 UWP](../../../application-development/sdk/windows-8-10)。
- 了解如何[创建适配器](../../../adapters/creating-adapters/)。

## WLResourceRequest
{: #wlresourcerequest }
`WorklightResourceRequest` 类可处理对适配器或外部资源的资源请求。

创建 `WorklightResourceRequest` 对象并指定资源路径和 HTTP 方法。  
可用方法包括：`GET`、`POST`、`PUT` 和 `DELETE`。

```cs
URI adapterPath = new URI("/adapters/JavaAdapter/users",UriKind.Relative);
WorklightResourceRequest request = WorklightClient.ResourceRequest(adapterPath,"GET");
```

* 对于 **JavaScript 适配器**，请使用 `/adapters/{AdapterName}/{procedureName}`
* 对于 **Java 适配器**，请使用 `/adapters/{AdapterName}/{path}`。 `path` 取决于您如何在 Java 代码中定义 `@Path` 注释。 这也将包含您使用的任何 `@PathParam`。
* 要访问项目外面的资源，请根据外部服务器的需求使用完整 URL。
* **超时**：可选，请求超时（毫秒）
* **作用域**：可选，如果您知道哪个作用域将保护资源 - 指定此作用域可以使请求更高效。

## 发送请求
{: #sending-the-request }
使用 `.send()` 方法请求资源。

```cs
WorklightResponse response = await request.send();
```

使用 `WorklightResponse response` 对象获取从适配器检索的数据。

`response` 对象包含响应数据，并且您可以使用其方法和属性来检索必需信息。 常用属性包括：`ResponseText`、`ResponseJSON`（如果以 JSON 格式响应）、`Success`（调用成功还是失败）和 `HTTPStatus`（响应的 HTTP 状态）。

## 参数
{: #parameters }
在发送请求之前，您可能希望根据需要添加参数。

### 路径参数
{: #path-parameters }
如上所述，在创建 `WorklightResourceRequest` 对象期间设置**路径**参数 (`/path/value1/value2`)：

```cs
Uri adapterPath = new Uri("/adapters/JavaAdapter/users/value1/value2",UriKind.Relative);
WorklightResourceRequest request = WorklightClient.createInstance(adapterPath,"GET");
```

### 查询参数
{: #query-parameters }
要发送**查询**参数 (`/path?param1=value1...`)，请对每个参数使用 `SetQueryParameter` 方法：

```cs
request.SetQueryParameter("param1","value1");
request.SetQueryParameter("param2","value2");
```

#### JavaScript 适配器
{: #javascript-adapters-query }
JavaScript 适配器使用有序的无名参数。 要将参数传递到 JavaScript 适配器，请设置名称为 `params` 的参数数组：

```cs
request.SetQueryParameter("params","['value1', 'value2']");
```

这应该与 `GET` 一起使用。

### 表单参数
{: #form-parameters }
要发送主体中的表单参数，请使用 `.Send(Dictionary<string, string> formParameters)` 代替 `.Send()`：  

```cs
Dictionary<string,string> formParams = new Dictionary<string,string>();
formParams.Add("height", height.getText().toString());
request.Send(formParams);
```   

#### JavaScript 适配器
JavaScript 适配器使用有序的无名参数。 要将参数传递到 JavaScript 适配器，请设置名称为 `params` 的参数数组：

```cs
formParams.Add("params","['value1', 'value2']");
```

这应该与 `POST` 一起使用。

### 头参数
{: #header-parameters }
要将参数作为 HTTP 头发送，请使用 `.SetHeader()` API：

```cs
request.SetHeader(KeyValuePair<string,string> header);
```

### 其他定制主体参数
{: #other-custom-body-parameters }
- `.Send(requestBody)` 允许您在主体中设置任意字符串。
- `.Send(JObject json)` 允许您在主体中设置任意字典。
- `.Send(byte[] data)` 允许您在主体中设置任意字节数组。

## 响应
{: #the-response }
`WorklightResponse` 对象包含响应数据，并且您可以使用其方法和属性来检索必需信息。 常用属性包括：`ResponseText`（字符串）、`ResponseJSON` (JSONObject)（如果以 JSON 格式响应）和 `success`（布尔）（响应的成功状态）。

在请求失败情况下，response 对象还包含 `error` 属性。

## 获取更多信息
{: #for-more-information }
> 有关 WLResourceRequest 的更多信息，请[参阅 API 参考](http://public.dhe.ibm.com/software/products/en/MobileFirstPlatform/docs/v800/mfpf_csharp_win8_native_client_api.pdf) (http://public.dhe.ibm.com/software/products/en/MobileFirstPlatform/docs/v800/mfpf_csharp_win8_native_client_api.pdf)。

<img alt="样本应用程序的图像" src="resource-request-success-win8-10.png" style="float:right"/>
## 样本应用程序
{: #sample-application }
ResourceRequestWin8 和 ResourceRequestWin10 项目包含一个本机 Windows 8 Universal/Windows 10 UWP 应用程序，该应用程序使用 Java 适配器发出资源请求。  
适配器 Maven 项目包含在资源请求调用期间使用的 Java 适配器。

[单击以下载](https://github.com/MobileFirst-Platform-Developer-Center/ResourceRequestWin8/tree/release80) Windows 8.1 Universal 项目。  
[单击以下载](https://github.com/MobileFirst-Platform-Developer-Center/ResourceRequestWin10/tree/release80) Windows 10 UWP 项目。  
[单击以下载](https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80)适配器 Maven 项目。

### 样本用法
{: #sample-usage }
遵循样本的 README.md 文件获取指示信息。
