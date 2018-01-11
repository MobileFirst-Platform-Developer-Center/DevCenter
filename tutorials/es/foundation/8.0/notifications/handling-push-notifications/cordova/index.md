---
layout: tutorial
title: Manejo de notificaciones push en Cordova
breadcrumb_title: Cordova
relevantTo: [cordova]
downloads:
  - name: Download Cordova project
    url: https://github.com/MobileFirst-Platform-Developer-Center/PushNotificationsCordova/tree/release80
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
Antes de que las aplicaciones iOS, Android y Windows Cordova reciban y visualicen notificaciones push, es necesario añadir el plugin Cordova **cordova-plugin-mfp-push** al proyecto Cordova.
Una vez se haya configurado la aplicación, se pueden utilizar la API de notificaciones que {{ site.data.keys.product_adj }} proporciona con el propósito de registrar y anular el registro de dispositivos, suscribir y anular la suscripción de etiquetas y manejar aplicaciones.
En esta guía de aprendizaje, aprenderá a manejar el envío de notificaciones en aplicaciones Cordova.


> **Nota:** Actualmente en Cordova **no se da soporte** a las notificaciones autenticadas debido a un defecto.
Sin embargo se proporciona un método alternativo: cada llamada de API de `MFPPush` puede ser acomodada mediante `WLAuthorizationManager.obtainAccessToken("push.mobileclient").then( ... );`.
La aplicación de ejemplo que se proporciona utiliza este método alternativo.


Para obtener información sobre las notificaciones interactivas o silenciosas en iOS, consulte: 

* [Notificaciones silenciosas](../silent)
* [Notificaciones interactivas](../interactive)

**Requisitos previos:**

* Asegúrese de haber leído las siguientes guías de aprendizaje:

    * [Configuración del entorno de desarrollo de {{ site.data.keys.product_adj }}](../../../installation-configuration/#installing-a-development-environment)
    * [Adición de {{ site.data.keys.product }} SDK a aplicaciones Cordova](../../../application-development/sdk/cordova)
    * [Visión general de notificaciones push](../../)
* {{ site.data.keys.mf_server }} para ejecutar localmente, o un remotamente ejecutando {{ site.data.keys.mf_server }} 
* {{ site.data.keys.mf_cli }} instalado en la estación de trabajo del desarrollador
* Interfaz de línea de mandatos (CLI) de Cordova instalada en la estación de trabajo del desarrollador

#### Ir a 
{: #jump-to }
* [Configuración de notificaciones](#notifications-configuration)
* [API de notificaciones](#notifications-api)
* [Manejo de una notificación push](#handling-a-push-notification)
* [Aplicación de ejemplo](#sample-application)

## Configuración de notificaciones
{: #notifications-configuration }
Cree un nuevo proyecto Cordova o utilice uno ya existente, y añada una o varias de las plataformas soportadas: iOS, Android, Windows.

> Si {{ site.data.keys.product_adj }} Cordova SDK todavía no está presente en el proyecto, siga las instrucciones en la guía de aprendizaje [Adición de {{ site.data.keys.product }} SDK para aplicaciones Cordova](../../../application-development/sdk/cordova).


### Añadir el plugin de push
{: #adding-the-push-plug-in }
1. Desde una ventana de **línea de mandatos**, vaya a la raíz del proyecto Cordova.
  

2. Añada el plugin ejecutando el mandato:

   ```bash
   cordova plugin add cordova-plugin-mfp-push
   ```

3. Compile el proyecto Cordova ejecutando el mandato:

   ```bash
   cordova build
   ```

### Plataforma iOS
{: #ios-platform }
La plataforma iOS precisa de un paso adicional.
  
En Xcode, habilite el envío de notificaciones para la aplicación en la pantalla **Funcionalidades**.


> <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> **Importante:** el bundleId seleccionado para la aplicación debe coincidir con el AppID creado con anterioridad en el sitio de Apple Developer.
Consulte la guía de aprendizaje [Visión general de notificaciones push].



![imagen de la funcionalidad en Xcode](push-capability.png)

### Plataforma Android
{: #android-platform }
La plataforma Android precisa de un paso adicional.
  
En Android Studio, añada la siguiente `actividad` a la etiqueta `application`: 

```xml
<activity android:name="com.ibm.mobilefirstplatform.clientsdk.android.push.api.MFPPushNotificationHandler" android:theme="@android:style/Theme.NoDisplay"/>
```

## API de notificaciones
{: #notifications-api }
### Lado del cliente
{: #client-side }

| Función Javascript| Descripción |
| --- | --- |
| [`MFPPush.initialize(success, failure)`](#initialization) | Inicializa la instancia MFPPush. | 
| [`MFPPush.isPushSupported(success, failure)`](#is-push-supported) | Indica si el dispositivo da soporte a notificaciones push. | 
| [`MFPPush.registerDevice(options, success, failure)`](#register-device) | Registra el dispositivo con el servicio de notificaciones push. | 
| [`MFPPush.getTags(success, failure)`](#get-tags) | Recupera todas las etiquetas disponibles en una instancia de servicio de notificaciones push. | 
| [`MFPPush.subscribe(tag, success, failure)`](#subscribe) | Suscribe a una etiqueta concreta. | 
| [`MFPPush.getSubsciptions(success, failure)`](#get-subscriptions) | Recupera las etiquetas de servicio a las que actualmente está suscrito. | 
| [`MFPPush.unsubscribe(tag, success, failure)`](#unsubscribe) | Anula la suscripción a una etiqueta concreta. | 
| [`MFPPush.unregisterDevice(success, failure)`](#unregister) | Anula el registro del dispositivo del servicio notificaciones push. | 

### Implementación de API
{: #api-implementation }
#### Inicialización
{: #initialization }
Inicializa la instancia **MFPPush**.


- Requerido para la aplicación de cliente para conectarse al servicio MFPPush con el contexto de aplicación correcto.   
- Primero se debe llamar al método de la API antes de utilizar cualquier otra API MFPPush.

- Registra la función de retorno de llamada para manejar las notificaciones push recibidas. 

```javascript
MFPPush.initialize (
    function(successResponse) {
        alert("Successfully intialized");
        MFPPush.registerNotificationsCallback(notificationReceived);
    },
    function(failureResponse) {
        alert("Failed to initialize");
    }
);
```

#### Está push soportado
{: #is-push-supported }
Comprueba si el dispositivo da soporte a las notificaciones push. 

```javascript
MFPPush.isPushSupported (
    function(successResponse) {
        alert("Push Supported: " + successResponse);
    },
    function(failureResponse) {
        alert("Failed to get push support status");
    }
);
```

#### Registrar el dispositivo
{: #register-device }
Registre el dispositivo para el servicio de notificaciones push. Si no se proporcionan opciones, se pueden establecer en `null`.


```javascript
var options = { };
MFPPush.registerDevice(
    options,
    function(successResponse) {
        alert("Successfully registered");
    },
    function(failureResponse) {
        alert("Failed to register");
    }
);
```

#### Obtener etiquetas
{: #get-tags }
Recupere todas las etiquetas disponibles desde el servicio de notificaciones push. 

```javascript
MFPPush.getTags (
    function(tags) {
        alert(JSON.stringify(tags));
},
    function() {
        alert("Failed to get tags");
    }
);
```

#### Suscribir
{: #subscribe }
Suscriba las etiquetas deseadas. 

```javascript
var tags = ['sample-tag1','sample-tag2'];

MFPPush.subscribe(
    tags,
    function(tags) {
        alert("Subscribed successfully");
    },
    function() {
        alert("Failed to subscribe");
    }
);
```

#### Obtener suscripciones
{: #get-subscriptions }
Recupere las etiquetas a las que el dispositivo está actualmente suscrito.


```javascript
MFPPush.getSubscriptions (
    function(subscriptions) {
        alert(JSON.stringify(subscriptions));
    },
    function() {
        alert("Failed to get subscriptions");
    }
);
```

#### Anular la suscripción
{: #unsubscribe }
Anule la suscripción de etiquetas. 

```javascript
var tags = ['sample-tag1','sample-tag2'];

MFPPush.unsubscribe(
    tags,
    function(tags) {
        alert("Unsubscribed successfully");
    },
    function() {
        alert("Failed to unsubscribe");
    }
);
```

#### Anular el registro
{: #unregister }
Anule el registro del dispositivo de una instancia de servicio de notificaciones push. 

```javascript
MFPPush.unregisterDevice(
    function(successResponse) {
        alert("Unregistered successfully");
    },
    function() {
        alert("Failed to unregister");
    }
);
```

## Manejar una notificación push
{: #handling-a-push-notification }
Las notificaciones push recibidas se pueden manejar trabajando con el objeto de respuesta en la función de retorno registrada.


```javascript
var notificationReceived = function(message) {
    alert(JSON.stringify(message));
};
```

<img alt="Imagen de la aplicación de ejemplo" src="notifications-app.png" style="float:right"/>
## Aplicación de ejemplo
{: #sample-application }
[
Pulse para descargar](https://github.com/MobileFirst-Platform-Developer-Center/PushNotificationsCordova/tree/release80) el proyecto Cordova.


**Nota:** Se necesita instalada la última versión de Google Play Services en el dispositivo Android para poder ejecutar el ejemplo.


### Uso de ejemplo
{: #sample-usage }
Siga el archivo README.md de ejemplo para obtener instrucciones.

