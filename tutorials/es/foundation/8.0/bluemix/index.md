---
layout: tutorial
breadcrumb_title: Foundation on Bluemix
title: IBM MobileFirst Foundation on Bluemix
relevantTo: [ios,android,windows,javascript]
weight: 10
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
{{ site.data.keys.product_full }} se puede alojar en Bluemix. La siguiente es información básica acerca de Bluemix.

IBM Bluemix es una implementación de IBM Open Cloud Architecture. Utiliza Cloud Foundry para permitir que los desarrolladores creen, desplieguen y gestionen rápidamente sus aplicaciones en la nube, mientras utilizan un creciente ecosistema de servicios y de infraestructuras de tiempo de ejecución disponibles.

> Obtenga más información acerca de la arquitectura de Bluemix y los conceptos de Bluemix [en el sitio web de Bluemix](https://console.ng.bluemix.net/docs/overview/whatisbluemix.html#bluemixoverview).

### ¿Cómo funciona?
{: #how-does-it-work }
En breves palabras, hay dos modos de ejecutar {{ site.data.keys.product }} en Bluemix, en función del tipo de titularidad de licencia.

* Suscripción de Bluemix o licencia PayGo: Servicio {{ site.data.keys.mf_bm_full }}
* Licencia On Prem: Utilice scripts proporcionados por IBM para configurar una instancia de {{ site.data.keys.product_full }} en IBM Containers o en el tiempo de ejecución de Liberty for Java.

Para ejecutar {{ site.data.keys.product }} en Bluemix IBM Containers, varios componentes deben interactuar entre sí: el primer componente es una **imagen** que contiene una **distribución de Linux con una instalación de WebSphere Liberty**, con una instancia de **{{ site.data.keys.mf_server }}** desplegada. A continuación, la imagen se almacena en un **IBM Container** y **Bluemix** gestiona IBM Container. 

Para ejecutar {{ site.data.keys.product}} en un tiempo de ejecución de Bluemix Liberty for Java, se utilizan los componentes siguientes: una **aplicación Cloudfoundry** que contiene una **instalación de WebSphere Liberty**, con una **instancia de {{ site.data.keys.mf_server }}** desplegada. 

### Kubernetes Cluster en Bluemix
Kubernetes es una herramienta de orquestación para planificar los contenedores de aplicación en un clúster de máquinas de sistemas. Con Kubernetes, los desarrolladores pueden desarrollar rápidamente aplicaciones de alta disponibilidad utilizando la potencia y la flexibilidad de los contenedores.
Puede utilizar IBM Bluemix Container Service CLI o Kubernetes CLI para crear y gestionar los clústeres de Kubernetes.

[Obtenga más información acerca de Kubernetes Cluster en Bluemix](https://console.bluemix.net/docs/containers/cs_tutorials.html#cs_tutorials)

### IBM Containers
{: #ibm-containers }
Los contenedores de IBM Container son objetos que se utilizan para ejecutar imágenes en un entorno de nube alojado. Los contenedores de IBM Container contienen todo lo que necesita una aplicación para ejecutarse.

La infraestructura de IBM Container incluye un registro privado para sus imágenes, de modo que pueda cargar, almacenar y recuperar las imágenes. Puede hacer que estas imágenes estén disponibles para que las gestione Bluemix. En este caso, se utiliza una interfaz de línea de mandatos para gestionar los contenedores de Bluemix. Puede obtener más información en las siguientes guías de aprendizaje.

[Obtenga más información acerca de IBM Containers](https://www.ng.bluemix.net/docs/containers/container_index.html).

### Tiempo de ejecución de Liberty for Java
{: #liberty-for-java-runtime }
El tiempo de ejecución de Liberty for Java está basado en el paquete de compilación de liberty-for-java. El paquete de compilación liberty-for-java proporciona un entorno de tiempo de ejecución completo para ejecutar aplicaciones sobre el perfil de WebSphere Liberty. Se utiliza una interfaz de línea de mandatos para gestionar las aplicaciones en Bluemix.

[Obtenga más información acerca de Liberty for Java](https://new-console.ng.bluemix.net/docs/runtimes/liberty/index.html).


## Guías de aprendizaje que se han de seguir a continuación
{: #tutorials-to-follow-next }

* Crear una instancia de {{ site.data.keys.mf_bm_short }} en Bluemix [mediante scripts proporcionados por IBM](mobilefirst-server-using-kubernetes/) utilizando Kubernetes Cluster.
* Crear una instancia de {{ site.data.keys.mf_server }} [utilizando el servicio de {{ site.data.keys.mf_bm }}](using-mobile-foundation/).
* Crear una instancia de {{ site.data.keys.mf_server }} en Bluemix [mediante scripts proporcionados por IBM](mobilefirst-server-using-scripts/) utilizando IBM Containers.
* Crear una instancia de {{ site.data.keys.mf_server }} en Bluemix [mediante scripts proporcionados por IBM](mobilefirst-server-using-scripts-lbp/) utilizando Liberty
