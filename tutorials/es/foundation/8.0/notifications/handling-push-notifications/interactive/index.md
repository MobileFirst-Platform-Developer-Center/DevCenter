---
layout: tutorial
title: Notificaciones interactivas
relevantTo: [ios, cordova]
show_in_nav: false
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
En las notificaciones interactivas, cuando una notificación llega, los usuarios pueden tomar acciones con relación a la misma sin abrir la aplicación. Cuando llega una notificación interactiva, el dispositivo muestra los botones de la acción junto con el mensaje de notificación.

Las notificaciones interactivas están soportadas en dispositivos en iOS versión 8 y posterior. Si se envía una notificación interactiva a un dispositivo iOS con una versión anterior a la versión 8, las acciones de la notificación no se visualizarán.

## Enviar notificaciones push interactivas
{: #sending-interactive-push-notification }
La notificación se debe preparar antes de enviarla. Para obtener más información, consulte [Envío de notificaciones push](../../sending-notifications).

Establezca una serie para indicar la categoría de la notificación con el objeto de notificación, bajo **{{ site.data.keys.mf_console }} → [su aplicación] → Push → Enviar notificaciones → Valores personalizados iOS**. Basándose en el valor de la categoría, se visualizan los botones de acción de la notificación. Por ejemplo:

![Establecer categorías para notificaciones interactivas de iOS en {{ site.data.keys.mf_console }}](categories-for-interactive-notifications.png)

## Manejo de notificaciones push interactivas en aplicaciones Cordova
{: #handling-interactive-push-notifications-in-cordova-applications }
Para recibir notificaciones interactivas, siga estos pasos:

1. En la sección JavaScript main, defina las categorías registradas para la notificación interactiva y pásela a la llamada de registro de dispositivo `MFPPush.registerDevice`.

   ```javascript
   var options = {
        ios: {
            alert: true,
            badge: true,
            sound: true,     
            categories: [{
                //Category identifier, this is used while sending the notification.
                id : "poll", 

                //Optional array of actions to show the action buttons along with the message.    
                actions: [{
                    //Action identifier
                    id: "poll_ok", 

                    //Action title to be displayed as part of the notification button.
                    title: "OK", 

                    //Optional mode to run the action in foreground or background. 1-foreground. 0-background. Default is foreground.
                    mode: 1,  

                    //Optional property to mark the action button in red color. Default is false.
                    destructive: false,

                    //Optional property to set if authentication is required or not before running the action.(Screen lock).
                    //For foreground, this property is always true.
                    authenticationRequired: true
                },
                {
                    id: "poll_nok",
                    title: "NOK",
                    mode: 1,
                    destructive: false,
                    authenticationRequired: true
                }],
                    
                //Optional list of actions that is needed to show in the case alert. 
                //If it is not specified, then the first four actions will be shown.
                defaultContextActions: ['poll_ok','poll_nok'],

                //Optional list of actions that is needed to show in the notification center, lock screen. 
                //If it is not specified, then the first two actions will be shown.
                minimalContextActions: ['poll_ok','poll_nok'] 
            }]     
        }
   }
   ```

2. Pase el objeto `options` mientras registra el dispositivo para las notificaciones push.

   ```javascript
   MFPPush.registerDevice(options, function(successResponse) {
  		navigator.notification.alert("Successfully registered");
  		enableButtons();
   });  
   ```

## Manejo de notificaciones push interactivas en aplicaciones iOS nativas
{: #handling-interactive-push-notifications-in-native-ios-applications }
Siga estos pasos para recibir notificaciones interactivas:

1. Habilite la funcionalidad de la aplicación para realizar tareas de fondo al recibir las notificaciones remotas. Este paso es necesario si algunas de las acciones están habilitadas para procesos de fondo.
2. Defina categorías registradas para las notificaciones interactivas y páselas como opciones a `MFPPush.registerDevice`.

   ```swift
   //define categories for Interactive Push
   let acceptAction = UIMutableUserNotificationAction()
   acceptAction.identifier = "OK"
   acceptAction.title = "OK"
   acceptAction.activationMode = .Foreground

   let rejetAction = UIMutableUserNotificationAction()
   rejetAction.identifier = "Cancel"
   rejetAction.title = "Cancel"
   rejetAction.activationMode = .Foreground

   let category = UIMutableUserNotificationCategory()
   category.identifier = "poll"
   category.setActions([acceptAction, rejetAction], forContext: .Default)

   let categories:Set<UIUserNotificationCategory> = [category]

   let options = ["alert":true, "badge":true, "sound":true, "categories": categories]

   // Register device
    MFPPush.sharedInstance().registerDevice(options as [NSObject : AnyObject], completionHandler: {(response: WLResponse!, error: NSError!) -> Void in
   ```
