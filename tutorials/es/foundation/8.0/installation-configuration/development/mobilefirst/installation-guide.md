---
layout: tutorial
title: Guía de instalación de la estación de trabajo 
breadcrumb_title: Installation guide
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
Siga esta guía de instalación para configurar la estación de trabajo para el desarrollo mediante {{ site.data.keys.product }}.


## Instalador DevKit
{: #devkit-installer }
El [Instalador de {{ site.data.keys.mf_dev_kit }}]({{site.baseurl}}/tutorials/en/foundation/8.0/installation-configuration/development/mobilefirst) instalará {{ site.data.keys.mf_server }}, una base de datos y un entorno de ejecución en su máquina de desarrollo listos para ser utilizados.
  

**Requisito previo:**  
El instalador necesita que Java esté instalado.


1. [Instale el JRE de Oracle](http://www.oracle.com/technetwork/java/javase/downloads/jre8-downloads-2133155.html).

2. Añada una variable `JAVA_HOME` que apunte a JRE

    *Mac y Linux:* Edite su **~/.bash_profile**:

    ```bash
    #### ORACLE JAVA
    export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_73.jdk/Contents/Home"
    ```

    *Windows:*  
    [Siga esta guía](https://confluence.atlassian.com/doc/setting-the-java_home-variable-in-windows-8895.html).

### Instalación
{: #installation }
Obtenga el instalador de DevKit desde la [página de descargas]({{site.baseurl}}/downloads/) y siga las instrucciones que aparezcan en la pantalla.


![instalador de devkit](devkit-installer.png)

### Inicio y detención del servidor
{: #starting-and-stopping-the-server }
Abra una ventana de línea de mandatos y vaya a la ubicación de la carpeta extraída.


*Mac y Linux:*  

* Para iniciar el servidor: `./run.sh -bg`
* Para detener el servidor: `./stop.sh`

*Windows:*  

* Para iniciar el servidor: `./run.cmd -bg`
* Para detener el servidor: `./stop.cmd`

### Acceso a {{ site.data.keys.mf_console }}
{: #accessing-the-mobilefirst-operations-console }
Se puede acceder a [{{ site.data.keys.mf_console }}]({{site.baseurl}}/tutorials/en/foundation/8.0/product-overview/components/console/) de las siguientes maneras:


* Desde la línea de mandatos, ejecute `mfpdev server console`
* Desde un navegador, visite [http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole)

![consola]({{site.baseurl}}/tutorials/en/foundation/8.0/product-overview/components/console/dashboard.png)

## {{ site.data.keys.mf_cli }}
{: #mobilefirst-cli }
[{{ site.data.keys.mf_cli }}]({{site.baseurl}}/tutorials/en/foundation/8.0/application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts) es una interfaz de línea de mandatos que permite registrar aplicaciones en {{ site.data.keys.mf_server }}, hacer pull/push a aplicaciones desde/a {{ site.data.keys.mf_server }}, crear adaptadores Java y JavaScript, gestionar distintos servidores locales y remotos, crear adaptadores Java y JavaScript, gestionar servidores locales y remotos, actualizar aplicaciones en directo mediante Direct Update, etc.


**Requisito previo:**  
1. NodeJS y NPM son requisitos para poder instalar {{ site.data.keys.mf_cli }}.  
 Descargue e instale [NodeJS v6.11.1](https://nodejs.org/download/release/v6.11.1/) y NPM v3.10.10. Para la versión MobileFirst CLI version 8.0.2018100112 o superiores, puede utilizar Node v8.x o v10.x. 

 Para verificar la instalación, abra una ventana de línea de mandatos y ejecute `node -v`.


2. Algunos mandatos de la interfaz de línea de mandatos (CLI), como por ejemplo los necesarios para crear, compilar y desplegar adaptadores precisan de Maven.
Consulte la sección siguiente para obtener instrucciones de instalación.

### Instalación de {{ site.data.keys.mf_cli }}
{: #installation-cli }
Abra una ventana de terminal y ejecute: `npm install -g mfpdev-cli`.
  

*Mac y Linux:* Observe que podría necesitar ejecutar el mandato utilizando `sudo`.
  
Obtenga más información sobre cómo [corregir los permisos de NPM](https://docs.npmjs.com/getting-started/fixing-npm-permissions).


Para verificar la instalación, abra una ventana de línea de mandatos y ejecute `mfpdev -v` o `mfpdev help`.


![consola](mfpdev-cli.png)

## Adaptadores y comprobaciones de seguridad
{: #adapters-and-security-checks }
Los [Adaptadores]({{site.baseurl}}/tutorials/en/foundation/8.0/adapters) y las [Comprobaciones de seguridad]({{site.baseurl}}/tutorials/en/foundation/8.0/authentication-and-security) son dos formas de incorporar autenticación y otras capas de seguridad a su aplicación.


**Requisito previo:**  
Se necesita Apache Maven para realizar la configuración y antes de poder crear adaptadores y comprobaciones de seguridad.
  

1. [Descargue el .zip de Apache Maven](https://maven.apache.org/download.cgi)
2. Añada una variable `MVN_PATH`, apuntando a la carpeta de Maven

    *Mac y Linux:* Edite su **~/.bash_profile**:

    ```bash
    #### Apache Maven
    export MVN_PATH="/usr/local/bin"
    ```

    *Windows:*  
    [Siga esta guía](http://crunchify.com/how-to-setupinstall-maven-classpath-variable-on-windows-7/).Verifique la instalación ejecutando `mvn -v`.

### Uso
{: #usage }
Con Apache Maven instalado, ahora podrá crear adaptadores a través de mandatos de línea de Maven o utilizando {{ site.data.keys.mf_cli }}.
  
Para obtener más información, revise las [guías de aprendizaje de adaptadores]({{site.baseurl}}/tutorials/en/foundation/8.0/adapters).
