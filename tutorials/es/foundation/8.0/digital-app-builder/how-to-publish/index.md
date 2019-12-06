---
layout: tutorial
title: Publicación de una aplicación en IBM App Center
weight: 14
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->

## Publicación de una aplicación 
{: #dab-app-publish }

Con la opción Publicar, puede crear y publicar su aplicación para Android/iOS en App Center o publicar Direct Updates de su aplicación “over-the-air” con recursos web renovados. 

### Publicación de una aplicación en App Center
{: #dab-app-publish-to-app-center }

IBM MobileFirst Foundation Application Center es un repositorio de aplicaciones móviles similar a los almacenes de aplicaciones públicos pero enfocado en las necesidades de una organización o equipo. Es un almacén de aplicaciones privado. Para obtener más información acerca de APP Center, consulte [aquí](http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/appcenter/app-center-tutorial/). 

Puede añadir su aplicación al repositorio en el servidor utilizando la función **Publicar** en Digital App Builder.

>**Nota**: Asegúrese de que se aplicación se ha compilado sin ningún error antes de publicarla en App Center.

1. En su proyecto de aplicación, pulse **Publicar**. Se abrirá una ventana emergente con las plataformas seleccionadas. 

    ![Publicar](dab-publish.png)

2. Seleccione la **Plataforma** para la que necesita publicar su aplicación. 

3. Pulse **Suma de comprobación web** para habilitar la característica de suma de comprobación de recursos web. Para obtener más detalles, consulte [Habilitación de la característica de suma de comprobación de recursos web](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/application-development/cordova-apps/securing-apps/#enabling-the-web-resources-checksum-feature).

4. Pulse **Cifrado de recursos web** para cifrar los recursos web de sus paquetes Cordova.
Para obtener más detalles, consulte [Cifrado de los recursos web de sus paquetes Cordova](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/application-development/cordova-apps/securing-apps/#encrypting-the-web-resources-of-your-cordova-packages).

2. Pulse **Publicar en App Center**.

    ![Publicar en App Center](dab-publish-app-center.png)

3. Seleccione un App Center existente o pulse **Conectar nuevo**. Pulse **Conectar**.
4. Esto creará el paquete para la plataforma seleccionada. 
5. *Solo para iOS*: Edite el archivo *app-build.json* y actualice el campo `developmentTeam` con su ID de equipo de desarrolladores de Apple. Para obtener el ID de equipo, inicie sesión en la [Cuenta de desarrollador de Apple](https://developer.apple.com/account/#/membership). 

    ![Publicar iOS](dab-publish-ios.png)

6. Pulse **Publicar** cuando los paquetes estén listos. 
7. Una vez publicados correctamente, se genera el código QR. 

    ![Publicar en código QR de App Center](dab-publish-code-scan.png)

8. Puede verificar si la aplicación está disponible en App Center iniciando sesión en **App Center** > **Gestión de aplicaciones**.

>**Nota**: Puede volver a seleccionar la plataforma necesaria y compilar y publicar la aplicación en **App Center**.

### Publicar actualización directa 
{: #dab-publish-direct-update }

Con la [Actualización directa](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/application-development/direct-update/), se pueden actualizar las aplicaciones Cordova “over-the-air” con recursos web renovados, tales como lógica aplicativa modificada, fija o nueva (JavaScript), HTML, CSS o imágenes. De este modo, las organizaciones pueden asegurarse de que siempre utilizan la última versión de la aplicación. 

>**Nota**: Asegúrese de que se aplicación se ha compilado sin ningún error antes de publicarla en App Center.

1. En su proyecto de aplicación, pulse **Publicar**. Se abrirá una ventana emergente con las plataformas seleccionadas. 

    ![Publicar](dab-publish.png)

2. Seleccione la **Plataforma** para la que necesita publicar su aplicación. 

3. Pulse **Suma de comprobación web** para habilitar la característica de suma de comprobación de recursos web. Para obtener más detalles, consulte [Habilitación de la característica de suma de comprobación de recursos web](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/application-development/cordova-apps/securing-apps/#enabling-the-web-resources-checksum-feature).

4. Pulse **Cifrado de recursos web** para cifrar los recursos web de sus paquetes Cordova.
Para obtener más detalles, consulte [Cifrado de los recursos web de sus paquetes Cordova](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/application-development/cordova-apps/securing-apps/#encrypting-the-web-resources-of-your-cordova-packages).
5. Pulse **Publicar Direct Update**. Cuando los usuarios inician la aplicación para conectar con Mobile Foundation Server, se muestra una solicitud para actualizar los recursos web. Una vez confirmado, los recursos web actualizados estarán disponibles para el usuario.

