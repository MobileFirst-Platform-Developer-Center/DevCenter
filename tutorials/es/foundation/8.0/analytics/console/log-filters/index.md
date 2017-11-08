---
layout: tutorial
title: Configuración de filtros de registro
breadcrumb_title: Filtros de registro
relevantTo: [ios,android,javascript]
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }

Los administradores pueden controlar los niveles y la captura del registro del SDK de cliente de {{ site.data.keys.product_adj }} desde **{{ site.data.keys.mf_console }} → [su aplicación] → [versión] → Filtros de registro**.
  
Desde `Filtros de registro` puede crear un nivel de filtro para el registro.
El nivel de registro se establece globalmente (todas las instancias del registrador) o para un paquete o paquetes específicos.


<img class="gifplayer"  alt="Creación de un filtro de registro" src="add-log-filter.png"/>

Para que la aplicación obtenga las modificaciones en la configuración que se definen en el servidor, se debe llamar al método `updateConfigFromServer` desde un lugar en el código que se ejecute de forma periódica como, por ejemplo, en las llamadas de retorno del ciclo de vida de la aplicación.



#### Android
{: #android }

```java
Logger.updateConfigFromServer();
```

#### iOS
{: #ios }

```objective-c
[OCLogger updateConfigFromServer];
```

#### Cordova
{: #cordova }

```javascript
WL.Logger.updateConfigFromServer();
```

#### Web
{: #web }

```javascript
ibmmfpfanalytics.logger.updateConfigFromServer();
```

Los valores de configuración del `Registrador` que el servidor devuelve prevalecen sobre los valores establecidos en el lado del cliente.
Cuando se elimina el perfil de registro del cliente y el cliente intenta recuperar el perfil de registro del cliente, el cliente recibe una carga útil vacía.
En este caso, los valores son los predeterminados del `Registrador` originalmente configurados en el cliente.


## Reenvío de registros de servidor
{: #forwarding-server-logs }

{{ site.data.keys.mf_console }} también proporciona al administrador del sistema la posibilidad de conservar registros y de enviarlos a {{ site.data.keys.mf_analytics_console }}.


Si desea reenviar registros de servidor, vaya a la pantalla de **Valores de tiempo de ejecución** y especifique el paquete registrador bajo **Paquetes adicionales**.  
Los registros recopilados se visualizarán en {{ site.data.keys.mf_analytics_console_short }}. Esto es útil para que un usuario se aproveche de la separación de registros de adaptador en {{ site.data.keys.mf_analytics_console_short }} sin tener que recopilar todos los registros del servidor.

