---
layout: tutorial
title: Manejo de las notificaciones push en Android
breadcrumb_title: Android
relevantTo: [android]
downloads:
  - name: Download Android Studio project
    url: https://github.com/MobileFirst-Platform-Developer-Center/PushNotificationsAndroid/tree/release80
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
Antes que las aplicaciones Android puedan manejar las notificaciones push que reciban, es necesario configurar el soporte para Google Play Services. Una vez se haya configurado la aplicación, se puede utilizar la API de notificaciones que {{ site.data.keys.product_adj }} proporciona con el propósito de registrar y anular el registro de dispositivos y suscribir y anular la suscripción a etiquetas. En esta guía de aprendizaje, aprenderá a manejar el envío de notificaciones en aplicaciones Android.

**Requisitos previos: **

* Asegúrese de haber leído las siguientes guías de aprendizaje:
    * [Configuración del entorno de desarrollo de {{ site.data.keys.product_adj }}](../../../installation-configuration/#installing-a-development-environment)
    * [Adición de {{ site.data.keys.product }} SDK a aplicaciones Android](../../../application-development/sdk/android)
    * [Visión general de notificaciones push](../../)
* {{ site.data.keys.mf_server }} para ejecutar localmente, o un remotamente ejecutando {{ site.data.keys.mf_server }}.
* {{ site.data.keys.mf_cli }} instalado en la estación de trabajo del desarrollador

#### Ir a:
{: #jump-to }
* [Configuración de notificaciones](#notifications-configuration)
* [API de notificaciones](#notifications-api)
* [Manejo de una notificación push](#handling-a-push-notification)
* [Aplicación de ejemplo](#sample-application)
* [Migración de las aplicaciones cliente en Android a FCM](#migrate-to-fcm)

## Configuración de notificaciones
{: #notifications-configuration }
Cree un nuevo proyecto de Android Studio o utilice uno que ya exista.  
Si {{ site.data.keys.product_adj }} Native Android SDK todavía no está presente en el proyecto, siga las instrucciones en la guía de aprendizaje [Adición de {{ site.data.keys.product }} SDK para aplicaciones Android](../../../application-development/sdk/android).

### Configurar el proyecto
{: #project-setup }
1. En **Android → Scripts de Gradle**, seleccione el archivo **build.gradle (Módulo: app)** y añada las siguientes líneas a `dependencies`:

   ```bash
   com.google.android.gms:play-services-gcm:9.0.2
   ```
   - **Nota:** hay un [defecto de Google conocido](https://code.google.com/p/android/issues/detail?id=212879) que impide el uso de la última versión de Play Services (actualmente la versión 9.2.0). Utilice una versión inferior.

   Y:

   ```xml
   compile group: 'com.ibm.mobile.foundation',
            name: 'ibmmobilefirstplatformfoundationpush',
            version: '8.0.+',
            ext: 'aar',
            transitive: true
   ```
    
   O en una sola línea:

   ```xml
   compile 'com.ibm.mobile.foundation:ibmmobilefirstplatformfoundationpush:8.0.+'
   ```

2. En **Android → app → manifiestos**, abra el archivo `AndroidManifest.xml`.
	* Añada los siguientes permisos en la parte superior de la etiqueta `manifest`:

	  ```xml
	  <!-- Permissions -->
      <uses-permission android:name="android.permission.WAKE_LOCK" />

      <!-- GCM Permissions -->
      <uses-permission android:name="com.google.android.c2dm.permission.RECEIVE" />
      <permission
    	    android:name="your.application.package.name.permission.C2D_MESSAGE"
    	    android:protectionLevel="signature" />
      ```
      
	* Añada lo siguiente a la etiqueta `application`:

	  ```xml
      <!-- GCM Receiver -->
      <receiver
            android:name="com.google.android.gms.gcm.GcmReceiver"
            android:exported="true"
            android:permission="com.google.android.c2dm.permission.SEND">
            <intent-filter>
                <action android:name="com.google.android.c2dm.intent.RECEIVE" />
                <category android:name="your.application.package.name" />
            </intent-filter>
      </receiver>

      <!-- MFPPush Intent Service -->
      <service
            android:name="com.ibm.mobilefirstplatform.clientsdk.android.push.api.MFPPushIntentService"
            android:exported="false">
            <intent-filter>
                <action android:name="com.google.android.c2dm.intent.RECEIVE" />
            </intent-filter>
      </service>

      <!-- MFPPush Instance ID Listener Service -->
      <service
            android:name="com.ibm.mobilefirstplatform.clientsdk.android.push.api.MFPPushInstanceIDListenerService"
            android:exported="false">
            <intent-filter>
                <action android:name="com.google.android.gms.iid.InstanceID" />
            </intent-filter>
      </service>
      
      <activity android:name="com.ibm.mobilefirstplatform.clientsdk.android.push.api.MFPPushNotificationHandler"
           android:theme="@android:style/Theme.NoDisplay"/>
	  ```

	  > **Nota:** Asegúrese de sustituir `your.application.package.name` con el nombre de paquete real de su aplicación.

    * Añada el siguiente `intent-filter` a la actividad de la aplicación.
      
      ```xml
      <intent-filter>
          <action android:name="your.application.package.name.IBMPushNotification" />
          <category android:name="android.intent.category.DEFAULT" />
      </intent-filter>
      ```
      
## API de notificaciones
{: #notifications-api }
### Instancia de MFPPush
{: #mfppush-instance }
Todas las llamadas de API se deben realizar en una instancia de `MFPPush`.  Esto se puede realizar creando un campo de nivel de clase como, por ejemplo, `private MFPPush push = MFPPush.getInstance();` y a continuación, llamando a `push.<api-call>` a través de la clase.

De forma alternativa puede llamar a `MFPPush.getInstance().<api_call>` para cada instancia en la que necesita acceder a los métodos de API de push.

### Manejadores de desafíos
{: #challenge-handlers }
Si el ámbito de `push.mobileclient` está correlacionado con la **comprobación de seguridad**, debe asegurarse de que existen **manejadores de desafíos** coincidentes registrados antes de utilizar las API de push.

> Aprenda más sobre los manejadores de desafíos en la guía de aprendizaje de [validación de credenciales](../../../authentication-and-security/credentials-validation/android).

### Lado del cliente
{: #client-side }

|Métodos Java |Descripción |
|-----------------------------------------------------------------------------------|-------------------------------------------------------------------------|
|[`initialize(Context context);`](#initialization) |Inicia MFPPush con el contexto proporcionado. |
|[`isPushSupported();`](#is-push-supported) |Indica si el dispositivo da soporte a notificaciones push. |
|[`registerDevice(JSONObject, MFPPushResponseListener);`](#register-device) |Registra el dispositivo con el servicio de notificaciones push. |
|[`getTags(MFPPushResponseListener)`](#get-tags) |Recupera las etiquetas disponibles en una instancia del servicio de notificaciones push. |
|[`subscribe(String[] tagNames, MFPPushResponseListener)`](#subscribe) |Suscribe el dispositivo para las etiquetas especificadas. |
|[`getSubscriptions(MFPPushResponseListener)`](#get-subscriptions) |Recupera todas las etiquetas a las que el dispositivo está actualmente suscrito. |
|[`unsubscribe(String[] tagNames, MFPPushResponseListener)`](#unsubscribe) |Anula la suscripción de una o varias etiquetas. |
|[`unregisterDevice(MFPPushResponseListener)`](#unregister) |Anula el registro del dispositivo del servicio notificaciones push. |

#### Inicialización
{: #initialization }
Requerido para la aplicación de cliente para conectarse al servicio MFPPush con el contexto de aplicación correcto.

* Primero se debe llamar al método de la API antes de utilizar cualquier otra API MFPPush.
* Registra la función de retorno de llamada para manejar las notificaciones push recibidas.

```java
MFPPush.getInstance().initialize(this);
```

#### Está push soportado
{: #is-push-supported }
Comprueba si el dispositivo da soporte a las notificaciones push.

```java
Boolean isSupported = MFPPush.getInstance().isPushSupported();

if (isSupported ) {
    // Push is supported
} else {
    // Push is not supported
}
```

#### Registrar el dispositivo
{: #register-device }
Registre el dispositivo para el servicio de notificaciones push.

```java
MFPPush.getInstance().registerDevice(null, new MFPPushResponseListener<String>() {
    @Override
    public void onSuccess(String s) {
        // Successfully registered
    }

    @Override
    public void onFailure(MFPPushException e) {
        // Registration failed with error
    }
});
```

#### Obtener etiquetas
{: #get-tags }
Recupere todas las etiquetas disponibles desde el servicio de notificaciones push.

```java
MFPPush.getInstance().getTags(new MFPPushResponseListener<List<String>>() {
    @Override
    public void onSuccess(List<String> strings) {
        // Successfully retrieved tags as list of strings
    }

    @Override
    public void onFailure(MFPPushException e) {
        // Failed to receive tags with error
    }
});
```

#### Suscribir
{: #subscribe }
Suscriba las etiquetas deseadas.

```java
String[] tags = {"Tag 1", "Tag 2"};

MFPPush.getInstance().subscribe(tags, new MFPPushResponseListener<String[]>() {
    @Override
    public void onSuccess(String[] strings) {
        // Subscribed successfully
    }

    @Override
    public void onFailure(MFPPushException e) {
        // Failed to subscribe
    }
});
```

#### Obtener suscripciones
{: #get-subscriptions }
Recupere las etiquetas a las que el dispositivo está actualmente suscrito.

```java
MFPPush.getInstance().getSubscriptions(new MFPPushResponseListener<List<String>>() {
    @Override
    public void onSuccess(List<String> strings) {
        // Successfully received subscriptions as list of strings
    }

    @Override
    public void onFailure(MFPPushException e) {
        // Failed to retrieve subscriptions with error
    }
});
```

#### Anular la suscripción
{: #unsubscribe }
Anule la suscripción de etiquetas.

```java
String[] tags = {"Tag 1", "Tag 2"};

MFPPush.getInstance().unsubscribe(tags, new MFPPushResponseListener<String[]>() {
    @Override
    public void onSuccess(String[] strings) {
        // Unsubscribed successfully
    }

    @Override
    public void onFailure(MFPPushException e) {
        // Failed to unsubscribe
    }
});
```

#### Anular el registro
{: #unregister }
Anule el registro del dispositivo de una instancia de servicio de notificaciones push.

```java
MFPPush.getInstance().unregisterDevice(new MFPPushResponseListener<String>() {
    @Override
    public void onSuccess(String s) {
        disableButtons();
        // Unregistered successfully
    }

    @Override
    public void onFailure(MFPPushException e) {
        // Failed to unregister
    }
});
```

## Manejar una notificación push
{: #handling-a-push-notification }
Con el propósito de manejar una notificación push será necesario configurar un `MFPPushNotificationListener`.  Esto se puede conseguir implementando uno de los métodos siguientes.

### Primera opción
{: #option-one }
En la actividad en que desea manejar las notificaciones push.

1. Añada `implements MFPPushNofiticationListener` a la declaración de la clase.
2. Establezca la clase para ser el escucha llamando a `MFPPush.getInstance().listen(this)` en el método `onCreate`.
2. Necesitará añadir el siguiente método *required*:

   ```java
   @Override
   public void onReceive(MFPSimplePushNotification mfpSimplePushNotification) {
        // Handle push notification here
   }
   ```

3. En este método recibirá `MFPSimplePushNotification` y podrá manejar la notificación para el comportamiento deseado.

### Segunda opción
{: #option-two }
Cree un escucha llamando a `listen(new MFPPushNofiticationListener())` en una instancia de `MFPPush` tal como se indica a continuación:

```java
MFPPush.getInstance().listen(new MFPPushNotificationListener() {
    @Override
    public void onReceive(MFPSimplePushNotification mfpSimplePushNotification) {
        // Handle push notification here
    }
});
```

<img alt="Imagen de la aplicación de ejemplo" src="notifications-app.png" style="float:right"/>

## Aplicación de ejemplo
{: #sample-application }

[
Pulse para descargar](https://github.com/MobileFirst-Platform-Developer-Center/PushNotificationsAndroid/tree/release80) el proyecto de Android Studio.

### Uso de ejemplo
{: #sample-usage }
Siga el archivo README.md de ejemplo para obtener instrucciones.

## Migración de las aplicaciones cliente en Android a FCM
{: #migrate-to-fcm }

Google Cloud Messaging (GCM) está [en desuso](https://developers.google.com/cloud-messaging/faq) y se ha integrado con Firebase Cloud Messaging (FCM). Google desactivará la mayoría de los servicios de GCM en abril de 2019.

Si utiliza un proyecto de GCM, [a continuación migre las aplicaciones cliente de GCM en Android a FCM](https://developers.google.com/cloud-messaging/android/android-migrate-fcm).

Por ahora, las aplicaciones existentes que utilizan servicios de GCM seguirán funcionando tal cual. Dado que el servicio de Notificaciones push se ha actualizado para utilizar los puntos finales de FCM, en el futuro todas las nuevas aplicaciones deben utilizar FCM.

**Nota**: Tras migrar a FCM, actualice el proyecto para utilizar credenciales de FCM en lugar de las credenciales antiguas de GCM.

### Configuración del proyecto de FCM

La configuración de una aplicación en FCM es algo distinta en comparación con el antiguo modelo de GCM. 

 1. Obtenga sus credenciales del proveedor de notificaciones, cree un proyecto de FCM y añada el mismo a la aplicación de Android. Incluya el nombre del paquete de la aplicación como `com.ibm.mobilefirstplatform.clientsdk.android.push`. Consulte la [documentación aquí](https://console.bluemix.net/docs/services/mobilepush/push_step_1.html#push_step_1_android), hasta el paso donde haya terminado de generar el archivo `google-services.json`

 2. Configure el archivo de Gradle. Añada lo siguiente en el archivo `build.gradle` de la aplicación 

    ```xml
    dependencies {
       ......
       compile 'com.google.firebase:firebase-messaging:10.2.6'
       .....

    }
    ```
	
    apply plugin: 'com.google.gms.google-services'
    
    - Añada la dependencia siguiente en el archivo `buildscript` -
    
    `classpath 'com.google.gms:google-services:3.0.0'`

 3. Configure el archivo AndroidManifest. Son necesarios los cambios siguientes en el `Android manifest.xml` 

**Elimine las entradas siguientes:**

```xml
    <receiver android:exported="true" android:name="com.google.android.gms.gcm.GcmReceiver" android:permission="com.google.android.c2dm.permission.SEND">
        <intent-filter>
            <action android:name="com.google.android.c2dm.intent.RECEIVE" />
            <category android:name="your.application.package.name" />
        </intent-filter>
        <intent-filter>
            <action android:name="com.google.android.c2dm.intent.REGISTRATION" />
            <category android:name="your.application.package.name" />
        </intent-filter>
    </receiver>  
	
    <service android:exported="false" android:name="com.ibm.mobilefirstplatform.clientsdk.android.push.api.MFPPushInstanceIDListenerService">
        <intent-filter>
            <action android:name="com.google.android.gms.iid.InstanceID" />
        </intent-filter>
    </service>

    <uses-permission android:name="your.application.package.name.permission.C2D_MESSAGE" />
    <uses-permission android:name="com.google.android.c2dm.permission.RECEIVE" />
```

**Las entradas siguientes necesitan modificarse:**

```xml
    <service android:exported="true" android:name="com.ibm.mobilefirstplatform.clientsdk.android.push.api.MFPPushIntentService">
        <intent-filter>
            <action android:name="com.google.android.c2dm.intent.RECEIVE" />
        </intent-filter>
    </service>
```

**Modifique las entradas a:**

```xml
    <service android:exported="true" android:name="com.ibm.mobilefirstplatform.clientsdk.android.push.api.MFPPushIntentService">
        <intent-filter>
            <action android:name="com.google.firebase.MESSAGING_EVENT" />
        </intent-filter>
    </service>
```

**Añada la entrada siguiente:**

```xml
    <service android:name="com.ibm.mobilefirstplatform.clientsdk.android.push.api.MFPPush"
            android:exported="true">
            <intent-filter>
                <action android:name="com.google.firebase.INSTANCE_ID_EVENT" />
            </intent-filter>
    </service>
```
	
 4. Abra la aplicación en Android Studio. Copie el archivo `google-services.json` que ha creado en el **step-1** dentro del directorio de aplicación. Tenga en cuenta que el archivo `google-service.json` incluye el nombre del paquete que ha añadido.		
		
 5. Compile el SDK. Cree la aplicación.




