---
layout: tutorial
title: API y características discontinuadas y en desuso
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
<br/>
Considere con cuidado cómo los elementos de API y las características eliminadas afectan a su entorno de {{ site.data.keys.product_full }}.

#### Ir a
{: #jump-to }
* [Características discontinuadas y características que no se incluyen en la versión 8.0](#dicontinued-features-and-features-that-are-not-included-in-v-80)
* [Cambios de API del lado del servidor](#server-side-api-changes)
* [Cambios de API del lado del cliente](#client-side-api-changes)

## Características discontinuadas y características que no se incluyen en la versión 8.0
{: #dicontinued-features-and-features-that-are-not-included-in-v-80 }
{{ site.data.keys.product }} v8.0 se ha simplificado en gran medida en relación a la versión anterior. Como resultado de esta simplificación, algunas características que estaban disponibles en la v7.1 se han discontinuado en la v8.0. En la mayoría de los casos, se sugiere una forma alternativa de implementar las características. Estas características se marcan como discontinuadas. Algunas otras características que existen en la V7.1. no se encuentran en la v8.0, pero no como consecuencia del nuevo diseño de la v8.0. Para diferencias entre estas características excluidas de las características discontinuadas de la v8.0, se marcan como no presentes en la V8.0.

<table class="table table-striped">
    <tr>
        <td>Característica</td>
        <td>Estado y forma de sustitución</td>
    </tr>
    <tr>
        <td><p>MobileFirst Studio ha sido sustituido por el plugin de {{ site.data.keys.mf_studio }} para Eclipse.</p></td>
        <td><p>Se ha sustituido por el plugin de {{ site.data.keys.mf_studio }} para Eclipse, respaldado por el estándar y la amplia base de plugins de Eclipse. Es posible desarrollar aplicaciones híbridas con Apache Cordova CLI o con un IDE habilitado para Cordova como, por ejemplo, Visual Studio Code, Eclipse o IntelliJ entre otros. Para obtener más información sobre cómo utilizar Eclipse como un IDE habilitado para Cordova, consulte <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/application-development/using-mobilefirst-cli-in-eclipse/">Plugin IBM {{ site.data.keys.mf_studio }} para la gestión de proyectos Cordova en Eclipse</a>.</p>

        <p>Es posible desarrollar adaptadores con Apache Maven o un IDE habilitado para Maven como, por ejemplo, Eclipse, IntelliJ entre otros. Para obtener más información sobre cómo desarrollar adaptadores, consulte <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/adapters">Categoría de adaptadores</a>. Para obtener más información sobre cómo utilizar Eclipse con un ID habilitado para Maven, consulte la <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/adapters/developing-adapters/">Guía de aprendizaje de desarrollo de adaptadores en Eclipse</a>.</p>

        <p>Instale {{ site.data.keys.mf_dev_kit_full }} para probar los adaptadores y las aplicaciones con {{ site.data.keys.mf_server }}. También puede acceder al SDK y a las herramientas de desarrollo de {{ site.data.keys.product_adj }} si no desea descargarlas desde repositorios basados en Internet como, por ejemplo, NPM, Maven, Cocoapod o NuGet. Para obtener más información sobre {{ site.data.keys.mf_dev_kit }}, consulte <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/installation-configuration/development/mobilefirst/">{{ site.data.keys.mf_dev_kit }}</a>.</p>
        </td>
    </tr>
    <tr>
        <td><p>Se han discontinuado skins, shells, la página Valores, la minificación y elementos de la interfaz de usuario JavaScript para aplicaciones híbridas.</p></td>
        <td><p>Discontinuado. Las aplicaciones híbridas se desarrollan directamente con Apache Cordova. Para obtener más información sobre la sustitución de skins, shells, la página Valores y la minificación, consulte Elementos eliminados y Comparación de aplicaciones Cordova desarrolladas con v8.0 en relación con v7.1 y anteriores.</p>
        </td>
    </tr>
    <tr>
        <td><p>Ya no es posible importar Sencah Touch en proyectos de {{ site.data.keys.product_adj }} para aplicaciones híbridas.</p></td>
        <td><p>Discontinuado. Las aplicaciones híbridas de {{ site.data.keys.product_adj }} se desarrollan directamente con Apache Cordova, y las características de {{ site.data.keys.product_adj }} se proporcionan como plugins de Cordova. Consulte la documentación de Sencha Touch para integrar Sencha Touch y Cordova.</p>
        </td>
    </tr>
    <tr>
        <td><p>Se ha discontinuado el caché cifrado.</p></td>
        <td><p>Discontinuado. Para almacenar datos cifrados localmente, se utiliza JSONStore. Para obtener más información sobre JSONStore, consulte la <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/application-development/jsonstore">Guía de aprendizaje de JSONStore</a>.</p>
        </td>
    </tr>
    <tr>        
        <td><p>Bajo la V8.0 no se da soporte al desencadenamiento de Direct Update bajo demanda. La aplicación de cliente comprueba Direct Update cuando obtiene la señal OAuth para una sesión. No puede programar una aplicación cliente para que compruebe la existencia de actualizaciones directas en otro punto en el tiempo en v8.0.</p></td>
        <td><p>No en v8.0.</p></td>
    </tr>
    <tr>
        <td><p>Adaptadores con configuración de dependencia de sesión. En V7.1.0,
era posible configurar a {{ site.data.keys.mf_server }} para que funcionase en una modalidad independiente de la sesión (lo predeterminado) o en una modalidad dependiente de la sesión. A partir de la V8.0, deja de darse soporte a la modalidad dependiente de la sesión. El servidor es intrínsecamente independiente de la sesión HTTP, sin que se necesite ninguna configuración relacionada.</p></td>
        <td><p>Discontinuado.</p></td>
    </tr>
    <tr>
        <td><p>En la versión 8.0 ya no se da soporte al almacenamiento de atributos sobre IBM WebSphere eXtreme Scale.</p></td>
        <td><p>No en v8.0.</p></td>
    </tr>
    <tr>
        <td><p>La generación de adaptadores y el descubrimiento de servicios para aplicaciones de proceso de IBM Business Process Manager (IBM BPM), Microsoft Azure Marketplace DataMarket, API RESTFUL de OData, recursos RESTful, servicios expuestos por una instancia de SAP Netweaver Gateway y servicios web no están en la versión 8.0.</p></td>
        <td><p>No en v8.0.</p></td>
    </tr>
    <tr>
        <td>El adaptador JMS JavaScript ya no está presente en la v8.0.</td>
        <td>No en v8.0.</td>
    </tr>
    <tr>
        <td>El adaptador SAP Gateway JavaScript ya no está presente en la v8.0.	</td>
        <td>No en v8.0.</td>
    </tr>
    <tr>
        <td>El adaptador SAP JCo JavaScript ya no está presente en la v8.0.	</td>
        <td>No en v8.0.</td>
    </tr>
    <tr>
        <td>El adaptador Cast Iron JavaScript ya no está presente en la v8.0.	</td>
        <td>No en v8.0.</td>
    </tr>
    <tr>
        <td>Los adaptadores OData y Microsoft Azure OData JavaScript ya no están presentes en la v8.0.	</td>
        <td>No en v8.0.</td>
    </tr>
    <tr>
        <td>No se da soporte a las notificaciones push para USSD en la v8.0.	</td>
        <td>Discontinuado.</td>
    </tr>
    <tr>
        <td>No se da soporte a las notificaciones push basadas en sucesos en la v8.0.	</td>
        <td>Discontinuado. Utilice el servicio de notificaciones push. Para obtener más información sobre la migración al servicio de notificaciones push, consulte el tema Migración a notificaciones push desde notificaciones basadas en un origen de sucesos.</td>
    </tr>
    <tr>
      <td>
        Seguridad: El reino contra la falsificación de solicitudes entre sitios (anti-XSRF) (<code>wl_antiXSRFRealm</code>) ya no es necesario en la V8.0.
      </td>
      <td>
        In la V7.1.0, el contexto de autenticación se almacena en la sesión HTTP y es identificado mediante una cookie de sesión, que se envía al navegador en solicitudes entre sitios. El reino anti-XSRF en esta versión se utiliza para proteger la transmisión de cookies en relación a ataques XSFR utilizando una cabecera adicional que se envía desde el cliente al servidor.
        <br />
        En la V8.0.0, el contexto de seguridad ya no está asociado con una sesión HTTP ni se identifica mediante una cookie de sesión.
        En su lugar, la autorización se realiza mediante la utilización de una señal de acceso 2.0 OAuth que se pasa en la cabecera de autorización.
        Puesto que la cabecera de autorización lo la envía el navegador en solicitudes entre sitios, no hay la necesidad de protegerse en relación a ataques XSRF.
      </td>
    </tr>
    <tr>
        <td>Seguridad: Autenticación de certificados de usuario. La V8.0 no incluye ninguna comprobación de seguridad predefinida para autenticar usuarios con certificados del lado del cliente X.509.</td>
        <td>No en v8.0.</td>
    </tr>
    <tr>
        <td>Seguridad: Integración con IBM Trusteer. La versión 8.0 no incluye ningún desafío o comprobación de seguridad predefinido para probar factores de riesgo de IBM Trusteer.</td>
        <td>No en v8.0. Utilice IBM Trusteer Mobile SDK.</td>
    </tr>
    <tr>
        <td>Seguridad: Aprovisionamiento de dispositivo y aprovisionamiento automático de dispositivo.	</td>
        <td><p>Discontinuado.</p><p>Nota: El aprovisionamiento de dispositivo se maneja en el flujo de autorizaciones normal. Los datos de dispositivo normalmente se recopilan durante el proceso de registro del flujo de seguridad. Para obtener más información sobre el flujo de seguridad, consulte Flujo de autorización de principio a fin.</p>
        </td>
    </tr>
    <tr>
        <td>Seguridad: Archivo de configuración para enmascarar código Android con ProGuard. La versión 8.0 no incluye el archivo de configuración proguard-project.txt predefinido para el enmascaramiento ProGuard de Android ProGuard con una aplicación Android de MobileFirst.	</td>
        <td>No en v8.0.</td>
    </tr>
    <tr>
        <td>Seguridad: Se ha sustituido la autenticación basada en adaptador. La autenticación utiliza el protocolo OAuth y está implementada con comprobaciones de seguridad.</td>
        <td>Ha sido sustituida por una implementación basada en las comprobaciones de seguridad.</td>
    </tr>
    <tr>
        <td><p>Seguridad: Inicio de sesión LDAP. La V8.0 no incluye ninguna comprobación de seguridad predefinida para autenticar usuarios con un servidor LDAP.</p>
        <p>En lugar de ello, para WebSphere Application Server o WebSphere Application Server Liberty utilice el servidor de aplicaciones o una pasarela para correlacionar proveedores de identidad como, por ejemplo, LDAP con LTPA, y generar las señales OAuth para los usuarios mediante una comprobación de seguridad LTPA.</p></td>
        <td>No en v8.0. Sustituido por una comprobación de seguridad LTPA para WebSphere Application Server o WebSphere Application Server Liberty.</td>
    </tr>
    <tr>
        <td>
        Configuración de autenticación del adaptador HTTP. El adaptador HTTP predefinido no da soporte a la conexión como un usuario a un servidor remoto.</td>
        <td><p>No en v8.0.</p><p>Edite el código fuente del adaptador HTTP y añada el código de autenticación. Utilice <code>MFP.Server.invokeHttp</code> para añadir señales de autenticación a la cabecera de la solicitud HTTP.</p></td>
    </tr>
    <tr>
        <td>
        Security Analytics, la posibilidad de supervisar sucesos de la infraestructura de seguridad de MobileFirst con MobileFirst Analytics Console no está disponible en la v8.0.</td>
        <td>No en v.8.0.</td>
    </tr>
    <tr>
        <td>Se ha discontinuado el modelo de notificaciones push para un modelo basado en un origen de sucesos. Este modelo ha sido sustituido por el modelo de servicio push basado en etiquetas.</td>
        <td>Discontinuado y sustituido por el modelo de servicio push basado en etiquetas.</td>
    </tr>
    <tr>
        <td>No se proporciona el soporte a USSD (Unstructured Supplementary Service Data) en la versión 8.0.</td>
        <td>No en v8.0.</td>
    </tr>
    <tr>
        <td>En la v8.0 no se da soporte a la utilización de Cloudant como base de datos para {{ site.data.keys.mf_server }}.	</td>
        <td>No en v8.0.</td>
    </tr>
    <tr>
        <td>Geoubicación: Se discontinua el soporte de geoubicación en {{ site.data.keys.product }} v8.0. Se han discontinuado las API REST para balizas y mediadores. Se discontinúan las API WL.Geo and WL.Device del lado del cliente y del lado del servidor.	</td>
        <td>Discontinuado. Utilice la API de dispositivo nativa o los plugins de Cordova de terceros para la geoubicación.</td>
    </tr>
    <tr>
        <td>Se ha discontinuado la característica {{ site.data.keys.product_adj }} Data Proxy. También se han discontinuado las API Cloudant IMFData y CloudantToolkit.	</td>
        <td>Discontinuado. Para obtener más información sobre cómo sustituir las API IMFData y CloudantToolkit en sus aplicaciones, consulte Migración de aplicaciones que almacenan datos móviles en Cloudant con IMFData o Cloudant SDK.</td>
    </tr>
    <tr>
        <td>IBM Tealeaf SDK ya no se empaqueta con {{ site.data.keys.product }}.	</td>
        <td>Discontinuado. Utilice IBM Tealeaf SDK. Para obtener más información, consulte <a href="https://www.ibm.com/support/knowledgecenter/TLSDK/AndroidGuide1010/CFs/TLAnddLggFrwkInstandImpl/TealeafAndroidLoggingFrameworkInstallationAndImplementation.dita?cp=SS2MBL_9.0.2%2F5-0-1-0&lang=en">Tealeaf installation and implementation in an Android application</a> y <a href="https://www.ibm.com/support/knowledgecenter/TLSDK/iOSGuide1010/CFs/TLiOSLggFrwkInstandImpl/TealeafIOSLoggingFrameworkInstallationAndImplementation.dita?cp=SS2MBL_9.0.2%2F5-0-3-1&lang=en">Tealeaf iOS Logging Framework Installation and Implementation</a> en la documentación de IBM Tealeaf Customer Experience.</td>
    </tr>
    <tr>
        <td>{{ site.data.keys.mf_test_workbench_full }} no se empaqueta con {{ site.data.keys.product }}</td>
        <td>Discontinuado.</td>
    </tr>
    <tr>
        <td>{{ site.data.keys.product }} v8.0 deja de dar soporte a BlackBerry, Adobe AIR y Windows Silverlight. No se proporciona un SDK para ninguna de estas plataformas.	</td>
        <td>Discontinuado.</td>
    </tr>
</table>

## Cambios de API del lado del servidor
{: #server-side-api-changes }
Para migrar el lado del servidor de sus aplicaciones de {{ site.data.keys.product_adj }}, debe tener en cuenta los cambios en las API.  
En las siguientes tablas se proporciona una lista de elementos de API del lado del servidor discontinuados en la v8.0, elementos de API del lado del servidor en desuso en la v8.0 y alternativas de migración sugeridas. Para más información sobre la migración del lado del servidor de la aplicación,

### Elementos de API de JavaScript en la v8.0
{: #javascript-api-elements-discontinued-v-v-80 }
#### Seguridad
{: #security }

|API                         |Sustitución                               |
|------------------------------------|------------------------------------------------|
|`WL.Server.getActiveUser`, `WL.Server.getCurrentUserIdentity`,  `WL.Server.getCurrentDeviceIdentity`, `WL.Server.setActiveUser`, `WL.Server.getClientId`, `WL.Server.getClientDeviceContext`, `WL.Server.setApplicationContext` |En su lugar, utilice `MFP.Server.getAuthenticatedUser`. |

#### Origen de suceso
{: #event-source }

|API           |Sustitución                               |
|------------------------------------|------------------------------------------------|
|`WL.Server.createEventSource`	     |En su lugar, utilice `MFP.Server.getAuthenticatedUser`. |
|`WL.Server.setEventHandlers`         |Para migrar desde notificaciones basadas en un origen de sucesos a notificaciones basadas en etiquetas, consulte Migración a notificaciones push desde notificaciones basadas en un origen de sucesos. |
|`WL.Server.createEventHandler`       |                                                |
|`WL.Server.createSMSEventHandler`	 |Para enviar mensajes SMS, utilice la API REST de servicio push. Para obtener más información, consulte [Envío de notificaciones](../../../notifications/sending-notifications).                         |
|`WL.Server.createUSSDEventHandler`	 |Integre USSD utilizando servicios de terceros.  |

#### Push
{: #push }

|API           |Sustitución                               |
|-------------------------------------------|------------------------------------------------|
|`WL.Server.getUserNotificationSubscription`, `WL.Server.notifyAllDevices`, `WL.Server.sendMessage`, `WL.Server.notifyDevice`, `WL.Server.notifyDeviceSubscription`, `WL.Server.notifyAll`, `WL.Server.createDefaultNotification`, `WL.Server.submitNotification` 	|Para migrar desde notificaciones basadas en un origen de sucesos a notificaciones basadas en etiquetas, consulte Migración a notificaciones push desde notificaciones basadas en un origen de sucesos. |
|`WL.Server.subscribeSMS`	                |Utilice la API REST Push Device Registration (POST) para registrar el dispositivo. Para enviar y recibir notificaciones SMS, proporcione el phoneNumber en la carga útil al invocar la API.                               |
|`WL.Server.unsubscribeSMS`	                |Utilice la API REST Push Device Registration (DELETE) para anular el registro del dispositivo. |
|`WL.Server.getSMSSubscription`	            |Utilice la API REST Push Device Registration GET) para obtener registros de dispositivos. |

#### Servicios de ubicación
{: #location-services }

|API           |Sustitución                               |
|-------------------------------------------|------------------------------------------------|
|`WL.Geo.*`	                                |Integre los servicios de ubicación utilizando servicios de terceros. |

#### Seguridad WS
{: #ws-security }

|API           |Sustitución                               |
|-------------------------------------------|------------------------------------------------|
|`WL.Server.signSoapMessage`	                |Utilice las funcionalidades de seguridad WS de WebSphere Application Server. |

### Elementos de API JAVA discontinuados en la v8.0
{: #java-api-elements-discontinued-in-v-80 }
#### Seguridad
{: #security-java }

|API           |Sustitución                               |
|-------------------------------------------|------------------------------------------------|
|`SecurityAPI.getSecurityContext`	        |En su lugar, utilice AdapterSecurityContext.            |

#### Push
{: #push-java }

|API           |Sustitución                               |
|-------------------------------------------|------------------------------------------------|
|`PushAPI.sendMessage(INotification notification, String applicationId)`	|Para migrar desde notificaciones basadas en un origen de sucesos a notificaciones basadas en etiquetas, consulte Migración a notificaciones push desde notificaciones basadas en un origen de sucesos. |
|`INotification PushAPI.buildNotification();` |Para migrar desde notificaciones basadas en un origen de sucesos a notificaciones basadas en etiquetas, consulte Migración a notificaciones push desde notificaciones basadas en un origen de sucesos. |
|`UserSubscription PushAPI.getUserSubscription(String eventSource, String userId)` |Para migrar desde notificaciones basadas en un origen de sucesos a notificaciones basadas en etiquetas, consulte Migración a notificaciones push desde notificaciones basadas en un origen de sucesos. |

#### Adaptadores
{: #adapters-java }

|API           |Sustitución                               |
|-------------------------------------------|------------------------------------------------|
|Interfaz `AdaptersAPI` en el paquete `com.worklight.adapters.rest.api` |En su lugar, utilice la interfaz `AdaptersAPI` en el paquete `com.ibm.mfp.adapter.api`. |
|Interfaz `AnalyticsAPI` en el paquete `com.worklight.adapters.rest.api` |En su lugar, utilice la interfaz `AnalyticsAPI` en el paquete `com.ibm.mfp.adapter.api`. |
|Interfaz `ConfigurationAPI` en el paquete `com.worklight.adapters.rest.api` |En su lugar, utilice la interfaz `ConfigurationAPI` en el paquete `com.ibm.mfp.adapter.api`. |
|Anotación `OAuthSecurity` en el paquete `com.worklight.core.auth` |En su lugar, utilice la anotación `OAuthSecurity` en el paquete `com.ibm.mfp.adapter.api` |
|Clase `MFPJAXRSApplication` en el paquete `com.worklight.wink.extensions` |En su lugar, utilice la clase `MFPJAXRSApplication` en el paquete `com.ibm.mfp.adapter.api`. |
|Interfaz `WLServerAPI` en el paquete `com.worklight.adapters.rest.api` |Utilice la anotación JAX-RS `Context` para acceder directamente a las interfaces de API {{ site.data.keys.product_adj }}. |
|Clase `WLServerAPIProvider` en el paquete `com.worklight.adapters.rest.api` |Utilice la anotación JAX-RS `Context` para acceder directamente a las interfaces de API {{ site.data.keys.product_adj }}. |

## Cambios de API del lado del cliente
{: #client-side-api-changes }
Los siguientes cambios en las API son importantes para poder migrar su aplicación de cliente de {{ site.data.keys.product_adj }}.  
En las siguientes tablas se proporciona una lista de elementos de API del lado del cliente discontinuados en la v8.0.0, elementos de API del lado del cliente en desuso en la V8.0.0 y alternativas de migración sugeridas.

### API de JavaScript
{: #javascript-apis }
En la V8.0 ya no se da soporte a estas API JavaScript que afectan a la interfaz de usuario. Se pueden sustituir con plugins de Cordova de terceros que ya existan o creando plugins de Cordova personalizados.

|API           |Migración                           |
|-----------------------|------------------------------------------|
|`WL.BusyIndicator`, `WL.OptionsMenu`, `WL.TabBar`, `WL.TabBarItem` |Utilice plugins Cordova o elementos HTML 5. |
|`WL.App.close` |Maneje este suceso fuera de {{ site.data.keys.product_adj }}. |
|`WL.App.copyToClipboard()` |Utilice plugins de Cordova que proporcionen esta funcionalidad. |
|`WL.App.openUrl(url, target, options)` |Utilice plugins de Cordova que proporcionen esta funcionalidad. **Nota:** El plugin **InAppBrowser** de Cordova proporciona esta característica. |
|`WL.App.overrideBackButton(callback)`, `WL.App.resetBackButton()` |Utilice plugins de Cordova que proporcionen esta funcionalidad. **Nota:** El plugin **backbutton** de Cordova proporciona esta característica. |
|`WL.App.getDeviceLanguage()` |Utilice plugins de Cordova que proporcionen esta funcionalidad. **Nota:** El plugin de Cordova **cordova-plugin-globalization** proporciona esta característica. |
|`WL.App.getDeviceLocale()` |Utilice plugins de Cordova que proporcionen esta funcionalidad. **Nota:** El plugin de Cordova **cordova-plugin-globalization** proporciona esta característica. |
|`WL.App.BackgroundHandler` |Para ejecutar una función de manejador personalizada, utilice el escucha de sucesos de pausa estándar de Cordova. Utiliza un plugin de Cordova que proporciona seguridad y que impide que los usuarios y los sistemas iOS y Android tomen instantáneas o capturas de pantalla. Para obtener más información, consulte la descripción de **[PrivacyScreenPlugin](https://github.com/devgeeks/PrivacyScreenPlugin)**. |
|`WL.Client.close`, `WL.Client.restore`, `WL.Client.minimize` |Estas funciones se proporcionaron para dar soporte a la plataforma Adobe AIR, a la que {{ site.data.keys.product }} V8.0.0 no da soporte. |
|`WL.Toast.show(string)` |Utilice plugins de Cordova para Toast. |

En la v8.0 ya no se da soporte a este conjunto de API.

|API           |Migración                           |
|-----------------------|------------------------------------------|
|`WL.Client.checkForDirectUpdate(options)` |Sin sustitución. **Nota:** Puede llamar a `WLAuthorizationManager.obtainAccessToken` para desencadenar una actualización directa si hay una disponible. El acceso a las señales de seguridad desencadena una actualización directa si hay una disponible en el servidor. Sin embargo, no es posible desencadenar Direct Update bajo demanda. |
|`WL.Client.setSharedToken({key: myName, value: myValue})`, `WL.Client.getSharedToken({key: myName})`, `WL.Client.clearSharedToken({key: myName})` |Sin sustitución. |
|`WL.Client.isConnected()`, opción de inicialización `connectOnStartup` |Utilice `WLAuthorizationManager.obtainAccessToken` para comprobar la conectividad con el servidor y aplicar reglas de gestión de aplicaciones. |
|`WL.Client.setUserPref(key,value, options)`, `WL.Client.setUserPrefs(userPrefsHash, options)`, `WL.Client.deleteUserPrefs(key, options)` |Sin sustitución. Puede utilizar un adaptador y la API `MFP.Server.getAuthenticatedUser` para gestionar las preferencias de usuario. |
|`WL.Client.getUserInfo(realm, key)`, `WL.Client.updateUserInfo(options)` |Sin sustitución. |
|`WL.Client.logActivity(activityType)` |Utilice `WL.Logger`. |
|`WL.Client.login(realm, options)` |Utilice `WLAuthorizationManager.login`. Para empezar con la autenticación y seguridad, consulte las guías de aprendizaje de Autenticación y Seguridad. |
|`WL.Client.logout(realm, options)` |Utilice `WLAuthorizationManager.logout`. |
|`WL.Client.obtainAccessToken(scope, onSuccess, onFailure)` |Utilice `WLAuthorizationManager.obtainAccessToken`. |
|`WL.Client.transmitEvent(event, immediate)`, `WL.Client.purgeEventTransmissionBuffer()`, `WL.Client.setEventTransmissionPolicy(policy)` |Cree un adaptador personalizado para recibir notificaciones de estos sucesos. |
|`WL.Device.getContext()`, `WL.Device.startAcquisition(policy, triggers, onFailure)`, `WL.Device.stopAcquisition()`, `WL.Device.Wifi`, `WL.Device.Geo.Profiles`, `WL.Geo` |Utilice la API nativa o plugins de Cordova de terceros para la geolocalización. |
|`WL.Client.makeRequest (url, options)` |Cree un adaptador personalizado que proporcione la misma funcionalidad |
|`WLDevice.getID(options)` |Utilice plugins de Cordova que proporcionen esta funcionalidad. **Nota:** Para su información, `device.uuid` del plugin **cordova-plugin-device** proporciona esta característica. |
|`WL.Device.getFriendlyName()` |Utilice `WL.Client.getDeviceDisplayName` |
|`WL.Device.setFriendlyName()` |Utilice `WL.Client.setDeviceDisplayName` |
|`WL.Device.getNetworkInfo(callback)` |Utilice plugins de Cordova que proporcionen esta funcionalidad. **Nota:** El plugin **cordova-plugin-network-information** proporciona esta característica. |
|`WLUtils.wlCheckReachability()` |Cree un adaptador personalizado para comprobar la disponibilidad del servidor. |
|`WL.EncryptedCache` |Utilice JSONStore para almacenar localmente los datos cifrados. JSONStore se encuentra en el plugin **cordova-plugin-mfp-jsonstore**. Para obtener más información, consulte [JSONStore](../../../application-development/jsonstore). |
|`WL.SecurityUtils.remoteRandomString(bytes)` |Cree un adaptador personalizado que proporcione la misma funcionalidad. |
|`WL.Client.getAppProperty(property)` |Puede recuperar la propiedad de la versión de la aplicación utilizando el plugin **cordova-plugin-appversion**. La versión que se devuelve es la versión de la aplicación nativa (únicamente para Android e iOS). |
|`WL.Client.Push.*` |Utilice la API push del lado del cliente del plugin **cordova-plugin-mfp-push**. |
|`WL.Client.Push.subscribeSMS(alias, adapterName, eventSource, phoneNumber, options)` |Utilice `MFPPush.registerDevice(org.json.JSONObject options, MFPPushResponseListener listener)` para registrar el dispositivo para push y SMS. |
|`WLAuthorizationManager.obtainAuthorizationHeader(scope)` |Utilice `WLAuthorizationManager.obtainAccessToken` para obtener una señal para el ámbito necesario. |
|`WLClient.getLastAccessToken(scope)` |Utilice `WLAuthorizationManager.obtainAccessToken` |
|`WLClient.getLoginName()`, `WL.Client.getUserName(realm)` |Sin sustitución |
|`WL.Client.getRequiredAccessTokenScope(status, header)` |Utilice `WLAuthorizationManager.isAuthorizationRequired` y `WLAuthorizationManager.getResourceScope`. |
|`WL.Client.isUserAuthenticated(realm)` |Sin sustitución |
|`WLUserAuth.deleteCertificate(provisioningEntity)` |Sin sustitución |
|`WL.Trusteer.getRiskAssessment(onSuccess, onFailure)` |Sin sustitución |
|`WL.Client.createChallengeHandler(realmName)` |Si desea crear un manejador de desafíos para manejar desafíos de pasarelas personalizadas, utilice `WL.Client.createGatewayChallengeHandler(gatewayName)`. Si desea crear un manejador de desafíos para manejar desafíos de comprobación de seguridad de {{ site.data.keys.product_adj }}, utilice `WL.Client.createSecurityCheckChallengeHandler(securityCheckName)`. |
|`WL.Client.createWLChallengeHandler(realmName)` |Utilice `WL.Client.createSecurityCheckChallengeHandler(securityCheckName)`. |
|`challengeHandler.isCustomResponse()` donde challengeHandler es un objeto de manejo de desafíos que `WL.Client.createChallengeHandler()` devuelve. |Utilice `gatewayChallengeHandler.canHandleResponse()` donde `gatewayChallengeHandler` es un objeto manejador de desafíos que `WL.Client.createGatewayChallengeHandler()` devuelve. |
|`wlChallengeHandler.processSucccess()` donde `wlChallengeHandler` es un objeto de manejo de desafíos que `WL.Client.createWLChallengeHandler()` devuelve. |Utilice `securityCheckChallengeHandler.handleSuccess()` donde `securityCheckChallengeHandler` es un objeto manejador de desafíos que `WL.Client.createSecurityCheckChallengeHandler()` devuelve. |
|`WL.Client.AbstractChallengeHandler.submitAdapterAuthentication()` |Implemente una lógica similar en su manejador de desafíos. En el caso de manejadores de desafíos de pasarela, utilice un objeto manejador de desafíos que `WL.Client.createGatewayChallengeHandler()` devuelva. Para manejadores de desafíos de comprobación de seguridad de {{ site.data.keys.product_adj }}, utilice un objeto manejador de desafíos que `WL.Client.createSecurityCheckChallengeHandler()` devuelva. |
|`WL.Client.createProvisioningChallengeHandler()` |Sin sustitución. La infraestructura de seguridad ahora maneja de forma automática el aprovisionamiento de dispositivos. |

#### API JavaScript en desuso
{: #deprecated-javascript-apis }

|API           |Migración                           |
|-----------------------|------------------------------------------|
|`WLClient.invokeProcedure(WLProcedureInvocationData invocationData,WLResponseListener responseListener)`, `WL.Client.invokeProcedure(invocationData, options)`, `WLClient.invokeProcedure(WLProcedureInvocationData invocationData, WLResponseListener responseListener, WLRequestOptions requestOptions)`, `WLProcedureInvocationResult` |En su lugar, utilice `WLResourceRequest`. **Nota:** La implementación de `invokeProcedure` utiliza `WLResourceRequest`. |
|`WLClient.getEnvironment` |Utilice plugins de Cordova que proporcionen esta funcionalidad. **Nota:** El plugin **device.platform** proporciona esta característica. |
|`WLClient.getLanguage` |Utilice plugins de Cordova que proporcionen esta funcionalidad. **Nota:** El plugin **cordova-plugin-globalization** proporciona esta característica. |
|`WL.Client.connect(options)` |Utilice `WLAuthorizationManager.obtainAccessToken` para comprobar la conectividad con el servidor y aplicar reglas de gestión de aplicaciones. |

### API Android
{: #android-apis}
####  Elementos de API Android discontinuadas
{: #discontinued-android-api-elements }

|API           |Migración                           |
|-----------------------|------------------------------------------|
|`WLConfig WLClient.getConfig()` |Sin sustitución. |
|`WLDevice WLClient.getWLDevice()`, `WLClient.transmitEvent(org.json.JSONObject event)`, `WLClient.setEventTransmissionPolicy(WLEventTransmissionPolicy policy)`, `WLClient.purgeEventTransmissionBuffer()` |Utilice API Android o paquetes de terceros para la geolocalización. |
|`WL.Client.getUserInfo(realm, key)`, `WL.Client.updateUserInfo(options)` |Sin sustitución. |
|`WL.Client.getUserInfo(realm, key`, `WL.Client.updateUserInfo(options)` |Sin sustitución. |
|`WLClient.checkForNotifications()` |Utilice `WLAuthorizationManager.obtainAccessToken("", listener)` para comprobar la conectividad con el servidor y aplicar reglas de gestión de aplicaciones. |
|`WLClient.login(java.lang.String realmName, WLRequestListener listener, WLRequestOptions options)`, `WLClient.login(java.lang.String realmName, WLRequestListener listener)` |Utilice `AuthorizationManager.login()` |
|`WLClient.logout(java.lang.String realmName, WLRequestListener listener, WLRequestOptions options)`, `WLClient.logout(java.lang.String realmName, WLRequestListener listener)` |Utilice `AuthorizationManager.logout()` |
|`WLClient.obtainAccessToken(java.lang.String scope,WLResponseListener responseListener)` |Utilice `WLAuthorizationManager.obtainAccessToken(String, WLAccessTokenListener)` para comprobar la conectividad con el servidor y aplicar reglas de gestión de aplicaciones. |
|`WLClient.getLastAccessToken()`, `WLClient.getLastAccessToken(java.lang.String scope)` |Utilice `AuthorizationManager` |
|`WLClient.getRequiredAccessTokenScope(int status, java.lang.String header)` |Utilice `AuthorizationManager` |
|`WLClient.logActivity(java.lang.String activityType)` |Utilice `com.worklight.common.Logger`. Consulte Logger SDK para obtener más información. |
|`WLAuthorizationPersistencePolicy` |Sin sustitución. Para implementar la persistencia de la autorización, almacene la señal de autorización en el código de la aplicación y cree solicitudes HTTP personalizadas. |
|`WLSimpleSharedData.setSharedToken(myName, myValue)`, `WLSimpleSharedData.getSharedToken(myName)`, `WLSimpleSharedData.clearSharedToken(myName)` |Utilice las API Android para compartir señales en todas las aplicaciones. |
|`WLUserCertificateManager.deleteCertificate(android.content.Context context)` |Sin sustitución |
|`BaseChallengeHandler.submitFailure(WLResponse wlResponse)` |Utilice `BaseChallengeHandler.cancel()` |
|`ChallengeHandler` |Para desafíos de pasarela personalizados, utilice `GatewayChallengeHandler`. Para desafíos de comprobación de seguridad de {{ site.data.keys.product_adj }}, utilice `SecurityCheckChallengeHandler`. |
|`WLChallengeHandler` |Utilice `SecurityCheckChallengeHandler`. |
|`ChallengeHandler.isCustomResponse()` |Utilice `GatewayChallengeHandler.canHandleResponse()`. |
|`ChallengeHandler.submitAdapterAuthentication` |Implemente una lógica similar en su manejador de desafíos. Para manejadores de desafíos de pasarela personalizados, utilice `GatewayChallengeHandler`. |

#### API Android en desuso
{: #deprecated-android-apis }

|API           |Migración                           |
|-----------------------|------------------------------------------|
|`WLClient.invokeProcedure(WLProcedureInvocationData invocationData, WLResponseListener responseListener)` |En desuso. Utilice `WLResourceRequest`. **Nota:** La implementación de `invokeProcedure` utiliza `WLResourceRequest`. |
|`WLClient.connect(WLResponseListener responseListener)`, `WLClient.connect(WLResponseListener responseListener,WLRequestOptions options)` |Utilice `WLAuthorizationManager.obtainAccessToken("", listener)` para comprobar la conectividad con el servidor y aplicar reglas de gestión de aplicaciones. |

#### API Android que dependen de las API org.apach.http antiguas a las que ya no se les da soporte
{: #android-apis-depending-on-the-legacy-orgapachehttp-apis-are-no-longer-supported }

|API           |Migración                           |
|-----------------------|------------------------------------------|
|`org.apache.http.Header[]` está ahora en desuso. Por lo tanto, se han eliminado los siguientes métodos:||
|`org.apache.http.Header[] WLResourceRequest.getAllHeaders()` |Utilice en su lugar la nueva API `Map<String, List<String>> WLResourceRequest.getAllHeaders()`. |
|`WLResourceRequest.addHeader(org.apache.http.Header header)` |En su lugar, utilice la nueva API `WLResourceRequest.addHeader(String name, String value)`. |
|`org.apache.http.Header[] WLResourceRequest.getHeaders(java.lang.String headerName)` |Utilice en su lugar la nueva API `List<String> WLResourceRequest.getHeaders(String headerName)`. |
|`org.apache.http.Header WLResourceRequest.getFirstHeader(java.lang.String headerName)` |En su lugar, utilice la nueva API `WLResourceRequest.getHeaders(String headerName)`. |
|`WLResourceRequest.setHeaders(org.apache.http.Header[] headers)` |En su lugar, utilice la nueva API `WLResourceRequest.setHeaders(Map<String, List<String>> headerMap)`. |
|`WLResourceRequest.setHeader(org.apache.http.Header header)` |En su lugar, utilice la nueva API `WLResourceRequest.setHeaders(Map<String, List<String>> headerMap)`. |
|`org.apache.http.client.CookieStore WLClient.getCookieStore()` |Sustituido por `java.net.CookieStore getCookieStore WLClient.getCookieStore()` |
|`WLClient.setAllowHTTPClientCircularRedirect(boolean isSet)` |Sin sustitución. El cliente MFP permite redirecciones circulares. |
|`WLHttpResponseListener`, `WLResourceRequest.send(java.util.HashMap formParameters,WLHttpResponseListener listener)`, `WLResourceRequest.send(org.json.JSONObject json, WLHttpResponseListener listener)`, `WLResourceRequest.send(byte[] data, WLHttpResponseListener listener)`, `WLResourceRequest.send(java.lang.String requestBody,WLHttpResponseListener listener)`, `WLResourceRequest.send(WLHttpResponseListener listener)`, `WLClient.sendRequest(org.apache.http.client.methods.HttpUriRequest request,WLHttpResponseListener listener)`, `WLClient.sendRequest(org.apache.http.client.methods.HttpUriRequest request, WLResponseListener listener)` |Eliminadas debido a las dependencias del cliente HTTP de Apache en desuso. Cree sus propias solicitudes para tener un control completo sobre las solicitudes y las respuestas. |

#### El paquete `com.worklight.androidgap.api` proporciona la funcionalidad de plataforma Android para las aplicaciones Cordova. Se han realizado varios cambios en {{ site.data.keys.product }} para acomodar la integración de Cordova.
{: #comworklightandroidgapapi }

|API           |Migración                           |
|-----------------------|------------------------------------------|
|La actividad Android ha sido sustituida con el contexto Android. | |
|`static WL.createInstance(android.app.Activity activity)` |`static WL.createInstance(android.content.Context context)` crea una instancia compartida. |
|`static WL.getInstance()` |`static WL.getInstance()` Obtiene una instancia de la clase WL. No es posible llamar a este método antes de `WL.createInstance(Context)`. |

### API Objective-C
{: #objective-c-apis }
#### API iOS Objective C discontinuadas
{: #discontinued-ios-objective-c-apis }

|API           |Migración                           |
|-----------------------|------------------------------------------|
|`[WLClient getWLDevice][WLClient transmitEvent:]`, `[WLClient setEventTransmissionPolicy]`, `[WLClient purgeEventTransmissionBuffer]` |Se ha eliminado la geolocalización. Utilice los paquetes de terceros o iOS nativos para la geolocalización. |
|`WL.Client.getUserInfo(realm, key)`, `WL.Client.updateUserInfo(options)` |Sin sustitución. |
|`WL.Client.deleteUserPref(key, options)` |Sin sustitución. Puede utilizar un adaptador y la API `MFP.Server.getAuthenticatedUser` para gestionar las preferencias de usuario. |
|`[WLClient getRequiredAccessTokenScopeFromStatus]` |Utilice `WLAuthorizationManager obtainAccessTokenForScope`. |
|`[WLClient login:withDelegate:]` |Utilice `WLAuthorizationManager login`. |
|`[WLClient logout:withDelegate:]` |Utilice `WLAuthorizationManager logout`. |
|`[WLClient lastAccessToken]`, `[WLClient lastAccessTokenForScope:]` |Utilice `WLAuthorizationManager obtainAccessTokenForScope`. |
|`[WLClient obtainAccessTokenForScope:withDelegate:]`, `[WLClient getRequiredAccessTokenScopeFromStatus:authenticationHeader:]` |Utilice `WLAuthorizationManager obtainAccessTokenForScope`. |
|`[WLClient isSubscribedToAdapter:(NSString *) adaptereventSource:(NSString *) eventSource` |Utilice API push Objective-C del lado del cliente para aplicaciones iOS desde la infraestructura IBMMobileFirstPlatformFoundationPush |
|`[WLClient - (int) getEventSourceIDFromUserInfo: (NSDictionary *) userInfo]` |Utilice API push Objective-C del lado del cliente para aplicaciones iOS desde la infraestructura IBMMobileFirstPlatformFoundationPush. |
|`[WLClient invokeProcedure: (WLProcedureInvocationData *) ]` |En desuso. En su lugar, utilice `WLResourceRequest`. |
|`WLClient sendUrlRequest:delegate:]` |En su lugar, utilice `[WLResourceRequest sendWithDelegate:delegate]`. |
|`[WLClient (void) logActivity:(NSString *) activityType]` |Se ha eliminado. Utilice un registrador de Objective C. |
|`[WLSimpleDataSharing setSharedToken: myName value: myValue]`, `[WLSimpleDataSharing getSharedToken: myName]]`, `[WLSimpleDataSharing clearSharedToken: myName]` |Utilice las API OS para compartir señales en todas las aplicaciones. |
|`BaseChallengeHandler.submitFailure(WLResponse *)challenge` |Utilice `BaseChallengeHandler.cancel()`. |
|`BaseProvisioningChallengeHandler` |Sin sustitución. La infraestructura de seguridad ahora maneja de forma automática el aprovisionamiento de dispositivos. |
|`ChallengeHandler` |Para desafíos de pasarela personalizados, utilice `GatewayChallengeHandler`. Para desafíos de comprobación de seguridad de {{ site.data.keys.product_adj }}, utilice `SecurityCheckChallengeHandler`. |
|`WLChallengeHandler` |Utilice `SecurityCheckChallengeHandler`. |
|`ChallengeHandler.isCustomResponse()` |Utilice `GatewayChallengeHandler.canHandleResponse()`. |
|`ChallengeHandler.submitAdapterAuthentication` |Implemente una lógica similar en su manejador de desafíos. Para manejadores de desafíos de pasarela personalizados, utilice `GatewayChallengeHandler`. Para manejadores de desafíos de comprobación de seguridad de {{ site.data.keys.product_adj }}, utilice `SecurityCheckChallengeHandler`. |

### API Windows C#
{: #windows-c-apis }
#### Elementos de API Windows C# - Clases
{: #deprecated-windows-c-api-elements-classes }

|API           |Migración                           |
|-----------------------|------------------------------------------|
|`ChallengeHandler` |Para desafíos de pasarela personalizados, utilice `GatewayChallengeHandler`. Para desafíos de comprobación de seguridad de {{ site.data.keys.product_adj }}, utilice `SecurityCheckChallengeHandler`. |
|`ChallengeHandler. isCustomResponse()` |Utilice `GatewayChallengeHandler.canHandleResponse()`. |
|`ChallengeHandler.submitAdapterAuthentication` |Implemente una lógica similar en su manejador de desafíos. Para manejadores de desafíos de pasarela personalizados, utilice `GatewayChallengeHandler`. Para manejadores de desafíos de comprobación de seguridad de {{ site.data.keys.product_adj }}, utilice `SecurityCheckChallengeHandler`. |
|`ChallengeHandler.submitFailure(WLResponse wlResponse)` |Para manejadores de desafíos de pasarela personalizados, utilice `GatewayChallengeHandler.Shouldcancel`. Para manejadores de desafíos de comprobación de seguridad de {{ site.data.keys.product_adj }}, utilice `SecurityCheckChallengeHandler.ShouldCancel`. |
|`WLAuthorizationManager` |En su lugar, utilice `WorklightClient.WorklightAuthorizationManager`. |
|`WLChallengeHandler` |Utilice `SecurityCheckChallengeHandler`. |
|`WLChallengeHandler.submitFailure(WLResponse wlResponse)` |Utilice `SecurityCheckChallengeHandler.ShouldCancel()`. |
|`WLClient` |En su lugar, utilice `WorklightClient`. |
|`WLErrorCode` |No soportado. |
|`WLFailResponse` |En su lugar, utilice `WorklightResponse`. |
|`WLResponse` |En su lugar, utilice `WorklightResponse`. |
|`WLProcedureInvocationData` |En su lugar, utilice `WorklightProcedureInvocationData`. |
|`WLProcedureInvocationFailResponse` |No soportado. |
|`WLProcedureInvocationResult` |No soportado. |
|`WLRequestOptions` |No soportado. |
|`WLResourceRequest` |No soportado. |

#### Elementos de API Windows C# - Interfaces
{: #deprecated-windows-c-api-elements-interfaces }

|API           |Migración                           |
|-----------------------|------------------------------------------|
|`WLHttpResponseListener` |No soportado. |
|`WLResponseListener` |La respuesta estará disponible con un objeto `WorklightResponse` |
|`WLAuthorizationPersistencePolicy` |No soportado. |
