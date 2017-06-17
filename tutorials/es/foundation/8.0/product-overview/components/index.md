---
layout: tutorial
title: Componentes del producto
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
{{ site.data.keys.product_full }} está formado por los siguientes componentes: {{ site.data.keys.mf_cli }}, {{ site.data.keys.mf_server }}, componentes de tiempo de ejecución del lado del cliente, {{ site.data.keys.mf_console }}, {{ site.data.keys.mf_app_center }} y {{ site.data.keys.mf_system_pattern }}.

La ilustración siguiente muestra los componentes de {{ site.data.keys.product }}:

![Arquitectura de la solución {{ site.data.keys.product }}](architecture.jpg)

### {{ site.data.keys.mf_cli }}
{: #mobilefirst-cli }
{{ site.data.keys.mf_cli_full }} sirve para desarrollar y gestionar aplicaciones, además de utilizar IBM {{ site.data.keys.mf_console }}.
Algunos aspectos del proceso de desarrollo de {{ site.data.keys.product_adj }} se pueden realizar desde la interfaz de línea de mandatos.


Los mandatos, que empiezan todos por **mfpdev**, dan soporte a los siguientes tipos de tareas:


* Registrar aplicaciones con {{ site.data.keys.mf_server }}
* Configurar aplicaciones
* Crear, construir y desplegar adaptadores
* Obtener vistas previas y actualizar aplicaciones Cordova
* Para obtener más información, consulte la guía de aprendizaje [Utilización de la interfaz de línea de mandatos para gestionar artefactos de {{ site.data.keys.product_adj }}](../../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts/).


### {{ site.data.keys.mf_server }}
{: #mobilefirst-server }
{{ site.data.keys.mf_server }} proporciona conectividad de fondo, gestión de aplicaciones, soporte de notificaciones push, funcionalidades de analíticas y supervisión de aplicaciones {{ site.data.keys.product_adj }}.
No es un servidor de aplicaciones en el sentido de Java Platform Enterprise Edition (Java EE).
Actúa como un contenedor para los paquetes de aplicación de {{ site.data.keys.product }}, y es de hecho un conjunto de aplicaciones web, opcionalmente empaquetado como un archivo EAR (archivador empresarial) que se ejecuta encima de los servidores de aplicaciones tradicionales.


{{ site.data.keys.mf_server }} se integra en el entorno de la empresa y utiliza los recursos y la infraestructura existentes.
Esta integración está basada en adaptadores, que son los componentes de software de servidor responsables de la canalización de sistemas de empresa de fondo y de los servicios basados en la nube del dispositivo del usuario.
Puede utilizar adaptadores para recuperar y actualizar datos desde orígenes de información y permitir a usuarios autorizados a realizar transacciones y a iniciar otros servicios y aplicaciones. 

[Aprenda más sobre {{ site.data.keys.mf_server }}](server).

### Componentes de tiempo de ejecución del cliente
{: #client-side-runtime-components }
{{ site.data.keys.product }} proporciona un código de tiempo de ejecución del lado del cliente que incluye funcionalidad de servidor dentro del entorno destino de las aplicaciones desplegadas.
Estas API de tiempo de ejecución de cliente son bibliotecas que están integradas en el código de la aplicación almacenado localmente.
Puede utilizarlas para añadir características de {{ site.data.keys.product_adj }} en sus aplicaciones de cliente.
Las API y las bibliotecas se pueden instalar con {{ site.data.keys.mf_dev_kit_full }} o puede descargarlas desde los repositorios para su plataforma de desarrollo.


### {{ site.data.keys.mf_console }}
{: #mobilefirst-operations-console }
{{ site.data.keys.mf_console }} se utiliza para controlar y gestionar las aplicaciones móviles.
El {{ site.data.keys.mf_console }} también es un punto de entrada para aprender sobre el desarrollo de {{ site.data.keys.product }}.
Desde la consola, es posible descargar ejemplos de códigos, herramientas y SDK.


Puede utilizar la {{ site.data.keys.mf_console }} para las tareas siguientes:

* Supervisar y configurar todas las aplicaciones desplegadas, adaptadores, y hacer push de reglas de notificación desde un consola web centralizada.

* Inhabilitar remotamente la capacidad de conectarse al {{ site.data.keys.mf_server }} mediante el uso de reglas preconfiguradas de versión de aplicación y tipo de dispositivo. 
* Personalizar mensajes que se envían a los usuarios cuando inician la aplicación.
* Recopilar estadísticas de usuario de todas las aplicaciones en ejecución. 
* Generar informes preconfigurados, incorporados acerca del uso y adopción del usuario (número y frecuencia de usuarios que trabajan con el servidor a través de las aplicaciones).
* Configurar reglas de recopilación de datos para sucesos específicos de aplicación. 
* [Aprenda más sobre {{ site.data.keys.mf_console }}](console).

### {{ site.data.keys.mf_analytics }}
{: #mobilefirst-analytics }
{{ site.data.keys.product }} incluye una característica de {{ site.data.keys.mf_analytics_short }} operativa escalable a la que se puede acceder desde {{ site.data.keys.mf_console }}.
La característica {{ site.data.keys.mf_analytics_short }} permite que las empresas busquen en registros y sucesos recopilados por los dispositivos, las aplicaciones, los servidores para patrones, los problemas y las estadísticas de utilización de la plataforma.


Los datos para {{ site.data.keys.mf_analytics }} incluyen los siguientes orígenes:


* Sucesos de cuelgue de una aplicación en dispositivos iOS y Android (sucesos de cuelgue para errores JavaScript y de código nativo).

* Interacciones de actividad de aplicación a servidor (cualquier actividad soportada por el protocolo cliente/servidor de {{ site.data.keys.mf_cli }}, incluidas las notificaciones push).

* Registros del lado del servidor que se capturan en archivos de registro de {{ site.data.keys.product_adj }} tradicionales.

[Aprenda más sobre {{ site.data.keys.mf_analytics }}](../../analytics).

### Application Center
{: #application-center }
Con Application Center, puede compartir aplicaciones móviles que están en desarrollo dentro de su organización en un único repositorio de aplicaciones móviles.
Los miembros del equipo de desarrollo pueden utilizar Application Center para compartir aplicaciones con otros miembros del equipo.
Este proceso facilita la colaboración entre todas las personas que están implicadas en el desarrollo de una aplicación. 

Su empresa puede utilizar Application Center de la siguiente manera: 

1. El equipo de desarrollo crea una versión de una aplicación. 
2. El equipo de desarrollo carga la aplicación en Application Center, especifica una descripción y solicita al resto del equipo de la pruebe y dé su opinión.

3. Cuando la nueva versión de la aplicación esté disponible, un probador ejecutará el programa de instalación de la aplicación en Application Center, que es el cliente móvil.
A continuación, el probador ubicará la nueva versión de la aplicación, la instalará en su dispositivo móvil y la probará. 
4. Una vez finalizada la prueba, el probador evaluará la aplicación y enviará comentarios, que el desarrollador podrá ver desde la consola de Application Center.


Application Center está dirigido a un uso privado dentro de una empresa. Puede destinar algunas aplicaciones móviles a un grupo específico de usuarios.
Puede utilizar Application Center como una tienda de aplicaciones de la empresa.


### {{ site.data.keys.mf_system_pattern }}
{: #mobilefirst-system-pattern }
Con {{ site.data.keys.mf_system_pattern_full }}, puede desplegar {{ site.data.keys.mf_server }} en IBM PureApplication System o IBM PureApplication Service en SoftLayer.
Con estos patrones, los administradores y empresas pueden responder rápidamente a los cambios en el entorno de empresa aprovechándose de las tecnologías en nube de las instalaciones.
Este enfoque simplifica el proceso de desarrollo y mejora la eficiencia operativa para hacer frente al incremento de la demanda móvil.
La demanda acelera la iteración de soluciones que excede los ciclos de demanda tradicional.
La utilización del patrón de {{ site.data.keys.mf_server }} también proporciona acceso a los procedimientos recomendados y a la experiencia ya existente, como con las políticas de escalado incorporadas.


#### PureApplication System
{: #pureapplication-system }
IBM PureApplication System es un sistema integrado y fácil de escalar que se basa en IBM X-Architecture, proporcionando un modelo de informática centrado en la aplicación en un entorno de nube.


Un sistema centrado en la aplicación es una manera eficiente de gestionar aplicaciones complejas y las tareas y procesos que se invocan mediante la aplicación.
Todo el sistema implementa un entorno informático virtual diverso en el que diferentes configuraciones de recursos se personalizan automáticamente a distintas cargas de trabajo de aplicación.
Las funciones de gestión de aplicaciones de la plataforma IBM PureApplication System realizan un despliegue de middleware y de otros componentes de aplicaciones de forma rápida, fácil y repetible.  

IBM PureApplication System proporciona cargas de trabajo virtualizadas y una infraestructura escalable que se proporciona en un sistema integrado. 

#### Patrones de sistema virtual
{: #virtual-system-patterns }
Los patrones de sistema virtual son una representación lógica de una topología recurrente para un conjunto de requisitos de despliegue.


Los patrones de sistema virtual habilitan despliegues eficaces y repetibles de sistemas que incluyen una o varias instancias de la máquina virtual, y las aplicaciones que se ejecutan en ellas.
Puede automatizar completamente el despliegue y eliminar la necesidad de realizar varias tareas manuales que llevan mucho tiempo.
Este despliegue elimina los problemas que provocan procesos de configuración manuales y propensos a errores, especialmente en topologías de producción compleja, como las granjas de servidores y acelera el despliegue de soluciones.

