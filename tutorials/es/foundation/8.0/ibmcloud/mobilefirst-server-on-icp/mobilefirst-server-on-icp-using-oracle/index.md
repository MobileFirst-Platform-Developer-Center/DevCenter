---
layout: tutorial
title: Configuración de Mobile Foundation con una base de datos Oracle en IBM Cloud Private
breadcrumb_title: Foundation with Oracle DB on ICP
relevantTo: [ios,android,windows,javascript]
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview}

IBM Mobile Foundation listo para utilizar - El paquete PPA de ICP admite el uso de un servidor de IBM DB2. Este tutorial se centra en extender el Mobile Foundation desplegado en IBM Cloud Private (ICP) para utilizar una base de datos Oracle remota para el almacenamiento de los datos de Mobile Foundation.

## Suposición
{: #assumption }
Antes de continuar con la guía de aprendizaje, se asume lo siguiente:

* Ya se ha configurado IBM Cloud Private y se ha cargado el archivo de IBM Mobile Foundation Passport Advantage en ICP.
* Configuración de las tablas de la base de datos de Mobile Foundation que se crean manualmente en un servidor de base de datos Oracle remoto ([Download]((customizable-db-artifacts-for-mfp-icp.zip)) y consulte los scripts de base de datos de Oracle para el servidor de Mobile Foundation).
* El conjunto de herramientas de interfaz de línea de mandatos de IBM Cloud Private está instalado en el sistema local (`bx pr`, `docker`, `kube` o `cloudctl`, etc.)

>**Nota:** Durante el despliegue de helm para bases de datos DB2, las tablas se crean automáticamente. Para Oracle, PostgreSQL o MySQL tendrá que crearlas manualmente antes de desplegar el gráfico de helm.

## Artefactos que necesitan personalización
{: #artifacts-to-be-customized }

La image de Docker de tiene ciertos artefectos que pueden personalizarse para habilitar el soporte para la base de datos de Oracle. Los siguientes archivos son los que es necesario modificar en el Docker para crear los contenedores con los artefactos y configuraciones relacionados con Oracle.
1.	`mfpdbconfig.sh`.
2.	`mfpfsqldb.xml` - modificado para dar soporte a la base de datos de Oracle y los orígenes de datos relacionados.
3.	Incluya el controlador JDBC cliente de Oracle.
4.	Actualice `server.xml`.

>**Nota:** Los nombres de archivo arriba mencionados tienen que mantenerse en el mismo orden para personalizar la imagen de Docker de base.


### Procedimiento
{: #procedure}

1.	Desde la consola de ICP **Catálogo**, asegúrese de que los gráficos helm `ibm-mfpf-*` helm se han cargado.
2.	Desempaquete el adjunto (`mfp-icp-oracle.zip`) para localizar el `Dockerfile` y `usr-mfpf-server` muestra la estructura de directorios y un `Dockerfile` de muestra para utilizarlo.
3.	Modifique el `Dockerfile` de forma que utilice la corrección de versión de imagen sobre la que se ha de extender la imagen de Docker.<br/>
     *Ejemplo:*<br/>
      `FROM mycluster.icp:8500/default/mfpf-server:<a.b.c.d>`<br/>
       *a.b.c.d* es la versión de imagen disponible en el registro de imágenes.
4.	Siga las instrucciones del blog para personalizar la imagen de Docker y crear los pods de servidor de Mobile Foundation.
5.	Una vez que se extienda la imagen de Docker con los pasos mencionados, puede utilizarse la consola de ICP para desplegar el gráfico Helm para el servidor de Mobile Foundation. Asegúrese de que se proporciona la nueva imagen.

Para personalizar o extender la imagen de Docker consulte [Cómo personalizar el componente de Mobile Foundation desplegado en IBM Cloud Private (ICP)](https://mobilefirstplatform.ibmcloud.com/blog/2018/11/04/customize-mfp-on-icp/).

>**Nota:** Para bases de datos MySQL y PostgreSQL deben usarse los controladores JDBC adecuados.
