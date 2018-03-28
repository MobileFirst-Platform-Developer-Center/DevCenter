---
layout: tutorial
title: Administración de aplicaciones a través de Terminal
breadcrumb_title: Administrating using terminal
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
Puede administrar aplicaciones {{ site.data.keys.product_adj }} a través del programa **mfpadm**.

>Las versiones del {{ site.data.keys.product_full }} SDK posteriores a la versión **8.0.0.0-MFPF-IF201701250919** tienen un soporte de autenticidad de aplicación actualizado, con mandatos `mfpadm` para conmutar entre una validación `dinámica` y otra `estática` (también es posible restablecerla).
>
Vaya hasta el directorio de instalación de {{ site.data.keys.product_full }} `/MobilefirstPlatformServer/shortcuts` y ejecute los mandatos `mfpadm`.
>
1.Para conmutar entre tipos de validación:
```bash
	mfpadm --url=  --user=  --passwordfile= --secure=false app version [RUNTIME] [APPNAME] [ENVIRONMENT] [VERSION] set authenticity-validation TYPE
```  
El valor para *TYPE* puede ser `static` o `dynamic`
>
Ejemplo para android: Aquí se establecerá TYPE en la validación `dynamic`.
```bash
  mfpadm --url=http://localhost:8080/mfpadmin --user=admin --passwordfile="C:\userhome\mfppassword\MFP_password.txt" --secure=false app version mfp test android 1.0 set authenticity-validation dynamic
```
>
2.Para restablecer los datos utilizando el siguiente mandato que borra la huella de la aplicación.
```bash
  mfpadm --url=  --user=  --passwordfile= --secure=false app version [RUNTIME] [APPNAME] [ENVIRONMENT] [VERSION] reset authenticity
```
Ejemplo:
>
```bash
  mfpadm --url=http://localhost:8080/mfpadmin --user=admin --passwordfile="C:\userhome\mfppassword\MFP_password.txt" --secure=false app version mfp sample.com.pincodeandroid android 1.0 reset authenticity
```

#### Ir a
{: #jump-to }

* [Comparación con otros recursos](#comparison-with-other-facilities)
* [Requisitos previos](#prerequisites)

## Comparación con otros recursos
{: #comparison-with-other-facilities }
Puede ejecutar operaciones de administración con {{ site.data.keys.product_full }} de las siguientes maneras:

* {{ site.data.keys.mf_console }}, que es interactivo.
* Tareas Ant de mfpadm.
* El programa **mfpadm**.
* Los servicios REST de administración de {{ site.data.keys.product_adj }}.

Las tareas Ant de **mfpadm**, el programa mfpadm y los servicios REST son útiles para realizar operaciones de ejecución automatizada o sin supervisión como, como en los siguientes casos:

* Eliminación de errores de operador en las operaciones repetitivas, o
* Operaciones fuera de las horas normales de trabajo de los operadores, o
* Configuración de un servidor de producción con los mismos valores que los de un servidor de prueba o previo a la producción.

El programa **mfpadm** y las tareas Ant de mfpadm son más fáciles de utilizar e informan mejor sobre los errores que los servicios REST. La ventaja del programa mfpadm sobre las tareas Ant de mfpadm es que son más fáciles de integrar cuando la integración con los mandatos del sistema operativo ya está presente. Además, es más adecuado para una utilización interactiva.

## Requisitos previos
{: #prerequisites }
La herramienta **mfpadm** se instala con el instalador de {{ site.data.keys.mf_server }}. En el resto de esta página **dir\_instalacion\_producto** indica el directorio de instalación del instalador de {{ site.data.keys.mf_server }}.

El mandato **mfpadm** se proporciona en el directorio **dir\_instalacion\_producto/shortcuts/** como un conjunto de scripts:

* mfpadm para UNIX / Linux
* mfpadm.bat para Windows

Estos scripts están listos para ser ejecutados, lo que significa que no precisan de variables de entorno específicas. Si se ha establecido la variable de entorno **JAVA_HOME**, el script la acepta.  
Para utilizar el programa **mfpadm**, añada el directorio **dir\_instalacion\_producto/shortcuts/** a su variable de entorno PATH, o haga referencia al nombre absoluto del archivo en cada llamada.

Para obtener más información sobre cómo ejecutar el instalador de {{ site.data.keys.mf_server }}, consulte [Ejecución de IBM Installation Manager](../../installation-configuration/production/installation-manager/).

#### Ir a
{: #jump-to-1 }

* [Llamada al programa **mfpadm**](#calling-the-mfpadm-program)
* [Mandatos para la configuración general](#commands-for-general-configuration)
* [Mandatos para los adaptadores](#commands-for-adapters)
* [Mandatos para las aplicaciones](#commands-for-apps)
* [Mandatos para los dispositivos](#commands-for-devices)
* [Mandatos para la resolución de problemas](#commands-for-troubleshooting)


### Llamada al programa **mfpadm**
{: #calling-the-mfpadm-program }
Utilice el programa **mfpadm** para administrar aplicaciones de {{ site.data.keys.product_adj }}.

#### Sintaxis:
{: #syntax }
Las llamadas al programa mfpadm tienen el siguiente formato:

```bash
mfpadm --url= --user= ... [--passwordfile=...] [--secure=false] algún mandato
```

El programa **mfpadm** tiene las siguientes opciones:

| Opción	| Tipo | Descripción | Obligatorio | Predeterminado |
|-----------|------|-------------|----------|---------|
| --url | 	 | URL | URL base de la aplicación web de {{ site.data.keys.product_adj }} para los servicios de administración | Sí | |
| --secure	 | Booleano | Evitar operaciones con riesgos de seguridad | No | verdadero |
| --user	 | nombre | Nombre de usuario para acceder a los servicios de administración de {{ site.data.keys.product_adj }} | Sí |  | 	 
| --passwordfile | file | Archivo con la contraseña del usuario | No |
| --timeout	     | Número  | Tiempo de espera para todo el acceso al servicio REST, en segundos | No | 	 
| --connect-timeout | Número | Tiempo de espera para establecer una conexión de red, en segundos | No |
| --socket-timeout  | Número | Tiempo de espera para detectar la pérdida de una conexión de red, en segundos | No |
| --connection-request-timeout | Tiempo de espera para obtener una entrada de una agrupación de solicitudes de conexión, en segundos | No |
| --lock-timeout | Número | Tiempo de espera para adquirir un bloqueo, en segundos | No | 2 |
| --verbose	     | Salida detallada | No	| |  

**url**  
El URL preferiblemente utiliza el protocolo HTTPS. Por ejemplo, si utiliza las raíces de contexto y los puertos predeterminados, utilice este URL:

* Para WebSphere Application Server: https://server:9443/mfpadmin
* Para Tomcat: https://server:8443/mfpadmin

**secure**  
La opción `--secure` se establece como verdadera de forma predeterminada. Si la establece como `--secure=false` ocurrirá lo siguiente:

* El usuario y la contraseña se podrían transmitir de forma no segura (posiblemente a través de tráfico HTTP sin cifrar).
* Los certificados SSL del servidor se aceptarán incluso si están autofirmados o si se crearon para un nombre de host diferente del nombre de host del servidor.

**password**  
Especifique la contraseña en un archivo separado que se pasa en la opción `--passwordfile`. Alternativamente, en la modalidad interactiva (consulte Modalidad interactiva), puede especificar la contraseña de forma interactiva. La contraseña es información confidencial y, por lo tanto, debe estar protegida. Debe impedir que otros usuarios en el mismo sistema sepan estas contraseñas. Para proteger la contraseña, antes de especificarla en un archivo, elimine los permisos de lectura del archivo a otros usuarios que no sean usted mismo. Por ejemplo, puede utilizar uno de los siguientes mandatos:

* En UNIX: `chmod 600 adminpassword.txt`
* En Windows: `cacls adminpassword.txt /P Administrators:F %USERDOMAIN%\%USERNAME%:F`

Por esta razón, no pase la contraseña a un proceso a través de un argumento de línea de mandatos. En muchos sistemas operativos, otros usuarios pueden inspeccionar los argumentos de línea de mandatos de sus procesos.

Las llamadas a mfpadm contienen un mandato. Se da soporte a los siguientes mandatos.

| Mandato                           | Descripción |
|-----------------------------------|-------------|
| show info	| Muestra información de configuración y de usuario. |
| show global-config | Muestra información de configuración global. |
| show diagnostics | Muestra información de diagnósticos. |
| show versions	| Muestra información de versión. |
| unlock | Libera el bloqueo de propósito general. |
| list runtimes [--in-database] | Lista los tiempos de ejecución. |
| show runtime [runtime-name] | Muestra información sobre un tiempo de ejecución. |
| delete runtime [runtime-name] condition | Suprime un tiempo de ejecución. |
| show user-config [runtime-name] | Muestra la configuración de usuario de un tiempo de ejecución. |
| set user-config [runtime-name] file | Especifica la configuración de usuario de un tiempo de ejecución. |
| set user-config [runtime-name] property = value | Especifica una configuración de usuario de un tiempo de ejecución. |
| show confidential-clients [runtime-name] | Muestra la configuración de los clientes confidencial de un entorno de ejecución. |
| set confidential-clients [runtime-name] file | Especifica la configuración de los clientes confidencial de un entorno de ejecución. |
| set confidential-clients-rule [runtime-name] id display-name secret allowed-scope | Especifica una regla para la configuración de los clientes confidenciales de un entorno de ejecución. |
| list adapters [runtime-name] | Lista los adaptadores. |
| deploy adapter [runtime-name] property = value | Despliega un adaptador.|
| show adapter [runtime-name] adapter-name | Muestra información sobre un adaptador.|
| delete adapter [runtime-name] adapter-name | Suprime un adaptador.|
| adapter [runtime-name] adapter-name get binary [> tofile]	| Obtiene los datos binarios de un adaptador.|
| list apps [runtime-name] | Lista las aplicaciones.|
| deploy app [runtime-name] file | Despliega una aplicación.|
| show app [runtime-name] app-name | Muestra información sobre una aplicación.|
| delete app [runtime-name] app-name | Suprime una aplicación. |
| show app version [runtime-name] app-name environment version | Muestra información sobre una versión de una aplicación. |
| delete app version [runtime-name] app-name environment version | Suprime una versión de una aplicación. |
| app [runtime-name] app-name show license-config | Muestra la configuración de licencia de señal de una aplicación. |
| app [runtime-name] app-name set license-config app-type license-type | Muestra la configuración de licencia de señal de una aplicación. |
| app [runtime-name] app-name delete license-config | Elimina la configuración de licencia de señal de una aplicación. |
| app version [runtime-name] app-name environment version get descriptor [> tofile]	| Obtiene el descriptor de una versión de aplicación. |
| app version [runtime-name] app-name environment version get web-resources [> tofile] | Obtiene los recursos web de una aplicación. |
| app version [runtime-name] app-name environment version set web-resources file | Especifica los recursos web de una versión de aplicación. |
| app version [runtime-name] app-name environment version get authenticity-data [> tofile] | Obtiene los datos de autenticidad de una versión de aplicación. |
| app version [runtime-name] app-name environment version set authenticity-data [file] | Especifica los datos de autenticidad de una versión de aplicación. |
| app version [runtime-name] app-name environment version delete authenticity-data | Suprime los datos de autenticidad de una versión de aplicación. |
| app version [runtime-name] app-name environment version show user-config | Muestra la configuración de usuario de una versión de aplicación. |
| app version [runtime-name] app-name environment version set user-config file | Especifica la configuración de usuario de una versión de aplicación. |
| app version [runtime-name] app-name environment version set user-config property = value | Especifica una configuración de usuario de una versión de aplicación. |
| list devices [runtime-name][--query query] | Lista los dispositivos. |
| remove device [runtime-name] id | Elimina un dispositivo. |
| device [runtime-name] id set status new-status | Cambia el estado de un dispositivo. |
| device [runtime-name] id set appstatus app-name new-status | Cambia el estado de un dispositivo para una aplicación. |
| list farm-members [runtime-name] | Lista los servidores que son miembros de la granja de servidores. |
| remove farm-member [runtime-name] server-id | Elimina un servidor de la lista de miembros de la granja. |

#### Modalidad interactiva
{: #interactive-mode }
Como alternativa, también puede llamar a **mfpadm** en la línea de mandatos sin ningún mandato. Puede entonces especificar mandatos de forma interactiva, uno por línea.
El mandato `exit`, o el final de archivo en la salida estándar (**Control-D** en terminales UNIX) finaliza mfpadm.

También en esta modalidad, hay disponibles mandatos `help` de ayuda. Por ejemplo:

* help
* help show versions
* help device
* help device set status

#### Historial de mandatos en la modalidad interactiva
{: #command-history-in-interactive-mode }
En algunos sistemas operativos, el mandato mfpadm interactivo recuerda el historial de mandatos. Con el historial de mandatos, puede seleccionar un mandato ejecutado de forma previa, utilizando las flechas de dirección, editarlo y ejecutarlo.

**En Linux**  
El historial de mandatos está habilitado en las ventanas del emulador de terminal si el paquete rlwrap está instalado y se encuentra en PATH. Para instalar el paquete rlwrap:

* En Red Hat Linux: `sudo yum install rlwrap`
* En SUSE Linux: `sudo zypper install rlwrap`
* En Ubuntu: `sudo apt-get install rlwrap`

**En OS X**  
El historial de mandatos está habilitado en el programa Terminal si el paquete rlwrap está instalado y se encuentra en PATH. Para instalar el paquete rlwrap:

1. Instale MacPorts utilizando el instalador de [www.macports.org](http://www.macports.org).
2. Ejecute el mandato: `sudo /opt/local/bin/port install rlwrap`
3. A continuación, para que el programa rlwrap esté disponible en PATH, utilice este mandato en un shell compatible con Bourne: `PATH=/opt/local/bin:$PATH`

**En Windows**  
El historial de mandatos está habilitado en las ventanas de consola de cmd.exe.

En entornos en los que rlwrap no funciona o no es necesario, puede inhabilitar su utilización a través de la opción `--no-readline`.

#### Archivo de configuración
{: #the-configuration-file }
También puede almacenar las opciones en un archivo de configuración en lugar de pasarlas en la línea de mandatos en cada una de las llamadas. Cuando un archivo de configuración está presente y se especifica la opción –configfile=file, puede omitir las opciones siguientes:

* --url=URL
* --secure=boolean
* --user=name
* --passwordfile=file
* --timeout=seconds
* --connect-timeout=seconds
* --socket-timeout=seconds
* --connection-request-timeout=seconds
* --lock-timeout=seconds
* runtime-name

Utilice estos mandatos para almacenar estos valores en el archivo de configuración.

| Mandato | Comentario |
|---------|---------|
| mfpadm [--configfile=file] config url URL | |
| mfpadm [--configfile=file] config secure boolean | |
| mfpadm [--configfile=file] config user name | |
| mfpadm [--configfile=file] config password | Prompts for the password. |
| mfpadm [--configfile=file] config timeout seconds | |
| mfpadm [--configfile=file] config connect-timeout seconds | |
| mfpadm [--configfile=file] config socket-timeout seconds | |
| mfpadm [--configfile=file] config connection-request-timeout seconds | |
| mfpadm [--configfile=file] config lock-timeout seconds | |
| mfpadm [--configfile=file] config runtime runtime-name | |

Utilice este mandato para listar los valores almacenados en el archivo de configuración: `mfpadm [--configfile=file] config`

El archivo de configuración es un archivo de texto, en la codificación del entorno local actual, en la sintaxis **.properties** de Java. Estos son los archivos de configuración predeterminados:

* UNIX: **${HOME}/.mfpadm.config**
* Windows: **{{ site.data.keys.prod_server_data_dir_win }}\mfpadm.config**

**Nota:** Cuando no se especifica una opción `--configfile`, el archivo de configuración predeterminado únicamente se utiliza en la modalidad interactiva y en mandatos config. Para utilización no interactiva de otros mandatos, debe designar de forma explícita el archivo de configuración si desea utilizar uno.

> **Importante:** La contraseña se almacena en un formato enmascarado que la oculta de una visualización accidental. Sin embargo, este enmascaramiento no proporciona seguridad.

#### Opciones genéricas
{: #generic-options }
También hay las opciones genéricas usuales:

| Opción	| Descripción |
|-----------|-------------|
| --help	| Muestra ayuda sobre la utilización |
| --version	| Muestra la versión |

#### Formato XML
{: #xml-format }
Los mandatos que reciben una respuesta XML del servidor verifican que dicha respuesta cumpla el esquema especifico. Puede inhabilitar esta comprobación especificando `--xmlvalidation=none`.

#### Conjunto de caracteres de salida
{: #output-character-set }
La salida normal del programa mfpadm se codifica en el entorno local actual. En Windows, este formato de codificación es el de la "página de códigos ANSI". Los resultados son los siguientes:

* Los caracteres fuera de este conjunto de caracteres se convierten en interrogantes de cierre en la salida.
* Cuando la salida se dirige a una ventana de un indicador de mandatos de Windows (cmd.exe), los caracteres no ASCII se visualizan de forma incorrecta porque en estas ventanas se presupone que los caracteres están codificados de acuerdo a la "página de códigos OEM".

Para solucionar esta limitación:

* En sistemas operativos distintos de Windows, utilice un entorno local cuya codificación sea UTF-8. Este formato es el entorno local predeterminado en Red Hat Linux y OS X.
Muchos otros sistemas operativos tienen un entorno local `en_US.UTF-8`.
* O utilice la tarea Ant de mfpadm, con el atributo `output="algún nombre de archivo"` para redireccionar la salida de un mandato a un archivo.

### Mandatos para la configuración general
{: #commands-for-general-configuration }
Cuando llama al programa **mfpadm**, puede incluir varios mandatos para acceder a la configuración global de IBM {{ site.data.keys.mf_server }} o de un tiempo de ejecución.

#### Mandato `show global-config`
{: #the-show-global-config-command }
El mandato `show global-config` muestra la configuración global.

Sintaxis: `show global-config`

Acepta las siguientes opciones:

| Argumento | Descripción |
|----------|-------------|
| --xml    | Produce salida XML en lugar de una salida tabular. |

**Ejemplo**  

```bash
show global-config
```

Este mandato se basa en el servicio REST [Global Configuration (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_global_configuration_get.html?view=kc#Global-Configuration--GET-)

<br/>
#### Mandato `show user-config`
{: #the-show-user-config-command }
El mandato `show user-config` muestra la configuración de usuario de un tiempo de ejecución.

Sintaxis: `show user-config [--xml] [runtime-name]`

Acepta los siguientes argumentos:

| Argumento | Descripción |
|----------|-------------|
| runtime-name | Nombre de tiempo de ejecución. |

El mandato `show user-config` utiliza las siguientes opciones después del verbo.

| Argumento | Descripción | Obligatorio | Predeterminado |
|----------|-------------|----------|---------|
| --xml | Genera salida en formato XML en lugar de formato JSON. | No | Salida estándar |

**Ejemplo**  

```bash
show user-config mfp
```

Este mandato se basa en el servicio REST [Runtime Configuration (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_runtime_configuration_get.html?view=kc#Runtime-Configuration--GET-).

<br/>
#### Mandato `set user-config`
{: #the-set-user-config-command }
El mandato `set user-config` especifica la configuración de usuario de un tiempo de ejecución o una propiedad individual en la misma.

La sintaxis para toda la configuración: `set user-config [runtime-name] file`

Acepta los siguientes argumentos:

| Atributo | Descripción |
|-----------|-------------|
| runtime-name | Nombre de tiempo de ejecución. |
| file | Nombre del archivo XML o JSON que contiene la nueva configuración. |

Sintaxis para una propiedad individual: `set user-config [runtime-name] property = value`

El mandato `set user-config` acepta los siguientes argumentos:

| Argumento | Descripción |
|----------|-------------|
| runtime-name | Nombre de tiempo de ejecución. |
| property | Nombre de la propiedad JSON. Para una propiedad anidada, utilice la sintaxis prop1.prop2.....propN. Para un elemento de matriz JSON, utilice el índice en lugar de un nombre de propiedad. |
| value | Valor de la propiedad. |

**Ejemplos**  

```bash
set user-config mfp myconfig.json
```

```bash
set user-config mfp timeout = 240
```

Este mandato se basa en el servicio REST [Runtime configuration (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_runtime_configuration_put.html?view=kc#Runtime-configuration--PUT-).

<br/>
#### Mandato `show confidential-clients`
{: #the-show-confidential-clients-command }
El mandato `show confidential-clients` muestra la configuración de los clientes confidenciales que pueden acceder a un tiempo de ejecución. Para obtener más información sobre los clientes confidenciales, consulte [Clientes confidenciales](../../authentication-and-security/confidential-clients).

Sintaxis: `show confidential-clients [--xml] [runtime-name]`

Acepta los siguientes argumentos:

| Atributo | Descripción |
|-----------|-------------|
| runtime-name | Nombre de tiempo de ejecución. |

El mandato `show confidential-clients` utiliza las siguientes opciones después del verbo.

| Argumento | Descripción | Obligatorio | Predeterminado |
|----------|-------------|----------|---------|
| --xml | Genera salida en formato XML en lugar de formato JSON. | No | Salida estándar |

**Ejemplo**

```bash
show confidential-clients --xml mfp
```

Este mandato se basa en el servicio REST [Confidential Clients (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_confidential_clients_get.html?view=kc#Confidential-Clients--GET-).

<br/>
#### Mandato `set confidential-clients`
{: #the-set-confidential-clients-command }
El mandato `set confidential-clients` especifica la configuración de los clientes confidenciales que pueden acceder a un tiempo de ejecución. Para obtener más información sobre los clientes confidenciales, consulte [Clientes confidenciales](../../authentication-and-security/confidential-clients).

Sintaxis: `set confidential-clients [runtime-name] file`

Acepta los siguientes argumentos:

| Atributo | Descripción |
|-----------|-------------|
| runtime-name | Nombre de tiempo de ejecución. |
| file | Nombre del archivo XML o JSON que contiene la nueva configuración. |

**Ejemplo**

```bash
set confidential-clients mfp clients.xml
```

Este mandato se basa en el servicio REST [Confidential Clients (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_confidential_clients_put.html?view=kc#Confidential-Clients--PUT-).

<br/>
#### Mandato `set confidential-clients-rule`
{: #the-set-confidential-clients-rule-command }
El mandato `set confidential-clients-rule` especifica una regla en la configuración de los clientes confidenciales que pueden acceder a un tiempo de ejecución. Para obtener más información sobre los clientes confidenciales, consulte [Clientes confidenciales](../../authentication-and-security/confidential-clients).

Sintaxis: `set confidential-clients-rule [runtime-name] id displayName secret allowedScope`

Acepta los siguientes argumentos:

| Atributo	| Descripción |
|-----------|-------------|
| runtime | Nombre de tiempo de ejecución. |
| id | El identificador de la regla. |
| displayName | El nombre de visualización de la regla. |
| secret | Secreto de la regla. |
| allowedScope | Ámbito de la regla. Lista de señales separadas por espacios. Utilice comillas dobles para pasar una lista de dos o más señales. |

**Ejemplo**

```bash
set confidential-clients-rule mfp push Push lOa74Wxs "**"
```

Este mandato se basa en el servicio REST [Confidential Clients (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_confidential_clients_put.html?view=kc#Confidential-Clients--PUT-).

### Mandatos para adaptadores
{: #commands-for-adapters }
Cuando invoca al programa **mfpadm**, puede incluir varios mandatos para los adaptadores.

### Mandato `list adapters`
{: #the-list-adapters-command }
El mandato `list adapters` devuelve una lista de los adaptadores desplegados en un tiempo de ejecución.

Sintaxis: `list adapters [runtime-name]`

Acepta los siguientes argumentos:

| Argumento | Descripción |
|----------|-------------|
| runtime-name | Nombre de tiempo de ejecución. |

El mandato `list adapters` acepta las siguientes opciones después del objeto.

| Opción | Descripción |
|--------|-------------|
| --xml | Produce salida XML en lugar de una salida tabular. |

**Ejemplo**  

```xml
list adapters mfp
```

Este mandato se basa en el servicio REST [Adapters (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapters_get.html?view=kc#Adapters--GET-).

<br/>
#### Mandato `deploy adapter`
{: #the-deploy-adapter-command }
El mandato `deploy adapter` despliega un adaptador en un tiempo de ejecución.

Sintaxis: `deploy adapter [runtime-name] file`

Acepta los siguientes argumentos:

| Argumento | Descripción |
|----------|-------------|
| runtime-name | Nombre de tiempo de ejecución. |
| file | Archivo de adaptador binario (.adapter) |

**Ejemplo**

```bash
deploy adapter mfp MyAdapter.adapter
```

Este mandato se basa en el servicio REST [Adapter (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapter_post.html?view=kc#Adapter--POST-).

<br/>
#### Mandato `show adapter`
{: #the-show-adapter-command }
El mandato `show adapter` muestra detalles sobre un adaptador.

Sintaxis: `show adapter [runtime-name] adapter-name`

Acepta los siguientes argumentos.

| Argumento | Descripción |
|----------|-------------|
| runtime-name | Nombre de tiempo de ejecución. |
| adapter-name | Nombre de un adaptador |

El mandato `show adapter` acepta las siguientes opciones después del objeto.

| Opción | Descripción |
|--------|-------------|
| --xml | Produce salida XML en lugar de una salida tabular. |

**Ejemplo**

```bash
show adapter mfp MyAdapter
```

Este mandato se basa en el servicio REST [Adapter (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapter_get.html?view=kc#Adapter--GET-).

<br/>
#### Mandato `delete adapter`
{: #the-delete-adapter-command }
El mandato `delete adapter` elimina (retira el despliegue) de un adaptador de un tiempo de ejecución.

Sintaxis: `delete adapter [runtime-name] adapter-name`

Acepta los siguientes argumentos:

| Argumento | Descripción |
|----------|-------------|
| runtime-name | Nombre de tiempo de ejecución. |
| adapter-name | Nombre de un adaptador. |

**Ejemplo**

```bash
delete adapter mfp MyAdapter
```

Este mandato se basa en el servicio REST [Adapter (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapter_delete.html?view=kc#Adapter--DELETE-).

<br/>
#### Prefijo de mandato `adapter`
{: #the-adapter-command-prefix }
El prefijo de mandato `adapter` utiliza los siguientes argumentos antes del verbo.

| Argumento | Descripción |
|----------|-------------|
| runtime-name | Nombre de tiempo de ejecución. |
| adapter-name | Nombre de un adaptador. |

<br/>
#### Mandato `adapter get binary`
{: #the-adapter-get-binary-command }
El mandato `adapter get binary` devuelve el archivo de adaptador binario.

Sintaxis: `adapter [runtime-name] adapter-name get binary [> tofile]`

Acepta las siguientes opciones después del verbo.

| Opción | Descripción | Obligatorio | Predeterminado |
|--------|-------------|----------|---------|
| > tofile | Nombre del archivo de salida. | No | Salida estándar |

**Ejemplo**

```bash
adapter mfp MyAdapter get binary > /tmp/MyAdapter.adapter
```

Este mandato se basa en el servicio REST [Export runtime resources (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_export_runtime_resources_get.html?view=kc).

<br/>
#### Mandato `adapter show user-config`
{: #the-adapter-show-user-config-command }
El mandato `adapter show user-config` muestra la configuración de usuario del adaptador.

Sintaxis: `adapter [runtime-name] adapter-name show user-config [--xml]`

Acepta las siguientes opciones después del verbo.

| Opción | Descripción |
|--------|-------------|
| --xml | Genera salida en formato XML en lugar de formato JSON. |

**Ejemplo**

```bash
adapter mfp MyAdapter show user-config
```

Este mandato se basa en el servicio REST [Adapter Configuration (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapter_configuration_get.html?view=kc#Adapter-Configuration--GET-).

<br/>
#### Mandato `adapter set user-config`
{: #the-adapter-set-user-config-command }
El mandato `adapter set user-config` especifica la configuración de usuario del adaptador o propiedad individual dentro de esta configuración.

Sintaxis para toda la configuración: `adapter [runtime-name] adapter-name set user-config file`

Acepta los siguientes argumentos después del verbo.

| Opción | Descripción |
|--------|-------------|
| file | Nombre del archivo XML o JSON que contiene la nueva configuración. |

Sintaxis para una propiedad individual: `adapter [runtime-name] adapter-name set user-config property = value`

Acepta los siguientes argumentos después del verbo.

| Opción | Descripción |
|--------|-------------|
| property | Nombre de la propiedad JSON. Para una propiedad anidada, utilice la sintaxis prop1.prop2.....propN. Para un elemento de matriz JSON, utilice el índice en lugar de un nombre de propiedad. |
| value | Valor de la propiedad. |

**Ejemplos**

```bash
adapter mfp MyAdapter set user-config myconfig.json
```

```bash
adapter mfp MyAdapter set user-config timeout = 240
```

Este mandato se basa en el servicio REST [Adapter configuration (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapter_configuration_put.html?view=kc).

### Mandatos para aplicaciones
{: #commands-for-apps }
Cuando se invoca al programa **mfpadm**, se pueden incluir varios mandatos para las aplicaciones.

#### Mandato `list apps`
{: #the-list-apps-command }
El mandato `list apps` devuelve una lista de aplicaciones desplegadas en un tiempo de ejecución.

Sintaxis: `list apps [runtime-name]`

Acepta los siguientes argumentos:

| Argumento | Descripción |
|----------|-------------|
| runtime-name | Nombre de tiempo de ejecución. |

El mandato `list apps` acepta las siguientes opciones después del objeto.

| Opción | Descripción |
|--------|-------------|
| --xml | Produce salida XML en lugar de una salida tabular. |

**Ejemplo**

```bash
list apps mfp
```

Este mandato se basa en el servicio REST [Applications (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_applications_get.html?view=kc#Applications--GET-).

#### Mandato `deploy app`
{: #the-deploy-app-command }
El mandato `deploy app` despliega una versión de aplicación en un tiempo de ejecución.

Sintaxis: `deploy app [runtime-name] file`

Acepta los siguientes argumentos:

| Argumento | Descripción |
|----------|-------------|
| runtime-name | Nombre de tiempo de ejecución. |
| file | Descriptor de la aplicación, un archivo JSON. |

**Ejemplo**

```bash
deploy app mfp MyApp/application-descriptor.json
```

Este mandato se basa en el servicio REST [Application (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_post.html?view=kc#Application--POST-).

#### Mandato `show app`
{: #the-show-app-command }
El mandato `show app` muestra detalles sobre una aplicación en un tiempo de ejecución, en concreto, sus entornos y versiones.

Sintaxis: `show app [runtime-name] app-name`

Acepta los siguientes argumentos:

| Argumento | Descripción |
|----------|-------------|
| runtime-name | Nombre de tiempo de ejecución. |
| app-name | Nombre de una aplicación. |

El mandato `show app` acepta las siguientes opciones después del objeto.

| Opción | Descripción |
|--------|-------------|
| --xml	 | Produce salida XML en lugar de una salida tabular. |

**Ejemplo**

```bash
show app mfp MyApp
```

Este mandato se basa en el servicio REST [Application (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_get.html?view=kc#Application--GET-).

#### Mandato `delete app`
{: #the-delete-app-command }
El mandato `delete app` elimina (retira el despliegue) una aplicación, de todos los entornos y todas las versiones, de un tiempo de ejecución.

Sintaxis: `delete app [runtime-name] app-name`

Acepta los siguientes argumentos:

| Argumento | Descripción |
|----------|-------------|
| runtime-name | Nombre de tiempo de ejecución. |
| app-name | Nombre de una aplicación |

**Ejemplo**

```bash
delete app mfp MyApp
```

Este mandato se basa en el servicio REST [Application Version (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_version_delete.html?view=kc#Application-Version--DELETE-).

#### Mandato `show app version`
{: #the-show-app-version-command }
El mandato `show app version` muestra detalles sobre una versión de aplicación en un tiempo de ejecución.

Sintaxis: `show app version [runtime-name] app-name environment version`

Acepta los siguientes argumentos:

| Argumento | Descripción |
|----------|-------------|
| runtime-name | Nombre de tiempo de ejecución. |
| app-name | Nombre de una aplicación. |
| environment | Plataforma móvil. |
| version | Versión de la aplicación. |

El mandato `show app version` acepta las siguientes opciones después del objeto.

| Argumento | Descripción |
| ---------|-------------|
| -- xml | Produce salida XML en lugar de una salida tabular. |

**Ejemplo**

```bash
show app version mfp MyApp iPhone 1.1
```

Este mandato se basa en el servicio REST [Application Version (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_version_get.html?view=kc#Application-Version--GET-).

#### Mandato `delete app version`
{: #the-delete-app-version-command }
El mandato `delete app version` elimina (retira el despliegue) una aplicación de un tiempo de ejecución.

Sintaxis: `delete app version [runtime-name] app-name environment version`

Acepta los siguientes argumentos:

| Argumento | Descripción |
|----------|-------------|
| runtime-name | Nombre de tiempo de ejecución. |
| app-name | Nombre de una aplicación. |
| environment | Plataforma móvil. |
| version | Versión de la aplicación. |

**Ejemplo**

```bash
delete app version mfp MyApp iPhone 1.1
```

Este mandato se basa en el servicio REST [Application Version (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_version_delete.html?view=kc#Application-Version--DELETE-).

#### Prefijo de mandato `app`
{: #the-app-command-prefix }
El prefijo de mandato `app` utiliza los siguientes argumentos antes del verbo.

| Argumento | Descripción |
|----------|-------------|
| runtime-name | Nombre de tiempo de ejecución. |
| app-name | Nombre de una aplicación. |

#### Mandato `app show license-config`
{: #the-app-show-license-config-command }
El mandato `app show license-config` muestra la configuración de licencia de señal de una aplicación.

Sintaxis: `app [runtime-name] app-name show license-config`

Acepta las siguientes opciones después del objeto:

| Argumento | Descripción |
|----------|-------------|
| --xml | Produce salida XML en lugar de una salida tabular. |

**Ejemplo**

```bash
app mfp MyApp show license-config
```

Este mandato se basa en el servicio REST [Application (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_license_configuration_get.html?view=kc).

#### Mandato `app set license-config`
{: #the-app-set-license-config-command }
El mandato `app set license-config` especifica la configuración de licencia de señal de una aplicación.

Sintaxis: `app [runtime-name] app-name set license-config app-type license-type`

Acepta los siguientes argumentos después del verbo.

| Argumento | Descripción |
|----------|-------------|
| appType | Tipo de aplicación: B2C o B2E. |
| licenseType | Tipo de aplicación: APPLICATION o ADDITIONAL_BRAND_DEPLOYMENT o NON_PRODUCTION. |

**Ejemplo**

```bash
app mfp MyApp iPhone 1.1 set license-config B2E APPLICATION
```

Este mandato se basa en el servicio REST [Application License Configuration (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_license_configuration__post.html?view=kc)

#### Mandato `app delete license-config`
{: #the-app-delete-license-config-command }
El mandato `app delete license-config` restablece la configuración de licencia de señal de una aplicación, esto es, la devuelve a su estado inicial.

Sintaxis: `app [runtime-name] app-name delete license-config`

**Ejemplo**

```bash
app mfp MyApp iPhone 1.1 delete license-config
```

Este mandato se basa en el servicio REST [License configuration (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_license_configuration_delete.html?view=kc#License-configuration--DELETE-).

#### Prefijo de mandato `app version`
{: #the-app-version-command-prefix }
El prefijo de mandato `app version` utiliza los siguientes argumentos antes del verbo.

| Argumento | Descripción |
|----------|-------------|
| runtime-name | Nombre de tiempo de ejecución. |
| app-name | Nombre de una aplicación. |
| environment | Plataforma móvil |
| version | Versión de la aplicación |

#### Mandato `app version get descriptor`
{: #the-app-version-get-descriptor-command }
El mandato `app version get descriptor` devuelve el descriptor de aplicación de una versión de una aplicación.

Sintaxis: `app version [runtime-name] app-name environment version get descriptor [> tofile]`

Acepta los siguientes argumentos después del verbo.

| Argumento | Descripción | Obligatorio | Predeterminado |
|----------|-------------|----------|---------|
| > tofile | Nombre del archivo de salida. | No | Salida estándar |

**Ejemplo**

```bash
app version mfp MyApp iPhone 1.1 get descriptor > /tmp/MyApp-application-descriptor.json
```

Este mandato se basa en el servicio REST [Application Descriptor (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_descriptor_get.html?view=kc#Application-Descriptor--GET-).

#### Mandato `app version get web-resources`
{: #the-app-version-get-web-resources-command }
El mandato `app version get web-resources` devuelve los recursos web de una versión de una aplicación, como un archivo .zip.

Sintaxis: `app version [runtime-name] app-name environment version get web-resources [> tofile]`

Acepta los siguientes argumentos después del verbo.

| Argumento | Descripción | Obligatorio | Predeterminado |
|----------|-------------|----------|---------|
| > tofile | Nombre del archivo de salida. | No | Salida estándar |

**Ejemplo**

```bash
app version mfp MyApp iPhone 1.1 get web-resources > /tmp/MyApp-web.zip
```

Este mandato se basa en el servicio REST [Retrieve Web Resource (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_retrieve_web_resource_get.html?view=kc#Retrieve-Web-Resource--GET-).

#### Mandato `app version set web-resources`
{: #the-app-version-set-web-resources-command }
El mandato `app version set web-resources` especifica los recursos web de una versión de una aplicación.

Sintaxis: `app version [runtime-name] app-name environment version set web-resources file`

Acepta los siguientes argumentos después del verbo.

| Argumento | Descripción |
| file | Nombre del archivo de entrada (debe ser un archivo .zip). |

**Ejemplo**

```bash
app version mfp MyApp iPhone 1.1 set web-resources /tmp/MyApp-web.zip
```

Este mandato se basa en el servicio REST [Deploy a web resource (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_deploy_a_web_resource_post.html?view=kc#Deploy-a-web-resource--POST-).

#### Mandato `app version get authenticity-data`
{: #the-app-version-get-authenticity-data-command }
El mandato `app version get authenticity-data` devuelve los datos de autenticidad de una versión de una aplicación.

Sintaxis: `app version [runtime-name] app-name environment version get authenticity-data [> tofile]`

Acepta los siguientes argumentos después del verbo.

| Argumento | Descripción | Necesario | Predeterminado |
| > tofile | Nombre del archivo de salida. | No | Salida estándar |

**Ejemplo**

```bash
app version mfp MyApp iPhone 1.1 get authenticity-data > /tmp/MyApp.authenticity_data
```

Este mandato se basa en el servicio REST [Export runtime resources (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_export_runtime_resources_get.html?view=kc).

#### Mandato `app version set authenticity-data`
{: #the-app-version-set-authenticity-data-command }
El mandato `app version set authenticity-data` especifica los datos de autenticidad de una versión de una aplicación.

Sintaxis: `app version [runtime-name] app-name environment version set authenticity-data file`

Acepta los siguientes argumentos después del verbo.

| Argumento | Descripción |
|----------|-------------|
| file | Nombre del archivo de entrada:<ul><li>Un archivo .authenticity_data,</li><li>O un archivo de dispositivo (.ipa, .apk o .appx), a partir del que se extraen los datos de autenticidad.</li></ul>|

**Ejemplos**

```bash
app version mfp MyApp iPhone 1.1 set authenticity-data /tmp/MyApp.authenticity_data
```

```bash
app version mfp MyApp iPhone 1.1 set authenticity-data MyApp.ipa
```

```bash
app version mfp MyApp android 1.1 set authenticity-data MyApp.apk
```

Este mandato se basa en el servicio REST [Deploy Application Authenticity Data (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_deploy_application_authenticity_data_post.html?view=kc).

#### Mandato `app version delete authenticity-data`
{: #the-app-version-delete-authenticity-data-command }
El mandato `app version delete authenticity-data` suprime los datos de autenticidad de una versión de una aplicación.

Sintaxis: `app version [runtime-name] app-name environment version delete authenticity-data`

**Ejemplo**

```bash
app version mfp MyApp iPhone 1.1 delete authenticity-data
```

Este mandato se basa en el servicio REST [Application Authenticity (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_authenticity_delete.html?view=kc).

#### Mandato `app version show user-config`
{: #the-app-version-show-user-config-command }
El mandato `app version show user-config` muestra la configuración de usuario de una versión de una aplicación.

Sintaxis: `app version [runtime-name] app-name environment version show user-config [--xml]`

Acepta las siguientes opciones después del verbo.

| Argumento | Descripción | Obligatorio | Predeterminado |
|----------|-------------|----------|---------|
| [--xml] | Genera salida en formato XML en lugar de formato JSON. | No | Salida estándar |

**Ejemplo**

```bash
app version mfp MyApp iPhone 1.1 show user-config
```

Este mandato se basa en el servicio REST [Application Configuration (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_configuration_get.html?view=kc#Application-Configuration--GET-).

### Mandato `app version set user-config`
{: #the-app-version-set-user-config-command }
El mandato `app version set user-config` especifica la configuración de usuario de una versión de una aplicación o de una propiedad individual en dicha configuración.

Sintaxis para toda la configuración: `app version [runtime-name] app-name environment version set user-config file`

Acepta los siguientes argumentos después del verbo.

| Argumento | Descripción |
|----------|-------------|
| file | Nombre del archivo XML o JSON que contiene la nueva configuración. |

Sintaxis para una propiedad individual: `app version [runtime-name] app-name environment version set user-config property = value`

El mandato `app version set user-config` utiliza los siguientes argumentos después del verbo.

| Argumento | Descripción |
|----------|-------------|
| property | Nombre de la propiedad JSON. Para una propiedad anidada, utilice la sintaxis prop1.prop2.....propN. Para un elemento de matriz JSON, utilice el índice en lugar de un nombre de propiedad. |
| value | Valor de la propiedad. |

**Ejemplos**

```bash
app version mfp MyApp iPhone 1.1 set user-config /tmp/MyApp-config.json
```

```bash
app version mfp MyApp iPhone 1.1 set user-config timeout = 240
```

Este mandato se basa en el servicio REST [Application Configuration (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_configuration_put.html?view=kc)

### Mandatos para dispositivos
{: #commands-for-devices }
Cuando invoca al programa **mfpadm**, puede incluir varios mandatos para los dispositivos.

#### Mandato `list devices`
{: #the-list-devices-command }
El mandato `list devices` devuelve una lista de dispositivos que se han puesto en contacto con las aplicaciones de un tiempo de ejecución.

Sintaxis: `list devices [runtime-name] [--query query]`

Acepta los siguientes argumentos:

| Argumento | Descripción |
|----------|-------------|
| runtime-name | Nombre de tiempo de ejecución. |
| query | Nombre descriptivo o identificador de usuario, para buscar. Este parámetro especifica una serie que buscar. Se devuelven todos los dispositivos que tienen un nombre descriptivo o identificador de usuario que contenga esta serie (con coincidencia insensible a las mayúsculas y minúsculas). |

El mandato `list devices` acepta las siguientes opciones después del objeto.

| Opción | Descripción |
|--------|-------------|
| --xml | Produce salida XML en lugar de una salida tabular. |

**Ejemplos**

```bash
list-devices mfp
```

```bash
list-devices mfp --query=john
```

Este mandato se basa en el servicio [Devices (GET) REST](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_devices_get.html?view=kc#Devices--GET-).

#### Mandato `remove device`
{: #the-remove-device-command }
El mandato `remove device` borra el registro sobre un dispositivo que contactó las aplicaciones de un tiempo de ejecución.

Sintaxis: `remove device [runtime-name] id`

Acepta los siguientes argumentos:

| Argumento | Descripción |
|----------|-------------|
| runtime-name | Nombre de tiempo de ejecución. |
| id | Identificador de dispositivo exclusivo. |

**Ejemplo**

```bash
remove device mfp 496E974CCEDE86791CF9A8EF2E5145B6
```

Este mandato se basa en el servicio REST [Device (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_device_delete.html?view=kc#Device--DELETE-).

#### Prefijo de mandato `device`
{: #the-device-command-prefix }
El prefijo de mandato `device` utiliza los siguientes argumentos antes del verbo.

| Argumento | Descripción |
|----------|-------------|
| runtime-name | Nombre de tiempo de ejecución. |
| id | Identificador de dispositivo exclusivo. |

#### Mandato `device set status`
{: #the-device-set-status-command }
El mandato `device set status` cambia el estado de un dispositivo, en el ámbito de un tiempo de ejecución.

Sintaxis: `device [runtime-name] id set status new-status`

Acepta los siguientes argumentos:

| Argumento | Descripción |
|----------|-------------|
| new-status | Nuevo estado. |

El estado puede tener uno de los siguientes valores:

* ACTIVE
* LOST
* STOLEN
* EXPIRED
* DISABLED

**Ejemplo**

```bash
device mfp 496E974CCEDE86791CF9A8EF2E5145B6 set status EXPIRED
```

Este mandato se basa en el servicio REST [Device Status (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_device_status_put.html?view=kc#Device-Status--PUT-).

#### Mandato `device set appstatus`
{: #the-device-set-appstatus-command }
El mandato `device set appstatus` cambia el estado de un dispositivo, en relación a una aplicación en un tiempo de ejecución.

Sintaxis: `device [runtime-name] id set appstatus app-name new-status`

Acepta los siguientes argumentos:

| Argumento | Descripción |
|----------|-------------|
| app-name | Nombre de una aplicación. |
| new-status | Nuevo estado. |

El estado puede tener uno de los siguientes valores:

* ENABLED
* DISABLED


**Ejemplo**

```xml
device mfp 496E974CCEDE86791CF9A8EF2E5145B6 set appstatus MyApp DISABLED
```

Este mandato se basa en el servicio REST [Device Application Status (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_device_application_status_put.html?view=kc#Device-Application-Status--PUT-).

### Mandatos para la resolución de problemas
{: #commands-for-troubleshooting }
Cuando se invoca al programa **mfpadm**, se pueden incluir varios mandatos para la resolución de problemas.

#### Mandato `show info`
{: #the-show-info-command }
El mandato `show info` muestra información básica sobre los servicios de administración de {{ site.data.keys.product_adj }} que se pueden devolver sin acceder a un tiempo de ejecución ni a una base de datos. Utilice esta mandato para verificar si los servicios de administración de {{ site.data.keys.product_adj }} están en ejecución.

Sintaxis: `show info`

Acepta las siguientes opciones después del objeto.

| Opción | Descripción |
|--------|-------------|
| --xml | Produce salida XML en lugar de una salida tabular. |

**Ejemplo**

```bash
show info
```

#### Mandato `show versions`
{: #the-show-versions-command }
El mandato `show versions` visualiza versiones de {{ site.data.keys.product_adj }} de varios componentes:

* **mfpadmVersion**: Número de versión de {{ site.data.keys.mf_server }} exacta de la que se toma **mfp-ant-deployer.jar**.
* **productVersion**: Número de versión de {{ site.data.keys.mf_server }} exacta de la que se toma **mfp-admin-service.war**.
* **mfpAdminVersion**: Número de versión de construcción exacto de sólo **mfp-admin-service.war**.

Sintaxis: `show versions`

Acepta las siguientes opciones después del objeto.

| Opción | Descripción |
|--------|-------------|
| --xml | Produce salida XML en lugar de una salida tabular. |

**Ejemplo**

```bash
show versions
```

#### Mandato `show diagnostics`
{: #the-show-diagnostics-command }
El mandato `show diagnostics` muestra el estado de varios componentes que son necesarios para el correcto funcionamiento del servicio de administración de {{ site.data.keys.product_adj }} como, por ejemplo, la disponibilidad de la base de datos y de los servicios auxiliares.

Sintaxis: `show diagnostics`

Acepta las siguientes opciones después del objeto.

| Opción | Descripción |
|--------|-------------|
| --xml | Produce salida XML en lugar de una salida tabular. |

**Ejemplo**

```bash
show diagnostics
```

#### Mandato `unlock`
{: #the-unlock-command }
El mandato `unlock` libera el bloqueo de propósito general. Algunas operaciones destructivas toman este bloqueo con el propósito de impedir una modificación de forma simultánea de los mismos datos de configuración. En casos poco habituales, si se interrumpe una operación de este tipo, el bloqueo permanece en estado bloqueado, haciendo imposibles otras operaciones destructivas. Utilice el mandato unlock para liberar el bloqueo en estos casos.

**Ejemplo**

```bash
unlock
```

#### Mandato `list runtimes`
{: #the-list-runtimes-command }
El mandato `list runtimes` devuelve una lista de tiempos de ejecución desplegados.

Sintaxis: `list runtimes [--in-database]`

Acepta las siguientes opciones:

| Opción | Descripción |
|--------|-------------|
| --in-database	| Indica si buscar en la base de datos en lugar de hacerlo a través de MBeans |
| --xml | Produce salida XML en lugar de una salida tabular. |

**Ejemplos**

```bash
list runtimes
```

```bash
list runtimes --in-database
```

Este mandato se basa en el servicio REST [Runtimes (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_runtimes_get.html?view=kc#Runtimes--GET-).

#### Mandato `show runtime`
{: #the-show-runtime-command }
El mandato `show runtime` muestra información sobre un tiempo de ejecución desplegado dado.

Sintaxis: `show runtime [runtime-name]`

Acepta los siguientes argumentos:

| Argumento | Descripción |
|----------|-------------|
| runtime-name | Nombre de tiempo de ejecución. |

El mandato `show runtime` acepta las siguientes opciones después del objeto.

| Opción | Descripción |
|--------|-------------|
| --xml | Produce salida XML en lugar de una salida tabular. |

Este mandato se basa en el servicio REST [Runtime (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_runtime_get.html?view=kc#Runtime--GET-).

**Ejemplo**

```bash
show runtime mfp
```

#### Mandato `delete runtime`
{: #the-delete-runtime-command }
El mandato `delete runtime` suprime un tiempo de ejecución, incluidas sus aplicaciones y adaptadores, de la base de datos. Únicamente puede suprimir un tiempo de ejecución cuando se hayan detenido sus aplicaciones web.

Sintaxis: `delete runtime [runtime-name] condition`

Acepta los siguientes argumentos:

| Argumento | Descripción |
|----------|-------------|
| runtime-name | Nombre de tiempo de ejecución. |
| condition | Condición cuando lo suprime: empty o always. **Atención:** La opción always es peligrosa. |

**Ejemplo**

```bash
delete runtime mfp empty
```

Este mandato se basa en el servicio REST [Runtime (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_runtime_delete.html?view=kc#Runtime--DELETE-).

#### Mandato `list farm-members`
{: #the-list-farm-members-command }
El mandato `list farm-members` muestra una lista de servidores de miembro de granja en los que se ha desplegado un tiempo de ejecución dado.

Sintaxis: `list farm-members [runtime-name]`

Acepta los siguientes argumentos:

| Argumento | Descripción |
|----------|-------------|
| runtime-name | Nombre de tiempo de ejecución. |

El mandato `list farm-members` acepta las siguientes opciones después del objeto.

| Opción | Descripción |
|--------|-------------|
| --xml | Produce salida XML en lugar de una salida tabular. |

**Ejemplo**

```bash
list farm-members mfp
```

Este mandato se basa en el servicio REST [Farm topology members (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_farm_topology_members_get.html?view=kc#Farm-topology-members--GET-).

#### Mandato `remove farm-member`
{: #the-remove-farm-member-command }
El mandato `remove farm-member` elimina un servidor de la lista de miembros de granja en la que se ha desplegado el tiempo de ejecución especificado. Utilice este mandato cuando el servidor no esté disponible o se haya desconectado.

Sintaxis: `remove farm-member [runtime-name] server-id`

Acepta los siguientes argumentos.

| Argumento | Descripción |
|----------|-------------|
| runtime-name | Nombre de tiempo de ejecución. |
| server-id | Identificador del servidor. |

El mandato `remove farm-member` acepta las siguientes opciones después del objeto.

| Opción | Descripción |
|--------|-------------|
| --force | Forzar la eliminación de un miembro de granja, incluso cuando no está disponible o está desconectado. |

**Ejemplo**

```bash
remove farm-member mfp srvlx15
```

Este mandato se basa en el servicio REST [Farm topology members (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_farm_topology_members_delete.html?view=kc).
