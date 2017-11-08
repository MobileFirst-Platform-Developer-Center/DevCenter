---
layout: tutorial
title: Implementación del manejador de desafíos en las aplicaciones Windows 8.1 Universal y Windows 10 UWP
breadcrumb_title: Windows
relevantTo: [windows]
weight: 5
downloads:
  - name: Download Win8 project
    url: https://github.com/MobileFirst-Platform-Developer-Center/PinCodeWin8/tree/release80
  - name: Download Win10 project
    url: https://github.com/MobileFirst-Platform-Developer-Center/PinCodeWin10/tree/release80
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

En este ejemplo, la comprobación de seguridad es `PinCodeAttempts` que se definió en [Implementación de CredentialsValidationSecurityCheck](../security-check). El desafío que ha enviado la comprobación de seguridad contiene el número de intentos restantes para iniciar sesión (`remainingAttempts`), y un `errorMsg` opcional.

Cree una clase C# que amplíe `Worklight.SecurityCheckChallengeHandler`:

```csharp
public class PinCodeChallengeHandler : Worklight.SecurityCheckChallengeHandler
{
}
```

## Manejo de un desafío
{: #handling-the-challenge }
El requisito mínimo de la clase `SecurityCheckChallengeHandler` es implementar un constructor y un método `HandleChallenge`, que es el responsable de solicitar al usuario las credenciales. El método `HandleChallenge` recibe el desafío como un `Object`.

Añadir un método constructor:

```csharp
public PinCodeChallengeHandler(String securityCheck) {
    this.securityCheck = securityCheck;
}
```

En este ejemplo de `HandleChallenge`, una alerta le solicita al usuario que introduzca el código PIN: 

```csharp
public override void HandleChallenge(Object challenge)
{
    try
    {
      JObject challengeJSON = (JObject)challenge;

      if (challengeJSON.GetValue("errorMsg") != null)
      {
          if (challengeJSON.GetValue("errorMsg").Type == JTokenType.Null)
              errorMsg = "This data requires a PIN Code.\n";
      }

      await CoreApplication.MainView.CoreWindow.Dispatcher.RunAsync(CoreDispatcherPriority.Normal,
           async () =>
           {
               _this.HintText.Text = "";
               _this.LoginGrid.Visibility = Visibility.Visible;
               if (errorMsg != "")
               {
                   _this.HintText.Text = errorMsg + "Remaining attempts: " + challengeJSON.GetValue("remainingAttempts");
               }
               else
               {
                   _this.HintText.Text = challengeJSON.GetValue("errorMsg") + "\n" + "Remaining attempts: " + challengeJSON.GetValue("remainingAttempts");
               }

               _this.GetBalance.IsEnabled = false;
           });
    } catch (Exception e)
    {
        Debug.WriteLine(e.StackTrace);
    }
}
```

> La implementación de `showChallenge` se incluye en la aplicación de ejemplo.

Si las credenciales son incorrectas, puede esperar que la infraestructura llame a `HandleChallenge` de nuevo.

## Envío de la respuesta de comprobación
{: #submitting-the-challenges-answer }
Cuando haya recopilado las credenciales de la IU, utilice los métodos `ShouldSubmitChallengeAnswer()` y `GetChallengeAnswer()` de `SecurityCheckChallengeHandler` para enviar una respuesta a la comprobación de seguridad. `ShouldSubmitChallengeAnswer()` devuelve un valor booleano que indica si la respuesta de verificación de identidad debería enviarse a la comprobación de seguridad.En este ejemplo, `PinCodeAttempts` espera una propiedad denominada `pin` que contiene el código PIN enviado:

```csharp
public override bool ShouldSubmitChallengeAnswer()
{
  JObject pinJSON = new JObject();
  pinJSON.Add("pin", pinCodeTxt.Text);
  this.challengeAnswer = pinJSON;
  return this.shouldsubmitchallenge;
}

public override JObject GetChallengeAnswer()
{
  return this.challengeAnswer;
}

```

## Cancelación del desafío
{: #cancelling-the-challenge }
En algunos casos, como cuando se pulsa el botón **Cancelar** en la IU, desea indicarle a la infraestructura que descarte este desafío por completo.

Para ello, sustituya el método `ShouldCancel`.


```csharp
public override bool ShouldCancel()
{
  return shouldsubmitcancel;
}
```

## Registro del manejador de desafíos
{: #registering-the-challenge-handler }
Para que el manejador de desafíos escuche los desafíos adecuados, debe pedirle a la infraestructura que se asocie con el manejador de desafíos con un nombre de comprobación de seguridad específico.

Para ello, inicialice el manejador de desafíos con la comprobación de seguridad de la siguiente manera:

```csharp
PinCodeChallengeHandler pinCodeChallengeHandler = new PinCodeChallengeHandler("PinCodeAttempts");
```

A continuación, debe **registrar** la instancia del manejador de desafíos:

```csharp
IWorklightClient client = WorklightClient.createInstance();
client.RegisterChallengeHandler(pinCodeChallengeHandler);
```

## Aplicación de ejemplo
{: #sample-application }
Los ejemplos **PinCodeWin8** y **PinCodeWin10** son aplicaciones C# que utilizan `ResourceRequest` para obtener un saldo de banco.  
El método está protegido con un código PIN y un máximo de 3 intentos.

[Haga clic para descargar](https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80) el proyecto Maven de SecurityCheckAdapters.  
[Haga clic para descargar](https://github.com/MobileFirst-Platform-Developer-Center/PinCodeWin8/tree/release80) el proyecto de Windows 8.  
[Haga clic para descargar](https://github.com/MobileFirst-Platform-Developer-Center/PinCodeWin10/tree/release80) el proyecto Windows 10 UWP.

### Uso de ejemplo
{: #sample-usage }
Siga el archivo README.md del ejemplo para obtener instrucciones.

![Aplicación de ejemplo](sample-application.png)   
