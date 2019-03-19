---
layout: tutorial
title: Implementación de Model Update seguro
breadcrumb_title: Secure Model Update
relevantTo: [iOS]
weight: 2
---

## Visión general
{: #overview }
Para que Model Update funcione, se debe desplegar un archivo de almacén de claves definido por el usuario en {{ site.data.keys.mf_server }}. Además, es necesario incluir una copia de la clave pública correspondiente en la aplicación de cliente desplegada.

En este tema se describe cómo vincular una clave pública a nuevas aplicaciones de cliente y a aplicaciones de cliente existentes que se hayan actualizado. Para obtener más información sobre cómo configurar el almacén de claves en {{ site.data.keys.mf_server }}, consulte [Configuración del almacén de claves de {{ site.data.keys.mf_server }}](../../../authentication-and-security/configuring-the-mobilefirst-server-keystore/).

El servidor incorpora un almacén de claves que sirve para probar Model Update de forma segura en las fases de desarrollo.

>**Nota: **Después de vincular la clave pública con la aplicación de cliente y de recompilarla, no necesita subirla de nuevo a {{ site.data.keys.mf_server }}. Sin embargo, si con anterioridad publicó la aplicación y la hizo disponible de manera general, sin la clave pública, necesitará publicarla de nuevo.

A efectos de desarrollo, se proporciona con {{ site.data.keys.mf_server }} la siguiente clave pública de pruebas predeterminada:

```text
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

>**Importante**: No utilice la clave pública a efectos de producción.

## Generación y despliegue del almacén de claves
{: #generating-and-deploying-the-keystore }
Hay muchas herramientas disponibles para generar certificados y extraer las claves públicas de un almacén de claves. En el siguiente ejemplo se muestran los procedimientos con el programa de utilidad keytool del JDK y openSSL.

1. Extraiga la clave pública del archivo de almacén de claves que se ha desplegado en {{ site.data.keys.mf_server }}.  
   >**Nota:** La clave pública debe estar codificada en Base64.

   Por ejemplo, supongamos que el nombre de alias es *mfp-server* y que el archivo del almacén de claves es `keystore.jks`.  
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

   >**Nota:** Con únicamente la herramienta de claves no es posible extraer claves públicas en formato Base64.

2. Complete los siguientes pasos:
    * Copie el texto resultante, sin el `BEGIN PUBLIC KEY` ni el `END PUBLIC KEY`.
    * En la aplicación cliente, abra el archivo de configuración de MobileFirst (por ejemplo, `mfpclient.plist` para iOS y `mfpclient.properties` para Android).
    * Añada el nuevo valor de clave llamado `wlSecureModelUpdatePublicKey`.
    * Proporcione la clave pública para el valor de clave correspondiente y guarde el archivo.
