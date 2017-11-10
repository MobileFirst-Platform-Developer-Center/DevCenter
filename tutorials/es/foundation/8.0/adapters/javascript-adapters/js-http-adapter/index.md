---
layout: tutorial
title: Adaptador JavaScript HTTP
breadcrumb_title: Adaptador HTTP
relevantTo: [ios,android,windows,javascript]
downloads:
  - name: Download Adapter Maven project
    url: https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general 
{: #overview }

Mediante los adaptadores HTTP, puede enviar solicitudes GET o POST HTTP y recuperar datos del cuerpo y la cabecera de la respuesta.
Los adaptadores HTTP funcionan con servicios basados en SOAP y RESTful, y pueden leer orígenes HTTP estructurados como, por ejemplo, canales de información RSS.


Puede personalizar fácilmente los adaptadores HTTP con código JavaScript simple del lado del servidor.
Por ejemplo, podría configurar filtrado del lado del servidor si fuese necesario.
El formato de los datos recuperados puede ser XML, HTML, JSON o texto sin formato.


El adaptador se configura con XML para definir sus procedimientos y propiedades.
  
Opcionalmente, también es posible utilizar XSL para filtrar los campos y registros recibidos.


**Requisito previo:** Asegúrese de leer primero la guía de aprendizaje [Adaptadores JavaScript](../).


## El archivo XML
{: #the-xml-file }

El archivo XML contiene los valores y metadatos.  
Para editar el archivo XML del adaptador, debe:

* Establecer el protocolo en HTTP o HTTPS.  
* Establecer el dominio HTTP en la parte de dominio del URL HTTP.
  
* Establecer el puerto TCP.   

Declarar los procedimientos necesarios bajo el elemento `connectivity`:


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

<div class="panel-group accordion" id="terminology" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="adapter-xml">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#adapter-xml" data-target="#collapse-adapter-xml" aria-expanded="false" aria-controls="collapse-adapter-xml"><b>Pulse para los subelementos y atributos de <code>connectionPolicy</code></b></a>
            </h4>
        </div>

        <div id="collapse-adapter-xml" class="panel-collapse collapse" role="tabpanel" aria-labelledby="adapter-xml">
            <div class="panel-body">
                <ul>
                    <li><b>xsi:type</b>: <i>Obligatorio</i>. El valor de este atributo debe ser http:HTTPConnectionPolicyType.</li>
                    <li><b>cookiePolicy</b>: <i>Opcional.</i> Este atributo establece la forma en la que el adaptador HTTP manejará las cookies que llegan desde la aplicación de fondo. Los siguientes valores son válidos.
  <ul>
                            <li>BEST_MATCH: valor predeterminado</li>
                            <li>BROWSER_COMPATIBILITY</li>
                            <li>RFC_2109</li>
                            <li>RFC_2965</li>
                            <li>NETSCAPE</li>
                            <li>IGNORE_COOKIES</li>
                        </ul>
Para obtener más información sobre estos valores, consulte la página de <a href="http://hc.apache.org/httpclient-3.x/cookies.html">componentes HTTP</a> de Apache. </li>
                    <li><b>maxRedirects</b>: <i>Opcional.</i> Número máximo de redirecciones que el adaptador HTTP puede seguir. Este atributo es útil cuando la aplicación de fondo envía redirecciones cíclicas como resultado de un error, por ejemplo, con anomalías de autenticación. Si este atributo se establece en 0, el adaptador no intenta seguir ninguna redirección, devolviendo la respuesta HTTP 302 al usuario. El valor predeterminado es 10.</li>
                    <li><b>protocol</b>: <i>Opcional.</i> Protocolo URL a utilizar. Los siguientes valores son válidos: <b>http</b> (predeterminado), <b>https</b>.</li>
                    <li><b>domain</b>: <i>Obligatorio.</i> Dirección del host.</li>
                    <li><b>port</b>: <i>Opcional.</i> Dirección del puerto. Si no se especifica un puerto, se utiliza el puerto HTTP/S predeterminado (80/443)</li>
                    <li><b>sslCertificateAlias</b>: Opcional para la autenticación SSL simple y la autenticación HTTP normal. Obligatorio para la autenticación SSL mutua. El alias de la clave SSL privada del adaptador, que el gestor de claves del adaptador HTTP utiliza para acceder al certificado SSL en el almacén de claves. Para obtener más información sobre el proceso de configuración del almacén de claves, consulte la guía de aprendizaje <a href="using-ssl">Utilización de SSL en adaptadores HTTP</a>. </li>
                    <li><b>sslCertificatePassword</b>: Opcional para la autenticación SSL simple y la autenticación HTTP normal. Obligatorio para la autenticación SSL mutua. La contraseña de la clave SSL privada del adaptador, que el gestor de claves del adaptador HTTP utiliza para acceder al certificado SSL en el almacén de claves. Para obtener más información sobre el proceso de configuración del almacén de claves, consulte la guía de aprendizaje <a href="using-ssl">Utilización de SSL en adaptadores HTTP</a>.
</li>
                    <li><b>authentication</b>: <i>Opcional.</i> Configuración de autenticación del adaptador HTTP. El adaptador HTTP puede utilizar uno de los dos protocolos de autenticación. Defina el elemento <b>authentication</b>< tal como se indica:
<ul>
                            <li>Autenticación básica
{% highlight xml %}
<authentication>
    <basic/>
</authentication>
{% endhighlight %}</li>
                            <li>Autenticación Digest
{% highlight xml %}
<authentication>
    <digest/>
</authentication>
{% endhighlight %}</li>


                            La política de conexión puede contener un elemento <code>serverIdentity</code>. Esta característica se aplica a todos los esquemas de autenticación.
Por ejemplo:
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
                    <li><b>proxy</b>: <i>Opcional.</i> El elemento proxy especifica los detalles del servidor de proxy que utilizar al acceder a la aplicación de fondo. Los detalles del proxy deben incluir el puerto y el dominio del protocolo. Si el proxy precisa de autenticación, añada un elemento <code>authentication</code> anidado dentro de <code>proxy</code>. Este elemento tiene la misma estructura que el que se utiliza para describir el protocolo de autenticación del adaptador. En el ejemplo siguiente se muestra un proxy que requiere autenticación básica y utiliza una identidad de servidor.
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
                    <li><b>maxConcurrentConnectionsPerNode</b>: <i>Opcional.</i> Define el número máximo de conexiones simultáneas que {{ site.data.keys.mf_server }} puede abrir en el sistema de fondo. {{ site.data.keys.product }} no limita las solicitudes de servicio entrantes desde las aplicaciones. Solo limita el número de conexiones HTTP simultáneas para el servicio de fondo. <br/><br/>
El número predeterminado de conexiones HTTP simultáneas es 50. Este valor se puede modificar en base a las solicitudes simultáneas esperadas para el adaptador y el máximo de solicitudes permitidas en el servicio de fondo. También se puede configurar el servicio de fondo para limitar el número de solicitudes entrantes simultáneas.
<br/><br/>
Considere un sistema de dos nodos, donde la carga esperada en el sistema es de 100 solicitudes simultáneas donde el servicio de fondo puede soportar un máximo de 80 solicitudes simultáneas. Puede establecer maxConcurrentConnectionsPerNode en 40. Este valor asegura que no habrá más de 80 solicitudes simultáneas en el servicio de fondo.
<br/><br/>
Si incrementa este valor, la aplicación de fondo necesitará más memoria. Para evitar problemas con la memoria, no establezca este valor en un valor demasiado elevado. Para ello, averigüe el número medio y máximo de transacciones por segundo, y evalúe su duración media. A continuación, calcule el número de conexiones simultáneas necesarias tal como se indica en este ejemplo, y añada un margen de un 5-10% . A continuación, supervise su sistema de fondo y ajuste este valor tal como sea necesario, para asegurarse de que la aplicación de fondo puede procesar todas las solicitudes entrantes.
<br/><br/>
Cuando despliega adaptadores en un clúster, establece el valor de este atributo a la carga requerida máxima divida por el número de miembros del clúster.
<br/><br/>
Para obtener más información sobre cómo dimensionar su aplicación de fondo, consulte el documento de <a href="{{site.baseurl}}/learn-more">Dimensionamiento de hardware y escalabilidad</a> junto con su hoja de cálculo para el hardware.
</li>
                    <li><b>connectionTimeoutInMilliseconds</b>: <i>Opcional.</i> El tiempo de espera en milisegundos hasta que se pueda establecer la conexión al sistema de fondo. El establecimiento de este tiempo de espera no asegura que se produzca una excepción de tiempo de espera excedido después de que transcurra un tiempo específico después de la invocación de la solicitud HTTP. Si pasa un valor diferente para este parámetro en la función <code>invokeHTTP()</code>, prevalece sobre el valor que se define aquí. </li>
                    <li><b>socketTimeoutInMilliseconds</b>: <i>Opcional.</i> Tiempo de espera en milisegundos entre dos paquetes consecutivos, empezando desde el paquete de conexión. El establecimiento de este tiempo de espera no asegura que se produzca una excepción de tiempo de espera excedido después de que transcurra un tiempo específico después de la invocación de la solicitud HTTP. Si pasa un valor diferente para el parámetro <code>socketTimeoutInMilliseconds</code> en la función <code>invokeHttp()</code>, prevalece sobre valor que se define aquí. </li>
                </ul>
                <br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#adapter-xml" data-target="#collapse-adapter-xml" aria-expanded="false" aria-controls="collapse-adapter-xml"><b>Sección de cierre</b></a>
            </div>
        </div>
    </div>
</div>


## Implementación JavaScript
{: #javascript-implementation }

Para las invocaciones de procedimiento se utiliza un URL de servicio. Algunas partes del URL son fijas, por ejemplo, http://example.com/.
  
Es posible parametrizar otras partes del URL, esto es, sustituirlas en tiempo de ejecución mediante valores de parámetro que el procedimiento proporciona. 

Es posible parametrizar las siguientes partes del URL.


* Elementos de vía de acceso
* Parámetros de serie de consulta
* Fragmentos

Para llamar a una solicitud HTTP, utilice el método `MFP.Server.invokeHttp`.
  
Proporcione un objeto de parámetro de entrada, que debe especificar:


* El método HTTP: `GET`,`POST`, `PUT`, `DELETE`
* El tipo de contenido devuelto: `XML`, `JSON`, `HTML` o `plain`
* El valor de `path` de servicio
* Los parámetros de consulta (opcional)
* El cuerpo de la solicitud (opcional)
* El tipo de transformación (opcional)

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

> Consulte la Referencia de API para "MFP.Server.invokeHttp" en la documentación del usuario para obtener una lista completa de opciones.


## Filtrado de transformación XSL
{: #xsl-transformation-filtering }

También puede aplicar una transformación XSL para los datos recibidos, por ejemplo para filtrar los datos.
  
Para aplicar la transformación XSL, cree un archivo **filtered.xsl** junto al archivo de implementación JavaScript.


Puede entonces especificar las opciones de transformación en los parámetros de entrada de la invocación del procedimiento. Por ejemplo:

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

## Creación de una solicitud de servicio basada en SOAP
{: #creating-a-soap-based-service-request }

Puede utilizar el método de API `MFP.Server.invokeHttp` para crear un sobre **SOAP**.
  
Nota: Para llamar a un servicio basado en SOAP en un adaptador JavaScript HTTP, puede codificar el sobre XML de SOAP dentro del cuerpo de la solicitud utilizando **E4X**.


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

El método `MFP.Server.invokeHttp(options)` se utiliza entonces para llamar a una solicitud para un servicio SOAP.
  
El objeto Options debe incluir las siguientes propiedades:


* Una propiedad `method`: habitualmente `POST`
* Una propiedad `returnedContentType`: habitualmente `XML`
* Una propiedad `path`: una vía de acceso de servicio
* Una propiedad `body`: `content` (XML de SOAP como una serie) y `contentType` 

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

## Invocación de resultados del servicio basado en SOAP
{: #invoking-results-of-soap-based-service }

El resultado se acomoda en un objeto `JSON`: 

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

Observe que la propiedad `Envelope`, que es específica de solicitudes basadas en SOAP.
  
La propiedad `Envelope` contiene el contenido resultante de la solicitud basada en SOAP.


Para acceder al contenido XML:

* En el lado del cliente, se puede utilizar jQuery para acomodar la serie resultante, y seguir los nodos del DOM:


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
* En el lado del servidor, se crea un objeto XML con la serie resultante. Se puede acceder entonces a los nodos como propiedades:


```javascript
var xmlDoc = new XML(result.Envelope.Body.GetWeatherResponse.GetWeatherResult);
var weatherInfo = {
	Location: xmlDoc.Location.toString(),
	Time: xmlDoc.Time.toString(),
	Wind: xmlDoc.Wind.toString(),
	Temperature: xmlDoc.Temperature.toString()
};
```

## Adaptador de ejemplo
{: #sample-adapter }

[Pulse para descargar](https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80/) el proyecto Maven Adapters.


### Uso de ejemplo 
{: #sample-usage }

* Utilice Maven, {{ site.data.keys.mf_cli }} o el IDE de su elección para [compilar y desplegar el adaptador JavaScriptHTTP](../../creating-adapters/).

* Para probar o depurar un adaptador, consulte la guía de aprendizaje [Pruebas y depuración de adaptadores](../../testing-and-debugging-adapters).

