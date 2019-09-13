---
layout: tutorial
title: Ejecución de IBM Installation Manager para actualizar
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Ejecución de Installation Manager en modalidad gráfica
{: #graphical-mode}

* Ejecute Installation Manager desde la cuenta de usuario que se utiliza en la instalación inicial.
  Para aplicar una actualización, Installation Manager debe ejecutarse con la misma lista de archivos de registro que se utilizan en la instalación inicial. La lista de software instalado y las opciones que se utilizan durante el momento de la instalación se almacenan en dichos archivos de registro. Si ejecuta Installation Manager en modalidad de administrador, los archivos de registro se instalarán en el nivel del sistema. En la carpeta `/var` en UNIX o Linux. En la carpeta `c:\ProgramData` en Windows. La ubicación es independiente del usuario que ejecuta Installation Manager (aunque la raíz es necesaria en UNIX y Linux). Sin embargo, si ejecuta Installation Manager en el modo de usuario único, los archivos de registro se almacenarán de forma predeterminada en el directorio de inicio del usuario.

* Seleccione **Archivo > Preferencias**.
  Si tiene la intención de actualizar un IBM MobileFirst Platform Foundation V8.0.0 existente (aplicar un fixpack o arreglo temporal), el repositorio del producto no es necesario.

* Pulse **Aceptar** para cerrar la pantalla **Preferencias**.

* Pulse **Actualizar** y seleccione el paquete que necesita actualizar. Installation Manager muestra una lista de paquetes. De forma predeterminada, el paquete a actualizar se denomina IBM MobileFirst Platform Server.

* Acepte los términos de licencia, y pulse **Siguiente**.

* En el panel **Gracias**, pulse **Siguiente**. Aparecerá un resumen.

* Pulse **Actualizar** para iniciar el procedimiento de actualización.

## Ejecución de Installation Manager en modalidad de línea de mandatos
{: #cli-mode}

1. Descargue los archivos de instalación silenciosa desde [aquí](http://public.dhe.ibm.com/software/products/en/MobileFirstPlatform/docs/v800/Silent_Install_Sample_Files.zip).

2. Descomprima el archivo y seleccione el archivo `8.0/upgrade-initially-mfpserver.xml`.
  - Si ha instalado inicialmente el producto en V6.0.0, V6.1.0 o V6.2.0, seleccione `8.0/upgrade-initially-worklightv6.xmlfile` en su lugar.
  - Si ha instalado inicialmente el producto en V5.x, seleccione este archivo `8.0/upgrade-initially-worklightv5.xml` en su lugar.
  El archivo contiene la identidad de perfiles del producto. El valor predeterminado de esta identidad cambia a través de los releases del producto. En V5.x, es Worklight. En V6.0.0, V6.1.0 y V6.2.0, es IBM Worklight. En V6.3.0, V7.0.0, V7.1.0 y V8.0.0, es IBM MobileFirst Platform Server.

3. Realice una copia del archivo que ha seleccionado.

4. Abra el archivo XML copiado con un editor de texto o un editor XML. Modifique los elementos siguientes:

   a. El elemento de repositorio que define la lista de repositorio. Puesto que tiene la intención de actualizar un IBM MobileFirst Platform Foundation V8.0.0 existente (aplicar un fixpack o arreglo temporal), el repositorio del producto no es necesario.

   b. **Opcional:** Actualice las contraseñas para la base de datos y el servidor de aplicaciones.
      Si el Application Center está instalado en la instalación inicial con Installation Manager, y las contraseñas para la base de datos o el servidor de aplicaciones están modificadas, puede modificar el valor en el archivo XML. Estas contraseñas se utilizan para validar que la base de datos tenga la versión de esquema correcta, y para actualizarla si se encuentra en una versión anterior a la V8.0.0. También se utilizan para ejecutar **wsadmin** para una instalación de Application Center en el perfil completo de WebSphere Application Server. Elimine el comentario de las líneas adecuadas en el archivo XML:
      ```
      <!-- Optional: If the password of the WAS administrator has changed-->
      <!-- <data key='user.appserver.was.admin.password2' value='password'/> -->

      <!-- Optional: If the password used to access the DB2 database for
           Application Center has changed, you may specify it here-->
      <!-- <data key='user.database.db2.appcenter.password' value='password'/> -->

      <!-- Optional: If the password used to access the MySQL database for
           Application Center has changed, you may specify it here -->
      <!-- <data key='user.database.mysql.appcenter.password' value='password'/> -->

      <!-- Optional: If the password used to access the Oracle database for
           Application Center has changed, you may specify it here -->
      <!-- <data key='user.database.oracle.appcenter.password' value='password'/> -->
      ```

    c. Si no ha realizado una elección antes de activar la licencia de señales que se lanzó con un arreglo temporal el 15 de septiembre 2015 o posteriormente, elimine el comentario de la línea `<data key=’user.licensed.by.tokens’ value=’false’/>`. Establezca el valor en **true** si tiene un contrato para utilizar la licencia de señales con el Rational License Key Server. De lo contrario, establezca el valor en **false**.
      Si activa las licencias de señales, asegúrese de que Rational License Key Server esté configurado, y que se puedan obtener suficientes señales para ejecutar MobileFirst Server y las aplicaciones que sirve. De lo contrario, la aplicación de administración y el entorno de ejecución de MobileFirst Server no se pueden ejecutar.
      > **Restricción:** Después de que se haya tomado la decisión de activar las licencias de señales o no, no se puede modificar. Si ejecuta una actualización con el valor **true**, y más tarde otra actualización con el valor **false**, la segunda actualización fallará.

    d. Revise la identidad del perfil y la ubicación de instalación. La identidad del perfil y la ubicación de instalación deben coincidir con lo que está instalado:
      * Esta línea: `<profile id='IBM MobileFirst Platform Server' installLocation='/opt/IBM/MobileFirst_Platform_Server'>`
      * Y esta línea: `<offering id='com.ibm.mobilefirst.foundation.server' version='8.0.0.20160610_0940' profile='IBM MobileFirst Platform Server' features='main.feature' installFixes='none'/>`
      * Para revisar la identidad del perfil y los directorios de instalación conocidos en Installation Manager, puede escribir el mandato:
    ```bash
      installation_manager_path/eclipse/tools/imcl listInstallationDirectories -verbose
    ```

    e. Actualice el atributo de versión para establecerlo en la versión del arreglo temporal.
       Por ejemplo, si instala el arreglo temporal (8.0.0.0-MFPF-IF20171006-1725), sustituya

      ```xml
      <offering id='com.ibm.mobilefirst.foundation.server' version='8.0.0.20160610_0940' profile='IBM MobileFirst Platform Server' features='main.feature' installFixes='none'/>
      ```

      por

      ```xml
      <offering id='com.ibm.mobilefirst.foundation.server' version='8.0.0.20171006-1725' profile='IBM MobileFirst Platform Server' features='main.feature' installFixes='none'/>
      ```

      Installation Manager no solo utiliza los repositorios que se listan en el archivo de instalación, sino también los repositorios que se instalan en sus preferencias. La especificación del atributo de versión en el elemento de la oferta es opcional. Sin embargo, al especificarlo, asegúrese de que el arreglo temporal que está definido sea la versión que pretende instalar. Esta especificación altera temporalmente el resto de los repositorios con arreglos temporales que se listan en las preferencias del Installation Manager.

5. Abra una sesión con la cuenta de usuario que se utiliza en la instalación inicial.
    Para aplicar una actualización, Installation Manager debe ejecutarse con la misma lista de archivos de registro que se utilizan en la instalación inicial. La lista de software instalado y las opciones que se utilizan durante el momento de la instalación se almacenan en dichos archivos de registro. Si ejecuta Installation Manager en modalidad de administrador, los archivos de registro se instalarán en el nivel del sistema. En la carpeta `/var` en UNIX o Linux. En la carpeta `c:\ProgramData` en Windows. La ubicación es independiente del usuario que ejecuta Installation Manager (aunque la raíz es necesaria en UNIX y Linux). Sin embargo, si ejecuta Installation Manager en el modo de usuario único, los archivos de registro se almacenarán de forma predeterminada en el directorio de inicio del usuario.

6. Ejecute el mandato
  ```bash
   installation_manager_path/eclipse/tools/imcl input <responseFile> -log /tmp/installwl.log -acceptLicense
  ```
   donde,
   * <responseFile> es el archivo XML que edita en el paso 4.
   * *-log /tmp/installwl.log* es opcional. Especifica un archivo de registro para la salida de Installation Manager.
   * *-acceptLicense* es obligatorio. Esto significa que acepta los términos de licencia de IBM MobileFirst Platform Foundation V8.0.0. Sin esta opción, Installation Manager no puede continuar con la actualización.

## Siguientes pasos
{: #next-steps }

[Actualización del servidor de aplicaciones](../appserver-update)
