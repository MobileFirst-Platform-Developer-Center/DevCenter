---
layout: tutorial
title: Implementación del manejador de desafíos en aplicaciones de JavaScript (Cordova, Web)
breadcrumb_title: JavaScript
relevantTo: [javascript]
weight: 2
downloads:
  - name: Download Web project
    url: https://github.com/MobileFirst-Platform-Developer-Center/PinCodeWeb/tree/release80
  - name: Download Cordova project
    url: https://github.com/MobileFirst-Platform-Developer-Center/PinCodeCordova/tree/release80
  - name: Download SecurityCheck Maven project
    url: https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
Al intentar acceder al recurso protegido, el servidor (la comprobación de seguridad) devolverá al cliente una lista con uno o más **desafíos** que debe gestionar el cliente.  
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
{: creating-the-challenge-handler }
Un manejador de desafíos maneja desafíos enviados por {{ site.data.keys.mf_server }} como, por ejemplo, la visualización de una pantalla de inicio de sesión, la recopilación de credenciales y la devolución a la comprobación de seguridad.

En este ejemplo, la comprobación de seguridad es `PinCodeAttempts` que se definió en [Implementación de CredentialsValidationSecurityCheck](../security-check). El desafío que ha enviado la comprobación de seguridad contiene el número de intentos restantes para iniciar sesión (`remainingAttempts`), y un `errorMsg` opcional.


Utilice el método API `WL.Client.createSecurityCheckChallengeHandler()` para crear y registrar un manejador de desafíos:

```javascript
PinCodeChallengeHandler = WL.Client.createSecurityCheckChallengeHandler("PinCodeAttempts");
```

## Manejo de un desafío
{: #handling-the-challenge }
El requisito mínimo del protocolo `createSecurityCheckChallengeHandler` es implementar el método `handleChallenge()` que es el responsable de solicitar al usuario las credenciales. El método `handleChallenge` recibe el desafío como un objeto `JSON`.

En este ejemplo, una alerta le solicita al usuario que introduzca el código PIN: 

```javascript
PinCodeChallengeHandler.handleChallenge = function(challenge) {
    var msg = "";

    // Create the title string for the prompt
    if(challenge.errorMsg != null) {
        msg =  challenge.errorMsg + "\n";
    } else {
        msg = "This data requires a PIN code.\n";
    }

    msg += "Remaining attempts: " + challenge.remainingAttempts;

    // Display a prompt for user to enter the pin code     
    var pinCode = prompt(msg, "");

    if(pinCode){ // calling submitChallengeAnswer with the entered value
        PinCodeChallengeHandler.submitChallengeAnswer({"pin":pinCode});
    } else { // calling cancel in case user pressed the cancel button
        PinCodeChallengeHandler.cancel();   
    }                            
};
```

Si las credenciales son incorrectas, puede esperar que la infraestructura llame a `handleChallenge` de nuevo.

## Envío de la respuesta de comprobación
{: #submitting-the-challenges-answer }
Cuando se hayan recopilado las credenciales de la IU, utilice el `submitChallengeAnswer()` de `createSecurityCheckChallengeHandler` para devolver una respuesta a la comprobación de seguridad. En este ejemplo, `PinCodeAttempts` espera una propiedad denominada `pin` que contiene el código PIN enviado:

```javascript
PinCodeChallengeHandler.submitChallengeAnswer({"pin":pinCode});
```

## Cancelación del desafío
{: #cancelling-the-challenge }
En algunos casos, como cuando se pulsa el botón **Cancelar** en la IU, desea indicarle a la infraestructura que descarte este desafío por completo.  
Para ello, llame: 

```javascript
PinCodeChallengeHandler.cancel();
```

## Manejo de errores
{: #handling-failures }
Es posible que en algunos escenarios se produzca un error (por ejemplo, el número de intentos máximos alcanzado). Para manejar esta situación, implemente el `handleFailure()` de `createSecurityCheckChallengeHandler`.  
La estructura del objeto JSON pasada como parámetro depende de la naturaleza del error. 

```javascript
PinCodeChallengeHandler.handleFailure = function(error) {
    WL.Logger.debug("Challenge Handler Failure!");

    if(error.failure && error.failure == "account blocked") {
        alert("No Remaining Attempts!");  
    } else {
        alert("Error! " + JSON.stringify(error));
    }
};
```

## Manejador de logros
{: #handling-successes }
En general, la infraestructura procesa los logros de forma automática para permitir que el resto de la aplicación continúe.

De forma opcional, también puede elegir realizar otras tareas antes de que la infraestructura cierre el flujo del manejador de desafíos, implementando el `handleSuccess()` de `createSecurityCheckChallengeHandler`. Una vez más, el contenido y estructura del objeto JSON `success` depende de lo que envíe la comprobación de seguridad.

En la aplicación de ejemplo `PinCodeAttemptsCordova`, el valor éxito no contiene datos adicionales. 

## Registro del manejador de desafíos
{: #registering-the-challenge-handler }
Para que el manejador de desafíos escuche los desafíos adecuados, debe pedirle a la infraestructura que se asocie con el manejador de desafíos con un nombre de comprobación de seguridad específico.  
Para ello, cree el manejador de desafíos con la comprobación de seguridad de la siguiente manera:

```javascript
someChallengeHandler = WL.Client.createSecurityCheckChallengeHandler("the-securityCheck-name");
```

## Aplicaciones de ejemplo
{: #sample-applications }
Los proyectos **PinCodeWeb** y **PinCodeCordova** utilizan `WLResourceRequest` para obtener un saldo de banco.   
El método está protegido con un código PIN y un máximo de 3 intentos.

[Haga clic para descargar](https://github.com/MobileFirst-Platform-Developer-Center/PinCodeWeb/tree/release80) el proyecto web.  
[Haga clic para descargar](https://github.com/MobileFirst-Platform-Developer-Center/PinCodeCordova/tree/release80) el proyecto Cordova.  
[Haga clic para descarga](https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80) el proyecto Maven SecurityAdapters.  

### Uso de ejemplo
{: #sample-usage }
Siga el archivo README.md del ejemplo para obtener instrucciones.

![Aplicación de ejemplo](pincode-attempts-cordova.png)
