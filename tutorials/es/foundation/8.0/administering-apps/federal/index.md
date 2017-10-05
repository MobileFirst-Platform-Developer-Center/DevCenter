---
layout: tutorial
title: Soporte de estándares federales de EE.UU. en MobileFirst Foundation
breadcrumb_title: Soporte de estándares federales
weight: 5
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
{{ site.data.keys.product_full }} da soporte a las especificaciones Federal Desktop Core Configuration (FDCC) y United States Government Configuration Baseline (USGCB).
{{ site.data.keys.product }} también da soporte a los Federal Information Processing Standards (FIPS) 140-2, que es un estándar de seguridad que se utiliza para acreditar módulos criptográficos.


#### Ir a 
{: #jump-to }

* [Soporte a FDCC y USGCB](#fdcc-and-usgcb-support)
* [Soporte a FIPS-140-2](#fips-140-2-support)
* [Habilitación de FIPS 140-2](#enabling-fips-140-2)
* [Configuración de la modalidad FIPS 140-2 para cifrado JSONStore y HTTPS](#configure-fips-140-2-mode-for-https-and-jsonstore-encryption)
* [Configuración de FIPS 140-2 para las aplicaciones existentes](#configuring-fips-140-2-for-existing-applications)

## Soporte a FDCC y USGCB
{: #fdcc-and-usgcb-support }
El gobierno federal de los Estados Unidos obliga a que los escritorios de las agencias federales que se ejecutan en plataformas Microsoft Windows adapten la Federal Desktop Core Configuration (FDCC) o la nueva configuración de seguridad United States Government Configuration Baseline (USGCB). 

IBM Worklight V5.0.6 se ha probado utilizando los valores de seguridad de USGCB y FDCC a través de un proceso de autocertificación. La realización de estas pruebas incluye un nivel razonable de verificación para asegurarse de que la instalación y las características principales funcionan en esta configuración. 

#### Referencias
{: #references }
Para obtener más información, consulte [USGCB](http://usgcb.nist.gov/).

## Soporte a FIPS 140-2
{: #fips-140-2-support }
Los estándares FIPS (Federal Information
Processing Standards) son estándares y directrices emitidos por el NIST (National Institute of Standards and Technology) de Estados Unidos para los sistemas de equipos informáticos del gobierno federal.
La Publicación de FIPS 140-2 es un estándar de seguridad que se utiliza para acreditar módulos criptográficos.{{ site.data.keys.product }} proporciona soporte a FIPS 140-2 para aplicaciones Android e iOS.


### FIPS 140-2 en {{ site.data.keys.mf_server }} y las comunicaciones SSL con {{ site.data.keys.mf_server }}
{: #fips-140-2-on-the-mobilefirst-server-and-ssl-communications-with-the-mobilefirst-server }
{{ site.data.keys.mf_server }} se ejecuta en un servidor de aplicaciones, como por ejemplo el WebSphere Application Server.
WebSphere Application Server se puede configurar para hacer que se utilicen módulos criptográficos FIPS 140-2 válidos para conexiones de entrada y salida de Secure Socket Layer (SSL).
Los módulos criptográficos también se utilizan para las operaciones criptográficas que las aplicaciones realizan mediante JCE (Java Cryptography Extension).
Puesto que {{ site.data.keys.mf_server }} es una aplicación que se ejecuta en el servidor de aplicaciones, utiliza módulos criptográficos válidos FIPS 140-2 para conexiones SSL de entrada y salida.

Cuando un cliente de {{ site.data.keys.product_adj }} gestiona una conexión de SSL a {{ site.data.keys.mf_server }}, que se ejecuta en un servidor de aplicaciones que está utilizando el modo de FIPS 140-2, los resultados son el uso correcto del conjunto de cifrado aprobado FIPS 140-2.
Si la plataforma de cliente no da soporte a ningún conjunto de cifrado aprobado FIPS 140-2, la transacción SSL fallará y el cliente no podrá establecer la conexión SSL con el servidor.
Si se realiza correctamente, el cliente utiliza un conjunto de cifrado aprobado FIPS 140-2. 

> **Nota:** Las instancias del módulo criptográfico que se utilizan en el cliente no están necesariamente validadas de acuerdo a FIPS 140-2.
Consulte más abajo para conocer qué opciones hay para utilizar bibliotecas validadas FIPS 140-2 en dispositivos de cliente.

Específicamente, el cliente y el servidor están utilizando el mismo conjunto de cifrado (SSL_RSA_WITH_AES_128_CBC_SHA, por ejemplo), pero el módulo criptográfico de cifrado de cliente tal vez no ejecutó el proceso de validación FIPS 140-2, mientras que el servidor está utilizando módulos certificado FIPS 140-2.


### FIPS 140-2 en el dispositivo de cliente de {{ site.data.keys.product_adj }} para la protección de datos que ya no se modifican en JSONStore y datos en reposo al utilizar comunicaciones HTTPS
{: #fips-140-2-on-the-mobilefirst-client-device-for-protection-of-data-at-rest-in-jsonstore-and-data-in-motion-when-using-https-communications }
Una protección de datos en el dispositivo de cliente lo proporciona una función de JSONStore de {{ site.data.keys.product }}.
La utilización de la comunicación HTTPS ente el cliente de {{ site.data.keys.product_adj }} y {{ site.data.keys.mf_server }} protege los datos en reposo.


En dispositivos iOS, de forma predeterminada se proporciona el soporte FIPS 140-2 tanto para los datos que ya no se modifican y los datos en reposo.


De forma predeterminada, los dispositivos Android utilizan bibliotecas validadas no FIPS 140-2.
Existe una opción para utilizar bibliotecas validadas FIPS 140-2 para la protección (cifrado y descifrado) de los datos locales que se almacenan en JSONStore y para la comunicación HTTPS para {{ site.data.keys.mf_server }}.
Este soporte se consigue utilizando una biblioteca OpenSSL que se alcanza la validación de FIPS 140-2 (Certificado número 1747).
Para habilitar esta opción en un proyecto de cliente de {{ site.data.keys.product_adj }}, añada el plugin opcional FIPS 140-2 de Android.


**Nota:** Existen algunas limitaciones que debe conocer:


* Este modo de FIPS 140-2 validado se aplica únicamente a la protección (cifrado) de los datos locales que se almacena por la característica de JSONStore y la protección de comunicaciones HTTPS entre el cliente de {{ site.data.keys.product_adj }} y {{ site.data.keys.mf_server }}.
* Esta característica sólo está soportada en las plataformas iOS y Android.
    * En Android, sólo se da soporte a esta característica en dispositivos o simuladores que utilizan arquitecturas x86 o armeabi.
En cambio, no está soportada en Android que utiliza arquitecturas armv5 o armv6.
Esto se debe a que la biblioteca OpenSSL utilizada no obtuvo la validación de FIPS 140-2 para armv5 o armv6 en Android.
FIPS 140-2 no está soportado en la arquitectura de 64 bits, aunque la biblioteca de {{ site.data.keys.product_adj }} da soporte a la arquitectura de 64 bits.
FIPS 140-2 se puede ejecutar en dispositivos de 64 bits si el proyecto incluye únicamente bibliotecas NDK nativas de 32 bits.

    * En iOS, se soporta en arquitecturas i386, x86_64, armv7, armv7s y arm64.

* Esta característica funciona con aplicaciones híbridas únicamente (no con aplicaciones nativas).
* Para iOS nativo, FIPS está habilitado a través de las bibliotecas iOS FIPS y está habilitado de forma predeterminada.
No es necesaria ninguna acción para habilitar FIPS 140-2.

* Para las comunicaciones HTTPS:
    * Para dispositivos Android, sólo las comunicaciones entre el cliente de {{ site.data.keys.product_adj }} y {{ site.data.keys.mf_server }} utilizan las bibliotecas FIPS 140-2 en el cliente.
Las conexiones directas con otros servidores o servicios no utilizan las bibliotecas de FIPS 140-2.

    * El cliente de {{ site.data.keys.product_adj }} únicamente se puede comunicar con una instancia de {{ site.data.keys.mf_server }} que se ejecute en entornos soportados, que se listan en los [Requisitos del sistema](http://www-01.ibm.com/support/docview.wss?uid=swg27024838).
Si {{ site.data.keys.mf_server }} se ejecuta en un entorno no soportado, la conexión HTTPS podría fallar con un error de tamaño de clave demasiado pequeño.
Este error no se produce en las comunicaciones HTTP.

* El cliente de {{ site.data.keys.mf_app_center_full }} no da soporte a la característica FIPS 140-2.


Si ya ha realizado anteriormente los cambios que se describen en la guía de aprendizaje, primero debe guardar cualquier otro cambio específico del entorno que haya realizado y, a continuación, suprimir y volver a crear sus entornos iOS o Android.


![Diagrama FIPS](FIPS.jpg)

> Para obtener información sobre JSONStore, consulte [Visión general de JSONStore](../../application-development/jsonstore).

## Referencias
{: #references-1 }
Para obtener información sobre cómo habilitar la modalidad FIPS 140-2 en WebSphere Application Server, consulte [Soporte a Federal Information Processing Standard](http://ibm.biz/knowctr#SSAW57_8.5.5/com.ibm.websphere.nd.multiplatform.doc/ae/rovr_fips.html).

En el perfil de WebSphere Application Server Liberty, no hay disponible una opción en la consola administrativa para habilitar la modalidad FIPS 140-2.
Sin embargo, puede habilitar FIPS 140-2 configurando el entorno de tiempo de ejecución Java para que utilice módulos validados para FIPS 140-2.
Para obtener más información, consulte la Java Secure Socket Extension (JSSE) IBMJSSE2 Provider Reference Guide.

## Habilitación de FIPS 140-2
{: #enabling-fips-140-2 }
En dispositivos iOS, de forma predeterminada se proporciona el soporte FIPS 140-2 tanto para los datos que ya no se modifican y los datos en reposo.
  
En dispositivos Android, añada el plugin de Cordova `cordova-plugin-mfp-fips`.


Una vez añadida, la característica se aplica tanto al cifrado de datos de JSONStore como a HTTPS.


**Nota:** 

* Únicamente se da soporte a FIPS 140-2 en Android a iOS.
Las arquitecturas iOS que dan soporte a FIPS 140-2 son i386, armv7, armv7s, x86_64 y arm64.
Las arquitecturas Android que dan soporte a FIPS 140-2 son x86 y armeambi.
* En Android, FIPS 140-2 no está soportado en la arquitectura de 64 bits, aunque la biblioteca de {{ site.data.keys.product_adj }} da soporte a la arquitectura de 64 bits.
Cuando utilice FIPS 140-2 en un dispositivo de 64 bits, podría ver el siguiente error:
 
        
```bash
java.lang.UnsatisfiedLinkError: dlopen failed: "..." is 32-bit instead of 64-bit
```

Este error significa que tiene bibliotecas nativas de 64 bits en su proyecto Android y que actualmente FIPS 140-2 no funciona al utilizar estas bibliotecas.
Para confirmarlo, vaya a src/main/libs o src/main/jniLibs bajo su proyecto Android y compruebe si tiene las carpetas x86_64 o arm64-v8a.
Si las tiene, suprima estas carpetas, y FIPS 140-2 funcionará de nuevo.


## Configuración de la modalidad FIPS 140-2 para cifrado JSONStore y HTTPS
{: #configure-fips-140-2-mode-for-https-and-jsonstore-encryption }
En las aplicaciones iOS, FIPS 140-2 se habilita a través de las bibliotecas iOS FIPS.
Están habilitadas de forma predeterminada, por lo tanto, no es necesaria ninguna acción para habilitarlas o configurarlas.


El siguiente fragmento de código se rellena para una nueva aplicación de {{ site.data.keys.product_adj }} en el objeto initOptions en index.js para el sistema operativo Android para configurar FIPS 140-2:


```javascript
var wlInitOptions = {
  ...
  // # Enable FIPS 140-2 for data-in-motion (network) and data-at-rest (JSONStore) on Android.
  //   Requires the FIPS 140-2 optional feature to be enabled also.
  // enableFIPS : false
  ...
};
```

El valor predeterminado de **enableFIPS** es `false` para el sistema operativo Android.
Para habilitar FIPS 140-2 tanto para HTTPS como para el cifrado de datos de JSONStore, descomente y establezca la opción en `true`.
Después de establecer el valor de **enableFIPS** en `true`, debería ponerse a la escucha para el suceso JavaScript FIPS ready creando un suceso de escucha similar al del siguiente ejemplo:


```javascript
document.addEventListener('WL/FIPS/READY', 
    this.onFipsReady, false);

onFipsReady: function() {
  // FIPS SDK is loaded and ready
}
```

Después de establecer el valor de la propiedad **enableFIPS**, reconstruya la plataforma Android.


**Nota: **Debe instalar el plugin Cordova FIPS antes es establecer el valor de la propiedad enableFIPS en true. De lo contrario, se registrará un mensaje de aviso que indicará que se ha establecido un valor para initOption, pero que no se ha encontrado la característica opcional.
Las características FIPS 140-2 y JSONStore son ambas opcionales en el sistema operativo Android.
FIPS 140-2 afecta al cifrado de datos JSONStore únicamente si también se ha habilitado la característica opcional JSONStore.
Si JSONStore no está habilitado, entonces FIPS 140-2 no afecta a JSONStore.
En iOS, la característica opcional FIPS 140-2 no es necesaria para JSONStore FIPS 140-2 (datos que ya no se modifican) o cifrado HTTPS (datos en reposo) porque iOS maneja a ambas características.
En Android, debe habilitar la característica opcional FIPS 140-2 si desea utilizar JSONStore FIPS 140-2 o el cifrado HTTPS.


```bash
[WARN] FIPSHttp feature not found, but initOptions enables it on startup
```

## Configuración de FIPS 140-2 para las aplicaciones existentes
{: #configuring-fips-140-2-for-existing-applications }
De forma predeterminada, la característica opcional FIPS 140-2 no está habilitada en aplicaciones creadas de cualquier versión del sistema operativo Android ni en aplicaciones iOS de versiones de {{ site.data.keys.product_full }} anteriores a la versión 8.0.
Para habilitar la característica opcional FIPS 140-2 para el sistema operativo Android, consulte Habilitación de FIPS 140-2.
Una vez la característica esté habilitada, podrá configurar FIPS 140-2.

Después de completar los pasos que se describen en Habilitación de FIPS 140-2, debe configurar FIPS 140-2 modificando el objeto initOptions en el archivo index.js para añadirle la propiedad de configuración FIPS.


**Nota:** La característica FIPS 140-2, combinada con la característica JSONStore, habilita el soporte FIPS 140-2 a JSONStore.
Esta combinación reemplaza a lo que se indicaba en la guía de aprendizaje JSONStore - Cifrado de datos confidenciales con FIPS 140-2 que estaba disponible en IBM Worklight V6.0 o anterior.
Si con anterioridad modificó una aplicación siguiendo las instrucciones de esta guía de aprendizaje, suprima y vuelva a crear sus entornos de iPhone, iPad y Android.
Puesto que los cambios específicos del entorno que realizó con anterioridad se perderán al suprimirlo, asegúrese de realizar una copia de seguridad de todos estos cambios antes de suprimir cualquier entorno.
Una vez el entorno se haya vuelto a crear, puede volver a aplicar dichos cambios al nuevo entorno.

Añada la siguiente propiedad al objeto initOptions que se encuentra en el archivo index.js.


```javascript
enableFIPS : true
```

Reconstrucción de la plataforma Android.
