---
layout: tutorial
title: Referencia de instalación
weight: 9
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
La información de referencia sobre tareas Ant y archivos de ejemplo de configuración para la instalación de {{ site.data.keys.mf_server_full }}, {{ site.data.keys.mf_app_center_full }} y {{ site.data.keys.mf_analytics_full }}.

#### Ir a
{: #jump-to }
* [Referencia de tarea configuredatabase Ant](#ant-configuredatabase-task-reference)
* [Tareas Ant para la instalación de {{ site.data.keys.mf_console }}, artefactos de {{ site.data.keys.mf_server }}, administración de {{ site.data.keys.mf_server }} y servicios de Live Update](#ant-tasks-for-installation-of-mobilefirst-operations-console-mobilefirst-server-artifacts-mobilefirst-server-administration-and-live-update-services)
* [Tareas Ant para la instalación del servicio de envío por push de {{ site.data.keys.mf_server }}](#ant-tasks-for-installation-of-mobilefirst-server-push-service)
* [Tareas Ant para la instalación de entornos de ejecución de {{ site.data.keys.product_adj }}](#ant-tasks-for-installation-of-mobilefirst-runtime-environments)
* [Tareas Ant para la instalación de Application Center](#ant-tasks-for-installation-of-application-center)
* [Tareas Ant para la instalación de {{ site.data.keys.mf_analytics }}](#ant-tasks-for-installation-of-mobilefirst-analytics)
* [Bases de datos de tiempo de ejecución internas](#internal-runtime-databases)
* [Archivos de configuración de ejemplo](#list-of-sample-configuration-files)
* [Archivos de configuración de ejemplo para {{ site.data.keys.mf_analytics }}](#sample-configuration-files-for-mobilefirst-analytics)

## Referencia de tarea configuredatabase Ant
{: #ant-configuredatabase-task-reference }
Información de referencia para la tarea Ant configuredatabase. Esta información de referencia es sólo para bases de datos relacionales. No se aplica a Cloudant.

La tarea Ant **configuredatabase** crea las bases de datos relacionales que utiliza el servicio de administración de {{ site.data.keys.mf_server }}, el servicio de Live Update de {{ site.data.keys.mf_server }}, el servicio de envío por push de {{ site.data.keys.mf_server }}, el tiempo de ejecución de {{ site.data.keys.product_adj }} y los servicios de Application Center. Esta tarea Ant configura una base de datos relacional a través de las siguientes acciones:

* Comprueba si existen las tablas de {{ site.data.keys.product_adj }} y las crea si es necesario.
* Si las tablas existen para una versión posterior de {{ site.data.keys.product }}, las migra a la versión actual.
* Si las tablas existen para la versión actual de {{ site.data.keys.product }}, no haga nada.

Además, si se cumple una de las condiciones siguientes:

* El tipo de DBMS será Derby.
* Habrá presente un elemento interno `<dba>`.
* El tipo de DBMS será DB2, y el usuario especificado tendrá los permisos para crear bases de datos.

A continuación, la tarea puede tener los efectos siguientes:

* Cree la base de datos si es necesario (excepto para Oracle 12c y Cloudant).
* Cree un usuario, si es necesario, y otórguele derechos de acceso a la base de datos.

> **Nota:** La tarea Ant configuredatabase no tendrá ningún efecto si la utiliza con Cloudant.

### Atributos y elementos para la tarea configuredatabase
{: #attributes-and-elements-for-configuredatabase-task }

La tarea **configuredatabase** tiene los atributos siguientes:

| Atributo | Descripción | Obligatorio | Predeterminado |
|-----------|-------------|----------|---------|
| kind      | El tipo de base de datos: En {{ site.data.keys.mf_server }}: MobileFirstRuntime, MobileFirstConfig, MobileFirstAdmin, o push. En Application Center: ApplicationCenter. | Sí | Ninguno |
| includeConfigurationTables | Para especificar si se van a realizar operaciones de base de datos en el servicio de Live Update y en el servicio de administración o sólo en el servicio de administración. El valor puede ser true o false. |  No | true |
| execute | Para especificar si se debe ejecutar la tarea Ant configuredatabase. El valor puede ser true o false. | No | true |

#### kind
{: #kind }
{{ site.data.keys.product }} da soporte a cuatro tipos de bases de datos: el tiempo de ejecución de {{ site.data.keys.product_adj }} utiliza la base de datos **MobileFirstRuntime**. El servicio de administración de {{ site.data.keys.mf_server }} utiliza la base de datos **MobileFirstAdmin**. El servicio de Live Update de {{ site.data.keys.mf_server }} utiliza la base de datos **MobileFirstConfig**. De forma predeterminada, se crea con el tipo **MobileFirstAdmin**. El servicio de envío por push de {{ site.data.keys.mf_server }} utiliza la base de datos **push**. Application Center utiliza la base de datos **ApplicationCenter**.

#### includeConfigurationTables
{: #includeconfigurationtables }
El atributo **includeConfigurationTables** sólo se puede utilizar cuando el atributo **kind** sea **MobileFirstAdmin**. El valor válido puede ser true o false. Cuando este atributo se establezca en true, la tarea **configuredatabase** realizará operaciones de base de datos en la base de datos de servicio de administración y en la base de datos de servicio de Live Update en una única ejecución. Cuando este atributo se establezca en false, la tarea **configuredatabase** realizará operaciones de base de datos sólo en la base de datos del servicio de administración.

#### execute
{: #execute }
El atributo **execute** habilita o inhabilita la ejecución de la tarea Ant **configuredatabase**. El valor válido puede ser true o false. Cuando este atributo se establezca en false, la tarea **configuredatabase** no realizará ninguna operación de configuración ni de base de datos.

La tarea **configuredatabase** da soporte a los siguientes elementos:

| Elemento             | Descripción	                | Recuento |
|---------------------|-----------------------------|-------|
| `<derby>`           | Los parámetros para Derby.   | 0..1  |
| `<db2>`             |	Los parámetros para DB2.     | 0..1  |
| `<mysql>`           |	Los parámetros para MySQL.   | 0..1  |
| `<oracle>`          |	Los parámetros para Oracle.  | 0..1  |
| `<driverclasspath>` | La vía de acceso de clase de controlador JDBC. | 0..1  |

Para cada tipo de base de datos, puede utilizar un elemento `<property>` para especificar una propiedad de conexión JDBC para acceder a la base de datos. El elemento `<property>` tiene los atributos siguientes:

| Atributo | Descripción                | Obligatorio | Predeterminado |
|-----------|----------------------------|----------|---------|
| name      | El nombre de la propiedad.	 | Sí      | Ninguno    |
| value	    | El valor de la propiedad.| Sí	    | Ninguno    |   

#### Apache Derby
{: #apache-derby }
El elemento `<derby>` tiene los atributos siguientes:

| Atributo | Descripción                                | Obligatorio | Predeterminado                                                                      |
|-----------|--------------------------------------------|----------|------------------------------------------------------------------------------|
| database  | El nombre de la base de datos.                         | No	    | MFPDATA, MFPADM, MFPCFG, MFPPUSH, o APPCNTR, dependiendo del tipo.             |
| datadir   | El directorio que contiene las bases de datos. | Sí      | Ninguno                                                                         |
| schema	| El nombre de esquema.                           | No       | MFPDATA, MFPCFG, MFPADMINISTRATOR, MFPPUSH, o APPCENTER, dependiendo del tipo. |

El elemento `<derby>` da soporte al elemento siguiente:

| Elemento      | Descripción                     | Recuento   |
|--------------|---------------------------------|---------|
| `<property>` | La propiedad de conexión JDBC.   | 0..∞    |

Para ver las propiedades disponibles, consulte [Configuración de atributos para el URL de conexión de base de datos](http://db.apache.org/derby/docs/10.11/ref/rrefattrib24612.html).

#### DB2
{: #db2 }
El elemento `<db2>` tiene los atributos siguientes:

| Atributo | Descripción                            | Obligatorio | Predeterminado |
|-----------|----------------------------------------|----------|---------|
| database  | El nombre de la base de datos.                     | No       | MFPDATA, MFPADM, MFPCFG, MFPPUSH, o APPCNTR, dependiendo del tipo. |
| server    | El nombre de host del servidor de bases de datos.	 | Sí      | Ninguno  |
| port      | El puerto en el servidor de bases de datos.       | No	    | 50000 |
| user      | El nombre de usuario para acceder a las bases de datos. | Sí	    | Ninguno  |
| password  | La contraseña para acceder a las bases de datos.	 | No	    | Consultado de forma interactiva |
| instance  | El nombre de la instancia de DB2.          | No	    | Depende del servidor |
| schema    | El nombre de esquema.                       | No	    | Depende del usuario   |

Para obtener más información sobre las cuentas de usuario de DB2, consulte [Visión general del modelo de seguridad de DB2](http://ibm.biz/knowctr#SSEPGG_10.1.0/com.ibm.db2.luw.admin.sec.doc/doc/c0021804.html).  
El elemento `<db2>` da soporte a los elementos siguientes:

| Elemento      | Descripción                             | Recuento   |
|--------------|-----------------------------------------|---------|
| `<property>` | La propiedad de conexión JDBC.           | 0..∞    |
| `<dba>`      | Las credenciales del administrador de bases de datos. | 0..1    |

Para ver las propiedades disponibles, consulte [Propiedades para IBM Data Server Driver for JDBC and SQLJ](http://ibm.biz/knowctr#SSEPGG_10.1.0/com.ibm.db2.luw.apdv.java.doc/src/tpc/imjcc_rjvdsprp.html).  
El elemento interno `<dba>` especifica las credenciales para los administradores de bases de datos. Este elemento tiene los siguientes atributos:

| Atributo | Descripción                            | Obligatorio | Predeterminado |
|-----------|----------------------------------------|----------|---------|
| user      | El nombre de usuario para acceder a la base de datos.  | Sí      | Ninguno    |
| password  | La contraseña para acceder a la base de datos.    | No	    | Consultado de forma interactiva |

El usuario que se especifica en un elemento `<dba>` debe tener el privilegio de DB2 SYSADM o SYSCTRL. Para obtener más información, consulte [Visión general de Autorizaciones](http://ibm.biz/knowctr#SSEPGG_10.1.0/com.ibm.db2.luw.admin.sec.doc/doc/c0055206.html).

El elemento `<driverclasspath>` debe contener los archivos JAR para el controlador de DB2 JDBC y para la licencia asociada. Puede recuperar estos archivos de una de las siguientes formas:

* Descargue los controladores DB2 JDBC desde la página [DB2 JDBC Driver Versions](http://www.ibm.com/support/docview.wss?uid=swg21363866)
* O capte el archivo **db2jcc4.jar** y sus archivos **db2jcc_license_*.jar** asociados desde el directorio **DB2_INSTALL_DIR/java** del servidor de DB2.

No puede especificar detalles de las asignaciones de tabla, como por ejemplo el espacio de tabla, utilizando la tarea Ant. Para controlar el espacio de tabla, debe utilizar las instrucciones manuales en la sección [Base de datos DB2 y requisitos de usuario](../databases/#db2-database-and-user-requirements).

#### MySQL
{: #mysql }
El elemento `<mysql>` tiene los siguientes atributos:

| Atributo | Descripción                            | Obligatorio | Predeterminado |
|-----------|----------------------------------------|----------|---------|
| database	| El nombre de la base de datos.	                 | No       | MFPDATA, MFPADM, MFPCFG, MFPPUSH, o APPCNTR, dependiendo del tipo. |
| server	| El nombre de host del servidor de bases de datos.	 | Sí	    | Ninguno |
| port	    | El puerto en el servidor de bases de datos.	     | No	    | 3306 |
| user	    | El nombre de usuario para acceder a las bases de datos. | Sí	    | Ninguno |
| password	| La contraseña para acceder a las bases de datos.	 | No	    | Consultado de forma interactiva |

Para obtener más información sobre las cuentas de usuario de MySQL, consulte [MySQL User Account Management](http://dev.mysql.com/doc/refman/5.5/en/user-account-management.html).  
El elemento `<mysql>` da soporte a los elementos siguientes:

| Elemento      | Descripción                                      | Recuento |
|--------------|--------------------------------------------------|-------|
| `<property>` | La propiedad de conexión JDBC.                    | 0..∞  |
| `<dba>`      | Las credenciales del administrador de bases de datos.          | 0..1  |
| `<client>`   | El host que está autorizado a acceder a la base de datos. | 0..∞  |

Para las propiedades disponibles, consulte [Driver/Datasource Class Names, URL Syntax and Configuration Properties for Connector/J](http://dev.mysql.com/doc/connector-j/en/connector-j-reference-configuration-properties.html).  
El elemento interno `<dba>` especifica las credenciales del administrador de bases de datos. Este elemento tiene los siguientes atributos:

| Atributo | Descripción                            | Obligatorio | Predeterminado |
|-----------|----------------------------------------|----------|---------|
| user	    | El nombre de usuario para acceder a las bases de datos. | Sí	    | Ninguno |
| password	| La contraseña para acceder a las bases de datos.	 | No	    | Consultado de forma interactiva |

El usuario que se especifica en un elemento `<dba>` debe ser una cuenta de superusuario de MySQL. Para obtener más información, consulte [Protección de cuentas iniciales de MySQL](http://dev.mysql.com/doc/refman/5.5/en/default-privileges.html).

Cada elemento interno de `<client>` especifica un sistema del cliente o un comodín para los sistemas cliente. Estos sistemas tienen permiso para conectarse a la base de datos. Este elemento tiene los siguientes atributos:

| Atributo | Descripción                                                              | Obligatorio | Predeterminado |
|-----------|--------------------------------------------------------------------------|----------|---------|
| hostname	| El nombre de host simbólico, dirección IP, o plantilla con % como marcador. | Sí	  | Ninguno    |

Para obtener más información sobre la sintaxis del nombre de host, consulte [Cómo especificar nombres de cuenta](http://dev.mysql.com/doc/refman/5.5/en/account-names.html).

El elemento `<driverclasspath>` debe contener un archivo JAR de MySQL Connector/J. Puede descargar dicho archivo desde la página [Download Connector/J](http://www.mysql.com/downloads/connector/j/).

Como alternativa, puede utilizar el elemento `<mysql>` con los atributos siguientes:

| Atributo | Descripción                            | Obligatorio | Predeterminado               |
|-----------|----------------------------------------|----------|-----------------------|
| url       | El URL de conexión de base de datos.	         | Sí      | Ninguno                  |
| user	    | El nombre de usuario para acceder a las bases de datos. | Sí      | Ninguno                  |
| password	| La contraseña para acceder a las bases de datos.	 | No       | Consultado de forma interactiva |

> `Nota:` Si especifica la base de datos con atributos alternativos, esta base de datos debe existir, la cuenta de usuario debe existir, y la base de datos ya debe estar accesible para el usuario. En este caso, la tarea **configuredatabase** no intentará crear la base de datos ni el usuario, ni intentará otorgar acceso al usuario. La tarea **configuredatabase** sólo garantiza que la base de datos tenga las tablas necesarias para la versión actual de {{ site.data.keys.mf_server }}. No tiene que especificar los elementos internos `<dba>` ni `<client>`.

#### Oracle
{: #oracle }
El elemento `<oracle>` tiene los siguientes atributos:

| Atributo      | Descripción                                                              | Obligatorio | Predeterminado |
|----------------|--------------------------------------------------------------------------|----------|---------|
| database       | El nombre de base de datos, o el nombre de servicio de Oracle. **Nota:** Siempre debe utilizar un nombre de servicio para conectarse a una base de datos PDB. | No | ORCL |
| server	     | El nombre de host del servidor de bases de datos.                                    | Sí      | Ninguno |
| port	         | El puerto en el servidor de bases de datos.                                         | No       | 1521 |
| user	         | El nombre de usuario para acceder a las bases de datos. Consulte la nota bajo esta tabla.	| Sí      | Ninguno |
| password	     | La contraseña para acceder a las bases de datos.                                    | No       | Consultado de forma interactiva |
| sysPassword	 | La contraseña para el usuario SYS.                                           | No       | Consultado de forma interactiva si la base de datos no existe aún |
| systemPassword | La contraseña para el usuario SYSTEM.                                        | No       | Consultado de forma interactiva si la base de datos o el usuario no existe aún |

> `Nota:` Para el atributo de usuario, utilice preferiblemente un nombre de usuario en letras mayúsculas. Los nombres de usuario de Oracle están generalmente en letras mayúsculas. A diferencia de otras herramientas de base de datos, la tarea Ant **configuredatabase** no convierte las letras en minúscula en letras en mayúscula en el nombre de usuario. Si la tarea Ant **configuredatabase** no consigue conectarse a la base de datos, intente escribir el valor para el atributo **user** en letras mayúsculas.
Para obtener más información sobre las cuentas de usuario de Oracle, consulte [Visión general de métodos de autenticación](http://docs.oracle.com/cd/B28359_01/server.111/b28318/security.htm#i12374).  
El elemento `<oracle>` da soporte a los elementos siguientes:

| Elemento      | Descripción                                      | Recuento |
|--------------|--------------------------------------------------|-------|
| `<property>` | La propiedad de conexión JDBC.                    | 0..∞  |
| `<dba>`      | Las credenciales del administrador de bases de datos.          | 0..1  |

Para obtener información sobre las propiedades de conexión disponibles, consulte [Clase OracleDriver](http://docs.oracle.com/cd/E11882_01/appdev.112/e13995/oracle/jdbc/OracleDriver.html).  
El elemento interno `<dba>` especifica las credenciales del administrador de bases de datos. Este elemento tiene los siguientes atributos:

| Atributo      | Descripción                                                              | Obligatorio | Predeterminado |
|----------------|--------------------------------------------------------------------------|----------|---------|
| user	         | El nombre de usuario para acceder a las bases de datos. Consulte la nota bajo esta tabla.	| Sí      | Ninguno    |
| password	     | La contraseña para acceder a las bases de datos.                                    | No       | Consultado de forma interactiva |

El elemento `<driverclasspath>` debe contener un archivo JAR del controlador JDBC de Oracle. Puede descargar los controladores JDBC de Oracle desde [JDBC, SQLJ, Oracle JPublisher y Universal Connection Pool (UCP)](http://www.oracle.com/technetwork/database/features/jdbc/index-091264.html).

No puede especificar detalles de asignación de tabla, como por ejemplo el espacio de tabla, utilizando la tarea Ant. Para controlar el espacio de tabla, puede crear la cuenta de usuario manualmente y asignarle un espacio de tabla predeterminado antes de ejecutar la tarea Ant. Para controlar otros detalles, debe utilizar las instrucciones manuales de la sección [Base de datos Oracle y requisitos de usuario](../databases/#oracle-database-and-user-requirements).

| Atributo | Descripción                            | Obligatorio | Predeterminado               |
|-----------|----------------------------------------|----------|-----------------------|
| url       | El URL de conexión de base de datos.	         | Sí      | Ninguno                  |
| user	    | El nombre de usuario para acceder a las bases de datos. | Sí      | Ninguno                  |
| password	| La contraseña para acceder a las bases de datos.	 | No       | Consultado de forma interactiva |

> **Nota:** Si especifica la base de datos con atributos alternativos, esta base de datos debe existir, la cuenta de usuario debe existir, y la base de datos ya debe estar accesible para el usuario. En este caso, la tarea no intentará crear la base de datos ni el usuario, ni intentará otorgar acceso al usuario. La tarea **configuredatabase** sólo garantiza que la base de datos tenga las tablas necesarias para la versión actual de {{ site.data.keys.mf_server }}. No tiene que especificar el elemento interno `<dba>`.

## Tareas Ant para la instalación de artefactos de {{ site.data.keys.mf_console }}, {{ site.data.keys.mf_server }}, administración de {{ site.data.keys.mf_server }} y servicios de Live Update
{: #ant-tasks-for-installation-of-mobilefirst-operations-console-mobilefirst-server-artifacts-mobilefirst-server-administration-and-live-update-services }
Las tareas Ant **installmobilefirstadmin**, **updatemobilefirstadmin**, y **uninstallmobilefirstadmin** se proporcionan para la instalación de {{ site.data.keys.mf_console }}, el componente de artefactos, el servicio de administración y el servicio de Live Update.

### Efectos de tareas
{: #task-effects }

#### installmobilefirstadmin
{: #installmobilefirstadmin }
La tarea Ant **installmobilefirstadmin** configura un servidor de aplicaciones para ejecutar los archivos WAR de la administración y los servicios de Live Update como aplicaciones web y, opcionalmente, para instalar {{ site.data.keys.mf_console }}. Esta tarea tiene los siguientes efectos:

* Declara la aplicación web del servicio de administración en la raíz de contexto especificada, de forma predeterminada /mfpadmin.
* Declara la aplicación web del servicio de Live Update en una raíz de contexto derivada de la raíz de contexto especificada del servicio de administración. De forma predeterminada, /mfpadminconfig.
* Para las bases de datos relacionales, declara orígenes de datos y en el perfil completo de WebSphere Application Server, proveedores JDBC para los servicios de administración.
* Despliega el servicio de administración y el servicio de Live Update en el servidor de aplicaciones.
* Opcionalmente, declara {{ site.data.keys.mf_console }} como una aplicación web en la raíz de contexto especificada, de forma predeterminada /mfpconsole. Si se especifica la instancia de {{ site.data.keys.mf_console }}, la tarea Ant declara la entrada de entorno JNDI apropiada para comunicarse con el servicio de gestión correspondiente. Por ejemplo,

```xml
<target name="adminstall">
  <installmobilefirstadmin servicewar="${mfp.service.war.file}">
    <console install="${mfp.admin.console.install}" warFile="${mfp.console.war.file}"/>
```

* Opcionalmente, declara la aplicación web de artefactos de {{ site.data.keys.mf_server }} en la raíz de contexto especificada /mfp-dev-artifacts cuando se instala {{ site.data.keys.mf_console }}.
* Configura las propiedades de configuración para el servicio de administración utilizando entradas de entorno JNDI. Estas entradas de entorno JNDI también dan alguna información adicional sobre la topología del servidor de aplicaciones, por ejemplo si la topología es una configuración autónoma, un clúster, o una granja de servidores.
* Opcionalmente, configura usuarios que correlaciona con roles utilizados por {{ site.data.keys.mf_console }}, y la administración y las aplicaciones web de servicios de Live Update.
* Configura el servidor de aplicaciones para el uso de JMX.
* Opcionalmente, configura la comunicación con el servicio de envío por push de {{ site.data.keys.mf_server }}.
* Opcionalmente, establece las entradas de entorno JNDI de MobileFirst para configurar el servidor de aplicaciones como un miembro de la granja de servidores para el componente de administración de {{ site.data.keys.mf_server }}.

#### updatemobilefirstadmin
{: #updatemobilefirstadmin }
La tarea Ant **updatemobilefirstadmin** actualiza una aplicación web {{ site.data.keys.mf_server }} ya configurada en un servidor de aplicaciones. Esta tarea tiene los siguientes efectos:

* Actualiza el archivo WAR del servicio de administración. Este archivo debe tener el mismo nombre base que el archivo WAR correspondiente desplegado anteriormente.
* Actualiza el archivo WAR del servicio de Live Update. Este archivo debe tener el mismo nombre base que el archivo WAR correspondiente desplegado anteriormente.
* Actualiza el archivo WAR de {{ site.data.keys.mf_console }}. Este archivo debe tener el mismo nombre base que el archivo WAR correspondiente desplegado anteriormente.
La tarea no cambia la configuración del servidor de aplicaciones, es decir, la configuración de la aplicación web, los orígenes de datos, las entradas de entorno JNDI, las correlaciones de usuario a rol ni la configuración de JMX.

#### uninstallmobilefirstadmin
{: #uninstallmobilefirstadmin }
La tarea Ant **uninstallmobilefirstadmin** deshace los efectos de una ejecución anterior de installmobilefirstadmin. Esta tarea tiene los siguientes efectos:

* Elimina la configuración de la aplicación web del servicio de administración con la raíz de contexto especificada. Como consecuencia, la tarea también elimina los valores que se han añadido manualmente a dicha aplicación.
* Elimina los archivos WAR de la administración y de los servicios de Live Update, y {{ site.data.keys.mf_console }} desde el servidor de aplicaciones como una opción.
* Para el DBMS relacional, elimina los orígenes de datos y en el perfil completo de WebSphere Application Server los proveedores JDBC para la administración y los servicios de Live Update.
* Para el DBMS relacional, elimina los controladores de base de datos que utilizaron la administración y los servicios de Live Update desde el servidor de aplicaciones.
* Elimina las entradas de entorno JNDI asociadas.
* En WebSphere Application Server Liberty y Apache Tomcat, elimina los usuarios configurados por la invocación de installmobilefirstadmin.
* Elimina la configuración de JMX.

### Atributos y elementos
{: #attributes-and-elements }
Las tareas Ant **installmobilefirstadmin**, **updatemobilefirstadmin**, y **uninstallmobilefirstadmin** tienen los atributos siguientes:

| Atributo         | Descripción                                                              | Obligatorio | Predeterminado |
|-------------------|--------------------------------------------------------------------------|----------|---------|
| contextroot       | El prefijo común para URL en el servicio de administración para obtener información sobre los entornos de tiempo de ejecución, las aplicaciones y los adaptadores de {{ site.data.keys.product_adj }}. | No | /mfpadmin |
| id                | Para distinguir los distintos despliegues.              | No | Vacío |
| environmentId     | Para distinguir los distintos entornos de {{ site.data.keys.product_adj }}. | No | Vacío |
| servicewar        | El archivo WAR para el servicio de administración.       | No | El archivo mfp-admin-service.war se encuentra en el mismo directorio que el archivo mfp-ant-deployer.jar. |
| shortcutsDir      | El directorio donde se colocarán los atajos.            | No | Ninguno |
| wasStartingWeight | El orden de inicio para WebSphere Application Server. Los valores inferiores comenzarán en primer lugar. | No | 1 |

#### contextroot e id
{: #contextroot-and-id }
Los atributos **contextroot** e **id** distinguen los diferentes despliegues de {{ site.data.keys.mf_console }} y el servicio de administración.

En los perfiles de WebSphere Application Server Liberty y en los entornos de Tomcat, el parámetro contextroot es suficiente para esta finalidad. En los entornos de perfil completo de WebSphere Application Server, se utilizará el atributo id en su lugar. Sin este atributo id, pueden entrar en conflicto dos archivos WAR con las mismas raíces de contexto y es posible que estos archivos no se desplieguen.

#### environmentId
{: #environmentid }
Utilice el atributo **environmentId** para distinguir varios entornos, cada uno de los cuales consta del servicio de administración de {{ site.data.keys.mf_server }} y de las aplicaciones web de tiempo de ejecución de {{ site.data.keys.product_adj }}, que deben funcionar independientemente. Por ejemplo, con esta opción puede alojar un entorno de prueba, un entorno de preproducción y un entorno de producción en el mismo servidor o en la misma célula de WebSphere Application Server Network Deployment. Este atributo environmentId crea un sufijo que se añade a los nombres de MBean que utiliza el servicio de administración y los proyectos de tiempo de ejecución de {{ site.data.keys.product_adj }} cuando se comunican mediante Java Management Extensions (JMX).

#### servicewar
{: #servicewar }
Utilice el atributo **servicewar** para especificar un directorio distinto para el archivo WAR del servicio de administración. Puede especificar el nombre de este archivo WAR con una vía de acceso absoluta o relativa.

#### shortcutsDir
{: #shortcutsdir }
El atributo **shortcutsDir** especifica dónde colocar atajos en la {{ site.data.keys.mf_console }}. Si establece este atributo, puede añadir los archivos siguientes a dicho directorio:

* **mobilefirst-console.url**: este archivo es un atajo de Windows. Abre la {{ site.data.keys.mf_console }} en un navegador.
* **mobilefirst-console.sh**: este archivo es un script de shell de UNIX y abre la {{ site.data.keys.mf_console }} en un navegador.
* **mobilefirst-admin-service.url**: este archivo es un atajo de Windows. Se abre en un navegador y llama a un servicio REST que devuelve una lista de los proyectos de {{ site.data.keys.product_adj }} que se pueden gestionar en formato JSON. Para cada proyecto en la lista de {{ site.data.keys.product_adj }}, también hay disponibles algunos detalles sobre sus artefactos, como el número de aplicaciones, de adaptadores, de dispositivos activos, de dispositivos fuera de servicio. La lista también indica si el tiempo de ejecución del proyecto de {{ site.data.keys.product_adj }} está en ejecución o no.
* **mobilefirst-admin-service.sh**: este archivo es un script de shell de UNIX que proporciona el mismo resultado que el archivo **mobilefirst-admin-service.url**.

#### wasStartingWeight
{: #wasstartingweight }
Utilice el atributo **wasStartingWeight** para especificar un valor que se utiliza en WebSphere Application Server como un peso para asegurarse de que se respeta un orden de inicio. Como resultado del valor de orden de inicio, la aplicación web del servicio de administración se desplegará y se iniciará antes de cualquier otro proyecto de tiempo de ejecución de {{ site.data.keys.product_adj }}. Si los proyectos de {{ site.data.keys.product_adj }} se despliegan o se inician antes de la aplicación web, no se establecerá la comunicación de JMX y el tiempo de ejecución no se podrá sincronizar con la base de datos del servicio de administración y no podrá manejar las solicitudes del servidor.

Las tareas Ant **installmobilefirstadmin**, **updatemobilefirstadmin**, y **uninstallmobilefirstadmin** dan soporte a los elementos siguientes:

| Elemento               | Descripción                                      | Recuento |
|-----------------------|--------------------------------------------------|-------|
| `<applicationserver>` | El servidor de aplicaciones.                          | 1     |
| `<configuration>`     | El servicio de Live Update.	                       | 1     |
| `<console>`           | La consola de administración.                      | 0..1  |
| `<database>`          | Las bases de datos.                                   | 1     |
| `<jmx>`               | Para habilitar Java Management Extensions.	           | 1     |
| `<property>`          | Las propiedades.	                               | 0..   |
| `<push>`              | El servicio de envío por push.	                               | 0..1  |
| `<user>`              | El usuario que se correlacionará con un rol de seguridad.	       | 0..   |

### Para especificar una {{ site.data.keys.mf_console }}
{: #to-specify-a-mobilefirst-operations-console }
El elemento `<console>` recopila información para personalizar la instalación de la {{ site.data.keys.mf_console }}. Este elemento tiene los siguientes atributos:

| Atributo         | Descripción                                                               | Obligatorio | Predeterminado     |
|-------------------|---------------------------------------------------------------------------|----------|-------------|
| contextroot       | El URI de la {{ site.data.keys.mf_console }}.                            | No       | /mfpconsole |
| install           | Para indicar si se debe instalar la {{ site.data.keys.mf_console }}. | No       | Sí         |
| warfile           | El archivo WAR de la consola.	                                                    |No        | El archivo mfp-admin-ui.war se encuentra en el mismo directorio que el archivo themfp-ant-deployer.jar. |

El elemento `<console>` da soporte al elemento siguiente:

| Elemento               | Descripción                                      | Recuento |
|-----------------------|--------------------------------------------------|-------|
| `<artifacts>`         | Los artefactos de {{ site.data.keys.mf_server }}.                | 0..1  |
| `<property>`	        | Las propiedades.	                               | 0..   |

El elemento `<artifacts>` tiene los atributos siguientes:

| Atributo         | Descripción                                                               | Obligatorio | Predeterminado     |
|-------------------|---------------------------------------------------------------------------|----------|-------------|
| install           | Para indicar si se debe instalar el componente de artefactos.            | No       | true        |
| warFile           | El archivo WAR de artefactos.                                                   | No       | El archivo mfp-dev-artifacts.war se encuentra en el mismo directorio que el archivo mfp-ant-deployer.jar |

Al utilizar este elemento, puede definir sus propias propiedades JNDI o sobrescribir el valor predeterminado de las propiedades JNDI que proporciona el servicio de administración y los archivos WAR de {{ site.data.keys.mf_console }}.

El elemento `<property>` especifica una propiedad de despliegue que se definirá en el servidor de aplicaciones. Tiene los atributos siguientes:

| Atributo  | Descripción                | Obligatorio | Predeterminado |
|------------|----------------------------|----------|---------|
| name       | El nombre de la propiedad.  | Sí      | Ninguno    |
| value	     | El valor de la propiedad. |	Sí      | Ninguno    |

Al utilizar este elemento, puede definir sus propias propiedades JNDI o sobrescribir el valor predeterminado de las propiedades JNDI que proporciona el servicio de administración y los archivos WAR de {{ site.data.keys.mf_console }}.

Para obtener más información sobre las propiedades JNDI, consulte [Lista de propiedades JNDI para el servicio de administración de {{ site.data.keys.mf_server }}](../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service).

### Para especificar un servidor de aplicaciones
{: #to-specify-an-application-server }
Utilice el elemento `<applicationserver>` para definir los parámetros que dependen del servidor de aplicaciones subyacente. El elemento `<applicationserver>` da soporte a los elementos siguientes.

| Elemento                                   | Descripción                                      | Recuento |
|-------------------------------------------|--------------------------------------------------|-------|
| `<websphereapplicationserver>` o `<was>` | Los parámetros para WebSphere Application Server. <br/><br/>El elemento `<websphereapplicationserver>` (o `was>` en su formato abreviado) denota una instancia de WebSphere Application Server. Se da soporte al perfil completo de WebSphere Application Server (Base, y Network Deployment), por lo que es WebSphere Application Server Liberty Core y WebSphere Application Server Liberty Network Deployment.               | 0..1  |
| `<tomcat>`                                | Los parámetros para Apache Tomcat.	               | 0..1  |

Los atributos y los elementos internos de estos elementos están descritos en las tablas de [Tareas Ant para la instalación de entornos de ejecución de {{ site.data.keys.product_adj }}](#ant-tasks-for-installation-of-mobilefirst-runtime-environments).  
Sin embargo, para el elemento interno del elemento `<was>` para el colectivo de Liberty, consulte la tabla siguiente:

| Elemento                  | Descripción                      | Recuento |
|--------------------------|----------------------------------|-------|
| `<collectiveController>` | Un controlador colectivo de Liberty. |	0..1  |

El elemento `<collectiveController>` tiene los atributos siguientes:

| Atributo                | Descripción                            | Obligatorio | Predeterminado |
|--------------------------|----------------------------------------|----------|---------|
| serverName               | El nombre del controlador colectivo.	| Sí      | Ninguno    |
| controllerAdminName      | El nombre de usuario administrativo definido en el controlador colectivo. Este es el mismo usuario que se utiliza para unirse a nuevos miembros en el colectivo.                                                         | Sí      | Ninguno    |
| controllerAdminPassword  | La contraseña de usuario administrativo.	    | Sí      | Ninguno    |
| createControllerAdmin    | Para indicar si el usuario administrativo debe crearse en el registro básico del controlador colectivo. Los valores posibles son true o false.                                                              | No	   | true    |

### Para especificar la configuración del servicio de Live Update
{: #to-specify-the-live-update-service-configuration }
Utilice el elemento `<configuration>` para definir los parámetros que dependen del servicio de Live Update. El elemento `<configuration>` tiene los atributos siguientes.

| Atributo                | Descripción                                                    | Obligatorio | Predeterminado |
|--------------------------|----------------------------------------------------------------|----------|---------|
| install                  | Para indicar si se debe instalar el servicio de Live Update. | Sí | true |
| configAdminUser	       | El administrador para el servicio de Live Update.	                | No. Sin embargo, es necesario para una topología de granja de servidores. |Si no está definido, se generará un usuario. En una topología de granja de servidores, el nombre de usuario debe ser el mismo para todos los miembros de la granja de servidores.|
| configAdminPassword      | La contraseña del administrador para el usuario de servicio de Live Update.       | Si se especifica un usuario para **configAdminUser**. | Ninguno. En una topología de granja de servidores, la contraseña debe ser el mismo para todos los miembros de la granja de servidores.|
| createConfigAdminUser	   | Para indicar si se creará un usuario admin en el registro básico del servidor de aplicaciones, si falta. | No | true |
| warFile                  | El archivo WAR del servicio de Live Update.	                            | No         | El archivo mfp-live-update.war se encuentra en el mismo directorio que el archivo mfp-ant-deployer.jar. |

El elemento `<configuration>` da soporte a los elementos siguientes:

| Elemento      | Descripción                           | Recuento |
|--------------|---------------------------------------|-------|
| `<user>`     | El usuario para el servicio de Live Update. | 0..1  |
| `<property>` | Las propiedades.	                   | 0..   |

El elemento `<user>` recopila los parámetros sobre un usuario para incluirlos en un determinado rol de seguridad para una aplicación.

| Atributo   | Descripción                                                             | Obligatorio | Predeterminado |
|-------------|-------------------------------------------------------------------------|----------|---------|
| role	      | Un rol de seguridad válido para la aplicación. Valor posible: configadmin.	| Sí      | Ninguno    |
| name	      | El nombre de usuario.	                                                        | Sí      | Ninguno    |
| password	  | La contraseña si el usuario debe crearse.	                        | No       | Ninguno    |

Una vez definidos los usuarios utilizando el elemento `<user>`, puede correlacionarlos con cualquiera de los roles siguientes para la autenticación en {{ site.data.keys.mf_console }}: `configadmin`.

Para obtener más información sobre qué autorizaciones están implícitas mediante los roles específicos, consulte [Configuración de la autenticación de usuario para la administración de {{ site.data.keys.mf_server }}](../server-configuration/#configuring-user-authentication-for-mobilefirst-server-administration).

> **Consejo:** Si los usuarios existen en un directorio LDAP externo, establezca sólo los atributos **role** y **name** pero no defina ninguna contraseña.

El elemento `<property>` especifica una propiedad de despliegue que se definirá en el servidor de aplicaciones. Tiene los atributos siguientes:

| Atributo  | Descripción                | Obligatorio | Predeterminado |
|------------|----------------------------|----------|---------|
| name       | El nombre de la propiedad.  | Sí      | Ninguno    |
| value	     | El valor de la propiedad. |	Sí      | Ninguno    |

Al utilizar este elemento, puede definir sus propias propiedades JNDI o sobrescribir el valor predeterminado de las propiedades JNDI que proporciona el servicio de administración y los archivos WAR de {{ site.data.keys.mf_console }}. Para obtener más información sobre las propiedades JNDI, consulte [Lista de propiedades JNDI para el servicio de administración de {{ site.data.keys.mf_server }}](../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service).

### Para especificar un servidor de aplicaciones
{: #to-specify-an-application-server-1 }
Utilice el elemento `<applicationserver>` para definir los parámetros que dependen del servidor de aplicaciones subyacente. El elemento `<applicationserver>` da soporte a los elementos siguientes:

| Elemento      | Descripción                                              | Recuento |
|--------------|--------------------------------------------------------- |-------|
| `<websphereapplicationserver>` o `<was>`	| Los parámetros para WebSphere Application Server.<br/><br/>El elemento <websphereapplicationserver> (o <was> en su formato abreviado) denota una instancia de WebSphere Application Server. Se da soporte al perfil completo de WebSphere Application Server (Base, y Network Deployment), por lo que es WebSphere Application Server Liberty Core y WebSphere Application Server Liberty Network Deployment. | 0..1  |
| `<tomcat>`   | Los parámetros para Apache Tomcat.                        | 0..1  |

Los atributos y los elementos internos de estos elementos están descritos en las tablas de [Tareas Ant para la instalación de entornos de ejecución de {{ site.data.keys.product_adj }}](#ant-tasks-for-installation-of-mobilefirst-runtime-environments).  
Sin embargo, para el elemento interno del elemento <was> para el colectivo de Liberty, consulte la tabla siguiente:

| Elemento               | Descripción                  | Recuento |
|-----------------------|----------------------------- |-------|
| `<collectiveMember>`	| Un miembro de colectivo de Liberty. | 0..1  |

El elemento `<collectiveMember>` tiene los atributos siguientes:

| Atributo   | Descripción                                             | Obligatorio | Predeterminado |
|-------------|---------------------------------------------------------|----------|---------|
| serverName  |	El nombre del miembro de colectivo.                      | Sí      | Ninguno    |
| clusterName |	El nombre de clúster al que pertenece el miembro de colectivo. | Sí	   | Ninguno    |

> **Nota:** Si el servicio de envío por push y los componentes de tiempo de ejecución están instalados en el mismo miembro de colectivo, deben tener el mismo nombre de clúster. Si estos componentes están instalados en miembros distintos del mismo colectivo, los nombres de clúster pueden ser distintos.
### Para especificar Analytics
{: #to-specify-analytics }
El elemento `<analytics>` indica que desea conectar el servicio de envío por push de {{ site.data.keys.product_adj }} a un servicio de {{ site.data.keys.mf_analytics }} ya instalado. Tiene los atributos siguientes:

| Atributo     | Descripción                                                               | Obligatorio | Predeterminado |
|---------------|---------------------------------------------------------------------------|----------|---------|
| install	    | Para indicar si se debe conectar el servicio de envío por push a {{ site.data.keys.mf_analytics }}. | No       | false   |
| analyticsURL 	| El URL de los servicios de {{ site.data.keys.mf_analytics }}.	                            | Sí	   | Ninguno    |
| username	    | El nombre de usuario.	                                                        | Sí	   | Ninguno    |
| password	    | La contraseña.	                                                            | Sí	   | Ninguno    |
| validate	    | Para validar si se puede acceder a {{ site.data.keys.mf_analytics_console }} o no.	| No	   | true    |

**install**  
Utilice el atributo install para indicar que este servicio de envío por push debe estar conectado y debe enviar sucesos a {{ site.data.keys.mf_analytics }}. Los valores válidos son true o false.

**analyticsURL**  
Utilice el atributo analyticsURL para especificar el URL expuesto por {{ site.data.keys.mf_analytics }}, que recibe datos analíticos entrantes.

Por ejemplo: `http://<hostname>:<port>/analytics-service/rest`

**username**  
Utilice el atributo username para especificar el nombre de usuario que se utilizará si el punto de entrada de datos para {{ site.data.keys.mf_analytics }} está protegido con autenticación básica.

**password**  
Utilice el atributo password para especificar la contraseña que se utilizará si el punto de entrada de datos para {{ site.data.keys.mf_analytics }} está protegido con autenticación básica.

**validate**  
Utilice el atributo validate para validar si se puede acceder a {{ site.data.keys.mf_analytics_console }} o no, y para comprobar la autenticación de nombre de usuario con una contraseña. Los valores posibles son true, o false.

### Para especificar una conexión con la base de datos de servicio de envío por push
{: #to-specify-a-connection-to-the-push-service-database }

El elemento `<database>` recopila los parámetros que especifican una declaración de origen de datos en un servidor de aplicaciones para acceder a la base de datos de servicio de envío por push.

Debe declarar una única base de datos: `<database kind="Push">`. Especifique el elemento `<database>` de forma parecida a la tarea Ant configuredatabase, excepto que el elemento `<database>` no tiene los elementos `<dba>` ni `<client>`. Podría tener los elementos `<property>`.

El elemento `<database>` tiene los atributos siguientes:

| Atributo     | Descripción                                     | Obligatorio | Predeterminado |
|---------------|-------------------------------------------------|----------|---------|
| kind          | El tipo de base de datos (Push).	                  | Sí	   | Ninguno    |
| validate	    | Para validar si se puede acceder a la base de datos. | No       | true    |

El elemento `<database>` da soporte a los elementos siguientes. Para obtener más información sobre la configuración de estos elementos de base de datos para DBMS relacional, consulte las tablas de [tareas Ant para la instalación de entornos de ejecución de {{ site.data.keys.product_adj }}](#ant-tasks-for-installation-of-mobilefirst-runtime-environments).

| Elemento            | Descripción                                                      | Recuento |
|--------------------|----------------------------------------------------------------- |-------|
| <db2>	             | El parámetro para bases de datos DB2.	                            | 0..1  |
| <derby>	         | El parámetro para bases de datos Apache Derby.	                    | 0..1  |
| <mysql>	         | El parámetro para bases de datos MySQL.                               | 0..1  |
| <oracle>	         | El parámetro para bases de datos Oracle.	                            | 0..1  |
| <cloudant>	     | El parámetro para bases de datos Cloudant.	                        | 0..1  |
| <driverclasspath>	 | El parámetro para la vía de acceso de la clase de controlador JDBC (sólo DBMS relacional). | 0..1  |

> **Nota:** Los atributos del elemento `<cloudant>` son ligeramente distintos del tiempo de ejecución. Para obtener más información, consulte la siguiente tabla:

| Atributo     | Descripción                                     | Obligatorio | Predeterminado                   |
|---------------|-------------------------------------------------|----------|---------------------------|
| url           | El URL de la cuenta de Cloudant.                | No       | https://user.cloudant.com |
| user          | El nombre de usuario de la cuenta de Cloudant.	      | Sí	   | Ninguno                      |
| password      | La contraseña de la cuenta de Cloudant.	          | No	     | Consultado de forma interactiva     |
| dbName        | El nombre de base de datos de Cloudant. **Importante:** Este nombre de base de datos debe comenzar por una letra en minúscula y contener sólo caracteres en minúscula (a-z), dígitos (0-9), cualquiera de los caracteres _, $, y -.                                | No       | mfp_push_db               |

## Tareas Ant para la instalación del servicio de envío por push de {{ site.data.keys.mf_server }}
{: #ant-tasks-for-installation-of-mobilefirst-server-push-service }
Las tareas Ant **installmobilefirstpush**, **updatemobilefirstpush**, y **uninstallmobilefirstpush** se proporcionan para la instalación del servicio de envío por push.

### Efectos de tareas
{: #task-effects-1 }
#### installmobilefirstpush
{: #installmobilefirstpush }
La tarea Ant **installmobilefirstpush** configura un servidor de aplicaciones para ejecutar el archivo WAR del servicio de envío por push como una aplicación web. Esta tarea tiene los siguientes efectos:
Declara la aplicación web del servicio de envío por push en la raíz de contexto **/imfpush**. La raíz de contexto no se puede modificar.
Para las bases de datos relacionales, declara los orígenes de datos y, en el perfil completo de WebSphere Application Server, los proveedores JDBC para servicio de envío por push.
Configura las propiedades de configuración para el servicio de envío por push utilizando entradas de entorno JNDI. Estas entradas de entorno JNDI configuran la comunicación de OAuth con el servidor de autorizaciones de {{ site.data.keys.product_adj }}, {{ site.data.keys.mf_analytics }}, y con Cloudant en caso de que se utilice Cloudant.

#### updatemobilefirstpush
{: #updatemobilefirstpush }
La tarea Ant **updatemobilefirstpush** actualiza una aplicación web de {{ site.data.keys.mf_server }} ya configurada en un servidor de aplicaciones. Esta tarea actualiza el archivo WAR del servicio de envío por push. Este archivo debe tener el mismo nombre base que el archivo WAR correspondiente desplegado anteriormente.

#### uninstallmobilefirstpush
{: #uninstallmobilefirstpush }
La tarea Ant **uninstallmobilefirstpush** deshace los efectos de una ejecución anterior de **installmobilefirstpush**. Esta tarea tiene los siguientes efectos:
Elimina la configuración de la aplicación web del servicio de envío por push con la raíz de contexto especificada. Como consecuencia, la tarea también elimina los valores que se han añadido manualmente a dicha aplicación.
Elimina el archivo WAR del servicio de envío por push del servidor de aplicaciones como una opción.
Para DBMS relacional, elimina los orígenes de datos y, en el perfil completo de WebSphere Application Server, los proveedores JDBC para el servicio de envío por push.
Elimina las entradas de entorno JNDI asociadas.

### Atributos y elementos
{: #attributes-and-elements-1 }
Las tareas Ant **installmobilefirstpush**, **updatemobilefirstpush**, y **uninstallmobilefirstpush** tienen los siguientes atributos:

| Atributo | Descripción                           | Obligatorio | Predeterminado     |
|-----------|---------------------------------------|----------|-------------|
| id        | Para distinguir los distintos despliegues.	| No	   | Vacío
| warFile	| El archivo WAR para el servicio de envío por push. | No	   | El archivo ../PushService/mfp-push-service.war es relativo al directorio MobileFirstServer que contiene el archivo mfp-ant-deployer.jar. |

### Id
{: #id }
El atributo **id** distingue distintos despliegues del servicio de envío por push en la misma célula de WebSphere Application Server. Sin este atributo id, pueden entrar en conflicto dos archivos WAR con las mismas raíces de contexto y es posible que estos archivos no se desplieguen.

### warFile
{: #warfile }
Utilice el atributo **warFile** para especificar un directorio distinto para el archivo WAR del servicio de envío por push. Puede especificar el nombre de este archivo WAR con una vía de acceso absoluta o relativa.

Las tareas Ant **installmobilefirstpush**, **updatemobilefirstpush**, y **uninstallmobilefirstpush** dan soporte a los siguientes elementos:

| Elemento               | Descripción             | Recuento |
|-----------------------|-------------------------|-------|
| `<applicationserver>` | El servidor de aplicaciones. | 1     |
| `<analytics>`	        | Analytics.	      | 0..1  |
| `<authorization>`	    | El servidor de autorizaciones para autenticar la comunicación con otros componentes {{ site.data.keys.mf_server }}. | 1 |
| `<database>`	        | Las bases de datos.	      | 1     |
| `<property>`	        | Las propiedades.	      | 0..∞  |

### Para especificar el servidor de autorizaciones
{: #to-specify-the-authorization-server }
El elemento `<authorization>` recopila información para configurar el servidor de autorizaciones para la comunicación de autenticación con otros componentes de {{ site.data.keys.mf_server }}. Este elemento tiene los siguientes atributos:

| Atributo          | Descripción                           | Obligatorio | Predeterminado     |
|--------------------|---------------------------------------|----------|-------------|
| auto               | Para indicar si el URL del servidor de autorizaciones está calculado. Los valores posibles son true o false.	| Necesario en un clúster o en un nodo de WebSphere Application Server Network Deployment.   	 | true |
| authorizationURL   | El URL del servidor de autorizaciones.	 | Si la modalidad no es auto. | La raíz de contexto del tiempo de ejecución en el servidor local. |
| runtimeContextRoot | La raíz de contexto del tiempo de ejecución.	     | No	     | /mfp       |
| pushClientID	     | El ID confidencial del servicio de envío por push del servidor de autorizaciones.  | Sí | Ninguno |
| pushClientSecret	 | La contraseña de cliente confidencial del servicio de envío por push del servidor de autorizaciones. | Sí | Ninguno |

#### auto
{: #auto }
Si el valor se establece en true, el URL del servidor de autorizaciones se calculará automáticamente utilizando la raíz de contexto del tiempo de ejecución en el servidor de aplicaciones local. La modalidad automática no estará soportada si despliega en WebSphere Application Server Network Deployment en un clúster.

#### authorizationURL
{: #authorizationurl }
El URL del servidor de autorizaciones. Si el servidor de autorizaciones es el tiempo de ejecución de {{ site.data.keys.product_adj }}, el URL es el del tiempo de ejecución. Por ejemplo: `http://myHost:9080/mfp`.

#### runtimeContextRoot
{: #runtimecontextroot }
La raíz de contexto del tiempo de ejecución que se utiliza para calcular el URL del servidor de autorizaciones en la modalidad automática.
#### pushClientID
{: #pushclientid }
El ID de esta instancia del servicio de envío por push como cliente confidencial del servidor de autorizaciones. El ID y el secreto deben estar registrados para el servidor de autorizaciones. Pueden estar registrados por la tarea Ant **installmobilefirstadmin**, o desde {{ site.data.keys.mf_console }}.

#### pushClientSecret
{: #pushclientsecret }
La clave secreta de esta instancia de servicio de envío por push como cliente confidencial del servidor de autorizaciones. El ID y el secreto deben estar registrados para el servidor de autorizaciones. Pueden estar registrados por la tarea Ant **installmobilefirstadmin**, o desde {{ site.data.keys.mf_console }}.

El elemento `<property>` especifica una propiedad de despliegue que se definirá en el servidor de aplicaciones. Tiene los atributos siguientes:

| Atributo  | Descripción                | Obligatorio | Predeterminado |
|------------|----------------------------|----------|---------|
| name       | El nombre de la propiedad.  |	Sí	   | Ninguno    |
| value	     | El valor de la propiedad. |	Sí	   | Ninguno    |

Al utilizar este elemento, puede definir sus propias propiedades JNDI o sobrescribir el valor predeterminado de las propiedades JNDI que proporciona el archivo WAR del servicio de envío por push.

Para obtener más información sobre las propiedades JNDI, consulte [Lista de propiedades JNDI para el servicio de envío por push de {{ site.data.keys.mf_server }}](../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service).

### Para especificar un servidor de aplicaciones
{: #to-specify-an-application-server-2 }
Utilice el elemento `<applicationserver>` para definir los parámetros que dependen del servidor de aplicaciones subyacente. El elemento `<applicationserver>` da soporte a los elementos siguientes:

| Elemento                               | Descripción                                      | Recuento |
|---------------------------------------|--------------------------------------------------|-------|
| <websphereapplicationserver> o <was>	| Los parámetros para WebSphere Application Server. | El elemento `<websphereapplicationserver>` (o `<was>` en su formato abreviado) denota una instancia de WebSphere Application Server. Se da soporte al perfil completo de WebSphere Application Server (Base, y Network Deployment), por lo que es WebSphere Application Server Liberty Core y WebSphere Application Server Liberty Network Deployment. | 0..1 |
| `<tomcat>` | Los parámetros para Apache Tomcat. | 0..1 |

Los atributos y los elementos internos de estos elementos están descritos en las tablas de [Tareas Ant para la instalación de entornos de ejecución de {{ site.data.keys.product_adj }}](#ant-tasks-for-installation-of-mobilefirst-runtime-environments).

Sin embargo, para el elemento interno del elemento `<was>` para el colectivo de Liberty, consulte la tabla siguiente:

| Elemento              | Descripción                  | Recuento |
|----------------------|------------------------------|-------|
| `<collectiveMember>` | Un miembro de colectivo de Liberty. |	0..1  |

El elemento `<collectiveMember>` tiene los atributos siguientes:

| Atributo   | Descripción                        | Obligatorio | Predeterminado |
|-------------|------------------------------------|----------|---------|
| serverName  | El nombre del miembro de colectivo. | Sí      | Ninguno    |
| clusterName |	El nombre de clúster al que pertenece el miembro de colectivo. | Sí | Ninguno |

> **Nota:** Si el servicio de envío por push y los componentes de tiempo de ejecución están instalados en el mismo miembro de colectivo, deben tener el mismo nombre de clúster. Si estos componentes están instalados en miembros distintos del mismo colectivo, los nombres de clúster pueden ser distintos.
### Para especificar Analytics
{: #to-specify-analytics-1 }
El elemento `<analytics>` indica que desea conectar el servicio de envío por push de {{ site.data.keys.product_adj }} a un servicio de {{ site.data.keys.mf_analytics }} ya instalado. Tiene los atributos siguientes:

| Atributo    | Descripción                        | Obligatorio | Predeterminado |
|--------------|------------------------------------|----------|---------|
| install	   | Para indicar si se debe conectar el servicio de envío por push a {{ site.data.keys.mf_analytics }}. | No | false |
| analyticsURL | El URL de los servicios de {{ site.data.keys.mf_analytics }}. | Sí | Ninguno |
| username	   | El nombre de usuario. | Sí | Ninguno |
| password	   | La contraseña. | Sí | Ninguno |
| validate	   | Para validar si se puede acceder a {{ site.data.keys.mf_analytics_console }} o no.	| No | true |

#### install
{: #install }
Utilice el atributo **install** para indicar que este servicio de envío por push debe estar conectado y enviar sucesos a {{ site.data.keys.mf_analytics }}. Los valores válidos son true o false.

#### analyticsURL
{: #analyticsurl }
Utilice el atributo **analyticsURL** para especificar el URL expuesto por {{ site.data.keys.mf_analytics }}, que recibe datos analíticos entrantes.  
Por ejemplo: `http://<hostname>:<port>/analytics-service/rest`

#### username
{: #username }
Utilice el atributo **username** para especificar el nombre de usuario que se utilizará si el punto de entrada de datos para {{ site.data.keys.mf_analytics }} está protegido con autenticación básica.

#### password
{: #password }
Utilice el atributo **password** para especificar la contraseña que se utilizará si el punto de entrada de datos para {{ site.data.keys.mf_analytics }} está protegido con autenticación básica.

#### validate
{: #validate }
Utilice el atributo **validate** para validar si se puede acceder a la {{ site.data.keys.mf_analytics_console }} o no, y para comprobar la autenticación del nombre de usuario con una contraseña. Los valores posibles son true, o false.

### Para especificar una conexión con la base de datos de servicio de envío por push
{: #to-specify-a-connection-to-the-push-service-database-1 }
El elemento `<database>` recopila los parámetros que especifican una declaración de origen de datos en un servidor de aplicaciones para acceder a la base de datos de servicio de envío por push.

Debe declarar una única base de datos: `<database kind="Push">`. Especifique el elemento `<database>` de forma parecida a la tarea Ant configuredatabase, excepto que el elemento `<database>` no tiene los elementos `<dba>` ni `<client>`. Podría tener los elementos `<property>`.

El elemento `<database>` tiene los atributos siguientes:

| Atributo    | Descripción                  | Obligatorio | Predeterminado |
|--------------|------------------------------|----------|---------|
| kind         | El tipo de base de datos (Push). | Sí      | Ninguno    |
| validate	   | Para validar si se puede acceder a la base de datos. | No | true |

El elemento `<database>` da soporte a los elementos siguientes. Para obtener más información sobre la configuración de estos elementos de base de datos para DBMS relacionales, consulte las tablas de las [tareas Ant para la instalación de los entornos de ejecución de {{ site.data.keys.product_adj }}](#ant-tasks-for-installation-of-mobilefirst-runtime-environments).

| Elemento              | Descripción                               | Recuento |
|----------------------|-------------------------------------------|-------|
| `<db2>`	           | El parámetro para bases de datos DB2.         | 0..1  |
| `<derby>`	           | El parámetro para bases de datos Apache Derby. | 0..1  |
| `<mysql>`	           | El parámetro para bases de datos MySQL.        | 0..1  |
| `<oracle>`           | El parámetro para bases de datos Oracle.       | 0..1  |
| `<cloudant>`	       | El parámetro para bases de datos Cloudant.     | 0..1  |
| `<driverclasspath>`  | El parámetro para la vía de acceso de la clase de controlador JDBC (sólo DBMS relacional). | 0..1 |

> **Nota:** Los atributos del elemento `<cloudant>` son ligeramente distintos del tiempo de ejecución. Para obtener más información, consulte la siguiente tabla:

| Atributo    | Descripción                            | Obligatorio   | Predeterminado |
|--------------|----------------------------------------|------------|---------|
| url	       | El URL de la cuenta de Cloudant.       | No         | https://user.cloudant.com |
| user	       | El nombre de usuario de la cuenta de Cloudant. | Sí | Ninguno |
| password	   | La contraseña de la cuenta de Cloudant.	| No  | Consultado de forma interactiva |
| dbName	   | El nombre de base de datos de Cloudant. **Importante:** Este nombre de base de datos debe comenzar por una letra en minúscula y contener sólo caracteres en minúscula (a-z), dígitos (0-9), cualquiera de los caracteres _, $, y -. |No	| mfp_push_db |

## Tareas Ant para la instalación de entornos de ejecución de {{ site.data.keys.product_adj }}
{: #ant-tasks-for-installation-of-mobilefirst-runtime-environments }
Información de referencia para las tareas Ant **installmobilefirstruntime**, **updatemobilefirstruntime**, y **uninstallmobilefirstruntime**.

### Efectos de tareas
{: #task-effects-2 }

#### installmobilefirstruntime
{: #installmobilefirstruntime }
La tarea Ant **installmobilefirstruntime** configura un servidor de aplicaciones para ejecutar un archivo WAR de tiempo de ejecución de {{ site.data.keys.product_adj }} como una aplicación web. Esta tarea tiene los siguientes efectos.

* Declara la aplicación web de {{ site.data.keys.product_adj }} en la raíz de contexto especificada, de forma predeterminada /mfp.
* Despliega el archivo WAR de tiempo de ejecución en el servidor de aplicaciones.
* Declara orígenes de datos y en el perfil completo de WebSphere Application Server, los proveedores JDBC para el tiempo de ejecución.
* Despliega los controladores de base de datos en el servidor de aplicaciones.
* Establece propiedades de configuración de {{ site.data.keys.product_adj }} mediante entradas de entorno de JNDI.
* Opcionalmente, establece las entradas de entorno JNDI de {{ site.data.keys.product_adj }} para configurar el servidor de aplicaciones como miembro de la granja de servidores para el tiempo de ejecución.

#### updatemobilefirstruntime
{: #updatemobilefirstruntime }
La tarea Ant **updatemobilefirstruntime** actualiza un tiempo de ejecución de {{ site.data.keys.product_adj }} que ya está configurado en un servidor de aplicaciones. Esta tarea actualiza el archivo WAR de tiempo de ejecución. El archivo debe tener el mismo nombre base que el archivo WAR de tiempo de ejecución que se desplegó anteriormente. Aparte de esto, la tarea no cambia la configuración del servidor de aplicaciones, es decir, la configuración de la aplicación web, de los orígenes de datos ni las entradas de entorno JNDI.

#### uninstallmobilefirstruntime
{: #uninstallmobilefirstruntime }
La tarea Ant **uninstallmobilefirstruntime** deshace los efectos de una ejecución anterior de **installmobilefirstruntime**. Esta tarea tiene los siguientes efectos.

* Elimina la configuración de la aplicación web de {{ site.data.keys.product_adj }} con la raíz de contexto especificada. La tarea también elimina los valores añadidos manualmente a dicha aplicación.
* Elimina el archivo WAR de tiempo de ejecución del servidor de aplicaciones.
* Elimina los orígenes de datos y en el perfil completo de WebSphere Application Server, los proveedores JDBC para el tiempo de ejecución.
* Elimina las entradas de entorno JNDI asociadas.

### Atributos y elementos
{: #attributes-and-elements-2 }
Las tareas Ant **installmobilefirstruntime**, **updatemobilefirstruntime**, y **uninstallmobilefirstruntime** tienen los siguientes atributos:

| Atributo         | Descripción                                                                 | Obligatorio   | Predeterminado                   |
|-------------------|-----------------------------------------------------------------------------|------------|---------------------------|
| contextroot       | El prefijo común en los URL con la aplicación (raíz de contexto).                | No | /mfp  |
| id	            | Para distinguir los distintos despliegues.                                       | No | Vacío |
| environmentId	    | Para distinguir los distintos entornos de {{ site.data.keys.product_adj }}.                          | No | Vacío |
| warFile	        | El archivo WAR para el tiempo de ejecución de {{ site.data.keys.product_adj }}.                                       | No | El archivo mfp-server.war se encuentra en el mismo directorio que el archivo mfp-ant-deployer.jar. |
| wasStartingWeight | El orden de inicio para WebSphere Application Server. Los valores inferiores comenzarán en primer lugar. | No | 2     |                           |

#### contextroot e id
{: #contextroot-and-id-1 }
Los atributos **contextroot** e **id** distinguen entre los distintos proyectos de {{ site.data.keys.product_adj }}.

En los perfiles de WebSphere Application Server Liberty y en los entornos de Tomcat, el parámetro contextroot es suficiente para esta finalidad. En los entornos de perfil completo de WebSphere Application Server, se utilizará el atributo id en su lugar.

#### environmentId
{: #environmentid-1 }
Utilice el atributo **environmentId** para distinguir varios entornos, cada uno de los cuales consta del servicio de administración de {{ site.data.keys.mf_server }} y de las aplicaciones web de tiempo de ejecución de {{ site.data.keys.product_adj }}, que deben funcionar independientemente. Debe establecer este atributo en el mismo valor para la aplicación de ejecución que el que se estableció en la invocación de <installmobilefirstadmin>, para la aplicación del servicio de administración.

#### warFile
{: #warfile-1 }
Utilice el atributo **warFile** para especificar un directorio distinto para el archivo WAR de tiempo de ejecución de {{ site.data.keys.product_adj }}. Puede especificar el nombre de este archivo WAR con una vía de acceso absoluta o relativa.

#### wasStartingWeight
{: #wasstartingweight-1 }
Utilice el atributo **wasStartingWeight** para especificar un valor que se utiliza en WebSphere Application Server como un peso para asegurarse de que se respeta un orden de inicio. Como resultado del valor de la orden de inicio, se desplegará la aplicación web del servicio de administración de {{ site.data.keys.mf_server }} y se iniciará antes que cualquier otro proyecto de tiempo de ejecución de {{ site.data.keys.product_adj }}. Si los proyectos de {{ site.data.keys.product_adj }} se despliegan o se inician antes que la aplicación web, no se establece la comunicación de JMX y no podrá gestionar los proyectos de {{ site.data.keys.product_adj }}.

Las tareas **installmobilefirstruntime**, **updatemobilefirstruntime**, y **uninstallmobilefirstruntime** dan soporte a los siguientes elementos:

| Elemento               | Descripción                                      | Recuento |
|-----------------------|--------------------------------------------------|-------|
| `<property>`          | Las propiedades.	                               | 0..   |
| `<applicationserver>` | El servidor de aplicaciones.                          | 1     |
| `<database>`          | Las bases de datos.                                   | 1     |
| `<analytics>`         | Las analíticas.                                   | 0..1  |

El elemento `<property>` especifica una propiedad de despliegue que se definirá en el servidor de aplicaciones. Tiene los atributos siguientes:

| Atributo | Descripción                | Obligatorio | Predeterminado |
|-----------|----------------------------|----------|---------|
| name      | El nombre de la propiedad.	 | Sí      | Ninguno    |
| value	    | El valor de la propiedad.| Sí	    | Ninguno    |  

El elemento `<applicationserver>` describe el servidor de aplicaciones en el que se despliega la aplicación de {{ site.data.keys.product_adj }}. Es un contenedor para uno de los elementos siguientes:

| Elemento                                    | Descripción                                      | Recuento |
|--------------------------------------------|--------------------------------------------------|-------|
| `<websphereapplicationserver>` o `<was>`  | Los parámetros para WebSphere Application Server.	| 0..1  |
| `<tomcat>`                                 | Los parámetros para Apache Tomcat.                | 0..1  |

El elemento `<websphereapplicationserver>` (o `<was>` en su formato abreviado) denota una instancia de WebSphere Application Server. Se da soporte al perfil completo de WebSphere Application Server (Base, y Network Deployment), por lo que es WebSphere Application Server Liberty Core y WebSphere Application Server Liberty Network Deployment. El elemento `<websphereapplicationserver>` tiene los atributos siguientes:

| Atributo       | Descripción                                            | Obligatorio                 | Predeterminado |
|-----------------|--------------------------------------------------------|--------------------------|---------|
| installdir      |	Directorio de instalación de WebSphere Application Server.   | Sí                      | Ninguno    |
| profile         |	Perfil de WebSphere Application Server, o Liberty.      | Sí	                  | Ninguno    |
| user	| Nombre del administrador de WebSphere Application Server.	               | Sí, excepto para Liberty  | Ninguno    |
| password        | Contraseña del administrador de WebSphere Application Server.   | No	| Consultado de forma interactiva |         |
| libertyEncoding |	El algoritmo para codificar las contraseñas de origen de datos para WebSphere Application Server Liberty. Los valores posibles son none, xor, y aes. Ya se utilice la codificación xor o aes, se pasará la contraseña borrada como argumento al programa securityUtility, que se llamará a través de un proceso externo. Puede ver la contraseña con un mandato ps, o en el sistema de archivos /proc en sistemas operativos UNIX.                                                         | No                       |	xor     |
| jeeVersion      |	Para el perfil de Liberty. Para especificar si se instalarán las características del perfil web de JEE6 o del perfil web de JEE7. Los valores posibles son 6, 7, o auto.| No | auto |
| configureFarm   |	Para WebSphere Application Server Liberty, y el perfil completo de WebSphere Application Server (no para la edición de WebSphere Application Server Network Deployment ni el colectivo de Liberty). Para especificar si el servidor es un miembro de la granja de servidores. Los valores posibles son true o false. | No	      | false   |
| farmServerId    |	Una serie que identifica de forma exclusiva un servidor de la granja de servidores. Los servicios de administración de {{ site.data.keys.mf_server }} y todos los tiempos de ejecución de {{ site.data.keys.product_adj }} que se comunican con él deben compartir el mismo valor.                                                                | Sí                      |	Ninguno    |

Da soporte al elemento siguiente para el despliegue en un solo servidor:

| Elemento     | Descripción      | Recuento |
|-------------|------------------|-------|
| `<server>`  | Un único servidor. | 0..1  |

El elemento <server>, que se utiliza en este contexto, tiene el atributo siguiente:

| Atributo | Descripción      | Obligatorio | Predeterminado |
|-----------|------------------|----------|---------|
| name	    | El nombre del servidor. | Sí      | Ninguno    |

Se da soporte a los siguientes elementos para el colectivo de Liberty:

| Elemento               | Descripción                  | Recuento |
|-----------------------|------------------------------|-------|
| `<collectiveMember>`  | Un miembro de colectivo de Liberty. | 0..1  |

El elemento `<collectiveMember>` tiene los atributos siguientes:

| Atributo               | Descripción      | Obligatorio | Predeterminado |
|-------------------------|------------------|----------|---------|
| serverName              |	El nombre del miembro de colectivo.                       | Sí | Ninguno |
| clusterName             |	El nombre de clúster al que pertenece el miembro de colectivo.  | Sí | Ninguno |
| serverId                |	Un serie que identifica de forma exclusiva al miembro de colectivo. | Sí | Ninguno |
| controllerHost          |	El nombre del controlador colectivo.                   | Sí | Ninguno |
| controllerHttpsPort     |	El puerto HTTPS del controlador colectivo.             | Sí | Ninguno |
| controllerAdminName     |	El nombre de usuario administrativo definido en el controlador colectivo. Este es el mismo usuario que se utiliza para unirse a nuevos miembros en el colectivo. | Sí | Ninguno |
| controllerAdminPassword |	La contraseña de usuario administrativo.	                     | Sí | Ninguno |
| createControllerAdmin   |	Para indicar si se debe crear el usuario administrativo en el registro básico del miembro de colectivo. Los valores posibles son true o false. | No | true |

Se da soporte a los siguientes elementos para Network Deployment:

| Elemento     | Descripción                                   | Recuento |
|-------------|-----------------------------------------------|-------|
| `<cell>`    |	La célula completa.	                          | 0..1  |
| `<cluster>` |	Todos los servidores de un clúster.                 |	0..1  |
| `<node>`    |	Todos los servidores de un nodo, clústeres excluidos. | 0..1  |
| `<server>`  |	Un único servidor.	                          | 0..1  |

El elemento `<cell>` no tiene atributos.

El elemento `<cluster>` tiene el atributo siguiente:

| Atributo | Descripción       | Obligatorio | Predeterminado |
|-----------|-------------------|----------|---------|
| name      | El nombre de clúster. | Sí	   | Ninguno    |

El elemento `<node>` tiene el atributo siguiente:

| Atributo | Descripción    | Obligatorio | Predeterminado |
|-----------|----------------|----------|---------|
| name      | El nombre de nodo. | Sí	    | Ninguno    |

El elemento `<server>`, que se utiliza en un contexto de Network Deployment, tiene los atributos siguientes:

| Atributo  | Descripción      | Obligatorio | Predeterminado |
|------------|------------------|----------|---------|
| nodeName   | El nombre de nodo.   | Sí	   | Ninguno    |
| serverName | El nombre del servidor. | Sí      | Ninguno    |

El elemento `<tomcat>` indica un servidor Apache Tomcat. Tiene el atributo siguiente:

| Atributo     | Descripción      | Obligatorio | Predeterminado |
|---------------|------------------|----------|---------|
| installdir    | El directorio de instalación de Apache Tomcat. Para una instalación de Tomcat que se divide entre un directorio CATALINA_HOME y un directorio CATALINA_BASE, especifique el valor de la variable de entorno CATALINA_BASE.     | Sí | Ninguno    |
| configureFarm | Para especificar si el servidor es un miembro de la granja de servidores. Los valores posibles son true o false. | No | false |
| farmServerId	| Una serie que identifica de forma exclusiva un servidor de la granja de servidores. Los servicios de administración de {{ site.data.keys.mf_server }} y todos los tiempos de ejecución de {{ site.data.keys.product_adj }} que se comunican con él deben compartir el mismo valor. | Sí | Ninguno |

El elemento `<database>` especifica qué información es necesaria para acceder a una base de datos determinada. El elemento `<database>` se especifica como la tarea Ant configuredatabase, excepto que no tiene los elementos `<dba>` ni `<client>`. Sin embargo, podría tener los elementos `<property>`. El elemento `<database>` tiene los atributos siguientes:

| Atributo | Descripción                                | Obligatorio | Predeterminado |
|-----------|--------------------------------------------|----------|---------|
| kind      | El tipo de base de datos (Tiempo de ejecución de {{ site.data.keys.product_adj }}). | Sí | Ninguno |
| validate  | Para validar si se puede acceder a la base de datos o no. Los valores posibles son true o false.	| No | true |

El elemento `<database>` da soporte a los elementos siguientes:

| Elemento             | Descripción	                | Recuento |
|---------------------|-----------------------------|-------|
| `<derby>`           | Los parámetros para Derby.   | 0..1  |
| `<db2>`             |	Los parámetros para DB2.     | 0..1  |
| `<mysql>`           |	Los parámetros para MySQL.   | 0..1  |
| `<oracle>`          |	Los parámetros para Oracle.  | 0..1  |
| `<driverclasspath>` | La vía de acceso de clase de controlador JDBC. | 0..1  |

El elemento `<analytics>` indica que desea conectar el tiempo de ejecución de {{ site.data.keys.product_adj }} a una {{ site.data.keys.mf_analytics_console }} y a unos servicios ya instalados. Tiene los atributos siguientes:

| Atributo    | Descripción                                                                      | Obligatorio | Predeterminado |
|--------------|----------------------------------------------------------------------------------|----------|---------|
| install      | Para indicar si conectará el tiempo de ejecución de {{ site.data.keys.product_adj }} a {{ site.data.keys.mf_analytics }}. | No       | false   |
| analyticsURL | El URL de los servicios de {{ site.data.keys.mf_analytics }}.	                                      | Sí      | Ninguno    |
| consoleURL   | El URL de {{ site.data.keys.mf_analytics_console }}.	                                      | Sí      | Ninguno    |
| username     | El nombre de usuario.	                                                                  | Sí      | Ninguno    |
| password     | La contraseña.	                                                                  | Sí      | Ninguno    |
| validate     | Para validar si se puede acceder a {{ site.data.keys.mf_analytics_console }} o no.	      | No	     | true    |
| tenant       | El arrendatario para los datos de indexación que se recopilan de un tiempo de ejecución de {{ site.data.keys.product_adj }}.	    | No       | Identificador interno |

#### install
{: #install-1 }
Utilice el atributo **install** para indicar que este tiempo de ejecución de {{ site.data.keys.product_adj }} debe estar conectado y enviar sucesos a {{ site.data.keys.mf_analytics }}. Los valores válidos son **true** o **false**.

#### analyticsURL
{: #analyticsurl-1 }
Utilice el atributo **analyticsURL** para especificar el URL expuesto por {{ site.data.keys.mf_analytics }}, que recibe datos analíticos entrantes.  
Por ejemplo: `http://<hostname>:<port>/analytics-service/rest`

#### consoleURL
{: #consoleurl }
Utilice el atributo **consoleURL** para el URL que expone {{ site.data.keys.mf_analytics }}, que enlaza a la {{ site.data.keys.mf_analytics_console }}.  
Por ejemplo: `http://<hostname>:<port>/analytics/console`

#### username
{: #username-1 }
Utilice el atributo **username** para especificar el nombre de usuario que se utilizará si el punto de entrada de datos para {{ site.data.keys.mf_analytics }} está protegido con autenticación básica.

#### password
{: #password-1 }
Utilice el atributo **password** para especificar la contraseña que se utilizará si el punto de entrada de datos para {{ site.data.keys.mf_analytics }} está protegido con autenticación básica.

#### validate
{: #validate-1 }
Utilice el atributo **validate** para validar si se puede acceder a la {{ site.data.keys.mf_analytics_console }} o no, y para comprobar la autenticación del nombre de usuario con una contraseña. Los valores posibles son **true** o **false**.

#### tenant
{: #tenant }
Para obtener más información sobre este atributo, consulte [Propiedades de configuración](../analytics/configuration/#configuration-properties).

### Para especificar una base de datos Apache Derby
{: #to-specify-an-apache-derby-database }
El elemento `<derby>` tiene los atributos siguientes:

| Atributo  | Descripción                                | Obligatorio | Predeterminado |
|------------|--------------------------------------------|----------|---------|
| database	 | El nombre de la base de datos.	                      | No       |	MFPDATA, MFPADM, MFPCFG, MFPPUSH, o APPCNTR, dependiendo del tipo. |
| datadir	 | El directorio que contiene las bases de datos. |	Sí	     | Ninguno    |
| schema     |	El nombre de esquema.                          |	No	     | MFPDATA, MFPCFG, MFPADMINISTRATOR, MFPPUSH, o APPCENTER, dependiendo del tipo. |

El elemento `<derby>` da soporte al elemento siguiente:

| Elemento       | Descripción	                | Recuento |
|---------------|-------------------------------|-------|
| `<property>`  | La propiedad de origen de datos o la propiedad de conexión JDBC.	| 0.. |

Para obtener más información sobre las propiedades disponibles, consulte la documentación para Clase [EmbeddedDataSource40](http://db.apache.org/derby/docs/10.8/publishedapi/jdbc4/org/apache/derby/jdbc/EmbeddedDataSource40.html). Consulte también la documentación de [Clase EmbeddedConnectionPoolDataSource40](http://db.apache.org/derby/docs/10.8/publishedapi/jdbc4/org/apache/derby/jdbc/EmbeddedConnectionPoolDataSource40.html).

Para obtener más información sobre las propiedades disponibles para un servidor Liberty, consulte la documentación de `properties.derby.embedded` en [Perfil de Liberty: Elementos de configuración en el archivo server.xml](http://ibm.biz/knowctr#SSAW57_8.5.5/com.ibm.websphere.wlp.nd.doc/autodita/rwlp_metatype_4ic.html).

Cuando se utilice el archivo **mfp-ant-deployer.jar** dentro del directorio de instalación de {{ site.data.keys.product }}, no será necesario un elemento `<driverclasspath>`.

### Para especificar una base de datos DB2
{: #to-specify-a-db2-database }
El elemento `<db2>` tiene los atributos siguientes:

| Atributo  | Descripción                                | Obligatorio | Predeterminado |
|------------|--------------------------------------------|----------|---------|
| database   | El nombre de la base de datos. | No	| MFPDATA, MFPADM, MFPCFG, MFPPUSH, o APPCNTR, dependiendo del tipo. |
| server     | El nombre de host del servidor de bases de datos.      | Sí	     | Ninguno    |
| port       | El puerto en el servidor de bases de datos.           | No	     | 50000   |
| user       | El nombre de usuario para acceder a las bases de datos.     | Este usuario no necesita privilegios ampliado en las bases de datos. Si implementa restricciones en la base de datos, puede establecer un usuario con los privilegios restringidos                                 | que se listan en Usuarios de base de datos y privilegios. | Sí | Ninguno |
| password   | La contraseña para acceder a las bases de datos.      | No       | Consultado de forma interactiva |
| schema     | El nombre de esquema.                           | No       | Depende del usuario |

Para obtener más información sobre las cuentas de usuario de DB2, consulte [Visión general del modelo de seguridad de DB2](http://ibm.biz/knowctr#SSEPGG_10.1.0/com.ibm.db2.luw.admin.sec.doc/doc/c0021804.html).  
El elemento `<db2>` da soporte al elemento siguiente:

| Elemento       | Descripción	                | Recuento |
|---------------|-------------------------------|-------|
| `<property>`  | La propiedad de origen de datos o la propiedad de conexión JDBC.	| 0.. |

Para obtener más información sobre las propiedades disponibles, consulte [Propiedades para IBM Data Server Driver for JDBC and SQLJ](http://ibm.biz/knowctr#SSEPGG_9.7.0/com.ibm.db2.luw.apdv.java.doc/src/tpc/imjcc_rjvdsprp.html).

Para obtener más información sobre las propiedades disponibles para un servidor Liberty, consulte la sección **properties.db2.jcc** en [Perfil de Liberty: Elementos de configuración en el archivo server.xml](http://ibm.biz/knowctr#SSAW57_8.5.5/com.ibm.websphere.wlp.nd.doc/autodita/rwlp_metatype_4ic.html).

El elemento `<driverclasspath>` debe contener los archivos JAR para el controlador de DB2 JDBC y para la licencia asociada. Puede descargar los controladores de DB2 JDBC desde [DB2 JDBC Driver Versions](http://www.ibm.com/support/docview.wss?uid=swg21363866).

### Para especificar una base de datos MySQL
{: #to-specify-a-mysql-database }
El elemento `<mysql>` tiene los atributos siguientes:

| Atributo  | Descripción                                | Obligatorio | Predeterminado |
|------------|--------------------------------------------|----------|---------|
| database	 | El nombre de la base de datos.	                      | No       | MFPDATA, MFPADM, MFPCFG, MFPPUSH, o APPCNTR, dependiendo del tipo. |
| server	 | El nombre de host del servidor de bases de datos.	  | Sí      | Ninguno    |
| port	     | El puerto en el servidor de bases de datos.           | No	     | 3306    |
| user	     | El nombre de usuario para acceder a las bases de datos. Este usuario no necesita privilegios ampliado en las bases de datos. Si implementa restricciones en la base de datos, puede establecer un usuario con los privilegios restringidos | que se listan en Usuarios de base de datos y privilegios. | Sí | Ninguno |
| password	 | La contraseña para acceder a las bases de datos.	  | No	     | Consultado de forma interactiva |

En lugar de **database**, **server** y **port**, también puede especificar un URL. En este caso, utilice los siguientes atributos:

| Atributo  | Descripción                                | Obligatorio | Predeterminado |
|------------|--------------------------------------------|----------|---------|
| url	     | El URL para la conexión a la base de datos.	  | Sí	     | Ninguno    |
| user	     | El nombre de usuario para acceder a las bases de datos. Este usuario no necesita privilegios ampliado en las bases de datos. Si implementa restricciones en la base de datos, puede establecer un usuario con los privilegios restringidos que se listan en Usuarios de base de datos y privilegios. | Sí  | Ninguno |
| password	 | La contraseña para acceder a las bases de datos.	  | No       | Consultado de forma interactiva |

Para obtener más información sobre las cuentas de usuario de MySQL, consulte [MySQL User Account Management](http://dev.mysql.com/doc/refman/5.5/en/user-account-management.html).

El elemento `<mysql>` da soporte al elemento siguiente:

| Elemento       | Descripción	                | Recuento |
|---------------|-------------------------------|-------|
| `<property>`  | La propiedad de origen de datos o la propiedad de conexión JDBC.	| 0.. |

Para obtener más información sobre las propiedades disponibles, consulte la documentación en [Driver/Datasource Class Names, URL Syntax and Configuration Properties for Connector/J](http://dev.mysql.com/doc/connector-j/en/connector-j-reference-configuration-properties.html).

Para obtener más información sobre las propiedades disponibles para un servidor Liberty, consulte la sección de propiedades en [Perfil de Liberty: Elementos de configuración en el archivo server.xml](http://ibm.biz/knowctr#SSAW57_8.5.5/com.ibm.websphere.wlp.nd.doc/autodita/rwlp_metatype_4ic.html).

El elemento `<driverclasspath>` debe contener un archivo JAR de MySQL Connector/J. Puede descargarlo desde [Descargar Connector/J](http://www.mysql.com/downloads/connector/j/).

### Para especificar una base de datos Oracle
{: #to-specify-an-oracle-database }
El elemento `<oracle>` tiene los atributos siguientes:

| Atributo  | Descripción                                | Obligatorio | Predeterminado |
|------------|--------------------------------------------|----------|---------|
| database   | El nombre de base de datos, o el nombre de servicio de Oracle. Nota: Siempre debe utilizar un nombre de servicio para conectarse a una base de datos PDB. | No | ORCL |
| server	 | El nombre de host del servidor de bases de datos.	Sí	| Ninguno
| port	     | El puerto en el servidor de bases de datos.	No	| 1521
| user	     | El nombre de usuario para acceder a las bases de datos. Este usuario no necesita privilegios ampliado en las bases de datos. Si implementa restricciones en la base de datos, puede establecer un usuario con los privilegios restringidos que se listan en Usuarios de base de datos y privilegios. Consulte la nota bajo esta tabla. | Sí | Ninguno |
| password	 | La contraseña para acceder a las bases de datos.	  | No       | Consultado de forma interactiva |

> **Nota:** Para el atributo **user**, utilice preferiblemente un nombre de usuario en letras mayúsculas. Los nombres de usuario de Oracle están generalmente en letras mayúsculas. A diferencia de otras herramientas de base de datos, la tarea Ant **installmobilefirstruntime** no convierte letras minúsculas a mayúsculas en el nombre de usuario. Si la tarea Ant **installmobilefirstruntime** no puede conectarse a la base de datos, intente escribir el valor para el atributo **user** en letras mayúsculas.

En lugar de **database**, **server** y **port**, también puede especificar un URL. En este caso, utilice los siguientes atributos:

| Atributo  | Descripción                                | Obligatorio | Predeterminado |
|------------|--------------------------------------------|----------|---------|
| url	     | El URL para la conexión a la base de datos.	  | Sí      | Ninguno    |
| user	     | El nombre de usuario para acceder a las bases de datos. Este usuario no necesita privilegios ampliado en las bases de datos. Si implementa restricciones en la base de datos, puede establecer un usuario con los privilegios restringidos que se listan en Usuarios de base de datos y privilegios. Consulte la nota bajo esta tabla. | Sí | Ninguno |
| password	 | La contraseña para acceder a las bases de datos.	  | No	     | Consultado de forma interactiva |

> **Nota:** Para el atributo **user**, utilice preferiblemente un nombre de usuario en letras mayúsculas. Los nombres de usuario de Oracle están generalmente en letras mayúsculas. A diferencia de otras herramientas de base de datos, la tarea Ant **installmobilefirstruntime** no convierte letras minúsculas a mayúsculas en el nombre de usuario. Si la tarea Ant **installmobilefirstruntime** no puede conectarse a la base de datos, intente escribir el valor para el atributo **user** en letras mayúsculas.

Para obtener más información sobre las cuentas de usuario de Oracle, consulte [Visión general de métodos de autenticación](http://docs.oracle.com/cd/B28359_01/server.111/b28318/security.htm#i12374).

Para obtener más información sobre los URL de conexión de base de datos Oracle, consulte la sección **Database URLs and Database Specifiers** en [Data Sources and URLs](http://docs.oracle.com/cd/B28359_01/java.111/b31224/urls.htm).

Da soporte al elemento siguiente:

| Elemento       | Descripción	                | Recuento |
|---------------|-------------------------------|-------|
| `<property>`  | La propiedad de origen de datos o la propiedad de conexión JDBC.	| 0.. |

Para obtener más información sobre las propiedades disponibles, consulte la sección **Data Sources and URLs** en [Data Sources and URLs](http://docs.oracle.com/cd/B28359_01/java.111/b31224/urls.htm).

Para obtener más información sobre las propiedades disponibles para un servidor Liberty, consulte la sección **properties.oracle** en [Perfil de Liberty: Elementos de configuración en el archivo server.xml](http://ibm.biz/knowctr#SSAW57_8.5.5/com.ibm.websphere.wlp.nd.doc/autodita/rwlp_metatype_4ic.html).

El elemento `<driverclasspath>` debe contener un archivo JAR del controlador JDBC de Oracle. Puede descargar los controladores JDBC de Oracle desde [JDBC, SQLJ, Oracle JPublisher y Universal Connection Pool (UCP)](http://www.oracle.com/technetwork/database/features/jdbc/index-091264.html).

El elemento `<property>`, que se puede utilizar dentro de los elementos `<derby>`, `<db2>`,` <mysql>`, o `<oracle>`, tiene los atributos siguientes:

| Atributo  | Descripción                                | Obligatorio | Predeterminado |
|------------|--------------------------------------------|----------|---------|
| name       | El nombre de la propiedad.	              | Sí      | Ninguno    |
| type	     | Tipo Java de los valores de propiedades, normalmente java.lang.String/Integer/Boolean. | No | java.lang.String |
| value	     | El valor de la propiedad.	              | Sí      |  Ninguno   |

## Tareas Ant para la instalación de Application Center
{: #ant-tasks-for-installation-of-application-center }
Las tareas Ant `<installApplicationCenter>`, `<updateApplicationCenter>`, y `<uninstallApplicationCenter>` se proporcionan para la instalación de Application Center Console and Services.

### Efectos de tareas
{: #task-effects-3 }
### installApplicationCenter
{: #installapplicationcenter }
La tarea `<installApplicationCenter>` configura un servidor de aplicaciones para ejecutar el archivo WAR de Application Center Services como una aplicación web, y para instalar Application Center Console. Esta tarea tiene los siguientes efectos:

* Declara la aplicación web de Application Center Services en la raíz de contexto /applicationcenter.
* Declara orígenes de datos, y en el perfil completo de WebSphere Application Server, declara también proveedores JDBC para Application Center Services.
* Despliega la aplicación web de Application Center Services en el servidor de aplicaciones.
* Declara la Application Center Console como una aplicación web en la raíz de contexto /appcenterconsole.
* Despliega el archivo WAR de Application Center Console en el servidor de aplicaciones.
* Configura propiedades de configuración para Application Center Services utilizando entradas de entorno JNDI. Las entradas de entorno JNDI relacionadas con el punto final y los proxies están comentadas. Debe eliminar el comentario en ellas en algunos casos.
* Configura usuarios que correlaciona para los roles utilizados por las aplicaciones web de Application Center Console and Services.
* En WebSphere Application Server, configura la propiedad personalizada necesaria para el contenedor web.

#### updateApplicationCenter
{: #updateApplicationCenter }
La tarea `<updateApplicationCenter>` actualiza una aplicación de Application Center ya configurada en un servidor de aplicaciones. Esta tarea tiene los siguientes efectos:

* Actualiza el archivo WAR de Application Center Services. Este archivo debe tener el mismo nombre base que el archivo WAR correspondiente desplegado anteriormente.
* Actualiza el archivo WAR de Application Center Console. Este archivo debe tener el mismo nombre base que el archivo WAR correspondiente desplegado anteriormente.

La tarea no cambia la configuración del servidor de aplicaciones, es decir, la configuración de la aplicación web, los orígenes de datos, las entradas de entorno JNDI ni las correlaciones de usuario a rol. Esta tarea sólo se aplica a una instalación realizada mediante la tarea <installApplicationCenter> descrita en este tema.

> **Nota:** En el perfil de WebSphere Application Server Liberty, la tarea no cambia las características, lo que deja una lista de características no mínimas potenciales en el archivo server.xml para la aplicación instalada.

#### uninstallApplicationCenter
{: #uninstallApplicationCenter }
La tarea Ant `<uninstallApplicationCenter>` deshace los efectos de una ejecución anterior de `<installApplicationCenter>`. Esta tarea tiene los siguientes efectos:

* Elimina la configuración de la aplicación web Application Center Services con la raíz de contexto **/applicationcenter**. Como consecuencia, la tarea también elimina los valores que se han añadido manualmente a dicha aplicación.
* Elimina los archivos WAR de Application Center Services and Console del servidor de aplicaciones.
* Elimina los orígenes de datos y, en el perfil completo de WebSphere Application Server, también elimina los proveedores JDBC para Application Center Services.
* Elimina los controladores de base de datos que utilizaron los Application Center Services del servidor de aplicaciones.
* Elimina las entradas de entorno JNDI asociadas.
* Elimina los usuarios configurados por la invocación de `<installApplicationCenter>`.

### Atributos y elementos
{: #attributes-and-elements-3 }
Las tareas `<installApplicationCenter>`, `<updateApplicationCenter>`, y `<uninstallApplicationCenter>` tienen los atributos siguientes:

| Atributo    | Descripción                                | Obligatorio | Predeterminado |
|--------------|--------------------------------------------|----------|---------|
| id	       | Distingue los diferentes despliegues del perfil completo de WebSphere Application Server. | No | Vacío |
| servicewar   | El archivo WAR para Application Center Services. | No | El archivo applicationcenter.war se encuentra en el directorio de la consola Center de la aplicación: **dir_instal_producto/ApplicationCenter/console.** |
| shortcutsDir | El directorio donde coloca los atajos. | No | Ninguno |
| aaptDir | El directorio que contiene el programa aapt, desde el paquete de herramientas de la plataforma Android SDK. | No | Ninguno |

#### id
{: #id-1 }
En los entornos del perfil completo de WebSphere Application Server, se utiliza el atributo **id** para distinguir distintos despliegues de Application Center Console and Services. Sin este atributo **id**, pueden entrar en conflicto dos archivos WAR con las mismas raíces de contexto y es posible que no se desplieguen estos archivos.

#### servicewar
{: #servicewar-1 }
Utilice el atributo **servicewar** para especificar un directorio distinto para el archivo WAR de Application Center Services. Puede especificar el nombre de este archivo WAR con una vía de acceso absoluta o relativa.

#### shortcutsDir
{: #shortcutsdir-1 }
El atributo **shortcutsDir** especifica dónde colocar atajos en Application Center Console. Si establece este atributo, se añadirán los archivos siguientes a este directorio:

* **appcenter-console.url**: Este archivo es un atajo de Windows. Abre Application Center Console en un navegador.
* **appcenter-console.sh**: Este archivo es un script de shell de UNIX. Abre Application Center Console en un navegador.

#### aaptDir
{: #aaptdir }
El programa **aapt** forma parte de la distribución de {{ site.data.keys.product }}: **dir_instal_producto/ApplicationCenter/tools/android-sdk**.  
Si este atributo no está establecido, durante la subida de una aplicación apk, Application Center lo analizará utilizando su propio código, que puede tener limitaciones.

Las tareas `<installApplicationCenter>`, `<updateApplicationCenter>`, y `<uninstallApplicationCenter>` dan soporte a los siguientes elementos:

| Elemento           | Descripción	                            | Recuento |
|-------------------|-------------------------------------------|-------|
| applicationserver	| El servidor de aplicaciones.                   | 1     |
| console           | La consola de Application Center.	        | 1     |
| database          | Las bases de datos.	                        | 1     |
| user	            | El usuario que se correlacionará con un rol de seguridad. | 0..∞  |

### Para especificar una consola de Application Center
{: #to-specify-an-application-center-console }
El elemento `<console>` recopila información para personalizar la instalación de Application Center Console. Este elemento tiene los siguientes atributos:

| Atributo    | Descripción                                      | Obligatorio | Predeterminado |
|--------------|--------------------------------------------------|----------|---------|
| warfile      | El archivo WAR para Application Center Console. |	No       | El archivo appcenterconsole.war se encuentra en el directorio de consola de Application Center: **dir_instal_producto/ApplicationCenter/console**. |

### Para especificar un servidor de aplicaciones
{: #to-specify-an-application-server-3 }
Utilice el elemento `<applicationserver>` para definir los parámetros que dependen del servidor de aplicaciones subyacente. El elemento `<applicationserver>` da soporte a los elementos siguientes.

| Elemento           | Descripción	                            | Recuento |
|-------------------|-------------------------------------------|-------|
| **websphereapplicationserver** o **was**	| Los parámetros para WebSphere Application Server. El elemento `<websphereapplicationserver>` (o `<was>` en su formato abreviado) denota una instancia de WebSphere Application Server. Se da soporte al perfil completo de WebSphere Application Server (Base, y Network Deployment), por lo que es WebSphere Application Server Liberty Core. El colectivo de Liberty no está soportado para Application Center. | 0..1 |
| tomcat            | Los parámetros para Apache Tomcat. | 0..1 |

Los atributos y elementos internos de estos elementos se describen en las tablas de la página [Tareas Ant para la instalación de entornos de ejecución de {{ site.data.keys.product_adj }}](#ant-tasks-for-installation-of-mobilefirst-runtime-environments).

### Para especificar una conexión a la base de datos de servicio
{: #to-specify-a-connection-to-the-services-database }
El elemento `<database>` recopila los parámetros que especifican una declaración de origen de datos en un servidor de aplicaciones para acceder a la base de datos de servicios.

Debe declarar una única base de datos: `<database kind="ApplicationCenter">`. Especifique el elemento `<database>` de forma parecida a la tarea Ant `<configuredatabase>`, excepto que el elemento `<database>` no tiene los elementos `<dba>` ni `<client>`. Podría tener los elementos `<property>`.

El elemento `<database>` tiene los atributos siguientes:

| Atributo    | Descripción                                            | Obligatorio | Predeterminado |
|--------------|--------------------------------------------------------|----------|---------|
| kind         | El tipo de base de datos (ApplicationCenter).              | Sí      | Ninguno    |
| validate	   | Para validar si se puede acceder a la base de datos o no. | No       | True    |

El elemento `<database>` da soporte a los elementos siguientes. Para obtener más información sobre la configuración de estos elementos de base de datos, consulte las tablas de [Tareas Ant para la instalación de entornos de ejecución de {{ site.data.keys.product_adj }}](#ant-tasks-for-installation-of-mobilefirst-runtime-environments).

| Elemento           | Descripción	                            | Recuento |
|-------------------|-------------------------------------------|-------|
| db2	            | El parámetro para bases de datos DB2.	        | 0..1  |
| derby             | El parámetro para bases de datos Apache Derby.	| 0..1  |
| mysql             | El parámetro para bases de datos MySQL.	    | 0..1  |
| oracle	        | El parámetro para bases de datos Oracle.	    | 0..1  |
| driverclasspath   | El parámetro para la vía de acceso de clase de controlador JDBC.	| 0..1  |

### Para especificar un usuario y un rol de seguridad
{: #to-specify-a-user-and-a-security-role }
El elemento `<user>` recopila los parámetros sobre un usuario para incluirlos en un determinado rol de seguridad para una aplicación.

| Atributo    | Descripción                                            | Obligatorio | Predeterminado |
|--------------|--------------------------------------------------------|----------|---------|
| role         | El rol de usuario appcenteradmin. | Sí | Ninguno |
| name	       | El nombre de usuario. | Sí | Ninguno |
| password	   | La contraseña, si debe crear el usuario.	| No | Ninguno |

## Tareas Ant para la instalación de {{ site.data.keys.mf_analytics }}
{: #ant-tasks-for-installation-of-mobilefirst-analytics }
Las tareas Ant **installanalytics**, **updateanalytics**, y **uninstallanalytics** se proporcionan para la instalación de {{ site.data.keys.mf_analytics }}.

El objetivo de estas Tareas Ant es configurar el servicio de {{ site.data.keys.mf_analytics_console }} y de {{ site.data.keys.mf_analytics }} con el almacenamiento apropiado para los datos en un servidor de aplicaciones.
La tarea instala nodos de {{ site.data.keys.mf_analytics }} que actúan como un maestro y datos. Para obtener más información, consulte [Gestión de clústeres y Elasticsearch](../analytics/configuration/#cluster-management-and-elasticsearch).

### Efectos de tareas
{: #task-effects-4 }
#### installanalytics
{: #installanalytics }
La tarea Ant **installanalytics** configura un servidor de aplicaciones para ejecutar IBM {{ site.data.keys.mf_analytics }}. Esta tarea tiene los siguientes efectos:

* Despliega los archivos WAR de {{ site.data.keys.mf_analytics }} Service and {{ site.data.keys.mf_analytics_console }} en el servidor de aplicaciones.
* Declara la aplicación web de {{ site.data.keys.mf_analytics }} Service en la raíz de contexto especificada /analytics-service.
* Declara la aplicación web {{ site.data.keys.mf_analytics_console }} en la raíz de contexto especificada /analytics.
* Establece las propiedades de configuración de {{ site.data.keys.mf_analytics_console }} and {{ site.data.keys.mf_analytics }} Services mediante entradas de entorno de JNDI.
* En el perfil de WebSphere Application Server Liberty, configura el contenedor web.
* Opcionalmente, crea usuarios para que utilicen la {{ site.data.keys.mf_analytics_console }}.

#### updateanalytics
{: #updateanalytics }
La tarea Ant **updateanalytics** actualiza los archivos WAR de las aplicaciones web de {{ site.data.keys.mf_analytics }} Service and {{ site.data.keys.mf_analytics_console }} ya configuradas en un servidor de aplicaciones. Estos archivos deben tener los mismos nombres base que los archivos WAR del proyecto desplegados anteriormente.

La tarea no cambia la configuración del servidor de aplicaciones, es decir, la configuración de la aplicación web ni las entradas de entorno JNDI.

#### uninstallanalytics
{: #uninstallanalytics }
La tarea Ant **uninstallanalytics** deshace los efectos de una ejecución anterior de **installanalytics**. Esta tarea tiene los siguientes efectos:

* Elimina la configuración de las aplicaciones web de {{ site.data.keys.mf_analytics }} Service and {{ site.data.keys.mf_analytics_console }} con sus raíces de contexto respectivas.
* Elimina los archivos WAR de {{ site.data.keys.mf_analytics }} Service and {{ site.data.keys.mf_analytics_console }} del servidor de aplicaciones.
* Elimina las entradas de entorno JNDI asociadas.

### Atributos y elementos
{: #attributes-and-elements-4 }
Las tareas **installanalytics**, **updateanalytics**, y **uninstallanalytics** tienen los atributos siguientes:

| Atributo    | Descripción                                            | Obligatorio | Predeterminado |
|--------------|--------------------------------------------------------|----------|---------|
| serviceWar   | El archivo WAR para {{ site.data.keys.mf_analytics }} Service     | No       | El archivo analytics-service.war se encuentra en el directorio Analytics. |

#### serviceWar
{: #servicewar-2 }
Utilice el atributo **serviceWar** para especificar un directorio distinto para el archivo WAR de {{ site.data.keys.mf_analytics }} Services. Puede especificar el nombre de este archivo WAR con una vía de acceso absoluta o relativa.

Las tareas `<installanalytics>`, `<updateanalytics>`, y `<uninstallanalytics>` dan soporte a los siguientes elementos:

| Atributo         | Descripción                               | Obligatorio | Predeterminado |
|-------------------|-------------------------------------------|----------|---------|
| console	        | {{ site.data.keys.mf_analytics }}   	                | Sí	   | 1       |
| user	            | El usuario que se correlacionará con un rol de seguridad.	| No	   | 0..     |
| storage	        | El tipo de almacenamiento.	                    | Sí 	   | 1       |
| applicationserver	| El servidor de aplicaciones.	                | Sí	   | 1       |
| property          | Propiedades.	                            | No 	   | 0..     |

### Para especificar una {{ site.data.keys.mf_analytics_console }}
{: #to-specify-a-mobilefirst-analytics-console }
El elemento `<console>` recopila información para personalizar la instalación de la {{ site.data.keys.mf_analytics_console }}. Este elemento tiene los siguientes atributos:

| Atributo    | Descripción                                  | Obligatorio | Predeterminado |
|--------------|----------------------------------------------|----------|---------|
| warfile	   | El archivo WAR de la consola	                      | No	     | El archivo analytics-ui.war se encuentra en el directorio Analytics. |
| shortcutsdir | El directorio donde coloca los atajos. | No	     | Ninguno    |

#### warFile
{: #warfile-2 }
Utilice el atributo **warFile** para especificar un directorio distinto para el archivo WAR de {{ site.data.keys.mf_analytics_console }}. Puede especificar el nombre de este archivo WAR con una vía de acceso absoluta o relativa.

#### shortcutsDir
{: #shortcutsdir-2 }
El atributo **shortcutsDir** especifica dónde colocar atajos en la {{ site.data.keys.mf_analytics_console }}. Si establece este atributo, puede añadir los archivos siguientes a dicho directorio:

* **analytics-console.url**: Este archivo es un atajo de Windows. Abre la {{ site.data.keys.mf_analytics_console }} en un navegador.
* **analytics-console.sh**: Este archivo es un script de shell de UNIX. Abre la {{ site.data.keys.mf_analytics_console }} en un navegador.

> Nota: Estos atajos no incluyen el parámetro de arrendatario de ElasticSearch.

El elemento `<console>` da soporte al siguiente elemento anidado:

| Elemento  | Descripción	| Recuento |
|----------|----------------|-------|
| property | Propiedades	    | 0..   |

Con este elemento, puede definir sus propias propiedades JNDI.

El elemento `<property>` tiene los atributos siguientes:

| Atributo  | Descripción                | Obligatorio | Predeterminado |
|------------|----------------------------|----------|---------|
| name       | El nombre de la propiedad.  | Sí      | Ninguno    |
| value	     | El valor de la propiedad. |	Sí      | Ninguno    |

### Para especificar un usuario y un rol de seguridad
{: #to-specify-a-user-and-a-security-role-1 }
El elemento `<user>` recopila los parámetros sobre un usuario para incluirlos en un determinado rol de seguridad para una aplicación.

| Atributo   | Descripción                                   | Obligatorio | Predeterminado |
|-------------|-----------------------------------------------|----------|---------|
| role	      | Un rol de seguridad válido para la aplicación.    | Sí      | Ninguno    |
| name	      | El nombre de usuario.	                              | Sí      | Ninguno    |
| password	  | La contraseña si el usuario debe crearse. | No       | Ninguno    |

Una vez definidos los usuarios utilizando el elemento ` <user>`, puede correlacionarlos con cualquiera de los siguientes roles para la autenticación en la {{ site.data.keys.mf_console }}:

* **mfpmonitor**
* **mfpoperator**
* **mfpdeployer**
* **mfpadmin**

### Para especificar un tipo de almacenamiento para {{ site.data.keys.mf_analytics }}
{: #to-specify-a-type-of-storage-for-mobilefirst-analytics }
El elemento `<storage>` indica qué tipo de almacenamiento subyacente {{ site.data.keys.mf_analytics }} utiliza para almacenar la información y los datos que recopila.

Da soporte al elemento siguiente:

| Elemento       | Descripción	| Recuento   |
|---------------|---------------|---------|
| elasticsearch	| ElasticSearch | clúster |

El elemento `<elasticsearch>` recopila los parámetros sobre un clúster de ElasticSearch.

| Atributo        | Descripción                                   | Obligatorio | Predeterminado   |
|------------------|-----------------------------------------------|----------|-----------|
| clusterName	   | El nombre de clúster de ElasticSearch.	           | No       | worklight |
| nodeName	       | El nombre de nodo de ElasticSearch. Este nombre debe ser exclusivo en un clúster de ElasticSearch.	| No | `worklightNode_<random number>` |
| mastersList	   | Una serie delimitada por comas que contiene el nombre de host y los puertos de los nodos maestro de ElasticSearch en el clúster de ElasticSearch (Por ejemplo: hostname1:transport-port1,hostname2:transport-port2)	           | No       |	Depende de la topología |
| dataPath	       | La ubicación del clúster de ElasticSearch.	       | No	      | Depende del servidor de aplicaciones |
| shards	       | El número de fragmentos que crea el clúster de ElasticSearch. Este valor sólo lo pueden establecer los nodos maestro creados en el clúster de ElasticSearch.	| No | 5 |
| replicasPerShard | El número de réplicas para cada fragmento del clúster de ElasticSearch. Este valor sólo lo pueden establecer los nodos maestro creados en el clúster de ElasticSearch. | No | 1 |
| transportPort	   | El puerto utilizado para la comunicación de nodo a nodo en el clúster de ElasticSearch.	| No | 9600 |

#### clusterName
{: #clustername }
Utilice el atributo **clusterName** para especificar un nombre de su elección para el clúster de ElasticSearch.

Un clúster de ElasticSearch consta de uno o varios nodos que comparten el mismo nombre de clúster, de forma que es posible especificar el mismo valor para el atributo **clusterName** si configura varios nodos.

#### nodeName
{: #nodename }
Utilice el atributo **nodeName** para especificar un nombre de su elección para el nodo que se va a configurar en el clúster de ElasticSearch. Cada nombre de nodo debe ser exclusivo en el clúster de ElasticSearch, aún cuando los nodos estén en varias máquinas.

#### mastersList
{: #masterslist }
Utilice el atributo **mastersList** para proporcionar una lista separada por comas de los nodos maestro del clúster de ElasticSearch. Cada nodo maestro de la lista debe identificarse por su nombre de host, y el puerto de comunicación de nodo a nodo de ElasticSearch. Este puerto es 9600 de forma predeterminada, o es el número de puerto que ha especificado con el atributo **transportPort** al configurar dicho nodo maestro.

Por ejemplo: `hostname1:transport-port1, hostname2:transport-port2`.

**Nota:**

* Si especifica un **transportPort** distinto al valor predeterminado 9600, también debe establecer este valor con el atributo **transportPort**. De forma predeterminada, cuando se omita el atributo **mastersList**, se realizará un intento para detectar el nombre de host y el puerto de transporte de ElasticSearch en todos los servidores de aplicaciones soportados.
* Si el servidor de aplicaciones de destino es el clúster de WebSphere Application Server Network Deployment, y si añade o elimina un servidor de este clúster en un momento posterior, debe editar esta lista manualmente para mantenerla sincronizada con el clúster de ElasticSearch.

#### dataPath
{: #datapath }
Utilice el atributo **dataPath** para especificar un directorio distinto para almacenar datos de ElasticsSearch. Puede especificar una vía de acceso absoluta o una vía de acceso relativa.

Si no se especifica el atributo **dataPath**, los datos del clúster de ElasticSearch se almacenarán en un directorio predeterminado llamado **analyticsData**, cuya ubicación depende del servidor de aplicaciones:

* Para el perfil de WebSphere Application Server Liberty, la ubicación es `${wlp.user.dir}/servers/serverName/analyticsData`.
* Para Apache Tomcat, la ubicación es `${CATALINA_HOME}/bin/analyticsData`.
* Para WebSphere Application Server y WebSphere Application Server Network Deployment, la ubicación es `${was.install.root}/profiles/<profileName>/analyticsData`.

El directorio **analyticsData** y la jerarquía de subdirectorios y archivos que contiene se crearán automáticamente en tiempo de ejecución, si no existen ya cuando el componente de {{ site.data.keys.mf_analytics }} Service reciba sucesos.

#### shards
{: #shards }
Utilice el atributo **shards** para especificar el número de fragmentos que se crearán en el clúster de ElasticSearch.

#### replicasPerShard
{: #replicaspershard }
Utilice el atributo **replicasPerShard** para especificar el número de réplicas que se crearán para cada fragmento en el clúster de ElasticSearch.

Cada fragmento puede tener cero o más réplicas. De forma predeterminada, cada fragmento tiene una réplica, pero el número de réplicas puede cambiar de forma dinámica en un índice existente de {{ site.data.keys.mf_analytics }}. Un fragmento de réplica no se puede iniciar nunca en el mismo nodo que su fragmento.

#### transportPort
{: #transportport }
Utilice el atributo **transportPort** para especificar un puerto que otros nodos del clúster de ElasticSearch deben utilizar al comunicarse con este nodo. Debe asegurarse de que este puerto esté disponible y accesible si este nodo está detrás de un proxy o de un cortafuegos.

### Para especificar un servidor de aplicaciones
{: #to-specify-an-application-server-4 }
Utilice el elemento `<applicationserver>` para definir los parámetros que dependen del servidor de aplicaciones subyacente. El elemento `<applicationserver>` da soporte a los elementos siguientes.

**Nota:** Los atributos y los elementos internos de este elemento se describen en las tablas de [Tareas Ant para la instalación de entornos de ejecución de {{ site.data.keys.product_adj }}](#ant-tasks-for-installation-of-mobilefirst-runtime-environments).

| Elemento                                   | Descripción	| Recuento   |
|-------------------------------------------|---------------|---------|
| **websphereapplicationserver** o **was** | Los parámetros para WebSphere Application Server.	| 0..1 |
| tomcat	                                | Los parámetros para Apache Tomcat.	| 0..1 |

### Para especificar propiedades JNDI personalizadas
{: #to-specify-custom-jndi-properties }
Los elementos `<installanalytics>`, `<updateanalytics>`, y `<uninstallanalytics>` dan soporte al elemento siguiente:

| Elemento  | Descripción | Recuento |
|----------|-------------|-------|
| property | Propiedades	 | 0..   |

Al utilizar este elemento, puede definir sus propias propiedades JNDI.

Este elemento tiene los siguientes atributos:

| Atributo  | Descripción                | Obligatorio | Predeterminado |
|------------|----------------------------|----------|---------|
| name       | El nombre de la propiedad.  | Sí      | Ninguno    |
| value	     | El valor de la propiedad. |	Sí      | Ninguno    |

## Bases de datos de tiempo de ejecución interno
{: #internal-runtime-databases }
Obtenga más información acerca de las tablas de base de datos de tiempo de ejecución, su finalidad, y el orden de magnitud de datos almacenados en cada tabla. En bases de datos relacionales, las entidades están organizadas en tablas de base de datos.

### Base de datos utilizada por el tiempo de ejecución de {{ site.data.keys.mf_server }}
{: #database-used-by-mobilefirst-server-runtime }
En la tabla siguiente se proporciona una lista de tablas de base de datos de tiempo de ejecución, sus descripciones, y cómo se utilizan en bases de datos relacionales.

| Nombre de tabla de base de datos relacional | Descripción | Orden de magnitud |
|--------------------------------|-------------|--------------------|
| LICENSE_TERMS	                 | Almacena las diversas métricas de licencias capturadas cada vez que se ejecuta la tarea de decomisionado de dispositivos. | Decenas de filas. Este valor no supera el valor establecido por la propiedad mfp.device.decommission.when de la propiedad JNDI. Para obtener más información sobre propiedades JNDI, consulte [Lista de propiedades JNDI para el tiempo de ejecución de {{ site.data.keys.product_adj }}](../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime) |
| ADDRESSABLE_DEVICE	         | Almacena las métricas de dispositivos dirigibles cada día. También se añade una entrada cada vez que se inicia un clúster.	| Acerca de 400 filas. Las entradas más antiguas de 13 meses se suprimen cada día. |
| MFP_PERSISTENT_DATA	         | Almacena instancias de aplicaciones cliente que se han registrado con el servidor OAuth, incluida la información sobre el dispositivo, la aplicación, usuarios asociados con el cliente y el estado del dispositivo. | Una fila por par de dispositivos y aplicaciones. |
| MFP_PERSISTENT_CUSTOM_ATTR	 | Los atributos personalizados que están asociados con las instancias de aplicaciones cliente. Los atributos personalizados son específicos de la aplicación registrados por la aplicación por cada instancia de cliente. | Cero o más filas por par de dispositivos y aplicaciones |
| MFP_TRANSIENT_DATA	         | Contexto de autenticación de clientes y dispositivos | Dos filas por par de dispositivos y aplicaciones; si se utiliza el inicio de sesión único de dispositivos en dos filas adicionales por dispositivo. Para obtener más información sobre SSO, consulte [Configuración de inicio de sesión único de dispositivo (SSO)](../../../authentication-and-security/device-sso). |
| SERVER_VERSION	             | La versión del producto.	| Una fila |

### Base de datos utilizada por el servicio de administración de {{ site.data.keys.mf_server }}
{: #database-used-by-mobilefirst-server-administration-service }
En la tabla siguiente se proporciona una lista de tablas de la base de datos de administración, sus descripciones, y cómo se utilizan en bases de datos relacionales.

| Nombre de tabla de base de datos relacional | Descripción | Orden de magnitud |
|--------------------------------|-------------|--------------------|
| ADMIN_NODE	                 | Almacena información sobre los servidores que ejecutan el servicio de administración. No se utilizará esta entidad en una topología autónoma con sólo un servidor. | Una fila por servidor; vacío si se utiliza un servidor autónomo. |
| AUDIT_TRAIL	                 | Almacena un seguimiento de auditoría de todas las acciones administrativas realizadas con el servicio de administración. | Miles de filas. |
| CONFIG_LINKS	                 | Almacena los enlaces en el servicio de Live Update. Los adaptadores y las aplicaciones podrían tener configuraciones almacenadas en el servicio de Live Update, y los enlaces se utilizarán para buscar dichas configuraciones.	| Cientos de filas. Se utilizan de 2 a 3 filas por adaptador. Se utilizan de 4 a 6 filas por aplicación. |
| FARM_CONFIG	                 | Almacena la configuración de nodos de granja de servidores cuando se utiliza una granja de servidores. | Decenas de filas; vacío si no se utiliza ninguna granja de servidores. |
| GLOBAL_CONFIG	                 | Almacena algunos datos de configuración global. | 1 fila. |
| PROJECT	                     | Almacena los nombres de los proyectos desplegados. | Decenas de filas. |
| PROJECT_LOCK	                 | Tareas de sincronización del clúster interno. | Decenas de filas. |
| TRANSACTIONS	                 | Tabla de sincronización del clúster interno; almacena el estado de todas las acciones de administración actuales. | Decenas de filas. |
| MFPADMIN_VERSION	             | La versión del producto.	| Una fila. |

### Base de datos utilizada por el servicio de Live Update de {{ site.data.keys.mf_server }}
{: #database-used-by-mobilefirst-server-live-update-service }
En la tabla siguiente se proporciona una lista de tablas de base de datos de servicio de Live Update, sus descripciones, y cómo se utilizan en bases de datos relacionales.

| Nombre de tabla de base de datos relacional | Descripción | Orden de magnitud |
|--------------------------------|-------------|--------------------|
| CS_SCHEMAS	                 | Almacena los esquemas versionados que existen en la plataforma.	| Una fila por esquema. |
| CS_CONFIGURATIONS	             | Almacena instancias de configuraciones para cada esquema versionado. | Una fila por configuración |
| CS_TAGS	                     | Almacena los campos en los que se pueden realizar búsquedas y los valores para cada instancia de configuración.	| Fila para cada nombre de campo y valor para cada campos en el que se pueden realizar búsquedas en la configuración. |
| CS_ATTACHMENTS	             | Almacena los archivos adjuntos para cada instancia de la configuración. | Una fila por archivo adjunto. |
| CS_VERSION	                 | Almacena la versión del MFP que ha creado las tablas o instancias. | Fila única en la tabla con la versión de MFP. |

### Base de datos utilizada por el servicio de envío por push de {{ site.data.keys.mf_server }}
{: #database-used-by-mobilefirst-server-push-service }
En la tabla siguiente se proporciona una lista de tablas de base de datos de servicio de envío por push, sus descripciones, y cómo se utilizan en bases de datos relacionales.

| Nombre de tabla de base de datos relacional | Descripción | Orden de magnitud |
|--------------------------------|-------------|--------------------|
| PUSH_APPS	                     | Tabla de notificaciones push; almacena detalles de aplicaciones push. | Una fila por aplicación. |
| PUSH_ENV	                     | Tabla de notificaciones push; almacena detalles de entornos push. | Decenas de filas. |
| PUSH_TAGS	                     | Tabla de notificaciones push; almacena detalles de etiquetas definidas.	     | Decenas de filas. |
| PUSH_DEVICES	                 | Tabla de notificaciones push. Almacena un registro por dispositivo.	         | Una fila por dispositivo. |
| PUSH_SUBSCRIPTIONS	         | Tabla de notificaciones push. Almacena un registro por suscripción de etiquetas. | Una fila por suscripción de dispositivos. |
| PUSH_MESSAGES	                 | Tabla de notificaciones push; almacena detalles de mensajes push.	 | Decenas de filas. |
| PUSH_MESSAGE_SEQUENCE_TABLE	 | Tabla de notificaciones push; almacena el ID de secuencia generado.	 | Una fila. |
| PUSH_VERSION	                 | La versión del producto.	                                         | Una fila. |

Para obtener más información sobre cómo configurar las bases de datos, consulte [Configuración de bases de datos](../databases).

## Archivos de configuración de ejemplo
{{ site.data.keys.product }} incluye un número de archivos de configuración de ejemplo para ayudarle a comenzar con las tareas Ant para instalar el {{ site.data.keys.mf_server }}.

La forma más sencilla de empezar con estas tareas Ant es trabajar con los archivos de configuración de ejemplo que se proporcionan en el directorio **MobileFirstServer/configuration-samples/** de la distribución de {{ site.data.keys.mf_server }}. Para obtener más información sobre cómo instalar {{ site.data.keys.mf_server }} con tareas Ant, consulte [Instalación con Tareas Ant](../appserver/#installing-with-ant-tasks).

### Lista de archivos de configuración de ejemplo
{: #list-of-sample-configuration-files }
Elija el archivo de configuración de ejemplo apropiado. Se proporcionan los siguientes archivos.

| Tarea                                                     | Derby                     | DB2                     | MySQL                     | Oracle                      |
|----------------------------------------------------------|---------------------------|-------------------------|---------------------------|-----------------------------|
| Crear bases de datos con credenciales de administradores de bases de datos | create-database-derby.xml | create-database-db2.xml | create-database-mysql.xml | create-database-oracle.xml
| Instalar {{ site.data.keys.mf_server }} en Liberty	                   | configure-liberty-derby.xml | configure-liberty-db2.xml | configure-liberty-mysql.xml | (Consulte Nota sobre MySQL) | configure-liberty-oracle.xml |
| Instalar {{ site.data.keys.mf_server }} en el perfil completo de WebSphere Application Server, servidor único |	configure-was-derby.xml | configure-was-db2.xml | configure-was-mysql.xml (Consulte Nota sobre MySQL) | configure-was-oracle.xml |
| Instalar {{ site.data.keys.mf_server }} en WebSphere Application Server Network Deployment (Consulte Nota sobre los archivos de configuración) | configure-wasnd-cluster-derby.xml, configure-wasnd-server-derby.xml, configure-wasnd-node-derby.xml. configure-wasnd-cell-derby.xml | configure-wasnd-cluster-db2.xml, configure-wasnd-server-db2.xml, configure-wasnd-node-db2.xml, configure-wasnd-cell-db2.xml | configure-wasnd-cluster-mysql.xml (Consulte Nota sobre MySQL),  configure-wasnd-server-mysql.xml (Consulte Nota sobre MySQL), configure-wasnd-node-mysql.xml (Consulte Nota sobre MySQL), configure-wasnd-cell-mysql.xml | configure-wasnd-cluster-oracle.xml, configure-wasnd-server-oracle.xml, configure-wasnd-node-oracle.xml, configure-wasnd-cell-oracle.xml |
| Instalar {{ site.data.keys.mf_server }} en Apache Tomcat	           | configure-tomcat-derby.xml | configure-tomcat-db2.xml | configure-tomcat-mysql.xml | configure-tomcat-oracle.xml |
| Instalar {{ site.data.keys.mf_server }} en el colectivo de Liberty	       | No relevante              | configure-libertycollective-db2.xml | configure-libertycollective-mysql.xml | configure-libertycollective-oracle.xml |

**Nota sobre MySQL:** MySQL en combinación con el perfil de WebSphere Application Server Liberty o el perfil completo de WebSphere Application Server no se clasifica como una configuración soportada. Para obtener más información, consulte WebSphere Application Server Support Statement. Considere la posibilidad de utilizar IBM DB2 u otra base de datos soportada por WebSphere Application Server para beneficiarse de una configuración que esté completamente soportada por IBM Support.

**Nota sobre archivos de configuración para WebSphere Application Server Network Deployment:** Los archivos de configuración para **wasnd** contienen un ámbito que se puede establecer en **clúster**, **nodo**, **servidor**, o **célula**. Por ejemplo, para **configure-wasnd-cluster-derby.xml**, el ámbito es **clúster**. Estos tipos de ámbito definen el destino de despliegue tal como se indica a continuación:

* **clúster**: Para desplegar en un clúster.
* **servidor**: Para desplegar en un único servidor gestionado por el gestor de despliegue.
* **nodo**: Para desplegar en todos los servidores que se ejecutan en un nodo, pero que no pertenecen a un clúster.
* **célula**: Para desplegar en todos los servidores en una célula.

## Archivos de configuración de ejemplo para {{ site.data.keys.mf_analytics }}
{: #sample-configuration-files-for-mobilefirst-analytics }
{{ site.data.keys.product }} incluye varios archivos de configuración de ejemplo para ayudarle a comenzar con las tareas Ant para instalar los Servicios de {{ site.data.keys.mf_analytics }}, y la {{ site.data.keys.mf_analytics_console }}.

La forma más sencilla de empezar con las tareas Ant `<installanalytics>`, `<updateanalytics>`, y `<uninstallanalytics>` es trabajando con los archivos de configuración de ejemplo proporcionados en el directorio **Analytics/configuration-samples/** de la distribución de {{ site.data.keys.mf_server }}.

### Paso 1
{: #step-1 }
Elija el archivo de configuración de ejemplo apropiado. Se proporcionan los siguientes archivos XML. Se les conoce como **configure-file.xml** en los pasos siguientes.

| Tarea | Servidor de aplicaciones |
|------|--------------------|
| Instale {{ site.data.keys.mf_analytics }} Services and Console en el perfil de WebSphere Application Server Liberty | configure-liberty-analytics.xml |
| Instale {{ site.data.keys.mf_analytics }} Services and Console en Apache Tomcat | configure-tomcat-analytics.xml |
| Instale {{ site.data.keys.mf_analytics }} Services and Console en el perfil completo de WebSphere Application Server | configure-was-analytics.xml |
| Instale {{ site.data.keys.mf_analytics }} Services and Console en WebSphere Application Server Network Deployment, servidor único | configure-wasnd-server-analytics.xml |
| Instale {{ site.data.keys.mf_analytics }} Services and Console en WebSphere Application Server Network Deployment, célula | configure-wasnd-cell-analytics.xml |
| Instale {{ site.data.keys.mf_analytics }} Services and Console en WebSphere Application Server Network Deployment, nodo | configure-wasnd-node.xml |
| Instale {{ site.data.keys.mf_analytics }} Services and Console en WebSphere Application Server Network Deployment, clúster | configure-wasnd-cluster-analytics.xml |

**Nota sobre los archivos de configuración para WebSphere Application Server Network Deployment:**  
Los archivos de configuración para wasnd contienen un ámbito que se puede establecer en **clúster**, **nodo**, **servidor**, o **célula**. Por ejemplo, para **configure-wasnd-cluster-analytics.xml**, el ámbito es **clúster**. Estos tipos de ámbito definen el destino de despliegue tal como se indica a continuación:

* **clúster**: Para desplegar en un clúster.
* **servidor**: Para desplegar en un único servidor gestionado por el gestor de despliegue.
* **nodo**: Para desplegar en todos los servidores que se ejecutan en un nodo, pero que no pertenecen a un clúster.
* **célula**: Para desplegar en todos los servidores en una célula.

### Paso 2
{: #step-2 }
Cambie los derechos de acceso del archivo del archivo de ejemplo para que sean lo más restrictivos posible. El paso 3 requiere que proporcione algunas contraseñas. Si debe impedir que otros usuarios del mismo sistema conozcan estas contraseñas, debe eliminar los permisos de lectura del archivo para usuarios distintos a usted mismo. Puede utilizar un mandato, como los ejemplos siguientes:

En UNIX: `chmod 600 configure-file.xml`
En Windows: `cacls configure-file.xml /P Administrators:F %USERDOMAIN%\%USERNAME%:F`

### Paso 3
{: #step-3 }
De forma similar, si el servidor de aplicaciones es el perfil de WebSphere Application Server Liberty, o Apache Tomcat, y el servidor está pensado para iniciarse sólo desde la cuenta de usuario, debe también eliminar los permisos de lectura para usuarios que no sean usted mismo desde los siguientes archivos:

* Para el perfil de WebSphere Application Server Liberty: **wlp/usr/servers/<server>/server.xml**
* Para Apache Tomcat: **conf/server.xml**

### Paso 4
{: #step-4 }
Sustituya los valores de marcador por las propiedades que hay al principio del archivo.

**Nota:**  
Los caracteres especiales siguientes deben escaparse cuando se utilicen en los valores de los scripts Ant XML:

* El signo de dólar (`$`) se debe escribir como $$, a no ser que desee hacer referencia explícitamente a una variable Ant mediante la sintaxis `${variable}`, tal como se describe en la sección Propiedades de Apache Ant Manual.
* El carácter ampersand (`&`) se debe escribir como `&amp;`, a no ser que desee explícitamente hacer referencia a una entidad XML.
* Las comillas dobles (`"`) se deben escribir como `&quot;`, excepto cuando estén dentro de una serie que esté entre comillas simples.

### Paso 5
{: #step-5 }
Ejecute el mandato: `ant -f configure-file.xml install`

Este mandato instala los componentes {{ site.data.keys.mf_analytics }} Services and {{ site.data.keys.mf_analytics_console }} en el servidor de aplicaciones.
Para instalar componentes actualizados de {{ site.data.keys.mf_analytics }} Services and {{ site.data.keys.mf_analytics_console }}, por ejemplo si aplica un fixpack de {{ site.data.keys.mf_server }}, ejecute el siguiente mandato: `ant -f configure-file.xml minimal-update`.

Para invertir el paso de instalación, ejecute el mandato: `ant -f configure-file.xml uninstall`

Este mandato desinstala los componentes {{ site.data.keys.mf_analytics }} Services and {{ site.data.keys.mf_analytics_console }}.
