---
layout: tutorial
title: Java-HTTP-Adapter
breadcrumb_title: HTTP Adapter
relevantTo: [ios,android,windows,javascript]
downloads:
  - name: Adapter-Maven-Projekt herunterladen
    url: https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }

Mit Java-Adaptern können Sie die Konnektivität zu einem Back-End-System steuern und kontrollieren. Der Entwickler ist daher dafür verantwortlich, bewährte Verfahren hinsichtlich der Leistung und anderer Implementierungsdetails anzuwenden. In diesem Lernprogramm gibt es ein Beispiel für einen Java-Adapter, der mit einem Java-`HttpClient` eine Verbindung zu einem RSS-Feed herstellt.

**Voraussetzung:** Arbeiten Sie zuerst das Lernprogramm [Java-Adapter](../) durch. 

>**Wichtiger Hinweis:** Wenn Sie in Ihrer Adapterimplementierung statische Referenzen auf Klassen von `javax.ws.rs.*` oder `javax.servlet.*` verwenden, müssen Sie **RuntimeDelegate** mit einer der folgenden Optionen konfigurieren:

*	Legen Sie in Liberty in der Datei `jvm.options` `-Djavax.ws.rs.ext.RuntimeDelegate=org.apache.cxf.jaxrs.impl.RuntimeDelegateImpl` fest.
ODER
*	Legen Sie Sie die Systemeigenschaft oder angepasste JVM-Eigenschaft `javax.ws.rs.ext.RuntimeDelegate=org.apache.cxf.jaxrs.impl.RuntimeDelegateImpl` fest.

## Adapter initialisieren
{: #initializing-the-adapter }

Im bereitgestellten Beispieladapter wird die Klasse `JavaHTTPApplication` verwendet,
um `MFPJAXRSApplication` zu erweitern. Dies ist ein bewährtes Verfahren zum Auslösen einer für Ihre Anwendung
erforderlichen Initialisierung. 

```java
@Override
    protected void init() throws Exception {
        JavaHTTPResource.init();
    logger.info("Adapter initialized!");
}
```

## Adapterressourcenklasse implementieren
{: #implementing-the-adapter-resource-class }

Die Adapterressourcenklasse behandelt Anforderungen an den Server.   
Im bereitgestellten Beispieladapter hat die Klasse den Namen `JavaHTTPResource`.

```java
@Path("/")
public class JavaHTTPResource {

}
```

`@Path("/")` bedeutet, dass die Ressourcen unter der URL `http(s)://host:port/ProjectName/adapters/AdapterName/` verfügbar sind.

### HTTP-Client
{: #http-client }

```java
private static CloseableHttpClient client;
private static HttpHost host;

public static void init() {
  client = HttpClientBuilder.create().build();
  host = new HttpHost("mobilefirstplatform.ibmcloud.com");
}
```

Da jedes Mal, wenn Ihre Ressource angefordert wird, eine neue Instanz von `JavaHTTPResource` erstellt wird,
ist es wichtig, Objekte mit Einfluss auf die Leistung wiederzuverwenden. In unserem Beispiel ist der HTTP-Client ein
statisches (`static`) Objekt, der in einer statischen Methode `init()` initialisiert wird, die
wie oben beschrieben von der Methode `init()` von `JavaHTTPApplication` aufgerufen wird. 

### Prozedurressource
{: #procedure-resource }

```java
@GET
@Produces("application/json")
public void get(@Context HttpServletResponse response, @QueryParam("tag") String tag)
    throws IOException, IllegalStateException, SAXException {
  if(tag!=null &&  !tag.isEmpty()){
    execute(new HttpGet("/blog/atom/"+ tag +".xml"), response);
  }
  else{
    execute(new HttpGet("/feed.xml"), response);
  }

}
```

Der Beispieladapter macht nur eine Ressourcen-URL zugänglich, über die Sie den RSS-Feed vom Back-End-Service abrufen können. 

* `@GET` bedeutet, dass diese Prozedur nur auf `HTTP GET`-Anforderungen reagiert. 
* `@Produces("application/json")` gibt den Inhaltstyp der zurückzusendenden Antwort an. In unserem Beispiel wird die Antwort zur Vereinfachung auf der Clientseite als `JSON`-Objekt gesendet. 
* `@Context HttpServletResponse response` wird verwendet, um den Ausgabedatenstrom der Antwort zu schreiben, und ermöglicht eine größere Detailgenauigkeit als die Rückgabe einer einfahcen Zeichenfolge. 
* Der Zeichenfolgetag `@QueryParam("tag")` ermöglicht der Prozedur, einen Parameter zu empfangen. Die Option `QueryParam` gibt an, dass der Parameter in der Abfrage übergeben werden muss (`/JavaHTTP/?tag=MobileFirst_Platform`). Weitere mögliche Optionen sind `@PathParam`, `@HeaderParam`, `@CookieParam`, `@FormParam` usw. 
* `throws IOException, ...` bedeutet, dass Ausnahmen zurück zum Client weitergeleitet werden. Der Client-Code ist für die Behandlung möglicher Ausnahmen zuständig, die als Fehler `HTTP 500` empfangen werden. Eine andere Lösung (die in Produktionscode favorisiert werden dürfte) ist die Behandlung von Ausnahmen im Server-Java-Code. Bei dieser Lösung kann ausgehend vom konkreten Fehler entschieden werden, was an den Client gesendet werden soll. 
* `execute(new HttpGet("/feed.xml"), response)` bedeutet, dass die eigentliche HTTP-Anforderung an den Back-End-Service von einer anderen, später definierten Methode behandelt wird. 

Der mit `execute`
abgerufene Build und Pfad sowie die abgerufene RSS-Datei hängen davon ab, ob Sie einen Parameter `tag` übergeben. 

### execute()
{: #execute }

```java
public void execute(HttpUriRequest req, HttpServletResponse resultResponse)
        throws IOException,
        IllegalStateException, SAXException {
    HttpResponse RSSResponse = client.execute(host, req);
    ServletOutputStream os = resultResponse.getOutputStream();
    if (RSSResponse.getStatusLine().getStatusCode() == HttpStatus.SC_OK){  
        resultResponse.addHeader("Content-Type", "application/json");
        String json = XML.toJson(RSSResponse.getEntity().getContent());
        os.write(json.getBytes(Charset.forName("UTF-8")));

    }else{
        resultResponse.setStatus(RSSResponse.getStatusLine().getStatusCode());
        RSSResponse.getEntity().getContent().close();
        os.write(RSSResponse.getStatusLine().getReasonPhrase().getBytes());
    }
    os.flush();
    os.close();
}
```

* `HttpResponse RSSResponse = client.execute(host, req)`: Der statische HTTP-Client wird verwendet, um die HTTP-Anforderung auszuführen und die Antwort zu speichern. 
* `ServletOutputStream os = resultResponse.getOutputStream()`: Dies ist der Ausgabedatenstrom zum Schreiben einer Antwort an den Client. 
* `resultResponse.addHeader("Content-Type", "application/json")`: Die Antwort wird, wie bereits erwähnt, als JSON gesendet. 
* `String json = XML.toJson(RSSResponse.getEntity().getContent())`: Für die Konvertierung von XML-RSS in eine JSON-Zeichenfolge wird `org.apache.wink.json4j.utils.XML` verwendet. 
* `os.write(json.getBytes(Charset.forName("UTF-8")))`: Dies resultierende JSON-Zeichenfolge wird in den Ausgabedatenstrom geschrieben. 

Für den Ausgabedatenstrom wird eine Flush-Operation (`flush`). Anschließend wird der Datenstrom geschlossen (`close`). 

Wenn die Antwort (`RSSResponse`) nicht `200 OK` lautet, werden stattdessen der Statuscode und die Ursache in die Antwort geschrieben. 

## Beispieladapter
{: #sample-adapter }

[Klicken Sie hier](https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80), um das Maven-Adapterprojekt herunterzuladen. 

Zum Maven-Adapterprojekt gehört der oben beschriebene **JavaHTTP**-Adapter. 

### Verwendung des Beispiels
{: #sample-usage }

* Verwenden Sie Maven, die {{ site.data.keys.mf_cli }} oder eine IDE Ihrer Wahl, um
den [Java-HTTP-Adapter zu erstellen und zu implementieren](../../creating-adapters/). 
* Informationen zum Testen oder Debuggen eines Adapters enthält das Lernprogramm [Adapter testen und debuggen](../../testing-and-debugging-adapters). 
