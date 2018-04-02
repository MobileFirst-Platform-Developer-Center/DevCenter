---
layout: tutorial
title: Implementación del manejador de desafíos en aplicaciones Android
breadcrumb_title: Android
relevantTo: [android]
weight: 4
downloads:
  - name: Download Android Studio project
    url: https://github.com/MobileFirst-Platform-Developer-Center/PinCodeAndroid/tree/release80
  - name: Download SecurityCheck Maven project
    url: https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
Al intentar acceder al recurso protegido, el servidor (la comprobación de seguridad) devuelve al cliente una lista que contiene uno o más **desafíos** que debe gestionar el cliente.  
Esta lista se recibe como un objeto `JSON`, listando el nombre de la comprobación de seguridad con un `JSON` opcional de datos adicionales:

```json
{
  "challenges": {
    "SomeSecurityCheck1":null,
    "SomeSecurityCheck2":{
      "some property": "some value"
    }
  }
}
```

A continuación, el cliente debe registrar un **manejador de desafíos** para cada comprobación de seguridad.  
El manejador de desafíos define el comportamiento del lado de cliente que es específico de la comprobación de seguridad.

## Creación del manejador de desafíos
{: #creating-the-challenge-handler }
Un manejador de desafíos es una clase que maneja desafíos enviados por {{ site.data.keys.mf_server }} como, por ejemplo, la visualización de una pantalla de inicio de sesión, la recopilación de credenciales y la devolución a la comprobación de seguridad.

En este ejemplo, la comprobación de seguridad es `PinCodeAttempts` que se definió en [Implementación de CredentialsValidationSecurityCheck](../security-check). El desafío que ha enviado la comprobación de seguridad contiene el número de intentos restantes para iniciar sesión (`remainingAttempts`) y un `errorMsg` opcional.

Cree una clase Java que amplíe `SecurityCheckChallengeHandler`:

```java
public class PinCodeChallengeHandler extends SecurityCheckChallengeHandler {

}
```

## Manejo de un desafío
{: #handling-the-challenge }
El requisito mínimo del protocolo `SecurityCheckChallengeHandler` es implementar un constructor y un método `handleChallenge` que le solicite al usuario las credenciales. El método `handleChallenge` recibe el desafío como un `JSONObject`.

Añadir un método constructor:

```java
public PinCodeChallengeHandler(String securityCheck) {
    super(securityCheck);
}
```

En este ejemplo de `handleChallenge`, una alerta le solicita al usuario que introduzca el código PIN:

```java
@Override
public void handleChallenge(JSONObject jsonObject) {
    Log.d("Handle Challenge", jsonObject.toString());
    Log.d("Failure", jsonObject.toString());
    Intent intent = new Intent();
    intent.setAction(Constants.ACTION_ALERT_MSG);
    try{
        if (jsonObject.isNull("errorMsg")){
            intent.putExtra("msg", "This data requires a PIN code.\n Remaining attempts: " + jsonObject.getString("remainingAttempts"));
            broadcastManager.sendBroadcast(intent);
        } else {
            intent.putExtra("msg", jsonObject.getString("errorMsg") + "\nRemaining attempts: " + jsonObject.getString("remainingAttempts"));
            broadcastManager.sendBroadcast(intent);
        }
    } catch (JSONException e) {
        e.printStackTrace();
    }
}

```

> La implementación de `alertMsg` se incluye en la aplicación de muestra.

Si las credenciales son incorrectas, puede esperar que la infraestructura llame a `handleChallenge` de nuevo.

## Envío de la respuesta de comprobación
{: #submitting-the-challenges-answer }
Cuando se hayan recopilado las credenciales de la IU, utilice el método `submitChallengeAnswer(respuesta JSONObject)` de `SecurityCheckChallengeHandler` para devolver una respuesta a la comprobación de seguridad. En este ejemplo, `PinCodeAttempts` espera una propiedad denominada `pin` que contiene el código PIN enviado:

```java
submitChallengeAnswer(new JSONObject().put("pin", pinCodeTxt.getText()));
```

## Cancelación del desafío
{: #cancelling-the-challenge }
En algunos casos, como cuando se pulsa el botón **Cancelar** en la IU, desea indicarle a la infraestructura que descarte este desafío por completo.

Para ello, utilice el método `cancel()` de `SecurityCheckChallengeHandler`.

## Manejo de errores
{: #handling-failures }
Es posible que en algunos escenarios se produzca un error (por ejemplo, el número de intentos máximos alcanzado). Para manejar esta situación, implemente el método `handleFailure` de `SecurityCheckChallengeHandler`.  
La estructura de `JSONObject` pasada como parámetro depende en gran parte de la naturaleza del error.

```java
@Override
public void handleFailure(JSONObject jsonObject) {
    Log.d("Failure", jsonObject.toString());
    Intent intent = new Intent();
    intent.setAction(Constants.ACTION_ALERT_ERROR);
    try {
        if (!jsonObject.isNull("failure")) {
            intent.putExtra("errorMsg", jsonObject.getString("failure"));
            broadcastManager.sendBroadcast(intent);
        } else {
            intent.putExtra("errorMsg", "Unknown error");
            broadcastManager.sendBroadcast(intent);
        }
    } catch (JSONException e) {
        e.printStackTrace();
    }
}
```

> La implementación de `alertError` se incluye en la aplicación de muestra.

## Manejador de logros
{: #handling-successes }
En general, la infraestructura procesa los logros de forma automática para permitir que el resto de la aplicación continúe.

De forma opcional, también puede elegir realizar otras tareas antes de que la infraestructura cierre el flujo de manejador de desafíos, implementando el método `handleSuccess` de `SecurityCheckChallengeHandler`. Una vez más, el contenido y la estructura de `JSONObject` pasados como parámetro dependen de lo que envíe la comprobación de seguridad.

En la aplicación de muestra `PinCodeAttempts`, `JSONObject` no contiene datos adicionales y, por lo tanto, no se implementa `handleSuccess`.

## Registro del manejador de desafíos
{: #registering-the-challenge-handler }
Para que el manejador de desafíos escuche los desafíos adecuados, debe pedirle a la infraestructura que se asocie con el manejador de desafíos con un nombre de comprobación de seguridad específico.

Para ello, inicialice el manejador de desafíos con la comprobación de seguridad de la siguiente manera:

```java
PinCodeChallengeHandler pinCodeChallengeHandler = new PinCodeChallengeHandler("PinCodeAttempts", this);
```

A continuación, debe **registrar** la instancia del manejador de desafíos:

```java
WLClient client = WLClient.createInstance(this);
client.registerChallengeHandler(pinCodeChallengeHandler);
```

**Nota:** Solo debería crear una instancia de `WLClient` y registrar el manejador de desafíos una vez en todo el ciclo de vida de aplicación. Se recomienda utilizar la clase de la aplicación Android para hacerlo.

## Aplicación de ejemplo
{: #sample-application }
El ejemplo **PinCodeAndroid** es una aplicación Android que utiliza `WLResourceRequest` para obtener un saldo de banco.  
El método está protegido con un código PIN y un máximo de 3 intentos.

[Haga clic para descarga](https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80) el proyecto Maven SecurityAdapters.  
[Haga clic para descargar](https://github.com/MobileFirst-Platform-Developer-Center/PinCodeAndroid/tree/release80) el proyecto Android.

### Uso de ejemplo
{: #sample-usage }
Siga el archivo README.md del ejemplo para obtener instrucciones.

![Aplicación de ejemplo](sample-application-android.png)
