---
layout: tutorial
title: Envío de notificaciones
relevantTo: [ios,android,windows,cordova]
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
Para poder enviar notificaciones push o SMS a dispositivos iOS, Android o Windows, primero es necesario configurar a {{ site.data.keys.mf_server }} con los detalles de GCM para Android, un certificado APNS para iOS o credenciales WNS para Windows 8.1 Universal / Windows 10 UWP.
Las notificaciones entonces se pueden enviar a: todos los dispositivos (difusión), dispositivos registrados a etiquetas específicas, un ID de dispositivo individual, ID de usuario, únicamente a dispositivos iOS, únicamente a dispositivos Android, únicamente a dispositivos Windows o en base al usuario autenticado.


**Requisito previo**: Asegúrese de completar la guía de aprendizaje [Visión general de notificaciones](../).


#### Ir a 
{: #jump-to }
* [Configuración de notificaciones](#setting-up-notifications)
    * [Google Cloud Messaging / Firebase Cloud Messaging](#google-cloud-messaging--firebase-cloud-messaging)
    * [Servicio de notificaciones push de Apple](#apple-push-notifications-service)
    * [Servicio de notificaciones push de Windows](#windows-push-notifications-service)
    * [Servicio de notificación SMS](#sms-notification-service)
    * [Correlaciones de ámbito](#scope-mapping)
    * [Notificaciones autenticadas](#authenticated-notifications)
* [Definición de etiquetas](#defining-tags)
* [Envío de notificaciones](#sending-notifications)    
    * [{{ site.data.keys.mf_console }}](#mobilefirst-operations-console)
    * [API REST](#rest-apis)
    * [Personalización de notificaciones](#customizing-notifications)
* [Soporte de proxy](#proxy-support)
* [Guías de aprendizaje con las que continuar](#tutorials-to-follow-next)

## Configuración de notificaciones
{: #setting-up-notifications }
La habilitación del soporte de notificaciones implica seguir varios pasos de configuración tanto en la aplicación de cliente como en {{ site.data.keys.mf_server }}.   
Continúe la lectura para configurar el lado del servidor, o vaya a [Configuración del lado del cliente](#tutorials-to-follow-next).

En el lado del servidor, la configuración necesaria incluye: la configuración del proveedor que se necesita (APNS, GCM o WNS) y la correlación del ámbito "push.mobileclient".


### Google Cloud Messaging / Firebase Cloud Messaging
{: #google-cloud-messaging--firebase-cloud-messaging }
> **Nota:** Google [anunció recientemente](https://firebase.google.com/support/faq/#gcm-fcm) el paso de GCM a FCM.
Las siguientes instrucciones se han actualizado en consonancia a este último aspecto.
Además tenga en cuenta que las configuraciones GCM existentes desplegadas continuarán funcionando, sin embargo, las nuevas configuraciones GCM no lo harán, siendo preciso utilizar FCM en su lugar.
Los dispositivos Android utilizan el servicio Firebase Cloud Messaging (FCM) para las notificaciones push.
  
Siga estos pasos para configurar FCM:

1. Visite la [Consola de Firebase](https://console.firebase.google.com/?pli=1). 
2. Cree un proyecto nuevo y dele un nombre. 
3. Pule el icono de la rueda dentada de valores y seleccione **Valores de proyecto**.
4. Pulse el separador **Cloud Messaging** para generar una **clave de API de servidor** y un **ID de remitente** y pulse **Guardar**.


> También puede configurar FCM mediante la [API REST para el servicio push de {{ site.data.keys.product_adj }}](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_gcm_settings_put.html#Push-GCM-Settings--PUT-) o la [API REST para el servicio de administración de {{ site.data.keys.product_adj }}](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_gcm_settings_put.html#restservicesapi)

#### Notas
{: #notes }
Si su organización dispone de un cortafuegos que restringe el tráfico a o desde Internet, debe seguir los pasos siguientes:
  

* Configurar el cortafuegos para permitir la conectividad con FCM a fin de que las aplicaciones de cliente de FCM reciban mensajes.

* Es necesario abrir los puertos 5228, 5229 y 5230. FCM normalmente solo utiliza el puerto 5228 pero, a veces, también utiliza los puertos 5229 y 5230.

* FCM no proporciona una dirección IP específica, por lo que debe permitir que el cortafuegos acepte conexiones salientes para todas las direcciones IP contenidas en los bloques de IP que se listan en la ASN 15169 de Google.

* Asegúrese de que el cortafuegos acepte conexiones salientes de desde {{ site.data.keys.mf_server }} a android.googleapis.com en el puerto 443.


<img class="gifplayer" alt="Imagen de adición de las credenciales de GCM" src="gcm-setup.png"/>

### Servicio de notificaciones push de Apple
{: #apple-push-notifications-service }
Los dispositivos iOS utilizan APNS (Push Notification Service) de Apple para las notificaciones push.
  
Siga estos pasos para configurar APNS:

1. [Genere un certificado de notificación push para el desarrollo o la producción](https://medium.com/@ankushaggarwal/generate-apns-certificate-for-ios-push-notifications-85e4a917d522#.67yfba5kv).
2. En {{ site.data.keys.mf_console }} → **[su aplicación] → Push → Valores de push**, seleccione el tipo de certificado y proporcione el archivo y la contraseña del certificado.
A continuación, pulse **Guardar**.

#### Notas
{: #notes-apns }
* Para que se envíen las notificaciones push, los siguientes servidores deben estar disponibles desde una instancia de {{ site.data.keys.mf_server }}:
  
    * Servidores de recinto de pruebas:
  
        * gateway.sandbox.push.apple.com:2195
        * feedback.sandbox.push.apple.com:2196
    * Servidores de producción:  
        * gateway.push.apple.com:2195
        * Feedback.push.apple.com:2196
        * 1-courier.push.apple.com 5223
* Durante la fase de desarrollo, utilice el archivo de certificado de recinto de pruebas apns-certificate-sandbox.p12.

* Durante la fase de producción, utilice el archivo de certificado de producción apns-certificate-production.p12.

    * El certificado de producción APNS solo se puede probar una vez que la aplicación que la utiliza haya sido enviada de forma satisfactoria a Apple App Store.


> También es posible configurar APNS utilizando la [API REST para el servicio push de {{ site.data.keys.product_adj }}](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_apns_settings_put.html#Push-APNS-settings--PUT-) o la [API REST para el servicio de administración de {{ site.data.keys.product_adj }}](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_apns_settings_put.html?view=kc)

<img class="gifplayer" alt="Imagen de adición de credenciales APNS" src="apns-setup.png"/>

### Servicio de notificaciones push de Windows
{: #windows-push-notifications-service }
Los dispositivos Windows utilizan WNS (Windows Push Notifications Service) para las notificaciones push.
  
Siga estos pasos para configurar WNS:

1. Siga las [instrucciones que Microsoft proporciona](https://msdn.microsoft.com/en-in/library/windows/apps/hh465407.aspx) para generar los valores de **SID (Package Security Identifier)** y **Secreto de cliente**.

2. En {{ site.data.keys.mf_console }} → **[su aplicación] → Push → Valores de push**, añada estos valores y pulse **Guardar**.


> También es posible configurar WNS utilizando la [API REST para el servicio push de {{ site.data.keys.product_adj }}](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_wns_settings_put.html?view=kc) o la [API REST para el servicio de administración de {{ site.data.keys.product_adj }}](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_wns_settings_put.html?view=kc)

<img class="gifplayer" alt="Imagen de adición de credenciales WNS" src="wns-setup.png"/>

### Servicio de notificación SMS
{: #sms-notification-service }
El siguiente código JSON se utiliza para configurar la pasarela SMS para enviar notificaciones SMS. [Utilice la API REST `smsConf`](https://www.ibm.com/support/knowledgecenter/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_sms_settings_put.html) para actualizar a {{ site.data.keys.mf_server }} con la configuración de pasarela SMS


```json
{
	"host": "2by0.com",
	"name": "dummy",
	"port": "80",
	"programName": "gateway/add.php",
	"parameters": [{
		"name": "xmlHttp",
		"value": "false",
		"encode": "true"
	}, {
		"name": "httpsEnabled",
		"value": "false",
		"encode": "true"
	}]

}
```

> Encuentre más API REST relacionadas con SMS [en la Referencia de API del servicio push](https://www.ibm.com/support/knowledgecenter/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/c_restapi_runtime.html)
### Correlaciones de ámbito
{: #scope-mapping }
Correlacione el elemento de ámbito **push.mobileclient** con la aplicación.


1. Cargue {{ site.data.keys.mf_console }}, vaya a **[su aplicación] → Seguridad → Correlaciones de elementos de ámbito** y pulse en **Nueva**.
2. Especifique "push.mobileclient" en el campo **Elemento de ámbito**.
A continuación, pulse **Añadir**.

    <div class="panel-group accordion" id="scopes" role="tablist">
        <div class="panel panel-default">
            <div class="panel-heading" role="tab" id="additional-scopes">
                <h4 class="panel-title">
                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#additional-scopes" data-target="#collapse-additional-scopes" aria-expanded="false" aria-controls="collapse-additional-scopes"><b>Pulse para obtener una lista de ámbitos disponibles adicionales</b></a>
                </h4>
            </div>

            <div id="collapse-additional-scopes" class="panel-collapse collapse" role="tabpanel">
                <div class="panel-body">
                    <table class="table table-striped">
                        <tr>
                            <td><b>Ámbito</b></td>
                            <td><b>Descripción </b></td>
                        </tr>
                        <tr>
                            <td>apps.read	</td>
                            <td>Permiso para leer recurso de aplicación.</td>
                        </tr>
                        <tr>
                            <td>apps.write	</td>
                            <td>Permiso para crear, actualizar, suprimir recurso de aplicación. </td>
                        </tr>
                        <tr>
                            <td>gcmConf.read	</td>
                            <td>Permiso para leer valores de configuración GCM (SenderID y clave de API).</td>
                        </tr>
                        <tr>
                            <td>gcmConf.write	</td>
                            <td>Permiso para actualizar, suprimir valores de configuración GCM. </td>
                        </tr>
                        <tr>
                            <td>apnsConf.read	</td>
                            <td>Permiso para leer valores de configuración de APN. </td>
                        </tr>
                        <tr>
                            <td>apnsConf.write	</td>
                            <td>Permiso para actualizar, suprimir valores de configuración APN. </td>
                        </tr>
                        <tr>
                            <td>devices.read	</td>
                            <td>Permiso para leer dispositivo. </td>
                        </tr>
                        <tr>
                            <td>devices.write	</td>
                            <td>Permiso para crear, actualizar y suprimir dispositivo. </td>
                        </tr>
                        <tr>
                            <td>subscriptions.read	</td>
                            <td>Permiso para leer suscripciones. </td>
                        </tr>
                        <tr>
                            <td>subscriptions.write	</td>
                            <td>Permiso para crear, actualizar, suprimir suscripciones. </td>
                        </tr>
                        <tr>
                            <td>messages.write	</td>
                            <td>Permiso para enviar notificaciones push. </td>
                        </tr>
                        <tr>
                            <td>webhooks.read	</td>
                            <td>Permiso para leer notificaciones de suceso. </td>
                        </tr>
                        <tr>
                            <td>webhooks.write	</td>
                            <td>Permiso para enviar notificaciones de suceso. </td>
                        </tr>
                        <tr>
                            <td>smsConf.read	</td>
                            <td>Permiso para leer valores de configuración SMS. </td>
                        </tr>
                        <tr>
                            <td>smsConf.write	</td>
                            <td>Permiso para actualizar, suprimir valores de configuración SMS. </td>
                        </tr>
                        <tr>
                            <td>wnsConf.read	</td>
                            <td>Permiso para leer valores de configuración WNS. </td>
                        </tr>
                        <tr>
                            <td>wnsConf.write	</td>
                            <td>Permiso para actualizar, suprimir valores de configuración WNS. </td>
                        </tr>
                    </table>
                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#additional-scopes" data-target="#collapse-additional-scopes" aria-expanded="false" aria-controls="collapse-additional-scopes"><b>Sección de cierre</b></a>
                </div>
            </div>
        </div>
    </div>

    <img class="gifplayer" alt="Correlaciones de ámbito" src="scope-mapping.png"/>

### Notificaciones autenticadas
{: #authenticated-notifications }
Las notificaciones autenticadas son las que se envían a uno o varios `userIds`.  

Correlacione el elemento de ámbito **push.mobileclient** para la comprobación de seguridad utilizada para la aplicación.
  

1. Cargue {{ site.data.keys.mf_console }} y vaya a **[su aplicación] → Seguridad → Correlación de elementos de ámbito**, pulse en **Nuevo** o edite una entrada de correlación de ámbito existente.

2. Seleccione una comprobación de seguridad.
A continuación, pulse **Añadir**.

    <img class="gifplayer" alt="Notificaciones autenticadas" src="authenticated-notifications.png"/>

## Definición de etiquetas
{: #defining-tags }
En {{ site.data.keys.mf_console }} → **[su aplicación] → Push → Etiquetas**, pulse **Nueva**.  
Proporcione el correspondiente `Nombre de etiqueta` y `Descripción` y pulse **Guardar**.


<img class="gifplayer" alt="Adición de etiquetas" src="adding-tags.png"/>

Las suscripciones se vinculan con una etiqueta y un registro de dispositivo.
Cuando se anula el registro de un dispositivo desde una etiqueta, automáticamente se anula el registro de todas las suscripciones asociadas desde el propio dispositivo.
En un escenario en el que hay varios usuarios de un dispositivo, las suscripciones se deberían implementar en las aplicaciones móviles en base a un criterio de inicio de sesión.
Por ejemplo, realizar la llamada de suscripción después de que el usuario haya iniciado la sesión de forma satisfactoria en una aplicación y realizar de forma explícita la llamada para anular la suscripción como parte del manejo de la acción de finalización de sesión.


## Envío de notificaciones
{: #sending-notifications }
Las notificaciones push se pueden enviar desde {{ site.data.keys.mf_console }} o a través de API REST.


* Con {{ site.data.keys.mf_console }}, se pueden enviar dos tipos de notificaciones: etiqueta y difusión.

* Con las API REST, se pueden enviar todos los tipos de notificaciones: etiqueta, difusión y autenticada.


### {{ site.data.keys.mf_console }}
{: #mobilefirst-operations-console }
Las notificaciones se pueden enviar a un único ID de dispositivo, a uno o varios ID de usuario, solo a dispositivos iOS o solo dispositivos Android, o a dispositivos suscritos a etiquetas.


#### Notificaciones de etiqueta
{: #tag-notifications }
Las notificaciones de etiqueta son mensajes de notificación dirigidos a todos los dispositivos que están suscritos a una etiqueta concreta.
Las etiquetas representan temas de interés para el usuario y proporcionan la posibilidad de recibir notificaciones de acuerdo al interés escogido.


En {{ site.data.keys.mf_console }} → **[su aplicación] → Push → separador Enviar notificaciones**, seleccione **Dispositivos por etiquetas** desde el separador **Enviar a** y proporcione el **Texto de notificación**.
A continuación, pulse **Enviar**.

<img class="gifplayer" alt="Enviar por etiqueta" src="sending-by-tag.png"/>

#### Notificaciones de difusión
{: #breadcast-notifications }
Las notificaciones de difusión son una forma de notificaciones push dirigidas a todos los dispositivos suscritos.
De forma predeterminada las notificaciones están habilitadas para las aplicaciones de {{ site.data.keys.product_adj }} habilitadas para push mediante una suscripción a la etiqueta reservada `Push.all` (que se crea de forma automática para cada dispositivo).
Es posible anular mediante programación la suscripción a la etiqueta `Push.all`.


En {{ site.data.keys.mf_console }} → **[su aplicación] → Push → separador Enviar notificaciones**, seleccione **Todo** desde el separador **Enviar a** y proporcione el **Texto de notificación**.
A continuación, pulse **Enviar**.

![enviar a todos](sending-to-all.png)

### API REST
{: #rest-apis }
Cuando se utilizan API REST para enviar notificaciones, se pueden enviar todos los tipos de notificaciones: notificaciones de etiqueta y difusión y notificaciones autenticadas.


Para enviar una notificación, realice una solicitud mediante POST al punto final REST:
`imfpush/v1/apps/<application-identifier>/messages`.  
URL de ejemplo:


```bash
https://myserver.com:443/imfpush/v1/apps/com.sample.PinCodeSwift/messages
```

> Para revisar todas las API REST de notificaciones push, consulte el tema [API REST de servicios de tiempo de ejecución](https://www.ibm.com/support/knowledgecenter/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/c_restapi_runtime.html) en la documentación de usuario.


#### Carga útil de notificación
{: #notification-payload }
La solicitud puede contener las siguientes propiedades de carga útil:


Propiedades de carga útil | Definición 
--- | ---
message | Mensaje de alerta a enviar. 
settings | Los valores son los distintos atributos de la notificación. 
target | Conjunto de destinos: etiquetas, plataformas, dispositivos o ID de consumidor. Solo se puede especificar uno de los destinos. 
deviceIds | Matriz de los dispositivos representados por los identificadores de dispositivo. Los dispositivos con estos identificadores recibirán la notificación. Se trata de una notificación de difusión única. 
notificationType | Valor entero para indicar el canal (Push/SMS) utilizado para enviar el mensaje. Los valores permitidos son 1 (solo push), 2 (solo SMS) y 3 (push y SMS)
platforms | Matriz de plataformas de dispositivo. Los dispositivos que se ejecuten en estas plataformas recibirán la notificación. Los valores soportados son (Apple/iOS), G (Google/Android) y M (Microsoft/Windows).
tagNames | Matriz de etiquetas especificados como tagNames. Los dispositivos suscritos a estas etiquetas recibirán la notificación. Este tipo de destino se utiliza con notificaciones basadas en etiquetas. 
userIds | Matriz de usuarios representados por sus userIds para enviar la notificación. Se trata de una notificación de difusión única. 
phoneNumber | Número de teléfono utilizado para registrar el dispositivo y recibir notificaciones. Se trata de una notificación de difusión única. 

**Ejemplo JSON de carga útil de notificaciones push**

```json
{
    "message" : {
    "alert" : "Test message",
  },
  "settings" : {
    "apns" : {
      "badge" : 1,
      "iosActionKey" : "Ok",
      "payload" : "",
      "sound" : "song.mp3",
      "type" : "SILENT",
    },
    "gcm" : {
      "delayWhileIdle" : ,
      "payload" : "",
      "sound" : "song.mp3",
      "timeToLive" : ,
    },
  },
  "target" : {
    // The list below is for demonstration purposes only - per the documentation only 1 target is allowed to be used at a time.
    "deviceIds" : [ "MyDeviceId1", ... ],
    "platforms" : [ "A,G", ... ],
    "tagNames" : [ "Gold", ... ],
    "userIds" : [ "MyUserId", ... ],
  },
}
```

**Ejemplo JSON de carga útil de notificación SMS**

```json
{
  "message": {
    "alert": "Hello World from an SMS message"
  },
  "notificationType":3,
   "target" : {
     "deviceIds" : ["38cc1c62-03bb-36d8-be8e-af165e671cf4"]
   }
}
```

#### Envío de la notificación
{: #sending-the-notification }
La notificación se puede envían utilizando diferentes herramientas.
  
Para realizar pruebas, se utiliza Postman tal como se describe a continuación:


1. [Configuración de un cliente confidencial](../../authentication-and-security/confidential-clients/).   
El envío de una notificación push a través de la API REST utiliza elementos de ámbito separados por espacios `messages.write` y `push.application.
<applicationId>.`

    <img class="gifplayer" alt="Configuración de un cliente confidencial" src="push-confidential-client.png"/>

2. [Creación de una señal de acceso](../../authentication-and-security/confidential-clients#obtaining-an-access-token).  


3. Realice una solicitud **POST** a **http://localhost:9080/imfpush/v1/apps/com.sample.PushNotificationsAndroid/messages**
    - Si está utilizando una instancia remota de {{ site.data.keys.product_adj }}, sustituya los valores de `hostname` y `port` con los suyos propios.

    - Actualice el valor del identificador de aplicación con el suyo propio. 

4. Establezca una cabecera: 
    - **Authorization**: `Bearer eyJhbGciOiJSUzI1NiIsImp ...`
    - Sustituya el valor después de "Bearer" con su señal de acceso obtenida en el paso (1) anterior.


    ![cabecera de autorización](postman_authorization_header.png)

5. Establezca un cuerpo: 
    - Actualice sus propiedades tal como se describe anteriormente en [Carga útil de notificación](#notification-payload).

    - Por ejemplo, añadiendo la propiedad **target** con el atributo **userIds**, podrá enviar una notificación a usuarios específicamente registrados.


   ```json
   {
        "message" : {
            "alert" : "Hello World!"
        }
   }
   ```

   ![cabecera de autorización](postman_json.png)

Después de pulsar el botón **Enviar**, el dispositivo debería haber recibido una notificación:


![Imagen de la aplicación de ejemplo](notifications-app.png)

### Personalización de notificaciones
{: #customizing-notifications }
Antes de enviar el mensaje de notificación, también puede personalizar los siguientes atributos de notificación.
  

En {{ site.data.keys.mf_console }} → **[su aplicación] → Push → Etiquetas → separador Enviar notificaciones**, amplíe la sección **Valores personalizados de iOS/Android** para cambiar los atributos de notificación.


### Android
{: #android }
* Entre otras, sonido de notificación, tiempo que permanece almacenada una notificación en el almacenamiento GCM o carga útil personalizada.

* Si desea cambiar el título de la notificación, añada `push_notification_tile` en el archivo **strings.xml** del proyecto.


### iOS
{: #ios }
* Sonido de notificación, carga útil personalizada, título de clave de acción, tipo de notificación y número de identificador.


![personalización de notificaciones push](customizing-push-notifications.png)

## Soporte de proxy
{: #proxy-support }
Utilice los valores proxy para establecer el proxy opcional a través de las notificaciones que se envían a dispositivos Android e iOS.
El proxy se configura mediante las propiedades de configuración **push.apns.proxy.** y **push.gcm.proxy.**.
Para obtener más información, consulte [Lista de propiedades JNDI para el servicio push de {{ site.data.keys.mf_server }}](../../installation-configuration/production/server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service).

## Guías de aprendizaje con las que continuar
{: #tutorials-to-follow-next }
Con el servidor ahora configurado, configure el lado del cliente y trate las notificaciones que se reciban.


* Manejo de notificaciones push
    * [Manejo de notificaciones push en aplicaciones Cordova](../handling-push-notifications/cordova)
    * [Manejo de notificaciones push en aplicaciones iOS](../handling-push-notifications/ios)
    * [Manejo de notificaciones push en aplicaciones Android](../handling-push-notifications/android)
    * [Manejo de notificaciones push en aplicaciones Windows](../handling-push-notifications/windows)

* Manejo de notificaciones SMS
    * [Manejo de notificaciones SMS en aplicaciones Cordova](../handling-sms-notifications/cordova)
    * [Manejo de notificaciones SMS en aplicaciones iOS](../handling-sms-notifications/ios)
    * [Manejo de notificaciones SMS en aplicaciones Android](../handling-sms-notifications/android)
