---
layout: tutorial
title: Implementación del manejador de desafíos en aplicaciones Android
breadcrumb_title: Android
relevantTo: [android]
weight: 4
downloads:
  - name: Download PreemptiveLogin project
    url: https://github.com/MobileFirst-Platform-Developer-Center/PreemptiveLoginAndroid/tree/release80
  - name: Download RememberMe project
    url: https://github.com/MobileFirst-Platform-Developer-Center/RememberMeAndroid/tree/release80
  - name: Download SecurityCheck Maven project
    url: https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
**Requisitos previos:** Asegúrese de leer la guía de aprendizaje de la [implementación de manejador de desafíos](../../credentials-validation/android) de **CredentialsValidationSecurityCheck**.

La guía de aprendizaje del manejador de desafíos muestra características adicionales (API) como, por ejemplo, las características `login`, `logout`, y `obtainAccessToken` preferentes.

## Inicio de sesión
{: #login }
En este ejemplo, `UserLogin` espera los *valores clave* llamados `username` y `password`. De forma opcional, también acepta una clave booleana `rememberMe`, que le pide a la comprobación de seguridad que recuerde el usuario durante más tiempo.En la aplicación de ejemplo, lo recopila un valor booleano del recuadro de selección en el formulario de inicio de sesión.

El argumento `credentials` es `JSONObject` que contiene los valores `username`, `password`, and `rememberMe`:

```java
submitChallengeAnswer(credentials);
```

Es posible que desee iniciar sesión en un usuario sin recibir desafíos. Por ejemplo, puede mostrar una pantalla de inicio de sesión como la primera pantalla de la aplicación, una pantalla de inicio de sesión después de cerrar sesión, o un error de inicio de sesión.Dichos escenarios se denominan **inicios de sesión preferentes**.

No puede llamar la API `submitChallengeAnswer` si no hay desafíos a los que responder. Para estos escenarios, el SDK de {{ site.data.keys.product }} incluye la API `login`:

```java
WLAuthorizationManager.getInstance().login(securityCheckName, credentials, new WLLoginResponseListener() {
    @Override
    public void onSuccess() {
        Log.d(securityCheckName, "Login Preemptive Success");

    }

    @Override
    public void onFailure(WLFailResponse wlFailResponse) {
        Log.d(securityCheckName, "Login Preemptive Failure");
    }
});
```

Si las credenciales no son correctas, la comprobación de seguridad devuelve un **desafío**.

Es responsabilidad del desarrollador saber cuando utilizar `login`, en lugar de `submitChallengeAnswer`, en función de las necesidades de la aplicación. Una forma de conseguirlo es definiendo un distintivo booleano, por ejemplo `isChallenged`, y establecerlo en `true` cuando se alcance `handleChallenge`, o establecerlo en `false` en los otros casos (error, éxito, inicialización, etc). 

Cuando el usuario pulsa el botón **Iniciar sesión**, puede elegir dinámicamente qué API desea utilizar:

```java
public void login(JSONObject credentials){
    if(isChallenged){
        submitChallengeAnswer(credentials);
    }
    else{
        WLAuthorizationManager.getInstance().login(securityCheckName, credentials, new WLLoginResponseListener() {
//...
        });
    }
}
```

> **Nota:**
>La API `WLAuthorizationManager` `login()` tiene sus propios métodos `onSuccess` y `onFailure`; **también** se llama a los manejadores de desafíos `handleSuccess` o `handleFailure` del manejador de desafíos relevante.

## Obtención de una señal de acceso
{: #obtaining-an-access-token }
Como esta comprobación de seguridad da soporte a la funcionalidad **RememberMe** (como la clave booleana `rememberMe`), sería de gran utilidad comprobar si el cliente tiene una sesión iniciada cuando se inicia la aplicación.

El SDK de {{ site.data.keys.product }} permite que la API `obtainAccessToken` le pida al servidor una señal válida:

```java
WLAuthorizationManager.getInstance().obtainAccessToken(scope, new WLAccessTokenListener() {
    @Override
    public void onSuccess(AccessToken accessToken) {
        Log.d(securityCheckName, "auto login success");
    }

    @Override
    public void onFailure(WLFailResponse wlFailResponse) {
        Log.d(securityCheckName, "auto login failure");
    }
});
```

> **Nota:**
> La API `WLAuthorizationManager` `obtainAccessToken()` tiene sus propios métodos `onSuccess` y `onFailure`; **también** se llama a los métodos `handleSuccess` o `handleFailure` del manejador de desafíos relevante.

Si el cliente ya ha iniciado sesión o está en estado *recordado*, la API da como resultado "éxito". Si el cliente no ha iniciado sesión, la comprobación de seguridad devuelve un desafío. 

La API `obtainAccessToken` incluye un **ámbito**. El ámbito puede ser el nombre de su **comprobación de seguridad**.

> Obtenga más información acerca de los **ámbitos** en la guía de aprendizaje [Conceptos de autorización](../../)

## Recuperación del usuario autenticado
{: #retrieving-the-authenticated-user }
El método `handleSuccess` del manejador de desafíos toma `JSONObject identity` como parámetro.
Si la comprobación de seguridad establece `AuthenticatedUser`, el objeto contiene las propiedades del usuario. Puede utilizar `handleSuccess` para guardar el usuario actual:

```java
@Override
public void handleSuccess(JSONObject identity) {
    super.handleSuccess(identity);
    isChallenged = false;
    try {
        //Save the current user
        SharedPreferences preferences = context.getSharedPreferences(Constants.PREFERENCES_FILE, Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = preferences.edit();
        editor.putString(Constants.PREFERENCES_KEY_USER, identity.getJSONObject("user").toString());
        editor.commit();
    } catch (JSONException e) {
        e.printStackTrace();
    }
}
```

Aquí, `identity` tiene una clave denominada `user` que contiene `JSONObject` que representa a `AuthenticatedUser`:

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

```java
WLAuthorizationManager.getInstance().logout(securityCheckName, new WLLogoutResponseListener() {
    @Override
    public void onSuccess() {
        Log.d(securityCheckName, "Logout Success");
    }

    @Override
    public void onFailure(WLFailResponse wlFailResponse) {
        Log.d(securityCheckName, "Logout Failure");
    }
});
```

## Aplicaciones de ejemplo
{: #sample-applications }
Se asocian dos ejemplos a este tutorial:

- **PreemptiveLoginAndroid**: Una aplicación que siempre se inicia con una pantalla de inicio de sesión mediante la API `login` preferente.
- **RememberMeAndroid**: Una aplicación con el recuadro de selección *Recuérdame*. El usuario podrá ignorar la pantalla de inicio de sesión la próxima vez que se abra la aplicación.

Los ejemplos utilizan la misma comprobación de seguridad `UserLogin` del adaptador de **SecurityCheckAdapters** del proyecto Maven.

[Haga clic para descargar](https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80) el proyecto Maven de SecurityCheckAdapters.  
[Haga clic para descargar ](https://github.com/MobileFirst-Platform-Developer-Center/RememberMeAndroid/tree/release80) el proyecto de aplicación web.  
[Haga clic para descargar ](https://github.com/MobileFirst-Platform-Developer-Center/PreemptiveLoginAndroid/tree/release80) el proyecto Recuérdame.

### Uso de ejemplo
{: sample-usage }
Siga el archivo README.md del ejemplo para obtener instrucciones.  
El nombre de usuario/contraseña de la aplicación debe coincidir, por ejemplo "john/john". 

![aplicación de ejemplo](sample-application.png)
