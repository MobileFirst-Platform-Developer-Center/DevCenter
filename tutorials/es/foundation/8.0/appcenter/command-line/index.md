---
layout: tutorial
title: Herramienta de línea de mandatos para cargar o suprimir una aplicación
breadcrumb_title: Uploading or deleting an app
relevantTo: [ios,android,windows,javascript]
weight: 5
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
Para desplegar aplicaciones en el Application Center mediante un proceso de compilación, utilice la herramienta de línea de mandatos.

Puede cargar una aplicación en el Application Center mediante la interfaz web de la consola del Application Center. También puede cargar una aplicación nueva mediante una herramienta de línea de mandatos.

Esto es especialmente útil cuando desee incorporar el despliegue de una aplicación en el Application Center en un proceso de compilación. Esta herramienta se encuentra en: **installDir/ApplicationCenter/tools/applicationcenterdeploytool.jar**.

La herramienta se puede utilizar para archivos de aplicaciones con extensión APK o IPA. Se puede utilizar de forma autónoma o como una tarea Ant.

El directorio tools contiene todos los archivos necesarios para dar soporte al uso de la herramienta.

* **applicationcenterdeploytool.jar**: la herramienta de carga.
* **json4j.jar**: la biblioteca para el formato JSON requerida por la herramienta de carga.
* **build.xml**: un script Ant de ejemplo que puede utilizar para cargar un archivo o una secuencia de archivos únicos en el Application Center.
* **acdeploytool.sh** y **acdeploytool.bat**: Scripts de ejemplo para invocar java con **applicationcenterdeploytool.jar**.

#### Ir a
{: #jump-to }
* [Uso de la herramienta autónoma para cargar una aplicación](#using-the-stand-alone-tool-to-upload-an-application)
* [Uso de la herramienta autónoma para suprimir una aplicación](#using-the-stand-alone-tool-to-delete-an-application)
* [Uso de la herramienta autónoma para borrar la memoria caché de LDAP](#using-the-stand-alone-tool-to-clear-the-ldap-cache)
* [Tarea Ant para cargar o suprimir una aplicación](#ant-task-for-uploading-or-deleting-an-application)

### Uso de la herramienta autónoma para cargar una aplicación
{: #using-the-stand-alone-tool-to-upload-an-application }
Para cargar una aplicación, invoque la herramienta autónoma desde la línea de mandatos.  
Utilice la herramienta autónoma siguiendo estos pasos.

1. Añada **applicationcenterdeploytool.jar** y **json4j.jar** a la variable de entorno java classpath.
2. Invoque la herramienta de carga desde la línea de mandatos:

   ```bash
   java com.ibm.appcenter.Upload [options] [files]
   ```

Puede pasar cualquiera de las opciones disponibles de la línea de mandatos.

|Opción |Contenido indicado por |Descripción |
|--------|----------------------|-------------|
| -s | serverpath | The path to the Application Center server. |
| -c | context | The context of the Application Center web application. |
| -u | user | The user credentials to access the Application Center. |
| -p | password | The password of the user. |
| -d | description | The description of the application to be uploaded. |
| -l | label | The fallback label. Normally the label is taken from the application descriptor stored in the file to be uploaded. If the application descriptor does not contain a label, the fallback label is used. |
| -isActive | true or false | The application is stored in the Application Center as an active or inactive application. |
| -isInstaller | true or false | The application is stored in the Application Center with the “installer” flag set appropriately. |
| -isReadyForProduction | true or false | The application is stored in the Application Center with the “ready-for-production” flag set appropriately. |
| -isRecommended | true or false | The application is stored in the Application Center with the “recommended” flag set appropriately. |
| -e	  |  | Shows the full exception stack trace on failure. |
| -f	  |  | Force uploading of applications, even if they exist already. |
| -y	  |  | Disable SSL security checking, which allows publishing on secured hosts without verification of the SSL certificate. |  Use of this flag is a security risk, but may be suitable for testing localhost with temporary self-signed SSL certificates. |

El parámetro files puede especificar archivos de tipo archivos de paquete de aplicaciones de Android (.apk) o archivos de aplicaciones iOS (.ipa).  
En este ejemplo, la demo del usuario tiene la contraseña demopassword. Utilice esta línea de mandatos.

```bash
java com.ibm.appcenter.Upload -s http://localhost:9080 -c applicationcenter -u demo -p demopassword -f app1.ipa app2.ipa
```

### Uso de la herramienta autónoma para suprimir una aplicación
{: #using-the-stand-alone-tool-to-delete-an-application }
Para suprimir una aplicación desde el Application Center, invoque la herramienta autónoma desde la línea de mandatos.  
Utilice la herramienta autónoma siguiendo estos pasos.

1. Añada **applicationcenterdeploytool.jar** y **json4j.jar** a la variable de entorno java classpath.
2. Invoque la herramienta de carga desde la línea de mandatos:

   ```bash
   java com.ibm.appcenter.Upload -delete [options] [files or applications]
   ```

Puede pasar cualquiera de las opciones disponibles de la línea de mandatos.

|Opción |Contenido indicado por	|Descripción |
|--------|----------------------|-------------|
| -s |serverpath | The path to the Application Center server. |
| -c | context | The context of the Application Center web application. |
| -u | user | The user credentials to access the Application Center. |
| -p | password | The password of the user. |
| -y | | Disable SSL security checking, which allows publishing on secured hosts without verification of the SSL certificate. Use of this flag is a security risk, but may be suitable for testing localhost with temporary self-signed SSL certificates. |

Puede especificar archivos o el paquete de aplicaciones, el sistema operativo y la versión. Si se especifican los archivos, el paquete, el sistema operativo y la versión estarán determinados desde el archivo y la aplicación correspondiente se suprimirá del Application Center. Si se especifican aplicaciones, deben tener uno de los formatos siguientes:

* `package@os@version`: Esta versión exacta se suprime del Application Center. El componente de la versión debe especificar la “versión interna”, no la “versión comercial” de la aplicación.
* `package@os`: Se suprimirán todas las versiones de esta aplicación del Application Center.
* `package`: Se suprimirán todas las versiones de los sistemas operativos de esta aplicación del Application Center.

#### Ejemplo
{: #example-delete }
En este ejemplo, la demo del usuario tiene la contraseña demopassword. Utilice esta línea de mandatos para suprimir la aplicación iOS demo.HelloWorld por la versión interna 3.0.

```bash
java com.ibm.appcenter.Upload -delete -s http://localhost:9080 -c applicationcenter -u demo -p demopassword demo.HelloWorld@iOS@3.0
```

### Uso de la herramienta autónoma para borrar la memoria caché de LDAP
{: #using-the-stand-alone-tool-to-clear-the-ldap-cache }
Utilice la herramienta autónoma para borrar la memoria caché de LDAP y para realizar cambios en los usuarios y los grupos de LDAP para que sean visibles inmediatamente en el Application Center.

Cuando se configure el Application Center con LDAP, los cambios a los usuarios y grupos del servidor LDAP pasarán a ser visibles en el Application Center tras un retraso. El Application Center mantiene una memoria caché de los datos y de los cambios de LDAP que sólo serán visibles una vez que caduque la memoria caché. De forma predeterminada, el retraso es de 24 horas. Si no desea esperar a que caduque este retraso tras realizar los cambios en los usuarios o grupos, puede invocar la herramienta autónoma desde la línea de mandatos para borrar la memoria caché de los datos de LDAP. Con el uso de la herramienta autónoma para borrar la memoria caché, los cambios serán visibles inmediatamente.

Utilice la herramienta autónoma siguiendo estos pasos.

1. Añada applicationcenterdeploytool.jar y json4j.jar a la variable de entorno java classpath.
2. Invoque la herramienta de carga desde la línea de mandatos:

   ```bash
   java com.ibm.appcenter.Upload -clearLdapCache [options]
   ```

Puede pasar cualquiera de las opciones disponibles de la línea de mandatos.

|Opción |Contenido indicado por	|Descripción |
|--------|----------------------|-------------|
| -s | serverpath | The path to the Application Center server.|
| -c | context | The context of the Application Center web application.|
| -u | user | The user credentials to access the Application Center.|
| -p | password | The password of the user.|
| -y | | Disable SSL security checking, which allows publishing on secured hosts without verification of the SSL certificate. Use of this flag is a security risk, but may be suitable for testing localhost with temporary self-signed SSL certificates.|

#### Ejemplo
{: #example-cache }
En este ejemplo, la demo del usuario tiene la contraseña demopassword.

```bash
java com.ibm.appcenter.Upload -clearLdapCache -s http://localhost:9080 -c applicationcenter -u demo -p demopassword
```

### Tarea Ant para cargar o suprimir una aplicación
{: #ant-task-for-uploading-or-deleting-an-application}
Puede utilizar las herramientas de carga y de supresión como una tarea Ant y utilizar la tarea Ant en su propio script Ant.  
Se necesita Apache Ant para ejecutar estas tareas. La versión mínima soportada de Apache Ant está listada en [Requisitos del sistema](../../product-overview/requirements).

Por comodidad, Apache Ant 1.8.4 está incluido en {{ site.data.keys.mf_server }}. En el directorio product_install_dir/shortcuts/, se proporcionan los scripts siguientes:

* ant for UNIX / Linux
* ant.bat for Windows

Estos scripts están listos para ejecutarse, lo que significa que no necesitan variables de entorno específicas. Si se establece la variable de entorno JAVA_HOME, los scripts la aceptan.

Cuando utilice la herramienta de carga como una tarea Ant, el valor classname de la tarea Ant de carga será **com.ibm.appcenter.ant.UploadApps**. El valor classname de la tarea Ant de supresión será **com.ibm.appcenter.ant.DeleteApps**.

|Parámetros de la tarea Ant |Descripción |
|------------------------|-------------|
|serverPath |Para conectar al Application Center. El valor predeterminado es http://localhost:9080. |
|context |El contexto del Application Center. El valor predeterminado es /applicationcenter. |
|loginUser |El nombre de usuario que tiene los permisos pertinentes para poder subir una aplicación. |
|loginPass |La contraseña del usuario que tiene los permisos pertinentes para poder subir una aplicación. |
|forceOverwrite |Si este parámetro se establece en true, la tarea Ant intentará sobrescribir aplicaciones en el Application Center cuando cargue una aplicación que ya se encuentre. Este parámetro sólo está disponible en la tarea Ant de carga.
|file |El archivo .apk o .ipa que se cargará en el Application Center o que se suprimirá del Application Center. Este parámetro no tiene ningún valor predeterminado. |
|fileset |Para cargar o suprimir varios archivos. |
|application |El nombre de paquete de la aplicación. Este parámetro sólo está disponible en la tarea Ant de supresión. |
|os |El sistema operativo de la aplicación. (Por ejemplo, Android o iOS). Este parámetro sólo está disponible en la tarea Ant de supresión. |
|version |La versión interna de la aplicación. Este parámetro sólo está disponible en la tarea Ant de supresión. No utilice la versión comercial aquí, porque no es apropiada para identificar la versión exactamente. |

#### Ejemplo
{: #example-ant }
Puede encontrar un ejemplo ampliado en el directorio **ApplicationCenter/tools/build.xml**.  
El ejemplo siguiente muestra cómo utilizar la tarea Ant en su propio script Ant.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project name="PureMeapAntDeployTask" basedir="." default="upload.AllApps">

  <property name="install.dir" value="../../" />
  <property name="workspace.root" value="../../" />

<!-- Server Properties -->
  <property name="server.path" value="http://localhost:9080/" />
  <property name="context.path" value="applicationcenter" />
  <property name="upload.file" value="" />
  <property name="force" value="true" />

  <!--  Authentication Properties -->
  <property name="login.user" value="appcenteradmin" />
  <property name="login.pass" value="admin" />
  <path id="classpath.run">
    <fileset dir="${install.dir}/ApplicationCenter/tools/">
      <include name="applicationcenterdeploytool.jar" />
      <include name="json4j.jar"/>
    </fileset>
  </path>
  <target name="upload.init">
    <taskdef name="uploadapps" classname="com.ibm.appcenter.ant.UploadApps">
      <classpath refid="classpath.run" />
    </taskdef>
  </target>
  <target name="upload.App" description="Uploads a single application" depends="upload.init">
    <uploadapps serverPath="${server.path}"
      context="${context.path}"
      loginUser="${login.user}"
      loginPass="${login.pass}"
      forceOverwrite="${force}"
      file="${upload.file}" />
    </target>
    <target name="upload.AllApps" description="Uploads all found APK and IPA files" depends="upload.init">
    <uploadapps serverPath="${server.path}"
      loginUser="${login.user}"
      loginPass="${login.pass}"
      forceOverwrite="${force}"
       context="${context.path}" >
      <fileset dir="${workspace.root}">
        <include name="**/*.ipa" />
      </fileset>
    </uploadapps>
  </target>
</project>
```

Este script Ant de ejemplo se encuentra en el directorio **tools**. Puede utilizarlo para cargar una aplicación única en el Application Center.

```bash
ant upload.App -Dupload.file=sample.ipa
```

También puede utilizarlo para cargar todas las aplicaciones que se encuentran en una jerarquía de directorios.

```bash
ant upload.AllApps -Dworkspace.root=myDirectory
```

#### Propiedades del script Ant de ejemplo
{: #properties-of-the-sample-ant-script }
|Propiedad |Comentario |
|----------|---------|
|install.dir |Tiene como valor predeterminado ../../ |
|server.path |El valor predeterminado es http://localhost:9080. |
|context.path |El valor predeterminado es applicationcenter. |
|upload.file |Esta propiedad no tiene ningún valor predeterminado. Debe incluir la vía de acceso de archivos exacta. |
|workspace.root |Tiene como valor predeterminado ../../ |
|login.user |El valor predeterminado es appcenteradmin. |
|login.pass |El valor predeterminado es admin. |
|force	El valor predeterminado es true. |

Para especificar estos parámetros por línea de mandatos al invocar Ant, añada -D antes del nombre de propiedad. Por ejemplo:

```xml
-Dserver.path=http://localhost:8888/
```
