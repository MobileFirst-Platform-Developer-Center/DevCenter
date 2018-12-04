---
layout: tutorial
title: Información adicional
breadcrumb_title: additional information
relevantTo: [ios]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
### Trabajar con bitcode en aplicaciones iOS
{: #working-with-bitcode-in-ios-apps }
* No se da soporte a la comprobación de la seguridad de autenticación de aplicación con bitcode.

* Las aplicaciones watchOS precisan que el bitcode esté habilitado. 

Para habilitar el bitcode, en su proyecto Xcode vaya al separador **Valores de compilación** y establezca **Habilitar bitcode** en **Sí**.

### Imposición de conexiones seguras TLS en aplicaciones iOS
{: #enforcing-tls-secure-connections-in-ios-apps }
A partir de iOS 9, se obliga a utilizar el protocolo TLS (Transport Layer Security) versión 1.2 en todas las aplicaciones.
Existe la posibilidad de inhabilitar este protocolo y omitir el requisito de iOS 9 a efectos de desarrollo.


ATS (Apple App Transport Security) es una nueva característica de iOS 9 que obliga a utilizar los procedimientos recomendados para conexiones entre la aplicación y el servidor.
De forma predeterminada, esta característica impone algunos requisitos de conexión que mejoran la seguridad.
Entre otros, se incluye la utilización de cifradores de conexión y de certificados del lado del servidor y solicitudes HTTPS del lado del cliente que se adhieren a TLS (Transport Layer Security) versión 1.2 utilizando la propiedad de secreto adelante ("forward secrecy").


Para **fines de desarrollo**, puede alterar temporalmente el comportamiento predeterminado especificando una excepción en el archivo de su aplicación info.plist, tal como se describe en App Transport Security Nota técnica. Sin embargo, en un entorno de **producción completa**, todas las aplicaciones iOS deben imponer conexiones seguras TLS para que funcionen correctamente.


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


### Habilitación de OpenSSL para iOS
{: #enabling-openssl-for-ios }
{{ site.data.keys.product_adj }} iOS SDK utiliza API iOS nativas para la criptografía.
Configure {{ site.data.keys.product_full }} para utilizar la biblioteca de criptografía de OpenSSL en aplicaciones iOS.


El cifrado/descifrado se proporciona con las siguientes API:
`WLSecurityUtils.encryptText()` y `WLSecurityUtils.decryptWithKey()`.

#### Opción 1: Cifrado y descifrado nativo
{: #option-1-native-encryption-and-decryption }
El cifrado y el descifrado nativo se proporciona de forma predeterminada, sin utilizar OpenSSL.
Esto es equivalente a configurar de forma explícita el comportamiento de cifrado o descifrado tal como sigue:


```xml
WLSecurityUtils enableOSNativeEncryption:YES
```

#### Opción 2: Habilitación OpenSSL
{: #option-2-enabling-openssl }
OpenSSL está inhabilitado de forma predeterminada.
Siga estos pasos para habilitarlo:


1. Instalar OpenSSL en las infraestructuras:

    * Con CocoaPods: Instalar el pod `IBMMobileFirstPlatformFoundationOpenSSLUtils` con CocoaPods.
    * Manualmente en Xcode: Enlazar las infraestructuras OpenSSL y `IBMMobileFirstPlatformFoundationOpenSSLUtils` de forma manual en la sección de Enlazar binario con bibliotecas del separador Fases de la compilación.

2. El siguiente código habilita la opción OpenSSL para el cifrado/descifrado:


   ```xml
   WLSecurityUtils enableOSNativeEncryption:NO
   ```
    
   El código ahora utilizará la implementación OpenSSL si se encuentra, de lo contrario, lanzará un error si las infraestructuras no están instaladas de forma correcta.


Con esta configuración, las llamadas de cifrado/descifrado utilizan OpenSSL como en versiones anteriores del producto.


### Opciones de migración
{: #migration-options }
Si tiene un proyecto {{ site.data.keys.product_adj }} escrito en una versión anterior, podría necesitar incorporar cambios para continuar utilizando OpenSSL.

    * Si la aplicación no está utilizando las API de cifrado/descifrado y no se colocan datos cifrado en la caché del dispositivo, no es necesaria acción alguna.

    * Si la aplicación está utilizando API de cifrado/descifrado, tiene la opción de utilizar estas API con o sin OpenSSL.


#### Migración al cifrado de nativo
{: #migrating-to-native-encryption }
1. Asegúrese de que se elige la opción de cifrado/descifrado nativo (consulte la Opción 1).
2. Migración de datos en caché: Si la instalación anterior de {{ site.data.keys.product_full }} guardó datos cifrados del dispositivo mediante OpenSSL,
las infraestructuras de OpenSSL deben estar instaladas tal como se describen en la Opción 2.
La primera vez que la aplicación intenta descifrar los datos volverá de nuevo a OpenSSL y, a continuación, cifrará los datos con el cifrado nativo.  Si la infraestructura de OpenSSL no está instalada, se lanza un error.
De esta forma, los datos se migrarán de forma automática al cifrado nativo permitiendo que releases posteriores funcionen sin la infraestructura de OpenSSL.


#### Continuando con OpenSSL
{: #continuing-with-openssl }
Si se necesita utilizar OpenSSL, utilice la configuración descrita en la Opción 2.

