---
layout: tutorial
title: Licencias en MobileFirst Server
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
IBM {{ site.data.keys.mf_server }} da soporte a varios métodos de gestión de licencias en base a lo que ha comprado.

Si ha comprado licencias perpetuas, puede consumir lo que ha comprado y verificar su utilización y cumplimiento a través de la **página de seguimiento de licencias** en {{ site.data.keys.mf_console }} y a través del [informe de seguimiento de licencias](../../administering-apps/license-tracking/#license-tracking-report). Si ha comprado licencias de señal, configure {{ site.data.keys.mf_server }} para que se comunique con un servidor de licencias de señal remoto.

### Licencias de dispositivo dirigible o aplicación
{: #application-or-addressable-device-licenses }
Si ha comprado licencias de dispositivo dirigible o aplicación, puede consumir lo que ha comprado y verificar su utilización y cumplimiento a través de la página de seguimiento de licencias en {{ site.data.keys.mf_console }} y a través del informe de seguimiento de licencias.

### Virtual Processor Cores (Licencia de VPC) 
{: #vpc-licensing}

Mobile Foundation también está disponible con una licencia basada en capacidad denominada VPC (Virtual Processor Cores). VPC es una unidad de medida que se utiliza para determinar el coste de la licencia para Mobile Foundation y está basada en el número de núcleos disponibles. Actualmente, esta métrica solo está disponible para Cloud Pak for Applications.

Las características de esta métrica son las siguientes. 

* Los clientes pueden ejecutar cualquier número de aplicaciones y dispositivos. Por lo tanto, este formato de licencia puede ofrecer más ventajas en comparación con la licencia de aplicación en los casos en los que los clientes tienen muchas aplicaciones en su despliegue.

* Está alineado con los otros productos de la cartera de productos y proporciona flexibilidad a los clientes en los despliegues de nube híbrida.


### Gestión de licencias de señal
{: #token-licensing }
En un entorno de señales, cada producto consume una valor de señal predefinido por licencia, comparado con un entorno flotante tradicional donde se consume una cantidad predefinida por licencia. La clave de licencia tiene una agrupación de señales a partir de la que el servidor de licencias calcula las señales que se extraen e incorporan. Las señales se consumen o liberan cuando un producto incorpora o extrae licencias del servidor de licencias.

El contrato de gestión de licencias define si es posible utilizar la gestión de licencias de señal, el número de señales disponibles y las características que se validan mediante señales. Consulte la validación de licencias de señal.

Si ha comprado licencias basadas en señal, instale una versión de {{ site.data.keys.mf_server }} que dé soporte a las licencias de señal y configure el servidor de aplicaciones para que se comunique con el servidor de señales remoto. Consulte Instalación y configuración para la gestión de licencias de señal.

Con la gestión de licencias de señal, se puede especificar el tipo de aplicación de licencia en el descriptor de cada una de sus aplicaciones antes de desplegarlas. El tipo de aplicación de licencia puede ser APPLICATION o ADDITIONAL_BRAND_DEPLOYMENT. Para la realización de pruebas, puede establecer el valor del tipo de aplicación de licencia en NON_PRODUCTION. Para obtener más información, consulte Establecimiento de la información de licencia de la aplicación.

La herramienta Rational License Key Server Administration and Reporting que se entrega con Rational License Key Server 8.1.4.9 permite administrar y generar informes para las licencias que {{ site.data.keys.product }} consume. Puede identificar las partes relevantes del informe con los siguientes nombres de visualización: **MobileFirst Platform Foundation Application** o **MobileFirst Platform Additional Brand Deployment**. Estos nombres hacen referencia al tipo de aplicación de licencia para el que se consumen las señales. Para obtener más información, consulte [Rational License Key Server Administration](https://www.ibm.com/support/knowledgecenter/SSSTWP_8.1.4/com.ibm.rational.license.doc/topics/c_rlks_admin_tool_overview.html) y [Reporting Tool overview and Rational License Key Server Fix Pack 9 (8.1.4.9)](http://www.ibm.com/support/docview.wss?uid=swg24040300).

Para obtener información sobre la planificación para utilizar la gestión de licencias de señal con {{ site.data.keys.mf_server }}, consulte Planificación de la utilización de la gestión de licencias de señal.

Si desea obtener claves de licencia para {{ site.data.keys.product }}, necesitará acceder a IBM Rational License Key Center. Para obtener más información sobre cómo generar y gestionar sus claves de licencia, consulte [IBM Support - Licensing](http://www.ibm.com/software/rational/support/licensing/).
