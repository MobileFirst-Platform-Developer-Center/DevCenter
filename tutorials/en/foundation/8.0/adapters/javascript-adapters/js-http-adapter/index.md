---
layout: tutorial
title: JavaScript HTTP Adapter
breadcrumb_title: HTTP Adapter
relevantTo: [ios,android,windows,javascript]
downloads:
  - name: Download Adapter Maven project
    url: https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
By using HTTP adapters, you can send GET or POST HTTP requests and retrieve data from the response headers and body. HTTP adapters work with RESTful and SOAP-based services, and can read structured HTTP sources such as RSS feeds.

You can easily customize HTTP adapters with simple server-side JavaScript code. For example, you could set up server-side filtering if necessary. The retrieved data can be in XML, HTML, JSON, or plain text format.

The adapter is configured with XML to define the adapter properties and procedures.  
Optionally, it is also possible to use XSL to filter received records and fields.

**Prerequisite:** Make sure to read the [JavaScript Adapters](../) tutorial first.

## The XML File
The XML file contains settings and metadata.  
To edit the adapter XML file, you must:

* Set the protocol to HTTP or HTTPS.  
* Set the HTTP domain to the domain part of HTTP URL.  
* Set the TCP Port.  

Declare the required procedures below the `connectivity` element:

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
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#adapter-xml" data-target="#collapse-adapter-xml" aria-expanded="false" aria-controls="collapse-adapter-xml"><b>Click for <code>connectionPolicy</code> attributes and subelements</b></a>
            </h4>
        </div>

        <div id="collapse-adapter-xml" class="panel-collapse collapse" role="tabpanel" aria-labelledby="adapter-xml">
            <div class="panel-body">
                <ul>
                    <li><b>xsi:type</b>: <i>Mandatory.</i> The value of this attribute must be http:HTTPConnectionPolicyType.</li>
                    <li><b>cookiePolicy</b>: <i>Optional.</i> This attribute sets how the HTTP adapter handles cookies that arrive from the back-end application. The following values are valid.
                        <ul>
                            <li>BEST_MATCH: default value</li>
                            <li>BROWSER_COMPATIBILITY</li>
                            <li>RFC_2109</li>
                            <li>RFC_2965</li>
                            <li>NETSCAPE</li>
                            <li>IGNORE_COOKIES</li>
                        </ul>
                        For more information about these values, see the Apache <a href="http://hc.apache.org/httpclient-3.x/cookies.html">HTTP components</a> page.
                    </li>
                    <li><b>maxRedirects</b>: <i>Optional.</i> The maximum number of redirects that the HTTP adapter can follow. This attribute is useful when the back-end application sends circular redirects as a result of some error, such as authentication failures. If this attribute is set to 0, the adapter does not attempt to follow redirects at all, and the HTTP 302 response is returned to the user. The default value is 10.</li>
                    <li><b>protocol</b>: <i>Optional.</i> The URL protocol to use. The following values are valid: <b>http</b> (default), <b>https</b>.</li>
                    <li><b>domain</b>: <i>Mandatory.</i> The host address.</li>
                    <li><b>port</b>: <i>Optional.</i> The port address. If no port is specified the default HTTP/S port is used (80/443)</li>
                    <li><b>sslCertificateAlias</b>: Optional for regular HTTP authentication and simple SSL authentication. Mandatory for mutual SSL authentication. The alias of the adapter private SSL key, which is used by the HTTP adapter key manager to access the correct SSL certificate in the keystore. For more information about the keystore setup process, see <a href="using-ssl">Using SSL in HTTP adapters</a> tutorial.</li>
                    <li><b>sslCertificatePassword</b>: Optional for regular HTTP authentication and simple SSL authentication. Mandatory for mutual SSL authentication. The password of the adapter private SSL key, which is used by the HTTP adapter key manager to access the correct SSL certificate in the keystore. For more information about the keystore setup process, see <a href="using-ssl">Using SSL in HTTP adapters</a> tutorial.</li>
                    <li><b>authentication</b>: <i>Optional.</i> Authentication configuration of the HTTP adapter. The HTTP adapter can use one of two authentication protocols. Define the <b>authentication</b>< element, as follows:
                        <ul>
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


                            The connection policy can contain a <code>serverIdentity</code> element. This feature applies to all authentication schemes. For example:
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
                    <li><b>proxy</b>: <i>Optional.</i> The proxy element specifies the details of the proxy server to use when accessing the back-end application. The proxy details must include the protocol domain and port. If the proxy requires authentication, add a nested <code>authentication</code> element inside <code>proxy</code>. This element has the same structure as the one used to describe the authentication protocol of the adapter. The following example shows a proxy that requires basic authentication and uses a server identity.
                    
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
                    <li><b>maxConcurrentConnectionsPerNode</b>: <i>Optional.</i> Defines the maximum number of concurrent connections, which the {{ site.data.keys.mf_server }} can open to the back end. {{ site.data.keys.product }} does not limit the incoming service requests from applications. This limits only the number of concurrent HTTP connections to the back-end service.
                    <br/><br/>
                    The default number of concurrent HTTP connections is 50. You can modify this number based on the expected concurrent requests to the adapter and the maximum requests allowed on the back-end service. You can also configure the back-end service to limit the number of concurrent incoming requests.
                    <br/><br/>
                    Consider a two-node system, where the expected load on the system is 100 concurrent requests and the back-end service can support up to 80 concurrent requests. You can set maxConcurrentConnectionsPerNode to 40. This setting ensures that no more than 80 concurrent requests are made to the back-end service.
                    <br/><br/>
                    If you increase the value, the back-end application needs more memory. To avoid memory issues, do not to set this value too high. Instead, estimate the average and peak number of transactions per second, and evaluate their average duration. Then, calculate the number of required concurrent connections as indicated in this example, and add a 5-10% margin. Then, monitor your back end, and adjust this value as required, to ensure that your back-end application can process all incoming requests.
                    <br/><br/>
                    When you deploy adapters to a cluster, set the value of this attribute to the maximum required load divided by the number of cluster members.
                    <br/><br/>
                    For more information about how to size your back-end application, see the <a href="{{site.baseurl}}/learn-more">Scalability and Hardware Sizing document</a> and its accompanying hardware calculator spreadsheet</li>
                    <li><b>connectionTimeoutInMilliseconds</b>: <i>Optional.</i> The timeout in milliseconds until a connection to the back-end can be established. Setting this timeout does not ensure that a timeout exception occurs after a specific time elapses after the invocation of the HTTP request. If you pass a different value for this parameter in the <code>invokeHTTP()</code> function, you can override the value that is defined here.</li>
                    <li><b>socketTimeoutInMilliseconds</b>: <i>Optional.</i> The timeout in milliseconds between two consecutive packets, starting from the connection packet. Setting this timeout does not ensure that a timeout exception occurs after a specific time elapses after the invocation of the HTTP request. If you pass a different value for the <code>socketTimeoutInMilliseconds</code> parameter in the <code>invokeHttp()</code> function, you can override the value that is defined here.</li>
                </ul>
                <br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#adapter-xml" data-target="#collapse-adapter-xml" aria-expanded="false" aria-controls="collapse-adapter-xml"><b>Close section</b></a>
            </div>
        </div>
    </div>
</div>


## JavaScript implementation
A service URL is used for procedure invocations. Some parts of the URL are constant; for example, http://example.com/.  
Other parts of the URL can be parameterized; that is, substituted at run time by parameter values that are provided to the procedure.

The following URL parts can be parameterized.

* Path elements
* Query string parameters
* Fragments

To call an HTTP request, use the `MFP.Server.invokeHttp` method.  
Provide an input parameter object, which must specify:

* The HTTP method: `GET`,`POST`, `PUT`, `DELETE`
* The returned content type: `XML`, `JSON`, `HTML`, or `plain`
* The service `path`
* The query parameters (optional)
* The request body (optional)
* The transformation type (optional)

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

> See the API Reference for "MFP.Server.invokeHttp" in the user documentation for a complete list of options.

## XSL transformation filtering
You can also apply XSL transformation to the received data, for example to filter the data.  
To apply XSL transformation, create a **filtered.xsl** file next to the JavaScript implementation file.

You can then specify the transformation options in the input parameters of the procedure invocation. For example:

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

## Creating a SOAP-based service request
You can use the `MFP.Server.invokeHttp` API method to create a **SOAP** envelope.  
Note: To call a SOAP-based service in a JavaScript HTTP adapter, you can encode the SOAP XML envelope within the request body using **E4X**.

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

The `MFP.Server.invokeHttp(options)` method is then used to call a request for a SOAP service.  
The Options object must include the following properties:

* A `method` property: usually `POST`
* A `returnedContentType` property: usually `XML`
* A `path` property: a service path
* A `body` property: `content` (SOAP XML as a string) and `contentType`

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

## Invoking results of SOAP-based service
The result is wrapped into a `JSON` object:

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

Note the `Envelope` property, which is specific of SOAP-based requests.  
The `Envelope` property contains the result content of the SOAP-based request.

To access the XML content:

* On client-side, jQuery can be used to wrap the result string, and follow the DOM nodes:

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
* On server-side, create an XML object with the result string. The nodes can then be accessed as properties:

```javascript
var xmlDoc = new XML(result.Envelope.Body.GetWeatherResponse.GetWeatherResult);
var weatherInfo = {
	Location: xmlDoc.Location.toString(),
	Time: xmlDoc.Time.toString(),
	Wind: xmlDoc.Wind.toString(),
	Temperature: xmlDoc.Temperature.toString()
};
```

## Sample adapter
[Click to download](https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80/) the Adapters Maven project.

### Sample usage
* Use either Maven, {{ site.data.keys.mf_cli }} or your IDE of choice to [build and deploy the JavaScriptHTTP adapter](../../creating-adapters/).
* To test or debug an adapter, see the [testing and debugging adapters](../../testing-and-debugging-adapters) tutorial.
