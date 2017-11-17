---
layout: tutorial
title: Solicitud de recursos desde aplicaciones JavaScript (Cordova, Web)
breadcrumb_title: JavaScript
relevantTo: [javascript]
downloads:
  - name: Download Web project
    url: https://github.com/MobileFirst-Platform-Developer-Center/ResourceRequestWeb/tree/release80
  - name: Download Cordova project
    url: https://github.com/MobileFirst-Platform-Developer-Center/ResourceRequestCordova/tree/release80
  - name: Download Adapter Maven project
    url: https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
Las aplicaciones {{ site.data.keys.product_adj }} pueden acceder a los recursos utilizando la API REST `WLResourceRequest`.
  
La API REST funciona con todos los adaptadores y recursos externos.

**Requisitos previos**:

- Si está implementando una aplicación Cordova, asegúrese de que ha [añadido el {{ site.data.keys.product }} SDK](../../../application-development/sdk/cordova) a su aplicación de Cordova.

- Si está implementando una aplicación web, asegúrese de que ha [añadido el {{ site.data.keys.product }} SDK](../../../application-development/sdk/web) a su aplicación web.

- Aprenda a [crear adaptadores](../../../adapters/creating-adapters/).

## WLResourceRequest
{: #wlresourcerequest }
La clase `WLResourceRequest` maneja solicitudes de recursos para recursos externos o adaptadores.


Cree un objeto `WLResourceRequest` y especifique la vía de acceso al recurso y el método HTTP.
  
Los métodos disponibles son: `WLResourceRequest.GET`, `WLResourceRequest.POST`, `WLResourceRequest.PUT` y `WLResourceRequest.DELETE`.


```javascript
var resourceRequest = new WLResourceRequest(
    "/adapters/JavaAdapter/users",
    WLResourceRequest.GET
);
```

* Para **adaptadores JavaScript**, utilice `/adapters/{AdapterName}/{procedureName}`
* Para **adaptadores Java**, utilice `/adapters/{AdapterName}/{path}`.  La `vía de acceso` depende de la forma en que haya definido sus anotaciones `@Path` en su código Java.
También debería incluir todos los `@PathParam` que utilice.

* Para acceder a recursos fuera del proyecto, utilice el URL completo según los requisitos del servidor externo.

* **timeout**: Opcional, tiempo de espera de la solicitud en milisegundos. 

## Envío de la solicitud
{: #sending-the-request }
Solicitud de recurso utilizando el método `send()`.
  
El método `send()` toma un parámetro opcional, que puede ser un objeto JSON o una serie de texto simple, establece un cuerpo con la solicitud HTTP .


Utilización de **promesas** para definir funciones de devolución de llamada `onSuccess` y `onFailure`.


```js
resourceRequest.send().then(
    onSuccess,
    onFailure
)
```

### setQueryParameter
{: #setqueryparameter }
Mediante la utilización del método `setQueryParameter`, puede incluir parámetros de consulta (URL) en la solicitud REST.


```js
resourceRequest.setQueryParameter("param1", "value1");
resourceRequest.setQueryParameter("param2", "value2");
```

#### Adaptadores JavaScript
{: #javascript-adapters-setquery}
Los adaptadores JavaScript utilizan parámetros sin nombre ordenados.
Para pasar parámetros a un adaptador JavaScript, establezca una matriz de parámetros con el nombre `params`:


> **Nota:** El valor `params` debería ser una *representación de serie* de una matriz. 

```js
resourceRequest.setQueryParameter("params", "['value1', 'value2']");
```

Se debería utilizar con `WLResourceRequest.GET`.

### setHeader
{: #setheader }
Mediante la utilización del método `setHeader`, puede establecer una nueva cabecera HTTP o sustituir una cabecera existente con el mismo nombre en la solicitud REST.


```js
resourceRequest.setHeader("Header-Name","value");
```

### sendFormParameters(json)
{: #sendformparamtersjson }
Para enviar parámetros de formulario codificados de URL, utilice en su lugar el método `sendFormParameters(json)`.
Este método convierte JSON en una serie codificada de URL, establece `content-type` en `application/x-www-form-urlencoded` y lo establece como un cuerpo HTTP:


```js
var formParams = {"param1": "value1", "param2": "value2"};
resourceRequest.sendFormParameters(formParams);
```

#### Adaptadores JavaScript
{: #javascript-adapters-sendform }
Los adaptadores JavaScript utilizan parámetros sin nombre ordenados.
Para pasar parámetros a un adaptador JavaScript, establezca una matriz de parámetros con el nombre `params`:


```js
var formParams = {"params":"['value1', 'value2']"};
```

Esto se debería utilizar con `WLResourceRequest.POST`.


> Para obtener más información sobre `WLResourceRequest`, consulte la referencia de API en la documentación del usuario.


## La respuesta
{: #the-response }
Tanto la llamada de devolución `onSuccess` como `onFailure` reciben un objeto `response`.
El objeto `response` contiene los datos de respuesta. Utilice todas sus propiedades para recuperar la información necesaria.
Las propiedades utilizadas habitualmente son `responseText`, `responseJSON` (objeto JSON, si la respuesta está en JSON) y `status` (el estado HTTP de la respuesta).


En caso de una respuesta anómala, el objeto `response` también contiene la propiedad `errorMsg`.
  
Dependiendo de su utiliza un adaptador Java o JavaScript, la respuesta puede contener otras propiedades como, por ejemplo, `responseHeaders`, `responseTime`, `statusCode`, `statusReason` y `totalTime`.

```json
{
  "responseHeaders": {
    "Content-Type": "application/json",
    "X-Powered-By": "Servlet/3.1",
    "Content-Length": "86",
    "Date": "Mon, 15 Feb 2016 21:12:08 GMT"
  },
  "status": 200,
  "responseText": "{\"height\":\"184\",\"last\":\"Doe\",\"Date\":\"1984-12-12\",\"age\":31,\"middle\":\"C\",\"first\":\"John\"}",
  "responseJSON": {
    "height": "184",
    "last": "Doe",
    "Date": "1984-12-12",
    "age": 31,
    "middle": "C",
    "first": "John"
  },
  "invocationContext": null
}
```

### Manejo de la respuesta
{: #handling-the-response }
El objeto response lo reciben las funciones de devolución de llamada `onSuccess` y `onFailure`.
  
Por ejemplo:


```js
onSuccess: function(response) {
    resultText = "Successfully called the resource: " + response.responseText;
},

onFailure: function(response) {
    resultText = "Failed to call the resource:" + response.errorMsg;
}
```

## Para obtener más información
{: #for-more-information }
> Para obtener más información sobre WLResourceRequest, [consulte la Referencia de API](../../../api/client-side-api/javascript/client/).

<img alt="Imagen de la aplicación de ejemplo" src="resource-request-success-cordova.png" style="float:right"/>
## Aplicaciones de ejemplo
{: #sample-applications }
Los proyectos **ResourceRequestWeb** y **ResourceRequestCordova** demuestran una solicitud de recurso mediante un adaptador Java.
  
El proyecto Maven de adaptador contiene el adaptador Java utilizado durante la llamada de solicitud de recurso.


[
Pulse para descargar](https://github.com/MobileFirst-Platform-Developer-Center/ResourceRequestCordova/tree/release80) el proyecto de Cordova.
  
[
Pulse para descargar](https://github.com/MobileFirst-Platform-Developer-Center/ResourceRequestWeb/tree/release80) el proyecto de web.
  
[Pulse para descargar](https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80) el proyecto Maven del adaptador.  

### Uso de ejemplo
{: #sample-usage }
Siga el archivo README.md de ejemplo para obtener instrucciones.
