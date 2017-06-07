---
layout: tutorial
title: JavaScript HTTP 适配器
breadcrumb_title: HTTP 适配器
relevantTo: [ios,android,windows,javascript]
downloads:
  - name: 下载适配器 Maven 项目
    url: https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }

通过 HTTP 适配器，您可以发送 GET 或 POST HTTP 请求，并从响应头或主体检索数据。HTTP 适配器与 RESTful 和基于 SOAP 的服务一起使用，可以读取结构化的 HTTP 源（例如 RSS 订阅源）。

您可以通过简单的服务器端 JavaScript 代码来轻松定制 HTTP 适配器。例如，您可以根据需要设置服务器端过滤。检索的数据可以为 XML、HTML、JSON 或纯文本格式。

使用 XML 配置适配器，以定义适配器属性和过程。  
（可选）也可以使用 XSL 来过滤接收到的记录和字段。

**先决条件：**确保首先阅读 [JavaScript 适配器](../)教程。

## XML 文件
{: #the-xml-file }

此 XML 文件中包含设置和元数据。  
要编辑适配器 XML 文件，您必须：

* 将协议设置为 HTTP 或 HTTPS。  
* 将 HTTP 域设置为 HTTP URL 的域部分。  
* 设置 TCP 端口。  

在 `connectivity` 元素下声明所需的过程：

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

<div class="panel-group accordion" id="terminology" role="tablist" aria-multiselectable="false">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="adapter-xml">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#adapter-xml" data-target="#collapse-adapter-xml" aria-expanded="false" aria-controls="collapse-adapter-xml"><b>单击获取 <code>connectionPolicy</code> 属性和子元素</b></a>
            </h4>
        </div>

        <div id="collapse-adapter-xml" class="panel-collapse collapse" role="tabpanel" aria-labelledby="adapter-xml">
            <div class="panel-body">
                <ul>
                    <li><b>xsi:type</b>：<i>必填。</i> 此属性的值必须是 http:HTTPConnectionPolicyType。</li>
                    <li><b>cookiePolicy</b>：<i>可选。</i>此属性决定 HTTP 适配器如何处理来自后端应用程序的 cookie。下列值有效。<ul>
                            <li>BEST_MATCH：缺省值</li>
                            <li>BROWSER_COMPATIBILITY</li>
                            <li>RFC_2109</li>
                            <li>RFC_2965</li>
                            <li>NETSCAPE</li>
                            <li>IGNORE_COOKIES</li>
                        </ul>
                        有关这些值的更多信息，请参阅 Apache <a href="http://hc.apache.org/httpclient-3.x/cookies.html">HTTP 组件</a>页面。</li>
                    <li><b>maxRedirects</b>：<i>可选。</i>HTTP 可以跟随的最大重定向数。当后端应用程序由于某些错误（如认证失败）而发送循环重定向时，此属性非常有用。如果此属性设置为 0，那么适配器根本不尝试跟随重定向，并会向用户返回 HTTP 302 响应。缺省值为 10。
</li>
                    <li><b>protocol</b>：<i>可选。</i>要使用的 URL 协议。下列值有效：<b>http</b>（缺省值）和 <b>https</b>。</li>
                    <li><b>domain</b>：<i>必填。</i>主机地址。</li>
                    <li><b>port</b>：<i>可选。</i>端口地址。如果未指定任何端口，那么将使用缺省 HTTP/S 端口 (80/443)</li>
                    <li><b>sslCertificateAlias</b>：对于常规 HTTP 认证和简单 SSL 认证是可选的。对于交互 SSL 认证是必需的。适配器专用 SSL 密钥的别名，HTTP 适配器密钥管理器使用该密钥来访问密钥库中的正确 SSL 证书。有关密钥库设置过程的更多信息，请参阅<a href="using-ssl">在 HTTP 适配器中使用 SSL</a> 教程。</li>
                    <li><b>sslCertificatePassword</b>：对于常规 HTTP 认证和简单 SSL 认证是可选的。对于交互 SSL 认证是必需的。适配器专用 SSL 密钥的密码，HTTP 适配器密钥管理器使用该密码来访问密钥库中的正确 SSL 证书。有关密钥库设置过程的更多信息，请参阅<a href="using-ssl">在 HTTP 适配器中使用 SSL</a> 教程。</li>
                    <li><b>authentication</b>：<i>可选。</i>HTTP 适配器的认证配置。HTTP 适配器可以使用两种认证协议中的一种。定义 <b>authentication</b>< 元素，如下所示：<ul>
                            <li>基本认证
{% highlight xml %}
<authentication>
    <basic/>
</authentication>
{% endhighlight %}</li>
                            <li>摘要认证
{% highlight xml %}
<authentication>
    <digest/>
</authentication>
{% endhighlight %}</li>


                            连接策略可以包含一个 <code>serverIdentity</code> 元素。此功能适用于所有认证方案。例如：
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
                    <li><b>proxy</b>：<i>可选。</i>proxy 元素指定访问后端应用程序时要使用的代理服务器的详细信息。代理详细信息中必须包含协议域和端口。如果代理需要认证，请在 <code>proxy</code> 中添加嵌套 <code>authentication</code> 元素。此元素与描述适配器的认证协议的元素具有相同的结构。以下示例显示需要基本认证并使用服务器身份的代理。                    
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
                    <li><b>maxConcurrentConnectionsPerNode</b>：<i>可选。</i>定义 {{ site.data.keys.mf_server }} 可以打开的到后端的最大并发连接数。{{ site.data.keys.product }} 不限制来自应用程序的入站服务请求。此项仅限制到后端服务的并发 HTTP 连接数。<br/><br/>
                    并发 HTTP 连接的缺省数目为 50。您可以基于到适配器的期望并发请求数和后端服务允许的最大请求数来修改此数值。也可以配置后端服务以限制并发入站请求的数目。<br/><br/>
                    注意双节点系统，其系统上期望的负载是 100 个并发请求，后端服务最多可支持 80 个并发请求。您可以将 maxConcurrentConnectionsPerNode 设置为 40。此设置可确保对后端服务发出的并发请求数不超过 80 个。<br/><br/>
                    如果增加此值，那么后端应用程序将需要更多内存。为避免出现内存问题，请勿将此值设置太高。您可以预测每秒事务数的平均值和峰值，并且估算其平均持续时间。之后，根据此示例中的指示计算所需的并发连接数，并增加 5-10% 的范围。然后，监控后端并根据需要调整此值，以确保后端应用程序可以处理所有入站请求。
<br/><br/>
                    将适配器部署到集群时，将此属性的值设置为最大所需负载除以集群成员数。<br/><br/>
                    有关如何调整后端应用程序大小的更多信息，请参阅<a href="{{site.baseurl}}/learn-more">“可伸缩性和硬件大小调整”文档</a>及其随附的硬件计算器电子表格</li>
                    <li><b>connectionTimeoutInMilliseconds</b>：<i>可选。</i>可以建立到后端的连接之前的超时（毫秒）。设置此超时并不确保在调用 HTTP 请求后经过特定时间后会发生超时异常。如果在 <code>invokeHTTP()</code> 函数中为此参数传递了其他值，那么将覆盖此处定义的值。</li>
                    <li><b>socketTimeoutInMilliseconds</b>：<i>可选。</i>从连接包开始两个连续包之间的超时（毫秒）。设置此超时并不确保在调用 HTTP 请求后经过特定时间后会发生超时异常。如果在 <code>invokeHttp()</code> 函数中为 <code>socketTimeoutInMilliseconds</code> 参数传递了其他值，那么将覆盖此处定义的值。</li>
                </ul>
                <br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#adapter-xml" data-target="#collapse-adapter-xml" aria-expanded="false" aria-controls="collapse-adapter-xml"><b>结束部分</b></a>
            </div>
        </div>
    </div>
</div>


## JavaScript 实施
{: #javascript-implementation }

服务 URL 用于过程调用。URL 的一些部分是常量；例如 http://example.com/。  
可以用参数表示 URL 的其他部分；即，可在运行时替换为提供给过程的参数值。

可以用参数表示以下 URL 部分。

* 路径元素
* 查询字符串参数
* 片段

要调用 HTTP 请求，请使用 `MFP.Server.invokeHttp` 方法。  
提供必须指定以下内容的输入参数对象：

* HTTP 方法：`GET`、`POST`、`PUT` 或 `DELETE`
* 返回的内容类型：`XML`、`JSON`、`HTML` 或 `plain`
* 服务 `path`
* 查询参数（可选）
* 请求主体（可选）
* 变换类型（可选）

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

> 请参阅用户文档中的“MFP.Server.invokeHttp”API 参考，以获取完整的选项列表。

## XSL 变换过滤
{: #xsl-transformation-filtering }

您也可以针对接收的数据应用 XSL 变换，例如过滤数据。  
要应用 XSL 变换，请在 JavaScript 实施文件后创建 **filtered.xsl** 文件。

之后，可以在过程调用的输入参数中指定变换选项。例如：

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

## 创建基于 SOAP 的服务请求
{: #creating-a-soap-based-service-request }

您可以使用 `MFP.Server.invokeHttp` API 方法来创建 **SOAP** 包络。  
注：要在 JavaScript HTTP 适配器中调用基于 SOAP 的服务，可以使用 **E4X** 在请求主体中对 SOAP XML 包络进行编码。

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

之后，`MFP.Server.invokeHttp(options)` 方法将用于调用 SOAP 服务的请求。  
Options 对象必须包含以下属性：

* `method` 属性：通常为 `POST`
* `returnedContentType` 属性：通常为 `XML`
* `path` 属性：服务路径
* `body` 属性：`content`（SOAP XML 作为字符串）和 `contentType`

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

## 基于 SOAP 的服务的调用结果
{: #invoking-results-of-soap-based-service }

结果将包裹在 `JSON` 对象中：

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

注：`Envelope` 属性，该属性特定于基于 SOAP 的请求。  
`Envelope` 属性包含基于 SOAP 的请求的结果内容。

要访问 XML 内容：

* 在客户机端，jQuery 可用于包裹结果字符串并跟随 DOM 节点：

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
* 在服务器端，创建具有结果字符串的 XML 对象。之后，节点可作为属性来访问：

```javascript
var xmlDoc = new XML(result.Envelope.Body.GetWeatherResponse.GetWeatherResult);
var weatherInfo = {
	Location: xmlDoc.Location.toString(),
	Time: xmlDoc.Time.toString(),
	Wind: xmlDoc.Wind.toString(),
	Temperature: xmlDoc.Temperature.toString()
};
```

## 样本适配器
{: #sample-adapter }

[单击以下载](https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80/)适配器 Maven 项目。

### 样本用法
{: #sample-usage }

* 使用 Maven、{{ site.data.keys.mf_cli }} 或您所选的 IDE 来[构建和部署 JavaScriptHTTP 适配器](../../creating-adapters/)。
* 要测试或调试适配器，请参阅[测试和调试适配器](../../testing-and-debugging-adapters)教程。
