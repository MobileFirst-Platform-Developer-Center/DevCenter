---
layout: tutorial
title: Creación de adaptadores Java y JavaScript
breadcrumb_title: Creación de adaptadores
relevantTo: [ios,android,windows,javascript]
show_children: true
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general 
{: #overview }
Un adaptador se puede crear utilizando mandatos de Maven o utilizando {{ site.data.keys.mf_cli }} (que depende de que Maven esté instalado y configurado).
El código del adaptador se puede entonces editar y compilar utilizando el entorno de desarrollo integrado (IDE) de su elección como, por ejemplo, Eclipse o IntelliJ.
Esta guía de aprendizaje explica como crear, compilar y desplegar **adaptadores de Java o JavaScript** mediante Maven y {{ site.data.keys.mf_cli }}.
Para aprender a utilizar los IDE de Eclipse o IntelliJ para crear y compilar adaptadores, revise la guía de aprendizaje [Desarrollo de adaptadores en Eclipse](../developing-adapters).


**Requisito previo: ** Asegúrese de haber leído primero [Visión general de adaptadores](../).


#### Ir a
{: #jump-to }
* [Instalación de Maven](#install-maven)
* [Creación de adaptadores mediante {{ site.data.keys.mf_cli }}](#creating-adapters-using-mobilefirst-cli)
* [Instalación de {{ site.data.keys.mf_cli }}](#install-mobilefirst-cli)
* [Creación de un adaptador](#creating-an-adapter)
* [Creación de adaptadores mediante arquetipos de Maven](#creating-adapters-using-maven-archetype-adapter-maven-archetype)
* [Estructura de archivos](#file-structure)
* [Compilación y despliegue de adaptadores](#build-and-deploy-adapters)
* [Dependencias](#dependencies)
* [Agrupación de adaptadores en un único proyecto Maven](#grouping-adapters-in-a-single-maven-project)
* [Descarga y despliegue de adaptadores mediante {{ site.data.keys.mf_console }}](#downloading-or-deploying-adapters-using-mobilefirst-operations-console)
* [Actualización del proyecto Maven del adaptador](#updating-the-adapter-maven-project)
* [Funcionamiento fuera de línea](#working-offline)
* [Guías de aprendizaje con las que continuar ](#tutorials-to-follow-next)

## Instalación de Maven
{: #install-maven }
Con el propósito de crear un adaptador, primero es necesario descargar e instalar Maven.
Vaya al [sitio web de Apache Maven](https://maven.apache.org/) y siga las instrucciones para descargar e instalar Maven.


## Creación de adaptadores mediante {{ site.data.keys.mf_cli }}
{: #creating-adapters-using-mobilefirst-cli }

### Instalación de {{ site.data.keys.mf_cli }}
{: #install-mobilefirst-cli }
Siga las instrucciones de instalación en la página de [Descargas]({{site.baseurl}}/downloads/) para instalar {{ site.data.keys.mf_cli }}.
  
**Requisito previo:** Para crear adaptadores utilizando la interfaz de línea de mandatos del desarrollador, Maven debe estar instalado.


### Creación de un adaptador
{: #creating-an-adapter }
Utilice el mandato `mfpdev adapter create` para crear un proyecto de un adaptador de Maven.
Puede ejecutar el mandato de forma interactiva o de forma directa.


#### Modalidad interactiva 
{: #interactive-mode }
1. Abra una ventana de **línea de mandatos** y ejecute:


   ```bash
   mfpdev adapter create
   ```

2. Especifique un nombre de adaptador. Por ejemplo:

   ```bash
   ? Enter Adapter Name: SampleAdapter
   ```

3. Seleccione un tipo de adaptador utilizando las flechas y el especifique las claves:

   ```bash
   ? Select Adapter Type:
      HTTP
      SQL
   ❯ Java
   ```
  * Seleccione `HTTP` para crear un adaptador HTTP JavaScript
  * Seleccione `SQL` para crear un adaptador SQL JavaScript  
  * Seleccione `Java` para crear un adaptador Java

4. Especifique un paquete de adaptador (esta opción solo es válida con adaptadores Java).
Por ejemplo:

   ```bash
   ? Enter Package: com.mypackage
   ```

5. Especifique un [ID de grupo](https://maven.apache.org/guides/mini/guide-naming-conventions.html) del proyecto Maven a compilar.
Por ejemplo:

   ```bash
   ? Enter Group ID: com.mycompany
   ```

#### Modalidad directa
{: #direct-mode }
Sustituya los parámetros con los valores reales y ejecute el mandato:


```bash
mfpdev adapter create <adapter_name> -t <adapter_type> -p <adapter_package_name> -g <maven_project_groupid>
```

## Creación de adaptadores mediante arquetipos Maven "adapter-maven-archetype"
{: #creating-adapters-using-maven-archetype-adapter-maven-archetype }

"adapter-maven-archetype" es un arquetipo que {{ site.data.keys.product }} proporciona, que se basa en el [Maven Archetype Toolkit](https://maven.apache.org/guides/introduction/introduction-to-archetypes.html) y que Maven utiliza con el propósito de crear un proyecto Maven de adaptador.


Utilice el mandato Maven `archetype:generate` para crear un proyecto de adaptador Maven.
Una vez ejecute el mandato, Maven descargará (o utilizará los repositorios locales mencionados con anterioridad) los archivos necesarios con el propósito de generar el proyecto Maven de adaptador.


Puede ejecutar el mandato de forma interactiva o de forma directa.


#### Modalidad interactiva 
{: #interactive-mode-archetype }

1. Desde la ventana de **línea de mandatos**, vaya a la ubicación de su elección.
  
También es donde se generará el proyecto de Maven.


2. Sustituya el parámetro **DarchetypeArtifactId** con el valor real y ejecute:


   ```bash
   mvn archetype:generate -DarchetypeGroupId=com.ibm.mfp -DarchetypeArtifactId=replace-with-the-adapter-type-artifact-ID
   ```
   
  * `ID de grupo de arquetipo` y Versión de arquetipo son parámetros necesarios para identificar el arquetipo.

  * El `ID de artefacto de arquetipo` es un parámetro necesario para identificar el tipo de adaptador:

     * Utilice `adapter-maven-archetype-java` para crear el adaptador Java
     * Utilice `adapter-maven-archetype-http` para crear el adaptador HTTP JavaScript
     * Utilice `adapter-maven-archetype-sql` para crear el adaptador SQL JavaScript  

3. Especifique un [ID de grupo](https://maven.apache.org/guides/mini/guide-naming-conventions.html) del proyecto Maven a compilar.
Por ejemplo:

   ```bash
   Define value for property 'groupId': : com.mycompany
   ```

4. Especifique un ID de artefacto del proyecto Maven **que más tarde también se utilizará como nombre de adaptador**.
Por ejemplo:

   ```bash
   Define value for property 'artifactId': : SampleAdapter
   ```

5. Especifique la versión del proyecto Maven (el valor predeterminado es `1.0-SNAPSHOT`).
Por ejemplo:

   ```bash
   Define value for property 'version':  1.0-SNAPSHOT: : 1.0
   ```

6. Especifique un nombre de paquete del adaptador (el valor predeterminado es `groupId`).
Por ejemplo:

   ```bash
   Define value for property 'package':  com.mycompany: : com.mypackage
   ```

7. Especifique `y` para confirmar:


   ```bash
   Confirm properties configuration:
   groupId: com.mycompany
   artifactId: SampleAdapter
   version: 1.0
   package: com.mypackage
   archetypeVersion: 8.0.0
   Y: : y
   ```

#### Modalidad directa
{: #direct-mode-archetype }
Sustituya los parámetros con los valores reales y ejecute el mandato:


```bash
mvn archetype:generate -DarchetypeGroupId=com.ibm.mfp -DarchetypeArtifactId=<adapter type artifact ID> -DgroupId=<maven_project_groupid> -DartifactId=<maven_project_artifactid>  -Dpackage=<adapter_package_name>
```

> Para obtener más información sobre el mandato `archetype:generate` consulte la [Documentación de Maven](http://maven.apache.org/).

## Estructura de archivos
{: #file-structure }
Después de crear el adaptador el resultado será un proyecto Maven con una carpeta **src** y un archivo **pom.xml**:


![mvn-adapter](adapter-fs.png)

## Compilación y despliegue de adaptadores
{: #build-and-deploy-adapters }

### Compilación
{: #build }

* **Mediante {{ site.data.keys.mf_cli }}** - Ejecute el mandato `adapter build` desde la carpeta raíz del proyecto.

    
  ```bash
  mfpdev adapter build
  ```
    
* **Mediante Maven** - El adaptador se compila cada vez que ejecuta el mandato `install` para compilar el proyecto Maven.


  ```bash
  mvn install
  ```

### Compilación de todo
{: #build-all }
Si tiene varios adaptadores en una carpeta del sistema de archivos y desea compilarlos todos, utilice:


```bash
mfpdev adapter build all
```

La salida es un archivo de archivado **.adapter** que encontrará en la carpeta **target** de cada adaptador:


![java-adapter-result](adapter-result.png)

### Despliegue
{: #deploy }

1. El archivo **pom.xml** contiene las siguientes `properties`:

   ```xml
   <properties>
    	<!-- parameters for deploy mfpf adapter -->
    	<mfpfUrl>http://localhost:9080/mfpadmin</mfpfUrl>
    	<mfpfUser>admin</mfpfUser>
    	<mfpfPassword>admin</mfpfPassword>
    	<mfpfRuntime>mfp</mfpfRuntime>
   </properties>
   ```
   
   * Sustituya **localhost:9080** con su dirección IP y número de puerto de {{ site.data.keys.mf_server }}.

   * **Opcional**. Sustituya los valores predeterminados de **mfpfUser** y **mfpfPassword** con su nombre de usuario y contraseña de administrador.

   * **Opcional**. Sustituya el valor predeterminado de **mfpfRuntime** con el nombre de su tiempo de ejecución.

2. Ejecute el mandato deploy desde la carpeta raíz del proyecto:

 * **Utilización de {{ site.data.keys.mf_cli }}**:

   ```bash
   mfpdev adapter deploy -x
   ```
   
   La opción `-x` despliega el adaptador en la instancia de {{ site.data.keys.mf_server }} que se especifique en el archivo **pom.xml** del adaptador.
  
Si no se utiliza esta opción, la interfaz de línea de mandatos utilizará el servidor predeterminado especificado en los valores de la CLI.

    
   > Para obtener más información sobre opciones de despliegue de CLI, ejecute el mandato: `mfpdev help adapter deploy`.
   
 * **Utilización de Maven**:

   ```bash
   mvn adapter:deploy
   ```

### Despliegue de todo
{:# deploy-all }
Si tiene varios adaptadores en una carpeta del sistema de archivos y desea desplegarlos todos, utilice:


```bash
mfpdev adapter deploy all
```

> <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> **Sugerencia:**
También puede compilar y desplegar el adaptador con un único mandato:
`mvn install adapter:deploy`

### Despliegue en distintos tiempos de ejecución
{: #deploying-to-different-runtimes }
Si ejecuta varios tiempos de ejecución, consulte [Registro de aplicaciones y despliegue de adaptadores para distintos tiempos de ejecución](../../installation-configuration/production/server-configuration/#registering-applications-and-deploying-adapters-to-different-runtimes).


## Dependencias
{: #dependencies }
Para poder utilizar una biblioteca externa en su adaptador, siga una de las siguientes instrucciones sugeridas:


#### Adición de una dependencia local
{: #adding-a-local-dependency }

1. Añada una carpeta **lib** bajo la carpeta de proyecto Maven raíz y coloque en ella la biblioteca externa.

2. Añada la vía de acceso a la biblioteca bajo el elemento `dependencies` en el archivo **pom.xml** del proyecto Maven.
  

Por ejemplo:

```xml
<dependency>
<groupId>sample</groupId>
<artifactId>com.sample</artifactId>
<version>1.0</version>
<scope>system</scope>
<systemPath>${project.basedir}/lib/</systemPath>
</dependency>
```

#### Adición de una dependencia externa
{: #adding-an-external-dependency }

1. Busque dependencias en repositorios en línea como, por ejemplo, [The Central Repository](http://search.maven.org/).

2. Copie la información de la dependencia de POM y péguela bajo el elemento `dependencies` en el archivo **pom.xml** del proyecto Maven.


El siguiente ejemplo utiliza `cloudant-client artifactId`:

```xml
<dependency>
  <groupId>com.cloudant</groupId>
  <artifactId>cloudant-client</artifactId>
  <version>1.2.3</version>
</dependency>
```

> Consulte la documentación de Maven para obtener más información sobre las dependencias.


## Agrupación de adaptadores en un único proyecto Maven
{: #grouping-adapters-in-a-single-maven-project }

Si tiene varios adaptadores en su proyecto es posible que desee disponerlos bajo un único proyecto Maven.
La agrupación de adaptadores proporciona ventajas como, por ejemplo, la posibilidad de compilarlos todos, desplegarlos todos o de compartir dependencias.
También puede compilar y desplegar todos los adaptadores incluso si no están agrupados en un único proyecto Maven mediante los mandatos de CLI `mfpdev adapter build all` y `mfpdev adapter deploy all`.


Para agrupar los adaptadores que necesite:


1. Cree una carpeta raíz y denomínela, por ejemplo, como "GroupAdapters".
2. Coloque los proyectos de adaptador Maven en la misma.

3. Cree un archivo **pom.xml**:


   ```xml
   <project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    	xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">

    	<modelVersion>4.0.0</modelVersion>
    	<groupId>com.sample</groupId>
    	<artifactId>GroupAdapters</artifactId>
    	<version>1.0-SNAPSHOT</version>
    	<packaging>pom</packaging>

    	<modules>
				<module>Adapter1</module>
				<module>Adapter2</module>
    	</modules>

    	<properties>
    		<!-- parameters for deploy mfpf adapter -->
    		<mfpfUrl>http://localhost:9080/mfpadmin</mfpfUrl>
    		<mfpfUser>admin</mfpfUser>
    		<mfpfPassword>admin</mfpfPassword>
        <mfpfRuntime>mfp</mfpfRuntime>
    	</properties>

   <build>
        <plugins>
			<plugin>
				<groupId>com.ibm.mfp</groupId>
				<artifactId>adapter-maven-plugin</artifactId>
				<extensions>true</extensions>
			</plugin>
		</plugins>
   </build>

   </project>
   ```
   
  1. Defina un elemento **`groupId`** que desee

  2. Añada un elemento **`artifactId`** - el nombre de la carpeta raíz 
  3. Añada un elemento **`module`** para cada adaptador
  4. Añada el elemento **`build`**
  5. **Opcional**. Sustituya **localhost:9080** con su dirección IP y número de puerto de {{ site.data.keys.mf_server }} específicos.

  6. **Opcional**. Sustituya los valores predeterminados de **`mfpfUser`** y **`mfpfPassword`** con su nombre de usuario y contraseña de administrador.

  7. **Opcional**. Sustituya el valor predeterminado de **`mfpfRuntime`** con el nombre de su tiempo de ejecución.


4. Para [compilar o desplegar](#build-and-deploy-adapters) todos los adaptadores, ejecute los mandatos desde el proyecto "GroupAdapters" raíz.


## Descarga o despliegue de adaptadores mediante {{ site.data.keys.mf_console }}
{: #downloading-or-deploying-adapters-using-mobilefirst-operations-console}

1. Abra el navegador de su elección y cargue {{ site.data.keys.mf_console }} utilizando la dirección `http://<IP>:<PORT>/mfpconsole/`.  
2. Pulse el botón "Nuevo" junto a Adaptadores.
Tiene dos opciones para crear un adaptador:

 * Mediante Maven o {{ site.data.keys.mf_cli }} tal como se explicó con anterioridad.

 * Descargue un proyecto de adaptador de plantilla (paso 2).

3. Compile el adaptador mediante Maven o {{ site.data.keys.mf_cli }}.
4. Elija una de las siguientes maneras para subir el archivo **.adapter** generado que se puede encontrar en la carpeta de destino del proyecto del adaptador:

 * Pulse en el botón Desplegar adaptador (paso 5).

 * Arrastre y suelte el archivo en la pantalla del adaptador "Crear nuevo".


    ![Creación de un adaptador mediante la consola](Create_adapter_console.png)

5. Después de desplegar de forma satisfactoria el adaptador, se visualizará la página de detalles con los siguientes separadores:

 * Configuraciones - Contiene las propiedades que el archivo XML del adaptador define.
Aquí se pueden cambiar las configuraciones sin tener que realizar de nuevo el despliegue.

 * Recurso - Contiene una lista de los recursos de adaptador.

 * Archivos de configuración - Contiene datos de configuración del adaptador para ser utilizados en los entornos de DevOps.


## Actualización del proyecto Maven del adaptador
{: #updating-the-adapter-maven-project }

Para actualizar el proyecto Maven del adaptador con el último release, encuentre el **número de versión** de la API y los artefactos de plugin [en el repositorio central de Maven](http://search.maven.org/#search%7Cga%7C1%7Cibmmobilefirstplatformfoundation) buscando "IBM MobileFirst Platform", y actualice las siguientes propiedades en el archivo **pom.xml** del proyecto Maven del adaptador:


1. La versión de `adapter-maven-api`:


   ```xml
   <dependency>
      <groupId>com.ibm.mfp</groupId>
      <artifactId>adapter-maven-api</artifactId>
      <scope>provided</scope>
      <version>{{ site.data.keys.prod_maven_adapter_version }}</version>
   </dependency>
   ```
   
2. La versión de `adapter-maven-plugin`:


   ```xml
   <plugin>
      <groupId>com.ibm.mfp</groupId>
      <artifactId>adapter-maven-plugin</artifactId>
      <version>{{ site.data.keys.prod_maven_adapter_version }}</version>
      <extensions>true</extensions>
   </plugin>
   ```

## Funcionamiento fuera de línea
{: #working-offline }

Si no tiene acceso en línea al repositorio central de Maven, puede compartir los artefactos Maven de {{ site.data.keys.product }} en el repositorio interno de su organización.


1. [Visite la página de descargas]({{site.baseurl}}/downloads/) y descargue el instalador de {{ site.data.keys.mf_dev_kit_full }}.

2. Inicie {{ site.data.keys.mf_server }} y en un navegador, cargue {{ site.data.keys.mf_console }} desde el siguiente URL:
`http://<your-server-host:server-port>/mfpconsole`.
3. Pulse **Centro de descargas**.
Bajo **Herramientas → Arquetipos de adaptador**, pulse **Descargar**.
Se descargará el archivador **mfp-maven-central-artifacts-adapter.zip**.

4. Añada los arquetipos de adaptador y las comprobaciones de seguridad al repositorio Maven interno ejecutando el script **install.sh** para Linux y Mac o el script **install.bat** para Windows.

5. Se necesitan los siguientes archivos JAR para adapter-maven-api.
Asegúrese de que están ubicados en la carpeta **.m2** local de los desarrolladores o en el repositorio Maven de su organización.
Puede descargarlos desde el The Central Repository.

    * javax.ws.rs:javax.ws.rs-api:2.0
    * javax:javaee-web-api:6.0
    * org.apache.httpcomponents:httpclient:4.3.4
    * org.apache.httpcomponents:httpcore:4.3.2
    * commons-logging:commons-logging:1.1.3
    * javax.xml:jaxp-api:1.4.2
    * org.mozilla:rhino:1.7.7
    * io.swagger:swagger-annotations:1.5.6
    * com.ibm.websphere.appserver.api:com.ibm.websphere.appserver.api.json:1.0
    * javax.servlet:javax.servlet-api:3.0.1

## Guías de aprendizaje con las que continuar 
{: #tutorials-to-follow-next }

* [Aprender sobre adaptadores Java](../java-adapters/)
* [Aprender sobre adaptadores JavaScript](../javascript-adapters/)
* [Desarrollo de adaptadores en entornos de desarrollo integrado (IDE)](../developing-adapters/)
* [Pruebas y depuración de adaptadores](../testing-and-debugging-adapters/)
* [Revisar todas las guías de aprendizaje de adaptadores](../#tutorials-to-follow-next)
