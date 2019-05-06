---
layout: tutorial
title: Interfaz de Digital App Builder
weight: 4
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #digital-app-builder-interface }


![Interfaz de DAB](dab-workbench-elements.png)

La interfaz de Digital App Builder está formada por los siguientes elementos en el panel de navegación izquierdo: 

* **Entorno de trabajo** - visualiza u oculta los detalles de la página
* **Datos** - ayudan a añadir un conjunto de datos conectándose a un origen de datos existente o creando un origen de datos para un microservicio utilizando el documento de OpenAPI.  
* **Watson** - consta de los componentes Image Recognition y Chatbot (Watson Assistant) para configurar una instancia existente o crear una nueva instancia.  
* **Compromiso** - incremente la involucración del usuario con la aplicación añadiendo servicios de notificación push 
* **Consola** - muestra la consola para ver las actividades y el código para cada componente.  
* **Parámetros** - muestra los detalles de la aplicación, la información del servidor, los plugins y la reparación del proyecto (como, por ejemplo, Reconstrucción de dependencias, Reconstrucción de plataformas y Restablecimiento de credenciales de IBM Cloud).

### Entorno de trabajo 
{: #workbench }

El entorno de trabajo le ayuda a diseñar las páginas. El entorno de trabajo consta de tres áreas de trabajo:

![Entorno de trabajo](dab-workbench.png)

1. **Páginas/Controles**: Esta área muestra el nombre de las páginas creadas de forma predeterminada. Utilice el signo **+** para crear una nueva página. Al pulsar el icono **Controles**, se visualizan los controles que ayudan a añadir funcionalidades a una página de una aplicación. Puede arrastrar y soltar los controles desde la respectiva paleta de controles al lienzo de la página. Cada control tiene un conjunto de propiedades y acciones.

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


    * **Inicio de sesión** - El inicio de sesión está formado por el control **Formulario de inicio de sesión**. Arrastre y suelte el formulario de inicio de sesión en la página.
 
        El control de formulario de inicio de sesión le ayuda a crear una página de inicio de sesión para la aplicación para conectar el usuario al servidor de Mobile Foundation. El servidor de Mobile Foundation proporciona una infraestructura de seguridad para autenticar a los usuarios y proporcionar este contexto de seguridad para acceder a los conjuntos de datos. Para obtener más información lea [aquí](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/authentication-and-security/creating-a-security-check/). 

        ![Formulario de inicio de sesión](dab-workbench-login-control.png)

        Para habilitar el formulario de inicio de sesión, siga los pasos siguientes:

        1. Realice los siguientes cambios en Mobile Foundation Server
            * Despliegue un adaptador de comprobación de seguridad que tomará el nombre de usuario y la contraseña como entrada. Puede utilizar el adaptador de ejemplo de [aquí](https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80).
            * En mfpconsole, vaya al separador de seguridad de la aplicación y bajo el ámbito de aplicación obligatorio, añada la definición de seguridad creada anteriormente como elemento de ámbito.
        2. Realice la configuración siguiente en la aplicación utilizando el constructor.
            * Añada el control **Formulario de inicio de sesión** a una página en el lienzo. 
            * En el separador **Propiedades**, proporcione el **Nombre de comprobación de seguridad** y la página a la que ir **Al iniciar sesión con éxito**.
            * Ejecute la aplicación. 
    * **IA** - IA controla la adición de funcionalidades de inteligencia artificial de Watson para su aplicación. 

        * **Chat de Watson** - Este control proporciona una interfaz de conversación completa que se puede respaldar con el servicio de Watson Assistant en IBM Cloud.  

            ![Watson Assistant](dab-workbench-ai-watson-chat.png)

            * En la sección de propiedades, seleccione el servicio de Watson Assistant configurado y seleccione el espacio de trabajo al que desea conectarse. Para definir y entrenar una conversación de Chat, consulte [Chatbot](#chatbot) bajo Watson.

        * **Watson Visual Recognition** - Este control proporciona la posibilidad de tomar una foto y hacer que Watson Visual Recognition la identifique. 
         
            ![Watson Visual Recognition](dab-workbench-ai-watson-vr.png)
 
            *  En la sección de propiedades, seleccione el servicio Visual Recognition configurado y el modelo de clasificación. Para definir y entrenar utilizando sus propias imágenes, consulte [Reconocimiento de imágenes](#image-recognition) bajo Watson.

2. Sección del **lienzo** - Esta área está formada por el Canal actual seleccionado, el nombre de Página actual, el conmutador Diseño/Código y el Lienzo.  

    * Icono **Canal** - Visualiza el canal actualmente seleccionado. Se pueden añadir canales adicionales seleccionando los canales necesarios en la sección Plataformas bajo **Parámetros > Aplicación > Detalles de aplicación**. 
    * Nombre de página actual - Muestra el nombre de página del lienzo. Cuando se conmuta entre páginas, el nombre de la página actual se actualiza con la página seleccionada. 
    * **Diseño / Código** - Esta opción establece la vista del editor de código para editar el código y habilita para ver de nuevo el diseño y para depurar errores. En el lienzo, cambie de Diseño a Código, para ver el código del archivo específico en el editor de proyectos. Al conmutar de Diseño a Código visualizará el siguiente mensaje emergente: 

        ![Alerta de conmutador Diseño - Código](dab-design-code-editor.png)

        **AVISO** - Cuando pulsa **Crear**, se crea de forma local una versión editable de la aplicación. Cualquier cambio realizado en la versión editable no se verá reflejado en la aplicación original y viceversa. Esta acción mostrará el explorador de proyectos con todos los archivos de proyecto para la aplicación. 

    * **Lienzo** - En el centro de esta sección se encuentra el lienzo, que muestra el diseño o el código. Arrastre y suelte los controles para crear la aplicación.

3. Separador **Propiedades/Acciones** - En el lado derecho se encuentra el separador de propiedades y acciones. Cuando se coloca un control en el lienzo, puede editar y modificar las propiedades del control y conectarlo con una acción relacionada para que la ejecute. 

### Datos
{: #dataset-integration}

La creación de un conjunto de datos para un microservicio implica los pasos siguientes. Después de crear el conjunto de datos, puede conectar los controles de enlace de datos en su aplicación. 

#### Creación de un nuevo conjunto de datos 

1. Desde la página de destino de Digital App Builder, abra cualquier aplicación existente o cree una.
2. Pulse **Datos** en el panel de la izquierda.

    ![Datos](dab-list-menu.png)

3. Pulse **Añadir nuevo conjunto de datos**. Esta acción visualiza la ventana Añadir un conjunto de datos. 

    ![Añadir nuevo conjunto de datos](dab-list-add-data-set.png)

4. Cree un conjunto de datos. Puede crearlo a partir de un origen existente (predeterminado) o crear un origen de datos para un microservicio utilizando un documento OpenAPI. 
    * **Crear a partir de un origen de datos existente** (predeterminado) - Esto cumplimentará el desplegable con todos los orígenes de datos (adaptadores) de la instancia configurada del servidor de Mobile Foundation.  
    * **Crear un origen de datos para un microservicio utilizando un documento de OpenAPI** - Esta opción permite crear un origen de datos a partir de un archivo de documento de especificación de Open API (Swagger json/yml) y un conjunto de datos a partir de la misma. 

#### Creación de un conjunto de datos a partir de un origen de datos existente

1. Seleccione el origen de datos para el que desea crear el conjunto de datos.
2. Esto cumplimentará las entidades disponibles en el origen de datos. Seleccione la entidad que se va a crear.
3. Déle un nombre al conjunto de datos y pulse el botón **Añadir**. Esta acción añadirá el conjunto de datos para que pueda ver los atributos y las acciones asociadas con dicho conjunto de datos. 

    ![Nuevo conjunto de datos con atributos](dab-list-dataset-attributes.png)

4. Puede ocultar algunos de los atributos y acciones en función de lo que desea hacer con el conjunto de datos.
5. También puede editar las **Etiquetas de visualización** para los atributos
6. También puede probar cualquiera de las acciones GET proporcionando los atributos necesarios y pulsando en **Ejecutar esta acción**, que forma parte de la acción. Recuerde que para esto funcione debe haber especificado el nombre de cliente confidencial y la contraseña en el separador **Valores**. 

#### Creación de un origen de datos para un microservicio utilizando un archivo swagger

1. Seleccione el archivo **json/yml** para el que desea crear un origen de datos y pulse **Generar**. 
2. Esto generará un adaptador, que es un artefacto de configuración en el servidor MF que puede volver a utilizar y desplegarlo en la instancia de servidor de Mobile Foundation.
3. Seleccione la entidad para la que desea definir el origen de datos. 
4. Déle un nombre al conjunto de datos y pulse el botón **Añadir**. 
5. Esta acción añadirá el conjunto de datos para que pueda ver los atributos y las acciones asociadas con el conjunto de datos. 

Ahora puede enlazar este conjunto de datos con cualquiera de los controles de enlace de datos.

### Watson
{: #integrating-with-watson-services}

Digital App Builder proporciona la posibilidad de configurar la aplicación para conectarla a los distintos servicios de Watson proporcionados en IBM Cloud.

#### Chatbot
{: #chatbot }

Los chatbots están basados en el servicio de Watson Assistant en IBM Cloud. Cree una instancia de Watson Assistant en IBM Cloud. Para obtener más información, consulte [aquí](https://cloud.ibm.com/catalog/services/watson-assistant-formerly-conversation).

Una vez configurado, puede crear un nuevo **Espacio de trabajo**. El espacio de trabajo es un conjunto de conversaciones que forman el chatbot. Después de crear un espacio de trabajo, inicie la creación de los diálogos. Proporcione un conjunto de preguntas para una intención y un conjunto de respuestas de dicha intención. Watson Assistant utiliza Natural Language Understand para interpretar la intención en base a las preguntas de ejemplo que ha proporcionado. Puede entonces intentar interpretar la pregunta que el usuario realiza en distintos estilos y correlacionarla con la intención. 

Para habilitar una chatbot en la aplicación, realice los pasos siguientes:

1. Pulse **Watson** y, a continuación, pulse **Chatbot**. Se visualizará la pantalla **Trabajar con Watson Assistant**. 

    ![Chatbot de Watson](dab-watson-chat.png)

2. Pulse **Conectar** a su instancia de Watson Assistance. 

    ![Instancia de chat de Watson](dab-watson-chat-instance.png)

3. Especifique los detalles de la **clave de API** y especifique el **URL** de su instancia de Watson Assistance.  
4. Proporcione un **Nombre** al chatbot y pulse **Conectar**. Visualizará el panel de control del servicio del **Nombre** dado. 

    ![Espacio de trabajo del chatbot de Watson](dab-watson-chat-workspace.png)

5. Añada un espacio de trabajo pulsando **Añadir un espacio de trabajo** que muestra la ventana emergente **Crear un modelo nuevo**. 

    ![Nuevo modelo de espacio de trabajo del chatbot de Watson](dab-watson-chat-new-model.png)

6. Especifique el **Nombre de espacio de trabajo** y la **Descripción del espacio de trabajo** y pulse **Crear**. Esto crea tres espacios de trabajo de **Conversación** (Bienvenido, No se ha encontrado ninguna coincidencia y Nueva conversación).

    ![Conversación predeterminada del chatbot de Watson](dab-watson-chat-conversations.png)

7. Pulse **Nueva conversación** para educar el nuevo modelo de chatbot. 

    ![Respuestas y preguntas del chatbot de Watson](dab-watson-chat-questions.png)

8. Añada preguntas y sus respuestas como un archivo csv o como preguntas y respuestas individuales. Por ejemplo, **Añadir una sentencia de usuario** para Si el usuario tiene la intención de preguntar, y a continuación **Añadir una respuesta de bot** para **Entonces, el bot debería responder con**. También puede subir preguntas y las respuestas para que responda el bot. 
9. Pulse **Guardar**.
10. Pulse el icono de Chatbot en la parte derecha del botón para probar el chatbot. 

    ![Realización de pruebas con el chatbot](dab-watson-chat-testing.png)

#### Reconocimiento de imágenes 
{: #image-recognition }

La funcionalidad de reconocimiento de imágenes viene respaldada por el servicio de reconocimiento Watson Visual en IBM Cloud. 
Cree una instancia de Watson Visual Recognition en IBM Cloud. Para obtener más información, consulte [aquí](https://cloud.ibm.com/catalog/services/visual-recognition).

Una vez configurado, podrá crear un nuevo modelo y añadirle clases. Puede arrastrar y soltar imágenes en el constructor y, a continuación, entrenar el modelo con dichas imágenes. Una vez que se haya completado el entrenamiento, puede descargar el modelo CoreML o utilizar el modelo en un control de IA en su aplicación.

Para habilitar reconocimiento visual en la aplicación, realice los pasos siguientes:

1. Pulse **Watson** y, a continuación, pulse **Reconocimiento de imagen**. Se visualizará la pantalla **Trabajar con Watson Visual Recognition**. 

    ![Watson Visual Recognition](dab-watson-vr.png)

2. Pulse **Conectar** a su instancia de Watson Visual Recognition. 

    ![Instancia de Watson Visual Recognition](dab-watson-vr-instance.png)

3. Especifique los detalles de la **clave de API** y especifique el **URL** de su instancia de Watson Visual Recognition.  
4. Proporcione un **Nombre** a su instancia de reconocimiento de imagen y pulse **Conectar**. Visualizará el panel de control para su modelo. 

    ![Nuevo modelo de Watson VR](dab-watson-vr-new-model.png)

5. Pulse **Añadir nuevo modelo** para crear un nuevo modelo. Esto mostrará la ventana emergente **Crear un nuevo modelo**. 

    ![Nombre de modelo de Watson VR](dab-watson-vr-model-name.png)

6. Especifique el **Nombre de modelo** y pulse **Crear**. Esta acción mostrará las clases para dicho modelo y una clase **Negativa**. 

    ![Clases del modelo de Watson VR](dab-watson-vr-model-class.png)

7. Pulse **Añadir nueva clase**. Esta acción mostrará una ventana emergente para especificar un nombre para la nueva clase. 

    ![Nombre de clase de modelo de Watson VR](dab-watson-vr-model-class-name.png)

8. Especifique el **Nombre de clase** para la nueva clase y pulse **Crear**. Esto mostrará el espacio de trabajo para añadir las imágenes para entrenar el modelo. 

    ![Entrenamiento de clase de modelo de Watson VR](dab-watson-vr-model-class-train.png)

9. Añada las imágenes al modelo arrastrándolas y soltándolas en el espacio de trabajo o bien utilice Examinar para acceder a las imágenes. 

10. Puede volver a su espacio de trabajo después de añadir las imágenes y probarlas pulsando **Probar modelo**.

    ![Probar clase del modelo de Watson VR](dab-watson-vr-model-class-train-test.png)

11. En la sección **Pruebe el modelo**, añada una imagen y, a continuación, se mostrará el resultado. 


### Compromiso
{: #engagement}

Puede añadir notificaciones push a la aplicación y aumentar el compromiso de los usuarios. 

Para añadir notificaciones push a la aplicación:

1. Seleccione **Compromiso**. Esto mostrará la lista de servicios disponibles. Actualmente, sólo están disponibles los servicios de notificaciones push. 

    ![Push de compromiso](dab-engagement-push.png)

2. En **Notificaciones Push** pulse **Conectar**. Se visualizará el diálogo **Conectarse a la instancia de notificaciones push**. 

    ![Instancia de notificaciones push de compromiso](dab-engagement-push-instance.png)

3. Especifique **Nombre**, **Clave de API**, **GUID de la aplicación**, **Clave de secreto de cliente**, seleccione **Región** y pulse **Conectar**. 
4. El nombre especificado más arriba se añade a la página bajo Compromiso. 
5. Configure la notificación push para Android proporcionando la **Clave de secreto de API** y el **ID de remitente** y pulse **Guardar configuración**. 

    ![Configuración de notificación push de compromiso de Android](dab-engagement-push-android-configure.png)

6. Navegue al separador de iOS y proporcione detalles de configuración de push: seleccione el **Entorno**, proporcione el archivo .p12 con la vía de acceso y especifique la **Contraseña** y pulse **Guardar configuración**. 

    ![Configuración de notificación push de compromiso de iOS](dab-engagement-push-ios-configure.png)

7.  
    a. Para Android, copie `google-services.json` (descargado de su proyecto firebase) en la carpeta `<path_to_app>/ionic/platforms/android/app`. 
    b. Para iOS, abra el proyecto xcode `<path_to_app>/ionic/platforms/ios/<app>.xcodeproj` y habilite la funcionalidad de notificación push. Para obtener más detalles, consulte [https://help.apple.com/xcode/mac/current/#/devdfd3d04a1](https://help.apple.com/xcode/mac/current/#/devdfd3d04a1).


### Consola
{: #console }

Ayuda a visualizar el código de cada uno de los componentes. También muestra la información sobre diversas actividades y errores.

### Parámetros
{: #settings}

Los parámetros sirven para gestionar la aplicación y rectificar los errores que se produzcan durante el proceso su creación. Los valores están formados por los separadores **Detalles de aplicación**, **Servidor**, **Plugins** y **Reparar proyecto**. 

#### Detalles de aplicación 
{: #app-details}

Los detalles de la aplicación muestran información sobre la aplicación: **Icono de aplicación**, **Nombre**, **Ubicación** donde se almacenan los archivos, **ID de proyecto/paquete** proporcionado al crear la aplicación, **Plataformas** (canales) seleccionados, **Servicio** habilitado. 

![Detalles de valores de aplicación](dab-settings-app-details.png)

Puede cambiar el **Icono de aplicación** pulsando el icono y subiendo un icono nuevo.

Puede añadir/eliminar plataformas adicionales seleccionado/deseleccionando el recuadro de selección junto a cada una de las mismas. 

Pulse **Guardar** para actualizar los cambios.

#### Servidor
{: #server }

La información del servidor muestra los **Detalles del servidor** en los que está trabajando actualmente. Puede editar la información pulsando el enlace **Editar**. Puede añadir o modificar la autorización de cliente confidencial.

![Detalles de los valores de servidor](dab-settings-server.png)

El separador Servidor también muestra **Servidores recientes**.

También puede añadir un nuevo servidor pulsando el botón **Conectar nuevo +** y proporcionando los detalles en la ventana emergente **Conectar a un nuevo servidor** y pulsando **Conectar**. 

![Valores de nuevo servidor](dab-settings-server-new-server.png)

#### Plugins
{: #plugins}

Plugins muestra la lista de plugins disponibles en Digital App Builder. Se pueden realizar las siguientes acciones:

![Valores de plugins disponibles](dab-settings-plugins.png)

* **Instalar nuevo** - Instale nuevos plugins pulsando este botón. Esto visualiza el diálogo **Nuevo plugin**. Especifique **Nombre de plugin**, **Versión** (opcional), y si se trata de un **plugin local**, habilite el conmutador para el mismo y apunte a la ubicación y pulse **Instalar**. 

![Valores de nuevos plugins](dab-settings-new-plugins.png)

* Desde la lista de plugins ya instalados, puede editar la versión y volver a instalar el plugin o desinstalar un plugin seleccionando el enlace para el respectivo plugin. 

#### Reparar proyecto 
{: #repair-project}

El separador Reparar proyecto ayuda a solucionar problemas pulsando las opciones respectivas. 

![Valores de reparar](dab-settings-repair.png)

* **Reconstruir dependencias** - Si el proyecto es inestable, puede intentar reconstruir las dependencias. 
* **Reconstruir plataformas** - Si ve en la consola errores relacionados con la plataforma, intente reconstruir las plataformas. Si ha realizado algún cambio en los canales o ha añadido canales adicionales, utilice esta opción. 
* **Restablecer las credenciales de IBM Cloud para el servidor de Playground** - Puede restablecer las credenciales de IBM Cloud utilizas para iniciar una sesión en el servidor Playground. Si restablece el caché de credenciales, también borrará todas sus aplicaciones en el servidor de Playground. **ESTA OPERACIÓN NO SE PUEDE REVERTIR.**

 
