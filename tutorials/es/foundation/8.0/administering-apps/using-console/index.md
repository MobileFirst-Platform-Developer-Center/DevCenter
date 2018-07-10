---
layout: tutorial
title: Administración de aplicaciones a través de MobileFirst Operations Console
breadcrumb_title: Administrating using the console
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
Administre las aplicaciones de {{ site.data.keys.product_adj }} a través de {{ site.data.keys.mf_console }}, bloqueando aplicaciones, denegando el acceso o visualizando mensajes de notificación.

Inicie la consola especificando uno de los siguientes URL:

* Modalidad segura para producción o prueba: `https://hostname:secure_port/mfpconsole`
* Desarrollo: `http://server_name:port/mfpconsole`

Debe poseer un identificador para iniciar una sesión y una contraseña que le otorguen autorización para acceder a {{ site.data.keys.mf_console }}. Para obtener más información, consulte [Configuración de autenticación de usuario para la administración de {{ site.data.keys.mf_server }}](../../installation-configuration/production/server-configuration/#configuring-user-authentication-for-mobilefirst-server-administration).

Puede utilizar {{ site.data.keys.mf_console }} para gestionar las aplicaciones.

Desde {{ site.data.keys.mf_console }}, también puede acceder a la consola de Analíticas y controlar la recopilación de datos móviles para su análisis mediante el servidor de Analíticas. Para obtener más información, consulte [Habilitación o inhabilitación de la recopilación de datos desde {{ site.data.keys.mf_console }}](../../analytics/console/#enabledisable-analytics-support).

#### Ir a
{: #jump-to }

* [Gestión de aplicaciones móviles](#mobile-application-management)
* [Estado de aplicación y gestión de licencias de señal](#application-status-and-token-licensing)
* [Registro de errores de operaciones en entornos de tiempo de ejecución](#error-log-of-operations-on-runtime-environments)
* [Registro de auditoría de operaciones de administración](#audit-log-of-administration-operations)

## Gestión de aplicaciones móviles
{: #mobile-application-management }
Las funcionalidades de {{ site.data.keys.product_adj }} proporcionan a los administradores y a los operadores de {{ site.data.keys.mf_server }} un control granular sobre el acceso de los usuarios y dispositivos a sus aplicaciones.

{{ site.data.keys.mf_server }} realiza un seguimiento del acceso a su infraestructura móvil, almacena información sobre la aplicación, el usuario y los dispositivos en los que ha instalado la aplicación. La correlación entre la aplicación, el usuario y el dispositivo, forma la base de las funcionalidades de gestión de aplicaciones móviles del servidor.

Utilice IBM {{ site.data.keys.mf_console }} para supervisar y gestionar el acceso a los recursos:

* Buscar un usuario por nombre, y ver la información sobre los dispositivos y las aplicaciones que se están utilizando para acceder a sus recursos.
* Buscar un dispositivo por su nombre para mostrar, y ver los usuarios asociados con el dispositivo, y las aplicaciones de {{ site.data.keys.product_adj }} registradas en este dispositivo.
* Bloquear el acceso a sus recursos desde todas las instancias de sus aplicaciones en un dispositivo específico. Esto es útil cuando un dispositivo se pierde o es robado.
* Bloquear el acceso a los recursos sólo para una aplicación específica en un dispositivo específico. Por ejemplo, si un empleado cambia de departamento, y desea que el empleado acceda desde otras aplicaciones en el mismo dispositivo.
* Anular el registro de un dispositivo, y suprimir todos los datos de registro y supervisión que se han recopilado para el dispositivo.

El bloqueo de acceso tiene las siguientes características:

* La operación de bloqueo es reversible. Puede eliminar el bloque cambiando el estado del dispositivo o de la aplicación en {{ site.data.keys.mf_console }}.
* El bloqueo sólo se aplica a los recursos protegidos. Un cliente bloqueado puede seguir utilizando la aplicación para acceder a recursos no protegidos. Consulte Recursos no protegidos.
* El acceso a recursos de adaptador en {{ site.data.keys.mf_server }} se bloquea de forma inmediata cuando se selecciona esta operación. Sin embargo, puede que esto no sea el caso con recursos en un servidor externo porque la aplicación podría seguir teniendo una señal de acceso válida que no hubiese caducado.

### Estado de dispositivo
{: #device-status }
{{ site.data.keys.mf_server }} mantiene información de estado para cada dispositivo que accede al servidor. Los valores de estado posibles son **Activo**, **Perdido**, **Robado**, **Caducado** e **Inhabilitado**.

El estado de dispositivo predeterminado es **Activo**, lo que indica que el acceso desde este dispositivo no está bloqueado. Puede cambiar el estado a **Perdido**, **Robado** o **Inhabilitado** para bloquear el acceso desde el dispositivo a los recursos de su aplicación. Siempre puede restaurar el estado **Activo** para permitir de nuevo el acceso. Consulte [Gestión de acceso de dispositivos en {{ site.data.keys.mf_console }}](#managing-device-access-in-mobilefirst-operations-console).

El estado **Caducado** es un estado especial que {{ site.data.keys.mf_server }} establece después de un tiempo de espera de inactividad configurado de forma previa desde la última vez que el dispositivo se conectó a esta instancia de servidor. Este estado se utiliza para el seguimiento de la gestión de licencias, y no afecta a los derechos de acceso del dispositivo. Cuando un dispositivo con un estado **Caducado** se vuelve a conectar con el servidor, su estado se restaura a **Activo**, y se le otorga acceso al servidor.

### Nombre para mostrar de dispositivo
{: #device-display-name }
{{ site.data.keys.mf_server }} identifica a los dispositivos mediante un ID de dispositivo exclusivo, que el SDK de cliente {{ site.data.keys.product_adj }} asigna. El establecer un nombre para mostrar para un dispositivo permite buscar el dispositivo por dicho nombre para mostrar. Los desarrolladores de aplicaciones pueden utilizar el método `setDeviceDisplayName` de la clase `WLClient` para establecer el nombre de dispositivo para mostrar. Consulte la documentación de `WLClient` en la [API del lado del cliente de {{ site.data.keys.product_adj }}](../../api/client-side-api/javascript/client/). (La clase JavaScript es `WL.Client`). Los desarrolladores de adaptadores de Java (incluidos los desarrolladores de comprobaciones de seguridad) también pueden establecer el nombre para mostrar del dispositivo utilizando el método `setDeviceDisplayName` de la clase `MobileDeviceData` de com.ibm.mfp.server.registration.external.model. Consulte [MobileDeviceData](../../api/client-side-api/objc/client/).

### Gestión de acceso de dispositivos en {{ site.data.keys.mf_console }}
{: #managing-device-access-in-mobilefirst-operations-console }
Para supervisar y gestionar el acceso a los recursos de los dispositivos, seleccione el separador Dispositivos en el Panel de control de {{ site.data.keys.mf_console }}.

Utilice el campo de búsqueda para buscar un dispositivo por su ID de usuario asociado al dispositivo, o por el nombre para mostrar del dispositivo (si se ha establecido). Consulte [Nombre para mostrar de dispositivo](#device-display-name). También puede buscar parte del ID de usuario o del nombre para mostrar del dispositivo (al menos tres caracteres).

Los resultados de la búsqueda muestran todos los dispositivos que coinciden con el ID de usuario o el nombre para mostrar de dispositivo que se haya especificado. Para cada dispositivo, puede ver el ID de dispositivo y el nombre para mostrar, el modelo del dispositivo, el sistema operativo y la lista de ID de usuario asociados con el dispositivo.

El columna Estado de dispositivo muestra el estado del dispositivo. Puede cambiar el estado del dispositivo a **Perdido**, **Robado** o **Inhabilitado**, para bloquear el acceso desde el dispositivo a los recursos protegidos. Al cambiar el estado de nuevo a **Activo** restaura los derechos de acceso originales.

Puede anular el registro de un dispositivo seleccionando **Anular registro** en la columna **Acciones**. Cuando se anula el registro de un dispositivo, suprime los datos de registro de todas las aplicaciones de {{ site.data.keys.product_adj }} que estaban instaladas en el dispositivo. Además, se suprime el nombre para mostrar del dispositivo, las listas de usuarios asociados con el dispositivo y los atributos públicos que la aplicación registró para este dispositivo.

**Nota:** La acción **Anular el registro** no es reversible. La siguiente vez que una de las aplicaciones de {{ site.data.keys.product_adj }} en el dispositivo intente acceder al servidor, será registrada de nuevo con un nuevo ID de dispositivo. Cuando seleccione registrar el dispositivo de nuevo, el estado del dispositivo se establecerá en **Activo**, y tendrá acceso a los recursos protegidos, independientemente cualquier bloqueo anterior. Por lo tanto, si desea bloquear un dispositivo, no anule su registro. En su lugar, cambie el estado del dispositivo a **Perdido**, **Robado** o **Inhabilitado**.

Para visualizar todas las aplicaciones que accedieron a un dispositivo específico, seleccione el icono de flecha para expandirlo junto al ID de dispositivo en la tabla de dispositivos. Cada fila en la tabla de aplicaciones visualizadas contiene el nombre de la aplicación y su estado de acceso (si el acceso a recursos protegidos está habilitado para esta aplicación en este dispositivo). Puede cambiar el estado de la aplicación a **Inhabilitado** para bloquear el acceso desde la aplicación específicamente en este dispositivo.

#### Ir a
{: #jump-to-1 }

* [Inhabilitación de forma remota del acceso de la aplicación a recursos protegidos](#remotely-disabling-application-access-to-protected-resources)
* [Visualización de un mensaje de administrador](#displaying-an-administrator-message)
* [Definición de mensajes de administrador en varios idiomas](#defining-administrator-messages-in-multiple-languages)

### Inhabilitación de forma remota del acceso de la aplicación a recursos protegidos
{: #remotely-disabling-application-access-to-protected-resources }
Utilice {{ site.data.keys.mf_console }} (la consola) para inhabilitar el acceso de usuario de una versión de aplicación específica en un sistema operativo móvil específico y proporcionar un mensaje personalizado al usuario.

1. Seleccione su versión de aplicación en la sección **Aplicaciones** de la barra lateral de navegación de la consola y, a continuación, seleccione el separador **Gestión** de aplicaciones.
2. Cambie el estado a **Acceso inhabilitado**.
3. En el campo **URL de la versión más reciente**, proporcione de forma opcional un URL para una nueva versión de la aplicación (habitualmente en la tienda de aplicaciones privada o pública apropiada). Para algunos entornos, Application Center proporciona un URL para acceder a la vista Detalles directamente de una versión de aplicación versión. Consulte [Propiedades de aplicación](../../appcenter/appcenter-console/#application-properties).
4. En el **Mensaje de notificación predeterminado**, añada el mensaje de notificación personalizado a visualizar cuando el usuario intente acceder a la aplicación. El siguiente mensaje de ejemplo indica a los usuarios a que actualicen a la última versión:

   ```bash
   Ya no se da soporte a esta versión. Actualice a la última versión.
   ```

5. En la sección **Entornos locales soportados**, puede proporcionar de forma opcional el mensaje de notificación en otros idiomas.
6. Seleccione **Guardar** para aplicar los cambios.

Cuando un usuario ejecuta una aplicación que se ha inhabilitado de forma remota, se visualiza una ventana de diálogo con su mensaje personalizado. El mensaje se muestra con cualquier interacción de la aplicación que precise acceso a un recurso protegido, o cuando la aplicación intente acceder a una señal de acceso. Si proporcionó un URL de actualización de versión, el recuadro de diálogo tiene un botón **Obtener una versión nueva** para actualizar a una nueva versión, además del botón **Cerrar** predeterminado. Si el usuario cierra la ventana de diálogo sin actualizar la versión, puede continuar trabajando con las partes de la aplicación que no necesiten acceso a los recursos protegidos. Sin embargo, cualquier interacción de aplicación que requiera acceder a un recurso protegido hará que la ventana de diálogo se visualice de nuevo, y a la aplicación no se le otorgará acceso al recurso.

<!-- **Note:** For cross-platform applications, you can customize the default remote-disable behavior: provide an upgrade URL for your application, as outlined in Step 3, and set the **showCloseOnRemoteDisableDenial** attribute in your application's initOptions.js file to false. If the attribute is not defined, define it. When an application-upgrade URL is provided and the value of **showCloseOnRemoteDisableDenial** is false, the **Close** button is omitted from the remote-disable dialog window, leaving only the Get new version button. This forces the user to upgrade the application. When no upgrade URL is provided, the **showCloseOnRemoteDisableDenial** configuration has no effect, and a single **Close** button is displayed. -->

### Visualización de un mensaje de administrador
{: #displaying-an-administrator-message }
Siga el procedimiento que se indica para configurar el mensaje de notificación. Puede utilizar este mensaje para notificar a los usuarios de la aplicación de situaciones de carácter temporal, como por ejemplo un tiempo de inactividad planificado del servicio.

1. Seleccione su versión de aplicación en la sección **Aplicaciones** de la barra lateral de navegación de {{ site.data.keys.mf_console }} y, a continuación, seleccione el separador Gestión de aplicaciones.
2. Cambie el estado a **Activo y notificando**.
3. Añada un mensaje de inicio personalizado. El siguiente mensaje de ejemplo notifica al usuario de tareas de mantenimiento planificadas para la aplicación:

   ```bash
   El servidor no estará disponible el sábado entre las 4 horas y las 18 horas debido a un mantenimiento planificado.
   ```

4. En la sección Entornos locales soportados, puede proporcionar de forma opcional el mensaje de notificación en otros idiomas.

5. Seleccione **Guardar** para aplicar los cambios.

El mensaje se visualiza cuando la aplicación utiliza {{ site.data.keys.mf_server }} por primera vez para acceder a un recurso protegido o al obtener una señal de acceso. Si la aplicación adquiere una señal de acceso cuando ésta se inicia, el mensaje se visualiza en esta etapa. De lo contrario, el mensaje se visualiza con la primera solicitud desde la aplicación para acceder a un recurso protegido o al obtener una señal de acceso. El mensaje se visualiza sólo una vez, en la primera interacción.

### Definición de mensajes de administrador en varios idiomas
{: #defining-administrator-messages-in-multiple-languages }
<b>Nota:</b> En Microsoft Internet Explorer (IE) y Microsoft Edge, los mensajes administrativos se visualizan de acuerdo a las preferencias de formato regional del sistema operativo y no de acuerdo a la configuración del navegador o las preferencias de idioma de visualización del sistema operativo. Consulte [Limitaciones con las aplicaciones web en IE Edge](../../product-overview/release-notes/known-issues-limitations/#web_app_limit_ms_ie_n_edge).

Siga el siguiente procedimiento para configurar varios idiomas para visualizar los mensajes de administración de la aplicación que definió a través de la consola. Los mensajes se envían de acuerdo al entorno local del dispositivo, y deben cumplir con los estándares que el sistema operativo móvil utiliza para especificar entornos locales.

1. Seleccione su versión de aplicación en la sección **Aplicaciones** de la barra lateral de navegación de {{ site.data.keys.mf_console }} y, a continuación, seleccione el separador **Gestión** de aplicaciones.
2. Seleccione el estado **Activo y notificando** o **Acceso inhabilitado**.
3. Seleccione **Actualizar entornos locales**. En la sección **Subir archivo** de la ventana de diálogo visualizada, seleccione **Subir**, y vaya a la ubicación de un archivo CSV que defina los entornos locales.

   Cada línea en el archivo CSV contiene un pareja de series separadas por coma. La primera serie es el código del entorno local (como, por ejemplo, fr-FR para francés (Francia) o en para inglés), y la segunda serie es el texto del mensaje en correspondiente idioma. Los códigos de entorno local que se especifiquen deben cumplir los estándares que el sistema operativo utilice para especificar entornos locales como, por ejemplo, ISO 639-1, ISO 3166-2 e ISO 15924.

   > **Nota:** Para crear un archivo CSV, debe utilizar un editor que de soporte a la codificación UTF-8 como, por ejemplo, Notepad.

   A continuación, se muestra un ejemplo de archivo CSV que define el mismo mensaje para varios entornos locales:

   ```xml
   en,Your application is disabled
   en-US,Your application is disabled in US
   en-GB,Your application is disabled in GB
   fr,votre application est désactivée
   he,האפליקציה חסמומה
   ```

4. En la sección **Verificar mensaje de notificación**, puede ver una tabla de los mensajes de los códigos de entorno local y los mensajes en su archivo CSV. Verifique los mensajes, y seleccione **Aceptar**.
Puede seleccione Editar en cualquier momento, para sustituir el archivo de CSV de entornos locales. También puede utilizar esta opción para subir un archivo CSV vacío para eliminar todos los entornos locales.
5. Seleccione **Guardar** para aplicar los cambios.

El mensaje de notificación localizado se visualiza en el dispositivo móvil del usuario, de acuerdo al entorno local del dispositivo. Si no se ha configurado ningún mensaje para el entorno local del dispositivo, se visualizará el mensaje predeterminado que proporcionó.

## Estado de aplicación y gestión de licencias de señal
{: #application-status-and-token-licensing }
Debe restaurar de forma manual el estado de aplicación correcto en {{ site.data.keys.mf_console }} después de un estado Bloqueado debido a la falta de señales.

Si utiliza la gestión de licencias y deja de tener suficientes señales de licencia para una aplicación, el estado de la aplicación de todas las versiones de la aplicación cambian a **Bloqueado**. Ya no podrá cambiar el estado de ninguna versión de la aplicación. Se visualiza el siguiente mensaje en {{ site.data.keys.mf_console }}:

```bash
Se bloqueó la aplicación porque su licencia caducó
```

Si más tarde se liberan suficientes señales para ejecutar la aplicación o si su organización compra más señales, se visualiza el siguiente mensaje en {{ site.data.keys.mf_console }}:

```bash
Se bloqueó la aplicación porque su licencia caducó, sin embargo, ahora hay disponible una licencia
```

El estado que se visualiza siguiendo **Bloqueado**. Debe restaurar el estado actual correcto de forma manual desde la memoria o desde sus propios registros editando el campo Estado. {{ site.data.keys.product }} no gestiona la visualización del estado **Bloqueado** en {{ site.data.keys.mf_console }} de una aplicación que se bloqueó debido un número insuficiente de señales de licencia. El usuario es el responsable de restaurar una aplicación bloqueada al estado real que se puede visualizar a través de {{ site.data.keys.mf_console }}.

## Registro de errores de la operación en entornos de tiempo de ejecución
{: #error-log-of-operations-on-runtime-environments }
Utilice el registro de errores para acceder a las operaciones de gestión con errores iniciadas desde {{ site.data.keys.mf_console }} o desde la línea de mandatos en el entorno de tiempo de ejecución seleccionado, y para ver el efecto de los errores en los servidores.

Cuando una transacción falla, la barra de estado muestra una notificación del error y muestra un enlace al registro de errores. Utilice el registro de errores para obtener más detalles acerca del error, por ejemplo, el estado de cada servidor con un mensaje de error específico, o para tener un historial de errores. El registro de errores muestra la operación más reciente en primer lugar.

Acceda al registro de errores pulsando **Registro de errores** de un entorno de tiempo de ejecución en {{ site.data.keys.mf_console }}.

Amplíe la fila que hace referencia a la operación errónea para acceder a más información sobre el estado actual de cada servidor. Para acceder a todo el registro, descárguelo pulsando **Descargar registro**.

![Registro de errores en la consola](error-log.png)

## Registro de auditoría de operaciones de administración
{: #audit-log-of-administration-operations }
En {{ site.data.keys.mf_console }}, puede hacer referencia a un registro de auditoría de las operaciones de administración.

{{ site.data.keys.mf_console }} proporciona acceso a un registro de auditoría para el inicio de sesiones, finalización de sesiones y todas las operaciones administración como, por ejemplo, el despliegue de aplicaciones y adaptadores o aplicaciones bloqueadas. El registro de auditoría se puede inhabilitar estableciendo la propiedad Java Naming and Directory Interface (JNDI) **mfp.admin.audit** del servicio de administración de {{ site.data.keys.product_adj }} en **false**.

Para acceder al registro de auditoría, pulse el nombre de usuario en la barra de la cabecera y seleccione **Acerca de **, pulse **Soporte adicional** y, a continuación, **Descargar registro de auditoría**.

|Nombre de campo |Descripción |
|------------|-------------|
|Timestamp	 |Fecha y hora en que se creó el registro. |
|Type	     |Tipo de operación. Consulte la lista de tipos de operación para conocer los posibles valores. |
|User	     |El **nombre_usuario** del usuario que ha iniciado la sesión. |
|Outcome	 |El resultado de la operación. Los posibles valores son SUCCESS, ERROR, PENDING. |
|ErrorCode	 |Si el resultado es ERROR, ErrorCode indica qué error es. |
|Runtime	 |Nombre del proyecto {{ site.data.keys.product_adj }} asociado a esta operación. |

En la siguiente lista se muestran los posibles valores del tipo de operación.

* Login
* Logout
* AdapterDeployment
* AdapterDeletion
* ApplicationDeployment
* ApplicationDeletion
* ApplicationLockChange
* ApplicationAuthenticityCheckRuleChange
* ApplicationAccessRuleChange
* ApplicationVersionDeletion
* add config profile
* DeviceStatusChange
* DeviceApplicationStatusChange
* DeviceDeletion
* unsubscribeSMS
* DeleteDevice
* DeleteSubscriptions
* SetPushEnabled
* SetGCMCredentials
* DeleteGCMCredentials
* sendMessage
* sendMessages
* setAPNSCredentials
* DeleteAPNSCredentials
* setMPNSCredentials
* deleteMPNSCredentials
* createTag
* updateTag
* deleteTag
* add runtime
* delete runtime
