---
layout: tutorial
title: Retención de datos y depuración
breadcrumb_title: Data Retention and Purging
relevantTo: [ios,android,javascript]
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }

Los datos de {{ site.data.keys.mf_analytics }} se almacenan en el servidor y están disponibles para la creación de informes hasta que se depuren los datos. El usuario controla los datos de los tipos de sucesos que se retienen o depuran. Los datos se pueden depurar de forma periódica o de forma manual.

## Configuración de la retención de datos desde Analytics Console
{: #configuring-data-retention-from-the-analytics-console }

1. Desde {{ site.data.keys.mf_analytics_console }}, pulse el icono **Administración** (<img  alt="icono de una llave" style="margin:0;display:inline" src="wrench.png"/>).
2. Elija el separador **Valores**.

   ![Configuración de la retención de datos](analytics_console_data_retention.png)

   * Seleccione el botón de selección **Descartar** para suprimir los datos de forma inmediata.
   * En la columna **Conservar datos para**, elija el número de días que desea retener los datos, o deje el valor predeterminado **Conservar datos indefinidamente**.

3. Pulse **Guardar cambios**.

La nueva política de retención se activa.
