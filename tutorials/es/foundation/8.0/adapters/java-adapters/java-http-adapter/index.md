---
layout: tutorial
title: Adaptador Java HTTP
breadcrumb_title: HTTP Adapter
relevantTo: [ios,android,windows,javascript]
downloads:
  - name: Download Adapter Maven project
    url: https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general 
{: #overview }

Los adaptadores Java proporcionan un amplio control para la conexión a un sistema de fondo.
Es por lo tanto responsabilidad del usuario asegurarse de que se siguen los procedimientos recomendados con relación al rendimiento y a otros detalles de implementación.
Esta guía de aprendizaje muestra un ejemplo de un adaptador Java que se conecta a un canal de información RSS utilizando `HttpClient` de Java.


**Requisito previo:** Asegúrese de leer primero la guía de aprendizaje [Adaptadores Java](../).


>**Importante:** Cuando utiliza referencias estáticas a clases desde `javax.ws.rs.*` o `javax.servlet.*`, dentro de su implementación de adaptador, debería asegurarse de configurar **RuntimeDelegate** mediante una se las siguientes opciones:

*	Establecer `-Djavax.ws.rs.ext.RuntimeDelegate=org.apache.cxf.jaxrs.impl.RuntimeDelegateImpl` en las `jvm.options` de Liberty
O BIEN

*	Establecer la propiedad de sistema o propiedad personalizada JVM
`javax.ws.rs.ext.RuntimeDelegate=org.apache.cxf.jaxrs.impl.RuntimeDelegateImpl`

## Inicialización del adaptador
{: #initializing-the-adapter }

En el adaptador de ejemplo proporcionado, la clase `JavaHTTPApplication` se utiliza para extender `MFPJAXRSApplication` y es un buen lugar para desencadenar cualquier inicialización que su aplicación precise.


```java
@Override
protected void init() throws Exception {
    JavaHTTPResource.init();
    logger.info("Adapter initialized!");
}
```

## Implementación de la clase de Recurso de adaptador
{: #implementing-the-adapter-resource-class }

La clase de Recurso del adaptador es donde se manejan las solicitudes para el servidor.
  
En el adaptador de ejemplo proporcionado, el nombre de clase es `JavaHTTPResource`.

```java
@Path("/")
public class JavaHTTPResource {

}
```

`@Path("/")` indica que los recursos estarán disponibles en el URL `http(s)://host:port/ProjectName/adapters/AdapterName/`.

### Cliente HTTP
{: #http-client }

```java
private static CloseableHttpClient client;
private static HttpHost host;

public static void init() {
  client = HttpClientBuilder.create().build();
  host = new HttpHost("mobilefirstplatform.ibmcloud.com");
}
```

Puesto que cada solicitud a su recurso creará una nueva instancia de `JavaHTTPResource`, es importante reutilizar objetos que puedan afectar al rendimiento.
En este ejemplo diseñamos el cliente HTTP como un objeto `static` y lo inicializamos con en un método `init()` estático, que es llamado por el `init()` de `JavaHTTPApplication` tal como se describió con anterioridad.


### Procedimiento resource
{: #procedure-resource }

```java
@GET
@Produces("application/json")
public void get(@Context HttpServletResponse response, @QueryParam("tag") String tag)
    throws IOException, IllegalStateException, SAXException {
  if(tag!=null && !tag.isEmpty()){
    execute(new HttpGet("/blog/atom/"+ tag +".xml"), response);
  }
  else{
    execute(new HttpGet("/feed.xml"), response);
  }

}
```

El adaptador de ejemplo expone tan solo un URL de recurso que permite recuperar el canal de información RSS desde el servicio de fondo.


* `@GET` indica que este procedimiento solo responde a solicitudes `HTTP GET`.

* `@Produces("application/json")` especifica el tipo de contenido de la respuesta a enviar.
Elegimos enviar la respuesta como un objeto `JSON` para facilitar el proceso en el lado del cliente.

* `@Context HttpServletResponse response` se utilizará para escribir la respuesta de la corriente de salida.
Esto proporciona una mayor granularidad que devolver una serie simple.

* `@QueryParam("tag")` La serie tag habilita que el procedimiento reciba un parámetro.
La elección de `QueryParam` significa que el parámetro se tiene que pasar en la consulta (`/JavaHTTP/?tag=MobileFirst_Platform`).
Otras opciones incluyen `@PathParam`, `@HeaderParam`, `@CookieParam`, `@FormParam`, etc.

* `throws IOException, ...` significa que reenviamos cualquier excepción de vuelta al cliente.
El código de cliente es responsable de manejar posibles excepciones que se recibirán como errores `HTTP 500`.
Otra solución (más probable en un código de producción) es manejar las excepciones en su código Java de servidor y decidir qué enviar al cliente en base al error exacto.

* `execute(new HttpGet("/feed.xml"), response)`. La solicitud HTTP real para el servicio de fondo la maneja otro método definido posteriormente.


Dependiendo de si se pasa un parámetro `tag`, `execute` recuperará una compilación diferente, una vía de acceso diferente y un archivo RSS diferente.


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

* `HttpResponse RSSResponse = client.execute(host, req)`. Utilizamos nuestro cliente HTTP estático para ejecutar la solicitud HTTP y almacenar la respuesta.

* `ServletOutputStream os = resultResponse.getOutputStream()`. Esta es la corriente de salida para grabar una respuesta para el cliente.

* `resultResponse.addHeader("Content-Type", "application/json")`. Tal como se mencionó con anterioridad, se elige enviar la respuesta como JSON.

* `String json = XML.toJson(RSSResponse.getEntity().getContent())`. Se utiliza `org.apache.wink.json4j.utils.XML` para convertir el RSS en XML como una serie JSON.

* `os.write(json.getBytes(Charset.forName("UTF-8")))` la serie JSON resultante se graba en la corriente de salida.


Se aplica entonces `flush` y `close` a la corriente de salida.


Si `RSSResponse` no es `200 OK`, en su lugar se escribe en la respuesta la razón y el código de estado.


## Adaptador de ejemplo
{: #sample-adapter }

[Pulse para descargar](https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80) el proyecto Maven Adapters.


El proyecto Maven Adapters incluye el adaptador **JavaHTTP** descrito con anterioridad.


### Uso de ejemplo 
{: #sample-usage }

* Utilice Maven, {{ site.data.keys.mf_cli }} o el IDE de su elección para [compilar y desplegar el adaptador JavaHTTP](../../creating-adapters/).

* Para probar o depurar un adaptador, consulte la guía de aprendizaje [Pruebas y depuración de adaptadores](../../testing-and-debugging-adapters).

