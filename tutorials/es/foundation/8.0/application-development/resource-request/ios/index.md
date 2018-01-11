---
layout: tutorial
title: Solicitud de recursos desde aplicaciones de iOS
breadcrumb_title: iOS
relevantTo: [ios]
downloads:
  - name: Download Xcode project
    url: https://github.com/MobileFirst-Platform-Developer-Center/ResourceRequestSwift/tree/release80
  - name: Download Adapter Maven project
    url: https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
Las aplicaciones {{ site.data.keys.product_adj }} pueden acceder a los recursos utilizando la API REST `WLResourceRequest`.
  
La API REST funciona con todos los adaptadores y recursos externos.

**Requisitos previos**:

- Asegúrese de que [añadió {{ site.data.keys.product }} SDK](../../../application-development/sdk/ios) a su proyecto iOS nativo.

- Aprenda a [crear adaptadores](../../../adapters/creating-adapters/).

## WLResourceRequest
{: #wlresourcerequest }
La clase `WLResourceRequest` maneja solicitudes de recursos para recursos externos o adaptadores.


Cree un objeto `WLResourceRequest` y especifique la vía de acceso al recurso y el método HTTP.
  
Los métodos disponibles son: `WLHttpMethodGet`, `WLHttpMethodPost`, `WLHttpMethodPut` y `WLHttpMethodDelete`.

Objective-C

```objc
WLResourceRequest *request = [WLResourceRequest requestWithURL:[NSURL URLWithString:@"/adapters/JavaAdapter/users/"] method:WLHttpMethodGet];
```
Swift

```swift
let request = WLResourceRequest(
    URL: NSURL(string: "/adapters/JavaAdapter/users"),
    method: WLHttpMethodGet
)
```

* Para **adaptadores JavaScript**, utilice `/adapters/{AdapterName}/{procedureName}`
* Para **adaptadores Java**, utilice `/adapters/{AdapterName}/{path}`.  La `vía de acceso` depende de la forma en que haya definido sus anotaciones `@Path` en su código Java.
También debería incluir todos los `@PathParam` que utilice.

* Para acceder a recursos fuera del proyecto, utilice el URL completo según los requisitos del servidor externo.

* **timeout**: Opcional, tiempo de espera de la solicitud en milisegundos. 

## Envío de la solicitud
{: #sending-the-request }
Solicite el recurso mediante el método `sendWithCompletionHandler`.
  
Proporcione un manejador de finalización para manejar los datos recuperados:


Objective-C

```objc
[request sendWithCompletionHandler:^(WLResponse *response, NSError *error) {
    if (error == nil){
        NSLog(@"%@", response.responseText);
    } else {
        NSLog(@"%@", error.description);
    }
}];
```
Swift

```swift
request.sendWithCompletionHandler { (response, error) -> Void in
    if(error == nil){
        NSLog(response.responseText)
    }
    else{
        NSLog(error.description)
    }
}
```

Otra posibilidad es utilizar `sendWithDelegate` y proporcionar un delegado que se adhiera a los dos protocolos `NSURLConnectionDataDelegate` y `NSURLConnectionDelegate`.
Esto permitirá manejar las respuestas con una mayor granularidad, por ejemplo, al manejar respuestas binarias.
   

## Parámetros
{: #parameters }
Antes de enviar su solicitud, podría desea añadir parámetros según sea necesario.


### Parámetros de vía de acceso
{: #path-parameters }
Tal como se ha explicado anteriormente, los parámetros de **vía de acceso** (`/path/value1/value2`) se establecen durante la creación del objeto `WLResourceRequest`.


### Parámetros de consulta
{: #query-parameters }
Para enviar parámetros de **consulta** (`/path?param1=value1...`) utilice el método `setQueryParameter` para cada parámetro:


Objective-C

```objc
[request setQueryParameterValue:@"value1" forName:@"param1"];
[request setQueryParameterValue:@"value2" forName:@"param2"];
```
Swift

```swift
request.setQueryParameterValue("value1", forName: "param1")
request.setQueryParameterValue("value2", forName: "param2")
```

#### Adaptadores JavaScript
{: #javascript-adapters-query }
Los adaptadores JavaScript utilizan parámetros sin nombre ordenados.
Para pasar parámetros a un adaptador JavaScript, establezca una matriz de parámetros con el nombre `params`:


Objective-C

```objc
[request setQueryParameterValue:@"['value1', 'value2']" forName:@"params"];
```

Swift

```swift
request.setQueryParameterValue("['value1', 'value2']", forName: "params")
```

Este debe utilizarse con `WLHttpMethodGet`.


### Parámetros de formulario
{: #form-parameters }
Para enviar parámetros del **formulario** en el cuerpo, utilice `sendWithFormParameters` en lugar de `sendWithCompletionHandler`:


Objective-C

```objc
//@FormParam("height")
NSDictionary *formParams = @{@"height":@"175"};

//Sending the request with Form parameters
[request sendWithFormParameters:formParams completionHandler:^(WLResponse *response, NSError *error) {
    if (error == nil){
        NSLog(@"%@", response.responseText);
    } else {
        NSLog(@"%@", error.description);
    }
}];
```
Swift

```swift
//@FormParam("height")
let formParams = ["height":"175"]

//Sending the request with Form parameters
request.sendWithFormParameters(formParams) { (response, error) -> Void in
    if(error == nil){
        NSLog(response.responseText)
    }
    else{
        NSLog(error.description)
    }
}
```

#### Adaptadores JavaScript
{: #javascript-adapters-form }
Los adaptadores JavaScript utilizan parámetros sin nombre ordenados.
Para pasar parámetros a un adaptador JavaScript, establezca una matriz de parámetros con el nombre `params`:


Objective-C

```objc
NSDictionary *formParams = @{@"params":@"['value1', 'value2']"};
```
Swift

```swift
let formParams = ["params":"['value1', 'value2']"]
```

Este debe utilizarse con `WLHttpMethodPost`.


### Parámetros de cabecera
{: #header-parameters }
Para enviar un parámetro como una cabecera HTTP utilice la API `setHeaderValue`:


Objective-C

```objc
//@HeaderParam("Date")
[request setHeaderValue:@"2015-06-06" forName:@"birthdate"];
```
Swift

```swift
//@HeaderParam("Date")
request.setHeaderValue("2015-06-06", forName: "birthdate")
```

### Otros parámetros de cuerpo personalizados
{: #other-custom-body-parameters }

- `sendWithBody` permite establecer una serie arbitraria en el cuerpo. 
- `sendWithJSON` permite establecer un diccionario arbitrario en el cuerpo. 
- `sendWithData` permite establecer un `NSData` arbitrario en el cuerpo. 

### Cola de devolución de llamada para completionHandler y delegado
Con el propósito de evitar el bloqueo de la interfaz de usuario mientras se reciben respuestas, se puede especificar una cola de devoluciones de llamada privadas para ejecutar el bloque completionHandler o un delegado para el conjunto de API `sendWithCompletionHandler` y `sendWithDelegate`.


#### Objective-C

```objc
//creating callback queue
dispatch_queue_t completionQueue = dispatch_queue_create("com.ibm.mfp.app.callbackQueue", DISPATCH_QUEUE_SERIAL);

//Sending the request with callback queue
[request sendWithCompletionHandler:completionQueue completionHandler:^(WLResponse *response, NSError *error) {
    if (error == nil){
        NSLog(@"%@", response.responseText);
    } else {
        NSLog(@"%@", error.description);
    }
}];
```
#### Swift

```swift
//creating callback queue
var completionQueue = dispatch_queue_create("com.ibm.mfp.app.callbackQueue", DISPATCH_QUEUE_SERIAL)

//Sending the request with callback queue
request.sendWithCompletionHandler(completionQueue) { (response, error) -> Void in
  if (error == nil){
      NSLog(@"%@", response.responseText);
  } else {
      NSLog(@"%@", error.description);
  }
}
```

## La respuesta
{: #the response }
El objeto `response` contiene los datos de respuesta. Utilice todos sus métodos y propiedades para recuperar la información necesaria.
Las propiedades utilizadas habitualmente son `responseText` (String), `responseJSON` (objeto Dictionary) (si la respuesta está en JSON) y `status` (Int) (en el estado HTTP de la respuesta).


Utilice los objetos `response` y `error` para obtener datos recuperados por el adaptador.


## Para obtener más información
{: #for-more-information }
> Para obtener más información sobre WLResourceRequest, [consulte la Referencia de API](../../../api/client-side-api/objc/client/).

<img alt="Imagen de la aplicación de ejemplo" src="resource-request-success-ios.png" style="margin-left: 15px; float:right"/>
## Aplicación de ejemplo
{: #sample-application }
El proyecto ResourceRequestSwift contiene una aplicación iOS, implementada en Swift, que realiza una solicitud se recurso mediante un adaptador de Java.
  
El proyecto Maven de adaptador contiene el adaptador Java utilizado durante la llamada de solicitud de recurso.


[Pulse para descargar](https://github.com/MobileFirst-Platform-Developer-Center/ResourceRequestSwift/tree/release80) el proyecto iOS.
  
[Pulse para descargar](https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80) el proyecto Maven del adaptador.  

### Uso de ejemplo
{: #sample-usage }
Siga el archivo README.md de ejemplo para obtener instrucciones.

#### Nota sobre iOS 9:
{: #note-about-ios-9 }

> Xcode 7 habilita [ATS (Application Transport Security)](https://developer.apple.com/library/ios/releasenotes/General/WhatsNewIniOS/Articles/iOS9.html#//apple_ref/doc/uid/TP40016198-SW14) de forma predeterminada.
Para completar la guía de aprendizaje inhabilite ATS ([pulse aquí para obtener más información](http://iosdevtips.co/post/121756573323/ios-9-xcode-7-http-connect-server-error)).

>   1. En Xcode, pulse con el botón derecho del ratón sobre **archivo [proyecto]/info.plist → Abrir como → Código fuente**
>   2. Pegue lo siguiente:

>
```xml
>      <key>NSAppTransportSecurity</key>
>      <dict>
>            <key>NSAllowsArbitraryLoads</key>
>            <true/>
>      </dict>
```
