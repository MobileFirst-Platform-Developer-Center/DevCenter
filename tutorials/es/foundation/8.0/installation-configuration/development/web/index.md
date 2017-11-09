---
layout: tutorial
title: Configuración del entorno de desarrollo web
breadcrumb_title: Web
relevantTo: [javascript]
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
El desarrollo y la realización de pruebas de aplicaciones web es tan fácil como obtener una vista previa de un archivo HTML local en el navegador web que elija.   
Los desarrolladores también pueden elegir su IDE así como cualquier infraestructura o infraestructuras que se adecúen a sus necesidades. 

Sin embargo, hay un aspecto que puede obstaculizar el desarrollo de las aplicaciones web. Las aplicaciones web podrían presentar errores debido a un incumplimiento de la [política de mismo origen](https://developer.mozilla.org/en-US/docs/Web/Security/Same-origin_policy). La política de mismo origen es una restricción impuesta en los navegadores web. Por ejemplo, si una aplicación está alojada en el dominio **example.com**, no se permite que la misma aplicación también acceda a contenido que está disponible en otro servidor, o para lo que interesa aquí, en {{ site.data.keys.mf_server }}.

[Las aplicaciones web que tienen que utilizar el SDK web de {{ site.data.keys.product }}](../../../application-development/sdk/web) deberían utilizar una topología de soporte por ejemplo, utilizando un proxy inverso, para redirigir de forma interna solicitudes al servidor apropiado a la vez que mantener el mismo origen único. 

Los requisitos de política se pueden satisfacer utilizando alguno de los siguientes métodos: 

- Sirviendo los recursos de la aplicación web desde el mismo servidor de aplicaciones de perfil WebSphere Full/Liberty que también aloje {{ site.data.keys.mf_server }}.
- Utilizando Node.js como un proxy para direccionar las solicitudes de la aplicación para {{ site.data.keys.mf_server }}.

#### Ir a
{: #jump-to }
- [Requisitos previos](#prerequisites)
- [Utilización del perfil WebSphere Liberty para servir recursos de aplicación web](#using-websphere-liberty-profile-to-serve-the-web-application-resources)
- [Utilización de Node.js](#using-nodejs)
- [Siguientes pasos](#next-steps)

## Requisitos previos
{: #prerequisites }
-   {: #web-app-supported-browsers }
Se da soporte a las aplicaciones web para las siguientes versiones de navegador. Los números indican la versión soportada más antigua del respectivo navegador. 

    | Navegador | Chrome   | Safari<sup>*</sup>   | Internet Explorer   | Firefox   | Navegador Android |
    |-----------------------|:--------:|:--------------------:|:-------------------:|:---------:|:-----------------:|
    | **Versión soportada** |  {{ site.data.keys.mf_web_browser_support_chrome_ver }} | {{ site.data.keys.mf_web_browser_support_safari_ver }} | {{ site.data.keys.mf_web_browser_support_ie_ver }} | {{ site.data.keys.mf_web_browser_support_firefox_ver }} | {{ site.data.keys.mf_web_browser_support_android_ver }}  |

    <sup>*</sup> En Safari, únicamente se da soporte a la navegación privada en aplicaciones de página individual (SPA). Otras aplicaciones podrían presentar un comportamiento inesperado. 

    {% comment %} [sharonl][c-web-browsers-ms-edge] Consulte la información relacionada con el soporte a Microsoft Edge en la tarea 111165. {% endcomment %}

-   Las siguientes instrucciones de configuración precisan que Apache Maven o Node.js esté instalado en la estación de trabajo del desarrollador. Para obtener más instrucciones, consulte la [guía de instalación](../mobilefirst/installation-guide/).

## Utilización del perfil WebSphere Liberty para servir recursos de aplicación web
{: #using-websphere-liberty-profile-to-serve-the-web-application-resources }
Para dar servicio a los recursos de la aplicación web, estos deben estar almacenados en una webapp de Maven (un archivo **.war**). 

### Creación de un arquetipo webapp de Maven
{: #creating-a-maven-webapp-archetype }
1. Desde la ventana de **línea de mandatos**, vaya a la ubicación de su elección. 
2. Ejecute el mandato: 

   ```bash
   mvn archetype:generate -DgroupId=MyCompany -DartifactId=MyWebApp -DarchetypeArtifactId=maven-archetype-webapp -DinteractiveMode=false
   ```
    - Sustituya **MyCompany** y **MyWebApp** con sus valores. 
    - Para especificar los valores uno a uno, elimine el distintivo `-DinteractiveMode=false`. 

### Compilación de la webapp de Maven con los recursos de la aplicación web 
{: #building-the-maven-webapp-with-the-web-applications-resources }
1. Coloque los recursos de la aplicación web (por ejemplo, los archivos HTML, CSS, JavaScript y de imágenes) dentro de la carpeta **[MyWebApp] → src → Main → webapp** generada. 

    > A partir de este punto, considere la carpeta **webapp** como la ubicación de desarrollo para la aplicación web. 

2. Ejecute el mandato: `mvn clean install` para generar el archivo .war con los recursos de la aplicación web.   
El archivo .war generado estará disponible en la carpeta **[MyWebApp] → target**. 
   
    > <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> **Importante:** Se debe ejecutar `mvn clean install` cada vez que actualiza un recurso web.



### Adición de la webapp de Maven al servidor de aplicaciones
{: #adding-the-maven-webapp-to-the-application-server }
1. Edite el archivo **server.xml** de su servidor de aplicaciones de WebSphere.   
    Si está utilizando {{ site.data.keys.mf_dev_kit }}, el archivo se encuentra en la carpeta [**{{ site.data.keys.mf_dev_kit }}] → mfp-server → user → servers → mfp**. Añada la siguiente entrada:  

   ```xml
   <application name="MyWebApp" location="path-to/MyWebApp.war" type="war"></application>
   ```
    - Sustituya **name** y **path-to/MyWebApp.war** con sus valores. 
    - El servidor de aplicaciones se reinicia de forma automática después de haber guardado los cambios en el archivo **server.xml**.   

### Realización de pruebas con la aplicación web
{: #testing-the-web-application }
Una vez esté listo para probar la aplicación web, visite el URL: **localhost:9080/MyWebApp**.
    - Sustituya **MyWebApp** con su valor. 

## Utilizando Node.js
{: #using-nodejs }
Node.js se puede utilizar como proxy inverso para canalizar las solicitudes de la aplicación web para {{ site.data.keys.mf_server }}.

1. Desde una ventana de **línea de mandatos**, vaya a la carpeta de la aplicación web y ejecute el siguiente conjunto de mandatos:  

   ```bash
   npm init
   npm install --save express
   npm install --save request
   ```

2. Cree un nuevo archivo en la carpeta **node_modules**, por ejemplo **proxy.js**.
3. Añada el siguiente código al archivo: 

   ```javascript
   var express = require('express');
   var http = require('http');
   var request = require('request');

   var app = express();
   var server = http.createServer(app);
   var mfpServer = "http://localhost:9080";
   var port = 9081;

   server.listen(port);
   app.use('/myapp', express.static(__dirname + '/'));
   console.log('::: server.js ::: Listening on port ' + port);

   // Web server - serves the web application
   app.get('/home', function(req, res) {
        // Website you wish to allow to connect
        res.sendFile(__dirname + '/index.html');
   });

   // Reverse proxy, pipes the requests to/from {{ site.data.keys.mf_server }}
   app.use('/mfp/*', function(req, res) {
        var url = mfpServer + req.originalUrl;
        console.log('::: server.js ::: Passing request to URL: ' + url);
        req.pipe(request[req.method.toLowerCase()](url)).pipe(res);
   });
   ```
    - sustituya el valor de **port** con el suyo propio. 
    - sustituya `/myapp` con el nombre de la vía de acceso preferida para su aplicación web. 
    - sustituya `/index.html` con el nombre de su archivo HTML principal. 
    - Si es necesario, actualice `/mfp/*` con la raíz de contexto de su tiempo de ejecución de {{ site.data.keys.product }}. 

4. Para iniciar el proxy, ejecute el mandato `node proxy.js`.
5. Una vez esté listo para probar su aplicación web, visite el URL:**server-hostname:port/app-name**, por ejemplo: **http://localhost:9081/myapp**
    - Sustituya **server-hostname** con su propio valor. 
    - Sustituya **port** con su propio valor. 
    - Sustituya **app-name** con su propio valor. 

## Siguientes pasos
{: #next-steps }
Para continuar con el desarrollo de {{ site.data.keys.product }} en las aplicaciones web, es necesario añadir el SDK web de {{ site.data.keys.product }} a la aplicación web. 

* Aprenda a añadir [{{ site.data.keys.product }} SDK para las aplicaciones web](../../../application-development/sdk/web/).
* Para el desarrollo de aplicaciones, consulte las guías de aprendizaje de [Utilización de {{ site.data.keys.product }} SDK](../../../application-development/). 
* Para el desarrollo de adaptadores, consulte la categoría [Adaptadores](../../../adapters/).

