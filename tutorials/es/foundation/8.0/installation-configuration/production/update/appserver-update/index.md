---
layout: tutorial
title: Actualización del servidor de MobileFirst
breadcrumb_title: Updating the MobileFirst server
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
IBM MobileFirst Platform Foundation proporciona varios componentes que es posible que haya instalado.

Aquí hay una descripción de sus dependencias para actualizarlos:

### MobileFirst Server Administration Service, MobileFirst Operations Console, y el entorno de ejecución de MobileFirst
{: #server-console }

Estos tres componentes componen MobileFirst Server. Deben actualizarse de forma conjunta.

### Application Center
{: #appenter}

La instalación de este componente es opcional. Este componente es independiente del resto de los componentes. Se puede ejecutar en un nivel de arreglo temporal diferente que los otros, si es necesario.

### MobileFirst Operational Analytics
{: #analytics}

La instalación de este componente es opcional. Los componentes de MobileFirst envían datos a MobileFirst Operational Analytics a través de una API REST. Es preferible ejecutar MobileFirst Operational Analytics con los otros componentes de MobileFirst Server del mismo nivel de arreglo temporal.


## Actualización de MobileFirst Server Administration Service, MobileFirst Operations Console, y del entorno de ejecución de MobileFirst
{: #updating-server}

Puede actualizar estos componentes de dos maneras:
* Con la Herramienta de configuración del servidor
* Con tareas Ant

El procedimiento de actualización depende del método que haya utilizado en la instalación inicial.

> **Nota:** Installation Manager (IM) no da soporte a la retrotracción de una actualización/iFix. Sin embargo, la retrotracción es posible utilizando la Herramienta de configuración de servidor o Ant, si tiene los archivos war antiguos.

### Aplicación de un fixpack utilizando la Herramienta de configuración del servidor
{: #applying-a-fix-pack-by-using-the-server-configuration-tool }
Si {{ site.data.keys.mf_server }} se instala con la herramienta de configuración y se conserva el archivo de configuración, puede aplicar un fixpack o un arreglo temporal reutilizando el archivo de configuración.

1. Inicie la Herramienta de configuración del servidor.
    * En Linux, desde los atajos de aplicación **Aplicaciones → IBM MobileFirst Platform Server → Herramienta de configuración del servidor**.
    * En Windows, pulse **Inicio → Programas → IBM MobileFirst Platform Server → Herramienta de configuración del servidor**.
    * En macOS, abra una consola de shell. Vaya a **mfp\_server\_install_dir/shortcuts** y escriba **./configuration-tool.sh**.
    * El directorio **mfp\_server\_install\_dir** es donde ha instalado {{ site.data.keys.mf_server }}.

2. Pulse **Configuraciones → Sustituir los archivos WAR desplegados** y seleccione una configuración existente para aplicar el fixpack o un arreglo temporal.


### Aplicación de un fixpack utilizando los archivos Ant
{: #applying-a-fix-pack-by-using-the-ant-files }

#### Actualización con el archivo Ant de ejemplo
{: #updating-with-the-sample-ant-file }
Si utiliza los archivos Ant de ejemplo que se proporcionan en el directorio **mfp\_install\_dir/MobileFirstServer/configuration-samples** para instalar {{ site.data.keys.mf_server }}, puede reutilizar una copia de este archivo Ant para aplicar un fixpack. Para los valores de contraseña, puede especificar 12 estrellas (\*) en lugar del valor real, para que se le solicite interactivamente cuando se ejecute el archivo Ant.

1. Verifique el valor de la propiedad **mfp.server.install.dir** en el archivo Ant. Debe apuntar al directorio que contiene el producto con el fixpack aplicado. Este valor se utiliza para tomar los archivos WAR de {{ site.data.keys.mf_server }} actualizados.
2. Ejecute el mandato: `mfp_install_dir/shortcuts/ant -f your_ant_file update`

#### Actualización con su propio archivo Ant
{: #updating-with-own-ant-file }
Si utiliza su propio archivo Ant, asegúrese de que para cada tarea de instalación (**installmobilefirstadmin**, **installmobilefirstruntime**, e **installmobilefirstpush**), tenga una tarea de actualización correspondiente en el archivo Ant con los mismos parámetros. Las tareas de actualización correspondientes son **updatemobilefirstadmin**, **updatemobilefirstruntime** y **updatemobilefirstpush**.

1. Verifique la vía de acceso de clases del elemento **taskdef** para el archivo **mfp-ant-deployer.jar**. Debe apuntar al archivo **mfp-ant-deployer.jar** en una instalación de {{ site.data.keys.mf_server }} a la que se aplica el fixpack. De forma predeterminada, los archivos WAR de {{ site.data.keys.mf_server }} actualizados se toman de la ubicación de **mfp-ant-deployer.jar**.
2. Ejecute las tareas de actualización (**updatemobilefirstadmin**, **updatemobilefirstruntime**, y **updatemobilefirstpush**) del archivo Ant.
