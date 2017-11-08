---
layout: tutorial
title: Elasticsearch
breadcrumb_title: Elasticsearch
relevantTo: [ios,android,javascript]
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }

{{ site.data.keys.mf_analytics_full }} utiliza **Elasticsearch 1.5x** para almacenar datos y ejecutar consultas de búsqueda.    

Elasticsearch es un motor de analíticas y búsqueda distribuida en tiempo real que incrementa los ratios de escalado y velocidad para la exploración y almacenamiento de datos.
Elasticsearch se utiliza para una búsqueda estructurada y de texto completo.


Elasticsearch sirve para almacenar todos los datos de servidor y móviles en formato JSON en las instancias de Elasticsearch en {{ site.data.keys.mf_analytics_server }}.

Las instancias de Elasticsearch son consultadas en tiempo real para cumplimentar {{ site.data.keys.mf_analytics_console_full }}.

{{ site.data.keys.mf_analytics }} expone toda la funcionalidad Elasticsearch.
Al usuario se le ofrece la posibilidad de aprovecharse de las características de optimización, depuración y consultas de Elasticsearch.


Para obtener más información sobre la funcionalidad Elasticsearch, más allá de la funcionalidad aquí descrita, consulte la [Documentación de Elasticsearch](https://www.elastic.co/guide/en/elasticsearch/reference/1.5/index.html).


## Gestión de Elasticsearch en {{ site.data.keys.mf_analytics_server }}
{: #managing-elasticsearch-on-the-mobilefirst-analytics-server }

Elasticsearch está incluido en {{ site.data.keys.mf_analytics_server }} y participa en el comportamiento a nivel de clúster y nodo.


> Para obtener más información sobre la configuración de Elasticsearch en el servidor de analíticas, consulte [Gestión del clúster y Elasticsearch](../../installation-configuration/production/analytics/configuration#cluster-management-and-elasticsearch) en el tema [Guía de configuración de {{ site.data.keys.mf_analytics_server }}](../../installation-configuration/production/analytics/configuration).
### Propiedades de Elasticsearch
{: #elasticsearch properties }

Las propiedades de Elasticsearch están disponibles a través de entradas de entorno o variables JNDI.
  
Una de las propiedades JNDI más útiles para empezar a visualizar los datos de Elasticsearch es:


```xml
<jndiEntry jndiName="analytics/http.enabled" value="true"/>
```

Esta propiedad JNDI permite ver los datos de {{ site.data.keys.mf_analytics_short }} sin procesar en formato JSON y acceder a la instancia Elasticsearch a través del puerto que esté definido por Elasticsearch.
El puerto predeterminado es 9500.

> **Nota**: Este valor no es seguro y no se debería habilitar en un entorno de producción.


## API REST de Elasticsearch
{: #elasticsearch-rest-api }

El acceso a la instancia de Elasticsearch proporciona la posibilidad de ejecutar consultas personalizadas así como visualizar información detallada sobre el clúster Elasticsearch.


**Búsqueda y visualización de datos**  
Visualice todos los datos visitando el punto final REST de `_search` del arrendatario.
  

```
http://localhost:9500/*/_search
```

**Visualización de la salud del clúster**  

```
http://localhost:9500/_cluster/health
```

**Visualización de información en los nodos actuales**  

```
http://localhost:9500/_nodes
```

**Visualización de las correlaciones actuales**  

```
http://localhost:9500/*/_mapping
```

> Elasticsearch expone muchos más puntos finales REST.
Para obtener más información, visite la [Documentación de Elasticsearch](https://www.elastic.co/guide/en/elasticsearch/reference/1.5/index.html).
