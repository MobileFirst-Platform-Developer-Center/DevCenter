---
layout: tutorial
title: Guía de configuración de MobileFirst Analytics Server
breadcrumb_title: Configuration Guide
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
Es necesaria alguna configuración para {{ site.data.keys.mf_analytics_server }}. Algunos de los parámetros de configuración se aplican a un único nodo, y algunos se aplican a todo el clúster, tal como se indica.

#### Ir a
{: #jump-to }

* [Propiedades de configuración](#configuration-properties)
* [Copia de seguridad de los datos de análisis](#backing-up-analytics-data)
* [Gestión de clústeres y Elasticsearch](#cluster-management-and-elasticsearch)

### Propiedades
{: #properties }
Para obtener una lista completa de propiedades de configuración y cómo establecerlas en el servidor de aplicaciones, consulte [Configuración de propiedades](#configuration-properties).

* La propiedad **discovery.zen.minimum\_master\_nodes** se debe establecer en **células((número de nodos elegibles maestros en el clúster / 2) + 1)** para evitar el síndrome de cerebro dividido.
    * Los nodos de Elasticsearch en un clúster que son elegibles por el maestro deben establecer un quórum para decidir qué nodo elegible por el maestro es el maestro.
    * Si añade un nodo elegible maestro en el clúster, el número de nodos elegibles por el maestro cambia y, por lo tanto, el valor debe cambiar. Debe modificar el valor si se introducen nuevos nodos elegibles por el maestro en el clúster. Para obtener más información sobre cómo gestionar el clúster, consulte [Gestión de clústeres y Elasticsearch](#cluster-management-and-elasticsearch).
* Dé un nombre al clúster estableciendo la propiedad **clustername** en todos los nodos.
    * Ponga un nombre al clúster para impedir que una instancia del desarrollador de Elasticsearch se una accidentalmente a un clúster que está utilizando un nombre predeterminado.
* Dé un nombre a cada nodo estableciendo la propiedad **nodename** en cada nodo.
    * De forma predeterminada, Elasticsearch pone nombre a cada nodo después de un carácter Marvel aleatorio, y el nombre del nodo es distinto en cada reinicio de nodo.
* Declare explícitamente la vía de acceso al sistema de archivos en el directorio de datos estableciendo la propiedad **datapath** en cada nodo.
* Declare explícitamente los nodos maestros dedicados estableciendo la propiedad **masternodes** en cada nodo.

### Valores de recuperación de clúster
{: #cluster-recovery-settings }
Una vez que haya escalado a un clúster de varios nodos, es posible que encuentre que es necesario un reinicio del clúster completo ocasional. Cuando sea necesario un reinicio de clúster completo, debe tener en cuenta los valores de recuperación. Si el clúster tiene 10 nodos, y a medida que se activa el clúster, un nodo a la vez, el nodo maestro da por supuesto que necesita iniciar los datos de equilibrio de carga inmediatamente tras la llegada de cada nodo en el clúster. Si se permite que el maestro se comporte de esta forma, se necesitará mucho reequilibrado innecesario. Debe configurar los valores del clúster para esperar a que se una al clúster un número mínimo de nodos para que se permita al maestro empezar a dar instrucciones a los nodos para reequilibrar. Puede reducir los reinicios de clúster de horas a minutos.

* La propiedad **gateway.recover\_after\_nodes** se debe establecer en la preferencia para impedir que Elasticsearch inicie un reequilibrado hasta que el número especificado de nodos en el clúster está activo y se haya unido. Si el clúster tiene 10 nodos, un valor de 8 para la propiedad **gateway.recover\_after\_nodes** podría ser un valor razonable.
* La propiedad **gateway.expected\_nodes** se debe establecer en el número de nodos que se espera que estén en el clúster. En este ejemplo, el valor para la propiedad **gateway.expected_nodes** es 10.
* La propiedad **gateway.recover\_after\_time** se debe establecer para indicar al maestro que espere para enviar instrucciones reequilibradas hasta después de que haya transcurrido el tiempo establecido desde el inicio de la modalidad maestra.

La combinación de los valores anteriores significa que Elasticsearch espera que esté presente el valor de los nodos **gateway.recover\_after\_nodes**. A continuación, comenzará a recuperarse una vez que el valor de **gateway.recover\_after\_time** minutos o que el valor de **gateway.expected\_nodes** nodos se hayan unido al clúster, lo que ocurra primero.

### Qué no hacer
{: #what-not-to-do }
* No ignorar el clúster de producción.
    * Los clústeres necesitan supervisión y cuidado. Hay disponibles muchas herramientas de supervisión de Elasticsearch buenas dedicadas a la tarea.
* No utilice el almacenamiento conectado a la red (NAS) para el valor de **datapath**. NAS ofrece más latencia, y punto único de anomalía. Utilice siempre los discos de hosts locales.
* Evite clústeres que abarcan centros de datos y evite definitivamente clústeres que abarcan grandes distancias geográficas. La latencia entre nodos es un cuello de botella de rendimiento severo.
* Desplegar su propia solución de gestión de configuración de clúster. Hay disponibles muchas buenas soluciones de gestión de la configuración, como por ejemplo Puppet, Chef y Ansible.

## Propiedades de configuración
{: #configuration-properties }
{{ site.data.keys.mf_analytics_server }} puede iniciarse satisfactoriamente sin ninguna configuración adicional.

La configuración se realiza a través de las propiedades de JNDI en {{ site.data.keys.mf_server }} y {{ site.data.keys.mf_analytics_server }}. Además, {{ site.data.keys.mf_analytics_server }} da soporte al uso de variables de entorno para controlar la configuración. Las variables de entorno prevalecen sobre las propiedades JNDI.

La aplicación web de tiempo de ejecución de análisis debe reiniciarse para que surtan efecto los cambios realizados en estas propiedades. No es necesario reiniciar todo el servidor de aplicaciones.

Para establecer una propiedad JNDI en WebSphere Application Server Liberty, añada una etiqueta al archivo **server.xml** como se indica a continuación.

```xml
<jndiEntry jndiName="{PROPERTY NAME}" value="{PROPERTY VALUE}}" />
```

Para establecer una propiedad JNDI en Tomcat, añada una etiqueta al archivo context.xml como se indica a continuación.

```xml
<Environment name="{PROPERTY NAME}" value="{PROPERTY VALUE}" type="java.lang.String" override="false" />
```

Las propiedades JNDI en WebSphere Application Server están disponibles como variables de entorno.

* En la consola de WebSphere Application Server, seleccione **Aplicaciones → Tipos de aplicaciones → Aplicaciones empresariales de WebSphere**.
* Seleccione la aplicación **Servicio de administración de {{ site.data.keys.product_adj }}**.
* En **Propiedades de módulo web**, pulse **Entradas de entorno para módulos web** para visualizar las propiedades de JNDI.

#### {{ site.data.keys.mf_server }}
{: #mobilefirst-server }
La tabla siguiente muestra las propiedades que se pueden establecer en {{ site.data.keys.mf_server }}.

| Propiedad                           | Descripción                                           | Valor predeterminado |
|------------------------------------|-------------------------------------------------------|---------------|
| mfp.analytics.console.url          | Establezca esta propiedad en el URL de {{ site.data.keys.mf_analytics_console }}. Por ejemplo, http://hostname:port/analytics/console. El establecimiento de esta propiedad permite el icono de análisis de {{ site.data.keys.mf_console }}. | None |
| mfp.analytics.logs.forward         | Si esta propiedad se establece en true, los registros del servidor que estén registrados en {{ site.data.keys.mf_server }} se capturarán en {{ site.data.keys.mf_analytics }}. | true |
| mfp.analytics.url                  |Necesario. El URL que expone {{ site.data.keys.mf_analytics_server }} que recibe datos analíticos de entrada. Por ejemplo, http://hostname:port/analytics-service/rest/v2. | None |
| analyticsconsole/mfp.analytics.url |	Opcional. URI completo de los servicios REST de análisis. En un escenario con un cortafuegos o un proxy inverso protegido, este URI debe ser el URI externo, no el URI interno dentro de la LAN local. Este valor puede contener * en los lugares del protocolo de URI, el nombre de host o el puerto, para denotar la parte correspondiente desde el URL de entrada.	*://*:*/analytics-service, con el protocolo, el nombre de host y el puerto dinámicamente determinados |
| mfp.analytics.username             | El nombre de usuario que se utiliza si el punto de entrada de datos está protegido con autenticación básica. | None |
| mfp.analytics.password             | La contraseña que se utiliza si el punto de entrada de datos está protegido con autenticación básica. | None |

#### {{ site.data.keys.mf_analytics_server }}
{: #mobilefirst-analytics-server }
La tabla siguiente muestra las propiedades que se pueden establecer en {{ site.data.keys.mf_analytics_server }}.

| Propiedad                           | Descripción                                           | Valor predeterminado |
|------------------------------------|-------------------------------------------------------|---------------|
| analytics/nodetype | Define el tipo de nodo de Elasticsearch. Los valores válidos son maestro y datos. Si no se establece esta propiedad, el nodo actuará como un nodo elegible por el maestro y un nodo de datos. | 	None |
| analytics/shards | El número de fragmentos por índice. Este valor lo puede establecer únicamente el primer nodo que se inicia en el clúster y no se puede modificar. | 1 |
| analytics/replicas_per_shard | El número de réplicas para cada fragmento del clúster. Este valor se puede cambiar dinámicamente en un clúster en ejecución. | 0 |
| analytics/masternodes | Una serie delimitada por comas que contiene el nombre de host y los puertos de los nodos elegibles por el maestro. | None |
| analytics/clustername | Nombre del clúster. Establezca este valor si va a tener varios clústeres que funcionan en el mismo subconjunto y necesita identificarlos de forma exclusiva. | worklight |
| analytics/nodename | Nombre de un nodo del clúster. | Un serie generada de forma aleatoria
| analytics/datapath | La vía de acceso en la que se guardan los datos analíticos en el sistema de archivos. | ./analyticsData |
| analytics/settingspath | La vía de acceso a un archivo de valores de Elasticsearch. Para obtener más información, consulte Elasticsearch. | None |
| analytics/transportport | El puerto que se utiliza para la comunicación de nodo a nodo. | 9600 |
| analytics/httpport | El puerto que se utiliza para la comunicación de HTTP con Elasticsearch. | 9500 |
| analytics/http.enabled | Habilita o inhabilita la comunicación de HTTP con Elasticsearch. | false |
| analytics/serviceProxyURL | El archivo WAR de la IU de análisis y el archivo WAR del servicio de análisis se pueden instalar en servidores de aplicaciones independientes. Si decide hacerlo, debe comprender que el tiempo de ejecución de JavaScript en el archivo WAR de la IU lo puede bloquear la prevención de creación de scripts entre sitios en el navegador. Para omitir este bloqueo, el archivo WAR de la IU incluye código de proxy de Java para que el tiempo de ejecución de JavaScript recupere respuestas de la API REST del servidor de origen. Pero el proxy está configurado para reenviar solicitudes de la API REST al archivo WAR del servicio de análisis. Configure esta propiedad si ha instalado los archivos WAR en servidores de aplicaciones independientes. | None |
| analytics/bootstrap.mlockall | Esta propiedad impide que cualquier memoria de Elasticsearch se transfiera al disco. | true |
| analytics/multicast | Habilita o inhabilita el descubrimiento del nodo de multidifusión. | false |
| analytics/warmupFrequencyInSeconds | La frecuencia con la que se ejecutan las consultas de preparación. Las consultas de preparación se ejecutan en segundo plano para forzar los resultados de consulta en la memoria, lo que mejora el rendimiento de la consola web. Los valores negativos inhabilitan las consultas de preparación. | 600 |
| analytics/tenant | Nombre del índice principal de Elasticsearch.	worklight |

En todos los casos en los que la clave no contiene un punto (como **httpport** pero no **http.enabled**), el valor puede controlarse mediante variables de entorno del sistema donde el nombre de la variable tiene como prefijo **ANALYTICS_**. Cuando se establece la propiedad JNDI y la variable de entorno de sistema, la variable de entorno de sistema tiene prioridad. Por ejemplo, si tiene la propiedad JNDI **analytics/httpport** y la variable de entorno de sistema **ANALTYICS_httpport** establecidas, se utilizará el valor para **ANALYTICS_httpport**.

> **Importante**: Actualmente, MobileFirst Analytics v8.0 no soporta la multitenencia. Los sucesos desde MobileFirst Server se envían por defecto a arquitecturas de un solo tenant.

#### Documento TTL (Time to Live)
{: #document-time-to-live-ttl }
TTL trata efectivamente de cómo puede establecer y mantener una política de retención de datos. Sus decisiones tienen consecuencias drásticas en las necesidades de recursos del sistema. Cuanto más conserve los datos, más RAM, disco y escalado se necesita.

Cada tipo de documento tiene su propio TTL. Establecer el TTL de un documento permite la supresión automática del documento una vez que se almacene durante la cantidad de tiempo especificada.

Cada propiedad TTL JNDI se denomina **analytics/TTL_[document-type]**. Por ejemplo, el valor TTL para **NetworkTransaction** se denomina **analytics/TTL_NetworkTransaction**.

Estos valores se pueden establecer mediante unidades de tiempo básicas como se indica a continuación.

* 1Y = 1 año
* 1M = 1 mes
* 1w = 1 semana
* 1d = 1 día
* 1h = 1 hora
* 1m = 1 minuto
* 1s = 1 segundo
* 1ms = 1 milisegundo

La lista de tipos de documentos soportados es la siguiente:

* TTL_PushNotification
* TTL_PushSubscriptionSummarizedHourly
* TTL_ServerLog
* TTL_AppLog
* TTL_NetworkTransaction
* TTL_AppSession
* TTL_AppSessionSummarizedHourly
* TTL_NetworkTransactionSummarizedHourly
* TTL_CustomData
* TTL_AppPushAction
* TTL_AppPushActionSummarizedHourly
* TTL_PushSubscription


> **Nota:** Si va a migrar desde las versiones anteriores de {{ site.data.keys.mf_analytics_server }} y ha configurado previamente cualquier propiedad TTL JNDI, consulte [Migración de propiedades del servidor utilizadas por versiones anteriores de {{ site.data.keys.mf_analytics_server }}](../installation/#migration-of-server-properties-used-by-previous-versions-of-mobilefirst-analytics-server).

#### Elasticsearch
{: #elasticsearch }
La tecnología de almacenamiento y de agrupación en clúster subyacente que sirve a {{ site.data.keys.mf_analytics_console }} es Elasticsearch.  
Elasticsearch proporciona muchas propiedades ajustables, principalmente para el ajuste de rendimiento. Muchas de las propiedades JNDI son resúmenes de propiedades proporcionados por Elasticsearch.

Todas las propiedades que proporciona Elasticsearch también se pueden establecer utilizando propiedades JNDI con **analytics/** preanexado antes del nombre de propiedad. Por ejemplo, **threadpool.search.queue_size** es una propiedad que proporciona Elasticsearch. Se puede establecer con la propiedad JNDI siguiente.

```xml
<jndiEntry jndiName="analytics/threadpool.search.queue_size" value="100" />
```

Estas propiedades se establecen normalmente en un archivo de valores personalizados. Si está familiarizado con Elasticsearch y el formato de sus archivos de propiedades, puede especificar la vía de acceso al archivo de valores utilizando la propiedad JNDI **settingspath**, tal como se indica a continuación.

```xml
<jndiEntry jndiName="analytics/settingspath" value="/home/system/elasticsearch.yml" />
```

A menos que sea un gestor de TI de Elasticsearch experto, que haya identificado una necesidad específica, o que se lo haya indicado su equipo de soporte o de servicios, no modifique estos valores.

## Copia de seguridad de los datos de análisis
{: #backing-up-analytics-data }
Obtenga más información acerca de cómo realizar copias de seguridad de los datos de {{ site.data.keys.mf_analytics }}.

Los datos para {{ site.data.keys.mf_analytics }} se almacenan como un conjunto de archivos en el sistema de archivos de {{ site.data.keys.mf_analytics_server }}. La ubicación de esta carpeta se especifica mediante la propiedad datapath JNDI en la configuración de {{ site.data.keys.mf_analytics_server }}. Para obtener más información sobre las propiedades JNDI, consulte [Propiedades de configuración](#configuration-properties).

La configuración de {{ site.data.keys.mf_analytics_server }} también está almacenada en el sistema de archivos, y se denomina server.xml.

Puede realizar una copia de seguridad de estos archivos utilizando cualquier procedimiento de copia de seguridad de servidor existente que puede que ya tenga. No es necesario ningún procedimiento especial cuando se realice una copia de seguridad de estos archivos, que no sea asegurarse que se haya detenido {{ site.data.keys.mf_analytics_server }}. De lo contrario, los datos pueden cambiar mientras se está produciendo la copia de seguridad, y los datos que están almacenados en la memoria puede que aún no se hayan escrito en el sistema de archivos. Para evitar datos incoherentes, detenga {{ site.data.keys.mf_analytics_server }} antes de iniciar la copia de seguridad.

## Gestión de clústeres y Elasticsearch
{: #cluster-management-and-elasticsearch }
Gestione clústeres y añada nodos para liberar memoria y presión de capacidad.

### Añadir un nodo al clúster
{: #add-a-node-to-the-cluster }
Puede añadir un nodo nuevo al clúster instalando {{ site.data.keys.mf_analytics_server }} o ejecutando una instancia autónoma de Elasticsearch.

Si elige la instancia autónoma de Elasticsearch, libere alguna presión del clúster para los requisitos de memoria y de capacidad, pero no libere la presión de ingestión de datos. Los informes de datos siempre deben ir a través de {{ site.data.keys.mf_analytics_server }} para conservar la integridad y la optimización de los datos antes de ir a un almacén persistente.

Puede mezclar y comparar.

El almacén de datos subyacente de Elasticsearch espera que los nodos sean homogéneos, por lo que no mezcle un potente sistema de bastidor de 64 GB de RAM de 8 núcleos con un cuaderno sobrante en el clúster. Utilice hardware similar entre los nodos.

#### Adición de {{ site.data.keys.mf_analytics_server }} al clúster
{: #adding-a-mobilefirst-analytics-server-to-the-cluster }
Información sobre cómo añadir {{ site.data.keys.mf_analytics_server }} al clúster.

Puesto que Elasticsearch se incluye en {{ site.data.keys.mf_analytics_server }}, utilice la configuración de Elasticsearch para definir el comportamiento del clúster. Por ejemplo, no cree una granja de WebSphere Application Server Liberty ni utilice otras configuraciones del servidor de aplicaciones.

En las siguientes instrucciones de ejemplo, no configure el nodo para que sea un nodo maestro ni un nodo de datos. En su lugar, configure el nodo como un "equilibrador de carga de búsqueda" cuyo propósito es estar activo temporalmente para que la API REST de Elasticsearch esté expuesta para la supervisión y la configuración dinámica.

**Notas:**

* Recuerde configurar el hardware y el sistema operativo de este nodo según [Requisitos del sistema](../installation/#system-requirements).
* El puerto 9600 es el puerto de transporte que utiliza Elasticsearch. Por lo tanto, el puerto 9600 debe estar abierto a través de cualquier cortafuegos entre nodos de clúster.

1. Instale el archivo WAR de servicio de análisis y el archivo WAR de la IU de análisis (si desea la IU) en el servidor de aplicaciones en el sistema recientemente asignado. Instale esta instancia de {{ site.data.keys.mf_analytics_server }} en cualquiera de los servidor de aplicaciones soportados.
    * [Instalación de {{ site.data.keys.mf_analytics }} en WebSphere Application Server Liberty](../installation/#installing-mobilefirst-analytics-on-websphere-application-server-liberty)
    * [Instalación de {{ site.data.keys.mf_analytics }} en Tomcat](../installation/#installing-mobilefirst-analytics-on-tomcat)
    * [Instalación de {{ site.data.keys.mf_analytics }} en WebSphere Application Server](../installation/#installing-mobilefirst-analytics-on-websphere-application-server)

2. Edite el archivo de configuración del servidor de aplicaciones para las propiedades JNDI (o utilice las variables de entorno de sistema) para configurar al menos los distintivos siguientes.

    | Distintivo | Valor (ejemplo) | Predeterminado | Nota |
    |------|-----------------|---------|------|
    | cluster.name | 	worklight	 | worklight | 	El clúster al que pretende que se añada este nodo. |
    | discovery.zen.ping.multicast.enabled | 	false | 	true | 	Establézcalo en false para evitar uniones de clúster accidentales. |
    | discovery.zen.ping.unicast.hosts | 	["9.8.7.6:9600"] | 	None | 	Lista de los nodos maestros en el clúster existente. Cambie el puerto predeterminado de 9600 si ha especificado un valor de puerto de transporte en los nodos maestros. |
    | node.master | 	false | 	true | 	No permita que este nodo sea un maestro. |
    | node.data|	false | 	true | 	No permita que este nodo almacene datos. |
    | http.enabled | 	true	 | true | 	Abra el puerto HTTP 9200 no protegido para la API REST de Elasticsearch. |

3. Considere todos los distintivos de configuración en escenarios de producción. Es posible que desee que Elasticsearch conserve los plug-ins en un directorio del sistema de archivos distinto que el de los datos, por lo que debe establecer el distintivo **path.plugins**.
4. Ejecute el servidor de aplicaciones e inicie las aplicaciones WAR si es necesario.
5. Confirme que este nodo nuevo se ha unido al clúster observando la salida de la consola en este nodo nuevo, u observando el recuento de nodos en la sección **Clúster y nodo** de la página **Administración** en {{ site.data.keys.mf_analytics_console }}.

#### Adición de un nodo autónomo de Elasticsearch en el clúster
{: #adding-a-stand-alone-elasticsearch-node-to-the-cluster }
Información sobre cómo añadir un nodo autónomo de Elasticsearch en el clúster.

Puede añadir un nodo autónomo de Elasticsearch a su clúster de {{ site.data.keys.mf_analytics }} existente en unos pocos pasos sencillos. Sin embargo, debe decidir el rol de este nodo. ¿Va a ser un nodo elegible por el maestro? Si es así, recuerde que debe evitar el problema de cerebro dividido. ¿Va a ser un nodo de datos? ¿Va a ser un nodo de sólo cliente? Quizás desea un nodo de sólo cliente de modo que pueda iniciar un nodo temporalmente para exponer la API REST de Elasticsearch directamente para que afecte a los cambios de configuración dinámica en el clúster en ejecución.

En las siguientes instrucciones de ejemplo, no configure el nodo para que sea un nodo maestro ni un nodo de datos. En su lugar, configure el nodo como un "equilibrador de carga de búsqueda" cuyo propósito es estar activo temporalmente para que la API REST de Elasticsearch esté expuesta para la supervisión y la configuración dinámica.

**Notas:**

* Recuerde configurar el hardware y el sistema operativo de este nodo según [Requisitos del sistema](../installation/#system-requirements).
* El puerto 9600 es el puerto de transporte que utiliza Elasticsearch. Por lo tanto, el puerto 9600 debe estar abierto a través de cualquier cortafuegos entre nodos de clúster.

1. Descargue Elasticsearch desde [https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.7.5.tar.gz](https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.7.5.tar.gz).
2. Descomprima el archivo.
3. Edite el archivo **config/elasticsearch.yml** y configure al menos los distintivos siguientes.

    | Distintivo | Valor (ejemplo) | Predeterminado | Nota |
    |------|-----------------|---------|------|
    | cluster.name | 	worklight	 | worklight | 	El clúster al que pretende que se añada este nodo. |
    | discovery.zen.ping.multicast.enabled | 	false | 	true | 	Establézcalo en false para evitar uniones de clúster accidentales. |
    | discovery.zen.ping.unicast.hosts | 	["9.8.7.6:9600"] | 	None | 	Lista de los nodos maestros en el clúster existente. Cambie el puerto predeterminado de 9600 si ha especificado un valor de puerto de transporte en los nodos maestros. |
    | node.master | 	false | 	true | 	No permita que este nodo sea un maestro. |
    | node.data|	false | 	true | 	No permita que este nodo almacene datos. |
    | http.enabled | 	true	 | true | 	Abra el puerto HTTP 9200 no protegido para la API REST de Elasticsearch. |


4. Considere todos los distintivos de configuración en escenarios de producción. Es posible que desee que Elasticsearch conserve los plug-ins en un directorio del sistema de archivos distinto al de los datos, por lo que debe establecer el distintivo path.plugins.
5. Ejecute `./bin/plugin -i elasticsearch/elasticsearch-analytics-icu/2.7.0` para instalar el plug-in de ICU.
6. Ejecute `./bin/elasticsearch`.
7. Confirme que este nodo nuevo se ha unido al clúster observando la salida de la consola en este nodo nuevo, u observando el recuento de nodos en la sección **Clúster y nodo** de la página **Administración** en {{ site.data.keys.mf_analytics_console }}.

#### Interruptores de circuito
{: #circuit-breakers }
Obtenga más información sobre los interruptores de circuito de Elasticsearch.

Elasticsearch contiene varios interruptores de circuito que se utilizan para evitar que las operaciones provoquen un **OutOfMemoryError**. Por ejemplo, si una consulta que sirve datos en {{ site.data.keys.mf_console }} da como resultado utilizar el 40% del almacenamiento dinámico de JVM, el interruptor del circuito se desencadenará, se generará una excepción y la consola recibirá datos vacíos.

Elasticsearch también tiene protecciones para rellenar el disco. Si el disco en el que está configurado el almacén de datos de Elasticsearch para escribir llega al 90% de su capacidad, el nodo de Elasticsearch informará al nodo maestro del clúster. El nodo maestro a continuación redirigirá nuevas escrituras de documentos fuera del nodo casi completo. Si sólo dispone de un nodo en el clúster, no habrá disponible ningún nodo secundario en el que se puedan escribir los datos. Por lo tanto, no se escriben datos y se perderán.
