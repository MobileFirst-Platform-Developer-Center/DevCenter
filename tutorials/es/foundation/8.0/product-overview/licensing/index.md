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

### Licencias de unidades de valor de procesador (PVU)
{: #processor-value-unit-pvu-licensing }
Las licencias de unidades de valor de procesador (PVU) están disponibles al comprar IBM {{ site.data.keys.product }} Extension (consulte [License Information documents](http://www.ibm.com/software/sla/sladb.nsf/lilookup/C154C7B1C8C840F38525800A0037B46E?OpenDocument)), pero únicamente después de haber comprado IBM WebSphere Application Server Network Deployment, IBM API Connect Professional o IBM API Connect Enterprise.

La estructura de precios de las licencias PVU depende tanto del tipo como del número de procesadores disponibles para los productos instalados. Las autorizaciones pueden ser de capacidad completa o de subcapacidad. En la estructura de gestión de licencias de unidades de valor de procesador, el software se licencia en base al número de unidades de valor asignadas a cada núcleo de procesador.

Por ejemplo, al tipo de procesador A se le asignan 80 unidades de valor por núcleo y al tipo de procesador B se le asignan 100 unidades de valor por núcleo. Si su licencia corresponde a un producto que se ejecuta en dos procesadores de tipo A, debe adquirir una titularidad para 160 unidades de valor por núcleo. Si el producto se ha de ejecutar en dos procesadores de tipo B, la titularidad que se necesita es de 200 unidades de valor por núcleo.

> [Consulte aquí para obtener más información](https://www.ibm.com/support/knowledgecenter/SS8JFY_9.2.0/com.ibm.lmt.doc/Inventory/overview/c_processor_value_unit_licenses.html) sobre la gestión de licencias PVU.

### Gestión de licencias de señal
{: #token-licensing }
En un entorno de señales, cada producto consume una valor de señal predefinido por licencia, comparado con un entorno flotante tradicional donde se consume una cantidad predefinida por licencia. La clave de licencia tiene una agrupación de señales a partir de la que el servidor de licencias calcula las señales que se extraen e incorporan. Las señales se consumen o liberan cuando un producto incorpora o extrae licencias del servidor de licencias.

El contrato de gestión de licencias define si es posible utilizar la gestión de licencias de señal, el número de señales disponibles y las características que se validan mediante señales. Consulte la validación de licencias de señal.

Si ha comprado licencias basadas en señal, instale una versión de {{ site.data.keys.mf_server }} que dé soporte a las licencias de señal y configure el servidor de aplicaciones para que se comunique con el servidor de señales remoto. Consulte Instalación y configuración para la gestión de licencias de señal.

Con la gestión de licencias de señal, se puede especificar el tipo de aplicación de licencia en el descriptor de cada una de sus aplicaciones antes de desplegarlas. El tipo de aplicación de licencia puede ser APPLICATION o ADDITIONAL_BRAND_DEPLOYMENT. Para la realización de pruebas, puede establecer el valor del tipo de aplicación de licencia en NON_PRODUCTION. Para obtener más información, consulte Establecimiento de la información de licencia de la aplicación.

La herramienta Rational License Key Server Administration and Reporting que se entrega con Rational License Key Server 8.1.4.9 permite administrar y generar informes para las licencias que {{ site.data.keys.product }} consume. Puede identificar las partes relevantes del informe con los siguientes nombres de visualización: **MobileFirst Platform Foundation Application** o **MobileFirst Platform Additional Brand Deployment**. Estos nombres hacen referencia al tipo de aplicación de licencia para el que se consumen las señales. Para obtener más información, consulte [Rational License Key Server Administration](https://www.ibm.com/support/knowledgecenter/SSSTWP_8.1.4/com.ibm.rational.license.doc/topics/c_rlks_admin_tool_overview.html) y [Reporting Tool overview and Rational License Key Server Fix Pack 9 (8.1.4.9)](http://www.ibm.com/support/docview.wss?uid=swg24040300).

Para obtener información sobre la planificación para utilizar la gestión de licencias de señal con {{ site.data.keys.mf_server }}, consulte Planificación de la utilización de la gestión de licencias de señal.

Si desea obtener claves de licencia para {{ site.data.keys.product }}, necesitará acceder a IBM Rational License Key Center. Para obtener más información sobre cómo generar y gestionar sus claves de licencia, consulte [IBM Support - Licensing](http://www.ibm.com/software/rational/support/licensing/).
