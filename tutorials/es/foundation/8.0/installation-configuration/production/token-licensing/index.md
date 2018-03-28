---
layout: tutorial
title: Instalación y configuración de licencias de señales 
breadcrumb_title: Token licensing
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
Si planea utilizar licencias de señales para {{ site.data.keys.mf_server }}, debe instalar la biblioteca de Rational Common Licensing y configurar su servidor de aplicaciones para conectar {{ site.data.keys.mf_server }} con Rational License Key Server.

En los temas siguientes se describe la visión general de la instalación, la instalación manual de la biblioteca de Rational Common Licensing, la configuración del servidor de aplicaciones y las limitaciones de plataforma conocidas para licencias de señales.

#### Ir a
{: #jump-to }

* [Planificación para la utilización de licencias de señales](#planning-for-the-use-of-token-licensing)
* [Visión general de la instalación de licencias de señales](#installation-overview-for-token-licensing)
* [Conexión de {{ site.data.keys.mf_server }}, instalado en Apache Tomcat, con Rational License Key Server](#connecting-mobilefirst-server-installed-on-apache-tomcat-to-the-rational-license-key-server)
* [Conexión de {{ site.data.keys.mf_server }}, instalado en el perfil de Liberty de WebSphere Application Server, con Rational License Key Server](#connecting-mobilefirst-server-installed-on-websphere-application-server-liberty-profile-to-the-rational-license-key-server)
* [Conexión de {{ site.data.keys.mf_server }}, instalado en WebSphere Application Server, con Rational License Key Server](#connecting-mobilefirst-server-installed-on-websphere-application-server-to-the-rational-license-key-server)
* [Limitaciones de plataformas soportadas para licencias de señales](#limitations-of-supported-platforms-for-token-licensing)
* [Resolución de problemas de licencias de señales](#troubleshooting-token-licensing-problems)

## Planificación para la utilización de licencias de señales
{: #planning-for-the-use-of-token-licensing }
Si se ha comprado una licencia de señal para {{ site.data.keys.mf_server }}, debe realizar pasos adicionales en la planificación de la instalación.

### Restricciones técnicas
{: #technical-restrictions }
Estas son las restricciones técnicas para el uso de licencias de señales:

#### Plataformas soportadas:
{: #supported-platforms }
La lista de plataformas que soportan licencias de señales está en [Limitaciones de plataformas soportadas para licencias de señales](#limitations-of-supported-platforms-for-token-licensing). La ejecución de {{ site.data.keys.mf_server }} en una plataforma que no esté listada es posible que no pueda instalarse y configurarse para licencias de señales. Es posible que las bibliotecas nativas para el cliente de Rational Common Licensing no estén disponibles para la plataforma o no estén soportadas.

#### Topologías soportadas:
{: #supported-topologies }
Las topologías soportadas por las licencias de señales se encuentran en [Restricciones en el servicio de administración de {{ site.data.keys.mf_server }}, el servicio Live Update de {{ site.data.keys.mf_server }} y el tiempo de ejecución de {{ site.data.keys.product_adj }}](../topologies/#constraints-on-mobilefirst-server-administration-service-mobilefirst-server-live-update-service-and-mobilefirst-foundation-runtime).

### Requisito de red
{: #network-requirement }
{{ site.data.keys.mf_server }} debe ser capaz de comunicarse con Rational License Key Server.

Esta comunicación requiere el acceso a los siguientes dos puertos de servidor de licencias:

* Puerto daemon de gestor de licencias (**lmgrd**): El número de puerto predeterminado es 27000.
* Puerto daemon de proveedor (**ibmratl**)
 
Para configurar los puertos para que utilicen valores estáticos, consulte Cómo servir una clave de licencia a máquinas de cliente a través de un cortafuegos.

### Proceso de instalación
{: #installation-process }
Debe activar las licencias de señales al ejecutar IBM Installation Manager al instalar. Para obtener más información sobre las instrucciones para habilitar las licencias de señales, consulte [Visión general de la instalación para licencias de señales](#installation-overview-for-token-licensing).

Tras instalar {{ site.data.keys.mf_server }}, debe configurar manualmente el servidor para licencias de señales. Para obtener más información, consulte los siguientes temas en esta sección.

{{ site.data.keys.mf_server }} no es funcional antes de completar esta configuración manual. La biblioteca de cliente de Rational Common Licensing se debe instalar en su servidor de aplicaciones y debe definir la ubicación de Rational License Key Server.

### Operaciones
{: #operations }
Después de instalar y configurar {{ site.data.keys.mf_server }} para licencias de señales, el servidor valida licencias durante varios escenarios. Para obtener más información sobre la recuperación de señales durante las operaciones, consulte [Validación de licencias de señal](../../../administering-apps/license-tracking/#token-license-validation).

Si necesita probar una aplicación no de producción en un servidor de producción con licencias de señales habilitadas, puede declarar la aplicación como no de producción. Para obtener más información sobre la declaración del tipo de aplicación, consulte [Establecimiento de la información de licencia de la aplicación](../../../administering-apps/license-tracking/#setting-the-application-license-information).

## Visión general de la instalación de licencias de señales
{: #installation-overview-for-token-licensing }
Si tiene la intención de utilizar licencias de señales con {{ site.data.keys.product }}, asegúrese de que lleva a cabo los siguientes pasos preliminares en este orden.

> **Importante:** Su elección sobre las licencias de señales (activarlas o no), como parte de una instalación que soporta licencias de señales, no se puede modificar. Si más adelante necesita cambiar la opción de licencias de señales, debe desinstalar y volver a instalar {{ site.data.keys.product }}.

1. Active las licencias de señales al ejecutar IBM Installation Manager para instalar {{ site.data.keys.product }}.

   #### Instalación en modalidad de gráficos
   Si instala el producto en modalidad de gráficos, seleccione la opción **Activar licencias de señales con Rational License Key Server** en el panel **Valores generales** durante la instalación.
    
   ![Activación de licencias de señales en IBM Installation Manager](licensing_with_tokens_activate.jpg)
    
   #### Instalación en modalidad de línea de mandatos
   Si instala en modalidad silenciosa, establezca el valor como **true** en el parámetro **user.licensed.by.tokens** en el archivo de respuestas.  
   Por ejemplo, puede utilizar:
    
   ```bash
   imcl install com.ibm.mobilefirst.foundation.server -repositories mfp_repository_dir/MobileFirst_Platform_Server/disk1 -properties user.appserver.selection2=none,user.database.selection2=none,user.database.preinstalled=false,user.use.ios.edition=false,user.licensed.by.tokens=true -acceptLicense
   ```
    
2. Despliegue {{ site.data.keys.mf_server }} en un servidor de aplicaciones una vez completada la instalación del producto. Para obtener más información, consulte [Instalación de {{ site.data.keys.mf_server }} en un servidor de aplicaciones](../appserver).

3. Configure {{ site.data.keys.mf_server }} para licencias de señales. Los pasos dependen se su servidor de aplicaciones.

* Para el perfil de Liberty de WebSphere Application Server, consulte [Conexión de {{ site.data.keys.mf_server }}, instalado en el perfil de Liberty de WebSphere Application Server, con Rational License Key Server](#connecting-mobilefirst-server-installed-on-websphere-application-server-liberty-profile-to-the-rational-license-key-server)
* Para Apache Tomcat, consulte [Conexión de {{ site.data.keys.mf_server }}, instalado en Apache Tomcat, con Rational License Key Server](#connecting-mobilefirst-server-installed-on-apache-tomcat-to-the-rational-license-key-server)
* Para el perfil completo de WebSphere Application Server, consulte [Conexión de {{ site.data.keys.mf_server }}, instalado en WebSphere Application Server, con Rational License Key Server](#connecting-mobilefirst-server-installed-on-websphere-application-server-to-the-rational-license-key-server).

## Conexión de {{ site.data.keys.mf_server }}, instalado en Apache Tomcat, con Rational License Key Server
{: #connecting-mobilefirst-server-installed-on-apache-tomcat-to-the-rational-license-key-server }
Debe instalar las bibliotecas nativa y Java de Rational Common Licensing en el servidor de aplicaciones de Apache Tomcat antes de conectar {{ site.data.keys.mf_server }} a Rational License Key Server.

* Rational License Key Server 8.1.4.8 o posterior debe estar instalado y configurado. La red debe permitir la comunicación desde y hasta {{ site.data.keys.mf_server }} abriendo puertos de comunicación bidireccional (**lmrgd** e **ibmratl**). Para obtener más información, consulte [Portal de Rational License Key Server](https://www.ibm.com/support/entry/portal/product/rational/rational_license_key_server?productContext=-283469295) y [Cómo servir una clave de licencia a máquinas de cliente a través de un cortafuegos](http://www.ibm.com/support/docview.wss?uid=swg21257370).
* Asegúrese de que las claves de licencia para {{ site.data.keys.product }} están generadas. Para obtener más información sobre la generación y gestión de sus claves de licencia con IBM Rational License Key Center, consulte [IBM Support - Licensing](http://www.ibm.com/software/rational/support/licensing/) y [Obtención de claves de licencia con IBM Rational License Key Center](https://www.ibm.com/support/knowledgecenter/SSSTWP_8.1.4/com.ibm.rational.license.doc/topics/t_access_license_key_center.html).
* {{ site.data.keys.mf_server }} debe estar instalado y configurado con la opción Activar licencias de señales con Rational License Key Server en su Apache Tomcat como se indica en [Visión general de la instalación para licencias de señales](#installation-overview-for-token-licensing).

### Instalación de bibliotecas Rational Common Licensing
{: #installing-rational-common-licensing-libraries }

1. Elija la biblioteca nativa de Rational Common Licensing. Dependiendo se su sistema operativo y la versión de bit de Java Runtime Environment (JRE) en la que se ejecuta su Apache Tomcat, debe elegir la biblioteca nativa correcta en **dir\_instalación\_producto/MobileFirstServer/tokenLibs/bin/su\_plataforma/archivo\_biblioteca\_nativa**. Por ejemplo, para Linux x86 con un JRE de 64 bits, la biblioteca se encuentra en **dir\_instalación\_producto/MobileFirstServer/tokensLibs/bin/Linux\_x86\_64/librcl\_ibmratl.so**.
2. Copie la biblioteca nativa en el sistema donde se ejecuta el servicio de administración de {{ site.data.keys.mf_server }}. El directorio puede ser **${CATALINA_HOME}/bin**. 
    > **Nota:** **${CATALINA_HOME}** es el directorio de instalación de su Apache Tomcat.
3. Copie el archivo **rcl_ibmratl.jar** en **${CATALINA_HOME}/lib**. El archivo **rcl_ibmratl.jar** es una biblioteca Java de Rational Common Licensing que se encuentra en el directorio **dir\_instalación\_producto/MobileFirstServer/tokenLibs**. La biblioteca utiliza la biblioteca nativa copiada en el paso 2 y solo se puede cargar una vez en Apache Tomcat. Este archivo debe ubicarse en el directorio **${CATALINA_HOME}/lib** o en cualquier directorio de la vía de acceso del cargador de clases común de Apache Tomcat.
    > **Importante:** La máquina virtual Java (JVM) de Apache Tomcat necesita privilegios de lectura y ejecución en las bibliotecas copiadas Java y nativa. Ambos archivos copiados deben ser leíbles y ejecutables por lo menos por el proceso del servidor de aplicaciones en su sistema operativo.
4. Configure el acceso de la JVM de su servidor de aplicaciones a la biblioteca de Rational Common Licensing. Para cualquier sistema operativo, configure el archivo **${CATALINA_HOME}/bin/setenv.bat** (o **setenv.sh** en UNIX) añadiendo la siguiente línea:

   **Windows:**  
    
   ```bash
   set CATALINA_OPTS=%CATALINA_OPTS% -Djava.library.path=absolute_path_to_the_previous_bin_directory
   ```
    
   **UNIX:**

   ```bash
   CATALINA_OPTS="$CATALINA_OPTS -Djava.library.path=absolute_path_to_the_previous_bin_directory"
   ```
    
   > **Nota:** Si mueve la carpeta de configuración del servidor donde se ejecuta el servicio de administración, debe actualizar **java.library.path** con la nueva vía de acceso absoluta.

5. Configure {{ site.data.keys.mf_server }} para acceder a Rational License Key Server. En el archivo **${CATALINA_HOME}/conf/server.xml**, busque el elemento `Context` de la aplicación de servicio de administración y añada las siguientes líneas de configuración JNDI.

   ```xml
   <Environment name="mfp.admin.license.key.server.host" value="rlks_hostname" type="java.lang.String" override="false"/>
   <Environment name="mfp.admin.license.key.server.port" value="rlks_port" type="java.lang.String" override="false"/>
   ```
   * **rlks_hostname** es el nombre de host de Rational License Key Server.
   * **rlks_port** es el puerto de Rational License Key Server. De forma predeterminada, el valor es **27000**.

Para obtener más información sobre las propiedades JNDI, consulte [Propiedades JNDI para servicios de administración: Licencia](../server-configuration/#jndi-properties-for-administration-service-licensing).

### Instalación en granja de servidores Apache Tomcat
{: #installing-on-apache-tomcat-server-farm }
Para configurar la conexión de {{ site.data.keys.mf_server }} en la granja de servidores de Apache Tomcat, debe seguir todos los pasos descritos en [Instalación de bibliotecas Rational Common Licensing](#installing-rational-common-licensing-libraries) para cada nodo de su granja de servidores donde se ejecute el servicio de administración de {{ site.data.keys.mf_server }}. Para obtener más información sobre las granjas de servidores, consulte [Topología de granja de servidores](../topologies/#server-farm-topology) e [Instalación de una granja de servidores](../appserver/#installing-a-server-farm).

## Conexión de {{ site.data.keys.mf_server }}, instalado en el perfil de Liberty de WebSphere Application Server, con Rational License Key Server
{: #connecting-mobilefirst-server-installed-on-websphere-application-server-liberty-profile-to-the-rational-license-key-server }
Debe instalar las bibliotecas nativa y Java de Rational Common Licensing en el perfil de Liberty antes de conectar {{ site.data.keys.mf_server }} con Rational License Key Server.

* Rational License Key Server 8.1.4.8 o posterior debe estar instalado y configurado. La red debe permitir la comunicación desde y hasta {{ site.data.keys.mf_server }} abriendo puertos de comunicación bidireccional (**lmrgd** e **ibmratl**). Para obtener más información, consulte [Portal de Rational License Key Server](https://www.ibm.com/support/entry/portal/product/rational/rational_license_key_server?productContext=-283469295) y [Cómo servir una clave de licencia a máquinas de cliente a través de un cortafuegos](http://www.ibm.com/support/docview.wss?uid=swg21257370).
* Asegúrese de que las claves de licencia para {{ site.data.keys.product }} están generadas. Para obtener más información sobre la generación y gestión de sus claves de licencia con IBM Rational License Key Center, consulte [IBM Support - Licensing](http://www.ibm.com/software/rational/support/licensing/) y [Obtención de claves de licencia con IBM Rational License Key Center](https://www.ibm.com/support/knowledgecenter/SSSTWP_8.1.4/com.ibm.rational.license.doc/topics/t_access_license_key_center.html).
* {{ site.data.keys.mf_server }} debe estar instalado y configurado con la opción Activar licencias de señales con Rational License Key Server en su Apache Tomcat como se indica en [Visión general de la instalación para licencias de señales](#installation-overview-for-token-licensing).

### Instalación de bibliotecas Rational Common Licensing
{: #common-licensing-libraries-liberty }

1. Defina una biblioteca compartida para el cliente de Rational Common Licensing. Esta biblioteca utiliza código nativo y solo se puede cargar una vez en el servidor de aplicaciones. Por lo tanto, las aplicaciones que la utilizan deben hacer referencia a ella como una biblioteca común.
   * Elija la biblioteca nativa de Rational Common Licensing. Dependiendo se su sistema operativo y la versión de bit de Java Runtime Environment (JRE) en la que se ejecuta su perfil de Liberty, debe elegir la biblioteca nativa correcta en **dir\_instalación\_producto/MobileFirstServer/tokenLibs/bin/su\_plataforma/archivo\_biblioteca\_nativa**. Por ejemplo, para Linux x86 con un JRE de 64 bits, la biblioteca se encuentra en **dir_instalación_producto/MobileFirstServer/tokensLibs/bin/Linux_x86_64/librcl_ibmratl.so**.
   * Copie la biblioteca nativa en el sistema donde se ejecuta el servicio de administración de {{ site.data.keys.mf_server }}. El directorio puede ser **${shared.resource.dir}/rcllib**. El directorio **${shared.resource.dir}** se encuentra, normalmente, en **usr/shared/resources**, donde usr es el directorio que contiene también el directorio usr/servers. Para obtener más información sobre la ubicación estándar de **${shared.resource.dir}**, consulte [ WebSphere Application Server, Liberty Core - Ubicaciones de directorio y propiedades](http://www.ibm.com/support/knowledgecenter/SSD28V_8.5.5/com.ibm.websphere.wlp.core.doc/ae/rwlp_dirs.html?lang=en&view=kc). Si la carpeta **rcllib** no existe, cree la carpeta y copie el archivo de biblioteca nativa en ella.
    
   > **Nota:** Asegúrese de que la máquina virtual Java (JVM) del servidor de aplicaciones tiene privilegios de lectura y ejecución en la biblioteca nativa. En Windows, aparece la siguiente excepción en el registro del servidor de aplicaciones si la JVM del servidor de aplicaciones no tiene derechos de ejecutable en la biblioteca nativa copiada.
    
   ```bash
   com.ibm.rcl.ibmratl.LicenseConfigurationException: java.lang.UnsatisfiedLinkError: rcl_ibmratl (Access is denied).
   ```
   * Copie el archivo **rcl_ibmratl.jar** en **${shared.resource.dir}/rcllib**. El archivo **rcl_ibmratl.jar** es una biblioteca Java de Rational Common Licensing que se encuentra en el directorio **dir_instalación_producto/MobileFirstServer/tokenLibs**.

   > **Nota:** La máquina virtual Java (JVM) del perfil de Liberty debe tener la posibilidad de leer la biblioteca Java copiada. Este archivo también debe tener privilegio de lectura (por lo menos para el proceso del servidor de aplicaciones) en su sistema operativo.    
   * Declare una biblioteca compartida que utilice el archivo **rcl_ibmratl.jar** en el archivo **${server.config.dir}/server.xml**.

   ```xml
   <!-- Declare a shared Library for the RCL client. -->
   <!- This library can be loaded only once because it uses native code. -->
   <library id="RCLLibrary">
       <fileset dir="${shared.resource.dir}/rcllib" includes="rcl_ibmratl.jar"/>
   </library>
   ```    
   * Declare la biblioteca compartida como una biblioteca común para la aplicación del servicio de administración de {{ site.data.keys.mf_server }} añadiendo un atributo (**commonLibraryRef**) al cargador de clases de la aplicación. Puesto que la biblioteca solo se puede cargar una vez, debe utilizarse como biblioteca común y no como biblioteca privada.

   ```xml
   <application id="mfpadmin" name="mfpadmin" location="mfp-admin-service.war" type="war">
      [...]
      <!- Declare the shared library as an attribute commonLibraryRef to 
          the class loader of the application. -->
      <classloader delegation="parentLast" commonLibraryRef="RCLLibrary">
      </classloader>
   </application>
   ```
   * Si utiliza Oracle como base de datos, el **server.xml** ya debe tener los siguientes cargadores de clases:

   ```xml
   <classloader delegation="parentLast" commonLibraryRef="MobileFirst/JDBC/oracle">
    </classloader>
   ```
    
   También debe añadir la biblioteca de Rational Common Licensing como biblioteca común a la biblioteca Oracle tal como se indica a continuación:
    
   ```xml
   <classloader delegation="parentLast"
         commonLibraryRef="MobileFirst/JDBC/oracle,RCLLibrary">
   </classloader>
   ```
   * Configure el acceso de la JVM de su servidor de aplicaciones a la biblioteca de Rational Common Licensing. Para cualquier sistema operativo, configure el archivo **${wlp.user.dir}/servers/nombre_servidor/jvm.options** añadiendo la siguiente línea:

   ```xml
   -Djava.library.path=Absolute_path_to_the_previously_created_rcllib_folder
   ```
    
   > **Nota:** Si mueve la carpeta de configuración del servidor donde se ejecuta el servicio de administración, debe actualizar **java.library.path** con la nueva vía de acceso absoluta.

   El directorio **${wlp.user.dir}** se encuentra, normalmente, en **dir_instalación_liberty/usr** y contiene el directorio de servidores. Sin embargo, su ubicación se puede personalizar. Para obtener más información, consulte [ Personalización del entorno Liberty](http://www.ibm.com/support/knowledgecenter/SSD28V_8.5.5/com.ibm.websphere.wlp.core.doc/ae/twlp_admin_customvars.html?lang=en&view=kc).
    
2. Configure {{ site.data.keys.mf_server }} para acceder a Rational License Key Server.

   En el archivo **${wlp.user.dir}/servers/nombre_servidor/server.xml** añada estas líneas de configuración JNDI.
    
   ```xml
   <jndiEntry jndiName="mfp.admin.license.key.server.host" value="rlks_hostname"/> 
   <jndiEntry jndiName="mfp.admin.license.key.server.port" value="rlks_port"/> 
   ```
   * **rlks_hostname** es el nombre de host de Rational License Key Server.
   * **rlks_port** es el puerto de Rational License Key Server. De forma predeterminada, el valor es 27000.

   Para obtener más información sobre las propiedades JNDI, consulte [Propiedades JNDI para servicios de administración: Licencia](../server-configuration/#jndi-properties-for-administration-service-licensing).

### Instalación en granja de servidores de perfil de Liberty
{: #installing-on-liberty-profile-server-farm }
Para configurar la conexión de {{ site.data.keys.mf_server }} en la granja de servidores de perfil de Liberty, debe seguir todos los pasos descritos en [Instalación de bibliotecas Rational Common Licensing](#installing-rational-common-licensing-libraries) para cada nodo de su granja de servidores donde se ejecute el servicio de administración de {{ site.data.keys.mf_server }}. Para obtener más información sobre las granjas de servidores, consulte [Topología de granja de servidores](../topologies/#server-farm-topology) e [Instalación de una granja de servidores](../appserver/#installing-a-server-farm).

## Conexión de {{ site.data.keys.mf_server }}, instalado en WebSphere Application Server, con Rational License Key Server
{: #connecting-mobilefirst-server-installed-on-websphere-application-server-to-the-rational-license-key-server }
Debe configurar una biblioteca compartida para las bibliotecas de Rational Common Licensing en WebSphere Application Server antes de conectar {{ site.data.keys.mf_server }} con Rational License Key Server.

* Rational License Key Server 8.1.4.8 o posterior debe estar instalado y configurado. La red debe permitir la comunicación desde y hasta {{ site.data.keys.mf_server }} abriendo puertos de comunicación bidireccional (**lmrgd** e **ibmratl**). Para obtener más información, consulte [Portal de Rational License Key Server](https://www.ibm.com/support/entry/portal/product/rational/rational_license_key_server?productContext=-283469295) y [Cómo servir una clave de licencia a máquinas de cliente a través de un cortafuegos](http://www.ibm.com/support/docview.wss?uid=swg21257370).
* Asegúrese de que las claves de licencia para {{ site.data.keys.product }} están generadas. Para obtener más información sobre la generación y gestión de sus claves de licencia con IBM Rational License Key Center, consulte [IBM Support - Licensing](http://www.ibm.com/software/rational/support/licensing/) y [Obtención de claves de licencia con IBM Rational License Key Center](https://www.ibm.com/support/knowledgecenter/SSSTWP_8.1.4/com.ibm.rational.license.doc/topics/t_access_license_key_center.html).
* {{ site.data.keys.mf_server }} debe estar instalado y configurado con la opción Activar licencias de señales con Rational License Key Server en su Apache Tomcat como se indica en [Visión general de la instalación para licencias de señales](#installation-overview-for-token-licensing).

### Instalación de una biblioteca de Rational Common Licensing en un servidor autónomo
{: #installing-rational-common-licensing-library-on-a-stand-alone-server }

1. Defina una biblioteca compartida para la biblioteca de Rational Common Licensing. Esta biblioteca utiliza código nativo y solo se puede cargar una vez durante el ciclo de vida del servidor de aplicaciones por el cargador de clases. Por este motivo, la biblioteca se declara como una biblioteca compartida y se asocia con todos los servidores de aplicaciones que se ejecutan el servicio de administración de {{ site.data.keys.mf_server }}. Para obtener más información sobre los motivos para declarar esta biblioteca como una biblioteca compartida, consulte [Configuración de bibliotecas nativas en bibliotecas compartidas](http://www.ibm.com/support/knowledgecenter/SSEQTP_8.5.5/com.ibm.websphere.base.doc/ae/tcws_sharedlib_nativelib.html?view=kc).
    * Elija la biblioteca nativa de Rational Common Licensing. Dependiendo se su sistema operativo y la versión de bit de Java Runtime Environment (JRE) en la que se ejecuta su WebSphere Application Server, debe elegir la biblioteca nativa correcta en **dir\_instalación\_producto/MobileFirstServer/tokenLibs/bin/su\_plataforma/archivo\_biblioteca\_nativa**.
    
        Por ejemplo, para Linux x86 con un JRE de 64 bits, la biblioteca se encuentra en **dir_instalación_producto/MobileFirstServer/tokensLibs/bin/Linux_x86_64/librcl_ibmratl.so**.
    
        Para determinar la versión de bit de Java Runtime Environment para un WebSphere Application Server autónomo o una instalación de WebSphere Application Server Network Deployment, ejecute **versionInfo.bat** en Windows o **versionInfo.sh** en UNIX desde el directorio **bin**. El archivo **versionInfo.sh** se encuentra en **/opt/IBM/WebSphere/AppServer/bin**. Examine el valor de la arquitectura en la sección **Producto instalado**. Java Runtime Environment es de 64 bits si el valor de la arquitectura lo menciona de forma explícita o si es el sufijo es 64 o _64.
    * Coloque la biblioteca nativa que corresponda a su plataforma en una carpeta de su sistema operativo. Por ejemplo, **/opt/IBM/RCL_Native_Library/**.
    * Copie el archivo **rcl_ibmratl.jar** en **/opt/IBM/RCL_Native_Library/**. El archivo **rcl_ibmratl.jar** es una biblioteca Java de Rational Common Licensing que se puede encontrar en el directorio **dir_instalación_producto/MobileFirstServer/tokenLibs**.
    
        > **Importante:** La máquina virtual Java (JVM) del servidor de aplicaciones necesita privilegios de lectura y ejecución en las bibliotecas copiadas Java y nativa. Ambos archivos copiados deben ser leíbles y ejecutables por lo menos por el proceso del servidor de aplicaciones en su sistema operativo.    
    * Declare una biblioteca compartida en la consola de administración de WebSphere Application Server.
        * Inicie sesión en la consola de administración de WebSphere Application Server.
        * Expanda **Entorno → Bibliotecas compartidas**.
        * Seleccione un ámbito visible para todos los servidores que ejecutan el servicio de administración de {{ site.data.keys.mf_server }}. Por ejemplo, un clúster.
        * Pulse **Nuevo**.
        * Introduzca un nombre para la biblioteca en el campo Name. Por ejemplo, "Biblioteca compartida de RCL".
        * En el campo Classpath, introduzca la vía de acceso al archivo **rcl_ibmratl.jar**. Por ejemplo, **/opt/IBM/RCL_Native_Library/rcl_ibmratl.jar**.
        * Pulse **Aceptar** y guarde los cambios. Este valor entra en vigor cuando se reinicia el servidor.
    
        > **Nota:** La vía de acceso de la biblioteca nativa de esta biblioteca se establece en el paso 3 en la propiedad **ld.library.path** de la máquina virtual Java del servidor.
    * Asocie la biblioteca compartida con todos los servidores que ejecuten el servicio de administración de {{ site.data.keys.mf_server }}.
    
        Asociar la biblioteca compartida a un servidor permite que la biblioteca compartida se utilice en varias aplicaciones. Si solo necesita el cliente de Rational Common Licensing para el servicio de administración de {{ site.data.keys.mf_server }}, puede crear una biblioteca compartida con un cargador de clases aislado y asociarlo con la aplicación de servicio de administración.

        La siguiente instrucción es asociar la biblioteca con un servidor. Para WebSphere Application Server Network Deployment, debe completar estas instrucciones para todos los servidores que ejecuten el servicio de administración de {{ site.data.keys.mf_server }}.    
        * Establezca la política y modalidad de cargador de clases.    
            1. En la consola de administración de WebSphere Application Server, pulse **Servidores → Tipos de servidores → Servidor de aplicaciones de WebSphere → nombre_servidor** para acceder a la página del valor de servidor de aplicaciones.
            2. Establezca los valores de la política de cargador de clases de aplicación y modalidad de cargador de clases del servidor:
                * **Política de cargador de clases**: Varias
                * **Modalidad de cargador de clases**: Clases cargadas con cargador de clases padre primero
            3. En la sección **Infraestructura de servidor**, pulse **Java y gestión de proceso → Cargador de clases**.
            4. Pulse **Nuevo** y asegúrese de que el orden de cargador de clases se establece en **Clases cargadas con cargador de clases padre primero**.
            5. Pulse **Aplicar** para crear un nuevo ID de cargador de clases.                
        * Cree una referencia de biblioteca para cada archivo de biblioteca compartida que necesite su aplicación.
            1. Pulse el nombre del cargador de clases creado en el paso anterior.
            2. En la sección **Propiedades adicionales**, pulse **Referencias de biblioteca compartida**.
            3. Pulse **Añadir**.
            4. En la página de valores de referencia de biblioteca, seleccione la referencia de biblioteca adecuada. El nombre identifica el archivo de biblioteca compartida que utiliza su aplicación. Por ejemplo, Biblioteca compartida de RCL.
            5. Pulse **Aplicar** y, a continuación, guarde los cambios.
2. Configure las entradas de entorno para la aplicación web del servicio de administración de {{ site.data.keys.mf_server }}.
    * En la consola de administración de WebSphere Application Server, pulse **Aplicaciones → Tipos de aplicación → Aplicaciones empresariales de WebSphere** y seleccione la aplicación del servicio de administración: **MobileFirst_Administration_Service**.
    * En la sección **Propiedades de módulo web**, pulse **Entradas de entorno para módulos web**.
    * Introduzca los valores para **mfp.admin.license.key.server.host** y **mfp.admin.license.key.server.port**.
        * **mfp.admin.license.key.server.host** es el nombre de host del Rational License Key Server.
        * **mfp.admin.license.key.server.port** es el puerto de Rational License Key Server. De forma predeterminada, el valor es 27000.
    * Pulse **Aceptar** y guarde los cambios.
3. Configure el acceso del servidor de aplicaciones JVM a la biblioteca de Rational Common Licensing.
    * En la consola de administración de WebSphere Application Server, pulse **Servidores → Tipos de servidor → WebSphere Application Servers** y seleccione su servidor.
    * En la sección **Infraestructura de servidor**, pulse **Java y gestión de proceso → Definición de proceso → Máquina virtual Java → Propiedades personalizadas → Nueva** para añadir una propiedad personalizada.
    * En el campo **Name**, escriba el nombre de la propiedad personalizada como **java.library.path**.
    * En el campo **Value**, introduzca la vía de acceso de la carpeta donde ha colocado el archivo de biblioteca nativa en el paso 1b. Por ejemplo, **/opt/IBM/RCL_Native_Library/**.
    * Pulse **Aceptar** y guarde los cambios.
4. Reinicie su servidor de aplicaciones.

### Instalación de una biblioteca de Rational Common Licensing en WebSphere Application Server Network Deployment
{: #installing-rational-common-licensing-library-on-websphere-application-server-network-deployment }
Para instalar la biblioteca nativa en WebSphere Application Server Network Deployment, debe seguir todos los pasos descritos en [Instalación de una biblioteca de Rational Common Licensing en un servidor autónomo](#installing-rational-common-licensing-library-on-a-stand-alone-server). Los servidores o clústeres que configure deben reiniciarse para que los cambios surtan efecto.

Cada nodo de su WebSphere Application Server Network Deployment debe tener una copia de la biblioteca nativa de Rational Common Licensing.

Cada servidor donde se ejecuta el servicio de administración de {{ site.data.keys.mf_server }} debe estar configurado para tener acceso a la biblioteca nativa copiada en su sistema local. Estos servidores también se deben configurar para conectarse a Rational License Key Server.

> **Importante:** Si utiliza un clúster con WebSphere Application Server Network Deployment, su clúster puede cambiar. Debe configurar cada servidor nuevo en su clúster, donde se ejecutan los servicios de administración.

## Limitaciones de plataformas soportadas para licencias de señales
{: #limitations-of-supported-platforms-for-token-licensing }
La lista de sistema operativo, su versión y la arquitectura de hardware que soporta {{ site.data.keys.mf_server }} con licencias de señales habilitadas.

Para licencias de señales, {{ site.data.keys.mf_server }} debe conectarse a Rational License Key Server utilizando la biblioteca de Rational Common Licensing.

Esta biblioteca está compuesta de una biblioteca Java y también bibliotecas nativas. Estas bibliotecas nativas dependen de la plataforma donde se ejecuta {{ site.data.keys.mf_server }}. Por lo tanto, las licencias de señales por {{ site.data.keys.mf_server }} solo están soportadas en las plataformas donde se pueden ejecutar bibliotecas de Rational Common Licensing.

La tabla siguiente describe las plataformas que soportan {{ site.data.keys.mf_server }} con licencias de señales.

| Sistema operativo             | Versión sistema operativo |	Arquitectura hardware |
|------------------------------|--------------------------|-----------------------|
| AIX                          | 7.1                      |	POWER8 (solo 64 bits) |
| SUSE Linux Enterprise Server | 11	                      | Solo x86-64           |
| Windows Server               | 2012	                  | Solo x86-64           |

Las licencias de señal no soportan Java Runtime Environment (JRE) de 32 bits. Asegúrese de que el servidor de aplicaciones utiliza JRE de 64 bits.

## Resolución de problemas de licencias de señales
{: #troubleshooting-token-licensing-problems }
Encuentra información para ayudar a resolver problemas que puede encontrar con las licencias de señales si ha activado esta característica al instalar {{ site.data.keys.mf_server }}.

Cuando inicia el servicio de administración de {{ site.data.keys.mf_server }} después de instalar y configurar completamente las licencias de señales, pueden emitirse algunos problemas o excepciones en el registro del servidor de aplicaciones o en {{ site.data.keys.mf_console }}. Estas excepciones pueden deberse a una instalación incorrecta de la biblioteca de Rational Common Licensing y la configuración del servidor de aplicaciones.

**Apache Tomcat**  
Compruebe el archivo **catalina.log** o catalina.out, dependiendo de su plataforma.

**Perfil de Liberty de WebSphere® Application Server**  
Compruebe el archivo **messages.log**.

**Perfil completo de WebSphere Application Server**  
Compruebe el archivo **SystemOut.log**.

> **Importante:** Si las licencias de señales están instaladas en WebSphere Application Server Network Deployment o en un clúster, debe comprobar el registro de cada servidor.

A continuación se muestra una lista de excepciones que pueden ocurrir tras la instalación y configuración de licencias de señales:

* [No se ha encontrado la biblioteca nativa de Rational Common Licensing](#rational-common-licensing-native-library-is-not-found)
* [No se ha encontrado la biblioteca compartida de Rational Common Licensing](#rational-common-licensing-shared-library-is-not-found)
* [No se ha configurado la conexión de Rational License Key Server](#the-rational-license-key-server-connection-is-not-configured)
* [Rational License Key Server no está accesible](#the-rational-license-key-server-is-not-accessible)
* [No se ha podido iniciar la API de Rational Common Licensing](#failed-to-initialize-rational-common-licensing-api)
* [Licencias de señal insuficientes](#insufficient-token-licenses)
* [Archivo rcl_ibmratl.jar no válido](#invalid-rcl_ibmratljar-file)

### No se ha encontrado la biblioteca nativa de Rational Common Licensing
{: #rational-common-licensing-native-library-is-not-found }

> FWLSE3125E: No se ha encontrado la biblioteca nativa de Rational Common Licensing. Asegúrese de que la propiedad JVM (java.library.path) está definida con la vía de acceso correcta y de que se puede ejecutar la biblioteca nativa. Reinicie {{ site.data.keys.mf_server }} después de emprender una acción correctiva.

#### Para perfil completo de WebSphere Application Server
{: #for-websphere-application-server-full-profile }
Las causas posibles de este error pueden ser:

* No se ha definido una propiedad común con el nombre **java.library.path** a nivel de servidor.
* La vía de acceso proporcionada como valor para la propiedad **java.library.path** no contiene la biblioteca nativa de Rational Common Licensing.
* La biblioteca nativa no dispone de los permisos adecuados. La biblioteca debe tener privilegios de lectura y ejecución en UNIX y Windows para el usuario que accede a ella con Java™ Runtime
* Entorno del servidor de aplicaciones.

#### Para el perfil de Liberty de WebSphere Application Server y Apache Tomcat
{: #for-websphere-application-server-liberty-profile-and-apache-tomcat }
Las causas posibles de este error pueden ser:

* La vía de acceso a la biblioteca nativa de Rational Common Licensing especificada como valor de la propiedad java.library.path no se ha establecido o no es correcta.
    * Para el perfil de Liberty, compruebe el archivo **${wlp.user.dir}/servers/nombre_servidor/jvm.options**.
    * Para Apache Tomcat, compruebe el archivo **${CATALINA_HOME}/bin/setenv.bat** o setenv.sh file, dependiendo de su plataforma.
* No se ha encontrado la biblioteca nativa en la vía de acceso definida en la propiedad **java.library.path**. Compruebe que la biblioteca nativa existe en la vía de acceso definida con el nombre esperado.
* La biblioteca nativa no dispone de los permisos adecuados. El error podría estar precedido por esta excepción:`com.ibm.rcl.ibmratl.LicenseConfigurationException: java.lang.UnsatisfiedLinkError: {0}\rcl_ibmratl.dll: Access is denied`.

El Java Runtime Environment del servidor de aplicaciones necesita privilegios de lectura y ejecución en esta biblioteca nativa. El archivo de biblioteca también debe ser leíble y ejecutable por lo menos por el proceso del servidor de aplicaciones en su sistema operativo.

* La biblioteca compartida que utiliza el archivo **rcl_ibmratl.jar** no está definida en el archivo **${server.config.dir}/server.xml** para el perfil de Liberty. **rcl_ibmratl.jar** podría no estar en el directorio correcto o el directorio no tiene los permisos adecuados.
* La biblioteca compartida que utiliza el archivo **rcl_ibmratl.jar** no está declarada como biblioteca común para la aplicación de servicio de administración de {{ site.data.keys.mf_server }} en el archivo **${server.config.dir}/server.xml** para el perfil de Liberty.
* Hay una combinación de objetos de 32 y 64 bits entre el Java Runtime Environment del servidor de aplicaciones y la biblioteca nativa. Por ejemplo, se utiliza un Java Runtime Environment de 32 bits con una biblioteca nativa de 64 bits. Esta mezcla no está soportada.

### No se ha encontrado la biblioteca compartida de Rational Common Licensing
{: #rational-common-licensing-shared-library-is-not-found }

> FWLSE3126E: No se ha encontrado la biblioteca compartida de Rational Common Licensing. Asegúrese de que la biblioteca compartida está configurada. Reinicie {{ site.data.keys.mf_server }} después de emprender una acción correctiva.

Las causas posibles de este error pueden ser:

* El archivo **rcl_ibmratl.jar** no se encuentra en el directorio previsto.
    * Para Apache Tomcat, compruebe que el archivo está en el directorio **${CATALINA_HOME}/lib**.
    * Para el perfil de Liberty de WebSphere Application Server, compruebe que el archivo se encuentra en el directorio definido en el archivo server.xml de la biblioteca compartida del cliente de Rational Common Licensing. Por ejemplo, **${shared.resource.dir}/rcllib**. En el archivo **server.xml**, asegúrese de que esta biblioteca compartida está referenciada correctamente como biblioteca común para la aplicación de servicio de administración de {{ site.data.keys.mf_server }}.
    * Para WebSphere Application Server, asegúrese de que este archivo se encuentra en el directorio que se especifica en la vía de acceso de clases de la biblioteca compartida de WebSphere Application Server. Compruebe que la vía de acceso de clases de la biblioteca compartida contiene esta entrada: **absolute\_path/rcl\_ibmratl.jar** siendo absolute_path la vía de acceso absoluta del archivo **rcl_ibmratl.jar**.

La propiedad **java.library.path** no está establecida para el servidor de aplicaciones. Defina una propiedad con el nombre **java.library.path** y establezca la vía de acceso a la biblioteca nativa de Rational Common Licensing como valor. Por ejemplo, **/opt/IBM/RCL/_Native\_Library/**.
* La biblioteca nativa no dispone de los permisos esperados. En Windows, el Java Runtime Environment del servidor de aplicaciones debe tener privilegios de lectura y ejecución en la biblioteca nativa.
* Hay una combinación de objetos de 32 y 64 bits entre el Java Runtime Environment del servidor de aplicaciones y la biblioteca nativa. Por ejemplo, se utiliza un Java Runtime Environment de 32 bits con una biblioteca nativa de 64 bits. Esta mezcla no está soportada.

### No se ha configurado la conexión de Rational License Key Server
{: #the-rational-license-key-server-connection-is-not-configured }

> FWLSE3127E: No se ha configurado la conexión de Rational License Key Server. Asegúrese de que las propiedades JNDI de administrador "mfp.admin.license.key.server.port" y "mfp.admin.license.key.server.host" están establecidas. Reinicie {{ site.data.keys.mf_server }} después de emprender una acción correctiva.

Las causas posibles de este error pueden ser:

* La biblioteca nativa de Rational Common Licensing y la biblioteca compartida que utiliza el archivo **rcl_ibmratl.jar** están configuradas correctamente pero el valor de las propiedades JNDI (**mfp.admin.license.key.server.host** y **mfp.admin.license.key.server.port**) no está establecido en la aplicación de servicio de administración de {{ site.data.keys.mf_server }}.
* Rational License Key Server está caído.
* El sistema principal donde está instalado el Rational License Key Server no se puede alcanzar. Compruebe la dirección IP o el nombre de host con el puerto especificado.

### Rational License Key Server no está accesible
{: #the-rational-license-key-server-is-not-accessible }

> FWLSE3128E: Rational License Key Server "{port}@{IP address or hostname}" no está accesible. Asegúrese de que el servidor de licencias se está ejecutando y es accesible en {{ site.data.keys.mf_server }}. Si se produce este error al iniciar el tiempo de ejecución, reinicie {{ site.data.keys.mf_server }} después de emprender una acción correctiva.

Las causas posibles de este error pueden ser:

* La biblioteca compartida de Rational Common Licensing y la biblioteca nativa están definidas correctamente pero no hay ninguna configuración válida para conectar con el Rational License Key Server. Compruebe la dirección IP, el nombre de host y el puerto del servidor de licencias. Asegúrese de que el servidor de licencias se ha iniciado y es accesible desde el sistema donde está instalado el servidor de aplicaciones.
* No se ha encontrado la biblioteca nativa en la vía de acceso definida en la propiedad **java.library.path**.
* La biblioteca nativa no dispone de los permisos adecuados.
* La biblioteca nativa no está en el directorio definido.
* Rational License Key Server está detrás de un cortafuegos. El error podría estar precedido por esta excepción: [ERROR] No se ha podido obtener la licencia para la aplicación 'WorklightStarter' porque Rational Licence Key Server ({port}@{IP address or hostname}) está inactivo o no es accesible com.ibm.rcl.ibmratl.LicenseServerUnreachableException. Se han buscado las características en todos los archivos de licencia: {port}@{IP address or hostname}

Asegúrese de que el puerto daemon gestor de licencias (lmgrd) y el puerto daemon proveedor (ibmratl) están abiertos en su cortafuegos. Para obtener más información, consulte Cómo servir una clave de licencia a máquinas de cliente a través de un cortafuegos.

### No se ha podido iniciar la API de Rational Common Licensing
{: #failed-to-initialize-rational-common-licensing-api }

> No se ha podido inicializar la API de Rational Common Licensing (RCL) porque su biblioteca nativa no se ha podido encontrar o cargar com.ibm.rcl.ibmratl.LicenseConfigurationException: java.lang.UnsatisfiedLinkError: rcl_ibmratl (No se ha encontrado en java.library.path)

Las causas posibles de este error pueden ser:

* No se ha encontrado la biblioteca nativa de Rational Common Licensing en la vía de acceso definida en la propiedad **java.library.path**. Compruebe que la biblioteca nativa existe en la vía de acceso definida con el nombre esperado.
* La propiedad **java.library.path** no está establecida para el servidor de aplicaciones. Defina una propiedad con el nombre **java.library.path** y establezca la vía de acceso a la biblioteca nativa de Rational Common Licensing como valor. Por ejemplo, **/opt/IBM/RCL_Native_Library/**.
* Hay una combinación de objetos de 32 y 64 bits entre el Java Runtime Environment del servidor de aplicaciones y la biblioteca nativa. Por ejemplo, se utiliza un Java Runtime Environment de 32 bits con una biblioteca nativa de 64 bits. Esta mezcla no está soportada.

### Licencias de señal insuficientes
{: #insufficient-token-licenses }

> FWLSE3129E: Licencias de señal insuficientes para la característica "{0}".

Este error se produce cuando el número de licencias de señal restantes en Rational License Key Server no es suficiente para desplegar una nueva aplicación de {{ site.data.keys.product_adj }}.

### Archivo rcl_ibmratl.jar no válido
{: #invalid-rcl_ibmratljar-file }

> UTLS0002E: La biblioteca compartida Biblioteca compartida de RCL contiene una entrada de classpath que no se resuelve en un archivo jar válido, la biblioteca jar está previsto que se encuentre en {0}/rcl_ibmratl.jar.

**Nota:** Solo para WebSphere Application Server y WebSphere Application Server Network Deployment

Las causas posibles de este error pueden ser:

* La biblioteca Java **rcl_ibmratl.jar** no dispone de los permisos adecuados. El error podría estar seguido de otra excepción: java.util.zip.ZipException: Error al abrir el archivo zip. Compruebe que el archivo **rcl_ibmratl.jar** tiene permisos de lectura para el usuario que instala WebSphere Application Server.
* Si no hay ninguna otra excepción, el archivo **rcl_ibmratl.jar** al que se hace referencia en la vía de acceso de clases de la biblioteca compartida puede no ser válido o no existe. Compruebe que el archivo **rcl_ibmratl.jar** es válido o existe en la vía de acceso definida.


