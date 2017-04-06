---
layout: tutorial
title: JavaScript-HTTP-Adapter
breadcrumb_title: HTTP-Adapter
relevantTo: [ios,android,windows,javascript]
downloads:
  - name: Adapter-Maven-Projekt herunterladen
    url: https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }

Mit
HTTP-Adaptern können Sie GET- oder POST-HTTP-Anforderungen senden und Daten aus den Headern und dem Text der Antwort
abrufen. HTTP-Adapter arbeiten mit REST-konformen und SOAP-basierten Services und können strukturierte HTTP-Quellen wie RSS-Feeds
lesen. 

Sie können HTTP-Adater ohne großen Aufwand mit einfachem serverseitigem JavaScript-Code anpassen.
Sie können beispielsweise serverseitige Filter einrichten, sofern dies erforderlich ist. Die abgerufenen Daten können in den Formaten XML, HTML und JSON oder in einfachem Textformat vorliegen. 

Für die Adapterkonfiguration werden in XML Adaptereigenschaften und -prozeduren definiert.   
Es ist auch möglich, empfangene Datensätze und Felder mit XSL zu filtern. 

**Voraussetzung:** Arbeiten Sie zuerst das Lernprogramm [JavaScript-Adapter](../) durch. 

## XML-Datei
{: #the-xml-file }

Die XML-Datei enthält Einstellungen und Metadaten.   
Wenn Sie die Adapter-XML-Datei bearbeiten, müssen Sie folgende Schritte ausführen: 

* Setzen Sie das Protokoll auf HTTP oder HTTPS.  
* Setzen Sie die HTTP-Domäne auf den Domänenabschnitt der HTTP-URL.  
* Legen Sie den TCP-Port fest.   

Deklarieren Sie die erforderlichen Prozeduren unterhalb des Elements `connectivity`: 

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
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#adapter-xml" data-target="#collapse-adapter-xml" aria-expanded="false" aria-controls="collapse-adapter-xml"><b>Für Attribute und untergeordnete Elemente von <code>connectionPolicy</code> hier klicken</b></a>
            </h4>
        </div>

        <div id="collapse-adapter-xml" class="panel-collapse collapse" role="tabpanel" aria-labelledby="adapter-xml">
            <div class="panel-body">
                <ul>
                    <li><b>xsi:type</b>: Dieses <i>obligatorische</i> Attribut muss den Wert
http:HTTPConnectionPolicyType haben. </li>
                    <li><b>cookiePolicy</b>: Dieses <i>optionale</i> Attribut legt fest, wie der HTTP-Adapter von der Back-End-Anwendung eingehende Cookies behandelt. Folgende Werte sind gültig: <ul>
                            <li>BEST_MATCH (Standardwert)</li>
                            <li>BROWSER_COMPATIBILITY</li>
                            <li>RFC_2109</li>
                            <li>RFC_2965</li>
                            <li>NETSCAPE</li>
                            <li>IGNORE_COOKIES</li>
                        </ul>
                        Weitere Informationen zu diesen Werten finden Sie auf der Apache-Seite <a href="http://hc.apache.org/httpclient-3.x/cookies.html">HTTP Components</a>.
                    </li>
                    <li><b>maxRedirects</b>: Dieses <i>optionale</i> Attribut gibt die maximale Anzahl möglicher Umleitungen für den HTTP-Adapter an. Dieses Attribut ist hilfreich, wenn die Back-End-Anwendung
infolge eines Fehlers (z. B. eines Authentifizierungsfehlers) kreisförmige Umleitungen sendet. Wenn dieses Attribut auf 0 gesetzt ist, versucht der Adapter nicht, Umleitungen zu folgen. An den
Benutzer wird die Antwort HTTP 302 zurückgegeben. Der Standardwert ist 10.</li>
                    <li><b>protocol</b>: Dieses <i>optionale</i> Unterelement gibt das zu verwendende URL-Protokoll an. Die folgenden Werte sind gültig: <b>http</b> (Standardwert), <b>https</b>.</li>
                    <li><b>domain</b>: Dieses <i>obligatorische</i> Unterelement gibt die Hostadresse an. </li>
                    <li><b>port</b>: Dieses <i>optionale</i> Unterelement gibt die Portadresse an. Wenn kein Port angegeben ist,
wird der HTTP/S-Standardport (80/443) verwendet. </li>
                    <li><b>sslCertificateAlias</b>: Für die reguläre HTTP-Authentifizierung und die einfache
SSL-Authentifizierung ist dieses Unterelement optional. Für die gegenseitige SSL-Authentifizierung ist es obligatorisch. Dies ist der Alias des privaten SSL-Schlüssels des Adapters. Der Key Manager des HTTP-Adapters greift mit diesem
Alias auf das richtige SSL-Zertifikat im Keystore zu.
Weitere Informationen zum Setup-Prozess für Keystores enthält das Lernprogramm <a href="using-ssl">SSL in HTTP-Adaptern</a>. </li>
                    <li><b>sslCertificatePassword</b>: Für die reguläre HTTP-Authentifizierung und die einfache
SSL-Authentifizierung ist dieses Unterelement optional. Für die gegenseitige SSL-Authentifizierung ist es obligatorisch. Dies ist das Kennwort für den privaten SSL-Schlüssel des Adapters. Der Key Manager des HTTP-Adapters greift mit diesem
Kennwort auf das richtige SSL-Zertifikat im Keystore zu.
Weitere Informationen zum Setup-Prozess für Keystores enthält das Lernprogramm <a href="using-ssl">SSL in HTTP-Adaptern</a>. </li>
                    <li><b>authentication</b>: Dieses <i>optionale</i> Unterelement gibt die Authentifizierungskonfiguration des HTTP-Adapters an. Der HTTP-Adapter kann eines von zwei Authentifizierungsprotokollen verwenden. Definieren Sie das Element <b>authentication</b> wie folgt: <ul>
                            <li>Basisauthentifizierung
{% highlight xml %}
<authentication>
    <basic/>
</authentication>
{% endhighlight %}</li>
                            <li>Digest-Authentifizierung
{% highlight xml %}
<authentication>
    <digest/>
</authentication>
{% endhighlight %}</li>


                            Die Verbindungsrichtlinie kann ein Element <code>serverIdentity</code> enthalten. Dieses Feature ist auf alle Authentifizierungsschemata anwendbar. Beispiel:
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
                    <li><b>proxy</b>: Dieses <i>optionale</i> Element gibt die Details des Proxy-Servers an, der beim Zugriff auf die Back-End-Anwendung verwendet
werden soll. Die Proxydetails müssen die Protokolldomäne und den Port enthalten. Falls der Proxy eine Authentifizierung erfordert, fügen Sie innerhalb des Elements <code>proxy</code> ein verschachteltes Element
<code>authentication</code> hinzu. Dieses Element hat dieselbe Struktur wie das Element, mit dem das Authentifizierungsprotokoll
des Adapters beschrieben wird. Das folgende Beispiel zeigt einen Proxy, der die Basisauthentifizierung erfordert und eine Serveridentität verwendet.                    
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
                    <li><b>maxConcurrentConnectionsPerNode</b>: Dieses <i>optionale</i> Unterelement definiert die maximale Anzahl Verbindungen, die der
{{ site.data.keys.mf_server }} gleichzeitig zum
Back-End öffnen kann. In der {{ site.data.keys.product }} gibt es
kein Limit für Serviceanforderungen, die von Anwendungen eingehen. Es wird nur die Anzahl gleichzeitiger HTTP-Verbindungen zum Back-End-Service begrenzt. <br/><br/>
                    Standardmäßig sind
50 gleichzeitige HTTP-Verbindungen möglich. Schätzen Sie ein, wie viele gleichzeitige Anforderungen an den Adapter erwartet werden. Ausgehend von dieser Zahl und von den
maximal zulässigen Anforderungen seitens des Back-End-Service können Sie die Anzahl der gleichzeitigen HTTP-Verbindungen modifizieren. Außerdem können Sie den Back-End-Service so konfigurieren, dass die Anzahl der gleichzeitig eingehenden Anforderungen begrenzt ist.<br/><br/>
                    Stellen Sie sich ein System mit zwei Knoten vor, für das eine Belastung von 100 parallelen Anforderungen erwartet wird. Der Back-End-Service
kann aber nur maximal 80 gleichzeitige Anforderungen unterstützen. Für den Fall können Sie maxConcurrentConnectionsPerNode auf
40 setzen.
Durch diese Einstellung ist sichergestellt, dass nicht mehr als 80 gleichzeitige Anforderungen an den Back-End-Service
gerichtet werden.<br/><br/>
                    Wenn Sie
den
Wert erhöhen, benötigt die Back-End-Anwendung mehr Hauptspeicher. Setzen Sie diesen Wert nicht zu hoch, um Speicherprobleme zu vermeiden. Schätzen Sie vielmehr ein, wie viele Transaktionen durchschnittlich und bei einer Spitzenbelastung anfallen,
und werten Sie die durchschnittliche Dauer der Transaktionen aus. Berechnen Sie dann die Anzahl der erforderlichen
gleichzeitig bestehenden Verbindungen wie in diesem Beispiel und addieren Sie eine Reserve
von 5-10 % hinzu.
Überwachen Sie dann Ihr Back-End und passen Sie diesen Wert ggf. an, um sicherzustellen, dass Ihre Back-End-Anwendung alle eingehenden Anforderungen
verarbeiten kann.<br/><br/>
                    Wenn Sie Adapter in einem Cluster implementieren, setzen Sie dieses Attribut auf den Quotienten aus
der maximal erforderlichen Arbeitslast und der Anzahl der Clustermember.
                    <br/><br/>
                    Weitere Informationen zur Berechnung der Größe
Ihrer Back-End-Anwendung finden Sie im Dokument
<a href="{{site.baseurl}}/learn-more">Scalability and Hardware Sizing</a> und dem zugehörigen Arbeitsblatt "Hardware Calculator". </li>
                    <li><b>connectionTimeoutInMilliseconds</b>: Dieses <i>optionale</i> Unterelement gibt das Zeitlimit bis zum Herstellen einer Verbindung zum Back-End in Millisekunden an.
                Durch das Festlegen dieses Zeitlimits ist nicht sichergestellt, dass nicht eine bestimmte Zeit nach dem Aufrufen der HTTP-Anforderung eine Ausnahme wegen einer Zeitlimitüberschreitung auftritt. Wenn Sie in der Funktion <code>invokeHTTP()</code> einen anderen Wert für diesen Parameter übergeben, wird der hier definierte Wert überschrieben. </li>
                    <li><b>socketTimeoutInMilliseconds</b>: Dieses <i>optionale</i> Unterelement gibt, beginnend beim Verbindungspaket, das Zeitlimit zwischen zwei
aufeinanderfolgenden Paketen in Millisekunden an. Durch das Festlegen dieses Zeitlimits ist nicht sichergestellt, dass nicht eine bestimmte Zeit nach dem Aufrufen der HTTP-Anforderung eine Ausnahme wegen einer Zeitlimitüberschreitung auftritt. Wenn Sie in der Funktion <code>invokeHttp()</code> einen anderen Wert für den Parameter <code>socketTimeoutInMilliseconds</code> übergeben, wird der hier definierte Wert überschrieben. </li>
                </ul>
                <br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#adapter-xml" data-target="#collapse-adapter-xml" aria-expanded="false" aria-controls="collapse-adapter-xml"><b>Abschnitt schließen</b></a>
            </div>
        </div>
    </div>
</div>


## JavaScript-Implementierung
{: #javascript-implementation }

Für Prozeduraufrufe wird eine Service-URL verwendet. Einige Abschnitte der URL sind konstant, z. B. http://example.com/.   
Andere Abschnitte der URL können parametrisiert, d. h. in der Laufzeit durch Parameterwerte ersetzt werden, die für die
Prozedur bereitgestellt werden. 

Folgende
URL-Abschnitte können parametrisiert werden. 

* Pfadelemente
* Parameter für Abfragezeichenfolgen
* Fragmente

Verwenden Sie zum Aufrufen einer
HTTP-Anforderung die Methode `MFP.Server.invokeHttp`.   
Geben Sie ein Eingabeparameterobjekt mit folgenden Optionen an: 

* HTTP-Methode: `GET`,`POST`, `PUT`, `DELETE`
* Zurückgegebener Inhaltstyp (`XML`, `JSON`, `HTML`
oder `plain`) 
* Servicepfad (`path`)
* Abfrageparameter (optional)
* Anforderungshauptteil (optional)
* Umwandlungstyp (optional)

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

> Eine vollständige Liste der Optionen können Sie den API-Referenzinformationen zu "MFP.Server.invokeHttp" in der Benutzerdokumentation entnehmen. 

## XSL-Transformation zum Filtern
{: #xsl-transformation-filtering }

Sie können auf die Daten die XSL-Transformation anwenden, um beispielsweise die Feeddaten zu filtern.   
Erstellen Sie neben der JavaScript-Implementierungsdatei eine Datei **filtered.xsl** für die XSL-Transformation. 

Anschließend können Sie in den Eingabeparametern des Prozeduraufrufs
die Transformationsoptionen angeben. Beispiel: 

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

## SOAP-basierte Serviceanforderung erstellen
{: #creating-a-soap-based-service-request }

Mit der API-Methode `MFP.Server.invokeHttp` können Sie ein **SOAP**-Envelope erstellen.  
Hinweis: Wenn Sie in einem JavaScript-HTTP-Adapter einen SOAP-basierten Service aufrufen möchten,
können Sie **E4X** verwenden, um das SOAP-XML-Envelope mit dem Anforderungshauptteil zu codieren. 

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

Rufen Sie dann mit der Methode `MFP.Server.invokeHttp(options)` eine SOAP-Serviceanforderung auf.   
Das Optionsobjekt muss die folgenden Eigenschaften enthalten: 

* Eigenschaft `method`: in der Regel `POST`
* Eigenschaft `returnedContentType`: in der Regel `XML`
* Eigenschaft `path`: ein Servicepfad
* Eigenschaft `body`: `content` (SOAP-XML als Zeichenfolge)
und `contentType`

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

## Ergebnisse eines SOAP-basierten Service aufrufen
{: #invoking-results-of-soap-based-service }

Das Ergebnis ist in einem `JSON`-Objekt eingeschlossen. 

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

Beachten Sie, dass die Eigenschaft `Envelope` für SOAP-basierte Anforderungen spezifisch ist.   
Die Eigenschaft `Envelope` enthält den Ergebnisinhalt zur SOAP-basierten Anforderung. 

Greifen Sie wie folgt auf den XML-Inhalt zu: 

* Auf der Clientseite können Sie jQuery verwenden, um die Ergebniszeichenfolge einzuschließen und den DOM-Knoten zu folgen: 

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
* Erstellen Sie auf der Serverseite ein XML-Objekt mit der Ergebniszeichenfolge. Die Knoten sind dann als Eigenschaften zugänglich. 

```javascript
var xmlDoc = new XML(result.Envelope.Body.GetWeatherResponse.GetWeatherResult);
var weatherInfo = {
	Location: xmlDoc.Location.toString(),
	Time: xmlDoc.Time.toString(),
	Wind: xmlDoc.Wind.toString(),
	Temperature: xmlDoc.Temperature.toString()
};
```

## Beispieladapter
{: #sample-adapter }

[Klicken Sie hier](https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80/), um das Maven-Adapterprojekt herunterzuladen. 

### Verwendung des Beispiels
{: #sample-usage }

* Verwenden Sie Maven, die {{ site.data.keys.mf_cli }} oder eine IDE Ihrer Wahl, um
den [JavaScript-HTTP-Adapter zu erstellen und zu implementieren](../../creating-adapters/). 
* Informationen zum Testen oder Debuggen eines Adapters enthält das Lernprogramm [Adapter testen und debuggen](../../testing-and-debugging-adapters). 
