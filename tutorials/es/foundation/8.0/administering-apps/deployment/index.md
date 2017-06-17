---
layout: tutorial
title: Despliegue de aplicaciones para pruebas y entornos de producción
breadcrumb_title: Despliegue de aplicaciones en entornos
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
Cuando finalice un ciclo de desarrollo de su aplicación, despliéguela en un entorno de prueba y, a continuación en un entorno de producción.


### Ir a 
{: #jump-to }

* [Despliegue o actualización de un adaptador en un entorno de producción](#deploying-or-updating-an-adapter-to-a-production-environment)
* [Configuración de SSL entre los adaptadores y los servidores de fondo utilizando certificados autofirmados](#configuring-ssl-between-adapters-and-back-end-servers-by-using-self-signed-certificates)
* [Creación de una aplicación para un entorno de prueba o producción](#building-an-application-for-a-test-or-production-environment)
* [Registro de una aplicación para un entorno de producción](#registering-an-application-to-a-production-environment)
* [Transferencia de artefactos del lado del servidor a un servidor de prueba o producción](#transferring-server-side-artifacts-to-a-test-or-production-server)
* [Actualización de aplicaciones de {{ site.data.keys.product_adj }} en producción](#updating-mobilefirst-apps-in-production)

## Despliegue o actualización de un adaptador en un entorno de producción
{: #deploying-or-updating-an-adapter-to-a-production-environment }
Los adaptadores contienen código del lado del servidor de aplicaciones que se despliegan en {{ site.data.keys.product }} y las que éste da servicio. Lea esta lista de comprobación antes de desplegar o actualizar un adaptador en un entorno de producción. Para obtener más información sobre cómo crear y construir adaptadores, consulte [Desarrollo del lado del servidor de una aplicación de {{ site.data.keys.product_adj }}](../../adapters).

Los adaptadores se pueden subir, actualizar o configurar mientras el servidor de producción se encuentra en ejecución. Después de que todos los nodos de una granja de servidores reciban el nuevo adaptador o la nueva configuración, todas las solicitudes entrantes al adaptador utilizarán los nuevos valores. 

1. Si actualiza un adaptador existente en un entorno de producción, asegúrese de que el adaptador no contiene incompatibilidades o regresiones con aplicaciones existentes registradas en un servidor. 

    El mismo adaptador puede ser utilizado por varias aplicaciones, o por varias versiones de la misma aplicación, que ya están utilizadas y publicadas para la tienda. Antes de actualizar el adaptador en un entorno de producción, ejecuta pruebas de no regresión en un servidor de prueba en relación al nuevo adaptador y copias de las aplicaciones se construyen para el servidor de prueba. 

2. Con adaptadores Java, si el adaptador utiliza Java URLConnection con HTTPS, asegúrese de que los certificados de fondo se encuentran en el almacén de claves de {{ site.data.keys.mf_server }}. 
        
    Para obtener más información, consulte [Utilización de SSL en adaptadores HTTP](../../adapters/javascript-adapters/js-http-adapter/using-ssl/). Para obtener más información acerca de cómo utilizar certificados autofirmados, consulte [Configuración SSL entre adaptadores y servidores de fondo utilizando certificados autofirmados](#configuring-ssl-between-adapters-and-back-end-servers-by-using-self-signed-certificates).

    > **Nota:** Si el servidor de aplicaciones es WebSphere Application Server Liberty, los certificados también se deben encontrar en el almacén de confianza de Liberty.
3. Verifique la configuración del lado del servidor del adaptador.
4. Utilice los mandatos `mfpadm deploy adapter` y `mfpadm adapter set user-config` para subir el adaptador y su configuración. 

    Para obtener más información sobre **mfpadm** para los adaptadores, consulte [Mandatos para adaptadores](../using-cli/#commands-for-adapters).
        
## Configuración SSL entre adaptadores y servidores de fondo utilizando certificados autofirmados
{: #configuring-ssl-between-adapters-and-back-end-servers-by-using-self-signed-certificates }
SSL se configura entre los adaptadores y los servidores de fondo importando el certificado SSL autofirmado en el almacén de confianza de {{ site.data.keys.product_adj }}.


1. Exporte el certificado público del servidor desde el almacén de claves del servidor de fondo. 

    > **Nota:** Exporte los certificados públicos de fondo desde el almacén de confianza de fondo utilizando keytool o la biblioteca openssl.
No utilice la característica de exportación en un navegador web.

2. Importe el certificado del servidor de fondo en el almacén de claves de {{ site.data.keys.product_adj }}. 
3. Despliegue el nuevo almacén de claves de {{ site.data.keys.product_adj }}.
Para obtener más información, consulte [Configuración del almacén de claves de {{ site.data.keys.mf_server }}](../../authentication-and-security/configuring-the-mobilefirst-server-keystore/).


### Ejemplo
{: #example }
El nombre **CN** del certificado de fondo debe coincidir con lo configurado en el archivo descriptor del adaptador **adapter.xml**.
Por ejemplo, considere un archivo **adapter.xml** que se configura de la siguiente manera:


```xml
<protocol>https</protocol>
<domain>mybackend.com</domain>
```

El certificado de fondo se debe generar con **CN=mybackend.com**.

A modo de otro ejemplo, considere la siguiente configuración de adaptador:


```xml
<protocol>https</protocol>
<domain>123.124.125.126</domain>
```

El certificado de fondo se debe generar con **CN=123.124.125.126**.

En el ejemplo siguiente se muestra cómo completar la configuración utilizando el programa Keytool.

1. Cree un almacén de claves de servidor de fondos con un certificado privado de 365 días.

        
    ```bash
    keytool -genkey -alias backend -keyalg RSA -validity 365 -keystore backend.keystore -storetype JKS
    ```

    > **Nota:** El campo **Nombre y apellido** contiene el URL de servidor, que se utiliza en el archivo de configuración **adapter.xml**, por ejemplo **mydomain.com** o **localhost**.
2. Configure su servidor de fondo para trabajar con el almacén de claves.
Por ejemplo, en Apache Tomcat, se cambia el archivo **server.xml**:


   ```xml
   <Connector port="443" SSLEnabled="true" maxHttpHeaderSize="8192" 
      maxThreads="150" minSpareThreads="25" maxSpareThreads="200"
      enableLookups="false" disableUploadTimeout="true"         
      acceptCount="100" scheme="https" secure="true"
      clientAuth="false" sslProtocol="TLS"
      keystoreFile="backend.keystore" keystorePass="password" keystoreType="JKS"
      keyAlias="backend"/>
   ```
        
3. Compruebe la configuración de conectividad en el archivo **adapter.xml**:


   ```xml
   <connectivity>
      <connectionPolicy xsi:type="http:HTTPConnectionPolicyType">
        <protocol>https</protocol>
        <domain>mydomain.com</domain>
        <port>443</port>
        <!-- The following properties are used by adapter's key manager for choosing a specific certificate from the key store
        <sslCertificateAlias></sslCertificateAlias> 
        <sslCertificatePassword></sslCertificatePassword>
        -->		
      </connectionPolicy>
      <loadConstraints maxConcurrentConnectionsPerNode="2"/>
   </connectivity>
   ```
        
4. Exporte el certificado público desde el almacén de claves del servidor de fondo que creó:


   ```bash
   keytool -export -alias backend -keystore backend.keystore -rfc -file backend.crt
   ```
        
5. Importe el certificado exportado en su almacén de claves de {{ site.data.keys.mf_server }}:


   ```bash
   keytool -import -alias backend -file backend.crt -storetype JKS -keystore mfp.keystore
   ```
        
6. Compruebe que el certificado se importa de forma correcta en el almacén de claves:

   ```bash
   keytool -list -keystore mfp.keystore
   ```
        
7. Despliegue el nuevo almacén de claves de {{ site.data.keys.mf_server }}.


## Construcción de una aplicación para un entorno de prueba o producción
{: #building-an-application-for-a-test-or-production-environment }
Para construir una aplicación para un entorno de prueba o producción, debe configurarla para su servidor de destino.
Para construir una aplicación para un entorno de producción, hay que seguir pasos adicionales.


1. Asegúrese de que el almacén de claves del servidor de destino está configurado.
Para obtener más información, consulte [Configuración del almacén de claves de {{ site.data.keys.mf_server }}](../../authentication-and-security/configuring-the-mobilefirst-server-keystore/).


2. Si piensa distribuir el artefacto instalable de la aplicación, incremente la versión de la aplicación.

3. Antes de construir su aplicación, configúrela para el servidor de destino.


    Se define el nombre de tiempo de ejecución y el URL del servidor de destino en el archivo de propiedades del cliente.
También puede cambiar el servidor de destino utilizando {{ site.data.keys.mf_cli }}.
Para configurar la aplicación para un servidor de destino sin registrar la aplicación para un servidor en ejecución, puede utilizar los mandatos `mfpdev app config server <URL servidor>` y `mfpdev app config runtime <nombre_tiempo_ejecución>`.
Otra posibilidad es registrar la aplicación para un servidor en ejecución ejecutando el mandato `mfpdev app register`.
Utilice el URL público del servidor.
Este URL lo utiliza la aplicación móvil para conectarse a {{ site.data.keys.mf_server }}.
    
    Por ejemplo, para configurar la aplicación para un servidor de destino mfp.mycompany.com con un tiempo de ejecución que tiene el nombre predeterminado mfp, ejecute `mfpdev app config server https://mfp.mycompany.com` y `mfpdev app config runtime mfp`.
    
4. Configure las claves de secreto y los servidores autorizados para su aplicación.

    * Si su aplicación implementa fijación de certificado, utilice el certificado de su servidor de destino.
Para obtener más información sobre la fijación de certificado, consulte [Fijación de certificado](../../authentication-and-security/certificate-pinning).

    * Si su aplicación iOS utiliza App Transport Security (ATS), configure ATS para su servidor de destino.

    * Para configurar Direct Update de forma segura para una aplicación Apache Cordova, consulte [Implementación de Direct Update de forma segura en el lado del cliente](../../application-development/direct-update).

    * Si ha desarrollado su aplicación con Apache Cordova, configure Cordova Content Security Policy (CSP).
    

5. Si piensa utilizar Direct Update para una aplicación que se ha desarrollado con Apache Cordova, archive las versiones de los plugins de Cordova que utilizó para construir la aplicación. 

    Direct Update no se puede utilizar para actualizar código nativo. Si cambió una biblioteca nativa o una de las herramientas de creación en un proyecto de Cordova y la subió a {{ site.data.keys.mf_server }}, el servidor detecta la diferencia y no envía ninguna actualización para la aplicación cliente. Los cambios en la biblioteca nativa puede incluir una versión Cordova diferente, un nuevo plugin Cordova iOS o incluso un fixpack de plugin mfpdev que sea más reciente que la utiliza para construir la aplicación original. 
    
6. Configure la aplicación para el uso de producción.
    * Considere inhabilitar la función de impresión en el registro del dispositivo.

    * Si tiene la intención de utilizar {{ site.data.keys.mf_analytics }}, verifique que su aplicación envía datos recopilados a {{ site.data.keys.mf_server }}.
    * Considere inhabilitar las características de su aplicación que llaman a la API `setServerURL`, a menos que piense en realizar una única construcción para varios servidores de prueba.


7. Si construye para un servidor de producción y planea distribuir el artefacto instalable, archive el código fuente de la aplicación para poder ejecutar pruebas de no regresión para esta aplicación en un servidor de prueba.


    Por ejemplo, si actualiza un adaptador con posterioridad, puede ejecutar pruebas de no regresión en aplicaciones ya distribuidas que utilizan este adaptador.
Para obtener más información, consulte [Despliegue o actualización de un adaptador en un entorno de producción](#deploying-or-updating-an-adapter-to-a-production-environment).
    
8. Opcional: Cree un archivo de autenticidad para su aplicación.

    Puede utilizar el archivo de autenticidad de aplicación después de registrar la aplicación en el servidor para habilitar la comprobación de seguridad de autenticidad de aplicación.

    * Para obtener más información, consulte [Habilitación de la comprobación de seguridad de autenticidad de aplicación](../../authentication-and-security/application-authenticity).
    * Para obtener más información sobre cómo registrar una aplicación en un servidor de producción, consulte [Registro de una aplicación para un entorno de producción](#registering-an-application-to-a-production-environment).

## Registro de una aplicación para un entorno de producción
{: #registering-an-application-to-a-production-environment }
Cuando registra una aplicación para un servidor de producción, se sube su descriptor de aplicación, se define su tipo de licencia y, opcionalmente, se activa la autenticidad de aplicación.


#### Antes de empezar 
{: #before-you-begin }
* Verifique que el almacén de claves de {{ site.data.keys.mf_server }} está configurado y no es el almacén de claves predeterminado. No utilice un servidor en producción con un almacén de claves predeterminado. El almacén de claves de {{ site.data.keys.mf_server }} define la identidad de las instancias de {{ site.data.keys.mf_server }}, y se utiliza para firmar digitalmente señales OAuth y paquetes de Direct Update. Debe configurar el almacén de claves del servidor con una clave secreta antes de utilizarlo en un entorno de producción. Para obtener más información, consulte [Configuración del almacén de claves de {{ site.data.keys.mf_server }}](../../authentication-and-security/configuring-the-mobilefirst-server-keystore/). 
* Desplegar los adaptadores utilizados por la aplicación. Para obtener más información, consulte [Despliegue o actualización de un adaptador en un entorno de producción](#deploying-or-updating-an-adapter-to-a-production-environment).
* Construya la aplicación para su servidor de destino. Para obtener más información, consulte [Construcción de una aplicación para un entorno de prueba o producción](#building-an-application-for-a-test-or-production-environment).

Cuando registra una aplicación con un servidor de producción, se sube su descriptor de aplicación, se define su tipo de licencia y, opcionalmente, se activa la autenticidad de aplicación. También puede definir su estrategia de actualización si ya se ha desplegado una versión más antigua de su aplicación. Consulte el procedimiento siguiente para obtener más información sobre pasos importantes, y sobre las formas en las que automatizarlos con el programa **mfpadm**.


1. Si {{ site.data.keys.mf_server }} está configurado para licencias de señal, asegúrese de que tiene suficiente señales disponibles en License Key Server. Para obtener más información, consulte [Validación de licencias de señal](../license-tracking/#token-license-validation) y [Planificación para la utilización de gestión de licencias de señal](../../installation-configuration/production/token-licensing/#planning-for-the-use-of-token-licensing).

   > **Sugerencia:** Puede establecer el tipo de licencia de señal de su aplicación antes de registrar la primera versión de dicha aplicación. Para obtener más información, consulte [Establecimiento de la información de la licencia de la aplicación](../license-tracking/#setting-the-application-license-information).
2. Transfiera el descriptor de la aplicación desde un servidor de prueba al servidor de producción. 

   Esta operación registra la aplicación para el servidor de producción y sube su configuración. Para obtener más información sobre la transferencia de un descriptor de aplicación, consulte [Transferencia de artefactos del lado del servidor a un servidor de prueba o producción](#transferring-server-side-artifacts-to-a-test-or-production-server).

3. Establezca la información de la licencia de la aplicación. Para obtener más información, consulte [Establecimiento de la información de licencia de la aplicación](../license-tracking/#setting-the-application-license-information).
4. Configure la comprobación de seguridad de autenticidad de aplicación. Para obtener más información sobre la configuración de la comprobación de la autenticidad de aplicación, consulte [Configuración de la comprobación de seguridad de autenticidad de aplicación](../../authentication-and-security/application-authenticity/#configuring-application-authenticity).


   > **Nota:** Necesita el archivo binario de aplicación para crear el archivo de autenticidad de aplicación. Para obtener más información, consulte [Habilitación de la comprobación de seguridad de autenticidad de aplicación](../../authentication-and-security/application-authenticity/#enabling-application-authenticity).

5. Si su aplicación utiliza notificaciones push, suba los certificados de notificación push al servidor. Puede subir los certificados push para su aplicación con {{ site.data.keys.mf_console }}. Los certificados son comunes a todas las versiones de una aplicación. 

   > **Nota:** Es posible que no pueda probar las notificaciones push para su aplicación con certificados de producción antes de que su aplicación se publique en la tienda.
6. Verifique los elementos siguientes antes de publicar la aplicación en la tienda.

    * Pruebe la característica de gestión de aplicaciones móviles que piensa utilizar como, por ejemplo, la inhabilitación de aplicaciones remotas o la visualización de un mensaje de administrador. Para obtener más información, consulte [Gestión de aplicaciones móviles](../using-console/#mobile-application-management).
    * En el caso de una actualización, defina la estrategia de actualización. Para obtener más información, consulte [Actualización de aplicaciones de {{ site.data.keys.product_adj }} en producción](#updating-mobilefirst-apps-in-production).

## Transferencia de artefactos del lado del servidor a un servidor de producción o pruebas
{: #transferring-server-side-artifacts-to-a-test-or-production-server }
Existe la posibilidad de transferir una configuración de aplicación de un servidor a otro utilizando una API REST o herramientas de línea de mandatos.


El archivo de descriptor de la aplicación es un archivo JSON que contiene la descripción y la configuración de la aplicación.
Cuando se ejecuta una aplicación que se conecta a una instancia de {{ site.data.keys.mf_server }}, la aplicación debe estar configurada y registrada con dicho servidor.
Después de definir una configuración para la aplicación, puede transferir el descriptor de aplicación a otro servidor, por ejemplo, a un servidor de prueba o a un servidor de producción.
Después de haber transferido el descriptor de aplicación al nuevo servidor, la aplicación se registra con el nuevo servidor.
Hay disponibles varios procedimientos, dependiendo de si desarrolla las aplicaciones móviles y tiene acceso al código, o si administra los servidores y no tiene acceso al código de la aplicación móvil.


> **Importante:** Si importa una aplicación que incluye datos de autenticidad, y si la propia aplicación se ha recompilado desde que se generaron los datos de autenticidad, debe renovar los datos de autenticidad.
Para obtener más información, consulte [Configuración de la comprobación de seguridad de autenticidad de aplicación](../../authentication-and-security/application-authenticity/#configuring-application-authenticity).
* Si tiene acceso al código de la aplicación móvil, utilice los mandatos `mfpdev app pull` y `mfpdev app push`.

* Si no tiene acceso al código de la aplicación móvil, utilice el servicio de administración.


#### Ir a 
{: #jump-to-1 }

* [Transferencia de una configuración de aplicación utilizando mfpdev](#transferring-an-application-configuration-by-using-mfpdev)
* [Transferencia de una configuración con el servicio de administración](#transferring-an-application-configuration-with-the-administration-service)
* [Transferencia de artefactos del lado del servidor utilizando la API REST](#transferring-server-side-artifacts-by-using-the-rest-api)
* [Exportación e importación de aplicaciones y adaptadores desde MobileFirst Operations Console](#exporting-and-importing-applications-and-adapters-from-the-mobilefirst-operations-console)

### Transferencia de una configuración de aplicación utilizando mfpdev
{: #transferring-an-application-configuration-by-using-mfpdev }
Después de desarrollar una aplicación, puede transferirla desde el entorno de desarrollo a un entorno de producción o prueba.


* Debe tener una aplicación de {{ site.data.keys.product_adj }} existente en el sistema local.
La aplicación debe estar registrada para una instancia de {{ site.data.keys.mf_server }}.
Para obtener información sobre cómo crear un perfil de servidor, ejecute **mfpdev app register**, o el tema sobre cómo registrar su tipo de aplicación en la sección Desarrollo de aplicaciones de esta documentación.

* Debe haber conectividad entre el sistema local y el servidor en el que la aplicación está actualmente registrada y al servidor al que desea transferir su aplicación.

* Debe tener un perfil de servidor en el sistema local, tanto para el servidor de {{ site.data.keys.mf_server }} original como el servidor al que desea transferir la aplicación.
Para obtener información sobre cómo crear un perfil de servidor, ejecute **mfpdev server add**.

* Debe tener instalado {{ site.data.keys.mf_cli }}

Utilice el mandato **mfpdev app pull** para enviar una copia de los archivos de configuración del lado del servidor de su aplicación a su sistema local.
A continuación, utilice el mandato **mfpdev app push** enviarlo a otra instancia de {{ site.data.keys.mf_server }}.
El mandato **mfpdev app push** también registra la aplicación en servidor especificado.


También puede utilizar estos mandatos para transferir una configuración de tiempo de ejecución de un servidor a otro.


La información de configuración incluye el contenido del descriptor de la aplicación, que la identifica de forma exclusiva en el servidor así como otra información que es específica de la aplicación.
Los archivos de configuración se proporcionan como archivos comprimidos (formato .zip).

Los archivos .zip se ubican en el directorio **appName/mobilefirst** y se denominan de la siguiente manera:


```bash
appID-platform-version-artifacts.zip
```

donde **appID** es el nombre de la aplicación, **platform** es **android**, **ios** o **windows** y version es el nivel de versión de su aplicación.
Para aplicaciones Cordova, se crea un archivo .zip separado para cada plataforma de destino.


Cuando se utiliza el mandato **mfpdev app push**, se modifica el archivo de propiedades del cliente para reflejar el nombre del perfil y el URL del nuevo {{ site.data.keys.mf_server }}.


1. En su sistema de desarrollo, vaya al directorio raíz de su aplicación o a uno de sus subdirectorios.

2. Ejecute el mandato **mfpdev app pull**.
Si especifica el mandato sin parámetros, la aplicación recupera de la instancia de {{ site.data.keys.mf_server }} predeterminada.
También puede especificar un servidor concreto y su contraseña de administrador.
Por ejemplo, para una aplicación Android denominada **myapp1**:


   ```bash
   cd myapp1
   mfpdev app pull Server10 -password secretPassword!
   ```
    
   Este mandato encuentra los archivos de configuración para la aplicación actual en la instancia de {{ site.data.keys.mf_server }} cuyo perfil de servidor de denomina Server10.
A continuación, envía el archivo comprimido **myapp1-android-1.0.0-artifacts.zip**, que contiene estos archivos de configuración, al sistema local y lo coloca en el directorio **myapp1/mobilefirst**.
    
3. Ejecute el mandato **mfpdev app push**.
Si especifica el mandato sin parámetros, la aplicación se recupera de la instancia de {{ site.data.keys.mf_server }} predeterminada.
También puede especificar un servidor concreto y su contraseña de administrador.
Por ejemplo, para la misma aplicación que se recuperó en el paso anterior: `mfpdev app push Server12 -password secretPass234!`.
    
   Este mandato envía el archivo **myapp1-android-1.0.0-artifacts.zip** a la instancia de {{ site.data.keys.mf_server }} cuyo perfil de servidor se denomina Server12, que tiene la contraseña de administrador **secretPass234!**
El archivo de propiedades de cliente **myapp1/app/src/main/assets/mfpclient.properties** se modifica para reflejar que el servidor en el que se registra la aplicación es Server12, con el URL del servidor.


Los archivos de configuración del lado del servidor están presentes en la instancia de {{ site.data.keys.mf_server }} que especificó en le mandato mfpdev app push.
La aplicación se registra en este nuevo servidor.


### Transferencia de una configuración de aplicación con el servicio de administración
{: #transferring-an-application-configuration-with-the-administration-service }
Como administrador, puede transferir una configuración de aplicación de un servidor a otro mediante el servicio de administración de {{ site.data.keys.mf_server }}.
No es necesario un código de aplicación, sin embargo, la aplicación de cliente se debe construir para el servidor de destino.


#### Antes de empezar 
{: #before-you-begin-1 }
Construya la aplicación de cliente para su servidor de destino.
Para obtener más información, consulte [Construcción de una aplicación para un entorno de prueba o producción](#building-an-application-for-a-test-or-production-environment).

El descriptor de aplicación se descarga desde el servidor en el que está configurada la aplicación y lo despliega en el nuevo servidor.
Puede ver el descriptor de la aplicación en {{ site.data.keys.mf_console }}.

1. Opcional: Revise el descriptor de aplicación en el servidor en el que el servidor de aplicaciones está configurado.
Abra {{ site.data.keys.mf_console }} para dicho servidor, seleccione su versión de aplicación y vaya al separador **Archivos de configuración**.


2. Descargue el descriptor de aplicación del servidor donde la aplicación está configurada.
Puede descargarla utilizando la API REST o **mfpadm**.

   > **Nota:** También puede exportar una aplicación o versión de aplicación desde {{ site.data.keys.mf_console }}.
Consulte [Exportación e importación de aplicaciones y adaptadores desde {{ site.data.keys.mf_console }}](#exporting-and-importing-applications-and-adapters-from-the-mobilefirst-operations-console).
    * Para descargar el descriptor de aplicación con la API REST, utilice la API REST [Application Descriptor (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_descriptor_get.html?view=kc#Application-Descriptor--GET-).


    El siguiente URL devuelve el descriptor de aplicación para la aplicación de ID **my.test.application**, para la plataforma **ios** y la versión **0.0.1**.
La llamada se realiza a la instancia de {{ site.data.keys.mf_server }}: `http://localhost:9080/mfpadmin/management-apis/2.0/runtimes/mfp/applications/my.test.application/ios/0.0.1/descriptor`
    
    Por ejemplo, puede utilizar URL como este en una herramienta como curl: `curl -user admin:admin http://[...]/ios/0.0.1/descriptor > desc.json`.
    
    <br/>
     Cambie los siguientes elementos del URL de acuerdo a la configuración de su servidor:
     * **9080** es el puerto HTTP predeterminado de {{ site.data.keys.mf_server }} durante el desarrollo.

     * **mfpadmin** es la raíz de contexto predeterminada del servicio de administración.
 

    Para obtener información sobre la API REST, consulte las API REST para el servicio de administración de {{ site.data.keys.mf_server }}.
     * Descargue el descriptor de aplicación mediante **mfpadm**.

       El programa **mfpadm** está instalado al ejecutar el instalador de {{ site.data.keys.mf_server }}.
Puede iniciarlo desde el directorio **product\_install\_dir/shortcuts/**, donde **product\_install\_dir** indica el directorio de instalación del producto {{ site.data.keys.mf_server }}.
    
       En el siguiente ejemplo se crear un archivo de contraseña que se necesita para el mandato **mfpadm**, a continuación se descarga el descriptor de aplicación para la aplicación de ID **my.test.application**, para la plataforma **ios** y la versión **0.0.1**.
El URL proporcionado es el URL HTTPS de {{ site.data.keys.mf_server }} durante el desarrollo.

    
       ```bash
       echo password=admin > password.txt
       mfpadm --url https://localhost:9443/mfpadmin --secure false --user admin \ --passwordfile password.txt \ app version mfp my.test.application ios 0.0.1 get descriptor > desc.json
       rm password.txt
       ```
    
       Cambie los siguientes elementos de la línea de mandatos de acuerdo a la configuración de su servidor:
        * **9443** es el puerto HTTPS predeterminado de {{ site.data.keys.mf_server }} durante el desarrollo.

        * **mfpadmin** es la raíz de contexto predeterminada del servicio de administración.
 
        * --secure false indica que se aceptará el certificado SSL incluso si está autofirmado o si se ha creado para un nombre de host diferente del nombre de host del servidor utilizado en el URL.


       Para obtener información sobre el programa **mfpadm**, consulte [Administración de aplicaciones de {{ site.data.keys.product_adj }} a través de la línea de mandatos](../using-cli).
    
3. Suba el descriptor de aplicación al nuevo servidor para registrar la aplicación o actualizar su configuración.
Puede subirla utilizando la API REST o **mfpadm**.
   * Para subir el descriptor de aplicación con la API REST, utilice la API REST [Application (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_post.html?view=kc#Application--POST-).

    
     El siguiente URL sube el descriptor de aplicación al tiempo de ejecución de mfp.
Puede enviar una solicitud POST. La carga útil está en el descriptor de aplicación JSON.
En este ejemplo, se realiza una llamada al servidor que se ejecuta en el sistema local y que está configurado con el puerto HTTP 9081.

    
     ```bash
     http://localhost:9081/mfpadmin/management-apis/2.0/runtimes/mfp/applications/
     ```
    
     Por ejemplo, puede utilizar un URL como este en una herramienta como curl.

    
     ```bash
     curl -H "Content-Type: application/json" -X POST -d @desc.json -u admin:admin \ http://localhost:9081/mfpadmin/management-apis/2.0/runtimes/mfp/applications/
     ```    
    
   * Suba el descriptor de aplicación utilizando mfpadm.

     
En el siguiente ejemplo se crea un archivo de contraseña que se necesita para el mandato mfpadm, a continuación se sube el descriptor de aplicación con el ID my.test.application, para la plataforma ios y la versión 0.0.1.
Se proporciona el URL HTTPS de un servidor que se ejecuta en el sistema local configurado con el puerto HTTPS 9444 para un tiempo de ejecución denominado mfp.


     ```bash
     echo password=admin > password.txt
     mfpadm --url https://localhost:9444/mfpadmin --secure false --user admin \ --passwordfile password.txt \ deploy app mfp desc.json 
     rm password.txt
     ```

### Transferencia de artefactos del lado del servidor utilizando la API REST
{: #transferring-server-side-artifacts-by-using-the-rest-api }
Independientemente de su rol, puede exportar aplicaciones, adaptadores y recursos a efectos de reutilizarlos o de hacer copias de seguridad utilizando el servicio de administración de {{ site.data.keys.mf_server }}.
Como administrador o desplegador, también puede desplegar un archivador de exportación a un servidor diferente.
No es necesario un código de aplicación, sin embargo, la aplicación de cliente se debe construir para el servidor de destino.


#### Antes de empezar 
{: #before-you-begin-2 }
Construya la aplicación de cliente para su servidor de destino.
Para obtener más información, consulte [Construcción de una aplicación para un entorno de prueba o producción](#building-an-application-for-a-test-or-production-environment).

La API de exportación recupera los artefactos seleccionados para un tiempo de ejecución como un archivo .zip.
Utilice la API de despliegue para reutilizar el contenido archivado.


> **Importante:** Considere con atención este caso de uso:
  
>  
> * El archivo de exportación incluye datos de autenticidad de la aplicación.
Los datos son específicos de la construcción de una aplicación móvil.
La aplicación móvil incluye el URL del servidor y su nombre de tiempo de ejecución.
Por lo tanto, si desea utilizar otro servidor u otro entorno de tiempo de ejecución, debe reconstruir la aplicación.
Transferir únicamente los archivos de la aplicación no será suficiente.
> * Algunos artefactos pueden variar de un servidor a otro.
Las credenciales push son diferentes dependiendo de si trabaja en un entorno de desarrollo o un entorno de producción.
> * La configuración del tiempo de ejecución de la aplicación (que contiene el estado activo/inhabilitado y los archivos de registro) se pueden transferir en algunos casos, pero no en todos.
> * La transferencia de recursos web podría no tener sentido en algunos casos, por ejemplo, si se realiza la reconstrucción para utilizar un nuevo servidor.

* Para exportar todos los recursos, o un subconjunto seleccionado de recursos, para un adaptador o para todos adaptadores, utilice la API [Export adapter resources (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_export_adapter_resources_get.html?view=kc) o [Export adapters (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_export_adapters_get.html?view=kc).

* Para exportar todos los recursos bajo un entorno de aplicaciones específico (como, por ejemplo, Android o iOS), esto es todas las versiones y todos los recursos para la versión para dicho entorno, utilice la API [Export application environment (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_export_application_environment_get.html?view=kc).

* Para exportar todos los recursos para una versión específica de una aplicación (por ejemplo, la versión 1.0 o 2.0 de una aplicación Android), utilice la API [Export application environment resources (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_export_application_environment_resources_get.html?view=kc).

* Para exportar una aplicación específica o todas las aplicaciones para un tiempo de ejecución, utilice la API [Export applications (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_export_applications_get.html?view=kc) o [Export application resources (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_export_application_resources_get.html?view=kc).
**Nota:** Las credenciales para las notificaciones push no se exportan junto con los recursos de la aplicación.

* Para exportar el contenido del adaptador, el descriptor, la configuración de licencia, el contenido, la configuración de usuario, el almacén de claves y los recursos web de una aplicación, utilice la API [Export resources (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_export_resources_get.html?view=kc#Export-resources--GET-).

* Para exportar recursos seleccionados o todos ellos de un tiempo de ejecución, utilice la API [Export runtime resources (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_export_runtime_resources_get.html?view=kc).
Por ejemplo, puede utilizar este mandato curl general para recuperar todos los recursos como un archivo .zip.


  ```bash
  curl -X GET -u admin:admin -o exported.zip
  "http://localhost:9080/worklightadmin/management-apis/2.0/runtimes/mfp/export/all"
  ```
    
* Para desplegar un archivador que contenga dichos recursos de aplicación web como un adaptador, aplicación, configuración de licencia, almacén de claves o recurso web, utilice la API [Deploy (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_deploy_post.html?view=kc).
Por ejemplo, puede utilizar este mandato curl para desplegar un archivo .zip existente que contenga artefactos.


  ```bash
  curl -X POST -u admin:admin -F
  file=@/Users/john_doe/Downloads/export_applications_adf_ios_2.zip
  "http://localhost:9080/mfpadmin/management-apis/2.0/runtimes/mfp/deploy/multi"
  ```

* Para desplegar datos de autenticidad de aplicación, utilice la API [Deploy Application Authenticity Data (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_deploy_application_authenticity_data_post.html?view=kc).

* Para desplegar los recursos web de una aplicación, utilice la API [Deploy a web resource (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_deploy_a_web_resource_post.html?view=kc).


Si despliega un archivador de exportación al mismo entorno de tiempo de ejecución, la aplicación o la versión no necesariamente se restauran de la misma manera que cuando se exportaron.
Es decir, el redespliegue no elimina las subsiguientes modificaciones.
En su lugar, si algún recurso de aplicación se modifica entre la exportación y el redespliegue, únicamente los recursos que se incluyen en el archivador exportado se redespliegan en su estado original.
Por ejemplo, si exporta una aplicación sin datos de autenticidad, sube sus datos de autenticidad y, a continuación, importa el archivador inicial, no se borrarán los datos de autenticidad.


### Exportación e importación de aplicaciones y adaptadores desde {{ site.data.keys.mf_console }}

{: #exporting-and-importing-applications-and-adapters-from-the-mobilefirst-operations-console }
Desde la consola, en determinadas condiciones, puede exportar una aplicación o una de sus versiones, y, posteriormente, importarla en otro tiempo de ejecución en el mismo servidor o en un servidor distinto.
También puede exportar y reimportar adaptadores.
Utilice esta funcionalidad para volver a utilizarlos o a efectos de copia de seguridad.


Si se le ha otorgado el rol de administrador **mfpadmin** y el rol de desplegador **mfpdeployer**, puede exportar una versión o todas las versiones de una aplicación.
La aplicación o versión se exporta como un archivo comprimido .zip, que guarda el ID de aplicación, descriptores, datos de autenticidad y recursos web.
Posteriormente puede importar el archivador para redesplegar la aplicación o versión en otro tiempo de ejecución en el mismo servidor o en otro servidor diferente.


> **Importante:** Considere con atención este caso de uso:
  
> 
> * El archivo de exportación incluye datos de autenticidad de la aplicación.
Los datos son específicos de la construcción de una aplicación móvil.
La aplicación móvil incluye el URL del servidor y su nombre de tiempo de ejecución.
Por lo tanto, si desea utilizar otro servidor u otro entorno de tiempo de ejecución, debe reconstruir la aplicación.
Transferir únicamente los archivos de la aplicación no será suficiente.
> * Algunos artefactos pueden variar de un servidor a otro.
Las credenciales push son diferentes dependiendo de si trabaja en un entorno de desarrollo o un entorno de producción.
> * La configuración del tiempo de ejecución de la aplicación (que contiene el estado activo/inhabilitado y los archivos de registro) se pueden transferir en algunos casos, pero no en todos.
> * La transferencia de recursos web podría no tener sentido en algunos casos, por ejemplo, si se realiza la reconstrucción para utilizar un nuevo servidor.

Puede transferir también descriptores de aplicación utilizando la API REST o la herramienta mfpadm.
Para obtener más información, consulte [Transferencia de una configuración de aplicación con el servicio de administración](#transferring-an-application-configuration-with-the-administration-service).

1. Desde la barra lateral de navegación, seleccione una aplicación o una versión de aplicación o un adaptador.

2. Seleccione **Acciones → Exportar aplicación** o **Exportar versión** o **Exportar adaptador**.

    Se le solicitará que guarde el archivo archivador .zip que encapsula los recursos exportados.
El aspecto del recuadro de diálogo depende del navegador y la carpeta de destino depende de los valores del navegador.


3. Guarde el archivo archivador.


    El nombre del archivo archivador incluye el nombre y la versión de la aplicación o el adaptador, por ejemplo, **export_applications_com.sample.zip**.

4. Para reutilizar un archivador de archivo existe, seleccione **Acciones → Importar aplicación** o **Importar versión**, navegue hasta el archivador y pulse **Desplegar**.


El marco de consola principal visualiza los detalles del adaptador o la aplicación importada.


Si importa al mismo entorno de tiempo de ejecución, la aplicación o versión no necesariamente se restaurarán de la misma forma en la que se exportó.
Esto es, el redespliegue en el momento de la importación no elimina las modificaciones posteriores.
Es más, si algún recurso de aplicación se modifica entre la exportación y el redespliegue en el momento de la importación, únicamente los recursos que se incluyen en el archivador exportado se redespliegan en su estado original.
Por ejemplo, si exporta una aplicación sin datos de autenticidad, sube sus datos de autenticidad y, a continuación, importa el archivador inicial, no se borrarán los datos de autenticidad.


## Actualización de aplicaciones de {{ site.data.keys.product_adj }} en producción
{: #updating-mobilefirst-apps-in-production }
Hay directrices generales para actualizar sus aplicaciones de {{ site.data.keys.product_adj }} cuando ya estén en un entorno de producción, en Application Center o en tiendas de aplicaciones.


Al actualizar un aplicación, puede desplegar una nueva versión de la aplicación y dejar la versión antigua funcionando, o desplegar una nueva versión de la aplicación y bloquear la versión antigua.
En el caso de un aplicación desarrollada con Apache Cordova, también puede considerar el actualizar únicamente los recursos web.


### Desplegar una nueva versión de la aplicación y dejar la antigua funcionando
{: #deploying-a-new-app-version-and-leaving-the-old-version-working }
El método de actualización más habitual, cuando introduce nuevas características o modifica el código nativo, es proporcionar una nueva version de su aplicación. Considere seguir estos pasos:

1. Incrementar el número de versión de la aplicación.

2. Construir y probar la aplicación.
Para obtener más información, consulte [Construcción de una aplicación para un entorno de prueba o producción](#building-an-application-for-a-test-or-production-environment).
3. Registrar la aplicación en {{ site.data.keys.mf_server }} y configurarla.

4. Enviar los nuevos archivos .apk, .ipa, .appx o .xap a sus respectivas tiendas de aplicaciones.

5. Esperar la revisión y la aprobación y que las aplicaciones pasen a estar disponibles.

6. Opcional: enviar mensajes de notificación a los usuarios de la versión antigua, anunciando la nueva versión.
Consulte [Visualización de un mensaje de administrador](../using-console/#displaying-an-administrator-message) y [Definición de mensajes de administrador en varios idiomas](../using-console/#defining-administrator-messages-in-multiple-languages).


### Desplegar una nueva versión de la aplicación y bloquear la versión antigua
{: #deploying-a-new-app-version-and-blocking-the-old-version }
Este método de actualización se utiliza cuando desea forzar a los usuarios a actualizarse a la nueva versión y bloquear el acceso a la versión antigua.
Considere seguir estos pasos:

1. Opcional: enviar mensajes de notificación a los usuarios de la versión antigua, anunciando una actualización obligatoria en unos días.
Consulte [Visualización de un mensaje de administrador](../using-console/#displaying-an-administrator-message) y [Definición de mensajes de administrador en varios idiomas](../using-console/#defining-administrator-messages-in-multiple-languages).
2. Incrementar el número de versión de la aplicación.

3. Construir y probar la aplicación.
Para obtener más información, consulte [Construcción de una aplicación para un entorno de prueba o producción](#building-an-application-for-a-test-or-production-environment).
4. Registrar la aplicación en {{ site.data.keys.mf_server }} y configurarla.

5. Enviar los nuevos archivos .apk, .ipa, .appx o .xap a sus respectivas tiendas de aplicaciones.

6. Esperar la revisión y la aprobación y que las aplicaciones pasen a estar disponibles.

7. Copiar enlaces a la nueva versión de la aplicación.

8. Bloquear las versión antigua de la aplicación en {{ site.data.keys.mf_console }}, proporcionando un mensaje y un enlace a la nueva versión.
Consulte [Inhabilitación de forma remota del acceso de la aplicación a recursos protegidos](../using-console/#remotely-disabling-application-access-to-protected-resources).

> **Nota:** Si inhabilita la antigua aplicación, ya no podrá comunicarse con {{ site.data.keys.mf_server }}.
Los usuarios todavía podrán iniciar la aplicación y trabajar con ella fuera de línea, a menos que fuerce una conexión al servidor al iniciar la aplicación.
### Direct Update (sin cambios de código nativo)
{: #direct-update-no-native-code-changes }
Direct Update es un mecanismo de actualización obligatorio que se utiliza para desplegar arreglos de forma rápida en una aplicación de producción.
Cuando se redespliega una aplicación en {{ site.data.keys.mf_server }} sin cambiar su versión, {{ site.data.keys.mf_server }} utiliza un mecanismo push para los recursos web actualizados para el dispositivo cuando el usuario se conecta al servidor.
El mecanismo push no se utiliza para actualizar el código nativo.
Tenga en cuenta lo siguiente cuando considere utilizar Direct Update:


1. Direct Update no actualiza la versión de la aplicación.
La aplicación permanece en la misma versión, pero con un conjunto distinto de recursos web.
El número de versión sin cambio puede producir confusión si se utiliza incorrectamente
2. Direct Update tampoco utiliza el proceso de revisión de una tienda de aplicaciones porque técnicamente no es un nuevo release.
No se debería abusar de este mecanismo porque los proveedores podrían quejarse si despliega toda una nueva versión de la aplicación de su aplicación omitiendo su proceso de revisión.
Es su responsabilidad leer y respetar el acuerdo de utilización de cada tienda.
Direct Update está pensado para corregir problemas urgentes que no pueden esperar varios días.

3. Direct Update se considera un mecanismo de seguridad y, por lo tanto, es obligatorio y no opcional.
Cuando inicia Direct Update, todos los usuarios deben actualizar su aplicación para poder utilizarla.

4. Direct Update no funciona si una aplicación se ha compilado (construido) con una versión diferente de {{ site.data.keys.product }} de la que se utilizó para el despliegue inicial.


> **Nota:** Los archivos de archivador/IPA generados con Test Flight o iTunes Connect para la validación en la tienda o su envío a la tienda para aplicaciones iOS, podrían originar errores/cuelgues en tiempo de ejecución. Para obtener más in formación, consulte el blog [Preparing iOS apps for App Store submission in {{ site.data.keys.product }}](https://mobilefirstplatform.ibmcloud.com/blog/2016/10/17/prepare-ios-apps-for-app-store-submission/).
