---
layout: tutorial
title: Configuración del entorno de desarrollo de MobileFirst
breadcrumb_title: MobileFirst
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
{{ site.data.keys.product_full }} está formado por varios componentes: los SDK de cliente, arquetipos de adaptador, comprobaciones de seguridad y herramientas de autenticación.


Estos componentes están disponibles en repositorios en línea y se pueden instalar mediante gestores de paquetes.
Estos repositorios en línea proporcionan el release más reciente de cada componente.
El mismo componente también está disponible para ser descargado desde {{ site.data.keys.mf_dev_kit }} para un uso local.
Tenga en cuenta que la versión disponible de {{ site.data.keys.mf_dev_kit_short }} corresponde a la versión que estaba disponible cuando se publicó la compilación específica de {{ site.data.keys.mf_dev_kit_short }}, y que la descarga de una nueva compilación de {{ site.data.keys.mf_dev_kit_short }} será necesaria para poder utilizar la más reciente.
 

Continúe leyendo para obtener más información sobre los componentes de {{ site.data.keys.product }}.

> Para evaluar {{ site.data.keys.product }} solo es necesario desplegar una instancia de {{ site.data.keys.mf_server }} en Bluemix mediante el servicio Mobile Foundation Bluemix.
Consulte la guía de aprendizaje [Utilización de Mobile Foundation](../../../bluemix/using-mobile-foundation/) para obtener las instrucciones necesarias.
También puede elegir instalar {{ site.data.keys.mf_dev_kit_short }} de forma local.
#### Ir a: 
{: #jump-to }

* [Guía de instalación](#installation-guide)
* [{{ site.data.keys.mf_dev_kit }}](#mobilefirst-developer-kit)
* [Componentes de {{ site.data.keys.product }}](#mobilefirst-foundation-components)
* [Desarrollo de aplicaciones y adaptadores](#applications-and-adapters-development)
* [Guías de aprendizaje con las que continuar](#tutorials-to-follow-next)

## Guía de instalación
{: #installation-guide }
[Lea la guía de instalación](installation-guide) para configurar MobileFirst Foundation de una forma rápida en su estación de trabajo.


## {{ site.data.keys.mf_dev_kit }}
{: #mobilefirst-developer-kit }
{{ site.data.keys.mf_dev_kit_short }} proporciona un entorno listo para el desarrollo con una mínima configuración.
El kit está formado por los siguientes componentes: {{ site.data.keys.mf_server }} y {{ site.data.keys.mf_console }}, MobileFirst Developer Command-line Interface (CLI) y opcionalmente proporciona herramientas de adaptadores y SDK de cliente.


> **Nota:**
Si necesita configurar su entorno de desarrollo en un sistema que no tiene acceso a internet, puede instalar los componentes fuera de línea.
Consulte [Configuración de un entorno de desarrollo de IBM MobileFirst fuera de línea]({{site.baseurl}}/blog/2016/03/31/howto-set-up-an-offline-ibm-mobilefirst-8-0-development-environment).
### Instalador de {{ site.data.keys.mf_dev_kit_short }} 
{: #developer-kit-installer }
El instalador empaqueta componentes para una instalación local donde no haya conectividad a Internet.
  
Los componentes están disponibles a través del Centro de descargas de {{ site.data.keys.mf_console }}.

> Para descargar el instalador, visite la página de [descargas]({{site.baseurl}}/downloads/).


## Componentes de {{ site.data.keys.product }} 
{: #mobilefirst-foundation-components }

### {{ site.data.keys.mf_server }}
{: #mobilefirst-server }
Como parte de {{ site.data.keys.mf_dev_kit_short }}, se proporciona a {{ site.data.keys.mf_server }} desplegado de forma previa en un servidor de aplicaciones de perfil WebSphere Liberty.
El servidor está preconfigurado con un tiempo de ejecución "mfp" y utiliza una base de datos Apache Derby basada en el sistema de archivos.


En el directorio raíz de {{ site.data.keys.mf_dev_kit_short }}, los scripts siguientes están disponibles para ejecutarse desde una línea de mandatos:


* `run.[sh|cmd]`: Ejecuta {{ site.data.keys.mf_server }} con mensajes de Liberty Server 
    * Añada el distintivo `-bg` para ejecutar el proceso en un segundo plano

* `stop.[sh|cmd]`: Detiene la instancia de {{ site.data.keys.mf_server }} actual

* `console.[sh|cmd]`: Abre {{ site.data.keys.mf_console }}

Las extensiones de archivo `.sh` son para Mac y Linux, y las extensiones de archivo `.cmd` son para Windows.

### {{ site.data.keys.mf_console }}
{: #mobilefirst-operations-console }
{{ site.data.keys.mf_console }} expone las siguientes funcionalidades.
  
Un desarrollador puede:

- Registrar y desplegar aplicaciones y adaptadores
- Opcionalmente descargar plantillas de código para empezar con adaptadores y aplicaciones de Cordova/nativas 
- Configurar las propiedades de seguridad y autenticación de una aplicación 
- Gestionar aplicaciones:

    - Autenticidad de aplicaciones
    - Direct Update
    - Notificar/inhabilitar de forma remota
- Enviar notificaciones push a dispositivos iOS y Android
- Generar scripts de DevOps para flujos de trabajo de integración continua y ciclos de desarrollo más rápidos

> Obtenga más información sobre {{ site.data.keys.mf_console }} en la guía de aprendizaje [Utilización de la consola de operaciones de MobileFirst](../../../product-overview/components/console/).
### Interfaz de línea de mandatos (CLI) de {{ site.data.keys.product }} 
{: #mobilefirst-foundation-command-line-interface }
Utilice {{ site.data.keys.mf_cli }} para desarrollar y gestionar aplicaciones, además de utilizar {{ site.data.keys.mf_console }}.
Los mandatos de la interfaz (CLI) se prefijan con `mfpdev` y dan soporte a los siguientes tipos de tareas:


* Registro de aplicaciones con {{ site.data.keys.mf_server }}
* Configuración de sus aplicaciones
* Creación, compilación y despliegue de adaptadores
* Obtención de vistas previas y de actualización de aplicaciones Cordova

> Para descargar e instalar el {{ site.data.keys.mf_cli }}, visite la página de [descargas]({{site.baseurl}}/downloads/).
  
> Obtenga más información sobre los distintos mandatos de la interfaz de línea de mandatos (CLI) en la guía de aprendizaje [Utilización de la interfaz de línea de mandatos (CLI) para gestionar artefactos de MobileFirst](../../../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts/).


### Herramientas de adaptador y SDK de cliente de {{ site.data.keys.product }} 
{: #mobilefirst-foundation-client-sdks-and-adapter-tooling }
{{ site.data.keys.product }} proporciona SDK de cliente para aplicaciones Cordova así como para plataformas nativas (iOS, Android y Windows 8.1 Universal y Windows 10 UWP).
Las herramientas para los adaptadores y el desarrollo de comprobaciones de seguridad también están disponibles.


* Para utilizar los SDK de cliente de {{ site.data.keys.product_adj }}, visite la categoría de guías de aprendizaje de [Adición de SDK de {{ site.data.keys.product }}SDK](../../../application-development/sdk/).
  
* Para desarrollar adaptadores, visite la categoría de guías de aprendizaje de [Adaptadores](../../../adapters/).
  
* Para desarrollar comprobaciones de seguridad, visite la categoría de guías de aprendizaje de [Autenticación y seguridad](../../../authentication-and-security/).
  

## Desarrollo de adaptadores y aplicaciones
{: #applications-and-adapters-development }

### Aplicaciones
{: #applications }
* Las aplicaciones Cordova precisan NodeJS y Cordova CLI.
Para obtener más información, consulte [Configuración del entorno de desarrollo de Cordova](../cordova).

    Puede utilizar su editor de código preferido como, por ejemplo, Atom.io, Visual Studio Code, Eclipse, IntelliJ entre otros, para implementar aplicaciones y adaptadores.
  
    
* Las aplicaciones nativas precisan de Xcode, Android Studio o Visual Studio.
Para obtener más información, consulte [Configuración del entorno de desarrollo de iOS/Android/Windows](../).

### Adaptadores
{: #adapters }
Los adaptadores precisan que Apache Maven esté instalado.
Consulte la categoría [Adaptadores](../../../adapters/) para obtener más información sobre los adaptadores y cómo crearlos, desarrollarlos y desplegarlos.


## Guías de aprendizaje con las que continuar
{: #tutorials-to-follow-next }
Visite la página [Todas las guías de aprendizaje](../../../all-tutorials/) y seleccione una categoría de guías de aprendizaje para seguir a continuación.


