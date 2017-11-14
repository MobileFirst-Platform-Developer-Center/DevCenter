---
layout: tutorial
title: Guía de aprendizaje para la instalación de MobileFirst Server desde línea de mandatos
weight: 0
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
Utilice la modalidad de línea de mandatos de IBM Installation Manager y las tareas Ant para instalar {{ site.data.keys.mf_server }}.

#### Antes de empezar
{: #before-you-begin }
* Asegúrese de que están instaladas una de las siguientes bases de datos y versión de Java soportada. También necesita que el controlador JDBC correspondiente para la base de datos esté disponible en su sistema:
    * Sistema de gestión de bases de datos (DBMS) de la lista de bases de datos soportadas:
        * DB2 
        * MySQL
        * Oracle

        > **Importante:** Debe tener una base de datos donde pueda crear las tablas necesarias para el producto y un usuario de base de datos que pueda crear tablas en esa base de datos.


        En la guía de aprendizaje, los pasos para crear las tablas son para DB2. Puede encontrar el instalador de DB2 como paquete de {{ site.data.keys.product }} eAssembly en IBM Passport Advantage.

* Controlador JDBC para su base de datos.
    * Para DB2, utilice el tipo de controlador JDBC de DB2 4.
    * Para MySQL, utilice el controlador JDBC de Connector/J.
    * Para Oracle, utilice el controlador JDBC ligero de Oracle.
* Java 7 o posterior.

* Descargue el instalador de IBM Installation Manager V1.8.4 o posterior de [Enlaces de descarga de Installation Manager y Packaging Utility](http://www.ibm.com/support/docview.wss?uid=swg27025142).
* También debe tener el repositorio de instalación de {{ site.data.keys.mf_server }} y el instalador de WebSphere Application Server Liberty Core V8.5.5.3 o posterior. Descargue estos paquetes desde {{ site.data.keys.product }} eAssembly en Passport Advantage:

**Repositorio de instalación de {{ site.data.keys.mf_server }}**  
Archivo .zip de {{ site.data.keys.product }} V8.0 del repositorio de Installation Manager para {{ site.data.keys.mf_server }}

**Perfil de Liberty de WebSphere Application Server**  
IBM WebSphere Application Server: Liberty Core V8.5.5.3 o posterior
    
#### Ir a
{: #jump-to }
* [Instalación de IBM Installation Manager](#installing-ibm-installation-manager)
* [Instalación de WebSphere Application Server Liberty Core](#installing-websphere-application-server-liberty-core)
* [Instalación de {{ site.data.keys.mf_server }}](#installing-mobilefirst-server)
* [Creación de una base de datos](#creating-a-database)
* [Despliegue de {{ site.data.keys.mf_server }} en Liberty con tareas Ant](#deploying-mobilefirst-server-to-liberty-with-ant-tasks)
* [Probar la instalación](#testing-the-installation)
* [Creación de una granja de servidores de dos servidores Liberty que ejecutan {{ site.data.keys.mf_server }}](#creating-a-farm-of-two-liberty-servers-that-run-mobilefirst-server)
* [Realización de pruebas en la granja de servidores y ver los cambios en {{ site.data.keys.mf_console }}](#testing-the-farm-and-see-the-changes-in-mobilefirst-operations-console)

## Instalación de IBM Installation Manager
{: #installing-ibm-installation-manager }
Debe instalar Installation Manager V1.8.4 o posterior. Las versiones anteriores de Installation Manager no están disponibles para instalar {{ site.data.keys.product }} V8.0 porque las operaciones posteriores a la instalación del producto requieren Java 7. Las versiones anteriores de Installation Manager se suministran con Java 6.


1. Extraiga el archivo de archivado de IBM Installation Manager descargado. Puede encontrar el instalador en [Enlaces de descarga de Installation Manager y Packaging Utility](http://www.ibm.com/support/docview.wss?uid=swg27025142).
2. Revise el acuerdo de licencia de IBM Installation Manager que se encuentra en el directorio **unzip\_IM\_1.8.x/license**.
3. Si acepta el acuerdo de licencia tras la revisión, instale Installation Manager.  
    * Ejecute **installc.exe** para instalar Installation Manager como administrador. Se necesita el usuario root en Linux o UNIX. En Windows, se necesita el privilegio de administrador. En esta modalidad, la información sobre los paquetes instalados se coloca en una ubicación compartida en el disco y cualquier usuario con permisos para ejecutar Installation Manager puede actualizar las aplicaciones. El nombre del archivo ejecutable acaba con "c" (**installc**) para una instalación en línea de mandatos sin una interfaz gráfica de usuario. Para instalar Installation Manager, introduzca **installc.exe -acceptLicence**.
    * Ejecute **userinstc.exe** para instalar Installation Manager en modalidad de usuario. No es necesario ningún privilegio específico. Sin embargo, en esta modalidad, la información sobre los paquetes instalados se coloca en el directorio de inicio del usuario. Solo dicho usuario puede actualizar las aplicaciones instaladas con Installation Manager. El ejecutable acaba con "c" (**userinstc**) para una instalación en línea de mandatos sin una interfaz gráfica de usuario. Para instalar Installation Manager, introduzca **userinstc.exe -acceptLicence**.
    
## Instalación de WebSphere Application Server Liberty Core
{: #installing-websphere-application-server-liberty-core }
El instalador de WebSphere Application Server Liberty Core se proporciona como parte del paquete de {{ site.data.keys.product }}. En esta tarea, se instala el perfil de Liberty y se crea una instancia de servidor para que pueda instalar {{ site.data.keys.mf_server }}.

1. Revise el acuerdo de licencia para WebSphere Application Server Liberty Core. Los archivos de licencia se pueden ver al descargar el instalador desde Passport Advantage.
2. Extraiga el archivo comprimido de WebSphere Application Server Liberty Core, que ha descargado, en una carpeta.

    En los pasos que se indican a continuación, se hace referencia al directorio donde extrae el instalador como **liberty\_repository\_dir**. Contiene un archivo **repository.config** o **diskTag.inf** junto con muchos otros archivos.

3. Decida un directorio donde instalar el perfil de Liberty. En los pasos siguientes referido como liberty_install_dir. 
4. Inicie una línea de mandatos y vaya a **installation\_manager\_install\_dir/tools/eclipse/**.
5. Si acepta el acuerdo de licencia tras la revisión, instale Liberty.
    
    Introduzca el mandato: **imcl install com.ibm.websphere.liberty.v85 -repositories liberty\_repository\_dir -installationDirectory liberty\_install\_dir -acceptLicense**

    Este mandato instala Liberty en el directorio **liberty\_install\_dir**. La opción **-acceptLicense** significa que acepta los términos de la licencia del producto.

6. Mueva el directorio que contiene los servidores a una ubicación que no necesite privilegios específicos.

    Para el ámbito de esta guía de aprendizaje, si **liberty\_install\_dir** apunta a una ubicación donde los usuarios no administradores y no root no pueden modificar archivos, mueva el directorio que contenga los servidores a una ubicación que no necesite privilegios específicos. De este modo, las operaciones de instalación se pueden llevar a cabo sin privilegios específicos.
    * Vaya al directorio de instalación de Liberty.
    * Cree un directorio llamado etc. Necesita privilegios raíz o de administrador.
    * En el directorio **etc**, cree un archivo **server.env** con el siguiente contenido: `WLP_USER_DIR=<path to a directory where any user can write>`. Por ejemplo, en Windows: `WLP_USER_DIR=C:\LibertyServers\usr`.
7.  Cree un servidor Liberty que se utilizará para instalar el primer nodo de {{ site.data.keys.mf_server }} al final de la guía de aprendizaje.
    * Inicie una línea de mandatos.
    * Vaya a **liberty\_install\_dir/bin** e introduzca **server create mfp1**.
    
    Este mandato crea una instancia de servidor Liberty llamada **mfp1**. Puede ver su definición en **liberty\_install\_dir/usr/servers/mfp1** o **WLP\_USER\_DIR/servers/mfp1** (si modifica el directorio como se describe en el paso 6).
    
Después de crear el servidor, puede iniciarlo con `server start mfp1` desde **liberty\_install\_dir/bin/**.  
Para detener el servidor, introduzca el mandato: `server stop mfp1` desde **liberty\_install\_dir/bin/**.

La página de inicio predeterminada se puede ver en [http://localhost:9080](http://localhost:9080).

> **Nota:** Para producción, debe asegurarse de que el servidor Liberty está iniciado como servicio cuando se inicia el sistema principal. Hacer que el servidor Liberty se inicie como servicio no es parte de esta guía de aprendizaje.


## Instalación de {{ site.data.keys.mf_server }}
{: #installing-mobilefirst-server }
Asegúrese de que Installation Manager V1.8.4 o posterior está instalado. Es posible que la instalación de {{ site.data.keys.mf_server }} no tenga éxito con una versión anterior de Installation Manager ya que las instalaciones posteriores requieren Java 7. Las versiones anteriores de Installation Manager se suministran con Java 6.

Ejecute Installation Manager para instalar los archivos binarios de {{ site.data.keys.mf_server }} en su disco antes de crear las bases de datos y desplegar {{ site.data.keys.mf_server }} en el perfil de Liberty. Durante la instalación de {{ site.data.keys.mf_server }} con Installation Manager, se le propone una opción para instalar {{ site.data.keys.mf_app_center }}. Application Center es un componente diferente del producto. Para esta guía de aprendizaje, no es necesario instalarlo con {{ site.data.keys.mf_server }}.

También debe especificar una propiedad para indicar si desea activar las licencias de señales o no. En esta guía de aprendizaje, se presupone que las licencias de señales no son necesarias y los pasos para configurar {{ site.data.keys.mf_server }} para las licencias de señales no se incluyen. Sin embargo, para la instalación de producción, debe determinar si es necesario activar las licencias de señales o no. Si no tiene un contrato para utilizar las licencias de señales con Rational License Key Server, no es necesario que active las licencias de señales. Si activa las licencias de señales, debe configurar {{ site.data.keys.mf_server }} para las licencias de señales.  

En esta guía de aprendizaje, especifique las propiedades como los parámetros a través de la línea de mandatos **imcl**. Esta especificación también puede realizarse mediante un archivo de respuestas.

1. Revise el acuerdo de licencia para {{ site.data.keys.mf_server }}. Los archivos de licencia se pueden ver al descargar el repositorio de instalación desde Passport Advantage.
2. Extraiga el archivo comprimido del instalador de {{ site.data.keys.mf_server }}, que ha descargado, a una carpeta.

    En los pasos que se indican a continuación, se hace referencia al directorio donde extrae el instalador como **mfp\_repository\_dir**. Contiene una carpeta **MobileFirst\_Platform\_Server/disk1**.
3. Inicie una línea de mandatos y vaya a **installation\_manager\_install\_dir/tools/eclipse/**.
4. Si acepta el acuerdo de licencia tras la revisión en el paso 1, instale {{ site.data.keys.mf_server }}.

    Introduzca el mandato: `imcl install com.ibm.mobilefirst.foundation.server -repositories mfp_repository_dir/MobileFirst_Platform_Server/disk1 -properties user.appserver.selection2=none,user.database.selection2=none,user.database.preinstalled=false,user.licensed.by.tokens=false,user.use.ios.edition=false -acceptLicense`

    Las propiedades siguientes se definen para tener una instalación sin Application Center:
    * **user.appserver.selection2=none**
    * **user.database.selection2=none**
    * **user.database.preinstalled=false**

    Esta propiedad indica que las licencias de señales no se activan: **user.licensed.by.tokens=false**.  
    Establezca el valor de la propiedad **user.use.ios.edition** en false para instalar {{ site.data.keys.product }}.

Se ha instalado un directorio de instalación que contiene los recursos para instalar componentes de {{ site.data.keys.product_adj }}.  
Puede encontrar los recursos en las siguientes carpetas:

* Carpeta **MobileFirstServer** para {{ site.data.keys.mf_server }}
* Carpeta **PushService** para el servicio de envío por push de {{ site.data.keys.mf_server }}
* Carpeta **ApplicationCenter** para Application Center
* Carpeta **Analytics** para {{ site.data.keys.mf_analytics }}

El objetivo de esta guía de aprendizaje es instalar {{ site.data.keys.mf_server }} utilizando los recursos de la carpeta **MobileFirstServer**.  
También puede encontrar algunos atajos para la Herramienta de configuración del servidor, Ant, y el programa **mfpadm** en la carpeta **shortcuts**.

## Creación de una base de datos
{: #creating-a-database }
Esta tarea es para asegurarse de que existe una base de datos en su DBMS, y que un usuario está autorizado a utilizar la base de datos, crear tablas en ella y utilizarlas. Puede omitir esta tarea si prevé utilizar bases de datos Derby.

La base de datos se utiliza para almacenar los datos técnicos utilizados por los diversos componentes {{ site.data.keys.product_adj }}:

* Servicio de administración de {{ site.data.keys.mf_server }}
* Servicio de Live Update de {{ site.data.keys.mf_server }}
* Servicio de envío por push de {{ site.data.keys.mf_server }}
* Tiempo de ejecución de {{ site.data.keys.product_adj }}

En esta guía de aprendizaje, las tablas de todos los componentes están colocadas en el mismo esquema.  
**Nota:** Los pasos de esta tarea son para DB2. Si tiene la intención de utilizar MySQL u Oracle, consulte [Requisitos de base de datos](../../databases/#database-requirements).

1. Inicie sesión en el sistema que está ejecutando el servidor DB2. Se presupone que existe un usuario de DB2, por ejemplo, **mfpuser**.
2. Verifique que este usuario de DB2 tiene acceso a una base de datos con un tamaño de página de 32768 o más, y tiene permiso para crear esquemas y tablas implícitas en la base de datos.

    De forma predeterminada, este usuario es un usuario declarado en el sistema operativo del sistema que ejecuta DB2. Es decir, un usuario con un inicio de sesión para ese sistema. Si dicho usuario existe, la acción del paso 3 no es necesaria.
3. Cree una base de datos con el tamaño de página correcto para esta instalación si no tiene una.
    * Abra una sesión con un usuario que tenga permisos **SYSADM** o **SYSCTRL**.Por ejemplo, utilice el usuario **db2inst1** que es el usuario administrativo predeterminado que crea el instalador de DB2.
    * Abra un procesador de línea de mandatos de DB2:
        * En sistemas Windows, pulse **Inicio → IBM DB2 → Procesador de línea de mandatos**.
        * En sistemas Linux o UNIX, vaya a **~/sqllib/bin** (o **db2\_install\_dir/bin** si sqllib no está creado en el directorio de inicio del administrador) y especifique `./db2`.
    * Especifique las siguientes sentencias SQL para crear una base de datos denominada **MFPDATA**:
    
        ```sql
        CREATE DATABASE MFPDATA COLLATE USING SYSTEM PAGESIZE 32768
        CONNECT TO MFPDATA
        GRANT CONNECT ON DATABASE TO USER mfpuser
        GRANT CREATETAB ON DATABASE TO USER mfpuser
        GRANT IMPLICIT_SCHEMA ON DATABASE TO USER mfpuser
        DISCONNECT MFPDATA
        QUIT
        ```

    Si ha definido un nombre de usuario diferente, sustituya **mfpuser** con su propio nombre de usuario.
    
    > **Nota:** La sentencia no elimina los privilegios predeterminados concedidos a PUBLIC en una base de datos predeterminada de DB2. Para producción, es posible que tenga que reducir los privilegios en esta base de datos a los requisitos mínimos para el producto. Para obtener más información sobre la seguridad DB2 y un ejemplo de las prácticas de seguridad, consulte [Seguridad DB2, Parte 8: Doce procedimientos recomendados de seguridad DB2](http://www.ibm.com/developerworks/data/library/techarticle/dm-0607wasserman/).



## Despliegue de {{ site.data.keys.mf_server }} en Liberty con tareas Ant
{: #deploying-mobilefirst-server-to-liberty-with-ant-tasks }
Utilice las tareas Ant para ejecutar las operaciones siguientes:

* Crear las tablas en la base de datos necesarias para las aplicaciones de {{ site.data.keys.product_adj }}. 
* Desplegar las aplicaciones web de {{ site.data.keys.mf_server }} (el tiempo de ejecución, el servicio de administración, el servicio Live Update y {{ site.data.keys.mf_console }}) en el servidor Liberty.

Las siguientes aplicaciones de {{ site.data.keys.product_adj }} no las despliegan las tareas Ant:

#### {{ site.data.keys.mf_analytics }}
{: #mobilefirst-analytics }
Normalmente, {{ site.data.keys.mf_analytics }} se despliega en una granja de servidores diferente que {{ site.data.keys.mf_server }} debido a su alta necesidad de memoria. {{ site.data.keys.mf_analytics }} se puede instalar manualmente o con tareas Ant. Si ya está instalado, puede introducir su URL, el nombre de usuario y la contraseña para enviarle datos en la Herramienta de configuración del servidor. A continuación, la Herramienta de configuración del servidor configura las aplicaciones de {{ site.data.keys.product_adj }} para enviar datos a {{ site.data.keys.mf_analytics }}. 

#### Application Center
{: #application-center }
Esta aplicación puede utilizarse para distribuir aplicaciones móvil internamente a los empleados que utilizan las aplicaciones o para pruebas. Es independiente de {{ site.data.keys.mf_server }} y no es necesario instalarla con {{ site.data.keys.mf_server }}. 

Seleccione el archivo XML adecuado que contiene las tareas Ant y configure las propiedades.

* Realice una copia del archivo **mfp\_install\_dir/MobileFirstServer/configuration-samples/configure-liberty-db2.xml** en un directorio de trabajo. Este archivo contiene las tareas Ant para instalar {{ site.data.keys.mf_server }} en Liberty con DB2 como base de datos. Antes de utilizarlo, defina las propiedades para describir dónde se deben desplegar las aplicaciones de {{ site.data.keys.mf_server }}.
* Edite la copia del archivo XML y establezca los valores de las siguientes propiedades:
    * **mfp.admin.contextroot** en **/mfpadmin**
    * **mfp.runtime.contextroot** en **/mfp**
    * **database.db2.host** en el valor del nombre de host del sistema que ejecuta su base de datos DB2. Si la base de datos está en el mismo sistema que Liberty, utilice **localhost**.
    * **database.db2.port** en el puerto al que escucha la instancia de DB2. De forma predeterminada, es **50000**.
    * **database.db2.driver.dir** en el directorio que contiene su controlado de DB2: **db2jcc4.jar** y **db2jcc\_license\_cu.jar**. En una distribución DB2 estándar, estos archivos se encuentran en **db2\_install\_dir/java**.
    * **database.db2.mfp.dbname** en **MFPDATA**: El nombre de base de datos que creó en Creación de una base de datos.
    * **database.db2.mfp.schema** en **MFPDATA**: El valor del esquema donde se deben crear las tablas de {{ site.data.keys.mf_server }}. Si su usuario de base de datos no puede crear un esquema, establezca el valor en una cadena vacía. Por ejemplo, **database.db2.mfp.schema=""**.
    * **database.db2.mfp.username** en el usuario de DB2 que crea las tablas. Este usuario también utiliza las tablas en el tiempo de ejecución. Para esta guía de aprendizaje, utilice **mfpuser**.
    * **appserver.was.installdir** en el directorio de instalación de Liberty.
    * **appserver.was85liberty.serverInstance** en **mfp1**: El valor del nombre del servidor Liberty donde debe instalarse {{ site.data.keys.mf_server }}. 
    * **mfp.farm.configure** en **false** para instalar {{ site.data.keys.mf_server }} en modalidad autónoma. 
    * **mfp.analytics.configure** en **false**. La conexión con {{ site.data.keys.mf_analytics }} no está en el ámbito de esta guía de aprendizaje. Puede ignorar las otras propiedades mfp.analytics.****.
    * **mfp.admin.client.id** en **admin-client-id**.
    * **mfp.admin.client.secret** en **adminSecret** (o elija otra contraseña de secreto).
    * **mfp.push.client.id** en **push-client-id**.
    * **mfp.push.client.secret** en **pushSecret** (o elija otra contraseña de secreto).
    * **mfp.config.admin.user** en el nombre de usuario del servicio Live Update de {{ site.data.keys.mf_server }}. En una topología de granja de servidores, el nombre de usuario debe ser el mismo para todos los miembros de la granja de servidores.
    * **mfp.config.admin.password** en la contraseña del servicio Live Update de {{ site.data.keys.mf_server }}. En una topología de granja de servidores, la contraseña debe ser el mismo para todos los miembros de la granja de servidores.
* Mantenga los valores predeterminados de las siguientes propiedades como están:
    * **mfp.admin.console.install** en true
    * **mfp.admin.default.user** en **admin**: El nombre de un usuario predeterminado creado para iniciar sesión en {{ site.data.keys.mf_console }}.
    * **mfp.admin.default.user.initialpassword** en **admin**: La contraseña de un usuario predeterminado creado para iniciar sesión en la consola de administrador.
    * **appserver.was.profile** en **Liberty**. Si el valor es diferente, la tarea Ant da por hecho que la instalación se realiza en un servidor de WebSphere Application Server.
* Guarde el archivo después de definir las propiedades.
* Ejecute `mfp_server_install_dir/shortcuts/ant -f configure-liberty-db2.xml` para mostrar una lista de destinos posibles para el archivo Ant.
* Ejecute `mfp_server_install_dir/shortcuts/ant -f configure-liberty-db2.xml databases` para crear las tablas de base de datos.
* Ejecute `mfp_server_install_dir/shortcuts/ant -f configure-liberty-db2.xml install` para instalar {{ site.data.keys.mf_server }}.

> **Nota:** Si no tiene DB2 y desea probar la instalación con Derby incluido como base de datos, utilice el archivo **mfp\_install\_dir/MobileFirstServer/configuration-samples/configure-liberty-derby.xml**. Sin embargo, no puede realizar el último paso de esta guía de aprendizaje (Creación de una granja de servidores de dos servidores Liberty que ejecutan {{ site.data.keys.mf_server }}) porque varios servidores Liberty no pueden acceder a la base de datos Derby. Debe establecer las propiedades excepto aquellas relacionadas con DB2 (**database.db2**, ...). Para Derby, establezca el valor de la propiedad **database.derby.datadir** en el directorio donde se puede crear la base de datos Derby. Además, establezca el valor de la propiedad **database.derby.mfp.dbname** en **MFPDATA**.



Las tareas Ant ejecutan las siguientes operaciones:

1. Se crean las tablas para los siguientes componentes en la base de datos:
    * El servicio de administración y el servicio Live Update. Creado por el destino Ant `admdatabases`.
    * El componente de tiempo de ejecución. Creado por el destino Ant `rtmdatabases`.
    * El servicio de envío por push. Creado por el destino Ant `pushdatabases`.
2. Los archivos WAR de los varios componentes se despliegan en el servidor Liberty. Puede ver los detalles de las operaciones en el registro en los destinos `adminstall`, `rtminstall` y `pushinstall`.

Si tiene acceso al servidor DB2, puede listar las tablas creadas mediante estas instrucciones:

1. Abra un procesador de línea de mandato de DB2 con mfpuser como se describe en el paso 3 de Creación de una base de datos.
2. Especifique las sentencias SQL:

```sql
CONNECT TO MFPDATA USER mfpuser USING mfpuser_password
LIST TABLES FOR SCHEMA MFPDATA
DISCONNECT MFPDATA
QUIT
```

Anote los siguientes factores de base de datos:

#### Consideración de usuario de base de datos
{: #database-user-consideration }
En la Herramienta de configuración del servidor, solo es necesario un usuario de base de datos. Este usuario se utiliza para crear las tablas, pero también como el usuario de origen de datos en el servidor de aplicaciones en el tiempo de ejecución. En entorno de producción, es posible que desee restringir privilegios del usuario utilizado en el tiempo de ejecución al mínimo (`SELECT / INSERT / DELETE / UPDATE)` y, por lo tanto, proporcionar un usuario diferente para el despliegue en el servidor de aplicaciones. Los archivos Ant proporcionados como ejemplo también utilizan los mismos usuarios para ambos casos. Sin embargo, en el caso de DB2, es posible que desee crear sus propias versiones de los archivos. Como tal, puede distinguir entre el usuario utilizado para crear las bases de datos del usuario utilizado para el origen de datos en el servidor de aplicaciones con las tareas Ant.

#### Creación de tablas de bases de datos
{: #database-tables-creation }
Para producción, es posible que desee crear las tablas de forma manual. Por ejemplo, si su DBA desea sustituir algunos valores predeterminados o asignar espacios de tabla específicos. Los scripts de base de datos utilizados para crear las tablas están disponibles en **mfp\_server\_install\_dir/MobileFirstServer/databases** y **mfp\_server\_install\_dir/PushService/databases**. Para obtener más información, consulte [Creación de tablas de base de datos manualmente](../../databases/#create-the-database-tables-manually).

El archivo **server.xml** y algunos valores de servidor de aplicaciones se modifican durante la instalación. Antes de cada modificación, se realiza una copia del archivo **server.xml**, como **server.xml.bak**, **server.xml.bak1** y **server.xml.bak2**. Para ver todo lo que se ha añadido, puede comparar el archivo **server.xml** con la copia de seguridad más antigua (server.xml.bak). En Linux, puede utilizar en mandato diff `--strip-trailing-cr server.xml server.xml.bak` para ver las diferencias. En AIX, utilice el mandato `diff server.xml server.xml.bak` para encontrar las diferencias.

#### Modificación de los valores de servidor de aplicaciones (específico para Liberty):
{: #modification-of-the-application-server-settings-specific-to-liberty }
1. Se han añadido las características de Liberty.

    Las características se han añadido para cada aplicación y se pueden duplicar. Por ejemplo, la característica JDBC se utiliza para el servicio de administración y los componentes de tiempo de ejecución. Esta duplicación permite la eliminación de característica de una aplicación cuando se desinstala, sin dañar las otras aplicaciones. Por ejemplo, si decide en algún momento desinstalar el servicio de envío por push de un servidor e instalarlo en otro servidor. Sin embargo, no son posibles todas las topologías. El servicio de administración, el servicio de Live Update y el componente de tiempo de ejecución deben estar en el mismo servidor de aplicaciones con perfil de Liberty. Para obtener más información, consulte [Restricciones en el servicio de administración de {{ site.data.keys.mf_server }}, el servicio Live Update de {{ site.data.keys.mf_server }} y el tiempo de ejecución de {{ site.data.keys.product_adj }}](../../topologies/#constraints-on-mobilefirst-server-administration-service-mobilefirst-server-live-update-service-and-mobilefirst-foundation-runtime). La duplicación de características no crea problemas a menos que las características que añada entren en conflicto. Añadir las características jdbc-40 y jdbc-41 causará un problema, pero añadir dos veces la misma característica no.
    
2. Se añade `host='*'` en la declaración de `httpEndPoint`.

    Este valor es para permitir la conexión con el servidor desde todas las interfaces de red. En producción, es posible que desee restringir el valor de host del punto final HTTP.
3. Se añade el elemento **tcpOptions** (**tcpOptions soReuseAddr="true"**) en la configuración de servidor para permitir el volver a enlazar de forma inmediata con un puerto que no tenga escuchas activas y mejorar el rendimiento del servidor.
4. Se crea un almacén de claves con el ID **defaultKeyStore** si no existe.

    El almacén de claves sirve para habilitar el puerto HTTPS y más en concreto, para habilitar la comunicación JMX entre el servicio de administración (mfp-admin-service.war) y el componente de tiempo de ejecución (mfp-server.war). Las dos aplicaciones se comunican mediante JMX. En el caso del perfil de Liberty, se utiliza restConnector para comunicar entre las aplicaciones en un servidor único y también entre los servidores de una granja de servidores Liberty. Requiere el uso de HTTPS. Para el almacén de claves creado de forma predeterminada, los perfiles de Liberty crean un certificado con un periodo de validez de 365 días. Esta configuración no está pensada para el uso de producción. Para producción, debe considerar utilizar su propio certificado.    

    Para habilitar JMX, se crea un usuario con rol de administrador (llamado MfpRESTUser) en el registro básico. Su nombre y contraseña se proporcionan como propiedades JNDI (mfp.admin.jmx.user y mfp.admin.jmx.pwd) y los utiliza el componente de tiempo de ejecución y el servicio de administración para ejecutar consultas JMX. En las propiedades globales de JMX, algunas propiedades se utilizan para definir la modalidad de clúster (servidor autónomo o trabajar en una granja de servidores). La Herramienta de configuración del servidor establece la propiedad mfp.topology.clustermode en autónomo en el servidor Liberty. En la última parte de esta guía de aprendizaje sobre la creación de una granja de servidores, se modifica la propiedad a clúster.
5. La creación de usuarios (También válido para Apache Tomcat y WebSphere Application Server)
    * Usuarios opcionales: La Herramienta de configuración del servidor crea un usuario de prueba (admin/admin) para que pueda utilizarlo para iniciar sesión en la consola tras la instalación.
    * Usuarios obligatorios: La Herramienta de configuración del servidor también crea un usuario (llamado configUser_mfpadmin con una contraseña generada de forma aleatoria) para utilizarlo como el servicio de administración para contactar con el servicio local Live Update. Para el servidor Liberty, se crea MfpRESTUser. Si su servidor de aplicaciones no está configurado para utilizar un registro básico (por ejemplo, un registro LDAP), la Herramienta de configuración del servidor no puede solicitar el nombre de un usuario existente. En este caso, debe utilizar tareas Ant.
6. Se modifica el elemento **webContainer**.

    La propiedad personalizada del contenedor web `deferServletLoad` está establecida en false. Tanto el componente de tiempo de ejecución como el servicio de administración deben iniciarse cuando se inicia el servidor. Estos componentes, por lo tanto, pueden registrar los beans de JMX e iniciar el procedimiento de sincronización que permite al componente de tiempo de ejecución descargar todas las aplicaciones y adaptadores que debe servir.
7. El ejecutor predeterminado está personalizado para establecer valores grandes en `coreThreads` y `maxThreads` si utiliza Liberty V8.5.5.5 o anterior. Liberty ajusta de forma automática el ejecutor predeterminado a partir de V8.5.5.6.

    Este valor evita problemas de tiempo de espera que interrumpen la secuencia de inicio del componente de tiempo de ejecución y el servicio de administración en algunas versiones de Liberty. La ausencia de esta sentencia puede ser la causa de estos errores en el archivo de registro del servidor:
    
    > No se ha podido obtener la conexión JMX para acceder a un MBean. Es posible que ocurra un error de configuración JMX: Tiempo de espera de lectura excedido FWLSE3000E: Se ha detectado un error de servidor.
    > FWLSE3012E: Error de configuración JMX. No se han podido obtener MBeans. Motivo: "Tiempo de espera de lectura excedido".

#### Declaración de aplicaciones
{: #declaration-of-applications }
Las siguientes aplicaciones están instaladas:

* **mfpadmin**, el servicio de administración
* **mfpadminconfig**, el servicio Live Update
* **mfpconsole**, {{ site.data.keys.mf_console }}
* **mobilefirst**, componente de tiempo de ejecución de {{ site.data.keys.product_adj }}
* **imfpush**, el servicio de envío por push

La Herramienta de configuración del servidor instala todas las aplicaciones en el mismo servidor. Puede separar las aplicaciones en diferentes servidor de aplicaciones, pero con determinadas restricciones que se documentan en [Flujos de red y topologías](../../topologies).  
Para una instalación en diferentes servidores, no puede utilizar la Herramienta de configuración del servidor. Utilice tareas Ant o instale el producto de forma manual.

#### Servicio de administración
{: #administration-service }
El servicio de administración es el servicio para gestionar aplicaciones y adaptadores de {{ site.data.keys.product_adj }} y sus configuraciones. Está protegido por roles de seguridad. De forma predeterminada, la Herramienta de configuración del servidor añade un usuario (administrador) con el rol de administrador, que puede utilizar para iniciar sesión en la consola para la realización de pruebas. La configuración del rol de seguridad debe llevarse a cabo tras la instalación con la Herramienta de configuración del servidor (o con tareas Ant). Es posible que desee correlacionar los usuarios o los grupos que proceden del registro básico o el registro LDAP que configuró en su servidor de aplicaciones o cada rol de seguridad.

El cargador de clases se establece con el último padre de delegación para el perfil de Liberty y WebSphere Application Server, y para todas las aplicaciones de {{ site.data.keys.product_adj }}. Este valor es para evitar conflictos entre las clases empaquetadas en las aplicaciones de {{ site.data.keys.product_adj }} y las clases del servidor de aplicaciones. Olvidar establecer la delegación de cargador de clases en último padre es un origen de errores frecuente en la instalación manual. Para Apache Tomcat, esta declaración no es necesaria.

En el perfil de Liberty, se añade una biblioteca común a la aplicación para descifrar contraseñas pasadas como propiedades JNDI. La Herramienta de configuración del servidor define dos propiedades JNDI obligatorias para el servicio de administración: **mfp.config.service.user** y **mfp.config.service.password**. Las utiliza el servicio de administración para conectar el servicio Live Update con su API REST. Se pueden definir más propiedades JNDI para ajustar la aplicación o adaptarla a las particularidades de su instalación. Para obtener más información, consulte [Lista de propiedades JNDI para el servicio de administración de {{ site.data.keys.mf_server }}](../../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service).

La Herramienta de configuración del servidor también define las propiedades JNDI (el URL y los parámetros OAuth para registrar los clientes confidenciales) para la comunicación con el servicio de envío por push.  
El origen de datos para la base de datos que contiene las tablas del servicio de administración está declarado, también, como biblioteca para su controlador JDBC.

#### Servicio de Live Update
{: #live-update-service }
El servicio Live Update almacena información sobre las configuraciones de tiempo de ejecución y aplicación. Está controlado por el servicio de administración y siempre debe ejecutarse en el mismo servidor que el servicio de administración. La raíz de contexto es **context\_root\_of\_admin\_serverconfig**. Como tal, es **mfpadminconfig**. El servicio de administración da por hecho que se respeta esta convención para crear el URL de sus solicitudes en los servicios REST del servicio Live Update.

El cargador de clases se establece con el último padre de delegación como se explica en la sección del servicio de administración. 

El servicio Live Update tiene un rol de seguridad, **admin_config**. Se debe correlacionar un usuario a ese rol. Debe proporcionarse su contraseña e inicio de sesión al servicio de administración con la propiedad JNDI: **mfp.config.service.user** y **mfp.config.service.password**. Para obtener información sobre las propiedades JNDI, consulte [Lista de propiedades JNDI para el servicio de administración de {{ site.data.keys.mf_server }}](../../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service) y [Lista de propiedades JNDI para el servicio de Live Update de {{ site.data.keys.mf_server }}](../../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-live-update-service).

También necesita un origen de datos con nombre JNDI en el perfil de Liberty. La convención es **context\_root\_of\_config\_server/jdbc/ConfigDS**. En esta guía de aprendizaje, se define como **mfpadminconfig/jdbc/ConfigDS**. En una instalación realizada con la Herramienta de configuración del servidor o con tareas Ant, las tablas del servicio Live Update están en la misma base de datos y esquema que las tablas del servicio de administración. El usuario para acceder a estas tablas es también el mismo.

#### {{ site.data.keys.mf_console }}
{: #mobilefirst-operations-console }
{{ site.data.keys.mf_console }} está declarado con los mismos roles de seguridad que el servicio de administración. Los usuarios correlacionados con los roles de seguridad de {{ site.data.keys.mf_console }} también deben estar correlacionados con el mismo rol de seguridad del servicio de administración. De hecho, {{ site.data.keys.mf_console }} ejecuta consultas en el servicio de administración en nombre del usuario de consola.

La Herramienta de configuración del servidor posiciona una propiedad JNDI, **mfp.admin.endpoint**, que indica cómo se conecta la consola con el servicio de administración. El valor predeterminado establecido por la Herramienta de configuración del servidor es `*://*:*/mfpadmin`. El valor significa que debe utilizar el mismo protocolo, nombre de host y puerto que la solicitud HTTP entrante en la consola, y la raíz de contexto del servicio de administración es /mfpadmin. Si desea forzar la solicitud para que pase a través de un proxy de web, cambie el valor predeterminado. Para obtener más información sobre los valores posibles para este URL, o información sobre otras posibles propiedades JNDI, consulte [Lista de propiedades JNDI para el servicio de administración de {{ site.data.keys.mf_server }}](../../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service).

El cargador de clases se establece con el último padre de delegación como se explica en la sección del servicio de administración. 

#### Tiempo de ejecución de {{ site.data.keys.product_adj }}
{: #mobilefirst-runtime }
Esta aplicación no está protegida por un rol de seguridad. No es necesario iniciar sesión con un usuario conocido por el servidor Liberty para acceder a esta aplicación. Las solicitudes de dispositivos móvil se direccionan al tiempo de ejecución. Estas se autentican con otros mecanismos específicos del producto (como OAuth) y la configuración de las aplicaciones de {{ site.data.keys.product_adj }}.

El cargador de clases se establece con el último padre de delegación como se explica en la sección del servicio de administración. 

También necesita un origen de datos con nombre JNDI en el perfil de Liberty. La convención es **context\_root\_of\_runtime/jdbc/mfpDS**. En esta guía de aprendizaje, se define como **mobilefirst/jdbc/mfpDS**. En una instalación realizada con la Herramienta de configuración del servidor o con tareas Ant, las tablas del tiempo de ejecución están en la misma base de datos y esquema que las tablas del servicio de administración. El usuario para acceder a estas tablas es también el mismo.

#### Servicio de envío por push
{: #push-service }
Esta aplicación está protegida por OAuth. Las señales de OAuth válidas deben incluirse en cualquier solicitud HTTP al servicio.

La configuración de OAuth se realiza a través de las propiedades JNDI (como el URL del servidor de autorizaciones, el ID de cliente y la contraseña del servicio de envío por push). Las propiedades JNDI también indican el plugin de seguridad (**mfp.push.services.ext.security**) y el hecho de que se utiliza una base de datos relacional (**mfp.push.db.type**). Las solicitudes desde dispositivos móviles al servicio de envío por push se direccionan a este servicio. La raíz de contexto del servicio de envío por push debe ser /imfpush. El SDK de cliente calcula el URL del servicio de envío por push con base en el URL del tiempo de ejecución con la raíz de contexto (**/imfpush**). Si desea instalar el servicio de envío por push en un servidor diferente al del tiempo de ejecución, debe tener un direccionador HTTP que pueda direccionar las solicitudes de dispositivo al servidor de aplicaciones relevante.

El cargador de clases se establece con el último padre de delegación como se explica en la sección del servicio de administración. 

También necesita un origen de datos con nombre JNDI en el perfil de Liberty. El nombre JNDI es **imfpush/jdbc/imfPushDS**. En una instalación realizada con la Herramienta de configuración del servidor o con tareas Ant, las tablas del servicio de envío por push están en la misma base de datos y esquema que las tablas del servicio de administración. El usuario para acceder a estas tablas es también el mismo.

#### Modificación de otros archivos
{: #other-files-modification }
Se ha modificado el archivo **jvm.options** del perfil de Liberty. Se define una propiedad (**com.ibm.ws.jmx.connector.client.rest.readTimeout**) para evitar problemas de tiempo de espera con JMX cuando el tiempo de ejecución se sincroniza con el servicio de administración. 

### Probar la instalación
{: #testing-the-installation }
Una vez finalizada la instalación, puede utilizar este procedimiento para probar los componentes instalados.

1. Inicie el servidor utilizando el mandato **server start mfp1**. El archivo binario para el servidor está en **liberty\_install\_dir/bin**.
2. Pruebe {{ site.data.keys.mf_console }} con un navegador web. Vaya a [http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole). De forma predeterminada, el servidor se ejecuta en el puerto 9080. Sin embargo, puede verificar el puerto en el elemento `<httpEndpoint>` como se define en el archivo **server.xml**. Se visualiza una pantalla de inicio de sesión.

![La pantalla de inicio de sesión](mfpconsole_signin.jpg)

3. Inicie sesión con **admin/admin**. Este usuario lo crea de forma predeterminada la Herramienta de configuración del servidor.

    > **Nota:** Si se conecta con HTTP, el ID de inicio de sesión y la contraseña se envían como texto simple en la red. Para un inicio de sesión seguro, utilice HTTPS para iniciar sesión en el servidor. Puede ver el puerto HTTPS del servidor Liberty en el atributo httpsPort del elemento `<httpEndpoint>` del archivo **server.xml**. De forma predeterminada, el valor es 9443.



4. Cierre la sesión de la consola con **Hola, administrador → Finalizar sesión**.
5. Especifique el siguiente URL: [https://localhost:9443/mfpconsole](https://localhost:9443/mfpconsole) en el navegador web y acepte el certificado. De forma predeterminada, el servidor Liberty genera un certificado predeterminado que no es conocido por su navegador web, debe aceptar el certificado. Mozilla Firefox presenta esta certificación como excepción de seguridad.
6. Vuelva a iniciar sesión con **admin/admin**. El inicio de sesión y la contraseña se encriptan entre su navegador web y {{ site.data.keys.mf_server }}. En producción, es posible que desee cerrar el puerto HTTP.

## Creación de una granja de servidores de dos servidores Liberty que ejecutan {{ site.data.keys.mf_server }}
{: #creating-a-farm-of-two-liberty-servers-that-run-mobilefirst-server }
En esta tarea, creará un segundo servidor Liberty que ejecute el mismo {{ site.data.keys.mf_server }} y conectado con la misma base de datos. En producción, es posible que utilice más de un servidor por motivos de rendimiento, para tener servidores suficientes para servir al número de transacciones por segundo necesario para sus aplicaciones móvil en hora punta. También es por motivos de alta disponibilidad para evitar tener un punto único de anomalía.

Cuando tiene más de un servidor que ejecuta {{ site.data.keys.mf_server }}, se deben configurar como granja de servidores. Esta configuración permite a cualquier servicio de administración contactar con todos los tiempos de ejecución de una granja de servidores. Si el clúster no está configurado como granja de servidores, solo se notifica al tiempo de ejecución que se ejecuta en el mismo servidor de aplicaciones que el servicio de gestión que ejecuta a operación de gestión. Otros tiempos de ejecución no conocen el cambio. Por ejemplo, despliega una nueva versión de un adaptador en un clúster que no está configurado como granja de servidores, solo un tiempo de ejecución servirá al nuevo adaptador. Los otros servidores continuarán sirviendo al adaptador antiguo. La única situación donde puede tener un clúster sin necesidad de configurarlo como granja de servidores es cuando instala sus servidores en WebSphere Application Server Network Deployment. El servicio de administración es capaz de encontrar todos los servidores consultando los beans de JMX con el gestor de despliegue. El gestor de despliegue debe estar en ejecución para permitir operaciones de gestión porque se utiliza para proporcionar la lista de beans de JMX de la celda de {{ site.data.keys.product_adj }}. 

Cuando crea una granja de servidores, también debe configurar un servidor HTTP para enviar consultas a todos los miembros de la granja de servidores. La configuración de un servidor HTTP no está incluida en esta guía de aprendizaje. Esta guía de aprendizaje solo trata sobre la configuración de la granja de servidores para que las operaciones de gestión se repliquen en todos los componentes de tiempo de ejecución del clúster.

1. Crear un segundo servidor Liberty en el mismo sistema.
    * Inicie una línea de mandatos.
    * Vaya a **liberty\_install\_dir/bin** e introduzca **server create mfp2**.

2. Modifique los puertos HTTP y HTTPS del servidor **mfp2** para que no entren en conflicto con los puertos del servidor **mfp1**.
    * Vaya al directorio del segundo servidor.

        El directorio es **liberty\_install\_dir/usr/servers/mfp2** o **WLP\_USER\_DIR/servers/mfp2** (si modificó el directorio como se describía en el paso 6 Instalación de WebSphere Application Server Liberty Core).
    * Edite el archivo **server.xml**. Sustituya

      ```xml
      <httpEndpoint id="defaultHttpEndpoint"
        httpPort="9080"
        httpsPort="9443" />
      ```
        
      Por:
        
      ```xml
      <httpEndpoint id="defaultHttpEndpoint"
        httpPort="9081"
        httpsPort="9444" />
      ```
        
      Los puertos HTTP y HTTPS del servidor mfp2 no entran en conflicto con los puertos del servidor mfp1 con este cambio. Asegúrese de modificar los puertos antes de ejecutar la instalación de {{ site.data.keys.mf_server }}. De lo contrario, si modifica los puertos después de realizar la instalación, también deberá reflejar el cambio del puerto en la propiedad JNDI: **mfp.admin.jmx.port**.

3. Copie el archivo Ant que utilizó en [Despliegue de {{ site.data.keys.mf_server }} en Liberty con tareas Ant](#deploying-mobilefirst-server-to-liberty-with-ant-tasks), y cambie el valor de la propiedad **appserver.was85liberty.serverInstance** por **mfp2**. Las tareas Ant detectan que existen las bases de datos y no las crean (consulte el siguiente extracto de registro). A continuación, se despliegan las aplicaciones en el servidor. 

   ```bash
   [configuredatabase] Checking connectivity to MobileFirstAdmin database MFPDATA with schema 'MFPDATA' and user 'mfpuser'...
   [configuredatabase] Database MFPDATA exists.
   [configuredatabase] Connection to MobileFirstAdmin database MFPDATA with schema 'MFPDATA' and user 'mfpuser' succeeded.
   [configuredatabase] Getting the version of MobileFirstAdmin database MFPDATA...
   [configuredatabase] Table MFPADMIN_VERSION exists, checking its value...
   [configuredatabase] GetSQLQueryResult => MFPADMIN_VERSION = 8.0.0
   [configuredatabase] Configuring MobileFirstAdmin database MFPDATA...
   [configuredatabase] The database is in latest version (8.0.0), no upgrade required.
   [configuredatabase] Configuration of MobileFirstAdmin database MFPDATA succeeded.
   ```

4. Probar los dos servidores con conexión HTTP.
    * Abra un navegador web.
    * Especifique el siguiente URL: [http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole). El servidor mfp1 sirve a la consola.
    * Inicie sesión con **admin/admin**. 
    * Abra un separador en el mismo navegador web y especifique el URL: [http://localhost:9081/mfpconsole](http://localhost:9081/mfpconsole). El servidor mfp2 sirve a la consola.
    * Inicie sesión con admin/admin. Si se ha realizado correctamente la instalación, puede ver la misma página de bienvenida en ambos separadores después de iniciar sesión.
    * Vuelva al primer separador del navegador y pulse **Hola, administrador → Descargar registro de auditoría**. Se cierra la sesión de la consola y ve la pantalla de inicio de sesión de nuevo. Este comportamiento de cierre de sesión es un problema. El problema ocurre porque cuando inicia sesión en el servidor mfp2, se crea una señal de Lightweight Third Party Authentication (LTPA) y se almacena en su navegador como cookie. Sin embargo, el servidor mfp1 no reconoce esta señal LTPA. Es posible que se produzca una conmutación entre servidores en un entorno de producción cuando tiene un equilibrador de carga HTTP delante de un clúster. Para resolver este problema, debe asegurarse de que ambos servidores (mfp1 y mfp2) generan las señales de LTPA con las mismas claves secretas. Copie las claves de LTPA del servidor mfp1 en el servidor mfp2.
    
        * Detenga ambos servidores con estos mandatos:
        
          ```bash
          server stop mfp1
          server stop mfp2
          ```
        
        * Copie las claves de LTPA del servidor mfp1 en el servidor mfp2.

Desde **liberty\_install\_dir/usr/servers** o **WLP\_USER\_DIR/servers**, ejecute el siguiente mandato dependiendo de su sistema operativo. 
            * En UNIX: `cp mfp1/resources/security/ltpa.keys mfp2/resources/security/ltpa.keys`
            * En Windows: `copy mfp1/resources/security/ltpa.keys mfp2/resources/security/ltpa.keys`
        * Reinicie los servidores. Conmutar de un separador del navegador a otro no requiere que vuelva a iniciar sesión. En una granja de servidores Liberty, todos los servidores deben tener las mismas claves LTPA.
    
5. Habilite la comunicación JMX entre los servidores Liberty.

    La comunicación JMX con Liberty se realiza mediante el conector REST de Liberty en el protocolo HTTPS. Para habilitar esta comunicación, cada servidor de la granja de servidores debe ser capaz de reconocer el certificado SSL de los otros miembros. Debe intercambiar los certificados HTTPS en sus almacenes de confianza. Utilice los programas de utilidad de IBM como Keytool, que es parte de la distribución de JRE de IBM en **java/bin** para configurar el almacén de confianza. Las ubicaciones del almacén de claves y del almacén de confianza están definidas en el archivo **server.xml**. De forma predeterminada, el almacén de claves del perfil de Liberty se encuentra en **WLP\_USER\_DIR/servers/server\_name/resources/security/key.jks**. La contraseña de este almacén de claves predeterminado, como se puede ver en el archivo **server.xml**, es **mobilefirst**.
        
    > **Sugerencia:** Puede cambiarla con el programa de utilidad keytool Keytool, pero también debe cambiar la contraseña en el archivo server.xml para que el servidor Liberty pueda leer este almacén de claves. En esta guía de aprendizaje, utilice la contraseña predeterminada.
    
    * En **WLP\_USER\_DIR/servers/mfp1/resources/security**, especifique `keytool -list -keystore key.jks`. El mandato muestra los certificados en el almacén de claves. Solo hay uno llamado **default**. Se le solicitará la contraseña del almacén de claves (mobilefirst) antes de poder ver las claves. Este es el caso de todos los mandatos siguientes con el programa de utilidad Keytool.
    * Exporte el certificado predeterminado del servidor mfp1 con el mandato: `keytool -exportcert -keystore key.jks -alias default -file mfp1.cert`.
    * En **WLP\_USER\_DIR/servers/mfp2/resources/security**, exporte el certificado predeterminado del servidor mfp2 con el mandato: `keytool -exportcert -keystore key.jks -alias default -file mfp2.cert`.
    * En el mismo directorio, importe el certificado del servidor mfp1 con el mandato: `keytool -import -file ../../../mfp1/resources/security/mfp1.cert -keystore key.jks`. El certificado del servidor mfp1 se importa en el almacén de claves del servidor mfp2 para que el servidor mfp2 pueda confiar en las conexiones HTTPS con el servidor mfp1. Se le solicitará que confirme que confía en el certificado.
    * En **WLP\_USER\_DIR/servers/mfp1/resources/security**, importe el certificado del servidor mfp2 con el mandato: `keytool -import -file ../../../mfp2/resources/security/mfp2.cert -keystore key.jks`. Después de realizar este paso, son posibles las conexiones HTTPS entre los dos servidores.

## Realización de pruebas en la granja de servidores y ver los cambios en {{ site.data.keys.mf_console }}
{: #testing-the-farm-and-see-the-changes-in-mobilefirst-operations-console }

1. Inicie los dos servidores:

   ```bash
   server start mfp1
   server start mfp2
   ```
        
2. Acceda a la consola. Por ejemplo, [http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole), o [https://localhost:9443/mfpconsole](https://localhost:9443/mfpconsole) en HTTPS. En la barra lateral izquierda, aparecerá un menú adicional etiquetado como **Nodos de granja de servidores**. Si pulsa en **Nodos de granja de servidores**, puede ver el estado de cada nodo. Es posible que tenga que esperar un poco para que se inicien los nodos.
