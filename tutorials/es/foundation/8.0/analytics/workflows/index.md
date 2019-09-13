---
layout: tutorial
title: Flujos de trabajo de analíticas
breadcrumb_title: Workflows
relevantTo: [ios,android,javascript]
weight: 5
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }

Utilice {{ site.data.keys.mf_analytics_full }} para satisfacer lo mejor posible sus necesidades empresariales. Una vez se hayan identificado sus objetivos, recopile los datos apropiados mediante el SDK de cliente de {{ site.data.keys.mf_analytics_short }} y cree informes con {{ site.data.keys.mf_analytics_console }}. Los siguientes escenarios demuestran métodos de recopilación y creación de informes de datos de analíticas.

#### Ir a
{: #jump-to }

* [Analíticas de utilización de aplicaciones](#app-usage-analytics)
* [Captura de bloqueos](#crash-capture)

## Analíticas de utilización de aplicaciones
{: #app-usage-analytics }

### Inicialización de la aplicación de cliente para capturar el uso de la aplicación
{: #initializing-your-client-app-to-capture-app-usage }

El uso de la aplicación mide el número de veces que una aplicación específica pasa al primer plano y, a continuación pasa a un segundo plano. Para capturar el uso de las aplicaciones móviles, el SDK del cliente de {{ site.data.keys.mf_analytics }} debe estar configurado para escuchar los sucesos de ciclo de vida de las aplicaciones.

Es posible utilizar una API de {{ site.data.keys.mf_analytics }} para capturar el uso de las aplicaciones. Asegúrese de haber creado el pertinente escucha de dispositivo. A continuación, envíe los datos al servidor.

#### iOS
{: #ios }

Añada el siguiente código en su método `application:didFinishLaunchingWithOptions` de delegado de aplicación en el archivo **AppDelegate.m/AppDeligate.swift**.

**Objective-C**

```objc
WLAnalytics *analytics = [WLAnalytics sharedInstance];
[analytics addDeviceEventListener:LIFECYCLE];
```

 Para enviar datos de analíticas:

```objc
[[WLAnalytics sharedInstance] send];
```

**Swift**

```Swift
WLAnalytics.sharedInstance().addDeviceEventListener(LIFECYCLE);
```

Para enviar datos de analíticas:

```Swift
WLAnalytics.sharedInstance().send;
```

#### Android
{: #android }

Añada el siguiente código en su método `onCreate` de subclase de aplicación.

```Java
WLAnalytics.init(this);
WLAnalytics.addDeviceEventListener(DeviceEvent.LIFECYCLE);
```

Para enviar datos de analíticas:

```Java
WLAnalytics.send();
```

#### Cordova
{: #cordova }

En el caso de aplicaciones Cordova, el escucha se debe crear en el código de la plataforma nativa, de forma parecida a las aplicaciones iOS y Android. Envié los datos al servidor:

```javascript
WL.Analytics.send();
```

#### Aplicaciones web
{: #web-apps }

En el caso de aplicaciones web, los escuchas no son necesarios. Las analíticas se pueden habilitar e inhabilitar a través de la clase `WLlogger`.

```javascript                                    
ibmmfpfanalytics.logger.config({analyticsCapture: true});                
ibmmfpfanalytics.send();
```

### Gráfico de dispositivos y uso predeterminado
{: #default-usage-and-devices-charts }

En la página **Uso y dispositivos** de la sección de Aplicaciones en {{ site.data.keys.mf_analytics_console }},
se proporcionan varios gráficos predeterminados para ayudar a gestionar el uso de la aplicación.

#### Número total de dispositivos
{: #total-devices }

El gráfico **Número total de dispositivos** muestra el número total de dispositivos.

#### Número total de sesiones de app
{: #total-app-sessions }

El gráfico **Número total de sesiones de app** muestra el número total sesiones de aplicación. Una sesión de aplicación se graba cuando pasa a un segundo plano de un dispositivo.

#### Usuarios activos
{: #active-users }

El gráfico de **Usuarios activos** muestra un gráfico de varias líneas con los siguientes datos:

* Usuarios activos - usuarios únicos durante el intervalo de tiempo visualizado.
* Usuarios nuevos - usuarios nuevos durante el intervalo de tiempo visualizado.

El marco temporal visualizado predeterminado es de un día con un punto de datos para cada hora. Si cambia el marco temporal a más de un día, los puntos de los datos reflejarán el valor de cada día. Puede pulsar en la correspondiente en la leyenda para conmutar la visualización de la línea. De forma predeterminada, se muestran todas las claves. Tampoco es posible conmutar todas las claves al mismo tiempo para no visualizar ninguna línea.

Para ver los datos lo más precisos posibles en el gráfico de líneas, debe instrumentar el código de sus aplicaciones para proporcionar el `userID` llamando a la API `setUserContext`. Si desea proporcionar no mostrar los valores de `userID`, debe hacer primero un hash del valor. Si el `ID de usuario` no se proporciona, el ID del dispositivo se utiliza de forma predeterminada. Si un dispositivo es utilizado por varios usuarios y no se proporciona el `ID de usuario`, el gráfico de líneas no muestra información precisa porque el ID del dispositivo se cuenta como un usuario.

#### Sesiones de aplicaciones
{: #app-sessions }
El gráfico **Sesiones de app** muestra un gráfico de barras de las sesiones de la aplicación a lo largo del tiempo.

#### Uso de la aplicación
{: #app-usage }

El gráfico **Uso de la app** muestra un gráfico circular del porcentaje de las sesiones de aplicación de cada aplicación.

#### Dispositivos nuevos
{: #new-devices }

El gráfico **Dispositivos nuevos** muestra un gráfico de barras de los nuevos dispositivos a lo largo del tiempo.

#### Uso del modelo
{: #model-usage }

El gráfico **Uso del modelo** muestra un gráfico circular del porcentaje de las sesiones de aplicación de cada modelo de dispositivo.

#### Uso del sistema operativo
{: #operating-system-usage }
El gráfico **Uso del sistema operativo** muestra un gráfico circular del porcentaje de las sesiones de aplicación de cada sistema operativo de dispositivo.

### Creación de un gráfico personalizado de la duración de sesión promedio
{: #creating-acustom-chart-for-average-session-duration }

La duración de una sesión de aplicación es una métrica que es interesante visualizar. En una aplicación, se desea saber la cantidad de tiempo que los usuarios han estado trabajando en una sesión concreta.

1. En {{ site.data.keys.mf_analytics_console }}, pulse **Crear gráfico** en la página **Gráficos personalizados** de la sección del Panel de control.
2. Proporcione un título al gráfico.
3. Seleccione **Sesiones de app** como **Tipo de suceso**.
4. Seleccione **Gráfico de barras** como **Tipo de gráfico**.
5. Pulse **Siguiente**.
6. Seleccione **Línea temporal** como **Eje X**.
7. Seleccione **Media** como **Eje Y**.
8. Seleccione **Duración** como **Propiedad**.
9. Pulse **Guardar**.

## Captura de bloqueos
{: #crash-capture }

{{ site.data.keys.mf_analytics }} incluye datos e informes acerca de los bloqueos de las aplicaciones. Estos datos se recopilan automáticamente junto con otros datos de sucesos del ciclo de vida. Los datos de los bloqueos los recopilan los clientes y se envían al servidor una vez que la aplicación está de nuevo en marcha y ejecutándose.

Un bloqueo de aplicación se graba cuando se produce una excepción no manejada y hace que el programa pase a estar en un estado no recuperable. Antes de que se cierre la aplicación, el SDK de {{ site.data.keys.mf_analytics }} registra un suceso de bloqueo. Estos datos se envían al servidor en la siguiente llamada de envío de registrador.

### Inicialización de la aplicación para capturar datos de bloqueos
{: #initializing-your-app-to-capture-crash-data }

Para asegurarse de que los datos de los bloqueos se recopilen e incluyan en los informes de {{ site.data.keys.mf_analytics_console }}, asegúrese de que son enviados al servidor.

Asegúrese de que se están recopilando los sucesos del ciclo de vida de aplicación tal como se describe en [Inicialización de la aplicación de cliente para capturar el uso de la aplicación](#initializing-your-client-app-to-capture-app-usage).

Los registros de cliente se deben enviar una vez que la aplicación esté de nuevo en ejecución, para poder obtener el rastreo de la pila que se asocia al bloqueo. La utilización de un temporizador garantiza que los registros se envían periódicamente.

#### iOS
{: #ios-crash-data }

**Objective-C**

```objc
- (void)sendMFPAnalyticData {
  [OCLogger send];
  [[WLAnalytics sharedInstance] send];
}

// then elsewhere in the same implementation file:

[NSTimer scheduledTimerWithTimeInterval:60
  target:self
  selector:@selector(sendMFPAnalyticData)
  userInfo:nil
  repeats:YES]
```

**Swift**

```swift
overridefuncviewDidLoad() {
       super.viewDidLoad()
       WLAnalytics.sharedInstance();
       lettimer = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: #selector(sendMFPAnalyticData), userInfo: nil, repeats: true);
       timer.fire();
       // Do any additional setup after loading the view, typically from a nib.
   }

   funcsendMFPAnalyticData() {
       OCLogger.send()
       WLAnalytics.sharedInstance().send()
   }
```

#### Android
{: #android-crash-data }

```Java
Timer timer = new Timer();
timer.schedule(new TimerTask() {
  @Override
  public void run() {
    Logger.send();
    WLAnalytics.send();
  }
}, 0, 60000);
```

#### Cordova
{: #cordova-crash-data }

```Java
setInterval(function() {
  WL.Logger.send();
  WL.Analytics.send();
}, 60000)
```

#### Web
{: #web-crash-data }

```Java
setInterval(function() {
  ibmmfpfanalytics.logger.send();
}, 60000);
```

### Supervisión de bloqueos de aplicación
{: #app-crash-monitoring }

Después de un bloqueo, cuando se reinicia una aplicación, los registros del bloqueo se envían a {{ site.data.keys.mf_analytics_server }}. Esta información sobre el bloqueo de la aplicación se puede visualizar con rapidez en la sección del **Panel de control** de {{ site.data.keys.mf_analytics_console }}.  
En la página **Visión general** de la sección **Panel de control**, el gráfico de barras **Bloqueos** muestra un histograma de los bloqueos a lo largo del tiempo.

Los datos se pueden mostrar de dos maneras:

* **Mostrar frecuencia de bloqueos**: frecuencia de bloqueos a lo largo del tiempo
* **Mostrar total de bloqueos**: total de bloqueos a lo largo del tiempo

> **Nota:** El gráfico de bloqueos realiza consultas con relación a documentos `MfpAppSession`. Debe instrumentar sus aplicaciones para recopilar bloqueos y usos de la aplicación para que los datos aparezcan en los gráficos. Si no se recopilan los datos de `MfpAppSession`, se consultan los documentos de `MfpAppLog`. En este caso, el gráfico puede indicar el número de bloqueos, pero no puede calcular la frecuencia de bloqueos porque se desconoce el número de usos de aplicación, lo que resulta en la limitación siguiente:
>
> * El gráfico **Bloqueos** no visualiza datos cuando se selecciona **Mostrar frecuencia de bloqueos**.

### Gráficos predeterminados para bloqueos
{: #default-charts-for-crashes }

En la página **Bloqueos** de la sección **Aplicaciones** en {{ site.data.keys.mf_analytics_console }}, se proporcionan varios gráficos predeterminados que ayudan a gestionar los bloqueos de las aplicaciones.

El gráfico **Visión general de bloqueo** muestra una tabla que proporciona una visión general de los bloqueos.  
El gráfico de barras **Bloqueos** muestra un histograma de los bloqueos a lo largo del tiempo. Los datos se pueden visualizar por frecuencia de bloqueos o total de bloqueos. El gráfico de barras de Bloqueos también se muestra en la página Bloqueos de la sección de Aplicaciones.

El gráfico **Resumen de bloqueo** muestra una tabla que es posible ordenar con un resumen de los bloqueos. Amplíe los bloqueos individuales pulsando el icono + para ver la tabla de **Detalles del bloqueo** que incluye más detalles sobre los mismos. En la tabla de Detalles de bloqueos, pulse el icono **>** para ver más detalles sobre una instancia de bloqueo específica.

### Resolución de problemas de bloqueos de aplicación
{: #app-crash-troubleshooting }

Visualice la página **Bloqueos** en la sección **Aplicaciones** de {{ site.data.keys.mf_analytics_console }} para una mejor administración de sus aplicaciones.

La tabla **Visión general del bloqueo** muestra las siguientes columnas:

* **Aplicación:** nombre de la aplicación
* **Bloqueos:** número total de bloqueos para dicha aplicación
* **Usos totales:** número total de veces que un usuario abre y cierra la aplicación
* **Frecuencia de bloqueos:** porcentaje de bloqueos por uso

El gráfico de barras de **Bloqueos** es el mismo gráfico que el que se visualiza en la página **Visión general** de la sección **Panel de control**.

> **Nota:** Ambos gráficos realizan consultas con relación a los documentos `MfpAppSession`. Debe instrumentar sus aplicaciones para recopilar bloqueos y usos de la aplicación para que los datos aparezcan en los gráficos. Si no se recopilan los datos de `MfpAppSession`, se consultan los documentos de `MfpAppLog`. En este caso, los gráficos pueden indicar el número de bloqueos, pero no puede calcular la frecuencia de bloqueos porque se desconoce el número de usos de aplicación, lo que resulta en las limitaciones siguientes:
>
> * La tabla Visión general de bloqueo tiene columnas vacías para Usos totales y Frecuencia de bloqueos.
> * El gráfico de barras de Bloqueos no muestra datos cuando se selecciona Mostrar frecuencia de bloqueos.

La tabla **Resumen de bloqueos** se puede ordenar e incluye las siguientes columnas de datos:

* Bloqueos
* Dispositivos
* Último bloqueo
* Apl
* SO
* Mensaje

Pulse el icono **+** junto a una entrada para visualizar la tabla **Detalles de bloqueo**, que incluye las siguientes columnas:

* Hora del bloqueo
* Versión de aplicación
* Versión de SO
* Modelo de dispositivo
* ID de dispositivo
* Descarga: enlace para descargar los registros que han dado lugar al bloqueo

Amplíe las entradas en la tabla **Detalles de bloqueo** para obtener más información como, por ejemplo, el rastreo de la pila.

> **Nota:** Los datos en la tabla **Resumen de bloqueos** se cumplimentan consultado los registros de cliente con un nivel de fatal. Si su aplicación no recopila registro de cliente con un nivel fatal, no habrá datos disponibles.
