---
layout: tutorial
title: Implementación del manejador de desafíos en aplicaciones JavaScript (Cordova, Web)
breadcrumb_title: JavaScript
relevantTo: [javascript]
weight: 2
downloads:
  - name: Download PreemptiveLogin Cordova project
    url: https://github.com/MobileFirst-Platform-Developer-Center/PreemptiveLoginCordova/tree/release80
  - name: Download PreemptiveLogin Web project
    url: https://github.com/MobileFirst-Platform-Developer-Center/PreemptiveLoginWeb/tree/release80
  - name: Download RememberMe Cordova project
    url: https://github.com/MobileFirst-Platform-Developer-Center/RememberMeCordova/tree/release80
  - name: Download RememberMe Web project
    url: https://github.com/MobileFirst-Platform-Developer-Center/RememberMeWeb/tree/release80
  - name: Download SecurityCheck Maven project
    url: https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
**Requisitos previos:** Asegúrese de leer la guía de aprendizaje de la [implementación del manejador de desafíos](../../credentials-validation/javascript) de **CredentialsValidationSecurityCheck**.

El manejador de desafíos mostrará características adicionales (API) como, por ejemplo, las características `login`, `logout` y `obtainAccessToken` preferentes.

## Inicio de sesión
{: #login }
En este ejemplo, `UserLogin` espera los *valores clave* llamados `username` y `password`. De forma opcional, también acepta una clave booleana `rememberMe`, que le pide a la comprobación de seguridad que recuerde el usuario durante más tiempo. En la aplicación de ejemplo, lo recopila un valor booleano del recuadro de selección en el formulario de inicio de sesión.

```js
userLoginChallengeHandler.submitChallengeAnswer({'username':username, 'password':password, rememberMe: rememberMeState});
```

Es posible que desee iniciar sesión en un usuario sin recibir desafíos. Por ejemplo, mostrar una pantalla de inicio de sesión como la primera pantalla de la aplicación, una pantalla de inicio de sesión después de cerrar sesión, o un error de inicio de sesión. Denominamos a dichos escenarios **inicios de sesión preferentes**.

No puede llamar la API `submitChallengeAnswer` si no hay desafíos a los que responder. Para estos escenarios, el SDK de {{ site.data.keys.product }} incluye la API `login`:

```js
WLAuthorizationManager.login(securityCheckName,{'username':username, 'password':password, rememberMe: rememberMeState}).then(
    function () {
        WL.Logger.debug("login onSuccess");
    },
    function (response) {
        WL.Logger.debug("login onFailure: " + JSON.stringify(response));
    });
```

Si las credenciales no son correctas, la comprobación de seguridad devuelve un **desafío**.

Es responsabilidad del desarrollador saber cuando utilizar `login`, en lugar de `submitChallengeAnswer`, en función de las necesidades de la aplicación. Una forma de conseguirlo es definiendo un distintivo booleano, por ejemplo `isChallenged`, y establecerlo en `true` cuando se alcance `handleChallenge`, o establecerlo en `false` en los otros casos (error, éxito, inicialización, etc).

Cuando el usuario pulsa el botón **Iniciar sesión**, puede elegir dinámicamente qué API desea utilizar:

```js
if (isChallenged){
    userLoginChallengeHandler.submitChallengeAnswer({'username':username, 'password':password, rememberMe: rememberMeState});
} else {
    WLAuthorizationManager.login(securityCheckName,{'username':username, 'password':password, rememberMe: rememberMeState}).then(
//...
    );
}
```

> **Nota:**
>La API `WLAuthorizationManager` `login()` tiene sus propios métodos `onSuccess` y `onFailure`; **también** se llama a los manejadores de desafíos `handleSuccess` o `handleFailure` del manejador de desafíos relevante.

## Obtención de una señal de acceso
{: #obtaining-an-access-token }
Como esta comprobación de seguridad da soporte a la funcionalidad **RememberMe** (como la clave booleana `rememberMe`), sería de gran utilidad comprobar si el cliente tiene una sesión iniciada cuando se inicia la aplicación.

El SDK de {{ site.data.keys.product }} permite que la API `obtainAccessToken` le pida al servidor una señal válida:

```js
WLAuthorizationManager.obtainAccessToken(userLoginChallengeHandler.securityCheckName).then(
    function (accessToken) {
        WL.Logger.debug("obtainAccessToken onSuccess");
        showProtectedDiv();
    },
    function (response) {
        WL.Logger.debug("obtainAccessToken onFailure: " + JSON.stringify(response));
        showLoginDiv();
});
```
> **Nota:**
> La API `WLAuthorizationManager` `obtainAccessToken()` tiene sus propios métodos `onSuccess` y `onFailure`; **también** se llama a los manejadores de desafíos `handleSuccess` o `handleFailure` del manejador de desafíos relevante.

Si el cliente ya ha iniciado sesión o está en estado *recordado*, la API da como resultado "éxito". Si el cliente no ha iniciado sesión, la comprobación de seguridad devuelve un desafío.

La API `obtainAccessToken` incluye un **ámbito**. El ámbito puede ser el nombre de su **comprobación de seguridad**.

> Obtenga más información acerca los **ámbitos** en la guía de aprendizaje [Conceptos de autorización](../../).

## Recuperación del usuario autenticado
{: #retrieving-the-authenticated-user }
El método `handleSuccess` del manejador de desafíos recibe `data` como parámetro.
Si la comprobación de seguridad establece `AuthenticatedUser`, el objeto contiene las propiedades del usuario. Puede utilizar `handleSuccess` para guardar el usuario actual:

```js
userLoginChallengeHandler.handleSuccess = function(data) {
    WL.Logger.debug("handleSuccess");
    isChallenged = false;
    document.getElementById ("rememberMe").checked = false;
    document.getElementById('username').value = "";
    document.getElementById('password').value = "";
    document.getElementById("helloUser").innerHTML = "Hello, " + data.user.displayName;
    showProtectedDiv();
}
```

Aquí, `data` tiene una clave denominada `user` que contiene `JSONObject` que representa a `AuthenticatedUser`:

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
El SDK de {{ site.data.keys.product }} también proporciona una API `logout` para cerrar sesión de una comprobación de seguridad determinada:

```js
WLAuthorizationManager.logout(securityCheckName).then(
    function () {
        WL.Logger.debug("logout onSuccess");
        location.reload();
    },
    function (response) {
        WL.Logger.debug("logout onFailure: " + JSON.stringify(response));
    });
```

## Aplicaciones de ejemplo
{: #sample-applications }
Se asocian dos ejemplos a este tutorial:

- **PreemptiveLogin**: Una aplicación que siempre se inicia con una pantalla de inicio de sesión mediante la API `login` preferente.
- **RememberMe**: Una aplicación con recuadro de selección *Recuérdame*. El usuario podrá ignorar la pantalla de inicio de sesión la próxima vez que se abra la aplicación.

Los ejemplos utilizan la misma comprobación de seguridad `UserLogin` del adaptador de **SecurityCheckAdapters** del proyecto Maven.

- [Haga clic para descargar](https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80) el proyecto Maven de SecurityCheckAdapters.  
- [Haga clic para descargar](https://github.com/MobileFirst-Platform-Developer-Center/RememberMeCordova/tree/release80) el proyecto Cordova RememberMe.  
- [Haga clic para descargar](https://github.com/MobileFirst-Platform-Developer-Center/PreemptiveLoginCordova/tree/release80) el proyecto Cordova PreemptiveLogin.
- [Haga clic para descargar](https://github.com/MobileFirst-Platform-Developer-Center/RememberMeWeb/tree/release80) el proyecto Web RememberMe.
- [Haga clic para descargar](https://github.com/MobileFirst-Platform-Developer-Center/PreemptiveLoginWeb/tree/release80) el proyecto Web PreemptiveLogin.

### Uso de ejemplo
{: #sample-usage }
Siga el archivo README.md del ejemplo para obtener instrucciones.
El nombre de usuario/contraseña de la aplicación debe coincidir, por ejemplo "john/john".

![aplicación de ejemplo](sample-application.png)
