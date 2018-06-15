---
layout: tutorial
title: Consolas de operaciones y de analíticas
breadcrumb_title: Analytics Console
relevantTo: [ios,android,javascript]
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->

## Visión general
Configure el modo en que el cliente funcionará con {{ site.data.keys.mf_analytics_server }}, configure y visualice una amplia gama de informes utilizando las consolas de analíticas y operaciones.

## {{ site.data.keys.mf_analytics_console_full }}
Desde la {{ site.data.keys.mf_analytics_console }}, visualice y configure los informes de las analíticas. Gestione alertas y visualice registros de cliente.

Abra {{ site.data.keys.mf_analytics_console_short }} desde {{ site.data.keys.mf_console }} pulsando el enlace **Analytics Console** en la barra de navegación superior derecha.

![Botón de la consola de analíticas](analytics-console-button.png)

Después de navegar a {{ site.data.keys.mf_analytics_console_short }}, aparece el **Panel de control** predeterminado. Si una aplicación de cliente ya ha enviado registros y datos de analíticas al servidor, los informes relevantes aparecen cumplimentados. Desde la barra de navegación se pueden elegir **Aplicaciones** e **Infraestructura**.

![Analytics Console](analytics-console.png)

### Panel de control
En el **Panel de control**, puede revisar los datos de las analíticas recopiladas relacionados con bloqueos de aplicación, sesiones de aplicación y tiempo de proceso del servidor. Además puede crear gráficos personalizados y gestionar alertas.

### Aplicaciones
En el panel **Aplicaciones**, revise en profundidad datos de analíticas relacionadas con el uso y los dispositivos (como, por ejemplo, el total de sesiones de aplicaciones y dispositivos, usuarios activos, uso de aplicaciones, nuevos dispositivos, uso de modelo y sistema operativo), así como datos relacionados con los bloqueos. Busque en los registros de cliente aplicaciones y dispositivos específicos (**Aplicaciones → Buscar en registro de clientes**).


### Infraestructura
El panel **Infraestructura** permite revisar los datos de las analíticas relacionadas con: el tiempo de proceso de sesión, el tamaño medio de las solicitudes, las solicitudes de servidor, el tiempo de respuesta de los adaptadores, el tiempo de respuesta de los procedimientos y el tamaño y uso de los adaptadores, así como datos de las notificaciones push como, por ejemplo, solicitudes de notificación e información de mediador. También es posible buscar información en los registros de servidor.

> Obtenga más información en la guía de aprendizaje de [Flujos de trabajo de analíticas](../workflows/).

> **Nota:**Las funcionalidades de datos del registro cliente/servidor **Buscar** y **Exportar** no invocan una acción en el suceso de click de ratón cuando se modifica el filtro de fecha, tal y como se observa en versiones recientes del navegador Chrome. Este comportamiento viene causado por un problema con el navegador Chrome y también por una limitación conocida. Este problema no se produce en otros navegadores ni en versiones de Chrome anteriores a la *v54.0.2840.71*. En las versiones más recientes del navegador Chrome, los usuarios pueden utilizar el método alternativo de establecer la fecha requerida y a continuación actualizar la página antes de pulsar el botón de Buscar/Exportar, o pueden pulsar la tecla Intro/Return para llevar a cabo la acción seleccionada.

## Características de analíticas

### Analíticas de aplicaciones
Desde el separador **Aplicaciones → Uso y dispositivos**, visualice gráficos de Sesiones de aplicación y Uso de aplicaciones para encontrar la aplicación que sus usuarios están utilizando con más frecuencia.

### Analíticas incorporadas
Cuando se utiliza el SDK de cliente de {{ site.data.keys.product_adj }} junto con {{ site.data.keys.mf_server }}, se recopilan de forma automática todos los datos de las solicitudes que su aplicación realiza a {{ site.data.keys.mf_server }}. Desde **Panel de control → Visión general** visualice metadatos de dispositivos que se recopilan y de los que se informa a {{ site.data.keys.mf_analytics_server }}.

### Analíticas personalizadas
Puede hacer que su aplicación envíe datos personalizados y cree gráficos personalizados con dichos datos.

> Aprenda a enviar analíticas personalizadas con la ayuda de la guía de aprendizaje de [API de analíticas](../analytics-api/).

### Gráficos personalizados
Los gráficos personalizados permiten visualizar los datos recopilados en el almacén de datos de analíticas como gráficos que no están disponibles de forma predeterminada en {{ site.data.keys.mf_analytics_console_short }} (**Panel de control → Gráficos personalizados**). Esta característica de visualización es una manera efectiva de analizar los datos más significativos de la empresa.

> Aprenda a crear gráficos personalizados en la guía de aprendizaje [Creación de gráficos personalizados](custom-charts/).

### Gestión de alertas
Las alertas proporcionan unos medios proactivos para supervisar la salida de las aplicaciones móviles sin tener que comprobar {{ site.data.keys.mf_analytics_console }} de forma periódica.

Desde el separador **Panel de control → Gestión de alertas**, puede configurar umbrales, que si se superan, desencadenan alertas para notificar a los administradores. Las alertas que se desencadenan se pueden visualizar en la consola o se puede permitir que enganches web personalizados las manejen. Un enganche web personalizado permite controlar quién será notificado cuando se desencadene una alerta y cómo.

> Aprenda a gestionar alertas en la guía de aprendizaje [Gestión de alertas](alerts/).

### Supervisión de bloqueos de aplicaciones
Los bloqueos de las aplicaciones se visualizan en {{ site.data.keys.mf_analytics_console_short }} (**Aplicaciones → Bloqueos**), que permite visualizar con rapidez bloqueos para actuar en consecuencia. De forma predeterminada, los registros de bloqueos se recopilan en el dispositivo y se envían al servidor *una vez la aplicación se ejecuta de nuevo*. Cuando los registros de bloqueo se envían a las analíticas servidor, automáticamente cumplimentan los gráficos de bloqueos.

### Supervisión del servidor y datos de red
{{ site.data.keys.mf_analytics_console_short }} supervisa los datos de red cuando se envían al servidor de analíticas y permite al usuario consultar esta información de distintas formas (**Infraestructura → Servidores y redes**).


### Recopilación, búsqueda e información sobre los registros de cliente
Los registros de cliente se pueden enviar al servidor para incluirlos en informes de analíticas.

Para incluir información de registro en un informe:

1. Desde {{ site.data.keys.mf_analytics_console_short }}, elija el separador **Panel de control → Gráficos personalizados**.

2. Elija **Registros de cliente** en el menú desplegable **Tipo de suceso**.

Para obtener más información sobre los **Gráficos personalizados**, consulte [Creación de gráficos personalizados](custom-charts/).

Los datos de registro se pueden filtrar. Los filtros de registro se configuran y guardan en el servidor de analíticas y, a continuación, las aplicaciones de cliente los recuperan.

Para obtener información sobre cómo configurar los filtros de registro, consulte la guía de aprendizaje de [Búsquedas de registro de cliente](log-filters/).

Para obtener más información sobre cómo enviar registros desde el cliente, consulte [Recopilación de registros de cliente](../../application-development/client-side-log-collection/).



## {{ site.data.keys.mf_console_full }}
Configuración y administración del servidor de analíticas con {{ site.data.keys.mf_console }}.

Si se encuentra en {{ site.data.keys.mf_analytics_console_short }}, acceda a {{ site.data.keys.mf_console }} pulsando el botón **Consola de operaciones** en la parte superior barra de navegación.

### Recopilación de datos de analíticas de paquetes registradores adicionales
De forma predeterminada, solo se envían como analíticas los registros del paquete `com.worklight`. Para añadir registros y paquetes adicionales, consulte [Reenvío de registros al servidor de analíticas](../../adapters/server-side-log-collection/java-adapter/#forwarding-logs-to-the-analytics-server).


### Habilitación e inhabilitación del soporte de analíticas
{: #enabledisable-analytics-support}

De forma predeterminada está habilitada la recopilación de datos para el análisis por parte del servidor de analíticas. Existe la posibilidad de inhabilitarla, por ejemplo para ahorrar tiempo de proceso.

1. En la barra lateral de navegación, pulse en **Valores de tiempo de ejecución**. Para evitar de cambios accidentales, las propiedades de tiempo de ejecución se muestran en una modalidad de sólo lectura.
2. Para editar los valores, pulse el botón **Editar**. Se inicia una sesión con un rol distinto de *administrator* o *deployer*, el botón **Editar** no está visible porque no está autorizado a modificar propiedades de tiempo de ejecución.
3. Desde el menú desplegable **Habilitada la recopilación de datos**, seleccione **falso** para inhabilitar la recopilación de datos.
4. Pulse **Guardar**.
5. Pulse el botón de **Sólo lectura** para bloquear de nuevo las propiedades.


![Habilitar o inhabilitar el soporte de analíticas en la consola](enable-disable-analytics.png)


### Control de acceso basado en el rol
El contenido en {{ site.data.keys.mf_analytics_console_short }} viene restringido por roles de seguridad definidos de forma previa.  
{{ site.data.keys.mf_analytics_console_short }} visualiza contenidos diferentes en función del rol de seguridad del usuario que ha iniciado la sesión. En la tabla siguiente se muestran los roles de seguridad y su acceso a {{ site.data.keys.mf_analytics_console_short }}.

| Rol           | Nombre de rol                | Acceso de visualización                                                     | Acceso de edición  |
|----------------|--------------------------|--------------------------------------------------------------------|-----------------|
| Administrator  | analytics_administrator  | Todo.	                                                     | Todo.     |
| Infrastructure | analytics_infrastructure	| Todo.	                                                     | Todo.     |
| Developer      | analytics_developer	    | Todo excepto páginas del administrador.		             | Todo.     |
| Support        | analytics_support        | Todo excepto páginas del administrador.		             | Todo.     |
| Business       | analytics_business       | Todo excepto páginas del administrador y de infraestructura. | Todo.     |

> Para obtener información sobre cómo configurar roles, consulte [Configuración de la autenticación de usuarios para la administración de {{ site.data.keys.mf_server }}](../../installation-configuration/production/server-configuration#configuring-user-authentication-for-mobilefirst-server-administration).


## Artículos de blog relacionados
* [Más información sobre la instrumentación de analíticas personalizadas]({{site.baseurl}}/blog/2016/01/22/howto-custom-in-app-behavior-analytics/)
* ´[Más información sobre los enganches web]({{site.baseurl}}/blog/2015/10/19/using-mfp-adapters-endpoint-analytics-alerts-webhooks/)
