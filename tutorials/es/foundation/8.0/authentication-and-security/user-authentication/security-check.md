---
layout: tutorial
title: Implementación de la clase UserAuthenticationSecurityCheck
breadcrumb_title: Comprobación de seguridad
relevantTo: [android,ios,windows,javascript]
weight: 1
downloads:
  - name: Download Security Checks
    url: https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
Esta clase abstracta amplia `CredentialsValidationSecurityCheck` y se compila para ajustarse a los casos de uso más comunes de la autenticación de usuario simple. Además de validar las credenciales, crea una **identidad de usuario** a la que se puede acceder desde varias partes de la infraestructura, permitiéndolo identificar el usuario actual. De forma opcional, `UserAuthenticationSecurityCheck` también proporciona funcionalidades de **Recuérdame**.

Este tutorial utiliza el ejemplo de una comprobación de seguridad que solicita un nombre de usuario y contraseña, y utiliza el nombre de usuario para representar un usuario autenticado.

**Requisitos previos:** Asegúrese de leer la guía de aprendizaje [CredentialsValidationSecurityCheck](../../credentials-validation/).

#### Ir a:
{: #jump-to }
* [Creación de la comprobación de seguridad](#creating-the-security-check)
* [Creación del desafío](#creating-the-challenge)
* [Validación de las credenciales de usuario](#validating-the-user-credentials)
* [Creación del objeto AuthenticatedUser](#creating-the-authenticateduser-object)
* [Adición de la funcionalidad RememberMe](#adding-rememberme-functionality)
* [Configuración de la comprobación de seguridad](#configuring-the-security-check)
* [Comprobación de seguridad de ejemplo](#sample-security-check)

## Creación de la comprobación de seguridad
{: #creating-the-security-check }
[Cree un adaptador Java](../../../adapters/creating-adapters) y añada una clase Java denominada `UserLogin` que amplíe `UserAuthenticationSecurityCheck`.

```java
public class UserLogin extends UserAuthenticationSecurityCheck {

    @Override
    protected AuthenticatedUser createUser() {
        return null;
    }

    @Override
    protected boolean validateCredentials(Map<String, Object> credentials) {
        return false;
    }

    @Override
    protected Map<String, Object> createChallenge() {
        return null;
    }
}
```

## Creación del desafío
{: #creating-the-challenge }
El desafío es el mismo que el descrito en [Implementación de CredentialsValidationSecurityCheck](../../credentials-validation/security-check/).

```java
@Override
protected Map<String, Object> createChallenge() {
    Map challenge = new HashMap();
    challenge.put("errorMsg",errorMsg);
    challenge.put("remainingAttempts",getRemainingAttempts());
    return challenge;
}
```

## Validación de las credenciales de usuario
{: #validating-the-user-credentials }
Cuando el cliente envía una respuesta al desafío, la respuesta se pasa a `validateCredentials` como `Map`. Utilice este método para implementar la lógica.El método devuelve el valor `true` si las credenciales son válidas.

En este ejemplo, las credenciales se consideran "válidas" cuando `username` y `password` son lo mismo:

```java
@Override
protected boolean validateCredentials(Map<String, Object> credentials) {
    if(credentials!=null && credentials.containsKey("username") && credentials.containsKey("password")){
        String username = credentials.get("username").toString();
        String password = credentials.get("password").toString();
        if(!username.isEmpty() && !password.isEmpty() && username.equals(password)) {
            return true;
        }
        else {
            errorMsg = "Wrong Credentials";
        }
    }
    else{
        errorMsg = "Credentials not set properly";
    }
    return false;
}
```

## Creación del objeto AuthenticatedUser
{: #creating-the-authenticateduser-object }
La clase `UserAuthenticationSecurityCheck` almacena una representación del cliente actual (usuario, dispositivo, aplicación) en los datos persistentes, permitiendo recuperar el usuario actual en varias partes del código como, por ejemplo, los manejadores de desafíos o los adaptadores.
Los usuarios se representan por una instancia de la clase `AuthenticatedUser`. El constructor toma los parámetros `id`, `displayName`, y `securityCheckName`.

Este ejemplo utiliza `username` para los parámetros `id` y `displayName`.

1. Primero, modifique el método `validateCredentials` para guardar el argumento `username`:

   ```java
   private String userId, displayName;

   @Override
   protected boolean validateCredentials(Map<String, Object> credentials) {
        if(credentials!=null && credentials.containsKey("username") && credentials.containsKey("password")){
            String username = credentials.get("username").toString();
            String password = credentials.get("password").toString();
            if(!username.isEmpty() && !password.isEmpty() && username.equals(password)) {
                userId = username;
                displayName = username;
                return true;
            }
            else {
                errorMsg = "Wrong Credentials";
            }
        }
        else{
            errorMsg = "The credentials are not set properly.";
        }
        return false;
   }
   ```

2. A continuación, sustituya el método `createUser` para devolver una nueva instancia de `AuthenticatedUser`:

   ```java
   @Override
   protected AuthenticatedUser createUser() {
        return new AuthenticatedUser(userId, displayName, this.getName());
   }
   ```

Puede utilizar `this.getName()` para obtener el nombre de la comprobación de seguridad actual.

`UserAuthenticationSecurityCheck` llama a la implementación `createUser()` después que de `validateCredentials` se complete con éxito.

### Almacenamiento de atributos en AuthenticatedUser
{: #storing-attributes-in-the-authenticateduser }
`AuthenticatedUser` tiene un constructor alternativo:

```java
AuthenticatedUser(String id, String displayName, String securityCheckName, Map<String, Object> attributes);
```

Este constructor añade el atributo `Map` de los atributos personalizados para almacenarlo con la representación del usuario. La correlación puede utilizarse para almacenar información adicional como, por ejemplo, una foto de perfil, un sitio web, etc. Se puede acceder a esta información en el lado del cliente (manejador de usuarios) y en el recurso (mediante los datos de introspección). 

> **Nota:**
> Los atributos `Map` deben contener solo objetos de tipos/clases empaquetados en la biblioteca Java (por ejemplo `String`, `int`, `Map`, etc), y **no** clases personalizadas.

## Adición de la funcionalidad RememberMe
{: #adding-rememberme-functionality }
De forma predeterminada, `UserAuthenticationSecurityCheck` utiliza la propiedad `successStateExpirationSec` para determinar la duración del estado de éxito. Esta propiedad se hereda de `CredentialsValidationSecurityCheck`.

Si desea permitir que los usuarios permanezcan con la sesión iniciada pasado el valor `successStateExpirationSec`, `UserAuthenticationSecurityCheck` añade esta funcionalidad.

`UserAuthenticationSecurityCheck` añade una propiedad denominada `rememberMeDurationSec` cuyo valor predeterminado es `0`: de forma predeterminada, los usuarios se recuerdan durante **0 segundos**, lo que significa que esta función está inhabilitada de forma predeterminada. Modifique el valor a un número que tenga sentido para la aplicación (un día, una semana, un mes...).

También puede gestionar la función sustituyendo el método `rememberCreatedUser()`, que devuelve el valor `true` de forma predeterminada, lo que significa que la función está activa de forma predeterminada (siempre que haya modificado la duración de la propiedad).

En este ejemplo, el cliente decide habilitar/inhabilitar la función **RememberMe** enviando un valor `boolean` como parte de las credenciales enviadas.

1. Primero, modifique el método `validateCredentials` para guardar la opción `rememberMe`:

   ```java
   private String userId, displayName;
   private boolean rememberMe = false;

   @Override
   protected boolean validateCredentials(Map<String, Object> credentials) {
        if(credentials!=null && credentials.containsKey("username") && credentials.containsKey("password")){
            String username = credentials.get("username").toString();
            String password = credentials.get("password").toString();
            if(!username.isEmpty() && !password.isEmpty() && username.equals(password)) {
                userId = username;
                displayName = username;

                //Optional RememberMe
                if(credentials.containsKey("rememberMe") ){
                    rememberMe = Boolean.valueOf(credentials.get("rememberMe").toString());
                }

                return true;
            }
            else {
                errorMsg = "Wrong Credentials";
            }
        }
        else{
            errorMsg = "Credentials not set properly";
        }
        return false;
   }
   ```

2. A continuación, sustituya el método `rememberCreatedUser()`:

   ```java
   @Override
   protected boolean rememberCreatedUser() {
        return rememberMe;
   }
   ```

## Configuración de la comprobación de seguridad
{: #configuring-the-security-check }
En el archivo **adapter.xml**, añada un elemento de `<securityCheckDefinition>`:

```xml
<securityCheckDefinition name="UserLogin" class="com.sample.UserLogin">
  <property name="maxAttempts" defaultValue="3" description="How many attempts are allowed."/>
  <property name="blockedStateExpirationSec" defaultValue="10" description="How long before the client can try again (seconds)."/>
  <property name="successStateExpirationSec" defaultValue="60" description="How long is a successful state valid for (seconds)."/>
  <property name="rememberMeDurationSec" defaultValue="120" description="How long is the user remembered by the RememberMe feature (seconds)."/>
</securityCheckDefinition>
```
Como se ha mencionado anteriormente, `UserAuthenticationSecurityCheck` hereda todas las propiedades `CredentialsValidationSecurityCheck` como `blockedStateExpirationSec`, `successStateExpirationSec`, etc.

Además, también puede configurar una propiedad `rememberMeDurationSec`.

## Comprobación de seguridad de ejemplo
{: #sample-security-check }
[Descargue](https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80) el proyecto de Maven de comprobaciones de seguridad.

El proyecto Maven contiene una implementación de `UserAuthenticationSecurityCheck`.
