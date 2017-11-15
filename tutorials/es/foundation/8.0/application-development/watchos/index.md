---
layout: tutorial
title: Desarrollo para Apple watchOS
breadcrumb_title: watchOS 2, watchOS 3
relevantTo: [ios]
weight: 13
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
En este ejemplo aprenderá a configurar un entorno de desarrollo para watchOS 2 y posterior utilizando la infraestructura de {{ site.data.keys.product_adj }}.
El ejemplo se ha creado y se describe utilizando watchOS 2. También se puede hacer bajo watchOS 3.

## Configuración
{: #setup }
Para configurar el entorno de desarrollo para watchOS, cree el proyecto Xcode, añada la infraestructura watchOS y configure los destinos necesarios.


1. Cree una aplicación watchOS 2 en Xcode.
    * Elija la opción **Archivo → Nuevo → Proyecto**; aparecerá el diálogo **Elegir una plantilla para su nuevo proyecto**.

    * Elija la opción **watchOS2/Aplicación ** y pulse **Siguiente**. 
    * Proporcione un nombre al proyecto y pulse **Siguiente**.
    * Desde el diálogo de navegación, elija la carpeta del proyecto. 

    El árbol de navegación del proyecto ahora contendrá una carpeta de aplicación principal y un destino y una carpeta **[nombre proyecto] WatchKit Extension**.


    ![Proyecto watchOS en Xcode](WatchOSProject.jpg)

2. Añada la infraestructura {{ site.data.keys.product_adj }} watchOS.

    * Para instalar las infraestructuras necesarias con CocoaPods, consulte la guía de aprendizaje [Adición de {{ site.data.keys.product_adj }} Native SDK](../../application-development/sdk/ios/#adding-support-for-apple-watchos).

    * Para instalar las infraestructuras necesarias manualmente:
        * Obtenga la infraestructura de watchOS desde el Centro de descargas de {{ site.data.keys.mf_console }}.
        * Seleccione la carpeta **[nombre proyecto] WatchKit Extension** en el panel de navegación izquierdo. 
        * Desde el menú **Archivo**, elija **Añadir archivos**.
        * Pulse el botón **Opciones** y seleccione lo siguiente: 
            * Opciones **Copiar elementos si es necesario** y **Crear grupos**. 
            * **[nombre proyecto] WatchKit Extension** en la sección **Añadir a destinos**.

        * Pulse **Añadir**.

        Ahora cuando seleccione **[nombre proyecto] WatchKit Extension** en la sección **Destinos**:

            * La vía de acceso de la infraestructura aparece en **Vías de acceso de búsqueda de infraestructura** en la sección **Vías de acceso de búsqueda** del separador **Valores de compilación**.

            * La sección **Enlazar binario con bibliotecas** del separador **Fases de compilación** lista el archivo **IBMMobileFirstPlatformFoundationWatchOS.framework**:
![infraestructuras enlazadas de watchOS](watchOSlinkedframeworks.jpg)

        > **Nota:** WatchOS 2 precisa de bitcode. Desde Xcode 7 **Opciones de compilación** se establece con **Habilitar bitcode sí** (separador **Valores de compilación**, sección **Opciones de compilación**).


3. Registre tanto la aplicación principal como la extensión WatchKit en el servidor.
Ejecute `mfpdev app register` para cada ID de paquete (o registre desde {{ site.data.keys.mf_console }}):

    * com.worklight.[nombre_proyecto]
    * com.worklight.[nombre_proyecto].watchkitextension

4. En Xcode, desde el menú Archivo->Añadir archivo, vaya al archivo mfpclient.plist creado por mfpdev y añádalo al proyecto.

    * Seleccione el archivo a visualizar en el recuadro **Pertenencia de destino**.
Seleccione el destino **WatchOSDemoApp WatchKit Extension** además de **WatchOSDemoApp**.


El proyecto Xcode ahora contiene una aplicación principal y una aplicación watchOS 2, cada una se puede desarrollar de forma independiente.
Para Swift, el punto de entrada para la aplicación watchOS 2 está en el archivo **InterfaceController.swift** en la carpeta **[nombre proyecto] watchKit Extension**.
Para Objective-C el punto de entrada es el archivo **ViewController.m**.


## Configuración de la seguridad de {{ site.data.keys.product_adj }} para la aplicación iPhone y la aplicación watchOS  
{: #setting-up-mobilefirst-security-for-the-iphone-app-and-the-watchos-app }
Los dispositivos Apple Watch e iPhone difieren físicamente.
Las comprobaciones de seguridad para cada uno de los dispositivos de entrada deben ser las apropiadas.
Por ejemplo, Apple Watch está limitado a una interfaz numérica y no permite la habitual comprobación de usuario/contraseña.
Por lo tanto, el acceso a recursos protegidos en el servidor se podría habilitar utilizando un código pin.
Debido a estas, y a otras diferencias parecidas, es necesario aplicar comprobaciones de seguridad diferentes para cada destino.


A continuación hay un ejemplo de la creación de una aplicación cuyo destino es un iPhone y un Apple Watch.
Esta arquitectura permite que cada una tenga su propia comprobación de seguridad.
Las comprobaciones de seguridad tan solo son ejemplos de cómo puede diseñar características para cada destino.
Podrían haber comprobaciones de seguridad adicionales.


1. Determine el ámbito y las comprobaciones de seguridad definidas por el recurso protegido.

2. En {{ site.data.keys.mf_console }}:
    * Asegúrese de que ambas aplicaciones están registradas en el servidor:

        * com.worklight.[nombre_proyecto]
        * com.worklight.[nombre_proyecto].watchkitextension
    * Correlaciones de scopeName con las comprobaciones de seguridad definidas: 
        * Para com.worklight.[nombre_proyecto] correlaciónelo con la comprobación de nombre de usuario/contraseña. 
        * Para com.worklight.[nombre_proyecto].watchkitapp.watchkitextension correlaciónelo con la comprobación de seguridad de código de pin.  

## Limitación de WatchOS 
{: #watchos-limitation }
Las infraestructuras opcionales que añaden características a la aplicación {{ site.data.keys.product_adj }} no se proporcionan para el desarrollo de watchOS.
Algunas otras características están limitadas por las restricciones que el dispositivo watchOS o Apple Watch imponen.


| Característica | Limitación |
|---------|------------|
| openSSL | No soportada |
| JSONStore| No soportada |
| Notificaciones | No soportada |
| Alertas de mensajes visualizadas por el código de {{ site.data.keys.product_adj }} | No soportada |
| Validación de autenticidad de aplicación | No compatible con bitcode, y por lo tanto, no soportada|
| Notificación/inhabilitación remota| Precisa personalización (consulte más abajo) |
| Comprobación de seguridad de contraseña/nombres de usuario | Utilice la comprobación de seguridad CredentialsValidation |

### Notificación/inhabilitación remota
{: #remote-disablenotify }
Con {{ site.data.keys.mf_console }}, es posible configurar {{ site.data.keys.mf_server }} para inhabilitar el acceso (y la devolución de un mensaje) a aplicaciones de cliente basadas en la versión que ejecutan (consulte [Inhabilitación de forma remota del acceso de la aplicación a recursos protegidos](../../administering-apps/using-console/#remotely-disabling-application-access-to-protected-resources).
Existen dos opciones que proporcionan alertas de interfaz de usuario predeterminada: 

* Cuando la aplicación está activa y se envía un mensaje: **Activo y notificando**
* Cuando la aplicación está anticuada y se niega el acceso: **Acceso denegado**

Para watchOS:

* Para ver los mensajes cuando la aplicación está establecida en **Activo y notificando**, se debe implementar y registrar un manejador de desafíos de inhabilitación remota personalizado.
El manejador de desafíos personalizado se debe inicializar con la comprobación de seguridad `wl_remoteDisableRealm`.

* En el caso en el que se inhabilite el acceso (**Acceso denegado**) la aplicación del cliente recibe un mensaje de error en el manejador de delegado de solicitud o la devolución de llamada de anomalía.
El desarrollador puede decidir cómo manejar el error, ya sea notificando al usuario a través de la interfaz de usuario o escribiendo en el registro.
Además, es posible utilizar el método de creación de un manejador de desafíos personalizado.

