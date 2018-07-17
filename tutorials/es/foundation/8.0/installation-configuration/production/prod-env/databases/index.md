---
layout: tutorial
title: Configuración de bases de datos
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
Los siguientes componentes de {{ site.data.keys.mf_server_full }} necesitan almacenar datos técnicos en una base de datos:

* Servicio de administración de {{ site.data.keys.mf_server }}
* Servicio de Live Update de {{ site.data.keys.mf_server }}
* Servicio de envío por push de {{ site.data.keys.mf_server }}
* Tiempo de ejecución de {{ site.data.keys.product }}

> **Nota:** Si hay instaladas varias instancias de tiempo de ejecución con distintas raíces de contexto, cada instancia necesitará su propio conjunto de tablas.
> La base de datos puede ser una base de datos relacional como IBM DB2, Oracle o MySQL.

#### Bases de datos relacionales (DB2, Oracle o MySQL)
{: #relational-databases-db2-oracle-or-mysql }
Cada componente necesita un conjunto de tablas. Las tablas pueden crearse manualmente ejecutando los scripts SQL específicos de cada componente (consulte [Crear las tablas de base de datos manualmente](#create-the-database-tables-manually)), utilizando tareas Ant, o la Herramienta de configuración del servidor. Los nombres de tabla de cada componente no se solapan. Por lo tanto, es posible colocar todas las tablas de estos componentes en un único esquema.

Sin embargo, si decide instalar varias instancias de tiempo de ejecución de {{ site.data.keys.product }}, cada una con su propia raíz de contexto en el servidor de aplicaciones, cada instancia necesitará su propio conjunto de tablas. En este caso, deben estar en distintos esquemas.

> **Nota sobre DB2:** Los licenciatarios de {{ site.data.keys.product_adj }} están autorizados a utilizar DB2 como un sistema de soporte para Foundation. Para beneficiarse de esto, debe, después de instalar el software de DB2:
>
> * Descargar la imagen de activación de uso restringido directamente desde el [sitio web de IBM Passport Advantage (PPA)](https://www-01.ibm.com/software/passportadvantage/pao_customer.html)
> * Aplicar el archivo de licencia de activación de uso restringido **db2xxxx.lic** utilizando el mandato **db2licm**
>
> Obtenga más información en el [DB2 IBM Knowledge Center](http://www.ibm.com/support/knowledgecenter/SSEPGG_10.5.0/com.ibm.db2.luw.kc.doc/welcome.html)

#### Ir a
{: #jump-to }

* [Usuarios de base de datos y privilegios](#database-users-and-privileges)
* [Requisitos de la base de datos](#database-requirements)
* [Crear las tablas de base de datos manualmente](#create-the-database-tables-manually)
* [Crear las tablas de base de datos con la Herramienta de configuración del servidor](#create-the-database-tables-with-the-server-configuration-tool)
* [Crear las tablas de base de datos con tareas Ant](#create-the-database-tables-with-ant-tasks)

## Usuarios de base de datos y privilegios
{: #database-users-and-privileges }
En el tiempo de ejecución, las aplicaciones de {{ site.data.keys.mf_server }} en el servidor de aplicaciones utilizan orígenes de datos como recursos para obtener conexión a bases de datos relacionales. El origen de datos necesita un usuario con determinados privilegios para acceder a la base de datos.

Debe configurar un origen de datos para cada aplicación de {{ site.data.keys.mf_server }} que se despliega en el servidor de aplicaciones para tener acceso a la base de datos relacional. El origen de datos necesita un usuario con privilegios específicos para acceder a la base de datos. El número de usuarios que necesita crear depende del procedimiento de instalación que se utiliza para desplegar aplicaciones de {{ site.data.keys.mf_server }} en el servidor de aplicaciones.

### Instalación con la Herramienta de configuración del servidor
{: #installation-with-the-server-configuration-tool }
El mismo usuario se utiliza para todos los componentes (servicio de administración de {{ site.data.keys.mf_server }}, servicio de configuración de {{ site.data.keys.mf_server }}, servicio de envío por push de {{ site.data.keys.mf_server }} y tiempo de ejecución de {{ site.data.keys.product }})

### Instalación con tareas Ant
{: #installation-with-ant-tasks }
Los archivos Ant de ejemplo que se proporcionan en la distribución del producto utilizan el mismo usuario para todos los componentes. Sin embargo, es posible modificar los archivos Ant para que tengan diferentes usuarios:

* El mismo usuario para el servicio de administración y el servicio de configuración, ya que no se pueden instalar por separado con tareas Ant.
* Un usuario distinto para el tiempo de ejecución
* Un usuario distinto para el servicio de envío por push.

### Instalación manual
{: #manual-installation }
Es posible asignar un origen de datos distinto y, por lo tanto, un usuario distinto, a cada uno de los componentes de {{ site.data.keys.mf_server }}.
En el tiempo de ejecución, los usuarios deben tener los privilegios siguientes en las tablas y las secuencias de sus datos:

* SELECT TABLE
* INSERT TABLE
* UPDATE TABLE
* DELETE TABLE
* SELECT SEQUENCE

Si las tablas no se crean manualmente antes de ejecutar la instalación con Tareas Ant o la Herramienta de configuración del servidor, asegúrese de que tenga un usuario que pueda crear las tablas. También necesita los privilegios siguientes:

* CREATE INDEX
* CREATE SEQUENCE
* CREATE TABLE

Para una actualización del producto, necesita estos privilegios adicionales:

* ALTER TABLE
* CREATE VIEW
* DROP INDEX
* DROP SEQUENCE
* DROP TABLE
* DROP VIEW

## Requisitos de la base de datos
{: #database-requirements }
La base de datos almacena todos los datos de las aplicaciones de {{ site.data.keys.mf_server }}. Antes de instalar los componentes de {{ site.data.keys.mf_server }}, asegúrese de que se cumplan los requisitos de base de datos.

* [Base de datos DB2 y requisitos de usuario](#db2-database-and-user-requirements)
* [Base de datos Oracle y requisitos de usuario](#oracle-database-and-user-requirements)
* [Base de datos MySQL y requisitos de usuario](#mysql-database-and-user-requirements)

> Para obtener una lista actualizada de versiones de software de bases de datos soportadas, consulte la página [Requisitos del sistema](../../../../product-overview/requirements/).

### Base de datos DB2 y requisitos de usuario
{: #db2-database-and-user-requirements }
Revise el requisito de base de datos para DB2. Siga los pasos para crear el usuario, la base de datos y configurar la base de datos para que cumpla el requisito específico.

Asegúrese de establecer el juego de caracteres de base de datos como UTF-8.

El tamaño de página de la base de datos debe ser de al menos 32768. El procedimiento siguiente crea una base de datos con un tamaño de página de 32768. También crea un usuario (**mfpuser**) y, a continuación, otorga a la base de datos acceso a este usuario. A continuación, este usuario lo podrá utilizar la Herramienta de configuración del servidor o las tareas Ant para crear las tablas.

1. Cree un usuario del sistema con el nombre, por ejemplo, **mfpuser** en un grupo de administración de DB2 como **DB2USERS**, utilizando los mandatos apropiados para el sistema operativo. Otórguele una contraseña, por ejemplo, **mfpuser**.
2. Abra un procesador de línea de mandatos de DB2, con un usuario que tenga permisos **SYSADM** o **SYSCTRL**.
    * En sistemas Windows, pulse **Inicio → IBM DB2 → Procesador de línea de mandatos**.
    * En sistemas Linux o UNIX, vaya a **~/sqllib/bin** y especifique `./db2`.
3. Para crear la base de datos de {{ site.data.keys.mf_server }}, especifique las sentencias SQL similares al ejemplo siguiente.

Sustituya el nombre de usuario **mfpuser** por el suyo propio.

```sql
CREATE DATABASE MFPDATA COLLATE USING SYSTEM PAGESIZE 32768
CONNECT TO MFPDATA
GRANT CONNECT ON DATABASE TO USER mfpuser
DISCONNECT MFPDATA
QUIT
```

### Base de datos Oracle y requisitos de usuario
{: #oracle-database-and-user-requirements }
Revise el requisito de base de datos para Oracle. Siga los pasos para crear el usuario, la base de datos y configurar la base de datos para que cumpla el requisito específico.

Asegúrese de establecer el juego de caracteres de la base de datos como juego de caracteres Unicode (AL32UTF8) y el juego de caracteres nacional como UTF8 - Unicode 3.0 UTF-8.  

El usuario de tiempo de ejecución (tal como se describe en [Usuarios y privilegios de base de datos](#database-users-and-privileges)) debe tener un espacio de tabla asociado y suficiente cuota para escribir los datos técnicos que necesitan los servicios de {{ site.data.keys.product }}. Para obtener más información sobre las tablas que utiliza el producto, consulte [Bases de datos de tiempo de ejecución internas](../../installation-reference/#internal-runtime-databases).

Está previsto que las tablas se creen en el esquema predeterminado del usuario de tiempo de ejecución. Las tareas Ant y la Herramienta de configuración del servidor crean las tablas en el esquema predeterminado del usuario pasado como argumento. Para obtener más información sobre la creación de tablas, consulte [Creación de tablas de base de datos Oracle manualmente](#creating-the-oracle-database-tables-manually).

El procedimiento crea una base de datos si es necesario. Un usuario que pueda crear tablas y un índice en esta base de datos se añadirá y se utilizará como usuario de tiempo de ejecución.

1. Si todavía no tiene una base de datos, utilice Oracle Database Configuration Assistant (DBCA) y siga los pasos del asistente para crear una nueva base de datos de finalidad general denominada ORCL en este ejemplo:
    * Utilice el nombre de base de datos global **ORCL\_su\_dominio**, y el identificador de sistema (SID) **ORCL**.
    * En el separador **Scripts personalizados** del paso **Contenido de base de datos**, no ejecute los scripts de SQL, porque primero debe crear una cuenta de usuario.
    * En el separador **Juegos de caracteres** del paso **Parámetros de inicialización**, seleccione **Utilizar juego de caracteres Unicode (AL32UTF8) y UTF8 - Juego de caracteres nacional Unicode 3.0 UTF-8**.
    * Complete el procedimiento, aceptando los valores predeterminados.
2. Cree un usuario de base de datos utilizando Oracle Database Control o el intérprete de línea de mandatos de Oracle SQLPlus.
3. Utilizando Oracle Database Control:
    * Conéctese como **SYSDBA**.
    * Vaya a la página **Usuarios** y pulse **Servidor**, luego **Usuarios** en la sección **Seguridad**.
    * Cree un usuario, por ejemplo **MFPUSER**.
    * Asigne los atributos siguientes:
        * **Perfil**: DEFAULT
        * **Autenticación**: contraseña
        * **Espacio de tabla predeterminado**: USERS
        * **Espacio de tabla temporal**: TEMP
        * **Estado**: Desbloqueado
        * Añadir privilegio de sistema: CREATE SESSION
        * Añadir privilegio de sistema: CREATE SEQUENCE
        * Añadir privilegio de sistema: CREATE TABLE
        * Añadir cuota: Ilimitado para los USERS del espacio de tabla
    * Utilización del intérprete de línea de mandatos de Oracle SQLPlus:

Los mandatos del ejemplo siguiente crean un usuario denominado **MFPUSER** para la base de datos:

```sql
CONNECT SYSTEM/<SYSTEM_password>@ORCL
CREATE USER MFPUSER IDENTIFIED BY MFPUSER_password DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;
GRANT CREATE SESSION, CREATE SEQUENCE, CREATE TABLE TO MFPUSER;
DISCONNECT;
```

### Base de datos MySQL y requisitos de usuario
{: #mysql-database-and-user-requirements }
Revise el requisito de base de datos para MySQL. Siga los pasos para crear el usuario, la base de datos y configurar la base de datos para que cumpla el requisito específico.

Asegúrese de que establece el juego de caracteres en UTF8.

Las propiedades siguientes deben asignarse con los valores apropiados:

* max_allowed_packet con 256 M o más
* innodb_log_file_size con 250 M o más

Para obtener más información sobre cómo establecer las propiedades, consulte la [documentación de MySQL](http://dev.mysql.com/doc/).  
El procedimiento crea una base de datos (MFPDATA) y un usuario (mfpuser) que se pueden conectar a la base de datos con todos los privilegios de un host (mfp-host).

1. Ejecute un cliente de línea de mandatos de MySQL con la opción `-u root`.
2. Especifique los mandatos siguientes:

   ```sql
   CREATE DATABASE MFPDATA CHARACTER SET utf8 COLLATE utf8_general_ci;
   GRANT ALL PRIVILEGES ON MFPDATA.* TO 'mfpuser'@'mfp-host' IDENTIFIED BY 'mfpuser-password';
   GRANT ALL PRIVILEGES ON MFPDATA.* TO 'mfpuser'@'localhost' IDENTIFIED BY 'mfpuser-password';
   FLUSH PRIVILEGES;
   ```

    Donde mfpuser antes del signo "arroba" (@) es el nombre de usuario, **mfpuser-password** después de **IDENTIFIED BY** es la contraseña, y **mfp-host** es el nombre del host en el que se ejecuta {{ site.data.keys.product_adj }}.

    El usuario debe poder conectarse al servidor MySQL desde los hosts que ejecutan el servidor de aplicaciones Java con las aplicaciones de {{ site.data.keys.mf_server }} instaladas.

## Cree las tablas de base de datos manualmente
{: #create-the-database-tables-manually }
Las tablas de base de datos para las aplicaciones de {{ site.data.keys.mf_server }} se pueden crear manualmente, con Tareas Ant, o con la Herramienta de configuración del servidor. Los temas proporcionan la explicación y los detalles sobre cómo crearlas manualmente.

* [Creación de las tablas de base de datos DB2 manualmente](#creating-the-db2-database-tables-manually)
* [Creación de las tablas de base de datos Oracle manualmente](#creating-the-oracle-database-tables-manually)
* [Creación de las tablas de base de datos MySQL manualmente](#creating-the-mysql-database-tables-manually)

### Creación de las tablas de base de datos DB2 manualmente
{: #creating-the-db2-database-tables-manually }
Utilice los scripts SQL que se proporcionan en la instalación de {{ site.data.keys.mf_server }} para crear las tablas de base de datos DB2.

Tal como se describe en la sección Visión general, los cuatro componentes de {{ site.data.keys.mf_server }} necesitan tablas. Pueden crearse en el mismo esquema o en diferentes esquemas. Sin embargo, se aplican algunas restricciones en función del modo en que se desplieguen las aplicaciones de {{ site.data.keys.mf_server }} en el servidor de aplicaciones de Java. Son similares al tema sobre los posibles usuarios para DB2 tal como se describe en [Usuarios de base de datos y privilegios](#database-users-and-privileges).

#### Instalación con la Herramienta de configuración del servidor
{: #installation-with-the-server-configuration-tool-1 }
Se utiliza el mismo esquema para todos los componentes (servicio de administración de {{ site.data.keys.mf_server }}, servicio de Live Update de {{ site.data.keys.mf_server }}, servicio de envío por push de {{ site.data.keys.mf_server }} y tiempo de ejecución de {{ site.data.keys.product }})

#### Instalación con tareas Ant
{: #installation-with-ant-tasks-1 }
Los archivos Ant de ejemplo que se proporcionan en la distribución del producto utilizan el mismo esquema para todos los componentes. Sin embargo, es posible modificar los archivos Ant para que tengan distintos esquemas:

* El mismo esquema para el servicio de administración y el servicio de Live Update, ya que no se pueden instalar por separado con tareas Ant.
* Un esquema distinto para el tiempo de ejecución.
* Un esquema distinto para el servicio de envío por push.

#### Instalación manual
{: #manual-installation-1 }
Es posible asignar un origen de datos distinto y, por lo tanto, un esquema distinto, a cada uno de los componentes de {{ site.data.keys.mf_server }}.  
Los scripts para crear las tablas son los siguientes:

* Para el servicio de administración, en **mfp\_install\_dir/MobileFirstServer/databases/create-mfp-admin-db2.sql**.
* Para el servicio de Live Update, en **mfp\_install\_dir/MobileFirstServer/databases/create-configservice-db2.sql**.
* Para el componente de tiempo de ejecución, en **mfp\_install\_dir/MobileFirstServer/databases/create-runtime-db2.sql**.
* Para el servicio de envío por push, en **mfp\_install\_dir/PushService/databases/create-push-db2.sql**.

El procedimiento siguiente crea las tablas para todas las aplicaciones en el mismo esquema (MFPSCM). Se da por supuesto que ya se ha creado una base de datos y un usuario. Para obtener más información, consulte [Base de datos DB2 y requisitos de usuario](#db2-database-and-user-requirements).

Ejecute DB2 con los mandatos siguientes con el usuario (mfpuser):

```sql
db2 CONNECT TO MFPDATA
db2 SET CURRENT SCHEMA = 'MFPSCM'
db2 -vf mfp_install_dir/MobileFirstServer/databases/create-mfp-admin-db2.sql
db2 -vf mfp_install_dir/MobileFirstServer/databases/create-configservice-db2.sql -t
db2 -vf mfp_install_dir/MobileFirstServer/databases/create-runtime-db2.sql -t
db2 -vf mfp_install_dir/PushService/databases/create-push-db2.sql -t
```

Si las tablas las crea mfpuser, este usuario tendrá los privilegios en las tablas automáticamente y puede utilizarlos en tiempo de ejecución. Si desea restringir los privilegios del usuario de tiempo de ejecución tal como se describe en [Usuarios de base de datos y privilegios](#database-users-and-privileges) o un control más preciso de privilegios, consulte la documentación de DB2.

### Creación de tablas de base de datos Oracle manualmente
{: #creating-the-oracle-database-tables-manually }
Utilice los scripts de SQL que se proporcionan en la instalación de {{ site.data.keys.mf_server }} para crear las tablas de base de datos Oracle.

Tal como se describe en la sección Visión general, los cuatro componentes de {{ site.data.keys.mf_server }} necesitan tablas. Pueden crearse en el mismo esquema o en diferentes esquemas. Sin embargo, se aplican algunas restricciones en función del modo en que se desplieguen las aplicaciones de {{ site.data.keys.mf_server }} en el servidor de aplicaciones de Java. Los detalles se describen en [Usuarios de base de datos y privilegios](#database-users-and-privileges).

Las tablas deben crearse en el esquema predeterminado del usuario de tiempo de ejecución. Los scripts para crear las tablas son los siguientes:

* Para el servicio de administración, en **mfp\_install\_dir/MobileFirstServer/databases/create-mfp-admin-oracle.sql**.
* Para el servicio de Live Update, en **mfp\_install\_dir/MobileFirstServer/databases/create-configservice-oracle.sql**.
* Para el componente de tiempo de ejecución, en **mfp\_install\_dir/MobileFirstServer/databases/create-runtime-oracle.sql**.
* Para el servicio de envío por push, en **mfp\_install\_dir/PushService/databases/create-push-oracle.sql**.

El procedimiento siguiente crea las tablas de todas las aplicaciones para el mismo usuario (**MFPUSER**). Se da por supuesto que ya se ha creado una base de datos y un usuario. Para obtener más información, consulte [Base de datos Oracle y requisitos de usuario](#oracle-database-and-user-requirements).

Ejecute los mandatos siguientes en Oracle SQLPlus:

```sql
CONNECT MFPUSER/MFPUSER_password@ORCL
@mfp_install_dir/MobileFirstServer/databases/create-mfp-admin-oracle.sql
@mfp_install_dir/MobileFirstServer/databases/create-configservice-oracle.sql
@mfp_install_dir/MobileFirstServer/databases/create-runtime-oracle.sql
@mfp_install_dir/PushService/databases/create-push-oracle.sql
DISCONNECT;
```

Si las tablas las crea MFPUSER, este usuario tendrá los privilegios en las tablas automáticamente y puede utilizarlos en tiempo de ejecución. Las tablas se crean en el esquema predeterminado del usuario. Si desea restringir los privilegios del usuario de tiempo de ejecución tal como se describe en [Usuarios de base de datos y privilegios](#database-users-and-privileges) o tener un control más preciso de privilegios, consulte la documentación de Oracle.

### Creación de las tablas de base de datos MySQL manualmente
{: #creating-the-mysql-database-tables-manually }
Utilice los scripts de SQL que se proporcionan en la instalación de {{ site.data.keys.mf_server }} para crear las tablas de base de datos MySQL.

Tal como se describe en la sección Visión general, los cuatro componentes de {{ site.data.keys.mf_server }} necesitan tablas. Pueden crearse en el mismo esquema o en diferentes esquemas. Sin embargo, se aplican algunas restricciones en función del modo en que se desplieguen las aplicaciones de {{ site.data.keys.mf_server }} en el servidor de aplicaciones de Java. Son similares al tema sobre los posibles usuarios para MySQL tal como se describe en [Usuarios de base de datos y privilegios](#database-users-and-privileges).

#### Instalación con la Herramienta de configuración del servidor
{: #installation-with-the-server-configuration-tool-2 }
Se utiliza la misma base de datos para todos los componentes (servicio de administración de {{ site.data.keys.mf_server }}, servicio de Live Update de {{ site.data.keys.mf_server }}, servicio de envío por push de {{ site.data.keys.mf_server }} y tiempo de ejecución de {{ site.data.keys.product }})

#### Instalación con tareas Ant
{: #installation-with-ant-tasks-2 }
Los archivos Ant de ejemplo que se proporcionan en la distribución del producto utilizan la misma base de datos para todos los componentes. Sin embargo, es posible modificar los archivos Ant para tener una base de datos distinta:

* La misma base de datos para el servicio de administración y el servicio de Live Update, ya que no se pueden instalar por separado con tareas Ant.
* Una base de datos distinta para el tiempo de ejecución.
* Una base de datos distinta para el servicio de envío por push.

#### Instalación manual
{: #manual-installation-2 }
Es posible asignar un origen de datos distinto y, por lo tanto, una base de datos distinta, a cada uno de los componentes de {{ site.data.keys.mf_server }}.  
Los scripts para crear las tablas son los siguientes:

* Para el servicio de administración, en **mfp\_install\_dir/MobileFirstServer/databases/create-mfp-admin-mysql.sql**.
* Para el servicio de Live Update, en **mfp\_install\_dir/MobileFirstServer/databases/create-configservice-mysql.sql**.
* Para el componente de tiempo de ejecución, en **mfp\_install\_dir/MobileFirstServer/databases/create-runtime-mysql.sql**.
* Para el servicio de envío por push, en **mfp\_install\_dir/PushService/databases/create-push-mysql.sql**.

El ejemplo siguiente crea las tablas para todas las aplicaciones para el mismo usuario y base de datos. Se da por supuesto que se ha creado una base de datos y un usuario como en [Requisitos para las bases de datos para MySQL](#database-requirements).

El procedimiento siguiente crea las tablas para todas las aplicaciones para el mismo usuario (mfpuser) y base de datos (MFPDATA). Se da por supuesto que ya se ha creado una base de datos y un usuario.

1. Ejecute un cliente de línea de mandatos de MySQL con la opción: `-u mfpuser`.
2. Especifique los mandatos siguientes:

```sql
USE MFPDATA;
SOURCE mfp_install_dir/MobileFirstServer/databases/create-mfp-admin-mysql.sql;
SOURCE mfp_install_dir/MobileFirstServer/databases/create-configservice-mysql.sql;
SOURCE mfp_install_dir/MobileFirstServer/databases/create-runtime-mysql.sql;
SOURCE mfp_install_dir/PushService/databases/create-push-mysql.sql;
```

## Cree las tablas de base de datos con la Herramienta de configuración del servidor
{: #create-the-database-tables-with-the-server-configuration-tool }
Las tablas de base de datos para las aplicaciones de {{ site.data.keys.mf_server }} se pueden crear manualmente, con Tareas Ant, o con la Herramienta de configuración del servidor. Los temas proporcionan la explicación y los detalles sobre la configuración de base de datos al instalar {{ site.data.keys.mf_server }} con la Herramienta de configuración del servidor.

La Herramienta de configuración del servidor puede crear las tablas de base de datos como parte del proceso de instalación. En algunos casos, puede incluso crear una base de datos y un usuario para los componentes de {{ site.data.keys.mf_server }}. Para obtener una visión general del proceso de instalación con la Herramienta de configuración del servidor, consulte [Instalación de {{ site.data.keys.mf_server }} en modalidad gráfica](../../simple-install/tutorials/graphical-mode).

Después de completar las credenciales de configuración y pulsar **Desplegar** en el panel Herramienta de configuración del servidor, se ejecutarán las siguientes operaciones:

* Cree la base de datos y el usuario si es necesario.
* Verifique si existen las tablas de {{ site.data.keys.mf_server }} en la base de datos. Si no existen, créelas.
* Despliegue las aplicaciones de {{ site.data.keys.mf_server }} en el servidor de aplicaciones.

Si las tablas de base de datos se crean manualmente antes de ejecutar la Herramienta de configuración del servidor, la herramienta puede detectarlas y omitir la fase de configuración de las tablas.

En función de su elección de sistema de gestión de base de datos (DBMS) soportado, seleccione uno de los temas siguientes para obtener más detalles sobre cómo crea la herramienta las tablas de base de datos.

* [Creación de las tablas de base de datos DB2 con la Herramienta de configuración del servidor](#creating-the-db2-database-tables-with-the-server-configuration-tool)
* [Creación de las tablas de base de datos Oracle con la Herramienta de configuración del servidor](#creating-the-oracle-database-tables-with-the-server-configuration-tool)
* [Creación de las tablas de base de datos MySQL con la Herramienta de configuración del servidor](#creating-the-mysql-database-tables-with-the-server-configuration-tool)

### Creación de las tablas de base de datos DB2 con la Herramienta de configuración del servidor
{: #creating-the-db2-database-tables-with-the-server-configuration-tool }
Utilice la Herramienta de configuración del servidor que se proporciona con la instalación de {{ site.data.keys.mf_server }} para crear las tablas de base de datos DB2.

La Herramienta de configuración del servidor puede crear una base de datos en la instancia de DB2 predeterminada. En el panel **Selección de base de datos** de la Herramienta de configuración del servidor, seleccione la opción IBM DB2. En los siguientes tres paneles, especifique las credenciales de base de datos. Si el nombre de base de datos especificado en el panel **Valores adicionales de la base de datos** no existe en la instancia de DB2, puede especificar información adicional para permitir que la herramienta cree una base de datos para usted.

La Herramienta de configuración del servidor crea las tablas de base de datos con valores predeterminados con la siguiente sentencia SQL:
```sql
CREATE DATABASE MFPDATA COLLATE USING SYSTEM PAGESIZE 32768
```

No está pensada para utilizarse para producción como en una instalación predeterminada de DB2, se otorgan muchos privilegios a PUBLIC.

### Creación de las tablas de base de datos Oracle con la Herramienta de configuración del servidor
{: #creating-the-oracle-database-tables-with-the-server-configuration-tool }
Utilice la Herramienta de configuración del servidor que se proporciona con la instalación de {{ site.data.keys.mf_server }} para crear las tablas de base de datos Oracle.

En el panel Selección de base de datos de la Herramienta de configuración del servidor, seleccione la opción **Oracle Standard o Enterprise Editions, 11g o 12c**. En los siguientes tres paneles, especifique las credenciales de base de datos.

Cuando especifique el nombre de usuario de Oracle en el panel **Valores adicionales de la base de datos**, debe estar en mayúsculas. Si tiene un usuario de base de datos Oracle (FOO), pero especifica un nombre de usuario con minúsculas (foo), la Herramienta de configuración del servidor lo considerará como otro usuario. A diferencia de otras herramientas para la base de datos Oracle, la Herramienta de configuración del servidor protege el nombre de usuario con relación a la conversión automática a mayúsculas.

La Herramienta de configuración del servidor utiliza un nombre de servicio o Identificador de sistema (SID) Oracle para identificar una base de datos. Sin embargo, si desea realizar la conexión a Oracle RAC, debe especificar un URL de JDBC complejo. En este caso, en el panel **Valores de base de datos**, seleccione la opción **Conectar utilizando URL de JDBC de Oracle genéricos** y escriba un URL para el controlador ligero de Oracle.

Si necesita crear la base de datos y el usuario para Oracle, utilice la herramienta Oracle Database Creation Assistant (DBCA). Para obtener más información, consulte [Base de datos Oracle y requisitos de usuario](#oracle-database-and-user-requirements).

La Herramienta de configuración del servidor puede hacer lo mismo pero con una limitación. La herramienta puede crear un usuario para Oracle 11g u Oracle 12g. Sin embargo, sólo puede crear una base de datos para Oracle 11g, y no para Oracle 12c.

Si el nombre de base de datos o el nombre de usuario que se especifique en el panel **Valores adicionales de base de datos** no existe, consulte las siguientes dos secciones para ver los pasos adicionales para crear la base de datos o el usuario.

#### Creación de la base de datos
{: #creating-the-database }

1. Ejecute un servidor SSH en el sistema que ejecuta la base de datos Oracle.

    La Herramienta de configuración del servidor abre una sesión SSH en el host de Oracle para crear la base de datos. Excepto en Linux y en algunas versiones de los sistemas UNIX, se necesita el servidor SSH incluso si la base de datos Oracle se ejecuta en el mismo sistema que la Herramienta de configuración del servidor.

2. En el panel **Solicitud de creación de base de datos**, especifique el ID de inicio de sesión y la contraseña de un usuario de la base de datos Oracle que tenga los privilegios para crear una base de datos.
3. En el mismo panel, escriba también la contraseña para el usuario **SYS** y el usuario **SYSTEM** para la base de datos que se va a crear.

Se crea una base de datos con el nombre de SID que se especifica en el panel **Valores adicionales de base de datos**. No está pensada para utilizarse para producción.

#### Creación del usuario
{: #creating-the-user }

1. Ejecute un servidor SSH en el sistema que ejecuta la base de datos Oracle.

    La Herramienta de configuración del servidor abre una sesión SSH en el host de Oracle para crear la base de datos. Excepto en Linux y en algunas versiones de los sistemas UNIX, se necesita el servidor SSH incluso si la base de datos Oracle se ejecuta en el mismo sistema que la Herramienta de configuración del servidor.

2. En el panel **Valores adicionales de base de datos**, escriba el ID de inicio de sesión y la contraseña del usuario de base de datos que se va a crear.
3. En el panel **Solicitud de creación de base de datos**, especifique el ID de inicio de sesión y la contraseña de un usuario de base de datos Oracle que tenga los privilegios para crear un usuario de base de datos.
4. En el mismo panel, especifique también la contraseña para el usuario **SYSTEM** de la base de datos.

### Creación de las tablas de base de datos MySQL con la Herramienta de configuración del servidor
{: #creating-the-mysql-database-tables-with-the-server-configuration-tool }
Utilice la Herramienta de configuración del servidor que se proporciona con la instalación de {{ site.data.keys.mf_server }} para crear las tablas de base de datos MySQL.

La Herramienta de configuración del servidor puede crear una base de datos MySQL para usted. En el panel **Selección de base de datos** de la Herramienta de configuración del servidor, seleccione la opción **MySQL 5.5.x, 5.6.x o 5.7.x**. En los siguientes tres paneles, especifique las credenciales de base de datos. Si la base de datos o el usuario que ha especificado en el panel Valores adicionales de base de datos no existe, la herramienta puede crearla.

Si el servidor de MySQL no tiene los valores recomendados en [Base de datos MySQL y requisitos de usuario](#mysql-database-and-user-requirements), la Herramienta de configuración del servidor mostrará un aviso. Asegúrese de cumplir los requisitos antes de ejecutar la Herramienta de configuración del servidor.

El procedimiento siguiente proporciona algunos pasos adicionales que tiene que realizar al crear las tablas de base de datos con la herramienta.

1. En el panel **Valores adicionales de base de datos**, junto a los valores de conexión, debe especificar todos los hosts desde los que se permite que se conecte el usuario a la base de datos. Es decir, todos los hosts donde se ejecuta {{ site.data.keys.mf_server }}.
2. En el panel **Solicitud de creación de base de datos**, especifique el ID de inicio de sesión y la contraseña de un administrador de MySQL. De forma predeterminada, el administrador es root.

## Crear las tablas de base de datos con tareas Ant
{: #create-the-database-tables-with-ant-tasks }
Las tablas de base de datos para las aplicaciones de {{ site.data.keys.mf_server }} se pueden crear manualmente, con Tareas Ant, o con la Herramienta de configuración del servidor. Los temas proporcionan la explicación y los detalles sobre cómo crearlas con tareas Ant.

Puede encontrar información relevante en esta sección sobre la configuración de la base de datos si {{ site.data.keys.mf_server }} se instala con tareas Ant.

Puede utilizar tareas Ant para configurar las tablas de base de datos {{ site.data.keys.mf_server }}. En algunos casos, también puede crear una base de datos y un usuario con estas tareas. Para obtener una visión general del proceso de instalación con Tareas Ant, consulte [Instalación de {{ site.data.keys.mf_server }} en modalidad de línea de mandatos](../../simple-install/tutorials/command-line).

Se proporciona un conjunto de archivos Ant de ejemplo con la instalación para ayudarle a comenzar con las tareas Ant. Puede encontrar los archivos en **mfp\_install\_dir/MobileFirstServer/configurations-samples**. Los archivos se denominan con los siguientes patrones:

#### configure-appserver-dbms.xml
{: #configure-appserver-dbmsxml }
Los archivos Ant pueden realizar estas tareas:

* Crear las tablas de una base de datos si existe la base de datos y el usuario de base de datos. Los requisitos para la base de datos se listan en [Requisitos de la base de datos](#database-requirements).
* Desplegar los archivos WAR de los componentes de {{ site.data.keys.mf_server }} en el servidor de aplicaciones. Estos archivos Ant utilizan el mismo usuario de base de datos para crear las tablas, y para instalar el usuario de base de datos de tiempo de ejecución para las aplicaciones en el tiempo de ejecución. Los archivos también utilizan el mismo usuario de base de datos para todas las aplicaciones de {{ site.data.keys.mf_server }}.

#### create-database-dbms.xml
{: #create-database-dbmsxml }
Los archivos Ant pueden crear una base de datos si es necesario en el sistema de gestión de bases de datos (DBMS) soportado y, a continuación, crear las tablas de la base de datos. Sin embargo, como la base de datos se crea con valores predeterminados, no está pensada para utilizarse para producción.

En los archivos Ant, puede encontrar los destinos predefinidos que utilicen la tarea Ant **configureDatabase** para configurar la base de datos. Para obtener más información, consulte la referencia de tareas [Ant configuredatabase](../../installation-reference/#ant-configuredatabase-task-reference).

### Utilización de los archivos Ant de ejemplo
{: #using-the-sample-ant-files }
Los archivos Ant de ejemplo tienen destinos predefinidos. Siga este procedimiento para utilizar los archivos.

1. Copie el archivo Ant según su servidor de aplicaciones y su configuración de base de datos en un directorio de trabajo.
2. Edite el archivo y especifique los valores para la configuración en la sección `<! -- Start of Property Parameters -->` para el archivo Ant.
3. Ejecute el archivo Ant con el destino de bases de datos: `mfp_install_dir/shortcuts/ant -f your_ant_file databases`.

Este mandato crea las tablas de la base de datos y el esquema especificados para todas las aplicaciones de {{ site.data.keys.mf_server }} (servicio de administración de {{ site.data.keys.mf_server }}, servicio de Live Update de {{ site.data.keys.mf_server }}, servicio de envío por push de {{ site.data.keys.mf_server }} y tiempo de ejecución de {{ site.data.keys.mf_server }}). Se crea y se almacena en el disco un registro para las operaciones.

* En Windows, se encuentra en el directorio **{{ site.data.keys.prod_server_data_dir_win }}\\Configuration Logs\\**.
* En UNIX, se encuentra en el directorio **{{ site.data.keys.prod_server_data_dir_unix }}/configuration-logs/**.

### Usuarios distintos para la creación de tablas de base de datos y para el tiempo de ejecución
{: #different-users-for-the-database-tables-creation-and-for-run-time }
Los archivos Ant de ejemplo en **mfp\_install\_dir/MobileFirstServer/configurations-samples** utilizan el mismo usuario de base de datos para:

* Todas las aplicaciones de {{ site.data.keys.mf_server }} (el servicio de administración, el servicio de Live Update, el servicio de envío por push y el tiempo de ejecución)
* El usuario que se utiliza para crear la base de datos y el usuario en tiempo de ejecución para el origen de datos en el servidor de aplicaciones.

Si desea separar los usuarios como se describe en [Usuarios de base de datos y privilegios](#database-users-and-privileges), debe crear su propio archivo Ant, o modificar los archivos Ant de ejemplo para que cada destino de base de datos tenga un usuario distinto. Para obtener más información, consulte la [Referencia de instalación](../../installation-reference).

Para DB2 y MySQL, es posible tener distintos usuarios para la creación de bases de datos y para el tiempo de ejecución. Los privilegios para cada tipo de usuario se listan en [Usuarios de base de datos y privilegios](#database-users-and-privileges). Para Oracle, no puede tener un usuario distinto para la creación de bases de datos y para el tiempo de ejecución. Las tareas Ant consideran la posibilidad de que las tablas se encuentren en el esquema predeterminado de un usuario. Si desea reducir los privilegios para el usuario de tiempo de ejecución, debe crear las tablas manualmente en el esquema predeterminado del usuario que se utilizará en tiempo de ejecución. Para obtener más información, consulte [Creación de tablas de base de datos Oracle manualmente](#creating-the-oracle-database-tables-manually).

En función de su elección de sistema de gestión de base de datos (DBMS) soportado, seleccione uno de los temas siguientes para crear la base de datos con tareas Ant.

### Creación de las tablas de base de datos DB2 con tareas Ant
{: #creating-the-db2-database-tables-with-ant-tasks }
Utilice las tareas Ant que se proporcionan con la instalación de {{ site.data.keys.mf_server }} para crear la base de datos DB2.

Para crear las tablas de base de datos en una base de datos que ya existe, consulte [Crear las tablas de base de datos con tareas Ant](#create-the-database-tables-with-ant-tasks).

Para crear una base de datos y las tablas de la base de datos, puede hacerlo con las tareas Ant. Las tareas Ant crean una base de datos en la instancia predeterminada de DB2 si utiliza un archivo Ant que contiene el elemento **dba**. Este elemento se puede encontrar en los archivos Ant de ejemplo denominados **create-database-<dbms>.xml**.

Antes de ejecutar las tareas Ant, asegúrese de que tiene un servidor SSH en el sistema que ejecuta la base de datos DB2. La tarea Ant **configureDatabase** abre una sesión SSH en el host de DB2 para crear la base de datos. El servidor SSH es necesario incluso si la base de datos DB2 se ejecuta en el mismo sistema en el que se ejecutan las tareas Ant (excepto en Linux y en algunas versiones de sistemas UNIX).

Siga las directrices generales tal como se describe en [Crear las tablas de base de datos con tareas Ant](#create-the-database-tables-with-ant-tasks) para editar la copia del archivo **create-database-db2.xml**.

También debe proporcionar el ID de inicio de sesión y la contraseña de un usuario de DB2 con privilegios de administración (permisos **SYSADM** o **SYSCTRL**) en el elemento **dba**. En el archivo Ant de ejemplo para DB2 (**create-database-db2.xml**), las propiedades a establecer son: **database.db2.admin.username** y **database.db2.admin.password**.

Cuando se llame al destino de Ant **bases de datos**, la tarea Ant **configureDatabase** creará una base de datos con valores predeterminados con la siguiente sentencia SQL:

```sql
CREATE DATABASE MFPDATA COLLATE USING SYSTEM PAGESIZE 32768
```

No está pensada para utilizarse para producción como en una instalación predeterminada de DB2, se otorgan muchos privilegios a PUBLIC.

### Creación de tablas de base de datos Oracle con tareas Ant
{: #creating-the-oracle-database-tables-with-ant-tasks }
Utilice las tareas Ant que se proporcionan con la instalación de {{ site.data.keys.mf_server }} para crear las tablas de base de datos Oracle.

Cuando especifique el nombre de usuario de Oracle en el archivo Ant, debe estar en mayúsculas. Si tiene un usuario de base de datos Oracle (FOO), pero especifica un nombre de usuario con minúsculas (foo), la tarea Ant **configureDatabase** lo considerará como otro usuario. A diferencia de otras herramientas para la base de datos Oracle, la tarea Ant **configureDatabase** protegerá el nombre de usuario contra la conversión automática a mayúscula.

La tarea Ant **configureDatabase** utiliza un nombre de servicio o Identificador de sistema (SID) Oracle para identificar una base de datos. Sin embargo, si desea realizar la conexión a Oracle RAC, debe especificar un URL de JDBC complejo. En este caso, el elemento **oracle** que se encuentra de la tarea Ant **configureDatabase** debe utilizar los atributos (**url**, **usuario** y **contraseña**) en lugar de estos atributos (**base de datos**, **servidor**, **puerto**, **usuario** y **contraseña**). Para obtener más información, consulte la tabla de [Referencia de tarea Ant **configuredatabase**](../../installation-reference/#ant-configuredatabase-task-reference). Los archivos Ant de ejemplo de **mfp\_install\_dir/MobileFirstServer/configurations-samples** utilizan los atributos **base de datos**, **servidor**, **puerto**, **usuario** y **contraseña** del elemento **oracle**. Deben modificarse si necesita conectarse a Oracle con un URL de JDBC.

Para crear las tablas de base de datos en una base de datos que ya existe, consulte [Crear las tablas de base de datos con tareas Ant](#create-the-database-tables-with-ant-tasks).

Para crear una base de datos, un usuario o las tablas de base de datos, utilice la herramienta Oracle Database Creation Assistant (DBCA). Para obtener más información, consulte [Base de datos Oracle y requisitos de usuario](#oracle-database-and-user-requirements).

La tarea Ant **configureDatabase** puede hacer lo mismo pero con una limitación. La tarea puede crear un usuario de base de datos para Oracle 11g u Oracle 12g. Sin embargo, sólo puede crear una base de datos para Oracle 11g, y no para Oracle 12c. Consulte las siguientes dos secciones para ver los pasos adicionales que necesita para crear la base de datos o el usuario.

#### Creación de la base de datos
{: #creating-the-database-1 }
Siga las directrices generales tal como se describe en [Crear las tablas de base de datos con tareas Ant](#create-the-database-tables-with-ant-tasks) para editar la copia del archivo **create-database-oracle.xml**.

1. Ejecute un servidor SSH en el sistema que ejecuta la base de datos Oracle.

    La tarea Ant **configureDatabase** abre una sesión SSH en el host de Oracle para crear la base de datos. Excepto en Linux y en algunas versiones de sistemas UNIX, el servidor SSH es necesario incluso si la base de datos Oracle se ejecuta en el mismo sistema en el que se ejecutan las tareas Ant.

2. En el elemento **dba** definido en el archivo **create-database-oracle.xml**, especifique el ID de inicio de sesión y la contraseña de un usuario de base de datos Oracle que puede conectarse a Oracle Server a través de SSH y que tiene los privilegios para crear una base de datos. Puede asignar los valores en las siguientes propiedades:
    * **database.oracle.admin.username**
    * **database.oracle.admin.password**
3. En el elemento **oracle**, escriba el nombre de la base de datos que desee crear. El atributo es **base de datos**. Puede asignar el valor en la propiedad **database.oracle.mfp.dbname**.
4. En el mismo elemento **oracle**, escriba también la contraseña para el usuario **SYS** y el usuario **SYSTEM** para la base de datos que se va a crear. Los atributos son **sysPassword** y **systemPassword**. Puede asignar los valores en las propiedades correspondientes:
    * **database.oracle.sysPassword**
    * **database.oracle.systemPassword**
5. Una vez que se hayan especificado todas las credenciales de base de datos en el archivo Ant, guárdelo y ejecute el destino Ant **bases de datos**.

Una base de datos se crea con el nombre de SID que se especifica en la base de datos del elemento **oracle**. No está pensada para utilizarse para producción.

#### Creación del usuario
{: #creating-the-user-1 }
Siga las directrices generales tal como se describe en [Crear las tablas de base de datos con tareas Ant](#create-the-database-tables-with-ant-tasks) para editar la copia del archivo **create-database-oracle.xml**.

1. Ejecute un servidor SSH en el sistema que ejecuta la base de datos Oracle.

    La tarea Ant **configureDatabase** abre una sesión SSH en el host de Oracle para crear la base de datos. Excepto en Linux y en algunas versiones de sistemas UNIX, el servidor SSH es necesario incluso si la base de datos Oracle se ejecuta en el mismo sistema en el que se ejecutan las tareas Ant.

2. En el elemento oracle definido en el archivo **create-database-oracle.xml**, especifique el ID de inicio de sesión y la contraseña de un usuario de base de datos Oracle que desee crear. Los atributos son **usuario** y **contraseña**. Puede asignar los valores en las propiedades correspondientes:
    * database.oracle.mfp.username
    * database.oracle.mfp.password
3. En el mismo elemento **oracle**, especifique también la contraseña para el usuario **SYSTEM** para la base de datos. El atributo es **systemPassword**. Puede asignar el valor de la **propiedad database.oracle.systemPassword**.
4. En el elemento **dba**, especifique el ID de inicio de sesión y la contraseña de un usuario de base de datos Oracle que tiene los privilegios de crear un usuario. Puede asignar los valores en las siguientes propiedades:
    * **database.oracle.admin.username**
    * **database.oracle.admin.password**
5. Una vez que se hayan especificado todas las credenciales de base de datos en el archivo Ant, guárdelo y ejecute el destino Ant **bases de datos**.

Un usuario de base de datos se crea con el nombre y la contraseña especificados en el elemento **oracle**. Este usuario tiene los privilegios de crear las tablas de {{ site.data.keys.mf_server }}, actualizarlas y utilizarlas en tiempo de ejecución.

### Creación de las tablas de base de datos MySQL con tareas Ant
{: #creating-the-mysql-database-tables-with-ant-tasks }
Utilice las Tareas Ant que se proporcionan con la instalación de {{ site.data.keys.mf_server }} para crear las tablas de base de datos MySQL.

Para crear las tablas de base de datos en una base de datos que ya existe, consulte [Crear las tablas de base de datos con tareas Ant](#create-the-database-tables-with-ant-tasks).

Si el servidor MySQL no tiene los valores recomendados en [Base de datos MySQL y requisitos de usuario](#mysql-database-and-user-requirements), la tarea Ant **configureDatabase** mostrará un aviso. Asegúrese de cumplir los requisitos antes de ejecutar la tarea Ant.

Para crear una base de datos y las tablas de base de datos, siga las directrices generales descritas en [Crear las tablas de base de datos con tareas Ant](#create-the-database-tables-with-ant-tasks) para editar la copia del archivo **create-database-mysql.xml**.

El procedimiento siguiente proporciona algunos pasos adicionales que tiene que realizar al crear las tablas de base de datos con la tarea Ant **configureDatabase**.

1. En el elemento **dba** definido en el archivo **create-database-mysql.xml**, especifique el ID de inicio de sesión y la contraseña de un administrador de MySQL. De forma predeterminada, el administrador es **root**. Puede asignar los valores en las siguientes propiedades:
    * **database.mysql.admin.username**
    * **database.mysql.admin.password**
2. En el elemento **mysql**, añada un elemento **cliente** para cada host desde el que se permite al usuario conectarse a la base de datos. Es decir, todos los hosts donde se ejecuta {{ site.data.keys.mf_server }}.
Una vez que se hayan especificado todas las credenciales de base de datos en el archivo Ant, guárdelo y ejecute el destino Ant **bases de datos**.
