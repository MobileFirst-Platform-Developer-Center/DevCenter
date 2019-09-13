---
layout: tutorial
title: Gestión de alertas
breadcrumb_title: Alerts
relevantTo: [ios,android,javascript]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }

Las alertas proporcionan unos medios proactivos para supervisar la salida de las aplicaciones móviles sin tener que comprobar {{ site.data.keys.mf_analytics_console_full }} de forma periódica.  
Establezca umbrales reactivos en {{ site.data.keys.mf_analytics_console }} para desencadenar alertas cuando se satisfaga un criterio dado.

Establezca umbrales en un nivel amplio (en una aplicación específica) o en un nivel granular (en un dispositivo o en una instancia de aplicación específica). Las configuraciones de alerta se pueden configurar para visualizar información en {{ site.data.keys.mf_analytics_console_short }} y también para enviarla a un enganche o a un punto final REST configurado de forma previa.

Una vez que se desencadenan las alertas, el icono de **Alerta** (en la barra del título de {{ site.data.keys.mf_analytics_console_short }}) visualiza el recuento de alertas en rojo (<img  alt="icono de alerta" style="margin:0;display:inline" src="alertIcon.png"/>). Pulse el icono **Alerta** para ver las alertas.

Hay métodos alternativos disponibles para distribuir las alertas.

**Requisito previo:** Asegúrese de que {{ site.data.keys.mf_analytics_server }} se ha iniciado y está preparado para recibir registros de cliente.

## Gestión de alertas
{: #alert-management }

### Creación de una alerta
{: #creating-an-alert }

En {{ site.data.keys.mf_analytics_console }}:

1. Seleccione el separador **Panel de control→Gestión de alertas**. Pulse el botón **Crear Alerta**.

   ![Separador Gestión de alertas](alert_management_tab.png)

2. Proporcione los valores siguientes: Nombre de alerta, Mensaje, Frecuencia de consulta y Tipo de suceso. Dependiendo del tipo de suceso, cumplimente los recuadros de texto adicionales que aparezcan con los valores apropiados.
3. Una vez se haya especificado todos los valores, pulse **Siguiente**. Aparece el separador **Método de distribución**.

### Separador Método de distribución
{: #distribution-method-tab }

De forma predeterminada, la alerta se visualiza en {{ site.data.keys.mf_analytics_console_short }}.

También puede enviar un mensaje POST con una carga útil JSON tanto a {{ site.data.keys.mf_analytics_console_short }} como a un URL personalizado seleccionando la opción **Analytics Console y Publicación de red**.

Los campos siguientes están disponibles si elige esta opción:

* URL de publicación de red (*necesario*)
* Cabeceras (*opcional*)
* Tipo de autenticación (*necesario*)

<img class="gifplayer"  alt="Creación de una alerta" src="creating-an-alert.png"/>

## Enganche web personalizado
{: #custom-web-hook }

Puede configurar un método de distribución personalizado para una alerta. Por ejemplo: definir un enganche web al que se envía a una carga útil cuando se desencadena una alerta cuando se supera el umbral.

Ejemplo de carga útil:

```json
{
  "timestamp": 1442848504431,
  "condition": {"value":5.0,"operator":"GTE"},
  "value": "CRASH",
  "offenders": [
    { "XXX 1.0": 5.0 },
    { "XXX 2.0": 1.0 }
  ],
  "property":"closedBy",
  "eventType":"MfpAppSession",
  "title":" Crash Count Alert for Application ABC",
  "message": "The crash count for a application ABC exceeded XYZ.
    View the Crash Summary table in the Crashes tab in the Apps
    section of the MobileFirst Analytics Console
    to see a detailed stacktrace of this crash instance."
}
```

El mensaje POST incluye los siguientes atributos:

* **timestamp** - tiempo en el que se creó la notificación de alerta.
* **condition** - umbral que el usuario estableció (por ejemplo, mayor que o igual a 5).
* **eventType** - eventType que se consultó.
* **property** - propiedad del eventType que se consultó.
* **value** - valor de la propiedad que se consultó.
* **offenders** - lista de aplicaciones o dispositivos que desencadenaron la alerta.
* **title** - título definido por el usuario.
* **message** - mensaje definido por el usuario.

## Visualización de detalles de alerta
{: #viewing-alert-details }

Los detalles de la alerta se pueden visualizar desde el separador **Panel de control→Registro de alertas** en {{ site.data.keys.mf_analytics_console }}.

![Un nuevo registro de alerta](alert-log.png)

Pulse el icono **+** para cualquiera de las alertas entrantes. Esta acción muestra las secciones **Definición de alerta** e **Instancias de alerta**. La imagen siguiente muestra las secciones Definición de alertas e Instancias de alertas:

![Instancias y definiciones de alerta](alert-definitions-and-instances.png)
