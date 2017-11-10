---
layout: tutorial
title: Notificaciones silenciosas
relevantTo: [ios,cordova]
show_in_nav: false
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
Las notificaciones silenciosas son notificaciones que no visualizan alertas ni interrumpen al usuario.
Cuando llega una notificación silenciosa, la aplicación que se encarga del código lo ejecuta en un segundo plano sin llevar la aplicación a un primer plano.
Actualmente, se da soporte a las instalaciones silenciosas en dispositivos iOS a partir de la versión 7.
Si se envía una notificación silenciosa a dispositivos iOS con una versión anterior a la 7, si la aplicación se ejecuta en un segundo plano, se ignora la notificación.
Si la aplicación se está ejecutando en un primer plano, se invoca al método de llamada de retorno de notificación.


## Enviar notificaciones push silenciosas
{: #sending-silent-push-notifications }
La notificación se debe preparar antes de enviarla.
Para obtener más información, consulte [Envío de notificaciones push](../../sending-notifications).


Los tres tipos de notificaciones a las que iOS da soporte se representan con las constantes `DEFAULT`, `SILENT` y `MIXED`.
Cuando el tipo no se especifica de forma explícita, se presupone el tipo `DEFAULT`.


Para las notificaciones del tipo `MIXED`, se visualiza un mensaje en el dispositivo a la vez que, en un segundo plano, la aplicación se activa y procesa la notificación silenciosa.
El método de retorno de llamada para las notificaciones del tipo `MIXED` es llamado dos veces, una vez cuando la notificación silenciosa llega al dispositivo y otra al abrir la aplicación al pulsar en la notificación.


Basándose en sus requisitos elija el tipo apropiado bajo **{{ site.data.keys.mf_console }} → [su aplicación] → Push → Enviar notificaciones → Valores personalizados de iOS**.
 

> **Nota:** Si la alerta es silenciosa, se ignoran las propiedades **alert**, **sound** y **badge**.


![Configuración del tipo de notificación silenciosa de iOS en {{ site.data.keys.mf_console }}](notification-type-for-silent-notifications.png)


## Manejar notificaciones push silenciosas en aplicaciones Cordova
{: #handling-silent-push-notifications-in-cordova-applications }
En el método de llamada de retorno de notificación push JavaScript, debe realizar los siguientes pasos:


1. Compruebe el tipo de notificación. Por ejemplo:

   ```javascript
   if(props['content-available'] == 1) {
        //Silent Notification or Mixed Notification. Perform non-GUI tasks here.
   } else {
        //Normal notification
   }
   ```

2. Si la notificación es silenciosa o mixta, después de completar el trabajo de fondo, invoque a la API `WL.Client.Push.backgroundJobDone`.


## Manejar notificaciones push silenciosas en aplicaciones iOS nativas
{: #handling-silent-push-notifications-in-native-ios-applications }
Debe seguir estos pasos para recibir notificaciones silenciosas:


1. Habilite la funcionalidad de la aplicación para realizar tareas de fondo al recibir las notificaciones remotas.

2. Compruebe si la notificación es silenciosa verificando si la clave `content-available` se ha establecido en **1**.

3. Después de finalizar el proceso de notificación, debe llamar inmediatamente al bloque en el parámetro de manejador, de lo contrario su aplicación habrá terminado.
Su aplicación tiene hasta 30 segundos para procesar la notificación y llamar al bloque del manejador de finalización especificado.

