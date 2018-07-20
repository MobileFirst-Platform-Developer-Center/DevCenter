---
layout: tutorial
title: Uso del servicio de Mobile Foundation en IBM Cloud
breadcrumb_title: Setting up Mobile Foundation service
relevantTo: [ios,android,windows,javascript]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
Esta guía de aprendizaje proporciona instrucciones paso a paso para configurar una instancia de  {{ site.data.keys.mfound_server }} en IBM Cloud utilizando el servicio {{ site.data.keys.mf_bm_full }} (**{{ site.data.keys.mf_bm_short }}**).  
{{ site.data.keys.mf_bm_short }} es un servicio de IBM Cloud que permite crear de forma rápida y fácil entornos de desarrollador o producción escalables de Mobile Foundation v8.0 en el **tiempo de ejecución de Liberty for Java**.

El servicio de {{ site.data.keys.mf_bm_short }} ofrece las siguientes opciones de planes:

1. **Desarrollador**: Este plan proporciona un {{ site.data.keys.mfound_server }} como una aplicación Cloud Foundry en un tiempo de ejecución de Liberty for Java. Los cargos relacionados con Liberty for Java se facturan aparte y no se incluyen en este plan. El plan no permite utilizar las bases de datos externas y está restringido para fines de desarrollo y prueba. La instancia del *plan de desarrollador* del servidor de {{ site.data.keys.mf_bm_short }}le permite registrar cualquier número de aplicaciones móviles para desarrollo y pruebas, pero limita el número de dispositivos conectados a 10 al día. Este plan también incluye una instancia de servicio de {{ site.data.keys.mf_analytics_service }}. Si la utilización supera las concesiones del nivel gratuito de Mobile Analytics, podrían aplicarse cargos al plan básico de Mobile Analytics.

    > **Nota:** El plan del desarrollador no ofrece una base de datos persistente, por lo tanto, asegúrese de que realiza una copia de seguridad, como se describe en la sección [Resolución de problemas](#troubleshooting).

2. **Profesional por dispositivo**: Este plan permite a los usuarios crear, probar y ejecutar aplicaciones en producción. Se factura en función del número de dispositivos cliente conectados al día. Este plan da soporte a despliegues de gran tamaño y a la alta disponibilidad. Este plan requiere que tenga una instancia de servicio de IBM Db2 on Cloud (que ahora se denomina Db2 Hosted), que se crea y se factura por separado. Este plan suministra un servidor Mobile Foundation en Liberty for Java, empezando con un mínimo de 2 nodos de 1 GB. Los cargos relacionados con Liberty for Java se facturan aparte y no se incluyen como parte de este plan. Opcionalmente, puede añadir una instancia de servicio de Mobile Analytics. El servicio Mobile Analytics se factura de forma separada.

3. **Profesional 1 de aplicación**: Este plan permite a los usuarios crear y gestionar una aplicación móvil individual con un precio predecible, independientemente del número de dispositivos o de usuarios de la aplicación móvil. La aplicación móvil individual puede ser de varios tipos, tales como iOS, Android, Windows y Mobile Web. Este plan suministra un servidor Mobile Foundation en un entorno escalable como una aplicación Cloud Foundry en Liberty for Java, empezando con un mínimo de 2 nodos de 1 GB. Los cargos relacionados con Liberty for Java se facturan aparte y no se incluyen como parte de este plan. Este plan también requiere una instancia de servicio de IBM Db2 on Cloud (Db2 Hosted), que se crea y se factura por separado. Opcionalmente, puede añadir una instancia de servicio {{ site.data.keys.mf_analytics_service }} pulsando el botón **Añadir Analytics**. El servicio Mobile Analytics se factura de forma separada.

4. **Desarrollador Pro**: Este plan proporciona un {{ site.data.keys.mfound_server }} como una aplicación Cloud Foundry en un tiempo de ejecución de  Liberty for Java y permite a los usuarios desarrollar y probar cualquier número de aplicaciones móviles. Este plan requiere que tenga una instancia de servicio de **Db2 Hosted**. La instancia de servicio de Db2 on Cloud se crea y se factura por separado. Este plan está limitado por tamaño y está pensado para ser utilizado en actividades de desarrollo y prueba y no en producción. Los cargos dependen del tamaño total de su entorno. Opcionalmente, puede añadir un servicio {{ site.data.keys.mf_analytics_service }} pulsando el botón **Añadir Analytics**.
>_El plan **Desarrollador Pro** está ahora en desuso._

5. **Profesional por capacidad:** Este plan permite a los usuarios crear, probar y ejecutar cualquier número de aplicaciones en producción, independientemente del número de usuarios móviles o dispositivos. Da soporte a despliegues de gran tamaño y a la alta disponibilidad. El plan requiere que tenga una instancia de servicio de **Db2 Hosted**. La instancia de servicio de Db2 Hosted se crea y se factura por separado. Los cargos dependen del tamaño total de su entorno. Opcionalmente, puede añadir un servicio {{ site.data.keys.mf_analytics_service }} pulsando el botón **Añadir Analytics**.
>_El plan **Profesional por capacidad** está ahora en desuso._

> [Consulte los detalles de servicio](https://console.bluemix.net/catalog/services/mobile-foundation/) para obtener más información acerca de los planes disponibles y su facturación.

#### Ir a:
{: #jump-to}
* [Configuración del servicio {{ site.data.keys.mf_bm_short }}](#setting-up-the-mobile-foundation-service)
* [Utilización del servicio {{ site.data.keys.mf_bm_short }}](#using-the-mobile-foundation-service)
* [Configuración del servidor](#server-configuration)
* [Configuración avanzada del servidor](#advanced-server-configuration)
* [Añadir soporte de Analytics](#adding-analytics-support)
* [Eliminar soporte de Analytics](#removing-analytics-support)
* [Aplicar arreglos de {{ site.data.keys.mfound_server }}](#applying-mobilefirst-server-fixes)
* [Acceso a los registros del servidor](#accessing-server-logs)
* [Resolución de problemas](#troubleshooting)
* [Lectura adicional](#further-reading)

## Configuración del servicio {{ site.data.keys.mf_bm_short }}
{: #setting-up-the-mobile-foundation-service }
Para configurar los planes disponibles, en primer lugar siga estos pasos:

1. Vaya a [bluemix.net](http://bluemix.net), inicie sesión y pulse **Catálogo**.
2. Busque **Mobile Foundation** y pulse la opción de mosaico resultante.
3. *Opcional*. Escriba un nombre personalizado para la instancia de servicio o utilice el nombre predeterminado que se proporciona.
4. Seleccione el plan de precios que desea y, a continuación, pulse **Crear**.

    <img class="gifplayer" alt="Creación de una instancia de servicio de {{ site.data.keys.mf_bm_short }} " src="mf-create-new.png"/>

### Configuración del plan de *desarrollador*
{: #setting-up-the-developer-plan }

La creación del servicio {{ site.data.keys.mf_bm_short }} crea   {{ site.data.keys.mfound_server }}.
  * Puede acceder y trabajar de forma instantánea con {{ site.data.keys.mfound_server }}.
  * Para acceder a {{ site.data.keys.mfound_server }} con CLI necesita las credenciales que están disponibles cuando pulsa **Credenciales de servicio** en el panel de navegación de la consola de IBM Cloud.

  ![Imagen de {{ site.data.keys.mf_bm_short }} ](overview-page-new-2.png)

### Configuración de los planes *Profesional de una aplicación* y *Profesional por dispositivo*
{: #setting-up-the-professional-1-application-n-professional-per-device-plan }
1. Estos planes requieren una [instancia de base de datos Db2 Hosted](https://console.bluemix.net/catalog/services/db2-hosted/) externa.

    * Si ya tiene una instancia de servicio Db2 Hosted, seleccione la opción **Utilizar servicio existente** y proporcione sus credenciales:

        ![Imagen de la configuración de {{ site.data.keys.mf_bm_short }} ](create-db2-hosted-instance-existing.png)

    * Si actualmente no tiene una instancia de servicio Db2 Hosted, seleccione la opción **Crear nuevo servicio** y siga las instrucciones de la pantalla:

       ![Imagen de la configuración de {{ site.data.keys.mf_bm_short }} ](create-db2-hosted-instance-new.png)

2. Inicie {{ site.data.keys.mfound_server }}.
    - Puede conservar la configuración del servidor en su nivel básico y pulsar **Iniciar servidor básico**, o
    - Actualizar la configuración del servidor en el separador [Valores](#advanced-server-configuration) y pulsar **Iniciar el servidor avanzado**.

    Durante este paso se genera una aplicación Cloud Foundry para el servicio {{ site.data.keys.mf_bm_short }} y se inicializa el entorno Mobile Foundation. Este paso puede tardar entre 5 y 10 minutos.

3. Con la instancia preparada, puede [utilizar el servicio](#using-the-mobile-foundation-service).

    ![Imagen de la configuración de {{ site.data.keys.mf_bm_short }} ](overview-page.png)

## Utilización del servicio {{ site.data.keys.mf_bm_short }}
{: #using-the-mobile-foundation-service }

Cuando se ejecuta {{ site.data.keys.mfound_server }} verá el panel de control siguiente:

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

  *Creación del certificado de almacén de confianza para el servicio Mobile Foundation:*

  * Utilice *cacerts* del JDK Java 8 del fixpack más reciente de IBM Java u Oracle Java.

  * Importe el certificado adicional en el almacén de confianza mediante el mandato siguiente:
    ```
    keytool -import -file firstCA.cert -alias firstCA -keystore truststore.jks
    ```

  >**Nota**: puede optar por crear su propio almacén de confianza, pero el certificado predeterminado debe estar disponible para que el servicio Mobile Foundation funcione correctamente

* Configuración de {{ site.data.keys.mf_analytics_service }}
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

<!--
##  Switching from Analytics deployed with IBM Containers to Analytics service
{: #switching-from-analytics-container-to-analytics-service}

>**Note**: Deleting {{ site.data.keys.mf_analytics_service }} will remove all available analytics data. This data will not be available in the new {{ site.data.keys.mf_analytics_service }} instance.

User can delete current container by clicking on **Delete Analytics** button from service dashboard. This will remove the analytics instance and enable the **Add Analytics** button, which the user can click to add a new {{ site.data.keys.mf_analytics_service }} service instance.
-->
## Aplicar arreglos de {{ site.data.keys.mfound_server }}
{: #applying-mobilefirst-server-fixes }
Las actualizaciones de los servicios de {{ site.data.keys.mf_bm }} se aplican de forma automática sin intervención humana, salvo aceptar que se lleve a cabo la actualización. Cuando está disponible una actualización, en la página Panel de control del servicio se muestra un banner con las instrucciones y los botones de acción.

## Acceso a los registros del servidor
{: #accessing-server-logs }
Para acceder a los registros del servidor, siga los pasos siguientes.

**Escenario 1:**

1. Configure su máquina host.<br/>
   Para gestionar la app IBM Cloud Cloud Foundry, debe instalar Cloud Foundry CLI.<br/>
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

1. En **Tiempo de ejecución → SSH**, seleccione su instancia de servicio en el recuadro combinado (los ID de instancia comienzan por **0**).
2. Vaya a cada instancia de la consola y abra el archivo `/home/vcap/app/wlp/usr/servers/mfp/configDropins/overrides/tracespec.xml` con el editor vi.
3. Actualice la siguiente sentencia de rastreo: `traceSpecification="=info:com.ibm.mfp.*=all"` y guarde el archivo.

Ahora el archivo **trace.log** está disponible en la ubicación especificada arriba.

<img class="gifplayer" alt="Registros del servidor para el servicio {{ site.data.keys.mf_bm_short }} " src="mf-trace-setting.png"/>

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
Ahora que la instancia de {{ site.data.keys.mfound_server }} está activa y en ejecución,

* Familiarícese con  [{{ site.data.keys.mf_console }}](../../product-overview/components/console).
* Obtenga experiencia con Mobile Foundation con estas [Guías de aprendizaje de inicio rápido](../../quick-start).
* Lea todas las [guías de aprendizaje disponibles](../../all-tutorials/).
