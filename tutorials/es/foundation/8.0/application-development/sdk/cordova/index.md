---
layout: tutorial
title: Adición de MobileFirst Foundation SDK a aplicaciones Cordova
breadcrumb_title: Cordova
relevantTo: [cordova]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
En esta guía de aprendizaje, aprenderá a añadir {{ site.data.keys.product_adj }} SDK a una aplicación Cordova nueva o existente creada con Apache Cordova, Ionic u otra herramienta de un tercero.
También aprenderá a configurar {{ site.data.keys.mf_server }} para que reconozca la aplicación, y para encontrar información sobre los archivos de configuración de {{ site.data.keys.product_adj }} que se cambian en el proyecto.


{{ site.data.keys.product_adj }} Cordova SDK se proporciona como un conjunto de plugins de Cordova, [que se registra en NPM](https://www.npmjs.com/package/cordova-plugin-mfp).  
Los plugins disponibles son:


* **cordova-plugin-mfp** - El núcleo de SDK
* **cordova-plugin-mfp-push** - Proporciona soporte de notificaciones push
* **cordova-plugin-mfp-jsonstore** - Proporciona soporte JSONStore 
* **cordova-plugin-mfp-fips** - *Solo Android*. Proporciona soporte de FIPS 
* **cordova-plugin-mfp-encrypt-utils** - *Solo iOS*. Proporciona soporte para el cifrado y descifrado

#### Niveles de soporte
{: #support-levels }
Los plugins de MobileFirst dan soporte a las siguientes versiones de plataforma Cordova:


* cordova-ios: **>= 4.1.1 y < 5.0**
* cordova-android: **>= 6.1.2 y < 7.0**
* cordova-windows: **>= 4.3.2 y < 6.0**

#### Ir a:
{: #jump-to }
- [Componentes de Cordova SDK ](#cordova-sdk-components)
- [Adición de {{ site.data.keys.product_adj }} Cordova SDK](#adding-the-mobilefirst-cordova-sdk)
- [Actualización de {{ site.data.keys.product_adj }} Cordova SDK](#updating-the-mobilefirst-cordova-sdk)
- [Artefactos de {{ site.data.keys.product_adj }} Cordova SDK generados](#generated-mobilefirst-cordova-sdk-artifacts)
- [Guías de aprendizaje con las que continuar](#tutorials-to-follow-next)

> **Nota:** La funcionalidad de **compartición de la cadena de claves** es obligatoria al ejecutar aplicaciones iOS en el simulador de iOS al utilizar Xcode 8. Necesitará habilitar esta funcionalidad de forma manual antes de compilar el proyecto Xcode.



## Componentes de Cordova SDK
{: #cordova-sdk-components }
#### cordova-plugin-mfp
{: #cordova-plugin-mfp }
El plugin cordova-plugin-mfp es el plugin principal de {{ site.data.keys.product_adj }} para Cordova. Este plugin es necesario.
Si instala cualquier otro plugin de {{ site.data.keys.product_adj }}, también se instala automáticamente el plugin cordova-plugin-mfp en el caso de que todavía no lo esté.


> Los siguientes plugins de Cordova se instalan como dependencias de cordova-plugin-mfp:
>   
>    - cordova-plugin-device
>    - cordova-plugin-dialogs
>    - cordova-plugin-globalization
>    - cordova-plugin-okhttp

#### cordova-plugin-mfp-jsonstore
{: #cordova-plugin-mfp-jsonstore }
El plugin de cordova-plugin-mfp-jsonstore habilita que su aplicación utilice JSONstore.
Para obtener más información sobre JSONstore, consulte la [guía de aprendizaje de JSONStore](../../jsonstore/cordova/).  

#### cordova-plugin-mfp-push
{: #cordova-plugin-mfp-push }
El plugin cordova-plugin-mfp-push proporciona los permisos necesarios para utilizar notificaciones push desde {{ site.data.keys.mf_server }} para aplicaciones Android.
Se necesita una configuración adicional para utilizar notificaciones push.
Para obtener más información sobre las notificaciones push, consulte la guía de aprendizaje de [Notificaciones push](../../../notifications/).

#### cordova-plugin-mfp-fips
{: #cordova-plugin-mfp-fips }
El plugin cordova-plugin-mfp-fips proporciona soporte FIPS 140-2 para la plataforma Andorid.
Para obtener más información, consulte el [soporte a FIPS 140-2](../../../administering-apps/federal/#fips-140-2-support).

#### cordova-plugin-mfp-encrypt-utils
{: #cordova-plugin-mfp-encrypt-utils }
El plugin cordova-plugin-mfp-encrypt-utils proporciona infraestructuras de cifrado OpenSSL para las aplicaciones Cordova con la plataforma iOS.
Para obtener más información, consulte [Habilitación de OpenSSL para Cordova iOS](additional-information).

**Requisitos previos:**

- [Apache Cordova CLI 6.x](https://www.npmjs.com/package/cordova) y {{ site.data.keys.mf_cli }} instalado en la estación de trabajo del desarrollador.

- Una instancia remota o local de {{ site.data.keys.mf_server }} que esté en ejecución.

- Lea las guías de aprendizaje [
Configuración del entorno de desarrollo de {{ site.data.keys.product_adj }}](../../../installation-configuration/development/mobilefirst) y [Configuración del entorno de desarrollo de Cordova](../../../installation-configuration/development/cordova).

- Para cordova-windows, debe instalarse una versión de Visual C++ que sea compatible con las versiones de Visual Studio y .NET instaladas en la máquina.
- En el caso de Windows Phone SDK 8.0 y Visual Studio Tools for Universal Windows Apps, asegúrese de que las aplicaciones cordova-windows creadas tengan todas las bibliotecas de soporte necesarias.

## Adición de {{ site.data.keys.product }} Cordova SDK
{: #adding-the-mobilefirst-cordova-sdk }
Siga las instrucciones más abajo para añadir {{ site.data.keys.product }} Cordova SDK a un proyecto nuevo o existente de Cordova, y regístrelo en {{ site.data.keys.mf_server }}.


Antes de empezar, asegúrese de que {{ site.data.keys.mf_server }} está en ejecución.
  
Si está utilizando un servidor instalado localmente: Desde una ventana de **línea de mandatos**, vaya a la carpeta del servidor y ejecute el mandato: `./run.sh`.

> **Nota:** Si está añadiendo el SDK a una aplicación existente de Cordova, el plugin sobrescribe el archivo `MainActivity.java` en Android y el archivo `Main.m` en iOS.


### Adición del SDK
{: #adding-the-sdk }
Considere la posibilidad de crear el proyecto mediante la **plantilla de aplicación** de {{ site.data.keys.product_adj }} Cordova.
La plantilla añade las entradas de plugin específicas necesarias de {{ site.data.keys.product_adj }} al archivo **config.xml** del proyecto de Cordova y proporciona un archivo **index.js** específico de {{ site.data.keys.product_adj }}, listo para ser utilizado, y que está configurado para el desarrollo de aplicaciones de {{ site.data.keys.product_adj }}.


#### Nueva aplicación
{: #new-application }
1. Cree un proyecto de Cordova: `cordova create projectName applicationId applicationName --template cordova-template-mfp`.  
Por ejemplo:


   ```bash
   cordova create Hello com.example.helloworld HelloWorld --template cordova-template-mfp
   ```
     - "Hello" es el nombre de la carpeta de la aplicación. 
     - "com.example.helloworld" es el ID de la aplicación. 
     - "HelloWorld" es el nombre de la aplicación.

     - --template modifica la aplicación con añadidos específicos de {{ site.data.keys.product_adj }}.


    > El archivo **index.js** de la plantilla permite utilizar características de {{ site.data.keys.product_adj }} adicionales como, por ejemplo, la [traducción de aplicación multilingüe](../../translation) y opciones de inicialización (consulte la documentación del usuario para obtener más información).



2. Cambie al directorio raíz del proyecto Cordova: `cd hello`

3. Añada una o más plataformas soportadas al proyecto Cordova mediante mandatos de la interfaz de línea de mandatos (CLI) de Cordova: `cordova platform add ios|android|windows`.
Por ejemplo:


   ```bash
   cordova platform add ios
   ```

   > **Nota:** Puesto que la aplicación se configuró mediante la plantilla {{ site.data.keys.product_adj }}, el plugin principal de Cordova {{ site.data.keys.product_adj }} se añadió de forma automática con la plataforma en el paso 3.


4. Prepare los recursos de la aplicación ejecutando el mandato `cordova prepare`:


   ```bash
   cordova prepare
   ```

#### Aplicación existente
{: #existing-application }
1. Vaya a la raíz de su proyecto Cordova existente y añada el plugin de Cordova principal de {{ site.data.keys.product_adj }}:


   ```bash
   cordova plugin add cordova-plugin-mfp
   ```

2. Vaya a la carpeta **www\js** y seleccione el archivo **index.js**.


3. Añada la siguiente función:


   ```javascript
   function wlCommonInit() {

   }
   ```

Los métodos de API de {{ site.data.keys.product_adj }} estarán disponibles después de que se haya cargado el SDK de cliente de {{ site.data.keys.product_adj }}.
Se llama entonces a la función `wlCommonInit`.
  
Utilice esta función para llamar a los diversos métodos de API de {{ site.data.keys.product_adj }}.

### Registro de la aplicación
{: #registering-the-application }
1. Abra la ventana de **línea de mandatos** y vaya a la raíz del proyecto Cordova.
  

2. Registre la aplicación en {{ site.data.keys.mf_server }}:

   ```bash
   mfpdev app register
   ```
    - Si se utiliza un servidor remoto, [utilice el mandato `mfpdev server add`](../../using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance) para añadirlo.


El mandato de CLI `mfpdev app register` primero se conecta a {{ site.data.keys.mf_server }} para registrar la aplicación y, a continuación, actualiza el archivo **config.xml** en la raíz del proyecto Cordova con metadatos que identifican a {{ site.data.keys.mf_server }}.

Cada plataforma se registra como una aplicación en {{ site.data.keys.mf_server }}.

> <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> **Sugerencia:** También es posible registrar aplicaciones desde {{ site.data.keys.mf_console }}:    
>
> 1. Cargue {{ site.data.keys.mf_console }}.  
> 2. Pulse el botón **Nuevo** junto a **Aplicaciones** para registrar una nueva aplicación y seguir las instrucciones en la pantalla.
  

### Utilización del SDK
{: #using-the-sdk }
Los métodos de API de {{ site.data.keys.product_adj }} estarán disponibles después de que se haya cargado el SDK de cliente de {{ site.data.keys.product_adj }}.
Se llama entonces a la función `wlCommonInit`.
  
Utilice esta función para llamar a los diversos métodos de API de {{ site.data.keys.product_adj }}.

## Actualización de {{ site.data.keys.product_adj }} Cordova SDK
{: #updating-the-mobilefirst-cordova-sdk }
Para actualizar {{ site.data.keys.product_adj }} Cordova SDK con el último release, elimine el plugin **cordova-plugin-mfp**: ejecute el mandato `cordova plugin remove cordova-plugin-mfp` y, a continuación, ejecute el mandato `cordova plugin add cordova-plugin-mfp` para añadirlo de nuevo.


Los releases de SDK se pueden encontrar en el [repositorio NPM ](https://www.npmjs.com/package/cordova-plugin-mfp) de SDK.


## Artefactos de {{ site.data.keys.product_adj }} Cordova SDK generados
{: #generated-mobilefirst-cordova-sdk-artifacts }
### config.xml
{: #configxml }
El archivo de configuración de Cordova es un archivo XML necesario que contiene metadatos de aplicación y que se almacena en el directorio raíz de la aplicación.
  
Después de que {{ site.data.keys.product_adj }} Cordova SDK se añada al proyecto, el archivo **config.xml** que genera Cordova recibe un conjunto de nuevos elementos que se identifican con el espacio de nombres `mfp:`.
Los elementos añadidos contienen información relacionada con las características {{ site.data.keys.product_adj }} y {{ site.data.keys.mf_server }}.


### Ejemplo de valores de {{ site.data.keys.product_adj }} añadidos al archivo **config.xml**
{: #example-of-mobilefirst-settings-added-to-the-configxml-file}
```xml
<?xml version='1.0'encoding='utf-8'?>
<widget id="..." xmlns:mfp="http://www.ibm.com/mobilefirst/cordova-plugin-mfp">
    <mfp:android>
        <mfp:sdkChecksum>3563350808</mfp:sdkChecksum>
        <mfp:appChecksum>0</mfp:appChecksum>
        <mfp:security>
            <mfp:testWebResourcesChecksum enabled="false" ignoreFileExtensions="png, jpg, jpeg, gif, mp4, mp3" />
        </mfp:security>
    </mfp:android>
    <mfp:windows>
        <mfp:sdkChecksum>3563350808</mfp:sdkChecksum>
       <mfp:windows10>
          <mfp:sdkChecksum>...</mfp:sdkChecksum>          
          <mfp:security>
             <mfp:testWebResourcesChecksum/>
          </mfp:security>
    </mfp:windows>
    <mfp:platformVersion>8.0.0.00-20151214-1255</mfp:platformVersion>
    <mfp:clientCustomInit enabled="false" />
    <mfp:server runtime="mfp" url="http://10.0.0.1:9080" />
    <mfp:directUpdateAuthenticityPublicKey>the-key</mfp:directUpdateAuthenticityPublicKey>
    <mfp:languagePreferences>en</mfp:languagePreferences>
</widget>
```

<div class="panel-group accordion" id="config-xml" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="config-xml-properties">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#config-xml-properties" data-target="#collapse-config-xml-properties" aria-expanded="false" aria-controls="collapse-config-xml-properties"><b>Pulse para ver la lista completa de propiedades de config.xml</b></a>
            </h4>
        </div>

        <div id="collapse-config-xml-properties" class="panel-collapse collapse" role="tabpanel" aria-labelledby="config-xml-properties">
            <div class="panel-body">
                <table class="table table-striped">
                    <tr>
                        <td><b>Elemento</b></td>
                        <td><b>Descripción </b></td>
                        <td><b>Configuración</b></td>
                    </tr>
                    <tr>
                        <td><b>widget</b></td>
                        <td>Elemento raíz del <a href="http://cordova.apache.org/docs/en/dev/config_ref/index.html">documento config.xml</a>. El elemento contiene dos atributos necesarios: <ul><li><b>id</b>: Nombre del paquete de aplicación que se especificó cuando se creó el proyecto Cordova. Si este valor se cambia manualmente después de se haya registrado la aplicación con {{ site.data.keys.mf_server }}, la aplicación se debe registrar de nuevo. </li><li><b>xmlns:mfp</b>: Espacio de nombres XML del plugin {{ site.data.keys.product_adj }}. </li></ul></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td><b>mfp:platformVersion</b></td>
                        <td>Necesario. Versión del producto con la que se desarrolló el la aplicación. </td>
                        <td>Establecido de forma predeterminada. No se debe cambiar. </td>
                    </tr>
                    <tr>
                        <td><b>mfp:directUpdateAuthenticityPublicKey</b></td>
                        <td>Opcional. Cuando se habilita la característica de autenticidad de Direct Update, el paquete Direct Update se firma digitalmente durante el despliegue. Después de que el cliente baje el paquete, se realiza una comprobación de seguridad para validar la autenticidad del paquete. El valor de serie es la clave pública que se utilizará para autenticar el archivo .zip de Direct Update. </td>
                        <td>Configúrelo con el mandato <code>mfpdev app config direct_update_authenticity_public_key key-value</code>. </td>
                    </tr>
                    <tr>
                        <td><b>mfp:languagePreferences</b></td>
                        <td>Opcional. Contiene una lista separada por comas de entornos locales para visualizar los mensajes del sistema. </td>
                        <td>Configúrelo con el mandato <code>mfpdev app config language_preferences key-value</code>. </td>
                    </tr>
                    <tr>
                        <td><b>mfp:clientCustomInit</b></td>
                        <td>Controla la forma en la que se llama al método <code>WL.Client.init</code>. De forma predeterminada, este valor se establece en false y se llama al método <code>WL.Client.init</code> de forma automática después de que se haya instalado el plugin {{ site.data.keys.product_adj }}. Establezca este valor en <b>true</b> para que el código del cliente controle de forma explícita al llamar a <code>WL.Client.init</code>. </td>
                        <td>Editado manualmente. Los valores del atributo <b>enabled</b> son <b>true</b> o <b>false</b>.</td>
                    </tr>
                    <tr>
                        <td><b>mfp:server</b></td>
                        <td>La información de conexión del servidor remoto predeterminado. La aplicación de cliente utiliza esta información para comunicarse con {{ site.data.keys.mf_server }}. <ul><li><b>url:</b> El valor de url especifica el protocolo, host y valores de puerto de {{ site.data.keys.mf_server }} que el cliente utilizará de forma predeterminada para conectarse al servidor. </li><li><b>runtime:</b> El valor de tiempo de ejecución especifica el tiempo de ejecución de {{ site.data.keys.mf_server }} en el que se registró la aplicación. Para obtener más información sobre el tiempo de ejecución de {{ site.data.keys.product_adj }}, consulte la visión general de {{ site.data.keys.mf_server }}. </li></ul></td>
                        <td><ul><li>El valor del url de servidor se configura con el mandato <code>mfpdev app config server</code>. </li><li>El valor del tiempo de ejecución del servidor se establece con el mandato <code>mfpdev app config runtime</code>. </li></ul></td>
                    </tr>
                    <tr>
                        <td><b>mfp:ios</b></td>
                        <td>Este elemento contiene toda la configuración de la aplicación de cliente relacionada con {{ site.data.keys.product_adj }} en la plataforma iOS. <ul><li><b>mfp:appChecksum</b></li><li><b>mfp:sdkChecksum</b></li><li><b>mfp:security</b></li></ul></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td><b>mfp:android</b></td>
                        <td>Este elemento contiene toda la configuración de la aplicación de cliente relacionada con {{ site.data.keys.product_adj }} en la plataforma Android. <ul><li><b>mfp:appChecksum</b></li><li><b>mfp:sdkChecksum</b></li><li><b>mfp:security</b></li></ul></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td><b>mfp:windows</b></td>
                        <td>Este elemento contiene toda la configuración de la aplicación de cliente relacionada con {{ site.data.keys.product_adj }} en la plataforma Windows. <ul><li><b>mfp:appChecksum</b></li><li><b>mfp:windowsphone8</b></li><li><b>mfp:windows8</b></li><li><b>mfp:windows10</b></li></ul></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td><b>mfp:windows8</b></td>
                        <td>Este elemento contiene toda la configuración de la aplicación de cliente relacionada con {{ site.data.keys.product_adj }} en las plataformas Windows 8.1. <ul><li><b>mfp:sdkChecksum</b></li><li><b>mfp:security</b></li></ul></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td><b>mfp:windows10</b></td>
                        <td>Este elemento contiene toda la configuración de la aplicación de cliente relacionada con {{ site.data.keys.product_adj }} en las plataformas Windows 10. <ul><li><b>mfp:sdkChecksum</b></li><li><b>mfp:security</b></li></ul></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td><b>mfp:windowsphone8</b></td>
                        <td>Este elemento contiene toda la configuración de la aplicación de cliente relacionada con {{ site.data.keys.product_adj }} en las plataformas Windows 8.1. <ul><li><b>mfp:sdkChecksum</b></li><li><b>mfp:security</b></li></ul></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td><b>mfp:appChecksum</b></td>
                        <td>Este valor es la suma de comprobación de los recursos web de la aplicación. Se calcula al ejecutar <code>mfpdev app webupdate</code>. </td>
                        <td>No es configurable por parte del usuario. El valor de la suma de comprobación se actualiza cuando se ejecuta el mandato <code>mfpdev app webupdate</code>. Para obtener más detalles sobre el mandato <code>mfpdev app webupdate</code>, escriba <code>mfpdev help app webupdate</code> en su ventana de mandatos. </td>
                    </tr>
                    <tr>
                        <td><b>mfp:sdkChecksum</b></td>
                        <td>Este valor es la suma de comprobación de {{ site.data.keys.mf_console }} SDK que se utiliza para identificar niveles de SDK de {{ site.data.keys.product_adj }}. </td>
                        <td>No es configurable por parte del usuario. Este valor se establece de forma predeterminada.</td>
                    </tr>
                    <tr>
                        <td><b>mfp:security</b></td>
                        <td>Este elemento contiene la configuración específica de la plataforma de la aplicación de cliente para la seguridad de {{ site.data.keys.product_adj }}. Contiene<ul><li><b>mfp:testWebResourcesChecksum</b></li></ul></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td><b>mfp:testWebResourcesChecksum</b></td>
                        <td>Controla si la aplicación verifica la integridad de sus recursos web cada vez que empieza a ejecutarse en el dispositivo móvil. Atributos: <ul><li><b>enabled:</b> Los valores válidos son <b>true</b> y <b>false</b>. Si este atributo se establece en <b>true</b>, la aplicación calcula la suma de comprobación de sus recursos web y compara esta suma de comprobación con un valor que se almacenó la primera vez que se ejecutó la aplicación. </li><li><b>ignoreFileExtensions:</b> Cálculo de suma de comprobación que puede tardar unos segundos, dependiendo del tamaño de los recursos web. Para hacerlo más rápido, puede proporcionar una lista de extensiones de archivo que se pueden ignorar en este cálculo. Este valor se ignora cuando el valor del atributo <b>enabled</b> es <b>false</b>. </li></ul></td>
                        <td><ul><li>El atributo <b>enabled</b> se establece con el mandato <code>mfpdev app config android_security_test_web_resources_checksum key-value</code>. </li><li>El atributo <b>ignoreFileExtensions</b> se establece con el mandato <code>mfpdev app config android_security_ignore_file_extensions value</code>. </li></ul></td>
                    </tr>
                </table>

                <br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#config-xml-properties" data-target="#collapse-config-xml-properties" aria-expanded="false" aria-controls="collapse-config-xml-properties"><b>Sección de cierre</b></a>
            </div>
        </div>
    </div>
</div>

### Edición de los valores de {{ site.data.keys.product_adj }} en el archivo config.xml 
{: #editing-mobilefirst-settings-in-the-configxml-file }
Utilice {{ site.data.keys.mf_cli }} para editar los valores anteriores ejecutando el mandato:


```bash
mfpdev app config
```

## Guías de aprendizaje con las que continuar 
{: #tutorials-to-follow-next }
Con {{ site.data.keys.product_adj }} Cordova SDK ahora integrado, podrá:


- Revisar las guías de aprendizaje de [Utilización de {{ site.data.keys.product }} SDK](../)
- Revisar las guías de aprendizaje de [Desarrollo de adaptadores](../../../adapters/)
- Revisar las guías de aprendizaje de [Autenticación y seguridad](../../../authentication-and-security/)
- Revisar las guías de aprendizaje de [Notificaciones](../../../notifications/) 
- Revisar [Todas las guías de aprendizaje](../../../all-tutorials)
