---
layout: tutorial
title: Utilización de la CLI de MobileFirst para gestionar artefactos de MobileFirst
breadcrumb_title: Using the MobileFirst CLI
weight: 2
relevantTo: [ios,android,windows,javascript]
---
## Visión general
{: #overview }
{{ site.data.keys.product_full }} proporciona una herramienta de interfaz de línea de mandatos (CLI) a los desarrolladores, **mfpdev**, para gestionar con facilidad artefactos de servidor y de cliente.
  
Mediante la CLI podrá gestionar aplicaciones basadas en Cordova que utilicen el plugin {{ site.data.keys.product_adj }} y aplicaciones que utilicen {{ site.data.keys.product_adj }} Native SDK.

También podrá crear, registrar y gestionar adaptadores en instancias de {{ site.data.keys.mf_server }} locales y remotas así como administrar proyectos desde la línea de mandatos o a través de los servicios REST o desde {{ site.data.keys.mf_console }}.


Los mandatos **mfpdev** tienen dos modalidades: la modalidad interactiva y la modalidad directa.
En la modalidad interactiva, se especifican mandatos sin opciones y a medida que es necesario se le solicitan respuestas.
En la modalidad directa, se especifica un mandato completo, incluidas las opciones, sin que se le solicite información.
Cuando corresponda, los indicadores de solicitud son sensibles al contexto para la plataforma de destino de la aplicación, tal como lo determina el directorio desde el que se ejecuta el mandato.
Utilice las teclas de cursor del teclado para moverse a través de las selecciones y pulse la tecla Intro cuando la selección que desee esté resaltada y seguida por el carácter ">".


En esta guía de aprendizaje aprenderá a instalar el `mfpdev` CLI (Command Line Interface) y cómo utilizarlo para gestionar instancias, aplicaciones y adaptadores de {{ site.data.keys.mf_server }}.


> Para obtener más información con relación a la integración de SDK en aplicaciones Cordova y nativas, consulte las guías de aprendizaje en la categoría de [Adición de {{ site.data.keys.product }} SDK](../../application-development/sdk/).


#### Ir a 
{: #jump-to }
* [Requisitos previos](#prerequisites)
* [Instalación de {{ site.data.keys.mf_cli }}](#installing-the-mobilefirst-cli)
* [Lista de mandatos de CLI](#list-of-cli-commands)
* [Modalidad directa e interactiva](#interactive-and-direct-modes)
* [Gestión de instancias de {{ site.data.keys.mf_server }}](#managing-mobilefirst-server-instances)
* [Gestión de aplicaciones](#managing-applications)
* [Gestión y realización de pruebas con adaptadores](#managing-and-testing-adapters)
* [Mandatos de utilidad](#helpful-commands)
* [Actualización y desinstalación de la interfaz de línea de mandatos](#update-and-uninstall-the-command-line-interface)

## Requisitos previos
{: #prerequisites }
{{ site.data.keys.mf_cli }} está disponible como un paquete NPM en el [registro NPM](https://www.npmjs.com/).  

Asegúrese de que **node.js** y **npm** estén instalados en el entorno de desarrollo con el propósito de instalar paquetes NPM.
  
Siga las instrucciones de instalación en [nodejs.org](https://nodejs.org) para instalar node.js.

Para confirmar que node.js está correctamente instalado, ejecute el mandato `node -v`.

```bash
node -v
v6.11.1
```

> **Nota:** La versión de **node.js** mínima soportada es **4.2.3**. Además, con los paquetes en rápida evolución de **node** y **npm**, la CLI de MobileFirst puede no ser totalmente funcional con todas las versiones disponibles de **node** y **npm** incluidas las versiones más recientes.  
> 
> Para las versiones de la CLI de MobileFirst hasta iFix versión 8.0.2018040312, inclusive, asegúrese de que **node** tenga la versión **6.11.1** y que **npm** tenga la versión **3.10.10**, para el funcionamiento adecuado de la CLI.
>
> Para la CLI de MobileFirst iFix versiones 8.0.2018100112 y posteriores, puede utilizar Node versión 8.x o 10.x

## Instalación de {{ site.data.keys.mf_cli }}
{: #installing-the-mobilefirst-cli }
Para instalar la interfaz de línea de mandatos ejecute el mandato:


```bash
npm install -g mfpdev-cli --no-optional
```


Si el archivo .zip de la interfaz de línea de mandatos (CLI) se descargó desde el Centro de descargas de {{ site.data.keys.mf_console }}, utilice el mandato:


```bash
npm install -g <path-to-mfpdev-cli.tgz>
```

- Si desea instalar la CLI sin dependencias opcionales añada el distintivo `--no-optional`:  `npm install -g --no-optional path-to-mfpdev-cli.tgz`

Para confirmar la instalación, ejecute el mandato `mfpdev` sin argumentos de forma que imprima el texto de ayuda:


```shell
NAME
     IBM MobileFirst Foundation Command Line Interface (CLI).

SYNOPSIS
     mfpdev <command> [options]

DESCRIPTION
     The IBM MobileFirst Foundation Command Line Interface (CLI) is a command-line
     for developing MobileFirst applications. The command-line can be used by itself, or in conjunction
     with the IBM MobileFirst Foundation Operations Console. Some functions are available from  
     the command-line only and not the console.

     For more information and a step-by-step example of using the CLI, see the IBM Knowledge Center for
     your version of IBM MobileFirst Foundation at

          https://www.ibm.com/support/knowledgecenter.
    ...
    ...
    ...
```

## Lista de mandatos de CLI
{: #list-of-cli-commands }

|Prefijo de mandato |Acción de mandato |Descripción |
|---------------------------------------------------------------|----------------------------------------------|-------------------------------------------------------------------------|
|`mfpdev app`	                                                |register                                     |Registra su aplicación con {{ site.data.keys.mf_server }}.                           |
|                                                               |config                                       |Permite especificar el tiempo de ejecución y el servidor de fondo para que los utilice su aplicación. Además, para las aplicaciones de Cordova, permite configurar varios aspectos adicionales como, por ejemplo, el idioma predeterminado para los mensajes del sistema o si es necesario realizar una suma de comprobación. Se incluyen otros parámetros de configuración para aplicaciones de Cordova. |
|                                                               |pull                                         |Recupera una configuración de aplicación existente desde el servidor. |
|                                                               |push                                         |Envía una configuración de aplicación al servidor. |
|                                                               |preview                                      |Habilita obtener una vista previa de su aplicación de Cordova sin que sea necesario el dispositivo real en el tipo de plataforma de destino. Podrá visualizar la vista previa tanto en {{ site.data.keys.mf_mbs }} como en su navegador. |
|                                                               |webupdate                                    |Empaqueta los recursos de la aplicación contenidos en el directorio www en un archivo .zip que se puede utilizar para el proceso de Direct Update. |
|mfpdev server	                                                |info                                         |Visualiza información sobre {{ site.data.keys.mf_server }}.                      |
|                                                               |add                                          |Añade una nueva definición de servidor a su entorno. |
|                                                               |edit                                         |Habilita la edición de definiciones de servidor. |
|                                                               |remove                                       |Elimina una definición de servidor del entorno. |
|                                                               |console                                      |Abre {{ site.data.keys.mf_console }}.                               |
|                                                               |clean                                        |Anula el registro de aplicaciones y elimina adaptadores de {{ site.data.keys.mf_server }}.      |
|mfpdev adapter                                                |create                                       |Crea un adaptador. |
|                                                               |build                                        |Compila un adaptador. |
|                                                               |build all                                    |Encuentra y compila todos los adaptadores en el directorio actual y sus subdirectorios. |
|                                                               |deploy                                       |Despliega un adaptador en {{ site.data.keys.mf_server }}.                           |
|                                                               |deploy all                                   |Encuentra todos los adaptadores en el directorio actual y sus subdirectorios, y los despliega en {{ site.data.keys.mf_server }}. |
|                                                               |call                                         |Llama a un procedimiento de adaptador en {{ site.data.keys.mf_server }}.                 |
|                                                               |pull                                         |Recupera una configuración de adaptador existente desde el servidor. |
|                                                               |push                                         |Envía una configuración de adaptador al servidor. |
|mfpdev                                                        |config                                       |Establece las preferencias de configuración para el tipo de navegador de vista previa, el valor del tiempo de espera de vista previa y el valor de tiempo de espera de servidor para la interfaz de línea de mandatos mfpdev. |
|                                                               |info                                         |Visualiza información sobre el entorno, incluido el sistema operativo, el consumo de memoria, la versión del nodo y la versión de la interfaz de línea de mandatos. Si el directorio actual corresponde a una aplicación de Cordova, también se visualiza la información que proporciona el mandato cordova info de Cordova. |
|                                                               |-v                                           |Visualiza el número de versión de la instancia de {{ site.data.keys.mf_cli }} actualmente en uso. |
|                                                               |-d, --debug                                  |Modalidad de depuración: Genera la salida de depuración. |
|                                                               |-dd, --ddebug                                |Modalidad de depuración detallada: Genera la salida de depuración detallada. |
|                                                               |-no-color                                    |Suprime la utilización del color en la salida del mandato. |
|mfpdev help                                                   |nombre del mandato|Visualiza ayuda para los mandatos {{ site.data.keys.mf_cli }} (mfpdev). Con argumentos, visualiza texto de ayuda más específico para cada mandato o tipo de mandato. Por ejemplo, "mfpdev help server add" |

## Modalidad directa e interactiva
{: #interactive-and-direct-modes }
Todos los mandatos se pueden ejecutar en la modalidad **interactiva** o **directa**. En la modalidad interactiva, se le solicitarán para el mandato los parámetros necesarios y se utilizarán algunos valores predeterminados.
En la modalidad directa, se deben proporcionar parámetros con el mandato que se está ejecutando. 

Ejemplo: 

`mfpdev server add` en la modalidad interactiva: 

```bash
? Enter the name of the new server definition: mydevserver
? Enter the fully qualified URL of this server: http://mydevserver.example.com:9080
? Enter the {{ site.data.keys.mf_server }} administrator login ID: admin
? Enter the {{ site.data.keys.mf_server }} administrator password: *****
? Save the admin password for this server?: Yes
? Enter the context root of the MobileFirst administration services: mfpadmin
? Enter the {{ site.data.keys.mf_server }} connection timeout in seconds: 30
Verifying server configuration...
The following runtimes are currently installed on this server: mfp
Server profile 'mydevserver' added successfully.
```
El mismo mandato en la modalidad directa sería



```bash
mfpdev server add mydevserver --url http://mydevserver.example.com:9080 --login admin --password admin --setdefault
```

Para averiguar la sintaxis correcta para un mandato en la modalidad directa, utilice `mfpdev help <command>`.


## Gestión de instancias de {{ site.data.keys.mf_server }} 
{: #managing-mobilefirst-server-instances }
Utilice el mandato `mfpdev server <option>` para gestionar instancias de {{ site.data.keys.mf_server }} que ya se están utilizando.
Debe haber listada al menos una instancia de servidor como la instancia predeterminada.
Se utiliza siempre el servidor predeterminado si no se especifica otro.


### Listar las instancias de servidor
{: #list-server-instances }
Para listar todas las instancias de {{ site.data.keys.mf_server }} disponibles para ser utilizadas, ejecute el mandato:


```bash
mfpdev server info
```

De forma predeterminada, se crea automáticamente un perfil de servidor local que la CLI utiliza como la predeterminada actual.


### Adición de una nueva instancia de servidor
{: #add-a-new-server-instance }
Si está utilizando otra instancia de {{ site.data.keys.mf_server }} local o remota puede añadirla a la lista de instancias disponibles a utilizar con el mandato:


```bash
mfpdev server add
```

Siga las solicitudes interactivas para proporcionar un nombre al servidor, el URL de servidor y las credenciales de usuario y contraseña.
  
Por ejemplo, para añadir una instancia de {{ site.data.keys.mf_server }} que se ejecuta en un servicio de IBM Cloud de Mobile Foundation debería añadir lo siguiente:


```bash
$ mfpdev server add
? Enter the name of the new server profile: MyBluemixServer
? Enter the fully qualified URL of this server: https://mobilefoundation-7abcd-server.mybluemix.net:443
? Enter the {{ site.data.keys.mf_server }} administrator login ID: admin
? Enter the {{ site.data.keys.mf_server }} administrator password: *****
? Save the administrator password for this server?: Yes
? Enter the context root of the MobileFirst administration services: mfpadmin
? Enter the {{ site.data.keys.mf_server }} connection timeout in seconds: 30
? Make this server the default?: Yes
Verifying server configuration...
The following runtimes are currently installed on this server: mfp
Server profile 'MyBluemixServer' added successfully.
```

- Sustituya "fully qualified URL of this server" con su propio valor. 

### Editar instancias de servidor
{: #edit-server-instances }
Si desea editar los detalles de una instancia de servidor registrada, ejecute el siguiente mandato y siga las solicitudes interactivas para seleccionar el editor a editar y proporcione la información para actualizarlo.


```bash
mfpdev server edit
```

Para establecer el servidor como el predeterminado, utilice:


```bash
mfpdev server edit <server_name> --setdefault
```

### Eliminar instancias de servidor
{: #remove-server-instances }
Para eliminar una instancia de servidor de la lista de servidores registrados, ejecute el mandato:


```bash
mfpdev server remove
```

Y seleccione el servidor de la lista interactiva

### Cómo abrir {{ site.data.keys.mf_console }}
{: #open-mobilefirst-operations-console }
Para abrir la consola del servidor predeterminado, ejecute el siguiente mandato:


```bash
mfpdev server console
```

Para abrir la consola para otro servidor, informe del nombre de servidor como un parámetro del mandato: 

```bash
mfpdev server console <server_name>
```

### Eliminación de aplicaciones y adaptadores del servidor
{: #remove-apps-and-adapters-from-a-server }
Para eliminar todas las aplicaciones y todos los adaptadores registrados en un servidor ejecute el mandato: 

```bash
mfpdev server clean
```

A continuación, seleccione en la solicitud interactiva el servidor en el que realizar la eliminación.
  
Esto colocará la instancia del servidor en estado sin cualquier aplicación o adaptador desplegado. 

## Gestión de aplicaciones
{: #managing-applications }
El mandato `mfpdev app <option>` sirve para gestionar aplicaciones creadas con {{ site.data.keys.product }} SDK.


### Registro de una aplicación en una instancia de servidor
{: #register-an-application-in-a-server-instance }
Una aplicación se debe registrar en {{ site.data.keys.mf_server }} cuando esté lista para ser ejecutada.
  
Para registrar una aplicación, ejecute el siguiente mandato desde la carpeta raíz del proyecto de la aplicación: 

```bash
mfpdev app register
```

Este mandato se puede ejecutar desde la raíz de la aplicación Cordova, Android, iOS o Windows.   
Utilizará el tiempo de ejecución y el servidor predeterminado para ejecutar las siguientes tareas: 

* Registrar una aplicación con un servidor.
* Generar un archivo de propiedades de cliente predeterminado para la aplicación. 
* Colocar la información del servidor en el archivo de propiedades de cliente. 

Para una aplicación Cordova, este mandato actualizará el archivo config.xml.   
Para una aplicación iOS, este mandato actualizará el archivo mfpclient.plist.   
Para una aplicación Android, este mandato actualizará el archivo mfpclient.properties. 

Para registrar una aplicación en un tiempo de ejecución y en un servidor que no sea el predeterminado, utilice la sintaxis:  

```
mfpdev app register <server> <runtime>
```

Con la plataforma Cordova Windows, el argumento `-w <platform>` se debe añadir al mandato. El argumento `<platform>` es una lista separada por comas de plataformas windows a registrar.
Los valores válidos son `windows`,`windows8` y `windowsphone8`.

```
mfpdev app register -w windows8
```

### Configuración de una aplicación
{: #configure-an-application }
Cuando se registra una aplicación, los atributos relacionados con el servidor se añaden a su archivo de configuración.   
Para cambiar los valores de estos atributos, ejecute el siguiente mandato: 

```bash
mfpdev app config
```

Este mandato presentará de forma interactiva una lista de atributos que se pueden cambiar y solicitará el valor de los nuevos atributos.   
Los atributos disponibles variarán para cada plataforma (iOS, Android, Windows).

Las configuraciones disponibles son:

* El tiempo de ejecución y la dirección de servidor que se registrarán

    > **Caso de uso de ejemplo:** para registrar una aplicación en un  {{ site.data.keys.mf_server }} con una dirección determinada, pero tener también la aplicación conectada a una dirección de servidor distinta, por ejemplo, un dispositivo
DataPower: >
    > 1. Ejecute `mfpdev app register` para registrar la aplicación en la dirección de {{ site.data.keys.mf_server }} esperada.
    > 2. Ejecute `mfpdev app config` y cambie el valor de la propiedad **server** para que coincida con la dirección del dispositivo DataPower. 
También puede ejecutar el mandato en la **modalidad directa**:
`mfpdev app config server http(s)://server-ip-or-host:port`.



* Estableciendo una clave pública para la característica de autenticidad de Direct Update
* Estableciendo un idioma predeterminado de aplicación (el valor predeterminado es inglés (en))
* Habilitar o inhabilitar la prueba de suma de comprobación de recursos web
* Extensiones de archivo a ignorar durante una prueba de suma de comprobación de recursos web

<div class="panel-group accordion" id="app-config" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="app-config-options">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#app-config-options" data-target="#collapse-app-config-options" aria-expanded="false" aria-controls="collapse-app-config-options"><b>Información adicional sobre valores de suma de comprobación de recursos web</b></a>
            </h4>
        </div>

        <div id="collapse-app-config-options" class="panel-collapse collapse" role="tabpanel" aria-labelledby="app-config-options">
            <div class="panel-body">
                <p>Para los valores de suma de comprobación de recursos web, cada plataforma de destino posible (Android, iOS, Windows 8, Windows Phone 8 y Windows 10 UWP) tiene una clave específica de la plataforma para utilizarlo en la modalidad directa de <b>mfpdev</b>. Estas claves empiezan con una serie que representa el nombre de la plataforma. Por ejemplo, <code>windows10_security_test_web_resources_checksum</code> tiene los valores true o false para especificar si hay que habilitar o inhabilitar la prueba de suma de comprobación de recursos web para Windows10 UWP.</p>

                <table class="table table-striped">
                    <tr>
                        <td><b>Valor </b></td>
                        <td><b>Descripción </b></td>
                    </tr>
                    <tr>
                        <td><code>direct_update_authenticity_public_key</code></td>
                        <td>Especifica la clave pública para la autenticación de Direct Update. Se debe basar en el formato Base64. </td>
                    </tr>
                    <tr>
                        <td><code>ios_security_test_web_resources_checksum</code></td>
                        <td>Si se establece en <code>true</code>, habilita la prueba de suma de comprobación de recursos web para aplicaciones iOS Cordova. El valor predeterminado es <code>false</code>.</td>
                    </tr>
                    <tr>
                        <td><code>android_security_test_web_resources_checksum</code></td>
                        <td>Si se establece en <code>true</code>, habilita la prueba de suma de comprobación de recursos web para aplicaciones Android Cordova. El valor predeterminado es <code>false</code>.</td>
                    </tr>
                    <tr>
                        <td><code>windows10_security_test_web_resources_checksum</code></td>
                        <td>Si se establece en <code>true</code>, habilita la prueba para la suma de comprobación de recursos web para aplicaciones Windows 10 UWP Cordova. El valor predeterminado es <code>false</code>.</td>
                    </tr>
                    <tr>
                        <td><code>windows8_security_test_web_resources_checksum</code></td>
                        <td>Si se establece en <code>true</code>, habilita la prueba de suma de comprobación de recursos web para aplicaciones Windows 8.1 Cordova. El valor predeterminado es <code>false</code>.</td>
                    </tr>
                    <tr>
                        <td><code>windowsphone8_security_test_web_resources_checksum</code></td>
                        <td>Si se establece en <code>true</code>, habilita la prueba de suma de comprobación de recursos web para aplicaciones Windows Phone 8.1 Cordova. El valor predeterminado es <code>false</code>.</td>
                    </tr>
                    <tr>
                        <td><code>ios_security_ignore_file_extensions</code></td>
                        <td>Especifica las extensiones de archivo a ignorar durante las pruebas de suma de comprobación de recursos web para las aplicaciones iOS Cordova. Separe las distintas extensiones con comas. Por ejemplo: jpg,gif,pdf</td>
                    </tr>
                    <tr>
                        <td><code>android_security_ignore_file_extensions</code></td>
                        <td>Especifica las extensiones de archivo a ignorar durante las pruebas de suma de comprobación de recursos web para las aplicaciones Android Cordova. Separe las distintas extensiones con comas. Por ejemplo: jpg,gif,pdf</td>
                    </tr>
                    <tr>
                        <td><code>windows10_security_ignore_file_extensions</code></td>
                        <td>Especifica las extensiones de archivo a ignorar durante las pruebas de suma de comprobación de recursos web para las aplicaciones Windows 10 UWP Cordova. Separe las distintas extensiones con comas. Por ejemplo: jpg,gif,pdf</td>
                    </tr>
                    <tr>
                        <td><code>windows8_security_ignore_file_extensions</code></td>
                        <td>Especifica las extensiones de archivo a ignorar durante las pruebas de suma de comprobación de recursos web para las aplicaciones Windows 8.1 Cordova. Separe las distintas extensiones con comas. Por ejemplo: jpg,gif,pdf</td>
                    </tr>
                    <tr>
                        <td><code>windowsphone8_security_ignore_file_extensions</code></td>
                        <td>Especifica las extensiones de archivo a ignorar durante las pruebas de suma de comprobación de recursos web para las aplicaciones Windows Phone 8.1 Cordova. Separe las distintas extensiones con comas. Por ejemplo: jpg,gif,pdf</td>
                    </tr>
                </table>

                <br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#app-config-options" data-target="#collapse-app-config-options" aria-expanded="false" aria-controls="collapse-app-config-options"><b>Sección de cierre</b></a>
            </div>
        </div>
    </div>
</div>


### Vista previa de una aplicación de Cordova
{: #preview-a-cordova-application }
Obtenga una vista previa de los recursos web de una aplicación Cordova mediante un navegador.
La vista previa de una aplicación permite un rápido desarrollo sin la necesidad de utilizar simuladores ni emuladores específicos de las plataformas nativas. 

Antes de ejecutar el mandato de vista previa, debe preparar el proyecto añadiendo la variable `wlInitOptions`.
Complete los siguientes pasos:


1. Añade la variable *wlInitOptions* a su archivo JavaScript principal, que es **index.js** en una aplicación Cordova estándar. 

   ```javascript
   var wlInitOptions = {
      mfpContextRoot:'/mfp', // "mfp" is the default context root of {{ site.data.keys.mf_server }}
      applicationId:'com.sample.app' // Replace with your own value.
   };
   ```

2. Registre de nuevo la aplicación utilizando el siguiente mandato:


   ```bash
   mfpdev app register
   ```

 3. Ejecute el siguiente mandato: 

    ```bash
   cordova prepare
   ```

 4. Obtenga una vista previa de la aplicación Cordova ejecutando el siguiente mandato desde la carpeta raíz de la aplicación Cordova: 

    ```bash
mfpdev app preview
```

Se le solicitará que seleccione la plataforma para la vista previa y el tipo de vista previa a utilizar.
Hay dos opciones de vista previa: MBS (Mobile Browser Simulator) y navegador. 

* MBS - {{ site.data.keys.mf_mbs }}. 
Este método simula un dispositivo móvil en un navegador, así como proporciona una simulación de API de Cordova rudimentaria como, por ejemplo, la de cámara, subida de archivos o geoubicación, entre otras.
Nota: No es posible utilizar el navegador cordova con la opción MBS.

* Navegador - Representación de navegador simple.
Este método presenta los recursos www de la aplicación Cordova como una página web de navegador normal.


> Para obtener detalles sobre las opciones de vista previa, consulte la [guía de aprendizaje de Desarrollo Cordova](../cordova-apps).

### Actualización de recursos web para Direct Update
{: #update-web-resources-for-direct-update }
Los recursos web de una aplicación cordova como, por ejemplo, archivos .html, .css y .js dentro de una carpeta **www** se pueden actualizar sin la necesidad de reinstalar la aplicación en el dispositivo móvil.
Esto es posible con la característica de Direct Update que {{ site.data.keys.product }} proporciona.


> Para obtener más detalles sobre cómo funciona Direct Update, consulte la guía de aprendizaje [Utilización de Direct Update en aplicaciones Cordova](../direct-update).

Cuando desee enviar un nuevo conjunto de recursos web para actualizarlos en una aplicación cordova, ejecute el mandato 

```bash
mfpdev app webupdate
```

Este mandato empaquetará los recursos web actualizados en un archivo .zip y los subirá a la instancia de {{ site.data.keys.mf_server }} registrada.
Los recursos web empaquetados se pueden encontrar en la carpeta **[cordova-project-root-folder]/mobilefirst/**.


Para subir los recursos web a una instancia de servidor diferente, informe del tiempo de ejecución y el nombre de servidor como parte del mandato

```bash
mfpdev app webupdate <server_name> <runtime>
```

Utilice el parámetro --build para generar el archivo .zip con los recursos web empaquetados sin subirlos a un servidor. 

```bash
mfpdev app webupdate --build
```

Para subir un paquete compilado con anterioridad, utilice el parámetro --file

```bash
mfpdev app webupdate --file mobilefirst/com.ibm.test-android-1.0.0.zip
```

También existe la posibilidad de cifrar el contenido del paquete mediante el parámetro --encrypt

```bash
mfpdev app webupdate --encrypt
```

### Hacer pull y push a la configuración de la aplicación de {{ site.data.keys.product_adj }} 
{: #pull-and-push-the-mobilefirst-application-configuration }
Después de que una aplicación de {{ site.data.keys.product_adj }} esté registrada en una instancia de {{ site.data.keys.mf_server }}, existe la posibilidad de cambiar algunas de las configuraciones de aplicación mediante la consola de {{ site.data.keys.mf_server }} y, a continuación, obtenerlas haciendo pull a dichas configuraciones desde el servidor a la aplicación con el siguiente mandato:


```bash
mfpdev app pull
```

También es posible cambiar las configuraciones de la aplicación localmente y hacer push de los cambios a {{ site.data.keys.mf_server }} con el mandato: 

```bash
mfpdev app push
```

**Ejemplo:** Se pueden realizar correlaciones de ámbito para comprobaciones de seguridad en {{ site.data.keys.mf_console }} y, a continuación, obtenerlas mediante pull desde el servidor mediante el mandato anterior.
El archivo .zip se almacena en la carpeta **[directorio raíz]/mobilefirst** del proyecto, y se puede utilizar más tarde con `mfpdev app push` para subirlo a otras instancias de {{ site.data.keys.mf_server }}, permitiendo una puesta a punto y configuración rápida mediante la reutilización de una configuración predefinida.


## Gestión y realización de pruebas con adaptadores
{: #managing-and-testing-adapters }
Puede gestionar los adaptadores con el mandato `mfpdev adapter <option>`.

> Para obtener más información sobre los adaptadores consulte las guías de aprendizaje de la categoría [Adaptadores](../../adapters/).



### Creación de un adaptador
{: #create-an-adapter }
Para crear un nuevo adaptador, utilice el mandato

```bash
mfpdev adapter create
```

Responda a las solicitudes para informar sobre el nombre, el tipo y el ID de grupo del adaptador

### Compilación de un adaptador
{: #build-an-adpater }
Para compilar un adaptador, ejecute el siguiente mandato desde la carpeta raíz del adaptador: 

```bash
mfpdev adapter build
```

De esta forma generará un archivo .adapter en la carpeta **<NombreAdaptador>/target**.


### Despliegue de un adaptador
{: #deploy-an-adapter}
El siguiente mandato desplegará el adaptador en el servidor predeterminado:

```bash
mfpdev adapter deploy
```

Para desplegarlo en un servidor diferente, utilice:

```bash
mfpdev adapter deploy <server_name>
```

### Llamada a un adaptador desde la línea de mandatos
{: #call-an-adapter-from-the-command-line }
Después de que se despliegue un adaptador es posible llamarlo desde la línea de mandatos para probar su comportamiento con el mandato:


```bash
mfpdev adapter call
```

Se le solicitará informar del adaptador, el procedimiento y los parámetros a utilizar.
La salida del mandato será la respuesta del procedimiento del adaptador.


> Obtenga más información en la guía de aprendizaje [Pruebas y depuración de adaptadores](../../adapters/testing-and-debugging-adapters/). 

## Mandatos de utilidad
{: #helpful-commands }
Utilice el siguiente mandato para establecer las preferencias de la interfaz de línea de mandatos (CLI) de mfpdev como, por ejemplo, el navegador predeterminado y la modalidad de vista previa predeterminada:


```bash
mfpdev config
```

Para ver el contenido de ayuda que describe todos los mandatos de mfpdev, utilice: 

```bash
mfpdev help
```

El siguiente mandato generará una lista con información sobre el entorno: 

```bash
mfpdev info
```

Para imprimir la versión de la CLI de mfpdev, utilice:

```bash
mfpdev -v
```

## Actualización y desinstalación de la interfaz de línea de mandatos
{: #update-and-uninstall-the-command-line-interface }
Ejecute el siguiente mandato para actualizar la interfaz de línea de mandatos:


```bash
npm update -g mfpdev-cli
```

Ejecute el siguiente mandato para desinstalar la interfaz de línea de mandatos:


```bash
npm uninstall -g mfpdev-cli
```
