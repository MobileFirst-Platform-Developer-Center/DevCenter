---
layout: tutorial
title: Interfaz de Digital App Builder
weight: 4
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## Interfaz de Digital App Builder
{: #digital-app-builder-interface }

En función de la modalidad seleccionada (Diseño/Código), se muestra la interfaz de Digital App Builder. 

### Interfaz de Digital App Builder en modalidad de Diseño 

![Interfaz de Digital App Builder en modalidad de Diseño](dab-workbench-elements.png)

La interfaz de Digital App Builder está formada por los siguientes elementos en el panel de navegación izquierdo: 

* **Entorno de trabajo** - visualiza u oculta los detalles de la página
* **Datos** - ayudan a añadir un conjunto de datos conectándose a un origen de datos existente o creando un origen de datos para un microservicio utilizando el documento de OpenAPI.  
* **Watson** - consta de los componentes Image Recognition y Chatbot (Watson Assistant) para configurar una instancia existente o crear una nueva instancia.  
* **Compromiso** - puede aumentar la involucración del usuario con la aplicación añadiendo servicios de notificación push y utilizar la característica Live Update para mostrar/ocultar controles y páginas o para cambiar sus propiedades cuando la aplicación esté activa.
* **Consola** - muestra la consola para ver las actividades.  
* **Parámetros** - muestra los detalles de la aplicación, la información del servidor, los plugins y la reparación del proyecto (como, por ejemplo, Reconstrucción de dependencias, Reconstrucción de plataformas y Restablecimiento de credenciales de IBM Cloud), habilitar o inhabilitar análisis.

#### Entorno de trabajo 
{: #workbench }

El entorno de trabajo le ayuda a diseñar las páginas. El entorno de trabajo consta de tres áreas de trabajo:

![Entorno de trabajo](dab-workbench.png)

1. **Páginas/Controles**: Esta área muestra el nombre de las páginas creadas de forma predeterminada. Utilice el signo **+** para crear una nueva página. Al pulsar el icono **Controles**, se visualizan los controles que ayudan a añadir funcionalidades a una página de una aplicación. Puede arrastrar y soltar los controles desde la respectiva paleta de controles al lienzo de la página. Cada control tiene un conjunto de propiedades y acciones. Puede modificar las propiedades de cada uno de los controles seleccionados. 

    A continuación se muestra la lista de controles proporcionados: 
    * **Básico**: Puede arrastrar y soltar estos controles básicos (Botón, Cabecera, Imagen y Etiqueta) en el lienzo y configurar las propiedades y las acciones.

        ![Páginas / Controles](dab-workbench-basic-controls.png)

        * **Botón** - Los botones tienen una propiedad para etiquetar. En el separador Acción, puede especificar la página a la que navegar al pulsar el botón. 
        * **Texto de cabecera** - Añade un texto de cabecera para la aplicación como, por ejemplo, Título de página.
        * **Imagen** - Permite cargar una imagen local o proporcionar un URL de una imagen.
        * **Etiqueta** - Añade texto estático a su cuerpo de página. 
    * **Enlace de datos** - Conecta con un conjunto de datos y trabaja con las entidades en el conjunto de datos. Un enlace de datos está formado por dos componentes: **Lista** y **Etiquetas conectadas**. 

        ![Controles de enlace de datos](dab-workbench-databound-controls.png)

        * **Lista** - Cree una nueva página y arrastre y suelte el componente Lista. Añada el **Título de lista**, elija el tipo de lista en el que trabajar, añada el contenido con el que trabajar y seleccione el conjunto de datos que desee utilizar. 

        Para obtener más información sobre cómo añadir un **Conjunto de datos**, consulte [aquí](../how-to-add-dataset/).

    * **Inicio de sesión** - El inicio de sesión está formado por el control **Formulario de inicio de sesión**.  
 
        El control de formulario de inicio de sesión le ayuda a crear una página de inicio de sesión para la aplicación para conectar el usuario al servidor de Mobile Foundation. El servidor de Mobile Foundation proporciona una infraestructura de seguridad para autenticar a los usuarios y proporcionar este contexto de seguridad para acceder a los conjuntos de datos. Para obtener más información lea [aquí](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/authentication-and-security/creating-a-security-check/). 

        ![Formulario de inicio de sesión](dab-workbench-login-control.png)

        Para obtener más información sobre cómo añadir un **Formulario de inicio de sesión**, consulte [aquí](../how-to-login/).

    * **IA** - IA controla la adición de funcionalidades de inteligencia artificial de Watson para su aplicación. 

        * **Chat de Watson** - Este control proporciona una interfaz de conversación completa que se puede respaldar con el servicio de Watson Assistant en IBM Cloud.  

            ![Watson Assistant](dab-workbench-ai-watson-chat.png)

            * En la sección de propiedades, seleccione el servicio de Watson Assistant configurado y seleccione el espacio de trabajo al que desea conectarse. Para definir y entrenar una conversación de Chat, consulte [Chatbot](../how-to-chatbot/) bajo Watson.

        * **Watson Visual Recognition** - Este control proporciona la posibilidad de tomar una foto y hacer que Watson Visual Recognition la identifique. 
         
            ![Watson Visual Recognition](dab-workbench-ai-watson-vr.png)
 
            *  En la sección de propiedades, seleccione el servicio Visual Recognition configurado y el modelo de clasificación. Para definir y entrenar utilizando sus propias imágenes, consulte [Reconocimiento de imágenes](../how-to-image-recognition/) bajo Watson.

2. Sección del **Lienzo** - Esta área está formada por el Canal actual seleccionado, el nombre de Página actual y el Lienzo.  

    * Icono **Canal** - Visualiza el canal actualmente seleccionado. Se pueden añadir canales adicionales seleccionando los canales necesarios en la sección Plataformas bajo **Parámetros > Aplicación > Detalles de aplicación**. 
    * Nombre de página actual - Muestra el nombre de página del lienzo. Cuando se conmuta entre páginas, el nombre de la página actual se actualiza con la página seleccionada. 
    * **Compilar/Vista previa de aplicación** - Este botón tiene dos opciones:a. ayuda a obtener la vista previa de la aplicación que está desarrollando; b. compila la aplicación.
    * **Publicar aplicación** - Esta opción le ayuda a crear y publicar su aplicación para Android/iOS en App Center.
    * **Lienzo** - En el centro de esta sección se encuentra el lienzo, que muestra el diseño o el código. Arrastre y suelte los controles para crear la aplicación.

3. Separador **Propiedades/Acciones** - En el lado derecho se encuentra el separador de propiedades y acciones. Cuando se coloca un control en el lienzo, puede editar y modificar las propiedades del control y conectarlo con una acción relacionada para que la ejecute. 

#### Datos
{: #dataset-integration}

Puede crear el conjunto de datos para un microservicio y después crear el conjunto de datos, puede conectar los controles de enlace de datos en su aplicación. 

Para obtener más información sobre cómo añadir un **Conjunto de datos**, consulte [aquí](../how-to-add-dataset/).

#### Watson
{: #integrating-with-watson-services}

Digital App Builder proporciona la posibilidad de configurar la aplicación para conectarla a los distintos servicios de Watson proporcionados en IBM Cloud.

#### Compromiso
{: #engagement}

Puede añadir notificaciones push a su aplicación y aumentar la involucración del usuario o utilizar la característica Live Update para mostrar/ocultar controles y páginas o cambiar sus propiedades cuando la aplicación esté activa. 

#### Consola
{: #console }

Ayuda a visualizar el código de cada uno de los componentes. También muestra la información sobre diversas actividades y errores.

#### Parámetros
{: #settings}

Los parámetros sirven para gestionar la aplicación y rectificar los errores que se produzcan durante el proceso su creación. Los valores están formados por los separadores **Detalles de aplicación**, **Servidor**, **Plugins** y **Reparar proyecto**. 

### Interfaz de Digital App Builder en modalidad de Código 

![Interfaz DAB en modalidad de Código](dab-workbench-elements-codemode.png)

La interfaz de Digital App Builder en modalidad de Código consta de los siguientes elementos en el panel de navegación izquierdo: 

* **Entorno de trabajo** - visualiza u oculta los archivos 
* **Watson** - consta de los componentes Image Recognition y Chatbot (Watson Assistant) para configurar una instancia existente o crear una nueva instancia.  
* **Compromiso** - puede aumentar la involucración del usuario con la aplicación añadiendo servicios de notificación push y utilizar la característica Live Update para mostrar/ocultar controles y páginas o para cambiar sus propiedades cuando la aplicación esté activa.
* **API** - ayuda a simular el servidor proporcionando simplemente un dato JSON durante el desarrollo. 
* **Consola** - muestra la consola para ver las actividades.  
* **Parámetros** - muestra los detalles de la aplicación, la información del servidor, los plugins y la reparación del proyecto (como, por ejemplo, Reconstrucción de dependencias, Reconstrucción de plataformas y Restablecimiento de credenciales de IBM Cloud), habilitar o inhabilitar análisis.

#### Entorno de trabajo (modalidad de Código) 
{: #workbench }

El entorno de trabajo le ayuda a diseñar las páginas. El entorno de trabajo consta de dos áreas de trabajo:

1. **Archivos de proyecto**: Esta área muestra la lista de archivos asociados a esta aplicación creada de forma predeterminada. Utilice el signo **+** para crear una nueva página. Cuando se pulsa el icono **Controles** (**</>**), se muestra el panel **Fragmentos de código**. Puede arrastrar y soltar estos fragmentos de código y modificar las propiedades de cada uno de los controles seleccionados. 

#### Fragmentos de código (solo modalidad de Código) 
{: #code-snippets}

Algunos de los fragmentos de códigos están predefinidos y se pueden añadir a los archivos de origen con una simple acción de arrastrar y soltar desde la sección Fragmentos de códigos. Esta sección consta de fragmentos de código en las categorías siguientes: 

* **Mobile Core** - Fragmentos de código para realizar operaciones básicas con IBM Mobile Foundation Server
* **Analytics** - Fragmentos de código para análisis personalizados y comentarios del usuario. 
* **Ionic** - Fragmentos de código para componentes Ionic simples. 
* **Push** - Fragmentos de código para trabajar con notificaciones push. 
* **Live Update** - Fragmentos de código para trabajar con el conmutador de características de Live Update. 

