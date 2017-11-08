---
layout: tutorial
title: Creación de gráficos personalizados
breadcrumb_title: Gráficos personalizados
relevantTo: [ios,android,javascript]
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }

Los gráficos personalizados permiten visualizar los datos recopilados en el almacén de datos de analíticas como gráficos que no están disponibles de forma predeterminada en {{ site.data.keys.mf_analytics_console }}.
Esta característica de visualización es una manera efectiva de analizar los datos más significativos de la empresa.


Tipos de gráficos personalizados disponibles: **Sesiones de app**, **Transacciones de red**, **Notificaciones push**, **Registros de cliente**, **Registros de servidor** y **Datos personalizados**.

#### Ir a
{: #jump-to }

* [Creación de un diagrama personalizado](#creating-a-custom-chart)
* [Tipos de gráficos](#chart-types)
* [Creación de gráficos personalizados para registros de cliente](#creating-custom-charts-for-client-logs)
* [Exportación de datos de gráficos personalizados](#exporting-custom-chart-data)
* [Exportación e importación de definiciones de gráficos personalizados](#exporting-and-importing-custom-chart-definitions)

## Creación de un gráfico personalizado
{: #creating-a-custom-chart }

En {{ site.data.keys.mf_analytics_console }}, desde el **Panel de control**, el asistente de creación de gráficos personalizado le lleva por cuatro pasos básicos:


### 1. Valores generales
{: #1-general-settings }

Pulse el botón **Crear gráfico** en el separador **Gráficos personalizados**.
  

En el separador **Valores generales**, seleccione el Título de gráfico, el Tipo de suceso y el Tipo de gráfico.
  
Después de seleccionar el Tipo de suceso y el Tipo de gráfico, aparece el separador **Definición de gráfico**.


### 2. Separador Definición de gráfico
{: #2-the-chart-definition-tab }

Utilice el separador **Definición de gráfico** para definir el gráfico especificado para el tipo de gráfico que se ha seleccionado anteriormente.
Después de definir el gráfico, puede establecer filtros y propiedades del gráfico. 

### 3. Separador Filtros de gráfico
{: #3-the-chart-filters-tab }

El separador **Filtros de gráfico** permite realizar ajustes más precisos al gráfico personalizado.
Se pueden definir varios filtros para los gráficos.
  
Por ejemplo, si está interesado en ver el promedio de la duración de la sesión de una determinada aplicación, puede especificar las opciones siguientes:

1. Seleccione **Nombre de aplicación** como **Propiedad**.
2. Seleccione **Igual a** como **Operador**.
3. Seleccione el nombre de su aplicación como **Valor**.
4. Pulse **Añadir filtro**.

El filtro del nombre de la aplicación se añade a la tabla de filtros de su gráfico.


### 4. Propiedades del gráfico
{: #4-chart-properties }

Las propiedades del gráfico están disponibles en los tipos de gráfico **Tabla**, **Gráfico de barras** y **Gráfico de líneas**.
El objetivo de las propiedades del gráfico es mejorar la presentación de los datos para que la visualización sea más efectiva. 

Si ha creado un **Gráfico de tabla**, las propiedades del gráfico sirven para establecer el tamaño de la página de la tabla, el campo por el que ordenar o el orden de clasificación del campo.


Si ha creado un **Gráfico de barras** o un **Gráfico de líneas**, las propiedades del gráfico se pueden establecer para etiquetar las líneas de umbral para añadir un marco de referencia para los usuarios que supervisen el gráfico.


<img class="gifplayer"  alt="Creación de un gráfico personalizado" src="creating-custom-charts.png"/>

## Tipos de gráfico
{: #chart-types }

### Gráfico de barras
{: #bar-graph }

El gráfico de barras permite la visualización de datos numéricos a lo largo de un eje X.
Al definir un gráfico de barras, primero se debe elegir el valor para el eje X.
Puede elegir entre los siguientes posibles valores.


* **Línea temporal** - elija Línea temporal para el eje X si desea ver los datos como una tendencia (por ejemplo, la duración media de una sesión de aplicación a lo largo del tiempo).

* **Propiedad** - elija Propiedad si desea ver un desglose de recuento por la propiedad especificada.
Si elige Propiedad para el eje X, de forma implícita se elige el Total para el eje Y.
Por ejemplo, elija Propiedad para el eje X y Nombre de aplicación para Propiedad para ver un recuento de un tipo de suceso especificado, que se desglosa por los nombres de aplicación.


Después de definir un valor para el eje X, puede definir un valor para el eje Y.
Si elige Línea temporal para eje X, puede elegir los siguientes valores para el eje Y.


* **Media** - calcula el valor medio de una propiedad numérica en el tipo de suceso especificado.

* **Total** - un recuento total de una propiedad en el tipo de suceso proporcionado.

* **Exclusivo** - un recuento exclusivo de una propiedad en el tipo de suceso proporcionado.


Después de definir los ejes del gráfico, debe elegir un valor para la propiedad.


### Gráfico de líneas
{: #line-graph }

El gráfico de líneas permite la visualización de algunas métricas a lo largo del tiempo.
Este tipo de gráfico es útil cuando se desean visualizar datos en términos de una tendencia a lo largo del tiempo.
El primer valor que se define al crear un gráfico de líneas es la Medida, que tiene los siguientes posibles valores.


* **Media** - calcula el valor medio de una propiedad numérica en el tipo de suceso especificado.

* **Total** - un recuento total de una propiedad en el tipo de suceso proporcionado.

* **Exclusivo** - un recuento exclusivo de una propiedad en el tipo de suceso proporcionado.


Después de definir la medida, debe elegir un valor para la propiedad.


### Gráfico de flujo
{: #flow-chart }

El gráfico de flujo permite la visualización de desglose del flujo desglose de una propiedad a otra.
Con un gráfico de flujo, se deben establecer las siguientes propiedades.


* **Origen** - valor del nodo origen en el diagrama. 
* **Destino** - valor del nodo de destino en el diagrama. 
* **Propiedad** - valor de propiedad desde el nodo origen o desde el nodo de destino. 

Con el gráfico de flujo, puede ver el desglose de densidad de los distintos orígenes que fluyen a un destino o viceversa.
Por ejemplo, si desea desglosar las gravedades de un registro de una aplicación, puede definir los siguientes valores.


* Seleccione Nombre de aplicación como Origen.
* Seleccione Nivel de registro como Destino. 
* Seleccione el nombre de su aplicación como Propiedad. 

### Grupo de métricas
{: #metric-group }

El grupo de métricas permite visualizar una métrica individual que se mide como un valor promedio, un recuento total o un valor exclusivo.
Para definir un grupo de métricas, debe definir uno de los siguientes valores posibles para Medida.


* **Media** - calcula el valor medio de una propiedad numérica en el tipo de suceso especificado.

* **Total** - un recuento total de una propiedad en el tipo de suceso proporcionado.

* **Exclusivo** - un recuento exclusivo de una propiedad en el tipo de suceso proporcionado.


Después de definir la medida, debe elegir un valor para la propiedad.
Esta métrica se visualiza en el grupo de métricas.


### Gráfico circular
{: #pie-chart }

El gráfico circular se puede utilizar para visualizar el desglose del recuento de valores de una propiedad concreta.
Por ejemplo, si desea visualizar un desglose de bloqueos, defina los siguientes valores.


* Seleccione Sesión de aplicación como Tipo de suceso. 
* Seleccione Gráfico circular como Tipo de gráfico. 
* Seleccione Cerrado por como Propiedad. 

El gráfico circular que se obtiene muestra el desglose de las sesiones de aplicación que el usuario cerró en oposición a las sesiones de aplicación que se cerraron debido a un bloqueo.


### Tabla
{: #table }

La tabla es útil cuando desea ver los datos sin procesar.
La generación de una tabla es tan simple como añadir columnas de los datos sin procesar que desea ver.
  
Dado que no todas las propiedades son necesarias para tipos de suceso específicos, pueden aparecer valores nulos en la tabla.
Si desea evitar que estas filas aparezcan en la tabla, añada un filtro de Existe para una propiedad específica en el separador de Filtros de gráfico.


## Creación de gráficos personalizados para registros de cliente
{: #creating-custom-charts-for-client-logs }

Existe la posibilidad de crear un gráfico personalizado para los registros de cliente que contiene información que se envía con la API del registrador de la plataforma.
  
La información de registro también incluye información contextual sobre el dispositivo, incluido el entorno, el nombre de la aplicación y la versión de la aplicación.


> **Nota:** Debe registrar sucesos personalizados para cumplimentar los gráficos personalizados.
Para obtener información sobre cómo enviar sucesos personalizados desde las aplicaciones de cliente, consulte [Captura de datos personalizados](../../analytics-api/#custom-events).
1. Desde la aplicación de cliente, cumplimente los datos enviando registros capturados al servidor.
Consulte [Envío de registros capturados](../../analytics-api/#sending-analytics-data).
2. En {{ site.data.keys.mf_analytics_console }}, pulse el separador **Gráficos personalizados** y continúe para crear un gráfico:

    * **Título de gráfico**: Niveles de registro y aplicación
    * **Tipo de suceso**: Registros de cliente
    * **Tipo de gráfico**: Gráfico de flujo

3. Pulse el separador **Definición de gráfico** y proporcione los siguientes valores:

    * **Origen**: Nombre de aplicación
    * **Destino**: Nivel de registro
    * **Propiedad**: el nombre de su aplicación

4. Pulse el botón **Guardar**. 

## Exportación de los datos de gráfico personalizado
{: #exporting-custom-chart-data }

Puede descargar los datos que se muestran en cualquier gráfico personalizado.  

![Exportar datos de gráficos personalizados mediante estos iconos](export-data.png)

* **Exportar con URL** - tiene el aspecto de un eslabón de una cadena
* **Descargar gráfico** - tiene el aspecto de una flecha hacia abajo
* **Editar gráfico** - tiene el aspecto de un lápiz
* **Suprimir gráfico** - tiene el aspecto de una papelera

Pulse el icono **Descargar gráfico** para descargar un archivo en formato JSON desde {{ site.data.keys.mf_analytics_console_short }}.
  
Pulse el icono **Exportar con URL** para genera un enlace de exportación desde {{ site.data.keys.mf_analytics_console_short }} al que puede llamar desde un cliente HTTP.
Esta opción es útil si desea escribir un script para automatizar los procesos de exportación durante un intervalo de tiempo especificado.


## Exportación e importación de definiciones de gráficos personalizados
{: #exporting-and-importing-custom-chart-definitions }

Las definiciones de los gráficos personalizados se pueden exportar e importar en {{ site.data.keys.mf_analytics_console_short }}.
Si está migrando desde un entorno de prueba a uno de despliegue de producción, puede ahorrar tiempo si exporta las definiciones de los gráficos personalizados en lugar de volverlos a crear para su nuevo clúster.


1. Pulse el separador **Gráficos personalizados** en el panel de control de {{ site.data.keys.mf_analytics_console_short }}.

2. Pulse **Exportar gráficos** para exportar un archivo JSON con su definición de gráfico.

3. Elija la ubicación en la que guardar el archivo JSON.

4. Pulse **Importar gráficos** para importar el archivo JSON.
Si importa una definición de gráfico personalizado que ya exista, creará definiciones duplicadas, lo que también significa que {{ site.data.keys.mf_analytics_console_short }} mostrará gráficos duplicados.

