---
layout: tutorial
title: Recopilación de registro del lado del cliente
breadcrumb_title: Recopilación de registro del lado del cliente
relevantTo: [ios,android,javascript]
weight: 7
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
La creación de registros es la instrumentación del código fuente que utiliza llamadas de API para grabar mensajes con el propósito de facilitar la depuración y los diagnósticos.
{{ site.data.keys.product_full }} proporciona un conjunto de métodos de API de registro para este propósito.


La API {{ site.data.keys.product_adj }} `Logger` es parecida a otras API de registro utilizadas habitualmente como, por ejemplo, `console.log` (JavaScript), `java.util.logging` (Java) y `NSLog` (Objective-C),
y proporciona la funcionalidad adicional de capturar de forma persistente los datos registrados para enviarlos a {{ site.data.keys.mf_server }} para ser utilizados en la inspección por parte de los desarrolladores y para la recopilación de analíticas.
Utilice las API de `Logger` obtener datos de registro en los niveles apropiados, de forma que los desarrolladores que inspeccionen registros puedan determinar y corregir problemas sin tener que reproducir los problemas en sus centros de desarrollo. 

#### Disponibilidad
{: #availability }
Los métodos de API de `Logger` que {{ site.data.keys.product_adj }} proporciona se pueden utilizar con aplicaciones iOS, Android, Web y Cordova. 

## Niveles de registro
{: #logging-levels }
Las bibliotecas de creación de registros habitualmente tienen controles de nivel de detalle frecuentemente denominados **niveles**.  
Los niveles de creación de registro, de más detallado o menos detallado, son lo siguientes:


* TRACE - utilizado para puntos de entrada y salida de método
* DEBUG - utilizado para salidas de resultado de método
* LOG - utilizado para la creación de instancias de clase
* INFO - utilizado para la inicialización de creación de informes
* WARN - utilizado para registrar avisos de utilización en desuso
* ERROR - utilizado para las excepciones no esperadas
* FATAL - utilizado para cuelgues o bloqueos no recuperables

> **Nota:** La utilización de FATAL dará lugar a la recopilación de un bloqueo de aplicación.
Para evitar la distorsión con sus datos de bloqueo de aplicación, se recomienda no utilizar esta palabra clave.


Los SDK de cliente están configurados de forma predeterminada con el nivel de detalle FATAL, lo que se significa que la captura o la salida es escasa o sin registros de depuración detallados.
El nivel de detalle se puede ajustar mediante programación o mediante un perfil de configuración en {{ site.data.keys.mf_analytics_console }}, que su aplicación debe recuperar de forma explícita.


### Registros de aplicaciones de cliente: 
{: #logging-from-client-applications }
* [Registro en aplicaciones JavaScript (Cordova, Web) ](javascript/)
* [Registro en aplicaciones iOS](ios/)
* [Registro en aplicaciones Android](android/)

### Ajuste del nivel de detalle del registro
{: #adjusting-log-verbosity }
Una vez establecido el nivel de registros, ya sea en el cliente o recuperando el perfil del servidor, el cliente filtra los mensajes de registro que recibe.
Si se envía de forma explícita un mensaje por debajo del umbral, el cliente lo ignora.


Por ejemplo, para establecer el nivel de detalle en DEBUG:

#### iOS
{: #ios}
**Objective-C**

```objc
[OCLogger setLevel:OCLogger_DEBUG];
```

**Swift**

```swift
 OCLogger.setLevel(OCLogger_DEBUG);
 ```

#### Android
{: #android }
```java
Logger.setLevel(Logger.LEVEL.DEBUG);
```

#### JavaScript (Cordova)
{: #javascript-cordova }
```javascript
WL.Logger.config({ level: 'DEBUG' });
```

#### JavaScript (Web)
{: #javascript-web }
El nivel de rastreo predeterminado para el SDK web no se puede cambiar desde el cliente.


## Captura de bloqueos
{: #crash-capture }
El SDK de cliente de {{ site.data.keys.product_adj }}, en aplicaciones Android e iOS, captura un rastreo de pila cuando una aplicación se bloquea y lo registra en un nivel FATAL.
Este tipo de bloqueo es un bloqueo verdadero donde la interfaz de usuario desaparece de la vista del usuario.
En aplicaciones Cordova, captura errores globales de JavaScript y, si es posible, una pila de llamadas de JavaScript, y lo registra en el nivel FATAL.
Este tipo de bloqueo no es un suceso de bloqueo, y podría tener o no tener consecuencias adversas en la experiencia del usuario en el tiempo de ejecución.


Los bloqueos, excepciones no capturadas y errores globales se capturan y registran de forma automática una vez la aplicación se ejecuta de nuevo.


## Visualización de registros
{: #viewing-the-logs }
Después de que se recopilen los registros y se envíen al servidor, los podrá visualizar en {{ site.data.keys.mf_analytics_console }}.
Elija el panel **Aplicaciones** en la barra de navegación y pulse el separador **Buscar en registro de clientes**.


![Visualizar y buscar en los registros](consoleViewClientLogs.png)
