---
layout: tutorial
title: Administración de aplicaciones a través de Ant
breadcrumb_title: Administración con Ant
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
Administre las aplicaciones de {{ site.data.keys.product_adj }} a través de la tarea Ant **mfpadm**.

#### Ir a
{: #jump-to }

* [Comparación con otros recursos](#comparison-with-other-facilities)
* [Requisitos previos](#prerequisites)

## Comparación con otros recursos
{: #comparison-with-other-facilities }
Puede ejecutar operaciones de administración con {{ site.data.keys.product_full }} de las siguientes maneras:

* {{ site.data.keys.mf_console }}, que es interactivo.
* Tareas Ant de **mfpadm**.
* El programa **mfpadm**.
* Los servicios REST de administración de {{ site.data.keys.product_adj }}.

Las tareas Ant de **mfpadm**, el programa **mfpadm** y los servicios REST son útiles para realizar operaciones de ejecución automatizada o sin supervisión como, por ejemplo:

* Eliminación de errores de operador en las operaciones repetitivas, o
* Operaciones fuera de las horas normales de trabajo de los operadores, o
* Configuración de un servidor de producción con los mismos valores que los de un servidor de prueba o previo a la producción.

Las tareas Ant de **mfpadm** y el programa **mfpadm** son más fáciles de utilizar e informan mejor sobre los errores que los servicios REST. La ventaja de las tareas Ant de **mfpadm** sobre el programa mfpadm es que son independientes de la plataforma y más fáciles de integrar cuando la integración de Ant ya está disponible.

## Requisitos previos
{: #prerequisites }
La herramienta **mfpadm** se instala con el instalador de {{ site.data.keys.mf_server }}. En el resto de esta página **dir\_instalacion\_producto** indica el directorio de instalación del instalador de {{ site.data.keys.mf_server }}.

Para ejecutar las tareas de **mfpadm** se necesita Apache Ant. Para obtener información sobre la versión mínima soportada de Ant, consulte los Requisitos del sistema.

Como ayuda, Apache Ant 1.9.4 se incluye en {{ site.data.keys.mf_server }}. Se proporcionan los siguientes scripts en el directorio **dir\_instalacion\_producto/shortcuts/**.

* ant para UNIX / Linux
* ant.bat para Windows

Estos scripts están listos para ser ejecutados, lo que significa que no precisan de variables de entorno específicas. Si se ha establecido la variable de entorno JAVA_HOME, el script la acepta.

Puede utilizar las tareas Ant de **mfpadm** en un sistema diferente del sistema en que {{ site.data.keys.mf_server }} está instalado.

* Copie el archivo **dir\_instalacion\_producto/MobileFirstServer/mfp-ant-deployer.jar** al sistema.
* Asegúrese de que en el sistema hay instalada una versión soportada de Apache Ant y un entorno de tiempo de ejecución de Java.

Para utilizar las tareas Ant de **mfpadm**, añada este mandato de inicialización al script Ant:

```xml
<taskdef resource="com/ibm/mfp/ant/deployers/antlib.xml">
  <classpath>
    <pathelement location="product_install_dir/MobileFirstServer/mfp-ant-deployer.jar"/>
  </classpath>
</taskdef>
```

Otros mandatos de inicialización que hacen referencia al mismo archivo **mfp-ant-deployer.jar** son redundantes porque la inicialización mediante **defaults.properties** es realizada por antlib.xml de forma implícita. A continuación se muestra un ejemplo de un mandato de inicialización redundante:

```xml
<taskdef resource="com/ibm/mfp/ant/defaults.properties">
  <classpath>
    <pathelement location="product_install_dir/MobileFirstServer/mfp-ant-deployer.jar"/>
  </classpath>
</taskdef>
```

Para obtener más información sobre cómo ejecutar el instalador de {{ site.data.keys.mf_server }}, consulte [Ejecución de IBM Installation Manager](../../installation-configuration/production/installation-manager/).

#### Ir a
{: #jump-to-1 }

* [Llamada a tareas Ant de **mfpadm**](#calling-the-mfpadm-ant-task)
* [Mandatos para la configuración general](#commands-for-general-configuration)
* [Mandatos para los adaptadores](#commands-for-adapters)
* [Mandatos para las aplicaciones](#commands-for-apps)
* [Mandatos para los dispositivos](#commands-for-devices)
* [Mandatos para la resolución de problemas](#commands-for-troubleshooting)

### Llamada a una tarea Ant de mfpadm
{: #calling-the-mfpadm-ant-task }
Utilice las tareas Ant de **mfpadm** y sus mandatos asociados para administrar las aplicaciones de {{ site.data.keys.product_adj }}.
Llame a las tareas Ant de **mfpadm** de la siguiente manera:

```xml
<mfpadm url=... user=... password=...|passwordfile=... [secure=...]>
    algunos mandatos
</mfpadm>
```

#### Atributos
{: #attributes }
Las tareas Ant de **mfpadm** tienen los siguientes atributos:

| Atributo      | Descripción | Obligatorio | Predeterminado | 
|----------------|-------------|----------|---------|
| url	         | URL base de la aplicación web de {{ site.data.keys.product_adj }} para los servicios de administración | Sí	 | |
| secure	     | Evitar operaciones con riesgos de seguridad | No | verdadero |
| user	         | Nombre de usuario para acceder a los servicios de administración de {{ site.data.keys.product_adj }} | Sí | |
| password	     | Contraseña del usuario. | Se necesita una | |
| passwordfile   |	Archivo que contiene la contraseña para el usuario | Se necesita una | |	 
| timeout	     | Tiempo de espera para todo el acceso al servicio REST, en segundos | No | |
| connectTimeout |	Tiempo de espera para establecer una conexión de red, en segundos | No | |	 
| socketTimeout  |	Tiempo de espera para detectar la pérdida de una conexión de red, en segundos | No | |
| connectionRequestTimeout |	Tiempo de espera para obtener una entrada de una agrupación de solicitudes de conexión, en segundos | No | |
| lockTimeout    |	Tiempo de espera para adquirir un bloqueo | No | |

**url**<br/>
El URL base preferentemente utiliza el protocolo HTTPS. Por ejemplo, si utiliza las raíces de contexto y los puertos predeterminados, utilice el siguiente URL.

* Para WebSphere Application Server: [https://server:9443/worklightadmin](https://server:9443/worklightadmin)
* Para Tomcat: [https://server:8443/worklightadmin](https://server:8443/worklightadmin)

**secure**<br/>
El valor predeterminado es **true**. Si establece **secure="false"** podría ocurrir lo siguiente:

* El usuario y la contraseña se podrían transmitir de forma no segura, posiblemente a través de tráfico HTTP sin cifrar.
* Los certificados SSL del servidor se aceptarán incluso si están autofirmados o si se crearon para un nombre de host diferente al nombre de host del servidor especificado.

**password**<br/>
Especifique la contraseña en el script Ant, a través del atributo **password** o en el archivo aparte que pasará a través del atributo **passwordfile**. La contraseña es información confidencial y, por lo tanto, debe estar protegida. Debe impedir que otros usuarios en el mismo sistema sepan esta contraseña. Para proteger la contraseña, antes de especificarla en un archivo, elimine los permisos de lectura del archivo a otros usuarios que no sean usted mismo. Por ejemplo, puede utilizar uno de los siguientes mandatos:

* En UNIX: `chmod 600 adminpassword.txt`
* En Windows: `cacls adminpassword.txt /P Administrators:F %USERDOMAIN%\%USERNAME%:F`

Además, es posible que desee enmascarar la contraseña para ocultarla de cualquier visualización accidental. Para ello, utilice el mandato **mfpadm** config password para almacenar la contraseña enmascarada en un archivo de configuración. A continuación, puede copiar y pegar el contraseña enmascarada en el script de Ant o en el archivo de contraseña.

La llamada **mfpadm** contiene mandatos que se codifican como elementos internos. Estos mandatos se ejecutan en el orden en el que aparecen listados. Si uno de los mandatos falla, el resto de los mandatos no se ejecutan y la llamada **mfpadm** falla.

#### Elementos
{: #elements }
Utilice los siguientes elementos en llamadas de **mfpadm**:

| Elemento                       | Descripción | Número |
|-------------------------------|-------------|-------|
| show-info	                    | Muestra información de configuración y de usuario | 0..∞ | 
| show-global-config	        | Muestra información de configuración global | 0..∞ | 
| show-diagnostics              | Muestra información de diagnósticos | 0..∞ | 
| show-versions	                | Muestra información de versiones | 0..∞ | 
| unlock	                    | Libera el bloqueo de propósito general | 0..∞ | 
| list-runtimes	                | Lista los tiempos de ejecución | 0..∞ | 
| show-runtime      	        | Muestra información sobre un tiempo de ejecución | 0..∞ | 
| delete-runtime	            | Suprime un tiempo de ejecución | 0..∞ | 
| show-user-config	            | Muestra la configuración de usuario de un tiempo de ejecución | 0..∞ | 
| set-user-config	            | Especifica la configuración de usuario de un tiempo de ejecución | 0..∞ | 
| show-confidential-clients	    | Muestra las configuraciones de clientes confidenciales de un tiempo de ejecución | 0..∞ | 
| set-confidential-clients	    | Especifica las configuraciones de clientes confidenciales de un tiempo de ejecución | 0..∞ | 
| set-confidential-clients-rule	| Especifica una regla para la configuración de clientes confidenciales de un tiempo de ejecución | 0..∞ | 
| list-adapters	                | Lista los adaptadores | 0..∞ | 
| deploy-adapter	            | Despliega un adaptador | 0..∞ | 
| show-adapter	                | Muestra información sobre un adaptador | 0..∞ | 
| delete-adapter	            | Suprime un adaptador | 0..∞ | 
| adapter	                    | Otras operaciones en un adaptador | 0..∞ | 
| list-apps	                    | Lista las aplicaciones | 0..∞ | 
| deploy-app	                | Despliega una aplicación | 0..∞ | 
| show-app	                    | Muestra información sobre una aplicación | 0..∞ | 
| delete-app	                | Suprime una aplicación | 0..∞ | 
| show-app-version              | Muestra información sobre una versión de aplicación | 0..∞ | 
| delete-app-version            | Suprime una versión de una aplicación | 0..∞ | 
| app	                        | Otras operaciones en una aplicación | 0..∞ | 
| app-version	                | Otras operaciones en una versión de aplicación | 0..∞ | 
| list-devices	                | Lista los dispositivos | 0..∞ | 
| remove-device	                | Elimina un dispositivo. | 0..∞ | 
| device	                    | Otras operaciones para un dispositivo | 0..∞ | 
| list-farm-members	            | Lista los miembros de la granja de servidores | 0..∞ | 
| remove-farm-member	        | Elimina un miembro de la granja de servidores | 0..∞ | 

#### Formato XML
{: #xml-format }
La salida de la mayoría de los mandatos es en XML, y la entrada para mandatos específicos, como por ejemplo `<set-accessrule>`, también es XML. Puede encontrar los esquemas XML de estos formatos XML en el directorio **dir\_instalacion\_producto/MobileFirstServer/mfpadm-schemas/**. Los mandatos que reciben una respuesta XML del servidor verifican que dicha respuesta cumpla el esquema especifico. Puede inhabilitar esta comprobación especificando el atributo **xmlvalidation="none"**. 

#### Conjunto de caracteres de salida
{: #output-character-set }
La salida normal de las tareas Ant de mfpadm se codifica en el entorno local actual. En Windows, este formato de codificación es el denominado el de la "página de códigos ANSI". Los resultados son los siguientes:

* Los caracteres fuera de este conjunto de caracteres se convierten en interrogantes de cierre en la salida.
* Cuando la salida se dirige a una ventana de un indicador de mandatos de Windows (cmd.exe), los caracteres no ASCII se visualizan de forma incorrecta porque en estas ventanas se presupone que los caracteres están codificados de acuerdo a la denominada "página de códigos OEM".

Para solucionar esta limitación:

* En sistemas operativos distintos de Windows, utilice un entorno local cuya codificación sea UTF-8. Este entorno local es el entorno local predeterminado en Red Hat Linux y macOS. Muchos sistemas operativos tienen el entorno local en_US.UTF-8.
* O bien utilice el atributo **output="un nombre de archivo"** para redirigir la salida de un mandato mfpadm a un archivo.

### Mandatos para la configuración general
{: #commands-for-general-configuration }
Cuando llama a una tarea Ant de **mfpadm**, puede incluir varios mandatos para acceder a la configuración global de IBM {{ site.data.keys.mf_server }} o de un tiempo de ejecución.

#### Mandato `show-global-config`
{: #the-show-global-config-command }
El mandato `show-global-config` muestra la configuración global. Tiene los siguientes atributos:

| Atributo      | Descripción |	Obligatorio | Predeterminado |
|----------------|-------------|-------------|---------|
| output	     | Nombre del archivo de salida.  |	No	   | No aplicable |
| outputproperty | Nombre de la propiedad Ant para la salida. | No | No aplicable |

**Ejemplo**  

```xml
<show-global-config/>
```

Este mandato se basa en el servicio REST [Global Configuration (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_global_configuration_get.html?view=kc#Global-Configuration--GET-)

<br/>
#### Mandato `show-user-config`
{: #the-show-user-config-command }
El mandato `show-user-config`, fuera de los elementos `<adapter>` y `<app-version>`, muestra la configuración de usuario de un tiempo de ejecución. Tiene los siguientes atributos:

| Atributo      | Descripción |	Obligatorio | Predeterminado |
|----------------|-------------|-------------|---------|
| runtime	     | Nombre de tiempo de ejecución.      | Sí     |	No disponible |
| format	     | Especifica el formato de salida. json o xml. | Sí | No disponible       | 
| output	     | Nombre del archivo en el que almacenar la salida.   | No  | No aplicable      | 
| outputproperty | Nombre de un propiedad Ant en la que almacenar la salida.  | No | No aplicable |

**Ejemplo**  

```xml
<show-user-config runtime="mfp" format="xml"/>
```

Este mandato se basa en el servicio REST [Runtime Configuration (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_runtime_configuration_get.html?view=kc#Runtime-Configuration--GET-).

<br/>
#### Mandato `set-user-config`
{: #the-set-user-config-command }
El mandato `set-user-config`, fuera de los elementos `<adapter>` y `<app-version>`, especifica la configuración de usuario de un tiempo de ejecución. Tiene los siguientes atributos para configurar toda la configuración.

| Atributo      | Descripción |	Obligatorio | Predeterminado |
|----------------|-------------|-------------|---------|
| runtime        | Nombre de tiempo de ejecución. | Sí | No disponible | 
| file	         | Nombre del archivo XML o JSON que contiene la nueva configuración. | Sí | No disponible | 

El mandato `set-user-config` tiene los atributos siguientes para establecer una propiedad individual en la configuración.

| Atributo      | Descripción |	Obligatorio | Predeterminado |
|----------------|-------------|-------------|---------|
| runtime	     | Nombre de tiempo de ejecución. | Sí | No disponible | 
| property	     | Nombre de la propiedad JSON. Para una propiedad anidada, utilice la sintaxis prop1.prop2.....propN. Para un elemento de matriz JSON, utilice el índice en lugar de un nombre de propiedad. | Sí | No disponible | 
| value	         | Valor de la propiedad. | Sí | No disponible |

**Ejemplo**  

```xml
<set-user-config runtime="mfp" file="myconfig.json"/>
```

```xml
<set-user-config runtime="mfp" property="timeout" value="240"/>
```

Este mandato se basa en el servicio REST [Runtime configuration (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_runtime_configuration_put.html?view=kc#Runtime-configuration--PUT-).

<br/>
#### Mandato `show-confidential-clients`
{: #the-show-confidential-clients-command }
El mandato `show-confidential-clients` muestra la configuración de los clientes confidenciales que pueden acceder a un tiempo de ejecución. Para obtener más información sobre los clientes confidenciales, consulte [Clientes confidenciales](../../authentication-and-security/confidential-clients). Este mandato tiene los siguientes atributos:

| Atributo      | Descripción |	Obligatorio | Predeterminado |
|----------------|-------------|-------------|---------|
| runtime        | Nombre de tiempo de ejecución. | Sí | No disponible | 
| format         | Especifica el formato de salida. json o xml. | Sí | No disponible | 
| output         | Nombre del archivo en el que almacenar la salida. | No | No aplicable | 
| outputproperty | Nombre de un propiedad Ant en la que almacenar la salida. | No | No aplicable | 

**Ejemplo**  

```xml
<show-confidential-clients runtime="mfp" format="xml" output="clients.xml"/>
```

Este mandato se basa en el servicio REST [Confidential Clients (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_confidential_clients_get.html?view=kc).

<br/>
#### Mandato `set-confidential-clients`
{: #the-set-confidential-clients-command }
El mandato `set-confidential-clients` especifica la configuración de los clientes confidenciales que pueden acceder a un tiempo de ejecución. Para obtener más información sobre los clientes confidenciales, consulte [Clientes confidenciales](../../authentication-and-security/confidential-clients). Este mandato tiene los siguientes atributos:

| Atributo      | Descripción |	Obligatorio | Predeterminado |
|----------------|-------------|-------------|---------|
| runtime        | Nombre de tiempo de ejecución. | Sí | No disponible | 
| file	         | Nombre del archivo XML o JSON que contiene la nueva configuración. | Sí | No disponible | 

**Ejemplo**  

```xml
<set-confidential-clients runtime="mfp" file="clients.xml"/>
```

Este mandato se basa en el servicio REST [Confidential Clients (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_confidential_clients_put.html?view=kc#Confidential-Clients--PUT-).

<br/>
#### Mandato `set-confidential-clients-rule`
{: #the-set-confidential-clients-rule-command }
El mandato `set-confidential-clients-rule` especifica una regla en la configuración de los clientes confidenciales que pueden acceder a un tiempo de ejecución. Para obtener más información sobre los clientes confidenciales, consulte [Clientes confidenciales](../../authentication-and-security/confidential-clients). Este mandato tiene los siguientes atributos:

| Atributo      | Descripción |	Obligatorio | Predeterminado |
|----------------|-------------|-------------|---------|
| runtime        | Nombre de tiempo de ejecución. | Sí | No disponible | 
| id             | El identificador de la regla. | Sí | No disponible | 
| displayName    | El nombre de visualización de la regla. | Sí | No disponible | 
| secret         | Secreto de la regla. | Sí | No disponible | 
| allowedScope   | Ámbito de la regla. Lista de señales separadas por espacios. | Sí | No disponible | 

**Ejemplo**  

```xml
<set-confidential-clients-rule runtime="mfp" id="push" displayName="Push" secret="lOa74Wxs" allowedScope="**"/>
```

Este mandato se basa en el servicio REST [Confidential Clients (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_confidential_clients_put.html?view=kc#Confidential-Clients--PUT-).

### Mandatos para adaptadores
{: #commands-for-adapters }
Cuando llama a una tarea Ant de **mfpadm**, puede incluir varios mandatos para los adaptadores.

#### Mandato `list-adapters`
{: #the-list-adapters-command }
El mandato `list-adapters` devuelve una lista de adaptadores desplegados para un tiempo de ejecución dado. Tiene los siguientes atributos.

| Atributo      | Descripción |	Obligatorio | Predeterminado |
|----------------|-------------|-------------|---------|
| runtime        | Nombre de tiempo de ejecución. | 	Sí | No disponible | 
| output	     | Nombre del archivo de salida. | 	No  | No aplicable | 
| outputproperty | Nombre de la propiedad Ant para la salida. | No | No aplicable | 

**Ejemplo**  

```xml
<list-adapters runtime="mfp"/>
```

Este mandato se basa en el servicio REST [Adapters (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapters_get.html?view=kc#Adapters--GET-).

<br/>
#### Mandato `deploy-adapter`
{: #the-deploy-adapter-command }
El mandato `deploy-adapter` despliega un adaptador en un tiempo de ejecución. Tiene los siguientes atributos.

| Atributo      | Descripción |	Obligatorio | Predeterminado |
|----------------|-------------|-------------|---------|
| runtime	     | Nombre de tiempo de ejecución. | Sí | No disponible | 
| file           | Archivo de adaptador binario (.adapter). | Sí | No disponible |

**Ejemplo**  

```xml
<deploy-adapter runtime="mfp" file="MyAdapter.adapter"/>
```

Este mandato se basa en el servicio REST [Adapter (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapter_post.html?view=kc#Adapter--POST-).

<br/>
#### Mandato `show-adapter`
{: #the-show-adapter-command }
El mandato `show-adapter` muestra detalles sobre un adaptador. Tiene los siguientes atributos.

| Atributo      | Descripción |	Obligatorio | Predeterminado |
|----------------|-------------|-------------|---------|
| runtime | Nombre de tiempo de ejecución. | Sí | No disponible | 
| nombre | Nombre de un adaptador. | Sí | No disponible | 
| output | Nombre del archivo de salida. | No | No aplicable | 
| outputproperty | Nombre de la propiedad Ant para la salida. | No | No aplicable | 

**Ejemplo**  

```xml
<show-adapter runtime="mfp" name="MyAdapter"/>
```

Este mandato se basa en el servicio REST [Adapter (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapter_get.html?view=kc#Adapter--GET-).

<br/>
#### Mandato `delete-adapter`
{: #the-delete-adapter-command }
El mandato `delete-adapter` elimina (retira el despliegue) de un adaptador de un tiempo de ejecución. Tiene los siguientes atributos.

| Atributo      | Descripción |	Obligatorio | Predeterminado |
|----------------|-------------|-------------|---------|
| runtime | Nombre de tiempo de ejecución. | Sí | No disponible | 
| nombre    | Nombre de un adaptador. | Sí | No disponible | 

**Ejemplo**  

```xml
<delete-adapter runtime="mfp" name="MyAdapter"/>
```

Este mandato se basa en el servicio REST [Adapter (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapter_get.html?view=kc#Adapter--GET-).

<br/>
#### Grupo de mandatos `adapter`
{: #the-adapter-command-group }
El grupo de mandatos `adapter` tiene los siguientes atributos.

| Atributo      | Descripción |	Obligatorio | Predeterminado |
|----------------|-------------|-------------|---------|
| runtime | Nombre de tiempo de ejecución. | Sí | No disponible | 
| nombre | Nombre de un adaptador. | Sí | No disponible | 

El mandato `adapter` da soporte a los siguientes elementos.

| Elemento          | Descripción |	Número    | 
|------------------|-------------|-------------|
| get-binary	   | Obtiene los datos binarios. | 0..∞ | 
| show-user-config | Muestra la configuración de usuario. | 0..∞ | 
| set-user-config  | Especifica la configuración de usuario. | 0..∞ | 

<br/>
#### Mandato `get-binary`
{: #the-get-binary-command }
El mandato `get-binary` dentro de un elemento `<adapter>` devuelve el archivo de adaptador binario. Tiene los siguientes atributos.

| Atributo      | Descripción |	Obligatorio | Predeterminado |
|----------------|-------------|-------------|---------|
| tofile	     | Nombre del archivo de salida. | Sí | No disponible | 

**Ejemplo**  

```xml
<adapter runtime="mfp" name="MyAdapter">
  <get-binary tofile="/tmp/MyAdapter.adapter"/>
</adapter>
```

Este mandato se basa en el servicio REST [Adapter (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapter_get.html?view=kc#Adapter--GET-).

<br/>
#### Mandato `show-user-config`
{: #the-show-user-config-command-1 }
El mandato `show-user-config`, dentro de un elemento `<adapter>`, muestra la configuración del adaptador. Tiene los siguientes atributos.

| Atributo      | Descripción |	Obligatorio | Predeterminado |
|----------------|-------------|-------------|---------|
| format	     | Especifica el formato de salida. json o xml. | Sí | No disponible       | 
| output	     | Nombre del archivo en el que almacenar la salida.   | No  | No aplicable      | 
| outputproperty | Nombre de un propiedad Ant en la que almacenar la salida.  | No | No aplicable |

**Ejemplo**  

```xml
<adapter runtime="mfp" name="MyAdapter">
  <show-user-config format="xml"/>
</adapter>
```

Este mandato se basa en el servicio REST [Adapter Configuration (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapter_configuration_get.html?view=kc#Adapter-Configuration--GET-).

<br/>
#### Mandato `set-user-config`
{: #the-set-user-config-command-1 }
El mandato `set-user-config`, dentro de un elemento `<adapter>`, especifica la configuración del adaptador. Tiene los siguientes atributos para configurar toda la configuración.

| Atributo      | Descripción |	Obligatorio | Predeterminado |
|----------------|-------------|-------------|---------|
| file | Nombre del archivo XML o JSON que contiene la nueva configuración. | Sí | No disponible | 

El mandato tiene los atributos siguientes para establecer una propiedad individual en la configuración.

| Atributo      | Descripción |	Obligatorio | Predeterminado |
|----------------|-------------|-------------|---------|
| property | Nombre de la propiedad JSON. Para una propiedad anidada, utilice la sintaxis prop1.prop2.....propN. Para un elemento de matriz JSON, utilice el índice en lugar de un nombre de propiedad. | Sí | No disponible | 
| value | Valor de la propiedad. | Sí | No disponible | 

**Ejemplos**  

```xml
<adapter runtime="mfp" name="MyAdapter">
  <set-user-config file="myconfig.json"/>
</adapter>
```

```xml
<adapter runtime="mfp" name="MyAdapter">
  <set-user-config property="timeout" value="240"/>
</adapter>
```

Este mandato se basa en el servicio REST [Application Configuration (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_configuration_put.html?view=kc)

### Mandatos para aplicaciones
{: #commands-for-apps }
Cuando llama a una tarea Ant de **mfpadm**, puede incluir varios mandatos para las aplicaciones.

#### Mandato `list-apps`
{: #the-list-apps-command }
El mandato `list-apps` devuelve una lista de aplicaciones desplegadas en un tiempo de ejecución. Tiene los siguientes atributos.

| Atributo      | Descripción |	Obligatorio | Predeterminado |
|----------------|-------------|-------------|---------|
| runtime | Nombre de tiempo de ejecución. | Sí | No disponible | 
| output | Nombre del archivo de salida. | | No | No aplicable | 
| outputproperty | Nombre de la propiedad Ant para la salida. | No | No aplicable | 

**Ejemplo**  

```xml
<list-apps runtime="mfp"/>
```

Este mandato se basa en el servicio REST [Applications (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_applications_get.html?view=kc#Applications--GET-).

<br/>
#### Mandato `deploy-app`
{: #the-deploy-app-command }
El mandato `deploy-app` despliega una versión de aplicación en un tiempo de ejecución. Tiene los siguientes atributos.

| Atributo      | Descripción |	Obligatorio | Predeterminado |
|----------------|-------------|-------------|---------|
| runtime | Nombre de tiempo de ejecución. | Sí | No disponible | 
| file | Descriptor de la aplicación, un archivo JSON. | Sí | No disponible | 

**Ejemplo**  

```xml
<deploy-app runtime="mfp" file="MyApp/application-descriptor.json"/>
```

Este mandato se basa en el servicio REST [Application (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_post.html?view=kc#Application--POST-).

<br/>
#### Mandato `show-app`
{: #the-show-app-command }
El mandato `show-app` devuelve una lista de versiones de aplicación desplegadas en un tiempo de ejecución. Tiene los siguientes atributos.

| Atributo      | Descripción |	Obligatorio | Predeterminado |
|----------------|-------------|-------------|---------|
| runtime | Nombre de tiempo de ejecución. | Sí | No disponible | 
| nombre | Nombre de una aplicación. | Sí | No disponible | 
| output | Nombre del archivo de salida. | No | No aplicable | 
| outputproperty | Nombre de la propiedad Ant para la salida. | No | No aplicable | 

**Ejemplo**  

```xml
<show-app runtime="mfp" name="MyApp"/>
```

Este mandato se basa en el servicio REST [Application (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_get.html?view=kc#Application--GET-).

<br/>
#### Mandato `delete-app`
{: #the-delete-app-command }
El mandato `delete-app` elimina (retira el despliegue) una aplicación, con todas sus versiones de aplicación, de todos los entornos en los que fue desplegada, de un tiempo de ejecución. Tiene los siguientes atributos.

| Atributo      | Descripción |	Obligatorio | Predeterminado |
|----------------|-------------|-------------|---------|
| runtime | Nombre de tiempo de ejecución. | Sí | No disponible | 
| nombre | Nombre de una aplicación. | Sí | No disponible | 

**Ejemplo**  

```xml
<delete-app runtime="mfp" name="MyApp"/>
```

Este mandato se basa en el servicio REST [Application Version (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_version_delete.html?view=kc#Application-Version--DELETE-).

<br/>
#### Mandato `show-app-version`
{: #the-show-app-version-command }
El mandato `show-app-version` muestra detalles sobre una versión de aplicación en un tiempo de ejecución. Tiene los siguientes atributos.

| Atributo      | Descripción |	Obligatorio | Predeterminado |
|----------------|-------------|-------------|---------|
| runtime	| Nombre de tiempo de ejecución. | Sí | No disponible | 
| name | Nombre de la aplicación. | Sí | No disponible | 
| environment	| Plataforma móvil. | Sí | No disponible | 
| version	| Número de versión de la aplicación. | Sí | No disponible | 

**Ejemplo**  

```xml
<show-app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1"/>
```

Este mandato se basa en el servicio REST [Application Version (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_version_get.html?view=kc#Application-Version--GET-).

<br/>
#### Mandato `delete-app-version`
{: #the-delete-app-version-command }
El mandato `delete-app-version` elimina (retira el despliegue) una aplicación de un tiempo de ejecución. Tiene los siguientes atributos.

| Atributo      | Descripción |	Obligatorio | Predeterminado |
|----------------|-------------|-------------|---------|
| runtime	| Nombre de tiempo de ejecución. | Sí | No disponible | 
| name | Nombre de la aplicación. | Sí | No disponible | 
| environment	| Plataforma móvil. | Sí | No disponible | 
| version	| Número de versión de la aplicación. | Sí | No disponible | 

**Ejemplo**  

```xml
<delete-app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1"/>
```

Este mandato se basa en el servicio REST [Application Version (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_version_delete.html?view=kc#Application-Version--DELETE-).

<br/>
#### Grupo de mandatos `app`
{: #the-app-command-group }
El grupo de mandatos `app` tiene los siguientes atributos.

| Atributo      | Descripción |	Obligatorio | Predeterminado |
|----------------|-------------|-------------|---------|
| runtime	| Nombre de tiempo de ejecución. | Sí | No disponible | 
| name | Nombre de la aplicación. | Sí | No disponible | 

El grupo de mandatos app da soporte a los siguientes elementos.

| Elemento | Descripción | Número | 
|---------|-------------|-------|
| show-license-config | Muestra la configuración de licencia de señal. | 0.. | 
| set-license-config | Especifica la configuración de licencia de señal. | 0.. | 
| delete-license-config | Elimina la configuración de licencia de señal. | 0.. | 

<br/>
#### Mandato `show-license-config`
{: #the-show-license-config-command }
El mandato `show-license-config` muestra la configuración de licencia de señal de una aplicación. Tiene los siguientes atributos.

| Atributo      | Descripción |	Obligatorio | Predeterminado |
|----------------|-------------|-------------|---------|
| output         |	Nombre de un archivo en el que almacenar la salida. | Sí | No disponible |
| outputproperty | 	Nombre de un propiedad Ant en la que almacenar la salida. | Sí	| No disponible |

**Ejemplo**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <show-license-config output="/tmp/MyApp-license.xml"/>
</app-version>
```

Este mandato se basa en el servicio REST [Application (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_license_configuration_get.html?view=kc).

<br/>
#### Mandato `set-license-config`
{: #the-set-license-config-command }
El mandato `set-license-config` especifica la configuración de licencia de señal de una aplicación. Tiene los siguientes atributos.

| Atributo      | Descripción |	Obligatorio | Predeterminado |
|----------------|-------------|-------------|---------|
| appType | Tipo de aplicación: B2C o B2E | Sí | No disponible | 
| licenseType | Tipo de aplicación: APPLICATION o ADDITIONAL_BRAND_DEPLOYMENT o NON_PRODUCTION. | Sí | No disponible | 

**Ejemplo**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <set-license-config appType="B2E" licenseType="APPLICATION"/>
</app-version>
```

Este mandato se basa en el servicio REST [Application License Configuration (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_license_configuration__post.html?view=kc)

<br/>
#### Mandato `delete-license-config`
{: #the-delete-license-config-command }
El mandato `delete-license-config` restablece la configuración de licencia de señal de una aplicación, esto es, la devuelve a su estado inicial.

**Ejemplo**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <delete-license-config/>
</app-version>
```

Este mandato se basa en el servicio REST [License configuration (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_license_configuration_delete.html?view=kc#License-configuration--DELETE-).

<br/>
#### Grupo de mandatos `app-version`
{: #the-app-version-command-group }
El grupo de mandatos `app-version` tiene los siguientes atributos.

| Atributo      | Descripción |	Obligatorio | Predeterminado |
|----------------|-------------|-------------|---------|
| runtime | Nombre de tiempo de ejecución. | Sí | No disponible | 
| nombre | Nombre de una aplicación. | Sí | No disponible | 
| environment | Plataforma móvil. | Sí | No disponible | 
| version | Versión de la aplicación. | Sí | No disponible | 

El mandato `app-version` da soporte a los siguientes elementos:

| Elemento | Descripción | Número | 
|---------|-------------|-------|
| get-descriptor | Obtiene el descriptor. | 0.. | 
| get-web-resources | Obtiene los recursos web. | 0.. | 
| set-web-resources | Especifica los recursos web. | 0.. | 
| get-authenticity-data | Obtiene los datos de autenticidad. | 0.. | 
| set-authenticity-data | Especifica los datos de autenticidad. | 0.. | 
| delete-authenticity-data | Suprime los datos de autenticidad. | 0.. | 
| show-user-config | Muestra la configuración de usuario. | 0.. | 
| set-user-config | Especifica la configuración de usuario. | 0.. | 

<br/>
#### Mandato `get-descriptor`
{: #the-get-descriptor-command }
El mandato `get-descriptor`, dentro de un elemento `<app-version>`, devuelve el descriptor de aplicación de la versión de una aplicación. Tiene los siguientes atributos.

| Atributo      | Descripción |	Obligatorio | Predeterminado |
|----------------|-------------|-------------|---------|
| output | Nombre de un archivo en el que almacenar la salida. | No | No aplicable | 
| outputproperty | Nombre de un propiedad Ant en la que almacenar la salida. | No | No aplicable | 

**Ejemplo**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <get-descriptor output="/tmp/MyApp-application-descriptor.json"/>
</app-version>
```

Este mandato se basa en el servicio [Application Descriptor (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_descriptor_get.html?view=kc#Application-Descriptor--GET-).

<br/>
#### Mandato `get-web-resources`
{: #the-get-web-resources-command }
El mandato `get-web-resources`, dentro de un elemento `<app-version>`, devuelve los recursos web de una versión de una aplicación, como un archivo .zip. Tiene los siguientes atributos.

| Atributo      | Descripción |	Obligatorio | Predeterminado |
|----------------|-------------|-------------|---------|
| tofile | 	Nombre del archivo de salida. | Sí |No disponible | 

**Ejemplo**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <get-web-resources tofile="/tmp/MyApp-web.zip"/>
</app-version>
```

Este mandato se basa en el servicio REST [Retrieve Web Resource (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_retrieve_web_resource_get.html?view=kc#Retrieve-Web-Resource--GET-).

<br/>
#### Mandato `set-web-resources`
{: #the-set-web-resources-command }
El mandato `set-web-resources`, dentro de un elemento `<app-version>`, especifica los recursos web de una versión de una aplicación. Tiene los siguientes atributos.

| Atributo      | Descripción |	Obligatorio | Predeterminado |
|----------------|-------------|-------------|---------|
| file | Nombre del archivo de entrada (debe ser un archivo .zip). | Sí |No disponible |

**Ejemplo**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <set-web-resources file="/tmp/MyApp-web.zip"/>
</app-version>
```

Este mandato se basa en el servicio REST [Deploy a web resource (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_deploy_a_web_resource_post.html?view=kc#Deploy-a-web-resource--POST-).

<br/>
#### Mandato `get-authenticity-data`
{: #the-get-authenticity-data-command }
El mandato `get-authenticity-data`, dentro de un elemento `<app-version>`, devuelve los datos de autenticidad de una versión de una aplicación. Tiene los siguientes atributos.

| Atributo      | Descripción |	Obligatorio | Predeterminado |
|----------------|-------------|-------------|---------|
| output | 	Nombre de un archivo en el que almacenar la salida. | No | No aplicable | 
| outputproperty | Nombre de un propiedad Ant en la que almacenar la salida. | No | No aplicable | 

**Ejemplo**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <get-authenticity-data output="/tmp/MyApp.authenticity_data"/>
</app-version>
```

Este mandato se basa en el servicio REST [Export runtime resources (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_export_runtime_resources_get.html?view=kc).

<br/>
#### Mandato `set-authenticity-data`
{: #the-set-authenticity-data-command }
El mandato `set-authenticity-data`, dentro de un elemento `<app-version>`, especifica los datos de autenticidad de una versión de una aplicación. Tiene los siguientes atributos.

| Atributo      | Descripción |	Obligatorio | Predeterminado |
|----------------|-------------|-------------|---------|
| file | Nombre del archivo de entrada:<ul><li>Un archivo de datos de autenticidad,</li><li>Un archivo de dispositivo (archivo .ipa, .apk o .appx), a partir del que se extraen los datos de autenticidad.</li></ul> |  Sí | No disponible | 

**Ejemplos**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <set-authenticity-data file="/tmp/MyApp.authenticity_data"/>
</app-version>
```

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <set-authenticity-data file="MyApp.ipa"/>
</app-version>
```

```xml
<app-version runtime="mfp" name="MyApp" environment="android" version="1.1">
  <set-authenticity-data file="MyApp.apk"/>
</app-version>
```

Este mandato se basa en el servicio REST [Deploy Application Authenticity Data (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_deploy_application_authenticity_data_post.html?view=kc).

<br/>
#### Mandato `delete-authenticity-data`
{: #the-delete-authenticity-data-command }
El mandato `delete-authenticity-data`, dentro de un elemento `<app-version>`, suprime los datos de autenticidad de una versión de una aplicación. No tiene atributos.

**Ejemplo**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <delete-authenticity-data/>
</app-version>
```

Este mandato se basa en el servicio REST [Application Authenticity (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_authenticity_delete.html?view=kc).

<br/>
#### Mandato `show-user-config`
{: #the-show-user-config-command-2 }
El mandato `show-user-config`, dentro de un elemento `<app-version>`, muestra la configuración de usuario de una versión de una aplicación. Tiene los siguientes atributos.

| Atributo      | Descripción |	Obligatorio | Predeterminado |
|----------------|-------------|-------------|---------|
| format | Especifica el formato de salida. json o xml. | Sí | No disponible | 
| output | Nombre del archivo de salida.	| No | No aplicable | 
| outputproperty | Nombre de la propiedad Ant para la salida. | No | No aplicable | 

**Ejemplos**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <show-user-config format="json" output="/tmp/MyApp-config.json"/>
</app-version>
```

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <show-user-config format="xml" output="/tmp/MyApp-config.xml"/>
</app-version>
```

Este mandato se basa en el servicio REST [Application Configuration (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_configuration_get.html?view=kc#Application-Configuration--GET-).

<br/>
#### Mandato `set-user-config`
{: #the-set-user-config-command-2 }
El mandato `set-user-config`, dentro de un elemento `<app-version>`, especifica la configuración de usuario para una versión de una aplicación. Tiene los siguientes atributos para configurar toda la configuración.

| Atributo      | Descripción |	Obligatorio | Predeterminado |
|----------------|-------------|-------------|---------|
| file | Nombre del archivo XML o JSON que contiene la nueva configuración. | Sí | No disponible | 

El mandato `set-user-config` tiene los atributos siguientes para establecer una propiedad individual en la configuración.

| Atributo      | Descripción |	Obligatorio | Predeterminado |
|----------------|-------------|-------------|---------|
| property | Nombre de la propiedad JSON. Para una propiedad anidada, utilice la sintaxis prop1.prop2.....propN. Para un elemento de matriz JSON, utilice el índice en lugar de un nombre de propiedad. | Sí | No disponible | 
| value	| Valor de la propiedad. | Sí | No disponible | 

**Ejemplos**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <set-user-config file="/tmp/MyApp-config.json"/>
</app-version>
```

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <set-user-config property="timeout" value="240"/>
</app-version>
```

### Mandatos para dispositivos
{: #commands-for-devices }
Cuando llama a una tarea Ant de **mfpadm**, puede incluir varios mandatos para los dispositivos.

#### Mandato `list-devices`
{: #the-list-devices-command }
El mandato `list-devices` devuelve una lista de dispositivos que se han puesto en contacto con las aplicaciones de un tiempo de ejecución. Tiene los siguientes atributos:

| Atributo      | Descripción |	Obligatorio | Predeterminado |
|----------------|-------------|-------------|---------|
| runtime | Nombre de tiempo de ejecución. | Sí | No disponible | 
| query	 | Nombre descriptivo o identificador de usuario que buscar. Este parámetro especifica una serie que buscar. Todos los dispositivos que tienen un nombre descriptivo o identificador de usuario que lo contiene. | Se devuelve una serie (con coincidencia insensible a las mayúsculas y minúsculas). | No | No aplicable | 
| output | 	Nombre del archivo de salida. | No | No aplicable | 
| outputproperty | 	Nombre de la propiedad Ant para la salida. | No | No aplicable | 

**Ejemplos**  

```xml
<list-devices runtime="mfp"/>
```

```xml
<list-devices runtime="mfp" query="john"/>
```

Este mandato se basa en el servicio REST [Devices (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_devices_get.html?view=kc#Devices--GET-).

<br/>
#### Mandato `remove-device`
{: #the-remove-device-command }
El mandato `remove-device` borra el registro sobre un dispositivo que contactó las aplicaciones de un tiempo de ejecución. Tiene los siguientes atributos:

| Atributo      | Descripción |	Obligatorio | Predeterminado |
|----------------|-------------|-------------|---------|
| runtime | Nombre de tiempo de ejecución. | Sí | No disponible | 
| id | Identificador de dispositivo exclusivo. | Sí | No disponible | 

**Ejemplo**  

```xml
<remove-device runtime="mfp" id="496E974CCEDE86791CF9A8EF2E5145B6"/>
```

Este mandato se basa en el servicio REST [Device (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_device_delete.html?view=kc#Device--DELETE-).

<br/>
#### Grupo de mandatos `device`
{: #the-device-command-group }
El grupo de mandatos `device` tiene los siguientes atributos.

| Atributo      | Descripción |	Obligatorio | Predeterminado |
|----------------|-------------|-------------|---------|
| runtime | Nombre de tiempo de ejecución. | Sí | No disponible | 
| id | Identificador de dispositivo exclusivo. | Sí | No disponible | 

El mandato `device` da soporte a los siguientes elementos.

| Elemento        | Descripción |       Número |
|----------------|-------------|-------------|
| set-status | Cambio de estado. | 0..∞ | 
| set-appstatus | Cambio de estado para una aplicación. | 0..∞ | 

<br/>
#### Mandato `set-status`
{: #the-set-status-command }
El mandato `set-status` cambia el estado de un dispositivo, en el ámbito de un tiempo de ejecución. Tiene los siguientes atributos:

| Atributo      | Descripción |	Obligatorio | Predeterminado |
|----------------|-------------|-------------|---------|
| status | Nuevo estado. | Sí | No disponible | 

El estado puede tener uno de los siguientes valores:

* ACTIVE
* LOST
* STOLEN
* EXPIRED
* DISABLED

**Ejemplo**  

```xml
<device runtime="mfp" id="496E974CCEDE86791CF9A8EF2E5145B6">
  <set-status status="EXPIRED"/>
</device>
```

Este mandato se basa en el servicio REST [Device Status (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_device_status_put.html?view=kc#Device-Status--PUT-).

<br/>
#### Mandato `set-appstatus`
{: #the-set-appstatus-command }
El mandato `set-appstatus` cambia el estado de un dispositivo, en relación a una aplicación en un tiempo de ejecución. Tiene los siguientes atributos:

| Atributo      | Descripción |	Obligatorio | Predeterminado |
|----------------|-------------|-------------|---------|
| app	| Nombre de una aplicación. | Sí | No disponible | 
| status | 	Nuevo estado. | Sí | No disponible | 

El estado puede tener uno de los siguientes valores:

* ENABLED
* DISABLED

**Ejemplo**  

```xml
<device runtime="mfp" id="496E974CCEDE86791CF9A8EF2E5145B6">
  <set-appstatus app="MyApp" status="DISABLED"/>
</device>
```

Este mandato se basa en el servicio REST [Device Application Status (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_device_application_status_put.html?view=kc#Device-Application-Status--PUT-).

### Mandatos para la resolución de problemas
{: #commands-for-troubleshooting }
Los mandatos de tareas de Ant también sirven para investigar problemas con las aplicaciones web de {{ site.data.keys.mf_server }}.

#### Mandato `show-info`
{: #the-show-info-command }
El mandato `show-info` muestra información básica sobre los servicios de administración de {{ site.data.keys.product_adj }} que se pueden devolver sin acceder a un tiempo de ejecución ni a una base de datos. Utilice esta mandato para verificar si los servicios de administración de {{ site.data.keys.product_adj }} están en ejecución. Tiene los siguientes atributos:

| Atributo      | Descripción |	Obligatorio | Predeterminado |
|----------------|-------------|-------------|---------|
| output | 	Nombre del archivo de salida. | No | No aplicable | 
| outputproperty | 	Nombre de la propiedad Ant para la salida. | No | No aplicable | 

**Ejemplo**  

```xml
<show-info/>
```

<br/>
#### Mandato `show-versions`
{: #the-show-versions-command }
El mandato `show-versions` visualiza versiones de {{ site.data.keys.product_adj }} de varios componentes:

* **mfpadmVersion**: Número de versión de {{ site.data.keys.mf_server }} exacto que se toma del archivo *mfp-ant-deployer.jar*.
* **productVersion**: Número de versión de {{ site.data.keys.mf_server }} exacto que se toma del archivo **mfp-admin-service.war**.
* **mfpAdminVersion**: Número de versión de construcción exacto de sólo **mfp-admin-service.war**.

El mandato tiene los siguientes atributos:

| Atributo      | Descripción |	Obligatorio | Predeterminado |
|----------------|-------------|-------------|---------|
| output | 	Nombre del archivo de salida. | No | No aplicable | 
| outputproperty | 	Nombre de la propiedad Ant para la salida. | No | No aplicable | 

**Ejemplo**  

```xml
<show-versions/>
```

<br/>
#### Mandato `show-diagnostics`
{: #the-show-diagnostics-command }
El mandato `show-diagnostics` muestra el estado de varios componentes que son necesarios para el correcto funcionamiento del servicio de administración de {{ site.data.keys.product_adj }} como, por ejemplo, la disponibilidad de la base de datos y de los servicios auxiliares. Este mandato tiene los siguientes atributos.

| Atributo      | Descripción |	Obligatorio | Predeterminado |
|----------------|-------------|-------------|---------|
| output | 	Nombre del archivo de salida. | No | No aplicable | 
| outputproperty | 	Nombre de la propiedad Ant para la salida. | No | No aplicable | 

**Ejemplo**  

```xml
<show-diagnostics/>
```

<br/>
#### Mandato `unlock`
{: #the-unlock-command }
El mandato `unlock` libera el bloqueo de propósito general. Algunas operaciones destructivas toman este bloqueo con el propósito de impedir una modificación de forma simultánea de los mismos datos de configuración. En casos poco habituales, si se interrumpe una operación de este tipo, el bloqueo permanece en estado bloqueado, haciendo imposibles otras operaciones destructivas. Utilice el mandato unlock para liberar el bloqueo en estos casos. Este mandato no tiene atributos.

**Ejemplo**  

```xml
<unlock/>
```

<br/>
#### Mandato `list-runtimes`
{: #the-list-runtimes-command }
El mandato `list-runtimes` devuelve una lista de tiempos de ejecución desplegados. Tiene los siguientes atributos:

| Atributo      | Descripción |	Obligatorio | Predeterminado |
|----------------|-------------|-------------|---------|
| runtime | Nombre de tiempo de ejecución. | Sí | No disponible | 
| output | Nombre del archivo de salida. | No | No aplicable | 
| outputproperty | Nombre de la propiedad Ant para la salida. | No | No aplicable | 

**Ejemplos**  

```xml
<list-runtimes/>
```

```xml
<list-runtimes inDatabase="true"/>
```

Este mandato se basa en el servicio REST [Runtimes (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_runtimes_get.html?view=kc#Runtimes--GET-).

<br/>
#### Mandato `show-runtime`
{: #the-show-runtime-command }
El mandato `show-runtime` muestra información sobre un tiempo de ejecución desplegado dado. Tiene los siguientes atributos:

| Atributo      | Descripción |	Obligatorio | Predeterminado |
|----------------|-------------|-------------|---------|
| runtime | Nombre de tiempo de ejecución. | Sí | No disponible | 
| output | Nombre del archivo de salida. | No | No aplicable | 
| outputproperty | Nombre de la propiedad Ant para la salida. | No | No aplicable | 

**Ejemplo**

```xml
<show-runtime runtime="mfp"/>
```

Este mandato se basa en el servicio REST [Runtime (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_runtime_get.html?view=kc#Runtime--GET-).

<br/>
#### Mandato `delete-runtime`
{: #the-delete-runtime-command }
El mandato `delete-runtime` suprime el tiempo de ejecución, incluidas sus aplicaciones y adaptadores, de la base de datos. Únicamente puede suprimir un tiempo de ejecución cuando se hayan detenido sus aplicaciones web. El mandato tiene los siguientes atributos.

| Atributo      | Descripción |	Obligatorio | Predeterminado |
|----------------|-------------|-------------|---------|
| runtime |  Nombre de tiempo de ejecución. | Sí | No disponible |
| condition | Condición cuando lo suprime: empty o always. **Atención:** La opción always es peligrosa. | No | No aplicable |

**Ejemplo**

```xml
<delete-runtime runtime="mfp" condition="empty"/>
```

Este mandato se basa en el servicio REST [Runtime (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_runtime_delete.html?view=kc#Runtime--DELETE-).

<br/>
#### Mandato `list-farm-members`
{: #the-list-farm-members-command }
El mandato `list-farm-members` muestra una lista de servidores de miembro de granja en los que se ha desplegado un tiempo de ejecución dado. Tiene los siguientes atributos:

| Atributo      | Descripción |	Obligatorio | Predeterminado |
|----------------|-------------|-------------|---------|
| runtime | Nombre de tiempo de ejecución. | Sí | No disponible | 
| output | Nombre del archivo de salida. | No | No aplicable | 
| outputproperty | Nombre de la propiedad Ant para la salida. | No | No aplicable | 

**Ejemplo**

```xml
<list-farm-members runtime="mfp"/>
```

Este mandato se basa en el servicio REST [Farm topology members (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_farm_topology_members_get.html?view=kc#Farm-topology-members--GET-).

<br/>
#### Mandato `remove-farm-member`
{: #the-remove-farm-member-command }
El mandato `remove-farm-member` elimina un servidor de la lista de miembros de granja en los que se ha desplegado un tiempo de ejecución dado. Utilice este mandato cuando el servidor no esté disponible o se haya desconectado. El mandato tiene los siguientes atributos.

| Atributo      | Descripción |	Obligatorio | Predeterminado |
|----------------|-------------|-------------|---------|
| runtime | Nombre de tiempo de ejecución. | Sí | No disponible | 
| serverId | Identificador del servidor.	 | Sí | No aplicable | 
| force | Forzar la eliminación de un miembro de granja, incluso cuando no está disponible o está desconectado. | No | falso | 

**Ejemplo**

```xml
<remove-farm-member runtime="mfp" serverId="srvlx15"/>
```

Este mandato se basa en el servicio REST [Farm topology members (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_farm_topology_members_delete.html?view=kc).
