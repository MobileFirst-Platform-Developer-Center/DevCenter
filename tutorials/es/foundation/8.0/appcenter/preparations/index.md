---
layout: tutorial
title: Preparaciones para utilizar el cliente móvil
breadcrumb_title: Preparaciones
relevantTo: [ios,android,windows,javascript]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
La aplicación Appcenter Installer se utiliza para instalar aplicaciones en dispositivos móviles. Puede generar esta aplicación utilizando los proyectos de Cordova, Visual Studio y MobileFirst Studio que se proporcionan, o utilizando directamente una versión preconfigurada del proyecto de MobileFirst Studio para Android, iOS o Windows 8 Universal. 

#### Ir a
{: #jump-to }
* [Requisitos previos](#prerequisites)
* [Cliente de IBM AppCenter basado en Cordova](#cordova-based-ibm-appcenter-client)
* [Cliente de IBM AppCenter basado en MobileFirst Studio](#mobilefirst-studio-based-ibm-appcenter-client)
* [Personalización de características (para expertos): Android, iOS, Windows Phone](#customizing-features-for-experts-android-ios-windows-phone)
* [Despliegue del cliente móvil en Application Center](#deploying-the-mobile-client)

## Requisitos previos
{: #prerequisites }
### Requisitos previos específicos del sistema operativo Android
{: #prerequisites-specific-to-the-android-operating-system }
La versión nativa de Android del cliente móvil está incluida en la entrega de software en la forma de un archivo de paquete de aplicaciones de Android (.apk). El archivo **IBMApplicationCenter.apk** se encuentra en el directorio **ApplicationCenter/installer**. Las notificaciones push están inhabilitadas. Si desea habilitar las notificaciones push, debe volver a crear el archivo .apk. Consulte [Notificaciones push de actualizaciones de aplicaciones](../push-notifications) para obtener más información sobre las notificaciones push del Application Center.

Para crear la versión de Android, debe tener la versión más reciente de las herramientas de desarrollo de Android.

### Requisitos previos específicos del sistema operativo Apple iOS
{: #prerequisites-specific-to-apple-ios-operating-system }
La versión nativa de iOS para iPad e iPhone no se entrega como una aplicación compilada. La aplicación debe estar creada desde el proyecto de {{ site.data.keys.product_full }} denominado **IBMAppCenter**. Este proyecto también se entrega como parte de la distribución en el directorio **ApplicationCenter/installer**.

Para crear la versión de iOS, debe tener el software apropiado de {{ site.data.keys.product_full }} y de Apple. La versión de {{ site.data.keys.mf_studio }} debe ser la misma que la versión de {{ site.data.keys.mf_server }} en la que se basa esta documentación. La versión de Apple Xcode es V6.1.

### Requisitos previos específicos del sistema operativo Microsoft Windows Phone
{: #prerequisites-specific-to-microsoft-windows-phone-operating-system }
La versión de Windows Phone del cliente móvil está incluida como un archivo de paquete de aplicaciones de Windows Phone (.xap) no firmado en la entrega de software. El archivo **IBMApplicationCenterUnsigned.xap** se encuentra en el directorio **ApplicationCenter/installer**.

> **Importante:** El archivo .xap no firmado no se puede utilizar directamente. Debe firmarlo con el certificado de la empresa que proporciona Symantec/Microsoft para poder instalarlo en un dispositivo.

Opcional: Si es necesario, también puede crear la versión de Windows Phone desde las fuentes. Por este motivo, debe tener la versión más reciente de Microsoft Visual Studio.

### Requisitos previos específicos del sistema operativo Microsoft Windows 8
{: #prerequisites-specific-to-microsoft-windows-8-operating-system }
La versión Windows 8 del cliente móvil está incluida como un archivo de archivado .zip. El archivo **IBMApplicationCenterWindowsStore.zip** contiene un archivo ejecutable (.exe) y sus archivos Dynamic-Link Library (.dll) dependientes. Para utilizar el contenido de este archivado, descargue el archivado a una ubicación en su unidad local y ejecute el archivo ejecutable.

Opcional: Si es necesario, también puede crear la versión de Windows 8 desde las fuentes. Por este motivo, debe tener la versión más reciente de Microsoft Visual Studio.

## Cliente de IBM AppCenter basado en Cordova
{: #cordova-based-ibm-appcenter-client }
El proyecto del cliente de AppCenter basado en Cordova está ubicado en el directorio `install` en: **install_dir/ApplicationCenter/installer/CordovaAppCenterClient**.

Este proyecto se basa solamente en la infraestructura de Cordova y, por lo tanto, no depende de las API de cliente/servidor de {{ site.data.keys.product }}.  
Puesto que esta es una app de Cordova estándar, tampoco hay ninguna dependencia en {{ site.data.keys.mf_studio }}. Esta app utiliza Dojo para la IU.

Siga los pasos siguientes para comenzar:

1. Instale Cordova.

```bash
npm install -g cordova@latest
```

2. Instale Android SDK y configure el `ANDROID_HOME`.  
3. Cree y ejecute este proyecto.

Crear todas las plataformas:

```bash
cordova build
```

Crear sólo Android:

```bash
cordova build android
```

Crear sólo iOS:

```bash
cordova build ios
```

### Personalización de la aplicación AppCenter Installer
{: #customizing-appcenter-installer-application }
Puede personalizar más la aplicación, como por ejemplo actualizar su interfaz de usuario para una empresa o necesidades específicas.

> **Nota:** Aunque puede personalizar libremente la IU de aplicaciones y el comportamiento, tales cambios no están en el acuerdo de soporte de IBM.

#### Android
{: #android }
* Abra Android Studio.
* Seleccione **Importar proyecto (Eclipse ADT, Gradle, etc.)**
* Seleccione la carpeta de Android desde **install_dir/ApplicationCenter/installer/CordovaAppCenterClient/platforms/android**.

Esta acción puede tardar algún tiempo. Una vez que se haya hecho, ya podrá personalizar.

> **Nota:** Seleccione omitir la opción de actualización en la ventana emergente, para actualizar la versión de Gradle. Consulte `grade-wrapper.properties` para la versión.

#### iOS
{: #ios }
* Vaya a **install_dir/ApplicationCenter/installer/CordovaAppCenterClient/platforms**.
* Pulse para abrir el archivo **IBMAppCenterClient.xcodeproj**. El proyecto se abrirá en Xcode y podrá personalizar.

## Cliente de IBM AppCenter basado en MobileFirst Studio
{: #mobilefirst-studio-based-ibm-appcenter-client }
En lugar de utilizar el proyecto de Cordova para iOS y Android, también puede elegir utilizar el release anterior de la aplicación cliente de App Center, que se basa en MobileFirst Studio 7.1 y que da soporte a iOS, Android y Windows Phone.

### Importación y creación del proyecto (Android, iOS, Windows Phone)
{: #importing-and-building-the-project-android-ios-windows-phone }
Debe importar el proyecto **IBMAppCenter** en {{ site.data.keys.mf_studio }} y, a continuación, crear el proyecto.

> **Nota:** Para V8.0.0, utilice MobileFirst Studio 7.1. Puede descargar MobileFirst Studio desde la [página de Descargas]({{site.baseurl}}/downloads). Para obtener las instrucciones de instalación, consulte [Instalación de MobileFirst Studio](https://www.ibm.com/support/knowledgecenter/SSHS8R_7.1.0/com.ibm.worklight.installconfig.doc/devenv/t_installing_ibm_worklight_studi.html) en el IBM Knowledge Center for 7.1.

1. Seleccione **Archivo → Importar**.
2. Seleccione **General → Proyecto existente en el espacio de trabajo**.
3. En la página siguiente, seleccione **Seleccionar directorio raíz** y localice la raíz del proyecto **IBMAppCenter**.
4. Seleccione el proyecto **IBMAppCenter**.
5. Seleccione **Copiar proyectos en espacio de trabajo**. Esta selección crea una copia del proyecto en su espacio de trabajo. En sistemas UNIX, el proyecto IBMAppCenter es de sólo lectura en la ubicación original. La copia de proyectos en el espacio de trabajo evita problemas con los permisos de archivos.
6. Pulse **Finalizar** para importar el proyecto **IBMAppCenter** en MobileFirst Studio.

Cree el proyecto **IBMAppCenter**. El proyecto MobileFirst contiene una única aplicación denominada **AppCenter**. Pulse con el botón derecho del ratón la aplicación y seleccione **Ejecutar como → Crear todos los entornos**.

#### Android
{: #android }
MobileFirst Studio genera un proyecto nativo de Android en **IBMAppCenter/apps/AppCenter/android/native**. Hay un proyecto nativo de las herramientas de desarrollo de Android (ADT) en la carpeta android/native. Puede compilar y firmar este proyecto mediante las herramientas de ADT. Este proyecto requiere que se instale Android SDK nivel 16, por lo que el APK resultante es compatible con todas las versiones de Android 2.3 y posteriores. Si selecciona un nivel superior del Android SDK al crear el proyecto, el APK resultante no será compatible con Android versión 2.3.

Consulte el [Sitio Android para desarrolladores](https://developer.android.com/index.html) para obtener información de Android más específica que afecte a la aplicación del cliente móvil.

Si desea habilitar las notificaciones push para actualizaciones de aplicaciones, debe configurar en primer lugar las propiedades del cliente de Application Center. Consulte [Configuración de notificaciones push para las actualizaciones de aplicaciones para obtener más información](../push-notifications).

#### iOS
{: #ios }
MobileFirst Studio genera un proyecto nativo de iOS en **IBMAppCenter/apps/AppCenter/iphone/native**. El archivo **IBMAppCenterAppCenterIphone.xcodeproj** se encuentra en la carpeta iphone/native. Este archivo es el proyecto de Xcode que debe compilar y firmar con Xcode.

Consulte [El sitio de desarrolladores de Apple](https://developer.apple.com/) para obtener más información sobre cómo firmar la aplicación del cliente móvil de iOS. Para firmar una aplicación iOS, debe cambiar el Identificador de paquete de la aplicación a un identificador de paquete que se pueda utilizar con el perfil de suministro que utilice. El valor está definido en la configuración del proyecto de Xcode como **com.your\_internet\_domain\_name.appcenter**, donde **your\_internet\_domain\_name** es el nombre del dominio de Internet.

Si desea habilitar las notificaciones push para actualizaciones de aplicaciones, debe configurar en primer lugar las propiedades del cliente de Application Center. Consulte [Configuración de notificaciones push para las actualizaciones de aplicaciones para obtener más información](../push-notifications).

#### Windows Phone 8
{: #windows-phone-8 }
MobileFirst Studio genera un proyecto nativo de Windows Phone 8 en **IBMAppCenter/apps/AppCenter/windowsphone8/native**. El archivo **AppCenter.csproj** se encuentra en la carpeta windowsphone8/native. Este archivo es el proyecto de Visual Studio que debe compilar mediante Visual Studio y el SDK de Windows Phone 8.0.

La aplicación se ha creado con el [Windows Phone 8.0 SDK](https://www.microsoft.com/en-in/download/details.aspx?id=35471), por lo que se puede ejecutar en dispositivos Windows Phone 8.0 y 8.1. No se crea con el SDK de Windows Phone 8.1, dado que el resultado no se ejecutaría en dispositivos anteriores a Windows Phone 8.0.

La instalación de Visual Studio 2013 le permite seleccionar la instalación del SDK de Windows Phone 8.0 además del SDK de 8.1. El SDK de Windows Phone 8.0 también está disponible desde [Archivadores de SDK de Windows Phone](https://developer.microsoft.com/en-us/windows/downloads/sdk-archive).

Consulte [Windows Phone Dev Center](https://developer.microsoft.com/en-us) para obtener más información sobre cómo crear y firmar la aplicación del cliente móvil de Windows Phone.

#### Microsoft Windows 8: Creación del proyecto
{: #microsoft-windows-8-building-the-project }
El proyecto de Windows 8 Universal se proporciona como un proyecto de Visual Studio ubicado en **IBMApplicationCenterWindowsStore\AppCenterClientWindowsStore.csproj.**  
Debe crear el proyecto del cliente en Microsoft Visual Studio 2013 para poder distribuirlo.

La creación del proyecto es un requisito previo para distribuirlo a sus usuarios, pero la aplicación de Windows 8 no está pensada para desplegarse en Application Center para su posterior distribución.

Para crear el proyecto de Windows 8:

1. Abra el archivo de proyecto de Visual Studio denominado **IBMApplicationCenterWindowsStore\AppCenterClientWindowsStore.csproj** en Microsoft Visual Studio 2013.
2. Realice una creación completa de la aplicación.

Para distribuir el cliente móvil a los usuarios de Application Center, puede generar posteriormente un instalador que instalará el archivo ejecutable generado (.exe) y sus archivos Dynamic-Link Library (.dll) dependientes. Alternativamente, puede proporcionar estos archivos sin incluirlos en un instalador.

####  Cliente Microsoft Windows 10 Universal (Nativo) IBM AppCenter
{: #microsoft-windows-10-universal-(native)-ibm-appcenter-client}

El cliente Windows 10 Universal IBM AppCenter nativo sirve para instalar aplicaciones Windows 10 Universal en teléfonos Windows 10.
Utilice **IBMApplicationCenterWindowsStore** para instalar aplicaciones Windows 10 en el escritorio de Windows. 

#### Microsoft Windows 10 Universal: Creación del proyecto
{: #microsoft-windows-10-universal-building-the-project}

El proyecto de Windows 10 Universal se proporciona como un proyecto de Visual Studio ubicado en **IBMAppCenterUWP\IBMAppCenterUWP.csproj**.             
Debe crear el proyecto del cliente en Microsoft Visual Studio 2015 para poder distribuirlo.
>La compilación del proyecto es un requisito previo antes de poder distribuirlo a sus usuarios.

Siga estos pasos para compilar el proyecto de Windows 10 Universal:

1.  Abra el archivo de proyecto de Visual Studio denominado **IBMAppCenterUWP\IBMAppCenterUWP.csproj** en Visual Studio 2015.
+ Realice una creación completa de la aplicación.
+ Genere el archivo **.appx** siguiente el siguiente paso:

  * Pulse con el botón derecho sobre el proyecto y seleccione **Tienda → Crear paquetes de aplicación**.

## Personalización de características (para expertos): Android, iOS, Windows Phone)
{: #customizing-features-for-experts-android-ios-windows-phone }
Puede personalizar características editando un archivo de propiedades central y manipulando algunos otros recursos.
>Esta función sólo está soportada en Android, iOS, Windows 8 (solo paquetes de Windows Store) o Windows Phone 8.


Para personalizar características: varias características están controladas por un archivo de propiedades central denominado **config.json** en el directorio **IBMAppCenter/apps/AppCenter/common/js/appcenter/** o **ApplicationCenter/installer/CordovaAppCenterClient/www/js/appcenter**. Si desea modificar el comportamiento predeterminado de la aplicación, puede adaptar este archivo de propiedades para crear el proyecto.

Este archivo contiene las propiedades que se muestran en la tabla siguiente.

| Propiedad | Descripción |
|----------|-------------|
| url | La dirección codificada del servidor de Application Center. Si se establece esta propiedad, no se mostrarán los campos de direcciones de la vista Inicio de sesión.  |
| defaultPort | Si la propiedad url es null, esta propiedad prerrellena el campo port de la vista Inicio de sesión de un teléfono. Este es un valor predeterminado; el usuario puede editar el campo.  |
| defaultContext | Si la propiedad url es null, esta propiedad prerrellena el campo context de la vista Inicio de sesión de un teléfono. Este es un valor predeterminado; el usuario puede editar el campo.  |
| ssl | El valor predeterminado del conmutador de SSL de la vista Inicio de sesión. |
| allowDowngrade | Esta propiedad indica si la instalación de versiones anteriores está autorizada o no; sólo se puede instalar una versión anterior si el sistema operativo y la versión permiten la degradación. |
| showPreviousVersions | Esta propiedad indica si el usuario del dispositivo puede mostrar los detalles de todas las versiones de las aplicaciones o sólo los detalles de la versión más reciente. |
| showInternalVersion | Esta propiedad indica si la versión interna se muestra o no. Si el valor es false, la versión interna sólo se mostrará si no se ha establecido ninguna versión comercial. |
| listItemRenderer | Esta propiedad puede tener uno de estos valores:<br/>- **full**: el valor predeterminado; las listas de aplicaciones muestran el nombre de aplicación, la valoración y la versión más reciente. <br/>- **simple**: la aplicación lista sólo el nombre de aplicación.  |
| listAverageRating | Esta propiedad puede tener uno de estos valores:<br/>-  **latestVersion**: las listas de aplicaciones muestran la valoración media de la versión más reciente de la aplicación. <br/>-  **allVersions**: las listas de aplicaciones muestran la valoración media de todas las versiones de la aplicación.  |
| requestTimeout | Esta propiedad indica el tiempo de espera en milisegundos para solicitudes en el servidor de Application Center. |
| gcmProjectId | El ID de proyecto de la API de Google (nombre de proyecto = com.ibm.appcenter), necesario para las notificaciones push de Android; por ejemplo, 123456789012. |
| allowAppLinkReview | Esta propiedad indica si las opiniones locales de aplicaciones desde almacenes de aplicaciones externos se pueden registrar y examinar en el Application Center. Estas opiniones locales no serán visibles en el almacén de aplicaciones externo. Estas opiniones se almacenarán en el servidor de Application Center. |

### Otros recursos
{: #other-resources }
Otros recursos disponibles son iconos de aplicaciones, nombre de aplicación, imágenes de pantalla inicial, iconos y recursos traducibles de la aplicación.

#### Iconos de aplicación
{: #application-icons }
* **Android:** El archivo denominado **icon.png** en los directorios **/res/drawabledensity** del proyecto de Android Studio; hay un directorio para cada densidad.
* **iOS:** Los archivos denominados **iconsize.png** en el directorio **Recursos** del proyecto de Xcode.
* **Windows Phone:** Los archivos denominados **ApplicationIcon.png**, **IconicTileSmallIcon.png**, e **IconicTileMediumIcon.png** en el directorio **native** de la carpeta del entorno de MobileFirst Studio para Windows Phone.
* **Windows 10 Universal:** Archivos denominados **Square\*Logo\*.png**, **StoreLogo.png** y **Wide\*Logo\*.png** en el directorio **IBMAppCenterUWP/Assets** en Visual Studio.


#### Nombre de aplicación
{: #application-name }
* **Android:** Edite la propiedad **app_name** en el archivo **res/values/strings.xml** del proyecto de Android Studio.
* **iOS:** Edite la clave **CFBundleDisplayName** en el archivo **IBMAppCenterAppCenterIphone-Info.plist** del proyecto de Xcode.
* **Windows Phone:** Edite el atributo **Título** de la entrada de App en el archivo **Properties/WMAppManifest.xml** de Visual Studio.
* **Windows 10 Universal:** Edite el atributo **Title** de la entrada App en el archivo **IBMAppCenterUWP/Package.appxmanifest** de Visual Studio. 


#### Imágenes de la pantalla inicial
{: #splash-screen-images }
* **Android:** Edite el archivo denominado **splashimage.9.png** en los directorios **res/drawable/density** del proyecto de Android Studio; hay un directorio para cada densidad. Este archivo es una imagen de parche 9.
* **iOS:** Los archivos denominados **Default-size.png** en el directorio **Recursos** del proyecto de Xcode.
* Pantalla inicial de los proyectos basados en Cordova/MobileFirst Studio durante el inicio de sesión automático: **js/idx/mobile/themes/common/idx/Launch.css**
* **Windows Phone:** Edite el archivo denominado **SplashScreenImage.png** en el directorio **native** de la carpeta del entorno de MobileFirst Studio para Windows Phone.
* **Windows 10 Universal:** Edite los archivos denominados **SplashScreen*.png** en el directorio **IBMAppCenterUWP/Assets** en Visual Studio.

#### Iconos (botones, estrellas y objetos similares) de la aplicación
{: #icons }
**IBMAppCenter/apps/AppCenter/common/css/images**.

#### Recursos traducibles de la aplicación
{: #translatable-resources }
**IBMAppCenter/apps/AppCenter/common/js/appcenter/nls/common.js**.

## Despliegue del cliente móvil en Application Center
{: #deploying-the-mobile-client }
Despliegue las distintas versiones de la aplicación cliente en Application Center.

El cliente móvil de Windows 8 no está pensado para desplegarse en Application Center para su posterior distribución. Puede elegir distribuir el cliente móvil de Windows 8 proporcionando a los usuarios el archivo ejecutable .exe del cliente y los archivos .dll de la biblioteca de enlaces dinámicos directamente empaquetados en un archivado, o creando un instalador ejecutable para el cliente móvil de Windows 8.

Las versiones de Android, iOS, Windows Phone y Windows 10 Universal (Phone) del cliente móvil deben estar desplegadas en el Application Center. Para ello, debe cargar los archivos del paquete de aplicaciones de Android (.apk), los archivos de la aplicación de iOS (.ipa), los archivos de la aplicación de Windows Phone (.xap), los archivos de Windows 10 Universal (.appx) o los archivos del archivador del directorio web (.zip) en el Application Center. 

Siga los pasos descritos en [Cómo añadir aplicaciones móviles](../appcenter-console/#adding-a-mobile-application) para añadir la aplicación del cliente móvil para Android, iOS, Windows Phone y Windows 10 Universal. Asegúrese de seleccionar la propiedad de aplicación del Instalador para indicar que la aplicación es un instalador. La selección de esta propiedad permite a los usuarios de dispositivos móviles instalar la aplicación del cliente móvil fácilmente a través de Internet. Para instalar el cliente móvil, consulte la tarea relacionada que se corresponde con la versión de la aplicación del cliente móvil determinada por el sistema operativo.
