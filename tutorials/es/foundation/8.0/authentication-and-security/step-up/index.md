---
layout: tutorial
title: Autenticación de paso ascendente
breadcrumb_title: Autenticación de paso ascendente
relevantTo: [android,ios,windows,javascript]
weight: 5
downloads:
  - name: Download Cordova project
    url: https://github.com/MobileFirst-Platform-Developer-Center/StepUpCordova/tree/release80
  - name: Download iOS Swift project
    url: https://github.com/MobileFirst-Platform-Developer-Center/StepUpSwift/tree/release80
  - name: Download Android project
    url: https://github.com/MobileFirst-Platform-Developer-Center/StepUpAndroid/tree/release80
  - name: Download Win8 project
    url: https://github.com/MobileFirst-Platform-Developer-Center/StepUpWin8/tree/release80
  - name: Download Win10 project
    url: https://github.com/MobileFirst-Platform-Developer-Center/StepUpWin10/tree/release80
  - name: Download Web project
    url: https://github.com/MobileFirst-Platform-Developer-Center/StepUpWeb/tree/release80
  - name: Download SecurityCheck Maven project
    url: https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
Los recursos pueden protegerse por varias comprobaciones de seguridad. En este caso, {{ site.data.keys.mf_server }} envía a la aplicación todos los desafíos relevantes simultáneamente.  

Una comprobación de seguridad también puede depender de otra comprobación de seguridad. Por lo tanto, es importante poder controlar cuando se envían los desafíos.   
Por ejemplo, esta guía de aprendizaje describe una aplicación que tiene dos recursos protegidos por un nombre de usuario y una contraseña, en la que el segundo recurso también requiere un código PIN adicional. 

**Requisitos previos:** Lea las guías de aprendizaje [CredentialsValidationSecurityCheck](../credentials-validation) y [UserAuthenticationSecurityCheck](../user-authentication) antes de continuar.

#### Ir a:
{: #jump-to }
* [Referencia a una comprobación de seguridad](#referencing-a-security-check)
* [Máquina de estados](#state-machine)
* [El método authorize](#the-authorize-method)
* [Manejadores de desafíos](#challenge-handlers)
* [Aplicaciones de ejemplo](#sample-applications)

## Referencia a una comprobación de seguridad
{: #referencing-a-security-check }
Cree dos comprobaciones de seguridad separadas: `StepUpPinCode` y `StepUpUserLogin`. La implementación inicial es la misma que la implementación descrita en las guías de aprendizaje [Validación de credenciales](../credentials-validation/security-check/) y [Autenticación de usuario](../user-authentication/security-check/).

En este ejemplo, `StepUpPinCode` **depende de ** `StepUpUserLogin`. Se debería pedir al usuario que introduzca un código PIN solo después de haber iniciado sesión en `StepUpUserLogin` correctamente. Para ello, `StepUpPinCode` debe poder **referenciar** la clase `StepUpUserLogin`.  

La infraestructura de {{ site.data.keys.product_adj }} proporciona una anotación para añadir una referencia.  
En la clase `StepUpPinCode`, a nivel de clase, añada:

```java
@SecurityCheckReference
private transient StepUpUserLogin userLogin;
```

> <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> **Importante:** Las dos implementaciones de comprobación de seguridad deben estar empaquetadas en el mismo adaptador.


Para resolver esta referencia, la infraestructura busca una comprobación de seguridad con la clase apropiada, y la añade a la referencia correspondiente en la comprobación de seguridad dependiente.   
Si hay más de una comprobación de seguridad de la misma clase, la anotación tiene un parámetro `name` opcional, que puede utilizar para especificar el nombre exclusivo de la comprobación a la que se hace referencia.

## Máquina de estados
{: #state-machine }
Todas las clases que amplían `CredentialsValidationSecurityCheck` (que incluye `StepUpPinCode` y `StepUpUserLogin`) heredan una máquina de estados simple. En cualquier momento, la comprobación de seguridad puede ser uno de los estados siguientes: 

- `STATE_ATTEMPTING`: Se ha enviado un desafío y la comprobación de seguridad espera la respuesta del cliente.El recuento del intento se mantiene durante este estado. 
- `STATE_SUCCESS`: Las credenciales se han validado correctamente.
- `STATE_BLOCKED`: Se ha alcanzado el número máximo de intentos y la verificación está en estado de bloqueo.

El estado actual puede obtenerse utilizando el método `getState()` heredado.

En `StepUpUserLogin`, añada un método de conveniencia para verificar si el usuario ha iniciado sesión.
El método se utilizará más adelante en la guía de aprendizaje.

```java
public boolean isLoggedIn(){
    return this.getState().equals(STATE_SUCCESS);
}
```

## El método authorize
{: #the-authorize-method }
La interfaz `SecurityCheck` define un método denominado `authorize`. Este método es responsable de implementar la lógica principal de la comprobación de seguridad como, por ejemplo, el envío de un desafío o la validación de la solicitud.  
La clase `CredentialsValidationSecurityCheck`, que amplia `StepUpPinCode`, ya incluye una implementación para este método. Sin embargo, en este caso, el objetivo es verificar el estado de `StepUpUserLogin` antes de iniciar el comportamiento predeterminado del método `authorize`.

Para ello, **sustituya** el método `authorize`:

```java
@Override
public void authorize(Set<String> scope, Map<String, Object> credentials, HttpServletRequest request, AuthorizationResponse response) {
    if(userLogin.isLoggedIn()){
        super.authorize(scope, credentials, request, response);
    }
}
```

Esta implementación comprueba el estado actual de la referencia `StepUpUserLogin`:

* Si el estado es `STATE_SUCCESS` (el usuario ha iniciado sesión), el flujo normal de la comprobación de seguridad continua. 
* Si el estado de `StepUpUserLogin` es otro diferente, no se realiza ninguna acción: no se envía ningún desafío y el resultado no es ni éxito ni error.

Si damos por hecho que el recurso lo protegen **** `StepUpPinCode` y `StepUpUserLogin`, el flujo se asegura de que el usuario ha iniciado sesión antes de que se le solicite una segunda credencial (código PIN). El cliente nunca recibe ambos desafíos al mismo tiempo, aunque las dos comprobaciones de seguridad estén activas.

De forma alternativa, si el recurso **solo** está protegido por `StepUpPinCode` (la infraestructura activará solo esta comprobación de seguridad), puede modificar la implementación `authorize` para iniciar `StepUpUserLogin` manualmente:

```java
@Override
public void authorize(Set<String> scope, Map<String, Object> credentials, HttpServletRequest request, AuthorizationResponse response) {
    if(userLogin.isLoggedIn()){
        //If StepUpUserLogin is successful, continue the normal processing of StepUpPinCode
        super.authorize(scope, credentials, request, response);
    } else {
        //In any other case, process StepUpUserLogin instead.
        userLogin.authorize(scope, credentials, request, response);
    }
}
```

## Recuperar el usuario actual
{: #retrieve-current-user }
En la comprobación de seguridad `StepUpPinCode`, le interesa saber el ID del usuario actual para poder buscar el código PIN del usuario en alguna base de datos.

En la comprobación de seguridad `StepUpUserLogin`, añada el siguiente método para obtener el usuario actual del **contexto de autorización**:

```java
public AuthenticatedUser getUser(){
    return authorizationContext.getActiveUser();
}
```

En `StepUpPinCode`, puede utilizar el método `userLogin.getUser()` para obtener el usuario actual de la comprobación de seguridad `StepUpUserLogin` y verificar el código PIN válido para este usuario específico:

```java
@Override
protected boolean validateCredentials(Map<String, Object> credentials) {
    //Get the correct PIN code from the database
    User user = userManager.getUser(userLogin.getUser().getId());

    if(credentials!=null && credentials.containsKey(PINCODE_FIELD)){
        String pinCode = credentials.get(PINCODE_FIELD).toString();

        if(pinCode.equals(user.getPinCode())){
            errorMsg = null;
            return true;
        }
        else{
            errorMsg = "Wrong credentials. Hint: " + user.getPinCode();
        }
    }
    return false;
}
```

## Manejadores de desafíos
{: #challenge-handlers }
En el lado del cliente, no hay API especiales para manejar varios pasos. En su lugar, cada manejador de desafíos manejar su propio desafío.En este ejemplo, debe registrar dos manejadores de desafíos distintos: uno para manejar desafíos desde `StepUpUserLogin` y otro para manejarlos desde `StepUpPincode`.

<img alt="Aplicación de ejemplo de paso ascendente" src="sample_application.png" style="float:right"/>
## Aplicaciones de ejemplo
{: #sample-applications }
### Comprobación de seguridad
{: #security-check }
Las comprobaciones de seguridad `StepUpUserLogin` y `StepUpPinCode` están disponibles en el proyecto SecurityChecks del proyecto Maven StepUp.
[Haga clic para descargar](https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80) el proyecto Maven de comprobaciones de seguridad.

### Aplicaciones
{: #applications }
Las aplicaciones de ejemplo están disponibles para iOS (Swift), Android, Windows 8.1/10 Cordova y Web.

* [Haga clic para descargar](https://github.com/MobileFirst-Platform-Developer-Center/StepUpCordova/tree/release80) el proyecto Cordova.
* [Haga clic para descargar](https://github.com/MobileFirst-Platform-Developer-Center/StepUpSwift/tree/release80) el proyecto iOS Swift.
* [Haga clic para descargar ](https://github.com/MobileFirst-Platform-Developer-Center/StepUpAndroid/tree/release80) el proyecto Android.
* [Haga clic para descargar](https://github.com/MobileFirst-Platform-Developer-Center/StepUpWin8/tree/release80) el proyecto de Windows 8.1.
* [Haga clic para descargar](https://github.com/MobileFirst-Platform-Developer-Center/StepUpWin10/tree/release80) el proyecto de Windows 10.
* [Haga clic para descargar ](https://github.com/MobileFirst-Platform-Developer-Center/StepUpWeb/tree/release80) el proyecto de aplicación Web.

### Uso de ejemplo
{: #sample-usage }
Siga el archivo README.md del ejemplo para obtener instrucciones.
