---
layout: tutorial
title: Fijación de certificados
relevantTo: [ios,android,cordova]
weight: 13
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
Al comunicar con redes públicas, es esencial enviar y recibir información de forma segura. El protocolo más usado para asegurar estas comunicaciones es SSL/TLS. (SSL/TLS hace referencia a Secure Sockets Layer o a su sucesor, TLS o Transport Layer Security). SSL/TLS utiliza certificados digitales para proporcionar autenticación y cifrado. Para asegurar que un certificado es genuino o válido, un certificado raíz perteneciente a la autoridad de certificado de confianza (CA) lo firma digitalmente. Los sistemas operativos y navegadores mantienen listas de certificados raíz CA de confianza para que puedan verificar fácilmente los certificados que los CA han emitido y firmado. 

Los protocolos que se basan en la verificación de cadenas de certificado como, por ejemplo, SSL/TLS, son vulnerables a un número de ataques peligrosos, incluidos los ataques intermediarios, que se producen cuando una parte autorizada puede visualizar y modificar todo el tráfico que pasa entre el dispositivo móvil y los sistemas de fondo. 

{{ site.data.keys.product_full }} proporciona una API para habilitar la **fijación de certificados**. Se soporta en iOS nativo, Android nativo y las aplicaciones de {{ site.data.keys.product_adj }} Cordova entre aplicaciones.

## Proceso de fijación de certificados
{: #certificate-pinning-process }
La fijación de certificados es el proceso de asociar un host con la clave pública esperada que le corresponde. Como tiene el código del lado del servidor y el código del lado del cliente, puede configurar el código de cliente para que acepte solo certificados específicos para su nombre de dominio, en lugar de cualquier certificado que corresponda a una raíz CA de confianza reconocida por el sistema operativo o por el navegador.
Una copia del certificado se coloca en la aplicación cliente. Durante el reconocimiento SSL (primera solicitud al servidor), el SDK del cliente {{ site.data.keys.product_adj }} verifica que la clave pública del certificado de servidor coincide con la clave pública del certificado que se almacena en la aplicación.

También puede fijar varios certificados con su aplicación cliente. Debe colocarse una copia de todos los certificados en la aplicación de cliente.Durante el reconocimiento SSL (primera solicitud al servidor), el SDK del cliente {{ site.data.keys.product_adj }} verifica que la clave pública del certificado de servidor coincide con la clave pública de uno de los certificados que se almacena en la aplicación.

#### Importante
{: #important }
* Es posible que algunos sistemas operativos móviles guarden en caché el resultado de la comprobación de la validación de certificado. Por lo tanto, el código debería llamar el método de API de fijación de certificados **antes** de realizar una solicitud asegurada. De lo contrario, es posible que cualquier solicitud posterior omita la validación de certificado y la comprobación de fijación.
* Asegúrese de utilizar solo las API de {{ site.data.keys.product }} para todas las comunicaciones con el host relacionado, incluso después de la fijación de certificados. Es posible que la utilización de API de terceros para interaccionar con el mismo host provoque comportamientos inesperados como, por ejemplo, que un sistema operativo móvil almacene en memoria caché un certificado no verificado. 
* Si se vuelve a llamar el método API de fijación de certificados, se sustituye la operación de fijación previa.

Si el proceso de fijación se realiza correctamente, la clave pública que se encuentra en el certificad o proporcionado se utiliza para verificar la integridad del certificado de {{ site.data.keys.mf_server }} durante el reconocimiento SSL/TLS de la solicitud asegurada. Si el proceso de fijación falla, la aplicación de cliente rechaza todas las solicitudes SSL/TLS que se hagan al servidor.

## Configuración del certificado
{: #certificate-setup }
Debe utilizar un certificado obtenido de una entidad emisora. **No se da soporte** a los certificados autofirmados. Para obtener compatibilidad con los entornos soportados, asegúrese de que el certificado está codificado en formato **DER** (Reglas de codificación distinguida, tal y como se define en la Unión Internacional de Telecomunicaciones X.690 estándar). 

El certificado debe colocarse en {{ site.data.keys.mf_server }} y en la aplicación. Coloque el certificado de la siguiente manera:

* En {{ site.data.keys.mf_server }} (WebSphere  Application Server, WebSphere Application Server Liberty, o Apache Tomcat): Consulte la documentación para obtener información acerca de cómo configurar SSL/TLS y los certificados de su servidor de aplicaciones específico.
* En la aplicación:
    - iOS nativo: añada el certificado en el **paquete** de aplicación
    - Android nativo: coloque el certificado en la carpeta de **activos**
    - Cordova: coloque el certificado en la carpeta **app-name\www\certificates** (si la carpeta no existe, créela)

## API de fijación de certificados
{: #certificate-pinning-api }
La fijación de certificados consiste en el siguiente método API de sobrecarga, en el que un método tiene un parámetro `certificateFilename`, en el que `certificateFilename` es el nombre del archivo de certificado, y el segundo método tiene un parámetro `certificateFilenames`, en el que `certificateFilenames` es una matriz de los archivos de certificado.

### Android
{: #android }
Certificado único:
Sintaxis:
pinTrustedCertificatePublicKeyFromFile(String certificateFilename);
Ejemplo:
```java
WLClient.getInstance().pinTrustedCertificatePublicKey("myCertificate.cer");
```
Varios certificados:

Sintaxis:
pinTrustedCertificatePublicKeyFromFile(String[] certificateFilename);
Ejemplo:
```java
String[] certificates={"myCertificate.cer","myCertificate1.cer"};
WLClient.getInstance().pinTrustedCertificatePublicKey(certificates);
```
El método de fijación de certificados provocará una excepción en dos casos:
* El archivo no existe
* El formato del archivo no es correcto


### iOS
{: #ios }
Sintaxis de fijación de certificado único:
pinTrustedCertificatePublicKeyFromFile:(NSString*) certificateFilename;

El método de fijación de certificados provocará una excepción en dos casos:

* El archivo no existe
* El formato del archivo no es correcto

Sintaxis de fijación de varios certificados:
pinTrustedCertificatePublicKeyFromFiles:(NSArray*) certificateFilenames;

El método de fijación de certificados provocará una excepción en dos casos:

* No existe ninguno de los archivos de certificado
* El formato de los archivos de certificado no es correcto

**En Objective-C:**
Ejemplo:
Certificado único:
```objc
[[WLClient sharedInstance]pinTrustedCertificatePublicKeyFromFile:@"myCertificate.cer"];

```
Varios certificados:
Ejemplo:
```objc
NSArray *arrayOfCerts = [NSArray arrayWithObjects:@“Cert1”,@“Cert2”,@“Cert3",nil];
[[WLClient sharedInstance]pinTrustedCertificatePublicKeyFromFiles:arrayOfCerts];
```

**En Swift:**

Certificado único:
Ejemplo:
```swift
WLClient.sharedInstance().pinTrustedCertificatePublicKeyFromFile("myCertificate.cer")
```
Varios certificados:
Ejemplo:
```swift
let arrayOfCerts : [Any] = ["Cert1", "Cert2”, "Cert3”];
WLClient.sharedInstance().pinTrustedCertificatePublicKey( fromFiles: arrayOfCerts)
```

El método de fijación de certificados provocará una excepción en dos casos:


* El archivo no existe
* El formato del archivo no es correcto

### Cordova
{: #cordova }

Fijación de certificado único:

```javascript
WL.Client.pinTrustedCertificatePublicKey('myCertificate.cer').then(onSuccess, onFailure);
```

Fijación de varios certificados:

```javascript
WL.Client.pinTrustedCertificatePublicKey(['Cert1.cer','Cert2.cer','Cert3.cer']).then(onSuccess, onFailure);
```

El método de fijación de certificados devuelve un compromiso:

* El método de fijación de certificados llamará el método onSuccess en caso de que la fijación se realice correctamente.
* El método de fijación de certificados desencadenará la devolución de llamada de onFailure en dos casos:
* El archivo no existe
* El formato del archivo no es correcto

A continuación, si se realiza una solicitud asegurada al servidor cuyo certificado no está fijado, se llama a la devolución de llamada `onFailure` de la solicitud específica (por ejemplo, `obtainAccessToken` o `WLResourceRequest`).

> Obtenga más información acerca del método API de fijación de certificados [Referencia de API](../../api/client-side-api/)
