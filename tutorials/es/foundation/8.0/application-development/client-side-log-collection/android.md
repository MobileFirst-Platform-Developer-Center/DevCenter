---
layout: tutorial
title: Registro en aplicaciones Android
breadcrumb_title: Registro en Android
relevantTo: [android]
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }

Esta guía de aprendizaje proporciona fragmentos de código con el propósito de añadir funcionalidades de creación de registro en aplicaciones Android.

**Requisito previo:** Asegúrese de leer la [visión general de recopilación de registro del lado del cliente](../).

## Habilitación de la captura de registro
{: #enabling-log-capture }
De forma predeterminada, la captura de registro está habilitada.
La captura de registro, que es posible habilitar e inhabilitar mediante programación, guarda registros en el cliente.
Los registros se envían al servidor con una llamada de envío explícita, o mediante un registro automático.


> **Nota:** La habilitación de la captura del registro en niveles de detalle elevados puede afectar al consumo de la CPU del dispositivo, el espacio del sistema de archivos y el tamaño de la carga útil cuando el cliente envía registros a través de la red.


Para inhabilitar la captura de registro:

```java
Logger.setCapture(false);
```

## Envío de registros capturados
{: #sending-captured-logs }
Envíe los registros a {{ site.data.keys.product_adj }} de acuerdo a la lógica de su aplicación.
También es posible habilitar el registro automático para enviar registros.
Si los registros no se envían antes de que alcancen el tamaño máximo, el archivo de registro se depura en favor de registros más recientes.


> **Nota:** Adopte el siguiente patrón al recopilar datos de registro.
El envío de datos en un intervalo de tiempo garantiza que está viendo sus datos de registro en tiempo casi real en {{ site.data.keys.mf_analytics_console }}.


```java
Timer timer = new Timer();
timer.schedule(new TimerTask() {
  @Override
  public void run() {
    Logger.send();
  }
}, 0, 60000);
```

Para asegurarse de que todos los registros capturados se envían, considere un de las siguientes estrategias:


* Llamar al método `send` en un intervalo de tiempo. 
* Llamar al método `send` desde las llamadas de retorno de suceso del ciclo de vida de la aplicación.

* Incremente el tamaño máximo de archivo del almacenamiento intermedio de registro persistente (en bytes):


```java
Logger.setMaxFileSize(150000);
```

## Envío de registro automático
{: auto-log-sending }
De forma predeterminada, el envío de registro automático está habilitado.
Cada vez que se envía una solicitud de recurso satisfactoria al servidor, también se envían los registros capturados, con un intervalo mínimo de 60 segundos entre envíos.
El envío de registro automático se puede habilitar o inhabilitar desde el cliente.

Para habilitar:

```java
Logger.setAutoSendLogs(true);
```

Para inhabilitar:

```java
Logger.setAutoSendLogs(false);
```

## Ajuste fino con la API Logger
{: #fine-tuning-with-the-logger-api }
El SDK de cliente de {{ site.data.keys.product_adj }} utiliza internamente la API Logger.
De forma predeterminada, se capturan las entradas de registro que el SDK realiza.
Para un ajuste fino en la recopilación del registro, utilice instancias de Logger con nombres de paquete.
También puede controlar qué nivel de registro se captura mediante las analíticas utilizando filtros desde el lado del servidor.


A modo de ejemplo para capturar solo registros cuando el nivel sea ERROR para el nombre de paquete `myApp`, siga estos pasos.


1. Utilice una instancia de `Logger` con el nombre de paquete `myApp`.


   ```java
   Logger logger = Logger.getInstance("MyApp");
   ```

2. **Opcional:** Especifique un filtro para restringir la captura de registro y la salida de registro a únicamente el nivel y paquete especificados mediante programación.


   ```java
   HashMap<String, LEVEL> filters = new HashMap<>();
   filters.put("MyApp", LEVEL.ERROR);
   Logger.setFilters(filters);
   ```

3. **Opcional:** Controle los filtros de manera remota recuperando un perfil de configuración de servidor.

## Recuperación de perfiles de configuración del servidor
{: #fetching-server-configuration-profiles }
Los niveles de registro se pueden establecer por el cliente o recuperando perfiles de configuración del servidor.
Desde {{ site.data.keys.mf_analytics_console }}, se puede establecer de forma global un nivel de registro (todas las instancias de Logger) o para un paquete o paquetes específicos.


> Para obtener información sobre cómo configurar el filtro desde {{ site.data.keys.mf_analytics_console }}, consulte [Configuración de filtros de registro](../../../analytics/console/log-filters/).


Para que el cliente recupere las modificaciones de configuración establecidas en el servidor, se debe llamar al método `updateConfigFromServer` desde un lugar en el código que se ejecute de forma regular como, por ejemplo en las llamadas de retorno del ciclo de vida de la aplicación.


```java
Logger.updateConfigFromServer();
```

## Ejemplo de creación de registro
{: #logging-example }
La salida se dirige a la consola JavaScript del navegador, LogCat o la consola Xcode.


```java
import com.worklight.common.Logger;

public class MathUtils{
  private static final Logger logger = Logger.getInstance(MathUtils.class.getName());
  public int sum(final int a, final int b){
    logger.setLevel(LEVEL.DEBUG);
    int sum = a + b;
    logger.debug("sum called with args " + a + " and " + b + ". Returning " + sum);
    return sum;
  }
}
```
