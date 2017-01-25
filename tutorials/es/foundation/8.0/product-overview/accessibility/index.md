---
layout: tutorial
title: Accessibility features for IBM MobileFirst Foundation
breadcrumb_title: Accessibility features
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
<br/>
Las características de accesibilidad ayudan a los usuarios con discapacidades como, por ejemplo, las relacionadas la movilidad o la visión, a utilizar de forma satisfactoria el contenido de la tecnología de información.
### Características de accesibilidad
{: #accessibility-features }
{{site.data.keys.product_full }} incluye las siguientes características de accesibilidad importantes: 

* Funcionamiento sólo con el teclado
* Operaciones que dan soporte al uso de un lector de pantalla

{{site.data.keys.product }} utiliza el último estándar W3C, [WAI-ARIA 1.0](http://www.w3.org/TR/wai-aria/), para garantizar la conformidad con [US Section 508](http://www.access-board.gov/guidelines-and-standards/communications-and-it/about-the-section-508-standards/section-508-standards) y [Web Content Accessibility Guidelines (WCAG) 2.0](http://www.w3.org/TR/WCAG20/).
Para aprovechar las características de accesibilidad, utilice el release más reciente de su lector de pantalla en combinación con el navegador web más reciente que admita este producto.

### Navegación mediante el teclado
{: #keyboard-navigation }
Este producto utiliza teclas de navegación estándares. 

### Información sobre la interfaz

{: #interface-informaton }
Las interfaces de usuario de {{site.data.keys.product }} no tienen contenido que parpadee 2 - 55 veces por segundo.


Puede utilizar un lector de pantalla con un sintetizador de voz digital para escuchar lo que se visualiza en la pantalla.
Consulte la documentación de su tecnología de ayuda para obtener más detalles acerca de cómo utilizarlo con este producto y su documentación.

### {{site.data.keys.mf_cli }}
{: #mobilefirst-cli }
De forma predeterminada, {{site.data.keys.mf_cli }} visualiza los mensajes de estado utilizando distintos colores para indicar su terminación correcta, si se trata de avisos o de errores.
Utilice la opción `--no-color` en cualquier mandato de
{{site.data.keys.mf_cli }} para suprimir la utilización de estos colores con dicho mandato.
Cuando se especifica `--no-color`, la salida se visualiza en los colores de visualización del texto que se hayan establecido para su consola del sistema operativo.


### Interfaz web  
{: #web-interface }
Las interfaces de usuario web de {{site.data.keys.product }} se basan en hojas de estilo en cascada para representar el contenido correctamente y proporcionar una experiencia adecuada al usuario.
La aplicación proporciona una forma equivalente para que los usuarios con dificultades de visión utilicen valores de visualización del sistema de usuario, incluidas modalidades de alto contraste.
Puede controlar el tamaño de font mediante los valores del dispositivo o del navegador web.


Puede navegar por entornos de {{site.data.keys.product_adj }} diferentes y por la documentación con atajos de teclado.
Eclipse proporciona características de accesibilidad para sus entornos de desarrollo.
Los navegadores de internet también proporcionan características de accesibilidad para aplicaciones web como, por ejemplo, {{site.data.keys.mf_console }}, the {{site.data.keys.mf_analytics_console }}, la consola {{site.data.keys.product }} Application Center y el cliente móvil de {{site.data.keys.product }} Application Center.


La interfaz de usuario de web de {{site.data.keys.product }} incluye puntos de referencia de navegación WAI-ARIA, que puede utilizar para navegar rápidamente a áreas funcionales en la aplicación.


### Instalación y configuración 
{: #installation-and-configuration }
Hay dos formas de instalar y configurar {{site.data.keys.product }}: mediante la interfaz gráfica de usuario (GUI) o mediante la línea de mandatos.


A pesar de que la interfaz gráfica de usuario (IBM Installation Manager en modalidad de asistente o Server
Configuration Tool) no proporciona información sobre los objetos de la interfaz de usuario, hay disponible una función equivalente con la interfaz de línea de mandatos.
Todas las funciones en la interfaz gráfica de usuario se soportan a través de la línea de mandatos, algunas características de configuración e instalación específicas únicamente están disponibles con la línea de mandatos.
Obtenga más información sobre las características de accesibilidad de [IBM Installation Manager](http://www.ibm.com/support/knowledgecenter/SSDV2W/im_family_welcome.html?lang=en&view=kc) en el IBM Knowledge Center.


Los temas siguientes proporcionan la información sobre cómo se puede llevar a cabo la instalación y la configuración sin la interfaz gráfica de usuario:


* Trabajar con archivos de respuesta de ejemplo para IBM Installation Manager
Este método permite la configuración e instalación silenciosa de {{site.data.keys.mf_server }} y Application Center. Tiene la posibilidad de no instalar Application Center utilizando el archivo de respuesta denominado install-no-appcenter.xml.
Se puede entonces utilizar la tarea Ant para instalarlo más tarde.
Consulte Instalación de Application Center con tareas Ant.
En este caso, la instalación y la actualización de Application Center se puede hacer de manera independiente.

* Instalación con tareas Ant
* Instalación de Application Center con tareas Ant

### Software de proveedor
{: #vendor-software }
{{site.data.keys.product }} incluye determinado software de proveedor que no está cubierto por el acuerdo de la licencia de IBM.
IBM no es responsable de las características de accesibilidad de estos productos.
Póngase en contacto con el proveedor para obtener información sobre la accesibilidad de estos productos.

### Información de accesibilidad relacionada
{: #related-accessibility-information }
Además de los sitios web de soporte y atención al cliente de IBM estándar, IBM ha establecido un servicio de teléfono de texto (TTY) especial para personas sordas o con deficiencias auditivas, para que puedan acceder a los servicios de soporte y ventas:


Servicio TTY
  
800-IBM-3383 (800-426-3383)  
(en EE.UU. y Canadá)

### IBM y la accesibilidad
{: #ibm-and-accessibility }
Para obtener más información sobre el compromiso de IBM con la accesibilidad, consulte [Accesibilidad de IBM](http://www.ibm.com/able).


