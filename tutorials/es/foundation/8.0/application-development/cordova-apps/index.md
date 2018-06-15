---
layout: tutorial
title: Desarrollo de MobileFirst Foundation en aplicaciones Cordova
breadcrumb_title: Cordova application development
relevantTo: [cordova]
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
De [http://cordova.apache.org/](http://cordova.apache.org/):

> Apache Cordova es una infraestructura de desarrollo móvil de código abierto.
Permite utilizar tecnologías web estándar como, por ejemplo, HTML5, CSS3 y JavaScript para un desarrollo entre varias plataformas, evitando el lenguaje de desarrollo nativo de cada plataforma móvil.
Las aplicaciones se ejecutan dentro de derivadores destinados a cada plataforma, y se basan en enlaces de API que siguen los estándares para acceder a los sensores de los dispositivos, a los datos y al estado de la red.



{{ site.data.keys.product_full }} proporciona un SDK en forma de varios plugins de Cordova.
Aprenda a [Añadir {{ site.data.keys.product }} SDK a aplicaciones Cordova](../../application-development/sdk/cordova).

> **Nota:** Los archivos de archivado/IPA generados mediante Test Flight o iTunes Connect para almacenar envíos/validación de aplicaciones iOS, podrían originar fallos/bloqueos en tiempo de ejecución. Consulte el blog [
Preparación de aplicaciones iOS para enviarlas a App Store en {{ site.data.keys.product_full }}](https://mobilefirstplatform.ibmcloud.com/blog/2016/10/17/prepare-ios-apps-for-app-store-submission/) para obtener más información.


#### Ir a:
{: #jump-to }

* [Desarrollo de aplicaciones Cordova](#cordova-application-development)
* API de [{{ site.data.keys.product_adj }}](#mobilefirst-apis)
* Flujo inicial del SDK de [{{ site.data.keys.product_adj }}](#mobilefirst-sdk-startup-flow)
* [Seguridad de aplicaciones Cordova](#cordova-application-security)
* [Recursos de aplicación de Cordova](#cordova-application-resources)
* [Vista previa de una recurso web de una aplicación](#previewing-an-applications-web-resources)
* [Implementación de código JavaScript](#implementing-javascript-code)
* [Soporte de CrossWalk para Android](#crosswalk-support-for-android)
* [Soporte de WKWebView para iOS](#wkwebview-support-for-ios)
* [Lectura adicional](#further-reading)
* [Guías de aprendizaje con las que continuar](#tutorials-to-follow-next)

## Desarrollo de aplicaciones Cordova
{: #cordova-application-development }
Las aplicaciones desarrolladas con Cordova se pueden mejorar mediante las siguientes características y métodos de desarrollo proporcionados para Cordova:


### Enganches
{: #hooks }
Los enganches de Cordova son scripts que proporcionan a los desarrolladores la posibilidad de personalizar mandatos de Cordova, permitiendo crear por ejemplo flujos de compilación personalizados.
  
Obtenga más información sobre los [Enganches de Cordova](http://cordova.apache.org/docs/en/dev/guide/appdev/hooks/index.html#Hooks%20Guide).


### Carpeta Merges
{: #merges }
La carpeta Merges proporciona la posibilidad de tener recursos web específicos de plataforma (archivos HTML, CSS y JavaScript).
Estos recursos web se despliegan durante el paso `cordova prepare` para el directorio nativo apropiado.
Los archivos colocados bajo la carpeta **merges/** remplazarán los archivos coincidentes en la carpeta **www/** de la plataforma pertinente.
Obtenga más información sobre la [Carpeta Merges](https://github.com/apache/cordova-cli#merges).


### Plugins de Cordova
{: #cordova-plug-ins }
La utilización de plugins de Cordova puede proporcionar mejoras como, por ejemplo, la adición de elementos de interfaz de usuario nativos (diálogos, barras de separadores, selectores, etc.) así como funcionalidades más avanzadas como, por ejemplo, la correlación y geoubicación, la carga de contenido externo, teclados personalizados o la integración de dispositivos (cámaras, contactos, sensores etc.).


Encontrará plugins de Cordova en [GitHub.com](https://github.com) y en otros sitios web populares de plugins de Cordova como, por ejemplo, [Plugreg](http://plugreg.com/) y [NPM](http://npmjs.org).

Plugins de ejemplo: 

- [cordova-plugin-dialogs](https://www.npmjs.com/package/cordova-plugin-dialogs)
- [cordova-plug-inprogress-indicator](https://www.npmjs.com/package/cordova-plugin-progress-indicator)
- [cordova-plugin-statusbar](https://www.npmjs.com/package/cordova-plugin-statusbar)

>**Nota:** La modificación del comportamiento predeterminado de una aplicación Cordova (por ejemplo, modificando el comportamiento del botón de ir hacia atrás) cuando {{ site.data.keys.product_adj }} Cordova SDK se añade al proyecto, puede hacer que Google Play Store la rechace cuando la envíe.

Póngase en contacto con el soporte de Google para conocer otras anomalías al enviar una aplicación a Google Play Store.



### Infraestructuras de terceros
{: #3rd-party-frameworks }
El desarrollo de aplicaciones de Cordova se puede mejorar aún más utilizando infraestructuras como, por ejemplo, [Ionic](http://ionicframework.com/), [AngularJS](https://angularjs.org/), [jQuery Mobile](http://jquerymobile.com/) o [Backbone](http://backbonejs.org/) entre muchas otras.


**Artículos de blogs sobre la integración**

* [Procedimientos recomendados para crear aplicaciones Angular JS con MobileFirst Foundation 8.0](https://mobilefirstplatform.ibmcloud.com/blog/2016/08/11/best-practices-for-building-angularjs-apps-with-mobilefirst-foundation-8.0/)
* [Integración de {{ site.data.keys.product }} en aplicaciones basadas en Ionic]({{site.baseurl}}/blog/2016/07/19/integrating-mobilefirst-foundation-8-in-ionic-based-apps/)
* [
Integración de {{ site.data.keys.product }} en aplicaciones basadas en Ionic 2]({{site.baseurl}}/blog/2016/10/17/integrating-mobilefirst-foundation-8-in-ionic2-based-apps/)

### Paquetes de terceros
{: #3rd-party-packages }
Las aplicaciones se pueden modificar utilizando paquetes de terceros para lograr requisitos como, por ejemplo, la minificación y la concatenación de recursos web de aplicaciones, entre otros.
Paquetes populares para ello son:


- [uglify-js](https://www.npmjs.com/package/uglify-js)
- [clean-css](https://www.npmjs.com/package/clean-css)

## API de {{ site.data.keys.product_adj }}
{: #mobilefirst-apis }
Después de [añadir {{ site.data.keys.product_adj }} Cordova SDK](../../application-development/sdk/cordova) a una aplicación Cordova, tendrá disponible el conjunto de {{ site.data.keys.product_adj }} de métodos de API para ser utilizados.


> Consulte la [Referencia de API](../../api) para obtener una lista completa de métodos de API disponibles.


## Flujo inicial del SDK de {{ site.data.keys.product_adj }}
{: #mobilefirst-sdk-startup-flow }
<div class="panel-group accordion" id="startup-flows" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="android-flow">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#android-flow" data-target="#collapse-android-flow" aria-expanded="false" aria-controls="collapse-android-flow"><b>Flujo inicial de Android</b></a>
            </h4>
        </div>

        <div id="collapse-android-flow" class="panel-collapse collapse" role="tabpanel" aria-labelledby="android-flow">
            <div class="panel-body">
                <p>En Android Studio, revise el proceso de inicio de la aplicación Cordova para Android con {{ site.data.keys.product_adj }}. El plugin Cordova de {{ site.data.keys.product_adj }} <b>cordova-plugin-mfp</b> tiene una secuencia de arranque asíncrona. Se debe completar la secuencia de arranque antes que la aplicación Cordova cargue el archivo html principal de la aplicación. </p>

                <p>La adición del plugin <b>cordova-plugin-mfp</b> a una aplicación Cordova instrumenta el archivo <b>AndroidManifest.xml</b> de la aplicación y el código nativo (que extiende <code>CordovaActivity</code>) del archivo <code>MainActivity</code> para realizar la inicialización de {{ site.data.keys.product_adj }}. </p>

                <p>La instrumentación de código nativo de la aplicación está formada por: </p>
                <ul>
                    <li>Adición de llamadas de API de <code>com.worklight.androidgap.api.WL</code> para realizar la inicialización de {{ site.data.keys.product_adj }}. </li>
                    <li>En el archivo <b>AndroidManifest.xml</b> la adición de
                        <ul>
                            <li>Una actividad denominada <code>MFPLoadUrlActivity</code> para permitir una inicialización de {{ site.data.keys.product_adj }} adecuada en el caso de que se haya instalado <b>cordova-plugin-crosswalk-webview</b>. </li>
                            <li>Un atributo personalizado <b>android:name="com.ibm.MFPApplication</b>" para el elemento <code>application</code> (consulte más abajo). </li>
                        </ul>
                    </li>
                </ul>

                <h3>Implementación de WLInitWebFrameworkListener y creación del objeto WL</h3>
                <p>El archivo <b>MainActivity.java</b> crea la clase <code>MainActivity</code> inicial extendiendo la clase <code>CordovaActivity</code>. <code>WLInitWebFrameworkListener</code> recibe notificaciones cuando se inicializa la infraestructura de {{ site.data.keys.product_adj }}. </p>

{% highlight java %}
public class MainActivity extends CordovaActivity implements WLInitWebFrameworkListener {
{% endhighlight %}

                <p>Se llama a la clase <code>MFPApplication</code> desde dentro de <code>onCreate</code> y crea una instancia de cliente de {{ site.data.keys.product_adj }} (<code>com.worklight.androidgap.api.WL</code>) que se utiliza a través de la aplicación.
El método <code>onCreate</code> inicializa la <b>infraestructura WebView</b>.</p>

{% highlight java %}
@Overridepublic void onCreate(Bundle savedInstanceState){
super.onCreate(savedInstanceState);

if (!((MFPApplication)this.getApplication()).hasCordovaSplashscreen()) {
           WL.getInstance().showSplashScreen(this);
       }
   init();
   WL.getInstance().initializeWebFramework(getApplicationContext(), this);
}
{% endhighlight %}

                <p>La clase <code>MFPApplication</code> tiene dos funciones: </p>
                <ul>
                    <li>Define el método <code>showSplashScreen</code> para cargar una pantalla inicial (si existe una). </li>
                    <li>Crea dos escuchas para habilitar las analíticas. Estos escuchas se pueden eliminar si no son necesarios. </li>
                </ul>

                <h3>Carga de WebView</h3>
                <p>El plugin <b>cordova-plugin-mfp</b> añade una actividad al archivo <b>AndroidManifest.xml</b> que se necesita para inicializar Crosswalks WebView:</p>

{% highlight xml %}
<activity android:name="com.ibm.MFPLoadUrlActivity" />
{% endhighlight %}

                <p>Esta actividad se utiliza para garantizar la inicialización asíncrona de Crosswalk WebView tal como se indica a continuación:</p>

                <p>Después de que se inicialice la infraestructura de {{ site.data.keys.product_adj }} y esté lista para ser cargada en WebView, <code>onInitWebFrameworkComplete</code> se conecta al URL si <code>WLInitWebFrameworkResult</code> finaliza de forma satisfactoria. </p>

{% highlight java %}
public void onInitWebFrameworkComplete(WLInitWebFrameworkResult result){
if (result.getStatusCode() == WLInitWebFrameworkResult.SUCCESS) {
super.loadUrl(WL.getInstance().getMainHtmlFilePath());
   } else {
      handleWebFrameworkInitFailure(result);
   }
}
{% endhighlight %}



                <br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#android-flow" data-target="#collapse-android-flow" aria-expanded="false" aria-controls="collapse-android-flow"><b>Sección de cierre</b></a>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="ios-flow">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#ios-flow" data-target="#collapse-ios-flow" aria-expanded="false" aria-controls="collapse-ios-flow"><b>Flujo de inicio de iOS</b></a>
            </h4>
        </div>

        <div id="collapse-ios-flow" class="panel-collapse collapse" role="tabpanel" aria-labelledby="ios-flow">
            <div class="panel-body">
                <p>La infraestructura de {{ site.data.keys.product_adj }} se inicializa en la plataforma iOS para visualizar una instancia de WebView en la aplicación Cordova con {{ site.data.keys.product_adj }}. </p>

                <b>AppDelegate.m</b>
                <p>El archivo <code>AppDelegate.m</code> se encuentra en la carpeta Classes. Inicializa la infraestructura de {{ site.data.keys.product_adj }} antes de que el controlador de vista cargue la instancia de WebView.</p>

                <p>El método <code>didFinishLaunchingWithOptions</code> inicializa la infraestructura: </p>

{% highlight objc %}
[[WL sharedInstance] initializeWebFrameworkWithDelegate:self];
{% endhighlight %}

                <p>Una vez que la inicialización finalice de forma satisfactoria, <code>wlInitWebFrameworkDidCompleteWithResult</code> comprueba que se haya cargado la infraestructura de {{ site.data.keys.product_adj }} y crea un <code>MainViewController</code> que se conecta a la página <b>index.html</b> predeterminada. </p>

                <p>Una vez que la aplicación Cordova de iOS está compilada en Xcode sin errores, puede continuar añadiendo característica para la plataforma nativa y WebView. </p>

                <br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#ios-flow" data-target="#collapse-ios-flow" aria-expanded="false" aria-controls="collapse-ios-flow"><b>Sección de cierre</b></a>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="windows-flow">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#windows-flow" data-target="#collapse-windows-flow" aria-expanded="false" aria-controls="collapse-windows-flow"><b>Flujo de inicio de Windows</b></a>
            </h4>
        </div>

        <div id="collapse-windows-flow" class="panel-collapse collapse" role="tabpanel" aria-labelledby="windows-flow">
            <div class="panel-body">
                <p>El plugin Cordova de {{ site.data.keys.product_adj }} <b>cordova-plugin-mfp</b> tiene una secuencia de arranque asíncrona. Se debe completar la secuencia de arranque antes que la aplicación Cordova cargue el archivo HTML principal de la aplicación. </p>

                <p>La adición del plugin <b>cordova-plugin-mfp</b> a una aplicación Cordova añade el archivo <b>index.html</b> al archivo <b>appxmanifest</b> de la aplicación. Esto amplía el código nativo <code>CordovaActivity</code> para realizar la inicialización de {{ site.data.keys.product_adj }}. </p>

                <br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#windows-flow" data-target="#collapse-windows-flow" aria-expanded="false" aria-controls="collapse-windows-flow"><b>Sección de cierre</b></a>
            </div>
        </div>
    </div>
</div>

## Seguridad de aplicaciones Cordova
{: #cordova-application-security }
{{ site.data.keys.product_full }} proporciona características de seguridad que ayudan a proteger las aplicaciones Cordova.


Una gran parte del contenido en una aplicación entra plataformas se modifica más fácilmente por una persona no autorizada que para una aplicación nativa.
Puesto que una gran parte del contenido común en una aplicación entre plataformas está en un formato legible, IBM MobileFirst Foundation proporciona características que proporcionan un mayor nivel de seguridad para sus aplicaciones Cordova entre plataformas.


> Obtenga más información sobre la [infraestructura de seguridad de {{ site.data.keys.product_adj }}](../../authentication-and-security)

Utilice las siguientes características para mejorar la seguridad en sus aplicaciones Cordova:

* [Cifrado de recursos web de sus paquetes Cordova](securing-apps/#encrypting-the-web-resources-of-your-cordova-packages)  
Cifra el contenido en la carpeta www de su aplicación Cordova y lo descifra cuando la aplicación se instala y ejecuta por primera vez.
Este cifrado hace que sea más difícil para alguien el ver o modificar el contenido en dicha carpeta mientras la aplicación está empaquetada.

* [Habilitación de la característica de suma de comprobación de recursos web](securing-apps/#enabling-the-web-resources-checksum-feature)  
 Asegura la integridad de la aplicación cuando esta se inicia al comparar el contenido con los resultados de la suma de comprobación de la línea base que se recopila la primera vez que se inicia la aplicación.
Esta prueba ayuda a impedir la modificación de una aplicación que ya está instalada.

* [Habilitación de FIPS 140-2](../../administering-apps/federal/#enabling-fips-140-2)  
Asegura que los algoritmos de cifrado que se utilizan para cifrar datos fijos y datos dinámicos satisfacen el estándar FIPS (Federal Information Processing Standards) 140-2.

* [Fijación de certificados](../../authentication-and-security/certificate-pinning)  
Ayuda a impedir ataques de intermediario asociando un host con su clave pública esperada.


## Recursos de aplicación de Cordova
{: #cordova-application-resources }
Determinados recursos son necesarios como parte de la aplicación Cordova.
En la mayoría de los casos, se generan en su nombre al crear su aplicación Cordova con sus herramientas preferidas de desarrollo de Cordova.
Si utiliza la plantilla de {{ site.data.keys.product }}, también se proporcionan iconos y pantallas iniciales.


Se puede habilitar una plantilla de proyecto que IBM proporciona para utilizar con proyectos de Cordova que se habilitan para utilizar las características de {{ site.data.keys.product_adj }}.
Si utiliza esta plantilla de {{ site.data.keys.product_adj }}, tendrá disponibles los siguientes recursos como un punto de partida.
Si no utiliza la plantilla de {{ site.data.keys.product_adj }}, se proporcionan todos los recursos excepto los iconos y las pantallas iniciales.
Añada la plantilla especificando la opción `--template` y la plantilla {{ site.data.keys.product_adj }} cuando inicialmente cree su proyecto de Cordova.


Si cambia los nombres de archivo y las vías de acceso predeterminadas de los recursos, también debe especificar dichos cambios en el archivo de configuración de Cordova (config.xml).
Además, en algunos casos, puede cambiar las vías de acceso y los nombres predeterminados con el mandato mfpdev app config.
Si puede cambiar los nombres y las vías de acceso con el mandato mfpdev app config, se indica en la sección sobre el recurso específico.


### Archivo de configuración de Cordova (config.xml)
{: #cordova-configuration-file-configxml }
El archivo de configuración de Cordova es un archivo XML necesario que contiene metadatos de aplicación y que se almacena en el directorio raíz de la aplicación.
El archivo se genera de forma automática al crear una aplicación Cordova.
Puede modificarla para añadir propiedades personalizadas mediante el mandato mfpdev app config.


### Archivo principal (index.html)
{: #main-file-indexhtml}
Este archivo principal es un archivo HTML5 que contiene el esqueleto de la aplicación.
Este archivo carga todos los recursos web (scripts y hojas de estilo) que se necesitan para definir los componentes generales de la aplicación y para el enganche a los sucesos de documento necesarios.
Encontrará este archivo en el directorio **su_nombre_de_proyecto/www**.
El nombre de este archivo se puede cambiar con el mandato `mfpdev app config`.


### Imagen en miniatura
{: #thumbnail-image }
La imagen en miniatura proporciona una identificación gráfica de la aplicación en {{ site.data.keys.mf_console }}.
Debe ser una imagen cuadrada, preferiblemente con un tamaño de 90 por 90 píxeles.
  
Se proporciona una imagen en miniatura predeterminada cuando se utiliza la plantilla.
La imagen predeterminada se puede modificar utilizando el mismo nombre de archivo con otra imagen.
El archivo thumbnail.png se encuentra en la carpeta **su_nombre_de_proyecto/www/img**.
El nombre de este archivo o su vía de acceso se puede cambiar con el mandato `mfpdev app config`.


### Imagen de bienvenida
{: #splash-image }
La imagen de bienvenida se visualiza cuando se está inicializando la aplicación.
Si utiliza la plantilla predeterminada de {{ site.data.keys.product_adj }}, se proporcionan imágenes de bienvenida.
Estas imágenes predeterminadas se almacenan en los directorios siguientes:


* iOS: <su nombre de proyecto>/res/screen/ios/
* Android: <su nombre de proyecto>/res/screen/android/
* Windows: <su nombre de proyecto>/res/screen/windows/

Se incluyen varias imágenes de bienvenida predeterminadas para las distintas visualizaciones y para iOS y Windows y para distintas versiones del sistema operativo.
Es posible sustituir la imagen predeterminada que la plantilla proporciona con su propia imagen de bienvenida, o se puede añadir una imagen si no utilizó la plantilla.
Cuando se utiliza la plantilla de {{ site.data.keys.product_adj }} para compilar su aplicación para la plataforma Android, se instala el plugin **cordova-plugin-splashscreen**.
Cuando se integra este plugin, se visualizan las imágenes de bienvenida que Cordova utiliza en lugar de las imágenes que {{ site.data.keys.product }} utiliza.
Las imágenes en la carpeta con el formato screen.png están en las imágenes de bienvenida estándar de Cordova.
Puede especificar las imágenes a visualizar cambiando los valores en el archivo **config.xml** de Cordova.


Si no utiliza la plantilla de {{ site.data.keys.product_adj }}, las imágenes de bienvenida predeterminadas que se visualizan son las que utiliza el plugin de {{ site.data.keys.product }}.
Los nombres de archivo de las imágenes de bienvenida de origen de {{ site.data.keys.product_adj }} predeterminadas están como **splash-string.9.png**.


> Para obtener más información sobre la utilización de sus propias pantallas iniciales, consulte [Adición de iconos y pantallas iniciales a las aplicaciones para Cordova](adding-images-and-icons).


### Iconos de aplicación
{: #application-icons }
Las imágenes predeterminadas para los iconos de aplicación se proporcionan con la plantilla.
Estas imágenes predeterminadas se almacenan en los directorios siguientes:


* iOS: <su nombre de proyecto>/res/icon/ios/
* Android: <su nombre de proyecto>/res/icon/android/
* Windows: <su nombre de proyecto>/res/icon/windows/

Puede sustituir la imagen predeterminada con su propia imagen.
Su imagen de aplicación personalizada debe coincidir con el tamaño de la imagen de aplicación predeterminada que sustituye, y debe utilizar el mismo nombre de archivo.
Se proporcionan varias imágenes predeterminadas, de acuerdo a distintas versiones de sistemas operativos y pantallas.


> Para obtener más información sobre la utilización de sus propias pantallas iniciales, consulte [Adición de iconos y pantallas iniciales a las aplicaciones para Cordova](adding-images-and-icons).


### Hojas de estilo
{: #stylesheets }
El código de la aplicación puede incluir archivos CSS para definir la vista de la aplicación.


Las hojas de estilo se encuentran en el directorio <su nombre de proyecto>/www/css y se copian a las siguientes carpetas específicas de cada plataforma:


* iOS: <su nombre de proyecto>/platforms/ios/www/css
* Android: <su nombre de proyecto>/platforms/android/assets/www/css
* Windows: <su nombre de proyecto>/platforms/windows/www/css

### Scripts
{: #scripts }
El código de la aplicación puede incluir archivos JavaScript que implementan distintas funciones de su aplicación como, por ejemplo, los componentes de interfaz de usuario interactivo, la lógica empresarial y la integración de las consultas en un segundo plano.


La plantilla proporciona el archivo JavaScript index.js y que se encuentra en la carpeta **su_nombre_proyecto/www/js**.
Este archivo se copia a las siguientes carpetas específicas de cada plataforma:

* iOS: <su nombre de proyecto>/platforms/ios/www/js
* Android: <su nombre de proyecto>/platforms/android/assets/www/js
* Windows: <su nombre de proyecto>/platforms/windows/assets/www/js

## Vista previa de una recurso web de una aplicación
{: #previewing-an-applications-web-resources }
Obtenga una vista previa de los recursos web de una aplicación Cordova en los emuladores de iOS, Android, Windows o en los dispositivos físicos.
En {{ site.data.keys.product }}, hay disponibles dos opciones de vista previa dinámica adicionales: la representación de {{ site.data.keys.mf_mbs_full }} y el Navegador simple.


> <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> **Restricción de seguridad: ** Puede obtener una vista previa de los recursos web, si embargo el simulador no da soporte a todas las API de JavaScript de {{ site.data.keys.product_adj }}.
En concreto, no hay un soporte completo al protocolo OAuth.
Sin embargo, puede probar las llamadas a adaptadores con `WLResourceRequest`.
En este caso,

>
> * Las comprobaciones de seguridad no se ejecutan en el lado del servidor y los retos de seguridad no se envían al cliente que se ejecuta en {{ site.data.keys.mf_mbs }}.
> * Si no utiliza {{ site.data.keys.mf_server }} en un entorno de desarrollo, registre un cliente confidencial que tenga el ámbito del adaptador en su lista de ámbitos permitidos.
Defina un cliente confidencial con {{ site.data.keys.mf_console }}, mediante el menú Tiempo de ejecución/Valores.
Para obtener más información sobre los clientes confidenciales, consulte [Clientes confidenciales](../../authentication-and-security/confidential-clients).

>
> **Nota:** {{ site.data.keys.mf_server }} en un entorno de desarrollo incluye un cliente confidencial "test" con un ámbito permitido ilimitado ("*").
De forma predeterminada la aplicación mfpdev utiliza este cliente confidencial.


#### Navegador simple
{: #simple-browser }
La vista previa del Navegador simple, los recursos web de la aplicación se representan en el navegador de escritorio sin que sean tratados como una aplicación móvil, permitiendo una depuración sencilla de tan solo recursos web.
  

#### {{ site.data.keys.mf_mbs }}
{: #mobile-browser-simulator }
{{ site.data.keys.mf_mbs }} es una aplicación web que permite probar aplicaciones Cordova  simulando características del dispositivo sin la necesidad de instalar la aplicación en un emulador o dispositivo físico.


**Navegadores soportados:**

* Firefox versión 38 y posterior
* Chrome 49 y posterior
* Safari 9 y posterior

### Vista previa
{: #previewing }
1. Desde una ventana de **línea de mandatos**, ejecute el mandato:


    ```bash
    mfpdev app preview
    ```

2. Seleccione una opción de vista previa: 

    ```bash
    ? Seleccione cómo obtener una vista previa de su aplicación: (Utilice las teclas de cursor)
      navegador: representación de navegador simple
      mbs: Mobile Browser Simulator
    ```
3. Seleccione una plataforma para la vista previa (únicamente se visualizará la plataforma añadida): 

    ```bash
    ❯◯ android
    ◯ ios
	```

> <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> **Consejo** Aprenda más sobre los distintos mandatos de interfaz de línea de mandatos en la guía de aprendizaje [Utilización de la interfaz de línea de mandatos (CLI) para gestionar artefactos de {{ site.data.keys.product_adj }} ](../using-mobilefirst-cli-to-manage-mobilefirst-artifacts/).

### Vista previa dinámica
{: #live-preview }
El código de la aplicación (HTML, CSS y JS) ahora se puede editar en tiempo real con una vista previa dinámica.
Después de realizar un cambio a un recurso, guarde el cambio y dicho cambio será reflejado de forma inmediata en el navegador.

### Recarga dinámica
{: #live-reload }
Para obtener un efecto similar al realizar una vista previa en dispositivos físicos o en simuladores/emuladores, añada el plugin **cordova-plugin-livereload**.
Para obtener las instrucciones de uso, [consulte la página de plugins de GitHub](https://github.com/omefire/cordova-plugin-livereload).

### Ejecución de la aplicación en un emulador o en un dispositivo físico
{: #running-the-application-on-emulator-or-on-a-physical-device }
Para emular la aplicación ejecute el mandato de interfaz de línea de mandatos (CLI) Cordova `cordova emulate ios|android|windows`.
Por ejemplo:

```bash
cordova emulate ios
```

Para ejecutar la aplicación en un dispositivo físico, conectado a la estación de trabajo de desarrollo ejecute el mandato de interfaz de línea de mandatos (CLI) Cordova `cordova run ios|android|windows`.
Por ejemplo:

```bash
cordova run ios
```

## Implementación de código JavaScript
{: #implementing-javascript-code }
La edición de los recursos WebView es más adecuada mediante un entorno de desarrollo integrado (IDE) que proporciona cumplimentación automática para JavaScript.

Xcode, Android Studio y Visual Studio proporcionan funcionalidades de edición completas para Objective C, Swift, C# y Java, sin embargo, pueden estar limitadas para dar soporte a la edición en JavaScript.
Para facilitar la edición de JavaScript, el proyecto de Cordova de {{ site.data.keys.product_adj }} contiene un archivo de definición para poder cumplimentar de forma automática elementos de API de {{ site.data.keys.product_adj }}.
Cada plugin Cordova de {{ site.data.keys.product_adj }} proporciona un archivo de configuración `d.ts` para cada archivo JavaScript de {{ site.data.keys.product_adj }}.
El nombre de archivo `d.ts` coincide con el correspondiente nombre de archivo JavaScript y se encuentra ubicado en la carpeta del plugin.
Por ejemplo, para el {{ site.data.keys.product_adj }} SDK principal el archivo se encuentra en: **[myapp]\plugins\cordova-plugin-mfp\typings\worklight.d.ts**.

Los archivos de configuración `d.ts` proporcionan funcionalidades para cumplimentar de forma automática en todos los IDE con soporte de TypeScript: [TypeScript Playground](http://www.typescriptlang.org/Playground/), [Visual Studio Code](http://www.microsoft.com/visualstudio/eng), [WebStorm](http://www.jetbrains.com/webstorm/), [WebEssentials](http://visualstudiogallery.msdn.microsoft.com/6ed4c78f-a23e-49ad-b5fd-369af0c2107f), [Eclipse](https://github.com/palantir/eclipse-typescript).

Los recursos (archivos HTML y JavaScript) para WebView se encuentran en la carpeta **[myapp]\www**.
Cuando un proyecto se compila con el mandato cordova build, o cuando se ejecuta el mandato cordova prepare, estos recursos se copian a la correspondiente carpeta **www** en la carpeta **[myapp]\platforms\ios\www**, **[myapp]\platforms\android\assets\www** o **[myapp]\platforms\windows\www**.

Cuando abre la carpeta de aplicación principal con uno de los anteriores IDE, se conserva el contexto.
El editor IDE estará ahora enlazado a los archivos `d.ts` relevantes y los elementos de API de {{ site.data.keys.product_adj }} se cumplimentarán de forma automática a medida que escribe.

## Soporte de CrossWalk para Android
{: #crosswalk-support-for-android }
Las aplicaciones Cordova para la plataforma Android tiene su instancia de WebView predeterminada con [CrossWalk WebView](https://crosswalk-project.org/).

Para añadirlo:

1. Desde una **línea de mandatos**, ejecute el mandato:

   ```bash
   cordova plugin add cordova-plugin-crosswalk-webview
   ```

   Este mandato añadirá CrossWalk WebView a la aplicación.
Internamente, {{ site.data.keys.product_adj }} Cordova SDK ajustará la actividad del proyecto Android para utilizarlo.

2. Compile el proyecto ejecutando el mandato:

   ```bash
   cordova build
   ```

## Soporte de WKWebView para iOS
{: #wkwebview-support-for-ios }
La instancia de UIWebView predeterminada utilizada en aplicaciones Cordova iOS se puede sustituir con [WKWebView de Apple](https://developer.apple.com/library/ios/documentation/WebKit/Reference/WKWebView_Ref/).
Para añadirlo, ejecute el siguiente mandato desde una ventana de línea de mandatos: `cordova plugin add cordova-plugin-wkwebview-engine`.

> Aprenda más sobre el [plugin Cordova WKWebView](https://github.com/apache/cordova-plugin-wkwebview-engine).

## Lectura adicional
{: #further-reading }
Aprenda más sobre Cordova:

- [Visión general](https://cordova.apache.org/docs/en/latest/guide/overview/index.html)
- [Procedimientos recomendados, realización de pruebas, depuración y consideraciones sobre Cordova](https://cordova.apache.org/docs/en/latest/guide/next/index.html#link-testing-on-a-simulator-vs-on-a-real-device)
- [Cómo empezar a desarrollar aplicaciones Cordova](https://cordova.apache.org/#getstarted)

## Guías de aprendizaje con las que continuar
{: #tutorials-to-follow-next }
Empiece [añadiendo el SDK de MobileFirst a su aplicación Cordova](../../application-development/sdk/cordova) y revise las características que {{ site.data.keys.product_adj }} proporciona en la sección de [Todas las guías de aprendizaje](../../all-tutorials/).
