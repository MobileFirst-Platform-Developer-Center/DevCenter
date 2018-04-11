---
layout: tutorial
breadcrumb_title: Mobile Foundation on IBM Cloud
title: IBM Mobile Foundation en IBM Cloud
relevantTo: [ios,android,windows,javascript]
weight: 10
---
<!-- NLS_CHARSET=UTF-8 -->
<br/><br/>
> **Nota:** *IBM Bluemix ahora es IBM Cloud. Para obtener más información, consulte [aquí](https://www.ibm.com/blogs/bluemix/2017/10/bluemix-is-now-ibm-cloud/).*

## Visión general
{: #overview }
{{ site.data.keys.product_full }} se puede alojar en IBM Cloud. La siguiente es información básica acerca de IBM Cloud.

IBM Cloud es una implementación de IBM Open Cloud Architecture. Utiliza Cloud Foundry para permitir que los desarrolladores creen, desplieguen y gestionen rápidamente sus aplicaciones en la nube, mientras utilizan un creciente ecosistema de servicios y de infraestructuras de tiempo de ejecución disponibles.

> Obtenga más información sobre la arquitectura de IBM Cloud y los conceptos de IBM Cloud [aquí](https://console.bluemix.net/docs/overview/ibm-cloud.html#overview).

### ¿Cómo funciona?
{: #how-does-it-work }
En breves palabras, hay dos modos de ejecutar {{ site.data.keys.product }} en IBM Cloud, en función del tipo de titularidad de licencia.

> **Nota:** *El servicio IBM Containers está ahora en desuso, por lo tanto, Mobile Foundation no está admitido en IBM Containers. [Más información](https://www.ibm.com/blogs/bluemix/2017/07/deprecation-single-scalable-group-container-service-bluemix-public/).*

* Suscripción de IBM Cloud o licencia PayGo: Servicio {{ site.data.keys.mf_bm_full }}
* Licencia On Prem: Utilice scripts proporcionados por IBM para configurar una instancia de {{ site.data.keys.product_full }} en clústeres de Kubernetes o en el tiempo de ejecución de Liberty for Java.

<!--To run {{ site.data.keys.product }} on Bluemix IBM Containers, several components must interact with one another: the first component is an **image** that contains a **Linux distribution with a WebSphere Liberty installation**, with a **{{ site.data.keys.mf_server }} instance** deployed to it. The image is then stored inside an **IBM Container**, and the IBM Container is managed by **Bluemix**.-->

Para ejecutar {{ site.data.keys.product}} en un tiempo de ejecución de IBM Cloud Liberty for Java, se utilizan los componentes siguientes: una **aplicación Cloudfoundry** que contiene una **instalación de WebSphere Liberty**, con una **instancia de {{ site.data.keys.mf_server }}** desplegada.

### Kubernetes Cluster en IBM Cloud
Kubernetes es una herramienta de orquestación para planificar los contenedores de aplicación en un clúster de máquinas de sistemas. Con Kubernetes, los desarrolladores pueden desarrollar rápidamente aplicaciones de alta disponibilidad utilizando la potencia y la flexibilidad de los contenedores.
Puede utilizar Kubernetes CLI para crear y gestionar los clústeres de Kubernetes.

[Obtenga más información acerca de Kubernetes Cluster en IBM Cloud](https://console.bluemix.net/docs/containers/cs_tutorials.html#cs_tutorials)

<!--### IBM Containers
{: #ibm-containers }
IBM Containers are objects that are used to run images in a hosted cloud environment. IBM Containers hold everything that an app needs to run.

IBM Container infrastructure includes a private registry for your images, so that you can upload, store, and retrieve them. You can make those images available for Bluemix to manage them. A command line interface is then used to manage your containers on Bluemix - More on this in the following tutorials.

[Learn more about IBM Containers](https://www.ng.bluemix.net/docs/containers/container_index.html).-->

### Tiempo de ejecución de Liberty for Java
{: #liberty-for-java-runtime }
El tiempo de ejecución de Liberty for Java está basado en el paquete de compilación de liberty-for-java. El paquete de compilación liberty-for-java proporciona un entorno de tiempo de ejecución completo para ejecutar aplicaciones sobre el perfil de WebSphere Liberty. Se utiliza una interfaz de línea de mandatos para gestionar las aplicaciones en IBM Cloud.

[Obtenga más información acerca de Liberty for Java](https://console.bluemix.net/docs/runtimes/liberty/index.html).


## Guías de aprendizaje que se han de seguir a continuación
{: #tutorials-to-follow-next }

* Crear una instancia de {{ site.data.keys.mf_bm_short }} en Kubernetes Cluster en IBM Cloud [mediante scripts proporcionados por IBM](mobilefirst-server-using-kubernetes/).
* Crear una instancia de {{ site.data.keys.mf_server }} utilizando la guía de aprendizaje [Configuración del servicio de {{ site.data.keys.mf_bm }}](using-mobile-foundation/).
<!--* Create a {{ site.data.keys.mf_server }} instance on Bluemix [using IBM provided scripts](mobilefirst-server-using-scripts/) using IBM Containers.-->
* Crear una instancia de {{ site.data.keys.mf_server }} mediante Liberty for Java en IBM Cloud [mediante scripts proporcionados por IBM](mobilefirst-server-using-scripts-lbp/).
