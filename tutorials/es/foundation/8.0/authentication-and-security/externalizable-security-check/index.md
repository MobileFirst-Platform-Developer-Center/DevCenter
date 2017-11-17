---
layout: tutorial
title: Implementación de ExternalizableSecurityCheck
breadcrumb_title: ExternalizableSecurityCheck
relevantTo: [android,ios,windows,javascript]
weight: 5
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
La clase abstracta `ExternalizableSecurityCheck` implementa la interfaz `SecurityCheck` y maneja dos aspectos importantes de la funcionalidad de comprobación de seguridad: externalización y gestión de estado. 

* Externalización - esta clase implementa la interfaz `Externalizable`, para que no tengan que implementarse las clases derivadas.
* Gestión de estado - esta clase predefine un estado `STATE_EXPIRED`, lo que significa que la comprobación de seguridad ha caducado y el estado no se conserva.Las clases derivadas necesitan definir otros estados que la comprobación de seguridad soporta. 

Es necesario que las subclases implementen tres métodos: `initStateDurations`, `authorize`, e `introspect`.

Este tutorial describe cómo implementar la clase y muestra cómo gestionar estados. 

**Requisitos previos:** Asegúrese de leer los tutoriales [Conceptos de autorización](../) y [Creación de una comprobación de seguridad](../creating-a-security-check).

#### Ir a:
{: #jump-to }
* [El método initStateDurations](#the-initstatedurations-method)
* [El método authorize](#the-authorize-method)
* [El método introspect](#the-introspect-method)
* [El objeto AuthorizationContext](#the-authorizationcontext-object)
* [El objeto RegistrationContext](#the-registrationcontext-object)

## El método initStateDurations
{: #the-initstatedurations-method }
El `ExternalizableSecurityCheck` define un método abstracto llamado `initStateDurations`. Las subclases deben implementar este método proporcionando los nombres y duraciones para todos los estados soportados por la comprobación de seguridad.Los valores de duración normalmente provienen de la configuración de comprobación de seguridad.

```java
private static final String SUCCESS_STATE = "success";

protected void initStateDurations(Map<String, Integer> durations) {
    durations.put (SUCCESS_STATE, ((SecurityCheckConfig) config).successStateExpirationSec);
}
```

> Para obtener más información acerca de la configuración de comprobación de seguridad, consulte la [sección de clase de configuración](../credentials-validation/security-check/#configuration-class) en el tutorial de implementación de CredentialsValidationSecurityCheck.


## El método authorize
{: #the-authorize-method }
La interfaz `SecurityCheck` define un método denominado `authorize`. Este método es el responsable de implementar la lógica principal de la comprobación de seguridad, de gestionar estados y enviar una respuesta al cliente (acierto, desafío o error). 

Utilice los métodos de ayudante siguientes para gestionar estados:

```java
protected void setState(String name)
```
```java
public String getState()
```
El siguiente ejemplo verifica si el usuario ha iniciado sesión o devuelve acierto o error en consecuencia:
```java
public void authorize(Set<String> scope, Map<String, Object> credentials, HttpServletRequest request, AuthorizationResponse response) {
    if (loggedIn){
        setState(SUCCESS_STATE);
        response.addSuccess(scope, getExpiresAt(), this.getName());
    } else  {
        setState(STATE_EXPIRED);
        Map <String, Object> failure = new HashMap<String, Object>();           
        failure.put("failure", "User is not logged-in");
        response.addFailure(getName(), failure);
    }
}
```

El método `AuthorizationResponse.addSuccess` añade el ámbito de éxito y la caducidad al objeto de respuesta. Requiere:

* El ámbito otorgado por la comprobación de seguridad.
* El vencimiento del ámbito otorgado.  
El método de ayudante `getExpiresAt` devuelve la hora en la que el estado caduca, o 0 si el estado actual es cero:

  ```java
  public long getExpiresAt()
  ```
   
* El nombre de la comprobación de seguridad.

El método `AuthorizationResponse.addFailure` añade un valor de error en el objeto de respuesta. Requiere:

* El nombre de la comprobación de seguridad.
* Un objeto `Map` de error.

El método `AuthorizationResponse.addChallenge` añade un desafío al objeto de respuesta. Requiere:

* El nombre de la comprobación de seguridad.
* Un objeto `Map` de desafío.

## El método introspect
{: #the-introspect-method }
La interfaz `SecurityCheck` define un método llamado `introspect`. Este método debe asegurar que la comprobación de seguridad está en el estado que concede el ámbito solicitado. Si se concede el ámbito, la comprobación de seguridad debe informar al parámetro de resultado sobre el ámbito concedido, el vencimiento, y los datos de introspección. Si no se ha concedido el ámbito, la verificación de seguridad no hace nada.  
Es posible que el método cambie el estado de la comprobación de seguridad y del registro de registro de cliente. 

```java
public void introspect(Set<String> checkScope, IntrospectionResponse response) {
    if (getState().equals(SUCCESS_STATE)) {
        response.addIntrospectionData(getName(),checkScope,getExpiresAt(),null);
    }
}
```

## El objeto AuthorizationContext
{: #the-authorizationcontext-object }
La clase `ExternalizableSecurityCheck` proporciona el objeto `AuthorizationContext authorizationContext` que se utiliza para almacenar los datos transitorios asociados con el cliente actual para la comprobación de seguridad.  
Utilice los métodos siguientes para almacenar y obtener datos:

* Obtenga el usuario autenticado que la comprobación de seguridad ha establecido para el cliente actual:

  ```java
  AuthenticatedUser getActiveUser();
  ```
  
* Establezca el usuario activo para el cliente actual con esta comprobación de seguridad:

  ```java
  void setActiveUser(AuthenticatedUser user);
  ```

## El objeto RegistrationContext
{: #the-registrationcontext-object }
La clase `ExternalizableSecurityCheck` proporciona el objeto `RegistrationContext registrationContext` que se utiliza para almacenar los datos de despliegue/persistentes asociados con el cliente actual.  
Utilice los métodos siguientes para almacenar y obtener datos:

* Obtenga el usuario que la comprobación de seguridad ha registrado para el cliente actual:

  ```java
  AuthenticatedUser getRegisteredUser();
  ```
  
* Registre el usuario proporcionado para el cliente actual:

  ```java
  setRegisteredUser(AuthenticatedUser user);
  ```
  
* Obtenga los atributos persistentes públicos del cliente actual:

  ```java
  PersistentAttributes getRegisteredPublicAttributes();
  ```
  
* Obtenga los atributos persistentes protegidos del cliente actual:

  ```java
  PersistentAttributes getRegisteredProtectedAttributes();
  ```
  
* Encuentre los datos de registro de los clientes móviles de acuerdo con los criterios de búsqueda proporcionados:

  ```java
  List<ClientData> findClientRegistrationData(ClientSearchCriteria criteria);
  ```

## Aplicación de ejemplo
{: #sample-application }
Para un ejemplo que implementa `ExternalizableSecurityCheck`, consulte el tutorial [Inscripción](../enrollment).
