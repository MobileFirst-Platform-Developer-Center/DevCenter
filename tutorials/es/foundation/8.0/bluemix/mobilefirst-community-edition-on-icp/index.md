---
layout: tutorial
title: Despliegue de IBM Mobile Foundation for Developers 8.0 on IBM Cloud Private
breadcrumb_title: Foundation for Developers on IBM Cloud Private
relevantTo: [ios,android,windows,javascript]
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }

IBM Mobile Foundation for Developers 8.0 on {{ site.data.keys.prod_icp }} es una edición de Mobile Foundation para desarrolladores, que se compone del servidor de Mobile Foundation server y componentes de Operational Analytics. El entorno de ejecución del servidor tiene una base de datos Derby incorporada para almacenar los datos de Mobile Foundation. Esto restringe a los usuarios a un pod en el despliegue de Kubernetes en {{ site.data.keys.prod_icp }}. La Community Edition proporciona a los usuarios de Mobile Foundation una experiencia de desarrollador con parámetros de configuración mínimos y facilidad de configuración de la instancia de Mobile Foundation en {{ site.data.keys.prod_icp }}.

Siga las instrucciones que se detallan a continuación para instalar la edición de desarrollador de IBM Mobile Foundation server con Operational Analytics pre-configurado en {{ site.data.keys.prod_icp }}:<br/>
* Configure IBM Cloud Private Kubernetes Cluster (IBM Cloud Private CE o Native/Enterprise).
* [Opcional] Configure su sistema host con las herramientas necesarias: CLI de Docker, de IBM Cloud (cloudctl), de Kubernetes (kubectl) y de Helm (helm).


#### Ir a:
{: #jump-to }
* [Requisitos previos](#prereqs)
* [Instalación y configuración de IBM Mobile Foundation for Developers 8.0 desde el catálogo de IBM Cloud Private](#install-the-ibm-mfpf-icp-catalog)
* [Verificación de la instalación](#verify-install)
* [Aplicación de ejemplo](#sample-app)
* [Desinstalar](#uninstall)
* [Limitaciones](#limitations)

## Requisitos previos
{: #prereqs}

Debe tener IBM Cloud Private (Community Edition o Native/Enterprise) configurado y listo. Consulte [Instalación de IBM Cloud Private Cluster](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_3.1.1/installing/install.html) la documentación para obtener instrucciones de configuración.

Para gestionar los contenedores y las imágenes, debe instalar las herramientas siguientes en la máquina host como parte de la configuración de {{ site.data.keys.prod_icp }}:

* Docker
* CLI de IBM Cloud (`cloudctl`)
* Kubernetes CLI (`kubectl`)
* Helm (`helm`)

Para acceder a {{ site.data.keys.prod_icp }} Cluster mediante CLI, debe configurar el cliente *kubectl*. [Más información](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_3.1.0/manage_cluster/cfc_cli.html).


## Instalación y configuración del gráfico de Helm de IBM Mobile Foundation for Developers 8.0
{: #install-the-ibm-mfpf-icp-catalog}

Siga el procedimiento explicado en [Despliegue de gráficos de Helm del catálogo](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_3.1.1/app_center/create_release.html)para instalar el gráfico de Helm de IBM Mobile Foundation for Developers 8.0 (**ibm-mobilefoundation-dev**) desde el catálogo.

### Variables de entorno para IBM Mobile Foundation for Developers 8.0
{: #env-mf-developers }
La tabla siguiente indica las variables de entorno utilizadas en IBM Mobile Foundation for Developers 8.0:

| Calificador | Parámetro | Definición | Valor permitido |
|-----------|-----------|------------|---------------|
| arch |  | Arquitectura de nodo de trabajador | Arquitectura de nodo de trabajador en la que debe desplegarse este gráfico.<br/>Actualmente, solo se admite la plataforma **AMD64**. |
| image | pullPolicy | Política de extracción de imágenes | Always, Never, o IfNotPresent.  <br/>El valor predeterminado es **IfNotPresent**. |
|  | repository | Nombre de imagen Docker | Nombre de la imagen Docker del servidor de {{ site.data.keys.prod_adj }}. |
|  | tag | Etiqueta de imagen Docker | Consulte [Descripción de etiquetas de Docker](https://docs.docker.com/engine/reference/commandline/image_tag/) |
| resources | limits.cpu | Describe la cantidad máxima de CPU permitidas | El valor predeterminado es 2000m. Consulte Kubernetes - [significado de CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu). |
|  | limits.memory | Describe la cantidad máxima de memoria permitida | El valor predeterminado es 4096Mi. Consulte Kubernetes - [significado de memoria](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory). |
|  | requests.cpu | Describe la cantidad mínima de CPU requerida - si no se especifica tomará el valor predeterminado del limite (si se ha especificado) o de lo contrario el valor definido por la implementación | El valor predeterminado es 2000m. Consulte Kubernetes - [significado de CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu). |
|  | requests.memory | Describe la cantidad mínima de memoria necesaria. Si no se especifica, el valor predeterminado de la cantidad de memoria será el límite (si se ha especificado) o el valor definido por implementación. | El valor predeterminado es 2048Mi. Consulte Kubernetes - [significado de memoria](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory). |
| logs | consoleFormat | Especifica el formato de salida del registro del contenedor. | El valor predeterminado es **json**. |
|  | consoleLogLevel | Controla la granularidad de los mensajes que van al registro del contenedor. | El valor predeterminado es **info**. |
|  | consoleSource | Especifica los orígenes que se escriben en el registro del contenedor. Utilice una lista separada por comas para varios orígenes. | El valor predeterminado es **message**, **trace**, **accessLog**, **ffdc**. |

## Verificación de la instalación
{: #verify-install}

Cuando haya instalado Mobile Foundation for Developers 8.0, puede verificar la instalación y el estado de los pods desplegados haciendo lo siguiente:

En la consola de gestión de {{ site.data.keys.prod_icp }}. Seleccione **Cargas de trabajo > Releases de Helm**. Pulse el *nombre de release* de la instalación.


## Acceso a la consola {{ site.data.keys.prod_adj }}
{: #access-mf-console}

Una vez realizada la instalación correctamente, puede acceder a la consola operativa de IBM {{ site.data.keys.prod_adj }} mediante `<protocol>://<ip_address>:<port>/mfpconsole`.
Se puede acceder a la consola de IBM {{ site.data.keys.mf_analytics }} mediante `<protocol>://<ip_address>:<port>/analytics/console`.

El protocolo puede ser `http` o `https`. Además, tenga en cuenta que el puerto será **NodePort** en el caso del despliegue de **NodePort**. Para obtener los valores de ip_address y **NodePort** de los gráficos {{ site.data.keys.prod_adj }} instalados, siga estos pasos:

1. En la consola de gestión de {{ site.data.keys.prod_icp }}, seleccione **Cargas de trabajo > Releases de Helm**.
2. Pulse el *nombre de release* de la instalación de gráfico Helm.
3. Consulte la sección **Notas**.

## Aplicación de ejemplo
{: #sample-app}
Consulte las [{{ site.data.keys.prod_adj }} guías de aprendizaje](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/all-tutorials/) para desplegar el adaptador de ejemplo y ejecutar la aplicación de ejemplo en IBM {{ site.data.keys.mf_server }} en ejecución en {{ site.data.keys.prod_icp }},

## Desinstalar
{: #uninstall}
Para desinstalar {{ site.data.keys.mf_server }} y {{ site.data.keys.mf_analytics }}, utilice [Helm CLI](https://docs.helm.sh/using_helm/#installing-helm).

Desde el panel de control, pulse en **Cargas de trabajo > Releases de Helm**, busque el *release_name* utilizado para desplegar el gráfico, pulse en el menú **Acción** y elija **Suprimir** para suprimir completamente los gráficos instalados.

Utilice el mandato siguiente para suprimir completamente los gráficos instalados y los despliegues asociados:
```bash
helm delete --purge <release_name>
```
*release_name* es el nombre de release desplegado del gráfico Helm.

## Limitaciones
{: #limitations}

Este gráfico de Helm se proporciona únicamente con finalidades de desarrollo y prueba. Los datos se almacenan en la base de datos Derby incluida. El gráfico funciona con un solo pod debido a las restricciones de la base de datos.
