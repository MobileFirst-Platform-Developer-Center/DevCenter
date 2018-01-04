---
layout: tutorial
title: La consola de Application Center
relevantTo: [ios,android,windows,javascript]
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
Con la consola de Application Center, puede gestionar el repositorio del Application Center y de las aplicaciones.

La consola de Application Center es una aplicación web para gestionar el repositorio del Application Center. El repositorio del Application Center es la ubicación central donde almacena las aplicaciones móviles que se pueden instalar en dispositivos móviles.

Utilice la consola de Application Center para:

* Subir aplicaciones que se escriben para estos sistemas operativos: Android, iOS, Windows 8 (sólo paquetes de Windows Store), Windows Phone 8 o Windows 10 Universal. 
* Gestionar varias versiones distintas de aplicaciones móviles.
* Revisar los comentarios de los probadores de aplicaciones móviles.
* Definir los usuarios que tienen derechos para listar e instalar una aplicación en los dispositivos móviles.
* Realizar el seguimiento de qué aplicaciones están instaladas en qué dispositivos.

> **Notas:**
>
> * Sólo los usuarios con el rol de administrador pueden iniciar sesión en la consola de Application Center.
> * Soporte multicultural: la interfaz de usuario de la consola de Application Center no se ha traducido.

#### Ir a
{: #jump-to }
* [Inicio de la consola de Application Center](#starting-the-application-center-console)
* [Resolución de problemas de una página de inicio de sesión dañada (Apache Tomcat)](#troubleshooting-a-corrupted-login-page-apache-tomcat)
* [Resolución de problemas de una página de inicio de sesión dañada en navegadores Safari](#troubleshooting-a-corrupted-login-page-in-safari-browsers)
* [Gestión de aplicaciones](#application-management)
* [Adición de una aplicación móvil](#adding-a-mobile-application)
* [Cómo añadir una aplicación desde un almacenamiento de aplicaciones públicas](#adding-an-application-from-a-public-app-store)
* [Propiedades de la aplicación](#application-properties)
* [Edición de las propiedades de la aplicación](#editing-application-properties)
* [Actualización de una aplicación móvil en {{ site.data.keys.mf_server }} y el Application Center](#upgrading-a-mobile-application-in-mobilefirst-server-and-the-application-center)
* [Descarga de un archivo de aplicación](#downloading-an-application-file)

En la consola de Application Center, puede ver opiniones sobre versiones de la aplicación móvil enviadas por los usuarios.

* [Gestión de usuarios y grupos](#user-and-group-management)
* [Control de acceso](#access-control)
* [Gestión de control de acceso](#managing-access-control)
* [Gestión de dispositivos](#device-management)
* [Señales de inscripción de aplicaciones en Windows 8 Universal](#application-enrollment-tokens-in-windows-8-universal)
* [Cierre de sesión de la consola de Application Center](#signing-out-of-the-application-center-console)

## Inicio de la consola de Application Center
{: #starting-the-application-center-console }
Puede iniciar el Application Center con el navegador web e iniciar sesión si tiene el rol de administrador.

1. Inicie una sesión de navegador web en el escritorio.
2. Póngase en contacto con el administrador del sistema para obtener la dirección y el puerto del servidor donde está instalado Application Center.
3. Especifique el siguiente URL: `http://server/appcenterconsole`
4. Donde **server** es la dirección y el puerto del servidor donde está instalado Application Center: `http://localhost:9080/appcenterconsole`

Inicie sesión en la consola de Application Center. Póngase en contacto con el administrador del sistema para obtener las credenciales para que pueda iniciar sesión en la consola de Application Center.

![Inicio de sesión en la consola de Application Center](ac_startconsole.jpg)

> **Nota:** Sólo los usuarios con el rol de administrador pueden iniciar sesión en la consola de Application Center.

## Resolución de problemas de una página de inicio de sesión dañada (Apache Tomcat)
{: #troubleshooting-a-corrupted-login-page-apache-tomcat }
Puede recuperarse de una página de inicio de sesión dañada de la consola de Application Center cuando el Application Center se ejecute en Apache Tomcat.

Cuando el Application Center se ejecute en Apache Tomcat, el uso de un nombre de usuario o contraseña incorrectos podría dañar la página de inicio de sesión de la consola de Application Center.

Cuando intente iniciar sesión en la consola con un nombre de usuario o contraseña incorrectos, recibirá un mensaje de error. Cuando corrija el nombre de usuario o la contraseña, en lugar de un inicio de sesión correcto, tendrá uno de los siguientes errores; el mensaje dependerá del navegador web.

* El mismo mensaje de error que antes
* El mensaje **La conexión se ha restablecido**
* El mensaje **Se ha superado el tiempo permitido para el inicio de sesión**

El comportamiento se ha vinculado a la gestión por parte de Apache Tomcat del servlet j_security_check. Este comportamiento es específico de Apache Tomcat y no se da en ninguno de los perfiles de WebSphere Application Server.

El método alternativo es pulsar el botón de actualización del navegador para renovar la página web tras el error de inicio de sesión. A continuación, escriba las credenciales correctas.

## Resolución de problemas de una página de inicio de sesión dañada en navegadores Safari
{: #troubleshooting-a-corrupted-login-page-in-safari-browsers }
Puede recuperarse de una página de inicio de sesión dañada de la consola de Application Center al utilizar el navegador Safari.

Cuando la consola de Application Center está abierta en un navegar Safari, puede navegar fuera de la consola. Cuando vuelva a la consola, puede que vea la página de inicio de sesión. Aunque especifique los detalles de inicio de sesión correctos, verá el mensaje siguiente en lugar de un inicio de sesión correcto: **HTTP Status 404 - appcenterconsole/j_security_check.**

El comportamiento está vinculado a un problema de almacenamiento en memoria caché en el navegador Safari.

El método alternativo es desencadenar una recarga forzada al utilizar la página de inicio de sesión sin credenciales especificas ni rellenadas. A continuación se muestra cómo desencadenar una recarga forzada:

* En un sistema Mac, pulse Mayús + el botón **Renovar**.
* En un dispositivo iPad o iPhone: Efectúe una doble pulsación en el botón de renovación o borre la memoria caché cerrando Safari: efectúe una doble pulsación en el botón de inicio y, a continuación, deslice el dedo en Safari.

## Application Management
{: #application-management }
Puede utilizar Application Management para añadir aplicaciones y versiones nuevas y para gestionar dichas aplicaciones.  
Application Center le permite añadir aplicaciones y versiones nuevas y gestionar dichas aplicaciones.

Pulse **Aplicaciones** para acceder a Application Management.

### Application Center está instalado en el perfil de WebSphere Application Server Liberty o en Apache Tomcat
{: #application-center-installed-on-websphere-application-server-liberty-profile-or-on-apache-tomcat }
Las instalaciones del Application Center en estos servidores de aplicaciones, durante la instalación de {{ site.data.keys.product_full }} con el paquete de IBM Installation Manager, tienen dos usuarios diferentes definidos que puede utilizar para empezar.

* Usuario con la **demo** de inicio de sesión y la **demo** de contraseña
* Usuario con la **appcenteradmin** de inicio de sesión y la **admin** de contraseña

### Perfil completo de WebSphere Application Server
{: #websphere-application-server-full-profile }
Si ha instalado Application Center en el perfil completo de WebSphere Application Server, se creará un usuario denominado appcenteradmin de forma predeterminada con la contraseña indicada por el instalador.

![Aplicaciones disponibles](ac_app_mgt.jpg)

## Cómo añadir aplicaciones móviles
{: #adding-a-mobile-application }
Puede añadir aplicaciones al repositorio en el servidor utilizando la consola de Application Center. Estas aplicaciones se podrán instalar en dispositivos móviles utilizando el cliente móvil.

En la vista Aplicaciones, puede añadir aplicaciones al Application Center. Inicialmente, la lista de aplicaciones está vacía y debe subir un archivo de aplicación. Los archivos de aplicaciones se describen en este procedimiento.

Para añadir una aplicación para hacerla disponible para su instalación en dispositivos móviles:

1. Pulse **Añadir aplicación**.
2. Pulse **Subir**.
3. Seleccione el archivo de aplicación para subir en el repositorio de Application Center.

   ### Android
   {: #android }
   La extensión del nombre del archivo de aplicación es **.apk**.

   ### iOS
   {: #ios }
   La extensión del nombre del archivo de aplicación es **.ipa** para las aplicaciones iOS normales. 

   ### Windows Phone 8
   {: #windows-phone-8 }
   La extensión del nombre del archivo de aplicación es **.xap**. La aplicación debe estar firmada con una cuenta de la empresa. La señal de inscripción de aplicación para esta cuenta de la empresa debe ponerse a disposición de dispositivos Windows Phone 8 antes de que la aplicación se pueda instalar en los dispositivos. Consulte [Señales de inscripción de aplicación en Windows 8 Universal](#application-enrollment-tokens-in-windows-8-universal) para obtener más detalles.

   ### Windows 8
   {: #windows-8 }
     La aplicación se proporciona como un paquete de Windows Store; la extensión de archivo es **.appx**. 

   Los paquetes .appx de Windows Store pueden depender de uno o varios paquetes de aplicaciones de biblioteca de componentes de Windows, que también se conocen como paquetes de "infraestructura". Las aplicaciones híbridas de MobileFirst para Windows 8 dependen del paquete de infraestructura de Microsoft.WinJS. Al utilizar Microsoft Visual Studio para generar el paquete de aplicaciones, los paquetes de dependencias también se generarán y se empaquetarán como archivos .appx independientes. Para instalar satisfactoriamente tales aplicaciones utilizando el cliente móvil, debe subir el paquete .appx de la aplicación y cualquier otro paquete de dependencias en el servidor de Application Center. Al subir un paquete de dependencias, aparecerá como inactivo en la consola del Application Center. Se espera este comportamiento, por lo que el paquete de infraestructura no aparece como una aplicación instalable en el cliente. A continuación, cuando un usuario instala una aplicación, el cliente móvil comprueba si la dependencia ya está instalada en el dispositivo. Si el paquete de dependencias no está instalado, el cliente recupera automáticamente el paquete de dependencias desde el servidor de Application Center y lo instala en el dispositivo. Para obtener más información sobre las dependencias, consulte [Dependencias](http://msdn.microsoft.com/library/windows/apps/hh464929.aspx#dependencies) en la documentación del desarrollador de Windows sobre los paquetes y el despliegue de aplicaciones.

   ### Windows 10 universal
   {: windows-10-universal}
   La extensión del nombre del archivo de aplicación es **.appx**.
   


4. Pulse **Siguiente** para acceder a las propiedades para completar la definición de la aplicación.
5. Rellene las propiedades para definir la aplicación. Consulte [Propiedades de aplicación](#application-properties) para obtener información sobre cómo rellenar valores de propiedad.
6. Pulse **Finalizar**.

![Propiedades de aplicación, adición de una aplicación](ac_add_app_props.jpg)

## Adición de una aplicación desde un almacenamiento de aplicaciones públicas
{: #adding-an-application-from-a-public-app-store }
Application Center da soporte a la adición en las aplicaciones del catálogo que se almacenan en almacenes de aplicaciones de terceros, como por ejemplo Google play o Apple iTunes.

Las aplicaciones de almacenamientos de aplicaciones de terceros aparecen en el catálogo de Application Center como cualquier otra aplicación, pero se dirigirá a los usuarios al almacén de aplicaciones públicas correspondientes para instalar la aplicación. Añada una aplicación desde un almacén de aplicaciones públicas de la consola, en el mismo lugar en el que ha añadido una aplicación creada dentro de su propia empresa. Consulte [Adición de una aplicación móvil](#adding-a-mobile-application).

> **Nota:** En este momento, Application Center sólo da soporte a Google Play y Apple iTunes. Windows Phone Store y Windows Store no están soportados aún.



En lugar del archivo ejecutable de la aplicación, debe proporcionar un URL al almacén de aplicaciones de terceros donde se almacena la aplicación. Para buscar el enlace de aplicación correcto más fácilmente, la consola proporcionará enlaces directos en la página **Añadir una aplicación** a los sitios web del almacén de aplicaciones de terceros soportados.

La dirección del almacén de Google play es [https://play.google.com/store/apps](https://play.google.com/store/apps).

La dirección del almacén de Apple iTunes es [https://linkmaker.itunes.apple.com/](https://linkmaker.itunes.apple.com/); utilice el sitio del linkmaker en lugar del sitio de iTunes, porque puede buscar este sitio para todos los tipos de elementos de iTunes, incluidas canciones, podcasts, y otros elementos soportados por Apple. Sólo al seleccionar aplicaciones de iOS se proporcionan enlaces compatibles para crear enlaces de aplicación.

1. Pulse la URL del almacén de aplicaciones público que desee examinar.
2. Copie la URL de la aplicación del almacén de aplicaciones de terceros al campo de texto **URL de aplicaciones** de la página **Añadir una aplicación** de la consola del Application Center.
    * **Google Play:**
        * Seleccione una aplicación en el almacén.
        * Pulse la página de detalles de la aplicación.
        * Copie la URL de la barra de direcciones.
    * **Apple iTunes:**
        * Cuando se devuelve la lista de elementos en el resultado de la búsqueda, seleccione el elemento que desee.

        * En la parte inferior de la aplicación seleccionada, pulse **Enlace directo** para abrir la página de detalles de la aplicación.

        * Copie la URL de la barra de direcciones.

          **Nota:** No copie el **Enlace directo** al Application Center. **Enlace directo** es una URL con redirección. Necesitará obtener la URL a la que se redirige.

3. Cuando el enlace de aplicación se encuentra en el campo de texto **URL de aplicación** de la consola, pulse **Siguiente** para validar la creación del enlace de aplicación.
    * Si la validación no es correcta, se mostrará un mensaje de error en la página **Añadir una aplicación**. Puede probar otro enlace o cancelar el intento de crear el enlace actual.
    * Si la validación es correcta, esta acción mostrará las propiedades de aplicación. A continuación, puede modificar la descripción de aplicación en las propiedades de aplicación antes de moverse al paso siguiente.

    ![Descripción de aplicación modificada en las propiedades de la aplicación](ac_add_public_app_details.jpg)

4. Pulse **Listo** para crear el enlace de aplicación.

    Esta acción hace que la aplicación esté disponible en la versión correspondiente del cliente móvil de Application Center. Aparecerá un icono de enlace pequeño en el icono de la aplicación para mostrar que esta aplicación está almacenada en un almacén de aplicaciones público y que es distinta de una aplicación binaria.

    ![Enlace a una aplicación almacenada en Google Play](ac_public_app_available.jpg)

## Propiedades de la aplicación
{: #application-properties }
Las aplicaciones tienen sus propios conjuntos de propiedades, que depende del sistema operativo del dispositivo móvil y no se pueden editar. Las aplicaciones también tienen una propiedad común y propiedades editables.

Los valores de los campos siguientes se toman de la aplicación y no se pueden editar.

* **Paquete**.
* **Versión interna**.
* **Versión comercial**.
* **Etiqueta**.
* **URL externo**; esta propiedad está soportada para aplicaciones que se ejecutan en Android, iOS, y Windows Phone 8.

### Propiedades de aplicaciones Android
{: #properties-of-android-applications }
Para obtener más información sobre las propiedades siguientes, consulte la documentación de Android SDK.

* **Paquete** es el nombre de paquete de la aplicación; el atributo **paquete** del elemento manifest en el archivo manifest de la aplicación.
* **Versión interna** es la identificación de la versión interna de la aplicación; el atributo **android:versionCode** del elemento **manifest** en el archivo manifest de la aplicación.
* **Versión comercial** es la versión publicada de la aplicación.
* **Etiqueta** es la etiqueta de la aplicación; **android:label attribute** del elemento de aplicación en el archivo **manifest** de la aplicación.
* **URL externo** es un URL que puede utilizar para que el cliente móvil del Application Center se inicie automáticamente en la vista Detalles de la versión más reciente de la aplicación actual.

### Propiedades de aplicaciones de iOS
{: #properties-of-ios-applications }
Para obtener más información sobre las propiedades siguientes, consulte la documentación de iOS SDK.

* **Paquete** es el identificador de la empresa y el nombre de producto; clave **CFBundleIdentifier**.
* **Versión interna** es el número de compilación de la aplicación; clave **CFBundleVersion** de la aplicación.
* **Versión comercial** es la versión publicada de la aplicación.
* **Etiqueta** es la etiqueta de la aplicación; clave **CFBundleDisplayName** de la aplicación.
* **URL externo** es un URL que puede utilizar para que el cliente móvil del Application Center se inicie automáticamente en la vista Detalles de la versión más reciente de la aplicación actual.

### Propiedades de las aplicaciones de Windows Phone 8
{: #properties-of-windows-phone-8-applications }
Para obtener más información sobre las propiedades siguientes, consulte la documentación de Windows Phone.

* **Paquete** es el identificador de producto de la aplicación; atributo **ProductID** del elemento App del archivo manifest de la aplicación.
* **Versión interna** es la identificación de la versión de la aplicación; el atributo **Versión** del elemento App del archivo manifest de la aplicación.
* **Versión comercial**, como Versión interna, es la versión de la aplicación.
* **Etiqueta**() es el título de la aplicación; el atributo **Título** del elemento **App** del archivo manifest de la aplicación.
* **Proveedor** es el proveedor que ha creado la aplicación; el atributo **Aplicación de publicación** del elemento **App** del archivo manifest de la aplicación.
* **URL externo** es un URL que puede utilizar para que el cliente móvil del Application Center se inicie automáticamente en la vista Detalles de la versión más reciente de la aplicación actual.
* **Versión comercial**, como **Versión interna**, es la versión de la aplicación.

### Propiedades de las aplicaciones de Windows Store
{: #properties-of-windows-store-applications }
Para obtener más información sobre las siguientes propiedades, consulte la documentación de Windows Store sobre el desarrollo de aplicaciones.

* **Paquete** es el identificador de producto de la aplicación; el atributo del nombre de **Paquete** del archivo manifest de la aplicación.
* **Versión interna** es la identificación de versión de la aplicación; el atributo **Versión** del archivo manifest de la aplicación.
* **Versión comercial**, como **Versión interna**, es la versión de la aplicación.
* **Etiqueta** es el título de la aplicación; el atributo del nombre de visualización de **Paquete** del archivo manifest de la aplicación.
* **Proveedor** es el proveedor que ha creado la aplicación; el atributo **Aplicación de publicación** del archivo manifest de la aplicación.

### Propiedades de las aplicaciones de Windows 10 Universal
{: #properties-of-windows-10-universal-applications}

* **Paquete** es el identificador de producto de la aplicación; el atributo del nombre de **Paquete** del archivo manifest de la aplicación.
* **Versión interna** es la identificación de versión de la aplicación; el atributo **Versión** del archivo manifest de la aplicación.
* **Versión comercial**, como **Versión interna**, es la versión de la aplicación.
* **Etiqueta** es el título de la aplicación; el atributo del nombre de visualización de **Paquete** del archivo manifest de la aplicación.
* **Proveedor** es el proveedor que ha creado la aplicación; el atributo **Aplicación de publicación** del archivo manifest de la aplicación.

### Propiedad común: Autor
{: #common-property-author }
El campo **Autor** es de sólo lectura. Muestra el atributo **username** del usuario que sube la aplicación.

### Propiedades editables
{: #editable-properties }
Puede editar los siguientes campos:

**Descripción**  
Utilice este campo para describir la aplicación al usuario móvil.

**Recomendado**  
Seleccione **Recomendado** para indicar que anima a los usuarios a instalar esta aplicación. Las aplicaciones recomendadas aparecen como una lista especial en el cliente móvil.

**Instalador**  
Sólo para el Administrador: Esta propiedad indica que la aplicación se utiliza para instalar otras aplicaciones en el dispositivo móvil y enviar comentarios sobre una aplicación desde el dispositivo móvil al Application Center. Normalmente, sólo una aplicación está cualificada como **Instalador** y se llama cliente móvil. Esta aplicación se documenta en [El cliente móvil](../mobile-client).

**Activa**  
Seleccione Activa para indicar que una aplicación puede estar instalada en un dispositivo móvil.

* Si no selecciona **Activa**, el usuario móvil no verá la aplicación en la lista de aplicaciones disponibles que se muestran en el dispositivo y la aplicación está inactiva.
* En la lista de aplicaciones disponibles en Application Management, si **Mostrar inactivo** está seleccionado, la aplicación se inhabilita. Si **Mostrar inactivo** no está seleccionado, la aplicación no aparecerá en la lista de aplicaciones disponibles.

**Preparado para producción**  
Seleccione **Preparado para producción** para indicar que una aplicación está lista para desplegarse en un entorno de producción y que, por lo tanto, es apropiada para que la gestione Tivoli Endpoint Manager mediante su almacén de aplicaciones. Las aplicaciones para las que se selecciona esta propiedad son las únicas que se señalan en Tivoli Endpoint Manager.

## Edición de propiedades de aplicaciones
{: #editing-application-properties }
Puede editar las propiedades de una aplicación en la lista de aplicaciones subidas.  
Para editar las propiedades de una aplicación subida:

1. Seleccione **Aplicaciones** para ver la lista de aplicaciones subidas: Aplicaciones disponibles.
2. Pulse la versión de la aplicación para editar las propiedades: Detalles de la aplicación.
3. Edite cualquiera de las propiedades editables que desee. Consulte [Propiedades de aplicación](#application-properties) para obtener más detalles acerca de estas propiedades. El nombre del archivo de aplicación actual se muestra después de las propiedades.

    > **Importante:** Si desea actualizar el archivo, debe pertenecer al mismo paquete y tener el mismo número de versión. Si alguna de estas propiedades no es la misma, debe volver a la lista de aplicaciones y añadir la nueva versión en primer lugar.



4. Pulse **Aceptar** para guardar los cambios y volver a Aplicaciones disponibles o **Aplicar** para guardar y conservar los Detalles de la aplicación abiertos.

![Propiedades de la aplicación para su edición](ac_edit_app_props.jpg)

## Actualización de una aplicación móvil en {{ site.data.keys.mf_server }} y en el Application Center
{: #upgrading-a-mobile-application-in-mobilefirst-server-and-the-application-center }

> Esto únicamente está soportado para Android, iOS y Windows Phone y actualmente no está soportado para Windows 10 Universal, Blackberry ni Windows 8 Universal.





Puede actualizar de forma sencilla aplicaciones móviles desplegadas utilizando una combinación de {{ site.data.keys.mf_console }} y del Application Center.

El cliente móvil del Application Center debe estar instalado en el dispositivo móvil. La aplicación HelloWorld debe estar instalada en el dispositivo móvil y debe estar conectada a {{ site.data.keys.mf_server }} cuando la aplicación está en ejecución.

Puede utilizar este procedimiento para actualizar aplicaciones Android, iOS y Windows Phone que se han desplegado en {{ site.data.keys.mf_server }} y también en el Application Center. En esta tarea, la aplicación HelloWorld versión 1.0 ya está desplegada en {{ site.data.keys.mf_server }} y en el Application Center.

Se ha publicado HelloWorld versión 2.0 y desea que los usuarios de la versión 1.0 actualicen a la versión más reciente. Para desplegar la versión nueva de la aplicación:

1. Despliegue HelloWorld 2.0 en el Application Center. Consulte [Adición de una aplicación móvil](#adding-a-mobile-application).
2. Desde la página Detalles de la aplicación, copie el valor del URL externo.

    ![Copia del URL externo desde Detalles de aplicación](ac_copy_ext_url.jpg)

3. Cuando el URL externo se copia en el portapapeles, abra la {{ site.data.keys.mf_console }}.
4. Cambie la regla de acceso de HelloWorld versión 1.0 a "Acceso inhabilitado".
5. Pegue el URL externo en el campo URL.

    Ejecución del cliente: Cuando un dispositivo móvil se conecta a {{ site.data.keys.mf_server }} para intentar ejecutar HelloWorld versión 1.0, se solicitará que el usuario del dispositivo actualice la versión de la aplicación.

    ![Inhabilitación remota de una versión antigua de una aplicación](ac_remote_disable_app_cli.jpg)

6. Pulse **Actualizar** para abrir el cliente de Application Center. Cuando los detalles de inicio de sesión estén rellenos correctamente, accederá a la página Detalles de HelloWorld versión 2.0 directamente.

    ![Detalles de HelloWorld 2.0 en el cliente de Application Center ](ac_cli_app_details_upgrade.jpg)

## Descarga de un archivo de aplicación
{: #downloading-an-application-file }
Puede descargar el archivo de una aplicación registrada en el Application Center.

1. Seleccione **Aplicaciones** para ver la lista de aplicaciones subidas: **Aplicaciones disponibles**.
2. Toque la versión de la aplicación en **Detalles de la aplicación**.
3. Toque el nombre de archivo en la sección "Archivo de aplicación".

## Visualización de opiniones de aplicaciones
{: #viewing-application-reviews }
En la consola de Application Center, puede ver opiniones sobre versiones de la aplicación móvil enviadas por los usuarios.

Los usuarios de aplicaciones móviles pueden escribir una opinión, que incluye una puntuación y un comentario, y enviar la opinión mediante el cliente de Application Center. Las opiniones están disponibles en la consola y en el cliente del Application Center. Las opiniones individuales siempre están asociadas con una versión concreta de una aplicación.

Para ver opiniones desde usuarios o probadores móviles sobre la versión de una aplicación:

1. Seleccione **Aplicaciones** para ver la lista de aplicaciones subidas: **Aplicaciones disponibles**.
2. Seleccione la versión de la aplicación.
3. En el menú, seleccione **Opiniones**.

    ![Opiniones de versiones de aplicaciones](ac_appfeedbk.jpg)

    La puntuación es una media de las puntuaciones en todas las opiniones registradas. Consta de una a cinco estrellas, donde una estrella representa el nivel más bajo de valoración y cinco estrellas representan el nivel más alto de valoración. El cliente no puede enviar una puntuación de cero estrellas.

    La puntuación media da una indicación de cómo la aplicación satisface el uso pretendido de la aplicación.

4. Pulse las dos puntas de flecha <img src="down-arrow.jpg" style="margin:0;display:inline" alt="Botón de punta de flecha doble"/> para ampliar el comentario que forma parte de la opinión y para ver los detalles del dispositivo móvil donde se genera la opinión.

    Por ejemplo, el comentario puede dar el motivo para enviar la opinión, como un fallo al instalar.
    Si desea suprimir la opinión, pulse el icono de papelera a la derecha de la opinión que desea suprimir.

## Gestión de usuarios y grupos
{: #user-and-group-management }
Puede utilizar usuarios y grupos para definir quién tiene acceso a algunas características del Application Center, como por ejemplo la instalación de aplicaciones en dispositivos móviles.  
Utilice usuarios y grupos en la definición de las listas de control de acceso (ACL).

### Gestión de usuarios registrados
{: #managing-registered-users }
Para gestionar los usuarios registrados, pulse el separador **Usuarios/Grupos** y seleccione **Usuarios registrados**. Obtendrá una lista de usuarios registrados del Application Center que incluye:

* Usuarios del cliente móvil
* Usuarios de la consola
* Miembros del grupo local
* Miembros de una lista de control de acceso

![Lista de usuarios registrados de Application Center](ac_reg_users.jpg)

Si el Application Center está conectado a un repositorio LDAP, no podrá editar los nombres de visualización del usuario. Si el repositorio no es LDAP, puede cambiar el nombre de visualización de un usuario seleccionándolo y editándolo.

Para registrar usuarios nuevos, pulse **Registrar usuario**, escriba el nombre de inicio de sesión y el nombre de visualización, y pulse **Aceptar**.  
Para anular el registro de un usuario, pulse el icono de papelera junto al nombre de usuario.

* Eliminación de los comentarios proporcionados por el usuario
* Eliminación del usuario desde las listas de control de acceso
* Eliminación del usuario desde los grupos locales

> **Nota:** Cuando anula el registro de un usuario, este se eliminará del servidor de aplicaciones o del repositorio LDAP.

### Gestión de grupos locales
{: #managing-local-groups }
Para gestionar grupos locales, pulse el separador **Usuarios/Grupos** y seleccione **Grupo de usuarios**.  
Para crear un grupo local, pulse **Crear grupo**. Escriba el nombre del grupo nuevo y pulse **Aceptar**.

Si el Application Center está conectado a un repositorio LDAP, la búsqueda incluye grupos locales, así como los grupos definidos en el repositorio LDAP. Si el repositorio no es LDAP, sólo estarán disponibles los grupos locales en la búsqueda.

![Grupos de usuarios locales](ac_loc_group.jpg)

Para suprimir un grupo, pulse el icono de papelera junto al nombre de grupo. El grupo también se elimina de las listas de control de acceso.  
Para añadir o eliminar miembros de un grupo, pulse el enlace **Editar miembros** del grupo.

![Gestión de pertenencia a grupo](ac_grp_members.jpg)

Para añadir un miembro nuevo, busque el usuario especificando el nombre de visualización del usuario, seleccione el usuario y pulse **Añadir**.

Si el Application Center está conectado a un repositorio LDAP, la búsqueda para el usuario se realiza en el repositorio LDAP. Si el repositorio no es LDAP, la búsqueda se realiza en la lista de usuarios registrados.

Para eliminar un miembro de un grupo, pulse el icono de cruz a la derecha del nombre de usuario.

## Control de accesos
{: #access-control }
Puede decidir si la instalación de una aplicación en dispositivos móviles está abierta a cualquier usuario o si desea restringir la capacidad de instalar una aplicación.

La instalación de aplicaciones en un dispositivo móvil se puede limitar a usuarios específicos o puede estar disponible para cualquier usuario.

El control de accesos está definido a nivel de aplicación y no a nivel de versión.

De forma predeterminada, una vez que se cargue una aplicación, cualquier usuario tiene el derecho de instalar la aplicación en un dispositivo móvil.

El control de accesos actual para una aplicación se visualiza en Aplicaciones disponibles para cada aplicación. El estado de acceso no restringido o restringido para la instalación se muestra como un enlace a la página para editar el control de accesos.

Los derechos de instalación sólo son acerca de la instalación de la aplicación en el dispositivo móvil. Si no se habilita el control de accesos, todo el mundo tendrá acceso a la aplicación.

## Gestión del control de accesos
{: #managing-access-control }
Puede añadir o eliminar el acceso para los usuarios o grupos para instalar una aplicación en dispositivos móviles.  
Puede editar el control de accesos:

1. En Application Management en Aplicaciones disponibles, pulse el estado no restringido o restringido de Instalación de una aplicación.

    ![Donde pulsar en la modalidad restringida o no restringida](ac_app_access_state.jpg)

2. Seleccione **Control de accesos habilitado** para habilitar el control de accesos.
3. Añada usuarios o grupos a la lista de acceso.

Para añadir un usuario o grupos únicos, escriba un nombre, seleccione la entrada en las entradas coincidentes que se encuentran, y pulse **Añadir**.

Si el Application Center está conectado a un repositorio LDAP, puede buscar usuarios y grupos en el repositorio, así como grupos definidos de forma local. Si el repositorio no es LDAP, sólo podrá buscar grupos locales y usuarios registrados. Los grupos locales se definen de forma exclusiva en el separador **Usuarios/Grupos**. Cuando utilice el registro federado del perfil de Liberty, sólo podrá buscar usuarios mediante el nombre de inicio de sesión; el resultado está limitado a un máximo de 15 usuarios y 15 grupos (en lugar de 50 usuarios y 50 grupos).

Para registrar un usuario al mismo tiempo que añada el usuario a la lista de acceso, escriba el nombre y pulse **Añadir**. A continuación, debe especificar el nombre de inicio de sesión y el nombre de visualización del usuario.

Para añadir todos los usuarios de una aplicación, pulse **Añadir usuarios desde la aplicación** y seleccione la aplicación apropiada.  
Para eliminar el acceso de un usuario o un grupo, pulse el icono de cruz a la derecha del nombre.

![Adición o eliminación de usuarios en la lista de acceso](ac_instal_access.jpg)

## Gestión de dispositivos
{: #device-management }
Puede ver los dispositivos que están conectados al Application Center desde el cliente móvil de Application Center y sus propiedades.

**Gestión de dispositivos** muestra en **Dispositivos registrados** la lista de dispositivos que se han conectado al Application Center al menos una vez desde el cliente móvil de Application Center.

![La lista de dispositivos](ac_reg_devices.jpg)

### Propiedades de dispositivo
{: #device-properties }
Pulse un dispositivo de la lista de dispositivos para ver las propiedades del dispositivo o las aplicaciones instaladas en dicho dispositivo.

![Propiedades de dispositivo](ac_edit_deviceprops.jpg)

Seleccione **Propiedades** para ver las propiedades del dispositivo.

**Nombre**  
El nombre del dispositivo. Puede editar esta propiedad.

> **Nota:** en iOS, el usuario puede definir este nombre en la configuración del dispositivo en Configuración > General > Información > Nombre. Se mostrará el mismo nombre en iTunes.



**Nombre de usuario**  
El nombre del primer usuario que ha iniciado sesión en el dispositivo.

**Fabricante**  
El fabricante del dispositivo.

**Modelo**  
El identificador de modelo.

**Sistema operativo**  
El sistema operativo del dispositivo móvil.

**Identificador exclusivo**  
El identificador exclusivo del dispositivo móvil.

Si edite el nombre de dispositivo, pulse **Aceptar** para guardar el nombre y volver a Dispositivos registrados o **Aplicar** para guardar y conservar abierto Editar propiedades del dispositivo.

### Aplicaciones instaladas en el dispositivo
{: #applications-installed-on-device }
Seleccione **Aplicaciones instaladas en el dispositivo** para enumerar todas las aplicaciones instaladas en el dispositivo.

![Aplicaciones instaladas en un dispositivo](ac_apps_on_device.jpg)

## Señales de inscripción de aplicaciones en Windows 8 Universal
{: #application-enrollment-tokens-in-windows-8-universal }
El sistema operativo Windows 8 Universal requiere que los usuarios inscriban cada dispositivo con la empresa antes de que los usuarios puedan instalar aplicaciones de empresa en sus dispositivos. Una forma de inscribir los dispositivos es utilizando una señal de inscripción de aplicación.

Las señales de inscripción de aplicación le permiten instalar aplicaciones de empresa en un dispositivo Windows 8 Universal. Debe instalar en primer lugar la señal de inscripción para una empresa específica en el dispositivo para inscribir el dispositivo con la empresa. A continuación, puede instalar aplicaciones creadas y firmadas por la empresa correspondiente.
El Application Center simplifica la entrega de la señal de inscripción. En su rol de administrador del catálogo del Application Center, puede gestionar las señales de inscripción desde la consola del Application Center. Una vez que se declaren las señales de inscripción en la consola del Application Center, estarán disponibles para que los usuarios del Application Center inscriban sus dispositivos.

La interfaz de señales de inscripción disponible desde la consola del Application Center en la vista Configuración le permite gestionar señales de inscripción de la aplicación para Windows 8 Universal registrándolas, actualizándolas o suprimiéndolas.

### Gestión de señales de inscripción de aplicación
{: #managing-application-enrollment-tokens }
En el rol de administrador del Application Center, puede acceder a la lista de señales registradas pulsando el icono de engranaje en la cabecera de la pantalla para mostrar la Configuración del Application Center. A continuación, seleccione **Señales de inscripción** para mostrar la lista de señales registradas.

Para inscribir un dispositivo, el usuario del dispositivo debe subir e instalar el archivo de la señal antes de instalar el cliente móvil de Application Center. El cliente móvil también es una aplicación de empresa. Por lo tanto, el dispositivo debe estar inscrito para poder instalar el cliente móvil.

Las señales registradas están disponibles mediante la página de arranque en `http://hostname:portnumber/applicationcenter/installers.html`, donde **hostname** es el nombre de host del servidor que aloja el Application Center y **portnumber** es el número de puerto correspondiente.

Para registrar una señal en la consola de Application Center, pulse **Subir señal** y seleccione un archivo de señal. La extensión de archivo de señal es aetx.  
Para actualizar el asunto de certificado de una señal, seleccione el nombre de señal en la lista, cambie el valor y pulse Aceptar.  
Para suprimir una señal, pulse el icono de papelera en la parte derecha de la señal en la lista.

## Cierre de sesión de la consola de Application Center
{: #signing-out-of-the-application-center-console }
Por motivos de seguridad, debe cerrar sesión en la consola cuando haya terminado sus tareas administrativas.

Para cerrar sesión del inicio de sesión seguro en la consola de Application Center.  
Para cerrar sesión de la consola de Application Center, pulse **Finalizar sesión** junto al mensaje de Bienvenida que se muestra en el banner de cada página.
