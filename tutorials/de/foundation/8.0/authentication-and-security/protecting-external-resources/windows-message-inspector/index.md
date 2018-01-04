---
layout: tutorial
title: Windows .NET Message Inspector
breadcrumb_title: Windows .NET Message Inspector
relevantTo: [android,ios,windows,javascript]
weight: 4
downloads:
  - name: Beispiel herunterladen
    url: https://github.com/MobileFirst-Platform-Developer-Center/DotNetTokenValidator/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Dieses Lernprogramm zeigt, wie die einfache Windows-.NET-Ressource `GetBalanceService` mit einem Bereich (`accessRestricted`) geschützt wird.
In dem Beispiel wird ein Service verwendet, der von einer Konsolenanwendung mit der Bezeichnung DotNetTokenValidator bereitgestellt wird.

Zunächst werden wir einen **Message Inspector** definieren, der uns helfen wird,
die bei der Ressource `GetBalanceService` eingehende Anforderung zu kontrollieren.
Mit diesem Message Inspector werden wir die eingehende Anforderung untersuchen und überprüfen, ob sie alle
vom **{{ site.data.keys.product_adj }}-Autorisierungsserver** geforderten Header bereitstellt.

**Voraussetzungen:**

* Sie müssen das Lernprogramm [Externe Ressource mit {{ site.data.keys.mf_server }} authentifizieren](../) durchgehen. 
* Sie müssen das [{{ site.data.keys.product_adj }}-Sicherheitsframework](../../) verstehen.

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }
* [WCF-Web-HTTP-Service erstellen und konfigurieren](#create-and-configure-wcf-web-http-service)
* [Message Inspector definieren](#define-a-message-inspector)
* [Message Inspector implementieren](#message-inspector-implementation)
    * [Validierung vor Prozessbeginn](#pre-process-validation)
    * [Zugriffstoken vom {{ site.data.keys.product_adj }}-Autorisierungsserver anfordern](#obtain-access-token-from-mobilefirst-authorization-server)
    * [Anforderung mit Clienttoken an einen Introspektionsendpunkt senden](#send-request-to-introspection-endpoint-with-client-token)
    * [Validierung nach Prozessende](#post-process-validation)

## WCF-Web-HTTP-Service erstellen und konfigurieren
{: #create-and-configure-wcf-web-http-service }
Zunächst werden wir einen **WCF-Service** erstellen und den Service
`GetBalanceService` nennen. Später werden wir diesen Service mit einem **Message Inspector** schützen.
In unserem Beispiel werden wir eine Konsolenanwendung als Bereitstellungsprogramm für den Service verwenden. 

Es folgt der Code für (die geschützte Ressource) `getBalance`: 

```csharp
public class GetBalanceService : IGetBalanceService {
  public string getBalance()
  {
    Console.WriteLine("getBalance()");
    return "19938.80";
  }
}
```

Außerdem sollten wir eine Servicevereinbarung (`ServiceContract`) definieren:

```csharp
[ServiceContract]
public interface IGetBalanceService
{
  [OperationContract]
  [WebInvoke(Method = "GET",
  BodyStyle = WebMessageBodyStyle.Wrapped,
  ResponseFormat = WebMessageFormat.Json,
  UriTemplate = "getBalance")]
  string getBalance();
}
```

Unser Service ist bereit, sodass wir jetzt in der Datei App.config konfigurieren können, wie er von der Hostanwendung genutzt wird: 

```xml
<service behaviorConfiguration="Default" name="DotNetTokenValidator.GetBalanceService">
  <endpoint address="" behaviorConfiguration="webBehavior" binding="webHttpBinding" contract="DotNetTokenValidator.IGetBalanceService" />
  <host>
    <baseAddresses>
      <add baseAddress="http://localhost:8732/GetBalanceService" />
    </baseAddresses>
  </host>
</service>
```
Zum Schluss sollten wir den Service mit der Methode `Main` des Bereitstellungsprogramms ausführen:

```csharp
static void Main(string[] args) {
  // ServiceHost erstellen
  using (ServiceHost host = new ServiceHost(typeof(GetBalanceService)))
  {
    // Veröffentlichung der Metadaten ermöglichen
    ServiceMetadataBehavior smb = new ServiceMetadataBehavior();
    smb.HttpGetEnabled = true;

    Console.WriteLine("The service is ready at {0}", host.BaseAddresses[0]);
    host.Open();

    Console.WriteLine("Press <Enter> to stop the service.");
    Console.ReadLine();

    // ServiceHost schließen
    host.Close();
  }
}
```

> Weitere Informationen zu WCF-REST-Services finden Sie
unter [Create a Basic WCF Web HTTP Service](https://msdn.microsoft.com/en-us/library/bb412178(v=vs.100).



## Message Inspector definieren
{: #define-a-message-inspector}
Bevor wir uns mit dem Validierungsprozess beschäftigen, müssen wir einen
**Message Inspector** für den Schutz der Ressource (des Serviceendpunkts) erstellen und definieren.
Ein Message Inspector ist ein erweiterbares Objekt, das im Service
verwendet werden kann, um Nachrichten zu inspizieren und zu ändern, nachdem sie empfangen wurden oder bevor sie gesendet werden. Service-Message-Inspectors
sollten die Schnittstelle `IDispatchMessageInspector` implementieren: 

```csharp
public class MyInspector : IDispatchMessageInspector
```

Jeder Service-Message-Inspector muss die beiden
`IDispatchMessageInspector`-Methoden `AfterReceiveRequest` und `BeforeSendReply` implementieren:

```csharp
public class MyInspector : IDispatchMessageInspector {

  public object AfterReceiveRequest(ref Message request, IClientChannel channel, InstanceContext instanceContext){
  ...
  }

  public void BeforeSendReply(ref Message reply, object correlationState){
    // In unserem Fall ist hier kein Code erforderlich.
  }
}
```

Der erstellte Message Inspector sollte für den Schutz eines bestimmten Endpunkts definiert werden. Zu diesem Zweck werden Verhaltensweisen genutzt. Eine
Verhaltensweise (**behavior**) ist eine Klasse, die das Verhalten
der Servicemodelllaufzeit ändert, indem sie
die Standardkonfiguration ändert oder Erweiterungen
(wie Message Inspectors) zu dieser Konfiguration hinzufügt.
Dafür werden zwei Klassen verwendet. Eine der Klassen konfiguriert den Message Inspector für den Schutz
des Anwendungsendpunkts und die andere Klasse
gibt diese Instanz der Klasse "behavior" und den Typ zurück. 

```csharp
public class MyCustomBehavior : IEndpointBehavior
{
  ...
  public void ApplyDispatchBehavior(ServiceEndpoint endpoint, EndpointDispatcher endpointDispatcher)
  {
    endpointDispatcher.DispatchRuntime.MessageInspectors.Add(new MyInspector());
  }
  ...
}

public class MyCustomBehaviorExtension : BehaviorExtensionElement
{
  public override Type BehaviorType
  {
    get { return typeof(MyCustomBehavior); }
  }

  protected override object CreateBehavior()
  {
    return new MyCustomBehavior();
  }
}
```

In der Datei `App.config` definieren wir eine Erweiterung (`behaviorExtension`) und fügen sie an die gerade erstellte Klasse "behavior" an: 

```xml
<extensions>
  <behaviorExtensions>
    <add name="extBehavior" type="DotNetTokenValidator.Inspector.MyCustomBehaviorExtension, DotNetTokenValidator"/>
  </behaviorExtensions>
</extensions>
```

Anschließend fügen wir diese Erweiterung (behaviorExtension) zum Element webBehavior hinzu, das in unserem Service als Endpunktverhalten konfiguriert ist: 

```xml
<behavior name="webBehavior">
  <webHttp />
  <extBehavior />
</behavior>
```

## Message Inspector implementieren
{: #message-inspector-implementation}

Zunächst werden wir einige Konstanten als Klasseneinträge in unserem Message Inspector
definieren: die MobileFirst-Server-URL,
die Berechtigungsnachweise unseres vertraulichen Clients
und den Bereich (`scope`), den wir für den Schutz unseres Service verwenden werden. Wir können auch eine statische Variable für das vom
{{ site.data.keys.product_adj }}-Autorisierungsserver empfangene Token definieren, damit das Token für alle Benutzer verfügbar ist: 

```csharp
private const string azServerBaseURL = "http://YOUR-SERVER-URL:9080/mfp/api/az/v1/";
private const string scope = "accessRestricted";
private static string filterIntrospectionToken = null;
private const string filterUserName = "USERNAME"; // Benutzername des vertraulichen Clients
private const string filterPassword = "PASSWORD";  // Geheimer Schlüssel des vertraulichen Clients
```

Als Nächstes werden wir unsere Methode `validateRequest` erstellen, die den Ausgangspunkt für den Validierungsprozess bildet, den wir in unserem Message Inspector implementieren werden. Im Anschluss werden wir
einen Aufruf dieser Methode in die zuvor erwähnte Methode `AfterReceiveRequest` einfügen: 

```csharp
public object AfterReceiveRequest(ref Message request, IClientChannel channel, InstanceContext instanceContext){
  validateRequest(request);
  return null;
}
```

In `validateRequest` werden wir drei Hauptschritte implementieren: 

1. **Validierung vor Prozessbeginn** - Überprüfung, ob die Anforderung
einen **Authorization-Header** hat und ob dieser ggf. mit dem Präfix **"Bearer"** beginnt
2. **Abruf des Tokens** vom {{ site.data.keys.product_adj }}-Autorisierungsserver - Dieses Token wird verwendet,
um das dem {{ site.data.keys.product_adj }}-Autorisierungsserver vom Client präsentierte Token zu authentifizieren. 
3. **Validierung nach Prozessende** - Überprüfung auf **Konflikte**, Prüfung, ob die Anforderung an den richtigen
**Bereich** gesendet wurde, und Prüfung, ob die Anforderung **aktiv** ist.

```csharp
private void validateRequest(Message request)
{
  // Validierung vor Prozessbeginn: clientToken aus der Anforderung extrahieren und sicherstellen, dass das Token nicht leer ist und dass es mit "Bearer" beginnt.
  string clientToken = getClientTokenFromHeader(request);

  // Token abrufen
  if (filterIntrospectionToken == null)
  {
    filterIntrospectionToken = getIntrospectionToken();
  }

  // Mit dem im vorherigen Schritt empfangenen Token den an den MFP-Autorisierungsserver übergebenen Client-Authorization-Header überprüfen.
  HttpWebResponse introspectionResponse = introspectClientRequest(clientToken);

  // Überprüfung, ob introspectionToken abgelaufen ist (401)
  // - Ist das der Fall, ein neues Token abrufen und Clientanforderung erneut senden.
  if (introspectionResponse.StatusCode == HttpStatusCode.Unauthorized)
  {
    filterIntrospectionToken = getIntrospectionToken();
    introspectionResponse = introspectClientRequest(clientToken);
  }

  // Validierung nach Prozessende: Überprüfung, ob die Antwort des MFP-Autorisierungsservers gültig ist und den erforderlichen Bereich enthält.
  postProcess(introspectionResponse);
}
```

## Validierung vor Prozessbeginn
{: #pre-process-validation }
Die Validierung vor Prozessbeginn erfolgt im Rahmen der Methode getClientTokenFromHeader().
Für diese Validierung werden zwei Überprüfungen durchgeführt: 

1. Prüfung, dass der Authorization-Header der Anforderung nicht leer ist
2. Bei leerem Authorization-Header die Prüfung, dass der Header mit dem Präfix "Bearer" beginnt

In beiden Fällen sollte die Antowrt 401 (**Unauthorized Response Status**) lauten und der Header
**WWW-Authenticate:Bearer** hinzugefügt werden.   
Nach der Validierung des Authorization-Headers gibt diese Methode das von der Clientanwendung empfangene Token zurück. 

```csharp
private string getClientTokenFromHeader(Message request)
{
  string token = null;
  string authHeader = null;

  // Authorization-Header aus der Anforderung extrahieren
  var httpRequest = (HttpRequestMessageProperty)request.Properties[HttpRequestMessageProperty.Name];
  authHeader = httpRequest.Headers[HttpRequestHeader.Authorization];

  // Validierung vor Prozessbeginn
  if ((string.IsNullOrEmpty(authHeader) || !authHeader.StartsWith("Bearer", StringComparison.CurrentCulture)))
  {
    WebHeaderCollection webHeaderCollection = new WebHeaderCollection();
    webHeaderCollection.Add(HttpResponseHeader.WwwAuthenticate, "Bearer");
    returnErrorResponse(HttpStatusCode.Unauthorized, webHeaderCollection);
  }

  // Token ohne das Präfix "Bearer" extrahieren
  try {
    token = authHeader.Substring("Bearer ".Length);
  }
  catch (Exception ex) {
    Console.WriteLine(ex);
  }

  return token;
}
```

`returnErrorResponse` ist eine Helper-Methode, die einen HTTP-Statuscode (httpStatusCode) und eine Web-Header-Sammlung (WebHeaderCollection)
empfängt,
die Antwort erstellt und diese an die Clientanwendung sendet. Nach dem Senden der Antwort an die Clientanwendung führt die Methode die Anforderung aus. 

```csharp
private void returnErrorResponse(HttpStatusCode httpStatusCode, WebHeaderCollection headers)
{
  OutgoingWebResponseContext outgoingResponse = WebOperationContext.Current.OutgoingResponse;
  outgoingResponse.StatusCode = httpStatusCode;
  outgoingResponse.Headers.Add(headers);
  HttpContext.Current.Response.Flush();
  HttpContext.Current.Response.SuppressContent = true; // Senden von Inhalten verhindern. Es werden nur Header gesendet.
  HttpContext.Current.ApplicationInstance.CompleteRequest();
}
```

## Zugriffstoken vom {{ site.data.keys.product_adj }}-Autorisierungsserver anfordern
{: #obtain-access-token-from-mobilefirst-authorization-server}

Zum Authentifizieren des Clienttokens sollten wir mit einer Anforderung an den **Tokenendpunkt**
**ein Zugriffstoken als Message Inspector anfordern**.
Später werden wir dieses empfangene Token verwenden, um das Clienttoken zur Introspektion zu übergeben. 

```csharp
private string getIntrospectionToken()
{
  string returnVal = null;
  string strResponse = null;

  string Base64Credentials = Convert.ToBase64String(
    System.Text.ASCIIEncoding.ASCII.GetBytes(
      string.Format("{0}:{1}", filterUserName, filterPassword)
    )
  );

  // POST-Daten erstellen
  Dictionary<string, string> postParameters = new Dictionary<string, string> { };
  postParameters.Add("grant_type", "client_credentials");
  postParameters.Add("scope", "authorization.introspect");

  try {
    HttpWebResponse resp = sendRequest(postParameters, "token", "Basic " + Base64Credentials);
    Stream dataStream = resp.GetResponseStream();
    StreamReader reader = new StreamReader(dataStream);
    strResponse = reader.ReadToEnd();

    JToken token = JObject.Parse(strResponse);
    returnVal = (string)token.SelectToken("access_token");
  }
  catch (Exception ex) {
    Debug.WriteLine(ex);
  }

  return returnVal;
}
```

Die Methode `sendRequest` ist eine Helper-Methode, die für das Senden von Anforderungen
an den {{ site.data.keys.product_adj }}-Autorisierungsserver verantwortlich ist.   
Sie wird von `getIntrospectionToken` verwendet, um eine Anforderung an den Tokenendpunkt zu senden, und von
der Methode `introspectClientRequest`, um eine Anforderung an den Introspektionsendpunkt zu senden. Diese Methode gibt
eine HTTP-Webantwort (`HttpWebResponse`) zurück, die wir in der Methode
`getIntrospectionToken` verwenden, um das Zugriffstoken (access_token) zu extrahieren und
als Message-Inspector-Token zu speichern. In der Methode `introspectClientRequest` wird die Antwort nur verwendet,
um die Antwort des MFP-Autorisierungsservers zurückzugeben. 

```csharp
private HttpWebResponse sendRequest(Dictionary<string, string> postParameters, string endPoint, string authHeader) {
  string postData = "";
  foreach (string key in postParameters.Keys)
  {
    postData += HttpUtility.UrlEncode(key) + "=" + HttpUtility.UrlEncode(postParameters[key]) + "&";
  }

  HttpWebRequest request = (HttpWebRequest)WebRequest.Create(new System.Uri(azServerBaseURL + endPoint));
  request.Method = "POST";
  request.ContentType = "application/x-www-form-urlencoded";
  request.Headers.Add(HttpRequestHeader.Authorization, authHeader);

  // POST-Daten anhängen
  byte[] data = Encoding.ASCII.GetBytes(postData);
  request.ContentLength = data.Length;
  Stream dataStream = request.GetRequestStream();
  dataStream.Write(data, 0, data.Length);
  dataStream.Close();

  return (HttpWebResponse)request.GetResponse();
}
```

## Anforderung mit Clienttoken an einen Introspektionsendpunkt senden
{: #send-request-to-introspection-endpoint-with-client-token }
Jetzt wurden wir vom {{ site.data.keys.product_adj }}-Autorisierungsserver autorisiert und können
den Inhalt des **Clienttokens validieren**. Wir senden eine Anforderung an den
**Introspektionsendpunkt**, fügen das im vorherigen Schritt empfangene Token (`filterIntrospectionToken`) zum Anforderungsheader hinzu
und das Clienttoken zu den POST-Daten der Anforderung.   
Anschließend werden wir die Antwort vom {{ site.data.keys.product_adj }}-Autorisierungsserver
in der Methode `postProcess` untersuchen. 

```csharp
private HttpWebResponse introspectClientRequest(string clientToken) {
  // POST-Daten erstellen - Clienttoken mit dem Schlüssel "token" zum Verzeichnis postParameters hinzufügen
  Dictionary<string, string> postParameters = new Dictionary<string, string> { };
  postParameters.Add("token", clientToken);

  // Anforderung mit der Methode sendRequest() senden und HttpWebResponse zurückgeben
  return sendRequest(postParameters, "introspection", "Bearer " + filterIntrospectionToken);
}
```

## Validierung nach Prozessende
{: #post-process-validation }
Bevor wir mit der Methode `postProcess` fortfahren, wollen wir sicherstellen,
dass der Status der Antwort nicht **401** (Unauthorized) ist.   
Ein Antwortstatus 401 (Unauthorized) an dieser Stelle zeigt an,
dass das Message-Inspector-Token (`filterIntrospectionToken`) abgelaufen ist. Wenn der Antwortstatus
401 (Unauthorized) ist, rufen wir `getIntrospectionToken` auf, um ein neues Token für den Message Inspector
abzurufen. Dann rufen wir mit dem neuen Token erneut `introspectClientRequest` auf. 

```csharp
if (introspectionResponse.StatusCode == HttpStatusCode.Unauthorized)
{
  filterIntrospectionToken = getIntrospectionToken();
  introspectionResponse = introspectClientRequest(clientToken);
}
```

Der Hauptzweck der Methode postProcess ist, die vom {{ site.data.keys.product_adj }}-Autorisierungsserver empfangene Antwort zu untersuchen.
Bevor wir jedoch die Antwort extrahieren und überprüfen, müssen wir **sicherstellen, dass der Antwortstatus 200 (OK) ist**. Wenn der Antwortstatus
**409 (Conflict)** ist, sollten wir diese Antwort an die Clientanwendung weiterleiten.
Andernfalls sollten wir eine Ausnahme auslösen.   
Wenn der Antwortstatus 200 (OK) ist, initialisieren wir die Klasse `AzResponse` (die für die Darstellung der
Antwort des {{ site.data.keys.product_adj }}-Autorisierungsservers definiert ist) mit der aktuellen Antwort. Dann vergewissern wir uns, dass die
**Antwort aktiv ist** und den richtigen **Bereich** enthält:

```csharp
private void postProcess(HttpWebResponse introspectionResponse)
{
  if (introspectionResponse.StatusCode != HttpStatusCode.OK) // Make sure that HttpStatusCode = 200 ok (before checking active==true & scope)
  {
    if (introspectionResponse.StatusCode == HttpStatusCode.Unauthorized) // Wir haben ein Problem, weil wir bereits ein neues Token angefordert haben.
    {
      throw new WebFaultException<string>("Authentication did not succeed, Please try again...", HttpStatusCode.BadRequest);
    }
    else if (introspectionResponse.StatusCode == HttpStatusCode.Conflict) // Antwort 409 (Conflict) überprüfen
    {
      returnErrorResponse(HttpStatusCode.Conflict, introspectionResponse.Headers);
    }
    else
    {
      throw new WebFaultException<string>("Authentication did not succeed, Please try again...", HttpStatusCode.BadRequest);
    }
  }
  else
  {                
    AzResponse azResp = new AzResponse(introspectionResponse); // Antwort an ein Objekt übergeben
    WebHeaderCollection webHeaderCollection = new WebHeaderCollection();

    if (!azResp.isActive)
    {                    
      webHeaderCollection.Add(HttpResponseHeader.WwwAuthenticate, "Bearer error=\"invalid_token\"");
      returnErrorResponse(HttpStatusCode.Unauthorized, webHeaderCollection);
    }
    else if (!azResp.scope.Contains(scope))
    {
      webHeaderCollection.Add(HttpResponseHeader.WwwAuthenticate, "Bearer error=\"insufficient_scope\", scope=\"" + scope + "\"");
      returnErrorResponse(HttpStatusCode.Forbidden, webHeaderCollection);
    }               
  }           
}
```

## Beispielanwendung
{: #sample-application }
[Laden Sie das Beispiel mit dem .NET Message Inspector herunter](https://github.com/MobileFirst-Platform-Developer-Center/DotNetTokenValidator/tree/release80).

### Verwendung des Beispiels
{: #sample-usage }
1. Verwenden Sie Visual Studio, um das Beispiel zu öffnen und als Service zu erstellen und auszuführen. (Führen Sie Visual Studio als Administrator aus.) 
2. Sie müssen [den vertraulichen Client](../#confidential-client)
und die geheimen Schlüssel in der {{ site.data.keys.mf_console }} aktualisieren.
3. Implementieren Sie eine der Sicherheitsüberprüfungen: **[UserLogin](../../user-authentication/security-check/)**
oder **[PinCodeAttempts](../../credentials-validation/security-check/)**.
4. Registrieren Sie die passende Anwendung. 
5. Ordnen Sie der Sicherheitsüberprüfung den Bereich `accessRestricted` zu. 
6. Aktualisieren Sie die Clientanwendung so, dass `WLResourceRequest` Ihre Servlet-URL ist. 
