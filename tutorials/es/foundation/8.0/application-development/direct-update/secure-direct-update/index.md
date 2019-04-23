---
layout: tutorial
title: Implementación de Direct Update seguro
breadcrumb_title: Secure Direct Update
relevantTo: [cordova]
weight: 2
---

## Visión general
{: #overview }
Para que Direct Update funcione, se debe desplegar un archivo de almacén de claves definido por el usuario en {{ site.data.keys.mf_server }}. Además, es necesario incluir una copia de la clave pública correspondiente en la aplicación de cliente desplegada.

En este tema se describe cómo vincular una clave pública a nuevas aplicaciones de cliente y a aplicaciones de cliente existentes que se hayan actualizado. Para obtener más información sobre cómo configurar el almacén de claves en {{ site.data.keys.mf_server }}, consulte [Configuración del almacén de claves de {{ site.data.keys.mf_server }}](../../../authentication-and-security/configuring-the-mobilefirst-server-keystore/).

El servidor incorpora un almacén de claves que sirve para probar Direct Update de forma segura en las fases de desarrollo.

**Nota: **
Después de vincular la clave pública con la aplicación de cliente y de recompilarla, no necesita subirla de nuevo a {{ site.data.keys.mf_server }}. Sin embargo, si con anterioridad publicó la aplicación en el mercado, sin la clave pública, necesitará publicarla de nuevo.

A efectos de desarrollo, se proporciona con {{ site.data.keys.mf_server }} la siguiente clave pública de pruebas predeterminada:

```xml
-----BEGIN PUBLIC KEY-----
MIIDPjCCAiagAwIBAgIEUD3/bjANBgkqhkiG9w0BAQsFADBgMQswCQYDVQQGEwJJTDELMAkGA1UECBMCSUwxETA
PBgNVBAcTCFNoZWZheWltMQwwCgYDVQQKEwNJQk0xEjAQBgNVBAsTCVdvcmtsaWdodDEPMA0GA1UEAxMGV0wgRG
V2MCAXDTEyMDgyOTExMzkyNloYDzQ3NTAwNzI3MTEzOTI2WjBgMQswCQYDVQQGEwJJTDELMAkGA1UECBMCSUwxE
TAPBgNVBAcTCFNoZWZheWltMQwwCgYDVQQKEwNJQk0xEjAQBgNVBAsTCVdvcmtsaWdodDEPMA0GA1UEAxMGV0wg
RGV2MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAzQN3vEB2/of7KAvuvyoIt0T7cjaSTjnOBm0N3+q
zx++dh92KpNJXj/a3o4YbwJXkJ7jU8ykjCYvjXRf0hme+HGhiIVwxJo54iqh76skDS5m7DaseFdndZUJ4p7NFVw
I5ixA36ZArSZ/Pn/ej56/RRjBeRI7AEGXUSGojBUPA6J6DYkwaXQRew9l+Q1kj4dTigyKL5Os0vNFaQyYu+bT2E
vnOixQ0DXm94IqmHZamZKbZLrWcOEfuAsSjKYOdMSM9jkCiHaKcj7fpEZhUxRRs7joKs1Ri4ihs6JeUvMEiG4gK
l9V3FP/Huy0pfkL0F8xMHgaQ4c/lxS/s3PV0OEg+7wIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQAgEhhqRl2Rgkt
MJeqOCRcT3uyr4XDK3hmuhEaE0nOvLHi61PoLKnDUNryWUicK/W+tUP9jkN5xRckdzG6TJ/HPySmZ7Adr6QRFu+
xcIMY+/S8j4PHLXBjoqgtUMhkt7S2/thN/VA6mwZpw4Ol0Pa2hyT2TkhQoYYkRwYCk9pxmuBCoH/eCWpSxquNny
RwrY25x0YzccXUaMI8L3/3hzq3mW40YIMiEdpiD5HqjUDpzN1funHNQdsxEIMYsWmGAwOdV5slFzyrH+ErUYUFA
pdGIdLtkrhzbqHFwXE0v3dt+lnLf21wRPIqYHaEu+EB/A4dLO6hm+IjBeu/No7H7TBFm
-----END PUBLIC KEY-----
```

> Importante: No utilice la clave pública a efectos de producción.

## Generación y despliegue del almacén de claves
{: #generating-and-deploying-the-keystore }
Hay muchas herramientas disponibles para generar certificados y extraer las claves públicas de un almacén de claves. En el siguiente ejemplo se muestran los procedimientos con el programa de utilidad keytool del JDK y openSSL.

1. Extraiga la clave pública del archivo de almacén de claves que se ha desplegado en {{ site.data.keys.mf_server }}.  
   Nota: La clave pública debe estar codificada en Base64.
    
   Por ejemplo, supongamos que el nombre de alias es `mfp-server` y que el archivo del almacén de claves es **keystore.jks**.  
   Para generar un certificado, emita el siguiente mandato:
    
   ```bash
   keytool -export -alias mfp-server -file certfile.cert
   -keystore keystore.jks -storepass keypassword
   ```
    
   Se genera un archivo de certificado.  
   Emita el siguiente mandato para extraer la clave pública:
    
   ```bash
   openssl x509 -inform der -in certfile.cert -pubkey -noout
   ```
    
   **Nota:** Con únicamente la herramienta de claves no es posible extraer claves públicas en formato Base64.
    
2. Siga uno de los siguientes procedimientos:
    * Copie el texto resultante, sin los marcadores `BEGIN PUBLIC KEY` y `END PUBLIC KEY` en el archivo de propiedades mfpclient de la aplicación, inmediatamente después de `wlSecureDirectUpdatePublicKey`.
    * Desde el indicador de mandatos, emita el siguiente mandato:
`mfpdev app config direct_update_authenticity_public_key <public_key>`
    
    Para `<public_key>`, pegue el texto que se obtiene del Paso 1, sin los marcadores `BEGIN PUBLIC KEY` y `END PUBLIC KEY`.

3. Ejecute el mandato cordova build para guardar la clave pública en la aplicación.


