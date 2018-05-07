---
layout: tutorial
title: Distribución de aplicaciones móviles con IBM Application Center
breadcrumb_title: Distributing apps with Application Center
relevantTo: [ios,android,windows8,cordova]
show_in_nav: true
weight: 7
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
{{ site.data.keys.mf_app_center_full }} es un **repositorio de aplicaciones móviles** similar a los almacenes de aplicaciones públicas pero centrado en las necesidades de una organización o de un equipo. Es un almacén de aplicaciones privado.

Application Center facilita el uso compartido de aplicaciones móviles:

* Puede **compartir comentarios e información de valoración**.  
* Puede utilizar listas de control de acceso para limitar quién puede instalar aplicaciones.

Application Center funciona con aplicaciones {{ site.data.keys.product_adj }} y no {{ site.data.keys.product_adj }}, y da soporte a cualquier aplicación de **iOS, Android**, **BlackBerry 6/7** y **Windows/Phone 8.x**.

> **Nota:** Los archivos de archivado/IPA generados mediante Test Flight o iTunes Connect para el envío/validación del almacén de aplicaciones iOS, puede provocar un bloqueo/fallo del tiempo de ejecución. Lea el blog [Preparación de aplicaciones iOS para el envío de App Store en IBM MobileFirst Foundation 8.0](https://mobilefirstplatform.ibmcloud.com/blog/2016/10/17/prepare-ios-apps-for-app-store-submission/), para obtener más información.

Puede utilizar Application Center en contextos distintos. Por ejemplo:

* Como almacén de aplicaciones de empresa en una organización.
* Durante el desarrollo para distribuir aplicaciones en un equipo.

> **Nota:** para crear la aplicación iOS AppCenter Installer, se necesita MobileFirst 7.1.

#### Ir a:
{: #jump-to}
* [Instalación y configuración](#installing-and-configuring)
* [Cliente de IBM AppCenter basado en Cordova](#cordova-based-ibm-appcenter-client)
* [Preparación de clientes móviles](#preparing-mobile-clients)
* [Gestión de aplicaciones en la consola de Application Center](#managing-applications-in-the-application-center-console)
* [El cliente móvil de Application Center](#the-application-center-mobile-client)
* [Herramientas de línea de mandatos de Application Center](#application-center-command-line-tools)

## Instalación y configuración
{: #installing-and-configuring }
Application Center se instala como parte de la instalación de {{ site.data.keys.mf_server }} con IBM Installation Manager.

**Requisito previo:** Antes de instalar Application Center, debe haber instalado un servidor de aplicaciones y una base de datos:

* Servidor de aplicaciones: perfil completo de Tomcat o WebSphere Application Server o perfil de Liberty
* Base de datos: DB2 , Oracle, o MySQL

Si no tiene instalada una base de datos, el proceso de instalación también puede instalar una base de datos Apache Derby. Sin embargo, no se recomienda el uso de la base de datos Derby para escenarios de producción.

1. IBM Installation Manager le guía por la instalación de Application Center con opciones de base de datos y servidor de aplicaciones.

    > Para obtener más información, consulte el tema sobre [instalación de {{ site.data.keys.mf_server }}](../../installation-configuration).

    Dado que iOS 7.1 sólo admite el protocolo https, el servidor de Application Center debe estar protegido con SSL (al menos con TLS v.1) si tiene pensado distribuir aplicaciones para dispositivos que ejecutan iOS 7.1 o posterior. No se recomiendan los certificados autofirmados, pero se pueden utilizar para realizar pruebas, siempre que los certificados de autoridades emisoras de certificados autofirmados se distribuyan a los dispositivos.

2. Una vez que Application Center esté instalado con IBM Installation Manager, abra la consola: `http://localhost:9080/appcenterconsole`

3. Inicie sesión con esta combinación de usuario/contraseña: demo/demo

4. En este punto, puede configurar la autenticación de usuario. Por ejemplo, puede conectarse a un repositorio LDAP.

    > Para obtener más información, consulte el tema sobre [configuración del Application Center tras la instalación](../../installation-configuration/production/appcenter/#configuring-application-center-after-installation).

5. Prepare el cliente móvil para Android, iOS, BlackBerry 6/7 y Windows Phone 8

El cliente móvil es la aplicación móvil que utiliza para examinar el catálogo e instalar la aplicación.

> **Nota:** Para una instalación de producción, piense en instalar el Application Center ejecutando las tareas Ant proporcionadas: le permite desacoplar actualizaciones en el servidor desde actualizaciones al Application Center.

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

## Preparación de clientes móviles
{: #preparing-mobile-clients }
### Para teléfonos y tabletas Android
{: #for-android-phones-and-tablets }
El cliente móvil se entrega como una aplicación compilada (APK) y está ubicado en **install_dir/ApplicationCenter/installer/IBMApplicationCenter.apk**

> **Nota:** Consulte [Cliente de IBM AppCenter basado en Cordova](#cordova-based-ibm-appcenter-client), si está utilizando la infraestructura de Cordova para crear el cliente de Android e iOS AppCenter.

### Para iPad e iPhone
{: #for-ipad-and-iphone }
1. Compile y firme la aplicación cliente proporcionada en el código fuente. Es obligatorio.

2. En MobileFirst Studio, abra el IBMAppCenter Project en: **install\_dir/ApplicationCenter/installer**

3. Utilice **Ejecutar como → Ejecutar en MobileFirst Development Server** para crear el proyecto.

4. Utilice Xcode para crear y firmar la aplicación con su perfil de Apple iOS Enterprise.  
Puede abrir el proyecto nativo resultante (en **iphone\native**) manualmente en Xcode, o efectuar una pulsación con el botón derecho del ratón en la carpeta iPhone y seleccionar **Ejecutar como → Proyecto de Xcode**. Esta acción genera el proyecto y lo abre en Xcode.

> **Nota:** Consulte [Cliente de IBM AppCenter basado en Cordova](#cordova-based-ibm-appcenter-client), si está utilizando la infraestructura de Cordova para crear el cliente de Android e iOS AppCenter.

### Para Blackberry
{: #for-blackberry }
* Para crear la versión de BlackBerry, debe tener el BlackBerry Eclipse IDE (o Eclipse con el plug-in de BlackBerry Java) con la BlackBerry SDK 6.0. La aplicación también se ejecuta en BlackBerry OS 7 cuando se compila con BlackBerry SDK 6.0.

Se proporciona un proyecto de BlackBerry en: **install\_dir/ApplicationCenter/installer/IBMAppCenterBlackBerry6**

### Para Windows Phone 8
{: #for-windows-phone-8}
1.  Registre una cuenta de empresa con Microsoft.  
Application Center sólo gestiona aplicaciones de empresa firmadas con el certificado de la empresa que se proporciona con su cuenta de la empresa.

2. La versión de Windows Phone del cliente móvil se incluye en: **install\_dir/ApplicationCenter/installer/IBMApplicationCenterUnsigned.xap**

* Asegúrese de que el cliente móvil de Application Center también esté firmado con este certificado de la empresa.

* Para instalar aplicaciones de empresa en un dispositivo, en primer lugar inscriba el dispositivo con la empresa instalando una señal de inscripción de la empresa.

> Para obtener más información sobre las cuentas de la empresa y las señales de inscripción, consulte la página [Sitio web de Microsoft Developer → Distribución de aplicaciones de la empresa para Windows Phone](http://msdn.microsoft.com/library/windows/apps/jj206943(v=vs.105).aspx).

> Para obtener más información sobre cómo firmar las aplicaciones de clientes móviles de Windows Phone, consulte el [sitio web de Microsoft Developer](http://dev.windows.com/en-us/develop).

<br/>

> <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> **Importante:** **No** puede utilizar el archivo `.xap` no firmado directamente. Para poder instalarlo en un dispositivo, debe firmarlo en primer lugar con el certificado de la empresa, que se obtiene desde Symantec o Microsoft.

### Para aplicaciones de Windows Store para Windows 8.1 Pro
{: #for-windows-store-apps-for-windows-81-pro }
* El archivo **install\_dir/ApplicationCenter/installer/IBMApplicationCenterWindowsStore.zip** contiene el ejecutable del cliente de Application Center. Distribuya este archivo al sistema del cliente y descomprímalo. Contiene el programa ejecutable.

* La instalación de una aplicación de Windows Store (un archivo de tipo `appx`) sin el uso de Microsoft Windows Store se denomina <em>instalación de prueba</em> de una aplicación. Para realizar una instalación de prueba de una aplicación, debe cumplir con los requisitos previos de [Prepararse para realizar una instalación de prueba de aplicaciones](https://technet.microsoft.com/fr-fr/library/dn613842.aspx. The Windows 8.1.1 update simplifies the prerequisites for sideloading. For more information, see [Sideloading Store Apps to Windows 8.1.1 Devices]( http://blogs.msdn.com/b/micham/archive/2014/05/30/sideloading-store-apps-to-windows-8-1-devices.aspx).

## Gestión de aplicaciones en la consola de Application Center
{: #managing-applications-in-the-application-center-console }
![Imagen de gestión de aplicación en Application Center]({{ site.baseurl }}/assets/backup/overview1.png)

Utilice la consola del Application Center para gestionar aplicaciones en el catálogo de las formas siguientes:

* Añadir y eliminar aplicaciones
* Gestionar versiones de aplicaciones    
* Ver los detalles de una aplicación
* Restringir el acceso de una aplicación a usuarios o grupos de usuarios específicos
* Leer los comentarios para cada aplicación
* Revisar los usuarios y dispositivos registrados

### Adición de aplicaciones nuevas al almacén
{: #adding-new-applications-to-the-store }
![Imagen de adición de aplicaciones a Application Center]({{ site.baseurl }}/assets/backup/addAppFile_smaller.png)

Para añadir aplicaciones nuevas al Almacén:

1. Abra la consola del Application Center.
2. Pulse **Añadir aplicación**.
3. Seleccione un archivo de aplicación:
    * `.ipa`: iOS
    * `.apk`: Android
    * `.zip`: BlackBerry 6/7
    * `.xap`: Windows Phone 8.x
    * `.appx`: Windows Store 8.x

* Pulse **Siguiente**.

    En las vistas de Detalles de la aplicación, puede consultar la información sobre la aplicación nueva y especificar más información, como por ejemplo la descripción. Puede volver a esta vista más tarde para todas las aplicaciones del catálogo.

    ![Imagen de pantalla de detalles de aplicación]({{ site.baseurl }}/assets/backup/appDetails1.png)

* Pulse **Listo** para finalizar la tarea.

La aplicación nueva se añadirá al almacén.

![Imagen de control de acceso en Application Center]({{ site.baseurl }}/assets/backup/accessControlEnabled.png)


De forma predeterminada, una aplicación puede instalarla cualquier usuario autorizado del almacén.

### Restricción de acceso a un grupo de usuarios
{: #restricting-access-to-a-group-of-users }
Para restringir el acceso a un grupo de usuarios:

1. En la vista de catálogo, pulse el **enlace no restringido** que hay junto al nombre de aplicación. Se abrirá la página Instalación del control de accesos.
2. Seleccione **Control de accesos habilitado**. Ahora puede escribir la lista de usuarios o grupos autorizados para instalar la aplicación.
3. Si ha configurado LDAP, añada usuarios y grupos definidos en el repositorio LDAP.

También puede añadir aplicaciones desde los almacenes de aplicaciones públicos, como Google Play o Apple App Store, escribiendo sus URL.

## El cliente móvil de Application Center
{: #the-application-center-mobile-client }
El cliente móvil de App Center es una aplicación móvil para gestionar las aplicaciones en el dispositivo. Con el cliente móvil, podrá:

* Listar todas las aplicaciones desde el catálogo (para el que tiene derechos de acceso).
* Listar las aplicaciones favoritas.
* Instalar una aplicación o actualizar a una versión nueva.
* Proporcionar comentarios y puntuaciones de cinco estrellas para una aplicación.

### Adición de aplicaciones de cliente móvil al catálogo
{: #adding-mobile-client-applications-to-the-catalog }
Debe añadir aplicaciones del cliente móvil de Application Center al catálogo.

1. Abra la consola del Application Center.
2. Pulse el botón **Añadir aplicación** para añadir el archivo `.apk`, `.ipa`, `.zip`, o `.xap` del cliente móvil.
3. Pulse **Siguiente** para abrir la página Detalles de la aplicación.
4. En la página Detalles de la aplicación, seleccione **Instalador** para indicar que esta aplicación es un cliente móvil.
5. Pulse **Listo** para añadir la aplicación Application Center al catálogo.

El cliente de Application Center para Windows 8.1 Pro no necesita añadirse al catálogo. Este cliente es un programa normal `.exe` de Windows contenido en el archivo **install\_dir/ApplicationCenter/installer/IBMApplicationCenterWindowsStore.zip**. Puede simplemente copiarlo al sistema del cliente.

### Windows Phone 8
{: #windows-phone-8 }
En Windows Phone 8, también debe instalar la señal de inscripción que ha recibido con la cuenta de su empresa en la consola de Application Center, para que los usuarios puedan inscribirse a sus dispositivos. Utilice la página Configuración del Application Center, que puede abrir mediante el icono de engranaje.

![Imagen de inscripción de aplicación de Windows Phone 8 ]({{ site.baseurl }}/assets/backup/wp8Enrollment.png)

Para poder instalar el cliente móvil, debe inscribir el dispositivo con la empresa instalando la señal de inscripción:

1. Abra el navegador web en el dispositivo.
2. Escriba el URL: `http://hostname:9080/appcenterconsole/installers.html`
3. Escriba su nombre de usuario y contraseña.
4. Pulse **Señales** para abrir la lista de señales de inscripción.
5. Seleccione la empresa en la lista. Se mostrarán los detalles de la cuenta de la empresa.
6. Pulse **Añadir cuenta de la empresa**. El dispositivo está inscrito.

### Instalación del cliente móvil en el dispositivo móvil
{: #installing-the-mobile-client-on-the-mobile-device }
Para instalar el cliente móvil en el dispositivo móvil: ![Imagen del instalador de aplicaciones]({{ site.baseurl }}/assets/backup/installers_smaller.png)

1. Abra el navegador web en el dispositivo.
2. Escriba el URL: `http://hostname:9080/appcenterconsole/installers.html`
3. Escriba su nombre de usuario y contraseña.
4. Seleccione la aplicación Application Center para comenzar la instalación.

En los dispositivos **Android**, debe abrir la aplicación Android Download y seleccionar **IBM App Center** para la instalación.

### Registro en el cliente móvil
{: #logging-in-to-the-mobile-client }
Para iniciar sesión en el cliente móvil:

1. Escriba las credenciales para acceder al servidor.
2. Escriba el nombre de host o dirección IP del servidor.
3. En el campo **Puerto del servidor**, escriba el número de puerto si no es el predeterminado (`9080`).
4. En el campo **Contexto de aplicación**, escriba el contexto: `applicationcenter`.

![Pantalla de inicio de sesión]({{ site.baseurl }}/assets/backup/login.png)

### Vistas del cliente móvil de Application Center
{: #application-center-mobile-client-views }
* La vista **Catálogo** muestra la lista de aplicaciones disponibles.
* La selección de una aplicación abre la vista **Detalles** en la aplicación. Puede instalar aplicaciones desde la vista Detalles. También puede marcar aplicaciones como favoritas utilizando el icono de estrella de la Vista de detalles.

    ![Detalles de catálogo]({{ site.baseurl }}/assets/backup/catalog_details.001.jpg)

* La vista **Favoritos** lista las aplicaciones favoritas. Esta lista está disponible en todos los dispositivos de un usuario concreto.
* La vista **Actualizaciones** lista todas las actualizaciones disponibles. En la vista Actualizaciones, puede navegar a la vista Detalles. Puede seleccionar una versión más reciente de la aplicación o tomar la versión más reciente disponible. Si Application Center está configurado para enviar notificaciones push, es posible que se le notifique sobre las actualizaciones mediante mensajes de notificaciones push.

Desde el cliente móvil, puede valorar la aplicación y enviar una opinión. Las opiniones se visualizarán en la consola o en el dispositivo móvil.

![Revisiones]({{ site.baseurl }}/assets/backup/reviewss.png)

## Herramientas de línea de mandatos de Application Center
{: #application-center-command-line-tools }
El directorio **install_dir/ApplicationCenter/tools** contiene todos los archivos necesarios para utilizar la herramienta de línea de mandatos o las tareas Ant para gestionar las aplicaciones en el almacén:

* `applicationcenterdeploytool.jar`: la herramienta de línea de mandatos de carga.
* `json4jar`: la biblioteca para el formato JSON necesario por la herramienta de carga.
* `build.xml`: un script Ant de prueba que puede utilizar para cargar un archivo único o una secuencia de archivos en el Application Center.
* `acdeploytool.sh` y `acdeploytool.bat`: Scripts de ejemplo para invocar a Java con el archivo `applicationcenterdeploytool.jar`.

Por ejemplo, para desplegar un archivo `app.apk` de aplicación en el almacén en `localhost:9080/applicationcenter` con el ID de usuario `demo` y la contraseña `demo`, escriba:

```bash
Java com.ibm.appcenter.Upload -s http://localhost:9080 -c applicationcenter -u demo -p demo app.apk
```
