---
layout: tutorial
title: Desarrollo de adaptadores en Eclipes
relevantTo: [ios,android,windows,javascript]
weight: 5
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general 
{: #overview }

Tal como se explicó en las anteriores [guías de aprendizaje](../), los adaptadores son proyectos Maven que se crean directamente con Maven o mediante {{ site.data.keys.mf_cli }}.
El código del adaptador se puede editar en un IDE, y más tarde, compilarlo y desplegarlo mediante Maven o {{ site.data.keys.mf_cli }}.
Un desarrollador también puede elegir realizar todo el proceso de crear, desarrollar, compilar y desplegar dentro de un IDE soportado como, por ejemplo, Eclipse o IntelliJ.
En esta guía de aprendizaje se crea y compila un adaptador en el IDE de Eclipse.


> Para obtener las instrucciones para utilizar IntelliJ consulte el artículo del blog de [Utilización de IntelliJ para desarrollar adaptadores Java de MobileFirst]({{site.baseurl}}/blog/2016/03/31/using-intellij-to-develop-adapters).


**Requisitos previos:
**

* Familiarícese con los adaptadores leyendo en primer lugar las [guías de aprendizaje de adaptadores](../).

* Integración de Maven en Eclipse.
Desde Eclipse Kepler (v4.3), el soporte a Maven está incorporado en Eclipse. Si su instancia de Eclipse no da soporte a Maven, [siga las instrucciones de m2e](http://www.eclipse.org/m2e/) para añadir el soporte a Maven.


#### Ir a
{: #jump-to }

* [Creación de un nuevo proyecto Maven de adaptador](#creating-a-new-adapter-maven-project)
* [Importación de un proyecto Maven de adaptador existente](#importing-an-existing-adapter-maven-project)
* [Compilación y despliegue de un proyecto Maven de adaptador](#building-and-deploying-an-adapter-maven-project)
* [Lectura adicional](#further-reading)

## Creación o importación de un proyecto Maven de adaptador
{: #create-or-import-an-adapter-maven-project }

Siga las instrucciones que hay a continuación para crear un nuevo proyecto Maven de adaptador o para importar uno que ya exista.


### Creación de un nuevo proyecto Maven de adaptador
{: #creating-a-new-adapter-maven-project }

1. Para crear un nuevo proyecto Maven de adaptador, seleccione **Archivo → Nuevo → Otro... → Maven → Proyecto Maven** y pulse **Siguiente**.


    ![Imagen que muestra cómo crear un proyecto Maven de adaptador en Eclipse](new-maven-project.png)

2. Proporcione un nombre de proyecto y su ubicación.  
    - Asegúrese de que la opción para crear un proyecto simple está **desmarcada** y pulse **Siguiente**. 

    ![Imagen que muestra cómo crear un proyecto Maven de adaptador en Eclipse](select-project-name-and-location.png)

3. Seleccione o añada el arquetipo del adaptador.

    - Si [instaló arquetipos de forma local](../creating-adapters/#install-maven) y no aparecen en la lista de arquetipos, seleccione **Configurar → Añadir catálogo local → Navegue a /.m2/repository/archetype-catalog.xml en el directorio de inicio**.
    - Pulse en **Añadir arquetipo** y proporcione los siguientes detalles:

        - **ID de grupo de arquetipo**: `com.ibm.mfp`
        - **ID de artefacto de arquetipo**: Indique `adapter-maven-archetype-java`, `adapter-maven-archetype-http` o `adapter-maven-archetype-sql`

        - **Versión de arquetipo**: Encontrará la última versión disponible en [Maven Central](http://search.maven.org/#search%7Cga%7C1%7Ccom.ibm.mfp)


    ![Imagen que muestra cómo crear un proyecto Maven de adaptador en Eclipse](create-an-archetype.png)

4. Especifique los parámetros del proyecto Maven.   
    - Especifique los parámetros **ID de grupo**, **ID de artefacto**, **Versión** y **paquete** y pulse **Finalizar**.


    ![Imagen que muestra cómo crear un proyecto Maven de adaptador en Eclipse](project-parameters.png)

### Importación de un proyecto Maven de adaptador existente
{: #importing-an-existing-adapter-maven-project }

Para importar el proyecto Maven de adaptador, seleccione **Archivo → Importar... → Maven → Proyectos Maven existentes**.

![Imagen que muestran cómo importar un proyecto Maven de adaptador en Eclipse](import-adapter-maven-project.png)

## Compilación y despliegue de un proyecto Maven de adaptador
{: #building-and-deploying-an-adapter-maven-project }

Un proyecto de adaptador se puede compilar y desplegar mediante mandatos de línea de mandatos de Maven, {{ site.data.keys.mf_cli }} o desde Eclipse.
  
[Aprenda a compilar y desplegar adaptadores](../creating-adapters/#build-and-deploy-adapters).


> <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> **Sugerencia:** También es posible mejorar Eclipse para facilitar el paso de despliegue integrando una ventana de **línea de mandatos** mediante un plugin, creando un entorno de desarrollo coherente.
Desde esta ventana se pueden ejecutar mandatos de {{ site.data.keys.mf_cli }} o Maven.


### Compilación de un adaptador
{: #building-an-adapter }

Para compilar un adaptador, pulse con el botón derecho del ratón sobre la carpeta del adaptador y seleccione **Ejecutar como → Instalación Maven**.  

### Despliegue de un adaptador
{: #deploying-an-adapter }

Para desplegar un adaptador, primero es necesario añadir el mandato Maven deploy:


1. Seleccione **Ejecutar → Ejecutar configuraciones...**, pulse con el botón derecho del ratón en **Compilación de Maven** y seleccione **Nuevo**.
2. Proporcione un nombre: "Maven deploy".
2. Establezca como objetivo: "adapter:deploy".
3. Pulse **Aplicar** y pulse **Ejecutar** para un despliegue inicial.


Puede pulsar con el botón derecho del ratón sobre la carpeta del adaptador y seleccionar **Ejecutar como → Despliegue de Maven**

### Compilación y despliegue de un adaptador
{: #building-and-deploying-an-adapter }

También es posible combinar los objetivos Maven "build" y "deploy" en un único objetivo "build and deploy": "clean install adapter:deploy".


## Lectura adicional
{: #further-reading }

Aprenda a depurar código Java en adaptadores en la guía de aprendizaje [Pruebas y depuración de adaptadores](../testing-and-debugging-adapters).

