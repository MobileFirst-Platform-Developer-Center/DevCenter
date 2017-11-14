---
layout: tutorial
title: Cargador de escenarios
breadcrumb_title: Cargador de escenarios
relevantTo: [ios,android,javascript]
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }

> **Nota:** El cargador de escenarios tiene un carácter *experimental* y, por lo tanto, no está soportado de forma completa.
Utilícelo de acuerdo a este criterio.

>
> * Algunos diagramas no se cumplimentan con datos.

El cargador de escenarios cumplimenta distintos informes y diagramas de {{ site.data.keys.mf_analytics_console_full }} con datos ficticios.
Los datos se almacenan en el almacén de datos Elasticsearch, separados de forma segura de los datos de producción o prueba existentes. 

Los datos cargados son de una naturaleza sintética y se inyectan directamente en el almacén de datos.
No son el resultado de datos analíticos reales que hayan creado el cliente o el servidor.
El propósito de los datos es habilitar la posibilidad de que el usuario obtenga una mejor visión de los distintos informes y gráficos tal como se visualizan en la interfaz de usuario.
Por lo tanto, los datos **no** se deberían utilizar a efectos de realizar pruebas.


#### Ir a
{: #jump-to }

* [Antes de empezar](#before-you-start)
* [Conexión al cargador de escenarios](#connecting-to-the-scenario-loader)
* [Configuración de la carga de datos](#configuring-the-data-loading)
* [Carga y supresión de datos](#loading-and-deleting-the-data)
* [Visualización de tablas y gráficos cumplimentados](#viewing-the-populated-charts-and-tables)
* [Inhabilitación de la modalidad de depuración](#disabling-the-debug-mode)

## Antes de empezar
{: #before-you-start }

El cargador de escenarios se ha empaquetado junto a {{ site.data.keys.mf_analytics_console }}.
Asegúrese de que {{ site.data.keys.mf_analytics_console_short }} se está ejecutando y es accesible antes de conectarse al cargador de escenarios.


## Conexión al cargador de escenarios
{: #connecting-to-the-scenario-loader }

1. Para habilitar el cargador de escenarios, establezca el argumento JVM `-DwlDevEnv=true` o la variable de entorno `ANALYTICS_DEBUG=true`.


2. Acceda al cargador de escenarios en su navegador utilizando el URL de consola: `http://<console-path>/scenarioLoader` donde `<console-path>` es el valor de la propiedad JNDI que se define en el archivo `mfp-server/usr/servers/mfp/server.xml` como, por ejemplo:


    `<jndiEntry jndiName="mfp/mfp.analytics.console.url" value='"http://localhost:9080/analytics/console"'/>`

3. Se visualiza la página del cargador de escenarios junto con la barra de navegación de {{ site.data.keys.mf_analytics_console_short }}.
El cargador de escenarios permanece inaccesible desde la barra de navegación.


## Configuración de la carga de datos
{: #configuring-the-data-loading}

1. En la sección **Configuración de pruebas** existen varios valores disponibles para controlar la naturaleza (separador **Básico**) y el volumen (separador **Planificación de capacidad**) de los datos generados.
Asegúrese de que el valor **Días de historial** se establece en al menos 30 días en para cargar suficientes datos.


    Toda la información disponible sobre estos valores se proporciona en la sección **Configuración de pruebas**.


2. Pulse el icono **Administración** <img  alt="icono de llave" style="margin:0;display:inline" src="wrench.png"/> y seleccione el separador **Valores**.
En la sección **Avanzado** asegúrese de que el valor **Arrendatario predeterminado** se establece en `dummy_data_for_demo_purposes_only`.


## Carga y supresión de datos
{: #loading-and-deleting-the-data }

Para cargar los datos, pulse el botón **Iniciar carga de escenarios** en la sección **Operaciones de escenario**.


Para suprimir los datos, pulse el botón **Suprimir ahora** en la sección **Configuración de prueba**.


**NB:** Lea la advertencia sobre la supresión y creación de datos en la sección **Operaciones de escenario**.


## Visualización de tablas y gráficos cumplimentados
{: #viewing-the-populated-charts-and-tables }

Una vez que los datos se han cargado, se cumplimentan la mayoría de los gráficos y las tablas disponibles en Analytics Console.


Desde la barra de navegación de {{ site.data.keys.mf_analytics_console_short }}, compruebe las distintas páginas y separadores para ver las tablas y gráficos cumplimentados.


## Inhabilitación de la modalidad de depuración
{: #disabling-the-debug-mode }

Para poder trabajar con datos reales después de haber trabajado en la modalidad de depuración y con datos sintéticos:


1. Suprima los datos pulsando el botón **Suprimir ahora** en la sección **Configuración de prueba**.

2. En la sección **Valores ** → **Avanzado** asegúrese de que el valor **Arrendatario predeterminado** se establece en `worklight`.

3. Para la variable que se estableció en true, establézcala en false (el argumento JVM `-DwlDevEnv=false` o la variable de entorno `ANALYTICS_DEBUG=false`).

4. Reinicie {{ site.data.keys.mf_analytics_server }}.

