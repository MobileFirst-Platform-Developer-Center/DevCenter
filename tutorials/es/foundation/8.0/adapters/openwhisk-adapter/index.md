---
layout: tutorial
title: Cloud Functions adapter
breadcrumb_title: Cloud Functions adapter
relevantTo: [ios,android,cordova]
weight: 10
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general 
{: #overview }

> OpenWhisk se denomina ahora Cloud Functions.

IBM Cloud Functions es una plataforma FaaS (Function-as-a-Service) que permite la ejecución de código en un entorno escalable y sin servidor. Uno de los casos de uso de la plataforma Cloud Functions es el desarrollo y la ejecución de código de fondo móvil sin servidor. Para obtener más información sobre la plataforma Cloud Functions en Bluemix [consulte aquí](https://console.bluemix.net/openwhisk/?env_id=ibm:yp:us-south). 

Los adaptadores de {{ site.data.keys.product }} se utilizan para realizar toda la lógica necesaria del lado del servidor y para transferir y recuperar información desde sistemas de fondo para los servicios de nube y las aplicaciones de cliente.
{{ site.data.keys.product }} proporciona ahora un adaptador para Cloud Functions. 

##  Adaptador Cloud Functions
{: #cloud-functions-adapter}

{{ site.data.keys.product_full }}, desde el [iFix 8.0.0.0-MFPF-IF20170710-1834](https://mobilefirstplatform.ibmcloud.com/blog/2017/07/11/8-0-ifix-release/), proporciona un adaptador Cloud Functions. Este adaptador está disponible para descargar y desplegar desde el **Centro de descargas** en Mobile Foundation Console. 

Después de descargar y desplegar el adaptador, debería configurarlo para conectarse a Cloud Functions. 

### Configuración del adaptador para conectarse a Cloud Functions
{: configure-adapter-connect-cloud-functions}

Para configurar el adaptador para conectarse a Cloud Functions, vaya a la página **Configuración de adaptador** y proporcione el _**nombre de usuario**_ y la _**contraseña**_ de la clave de autorización de Cloud Functions. El _**nombre de usuario**_ y la _**contraseña**_ para Cloud Functions se puede obtener ejecutando el siguiente mandato de CLI: 

```bash
./wsk property get --auth KEY
```

El mandato anterior devuelve la clave de autorización separada por dos puntos, a la izquierda de los puntos el _**nombre de usuario**_ y a la derecha la _**contraseña**_. 

_**nombre de usuario:contraseña**_

El _**nombre de usuario**_ y la _**contraseña**_, tal como se ha indicado, se debería proporcionar en la página de configuración del adaptador Cloud Functions y, a continuación, guardarla. Las aplicaciones de cliente podrán ahora llamar a la API del adaptador para invocar al código de fondo de Cloud Functions. 

>Para modificar el adaptador Cloud Functions descargue su código fuente desde este [Repositorio Github](https://github.com/mfpdev/mfp-extension-adapters). 
