---
layout: tutorial
title: Configuración del almacén de claves de MobileFirst Server
breadcrumb_title: Configuración del almacén de claves de servidor
weight: 14
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
Un almacén de claves es un repositorio de claves de seguridad y certificados que se utiliza para verificar y autenticar las partes involucradas en la transacción de red. El almacén de claves de {{ site.data.keys.mf_server }} define la identidad de las instancias de {{ site.data.keys.mf_server }} y se utiliza para firmar digitalmente las señales de OAuth y los paquetes de Direct Update.Además, cuando un adaptador se comunica con un servidor de fondo utilizando la autenticación HTTPS mutua (SSL), el almacén de claves se utiliza para validar la identidad de cliente SSL de la instancia de {{ site.data.keys.mf_server }}.

Para establecer la seguridad en un nivel de producción, durante el desplazamiento de desarrollo a producción, el administrador debe configurar {{ site.data.keys.mf_server }} para utilizar almacén de claves definido por usuario. El almacén de claves de {{ site.data.keys.mf_server }} predeterminado está pensado para que sea utilizado durante el desarrollo.

### Notas
{: #notes }
* Para utilizar el almacén de claves para verificar la autenticidad de un paquete de Direct Update, vincule estadísticamente la aplicación con la clave pública de la identidad de {{ site.data.keys.mf_server }} que se define en el almacén de claves. Consulte [Implementación de un Direct Update seguro en el lado del cliente](../../application-development/direct-update).
* Debe tenerse en cuenta la reconfiguración del almacén de claves de {{ site.data.keys.mf_server }} después de la producción.La modificación de la configuración puede provocar los siguientes posibles efectos:
    * Es posible que el cliente necesite adquirir una nueva señal de OAuth en lugar de una señal firmada con el almacén de claves previo. En la mayoría de los casos, este proceso es transparente para la aplicación.
    * Si la aplicación de cliente está limitada a una clave pública que no coincide con la identidad de {{ site.data.keys.mf_server }} en la nueva configuración del almacén de claves, Direct Update falla. Para continuar obteniendo actualizaciones, enlace la aplicación con la clave pública nueva y vuelva a publicar la aplicación. De forma alternativa, vuelva a modificar la configuración del almacén de claves para que coincida con la clave pública a la que la aplicación está vinculada. Consulte [Implementación de un Direct Update seguro en el lado del cliente](../../application-development/direct-update).
    *  Para la autenticación SSL mutua, si el alias y la contraseña de identidad de cliente SSL configuradas en el adaptador no se encuentran en el almacén de claves o no coinciden con las certificaciones SSL, la autenticación SSL falla. Consulte la información de configuración del adaptador en el paso 2 del siguiente procedimiento. 

## Configuración
{: #setup }
1. Cree un almacén de claves Java (JKS) o un archivo de almacén de claves PKCS 12 con un alias que contenga un par de claves que definan la identidad de {{ site.data.keys.mf_server }}. Si ya tiene un archivo de almacén de claves adecuado, vaya al paso siguiente. 

   > **Nota:** El tipo de algoritmo de clave-pareja que se debe utilizar es RSA. La siguiente información explica cómo establecer el tipo de algoritmo en RSA al utilizar el programa de utilidad **keytool**.


   Puede utilizar herramientas de terceros para crear el archivo de almacén de claves. Por ejemplo, puede generar el archivo de almacén de claves JKS ejecutando el programa de utilidad **keytool** con el siguiente mandato (en el que `<keystore name>` es el nombre de su almacén y `<alias name>` es el alias seleccionado):

   ```bash
   keytool -keystore <keystore name> -genkey -alias <alias name> -keylag RSA
   ```

   El siguiente mandato de muestra genera un archivo JKS **my_company.keystore** con un alias `my_alias`:

   ```bash
   keytool -keystore my_company.keystore -genkey -alias my_alias -keyalg RSA
   ```

   El programa de utilidad solicita que se proporcionen parámetros de entrada diferentes, incluidas las contraseñas del archivo de almacén de claves y del alias. 

   > **Nota:** Debe establecer la opción `-keyalg RSA` para establecer el tipo de algoritmo de claves generadas en RSA en lugar del tipo DSA predeterminado. 

   Para utilizar el almacén de claves para la autenticación SSL mutua entre un adaptador y un servidor de fondo, añada también un alias de identidad de cliente SSL de {{ site.data.keys.product }} en el almacén de claves. Puede hacerlo utilizando el mismo método que utilizó para crear el archivo de almacén de claves con el alias de identidad de {{ site.data.keys.mf_server }}, pero proporcionando en su lugar el alias y la contraseña para la identidad del cliente SSL.

2. Configure {{ site.data.keys.mf_server }} para utilizar su almacén de claves:
   Siga estos pasos para configurar {{ site.data.keys.mf_server }} para utilizar su almacén de claves:

      * **Adaptador Javascript**
        En la barra lateral de navegación de {{ site.data.keys.mf_console }}, seleccione **Valores de tiempo de ejecución** y luego seleccione el separador **Almacén de claves**. Siga las instrucciones del separador para configurar el almacén de {{ site.data.keys.mf_server }} definido por el usuario. Los pasos incluyen la carga del archivo de almacén de claves, indicando el tipo y proporcionando la contraseña del almacén de claves, el nombre del alias de identidad de {{ site.data.keys.mf_server }} y la contraseña del alias. Si se ha configurado correctamente, el **Estado** cambia a *Definido por el usuario*, o se muestra un error y el estado se queda en *Predeterminado*.
        El alias de identidad de cliente SSL (si se utiliza) y la contraseña se configuran en el archivo de descriptor del adaptador relevante en `<sslCertificateAlias>` y `<sslCertificatePassword>` los subelementos del elemento de `<connectionPolicy>`. Consulte [Elemento connectionPolicy del adaptador HTTP](../../adapters/javascript-adapters/js-http-adapter/#the-xml-file).

      * **Adaptador Java**
        Para configurar la autenticación SSL mutua para el adaptador Java el almacén de claves del servidor debe actualizarse. Esto se puede conseguir siguiendo estos pasos:

        * Copie el archivo de almacén de claves en `<ServerInstallation>/mfp-server/usr/servers/mfp/resources/security`

        * Edite el archivo `server.xml` `<ServerInstallation>/mfp-server/usr/servers/mfp/server.xml`.

        * Actualice la configuración del almacén de claves con el nombre de archivo correcto, contraseña y tipo `<keyStore id=“defaultKeyStore” location=<Keystore name> password=<Keystore password> type=<Keystore type> />`

Si se despliega utilizando el servicio {{ site.data.keys.mf_bm_short}} en Bluemix, puede subir el archivo de almacén de claves a **Configuración avanzada** antes de desplegar el servidor.
