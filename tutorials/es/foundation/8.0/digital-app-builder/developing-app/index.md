---
layout: tutorial
title: Desarrollo de una aplicación
weight: 5
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #developing-an-app }

El desarrollo de una aplicación incluye los pasos siguientes:

1. Cree una aplicación. Consulte la sección [Creación de una aplicación](../getting-started/). 
2. Diseñe su aplicación añadiendo los controles necesarios. Para obtener más información, consulte [Interfaz de Digital App Builder](../dab-interface/). 
3. Añada los servicios que necesita (Chat de Watson, Watson Visual Recognition, Notificaciones push, Conjunto de datos) a la aplicación. 
4. Añada o modifique plataformas, si es necesario. Consulte la sección [Valores > Detalles de aplicación](../settings/). 
5. Obtenga una vista previa de la aplicación. Consulte [Vista previa de la aplicación utilizando el simulador](#preview-the-app-using-the-simulator). 
6. Después de obtener una vista previa de la aplicación, y si está lista para ser creada después de rectificar los errores, realice los pasos siguientes para crear la aplicación: 

    * **Para aplicaciones Android: **

        a. Vaya al directorio, que especificó al crear la aplicación. 

        b. Vaya a la carpeta ionic. 

        c. Vaya a **Plataforma > Android**.

        d. Abra Android Studio y luego vaya a **Archivo > Abrir proyecto** > Elija la carpeta android mencionada en el paso c. 

        e. Construya el proyecto.  

        >**Nota**: Para la publicación y la creación, siga los pasos de la guía de aprendizaje [https://developer.android.com/studio/publish/](https://developer.android.com/studio/publish/).

    * **Para aplicaciones iOS**:
 
        a. Vaya al directorio, que especificó al crear la aplicación. 

        b. Vaya a la carpeta ionic. 

        c. Vaya a Plataforma > iOS.

        d. Abra **Xcode** y, a continuación, construya el proyecto.  

        >**Nota**: Para la publicación y la creación, siga los pasos de la guía de aprendizaje [https://developer.apple.com/ios/submit/](https://developer.apple.com/ios/submit/).


### Vista previa de la aplicación
{: #preview-the-app }

Puede obtener una vista previa de la aplicación desarrollada conectándose a la simulación para el canal seleccionado.

* Para obtener una vista previa de la aplicación en iOS, descargue e instale **XCode** desde el Apple App Store. 
* Para obtener una vista previa de la aplicación en Android, 
    * Instale Android Studio y siga las instrucciones. [https://developer.android.com/studio/](https://developer.android.com/studio/)
    * Configure una máquina virtual Android. Siga las instrucciones [aquí](https://developer.android.com/studio/releases/emulator).

>**Nota**: Para obtener rápidamente una vista previa de la aplicación, seleccione la opción Vista previa de aplicación y se abrirá una nueva ventana con la aplicación en ejecución. Puede establecerla en diferentes modelos de plataforma y también puede cambiar la orientación. Los cambios realizados en la aplicación se reflejarán dinámicamente en esta ventana de vista previa.

>**Nota**: Archivo > Exportar a código, exportará el proyecto a la modalidad de código. (Se guardará el código de la aplicación en una carpeta nueva, por lo que no creará problemas en la modalidad de diseño). Después de la exportación a la modalidad de diseño, no podrá abrir el proyecto exportado en la modalidad de diseño. 
