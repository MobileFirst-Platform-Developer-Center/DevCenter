---
layout: tutorial
title: Adición del SDK de MobileFirst Foundation a aplicaciones iOS
breadcrumb_title: iOS
relevantTo: [ios]
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
El SDK de MobileFirst Foundation está formado por un conjunto de pods disponibles a través de [CocoaPods](http://guides.cocoapods.org) que se pueden añadir a su proyecto Xcode.
  
Los pods corresponden a funciones principales y a otras funciones:


* **IBMMobileFirstPlatformFoundation** - Implementa la conectividad de cliente a servidor, maneja la autenticación y los aspectos de seguridad, solicitudes de recursos y otras funciones básicas necesarias.

* **IBMMobileFirstPlatformFoundationJSONStore** - Contiene la infraestructura de JSONStore. Para obtener más información, revise la [guía de aprendizaje JSONStore para iOS](../../jsonstore/ios/).

* **IBMMobileFirstPlatformFoundationPush** - Contiene la infraestructura de notificaciones push.
Para obtener más información, revise las [guías de aprendizajes de notificaciones](../../../notifications/).
* **IBMMobileFirstPlatformFoundationWatchOS** - Contiene soporte para Apple WatchOS.

En esta guía de aprendizaje aprenderá a añadir MobileFirst Native SDK mediante CocoaPods a una aplicación iOS nueva o ya existente.
También aprenderá a configurar {{ site.data.keys.mf_server }} para que reconozca la aplicación.


**Requisitos previos:**

- Xcode y MobileFirst CLI instalado en la estación de trabajo del desarrollador.
  
- Una instancia remota o local de {{ site.data.keys.mf_server }} que esté en ejecución.

- Lea las guías de aprendizaje [Configuración de su entorno de desarrollo MobileFirst](../../../installation-configuration/development/mobilefirst) y [Configuración del entorno de desarrollo iOS](../../../installation-configuration/development/ios).


> **Nota:** La funcionalidad de **compartición de cadena de claves** es obligatoria al ejecutar aplicaciones iOS en simuladores mediante XCode 8.

#### Ir a:
{: #jump-to }
- [Adición de MobileFirst Native SDK](#adding-the-mobilefirst-native-sdk)
- [Adición manual de MobileFirst Native SDK](#manually-adding-the-mobilefirst-native-sdk)
- [Adición de soporte para Apple watchOS](#adding-support-for-apple-watchos)
- [Actualización de MobileFirst Native SDK](#updating-the-mobilefirst-native-sdk)
- [Artefactos de MobileFirst Native SDK generados](#generated-mobilefirst-native-sdk-artifacts)
- [Bitcode y TLS 1.2](#bitcode-and-tls-12)
- [Guías de aprendizaje con las que continuar](#tutorials-to-follow-next)

## Adición de {{ site.data.keys.product_adj }} Native SDK
{: #adding-the-mobilefirst-native-sdk }
Siga las instrucciones que hay más abajo para añadir {{ site.data.keys.product }} Native SDK a un proyecto de Xcode nuevo o existente y para registrar la aplicación para {{ site.data.keys.mf_server }}.


Antes de empezar, asegúrese de que {{ site.data.keys.mf_server }} está en ejecución.
  
Si está utilizando un servidor instalado localmente: Desde una ventana de **línea de mandatos**, vaya a la carpeta del servidor y ejecute el mandato: `./run.sh`.

### Creación de una aplicación
{: #creating-an-application }
Cree un proyecto Xcode o utilice uno existente (Swift o Objective-C).  

### Adición del SDK
{: #adding-the-sdk }
1. {{ site.data.keys.product }} Native SDK se proporciona a través de CocoaPods.
    - Si [CocoaPods](http://guides.cocoapods.org) ya está instalado en su entorno de desarrollo, vaya al paso 2.

    - Si CocoaPods no está instalado, instálelo tal como se indica a continuación:
  
        - Abra una **línea de mandatos** y vaya a la raíz del proyecto Xcode.

        - Ejecute el mandato:
`sudo gem install cocoapods` seguido por `pod setup`. **Nota:** Estos mandatos podrían tardar varios minutos en completarse.

2. Ejecute el mandato: `pod init`. Este mandato crea un `Podfile`.
3. Con la ayuda de su editor preferido, abra el `Podfile`.
    - Comente o suprima el contenido del archivo. 
    - Añada las líneas siguientes y guarde los cambios:


      ```xml
      use_frameworks!

      platform :ios, 8.0
      target "Xcode-project-target" do
          pod 'IBMMobileFirstPlatformFoundation'
      end
      ```
      - Sustituya **Xcode-project-target** con el nombre de su destino del proyecto Xcode.


4. De nuevo en la línea de mandatos, ejecute los mandatos `pod install`, seguidos por `pod update`.
Estos mandatos añaden los archivos de {{ site.data.keys.product }} Native SDK, añaden el archivo **mfpclient.plist** y generan un proyecto Pod.
  
    **Nota:** Los mandatos puede tardar unos minutos en completarse.

    > <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> **Importante**: A partir de aquí, utilice el archivo `[NombreProyecto].xcworkspace` para abrir el proyecto en Xcode.
**No** utilice el archivo `[NombreProyecto].xcodeproj`.
Un proyecto basado en CocoaPods está gestionado como un espacio de trabajo con la aplicación (el ejecutable) y la biblioteca (todas las dependencias de proyecto recuperadas por el gestor de CocoaPods).


### Adición manual de {{ site.data.keys.product_adj }} Native SDK
{: #manually-adding-the-mobilefirst-native-sdk }
También es posible añadir el SDK de {{ site.data.keys.product }}:


<div class="panel-group accordion" id="adding-the-sdk-manually" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="ios-sdk">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#ios-sdk" data-target="#collapse-ios-sdk" aria-expanded="false" aria-controls="collapse-ios-sdk"><b>Pulse para obtener instrucciones</b></a>
            </h4>
        </div>

        <div id="collapse-ios-sdk" class="panel-collapse collapse" role="tabpanel" aria-labelledby="ios-sdk">
            <div class="panel-body">
                <p>Para añadir de forma manual el SDK de {{ site.data.keys.product }}, descargue primero el archivo .zip SDK desde el separador <b>{{ site.data.keys.mf_console }} → Centro de descargas → SDK</b>. </p>

                <ul>
                    <li>En su proyecto Xcode, añada los archivos de infraestructura de {{ site.data.keys.product }} para su proyecto.
                        <ul>
                            <li>Seleccione el icono de raíz de proyecto en el explorador de proyectos. </li>
                            <li>Seleccione <b>Archivo → Añadir archivos</b> y vaya a la carpeta que contiene los archivos de infraestructura descargados con anterioridad. </li>
                            <li>Pulse el botón <b>Opciones</b>. </li>
                            <li>Seleccione <b>Copiar elementos si es necesario</b> y <b>Crear grupos para las carpetas añadidas</b>. <br/>
                            <b>Nota:</b> Si no selecciona la opción <b>Copiar elementos si es necesario</b>, los archivos de infraestructura no se copian sino que se enlazan desde su ubicación inicial. </li>
                            <li>Seleccione el proyecto principal (primera opción) y seleccione el destino de aplicación. </li>
                            <li>En el separador <b>General</b>, elimine las infraestructuras que se añadirían de forma automática a <b>Bibliotecas e infraestructuras enlazadas</b>.  </li>
                            <li>Necesario: En <b>Binarios incluidos</b>, añada las siguientes infraestructuras:
                                <ul>
                                    <li>IBMMobileFirstPlatformFoundation.framework</li>
                                    <li>IBMMobileFirstPlatformFoundationOpenSSLUtils.framework</li>
                                    <li>IBMMobileFirstPlatformFoundationWatchOS.framework</li>
                                </ul>
                            Al realizar este paso cargará automáticamente estas infraestructuras a las <b>Bibliotecas e infraestructuras enlazadas</b>.
                            </li>
                            <li>En <b>Bibliotecas e infraestructuras enlazadas</b>, añada las siguientes infraestructuras:
                                <ul>
                                    <li>IBMMobileFirstPlatformFoundationJSONStore.framework</li>
                                    <li>sqlcipher.framework</li>
                                    <li>openssl.framework</li>
                                    <li>Localizations.bundle</li>
                                </ul>
                            </li>
                            <blockquote><b>Nota:</b> Estos pasos copian las infraestructuras de {{ site.data.keys.product }} relevantes de su proyecto y las enlazan dentro de la lista de Enlazar binario con Bibliotecas en el separador de Fases de compilación. Si enlaza los archivos a su ubicación original (sin elegir la opción Copiar elementos si es necesario tal como se describió con anterioridad), necesitará establecer las Vías de acceso de búsqueda de infraestructura tal como se describe a continuación. </blockquote>
                        </ul>
                    </li>
                    <li>Las infraestructuras añadidas en el Paso 1, se deberían añadir de forma automática a la sección <b>Enlazar binario con bibliotecas</b>, en el separador <b>Fases de compilación</b>. </li>
                    <li><i>Opcional:</i> Si no copió los archivos de infraestructura en su proyecto tal como se describió con anterioridad, siga los siguientes pasos utilizando la opción <b>Copiar elementos si es necesario</b>, en el separador <b>Fases de compilación</b>.
                        <ul>
                            <li> Abra la página <b>Valores de compilación</b>. </li>
                            <li>Encuentre la sección <b>Vías de acceso de búsqueda</b>. </li>
                            <li>Añada la vía de acceso de la carpeta que continúe las infraestructuras a la carpeta <b>Vías de acceso de búsqueda de infraestructura</b>. </li>
                        </ul>
                    </li>
                    <li>En la sección <b>Despliegue</b> del separador <b>Valores de compilación</b>, seleccione un valor para el campo <b>Destino de despliegue de iOS</b> que sea mayor o igual a 8.0.  </li>
                    <li><i>Opcional:</i> A partir de Xcode 7, bitcode se establece como predeterminado. Para conocer las limitaciones y requisitos consulte <a href="additional-information/#working-with-bitcode-in-ios-apps">Trabajar con bitcode en aplicaciones iOS</a>. Para inhabilitar el bitcode:
                        <ul>
                            <li>Abra la sección <b>Opciones de compilación</b>. </li>
                            <li>Establezca <b>Habilitar bitcode</b> en <b>No</b>.</li>
                        </ul>
                    </li>
                    <li>A partir de Xcode 7, se debe utilizar de forma obligatoria TLS. Consulte <a href="additional-information/#enforcing-tls-secure-connections-in-ios-apps">Imposición de conexiones seguras TLS en aplicaciones iOS</a>. </li>
                </ul>

                <br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#ios-sdk" data-target="#collapse-ios-sdk" aria-expanded="false" aria-controls="collapse-ios-sdk"><b>Sección de cierre</b></a>
            </div>
        </div>
    </div>
</div>

### Registro de la aplicación
{: #registering-the-application }
1. Abra una **línea de mandatos** y vaya a la raíz del proyecto Xcode.
  

2. Ejecute el mandato:


    ```bash
    mfpdev app register
    ```
    - Si se utiliza un servidor remoto, [utilice el mandato `mfpdev server add`](../../using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance) para añadirlo.


    Se le solicitará proporcionar el BundleID de la aplicación.
**Importante**: El BundleID es **sensible a las mayúsculas y minúsculas**.
  

El mandato de interfaz de línea de mandatos (CLI) `mfpdev app register` se conecta primero a {{ site.data.keys.mf_server }} para registrar la aplicación, a continuación genera el archivo **mfpclient.plist** en la raíz del proyecto Xcode y lo añade a los metadatos que identifican a {{ site.data.keys.mf_server }}.
  

> <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> **Sugerencia:** También es posible registrar aplicaciones desde {{ site.data.keys.mf_console }}:    
>
> 1. Cargue {{ site.data.keys.mf_console }}.
> 2. Pulse el botón **Nuevo** junto a **Aplicaciones** para registrar una nueva aplicación y seguir las instrucciones en la pantalla.
  
> 3. Después de que se registre la aplicación, vaya al separador **Archivos de configuración** y copie o descargue el archivo **mfpclient.plist**.
Siga las instrucciones en la pantalla para añadir el archivo al proyecto.



### Completar el proceso de configuración
{: #completing-the-setup-process }
En Xcode, pulse con el botón derecho del ratón en la entrada del proyecto, pulse **Añadir archivos a [NombreProyecto]** y seleccione el archivo **mfpclient.plist**, ubicado en la raíz del proyecto Xcode.


### Cómo hacer referencia al SDK
{: #referencing-the-sdk }
Siempre que utilice el {{ site.data.keys.product }} Native SDK, asegúrese de importar la infraestructura de {{ site.data.keys.product }}:


Objective-C:

```objc
#import <IBMMobileFirstPlatformFoundation/IBMMobileFirstPlatformFoundation.h>
```

Swift:

```swift
import IBMMobileFirstPlatformFoundation
```

<br>
#### Nota acerca de iOS 9 y superior: 
{: #note-about-ios-9-and-above }
> A partir de Xcode 7, [ATS (Application Transport Security)](https://developer.apple.com/library/ios/releasenotes/General/WhatsNewIniOS/Articles/iOS9.html#//apple_ref/doc/uid/TP40016198-SW14) está habilitado de forma predeterminada.
Con el propósito de ejecutar aplicaciones durante el desarrollo, puede inhabilitar ATS ([pulse aquí para obtener más información](http://iosdevtips.co/post/121756573323/ios-9-xcode-7-http-connect-server-error)).
>   1. En Xcode, pulse con el botón derecho del ratón sobre **archivo [proyecto]/info.plist → Abrir como → Código fuente**
>   2. Pegue lo siguiente:

>
```xml
>      <key>NSAppTransportSecurity</key>
>      <dict>
>            <key>NSAllowsArbitraryLoads</key>
>            <true/>
>      </dict>
```

## Adición de soporte para Apple watchOS
{: #adding-support-for-apple-watchos}
Si está desarrollando para Apple watchOS 2 y posterior, el Podfile debe contener secciones que correspondan a la aplicación principal y la extensión watchOS.
Consulte el siguiente ejemplo para watchOS 2:

```xml
# Replace with the name of your watchOS application
xcodeproj 'MyWatchApp'

use_frameworks!

#use the name of the iOS target
target :MyWatchApp do
    platform :ios, 9.0
    pod 'IBMMobileFirstPlatformFoundation'
    end

#use the name of the watch extension target
target :MyWatchApp WatchKit Extension do
    platform :watchos, 2.0
    pod 'IBMMobileFirstPlatformFoundation'
end
```

Verifique que el proyecto Xcode está cerrado y ejecute el mandato `pod install`.


## Actualización de {{ site.data.keys.product_adj }} Native SDK
{: #updating-the-mobilefirst-native-sdk }
Para actualizar {{ site.data.keys.product }} Native SDK con el último release, ejecute el siguiente mandato desde la carpeta raíz del proyecto Xcode en una ventana de **línea de mandatos**:


```bash
pod update
```

Los releases de SDK se pueden encontrar en el [repositorio CocoaPods](https://cocoapods.org/?q=ibm%20mobilefirst) de SDK.


## Artefactos de {{ site.data.keys.product_adj }} Native SDK generados
{: #generated-mobilefirst-native-sdk-artifacts }
### mfpclient.plist
{: #mfpclientplist }
Ubicado en la raíz del proyecto, este archivo define las propiedades del lado del cliente utilizadas para registrar la aplicación iOS en {{ site.data.keys.mf_server }}.


| Propiedad | Descripción | Valores de ejemplo |
|---------------------|---------------------------------------------------------------------|----------------|
| protocol    | Protocolo de comunicación con {{ site.data.keys.mf_server }}.             | http o https  |
| host        | Nombre de host de {{ site.data.keys.mf_server }}.                            | 192.168.1.63   |
| port        | Puerto de {{ site.data.keys.mf_server }}.                           | 9080           |
| wlServerContext     | Vía de acceso de raíz de contexto de la aplicación en {{ site.data.keys.mf_server }}. | /mfp/          |
| languagePreferences | Establece el idioma predeterminado para los mensajes de sistema del SDK de cliente. | en             |

## Bitcode y TLS 1.2
{: #bitcode-and-tls-12 }
Para obtener información sobre el soporte a bitcode y TLS 1.2 consulte la página de [Información adicional](additional-information).


## Guías de aprendizaje con las que continuar 
{: #tutorials-to-follow-next }
Con {{ site.data.keys.product }} Native SDK ahora integrado, podrá:


- Revisar las guías de aprendizaje de [Utilización de {{ site.data.keys.product }} SDK](../)
- Revisar las guías de aprendizaje de [Desarrollo de adaptadores](../../../adapters/)
- Revisar las guías de aprendizaje de [Autenticación y seguridad](../../../authentication-and-security/)
- Revisar las guías de aprendizaje de [Notificaciones](../../../notifications/) 
- Revisar [Todas las guías de aprendizaje](../../../all-tutorials)
