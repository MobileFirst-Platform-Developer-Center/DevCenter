---
layout: tutorial
title: Novedades en los arreglos temporales
breadcrumb_title: iFixes temporales
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
<br/>
Los arreglos temporales proporcionan parches y actualizaciones para corregir problemas y mantener {{site.data.keys.product_full }} actualizado para nuevos releases de los sistemas operativos móviles.

Los arreglos temporales son acumulativos.
Cuando descarga los últimos arreglos temporales de la v8.0, obtiene todos los arreglos de anteriores arreglos temporales.


Descargue e instale el arreglo temporal más reciente para obtener todos los arreglos que se describen en las secciones siguientes.
Si no instalar los últimos arreglos, podría no obtener todos los arreglos que se describen aquí.


> Para obtener una lista de releases de iFix de {{site.data.keys.product }} 8.0, [consulte estas entradas del blog]({{site.baseurl}}/blog/tag/iFix_8.0/).  

Donde aparezca una lista de números de APAR, podrá confirmar que un arreglo temporal tiene dicha característica buscando en el archivo README del arreglo temporal dicho número de APAR.


### Gestión de licencias
{: #licensing }
#### Gestión de licencias de PVU
{: #pvu-licensing }
Ahora hay disponible una nueva oferta, {{site.data.keys.product }} Extension V8.0.0, a través de la gestión de licencias de unidades de valor de procesador (PVU).
Para obtener más información sobre la gestión de licencias PVU para {{site.data.keys.product }} Extension, consulte la [Gestión de licencias de {{site.data.keys.product_adj }}](../../licensing).


### Aplicaciones Web
{: #web-applications }
#### Registro de aplicaciones web desde {{site.data.keys.mf_cli }} (APAR PI65327)
{: #registering-web-applications-from-the-mobilefirst-cli-apar-pi65327 }
Ahora puede registrar aplicaciones web de cliente en {{site.data.keys.mf_server }} utilizando {{site.data.keys.mf_cli }} (mfpdev) como método alternativo al registro desde {{site.data.keys.mf_console }}.
Para obtener más información, consulte Registro de aplicaciones web desde {{site.data.keys.mf_cli }}.

### Aplicaciones Cordova
{: #cordova-applications }
#### Apertura del entorno de desarrollo integrado (IDE) nativo para una proyecto Cordova desde Eclipse con el plugin Studio

{: #opening-the-native-ide-for-a-cordova-project-from-eclipse-with-the-studio-plug-in }
Con el plugin Studio instalado en su IDE de Eclipse, puede abrir un proyecto de Cordova existente en Android Studio o Xcode desde la interfaz de Eclipse para compilar y ejecutar el proyecto.


#### Añadido el directorio *nombre_proyecto* como una opción al utilizar la herramienta de Asistente de migración.

{: #added-projectname-directory-as-an-option-when-you-use-the-migration-assistance-tool }
Puede especificar un nombre para su directorio de proyecto de Cordova al migrar proyectos con la herramienta de asistencia de migración.  Si no proporciona un nombre, el nombre predeterminado es *nombre_aplicación_id_versión*.

#### Mejoras de usabilidad en la herramienta Asistente de migración
{: #usability-improvements-to-the-migration-assistance-tool }
Se ha realizado los siguientes cambios para mejorar la usabilidad de la herramienta Asistente de migración:


* La herramienta Asistente de migración escanea archivos HTML y archivos JavaScript.

* El informa de escaneo se abre de forma automática en su navegador predeterminado una vez el escaneo ha finalizado.

* El distintivo *--out* es opcional.
Se utiliza el directorio de trabajo si no se especifica.

* Cuando se especifica el distintivo *--out* y el directorio no existe, se crea.


### Adaptadores
{: #adapters }
#### Se han añadido los mandatos `mfpdev push` y `pull` para configuraciones de adaptador JavaScript y Java
{: #added-mfpdev-push-and-pull-commands-for-java-and-javascript-adapter-configurations }
Puede utilizar {{site.data.keys.mf_cli }} para hacer push a configuraciones de adaptador JavaScript y Java para {{site.data.keys.mf_server }} y hacer pull a configuraciones de adaptador de {{site.data.keys.mf_server }}.

