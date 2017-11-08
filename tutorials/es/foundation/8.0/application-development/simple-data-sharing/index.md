---
layout: tutorial
title: Compartición de datos simple
relevantTo: [ios,android,cordova]
weight: 12
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
La característica de compartición de datos simple permite compartir de forma segura pequeñas cantidades de información entre una familia de aplicaciones en un único dispositivo.
Esta característica utiliza las API nativas que ya están presentes en los distintos SDK móviles para proporcionar una API de desarrollador unificada.
Esta API de {{ site.data.keys.product_adj }} permite abstraerse de las distintas complejidades de cada plataforma, facilitando a los desarrolladores una implementación de código rápida que permite una comunicación entre aplicaciones.


Se da soporte a esta característica tanto en iOS como en Android, tanto para aplicaciones nativas como de Cordova.


Después de habilitar la característica de compartición de datos simple, utilice las API nativas y de Cordova que se proporcionan para intercambiar señales de series simples entre una familia de aplicaciones en un dispositivo.


#### Ir a 
{: #jump-to}
* [Terminología](#terminology)
* [Habilitación de la característica de compartición de datos simple](#enabling-the-simple-data-sharing-feature)
* [Conceptos de API de compartición de datos simple](#simple-data-sharing-api-concepts)
* [Limitaciones y consideraciones](#limitations-and-considerations)

## Terminología
{: #terminology }
### Familia de aplicaciones de {{ site.data.keys.product_adj }}
{: #mobilefirst-application-family }
Una familia de aplicaciones es una forma de asociar un grupo de aplicaciones que comparten el mismo nivel de confianza.
Las aplicaciones en la misma familia pueden compartir información de forma segura y protegida entre sí.


Para ser considerado parte de la misma familia de aplicaciones de {{ site.data.keys.product_adj }}, todas las aplicaciones en la misma familia deben cumplir con los siguientes requisitos:


* Especificar el mismo valor para la familia de aplicaciones en el descriptor de aplicación.

	* Para aplicaciones iOS, este requisito es sinónimo del valor de titularidad de grupo de acceso.

	* Para aplicaciones Android, este requisito es sinónimo del valor **sharedUserId** en el archivo **AndroidManifest.xml**.


    > **Nota:** En Android, el nombre debe tener el formato **x.y**.


* Las aplicaciones deben estar firmadas por la misma identidad de firma.
Este requisito significa que solo aplicaciones de la misma organización pueden utilizar esta característica.

    * Para aplicaciones iOS, este requisito significa que el mismo prefijo de ID de aplicación, perfil de aprovisionamiento e identidad de firma se utilizan para firmar la aplicación.

	* Para aplicaciones Android, este requisito significa la misma clave y certificado de firma.


Además de las API de {{ site.data.keys.product }} que se proporcionan, las aplicaciones en la misma familia de aplicaciones de {{ site.data.keys.product_adj }} pueden utilizar las API de compartición de datos que están disponibles a través de sus respectivas API de SDK de móvil nativas.


### Señales de serie
{: #string-tokens }
La compartición de señales de serie en las aplicaciones de la misma familia de {{ site.data.keys.product_adj }} se puede lograr ahora en aplicaciones Android e iOS nativas o híbridas a través de la característica de compartición de datos simple.


Las señales de serie se consideran como series simples como, por ejemplo, contraseñas o cookies.
La utilización de series largas dan lugar a una considerable degradación del rendimiento.


Considere la utilización de señales cifradas al utilizar las API para añadir una mayor seguridad.


> Para obtener más información, consulte [Programas de utilidad de seguridad de JSONStore](../jsonstore/security-utilities/). 

## Habilitación de la característica de compartición de datos simple
{: #enabling-the-simple-data-sharing-feature }
Independientemente de si su aplicación es nativa o se basa en Cordova, las siguientes instrucciones se aplican a ambas.
  
Abra su aplicación en Xcode/Android Studio y: 

### iOS
{: #ios }
1. En Xcode, añada un grupo de acceso de cadena de claves con un nombre exclusivo para todas las aplicaciones que desee que sean parte de la misma familia.
La titularidad del identificador de aplicaciones debe ser el mismo para todas las aplicaciones en la familia.

2. Asegúrese de que las aplicaciones que son parte de la misma familia comparten el mismo prefijo de ID de aplicación.
Para obtener más información, consulte 3. Gestión de varios prefijos de ID de aplicación en iOS Developer Library.

4. Guarde y firme las aplicaciones.
Asegúrese de que todas las aplicaciones en este grupo se firman con los mismos perfiles de aprovisionamiento y certificados de iOS.

5. Repita los pasos para todas las aplicaciones que desea sean parte de la misma familia de aplicaciones.


Ahora podrá utilizar las API de compartición de datos simple para compartir series simples entre el grupo de aplicaciones en la misma familia.


### Android
{: #android }
1. Habilite la opción de compartición de datos simple especificando el nombre de la familia de aplicaciones como el elemento **android:sharedUserId** en la etiqueta manifest de su archivo **AndroidManifest.xml**.
Por ejemplo:


   ```xml
   <manifest xmlns:android="http://schemas.android.com/apk/res/android" package="com.myApp1"
        android:versionCode="1"
        android:versionName="1.0"
        android:sharedUserId="com.myGroup1">
   ```

2. Asegúrese de que las aplicaciones que son parte de la misma familia se firmen con las mismas credenciales de firma.

3. Desinstale cualquier versión anterior de aplicaciones que no especificaban un **sharedUserId** o que utilizaban un **sharedUserId** diferente.

4. Instale la aplicación en el dispositivo.

5. Repita los pasos para todas las aplicaciones que desea sean parte de la misma familia de aplicaciones.


Ahora podrá utilizar las API de compartición de datos que se proporcionan para compartir series simples entre el grupo de aplicaciones en la misma familia.


## Conceptos de API de compartición de datos simple
{: #simple-data-sharing-api-concepts }
Las API de compartición de datos simple permiten a las aplicaciones de la misma familia establecer, obtener y borrar parejas de clave-valor en un lugar común.
Las API de compartición de datos simple son similares en cada plataforma y proporcionan una capa de abstracción, ocultando las complejidades que existen con las API de los SDK nativos, facilitando su uso.


Los siguientes ejemplos muestran cómo establecer, obtener y suprimir señales de un almacenamiento de credenciales compartido para distintos entornos. 

### JavaScript
{: #javascript }
```javascript
WL.Client.setSharedToken({key: myName, value: myValue})
WL.Client.getSharedToken({key: myName})
WL.Client.clearSharedToken({key: myName})
```

> Para obtener más información sobre las API de Cordova, consulte las funciones [getSharedToken](../../api/client-side-api/javascript/client/), [setSharedToken](../../api/client-side-api/javascript/client/) y [clearSharedToken](../../api/client-side-api/javascript/client/) en la referencia de API `WL.Client`.
### Objective-C
{: #objective-c }
```objc
[WLSimpleDataSharing setSharedToken: myName value: myValue];
NSString* token = [WLSimpleDataSharing getSharedToken: myName]];
[WLSimpleDataSharing clearSharedToken: myName];
```

> Para obtener más información sobre las API de Objective-C, consulte la clase [WLSimpleDataSharing](../../api/client-side-api/objc/client/) en la referencia de API.


### Java
{: #java }
```java
WLSimpleSharedData.setSharedToken(myName, myValue);
String token = WLSimpleSharedData.getSharedToken(myName);
WLSimpleSharedData.clearSharedToken(myName);
```

> Para obtener más información sobre las API de Java, consulte la clase [WLSimpleDataSharing](../../api/client-side-api/java/client/) en la referencia de API.


## Limitaciones y consideraciones
{: #limitations-and-considerations }
### Consideraciones de seguridad
{: #security-considerations }
Puesto que esta característica permite acceder a los datos para un grupo de aplicaciones, se debe tener un cuidado especial para proteger el acceso al dispositivo desde usuarios no autorizados.
Considere los siguientes aspectos sobre la seguridad:

#### Bloqueo de dispositivo
{: #device-lock }
Para una mayor seguridad, asegúrese de que los dispositivos están protegidos mediante contraseñas, códigos o pin de forma que el acceso al dispositivo esté protegido incluso cuando se pierde o es robado.


#### Detección de Jailbreak
{: #jailbreak-detection }
Considere utilizar una solución de gestión de dispositivo móvil que asegure que no se realizan operaciones de jailbreak o root sobre dicho dispositivo.


#### Cifrado
{: #encryption }
Para una mayor seguridad, considere cifrar todas las señales antes de compartirlas.
Para obtener más información, consulte programas de utilidad de seguridad de JSONStore.


### Limite de tamaño
{: #size-limit }
Esta característica está pensada para compartir series pequeñas como, por ejemplo, contraseñas o cookies.
Intente no utilizar esta característica con otros propósitos puesto que puede afectar al rendimiento al cifrar, descifrar, leer o escribir grandes cantidades de datos.


### Retos de mantenimiento
{: #maintenance-challenges }
Los desarrolladores de Android deben saber que al habilitar esta característica, o al cambiar el valor de la familia de aplicaciones, dará lugar a la imposibilidad de actualizar aplicaciones existentes que se instalaron bajo un nombre diferente.
Por razones de seguridad, es necesario desinstalar aplicaciones anteriores antes de poder instalar aplicaciones bajo el nuevo nombre de familia.

