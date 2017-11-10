---
layout: tutorial
title: Inscripción
breadcrumb_title: Inscripción
relevantTo: [android,ios,windows,javascript]
weight: 7
downloads:
  - name: Download Cordova project
    url: https://github.com/MobileFirst-Platform-Developer-Center/EnrollmentCordova/tree/release80
  - name: Download iOS Swift project
    url: https://github.com/MobileFirst-Platform-Developer-Center/EnrollmentSwift/tree/release80
  - name: Download Android project
    url: https://github.com/MobileFirst-Platform-Developer-Center/EnrollmentAndroid/tree/release80
  - name: Download Web project
    url: https://github.com/MobileFirst-Platform-Developer-Center/EnrollmentWeb/tree/release80
  - name: Download SecurityCheck Maven project
    url: https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
Este ejemplo muestra un proceso de inscripción personalizado y una autorización de paso ascendente. Durante el proceso de inscripción de una única vez, se le pide al usuario que introduzca su nombre de usuario y contraseña y que defina el código PIN.   

**Requisitos previos:** Asegúrese de leer los tutoriales [ExternalizableSecurityCheck](../externalizable-security-check/) y [Paso ascendente](../step-up/).

#### Ir a:
{: #jump-to }
* [Flujo de aplicación](#application-flow)
* [Almacenamiento de datos en atributos persistentes](#storing-data-in-persistent-attributes)
* [Comprobaciones de seguridad](#security-checks)
* [Aplicaciones de ejemplo](#sample-applications)

## Flujo de aplicación
{: #application-flow }
* Cuando se inicia la aplicación por primera vez (antes de realizar la inscripción), muestra la IU con dos botones: **Obtener datos públicos** e **Inscribirse**.
* Cuando el usuario pulsa el botón **Inscribirse** para iniciar la inscripción, visualiza un formulario de inicio de sesión y se le solicita que establezca un código PIN.
* Cuando el usuario se haya inscrito correctamente, la IU incluirá cuatro botones: **Obtener datos públicos**, **Obtener saldo**, **Obtener transacciones**, y **Cerrar sesión**. El usuario puede acceder a los cuatro botones sin tener que escribir el código PIN.
* Cuando se inicia la aplicación una segunda vez (después de haber realizado la inscripción), todavía se muestran los cuatro botones en la IU. Sin embargo, cuando el usuario hace clic en el botón **Obtener transacciones***, se le solicita que introduzca el código PIN. 

Si el usuario comete tres fallos al introducir el código PIN, se le solicita que vuelva a autenticarse con un nombre de usuario y una contraseña y que restablezca el código PIN. 

## Almacenamiento de datos en atributos persistentes
{: #storing-data-in-persistent-attributes }
Puede guardar los datos protegidos en el objeto `PersistentAttributes`, que es un contenedor para los atributos personalizados de un cliente registrado. Se puede acceder al objeto desde una clase de comprobación de seguridad o desde una clase de recurso de adaptador.

En la aplicación de ejemplo proporcionada, el objeto `PersistentAttributes` se utiliza en la clase de recurso de adaptador para almacenar el código PIN:

* El recurso **setPinCode** añade el atributo **pinCode** y llama el método `AdapterSecurityContext.storeClientRegistrationData()` para que almacene los cambios.

  ```java
  @POST
  @OAuthSecurity(scope = "setPinCode")
  @Path("/setPinCode/{pinCode}")
  
  public Response setPinCode(@PathParam("pinCode") String pinCode){
  		ClientData clientData = adapterSecurityContext.getClientRegistrationData();
  		clientData.getProtectedAttributes().put("pinCode", pinCode);
  		adapterSecurityContext.storeClientRegistrationData(clientData);
  		return Response.ok().build();
  }
  ```
  
  `users` tiene una llave denominada `EnrollmentUserLogin` que contiene el objeto `AuthenticatedUser`.

* El recurso **Cancelar inscripción** suprime el atributo **pinCode** y llama el método `AdapterSecurityContext.storeClientRegistrationData()` para que almacene los cambios.

  ```java
  @DELETE
  @OAuthSecurity(scope = "unenroll")
  @Path("/unenroll")
  
  public Response unenroll(){
  		ClientData clientData = adapterSecurityContext.getClientRegistrationData();
  		if (clientData.getProtectedAttributes().get("pinCode") != null){
  			clientData.getProtectedAttributes().delete("pinCode");
  			adapterSecurityContext.storeClientRegistrationData(clientData);
  		}
  		return Response.ok().build();
  }
  ```

## Comprobaciones de seguridad
{: #security-checks }
El ejemplo de inscripción contiene tres comprobaciones de seguridad:

### EnrollmentUserLogin
{: #enrollmentuserlogin }
La comprobación de seguridad `EnrollmentUserLogin` protege el recurso **setPinCode** para que solo los usuarios autenticados puedan definir un código PIN. Esta verificación de seguridad se ha creado para caducar rápido y para mantenerse solo durante la "primera experiencia". Es idéntico a la comprobación de seguridad `UserLogin` descrita en el tutorial [Implementación de UserAuthenticationSecurityCheck](../user-authentication/security-check) excepto por los métodos `isLoggedIn` y `getRegisteredUser` adicionales.  
El método `isLoggedIn` devuelve `true` si el estado de la verificación de seguridad es igual al valor ÉXITO y `false` si es lo contrario.  
El método `getRegisteredUser` devuelve el usuario autenticado.

```java
public boolean isLoggedIn(){
    return getState().equals(STATE_SUCCESS);
}
```
```java
public AuthenticatedUser getRegisteredUser() {
    return registrationContext.getRegisteredUser();
}
```

### EnrollmentPinCode
{: #enrollmentpincode }
La comprobación de seguridad `EnrollmentPinCode` protege el recurso **Obtener transacciones** y es similar a la comprobación de seguridad `PinCodeAttempts` descrita en el tutorial [Implementación de CredentialsValidationSecurityCheck](../credentials-validation/security-check), salvo por algunas modificaciones.

En el ejemplo de este tutorial, `EnrollmentPinCode` **depende de ** `EnrollmentUserLogin`. Cuando haya iniciado sesión correctamente en `EnrollmentUserLogin`, solo se le solicita al usuario que introduzca un código PIN.

```java
@SecurityCheckReference
private transient EnrollmentUserLogin userLogin;
```

Cuando se inicie la aplicación **por primera vez** y el usuario se haya inscrito correctamente, deberá poder acceder al recurso **Obtener transacciones** sin tener que indicar el código PIN que ha establecido. Para este propósito, el método `authorize` utiliza el método `EnrollmentUserLogin.isLoggedIn` para verificar si el usuario ha iniciado sesión. Esto significa que si siempre y cuando `EnrollmentUserLogin` no haya caducado, el usuario puede acceder a **Obtener transacciones**.

```java
@Override

public void authorize(Set<String> scope, Map<String, Object> credentials, HttpServletRequest request, AuthorizationResponse response) {
    if (userLogin.isLoggedIn()){
        setState(STATE_SUCCESS);
        response.addSuccess(scope, userLogin.getExpiresAt(), getName());
    }
}
```

Si el usuario comete tres fallos al introducir el código PIN, el tutorial está diseñado para que el atributo **pinCode** se suprima antes de solicitar al usuario que se autentique, utilizando el nombre de usuario y la contraseña y restableciendo el código PIN.

```java
@Override

public void authorize(Set<String> scope, Map<String, Object> credentials, HttpServletRequest request, AuthorizationResponse response) {
    PersistentAttributes attributes = registrationContext.getRegisteredProtectedAttributes();
    if (userLogin.isLoggedIn()){
        setState(STATE_SUCCESS);
        response.addSuccess(scope, userLogin.getExpiresAt(), getName());
    } else {
        super.authorize(scope, credentials, request, response);
        if (getState().equals(STATE_BLOCKED)){
            attributes.delete("pinCode");
        }
    }
}
```

El método `validateCredentials` es el mismo que en la comprobación de seguridad `PinCodeAttempts`, pero en este caso las credenciales se comparan con el atributo **pinCode**.

```java
@Override

protected boolean validateCredentials(Map<String, Object> credentials) {
    PersistentAttributes attributes = registrationContext.getRegisteredProtectedAttributes();
    if(credentials!=null && credentials.containsKey("pin")){
        String pinCode = credentials.get("pin").toString();

        if(pinCode.equals(attributes.get("pinCode"))){
            errorMsg = null;
            return true;
        }
        else {
            errorMsg = "The pin code is not valid. Hint: " + attributes.get("pinCode");
        }
    }
    else{
        errorMsg = "The pin code was not provided.";
    }
    //In any other case, credentials are not valid
    return false;
}
```

### IsEnrolled
{: #isenrolled }
La comprobación de seguridad `IsEnrolled` protege:

* El recurso **getBalance** para que solo los usuarios inscritos puedan utilizar el saldo.
* El recurso **transacciones** de manera que solo los usuarios inscritos pueden obtener las transacciones.
* El recurso **cancelar inscripción** por lo que solo es posible suprimir el **pinCode** si se ha definido antes. 

#### Creación de la comprobación de seguridad
{: #creating-the-security-check }
[Cree un adaptador Java](../../adapters/creating-adapters/) y añada una clase Java denominada `IsEnrolled` que amplíe `ExternalizableSecurityCheck`.

```java
public class IsEnrolled  extends ExternalizableSecurityCheck{
    protected void initStateDurations(Map<String, Integer> durations) {}

    public void authorize(Set<String> scope, Map<String, Object> credentials, HttpServletRequest request, AuthorizationResponse response) {}

    public void introspect(Set<String> scope, IntrospectionResponse response) {}
}
```

#### La clase de configuración IsEnrolledConfig
{: #the-isenrolledconfig-configuration-class }
Cree una clase de configuración `IsEnrolledConfig` que amplíe `ExternalizableSecurityCheckConfig`:

```java
public class IsEnrolledConfig extends ExternalizableSecurityCheckConfig {

    public int successStateExpirationSec;

    public IsEnrolledConfig(Properties properties) {
        super(properties);
        successStateExpirationSec = getIntProperty("expirationInSec", properties, 8000);
    }
}
```

Añada el método `createConfiguration` en la clase `IsEnrolled`:

```java
public class IsEnrolled  extends ExternalizableSecurityCheck{
    @Override
    public SecurityCheckConfiguration createConfiguration(Properties properties) {
        return new IsEnrolledConfig(properties);
    }
}
```
#### El método initStateDurations
{: #the-initstatedurations-method }
Establezca la duración para el estado ÉXITO en `successStateExpirationSec`:

```java
@Override
protected void initStateDurations(Map<String, Integer> durations) {
    durations.put (SUCCESS_STATE, ((IsEnrolledConfig) config).successStateExpirationSec);
}
```

#### El método authorize
{: #the-authorize-method }
El ejemplo de código verifica si el usuario está inscrito y devuelve un error o un acierto en consecuencia:

```java
public void authorize(Set<String> scope, Map<String, Object> credentials, HttpServletRequest request, AuthorizationResponse response) {
    PersistentAttributes attributes = registrationContext.getRegisteredProtectedAttributes();
    if (attributes.get("pinCode") != null){
        setState(SUCCESS_STATE);
        response.addSuccess(scope, getExpiresAt(), this.getName());
    } else  {
        setState(STATE_EXPIRED);
        Map <String, Object> failure = new HashMap<String, Object>();
        failure.put("failure", "User is not enrolled");
        response.addFailure(getName(), failure);
    }
}
```

* En caso de que exista el atributo `pinCode`:

 * Establezca el estado en ÉXITO utilizando el método `setState`.
 * Añada el valor éxito en el objeto de respuesta utilizando el método `addSuccess`.

* En caso de que el atributo `pinCode` no exista:

 * Establezca el estado CADUCADO utilizando el método `setState`.
 * Añada el valor error en el objeto de respuesta utilizando el método `addFailure`.

<br/>
La comprobación de seguridad `IsEnrolled` **depende de** `EnrollmentUserLogin`:
```java
@SecurityCheckReference
private transient EnrollmentUserLogin userLogin;
```

Establezca el usuario activo añadiendo el código siguiente:

```java
public void authorize(Set<String> scope, Map<String, Object> credentials, HttpServletRequest request, AuthorizationResponse response) {
    PersistentAttributes attributes = registrationContext.getRegisteredProtectedAttributes();
    if (attributes.get("pinCode") != null){
        // Is there a user currently active?
        if (!userLogin.isLoggedIn()){
            // If not, set one here.
            authorizationContext.setActiveUser(userLogin.getRegisteredUser());
        }
        setState(SUCCESS_STATE);
        response.addSuccess(scope, getExpiresAt(), this.getName());
    } else  {
        setState(STATE_EXPIRED);
        Map <String, Object> failure = new HashMap<String, Object>();
        failure.put("failure", "User is not enrolled");
        response.addFailure(getName(), failure);
    }
}
```
   
A continuación, el recurso `transacciones` obtiene el objeto actual `AuthenticatedUser` para presentar el nombre de visualización:

```java
@GET
@Produces(MediaType.TEXT_PLAIN)
@OAuthSecurity(scope = "transactions")
@Path("/transactions")

public String getTransactions(){
  AuthenticatedUser currentUser = securityContext.getAuthenticatedUser();
  return "Transactions for " + currentUser.getDisplayName() + ":\n{'date':'12/01/2016', 'amount':'19938.80'}";
}
```
    
> Para obtener más información acerca de `securityContext`, consulte la sección [API Seguridad](../../adapters/java-adapters/#security-api) en el tutorial de adaptador Java.


Añada el usuario registrado al objeto de respuesta de la forma siguiente:

```java
public void authorize(Set<String> scope, Map<String, Object> credentials, HttpServletRequest request, AuthorizationResponse response) {
    PersistentAttributes attributes = registrationContext.getRegisteredProtectedAttributes();
    if (attributes.get("pinCode") != null){
        // Is there a user currently active?
        if (!userLogin.isLoggedIn()){
            // If not, set one here.
            authorizationContext.setActiveUser(userLogin.getRegisteredUser());
        }
        setState(SUCCESS_STATE);
        response.addSuccess(scope, getExpiresAt(), getName(), "user", userLogin.getRegisteredUser());
    } else  {
        setState(STATE_EXPIRED);
        Map <String, Object> failure = new HashMap<String, Object>();
        failure.put("failure", "User is not enrolled");
        response.addFailure(getName(), failure);
    }
}
```
    
En el código de ejemplo, el método `handleSuccess` del manejador de desafíos `IsEnrolled` utiliza el objeto de usuario para presentar el nombre de visualización.

<img alt="Aplicación de ejemplo de inscripción" src="sample_application.png" style="float:right"/>
## Aplicaciones de ejemplo
{: #sample-applications }

### Comprobación de seguridad
{: #security-check }
Las comprobaciones de seguridad `EnrollmentUserLogin`, `EnrollmentPinCode`, e `IsEnrolled` están disponibles en el proyecto SecurityChecks del proyecto Maven de inscripción.
[Haga clic para descargar](https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80) el proyecto Maven de comprobaciones de seguridad.

### Aplicaciones
{: #applications }
Las aplicaciones de ejemplo están disponibles para iOS (Swift), Android, Cordova y Web.

* [Haga clic para descargar](https://github.com/MobileFirst-Platform-Developer-Center/EnrollmentCordova/tree/release80) el proyecto Cordova.
* [Haga clic para descargar](https://github.com/MobileFirst-Platform-Developer-Center/EnrollmentSwift/tree/release80) el proyecto iOS Swift.
* [Haga clic para descargar ](https://github.com/MobileFirst-Platform-Developer-Center/EnrollmentAndroid/tree/release80) el proyecto Android.
* [Haga clic para descargar ](https://github.com/MobileFirst-Platform-Developer-Center/EnrollmentWeb/tree/release80) el proyecto de aplicación Web.

### Uso de ejemplo
{: #sample-usage }
Siga el archivo README.md del ejemplo para obtener instrucciones.
