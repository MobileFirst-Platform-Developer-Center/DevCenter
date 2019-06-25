---
layout: tutorial
title: Configuración de MobileFirst Server en IBM Cloud Private
breadcrumb_title: Foundation on IBM Cloud Private
relevantTo: [ios,android,windows,javascript]
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
Siga las instrucciones siguientes para configurar una instancia de {{ site.data.keys.mf_server }} y una instancia de {{ site.data.keys.mf_analytics }} en {{ site.data.keys.prod_icp }}:

* Configure IBM Cloud Private Kubernetes Cluster.
* Configure el sistema host con las herramientas necesarias (CLI de Docker, de IBM Cloud (`cloudctl`), de Kubernetes (`kubectl`) y de Helm (`helm`)).
* Descargue el archivo Passport Advantage (archivo PPA) de {{ site.data.keys.product_full }} para {{ site.data.keys.prod_icp }}.
* Cargue el archivo PPA en {{ site.data.keys.prod_icp }} Cluster.
* Finalmente, deberá configurar e instalar {{ site.data.keys.mf_analytics }} (opcional) y {{ site.data.keys.mf_server }}.

#### Ir a:
{: #jump-to }
* [Requisitos previos](#prereqs)
* [Descargar el archivo Passport Advantage de IBM Mobile Foundation](#download-the-ibm-mfpf-ppa-archive)
* [Cargar el archivo Passport Advantage de IBM Mobile Foundation](#load-the-ibm-mfpf-ppa-archive)
* [Instalar y configurar gráficos Helm de IBM {{ site.data.keys.product }}](#configure-install-mf-helmcharts)
* [Verificación de la instalación](#verify-install)
* [Aplicación de ejemplo](#sample-app)
* [Actualización de {{ site.data.keys.prod_adj }}releases y gráficos Helm](#upgrading-mf-helm-charts)
* [Desinstalar](#uninstall)

## Requisitos previos
{: #prereqs}

Debe tener una cuenta de {{ site.data.keys.prod_icp }} y debe haber configurado Kubernetes Cluster siguiendo la documentación de [instalación de {{ site.data.keys.prod_icp }}](https://www.ibm.com/support/knowledgecenter/SSBS6K_3.1.0/installing/install_containers.html#setup).

Para gestionar los contenedores y las imágenes, debe instalar las herramientas siguientes en la máquina host como parte de la configuración de {{ site.data.keys.prod_icp }}:

* Docker
* CLI de IBM Cloud (`cloudctl`)
* Kubernetes CLI (`kubectl`)
* Helm (`helm`)

Para acceder a {{ site.data.keys.prod_icp }} Cluster mediante CLI, debe configurar el cliente *kubectl*. [Más información](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_3.1.0/manage_cluster/cfc_cli.html).

## Descargar el archivo Passport Advantage de IBM Mobile Foundation
{: #download-the-ibm-mfpf-ppa-archive}
El archivo Passport Advantage (PPA) de {{ site.data.keys.product_full }} está disponible [aquí](https://www-01.ibm.com/software/passportadvantage/pao_customer.html). El archivo PPA de {{ site.data.keys.product }} contendrá las imágenes docker y los gráficos Helm de los componentes siguientes de {{ site.data.keys.product }}:
* {{ site.data.keys.product_adj }} Server
* {{ site.data.keys.product_adj }} Analytics
* {{ site.data.keys.product_adj }} Application Center

## Cargar el archivo Passport Advantage de IBM Mobile Foundation
{: #load-the-ibm-mfpf-ppa-archive}
Antes de cargar el archivo PPA de {{ site.data.keys.product }}, debe configurar Docker. Consulte las instrucciones [aquí](https://www.ibm.com/support/knowledgecenter/SSBS6K_2.1.0/manage_images/using_docker_cli.html).

Siga los pasos indicados a continuación para cargar el archivo PPA en el clúster de {{ site.data.keys.prod_icp }}:

  1. Inicie sesión en el clúster con el plugin IBM Cloud ICP (`cloudctl`).
      >Consulte [Referencia de mandatos de CLI](https://www.ibm.com/support/knowledgecenter/SSBS6K_3.1.0/manage_cluster/cli_commands.html) en la documentación de {{ site.data.keys.prod_icp }}.

      Por ejemplo:
      ```bash
      cloudctl login -a https://ip:puerto
      ```
      Opcionalmente, si desea omitir la validación SSL, utilice el distintivo `--skip-ssl-validation` en el mandato anterior. Mediante esta opción, se solicitan los valores de `username` y `password` del punto final del clúster. Continúe con los pasos siguientes, una vez iniciada la sesión.

  2. Cargue el archivo PPA de {{ site.data.keys.product }} mediante el mandato siguiente:
      ```
      cloudctl load-ppa-archive --archive <nombre_archivado> [--clustername <nombre_clúster>] [--namespace <espacio de nombres>]
      ```
      *archive_name* de {{ site.data.keys.product }} es el nombre del archivo PPA descargado desde IBM Passport Advantage,

      `--clustername` puede ignorarse si se ha seguido el paso anterior y se ha establecido el punto final del clúster como valor predeterminado para `cloudctl`.

  3. Después de cargar el archivo PPA, sincronice los repositorios, lo que garantiza que se listen los gráficos Helm en el **Catálogo**. Puede realizar esta acción en la consola de gestión de {{ site.data.keys.prod_icp }}.
      * Seleccione **Administración > Repositorios**.
      * Pulse **Sincronizar repositorios**.

  4.  Vea las imágenes Docker y los gráficos Helm en la consola de gestión de {{ site.data.keys.prod_icp }}.
      Para ver las imágenes Docker,
      * Seleccione **Plataforma > Imágenes**.
      * Los gráficos Helm se muestran en el **Catálogo**.

  Tras completar los pasos anteriores, verá que aparece la versión cargada de {{ site.data.keys.prod_adj }} los gráficos Helm en el catálogo de ICP. {{ site.data.keys.mf_server }} se lista como **ibm-mfpf-server-prod**, y {{ site.data.keys.mf_analytics }} como **ibm-mfpf-analytics-prod**.

## Instalar y configurar gráficos Helm de IBM {{ site.data.keys.product }}
{: #configure-install-mf-helmcharts}

Antes de instalar y configurar {{ site.data.keys.mf_server }}, debe tener lo siguiente:

* [**Obligatorio**] una base de datos DB2 configurada y lista para utilizar.
  Necesitará la información de base de datos para [configurar {{ site.data.keys.mf_server }} helm](#install-hmc-icp). {{ site.data.keys.mf_server }} requiere un esquema y tablas, que se crearán (si no existen) en esta base de datos.

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

### Variables de entorno de {{ site.data.keys.mf_analytics }}
{: #env-mf-analytics }
La tabla siguiente indica las variables de entorno utilizadas en {{ site.data.keys.mf_analytics }} en {{ site.data.keys.prod_icp }}.

| Calificador | Parámetro | Definición | Valor permitido |
|-----------|-----------|------------|---------------|
| arch |  | Arquitectura de nodo de trabajador | Arquitectura de nodo de trabajador en la que debe desplegarse este gráfico.<br/>Actualmente, solo se admite la plataforma **AMD64**. |
| image | pullPolicy | Política de extracción de imágenes | El valor predeterminado es **IfNotPresent**. |
|  | tag | Etiqueta de imagen Docker | Consulte [Descripción de etiquetas de Docker](https://docs.docker.com/engine/reference/commandline/image_tag/) |
|  | name | Nombre de imagen Docker | Nombre de la imagen docker de {{ site.data.keys.prod_adj }} Operational Analytics. |
| scaling | replicaCount | Número de instancias (pods) de {{ site.data.keys.prod_adj }} Operational Analytics que deben crearse | Número entero positivo<br/>El valor predeterminado es **2** |
| mobileFirstAnalyticsConsole | user | Nombre de usuario de {{ site.data.keys.prod_adj }} Operational Analytics | El valor predeterminado es **admin**. |
|  | password | Contraseña de {{ site.data.keys.prod_adj }} Operational Analytics | El valor predeterminado es **admin**. |
| analyticsConfiguration | clusterName | Nombre del clúster de {{ site.data.keys.prod_adj }} Analytics | El valor predeterminado es **mobilefirst** |
|  | analyticsDataDirectory | Vía de acceso donde se almacenan los datos de análisis. *La vía de acceso será la misma si la reclamación de volumen persistente se monta dentro del contenedor*. | El valor predeterminado es `/analyticsData` |
|  | numberOfShards | Número de fragmentos Elasticsearch de {{ site.data.keys.prod_adj }} Analytics | Número entero positivo<br/>El valor predeterminado es **2** |
|  | replicasPerShard | Número de réplicas Elasticsearch que se van a mantener por cada fragmento de {{ site.data.keys.prod_adj }} Analytics | Número entero positivo<br/>El valor predeterminado es **2** |
| keystores | keystoresSecretName | Consulte [Instalar y configurar gráficos Helm de IBM {{ site.data.keys.product }}](#configure-install-mf-helmcharts), donde se describen los pasos para crear el secreto con los almacenes y sus contraseñas. |  |
| jndiConfigurations | mfpfProperties | Propiedades {{ site.data.keys.prod_adj }} JNDI que se deben especificar para personalizar Operational Analytics | Proporcione pares nombre-valor separados por comas. |
| resources | limits.cpu | Describe la cantidad máxima de CPU permitidas | El valor predeterminado es **2000m**<br/>Lea el [significado de CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu). |
|  | limits.memory | Describe la cantidad máxima de memoria permitida | El valor predeterminado es **4096Mi**<br/>Lea el [significado de memoria](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory). |
|  | requests.cpu | Describe la cantidad mínima de CPU necesarias. Si no se especifica, el valor predeterminado será *limits* (si se especifica) o el valor definido por implementación. | El valor predeterminado es **1000m**. |
|  | requests.memory | Describe la cantidad mínima de memoria necesaria. Si no se especifica, el valor predeterminado de la cantidad de memoria será *limits* (si se especifica) o el valor definido por implementación. | El valor predeterminado es **2048Mi**. |
| persistence | existingClaimName | El nombre de la reclamación de volumen de persistencia (PVC) |  |
| logs | consoleFormat | Especifica el formato de salida del registro del contenedor. | El valor predeterminado es **json**. |
|  | consoleLogLevel | Controla la granularidad de los mensajes que van al registro del contenedor. | El valor predeterminado es **info**. |
|  | consoleSource | Especifica los orígenes que se escriben en el registro del contenedor. Utilice una lista separada por comas para varios orígenes. | El valor predeterminado es **message**, **trace**, **accessLog**, **ffdc**. |


### Variables de entorno de {{ site.data.keys.mf_server }}
{: #env-mf-server }
La tabla siguiente indica las variables de entorno utilizadas en {{ site.data.keys.mf_server }} en {{ site.data.keys.prod_icp }}.

| Calificador | Parámetro | Definición | Valor permitido |
|-----------|-----------|------------|---------------|
| arch |  | Arquitectura de nodo de trabajador | Arquitectura de nodo de trabajador en la que debe desplegarse este gráfico.<br/>Actualmente, solo se admite la plataforma **AMD64**. |
| image | pullPolicy | Política de extracción de imágenes | El valor predeterminado es **IfNotPresent**. |
|  | tag | Etiqueta de imagen Docker | Consulte [Descripción de etiquetas de Docker](https://docs.docker.com/engine/reference/commandline/image_tag/) |
|  | name | Nombre de imagen Docker | Nombre de la imagen Docker de {{ site.data.keys.prod_adj }} Server. |
| scaling | replicaCount | Número de instancias (pods) de {{ site.data.keys.prod_adj }} Server que deben crearse | Número entero positivo<br/>El valor predeterminado es **3** |
| mobileFirstOperationsConsole | user | Nombre de usuario de {{ site.data.keys.prod_adj }} Server | El valor predeterminado es **admin**. |
|  | password | Contraseña del usuario de {{ site.data.keys.prod_adj }} Server | El valor predeterminado es **admin**. |
| existingDB2Details | db2Host | Dirección IP o HOST de la base de datos DB2 donde se deben configurar las tablas de {{ site.data.keys.prod_adj }} Server | Actualmente, solo se admite DB2. |
|  | db2Port | Puerto en el que está configurada la base de datos DB2 |  |
|  | db2Database | Nombre de la base de datos que está preconfigurada para utilizar en DB2 |  |
|  | db2Username | Nombre de usuario de DB2 para acceder a la base de datos DB2 | El usuario debe tener acceso para crear tablas y crear el esquema si no existe todavía. |
|  | db2Password | Contraseña de DB2 de la base de datos proporcionada  |  |
|  | db2Schema | Esquema de DB2 de servidor que se va a crear |  |
|  | db2ConnectionIsSSL | Tipo de conexión de DB2 | Especifique si la conexión de la base de datos debe ser **http** o **https**. El valor predeterminado es **false** (http).<br/>Asegúrese de que el puerto de DB2 también esté configurado para la misma modalidad de conexión. |
| existingMobileFirstAnalytics | analyticsEndPoint | URL del servidor de análisis | Por ejemplo: `http://9.9.9.9:30400`.<br/> No especifique la vía de acceso a la consola, se añadirá durante el despliegue.
 |
|  | analyticsAdminUser | Nombre de usuario del usuario administrador de analítica |  |
|  | analyticsAdminPassword | Contraseña del usuario administrador de analítica |  |
| keystores | keystoresSecretName | Consulte [Instalar y configurar gráficos Helm de IBM {{ site.data.keys.product }}](#configure-install-mf-helmcharts), donde se describen los pasos para crear el secreto con los almacenes y sus contraseñas. |  |
| jndiConfigurations | mfpfProperties | Propiedades JNDI de servidor {{ site.data.keys.prod_adj }} para personalizar el despliegue | Pares nombre-valor separados por comas. |
| resources | limits.cpu | Describe la cantidad máxima de CPU permitidas | El valor predeterminado es **2000m**<br/>Lea el [significado de CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu). |
|  | limits.memory | Describe la cantidad máxima de memoria permitida | El valor predeterminado es **4096Mi**<br/>Lea el [significado de memoria](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory). |
|  | requests.cpu | Describe la cantidad mínima de CPU necesarias. Si no se especifica, el valor predeterminado es *limits* (si se especifica) o el valor definido por implementación. | El valor predeterminado es **1000m**. |
|  | requests.memory | Describe la cantidad mínima de memoria necesaria. Si no se especifica, el valor predeterminado es *limits* (si se especifica) o el valor definido por implementación | El valor predeterminado es **2048Mi**. |
| logs | consoleFormat | Especifica el formato de salida del registro del contenedor. | El valor predeterminado es **json**. |
|  | consoleLogLevel | Controla la granularidad de los mensajes que van al registro del contenedor. | El valor predeterminado es **info**. |
|  | consoleSource | Especifica los orígenes que se escriben en el registro del contenedor. Utilice una lista separada por comas para varios orígenes. | El valor predeterminado es **message**, **trace**, **accessLog**, **ffdc**. |

> Para ver la guía de aprendizaje sobre el análisis de registros de {{ site.data.keys.prod_adj }} utilizando Kibana, consulte [aquí](analyzing-mobilefirst-logs-on-icp/).

### Instalación de gráficos Helm {{ site.data.keys.prod_adj }} desde el catálogo de ICP
{: #install-hmc-icp}

#### Instalación de {{ site.data.keys.mf_analytics }}
{: #install-mf-analytics}

La instalación de {{ site.data.keys.mf_analytics }} es opcional. Si desea habilitar el análisis en {{ site.data.keys.mf_server }}, primero debe configurar e instalar {{ site.data.keys.mf_analytics }}, antes de instalar {{ site.data.keys.mf_server }}.

Antes de empezar la instalación del gráfico de {{ site.data.keys.mf_analytics }}, configure el **Volumen persistente**. Proporcione el **Volumen persistente** para configurar {{ site.data.keys.mf_analytics }}. Siga los pasos detallados en la [documentación de {{ site.data.keys.prod_icp }}](https://www.ibm.com/support/knowledgecenter/SSBS6K_2.1.0/manage_cluster/create_volume.html) para crear el **Volumen persistente**.

Siga estos pasos para instalar y configurar IBM {{ site.data.keys.mf_analytics }} desde la consola de gestión de {{ site.data.keys.prod_icp }}.

1. Vaya a **Catálogo** en la consola de gestión.
2. Seleccione el gráfico Helm **ibm-mfpf-analytics-prod**.
3. Pulse **Configurar**.
4. Proporcione las variables de entorno. Consulte [Variables de entorno de {{ site.data.keys.mf_analytics }}](#env-mf-analytics) para obtener más información.
5. Acepte el **Acuerdo de licencia**.
6. Pulse **Instalar**.

#### Instalación de {{ site.data.keys.mf_server }}
{: #install-mf-server}

Antes de empezar la instalación de {{ site.data.keys.mf_server }}, preconfigure una base de datos DB2.


Siga estos pasos para instalar y configurar IBM {{ site.data.keys.mf_server }} desde la consola de gestión de {{ site.data.keys.prod_icp }}.

1. Vaya a **Catálogo** en la consola de gestión.
2. Seleccione el gráfico Helm **ibm-mfpf-server-prod**.
3. Pulse **Configurar**.
4. Proporcione las variables de entorno. Consulte [Variables de entorno de {{ site.data.keys.mf_server }}](#env-mf-server) para obtener más información.
5. Acepte el **Acuerdo de licencia**.
6. Pulse **Instalar**.

## Verificación de la instalación
{: #verify-install}

Después de haber instalado y configurado {{ site.data.keys.mf_analytics }} (opcional) y {{ site.data.keys.mf_server }}, puede verificar la instalación y el estado de los pods desplegados mediante las acciones siguientes:

En la consola de gestión de {{ site.data.keys.prod_icp }}. Seleccione **Cargas de trabajo > Releases de Helm**. Pulse el *nombre de release* de la instalación.


## Acceso a la consola {{ site.data.keys.prod_adj }}
{: #access-mf-console}

Una vez realizada la instalación correctamente, puede acceder a la consola operativa de IBM {{ site.data.keys.prod_adj }} mediante `<protocol>://<ip_address>:<port>/mfpconsole`.
Se puede acceder a la consola de IBM {{ site.data.keys.mf_analytics }} mediante `<protocol>://<ip_address>:<port>/analytics/console`.

El protocolo puede ser `http` o `https`. Además, tenga en cuenta que el puerto será **NodePort** en el caso del despliegue de **NodePort**. Para obtener los valores de ip_address y **NodePort** de los gráficos {{ site.data.keys.prod_adj }} instalados, siga estos pasos:

1. En la consola de gestión de {{ site.data.keys.prod_icp }}, seleccione **Cargas de trabajo > Releases de Helm**.
2. Pulse el *nombre de release* de la instalación de gráfico Helm.
3. Consulte la sección **Notas**.

>**Nota:** El puerto 9600 se expone internamente en el servicio Kubernetes y las instancias de {{ site.data.keys.prod_adj }} Analytics lo utilizan como puerto de transporte.


## Aplicación de ejemplo
{: #sample-app}
Consulte las [{{ site.data.keys.prod_adj }} guías de aprendizaje](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/all-tutorials/) para desplegar el adaptador de ejemplo y ejecutar la aplicación de ejemplo en IBM {{ site.data.keys.mf_server }} en ejecución en {{ site.data.keys.prod_icp }},

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
Para desinstalar {{ site.data.keys.mf_server }} y {{ site.data.keys.mf_analytics }}, utilice [Helm CLI](https://docs.helm.sh/using_helm/#installing-helm).
Utilice el mandato siguiente para suprimir completamente los gráficos instalados y los despliegues asociados:
```bash
helm delete --purge <release_name>
```
*release_name* es el nombre de release desplegado del gráfico Helm.
