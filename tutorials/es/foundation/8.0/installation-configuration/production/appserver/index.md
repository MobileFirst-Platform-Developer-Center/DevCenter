---
layout: tutorial
title: Instalación de MobileFirst Server a un servidor de aplicaciones 
breadcrumb_title: Installing MobileFirst Server
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
La instalación de los componentes se puede realizar utilizando Tareas Ant, la Herramienta de configuración del servidor, o manualmente. Descubra el requisito previo y los detalles sobre el proceso de instalación para que pueda instalar los componentes en el servidor de aplicaciones satisfactoriamente.

Antes de continuar con la instalación de los componentes en el servidor de aplicaciones, asegúrese de que las bases de datos y las tablas de los componentes estén preparados y listos para su uso. Para obtener más información, consulte [Configuración de bases de datos](../databases).

También se debe definir la topología del servidor para instalar los componentes. Consulte [Flujos de red y topologías](../topologies).

#### Ir a
{: #jump-to }

* [Requisitos previos del servidor de aplicaciones](#application-server-prerequisites)
* [Instalación con la Herramienta de configuración del servidor](#installing-with-the-server-configuration-tool)
* [Instalación con tareas Ant](#installing-with-ant-tasks)
* [Instalación de los componentes de {{ site.data.keys.mf_server }} manualmente](#installing-the-mobilefirst-server-components-manually)
* [Instalación de una granja de servidores](#installing-a-server-farm)

## Requisitos previos del servidor de aplicaciones
{: #application-server-prerequisites }
En función de su elección del servidor de aplicaciones, seleccione uno de los siguientes temas para averiguar los requisitos previos que debe cumplir antes de instalar los componentes de {{ site.data.keys.mf_server }}.

* [Requisitos previos de Apache Tomcat](#apache-tomcat-prerequisites)
* [Requisitos previos de WebSphere Application Server Liberty](#websphere-application-server-liberty-prerequisites)
* [Requisitos previos de WebSphere Application Server y WebSphere Application Server Network Deployment](#websphere-application-server-and-websphere-application-server-network-deployment-prerequisites)

### Requisitos previos de Apache Tomcat
{: #apache-tomcat-prerequisites }
{{ site.data.keys.mf_server }} tiene algunos requisitos para la configuración de Apache Tomcat que están detallados en los temas siguientes.  
Asegúrese de que cumple los criterios siguientes:

* Utilice una versión soportada de Apache Tomcat. Consulte [Requisitos del sistema](../../../product-overview/requirements).
* Apache Tomcat se debe ejecutar con JRE 7.0 o posterior.
* La configuración de JMX debe estar habilitada para permitir la comunicación entre el servicio de administración y el componente de tiempo de ejecución. La comunicación utiliza RMI como se describe en **Configuración de la conexión de JMX para Apache Tomcat** a continuación.

<div class="panel-group accordion" id="tomcat-prereq" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="jmx-connection">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#tomcat-prereq" href="#collapse-jmx-connection" aria-expanded="true" aria-controls="collapse-jmx-connection"><b>Pulse aquí para obtener instrucciones sobre cómo configurar la conexión de JMX para Apache Tomcat</b></a>
            </h4>
        </div>

        <div id="collapse-jmx-connection" class="panel-collapse collapse" role="tabpanel" aria-labelledby="jmx-connection">
            <div class="panel-body">
                <p>Debe configurar una conexión JMX segura para el servidor de aplicaciones de Apache Tomcat.</p>
                <p>La Herramienta de configuración del servidor y las tareas Ant pueden configurar una conexión JMX segura predeterminada, que incluya la definición de un puerto remoto JMX, y la definición de propiedades de autenticación. Modifican <b>tomcat_install_dir/bin/setenv.bat</b> y <b>tomcat_install_dir/bin/setenv.sh</b> para añadir estas opciones a <b>CATALINA_OPTS</b>:</p>
{% highlight xml %}
-Djava.rmi.server.hostname=localhost
-Dcom.sun.management.jmxremote.port=8686
-Dcom.sun.management.jmxremote.authenticate=false
-Dcom.sun.management.jmxremote.ssl=false
{% endhighlight %}

                <p><b>Nota:</b> 8686 es un valor predeterminado. El valor para este puerto puede cambiarse si el puerto no está disponible en el sistema.</p>

                <ul>
                    <li>El archivo <b>setenv.bat</b> se utiliza si inicia Apache Tomcat con <b>tomcat_install_dir/bin/startup.bat</b>, o <b>tomcat_install_dir/bin/catalina.bat.</b></li>
                    <li>El archivo <b>setenv.sh</b> se utiliza si inicia Apache Tomcat con <b>tomcatInstallDir/bin/startup.sh</b>, o <b>tomcat_install_dir/bin/catalina.sh.</b></li>
                </ul>

                <p>Este archivo podría no utilizarse si inicia Apache Tomcat con otro mandato. Si ha instalado Apache Tomcat Windows Service Installer, el lanzador del servicio no utiliza <b>setenv.bat</b>.</p>

                <blockquote><b>Importante:</b> Esta configuración no es segura de forma predeterminada. Para proteger la configuración, debe completar manualmente los pasos 2 y 3 del procedimiento siguiente.</blockquote>

                <p>Configuración manual de Apache Tomcat:</p>

                <ol>
                    <li>Para una configuración simple, añada las opciones siguientes a <b>CATALINA_OPTS</b>:

{% highlight xml %}
-Djava.rmi.server.hostname=localhost
-Dcom.sun.management.jmxremote.port=8686
-Dcom.sun.management.jmxremote.authenticate=false
-Dcom.sun.management.jmxremote.ssl=false
{% endhighlight %}
                    </li>
                    <li>Para activar la autenticación, consulte la documentación de usuario de Apache Tomcat <a href="https://tomcat.apache.org/tomcat-7.0-doc/config/http.html#SSL_Support">SSL Support - BIO and NIO</a> y <a href="http://tomcat.apache.org/tomcat-7.0-doc/ssl-howto.html">SSL Configuration HOW-TO</a>.</li>
                    <li>For a JMX configuration with SSL enabled, add the following options:
{% highlight xml %}
-Dcom.sun.management.jmxremote=true
-Dcom.sun.management.jmxremote.port=8686
-Dcom.sun.management.jmxremote.ssl=true
-Dcom.sun.management.jmxremote.authenticate=false
-Djava.rmi.server.hostname=localhost  
-Djavax.net.ssl.trustStore=<key store location>
-Djavax.net.ssl.trustStorePassword=<key store password>
-Djavax.net.ssl.trustStoreType=<key store type>
-Djavax.net.ssl.keyStore=<key store location>
-Djavax.net.ssl.keyStorePassword=<key store password>
-Djavax.net.ssl.keyStoreType=<key store type>
{% endhighlight %}

                    <b>Nota:</b> El puerto 8686 se puede modificar.</li>
                    <li>
                        <p>Si la instancia de Tomcat se está ejecutando detrás de un cortafuegos, se debe configurar el JMX Remote Lifecycle Listener. Consulte la documentación de Apache Tomcat para <a href="http://tomcat.apache.org/tomcat-7.0-doc/config/listeners.html#JMX_Remote_Lifecycle_Listener_-_org.apache.catalina.mbeans.JmxRemoteLifecycleListener">JMX Remote Lifecycle Listener</a>.</p><p>También se deben añadir las siguientes propiedades del entorno a la sección Contexto de la aplicación del servicio de administración en el archivo <b>server.xml</b>, como por ejemplo en el ejemplo siguiente:</p>

{% highlight xml %}
<Context docBase="mfpadmin" path="/mfpadmin ">
    <Environment name="mfp.admin.rmi.registryPort" value="registryPort" type="java.lang.String" override="false"/>
    <Environment name="mfp.admin.rmi.serverPort" value="serverPort" type="java.lang.String" override="false"/>
</Context>
{% endhighlight %}

                        En el ejemplo anterior:
                        <ul>
                            <li>registryPort debe tener el mismo valor que el atributo <b>rmiRegistryPortPlatform</b> del JMX Remote Lifecycle Listener.</li>
                            <li>serverPort debe tener el mismo valor que el atributo <b>rmiServerPortPlatform</b> del JMX Remote Lifecycle Listener.</li>
                        </ul>
                    </li>
                    <li>Si ha instalado Apache Tomcat con el Apache Tomcat Windows Service Installer en lugar de añadir las opciones a <b>CATALINA_OPTS</b>, ejecute <b>tomcat_install_dir/bin/Tomcat7w.exe</b>, y añada las opciones del separador <b>Java</b> de la ventana Propiedades.

                    <img alt="Propiedades de Apache Tomcat 7" src="Tomcat_Win_Service_Installer_properties.jpg"/></li>
                </ol>
            </div>
        </div>
    </div>
</div>

### Requisitos previos de WebSphere Application Server Liberty
{: #websphere-application-server-liberty-prerequisites }
{{ site.data.keys.product_full }}tiene algunos requisitos para la configuración del servidor de Liberty que están detallados en los temas siguientes.  

Asegúrese de que cumple los criterios siguientes:

* Utilice una versión soportada de Liberty. Consulte [Requisitos del sistema](../../../product-overview/requirements).
* Liberty se debe ejecutar con JRE 7.0 o posterior. JRE 6.0 no está soportado.
* Algunas versiones de Liberty dan soporte a las características de Java EE 6 y Java EE 7. Por ejemplo, la característica de Liberty jdbc-4.0 forma parte de Java EE 6, mientras que la característica de Liberty jdbc-4.1 forma parte de Java EE 7. {{ site.data.keys.mf_server }} V8.0.0 se puede instalar con las características Java EE 6 o Java EE 7. Sin embargo, si desea ejecutar una versión anterior de {{ site.data.keys.mf_server }} en el mismo servidor de Liberty, debe utilizar las características de Java EE 6. {{ site.data.keys.mf_server }} V7.1.0 y anteriores, no da soporte a las características de Java EE 7.
* JMX debe estar configurado tal como se describe en **Configuración de la conexión JMX para el perfil de Liberty de WebSphere Application Server** a continuación.
* Para una instalación en un entorno de producción, es posible que desee iniciar el servidor de Liberty como un servicio en sistemas Windows, Linux o UNIX, por lo que:
Los componentes de {{ site.data.keys.mf_server }} se inician automáticamente cuando se inicia el sistema.
El proceso que ejecuta el servidor de Liberty no se detiene cuando el usuario, que ha iniciado el proceso, cierra sesión.
* {{ site.data.keys.mf_server }} V8.0.0 no se puede desplegar en un servidor Liberty que contiene los componentes desplegados de {{ site.data.keys.mf_server }} de las versiones anteriores.
* Para una instalación en un entorno colectivo de Liberty, el controlador colectivo de Liberty y los miembros del clúster colectivo de Liberty deben configurarse como se documenta en [Configuración de un colectivo de Liberty](http://www.ibm.com/support/knowledgecenter/SSAW57_8.5.5/com.ibm.websphere.wlp.nd.doc/ae/tagt_wlp_configure_collective.html?view=kc).

<div class="panel-group accordion" id="websphere-prereq" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="websphere-jmx-connection">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#websphere-prereq" href="#collapse-websphere-jmx-connection" aria-expanded="true" aria-controls="collapse-websphere-jmx-connection"><b>Pulse para obtener instrucciones sobre cómo configurar la conexión JMX para el perfil de Liberty de WebSphere Application Server</b></a>
            </h4>
        </div>

        <div id="collapse-websphere-jmx-connection" class="panel-collapse collapse" role="tabpanel" aria-labelledby="websphere-jmx-connection">
            <div class="panel-body">
                <p>{{ site.data.keys.mf_server }} requiere que se configure la conexión JMX segura.</p>

                <ul>
                    <li>La Herramienta de configuración del servidor y las tareas Ant pueden configurar una conexión JMX segura predeterminada, que incluye la generación de un certificado SSL firmado automáticamente con un periodo de validez de 365 días. Esta configuración no está pensada para el uso de producción.</li>
                    <li>Para configurar la conexión JMX segura para el uso de producción, siga las instrucciones tal como se describen en <a href="http://www.ibm.com/support/knowledgecenter/SSD28V_8.5.5/com.ibm.websphere.wlp.core.doc/ae/twlp_admin_restconnector.html?cp=SSD28V_8.5.5&view=embed">Configuración de la conexión JMX segura en el perfil de Liberty</a>.</li>
                    <li>Rest-connector está disponible para WebSphere Application Server, Liberty Core, y otras ediciones de Liberty, pero se puede empaquetar un servidor de Liberty con un subconjunto de las características disponibles. Para verificar que la característica rest-connector esté disponible en la instalación de Liberty, escriba el siguiente mandato:
{% highlight bash %}                    
liberty_install_dir/bin/productInfo featureInfo
{% endhighlight %}
                    <b>Nota:</b> Verifique que la salida de este mandato contenga restConnector-1.0.</li>
                </ul>
            </div>
        </div>
    </div>
</div>

### Requisitos previos de WebSphere Application Server y WebSphere Application Server Network Deployment
{: #websphere-application-server-and-websphere-application-server-network-deployment-prerequisites }
{{ site.data.keys.mf_server }} tiene algunos requisitos para la configuración de WebSphere Application Server y WebSphere Application Server Network Deployment detallados en los temas siguientes.  
Asegúrese de que cumple los criterios siguientes:

* Utilice una versión soportada de WebSphere Application Server. Consulte [Requisitos del sistema](../../../product-overview/requirements).
* El servidor de aplicaciones debe ejecutarse con JRE 7.0. De forma predeterminada, WebSphere Application Server utiliza Java 6.0 SDK. Para conmutar a Java 7.0 SDK, consulte [Conmutación a Java 7.0 SDK en WebSphere Application Server](https://www.ibm.com/support/knowledgecenter/SSWLGF_8.5.5/com.ibm.sr.doc/twsr_java17.html).
* La seguridad administrativa debe estar activa. {{ site.data.keys.mf_console }}, el servicio de administración de {{ site.data.keys.mf_server }} y el servicio de configuración de {{ site.data.keys.mf_server }} están protegidos por roles de seguridad. Para obtener más información, consulte [Habilitación de seguridad](https://www.ibm.com/support/knowledgecenter/SSEQTP_8.5.5/com.ibm.websphere.base.doc/ae/tsec_csec2.html?cp=SSEQTP_8.5.5%2F1-8-2-31-0-2&lang=en).
* La configuración de JMX debe estar habilitada para permitir la comunicación entre el servicio de administración y el componente de tiempo de ejecución. La comunicación utiliza SOAP. Para WebSphere Application Server Network Deployment, se puede utilizar RMI. Para obtener más información, consulte **Configuración de la conexión JMX para WebSphere Application Server y WebSphere Application Server Network Deployment** a continuación.

<div class="panel-group accordion" id="websphere-nd-prereq" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="websphere-nd-jmx-connection">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#websphere-nd-prereq" href="#collapse-websphere-nd-jmx-connection" aria-expanded="true" aria-controls="collapse-websphere-nd-jmx-connection"><b>Pulse aquí para obtener instrucciones sobre cómo configurar la conexión JMX para WebSphere Application Server y WebSphere Application Server Network Deployment</b></a>
            </h4>
        </div>

        <div id="collapse-websphere-nd-jmx-connection" class="panel-collapse collapse" role="tabpanel" aria-labelledby="websphere-nd-jmx-connection">
            <div class="panel-body">
                <p>{{ site.data.keys.mf_server }} requiere que se configure la conexión JMX segura.</p>

                <ul>
                    <li>{{ site.data.keys.mf_server }} requiere acceso al puerto SOAP, o el puerto RMI para realizar operaciones JMX. De forma predeterminada, el puerto SOAP está activo en un WebSphere Application Server. {{ site.data.keys.mf_server }} utiliza el puerto SOAP de forma predeterminada. Si los puertos SOAP y RMI están desactivados, {{ site.data.keys.mf_server }} no se ejecutará.</li>
                    <li>RMI sólo está soportado por WebSphere Application Server Network Deployment. RMI no está soportado por un perfil autónomo, o una granja de servidores de WebSphere Application Server.</li>
                    <li>Debe activar Administrative and Application Security.</li>
                </ul>
            </div>
        </div>
    </div>
</div>

### Requisitos previos del sistema de archivos
{: #file-system-prerequisites }
Para instalar {{ site.data.keys.mf_server }} en un servidor de aplicaciones, las herramientas de instalación de {{ site.data.keys.product_adj }} deben ejecutarlas un usuario que tenga privilegios del sistema de archivos específicos.  
Entre las herramientas de instalación se incluye:

* IBM Installation Manager
* La Herramienta de configuración del servidor
* Las tareas Ant para desplegar {{ site.data.keys.mf_server }}

Para el perfil de WebSphere Application Server Liberty, debe tener el permiso necesario para realizar las acciones siguientes:

* Leer los archivos en el directorio de instalación de Liberty.
* Crear archivos en el directorio de configuración del servidor de Liberty, que es normalmente usr/servers/server-name, para crear copias de seguridad y modificar server.xml y jvm.options.
* Crear archivos y directorios en el directorio de recursos compartidos de Liberty, que es normalmente usr/shared.
* Crear archivos en el directorio de aplicaciones del servidor de Liberty, que es normalmente usr/servers/server-name/apps.

Para el perfil completo de WebSphere Application Server y WebSphere Application Server Network Deployment, debe tener el permiso necesario para realizar las acciones siguientes:

* Leer los archivos del directorio de instalación de WebSphere Application Server.
* Leer el archivo de configuración del perfil completo de WebSphere Application Server seleccionado o del perfil de Deployment Manager.
* Ejecutar el mandato wsadmin.
* Crear archivos en el directorio de configuración de perfiles. Las herramientas de instalación ponen recursos como, por ejemplo, bibliotecas compartidas o controladores JDBC en dicho directorio.

Para Apache Tomcat, debe tener el permiso necesario para realizar las acciones siguientes:

* Leer el directorio de configuración.
* Crear archivos de copia de seguridad y modificar archivos en el directorio de configuración, como por ejemplo server.xml y tomcat-users.xml.
* Crear archivos de copia de seguridad y modificar archivos en el directorio bin, como por ejemplo setenv.bat.
* Crear archivos en el directorio lib.
* Crear archivos en el directorio webapps.

Para todos estos servidores de aplicaciones, el usuario que ejecuta el servidor de aplicaciones debe poder leer los archivos creados por el usuario que ha ejecutado las herramientas de instalación de {{ site.data.keys.product_adj }}.

## Instalación con la Herramienta de configuración del servidor
{: #installing-with-the-server-configuration-tool }
Utilice la Herramienta de configuración del servidor para instalar los componentes de {{ site.data.keys.mf_server }} en su servidor de aplicaciones.

La Herramienta de configuración del servidor puede configurar la base de datos e instalar los componentes en un servidor de aplicaciones. Esta herramienta está pensada para un único usuario. Los archivos de configuración se almacenan en el disco. El directorio donde se almacenan se puede modificar con el menú **Archivo → Preferencias**. Los archivos sólo debe utilizarlos una instancia de la Herramienta de configuración del servidor a la vez. La herramienta no gestiona el acceso simultáneo al mismo archivo. Si tiene varias instancias de la herramienta que acceden al mismo archivo, es posible que se pierdan los datos. Para obtener más información sobre cómo crea y configura la herramienta las bases de datos, consulte [Crear las tablas de base de datos con la Herramienta de configuración del servidor](../databases/#create-the-database-tables-with-the-server-configuration-tool). Si las bases de datos existen, la herramienta puede detectarlas probando la presencia y el contenido de algunas tablas de prueba y no modifica estas tablas de base de datos.

* [Sistemas operativos soportados](#supported-operating-systems)
* [Topologías soportadas](#supported-topologies)
* [Ejecución de la Herramienta de configuración del servidor](#running-the-server-configuration-tool)
* [Aplicación de un fixpack utilizando la Herramienta de configuración del servidor](#applying-a-fix-pack-by-using-the-server-configuration-tool)

### Sistemas operativos soportados
{: #supported-operating-systems }
Puede utilizar la Herramienta de configuración del servidor si se encuentra en los siguientes sistemas operativos:

* Windows x86 o x86-64
* macOS x86-64
* Linux x86 o Linux x86-64

La herramienta no está disponible en otros sistemas operativos. Debe utilizar las tareas Ant para instalar los componentes de {{ site.data.keys.mf_server }} tal como se describe en [Instalación con Tareas Ant](#installing-with-ant-tasks).

### Topologías soportadas
{: #supported-topologies }
La Herramienta de configuración del servidor instala los componentes de {{ site.data.keys.mf_server }} con las siguientes topologías:

* Todos los componentes ({{ site.data.keys.mf_console }}, el servicio de administración de {{ site.data.keys.mf_server }}, el servicio de Live Update de {{ site.data.keys.mf_server }} y el tiempo de ejecución de {{ site.data.keys.product_adj }}) se encuentran en el mismo servidor de aplicaciones. Sin embargo, en WebSphere Application Server Network Deployment, cuando instala en un clúster, puede especificar un clúster distinto para los servicios de administración y de Live Update, y para el tiempo de ejecución. En el colectivo de Liberty, {{ site.data.keys.mf_console }}, el servicio de administración y el servicio de Live Update están instalados en un controlador colectivo y el tiempo de ejecución en un miembro de colectivo.
* Si el servicio de envío por push de {{ site.data.keys.mf_server }} está instalado, también estará instalado en el mismo servidor. Sin embargo, en WebSphere Application Server Network Deployment cuando instala en un clúster, puede especificar un clúster distinto para el servicio de envío por push. En el colectivo de Liberty, el servicio de envío por push está instalado en un miembro de Liberty que puede ser el mismo que donde está instalado el tiempo de ejecución.
* Todos los componentes utilizan el mismo sistema de base de datos y usuario. Para DB2, todos los componentes también utilizan el mismo esquema.
* La Herramienta de configuración del servidor instala los componentes para un único servidor, excepto para el colectivo de Liberty y WebSphere Application Server Network Deployment para el despliegue simétrico. Para una instalación en varios servidores, debe configurarse una granja una vez que se ejecute la herramienta. La configuración de granja de servidores no es necesaria en WebSphere Application Server Network Deployment.

Para otras topologías o valores de base de datos, puede instalar los componentes con Tareas Ant o manualmente en su lugar.

### Ejecución de la Herramienta de configuración del servidor
{: #running-the-server-configuration-tool }
Antes de ejecutar la Herramienta de configuración del servidor, asegúrese de que se cumplen los requisitos siguientes:

* Las bases de datos y las tablas para los componentes están preparadas y listas para utilizarse. Consulte [Configuración de bases de datos](../databases).
* La topología del servidor para instalar los componentes está decidida. Consulte [Flujos de red y topologías](../topologies).
* El servidor de aplicaciones está configurado. Consulte [Requisitos previos del servidor de aplicaciones](#application-server-prerequisites).
* El usuario que ejecuta la herramienta tiene los privilegios del sistema de archivos específicos. Consulte [Requisitos previos del sistema de archivos](#file-system-prerequisites).

<div class="panel-group accordion" id="running-the-configuration-tool" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="configuration-tool">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#running-the-configuration-tool" href="#collapse-configuration-tool" aria-expanded="true" aria-controls="collapse-configuration-tool"><b>Pulse aquí para obtener instrucciones sobre la ejecución de la Herramienta de configuración</b></a>
            </h4>
        </div>

        <div id="collapse-configuration-tool" class="panel-collapse collapse" role="tabpanel" aria-labelledby="configuration-tool">
            <div class="panel-body">
                <ol>
                    <li>Inicie la Herramienta de configuración del servidor.
                        <ul>
                            <li>En Linux, desde los atajos de la aplicación <b>Aplicaciones → IBM MobileFirst Platform Server → Herramienta de configuración del servidor</b>.</li>
                            <li>En Windows, pulse <b>Inicio → Programas → IBM MobileFirst Platform Server → Herramienta de configuración del servidor</b>.</li>
                            <li>En macOS, abra una consola de shell. Vaya a <b>mfp_server_install_dir/shortcuts</b> y escriba <b>./configuration-tool.sh</b>.</li>
                            <li>El directorio <b>mfp_server_install_dir</b> es donde ha instalado {{ site.data.keys.mf_server }}.</li>
                        </ul>
                    </li>
                    <li>Seleccione <b>Archivo → Nueva configuración</b> para crear una Configuración de {{ site.data.keys.mf_server }}.
                        <ul>
                            <li>En el panel <b>Detalles de configuración</b>, escriba la raíz de contexto del servicio de administración y del componente de tiempo de ejecución. Es posible que desee especificar un ID de entorno. Un ID de entorno se utiliza en casos de uso avanzados, por ejemplo cuando <a href="../topologies/#multiple-instances-of-mobilefirst-server-on-the-same-server-or-websphere-application-server-cell">varias instalaciones de {{ site.data.keys.mf_server }} se realizan en el mismo servidor de aplicaciones o la misma célula de WebSphere  Application Server</a>.</li>
                            <li>En el panel <b>Valores de consola</b>, seleccione si desea instalar {{ site.data.keys.mf_console }} o no. Si la consola no está instalada, debe utilizar las herramientas de línea de mandatos (<b>mfpdev</b> o <b>mfpadm</b>) o la API REST para interactuar con el servicio de administración de {{ site.data.keys.mf_server }}.</li>
                            <li>En el panel <b>Selección de base de datos</b>, seleccione el sistema de gestión de bases de datos que tiene pensado utilizar. Todos los componentes utilizan el mismo tipo de base de datos y la misma instancia de base de datos. Para obtener más información sobre los paneles de base de datos, consulte <a href="../databases/#create-the-database-tables-with-the-server-configuration-tool">Crear las tablas de base de datos con la Herramienta de configuración del servidor</a>.</li>
                            <li>En el panel <b>Selección del servidor de aplicaciones</b>, seleccione el tipo de servidor de aplicaciones donde desea desplegar {{ site.data.keys.mf_server }}.</li>
                        </ul>
                    </li>
                    <li>En el panel <b>Valores del servidor de aplicaciones</b>, seleccione el servidor de aplicaciones y realice los pasos siguientes:
                        <ul>
                            <li>Para una instalación en WebSphere Application Server Liberty:
                                <ul>
                                    <li>Escriba el directorio de instalación de Liberty y el nombre del servidor donde desea instalar {{ site.data.keys.mf_server }}.</li>
                                    <li>Puede crear un usuario predeterminado para iniciar sesión en la consola. Este usuario se crea en el registro de Liberty Basic. Para una instalación de producción, es posible que desee borrar la opción <b>Crear un usuario predeterminado</b> y configurar el acceso de usuario después de la instalación. Para obtener más información, consulte <a href="../server-configuration/#configuring-user-authentication-for-mobilefirst-server-administration">Configuración de autenticación de usuario para la administración de {{ site.data.keys.mf_server }}</a>.</li>
                                    <li>Seleccione el tipo de despliegue: <b>Despliegue autónomo</b> (valor predeterminado), <b>Despliegue de granja de servidores</b>, o <b>Despliegue de colectivo de Liberty</b>.</li>
                                </ul>

                                Si está seleccionada la opción de despliegue colectivo de Liberty, realice los pasos siguientes:
                                <ul>
                                    <li>Especifique el servidor colectivo de Liberty:
                                        <ul>
                                            <li>Donde está instalado el servicio de administración, {{ site.data.keys.mf_console }} y el servicio de Live Update. El servidor debe ser un controlador colectivo de Liberty.</li>
                                            <li>Donde está instalado el tiempo de ejecución. El servidor debe ser un miembro de colectivo de Liberty.</li>
                                            <li>Donde está instalado el servicio de envío por push. El servidor debe ser un miembro de colectivo de Liberty.</li>
                                        </ul>
                                    </li>
                                    <li>Escriba el ID de servidor del miembro. Este identificador debe ser distinto para cada miembro del colectivo.</li>
                                    <li>Escriba el nombre de clúster de los miembros de colectivo.</li>
                                    <li>Escriba el nombre de host de controlador y el número de puerto de HTTPS. Los valores deben ser los mismos que los definidos en el elemento <code>variable</code> dentro del archivo <b>server.xml</b> del controlador colectivo de Liberty.</li>
                                    <li>Escriba el nombre de usuario y la contraseña del administrador del controlador.</li>
                                </ul>
                            </li>
                            <li>Para una instalación en WebSphere Application Server o WebSphere Application Server Network Deployment:
                                <ul>
                                    <li>Escriba el directorio de instalación de WebSphere Application Server.</li>
                                    <li>Seleccione el perfil de WebSphere Application Server donde desea instalar {{ site.data.keys.mf_server }}. Si instala en WebSphere Application Server Network Deployment, seleccione el perfil del gestor de despliegue. En el perfil de gestor de despliegue, puede seleccionar un ámbito (<b>Servidor</b> o <b>Clúster</b>). Si selecciona <b>Clúster</b>, debe especificar el clúster:
                                        <ul>
                                            <li>Donde está instalado el tiempo de ejecución.</li>
                                            <li>Donde está instalado el servicio de administración, {{ site.data.keys.mf_console }} y el servicio de Live Update.</li>
                                            <li>Donde está instalado el servicio de envío por push.</li>
                                        </ul>
                                    </li>
                                    <li>Escriba un ID de inicio de sesión y una contraseña del administrador. El usuario administrador debe tener un rol de administrador.</li>
                                    <li>Si selecciona la opción <b>Declarar al administrador de WebSphere como usuario administrador en {{ site.data.keys.mf_console }}</b>, el usuario utilizado para instalar {{ site.data.keys.mf_server }} se correlaciona con el rol de seguridad de administración de la consola y puede iniciar sesión en la consola con privilegios de administrador. Este usuario también se correlaciona con el rol de seguridad del servicio de Live Update. El nombre de usuario y la contraseña se establecen como propiedades JNDI (<b>mfp.config.service.user</b> y <b>mfp.config.service.password</b>) del servicio de administración.</li>
                                    <li>Si no selecciona la opción <b>Declarar al administrador de WebSphere como usuario administrador en {{ site.data.keys.mf_console }}</b>, antes de utilizar {{ site.data.keys.mf_server }}, debe realizar las tareas siguientes:
                                        <ul>
                                            <li>Habilitar la comunicación entre el servicio de administración y el servicio de Live Update mediante:
                                                <ul>
                                                    <li>Correlación de un usuario con el rol de seguridad <b>configadmin</b> del servicio de Live Update.</li>
                                                    <li>Adición del ID y de la contraseña de inicio de sesión de este usuario en las propiedades JNDI (<b>mfp.config.service.user</b> and <b>mfp.config.service.password</b>) del servicio de administración.</li>
                                                    <li>Correlacione uno o varios usuarios en los roles de seguridad del servicio de administración y de {{ site.data.keys.mf_console }}. Consulte <a href="../server-configuration/#configuring-user-authentication-for-mobilefirst-server-administration">Configuración de autenticación de usuario para la administración de {{ site.data.keys.mf_server }}</a>.</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                </ul>
                            </li>
                            <li>Para una instalación en Apache Tomcat:
                                <ul>
                                    <li>Escriba el directorio de instalación de Apache Tomcat.</li>
                                    <li>Escriba el puerto utilizado para la comunicación de JMX con RMI. De forma predeterminada, el valor es 8686. La Herramienta de configuración del servidor modifica el archivo <b>tomcat_install_dir/bin/setenv.bat</b> o <b>tomcat_install_dir/bin/setenv.sh</b> para abrir este puerto. Si desea abrir el puerto manualmente, o tiene ya algún código que abra el puerto en <b>setenv.bat</b> o <b>setenv.sh</b>, no utilice la herramienta. Instale con tareas Ant en su lugar. Una opción para abrir el puerto RMI manualmente se proporciona para una instalación con tareas Ant.</li>
                                    <li>Cree un usuario predeterminado para iniciar sesión en la consola. Este usuario también se crea en el archivo de configuración <b>tomcat-users.xml</b>. Para una instalación de producción, puede que desee borrar la opción Crear un usuario predeterminado y configurar el acceso de usuario tras la instalación. Para obtener más información, consulte <a href="../server-configuration/#configuring-user-authentication-for-mobilefirst-server-administration">Configuración de autenticación de usuario para la administración de {{ site.data.keys.mf_server }}</a>.</li>
                                </ul>
                            </li>
                        </ul>
                    </li>
                    <li>En el panel <b>Valores del servicio de envío por push</b>, seleccione la opción <b>Instalar el servicio de envío por push</b> si desea que el servicio de envío por push se instale en el servidor de aplicaciones. La raíz de contexto es <b>imfpush</b>. Para habilitar la comunicación entre el servicio de envío por push y el servicio de administración, debe definir los parámetros siguientes:
                        <ul>
                            <li>Escriba el URL del servicio de envío por push y el URL del tiempo de ejecución. Este URL se puede calcular automáticamente si instala en Liberty, Apache Tomcat, o en WebSphere Application Server autónomo. Utiliza el URL del componente (el tiempo de ejecución o el servicio de envío por push) en el servidor local. Si instala en WebSphere Application Server Network Deployment o las comunicaciones pasan por un proxy web o un equilibrador de carga, debe escribir el URL manualmente.</li>
                            <li>Escriba los ID de clientes confidenciales y el secreto para la comunicación de OAuth entre los servicios. De lo contrario, la herramienta generará valores predeterminados y contraseñas aleatorias.</li>
                        </ul>
                    </li>
                    <li>En el panel <b>Valores de Analytics</b>, seleccione <b>Habilitar la conexión con el servidor de Analytics</b> si {{ site.data.keys.mf_analytics }} está instalado. Escriba los siguientes valores de conexión:
                        <ul>
                            <li>El URL de la consola de Analytics.</li>
                            <li>El URL del servidor de Analytics (el servicio de datos de Analytics).</li>
                            <li>El ID de inicio de sesión y la contraseña del usuario permitidos para publicar datos en el servidor de Analytics.</li>
                        </ul>

                        La herramienta configura el tiempo de ejecución y el servicio de envío por push para enviar datos al servidor de Analytics.
                    </li>
                    <li>Pulse <b>Desplegar</b> para continuar con la instalación.</li>
                </ol>
            </div>
        </div>
    </div>
</div>

Una vez que la instalación se haya completado correctamente, reinicie el servidor de aplicaciones en el caso de Apache Tomcat o del perfil de Liberty.

Si Apache Tomcat se ha iniciado como un servicio, es posible que no se pueda leer el archivo setenv.bat o setenv.sh que contiene la sentencia para abrir RMI. Como resultado, es posible que {{ site.data.keys.mf_server }} no pueda funcionar correctamente. Para establecer las variables necesarias, consulte [Configuración de la conexión de JMX para Apache Tomcat](#apache-tomcat-prerequisites).

En WebSphere Application Server Network Deployment, las aplicaciones están instaladas pero no se inician. Debe iniciarlas manualmente. Puede hacerlo desde la consola de administración de WebSphere Application Server.

Conserve el archivo de configuración en la Herramienta de configuración del servidor. Puede reutilizarlo para instalar los arreglos temporales. El menú para aplicar un arreglo temporal es **Configuraciones > Sustituir los archivos WAR desplegados**.

### Aplicación de un fixpack utilizando la Herramienta de configuración del servidor
{: #applying-a-fix-pack-by-using-the-server-configuration-tool }
Si {{ site.data.keys.mf_server }} se instala con la herramienta de configuración y se conserva el archivo de configuración, puede aplicar un fixpack o un arreglo temporal reutilizando el archivo de configuración.

1. Inicie la Herramienta de configuración del servidor.
    * En Linux, desde los atajos de aplicación **Aplicaciones → IBM MobileFirst Platform Server → Herramienta de configuración del servidor**.
    * En Windows, pulse **Inicio → Programas → IBM MobileFirst Platform Server → Herramienta de configuración del servidor**.
    * En macOS, abra una consola de shell. Vaya a **mfp\_server\_install_dir/shortcuts** y escriba **./configuration-tool.sh**.
    * El directorio **mfp\_server\_install\_dir** es donde ha instalado {{ site.data.keys.mf_server }}.

2. Pulse **Configuraciones → Sustituir los archivos WAR desplegados** y seleccione una configuración existente para aplicar el fixpack o un arreglo temporal.

## Instalación con tareas Ant
{: #installing-with-ant-tasks }
Utilice las tareas Ant para instalar los componentes de {{ site.data.keys.mf_server }} en el servidor de aplicaciones.

Puede encontrar los archivos de configuración de ejemplo para instalar {{ site.data.keys.mf_server }} en el directorio **mfp\_install\_dir/MobileFirstServer/configuration-samples**.

También puede crear una configuración con la Herramienta de configuración del servidor y exportar los archivos Ant utilizando **Archivo → Exportar configuración como archivos Ant...**. Los archivos Ant de ejemplo tienen las mismas limitaciones que la Herramienta de configuración del servidor:

* Todos los componentes ({{ site.data.keys.mf_console }}, servicio de administración de {{ site.data.keys.mf_server }}, servicio de Live Update de {{ site.data.keys.mf_server }}, los artefactos de {{ site.data.keys.mf_server }} y el tiempo de ejecución de {{ site.data.keys.product_adj }}) se encuentran en el mismo servidor de aplicaciones. Sin embargo, en WebSphere Application Server Network Deployment, cuando instala en un clúster, puede especificar un clúster distinto para los servicios de administración y de Live Update, y para el tiempo de ejecución.
* Si el servicio de envío por push de {{ site.data.keys.mf_server }} está instalado, también estará instalado en el mismo servidor. Sin embargo, en WebSphere Application Server Network Deployment cuando instala en un clúster, puede especificar un clúster distinto para el servicio de envío por push.
* Todos los componentes utilizan el mismo sistema de base de datos y usuario. Para DB2, todos los componentes también utilizan el mismo esquema.
* La Herramienta de configuración del servidor instala los componentes para un único servidor. Para una instalación en varios servidores, debe configurarse una granja una vez que se ejecute la herramienta. La configuración de granja de servidores no está soportada en WebSphere Application Server Network Deployment.

Puede configurar los servicios de {{ site.data.keys.mf_server }} para que se ejecuten en la granja de servidores con tareas Ant. Para incluir el servidor en una granja, debe especificar algunos atributos específicos que configuren su servidor de aplicaciones en consonancia. Para obtener más información sobre cómo configurar una granja de servidores con las tareas Ant, consulte [Instalación de una granja de servidores con tareas Ant](#installing-a-server-farm-with-ant-tasks).

Para otras topologías soportadas en [Flujos de red y topologías](../topologies), puede modificar los archivos Ant de ejemplo.

Las referencias a las tareas Ant son las siguientes:

* [Tareas Ant para la instalación de {{ site.data.keys.mf_console }}, artefactos de {{ site.data.keys.mf_server }}, administración de {{ site.data.keys.mf_server }} y servicios de Live Update](../installation-reference/#ant-tasks-for-installation-of-mobilefirst-operations-console-mobilefirst-server-artifacts-mobilefirst-server-administration-and-live-update-services)
* [Tareas Ant para la instalación del servicio de envío por push de {{ site.data.keys.mf_server }}](../installation-reference/#ant-tasks-for-installation-of-mobilefirst-server-push-service)
* [Tareas Ant para la instalación de entornos de ejecución de {{ site.data.keys.product_adj }}](../installation-reference/#ant-tasks-for-installation-of-mobilefirst-runtime-environments)

Para obtener una visión general de la instalación con el archivo y las tareas de configuración de ejemplo, consulte [Instalación de {{ site.data.keys.mf_server }} en modalidad de línea de mandatos](../tutorials/command-line).

Puede ejecutar un archivo Ant con la distribución de Ant que forma parte de la instalación del producto. Por ejemplo, si tiene el clúster WebSphere Application Server Network Deployment y su base de datos es IBM DB2, puede utilizar el archivo Ant **mfp\_install\_dir/MobileFirstServer/configuration-samples/configure-wasnd-cluster-db2.xml**. Después de editar el archivo y especificar todas las propiedades necesarias, puede ejecutar los mandatos siguientes desde el directorio **mfp\_install\_dir/MobileFirstServer/configuration-samples**:

* **mfp\_install\_dir/shortcuts/ant -f configure-wasnd-cluster-db2.xml help** - Este mandato muestra la lista de todos los destinos posibles del archivo Ant, para instalar, desinstalar o actualizar algunos componentes.
* **mfp\_install\_dir/shortcuts/ant -f configure-wasnd-cluster-db2.xml install** - Este mandato instala {{ site.data.keys.mf_server }} en el clúster de WebSphere Application Server Network Deployment, con DB2 como origen de datos utilizando los parámetros que ha especificado en las propiedades del archivo Ant.

<br/>
Después de la instalación, realice una copia del archivo Ant para que pueda reutilizarlo para aplicar un fixpack.

### Aplicación de un fixpack utilizando los archivos Ant
{: #applying-a-fix-pack-by-using-the-ant-files }

#### Actualización con el archivo Ant de ejemplo
{: #updating-with-the-sample-ant-file }
Si utiliza los archivos Ant de ejemplo que se proporcionan en el directorio **mfp\_install\_dir/MobileFirstServer/configuration-samples** para instalar {{ site.data.keys.mf_server }}, puede reutilizar una copia de este archivo Ant para aplicar un fixpack. Para los valores de contraseña, puede especificar 12 estrellas (\*) en lugar del valor real, para que se le solicite interactivamente cuando se ejecute el archivo Ant.

1. Verifique el valor de la propiedad **mfp.server.install.dir** en el archivo Ant. Debe apuntar al directorio que contiene el producto con el fixpack aplicado. Este valor se utiliza para tomar los archivos WAR de {{ site.data.keys.mf_server }} actualizados.
2. Ejecute el mandato: `mfp_install_dir/shortcuts/ant -f your_ant_file update`

#### Actualización con su propio archivo Ant
{: #updating-with-own-ant-file }
Si utiliza su propio archivo Ant, asegúrese de que para cada tarea de instalación (**installmobilefirstadmin**, **installmobilefirstruntime**, e **installmobilefirstpush**), tenga una tarea de actualización correspondiente en el archivo Ant con los mismos parámetros. Las tareas de actualización correspondientes son **updatemobilefirstadmin**, **updatemobilefirstruntime** y **updatemobilefirstpush**.

1. Verifique la vía de acceso de clases del elemento **taskdef** para el archivo **mfp-ant-deployer.jar**. Debe apuntar al archivo **mfp-ant-deployer.jar** en una instalación de {{ site.data.keys.mf_server }} a la que se aplica el fixpack. De forma predeterminada, los archivos WAR de {{ site.data.keys.mf_server }} actualizados se toman de la ubicación de **mfp-ant-deployer.jar**.
2. Ejecute las tareas de actualización (**updatemobilefirstadmin**, **updatemobilefirstruntime**, y **updatemobilefirstpush**) del archivo Ant.

### Modificaciones de archivos Ant de ejemplo
{: #sample-ant-files-modifications }
Puede modificar los archivos Ant de ejemplo proporcionados en el directorio **mfp\_install\_dir/MobileFirstServer/configuration-samples** para adaptarlos a sus requisitos de instalación.  
En las secciones siguientes se proporcionan los detalles sobre cómo puede modificar los archivos Ant de ejemplo para adaptar la instalación a sus necesidades:

1. [Especificar propiedades JNDI adicionales](#specify-extra-jndi-properties)
2. [Especificar usuarios existentes](#specify-existing-users)
3. [Especificar el nivel de Liberty Java EE](#specify-liberty-java-ee-level)
4. [Especificar propiedades JDBC del origen de datos](#specify-data-source-jdbc-properties)
5. [Ejecutar los archivos Ant en un sistema donde {{ site.data.keys.mf_server }} no esté instalado](#run-the-ant-files-on-a-computer-where-mobilefirst-server-is-not-installed)
6. [Especificar destinos de WebSphere Application Server Network Deployment](#specify-websphere-application-server-network-deployment-targets)
7. [Configuración manual del puerto RMI en Apache Tomcat](#manual-configuration-of-the-rmi-port-on-apache-tomcat)

#### Especificar propiedades JNDI adicionales
{: #specify-extra-jndi-properties }
Las tareas Ant **installmobilefirstadmin**, **installmobilefirstruntime** e **installmobilefirstpush** declaran los valores para las propiedades JNDI que son necesarios para que funcionen los componentes. Estas propiedades JNDI se utilizan para definir la comunicación JMX, y también los enlaces a otros componentes (como el servicio de Live Update, el servicio de envío por push, el servicio de análisis o el servidor de autorizaciones). Sin embargo, también puede definir valores para otras propiedades JNDI. Utilice el elemento `<property>` que existe para estas tres tareas. Para obtener una lista de propiedades JNDI, consulte:

* [Lista de propiedades JNDI para el servicio de administración de {{ site.data.keys.mf_server }}](../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service)
* [Lista de propiedades JNDI para el servicio de envío por push de {{ site.data.keys.mf_server }}](../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service)
* [Lista de propiedades JNDI para el tiempo de ejecución de {{ site.data.keys.product_adj }}](../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime)

Por ejemplo:

```xml
<installmobilefirstadmin ..>
    <property name="mfp.admin.actions.prepareTimeout" value="3000000"/>
</installmobilefirstadmin>
```

#### Especificar usuarios existentes
{: #specify-existing-users }
De forma predeterminada, la tarea Ant **installmobilefirstadmin** crea usuarios:

* En WebSphere Application Server Liberty para definir un administrador de Liberty para la comunicación de JMX.
* En cualquier servidor de aplicaciones, para definir un usuario utilizado para la comunicación con el servicio de Live Update.

Para utilizar un usuario existente en lugar de crear un usuario nuevo, puede realizar las siguientes operaciones:

1. En el elemento `<jmx>`, especifique un usuario y una contraseña, y establezca el valor del atributo **createLibertyAdmin** en false. Por ejemplo:

   ```xml
   <installmobilefirstadmin ...>
       <jmx libertyAdminUser="myUser" libertyAdminPassword="password" createLibertyAdmin="false" />
       ...
   ```

2. En el elemento `<configuration>`, especifique un usuario y una contraseña y establezca el valor del atributo **createConfigAdminUser** en false. Por ejemplo:

   ```xml
    <installmobilefirstadmin ...>
        <configuration configAdminUser="myUser" configAdminPassword="password" createConfigAdminUser="false" />
        ...
   ```

Además, el usuario que se crea mediante los archivos Ant de ejemplo se correlaciona con los roles de seguridad del servicio de administración y de la consola. Con este valor, puede utilizar este usuario para iniciar sesión en {{ site.data.keys.mf_server }} después de la instalación. Para cambiar dicho comportamiento, elimine el elemento `<user>` de los archivos Ant de ejemplo. Como alternativa, puede eliminar el atributo **password** del elemento `<user>`, y el usuario no se creará en el registro local del servidor de aplicaciones.

#### Especificar el nivel de Liberty Java EE
{: #specify-liberty-java-ee-level }
Algunas distribuciones de WebSphere Application Server Liberty dan soporte a características de Java EE 6 o de Java EE 7. De forma predeterminada, las tareas Ant detectan automáticamente las características que hay que instalar. Por ejemplo, la característica de Liberty **jdbc-4.0** está instalada para Java EE 6 y la característica **jdbc-4.1** está instalada en el caso de Java EE 7. Si la instalación de Liberty da soporte a las dos características de Java EE 6 y Java EE 7, es posible que desee forzar un determinado nivel de características. Un ejemplo podría ser que tenga previsto ejecutar {{ site.data.keys.mf_server }} V8.0.0 y V7.1.0 en el mismo servidor de Liberty. {{ site.data.keys.mf_server }} V7.1.0 o anterior sólo da soporte a característica de Java EE 6.

Para forzar un determinado nivel de características de Java EE 6, utilice el atributo jeeversion del elemento `<websphereapplicationserver>`. Por ejemplo:

```xml
<installmobilefirstadmin execute="${mfp.process.admin}" contextroot="${mfp.admin.contextroot}">
    [...]
    <applicationserver>
      <websphereapplicationserver installdir="${appserver.was.installdir}"
        profile="Liberty" jeeversion="6">
```

#### Especificar propiedades JDBC del origen de datos
{: #specify-data-source-jdbc-properties }
Puede especificar las propiedades para la conexión de JDBC. Utilice el elemento `<property>` de un elemento `<database>`. El elemento está disponible en las tareas Ant **configureDatabase**, **installmobilefirstadmin**, **installmobilefirstruntime** e **installmobilefirstpush**. Por ejemplo:

```xml
<configuredatabase kind="MobileFirstAdmin">
    <db2 database="${database.db2.mfpadmin.dbname}"
        server="${database.db2.host}"
        instance="${database.db2.instance}"
        user="${database.db2.mfpadmin.username}"
        port= "${database.db2.port}"
        schema = "${database.db2.mfpadmin.schema}"
        password="${database.db2.mfpadmin.password}">

       <property name="commandTimeout" value="10"/>
    </db2>
```

#### Ejecutar los archivos Ant en un sistema donde {{ site.data.keys.mf_server }} no está instalado
{: #run-the-ant-files-on-a-computer-where-mobilefirst-server-is-not-installed }
Para ejecutar las tareas Ant en un sistema donde {{ site.data.keys.mf_server }} no está instalado, necesita los elementos siguientes:

* Una instalación Ant
* Una copia del archivo **mfp-ant-deployer.jar** en el sistema remoto. Esta biblioteca contiene la definición de las tareas Ant.
* Para especificar los recursos que se van a instalar. De forma predeterminada, los archivos WAR se toman cerca de **mfp-ant-deployer.jar**, pero puede especificar la ubicación de estos archivos WAR. Por ejemplo:

```xml
<installmobilefirstadmin execute="true" contextroot="/mfpadmin" serviceWAR="/usr/mfp/mfp-admin-service.war">
  <console install="true" warFile="/usr/mfp/mfp-admin-ui.war"/>
```

Para obtener más información, consulte las tareas Ant para instalar cada componente de {{ site.data.keys.mf_server }} en [Referencia de instalación](../installation-reference).

#### Especificar los destinos de WebSphere Application Server Network Deployment
{: #specify-websphere-application-server-network-deployment-targets }
Para instalar en WebSphere Application Server Network Deployment, el perfil especificado de WebSphere Application Server debe ser el gestor de despliegue. Puede desplegar en las siguientes configuraciones:

* Un clúster
* Un único servidor
* Una célula (todos los servidores de una célula)
* Un nodo (todos los servidores de un nodo)

Los archivos de ejemplo como **configure-wasnd-cluster-dbms-name.xml**, **configure-wasnd-server-dbms-name.xml** y **configure-wasnd-node-dbms-name.xml** contienen la declaración para desplegar en cada tipo de destino. Para obtener más información, consulte las tareas Ant para instalar cada componente de {{ site.data.keys.mf_server }} en la [Referencia de instalación](../installation-reference).

> Nota: A partir de V8.0.0, no se proporcionará el archivo de configuración de ejemplo para la célula de WebSphere Application Server Network Deployment.


#### Configuración manual del puerto RMI en Apache Tomcat
{: #manual-configuration-of-the-rmi-port-on-apache-tomcat }
De forma predeterminada, las tareas Ant modifican el archivo **setenv.bat** o el archivo **setenv.sh** para abrir el puerto RMI. Si prefiere abrir el puerto RMI manualmente, añada el atributo **tomcatSetEnvConfig** con el valor false en el elemento `<jmx>` de las tareas **installmobilefirstadmin**, **updatemobilefirstadmin** y **uninstallmobilefirstadmin**.

## Instalación de los componentes de {{ site.data.keys.mf_server }} manualmente
{: #installing-the-mobilefirst-server-components-manually }
También puede instalar los componentes de {{ site.data.keys.mf_server }} en su servidor de aplicaciones manualmente.  
Los temas siguientes le proporcionan la información completa para guiarle por el proceso de instalación de los componentes en las aplicaciones soportadas en producción.

* [Instalación manual en WebSphere Application Server Liberty](#manual-installation-on-websphere-application-server-liberty)
* [Instalación manual en el colectivo de WebSphere Application Server Liberty](#manual-installation-on-websphere-application-server-liberty-collective)
* [Instalación manual en Apache Tomcat](#manual-installation-on-apache-tomcat)
* [Instalación manual en WebSphere Application Server y WebSphere Application Server Network Deployment](#manual-installation-on-websphere-application-server-and-websphere-application-server-network-deployment)

### Instalación manual en WebSphere Application Server Liberty
{: #manual-installation-on-websphere-application-server-liberty }
Asegúrese de que también haya cumplido los requisitos tal como se describe en [Requisitos previos de WebSphere Application Server Liberty](#websphere-application-server-liberty-prerequisites).

* [Restricciones de topología](#topology-constraints)
* [Valores del servidor de aplicaciones](#application-server-settings)
* [Características de Liberty requeridas por las aplicaciones de {{ site.data.keys.mf_server }}](#liberty-features-required-by-the-mobilefirst-server-applications)
* [Entradas JNDI globales](#global-jndi-entries)
* [Cargador de clases](#class-loader)
* [Característica de usuario decodificador de contraseñas](#password-decoder-user-feature)
* [Detalles de la configuración](#configuration-details-liberty)

#### Restricciones de topología
{: #topology-constraints }
El servicio de administración de {{ site.data.keys.mf_server }}, el servicio de Live Update de {{ site.data.keys.mf_server }} y el tiempo de ejecución de MobileFirst deben estar instalados en el mismo servidor de aplicaciones. La raíz de contexto del servicio de Live Update debe estar definida como **the-adminContextRootconfig**. La raíz de contexto del servicio de envío por push debe ser **imfpush**. Para obtener más información acerca de las restricciones, consulte [Restricciones en los componentes de {{ site.data.keys.mf_server }} y {{ site.data.keys.mf_analytics }}](../topologies/#constraints-on-the-mobilefirst-server-components-and-mobilefirst-analytics).

#### Valores del servidor de aplicaciones
{: #application-server-settings }
Debe configurar el elemento **webContainer** para cargar los servlets de inmediato. Este valor es necesario para la inicialización mediante JMX. Por ejemplo: `<webContainer deferServletLoad="false"/>`.

Opcionalmente, para evitar problemas de tiempo de espera excedido que rompan la secuencia de arranque del tiempo de ejecución y el servicio de administración en algunas versiones de Liberty, cambie el elemento **executor** predeterminado. Establezca valores grandes en los atributos **coreThreads** y **maxThreads**. Por ejemplo:

```xml
<executor id="default" name="LargeThreadPool"
  coreThreads="200" maxThreads="400" keepAlive="60s"
  stealPolicy="STRICT" rejectedWorkPolicy="CALLER_RUNS"/>
```

También puede configurar el elemento **tcpOptions** y establecer el atributo **soReuseAddr** en `true`: `<tcpOptions soReuseAddr="true"/>`.

#### Características de Liberty requeridas por las aplicaciones de {{ site.data.keys.mf_server }}
{: #liberty-features-required-by-the-mobilefirst-server-applications }
Puede utilizar las siguientes características para Java EE 6 o Java EE 7.

**Servicio de administración de {{ site.data.keys.mf_server }}**

* **jdbc-4.0** (jdbc-4.1 for Java EE 7)
* **appSecurity-2.0**
* **restConnector-1.0**
* **usr:MFPDecoderFeature-1.0**

**Servicio de envío por push de {{ site.data.keys.mf_server }}**  

* **jdbc-4.0** (jdbc-4.1 for Java EE 7)
* **servlet-3.0** (servlet-3.1 for Java EE 7)
* **ssl-1.0**
* **usr:MFPDecoderFeature-1.0**

**Tiempo de ejecución de {{ site.data.keys.product_adj }}**  

* **jdbc-4.0** (jdbc-4.1 for Java EE 7)
* **servlet-3.0** (servlet-3.1 for Java EE 7)
* **ssl-1.0**
* **usr:MFPDecoderFeature-1.0**

#### Entradas JNDI globales
{: #global-jndi-entries }
Las siguientes entradas JNDI globales son necesarias para configurar la comunicación JMX entre el tiempo de ejecución y el servicio de administración:

* **mfp.admin.jmx.host**
* **mfp.admin.jmx.port**
* **mfp.admin.jmx.user**
* **mfp.admin.jmx.pwd**
* **mfp.topology.platform**
* **mfp.topology.clustermode**

Estas entradas JNDI globales se establecen con esta sintaxis y no tienen como prefijos una raíz de contexto. Por ejemplo: `<jndiEntry jndiName="mfp.admin.jmx.port" value="9443"/>`.

> **Nota:** Para proteger contra una conversión automática de los valores JNDI, para que 075 no se convierta a 61 o que 31,500 no se convierta en 31,5, utilice esta sintaxis '"075"' al definir el valor.

Para obtener más información sobre las propiedades JNDI para el servicio de administración, consulte [Lista de propiedades JNDI para el servicio de administración de {{ site.data.keys.mf_server }}](../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service).  

Para la configuración en una granja de servidores, consulte también los temas siguientes:

* [Topología de la granja de servidores](../topologies/#server-farm-topology)
* [Flujos de red y topologías](../topologies)
* [Instalación de una granja de servidores](#installing-a-server-farm)

#### Cargador de clases
{: #class-loader }
Para todas las aplicaciones, el cargador de clases debe tener la delegación del último padre. Por ejemplo:

```xml
<application id="mfpadmin" name="mfpadmin" location="mfp-admin-service.war" type="war">
  [...]
  <classloader delegation="parentLast">
  </classloader>
</application>
```

#### Característica de usuario decodificador de contraseñas
{: #password-decoder-user-feature }
Copie la característica de usuario decodificador de contraseñas en el perfil de Liberty. Por ejemplo:

* En sistemas UNIX y Linux:

  ```bash
  mkdir -p LIBERTY_HOME/wlp/usr/extension/lib/features
  cp product_install_dir/features/com.ibm.websphere.crypto_1.0.0.jar LIBERTY_HOME/wlp/usr/extension/lib/
  cp product_install_dir/features/MFPDecoderFeature-1.0.mf LIBERTY_HOME/wlp/usr/extension/lib/features/
  ```

* En sistemas Windows:

  ```bash
  mkdir LIBERTY_HOME\wlp\usr\extension\lib
  copy /B product_install_dir\features\com.ibm.websphere.crypto_1.0.0.jar
  LIBERTY_HOME\wlp\usr\extension\lib\com.ibm.websphere.crypto_1.0.0.jar
  mkdir LIBERTY_HOME\wlp\usr\extension\lib\features
  copy /B product_install_dir\features\MFPDecoderFeature-1.0.mf
  LIBERTY_HOME\wlp\usr\extension\lib\features\MFPDecoderFeature-1.0.mf
  ```

#### Detalles de la configuración
{: #configuration-details-liberty }
<div class="panel-group accordion" id="manual-installation-liberty" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="admin-service">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty" href="#collapse-admin-service" aria-expanded="true" aria-controls="collapse-admin-service"><b>Detalles de configuración del servicio de administración de {{ site.data.keys.mf_server }}</b></a>
            </h4>
        </div>

        <div id="collapse-admin-service" class="panel-collapse collapse" role="tabpanel" aria-labelledby="admin-service">
            <div class="panel-body">
                <p>El servicio de administración está empaquetado como una aplicación WAR para desplegar en el servidor de aplicaciones. Necesita realizar algunas configuraciones específicas para esta aplicación en el archivo <b>server.xml</b>. El archivo WAR del servicio de administración se encuentra en <b>mfp_install_dir/MobileFirstServer/mfp-admin-service.war</b>. Puede definir la raíz de contexto como desee. Sin embargo, normalmente es <b>/mfpadmin</b>.</p>

                <h3>Propiedades JNDI obligatorias</h3>
                <p>Al definir las propiedades JNDI, los nombres de JNDI deben tener como prefijo la raíz de contexto del servicio de administración. El ejemplo siguiente ilustra el caso para declarar <b>mfp.admin.push.url</b> mediante el que el servicio de administración está instalado con <b>/mfpadmin</b> como raíz de contexto:</p>
{% highlight xml %}
<jndiEntry jndiName="mfpadmin/mfp.admin.push.url" value="http://localhost:9080/imfpush"/>
{% endhighlight %}

                <p>Si el servicio de envío por push está instalado, debe configurar las siguientes propiedades JNDI:</p>
                <ul>
                    <li><b>mfp.admin.push.url</b></li>
                    <li><b>mfp.admin.authorization.server.url</b></li>
                    <li><b>mfp.push.authorization.client.id</b></li>
                    <li><b>mfp.push.authorization.client.secret</b></li>
                    <li><b>mfp.admin.authorization.client.id</b></li>
                    <li><b>mfp.admin.authorization.client.secret</b></li>
                </ul>
                <p>Las propiedades JNDI para la comunicación con el servicio de configuración son las siguientes:</p>
                <ul>
                    <li><b>mfp.config.service.user</b></li>
                    <li><b>mfp.config.service.password</b></li>
                </ul>
                <p>Para obtener más información sobre las propiedades JNDI, consulte <a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service">Lista de propiedades JNDI para el servicio de administración de {{ site.data.keys.mf_server }}</a>.</p>

                <h3>Origen de datos</h3>
                <p>El nombre JNDI del origen de datos para el servicio de administración debe estar definido como <b>jndiName=the-contextRoot/jdbc/mfpAdminDS</b>. En el ejemplo siguiente se ilustra el caso mediante el que el servicio de administración está instalado con la raíz de contexto <b>/mfpadmin</b>, y que el servicio está utilizando una base de datos relacional:</p>

{% highlight xml %}
<dataSource jndiName="mfpadmin/jdbc/mfpAdminDS" transactional="false">
  [...]
</dataSource>
{% endhighlight %}

                <h3></h3>
                <p>Declare los roles siguientes en el elemento <b>application-bnd</b> de la aplicación:</p>
                <ul>
                    <li>mfpadmin</li>
                    <li>mfpdeployer</li>
                    <li>mfpmonitor</li>
                    <li>mfpoperator</li>
                </ul>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="live-update-service">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty" href="#collapse-live-update-service" aria-expanded="true" aria-controls="collapse-live-update-service"><b>Detalles de configuración del servicio de Live Update de {{ site.data.keys.mf_server }}</b></a>
            </h4>
        </div>

        <div id="collapse-live-update-service" class="panel-collapse collapse" role="tabpanel" aria-labelledby="live-update-service">
            <div class="panel-body">
                <p>El servicio de Live Update está empaquetado como una aplicación WAR para que la despliegue en el servidor de aplicaciones. Necesita realizar algunas configuraciones específicas para esta aplicación en el archivo <b>server.xml</b>. Antes de continuar, consulte <a href="#manual-installation-on-websphere-application-server-liberty">Instalación manual en WebSphere Application Server Liberty</a> para ver los detalles de configuración que son comunes a todos los servicios.</p>

                <p>El archivo WAR del servicio de Live Update se encuentra en <b>mfp_install_dir/MobileFirstServer/mfp-live-update.war</b>. La raíz de contexto del servicio de Live Update debe definirse de esta forma: <b>/the-adminContextRootconfig</b>. Por ejemplo, si la raíz de contexto del servicio de administración es <b>/mfpadmin</b>, la raíz de contexto del servicio de Live Update debe ser <b>/mfpadminconfig</b>.</p>

                <h3>Origen de datos</h3>
                <p>El nombre JNDI del origen de datos para el servicio de Live Update debe estar definido como the-contextRoot/jdbc/ConfigDS. El ejemplo siguiente ilustra el caso mediante el que el servicio de Live Update está instalado con la raíz de contexto /mfpadminconfig, y en el que el servicio está utilizando una base de datos relacional:</p>

{% highlight xml %}
<dataSource jndiName="mfpadminconfig/jdbc/ConfigDS" transactional="false">
  [...]
</dataSource>
{% endhighlight %}

                <h3></h3>
                <p>Declare el rol configadmin en el elemento <b>application-bnd</b> de la aplicación. Como mínimo un usuario debe estar correlacionado con este rol. El usuario y su contraseña deben estar proporcionados en las siguientes propiedades JNDI del servicio de administración:</p>

                <ul>
                    <li><b>mfp.config.service.user</b></li>
                    <li><b>mfp.config.service.password</b></li>
                </ul>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="console-configuration">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty" href="#collapse-console-configuration" aria-expanded="true" aria-controls="collapse-console-configuration"><b>Detalles de configuración de {{ site.data.keys.mf_console }}</b></a>
            </h4>
        </div>

        <div id="collapse-console-configuration" class="panel-collapse collapse" role="tabpanel" aria-labelledby="console-configuration">
            <div class="panel-body">
                <p>La consola está empaquetada como una aplicación WAR para que la despliegue en el servidor de aplicaciones. Necesita realizar algunas configuraciones específicas para esta aplicación en el archivo <b>server.xml</b>. Antes de continuar, consulte <a href="#manual-installation-on-websphere-application-server-liberty">Instalación manual en WebSphere Application Server Liberty</a> para ver los detalles de configuración que son comunes a todos los servicios.</p>

                <p>El archivo WAR de la consola se encuentra en <b>mfp_install_dir/MobileFirstServer/mfp-admin-ui.war</b>. Puede definir la raíz de contexto como desee. Sin embargo, normalmente es <b>/mfpconsole</b>.</p>

                <h3>Propiedades JNDI obligatorias</h3>
                <p>Al definir las propiedades JNDI, los nombres de JNDI deben tener como prefijo la raíz de contexto de la consola. El ejemplo siguiente ilustra el caso para declarar <b>mfp.admin.endpoint</b> mediante el que la consola se instala con <b>/mfpconsole</b> como raíz de contexto:</p>

{% highlight xml %}
<jndiEntry jndiName="mfpconsole/mfp.admin.endpoint" value="*://*:*/mfpadmin"/>
{% endhighlight %}

                <p>El valor típico para la propiedad mfp.admin.endpoint es <b>*://*:*/the-adminContextRoot</b>.<br/>
                Para obtener más información sobre las propiedades JNDI, consulte <a href="../server-configuration/#jndi-properties-for-mobilefirst-operations-console">Propiedades JNDI para {{ site.data.keys.mf_console }}</a>.</p>

                <h3>Roles de seguridad</h3>
                <p>Declare los roles siguientes en el elemento <b>application-bnd</b> de la aplicación:</p>
                <ul>
                    <li><b>mfpadmin</b></li>
                    <li><b>mfpdeployer</b></li>
                    <li><b>mfpmonitor</b></li>
                    <li><b>mfpoperator</b></li>
                </ul>
                Cualquier usuario que esté correlacionado con un rol de seguridad de la consola también debe estar correlacionado en el mismo rol de seguridad que el servicio de administración.
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="runtime-configuration">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty" href="#collapse-runtime-configuration" aria-expanded="true" aria-controls="collapse-runtime-configuration"><b>Detalles de configuración de tiempo de ejecución de MobileFirst</b></a>
            </h4>
        </div>

        <div id="collapse-runtime-configuration" class="panel-collapse collapse" role="tabpanel" aria-labelledby="runtime-configuration">
            <div class="panel-body">
                <p>El tiempo de ejecución está empaquetado como una aplicación WAR para que la despliegue en el servidor de aplicaciones. Necesita realizar algunas configuraciones específicas para esta aplicación en el archivo <b>server.xml</b>. Antes de continuar, consulte <a href="#manual-installation-on-websphere-application-server-liberty">Instalación manual en WebSphere Application Server Liberty</a> para ver los detalles de configuración que son comunes a todos los servicios.</p>

                <p>El archivo WAR de tiempo de ejecución se encuentra en <b>mfp_install_dir/MobileFirstServer/mfp-server.war</b>. Puede definir la raíz de contexto como desee. Sin embargo, es <b>/mfp</b> de forma predeterminada.</p>

                <h3>Propiedades JNDI obligatorias</h3>
                <p>Al definir las propiedades JNDI, los nombres de JNDI deben tener como prefijo la raíz de contexto del tiempo de ejecución. El ejemplo siguiente ilustra el caso para declarar <b>mfp.analytics.url</b> mediante el que se instala el tiempo de ejecución con <b>/mobilefirst</b> como raíz de contexto:</p>

{% highlight xml %}
<jndiEntry jndiName="mobilefirst/mfp.analytics.url" value="http://localhost:9080/analytics-service/rest"/>
{% endhighlight %}

                <p>Debe definir la propiedad <b>mobilefirst/mfp.authorization.server</b>. Por ejemplo:</p>
{% highlight xml %}
<jndiEntry jndiName="mobilefirst/mfp.authorization.server" value="embedded"/>
{% endhighlight %}

                <p>Si {{ site.data.keys.mf_analytics }} está instalado, tiene que definir las siguientes propiedades JNDI:</p>
                <ul>   
                    <li><b>mfp.analytics.url</b></li>
                    <li><b>mfp.analytics.console.url</b></li>
                    <li><b>mfp.analytics.username</b></li>
                    <li><b>mfp.analytics.password</b></li>
                </ul>

                <p>Para obtener más información sobre las propiedades JNDI, consulte <a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime">Lista de propiedades JNDI para el tiempo de ejecución de {{ site.data.keys.product_adj }}</a>.</p>

                <h3>Origen de datos</h3>
                <p>El nombre JNDI del origen de datos para el tiempo de ejecución debe estar definido como <b>jndiName=the-contextRoot/jdbc/mfpDS</b>. El ejemplo siguiente ilustra el caso mediante el que el tiempo de ejecución está instalado con la raíz de contexto <b>/mobilefirst</b>, y que el tiempo de ejecución está utilizando una base de datos relacional:</p>

{% highlight xml %}
<dataSource jndiName="mobilefirst/jdbc/mfpDS" transactional="false">
  [...]
</dataSource>
{% endhighlight %}
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="push-configuration-liberty">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty" href="#collapse-push-configuration-liberty" aria-expanded="true" aria-controls="collapse-push-configuration-liberty"><b>Detalles de configuración del servicio de envío por push de {{ site.data.keys.mf_server }}</b></a>
            </h4>
        </div>

        <div id="collapse-push-configuration-liberty" class="panel-collapse collapse" role="tabpanel" aria-labelledby="push-configuration-liberty">
            <div class="panel-body">
                <p>El servicio de envío por push está empaquetado como una aplicación WAR para que la despliegue en el servidor de aplicaciones. Necesita realizar algunas configuraciones específicas para esta aplicación en el archivo <b>server.xml</b>. Antes de continuar, consulte <a href="#manual-installation-on-websphere-application-server-liberty">Instalación manual en WebSphere Application Server Liberty</a> para ver los detalles de configuración que son comunes a todos los servicios.</p>

                <p>El archivo WAR del servicio de envío por push se encuentra en <b>mfp_install_dir/PushService/mfp-push-service.war</b>. Debe definir la raíz de contexto como <b>/imfpush</b>. De lo contrario, los dispositivos cliente no se podrán conectar a la misma, ya que la raíz de contexto está codificada en el SDK.</p>

                <h3>Propiedades JNDI obligatorias</h3>
                <p>Al definir las propiedades JNDI, los nombres de JNDI deben tener como prefijo la raíz de contexto del servicio de envío por push. El ejemplo siguiente ilustra el caso para declarar <b>mfp.push.analytics.user</b> mediante el que el servicio de envío por push está instalado con <b>/imfpush</b> como raíz de contexto:</p>

{% highlight xml %}
<jndiEntry jndiName="imfpush/mfp.push.analytics.user" value="admin"/>
{% endhighlight %}

                Debe definir las propiedades siguientes:
                <ul>
                    <li><b>mfp.push.authorization.server.url</b></li>
                    <li><b>mfp.push.authorization.client.id</b></li>
                    <li><b>mfp.push.authorization.client.secret</b></li>
                    <li><b>mfp.push.services.ext.security</b> - el valor debe ser <b>com.ibm.mfp.push.server.security.plugin.OAuthSecurityPlugin</b>.</li>
                    <li><b>mfp.push.db.type</b> - para una base de datos relacional, el valor debe ser DB.</li>
                </ul>

                Si se configura {{ site.data.keys.mf_analytics }}, defina las siguientes propiedades JNDI:
                <ul>
                    <li><b>mfp.push.analytics.endpoint</b></li>
                    <li><b>mfp.analytics.username</b></li>
                    <li><b>mfp.analytics.password</b></li>
                    <li><b>mfp.push.services.ext.analytics</b> - el valor debe ser <b>com.ibm.mfp.push.server.analytics.plugin.AnalyticsPlugin</b>.</li>
                </ul>
                Para obtener más información sobre las propiedades JNDI, consulte <a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service">Lista de propiedades JNDI para el servicio push de {{ site.data.keys.mf_server }}</a>.
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="artifacts-configuration">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty" href="#collapse-artifacts-configuration" aria-expanded="true" aria-controls="collapse-artifacts-configuration"><b>Detalles de configuración de artefactos de {{ site.data.keys.mf_server }}</b></a>
            </h4>
        </div>

        <div id="collapse-artifacts-configuration" class="panel-collapse collapse" role="tabpanel" aria-labelledby="artifacts-configuration">
            <div class="panel-body">
                <p>El componente de artefactos está empaquetado como una aplicación WAR para que la despliegue en el servidor de aplicaciones. Necesita realizar algunas configuraciones específicas para esta aplicación en el archivo <b>server.xml</b>. Antes de continuar, consulte <a href="#manual-installation-on-websphere-application-server-liberty">Instalación manual en WebSphere Application Server Liberty</a> para ver los detalles de configuración que son comunes a todos los servicios.</p>

                <p>El archivo WAR para este componente se encuentra en <b>mfp_install_dir/MobileFirstServer/mfp-dev-artifacts.war</b>. Debe definir la raíz de contexto como <b>/mfp-dev-artifacts</b>.</p>
            </div>
        </div>
    </div>
</div>

### Instalación manual en el colectivo de WebSphere Application Server Liberty
{: #manual-installation-on-websphere-application-server-liberty-collective }
Asegúrese de que también haya cumplido los requisitos tal como se describe en [Requisitos previos de WebSphere Application Server Liberty](#websphere-application-server-liberty-prerequisites).

* [Restricciones de topología](#topology-constraints-collective)
* [Valores del servidor de aplicaciones](#application-server-settings-collective)
* [Características de Liberty requeridas por las aplicaciones de {{ site.data.keys.mf_server }}](#liberty-features-required-by-the-mobilefirst-server-applications-collective)
* [Entradas JNDI globales](#global-jndi-entries-collective)
* [Cargador de clases](#class-loader-collective)
* [Característica de usuario decodificador de contraseñas](#password-decoder-user-feature-collective)
* [Detalles de la configuración](#configuration-details-collective)

#### Restricciones de topología
{: #topology-constraints-collective }
El servicio de administración de {{ site.data.keys.mf_server }}, el servicio de Live Update de {{ site.data.keys.mf_server }} y {{ site.data.keys.mf_console }} se deben instalar en un controlador colectivo de Liberty. El tiempo de ejecución de {{ site.data.keys.product_adj }} y el servicio de envío por push de the {{ site.data.keys.mf_server }} deben estar instalados en cada miembro del clúster colectivo de Liberty.

La raíz de contexto del servicio de Live Update debe estar definida como **the-adminContextRootconfig**. La raíz de contexto del servicio de envío por push debe ser **imfpush**. Para obtener más información acerca de las restricciones, consulte [Restricciones en los componentes de {{ site.data.keys.mf_server }} y {{ site.data.keys.mf_analytics }}](../topologies/#constraints-on-the-mobilefirst-server-components-and-mobilefirst-analytics).

#### Valores del servidor de aplicaciones
{: #application-server-settings-collective }
Debe configurar el elemento **webContainer** para cargar los servlets de inmediato. Este valor es necesario para la inicialización mediante JMX. Por ejemplo: `<webContainer deferServletLoad="false"/>`.

Opcionalmente, para evitar problemas de tiempo de espera excedido que rompan la secuencia de arranque del tiempo de ejecución y el servicio de administración en algunas versiones de Liberty, cambie el elemento **executor** predeterminado. Establezca valores grandes en los atributos **coreThreads** y **maxThreads**. Por ejemplo:

```xml
<executor id="default" name="LargeThreadPool"
  coreThreads="200" maxThreads="400" keepAlive="60s"
  stealPolicy="STRICT" rejectedWorkPolicy="CALLER_RUNS"/>
```

También puede configurar el elemento **tcpOptions** y establecer el atributo **soReuseAddr** en `true`: `<tcpOptions soReuseAddr="true"/>`.

#### Características de Liberty requeridas por las aplicaciones de {{ site.data.keys.mf_server }}
{: #liberty-features-required-by-the-mobilefirst-server-applications-collective }

Debe añadir las siguientes características para Java EE 6 o Java EE 7.

**Servicio de administración de {{ site.data.keys.mf_server }}**

* **jdbc-4.0** (jdbc-4.1 for Java EE 7)
* **appSecurity-2.0**
* **restConnector-1.0**
* **usr:MFPDecoderFeature-1.0**

**Servicio de envío por push de {{ site.data.keys.mf_server }}**  

* **jdbc-4.0** (jdbc-4.1 for Java EE 7)
* **servlet-3.0** (servlet-3.1 for Java EE 7)
* **ssl-1.0**
* **usr:MFPDecoderFeature-1.0**

**Tiempo de ejecución de {{ site.data.keys.product_adj }}**  

* **jdbc-4.0** (jdbc-4.1 for Java EE 7)
* **servlet-3.0** (servlet-3.1 for Java EE 7)
* **ssl-1.0**
* **usr:MFPDecoderFeature-1.0**

#### Entradas JNDI globales
{: #global-jndi-entries-collective }
Las siguientes entradas JNDI globales son necesarias para configurar la comunicación JMX entre el tiempo de ejecución y el servicio de administración:

* **mfp.admin.jmx.host**
* **mfp.admin.jmx.port**
* **mfp.admin.jmx.user**
* **mfp.admin.jmx.pwd**
* **mfp.topology.platform**
* **mfp.topology.clustermode**
* **mfp.admin.serverid**

Estas entradas JNDI globales se establecen con esta sintaxis y no tienen como prefijos una raíz de contexto. Por ejemplo: `<jndiEntry jndiName="mfp.admin.jmx.port" value="9443"/>`.

> **Nota:** Para proteger contra una conversión automática de los valores JNDI, para que 075 no se convierta a 61 o que 31,500 no se convierta en 31,5, utilice esta sintaxis '"075"' al definir el valor.

* Para obtener más información sobre las propiedades JNDI para el servicio de administración, consulte [Lista de propiedades JNDI para el servicio de administración de {{ site.data.keys.mf_server }}](../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service).  
* Para obtener más información sobre las propiedades JNDI para el tiempo de ejecución, consulte [Lista de propiedades JNDI para el tiempo de ejecución de {{ site.data.keys.product_adj }}](../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime).

#### Cargador de clases
{: #class-loader-collective }
Para todas las aplicaciones, el cargador de clases debe tener la delegación del último padre. Por ejemplo:

```xml
<application id="mfpadmin" name="mfpadmin" location="mfp-admin-service.war" type="war">
  [...]
  <classloader delegation="parentLast">
  </classloader>
</application>
```

#### Característica de usuario decodificador de contraseñas
{: #password-decoder-user-feature-collective }
Copie la característica de usuario decodificador de contraseñas en el perfil de Liberty. Por ejemplo:

* En sistemas UNIX y Linux:

  ```bash
  mkdir -p LIBERTY_HOME/wlp/usr/extension/lib/features
  cp product_install_dir/features/com.ibm.websphere.crypto_1.0.0.jar LIBERTY_HOME/wlp/usr/extension/lib/
  cp product_install_dir/features/MFPDecoderFeature-1.0.mf LIBERTY_HOME/wlp/usr/extension/lib/features/
  ```

* En sistemas Windows:

  ```bash
  mkdir LIBERTY_HOME\wlp\usr\extension\lib
  copy /B product_install_dir\features\com.ibm.websphere.crypto_1.0.0.jar
  LIBERTY_HOME\wlp\usr\extension\lib\com.ibm.websphere.crypto_1.0.0.jar
  mkdir LIBERTY_HOME\wlp\usr\extension\lib\features
  copy /B product_install_dir\features\MFPDecoderFeature-1.0.mf
  LIBERTY_HOME\wlp\usr\extension\lib\features\MFPDecoderFeature-1.0.mf
  ```
#### Detalles de la configuración
{: #configuration-details-collective }
<div class="panel-group accordion" id="manual-installation-liberty-collective" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="admin-service-collective">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty-collective" href="#collapse-admin-service-collective" aria-expanded="true" aria-controls="collapse-admin-service-collective"><b>Detalles de configuración del servicio de administración de {{ site.data.keys.mf_server }}</b></a>
            </h4>
        </div>

        <div id="collapse-admin-service-collective" class="panel-collapse collapse" role="tabpanel" aria-labelledby="admin-service-collective">
            <div class="panel-body">
                <p>El servicio de administración está empaquetado como una aplicación WAR para que la despliegue en el controlador colectivo de Liberty. Necesita realizar algunas configuraciones específicas para esta aplicación en el archivo <b>server.xml</b> del controlador colectivo de Liberty.
                <br/><br/>
                Antes de continuar, consulte <a href="#manual-installation-on-websphere-application-server-liberty-collective">Instalación manual en el colectivo de WebSphere Application Server Liberty</a> para ver los detalles de configuración que son comunes a todos los servicios.
                <br/><br/>
                El archivo WAR del servicio de administración se encuentra en <b>mfp_install_dir/MobileFirstServer/mfp-admin-service-collective.war</b>. Puede definir la raíz de contexto como desee. Sin embargo, normalmente es <b>/mfpadmin</b>.</p>

                <h3>Propiedades JNDI obligatorias</h3>
                <p>Al definir las propiedades JNDI, los nombres de JNDI deben tener como prefijo la raíz de contexto del servicio de administración. El ejemplo siguiente ilustra el caso para declarar <b>mfp.admin.push.url</b> mediante el que el servicio de administración está instalado con <b>/mfpadmin</b> como raíz de contexto:</p>
{% highlight xml %}
<jndiEntry jndiName="mfpadmin/mfp.admin.push.url" value="http://localhost:9080/imfpush"/>
{% endhighlight %}

                <p>Si el servicio de envío por push está instalado, debe configurar las siguientes propiedades JNDI:</p>
                <ul>
                    <li><b>mfp.admin.push.url</b></li>
                    <li><b>mfp.admin.authorization.server.url</b></li>
                    <li><b>mfp.push.authorization.client.id</b></li>
                    <li><b>mfp.push.authorization.client.secret</b></li>
                    <li><b>mfp.admin.authorization.client.id</b></li>
                    <li><b>mfp.admin.authorization.client.secret</b></li>
                </ul>
                <p>Las propiedades JNDI para la comunicación con el servicio de configuración son las siguientes:</p>
                <ul>
                    <li><b>mfp.config.service.user</b></li>
                    <li><b>mfp.config.service.password</b></li>
                </ul>
                <p>Para obtener más información sobre las propiedades JNDI, consulte <a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service">Lista de propiedades JNDI para el servicio de administración de {{ site.data.keys.mf_server }}</a>.</p>

                <h3>Origen de datos</h3>
                <p>El nombre JNDI del origen de datos para el servicio de administración debe estar definido como <b>jndiName=the-contextRoot/jdbc/mfpAdminDS</b>. En el ejemplo siguiente se ilustra el caso mediante el que el servicio de administración está instalado con la raíz de contexto <b>/mfpadmin</b>, y que el servicio está utilizando una base de datos relacional:</p>

{% highlight xml %}
<dataSource jndiName="mfpadmin/jdbc/mfpAdminDS" transactional="false">
  [...]
</dataSource>
{% endhighlight %}

                <h3>Roles de seguridad</h3>
                <p>Declare los roles siguientes en el elemento <b>application-bnd</b> de la aplicación:</p>
                <ul>
                    <li>mfpadmin</li>
                    <li>mfpdeployer</li>
                    <li>mfpmonitor</li>
                    <li>mfpoperator</li>
                </ul>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="live-update-service-collective">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty-collective" href="#collapse-live-update-service-collective" aria-expanded="true" aria-controls="collapse-live-update-service-collective"><b>Detalles de configuración del servicio de Live Update de {{ site.data.keys.mf_server }}</b></a>
            </h4>
        </div>

        <div id="collapse-live-update-service-collective" class="panel-collapse collapse" role="tabpanel" aria-labelledby="live-update-service-collective">
            <div class="panel-body">
                <p>El servicio de Live Update está empaquetado como una aplicación WAR para que desplegarse en el controlador colectivo de Liberty. Necesita realizar algunas configuraciones específicas para esta aplicación en el archivo <b>server.xml</b> del controlador colectivo de Liberty.
                <br/><br/>
                Antes de continuar, consulte <a href="#manual-installation-on-websphere-application-server-liberty-collective">Instalación manual en el colectivo de WebSphere Application Server Liberty</a> para ver los detalles de configuración que son comunes a todos los servicios.
                <br/><br/>
                El archivo WAR del servicio de Live Update se encuentra en <b>mfp_install_dir/MobileFirstServer/mfp-live-update.war</b>. La raíz de contexto del servicio de Live Update debe definirse de esta forma: <b>/the-adminContextRootconfig</b>. Por ejemplo, si la raíz de contexto del servicio de administración es <b>/mfpadmin</b>, la raíz de contexto del servicio de Live Update debe ser <b>/mfpadminconfig</b>.</p>

                <h3>Origen de datos</h3>
                <p>El nombre JNDI del origen de datos para el servicio de Live Update debe estar definido como <b>the-contextRoot/jdbc/ConfigDS</b>. El ejemplo siguiente ilustra el caso mediante el que está instalado el servicio de Live Update con la raíz de contexto <b>/mfpadminconfig</b>, y que el servicio está utilizando una base de datos relacional:</p>

{% highlight xml %}
<dataSource jndiName="mfpadminconfig/jdbc/ConfigDS" transactional="false">
  [...]
</dataSource>
{% endhighlight %}

                <h3>Roles de seguridad</h3>
                <p>Declare el rol configadmin en el elemento <b>application-bnd</b> de la aplicación. Como mínimo un usuario debe estar correlacionado con este rol. El usuario y su contraseña deben estar proporcionados en las siguientes propiedades JNDI del servicio de administración:</p>

                <ul>
                    <li><b>mfp.config.service.user</b></li>
                    <li><b>mfp.config.service.password</b></li>
                </ul>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="console-configuration-collective">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty-collective" href="#collapse-console-configuration-collective" aria-expanded="true" aria-controls="collapse-console-configuration-collective"><b>Detalles de configuración de {{ site.data.keys.mf_console }}</b></a>
            </h4>
        </div>

        <div id="collapse-console-configuration-collective" class="panel-collapse collapse" role="tabpanel" aria-labelledby="console-configuration-collective">
            <div class="panel-body">
                <p>La consola está empaquetada como una aplicación WAR para desplegarse en el controlador colectivo de Liberty. Necesita realizar algunas configuraciones específicas para esta aplicación en el archivo <b>server.xml</b> del controlador colectivo de Liberty.
                <br/><br/>Antes de continuar, consulte <a href="#manual-installation-on-websphere-application-server-liberty-collective">Instalación manual en WebSphere Application Server Liberty</a> para ver los detalles de configuración que son comunes a todos los servicios.
                <br/><br/>
                El archivo WAR de la consola se encuentra en <b>mfp_install_dir/MobileFirstServer/mfp-admin-ui.war</b>. Puede definir la raíz de contexto como desee. Sin embargo, normalmente es <b>/mfpconsole</b>.</p>

                <h3>Propiedades JNDI obligatorias</h3>
                <p>Al definir las propiedades JNDI, los nombres de JNDI deben tener como prefijo la raíz de contexto de la consola. El ejemplo siguiente ilustra el caso para declarar <b>mfp.admin.endpoint</b> mediante el que la consola se instala con <b>/mfpconsole</b> como raíz de contexto:</p>

{% highlight xml %}
<jndiEntry jndiName="mfpconsole/mfp.admin.endpoint" value="*://*:*/mfpadmin"/>
{% endhighlight %}

                <p>El valor típico para la propiedad mfp.admin.endpoint es <b>*://*:*/the-adminContextRoot</b>.<br/>
                Para obtener más información sobre las propiedades JNDI, consulte <a href="../server-configuration/#jndi-properties-for-mobilefirst-operations-console">Propiedades JNDI para {{ site.data.keys.mf_console }}</a>.</p>

                <h3>Roles de seguridad</h3>
                <p>Declare los roles siguientes en el elemento <b>application-bnd</b> de la aplicación:</p>
                <ul>
                    <li><b>mfpadmin</b></li>
                    <li><b>mfpdeployer</b></li>
                    <li><b>mfpmonitor</b></li>
                    <li><b>mfpoperator</b></li>
                </ul>
                Cualquier usuario que esté correlacionado con un rol de seguridad de la consola también debe estar correlacionado en el mismo rol de seguridad que el servicio de administración.
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="runtime-configuration-collective">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty-collective" href="#collapse-runtime-configuration-collective" aria-expanded="true" aria-controls="collapse-runtime-configuration-collective"><b>Detalles de configuración de tiempo de ejecución de {{ site.data.keys.product_adj }}</b></a>
            </h4>
        </div>

        <div id="collapse-runtime-configuration-collective" class="panel-collapse collapse" role="tabpanel" aria-labelledby="runtime-configuration-collective">
            <div class="panel-body">
                <p>El tiempo de ejecución está empaquetado como una aplicación WAR para desplegarse en los miembros del clúster colectivo de Liberty. Necesita realizar algunas configuraciones específicas para esta aplicación en el archivo <b>server.xml</b> de cada miembro del clúster colectivo de Liberty.
                <br/><br/>
                Antes de continuar, consulte <a href="#manual-installation-on-websphere-application-server-liberty-collective">Instalación manual en el colectivo de WebSphere Application Server Liberty</a> para ver los detalles de configuración que son comunes a todos los servicios.
                <br/><br/>
                El archivo WAR de tiempo de ejecución se encuentra en <b>mfp_install_dir/MobileFirstServer/mfp-server.war</b>. Puede definir la raíz de contexto como desee. Sin embargo, es <b>/mfp</b> de forma predeterminada.</p>

                <h3>Propiedades JNDI obligatorias</h3>
                <p>Al definir las propiedades JNDI, los nombres de JNDI deben tener como prefijo la raíz de contexto del tiempo de ejecución. El ejemplo siguiente ilustra el caso para declarar <b>mfp.analytics.url</b> mediante el que se instala el tiempo de ejecución con <b>/mobilefirst</b> como raíz de contexto:</p>

{% highlight xml %}
<jndiEntry jndiName="mobilefirst/mfp.analytics.url" value="http://localhost:9080/analytics-service/rest"/>
{% endhighlight %}

                <p>Debe definir la propiedad <b>mobilefirst/mfp.authorization.server</b>. Por ejemplo:</p>
{% highlight xml %}
<jndiEntry jndiName="mobilefirst/mfp.authorization.server" value="embedded"/>
{% endhighlight %}

                <p>Si {{ site.data.keys.mf_analytics }} está instalado, tiene que definir las siguientes propiedades JNDI:</p>
                <ul>   
                    <li><b>mfp.analytics.url</b></li>
                    <li><b>mfp.analytics.console.url</b></li>
                    <li><b>mfp.analytics.username</b></li>
                    <li><b>mfp.analytics.password</b></li>
                </ul>

                <p>Para obtener más información sobre las propiedades JNDI, consulte <a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime">Lista de propiedades JNDI para el tiempo de ejecución de {{ site.data.keys.product_adj }}</a>.</p>

                <h3>Origen de datos</h3>
                <p>El nombre JNDI del origen de datos para el tiempo de ejecución debe estar definido como <b>jndiName=the-contextRoot/jdbc/mfpDS</b>. El ejemplo siguiente ilustra el caso mediante el que el tiempo de ejecución está instalado con la raíz de contexto <b>/mobilefirst</b>, y que el tiempo de ejecución está utilizando una base de datos relacional:</p>

{% highlight xml %}
<dataSource jndiName="mobilefirst/jdbc/mfpDS" transactional="false">
  [...]
</dataSource>
{% endhighlight %}
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="push-configuration">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty-collective" href="#collapse-push-configuration" aria-expanded="true" aria-controls="collapse-push-configuration"><b>Detalles de configuración del servicio de envío por push de {{ site.data.keys.mf_server }}</b></a>
            </h4>
        </div>

        <div id="collapse-push-configuration" class="panel-collapse collapse" role="tabpanel" aria-labelledby="push-configuration">
            <div class="panel-body">
                <p>El servicio de envío por push está empaquetado como una aplicación WAR para desplegarla en un miembro del clúster colectivo de Liberty o en un servidor de Liberty. Si instala el servicio de envío por push en un servidor de Liberty, consulte <a href="#configuration-details-liberty">Detalles de configuración del servicio de envío por push de {{ site.data.keys.mf_server }}</a> en <a href="#manual-installation-on-websphere-application-server-liberty">Instalación manual en WebSphere Application Server Liberty</a>.
                <br/><br/>
                Cuando el servicio de envío por push de {{ site.data.keys.mf_server }} esté instalado en un colectivo de Liberty, se podrá instalar en el mismo clúster que el tiempo de ejecución o en otro clúster.
                <br/><br/>
                Necesita realizar algunas configuraciones específicas para esta aplicación en el archivo <b>server.xml</b> de cada miembro del clúster colectivo de Liberty. Antes de continuar, consulte <a href="#manual-installation-on-websphere-application-server-liberty-collective">Instalación manual en el colectivo de WebSphere Application Server Liberty</a> para ver los detalles de configuración que son comunes a todos los servicios.    
                <br/><br/>
                El archivo WAR del servicio de envío por push se encuentra en <b>mfp_install_dir/PushService/mfp-push-service.war</b>. Debe definir la raíz de contexto como <b>/imfpush</b>. De lo contrario, los dispositivos cliente no se podrán conectar a la misma, ya que la raíz de contexto está codificada en el SDK.</p>

                <h3>Propiedades JNDI obligatorias</h3>
                <p>Al definir las propiedades JNDI, los nombres de JNDI deben tener como prefijo la raíz de contexto del servicio de envío por push. El ejemplo siguiente ilustra el caso para declarar <b>mfp.push.analytics.user</b> mediante el que el servicio de envío por push está instalado con <b>/imfpush</b> como raíz de contexto:</p>

{% highlight xml %}
<jndiEntry jndiName="imfpush/mfp.push.analytics.user" value="admin"/>
{% endhighlight %}

                Debe definir las propiedades siguientes:
                <ul>
                    <li><b>mfp.push.authorization.server.url</b></li>
                    <li><b>mfp.push.authorization.client.id</b></li>
                    <li><b>mfp.push.authorization.client.secret</b></li>
                    <li><b>mfp.push.services.ext.security</b> - el valor debe ser <b>com.ibm.mfp.push.server.security.plugin.OAuthSecurityPlugin</b>.</li>
                    <li><b>mfp.push.db.type</b> - para una base de datos relacional, el valor debe ser DB.</li>
                </ul>

                Si se configura {{ site.data.keys.mf_analytics }}, defina las siguientes propiedades JNDI:
                <ul>
                    <li><b>mfp.push.analytics.endpoint</b></li>
                    <li><b>mfp.analytics.username</b></li>
                    <li><b>mfp.analytics.password</b></li>
                    <li><b>mfp.push.services.ext.analytics</b> - el valor debe ser <b>com.ibm.mfp.push.server.analytics.plugin.AnalyticsPlugin</b>.</li>
                </ul>
                Para obtener más información sobre las propiedades JNDI, consulte <a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service">Lista de propiedades JNDI para el servicio push de {{ site.data.keys.mf_server }}</a>.
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="artifacts-configuration-collective">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty-collective" href="#collapse-artifacts-configuration-collective" aria-expanded="true" aria-controls="collapse-artifacts-configuration-collective"><b>Detalles de configuración de artefactos de {{ site.data.keys.mf_server }}</b></a>
            </h4>
        </div>

        <div id="collapse-artifacts-configuration-collective" class="panel-collapse collapse" role="tabpanel" aria-labelledby="artifacts-configuration-collective">
            <div class="panel-body">
                <p>El componente artifacts está empaquetado como una aplicación WAR para desplegarse en el controlador colectivo de Liberty. Necesita realizar algunas configuraciones específicas para esta aplicación en el archivo <b>server.xml</b> del controlador colectivo de Liberty. Antes de continuar, consulte <a href="#manual-installation-on-websphere-application-server-liberty">Instalación manual en WebSphere Application Server Liberty</a> para ver los detalles de configuración que son comunes a todos los servicios.</p>

                <p>El archivo WAR para este componente se encuentra en <b>mfp_install_dir/MobileFirstServer/mfp-dev-artifacts.war</b>. Debe definir la raíz de contexto como <b>/mfp-dev-artifacts</b>.</p>
            </div>
        </div>
    </div>
</div>

### Instalación manual en Apache Tomcat
{: #manual-installation-on-apache-tomcat }
Asegúrese de que cumpla los requisitos tal como se describe en [Requisitos previos de Apache Tomcat](#apache-tomcat-prerequisites).

* [Restricciones de topología](#topology-constraints-tomcat)
* [Valores del servidor de aplicaciones](#application-server-settings-tomcat)
* [Detalles de la configuración](#configuration-details-tomcat)

#### Restricciones de topología
{: #topology-constraints-tomcat }
El servicio de administración de {{ site.data.keys.mf_server }}, el servicio de Live Update de {{ site.data.keys.mf_server }} y el tiempo de ejecución de {{ site.data.keys.product_adj }} deben estar instalados en el mismo servidor de aplicaciones. La raíz de contexto del servicio de Live Update debe estar definida como **the-adminContextRootconfig**. La raíz de contexto del servicio de envío por push debe ser **imfpush**. Para obtener más información acerca de las restricciones, consulte [Restricciones en los componentes de {{ site.data.keys.mf_server }} y {{ site.data.keys.mf_analytics }}](../topologies/#constraints-on-the-mobilefirst-server-components-and-mobilefirst-analytics).

#### Valores del servidor de aplicaciones
{: #application-server-settings-tomcat }
Debe activar **Valve de inicio de sesión único**. Por ejemplo:

```xml
<Valve className="org.apache.catalina.authenticator.SingleSignOn"/>
```

Opcionalmente, es posible que desee activar el dominio de memoria si los usuarios están definidos en **tomcat-users.xml**. Por ejemplo:

```xml
<Realm className="org.apache.catalina.realm.MemoryRealm"/>
```
#### Detalles de la configuración
{: #configuration-details-tomcat }
<div class="panel-group accordion" id="manual-installation-apache-tomcat" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="admin-service-tomcat">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-apache-tomcat" href="#collapse-admin-service-tomcat" aria-expanded="true" aria-controls="collapse-admin-service-tomcat"><b>Detalles de configuración del servicio de administración de {{ site.data.keys.mf_server }}</b></a>
            </h4>
        </div>

        <div id="collapse-admin-service-tomcat" class="panel-collapse collapse" role="tabpanel" aria-labelledby="admin-service-tomcat">
            <div class="panel-body">
                <p>El servicio de administración está empaquetado como una aplicación WAR para desplegar en el servidor de aplicaciones. Necesita realizar algunas configuraciones específicas para esta aplicación en el archivo <b>server.xml</b> del servidor de aplicaciones.
                <br/><br/>
                Antes de continuar, consulte <a href="#manual-installation-on-apache-tomcat">Instalación manual en Apache Tomcat</a> para ver los detalles de configuración que son comunes a todos los servicios.
                <br/><br/>
                El archivo WAR del servicio de administración se encuentra en <b>mfp_install_dir/MobileFirstServer/mfp-admin-service.war</b>. Puede definir la raíz de contexto como desee. Sin embargo, normalmente es <b>/mfpadmin</b>.</p>

                <h3>Propiedades JNDI obligatorias</h3>
                <p>Las propiedades JNDI están definidas en el elemento <code>Environment</code> del contexto de aplicaciones. Por ejemplo:</p>

{% highlight xml %}
<Environment name="mfp.admin.push.url" value="http://localhost:8080/imfpush" type="java.lang.String" override="false"/>
{% endhighlight %}
                <p>Para habilitar la comunicación de JMX con el tiempo de ejecución, defina las siguientes propiedades JNDI:</p>
                <ul>
                    <li><b>mfp.topology.platform</b></li>
                    <li><b>mfp.topology.clustermode</b></li>
                </ul>

                <p>Si el servicio de envío por push está instalado, debe configurar las siguientes propiedades JNDI:</p>
                <ul>
                    <li><b>mfp.admin.push.url</b></li>
                    <li><b>mfp.admin.authorization.server.url</b></li>
                    <li><b>mfp.push.authorization.client.id</b></li>
                    <li><b>mfp.push.authorization.client.secret</b></li>
                    <li><b>mfp.admin.authorization.client.id</b></li>
                    <li><b>mfp.admin.authorization.client.secret</b></li>
                </ul>
                <p>Las propiedades JNDI para la comunicación con el servicio de configuración son las siguientes:</p>
                <ul>
                    <li><b>mfp.config.service.user</b></li>
                    <li><b>mfp.config.service.password</b></li>
                </ul>
                <p>Para obtener más información sobre las propiedades JNDI, consulte <a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service">Lista de propiedades JNDI para el servicio de administración de {{ site.data.keys.mf_server }}</a>.</p>

                <h3>Origen de datos</h3>
                <p>El origen de datos (jdbc/mfpAdminDS) se declara como un recurso en el elemento **Context**. Por ejemplo:</p>

{% highlight xml %}
<Resource name="jdbc/mfpAdminDS" type="javax.sql.DataSource" .../>
{% endhighlight %}

                <h3>Roles de seguridad</h3>
                <p>Los roles de seguridad disponibles para la aplicación del servicio de administración son:</p>
                <ul>
                    <li>mfpadmin</li>
                    <li>mfpdeployer</li>
                    <li>mfpmonitor</li>
                    <li>mfpoperator</li>
                </ul>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="live-update-service-tomcat">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-apache-tomcat" href="#collapse-live-update-service-tomcat" aria-expanded="true" aria-controls="collapse-live-update-service-tomcat"><b>Detalles de configuración del servicio de Live Update de {{ site.data.keys.mf_server }}</b></a>
            </h4>
        </div>

        <div id="collapse-live-update-service-tomcat" class="panel-collapse collapse" role="tabpanel" aria-labelledby="live-update-service-tomcat">
            <div class="panel-body">
                <p>El servicio de Live Update está empaquetado como una aplicación WAR para que la despliegue en el servidor de aplicaciones. Necesita realizar algunas configuraciones específicas para esta aplicación en el archivo <b>server.xml</b>.
                <br/><br/>
                Antes de continuar, consulte <a href="#manual-installation-on-apache-tomcat">Instalación manual en Apache Tomcat</a> para ver los detalles de configuración que son comunes a todos los servicios.
                <br/><br/>
                El archivo WAR del servicio de Live Update se encuentra en <b>mfp_install_dir/MobileFirstServer/mfp-live-update.war</b>. La raíz de contexto del servicio de Live Update debe definirse de esta forma: <b>/the-adminContextRoot/config</b>. Por ejemplo, si la raíz de contexto del servicio de administración es <b>/mfpadmin</b>, la raíz de contexto del servicio de Live Update debe ser <b>/mfpadminconfig</b>.</p>

                <h3>Origen de datos</h3>
                <p>El nombre JNDI del origen de datos para el servicio de Live Update debe estar definido como <code>jdbc/ConfigDS</code>. Declárelo como un recurso en el elemento <code>Context</code>.</p>

                <h3>Roles de seguridad</h3>
                <p>El rol de seguridad disponible para la aplicación de servicio de Live Update es <b>configadmin</b>.
                <br/><br/>
                Como mínimo un usuario debe estar correlacionado con este rol. El usuario y su contraseña deben estar proporcionados en las siguientes propiedades JNDI del servicio de administración:</p>

                <ul>
                    <li><b>mfp.config.service.user</b></li>
                    <li><b>mfp.config.service.password</b></li>
                </ul>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="console-configuration-tomcat">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-apache-tomcat" href="#collapse-console-configuration-tomcat" aria-expanded="true" aria-controls="collapse-console-configuration-tomcat"><b>Detalles de configuración de {{ site.data.keys.mf_console }}</b></a>
            </h4>
        </div>

        <div id="collapse-console-configuration-tomcat" class="panel-collapse collapse" role="tabpanel" aria-labelledby="console-configuration-tomcat">
            <div class="panel-body">
                <p>La consola está empaquetada como una aplicación WAR para que la despliegue en el servidor de aplicaciones. Necesita realizar algunas configuraciones específicas para esta aplicación en el archivo <b>server.xml</b> del servidor de aplicaciones.
                <br/><br/>Antes de continuar, consulte <a href="#manual-installation-on-apache-tomcat">Instalación manual en Apache Tomcat</a> para ver los detalles de configuración que son comunes a todos los servicios.
                <br/><br/>
                El archivo WAR de la consola se encuentra en <b>mfp_install_dir/MobileFirstServer/mfp-admin-ui.war</b>. Puede definir la raíz de contexto como desee. Sin embargo, normalmente es <b>/mfpconsole</b>.</p>

                <h3>Propiedades JNDI obligatorias</h3>
                <p>Debe definir la propiedad <b>mfp.admin.endpoint</b>. El valor típico para esta propiedad es <b>*://*:*/the-adminContextRoot</b>.
                <br/><br/>
                Para obtener más información sobre las propiedades JNDI, consulte <a href="../server-configuration/#jndi-properties-for-mobilefirst-operations-console">Propiedades JNDI para {{ site.data.keys.mf_console }}</a>.</p>

                <h3>Roles de seguridad</h3>
                <p>Los roles de seguridad disponibles para la aplicación son:</p>
                <ul>
                    <li><b>mfpadmin</b></li>
                    <li><b>mfpdeployer</b></li>
                    <li><b>mfpmonitor</b></li>
                    <li><b>mfpoperator</b></li>
                </ul>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="runtime-configuration-tomcat">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-apache-tomcat" href="#collapse-runtime-configuration-tomcat" aria-expanded="true" aria-controls="collapse-runtime-configuration-tomcat"><b>Detalles de configuración de tiempo de ejecución de {{ site.data.keys.product_adj }}</b></a>
            </h4>
        </div>

        <div id="collapse-runtime-configuration-tomcat" class="panel-collapse collapse" role="tabpanel" aria-labelledby="runtime-configuration-tomcat">
            <div class="panel-body">
                <p>El tiempo de ejecución está empaquetado como una aplicación WAR para que la despliegue en el servidor de aplicaciones. Necesita realizar algunas configuraciones específicas para esta aplicación en el archivo <b>server.xml</b>.
                <br/><br/>
                Antes de continuar, consulte <a href="#manual-installation-on-apache-tomcat">Instalación manual en Apache Tomcat</a> para ver los detalles de configuración que son comunes a todos los servicios.
                <br/><br/>
                El archivo WAR de tiempo de ejecución se encuentra en <b>mfp_install_dir/MobileFirstServer/mfp-server.war</b>. Puede definir la raíz de contexto como desee. Sin embargo, es <b>/mfp</b> de forma predeterminada.</p>

                <h3>Propiedades JNDI obligatorias</h3>
                <p>Debe definir la propiedad <b>mfp.authorization.server</b>. Por ejemplo:</p>

{% highlight xml %}
<Environment name="mfp.authorization.server" value="embedded" type="java.lang.String" override="false"/>
{% endhighlight %}

                <p>Para habilitar la comunicación de JMX con el servicio de administración, defina las siguientes propiedades JNDI:</p>
                <ul>
                    <li><b>mfp.topology.platform</b></li>
                    <li><b>mfp.topology.clustermode</b></li>
                </ul>

                <p>Si {{ site.data.keys.mf_analytics }} está instalado, tiene que definir las siguientes propiedades JNDI:</p>
                <ul>   
                    <li><b>mfp.analytics.url</b></li>
                    <li><b>mfp.analytics.console.url</b></li>
                    <li><b>mfp.analytics.username</b></li>
                    <li><b>mfp.analytics.password</b></li>
                </ul>

                <p>Para obtener más información sobre las propiedades JNDI, consulte <a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime">Lista de propiedades JNDI para el tiempo de ejecución de {{ site.data.keys.product_adj }}</a>.</p>

                <h3>Origen de datos</h3>
                <p>El nombre JNDI del origen de datos para el tiempo de ejecución debe estar definido como <b>jdbc/mfpDS</b>. Declárelo como un recurso en el elemento <b>Context</b>.</p>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="push-configuration-tomcat">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-apache-tomcat" href="#collapse-push-configuration-tomcat" aria-expanded="true" aria-controls="collapse-push-configuration-tomcat"><b>Detalles de configuración del servicio de envío por push de {{ site.data.keys.mf_server }}</b></a>
            </h4>
        </div>

        <div id="collapse-push-configuration-tomcat" class="panel-collapse collapse" role="tabpanel" aria-labelledby="push-configuration-tomcat">
            <div class="panel-body">
                <p>El servicio de envío por push está empaquetado como una aplicación WAR para que la despliegue en el servidor de aplicaciones. Necesita realizar algunas configuraciones específicas para esta aplicación. Antes de continuar, consulte <a href="#manual-installation-on-apache-tomcat">Instalación manual en Apache Tomcat</a> para ver los detalles de configuración que son comunes a todos los servicios.    
                <br/><br/>
                El archivo WAR del servicio de envío por push se encuentra en <b>mfp_install_dir/PushService/mfp-push-service.war</b>. Debe definir la raíz de contexto como <b>/imfpush</b>. De lo contrario, los dispositivos cliente no se podrán conectar a la misma, ya que la raíz de contexto está codificada en el SDK.</p>

                <h3>Propiedades JNDI obligatorias</h3>
                <p>Debe definir las propiedades siguientes:</p>
                <ul>
                    <li><b>mfp.push.authorization.server.url</b></li>
                    <li><b>mfp.push.authorization.client.id</b></li>
                    <li><b>mfp.push.authorization.client.secret</b></li>
                    <li><b>mfp.push.services.ext.security</b> - el valor debe ser <b>com.ibm.mfp.push.server.security.plugin.OAuthSecurityPlugin</b>.</li>
                    <li><b>mfp.push.db.type</b> - para una base de datos relacional, el valor debe ser DB.</li>
                </ul>

                <p>Si se configura {{ site.data.keys.mf_analytics }}, defina las siguientes propiedades JNDI:</p>
                <ul>
                    <li><b>mfp.push.analytics.endpoint</b></li>
                    <li><b>mfp.analytics.username</b></li>
                    <li><b>mfp.analytics.password</b></li>
                    <li><b>mfp.push.services.ext.analytics</b> - el valor debe ser <b>com.ibm.mfp.push.server.analytics.plugin.AnalyticsPlugin</b>.</li>
                </ul>
                Para obtener más información sobre las propiedades JNDI, consulte <a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service">Lista de propiedades JNDI para el servicio push de {{ site.data.keys.mf_server }}</a>.
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="artifacts-configuration-tomcat">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-on-apache-tomcat" href="#collapse-artifacts-configuration-tomcat" aria-expanded="true" aria-controls="collapse-artifacts-configuration-tomcat"><b>Detalles de configuración de artefactos de {{ site.data.keys.mf_server }}</b></a>
            </h4>
        </div>

        <div id="collapse-artifacts-configuration-tomcat" class="panel-collapse collapse" role="tabpanel" aria-labelledby="artifacts-configuration-tomcat">
            <div class="panel-body">
                <p>El componente de artefactos está empaquetado como una aplicación WAR para que la despliegue en el servidor de aplicaciones. Necesita realizar algunas configuraciones específicas para esta aplicación en el archivo <b>server.xml</b> del servidor de aplicaciones. Antes de continuar, consulte <a href="#manual-installation-on-apache-tomcat">Instalación manual en Apache Tomcat</a> para ver los detalles de configuración que son comunes a todos los servicios.</p>

                <p>El archivo WAR para este componente se encuentra en <b>mfp_install_dir/MobileFirstServer/mfp-dev-artifacts.war</b>. Debe definir la raíz de contexto como <b>/mfp-dev-artifacts</b>.</p>
            </div>
        </div>
    </div>
</div>

### Instalación manual en WebSphere Application Server y WebSphere Application Server Network Deployment
{: #manual-installation-on-websphere-application-server-and-websphere-application-server-network-deployment }
Asegúrese de que cumpla los requisitos tal como se describe en <a href="#websphere-application-server-and-websphere-application-server-network-deployment-prerequisites">Requisitos previos de WebSphere Application Server y WebSphere Application Server Network Deployment</a>.

* [Restricciones de topología](#topology-constraints-nd)
* [Valores del servidor de aplicaciones](#application-server-settings-nd)
* [Cargador de clases](#class-loader-nd)
* [Detalles de la configuración](#configuration-details-nd)

#### Restricciones de topología
{: #topology-constraints-nd }
<b>En un WebSphere Application Server autónomo</b>  
El servicio de administración de {{ site.data.keys.mf_server }}, el servicio de Live Update de {{ site.data.keys.mf_server }} y el tiempo de ejecución de {{ site.data.keys.product_adj }} deben estar instalados en el mismo servidor de aplicaciones. La raíz de contexto del servicio de Live Update debe estar definida como <b>the-adminContextRootConfig</b>. La raíz de contexto del servicio de envío por push debe ser <b>imfpush</b>. Para obtener más información acerca de las restricciones, consulte [Restricciones en los componentes de {{ site.data.keys.mf_server }} y {{ site.data.keys.mf_analytics }}](../topologies/#constraints-on-the-mobilefirst-server-components-and-mobilefirst-analytics).

<b>En WebSphere Application Server Network Deployment</b>  
El gestor de despliegue debe estar en ejecución mientras {{ site.data.keys.mf_server }} se encuentra en ejecución. El gestor de despliegue se utiliza para la comunicación JMX entre el tiempo de ejecución y el servicio de administración. El servicio de administración y el servicio de Live Update deben estar instalados en el mismo servidor de aplicaciones. El tiempo de ejecución puede estar instalado en distintos servidores que el servicio de administración, pero debe estar en la misma célula.

#### Valores del servidor de aplicaciones
{: #application-server-settings-nd }
La seguridad administrativa y la seguridad de la aplicación deben estar habilitadas. Puede habilitar la seguridad de la aplicación en la consola de administración de WebSphere Application Server:

1. Inicie sesión en la consola de administración de WebSphere Application Server.
2. Pulse **Seguridad → Seguridad global**. Asegúrese de que esté seleccionado Habilitar seguridad administrativa.
3. Además, asegúrese de que **Habilitar seguridad de la aplicación** esté seleccionado. La seguridad de la aplicación puede estar habilitada sólo si está habilitada la seguridad administrativa.
4. Pulse **Aceptar**.
5. Guarde los cambios.

Para obtener más información, consulte [Habilitación de seguridad](http://www.ibm.com/support/knowledgecenter/SSAW57_8.5.5/com.ibm.websphere.nd.doc/ae/tsec_csec2.html?view=kc) en la documentación de WebSphere Application Server.

La política de cargador de clases del servidor debe dar soporte a la delegación del último padre. Los archivos WAR de {{ site.data.keys.mf_server }} deben estar instalados con la modalidad del cargador de clases del último padre. Consulte la política de cargador de clases:

1. Inicie sesión en la consola de administración de WebSphere Application Server.
2. Pulse **Servidores → Tipos de servidores → Servidores de aplicaciones de WebSphere**, y pulse en el servidor que se utiliza para {{ site.data.keys.product }}.
3. Si la política de cargador de clases se establece en **Varios**, no haga nada.
4. Si la política de cargador de clases se establece en **Única** y la modalidad de carga de clases se establece en **Clases cargadas con cargador de clases local en primer lugar (último padre)**, no haga nada.
5. Si la política de cargador de clases se establece en **Única** y la modalidad de carga de clases se establece en **Clases cargadas con el cargador de clases padre en primer lugar (primer padre)**, cambie la política de cargador de clases a **Varios**. Además, establezca el orden de cargador de clases de todas las aplicaciones que no sean aplicaciones de {{ site.data.keys.mf_server }} en **Clases cargadas con el cargador de clases padre en primer lugar (primer padre)**.

#### Cargador de clases
{: #class-loader-nd }
Para todas las aplicaciones de {{ site.data.keys.mf_server }}, el cargador de clases debe tener la delegación de último padre.

Para establecer la delegación del cargador de clases a último padre una vez que se instale una aplicación, siga estos pasos:

1. Pulse el enlace **Gestionar aplicaciones**, o pulse **Aplicaciones → Tipos de aplicaciones → Aplicaciones empresariales de WebSphere**.
2. Pulse la aplicación **{{ site.data.keys.mf_server }}**. De forma predeterminada, el nombre de la aplicación es el nombre del archivo WAR.
3. En la sección **Propiedades detalladas**, pulse el enlace **Carga de clase y detección de actualización**.
4. En el panel **Orden de cargador de clases**, seleccione la opción **Clases cargadas con el cargador de clases locales en primer lugar (último padre)**.
5. Pulse **Aceptar**.
6. En la sección **Módulos**, pulse el enlace **Gestionar módulos**.
7. Pulse el módulo.
8. Para el campo **Orden de cargador de clases**, seleccione la opción **Clases cargadas con el cargador de clases locales en primer lugar (último padre)**.
9. Pulse **Aceptar** dos veces para confirmar la selección y volver al panel **Configuración** de la aplicación.
10. Pulse **Guardar** para persistir los cambios.

#### Detalles de la configuración
{: #configuration-details-nd }
<div class="panel-group accordion" id="manual-installation-nd" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="admin-service-nd">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-nd" href="#collapse-admin-service-nd" aria-expanded="true" aria-controls="collapse-admin-service-nd"><b>Detalles de configuración del servicio de administración de {{ site.data.keys.mf_server }}</b></a>
            </h4>
        </div>

        <div id="collapse-admin-service-nd" class="panel-collapse collapse" role="tabpanel" aria-labelledby="admin-service-nd">
            <div class="panel-body">
                <p>El servicio de administración está empaquetado como una aplicación WAR para desplegar en el servidor de aplicaciones. Necesita realizar algunas configuraciones específicas para esta aplicación en el archivo <b>server.xml</b> del servidor de aplicaciones.
                <br/><br/>
                Antes de continuar, consulte <a href="#manual-installation-on-websphere-application-server-and-websphere-application-server-network-deployment">Instalación manual en WebSphere Application Server y WebSphere Application Server Network Deployment</a> para ver los detalles de configuración que son comunes a todos los servicios.
                <br/><br/>
                El archivo WAR del servicio de administración se encuentra en <b>mfp_install_dir/MobileFirstServer/mfp-admin-service.war</b>. Puede definir la raíz de contexto como desee. Sin embargo, normalmente es <b>/mfpadmin</b>.</p>

                <h3>Propiedades JNDI obligatorias</h3>
                <p>Puede establecer propiedades JNDI con la consola de administración de WebSphere Application Server. Vaya a <b>Aplicaciones → Tipos de aplicaciones → Aplicaciones empresariales de WebSphere → nombre_aplicación → Entradas de entorno para módulos Web</b> y establezca las entradas.</p>

                <p>Para habilitar la comunicación de JMX con el tiempo de ejecución, defina las siguientes propiedades JNDI:</p>

                <b>En WebSphere Application Server Network Deployment</b>
                <ul>
                    <li><b>mfp.admin.jmx.dmgr.host</b></li>
                    <li><b>mfp.admin.jmx.dmgr.port</b> - el puerto SOAP en el gestor de despliegue.</li>
                    <li><b>mfp.topology.platform</b> - establezca el valor como <b>WAS</b>.</li>
                    <li><b>mfp.topology.clustermode</b> - establezca el valor como <b>Clúster</b>.</li>
                    <li><b>mfp.admin.jmx.connector</b> - establezca el valor como <b>SOAP</b>.</li>
                </ul>

                <b>En un WebSphere Application Server autónomo</b>
                <ul>
                    <li><b>mfp.topology.platform</b> - establezca el valor como <b>WAS</b>.</li>
                    <li><b>mfp.topology.clustermode</b> - establezca el valor como <b>Autónomo</b>.</li>
                    <li><b>mfp.admin.jmx.connector</b> - establezca el valor como <b>SOAP</b>.</li>
                </ul>

                <p>Si el servicio de envío por push está instalado, debe configurar las siguientes propiedades JNDI:</p>
                <ul>
                    <li><b>mfp.admin.push.url</b></li>
                    <li><b>mfp.admin.authorization.server.url</b></li>
                    <li><b>mfp.push.authorization.client.id</b></li>
                    <li><b>mfp.push.authorization.client.secret</b></li>
                    <li><b>mfp.admin.authorization.client.id</b></li>
                    <li><b>mfp.admin.authorization.client.secret</b></li>
                </ul>
                <p>Las propiedades JNDI para la comunicación con el servicio de configuración son las siguientes:</p>
                <ul>
                    <li><b>mfp.config.service.user</b></li>
                    <li><b>mfp.config.service.password</b></li>
                </ul>
                <p>Para obtener más información sobre las propiedades JNDI, consulte <a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service">Lista de propiedades JNDI para el servicio de administración de {{ site.data.keys.mf_server }}</a>.</p>

                <h3>Origen de datos</h3>
                <p>Cree un origen de datos para el servicio de administración y correlaciónelo con <b>jdbc/mfpAdminDS</b>.</p>

                <h3>Iniciar orden</h3>
                <p>La aplicación de servicio de administración debe iniciarse antes de la aplicación de ejecución. Puede establecer el orden en la sección <b>Comportamiento de arranque</b>. Por ejemplo, establezca el Orden de arranque en <b>1</b> para el servicio de administración y en <b>2</b> en el tiempo de ejecución.</p>

                <h3>Roles de seguridad</h3>
                <p>Los roles de seguridad disponibles para la aplicación del servicio de administración son:</p>
                <ul>
                    <li>mfpadmin</li>
                    <li>mfpdeployer</li>
                    <li>mfpmonitor</li>
                    <li>mfpoperator</li>
                </ul>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="live-update-service-nd">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-nd" href="#collapse-live-update-service-nd" aria-expanded="true" aria-controls="collapse-live-update-service-nd"><b>Detalles de configuración del servicio de Live Update de {{ site.data.keys.mf_server }}</b></a>
            </h4>
        </div>

        <div id="collapse-live-update-service-nd" class="panel-collapse collapse" role="tabpanel" aria-labelledby="live-update-service-nd">
            <div class="panel-body">
                <p>El servicio de Live Update está empaquetado como una aplicación WAR para que la despliegue en el servidor de aplicaciones. Necesita realizar algunas configuraciones específicas para esta aplicación en el archivo <b>server.xml</b>.
                <br/><br/>
                Antes de continuar, consulte <a href="#manual-installation-on-websphere-application-server-and-websphere-application-server-network-deployment">Instalación manual en WebSphere Application Server y WebSphere Application Server Network Deployment</a> para ver los detalles de configuración que son comunes a todos los servicios.
                <br/><br/>
                El archivo WAR del servicio de Live Update se encuentra en <b>mfp_install_dir/MobileFirstServer/mfp-live-update.war</b>. La raíz de contexto del servicio de Live Update debe definirse de esta forma: <b>/the-adminContextRoot/config</b>. Por ejemplo, si la raíz de contexto del servicio de administración es <b>/mfpadmin</b>, la raíz de contexto del servicio de Live Update debe ser <b>/mfpadminconfig</b>.</p>

                <h3>Origen de datos</h3>
                <p>Cree un origen de datos para el servicio de Live Update y correlaciónelo con <b>jdbc/ConfigDS</b>.</p>

                <h3>Roles de seguridad</h3>
                <p>El rol <b>configadmin</b> está definido para esta aplicación.
                <br/><br/>
                Como mínimo un usuario debe estar correlacionado con este rol. El usuario y su contraseña deben estar proporcionados en las siguientes propiedades JNDI del servicio de administración:</p>

                <ul>
                    <li><b>mfp.config.service.user</b></li>
                    <li><b>mfp.config.service.password</b></li>
                </ul>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="console-configuration-nd">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-nd" href="#collapse-console-configuration-nd" aria-expanded="true" aria-controls="collapse-console-configuration-nd"><b>Detalles de configuración de {{ site.data.keys.mf_console }}</b></a>
            </h4>
        </div>

        <div id="collapse-console-configuration-nd" class="panel-collapse collapse" role="tabpanel" aria-labelledby="console-configuration-nd">
            <div class="panel-body">
                <p>La consola está empaquetada como una aplicación WAR para que la despliegue en el servidor de aplicaciones. Necesita realizar algunas configuraciones específicas para esta aplicación en el archivo <b>server.xml</b> del servidor de aplicaciones.
                <br/><br/>Antes de continuar, consulte <a href="#manual-installation-on-websphere-application-server-and-websphere-application-server-network-deployment">Instalación manual en WebSphere Application Server y WebSphere Application Server Network Deployment</a> para ver los detalles de configuración que son comunes a todos los servicios.
                <br/><br/>
                El archivo WAR de la consola se encuentra en <b>mfp_install_dir/MobileFirstServer/mfp-admin-ui.war</b>. Puede definir la raíz de contexto como desee. Sin embargo, normalmente es <b>/mfpconsole</b>.</p>

                <h3>Propiedades JNDI obligatorias</h3>
                <p>Puede establecer propiedades JNDI con la consola de administración de WebSphere Application Server. Vaya a las entradas <b>Aplicaciones → Tipos de aplicaciones → Aplicaciones empresariales de WebSphere → nombre_aplicación → Entorno</b> para módulos Web y establezca las entradas.
                <br/><br/>
                Debe definir la propiedad <b>mfp.admin.endpoint</b>. El valor típico para esta propiedad es <b>*://*:*/the-adminContextRoot</b>.
                <br/><br/>
                Para obtener más información sobre las propiedades JNDI, consulte <a href="../server-configuration/#jndi-properties-for-mobilefirst-operations-console">Propiedades JNDI para {{ site.data.keys.mf_console }}</a>.</p>

                <h3>Roles de seguridad</h3>
                <p>Los roles de seguridad disponibles para la aplicación son:</p>
                <ul>
                    <li><b>mfpadmin</b></li>
                    <li><b>mfpdeployer</b></li>
                    <li><b>mfpmonitor</b></li>
                    <li><b>mfpoperator</b></li>
                </ul>
                Cualquier usuario que esté correlacionado con un rol de seguridad de la consola también debe estar correlacionado en el mismo rol de seguridad que el servicio de administración.
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="runtime-configuration-nd">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-nd" href="#collapse-runtime-configuration-nd" aria-expanded="true" aria-controls="collapse-runtime-configuration-nd"><b>Detalles de configuración de tiempo de ejecución de MobileFirst</b></a>
            </h4>
        </div>

        <div id="collapse-runtime-configuration-nd" class="panel-collapse collapse" role="tabpanel" aria-labelledby="runtime-configuration-nd">
            <div class="panel-body">
                <p>El tiempo de ejecución está empaquetado como una aplicación WAR para que la despliegue en el servidor de aplicaciones. Necesita realizar algunas configuraciones específicas para esta aplicación en el archivo <b>server.xml</b>.
                <br/><br/>
                Antes de continuar, consulte <a href="#manual-installation-on-websphere-application-server-and-websphere-application-server-network-deployment">Instalación manual en WebSphere Application Server y WebSphere Application Server Network Deployment</a> para ver los detalles de configuración que son comunes a todos los servicios.
                <br/><br/>
                El archivo WAR de tiempo de ejecución se encuentra en <b>mfp_install_dir/MobileFirstServer/mfp-server.war</b>. Puede definir la raíz de contexto como desee. Sin embargo, es <b>/mfp</b> de forma predeterminada.</p>

                <h3>Propiedades JNDI obligatorias</h3>
                <p>Puede establecer propiedades JNDI con la consola de administración de WebSphere Application Server. Vaya a las entradas <b>Aplicaciones → Tipos de aplicaciones → Aplicaciones empresariales de WebSphere → nombre_aplicación → Entorno</b> para módulos Web y establezca las entradas.</p>

                <p>Debe definir la propiedad <b>mfp.authorization.server</b> con el valor como incorporado.<br/>
                Además, defina las siguientes propiedades JNDI para habilitar la comunicación de JMX con el servicio de administración:</p>

                <b>En WebSphere Application Server Network Deployment</b>
                <ul>
                    <li><b>mfp.admin.jmx.dmgr.host</b> - el nombre de host del gestor de despliegue.</li>
                    <li><b>mfp.admin.jmx.dmgr.port</b> - el puerto SOAP del gestor de despliegue.</li>
                    <li><b>mfp.topology.platform</b> - establezca el valor como <b>WAS</b>.</li>
                    <li><b>mfp.topology.clustermode</b> - establezca el valor como <b>Clúster</b>.</li>
                    <li><b>mfp.admin.jmx.connector</b> - establezca el valor como <b>SOAP</b>.</li>
                </ul>

                <b>En un WebSphere Application Server autónomo</b>
                <ul>
                    <li><b>mfp.topology.platform</b> - establezca el valor como <b>WAS</b>.</li>
                    <li><b>mfp.topology.clustermode</b> - establezca el valor como <b>Autónomo</b>.</li>
                    <li><b>mfp.admin.jmx.connector</b> - establezca el valor como <b>SOAP</b>.</li>
                </ul>

                <p>Si {{ site.data.keys.mf_analytics }} está instalado, tiene que definir las siguientes propiedades JNDI:</p>
                <ul>   
                    <li><b>mfp.analytics.url</b></li>
                    <li><b>mfp.analytics.console.url</b></li>
                    <li><b>mfp.analytics.username</b></li>
                    <li><b>mfp.analytics.password</b></li>
                </ul>

                <p>Para obtener más información sobre las propiedades JNDI, consulte <a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime">Lista de propiedades JNDI para el tiempo de ejecución de {{ site.data.keys.product_adj }}</a>.</p>

                <h3>Iniciar orden</h3>
                <p>La aplicación de ejecución debe iniciarse después de la aplicación del servicio de administración. Puede establecer el orden en la sección <b>Comportamiento de arranque</b>. Por ejemplo, establezca el Orden de arranque en <b>1</b> para el servicio de administración y en <b>2</b> en el tiempo de ejecución.</p>

                <h3>Origen de datos</h3>
                <p>Cree un origen de datos para el tiempo de ejecución y correlaciónelo con <b>jdbc/mfpDS</b>.</p>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="push-configuration-nd">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-nd" href="#collapse-push-configuration-nd" aria-expanded="true" aria-controls="collapse-push-configuration-nd"><b>Detalles de configuración del servicio de envío por push de {{ site.data.keys.mf_server }}</b></a>
            </h4>
        </div>

        <div id="collapse-push-configuration-nd" class="panel-collapse collapse" role="tabpanel" aria-labelledby="push-configuration-nd">
            <div class="panel-body">
                <p>El servicio de envío por push está empaquetado como una aplicación WAR para que la despliegue en el servidor de aplicaciones. Necesita realizar algunas configuraciones específicas para esta aplicación. Antes de continuar, consulte <a href="#manual-installation-on-websphere-application-server-and-websphere-application-server-network-deployment">Instalación manual en WebSphere Application Server y WebSphere Application Server Network Deployment</a> para ver los detalles de configuración que son comunes a todos los servicios.    
                <br/><br/>
                El archivo WAR del servicio de envío por push se encuentra en <b>mfp_install_dir/PushService/mfp-push-service.war</b>. Debe definir la raíz de contexto como <b>/imfpush</b>. De lo contrario, los dispositivos cliente no se podrán conectar a la misma, ya que la raíz de contexto está codificada en el SDK.</p>

                <h3>Propiedades JNDI obligatorias</h3>
                <p>Puede establecer propiedades JNDI con la consola de administración de WebSphere Application Server. Vaya a <b>Aplicaciones > Tipos de aplicaciones → Aplicaciones empresariales de WebSphere → nombre_aplicación → Entradas de entorno para módulos Web</b> y establezca las entradas.</p>

                <p>Debe definir las propiedades siguientes:</p>
                <ul>
                    <li><b>mfp.push.authorization.server.url</b></li>
                    <li><b>mfp.push.authorization.client.id</b></li>
                    <li><b>mfp.push.authorization.client.secret</b></li>
                    <li><b>mfp.push.services.ext.security</b> - el valor debe ser <b>com.ibm.mfp.push.server.security.plugin.OAuthSecurityPlugin</b>.</li>
                    <li><b>mfp.push.db.type</b> - para una base de datos relacional, el valor debe ser DB.</li>
                </ul>

                <p>Si se configura {{ site.data.keys.mf_analytics }}, defina las siguientes propiedades JNDI:</p>
                <ul>
                    <li><b>mfp.push.analytics.endpoint</b></li>
                    <li><b>mfp.analytics.username</b></li>
                    <li><b>mfp.analytics.password</b></li>
                    <li><b>mfp.push.services.ext.analytics</b> - el valor debe ser <b>com.ibm.mfp.push.server.analytics.plugin.AnalyticsPlugin</b>.</li>
                </ul>
                <p>Para obtener más información sobre las propiedades JNDI, consulte <a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service">Lista de propiedades JNDI para el servicio push de {{ site.data.keys.mf_server }}</a>.</p>

                <h3>Origen de datos</h3>
                <p>Cree el origen de datos para el servicio de envío por push y correlaciónelo con <b>jdbc/imfPushDS</b>.</p>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="artifacts-configuration-nd">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-nd" href="#collapse-artifacts-configuration-nd" aria-expanded="true" aria-controls="collapse-artifacts-configuration-nd"><b>Detalles de configuración de artefactos de {{ site.data.keys.mf_server }}</b></a>
            </h4>
        </div>

        <div id="collapse-artifacts-configuration-nd" class="panel-collapse collapse" role="tabpanel" aria-labelledby="artifacts-configuration-nd">
            <div class="panel-body">
                <p>El componente de artefactos está empaquetado como una aplicación WAR para que la despliegue en el servidor de aplicaciones. Necesita realizar algunas configuraciones específicas para esta aplicación en el archivo <b>server.xml</b> del servidor de aplicaciones. Antes de continuar, consulte <a href="#manual-installation-on-websphere-application-server-and-websphere-application-server-network-deployment">Instalación manual en WebSphere Application Server y WebSphere Application Server Network Deployment</a> para ver los detalles de configuración que son comunes a todos los servicios.</p>

                <p>El archivo WAR para este componente se encuentra en <b>mfp_install_dir/MobileFirstServer/mfp-dev-artifacts.war</b>. Debe definir la raíz de contexto como <b>/mfp-dev-artifacts</b>.</p>
            </div>
        </div>
    </div>
</div>

## Instalación una granja de servidores
{: #installing-a-server-farm }
Puede instalar la granja de servidores ejecutando tareas Ant, con la Herramienta de configuración del servidor, o manualmente.

* [Planificación de la configuración de una granja de servidores](#planning-the-configuration-of-a-server-farm)
* [Instalación de una granja de servidores con la Herramienta de configuración del servidor](#installing-a-server-farm-with-the-server-configuration-tool)
* [Instalación de una granja de servidores con tareas Ant](#installing-a-server-farm-with-ant-tasks)
* [Configuración de una granja de servidores manualmente](#configuring-a-server-farm-manually)
* [Verificación de una configuración en una granja de servidores](#verifying-a-farm-configuration)
* [Ciclo de vida de un nodo de granja de servidores](#lifecycle-of-a-server-farm-node)

### Planificación de la configuración de una granja de servidores
{: #planning-the-configuration-of-a-server-farm }
Para planificar la configuración de una granja de servidores, seleccione el servidor de aplicaciones, configure las bases de datos de {{ site.data.keys.product_adj }} y despliegue los archivos WAR de los componentes de {{ site.data.keys.mf_server }} en cada servidor de la granja de servidores. Tiene las opciones de utilizar la Herramienta de configuración del servidor, las tareas Ant o las operaciones manuales para configurar una granja de servidores.

Cuando tenga la intención de planificar una instalación de granja de servidores, consulte [Restricciones en el servicio de administración de {{ site.data.keys.mf_server }}, en el servicio de Live Update de {{ site.data.keys.mf_server }} y en el tiempo de ejecución de MobileFirst](../topologies/#constraints-on-mobilefirst-server-administration-service-mobilefirst-server-live-update-service-and-mobilefirst-foundation-runtime) en primer lugar, y en particular consulte [Topología de la granja de servidores](../topologies/#server-farm-topology).

En {{ site.data.keys.product }}, una granja de servidores se compone de varios servidores de aplicaciones autónomos que no están federados ni administrados por un componente de gestión de un servidor de aplicaciones. {{ site.data.keys.mf_server }} proporciona internamente un plug-in de granja de servidores como medio para ampliar un servidor de aplicaciones para que pueda formar parte de una granja de servidores.

#### Cuándo declarar una granja de servidores
{: #when-to-declare-a-server-farm }
**Declare una granja de servidores en los casos siguientes:**

* {{ site.data.keys.mf_server }} se instala en varios servidores de aplicaciones de Tomcat.
* {{ site.data.keys.mf_server }} se instala en varios servidores de WebSphere Application Server pero no en WebSphere Application Server Network Deployment.
* {{ site.data.keys.mf_server }} se instala en varios servidores de WebSphere Application Server Liberty.

**No declare una granja de servidores en los casos siguientes:**

* El servidor de aplicaciones es autónomo.
* Varios servidores de aplicaciones están federados por WebSphere Application Server Network Deployment.

#### Porqué es obligatorio declarar una granja de servidores
{: #why-it-is-mandatory-to-declare-a-farm }
Cada vez que se realiza una operación de gestión a través de {{ site.data.keys.mf_console }} o de la aplicación de servicio de administración de {{ site.data.keys.mf_server }}, la operación necesitará replicarse en todas las instancias de un entorno de ejecución. Algunos ejemplos de tales operaciones de gestión son la carga de una versión nueva de una aplicación o de un adaptador. La réplica se realiza mediante las llamadas de JMX realizadas por la instancia de la aplicación de servicio de administración que maneja la operación. El servicio de administración necesita ponerse en contacto con todas las instancias de ejecución del clúster. En entornos listados bajo **Cuándo declarar una granja de servidores** anterior, se puede poner en contacto con la ejecución mediante JMX sólo si se configura una granja de servidores. Si se añade un servidor a un clúster sin la configuración adecuada de la granja de servidores, la ejecución en dicho servidor estará en un estado incoherente después de cada operación de gestión, y hasta que se reinicie de nuevo.

### Instalación de una granja de servidores con la Herramienta de configuración del servidor
{: #installing-a-server-farm-with-the-server-configuration-tool }
Utilice la Herramienta de configuración del servidor para configurar cada servidor de la granja de servidores de acuerdo con los requisitos del tipo único de servidor de aplicaciones que se utilice para cada miembro de la granja de servidores.

Cuando planifique una granja de servidores con la Herramienta de configuración del servidor, cree en primer lugar los servidores autónomos y configure sus respectivos almacenes de confianza para que se puedan comunicar entre sí de una forma segura. A continuación, ejecute la herramienta que realiza las operaciones siguientes:

* Configurar la instancia de base de datos que comparten los componentes de {{ site.data.keys.mf_server }}.
* Desplegar los componentes de {{ site.data.keys.mf_server }} en cada servidor
* Modificar su configuración para convertirla en un miembro de una granja de servidores

<div class="panel-group accordion" id="installing-mobilefirst-server-ct" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="server-farm-ct">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#server-farm-ct" href="#collapse-server-farm-ct" aria-expanded="true" aria-controls="collapse-server-farm-ct"><b>Pulse aquí para obtener instrucciones sobre la instalación de una granja de servidores con la Herramienta de configuración del servidor</b></a>
            </h4>
        </div>

        <div id="collapse-server-farm-ct" class="panel-collapse collapse" role="tabpanel" aria-labelledby="server-farm-ct">
            <div class="panel-body">
                <p>{{ site.data.keys.mf_server }} requiere que se configure la conexión JMX segura.</p>

                <ol>
                    <li>Prepare los servidores de aplicaciones que se deben configurar como miembros de la granja de servidores.
                        <ul>
                            <li>Elija el tipo de servidor de aplicaciones que se utilizará para configurar los miembros de la granja de servidores. {{ site.data.keys.product }} da soporte a los siguientes servidores de aplicaciones en granjas de servidores:
                                <ul>
                                    <li>Perfil completo de WebSphere Application Server<br/>
                                    <b>Nota:</b> En una topología de granja de servidores, no puede utilizar el conector RMI JMX. En esta topología, sólo se da soporte al conector SOAP mediante {{ site.data.keys.product }}.</li>
                                    <li>Perfil de Liberty de WebSphere Application Server</li>
                                    <li>Apache Tomcat</li>
                                </ul>
                                Para saber qué versiones de los servidores de aplicaciones están soportadas, consulte <a href="../../../product-overview/requirements">Requisitos del sistema</a>.

                                <blockquote><b>Importante:</b> {{ site.data.keys.product }} sólo da soporte a granjas de servidores homogéneas. Una granja de servidores es homogénea cuando conecta el mismo tipo de servidores de aplicaciones. Intentar asociar distintos tipos de servidores de aplicaciones puede dar lugar a un comportamiento impredecible en el tiempo de ejecución. Por ejemplo, una granja de servidores con una mezcla de servidores de Apache Tomcat y servidores de perfil completo de WebSphere Application Server es una configuración no válida.</blockquote>
                            </li>
                            <li>Configure tantos servidores autónomos como el número de miembros que desee en la granja de servidores.
                                <ul>
                                    <li>Cada uno de estos servidores autónomos debe comunicarse con la misma base de datos. Debe asegurarse de que cualquier puerto que utilice cualquiera de estos servidores no lo utilice también otro servidor configurado en el mismo host. Esta restricción se aplica a los puertos utilizados por los protocolos HTTP, HTTPS, REST, SOAP y RMI.</li>
                                    <li>Cada uno de estos servidores debe tener el servicio de administración de {{ site.data.keys.mf_server }}, el servicio de Live Update de {{ site.data.keys.mf_server }} y uno o varios tiempos de ejecución de {{ site.data.keys.product_adj }} desplegados.</li>
                                    <li>Para obtener más información sobre cómo configurar un servidor, consulte <a href="../topologies/#constraints-on-mobilefirst-server-administration-service-mobilefirst-server-live-update-service-and-mobilefirst-foundation-runtime">Restricciones en el servicio de administración de {{ site.data.keys.mf_server }}, en el servicio de Live Update de {{ site.data.keys.mf_server }} y en el tiempo de ejecución de {{ site.data.keys.product_adj }}</a>.</li>
                                </ul>
                            </li>
                            <li>Intercambie los certificados de firmante entre todos los servidores en sus respectivos almacenes de confianza.
                            <br/><br/>
                            Este paso es obligatorio para las granjas de servidores que utilizan el perfil completo de WebSphere Application Server o deba habilitarse Liberty como seguridad. Además, para las granjas de servidores de Liberty, se debe replicar la misma configuración de LTPA en cada servidor para asegurar la funcionalidad de inicio de sesión único. Para llevar a cabo esta configuración, siga las directrices en el paso 6 de <a href="#configuring-a-server-farm-manually">Configuración de una granja de servidores manualmente</a>.
                            </li>
                        </ul>
                    </li>
                    <li>Ejecute la Herramienta de configuración del servidor para cada servidor de la granja de servidores. Todos los servidores deben compartir las mismas bases de datos. Asegúrese de seleccionar el tipo de despliegue: <b>Despliegue de granja de servidores</b> en el panel <b>Valores del servidor de aplicaciones</b>. Para obtener más información sobre la herramienta, consulte <a href="#running-the-server-configuration-tool">Ejecución de la Herramienta de configuración del servidor</a>.
                    </li>
                </ol>
            </div>
        </div>
    </div>
</div>

### Instalación de una granja de servidores con tareas Ant
{: #installing-a-server-farm-with-ant-tasks }
Utilice las tareas Ant para configurar cada servidor de la granja de servidores según los requisitos del tipo único de servidor de aplicaciones que se utiliza para cada miembro de la granja de servidores.

Cuando planifique una granja de servidores con tareas Ant, cree en primer lugar los servidores autónomos y configure sus respectivos almacenes de confianza para que se puedan comunicar entre sí de forma segura. A continuación, ejecute las tareas Ant para configurar la instancia de base de datos que comparten los componentes de {{ site.data.keys.mf_server }}. Finalmente, ejecute tareas Ant para desplegar los componentes de {{ site.data.keys.mf_server }} en cada servidor y modificar su configuración para convertirla en miembro de una granja de servidores.

<div class="panel-group accordion" id="installing-mobilefirst-server-ant" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="server-farm-ant">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#server-farm-ct" href="#collapse-server-farm-ant" aria-expanded="true" aria-controls="collapse-server-farm-ant"><b>Pulse aquí para obtener instrucciones sobre cómo instalar una granja de servidores con tareas Ant</b></a>
            </h4>
        </div>

        <div id="collapse-server-farm-ant" class="panel-collapse collapse" role="tabpanel" aria-labelledby="server-farm-ant">
            <div class="panel-body">
                <p>{{ site.data.keys.mf_server }} requiere que se configure la conexión JMX segura.</p>

                <ol>
                    <li>Prepare los servidores de aplicaciones que se deben configurar como miembros de la granja de servidores.
                        <ul>
                            <li>Elija el tipo de servidor de aplicaciones que se utilizará para configurar los miembros de la granja de servidores. {{ site.data.keys.product }} da soporte a los siguientes servidores de aplicaciones en granjas de servidores:
                                <ul>
                                    <li>Perfil completo de WebSphere Application Server. <b>Nota:</b> En una topología de granja de servidores, no puede utilizar el conector RMI JMX. En esta topología, sólo se da soporte al conector SOAP mediante {{ site.data.keys.product }}.</li>
                                    <li>Perfil de Liberty de WebSphere Application Server</li>
                                    <li>Apache Tomcat</li>
                                </ul>
                                Para saber qué versiones de los servidores de aplicaciones están soportadas, consulte <a href="../../../product-overview/requirements">Requisitos del sistema</a>.

                                <blockquote><b>Importante:</b> {{ site.data.keys.product }} sólo da soporte a granjas de servidores homogéneas. Una granja de servidores es homogénea cuando conecta el mismo tipo de servidores de aplicaciones. Intentar asociar distintos tipos de servidores de aplicaciones puede dar lugar a un comportamiento impredecible en el tiempo de ejecución. Por ejemplo, una granja de servidores con una mezcla de servidores de Apache Tomcat y servidores de perfil completo de WebSphere Application Server es una configuración no válida.</blockquote>
                            </li>
                            <li>Configure tantos servidores autónomos como el número de miembros que desee en la granja de servidores.
                            <br/><br/>
                            Cada uno de estos servidores autónomos debe comunicarse con la misma base de datos. Debe asegurarse de que cualquier puerto que utilice cualquiera de estos servidores no lo utilice también otro servidor configurado en el mismo host. Esta restricción se aplica a los puertos utilizados por los protocolos HTTP, HTTPS, REST, SOAP y RMI.
                            <br/><br/>
                            Cada uno de estos servidores debe tener el servicio de administración de {{ site.data.keys.mf_server }}, el servicio de Live Update de {{ site.data.keys.mf_server }} y uno o varios tiempos de ejecución de {{ site.data.keys.product_adj }} desplegados.
                            <br/><br/>
                            Para obtener más información sobre cómo configurar un servidor, consulte <a href="../topologies/#constraints-on-mobilefirst-server-administration-service-mobilefirst-server-live-update-service-and-mobilefirst-foundation-runtime">Restricciones en el servicio de administración de {{ site.data.keys.mf_server }}, en el servicio de Live Update de {{ site.data.keys.mf_server }} y en el tiempo de ejecución de {{ site.data.keys.product_adj }}</a>.</li>
                            <li>Intercambie los certificados de firmante entre todos los servidores en sus respectivos almacenes de confianza.
                            <br/><br/>
                            Este paso es obligatorio para las granjas de servidores que utilizan el perfil completo de WebSphere Application Server o deba habilitarse Liberty como seguridad. Además, para las granjas de servidores de Liberty, se debe replicar la misma configuración de LTPA en cada servidor para asegurar la funcionalidad de inicio de sesión único. Para llevar a cabo esta configuración, siga las directrices en el paso 6 de <a href="#configuring-a-server-farm-manually">Configuración de una granja de servidores manualmente</a>.
                            </li>
                        </ul>
                    </li>
                    <li>Configure la base de datos para el servicio de administración, el servicio de Live Update y el tiempo de ejecución.
                        <ul>
                            <li>Decida la base de datos que desee utilizar y elija el archivo Ant para crear y configurar la base de datos en el directorio de <b>mfp_install_dir/MobileFirstServer/configuration-samples</b>:
                                <ul>
                                    <li>Para DB2, utilice <b>create-database-db2.xml</b>.</li>
                                    <li>Para MySQL, utilice <b>create-database-mysql.xml</b>.</li>
                                    <li>Para Oracle, utilice <b>create-database-oracle.xml</b>.</li>
                                </ul>
                                <blockquote>Nota: No utilice la base de datos Derby en una topología de granja de servidores porque la base de datos Derby sólo permite una única conexión al mismo tiempo.</blockquote>

                            </li>
                            <li>Edite el archivo Ant y escriba todas las propiedades necesarias para la base de datos.
                            <br/><br/>
                            Para habilitar la configuración de la base de datos que utilizan los componentes de {{ site.data.keys.mf_server }}, establezca los valores de las siguientes propiedades:
                                <ul>
                                    <li>Establezca <b>mfp.process.admin</b> en <b>true</b>. Para configurar la base de datos para el servicio de administración y el servicio de Live Update.</li>
                                    <li>Establezca <b>mfp.process.runtime</b> en <b>true</b>. Para configurar la base de datos para el tiempo de ejecución.</li>
                                </ul>
                            </li>
                            <li>Ejecute los mandatos siguientes desde el directorio <b>dir_instal_mfp/MobileFirstServer/configuration-samples</b> donde <b>create-database-ant-file.xml</b> se debe sustituir por el nombre de archivo Ant real que elija: <code>dir_instal_mfp/shortcuts/ant -f create-database-ant-file.xml admdatabases</code> y <code>dir_instal_mfp/shortcuts/ant -f create-database-ant-file.xml rtmdatabases</code>.
                            <br/><br/>
                            Puesto que las bases de datos de {{ site.data.keys.mf_server }} se comparten entre los servidores de aplicaciones de una granja de servidores, estos dos mandatos se deben ejecutar sólo una vez, sea cual sea el número de servidores de la granja de servidores.
                            </li>
                            <li>Opcionalmente, si desea instalar otro tiempo de ejecución, debe configurar otra base de datos con otro nombre o esquema de base de datos. Para hacerlo, edite el archivo Ant, modifique las propiedades y ejecute el mandato siguiente una vez, sea cual sea el número de servidores de la granja de servidores: <code>dir_instal_mfp/shortcuts/ant -f create-database-ant-file.xml rtmdatabases</code>.</li>
                        </ul>
                    </li>
                    <li>Despliegue el servicio de administración, el servicio de Live Update y el tiempo de ejecución en los servidores y configure estos servidores como miembros de una granja de servidores.
                        <ul>
                            <li>Elija el archivo Ant que se corresponda con su servidor de aplicaciones y su base de datos en el directorio <b>mfp\_install\_dir/MobileFirstServer/configuration-samples</b> para desplegar el servicio de administración, el servicio de Live Update y el tiempo de ejecución en los servidores.
                            <br/><br/>
                            Por ejemplo, elija el archivo <b>configure-liberty-db2.xml</b> para un despliegue en el servidor de Liberty con la base de datos de DB2. Realice tantas copias de este archivo como el número de miembros que desee en la granja de servidores.
                            <br/><br/>
                            <b>Nota:</b> Conserve estos archivos después de la configuración, ya que se pueden volver a utilizar para actualizar los componentes de {{ site.data.keys.mf_server }} que ya se han desplegado, o para desinstalarlos de cada miembro de la granja de servidores.</li>
                            <li>Edite cada copia del archivo Ant, especifique las mismas propiedades para la base de datos que se utilizan en el paso 2, y escriba también el resto de las propiedades necesarias para el servidor de aplicaciones.
                            <br/><br/>
                            Para configurar el servidor como un miembro de la granja de servidores, establezca los valores de las siguientes propiedades:
                                <ul>
                                    <li>Establezca <b>mfp.farm.configure</b> en true.</li>
                                    <li><b>mfp.farm.server.id</b>: Un identificador que defina para este miembro de la granja de servidores. Asegúrese de que cada servidor de la granja de servidores tenga su propio identificador exclusivo. Si dos servidores de la granja de servidores tienen el mismo identificador, la granja de servidores podría comportarse de un modo imprevisible.</li>
                                    <li><b>mfp.config.service.user</b>: El nombre de usuario que se utiliza para acceder al servicio de Live Update. El nombre de usuario debe ser el mismo para todos los miembros de la granja de servidores.</li>
                                    <li><b>mfp.config.service.password</b>: La contraseña que se utiliza para acceder al servicio de Live Update. La contraseña debe ser la misma para todos los miembros de la granja de servidores.</li>
                                </ul>
                                Para habilitar el despliegue de los archivos WAR de los componentes de {{ site.data.keys.mf_server }} en el servidor, establezca los valores de las propiedades siguientes:
                                    <ul>
                                        <li>Establezca <b>mfp.process.admin</b> en <b>true</b>. Para desplegar los archivos WAR del servicio de administración y del servicio de Live Update.</li>
                                        <li>Establezca <b>mfp.process.runtime</b> en <b>true</b>. Para desplegar el archivo WAR del tiempo de ejecución.</li>
                                    </ul>
                                <br/>
                                <b>Nota:</b> Si tiene la intención de instalar más de un tiempo de ejecución en los servidores de la granja de servidores, especifique el ID de atributo y establezca un valor que debe ser exclusivo para cada tiempo de ejecución en <b>installmobilefirstruntime</b>, <b>updatemobilefirstruntime</b> y en las tareas Ant <b>uninstallmobilefirstruntime</b>.
                                <br/>
                                Por ejemplo,
{% highlight xml %}
<target name="rtminstall">
    <installmobilefirstruntime execute="true" contextroot="/runtime1" id="rtm1">
{% endhighlight %}
                            </li>
                            <li>Para cada servidor, ejecute los siguientes mandatos, donde <b>configure-appserver-database-ant-file.xml</b> se debe sustituir por el nombre de archivo Ant real que haya elegido: <code>dir_instal_mfp/shortcuts/ant -f configure-appserver-database-ant-file.xml adminstall</code> y <code>dir_instal_mfp/shortcuts/ant -f configure-appserver-database-ant-file.xml rtminstall</code>.
                            <br/><br/>
                            Estos mandatos ejecutan <b>installmobilefirstadmin</b> y las tareas Ant de <b>installmobilefirstruntime</b>. Para obtener más información sobre estas tareas, consulte <a href="../installation-reference/#ant-tasks-for-installation-of-mobilefirst-operations-console-mobilefirst-server-artifacts-mobilefirst-server-administration-and-live-update-services">Tareas Ant para la instalación de {{ site.data.keys.mf_console }}, los artefactos de {{ site.data.keys.mf_server }}, la administración de {{ site.data.keys.mf_server }} y los servicios de Live Update</a> y <a href="../installation-reference/#ant-tasks-for-installation-of-mobilefirst-runtime-environments">Tareas Ant para la instalación de entornos de ejecución de {{ site.data.keys.product_adj }}</a>.
                            </li>
                            <li>Opcionalmente, si desea instalar otro tiempo de ejecución, lleve a cabo los pasos siguientes:
                                <ul>
                                    <li>Haga una copia del archivo Ant que ha configurado en el paso 3.b.</li>
                                    <li>Edite la copia, establezca una raíz de contexto distinta y un valor para el <b>id</b> de atributo de <b>installmobilefirstruntime</b>, <b>updatemobilefirstruntime</b> y <b>uninstallmobilefirstruntime</b> que sea distinto de la otra configuración de tiempo de ejecución.</li>
                                    <li>Ejecute el siguiente mandato en cada servidor de la granja de servidores donde <b>configure-appserver-database-ant-file2.xml</b> se debe sustituir por el nombre real del archivo Ant que está editado: <code>dir_instal_mfp/shortcuts/ant -f configure-appserver-database-ant-file2.xml rtminstall</code>.</li>
                                    <li>Repita este paso para cada servidor de la granja de servidores.</li>
                                </ul>
                            </li>                            
                        </ul>
                    </li>
                    <li>Reinicie todos los servidores.</li>
                </ol>
            </div>
        </div>
    </div>
</div>

### Configuración de una granja de servidores manualmente
{: #configuring-a-server-farm-manually }
Debe configurar cada servidor de la granja de servidores según los requisitos del tipo único de servidor de aplicaciones que utiliza cada miembro de la granja de servidores.

Cuando planifique una granja de servidores, cree en primer lugar servidores autónomos que se comuniquen con la misma instancia de base de datos. A continuación, modifique la configuración de estos servidores para convertirlos en miembros de una granja de servidores.

<div class="panel-group accordion" id="configuring-manually" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="manual">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#websphere-prereq" href="#collapse-manual" aria-expanded="true" aria-controls="collapse-manual"><b>Pulse aquí para obtener instrucciones sobre cómo configurar una granja de servidores manualmente</b></a>
            </h4>
        </div>

        <div id="collapse-manual" class="panel-collapse collapse" role="tabpanel" aria-labelledby="manual">
            <div class="panel-body">
                <ol>
                    <li>Elija el tipo de servidor de aplicaciones que se utilizará para configurar los miembros de la granja de servidores. {{ site.data.keys.product }} da soporte a los siguientes servidores de aplicaciones en granjas de servidores:
                        <ul>
                            <li>Perfil completo de WebSphere Application Server<br/>
                            <b>Nota:</b> En una topología de granja de servidores, no puede utilizar el conector RMI JMX. En esta topología, sólo se da soporte al conector SOAP mediante {{ site.data.keys.product }}.</li>
                            <li>Perfil de Liberty de WebSphere Application Server</li>
                            <li>Apache Tomcat</li>
                        </ul>
                        Para saber qué versiones de los servidores de aplicaciones están soportadas, consulte <a href="../../../product-overview/requirements">Requisitos del sistema</a>.

                        <blockquote><b>Importante:</b> {{ site.data.keys.product }} sólo da soporte a granjas de servidores homogéneas. Una granja de servidores es homogénea cuando conecta el mismo tipo de servidores de aplicaciones. Intentar asociar distintos tipos de servidores de aplicaciones puede dar lugar a un comportamiento impredecible en el tiempo de ejecución. Por ejemplo, una granja de servidores con una mezcla de servidores de Apache Tomcat y servidores de perfil completo de WebSphere Application Server es una configuración no válida.</blockquote>
                    </li>
                    <li>Decida qué base de datos desea utilizar. Puede elegir entre:
                        <ul>
                            <li>DB2 </li>
                            <li>MySQL</li>
                            <li>Oracle</li>
                        </ul>
                        Las bases de datos de {{ site.data.keys.mf_server }} se comparten entre los servidores de aplicaciones de una granja de servidores, lo que significa:
                        <ul>
                            <li>Ha creado la base de datos sólo una vez, sea cual sea el número de servidores de la granja de servidores.</li>
                            <li>No puede utilizar la base de datos Derby en una topología de granja de servidores porque la base de datos Derby sólo permite una única conexión a la vez.</li>
                        </ul>
                        Para obtener más información acerca de las bases de datos, consulte <a href="../databases">Configuración de bases de datos</a>.
                    </li>
                    <li>Configure tantos servidores autónomos como el número de miembros que desee en la granja de servidores.
                        <ul>
                            <li>Cada uno de estos servidores autónomos debe comunicarse con la misma base de datos. Debe asegurarse de que cualquier puerto que utilice cualquiera de estos servidores no lo utilice también otro servidor configurado en el mismo host. Esta restricción se aplica a los puertos utilizados por los protocolos HTTP, HTTPS, REST, SOAP y RMI.</li>
                            <li>Cada uno de estos servidores debe tener el servicio de administración de {{ site.data.keys.mf_server }}, el servicio de Live Update de {{ site.data.keys.mf_server }} y uno o varios tiempos de ejecución de {{ site.data.keys.product_adj }} desplegados.</li>
                            <li>Cuando cada uno de estos servidores esté funcionando correctamente en una topología autónoma, puede transformarlos en miembros de una granja de servidores.</li>
                        </ul>
                    </li>
                    <li>Detenga todos los servidores que estén pensados para que pasen a ser miembros de la granja de servidores.</li>
                    <li>Configure cada servidor correctamente para el tipo de servidor de aplicaciones.<br/>Debe establecer algunas propiedades JNDI correctamente. En una topología de granja de servidores, las propiedades JNDI mfp.config.service.user y mfp.config.service.password deben tener el mismo valor para todos los miembros de la granja de servidores. Para Apache Tomcat, también debe comprobar que los argumentos JVM estén correctamente definidos.
                        <ul>
                            <li><b>Perfil de Liberty de WebSphere Application Server</b>
                                <br/>
                                En el archivo server.xml, establezca las propiedades JNDI tal como se muestran en el siguiente código de ejemplo.
{% highlight xml %}
<jndiEntry jndiName="mfp.topology.clustermode" value="Farm"/>
<jndiEntry jndiName="mfp.admin.serverid" value="farm_member_1"/>
<jndiEntry jndiName="mfp.admin.jmx.user" value="myRESTConnectorUser"/>
<jndiEntry jndiName="mfp.admin.jmx.pwd" value="password-of-rest-connector-user"/>
<jndiEntry jndiName="mfp.admin.jmx.host" value="93.12.0.12"/>
<jndiEntry jndiName="mfp.admin.jmx.port" value="9443"/>
{% endhighlight %}
                                Estas propiedades deben establecerse con valores adecuados:
                                <ul>
                                    <li><b>mfp.admin.serverid</b>: El identificador que ha definido para este miembro de la granja de servidores. Este identificador debe ser exclusivo en todos los miembros de la granja de servidores.</li>
                                    <li><b>mfp.admin.jmx.user</b> y <b>mfp.admin.jmx.pwd</b>: Estos valores deben coincidir con las credenciales de un usuario, tal como está declarado en el elemento <code>administrator-role</code>.</li>
                                    <li><b>mfp.admin.jmx.host</b>: Establezca este parámetro en el IP o en el nombre de host que utilicen miembros remotos para acceder a este servidor. Por lo tanto, no lo establezca en <b>localhost</b>. Este nombre de host lo utilizan otros miembros de la granja de servidores y debe estar accesible para todos los miembros de la granja de servidores.</li>
                                    <li><b>mfp.admin.jmx.port</b>: Establezca este parámetro en el puerto HTTPS del servidor que se utiliza para la conexión JMX REST. Puede encontrar el valor en el elemento <code>httpEndpoint</code> del archivo <b>server.xml</b>.</li>
                                </ul>
                            </li>
                            <li><b>Apache Tomcat</b>
                                <br/>
                                Modifique el archivo <b>conf/server.xml</b> para establecer las siguientes propiedades JNDI en el contexto del servicio de administración y en cada contexto de tiempo de ejecución.
{% highlight xml %}
<Environment name="mfp.topology.clustermode" value="Farm" type="java.lang.String" override="false"/>
<Environment name="mfp.admin.serverid" value="farm_member_1" type="java.lang.String" override="false"/>
{% endhighlight %}
                                La propiedad <b>mfp.admin.serverid</b> se debe establecer en el identificador definido para este miembro de la granja de servidores. Este identificador debe ser exclusivo en todos los miembros de la granja de servidores.
                                <br/>
                                Debe asegurarse de que el argumento JVM <code>-Djava.rmi.server.hostname</code> esté establecido en el IP o en el nombre de host utilizado por los miembros remotos para acceder a este servidor. Por lo tanto, no lo establezca en <b>localhost</b>. Además, debe asegurarse de que el argumento JVM <code>-Dcom.sun.management.jmxremote.port</code> se establezca con un puerto que aún no esté en uso para habilitar las conexiones JMX RMI. Ambos argumentos se establecen en la variable de entorno <b>CATALINA_OPTS</b>.
                            </li>
                            <li><b>Perfil completo de WebSphere Application Server</b>
                                <br/>
                                Debe declarar las siguientes propiedades JNDI en el servicio de administración y en cada aplicación de ejecución desplegada en el servidor.
                                <ul>
                                    <li><b>mfp.topology.clustermode</b></li>
                                    <li><b>mfp.admin.serverid</b></li>
                                </ul>
                                En la consola de WebSphere Application Server,
                                <ul>
                                    <li>seleccione <b>Aplicaciones → Tipos de aplicaciones → Aplicaciones empresariales de WebSphere</b>.</li>
                                    <li>Seleccione la aplicación del servicio de administración.</li>
                                    <li>En <b>Propiedades de módulo web</b>, pulse <b>Entradas de entorno para módulos web</b> para visualizar las propiedades de JNDI.</li>
                                    <li>Establezca los valores de las siguientes propiedades.
                                        <ul>
                                            <li>Establezca <b>mfp.topology.clustermode</b> en <b>Farm</b>.</li>
                                            <li>Establezca <b>mfp.admin.serverid</b> en el identificador que ha elegido para este miembro de la granja de servidores. Este identificador debe ser exclusivo en todos los miembros de la granja de servidores.</li>
                                            <li>Establezca <b>mfp.admin.jmx.user</b> en un nombre de usuario que tenga acceso al conector SOAP.</li>
                                            <li>Establezca <b>mfp.admin.jmx.pwd</b> en la contraseña del usuario, tal como se declara en <b>mfp.admin.jmx.user</b>.</li>
                                            <li>Establezca <b>mfp.admin.jmx.port</b> en el valor del puerto SOAP.</li>
                                        </ul>
                                    </li>
                                    <li>Verifique que <b>mfp.admin.jmx.connector</b> esté establecido en <b>SOAP</b>.</li>
                                    <li>Pulse <b>Aceptar</b> y guarde la configuración.</li>
                                    <li>Realice cambios similares para cada aplicación de ejecución de {{ site.data.keys.product_adj }} desplegada en el servidor.</li>
                                </ul>
                            </li>
                        </ul>
                    </li>
                    <li>Intercambie los certificados de servidor en sus almacenes de confianza entre todos los miembros de la granja de servidores. Intercambiar los certificados de servidor en sus almacenes de confianza es obligatorio para granjas de servidores que utilizan el perfil completo de WebSphere Application Server y el perfil de WebSphere Application Server Liberty ya que, en estos conjuntos de servidores, las comunicaciones entre los servidores están protegidas por SSL.
                        <ul>
                            <li><b>Perfil de Liberty de WebSphere Application Server</b>
                                <br/>
                                Puede configurar el almacén de confianza mediante programas de utilidad de IBM como Keytool o iKeyman.
                                <ul>
                                    <li>Para obtener más información sobre Keytool, consulte <a href="http://www-01.ibm.com/support/knowledgecenter/?lang=en#!/SSYKE2_6.0.0/com.ibm.java.security.component.60.doc/security-component/keytoolDocs/keytool_overview.html">Keytool</a> en IBM SDK, Java Technology Edition.</li>
                                    <li>Para obtener más información sobre iKeyman, consulte <a href="http://www-01.ibm.com/support/knowledgecenter/?lang=en#!/SSYKE2_6.0.0/com.ibm.java.security.component.60.doc/security-component/ikeyman_tool.html">iKeyman</a> en IBM SDK, Java Technology Edition.</li>
                                </ul>
                                Las ubicaciones del almacén de claves y del almacén de confianza están definidas en el archivo <b>server.xml</b>. Consulte los atributos <b>keyStoreRef</b> y <b>trustStoreRef</b> en <a href="http://www.ibm.com/support/knowledgecenter/SSD28V_8.5.5/com.ibm.websphere.wlp.core.doc/ae/rwlp_ssl.html?lang=en&view=kc">Atributos de configuración de SSL</a>. De forma predeterminada, el almacén de claves del perfil de Liberty se encuentra en <b>${server.config.dir}/resources/security/key.jks</b>. Si falta la referencia del almacén de confianza o no está definida en el archivo <b>server.xml</b>, se utilizará el almacén de claves especificado por <b>keyStoreRef</b>. El servidor utiliza el almacén de claves predeterminado y el archivo se creará la primera vez que se ejecute el servidor. En tal caso, se creará un certificado predeterminado con un periodo de validez de 365 días. Para producción, es posible que considere la posibilidad de utilizar su propio certificado (incluidos los intermedios, si es necesario) o de cambiar la fecha de caducidad del certificado generado.

                                <blockquote>Nota: Si desea confirmar la ubicación del almacén de confianza, puede hacerlo añadiendo la siguiente declaración al archivo server.xml:
{% highlight xml %}
<logging traceSpecification="SSL=all:SSLChannel=all"/>
{% endhighlight %}
                                </blockquote>
                                Por último, inicie el servidor y busque las líneas que contienen com.ibm.ssl.trustStore en el archivo <b>${wlp.install.dir}/usr/servers/server_name/logs/trace.log</b>.
                                <ul>
                                    <li>Importe los certificados públicos del resto de servidores de la granja de servidores en el almacén de confianza al que se hace referencia mediante el archivo de configuración <b>server.xml</b> del servidor. La guía de aprendizaje <a href="../tutorials/graphical-mode">Instalación de {{ site.data.keys.mf_server }} en modalidad gráfica</a> proporciona las instrucciones para intercambiar los certificados entre dos servidores de Liberty de una granja de servidores. Para obtener más información, consulte el paso 5 de la sección <a href="../tutorials/graphical-mode/#creating-a-farm-of-two-liberty-servers-that-run-mobilefirst-server">Creación de una granja de servidores de dos servidores de Liberty que ejecutan {{ site.data.keys.mf_server }}</a>.</li>
                                    <li>Reinicie cada instancia del perfil de WebSphere Application Server Liberty para que surta efecto la configuración de seguridad. Los pasos siguientes son necesarios para que funcione el inicio de sesión único (SSO).</li>
                                    <li>Inicie un miembro de la granja de servidores. En la configuración de LTPA predeterminada, una vez que el servidor de Liberty se inicie correctamente, generará un almacén de claves de LTPA como <b>${wlp.user.dir}/servers/server_name/resources/security/ltpa.keys.</b></li>
                                    <li>Copie el archivo <b>ltpa.keys</b> al directorio <b>${wlp.user.dir}/servers/server_name/resources/security</b> de cada miembro de la granja de servidores para replicar los almacenes de claves de LTPA entre los miembros de la granja de servidores. Para obtener más información sobre la configuración de LTPA, consulte <a href="http://www.ibm.com/support/knowledgecenter/?view=kc#!/SSAW57_8.5.5/com.ibm.websphere.wlp.nd.multiplatform.doc/ae/twlp_sec_ltpa.html">Configuración de LTPA en el perfil de Liberty</a>.</li>
                                </ul>
                            </li>
                            <li><b>Perfil completo de WebSphere Application Server</b>
                                <br/>
                                Configure el almacén de confianza en la consola de administración de WebSphere Application Server.
                                <ul>
                                    <li>Inicie sesión en la consola de administración de WebSphere Application Server.</li>
                                    <li>Seleccione <b>Seguridad → Certificado SSL y gestión de claves</b>.</li>
                                    <li>En <b>Elementos relacionados</b>, seleccione <b>Almacenes de claves y certificados</b>.</li>
                                    <li>En el campo <b>Usos del almacén de claves</b>, asegúrese de que <b>Almacenes de claves de SSL</b> esté seleccionado. Ahora puede importar los certificados desde el resto de los servidores de la granja de servidores.</li>
                                    <li>Pulse <b>NodeDefaultTrustStore</b>.</li>
                                    <li>En <b>Propiedades adicionales</b>, seleccione <b>Certificados de firmante</b>.</li>
                                    <li>Pulse <b>Recuperar de puerto</b>. Ahora puede especificar la comunicación y los detalles de seguridad de cada uno del resto de los servidores de la granja de servidores. Siga los pasos siguientes para cada uno del resto de los miembros de la granja de servidores.</li>
                                    <li>En el campo <b>Host</b>, especifique el nombre de host de servidor o la dirección IP.</li>
                                    <li>En el campo <b>Puerto</b>, especifique el puerto de transporte de HTTPS (SSL).</li>
                                    <li>En <b>Configuración de SSL para la conexión saliente</b>, seleccione <b>NodeDefaultSSLSettings</b>.</li>
                                    <li>En el campo <b>Alias</b>, especifique un alias para este certificado de firmante.</li>
                                    <li>Pulse <b>Recuperar información de firmante</b>.</li>
                                    <li>Revise la información recuperada del servidor remoto y, a continuación, pulse <b>Aceptar</b>.</li>
                                    <li>Pulse <b>Guardar</b>.</li>
                                    <li>Reinicie el servidor.</li>
                                </ul>    
                            </li>
                        </ul>
                    </li>
                </ol>
            </div>
        </div>
    </div>
</div>

### Verificación de una configuración en una granja de servidores
{: #verifying-a-farm-configuration }
La finalidad de esta tarea es comprobar el estado de los miembros de la granja de servidores y verificar si una granja de servidores está configurado correctamente.

1. Inicie todos los servidores de la granja de servidores.
2. Acceda a {{ site.data.keys.mf_console }}. Por ejemplo, **http://server_name:port/mfpconsole**, o **https://hostname:secure_port/mfpconsole** en HTTPS.
    En la barra lateral de la consola, aparecerá un menú adicional etiquetado como Nodos de la granja de servidores.
3. Pulse **Nodos de la granja de servidores** para acceder a la lista de miembros de la granja de servidores registrados y a su estado. En el ejemplo siguiente, el nodo identificado como **FarmMember2** se considera que está inactivo, lo que indica que este servidor probablemente ha fallado y requiere un poco de mantenimiento.

![Estado de nodos de granja de servidores en {{ site.data.keys.mf_console }}](farm_nodes_status_list.jpg)

### Ciclo de vida de un nodo de granja de servidores
{: #lifecycle-of-a-server-farm-node }
Puede configurar la tasa de latido y los valores de tiempo de espera para indicar posibles problemas del servidor entre miembros de la granja de servidores desencadenando un cambio en el estado de un nodo afectado.

#### Registro y supervisión de servidores como nodos de la granja de servidores
{: #registration-and-monitoring-servers-as-farm-nodes }
Cuando se haya iniciado un servidor configurado como un nodo de granja de servidores, el servicio de administración de dicho servidor lo registra automáticamente como un nuevo miembro de la granja de servidores.
Cuando se cierra un miembro de la granja de servidores, se elimina automáticamente de la granja de servidores.

Existe un mecanismo de latido para realizar el seguimiento de los miembros de la granja de servidores que puede que se queden sin responder, por ejemplo, debido a un corte de electricidad o a un fallo del servidor. En este mecanismo de latido, los tiempos de ejecución de {{ site.data.keys.product_adj }} envían periódicamente un latido a los servicios de administración de {{ site.data.keys.product_adj }} a una velocidad especificada. Si el servicio de administración de {{ site.data.keys.product_adj }} registra que ha pasado demasiado tiempo desde que un miembro de la granja de servidores haya enviado un latido, se considerará que el miembro de la granja de servidores está desactivado.

Los miembros de la granja de servidores que se consideran como desactivados no sirven ninguna solicitud más a aplicaciones móviles.

Tener uno o varios nodos no impide que el resto de los miembros de la granja de servidores sirvan solicitudes correctamente a aplicaciones móviles ni que acepten nuevas operaciones de gestión desencadenadas mediante la {{ site.data.keys.mf_console }}.

#### Configuración de la tasa de latido y de los valores de tiempo de espera
{: #configuring-the-heartbeat-rate-and-timeout-values }
Puede configurar la tasa de latido y los valores de tiempo de espera definiendo las siguientes propiedades JNDI:

* **mfp.admin.farm.heartbeat**
* **mfp.admin.farm.missed.heartbeats.timeout**

<br/>
Para obtener más información sobre propiedades JNDI, consulte [Lista de propiedades JNDI para el servicio de administración de {{ site.data.keys.mf_server }}](../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service).
