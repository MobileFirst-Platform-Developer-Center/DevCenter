---
layout: tutorial
title: Implementación del manejador de desafíos en aplicaciones Windows 8.1 Universal y Windows 10 UWP
breadcrumb_title: Windows
relevantTo: [windows]
weight: 5
downloads:
  - name: Download RememberMe Win8 project
    url: https://github.com/MobileFirst-Platform-Developer-Center/RememberMeWin8/tree/release80
  - name: Download RememberMe Win10 project
    url: https://github.com/MobileFirst-Platform-Developer-Center/RememberMeWin10/tree/release80
  - name: Download PreemptiveLogin Win8 project
    url: https://github.com/MobileFirst-Platform-Developer-Center/PreemptiveLoginWin8/tree/release80
  - name: Download PreemptiveLogin Win10 project
    url: https://github.com/MobileFirst-Platform-Developer-Center/PreemptiveLoginWin10/tree/release80
  - name: Download SecurityCheck Maven project
    url: https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
**Requisitos previos:** Asegúrese de leer la guía de aprendizaje de la [implementación del manejador de desafíos](../../credentials-validation/windows-8-10) **CredentialsValidationSecurityCheck**.

La guía de aprendizaje del manejador de desafíos muestra algunas características adicionales (API) como las características `Login`, `Logout`, y `ObtainAccessToken` preferentes.

## Inicio de sesión
{: #login }
En este ejemplo, `UserLoginSecurityCheck` espera los *valores clave* llamados `username` y `password`. De forma opcional, también acepta una clave booleana `rememberMe`, que le pide a la comprobación de seguridad que recuerde el usuario durante más tiempo. En la aplicación de ejemplo, lo recopila un valor booleano del recuadro de selección en el formulario de inicio de sesión.

El argumento `credentials` es `JSONObject` que contiene los valores `username`, `password`, and `rememberMe`:

```csharp
public override void SubmitChallengeAnswer(object answer)
{
    challengeAnswer = (JObject)answer;
}
```

Es posible que desea iniciar sesión en un usuario sin recibir desafíos. Por ejemplo, puede mostrar una pantalla de inicio de sesión como la primera pantalla de la aplicación, una pantalla de inicio de sesión después de cerrar sesión, o un error de inicio de sesión. Dichos escenarios se denominan **inicios de sesión preferentes**.

No puede llamar la API `challengeAnswer` si no hay desafíos a los que responder. Para estos escenarios, el SDK de {{ site.data.keys.product }} incluye la API `Login`:

```csharp
WorklightResponse response = await Worklight.WorklightClient.CreateInstance().AuthorizationManager.Login(String securityCheckName, JObject credentials);
```

Si las credenciales no son correctas, la comprobación de seguridad devuelve un **desafío**.

Es responsabilidad del desarrollador saber cuando utilizar `Login`, en lugar de `challengeAnswer`, en función de las necesidades de la aplicación. Una forma de conseguirlo es definiendo un distintivo booleano, por ejemplo `isChallenged`, y establecerlo en `true` cuando se alcance `HandleChallenge`, o establecerlo en `false` en los otros casos (error, éxito, inicialización, etc).

Cuando el usuario pulsa el botón **Iniciar sesión**, puede elegir dinámicamente qué API desea utilizar:

```csharp
public async void login(JSONObject credentials)
{
    if(isChallenged)
    {
        challengeAnswer= credentials;
    }
    else
    {
        WorklightResponse response = await Worklight.WorklightClient.CreateInstance().AuthorizationManager.Login(securityCheckName, credentials);
    }
}
```
## Obtención de una señal de acceso
{: #obtaining-an-access-token }
Como esta comprobación de seguridad da soporte a la funcionalidad **RememberMe** (como la clave booleana `rememberMe`), sería de gran utilidad comprobar si el cliente tiene una sesión iniciada cuando se inicia la aplicación.

El SDK de {{ site.data.keys.product }} permite que la API `ObtainAccessToken` le pida al servidor una señal válida:

```csharp
WorklightAccessToken accessToken = await Worklight.WorklightClient.CreateInstance().AuthorizationManager.ObtainAccessToken(String scope);

if(accessToken.IsValidToken && accessToken.Value != null && accessToken.Value != "")
{
  Debug.WriteLine("Auto login success");
}
else
{
  Debug.WriteLine("Auto login failed");
}

```

Si el cliente ya ha iniciado sesión o está en estado *recordado*, la API da como resultado "éxito". Si el cliente no ha iniciado sesión, la comprobación de seguridad devuelve un desafío.

La API `ObtainAccessToken` incluye un **ámbito**. El ámbito puede ser el nombre de su **comprobación de seguridad**.

> Obtenga más información acerca los **ámbitos** en la guía de aprendizaje [Conceptos de autorización](../../).

## Recuperación del usuario autenticado
{: #retrieving-the-authenticated-user }
El método `HandleSuccess` del manejador de desafíos recibe `JObject identity` como parámetro.
Si la comprobación de seguridad establece `AuthenticatedUser`, el objeto contiene las propiedades del usuario. Puede utilizar `HandleSuccess` para guardar el usuario actual:

```csharp
public override void HandleSuccess(JObject identity)
{
    isChallenged = false;
    try
    {
        //Save the current user
        var localSettings = Windows.Storage.ApplicationData.Current.LocalSettings;
        localSettings.Values["useridentity"] = identity.GetValue("user");

    } catch (Exception e) {
        Debug.WriteLine(e.StackTrace);
    }
}
```

Aquí, `identity` tiene una clave denominada `user` que contiene el valor `JObject` que representa a `AuthenticatedUser`:

```json
{
  "user": {
    "id": "john",
    "displayName": "john",
    "authenticatedAt": 1455803338008,
    "authenticatedBy": "UserLogin"
  }
}
```

## Cierre de sesión
{: #logout }
El SDK de {{ site.data.keys.product }} también proporciona una API `Logout` para cerrar sesión de una comprobación de seguridad determinada:

```csharp
WorklightResponse response = await Worklight.WorklightClient.CreateInstance().AuthorizationManager.Logout(securityCheckName);
```

## Aplicaciones de ejemplo
{: #sample-applications }
Se asocian dos ejemplos a este tutorial:

- **PreemptiveLoginWin**: Una aplicación que siempre se inicia con una pantalla de inicio de sesión mediante la API `Login` preferente.
- **RememberMeWin**: Una aplicación con el recuadro de selección *Recuérdame*. El usuario podrá ignorar la pantalla de inicio de sesión la próxima vez que se abra la aplicación.

Los ejemplos utilizan la misma comprobación de seguridad `UserLoginSecurityCheck` del adaptador de **SecurityCheckAdapters** del proyecto Maven.

[Haga clic para descargar](https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80) el proyecto Maven de SecurityCheckAdapters.  
[Haga clic para descargar](https://github.com/MobileFirst-Platform-Developer-Center/RememberMeWin8/tree/release80) el proyecto recuérdame Win8.  
[Haga clic para descargar](https://github.com/MobileFirst-Platform-Developer-Center/RememberMeWin10/tree/release80) el proyecto recuérdame Win10.  
[Haga clic para descargar](https://github.com/MobileFirst-Platform-Developer-Center/PreemptiveLoginWin8/tree/release80) el proyecto PreemptiveLogin Win8.  
[Haga clic para descargar ](https://github.com/MobileFirst-Platform-Developer-Center/PreemptiveLoginWin10/tree/release80) el proyecto PreemptiveLoginWin10.

### Uso de ejemplo
{: #sample-usage }
Siga el archivo README.md del ejemplo para obtener instrucciones.
El nombre de usuario/contraseña de la aplicación debe coincidir, por ejemplo "john/john".

![aplicación de ejemplo](RememberMe.png)
