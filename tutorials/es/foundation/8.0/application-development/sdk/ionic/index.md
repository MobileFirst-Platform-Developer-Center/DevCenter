---
layout: tutorial
title: Adición del SDK de MobileFirst Foundation a aplicaciones Ionic
breadcrumb_title: Ionic
relevantTo: [ionic]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
En esta guía de aprendizaje, aprenderá a añadir el SDK de {{ site.data.keys.product_adj }} a una aplicación Ionic nueva o existente, creada con la CLI de Ionic. También aprenderá a configurar {{ site.data.keys.mf_server }} para que reconozca la aplicación, y a buscar información sobre los archivos de configuración de {{ site.data.keys.product_adj }} que se cambian en el proyecto.

El SDK de {{ site.data.keys.product_adj }} Ionic se proporciona como un conjunto de Typescript Wrappers junto con los plug-ins de Cordova y se registra en [NPM](https://www.npmjs.com/package/cordova-plugin-mfp).  

Los plugins disponibles son:

* **cordova-plugin-mfp** - El núcleo de SDK
* **cordova-plugin-mfp-push** - Proporciona soporte de notificaciones push
* **cordova-plugin-mfp-jsonstore** - Proporciona soporte JSONStore


### Niveles de soporte
{: #support-levels }
Las versiones de la plataforma Ionic Cordova soportadas por los plug-ins de MobileFirst son:

* cordova-ios: **>= 4.1.1 y < 5.0**
* cordova-android: **>= 6.1.2 y < 7.0**
* cordova-windows: **>= 4.3.2 y < 6.0**

### Ir a:
{: #jump-to }
- [Componentes del SDK de Ionic](#ionic-sdk-components)
- [Adición del SDK de {{ site.data.keys.product_adj }} Ionic](#adding-the-mobilefirst-ionic-sdk)
- [Actualización del SDK de {{ site.data.keys.product_adj }} Ionic](#updating-the-mobilefirst-ionic-sdk)
- [Artefactos generados del SDK de {{ site.data.keys.product_adj }} Ionic](#generated-mobilefirst-ionic-sdk-artifacts)
- [Guías de aprendizaje con las que continuar](#tutorials-to-follow-next)

## Componentes del SDK de Ionic
{: #ionic-sdk-components }
#### cordova-plugin-mfp
{: #cordova-plugin-mfp }
El plug-in *cordova-plugin-mfp* es el plug-in principal de {{ site.data.keys.product_adj }} para Cordova y es necesario. Si instala cualquier otro plug-in de {{ site.data.keys.product_adj }}, también se instala automáticamente el plug-in *cordova-plugin-mfp* en el caso de que todavía no lo esté.

> Los siguientes plugins de Cordova se instalan como dependencias de cordova-plugin-mfp:
>   
>    - cordova-plugin-device
>    - cordova-plugin-dialogs
>    - cordova-plugin-globalization
>    - cordova-plugin-okhttp

#### cordova-plugin-mfp-jsonstore
{: #cordova-plugin-mfp-jsonstore }
El plugin de *cordova-plugin-mfp-jsonstore* habilita que su aplicación utilice JSONstore. Para obtener más información sobre JSONstore, consulte la [guía de aprendizaje de JSONStore](../../jsonstore/cordova/).  

#### cordova-plugin-mfp-push
{: #cordova-plugin-mfp-push }
El plugin *cordova-plugin-mfp-push* proporciona los permisos necesarios para utilizar notificaciones push desde {{ site.data.keys.mf_server }} para aplicaciones Android. Se necesita una configuración adicional para utilizar notificaciones push. Para obtener más información sobre las notificaciones push, consulte la guía de aprendizaje de [Notificaciones push](../../../notifications/).

#### cordova-plugin-mfp-fips
{: #cordova-plugin-mfp-fips }
El plugin *cordova-plugin-mfp-fips* proporciona soporte FIPS 140-2 para la plataforma Android. Para obtener más información, consulte el apartado [Soporte FIPS 140-2](../../../administering-apps/federal/#fips-140-2-support).

#### cordova-plugin-mfp-encrypt-utils
{: #cordova-plugin-mfp-encrypt-utils }
El plugin *cordova-plugin-mfp-encrypt-utils* proporciona infraestructuras de cifrado iOS OpenSSL para las aplicaciones Cordova con la plataforma iOS. Para obtener más información, consulte [Habilitación de OpenSSL para Cordova iOS](../cordova/additional-information).

**Requisitos previos:**

- [CLI de Ionic](https://www.npmjs.com/package/ionic) y {{ site.data.keys.mf_cli }} están instalados en la estación de trabajo del desarrollador.
- Una instancia remota o local de {{ site.data.keys.mf_server }} que esté en ejecución.
- Lea las guías de aprendizaje [
Configuración del entorno de desarrollo de {{ site.data.keys.product_adj }}](../../../installation-configuration/development/mobilefirst) y [Configuración del entorno de desarrollo de Cordova](../../../installation-configuration/development/cordova).
- Para cordova-windows, debe instalarse una versión de Visual C++ que sea compatible con las versiones de Visual Studio y .NET instaladas en la máquina.
- En el caso de Visual Studio Tools for Universal Windows Apps, asegúrese de que las aplicaciones cordova-windows creadas tengan todas las bibliotecas de soporte necesarias.

## Adición del SDK de {{ site.data.keys.product }} Ionic
{: #adding-the-mobilefirst-ionic-sdk }
Siga las instrucciones siguientes para añadir el SDK de {{ site.data.keys.product }} Ionic a un proyecto nuevo o existente de Ionic, y regístrelo en {{ site.data.keys.mf_server }}.

Antes de empezar, asegúrese de que {{ site.data.keys.mf_server }} está en ejecución.  
Si está utilizando un servidor instalado localmente, desde una ventana de **línea de mandatos**, vaya a la carpeta del servidor y ejecute el mandato: `./run.sh`.

### Adición del SDK
{: #adding-the-sdk }
Considere la posibilidad de crear el proyecto mediante la **plantilla de aplicación** de {{ site.data.keys.product_adj }}. La plantilla añade las entradas de plug-in específicas necesarias de {{ site.data.keys.product_adj }} al archivo **config.xml** del proyecto de Ionic y proporciona un archivo **index.js** específico de {{ site.data.keys.product_adj }}, listo para ser utilizado, y que está configurado para el desarrollo de aplicaciones de {{ site.data.keys.product_adj }}.

#### Nueva aplicación
{: #new-application }
1. Cree un proyecto de Ionic: `ionic start projectName starter-template`.  
   Por ejemplo:

   ```bash
   ionic start Hello blank
   ```
     - "Hello" es el nombre de carpeta y el nombre de la aplicación.
     - "blank" es el nombre de la plantilla de iniciador.

    El archivo **index.js** de la plantilla permite utilizar características de {{ site.data.keys.product_adj }} adicionales como, por ejemplo, la [traducción de aplicación multilingüe](../../translation) y opciones de inicialización (consulte la documentación del usuario para obtener más información).

2. Cambie el directorio a la raíz del proyecto de Ionic: `cd hello`

3. Añada los plug-ins de MobileFirst utilizando el mandato de la CLI de Ionic: `ionic cordova plugin add cordova-plugin-name`
Por ejemplo:

   ```bash
   ionic cordova plugin add cordova-plugin-mfp
   ```

   > El mandato anterior añade el plug-in del SDK de MobileFirst Core al proyecto de Ionic.

4. Añada una o más plataformas soportadas al proyecto de Cordova mediante el mandato de la CLI de Ionic: `ionic cordova platform add ios|android|windows|browser`. Por ejemplo:

   ```bash
   cordova platform add ios
   ```

4. Prepare los recursos de la aplicación ejecutando el `mandato ionic cordova prepare`:

   ```bash
   ionic cordova prepare
   ```

#### Aplicación existente
{: #existing-application }

Vaya a la raíz de su proyecto Ionic existente y añada el plug-in de Ionic Cordova central de {{ site.data.keys.product_adj }}:

   ```bash
   ionic cordova plugin add cordova-plugin-mfp
   ```

Los métodos de API de {{ site.data.keys.product_adj }} estarán disponibles después de que se haya cargado el SDK de cliente de {{ site.data.keys.product_adj }}. Se llama entonces al suceso `mfjsloaded`.  

### Registro de la aplicación
{: #registering-the-application }
1. Abra una ventana de **línea de mandatos** y vaya a la raíz del proyecto Ionic.  

2. Registre la aplicación en {{ site.data.keys.mf_server }}:

   ```bash
   mfpdev app register
   ```
    - Si se utiliza un servidor remoto, [utilice el mandato ](../../using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance)  `mfpdev server add` para añadirlo.

El mandato de CLI `mfpdev app register` primero se conecta a {{ site.data.keys.mf_server }} para registrar la aplicación y, a continuación, actualiza el archivo **config.xml** en la raíz del proyecto Ionic con metadatos que identifican a {{ site.data.keys.mf_server }}.

Cada plataforma se registra como una aplicación en {{ site.data.keys.mf_server }}.

> <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> **Sugerencia:** También es posible registrar aplicaciones desde {{ site.data.keys.mf_console }}:    
>
> 1. Cargue {{ site.data.keys.mf_console }}.  
> 2. Pulse el botón **Nuevo** junto a **Aplicaciones** para registrar una nueva aplicación y seguir las instrucciones en la pantalla.  

### Utilización del SDK
{: #using-the-sdk }
Los métodos de API de {{ site.data.keys.product_adj }} estarán disponibles después de que se haya cargado el SDK de cliente de {{ site.data.keys.product_adj }}. Se llama entonces al suceso `mfjsloaded`.  
Llame a los diversos métodos de la API de {{ site.data.keys.product_adj }} solo después de que se haya llamado al suceso.

## Actualización del SDK de {{ site.data.keys.product_adj }} Ionic
{: #updating-the-mobilefirst-ionic-sdk }
Para actualizar el SDK de {{ site.data.keys.product_adj }} Ionic Cordova con el último release, elimine el plug-in **cordova-plugin-mfp**: ejecute el mandato `ionic cordova plugin remove cordova-plugin-mfp` y, a continuación, ejecute el mandato `ionic cordova plugin add cordova-plugin-mfp` para añadirlo de nuevo.

Los releases de SDK se pueden encontrar en el [repositorio NPM ](https://www.npmjs.com/package/cordova-plugin-mfp) de SDK.

## Artefactos generados del SDK de {{ site.data.keys.product_adj }} Ionic
{: #generated-mobilefirst-ionic-sdk-artifacts }
### config.xml
{: #configxml }
El archivo de configuración de Ionic es un archivo XML necesario que contiene metadatos de aplicación y que se almacena en el directorio raíz de la aplicación.  
Después de que el SDK de {{ site.data.keys.product_adj }} Ionic se añada al proyecto, el archivo **config.xml** que genera Ionic recibe un conjunto de nuevos elementos que se identifican con el espacio de nombres `mfp:`. Los elementos añadidos contienen información relacionada con las características {{ site.data.keys.product_adj }} y {{ site.data.keys.mf_server }}.

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
                        <td>Elemento raíz del <a href="http://cordova.apache.org/docs/en/dev/config_ref/index.html">documento config.xml</a>. El elemento contiene dos atributos necesarios: <ul><li><b>id</b>: Nombre del paquete de aplicación que se especificó cuando se creó el proyecto Cordova. Si este valor se cambia manualmente después de se haya registrado la aplicación con {{ site.data.keys.mf_server }}, la aplicación se debe registrar de nuevo.</li><li><b>xmlns:mfp</b>: Espacio de nombres XML del plugin {{ site.data.keys.product_adj }}.</li></ul></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td><b>mfp:platformVersion</b></td>
                        <td>Necesario. Versión del producto con la que se desarrolló el la aplicación.</td>
                        <td>Establecido de forma predeterminada. No se debe cambiar.</td>
                    </tr>
                    <tr>
                        <td><b>mfp:directUpdateAuthenticityPublicKey</b></td>
                        <td>Opcional. Cuando se habilita la característica de autenticidad de Direct Update, el paquete Direct Update se firma digitalmente durante el despliegue. Después de que el cliente baje el paquete, se realiza una comprobación de seguridad para validar la autenticidad del paquete. El valor de serie es la clave pública que se utilizará para autenticar el archivo .zip de Direct Update.</td>
                        <td>Configúrelo con el mandato <code>mfpdev app config direct_update_authenticity_public_key key-value</code>.</td>
                    </tr>
                    <tr>
                        <td><b>mfp:languagePreferences</b></td>
                        <td>Opcional. Contiene una lista separada por comas de entornos locales para visualizar los mensajes del sistema.</td>
                        <td>Configúrelo con el mandato <code>mfpdev app config language_preferences key-value</code>.</td>
                    </tr>
                    <tr>
                        <td><b>mfp:clientCustomInit</b></td>
                        <td>Controla la forma en la que se llama al método <code>WL.Client.init</code>. De forma predeterminada, este valor se establece en false y se llama al método <code>WL.Client.init</code> de forma automática después de que se haya instalado el plugin {{ site.data.keys.product_adj }}. Establezca este valor en <b>true</b> para que el código del cliente controle de forma explícita al llamar a <code>WL.Client.init</code>.</td>
                        <td>Editado manualmente. Los valores del atributo <b>enabled</b> son <b>true</b> o <b>false</b>.</td>
                    </tr>
                    <tr>
                        <td><b>mfp:server</b></td>
                        <td>La información de conexión del servidor remoto predeterminado. La aplicación de cliente utiliza esta información para comunicarse con {{ site.data.keys.mf_server }}. <ul><li><b>url:</b> El valor de url especifica el protocolo, host y valores de puerto de {{ site.data.keys.mf_server }} que el cliente utilizará de forma predeterminada para conectarse al servidor.</li><li><b>runtime:</b> El valor de tiempo de ejecución especifica el tiempo de ejecución de {{ site.data.keys.mf_server }} en el que se registró la aplicación. Para obtener más información sobre el tiempo de ejecución de {{ site.data.keys.product_adj }}, consulte la visión general de {{ site.data.keys.mf_server }}.</li></ul></td>
                        <td><ul><li>El valor del url de servidor se configura con el mandato <code>mfpdev app config server</code>.</li><li>El valor del tiempo de ejecución del servidor se establece con el mandato <code>mfpdev app config runtime</code>.</li></ul></td>
                    </tr>
                    <tr>
                        <td><b>mfp:ios</b></td>
                        <td>Este elemento contiene toda la configuración de la aplicación de cliente relacionada con {{ site.data.keys.product_adj }} en la plataforma iOS.<ul><li><b>mfp:appChecksum</b></li><li><b>mfp:sdkChecksum</b></li><li><b>mfp:security</b></li></ul></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td><b>mfp:android</b></td>
                        <td>Este elemento contiene toda la configuración de la aplicación de cliente relacionada con {{ site.data.keys.product_adj }} en la plataforma Android.<ul><li><b>mfp:appChecksum</b></li><li><b>mfp:sdkChecksum</b></li><li><b>mfp:security</b></li></ul></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td><b>mfp:windows</b></td>
                        <td>Este elemento contiene toda la configuración de la aplicación de cliente relacionada con {{ site.data.keys.product_adj }} en la plataforma Windows.<ul><li><b>mfp:appChecksum</b></li><li><b>mfp:windowsphone8</b></li><li><b>mfp:windows8</b></li><li><b>mfp:windows10</b></li></ul></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td><b>mfp:windows8</b></td>
                        <td>Este elemento contiene toda la configuración de la aplicación de cliente relacionada con {{ site.data.keys.product_adj }} en las plataformas Windows 8.1.
                        <ul><li><b>mfp:sdkChecksum</b></li><li><b>mfp:security</b></li></ul></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td><b>mfp:windows10</b></td>
                        <td>Este elemento contiene toda la configuración de la aplicación de cliente relacionada con {{ site.data.keys.product_adj }} en las plataformas Windows 10.
                        <ul><li><b>mfp:sdkChecksum</b></li><li><b>mfp:security</b></li></ul></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td><b>mfp:windowsphone8</b></td>
                        <td>Este elemento contiene toda la configuración de la aplicación de cliente relacionada con {{ site.data.keys.product_adj }} en las plataformas Windows 8.1.
                        <ul><li><b>mfp:sdkChecksum</b></li><li><b>mfp:security</b></li></ul></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td><b>mfp:appChecksum</b></td>
                        <td>Este valor es la suma de comprobación de los recursos web de la aplicación. Se calcula al ejecutar <code>mfpdev app webupdate</code>.</td>
                        <td>No es configurable por parte del usuario. El valor de la suma de comprobación se actualiza cuando se ejecuta el mandato <code>mfpdev app webupdate</code>. Para obtener más detalles sobre el mandato <code>mfpdev app webupdate</code>, escriba <code>mfpdev help app webupdate</code> en su ventana de mandatos.</td>
                    </tr>
                    <tr>
                        <td><b>mfp:sdkChecksum</b></td>
                        <td>Este valor es la suma de comprobación de {{ site.data.keys.mf_console }} SDK que se utiliza para identificar niveles de SDK de {{ site.data.keys.product_adj }}.</td>
                        <td>No es configurable por parte del usuario. Este valor se establece de forma predeterminada.</td>
                    </tr>
                    <tr>
                        <td><b>mfp:security</b></td>
                        <td>Este elemento contiene la configuración específica de la plataforma de la aplicación de cliente para la seguridad de {{ site.data.keys.product_adj }}. Contiene<ul><li><b>mfp:testWebResourcesChecksum</b></li></ul></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td><b>mfp:testWebResourcesChecksum</b></td>
                        <td>Controla si la aplicación verifica la integridad de sus recursos web cada vez que empieza a ejecutarse en el dispositivo móvil. Atributos: <ul><li><b>enabled:</b> Los valores válidos son <b>true</b> y <b>false</b>. Si este atributo se establece en <b>true</b>, la aplicación calcula la suma de comprobación de sus recursos web y compara esta suma de comprobación con un valor que se almacenó la primera vez que se ejecutó la aplicación.</li><li><b>ignoreFileExtensions:</b> Cálculo de suma de comprobación que puede tardar unos segundos, dependiendo del tamaño de los recursos web. Para hacerlo más rápido, puede proporcionar una lista de extensiones de archivo que se pueden ignorar en este cálculo. Este valor se ignora cuando el valor del atributo <b>enabled</b> es <b>false</b>.</li></ul></td>
                        <td><ul><li>El atributo <b>enabled</b> se establece con el mandato <code>mfpdev app config android_security_test_web_resources_checksum key-value</code>.</li><li>El atributo <b>ignoreFileExtensions</b> se establece con el mandato <code>mfpdev app config android_security_ignore_file_extensions value</code>.</li></ul></td>
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
Con el SDK de {{ site.data.keys.product_adj }} Ionic ahora integrado, podrá:

- Revisar las guías de aprendizaje de [Utilización de {{ site.data.keys.product }} SDK](../)
- Revisar las guías de aprendizaje de [Desarrollo de adaptadores](../../../adapters/)
- Revisar las guías de aprendizaje de [Autenticación y seguridad](../../../authentication-and-security/)
- Revisar las guías de aprendizaje de [Notificaciones](../../../notifications/)
- Revisar [Todas las guías de aprendizaje](../../../all-tutorials)
