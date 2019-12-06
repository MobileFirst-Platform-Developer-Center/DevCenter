---
layout: tutorial
title: Generación automática de un adaptador
breadcrumb_title: Adapter auto-generation
relevantTo: [ios,android,cordova]
weight: 12
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }

Los adaptadores de {{ site.data.keys.product }} se utilizan para realizar toda la lógica necesaria del lado del servidor y para transferir y recuperar información desde sistemas de fondo para los servicios de nube y las aplicaciones de cliente.

##  Generación de un adaptador desde su especificación OpenAPI
{: #generate-adapter-openapi-spec}

La generación automática de un adaptador a partir de su especificación OpenAPI (especificación Swagger) agiliza el desarrollo de aplicaciones. El usuario de {{ site.data.keys.product }} podrá centrarse ahora en la lógica de la aplicación en lugar de la creación del adaptador de {{ site.data.keys.product }}, que conecta la aplicación al servicio de fondo deseado.

>**Nota:** Esta característica solo está disponible en DevKit.

Para utilizar esta característica, la especificación OpenAPI (.json o .yaml) para el microservicio (o el servicio de fondo deseado) debería estar disponible. La característica de generación del adaptador pasa a estar disponible mediante un adaptador de extensión denominado **Microservice Connector**, al que también se hace referencia como **Microservice Adapter Generator**, que está disponible para descargar desde el **Centro de descargas** en la consola {{ site.data.keys.product }}.

>**Nota:** Como requisito previo, configure la variable JAVA_HOME para apuntar a la carpeta JDK instalada.


  ![Imagen del generador de adaptadores en el Centro de descargas](./AdapterGen_DownloadCenter.png)


Descargue el adaptador **Microservice Adapter Generator** y despliéguelo en el servidor {{ site.data.keys.product }}. El adaptador desplegado aparecerá listado bajo **Extensiones**, en el panel de navegación.


  ![Imagen del generador de adaptadores en el panel de navegación](./AdapterGen_naviagtionPane.png)


Pulsando **Microservice Adapter Generator** lanzará la página, donde el usuario puede proporcionar el archivo de especificación OpenAPI (.json o .yaml) y elegir generar el adaptador desde la especificación OpenAPI proporcionada.

  ![Imagen de la página del generador de adaptadores](./AdapterGen_generationPage.png)


Después de que se haya generado el adaptador, se descargará de forma automática en el navegador. Se solicita entonces al usuario desplegar el adaptador generado para que sea utilizado por sus aplicaciones. Si selecciona la opción **Incluir fuente del adaptador** se descargará el código fuente del adaptador y el adaptador generado como un archivo zip. El usuario puede modificar el código fuente del adaptador generado, volver a crearlo y desplegar el adaptador.

El generador de adaptadores depende de la exactitud del JSON de especificación OpenAPI. Si la especificación es incompleta o incorrecta, la generación podría fallar o dar lugar a la generación de API de adaptador que no coincidan con las API de los microservicios de fondo.

>Para obtener más información, lea el artículo del blog [Generación automática de adaptadores para microservicios y sistemas de fondo desde su especificación OpenAPI](https://mobilefirstplatform.ibmcloud.com/blog/2017/08/10/autogenerate-adapter-from-openapi-specification/).
