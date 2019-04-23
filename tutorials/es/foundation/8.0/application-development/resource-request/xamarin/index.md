---
layout: tutorial
title: Solicitud de recursos de aplicaciones Xamarin
breadcrumb_title: Xamarin
relevantTo: [xamarin]
downloads:
  - name: Download Xamarin project
    url: https://github.com/MobileFirst-Platform-Developer-Center/ResourceRequestXamarin/tree/release80
  - name: Download Adapter Maven project
    url: https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80
weight: 5
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
Las aplicaciones {{ site.data.keys.product_full }} pueden acceder a los recursos utilizando la API REST `WorklightResourceRequest`.  
La API REST funciona con todos los adaptadores y recursos externos.

**Requisitos previos**:

- Asegúrese de haber añadido {{ site.data.keys.product }} SDK a su [aplicación Xamarin](../../sdk/xamarin/) nativa.
- Aprenda a [crear adaptadores](../../../adapters/creating-adapters/).

## WLResourceRequest
{: #wlresourcerequest }
La clase `WorklightResourceRequest` maneja solicitudes de recursos para recursos externos o adaptadores.

Cree un objeto `WorklightResourceRequest` y especifique la vía de acceso al recurso y el método HTTP.  
Los métodos disponibles son: `GET`, `POST`, `PUT` y `DELETE`.

```cs
URI adapterPath = new URI("/adapters/JavaAdapter/users",UriKind.Relative);
WorklightResourceRequest request = WorklightClient.CreateInstance.ResourceRequest(adapterPath,"GET");
```

* Para **adaptadores JavaScript**, utilice `/adapters/{AdapterName}/{procedureName}`
* Para **adaptadores Java**, utilice `/adapters/{AdapterName}/{path}`. La `vía de acceso` depende de la forma en que haya definido sus anotaciones `@Path` en su código Java. También debería incluir todos los `@PathParam` que utilice.
* Para acceder a recursos fuera del proyecto, utilice el URL completo según los requisitos del servidor externo.
* **timeout**: Opcional, tiempo de espera de la solicitud en milisegundos.
* **scope**: Opcional, ámbito que está protegiendo el recurso. Si especifica este ámbito, podría hacer que la solicitud fuese más eficiente.

## Envío de la solicitud
{: #sending-the-request }
Solicite el recurso mediante el método `.send()`.

```cs
WorklightResponse response = await request.send();
```

Utilice el objeto `WorklightResponse response` para obtener los datos que se recuperan desde el adaptador.

El objeto `response` contiene los datos de respuesta. Utilice todos sus métodos y propiedades para recuperar la información necesaria. Las propiedades habitualmente utilizadas son `ResponseText`, `ResponseJSON` (si la respuesta está en JSON), `Success` (si la invocación fue satisfactoria o anómala) y `HTTPStatus` (el estado HTTP de la respuesta).

## Parámetros
{: #parameters }
Antes de enviar su solicitud, podría desea añadir parámetros según sea necesario.

### Parámetros de vía de acceso
{: #path-parameters }
Tal como se ha explicado anteriormente, los parámetros de **vía de acceso** (`/path/value1/value2`) se establecen durante la creación del objeto `WorklightResourceRequest`:

```cs
Uri adapterPath = new Uri("/adapters/JavaAdapter/users/value1/value2",UriKind.Relative);
WorklightResourceRequest request = WorklightClient.CreateInstance.ResourceRequest(adapterPath,"GET");
```

### Parámetros de consulta
{: #query-parameters }
Para enviar parámetros de **consulta** (`/path?param1=value1...`) utilice el método `SetQueryParameter` para cada parámetro:

```cs
request.SetQueryParameter("param1","value1");
request.SetQueryParameter("param2","value2");
```

#### Adaptadores JavaScript
{: #javascript-adapters-query }
Los adaptadores JavaScript utilizan parámetros sin nombre ordenados. Para pasar parámetros a un adaptador JavaScript, establezca una matriz de parámetros con el nombre `params`:

```cs
request.SetQueryParameter("params","['value1', 'value2']");
```

Esto se debería utilizar con `GET`.

### Parámetros de formulario
{: #form-parameters }
Para enviar parámetros de formulario en el cuerpo, utilice `.Send(Dictionary<string, string> formParameters)` en lugar de `.Send()`:  

```cshrap
Dictionary<string,string> formParams = new Dictionary<string,string>();
formParams.Add("height", height.getText().toString());
request.Send(formParams);
```   

#### Adaptadores JavaScript
{: #javascript-adapters-form }
Los adaptadores JavaScript utilizan parámetros sin nombre ordenados. Para pasar parámetros a un adaptador JavaScript, establezca una matriz de parámetros con el nombre `params`:

```cs
formParams.Add("params","['value1', 'value2']");
```

Esto se debería utilizar con `POST`.

### Parámetros de cabecera
{: #header-parameters }
Para enviar un parámetro como una cabecera HTTP utilice la API `.SetHeader()`:

```cs
System.Net.WebHeaderCollection headerCollection = new WebHeaderCollection();

headerCollection["key"] = value;

request.AddHeader(headerCollection);
```

### Otros parámetros de cuerpo personalizados
{: #other-custom-body-parameters }
- `.Send(requestBody)` permite establecer una serie arbitraria en el cuerpo.
- `.Send(JObject json)` permite establecer un diccionario arbitrario en el cuerpo.
- `.Send(byte[] data)` permite establecer un matriz de bytes arbitraria en el cuerpo.

## La respuesta
{: #the-response }
El objeto `WorklightResponse` contiene los datos de respuesta. Utilice todos sus métodos y propiedades para recuperar la información necesaria. Las propiedades utilizadas habitualmente son `ResponseText` (String), `ResponseJSON` (JSONObject) (si la respuesta está en JSON) y `success` (boolean) (estado de éxito de la respuesta).

En caso de una respuesta anómala, el objeto de respuesta también contiene una propiedad `error`.

## Para obtener más información
{: #for-more-information }
> Para obtener más información sobre WLResourceRequest, consulte la documentación de usuario.

<img alt="Imagen de la aplicación de ejemplo" src="resource-request-success-xamarin.png" style="float:right"/>

## Aplicación de ejemplo
{: #sample-application }
El proyecto ResourceRequestXamarin contiene una aplicación iOS y Android nativa que realiza una solicitud de recurso mediante un adaptador Javva.  
El proyecto Maven de adaptador contiene el adaptador Java utilizado durante la llamada de solicitud de recurso.

[Pulse para descargar](https://github.com/MobileFirst-Platform-Developer-Center/ResourceRequestXamarin/tree/release80) el proyecto Xamarin.  
[Pulse para descargar](https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80) el proyecto Maven del adaptador.

### Uso de ejemplo
{: #sample-usage }
Siga el archivo README.md de ejemplo para obtener instrucciones.
