---
layout: tutorial
title: Implementación de la clase CredentialsValidationSecurityCheck
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
Esta clase abstracta amplia `ExternalizableSecurityCheck` e implementa gran parte de sus métodos para facilitar el uso. Hay dos métodos obligatorios: `validateCredentials` y `createChallenge`.  
La clase `CredentialsValidationSecurityCheck` está pensada para que los flujos simples validen credenciales arbitrarias para garantizar el acceso a un recurso. También se proporciona una capacidad incorporada para bloquear el acceso después de un determinado número de intentos.

Este tutorial utiliza el ejemplo de un código PIN grabado en el código para proteger un recurso, y le proporciona al usuario 3 intentos(después de estos tres intentos, la instancia de aplicación cliente se bloquea durante 60 segundos).

**Requisitos previos:** Asegúrese de leer los tutoriales [Conceptos de autorización](../../) y [Creación de una comprobación de seguridad](../../creating-a-security-check).

#### Ir a:
{: #jump-to }
* [Creación de la comprobación de seguridad](#creating-the-security-check)
* [Creación del desafío](#creating-the-challenge)
* [Validación de las credenciales de usuario](#validating-the-user-credentials)
* [Configuración de la comprobación de seguridad](#configuring-the-security-check)
* [Comprobación de seguridad de ejemplo](#sample-security-check)

## Creación de la comprobación de seguridad
{: #creating-the-security-check }
[Cree un adaptador Java](../../../adapters/creating-adapters) y añada una clase Java denominada `PinCodeAttempts` que amplíe `CredentialsValidationSecurityCheck`.

```java
public class PinCodeAttempts extends CredentialsValidationSecurityCheck {

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
Cuando se activa la comprobación de seguridad, envía un desafío al cliente. La devolución de `null` crea un desafío vacío que puede ser insuficiente en algunos casos.   
De forma opcional, puede devolver datos con el desafío, por ejemplo un mensaje de error para mostrar u otros datos que el cliente pueda utilizar.

Por ejemplo, `PinCodeAttempts` envía un mensaje de error predefinido y el número de intentos restantes.

```java
@Override
protected Map<String, Object> createChallenge() {
    Map challenge = new HashMap();
    challenge.put("errorMsg",errorMsg);
    challenge.put("remainingAttempts",getRemainingAttempts());
    return challenge;
}
```

> La implementación de `errorMsg` se incluye en la aplicación de muestra.

`getRemainingAttempts()` se hereda de `CredentialsValidationSecurityCheck`.

## Validación de las credenciales de usuario
{: #validating-the-user-credentials }
Cuando el cliente envía la respuesta del desafío, la respuesta se pasa a `validateCredentials` como `Map`. Este método debería implementar su lógica y devolver `true` si las credenciales son válidas.

```java
@Override
protected boolean validateCredentials(Map<String, Object> credentials) {
    if(credentials!=null && credentials.containsKey("pin")){
        String pinCode = credentials.get("pin").toString();

        if(pinCode.equals("1234")){
            return true;
        }
        else {
            errorMsg = "The pin code is not valid.";
        }

    }
    else{
        errorMsg = "The pin code was not provided.";
    }

    //In any other case, credentials are not valid
    return false;

}
```

### Clase de configuración
{: #configuration-class }
También puede configurar un código PIN válido utilizando el archivo adapter.xml y {{ site.data.keys.mf_console }}.

Cree una nueva clase Java que amplíe `CredentialsValidationSecurityCheckConfig`. Es importante ampliar una clase que coincida con la clase de comprobación de seguridad padre, para poder heredar la configuración predeterminada.

```java
public class PinCodeConfig extends CredentialsValidationSecurityCheckConfig {

    public String pinCode;

    public PinCodeConfig(Properties properties) {
        super(properties);
        pinCode = getStringProperty("pinCode", properties, "1234");
    }

}
```

El único método requerido en esta clase es un constructor que pueda manejar la instancia `Properties`. Utilice el método `get[Type]Property` para recuperar una propiedad específica del archivo adapter.xml.Si no se encuentra ningún valor, el tercer parámetro define un valor predeterminado (`1234`).

También puede añadir el manejo de errores en este constructor utilizando el método `addMessage`:

```java
public PinCodeConfig(Properties properties) {
    //Make sure to load the parent properties
    super(properties);

    //Load the pinCode property
    pinCode = getStringProperty("pinCode", properties, "1234");

    //Check that the PIN code is at least 4 characters long. Triggers an error.
    if(pinCode.length() < 4) {
        addMessage(errors,"pinCode","pinCode needs to be at least 4 characters");
    }

    //Check that the PIN code is numeric. Triggers warning.
    try {
        int i = Integer.parseInt(pinCode);
    }
    catch(NumberFormatException nfe) {
        addMessage(warnings,"pinCode","PIN code contains non-numeric characters");
    }
}
```

En la clase principal (`PinCodeAttempts`), añada los dos métodos siguientes para que puedan cargar la configuración:

```java
@Override
public SecurityCheckConfiguration createConfiguration(Properties properties) {
    return new PinCodeConfig(properties);
}
@Override
protected PinCodeConfig getConfiguration() {
    return (PinCodeConfig) super.getConfiguration();
}
```

Ahora puede utilizar el método `getConfiguration().pinCode` para recuperar el código PIN predeterminado.  

Puede modificar el método `validateCredentials` para utilizar el código PIN de la configuración en lugar del valor no modificado. 

```java
@Override
protected boolean validateCredentials(Map<String, Object> credentials) {
    if(credentials!=null && credentials.containsKey(PINCODE_FIELD)){
        String pinCode = credentials.get(PINCODE_FIELD).toString();

        if(pinCode.equals(getConfiguration().pinCode)){
            return true;
        }
        else {
            errorMsg = "Pin code is not valid. Hint: " + getConfiguration().pinCode;
        }

    }
    else{
        errorMsg = "The pin code was not provided.";
    }

    //In any other case, credentials are not valid
    return false;

}
```

## Configuración de la comprobación de seguridad
{: #configuring-the-security-check }
En adapter.xml, añada un elemento de `<securityCheckDefinition>`:

```xml
<securityCheckDefinition name="PinCodeAttempts" class="com.sample.PinCodeAttempts">
  <property name="pinCode" defaultValue="1234" description="The valid PIN code"/>
  <property name="maxAttempts" defaultValue="3" description="How many attempts are allowed"/>
  <property name="blockedStateExpirationSec" defaultValue="60" description="How long before the client can try again (seconds)"/>
  <property name="successStateExpirationSec" defaultValue="60" description="How long is a successful state valid for (seconds)"/>
</securityCheckDefinition>
```

El atributo `name` debe ser el nombre de la comprobación de seguridad. Establezca el parámetro `class` a la clase que ha creado previamente.

Un `securityCheckDefinition` puede contener cero más elementos `property`. La propiedad `pinCode` es la que se define en la clase de configuración `PinCodeConfig`. Las otras propiedades se heredan de la clase de configuración `CredentialsValidationSecurityCheckConfig`.

De forma predeterminada, si no especifica estas propiedades en el archivo adapter.xml, recibirá los valores que `CredentialsValidationSecurityCheckConfig` ha establecido:

```java
public CredentialsValidationSecurityCheckConfig(Properties properties) {
    super(properties);
    maxAttempts = getIntProperty("maxAttempts", properties, 1);
    attemptingStateExpirationSec = getIntProperty("attemptingStateExpirationSec", properties, 120);
    successStateExpirationSec = getIntProperty("successStateExpirationSec", properties, 3600);
    blockedStateExpirationSec = getIntProperty("blockedStateExpirationSec", properties, 0);
}
```
La clase `CredentialsValidationSecurityCheckConfig` define las propiedades siguientes:
- `maxAttempts`: Los intentos están permitidos antes de obtener un *error*.
- `attemptingStateExpirationSec`: Intervalo en segundos durante el cual el cliente debe proporcionar credenciales válidas, y los intentos se cuentan.
- `successStateExpirationSec`: Intervalo en segundos durante el cual se mantiene el inicio de sesión correcto. 
- `blockedStateExpirationSec`: Intervalo en segundos durante el cual se bloquea el cliente después de alcanzar `maxAttempts`.

Tenga en cuenta que el valor predeterminado para `blockedStateExpirationSec` se establece en `0`: si el cliente envía credenciales inválidas, puede volverse a intentar "0 segundos después". Esto significa que la función "intentos" queda inhabilitada de forma predeterminada. 


## Comprobación de seguridad de ejemplo
{: #sample-security-check }
[Descargue](https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80) el proyecto de Maven de comprobaciones de seguridad.

El proyecto Maven contiene una implementación de CredentialsValidationSecurityCheck.
