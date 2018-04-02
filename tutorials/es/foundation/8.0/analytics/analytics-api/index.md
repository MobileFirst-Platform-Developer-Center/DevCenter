---
layout: tutorial
title: Utilización de la API de analíticas en aplicaciones cliente
breadcrumb_title: Analytics API
relevantTo: [ios,android,javascript]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }

{{ site.data.keys.mf_analytics_full }}
proporciona API del lado del cliente que permite recopilar datos analíticos sobre la aplicación. Esta guía de aprendizaje proporciona información sobre cómo configurar el soporte de analíticas en la aplicación de cliente y lista las API disponibles.

#### Ir a
{: #jump-to }

* [Configuración de analíticas en el lado del cliente](#configuring-analytics-on-the-client-side)
* [Envío de datos de analíticas](#sending-analytics-data)
* [Habilitación/inhabilitación de sucesos de cliente](#enablingdisabling-client-event-types)
* [Sucesos personalizados](#custom-events)
* [Seguimiento de usuarios](#tracking-users)

## Configuración de analíticas en el lado del cliente
{: #configuring-analytics-on-the-client-side }

Antes de iniciar la recopilación de datos predefinidos que {{ site.data.keys.mf_analytics }} proporciona, debe importar las correspondientes bibliotecas para inicializar el soporte de analíticas.

### JavaScript (Cordova)
{: #javascript-cordova }

En aplicaciones Cordova no es necesaria ninguna configuración inicial y la inicialización ya viene incorporada.  

### JavaScript (Web)
{: #javascript-web }

En aplicaciones web, se debe hacer referencia a los archivos JavaScript de analíticas. Asegúrese de que primero ha añadido {{ site.data.keys.product_adj }} Web SDK. Para obtener más información, consulte la guía de aprendizaje de [Adición de {{ site.data.keys.product_adj }} SDK para aplicaciones web](../../application-development/sdk/web).  

Según de cómo se haya añadido {{ site.data.keys.product_adj }} Web SDK, siga de una de las siguientes maneras:


Referencia a {{ site.data.keys.mf_analytics }} en el elemento `HEAD`:

```html
<head>
    ...
    <script type="text/javascript" src="node_modules/ibm-mfp-web-sdk/lib/analytics/ibmmfpfanalytics.js"></script>
    <script type="text/javascript" src="node_modules/ibm-mfp-web-sdk/ibmmfpf.js"></script>
</head>
```

O, si está utilizando RequireJS, escriba:

```javascript
require.config({
	'paths': {
		'ibmmfpfanalytics': 'node_modules/ibm-mfp-web-sdk/lib/analytics/ibmmfpfanalytics',
		'mfp': 'node_modules/ibm-mfp-web-sdk/ibmmfpf'
	}
});

require(['ibmmfpfanalytics','mfp'], function(ibmmfpfanalytics, WL) {
    // application logic.
});
```

Tenga en cuenta que puede seleccionar su propio espacio de nombres para sustituir "ibmmfpfanalytics".


```javascript
ibmmfpfanalytics.logger.config({analyticsCapture: true});
```

 **Importante**:
Existen algunas diferencias en las API de JavaScript entre los SDK Web y de Cordova. Consulte el tema [Consulta de API](../../api/) en la documentación del usuario.

### iOS
{: #ios }

#### Importación de la biblioteca WLAnalytics
{: #importing-the-wlanalytics-library }

**Objective-C**

```objc
import "WLAnalytics.h"
```

**Swift**

```Swift
import IBMMobileFirstPlatformFoundation
```

#### Inicialización de Analytics
{: #initialize-analytics-ios }

**Objective-C**  
No hace falta configuración. Preinicializado de forma predeterminada.

**Swift**  
Antes de llamar a otros métodos de la clase **WLAnalytics**, llame a `WLAnalytics.sharedInstance()`.

### Android
{: #android }

#### Importación de WLAnalytics
{: #import-wlanalytics }

```java
import com.worklight.common.WLAnalytics;
```

#### Inicialización de Analytics
{: #initialize-analytics-android }

Dentro del método `onCreate` de su actividad principal incluya:

```java
WLAnalytics.init(this.getApplication());
```


## Habilitación/inhabilitación de tipos de suceso de cliente
{: #enablingdisabling-client-event-types }

La API de analíticas proporciona al desarrollador la posibilidad de habilitar o inhabilitar la recopilación de analíticas para el suceso que deseen visualizar en su instancia de {{ site.data.keys.mf_analytics_console }}.

La API {{ site.data.keys.mf_analytics }} permite la captura de las métricas siguientes.

* **Sucesos del ciclo de vida**: frecuencia de utilización de las aplicaciones, duración del uso, frecuencia de bloqueos.
* **Uso de red**: desglose de frecuencias de llamadas de API, métricas de rendimiento de red
* **Usuarios**: usuarios de la aplicación identificados por un ID de usuario proporcionado
* **Analíticas personalizadas**: parejas de clave/valor personalizados que el desarrollador de la aplicación define

La inicialización de las API de analíticas debe escribirse en código nativo, incluso en aplicaciones Cordova.

 * Para capturar el uso de las aplicaciones, se deben registrar los escuchas de sucesos del ciclo de vida antes de que se produzca el suceso relevante y antes de enviar los datos al servidor.
 * Para utilizar el sistema de archivos o las características de los dispositivos y el lenguaje nativo, se debe inicializar la API. Si la API se utiliza de una forma que precise características del dispositivo nativo (como, por ejemplo el sistema de archivos), pero no esta inicializada, la llamada de la API falla. Este comportamiento es especialmente cierto en Android.

**Nota**: Para crear aplicaciones Cordova, la API de analíticas de JavaScript no tiene métodos para habilitar o inhabilitar la recopilación de sucesos `LIFECYCLE` o `NETWORK`. En otras palabras, las aplicaciones Cordova vienen de forma predeterminada con sucesos `LIFECYCLE` y `NETWORK` habilitados de forma previa. Si desea inhabilitar estos sucesos, consulte [Sucesos de ciclo de vida de cliente](#client-lifecycle-events) y [Sucesos de red de cliente](#client-lifecycle-events).

### Sucesos de ciclo de vida de cliente
{: #client-lifecycle-events }

Una vez que configurado el SDK de analíticas, las sesiones de la aplicación empiezan a ser grabadas en el dispositivo del usuario. Se graba una sesión en {{ site.data.keys.mf_analytics }} cuando la aplicación se pasa desde el primer plano al segundo plano, lo que crea una sesión en {{ site.data.keys.mf_analytics_console_short }}.

Tan pronto como el dispositivo está configurado para registrar sesiones y envía los datos, puede ver {{ site.data.keys.mf_analytics_console_short }} cumplimentado con datos, tal como se muestra a continuación.

![gráfico de sesiones](analytics-app-sessions.png)

Habilite o inhabilite la recopilación de sesiones de aplicación mediante la API de {{ site.data.keys.mf_analytics_short }}.

#### JavaScript
{: #javascript-lifecycle-events }

**Web**  
Para utilizar los sucesos del ciclo de vida de cliente, inicialice las analíticas:

```javascript
ibmmfpfanalytics.logger.config({analyticsCapture: true});
```

**Cordova**  
Para habilitar la captura de los sucesos del ciclo de vida, se debe inicializar en la plataforma nativa de la aplicación Cordova.

* Para la plataforma iOS:
	* Abra la carpeta **[Carpeta raíz aplicación Cordova] → plataformas → ios → Clases** y encuentre el archivo **AppDelegate.m** (Objective-C) o **AppDelegate.swift** (Swift).
	* Siga la guía de iOS más abajo para habilitar o inhabilitar las actividades de `LIFECYCLE`.
	* Compile el proyecto Cordova ejecutando el mandato: `cordova build`.

* Para la plataforma Android:
	* Abra el archivo **[carpeta raíz aplicación Cordova] → plataformas → android → src → com → sample → [nombre-app] → MainActivity.java**.
	* Busque el método `onCreate` y siga la guía de Android más abajo para habilitar o inhabilitar las actividades de `LIFECYCLE`.
	* Compile el proyecto Cordova ejecutando el mandato: `cordova build`.

#### Android
{: #android-lifecycle-events }

Para habilitar el registro de sucesos del ciclo de vida del cliente:

```java
WLAnalytics.addDeviceEventListener(DeviceEvent.LIFECYCLE);
```

Para inhabilitar el registro de sucesos del ciclo de vida del cliente:

```java
WLAnalytics.removeDeviceEventListener(DeviceEvent.LIFECYCLE);
```

#### iOS
{: #ios-lifecycle-events }

Para habilitar el registro de sucesos del ciclo de vida del cliente:

**Objective-C:**

```objc
[[WLAnalytics sharedInstance] addDeviceEventListener:LIFECYCLE];
```

**Swift:**

```swift
WLAnalytics.sharedInstance().addDeviceEventListener(LIFECYCLE);
```

Para inhabilitar el registro de sucesos del ciclo de vida del cliente:

**Objective-C:**

```objc
[[WLAnalytics sharedInstance] removeDeviceEventListener:LIFECYCLE];
```

**Swift:**

```swift
WLAnalytics.sharedInstance().removeDeviceEventListener(LIFECYCLE);
```

### Actividades de red de cliente
{: #client-network-activities }

La recopilación en adaptadores y la red puede darse en dos ubicaciones diferentes: en el cliente y en el servidor:

* El cliente recopila información como, por ejemplo, el tiempo de ida y vuelta y el tamaño de carga útil al iniciar la recopilación en el suceso de dispositivo de `NETWORK`.

* El servidor recopila información de fondo como, por ejemplo, el tiempo de proceso, el uso del adaptador y los procedimientos utilizados.

Puesto que el cliente y el servidor recopilan cada uno su propia información, los diagramas no muestran información hasta que el cliente está configurado para ello. Para configurar el cliente, debe iniciar la recopilación para el suceso de dispositivo `NETWORK` y enviarla al servidor.

#### JavaScript
{: #javascript }

**Web**  
Para utilizar los sucesos de red, inicialice las analíticas:

```javascript
ibmmfpfanalytics.logger.config({analyticsCapture: true});
```

**Cordova**  
Para habilitar la captura de los sucesos de red, se debe inicializar en la plataforma nativa de la aplicación Cordova.

* Para la plataforma iOS:
	* Abra la carpeta **[Carpeta raíz aplicación Cordova] → plataformas → ios → Clases** y encuentre el archivo **AppDelegate.m** (Objective-C) o **AppDelegate.swift**.
	* Siga la guía de iOS más abajo para habilitar o inhabilitar las actividades de `NETWORK`.
	* Compile el proyecto Cordova ejecutando el mandato: `cordova build`.

* Para la plataforma Android: vaya a la subactividad de la actividad principal para inhabilitarla.
	* Abra el archivo **[carpeta raíz aplicación Cordova] → plataformas → ios → src → com → sample → [nombre-app] → MainActivity.java**.
	* Busque el método `onCreate` y siga la guía de Android más abajo para habilitar o inhabilitar las actividades de `NETWORK`.
	* Compile el proyecto Cordova ejecutando el mandato: `cordova build`.

#### iOS
{: #ios-network-activities }

Para habilitar el registro de sucesos de red del cliente:

**Objective-C:**

```objc
[[WLAnalytics sharedInstance] addDeviceEventListener:NETWORK];
```

**Swift:**

```swift
WLAnalytics.sharedInstance().addDeviceEventListener(NETWORK);
```

Para inhabilitar el registro de sucesos de red del cliente:

**Objective-C:**

```objc
[[WLAnalytics sharedInstance] removeDeviceEventListener:NETWORK];
```

**Swift:**

```swift
WLAnalytics.sharedInstance().removeDeviceEventListener(NETWORK);
```

#### Android
{: #android-network-activities }

Para habilitar el registro de sucesos de red del cliente:

```java
WLAnalytics.addDeviceEventListener(DeviceEvent.NETWORK);
```

Para inhabilitar el registro de sucesos de red del cliente:

```java
WLAnalytics.removeDeviceEventListener(DeviceEvent.NETWORK);
```

## Sucesos personalizados
{: #custom-events }

Utilice los siguientes métodos de API para crear sucesos personalizados.

#### JavaScript (Cordova)
{: #javascript-cordova-custom-events }

```javascript
WL.Analytics.log({"key" : 'value'});
```

#### JavaScript (Web)
{: #javascript-web-custom-events }

Para la API de web, los datos personalizados se envían con el método `addEvent`.

```javascript
ibmmfpfanalytics.addEvent({'Purchases':'radio'});
ibmmfpfanalytics.addEvent({'src':'App landing page','target':'About page'});
```

#### Android
{: #android-custom-events }

Después de establecer las dos primeras configuraciones, puede empezar a registrar datos tal como se ve este ejemplo:

```java
JSONObject json = new JSONObject();
try {
    json.put("key", "value");
} catch (JSONException e) {
    // TODO Auto-generated catch block
    e.printStackTrace();
}

WLAnalytics.log("Message", json);
```

#### iOS
{: #ios-custom-events }

Después de importar WLAnalytics, podrá utilizar la API para recopilar datos personalizados, tal como se muestra:

**Objective-C:**

```objc
NSDictionary *inventory = @{
    @"property" : @"value",
};

[[WLAnalytics sharedInstance] log:@"Custom event" withMetadata:inventory];
[[WLAnalytics sharedInstance] send];
```

**Swift:**

```swift
let metadata: [NSObject: AnyObject] = ["foo": "bar"];  
WLAnalytics.sharedInstance().log("hello", withMetadata: metadata);
```

## Seguimiento de usuarios
{: #tracking-users }

Para realizar el seguimiento de usuarios individuales, utilice el método `setUserContext`:

#### Cordova
{: #cordova-tracking-users }

No soportado.

#### Aplicaciones web
{: #web-applications }

```javascript
ibmmfpfanalytics.setUserContext(user);
```

#### iOS
{: #ios-tracking-users }

**Objective-C**

```objc
[[WLAnalytics sharedInstance] setUserContext:@"John Doe"];
```

**Swift**

```swift
WLAnalytics.sharedInstance().setUserContext("John Doe")
```

#### Android
{: #android-tracking-users }

```java
WLAnalytics.setUserContext("John Doe");
```

Para dejar el seguimiento de usuarios individuales, utilice el método `unsetUserContext`:

#### Cordova
{: #cordova-untracking-users }

No soportado.

#### Aplicaciones web
{: #web-applications-untracking-users }

No hay `unsetUserContext` en {{ site.data.keys.product_adj }} Web SDK. La sesión de usuario finaliza después de 30 minutos de inactividad, a no ser que se realice otra llamada a `ibmmfpfanalytics.setUserContext(user)`.

#### iOS
{: #ios-untracking-users }

**Objective-C**

```objc
[[WLAnalytics sharedInstance] unsetUserContext];
```

**Swift**

```swift
WLAnalytics.sharedInstance().unsetUserContext
```

#### Android
{: #android-untracking-users }

```java
WLAnalytics.unsetUserContext();
```

## Envío de datos de analíticas
{: #sending-analytics-data }

El envío de analíticas es un paso crucial para ver las analíticas del lado del cliente en el servidor de analíticas. Cuando se recopilan para las analíticas los datos de los tipos de suceso configurados, los registros de analíticas se almacenan en un archivo de registro en dispositivo del cliente. Los datos desde el archivo se envían a {{ site.data.keys.mf_analytics_server }} mediante el método `send` de la API de analíticas.

Considere la posibilidad de enviar los registros capturados periódicamente al servidor. El envío de datos en de forma periódica asegura que se verán datos analíticos actualizados en {{ site.data.keys.mf_analytics_console }}.

#### JavaScript (Cordova)
{: #javascript-cordova-sending-data }

En una aplicación Cordova, utilice el siguiente método de API de JavaScript:

```javascript
WL.Analytics.send();
```

#### JavaScript (Web)
{: #javascript-web-sending-data }

En una aplicación Web, utilice el siguiente método de API de JavaScript (dependiendo del espacio de nombres que haya seleccionado):

```javascript
ibmmfpfanalytics.send();
```

#### iOS
{: #ios-sending-data }

**Objective-C**

```objc
[[WLAnalytics sharedInstance] send];
```

**Swift**

```swift
WLAnalytics.sharedInstance().send();
```

#### Android
{: #android-sending-data }

En una aplicación Android, utilice el siguiente método de API de Java:

```java
WLAnalytics.send();
```
