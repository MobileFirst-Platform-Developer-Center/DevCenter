---
layout: tutorial
title: Manejo de las notificaciones push en iOS
breadcrumb_title: iOS
relevantTo: [ios]
weight: 5
downloads:
  - name: Download Xcode project
    url: https://github.com/MobileFirst-Platform-Developer-Center/PushNotificationsSwift/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
La API de notificaciones que {{ site.data.keys.product_adj }} proporciona sirve para registrar y anular el registro de dispositivos y suscribir y anular la suscripción a etiquetas. En esta guía de aprendizaje, aprenderá a manejar el envío de notificaciones en aplicaciones iOS utilizando Swift.

Para obtener información sobre las notificaciones interactivas o silenciosas, consulte:

* [Notificaciones silenciosas](../silent)
* [Notificaciones interactivas](../interactive)

**Requisitos previos: **

* Asegúrese de haber leído las siguientes guías de aprendizaje:
	* [Visión general de notificaciones push](../../)
    * [Configuración del entorno de desarrollo de {{ site.data.keys.product_adj }}](../../../installation-configuration/#installing-a-development-environment)
    * [Adición de {{ site.data.keys.product }} SDK a aplicaciones iOS](../../../application-development/sdk/ios)
* {{ site.data.keys.mf_server }} para ejecutar localmente, o un remotamente ejecutando {{ site.data.keys.mf_server }}.
* {{ site.data.keys.mf_cli }} instalado en la estación de trabajo del desarrollador


### Ir a:
{: #jump-to }
* [Configuración de notificaciones](#notifications-configuration)
* [API de notificaciones](#notifications-api)
* [Manejo de una notificación push](#handling-a-push-notification)


### Configuración de notificaciones
{: #notifications-configuration }
Cree un nuevo proyecto Xcode o utilice uno existente.
Si {{ site.data.keys.product_adj }} Native iOS SDK todavía no está presente en el proyecto, siga las instrucciones en la guía de aprendizaje [Adición de {{ site.data.keys.product }} SDK para aplicaciones iOS](../../../application-development/sdk/ios).


### Añadir el SDK de push
{: #adding-the-push-sdk }
1. Abra el **podfile** existente del proyecto y añada las siguientes líneas:

   ```xml
   use_frameworks!

   platform :ios, 8.0
   target "Xcode-project-target" do
        pod 'IBMMobileFirstPlatformFoundation'
        pod 'IBMMobileFirstPlatformFoundationPush'
   end

   post_install do |installer|
        workDir = Dir.pwd

        installer.pods_project.targets.each do |target|
            debugXcconfigFilename = "#{workDir}/Pods/Target Support Files/#{target}/#{target}.debug.xcconfig"
            xcconfig = File.read(debugXcconfigFilename)
            newXcconfig = xcconfig.gsub(/HEADER_SEARCH_PATHS = .*/, "HEADER_SEARCH_PATHS = ")
            File.open(debugXcconfigFilename, "w") { |file| file << newXcconfig }

            releaseXcconfigFilename = "#{workDir}/Pods/Target Support Files/#{target}/#{target}.release.xcconfig"
            xcconfig = File.read(releaseXcconfigFilename)
            newXcconfig = xcconfig.gsub(/HEADER_SEARCH_PATHS = .*/, "HEADER_SEARCH_PATHS = ")
            File.open(releaseXcconfigFilename, "w") { |file| file << newXcconfig }
        end
   end
   ```
    - Sustituya **Xcode-project-target** con el nombre de su destino de proyecto Xcode.

2. Guarde y cierre el **podfile**.
3. Desde una ventana de **línea de mandatos**, vaya a la carpeta raíz del proyecto.
4. Ejecute el mandato `pod install`
5. Abra proyecto utilizando el archivo **.xcworkspace**.

## API de notificaciones
{: #notifications-api }
### Instancia de MFPPush
{: #mfppush-instance }
Todas las llamadas de API se deben realizar en una instancia de `MFPPush`.  Esto se puede realizar utilizando una `var` en un controlador de vista, por ejemplo, `var push = MFPPush.sharedInstance();` y, a continuación, llamando a `push.methodName()` a través del controlador de vista.

Otra posibilidad es llamar a `MFPPush.sharedInstance().methodName()` para cada instancia en la que necesita acceder a los métodos de API de push.

### Manejadores de desafíos
{: #challenge-handlers }
Si el ámbito de `push.mobileclient` está correlacionado con la **comprobación de seguridad**, debe asegurarse de que existen **manejadores de desafíos** coincidentes registrados antes de utilizar las API de push.

> Aprenda más sobre los manejadores de desafíos en la guía de aprendizaje de [validación de credenciales](../../../authentication-and-security/credentials-validation/ios).

### Lado del cliente
{: #client-side }

|Métodos Swift |Descripción  |
|---------------|--------------|
|[`initialize()`](#initialization) |Inicia MFPPush con el contexto proporcionado. |
|[`isPushSupported()`](#is-push-supported) |Indica si el dispositivo da soporte a notificaciones push. |
|[`registerDevice(completionHandler: ((WLResponse!, NSError!) -> Void)!)`](#register-device--send-device-token) |Registra el dispositivo con el servicio de notificaciones push.|
|[`sendDeviceToken(deviceToken: NSData!)`](#register-device--send-device-token) |Envía la señal de dispositivo al servidor |
|[`getTags(completionHandler: ((WLResponse!, NSError!) -> Void)!)`](#get-tags) |Recupera las etiquetas disponibles en una instancia del servicio de notificaciones push. |
|[`subscribe(tagsArray: [AnyObject], completionHandler: ((WLResponse!, NSError!) -> Void)!)`](#subscribe) |Suscribe el dispositivo para las etiquetas especificadas. |
|[`getSubscriptions(completionHandler: ((WLResponse!, NSError!) -> Void)!)`](#get-subscriptions)  |Recupera todas las etiquetas a las que el dispositivo está actualmente suscrito. |
|[`unsubscribe(tagsArray: [AnyObject], completionHandler: ((WLResponse!, NSError!) -> Void)!)`](#unsubscribe) |Anula la suscripción de una o varias etiquetas. |
|[`unregisterDevice(completionHandler: ((WLResponse!, NSError!) -> Void)!)`](#unregister) |Anula el registro del dispositivo del servicio notificaciones push.              |

#### Inicialización
{: #initialization }
La inicialización es necesaria para que la aplicación de cliente se conecte al servicio MFPPush.

* Primero se debe llamar al método `initialize` antes de utilizar cualquier otra API MFPPush.
* Registra la función de retorno de llamada para manejar las notificaciones push recibidas.

```swift
MFPPush.sharedInstance().initialize();
```

#### Está push soportado
{: #is-push-supported }
Comprueba si el dispositivo da soporte a las notificaciones push.

```swift
let isPushSupported: Bool = MFPPush.sharedInstance().isPushSupported()

if isPushSupported {
    // Push is supported
} else {
    // Push is not supported
}
```

#### Registrar el dispositivo y enviar una señal de dispositivo
{: #register-device--send-device-token }
Registre el dispositivo para el servicio de notificaciones push.

```swift
MFPPush.sharedInstance().registerDevice(nil) { (response, error) -> Void in
    if error == nil {
        self.enableButtons()
        self.showAlert("Registered successfully")
        print(response?.description ?? "")
    } else {
        self.showAlert("Registrations failed.  Error \(error?.localizedDescription)")
        print(error?.localizedDescription ?? "")
    }
}
```

<!--`options` = `[NSObject : AnyObject]` which is an optional parameter that is a dictionary of options to be passed with your register request, sends the device token to the server to register the device with its unique identifier.-->

```swift
MFPPush.sharedInstance().sendDeviceToken(deviceToken)
```

> **Nota:** Habitualmente la llamada se realiza en **AppDelegate** en el método `didRegisterForRemoteNotificationsWithDeviceToken`.

#### Obtener etiquetas
{: #get-tags }
Recupere todas las etiquetas disponibles desde el servicio de notificaciones push.

```swift
MFPPush.sharedInstance().getTags { (response, error) -> Void in
    if error == nil {
        print("The response is: \(response)")
        print("The response text is \(response?.responseText)")
        if response?.availableTags().isEmpty == true {
            self.tagsArray = []
            self.showAlert("There are no available tags")
        } else {
            self.tagsArray = response!.availableTags() as! [String]
            self.showAlert(String(describing: self.tagsArray))
            print("Tags response: \(response)")
        }
    } else {
        self.showAlert("Error \(error?.localizedDescription)")
        print("Error \(error?.localizedDescription)")
    }
}
```


#### Suscribir
{: #subscribe }
Suscriba las etiquetas deseadas.

```swift
var tagsArray: [String] = ["Tag 1", "Tag 2"]

MFPPush.sharedInstance().subscribe(self.tagsArray) { (response, error)  -> Void in
    if error == nil {
        self.showAlert("Subscribed successfully")
        print("Subscribed successfully response: \(response)")
    } else {
        self.showAlert("Failed to subscribe")
        print("Error \(error?.localizedDescription)")
    }
}
```


#### Obtener suscripciones
{: #get-subscriptions }
Recupere las etiquetas a las que el dispositivo está actualmente suscrito.

```swift
MFPPush.sharedInstance().getSubscriptions { (response, error) -> Void in
   if error == nil {
       var tags = [String]()
       let json = (response?.responseJSON)! as [AnyHashable: Any]
       let subscriptions = json["subscriptions"] as? [[String: AnyObject]]
       for tag in subscriptions! {
           if let tagName = tag["tagName"] as? String {
               print("tagName: \(tagName)")
               tags.append(tagName)
           }
       }
       self.showAlert(String(describing: tags))
   } else {
       self.showAlert("Error \(error?.localizedDescription)")
       print("Error \(error?.localizedDescription)")
   }
}
```


#### Anular la suscripción
{: #unsubscribe }
Anule la suscripción de etiquetas.

```swift
var tags: [String] = {"Tag 1", "Tag 2"};

// Unsubscribe from tags
MFPPush.sharedInstance().unsubscribe(self.tagsArray) { (response, error)  -> Void in
    if error == nil {
        self.showAlert("Unsubscribed successfully")
        print(String(describing: response?.description))
    } else {
        self.showAlert("Error \(error?.localizedDescription)")
        print("Error \(error?.localizedDescription)")
    }
}
```

#### Anular el registro
{: #unregister }
Anule el registro del dispositivo de una instancia de servicio de notificaciones push.

```swift
MFPPush.sharedInstance().unregisterDevice { (response, error)  -> Void in
   if error == nil {
       // Disable buttons
       self.disableButtons()
       self.showAlert("Unregistered successfully")
       print("Subscribed successfully response: \(response)")
   } else {
       self.showAlert("Error \(error?.localizedDescription)")
       print("Error \(error?.localizedDescription)")
   }
}
```

## Manejar una notificación push
{: #handling-a-push-notification }

La infraestructura iOS nativa maneja directamente las notificaciones push. Dependiendo del ciclo de vida de su aplicación, la infraestructura iOS llamará a distintos métodos.

Por ejemplo si se recibe una notificación simple mientras se ejecuta la aplicación, se desencadenará el `didReceiveRemoteNotification` de **AppDelegate**:

```swift
func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
    print("Received Notification in didReceiveRemoteNotification \(userInfo)")
    // display the alert body
      if let notification = userInfo["aps"] as? NSDictionary,
        let alert = notification["alert"] as? NSDictionary,
        let body = alert["body"] as? String {
          showAlert(body)
        }
}
```

> Obtenga más información sobre el manejo de notificaciones en iOS de la documentación Apple: http://bit.ly/1ESSGdQ

<img alt="Imagen de la aplicación de ejemplo" src="notifications-app.png" style="float:right"/>

## Aplicación de ejemplo
{: #sample-application }
[Pulse para descargar](https://github.com/MobileFirst-Platform-Developer-Center/PushNotificationsSwift/tree/release80) el proyecto Xcode.

### Uso de ejemplo
{: #sample-usage }
Siga el archivo README.md de ejemplo para obtener instrucciones.
