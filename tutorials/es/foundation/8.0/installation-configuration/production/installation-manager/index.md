---
layout: tutorial
title: Cómo ejecutar IBM Installation Manager
weight: 7
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
IBM Installation Manager instala los archivos y las herramientas de {{ site.data.keys.mf_server_full }} en el sistema.

Ejecute Installation Manager para instalar los archivos binarios de {{ site.data.keys.mf_server }} y las herramientas para desplegar las aplicaciones de {{ site.data.keys.mf_server }} en un servidor de aplicaciones en el sistema. Los archivos y herramientas instalados por el instalador se describen en [Estructura de distribución de {{ site.data.keys.mf_server }}](#distribution-structure-of-mobilefirst-server).

Necesita IBM Installation Manager V1.8.4 o posterior para ejecutar el instalador de {{ site.data.keys.mf_server }}. Puede ejecutarlo en modalidad gráfica o en modalidad de línea de mandatos.  
Se proponen dos opciones principales durante el proceso de instalación:

* Activación de licencias de señales
* Instalación y despliegue de {{ site.data.keys.mf_app_center }}

### Licencias de señales
{: #token-licensing }
Las licencias de señales es uno de los dos métodos de licencias soportados por {{ site.data.keys.mf_server }}. Debe determinar si es necesario activar las licencias de señales o no. Si no tiene un contrato que defina el uso de licencias de señales con Rational License Key Server, no active las licencias de señales. Si activa las licencias de señales, debe configurar {{ site.data.keys.mf_server }} para las licencias de señales. Para obtener más información, consulte [Instalación y configuración para las licencias de señales](../token-licensing).

### {{ site.data.keys.mf_app_center_full }}
{: #ibm-mobilefirst-foundation-application-center }
Application Center es un componente de {{ site.data.keys.product }}. Con Application Center, puede compartir aplicaciones móviles que se encuentran en desarrollo dentro de su organización en un único repositorio de aplicaciones móviles.

Si elige instalar Application Center con Installation Manager, debe proporcionar los parámetros de la base de datos y del servidor de aplicaciones para que Installation Manager configure las bases de datos y despliegue Application Center en el servidor de aplicaciones. Si opta por no instalar Application Center con Installation Manager, Installation Manager guardará el archivo WAR y los recursos de Application Center en el disco. No configura las bases de datos ni despliega el archivo WAR de Application Center en el servidor de aplicaciones. Puede hacerlo más tarde utilizando tareas Ant o manualmente. Esta opción para instalar Application Center es una forma cómoda de descubrir Application Center porque el asistente de instalación gráfico le guiará durante el proceso de instalación.

Sin embargo, para la instalación de producción, utilice tareas Ant para instalar Application Center. La instalación con tareas Ant le permite separar las actualizaciones en {{ site.data.keys.mf_server }} desde las actualizaciones a Application Center.

* Ventajas de instalar Application Center con Installation Manager.
    * Un asistente gráfico guiado le ayudará a través de la instalación y del proceso de despliegue.
* Desventajas de instalar Application Center con Installation Manager.
    * Si Installation Manager se ejecuta con el usuario root en UNIX o Linux, puede crear los archivos que son propiedad de root en el directorio del servidor de aplicaciones donde se despliega Application Center. Como resultado, debe ejecutar el servidor de aplicaciones como root.
    * No tiene acceso a los scripts de base de datos y no puede proporcionarlos a su administrador de base de datos para crear las tablas antes de ejecutar el procedimiento de instalación. Installation Manager crea las tablas de base de datos con valores predeterminados.
    * Cada vez que actualice el producto, por ejemplo para instalar un arreglo temporal, Application Center se actualizará en primer lugar. La actualización de Application Center incluye operaciones en la base de datos y en el servidor de aplicaciones. Si la actualización de Application Center falla, impedirá que Installation Manager finalice la actualización, e impide al usuario actualizar otros componentes de {{ site.data.keys.mf_server }}. Para la instalación de producción, no despliegue Application Center con Installation Manager. Instale Application Center por separado con tareas Ant una vez que Installation Manager instale {{ site.data.keys.mf_server }}. Para obtener más información sobre Application Center, consulte [Instalación y configuración de Application Center](../../../appcenter).

> **Importante:** El instalador de {{ site.data.keys.mf_server }} sólo instala los archivos binarios y las herramientas de {{ site.data.keys.mf_server }} en el disco. No despliega las aplicaciones de {{ site.data.keys.mf_server }} en el servidor de aplicaciones. Después de ejecutar la instalación con Installation Manager, debe configurar las bases de datos y desplegar las aplicaciones de {{ site.data.keys.mf_server }} en su servidor de aplicaciones.  
> De forma similar, al ejecutar Installation Manager para actualizar una instalación existente, sólo actualizará los archivos del disco. Debe llevar a cabo más acciones para actualizar las aplicaciones desplegadas en los servidores de aplicaciones.

#### Ir a
{: #jump-to }
* [Administrador frente a modalidad de usuario](#administrator-versus-user-mode)
* [Instalación mediante el asistente de instalación de IBM Installation Manager](#installing-by-using-ibm-installation-manager-install-wizard)
* [Instalación mediante la ejecución de IBM Installation Manager en la línea de mandatos](#installing-by-running-ibm-installation-manager-in-command-line)
* [Instalación mediante los archivos de respuestas XML - instalación silenciosa](#installing-by-using-xml-response-files---silent-installation)
* [Estructura de distribución de {{ site.data.keys.mf_server }}](#distribution-structure-of-mobilefirst-server)

## Administrador frente a modalidad de usuario
{: #administrator-versus-user-mode }
Puede instalar {{ site.data.keys.mf_server }} en dos modalidades diferentes de IBM Installation Manager. La modalidad depende de cómo está instalado el propio IBM Installation Manager. La modalidad determina los directorios y los mandatos que utiliza para Installation Manager y los paquetes.

{{ site.data.keys.product }} da soporte a las siguientes dos modalidades de Installation Manager:

* Modalidad de administrador
* Modalidad de usuario (no administrador)

La modalidad de grupo que está disponible en Linux o UNIX no está soportada por el producto.

### Modalidad de administrador
{: #administrator-mode }
En la modalidad de administrador, Installation Manager debe ejecutarse como root en Linux o UNIX, y con privilegios de administrador en Windows. Los archivos de repositorio de Installation Manager (que es la lista de software instalado y su versión) están instalados en un directorio del sistema. /var/ibm en Linux o UNIX, o ProgramData en Windows. No despliegue Application Center con Installation Manager si ejecuta Installation Manager en modalidad de administrador.

### Modalidad de usuario (no administrador)
{: #user-nonadministrator-mode }
En la modalidad de usuario, Installation Manager puede ejecutarlo cualquier usuario sin privilegios específicos. Sin embargo, los archivos de repositorio de Installation Manager están almacenados en el directorio de inicio del usuario. Sólo dicho usuario podrá actualizar una instalación del producto.
Si no ejecuta Installation Manager como root, asegúrese de tener una cuenta de usuario disponible más adelante al actualizar la instalación del producto o aplicar un arreglo temporal.

Para obtener más información sobre las modalidades de Installation Manager, consulte [Instalación como administrador, no administrador o grupo](http://www.ibm.com/support/knowledgecenter/SSDV2W_1.8.4/com.ibm.silentinstall12.doc/topics/r_admin_nonadmin.html?lang=en&view=kc) en la documentación de IBM Installation Manager.

## Instalación mediante el asistente de instalación de IBM Installation Manager
{: #installing-by-using-ibm-installation-manager-install-wizard }
Siga los pasos del procedimiento para instalar los recursos de {{ site.data.keys.mf_server }}, y las herramientas (como por ejemplo la Herramienta de configuración del servidor, Ant, y el programa mfpadm).  
Las decisiones de los dos paneles siguientes del asistente de instalación son obligatorias:

* El panel **Valores generales**.
* El panel **Elegir configuración** para instalar Application Center.

1. Inicie Installation Manager.
2. Añada el repositorio de {{ site.data.keys.mf_server }} en Installation Manager.
    * Vaya a **Archivo → Preferencias** y pulse **Añadir repositorios...**.
    * Busque el archivo de repositorio en el directorio donde se extrae el instalador.

        Si descomprime el archivo .zip de {{ site.data.keys.product }} V8.0 para {{ site.data.keys.mf_server }} en la carpeta **mfp\_installer\_directory**, el archivo de repositorio se podrá encontrar en **mfp\_installer\_directory/MobileFirst\_Platform\_Server/disk1/diskTag.inf**.

        También es posible que desee aplicar el fixpack más reciente que se puede descargar desde [IBM Support Portal](http://www.ibm.com/support/entry/portal/product/other_software/ibm_mobilefirst_platform_foundation). Asegúrese de escribir el repositorio para el fixpack. Si descomprime el fixpack en la carpeta **fixpack_directory**, el archivo de repositorio se encontrará en **fixpack\_directory/MobileFirst\_Platform\_Server/disk1/diskTag.inf**.

        **Nota:** No puede instalar el fixpack sin el repositorio de la versión base en los repositorios de Installation Manager. Los fixpacks son instaladores incrementales y necesitan el repositorio de la versión base que va a instalarse.
    * Seleccione el archivo y pulse **Aceptar**.
    * Pulse **Aceptar** para cerrar el panel **Preferencias**.
3. Después de aceptar los términos de licencia del producto, pulse **Siguiente**.
4. Elija el grupo de paquetes para instalar el producto.

    {{ site.data.keys.product }} V8.0 es una sustitución para los releases anteriores que tienen un nombre de instalación distinto:
    * Worklight para V5.0.6
    * IBM Worklight para V6.0 a V6.3

    Si una de estas versiones anteriores del producto está instalada en el sistema, Installation Manager le ofrecerá una opción Utilizar un grupo de paquetes existente al principio del proceso de instalación. Esta opción desinstala la versión anterior del producto, y reutiliza las opciones de instalación anteriores para actualizar {{ site.data.keys.mf_app_center_full }} si se había instalado.

    Para una instalación independiente, seleccione la opción de grupo Crear un paquete nuevo para poder instalar la versión nueva junto con la antigua.  
    Si no hay ninguna otra versión del producto instalada en el sistema, elija la opción de grupo Crear un paquete nuevo para instalar el producto en un nuevo grupo de paquetes.

5. Pulse **Siguiente**.
6. Decida si desea activar las licencias de señales en la sección **Activar licencias de señales** del panel **Valores generales**.

    Si tiene un contrato para utilizar las licencias de señales con Rational License Key Server, seleccione la opción **Activar licencias de señales con Rational License Key Server**. Tras activar las licencias de señales, debe realizar pasos adicionales para configurar {{ site.data.keys.mf_server }}. De lo contrario, seleccione la opción **No activar las licencias de señales con Rational License Key Server** para continuar.
7. Mantenga la opción predeterminada (No) tal cual en la sección **Instalar {{ site.data.keys.product }} for iOS** del panel **Valores generales**.
8. Decida si va a instalar Application Center en el panel **Elegir configuración**.

    Para la instalación de producción, utilice tareas Ant para instalar Application Center. La instalación con tareas Ant le permite separar las actualizaciones en {{ site.data.keys.mf_server }} desde las actualizaciones a Application Center. En este caso, seleccione Ninguna opción en el panel Elegir configuración para que Application Center no se instale.

    Si selecciona Sí, necesitará pasar por los paneles siguientes para especificar los detalles sobre la base de datos que tiene pensado utilizar y el servidor de aplicaciones donde tiene previsto desplegar Application Center. También necesita tener disponible el controlador JDBC de la base de datos.
9. Pulse **Siguiente** hasta que llegue al panel **Gracias**. A continuación, siga con la instalación.

Se ha instalado un directorio de instalación que contiene los recursos para instalar componentes de {{ site.data.keys.product_adj }}.

Puede encontrar los recursos en las siguientes carpetas:

* Carpeta **MobileFirstServer** para {{ site.data.keys.mf_server }}
* Carpeta **PushService** para el servicio de envío por push de {{ site.data.keys.mf_server }}
* Carpeta **ApplicationCenter** para Application Center
* Carpeta **Analytics** para {{ site.data.keys.mf_analytics }}

También puede encontrar algunos atajos para la Herramienta de configuración del servidor, Ant, y el programa mfpadm en la carpeta **shortcuts**.

## Instalación ejecutando IBM Installation Manager en la línea de mandatos
{: #installing-by-running-ibm-installation-manager-in-command-line }

1. Revise el acuerdo de licencia para {{ site.data.keys.mf_server }}. Los archivos de licencia se pueden ver al descargar el repositorio de instalación desde Passport Advantage.
2. Extraiga el archivo comprimido del repositorio de {{ site.data.keys.mf_server }}, que ha descargado, a una carpeta.

    Puede descargar el repositorio desde {{ site.data.keys.product }} eAssembly en [IBM Passport Advantage](http://www.ibm.com/software/passportadvantage/pao_customers.htm). El nombre del paquete es **IBM MobileFirst Foundation V{{ site.data.keys.product_V_R }} archivo .zip de Installation Manager Repository for IBM MobileFirst Platform Server**.

    En los pasos que se indican a continuación, se hace referencia al directorio donde extrae el instalador como **mfp\_repository\_dir**. Contiene una carpeta **MobileFirst\_Platform\_Server/disk1**.
3. Inicie una línea de mandatos y vaya a **installation\_manager\_install\_dir/tools/eclipse/**.

    Si acepta el acuerdo de licencia tras la revisión en el paso 1, instale {{ site.data.keys.mf_server }}.
    * Para una instalación sin obligatoriedad de las licencias de señales (si no tiene un contrato que defina el uso de las licencias de señales), escriba el mandato:

      ```bash
      imcl install com.ibm.mobilefirst.foundation.server -repositories mfp_repository_dir/MobileFirst_Platform_Server/disk1 -properties user.appserver.selection2=none,user.database.selection2=none,user.database.preinstalled=false,user.licensed.by.tokens=false,user.use.ios.edition=false -acceptLicense
      ```
    * Para una instalación con la puesta en vigor de licencias de señales, especifique el mandato:

      ```bash
      imcl install com.ibm.mobilefirst.foundation.server -repositories mfp_repository_dir/MobileFirst_Platform_Server/disk1 -properties user.appserver.selection2=none,user.database.selection2=none,user.database.preinstalled=false,user.licensed.by.tokens=true,user.use.ios.edition=false -acceptLicense
      ```

        El valor de la propiedad **user.licensed.by.tokens** está establecida en **true**. Debe configurar {{ site.data.keys.mf_server }} para [licencias de señales](../token-licensing).

        Las propiedades siguientes se establecen para instalar {{ site.data.keys.mf_server }} sin Application Center:
        * **user.appserver.selection2**=none
        * **user.database.selection2**=none
        * **user.database.preinstalled**=false

        Esta propiedad indica si las licencias de señales están activadas o no: **user.licensed.by.tokens=true/false**.

        Establezca el valor de la propiedad user.use.ios.edition en false para instalar {{ site.data.keys.product }}.

5. Si desea instalar con el arreglo temporal más reciente, añada el repositorio de arreglo temporal al parámetro **-repositories**. El parámetro **-repositories** toma una lista separada por comas de repositorios.

    Añada la versión del arreglo temporal sustituyendo **com.ibm.mobilefirst.foundation.server** por **com.ibm.mobilefirst.foundation.server_version**. **version** tiene la forma **8.0.0.0-buildNumber**. Por ejemplo, si instala el arreglo temporal **8.0.0.0-IF20160103101**5, escriba el mandato: `imcl install com.ibm.mobilefirst.foundation.server_8.0.0.00-201601031015 -repositories...`.

    Para obtener más información sobre el mandato imcl, consulte [Installation Manager: Instalación de paquetes mediante mandatos `imcl`](https://www.ibm.com/support/knowledgecenter/SSDV2W_1.8.4/com.ibm.cic.commandline.doc/topics/t_imcl_install.html?lang=en).

Se ha instalado un directorio de instalación que contiene los recursos para instalar componentes de {{ site.data.keys.product_adj }}.

Puede encontrar los recursos en las siguientes carpetas:

* Carpeta **MobileFirstServer** para {{ site.data.keys.mf_server }}
* Carpeta **PushService** para el servicio de envío por push de {{ site.data.keys.mf_server }}
* Carpeta **ApplicationCenter** para Application Center
* Carpeta **Analytics** para {{ site.data.keys.mf_analytics }}    

También puede encontrar algunos atajos para la Herramienta de configuración del servidor, Ant, y el programa mfpadm en la carpeta **shortcuts**.

## Instalación mediante archivos de respuesta XML - instalación silenciosa
{: #installing-by-using-xml-response-files---silent-installation }
Si desea instalar {{ site.data.keys.mf_app_center_full }} con IBM Installation Manager en la línea de mandatos, debe proporcionar una lista larga de argumentos. En este caso, utilice los archivos de respuesta XML para proporcionar estos argumentos.

Las instalaciones silenciosas están definidas por un archivo XML que se llama archivo de respuestas. Este archivo contiene los datos necesarios para completar las operaciones de instalación de forma silenciosa. Las instalaciones silenciosas se han iniciado desde la línea de mandatos o un archivo de procesamiento por lotes.

Puede utilizar Installation Manager para registrar preferencias y acciones de instalación para su archivo de respuestas en la modalidad de interfaz de usuario. Como alternativa, puede crear un archivo de respuestas manualmente utilizando la lista documentada de mandatos y preferencias de archivos de respuestas.

La instalación silenciosa se describe en la documentación de usuario de Installation Manager. Consulte [Cómo trabajar en modalidad silenciosa](http://ibm.biz/knowctr#SSDV2W_1.8.4/com.ibm.silentinstall12.doc/topics/t_silentinstall_overview.html).

Hay dos formas de crear un archivo de respuestas adecuado:

* Cómo trabajar con archivos de respuestas de ejemplo proporcionados en la documentación de usuario de {{ site.data.keys.product_adj }}.
* Cómo trabajar con un archivo de respuestas registrado en un sistema distinto.

Ambos métodos están documentados en las siguientes secciones.

### Cómo trabajar con archivos de respuestas de ejemplo para IBM Installation Manager
{: #working-with-sample-response-files-for-ibm-installation-manager }
Los archivos de respuestas de ejemplo para IBM Installation Manager se proporcionan en el archivo comprimido **Silent\_Install\_Sample_Files.zip**. Los procedimientos siguientes describen cómo utilizarlos.

1. Elija el archivo de respuestas de ejemplo apropiado desde el archivo comprimido. El archivo Silent_Install_Sample_Files.zip contiene un subdirectorio por release.

    > **Importante:**  
    >
    > * Para una instalación que no instala Application Center en un servidor de aplicaciones, utilice el archivo denominado **install-no-appcenter.xml**.
    > * Para una instalación que instala Application Center, elija el archivo de respuestas de ejemplo desde la tabla siguiente, dependiendo del servidor de aplicaciones y de la base de datos.

   #### Archivos de respuestas de instalación de ejemplo en el archivo **Silent\_Install\_Sample_Files.zip** para instalar el Application Center

    <table>
        <tr>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
            <th>Servidor de aplicaciones donde se instalará el Application Center</th>
            <th>Derby</th>
            <th>IBM DB2 </th>
            <th>MySQL</th>
            <th>Oracle</th>
        </tr>
        <tr>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
            <td>Perfil de WebSphere Application Server Liberty</td>
            <td>install-liberty-derby.xml</td>
            <td>install-liberty-db2.xml</td>
            <td>install-liberty-mysql.xml (Véase Nota)</td>
            <td>install-liberty-oracle.xml</td>
        </tr>
        <tr>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
            <td>Perfil completo de WebSphere Application Server, servidor autónomo</td>
            <td>install-was-derby.xml</td>
            <td>install-was-db2.xml</td>
            <td>install-was-mysql.xml (Véase Nota)</td>
            <td>install-was-oracle.xml</td>
        </tr>
        <tr>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
            <td>WebSphere Application Server Network Deployment</td>
            <td>n/a</td>
            <td>install-wasnd-cluster-db2.xml, install-wasnd-server-db2.xml, install-wasnd-node-db2.xml, install-wasnd-cell-db2.xml</td>
            <td>install-wasnd-cluster-mysql.xml (Véase Nota), install-wasnd-server-mysql.xml (Véase Nota), install-wasnd-node-mysql.xml, install-wasnd-cell-mysql.xml (Véase Nota)</td>
            <td>install-wasnd-cluster-oracle.xml, install-wasnd-server-oracle.xml, install-wasnd-node-oracle.xml, install-wasnd-cell-oracle.xml</td>
        </tr>
        <tr>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
            <td>Apache Tomcat</td>
            <td>install-tomcat-derby.xml</td>
            <td>install-tomcat-db2.xml</td>
            <td>install-tomcat-mysql.xml</td>
            <td>install-tomcat-oracle.xml</td>
        </tr>
    </table>

    > **Nota:** MySQL junto con el perfil de Liberty de WebSphere Application Server o el perfil completo de WebSphere Application Server no está clasificado como una configuración soportada. Para obtener más información, consulte [WebSphere Application Server Support Statement](http://www.ibm.com/support/docview.wss?uid=swg27004311). Puede utilizar IBM DB2 u otro DBMS soportado por WebSphere Application Server para beneficiarse de una configuración completamente soportada por IBM Support.

    Para la desinstalación, utilice un archivo de ejemplo que dependa de la versión de {{ site.data.keys.mf_server }} o Worklight Server que ha instalado inicialmente en el grupo de paquetes concreto:

    * {{ site.data.keys.mf_server }} utiliza el grupo de paquetes {{ site.data.keys.mf_server }}.
    * Worklight Server V6.x, o posterior, utiliza el grupo de paquetes IBM Worklight.
    * Worklight Server V5.x utiliza el grupo de paquetes Worklight.

    <table>
        <tr>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
            <th>Versión inicial de {{ site.data.keys.mf_server }}</th>
            <th>Archivo de ejemplo</th>
        </tr>
        <tr>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
            <td>Worklight Server V5.x</td>
            <td>uninstall-initially-worklightv5.xml</td>
        </tr>
        <tr>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
            <td>Worklight Server V6.x</td>
            <td>uninstall-initially-worklightv6.xml</td>
        </tr>
        <tr>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
            <td>IBM MobileFirst Server V6.x o posterior</td>
            <td>uninstall-initially-mfpserver.xml</td>
        </tr>
    </table>

2. Cambie los derechos de acceso del archivo del archivo de ejemplo para que sean lo más restrictivos posible. El paso 4 requiere que proporcione algunas contraseñas. Si debe impedir que otros usuarios del mismo sistema conozcan estas contraseñas, debe eliminar los permisos de lectura del archivo para usuarios distintos a usted mismo. Puede utilizar un mandato, como los ejemplos siguientes:
    * En UNIX: `chmod 600 <target-file.xml>`
    * En Windows: `cacls <target-file.xml> /P Administrators:F %USERDOMAIN%\%USERNAME%:F`
3. De forma similar, si el servidor es un perfil de WebSphere Application Server Liberty o un servidor de Apache Tomcat, y el servidor está destinado a que se inicie únicamente desde su cuenta de usuario, también debe eliminar los permisos de lectura para usuarios distintos a usted mismo del archivo siguiente:
    * Para el perfil de WebSphere Application Server Liberty: `wlp/usr/servers/<server>/server.xml`
    * Para Apache Tomcat: `conf/server.xml`
4. Ajuste la lista de repositorios, en el elemento <server>. Para obtener más información sobre este paso, consulte la documentación de IBM Installation Manager en [Repositorios](http://ibm.biz/knowctr#SSDV2W_1.8.4/com.ibm.silentinstall12.doc/topics/r_repository_types.html).

    En el elemento `<profile>`, ajuste los valores de cada par clave/valor.  
    En el elemento `<offering>`, en el elemento `<install>`, establezca el atributo version para que coincida con el release que desea instalar, o elimine el atributo version si desea instalar la versión más reciente disponible en los repositorios.
5. Escriba el siguiente mandato: `<InstallationManagerPath>/eclipse/tools/imcl input <responseFile>  -log /tmp/installwl.log -acceptLicense`

    Donde:
    * `<InstallationManagerPath>` es el directorio de instalación de IBM Installation Manager.
    * `<responseFile>` es el nombre del archivo seleccionado y actualizado en el paso 1.

> Para obtener más información, consulte la documentación de IBM Installation Manager en [Instalación de un paquete de forma silenciosa utilizando un archivo de respuestas](http://ibm.biz/knowctr#SSDV2W_1.8.4/com.ibm.silentinstall12.doc/topics/t_silent_response_file_install.html).


### Cómo trabajar con un archivo de respuestas registrado en una máquina distinta
{: #working-with-a-response-file-recorded-on-a-different-machine }

1. Registre un archivo de respuestas, ejecutando IBM Installation Manager en modalidad de asistente y con la opción `-record responseFile` en una máquina donde esté disponible una GUI. Para obtener más detalles, consulte [Registrar un archivo de respuestas con Installation Manager](http://ibm.biz/knowctr#SSDV2W_1.7.0/com.ibm.silentinstall12.doc/topics/t_silent_create_response_files_IM.html).
2. Cambie los derechos de acceso del archivo del archivo de respuestas para que sean lo más restrictivos posible. El paso 4 requiere que proporcione algunas contraseñas. Si debe impedir que otros usuarios del mismo sistema conozcan estas contraseñas, debe eliminar los permisos de **lectura** del archivo para usuarios distintos a usted mismo. Puede utilizar un mandato, como los ejemplos siguientes:
    * En UNIX: `chmod 600 response-file.xml`
    * En Windows: `cacls response-file.xml /P Administrators:F %USERDOMAIN%\%USERNAME%:F`
3. De forma similar, si el servidor es uno de WebSphere Application Server Liberty o de Apache Tomcat, y el servidor está pensado para iniciarse únicamente desde su cuenta de usuario, también debe eliminar los permisos de lectura para usuarios que no sean usted mismo desde el siguiente archivo:
    * Para WebSphere Application Server Liberty: `wlp/usr/servers/<server>/server.xml`
    * Para Apache Tomcat: `conf/server.xml`
4. Modifique el archivo de respuestas para tener en cuenta las diferencias entre la máquina en la que se ha creado el archivo de respuestas y la máquina de destino.
5. Instale {{ site.data.keys.mf_server }} mediante el archivo de respuestas en la máquina de destino, tal como se describe en [Instalar un paquete de forma silenciosa utilizando un archivo de respuestas](http://ibm.biz/knowctr#SSDV2W_1.7.0/com.ibm.silentinstall12.doc/topics/t_silent_response_file_install.html).

### Parámetros de la línea de mandatos (instalación silenciosa)
{: #command-line-silent-installation-parameters }
<table style="word-break:break-all">
    <tr>
        <th>Clave</th>
        <th>Cuando sea necesario</th>
        <th>Descripción</th>
        <th>Valores permitidos</th>
    </tr>
    <tr>
        <td>user.use.ios.edition</td>
        <td>Siempre</td>
        <td>Establezca el valor en <code>false</code> si tiene pensado instalar {{ site.data.keys.product }}. Si tiene pensado instalar el producto para la edición de iOS, debe establecer el valor en <code>true</code>.</td>
        <td><code>true</code> o <code>false</code></td>
    </tr>
    <tr>
        <td>user.licensed.by.tokens</td>
        <td>Siempre</td>
        <td>Activación de las licencias de señales. Si tiene pensado utilizar el producto con Rational License Key Server, debe activar las licencias de señales.<br/><br/>En este caso, establezca el valor en <code>true</code>. Si no tiene pensado utilizar el producto con Rational License Key Server, establezca el valor en <code>false</code>.<br/><br/>Si activa las señales de licencia, se necesitarán pasos de configuración específicos después de desplegar el producto en un servidor de aplicaciones. </td>
        <td><code>true</code> o <code>false</code></td>    
    </tr>
    <tr>
        <td>user.appserver.selection2</td>
        <td>Siempre</td>
        <td>Tipo de servidor de aplicaciones. was significa preinstalado en WebSphere Application Server 8.5.5. tomcat significa Tomcat 7.0.</td>
        <td></td>
    </tr>
    <tr>
        <td>user.appserver.was.installdir</td>
        <td>${user.appserver.selection2} == was</td>
        <td>Directorio de instalación de WebSphere Application Server.</td>
        <td>Un nombre de directorio absoluto.</td>
    </tr>
    <tr>
        <td>user.appserver.was.profile</td>
        <td>${user.appserver.selection2} == was</td>
        <td>Perfil en el que se van a instalar las aplicaciones. Para WebSphere Application Server Network Deployment, especifique el perfil de Deployment Manager. Liberty significa el perfil de Liberty (subdirectorio wlp).</td>
        <td>El nombre de uno de los perfiles de WebSphere Application Server.</td>
    </tr>
    <tr>
        <td>user.appserver.was.cell</td>
        <td>${user.appserver.selection2} == was && ${user.appserver.was.profile} != Liberty</td>
        <td>Célula de WebSphere Application Server en la que se van a instalar las aplicaciones.</td>
        <td>El nombre de la célula de WebSphere Application Server.</td>
    </tr>
    <tr>
        <td>user.appserver.was.node</td>
        <td>${user.appserver.selection2} == was && ${user.appserver.was.profile} != Liberty</td>
        <td>Nodo de WebSphere Application Server en el que se van a instalar las aplicaciones. Se corresponde con la máquina actual.</td>
        <td>El nombre del nodo de WebSphere Application Server de la máquina actual.</td>
    </tr>
    <tr>
        <td>user.appserver.was.scope</td>
        <td>${user.appserver.selection2} == was && ${user.appserver.was.profile} != Liberty</td>
        <td>Tipo de granja de servidores en el que se instalan las aplicaciones.<br/><br/><code>server</code> significa un servidor autónomo.<br/><br/><code>nd-cell</code> significa una célula de WebSphere Application Server Network Deployment. <code>nd-cluster</code> significa un clúster de WebSphere Application Server Network Deployment.<br/><br/><code>nd-node</code> significa un nodo de WebSphere Application Server Network Deployment (excluyendo clústeres).<br/><br/><code>nd-server</code> significa un servidor gestionado de WebSphere Application Server Network Deployment.</td>
        <td><code>server</code>, <code>nd-cell</code>, <code>nd-cluster</code>, <code>nd-node</code>, <code>nd-server</code></td>
    </tr>
    <tr>
      <td>user.appserver.was.serverInstance</td>
      <td>${user.appserver.selection2} == was && ${user.appserver.was.profile} != Liberty && ${user.appserver.was.scope} == server</td>
      <td>Nombre del servidor WebSphere Application Server en el que se van a instalar las aplicaciones.</td>
      <td>El nombre de un servidor WebSphere Application Server en la máquina actual.</td>
    </tr>
    <tr>
      <td>user.appserver.was.nd.cluster</td>
      <td>${user.appserver.selection2} == was && ${user.appserver.was.profile} != Liberty && ${user.appserver.was.scope} == nd-cluster</td>
      <td>Nombre del clúster de WebSphere Application Server Network Deployment en el que se van a instalar las aplicaciones.</td>
      <td>El nombre de un clúster de WebSphere Application Server Network Deployment en la célula de WebSphere Application Server.</td>
    </tr>
    <tr>
      <td>user.appserver.was.nd.node</td>
      <td>${user.appserver.selection2} == was && ${user.appserver.was.profile} != Liberty && (${user.appserver.was.scope} == nd-node || ${user.appserver.was.scope} == nd-server)</td>
      <td>Nombre del nodo de WebSphere Application Server Network Deployment en el que se van a instalar las aplicaciones.</td>
      <td>El nombre de un nodo de WebSphere Application Server Network Deployment en la célula de WebSphere Application Server.</td>
    </tr>
    <tr>
      <td>user.appserver.was.nd.server</td>
      <td>${user.appserver.selection2} == was && ${user.appserver.was.profile} != Liberty && ${user.appserver.was.scope} == nd-server</td>
      <td>Nombre del servidor de WebSphere Application Server Network Deployment en el que se van a instalar las aplicaciones.</td>
      <td>El nombre de un servidor de WebSphere Application Server Network Deployment en el nodo proporcionado de WebSphere Application Server Network Deployment.</td>
    </tr>
    <tr>
      <td>user.appserver.was.admin.name</td>
      <td>${user.appserver.selection2} == was && ${user.appserver.was.profile} != Liberty</td>
      <td>Nombre del administrador de WebSphere Application Server.</td>
      <td></td>
    </tr>
    <tr>
      <td>user.appserver.was.admin.password2</td>
      <td>${user.appserver.selection2} == was && ${user.appserver.was.profile} != Liberty</td>
      <td>Contraseña del administrador de WebSphere Application Server, opcionalmente cifrada de una forma específica.</td>
      <td></td>
    </tr>
    <tr>
      <td>user.appserver.was.appcenteradmin.password</td>
      <td>${user.appserver.selection2} == was && ${user.appserver.was.profile} != Liberty</td>
      <td>Contraseña del usuario <code>appcenteradmin</code> para añadir a la lista de usuarios de WebSphere Application Server, opcionalmente cifrada de una forma específica.</td>
      <td></td>
    </tr>
    <tr>
      <td>user.appserver.was.serial</td>
      <td>${user.appserver.selection2} == was && ${user.appserver.was.profile} != Liberty</td>
      <td>Sufijo que distingue las aplicaciones que se van a instalar desde otras instalaciones de {{ site.data.keys.mf_server }}.</td>
      <td>Serie de 10 dígitos decimales.</td>
    </tr>
    <tr>
      <td>user.appserver.was85liberty.serverInstance_</td>
      <td>${user.appserver.selection2} == was && ${user.appserver.was.profile} == Liberty</td>
      <td>Nombre del servidor de WebSphere Application Server Liberty en el que se van a instalar las aplicaciones.</td>
      <td></td>
    </tr>
    <tr>
      <td>user.appserver.tomcat.installdir</td>
      <td>${user.appserver.selection2} == tomcat</td>
      <td>Directorio de instalación de Apache Tomcat. Para una instalación de Tomcat que se divida entre un directorio <b>CATALINA_HOME</b> y un directorio <b>CATALINA_BASE</b>, debe especificar el valor de la variable de entorno <b>CATALINA_BASE</b>.</td>
      <td>Un nombre de directorio absoluto.</td>
    </tr>
    <tr>
      <td>user.database.selection2</td>
      <td>Siempre</td>
      <td>Tipo de sistema de gestión de bases de datos utilizado para almacenar las bases de datos.</td>
      <td><code>derby</code>, <code>db2</code>, <code>mysql</code>, <code>oracle</code>, <code>none</code>. El valor none significa que el instalador no instalará Application Center. Si se utiliza este valor, tanto <b>user.appserver.selection2</b> como <b>user.database.selection2</b> deben adoptar el valor none.</td>
    </tr>
    <tr>
      <td>user.database.preinstalled</td>
      <td>Siempre</td>
      <td><code>true</code> significa un sistema de gestión de bases de datos preinstalado, <code>false</code> significa que se instalará Apache Derby.</td>
      <td><code>true</code>, <code>false</code></td>
    </tr>
    <tr>
      <td>user.database.derby.datadir</td>
      <td>${user.database.selection2} == derby</td>
      <td>El directorio en el que se crearán o asumirán las bases de datos Derby.</td>
      <td>Un nombre de directorio absoluto.</td>
    </tr>
    <tr>
      <td>user.database.db2.host</td>
      <td>${user.database.selection2} == db2</td>
      <td>El nombre de host o la dirección IP del servidor de base de datos DB2.</td>
      <td></td>
    </tr>
    <tr>
      <td>user.database.db2.port</td>
      <td>${user.database.selection2} == db2</td>
      <td>El puerto donde el servidor de bases de datos DB2 está a la escucha de conexiones JDBC. Normalmente 50000.</td>
      <td>Un número entre 1 y 65535.</td>
    </tr>
    <tr>
      <td>user.database.db2.driver</td>
      <td>${user.database.selection2} == db2</td>
      <td>El nombre de archivo absoluto de db2jcc4.jar.</td>
      <td>Un nombre de archivo absoluto.</td>
    </tr>
    <tr>
      <td>user.database.db2.appcenter.username</td>
      <td>${user.database.selection2} == db2</td>
      <td>El nombre de usuario utilizado para acceder a la base de datos DB2 para Application Center.</td>
      <td>No vacío.</td>
    </tr>
    <tr>
      <td>user.database.db2.appcenter.password</td>
      <td>${user.database.selection2} == db2</td>
      <td>La contraseña utilizada para acceder a la base de datos DB2 para Application Center, opcionalmente cifrada de una forma específica.</td>
      <td>Contraseña no vacía.</td>
    </tr>
    <tr>
      <td>user.database.db2.appcenter.dbname</td>
      <td>${user.database.selection2} == db2</td>
      <td>El nombre de la base de datos DB2 para Application Center.</td>
      <td>No vacía; un nombre de base de datos DB2 válido.</td>
    </tr>
    <tr>
      <td>user.database.oracle.appcenter.isservicename.jdbc.url</td>
      <td>Opcional</td>
      <td>Indica si <b>user.database.mysql.appcenter.dbname</b> es un nombre de Servicio o un nombre de SID. Si el parámetro no está presente, entonces <b>user.database.mysql.appcenter.dbname</b> se considerará como un nombre de SID.</td>
      <td><code>true</code> (indica un nombre de Servicio) o <code>false</code> (indica un nombre de SID)</td>
    </tr>
    <tr>
      <td>user.database.db2.appcenter.schema</td>
      <td>${user.database.selection2} == db2</td>
      <td>El nombre del esquema para Application Center en la base de datos DB2.</td>
      <td></td>
    </tr>
    <tr>
      <td>user.database.mysql.host</td>
      <td>${user.database.selection2} == mysql</td>
      <td>El nombre de host o dirección IP del servidor de base de datos MySQL.</td>
      <td></td>
    </tr>
    <tr>
      <td>user.database.mysql.port</td>
      <td>${user.database.selection2} == mysql</td>
      <td>El puerto donde el servidor de base de datos MySQL está a la escucha de conexiones JDBC. Normalmente 3306.</td>
      <td>Un número entre 1 y 65535.</td>
    </tr>
    <tr>
      <td>user.database.mysql.driver</td>
      <td>${user.database.selection2} == mysql</td>
      <td>El nombre de archivo absoluto de <b>mysql-connector-java-5.*-bin.jar</b>.</td>
      <td>Un nombre de archivo absoluto.</td>
    </tr>
    <tr>
      <td>user.database.mysql.appcenter.username</td>
      <td>${user.database.selection2} == oracle</td>
      <td>El nombre de usuario utilizado para acceder a la base de datos Oracle para Application Center.</td>
      <td>Una serie que consta de 1 a 30 caracteres: se permiten dígitos en ASCII, letras en mayúscula y minúscula en ASCII, '_', '#' y '$'.</td>
    </tr>
    <tr>
      <td>user.database.mysql.appcenter.password</td>
      <td>${user.database.selection2} == oracle</td>
      <td>La contraseña utilizada para acceder a la base de datos Oracle para Application Center, opcionalmente cifrada de una forma específica.</td>
      <td>La contraseña debe ser una serie que consta de 1 a 30 caracteres: se permiten dígitos en ASCII, letras en mayúscula y minúscula en ASCII, '_', '#' y '$'.</td>
    </tr>
    <tr>
      <td>user.database.mysql.appcenter.dbname</td>
      <td>${user.database.selection2} == oracle, a menos que se especifique ${user.database.oracle.appcenter.jdbc.url}</td>
      <td>El nombre de la base de datos Oracle para Application Center.</td>
      <td>No vacío, un nombre de base de datos Oracle válido.</td>
    </tr>
    <tr>
      <td>user.database.oracle.host</td>
      <td>${user.database.selection2} == oracle, a menos que se especifique ${user.database.oracle.appcenter.jdbc.url}</td>
      <td>El nombre de host o dirección IP del servidor de base de datos Oracle.</td>
      <td></td>
    </tr>
    <tr>
      <td>user.database.oracle.port</td>
      <td>${user.database.selection2} == oracle, a menos que se especifique ${user.database.oracle.appcenter.jdbc.url}</td>
      <td>El puerto donde el servidor de base de datos Oracle está a la escucha de conexiones JDBC. Normalmente 1521.</td>
      <td>Un número entre 1 y 65535.</td>
    </tr>
    <tr>
      <td>user.database.oracle.driver</td>
      <td>${user.database.selection2} == oracle</td>
      <td>El nombre de archivo absoluto del archivo JAR del controlador ligero de Oracle. (<b>ojdbc6.jar o ojdbc7.jar</b>)</td>
      <td>Un nombre de archivo absoluto.</td>
    </tr>
    <tr>
      <td>user.database.oracle.appcenter.username</td>
      <td>${user.database.selection2} == oracle</td>
      <td>El nombre de usuario utilizado para acceder a la base de datos Oracle para Application Center.</td>
      <td>Una serie que consta de 1 a 30 caracteres: se permiten dígitos en ASCII, letras en mayúscula y minúscula en ASCII, '_', '#' y '$'.</td>
    </tr>
    <tr>
      <td>user.database.oracle.appcenter.username.jdbc</td>
      <td>	${user.database.selection2} == oracle</td>
      <td>El nombre de usuario utilizado para acceder a la base de datos Oracle para Application Center, en una sintaxis adecuada para JDBC.</td>
      <td>Igual que ${user.database.oracle.appcenter.username} si empieza por un carácter alfabético y no contiene caracteres en minúscula; de lo contrario, debe ser ${user.database.oracle.appcenter.username} rodeado por comillas dobles.</td>
    </tr>
    <tr>
      <td>user.database.oracle.appcenter.password</td>
      <td>${user.database.selection2} == oracle</td>
      <td>La contraseña utilizada para acceder a la base de datos Oracle para Application Center, opcionalmente cifrada de una forma específica.</td>
      <td>La contraseña debe ser una serie que consta de 1 a 30 caracteres: se permiten dígitos en ASCII, letras en mayúscula y minúscula en ASCII, '_', '#' y '$'.</td>
    </tr>
    <tr>
      <td>user.database.oracle.appcenter.dbname</td>
      <td>${user.database.selection2} == oracle, a menos que se especifique ${user.database.oracle.appcenter.jdbc.url}</td>
      <td>El nombre de la base de datos Oracle para Application Center.</td>
      <td>No vacío, un nombre de base de datos Oracle válido.
</td>
    </tr>
    <tr>
      <td>user.database.oracle.appcenter.isservicename.jdbc.url</td>
      <td>Opcional</td>
      <td>Indica si <code>user.database.oracle.appcenter.dbname</code> es un nombre de Servicio o un nombre de SID. Si el parámetro no está presente, entonces <code>user.database.oracle.appcenter.dbname</code> se considerará como un nombre de SID.</td>
      <td><code>true</code> (indica un nombre de Servicio) o <code>false</code> (indica un nombre de SID)</td>
    </tr>
    <tr>
      <td>user.database.oracle.appcenter.jdbc.url</td>
      <td>${user.database.selection2} == oracle, a menos que se especifique ${user.database.oracle.host}, ${user.database.oracle.port} y ${user.database.oracle.appcenter.dbname}</td>
      <td>El URL de JDBC de la base de datos Oracle para Application Center.</td>
      <td>Un URL de JDBC de Oracle válido. Empieza por "jdbc:oracle:".</td>
    </tr>
    <tr>
      <td>user.writable.data.user</td>
      <td>Siempre</td>
      <td>El usuario de sistema operativo al que se permite ejecutar el servidor instalado.</td>
      <td>Un nombre de usuario de sistema operativo, o vacío.</td>
    </tr>
    <tr>
      <td>user.writable.data.group2</td>
      <td>Siempre</td>
      <td>El grupo de usuarios del sistema operativo al que se permite ejecutar el servidor instalado.</td>
      <td>Un nombre de grupo de usuarios del sistema operativo, o vacío.</td>
    </tr>
</table>

## Estructura de distribución de {{ site.data.keys.mf_server }}
{: #distribution-structure-of-mobilefirst-server }
Los archivos y las herramientas de {{ site.data.keys.mf_server }} se instalan en el directorio de instalación de {{ site.data.keys.mf_server }}.

#### Archivos y subdirectorios del subdirectorio Analytics
{: #files-and-subdirectories-in-the-analytics-subdirectory }

| Elemento | Descripción |
|------|-------------|
| **analytics.ear** y **analytics-*.war** | Los archivos EAR y WAR para instalar {{ site.data.keys.mf_analytics }}. |
| **configuration-samples** | Contiene los archivos Ant de ejemplo para instalar {{ site.data.keys.mf_analytics }} con tareas Ant. |

#### Archivos y subdirectorios del subdirectorio ApplicationCenter
{: #files-and-subdirectories-in-the-applicationcenter-subdirectory }

| Elemento | Descripción |
|------|-------------|
| **configuration-samples** | Contiene los archivos Ant de ejemplo para instalar Application Center. Las tareas Ant crean la tabla de base de datos y despliegan los archivos WAR en un servidor de aplicaciones. |
| **console** | Contiene los archivos EAR y WAR para instalar Application Center. El archivo EAR es exclusivamente para IBM  PureApplication System. |
| **databases** | Contiene los scripts SQL que se van a utilizar para la creación manual de tablas para Application Center. |
| **installer** | Contiene los recursos para crear el cliente de Application Center. |
| **tools** | Las herramientas de Application Center. |

#### Archivos y subdirectorios del subdirectorio {{ site.data.keys.mf_server }}
{: #files-and-subdirectories-in-the-mobilefirst-server-subdirectory }

| Elemento | Descripción |
|------|-------------|
| **mfp-ant-deployer.jar** | Un conjunto de tareas Ant de {{ site.data.keys.mf_server }}. |
| **mfp-*.war** | Los archivos WAR de los componentes de {{ site.data.keys.mf_server }}. |
| **configuration-samples** | Contiene los archivos Ant de ejemplo para instalar los componentes de {{ site.data.keys.mf_server }} con tareas Ant. |
| **ConfigurationTool** | Contiene los archivos binarios de la Herramienta de configuración del servidor. La herramienta se inicia desde **dir_instal_servidor_mfp/shortcuts**. |
| **databases** | Contiene los scripts SQL que se van a utilizar para la creación manual de tablas para componentes de {{ site.data.keys.mf_server }} (servicio de administración de {{ site.data.keys.mf_server }}, servicio de configuración de {{ site.data.keys.mf_server }} y tiempo de ejecución de {{ site.data.keys.product_adj }}). |
| **external-server-libraries** |  Contiene los archivos JAR que utilizan distintas herramientas (como por ejemplo las herramientas de autenticidad y la herramienta de seguridad de OAuth). |

#### Archivos y subdirectorios del subdirectorio PushService
{: #files-and-subdirectories-in-the-pushservice-subdirectory }

| Elemento | Descripción |
|------|-------------|
| **mfp-push-service.war** | El archivo WAR para instalar el servicio de envío por push de {{ site.data.keys.mf_server }}. |
| **databases** | Contiene los scripts SQL que se van a utilizar para la creación manual de tablas para el servicio de envío por push de {{ site.data.keys.mf_server }}. |

#### Archivos y subdirectorios del subdirectorio License
{: #files-and-subdirectories-in-the-license-subdirectory }

| Elemento | Descripción |
|------|-------------|
| **Text** | Contiene la licencia para {{ site.data.keys.product }}. |

#### Archivos y subdirectorios del directorio de instalación de {{ site.data.keys.mf_server }}
{: #files-and-subdirectories-in-the-mobilefirst-server-installation-directory }

| Elemento | Descripción |
|------|-------------|
| **shortcuts** | Scripts de lanzador para Apache Ant, la Herramienta de configuración del servidor y el mandato mfpadmin, que se facilitan con {{ site.data.keys.mf_server }}. |

#### Archivos y subdirectorios del subdirectorio tools
{: #files-and-subdirectories-in-the-tools-subdirectory }

| Elemento | Descripción |
|------|-------------|
| **tools/apache-ant-version-number** | Una instalación binaria de Apache Ant que utiliza la Herramienta de configuración del servidor. También se puede utilizar para ejecutar las tareas Ant. |
