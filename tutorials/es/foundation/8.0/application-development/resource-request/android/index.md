---
layout: tutorial
title: Solicitud de recursos de aplicaciones Android
breadcrumb_title: Android
relevantTo: [android]
downloads:
  - name: Download Android Studio project
    url: https://github.com/MobileFirst-Platform-Developer-Center/ResourceRequestAndroid/tree/release80
  - name: Download Adapter Maven project
    url: https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80
weight: 5
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
Las aplicaciones {{ site.data.keys.product_adj }} pueden acceder a los recursos utilizando la API REST `WLResourceRequest`.  
La API REST funciona con todos los adaptadores y recursos externos.

**Requisitos previos**:

- Asegúrese de que [añadió {{ site.data.keys.product }} SDK](../../../application-development/sdk/android) a su proyecto Android nativo.
- Aprenda a [crear adaptadores](../../../adapters/creating-adapters).

## WLResourceRequest
{: #wlresourcerequest }
La clase `WLResourceRequest` maneja solicitudes de recursos para recursos externos o adaptadores.

Cree un objeto `WLResourceRequest` y especifique la vía de acceso al recurso y el método HTTP.  
Los métodos disponibles son: `WLResourceRequest.GET`, `WLResourceRequest.POST`, `WLResourceRequest.PUT`, `WLResourceRequest.HEAD` y `WLResourceRequest.DELETE`.

```java
URI adapterPath = URI.create("/adapters/JavaAdapter/users");
WLResourceRequest request = new WLResourceRequest(adapterPath,WLResourceRequest.GET);
```

* Para **adaptadores JavaScript**, utilice `/adapters/{AdapterName}/{procedureName}`
* Para **adaptadores Java**, utilice `/adapters/{AdapterName}/{path}`. La `vía de acceso` depende de la forma en que haya definido sus anotaciones `@Path` en su código Java. También debería incluir todos los `@PathParam` que utilice.
* Para acceder a recursos fuera del proyecto, utilice el URL completo según los requisitos del servidor externo.
* **timeout**: Opcional, tiempo de espera de la solicitud en milisegundos.
* **scope**: Opcional, ámbito que está protegiendo el recurso. Si especifica este ámbito, podría hacer que la solicitud fuese más eficiente.

## Envío de la solicitud
{: #sending-the-request }
Solicite el recurso mediante el método `.send()`. Especifique una instancia de clase WLResponseListener:

```java
request.send(new WLResponseListener(){
  public void onSuccess(WLResponse response) {
    Log.d("Success", response.getResponseText());
  }
  public void onFailure(WLFailResponse response) {
    Log.d("Failure", response.getResponseText());
  }
});
```

## Parámetros
{: #parameters }
Antes de enviar su solicitud, podría desea añadir parámetros según sea necesario.

### Parámetros de vía de acceso
{: #path-parameters }
Tal como se ha explicado anteriormente, los parámetros de **vía de acceso** (`/path/value1/value2`) se establecen durante la creación del objeto `WLResourceRequest`:

```java
URI adapterPath = new URI("/adapters/JavaAdapter/users/value1/value2");
WLResourceRequest request = new WLResourceRequest(adapterPath,WLResourceRequest.GET);
```

### Parámetros de consulta
{: #query-parameters }
Para enviar parámetros de **consulta** (`/path?param1=value1...`) utilice el método `setQueryParameter` para cada parámetro:

```java
request.setQueryParameter("param1","value1");
request.setQueryParameter("param2","value2");
```

#### Adaptadores JavaScript
{: #javascript-adapters }
Los adaptadores JavaScript utilizan parámetros sin nombre ordenados. Para pasar parámetros a un adaptador JavaScript, establezca una matriz de parámetros con el nombre `params`:

```java
request.setQueryParameter("params","['value1', 'value2']");
```

Se debería utilizar con `WLResourceRequest.GET`.

### Parámetros de formulario
{: #form-parameters }
Para enviar parámetros de formulario en el cuerpo, utilice `.send(HashMap<String, String> formParameters, WLResponseListener)` en lugar de `.send(WLResponseListener)`:  

```java
HashMap formParams = new HashMap();
formParams.put("height", height.getText().toString());
request.send(formParams, new MyInvokeListener());
```    

#### Parámetros - adaptadores JavaScript
{: #parameters-javascript-adapters}
Los adaptadores JavaScript utilizan parámetros sin nombre ordenados. Para pasar parámetros a un adaptador JavaScript, establezca una matriz de parámetros con el nombre `params`:

```java
formParams.put("params", "['value1', 'value2']");
```

Esto se debería utilizar con `WLResourceRequest.POST`.

### Parámetros de cabecera
{: #header-parameters }
Para enviar un parámetro como una cabecera HTTP utilice la API `.addHeader()`:

```java
request.addHeader("date", date.getText().toString());
```

### Otros parámetros de cuerpo personalizados
{: #other-custom-body-parameters }
- `.send(requestBody, WLResponseListener listener)` permite establecer una serie arbitraria en el cuerpo.
- `.send(JSONStore json, WLResponseListener listener)` permite establecer un diccionario arbitrario en el cuerpo.
- `.send(byte[] data, WLResponseListener listener)` permite establecer un matriz de bytes arbitraria en el cuerpo.

## La respuesta
{: #the-response }
El objeto `response` contiene los datos de respuesta. Utilice todos sus métodos y propiedades para recuperar la información necesaria. Las propiedades utilizadas habitualmente son `responseText` (String), `responseJSON` (objeto JSON) (si la respuesta está en JSON) y `status` (Int) (el estado HTTP de la respuesta).

Utilice los objetos `WLResponse response` y `WLFailResponse response` para obtener los datos recuperados desde el adaptador.

## Para obtener más información
{: #for-more-information }
> Para obtener más información sobre WLResourceRequest, [consulte la Referencia de API](../../../api/client-side-api/java/client/).

<img alt="Imagen de la aplicación de ejemplo" src="resource-request-success-android.png" style="float:right"/>
## Aplicación de ejemplo
{: #sample-application }
El proyecto ResourceRequestAndroid contiene una aplicación Android nativa que realiza una solicitud de recurso mediante un adaptador de Java.  
El proyecto Maven de adaptador contiene el adaptador Java utilizado durante la llamada de solicitud de recurso.

[Pulse para descargar](https://github.com/MobileFirst-Platform-Developer-Center/ResourceRequestAndroid/tree/release80) el proyecto de Android.  
[Pulse para descargar](https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80) el proyecto Maven del adaptador.

### Uso de ejemplo
{: #sample-usage }
Siga el archivo README.md de ejemplo para obtener instrucciones.
