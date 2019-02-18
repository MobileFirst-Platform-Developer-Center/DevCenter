---
layout: tutorial
title: Configuración de MobileFirst Server en IBM Cloud con scripts para Liberty for Java
breadcrumb_title: Foundation on Liberty for Java
relevantTo: [ios,android,windows,javascript]
weight: 7
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
Siga las instrucciones siguientes para configurar una instancia de {{ site.data.keys.mf_server }} en un tiempo de ejecución de Liberty for Java en IBM Cloud. <!--({{ site.data.keys.mf_analytics }} instances can be run on IBM containers only.)--> Para llevarlo a cabo, realice los pasos siguientes:

* Configure su sistema host con las herramientas necesarias (Cloud Foundry CLI)
* Configure su cuenta de IBM Cloud
* Cree un {{ site.data.keys.mf_server }} y envíelo mediante push a IBM Cloud como una aplicación Cloud Foundry.

Finalmente, registrará sus aplicaciones móviles y también desplegará sus adaptadores.

**Notas:**  

* Actualmente el sistema operativo Windows no está soportado para ejecutar estos scripts.  
* Las herramientas de configuración de {{ site.data.keys.mf_server }} no se pueden utilizar para despliegues en IBM Cloud.

#### Ir a:
{: #jump-to }

* [Registrar una cuenta en IBM Cloud](#register-an-account-at-ibmcloud)
* [Configurar la máquina host](#set-up-your-host-machine)
* [Descargar el archivo {{ site.data.keys.mf_bm_pkg_name }}](#download-the-ibm-mfpf-container-8000-archive)
* [Añadir información de Analytics Server](#adding-analytics-server-configuration-to-mobilefirst-server)
* [Aplicar arreglos de {{ site.data.keys.mf_server }}](#applying-mobilefirst-server-fixes)
* [Eliminar la configuración del servicio de base de datos de IBM Cloud](#removing-the-database-service-configuration-from-ibmcloud)

## Registrar una cuenta en IBM Cloud
{: #register-an-account-at-ibmcloud }
Si todavía no tiene una cuenta, vaya al [sitio web de IBM Cloud](https://bluemix.net) y pulse **Iniciación gratuita** o **Iniciar sesión**. Debe rellenar un formulario de registro para ir al paso siguiente.

### Panel de control de IBM Cloud
{: #the-ibmcloud-dashboard }
Después de iniciar sesión en IBM Cloud, se le presentará el panel de control de IBM Cloud, que proporciona una visión general del **espacio** activo de IBM Cloud. De forma predeterminada, esta área de trabajo recibe el nombre de "dev". Puede crear varios espacios o áreas de trabajo, si es necesario.

## Configurar la máquina host
{: #set-up-your-host-machine }
Para gestionar la app IBM Cloud Cloud Foundry, debe instalar Cloud Foundry CLI.  
Puede ejecutar los scripts utilizando Terminal.app de macOS o un shell bash de Linux.

Instale [Cloud Foundry CLI](https://github.com/cloudfoundry/cli/releases?cm_mc_uid=85906649576514533887001&cm_mc_sid_50200000=1454307195).

## Descargar el archivo {{ site.data.keys.mf_bm_pkg_name }}
{: #download-the-ibm-mfpf-container-8000-archive}
Para configurar {{ site.data.keys.product }} en Liberty para Java, en primer lugar, cree un diseño de archivo que se enviará mediante push a IBM Cloud.  
<a href="http://www-01.ibm.com/support/docview.wss?uid=swg2C7000005" target="blank">Siga las instrucciones de esta página</a> para descargar el archivo de {{ site.data.keys.mf_server }} 8.0 for IBM Containers (archivo .zip, busque: *CNBL0EN*).

El archivo comprimido contiene los archivos para crear un diseño de archivo (**dependencies** y **mfpf-libs**), los archivos para compilar y desplegar {{ site.data.keys.mf_analytics }} Container (**mfpf-analytics**) y los archivos para configurar una aplicación {{ site.data.keys.mf_server }} Cloud Foundry (**mfpf-server-libertyapp**).

<div class="panel-group accordion" id="terminology" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="zip-file">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#zip-file" data-target="#collapse-zip-file" aria-expanded="false"><b>Pulse para obtener más información sobre el contenido de los archivos comprimidos</b></a>
            </h4>
        </div>

        <div id="collapse-zip-file" class="panel-collapse collapse" role="tabpanel" aria-labelledby="zip-file">
            <div class="panel-body">
                <img src="zip.png" alt="Imagen que muestra la estructura del sistema de archivos del archivo comprimido" style="float:right;width:570px"/>
                <h4>carpeta dependencies</h4>
                <p>Contiene el tiempo de ejecución de {{ site.data.keys.product }} junto con IBM Java JRE 8.</p>

                <h4>carpeta mfpf-libs</h4>
                <p>Contiene las bibliotecas de componentes del producto {{ site.data.keys.product_adj }} y CLI.</p>

                <h4>carpeta mfpf-server-libertyapp</h4>

                <ul>

                    <li>Carpeta <b>scripts</b>: Esta carpeta contiene la carpeta <b>args</b> que incluye un conjunto de archivos de configuración. También contiene scripts que se pueden ejecutar para iniciar sesión en IBM Cloud, crear una aplicación {{ site.data.keys.product }} para enviarla por push a IBM Cloud y ejecutar el servidor en IBM Cloud. Puede optar por ejecutar los scripts de forma interactiva o configurar previamente los archivos de configuración como se describe detalladamente más adelante. Aparte de los archivos args/*.properties personalizables, no modifique ningún elemento de esta carpeta. Para obtener ayuda sobre el uso de scripts, utilice los argumentos de línea de mandatos <code>-h</code> o <code>--help</code>, por ejemplo, <code>scriptname.sh --help</code>.</li>
                    <li>carpeta <b>usr</b>:
                        <ul>
                            <li>Carpeta <b>config</b>: Contiene los fragmentos de configuración del servidor (almacén de claves, propiedades del servidor, registro de usuarios) que utiliza {{ site.data.keys.mf_server }}.</li>
                            <li><b>keystore.xml</b> - la configuración del repositorio de los certificados de seguridad que se utilizan para el cifrado SSL. Debe hacerse referencia a los archivos listados en la carpeta ./usr/security.</li>
                            <li><b>mfpfproperties.xml</b> - propiedades de configuración para {{ site.data.keys.mf_server }}. Consulte las propiedades soportadas en estos temas de la documentación:
                                <ul>
                                <li><a href="../../installation-configuration/production/server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service">Lista de propiedades de JNDI para el servicio de administración de {{ site.data.keys.mf_server }}</a></li>
                                    <li><a href="../../installation-configuration/production/server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime">Lista de propiedades de JNDI para el tiempo de ejecución de {{ site.data.keys.product_adj }}</a></li>
                                </ul>
                            </li>
                            <li><b>registry.xml</b> - configuración del registro de usuarios. La configuración de basicRegistry (de forma predeterminada, se proporciona una configuración de registro de usuarios básico basado en XML). Se pueden configurar los nombres de usuarios y las contraseñas para basicRegistry o puede configurar ldapRegistry.</li>
                        </ul>
                    </li>
                    <li>Carpeta <b>env</b>: Contiene las propiedades del entorno que se utilizan para la inicialización del servidor (server.env) y las opciones de JVM personalizadas (jvm.options).
                    <br/>
                    </li>

                    <li>Carpeta <b>security</b>: Se utiliza para los archivos del almacén de claves, el almacén de confianza y las claves LTPA (ltpa.keys).</li>

                </ul>
				<br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#zip-file" data-target="#collapse-zip-file" aria-expanded="false" aria-controls="collapse-zip-file"><b>Cerrar sección</b></a>
            </div>
        </div>
    </div>
</div>


## Configuración de {{ site.data.keys.mf_server }} y de {{ site.data.keys.mf_app_center }}
{: #setting-up-the-mobilefirst-server }
Puede optar por ejecutar los scripts de forma interactiva o utilizar los archivos de configuración: Un buen punto de partida es ejecutar los scripts de forma interactiva una vez, lo que además registrará los argumentos (**recorded-args**). Posteriormente puede utilizar los archivos args para ejecutar los scripts en modo no interactivo.

> **Nota:** Las contraseñas no se registran y tendrá que añadir manualmente las contraseñas a los archivos de argumentos.

* Utilización de los archivos de configuración: Ejecute los scripts y pase el archivo de configuración respectivo como un argumento.
* Interactivamente: Ejecute los scripts sin argumentos.

Si opta por ejecutar los scripts de forma interactiva, puede omitir el paso de configuración pero se le recomienda que, como mínimo, lea y comprenda los argumentos que deberá proporcionar.


### {{ site.data.keys.mf_app_center }}
{: #mobilefirst-appcenter }

>**Nota:** Puede descargar los instaladores y las herramientas de base de datos desde las carpetas de instalación de {{ site.data.keys.mf_app_center }} locales (las carpetas `installer` y `tools`).

<div class="panel-group accordion" id="scripts2" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="step-foundation-1">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#scripts2" data-target="#collapse-step-appcenter-1" aria-expanded="false" aria-controls="collapse-step-appcenter-1">Utilización de los archivos de configuración</a>
            </h4>
        </div>

        <div id="collapse-step-appcenter-1" class="panel-collapse collapse" role="tabpanel">
            <div class="panel-body">
            La carpeta <b>args</b> contiene un conjunto de archivos de configuración que contiene los argumentos necesarios para ejecutar los scripts. Puede buscar los archivos de plantilla vacíos y la descripción de los argumentos en la carpeta <b>args</b> o, después de ejecutar los scripts de forma interactiva, en la carpeta <b>recorded-args</b>. Los siguientes son los archivos:<br/>

              <h4>initenv.properties</h4>
              Este archivo contiene propiedades que se utilizan para inicializar el entorno.
              <h4>prepareappcenterdbs.properties</h4>
              {{ site.data.keys.mf_app_center }} requiere una <a href="https://console.bluemix.net/catalog/services/dashdb/" target="\_blank">instancia de base de datos de dashDB Enterprise Transactional</a> (Cualquier plan marcado como OLTP o Transactional).<br/>
              <b>Nota:</b> El despliegue de los planes dashDB Enterprise Transactional es inmediato para los planes marcados como "pago por uso". Asegúrese de que selecciona uno de los planes adecuados, como <i>Enterprise for Transactions High Availability 2.8.500 (Pago por uso)</i> <br/><br/>
              Después de configurar la instancia de dashDB, proporcione los argumentos necesarios.

              <h4>prepareappcenter.properties</h4>
              Este archivo se utiliza para el script prepareappcenter.sh. Esto prepara el diseño de archivos de {{ site.data.keys.mf_app_center_short }} y lo transfiere mediante push a IBM Cloud como una aplicación Cloud Foundry.
              <h4>startappcenter.properties</h4>
              Este archivo configura los atributos de tiempo de ejecución del servidor y lo inicia. Se recomienda utilizar un mínimo de 1024 MB (<b>SERVER_MEM=1024</b>) y 3 nodos para alta disponibilidad (<b>INSTANCES=3</b>)

            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="step-appcenter-2">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#scripts2" data-target="#collapse-step-appcenter-2" aria-expanded="false" aria-controls="collapse-step-appcenter-2">Ejecución de los scripts</a>
            </h4>
        </div>

        <div id="collapse-step-appcenter-2" class="panel-collapse collapse" role="tabpanel">
            <div class="panel-body">
              <p>Las siguientes instrucciones muestran cómo ejecutar los scripts utilizando los archivos de configuración. También está disponible una lista de argumentos de línea de mandatos, si opta por ejecutarlos fuera del modo interactivo:</p>
              <ol>
                  <li><b>initenv.sh – Inicio de sesión en IBM Cloud </b><br />
                      Ejecute el script <b>initenv.sh</b> para iniciar sesión en IBM Cloud. Ejecútelo para la organización y espacio, cuando el servicio dashDB esté enlazado:
{% highlight bash %}
./initenv.sh args/initenv.properties
{% endhighlight %}

                        También puede pasar los parámetros en la línea de mandatos

{% highlight bash %}
initenv.sh --user IBM_Cloud_user_ID --password IBM_Cloud_password --org IBM_Cloud_organization_name --space IBM_Cloud_space_name
{% endhighlight %}

                        Para obtener información acerca de todos los parámetros soportados y su documentación, ejecute la opción help

{% highlight bash %}
./initenv.sh --help
{% endhighlight %}
                  </li>
                  <li><b>prepareappcenterdbs.sh - Prepare la base de datos de {{ site.data.keys.mf_app_center }} </b><br />
                  El script <b>prepareappcenterdbs.sh</b> se utiliza para configurar {{ site.data.keys.mf_app_center }} con el servicio de base de datos dashDB o un servidor de base de datos DB2 accesible. La opción de DB2 se puede utilizar especialmente cuando ejecuta IBM Cloud local en el mismo centro de datos en el que está instalado el servidor de DB2. Si utiliza el servicio dashDB, la instancia de servicio de dashDB debe estar disponible en la organización y el espacio en el que ha iniciado sesión en el paso 1. Ejecute lo siguiente:
{% highlight bash %}
./prepareappcenterdbs.sh args/prepareappcenterdbs.properties
{% endhighlight %}

                        También puede pasar los parámetros en la línea de mandatos

{% highlight bash %}
prepareappcenterdbs.sh --acdb MFPAppCenterDashDBService
{% endhighlight %}

                        Para obtener información acerca de todos los parámetros soportados y su documentación, ejecute la opción help

{% highlight bash %}
./prepareappcenterdbs.sh --help
{% endhighlight %}

                  </li>
                  <li><b>initenv.sh (Opcional) – Inicio de sesión en IBM Cloud </b><br />
                      Este paso solo es necesario si necesita crear su servidor en una organización y espacio diferentes a aquellos en los que está disponible la instancia de servicio de dashDB. Si es así, actualice initenv.properties con la nueva organización y espacio en que se han creado los contenedores (y se han iniciado), y vuelva a ejecutar el script <b>initenv.sh</b>:
{% highlight bash %}
./initenv.sh args/initenv.properties
{% endhighlight %}
                  </li>
                  <li><b>prepareappcenter.sh - Prepare {{ site.data.keys.mf_app_center }}</b><br />
                    Ejecute el script <b>prepareappcenter.sh</b> para crear un {{ site.data.keys.mf_app_center }} y enviarlo mediante push a IBM Cloud como una aplicación Cloud Foundry. Para ver todas las aplicaciones de Cloud Foundry y sus URL de la organización y espacio de inicio de sesión, ejecute: <code>cf apps</code><br/>


{% highlight bash %}
./prepareappcenter.sh args/prepareappcenter.properties
{% endhighlight %}

                        También puede pasar los parámetros en la línea de mandatos

{% highlight bash %}
prepareappcenter.sh --name APP_NAME
{% endhighlight %}

                        Para obtener información acerca de todos los parámetros soportados y su documentación, ejecute la opción help

{% highlight bash %}
./prepareappcenter.sh --help
{% endhighlight %}                  

                  </li>
                  <li><b>startappcenter.sh - Inicio de {{ site.data.keys.mf_app_center }}</b><br />
                  El script <b>startappcenter.sh</b> se utiliza para iniciar {{ site.data.keys.mf_app_center }} en la aplicación Liberty for Java Cloud Foundry. Ejecute:<p/>
{% highlight bash %}
./startappcenter.sh args/startappcenter.properties
{% endhighlight %}

                        También puede pasar los parámetros en la línea de mandatos

{% highlight bash %}
./startappcenter.sh --name APP_NAME
{% endhighlight %}

                        Para obtener información acerca de todos los parámetros soportados y su documentación, ejecute la opción help

{% highlight bash %}
./startappcenter.sh --help
{% endhighlight %}   

                  </li>
              </ol>
            </div>
        </div>
    </div>
</div>
Inicie la consola de {{ site.data.keys.mf_app_center }} cargando el URL siguiente: `http://APP_HOST.mybluemix.net/appcenterconsole` (puede tardar unos minutos).   

Ahora, con {{ site.data.keys.mf_app_center }} ejecutándose en IBM Cloud, puede subir sus aplicaciones móviles al centro de aplicaciones.


### {{ site.data.keys.mf_server }}
{: #mobilefirst-server }
<div class="panel-group accordion" id="scripts2-mf" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="step-foundation-1-mf">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#scripts2-mf" data-target="#collapse-step-foundation-1-mf" aria-expanded="false" aria-controls="collapse-step-foundation-1-mf">Utilización de los archivos de configuración</a>
            </h4>
        </div>

        <div id="collapse-step-foundation-1-mf" class="panel-collapse collapse" role="tabpanel">
            <div class="panel-body">
            La carpeta <b>args</b> contiene un conjunto de archivos de configuración que contiene los argumentos necesarios para ejecutar los scripts. Puede buscar los archivos de plantilla vacíos y la descripción de los argumentos en la carpeta <b>args</b> o, después de ejecutar los scripts de forma interactiva, en la carpeta <b>recorded-args</b>. Los siguientes son los archivos:<br/>

              <h4>initenv.properties</h4>
              Este archivo contiene propiedades que se utilizan para inicializar el entorno.
              <h4>prepareserverdbs.properties</h4>
              El servicio de {{ site.data.keys.mf_bm_short }} requiere una <a href="https://console.ng.bluemix.net/catalog/services/dashdb/" target="\_blank">instancia de base de datos de dashDB Enterprise Transactional</a> (Cualquier plan marcado como OLTP o Transactional).<br/>
              <b>Nota:</b> El despliegue de los planes dashDB Enterprise Transactional es inmediato para los planes marcados como "pago por uso". Asegúrese de que selecciona uno de los planes adecuados, como <i>Enterprise for Transactions High Availability 2.8.500 (Pago por uso)</i> <br/><br/>
              Después de configurar la instancia de dashDB, proporcione los argumentos necesarios.

              <h4>prepareserver.properties</h4>
              Este archivo se utiliza para el script prepareserver.sh. Esto prepara el diseño de archivos y lo transfiere mediante push a IBM Cloud como una aplicación Cloud Foundry.
              <h4>startserver.properties</h4>
              Este archivo configura los atributos de tiempo de ejecución del servidor y lo inicia. Se recomienda utilizar un mínimo de 1024 MB (<b>SERVER_MEM=1024</b>) y 3 nodos para alta disponibilidad (<b>INSTANCES=3</b>)

            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="step-foundation-2">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#scripts2-mf" data-target="#collapse-step-foundation-2" aria-expanded="false" aria-controls="collapse-step-foundation-2">Ejecución de los scripts</a>
            </h4>
        </div>

        <div id="collapse-step-foundation-2" class="panel-collapse collapse" role="tabpanel">
            <div class="panel-body">
              <p>Las siguientes instrucciones muestran cómo ejecutar los scripts utilizando los archivos de configuración. También está disponible una lista de argumentos de línea de mandatos, si opta por ejecutarlos fuera del modo interactivo:</p>
              <ol>
                  <li><b>initenv.sh – Inicio de sesión en IBM Cloud </b><br />
                      Ejecute el script <b>initenv.sh</b> para iniciar sesión en IBM Cloud. Ejecútelo para la organización y espacio, cuando el servicio dashDB esté enlazado:
{% highlight bash %}
./initenv.sh args/initenv.properties
{% endhighlight %}

                        También puede pasar los parámetros en la línea de mandatos

{% highlight bash %}
initenv.sh --user IBM_Cloud_user_ID --password IBM_Cloud_password --org IBM_Cloud_organization_name --space IBM_Cloud_space_name
{% endhighlight %}

                        Para obtener información acerca de todos los parámetros soportados y su documentación, ejecute la opción help

{% highlight bash %}
./initenv.sh --help
{% endhighlight %}
                  </li>
                  <li><b>prepareserverdbs.sh - Prepare la base de datos de {{ site.data.keys.mf_server }}</b><br />
                  El script <b>prepareserverdbs.sh</b> se utiliza para configurar {{ site.data.keys.mf_server }} con el servicio de base de datos dashDB o un servidor de base de datos DB2 accesible. La opción de DB2 se puede utilizar especialmente cuando ejecuta IBM Cloud local en el mismo centro de datos en el que está instalado el servidor de DB2. Si utiliza el servicio dashDB, la instancia de servicio de dashDB debe estar disponible en la organización y el espacio en el que ha iniciado sesión en el paso 1. Ejecute lo siguiente:
{% highlight bash %}
./prepareserverdbs.sh args/prepareserverdbs.properties
{% endhighlight %}

                        También puede pasar los parámetros en la línea de mandatos

{% highlight bash %}
prepareserverdbs.sh --admindb MFPDashDBService
{% endhighlight %}

                        Para obtener información acerca de todos los parámetros soportados y su documentación, ejecute la opción help

{% highlight bash %}
./prepareserverdbs.sh --help
{% endhighlight %}

                  </li>
                  <li><b>initenv.sh (Opcional) – Inicio de sesión en IBM Cloud </b><br />
                      Este paso solo es necesario si necesita crear su servidor en una organización y espacio diferentes a aquellos en los que está disponible la instancia de servicio de dashDB. Si es así, actualice initenv.properties con la nueva organización y espacio en que se han creado los contenedores (y se han iniciado), y vuelva a ejecutar el script <b>initenv.sh</b>:
{% highlight bash %}
./initenv.sh args/initenv.properties
{% endhighlight %}
                  </li>
                  <li><b>prepareserver.sh - Preparar {{ site.data.keys.mf_server }}</b><br />
                    Ejecute el script <b>prepareserver.sh</b> para crear un {{ site.data.keys.mf_server }} y enviarlo mediante push a IBM Cloud como una aplicación Cloud Foundry. Para ver todas las aplicaciones de Cloud Foundry y sus URL de la organización y espacio de inicio de sesión, ejecute: <code>cf apps</code><br/>


{% highlight bash %}
./prepareserver.sh args/prepareserver.properties
{% endhighlight %}

                        También puede pasar los parámetros en la línea de mandatos

{% highlight bash %}
prepareserver.sh --name APP_NAME
{% endhighlight %}

                        Para obtener información acerca de todos los parámetros soportados y su documentación, ejecute la opción help

{% highlight bash %}
./prepareserver.sh --help
{% endhighlight %}                  

                  </li>
                  <li><b>startserver.sh - Inicio del servidor</b><br />
                  El script <b>startserver.sh</b> se utiliza para iniciar {{ site.data.keys.mf_server }} en la aplicación Liberty for Java Cloud Foundry. Ejecute:<p/>
{% highlight bash %}
./startserver.sh args/startserver.properties
{% endhighlight %}

                        También puede pasar los parámetros en la línea de mandatos

{% highlight bash %}
./startserver.sh --name APP_NAME
{% endhighlight %}

                        Para obtener información acerca de todos los parámetros soportados y su documentación, ejecute la opción help

{% highlight bash %}
./startserver.sh --help
{% endhighlight %}   

                  </li>
              </ol>
            </div>
        </div>
    </div>
</div>


Inicie {{ site.data.keys.mf_console }} cargando el URL siguiente: `http://APP_HOST.mybluemix.net/mfpconsole` (puede tardar unos minutos).  
Añada el servidor remoto siguiendo las instrucciones de la guía de aprendizaje [Utilización de {{ site.data.keys.mf_cli }} para gestionar artefactos de {{ site.data.keys.product_adj }}](../../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance).  

Ahora, con {{ site.data.keys.mf_server }} ejecutándose en IBM Cloud, puede iniciar el desarrollo de su aplicación.

#### Aplicación de cambios
{: #applying-changes }
Es posible que necesite aplicar cambios en el diseño del servidor después de desplegar el servidor una vez, por ejemplo, si desea actualizar el URL de Analytics en **/usr/config/mfpfproperties.xml**. Realice los cambios y, a continuación, vuelva a ejecutar los scripts siguientes con el mismo conjunto de argumentos.

1. ./prepareserver.sh
2. ./startserver.sh

### Añadir la configuración del servidor de Analytics a {{ site.data.keys.mf_server }}
{: #adding-analytics-server-configuration-to-mobilefirst-server }
Si ha configurado un servidor de Analytics y desea conectarlo a este {{ site.data.keys.mf_server }}, edite el archivo **mfpfproperties.xml** de la carpeta **package_root/mfpf-server-libertyapp/usr/config**, como se especifica a continuación. Sustituya las señales marcadas con `<>` por los valores correctos de su despliegue.

```xml
<jndiEntry jndiName="${env.MFPF_RUNTIME_ROOT}/mfp.analytics.url" value='"https://<AnalyticsContainerGroupRoute>:443/analytics-service/rest"'/>
<jndiEntry jndiName="${env.MFPF_RUNTIME_ROOT}/mfp.analytics.console.url" value='"https://<AnalyticsContainerPublicRoute>:443/analytics/console"'/>
<jndiEntry jndiName="${env.MFPF_RUNTIME_ROOT}/mfp.analytics.username" value='"<AnalyticsUserName>"'/>
<jndiEntry jndiName="${env.MFPF_RUNTIME_ROOT}/mfp.analytics.password" value='"<AnalyticsPassword>"'/>


<jndiEntry jndiName="${env.MFPF_PUSH_ROOT}/mfp.push.analytics.endpoint" value='"https://<AnalyticsContainerGroupRoute>:443/analytics-service/rest"'/>
<jndiEntry jndiName="${env.MFPF_PUSH_ROOT}/mfp.push.services.ext.analytics" value="com.ibm.mfp.push.server.analytics.plugin.AnalyticsPlugin"/>
<jndiEntry jndiName="${env.MFPF_PUSH_ROOT}/mfp.push.analytics.user" value='"<AnalyticsUserName>"'/>
<jndiEntry jndiName="${env.MFPF_PUSH_ROOT}/mfp.push.analytics.password" value='"<AnalyticsPassword>"'/>
```

## Aplicar arreglos de {{ site.data.keys.mf_server }}
{: #applying-mobilefirst-server-fixes }

Los arreglos temporales para {{ site.data.keys.mf_server }} en IBM Cloud se pueden obtener en [IBM Fix Central](http://www.ibm.com/support/fixcentral).  
Antes de aplicar un arreglo temporal, realice una copia de seguridad de los archivos de configuración existentes. Los archivos de configuración se encuentran en las carpetas siguientes:
* {{ site.data.keys.mf_analytics }}:  **package_root/mfpf-analytics/usr**
* {{ site.data.keys.mf_server }} Liberty Cloud Foundry Application: **package_root/mfpf-server-libertyapp/usr**
* {{ site.data.keys.mf_app_center_short }}:  **package_root/mfp-appcenter-libertyapp/usr**

### Pasos para aplicar iFix:

1. Descargue el archivo de arreglo temporal y extraiga el contenido en la carpeta de instalación existente, sobrescribiendo los archivos existentes.
2. Restaure los archivos de configuración de copia de seguridad en las carpetas **package_root/mfpf-analytics/usr**, **package_root/mfpf-server-libertyapp/usr** y  **package_root/mfp-appcenter-libertyapp/usr**, sobrescribiendo los archivos de configuración instalados recientemente.
3. Edite el archivo **package_root/mfpf-server/usr/env/jvm.options** en su editor y elimine la siguiente línea, si existe:
```
-javaagent:/opt/ibm/wlp/usr/servers/mfp/newrelic/newrelic.jar
```
    Ahora puede compilar y desplegar el servidor actualizado. Vuelva a ejecutar los scripts siguientes con el mismo conjunto de argumentos.

    a. `./prepareserver.sh` para subir los artefactos actualizados a IBM Cloud.

    b. `./startserver.sh` para iniciar el servidor actualizado

    Se habrá guardado una copia de los argumentos utilizados en su despliegue anterior en el directorio `recorded-args/`. Puede utilizar estas propiedades para su despliegue.

<!--**Note:** When applying fixes for {{ site.data.keys.mf_app_center }} the folders are `mfp-appcenter-libertyapp/usr` and `mfp-appcenter/usr`.-->

## Eliminar la configuración del servicio de base de datos de IBM Cloud
{: #removing-the-database-service-configuration-from-ibmcloud }
Si ha ejecutado el script **prepareserverdbs.sh** durante la configuración de la imagen de {{ site.data.keys.mf_server }}, se crean las configuraciones y tablas de base de datos necesarias para {{ site.data.keys.mf_server }}. Este script también crea el esquema de base de datos para {{ site.data.keys.mf_server }}.

Para eliminar la configuración del servicio de base de datos desde IBM Cloud, realice el siguiente procedimiento utilizando el panel de control de IBM Cloud.

1. En el panel de control de IBM Cloud, seleccione el servicio dashDB que ha utilizado. Seleccione el nombre del servicio dashDB que ha proporcionado como un parámetro cuando ejecutaba el script **prepareserverdbs.sh**.
2. Inicie la consola de dashDB para trabajar con los esquemas y los objetos de base de datos de la instancia de servicio dashDB seleccionada.
3. Seleccione los esquemas relacionados con la configuración de IBM {{ site.data.keys.mf_server }}. Los nombres de esquemas son los que ha proporcionado durante la ejecución del script **prepareserverdbs.sh**.
4. Suprima cada esquema después de inspeccionar detenidamente los nombres de esquemas y los objetos que se encuentran debajo de los mismos. Las configuraciones de base de datos se eliminan de IBM Cloud.

Del mismo modo, si ha ejecutado **prepareappcenterdbs.sh** durante la configuración de {{ site.data.keys.mf_app_center }}, siga los pasos anteriores para eliminar la configuración del servicio de base de datos en IBM Cloud.
