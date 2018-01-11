---
layout: tutorial
title: Configuración del registro y del rastreo para Application Center en el servidor de aplicaciones
breadcrumb_title: Configuración del registro y del rastreo
relevantTo: [ios,android,windows,javascript]
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
Puede configurar los parámetros de registro y rastreo para determinados servidores de aplicaciones y utilizar propiedades JNDI para controlar la salida en todos los servidores de aplicaciones soportados.

Puede configurar niveles de registro y el archivo de salida para operaciones de rastreo de Application Center de formas que sean específicas de servidores de aplicaciones determinados. Además, {{ site.data.keys.product_full }} proporciona propiedades de Java Naming and Directory Interface (JNDI) para controlar el formateo y la redirección de la salida de rastreo, y para imprimir las sentencias SQL generadas.

#### Ir a
{: #jump-to }
* [Habilitación del registro y rastreo en el perfil completo de WebSphere Application Server](#logging-in-websphere)
* [Habilitación del registro y rastreo en WebSphere Application Server Liberty](#logging-in-liberty)
* [Habilitación del registro y rastreo en Apache Tomcat](#logging-in-tomcat)
* [Propiedades JNDI para controlar la salida de rastreo](#jndi-properties-for-controlling-trace-output)

## Habilitación del registro y rastreo en el perfil completo de WebSphere Application Server
{: #logging-in-websphere }
Puede establecer los niveles de registro y el archivo de salida para las operaciones de rastreo en el servidor de aplicaciones.

Al intentar diagnosticar problemas en Application Center
(u otros componentes de {{ site.data.keys.product }}),
es importante poder ver los mensajes de registro. Para imprimir los mensajes de registro legibles en los archivos de registro, debe especificar los valores aplicables como propiedades de máquina virtual Java (JVM).

1. Abra la consola de administración de WebSphere Application Server.
2. Seleccione **Resolución de problemas → Registros y rastreo**.
3. En **Registro y rastreo**, seleccione el servidor de aplicaciones adecuado y a continuación seleccione **Cambiar niveles de detalle de rastreo**.
4. Seleccione los paquetes y su correspondiente nivel de detalle. Este ejemplo permite el registro para {{ site.data.keys.product }}, incluido Application Center, con el nivel **FINEST** (equivalente a **ALL**).

```xml
com.ibm.puremeap.*=all
com.ibm.mfp.*=all
com.ibm.worklight.*=all
com.worklight.*=all
```

Donde:

* **com.ibm.puremeap.*** es para Application Center.
* **com.ibm.mfp.**\*, **com.ibm.worklight.*** y
**com.worklight.*** son para otros componentes de {{ site.data.keys.product_adj }}.


Los rastreos se envían a un archivo denominado **trace.log**, no a **SystemOut.log** o a **SystemErr.log**.

## Habilitación del registro y rastreo en WebSphere Application Server Liberty
{: #logging-in-liberty }
Puede establecer los niveles de registro y el archivo de salida para las operaciones de rastreo para Application Center en el servidor de aplicaciones de Liberty.

Al intentar diagnosticar problemas en el servidor de aplicaciones, es importante poder ver los mensajes de registro. Para imprimir los mensajes de registro legibles en los archivos de registro, debe especificar los valores aplicables. 

Para habilitar el registro para {{ site.data.keys.product }}, incluido Application Center, con el nivel FINEST (equivalente a ALL), añada una línea al archivo server.xml. Por ejemplo:

```xml
<logging traceSpecification="com.ibm.puremeap.*=all:com.ibm.mfp.*=all:com.ibm.worklight.*=all:com.worklight.*=all"/>
```

En este ejemplo, varias entradas de un paquete y su nivel de registro están separados por dos puntos (:).

Los rastreos se envían a un archivo denominado **trace.log**, no a **messages.log** o a **console.log**.

Para obtener más información, consulte [Perfil de Liberty: Registro y rastreo](http://www.ibm.com/support/knowledgecenter/SSEQTP_8.5.5/com.ibm.websphere.wlp.doc/ae/rwlp_logging.html?cp=SSEQTP_8.5.5%2F1-16-0-0&view=kc).

## Habilitación del registro y rastreo en Apache Tomcat
{: #logging-in-tomcat }
Puede establecer los niveles de registro y el archivo de salida para las operaciones de rastreo realizadas en el servidor de aplicaciones Apache Tomcat.

Al intentar diagnosticar problemas en el servidor de aplicaciones, es importante poder ver los mensajes de registro. Para imprimir los mensajes de registro legibles en los archivos de registro, debe especificar los valores aplicables. 

Para habilitar el registro para {{ site.data.keys.product }}, incluido Application Center, con el nivel **FINEST** (equivalente a **ALL**), edite el archivo **conf/logging.properties**. Por ejemplo, añada líneas similares a las siguientes:

```xml
com.ibm.puremeap.level = ALL
com.ibm.mfp.level = ALL
com.ibm.worklight.level = ALL
com.worklight.level = ALL
```

Para obtener más información, consulte [Registro en Tomcat](http://tomcat.apache.org/tomcat-7.0-doc/logging.html).

## Propiedades JNDI para controlar la salida de rastreo
{: #jndi-properties-for-controlling-trace-output }
En todas las plataformas soportadas, puede utilizar propiedades de Java Naming and Directory Interface (JNDI) para formatear y redirigir la salida de rastreo para Application Center y para imprimir las sentencias SQL generadas.

Las siguientes propiedades de JNDI son aplicables para la aplicación web para servicios de Application Center (**applicationcenter.war**).

| Valores de la propiedad| Valor| Descripción| 
|-------------------|---------|-------------|
| ibm.appcenter.logging.formatjson| true| De manera predeterminada, esta propiedad se establece en false. Establézcala en true para formatear la salida JSON con espacios en blanco, para una lectura más sencilla en archivos de registro.| 
| ibm.appcenter.logging.tosystemerror| true| De manera predeterminada, esta propiedad se establece en false. Establézcala en true para imprimir todos los mensajes de registro del error de sistema en archivos de registro. Utilice la propiedad para activar el registro de forma global.| 
| ibm.appcenter.openjpa.Log| DefaultLevel=WARN, Runtime=INFO, Tool=INFO, SQL=TR  ACE| Este valor imprime todas las sentencias SQL generadas en los archivos de registro.| 
