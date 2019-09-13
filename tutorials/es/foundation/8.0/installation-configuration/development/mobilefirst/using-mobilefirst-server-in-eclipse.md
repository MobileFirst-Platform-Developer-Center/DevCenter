---
layout: tutorial
title: Uso de MobileFirst Server para Eclipse
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
{{ site.data.keys.mf_server }} puede integrarse en Eclipse IDE. Esto podría ayudar a crear un entorno de desarrollo integrado.

* También existe la posibilidad de exponer la funcionalidad de la interfaz de línea de mandatos (CLI) en Eclipse. Consulte [Utilización de {{ site.data.keys.mf_server }} en Eclipse](../../../../application-development/using-mobilefirst-cli-in-eclipse) para obtener más información.
* Además, es posible desarrollar adaptadores en Eclipse. Consulte la guía de aprendizaje [Desarrollo de adaptadores en Eclipse](../../../../adapters/developing-adapters) para obtener más información.

### Adición del servidor a Eclipse
{: #adding-the-server-to-eclipse }
1. Desde la vista de **Servidores** en Eclipse, seleccione **Nuevo → Servidor**.
2. Si no existe una opción de carpeta de IBM, pulse "Descargar adaptadores de servidor adicionales".
3. Seleccione **Herramientas de WebSphere Application Server Liberty** y siga las instrucciones en la pantalla.
4. Desde la vista de **Servidores** en Eclipse, seleccione **Nuevo → Servidor**.
5. Seleccione **IBM → WebSphere Application Server Liberty**.
6. Proporcione un **nombre** y un **nombre de host** de servidor y pulse **Siguiente**.
7. Proporcione la vía de acceso al directorio raíz del servidor y seleccione la versión de JRE que desee utilizar. Al utilizar {{ site.data.keys.mf_dev_kit }}, el directorio raíz es la carpeta **[directorio instalación]/mfp-server**.
8. Pulse **Siguiente** y pulse **Finalizar**.

Ahora podrá iniciar y detener {{ site.data.keys.mf_server }} desde la vista "Servidores" en el IDE de Eclipse.
