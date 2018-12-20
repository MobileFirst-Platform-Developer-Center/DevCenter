---
layout: tutorial
title: Limitaciones y problemas conocidos
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## Problemas conocidos
{: #known-issues }
Pulse en el enlace siguiente para recibir una lista generada de forma dinámica de documentos para este release específico y todos sus fixpacks, incluidos problemas conocidos y sus relaciones, así como descargas relevantes:[http://www.ibm.com/support/search.wss?tc=SSVNUQ&tc=SSHT2F&atrn=SWVersion&atrv=8.0](http://www.ibm.com/support/search.wss?tc=SSVNUQ&tc=SSHT2F&atrn=SWVersion&atrv=8.0).

## Limitaciones conocidas
{: #known-limitations }
En esta documentación, podrá encontrar la descripción de las limitaciones de {{ site.data.keys.product_full }} en ubicaciones diferentes:

* Cuando la limitación se aplica a una característica especial, podrá encontrar su descripción en el tema que explica dicha característica. Será entonces cuando podrá identificar inmediatamente cómo afecta a la característica.
* No obstante, podrá encontrar la descripción aquí sí las limitaciones conocidas son generales, esto es, que se aplican a temas diferentes y es posible que no estén relacionados directamente entre sí.

### Globalización
{: #globalization }
Si está desarrollando aplicaciones globalizadas, se aplican las siguientes restricciones:

* Traducción parcial: Parte del producto {{ site.data.keys.product }} v8.0, incluida su documentación, está traducida a los idiomas siguientes: Español, Alemán, Chino simplificado, Chino tradicional, Italiano, Japonés, Coreano, Portugués (Brasil) y Ruso. El texto visible por el usuario se traduce.
* Soporte bidireccional: Las aplicaciones que genera {{ site.data.keys.product }} no están habilitadas para ser plenamente bidireccionales. La duplicación de los elementos de la interfaz gráfica de usuario (GUI) y el control de la dirección del texto no se proporcionan de forma predeterminada. Sin embargo, no existe una dependencia rígida de las aplicaciones generadas en base a esta limitación. Los desarrolladores pueden lograr un cumplimiento bidireccional pleno realizando ajustes manuales en el código generado.

Aunque se proporciona conversión a hebreo para la funcionalidad principal de {{ site.data.keys.product }}, algunos elementos de la GUI no se invierten.

* Restricciones en los nombres de adaptador: Los nombres de los adaptadores deben ser válidos para poder crear un nombre de una clase Java. Además, deben estar formados únicamente por los siguientes caracteres:
    * Letras mayúsculas y minúsculas (A-Z y a-z)
    * Dígitos (0-9)
    * Guiones bajos (_)

* Caracteres Unicode: No se da soporte a los caracteres Unicode fuera el plano multilíngüe básico.
* Sensibilidad de idioma y formas de normalización Unicode: En los siguientes casos de uso, las consultas no consideran la sensibilidad de idioma (por ejemplo, la coincidencia normal, la insensibilidad a los acentos, la insensibilidad a mayúsculas y minúsculas, la correlación de 1 a 2 para que la función de búsqueda funcione correctamente en distintos idiomas y la búsqueda en datos en donde no se utiliza NFC (Normalization Form C)).
    * Desde {{ site.data.keys.mf_analytics_console }}, cuando crea un filtro personalizado para un diagrama personalizado. Sin embargo, en esta consola, la propiedad del mensaje utiliza NFC (Normalization Form C) y considera la sensibilidad de idioma.
    * Desde {{ site.data.keys.mf_console }}, al buscar una aplicación en la página Examinar aplicaciones, un adaptador en la página Examinar adaptadores, una etiqueta en la página Push o un dispositivo en la página Dispositivos.
    * En las funciones Buscar de la API JSONStore.

### {{ site.data.keys.mf_analytics }}
{: #mobilefirst-analytics }
{{ site.data.keys.mf_analytics }} tiene las siguientes limitaciones:

* No se da soporte a las analíticas de seguridad (datos sobre solicitudes que fallan comprobaciones de seguridad).
* En {{ site.data.keys.mf_analytics_console }}, el formato de los números no sigue las reglas ICU (International Components for Unicode).
* En {{ site.data.keys.mf_analytics_console }}, los números no utilizan el script de número preferido del usuario.
* En {{ site.data.keys.mf_analytics_console }}, el formato de las fechas, horas y números se visualiza en función del valor de idioma del sistema operativo y no del entorno local de Microsoft Internet Explorer.
* Al crear un filtro personalizado para un gráfico personalizado, los datos numéricos deben ser números romanos en base de 10, como, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9.
* Al crear una alerta en la página Gestión de alertas de {{ site.data.keys.mf_analytics_console }}, los datos numéricos deben ser datos numéricos occidentales en base de 10, es decir, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9.
* La página Analíticas de {{ site.data.keys.mf_console }} da soporte a los siguientes navegadores:
    * Microsoft Internet Explorer versión 10 o posterior
    * Mozilla Firefox ESR o posterior
    * Apple Safari en iOS versión 7.0 o posterior
    * La última versión de Google Chrome
* El SDK de cliente de Analytics no está disponible para Windows.


### Cliente móvil de {{ site.data.keys.mf_app_center_full }}
{: #ibm-mobilefirst-foundation-application-center-mobile-client }
El cliente móvil de Application Center cumple con las convenciones culturales del dispositivo en el que se ejecuta como, por ejemplo, el formato de fecha. Sin embargo, no siempre cumple con las reglas estrictas de ICU (International Components for Unicode).

### {{ site.data.keys.mf_console_full }}
{: #ibm-mobilefirst-operations-console }
{{ site.data.keys.mf_console }} tiene las siguientes limitaciones:

* Sólo proporciona soporte parcial a idiomas bidireccionales.
* La dirección del texto no se puede cambiar cuando los mensajes de notificación se envían a un dispositivo Android:
    * Si las primeras letras escritas lo son en un idioma de escritura de derecha a izquierda como, por ejemplo, el árabe o el hebreo, toda la dirección del texto se cambia automáticamente de derecha a izquierda.
    * Si las primeras letras escritas lo son en un idioma de escritura de izquierda a derecha, toda la dirección del texto se cambia automáticamente de izquierda a derecha.
* La secuencia de caracteres y la alineación del texto no coincide de acuerdo a los estándares habituales los idiomas bidireccionales.
* Los campos numéricos no analizan los valores numéricos de acuerdo a las reglas de formato del entorno local. La consola visualiza números con formato pero acepta como entrada únicamente números *sin formato*. Por ejemplo: 1000 y no 1 000 ni 1,000.
* Los tiempos de respuesta en la página de {{ site.data.keys.mf_console }} dependen de varios factores, como el hardware (RAM, CPU), la cantidad de datos de herramientas de analíticas acumuladas y la agrupación en clúster de {{ site.data.keys.mf_analytics }}. Debería probar la carga antes de integrar {{ site.data.keys.mf_analytics }} en producción.

### Herramienta de configuración del servidor
{: #server-configuration-tool }
La herramienta de configuración del servidor presenta las siguientes restricciones:

* El nombre descriptivo de una configuración de servidor sólo puede contener caracteres que estén en el conjunto de caracteres del sistema. En Windows, es el juego de caracteres ANSI.
* Las contraseñas que contienen comillas simples o comillas dobles es posible que no funcionen correctamente.
* La consola de la Herramienta de configuración del servidor tiene la misma limitación de globalización que la consola de Windows para mostrar series que están fuera de la página de códigos predeterminada.

Es posible que también experimente restricciones o anomalías en varios aspectos de la globalización a causa de las limitaciones de otros productos, tales como navegadores, sistemas de gestión de bases de datos o en kits de desarrollo de software en uso. Por ejemplo:

* Debe definir el nombre de usuario y la contraseña para Application Center únicamente con caracteres ASCII. Esta limitación existe porque WebSphere Application Server (Liberty Profile o versión completa) no da soporte a nombres de usuario y contraseñas no ASCII. Consulte Caracteres que son válidos para ID de usuario y contraseñas.
* En Windows:
    * Para ver los mensajes localizados en el archivo de registro que crea el servidor de pruebas debe abrir este archivo de registro con la codificación UTF8.
    * Estas limitaciones están presentes a dadas las causas siguientes:
        * El servidor de pruebas está instalado en un perfil de WebSphere Application Server, que crea un archivo de registro con la codificación ANSI excepto para sus mensajes localizados para los que utiliza la codificación UTF8.

* En Java 7.0 Service Refresh 4-FP2 y versiones anteriores no puede pegar en el campo de entrada caracteres Unicode que no forman parte del plano básico multilingüe. Para evitar este problema, cree la vía de acceso de la carpeta manualmente y elija esa carpeta durante la instalación.
* Los nombres de título y botón personalizados de los métodos de alerta, confirmación y solicitud deben ser cortos para evitar que se trunquen al margen de la pantalla.
* JSONStore no gestiona la normalización. Las funciones de Buscar para la API JSONStore no tienen en cuenta la sensibilidad de idioma, como por ejemplo los acentos, las mayúsculas y minúsculas y la correlación de 1 a 2.

### Adaptadores y dependencias de terceros
{: #adapters-and-third-party-dependencies }
Los siguientes problemas conocidos están relacionados con interacciones entre dependencias y clases en el servidor de aplicaciones, incluida la biblioteca compartida {{ site.data.keys.product_adj }}.

#### Apache HttpClient
{: #apache-httpclient }
{{ site.data.keys.product }} utiliza Apache HttpClient internamente. Si añade una instancia de Apache HttpClient como una dependencia para un adaptador Java, las siguientes API no funcionarán correctamente en el adaptador: `AdaptersAPI.executeAdapterRequest, AdaptersAPI.getResponseAsJSON` y `AdaptersAPI.createJavascriptAdapterRequest`. El motivo es que las API contienen tipos de Apache HttpClient en su firma. La solución alternativa es utilizar el Apache HttpClient interno y cambiar el ámbito de dependencia en **pom.xml**.

#### Biblioteca criptográfica Bouncy Castle
{: #bouncy-castle-cryptographic-library }
{{ site.data.keys.product }} utiliza el propio Bouncy Castle. Sería posible utilizar otra versión de Bouncy Castle en el adaptador, sin embargo, habría que verificar con cuidado las consecuencias de hacerlo: a veces el código Bouncy Castle de {{ site.data.keys.product_adj }} cumplimenta determinados campos Singleton estáticos de las clases del paquete `javax.security` que podrían impedir que la versión de Bouncy Castle dentro del adaptador utilizase características que se basan en dichos campos.

#### Implantación CXF de Apache en archivos JAR
{: #apache-cxf-implementaton-of-jar-files }
CXF se utiliza en la implementación JAX-RS de {{ site.data.keys.product_adj }}, lo que impide añadir archivos JAR de CXF de Apache a un adaptador.

### Cliente móvil de Application Center: problemas de renovación en Android 4.0.x
{: #application-center-mobile-client-refresh-issues-on-android-40x}
Se ha sabido que el componente WebView de Android 4.0.x tiene nuevos problemas. La actualización de dispositivos a Android 4.1.x debería proporcionar una experiencia de usuario mejorada.

Si crea el cliente de Application Center a partir de orígenes, inhabilitar la función de aceleración de hardware en el nivel de aplicación del manifiesto de Android debería mejorar la situación para Android 4.0.x. En tal caso, la aplicación debe crearse con Android SDK 11 o posterior.

### Application Center precisa MobileFirst Studio V7.1 para importar y compilar el cliente móvil de Application Center
{: #application-center-requires-mobilefirst-studio-v71-for-importing-and-building-the-application-center-mobile-client }
Para compilar el cliente móvil Application Center, necesita MobileFirst Studio V7.1. Descargue MobileFirst Studio desde la página de [Descargas]({{site.baseurl}}/downloads). Pulse el separador **Releases anteriores de MobileFirst Platform Foundation** para el enlace de descarga. Para obtener las instrucciones de instalación, consulte [Instalación de MobileFirst Studio en IBM  Knowledge Center para la versión 7.1](https://www.ibm.com/support/knowledgecenter/SSHS8R_7.1.0/com.ibm.worklight.installconfig.doc/devenv/t_installing_ibm_worklight_studi.html). Para obtener más información sobre cómo compilar el cliente móvil de Application Center, consulte [Preparaciones para utilizar el cliente móvil](../../../appcenter/preparations).

### Application Center y Microsoft Windows Phone 8.1
{: #application-center-and-microsoft-windows-phone-81 }
Application Center da soporte a la distribución de aplicaciones como archivos de paquete de aplicación (.xap) de Windows para Microsoft Windows Phone 8.0 y Microsoft Windows Phone 8.1. Con Microsoft Windows Phone 8.1, Microsoft presentó un nuevo formato universal de archivo de paquete de aplicación (.appx) para Windows Phone. Actualmente, Application Center no da soporte a la distribución de archivos de paquete de aplicación (.appx) para Microsoft Windows Phone 8.1 y únicamente lo hace para archivos de paquete de aplicación de Windows Phone (.xap).

Application Center únicamente da soporte a la distribución de archivos de paquete de aplicación (.appx) para Microsoft Windows Store (aplicaciones de escritorio).

### Administración de aplicaciones de {{ site.data.keys.product_adj }} a través de Ant o a través de la línea de mandatos
{: #administering-mobilefirst-applications-through-ant-or-through-the-command-line }
La herramienta **mfpadm** no está disponible si descargó e instaló únicamente {{ site.data.keys.mf_dev_kit_full }}. La herramienta mfpadm se instala con {{ site.data.keys.mf_server }} con el instalador.

### Clientes confidenciales
{: #confidential-clients }
Utilice únicamente caracteres ASCII para los valores de los secretos e ID de cliente confidencial.

### Direct Update
{: #direct-update }
No se da soporte a Direct Update en Windows en la versión V8.0.0.

### Limitaciones de características para FIPS 140-2
{: #fips-104-2-feature-limitations }
Los siguientes limitaciones conocidas se aplican cuando utiliza la característica FIPS 140-2 en {{ site.data.keys.product }}:
* Este modo de FIPS 140-2 validado se aplica únicamente a la protección (cifrado) de los datos locales que se almacena por la característica de JSONStore y la protección de comunicaciones HTTPS entre el cliente de {{ site.data.keys.product_adj }} y {{ site.data.keys.mf_server }}.
    * Para comunicaciones HTTPS, sólo las comunicaciones entre el cliente de {{ site.data.keys.product_adj }} y {{ site.data.keys.mf_server }} utilizan las bibliotecas de FIPS 140-2 en el cliente. Las conexiones directas con otros servidores o servicios no utilizan las bibliotecas de FIPS 140-2.
* Esta característica sólo está soportada en las plataformas iOS y Android.
    * En Android, esta característica sólo está soportada en dispositivos o simuladores que utilizan las arquitecturas x86 o armeabi. En cambio, no está soportada en Android que utiliza arquitecturas armv5 o armv6. Esto se debe a que la biblioteca OpenSSL utilizada no obtuvo la validación de FIPS 140-2 para armv5 o armv6 en Android. FIPS 140-2 no está soportado en la arquitectura de 64 bits, aunque la biblioteca de {{ site.data.keys.product_adj }} da soporte a la arquitectura de 64 bits. FIPS 140-2 únicamente se puede ejecutar en dispositivos de 64 bits si el proyecto incluye únicamente bibliotecas NDK nativas de 32 bits.
    * En iOS, está soportado en las arquitecturas i386, x86_64, armv7, armv7s y arm64.
* Esta característica únicamente funciona con aplicaciones híbridas (no con aplicaciones nativas).
* Para iOS nativo, FIPS está habilitado de forma predeterminada a través de las biblioteca iOS FIPS. No es necesario realizar acción alguna para habilitar FIPS 140-2.
* El uso de la característica de inscripción de usuario en el cliente no está soportado por la característica de FIPS 140-2.
* El cliente de Application Center no admite la característica de FIPS 140-2.

### Instalación de un fixpack o arreglo temporal en Application Center o {{ site.data.keys.mf_server }}
{: #installation-of-a-fix-pack-or-interim-fix-to-the-application-center-or-the-mobilefirst-server }
Cuando aplica un fixpack o un arreglo temporal a Application Center o {{ site.data.keys.mf_server }}, se requieren operaciones manuales y es posible que tenga que cerrar las aplicaciones durante algún tiempo.

### Arquitecturas soportadas por JSONStore
{: #jsonstore-supported-architectures }
Para Android, JSONStore da soporte a las siguientes arquitecturas: ARM, ARM v7 y x86 de 32 bits. Actualmente, no se admiten otras arquitecturas. Si intenta utilizar otras arquitecturas, podrían provocar excepciones y potenciales bloqueos de aplicaciones.

No se da soporte a JSONStore para aplicaciones nativas de Windows.

### Limitaciones del servidor Liberty
{: #liberty-server-limitations }
Si utiliza el servidor Liberty en un JDK 7 de 32 bits, es posible que Eclipse no se inicie y podría recibir el siguiente error:"Se ha producido un error durante la inicialización de VM. No se ha podido reservar suficiente espacio de almacenamiento dinámico para el objeto. Error: no se ha podido crear la máquina virtual Java. Error: Se ha producido una excepción grave. El programa se cerrará."

Para solucionar este problema, utilice el JDK de 64 bits con Eclipse de 64 bits y Windows de 64 bits. Si utiliza el JDK de 32 bits en una máquina de 64 bits, podría configurar las preferencias de la JVM en **mx512m** y **Xms216m**.

### Limitaciones de señales LTPA
{: #ltpa-token-limitations }
Se produce una excepción `SESN0008E` cuando la señal LTPA caduca antes de que caduque la sesión de usuario.

Una señal de LTPA está asociada a una sesión de usuario actual. Si la sesión caduca antes de que lo haga la señal LTPA, se creará una nueva sesión automáticamente. Sin embargo, cuando caduca una señal LTPA antes de que caduque la sesión de usuario, se produce una excepción:

`com.ibm.websphere.servlet.session.UnauthorizedSessionRequestException: SESN0008E: Un usuario autenticado como anónimo ha intentado acceder a una sesión propiedad de {nombre usuario}`

Para resolver esta limitación, debe forzar la finalización de la sesión de usuario cuando la señal LTPA caduque.
* En WebSphere Application Server Liberty, establezca el atributo httpSession invalidateOnUnauthorizedSessionRequestException en true en el archivo server.xml.
* En WebSphere Application Server, agregue la propiedad personalizada de gestión de sesiones InvalidateOnUnauthorizedSessionRequestException con el valor true para corregir el problema.

**Nota:** En determinadas versiones de WebSphere Application Server o WebSphere Application Server Liberty, la excepción estará registrada pero la sesión está invalidada correctamente. Para obtener más información, [consulte el APAR PM85141](http://www.ibm.com/support/docview.wss?uid=swg1PM85141).

### Microsoft Windows Phone 8
{: #microsoft-windows-phone-8 }
En entornos Windows Phone 8.1, no se da soporte a la arquitectura x64.

### Aplicaciones Microsoft Windows 10 UWP
{: #microsoft-windows-10-uwp-apps }
La característica de autenticidad de aplicación no funciona en aplicaciones {{ site.data.keys.product_adj }} Windows 10 UWP cuando el SDK de {{ site.data.keys.product_adj }} se instala a través del paquete NuGet. Como método alternativo, los desarrolladores pueden descargar el paquete de NuGet y añadir de forma manual las referencias del SDK de {{ site.data.keys.product_adj }}.

### Proyectos anidados pueden dar lugar a resultados impredecibles con la interfaz de línea de mandatos (CLI)
{: #nested-projects-can-result-in-unpredictable-results-with-the-cli }
No anide proyectos dentro de otro cuando utilice la {{ site.data.keys.mf_cli }}. De lo contrario, el proyecto sobre el que se actúa podría no ser el esperado.

### Vista previa de recursos web de Cordova con {{ site.data.keys.mf_mbs }}
{: #previewing-cordova-web-resources-with-the-mobile-browser-simulator }
Puede obtener una vista previa de recursos web con {{ site.data.keys.mf_mbs }}, sin embargo, el simulador no da soporte a todas las API de JavaScript de {{ site.data.keys.product_adj }}. En concreto, no se da soporte a la totalidad del protocolo OAuth. Sin embargo, se pueden probar llamadas a adaptadores con `WLResourceRequest`.

### El dispositivo físico de iOS es necesario para probar la autenticidad de la aplicación ampliada
{: #physical-ios-device-required-for-testing-extended-app-authenticity }
La prueba de la característica de autenticidad de aplicación ampliada precisa de un dispositivo iOS físico, puesto que en el simulador iOS no se puede instalar un IPA.

### Soporte de Oracle 12c por {{ site.data.keys.mf_server }}
{: #support-of-oracle-12c-by-mobilefirst-server }
Las herramientas del soporte de instalación de {{ site.data.keys.mf_server }} (Installation Manager, Herramienta de configuración del servidor y tareas Ant) con Oracle 12c como base de datos.

Las herramientas de instalación pueden crear los usuarios y las tablas, sin embargo, la base de datos, o las bases de datos, deben existir antes de ejecutar las herramientas de instalación.

### Soporte para notificaciones push
{: #support-for-push-notification }
Se da soporte a notificaciones push no seguras en Cordova (en iOS y Android).

### Actualización de la plataforma cordova-ios
{: #updating-cordova-ios-platform }
Para actualizar la plataforma cordova-ios de una aplicación Cordova, debe desinstalar y reinstalar la plataforma completando los siguientes pasos:

1. Navegue hasta el directorio del proyecto para la aplicación utilizando la interfaz de línea de mandatos.
2. Ejecute el mandato `cordova platform rm ios` para eliminar la plataforma.
3. Ejecute el mandato `cordova platform add ios@version` para añadir la nueva plataforma a la aplicación, donde versión es la versión de la plataforma iOS de Cordova.
4. Ejecute el mandato `cordova prepare` para integrar los cambios.

La actualización falla si utiliza el mandato `cordova platform update ios`.

### Aplicaciones Web
{: #web-applications }
Las aplicaciones web tienen las siguientes limitaciones:
- {: #web_app_limit_ms_ie_n_edge }
En Microsoft Internet Explorer (IE) y Microsoft Edge, los mensajes del SDK web de cliente y los mensajes administrativos de la aplicación se visualizan de acuerdo a la preferencia de formato regional del sistema operativo, y no de acuerdo a las preferencias del navegador o del idioma de visualización del sistema operativo configurado. Consulte también [Definición de mensajes de administrador en varios idiomas](../../../administering-apps/using-console/#defining-administrator-messages-in-multiple-languages).

### cordova-plugin-statusbar no funciona con aplicaciones Cordova cargadas con cordova-plugin-mfp.
{: #cordova-plugin-statusbar-does-not-work-with-cordova-application-loaded-with-cordova-plugin-mfp }
cordova-plugin-statusbar podría no funcionar correctamente con aplicaciones Cordova cargadas con cordova-plugin-mfp.

Para evitar este problema, el desarrollador tendrá que establecer `CDVViewController` como controlador de vista raíz. Sustituya el fragmento de código en el método `wlInitDidCompleteSuccessfully` tal como se sugiere más abajo en el archivo **MFPAppdelegate.m** del proyecto Cordova iOS.

Fragmento de código existente:

```objc
(void)wlInitDidCompleteSuccessfully
{
UIViewController* rootViewController = self.window.rootViewController; 
// Create a Cordova View Controller 
CDVViewController* cordovaViewController = [[CDVViewController alloc] init] ; 
cordovaViewController.startPage = [[WL sharedInstance] mainHtmlFilePath]; 
// Adjust the Cordova view controller view frame to match its parent view bounds 
cordovaViewController.view.frame = rootViewController.view.bounds; 
// Display the Cordova view [rootViewController addChildViewController:cordovaViewController]; 
[rootViewController.view addSubview:cordovaViewController.view]; 
[cordovaViewController didMoveToParentViewController:rootViewController]; 
}
```

Fragmento de código recomendado para solucionar la limitación:

```objc
(void)wlInitDidCompleteSuccessfully
{
 // Create a Cordova View Controller 
CDVViewController* cordovaViewController = [[CDVViewController alloc] init] ; 
cordovaViewController.startPage = [[WL sharedInstance] mainHtmlFilePath]; 
[self.window setRootViewController:cordovaViewController]; 
[self.window makeKeyAndVisible];
}
```

### No se da soporte a las direcciones raw IPv6 en aplicaciones Android
{: #raw-ipv6-address-not-supported-in-android-applications }
Durante la configuración de **mfpclient.properties** para su aplicación Android nativa, si su instancia de {{ site.data.keys.mf_server }} se encuentra en host con una dirección IPV6, utilice un nombre de host correlacionado para la dirección IPV6 para configurar la propiedad **wlServerHost** en **mfpclient.properties**. La configuración de la propiedad **wlServerHost** con una dirección raw IPv6 hace que falle el intento de la aplicación de conectarse a {{ site.data.keys.mf_server }}.

### No se recomienda modificar el comportamiento predeterminado de una aplicación Cordova
{:  #modifying_default_behaviour_of_a_cordova_app_is_not_recommended}
La modificación del comportamiento predeterminado de una aplicación Cordova (por ejemplo, cambiando el comportamiento del botón atrás) cuando se ha añadido {{ site.data.keys.product_adj }} Cordova SDK al proyecto, puede dar lugar a que Google Play Store la rechace cuando la envíe.
Para cualquier otra anomalía al enviar la aplicación a Google Play Store, puede ponerse en contacto con el soporte de Google.

>**Nota:** Si está utilizando la versión del release de MobileFirst 8.0 iFix de enero de 2018 o posterior, se recomienda que actualice tanto el servidor como el cliente a la misma versión. 

### Errores de acceso al instalar la CLI de MobileFirst utilizando Node 8
{:#mfpdev-cli-installation errors}
Al instalar la CLI de MobileFirst mediante npm, puede ver los errores siguientes en la salida del terminal.

```
> bufferutil@1.2.1 install /usr/local/lib/node_modules/mfpdev-cli/node_modules/bufferutil
> node-gyp rebuild

gyp ERR! clean error
gyp ERR! stack Error: EACCES: permission denied, rmdir 'build'
gyp ERR! System Darwin 18.0.0
gyp ERR! command "/usr/local/bin/node" "/usr/local/lib/node_modules/npm/node_modules/node-gyp/bin/node-gyp.js" "rebuild"
gyp ERR! cwd /usr/local/lib/node_modules/mfpdev-cli/node_modules/bufferutil
gyp ERR! node -v v8.12.0
gyp ERR! node-gyp -v v3.8.0
gyp ERR! not ok

> utf-8-validate@1.2.2 install /usr/local/lib/node_modules/mfpdev-cli/node_modules/utf-8-validate
> node-gyp rebuild

gyp ERR! clean error
gyp ERR! stack Error: EACCES: permission denied, rmdir 'build'
gyp ERR! System Darwin 18.0.0
gyp ERR! command "/usr/local/bin/node" "/usr/local/lib/node_modules/npm/node_modules/node-gyp/bin/node-gyp.js" "rebuild"
gyp ERR! cwd /usr/local/lib/node_modules/mfpdev-cli/node_modules/utf-8-validate
gyp ERR! node -v v8.12.0
gyp ERR! node-gyp -v v3.8.0
gyp ERR! not ok

> fsevents@1.2.4 install /usr/local/lib/node_modules/mfpdev-cli/node_modules/fsevents
> node install
```

Este error se debe a un [error conocido en node-gyp](https://github.com/nodejs/node-gyp/issues/1547). Estos errores se pueden omitir ya que no afectan al funcionamiento de la CLI de MobileFirst. Esto es aplicable para *mfpdev-cli iFix nivel 8.0.2018100112* y superior. Para evitar este error, utilice el distintivo `--no-optional` durante la instalación. Por ejemplo,

```bash
npm install -g mfpdev-cli --no-optional
```
