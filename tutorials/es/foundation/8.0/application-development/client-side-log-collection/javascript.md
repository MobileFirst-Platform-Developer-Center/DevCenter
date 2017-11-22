---
layout: tutorial
title: Registro en aplicaciones JavaScript (Cordova, Web)
breadcrumb_title: Registro en JavaScript
relevantTo: [javascript]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
Esta guía de aprendizaje proporciona fragmentos de código con el propósito de añadir funcionalidades de creación de registro en aplicaciones JavaScript.


**Requisito previo:** Asegúrese de leer la [visión general de recopilación de registro del lado del cliente](../).

## Habilitación de la captura de registro
{: #enabling-log-capture }
De forma predeterminada, la captura de registro está habilitada.
La captura de registro, que es posible habilitar e inhabilitar mediante programación, guarda registros en el cliente.
Los registros se envían al servidor con una llamada de envío explícita, o mediante un registro automático.


> **Nota:** La habilitación de la captura del registro en niveles de detalle elevados puede afectar al consumo de la CPU del dispositivo, el espacio del sistema de archivos y el tamaño de la carga útil cuando el cliente envía registros a través de la red.


Para inhabilitar la captura de registro:

### Cordova
{: #cordova }
```javascript
WL.Logger.config({capture: false});
```

### Web
{: #web }
```javascript
ibmmfpfanalytics.logger.enable(false);
```

## Envío de registros capturados
{: #sending-captured-logs }
Envíe los registros a {{ site.data.keys.product_adj }} de acuerdo a la lógica de su aplicación.
También es posible habilitar el registro automático para enviar registros.
Si los registros no se envían antes de que alcancen el tamaño máximo, el archivo de registro se depura en favor de registros más recientes.


> **Nota:** Adopte el siguiente patrón al recopilar datos de registro.
El envío de datos en un intervalo de tiempo garantiza que está viendo sus datos de registro en tiempo casi real en {{ site.data.keys.mf_analytics_console }}.


#### Aplicaciones Cordova
{: #cordova-apps }

Para asegurarse de que todos los registros capturados se envían, considere un de las siguientes estrategias:


* Llamar al método `send` en un intervalo de tiempo. 
* Llamar al método `send` desde las llamadas de retorno de suceso del ciclo de vida de la aplicación.

* Incremente el tamaño máximo de archivo del almacenamiento intermedio de registro persistente (en bytes):

```javascript
setInterval(function() {
    WL.Logger.send();
}, 60000);
```

```javascript
WL.Logger.config({ maxFileSize: 150000 });
```

#### Aplicaciones web
{: #web-apps }

```javascript
setInterval(function() {
   ibmmfpfanalytics.logger.send();
}, 60000);
```

El tamaño de archivo máximo para la API web es de 5 mb y no es posible cambiarlo.


## Envío de registro automático
{: auto-log-sending }
De forma predeterminada, el envío de registro automático está habilitado.
Cada vez que se envía una solicitud de recurso satisfactoria al servidor, también se envían los registros capturados, con un intervalo mínimo de 60 segundos entre envíos.
El envío de registro automático se puede habilitar o inhabilitar desde el cliente.
De forma predeterminada, el envío de registro automático está habilitado.


#### Para aplicaciones Cordova
{: #for-cordova-apps }
Para habilitar:

```javascript
WL.Logger.config({autoSendLogs: true});
```

Para inhabilitar:

```javascript
WL.Logger.config({autoSendLogs: false});
```

#### Para aplicaciones web
{: #for-web-apps }
Para habilitar:

```javascript
ibmmfpfanalytics.autoSendLogs(true);
```

Para inhabilitar:

```javascript
ibmmfpfanalytics.autoSendLogs(false);
```

## Ajuste fino con la API Logger
{: #fine-tuning-with-the-logger-api }
El SDK de cliente de {{ site.data.keys.product_adj }} utiliza internamente la API Logger.
De forma predeterminada, se capturan las entradas de registro que el SDK realiza.
Para un ajuste fino en la recopilación del registro, utilice instancias de Logger con nombres de paquete.
También puede controlar qué nivel de registro se captura mediante las analíticas utilizando filtros desde el lado del servidor.


A modo de ejemplo para capturar solo registros cuando el nivel sea ERROR para el nombre de paquete `myApp`, siga estos pasos.


#### Ajuste fino para aplicaciones Cordova
{: #fine-tuning-cordova-apps }
1. Utilice una instancia de `WL.Logger` con el nombre de paquete `myApp`.


   ```javascript
   var logger = WL.Logger.create({ pkg: 'MyApp' });
   ```

2. **Opcional:** Especifique un filtro para restringir la captura de registro y la salida de registro a únicamente el nivel y paquete especificados mediante programación.


   ```javascript
   WL.Logger.config({
        filters: {
            'MyApp': 'ERROR'
        }
   });
   ```

3. **Opcional:** Controle los filtros de manera remota recuperando un perfil de configuración de servidor.

#### Aplicaciones web
{: #fine-tuning-web-apps }
Con el SDK de web, el cliente no puede establecer el nivel.
Se envían todos los registros al servidor hasta que se cambia la configuración al recuperar el perfil de configuración del servidor.


## Recuperación de perfiles de configuración del servidor
{: #fetching-server-configuration-profiles }
Los niveles de registro se pueden establecer por el cliente o recuperando perfiles de configuración del servidor.
Desde {{ site.data.keys.mf_analytics_console }}, se puede establecer de forma global un nivel de registro (todas las instancias de Logger) o para un paquete o paquetes específicos.
Para obtener información sobre cómo configurar el filtro desde {{ site.data.keys.mf_analytics_console }}, consulte [Configuración de filtros de registro](../../../analytics/console/log-filters/).
Para que el cliente recupere las modificaciones de configuración establecidas en el servidor, se debe llamar al método `updateConfigFromServer` desde un lugar en el código que se ejecute de forma regular como, por ejemplo en las llamadas de retorno del ciclo de vida de la aplicación.


#### Recuperación de perfiles de configuración del servidor para aplicaciones Cordova
{: #fetching-server-configuration-profiles-cordova-apps }

```javascript
WL.Logger.updateConfigFromServer();
```

#### Recuperación de perfiles de configuración del servidor para aplicaciones Web
{: #fetching-server-configuration-profiles-web-apps }

```javascript
ibmmfpfanalytics.logger.updateConfigFromServer();
```

## Ejemplo de creación de registro
{: #logging-example }
La salida se dirige a la consola JavaScript del navegador, LogCat o la consola Xcode.


### Ejemplo de registro de Cordova
{: #logging-example-cordova }

```javascript
var MathUtils = function(){
   var logger = WL.Logger.create({pkg: 'MathUtils'});
   var sum = function(a, b){
      var sum = a + b;
      logger.debug('sum called with args ' + a + ' and ' + b + '. Returning ' + sum);
      return sum;
   };
}();
```

### Ejemplo de registro web
{: #logging-example-web }
Para el registro con aplicaciones web, utilice el ejemplo anterior y sustituya 

```javascript
var logger = WL.Logger.create({pkg: 'MathUtils'});
```

por 

```javascript
var logger = ibmmfpfanalytics.logger.create({pkg: 'MathUtils'});
```
