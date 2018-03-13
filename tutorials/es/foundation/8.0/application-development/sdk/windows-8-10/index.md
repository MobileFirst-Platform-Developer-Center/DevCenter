---
layout: tutorial
title: Adición del SDK de MobileFirst Foundation a aplicaciones Windows 8.1 Universal o Windows 10 UWP
breadcrumb_title: Windows
relevantTo: [windows]
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
El producto {{ site.data.keys.product }} SDK está formado por un conjunto de dependencias que están disponibles a través de [Nuget](https://www.nuget.org/) y que puede añadir a su proyecto de Visual Studio.
Las dependencias corresponden a funciones principales y a otras funciones:


* **IBMMobileFirstPlatformFoundation** - Implementa la conectividad de cliente a servidor, maneja la autenticación y los aspectos de seguridad, solicitudes de recursos y otras funciones básicas necesarias.


En esta guía de aprendizaje, aprenderá a añadir {{ site.data.keys.product_adj }} Native SDK mediante Nuget para una aplicación Windows 8.1 Universal o Windows 10 UWP (Universal Windows Platform) nueva o existente.
También aprenderá a configurar {{ site.data.keys.mf_server }} para que reconozca la aplicación, y para encontrar información sobre los archivos de configuración {{ site.data.keys.product_adj }} que se añaden al proyecto.


**Requisitos previos:**

- Microsoft Visual Studio 2013 o 2015 y {{ site.data.keys.mf_cli }} instalado en la estación de trabajo del desarrollador.
El desarrollo de una solución de Windows 10 UWP precisa como mínimo de Visual Studio 2015.

- Una instancia remota o local de {{ site.data.keys.mf_server }} que esté en ejecución.

- Lea las guías de aprendizaje [Configuración del entorno de desarrollo {{ site.data.keys.product_adj }}](../../../installation-configuration/development/mobilefirst) y [Configuración del entorno de desarrollo de Windows 8 Universal y Windows 10 UWP](../../../installation-configuration/development/windows).


#### Ir a:
{: #jump-to }
- [Adición de {{ site.data.keys.product_adj }} Native SDK](#adding-the-mobilefirst-native-sdk)
- [Adición manual de {{ site.data.keys.product_adj }} Native SDK](#manually-adding-the-mobilefirst-win-native-sdk)
- [Actualización de {{ site.data.keys.product_adj }} Native SDK](#updating-the-mobilefirst-native-sdk)
- [Artefactos de {{ site.data.keys.product_adj }} Native SDK generados](#generated-mobilefirst-native-sdk-artifacts)
- [Guías de aprendizaje con las que continuar](#tutorials-to-follow-next)

## Adición de {{ site.data.keys.product_adj }} Native SDK
{: #adding-the-mobilefirst-native-sdk }
Siga las instrucciones que hay más abajo para añadir {{ site.data.keys.product_adj }} Native SDK a un proyecto de Visual Studio nuevo o existente y para registrar la aplicación para {{ site.data.keys.mf_server }}.


Antes de empezar, asegúrese de que la instancia de {{ site.data.keys.mf_server }} está en ejecución.
  
Si está utilizando un servidor instalado localmente: Desde una ventana de **línea de mandatos**, vaya a la carpeta del servidor y ejecute el mandato: `.\run.cmd`.

### Creación de una aplicación
{: #creating-an-application }
Cree un proyecto de Windows 8.1 Universal o Windows 10 UWP mediante Visual Studio 2013/2015 o utilice un proyecto existente.
  

### Adición del SDK
{: #adding-the-sdk }
1. Utilice el gestor de paquetes NuGet para importar paquetes de {{ site.data.keys.product_adj }}.
NuGet es un gestor de paquetes para la plataforma de desarrollo de Microsoft, incluido .NET.
Las herramientas de cliente de NuGet proporcionan la posibilidad de crear y utilizar paquetes.
NuGet Gallery es el repositorio central de paquetes de todos los usuarios y creadores de paquetes.


2. Abra el proyecto de Windows 8.1 Universal o Windows 10 UWP en Visual Studio 2013/2015. Pulse con el botón derecho del ratón sobre la solución del proyecto y seleccione **Gestionar paquetes de Nuget**.

    ![Add-Nuget-tosolution-VS-settings](Add-Nuget-tosolution0.png)

3. La opción de búsqueda, busque "IBM MobileFirst Platform". Elija **IBM.MobileFirstPlatform.{{ site.data.keys.product_V_R_M_I }}**.

    ![Add-Nuget-tosolution-search](Add-Nuget-tosolution1.png)

    ![Add-Nuget-tosolution-choose](Add-Nuget-tosolution2.png)

4. Pulse **Instalar**. Esta acción instala {{ site.data.keys.product }} Native SDK y sus dependencias.
Este paso también genera un archivo `mfpclient.resw` vacío en la carpeta `strings` del proyecto Visual Studio.


5. Asegúrese de que, como mínimo, se han habilitado las siguientes funcionalidades en `Package.appxmanifest`:

    - Internet (Cliente)

### Adición manual de {{ site.data.keys.product_adj }} Native SDK
{: #manually-adding-the-mobilefirst-win-native-sdk }

También es posible añadir el SDK de {{ site.data.keys.product }}:


<div class="panel-group accordion" id="adding-the-win-sdk" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="win-sdk">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#win-sdk" data-target="#collapse-win-sdk" aria-expanded="false" aria-controls="collapse-win-sdk"><b>Pulse para obtener instrucciones</b></a>
            </h4>
        </div>

        <div id="collapse-win-sdk" class="panel-collapse collapse" role="tabpanel" aria-labelledby="win-sdk">
            <div class="panel-body">
                <p>Puede preparar su entorno para desarrollar aplicaciones MobileFirst obteniendo archivos de biblioteca e infraestructura de forma manual. {{ site.data.keys.product }} SDK para Windows 8 y Windows 10 Universal Windows Platform (UWP) también está disponible en NuGet.</p>

                <ol>
                    <li>Obtenga {{ site.data.keys.product }} SDK desde el separador <b>{{ site.data.keys.mf_console }} → Centro de descargas → SDK</b>. </li>
                    <li>Extraiga el contenido del SDK descargado en el paso 1. </li>
                    <li>Abra el proyecto nativo de Windows Universal en Visual Studio. Siga los siguientes pasos.
                        <ol>
                            <li>Seleccione <b>Herramientas → Gestor de paquetes NuGet → Valores del gestor de paquetes</b>.</li>
                            <li>Seleccione la opción de <b>Orígenes de paquetes</b>. Pulse el icono <b>+</b> para añadir un nuevo origen de paquetes. </li>
                            <li>Proporcione un nombre para el origen de paquete (por ejemplo: <em>windows8nuget</em>)</li>
                            <li>Vaya hasta la carpeta del SDK de MobileFirst que se descargó y extrajo. Pulse <b>Aceptar</b>. </li>
                            <li>Pulse <b>Actualizar</b> y, a continuación, pulse <b>Aceptar</b>. </li>
                            <li>Pulse con el botón derecho del ratón en <b>Nombre proyecto de solución</b> en el separador del <b>Explorador de soluciones</b>, que está en la esquina derecha de la pantalla. </li>
                            <li>Seleccione <b>Gestionar paquetes de NuGet para soluciones → En línea → windows8nuget</b>.</li>
                            <li>Pulse la opción <b>Instalar</b>. Obtendrá la opción de <b>Seleccionar proyectos</b>.</li>
                            <li>Asegúrese de que se seleccionan todos los recuadros de selección. Pulse <b>Aceptar</b>. </li>
                        </ol>

                    </li>
                </ol>

                <br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#win-sdk" data-target="#collapse-win-sdk" aria-expanded="false" aria-controls="collapse-win-sdk"><b>Sección de cierre</b></a>
            </div>
        </div>
    </div>
</div>

### Registro de la aplicación
{: #reigstering-the-application }
1. Abra una ventana de **línea de mandatos** y vaya a la raíz del proyecto Visual Studio.
  

2. Ejecute el mandato:


   ```bash
   mfpdev app register
   ```
    - Si se utiliza un servidor remoto, [utilice el mandato `mfpdev server add`](../../using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance) para añadirlo.


El mandato de interfaz de línea de mandatos (CLI) `mfpdev app register` primero se conecta a {{ site.data.keys.mf_server }} para registrar la aplicación, a continuación actualiza el archivo **mfpclient.resw** en la carpeta **strings** en el proyecto Visual Studio y lo añade a los metadatos que {{ site.data.keys.mf_server }} identifica.


> <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> **Sugerencia:** También es posible registrar aplicaciones desde {{ site.data.keys.mf_console }}:    
>
> 1. Cargue {{ site.data.keys.mf_console }}.  
> 2. Pulse el botón **Nuevo** junto a **Aplicaciones** para registrar una nueva aplicación y seguir las instrucciones en la pantalla.
  
> 3. Después de que se registre la aplicación, vaya al separador **Archivos de configuración** y copie o descargue el archivo **mfpclient.resw**.
Siga las instrucciones en la pantalla para añadir el archivo al proyecto.



## Actualización de {{ site.data.keys.product_adj }} Native SDK
{: #updating-the-mobilefirst-native-sdk }
Para actualizar {{ site.data.keys.product_adj }} Native SDK con el último release, ejecute el siguiente mandato desde la carpeta raíz del proyecto Visual Studio en una ventana de **línea de mandatos**:


```bash
Nuget update
```

## Artefactos de {{ site.data.keys.product_adj }} Native SDK generados
{: #generated-mobilefirst-native-sdk-artifacts }
### mfpclient.resw
{: #mfpclientresw }
Ubicado en la carpeta `strings` del proyecto, este archivo contiene propiedades de conectividad de servidor y lo puede editar el usuario: 

- `protocol` – Protocolo de comunicación para {{ site.data.keys.mf_server }}. Puede ser `HTTP` o `HTTPS`.
- `WlAppId` - Identificador de la aplicación.
Debería ser el mismo que el identificador de aplicación en el servidor.

- `host` – Nombre de host de la instancia de {{ site.data.keys.mf_server }}.

- `port` – Puerto raíz de la instancia de {{ site.data.keys.mf_server }}.

- `wlServerContext` – Vía de acceso raíz de contexto de la aplicación en la instancia de {{ site.data.keys.mf_server }}.

- `languagePreference` - Establece el idioma predeterminado para los mensajes de sistema del SDK de cliente. 

## Guías de aprendizaje con las que continuar 
{: #tutorials-to-follow-next }
Con MobileFirst Native SDK ahora integrado, podrá:


- Revisar las guías de aprendizaje de [Utilización de {{ site.data.keys.product }} SDK](../)
- Revisar las guías de aprendizaje de [Desarrollo de adaptadores](../../../adapters/)
- Revisar las guías de aprendizaje de [Autenticación y seguridad](../../../authentication-and-security/)
- Revisar las guías de aprendizaje de [Notificaciones](../../../notifications/) 
- Revisar [Todas las guías de aprendizaje](../../../all-tutorials)
