---
layout: tutorial
title: Utilización del servicio Mobile Foundation en Bluemix
breadcrumb_title: Servicio Mobile Foundation
relevantTo: [ios,android,windows,javascript]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
Esta guía de aprendizaje proporciona instrucciones paso a paso para configurar una instancia de  {{ site.data.keys.mf_server }} en Bluemix utilizando el servicio {{ site.data.keys.mf_bm_full }} (**{{ site.data.keys.mf_bm_short }}**).   
{{ site.data.keys.mf_bm_short }} es un servicio de Bluemix que permite crear de forma rápida y fácil entornos de desarrollador o producción escalables de MobileFirst Foundation v8.0 en el tiempo de ejecución de **Liberty for Java**.

El servicio de {{ site.data.keys.mf_bm_short }} ofrece las siguientes opciones de planes:

1. **Desarrollador**: Este plan proporciona un {{ site.data.keys.mf_server }} como una aplicación Cloud Foundry en un tiempo de ejecución de Liberty for Java. El plan no permite utilizar las bases de datos externas ni definir varios nodos *y está restringido únicamente para fines de desarrollos y prueba*. La instancia del servidor le permite registrar cualquier número de aplicaciones móviles para desarrollo y pruebas. De forma predeterminada, en este plan se añade el servicio de {{ site.data.keys.mf_analytics_service }}.

    > **Nota:** El plan del desarrollador no ofrece una base de datos persistente, por lo tanto, asegúrese de que realiza una copia de seguridad, como se describe en la sección [Resolución de problemas](#troubleshooting).

2. **Desarrollador Pro**: Este plan proporciona un {{ site.data.keys.mf_server }} como una aplicación Cloud Foundry en un tiempo de ejecución de  Liberty for Java y permite a los usuarios desarrollar y probar cualquier número de aplicaciones móviles. El plan requiere que tenga en vigor un **servicio dashDB OLTP**. El servicio dashDB se crea y factura por separado. Este plan está limitado por tamaño y está pensado para ser utilizado en actividades de desarrollo y prueba y no en producción. Los cargos dependen del tamaño total de su entorno. Opcionalmente, puede añadir un servicio {{ site.data.keys.mf_analytics_service }} pulsando el botón **Añadir Analytics**.

3. **Profesional por capacidad:** Este plan permite a los usuarios crear, probar y ejecutar cualquier número de aplicaciones en producción, independientemente del número de usuarios móviles o dispositivos. Da soporte a despliegues de gran tamaño y a la alta disponibilidad. El plan requiere que tenga en vigor un **servicio dashDB OLTP**. El servicio dashDB se crea y factura por separado. Los cargos dependen del tamaño total de su entorno. Opcionalmente, puede añadir un servicio {{ site.data.keys.mf_analytics_service }} pulsando el botón **Añadir Analytics**.

4. **Profesional 1 de aplicación**: Este plan proporciona un {{ site.data.keys.mf_server }} en una aplicación Cloud Foundry escalable para un tiempo de ejecución de Liberty for Java. El plan también requiere un servicio de base de datos dashDB, que se crea y factura por separado. El plan permite a los usuarios crear y gestionar una aplicación móvil individual. Una aplicación móvil individual puede ser de varios tipos, tales como iOS, Android, Windows y Mobile Web. Opcionalmente, puede añadir un servicio {{ site.data.keys.mf_analytics_service }} pulsando el botón **Añadir Analytics**.

> [Consulte la página de servicio en Bluemix.net](https://console.ng.bluemix.net/catalog/services/mobile-foundation/) para obtener más información acerca de los planes disponibles y su facturación.

#### Ir a:
{: #jump-to}
* [Configuración del servicio {{ site.data.keys.mf_bm_short }}](#setting-up-the-mobile-foundation-service)
* [Utilización del servicio {{ site.data.keys.mf_bm_short }}](#using-the-mobile-foundation-service)
* [Configuración del servidor](#server-configuration)
* [Configuración avanzada del servidor](#advanced-server-configuration)
* [Añadir soporte de Analytics](#adding-analytics-support)
* [Eliminar soporte de Analytics](#removing-analytics-support)
* [Cambiar de Analytics desplegado con IBM Containers al servicio Analytics](#switching-from-analytics-container-to-analytics-service)
* [Aplicar arreglos de {{ site.data.keys.mf_server }}](#applying-mobilefirst-server-fixes)
* [Acceso a los registros del servidor](#accessing-server-logs)
* [Resolución de problemas](#troubleshooting)
* [Lectura adicional](#further-reading)

## Configuración del servicio {{ site.data.keys.mf_bm_short }} 
{: #setting-up-the-mobile-foundation-service }
Para configurar los planes disponibles, en primer lugar siga estos pasos: 

1. Cargue [bluemix.net](http://bluemix.net), inicie sesión y pulse **Catálogo**.
2. Busque **Mobile Foundation** y pulse la opción de mosaico resultante. 
3. *Opcional*. Escriba un nombre personalizado para la instancia de servicio o utilice el nombre predeterminado que se proporciona. 
4. Seleccione el plan de precios que desea y, a continuación, pulse **Crear**.

    <img class="gifplayer" alt="Creación de una instancia de servicio de {{ site.data.keys.mf_bm_short }} " src="service-creation.png"/>

### Configuración del plan de *desarrollador* 
{: #setting-up-the-developer-plan }

La creación del servicio {{ site.data.keys.mf_bm_short }} crea   {{ site.data.keys.mf_server }}.
  * Puede acceder y trabajar de forma instantánea con {{ site.data.keys.mf_server }}.
  * Para acceder a {{ site.data.keys.mf_server }} con CLI necesita las credenciales que están disponibles cuando pulsa **Credenciales de servicio** en el panel de navegación de la consola de Bluemix. 

  ![Imagen de {{ site.data.keys.mf_bm_short }} ](overview-page-new.png)

### Configuración de los planes *Desarrollador Pro*, *Profesional por capacidad* y *Profesional 1 de aplicación*
{: #setting-up-the-developer-pro-professional-percapacity-and-professional-1-application-plans }
1. Estos planes requieren una [instancia de base de datos dashDB Transactional](https://console.ng.bluemix.net/catalog/services/dashdb/).

    > Obtenga más información acerca de cómo [configurar una instancia de base de datos dashDB]({{site.baseurl}}/blog/2016/11/02/using-dashdb-service-with-mobile-foundation/).

    Si ya tiene una instancia de servicio dashDB (DashDB Enterprise Transactional 2.8.500 o Enterprise Transactional 12.128.1400), seleccione la opción **Utilizar servicio existente** y proporcione sus credenciales: 

    ![Imagen de la configuración de {{ site.data.keys.mf_bm_short }} ](create-dashdb-instance-existing.png)

    1.b. Si actualmente no tiene una instancia de servicio dashDB, seleccione la opción **Crear nuevo servicio** y siga las instrucciones de la pantalla:

    ![Imagen de la configuración de {{ site.data.keys.mf_bm_short }} ](create-dashdb-instance-new.png)

2. Inicie {{ site.data.keys.mf_server }}.
    - Puede conservar la configuración del servidor en su nivel básico y pulsar **Iniciar servidor básico**, o
    - Actualizar la configuración del servidor en el separador [Valores](#advanced-server-configuration) y pulsar **Iniciar el servidor avanzado**.

    Durante este paso se genera una aplicación Cloud Foundry para el servicio {{ site.data.keys.mf_bm_short }} y se inicializa el entorno MobileFirst Foundation. Este paso puede tardar entre 5 y 10 minutos.

3. Con la instancia preparada, puede [utilizar el servicio](#using-the-mobile-foundation-service).

    ![Imagen de la configuración de {{ site.data.keys.mf_bm_short }} ](overview-page.png)

## Utilización del servicio {{ site.data.keys.mf_bm_short }} 
{: #using-the-mobile-foundation-service }

Cuando se ejecuta {{ site.data.keys.mf_server }} verá el panel de control siguiente:

![Imagen de la configuración de {{ site.data.keys.mf_bm_short }} ](service-dashboard.png)

Pulse **Añadir Analytics** para  añadir soporte de {{ site.data.keys.mf_analytics_service }} a su instancia de servicio.
Obtenga más información en la sección [Añadir soporte de Analytics](#adding-analytics-support).

Pulse **Iniciar consola** para abrir {{ site.data.keys.mf_console }}. El nombre de usuario predeterminado es "admin" y se puede detectar la contraseña pulsando el icono de "ojo". 

![Imagen de la configuración de {{ site.data.keys.mf_bm_short }} ](dashboard.png)

### Configuración del servidor
{: #server-configuration }
La instancia de servidor básica consta de: 

* Un nodo único (tamaño de servidor: "pequeño")
* 1GB de memoria
* 2GB de capacidad de almacenamiento

### Configuración de servidor avanzada
{: #advanced-server-configuration }
Con el separador **Valores**, puede personalizar adicionalmente la instancia del servidor con 

* Combinaciones de nodos, memoria y almacenamiento variables 
* Contraseña admin de {{ site.data.keys.mf_console }}
* Claves LTPA
* Configuración JNDI
* Registro de usuarios
* Almacén de confianza
* Configuración de {{ site.data.keys.mf_analytics_service }}
* Selección de base de datos DashDB Enterprise Transactional 2.8.500 o Enterprise Transactional 12.128.1400 (disponible en el plan *Profesional 1 de aplicación*)
* VPN

![Imagen de la configuración de {{ site.data.keys.mf_bm_short }} ](advanced-server-configuration.png)

## Añadir soporte de {{ site.data.keys.mf_analytics_service }} 
{: #adding-analytics-support }
Puede añadir soporte de {{ site.data.keys.mf_analytics_service }} a su instancia de servicio de {{ site.data.keys.mf_bm_short }} pulsando **Añadir Analytics** en la página Panel de control del servicio. Esta acción proporciona  una instancia de servicio de {{ site.data.keys.mf_analytics_service }}.

>Cuando crea o vuelve a crear la instancia del plan de servicio **Desarrollador** del servicio {{ site.data.keys.mf_bm_short }}, de forma predeterminada, se añade la instancia de servicio de {{ site.data.keys.mf_analytics_service }}.

<!--* When using the **Developer** plan this action will also automatically hook the {{ site.data.keys.mf_analytics_service }} service instance to your {{ site.data.keys.mf_server }} instance.  
* When using the **Developer Pro**, **Professional Per Capacity** or **Professional 1 Application** plans, this action will require additional input from you to select: amount of available Nodes, available Memory and a storage volume. -->

Una vez finalizada la operación, vuelva a cargar la página de {{ site.data.keys.mf_console }} en su navegador para acceder a {{ site.data.keys.mf_analytics_service_console }}.  

> Obtenga más información acerca de {{ site.data.keys.mf_analytics_service }} en la categoría [{{ site.data.keys.mf_analytics_service }}](../../analytics).

##  Eliminar soporte de {{ site.data.keys.mf_analytics_service }}
{: #removing-analytics-support}

Puede eliminar el soporte de {{ site.data.keys.mf_analytics_service }} de su instancia de servicio de {{ site.data.keys.mf_bm_short }} pulsando **Suprimir Analytics** en la página Panel de control del servicio. Esta acción suprime la instancia de servicio de {{ site.data.keys.mf_analytics_service }}.

Una vez finalizada la operación, vuelva a cargar la página de {{ site.data.keys.mf_console }} en el navegador.

##  Cambiar de Analytics desplegado con IBM Containers al servicio Analytics
{: #switching-from-analytics-container-to-analytics-service}

>**Nota**: Si suprime {{ site.data.keys.mf_analytics_service }}, se eliminarán todos los datos de Analytics disponibles. Estos datos no estarán disponibles en la nueva instancia de {{ site.data.keys.mf_analytics_service }}.

El usuario puede suprimir el contenedor actual pulsando el botón **Suprimir Analytics** en el panel de control de servicio. Esto eliminará la instancia de Analytics y habilitará el botón **Añadir Analytics** que el usuario puede pulsar para añadir una nueva instancia de servicio de {{ site.data.keys.mf_analytics_service }}.

## Aplicar arreglos de {{ site.data.keys.mf_server }}
{: #applying-mobilefirst-server-fixes }
Las actualizaciones de los servicios de {{ site.data.keys.mf_bm }} se aplican de forma automática sin intervención humana, salvo aceptar que se lleve a cabo la actualización. Cuando está disponible una actualización, en la página Panel de control del servicio se muestra un banner con las instrucciones y los botones de acción. 

## Acceso a los registros del servidor 
{: #accessing-server-logs }
Para acceder a los registros del servidor, siga los pasos siguientes. 

**Escenario 1:**

1. Configure su máquina host. <br/>
   Para gestionar la aplicación Bluemix Cloud Foundry, debe instalar Cloud Foundry CLI. <br/>
   Instale [Cloud Foundry CLI](https://github.com/cloudfoundry/cli/releases).
2. Abra el terminal e inicie sesión en su *Organización* y *Espacio* mediante `cf login`.
3. Ejecute el mandato siguiente en CLI:
```bash
  cf ssh <mfp_Appname> -c "/bin/cat logs/messages.log" > messages.log
```
4. Solo si está habilitado el rastreo, ejecute el mandato siguiente: 
```bash
cf ssh <mfp_Appname> -c "/bin/cat logs/trace.log" > trace.log
 ```

**Escenario 2:**      

* Para acceder a los registros del servidor, abra la barra de navegación lateral y pulse **Aplicaciones → Panel de control → Cloud Foundry Apps**.
* Seleccione su aplicación y pulse **Registros → Ver en Kibana**.
* Seleccione y copie los mensajes de registro. 


#### Rastreo
{: #tracing }
Para habilitar el rastreo de modo que puedan verse los mensajes de nivel DEBUG del archivo **trace.log**:

1. En **Tiempo de ejecución → Memoria e instancias**, seleccione su instancia de servicio (los ID de instancia comienzan por **0**).
2. Pulse la opción de acción **Rastrear**.
3. Especifique la siguiente sentencia de rastreo: `com.ibm.mfp.*=all` y pulse **Enviar rastreo**.

Ahora el archivo **trace.log** está disponible en la ubicación especificada arriba.

<img class="gifplayer" alt="Registros del servidor para el servicio {{ site.data.keys.mf_bm_short }} " src="server-logs.png"/>

## Resolución de problemas
{: #troubleshooting }
El plan Desarrollador no ofrece una base de datos persistente, lo que puede provocar que se pierdan datos. Para solucionar rápidamente estos casos, asegúrese de que sigue los métodos recomendados:

* Cada vez que realiza cualquiera de las acciones siguientes en el extremo del servidor: 
    * Despliegue un adaptador o actualizar cualquier configuración de adaptador o valor de propiedad
    * Realice cualquier configuración de seguridad, tal como la correlación de ámbitos o similar 

    Ejecute el mandato siguiente en la línea de mandatos para descargar su configuración en un archivo .zip: 

  ```bash
  $curl -X GET -u admin:admin -o export.zip http://<App Name>.mybluemix.net/mfpadmin/management-apis/2.0/runtimes/mfp/export/all
  ```

* En el caso de que vuelva a crear su servidor o pierda su configuración, ejecute lo siguiente en la línea de mandatos para importar la configuración al servidor: 

  ```bash
  $curl -X POST -u admin:admin -F file=@./export.zip http://<App Name>.mybluemix.net/mfpadmin/management-apis/2.0/runtimes/mfp/deploy/multi
  ```

## Lectura adicional 
{: #further-reading }
Ahora que la instancia de {{ site.data.keys.mf_server }} está activa y en ejecución,

* Familiarícese con  [{{ site.data.keys.mf_console }}](../../product-overview/components/console).
* Obtenga experiencia con MobileFirst Foundation con estas [Guías de aprendizaje de inicio rápido](../../quick-start).
* Lea todas las [guías de aprendizaje disponibles](../../all-tutorials/).
