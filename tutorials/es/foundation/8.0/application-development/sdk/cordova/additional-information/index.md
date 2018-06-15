---
layout: tutorial
title: Información adicional
breadcrumb_title: Additional information
relevantTo: [cordova]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
### Imposición de conexiones seguras TLS en aplicaciones iOS
{: #enforcing-tls-secure-connections-in-ios-apps }
A partir de iOS 9, se obliga a utilizar el protocolo TLS (Transport Layer Security) versión 1.2 en todas las aplicaciones.
Existe la posibilidad de inhabilitar este protocolo y omitir el requisito de iOS 9 a efectos de desarrollo.


ATS (Apple App Transport Security) es una nueva característica de iOS 9 que obliga a utilizar los procedimientos recomendados para conexiones entre la aplicación y el servidor.
De forma predeterminada, esta característica impone algunos requisitos de conexión que mejoran la seguridad.
Entre otros, se incluye la utilización de cifradores de conexión y de certificados del lado del servidor y solicitudes HTTPS del lado del cliente que se adhieren a TLS (Transport Layer Security) versión 1.2 utilizando la propiedad de secreto adelante ("forward secrecy").


A **efectos de desarrollo**, puede modificar el comportamiento predeterminado especificando una excepción en el archivo info.plist de su aplicación, tal como se describe en la nota técnica App Transport Security.
Sin embargo, en un entorno de **producción completa**, todas las aplicaciones iOS deben imponer conexiones seguras TLS para que funcionen correctamente.


Para habilitar las conexiones no TLS, la siguiente excepción debe aparece en el archivo **project-name-info.plist** en la carpeta **project-name\Resources**:


```xml
<key>NSExceptionDomains</key>
    <dict>
        <key>yourserver.com</key>
    
            <dict>
            <!--Include to allow subdomains-->
            <key>NSIncludesSubdomains</key>
            <true/>

            <!--Include to allow insecure HTTP requests-->
            <key>NSTemporaryExceptionAllowsInsecureHTTPLoads</key>
            <true/>
        </dict>
    </dict>
```

Preparación para el entorno de producción

1. Elimine o comente el código que aparece con anterioridad en esta página.
  
2. Configure el cliente para enviar solicitudes HTTPS utilizando la siguiente entrada al diccionario:
  

   ```xml
   <key>protocol</key>
   <string>https</string>

   <key>port</key>
   <string>10443</string>
   ```
   
   El número de puerto SSL se define en el servidor en el archivo **server.xml** en la definición `httpEndpoint`.

    
3. Configure un servidor que esté habilitado para el protocolo TLS 1.2.
Para obtener más información, [consulte Configuración de {{ site.data.keys.mf_server }} para habilitar TLS V1.2](http://www-01.ibm.com/support/docview.wss?uid=swg21965659).

4. Configure certificados y cifradores, a medida que se aplican a su configuración.
Para obtener más información, consulte la [Nota técnica App Transport Security](https://developer.apple.com/library/prerelease/ios/technotes/App-Transport-Security-Technote/), [Comunicaciones seguras utilizando SSL (Secure Sockets Layer) para WebSphere Application Server Network Deployment](http://www-01.ibm.com/support/knowledgecenter/SSAW57_8.5.5/com.ibm.websphere.nd.doc/ae/csec_sslsecurecom.html?cp=SSAW57_8.5.5%2F1-8-2-33-4-0&lang=en) y [Habilitación de la comunicación SSL para el perfil de Liberty](http://www-01.ibm.com/support/knowledgecenter/SSAW57_8.5.5/com.ibm.websphere.wlp.nd.doc/ae/twlp_sec_ssl.html?cp=SSAW57_8.5.5%2F1-3-11-0-4-1-0).


## Habilitación de OpenSSL en aplicaciones Cordova
{: #enabling-openssl-in-cordova-applications }
{{ site.data.keys.product_adj }} Cordova SDK para iOS utiliza las API iOS nativas para la criptografía.
Configure la aplicación para utilizar en su lugar la biblioteca de criptografía OpenSSL en su aplicación iOS de Cordova.


Las funcionalidades de cifrado/descifrado se proporcionan con las siguientes API de JavaScript:


* WL.SecurityUtils.encryptText
* WL.SecurityUtils.decryptWithKey

### Opción 1: Cifrado/descifrado nativo
{: #option-1-native-encryptiondecryption }
De forma predeterminada {{ site.data.keys.product_adj }} proporciona cifrado/descifrado nativo, sin utilizar OpenSSL.
Esto equivale a establecer de forma explícita el comportamiento de cifrado/descifrado:


* WL.SecurityUtils.enableNativeEncryption(true)

## Opción 2: Habilitación OpenSSL
{: #option-2-enabling-openssl }
La opción OpenSSL que {{ site.data.keys.product_adj }} proporciona está inhabilitada de forma predeterminada.


Para instalar todas las infraestructuras necesarias para dar soporte a OpenSSL, instale primero el plugin de Cordova:


```bash
cordova plugin add cordova-plugin-mfp-encrypt-utils
```

El siguiente código habilita la opción OpenSSL para el cifrado/descifrado:


* WL.SecurityUtils.enableNativeEncryption(false)

Con esta configuración, las llamadas de cifrado/descifrado utilizan OpenSSL como en versiones anteriores de {{ site.data.keys.product }}.


### Opciones de migración
{: #migration-options }
Si tiene un proyecto de {{ site.data.keys.product_adj }} escrito en una versión anterior del producto, podría necesitar incorporar cambios para continuar utilizando OpenSSL.


* Si la aplicación no está utilizando las API de cifrado/descifrado, y no se colocan datos cifrado en la caché del dispositivo, no es necesaria acción alguna.

* Si la aplicación está utilizando API de cifrado/descifrado tiene la opción de utilizar estas API con o sin OpenSSL.

    - **Migración al cifrado nativo:
**
        1. Asegúrese de que se elige la opción de cifrado/descifrado (consulte la **Opción 1**).
        2. **Migración de datos en caché**:
Si la instalación anterior del producto guardó datos cifrados en el dispositivo utilizando OpenSSL, y ahora se ha elegido la opción de cifrado/descifrado nativo, se descifrarán los datos almacenados.
La primera vez que la aplicación intenta descifrar los datos volverá de nuevo a OpenSSL y, a continuación, cifrará los datos con el cifrado nativo.
De esta forma, los datos se migrarán de forma automática al cifrado nativo.
**Nota:** Para permitir el descifrado desde OpenSSL, debe añadir las infraestructuras OpenSSL instalando el plugin Cordova: `cordova plugin add cordova-plugin-mfp-encrypt-utils`
    - **Continuación con OpenSSL:** Si se necesita OpenSSL utilice la configuración descrita en la **Opción 2**.

