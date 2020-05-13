---
layout: tutorial
breadcrumb_title: Configuración del recurso personalizado (CR) Mobile Foundation 
title: Configuración del recurso personalizado (CR) IBM Mobile Foundation 
weight: 3
show_in_nav: false
---
<!-- NLS_CHARSET=UTF-8 -->

### Parámetros 

| Calificador | Parámetro | Definición | Valor permitido |
|---|---|---|---|
| global.arch | amd64 | Preferencia de planificador de nodos trabajadores de amd64 en un clúster híbrido | amd64 |
| global.image     | pullPolicy | Política de extracción de imágenes | Always, Never, o IfNotPresent. Predeterminado: **IfNotPresent** |
|      |  pullSecret    | Secreto de extracción de imagen | Solo es necesario si las imágenes no están alojadas en el registro de imágenes de OCP. |
| global.ingress | hostname | El nombre de host externo o dirección IP para que lo utilicen los clientes externos | Déjelo en blanco para utilizar el valor predeterminado de la dirección IP del nodo de proxy del clúster|
|         | secret | Nombre del secreto TLS | Especifica el nombre del secreto para el certificado que se ha de utilizar en la definición Ingress. El secreto se ha de crear previamente utilizando el certificado y clave relevantes. Es obligatorio si está habilitado SSL/TLS. Cree previamente el secreto con el certificado & clave antes de proporcionar el nombre aquí. Consulte [aquí](#optional-creating-tls-secret-for-ingress-configuration) |
|         | sslPassThrough | Habilitar passthrough SSL | Especifica si se ha de pasar la solicitud SSL mediante el servicio Mobile Foundation - la terminación de SSL se produce en el servicio Mobile Foundation. **false** (predeterminado) o true|
| global.dbinit | habilitado | Habilitar la inicialización de las bases de datos del servidor, Push y Centro de aplicaciones | Inicializa las bases de datos y crea esquemas y tablas para el despliegue del servidor, Push y el centro de aplicaciones.(No es necesario para las analíticas). **true** (predeterminado) o false |
|  | repository | Repositorios de imagen Docker para la inicialización de base de datos | Repositorio de imagen de docker de la base de datos Mobile Foundation. Asegúrese de que el REPO_URL del contenedor se ha sustituido por el url del registro de docker. |
|           | tag | Etiqueta de imagen Docker | Consulte la descripción de la etiqueta Docker |
| mfpserver | habilitado       | Distintivo para habilitar el servidor | **true** (predeterminado) o false |
| mfpserver.image | repository | Repositorio de imagen Docker | Repositorio de la imagen Docker de Mobile Foundation Server. Asegúrese de que el REPO_URL del contenedor se ha sustituido por el url del registro de docker. |
|           | tag | Etiqueta de imagen Docker | Consulte la descripción de la etiqueta Docker |
|           | consoleSecret | Un secreto ya creado para inicio de sesión | Consulte [aquí](#optional-creating-custom-defined-console-login-secrets)
|  mfpserver.db | type | Nombre de proveedor de base de datos soportado. | **DB2** (predeterminado) / MySQL / Oracle |
|               | host | Dirección IP o nombre de host de la base de datos donde se han de configurar las tablas de Mobile Foundation Server. | |
|                       | port | 	Puerto donde se configura la base de datos | |
|                       | secret | Secreto ya creado que tiene credenciales de base de datos| |
|                       | name | Nombre de la base de datos de Mobile Foundation Server | |
|                       | schema | Esquema de bd de servidor que se ha de crear. | Si ya existe el esquema, se utilizará. De lo contrario, se creará. |
|                       | ssl |Tipo de conexión de base de datos | Especifique si la conexión de base de datos ha de ser http o https. El valor predeterminado es **false** (http). Asegúrese de que el puerto de base de datos también esté configurado para la misma modalidad de conexión. |
|                       | driverPvc | Reclamación de volumen persistente para acceder al controlador de base de datos JDBC| Especifique el nombre de la reclamación de volumen persistente que aloja el controlador de base de datos JDBC. Es necesario si el tipo de base de datos seleccionado no es DB2 |
|                       | adminCredentialsSecret | Secreto Admin de BD de MFPServer | Si ha habilitado la inicialización de base de datos, proporcione el secreto para crear las tablas y esquemas de base datos para los componentes de Mobile Foundation. |
| mfpserver | adminClientSecret | Secreto de cliente administrador | Especifique el nombre del secreto de cliente creado. Consulte [aquí](#optional-creating-secrets-for-confidential-clients)
|
|  | pushClientSecret | Secreto de cliente Push | Especifique el nombre del secreto de cliente creado. Consulte [aquí](#optional-creating-secrets-for-confidential-clients)
|
|  | liveupdateClientSecret | Secreto de cliente LiveUpdate | Especifique el nombre del secreto de cliente creado. Consulte [aquí](#optional-creating-secrets-for-confidential-clients)
|
| mfpserver.replicas |  | Número de instancias (pods) de Mobile Foundation Server que se han de crear | Entero positivo (Predeterminado: **3**) |
| mfpserver.autoscaling     | habilitado | Especifica si se despliega un HPA (Horizontal Pod Autoscaler). Tenga en cuenta que al habilitar este campo se inhabilita el campo de réplicas. | **false** (predeterminado) o true|
|           | min  | Límite inferior del número de pods que puede establecer el escalador automático. | Entero positivo (predeterminado: **1**) |
|           | max | Límite superior del número de pods que puede establecer el escalador automático. No puede ser inferior al mín. | Entero positivo (predeterminado: **10**) |
|           | targetcpu | Uso promedio objetivo de CPU (representado como un porcentaje de la CPU solicitada) sobre todos los pods. | Entero entre 1 y 100 (predeterminado **50**)|
| mfpserver.pdb     | habilitado | Especifique si se ha de habilitar/inhabilitar PDB.| **true** (predeterminado) o false |
|           | min  | mínimo de pods disponibles | Entero positivo (predeterminado: 1) |
|    mfpserver.customConfiguration |  |  Configuración del servidor predeterminada (Opcional)  | Proporcione una referencia de configuración adicional específica del servidor a una correlación de configuración creada previamente. Consulte [aquí](#optional-custom-server-configuration)|
| mfpserver | keystoreSecret | Consulte la [sección de configuración](#optional-creating-custom-keystore-secret-for-the-deployments) para crear previamente el secreto con almacenes de claves y sus contraseñas.|
| mfpserver.resources | limits.cpu | Describe la cantidad máxima de CPU permitida.  | El valor predeterminado es **2000m**. Consulte Kubernetes - [significado de CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|                  | limits.memory | Describe la cantidad de memoria máxima permitida. | El valor predeterminado es **2048Mi**. Consulte Kubernetes - [significado de memoria](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)|
|           | requests.cpu | Describe la cantidad mínima de CPU requerida. Si no se especifica tomará el valor predeterminado del límite (si se ha especificado) o de lo contrario el valor definido por la implementación. | El valor predeterminado es **1000m**. Consulte Kubernetes - [significado de CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|           | requests.memory | Describe la cantidad mínima de memoria necesaria. Si no se especifica, el límite será el valor predeterminado de cantidad de memoria (si se ha especificado) o el valor definido por implementación. | El valor predeterminado es **1536Mi**. Consulte Kubernetes - [significado de memoria](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory) |
| mfppush | habilitado       | Distintivo para habilitar Mobile Foundation Push | **true** (predeterminado) o false |
|           | repository | Repositorio de imagen Docker | Repositorio de la imagen Docker de Mobile Foundation Push. Asegúrese de que el REPO_URL del contenedor se ha sustituido por el url del registro de docker. |
|           | tag | Etiqueta de imagen Docker | Consulte la descripción de la etiqueta Docker |
| mfppush.replicas | | Número de instancias (pods) de Mobile Foundation Server que se han de crear | Entero positivo (Predeterminado: **3**) |
| mfppush.autoscaling     | habilitado | Especifica si se despliega un HPA (Horizontal Pod Autoscaler).  Tenga en cuenta que al habilitar este campo se inhabilita el campo replicaCount. | **false** (predeterminado) o true|
|           | min  | Límite inferior del número de pods que puede establecer el escalador automático. | Entero positivo (predeterminado: **1**) |
|           | max | Límite superior del número de pods que puede establecer el escalador automático. No puede ser inferior a minReplicas. | Entero positivo (predeterminado: **10**) |
|           | targetcpu | Uso promedio objetivo de CPU (representado como un porcentaje de la CPU solicitada) sobre todos los pods. | Entero entre 1 y 100 (predeterminado **50**)|
| mfppush.pdb     | habilitado | Especifique si se ha de habilitar/inhabilitar PDB.| **true** (predeterminado) o false |
|           | min  | mínimo de pods disponibles | Entero positivo (predeterminado: 1) |
| mfppush.customConfiguration |  |  Configuración predeterminada (Opcional)  | Proporcione una referencia de configuración adicional específica de Push a una correlación de configuración creada previamente. Consulte [aquí](#optional-custom-server-configuration)
|
| mfppush | keystoresSecretName | Consulte la [sección de configuración](#optional-creating-custom-keystore-secret-for-the-deployments) para crear previamente el secreto con almacenes de claves y sus contraseñas.|
| mfppush.resources | limits.cpu | Describe la cantidad máxima de CPU permitida.  | El valor predeterminado es **1000m**. Consulte Kubernetes - [significado de CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|                  | limits.memory | Describe la cantidad de memoria máxima permitida. | El valor predeterminado es **2048Mi**. Consulte Kubernetes - [significado de memoria](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)|
|           | requests.cpu | Describe la cantidad mínima de CPU requerida. Si no se especifica tomará el valor predeterminado del límite (si se ha especificado) o de lo contrario el valor definido por la implementación. | El valor predeterminado es **750m**. Consulte Kubernetes - [significado de CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|           | requests.memory | Describe la cantidad mínima de memoria necesaria. Si no se especifica, el límite será el valor predeterminado de cantidad de memoria (si se ha especificado) o el valor definido por implementación. | El valor predeterminado es **1024Mi**. Consulte Kubernetes - [significado de memoria](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory) |
| mfpliveupdate | habilitado       | Distintivo para habilitar Liveupdate | **false** (predeterminado) o true|
| mfpliveupdate.image | repository | Repositorio de imagen Docker | Repositorio de imagen de docker de Mobile Foundation Live Update. Asegúrese de que el REPO_URL del contenedor se ha sustituido por el url del registro de docker. |
|           | tag | Etiqueta de imagen Docker | Consulte la descripción de la etiqueta Docker. |
|           | consoleSecret | Un secreto ya creado para inicio de sesión | Consulte [aquí](#optional-creating-custom-defined-console-login-secrets). |
| mfpliveupdate.db | type | Nombre de proveedor de base de datos soportado | **DB2** (predeterminado) / MySQL / Oracle |
|  | host | Dirección IP o nombre de host de la base de datos donde se han de configurar las tablas de Mobile Foundation Server. |  |
|  | port | Número de puerto de base de datos. |  |
|  | secret | Un secreto ya creado con credenciales de base de datos. |  |
|  | name | Nombre de la base de datos de Mobile Foundation Server. |  |
|  | schema | Esquema de bd de servidor que se ha de crear. | Si ya existe el esquema, se utilizará. De lo contrario, se creará. |
|  | ssl | Tipo de conexión de base de datos. | Especifique si la conexión de base de datos ha de ser http o https. El valor predeterminado es **false** (http). Asegúrese de que el puerto de base de datos también está configurado para el mismo modo de conexión. |
|  | driverPvc | Reclamación de volumen persistente para acceder al controlador de base de datos JDBC. | Especifique el nombre de la reclamación de volumen persistente que aloja el controlador de base de datos JDBC. Es necesario si el tipo de base de datos seleccionado no es DB2. |
|  | adminCredentialsSecret |Secreto Admin de BD de MFPServer. | Si ha habilitado la inicialización de base de datos, proporcione el secreto para crear las tablas y esquemas de base datos para los componentes de Mobile Foundation. |
| mfpliveupdate.replicas |   | El número de instancias (pods) de Mobile Foundation Liveupdate que se han de crear. | Entero positivo (Predeterminado: **2**. |
| mfpliveupdate.autoscaling | habilitado      | Especifica si se despliega un HPA (Horizontal Pod Autoscaler). Tenga en cuenta que al habilitar este campo se inhabilita el campo de réplicas. | **false** (predeterminado) o true. |
|  | min  | Límite inferior del número de pods que puede establecer el escalador automático. | Entero positivo (predeterminado **1**). |
|  | max | Límite superior del número de pods que puede establecer el escalador automático. No puede ser inferior al mín. | Entero positivo (predeterminado **10**). |
|  | targetcpu | Uso promedio objetivo de CPU (representado como un porcentaje de la CPU solicitada) sobre todos los pods. | Entero entre 1 y 100 (predeterminado **50**). |
| mfpliveupdate.pdb | habilitado      | Especifique si se ha de habilitar/inhabilitar PDB.| **true** (predeterminado) o false. |
|  | min  | mínimo de pods disponibles | Entero positivo (predeterminado **1**). |
| mfpliveupdate.customConfiguration |   | Configuración predeterminada del servidor (Opcional). | Proporcione una referencia de configuración adicional específica del servidor a una correlación de configuración creada previamente. Consulte [aquí](#optional-custom-server-configuration).|
| mfpliveupdate | keystoreSecret | Consulte la [sección de configuración](#optional-creating-custom-keystore-secret-for-the-deployments) para crear previamente el secreto con almacenes de claves y sus contraseñas.|  |
| mfpliveupdate.resources | limits.cpu | Describe la cantidad máxima de CPU permitida.  | El valor predeterminado es **1000m**. Consulte Kubernetes - [significado de CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu). |
|  | limits.memory | Describe la cantidad de memoria máxima permitida. | El valor predeterminado es **2048Mi**. Consulte Kubernetes - [significado de memoria](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory). |
|  | requests.cpu | Describe la cantidad mínima de CPU requerida. Si no se especifica tomará el valor predeterminado del límite (si se ha especificado) o de lo contrario el valor definido por la implementación. | El valor predeterminado es **750m**. Consulte Kubernetes - [significado de CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu). |
|  | requests.memory | Describe la cantidad mínima de memoria necesaria. Si no se especifica, el límite será el valor predeterminado de cantidad de memoria (si se ha especificado) o el valor definido por implementación. | El valor predeterminado es 1024Mi. Consulte Kubernetes - [significado de memoria](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory). |
| mfpanalytics | habilitado       | Distintivo para habilitar las analíticas | **false** (predeterminado) o true|
| mfpanalytics.image | repository | Repositorio de imagen Docker | Repositorio de la imagen Docker de Mobile Foundation Operational Analytics. Asegúrese de que el REPO_URL del contenedor se ha sustituido por el url del registro de docker. |
|           | tag | Etiqueta de imagen Docker | Consulte la descripción de la etiqueta Docker |
|           | consoleSecret | Un secreto ya creado para inicio de sesión |Consulte [aquí](#optional-creating-custom-defined-console-login-secrets)|
| mfpanalytics.replicas |  | Número de instancias (pods) de Mobile Foundation Operational Analytics que se han de crear | Entero positivo (Predeterminado: **2**) |
| mfpanalytics.autoscaling     | habilitado | Especifica si se despliega un HPA (Horizontal Pod Autoscaler).  Tenga en cuenta que al habilitar este campo se inhabilita el campo replicaCount. | **false** (predeterminado) o true|
|           | min  | Límite inferior del número de pods que puede establecer el escalador automático. | Entero positivo (predeterminado: **1**) |
|           | max | Límite superior del número de pods que puede establecer el escalador automático. No puede ser inferior a minReplicas. | Entero positivo (predeterminado: **10**) |
|           | targetcpu | Uso promedio objetivo de CPU (representado como un porcentaje de la CPU solicitada) sobre todos los pods. | Entero entre 1 y 100 (predeterminado 50) |
|  mfpanalytics.shards|  | Número de fragmentos Elasticsearch para Mobile Foundation Analytics | predeterminado: 2 |             
|  mfpanalytics.replicasPerShard|  | Número de réplicas Elasticsearch que se van a mantener por cada fragmento de Mobile Foundation Analytics | predeterminado: **2**|
| mfpanalytics.persistence | habilitado      | Utilice una PersistentVolumeClaim para la persistencia de los datos     | **true** |                                                 |
|            |useDynamicProvisioning      | Especifique una storeclass o deje el campo vacío  | **false**  |                                                  |
|           |volumeName| Proporcione un nombre de volumen  | **data-stor** (predeterminado) |
|           |claimName| Proporcione una PersistentVolumeClaim existente | nil |
|           |storageClassName     | Clase de almacenamiento de la PersistentVolumeClaim de respaldo | nil |
|           |size             | Tamaño del volumen de datos      | 20Gi |
| mfpanalytics.pdb     | habilitado | Especifique si se ha de habilitar/inhabilitar PDB.| **true** (predeterminado) o false |
|           | min  | mínimo de pods disponibles | Entero positivo (predeterminado: **1**) |
|    mfpanalytics.customConfiguration |  |  Configuración predeterminada (Opcional)  | Proporcione una referencia de configuración adicional específica de Analytics a una correlación de configuración creada previamente. Consulte [aquí](#optional-custom-server-configuration |
| mfpanalytics | keystoreSecret | Consulte la [sección de configuración](#optional-creating-custom-keystore-secret-for-the-deployments) para crear previamente el secreto con almacenes de claves y sus contraseñas.|
| mfpanalytics.resources | limits.cpu | Describe la cantidad máxima de CPU permitida.  | El valor predeterminado es **1000m**. Consulte Kubernetes - [significado de CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|                  | limits.memory | Describe la cantidad de memoria máxima permitida. | El valor predeterminado es **2048Mi**. Consulte Kubernetes - [significado de memoria](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)|
|           | requests.cpu | Describe la cantidad mínima de CPU requerida. Si no se especifica tomará el valor predeterminado del límite (si se ha especificado) o de lo contrario el valor definido por la implementación. | El valor predeterminado es **750m**. Consulte Kubernetes - [significado de CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|           | requests.memory | Describe la cantidad mínima de memoria necesaria. Si no se especifica, el límite será el valor predeterminado de cantidad de memoria (si se ha especificado) o el valor definido por implementación. | El valor predeterminado es 1024Mi. Consulte Kubernetes - [significado de memoria](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory) |
| mfpanalytics_recvr | habilitado       | Distintivo para habilitar Analytics Receiver | **false** (predeterminado) o true|
| mfpanalytics_recvr.image | repository | Repositorio de imagen Docker | Repositorio de imagen de docker de Mobile Foundation Live Update. Asegúrese de que el REPO_URL del contenedor se ha sustituido por el url del registro de docker. |
|           | tag | Etiqueta de imagen Docker | Consulte la descripción de la etiqueta Docker. |
| mfpanalytics_recvr.replicas |   | El número de instancias (pods) de Mobile Foundation Analytics Receiver que se han de crear. | Entero positivo (Predeterminado: **1**. |
| mfpanalytics_recvr.autoscaling | habilitado      | Especifica si se despliega un HPA (Horizontal Pod Autoscaler).  Tenga en cuenta que al habilitar este campo se inhabilita el campo replicaCount. | **false** (predeterminado) o true. |
|  | min  | Límite inferior del número de pods que puede establecer el escalador automático. | Entero positivo (predeterminado **1**). |
|  | max | Límite superior del número de pods que puede establecer el escalador automático. No puede ser inferior al mín. | Entero positivo (predeterminado **10**). |
|  | targetcpu | Uso promedio objetivo de CPU (representado como un porcentaje de la CPU solicitada) sobre todos los pods. | Entero entre 1 y 100 (predeterminado **50**). |
| mfpanalytics_recvr.pdb | habilitado      | Especifique si se ha de habilitar/inhabilitar PDB.| **true** (predeterminado) o false. |
|  | min  | mínimo de pods disponibles | Entero positivo (predeterminado **1**). |
| mfpanalytics_recvr | analyticsRecvrSecret     | Un secreto ya creado para el receptor. |Consulte [aquí](#optional-creating-custom-keystore-secret-for-the-deployments).|
| mfpanalytics_recvr.customConfiguration |  | Configuración personalizada (Opcional). | Proporcione una referencia de configuración adicional específica de Analytics a una correlación de configuración creada previamente. Consulte [aquí](#optional-custom-server-configuration).|
| mfpanalytics_recvr | keystoreSecret | Consulte la [sección de configuración](#optional-creating-custom-keystore-secret-for-the-deployments) para crear previamente el secreto con almacenes de claves y sus contraseñas.|  |
| mfpanalytics_recvr.resources | limits.cpu | Describe la cantidad máxima de CPU permitida.  | El valor predeterminado es **1000m**. Consulte Kubernetes - [significado de CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu). |
|  | limits.memory | Describe la cantidad de memoria máxima permitida. | El valor predeterminado es **2048Mi**. Consulte Kubernetes - [significado de memoria](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory). |
|  | requests.cpu | Describe la cantidad mínima de CPU requerida. Si no se especifica tomará el valor predeterminado del límite (si se ha especificado) o de lo contrario el valor definido por la implementación. | El valor predeterminado es **750m**. Consulte Kubernetes - [significado de CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu). |
|  | requests.memory | Describe la cantidad mínima de memoria necesaria. Si no se especifica, el límite será el valor predeterminado de cantidad de memoria (si se ha especificado) o el valor definido por implementación. | El valor predeterminado es 1024Mi. Consulte Kubernetes - [significado de memoria](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory). |
| mfpappcenter | habilitado       | Distintivo para habilitar Application Center | **false** (predeterminado) o true|  
| mfpappcenter.image | repository | Repositorio de imagen Docker | Repositorio de la imagen Docker de Mobile Foundation Application Center. Asegúrese de que el REPO_URL del contenedor se ha sustituido por el url del registro de docker. |
|           | tag | Etiqueta de imagen Docker | Consulte la descripción de la etiqueta Docker |
|           | consoleSecret | Un secreto ya creado para inicio de sesión |Consulte [aquí](#optional-creating-custom-defined-console-login-secrets)|
|  mfpappcenter.db | type | Nombre de proveedor de base de datos soportado. | **DB2** (predeterminado) / MySQL / Oracle |
|                   | host | Dirección IP o nombre de host de la base de datos donde se ha de configurar la base de datos de Appcenter. | |
|                       | port | 	 Puerto de la base de datos | |             
|                       | name | Nombre de la base de datos que se va a utilizar | La base de datos debe crearse previamente. |
|                       | secret | Secreto ya creado que tiene credenciales de base de datos| |
|                       | schema | Esquema de base de datos de Application Center que se ha de crear. | Si ya existe el esquema, se utilizará. Si no es así, se creará. |
|                       | ssl |Tipo de conexión de base de datos | Especifique si la conexión de base de datos ha de ser http o https. El valor predeterminado es **false** (http). Asegúrese de que el puerto de base de datos también esté configurado para la misma modalidad de conexión. |
|                       | driverPvc | Reclamación de volumen persistente para acceder al controlador de base de datos JDBC| Especifique el nombre de la reclamación de volumen persistente que aloja el controlador de base de datos JDBC. Es necesario si el tipo de base de datos seleccionado no es DB2 |
|                       | adminCredentialsSecret | Secreto Admin de BD de Application Center | Si ha habilitado la inicialización de base de datos, proporcione el secreto para crear las tablas y esquemas de base datos para los componentes de Mobile Foundation |
| mfpappcenter.autoscaling     | habilitado | Especifica si se despliega un HPA (Horizontal Pod Autoscaler).  Tenga en cuenta que al habilitar este campo se inhabilita el campo replicaCount. | **false** (predeterminado) o true|
|           | min  | Límite inferior del número de pods que puede establecer el escalador automático. | Entero positivo (predeterminado: **1**) |
|           | max | Límite superior del número de pods que puede establecer el escalador automático. No puede ser inferior a minReplicas. | Entero positivo (predeterminado: **10**) |
|           | targetcpu | Uso promedio objetivo de CPU (representado como un porcentaje de la CPU solicitada) sobre todos los pods. | Entero entre 1 y 100 (predeterminado **50**)|
| mfpappcenter.pdb     | habilitado | Especifique si se ha de habilitar/inhabilitar PDB.| **true** (predeterminado) o false |
|           | min  | mínimo de pods disponibles | Entero positivo (predeterminado: **1**) |
| mfpappcenter.customConfiguration |  |  Configuración predeterminada (Opcional)  | Proporcione una referencia de configuración adicional específica de Application Center a una correlación de configuración creada previamente. Consulte [aquí](#optional-custom-server-configuration)
|
| mfpappcenter | keystoreSecret | Consulte la [sección de configuración](#optional-creating-custom-keystore-secret-for-the-deployments) para crear previamente el secreto con almacenes de claves y sus contraseñas.|
| mfpappcenter.resources | limits.cpu | Describe la cantidad máxima de CPU permitida.  | El valor predeterminado es **1000m**. Consulte Kubernetes - [significado de CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|                  | limits.memory | Describe la cantidad de memoria máxima permitida. | El valor predeterminado es **2048Mi**. Consulte Kubernetes - [significado de memoria](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)|
|           | requests.cpu | Describe la cantidad mínima de CPU requerida. Si no se especifica tomará el valor predeterminado del límite (si se ha especificado) o de lo contrario el valor definido por la implementación. | El valor predeterminado es **750m**. Consulte Kubernetes - [significado de CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|           | requests.memory | Describe la cantidad mínima de memoria necesaria. Si no se especifica, el límite será el valor predeterminado de cantidad de memoria (si se ha especificado) o el valor definido por implementación. | El valor predeterminado es **1024Mi**. Consulte Kubernetes - [significado de memoria](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory) |

## [OPCIONAL] Crear secretos de inicio de sesión en la consola personalizados 

De forma predeterminada, los secretos de inicio de sesión de la consola para todos los componentes de Mobile Foundation se crean automáticamente durante el despliegue. De forma opcional, puede optar por crear el **Secreto de inicio de sesión** para acceder a la consola del servidor, Analytics y Application Center. El siguiente es el ejemplo.

Para el servidor, 

```bash
kubectl create secret generic serverlogin --from-literal=MFPF_ADMIN_USER=admin --from-literal=MFPF_ADMIN_PASSWORD=admin
```

Para Analytics,

```bash
kubectl create secret generic analyticslogin --from-literal=MFPF_ANALYTICS_ADMIN_USER=admin --from-literal=MFPF_ANALYTICS_ADMIN_PASSWORD=admin
```

Para Analytics Receiver,

```bash
kubectl create secret generic analytics_recvrsecret --from-literal=MFPF_ANALYTICS_RECVR_USER=admin --from-literal=MFPF_ANALYTICS_RECVR_PASSWORD=admin
```

Para Application Center,

```bash
kubectl create secret generic appcenterlogin --from-literal=MFPF_APPCNTR_ADMIN_USER=admin --from-literal=MFPF_APPCNTR_ADMIN_PASSWORD=admin
```

> NOTA: Si no se proporcionan estos secretos, se crean con el nombre de usuario y contraseña predeterminados de admin/admin durante la instalación de Mobile Foundation. 

## [ OPCIONAL] Creación del secreto TLS para la configuración de ingress

Se pueden configurar los componentes de Mobile Foundation con el nombre de host basado en Ingress para que los clientes externos puedan conectarse a los mismos utilizando el nombre de host. Se puede proteger Ingress utilizando una clave TLS privada y un certificado. La clave privada TLS y el certificado se deben definir en un secreto con los nombres de clave `tls.key` y `tls.crt`. 

El secreto **mf-tls-secret** se crea en el mismo espacio de nombres que el recurso Ingress utilizando el mandato siguiente.

```
kubectl create secret tls mf-tls-secret --key=/path/to/tls.key --cert=/path/to/tls.crt
```

El nombre del secreto se proporciona en el campo *global.ingress.secret* del archivo yaml de la configuración del recurso personalizado.

## [ OPCIONAL] Creación de un secreto de almacén de claves personalizado para los despliegues

Puede proporcionar su propio almacén de claves y almacén de confianza al despliegue del servidor, Push, Analytics y Application Center creando un secreto con su propio almacén de claves y almacén de confianza.

Cree previamente un secreto con `keystore.jks` y `truststore.jks` junto con la contraseña del almacén de claves y el almacén de confianza utilizando los literales KEYSTORE_PASSWORD y TRUSTSTORE_PASSWORD; proporcione el nombre de secreto en el campo keystoreSecret del componente respectivo. 

El siguiente es un ejemplo de cómo crear el secreto del almacén de clave para el despliegue del servidor utilizando `keystore.jks`, `truststore.jks` y establecer sus contraseñas. 
```
kubectl create secret generic server-secret --from-file=./keystore.jks --from-file=./truststore.jks --from-literal=KEYSTORE_PASSWORD=worklight --from-literal=TRUSTSTORE_PASSWORD=worklight
```

> NOTA: Los nombres de los archivos y literales deben ser los mismos que se han mencionado en el mandato anterior. Proporcione este nombre de secreto en el campo de entrada `keystoresSecretName` del componente respectivo para reemplazar los almacenes de claves predeterminados cuando configura el gráfico helm. 


## [OPCIONAL] Creación de secretos para clientes confidenciales

Mobile Foundation Server está predefinido con clientes confidenciales para el servicio de administración. Las credenciales de estos clientes se proporcionan en los campos `mfpserver.adminClientSecret` y `mfpserver.pushClientSecret`. 

Estos secretos se pueden crear del modo siguiente: 

```
kubectl create secret generic mf-admin-client --from-literal=MFPF_ADMIN_AUTH_CLIENTID=admin --from-literal=MFPF_ADMIN_AUTH_SECRET=admin

kubectl create secret generic mf-push-client --from-literal=MFPF_PUSH_AUTH_CLIENTID=admin --from-literal=MFPF_PUSH_AUTH_SECRET=admin
```

Si no se proporcionan los valores de los campos `mfpserver.pushClientSecret`, `mfpserver.adminClientSecret` y `mfpserver.liveupdateClientSecret` durante la instalación del gráfico de helm, se crean los secretos del cliente predeterminados respectivamente con las credenciales siguientes, como se indica a continuación:

* `admin / nimda` for `mfpserver.adminClientSecret`
* `push / hsup` for `mfpserver.pushClientSecret`
* `liveupdate / etadpuevil` for `mfpserver.liveupdateClientSecret`

## [OPCIONAL] Configuración del servidor personalizada

Para personalizar la configuración, (por ejemplo, para modificar un valor de rastreo de registro, añadir una nueva propiedad jndi, etc.), tendrá que crear un mapa de configuración con el archivo XML de configuración. Esto le permite añadir un nuevo valor de configuración o reemplazar las configuraciones existentes de los componentes de Mobile Foundation. 

Los componentes de Mobile Foundation acceden a la configuración personalizada mediante un configMap (mfpserver-custom-config) que se puede crear del modo siguiente -

```
kubectl create configmap mfpserver-custom-config --from-file=<configuration file in XML format>
```

El configmap creado utilizando el mandato anterior se debe proporcionar en la **Configuración del servidor personalizada** del gráfico Helm durante el despliegue de Mobile Foundation.

El siguiente es un ejemplo de cómo establecer la especificación del registro de rastreo, (el valor predeterminado es info) utilizando mfpserver-custom-config configmap.

- XML de configuración de ejemplo (logging.xml)

```
<server>
        <logging maxFiles="5" traceSpecification="com.ibm.mfp.*=debug:*=warning"
        maxFileSize="20" />
</server>
```

- Cree configmap y añádalo durante el despliegue del gráfico helm 

```
kubectl create configmap mfpserver-custom-config --from-file=logging.xml
```

- Observe el cambio en messages.log (de los componentes de Mobile Foundation) - ***La propiedad traceSpecification se establecerá en com.ibm.mfp.=debug:\*=warning.***

## [OPCIONAL] Utilización de claves LTPA generadas personalizadas

De forma predeterminada, las imágenes de Mobile Foundation empaquetan un conjunto de `ltpa.keys` para cada componente de Mobile Foundation. En el entorno de producción, cuando es necesario actualizar `ltpa.keys` listo para usar con los valores generados personalizados, puede utilizar la configuración personalizada para añadir cualquier `ltpa.keys` personalizado generado junto con el xml de configuración.

El siguiente es un `ltpa.xml` de configuración de ejemplo. 

```xml
<server description="mfpserver">
    <ltpa
        keysFileName="ltpa.keys" />
    <webAppSecurity ssoUseDomainFromURL="true" />
</server>
```

El mandato siguiente es un ejemplo cómo añadir las claves LTPA personalizadas.

```bash
kubectl create configmap mfpserver-custom-config --from-file=ltpa.xml --from-file=ltpa.keys
```

Para obtener más detalles acerca de la generación de claves LTPA y otros detalles, consulte la [Documentación de Liberty](https://www.ibm.com/support/knowledgecenter/en/SSEQTP_liberty/com.ibm.websphere.wlp.doc/ae/twlp_sec_ltpa.html).

**Nota:** Tener varios custom-configmaps no está soportado para añadir la configuración personalizada, en su lugar se recomienda crear el *configmap* de configuración personalizada como se indica a continuación.

```bash
kubectl create configmap mfpserver-custom-config --from-file=ltpa.xml --from-file=ltpa.keys --from-file=moreconfig.xml
```
