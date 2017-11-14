---
layout: tutorial
title: Contrato de comprobación de seguridad
breadcrumb_title: contrato de comprobación de seguridad
relevantTo: [android,ios,windows,javascript]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
Cada comprobación de seguridad debe implementar la interfaz `com.ibm.mfp.server.security.external.SecurityCheck` (la interfaz de comprobación de seguridad). Esta interfaz constituye el contrato básico entre la comprobación de seguridad y la infraestructura de seguridad de {{ site.data.keys.product_adj }}. La implementación de comprobación de seguridad debe cumplir con los siguientes requisitos: 

* **Funciones**: la comprobación de seguridad debe proporcionar las funciones `authorization` e `introspection` de cliente.
* **Gestión de estado**: la comprobación de seguridad debe gestionar el estado, incluidas la creación, la venta y la gestión del estado actual. 
* **Configuración**: la comprobación de seguridad debe crear un objeto de configuración de comprobación de seguridad que defina las propiedades de configuración de comprobación de seguridad soportadas y valide los tipos y valores de personalizaciones de la configuración básica.

Para obtener una referencia completa de la interfaz de comprobación de seguridad, [ consulte `SecurityCheck` en la referencia API](../../../api/server-side-api/java/).

## Funciones de comprobación de seguridad
{: #securityc-check-functions }
Una comprobación de seguridad proporciona a la infraestructura de seguridad dos funciones principales:

### Autorización
{: #authorization }
La infraestructura utiliza el método `SecurityCheck.authorize` para autorizar las solicitudes de cliente. Cuando el cliente solicita acceso a un ámbito OAuth específico, la infraestructura correlaciona los elementos de ámbito en comprobaciones de seguridad. Para las comprobaciones de seguridad en el ámbito, la infraestructura llama al método `authorize` para solicitar autorización para un ámbito que contenga los elementos de ámbito correlacionados en la comprobación de seguridad.El ámbito se proporciona en el parámetro del método **scope**.

La comprobación de seguridad añade la respuesta en el objeto [`AuthorizationResponse` ](../../../api/server-side-api/java/) que se pasa en el parámetro response. La respuesta contiene el nombre de la comprobación de seguridad y el tipo de respuesta, que puede ser un éxito, un error o un desafío ([consulte `AuthorizationResponse.ResponseType`](../../../api/server-side-api/java/)).

Cuando la respuesta contiene un objeto de desafío o datos de error o de éxito, la infraestructura pasa los datos al manejador de desafíos de comprobación de seguridad del cliente en el objeto JSON.Para lograrlo, la respuesta también contiene el ámbito para el que se ha solicitado la autorización (tal y como se ha establecido en el parámetro **scope**), y el tiempo de caducidad de la autorización concedida. Para conceder el acceso de cliente en el ámbito solicitado, el método `authorize` de cada una de las verificaciones de seguridad del ámbito debe realizarse correctamente y todos los tiempos de caducidad deben ser posteriores al tiempo actual.

### Introspección
{: #introspection }
La infraestructura utiliza el método `SecurityCheck.introspect` para recuperar los datos de introspección para el servidor de recursos. Se llama al método de cada comprobación de seguridad contenido en el ámbito para el que se ha solicitado la introspección. Como con el método `authorize`, el método `introspect` recibe un parámetro de **ámbito** que contiene los elementos de ámbito correlacionados en esta comprobación de seguridad. Antes de devolver los datos de introspección, el método verifica que el estado actual de la comprobación de seguridad todavía de soporte a la autorización previamente garantizada para este ámbito. Si la autorización todavía es válida, el método `introspect` añade la respuesta al [objeto IntrospectionResponse](../../../api/server-side-api/java/) que se pasa en el parámetro **response**.

La respuesta contiene el nombre de la comprobación de seguridad, el ámbito para el que se ha solicitado la autorización (tal y como se ha establecido en el parámetro **scope**), la hora de caducidad de la autorización concedida y los datos de introspección solicitados definidos por el usuario. Si no se puede conceder la autorización (por ejemplo, si transcurre la hora de caducidad para un estado previo correcto), el método la devuelve sin añadir ninguna respuesta. 

**Nota:**

* La infraestructura de seguridad recopila los resultados de procesamiento de las comprobaciones de seguridad y pasa los datos relevantes al cliente. El procesamiento de infraestructura no conoce los estados de las comprobaciones de seguridad. 
* Las llamadas a los métodos `authorize` o `introspect` puede resultar en una modificación del estado actual de la comprobación de seguridad, incluso si no ha transcurrido la hora de caducidad del estado actual.

> Obtenga más información acerca de los métodos `authorize` e `introspect` [en el tutorial ExternalizableSecurityCheck](../../externalizable-security-check).

### Gestión de estado de la comprobación de seguridad 
{: #security-check-state-management }
Las comprobaciones de seguridad tiene estado, es decir, la comprobación de seguridad es responsable de rastrear y retener el estado de interacción. En cada autorización o solicitud de introspección, la infraestructura de seguridad recupera los estados de las comprobaciones de seguridad relevantes del almacenamiento externo (normalmente, memoria caché de seguridad). Al final del procesamiento de solicitud, la infraestructura vuelve a almacenar los estados de comprobación de seguridad en el almacenamiento externo. 

El contrato de comprobación de seguridad necesita que una comprobación de seguridad: 

* Implemente la interfaz `java.io.Externalizable`. La comprobación de seguridad utiliza esta interfaz para gestionar la serialización y deserialización del estado.
* Defina una hora de caducidad y un tiempo de espera de inactividad para el estado actual. El estado de la comprobación de seguridad representa una etapa en el proceso de autorización y no puede ser indefinido. Los períodos específicos de la validez de estado y el tiempo de inactividad máximo se establecen en la implementación de comprobación de seguridad, de acuerdo con la lógica implementada. La comprobación de seguridad notifica a la infraestructura de la hora de caducidad seleccionada y del tiempo de espera de inactividad mediante la implementación de los métodos `getExpiresAt` y `getInactivityTimeoutSec` de la interfaz SecurityCheck.

### Configuración de comprobación de seguridad 
{: #security-check-configuration }
Una comprobación de seguridad puede mostrar las propiedades de configuración, cuyos valores pueden personalizarse en el adaptador y en el nivel de aplicación.La definición de comprobación de seguridad de una clase específica determina cual de las propiedades de configuración soportadas de esta clase deben exponerse, y puede personalizar los valores predeterminados establecidos en la definición de clase. Los valores de propiedad pueden ser más personalizables y dinámicos para el adaptador que define las comprobaciones de seguridad y para cada aplicación que utiliza la comprobación. 

Una clase de comprobación de seguridad muestra las propiedades soportadas al implementar un método `createConfiguration`, lo que crea una instancia de una clase de configuración de comprobación de seguridad que implementa la interfaz `com.ibm.mfp.server.security.external.SecurityCheckConfiguration` (interfaz de configuración de la comprobación de seguridad).Esta interfaz complementa la interfaz de `SecurityCheck` y también es parte del contrato de comprobación de seguridad. La comprobación de seguridad puede crear un objeto de configuración que no expone ninguna propiedad, pero el método `createConfiguration` debe devolver un objeto de configuración válido y no puede devolver un valor nulo. Para obtener una referencia completa de la interfaz de configuración de comprobación de seguridad, consulte [`SecurityCheckConfiguration`](../../../api/server-side-api/java/).

La infraestructura de seguridad llama al método `createConfiguration` de la comprobación de seguridad durante el despliegue que se produce en las modificaciones de configuración de cualquier adaptador o aplicación. El parámetro de propiedades del método contiene las propiedades que se definen en la definición de comprobación de seguridad, y los valores personalizados actuales (o el valor predeterminado si no estaba personalizado). La implementación de la configuración de comprobación de seguridad debería validar los valores de las propiedades recibidas y proporcionar métodos para devolver los resultados de validación. 

La configuración de comprobación de seguridad debe implementar los métodos `getErrors`, `getWarnings`, y `getInfo`. La clase base de configuración de la comprobación de seguridad abstracta [`SecurityCheckConfigurationBase`](../../../api/server-side-api/java/) también define e implementa los métodos `getStringProperty`, `getIntProperty`, and `addMessage` personalizados. Para obtener más detalles, consulte la documentación del código de esta clase.

**Nota:** Los nombres y valores de las propiedades de configuración en la definición de comprobación de seguridad y en la personalización de aplicación o adaptador deben coincidir con las propiedades soportadas y los valores permitidos como se define en la clase de configuración.

> Obtenga más información en [creación de propiedades personalizadas](../#security-check-configuration) en Comprobaciones de seguridad.
