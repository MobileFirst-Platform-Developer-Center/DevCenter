---
layout: tutorial
title: Configuración de MobileFirst Application Center en IBM Cloud Kubernetes Cluster mediante scripts
breadcrumb_title: AppCenter on Kubernetes Cluster using scripts
relevantTo: [ios,android,windows,javascript]
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
<br/>
>**Nota:** Se recomienda utilizar Helm para desplegar software en Kubernetes Cluster. Obtenga información sobre cómo desplegar [Mobile Foundation en IBM Cloud Kubernetes Cluster mediante gráficos Helm](../../mobilefirst-server-on-kubernetes-using-helm).

## Visión general
{: #overview }
Siga estas instrucciones para configurar una instancia de {{ site.data.keys.mf_app_center }} en IBM Cloud. Para llevarlo a cabo, realice los pasos siguientes:

* Cree un tipo de Kubernetes Cluster: Estándar (clúster de pago).
* Configure el sistema host con las herramientas necesarias [Docker, Cloud Foundry CLI ( cf ), IBM Cloud CLI ( bx ), Container Service Plugin for IBM Cloud CLI ( bx cs ), Container Registry Plugin for IBM Cloud CLI ( bx cr ), Kubernetes CLI (kubectl)].
* Cree una imagen Docker de {{ site.data.keys.mf_app_center }} y envíela por push al repositorio de IBM Cloud.
* Finalmente, ejecutará la imagen de Docker en Kubernetes Cluster.

>**Nota:**  
>
* Actualmente el sistema operativo Windows no está soportado para ejecutar estos scripts.  
* Las herramientas de configuración de {{ site.data.keys.mf_server }} no se pueden utilizar para despliegues en IBM Containers.

#### Ir a:
{: #jump-to }
- [Visión general](#overview)
        - [Ir a:](#jump-to)
- [Registrar una cuenta en IBM Cloud](#register-an-account-on-ibm-cloud)
    - [Panel de control de IBM Cloud](#ibm-cloud-dashboard)
- [Configurar la máquina host](#set-up-your-host-machine)
- [Crear y configurar Kubernetes Cluster con IBM Cloud Container Service](#create-and-setup-a-kubernetes-cluster-with-ibm-cloud-container-service)
- [Descargar el archivo {{ site.data.keys.mf_bm_pkg_name }}](#download-the--sitedatakeysmfbmpkgname--archive)
- [Requisitos previos](#prerequisites)
- [Configuración de {{ site.data.keys.mf_app_center }} en Kubernetes Cluster con IBM Containers](#setting-up-the--sitedatakeysmfappcenter--on-kubernetes-cluster-with-ibm-containers)
    - [Pasos para aplicar iFix:](#steps-to-apply-the-ifix)
- [Eliminar el contenedor de IBM Cloud](#removing-the-container-from-ibm-cloud)
- [Eliminar los despliegues de Kubernetes de IBM Cloud](#removing-the-kubernetes-deployments-from-ibm-cloud)
- [Eliminar la configuración del servicio de base de datos de IBM Cloud](#removing-the-database-service-configuration-from-ibm-cloud)

## Registrar una cuenta en IBM Cloud
{: #register-an-account-on-ibmcloud }
Si todavía no tiene una cuenta, vaya al [sitio web de IBM Cloud](https://bluemix.net) y pulse **Iniciación gratuita** o **Iniciar sesión**. Debe rellenar un formulario de registro para ir al paso siguiente.

### Panel de control de IBM Cloud
{: #the-ibmcloud-dashboard }
Después de iniciar sesión en IBM Cloud, se le presentará el panel de control de IBM Cloud, que proporciona una visión general del **espacio** activo de IBM Cloud. De forma predeterminada, esta área de trabajo recibe el nombre de *dev*. Puede crear varios espacios o áreas de trabajo, si es necesario.

## Configurar la máquina host
{: #set-up-your-host-machine }
Para gestionar los contenedores y las imágenes, debe instalar las herramientas siguientes:
* Docker
* IBM Cloud CLI (bx)
* Container Service Plugin for IBM Cloud CLI ( bx cs )
* Container Registry Plugin for IBM Cloud CLI ( bx cr )
* Kubernetes CLI (kubectl)

Consulte la documentación de IBM Cloud para obtener información acerca de los [pasos para configurar CLI de requisito previo](https://console.bluemix.net/docs/containers/cs_cli_install.html#cs_cli_install_steps).

## Crear y configurar Kubernetes Cluster con IBM Cloud Container Service
{: #setup-kube-cluster}
Consulte la documentación de IBM Cloud para [configurar Kubernetes Cluster en IBM Cloud](https://console.bluemix.net/docs/containers/cs_cluster.html#cs_cluster_cli).

>**Nota:** Tipo de Kubernetes Cluster: Se requiere Estándar (clúster de pago) para desplegar {{ site.data.keys.mf_bm_short }}.

## Descargar el archivo {{ site.data.keys.mf_bm_pkg_name }}
{: #download-the-ibm-mfpf-container-8000-archive}
Para configurar {{ site.data.keys.mf_app_center }} como Kubernetes Cluster utilizando contenedores de IBM Cloud, en primer lugar, debe crear una imagen que posteriormente se enviará mediante push a IBM Cloud.<br/>
Se pueden obtener los arreglos internos para MobileFirst Server en IBM Containers en [IBM Fix Central](http://www.ibm.com/support/fixcentral).<br/>
Descargue el arreglo temporal más reciente desde Fix central. El soporte de Kubernetes está disponible en iFix **8.0.0.0-IF201708220656**.

El archivo contiene los archivos para crear una imagen (**dependencies** y **mfpf-libs**) y los archivos para compilar y desplegar un {{ site.data.keys.mf_app_center }} en Kubernetes (bmx-kubernetes).

<div class="panel-group accordion" id="terminology" role="tablist" aria-multiselectable="false">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="zip-file">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#zip-file" data-target="#collapse-zip-file" aria-expanded="false" aria-controls="collapse-adapter-xml"><b>Pulse para obtener más información sobre el contenido del archivo comprimido y las propiedades de entorno disponibles que se han de utilizar</b></a>
            </h4>
        </div>

        <div id="collapse-zip-file" class="panel-collapse collapse" role="tabpanel" aria-labelledby="zip-file">
            <div class="panel-body">
                <img src="zip.png" alt="Imagen que muestra la estructura del sistema de archivos del archivo comprimido" style="float:right;width:570px"/>
                <h4>carpeta bmx-kubernetes</h4>
                <p>Contiene los archivos de personalización y los scripts necesarios para desplegar Kubernetes Cluster con IBM Cloud Container Service.</p>

                <h4>Dockerfile-mfp-appcenter</h4>

                <ul>
                    <li><b>Dockerfile-mfp-appcenter</b>: Documento de texto que contiene todos los mandatos necesarios para crear la imagen de {{ site.data.keys.mf_app_center }}.</li>
                    <li>Carpeta <b>scripts</b>: Esta carpeta contiene la carpeta <b>args</b> que incluye un conjunto de archivos de configuración. También contiene los scripts necesarios para iniciar sesión en IBM Cloud, crear una imagen de {{ site.data.keys.mf_app_center }} para enviarla por push y ejecutar la imagen en IBM Cloud. Puede optar por ejecutar los scripts de forma interactiva o configurar previamente los archivos de configuración, como se describe más adelante. Aparte de los archivos args/*.properties personalizables, no modifique ningún elemento de esta carpeta. Para obtener ayuda sobre el uso de scripts, utilice los argumentos de línea de mandatos <code>-h</code> o <code>--help</code>, por ejemplo, <code>scriptname.sh --help</code>.</li>
                    <li>Carpeta <b>usr-mfp-appcenter</b>:
                        <ul>
                            <li>Carpeta <b>bin</b> folder: Contiene el archivo de script (mfp-appcenter-init) que se ejecuta cuando se inicia el contenedor. Puede añadir su propio código personalizado para ejecutarlo.</li>
                            <li>Carpeta <b>config</b>: Contiene los fragmentos de configuración del servidor (almacén de claves, propiedades del servidor, registro de usuarios) que utiliza {{ site.data.keys.mf_app_center }}.</li>
                            <li><b>keystore.xml</b> - la configuración del repositorio de los certificados de seguridad que se utilizan para el cifrado SSL. Debe hacerse referencia a los archivos listados en la carpeta ./usr/security.</li>
                            <li><b>ltpa.xml</b> - el archivo de configuración que define la clave LTPA y su contraseña.</li>
                            <li><b>appcentersqldb.xml</b>: Definición de origen de datos JDBC para conectar con la base de datos DB2 o dashDB.</li>
                            <li><b>registry.xml</b> - configuración del registro de usuarios. La configuración de basicRegistry (de forma predeterminada, se proporciona una configuración de registro de usuarios básico basado en XML). Se pueden configurar los nombres de usuarios y las contraseñas para basicRegistry o puede configurar ldapRegistry.</li>
                            <li><b>tracespec.xml</b> - La especificación de rastreo para habilitar la depuración, así como los niveles de registro.</li>
                        </ul>
                    </li>
                    <li>Carpeta <b>jre-security</b>: Puede actualizar los archivos relacionados con la seguridad JRE (almacén de claves, archivos JAR de políticas, etc.) colocándolos en esta carpeta. Los archivos de esta carpeta se copian en la carpeta <b>JAVA_HOME/jre/lib/security/</b> del contenedor.</li>
                    <li>Carpeta <b>security</b>: Se utiliza para los archivos del almacén de claves, el almacén de confianza y las claves LTPA (ltpa.keys).</li>
                    <li>Carpeta <b>env</b>: Contiene las propiedades del entorno que se utilizan para la inicialización del servidor (server.env) y las opciones de JVM personalizadas (jvm.options).</li>

                    <br/>
                    <div class="panel-group accordion" id="terminology" role="tablist">
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
                                            <td>APPCENTER_SERVER_HTTPPORT</td>
                                            <td>9080*</td>
                                            <td>El puerto utilizado para las solicitudes HTTP de cliente. Utilice -1 para inhabilitar este puerto.</td>
                                        </tr>
                                        <tr>
                                            <td>APPCENTER_SERVER_HTTPSPORT	</td>
                                            <td>9443*	</td>
                                            <td>El puerto utilizado para las solicitudes HTTP de cliente protegidas con SSL (HTTPS). Utilice -1 para inhabilitar este puerto.</td>
                                        </tr>
                                        <tr>
                                            <td>APPCENTER_ROOT	</td>
                                            <td>applicationcenter</td>
                                            <td>La raíz de contexto en la que estarán disponibles los servicios de administración de {{ site.data.keys.mf_app_center }}.</td>
                                        </tr>
                                        <tr>
                                            <td>APPCENTER_CONSOLE_ROOT	</td>
                                            <td>appcenterconsole</td>
                                            <td>La raíz de contexto en la que estará disponible la consola de {{ site.data.keys.mf_app_center }}.</td>
                                        </tr>
                                        <tr>
                                            <td>APPCENTER_ADMIN_GROUP</td>
                                            <td>appcenteradmingroup</td>
                                            <td>El nombre del grupo de usuarios que tiene asignado el rol <code>appcenteradmin</code> predefinido.</td>
                                        </tr>
                                        <tr>
                                            <td>APPCENTER_USER_GROUP	</td>
                                            <td>appcenterusergroup</td>
                                            <td>El nombre del grupo de usuarios que tiene asignado el rol <code>appcenteruser</code> predefinido.</td>
                                        </tr>
                                    </table>

                    				<br/>
                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#server-env" data-target="#collapse-server-env" aria-expanded="false" aria-controls="collapse-server-env"><b>Cerrar sección</b></a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <li>Carpeta <b>dependencies</b>: Contiene el tiempo de ejecución de {{ site.data.keys.mf_bm_short }} junto con IBM Java JRE 8.</li>
                    <li>Carpeta <b>mfpf-libs</b>: Contiene las bibliotecas de componentes del producto {{ site.data.keys.product_adj }} y CLI.</li>
                </ul>
				<br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#zip-file" data-target="#collapse-zip-file" aria-expanded="false" aria-controls="collapse-zip-file"><b>Cerrar sección</b></a>
            </div>
        </div>
    </div>
</div>

## Requisitos previos
{: #prerequisites }

Debe tener conocimientos para trabajar con Kubernetes. Consulte los [documentos de Kubernetes](https://kubernetes.io/docs/concepts/), para obtener más información.


## Configuración de {{ site.data.keys.mf_app_center }} en Kubernetes Cluster con IBM Containers
{: #setting-up-the-mobilefirst-appcenter-on-kube-with-ibm-containers }
Como se ha descrito anteriormente, puede optar por ejecutar los scripts de forma interactiva o utilizar los archivos de configuración:

* **Utilización de los archivos de configuración** - Ejecute los scripts y pase el archivo de configuración respectivo como un argumento.
* **Interactivamente** - Ejecute los scripts sin argumentos.

>**Nota:** Si opta por ejecutar los scripts de forma interactiva, puede omitir la configuración, pero se le recomienda que lea y comprenda los argumentos que deberá proporcionar.

Cuando ejecuta de forma interactiva, se guarda una copia de los argumentos proporcionados en un directorio: `./recorded-args/`. De este modo, puede utilizar la modalidad interactiva la primera vez y reutilizar los archivos de propiedades como una referencia para despliegues futuros.

<div class="panel-group accordion" id="scripts2" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="step-foundation-1">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#scripts2" data-target="#collapse-step-foundation-1" aria-expanded="false" aria-controls="collapse-step-foundation-1">Utilización de los archivos de configuración</a>
            </h4>
        </div>

        <div id="collapse-step-foundation-1" class="panel-collapse collapse" role="tabpanel" aria-labelledby="setupCordova">
            <div class="panel-body">
                La carpeta <b>args</b> contiene un conjunto de archivos de configuración que contiene los argumentos necesarios para ejecutar los scripts. Rellene los valores de los argumentos en los archivos siguientes:<br/>

                <h4>initenv.properties</h4>
                <ul>
                    <li><b>IBM_CLOUD_API_URL - </b>Zona geográfica o región en que desea realizar el despliegue.<br>
                      <blockquote>Por ejemplo: <i>api.ng.bluemix.net</i> para la región de EE.UU. o <i>api.eu-de.bluemix.net</i> para Alemania o <i>api.au-syd.bluemix.net</i> para Sydney</blockquote>
                    </li>
                    <li><b>IBM_CLOUD_ACCOUNT_ID - </b>Su ID de cuenta, que es un valor alfanumérico, como <i>a1b1b111d11e1a11d1fa1cc999999999</i><br>	Utilice el mandato <code>bx target</code> para obtener el ID de cuenta.</li>
                    <li><b>IBM_CLOUD_USER - </b>Su nombre de usuario de IBM Cloud (correo electrónico).</li>
                    <li><b>IBM_CLOUD_PASSWORD - </b>Su contraseña de IBM Cloud.</li>
                    <li><b>IBM_CLOUD_ORG - </b>El nombre de su organización de IBM Cloud.</li>
                    <li><b>IBM_CLOUD_SPACE - </b>Su espacio IBM Cloud (como se ha descrito anteriormente).</li>
                </ul><br/>
                <h4>prepareappcenterdbs.properties</h4>
                {{ site.data.keys.mf_app_center }} requiere una instancia de <a href="https://console.bluemix.net/catalog/services/db2-on-cloud/" target="\_blank"><i>DB2 en Cloud</i></a>.<br/>
                <blockquote><b>Nota:</b> También puede utilizar su propia base de datos DB2. IBM Cloud Kubernetes Cluster se debe configurar para su conexión con la base de datos.</blockquote>
                Después de configurar la instancia de DB2, proporcione los argumentos necesarios:
                <ul>
                    <li><b>DB_TYPE</b> - <i>dashDB</i> ( si utiliza DB2 on Cloud ) o <i>DB2</i> si utiliza su propia base de datos DB2.</li>
                    <li>Proporcione lo siguiente si utiliza su propia base de datos DB2 (por ejemplo, DB_TYPE=DB2).
                      <ul><li><b>DB2_HOST</b> - Nombre de host de su configuración de DB2.</li>
                          <li><b>DB2_DATABASE</b> - Nombre de la base de datos.</li>
                          <li><b>DB2_PORT</b> - Puerto en el que se conectará a la base de datos.</li>
                          <li><b>DB2_USERNAME</b> - El usuario de la base de datos DB2 (el usuario debe tener los permisos para crear tablas en el esquema proporcionado o, si el esquema no existe todavía, el usuario debe poder crear un esquema)</li>
                          <li><b>DB2_PASSWORD</b> - La contraseña del usuario de DB2.</li>
                      </ul>
                    </li>
                    <li>Proporcione lo siguiente si utiliza DB2 on Cloud (por ejemplo, DB_TYPE=dashDB).
                      <ul><li><b>APPCENTER_DB_SRV_NAME</b>: El nombre de su instancia de servicio de dashDB, para almacenar los datos de Appcenter.</li>
                      </ul>
                    </li>
                    <li><b>APPCENTER_SCHEMA_NAME</b>: Su nombre de esquema para los datos de Appcenter. El valor predeterminado es <i>APPCNTR</i>.</li>
                    <blockquote><b>Nota:</b> Si su instancia de servicio de base de datos DB2 la comparten muchos usuarios o varios despliegues de {{ site.data.keys.mf_app_center }}, asegúrese de que proporciona nombres de esquema exclusivos.</blockquote>
                </ul><br/>
                <h4>prepareappcenter.properties</h4>
                <ul>
                  <li><b>SERVER_IMAGE_TAG</b> - Una etiqueta para la imagen. Debe tener el formato: <em>registry-url/namespace/image:tag</em>.</li>
                  <blockquote>Por ejemplo: <em>registry.ng.bluemix.net/myuniquenamespace/myappcenter:v1</em><br/>Si todavía no ha creado un espacio de nombres de registro, cree el espacio de nombres de registro utilizando uno de estos mandatos:<br/>
                  <ul><li><code>bx cr namespace-add <em>myuniquenamespace</em></code></li><li><code>bx cr namespace-list</code></li></ul>
                  </blockquote>
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

        <div id="collapse-step-foundation-2" class="panel-collapse collapse" role="tabpanel" aria-labelledby="setupCordova">
            <div class="panel-body">
            <p>Las siguientes instrucciones muestran cómo ejecutar los scripts utilizando los archivos de configuración. También está disponible una lista de argumentos de línea de mandatos, si opta por ejecutarlos fuera del modo interactivo:</p>

            <ol>
                <li><b>initenv.sh – Inicio de sesión en IBM Cloud </b><br />
                    Ejecute el script <b>initenv.sh</b> para crear un entorno para compilar y ejecutar {{ site.data.keys.mf_app_center }} en IBM Containers:
                    <b>Modo interactivo</b>
{% highlight bash %}
./initenv.sh
{% endhighlight %}
                    <b>Modo no interactivo</b>
{% highlight bash %}
./initenv.sh args/initenv.properties
{% endhighlight %}
                </li>
                <li><b>prepareappcenterdbs.sh - Prepare la base de datos de {{ site.data.keys.mf_app_center }} </b><br />
                    El script <b>prepareappcenterdbs.sh</b> se utiliza para configurar {{ site.data.keys.mf_app_center }} con el servicio de base de datos DB2. La instancia de servicio de DB2 debe estar disponible en la Organización y Espacio en que ha iniciado sesión en el paso 1. Ejecute lo siguiente:
                    <b>Interactive Mode</b>
{% highlight bash %}
./prepareappcenterdbs.sh
{% endhighlight %}
                    <b>Non-interactive Mode</b>
{% highlight bash %}
./prepareappcenterdbs.sh args/prepareappcenterdbs.properties
{% endhighlight %}
                </li>
                <li><b>initenv.sh (Opcional) – Inicio de sesión en IBM Cloud </b><br />
                      Este paso solo es necesario si necesita crear contenedores en una organización y espacio diferentes a aquellos en los que está disponible la instancia de servicio de DB2. Si es así, actualice initenv.properties con la nueva organización y espacio en que se han creado los contenedores (y se han iniciado), y vuelva a ejecutar el script <b>initenv.sh</b>:
{% highlight bash %}
./initenv.sh args/initenv.properties
{% endhighlight %}

                </li>
                <li><b>prepareappcenter.sh - Prepare una imagen de {{ site.data.keys.mf_app_center }}</b><br />
                    Ejecute el script <b>prepareappcenter.sh</b> para crear la imagen de {{ site.data.keys.mf_app_center }} y enviarla mediante push al repositorio de IBM Cloud. Para ver todas las imágenes disponibles en el repositorio de IBM Cloud, ejecute: <code>bx cr image-list</code><br/>
                    La lista contiene el nombre, la fecha de creación y el ID de la imagen.<br/>
                    <b>Modo interactivo</b>
{% highlight bash %}
./prepareappcenter.sh
{% endhighlight %}
                    <b>Modo no interactivo</b>
{% highlight bash %}
./prepareappcenter.sh args/prepareappcenter.properties
{% endhighlight %}
                </li>
                <li>Despliegue {{ site.data.keys.mf_app_center }} en contenedores Docker en Kubernetes Cluster utilizando IBM Cloud Container Service.
                <ol>
                  <li>Establezca el contexto del terminal en su clúster<br/><code>bx cs cluster-config <em>my-cluster</em></code><br/>
                  Para averiguar el nombre del clúster, ejecute el mandato siguiente: <br/><code>bx cs clusters</code><br/>
                  En la salida, la vía de acceso del archivo de configuración se muestra como un mandato para establecer la variable de entorno, por ejemplo:<br/>
                  <code>export KUBECONFIG=/Users/ibm/.bluemix/plugins/container-service/clusters/<em>my-cluster</em>/kube-config-prod-dal12-my-cluster.yml</code><br/>
                  Copie y pegue el mandato anterior, después de sustituir <em>my-cluster</em> por el nombre de clúster, establezca la variable de entorno de su terminal y pulse <b>Intro</b>.
                  </li>
                  <li>Para obtener su <b>dominio de ingreso</b>, ejecute el mandato siguiente:<br/>
                   <code>bx cs cluster-get <em>my-cluster</em></code><br/>
                   Anote el dominio de ingreso. Si necesita configurar TLS, anote el <b>secreto de ingreso</b>.</li>
                  <li>Cree los despliegues de Kubernetes<br/>Edite el archivo yaml <b>args/mfp-deployment-appcenter.yaml</b> y rellene los detalles. Se deben sustituir todas las variables por sus valores antes de ejecutar el mandato <em>kubectl</em>.<br/>
                  <b>./args/mfp-deployment-appcenter.yaml</b> contiene el despliegue para lo siguiente:
                  <ul>
                    <li>un despliegue de kubernetes para {{ site.data.keys.mf_app_center }} que consta de 1 instancia (réplica), con una memoria de 1024 MB y CPU de 1 núcleo.</li>
                    <li>un servicio de kubernetes para {{ site.data.keys.mf_app_center }}.</li>
                    <li>un ingreso para toda la configuración que incluya todos los puntos finales REST para {{ site.data.keys.mf_app_center }}.</li>
                    <li>un configMap para que las variables de entorno estén disponibles en las instancias de {{ site.data.keys.mf_app_center }} instance.</li>
                  </ul>
                  Los valores siguientes se deben editar en el archivo YAML:<br/>
                    <ol><li>Las diferentes apariciones de <em>my-cluster.us-south.containers.mybluemix.net</em> con la salida del <b>Dominio de ingreso</b> de la salida del mandato <code>bx cs cluster-get</code>, como se ha indicado anteriormente.</li>
                    <li><em>registry.ng.bluemix.net/repository/mfpappcenter:latest</em>: Utilice los mismos nombres que ha utilizado en prepareappcenter.sh para subir la imagen.</li>
                    </ol>
                    Ejecute el mandato siguiente:<br/>
                    <code>kubectl create -f ./args/mfp-deployment-appcenter.yaml</code>
                    <blockquote><b>Nota:<br/></b>Se proporcionan los siguientes archivos yaml de plantilla:<br/>
                    <ul><li><b>mfp-deployment-appcenter.yaml</b>: Despliega {{ site.data.keys.mf_app_center }} con http.</li>
                      <li><b>mfp-deployment-appcenter-with-tls.yaml</b>: Despliega {{ site.data.keys.mf_app_center }} con https.</li>
                    </ul></blockquote>
                      Después de su creación, para utilizar el panel de control de Kubernetes, ejecute el siguiente mandato:<br/>
                      <code>kubectl proxy</code><br/>Abra <b>localhost:8001/ui</b>, en su navegador.
                  </li>
                </ol>
                </li>
                </ol>
            </div>
        </div>
    </div>
</div>
<!--
## Applying {{ site.data.keys.mf_server }} Fixes
{: #applying-mobilefirst-server-fixes }

Interim fixes for the {{ site.data.keys.mf_server }} on IBM Containers can be obtained from [IBM Fix Central](http://www.ibm.com/support/fixcentral).  
Before you apply an interim fix, back up your existing configuration files. The configuration files are located in the the following folders:
* {{ site.data.keys.mf_analytics }}: **package_root/bmx-kubernetes/usr-mfpf-analytics**
* {{ site.data.keys.mf_server }} Liberty Cloud Foundry Application: **package_root/bmx-kubernetes/usr-mfpf-server**

### Steps to apply the iFix:

1. Download the interim fix archive and extract the contents to your existing installation folder, overwriting the existing files.
2. Restore your backed-up configuration files into the **package_root/bmx-kubernetes/usr-mfpf-server** and **package_root/bmx-kubernetes/usr-mfpf-analytics** folders, overwriting the newly installed configuration files.
3. Edit **package_root/bmx-kubernetes/usr-mfpf-server/env/jvm.options** file in your editor and remove the following line, if it exists:
```
-javaagent:/opt/ibm/wlp/usr/servers/mfp/newrelic/newrelic.jar”
```
    You can now build and deploy the updated server.

    a. Run the `prepareserver.sh` script to rebuild the server image and push it to the IBM Containers service.

    b. Perform a rolling update by running the following command:
      <code>kubectl rolling-update NAME -f FILE</code>
-->
<!--**Note:** When applying fixes for {{ site.data.keys.mf_app_center }} the folders are `mfp-appcenter-libertyapp/usr` and `mfp-appcenter/usr`.-->

## Eliminar el contenedor de IBM Cloud
{: #removing-the-container-from-ibmcloud }
Cuando elimina un contenedor de IBM Cloud, también debe eliminar el nombre de imagen del registro.  
Ejecute los mandatos siguientes para eliminar un contenedor desde IBM Cloud:

1. `cf ic ps` (Lista los contenedores que se están ejecutando)
2. `cf ic stop container_id` (Detiene el contenedor)
3. `cf ic rm container_id` (Elimina el contenedor)

Ejecute los siguientes mandatos cf ic para eliminar un nombre de imagen del registro de IBM Cloud:

1. `cf ic images` (Lista las imágenes del registro)
2. `cf ic rmi image_id` (Elimina la imagen del registro)

## Eliminar los despliegues de Kubernetes de IBM Cloud
{: #removing-kube-deployments}

Ejecute los mandatos siguientes para eliminar las instancias desplegadas de IBM Cloud Kubernetes Cluster:

`kubectl delete -f mfp-deployment-appcenter.yaml` (Elimina todos los tipos de kubernetes definidos en el archivo yaml).

Ejecute los siguientes mandatos para eliminar el nombre de imagen del registro de IBM Cloud:
```bash
bx cr image-list (Lista las imágenes del registro)
bx cr image-rm image-name (Elimina la imagen del registro)
```

## Eliminar la configuración del servicio de base de datos de IBM Cloud
{: #removing-the-database-service-configuration-from-ibmcloud }
Si ha ejecutado el script **prepareappcenterdbs.sh** durante la configuración de la imagen de {{ site.data.keys.mf_app_center }}, se crean las configuraciones y tablas de base de datos necesarias para {{ site.data.keys.mf_app_center }}. Este script también crea el esquema de base de datos para el contenedor.

Para eliminar la configuración del servicio de base de datos desde IBM Cloud, realice el siguiente procedimiento utilizando el panel de control de IBM Cloud.

1. En el panel de control de IBM Cloud, seleccione el servicio DB2 on Cloud que ha utilizado. Seleccione el nombre del servicio DB2 on Cloud que ha proporcionado como un parámetro cuando ejecutaba el script **prepareappcenterdbs.sh**.
2. Inicie la consola de DB2 para trabajar con los esquemas y los objetos de base de datos de la instancia de servicio DB2 seleccionada.
3. Seleccione los esquemas relacionados con la configuración de IBM {{ site.data.keys.mf_server }}. Los nombres de esquemas son los que ha proporcionado durante la ejecución del script **prepareappcenterdbs.sh**.
4. Suprima cada esquema después de inspeccionar detenidamente los nombres de esquemas y los objetos que se encuentran debajo de los mismos. Las configuraciones de base de datos se eliminan de IBM Cloud.
