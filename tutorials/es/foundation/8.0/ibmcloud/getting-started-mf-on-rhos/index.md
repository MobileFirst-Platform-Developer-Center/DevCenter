---
layout: tutorial
breadcrumb_title: Get started with Foundation on OpenShift
title: Iniciación a Mobile Foundation en un clúster OpenShift
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->


> **NOTA:** Esta guía de iniciación se aplica a OpenShift Container Platform instalado como parte de IBM Cloud Pak for Applications o por separado fuera del mismo. 

* [Introducción](#introduction)
* [Arquitectura](#architecture)
* [Instalación de Mobile Foundation](#install-mf)
* [Desarrollo de aplicaciones](#develop-apps)
* [Despliegue de aplicaciones](#deploying-apps)

## Introducción
IBM Mobile Foundation v8 está ahora disponible para su instalación y ejecución en Red Hat Openshift 3.11 o posterior. Red Hat OpenShift es una plataforma Kubernetes de empresa diseñada para hacer frente a las complejas realidades de la orquestación de contenedores en sistemas de producción.

A medida que las empresas continúan transformando sus negocios digitalmente, los entornos de desarrollo de aplicaciones PaaS, incluidas las arquitecturas de contenedores y los microservicios, permiten a las empresas centrarse más en la creación y mejora de funciones de aplicaciones que aportan más valor y centrarse menos en la gestión de los sistemas operativos subyacentes y la infraestructura. Red Hat OpenShift se ha diseñado para que los entornos Kubernetes resulten más fáciles, mediante la automatización, los parches y actualizaciones para cada nivel de la pila de contenedores del sistema operativo a través de los servicios de aplicaciones. 

Mobile Foundation ofrece una plataforma segura, líder del sector, en la que los desarrolladores pueden crear y desplegar rápidamente la próxima generación de aplicaciones digitales multicanal, incluidos dispositivos móviles, portables, conversación, web y PWA. Acelere el desarrollo y despliegue de potentes y atractivas aplicaciones digitales con: -
* Servicios de sistemas de fondo móviles en contenedores para OpenShift Container Platform que cubren toda la seguridad, la gestión del ciclo de vida de aplicaciones, la sincronización de datos fuera de línea y la integración de los sistemas de fondo.
* Un estudio de código bajo para crear aplicaciones digitales y SDK enriquecidos para las infraestructuras móviles ampliamente utilizadas tanto para desarrolladores nativos como híbridos.
* Una App Store privada para publicar sus aplicaciones para que las consuman los usuarios 
* El compromiso de los usuarios mediante un servicio de analíticas de conocimientos de las aplicaciones, comentarios mediante In-App, notificaciones Push, conmutación de funciones y pruebas A/B. 

## Arquitectura
{: #architecture}

En la imagen siguiente se muestra la arquitectura de alto nivel del despliegue de Mobile Foundation en el clúster de Red Hat OpenShift. 

![Arquitectura](architecture-mobile-services-openshift.png)

## Instalación de Mobile Foundation
{: #install-mf}

Para instalar Mobile Foundation en un clúster de OpenShift existente, siga las instrucciones [aquí](../mobilefoundation-on-openshift).

>**Nota:** Para instalar Mobile Foundation en Red Hat OpenShift Container Platform en IBM Cloud, siga las instrucciones [aquí](../deploy-mf-on-ibmcloud-ocp).

## Desarrollo de aplicaciones
{: #develop-apps}

Puede desarrollar de forma rápida y sencilla aplicaciones móviles que utilizan Mobile Foundation Lifecycle Management, la seguridad, el compromiso y las analíticas con la herramienta IBM Digital App Builder (DAB). DAB también proporciona aceleradores de aplicaciones móviles para una conexión segura con los microservicios de fondo.   

* Compile y pruebe su primera aplicación de Mobile Foundation Application en cuestión de minutos - [iniciación a IBM Digital App Builder](https://github.com/MobileFirst-Platform-Developer-Center/IBMDigitalAppBuilderGettingStarted)

## Despliegue de aplicaciones
{: #deploying-apps}
Cada aplicación de Mobile Foundation Application tiene dos desplegables: 
* Aplicaciones de cliente móvil que se pueden desplegar en Mobile Foundation App Center o en cualquier otra App Store pública 
* Configuraciones del servicio de Mobile Foundation para el ciclo de vida de aplicaciones, la seguridad, las notificaciones push y LiveUpdate. Estas configuraciones se pueden exportar desde el entorno de desarrollo de Mobile Foundation e importar a un entorno de transición o producción de Mobile Foundation.  

Consulte la sección siguiente para obtener más información acerca de cómo exportar e importar las configuraciones del servicio de Mobile Foundation entre despliegues:
[Modos diferentes de exportar e importar artefactos del servidor Mobile Foundation](http://mobilefirstplatform.ibmcloud.com/blog/2016/07/25/how-to-replicate-mobilefirst-environment/).
