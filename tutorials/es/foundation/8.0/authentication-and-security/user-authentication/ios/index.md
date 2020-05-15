---
layout: tutorial
title: Implementación del manejador de desafíos en aplicaciones iOS
breadcrumb_title: iOS
relevantTo: [ios]
weight: 3
downloads:
  - name: Download PreemptiveLogin project
    url: https://github.com/MobileFirst-Platform-Developer-Center/PreemptiveLoginSwift/tree/release80
  - name: Download RememberMe project
    url: https://github.com/MobileFirst-Platform-Developer-Center/RememberMeSwift/tree/release80
  - name: Download SecurityCheck Maven project
    url: https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
**Requisitos previos:** Asegúrese de leer la guía de aprendizaje de la [implementación del manejador de usuarios](../../credentials-validation/ios/) de **CredentialsValidationSecurityCheck**.

La guía de aprendizaje del manejador de desafíos muestra características adicionales (API) como, por ejemplo, las características `login`, `logout`, y `obtainAccessTokenForScope` preferentes.

## Inicio de sesión
{: #login }
En este ejemplo, `UserLogin` espera los *valores clave* llamados `username` y `password`. De forma opcional, también acepta una clave booleana `rememberMe`, que le pide a la comprobación de seguridad que recuerde el usuario durante más tiempo. En la aplicación de ejemplo, lo recopila un valor booleano del recuadro de selección en el formulario de inicio de sesión.

El argumento `credentials` es `JSONObject` que contiene los valores `username`, `password`, and `rememberMe`:

```swift
self.submitChallengeAnswer(credentials);
```

Es posible que desee iniciar sesión en un usuario sin recibir desafíos. Por ejemplo, puede mostrar una pantalla de inicio de sesión como la primera pantalla de la aplicación, una pantalla de inicio de sesión después de cerrar sesión, o un error de inicio de sesión. Dichos escenarios se denominan **inicios de sesión preferentes**.

No puede llamar la API `submitChallengeAnswer` si no hay desafíos a los que responder. Para estos escenarios, el SDK de {{ site.data.keys.product }} incluye la API `login`:

```swift
WLAuthorizationManagerSwift.sharedInstance().login(securityCheck: self.securityCheckName, credentials: credentials) { (error) in
    if(error != nil){
        print("Login Preemptive Failure: " + String(error!));
    }
    else{
        print("Login Preemptive Success");
    }
}
```

Si las credenciales no son correctas, la comprobación de seguridad devuelve un **desafío**.

Es responsabilidad del desarrollador saber cuando utilizar `login`, en lugar de `submitChallengeAnswer`, en función de las necesidades de la aplicación. Una forma de conseguirlo es definiendo un distintivo booleano, por ejemplo `isChallenged`, y establecerlo en `true` cuando se alcance `handleChallenge`, o establecerlo en `false` en los otros casos (error, éxito, inicialización, etc).

Cuando el usuario pulsa el botón **Iniciar sesión**, puede elegir dinámicamente qué API desea utilizar:

```swift
if(!self.isChallenged){
  WLAuthorizationManagerSwift.sharedInstance().login(securityCheck: self.securityCheckName, credentials: credentials) { (error) -> Void in}
}
else{
  self.submitChallengeAnswer(credentials)
}
```

> **Nota:**
>La API `WLAuthorizationManager` `login()` tiene su propio manejador de terminación; **también** se llama a los métodos `handleSuccess` o `handleFailure` del manejador de desafíos relevante.

## Obtención de una señal de acceso
{: #obtaining-an-access-token }
Como esta comprobación de seguridad da soporte a la funcionalidad **RememberMe** (como la clave booleana `rememberMe`), sería de gran utilidad comprobar si el cliente tiene una sesión iniciada cuando se inicia la aplicación.

El SDK de Mobile Foundation proporciona la API `obtainAccessToken` para solicitar al servidor una señal válida:

```swift
WLAuthorizationManagerSwift.sharedInstance().obtainAccessToken(forScope : scope) { (token, error) -> Void in
  if(error != nil){
    print(“obtainAccessTokenForScope failed: “, error!)
  }
  else{
    print(“obtainAccessTokenForScope success " + (token?.value)!);
  }
}
```

> **Nota:**
> La API `WLAuthorizationManagerSwift obtainAccessToken()` tiene su propio manejador de terminación, **también** se invocan `handleSuccess` o `handleFailure`, del manejador de desafíos relevante. 

Si el cliente ya ha iniciado sesión o está en estado *recordado*, la API da como resultado "éxito". Si el cliente no ha iniciado sesión, la comprobación de seguridad devuelve un desafío.

La API `obtainAccessTokenForScope` incluye un **ámbito**. El ámbito puede ser el nombre de su **comprobación de seguridad**.

> Obtenga más información acerca los **ámbitos** en la guía de aprendizaje [Conceptos de autorización](../../).

## Recuperación del usuario autenticado
{: #retrieving-the-authenticated-user }
El método `handleSuccess` del manejador de desafíos recibe un diccionario `success` como parámetro.
Si la comprobación de seguridad establece `AuthenticatedUser`, el objeto contiene las propiedades del usuario. Puede utilizar `handleSuccess` para guardar el usuario actual:

```swift
override open func handleSuccess(successResponse: [NSObject : AnyObject]!) {
  self.isChallenged = false
  self.defaults.setObject(successResponse![“user"]!["displayName"]! as! String, forKey: "displayName")
}
```

Aquí, `success` tiene una clave denominada `user` que contiene un diccionario que representa a `AuthenticatedUser`:

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

```swift
WLAuthorizationManagerSwift.sharedInstance().logout(securityCheck: self.securityCheck){ (error) -> Void in
    if(error != nil){
        print("Logout Failure: " , error!)
    }
}
```

## Aplicaciones de ejemplo
{: #sample-applications }
Se asocian dos ejemplos a este tutorial:

- **PreemptiveLoginSwift**: Una aplicación que siempre se inicia con una pantalla de inicio de sesión mediante la API `login` preferente.
- **RememberMeSwift**: Una aplicación con el recuadro de selección *Recuérdame*. El usuario podrá ignorar la pantalla de inicio de sesión la próxima vez que se abra la aplicación.

Los ejemplos utilizan la misma comprobación de seguridad `UserLogin` del adaptador de **SecurityCheckAdapters** del proyecto Maven.

[Haga clic para descargar](https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80) el proyecto Maven de SecurityCheckAdapters.  
[Haga clic para descargar ](https://github.com/MobileFirst-Platform-Developer-Center/RememberMeSwift/tree/release80) el proyecto de aplicación web.  
[Haga clic para descargar ](https://github.com/MobileFirst-Platform-Developer-Center/PreemptiveLoginSwift/tree/release80) el proyecto Recuérdame.  

### Uso de ejemplo
{: #sample-usage }
Siga el archivo README.md del ejemplo para obtener instrucciones.  
El nombre de usuario/contraseña de la aplicación debe coincidir, por ejemplo "john/john".

![aplicación de ejemplo](sample-application.png)
