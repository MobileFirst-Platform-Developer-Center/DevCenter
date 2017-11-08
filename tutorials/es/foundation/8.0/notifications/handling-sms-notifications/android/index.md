---
layout: tutorial
title: Manejo de notificaciones SMS en Android
breadcrumb_title: Manejo de SMS en Android
relevantTo: [android]
weight: 10
downloads:
  - name: Download Android project
    url: https://github.com/MobileFirst-Platform-Developer-Center/SMSNotificationsAndroid/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
Las notificaciones SMS son un subconjunto de las notificaciones push, y por lo tanto, primero [consulte las guías de aprendizaje de notificaciones push en Android](../../).


**Requisitos previos: **

* Asegúrese de haber leído las siguientes guías de aprendizaje:

  * [Visión general de las notificaciones](../../)
  * [Configuración del entorno de desarrollo de {{ site.data.keys.product_adj }}](../../../installation-configuration/#installing-a-development-environment)
  * [Adición de {{ site.data.keys.product }} SDK a aplicaciones iOS](../../../application-development/sdk/ios)
* {{ site.data.keys.mf_server }} para ejecutar localmente, o un remotamente ejecutando {{ site.data.keys.mf_server }}.
* {{ site.data.keys.mf_cli }} instalado en la estación de trabajo del desarrollador


#### Ir a: 
{: #jump-to }
* [API de notificaciones](#notifications-api)   
* [Utilización de un servlet de suscripción SMS](#using-an-sms-subscribe-servlet)     
* [Aplicación de ejemplo](#sample-application)

## API de notificaciones
{: #notifications-api }
En notificaciones SMS, al registrar el dispositivo, se pasa un valor de número de teléfono.


#### Manejadores de desafíos
{: #challenge-handlers }
Si el ámbito de `push.mobileclient` está correlacionado con la **comprobación de seguridad**, debe asegurarse de que existen **manejadores de desafíos** coincidentes registrados antes de utilizar las API de push.


#### Inicialización
{: #initialization }
Requerido para la aplicación de cliente para conectarse al servicio MFPPush con el contexto de aplicación correcto. 

* Primero se debe llamar al método de la API antes de utilizar cualquier otra API MFPPush.

* Registra la función de retorno de llamada para manejar las notificaciones push recibidas. 

```java
MFPPush.getInstance().initialize(this);
```

#### Registrar dispositivo
{: #register-device }
Registre el dispositivo para el servicio de notificaciones push. 

```java
MFPPush.getInstance().registerDevice(new MFPPushResponseListener<String>() {
    @Override
    public void onSuccess(String s) {
        // Successfully registered
    }

    @Override
    public void onFailure(MFPPushException e) {
        // Registration failed with error
    }
}, optionObject);
```

* **optionObject**: `JSONObject` que contiene el número de teléfono con el que registrar el dispositivo. Por ejemplo:

```java
JSONObject optionObject = new JSONObject();
try {
    // Obtain the inputted phone number.
    optionObject.put("phoneNumber", editPhoneText.getText().toString());
}
catch(Exception ex) {
    ex.printStackTrace();
}
```

> El dispositivo también se puede registrar utilizando la [API REST (POST) de registro de dispositivo de push](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_device_registration_post.html)
#### Anular el registro del dispositivo
{: #unregister-device }
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

## Utilización de un servlet de suscripción de SMS
{: #using-an-sms-subscribe-servlet }
Las API REST sirven para enviar notificaciones a dispositivos registrados.
Es posible enviar cualquier forma de notificación: notificaciones de difusión y etiqueta y notificaciones autenticadas


Para enviar una notificación, realice una solicitud mediante POST al punto final REST:
`imfpush/v1/apps/<application-identifier>/messages`.  
URL de ejemplo:
 

```bash
https://myserver.com:443/imfpush/v1/apps/com.sample.sms/messages
```

> Para revisar todas las API REST de notificaciones push, consulte el tema de los <a href="https://www.ibm.com/support/knowledgecenter/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/c_restapi_runtime.html">servicios de ejecución de API REST</a> en la documentación de usuario.
Para enviar una notificación, consulte la guía de aprendizaje de [envío de notificaciones](../../sending-notifications).


<img alt="Imagen de la aplicación de ejemplo" src="sample-app.png" style="float:right"/>
## Aplicación de ejemplo
{: #sample-application }
[Pulse para descargar](https://github.com/MobileFirst-Platform-Developer-Center/SMSNotificationsAndroid/tree/release80) el proyecto Android.


**Nota:** Se necesita instalada la última versión de Google Play Services en el dispositivo Android para poder ejecutar el ejemplo.


### Uso de ejemplo
{: #sample-usage }
Siga el archivo README.md de ejemplo para obtener instrucciones.

