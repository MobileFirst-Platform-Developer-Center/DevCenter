---
layout: tutorial
title: Adición del SDK de MobileFirst Foundation a aplicaciones Xamarin
breadcrumb_title: Xamarin
relevantTo: [xamarin]
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview
El SDK {{ site.data.keys.product }} consiste en una colección de dependencias que están empaquetadas en un paquete NuGet que puede añadirse a un proyecto Xamarin desde [Nuget Package Manager](https://www.nuget.org/packages?q=mobilefirst) .

Los paquetes corresponden a las funciones principales y a otras funciones:

* **IBM.MobileFirstPlatformFoundation**: Contiene bibliotecas sdk de cliente MobileFirst que implementan conectividad de cliente a servidor, maneja aspectos de autenticación y seguridad, solicitudes de recursos y otras funciones principales requeridas con el entorno
JSONStore.
 
* **IBM.MobileFirstPlatformFoundationPush** - Contiene la infraestructura de notificación de push. Para obtener más información, revise las [guías de aprendizajes de notificaciones](../../../notifications/).

En este tutorial aprenderá a añadir {{ site.data.keys.product_adj }} Native SDK mediante NuGet Package Manager a una aplicación
Xamarin.Android o Xamarin.iOS nueva o existente. También aprenderá a configurar {{ site.data.keys.mf_server }} para que reconozca la aplicación.


**Requisitos previos:**

- Visual Studio 2017 instalado en la estación de trabajo del desarrollador para macOS .
- Versión de Community de Visual Studio 2015 o Visual Studio 2017 instalada en la estación de trabajo de desarrollo para Windows OS . Asegúrese de que no está utilizando la edición Express de Visual Studio. En este caso, se recomienda que actualice a Community Edition .  
- Una instancia remota o local de {{ site.data.keys.mf_server }} que esté en ejecución.

- Lea las guías de aprendizaje [Configuración del entorno de desarrollo de {{ site.data.keys.product_adj }}](../../../installation-configuration/development/) y [Configuración del entorno de desarrollo de Xamarin](../../../installation-configuration/development/xamarin/).


#### Ir a:
{: #jump-to }
- [Adición de {{ site.data.keys.product_adj }} Native SDK](#adding-the-mobilefirst-native-sdk)
- [Actualización de {{ site.data.keys.product_adj }} Native SDK](#updating-the-mobilefirst-native-sdk)
- [Guías de aprendizaje con las que continuar](#tutorials-to-follow-next)

## Adición de {{ site.data.keys.product_adj }} Native SDK
{: #adding-the-mobilefirst-native-sdk }
Siga las instrucciones que hay más abajo para añadir {{ site.data.keys.product_adj }} Native SDK a un proyecto de Xcode nuevo o existente y para registrar la aplicación para {{ site.data.keys.mf_server }}.


Antes de empezar, asegúrese de que {{ site.data.keys.mf_server }} está en ejecución.
  
Si está utilizando un servidor instalado localmente: Desde una ventana de **línea de mandatos**, vaya a la carpeta del servidor y ejecute el mandato: `./run.sh`.

### Creación de una aplicación
{: #creating-an-application }
Cree una solución Xamarin mediante Xamarin Studio, Visual Studio o utilice uno que ya exista.


### Adición del SDK
{: #adding-the-sdk }
1. El SDK nativo {{ site.data.keys.product_adj }} se proporciona a través de Nuget Gallery/Repository.
2. Para importar los paquetes de MobileFirst packages, utilice el gestor de paquetes NuGet. NuGet es un gestor de paquetes para la plataforma de desarrollo de Microsoft, incluido .NET.
Las herramientas de cliente de NuGet proporcionan la posibilidad de crear y utilizar paquetes.
NuGet Gallery es el repositorio central de paquetes de todos los usuarios y creadores de paquetes.
Pulse con el botón derecho del ratón en el directorio de paquetes, seleccione Añadir paquetes y en la opción de búsqueda, busque *IBM MobileFirst Platform*. Seleccione **IBM.MobileFirstPlatformFoundation**.
![Adición de sdk desde nuget.org]({{site.baseurl}}/assets/xamarin-tutorials/add-package1.png)
3. Pulse los paquetes para añadir. Con esta acción se instala Mobile Foundation Native SDK y sus dependencias.
![Adding sdk from nuget.org]({{site.baseurl}}/assets/xamarin-tutorials/add-package2.png)


### Registro de la aplicación
{: #registering-the-application }
1. Cargue {{ site.data.keys.mf_console }}.
2. Pulse el botón Nuevo junto a Aplicaciones para registrar una nueva aplicación y seguir las instrucciones en la pantalla.

3. Las aplicaciones Android e iOS se deben registrar de forma independiente.
Así se asegura que tanto la aplicación Android como la aplicación iOS se pueden conectar de forma satisfactoria al servidor.
Los detalles de registro para las aplicaciones Android e iOS se pueden entrar en `AndroidManifest.xml` e `Info.plist` respectivamente.

3. Después de registrar la aplicación, navegue a la ficha Archivos de configuración de la aplicación y copie o descargue los archivos`mfpclient.plist` y `mfpclient.properties`. Siga las instrucciones en la pantalla para añadir el archivo al proyecto.



### Completar el proceso de configuración
{: #completing-the-setup-process }
#### mfpclient.plist
{: #complete-setup-mfpclientplist }
1. Pulse con el botón derecho del ratón sobre el proyecto Xamarin iOS y seleccione **Añadir archivos...**. Navegue hasta encontrar `mfpclient.plist` para añadirlo a la raíz del proyecto.
Elija **Copiar archivo a proyecto** si así se le solicita. 
2. Pulse con el botón derecho sobre el archivo `mfpclient.plist` y seleccione **Acción de compilación**. Elija **Contenido**.

#### mfpclient.properties
{: #mfpclientproperties }
1. Pulse con el botón derecho del ratón sobre la carpeta de *Activos* del proyectoXamarin Android y seleccione **Añadir archivos...**. Navegue hasta encontrar `mfpclient.properties` para la carpeta.
Elija **Copiar archivo a proyecto** si así se le solicita. 
2. Pulse con el botón derecho sobre el archivo `mfpclient.properties` y seleccione **Acción de compilación**. Elija **Activo Android**.

### Cómo hacer referencia al SDK
{: #referencing-the-sdk }
Siempre que utilice el {{ site.data.keys.product_adj }} Native SDK, asegúrese de importar la infraestructura de {{ site.data.keys.product }}:


CommonProject:

```csharp
using Worklight;
```

iOS:

```csharp
using MobileFirst.Xamarin.iOS;
```

Android:

```csharp
using Worklight.Xamarin.Android;
```

## Actualización de {{ site.data.keys.product_adj }} Native SDK
{: #updating-the-mobilefirst-native-sdk }
Para actualizar {{ site.data.keys.product_adj }} Native SDK con la última publicación, actualice la versión de SDK a través de Nuget Gallery.

## Artefactos de {{ site.data.keys.product_adj }} Native SDK generados
{: #generated-mobilefirst-native-sdk-artifacts }
### mfpclient.plist
{: #mfpclientplist }
Este archivo define las propiedades del lado del cliente utilizadas para registrar la aplicación iOS en {{ site.data.keys.mf_server }}.


|Propiedad |Descripción |Valores de ejemplo |
|---------------------|---------------------------------------------------------------------|----------------|
|protocol    |Protocolo de comunicación con {{ site.data.keys.mf_server }}.             |http o https  |
|host        |Nombre de host de {{ site.data.keys.mf_server }}.                            |192.168.1.63   |
|port        |Puerto de {{ site.data.keys.mf_server }}.                           |9080           |
|wlServerContext     |Vía de acceso de raíz de contexto de la aplicación en {{ site.data.keys.mf_server }}. |/mfp/          |
|languagePreferences |Establece el idioma predeterminado para los mensajes de sistema del SDK de cliente. |en             |

## Guías de aprendizaje con las que continuar 
{: #tutorials-to-follow-next }
Con {{ site.data.keys.product_adj }} Native SDK ahora integrado, podrá:


- Revisar las guías de aprendizaje de [Desarrollo de adaptadores](../../../adapters/)
- Revisar las guías de aprendizaje de [Autenticación y seguridad](../../../authentication-and-security/)
- Revisar las guías de aprendizaje de [Notificaciones](../../../notifications/) 
- Revisar [Todas las guías de aprendizaje](../../../all-tutorials)
