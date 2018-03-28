---
layout: tutorial
title: Registro en aplicaciones iOS
breadcrumb_title: Logging in iOS
relevantTo: [ios]
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
Esta guía de aprendizaje proporciona fragmentos de código con el propósito de añadir funcionalidades de creación de registro en aplicaciones iOS.

**Requisito previo:** Asegúrese de leer la [visión general de recopilación de registro del lado del cliente](../).

> **Nota:** La utilización de `OCLogger` en Swift precisa la creación de una clase de extensión `OCLogger` (esta clase puede ser un archivo Swift distinto, o una extensión de su archivo Swift actual):


```swift
extension OCLogger {
    //Log methods with no metadata

    func logTraceWithMessages(message:String, _ args: CVarArgType...) {
        logWithLevel(OCLogger_TRACE, message: message, args:getVaList(args), userInfo:Dictionary<String, String>())
    }

    func logDebugWithMessages(message:String, _ args: CVarArgType...) {
        logWithLevel(OCLogger_DEBUG, message: message, args:getVaList(args), userInfo:Dictionary<String, String>())
    }

    func logInfoWithMessages(message:String, _ args: CVarArgType...) {
        logWithLevel(OCLogger_INFO, message: message, args:getVaList(args), userInfo:Dictionary<String, String>())
    }

    func logWarnWithMessages(message:String, _ args: CVarArgType...) {
        logWithLevel(OCLogger_WARN, message: message, args:getVaList(args), userInfo:Dictionary<String, String>())
    }

    func logErrorWithMessages(message:String, _ args: CVarArgType...) {
        logWithLevel(OCLogger_ERROR, message: message, args:getVaList(args), userInfo:Dictionary<String, String>())
    }

    func logFatalWithMessages(message:String, _ args: CVarArgType...) {
        logWithLevel(OCLogger_FATAL, message: message, args:getVaList(args), userInfo:Dictionary<String, String>())
    }

    func logAnalyticsWithMessages(message:String, _ args: CVarArgType...) {
        logWithLevel(OCLogger_ANALYTICS, message: message, args:getVaList(args), userInfo:Dictionary<String, String>())
    }

    //Log methods with metadata

    func logTraceWithUserInfo(userInfo:Dictionary<String, String>, message:String, _ args: CVarArgType...) {
        logWithLevel(OCLogger_TRACE, message: message, args:getVaList(args), userInfo:userInfo)
    }

    func logDebugWithUserInfo(userInfo:Dictionary<String, String>, message:String, _ args: CVarArgType...) {
        logWithLevel(OCLogger_DEBUG, message: message, args:getVaList(args), userInfo:userInfo)
    }

    func logInfoWithUserInfo(userInfo:Dictionary<String, String>, message:String, _ args: CVarArgType...) {
        logWithLevel(OCLogger_INFO, message: message, args:getVaList(args), userInfo:userInfo)
    }

    func logWarnWithUserInfo(userInfo:Dictionary<String, String>, message:String, _ args: CVarArgType...) {
        logWithLevel(OCLogger_WARN, message: message, args:getVaList(args), userInfo:userInfo)
    }

    func logErrorWithUserInfo(userInfo:Dictionary<String, String>, message:String, _ args: CVarArgType...) {
        logWithLevel(OCLogger_ERROR, message: message, args:getVaList(args), userInfo:userInfo)
    }

    func logFatalWithUserInfo(userInfo:Dictionary<String, String>, message:String, _ args: CVarArgType...) {
        logWithLevel(OCLogger_FATAL, message: message, args:getVaList(args), userInfo:userInfo)
    }

    func logAnalyticsWithUserInfo(userInfo:Dictionary<String, String>, message:String, _ args: CVarArgType...) {
        logWithLevel(OCLogger_ANALYTICS, message: message, args:getVaList(args), userInfo:userInfo)
    }
}
```

Después de incluir la clase de extensión podrá entonces utilizar `OCLogger` en Swift.


## Habilitación de la captura de registro
{: #enabling-log-capture }
De forma predeterminada, la captura de registro está habilitada.
La captura de registro, que es posible habilitar e inhabilitar mediante programación, guarda registros en el cliente.
Los registros se envían al servidor con una llamada de envío explícita, o mediante un registro automático.


> **Nota:** La habilitación de la captura del registro en niveles de detalle elevados puede afectar al consumo de la CPU del dispositivo, el espacio del sistema de archivos y el tamaño de la carga útil cuando el cliente envía registros a través de la red.


Para inhabilitar la captura de registro:

**Objective-C**

```objc
[OCLogger setCapture:NO];
```

**Swift**

```swift
OCLogger.setCapture(false);
```

## Envío de registros capturados
{: #sending-captured-logs }
Envíe los registros a {{ site.data.keys.product_adj }} de acuerdo a la lógica de su aplicación.
También es posible habilitar el registro automático para enviar registros.
Si los registros no se envían antes de que alcancen el tamaño máximo, el archivo de registro se depura en favor de registros más recientes.


> **Nota:** Adopte el siguiente patrón al recopilar datos de registro.
El envío de datos de forma periódica garantiza que está viendo sus datos de registro en tiempo casi real en {{ site.data.keys.mf_analytics_console }}.


**Objective-C**

```objc
[NSTimer scheduledTimerWithTimeInterval:60
  target:[OCLogger class]
  selector:@selector(send)
  userInfo:nil
  repeats:YES];
```

**Swift**

```swift
var timer = NSTimer.scheduledTimerWithTimeInterval(60,
  target:OCLogger.self,
  selector: #selector(OCLogger.send),
  userInfo: nil,
  repeats: true)
```

Para asegurarse de que todos los registros capturados se envían, considere un de las siguientes estrategias:


* Llamar al método `send` en un intervalo de tiempo. 
* Llamar al método `send` desde las llamadas de retorno de suceso del ciclo de vida de la aplicación.

* Incremente el tamaño máximo de archivo del almacenamiento intermedio de registro persistente (en bytes):


**Objective-C**

```objc
[OCLogger setMaxFileSize:150000];

```

**Swift**

```swift
OCLogger.setMaxFileSize(150000);
```

## Envío de registro automático
{: #auto-log-sending }
De forma predeterminada, el envío de registro automático está habilitado.
Cada vez que se envía una solicitud de recurso satisfactoria al servidor, también se envían los registros capturados, con un intervalo mínimo de 60 segundos entre envíos.
El envío de registro automático se puede habilitar o inhabilitar desde el cliente.
De forma predeterminada, el envío de registro automático está habilitado.


**Objective-C**

Para habilitar:

```objc
[OCLogger setAutoSendLogs:YES];
```

Para inhabilitar:

```objc
[OCLogger setAutoSendLogs:NO];
```

**Swift**

Para habilitar:

```swift
OCLogger.setAutoSendLogs(true);
```

Para inhabilitar:

```swift
OCLogger.setAutoSendLogs(false);
```

## Ajuste fino con la API Logger
{: #fine-tuning-with-the-logger-api }
El SDK de cliente de {{ site.data.keys.product_adj }} utiliza internamente la API Logger.
De forma predeterminada, se capturan las entradas de registro que el SDK realiza.
Para un ajuste fino en la recopilación del registro, utilice instancias de Logger con nombres de paquete.
También puede controlar qué nivel de registro se captura mediante las analíticas utilizando filtros desde el lado del servidor.


### Objective-C
{: #objective-c}
A modo de ejemplo de captura de registros únicamente cuando el nivel es `ERROR` para el nombre de paquete `myApp`, siga estos pasos.


1. Utilice una instancia de `Logger` con el nombre de paquete `myApp`.


   ```objc
   OCLogger *logger = [OCLogger getInstanceWithPackage:@"MyApp"];
   ```

2. **Opcional:** Especifique un filtro para restringir la captura de registro y la salida de registro a únicamente el nivel y paquete especificados mediante programación.


   ```objc
   [OCLogger setFilters:@{@"MyApp": @(OCLogger_ERROR)}];
   ```

3. **Opcional:** Controle los filtros de manera remota recuperando un perfil de configuración de servidor.

### Swift
{: #swift }
1. Utilizando la extensión explicada en la Visión general, cree una instancia del registrador para su paquete.


   ```swift
   let logger : OCLogger = OCLogger.getInstanceWithPackage("MyTestLoggerPackage");
   ```

2. **Opcional:** Especifique un nivel de registro.

   ```swift
   OCLogger.setLevel(OCLogger_DEBUG);
   ```

3. **Opcional:** Controle los filtros de manera remota recuperando un perfil de configuración de servidor.

## Recuperación de perfiles de configuración del servidor
{: #fetching-server-configuration-profiles }
Los niveles de registro cronológico se puede establecer por el cliente, o recuperando perfiles de configuración del servidor.
Desde {{ site.data.keys.mf_analytics_console }}, se puede establecer de forma global un nivel de registro (todas las instancias de Logger) o para un paquete o paquetes específicos.
Para obtener información sobre cómo configurar el filtro desde {{ site.data.keys.mf_analytics_console }}, consulte [Configuración de filtros de registro](../../../analytics/console/log-filters/).
Para que el cliente recupere la configuración del servidor, se debe llamar al método `updateConfigFromServer` desde un lugar en el código que se ejecute de forma regular como, por ejemplo en las llamadas de retorno del ciclo de vida de la aplicación.


**Objective-C**

```objc
[OCLogger updateConfigFromServer];
```

**Swift**

```swift
 OCLogger.updateConfigFromServer();
 ```

## Ejemplo de creación de registro
{: #logging-example }
La salida se dirige a la consola JavaScript del navegador, LogCat o la consola Xcode.


#### Objective-C
{: #objective-c-example }

```objc
#import "OCLogger.h"
+ (int) sum:(int) a with:(int) b{
    int sum = a + b;
    [OCLogger setLevel:DEBUG];
    OCLogger* mathLogger = [OCLogger getInstanceWithPackage:@"MathUtils"];
    NSString* logMessage = [NSString stringWithFormat:@"sum called with args %d and %d. Returning %d", a, b, sum];
    [mathLogger debug:logMessage];
    return sum;
}
```

### Swift
{: #swift-logging }

```swift
func sum(a: Int, b: Int) -> Int{
    var sum = a + b;
    let logger = OCLogger.getInstanceWithPackage("MathUtils");

    logger.logInfoWithMessages("sum called with args /(a) and /(b). Returning /(sum)");
    return sum;
}
```
