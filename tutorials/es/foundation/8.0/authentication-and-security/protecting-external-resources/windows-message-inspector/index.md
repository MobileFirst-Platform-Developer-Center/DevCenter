---
layout: tutorial
title: Inspector de mensajes Windows .NET
breadcrumb_title: Windows .NET Message Inspector
relevantTo: [android,ios,windows,javascript]
weight: 4
downloads:
  - name: Download sample
    url: https://github.com/MobileFirst-Platform-Developer-Center/DotNetTokenValidator/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
Esta guía de aprendizaje le mostrará cómo proteger un recurso de Windows .NET simple `GetBalanceService`, utilizando un ámbito(`accessRestricted`).
En el ejemplo protegeremos un servicio autoalojado por una aplicación de consola denominada DotNetTokenValidator.

Primero definiremos un **inspector de mensajes** que nos ayudará a controlar la solicitud entrante en el recurso `GetBalanceService`.
Con este inspector de mensajes examinaremos la solicitud entrante y validaremos que proporciona todas las cabeceras necesarias que requiere el servidor de autorización de **{{ site.data.keys.product_adj }}**.

**Requisitos previos:**

* Asegúrese de leer la guía de aprendizaje [Utilización de {{ site.data.keys.mf_server }} para autenticar recursos externos](../).
* Comprensión de la infraestructura de seguridad de [{{ site.data.keys.product_adj }}](../../).

#### Ir a:
{: #jump-to }
* [Crear y configurar un servicio HTTP web de WCF](#create-and-configure-wcf-web-http-service)
* [Definir un inspector de mensaje](#define-a-message-inspector)
* [Implementación de inspector de mensaje](#message-inspector-implementation)
    * [Validación de proceso previo](#pre-process-validation)
    * [Obtener señal de acceso del servidor de autorización de {{ site.data.keys.product_adj }}](#obtain-access-token-from-mobilefirst-authorization-server)
    * [Enviar una solicitud al punto final de introspección con la señal de cliente](#send-request-to-introspection-endpoint-with-client-token)
    * [Validación de proceso posterior](#post-process-validation)

## Crear y configurar un servicio HTTP web de WCF
{: #create-and-configure-wcf-web-http-service }
Primero crearemos un **servicio WCF** y le denominaremos `GetBalanceService`, que posteriormente protegeremos con un **inspector de mensaje**.
En el ejemplo utilizamos una aplicación de consola como programa de host para el servicio.

A continuación encontrará el código de `getBalance` (el recurso protegido):

```csharp
public class GetBalanceService : IGetBalanceService {
  public string getBalance()
  {
    Console.WriteLine("getBalance()");
    return "19938.80";
  }
}
```

También definiremos `ServiceContract`:

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

Ahora que el servicio está listo, podemos configurar cómo lo utilizará la aplicación de host. Esta acción se lleva a cabo en el archivo App.config de la siguiente manera:

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
Finalmente, lo ejecutaremos en el método `Main` del programa de host:

```csharp
static void Main(string[] args) {
  // Create the ServiceHost.
  using (ServiceHost host = new ServiceHost(typeof(GetBalanceService)))
  {
    // Enable metadata publishing.
    ServiceMetadataBehavior smb = new ServiceMetadataBehavior();
    smb.HttpGetEnabled = true;

    Console.WriteLine("The service is ready at {0}", host.BaseAddresses[0]);
    host.Open();

    Console.WriteLine("Press <Enter> to stop the service.");
    Console.ReadLine();

    // Close the ServiceHost.
    host.Close();
  }
}
```

> Para obtener más información acerca de los servicios REST WCF, consulte [Crear un servicio HTTP web WCF](https://msdn.microsoft.com/en-us/library/bb412178(v=vs.100).aspx)

## Definir un inspector de mensaje
{: #define-a-message-inspector}
Antes de iniciar proceso de validación, es necesario crear y definir un **inspector de mensaje ** que utilizaremos para proteger el recurso (el punto final de servicio).
Un inspector de mensaje es un objeto de extensibilidad que puede utilizarse en el servicio para inspeccionar y alterar los mensajes después de haberlos recibido o antes de que se envíen. Los inspectores de mensaje de servicio deben implementar la interfaz `IDispatchMessageInspector`:

```csharp
public class MyInspector : IDispatchMessageInspector
```

Cualquier inspector de mensaje de servicio debe implementar los dos métodos `IDispatchMessageInspector`, `AfterReceiveRequest` y `BeforeSendReply`:

```csharp
public class MyInspector : IDispatchMessageInspector {

  public object AfterReceiveRequest(ref Message request, IClientChannel channel, InstanceContext instanceContext){
  ...
  }

  public void BeforeSendReply(ref Message reply, object correlationState){
    // In our case there is no need for any code here
  }
}
```

Después de crear el inspector de mensaje, debería definirse para proteger un punto final determinado. Esta acción se lleva a cabo utilizando comportamientos. Un **comportamiento** es una clase que modifica el comportamiento de un tiempo de ejecución de modelo de servicio cambiando la configuración predeterminada o añadiéndole extensiones (como los inspectores de mensajes).
Esta acción se lleva a cabo utilizando 2 clases: una que configura el inspector de mensajes para proteger el punto final de aplicación y el otro para devolver la instancia de clase de comportamiento  y el tipo.

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

En el archivo `App.config`, definimos `behaviorExtension` y lo adjuntamos a la clase de comportamiento que acabamos de crear:

```xml
<extensions>
  <behaviorExtensions>
    <add name="extBehavior" type="DotNetTokenValidator.Inspector.MyCustomBehaviorExtension, DotNetTokenValidator"/>
  </behaviorExtensions>
</extensions>
```

A continuación, añadimos behaviorExtension al elemento webBehavior configurado en nuestro servicio como un comportamiento de punto final:

```xml
<behavior name="webBehavior">
  <webHttp />
  <extBehavior />
</behavior>
```

## Implementación de inspector de mensajes
{: #message-inspector-implementation}

Primero definimos algunas constantes como miembros de clase en el inspector de mensaje: URL de {{ site.data.keys.mf_server }}, las credenciales de cliente confidenciales y el `ámbito` que utilizaremos para proteger el servicio. También podemos definir una variable estática para conservar la señal que hemos recibido del servidor de autorización de {{ site.data.keys.product_adj }}, de manera que esté  disponible para todos los usuarios:

```csharp
private const string azServerBaseURL = "http://YOUR-SERVER-URL:9080/mfp/api/az/v1/";
private const string scope = "accessRestricted";
private static string filterIntrospectionToken = null;
private const string filterUserName = "USERNAME"; // Confidential Client Username
private const string filterPassword = "PASSWORD";  // Confidential Client Secret
```

A continuación, crearemos el método `validateRequest`, que es el punto de partida del proceso de validación que implementaremos en el inspector de mensaje. Añadiremos una llamada a este método dentro del método `AfterReceiveRequest` que hemos mencionado anteriormente:

```csharp
public object AfterReceiveRequest(ref Message request, IClientChannel channel, InstanceContext instanceContext) {
  validateRequest(request);
  return null;
}
```

En `validateRequest` hay 3 pasos principales que implementaremos:

1. **Validación de proceso previo** - compruebe si la solicitud tiene una **cabecera de autorización**, y en caso de que la tenga, si empieza con el prefijo **"Bearer"**.
2. **Obtenga una señal ** del servidor de autorización de {{ site.data.keys.product_adj }} - Esta señal se utilizará para autenticar la señal del cliente en relación con el servidor de autorización de {{ site.data.keys.product_adj }}.
3. **Validación de proceso posterior** - compruebe si hay **conflictos**, valide que ha enviado la solicitud al **ámbito** correcto y compruebe que la solicitud está **activa**.

```csharp
private void validateRequest(Message request)
{
  // Pre-process validation: Eextract the clientToken out of the request, check it is not empty and that it starts with "Bearer"
  string clientToken = getClientTokenFromHeader(request);

  // Get token          
  if (filterIntrospectionToken == null)
  {
    filterIntrospectionToken = getIntrospectionToken();
  }

  // Check client auth header against mfp authrorization server using the token I received in previous step
  HttpWebResponse introspectionResponse = introspectClientRequest(clientToken);

  // Check if introspectionToken has expired (401)
  // - if so we should obtain a new token and resend the client request
  if (introspectionResponse.StatusCode == HttpStatusCode.Unauthorized)
  {
    filterIntrospectionToken = getIntrospectionToken();
    introspectionResponse = introspectClientRequest(clientToken);
  }

  // Post-process validation: check that the MFP authrorization server response is valid and includes the requested scope
  postProcess(introspectionResponse);
}
```

## Validación de proceso previo
{: #pre-process-validation }
La validación del proceso previo se realiza como parte del método getClientTokenFromHeader().
Este proceso se basa en dos comprobaciones:

1. Compruebe que la cabecera de autorización de la solicitud no está vacía.
2. Si no lo está, compruebe que la cabecera de autorización empieza con el prefijo "Bearer".

En ambos casos, debemos responder con un **estado de respuesta no autorizado** (401) y la cabecera **WWW-Authenticate:Bearer**.  
Después de validar la cabecera de autorización el método devuelve la señal recibida de la aplicación cliente.

```csharp
private string getClientTokenFromHeader(Message request)
{
  string token = null;
  string authHeader = null;

  // Extract the authorization header from the request
  var httpRequest = (HttpRequestMessageProperty)request.Properties[HttpRequestMessageProperty.Name];
  authHeader = httpRequest.Headers[HttpRequestHeader.Authorization];

  // Pre-process validation         
  if ((string.IsNullOrEmpty(authHeader) || !authHeader.StartsWith("Bearer", StringComparison.CurrentCulture)))
  {
    WebHeaderCollection webHeaderCollection = new WebHeaderCollection();
    webHeaderCollection.Add(HttpResponseHeader.WwwAuthenticate, "Bearer");
    returnErrorResponse(HttpStatusCode.Unauthorized, webHeaderCollection);
  }

  // extract the token without the "Bearer " prefix
  try {               
    token = authHeader.Substring("Bearer ".Length);
  }
  catch (Exception ex) {
    Console.WriteLine(ex);
  }

  return token;
}
```

`returnErrorResponse` es un método de ayuda que recibe httpStatusCode y WebHeaderCollection, prepara la respuesta y la devuelve a la aplicación cliente. Después de enviar la respuesta a la aplicación cliente, completa la solicitud.

```csharp
private void returnErrorResponse(HttpStatusCode httpStatusCode, WebHeaderCollection headers)
{
  OutgoingWebResponseContext outgoingResponse = WebOperationContext.Current.OutgoingResponse;
  outgoingResponse.StatusCode = httpStatusCode;
  outgoingResponse.Headers.Add(headers);
  HttpContext.Current.Response.Flush();
  HttpContext.Current.Response.SuppressContent = true; //Prevent sending content - only headers will be sent
  HttpContext.Current.ApplicationInstance.CompleteRequest();
}
```

## Obtener acceso a la señal de acceso del servidor de autorización de {{ site.data.keys.product_adj }}
{: #obtain-access-token-from-mobilefirst-authorization-server}

Para poder autenticar la señal de cliente deberíamos **obtener una señal de acceso como el inspector de mensaje** realizando una solicitud al **punto final de señal**.
Más adelante utilizaremos esta señal recibida para la introspección de la señal de cliente.

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

  // Prepare Post Data
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

El método `sendRequest` es un método de ayuda responsable de enviar solicitudes al servidor de autorización de {{ site.data.keys.product_adj }}.  
El método `getIntrospectionToken` lo está utilizando para enviar una solicitud al punto final de la señal, e `introspectClientRequest` para enviar una solicitud al punto final de introspección. Este método devuelve `HttpWebResponse`, que debemos utilizar en el método `getIntrospectionToken` para extraer la señal de acceso y almacenarla como señal de inspector de mensaje. En el método `introspectClientRequest` se utiliza solo para devolver la respuesta de servidor de autorización de MFP.

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

  // Attach Post Data
  byte[] data = Encoding.ASCII.GetBytes(postData);
  request.ContentLength = data.Length;
  Stream dataStream = request.GetRequestStream();
  dataStream.Write(data, 0, data.Length);
  dataStream.Close();

  return (HttpWebResponse)request.GetResponse();
}
```

## Enviar una solicitud al punto final de introspección con la señal de cliente
{: #send-request-to-introspection-endpoint-with-client-token }
Ahora que el servidor de autorización de {{ site.data.keys.product_adj }} nos ha autorizado, podemos **validar el contenido de la señal de cliente**. Enviamos una solicitud al **punto final de introspección**, añadiendo la señal que hemos recibido en el paso previo (`filterIntrospectionToken`) a la cabecera de solicitud y la señal de cliente en los datos de publicación de la solicitud.  
A continuación, examinaremos la respuesta del servidor de autorización de {{ site.data.keys.product_adj }} en el método `postProcess`.

```csharp
private HttpWebResponse introspectClientRequest(string clientToken) {
  // Prepare the Post Data - add the client token to the postParameters dictionary with the key "token"
  Dictionary<string, string> postParameters = new Dictionary<string, string> { };
  postParameters.Add("token", clientToken);

  // send the request using the sendRequest() method and return an HttpWebResponse
  return sendRequest(postParameters, "introspection", "Bearer " + filterIntrospectionToken);
}
```

## Validación de proceso posterior
{: #post-process-validation }
Antes de proceder al método `postProcess` queremos asegurarnos de que el estado de respuesta no es **401 (no autorizado)**.  
El estado de respuesta 401 (no autorizado) indica que la señal del inspector de mensaje (`filterIntrospectionToken`) ha caducado. Si el estado de respuesta es 401 (no autorizado), llamamos a `getIntrospectionToken` para obtener una nueva señal para el inspector de mensajes y, a continuación, a `introspectClientRequest` con la nueva señal.

```csharp
if (introspectionResponse.StatusCode == HttpStatusCode.Unauthorized)
{
  filterIntrospectionToken = getIntrospectionToken();
  introspectionResponse = introspectClientRequest(clientToken);
}
```

El propósito principal del método postProcess es examinar la respuesta que hemos recibido del servidor de autorización de {{ site.data.keys.product_adj }}, pero antes de extraer y comprobar la respuesta, debemos **asegurarnos de que el estado de respuesta es 200 (aceptado)**. Si el estado de respuesta es **409 (conflicto)** deberíamos reenviar la respuesta a la aplicación cliente o, de lo contrario, lanzar una excepción.  
Si el estado de respuesta es 200 (aceptado), debemos inicializar la clase `AzResponse`, que es una clase definida para representar la respuesta del servidor de autorización de {{ site.data.keys.product_adj }} con la respuesta actual. A continuación, comprobamos que la **respuesta está activa** y que incluye el **ámbito correcto**:

```csharp
private void postProcess(HttpWebResponse introspectionResponse)
{
  if (introspectionResponse.StatusCode != HttpStatusCode.OK) // Make sure that HttpStatusCode = 200 ok (before checking active==true & scope)
  {
    if (introspectionResponse.StatusCode == HttpStatusCode.Unauthorized) // We have a real problem since we already obtained a new token
    {
      throw new WebFaultException<string>("Authentication did not succeed, Please try again...", HttpStatusCode.BadRequest);
    }
    else if (introspectionResponse.StatusCode == HttpStatusCode.Conflict) // Check Conflict response (409)
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
    AzResponse azResp = new AzResponse(introspectionResponse); // Casting the response to an object
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

## Aplicación de ejemplo
{: #sample-application }
[Descargue el ejemplo de inspector de mensaje .NET](https://github.com/MobileFirst-Platform-Developer-Center/DotNetTokenValidator/tree/release80).

### Uso de ejemplo
{: #sample-usage }
1. Utilice Visual Studio para abrir, crear y ejecutar una muestra como servicio (ejecutar Visual Studio como administrador).
2. Asegúrese de [actualizar el cliente confidencial](../#confidential-client) y los valores secretos en {{ site.data.keys.mf_console }}.
3. Despliegue alguna de las comprobaciones de seguridad: **[UserLogin](../../user-authentication/security-check/)** o **[PinCodeAttempts](../../credentials-validation/security-check/)**.
4. Registre la aplicación coincidente.
5. Correlacione el ámbito `accessRestricted` en la comprobación de seguridad.
6. Actualice la aplicación de cliente para crear `WLResourceRequest` en su URL de servlet.
