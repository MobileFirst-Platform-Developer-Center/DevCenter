---
layout: tutorial
title: Integración con Cloudant
relevantTo: [javascript]
downloads:
  - name: Download Cordova project
    url: https://github.com/MobileFirst-Platform-Developer-Center/CloudantAdapter/tree/release80
weight: 9
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general 
{: #overview }
Cloudant es una base de datos no SQL que se basa en CouchDB, que está disponible como un producto independiente así como un DBaaS (Database-as-a-Service) en IBM Cloud y `cloudant.com`.

Tal como se describe en la documentación de Cloudant:
> Los documentos son objetos JSON.
Los documentos son contenedores para los datos y son el fundamento de la base de datos Cloudant.
  
Todos los documentos deben tener dos campos: un campo `_id` exclusivo y un campo `_rev`.
El campo `_id` lo crea el usuario o lo genera Cloudant de forma automática como un UUID.
El campo `_rev` es un número de revisión y es esencial para el protocolo de réplica de Cloudant.
Además de estos dos campos obligatorios, los documentos pueden poseer cualquier otro contenido expresado en formato JSON.



La API de Cloudant se documenta en el sitio de [Documentación de IBM Cloudant](https://docs.cloudant.com/index.html).


Puede utilizar los adaptadores para comunicarse con una base de datos Cloudant.
En esta guía de aprendizaje se muestran algunos ejemplos.


En esta guía de aprendizaje se presupone que está familiarizado con los adaptadores.
Consulte [Adaptador JavaScript HTTP](../javascript-adapters/js-http-adapter) o [Adaptadores Java](../java-adapters).

### Ir a
{: #jump-to}
* [Adaptador JavaScript HTTP](#javascript-http-adapter)
* [Adaptadores Java](#java-adapters)
* [Aplicación de ejemplo](#sample-application)


## Adaptador JavaScript HTTP
{: #javascript-http-adapter }
Existe la posibilidad de acceder a la API de Cloudant como un servicio web HTTP simple.


Con la utilización de un adaptador HTTP, podrá conectarse al servicio HTTP de Cloudant con el método `invokeHttp`.


### Autenticación
{: #authentication }
Cloudant da soporte a varias formas de autenticación.
Consulte la documentación de Cloudant para obtener información sobre la autenticación en [https://docs.cloudant.com/authentication.html](https://docs.cloudant.com/authentication.html).   Con un adaptador JavaScript HTTP, puede utilizar la **Autenticación básica**.

En el archivo XML del adaptador, especifique el `domain` de su instancia de Cloudant, el `port` y añada un elemento `authentication` del tipo `basic`. 
La infraestructura utilizará estas credenciales para generar una cabecera HTTP `Authorization: Basic`.


**Nota:** Con Cloudant, puede generar claves de API exclusivas que puede utilizar en lugar de su nombre de usuario y contraseña reales.


```xml
<connectivity>
  <connectionPolicy xsi:type="http:HTTPConnectionPolicyType">
    <protocol>https</protocol>
    <domain>CLOUDANT_ACCOUNT.cloudant.com</domain>
    <port>443</port>
    <connectionTimeoutInMilliseconds>30000</connectionTimeoutInMilliseconds>
    <socketTimeoutInMilliseconds>30000</socketTimeoutInMilliseconds>
    <authentication>
      <basic/>
        <serverIdentity>
          <username>CLOUDANT_KEY</username>
          <password>CLOUDANT_PASSWORD</password>
        </serverIdentity>
    </authentication>
    <maxConcurrentConnectionsPerNode>50</maxConcurrentConnectionsPerNode>
    <!-- Following properties used by adapter's key manager for choosing specific certificate from key store
    <sslCertificateAlias></sslCertificateAlias>
    <sslCertificatePassword></sslCertificatePassword>
    -->
  </connectionPolicy>
</connectivity>
```

### Procedimientos
{: #procedures }
Los procedimientos del adaptador utilizan el método `invokeHttp` para enviar una solicitud HTTP a uno de los URL que Cloudant define.
  
Por ejemplo, puede crear un nuevo documento enviando una solicitud `POST` a `/{*your-database*}/` siendo el cuerpo una representación JSON del documento que desea almacenar.


```js
function addEntry(entry){

    var input = {
            method : 'post',
            returnedContentType : 'json',
            path : DATABASE_NAME + '/',
            body: {
                contentType : 'application/json',        
                content : entry
            }
        };

    var response = MFP.Server.invokeHttp(input);
    if(!response.id){
        response.isSuccessful = false;
    }
    return response;

}
```

La misma idea se puede aplicar a todas las funciones Cloudant.
Consulte la documentación de Cloudant para obtener información sobre los documentos en [https://docs.cloudant.com/document.html](https://docs.cloudant.com/document.html).


## Adaptadores Java
{: #java-adapters }
Cloudant proporciona una [biblioteca de cliente de Java](https://github.com/cloudant/java-cloudant) para que sea más fácil utilizar todas las características de Cloudant.


Durante la inicialización de su adaptador de Java, configure una instancia de `CloudantClient` con la que trabajar.
  
**Nota:** Con Cloudant, puede generar claves de API exclusivas que puede utilizar en lugar de su nombre de usuario y contraseña reales.


```java
CloudantClient cloudantClient = new CloudantClient(cloudantAccount,cloudantKey,cloudantPassword);
db = cloudantClient.database(cloudantDBName, false);
```
<br/>
Utilizando de los [POJO (Plain Old Java Objects)](https://en.wikipedia.org/wiki/Plain_Old_Java_Object) y la API Java estándar para servicios web RESTful (JAX-RS 2.0), puede crear un nuevo documento en Cloudant enviando una representación JSON del documento en la solicitud HTTP.



```java
@POST
@Consumes(MediaType.APPLICATION_JSON)
public Response addEntry(User user){
    if(user!=null && user.isValid()){
        db.save(user);
        return Response.ok().build();
    }
    else{
        return Response.status(418).build();
    }
}
```

<img alt="Imagen de la aplicación de ejemplo" src="cloudant-app.png" style="float:right"/>
## Aplicación de ejemplo
{: #sample-application }
[
Pulse para descargar](https://github.com/MobileFirst-Platform-Developer-Center/CloudantAdapter/tree/release80) el proyecto Cordova.


El ejemplo contiene dos adaptadores, uno en JavaScript y otro en Java.
  
También contiene una aplicación Cordova que funciona tanto con adaptadores JavaScript como Java.


> **Nota:** El ejemplo utiliza Cloudant Java Client v1.2.3 debido a una limitación conocida.


### Uso de ejemplo 
{: #sample-usage }
Siga el archivo README.md de ejemplo para obtener instrucciones.

