---
layout: redirect
new_url: /404/
sitemap: false
#layout: tutorial
#title: Setting Up MobileFirst Server on IBM Cloud using Scripts for IBM Containers
#breadcrumb_title: IBM Containers
#relevantTo: [ios,android,windows,javascript]
#weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
Siga las instrucciones siguientes para configurar una instancia de {{ site.data.keys.mf_server }}, así como una instancia de {{ site.data.keys.mf_analytics }} en IBM Cloud. Para llevarlo a cabo, realice los pasos siguientes:

* Configure su sistema host con las herramientas necesarias (Cloud Foundry CLI, Docker y el plugin de IBM Containers Extension (cf ic)
* Configure su cuenta de IBM Cloud
* Cree una imagen de {{ site.data.keys.mf_server }} y envíela por push al repositorio de IBM Cloud.

Finalmente, ejecute la imagen en IBM Containers como un contenedor individual o como un grupo de contenedores, registre sus aplicaciones y también despliegue sus adaptadores.

**Notas:**  

* Actualmente el sistema operativo Windows no está soportado para ejecutar estos scripts.  
* Las herramientas de configuración de {{ site.data.keys.mf_server }} no se pueden utilizar para despliegues en IBM Containers.

#### Ir a:
{: #jump-to }
* [Registrar una cuenta en IBM Cloud](#register-an-account-at-bluemix)
* [Configurar la máquina host](#set-up-your-host-machine)
* [Descargar el archivo {{ site.data.keys.mf_bm_pkg_name }}](#download-the-ibm-mfpf-container-8000-archive)
* [Requisitos previos](#prerequisites)
* [Configuración de {{ site.data.keys.product_adj }} y Analytics Servers en IBM Containers](#setting-up-the-mobilefirst-and-analytics-servers-on-ibm-containers)
* [Aplicar arreglos de {{ site.data.keys.mf_server }}](#applying-mobilefirst-server-fixes)
* [Eliminar un contenedor de IBM Cloud](#removing-a-container-from-bluemix)
* [Eliminar la configuración del servicio de base de datos de IBM Cloud](#removing-the-database-service-configuration-from-bluemix)

## Registrar una cuenta en IBM Cloud
{: #register-an-account-at-bluemix }
Si todavía no tiene una cuenta, vaya al [sitio web de IBM Cloud](https://bluemix.net) y pulse **Iniciación gratuita** o **Iniciar sesión**. Debe rellenar un formulario de registro para ir al paso siguiente.

### Panel de control de IBM Cloud
{: #the-bluemix-dashboard }
Después de iniciar sesión en IBM Cloud, se le presentará el panel de control de IBM Cloud, que proporciona una visión general del **espacio** activo de IBM Cloud. De forma predeterminada, esta área de trabajo recibe el nombre de "dev". Puede crear varios espacios o áreas de trabajo, si es necesario.

## Configurar la máquina host
{: #set-up-your-host-machine }
Para gestionar los contenedores y las imágenes, debe instalar las herramientas siguientes: Docker, Cloud Foundry CLI y el plugin de IBM Containers (cf ic).

### Docker
{: #docker }
Vaya a [Documentación de Docker](https://docs.docker.com/) en el menú de la izquierda y seleccione **Instalar → Motor de Docker**, seleccione su tipo de sistema operativo y siga las instrucciones para instalar Docker Toolbox.

**Nota:** IBM no da soporte a Kitematic de Docker.

En macOS, hay dos opciones disponibles para ejecutar los mandatos de Docker:

* En Terminal.app de macOS: no es necesario ningún paso adicional. Solo puede trabajar desde el mismo.
* En Docker Quickstart Terminal: siga los pasos siguientes.

* Ejecute el mandato:

  ```bash
  docker-machine env default
  ```

* Establezca el resultado como las variables de entorno, por ejemplo:

  ```bash
  $ docker-machine env default
  export DOCKER_TLS_VERIFY="1"
  export DOCKER_HOST="tcp://192.168.99.101:2376"
  export DOCKER_CERT_PATH="/Users/mary/.docker/machine/machines/default"
  export DOCKER_MACHINE_NAME="default"
  ```

> Para obtener más información, consulte la documentación de Docker.

### Plugin de Cloud Foundry y plugin de IBM Containers
{: #cloud-foundry-plug-in-and-ibm-containers-plug-in}
1. Instale [Cloud Foundry CLI](https://github.com/cloudfoundry/cli/releases?cm_mc_uid=85906649576514533887001&cm_mc_sid_50200000=1454307195).
2. Instale el [Plugin de IBM Containers (cf ic)](https://console.ng.bluemix.net/docs/containers/container_cli_cfic_install.html).

## Descargar el archivo {{ site.data.keys.mf_bm_pkg_name }}
{: #download-the-ibm-mfpf-container-8000-archive}
Para configurar {{ site.data.keys.product }} en IBM Containers, en primer lugar, cree una imagen que posteriormente se enviará mediante push a IBM Cloud.  
<a href="http://www-01.ibm.com/support/docview.wss?uid=swg2C7000005" target="blank">Siga las instrucciones de esta página</a> para descargar el archivo de {{ site.data.keys.mf_server }} for IBM Containers (archivo .zip, busque: *CNBL0EN*).

El archivo comprimido contiene los archivos para crear una imagen (**dependencies** y **mfpf-libs**), los archivos para compilar y desplegar un contenedor de {{ site.data.keys.mf_analytics }} (**mfpf-analytics**) y los archivos para configurar un contenedor de {{ site.data.keys.mf_server }} (**mfpf-server**).

<div class="panel-group accordion" id="terminology" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="zip-file">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#zip-file" data-target="#collapse-zip-file" aria-expanded="false"><b>Pulse para obtener más información sobre el contenido del archivo comprimido y las propiedades de entorno disponibles que se han de utilizar</b></a>
            </h4>
        </div>

        <div id="collapse-zip-file" class="panel-collapse collapse" role="tabpanel" aria-labelledby="zip-file">
            <div class="panel-body">
                <img src="zip.png" alt="Imagen que muestra la estructura del sistema de archivos del archivo comprimido" style="float:right;width:570px"/>
                <h4>carpeta dependencies</h4>
                <p>Contiene el tiempo de ejecución de {{ site.data.keys.product }} junto con IBM Java JRE 8.</p>

                <h4>carpeta mfpf-libs</h4>
                <p>Contiene las bibliotecas de componentes del producto {{ site.data.keys.product_adj }} y CLI.</p>

                <h4>carpetas mfpf-server y mfpf-analytics</h4>

                <ul>
                    <li><b>Dockerfile</b>: Documento de texto que contiene todos los mandatos necesarios para crear una imagen.</li>
                    <li>Carpeta <b>scripts</b>: Esta carpeta contiene la carpeta <b>args</b> que incluye un conjunto de archivos de configuración. También contiene scripts que se pueden ejecutar para iniciar sesión en IBM Cloud, crear una imagen de {{ site.data.keys.mf_server }}/{{ site.data.keys.mf_analytics }} para enviarla por push y ejecutar la imagen en IBM Cloud. Puede optar por ejecutar los scripts de forma interactiva o configurar previamente los archivos de configuración como se describe detalladamente más adelante. Aparte de los archivos args/*.properties personalizables, no modifique ningún elemento de esta carpeta. Para obtener ayuda sobre el uso de scripts, utilice los argumentos de línea de mandatos <code>-h</code> o <code>--help</code>, por ejemplo, <code>scriptname.sh --help</code>.</li>
                    <li>carpeta <b>usr</b>:
                        <ul>
                            <li>Carpeta <b>bin</b>: contiene el archivo de script que se ejecuta cuando se inicia el contenedor. Puede añadir su propio código personalizado para ejecutarlo.</li>
                            <li>Carpeta <b>config</b>: Contiene los fragmentos de configuración del servidor (almacén de claves, propiedades del servidor, registro de usuarios) que utilizan {{ site.data.keys.mf_server }}/{{ site.data.keys.mf_analytics }}.</li>
                            <li><b>keystore.xml</b> - la configuración del repositorio de los certificados de seguridad que se utilizan para el cifrado SSL. Debe hacerse referencia a los archivos listados en la carpeta ./usr/security.</li>
                            <li><b>mfpfproperties.xml</b> - propiedades de configuración para {{ site.data.keys.mf_server }} y {{ site.data.keys.mf_analytics }}. Consulte las propiedades soportadas en estos temas de la documentación:
                                <ul>
                                    <li><a href="../../installation-configuration/production/server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service">Lista de propiedades de JNDI para el servicio de administración de {{ site.data.keys.mf_server }}</a></li>
                                    <li><a href="../../installation-configuration/production/server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime">Lista de propiedades de JNDI para el tiempo de ejecución de {{ site.data.keys.product_adj }}</a></li>
                                </ul>
                            </li>
                            <li><b>registry.xml</b> - configuración del registro de usuarios. La configuración de basicRegistry (de forma predeterminada, se proporciona una configuración de registro de usuarios básico basado en XML). Se pueden configurar los nombres de usuarios y las contraseñas para basicRegistry o puede configurar ldapRegistry.</li>
                        </ul>
                    </li>
                    <li>Carpeta <b>env</b>: Contiene las propiedades del entorno que se utilizan para la inicialización del servidor (server.env) y las opciones de JVM personalizadas (jvm.options).</li>

                    <br/>
                    <div class="panel-group accordion" id="terminology-server-env" role="tablist">
                        <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="server-env">
                                <h4 class="panel-title">
                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#env-properties" data-target="#collapse-server-env" aria-expanded="false" aria-controls="collapse-server-env"><b>Pulse para obtener una lista de las propiedades de entorno del servidor soportadas</b></a>
                                </h4>
                            </div>

                            <div id="collapse-server-env" class="panel-collapse collapse" role="tabpanel" aria-labelledby="zip-file">
                                <div class="panel-body">
                                    <table class="table table-striped">
                                        <tr>
                                            <td><b>Propiedad</b></td>
                                            <td><b>Valor predeterminado</b></td>
                                            <td><b>Descripción</b></td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_SERVER_HTTPPORT</td>
                                            <td>9080*</td>
                                            <td>El puerto utilizado para las solicitudes HTTP de cliente. Utilice -1 para inhabilitar este puerto.</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_SERVER_HTTPSPORT	</td>
                                            <td>9443*	</td>
                                            <td>El puerto utilizado para las solicitudes HTTP de cliente protegidas con SSL (HTTPS). Utilice -1 para inhabilitar este puerto.</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_CLUSTER_MODE	</td>
                                            <td><code>Standalone</code></td>
                                            <td>No es necesaria la configuración. Los valores válidos son <code>Standalone</code> o <code>Farm</code>. El valor de <code>Farm</code> se establece automáticamente cuando se ejecuta el contenedor como un grupo de contenedores.</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_ADMIN_ROOT	</td>
                                            <td>mfpadmin</td>
                                            <td>La raíz de contexto en la que estarán disponibles los servicios de administración de {{ site.data.keys.mf_server }}.</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_CONSOLE_ROOT	</td>
                                            <td>mfpconsole</td>
                                            <td>La raíz de contexto en la que estarán disponibles los servicios de administración de {{ site.data.keys.mf_console }}.</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_ADMIN_GROUP</td>
                                            <td>mfpadmingroup</td>
                                            <td>El nombre del grupo de usuarios que tiene asignado el rol <code>mfpadmin</code> predefinido.</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_DEPLOYER_GROUP	</td>
                                            <td>mfpdeployergroup</td>
                                            <td>El nombre del grupo de usuarios que tiene asignado el rol <code>mfpdeployer</code> predefinido.</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_MONITOR_GROUP	</td>
                                            <td>mfpmonitorgroup</td>
                                            <td>El nombre del grupo de usuarios que tiene asignado el rol <code>mfpmonitor</code> predefinido.</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_OPERATOR_GROUP	</td>
                                            <td>mfpoperatorgroup</td>
                                            <td>El nombre del grupo de usuarios que tiene asignado el rol <code>mfpoperator</code> predefinido.</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_SERVER_ADMIN_USER	</td>
                                            <td>WorklightRESTUser</td>
                                            <td>El usuario administrador del servidor Liberty para los servicios de administración de {{ site.data.keys.mf_server }}.</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_SERVER_ADMIN_PASSWORD	</td>
                                            <td>mfpadmin. Asegúrese de que cambia el valor predeterminado por una contraseña privada antes del despliegue a un entorno de producción.</td>
                                            <td>La contraseña del usuario administrador del servidor Liberty para los servicios de administración de {{ site.data.keys.mf_server }}.</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_ADMIN_USER	</td>
                                            <td>admin</td>
                                            <td>El nombre de usuario del rol de administrador para las operaciones de {{ site.data.keys.mf_server }}.</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_ADMIN_PASSWORD	</td>
                                            <td>admin</td>
                                            <td>La contraseña del rol de administrador para las operaciones de {{ site.data.keys.mf_server }}.</td>
                                        </tr>
                                    </table>

                    				<br/>
                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#server-env" data-target="#collapse-server-env" aria-expanded="false" aria-controls="collapse-server-env"><b>Cerrar sección</b></a>
                                </div>
                            </div>
                        </div>
                        <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="analytics-env">
                                <h4 class="panel-title">
                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#env-properties" data-target="#collapse-analytics-env" aria-expanded="false" aria-controls="collapse-analytics-env"><b>Pulse para obtener una lista de las propiedades de entorno de Analytics soportadas</b></a>
                                </h4>
                            </div>

                            <div id="collapse-analytics-env" class="panel-collapse collapse" role="tabpanel" aria-labelledby="zip-file">
                                <div class="panel-body">
                                    <table class="table table-striped">
                                        <tr>
                                            <td><b>Propiedad</b></td>
                                            <td><b>Valor predeterminado</b></td>
                                            <td><b>Descripción</b></td>
                                        </tr>
                                        <tr>
                                            <td>ANALYTICS_SERVER_HTTP PORT	</td>
                                            <td>9080*</td>
                                            <td>El puerto utilizado para las solicitudes HTTP de cliente. Utilice -1 para inhabilitar este puerto.</td>
                                        </tr>
                                        <tr>
                                            <td>ANALYTICS_SERVER_HTTPS PORT	</td>
                                            <td>9443*	</td>
                                            <td>El puerto utilizado para las solicitudes HTTP de cliente. Utilice -1 para inhabilitar este puerto.</td>
                                        </tr>
                                        <tr>
                                            <td>ANALYTICS_ADMIN_GROUP</td>
                                            <td>analyticsadmingroup</td>
                                            <td>El nombre del grupo de usuarios que tiene asignado el rol <b>worklightadmin</b> predefinido.</td>
                                        </tr>
                                    </table>

                    				<br/>
                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#analytics-env" data-target="#collapse-analytics-env" aria-expanded="false" aria-controls="collapse-analytics-env"><b>Cerrar sección</b></a>
                                </div>
                            </div>
                        </div>
                    </div>


                    </li>
                    <li>Carpeta <b>jre-security</b>: Puede actualizar los archivos relacionados con la seguridad JRE (almacén de claves, archivos JAR de políticas, etc.) colocándolos en esta carpeta. Los archivos de esta carpeta se copian en la carpeta JAVA_HOME/jre/lib/security/ del contenedor.</li>
                    <li>Carpeta <b>security</b>: Se utiliza para los archivos del almacén de claves, el almacén de confianza y las claves LTPA (ltpa.keys).</li>
                    <li>Carpeta <b>ssh</b>: Se utiliza para almacenar el archivo de claves públicas (id_rsa.pub), que se utiliza para habilitar el acceso SSH al contenedor.</li>
                    <li>Carpeta <b>wxs</b> (solo para {{ site.data.keys.mf_server }}): Contiene la caché de datos y la biblioteca de cliente extreme-scale cuando se utiliza la caché de datos como un almacén de atributos para el servidor.</li>
                </ul>
				<br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#zip-file" data-target="#collapse-zip-file" aria-expanded="false" aria-controls="collapse-zip-file"><b>Cerrar sección</b></a>
            </div>
        </div>
    </div>
</div>

## Requisitos previos
{: #prerequisites }
Los pasos siguientes son obligatorios, ya que ejecutará mandatos de IBM durante la sección siguiente.

1. Inicie sesión en el entorno de IBM Cloud.  

    Ejecute: `cf login`.  
    Cuando se le solicite, especifique la información siguiente:
      * Punto final de API de IBM Cloud
      * Correo electrónico
      * Contraseña
      * Organización, si tiene más de una
      * Espacio, si tiene más de uno

2. Para ejecutar mandatos de IBM Containers, en primer lugar, debe iniciar sesión en IBM Container Cloud Service.  
Ejecute: `cf ic login`.

3. Asegúrese de que esté establecido el registro del contenedor de `namespace`. El valor de `namespace` es un nombre exclusivo que identifica su repositorio privado en el registro de IBM Cloud. El espacio de nombre se asigna una vez para la organización y no se puede cambiar. Seleccione un espacio de nombres siguiente estas reglas:
     * Solo puede contener letras en minúsculas, números o caracteres de subrayado.
     * Puede tener entre 4 - 30 caracteres. Si tiene previsto gestionar los contenedores desde la línea de mandatos, es posible que prefiera que el espacio de nombres sea corto para poder escribirlo rápidamente.
     * Debe ser exclusivo en el registro de IBM Cloud.

    Para establecer un espacio de nombres, ejecute el mandato: `cf ic namespace set <new_name>`.  
    Para obtener el espacio de nombres que ha ejecutado, ejecute el mandato: `cf ic namespace get`.

> Para obtener más información acerca de los mandatos IC, ejecute el mandato `ic help`.

## Configuración de {{ site.data.keys.product_adj }}, Analytics Servers y {{ site.data.keys.mf_app_center_short }} en IBM Containers
{: #setting-up-the-mobilefirst-and-analytics-servers-on-ibm-containers }
Como se ha descrito anteriormente, puede optar por ejecutar los scripts de forma interactiva o utilizar los archivos de configuración:

* Utilización de los archivos de configuración: Ejecute los scripts y pase el archivo de configuración respectivo como un argumento.
* Interactivamente: Ejecute los scripts sin argumentos.

**Nota:** Si opta por ejecutar los scripts de forma interactiva, puede omitir el paso de configuración pero se le recomienda que, como mínimo, lea y comprenda los argumentos que deberá proporcionar.


### {{ site.data.keys.mf_app_center }}
{: #mobilefirst-appcenter }
Si tiene previsto utilizar {{ site.data.keys.mf_app_center }}, comience aquí.

>**Nota:** Puede descargar los instaladores y las herramientas de base de datos desde las carpetas de instalación de {{ site.data.keys.mf_app_center }} locales (las carpetas `installer` y `tools`).

<div class="panel-group accordion" id="scripts" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="step1">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#scripts" data-target="#collapseStep1appcenter" aria-expanded="false" aria-controls="collapseStep1appcenter">Utilización de los archivos de configuración</a>
            </h4>
        </div>

        <div id="collapseStep1appcenter" class="panel-collapse collapse" role="tabpanel">
            <div class="panel-body">
            La carpeta <b>args</b> contiene un conjunto de archivos de configuración que contiene los argumentos necesarios para ejecutar los scripts. Rellene los valores de los argumentos en los archivos siguientes.<br/>
              <h4>initenv.properties</h4>
              <ul>
                  <li><b>IBM_CLOUD_USER - </b>Su nombre de usuario de IBM Cloud (correo electrónico).</li>
                  <li><b>IBM_CLOUD_PASSWORD - </b>Su contraseña de IBM Cloud.</li>
                  <li><b>IBM_CLOUD_ORG - </b>El nombre de su organización de IBM Cloud.</li>
                  <li><b>IBM_CLOUD_SPACE - </b>Su espacio IBM Cloud (como se ha descrito anteriormente).</li>
              </ul>
              <h4>prepareappcenterdbs.properties</h4>
              {{ site.data.keys.mf_app_center }} requiere una <a href="https://console.ng.bluemix.net/catalog/services/dashdb/" target="_blank">instancia de base de datos dashDB Enterprise Transactional</a> (Enterprise Transactional 2.8.500 o Enterprise Transactional 12.128.1400).
              <blockquote><p><b>Nota:</b> El despliegue de los planes dashDB Enterprise Transactional puede no ser inmediato. Es posible que el equipo de ventas le contacte antes del despliegue del servicio.</p></blockquote>

              Después de configurar la instancia de dashDB, proporcione los argumentos necesarios:
              <ul>
                  <li><b>APPCENTER_DB_SRV_NAME - </b>El nombre de su instancia de servicio de dashDB, para almacenar los datos del centro de aplicaciones</li>
                  <li><b>APPCENTER_SCHEMA_NAME - </b>El nombre de su esquema de base de datos, utilizado para los datos del centro de aplicaciones.</li>
                  <blockquote><b>Nota:</b> Si su instancia de servicio de dashDB la comparten varios usuarios, asegúrese de que proporciona nombres de esquema exclusivos.</blockquote>

              </ul>
              <h4>prepareappcenter.properties</h4>
              <ul>
                  <li><b>SERVER_IMAGE_TAG - </b>Una etiqueta para la imagen. Debe tener el formato: <em>registry-url/namespace/your-tag</em>.</li>
              </ul>
              <h4>startappcenter.properties</h4>
              <ul>
                  <li><b>SERVER_IMAGE_TAG - </b>Igual que en <em>prepareappcenter.sh</em>.</li>
                  <li><b>SERVER_CONTAINER_NAME - </b>Un nombre para el contenedor IBM Cloud.</li>
                  <li><b>SERVER_IP - </b>Una dirección IP a la que se puede enlazar el contenedor de IBM Cloud.</li>
                  <blockquote>Para asignar una dirección IP, ejecute: <code>cf ic ip request</code>.
                  Las direcciones IP se pueden reutilizar en varios contenedores de un espacio IBM Cloud concreto.
                  Si ya tiene asignada una IP, puede ejecutar: <code>cf ic ip list</code>.</blockquote>
              </ul>
              <h4>startappcentergroup.properties</h4>
              <ul>
                  <li><b>SERVER_IMAGE_TAG - </b>Igual que en <em>prepareappcenter.sh</em>.</li>
                  <li><b>SERVER_CONTAINER_GROUP_NAME - </b>Un nombre para el grupo de contenedores de IBM Cloud.</li>
                  <li><b>SERVER_CONTAINER_GROUP_HOST - </b>Su nombre de host.</li>
                  <li><b>SERVER_CONTAINER_GROUP_DOMAIN - </b>El nombre del dominio. El valor predeterminado es: <code>mybluemix.net</code>.</li>
              </ul>    
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="appcenterstep2">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#scripts" data-target="#collapseStep2appcenter" aria-expanded="false" aria-controls="collapseStep2appcenter">Ejecución de los scripts</a>
            </h4>
        </div>

        <div id="collapseStep2appcenter" class="panel-collapse collapse" role="tabpanel">
            <div class="panel-body">
                <p>Las siguientes instrucciones muestran cómo ejecutar los scripts utilizando los archivos de configuración. También está disponible una lista de argumentos de línea de mandatos, si opta por ejecutarlos fuera del modo interactivo:</p>
                <ol>
                    <li><b>initenv.sh – Inicio de sesión en IBM Cloud </b><br />
                    Ejecute el script <b>initenv.sh</b> para crear un entorno para compilar y ejecutar {{ site.data.keys.product }} en IBM Containers:
{% highlight bash %}
./initenv.sh args/initenv.properties
{% endhighlight %}

                        <div class="panel-group accordion" id="terminology-appcenter-initenv" role="tablist">
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="script-appcenter-initenv">
                                    <h4 class="panel-title">
                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-appcenter-initenv" data-target="#collapse-script-appcenter-initenv" aria-expanded="false" aria-controls="collapse-script-appcenter-initenv"><b>Pulse para obtener una lista de argumentos de línea de mandatos</b></a>
                                    </h4>
                                </div>

                                <div id="collapse-script-appcenter-initenv" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-appcenter-initenv">
                                    <div class="panel-body">
                                        <table class="table table-striped">
                                            <tr>
                                                <td><b>Argumento de línea de mandatos</b></td>
                                                <td><b>Descripción</b></td>
                                            </tr>
                                            <tr>
                                                <td>[-u|--user] IBM_CLOUD_USER</td>
                                                <td>ID de usuario o dirección de correo electrónico de IBM Cloud</td>
                                            </tr>
                                            <tr>
                                                <td>[-p|--password] IBM_CLOUD_PASSWORD	</td>
                                                <td>Contraseña de IBM Cloud</td>
                                            </tr>
                                            <tr>
                                                <td>[-o|--org] IBM_CLOUD_ORG	</td>
                                                <td>Nombre de organización de IBM Cloud</td>
                                            </tr>
                                            <tr>
                                                <td>[-s|--space] IBM_CLOUD_SPACE	</td>
                                                <td>Nombre de espacio de IBM Cloud</td>
                                            </tr>
                                            <tr>
                                                <td>Opcional. [-a|--api] IBM_CLOUD_API_URL	</td>
                                                <td>Punto final de API de IBM Cloud. (El valor predeterminado es: https://api.ng.bluemix.net)</td>
                                            </tr>
                                        </table>

                                        <p>Por ejemplo:</p>
{% highlight bash %}
initenv.sh --user IBM_CLOUD_user_ID --password IBM_CLOUD_password --org IBM_CLOUD_organization_name --space IBM_CLOUD_space_name
{% endhighlight %}

                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-appcenter-initenv" data-target="#collapse-script-appcenter-initenv" aria-expanded="false" aria-controls="collapse-script-appcenter-initenv"><b>Cerrar sección</b></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </li>
                    <li><b>prepareappcenterdbs.sh - Prepare la base de datos de {{ site.data.keys.mf_app_center }} </b><br/>
                    El script <b>prepareappcenterdbs.sh</b> se utiliza para configurar {{ site.data.keys.mf_app_center }} con el servicio de base de datos dashDB. La instancia de servicio de dashDB debe estar disponible en la organización y el espacio en el que ha iniciado sesión en el paso 1.
                    Ejecute lo siguiente:

{% highlight bash %}
./prepareappcenterdbs.sh args/prepareappcenterdbs.properties
{% endhighlight %}

                        <div class="panel-group accordion" id="terminology-appcenter-prepareappcenterdbs" role="tablist">
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="script-appcenter-prepareappcenterdbs">
                                    <h4 class="panel-title">
                                      <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-appcenter-prepareappcenterdbs" data-target="#collapse-script-appcenter-prepareappcenterdbs" aria-expanded="false" aria-controls="collapse-script-appcenter-prepareappcenterdbs"><b>Pulse para obtener una lista de argumentos de línea de mandatos</b></a>
                                    </h4>
                                </div>

                                <div id="collapse-script-appcenter-prepareappcenterdbs" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-appcenter-prepareappcenterdbs">
                                    <div class="panel-body">
                                        <table class="table table-striped">
                                            <tr>
                                              <td><b>Argumento de línea de mandatos</b></td>
                                              <td><b>Descripción</b></td>
                                            </tr>
                                            <tr>
                                              <td>[-db | --acdb ] APPCENTER_DB_SRV_NAME	</td>
                                              <td>Servicio dashDB de IBM Cloud (con el plan de servicio IBM Cloud Enterprise Transactional).</td>
                                            </tr>    
                                            <tr>
                                              <td>Opcional: [-ds | --acds ] APPCENTER_SCHEMA_NAME	</td>
                                              <td>Nombre de esquema de base de datos para el servicio de Application Center. El valor predeterminado es <i>APPCNTR</i>.</td>
                                            </tr>    
                                        </table>

                                        <p>Por ejemplo:</p>
{% highlight bash %}
prepareappcenterdbs.sh --acdb AppCenterDashDBService
{% endhighlight %}

                                      <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-appcenter-prepareappcenterdbs" data-target="#collapse-script-appcenter-prepareappcenterdbs" aria-expanded="false" aria-controls="collapse-script-appcenter-prepareappcenterdbs"><b>Cerrar sección</b></a>
                                  </div>
                              </div>
                          </div>
                      </div>

                    </li>
                    <li><b>initenv.sh (Opcional) – Inicio de sesión en IBM Cloud </b><br />
                    Este paso solo es necesario si necesita crear sus contenedores en una organización y espacio diferentes a aquellos en los que está disponible la instancia de servicio de dashDB. Si es así, actualice <b>initenv.properties</b> con la nueva organización y espacio en que se han de crear y también iniciar los contenedores y vuelva a ejecutar el script <b>initenv.sh</b>:</li>

{% highlight bash %}
./initenv.sh args/initenv.properties
{% endhighlight %}


                    <li><b>prepareappcenter.sh - Prepare una imagen de {{ site.data.keys.mf_app_center }}</b><br />
                    Ejecute el script <b>prepareappcenter.sh</b> para crear una imagen de {{ site.data.keys.mf_app_center }} y enviarla mediante push al repositorio de IBM Cloud. Para ver todas las imágenes disponibles del repositorio de IBM Cloud, ejecute: <code>cf ic images</code>
                    La lista contiene el nombre, la fecha de creación y el ID de la imagen.

                        Ejecute:
{% highlight bash %}
./prepareappcenter.sh args/prepareappcenter.properties
{% endhighlight %}

                        <div class="panel-group accordion" id="terminology-appcenter-prepareappcenter" role="tablist">
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="script-appcenter-prepareappcenter">
                                    <h4 class="panel-title">
                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-appcenter-prepareappcenter" data-target="#collapse-script-appcenter-prepareappcenter" aria-expanded="false" aria-controls="collapse-script-appcenter-prepareappcenter"><b>Pulse para obtener una lista de argumentos de línea de mandatos</b></a>
                                    </h4>
                                </div>

                                <div id="collapse-script-appcenter-prepareappcenter" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-appcenter-prepareappcenter">
                                    <div class="panel-body">
                                        <table class="table table-striped">
                                            <tr>
                                                <td><b>Argumento de línea de mandatos</b></td>
                                                <td><b>Descripción</b></td>
                                            </tr>
                                            <tr>
                                                <td>[-t|--tag] SERVER_IMAGE_NAME	</td>
                                                <td>El nombre que se utilizará para la imagen personalizada de MobileFirst Application Center. Formato: <em>registryUrl/namespace/imagename</em></td>
                                            </tr>
                                        </table>

                                        <p>Por ejemplo:</p>
{% highlight bash %}
prepareappcenter.sh --tag SERVER_IMAGE_NAME registryUrl/namespace/imagename
{% endhighlight %}

                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-appcenter-prepareappcenter" data-target="#collapse-script-appcenter-prepareappcenter" aria-expanded="false" aria-controls="collapse-script-appcenter-prepareappcenter"><b>Cerrar sección</b></a>
                                    </div>
                                </div>
                            </div>
                        </div>   
                    </li>
                    <li><b>startappcenter.sh - Ejecutar la imagen en IBM Container</b><br/>
                    El script <b>startappcenter.sh</b> se utiliza para ejecutar la imagen de {{ site.data.keys.mf_app_center }} en IBM Container. También enlaza la imagen con la IP pública que ha configurado en la propiedad <b>SERVER_IP</b>.

                        Ejecute:
{% highlight bash %}
./startappcenter.sh args/startappcenter.properties
{% endhighlight %}

                        <div class="panel-group accordion" id="terminology-appcenter-startappcenter" role="tablist">
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="script-appcenter-startappcenter">
                                    <h4 class="panel-title">
                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-appcenter-startappcenter" data-target="#collapse-script-appcenter-startappcenter" aria-expanded="false" aria-controls="collapse-script-appcenter-startappcenter"><b>Pulse para obtener una lista de argumentos de línea de mandatos</b></a>
                                    </h4>
                                </div>

                                <div id="collapse-script-appcenter-startappcenter" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-appcenter-startappcenter">
                                    <div class="panel-body">
                                        <table class="table table-striped">
                                            <tr>
                                                <td><b>Argumento de línea de mandatos</b></td>
                                                <td><b>Descripción</b></td>
                                            </tr>
                                            <tr>
                                                <td>[-t|--tag] SERVER_IMAGE_TAG	</td>
                                                <td>Nombre de la imagen de {{ site.data.keys.mf_app_center }}.</td>
                                            </tr>
                                            <tr>
                                                <td>[-i|--ip] SERVER_IP	</td>
                                                <td>La dirección IP a la que se debe enlazar el contenedor de {{ site.data.keys.mf_app_center }}. (Puede proporcionar una IP pública o solicitar una utilizando el mandato <code>cf ic ip request</code>).</td>
                                            </tr>
                                            <tr>
                                                <td>Opcional: [-si|--services] SERVICE_INSTANCES	</td>
                                                <td>Las instancias de servicio de IBM Cloud, separadas por comas, que desea enlazar con el contenedor.</td>
                                            </tr>
                                            <tr>
                                                <td>Opcional: [-h|--http] EXPOSE_HTTP </td>
                                                <td>Exponer el puerto HTTP. Los valores aceptados son Y (valor predeterminado) o N.</td>
                                            </tr>
                                            <tr>
                                                <td>Opcional: [-s|--https] EXPOSE_HTTPS </td>
                                                <td>Exponer el puerto HTTPS. Los valores aceptados son Y (valor predeterminado) o N.</td>
                                            </tr>
                                            <tr>
                                                <td>Optional: [-m|--memory] SERVER_MEM </td>
                                                <td>Asigne un límite de tamaño de memoria al contenedor en megabytes (MB). Los valores aceptados son 1024 MB (valor predeterminado) y 2048 MB.</td>
                                            </tr>
                                            <tr>
                                                <td>Opcional: [-se|--ssh] SSH_ENABLE </td>
                                                <td>Habilitar SSH para el contenedor. Los valores aceptados son Y (valor predeterminado) o N.</td>
                                            </tr>
                                            <tr>
                                                <td>Opcional: [-sk|--sshkey] SSH_KEY </td>
                                                <td>La clave SSH que se inyectará en el contenedor. (Proporcione el contenido de su archivo id_rsa.pub).</td>
                                            </tr>
                                            <tr>
                                                <td>Optional: [-tr|--trace] TRACE_SPEC </td>
                                                <td>La especificación de rastreo que se ha de aplicar. Valor predeterminado: <code>*=info</code></td>
                                            </tr>
                                            <tr>
                                                <td>Opcional: [-ml|--maxlog] MAX_LOG_FILES </td>
                                                <td>El número máximo de archivos de registro que se ha de mantener antes de que se sobrescriban. El valor predeterminado es de 5 archivos.</td>
                                            </tr>
                                            <tr>
                                                <td>Optional: [-ms|--maxlogsize] MAX_LOG_FILE_SIZE </td>
                                                <td>El tamaño máximo de un archivo de registro. El tamaño predeterminado es de 20 MB.</td>
                                            </tr>
                                            <tr>
                                                <td>Opcional:  [-v|--volume] ENABLE_VOLUME </td>
                                                <td>Habilitar el montaje de volúmenes para los registros del contenedor. Los valores aceptados son Y o N (valor predeterminado).</td>
                                            </tr>

                                        </table>

                                        <p>Por ejemplo:</p>
{% highlight bash %}
startappcenter.sh --tag image_tag_name --name container_name --ip container_ip_address
{% endhighlight %}

                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-appcenter-startappcenter" data-target="#collapse-script-appcenter-startappcenter" aria-expanded="false" aria-controls="collapse-script-appcenter-startappcenter"><b>Cerrar sección</b></a>
                                    </div>
                                </div>
                            </div>
                        </div>   
                    </li>
                    <li><b>startappcentergroup.sh - Ejecutar la imagen en un grupo de IBM Container</b><br/>
                    El script <b>startappcentergroup.sh</b> se utiliza para ejecutar la imagen de {{ site.data.keys.mf_app_center }} en un grupo de IBM Container. También enlaza la imagen con el nombre de host que ha configurado en la propiedad <b>SERVER_CONTAINER_GROUP_HOST</b>.

                        Ejecute:
{% highlight bash %}
./startappcentergroup.sh args/startappcentergroup.properties
{% endhighlight %}

                        <div class="panel-group accordion" id="terminology-appcenter-startappcentergroup" role="tablist">
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="script-appcenter-startappcentergroup">
                                    <h4 class="panel-title">
                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-appcenter-startappcentergroup" data-target="#collapse-script-appcenter-startappcentergroup" aria-expanded="false" aria-controls="collapse-script-appcenter-startappcentergroup"><b>Pulse para obtener una lista de argumentos de línea de mandatos</b></a>
                                    </h4>
                                </div>

                                <div id="collapse-script-appcenter-startappcentergroup" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-appcenter-startappcentergroup">
                                    <div class="panel-body">
                                        <table class="table table-striped">
                                            <tr>
                                                <td><b>Argumento de línea de mandatos</b></td>
                                                <td><b>Descripción</b></td>
                                            </tr>
                                            <tr>
                                                <td>[-t|--tag] SERVER_IMAGE_TAG	</td>
                                                <td>El nombre de la imagen del contenedor de {{ site.data.keys.mf_app_center }} en el registro de IBM Cloud.</td>
                                            </tr>
                                            <tr>
                                                <td>[-gn|--name] SERVER_CONTAINER_NAME	</td>
                                                <td>El nombre del grupo de contenedores de {{ site.data.keys.mf_app_center }}.</td>
                                            </tr>
                                            <tr>
                                                <td>[-gh|--host] SERVER_CONTAINER_GROUP_HOST	</td>
                                                <td>El nombre de host de la ruta.</td>
                                            </tr>
                                            <tr>
                                                <td>[-gs|--domain] SERVER_CONTAINER_GROUP_DOMAIN </td>
                                                <td>El nombre de dominio de la ruta.</td>
                                            </tr>
                                            <tr>
                                                <td>Opcional: [-gm|--min] SERVERS_CONTAINER_GROUP_MIN </td>
                                                <td>El número mínimo de instancias de contenedor. El valor predeterminado es 1.</td>
                                            </tr>
                                            <tr>
                                                <td>Opcional: [-gx|--max] SERVER_CONTAINER_GROUP_MAX </td>
                                                <td>El número máximo de instancias de contenedor. El valor predeterminado es 2.</td>
                                            </tr>
                                            <tr>
                                                <td>Opcional: [-gd|--desired] SERVER_CONTAINER_GROUP_DESIRED </td>
                                                <td>El número deseado de instancias de contenedor. El valor predeterminado es 1.</td>
                                            </tr>
                                            <tr>
                                                <td>Opcional: [-a|--auto] ENABLE_AUTORECOVERY </td>
                                                <td>Habilitar la recuperación automática para las instancias de contenedor. Los valores aceptados son Y o N (valor predeterminado).</td>
                                            </tr>
                                            <tr>
                                                <td>Optional: [-si|--services] SERVICES </td>
                                                <td>Los nombres de las instancias de servicio de IBM Cloud, separados por comas, que desea enlazar con el contenedor.</td>
                                            </tr>
                                            <tr>
                                                <td>Optional: [-tr|--trace] TRACE_SPEC </td>
                                                <td>La especificación de rastreo que se ha de aplicar. Valor predeterminado </code>*=info</code>.</td>
                                            </tr>
                                            <tr>
                                                <td>Optional: [-ml|--maxlog] MAX_LOG_FILESC </td>
                                                <td>El número máximo de archivos de registro que se ha de mantener antes de que se sobrescriban. El valor predeterminado es de 5 archivos.</td>
                                            </tr>
                                            <tr>
                                                <td>Optional: [-ms|--maxlogsize] MAX_LOG_FILE_SIZE </td>
                                                <td>El tamaño máximo de un archivo de registro. El tamaño predeterminado es de 20 MB.</td>
                                            </tr>
                                            <tr>
                                                <td>Optional: [-m|--memory] SERVER_MEM </td>
                                                <td>Asigne un límite de tamaño de memoria al contenedor en megabytes (MB). Los valores aceptados son 1024 MB (valor predeterminado) y 2048 MB.</td>
                                            </tr>
                                            <tr>
                                                <td>Optional: [-v|--volume] ENABLE_VOLUME </td>
                                                <td>Habilitar el montaje de volúmenes para los registros del contenedor. Los valores aceptados son Y o N (valor predeterminado).</td>
                                            </tr>

                                        </table>

                                        <p>Por ejemplo:</p>
{% highlight bash %}
startappcentergroup.sh --tag image_name --name container_group_name --host container_group_host_name --domain container_group_domain_name
{% endhighlight %}

                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-appcenter-startappcentergroup" data-target="#collapse-script-appcenter-startappcentergroup" aria-expanded="false" aria-controls="collapse-script-appcenter-startappcentergroup"><b>Cerrar sección</b></a>
                                    </div>
                                </div>
                            </div>
                        </div>   
                    </li>
                </ol>
            </div>
        </div>
    </div>
</div>


### {{ site.data.keys.mf_analytics }}
{: #mobilefirst-analytics }
Si tiene previsto utilizar Analytics con {{ site.data.keys.mf_server }}, comience aquí.

<div class="panel-group accordion" id="scripts-analytics" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="step1-analytics">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#scripts" data-target="#collapseStep1" aria-expanded="false" aria-controls="collapseStep1">Utilización de los archivos de configuración</a>
            </h4>
        </div>

        <div id="collapseStep1" class="panel-collapse collapse" role="tabpanel">
            <div class="panel-body">
            La carpeta <b>args</b> contiene un conjunto de archivos de configuración que contiene los argumentos necesarios para ejecutar los scripts. Rellene los valores de los argumentos en los archivos siguientes.<br/>
            <b>Nota:</b> Solo se incluyen los argumentos necesarios. Para obtener más información acerca de los argumentos adicionales, consulte la documentación contenida en los archivos de propiedades.
              <h4>initenv.properties</h4>
              <ul>
                  <li><b>IBM_CLOUD_USER - </b>Su nombre de usuario de IBM Cloud (correo electrónico).</li>
                  <li><b>IBM_CLOUD_PASSWORD - </b>Su contraseña de IBM Cloud.</li>
                  <li><b>IBM_CLOUD_ORG - </b>El nombre de su organización de IBM Cloud.</li>
                  <li><b>IBM_CLOUD_SPACE - </b>Su espacio IBM Cloud (como se ha descrito anteriormente).</li>
              </ul>
              <h4>prepareanalytics.properties</h4>
              <ul>
                  <li><b>ANALYTICS_IMAGE_TAG - </b>Una etiqueta para la imagen. Debe tener el formato: <em>registry-url/namespace/your-tag</em>.</li>
              </ul>
              <h4>startanalytics.properties</h4>
              <ul>
                  <li><b>ANALYTICS_IMAGE_TAG - </b>Igual que en <em>prepareserver.sh</em>.</li>
                  <li><b>ANALYTICS_CONTAINER_NAME - </b>Un nombre para el contenedor IBM Cloud.</li>
                  <li><b>ANALYTICS_IP - </b>Una dirección IP a la que se puede enlazar el contenedor de IBM Cloud.<br/>
                  Para asignar una dirección IP, ejecute: <code>cf ic ip request</code>.<br/>
                  Las direcciones IP se pueden reutilizar en varios contenedores de un espacio.<br/>
                  Si ya tiene asignada una, puede ejecutar: <code>cf ic ip list</code>.</li>
              </ul>
              <h4>startanalyticsgroup.properties</h4>
              <ul>
                  <li><b>ANALYTICS_IMAGE_TAG - </b>Igual que en <em>prepareserver.sh</em>.</li>
                  <li><b>ANALYTICS_CONTAINER_GROUP_NAME - </b>Un nombre para el grupo de contenedores de IBM Cloud.</li>
                  <li><b>ANALYTICS_CONTAINER_GROUP_HOST - </b>Su nombre de host.</li>
                  <li><b>ANALYTICS_CONTAINER_GROUP_DOMAIN - </b>El nombre del dominio. El valor predeterminado es: <code>mybluemix.net</code>.</li>
              </ul>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="step2">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#scripts" data-target="#collapseStep2" aria-expanded="false" aria-controls="collapseStep2">Ejecución de los scripts</a>
            </h4>
        </div>

        <div id="collapseStep2" class="panel-collapse collapse" role="tabpanel">
            <div class="panel-body">
                <p>Las siguientes instrucciones muestran cómo ejecutar los scripts utilizando los archivos de configuración. También está disponible una lista de argumentos de línea de mandatos, si opta por ejecutarlos fuera del modo interactivo:</p>
                <ol>
                    <li><b>initenv.sh – Inicio de sesión en IBM Cloud </b><br />
                    Ejecute el script <b>initenv.sh</b> para crear un entorno para compilar y ejecutar {{ site.data.keys.mf_analytics }} en IBM Containers:
{% highlight bash %}
./initenv.sh args/initenv.properties
{% endhighlight %}

                        <div class="panel-group accordion" id="terminology-analytics-initenv" role="tablist">
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="script-analytics-initenv">
                                    <h4 class="panel-title">
                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-analytics-initenv" data-target="#collapse-script-analytics-initenv" aria-expanded="false" aria-controls="collapse-script-analytics-initenv"><b>Pulse para obtener una lista de argumentos de línea de mandatos</b></a>
                                    </h4>
                                </div>

                                <div id="collapse-script-analytics-initenv" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-analytics-initenv">
                                    <div class="panel-body">
                                        <table class="table table-striped">
                                            <tr>
                                                <td><b>Argumento de línea de mandatos</b></td>
                                                <td><b>Descripción</b></td>
                                            </tr>
                                            <tr>
                                                <td>[-u|--user] IBM_CLOUD_USER</td>
                                                <td>ID de usuario o dirección de correo electrónico de IBM Cloud</td>
                                            </tr>
                                            <tr>
                                                <td>[-p|--password] IBM_CLOUD_PASSWORD	</td>
                                                <td>Contraseña de IBM Cloud</td>
                                            </tr>
                                            <tr>
                                                <td>[-o|--org] IBM_CLOUD_ORG	</td>
                                                <td>Nombre de organización de IBM Cloud</td>
                                            </tr>
                                            <tr>
                                                <td>[-s|--space] IBM_CLOUD_SPACE	</td>
                                                <td>Nombre de espacio de IBM Cloud</td>
                                            </tr>
                                            <tr>
                                                <td>Opcional. [-a|--api] IBM_CLOUD_API_URL	</td>
                                                <td>Punto final de API de IBM Cloud. (El valor predeterminado es: https://api.ng.bluemix.net)</td>
                                            </tr>
                                        </table>

                                        <p>Por ejemplo:</p>
{% highlight bash %}
initenv.sh --user IBM_CLOUD_user_ID --password IBM_CLOUD_password --org IBM_CLOUD_organization_name --space IBM_CLOUD_space_name
{% endhighlight %}

                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-analytics-initenv" data-target="#collapse-script-analytics-initenv" aria-expanded="false" aria-controls="collapse-script-analytics-initenv"><b>Cerrar sección</b></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </li>
                    <li><b>prepareanalytics.sh - Prepare una imagen de {{ site.data.keys.mf_analytics }}</b><br />
                        Ejecute el script <b>prepareanalytics.sh</b> para crear una imagen de {{ site.data.keys.mf_analytics }} y enviarla mediante push al repositorio de IBM Cloud:

{% highlight bash %}
./prepareanalytics.sh args/prepareanalytics.properties
{% endhighlight %}

                        Para ver todas las imágenes disponibles en el repositorio de IBM Cloud, ejecute: <code>cf ic images</code><br/>
                        La lista contiene el nombre, la fecha de creación y el ID de la imagen.

                        <div class="panel-group accordion" id="terminology-analytics-prepareanalytics" role="tablist">
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="script-analytics-prepareanalytics">
                                    <h4 class="panel-title">
                                      <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-analytics-prepareanalytics" data-target="#collapse-script-analytics-prepareanalytics" aria-expanded="false" aria-controls="collapse-script-analytics-prepareanalytics"><b>Pulse para obtener una lista de argumentos de línea de mandatos</b></a>
                                    </h4>
                                </div>

                                <div id="collapse-script-analytics-prepareanalytics" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-analytics-prepareanalytics">
                                    <div class="panel-body">
                                        <table class="table table-striped">
                                            <tr>
                                              <td><b>Argumento de línea de mandatos</b></td>
                                              <td><b>Descripción</b></td>
                                            </tr>
                                            <tr>
                                              <td>[-t|--tag] ANALYTICS_IMAGE_TAG	</td>
                                              <td>El nombre que se utilizará para la imagen personalizada de Analytics. Formato: IBM Cloud registry URL/private namespace/image name</td>
                                            </tr>      
                                        </table>

                                        <p>Por ejemplo:</p>
{% highlight bash %}
prepareanalytics.sh --tag registry.ng.bluemix.net/your_private_repository_namespace/mfpfanalytics80
{% endhighlight %}

                                      <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-analytics-prepareanalytics" data-target="#collapse-script-analytics-prepareanalytics" aria-expanded="false" aria-controls="collapse-script-analytics-prepareanalytics"><b>Cerrar sección</b></a>
                                  </div>
                              </div>
                          </div>
                      </div>

                    </li>
                    <li><b>startanalytics.sh - Ejecutar la imagen en un IBM Container</b><br />
                    El script <b>startanalytics.sh</b> se utiliza para ejecutar la imagen de {{ site.data.keys.mf_analytics }} en un IBM Container. También enlaza la imagen con la IP pública que ha configurado en la propiedad <b>ANALYTICS_IP</b>.</li>

                    Ejecute:
{% highlight bash %}
./startanalytics.sh args/startanalytics.properties
{% endhighlight %}

                        <div class="panel-group accordion" id="terminology-analytics-startanalytics" role="tablist">
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="script-analytics-startanalytics">
                                    <h4 class="panel-title">
                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-analytics-startanalytics" data-target="#collapse-script-analytics-startanalytics" aria-expanded="false" aria-controls="collapse-script-analytics-startanalytics"><b>Pulse para obtener una lista de argumentos de línea de mandatos</b></a>
                                    </h4>
                                </div>

                                <div id="collapse-script-analytics-startanalytics" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-analytics-startanalytics">
                                    <div class="panel-body">
                                        <table class="table table-striped">
                                            <tr>
                                                <td><b>Argumento de línea de mandatos</b></td>
                                                <td><b>Descripción</b></td>
                                            </tr>
                                            <tr>
                                                <td>[-t|--tag] ANALYTICS_IMAGE_TAG	</td>
                                                <td>El nombre de la imagen del contenedor de Analytics que se ha cargado en el registro de IBM Containers. Formato: IBMCloudRegistry/PrivateNamespace/ImageName:Tag</td>
                                            </tr>
                                            <tr>
                                                <td>[-n|--name] ANALYTICS_CONTAINER_NAME	</td>
                                                <td>El nombre del contenedor de Analytics</td>
                                            </tr>
                                            <tr>
                                                <td>[-i|--ip] ANALYTICS_IP	</td>
                                                <td>La dirección IP a la que se debe enlazar el contenedor. (Puede proporcionar una IP pública o solicitar una utilizando el mandato <code>cf ic ip request</code>).</td>
                                            </tr>
                                            <tr>
                                                <td>Opcional. [-h|--http] EXPOSE_HTTP	</td>
                                                <td>Exponer el puerto HTTP. Los valores aceptados son Y (valor predeterminado) o N.</td>
                                            </tr>
                                            <tr>
                                                <td>Opcional. [-s|--https] EXPOSE_HTTPS	</td>
                                                <td>Exponer el puerto HTTPS. Los valores aceptados son Y (valor predeterminado) o N.</td>
                                            </tr>
                                            <tr>
                                                <td>Opcional. [-m|--memory] SERVER_MEM	</td>
                                                <td>Asigne un límite de tamaño de memoria al contenedor en megabytes (MB). Los valores aceptados son 1024 MB (valor predeterminado) y 2048 MB.</td>
                                            </tr>
                                            <tr>
                                                <td>Opcional. [-se|--ssh] SSH_ENABLE	</td>
                                                <td>Habilitar SSH para el contenedor. Los valores aceptados son Y (valor predeterminado) o N.</td>
                                            </tr>
                                            <tr>
                                                <td>Opcional. [-sk|--sshkey] SSH_KEY	</td>
                                                <td>La clave SSH que se inyectará en el contenedor. (Proporcione el contenido de su archivo id_rsa.pub).</td>
                                            </tr>
                                            <tr>
                                                <td>Opcional. [-tr|--trace] TRACE_SPEC	</td>
                                                <td>La especificación de rastreo que se ha de aplicar. Valor predeterminado: <code>*=info</code></td>
                                            </tr>
                                            <tr>
                                                <td>Opcional. [-ml|--maxlog] MAX_LOG_FILES	</td>
                                                <td>El número máximo de archivos de registro que se ha de mantener antes de que se sobrescriban. El valor predeterminado es de 5 archivos.</td>
                                            </tr>
                                            <tr>
                                                <td>Opcional. [-ms|--maxlogsize] MAX_LOG_FILE_SIZE	</td>
                                                <td>El tamaño máximo de un archivo de registro. El tamaño predeterminado es de 20 MB.</td>
                                            </tr>
                                            <tr>
                                                <td>Opcional. [-v|--volume] ENABLE_VOLUME	</td>
                                                <td>Habilitar el montaje de volúmenes para los registros del contenedor. Los valores aceptados son Y o N (valor predeterminado).</td>
                                            </tr>
                                            <tr>
                                                <td>Opcional. [-ev|--enabledatavolume] ENABLE_ANALYTICS_DATA_VOLUME	</td>
                                                <td>Habilitar el montaje de volúmenes para los datos de Analytics. Los valores aceptados son Y o N (valor predeterminado).</td>
                                            </tr>
                                            <tr>
                                                <td>Opcional. [-av|--datavolumename] ANALYTICS_DATA_VOLUME_NAME	</td>
                                                <td>Especifique el nombre del volumen que se ha de crear y montar para los datos de Analytics. El nombre predeterminado es <b>mfpf_analytics_container_name</b>.</td>
                                            </tr>
                                            <tr>
                                                <td>Opcional. [-ad|--analyticsdatadirectory] ANALYTICS_DATA_DIRECTORY	</td>
                                                <td>Especifique la ubicación para almacenar los datos. El nombre predeterminado de la carpeta es <b>/analyticsData.</b></td>
                                            </tr>
                                            <tr>
                                                <td>Opcional. [-e|--env] MFPF_PROPERTIES	</td>
                                                <td>Proporcione las propiedades de {{ site.data.keys.mf_analytics }} como pares de clave:valor separados por comas. Nota: Si especifica propiedades utilizando este script, asegúrese de que no se hayan establecido las mismas propiedades en la carpeta usr/config.</td>
                                            </tr>
                                        </table>

                                        <p>Por ejemplo:</p>
                        {% highlight bash %}
                        startanalytics.sh --tag image_tag_name --name container_name --ip container_ip_address
                        {% endhighlight %}

                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-analytics-startanalytics" data-target="#collapse-script-analytics-startanalytics" aria-expanded="false" aria-controls="collapse-script-analytics-startanalytics"><b>Cerrar sección</b></a>
                                    </div>
                                </div>
                            </div>
                        </div>   
                    <li><b>startanalyticsgroup.sh - Ejecutar la imagen en un grupo de IBM Container</b><br />
                        El script <b>startanalyticsgroup.sh</b> se utiliza para ejecutar la imagen de {{ site.data.keys.mf_analytics }} en un grupo de IBM Container. También enlaza la imagen con el nombre de host que ha configurado en la propiedad <b>ANALYTICS_CONTAINER_GROUP_HOST</b>.

                        Ejecute:
{% highlight bash %}
./startanalyticsgroup.sh args/startanalyticsgroup.properties
{% endhighlight %}

                        <div class="panel-group accordion" id="terminology-analytics-startanalyticsgroup" role="tablist">
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="script-analytics-startanalyticsgroup">
                                    <h4 class="panel-title">
                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-analytics-startanalyticsgroup" data-target="#collapse-script-analytics-startanalyticsgroup" aria-expanded="false" aria-controls="collapse-script-analytics-startanalyticsgroup"><b>Pulse para obtener una lista de argumentos de línea de mandatos</b></a>
                                    </h4>
                                </div>

                                <div id="collapse-script-analytics-startanalyticsgroup" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-analytics-startanalyticsgroup">
                                    <div class="panel-body">
                                        <table class="table table-striped">
                                            <tr>
                                                <td><b>Argumento de línea de mandatos</b></td>
                                                <td><b>Descripción</b></td>
                                            </tr>
                                            <tr>
                                                <td>[-t|--tag] ANALYTICS_IMAGE_TAG	</td>
                                                <td>El nombre de la imagen del contenedor de Analytics que se ha cargado en el registro de IBM Containers. Formato: IBMCloudRegistry/PrivateNamespace/ImageName:Tag</td>
                                            </tr>
                                            <tr>
                                                <td>[-gn|--name] ANALYTICS_CONTAINER_GROUP_NAME	</td>
                                                <td>El nombre del grupo de contenedores de Analytics.</td>
                                            </tr>
                                            <tr>
                                                <td>[-gh|--host] ANALYTICS_CONTAINER_GROUP_HOST	</td>
                                                <td>El nombre de host de la ruta.</td>
                                            </tr>
                                            <tr>
                                                <td>[-gs|--domain] ANALYTICS_CONTAINER_GROUP_DOMAIN	</td>
                                                <td>El nombre de dominio de la ruta.</td>
                                            </tr>
                                            <tr>
                                                <td>Opcional. [-gm|--min] ANALYTICS_CONTAINER_GROUP_MIN</td>
                                                <td>El número mínimo de instancias de contenedor. El valor predeterminado es 1.</td>
                                            </tr>
                                            <tr>
                                                <td>Opcional. [-gx|--max] ANALYTICS_CONTAINER_GROUP_MAX	</td>
                                                <td>El número máximo de instancias de contenedor. El valor predeterminado es 1.</td>
                                            </tr>
                                            <tr>
                                                <td>Opcional. [-gd|--desired] ANALYTICS_CONTAINER_GROUP_DESIRED	</td>
                                                <td>El número deseado de instancias de contenedor. El valor predeterminado es 2.</td>
                                            </tr>
                                            <tr>
                                                <td>Opcional. [-tr|--trace] TRACE_SPEC	</td>
                                                <td>La especificación de rastreo que se ha de aplicar. Valor predeterminado: <code>*=info</code></td>
                                            </tr>
                                            <tr>
                                                <td>Opcional. [-ml|--maxlog] MAX_LOG_FILES	</td>
                                                <td>El número máximo de archivos de registro que se ha de mantener antes de que se sobrescriban. El valor predeterminado es de 5 archivos.</td>
                                            </tr>
                                            <tr>
                                                <td>Opcional. [-ms|--maxlogsize] MAX_LOG_FILE_SIZE	</td>
                                                <td>El tamaño máximo de un archivo de registro. El tamaño predeterminado es de 20 MB.</td>
                                            </tr>
                                            <tr>
                                                <td>Opcional. [-e|--env] MFPF_PROPERTIES	</td>
                                                <td>Proporcione las propiedades de {{ site.data.keys.product_adj }} como pares de clave:valor separados por comas. Ejemplo: <code>mfp.analytics.url:http://127.0.0.1/analytics-service/rest/v2</code></td>
                                            </tr>
                                            <tr>
                                                <td>Opcional. [-m|--memory] SERVER_MEM	</td>
                                                <td>Asigne un límite de tamaño de memoria al contenedor en megabytes (MB). Los valores aceptados son 1024 MB (valor predeterminado) y 2048 MB.</td>
                                            </tr>
                                            <tr>
                                                <td>Opcional. [-v|--volume] ENABLE_VOLUME	</td>
                                                <td>Habilitar el montaje de volúmenes para los registros del contenedor. Los valores aceptados son Y o N (valor predeterminado).</td>
                                            </tr>
                                            <tr>
                                                <td>Opcional. [-av|--datavolumename] ANALYTICS_DATA_VOLUME_NAME	</td>
                                                <td>Especifique el nombre del volumen que se ha de crear y montar para los datos de Analytics. El valor predeterminado es <b>mfpf_analytics_ANALYTICS_CONTAINER_GROUP_NAME</b></td>
                                            </tr>
                                            <tr>
                                                <td>Opcional. [-ad|--analyticsdatadirectory] ANALYTICS_DATA_DIRECTORY	</td>
                                                <td>Especifique el directorio que se utilizará para almacenar los datos de Analytics. El valor predeterminado es <b>/analyticsData</b></td>
                                            </tr>
                                        </table>

                                        <p>Por ejemplo:</p>
{% highlight bash %}
startanalyticsgroup.sh --tag image_name --name container_group_name --host container_group_host_name --domain container_group_domain_name
{% endhighlight %}

                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-analytics-startanalyticsgroup" data-target="#collapse-script-analytics-startanalyticsgroup" aria-expanded="false" aria-controls="collapse-script-analytics-startanalyticsgroup"><b>Cerrar sección</b></a>
                                    </div>
                                </div>
                            </div>
                        </div>   
                    </li>
                </ol>
                Inicie Analytics Console cargando el URL siguiente: http://ANALYTICS-CONTAINER-HOST/analytics/console (puede tardar algunos minutos).  
            </div>
        </div>
    </div>
</div>

### {{ site.data.keys.mf_server }}
{: #mobilefirst-server}
<div class="panel-group accordion" id="scripts2" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="step-foundation-1">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#scripts2" data-target="#collapse-step-foundation-1" aria-expanded="false" aria-controls="collapse-step-foundation-1">Utilización de los archivos de configuración</a>
            </h4>
        </div>

        <div id="collapse-step-foundation-1" class="panel-collapse collapse" role="tabpanel">
            <div class="panel-body">
                La carpeta <b>args</b> contiene un conjunto de archivos de configuración que contiene los argumentos necesarios para ejecutar los scripts. Rellene los valores de los argumentos en los archivos siguientes:<br/>

                <h4>initenv.properties</h4>
                <ul>
                    <li><b>IBM_CLOUD_USER - </b>Su nombre de usuario de IBM Cloud (correo electrónico).</li>
                    <li><b>IBM_CLOUD_PASSWORD - </b>Su contraseña de IBM Cloud.</li>
                    <li><b>IBM_CLOUD_ORG - </b>El nombre de su organización de IBM Cloud.</li>
                    <li><b>IBM_CLOUD_SPACE - </b>Su espacio IBM Cloud (como se ha descrito anteriormente).</li>
                </ul>
                <h4>prepareserverdbs.properties</h4>
                El servicio de {{ site.data.keys.mf_bm_short }} requiere una instancia de <a href="https://console.ng.bluemix.net/catalog/services/dashdb/" target="\_blank"><i>base de datos de dashDB Enterprise Transactional</i></a> (<i>Enterprise Transactional 2.8.500</i> o <i>Enterprise Transactional 12.128.1400</i>).<br/>
                <b>Nota:</b> El despliegue de los planes dashDB Enterprise Transactional puede no ser inmediato. Es posible que el equipo de ventas le contacte antes del despliegue del servicio.<br/><br/>
                Después de configurar la instancia de dashDB, proporcione los argumentos necesarios:
                <ul>
                    <li><b>ADMIN_DB_SRV_NAME - </b>El nombre de su instancia de servicio de dashDB, para almacenar sus datos de administrador.</li>
                    <li><b>ADMIN_SCHEMA_NAME - </b>Su nombre de esquema para los datos de administrador. El valor predeterminado es MFPDATA.</li>
                    <li><b>RUNTIME_DB_SRV_NAME - </b>El nombre de su instancia de servicio de dashDB, para almacenar sus datos de tiempo de ejecución. El valor predeterminado es el nombre de servicio de administración.</li>
                    <li><b>RUNTIME_SCHEMA_NAME - </b>Su nombre de esquema para los datos de tiempo de ejecución. El valor predeterminado es MFPDATA.</li>
                    <b>Nota:</b> Si su instancia de servicio de dashDB la comparten muchos usuarios, asegúrese de que proporciona nombres de esquema exclusivos.
                </ul><br/>
                <h4>prepareserver.properties</h4>
                <ul>
                  <li><b>SERVER_IMAGE_TAG - </b>Una etiqueta para la imagen. Debe tener el formato: <em>registry-url/namespace/your-tag</em>.</li>
                </ul>
                <h4>startserver.properties</h4>
                <ul>
                    <li><b>SERVER_IMAGE_TAG - </b>Igual que en <em>prepareserver.sh</em>.</li>
                    <li><b>SERVER_CONTAINER_NAME - </b>Un nombre para el contenedor IBM Cloud.</li>
                    <li><b>SERVER_IP - </b>Una dirección IP a la que se puede enlazar el contenedor de IBM Cloud.<br/>
                    Para asignar una dirección IP, ejecute: <code>cf ic ip request</code>.<br/>
                    Las direcciones IP se pueden reutilizar en varios contenedores de un espacio.<br/>
                    Si ya tiene asignada una, puede ejecutar: <code>cf ic ip list</code>.</li>
                    <li><b>MFPF_PROPERTIES - Propiedades JNDI de </b>{{ site.data.keys.mf_server }} separadas por comas (<b>sin espacios</b>). Las propiedades relacionadas con Analytics se definen de este modo: <code>MFPF_PROPERTIES=mfp/mfp.analytics.url:http://ANALYTICS-CONTAINER-IP:9080/analytics-service/rest,mfp/mfp.analytics.console.url:http://ANALYTICS-CONTAINER-IP:9080/analytics/console,mfp/mfp.analytics.username:ANALYTICS_USERNAME,mfp/mfp.analytics.password:ANALYTICS_PASSWORD</code></li>
                </ul>
                <h4>startservergroup.properties</h4>
                <ul>
                    <li><b>SERVER_IMAGE_TAG - </b>Igual que en <em>prepareserver.sh</em>.</li>
                    <li><b>SERVER_CONTAINER_GROUP_NAME - </b>Un nombre para el grupo de contenedores de IBM Cloud.</li>
                    <li><b>SERVER_CONTAINER_GROUP_HOST - </b>Su nombre de host.</li>
                    <li><b>SERVER_CONTAINER_GROUP_DOMAIN - </b>El nombre del dominio. El valor predeterminado es: <code>mybluemix.net</code>.</li>
                    <li><b>MFPF_PROPERTIES - Propiedades JNDI de </b>{{ site.data.keys.mf_server }} separadas por comas (<b>sin espacios</b>). Las propiedades relacionadas con Analytics se definen de este modo: <code>MFPF_PROPERTIES=mfp/mfp.analytics.url:http://ANALYTICS_CONTAINER_GROUP_HOSTNAME:80/analytics-service/rest,mfp/mfp.analytics.console.url:http://ANALYTICS_CONTAINER_GROUP_HOSTNAME:80/analytics/console,mfp/mfp.analytics.username:ANALYTICS_USERNAME,mfp/mfp.analytics.password:ANALYTICS_PASSWORD</code></li>
                </ul>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="step-foundation-2">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#scripts2" data-target="#collapse-step-foundation-2" aria-expanded="false" aria-controls="collapse-step-foundation-2">Ejecución de los scripts</a>
            </h4>
        </div>

        <div id="collapse-step-foundation-2" class="panel-collapse collapse" role="tabpanel">
            <div class="panel-body">
            <p>Las siguientes instrucciones muestran cómo ejecutar los scripts utilizando los archivos de configuración. También está disponible una lista de argumentos de línea de mandatos, si opta por ejecutarlos fuera del modo interactivo:</p>

            <ol>
                <li><b>initenv.sh – Inicio de sesión en IBM Cloud </b><br />
                    Ejecute el script <b>initenv.sh</b> para crear un entorno para compilar y ejecutar {{ site.data.keys.product }} en IBM Containers:
{% highlight bash %}
./initenv.sh args/initenv.properties
{% endhighlight %}

                    <div class="panel-group accordion" id="terminology-initenv" role="tablist">
                        <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="script-initenv">
                                <h4 class="panel-title">
                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-initenv" data-target="#collapse-script-initenv" aria-expanded="false" aria-controls="collapse-script-initenv"><b>Pulse para obtener una lista de argumentos de línea de mandatos</b></a>
                                </h4>
                            </div>

                            <div id="collapse-script-initenv" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-initenv">
                                <div class="panel-body">
                                    <table class="table table-striped">
                                        <tr>
                                            <td><b>Argumento de línea de mandatos</b></td>
                                            <td><b>Descripción</b></td>
                                        </tr>
                                        <tr>
                                            <td>[-u|--user] IBM_CLOUD_USER</td>
                                            <td>ID de usuario o dirección de correo electrónico de IBM Cloud</td>
                                        </tr>
                                        <tr>
                                            <td>[-p|--password] IBM_CLOUD_PASSWORD	</td>
                                            <td>Contraseña de IBM Cloud</td>
                                        </tr>
                                        <tr>
                                            <td>[-o|--org] IBM_CLOUD_ORG	</td>
                                            <td>Nombre de organización de IBM Cloud</td>
                                        </tr>
                                        <tr>
                                            <td>[-s|--space] IBM_CLOUD_SPACE	</td>
                                            <td>Nombre de espacio de IBM Cloud</td>
                                        </tr>
                                        <tr>
                                            <td>Opcional. [-a|--api] IBM_CLOUD_API_URL	</td>
                                            <td>Punto final de API de IBM Cloud. (El valor predeterminado es: https://api.ng.bluemix.net)</td>
                                        </tr>
                                    </table>

                                    <p>Por ejemplo:</p>
{% highlight bash %}
initenv.sh --user IBM_CLOUD_user_ID --password IBM_CLOUD_password --org IBM_CLOUD_organization_name --space IBM_CLOUD_space_name
{% endhighlight %}

                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-initenv" data-target="#collapse-script-initenv" aria-expanded="false" aria-controls="collapse-script-initenv"><b>Cerrar sección</b></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </li>
                <li><b>prepareserverdbs.sh - Prepare la base de datos de {{ site.data.keys.mf_server }}</b><br />
                    El script <b>prepareserverdbs.sh</b> se utiliza para configurar {{ site.data.keys.mf_server }} con el servicio de base de datos dashDB. La instancia de servicio de dashDB debe estar disponible en la organización y el espacio en que ha iniciado sesión en el paso 1. Ejecute lo siguiente:
{% highlight bash %}
./prepareserverdbs.sh args/prepareserverdbs.properties
{% endhighlight %}

                    <div class="panel-group accordion" id="terminology-prepareserverdbs" role="tablist">
                        <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="script-prepareserverdbs">
                                <h4 class="panel-title">
                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-prepareserverdbs" data-target="#collapse-script-prepareserverdbs" aria-expanded="false" aria-controls="collapse-script-prepareserverdbs"><b>Pulse para obtener una lista de argumentos de línea de mandatos</b></a>
                                </h4>
                            </div>

                            <div id="collapse-script-prepareserverdbs" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-prepareserverdbs">
                                <div class="panel-body">
                                    <table class="table table-striped">
                                        <tr>
                                            <td><b>Argumento de línea de mandatos</b></td>
                                            <td><b>Descripción</b></td>
                                        </tr>
                                        <tr>
                                            <td>[-adl |--admindb ] ADMIN_DB_SRV_NAME	</td>
                                            <td>Servicio dashDB de IBM Cloud (con el plan de servicio IBM Cloud Enterprise Transactional).</td>
                                        </tr>
                                        <tr>
                                            <td>Opcional. [-as |--adminschema ] ADMIN_SCHEMA_NAME	</td>
                                            <td>Nombre de esquema de base de datos para el servicio de administración. El valor predeterminado es MFPDATA.</td>
                                        </tr>
                                        <tr>
                                            <td>Opcional. [-rd |--runtimedb ] RUNTIME_DB_SRV_NAME	</td>
                                            <td>El nombre de la instancia de servicio de base de datos IBM Cloud para almacenar datos de tiempo de ejecución. El valor predeterminado es el mismo servicio que el proporcionado para los datos de administración.</td>
                                        </tr>
                                        <tr>
                                            <td>Opcional. [-p |--push ] ENABLE_PUSH	</td>
                                            <td>Habilitar la configuración de la base de datos para el servicio push. Los valores aceptados son Y (valor predeterminado) o N.</td>
                                        </tr>
                                        <tr>
                                            <td>[-pd |--pushdb ] PUSH_DB_SRV_NAME	</td>
                                            <td>El nombre de la instancia de servicio de base de datos IBM Cloud para almacenar datos de push. El valor predeterminado es el mismo servicio que el proporcionado para los datos de tiempo de ejecución.</td>
                                        </tr>
                                        <tr>
                                            <td>[-ps |--pushschema ] PUSH_SCHEMA_NAME	</td>
                                            <td>Nombre de esquema de base de datos para el servicio push. El valor predeterminado es el nombre de esquema de tiempo de ejecución.</td>
                                        </tr>
                                    </table>

                                    <p>Por ejemplo:</p>
{% highlight bash %}
prepareserverdbs.sh --admindb MFPDashDBService
{% endhighlight %}

                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-prepareserverdbs" data-target="#collapse-script-prepareserverdbs" aria-expanded="false" aria-controls="collapse-server-env"><b>Cerrar sección</b></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </li>
                <li><b>initenv.sh (Opcional) – Inicio de sesión en IBM Cloud </b><br />
                      Este paso solo es necesario si necesita crear contenedores en una organización y espacio diferentes a aquellos en los que está disponible la instancia de servicio de dashDB. Si es así, actualice initenv.properties con la nueva organización y espacio en que se han creado los contenedores (y se han iniciado), y vuelva a ejecutar el script <b>initenv.sh</b>:
{% highlight bash %}
./initenv.sh args/initenv.properties
{% endhighlight %}

                </li>
                <li><b>prepareserver.sh - Preparar una imagen de {{ site.data.keys.mf_server }}</b><br />
                    Ejecute el script <b>prepareserver.sh</b> para crear una imagen de {{ site.data.keys.mf_server }} y enviarla mediante push al repositorio de IBM Cloud. Para ver todas las imágenes disponibles en el repositorio de IBM Cloud, ejecute: <code>cf ic images</code><br/>
                    La lista contiene el nombre, la fecha de creación y el ID de la imagen.<br/>

{% highlight bash %}
./prepareserver.sh args/prepareserver.properties
{% endhighlight %}

                    <div class="panel-group accordion" id="terminology-prepareserver" role="tablist">
                        <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="script-prepareserver">
                                <h4 class="panel-title">
                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-prepareserver" data-target="#collapse-script-prepareserver" aria-expanded="false" aria-controls="collapse-script-prepareserver"><b>Pulse para obtener una lista de argumentos de línea de mandatos</b></a>
                                </h4>
                            </div>

                            <div id="collapse-script-prepareserver" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-prepareserver">
                                <div class="panel-body">
                                    <table class="table table-striped">
                                        <tr>
                                            <td><b>Argumento de línea de mandatos</b></td>
                                            <td><b>Descripción</b></td>
                                        </tr>
                                        <tr>
                                            <td>[-t|--tag] SERVER_IMAGE_NAME	</td>
                                            <td>El nombre que se utilizará para la imagen personalizada de {{ site.data.keys.mf_server }}. Formato: registryUrl/namespace/imagename</td>
                                        </tr>
                                    </table>

                                    <p>Por ejemplo:</p>
{% highlight bash %}
prepareserver.sh --tag SERVER_IMAGE_NAME registryUrl/namespace/imagename
{% endhighlight %}

                                  <br/>
                                  <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-prepareserver" data-target="#collapse-script-prepareserver" aria-expanded="false" aria-controls="collapse-script-prepareserver"><b>Cerrar sección</b></a>
                              </div>
                          </div>
                        </div>
                    </div>  
                </li>
                <li><b>startserver.sh - Ejecutar la imagen en un IBM Container</b><br />
                    El script <b>startserver.sh</b> se utiliza para ejecutar la imagen de {{ site.data.keys.mf_server }} en un IBM Container. También enlaza la imagen con la IP pública que ha configurado en la propiedad <b>SERVER_IP</b>. Ejecute:</li>
{% highlight bash %}
./startserver.sh args/startserver.properties
{% endhighlight %}

                    <div class="panel-group accordion" id="terminology-startserver" role="tablist">
                        <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="script-startserver">
                                <h4 class="panel-title">
                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-startserver" data-target="#collapse-script-startserver" aria-expanded="false" aria-controls="collapse-script-startserver"><b>Pulse para obtener una lista de argumentos de línea de mandatos</b></a>
                                </h4>
                            </div>
                            <div id="collapse-script-startserver" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-startserver">
                            <div class="panel-body">
                                <table class="table table-striped">
                                    <tr>
                                        <td><b>Argumento de línea de mandatos</b></td>
                                        <td><b>Descripción</b></td>
                                    </tr>
                                    <tr>
                                        <td>[-t|--tag] SERVER_IMAGE_TAG	</td>
                                        <td>Nombre de la imagen de {{ site.data.keys.mf_server }}.</td>
                                    </tr>
                                    <tr>
                                        <td>[-i|--ip] SERVER_IP	</td>
                                        <td>La dirección IP a la que se debe enlazar el contenedor de {{ site.data.keys.mf_server }}. (Puede proporcionar una IP pública o solicitar una utilizando el mandato <code>cf ic ip request</code>).</td>
                                    </tr>
                                    <tr>
                                        <td>Opcional. [-si|--services] SERVICE_INSTANCES	</td>
                                        <td>Las instancias de servicio de IBM Cloud, separadas por comas, que desea enlazar con el contenedor.</td>
                                    </tr>
                                    <tr>
                                        <td>Opcional. [-h|--http] EXPOSE_HTTP	</td>
                                        <td>Exponer el puerto HTTP. Los valores aceptados son Y (valor predeterminado) o N.</td>
                                    </tr>
                                    <tr>
                                        <td>Opcional. [-s|--https] EXPOSE_HTTPS	</td>
                                        <td>Exponer el puerto HTTPS. Los valores aceptados son Y (valor predeterminado) o N.</td>
                                    </tr>
                                    <tr>
                                        <td>Opcional. [-m|--memory] SERVER_MEM	</td>
                                        <td>Asigne un límite de tamaño de memoria al contenedor en megabytes (MB). Los valores aceptados son 1024 MB (valor predeterminado) y 2048 MB.</td>
                                    </tr>
                                    <tr>
                                        <td>Opcional. [-se|--ssh] SSH_ENABLE	</td>
                                        <td>Habilitar SSH para el contenedor. Los valores aceptados son Y (valor predeterminado) o N.</td>
                                    </tr>
                                    <tr>
                                        <td>Opcional. [-sk|--sshkey] SSH_KEY	</td>
                                        <td>La clave SSH que se inyectará en el contenedor. (Proporcione el contenido de su archivo id_rsa.pub).</td>
                                    </tr>
                                    <tr>
                                        <td>Opcional. [-tr|--trace] TRACE_SPEC	</td>
                                        <td>La especificación de rastreo que se ha de aplicar. Valor predeterminado: <code>*=info</code></td>
                                    </tr>
                                    <tr>
                                        <td>Opcional. [-ml|--maxlog] MAX_LOG_FILES	</td>
                                        <td>El número máximo de archivos de registro que se ha de mantener antes de que se sobrescriban. El valor predeterminado es de 5 archivos.</td>
                                    </tr>
                                    <tr>
                                        <td>Opcional. [-ms|--maxlogsize] MAX_LOG_FILE_SIZE	</td>
                                        <td>El tamaño máximo de un archivo de registro. El tamaño predeterminado es de 20 MB.</td>
                                    </tr>
                                    <tr>
                                        <td>Opcional. [-v|--volume] ENABLE_VOLUME	</td>
                                        <td>Habilitar el montaje de volúmenes para los registros del contenedor. Los valores aceptados son Y o N (valor predeterminado).</td>
                                    </tr>
                                    <tr>
                                        <td>Opcional. [-e|--env] MFPF_PROPERTIES	</td>
                                        <td>Proporcione las propiedades de {{ site.data.keys.product_adj }} como pares de clave:valor separados por comas. Ejemplo: <code>mfp.analytics.url:http://127.0.0.1/analytics-service/rest,mfp.analytics.console.url:http://127.0.0.1/analytics/console</code>.  <b>Nota:</b> Si especifica propiedades utilizando este script, asegúrese de que no se hayan establecido las mismas propiedades en la carpeta usr/config.</td>
                                    </tr>
                                </table>

                                <p>Por ejemplo:</p>
{% highlight bash %}
startserver.sh --tag image_tag_name --name container_name --ip container_ip_address
{% endhighlight %}

                                <br/>
                                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-startserver" data-target="#collapse-script-startserver" aria-expanded="false" aria-controls="collapse-script-startserver"><b>Cerrar sección</b></a>
                            </div>
                        </div>
                    </div>
                <li><b>startservergroup.sh - Ejecutar la imagen en un grupo de IBM Container</b><br />
                    El script <b>startservergroup.sh</b> se utiliza para ejecutar la imagen de {{ site.data.keys.mf_server }} en un grupo de IBM Container. También enlaza la imagen con el nombre de host que ha configurado en la propiedad <b>SERVER_CONTAINER_GROUP_HOST</b>.</li>
                    Ejecute:
{% highlight bash %}
./startservergroup.sh args/startservergroup.properties
{% endhighlight %}

                        <div class="panel-group accordion" id="terminology-startservergroup" role="tablist">
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="script-startservergroup">
                                    <h4 class="panel-title">
                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-startservergroup" data-target="#collapse-script-startservergroup" aria-expanded="false" aria-controls="collapse-script-startservergroup"><b>Pulse para obtener una lista de argumentos de línea de mandatos</b></a>
                                    </h4>
                                </div>

                                <div id="collapse-script-startservergroup" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-startservergroup">
                                    <div class="panel-body">
                                        <table class="table table-striped">
                                            <tr>
                                                <td><b>Argumento de línea de mandatos</b></td>
                                                <td><b>Descripción</b></td>
                                            </tr>
                                            <tr>
                                                <td>[-t|--tag] SERVER_IMAGE_TAG	</td>
                                                <td>El nombre de la imagen del contenedor de {{ site.data.keys.mf_server }} en el registro de IBM Cloud.</td>
                                            </tr>
                                            <tr>
                                                <td>[-gn|--name] SERVER_CONTAINER_NAME	</td>
                                                <td>El nombre del grupo de contenedores de {{ site.data.keys.mf_server }}.</td>
                                            </tr>
                                            <tr>
                                                <td>[-gh|--host] SERVER_CONTAINER_GROUP_HOST	</td>
                                                <td>El nombre de host de la ruta.</td>
                                            </tr>
                                            <tr>
                                                <td>[-gs|--domain] SERVER_CONTAINER_GROUP_DOMAIN	</td>
                                                <td>El nombre de dominio de la ruta.</td>
                                            </tr>
                                            <tr>
                                                <td>Opcional. [-gm|--min] SERVERS_CONTAINER_GROUP_MIN	</td>
                                                <td>El número mínimo de instancias de contenedor. El valor predeterminado es 1.</td>
                                            </tr>
                                            <tr>
                                                <td>Opcional. [-gx|--max] SERVER_CONTAINER_GROUP_MAX	</td>
                                                <td>El número máximo de instancias de contenedor. El valor predeterminado es 1.</td>
                                            </tr>
                                            <tr>
                                                <td>Opcional. [-gd|--desired] SERVER_CONTAINER_GROUP_DESIRED	</td>
                                                <td>El número deseado de instancias de contenedor. El valor predeterminado es 2.</td>
                                            </tr>
                                            <tr>
                                                <td>Opcional. [-a|--auto] ENABLE_AUTORECOVERY	</td>
                                                <td>Habilitar la recuperación automática para las instancias de contenedor. Los valores aceptados son Y o N (valor predeterminado).</td>
                                            </tr>

                                            <tr>
                                                <td>Opcional. [-si|--services] SERVICES	</td>
                                                <td>Los nombres de las instancias de servicio de IBM Cloud, separados por comas, que desea enlazar con el contenedor.</td>
                                            </tr>
                                            <tr>
                                                <td>Opcional. [-tr|--trace] TRACE_SPEC	</td>
                                                <td>La especificación de rastreo que se ha de aplicar. Valor predeterminado <code>*=info</code></td>
                                            </tr>
                                            <tr>
                                                <td>Opcional. [-ml|--maxlog] MAX_LOG_FILES	</td>
                                                <td>El número máximo de archivos de registro que se ha de mantener antes de que se sobrescriban. El valor predeterminado es de 5 archivos.</td>
                                            </tr>
                                            <tr>
                                                <td>Opcional. [-ms|--maxlogsize] MAX_LOG_FILE_SIZE	</td>
                                                <td>El tamaño máximo de un archivo de registro. El tamaño predeterminado es de 20 MB.</td>
                                            </tr>
                                            <tr>
                                                <td>Opcional. [-e|--env] MFPF_PROPERTIES	</td>
                                                <td>Proporcione las propiedades de {{ site.data.keys.product_adj }} como pares de clave:valor separados por comas. Ejemplo: <code>mfp.analytics.url:http://127.0.0.1/analytics-service/rest</code><br/> <code>mfp.analytics.console.url:http://127.0.0.1/analytics/console</code><br/>
                                                <b>Nota:</b> Si especifica propiedades utilizando este script, asegúrese de que no se hayan establecido las mismas propiedades en la carpeta usr/config.</td>
                                            </tr>
                                            <tr>
                                                <td>Opcional. [-m|--memory] SERVER_MEM	</td>
                                                <td>Asigne un límite de tamaño de memoria al contenedor en megabytes (MB). Los valores aceptados son 1024 MB (valor predeterminado) y 2048 MB.</td>
                                            </tr>
                                            <tr>
                                                <td>Opcional. [-v|--volume] ENABLE_VOLUME	</td>
                                                <td>Habilitar el montaje de volúmenes para los registros del contenedor. Los valores aceptados son Y o N (valor predeterminado).</td>
                                            </tr>
                                        </table>

                                        <p>Por ejemplo:</p>
{% highlight bash %}
startservergroup.sh --tag image_name --name container_group_name --host container_group_host_name --domain container_group_domain_name
{% endhighlight %}

                                        <br/>
                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-startservergroup" data-target="#collapse-script-startservergroup" aria-expanded="false" aria-controls="collapse-script-startservergroup"><b>Cerrar sección</b></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </ol>
            </div>
        </div>
    </div>
</div>

> **Nota:** Se deben reiniciar los contenedores después de realizar cualquier cambio de configuración (`cf ic restart containerId`). En el caso de los grupos de contenedores, debe reiniciar cada instancia de contenedor incluida en el grupo. Por ejemplo, si cambia un certificado raíz, se debe reiniciar cada instancia después de añadir el nuevo certificado.

Inicie {{ site.data.keys.mf_console }} cargando el URL siguiente: http://MF\_CONTAINER\_HOST/mfpconsole (puede tardar algunos minutos).  
Añada el servidor remoto siguiendo las instrucciones de la guía de aprendizaje [Utilización de {{ site.data.keys.mf_cli }} para gestionar artefactos de {{ site.data.keys.product_adj }}](../../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance).  

Ahora, con {{ site.data.keys.mf_server }} ejecutándose en IBM Cloud, puede iniciar el desarrollo de su aplicación. Revise las {{ site.data.keys.product }} [guías de aprendizaje](../../all-tutorials).

#### Limitación de números de puertos
{: #port-number-limitation }
En IBM Containers existe actualmente una limitación de los números de puertos disponibles para el dominio público. Por lo tanto, los números de puertos predeterminados proporcionados para el contenedor de {{ site.data.keys.mf_analytics }} y el contenedor de {{ site.data.keys.mf_server }} (9080 para HTTP y 9443 para HTTPS) no se pueden alterar. Los contenedores de un grupo de contenedores deben utilizar el puerto HTTP 9080. Los grupos de contenedores no admiten el uso de varios números de puertos o solicitudes HTTPS.


## Aplicar arreglos de {{ site.data.keys.mf_server }}
{: #applying-mobilefirst-server-fixes }

Los arreglos temporales para {{ site.data.keys.mf_server }} en IBM Containers se pueden obtener en [IBM Fix Central](http://www.ibm.com/support/fixcentral).  
Antes de aplicar un arreglo temporal, realice una copia de seguridad de los archivos de configuración existentes. Los archivos de configuración se encuentran en las carpetas siguientes:
* {{ site.data.keys.mf_analytics }}: **package_root/mfpf-analytics/usr**
* {{ site.data.keys.mf_server }} Liberty Cloud Foundry Application: **package_root/mfpf-server/usr**
* {{ site.data.keys.mf_app_center_short }}: **package_root/mfp-appcenter/usr**

### Pasos para aplicar iFix:

1. Descargue el archivo de arreglo temporal y extraiga el contenido en la carpeta de instalación existente, sobrescribiendo los archivos existentes.
2. Restaure los archivos de configuración de copia de seguridad en las carpetas **package_root/mfpf-analytics/usr**, **package_root/mfpf-server/usr** y **package_root/mfp-appcenter/usr**, sobrescribiendo los archivos de configuración instalados recientemente.
3. Edite el archivo **package_root/mfpf-server/usr/env/jvm.options** en su editor y elimine la siguiente línea, si existe:
```
-javaagent:/opt/ibm/wlp/usr/servers/mfp/newrelic/newrelic.jar”
```
    Ahora puede compilar y desplegar el servidor actualizado.

    a. Ejecute el script `prepareserver.sh` para volver a crear la imagen del servidor y enviarla mediante push al servicio IBM Containers.

    b. Ejecute el script `startserver.sh` para ejecutar la imagen del servidor como un servidor autónomo o un contenedor autónomo, o `startservergroup.sh` para ejecutar la imagen del servidor como un grupo de contenedores.

<!--**Note:** When applying fixes for {{ site.data.keys.mf_app_center }} the folders are `mfp-appcenter-libertyapp/usr` and `mfp-appcenter/usr`.-->

## Eliminar un contenedor de IBM Cloud
{: #removing-a-container-from-bluemix }
Cuando elimina un contenedor de IBM Cloud, también debe eliminar el nombre de imagen del registro.  
Ejecute los mandatos siguientes para eliminar un contenedor desde IBM Cloud:

1. `cf ic ps` (Lista los contenedores que se están ejecutando)
2. `cf ic stop container_id` (Detiene el contenedor)
3. `cf ic rm container_id` (Elimina el contenedor)

Ejecute los siguientes mandatos cf ic para eliminar un nombre de imagen del registro de IBM Cloud:

1. `cf ic images` (Lista las imágenes del registro)
2. `cf ic rmi image_id` (Elimina la imagen del registro)

## Eliminar la configuración del servicio de base de datos de IBM Cloud
{: #removing-the-database-service-configuration-from-bluemix }
Si ha ejecutado el script **prepareserverdbs.sh** durante la configuración de la imagen de {{ site.data.keys.mf_server }}, se crean las configuraciones y tablas de base de datos necesarias para {{ site.data.keys.mf_server }}. Este script también crea el esquema de base de datos para el contenedor.

Para eliminar la configuración del servicio de base de datos desde IBM Cloud, realice el siguiente procedimiento utilizando el panel de control de IBM Cloud.

1. En el panel de control de IBM Cloud, seleccione el servicio dashDB que ha utilizado. Seleccione el nombre del servicio dashDB que ha proporcionado como un parámetro cuando ejecutaba el script **prepareserverdbs.sh**.
2. Inicie la consola de dashDB para trabajar con los esquemas y los objetos de base de datos de la instancia de servicio dashDB seleccionada.
3. Seleccione los esquemas relacionados con la configuración de IBM {{ site.data.keys.mf_server }}. Los nombres de esquemas son los que ha proporcionado durante la ejecución del script **prepareserverdbs.sh**.
4. Suprima cada esquema después de inspeccionar detenidamente los nombres de esquemas y los objetos que se encuentran debajo de los mismos. Las configuraciones de base de datos se eliminan de IBM Cloud.

Del mismo modo, si ha ejecutado **prepareappcenterdbs.sh** durante la configuración de {{ site.data.keys.mf_app_center }}, siga los pasos anteriores para eliminar la configuración del servicio de base de datos en IBM Cloud.
