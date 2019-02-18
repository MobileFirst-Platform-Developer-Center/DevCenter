---
layout: tutorial
title: Configuración de MobileFirst Application Center en IBM Cloud Private
breadcrumb_title: Application Center on IBM Cloud Private
relevantTo: [ios,android,windows,javascript]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
IBM {{ site.data.keys.mf_app_center }} puede utilizarse como una tienda de aplicaciones empresariales y es una forma de compartir información entre los diferentes miembros del equipo dentro de una organización. El concepto de {{ site.data.keys.mf_app_center_short }} es similar a App Store de Apple o Play Store de Android, con la diferencia de que está destinada al uso privado dentro de una organización. Mediante {{ site.data.keys.mf_app_center_short }}, los usuarios de la misma organización pueden descargar aplicaciones para dispositivos móviles desde un solo lugar que sirve como repositorio de aplicaciones móviles.
Para obtener más información sobre MobileFirst Application Center, consulte la [documentación de MobileFirst Application Center](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/appcenter/).


#### Ir a:
{: #jump-to }
* [Requisitos previos](#prereqs)
* [Descargar el archivo Passport Advantage de IBM {{ site.data.keys.mf_app_center }}](#download-the-ibm-mac-ppa-archive)
* [Cargar el archivo PPA de IBM {{ site.data.keys.mf_app_center }} en {{ site.data.keys.prod_icp }}](#load-the-ibm-mfpf-appcenter-ppa-archive)
* [Variables de entorno de {{ site.data.keys.mf_app_center }}](#env-mf-appcenter)
* [Instalar y configurar {{ site.data.keys.mf_app_center }}](#configure-install-mf-appcenter-helmcharts)
* [Verificación de la instalación](#verify-install)
* [Acceso a {{ site.data.keys.mf_app_center }}](#access-mf-appcenter-console)
* [Actualización de {{ site.data.keys.prod_adj }}releases y gráficos Helm](#upgrading-mf-helm-charts)
* [Desinstalar](#uninstall)
* [Referencias](#references)

## Requisitos previos
{: #prereqs}

Debe tener una cuenta de {{ site.data.keys.prod_icp }} y debe haber configurado Kubernetes Cluster siguiendo la [documentación de  {{ site.data.keys.prod_icp }}](https://www.ibm.com/support/knowledgecenter/SSBS6K_3.1.0/installing/install_containers.html#setup).

Necesita una base de datos preconfigurada para instalar y configurar gráficos de {{ site.data.keys.mf_app_center }} en {{ site.data.keys.prod_icp }}. Deberá proporcionar la información de base de datos para configurar el gráfico Helm de {{ site.data.keys.mf_app_center }}. Las tablas necesarias para {{ site.data.keys.mf_app_center }} se crearán en esta base de datos.

> Bases de datos soportadas: DB2, Oracle, MySQL, PostgreSQL.

Para gestionar los contenedores y las imágenes, debe instalar las herramientas siguientes en la máquina host como parte de la configuración de {{ site.data.keys.prod_icp }}:

* Docker
* CLI de IBM Cloud (`cloudctl`)
* CLI de Kubernetes (`kubectl`)
* Helm (`helm`)


## Descargar el archivo Passport Advantage de IBM {{ site.data.keys.mf_app_center }}
{: #download-the-ibm-mac-ppa-archive}
El archivo Passport Advantage (PPA) de {{ site.data.keys.mf_app_center }} está disponible [aquí](). El archivo PPA de {{ site.data.keys.product }} contendrá las imágenes docker y los gráficos Helm de los componentes siguientes de {{ site.data.keys.product }}:
* {{ site.data.keys.product_adj }} Server
* {{ site.data.keys.product_adj }} Analytics
* {{ site.data.keys.product_adj }} Application Center

Los arreglos temporales para {{ site.data.keys.mf_app_center }} se pueden obtener en [IBM Fix Central](http://www.ibm.com/support/fixcentral).<br/>

## Cargar el archivo PPA de IBM {{ site.data.keys.mf_app_center }} en {{ site.data.keys.prod_icp }}
{: #load-the-ibm-mfpf-appcenter-ppa-archive}

Antes de cargar el archivo PPA de {{ site.data.keys.product }}, debe configurar Docker. Consulte las instrucciones [aquí](https://www.ibm.com/support/knowledgecenter/SSBS6K_3.1.0/manage_images/using_docker_cli.html).

Siga los pasos indicados a continuación para cargar el archivo PPA en el clúster de {{ site.data.keys.prod_icp }}:

  1. Inicie sesión en el clúster con el plugin IBM Cloud ICP (`cloudctl`).
      >Consulte [Referencia de mandatos de CLI](https://www.ibm.com/support/knowledgecenter/SSBS6K_3.1.0/manage_cluster/cli_commands.html) en la documentación de {{ site.data.keys.prod_icp }}.

      Por ejemplo:
      ```bash
      cloudctl login -a https://<ip>:<port>
      ```
      Opcionalmente, si desea omitir la validación SSL, utilice el distintivo `--skip-ssl-validation` en el mandato anterior. Mediante esta opción, se solicitan los valores de `username` y `password` del punto final del clúster. Continúe con los pasos siguientes, una vez iniciada la sesión.

  2. Cargue el archivo PPA de {{ site.data.keys.product }} mediante el mandato siguiente:
      ```
      cloudctl load-ppa-archive --archive <nombre_archivado> [--clustername <nombre_clúster>] [--namespace <espacio_nombres>]
      ```
      *archive_name* de {{ site.data.keys.product }} es el nombre del archivo PPA descargado desde IBM Passport Advantage,

      `--clustername` puede ignorarse si se ha seguido el paso anterior y se ha establecido el punto final del clúster como valor predeterminado para `cloudctl`.

  3. Después de cargar el archivo PPA, sincronice los repositorios; de este modo, se asegura de que los gráficos Helm figuren en el **Catálogo**. Puede realizar esta acción en la consola de gestión de {{ site.data.keys.prod_icp }}.<br/>
     * Seleccione **Administración > Repositorios**.
     * Pulse **Sincronizar repositorios**.

  4.  Puede ver las imágenes Docker y los gráficos Helm en la consola de gestión de {{ site.data.keys.prod_icp }}.<br/>
      Para ver las imágenes Docker,
      * Seleccione **Plataforma > Imágenes**.
      * Los gráficos Helm se muestran en el **Catálogo**.

  Tras completar los pasos anteriores, verá que aparece la versión cargada de {{ site.data.keys.prod_adj }} los gráficos Helm en el catálogo de ICP. {{ site.data.keys.mf_app_center }} aparece como **ibm-mfpf-appcenter-prod** en el catálogo.

## Variables de entorno de {{ site.data.keys.mf_app_center }}
{: #env-mf-appcenter }
La tabla siguiente indica las variables de entorno utilizadas en {{ site.data.keys.mf_app_center }} en {{ site.data.keys.prod_icp }}.

| Calificador | Parámetro | Definición | Valor permitido |
|-----------|-----------|------------|---------------|
| arch |  | Arquitectura de nodo de trabajador | Arquitectura de nodo de trabajador en la que debe desplegarse este gráfico. Actualmente, solo se admite la plataforma **AMD64**. |
| image | pullPolicy | Política de extracción de imágenes | El valor predeterminado es **IfNotPresent**. |
|  | name | Nombre de imagen Docker | Nombre de la imagen docker de {{ site.data.keys.mf_app_center }}. |
|  | tag | Etiqueta de imagen Docker | Consulte [Descripción de etiquetas de Docker](https://docs.docker.com/engine/reference/commandline/image_tag/) |
| mobileFirstAppCenterConsole | user | Nombre de usuario de la consola de {{ site.data.keys.mf_app_center }} |  |
|  | password | Contraseña de la consola de {{ site.data.keys.mf_app_center }} |  |
| existingDB2Details | appCenterDB2Host | Dirección IP del servidor DB2 donde se va a configurar la base de datos de {{ site.data.keys.mf_app_center_short }} |  |
|  | appCenterDB2Port | Puerto de la base de datos DB2 que está configurado |  |
|  | appCenterDB2Database | Nombre de la base de datos que se va a utilizar | La base de datos debe crearse previamente. |
|  | appCenterDB2Username | Nombre de usuario de DB2 para acceder a la base de datos DB2 | El usuario debe tener acceso para crear tablas y crear el esquema si no existe todavía. |
|  | appCenterDB2Password | Contraseña de DB2 de la base de datos proporcionada |  |
|  | appCenterDB2Schema | Esquema de {{ site.data.keys.mf_app_center_short }} DB2 que se va a crear  |  |
|  | appCenterDB2ConnectionIsSSL | Tipo de conexión de DB2 | Especifique si la conexión de la base de datos debe ser **http** o **https**. El valor predeterminado es **false** (http). Asegúrese de que el puerto de DB2 también esté configurado para la misma modalidad de conexión. |
| keystores | keystoresSecretName | Consulte [Instalar y configurar gráficos Helm de IBM {{ site.data.keys.product }}](../#configure-install-mf-helmcharts), donde se describen los pasos para crear el secreto con los almacenes y sus contraseñas. |  |
| resources | limits.cpu | Cantidad máxima de CPU permitidas | El valor predeterminado es **1000m**<br/>Consulte
[aquí](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) para obtener más información. |
|  | limits.memory | Cantidad máxima de memoria permitida | El valor predeterminado es **1024Mi**<br/>Consulte
[aquí](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory) para obtener más información. |
| resources.requests | requests.cpu | Describe la cantidad mínima de CPU necesarias. Si no se especifica, el valor predeterminado es *limits* (si se especifica) o el valor definido por implementación. | El valor predeterminado es **1000m**. |
|  | requests.memory | Describe la memoria mínima necesaria. Si no se especifica, el valor predeterminado de la memoria será *limits* (si se especifica) o el valor definido por implementación. | El valor predeterminado es **1024Mi**. |

## Instalar y configurar {{ site.data.keys.mf_app_center }}
{: #configure-install-mf-appcenter-helmcharts}

Antes de instalar y configurar {{ site.data.keys.mf_app_center }}, debe tener lo siguiente:

* [**Obligatorio**] una base de datos DB2 configurada y lista para utilizar.
  Necesitará la información de base de datos para [configurar {{ site.data.keys.mf_server }} helm](../#install-hmc-icp). {{ site.data.keys.mf_server }} requiere un esquema y tablas, que se crearán (si no existen) en esta base de datos.

* [**Opcional**] un secreto con el almacén de claves y el almacén de confianza.
  Puede proporcionar su propio almacén de claves y almacén de confianza para el despliegue creando un secreto con su propio almacén de claves y almacén de confianza.

  Antes de la instalación, siga estos pasos:

  * Cree un secreto con `keystore.jks`, `keystore-password.txt`, `truststore.jks`, `truststore-password.txt` y proporcione el nombre del secreto en el campo *keystores.keystoresSecretName*.

  * Guarde los archivos `keystore.jks` y su contraseña en un archivo denominado `keystore-password.txt`, y `truststore.jks` y su contraseña en un archivo denominado `truststore-password.jks`.

  * Vaya a la línea de mandatos y ejecute:
    ```bash
    kubectl create secret generic mfpf-cert-secret --from-file keystore-password.txt --from-file truststore-password.txt --from-file keystore.jks --from-file truststore.jks
    ```
    >**Nota:** Los nombres de los archivos debe ser los mencionados, es decir, `keystore.jks`, `keystore-password.txt`, `truststore.jks` y `truststore-password.txt`.

  * Proporcione el nombre del secreto en *keystoresSecretName* para sustituir los almacenes de claves predeterminados.

  Para obtener más información, consulte [Configuración del almacén de claves de MobileFirst Server]({{ site.baseurl }}/tutorials/en/foundation/8.0/authentication-and-security/configuring-the-mobilefirst-server-keystore/).

Siga estos pasos para instalar y configurar IBM {{ site.data.keys.mf_app_center }} desde la consola de gestión de {{ site.data.keys.prod_icp }}.

1. Vaya a **Catálogo** en la consola de gestión.
2. Seleccione el gráfico Helm **ibm-mfpf-appcenter-prod**.
3. Pulse **Configurar**.
4. Proporcione las variables de entorno. Consulte [Variables de entorno de {{ site.data.keys.mf_app_center }}](#env-mf-appcenter) para obtener más información.
5. Pulse **Instalar**.

## Verificación de la instalación
{: #verify-install}

Después de haber instalado y configurado {{ site.data.keys.mf_analytics }} (opcional) y {{ site.data.keys.mf_server }}, puede verificar la instalación y el estado de los pods desplegados mediante las acciones siguientes:

En la consola de gestión de {{ site.data.keys.prod_icp }}. Seleccione **Cargas de trabajo > Releases de Helm**. Pulse el *nombre de release* de la instalación.

## Acceso a {{ site.data.keys.mf_app_center }}
{: #access-mf-appcenter-console}

Tras instalar correctamente el gráfico Helm de {{ site.data.keys.mf_app_center }}, puede acceder a la consola de {{ site.data.keys.mf_app_center }} desde el navegador mediante `<protocol>://<external_ip>:<port>/appcenterconsole`.

El protocolo puede ser **http** o **https**. Además, tenga en cuenta que el puerto será NodePort, en caso de despliegue de NodePort. Para obtener los valores de ip_address y NodePort de los gráficos de {{ site.data.keys.mf_app_center }}, siga estos pasos:

1. En la consola de gestión de {{ site.data.keys.prod_icp }}, seleccione **Cargas de trabajo > Releases de Helm**.
2. Pulse el *nombre de release* de la instalación de gráfico Helm.
3. Consulte la sección **Notas**.

> **Nota:** Para acceder al cliente móvil de {{ site.data.keys.mf_app_center }}, descargue el paquete del centro de aplicaciones de Passport Advantage. [Más información](http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/appcenter/mobile-client/).

## Actualización de {{ site.data.keys.prod_adj }} releases y gráficos Helm
{: #upgrading-mf-helm-charts}

Consulte [Actualización de productos empaquetados](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_2.1.0/installing/upgrade_helm.html) para obtener instrucciones sobre cómo actualizar los gráficos/releases de helm.

### Casos de ejemplo para las actualizaciones de release de Helm

1. Para actualizar el release de helm con los cambios de los valores de `values.yaml`, utilice el mandato `helm upgrade` con el distintivo **--set**. Puede especificar el distintivo **--set** varias veces. Se dará prioridad al conjunto especificado más a la derecha en la línea de mandatos.
  ```bash
  helm upgrade --set <name>=<value> --set <name>=<value> <existing-helm-release-name> <path of new helm chart>
  ```

2. Para actualizar el release de helm indicando valores en un archivo, utilice el mandato `helm upgrade` con el distintivo **-f**. Puede utilizar **--values** o el distintivo **-f** varias veces. Se dará prioridad al archivo especificado más a la derecha en la línea de mandatos. En el siguiente ejemplo, si `myvalues.yaml` y `override.yaml` contienen una clave denominada *Test*, tendrá prioridad el valor establecido en `override.yaml`.
  ```bash
  helm upgrade -f myvalues.yaml -f override.yaml <existing-helm-release-name> <path of new helm chart>
  ```

3. Para actualizar el release de helm reutilizando los valores del último release y sustituyendo algunos de ellos, se puede utilizar un mandato como el siguiente:
  ```bash
  helm upgrade --reuse-values --set <name>=<value> --set <name>=<value> <existing-helm-release-name> <path of new helm chart>
  ```

## Desinstalar
{: #uninstall}
Para desinstalar {{ site.data.keys.mf_app_center }}, utilice [Helm CLI](https://docs.helm.sh/using_helm/#installing-helm).
Utilice el mandato siguiente para suprimir completamente los gráficos instalados y los despliegues asociados:
```bash
helm delete --purge <release_name>
```
*release_name* es el nombre de release desplegado del gráfico Helm.

## Referencias
{: #references}

Consulte [aquí](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/appcenter/) para obtener más información sobre {{ site.data.keys.mf_app_center }}.
