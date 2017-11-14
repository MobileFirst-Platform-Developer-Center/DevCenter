---
layout: tutorial
title: Notificaciones push de actualizaciones de aplicaciones
breadcrumb_title: Notificaciones push
relevantTo: [ios,android,windows,javascript]
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
Puede configurar el cliente de Application Center para que las notificaciones push se envíen a los usuarios cuando haya disponible una actualización para una aplicación en el almacenamiento.

El administrador del Application Center utiliza notificaciones push para enviar la notificación automáticamente, a cualquier dispositivo iOS o Android. Las notificaciones se envían para actualizaciones a las aplicaciones favoritas y de aplicaciones nuevas que se despliegan en el servidor de Application Center y que están marcadas como recomendadas.

### Proceso de notificación push
{: #push-notification-process }
Las notificaciones push se envían a un dispositivo si se cumplen las siguientes condiciones:

* El dispositivo tiene Application Center instalado y se ha iniciado al menos una vez.
* El usuario no ha inhabilitado la notificación push para este dispositivo para el Application Center en la interfaz **Configuración → Notificaciones**.
* Se permite al usuario instalar la aplicación. Tales permisos se controlan mediante los derechos de acceso del Application Center.
* La aplicación se marca como recomendada, o se marca como preferida para el usuario que está utilizando Application Center en este dispositivo. Estos distintivos se establecen automáticamente cuando el usuario instala una aplicación mediante Application Center. Puede ver qué aplicaciones están marcadas como preferidas mirando el separador **Favoritos** del Application Center en el dispositivo.
* La aplicación no está instalada en el dispositivo o hay una versión más reciente disponible que la versión instalada en el dispositivo.

La primera vez que se inicia el cliente de Application Center en un dispositivo, se puede preguntar al usuario si acepta notificaciones push entrantes. Este es el caso para dispositivos móviles iOS. La característica de la notificación push no funciona cuando el servicio está inhabilitado en el dispositivo móvil.

iOS y versiones del sistema operativo Android modernas ofrecen una forma de encender o apagar este servicio según la aplicación.

Consulte al proveedor del dispositivo para obtener más información sobre cómo configurar el dispositivo móvil para notificaciones push.

#### Ir a
{: #jump-to }
* [Configuración de notificaciones push para las actualizaciones de aplicaciones](#configuring-push-notifications)
* [Configuración del servidor de Application Center para la conexión a Google Cloud Messaging](#gcm)
* [Configuración del servidor de Application Center para la conexión a Apple Push Notification Services](#apns)
* [Creación de una versión del cliente móvil que no dependa de la API de GCM](#no-gcm)

## Configuración de las notificaciones push para actualizaciones de aplicaciones
{: #configuring-push-notifications }
Debe configurar las credenciales o certificados de los servicios de Application Center para poder comunicarse con servidores de notificaciones push de terceros.

### Configuración del planificador del servidor del Application Center
{: #configuring-the-server-scheduler }
El planificador del servidor es un servicio en segundo plano que se inicia y se detiene automáticamente con el servidor. Este planificador se utiliza para vaciar a intervalos periódicos una pila que se rellena automáticamente mediante las acciones del administrador con mensajes de actualizaciones push que se enviarán. El intervalo predeterminado entre el envío de dos lotes de mensajes de actualizaciones push es de doce horas. Si este valor predeterminado no se ajusta a usted, puede modificarlo utilizando las variables de entorno de servidor **ibm.appcenter.push.schedule.period.amount** e **ibm.appcenter.push.schedule.period.unit**.

El valor de **ibm.appcenter.push.schedule.period.amount** es un entero. El valor de **ibm.appcenter.push.schedule.period.unit** puede ser segundos, minutos u horas. Si no se especifica la unidad, la cantidad será un intervalo expresado en horas. Estas variables se utilizan para definir el tiempo transcurrido entre dos lotes de mensajes push.

Utilice las propiedades JNDI para definir estas variables.

> **Importante:** En producción, evite establecer la unidad en segundos. Cuanto más corto sea el tiempo transcurrido, mayor será la carga en el servidor. La unidad expresada en segundos sólo se implementa para fines de prueba y evaluación. Por ejemplo, cuando el tiempo transcurrido se establece en 10 segundos, los mensajes push se enviarán casi inmediatamente.



Consulte [Propiedades JNDI para Application Center](../../installation-configuration/production/appcenter/#jndi-properties-for-application-center) para obtener una lista completa de propiedades que puede establecer.

### Ejemplo para servidor Apache Tomcat
{: tomcat }
Defina estas variables con propiedades JNDI en el archivo server.xml:

```xml
<Environment name="ibm.appcenter.push.schedule.period.unit" override="false" type="java.lang.String" value="hours"/>
<Environment name="ibm.appcenter.push.schedule.period.amount" override="false" type="java.lang.String" value="2"/>
```

#### WebSphere Application Server v8.5
{: #websphere }
Para configurar variables JNDI para WebSphere Application Server v8.5, haga lo siguiente:

1. Pulse **Aplicaciones → Tipos de aplicaciones → Aplicaciones empresariales de Websphere**.
2. Seleccione la aplicación Application Center Services.
3. Pulse **Propiedades de módulo web → Entradas de entorno para módulos web**.
4. Edite la serie en la columna **Valor**.

#### Perfil de WebSphere Application Server Liberty
{: #liberty }
Para obtener información sobre cómo configurar variables JNDI para el perfil de WebSphere Application Server Liberty, consulte [Uso del enlace JNDI para constantes desde los archivos de configuración del servidor](http://ibm.biz/knowctr#SSAW57_8.5.5/com.ibm.websphere.wlp.nd.doc/ae/twlp_dep_jndi.html).

Las acciones restantes para configurar el servicio de notificaciones push depende del proveedor del dispositivo donde está instalada la aplicación de destino.

## Configuración del servidor de Application Center para la conexión a Google Cloud Messaging
{: #gcm }
Para habilitar Google Cloud Messaging (GCM) para una aplicación, debe adjuntar los servicios GCM a una cuenta de desarrollador de Google con la API de Google habilitada. Consulte [Cómo empezar con GCM](http://developer.android.com/google/gcm/gs.html) para obtener detalles.

> Importante: El cliente de Application Center sin Google Cloud Messaging: El Application Center se basa en la disponibilidad de la API de Google Cloud Messaging (GCM). Es posible que esta API no esté disponible en dispositivos de algunos territorios, como por ejemplo China. Para dar soporte a estos territorios, puede crear una versión del cliente de Application Center que no dependa de la API de GCM. La característica de notificaciones push no funciona en dicha versión del cliente de Application Center. Consulte [Creación de una versión del cliente móvil que no dependa de la API de GCM](#no-gcm) para obtener más detalles.



1. Si no tiene la cuenta de Google apropiada, vaya a [Crear una cuenta de Google](https://mail.google.com/mail/signup) y cree una para el cliente de Application Center.
2. Registre esta cuenta mediante la API de Google en la [Consola de la API de Google](https://code.google.com/apis/console/). El registro crea un nuevo proyecto predeterminado que puede renombrar. El nombre que dé a este proyecto de GCM no está relacionado con el nombre del paquete de aplicaciones de Android. Cuando se cree el proyecto, se añadirá un ID de proyecto de GCM al final del URL del proyecto. Debería registrar este número de que se añade al final como su ID de proyecto para su referencia futura.
3. Habilite el servicio de GCM para el proyecto; en la consola de la API de Google, pulse el separador **Servicios** de la izquierda y habilite el servicio "Google Cloud Messaging for Android" en la lista de servicios.
4. Asegúrese de que haya disponible una clave de Simple API Access Server para las comunicaciones entre aplicaciones.
    * Pulse el separador vertical **API Access** a la izquierda de la consola.
    * Cree una clave de Simple API Access Server o, si ya hay creada una clave predeterminada, anote los detalles de la clave predeterminada. Hay otros dos tipos de claves que no nos interesan en este momento.
    * Guarde la clave Simple API Access Server para utilizarla más tarde en las comunicaciones entre aplicaciones mediante GCM. La clave tiene alrededor de 40 caracteres y se hace referencia a ella como la clave de la API de Google que necesitará más tarde en el lado del servidor.
5. Escriba el ID del proyecto de GCM como una propiedad de recurso de serie en el proyecto de JavaScript del cliente de Application Center Android; en el archivo de plantilla **IBMAppCenter/apps/AppCenter/common/js/appcenter/config.json**, modifique esta línea con su propio valor:

   ```xml
   gcmProjectId:""// Google API project (project name = com.ibm.appcenter) ID needed for Android push.
   // example : 123456789012
   ```

6. Registre la clave de la API de Google como una propiedad JNDI para el servidor de Application Center. El nombre de clave es: **ibm.appcenter.gcm.signature.googleapikey**. Por ejemplo, puede configurar esta clave para un servidor de Apache Tomcat como una propiedad JNDI en el archivo **server.xml**:

   ```xml
   <Context docBase="AppCenterServices" path="/applicationcenter" reloadable="true" source="org.eclipse.jst.jee.server:AppCenterServices">
        <Environment name="ibm.appcenter.gcm.signature.googleapikey" override="false" type="java.lang.String" 
        value="AIxaScCHg0VSGdgfOZKtzDJ44-oi0muUasMZvAs"/>
   </Context>
   ```

   La propiedad JNDI debe estar definida de acuerdo con los requisitos del servidor de aplicaciones.  
Consulte [Propiedades JNDI para Application Center](../../installation-configuration/production/appcenter/#jndi-properties-for-application-center) para obtener una lista completa de propiedades que puede establecer.
    
**Importante:**

* Si utiliza GCM con versiones anteriores de Android, puede que necesite alinear el dispositivo con una cuenta de Google existente para que GCM funcione efectivamente. Consulte [Servicio de GCM](http://developer.android.com/google/gcm/gcm.html): "Utiliza una conexión existente para servicios de Google. Para dispositivos anteriores a 3.0, esto requiere que los usuarios configuren su cuenta de Google en sus dispositivos móviles. Una cuenta de Google no es un requisito en dispositivos que ejecutan Android 4.0.4 o superior".
* También debe asegurarse de que su cortafuegos acepte conexiones salientes a android.googleapis.com en el puerto 443 para que las notificaciones push funcionen.

## Configuración del servidor de Application Center para la conexión a Apple Push Notification Services
{: #apns }
Configure su proyecto de iOS para Apple Push Notification Services (APNs). Asegúrese de que se pueda acceder a los siguientes servidores desde el servidor de Application Center.

**Servidores de recinto de pruebas**  
gateway.sandbox.push.apple.com:2195
feedback.sandbox.push.apple.com:2196

**Servidores de producción**  
gateway.push.apple.com:2195
feedback.push.apple.com:2196

Debe ser un desarrollador registrado de Apple para configurar correctamente el proyecto de iOS con Apple Push Notification Services (APNs). En la empresa, la función administrativa responsable del desarrollo de Apple solicita la habilitación de APNs. La respuesta a esta solicitud debería proporcionarle un archivo de suministro habilitado para APNs para el paquete de aplicaciones de iOS; es decir, un valor de serie definido en la página de configuración del proyecto de Xcode. Este perfil de suministro se utiliza para generar un archivo de certificado de firma.
Hay dos tipos de perfil de suministro: perfiles de desarrollo y de producción, que se destina a entornos de desarrollo y de producción, respectivamente. Los perfiles de desarrollo se destinan exclusivamente a servidores APNs de desarrollo de Apple. Los perfiles de producción se destinan exclusivamente a servidores APNs de producción de Apple. Estos tipos de servidores no ofrecen la misma calidad de servicio.

Nota: Los dispositivos que están conectados al wifi de una empresa detrás de un cortafuegos sólo pueden recibir notificaciones push si la conexión al siguiente tipo de dirección no está bloqueada por el cortafuegos.

`x-courier.sandbox.push.apple.com:5223`  
Donde x es un entero.

1. Obtenga el perfil de suministro habilitado para APNs para el proyecto de Application Center Xcode. El resultado de la solicitud de habilitación de APNs del administrador se mostrará como una lista accesible desde [https://developer.apple.com/ios/my/bundles/index.action](https://developer.apple.com/ios/my/bundles/index.action). Cada elemento de la lista muestra si el perfil tiene o no prestaciones de APNs. Cuando tenga el perfil, puede descargarlo e instalarlo en el directorio del proyecto Xcode del cliente de Application Center realizando una doble pulsación en el perfil. El perfil se instalará entonces automáticamente en el almacén de claves y en el proyecto de Xcode.

2. Si desea probar o depurar el Application Center en un dispositivo iniciándolo directamente desde XCode, en la ventana "Xcode Organizer", vaya a la sección "Provisioning Profiles" e instale el perfil en el dispositivo móvil.

3. Cree un certificado de firma que utilicen los servicios de Application Center para proteger la comunicación con el servidor de APNs. Este servidor utilizará el certificado para firmar cada solicitud push en el servidor de APNs. Este certificado de firma se creará desde el perfil de suministro.
    
* Abra el programa de utilidad "Keychain Access" y pulse la categoría **Mis certificados** del panel izquierdo.
* Busque el certificado que desee instalar y revele su contenido. Verá un certificado y una clave privada; para el Application Center, la línea del certificado contiene el paquete de aplicaciones de Application Center **com.ibm.imf.AppCenter**.
* Seleccione **Archivo → Exportar elementos** para seleccionar el certificado y la clave y exportarlos como un archivo de Personal Information Exchange (.p12). Este archivo .p12 contiene la clave privada necesaria cuando el protocolo de conformidad de conexión seguro está implicado en la comunicación con el servidor de APNs.
* Copie el certificado .p12 al sistema responsable de la ejecución de los servicios de Application Center e instálelo en el lugar adecuado. Tanto el archivo de certificado como su contraseña son necesarios para crear la ejecución en túnel segura con el servidor de APNs. También necesita alguna información que indique si se está reproduciendo un certificado de desarrollo o un certificado de producción. Un perfil de suministro de desarrollo crea un certificado de desarrollo y un perfil de producción da un certificado de producción. La aplicación web de servicios de Application Center utiliza propiedades JNDI para hacer referencia a estos datos seguros

Los ejemplos de la tabla muestran cómo están definidas las propiedades JNDI en el archivo server.xml del servidor de Apache Tomcat.

| Propiedad JNDI| Tipo y descripción| Ejemplo para servidor Apache Tomcat| 
|---------------|----------------------|----------------------------------|
| ibm.appcenter.apns.p12.certificate.location| Un valor de serie que define la vía de acceso completa al certificado .p12.| `<Environment name="ibm.appcenter.apns.p12.certificate.location" override="false" type="java.lang.String" value="/Users/someUser/someDirectory/apache-tomcat/conf/AppCenter_apns_dev_cert.p12"/>` |
| ibm.appcenter.apns.p12.certificate.password| Un valor de serie que define la contraseña necesaria para acceder al certificado.| `<Environment name="ibm.appcenter.apns.p12.certificate.password" override="false" type="java.lang.String" value="this_is_a_secure_password"/>` | 
| ibm.appcenter.apns.p12.certificate.isDevelopmentCertificate|	Un valor booleano (identificado como true o false) que define si el perfil de suministro utilizado para generar el certificado de autenticación era un certificado de desarrollo.| `<Environment name="ibm.appcenter.apns.p12.certificate.isDevelopmentCertificate" override="false" type="java.lang.String" value="true"/>` | 

Consulte [Propiedades JNDI para Application Center](../../installation-configuration/production/appcenter/#jndi-properties-for-application-center) para obtener una lista completa de propiedades JNDI que puede establecer.

## Creación de una versión del cliente móvil que no dependa de la API de GCM
{: #no-gcm }
Puede eliminar la dependencia en la API de Google Cloud Messaging (GCM) desde la versión Android del cliente para cumplir con las restricciones en algunos territorios. Las notificaciones push no funcionan en esta versión del cliente.

Application Center se basa en la disponibilidad de la API de Google Cloud Messaging (GCM). Es posible que esta API no esté disponible en dispositivos de algunos territorios, como por ejemplo China. Para dar soporte a estos territorios, puede crear una versión del cliente de Application Center que no dependa de la API de GCM. La característica de notificaciones push no funciona en dicha versión del cliente de Application Center. 

1. Compruebe que las notificaciones push estén inhabilitadas comprobando que el archivo **IBMAppCenter/apps/AppCenter/common/js/appcenter/config.json** contenga esta línea: `"gcmProjectId": "" ,`.
2. Elimine de dos lugares del archivo **IBMAppCenter/apps/AppCenter/android/native/AndroidManifest.xml** todas las líneas ubicadas entre estos comentarios: `<!-- AppCenter Push configuration -->` y `<!-- end of AppCenter Push configuration -->`.
3. Suprima la clase **IBMAppCenter/apps/AppCenter/android/native/src/com/ibm/appcenter/GCMIntenteService.java**.
4. En Eclipse, ejecute "Build Android Environment" en la carpeta IBMAppCenter/apps/AppCenter/android.
5. Suprima el archivo **IBMAppCenter/apps/AppCenter/android/native/libs/gcm.jar** que ha creado el plug-in de MobileFirst al ejecutar el mandato "Build Android Environment" anterior.
6. Renueve el proyecto IBMAppCenterAppCenterAndroid recién creado, para que la eliminación de la biblioteca GCM se tenga en cuenta.
7. Cree el archivo .apk del Application Center.

La biblioteca **gcm.jar** se añadirá automáticamente mediante el plug-in de MobileFirst Eclipse cada vez que se cree el entorno de Android. Por lo tanto, este archivo de archivado Java debe suprimirse desde el directorio **IBMAppCenter/apps/AppCenter/android/native/libs/** cada vez que se ejecute el proceso de compilación de MobileFirst Android. De lo contrario, la biblioteca **gcm.jar** estará presente en el archivo **appcenter.apk** resultante.
