---
layout: tutorial
title: Despliegue de IBM Mobile Foundation for Developers 8.0 en IBM Cloud Kubernetes Cluster
breadcrumb_title: Foundation for Developers on IBM Cloud Kubernetes Cluster
relevantTo: [ios,android,windows,javascript]
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }

IBM Mobile Foundation for Developers 8.0 es una edición de desarrollador que consta de los componentes Servidor y Operational Analytics.

El entorno de ejecución del servidor de Mobile Foundation incluye una base de datos Derby incorporada para almacenar los datos de Mobile Foundation. Esto restringe a los usuarios a un pod en el despliegue de IBM Cloud Kubernetes. Community Edition proporciona a los usuarios de Mobile Foundation una experiencia de desarrollador con un número mínimo de parámetros de configuración y facilita la configuración de la instancia de Mobile Foundation en IBM Cloud Kubernetes Service. 

Siga las instrucciones que se detallan a continuación para instalar la edición de desarrollador de IBM Mobile Foundation Server con Operational Analytics preconfigurado en IBM Cloud Kubernetes: <br/>
* Cree y configure un clúster de Kubernetes [aquí](https://cloud.ibm.com/kubernetes/clusters).
* [Opcional] Configure su sistema host con las herramientas necesarias: CLI de docker, CLI de Kubernetes (kubectl) y CLI de Helm (helm).

#### Ir a:
{: #jump-to }

* [Requisitos previos](#prereqs)
* [Instalar y configurar IBM Mobile Foundation for Developers 8.0 desde el catálogo de gráficos helm](#install-the-ibm-mfpf-iks-catalog)
* [Verificación de la instalación](#verify-install)
* [Aplicación de ejemplo](#sample-app)
* [Desinstalar](#uninstall)
* [Limitaciones](#limitations)

## Requisitos previos
{: #prereqs}

Debe haber creado IBM Cloud Kubernetes Service (plan gratuito) utilizando el portal
[IBM Cloud](https://cloud.ibm.com/). Consulte la   [documentación](https://cloud.ibm.com/docs/containers?topic=containers-getting-started) para obtener las instrucciones.
Para gestionar pods de kube y el despliegue de helm, debe instalar las herramientas siguientes en su máquina host:
* CLI ibmcloud (`ibmcloud`)
* CLI de Kubernetes (`kubectl`)
* Helm (`helm`)
Para trabajar con el clúster Kubernetes utilizando la CLI, debe configurar el cliente *ibmcloud*. 
1. Asegúrese de iniciar sesión en la [página Clústeres](https://cloud.ibm.com/kubernetes/clusters). (Nota: la cuenta [IBMid](https://myibm.ibm.com/) es necesaria). 
2. Pulse el clúster Kubernetes en el que se debe desplegar el gráfico de IBM Mobile Foundation.
3. Siga las instrucciones del separador **Acceso** cuando se haya creado el clúster.
>**Nota:** La creación de clúster tarda unos minutos. Cuando el clúster se haya creado correctamente, pulse el separador **Nodos de trabajador** y tome nota de la *IP pública*.

## Instalación y configuración del gráfico de Helm de IBM Mobile Foundation for Developers 8.0
{: #install-the-ibm-mfpf-iks-catalog}

Desde el terminal del cliente de IBM Cloud (CLI de *ibmcloud*), siga el procedimiento de la sección **INSTALAR GRÁFICO** descrito en [Desplegar gráficos desde el catálogo helm](https://cloud.ibm.com/kubernetes/helm/ibm-charts/ibm-mobilefoundation-dev), para instalar el gráfico helm de IBM Mobile Foundation for Developers 8.0 (**ibm-mobilefoundation-dev**) desde el catálogo.

### Variables de entorno para IBM Mobile Foundation for Developers 8.0
{: #env-mf-developers }

La tabla siguiente indica las variables de entorno utilizadas en IBM Mobile Foundation for Developers 8.0:

| Calificador | Parámetro | Definición | Valor permitido |
|-----------|-----------|------------|---------------|
| arch |  | Arquitectura de nodo de trabajador | Arquitectura de nodo de trabajador en la que debe desplegarse este gráfico.<br/>Actualmente, solo se admite la plataforma **AMD64**. |
| image | pullPolicy | Política de extracción de imágenes | Always, Never, o IfNotPresent. <br/>El valor predeterminado es **IfNotPresent**. |
|  | repository | Nombre de imagen Docker | Nombre de la imagen Docker del servidor de {{ site.data.keys.prod_adj }}. |
|  | tag | Etiqueta de imagen Docker | Consulte [Descripción de etiquetas de Docker](https://docs.docker.com/engine/reference/commandline/image_tag/) |
| resources | limits.cpu | Describe la cantidad máxima de CPU permitidas | El valor predeterminado es 1000m. Consulte Kubernetes - [significado de CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu). |
|  | limits.memory | Describe la cantidad máxima de memoria permitida | El valor predeterminado es 2048Mi. Consulte Kubernetes - [significado de memoria](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory). |
|  | requests.cpu | Describe la cantidad mínima de CPU requerida - si no se especifica tomará el valor predeterminado del limite (si se ha especificado) o de lo contrario el valor definido por la implementación | El valor predeterminado es 750m. Consulte Kubernetes - [significado de CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu). |
|  | requests.memory | Describe la cantidad mínima de memoria necesaria. Si no se especifica, el límite será el valor predeterminado de cantidad de memoria (si se ha especificado mediante values.yaml) o el valor definido por la implementación. | El valor predeterminado es 1024Mi. Consulte Kubernetes - [significado de memoria](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory). |
| logs | consoleFormat | Especifica el formato de salida del registro del contenedor. | El valor predeterminado es **json**. |
|  | consoleLogLevel | Controla la granularidad de los mensajes que van al registro del contenedor. | El valor predeterminado es **info**. |
|  | consoleSource | Especifica los orígenes que se escriben en el registro del contenedor. Utilice una lista separada por comas para varios orígenes. | El valor predeterminado es **message**, **trace**, **accessLog**, **ffdc**. |

## Verificación de la instalación
{: #verify-install}

Cuando haya instalado Mobile Foundation for Developers 8.0, puede verificar la instalación y el estado de los pods desplegados haciendo lo siguiente:
1. En la [página Clústeres](https://cloud.ibm.com/kubernetes/clusters), pulse el clúster Kubernetes Cluster en el que se ha desplegado el gráfico de IBM Mobile Foundation.
2. Vaya al panel de control de Kube pulsando el botón **Panel de control de Kubernetes**.
3. En el panel de control, compruebe **Despliegues** y **Pods**, su estado ha de ser **DESPLEGADO** y **EN EJECUCIÓN** respectivamente.
4. Ahora necesita la *IP pública* y el *Puerto de nodo* del despliegue para acceder a los servicios
    - Para obtener la **IP pública**: Seleccione **Kubernetes****> ****Nodos de trabajador**, anote la dirección IP que se proporciona en la *IP pública*.
    - El **Puerto de nodo** se puede encontrar en el **Panel de control de Kubernetes** **>** **Seleccionar servicios** bajo los puntos finales internos, anote la entrada del *Puerto de nodo TCP* (un puerto de cinco dígitos). 
5. Abra un navegador y especifique `http://[public ip]:[node port]/mfpconsole`, esto le llevará a la consola de administración.
6. Escriba las credenciales de usuario como `admin` y la contraseña como `admin` en la consola de Mobile Foundation Server Admin.
7. Asegúrese de que las operaciones de Admin, Push y Analytics estén disponibles.

### [OPCIONAL] Utilización de la línea de mandatos 

De forma alternativa, puede realizar el procedimiento siguiente en la línea de mandatos. Asegúrese de que el mandato siguiente muestra el valor de **estado** como *DESPLEGADO*.
```bash
helm list
```
Ejecute los mandatos `kubectl` para comprobar si el estado de los pods es **EN EJECUCIÓN**.
1. Obtenga la lista de todos los despliegues del clúster Kubernetes y tome nota del nombre del despliegue de Mobile Foundation.
    ```bash
    kubectl get deployments
    ```
2. Ejecute los mandatos siguientes para comprobar la disponibilidad de los despliegues y su estado detalladamente. La disponibilidad de los pods kube se debe mostrar con el estado `(1/1) RUNNING`.
    ```bash
    kubectl describe deployment <deployment_name>
    kubectl get pods
    ```
## Acceso a la consola {{ site.data.keys.prod_adj }}
{: #access-mf-console}

Una vez realizada la instalación correctamente, puede acceder a la consola operativa de IBM {{ site.data.keys.prod_adj }} mediante `<protocol>://<public_ip>:<node_port>/mfpconsole`. <br/>
Se puede acceder a la consola de IBM {{ site.data.keys.mf_analytics }} mediante `<protocol>://<public_ip>:<port>/analytics/console`. El protocolo puede ser `http` o `https`. Además, tenga en cuenta que el puerto será **NodePort** en el caso del despliegue de **NodePort**. Para obtener la dirección ip y **NodePort** de los gráficos de {{ site.data.keys.prod_adj }} instalados, siga estos pasos desde el panel de control de Kubernetes. 
* Para obtener **IP pública**: Seleccione **Kubernetes**>**Nodos de trabajador**> bajo la dirección IP pública; tenga en cuenta la dirección IP.
* El **Puerto de nodo** se puede encontrar en el **Panel de control de Kubernetes**>. Seleccione **Servicios**>bajo los **puntos finales internos**. Tenga en cuenta la entrada para el *Puerto de nodo TCP* (un puerto de cinco dígitos).

## Aplicación de ejemplo
{: #sample-app}

Consulte las [guías de aprendizaje de {{ site.data.keys.prod_adj }}](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/all-tutorials/) para desplegar el adaptador de ejemplo y ejecutar la aplicación de ejemplo en IBM {{ site.data.keys.mf_server }} que se ejecuta en el clúster de IBM Cloud Kubernetes.

## Desinstalar
{: #uninstall}

Para desinstalar el gráfico helm `ibm-mobilefoundation-dev`, utilice la [CLI de Helm](https://docs.helm.sh/using_helm/#installing-helm).
Utilice el mandato siguiente para suprimir completamente los gráficos instalados y los despliegues asociados:
```bash
helm delete --purge <release_name>
```
*release_name* es el nombre de release desplegado del gráfico Helm.

## Limitaciones
{: #limitations}

Este gráfico de Helm se proporciona únicamente con finalidades de desarrollo y prueba. Los datos se almacenan en la base de datos Derby incluida y no son persistentes. El despliegue del gráfico solo funciona con un pod debido a las restricciones de la base de datos.
