---
layout: tutorial
title: Notificaciones
show_children: true
relevantTo: [ios,android,windows,cordova]
weight: 8
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
Las notificaciones permiten que un dispositivo móvil reciba mensajes de tipo "push" que se envían desde un servidor.
  
Las notificaciones se reciben independientemente de si la aplicación actualmente se está ejecutando en un primer plano o en un segundo plano.
  

{{ site.data.keys.product_full }} proporciona un conjunto de unificado de métodos de API para enviar notificaciones push o SMS a aplicaciones iOS, Android, Windows 8.1 Universal, Windows 10 UWP y Cordova (iOS, Android).
Las notificaciones se envían desde {{ site.data.keys.mf_server }} a la infraestructura de proveedor (Apple, Google, Microsoft, pasarelas SMS) y de allí a los dispositivos pertinentes.
El mecanismo de notificación unificado de notificación hace que todo el proceso de comunicación con los usuarios y los dispositivos sea completamente transparente para el desarrollador.


#### Soporte de dispositivo
{: #device-support }
Las notificaciones SMS y push están soportadas por las siguientes plataformas en {{ site.data.keys.product }}:

* iOS 8.x y posterior
* Android 4.x y posterior
* Windows 8.1, Windows 10

#### Ir a: 
{: #jump-to }
* [Notificaciones push](#push-notifications)
* [Notificaciones SMS](#sms-notifications)
* [Valores de proxy](#proxy-settings)
* [Guías de aprendizaje con las que continuar](#tutorials-to-follow-next)

## Notificaciones push
{: #push-notifications }
Las notificaciones pueden ser de distintos tipos: 

* **Alertas (iOS, Android, Windows)** -  mensaje de texto emergente
* **Sonido (iOS, Android, Windows)** - archivo de sonido que se reproduce cuando se recibe una notificación
* **Identificador (iOS), Mosaico (Windows)** - representación gráfica que permite un breve texto o una imagen 
* **Banner (iOS), Toast (Windows)** - mensaje de texto emergente que desaparece en la parte superior de la pantalla del dispositivo
* **Interactiva (iOS 8 y superior)** - botones de acción dentro del banner de una notificación recibida
* **Silenciosa (iOS 8 y superior)** - notificaciones que el usuario no percibe

### Tipos de notificación push 
{: #push-notification-types }
#### Notificaciones de etiqueta
{: #tag-notifications }
Las notificaciones de etiqueta son mensajes de notificación dirigidos a todos los dispositivos que están suscritos a una etiqueta concreta.
  

Las notificaciones basadas en etiquetas permiten la segmentación de notificaciones en base a temas o áreas de asuntos.  Los destinatarios de las notificaciones pueden elegir recibirlas únicamente si tratan sobre un tema o asunto de su interés.
Por lo tanto, las notificaciones basadas en etiquetas proporcionan un medio de segmentar los destinatarios.
Esta característica permite definir etiquetas y enviar o recibir mensajes por etiquetas.
El mensaje únicamente se dirige a los dispositivos que se han suscrito a una etiqueta. 

#### Notificaciones de difusión
{: #broadcast-notifications }
Las notificaciones de difusión son una forma de notificaciones push dirigidas a todos los dispositivos suscritos. De forma predeterminada están dirigidas a cualquier aplicación de {{ site.data.keys.product_adj }} habilitada para push mediante una suscripción a la etiqueta reservada `Push.all` (que se crea de forma automática para cada dispositivo).
Las notificaciones de difusión se pueden inhabilitar anulando la suscripción desde la etiqueta reservada `Push.all`.


#### Notificaciones de difusión única
{:# unicast-notifications }
Las notificaciones de difusión única, o notificaciones autenticadas de usuario, se protegen con OAuth.
Estos mensajes de notificación están destinados a un dispositivo determinado o distintos ID de usuario. La suscripción del ID de usuario en la suscripción de usuarios puede provenir del contexto de seguridad subyacente.


#### Notificaciones interactivas
{: #interactive-notifications }
En las notificaciones interactivas, cuando una notificación llega, los usuarios pueden tomar acciones con relación a la misma sin abrir la aplicación.
Cuando llega una notificación interactiva, el dispositivo muestra los botones de la acción junto con el mensaje de notificación.
Actualmente, las notificaciones interactivas están soportadas en dispositivos en iOS versión 8 y posterior.
Si se envía una notificación interactiva a un dispositivo iOS con una versión anterior a la versión 8, las acciones de la notificación no se visualizarán.


> Aprenda a manejar las [notificaciones interactivas](handling-push-notifications/interactive).

#### Notificaciones silenciosas
{: #silent-notifications }
Las notificaciones silenciosas son notificaciones que no visualizan alertas ni interrumpen al usuario.
Cuando llega una notificación silenciosa, la aplicación que se encarga del código lo ejecuta en un segundo plano sin llevar la aplicación a un primer plano.
Actualmente, se da soporte a las instalaciones silenciosas en dispositivos iOS a partir de la versión 7.
Si se envía una notificación silenciosa a dispositivos iOS con una versión anterior a la 7, si la aplicación se ejecuta en un segundo plano, se ignora la notificación.
Si la aplicación se está ejecutando en un primer plano, se invoca al método de llamada de retorno de notificación.


> Aprenda a manejar las [notificaciones silenciosas](handling-push-notifications/silent).

**Nota:** Las notificaciones de difusión única no contienen ninguna etiqueta en la carga útil.
El mensaje de notificación puede dirigirse a varios dispositivos o usuarios especificando varios deviceID o userID respectivamente, en el bloque de destino de la API del mensaje POST.


## Notificaciones SMS
{: #sms-notifications }
Para recibir notificaciones SMS, la aplicación primero se debe registrar a una suscripción de notificación SMS.
Para suscribirse a notificaciones SMS, el usuario proporciona un número de teléfono móvil y aprueba la suscripción de notificación.
Se envía una solicitud de suscripción a {{ site.data.keys.mf_server }} después de la recepción de la aprobación del usuario.
Cuando se recupera una notificación desde {{ site.data.keys.mf_console }}, se procesa y envía a través de una pasarela SMS configurada de forma previa.


Consulte la guía de aprendizaje de [Envío de notificaciones](sending-notifications) para configurar la pasarela.


## Valores de proxy
{: #proxy-settings }
Utilice los valores de proxy para establecer el proxy opcional a través de la cual se enviarán notificaciones a APNS y GCM.
El proxy se configura mediante las propiedades de configuración **push.apns.proxy.*** y **push.gcm.proxy.***.
Para obtener más información, consulte [Lista de propiedades JNDI para el servicio push de {{ site.data.keys.mf_server }}](../installation-configuration/production/server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service).


> **Nota:** WNS no tiene soporte de proxy. 

## Guías de aprendizaje con las que continuar
{: #tutorials-to-follow-next }
Siga a través de la siguiente configuración necesaria del lado del servidor y del lado del cliente para poder enviar y recibir notificaciones push:

